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
; a <- d + (e & %11) - (e & %1100 >> 2), clamped to [0, 31]
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
	jr c, .zero
.ceil
	cp 32
	ret c
	ld a, 31
	ret

.zero
	xor a
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
	jr .Done

; TODO:
; * vary skin color with Spd, SAt, SDf, like normal
; * pick base paint color like Hidden Power type, with (Atk&%11<<2)|(Def&%11)
; * vary paint color with 8 unused bits from HP, Atk&%1100, and Def&%1100, somehow
.Smeargle:
; pick variation by SAt DV
	inc bc
	inc bc
	inc hl
	inc hl
	push hl
	ld a, [bc]
	swap a
	and %1111
	ld e, a
	ld hl, .SmearglePals
	ld a, [ColorVaryShiny]
	and SHINY_MASK
	jr z, .not_shiny
	ld hl, .SmeargleShinyPals
.not_shiny
	sla e
	ld d, 0
	add hl, de
	ld a, [hli]
	ld e, a
	ld d, [hl]
	pop hl
	ld a, e
	ld [hli], a
	ld a, d
	ld [hl], a

.Done:
	pop af
	ld [rSVBK], a
	ret

.SmearglePals:
	RGB 02, 02, 02 ; black
	RGB 16, 16, 16 ; grey
	RGB 29, 29, 29 ; white
	RGB 31, 05, 06 ; red
	RGB 13, 27, 08 ; green
	RGB 00, 10, 27 ; blue
	RGB 29, 31, 02 ; yellow
	RGB 30, 16, 00 ; orange
	RGB 15, 09, 00 ; brown
	RGB 23, 22, 13 ; khaki
	RGB 21, 02, 09 ; amaranth
	RGB 31, 19, 24 ; pink
	RGB 18, 01, 24 ; violet
	RGB 31, 26, 00 ; gold
	RGB 24, 24, 24 ; silver
	RGB 08, 28, 26 ; crystal

.SmeargleShinyPals: ;TODO
	RGB 02, 02, 02
	RGB 16, 16, 16
	RGB 29, 29, 29
	RGB 31, 05, 06
	RGB 13, 27, 08
	RGB 00, 10, 27
	RGB 29, 31, 02
	RGB 30, 16, 00
	RGB 15, 09, 00
	RGB 23, 22, 13
	RGB 21, 02, 09
	RGB 31, 19, 24
	RGB 18, 01, 24
	RGB 31, 26, 00
	RGB 24, 24, 24
	RGB 08, 28, 26


VaryBGPal0ByTempMonDVs:
	ld hl, TempMonDVs
	ld a, [TempMonSpecies]
	ld b, a
	call CopyDVsToColorVaryDVs
	ld hl, UnknBGPals + 2
	call VaryColorsByDVs
	ret

VaryBGPal1ByTempMonDVs:
	ld hl, TempMonDVs
	ld a, [TempMonSpecies]
	ld b, a
	call CopyDVsToColorVaryDVs
	ld hl, UnknBGPals + 1 palettes + 2
	call VaryColorsByDVs
	ret
