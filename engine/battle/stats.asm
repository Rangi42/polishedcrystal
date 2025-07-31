FarChangeStat:
; b contains stat to alter, or -1 if it should be read from the move script
; If using SILENT|SKIPTEXT and handling DoPrintStatChange later, b must be
; preserved between the 2 calls.
	push af
	ld a, 2
	ld [wFailedMessage], a
	ld a, b
	inc b
	jr nz, .move_script_byte_ok
	farcall ReadMoveScriptByte
.move_script_byte_ok
	ld [wChangedStat], a
	pop af
	ld b, a
	bit STAT_TARGET_F, b
	jr z, .player
	call HasOpponentFainted
	ret z
.player
	call HasUserFainted
	ret z
.not_fainted

	; check attack missing
	bit STAT_CANMISS_F, b
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
	jmp nz, .perform_change
	ld a, b
	xor STAT_LOWER
	ld b, a
	jmp .perform_change

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
	jmp z, .perform_change
	ldh a, [hBattleTurn]
	and a
	ld a, [wEnemyGuards]
	jr z, .got_guard
	ld a, [wPlayerGuards]
.got_guard
	and GUARD_MIST
	ld hl, ProtectedByMistText
	jr nz, .mist_or_item_fail

.check_ability
	call GetOpponentAbilityAfterMoldBreaker
	cp CLEAR_BODY
	jr z, .ability_immune
	cp WHITE_SMOKE
	jr z, .ability_immune
	cp HYPER_CUTTER
	ld c, ATTACK
	jr z, .ability_check
	cp BIG_PECKS
	ld c, DEFENSE
	jr z, .ability_check
	cp KEEN_EYE
	ld c, ACCURACY
	jr z, .ability_check
	cp ILLUMINATE
	jr z, .ability_check
	cp MINDS_EYE
	jr nz, .check_item
.ability_check
	ld a, [wChangedStat]
	and $f
	cp c
	jr nz, .check_item
.ability_immune
	bit STAT_SILENT_F, b
	ret nz
	farcall CheckAlreadyExecuted
	ret nz
	farcall ShowPotentialAbilityActivation
	farcall BeginAbility
	farcall ShowEnemyAbilityActivation
	farcall AnimateFailedMove
	ld hl, DoesntAffectText
	call StdBattleTextbox
	farjp EndAbility

.check_item
	push bc
	farcall GetOpponentItemAfterUnnerve
	call GetCurItemName
	ld a, b
	pop bc
	cp HELD_CLEAR_AMULET
	ld hl, ProtectedByItemText
	jr nz, .perform_change

.mist_or_item_fail
	bit STAT_SILENT_F, b
	ret nz
	push hl
	farcall CheckAlreadyExecuted
	pop hl
	ret nz
	push hl
	farcall ShowPotentialAbilityActivation
	farcall AnimateFailedMove
	pop hl
	jmp StdBattleTextbox

.perform_change
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
	ld a, [wChangedStat]
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
	jr DoPrintStatChange

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
	jmp SwitchTurn

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
	ret nz ; the stat change failed
	ld a, [wAlreadyExecuted]
	push af
	farcall RunStatIncreaseAbilities
	pop af
	ld [wAlreadyExecuted], a
	xor a
	ld [wFailedMessage], a
	ret

.printmsg
	jmp StdBattleTextbox

GetStatRaiseMessage:
	ld a, [wChangedStat]
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
	ld a, [wChangedStat]
	and $f
	ld b, a
	inc b
	call GetStatName
	farcall CheckAlreadyExecuted
	jr nz, .item_anim_done
	farcall CurItemRecoveryAnim
.item_anim_done
	call GetCurItemName
	ld a, [wChangedStat]
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
	pop bc
	push bc
	call DoPrintStatChange
	pop bc
	ret

GetStatName:
	ld hl, StatNames
	ld c, '@'
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
	ld a, [wChangedStat]
	and $f
	ld c, a
	ld b, 0
	add hl, bc

	; Perform the stat change
	ld a, [wChangedStat]
	and $f0
	swap a
	inc a
	ld c, a
	pop af
	jr nz, .lower_loop

.raise_loop
	ld a, [hl]
	cp MAX_STAT_LEVEL
	jr z, .queue_mirror_herb
	inc [hl]
	inc b
	dec c
	jr nz, .raise_loop

.queue_mirror_herb
	; Get the relevant stat.
	ld hl, wMirrorHerbPendingBoosts
	ld a, [wChangedStat]
	and $f
	add l
	ld l, a
	adc h
	sub l
	ld h, a

	; Add the stat increment to pending boosts to copy.
	; Since we can't read half-carry, swap b (amount of increments) so
	; that we can do the add on the higher nibble and use carry.
	call .SwapHLIfEnemy
	ld a, b
	swap a
	add [hl]
	jr nc, .no_overflow
	or $f0
.no_overflow
	ld [hl], a
	call .SwapHLIfEnemy
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
	ld a, [wChangedStat]
	and $f
	or b
	ld [wChangedStat], a
	ret

.stat_change_failed
	ld a, 1
	ld [wFailedMessage], a
	ret

.SwapHLIfEnemy:
	ldh a, [hBattleTurn]
	and a
	ret z
	swap [hl]
	ret

PlayStatChangeAnim:
	farcall CheckBattleEffects
	ret c
	bit STAT_TARGET_F, b
	jr z, .do_it

	call SwitchTurn
	call .do_it
	jmp SwitchTurn

.do_it
	push hl
	push de
	push bc
	ld de, ANIM_STAT_UP
	bit STAT_LOWER_F, b
	jr z, .got_anim
	ld de, ANIM_STAT_DOWN
.got_anim
	ld a, [wBattleAnimParam]
	ld b, a
	ld a, [wNumHits]
	ld c, a
	push bc
	ld a, [wChangedStat]
	and $f
	ld [wBattleAnimParam], a
	xor a
	ld [wNumHits], a
	farcall FarPlayBattleAnimation
	pop bc
	ld a, c
	ld [wNumHits], a
	ld a, b
	ld [wBattleAnimParam], a
	jmp PopBCDEHL
