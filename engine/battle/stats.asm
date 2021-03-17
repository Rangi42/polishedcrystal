FarChangeStat:
; b contains stat to alter, or -1 if it should be read from the move script
	push af
	ld a, 2
	ld [wFailedMessage], a
	ld a, b
	inc b
	jr nz, .move_script_byte_ok
	farcall ReadMoveScriptByte
.move_script_byte_ok
	ld [wLoweredStat], a
	pop af
	ld b, a
	bit STAT_TARGET_F, b
	jr z, .player
	call HasOpponentFainted
	ret z
	jr z, .not_fainted
.player
	call HasUserFainted
	ret z
.not_fainted

	; check attack missing
	bit STAT_MISS_F, b
	jr z, .no_miss
	ld a, [wAttackMissed]
	and a
	jr z, .no_miss

	; The attack missed
	bit STAT_SILENT_F, b
	ret nz
	farcall CheckAlreadyExecuted
	ret nz
	farcall AnimateFailedMove
	farjp GetFailureResultText

.no_miss
	; check secondary
	bit STAT_SECONDARY_F, b
	jr z, .no_secondary
	ld a, [wEffectFailed]
	and a
	ret nz

.no_secondary
	; Do target-only checks
	bit STAT_TARGET_F, b
	jr nz, .is_target
	call GetTrueUserAbility
	cp CONTRARY
	jp nz, .ability_done
	ld a, b
	xor STAT_LOWER
	ld b, a
	jp .ability_done

.is_target
	call GetOpponentAbilityAfterMoldBreaker
	cp CONTRARY
	jr nz, .no_target_contrary
	ld a, b
	xor STAT_LOWER
	ld b, a
.no_target_contrary
	push bc
	farcall CheckSubstituteOpp
	pop bc
	jr z, .check_lowering

	bit STAT_SILENT_F, b
	ret nz
	farcall ShowPotentialAbilityActivation
	farcall CheckAlreadyExecuted
	ret nz
	farcall AnimateFailedMove
	farjp PrintButItFailed

.check_lowering
	bit STAT_LOWER_F, b
	jr z, .ability_done
	ldh a, [hBattleTurn]
	and a
	ld a, [wEnemyGuards]
	jr z, .got_guard
	ld a, [wPlayerGuards]
.got_guard
	and GUARD_MIST
	jr z, .check_ability
	bit STAT_SILENT_F, b
	ret nz
	farcall CheckAlreadyExecuted
	ret nz
	farcall ShowPotentialAbilityActivation
	farcall AnimateFailedMove
	ld hl, ProtectedByMistText
	jp StdBattleTextbox

.check_ability
	call GetOpponentAbilityAfterMoldBreaker
	cp CLEAR_BODY
	jr z, .ability_immune
	cp HYPER_CUTTER
	ld c, ATTACK
	jr z, .ability_check
	cp BIG_PECKS
	ld c, DEFENSE
	jr z, .ability_check
	cp KEEN_EYE
	ld c, ACCURACY
	jr nz, .ability_done
.ability_check
	ld a, [wLoweredStat]
	and $f
	cp c
	jr nz, .ability_done
.ability_immune
	bit STAT_SILENT_F, b
	ret nz
	farcall CheckAlreadyExecuted
	ret nz
	farcall ShowPotentialAbilityActivation
	farcall DisableAnimations
	farcall ShowEnemyAbilityActivation
	farcall AnimateFailedMove
	ld hl, DoesntAffectText
	call StdBattleTextbox
	farjp EnableAnimations

.ability_done
	bit STAT_TARGET_F, b
	call nz, SwitchTurn
	push bc
	bit STAT_LOWER_F, b
	jr nz, .lower
	call DoRaiseStat
	jr .stat_done
.lower
	call DoLowerStat
.stat_done
	ld a, [wLoweredStat]
	and $f
	ld b, a
	inc b
	call GetStatName
	pop bc
	bit STAT_TARGET_F, b
	call nz, SwitchTurn
	ld a, [wFailedMessage]
	and a
	jr z, .check_anim
	bit STAT_SILENT_F, b
	ret nz
	push bc
	farcall ShowPotentialAbilityActivation
	ld c, 60
	call DelayFrames
	pop bc
	ld hl, WontRiseAnymoreText
	ld de, WontDropAnymoreText
	or 1
	jp DoPrintStatChange

.check_anim
	bit STAT_SKIPTEXT_F, b
	ret nz
	bit STAT_SILENT_F, b
	push bc
	jr nz, .anim_done
	farcall StatUpDownAnim
.anim_done
	farcall ShowPotentialAbilityActivation
	pop bc
PrintStatChange:
	call GetStatRaiseMessage
DoPrintStatChange:
	push af
	and a
	call z, PlayStatChangeAnim
	pop af

	bit STAT_TARGET_F, b
	jr z, .do_print
	push af
	call SwitchTurn
	pop af
	call .do_print
	jp SwitchTurn

.do_print
	bit STAT_LOWER_F, b
	jr z, .printmsg
	ld h, d
	ld l, e
	push af
	push bc
	call StdBattleTextbox
	pop bc
	pop af
	bit STAT_TARGET_F, b
	ret z
	and a
	ret nz
	ld a, [wAlreadyExecuted]
	push af
	farcall RunStatIncreaseAbilities
	pop af
	ld [wAlreadyExecuted], a
	xor a
	ld [wFailedMessage], a
	ret

.printmsg
	jp StdBattleTextbox

GetStatRaiseMessage:
	ld a, [wLoweredStat]
	and $f0
	swap a
	and a
	ld hl, StatRoseText
	ld de, StatFellText
	ret z
	dec a
	ld hl, StatRoseSharplyText
	ld de, StatHarshlyFellText
	ret z
	ld hl, StatRoseDrasticallyText
	ld de, StatSeverelyFellText
	xor a
	ret

UseStatItemText:
; doesn't consume the item in case of multiple stats
	push bc
	ld a, [wLoweredStat]
	and $f
	ld b, a
	inc b
	call GetStatName
	farcall CheckAlreadyExecuted
	jr nz, .item_anim_done
	farcall ItemRecoveryAnim
.item_anim_done
	call GetCurItemName
	ld a, [wLoweredStat]
	and $f0
	swap a
	and a
	ld hl, BattleText_ItemRaised
	ld de, BattleText_ItemLowered
	jr z, .gotmsg
	dec a
	ld hl, BattleText_ItemSharplyRaised
	ld de, BattleText_ItemHarshlyLowered
	jr z, .gotmsg
	ld hl, BattleText_ItemDrasticallyRaised
	ld de, BattleText_ItemSeverelyLowered
.gotmsg
	xor a
	call DoPrintStatChange
	pop bc
	ret

GetStatName:
	ld hl, StatNames
	ld c, "@"
.CheckName:
	dec b
	jr z, .Copy
.GetName:
	ld a, [hli]
	cp c
	jr z, .CheckName
	jr .GetName

.Copy:
	ld de, wStringBuffer2
	ld bc, wStringBuffer3 - wStringBuffer2
	rst CopyBytes
	ret

INCLUDE "data/battle/stat_names.asm"

DoLowerStat:
	or 1
	jr DoChangeStat
DoRaiseStat:
	xor a
DoChangeStat:
	push af
	xor a
	ld [wFailedMessage], a
	ldh a, [hBattleTurn]
	and a
	ld hl, wPlayerStatLevels
	jr z, .got_stat_levels
	ld hl, wEnemyStatLevels
.got_stat_levels
	ld a, [wLoweredStat]
	and $f
	ld c, a
	ld b, 0
	add hl, bc

	; Perform the stat change
	ld a, [wLoweredStat]
	and $f0
	swap a
	inc a
	ld c, a
	pop af
	jr nz, .lower_loop

.raise_loop
	ld a, [hl]
	cp MAX_STAT_LEVEL
	jr z, .stat_change_done
	inc [hl]
	inc b
	dec c
	jr nz, .raise_loop
	jr .stat_change_done

.lower_loop
	ld a, [hl]
	dec a
	jr z, .stat_change_done
	dec [hl]
	inc b
	dec c
	jr nz, .lower_loop

.stat_change_done
	; Amount of stat levels changed is in b
	ld a, b
	and a
	jr z, .stat_change_failed
	dec b
	swap b
	ld a, [wLoweredStat]
	and $f
	or b
	ld [wLoweredStat], a
	ret

.stat_change_failed
	ld a, 1
	ld [wFailedMessage], a
	ret

PlayStatChangeAnim:
	farcall CheckBattleEffects
	ret c
	bit STAT_TARGET_F, b
	jr z, .do_it

	call SwitchTurn
	call .do_it
	jp SwitchTurn

.do_it
	push hl
	push de
	push bc
if !DEF(MONOCHROME)
	ld hl, StatPals
	ld de, wOBPals1 palette PAL_BATTLE_OB_GRAY + 2
	ld a, [wLoweredStat]
	and $f
	add a
	add a
	ld c, a
	ld b, 0
	add hl, bc
	ld bc, 4
	call FarCopyColorWRAM
	ld b, 2
	call SafeCopyTilemapAtOnce
endc
	pop bc
	push bc
	ld de, ANIM_STAT_UP
	bit STAT_LOWER_F, b
	jr z, .got_anim
	ld de, ANIM_STAT_DOWN
.got_anim
	ld a, [wNumHits]
	push af
	xor a
	ld [wNumHits], a
	farcall FarPlayBattleAnimation
	pop af
	ld [wNumHits], a
	ld a, CGB_BATTLE_COLORS
	call GetCGBLayout
	call SetPalettes
	jp PopBCDEHL

StatPals: ; similar to X items
; attack - red
	RGB 31, 19, 24
	RGB 30, 10, 06
; defense - blue
	RGB 12, 14, 31
	RGB 01, 04, 31
; speed - cyan
	RGB 13, 27, 31
	RGB 05, 20, 30
; spcl.atk - yellow
	RGB 31, 31, 07
	RGB 29, 23, 01
; spcl.def - green
	RGB 12, 25, 01
	RGB 05, 14, 00
; accuracy - purple
	RGB 27, 13, 31
	RGB 23, 00, 31
; evasion - gray
	RGB 25, 25, 25
	RGB 13, 13, 13
