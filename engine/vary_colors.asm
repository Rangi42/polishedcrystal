CopyDVsToColorVaryDVs:
; e = HPAtkDV
	ld a, [hli]
	ld e, a
; d = DefSpdDV
	ld a, [hli]
	ld d, a
; c = SatSdfDV
	ld a, [hli]
	ld c, a
; b = Shiny
	push bc
	ld a, [hl]
	ld b, a

	ld a, [rSVBK]
	ld c, a
	ld a, $5
	ld [rSVBK], a

	ld hl, ColorVaryDVs
; ColorVaryDVs = HPAtkDV
	ld a, e
	ld [hli], a
; ColorVaryDVs+1 = DefSpdDV
	ld a, d
	ld [hli], a
	inc hl
	inc hl
; ColorVaryShiny = Shiny
	ld a, b
	ld [hld], a
	ld a, c
	ld d, a
	pop bc
; ColorVarySpecies = Species
	ld a, b
	ld [hld], a
; ColorVaryDVs+2 = SatSdfDV
	ld a, c
	ld [hl], a

	ld a, d
	ld [rSVBK], a
	ret

GetColorChannelVariedByDV:
; d = color, e = DV
; a <- d + (e & %11) - (e & %1100 >> 2), ±5 if not in [0, 31]
	ld a, e
	cp %0010 ; override a +2
	jr z, .plus4
	cp %1000 ; override a -2
	jr z, .minus4
	and %11
	add d
	srl e
	srl e
	sub e
.floor
	jr c, .up
.ceil
	cp 32
	ret c
	sub 5
	ret

.up
	add 5
	ret

.plus4
	ld a, d
	add 4
	jr .ceil

.minus4
	ld a, d
	sub 4
	jr .floor


VaryRedByDV:
;;; e = DV
;;; [hl+0] = gggr:rrrr
;;; [hl+1] = 0bbb:bbgg
; store red in d
	ld a, [hl]
	and %00011111
	ld d, a
; vary d according to e
	call GetColorChannelVariedByDV
; store a back in red
	ld d, a
	ld a, [hl]
	and %11100000
	or d
	ld [hl], a
	ret

VaryGreenByDV:
;;; e = DV
;;; [hl+0] = gggr:rrrr
;;; [hl+1] = 0bbb:bbgg
; store green in d
	ld a, [hli]
	and %11100000
	srl a
	swap a
	ld d, a ; d = 00000ggg
	ld a, [hld]
	and %00000011
	swap a
	srl a
	or d
	ld d, a
; vary d according to e
	call GetColorChannelVariedByDV
; store a back in green
	sla a
	swap a
	ld d, a
	and %11100000
	ld e, a
	ld a, d
	and %00000011
	ld d, a
	ld a, [hl]
	and %00011111
	or e
	ld [hli], a
	ld a, [hl]
	and %11111100
	or d
	ld [hld], a
	ret

VaryBlueByDV:
;;; e = DV
;;; [hl+0] = gggr:rrrr
;;; [hl+1] = 0bbb:bbgg
; store blue in d
	inc hl
	ld a, [hl]
	and %01111100
	srl a
	srl a
	ld d, a
; vary d according to e
	call GetColorChannelVariedByDV
; store a back in blue
	ld d, a
	sla d
	sla d
	ld a, [hl]
	and %10000011
	or d
	ld [hl], a
	dec hl
	ret


VaryColorsByDVs::
; hl = colors
; [hl+0] = gggr:rrrr
; [hl+1] = 0bbb:bbgg
; [hl+2] = GGGR:RRRR
; [hl+3] = 0BBB:BBGG

; DVs in ColorVaryDVs
; [bc+0] = hhhh:aaaa
; [bc+1] = dddd:ssss
; [bc+2] = pppp:qqqq

; [ColorVarySpecies] = species
; [ColorVaryShiny] = shiny

	ld a, [InitialOptions]
	bit COLOR_VARY_OPT, a
	ret z

	ld a, [rSVBK]
	push af
	ld a, $5
	ld [rSVBK], a

	ld bc, ColorVaryDVs

	ld a, [ColorVarySpecies]
	cp SMEARGLE
	jr z, .Smeargle

;;; LiteRed ~ HPDV, aka, rrrrr ~ hhhh
; store HPDV in e
	ld a, [bc]
	swap a
	and %1111
	ld e, a
; vary LiteRed by e
	call VaryRedByDV

;;; LiteGrn ~ AtkDV, aka, ggggg ~ aaaa
; store AtkDV in e
	ld a, [bc]
	and %1111
	ld e, a
; vary LiteGrn by e
	call VaryGreenByDV

;;; advance from HP/Atk DV to Def/Spd DV
	inc bc

;;; LiteBlu ~ DefDV, aka, bbbbb ~ dddd
; store DefDV in e
	ld a, [bc]
	swap a
	and %1111
	ld e, a
; vary LiteBlu by e
	call VaryBlueByDV

;;; advance from Lite color to Dark color
	inc hl
	inc hl

.Finish:
;;; DarkRed ~ SpdDV, aka, RRRRR ~ ssss
; store SpdDV in e
	ld a, [bc]
	and %1111
	ld e, a
; vary DarkRed by e
	call VaryRedByDV

;;; move from Def/Spd DV to SAt/SDf DV
	inc bc

;;; DarkGrn ~ SAtDV, aka, GGGGG ~ pppp
; store SAtDV in e
	ld a, [bc]
	swap a
	and %1111
	ld e, a
; vary DarkGrn by e
	call VaryGreenByDV

;;; DarkBlu ~ SDfDV, aka, BBBBB ~ qqqq
; store SDfDV in e
	ld a, [bc]
	and %1111
	ld e, a
; vary DarkBlu by e
	call VaryBlueByDV

	pop af
	ld [rSVBK], a
	ret

; TODO: vary paint color with unused DV bits
; * DarkRed' = DarkRed + (HPDV & %0100 >> 2) - (HPDV & %1000 >> 3)
; * DarkGrn' = DarkGrn + (AtkDV & %0100 >> 2) - (AtkDV & %1000 >> 3)
; * DarkBlu' = DarkBlu + (DefDV & %0100 >> 2) - (DefDV & %1000 >> 3)
.Smeargle:
; a = (AtkDV & %11) << 2 | (DefDV & %11)
	ld a, [bc]
	and %11
	add a
	add a
	ld d, a
	inc bc
	ld a, [bc]
	swap a
	and %11
	or d
; d, e = base paint color
	ld e, a
	ld d, 0
	push hl
	ld hl, .SmearglePals
	ld a, [ColorVaryShiny]
	and SHINY_MASK
	jr z, .not_shiny
	ld hl, .SmeargleShinyPals
.not_shiny
	add hl, de
	add hl, de
	ld a, [hli]
	ld d, a
	ld a, [hl]
	ld e, a
	pop hl
;;; DarkRGB = base paint color
	inc hl
	inc hl
	inc hl
	ld a, e
	ld [hld], a
	ld a, d
	ld [hld], a
	dec hl
;;; LiteRGB ~ Spd,SAt,SDfDVs
	jr .Finish

; red and blue channels: no 0 or 31
; green channel: no 0, 7, 8, 15, 16, 23, 24, or 31
; need to be able to add or subtract 1 without overflow/underflow

.SmearglePals:
if !DEF(MONOCHROME)
	RGB 14, 05, 06 ; maroon (fighting)
	RGB 27, 09, 26 ; lavender (flying)
	RGB 29, 05, 06 ; red (poison)
	RGB 26, 26, 26 ; white (ground)
	RGB 18, 11, 05 ; brown (rock)
	RGB 16, 28, 01 ; lime (bug)
	RGB 14, 06, 27 ; purple (ghost)
	RGB 14, 14, 18 ; gray (steel)
	RGB 29, 13, 02 ; orange (fire)
	RGB 01, 09, 28 ; blue (water)
	RGB 04, 19, 01 ; green (grass)
	RGB 30, 25, 01 ; yellow (electric)
	RGB 30, 10, 13 ; pink (psychic)
	RGB 02, 22, 26 ; teal (ice)
	RGB 07, 11, 30 ; indigo (dragon)
	RGB 08, 06, 06 ; black (dark)
else
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_DARK
endc

.SmeargleShinyPals: ; TODO
if !DEF(MONOCHROME)
	RGB 14, 05, 06 ; maroon (fighting)
	RGB 27, 09, 26 ; lavender (flying)
	RGB 29, 05, 06 ; red (poison)
	RGB 26, 26, 26 ; white (ground)
	RGB 18, 11, 05 ; brown (rock)
	RGB 16, 28, 01 ; lime (bug)
	RGB 14, 06, 27 ; purple (ghost)
	RGB 14, 14, 18 ; gray (steel)
	RGB 29, 13, 02 ; orange (fire)
	RGB 01, 09, 28 ; blue (water)
	RGB 04, 19, 01 ; green (grass)
	RGB 30, 25, 01 ; yellow (electric)
	RGB 30, 10, 13 ; pink (psychic)
	RGB 02, 22, 26 ; teal (ice)
	RGB 07, 11, 30 ; indigo (dragon)
	RGB 08, 06, 06 ; black (dark)
else
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_DARK
endc

VaryBGPal0ByTempMonDVs:
	ld hl, TempMonDVs
	ld a, [TempMonSpecies]
	ld b, a
	call CopyDVsToColorVaryDVs
	ld hl, UnknBGPals palette 0 + 2
	jp VaryColorsByDVs

VaryBGPal1ByTempMonDVs:
	ld hl, TempMonDVs
	ld a, [TempMonSpecies]
	ld b, a
	call CopyDVsToColorVaryDVs
	ld hl, UnknBGPals palette 1 + 2
	jp VaryColorsByDVs
