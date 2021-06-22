GetVariant:
	ld a, [wCurPartySpecies]
	cp PIKACHU
	jr z, .GetPikachuVariant

; Return CurForm based on Form at hl
	ld a, [hl]
	and SPECIESFORM_MASK
	jr nz, .ok

	ld a, [wCurPartySpecies]
	cp ARBOK
	jr nz, .not_kanto_arbok
; NPC trainers should appear to have Kantonian Arbok without explicitly
; giving them all a personality, so form 0 becomes 1 (Johto) or 2 (Kanto)
	push bc
	push de
	call RegionCheck
	ld a, e
	pop de
	pop bc
	and a
	jr z, .not_kanto_arbok
.kanto_arbok
	ld a, ARBOK_KANTO_FORM
	jr .ok
.not_kanto_arbok
	ld a, PLAIN_FORM ; safeguard: form 0 becomes variant 1

.ok
	ld [wCurForm], a
	ret

.GetPikachuVariant:
; Return Pikachu form (1-5) in wCurForm
; hl-8 is ...MonMove1
; hl-7 is ...MonMove2
; hl-6 is ...MonMove3
; hl-5 is ...MonMove4
; hl is ...MonForm

	ld a, [hl]
	and SPECIESFORM_MASK
	cp PIKACHU_RED_FORM
	jr nc, .use_form

	push bc
	ld bc, MON_MOVES - MON_FORM
	add hl, bc
	pop bc

	ld a, PIKACHU_SURF_FORM
	ld [wCurForm], a
rept NUM_MOVES
	ld a, [hli]
	cp SURF
	ret z
endr

rept NUM_MOVES
	dec hl
endr
	ld a, PIKACHU_FLY_FORM
	ld [wCurForm], a
rept NUM_MOVES
	ld a, [hli]
	cp FLY
	ret z
endr

.plain
	ld a, PLAIN_FORM
.use_form
	ld [wCurForm], a
	ret

GetFrontpic:
	ld a, [wCurPartySpecies]
	ld [wCurSpecies], a
	and a
	ret z
	ldh a, [rSVBK]
	push af
	call _GetFrontpic
	pop af
	ldh [rSVBK], a
	jmp CloseSRAM

PrepareFrontpic:
	ld a, [wCurPartySpecies]
	ld [wCurSpecies], a
	and a
	ret z
	ldh a, [rSVBK]
	push af
	call _PrepareFrontpic
	pop af
	ldh [rSVBK], a
	jmp CloseSRAM

GetPreparedFrontpic:
	ld a, BANK(sScratch)
	call GetSRAMBank
	call _GetPreparedFrontpic
	jmp CloseSRAM

FrontpicPredef:
	ld a, [wCurPartySpecies]
	ld [wCurSpecies], a
	and a
	ret z
	ldh a, [rSVBK]
	push af
	xor a
	ldh [hBGMapMode], a
	call _GetFrontpic
	ld a, BANK(vTiles3)
	ldh [rVBK], a
	call GetAnimatedFrontpic
	xor a
	ldh [rVBK], a
	pop af
	ldh [rSVBK], a
	jmp CloseSRAM

_GetFrontpic:
	call _PrepareFrontpic
	; fallthrough
_GetPreparedFrontpic:
	push hl
	ld de, sScratch + 1 tiles
	ld c, 7 * 7
	ldh a, [hROMBank]
	ld b, a
	call Get2bpp
	pop hl
	ret

_PrepareFrontpic:
	ld a, BANK(sScratch)
	call GetSRAMBank
	push de
	call GetBaseData ; [wCurSpecies] and [wCurForm] are already set
	ld a, [wBasePicSize]
	and $f
	ld b, a
	push bc
	call GetFrontpicPointer
	ld a, BANK(wDecompressScratch)
	ldh [rSVBK], a
	call FarDecompressInB
	; Save decompressed size
	swap e
	swap d
	ld a, d
	and $f0
	or e
	ld [sScratch], a
	pop bc
	ld hl, sScratch + 1 tiles
	ld de, wDecompressScratch
	call PadFrontpic
	pop hl
	ret

GetFrontpicPointer:
	; c = species
	ld a, [wCurPartySpecies]
	ld c, a
	; b = form
	ld a, [wCurForm]
	ld b, a
	; bc = index
	call GetCosmeticSpeciesAndFormIndex
	dec bc
	ld hl, FrontPicPointers
rept 3
	add hl, bc
endr
	ld a, BANK(FrontPicPointers)
	call GetFarByte
	push af
	inc hl
	ld a, BANK(FrontPicPointers)
	call GetFarWord
	pop bc
	ret

GetAnimatedFrontpic:
	ld a, $1
	ldh [rVBK], a
	push hl
	ld de, sScratch + 1 tiles
	ld c, 7 * 7
	ldh a, [hROMBank]
	ld b, a
	call Get2bpp
	pop hl
	ld de, 7 * 7 tiles
	add hl, de
	push hl
	ld a, BANK(wBasePicSize)
	ld hl, wBasePicSize
	call GetFarWRAMByte
	pop hl
	and $f
	ld de, wDecompressScratch + 5 * 5 tiles
	ld c, 5 * 5
	cp 5
	jr z, .got_dims
	ld de, wDecompressScratch + 6 * 6 tiles
	ld c, 6 * 6
	cp 6
	jr z, .got_dims
	ld de, wDecompressScratch + 7 * 7 tiles
.got_dims
	; Get animation size (total - base sprite size)
	ld a, [sScratch]
	sub c
	ret z ; Return if there's no animation
	ld c, a
	push hl
	push bc
	call LoadFrontpicTiles
	pop bc
	pop hl
	ld de, wDecompressScratch
	ldh a, [hROMBank]
	ld b, a
; Improved routine by pfero
; https://gitgud.io/pfero/axyllagame/commit/486f4ed432ca49e5d1305b6402cc5540fe9d3aaa
	; If we can load it in a single pass, just do it
	ld a, c
	sub (128 - 7 * 7)
	jr c, .no_overflow
	; Otherwise, we load the first part...
	inc a
	ld [sScratch], a
	ld c, (127 - 7 * 7)
	call Get2bpp
	; Then move up a bit and load the rest
	ld de, wDecompressScratch + (127 - 7 * 7) tiles
	ld hl, vTiles4
	ldh a, [hROMBank]
	ld b, a
	ld a, [sScratch]
	ld c, a
.no_overflow
	jmp Get2bpp

LoadFrontpicTiles:
	ld hl, wDecompressScratch
; bc = c * $10
	swap c
	ld a, c
	and $f
	ld b, a
	ld a, c
	and $f0
	ld c, a
; load the first c bytes to round down bc to a multiple of $100
	push bc
	call LoadFrontpic
	pop bc
; don't access echo ram
	ld a, c
	and a
	jr z, .handle_loop
	inc b
	jr .handle_loop
; load the remaining bytes in batches of $100
.loop
	push bc
	ld c, $0
	call LoadFrontpic
	pop bc
.handle_loop
	dec b
	jr nz, .loop
	ret

GetBackpic:
	ld a, [wCurPartySpecies]
	and a
	ret z
	; c = species
	ld a, [wCurPartySpecies]
	ld c, a
	; b = form
	ld a, [wCurForm]
	ld b, a
	ldh a, [rSVBK]
	push af
	ld a, $6
	ldh [rSVBK], a
	push de
	; bc = index
	call GetCosmeticSpeciesAndFormIndex
	dec bc
	ld hl, BackPicPointers
rept 3
	add hl, bc
endr
	ld a, BANK(BackPicPointers)
	call GetFarByte
	push af
	inc hl
	ld a, BANK(BackPicPointers)
	call GetFarWord
	pop af
	call FarDecompress
	ld hl, wDecompressScratch
	ld c, 6 * 6
	call FixBackpicAlignment
	pop hl
	ld de, wDecompressScratch
	ldh a, [hROMBank]
	ld b, a
	call Get2bpp
	pop af
	ldh [rSVBK], a
	ret

GetTrainerPic:
	ld a, [wTrainerClass]
	and a
	ret z
	cp NUM_TRAINER_CLASS_PICS + 1
	ret nc
	call ApplyTilemapInVBlank
	xor a
	ldh [hBGMapMode], a
	ld hl, TrainerPicPointers
	ld a, [wTrainerClass]
	dec a
	ld bc, 3
	rst AddNTimes
	ldh a, [rSVBK]
	push af
	ld a, $6
	ldh [rSVBK], a
	push de
	ld a, BANK(TrainerPicPointers)
	call GetFarByte
	push af
	inc hl
	ld a, BANK(TrainerPicPointers)
	call GetFarWord
	pop af
_Decompress7x7Pic:
	call FarDecompress
	pop hl
	ld de, wDecompressScratch
	ld c, 7 * 7
	ldh a, [hROMBank]
	ld b, a
	call Get2bpp
	pop af
	ldh [rSVBK], a
	call ApplyTilemapInVBlank
	ld a, $1
	ldh [hBGMapMode], a
	ret

GetPaintingPic:
	ld a, [wTrainerClass]
	call ApplyTilemapInVBlank
	xor a
	ldh [hBGMapMode], a
	ld hl, PaintingPicPointers
	ld a, [wTrainerClass]
	ld bc, 3
	rst AddNTimes
	ldh a, [rSVBK]
	push af
	ld a, $6
	ldh [rSVBK], a
	push de
	ld a, BANK(PaintingPicPointers)
	call GetFarByte
	push af
	inc hl
	ld a, BANK(PaintingPicPointers)
	call GetFarWord
	pop af
	jr _Decompress7x7Pic

FixBackpicAlignment:
	push de
	push bc
	ld a, [wBoxAlignment]
	and a
	jr z, .keep_dims
	ld a, c
	cp 7 * 7
	ld de, 7 * 7 tiles
	jr z, .got_dims
	cp 6 * 6
	ld de, 6 * 6 tiles
	jr z, .got_dims
	ld de, 5 * 5 tiles

.got_dims
	ld a, [hl]

; https://github.com/pret/pokecrystal/wiki/Optimizing-assembly-code#reverse-the-bits-of-a
	ld b, a
	rlca
	rlca
	xor b
	and $aa
	xor b
	ld b, a
	swap b
	xor b
	and $33
	xor b
	rrca

	ld [hli], a
	dec de
	ld a, e
	or d
	jr nz, .got_dims

.keep_dims
	pop bc
	pop de
	ret

PadFrontpic:
	ld a, b
	sub 5
	jr z, .five
	dec a
	jr z, .six

.seven_loop
	ld c, 7 tiles
	call LoadFrontpic
	dec b
	jr nz, .seven_loop
	ret

.six
	ld c, 7 tiles
	call .Fill
.six_loop
	ld c, 1 tiles
	call .Fill
	ld c, 6 tiles
	call LoadFrontpic
	dec b
	jr nz, .six_loop
	ret

.five
	ld c, 7 tiles
	call .Fill
.five_loop
	ld c, 2 tiles
	call .Fill
	ld c, 5 tiles
	call LoadFrontpic
	dec b
	jr nz, .five_loop
	ld c, 7 tiles
	; fallthrough

.Fill:
	xor a
.fill_loop
	ld [hli], a
	dec c
	jr nz, .fill_loop
	ret

LoadFrontpic:
	ld a, [wBoxAlignment]
	and a
	jr nz, .x_flip
.left_loop
	ld a, [de]
	inc de
	ld [hli], a
	dec c
	jr nz, .left_loop
	ret

.x_flip
	push bc
.right_loop
	ld a, [de]
	inc de

; https://github.com/pret/pokecrystal/wiki/Optimizing-assembly-code#reverse-the-bits-of-a
	ld b, a
	rlca
	rlca
	xor b
	and $aa
	xor b
	ld b, a
	swap b
	xor b
	and $33
	xor b
	rrca

	ld [hli], a
	dec c
	jr nz, .right_loop
	pop bc
	ret
