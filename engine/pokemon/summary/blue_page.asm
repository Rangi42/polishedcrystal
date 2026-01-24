SummaryScreen_BluePage:
	ld a, SUMMARY_TILE_OAM_ABILITY_TITLE
	call SummaryScreen_UpdateTabTitle
	hlbgcoord 3, 1, wSummaryScreenWindowBuffer
	call SummaryScreen_DrawPlayerHP
	hlbgcoord 19, 1, wSummaryScreenWindowBuffer
	ld a, SUMMARY_PAL_HP_BAR
	ld bc, 10
	rst ByteFill
	ld a, [wTextboxFlags]
	set USE_BG_MAP_WIDTH_F, a
	set NO_LINE_SPACING_F, a
	ld [wTextboxFlags], a
	hlbgcoord 0, 0, wSummaryScreenWindowBuffer
	ld de, .HPString
	rst PlaceString
	hlbgcoord 0, 2, wSummaryScreenWindowBuffer
	ld bc, 8
	farcall PrintTempMonStats
	ld a, [wTextboxFlags]
	res USE_BG_MAP_WIDTH_F, a
	res NO_LINE_SPACING_F, a
	ld [wTextboxFlags], a

	ld a, [wInitialOptions]
	and ABILITIES_OPTMASK
	jr z, .no_ability
	ld a, [wTempMonAbility]
	and ABILITY_MASK
	swap a
	rrca
	ld e, a
	ld d, 0
	ld hl, .AbilityTiles
	add hl, de
	ld a, [hl]
	hlcoord 18, 13
	ld [hl], a
.no_ability

	ld hl, wTempMonPersonality
	ld a, [wTempMonSpecies]
	ld c, a
	call GetAbility

	push bc
	hlcoord 1, 13
	farcall PrintAbility
	pop bc
	farcall PrintAbilityDescription

	; Print Hyper Training statistics
	ld hl, wTempMonHyperTraining
	ld a, [hl]

	; Handle display one by one since Sp.Atk/Sp.Def/Speed is displayed in a
	; different order.
	hlbgcoord 11, 0, wSummaryScreenWindowBuffer
	ld de, TILEMAP_WIDTH
	call .CheckHyper ; HP
	add hl, de ; move past the HP bar
	call .CheckHyper ; Attack
	call .CheckHyper ; Defense
	rlca ; skips the speed one for now
	call .CheckHyper ; Sp.Atk
	call .CheckHyper ; Sp.Def
	rlca
	swap a
	call .CheckHyper ; Spe

	call SummaryScreen_ColorNatures

	ld hl, .BluePalettes
	ld bc, 1 palettes
	ld de, wSummaryScreenPals palette SUMMARY_PAL_LOWER_WINDOW
	rst CopyBytes
	ld bc, 1 palettes
	ld de, wSummaryScreenPals palette SUMMARY_PAL_SIDE_WINDOW
	rst CopyBytes
	ld bc, 1 palettes
	ld de, wSummaryScreenPals palette SUMMARY_PAL_NATURE_UP
	rst CopyBytes
	ld bc, 1 palettes
	ld de, wSummaryScreenPals palette SUMMARY_PAL_NATURE_DOWN
	rst CopyBytes

	ld a, [wCurHPPal]
	add a
	add a
	add a
	add LOW(.HPPalettes)
	ld l, a
	adc HIGH(.HPPalettes)
	sub l
	ld h, a
	ld bc, 1 palettes
	ld de, wSummaryScreenPals + 5 palettes
	rst CopyBytes

	ret

.CheckHyper:
	rlca
	jr nc, .no_hyper_training
	ld [hl], SUMMARY_TILE_HYPER_TRAINING
.no_hyper_training
	add hl, de
	ret

.BluePalettes:
INCLUDE "gfx/stats/blue_page.pal"

.HPPalettes:
INCLUDE "gfx/stats/blue_hp_bars.pal"

.HPString:
	db "HP@"

.AbilityTiles:
	db SUMMARY_TILE_HIDDEN_H, "1", "2", SUMMARY_TILE_HIDDEN_H

SummaryScreen_ColorNatures:
	ld c, STAT_ATK
	hlbgcoord 16 + 8, 2, wSummaryScreenWindowBuffer
	call .ColorNature
	ld c, STAT_DEF
	hlbgcoord 16 + 8, 3, wSummaryScreenWindowBuffer
	call .ColorNature
	ld c, STAT_SATK
	hlbgcoord 16 + 8, 4, wSummaryScreenWindowBuffer
	call .ColorNature
	ld c, STAT_SDEF
	hlbgcoord 16 + 8, 5, wSummaryScreenWindowBuffer
	call .ColorNature
	ld c, STAT_SPE
	hlbgcoord 16 + 8, 6, wSummaryScreenWindowBuffer
	; fallthrough
; c = stat
; hl = output attr coords
.ColorNature:
	ld a, [wTempMonNature]
	push hl
	farcall GetNatureStatMultiplier
	pop hl
	cp 10
	ret z
	; a = carry ? SUMMARY_PAL_NATURE_DOWN : SUMMARY_PAL_NATURE_UP
	sbc a
	and SUMMARY_PAL_NATURE_DOWN - SUMMARY_PAL_NATURE_UP
	add SUMMARY_PAL_NATURE_UP
	ld [hli], a
	ld [hli], a
	ld [hl], a
	ret

; Copy of DrawPlayerHP that works on the window buffer
SummaryScreen_DrawPlayerHP:
	ld a, $1
	ld [wWhichHPBar], a
	push hl
	push bc
	ld a, [wMonType]
	cp BOXMON
	jr z, .at_least_1_hp

	ld a, [wTempMonHP]
	ld b, a
	ld a, [wTempMonHP + 1]
	ld c, a

; Any HP?
	or b
	jr nz, .at_least_1_hp

	xor a
	ld c, a
	ld e, a
	ld a, 6
	ld d, a
	jr .fainted

.at_least_1_hp
	ld a, [wTempMonMaxHP]
	ld d, a
	ld a, [wTempMonMaxHP + 1]
	ld e, a
	ld a, [wMonType]
	cp BOXMON
	jr nz, .not_boxmon

	ld b, d
	ld c, e

.not_boxmon
	predef ComputeHPBarPixels
	ld a, 6
	ld d, a
	ld c, a

.fainted
	ld a, c
	pop bc
	ld c, a
	pop hl
	push de
	push hl
	push hl
	call DrawBattleHPBar
	pop hl

; Print HP
	ld bc, -31
	add hl, bc
	ld de, wTempMonHP
	ld a, [wMonType]
	cp BOXMON
	jr nz, .not_boxmon_2
	ld de, wTempMonMaxHP
.not_boxmon_2
	lb bc, 2, 3
	call PrintNum

	ld a, '/'
	ld [hli], a

; Print max HP
	ld de, wTempMonMaxHP
	lb bc, 2, 3
	call PrintNum
	pop hl
	pop de
	ret
