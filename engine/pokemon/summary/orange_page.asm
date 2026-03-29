SummaryScreen_OrangePage:
	ld a, SUMMARY_TILE_OAM_MET_TITLE
	call SummaryScreen_UpdateTabTitle
	call .TN_PrintToD
	call .TN_PrintLV
	call .TN_PrintLocation
	ld a, [wTextboxFlags]
	set USE_BG_MAP_WIDTH_F, a
	ld [wTextboxFlags], a
	call .PlaceNatureInfo
	call .TN_PrintCharacteristics
	ld a, [wTextboxFlags]
	res USE_BG_MAP_WIDTH_F, a
	ld [wTextboxFlags], a
	ld hl, wTempMonPersonality
	ld a, [wTempMonSpecies]
	ld c, a
	call GetAbility

.PlaceNatureInfo:
	ld de, .NatureString
	hlbgcoord 0, 0, wSummaryScreenWindowBuffer
	rst PlaceString
	ld de, .CharacterString
	hlbgcoord 0, 2, wSummaryScreenWindowBuffer
	rst PlaceString
	ld a, [wTempMonNature]
	ld b, a
	call GetNature
	hlbgcoord 1, 1, wSummaryScreenWindowBuffer
	farcall PrintNature

	ld hl, .OrangePalettes
	ld bc, 1 palettes
	ld de, wSummaryScreenPals palette SUMMARY_PAL_LOWER_WINDOW
	rst CopyBytes
	ld bc, 1 palettes
	ld de, wSummaryScreenPals palette SUMMARY_PAL_SIDE_WINDOW
	rst CopyBytes

	ret

.OrangePalettes:
INCLUDE "gfx/stats/orange_page.pal"

.NatureString:
	db "Nature/@"

.CharacterString:
	db "Character/@"

.TN_PrintToD:
	hlcoord 1, 14
	ld a, [wTempMonCaughtTime]
	farjp PlaceCaughtTimeOfDayString

.TN_PrintLocation:
	farcall BT_InRentalMode
	ld de, .battle_factory
	jr z, .print
	ld a, [wTempMonCaughtLocation]
	and a
	ret z
	ld de, .event
	cp LANDMARK_EVENT
	jr z, .print
	ld e, a
	farcall GetLandmarkName
	ld de, wStringBuffer1
.print
	hlcoord 1, 17
	rst PlaceString
	ret

.battle_factory
	db "Battle Factory@"

.event
	db "Event #mon@"

.TN_PrintLV:
	ld a, [wTempMonCaughtLevel]
; inherit coordinate from TN_PrintToD
	ld h, b
	ld l, c
	inc hl
;	hlcoord = 11, 9
	inc a
	jr z, .hatched
	dec a
	jr z, .traded
	ld [wSummaryCaughtLevel], a
	ld de, .str_level
	rst PlaceString
	ld h, b
	ld l, c
;	hlcoord = 15, 9
	ld de, wSummaryCaughtLevel
	lb bc, PRINTNUM_LEFTALIGN | 1, 3
	jmp PrintNum
.hatched
	ld de, .str_hatched
	rst PlaceString
	ret
.traded
	ld de, .str_traded
	rst PlaceString
	ret

.str_level
	db "at <LV>@"

.str_hatched
	db "from Egg@"

.str_traded
	db "by trade@"

.TN_PrintCharacteristics:
	; b = value of best DV, c = index of best DV
	ld hl, wTempMonDVs
	; Atk
	ld c, 1
	ld a, [hl]
	and $f
	ld b, a
	; HP
	ld a, [hli]
	swap a
	and $f
	cp b
	jr z, .atk_beats_hp ; tie
	jr c, .atk_beats_hp
	ld c, 0
	ld b, a
.atk_beats_hp
	; Spe
	ld a, [hl]
	and $f
	cp b
	jr z, .last_beats_spe ; tie
	jr c, .last_beats_spe
	ld c, 5
	ld b, a
.last_beats_spe
	; Def
	ld a, [hli]
	swap a
	and $f
	cp b
	jr z, .last_beats_def ; tie
	jr c, .last_beats_def
	ld c, 2
	ld b, a
.last_beats_def
	; SDf
	ld a, [hl]
	and $f
	cp b
	jr z, .last_beats_sdf ; tie
	jr c, .last_beats_sdf
	ld c, 4
	ld b, a
.last_beats_sdf
	; SAt
	ld a, [hl]
	swap a
	and $f
	cp b
	jr z, .last_beats_sat ; tie
	jr c, .last_beats_sat
	ld c, 3
	ld b, a
.last_beats_sat

; DVs are 0-15, but Gen 3+ IVs are 0-31.
; Stats are calculated so that a DV of N acts like an IV of 2*N+1.
; To keep characteristics consistent with the apparent IV values,
; this conversion is actually done.
	ld a, b
	add b
	inc a
	ld b, a
	; a = 5 * c + b % 5
.mod_5
	cp 5
	jr c, .modded_5
	sub 5
	jr .mod_5
.modded_5
	ld b, a
	ld a, 5
	call SimpleMultiply
	add b

	ld l, a
	ld h, 0
	ld bc, Characteristics
	add hl, hl
	add hl, bc
	ld a, [hli]
	ld d, [hl]
	ld e, a
	hlbgcoord 1, 3, wSummaryScreenWindowBuffer
	rst PlaceString
	ret

INCLUDE "data/characteristics.asm"
