GetVariant: ; 51040
	ld a, [CurPartySpecies]
	cp PIKACHU
	jr z, .GetPikachuVariant
	cp MEWTWO
	jp z, .GetMewtwoVariant

; Return MonVariant based on Form at hl
	ld a, [hl]
	and FORM_MASK
	jr nz, .ok
	ld a, [CurPartySpecies]
	cp ARBOK
	jr nz, .not_kanto_arbok
	push bc
	push de
	farcall RegionCheck
	ld a, e
	pop de
	pop bc
	and a
	jr z, .not_kanto_arbok
.kanto_arbok
	ld a, ARBOK_KANTO_FORM
	jr .ok
.not_kanto_arbok
	ld a, 1 ; safeguard: form 0 becomes variant 1
.ok
	ld [MonVariant], a
	ret

.GetPikachuVariant:
; Return Pikachu form (1-5) in MonVariant
; hl-8 is ...MonMove1
; hl-7 is ...MonMove2
; hl-6 is ...MonMove3
; hl-5 is ...MonMove4
; hl is ...MonForm

	ld a, [hl]
	and FORM_MASK
	cp PIKACHU_RED_FORM
	jr nc, .use_form

	push bc
	ld bc, TempMonForm
	ld a, b
	cp h
	jr nz, .nottemp1
	ld a, c
	cp l
	jr nz, .nottemp1
	; skip TempMonID through TempMonSdfEV
	ld bc, -11
	add hl, bc
.nottemp1
	ld bc, -8
	add hl, bc
	pop bc

	ld a, PIKACHU_SURF_FORM
	ld [MonVariant], a
rept NUM_MOVES
	ld a, [hli]
	cp SURF
	ret z
endr

rept NUM_MOVES
	dec hl
endr
	ld a, PIKACHU_FLY_FORM
	ld [MonVariant], a
rept NUM_MOVES
	ld a, [hli]
	cp FLY
	ret z
endr

.plain
	ld a, PIKACHU_PLAIN_FORM
.use_form
	ld [MonVariant], a
	ret

.GetMewtwoVariant:
; Return Mewtwo form (1-2) in MonVariant
; hl-9 is ...MonItem
; hl is ...MonForm

	push bc
	ld bc, TempMonForm
	ld a, b
	cp h
	jr nz, .nottemp2
	ld a, c
	cp l
	jr nz, .nottemp2
	; skip TempMonID through TempMonSdfEV
	ld bc, -11
	add hl, bc
.nottemp2
	ld bc, -9
	add hl, bc
	pop bc

	ld a, [hl]
	cp ARMOR_SUIT
	ld a, MEWTWO_ARMORED_FORM
	jr z, .armored_mewtwo
	dec a ; MEWTWO_PLAIN_FORM
.armored_mewtwo
	ld [MonVariant], a
	ret

GetFrontpic: ; 51077
	ld a, [CurPartySpecies]
	ld [CurSpecies], a
	call IsAPokemon
	ret c
	ld a, [rSVBK]
	push af
	call _GetFrontpic
	pop af
	ld [rSVBK], a
	jp CloseSRAM

FrontpicPredef: ; 5108b
	ld a, [CurPartySpecies]
	ld [CurSpecies], a
	call IsAPokemon
	ret c
	ld a, [rSVBK]
	push af
	xor a
	ld [hBGMapMode], a
	call _GetFrontpic
	ld a, BANK(VTiles3)
	ld [rVBK], a
	call GetAnimatedFrontpic
	xor a
	ld [rVBK], a
	pop af
	ld [rSVBK], a
	jp CloseSRAM

_GetFrontpic: ; 510a5
	ld a, BANK(sScratch)
	call GetSRAMBank
	push de
	call GetBaseData
	ld a, [BasePicSize]
	and $f
	ld b, a
	push bc
	call GetFrontpicPointer
	ld a, BANK(wDecompressScratch)
	ld [rSVBK], a
	ld a, b
	ld de, wDecompressScratch
	call FarDecompress
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
	push hl
	ld de, sScratch + 1 tiles
	ld c, 7 * 7
	ld a, [hROMBank]
	ld b, a
	call Get2bpp
	pop hl
	ret

GetFrontpicPointer: ; 510d7
	ld a, [CurPartySpecies]
	call GetRelevantPicPointers
	ld a, [CurPartySpecies]
	jr nc, .notvariant
	ld a, [MonVariant]
.notvariant
	dec a
	ld bc, 6
	call AddNTimes
	ld a, d
	call GetFarByte
	push af
	inc hl
	ld a, d
	call GetFarHalfword
	pop bc
	ret

GetAnimatedFrontpic: ; 51103
	ld a, $1
	ld [rVBK], a
	push hl
	ld de, sScratch + 1 tiles
	ld c, 7 * 7
	ld a, [hROMBank]
	ld b, a
	call Get2bpp
	pop hl
	ld de, 7 * 7 tiles
	add hl, de
	push hl
	ld a, BANK(BasePicSize)
	ld hl, BasePicSize
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
	ld a, [hROMBank]
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
	ld hl, VTiles4
	ld a, [hROMBank]
	ld b, a
	ld a, [sScratch]
	ld c, a
.no_overflow
	jp Get2bpp

LoadFrontpicTiles: ; 5114f
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

GetBackpic: ; 5116c
	ld a, [CurPartySpecies]
	call IsAPokemon
	ret c

	ld a, [CurPartySpecies]
	ld b, a
	ld a, [MonVariant]
	ld c, a
	ld a, [rSVBK]
	push af
	ld a, $6
	ld [rSVBK], a
	push de
	ld a, b
	push bc
	call GetRelevantPicPointers
	pop bc
	ld a, b
	jr nc, .notvariant
	ld a, c
.notvariant
	dec a
	ld bc, 6
	call AddNTimes
	ld bc, 3
	add hl, bc
	ld a, d
	call GetFarByte
	push af
	inc hl
	ld a, d
	call GetFarHalfword
	ld de, wDecompressScratch
	pop af
	call FarDecompress
	ld hl, wDecompressScratch
	ld c, 6 * 6
	call FixBackpicAlignment
	pop hl
	ld de, wDecompressScratch
	ld a, [hROMBank]
	ld b, a
	call Get2bpp
	pop af
	ld [rSVBK], a
	ret

GetTrainerPic: ; 5120d
	ld a, [TrainerClass]
	and a
	ret z
	cp NUM_TRAINER_CLASSES
	ret nc
	call WaitBGMap
	xor a
	ld [hBGMapMode], a
	ld hl, TrainerPicPointers
	ld a, [TrainerClass]
	dec a
	ld bc, 3
	call AddNTimes
	ld a, [rSVBK]
	push af
	ld a, $6
	ld [rSVBK], a
	push de
	ld a, BANK(TrainerPicPointers)
	call GetFarByte
	push af
	inc hl
	ld a, BANK(TrainerPicPointers)
	call GetFarHalfword
	pop af
_Decompress7x7Pic:
	ld de, wDecompressScratch
	call FarDecompress
	pop hl
	ld de, wDecompressScratch
	ld c, 7 * 7
	ld a, [hROMBank]
	ld b, a
	call Get2bpp
	pop af
	ld [rSVBK], a
	call WaitBGMap
	ld a, $1
	ld [hBGMapMode], a
	ret

GetPaintingPic:
	ld a, [TrainerClass]
	call WaitBGMap
	xor a
	ld [hBGMapMode], a
	ld hl, PaintingPicPointers
	ld a, [TrainerClass]
	ld bc, 3
	call AddNTimes
	ld a, [rSVBK]
	push af
	ld a, $6
	ld [rSVBK], a
	push de
	ld a, BANK(PaintingPicPointers)
	call GetFarByte
	push af
	inc hl
	ld a, BANK(PaintingPicPointers)
	call GetFarHalfword
	pop af
	jr _Decompress7x7Pic

DecompressPredef: ; 5125d
; Decompress lz data from b:hl to scratch space at 6:d000, then copy it to address de.

	ld a, [rSVBK]
	push af
	ld a, 6
	ld [rSVBK], a

	push de
	push bc
	ld a, b
	ld de, wDecompressScratch
	call FarDecompress
	pop bc
	ld de, wDecompressScratch
	pop hl
	ld a, [hROMBank]
	ld b, a
	call Get2bpp

	pop af
	ld [rSVBK], a
	ret

FixBackpicAlignment: ; 5127c
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
	lb bc, $0, $8
.loop
	rra
	rl b
	dec c
	jr nz, .loop
	ld a, b
	ld [hli], a
	dec de
	ld a, e
	or d
	jr nz, .got_dims

.keep_dims
	pop bc
	pop de
	ret

PadFrontpic: ; 512ab
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
	xor a
	call .Fill
.six_loop
	ld c, 1 tiles
	xor a
	call .Fill
	ld c, 6 tiles
	call LoadFrontpic
	dec b
	jr nz, .six_loop
	ret

.five
	ld c, 7 tiles
	xor a
	call .Fill
.five_loop
	ld c, 2 tiles
	xor a
	call .Fill
	ld c, 5 tiles
	call LoadFrontpic
	dec b
	jr nz, .five_loop
	ld c, 7 tiles
	xor a
	; fallthrough

.Fill:
	ld [hli], a
	dec c
	jr nz, .Fill
	ret

LoadFrontpic: ; 512f2
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
	ld b, a
	xor a
	rept 8
	rr b
	rla
	endr
	ld [hli], a
	dec c
	jr nz, .right_loop
	pop bc
	ret

GetRelevantPicPointers:
; given species in a, return *PicPointers in hl and BANK(*PicPointers) in d
; returns c for variants, nc for normal species
	ld hl, VariantPicPointerTable
	ld de, 4
	call IsInArray
	inc hl
	ld a, [hli]
	ld d, a
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ret

INCLUDE "data/pokemon/variant_pic_pointer_table.asm"
