GetVariant: ; 51040
	ld a, [CurPartySpecies]
	cp PIKACHU
	jp z, .GetPikachuVariant
	cp MEWTWO
	jp z, .GetMewtwoVariant

; Return MonVariant based on Form at hl
; Unown: 1-26, Pichu: 1-2, Arbok: 1-2
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
	ld a, 2 ; arbok with form 0 in kanto becomes variant 2
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
	jr nz, .use_form

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

	ld a, 3 ; Surf
	ld [MonVariant], a
rept 4
	ld a, [hli]
	cp SURF
	ret z
endr

rept 4
	dec hl
endr
	ld a, 2 ; Fly
	ld [MonVariant], a
rept 4
	ld a, [hli]
	cp FLY
	ret z
endr

.plain
	ld a, 1 ; plain
	ld [MonVariant], a
	ret

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
	jr z, .armored_mewtwo
	ld a, 1 ; plain
	ld [MonVariant], a
	ret

.armored_mewtwo
	ld a, 2 ; armored
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
	ret

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
	call GetAnimatedFrontpic
	pop af
	ld [rSVBK], a
	ret

_GetFrontpic: ; 510a5
	push de
	call GetBaseData
	ld a, [BasePicSize]
	and $f
	ld b, a
	push bc
	call GetFrontpicPointer
	ld a, $6
	ld [rSVBK], a
	ld a, b
	ld de, wDecompressScratch + $800
	call FarDecompress
	pop bc
	ld hl, wDecompressScratch
	ld de, wDecompressScratch + $800
	call PadFrontpic
	pop hl
	push hl
	ld de, wDecompressScratch
	ld c, 7 * 7
	ld a, [hROMBank]
	ld b, a
	call Get2bpp
	pop hl
	ret

GetFrontpicPointer: ; 510d7
GLOBAL PicPointers, PikachuPicPointers, PichuPicPointers, ArbokPicPointers, UnownPicPointers, MewtwoPicPointers

	ld a, [CurPartySpecies]
	cp PIKACHU
	jr z, .pikachu
	cp PICHU
	jr z, .pichu
	cp ARBOK
	jr z, .arbok
	cp UNOWN
	jr z, .unown
	cp MEWTWO
	jr z, .mewtwo
	ld a, [CurPartySpecies]
	ld d, BANK(PicPointers)
	ld hl, PicPointers
	jr .ok

.pikachu
	ld a, [MonVariant]
	ld d, BANK(PikachuPicPointers)
	ld hl, PikachuPicPointers
	jr .ok

.pichu
	ld a, [MonVariant]
	ld d, BANK(PichuPicPointers)
	ld hl, PichuPicPointers
	jr .ok

.arbok
	ld a, [MonVariant]
	ld d, BANK(ArbokPicPointers)
	ld hl, ArbokPicPointers
	jr .ok

.unown
	ld a, [MonVariant]
	ld d, BANK(UnownPicPointers)
	ld hl, UnownPicPointers
	jr .ok

.mewtwo
	ld a, [MonVariant]
	ld d, BANK(MewtwoPicPointers)
	ld hl, MewtwoPicPointers

.ok
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
	ld de, wDecompressScratch
	ld c, 7 * 7
	ld a, [hROMBank]
	ld b, a
	call Get2bpp
	pop hl
	ld de, 7 * 7 tiles
	add hl, de
	push hl
	ld a, $1
	ld hl, BasePicSize
	call GetFarWRAMByte
	pop hl
	and $f
	ld de, w6_d800 + 5 * 5 tiles
	ld c, 5 * 5
	cp 5
	jr z, .got_dims
	ld de, w6_d800 + 6 * 6 tiles
	ld c, 6 * 6
	cp 6
	jr z, .got_dims
	ld de, w6_d800 + 7 * 7 tiles

	push hl
	ld a, [CurSpecies]
	ld c, a
	ld hl, .LargeSpriteSizes
.loop
	ld a, [hli]
	cp c
	jr z, .found
	cp -1
	jr z, .found
	inc hl
	jr .loop
.found
	ld a, [hl]
	ld c, a
	pop hl

.got_dims
	push hl
	push bc
	call LoadOrientedFrontpicTiles
	pop bc
	pop hl

;	ld a, c
;	cp $80 - 7 * 7 + 1
;	jr c, .no_overflow
;	ld de, wDecompressScratch
;	ld a, [hROMBank]
;	ld b, a
;	push bc
;	call Get2bpp
;	pop bc
;	ld a, BANK(VTiles4)
;	ld [rVBK], a
;	ld de, w6_d800 + $80 tiles
;	ld hl, VTiles4
;	ld a, [hROMBank]
;	ld b, a
;	ld a, c
;	sub $80 - 7 * 7
;	ld c, a
;	call Get2bpp
;	jr .finish

.no_overflow
	ld de, wDecompressScratch
	ld a, [hROMBank]
	ld b, a
	call Get2bpp

.finish
	xor a
	ld [rVBK], a
	ret

.LargeSpriteSizes:
; species, max tile - size + 1
	db GLACEON,    $64 - 7 * 7 + 1
	db MAMOSWINE,  $6f - 7 * 7 + 1
	db PORYGON_Z,  $6f - 7 * 7 + 1
	db SYLVEON,    $71 - 7 * 7 + 1 ; TODO
	db MISMAGIUS,  $71 - 7 * 7 + 1
	db ELECTIVIRE, $76 - 7 * 7 + 1
	db WEAVILE,    $80 - 7 * 7 + 1 ; TODO
	db LEAFEON,    $81 - 7 * 7 + 1 ; TODO
	db GLISCOR,    $83 - 7 * 7 + 1 ; TODO
	db RHYPERIOR,  $85 - 7 * 7 + 1 ; TODO
	db TOGEKISS,   $88 - 7 * 7 + 1 ; TODO
	db MAGMORTAR,  $8b - 7 * 7 + 1 ; TODO
	db -1,         7 * 7

LoadOrientedFrontpicTiles: ; 5114f
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
; load the remaining bytes in batches of $100
.loop
	push bc
	ld c, $0
	call LoadFrontpic
	pop bc
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

GLOBAL PicPointers, PikachuPicPointers, PichuPicPointers, ArbokPicPointers, UnownPicPointers, MewtwoPicPointers
	ld hl, PicPointers
	ld a, b
	ld d, BANK(PicPointers)
	cp PIKACHU
	jr nz, .not_pikachu
	ld hl, PikachuPicPointers
	ld a, c
	ld d, BANK(PikachuPicPointers)
	jr .ok
.not_pikachu
	cp PICHU
	jr nz, .not_pichu
	ld hl, PichuPicPointers
	ld a, c
	ld d, BANK(PichuPicPointers)
	jr .ok
.not_pichu
	cp ARBOK
	jr nz, .not_arbok
	ld hl, ArbokPicPointers
	ld a, c
	ld d, BANK(ArbokPicPointers)
	jr .ok
.not_arbok
	cp UNOWN
	jr nz, .not_unown
	ld hl, UnownPicPointers
	ld a, c
	ld d, BANK(UnownPicPointers)
.not_unown
	cp MEWTWO
	jr nz, .ok
	ld hl, MewtwoPicPointers
	ld a, c
	ld d, BANK(MewtwoPicPointers)
.ok
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

Function511ec: ; 511ec
	ld a, c
	push de
	ld hl, PicPointers
	dec a
	ld bc, 6
	call AddNTimes
	ld a, BANK(PicPointers)
	call GetFarByte
	push af
	inc hl
	ld a, BANK(PicPointers)
	call GetFarHalfword
	pop af
	pop de
	call FarDecompress
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
	ld b, $0
	ld c, $8
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
	call .Fill
	ret

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
