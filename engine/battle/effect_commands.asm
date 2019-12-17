DoPlayerTurn: ; 34000
	call SetPlayerTurn

	ld a, [wBattleType]
	cp BATTLETYPE_GHOST
	jr nz, DoTurn

	ld hl, ScaredText
	jp StdBattleTextBox
; 3400a


DoEnemyTurn: ; 3400a
	call SetEnemyTurn

	ld a, [wBattleType]
	cp BATTLETYPE_GHOST
	jr nz, .not_ghost

	ld hl, GetOutText
	jp StdBattleTextBox

.not_ghost
	ld a, [wLinkMode]
	and a
	jr z, DoTurn

	ld a, [wBattleAction]
	cp BATTLEACTION_STRUGGLE
	jr z, DoTurn
	cp BATTLEACTION_SWITCH1
	ret nc

	; fallthrough
; 3401d


DoTurn: ; 3401d
; Read in and execute the user's move effects for this turn.
	xor a
	ld [wTurnEnded], a

	ld a, [hBattleTurn]
	and a
	ld hl, wPlayerSwitchTarget
	jr z, .got_switch_target
	ld hl, wEnemySwitchTarget
.got_switch_target
	ld a, [hl]
	and a
	ld a, 1 << SWITCH_DEFERRED | 1 << SWITCH_EXPLICIT | 1 << SWITCH_PURSUIT
	call nz, SetDeferredSwitch

	; Effect command checkturn is called for every move.
	call CheckTurn

	ld a, [wTurnEnded]
	and a
	ret nz

	call UpdateMoveData
; 3402c

DoMove:
; Get the user's move effect.
	; Increase move usage counter if applicable
	call IncreaseMetronomeCount
	ld a, BATTLE_VARS_MOVE_EFFECT
	call GetBattleVar
	ld c, a
	ld b, 0
	ld hl, MoveEffectsPointers
	add hl, bc
	add hl, bc
	ld a, BANK(MoveEffectsPointers)
	call GetFarHalfword

	ld a, l
	ld [wBattleScriptBufferLoc], a
	ld a, h
	ld [wBattleScriptBufferLoc + 1], a

.ReadMoveEffectCommand:
	call ReadMoveScriptByte

	; endturn_command (-2) is used to terminate branches without ending the read cycle
	cp endturn_command
	jr nc, .endturn_herb

	; The rest of the commands (fd and below) are read from BattleCommandPointers
	push bc
	dec a
	ld c, a
	ld b, 0
	ld hl, BattleCommandPointers
	add hl, bc
	add hl, bc
	pop bc

	ld a, BANK(BattleCommandPointers)
	call GetFarHalfword

	call _hl_

	jr .ReadMoveEffectCommand

.endturn_herb
	push af
	call CheckWhiteHerb ; also Eject Pack
	call CheckThroatSpray
	call CheckPowerHerb
	pop af
	ret

ReadMoveScriptByte:
	ld a, [wBattleScriptBufferLoc]
	ld l, a
	ld a, [wBattleScriptBufferLoc + 1]
	ld h, a

	inc hl
	ld a, l
	ld [wBattleScriptBufferLoc], a
	ld a, h
	ld [wBattleScriptBufferLoc + 1], a
	dec hl

	ld a, BANK(MoveEffectsPointers)
	jp GetFarByte

CheckTurn:
BattleCommand_checkturn:
; Repurposed as hardcoded turn handling. Useless as a command.
	; Move 0 immediately ends the turn (Used by Pursuit)
	ld a, BATTLE_VARS_MOVE
	call GetBattleVar
	and a
	jp z, EndTurn

	xor a
	ld [wAttackMissed], a
	ld [wEffectFailed], a
	ld [wKickCounter], a
	ld [wAlreadyDisobeyed], a
	ld [wAlreadyExecuted], a
	ld [wSomeoneIsRampaging], a

	ld a, $10 ; 1.0
	ld [wTypeModifier], a

	ld a, BATTLE_VARS_SUBSTATUS4
	call GetBattleVarAddr
	bit SUBSTATUS_RECHARGE, [hl]
	jr z, .no_recharge

	res SUBSTATUS_RECHARGE, [hl]
	ld hl, MustRechargeText
	call StdBattleTextBox
	call CantMove
	jp EndTurn

.no_recharge
	ld a, BATTLE_VARS_SUBSTATUS3
	call GetBattleVarAddr
	bit SUBSTATUS_FLINCHED, [hl]
	jr z, .not_flinched

	res SUBSTATUS_FLINCHED, [hl]
	ld a, BATTLE_VARS_ABILITY
	call GetBattleVar
	cp INNER_FOCUS
	jr z, .not_flinched
	push af
	ld hl, FlinchedText
	call StdBattleTextBox
	pop af
	cp STEADFAST
	jr nz, .skip_steadfast
	farcall SteadfastAbility

.skip_steadfast
	call CantMove
	jp EndTurn

.not_flinched
	ld a, BATTLE_VARS_STATUS
	call GetBattleVarAddr
	ld a, [hl]
	and SLP
	jr z, .not_asleep

	dec [hl]
	jr z, .woke_up

	; Early Bird decreases the sleep timer twice as fast (including Rest).
	ld a, BATTLE_VARS_ABILITY
	call GetBattleVar
	cp EARLY_BIRD
	jr nz, .no_early_bird
	; duplicated, but too few lines to make merging it worth it
	dec [hl]
	jr z, .woke_up

.no_early_bird
	xor a
	ld [wNumHits], a
	ld de, ANIM_SLP
	call FarPlayBattleAnimation
	jr .fast_asleep

.woke_up
	ld hl, WokeUpText
	call StdBattleTextBox
	ld a, [hBattleTurn]
	and a
	jr nz, .enemy1
	call UpdateBattleMonInParty
	ld hl, UpdatePlayerHUD
	jr .ok1
.enemy1
	call UpdateEnemyMonInParty
	ld hl, UpdateEnemyHUD
.ok1
	call CallBattleCore
	ld a, $1
	ld [hBGMapMode], a
	jr .not_asleep

.fast_asleep
	ld hl, FastAsleepText
	call StdBattleTextBox

	; Sleep Talk bypasses sleep.
	ld a, BATTLE_VARS_MOVE_ANIM
	call GetBattleVar
	cp SLEEP_TALK
	jr z, .not_asleep

	call CantMove
	jp EndTurn

.not_asleep
	ld a, BATTLE_VARS_STATUS
	call GetBattleVarAddr
	bit FRZ, [hl]
	jr z, .not_frozen

	; Flame Wheel, Sacred Fire, Scald, and Flare Blitz thaw the user.
	ld a, BATTLE_VARS_MOVE_ANIM
	call GetBattleVar
	cp FLAME_WHEEL
	jr z, .thaw
	cp SACRED_FIRE
	jr z, .thaw
	cp SCALD
	jr z, .thaw
	cp FLARE_BLITZ
	jr z, .thaw

	; Check for defrosting
	call BattleRandom
	cp 1 + (20 percent)
	jr c, .thaw
	ld hl, FrozenSolidText
	call StdBattleTextBox
	xor a
	ld [wNumHits], a
	ld de, ANIM_FRZ
	call FarPlayBattleAnimation

	call CantMove
	jp EndTurn

.thaw
	call BattleCommand_defrost

.not_frozen
	ld a, [hBattleTurn]
	and a
	jr nz, .enemy3
	ld hl, wPlayerDisableCount
	jr .ok3
.enemy3
	ld hl, wEnemyDisableCount
.ok3
	ld a, [hl]
	and a
	jr z, .not_disabled

	dec a
	ld [hl], a
	and $f
	jr nz, .not_disabled

	ld [hl], a
	ld a, [hBattleTurn]
	and a
	jr nz, .enemy4
	xor a
	ld [wDisabledMove], a
	jr .ok4
.enemy4
	xor a
	ld [wEnemyDisabledMove], a
.ok4
	ld hl, DisabledNoMoreText
	call StdBattleTextBox

.not_disabled
	ld a, BATTLE_VARS_SUBSTATUS3
	call GetBattleVar
	add a ; bit SUBSTATUS_CONFUSED, a
	jr nc, .not_confused
	ld a, [hBattleTurn]
	and a
	jr nz, .enemy5
	ld hl, wPlayerConfuseCount
	jr .ok5
.enemy5
	ld hl, wEnemyConfuseCount
.ok5
	dec [hl]
	jr nz, .confused

	ld a, BATTLE_VARS_SUBSTATUS3
	call GetBattleVarAddr
	res SUBSTATUS_CONFUSED, [hl]
	ld hl, ConfusedNoMoreText
	call StdBattleTextBox
	jr .not_confused

.confused
	ld hl, IsConfusedText
	call StdBattleTextBox
	xor a
	ld [wNumHits], a
	ld de, ANIM_CONFUSED
	call FarPlayBattleAnimation

	; 33% chance of hitting itself (updated from 50% in Gen VII)
	call BattleRandom
	cp 1 + (33 percent)
	jr nc, .not_confused

	; clear confusion-dependent substatus
	ld a, BATTLE_VARS_SUBSTATUS3
	call GetBattleVarAddr
	ld a, [hl]
	and 1 << SUBSTATUS_CONFUSED
	ld [hl], a

	call HitConfusion
	call CantMove
	jp EndTurn

.not_confused
	ld a, BATTLE_VARS_SUBSTATUS1
	call GetBattleVar
	add a ; bit SUBSTATUS_ATTRACT
	jr nc, .not_infatuated

	ld hl, InLoveWithText
	call StdBattleTextBox
	xor a
	ld [wNumHits], a
	ld de, ANIM_IN_LOVE
	call FarPlayBattleAnimation

	; 50% chance of infatuation
	call BattleRandom
	cp 1 + (50 percent)
	jr c, .not_infatuated

	ld hl, InfatuationText
	call StdBattleTextBox
	call CantMove
	jp EndTurn

.not_infatuated


	; Are we using a disabled move?
	ld a, [hBattleTurn]
	and a
	jr nz, .enemy6
	ld a, [wDisabledMove]
	ld hl, wCurPlayerMove
	jr .ok6
.enemy6
	ld a, [wEnemyDisabledMove]
	ld hl, wCurEnemyMove
.ok6
	and a
	jr z, .no_disabled_move ; can't disable a move that doesn't exist
	cp [hl]
	jr nz, .no_disabled_move

	call MoveDisabled
	call CantMove
	jp EndTurn

.no_disabled_move
	ld a, BATTLE_VARS_STATUS
	call GetBattleVarAddr
	bit PAR, [hl]
	ret z

	; 25% chance to be fully paralyzed
	call BattleRandom
	cp 1 + (25 percent)
	ret nc

	ld hl, FullyParalyzedText
	call StdBattleTextBox
	xor a
	ld [wNumHits], a
	ld de, ANIM_PAR
	call FarPlayBattleAnimation
	call CantMove
	; fallthrough


EndTurn:
	ld a, $1
	ld [wTurnEnded], a
	jp ResetDamage


OpponentCantMove:
	call CallOpponentTurn
CantMove:
	ld a, BATTLE_VARS_SUBSTATUS1
	call GetBattleVarAddr
	res SUBSTATUS_ROLLOUT, [hl]

	ld a, BATTLE_VARS_SUBSTATUS3
	call GetBattleVarAddr
	ld a, [hl]
	and $ff ^ (1<<SUBSTATUS_RAMPAGE + 1<<SUBSTATUS_CHARGED)
	ld [hl], a

	ld a, BATTLE_VARS_MOVE_ANIM
	call GetBattleVar
	cp FLY
	jr z, .fly_dig

	cp DIG
	ret nz

.fly_dig
	res SUBSTATUS_UNDERGROUND, [hl]
	res SUBSTATUS_FLYING, [hl]
	jp AppearUserRaiseSub


IncreaseMetronomeCount:
	; Don't arbitrarily boost usage counter twice on a turn
	call CheckUserIsCharging
	ret nz

	ld a, [hBattleTurn]
	and a
	ld de, wPlayerSelectedMove
	ld hl, wPlayerMetronomeCount
	jr z, .got_move_usage
	ld de, wEnemySelectedMove
	ld hl, wEnemyMetronomeCount
.got_move_usage
	ld a, [de]
	ld b, a
	ld a, BATTLE_VARS_MOVE
	call GetBattleVar
	cp b
	jr nz, .reset
	ld a, [hl]
	cp 5
	ret nc
	inc [hl]
	ret
.reset
	; Struggle doesn't update last move set but does reset count
	cp STRUGGLE
	jr z, .done_update_selected_move
	ld [de], a
.done_update_selected_move
	xor a
	ld [hl], a
	ret

CheckWhiteHerb:
	ld a, [hBattleTurn]
	ld b, a
	push bc
	call SetFastestTurn
	pop bc
	push bc
	call .do_it
	call SwitchTurn
	pop bc
	push bc
	call .do_it
	pop bc
	ld a, b
	ld [hBattleTurn], a
	ret

.do_it
	push bc
	call GetUserItemAfterUnnerve
	ld a, b
	pop bc
	cp HELD_WHITE_HERB
	jr z, .item_valid
	cp HELD_EJECT_PACK
	ret nz

.item_valid
	push bc
	call HasUserFainted
	pop bc
	ret z

	; Check if we have any reduced stat changes
	ld a, [hBattleTurn]
	and a
	ld hl, wPlayerStatLevels
	jr z, .got_stat_levels
	ld hl, wEnemyStatLevels
.got_stat_levels
	lb de, NUM_LEVEL_STATS, 0
.stat_loop
	ld a, [hl]
	cp BASE_STAT_LEVEL
	jr nc, .not_lowered
	push bc
	push de
	push hl
	call GetUserItemAfterUnnerve
	ld a, b
	pop hl
	pop de
	pop bc
	cp HELD_EJECT_PACK
	jr nz, .not_eject_pack

	ld a, [hBattleTurn]
	cp b
	ld a, 1 << SWITCH_DEFERRED | 1 << SWITCH_ITEM
	jr z, .move_user_switching
	ld a, 1 << SWITCH_DEFERRED | 1 << SWITCH_TARGET | 1 << SWITCH_OPPITEM
.move_user_switching
	jp SetDeferredSwitch

.not_eject_pack
	ld [hl], BASE_STAT_LEVEL
	ld e, 1
.not_lowered
	inc hl
	dec d
	jr nz, .stat_loop
	dec e
	ret nz
	farcall ItemRecoveryAnim
	call GetUserItem
	call GetCurItemName
	ld hl, RegainedStatsWithItem
	call StdBattleTextBox
	jp ConsumeUserItem

CheckThroatSpray:
	ld a, BATTLE_VARS_MOVE_ANIM
	call GetBattleVar
	ld hl, SoundMoves
	ld de, 1
	call IsInArray
	ret nc

	call GetUserItemAfterUnnerve
	ld a, b
	cp HELD_THROAT_SPRAY
	ret nz

	ld a, [wAttackMissed]
	and a
	ret nz

	ld b, c
	call BattleCommand_statup
	ld a, [wFailedMessage]
	and a
	ret nz
	call GetItemStatMessage
	jp ConsumeUserItem

CheckPowerHerb:
	call GetUserItemAfterUnnerve
	ld a, b
	cp HELD_POWER_HERB
	ret nz

	call GetCurItemName

	call HasUserFainted
	ret z

	ld a, BATTLE_VARS_SUBSTATUS3
	call GetBattleVar
	bit SUBSTATUS_CHARGED, a
	ret z

	farcall ItemRecoveryAnim
	call GetUserItem
	call GetCurItemName

	ld hl, BattleText_UserChargedWithItem
	call StdBattleTextBox
	call ConsumeUserItem
	jp ResetTurn

GetItemStatMessage:
	farcall ItemRecoveryAnim
	call GetCurItemName
	ld a, [wLoweredStat]
	and $f
	ld b, a
	inc b
	call GetStatName
	ld a, [wLoweredStat]
	and $f0
	ld hl, BattleText_ItemRaised
	jr z, .got_msg
	ld hl, BattleText_ItemSharplyRaised
.got_msg
	jp StdBattleTextBox

MoveDisabled: ; 3438d

	; Make sure any charged moves fail
	ld a, BATTLE_VARS_SUBSTATUS3
	call GetBattleVarAddr
	res SUBSTATUS_CHARGED, [hl]

	ld a, BATTLE_VARS_MOVE
	call GetBattleVar
	ld [wNamedObjectIndexBuffer], a
	call GetMoveName

	ld hl, DisabledMoveText
	jp StdBattleTextBox

; 343a5

HitConfusion: ; 343a5

	ld hl, HurtItselfText
	call StdBattleTextBox

	xor a
	ld [wCriticalHit], a

	call HitSelfInConfusion
	call ConfusedDamageCalc
	call BattleCommand_lowersub

	xor a
	ld [wNumHits], a

	; Flicker the monster pic unless flying or underground.
	ld de, ANIM_HIT_CONFUSION
	ld a, BATTLE_VARS_SUBSTATUS3_OPP
	call GetBattleVar
	and 1 << SUBSTATUS_FLYING | 1 << SUBSTATUS_UNDERGROUND
	call z, PlayFXAnimID

	ld a, [hBattleTurn]
	and a
	jr nz, .enemy
	ld hl, UpdatePlayerHUD
	call CallBattleCore
	ld a, $1
	ld [hBGMapMode], a
.enemy
	ld c, $1
	call TakeOpponentDamage
	jp BattleCommand_raisesub

; 343db


BattleCommand_checkobedience: ; 343db
; checkobedience

	; Enemy can't disobey
	ld a, [hBattleTurn]
	and a
	ret nz

	call CheckUserIsCharging
	ret nz

	; If we've already checked this turn
	ld a, [wAlreadyDisobeyed]
	and a
	ret nz

	xor a
	ld [wAlreadyDisobeyed], a

	; No obedience in link battles
	; (since no handling exists for enemy)
	ld a, [wLinkMode]
	and a
	ret nz

	ld a, [wInBattleTowerBattle]
	and a
	ret nz

	ld a, [wInitialOptions]
	bit TRADED_AS_OT_OPT, a
	ret nz

	; If the monster's id doesn't match the player's,
	; some conditions need to be met.
	ld a, MON_ID
	call BattlePartyAttr
	ld a, [wPlayerID]
	cp [hl]
	jr nz, .obeylevel
	inc hl
	ld a, [wPlayerID + 1]
	cp [hl]
	ret z

.obeylevel
	; The maximum obedience level is constrained by owned badges:
	ld hl, wJohtoBadges

	; risingbadge
	bit RISINGBADGE, [hl]
	ld a, MAX_LEVEL + 1
	jr nz, .getlevel

	; mineralbadge
	bit MINERALBADGE, [hl]
	ld a, 70
	jr nz, .getlevel

	; fogbadge
	bit FOGBADGE, [hl]
	ld a, 50
	jr nz, .getlevel

	; hivebadge
	bit HIVEBADGE, [hl]
	ld a, 30
	jr nz, .getlevel

	; zephyrbadge
	bit ZEPHYRBADGE, [hl]
	ld a, 20
	jr nz, .getlevel

	; no badges
	ld a, 10


.getlevel
; c = obedience level
; d = monster level
; b = c + d

	ld b, a
	ld c, a

	ld a, [wBattleMonLevel]
	ld d, a

	add b
	ld b, a

; No overflow (this should never happen)
	jr nc, .checklevel
	ld b, $ff


.checklevel
; If the monster's level is lower than the obedience level, it will obey.
	ld a, c
	cp d
	ret nc


; Random number from 0 to obedience level + monster level
.rand1
	call BattleRandom
	swap a
	cp b
	jr nc, .rand1

; The higher above the obedience level the monster is,
; the more likely it is to disobey.
	cp c
	ret c

; Sleep-only moves have separate handling, and a higher chance of
; being ignored. Lazy monsters like their sleep.
	call IgnoreSleepOnly
	ret c


; Another random number from 0 to obedience level + monster level
.rand2
	call BattleRandom
	cp b
	jr nc, .rand2

; A second chance.
	cp c
	jr c, .UseInstead


; No hope of using a move now.

; b = number of levels the monster is above the obedience level
	ld a, d
	sub c
	ld b, a

; The chance of napping is the difference out of 256.
	call BattleRandom
	swap a
	sub b
	jr c, .Nap

; The chance of not hitting itself is the same.
	cp b
	jr nc, .DoNothing

	ld hl, WontObeyText
	call StdBattleTextBox
	call HitConfusion
	jp .EndDisobedience


.Nap:
	call BattleRandom
	add a
	swap a
	and SLP
	jr z, .Nap

	ld [wBattleMonStatus], a

	ld hl, BeganToNapText
	jr .Print


.DoNothing:
	call BattleRandom
	and %11

	ld hl, LoafingAroundText
	and a
	jr z, .Print

	ld hl, WontObeyText
	dec a
	jr z, .Print

	ld hl, TurnedAwayText
	dec a
	jr z, .Print

	ld hl, IgnoredOrdersText

.Print:
	call StdBattleTextBox
	jp .EndDisobedience


.UseInstead:

; Can't use another move if the monster only has one!
	ld a, [wBattleMonMoves + 1]
	and a
	jr z, .DoNothing

; Don't bother trying to handle Disable.
	ld a, [wDisabledMove]
	and a
	jr nz, .DoNothing


	ld hl, wBattleMonPP
	ld de, wBattleMonMoves
	lb bc, 0, NUM_MOVES

.GetTotalPP:
	ld a, [hli]
	and $3f ; exclude pp up
	add b
	ld b, a

	dec c
	jr z, .CheckMovePP

; Stop at undefined moves.
	inc de
	ld a, [de]
	and a
	jr nz, .GetTotalPP


.CheckMovePP:
	ld hl, wBattleMonPP
	ld a, [wCurMoveNum]
	ld e, a
	ld d, 0
	add hl, de

; Can't use another move if only one move has PP.
	ld a, [hl]
	and $3f
	cp b
	jr z, .DoNothing


; Make sure we can actually use the move once we get there.
	ld a, 1
	ld [wAlreadyDisobeyed], a

	ld a, [w2DMenuNumRows]
	ld b, a

; Save the move we originally picked for afterward.
	ld a, [wCurMoveNum]
	ld c, a
	push af


.RandomMove:
	call BattleRandom
	and %11 ; NUM_MOVES - 1

	cp b
	jr nc, .RandomMove

; Not the move we were trying to use.
	cp c
	jr z, .RandomMove

; Make sure it has PP.
	ld [wCurMoveNum], a
	ld hl, wBattleMonPP
	ld e, a
	ld d, 0
	add hl, de
	ld a, [hl]
	and $3f
	jr z, .RandomMove


; Use it.
	ld a, [wCurMoveNum]
	ld c, a
	ld b, 0
	ld hl, wBattleMonMoves
	add hl, bc
	ld a, [hl]
	ld [wCurPlayerMove], a

	call SetPlayerTurn
	call UpdateMoveData
	call DoMove


; Restore original move choice.
	pop af
	ld [wCurMoveNum], a


.EndDisobedience:
	xor a
	ld [wLastPlayerMove], a
	ld [wLastEnemyCounterMove], a

	; Break Encore too.
	ld hl, wPlayerSubStatus2
	res SUBSTATUS_ENCORED, [hl]
	xor a
	ld [wPlayerEncoreCount], a

	jp EndMoveEffect

; 3451f


IgnoreSleepOnly: ; 3451f

	ld a, BATTLE_VARS_MOVE_ANIM
	call GetBattleVar

	cp SLEEP_TALK
	jr z, .CheckSleep
	and a
	ret

.CheckSleep:
	ld a, BATTLE_VARS_STATUS
	call GetBattleVar
	and SLP
	ret z

; 'ignored orders…sleeping!'
	ld hl, IgnoredSleepingText
	call StdBattleTextBox

	call EndMoveEffect

	scf
	ret

; 34541


BattleCommand_usedmovetext: ; 34541
; usedmovetext
	farjp DisplayUsedMoveText

; 34548


CheckUserIsCharging:
	ld a, [hBattleTurn]
	and a
	ld a, [wPlayerCharging]
	jr z, .end
	ld a, [wEnemyCharging]
.end
	and a
	ret

BattleCommand_doturn:
	call CheckUserIsCharging
	ret nz

	ld a, [hBattleTurn]
	and a
	ld hl, wPlayerTurnsTaken
	jr z, .got_turns_taken
	ld hl, wEnemyTurnsTaken
.got_turns_taken
	; If we've gotten this far, this counts as a turn.
	inc [hl]
	ld a, [hl]
	and a
	jr nz, .no_overflow
	dec [hl]
.no_overflow
	; Consume PP
	call BattleConsumePP
	ret nz

	; Out of PP
	call BattleCommand_movedelay

	; Different message if continuous
	ld a, BATTLE_VARS_MOVE_EFFECT
	call GetBattleVar
	ld hl, .continuousmoves
	ld de, 1
	call IsInArray

	ld hl, HasNoPPLeftText
	jr c, .print
	ld hl, NoPPLeftText
.print
	call StdBattleTextBox
	jp EndMoveEffect

.continuousmoves ; 34602
	db EFFECT_SOLAR_BEAM
	db EFFECT_FLY
	db EFFECT_ROLLOUT
	db EFFECT_RAMPAGE
	db $ff
; 3460b

BattleCommand_hastarget:
	; If the target is fainted, abort the move
	call HasOpponentFainted
	jr nz, .not_fainted

	ld hl, ButItFailedText
	call StdBattleTextBox
	jp EndMoveEffect

.not_fainted
	; Handle Pressure
	ld a, BATTLE_VARS_ABILITY_OPP
	call GetBattleVar
	cp PRESSURE
	ret nz
	; fallthrough
BattleConsumePP:
; Also used by DoTurn: return z if user has no PP left
	call CheckUserIsCharging
	ret nz

	ld a, BATTLE_VARS_MOVE
	call GetBattleVar
	cp STRUGGLE
	jr z, .end

	ld a, BATTLE_VARS_SUBSTATUS3
	call GetBattleVar
	and 1 << SUBSTATUS_IN_LOOP | 1 << SUBSTATUS_RAMPAGE
	ret nz

	ld a, [hBattleTurn]
	and a
	ld a, [wCurPartyMon]
	ld bc, wCurMoveNum
	ld de, wBattleMonPP
	ld hl, wPartyMon1PP
	jr z, .set_party_pp
	ld a, [wCurOTMon]
	ld bc, wCurEnemyMoveNum
	ld de, wEnemyMonPP
	ld hl, wOTPartyMon1PP
.set_party_pp
	call GetPartyLocation
.pp_vars_ok
	ld a, [bc]
	ld c, a
	ld b, 0
	add hl, bc

	; Swap de and hl
	push de
	ld d, h
	ld e, l
	pop hl

	add hl, bc
	ld a, [hl]
	and $3f
	ret z
	dec [hl]
	ld a, BATTLE_VARS_SUBSTATUS2
	call GetBattleVar
	and SUBSTATUS_TRANSFORMED
	ret nz
	ld a, [hl]
	ld [de], a
.end
	or 1
	ret

BattleCommand_critical: ; 34631
; critical

; Determine whether this attack's hit will be critical.

	xor a
	ld [wCriticalHit], a

	ld a, BATTLE_VARS_MOVE_POWER
	call GetBattleVar
	and a
	ret z

	call GetOpponentAbilityAfterMoldBreaker
	cp BATTLE_ARMOR
	ret z
	cp SHELL_ARMOR
	ret z
	ld a, [hBattleTurn]
	and a
	jr nz, .EnemyTurn

	ld hl, wBattleMonItem
	ld a, [wBattleMonSpecies]
	jr .Item

.EnemyTurn:
	ld hl, wEnemyMonItem
	ld a, [wEnemyMonSpecies]

.Item:
	ld c, 0

	cp CHANSEY
	jr nz, .Farfetchd
	ld a, [hl]
	cp LUCKY_PUNCH
	jr nz, .FocusEnergy

; +2 critical level
	ld c, 2
	jr .FocusEnergy

.Farfetchd:
	cp FARFETCH_D
	jr nz, .FocusEnergy
	ld a, [hl]
	cp STICK
	jr nz, .FocusEnergy

; +2 critical level
	ld c, 2
	; fallthrough

.FocusEnergy:
	ld a, BATTLE_VARS_SUBSTATUS4
	call GetBattleVar
	bit SUBSTATUS_FOCUS_ENERGY, a
	jr z, .CheckCritical

; +2 critical level
	inc c
	inc c

.CheckCritical:
	ld a, BATTLE_VARS_MOVE_ANIM
	call GetBattleVar
	ld de, 1
	ld hl, .Criticals
	push bc
	call IsInArray
	pop bc
	jr nc, .ScopeLens

; +1 critical level
	inc c

.ScopeLens:
	push bc
	call GetUserItem
	ld a, b
	cp HELD_CRITICAL_UP ; Increased critical chance (Scope Lens and Razor Claw)
	pop bc
	jr nz, .Ability

; +1 critical level
	inc c

.Ability:
	ld a, BATTLE_VARS_ABILITY
	call GetBattleVar
	cp SUPER_LUCK
	jr nz, .Tally

; +1 critical level
	inc c

.Tally:
	; Check for c > 2 which always crits
	ld a, c
	cp 3
	jr nc, .guranteed_crit
	ld hl, .Chances
	ld b, 0
	add hl, bc
	call BattleRandom
	cp [hl]
	ret nc
.guranteed_crit
	ld a, 1
	ld [wCriticalHit], a
	ret

.Criticals:
	db KARATE_CHOP
	db RAZOR_LEAF
	db CRABHAMMER
	db SLASH
	db AEROBLAST
	db CROSS_CHOP
	db SHADOW_CLAW
	db STONE_EDGE
	db $ff

.Chances:
	; 4.17% 12.5%  50%   100%
	db $a,  $20,  $80,  $ff
	;   0     1     2     3+
; 346b2


BattleCommand_triplekick: ; 346b2
; triplekick

	ld a, [wKickCounter]
	ld b, a
	inc b
	ld hl, wCurDamage + 1
	ld a, [hld]
	ld e, a
	ld a, [hli]
	ld d, a
.next_kick
	dec b
	ret z
	ld a, [hl]
	add e
	ld [hld], a
	ld a, [hl]
	adc d
	ld [hli], a

; No overflow.
	jr nc, .next_kick
	ld a, $ff
	ld [hld], a
	ld [hl], a
	ret

CheckAirBalloon:
; Returns z if the user is holding an Air Balloon
	push bc
	push hl
	call GetOpponentItem
	pop hl
	ld a, b
	pop bc
	cp HELD_AIR_BALLOON
	ret

BattleCommand_kickcounter: ; 346cd
; kickcounter

	ld hl, wKickCounter
	inc [hl]
	ret

; 346d2


BattleCommand_stab: ; 346d2
; STAB = Same Type Attack Bonus
; Also handles type matchups and fire/water in sun/rain
; Uses an one-byte var to finally use for damage calculation. Max/min listed in case
; future extension is done to keep potential overflow/rounding errors in mind.
; Min value: $02 (quad-resist, no STAB, bad weather modifier)
; Base value: $10
; Max value: $c0 (quad-weak, STAB, good weather modifier
	; Struggle doesn't apply STAB or matchups
	ld a, BATTLE_VARS_MOVE_ANIM
	call GetBattleVar
	cp STRUGGLE
	ret z

	; Apply type matchups
	call BattleCheckTypeMatchup
	; Store wTypeModifier (handles effectiveness)
	ld a, [wTypeMatchup]
	ld [wTypeModifier], a
	and a
	jr nz, .not_immune
	; Immunities are treated as we missing and dealing 0 damage
	ld hl, wCurDamage
	xor a
	ld [hli], a
	ld [hl], a
	; wAttackMissed being nonzero can mean special immunity, so avoid overriding it
	ld a, [wAttackMissed]
	and a
	ret nz
	ld a, 1
	ld [wAttackMissed], a
	ret

.not_immune
	; Apply STAB
	ld a, BATTLE_VARS_MOVE_TYPE
	call GetBattleVar
	ld b, a
	ld a, [hBattleTurn]
	and a
	ld hl, wBattleMonType1
	jr z, .got_attacker_types
	ld hl, wEnemyMonType1
.got_attacker_types
	ld a, [hli]
	cp b
	jr z, .stab
	ld a, [hl]
	cp b
	jr nz, .stab_done
.stab
	; Adaptability gives 2x, otherwise STAB is 1.5x
	ld a, BATTLE_VARS_ABILITY
	call GetBattleVar
	cp ADAPTABILITY
	ld a, [wTypeMatchup]
	jr nz, .no_adaptability
	sla a
	ld [wTypeMatchup], a
	jr .stab_done
.no_adaptability
	ld b, a
	srl b
	add b
	ld [wTypeMatchup], a

.stab_done
	; Apply weather modifiers
	ld a, BATTLE_VARS_MOVE_TYPE
	call GetBattleVar
	ld b, a
	farcall DoWeatherModifiers

	; Now calculate the damage changes with the modifiers in mind.
	ld a, [wTypeMatchup]
	ld [hMultiplier], a
	xor a
	ld [hMultiplicand + 0], a
	ld hl, wCurDamage
	ld a, [hli]
	ld [hMultiplicand + 1], a
	ld a, [hld]
	ld [hMultiplicand + 2], a
	call Multiply

	; Second ability pass
	push hl
	farcall ApplyDamageAbilities_AfterTypeMatchup
	pop hl

	ld a, $10
	ld [hDivisor], a
	ld b, 4
	call Divide

	; Store in curDamage
	ld a, [hMultiplicand]
	and a
	jr z, .damage_ok

	; Store $ffff
	ld a, $ff
	ld [hli], a
	ld [hl], a
	ret

.damage_ok
	ld a, [hMultiplicand + 1]
	ld [hli], a
	ld b, a
	ld a, [hMultiplicand + 2]
	ld [hl], a
	or b
	ret nz

	; damage ended up 0, so set it to 1
	inc a
	ld [hl], a
	ret

CheckAirborneAfterMoldBreaker:
	push de
	call SwitchTurn
	call GetOpponentAbilityAfterMoldBreaker
	ld b, a
	call SwitchTurn
	jr CheckAirborne_GotAbility
CheckAirborne:
	push de
	ld a, BATTLE_VARS_ABILITY
	call GetBattleVar
	ld b, a
CheckAirborne_GotAbility:
; d=1: Skip type checks (used for Inverse Battle Ground->Flying matchup)
; Returns a=0 and z if grounded. Returns nz if not.
; a contains ATKFAIL_MISSED for air balloon, ATKFAIL_IMMUNE for flying type,
; ATKFAIL_ABILITY for Levitate.
	push bc

	; Check Iron Ball
	call GetUserItemAfterUnnerve
	ld a, b
	cp HELD_IRON_BALL
	pop bc
	ld c, a
	ld a, 0
	pop de
	ret z

	; d=1 (inverse matchup checks) skips hardcoded immunity check
	ld a, d
	and a
	jr nz, .typecheck_done
	push bc
	call CheckIfUserIsFlyingType
	pop bc
	ld a, ATKFAIL_IMMUNE
	jr z, .airborne
.typecheck_done
	ld a, c
	cp HELD_AIR_BALLOON
	ld a, ATKFAIL_MISSED
	jr z, .airborne
	ld a, b
	cp LEVITATE
	ld a, ATKFAIL_ABILITY
	jr z, .airborne
	xor a
.airborne
	and a
	ret

BattleCheckTypeMatchup:
	ld a, [hBattleTurn]
	and a
	ld hl, wEnemyMonType1
	jr z, CheckTypeMatchup
	ld hl, wBattleMonType1
	; fallthrough
CheckTypeMatchup:
; Wrapper that handles ability immunities, because type matchups take predecence,
; this matters for Ground pokémon with Lightning Rod (and Trace edge-cases).
; Yes, Lightning Rod is useless on ground types since GSC has no doubles.
	push hl
	push de
	push bc
	call _CheckTypeMatchup
	; if the attack is ineffective, bypass ability checks
	ld a, [wTypeMatchup]
	and a
	jr z, .end

	; check Ground-type attacks
	ld a, BATTLE_VARS_MOVE_TYPE
	call GetBattleVar
	cp GROUND
	jr nz, .done_ground_type

	call SwitchTurn
	ld a, [wBattleType]
	cp BATTLETYPE_INVERSE
	ld d, 1
	jr z, .check_airborne
	ld d, 0
.check_airborne
	call CheckAirborneAfterMoldBreaker
	push af
	call SwitchTurn
	pop af
	jr z, .done_ground_type
	cp ATKFAIL_ABILITY
	jr nz, .no_levitate
	ld [wAttackMissed], a

.no_levitate
	xor a
	ld [wTypeMatchup], a

.done_ground_type
	farcall CheckNullificationAbilities
.end
	pop bc
	pop de
	pop hl
	ret

_CheckTypeMatchup: ; 347d3
	push hl
	ld de, 1 ; IsInArray checks below use single-byte arrays
; Handle powder moves
	ld a, BATTLE_VARS_MOVE_ANIM
	call GetBattleVar
	ld hl, PowderMoves
	call IsInArray
	jr nc, .skip_powder
	call GetOpponentItemAfterUnnerve
	ld a, b
	cp HELD_SAFETY_GOGGLES
	jp z, .Immune
	pop hl
	push hl
	ld a, [hli]
	cp GRASS
	jp z, .Immune
	ld a, [hl]
	cp GRASS
	jp z, .Immune
	call GetOpponentAbilityAfterMoldBreaker
	cp OVERCOAT
	jp z, .AbilImmune
.skip_powder
	pop hl
	push hl
	ld a, BATTLE_VARS_MOVE_TYPE
	call GetBattleVar
	ld d, a
	ld a, BATTLE_VARS_ABILITY
	call GetBattleVar
	cp PIXILATE
	jr nz, .no_pixilate
	ld a, NORMAL
	cp d
	jr nz, .no_pixilate
	ld d, FAIRY
.no_pixilate
	ld b, [hl]
	inc hl
	ld c, [hl]
	ld a, $10 ; 1.0
	ld [wTypeMatchup], a
	ld hl, InverseTypeMatchup
	ld a, [wBattleType]
	cp BATTLETYPE_INVERSE
	jr z, .TypesLoop
	ld hl, TypeMatchup
.TypesLoop:
	ld a, [hli]
	; terminator
	cp $ff
	jr z, .End
	cp $fe
	jr nz, .Next
	; stuff beyond this point is ignored if the foe is identified or we have Scrappy
	ld a, BATTLE_VARS_SUBSTATUS1_OPP
	call GetBattleVar
	bit SUBSTATUS_IDENTIFIED, a
	jr nz, .End
	ld a, BATTLE_VARS_ABILITY
	call GetBattleVar
	cp SCRAPPY
	jp z, .End
	jr .TypesLoop

.Next:
	; attacking type
	cp d
	jr nz, .Nope
	ld a, [hli]
	; defending types
	cp b
	jr z, .Yup
	cp c
	jr z, .Yup
	jr .Nope2

.Nope:
	inc hl
.Nope2:
	inc hl
	jr .TypesLoop

.Yup:
	; no need to continue if we encountered a 0x matchup
	ld a, [hli]
	and a
	jr z, .RingTarget
	cp SUPER_EFFECTIVE
	jr z, .se
	cp NOT_VERY_EFFECTIVE
	jr z, .nve
	jr .TypesLoop
.se
	ld a, [wTypeMatchup]
	sla a
	ld [wTypeMatchup], a
	jr .TypesLoop
.nve
	ld a, [wTypeMatchup]
	srl a
	ld [wTypeMatchup], a
	jr .TypesLoop

.RingTarget:
	; if opponent is holding Ring Target, ignore type-based immunity
	push hl
	call GetOpponentItemAfterUnnerve
	pop hl
	ld a, b
	cp HELD_RING_TARGET
	jr z, .TypesLoop
	jr .Immune
.AbilImmune:
	; most abilities are checked seperately, but Overcoat ends up here (powder)
	ld a, 3
	ld [wAttackMissed], a
.Immune:
	xor a
	ld [wTypeMatchup], a
.End:
	pop hl
	ret

; 34833

BattleCommand_checkpowder:
	ld de, 1
	ld a, BATTLE_VARS_MOVE_ANIM
	call GetBattleVar
	cp THUNDER_WAVE
	jr z, .twave
	ld hl, PowderMoves
	call IsInArray
	ret nc
	jr BattleCommand_resettypematchup
.twave
	call CheckIfTargetIsGroundType
	jr nz, BattleCommand_resettypematchup
	call GetOpponentItemAfterUnnerve
	ld a, b
	cp HELD_RING_TARGET
	ret z
	; fallthrough
BattleCommand_resettypematchup: ; 34833
; Reset the type matchup multiplier to 1.0, if the type matchup is not 0.
; If there is immunity in play, the move automatically misses.
	call BattleCheckTypeMatchup
	ld a, [wTypeMatchup]
	and a
	ld a, $10 ; 1.0
	jr nz, .reset
	call ResetDamage
	xor a
	ld [wTypeModifier], a
	inc a
	ld [wAttackMissed], a
	ret

.reset
	ld [wTypeMatchup], a
	ret

; 3484e

INCLUDE "engine/battle/ai/switch.asm"

INCLUDE "data/types/type_matchups.asm"
INCLUDE "data/types/inverse_type_matchups.asm"


BattleCommand_damagevariation: ; 34cfd
; damagevariation

; Modify the damage spread between 85% and 100%.

; Because of the method of division the probability distribution
; is not consistent. This makes the highest damage multipliers
; rarer than normal.


; No point in reducing 1 or 0 damage.
	ld hl, wCurDamage
	ld a, [hli]
	and a
	jr nz, .go
	ld a, [hl]
	cp 2
	ret c

.go
	; Start with the current (100%) damage.
	xor a
	ld [hMultiplicand + 0], a
	dec hl
	ld a, [hli]
	ld [hMultiplicand + 1], a
	ld a, [hl]
	ld [hMultiplicand + 2], a

	; Multiply by 85-100%...
	ld a, 16
	call BattleRandomRange
	add 85
	ld [hMultiplier], a
	call Multiply

	; ...divide by 100%...
	ld a, 100
	ld [hDivisor], a
	ld b, $4
	call Divide

	; ...to get .85-1.00x damage.
	ld a, [hQuotient + 1]
	ld hl, wCurDamage
	ld [hli], a
	ld a, [hQuotient + 2]
	ld [hl], a
	ret

BattleCommand_bounceback:
; Possibly bounce back an attack with Magic Bounce, or don't do anything if opponent is
; immune due to Prankster.
	ld a, BATTLE_VARS_ABILITY
	call GetBattleVar
	cp PRANKSTER
	jr nz, .prankster_done
	call CheckIfTargetIsDarkType
	jr nz, .prankster_done
	xor a
	ld [wTypeMatchup], a
	ld [wTypeModifier], a
	ld hl, wAttackMissed
	or [hl]
	ret nz
	inc [hl]
	ret

.prankster_done
	call GetOpponentAbilityAfterMoldBreaker
	cp MAGIC_BOUNCE
	ret nz

	; Someone behind Protect will not bounceback
	ld a, [wAttackMissed]
	cp 2
	ret z

	; Some moves bypass Substitute
	ld de, 1
	ld hl, SubstituteBypassMoves
	call IsInArray
	jr c, .sub_ok

	; Otherwise, Substitute blocks it
	call CheckSubstituteOpp
	ret nz

.sub_ok
	; No infinite bouncing
	ld a, BATTLE_VARS_SUBSTATUS2
	call GetBattleVar
	bit SUBSTATUS_MAGIC_BOUNCE, a
	ret nz

	ld a, BATTLE_VARS_MOVE
	call GetBattleVar
	ld b, a
	push bc
	call SwitchTurn

	; Store old move and replace with the bounced move
	ld a, BATTLE_VARS_MOVE
	call GetBattleVarAddr
	ld a, [hl]
	pop bc
	ld [hl], b
	push af

	farcall ShowAbilityActivation

	; Flag the bouncing
	ld a, BATTLE_VARS_SUBSTATUS2
	call GetBattleVarAddr
	set SUBSTATUS_MAGIC_BOUNCE, [hl]

	; Invert who went first
	ld a, [wEnemyGoesFirst]
	xor 1
	ld [wEnemyGoesFirst], a

	; Do the move
	call UpdateMoveData
	call ResetTurn

	; Restore old data
	ld a, [wEnemyGoesFirst]
	xor 1
	ld [wEnemyGoesFirst], a

	ld a, BATTLE_VARS_SUBSTATUS2
	call GetBattleVarAddr
	res SUBSTATUS_MAGIC_BOUNCE, [hl]

	ld a, BATTLE_VARS_MOVE
	call GetBattleVarAddr
	pop af
	ld [hl], a
	call UpdateMoveData
	jp SwitchTurn


BattleCommand_checkhit:
	call .DreamEater
	ld a, ATKFAIL_IMMUNE
	jp z, .Miss_skipset

	call .Protect
	ld a, ATKFAIL_PROTECT
	jp nz, .Miss_skipset

	call .Substitute
	ld a, ATKFAIL_GENERIC
	jp nz, .Miss_skipset

	call .PursuitCheck
	ret z

	call .PoisonTypeUsingToxic
	ret z

	call .NoGuardCheck
	ret z

	call .FlyDigMoves
	jp nz, .Miss

	call .LockOn
	ret nz

	call .WeatherAccCheck
	ret z

	call .AntiMinimize
	ret z

	; Perfect-accuracy moves
	ld a, BATTLE_VARS_MOVE_EFFECT
	call GetBattleVar
	cp EFFECT_ALWAYS_HIT
	ret z
	cp EFFECT_ROAR
	ret z
	ld a, BATTLE_VARS_MOVE_ANIM
	call GetBattleVar
	cp STRUGGLE
	ret z

	; Immunity might be set already from Prankster
	ld a, [wTypeModifier]
	and a
	ret z

	; Now doing usual accuracy check
	ld a, [wPlayerAccLevel]
	ld b, a
	ld a, [wEnemyEvaLevel]
	ld c, a
	ld a, [hBattleTurn]
	and a
	jr z, .got_acc_eva
	ld a, [wEnemyAccLevel]
	ld b, a
	ld a, [wPlayerEvaLevel]
	ld c, a

.got_acc_eva
	; Handle stat modifiers
	; Unaware ignores enemy stat changes, identification also does if above 0
	ld a, BATTLE_VARS_ABILITY
	call GetBattleVar
	cp UNAWARE
	jr z, .reset_evasion

	; check Foresight
	ld a, BATTLE_VARS_SUBSTATUS1_OPP
	call GetBattleVar
	bit SUBSTATUS_IDENTIFIED, a
	jr nz, .avoid_evasion_boost
	ld a, BATTLE_VARS_ABILITY
	call GetBattleVar
	cp KEEN_EYE
	jr nz, .check_opponent_unaware
.avoid_evasion_boost
	ld a, c
	cp 7
	jr c, .check_opponent_unaware
.reset_evasion
	ld c, 7
.check_opponent_unaware
	call GetOpponentAbilityAfterMoldBreaker
	cp UNAWARE
	jr nz, .no_opponent_unaware
	ld b, 7

.no_opponent_unaware
	; The way accuracy and evasion is combined
	; from generation III onwards is a bit unintuitive.
	; Instead of calcing them seperately, they
	; are both combined additively. For example,
	; acc-3 and eva+3 is 3/9, not 3/12. In addition,
	; the change is capped at -6 or +6
	ld a, 6
	add b
	sub c
	jr nc, .min_acc_ok
	xor a
.min_acc_ok
	sub 12
	jr c, .max_acc_ok
	xor a
.max_acc_ok
	add 13
	ld b, a
	xor a
	ld [hMultiplicand + 0], a
	ld [hMultiplicand + 1], a
	ld a, BATTLE_VARS_MOVE_ACCURACY
	call GetBattleVar
	ld [hMultiplicand + 2], a

	ld hl, hMultiplier

	; Apply stat changes
	call DoStatChangeMod
	add $11
	call ApplyDamageMod
	farcall ApplyAccuracyAbilities

	; Check user items
	call GetUserItemAfterUnnerve
	ld a, b
	cp HELD_ACCURACY_BOOST
	jr z, .accuracy_boost_item
	cp HELD_ZOOM_LENS
	jr nz, .done_user_items
	call CheckOpponentWentFirst
	jr z, .done_user_items
.accuracy_boost_item
	ld a, c
	call ApplyDamageMod

.done_user_items
	; Check opponent items
	call GetOpponentItemAfterUnnerve
	ld a, b
	cp HELD_BRIGHTPOWDER
	jr nz, .brightpowder_done
	ld a, c
	call ApplyDamageMod
.brightpowder_done
	; Accuracy modifiers done. Grab data
	; from hMultiplicand
	ld a, [hMultiplicand + 0]
	ld b, a
	ld a, [hMultiplicand + 1]
	or b
	ret nz ; final acc ended up >=100%
	ld a, [hMultiplicand + 2]
	ld b, a
	ld a, 100
	call BattleRandomRange
	cp b
	ret c

.Miss:
; Keep the damage value intact if we're using (Hi) Jump Kick.
	ld a, ATKFAIL_MISSED
.Miss_skipset:
; Used to set a special value to wAttackMissed for message customization
	ld [wAttackMissed], a
	ld a, BATTLE_VARS_MOVE_EFFECT
	call GetBattleVar
	cp EFFECT_JUMP_KICK
	call nz, ResetDamage
	ret

.DreamEater:
; Return z if we're trying to eat the dream of
; a monster that isn't sleeping.
	ld a, BATTLE_VARS_MOVE_EFFECT
	call GetBattleVar
	cp EFFECT_DREAM_EATER
	ret nz

	ld a, BATTLE_VARS_STATUS_OPP
	call GetBattleVar
	and SLP
	ret

.Protect:
; Return nz if the opponent is protected.
	ld a, BATTLE_VARS_SUBSTATUS1_OPP
	call GetBattleVar
	bit SUBSTATUS_PROTECT, a
	ret

.Substitute:
; Return nz if the opponent is behind a Substitute for certain moves
	call CheckSubstituteOpp
	jr z, .not_blocked
	ld a, BATTLE_VARS_MOVE_ANIM
	call GetBattleVar
	cp SWAGGER
	jr z, .blocked
	ld a, BATTLE_VARS_MOVE_EFFECT
	call GetBattleVar
	cp EFFECT_TRAP
	jr z, .blocked
.not_blocked
	xor a
	and a
	ret
.blocked
	ld a, 1
	and a
	ret


.LockOn:
; Return nz if we are locked-on and aren't trying to use Earthquake
; or Magnitude on a monster that is flying.
	ld a, BATTLE_VARS_SUBSTATUS2_OPP
	call GetBattleVarAddr
	bit SUBSTATUS_LOCK_ON, [hl]
	res SUBSTATUS_LOCK_ON, [hl]
	ret z

	ld a, BATTLE_VARS_SUBSTATUS3_OPP
	call GetBattleVar
	bit SUBSTATUS_FLYING, a
	jr z, .LockedOn

	ld a, BATTLE_VARS_MOVE_ANIM
	call GetBattleVar

	cp EARTHQUAKE
	ret z
	cp MAGNITUDE
	ret z

.LockedOn:
	ld a, 1
	and a
	ret


.PoisonTypeUsingToxic:
; Return z if we are a Poison-type using Toxic.
	call CheckIfUserIsPoisonType
	ret nz
	ld a, BATTLE_VARS_MOVE_ANIM
	call GetBattleVar
	cp TOXIC
	ret

.PursuitCheck:
; Pursuit used when a foe is switching always hits
	ld a, BATTLE_VARS_MOVE_EFFECT
	call GetBattleVar
	cp EFFECT_PURSUIT
	ret nz

	ld a, [wDeferredSwitch]
	and a
	jr nz, .pursuit_hits
	or 1
	ret
.pursuit_hits
	xor a
	ret

.FlyDigMoves:
; Check for moves that can hit underground/flying opponents.
; Return z if the current move can hit the opponent.

	ld a, BATTLE_VARS_SUBSTATUS3_OPP
	call GetBattleVar
	and 1 << SUBSTATUS_FLYING | 1 << SUBSTATUS_UNDERGROUND
	ret z

	bit SUBSTATUS_FLYING, a
	jr z, .DigMoves

	ld a, BATTLE_VARS_MOVE_ANIM
	call GetBattleVar

	cp GUST
	ret z
	cp THUNDER
	ret z
	cp HURRICANE
	ret

.DigMoves:
	ld a, BATTLE_VARS_MOVE_ANIM
	call GetBattleVar

	cp EARTHQUAKE
	ret z
	cp MAGNITUDE
	ret


.WeatherAccCheck:
; Returns z if the move used always hits in the current weather
	call GetWeatherAfterCloudNine
	cp WEATHER_RAIN
	jr z, .RainAccCheck
	cp WEATHER_HAIL
	jr z, .HailAccCheck
	ret

.RainAccCheck:
	ld a, BATTLE_VARS_MOVE_ANIM
	call GetBattleVar

	cp THUNDER
	ret z
	cp HURRICANE
	ret

.HailAccCheck:
	ld a, BATTLE_VARS_MOVE_ANIM
	call GetBattleVar

	cp BLIZZARD
	ret

.NoGuardCheck:
	ld a, [wPlayerAbility]
	cp NO_GUARD
	ret z
	ld a, [wEnemyAbility]
	cp NO_GUARD
	ret

.AntiMinimize:
	ld a, [hBattleTurn]
	and a
	ld hl, wPlayerMinimized
	jr z, .got_minimize
	ld hl, wEnemyMinimized
.got_minimize
	ld a, [hl]
	and a
	jr z, .no_minimize
	ld a, BATTLE_VARS_MOVE_ANIM
	call GetBattleVar
	cp BODY_SLAM
	ret z
	cp STOMP
	ret z
.no_minimize
	or 1
	ret

BattleCommand_effectchance: ; 34ecc
; effectchance
	push bc
	push hl
	xor a
	ld [wEffectFailed], a
	call CheckSubstituteOpp
	jr nz, .failed

	call GetOpponentAbilityAfterMoldBreaker
	cp SHIELD_DUST
	jr z, .failed

	ld hl, wPlayerMoveStruct + MOVE_CHANCE
	ld a, [hBattleTurn]
	and a
	jr z, .got_move_chance
	ld hl, wEnemyMoveStruct + MOVE_CHANCE
.got_move_chance

	ld a, [hl]
	ld b, a
	ld a, BATTLE_VARS_ABILITY
	call GetBattleVar
	cp SHEER_FORCE
	jr z, .failed
	cp SERENE_GRACE
	jr nz, .skip_serene_grace
	sla b
	jr c, .end ; Carry means the effect byte overflowed, so gurantee it

.skip_serene_grace
	ld a, 100
	call BattleRandomRange
	cp b
	jr c, .end

.failed
	ld a, 1
	ld [wEffectFailed], a
	and a
.end
	pop hl
	pop bc
	ret

; 34eee


BattleCommand_lowersub: ; 34eee
; lowersub

	ld a, BATTLE_VARS_SUBSTATUS4
	call GetBattleVar
	bit SUBSTATUS_SUBSTITUTE, a
	ret z

	ld a, BATTLE_VARS_SUBSTATUS3
	call GetBattleVar
	bit SUBSTATUS_CHARGED, a
	jr nz, .already_charged

	ld a, BATTLE_VARS_MOVE_EFFECT
	call GetBattleVar
	cp EFFECT_SOLAR_BEAM
	jr z, .charge_turn
	cp EFFECT_FLY
	jr z, .charge_turn

.already_charged
	call .Rampage
	jr z, .charge_turn

	call CheckUserIsCharging
	ret nz

.charge_turn
	call _CheckBattleEffects
	jr c, .mimic_anims

	xor a
	ld [wNumHits], a
	ld [wFXAnimIDHi], a
	inc a
	ld [wKickCounter], a
	ld a, SUBSTITUTE
	jp LoadAnim

.mimic_anims
	call BattleCommand_lowersubnoanim
	jp BattleCommand_movedelay

.Rampage:
	ld a, BATTLE_VARS_MOVE_EFFECT
	call GetBattleVar
	cp EFFECT_ROLLOUT
	jr z, .rollout_rampage
	cp EFFECT_RAMPAGE
	jr z, .rollout_rampage

	ld a, 1
	and a
	ret

.rollout_rampage
	ld a, [wSomeoneIsRampaging]
	and a
	ld a, 0 ; not xor a; preserve carry flag
	ld [wSomeoneIsRampaging], a
	ret

; 34f57


BattleCommand_hittarget: ; 34f57
; hittarget
	call BattleCommand_lowersub
	call BattleCommand_hittargetnosub
	jp BattleCommand_raisesub

; 34f60


BattleCommand_hittargetnosub: ; 34f60
	ld a, [wAttackMissed]
	and a
	jp nz, BattleCommand_movedelay

	ld a, [hBattleTurn]
	and a
	ld de, wPlayerRolloutCount
	ld a, BATTLEANIM_ENEMY_DAMAGE
	jr z, .got_rollout_count
	ld de, wEnemyRolloutCount
	ld a, BATTLEANIM_PLAYER_DAMAGE

.got_rollout_count
	ld [wNumHits], a
	ld a, BATTLE_VARS_MOVE_EFFECT
	call GetBattleVar
	cp EFFECT_MULTI_HIT
	jr z, .multihit
	cp EFFECT_FURY_STRIKES
	jr z, .fury_strikes
	cp EFFECT_CONVERSION
	jr z, .conversion
	cp EFFECT_DOUBLE_HIT
	jr z, .doublehit
	cp EFFECT_TRIPLE_KICK
	jr z, .triplekick

.normal_move
	xor a
	ld [wKickCounter], a
.triplekick
	ld a, BATTLE_VARS_MOVE_ANIM
	call GetBattleVar
	ld e, a
	ld d, 0
	call PlayFXAnimID

	ld a, BATTLE_VARS_MOVE_ANIM
	call GetBattleVar
	cp FLY
	jr z, .fly_dig
	cp DIG
	ret nz

.fly_dig
; clear sprite
	jp AppearUserLowerSub

.multihit
.conversion
.doublehit
	ld a, [wKickCounter]
	and 1
	xor 1
	ld [wKickCounter], a
.fury_attack
	ld a, [de]
	cp $1
	push af
	ld a, BATTLE_VARS_MOVE_ANIM
	call GetBattleVar
	ld e, a
	ld d, 0
	pop af
	jp z, PlayFXAnimID
	xor a
	ld [wNumHits], a
	jp PlayFXAnimID

; Fury Swipes and Fury Attack were merged into Fury Strikes, so use the correct
; animation for the Pokémon that learned each one
.fury_strikes
	push de
	ld a, [hBattleTurn]
	and a
	ld a, [wBattleMonSpecies]
	jr z, .got_user_species
	ld a, [wEnemyMonSpecies]
.got_user_species
	ld hl, .fury_attack_users
	ld de, 1
	call IsInArray
	pop de
	jr nc, .multihit
	ld a, $2
	ld [wKickCounter], a
	jr .fury_attack

.fury_attack_users
	db BEEDRILL
	db NIDORAN_M
	db NIDORINO
	db NIDOKING
	db FARFETCH_D
	db DODUO
	db DODRIO
	db RHYHORN
	db RHYDON
	db RHYPERIOR
	db PINSIR
	db DUNSPARCE
	db HERACROSS
	db PILOSWINE
	db MAMOSWINE
	db SKARMORY
	db DONPHAN
	db -1

; 34fd1


BattleCommand_statupanim: ; 34fd1
	ld a, [wAttackMissed]
	and a
	jp nz, BattleCommand_movedelay

	xor a
	jr StatUpDownAnim

; 34fdb


BattleCommand_statdownanim: ; 34fdb
	ld a, [wAttackMissed]
	and a
	jp nz, BattleCommand_movedelay

	ld a, [hBattleTurn]
	and a
	ld a, BATTLEANIM_ENEMY_STAT_DOWN
	jr z, StatUpDownAnim
	ld a, BATTLEANIM_WOBBLE

	; fallthrough
; 34feb


StatUpDownAnim: ; 34feb
	ld [wNumHits], a

	ld a, BATTLE_VARS_MOVE_ANIM
	call GetBattleVar
	ld e, a
	ld d, 0
	cp DEFENSE_CURL
	jr nz, .not_defense_curl
	ld a, [hBattleTurn]
	and a
	ld a, [wBattleMonSpecies]
	jr z, .got_user_species
	ld a, [wEnemyMonSpecies]
.got_user_species
	ld hl, .withdraw_users
	ld de, 1
	push af
	call IsInArray
	jr nc, .not_withdraw
	pop af
	ld a, $1
	jr .got_kick_counter
.not_withdraw
	pop af ; restore species to a
	inc hl ; ld hl, .harden_users
	; ld de, 1
	call IsInArray
	jr nc, .not_harden
	ld a, $2
	jr .got_kick_counter
.not_harden
.not_defense_curl
	xor a
.got_kick_counter
	ld [wKickCounter], a
	ld a, BATTLE_VARS_MOVE_ANIM
	call GetBattleVar
	ld e, a
	ld d, 0
	jp PlayFXAnimID

.withdraw_users
	db SQUIRTLE
	db WARTORTLE
	db BLASTOISE
	db SLOWBRO
	db SHELLDER
	db CLOYSTER
	db OMANYTE
	db OMASTAR
	db -1

.harden_users
	db METAPOD
	db KAKUNA
	db GRIMER
	db MUK
	db ONIX
	db STEELIX
	db KRABBY
	db KINGLER
	db STARYU
	db STARMIE
	db KABUTO
	db KABUTOPS
	db HERACROSS
	db GLIGAR
	db GLISCOR
	db SLUGMA
	db MAGCARGO
	db CORSOLA
	db PUPITAR
	db TYRANITAR
	db -1

; 34ffd


BattleCommand_raisesub: ; 35004
; raisesub

	ld a, BATTLE_VARS_SUBSTATUS4
	call GetBattleVar
	bit SUBSTATUS_SUBSTITUTE, a
	ret z

	call _CheckBattleEffects
	jp c, BattleCommand_raisesubnoanim

	xor a
	ld [wNumHits], a
	ld [wFXAnimIDHi], a
	ld a, $2
	ld [wKickCounter], a
	ld a, SUBSTITUTE
	jp LoadAnim

; 35023


BattleCommand_failuretext:
; If the move missed or failed, load the appropriate
; text, and end the effects of multi-turn or multi-
; hit moves.
	ld a, [wAttackMissed]
	and a
	ret z

	call GetFailureResultText
	ld a, BATTLE_VARS_MOVE_ANIM
	call GetBattleVarAddr

	cp FLY
	jr z, .fly_dig
	cp DIG
	jr z, .fly_dig

; Move effect:
	inc hl
	ld a, [hl]

	cp EFFECT_MULTI_HIT
	jr z, .multihit
	cp EFFECT_DOUBLE_HIT
	jr z, .multihit
	cp EFFECT_FURY_STRIKES
	jr z, .multihit
	jp EndMoveEffect

.multihit
	call BattleCommand_raisesub
	jp EndMoveEffect

.fly_dig
	ld a, BATTLE_VARS_SUBSTATUS3
	call GetBattleVarAddr
	res SUBSTATUS_UNDERGROUND, [hl]
	res SUBSTATUS_FLYING, [hl]
	call AppearUserRaiseSub
	jp EndMoveEffect

; 3505e


BattleCommand_checkfaint:
; b is set to an endure flag as follows:
; 0 - Nothing
; 1 - Endure (the move)
; 2 - Ability (i.e. Sturdy)
; 3 - Nonconsumable item (i.e. Focus Band)
; 4 - Item consumed after use (i.e. Focus Sash)
	ld a, BATTLE_VARS_SUBSTATUS1_OPP
	call GetBattleVar
	bit SUBSTATUS_ENDURE, a
	jr z, .not_enduring
	ld b, $1
	jr .enduring

.not_enduring
	call GetOpponentItem
	ld a, b
	ld b, $3
	cp HELD_FOCUS_BAND
	jr z, .focus_band
	ld b, $4
	cp HELD_FOCUS_SASH
	jr z, .sturdy
	call GetOpponentAbilityAfterMoldBreaker
	ld b, $2
	cp STURDY
	jr nz, .no_endure
.sturdy
	push bc
	farcall CheckOpponentFullHP
	pop bc
	jr nz, .no_endure
	jr .enduring
.focus_band
	call BattleRandom
	cp c
	jr nc, .no_endure
.enduring
	push bc
	call BattleCommand_falseswipe
	pop bc
	jr nc, .no_endure
	jr .okay
.no_endure
	ld b, $0
.okay
	push bc
	call .check_sub
	ld c, $0
	call TakeDamage
	pop bc
	ld a, b
	and a
	ret z
	dec a
	jr nz, .not_enduring2
	ld hl, EnduredText
	jp StdBattleTextBox

.not_enduring2
	dec a
	jr nz, .enduring_with_item
	farjp ShowEnemyAbilityActivation

.enduring_with_item
	push af
	call GetOpponentItem
	call GetCurItemName

	ld hl, HungOnText
	call StdBattleTextBox
	pop af
	dec a
	jp nz, ConsumeOpponentItem
	ret

.check_sub
	ld a, BATTLE_VARS_ABILITY
	call GetBattleVar
	cp INFILTRATOR
	jr z, .bypass_sub
	ld a, BATTLE_VARS_SUBSTATUS4_OPP
	call GetBattleVar
	bit SUBSTATUS_SUBSTITUTE, a
	ret nz
.bypass_sub
	ld de, wPlayerDamageTaken + 1
	ld a, [hBattleTurn]
	and a
	jr nz, .damage_taken
	ld de, wEnemyDamageTaken + 1

.damage_taken
	ld a, [wCurDamage + 1]
	ld b, a
	ld a, [de]
	add b
	ld [de], a
	dec de
	ld a, [wCurDamage]
	ld b, a
	ld a, [de]
	adc b
	ld [de], a
	ret nc
	ld a, $ff
	ld [de], a
	inc de
	ld [de], a
	ret

; 350e4


GetFailureResultText: ; 350e4
	ld hl, DoesntAffectText
	ld a, [wTypeModifier]
	and a
	jr z, .got_text
	ld a, BATTLE_VARS_MOVE_EFFECT
	call GetBattleVar
	cp EFFECT_FUTURE_SIGHT
	ld hl, ButItFailedText
	jr z, .got_text
	ld hl, AttackMissedText
	ld a, [wCriticalHit]
	cp $ff
	jr nz, .got_text
	ld hl, UnaffectedText
.got_text
	call FailText_CheckOpponentProtect
	xor a
	ld [wCriticalHit], a

	ld a, BATTLE_VARS_MOVE_EFFECT
	call GetBattleVar
	cp EFFECT_JUMP_KICK
	ret nz

	call GetHalfMaxHP
	ld hl, wCurDamage
	ld a, b
	ld [hli], a
	ld [hl], c

	ld hl, CrashedText
	call StdBattleTextBox
	ld a, $1
	ld [wKickCounter], a
	call LoadMoveAnim
	ld c, $1
	jp TakeOpponentDamage

FailText_CheckOpponentProtect: ; 35157
; Print an appropriate failure message, usually wAttackMissed.
; An wAttackMissed value of something other than 1 can override
; the message, used for Protect and some abilities.
; Important: To ensure proper message order, wAttackMissed=3
; has side effects -- it triggers the ability. Also,
; cp ATKFAIL_CUSTOM is used first since ATKFAIL_CUSTOM!=1 and
; hl is otherwise overwritten.
; TODO: use this function more extensively
	ld a, [wAttackMissed]
	and a
	ret z
	cp ATKFAIL_CUSTOM
	jr z, .printmsg
	dec a
	ld hl, AttackMissedText
	jr z, .printmsg
	dec a
	ld hl, ProtectingItselfText
	jr z, .printmsg
	dec a
	jr z, .ability_immune
	dec a
	ld hl, ButItFailedText
	jr z, .printmsg
	ld hl, DoesntAffectText
.printmsg
	jp StdBattleTextBox
.ability_immune
	farjp RunEnemyNullificationAbilities

; 35165

BattleCommand_suckerpunch:
	call CheckOpponentWentFirst
	jr nz, .failed

	; Now we know that the opponent did pick a move
	call SwitchTurn
	ld a, BATTLE_VARS_MOVE_CATEGORY
	call GetBattleVar
	push af
	call SwitchTurn
	pop af
	cp STATUS
	ret nz
.failed
	call AnimateFailedMove
	call TryPrintButItFailed
	jp EndMoveEffect

BattleCommand_criticaltext: ; 35175
; criticaltext
; Prints the message for critical hits.

; If there is no message to be printed, wait 20 frames.
	ld a, [wCriticalHit]
	and a
	jr z, .wait

	ld hl, CriticalHitText
	call StdBattleTextBox

	xor a
	ld [wCriticalHit], a

	; Maybe it fainted
	call HasOpponentFainted
	jr z, .wait

	; Activate Anger Point here to get proper message order
	call GetOpponentAbilityAfterMoldBreaker
	cp ANGER_POINT
	jr nz, .wait
	call SwitchTurn
	farcall AngerPointAbility
	call SwitchTurn

.wait
	ld c, 20
	jp DelayFrames


BattleCommand_startloop: ; 35197
; startloop

	ld hl, wPlayerRolloutCount
	ld a, [hBattleTurn]
	and a
	jr z, .ok
	ld hl, wEnemyRolloutCount
.ok
	xor a
	ld [hl], a
	ret

; 351a5


BattleCommand_supereffectivelooptext: ; 351a5
; supereffectivelooptext

	ld a, BATTLE_VARS_SUBSTATUS3
	call GetBattleVarAddr
	bit SUBSTATUS_IN_LOOP, a
	ret nz

	; fallthrough
; 351ad


BattleCommand_supereffectivetext: ; 351ad
; supereffectivetext

	ld a, [wTypeModifier]
	cp $10 ; 1.0
	ret z
	push af
	ld a, [wInverseBattleScore]
	ld hl, SuperEffectiveText
	jr nc, .super_effective
	ld hl, NotVeryEffectiveText
	dec a
	dec a
.super_effective
	inc a
	cp $80
	jr z, .score_ok
	ld [wInverseBattleScore], a
.score_ok
	call StdBattleTextBox
	pop af
	ret c

	; Maybe it fainted
	call HasOpponentFainted
	ret z

	; Activate Weakness Policy
	call GetOpponentItemAfterUnnerve
	ld a, b
	cp HELD_WEAKNESS_POLICY
	jr z, .weakness_policy
	cp HELD_ENIGMA_BERRY
	ret nz

	push bc
	push hl
	farcall CheckFullHP
	pop hl
	pop bc
	ret z

	; treat as HP-restoring berry
	ld b, HELD_BERRY
	farcall _HeldHPHealingItem
	ret nz
	farjp UseBattleItem

.weakness_policy
	ld a, [wAttackMissed]
	ld b, a
	ld a, [wEffectFailed]
	ld c, a
	xor a
	ld [wEffectFailed], a
	push bc
	push hl
	call SwitchTurn
	call ResetMiss
	call BattleCommand_attackup2
	xor a
	ld b, a
	ld c, a
	ld a, [wFailedMessage]
	and a
	jr z, .ok
	inc b
.ok
	push bc
	call ResetMiss
	call BattleCommand_specialattackup2
	pop bc
	ld a, [wFailedMessage]
	and a
	jr z, .ok2
	inc c
	ld a, b
	and a
	jr nz, .end
.ok2
	farcall ItemRecoveryAnim
	ld a, b
	and a
	pop hl
	push hl
	push bc
	jr nz, .atk_msg_done
	call GetCurItemName
	ld a, ATTACK
	call .print_msg
.atk_msg_done
	pop bc
	ld a, c
	and a
	jr nz, .satk_msg_done
	ld a, SP_ATTACK
	call .print_msg
.satk_msg_done
	call ConsumeUserItem
.end
	pop hl
	pop bc
	ld a, b
	ld [wAttackMissed], a
	ld a, c
	ld [wEffectFailed], a
	jp SwitchTurn
.print_msg
	ld b, a
	inc b
	call GetStatName
	ld hl, BattleText_ItemSharplyRaised
	jp StdBattleTextBox

CheckSheerForceNegation:
; Check if a secondary effect was suppressed due to Sheer Force.
; Most likely a bug introduced in Gen V, it is an established
; mechanic at this point (VII) that if Sheer Force negates the
; secondary effect of a move, various side effects don't trigger.
; Returns z if an effect is negated.
	ld a, BATTLE_VARS_ABILITY
	call GetBattleVar
	cp SHEER_FORCE
	ret nz
	ld a, [wEffectFailed]
	and a
	jr z, .ret_nz
	xor a
	ret
.ret_nz
	or 1
	ret

ConsumeOpponentItem::
	call CallOpponentTurn
ConsumeUserItem::
	ld a, [hBattleTurn]
	and a
	ld a, [wCurBattleMon]
	ld de, wBattleMonItem
	ld hl, wPartyMon1Item
	jr z, .got_item_pointers
	ld a, [wCurOTMon]
	ld de, wEnemyMonItem
	ld hl, wOTPartyMon1Item
.got_item_pointers
	call GetPartyLocation

	; Air Balloons are consumed permanently, so don't write it to UsedItems
	ld a, [de]
	cp AIR_BALLOON
	jr z, .consume_item
	push hl
	push af
	call GetUsedItemAddr
	pop af
	ld [hl], a
	pop hl

.consume_item
	xor a
	ld [de], a

	ld a, [hl]
	ld d, a
	xor a
	ld [hl], a
	ld a, [hBattleTurn]
	and a
	jr nz, .apply_unburden

	; For players, maybe remove the backup item too if we're dealing with a berry
	ld a, d
	ld [wCurItem], a
	push de
	push bc
	farcall CheckItemPocket
	pop bc
	pop de
	ld a, [wItemAttributeParamBuffer]
	cp BERRIES
	jr nz, .apply_unburden
	call GetBackupItemAddr

	; If the backup is different, don't touch it. This prevents consuming i.e. Focus Sash
	; under the following scenario: Sash procs, steal an Oran Berry, use the Oran Berry
	ld a, [hl]
	cp d
	jr nz, .apply_unburden
	xor a
	ld [hl], a

.apply_unburden
	; Unburden doubles Speed when an item is consumed
	ld a, BATTLE_VARS_ABILITY
	call GetBattleVar
	cp UNBURDEN
	ret nz

	ld a, BATTLE_VARS_SUBSTATUS1
	call GetBattleVarAddr
	set SUBSTATUS_UNBURDEN, [hl]
	ret

BattleCommand_postfainteffects:
; Effects that run after faint by an attack (Destiny Bond, Moxie, Aftermath, etc)
	call HasOpponentFainted
	ret nz

	ld a, BATTLE_VARS_SUBSTATUS2_OPP
	call GetBattleVar
	bit SUBSTATUS_DESTINY_BOND, a
	jr z, .no_dbond

	ld hl, TookDownWithItText
	call StdBattleTextBox

	call GetMaxHP
	farcall SubtractHPFromUser
	call SwitchTurn
	xor a
	ld [wNumHits], a
	ld [wFXAnimIDHi], a
	inc a
	ld [wKickCounter], a
	ld a, DESTINY_BOND
	call LoadAnim
	call SwitchTurn

	ld a, [hBattleTurn]
	and a
	jr nz, .enemy_dbond
	call UpdateBattleMonInParty
	jr .finish
.enemy_dbond
	call UpdateEnemyMonInParty
	jr .finish

.no_dbond
	farcall RunFaintAbilities
	call BattleCommand_posthiteffects
	ld a, BATTLE_VARS_MOVE_EFFECT
	call GetBattleVar
	cp EFFECT_MULTI_HIT
	jr z, .multiple_hit_raise_sub
	cp EFFECT_DOUBLE_HIT
	jr z, .multiple_hit_raise_sub
	cp EFFECT_TRIPLE_KICK
	jr z, .multiple_hit_raise_sub
	cp EFFECT_FURY_STRIKES
	jr z, .multiple_hit_raise_sub
	cp EFFECT_SWITCH_HIT
	jr nz, .finish
	call HasUserFainted
	call nz, BattleCommand_switchout
	jr .finish

.multiple_hit_raise_sub
	call BattleCommand_raisesub

.finish
	jp EndMoveEffect

BattleCommand_posthiteffects:
; This can run even if someone is fainted. Take this into account.
	call HasOpponentFainted
	jr z, .skip_sub_check
	call CheckSubstituteOpp
	ret nz

.skip_sub_check
	ld a, [wAttackMissed]
	and a
	ret nz

	farcall RunHitAbilities

	; Burst air balloons
	call HasOpponentFainted
	jr z, .air_balloon_done
	call CheckAirBalloon
	jr nz, .air_balloon_done

	ld hl, AirBalloonPoppedText
	call StdBattleTextBox
	call ConsumeOpponentItem

.air_balloon_done
	call HasOpponentFainted
	jr z, .rage_done
	ld a, BATTLE_VARS_SUBSTATUS4_OPP
	call GetBattleVar
	bit SUBSTATUS_RAGE, a
	jr z, .rage_done

	call SwitchTurn
	call ResetMiss
	call BattleCommand_attackup

	; don't print a failure message if we're maxed out in atk
	ld a, [wFailedMessage]
	and a
	jr nz, .rage_done_switchturn

	ld hl, RageBuildingText
	call StdBattleTextBox
	call BattleCommand_statupmessage

.rage_done_switchturn
	call SwitchTurn
.rage_done
	; Do Jaboca, Rowap, Kee, Maranga berries, Rocky Helmet,
	; Absorb Bulb, Snowball, Cell Battery, Luminous Moss
	call HasUserFainted
	jp z, .rocky_helmet_done
	call GetOpponentItemAfterUnnerve
	call GetCurItemName
	ld a, b
	cp HELD_ROCKY_HELMET
	jr z, .rocky_helmet
	cp HELD_SWITCH_TARGET
	jr nz, .not_switch_target
	ld a, c
	call SetDeferredSwitch
	jr .rocky_helmet_done

.not_switch_target
	ld a, BATTLE_VARS_MOVE_CATEGORY
	call GetBattleVar
	cp c
	jr nz, .check_type_hit
	ld a, b
	cp HELD_OFFEND_HIT
	jr z, .held_offend_hit
	cp HELD_DEFEND_HIT
	jr nz, .check_type_hit
	ld a, c
	cp PHYSICAL
	ld b, DEFENSE
	jr z, .got_stat
	ld b, SP_DEFENSE
	jr .got_stat
.check_type_hit
	ld a, BATTLE_VARS_MOVE_TYPE
	call GetBattleVar
	cp c
	jr nz, .rocky_helmet_done
	ld a, b
	cp HELD_HIT_RAISE_ATK
	ld b, ATTACK
	jr z, .got_stat
	cp HELD_HIT_RAISE_SAT
	ld b, SP_ATTACK
	jr z, .got_stat
	cp HELD_HIT_RAISE_SDF
	ld b, SP_DEFENSE
	jr nz, .rocky_helmet_done
.got_stat
	call SwitchTurn
	call BattleCommand_statup
	ld a, [wFailedMessage]
	and a
	jr nz, .defend_hit_done
	call GetItemStatMessage
	call ConsumeUserItem
.defend_hit_done
	call SwitchTurn
	jr .rocky_helmet_done
.held_offend_hit
	call ConsumeOpponentItem
	call GetEighthMaxHP
	jr .got_hurt_item_damage
.rocky_helmet
	call CheckContactMove
	jr c, .rocky_helmet_done
	call GetSixthMaxHP
.got_hurt_item_damage
	ld a, b
	or c
	jr nz, .damage_ok
	inc c
.damage_ok
	farcall SubtractHPFromUser
	ld hl, BattleText_UserHurtByItem
	call StdBattleTextBox

.rocky_helmet_done
	call GetUserItem
	push bc
	call GetCurItemName
	pop bc
	ld a, b
	cp HELD_LIFE_ORB
	jr z, .life_orb
	cp HELD_SHELL_BELL
	jr z, .shell_bell
	cp HELD_SWITCH
	jr nz, .not_switch
	ld a, c
	call SetDeferredSwitch
	jp .checkfaint

.not_switch
	cp HELD_FLINCH_UP
	call z, .flinch_up
	jp .checkfaint
.flinch_up
	; Ensure that the move doesn't already have a flinch rate.
	call HasOpponentFainted
	ret z
	ld a, BATTLE_VARS_MOVE_EFFECT
	call GetBattleVar
	cp EFFECT_FLINCH_HIT
	ret z
	cp EFFECT_STOMP
	ret z

	; Serene Grace boosts King's Rock
	ld a, BATTLE_VARS_ABILITY
	call GetBattleVar
	cp SERENE_GRACE
	jr nz, .no_serene_grace
	ld a, c
	add a
	ld c, a

.no_serene_grace
	; Flinch items procs even after Rocky Helmet fainting
	ld a, 100
	call BattleRandomRange
	cp c
	call c, FlinchTarget
	ret
.shell_bell
	call .checkfaint
	ret z
	call CheckSheerForceNegation
	ret z
	farcall CheckFullHP
	ret z

	ld a, [wCurDamage]
	ld b, a
	ld a, [wCurDamage + 1]
	ld c, a
	or b
	ret z ; No damage was done
	srl b
	rr c
	srl b
	rr c
	call HalveBC
	farcall ItemRecoveryAnim
	farcall RestoreHP
	ld hl, BattleText_UserRecoveredWithItem
	jp StdBattleTextBox

.life_orb
	call .checkfaint
	ret z
	ld a, BATTLE_VARS_ABILITY
	call GetBattleVar
	cp MAGIC_GUARD
	ret z

	call CheckSheerForceNegation
	ret z

.no_sheer_force
	xor a
	call GetMaxHP
	ld a, b
	ld [hDividend], a
	ld a, c
	ld [hDividend + 1], a
	ld a, 10
	ld [hDivisor], a
	ld b, 2
	call Divide
	ld a, [hQuotient + 1]
	ld b, a
	ld a, [hQuotient + 2]
	ld c, a
	farcall SubtractHPFromUser
	ld hl, BattleText_UserLostSomeOfItsHP
	call StdBattleTextBox

.checkfaint
	; if we fainted, abort the rest of the move sequence
	call HasUserFainted
	ret nz
	call EndMoveEffect ; oops
	xor a
	ret

BattleCommand_pickpocket:
; If the opponent has Pickpocket, proc the item steal now
	call CheckSheerForceNegation
	ret z

	; Don't steal items if we're fainted
	call HasOpponentFainted
	ret z

	; At this point, we can safely reset wEffectFailed (This runs after everything else)
	xor a
	ld [wEffectFailed], a
	call GetOpponentAbilityAfterMoldBreaker
	cp PICKPOCKET
	ret nz
	call CheckContactMove
	ret c
.is_contact
	call SwitchTurn
	call CanStealItem
	jr nz, .no_pickpocket
	farcall ShowAbilityActivation
	call BattleCommand_thief
.no_pickpocket
	jp SwitchTurn

BattleCommand_ragedamage:
; unused (Rage is now Attack boosts again)
	ret


DittoMetalPowder: ; 352b1
	ld a, MON_SPECIES
	call UserPartyAttr
	ld a, [hBattleTurn]
	and a
	ld a, [hl]
	jr nz, .continue
	ld a, [wTempEnemyMonSpecies]

.continue:
	cp DITTO
	ret nz

	push bc
	call GetOpponentItem
	ld a, [hl]
	cp METAL_POWDER
	pop bc
	ret nz

	ld a, c
	srl a
	add c
	ld c, a
	ret nc

	srl b
	ld a, b
	and a
	jr nz, .done
	inc b
.done
	scf
	rr c
	ret

; 352dc


UnevolvedEviolite:
	ld a, MON_SPECIES
	call UserPartyAttr
	ld a, [hBattleTurn]
	and a
	ld a, [hl]
	jr nz, .continue
	ld a, [wTempEnemyMonSpecies]

.continue:
	dec a
	push hl
	push bc
	ld c, a
	ld b, 0
	ld hl, EvosAttacksPointers
	add hl, bc
	add hl, bc
	ld a, BANK(EvosAttacksPointers)
	call GetFarHalfword
	ld a, BANK(EvosAttacks)
	call GetFarByte
	and a
	pop bc
	pop hl
	ret z

	push bc
	call GetOpponentItem
	ld a, [hl]
	cp EVIOLITE
	pop bc
	ret nz

	ld a, c
	srl a
	add c
	ld c, a
	ret nc

	srl b
	ld a, b
	and a
	jr nz, .done
	inc b
.done
	scf
	rr c
	ret

BattleCommand_brickbreak:
	ld a, [hBattleTurn]
	and a
	ld hl, wEnemyScreens
	ld bc, wEnemyLightScreenCount
	jr z, .got_screens
	ld hl, wPlayerScreens
	ld bc, wPlayerLightScreenCount
.got_screens
	bit SCREENS_LIGHT_SCREEN, [hl]
	jr z, .light_screen_done
	res SCREENS_LIGHT_SCREEN, [hl]
	xor a
	ld [bc], a
	push hl
	push bc
	ld hl, BrokeLightScreenText
	call StdBattleTextBox
	pop bc
	pop hl
.light_screen_done
	inc bc
	bit SCREENS_REFLECT, [hl]
	ret z
	res SCREENS_REFLECT, [hl]
	xor a
	ld [bc], a
	ld hl, BrokeReflectText
	jp StdBattleTextBox

BattleCommand_damagestats: ; 352dc
; damagestats

	ld a, [hBattleTurn]
	and a
	jp nz, EnemyAttackDamage

	; fallthrough
; 352e2

PlayerAttackDamage: ; 352e2
; Return move power d, player level e, enemy defense c and player attack b.

	call ResetDamage

; No damage dealt with 0 power.
	ld hl, wPlayerMoveStructPower
	ld a, [hl]
	and a
	ld d, a
	ret z

	ld hl, wPlayerMoveStructCategory
	ld a, [hl]
	cp SPECIAL
	jr nc, .special

.physical
	ld hl, wEnemyMonDefense
	ld a, [hli]
	ld b, a
	ld c, [hl]

if !DEF(FAITHFUL)
	call HailDefenseBoost
endc

	ld hl, wBattleMonAttack
	ld a, [wEnemyAbility]
	cp INFILTRATOR
	jr z, .thickcluborlightball
	ld a, [wEnemyScreens]
	bit SCREENS_REFLECT, a
	jr z, .thickcluborlightball
	ld a, [wCriticalHit]
	and a
	jr nz, .thickcluborlightball
	sla c
	rl b
	jr .thickcluborlightball

.special
	ld a, BATTLE_VARS_MOVE_EFFECT
	call GetBattleVar
	cp EFFECT_PSYSTRIKE
	jr z, .psystrike

	ld hl, wEnemyMonSpclDef
	ld a, [hli]
	ld b, a
	ld c, [hl]

	call SandstormSpDefBoost

	jr .lightscreen

.psystrike
	ld hl, wEnemyMonDefense
	ld a, [hli]
	ld b, a
	ld c, [hl]

.lightscreen
	ld hl, wBattleMonSpclAtk
	ld a, [wEnemyAbility]
	cp INFILTRATOR
	jr z, .lightball
	ld a, [wEnemyScreens]
	bit SCREENS_LIGHT_SCREEN, a
	jr z, .lightball
	ld a, [wCriticalHit]
	and a
	jr nz, .lightball
	sla c
	rl b

.lightball
; Note: Returns player special attack at hl in hl.
	call LightBallBoost
	jr .done

.thickcluborlightball
; Note: Returns player attack at hl in hl.
	call ThickClubOrLightBallBoost

.done
	call TruncateHL_BC

	ld a, [wBattleMonLevel]
	ld e, a
	call DittoMetalPowder
	call UnevolvedEviolite

	ld a, 1
	and a
	ret

; 3534d


EnemyAttackDamage: ; 353f6
; Return move power d, enemy level e, player defense c and enemy attack b.

	call ResetDamage

; No damage dealt with 0 power.
	ld hl, wEnemyMoveStructPower
	ld a, [hl]
	and a
	ld d, a
	ret z

	ld hl, wEnemyMoveStructCategory
	ld a, [hl]
	cp SPECIAL
	jr nc, .special

.physical
	ld hl, wBattleMonDefense
	ld a, [hli]
	ld b, a
	ld c, [hl]

if !DEF(FAITHFUL)
	call HailDefenseBoost
endc

	ld hl, wEnemyMonAttack
	ld a, [wPlayerAbility]
	cp INFILTRATOR
	jr z, .thickcluborlightball
	ld a, [wPlayerScreens]
	bit SCREENS_REFLECT, a
	jr z, .thickcluborlightball
	ld a, [wCriticalHit]
	and a
	jr nz, .thickcluborlightball
	sla c
	rl b
	jr .thickcluborlightball

.special
	ld a, BATTLE_VARS_MOVE_EFFECT
	call GetBattleVar
	cp EFFECT_PSYSTRIKE
	jr z, .psystrike

	ld hl, wBattleMonSpclDef
	ld a, [hli]
	ld b, a
	ld c, [hl]

	call SandstormSpDefBoost

	jr .lightscreen

.psystrike
	ld hl, wBattleMonDefense
	ld a, [hli]
	ld b, a
	ld c, [hl]

.lightscreen
	ld hl, wEnemyMonSpclAtk
	ld a, [wPlayerAbility]
	cp INFILTRATOR
	jr z, .lightball
	ld a, [wPlayerScreens]
	bit SCREENS_LIGHT_SCREEN, a
	jr z, .lightball
	ld a, [wCriticalHit]
	and a
	jr nz, .lightball
	sla c
	rl b

.lightball
; Note: Returns enemy special attack at hl in hl.
	call LightBallBoost
	jr .done

.thickcluborlightball
; Note: Returns enemy attack at hl in hl.
	call ThickClubOrLightBallBoost

.done
	call TruncateHL_BC

	ld a, [wEnemyMonLevel]
	ld e, a
	call DittoMetalPowder
	call UnevolvedEviolite

	ld a, 1
	and a
	ret

; 35461


TruncateHL_BC: ; 3534d
.loop
; Truncate 16-bit values hl and bc to 8-bit values b and c respectively.
; b = hl, c = bc

	ld a, h
	or b
	jr z, .finish

	call HalveBC

	srl h
	rr l

	ld a, l
	or h
	jr nz, .finish
	inc l

.finish
	ld a, h
	or b
	jr nz, .loop

.done
	ld b, l
	ret

ThickClubOrLightBallBoost: ; 353b5
; Return in hl the stat value at hl.

; If the attacking monster is Cubone or Marowak and
; it's holding a Thick Club, or if it's Pikachu and
; it's holding a Light Ball, double it.
	push bc
	push de
	push hl
	ld a, MON_SPECIES
	call UserPartyAttr
	ld a, [hBattleTurn]
	and a
	ld a, [hl]
	jr z, .checkpikachu
	ld a, [wTempEnemyMonSpecies]
.checkpikachu:
	pop hl
	cp PIKACHU
	lb bc, PIKACHU, PIKACHU
	ld d, LIGHT_BALL
	jr z, .ok
	lb bc, CUBONE, MAROWAK
	ld d, THICK_CLUB
.ok
	call SpeciesItemBoost
	pop de
	pop bc
	ret

; 353c3


LightBallBoost: ; 353c3
; Return in hl the stat value at hl.

; If the attacking monster is Pikachu and it's
; holding a Light Ball, double it.
	push bc
	push de
	lb bc, PIKACHU, PIKACHU
	ld d, LIGHT_BALL
	call SpeciesItemBoost
	pop de
	pop bc
	ret

; 353d1


SpeciesItemBoost: ; 353d1
; Return in hl the stat value at hl.

; If the attacking monster is species b or c and
; it's holding item d, double it.

	ld a, [hli]
	ld l, [hl]
	ld h, a

	push hl
	ld a, MON_SPECIES
	call UserPartyAttr
	ld a, [hBattleTurn]
	and a
	ld a, [hl]
	jr z, .CompareSpecies
	ld a, [wTempEnemyMonSpecies]
.CompareSpecies:
	pop hl

	cp b
	jr z, .GetItemHeldEffect
	cp c
	ret nz

.GetItemHeldEffect:
	push hl
	call GetUserItem
	ld a, [hl]
	pop hl
	cp d
	ret nz

; Double the stat
	add hl, hl
	ret

; 353f6


SandstormSpDefBoost:
	push bc
	lb bc, WEATHER_SANDSTORM, ROCK
	jr WeatherDefenseBoost
HailDefenseBoost:
	push bc
	lb bc, WEATHER_HAIL, ICE
WeatherDefenseBoost:
	call GetWeatherAfterCloudNine
	cp b
	ld a, c
	pop bc
	ret z
	push bc
	push de
	push hl
	call CheckIfTargetIsSomeType
	pop hl
	pop de
	pop bc
	ret nz
	push hl
	ld h, b
	ld l, c
	srl b
	rr c
	add hl, bc
	ld b, h
	ld c, l
	pop hl
	ret


BattleCommand_clearmissdamage: ; 355d5
; clearmissdamage
	ld a, [wAttackMissed]
	and a
	ret z

	jp ResetDamage

; 355dd


HitSelfInConfusion: ; 355dd
	call ResetDamage
	ld a, [hBattleTurn]
	and a
	ld hl, wBattleMonDefense
	ld de, wPlayerScreens
	ld a, [wBattleMonLevel]
	jr z, .got_it

	ld hl, wEnemyMonDefense
	ld de, wEnemyScreens
	ld a, [wEnemyMonLevel]
.got_it
	push af
	ld a, [hli]
	ld b, a
	ld c, [hl]
	ld a, [de]
	bit SCREENS_REFLECT, a
	jr z, .mimic_screen

	sla c
	rl b
.mimic_screen
	dec hl
	dec hl
	dec hl
	ld a, [hli]
	ld l, [hl]
	ld h, a
	call TruncateHL_BC
	ld d, 40
	pop af
	ld e, a
	ret

ApplyAttackBoosts:
	ld hl, wPlayerAtkLevel
	ld de, wEnemyAtkLevel
	jr ApplyStatBoostDamageAfterUnaware
ApplySpecialAttackBoosts:
	ld hl, wPlayerSAtkLevel
	ld de, wEnemySAtkLevel
	jr ApplyStatBoostDamageAfterUnaware

ApplyDefenseBoosts:
	ld hl, wEnemyDefLevel
	ld de, wPlayerDefLevel
	jr ApplyDefStatBoostDamageAfterUnaware

ApplySpecialDefenseBoosts:
	ld hl, wEnemySDefLevel
	ld de, wPlayerSDefLevel
	jr ApplyDefStatBoostDamageAfterUnaware

GetStatBoost:
	ld a, [hBattleTurn]
	and a
	ld a, [hl]
	ret z
	ld a, [de]
	ret

ApplyStatBoostDamageAfterUnaware:
	call GetOpponentAbilityAfterMoldBreaker
	cp UNAWARE
	ret z
ApplyStatBoostDamage:
	call GetStatBoost
	cp 7
	jr nc, GotStatLevel
	ld b, a
	ld a, [wCriticalHit]
	and a
	ret nz
	ld a, b
	jr GotStatLevel
ApplyDefStatBoostDamageAfterUnaware:
	ld a, BATTLE_VARS_ABILITY
	call GetBattleVar
	cp UNAWARE
	ret z
ApplyDefStatBoostDamage:
	call GetStatBoost
	cp 7
	ld b, a
	jr c, .no_crit_negation
	ld a, [wCriticalHit]
	and a
	ret nz
.no_crit_negation
	ld a, 14
	sub b
	; fallthrough
GotStatLevel:
	ld b, a
	call DoStatChangeMod
	jp ApplyDamageMod

FarDoStatChangeMod:
	call DoStatChangeMod
	ld b, a
	ret

DoStatChangeMod:
	ld a, b
	cp 7
	jr nc, .higher
	ld a, $29
	sub b ; between $23 (6, e.g. -1 stat change) and $28 (1, e.g. -6 stat change)
	ret
.higher
	ld a, $1b
	add b ; between $23 (8, e.g. +1 stat change) and $28 (13, e.g. +6 stat change)
	swap a ; we want to add, not reduce damage
	ret

ConfusedDamageCalc:
; Needed because several things are skipped
	call DamagePass1
	call DamagePass2
	push bc
	; This way we ignore Unnerve
	ld hl, wPlayerAtkLevel
	ld de, wEnemyAtkLevel
	call ApplyStatBoostDamage
	ld hl, wPlayerDefLevel
	ld de, wEnemyDefLevel
	call ApplyDefStatBoostDamage
	pop bc
	call DamagePass3
	jp DamagePass4

BattleCommand_damagecalc: ; 35612
; Return a damage value for move power d, player level e, enemy defense c and
; player attack b. Return 1 if successful, else 0.
	ld a, BATTLE_VARS_MOVE_EFFECT
	call GetBattleVar

	; Variable-hit moves and Conversion can have a power of 0.
	cp EFFECT_MULTI_HIT
	jr z, .skip_zero_damage_check
	cp EFFECT_FURY_STRIKES
	jr z, .skip_zero_damage_check
	cp EFFECT_CONVERSION
	jr z, .skip_zero_damage_check

	; No damage if move power is 0.
	ld a, d
	and a
	ret z

.skip_zero_damage_check
	call DamagePass1
	call DamagePass2
	push bc

	; Stat changes
	push de
	ld a, BATTLE_VARS_MOVE_EFFECT
	call GetBattleVar
	cp EFFECT_PSYSTRIKE
	jr z, .psystrike_mod
	ld a, BATTLE_VARS_MOVE_CATEGORY
	call GetBattleVar
	cp SPECIAL
	jr z, .special_mod
	call ApplyAttackBoosts
	call ApplyDefenseBoosts
	jr .stat_boosts_done
.special_mod
	call ApplySpecialAttackBoosts
	call ApplySpecialDefenseBoosts
	jr .stat_boosts_done
.psystrike_mod
	call ApplySpecialAttackBoosts
	call ApplyDefenseBoosts

.stat_boosts_done
	pop de

	; Ability boosts. Some are done elsewhere depending on needs.
	farcall ApplyDamageAbilities

	; If we're burned (and don't have Guts), halve damage
	ld a, BATTLE_VARS_STATUS
	call GetBattleVar
	bit BRN, a
	jr z, .burn_done
	ld a, BATTLE_VARS_ABILITY
	call GetBattleVar
	cp GUTS
	ld a, $12 ; 1/2 = 50%
	call nz, ApplyPhysicalAttackDamageMod

.burn_done
	; Flash Fire
	ld a, BATTLE_VARS_SUBSTATUS3
	call GetBattleVar
	bit SUBSTATUS_FLASH_FIRE, a
	jr z, .no_flash_fire
	ld a, BATTLE_VARS_MOVE_TYPE
	call GetBattleVar
	cp FIRE
	ld a, $32 ; 3/2 = 150%
	call z, ApplyDamageMod

.no_flash_fire
	; Critical hits
	ld a, [wCriticalHit]
	and a
	jr z, .no_crit

	ld a, BATTLE_VARS_ABILITY
	call GetBattleVar
	cp SNIPER
	ld a, $94 ; 9/4 = 225%
	jr z, .got_crit_mod
	ld a, $32 ; 3/2 = 150%
.got_crit_mod
	call ApplyDamageMod

.no_crit
	; Item boosts. TODO: move species items here
	call GetUserItem

	ld a, b
	cp HELD_TYPE_BOOST
	jr z, .type_boost
	cp HELD_CATEGORY_BOOST
	jr z, .category_boost
	cp HELD_CHOICE
	jr z, .choice
	cp HELD_EXPERT_BELT
	jr z, .expert_belt
	cp HELD_METRONOME
	jr z, .metronome_item

	cp HELD_LIFE_ORB
	ld a, $da ; 13/10 = 130%
	jr z, .life_orb
	jr .done_attacker_item
.type_boost
	ld a, BATTLE_VARS_MOVE_TYPE
	call GetBattleVar
	cp c
	ld a, $65 ; 6/5 = 120%
.life_orb
	call z, ApplyDamageMod
	jr .done_attacker_item
.category_boost
	ld a, BATTLE_VARS_MOVE_CATEGORY
	call GetBattleVar
	cp c
	ld a, $ba ; 11/10 = 110%
	call z, ApplyDamageMod
	jr .done_attacker_item
.choice
	ld a, c
	cp SP_ATTACK
	jr z, .choice_sat
	and a ; cp ATTACK
	jr nz, .done_attacker_item
	ld a, $32 ; 3/2 = 150%
	call ApplyPhysicalAttackDamageMod
	jr .done_attacker_item
.choice_sat
	ld a, $32 ; 3/2 = 150%
	call ApplySpecialAttackDamageMod
	jr .done_attacker_item
.metronome_item
	ld b, $55 ; (5+n)/5 = 100% + 20% * n
	ld a, [hBattleTurn]
	and a
	ld a, [wPlayerMetronomeCount]
	jr z, .got_metronome_count
	ld a, [wEnemyMetronomeCount]
.got_metronome_count
	swap a
	add b
	call ApplyDamageMod
	jr .done_attacker_item
.expert_belt
	ld a, [wTypeModifier]
	cp $11
	ld a, $65 ; 6/5 = 120%
	call nc, ApplyDamageMod
	; fallthrough
.done_attacker_item
	call GetOpponentItem

	ld a, b
	cp HELD_ASSAULT_VEST
	jr z, .assault_vest
	jr .done_defender_item
.assault_vest
	ld a, $23 ; 2/3 = 67%
	call ApplySpecialDefenseDamageMod
	; fallthrough
.done_defender_item
	pop bc
	call DamagePass3
	jp DamagePass4

DamagePass1:
	; Minimum defense value is 1.
	ld a, c
	and a
	jr nz, .not_dividing_by_zero
	ld c, 1
.not_dividing_by_zero

	xor a
	ld hl, hDividend
	ld [hli], a
	ld [hli], a
	ld [hl], a

	; Level * 2
	ld a, e
	add a
	jr nc, .level_not_overflowing
	ld [hl], $1
.level_not_overflowing
	inc hl
	ld [hli], a

	; / 5
	ld a, 5
	ld [hld], a
	push bc
	ld b, $4
	call Divide
	pop bc

	; + 2
	inc [hl]
	inc [hl]
	ret

DamagePass2:
	; * bp
	ld hl, hMultiplier
	ld [hl], d
	call Multiply

	; * Attack
	ld [hl], b
	jp Multiply

DamagePass3:
	; / Defense
	ld hl, hMultiplier
	ld [hl], c
	ld b, $4
	call Divide

	; / 50
	ld [hl], 50
	ld b, $4
	jp Divide

DamagePass4:
	; Add 2 unless damage is at least $ff00 -- set wCurDamage to $ff** in that case.
	ld hl, wCurDamage
	ld a, [hQuotient]
	and a
	jr z, .damage_ok

	; Store $ff**
	ld [hl], $ff
.end
	or 1
	ret

.damage_ok
	ld a, [hQuotient + 1]
	ld [hli], a
	ld b, a
	inc b
	jr z, .end
	ld a, [hQuotient + 2]
	add 2
	ld [hld], a
	jr nc, .end
	inc [hl]
	jr .end


BattleCommand_constantdamage: ; 35726
; constantdamage

	ld hl, wBattleMonLevel
	ld a, [hBattleTurn]
	and a
	jr z, .got_turn
	ld hl, wEnemyMonLevel

.got_turn
	ld a, BATTLE_VARS_MOVE_EFFECT
	call GetBattleVar
	cp EFFECT_LEVEL_DAMAGE
	ld b, [hl]
	ld a, 0 ; not xor a; preserve carry flag
	jr z, .got_power

	ld a, BATTLE_VARS_MOVE_EFFECT
	call GetBattleVar
	cp EFFECT_SUPER_FANG
	jr z, .super_fang

	cp EFFECT_REVERSAL
	jr z, .reversal

	ld a, BATTLE_VARS_MOVE_POWER
	call GetBattleVar
	ld b, a
	xor a
	jr .got_power

.super_fang
	ld hl, wEnemyMonHP
	ld a, [hBattleTurn]
	and a
	jr z, .got_hp
	ld hl, wBattleMonHP
.got_hp
	ld a, [hli]
	srl a
	ld b, a
	ld a, [hl]
	rr a
	push af
	ld a, b
	pop bc
	and a
	jr nz, .got_power
	or b
	ld a, 0 ; not xor a; preserve carry flag?
	jr nz, .got_power
	ld b, $1
	; fallthrough

.got_power
	ld hl, wCurDamage
	ld [hli], a
	ld [hl], b
	ret

.reversal
	ld hl, wBattleMonHP
	ld a, [hBattleTurn]
	and a
	jr z, .reversal_got_hp
	ld hl, wEnemyMonHP
.reversal_got_hp
	xor a
	ld [hDividend], a
	ld [hMultiplicand + 0], a
	ld a, [hli]
	ld [hMultiplicand + 1], a
	ld a, [hli]
	ld [hMultiplicand + 2], a
	ld a, $30
	ld [hMultiplier], a
	call Multiply
	ld a, [hli]
	ld b, a
	ld a, [hl]
	ld [hDivisor], a
	ld a, b
	and a
	jr z, .skip_to_divide

	ld a, [hProduct + 4]
	srl b
	rr a
	srl b
	rr a
	ld [hDivisor], a
	ld a, [hProduct + 2]
	ld b, a
	srl b
	ld a, [hProduct + 3]
	rr a
	srl b
	rr a
	ld [hDividend + 3], a
	ld a, b
	ld [hDividend + 2], a

.skip_to_divide
	ld b, $4
	call Divide
	ld a, [hQuotient + 2]
	ld b, a
	ld hl, .ReversalPower

.reversal_loop
	ld a, [hli]
	cp b
	jr nc, .break_loop
	inc hl
	jr .reversal_loop

.break_loop
	ld a, [hBattleTurn]
	and a
	ld a, [hl]
	jr nz, .notPlayersTurn

	ld hl, wPlayerMoveStructPower
	ld [hl], a
	push hl
	call PlayerAttackDamage
	jr .notEnemysTurn

.notPlayersTurn
	ld hl, wEnemyMoveStructPower
	ld [hl], a
	push hl
	call EnemyAttackDamage

.notEnemysTurn
	call BattleCommand_damagecalc
	pop hl
	ld [hl], 1
	ret

.ReversalPower:
	;  px,  bp
	db  1, 200
	db  4, 150
	db  9, 100
	db 16,  80
	db 32,  40
	db 48,  20
; 35813


BattleCommand_counter:
	lb bc, EFFECT_COUNTER, PHYSICAL
	jr Counterattack
BattleCommand_mirrorcoat:
	lb bc, EFFECT_MIRROR_COAT, SPECIAL
Counterattack:
	ld a, 1
	ld [wAttackMissed], a
	ld a, BATTLE_VARS_LAST_COUNTER_MOVE_OPP
	call GetBattleVar
	and a
	ret z

	push bc
	ld b, a
	farcall GetMoveEffect
	ld a, b
	pop bc
	cp b
	ret z

	call BattleCommand_resettypematchup
	ld a, [wTypeMatchup]
	and a
	ret z

	call CheckOpponentWentFirst
	ret z

	push bc
	ld a, BATTLE_VARS_LAST_COUNTER_MOVE_OPP
	call GetBattleVar
	dec a
	ld de, wStringBuffer1
	call GetMoveData
	pop bc

	ld a, [wStringBuffer1 + MOVE_POWER]
	and a
	ret z

	ld a, [wStringBuffer1 + MOVE_CATEGORY]
	cp c
	ret nz

	ld hl, wCurDamage
	ld a, [hli]
	or [hl]
	ret z

	ld a, [hl]
	add a
	ld [hld], a
	ld a, [hl]
	adc a
	ld [hl], a
	jr nc, .capped
	ld a, $ff
	ld [hli], a
	ld [hl], a
.capped

	xor a
	ld [wAttackMissed], a
	ret


BattleCommand_encore: ; 35864
; encore

	ld hl, wEnemyMonMoves
	ld de, wEnemyEncoreCount
	ld a, [hBattleTurn]
	and a
	jr z, .ok
	ld hl, wBattleMonMoves
	ld de, wPlayerEncoreCount
.ok
	ld a, BATTLE_VARS_LAST_MOVE_OPP
	call GetBattleVar
	and a
	jp z, .failed
	cp STRUGGLE
	jp z, .failed
	cp ENCORE
	jp z, .failed
	ld b, a

.got_move
	ld a, [hli]
	cp b
	jr nz, .got_move

	ld bc, wBattleMonPP - wBattleMonMoves - 1
	add hl, bc
	ld a, [hl]
	and $3f
	jp z, .failed
	ld a, [wAttackMissed]
	and a
	jp nz, .failed
	ld a, BATTLE_VARS_SUBSTATUS2_OPP
	call GetBattleVarAddr
	bit SUBSTATUS_ENCORED, [hl]
	jp nz, .failed
	set SUBSTATUS_ENCORED, [hl]
	call BattleRandom
	and $3
	inc a
	inc a
	inc a
	ld [de], a
	call CheckOpponentWentFirst
	jr nz, .finish_move
	ld a, [hBattleTurn]
	and a
	jr z, .force_last_enemy_move

	push hl
	ld a, [wLastPlayerMove]
	ld b, a
	ld c, 0
	ld hl, wBattleMonMoves
.find_player_move
	ld a, [hli]
	cp b
	jr z, .got_player_move
	inc c
	ld a, c
	cp NUM_MOVES
	jr c, .find_player_move
	pop hl
	res SUBSTATUS_ENCORED, [hl]
	xor a
	ld [de], a
	jr .failed

.got_player_move
	pop hl
	ld a, c
	ld [wCurMoveNum], a
	ld a, b
	ld [wCurPlayerMove], a
	dec a
	ld de, wPlayerMoveStruct
	call GetMoveData
	jr .finish_move

.force_last_enemy_move
	push hl
	ld a, [wLastEnemyMove]
	ld b, a
	ld c, 0
	ld hl, wEnemyMonMoves
.find_enemy_move
	ld a, [hli]
	cp b
	jr z, .got_enemy_move
	inc c
	ld a, c
	cp NUM_MOVES
	jr c, .find_enemy_move
	pop hl
	res SUBSTATUS_ENCORED, [hl]
	xor a
	ld [de], a
	jr .failed

.got_enemy_move
	pop hl
	ld a, c
	ld [wCurEnemyMoveNum], a
	ld a, b
	ld [wCurEnemyMove], a
	dec a
	ld de, wEnemyMoveStruct
	call GetMoveData

.finish_move
	call AnimateCurrentMove
	ld hl, GotAnEncoreText
	call StdBattleTextBox
	jp CheckOpponentMentalHerb

.failed
	jp PrintDidntAffect2

; 35926


BattleCommand_painsplit:
	call CheckHiddenOpponent
	jr nz, .failed

	call AnimateCurrentMove

	; Get HP
	ld a, [hBattleTurn]
	and a
	ld de, wBattleMonHP + 1
	ld hl, wEnemyMonHP + 1
	jr z, .got_hp
	push de
	ld d, h
	ld e, l
	pop hl

.got_hp
	; Set bc to [de] - [hl] (user HP - target HP)
	ld a, [de]
	sub [hl]
	ld c, a
	dec de
	dec hl
	ld a, [de]
	sbc [hl]
	jr c, .target_has_more
	ld b, a
	or c
	jr z, .done ; do nothing, they're equal

	; User has more
.share
	; updates HP anim buffers
	push bc
	call GetMaxHP
	pop bc
	srl b
	rr c
	push bc
	jr nc, .even_share
	inc bc ; HP difference is odd, so round down result (HP decrease is done first)
.even_share
	farcall SubtractHPFromUser
	call UpdateUserInParty
	call SwitchTurn
	call GetMaxHP
	pop bc
	farcall RestoreHP
	call UpdateUserInParty
	call SwitchTurn
.done
	ld hl, SharedPainText ; text is turn agnostic, so turn swap if target>user is OK
	jp StdBattleTextBox

.target_has_more
	cpl
	ld b, a
	ld a, c
	cpl
	ld c, a
	inc bc
	call SwitchTurn
	call .share
	jp SwitchTurn

.failed
	call AnimateFailedMove
	jp PrintButItFailed


BattleCommand_sketch: ; 35a74
; sketch

	call ClearLastMove
; Don't sketch during a link battle
	ld a, [wLinkMode]
	and a
	jr z, .not_linked
	call AnimateFailedMove
	jp PrintNothingHappened

.not_linked
; If the opponent has a substitute up, fail.
	call CheckSubstituteOpp
	jp nz, .fail
; If the user is transformed, fail.
	ld a, BATTLE_VARS_SUBSTATUS2
	call GetBattleVarAddr
	bit SUBSTATUS_TRANSFORMED, [hl]
	jp nz, .fail
; Get the user's moveset in its party struct.
; This move replacement shall be permanent.
; Pointer will be in de.
	ld a, MON_MOVES
	call UserPartyAttr
	ld d, h
	ld e, l
; Get the battle move structs.
	ld hl, wBattleMonMoves
	ld a, [hBattleTurn]
	and a
	jr z, .get_last_move
	ld hl, wEnemyMonMoves
.get_last_move
	ld a, BATTLE_VARS_LAST_COUNTER_MOVE_OPP
	call GetBattleVar
	ld [wTypeMatchup], a
	ld b, a
; Fail if move is invalid or is Struggle.
	and a
	jr z, .fail
	cp STRUGGLE
	jr z, .fail
; Fail if user already knows that move
	ld c, NUM_MOVES
.does_user_already_know_move
	ld a, [hli]
	cp b
	jr z, .fail
	dec c
	jr nz, .does_user_already_know_move
; Find Sketch in the user's moveset.
; Pointer in hl, and index in c.
	dec hl
	ld c, NUM_MOVES
.find_sketch
	dec c
	ld a, [hld]
	cp SKETCH
	jr nz, .find_sketch
	inc hl
; The Sketched move is loaded to that slot.
	ld a, b
	ld [hl], a
; Copy the base PP from that move.
	push bc
	push hl
	dec a
	ld hl, Moves + MOVE_PP
	call GetMoveAttr
	pop hl
	ld bc, wBattleMonPP - wBattleMonMoves
	add hl, bc
	ld [hl], a
	pop bc

	ld a, [hl]
	push af
	ld l, c
	ld h, 0
	add hl, de
	ld a, b
	ld [hl], a
	pop af
	ld de, MON_PP - MON_MOVES
	add hl, de
	ld [hl], a
.done_copy
	call GetMoveName
	call AnimateCurrentMove

	ld hl, SketchedText
	jp StdBattleTextBox

.fail
	call AnimateFailedMove
	jp PrintDidntAffect

; 35b16


BattleCommand_sleeptalk: ; 35b33
; sleeptalk

	call ClearLastMove
	ld a, [wAttackMissed]
	and a
	jr nz, .fail
	ld a, [hBattleTurn]
	and a
	ld hl, wBattleMonMoves + 1
	ld a, [wDisabledMove]
	ld d, a
	jr z, .got_moves
	ld hl, wEnemyMonMoves + 1
	ld a, [wEnemyDisabledMove]
	ld d, a
.got_moves
	ld a, BATTLE_VARS_STATUS
	call GetBattleVar
	and SLP
	jr z, .fail
	ld a, [hl]
	and a
	jr z, .fail
	call .safely_check_has_usable_move
	jr c, .fail
	dec hl
.sample_move
	push hl
	call BattleRandom
	and %11 ; NUM_MOVES - 1
	ld c, a
	ld b, 0
	add hl, bc
	ld a, [hl]
	pop hl
	and a
	jr z, .sample_move
	ld e, a
	ld a, BATTLE_VARS_MOVE
	call GetBattleVar
	cp e
	jr z, .sample_move
	ld a, e
	cp d
	jr z, .sample_move
	call .check_two_turn_move
	jr z, .sample_move
	ld a, BATTLE_VARS_MOVE
	call GetBattleVarAddr
	ld a, e
	ld [hl], a
	call CheckUserIsCharging
	jr nz, .charging
	ld a, [wKickCounter]
	push af
	call BattleCommand_lowersub
	pop af
	ld [wKickCounter], a
.charging
	call LoadMoveAnim
	call UpdateMoveData
	jp ResetTurn

.fail
	call AnimateFailedMove
	jp TryPrintButItFailed

.safely_check_has_usable_move
	push hl
	push de
	push bc
	call .check_has_usable_move
	pop bc
	pop de
	pop hl
	ret

.check_has_usable_move
	ld a, [hBattleTurn]
	and a
	ld a, [wDisabledMove]
	jr z, .got_move_2

	ld a, [wEnemyDisabledMove]
.got_move_2
	ld b, a
	ld a, BATTLE_VARS_MOVE
	call GetBattleVar
	ld c, a
	dec hl
	ld d, NUM_MOVES
.loop2
	ld a, [hl]
	and a
	jr z, .carry

	cp c
	jr z, .nope
	cp b
	jr z, .nope

	call .check_two_turn_move
	jr nz, .no_carry

.nope
	inc hl
	dec d
	jr nz, .loop2

.carry
	scf
	ret

.no_carry
	and a
	ret

.check_two_turn_move
	push hl
	push de
	push bc

	ld b, a
	farcall GetMoveEffect
	ld a, b

	pop bc
	pop de
	pop hl

	cp EFFECT_SOLAR_BEAM
	ret z
	cp EFFECT_FLY
	ret

; 35bff


BattleCommand_destinybond: ; 35bff
; destinybond

	ld a, BATTLE_VARS_LAST_COUNTER_MOVE
	call GetBattleVarAddr
	ld a, [hl]
	ld [hl], $0
	cp DESTINY_BOND
	jr z, .failed
	ld [hl], DESTINY_BOND
	ld a, BATTLE_VARS_SUBSTATUS2
	call GetBattleVarAddr
	set SUBSTATUS_DESTINY_BOND, [hl]
	call AnimateCurrentMove
	ld hl, DestinyBondEffectText
	jp StdBattleTextBox
.failed
	call AnimateFailedMove
	jp PrintButItFailed

BattleCommand_falseswipe: ; 35c94
; falseswipe

	ld hl, wEnemyMonHP
	ld a, [hBattleTurn]
	and a
	jr z, .got_hp
	ld hl, wBattleMonHP
.got_hp
	ld de, wCurDamage
	ld c, 2
	push hl
	push de
	call StringCmp
	pop de
	pop hl
	jr c, .done
	ld a, [hli]
	ld [de], a
	inc de
	ld a, [hl]
	dec a
	ld [de], a
	inc a
	jr nz, .okay
	dec de
	ld a, [de]
	dec a
	ld [de], a
.okay
	ld a, [wCriticalHit]
	cp $2
	jr nz, .carry
	xor a
	ld [wCriticalHit], a
.carry
	scf
	ret

.done
	and a
	ret

; 35cc9


BattleCommand_healbell: ; 35cc9
; healbell

	ld de, wPartyMon1Status
	ld a, [hBattleTurn]
	and a
	jr z, .got_status
	ld de, wOTPartyMon1Status
.got_status
	ld a, BATTLE_VARS_STATUS
	call GetBattleVarAddr
	xor a
	ld [hl], a
	ld h, d
	ld l, e
	ld bc, PARTYMON_STRUCT_LENGTH
	ld d, PARTY_LENGTH
.loop
	ld [hl], a
	add hl, bc
	dec d
	jr nz, .loop
	call AnimateCurrentMove

	ld hl, BellChimedText
	jp StdBattleTextBox


FarPlayBattleAnimation: ; 35d00
; play animation de

	ld a, BATTLE_VARS_SUBSTATUS3
	call GetBattleVar
	and 1 << SUBSTATUS_FLYING | 1 << SUBSTATUS_UNDERGROUND
	ret nz

	; fallthrough
; 35d08

PlayFXAnimID: ; 35d08
	ld a, e
	ld [wFXAnimIDLo], a
	ld a, d
	ld [wFXAnimIDHi], a

	ld c, 3
	call DelayFrames

	farcall PlayBattleAnim

	ret

; 35d1c

TakeOpponentDamage:
	call CallOpponentTurn
TakeDamage:
; opponent takes damage
	ld hl, wCurDamage
	ld a, [hli]
	ld b, a
	ld a, [hl]
	or b
	jr z, .did_no_damage

	ld a, c
	and a
	jr nz, .mimic_sub_check

	ld a, BATTLE_VARS_SUBSTATUS4_OPP
	call GetBattleVar
	bit SUBSTATUS_SUBSTITUTE, a
	jp nz, SelfInflictDamageToSubstitute
.mimic_sub_check
	ld a, [hld]
	ld c, a
	ld b, [hl]
	farcall SubtractHPFromOpponent
.did_no_damage
	jp RefreshBattleHuds

; 35de0


SelfInflictDamageToSubstitute: ; 35de0

	ld hl, SubTookDamageText
	call StdBattleTextBox

	ld de, wEnemySubstituteHP+1 ; hp is big-endian
	ld a, [hBattleTurn]
	and a
	jr z, .got_hp
	ld de, wPlayerSubstituteHP+1
.got_hp

	ld hl, wCurDamage
	ld a, [hli]
	and a
	jr nz, .broke

	ld a, [de]
	sub [hl]
	ld [de], a
	jr z, .broke
	jr nc, .done

.broke
	ld a, BATTLE_VARS_SUBSTATUS4_OPP
	call GetBattleVarAddr
	res SUBSTATUS_SUBSTITUTE, [hl]

	ld hl, SubFadedText
	call StdBattleTextBox

	call SwitchTurn
	call BattleCommand_lowersubnoanim
	ld a, BATTLE_VARS_SUBSTATUS3
	call GetBattleVar
	and 1 << SUBSTATUS_FLYING | 1 << SUBSTATUS_UNDERGROUND
	call z, AppearUserLowerSub
	call SwitchTurn

	ld a, BATTLE_VARS_MOVE_EFFECT
	call GetBattleVarAddr
	cp EFFECT_MULTI_HIT
	jr z, .ok
	cp EFFECT_DOUBLE_HIT
	jr z, .ok
	cp EFFECT_TRIPLE_KICK
	jr z, .ok
	cp EFFECT_FURY_STRIKES
	jr z, .ok
	xor a
	ld [hl], a
.ok
	call RefreshBattleHuds
.done
	jp ResetDamage

; 35e40

UpdateMoveData:
	ld a, BATTLE_VARS_MOVE_ANIM
	call GetBattleVarAddr
	ld d, h
	ld e, l

	; Don't update if the move doesn't exist
	ld a, BATTLE_VARS_MOVE
	call GetBattleVar
	and a
	ret z

	ld [wCurMove], a
	ld [wNamedObjectIndexBuffer], a

	dec a
	call GetMoveData
	call GetMoveName
	jp CopyName1

GetMoveData::
; Copy move struct a to de.
	ld hl, Moves
	ld bc, MOVE_LENGTH
	rst AddNTimes
	ld a, Bank(Moves)
	jp FarCopyBytes

IsOpponentLeafGuardActive:
	call CallOpponentTurn
IsLeafGuardActive:
; returns z if leaf guard applies for enemy
	call GetOpponentAbilityAfterMoldBreaker
DoLeafGuardCheck:
	cp LEAF_GUARD
	ret nz
	call GetWeatherAfterCloudNine
	cp WEATHER_SUN
	ret

PostStatusWithSynchronize:
	farcall RunEnemySynchronizeAbility
PostStatus:
	farcall UseOpponentHeldStatusHealingItem
	farjp RunEnemyStatusHealAbilities

BattleCommand_sleeptarget:
	ld b, 1
	call CanSleepTarget
	jr c, .ability_ok
	jr nz, .failed

	call CheckSubstituteOpp
	ld hl, ButItFailedText
	jr nz, .failed
	ld a, [wAttackMissed]
	and a
	ld hl, AttackMissedText
	jr nz, .failed

	call AnimateCurrentMove
	ld c, 30
	call DelayFrames
	xor a
	ld [wNumHits], a
	ld de, ANIM_SLP
	call PlayOpponentBattleAnim
	ld a, $1
	ld [hBGMapMode], a
	ld a, BATTLE_VARS_STATUS_OPP
	call GetBattleVarAddr
	push hl
	ld a, 3
	call BattleRandomRange
	add 2
	pop hl
	ld [hl], a
	call UpdateOpponentInParty
	call UpdateBattleHuds
	ld hl, FellAsleepText
	call StdBattleTextBox
	call PostStatus

	; Check if we were cured
	ld a, BATTLE_VARS_STATUS_OPP
	cp 1 << SLP
	jp z, OpponentCantMove
	ret

.failed
	push hl
	call AnimateFailedMove
	pop hl
	jp StdBattleTextBox

.ability_ok
	farcall ShowEnemyAbilityActivation
	call AnimateFailedMove
	jp PrintDoesntAffect

CanPoisonTarget:
	ld a, b
	lb bc, POISON, STEEL
	lb de, IMMUNITY, HELD_PREVENT_POISON
	ld h, 1 << PSN
	jr CanStatusTarget
CanBurnTarget:
	ld a, b
	lb bc, FIRE, FIRE
	lb de, WATER_VEIL, HELD_PREVENT_BURN
	ld h, 1 << BRN
	jr CanStatusTarget
CanParalyzeTarget:
	ld a, b
	lb bc, ELECTRIC, ELECTRIC
	lb de, LIMBER, HELD_PREVENT_PARALYZE
	ld h, 1 << PAR
	jr CanStatusTarget
CanSleepTarget:
	ld a, b
	lb bc, -1, -1
	lb de, INSOMNIA, HELD_PREVENT_SLEEP
	ld h, SLP
CanStatusTarget:
; Returns:
;     z -- we can
;  c|nz -- we can't, due to ability
; nc|nz -- we can't, failure msg in HL
	push af
	ld a, BATTLE_VARS_STATUS_OPP
	call GetBattleVar
	and h
	jr nz, .already_statused
	push de
	push bc
	ld a, b
	call CheckIfTargetIsSomeType
	pop bc
	jr z, .cant_type
	ld a, c
	call CheckIfTargetIsSomeType
	jr z, .cant_type
	ld a, [wTypeModifier]
	and a
	jr z, .cant_type
	call GetOpponentItemAfterUnnerve
	ld a, b
	pop de
	cp e
	jr z, .cant_item
	pop af
	and a
	jr z, .no_mold_breaker
	call GetOpponentAbilityAfterMoldBreaker
	jr .got_ability
.no_mold_breaker
	ld a, BATTLE_VARS_ABILITY_OPP
	call GetBattleVar
.got_ability
	; Vital Spirit does the same thing as Insomnia so treat it as Insomnia.
	cp VITAL_SPIRIT
	jr nz, .no_replace
	ld a, INSOMNIA
.no_replace
	cp d
	jr z, .cant_ability
	call DoLeafGuardCheck
	jr z, .cant_ability
	ld a, BATTLE_VARS_STATUS_OPP
	call GetBattleVar
	and a
	ld hl, ButItFailedText
	ret
.already_statused
	bit BRN, a
	ld hl, AlreadyBurnedText
	jr nz, .end
	bit PSN, a
	ld hl, AlreadyPoisonedText
	jr nz, .end
	bit PAR, a
	ld hl, AlreadyParalyzedText
	jr nz, .end
	; Shouldn't happen
	bit FRZ, a
	ld hl, AlreadyConfusedText ; no AlreadyFrozen
	jr nz, .end
	ld hl, AlreadyAsleepText
	jr .end
.cant_type
	ld hl, DoesntAffectText
	pop de
	jr .end
.cant_item
	call GetCurItemName
	ld hl, ProtectedByText
	; fallthrough
.end
	pop af
	or 1
	ret
.cant_ability
	xor a
	cp 1
	ret

BattleCommand_poisontarget:
	call CheckSubstituteOpp
	ret nz
	ld b, 1
	call CanPoisonTarget
	ret nz
	ld a, [wTypeModifier]
	and a
	ret z
	ld a, [wEffectFailed]
	and a
	ret nz

	call PoisonOpponent
	ld de, ANIM_PSN
	call PlayOpponentBattleAnim
	call RefreshBattleHuds

	ld hl, WasPoisonedText
	call StdBattleTextBox

	jp PostStatusWithSynchronize

CanPoisonTargetVerbose:
	; different from CanPoisonTarget: common function for BC_(Poison|Toxic)
	; which does move animations, prints text, etc, on failure.
	; Returns nz on failure
	ld hl, DoesntAffectText
	ld a, [wTypeModifier]
	and a
	jp z, .failed

	call CheckSubstituteOpp
	ld hl, ButItFailedText
	jr nz, .failed
	ld a, [wAttackMissed]
	and a
	ld hl, AttackMissedText
	jr nz, .failed

	ld b, 1
	call CanPoisonTarget
	jr c, .ability_ok
	jr nz, .failed
	xor a
	ret
.ability_ok
	farcall ShowEnemyAbilityActivation
	ld hl, DoesntAffectText
.failed
	push hl
	call AnimateFailedMove
	pop hl
	call StdBattleTextBox
	or a
	ret

BattleCommand_toxic:
	call CanPoisonTargetVerbose
	ret nz
	ld a, [hBattleTurn]
	and a
	ld de, wEnemyToxicCount
	jr z, .ok
	ld de, wPlayerToxicCount
.ok
	xor a
	ld [de], a
	ld a, BATTLE_VARS_STATUS_OPP
	call GetBattleVarAddr
	set TOX, [hl]
	jr ApplyPoison
BattleCommand_poison:
	call CanPoisonTargetVerbose
	ret nz
ApplyPoison:
	call AnimateCurrentMove
	call PoisonOpponent
	call RefreshBattleHuds
	ld a, BATTLE_VARS_STATUS_OPP
	call GetBattleVarAddr
	bit TOX, [hl]
	ld hl, WasPoisonedText
	jr z, .text_ok
	ld hl, BadlyPoisonedText
.text_ok
	call StdBattleTextBox
	jp PostStatusWithSynchronize

PoisonOpponent:
	ld a, BATTLE_VARS_STATUS_OPP
	call GetBattleVarAddr
	set PSN, [hl]
	jp UpdateOpponentInParty


BattleCommand_draintarget: ; 35fff
; draintarget
	call SapHealth
	ld hl, SuckedHealthText
	jp StdBattleTextBox

; 36008


BattleCommand_eatdream: ; 36008
; eatdream
	call SapHealth
	ld hl, DreamEatenText
	jp StdBattleTextBox

; 36011


SapHealth: ; 36011
	; Don't do anything if HP is full
	farcall CheckFullHP
	ret z

	; get damage
	ld hl, wCurDamage
	ld a, [hli]
	ld b, a
	ld c, [hl]

	; for Drain Kiss, we want 75% drain instead of 50%
	ld a, BATTLE_VARS_MOVE_ANIM
	call GetBattleVar
	cp DRAIN_KISS
	jr nz, .skip_drain_kiss
	ld h, b
	ld l, c
	srl b
	rr c
	add hl, bc
	ld b, h
	ld c, l

.skip_drain_kiss
	call GetHPAbsorption

	; check for Liquid Ooze
	push bc
	call GetOpponentAbilityAfterMoldBreaker
	pop bc
	cp LIQUID_OOZE
	jr z, .damage
	farjp RestoreHP
.damage
	farcall ShowEnemyAbilityActivation
	farjp SubtractHPFromUser

GetHPAbsorption:
; From damage in bc, get resulting absorbed HP
	call HandleBigRoot
	jp HalveBC

HandleBigRoot:
; Bonus +30% HP drain (or reduction if Liquid Ooze)
	push bc
	call GetUserItemAfterUnnerve
	ld a, b
	pop bc
	cp HELD_BIG_ROOT
	ret nz

	xor a
	ld hl, hMultiplicand
	ld [hli], a
	ld [hl], b
	inc hl
	ld [hl], c
	ld hl, hMultiplier
	ld [hl], 13
	call Multiply
	ld [hl], 10
	ld b, 4
	call Divide
	ld a, [hQuotient + 1]
	ld b, a
	ld a, [hQuotient + 2]
	ld c, a
	ret

BattleCommand_burntarget:
	xor a
	ld [wNumHits], a
	call CheckSubstituteOpp
	ret nz
	ld a, BATTLE_VARS_STATUS_OPP
	call GetBattleVarAddr
	and a
	jp nz, Defrost
	ld b, 1
	call CanBurnTarget
	ret nz
	ld a, [wTypeModifier]
	and a
	ret z
	ld a, [wEffectFailed]
	and a
	ret nz

	ld a, BATTLE_VARS_STATUS_OPP
	call GetBattleVarAddr
	set BRN, [hl]
	call UpdateOpponentInParty
	ld de, ANIM_BRN
	call PlayOpponentBattleAnim
	call RefreshBattleHuds

	ld hl, WasBurnedText
	call StdBattleTextBox
	jp PostStatusWithSynchronize

Defrost:
	ld a, [hl]
	and 1 << FRZ
	ret z

	xor a
	ld [hl], a

	ld a, [hBattleTurn]
	and a
	ld a, [wCurOTMon]
	ld hl, wOTPartyMon1Status
	jr z, .ok
	ld hl, wPartyMon1Status
	ld a, [wCurBattleMon]
.ok

	call GetPartyLocation
	xor a
	ld [hl], a
	call UpdateOpponentInParty

	ld hl, DefrostedOpponentText
	jp StdBattleTextBox

BattleCommand_freezetarget:
	xor a
	ld [wNumHits], a
	call CheckSubstituteOpp
	ret nz
	ld a, BATTLE_VARS_STATUS_OPP
	call GetBattleVarAddr
	and a
	ret nz
	ld a, [wTypeModifier]
	and a
	ret z
	call GetWeatherAfterCloudNine
	cp WEATHER_SUN
	ret z
	call CheckIfTargetIsIceType
	ret z
	call GetOpponentItem
	ld a, b
	cp HELD_PREVENT_FREEZE
	ret z
	call GetOpponentAbilityAfterMoldBreaker
	cp MAGMA_ARMOR
	ret z
	call IsLeafGuardActive
	ret z
	ld a, [wEffectFailed]
	and a
	ret nz
	call SafeCheckSafeguard
	ret nz
	ld a, BATTLE_VARS_STATUS_OPP
	call GetBattleVarAddr
	set FRZ, [hl]
	call UpdateOpponentInParty
	ld de, ANIM_FRZ
	call PlayOpponentBattleAnim
	call RefreshBattleHuds

	ld hl, WasFrozenText
	call StdBattleTextBox

	jp PostStatus
.no_magma_armor
	call OpponentCantMove
	jp EndRechargeOpp

BattleCommand_paralyzetarget:
	xor a
	ld [wNumHits], a
	call CheckSubstituteOpp
	ret nz
	ld b, 1
	call CanParalyzeTarget
	ret nz
	ld a, [wTypeModifier]
	and a
	ret z
	ld a, [wEffectFailed]
	and a
	ret nz

	ld a, BATTLE_VARS_STATUS_OPP
	call GetBattleVarAddr
	set PAR, [hl]
	call UpdateOpponentInParty
	ld de, ANIM_PAR
	call PlayOpponentBattleAnim
	call RefreshBattleHuds
	call PrintParalyze
	jp PostStatusWithSynchronize

BattleCommand_bulkup:
	lb bc, ATTACK, DEFENSE
	jr DoubleUp
BattleCommand_calmmind:
	lb bc, SP_ATTACK, SP_DEFENSE
	jr DoubleUp
BattleCommand_dragondance:
	lb bc, ATTACK, SPEED
	jr DoubleUp
BattleCommand_growth:
	lb bc, ATTACK, SP_ATTACK
	call GetWeatherAfterCloudNine
	cp WEATHER_SUN
	jr nz, DoubleUp
	lb bc, ($10 | ATTACK), ($10 | SP_ATTACK)
	jr DoubleUp
BattleCommand_honeclaws:
	lb bc, ATTACK, ACCURACY
DoubleUp:
; stats to raise are in bc
	push bc ; StatUp clobbers c (via CheckIfStatCanBeRaised), which we want to retain
	call ResetMiss
	call BattleCommand_statup
	ld a, [wFailedMessage]
	ld d, a ; note for 2nd stat
	ld e, 0	; track if we've shown animation
	and a
	call z, .msg_animate
	pop bc
	ld b, c
	push de
	call ResetMiss
	call BattleCommand_statup
	pop de
	ld a, [wFailedMessage]
	and a
	jr z, .msg_animate
	and d ; if this result in a being nonzero, we want to give a failure message
	ret z
	ld b, MULTIPLE_STATS + 1
	call GetStatName
	call AnimateFailedMove
	ld hl, WontRiseAnymoreText
	jp StdBattleTextBox
.msg_animate
	ld a, e
	and a
	push de
	jr nz, .statupmessage
	inc a
	ld [wKickCounter], a
	call AnimateCurrentMove
	pop de
	inc e
	push de
.statupmessage
	call BattleCommand_statupmessage
	pop de
	ret

BattleCommand_attackup: ; 361ac
; attackup
	ld b, ATTACK
	jr BattleCommand_statup

BattleCommand_defenseup: ; 361b0
; defenseup
	ld b, DEFENSE
	jr BattleCommand_statup

BattleCommand_speedup: ; 361b4
; speedup
	ld b, SPEED
	jr BattleCommand_statup

BattleCommand_specialattackup: ; 361b8
; specialattackup
	ld b, SP_ATTACK
	jr BattleCommand_statup

BattleCommand_specialdefenseup: ; 361bc
; specialdefenseup
	ld b, SP_DEFENSE
	jr BattleCommand_statup

BattleCommand_accuracyup: ; 361c0
; accuracyup
	ld b, ACCURACY
	jr BattleCommand_statup

BattleCommand_evasionup: ; 361c4
; evasionup
	ld b, EVASION
	jr BattleCommand_statup

BattleCommand_attackup2: ; 361c8
; attackup2
	ld b, $10 | ATTACK
	jr BattleCommand_statup

BattleCommand_defenseup2: ; 361cc
; defenseup2
	ld b, $10 | DEFENSE
	jr BattleCommand_statup

BattleCommand_speedup2: ; 361d0
; speedup2
	ld b, $10 | SPEED
	jr BattleCommand_statup

BattleCommand_specialattackup2: ; 361d4
; specialattackup2
	ld b, $10 | SP_ATTACK
	jr BattleCommand_statup

BattleCommand_specialdefenseup2: ; 361d8
; specialdefenseup2
	ld b, $10 | SP_DEFENSE
	jr BattleCommand_statup

BattleCommand_accuracyup2: ; 361dc
; accuracyup2
	ld b, $10 | ACCURACY
	jr BattleCommand_statup

BattleCommand_evasionup2: ; 361e0
; evasionup2
	ld b, $10 | EVASION
	; fallthrough

BattleCommand_statup:
	jp ForceRaiseStat

CheckAlreadyExecuted:
	ld a, [wAlreadyExecuted]
	and a
	ret nz
	inc a
	ld [wAlreadyExecuted], a
	dec a
	ret

BattleCommand_raisestat:
	ld b, -1
RaiseStat:
	xor a
_RaiseStat:
	or STAT_MISS | STAT_SILENT
	jr ChangeStat

BattleCommand_lowerstat:
	ld b, -1
LowerStat:
	xor a
_LowerStat:
	or STAT_LOWER | STAT_MISS | STAT_SILENT
	jr ChangeStat

BattleCommand_forceraisestat:
	ld b, -1
ForceRaiseStat:
	xor a
_ForceRaiseStat:
	jr ChangeStat

BattleCommand_forcelowerstat:
	ld b, -1
ForceLowerStat:
	xor a
_ForceLowerStat:
	or STAT_LOWER
	jr ChangeStat

BattleCommand_raisestathit:
	ld b, -1
RaiseStatHit:
	xor a
_RaiseStatHit:
	or STAT_MISS | STAT_SECONDARY | STAT_SILENT
	jr ChangeStat

BattleCommand_lowerstathit:
	ld b, -1
LowerStatHit:
	xor a
_LowerStatHit:
	or STAT_LOWER | STAT_MISS | STAT_SECONDARY | STAT_SILENT
	jr ChangeStat

BattleCommand_forceraiseoppstat:
	ld b, -1
ForceRaiseOppStat:
	xor a
_ForceRaiseOppStat:
	or STAT_TARGET | STAT_MISS
	jr ChangeStat

BattleCommand_forceloweroppstat:
	ld b, -1
ForceLowerOppStat:
	xor a
_ForceLowerOppStat:
	or STAT_TARGET | STAT_LOWER | STAT_MISS
	jr ChangeStat

BattleCommand_raiseoppstat:
	ld b, -1
RaiseOppStat:
	xor a
_RaiseOppStat:
	or STAT_TARGET
	jr ChangeStat

BattleCommand_loweroppstat:
	ld b, -1
LowerOppStat:
	xor a
_LowerOppStat:
	or STAT_TARGET | STAT_LOWER
	jr ChangeStat

BattleCommand_raiseoppstathit:
	ld b, -1
RaiseOppStatHit:
	xor a
_RaiseOppStatHit:
	or STAT_TARGET | STAT_MISS | STAT_SECONDARY | STAT_SILENT
	jr ChangeStat

BattleCommand_loweroppstathit:
	ld b, 0
LowerOppStatHit:
	xor a
_LowerOppStatHit:
	or STAT_TARGET | STAT_LOWER | STAT_MISS | STAT_SECONDARY | STAT_SILENT
ChangeStat:
; b contains stat to alter, or zero if it should be read from the move script
	farjp FarChangeStat

CheckIfStatCanBeRaised:
	ld a, b
	ld [wLoweredStat], a
	ld hl, wPlayerStatLevels
	ld a, [hBattleTurn]
	and a
	jr z, .got_stat_levels
	ld hl, wEnemyStatLevels
.got_stat_levels
	ld a, [wAttackMissed]
	and a
	jp nz, .stat_raise_failed
	ld a, [wEffectFailed]
	and a
	jp nz, .stat_raise_failed
	ld a, [wLoweredStat]
	and $f
	ld c, a
	ld b, 0
	add hl, bc
	ld b, [hl]
	inc b
	ld a, $d
	cp b
	jp c, .cant_raise_stat
	ld a, [wLoweredStat]
	and $f0
	jr z, .got_num_stages
	inc b
	ld a, $d
	cp b
	jr nc, .got_num_stages
	ld b, a
.got_num_stages
	ld [hl], b
	xor a
	ld [wFailedMessage], a
	ret

.cant_raise_stat
	ld a, $2
	ld [wFailedMessage], a
	ld a, $1
	ld [wAttackMissed], a
	ret

.stat_raise_failed
	ld a, $1
	ld [wFailedMessage], a
	ret

StatUpAnimation:
	ld bc, wPlayerMinimized
	ld hl, DropPlayerSub
	ld a, [hBattleTurn]
	and a
	jr z, .do_player
	ld bc, wEnemyMinimized
	ld hl, DropEnemySub
.do_player
	ld a, BATTLE_VARS_MOVE_ANIM
	call GetBattleVar
	cp MINIMIZE
	ret nz

	ld a, $1
	ld [bc], a
	call _CheckBattleEffects
	ret nc

	xor a
	ld [hBGMapMode], a
	call CallBattleCore
	call ApplyTilemapInVBlank
	jp BattleCommand_movedelay

; 362ad


BattleCommand_attackdown: ; 362ad
; attackdown
	ld a, ATTACK
	jr BattleCommand_statdown

BattleCommand_defensedown: ; 362b1
; defensedown
	ld a, DEFENSE
	jr BattleCommand_statdown

BattleCommand_speeddown: ; 362b5
; speeddown
	ld a, SPEED
	jr BattleCommand_statdown

BattleCommand_specialattackdown: ; 362b9
; specialattackdown
	ld a, SP_ATTACK
	jr BattleCommand_statdown

BattleCommand_specialdefensedown: ; 362bd
; specialdefensedown
	ld a, SP_DEFENSE
	jr BattleCommand_statdown

BattleCommand_accuracydown: ; 362c1
; accuracydown
	ld a, ACCURACY
	jr BattleCommand_statdown

BattleCommand_evasiondown: ; 362c5
; evasiondown
	ld a, EVASION
	jr BattleCommand_statdown

BattleCommand_attackdown2: ; 362c9
; attackdown2
	ld a, $10 | ATTACK
	jr BattleCommand_statdown

BattleCommand_defensedown2: ; 362cd
; defensedown2
	ld a, $10 | DEFENSE
	jr BattleCommand_statdown

BattleCommand_speeddown2: ; 362d1
; speeddown2
	ld a, $10 | SPEED
	jr BattleCommand_statdown

BattleCommand_specialattackdown2: ; 362d5
; specialattackdown2
	ld a, $10 | SP_ATTACK
	jr BattleCommand_statdown

BattleCommand_specialdefensedown2: ; 362d9
; specialdefensedown2
	ld a, $10 | SP_DEFENSE
	jr BattleCommand_statdown

BattleCommand_accuracydown2: ; 362dd
; accuracydown2
	ld a, $10 | ACCURACY
	jr BattleCommand_statdown

BattleCommand_evasiondown2: ; 362e1
; evasiondown2
	ld a, $10 | EVASION

BattleCommand_statdown: ; 362e3
; statdown

	ld [wLoweredStat], a

; check abilities
	and $f
	ld c, a
	call GetOpponentAbilityAfterMoldBreaker
	cp CLEAR_BODY
	jp z, .Failed
	cp HYPER_CUTTER
	jr z, .atk
	cp BIG_PECKS
	jr z, .def
	cp KEEN_EYE
	jr z, .acc
	jr .no_relevant_ability
.atk
	ld a, c
	and a ; cp ATTACK
	jr z, .Failed
.def
	ld a, c
	cp DEFENSE
	jr z, .Failed
.acc
	ld a, c
	cp ACCURACY
	jr z, .Failed

.no_relevant_ability
	call CheckMist
	jp nz, .Mist

	ld hl, wEnemyStatLevels
	ld a, [hBattleTurn]
	and a
	jr z, .GetStatLevel
	ld hl, wPlayerStatLevels

.GetStatLevel:
; Attempt to lower the stat.
	ld a, [wLoweredStat]
	and $f
	ld c, a
	ld b, 0
	add hl, bc
	ld b, [hl]
	dec b
	jp z, .CantLower

; Sharply lower the stat if applicable.
	ld a, [wLoweredStat]
	and $f0
	jr z, .ComputerMiss
	dec b
	jr nz, .ComputerMiss
	inc b

.ComputerMiss:
	call CheckSubstituteOpp
	jr nz, .Failed

	ld a, [wAttackMissed]
	and a
	jr nz, .Failed

	ld a, [wEffectFailed]
	and a
	jr nz, .Failed

	call CheckHiddenOpponent
	jr nz, .Failed

	ld [hl], b
	xor a
	ld [wFailedMessage], a
	ret

.CouldntLower:
	inc [hl]
.CantLower:
	ld a, 3
	ld [wFailedMessage], a
	ld a, 1
	ld [wAttackMissed], a
	ret

.Failed:
	ld a, 1
	ld [wFailedMessage], a
	ld [wAttackMissed], a
	ret

.Mist:
	ld a, 2
	ld [wFailedMessage], a
	ld a, 1
	ld [wAttackMissed], a
	ret

; 36391


CheckMist: ; 36391
	ld a, BATTLE_VARS_MOVE_EFFECT
	call GetBattleVar
	cp EFFECT_ATTACK_DOWN
	jr c, .dont_check_mist
	cp EFFECT_EVASION_DOWN + 1
	jr c, .check_mist
	cp EFFECT_ATTACK_DOWN_2
	jr c, .dont_check_mist
	cp EFFECT_EVASION_DOWN_2 + 1
	jr c, .check_mist
	cp EFFECT_ATTACK_DOWN_HIT
	jr c, .dont_check_mist
	cp EFFECT_EVASION_DOWN_HIT + 1
	jr c, .check_mist
.dont_check_mist
	xor a
	ret

.check_mist
	ld a, BATTLE_VARS_SUBSTATUS4_OPP
	call GetBattleVar
	bit SUBSTATUS_MIST, a
	ret

; 363b8


BattleCommand_statupmessage: ; 363b8
	ld a, [wFailedMessage]
	and a
	ret nz
	ld a, [wLoweredStat]
	and $f
	ld b, a
	inc b
	call GetStatName
	ld hl, .stat
	jp BattleTextBox

.stat
	text_jump UnknownText_0x1c0cc6
	start_asm
	ld hl, .up
	ld a, [wLoweredStat]
	and $f0
	ret z
	ld hl, .wayup
	ret

.wayup
	text_jump UnknownText_0x1c0cd0
	db "@"

.up
	text_jump UnknownText_0x1c0ce0
	db "@"

BattleCommand_statdownmessage:
	ld a, [wFailedMessage]
	and a
	ret nz
	ld a, [wLoweredStat]
	and $f
	ld b, a
	inc b
	call GetStatName
	ld hl, .stat
	call BattleTextBox
	; Competitive/Defiant activates here to give proper messages. A bit awkward,
	; but the alternative is to rewrite the stat-down logic.
	ld a, [wLoweredStat]
	and $80
	ret nz
	farjp RunEnemyStatIncreaseAbilities

.stat
	text_jump UnknownText_0x1c0ceb
	start_asm
	ld hl, .fell
	ld a, [wLoweredStat]
	and $70
	ret z
	ld hl, .sharplyfell
	ret

.sharplyfell
	text_jump UnknownText_0x1c0cf5
	db "@"
.fell
	text_jump UnknownText_0x1c0d06
	db "@"

BattleCommand_statupfailtext: ; 3644c
; statupfailtext
	ld a, [wFailedMessage]
	and a
	ret z
	push af
	call BattleCommand_movedelay
	pop af
	dec a
	jp z, TryPrintButItFailed
	ld a, [wLoweredStat]
	and $f
	ld b, a
	inc b
	call GetStatName
	ld hl, WontRiseAnymoreText
	jp StdBattleTextBox

; 3646a


BattleCommand_statdownfailtext: ; 3646a
; statdownfailtext
	ld a, [wFailedMessage]
	and a
	ret z
	push af
	call BattleCommand_movedelay
	pop af
	dec a
	jp z, TryPrintButItFailed
	dec a
	ld hl, ProtectedByMistText
	jp z, StdBattleTextBox
	ld a, [wLoweredStat]
	and $f
	ld b, a
	inc b
	call GetStatName
	ld hl, WontDropAnymoreText
	jp StdBattleTextBox

; 3648f


GetStatName:
	ld hl, .names
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

.names
	db "Attack@"
	db "Defense@"
	db "Speed@"
	db "Spcl.Atk@"
	db "Spcl.Def@"
	db "Accuracy@"
	db "Evasion@"
	db "stats@" ; used by Curse


StatLevelMultipliers: ; 364e6
	db 25, 100 ; 0.25x
	db 28, 100 ; 0.28x
	db 33, 100 ; 0.33x
	db 40, 100 ; 0.40x
	db 50, 100 ; 0.50x
	db 66, 100 ; 0.66x
	db  1,   1 ; 1.00x
	db 15,  10 ; 1.50x
	db  2,   1 ; 2.00x
	db 25,  10 ; 2.50x
	db  3,   1 ; 3.00x
	db 35,  10 ; 3.50x
	db  4,   1 ; 4.00x
; 36500


BattleCommand_allstatsup: ; 36500
; allstatsup

; Attack
	call ResetMiss
	call BattleCommand_attackup
	call BattleCommand_statupmessage

; Defense
	call ResetMiss
	call BattleCommand_defenseup
	call BattleCommand_statupmessage

; Speed
	call ResetMiss
	call BattleCommand_speedup
	call BattleCommand_statupmessage

; Special Attack
	call ResetMiss
	call BattleCommand_specialattackup
	call BattleCommand_statupmessage

; Special Defense
	call ResetMiss
	call BattleCommand_specialdefenseup
	jp   BattleCommand_statupmessage
; 3652d


ResetMiss: ; 3652d
	xor a
	ld [wAttackMissed], a
	ret

; 36532



BattleCommand_tristatuschance: ; 3658f
; tristatuschance

	call BattleCommand_effectchance

; 1/3 chance of each status
.loop
	call BattleRandom
	swap a
	and %11
	jr z, .loop
; jump
	dec a
	ld hl, .ptrs
	rst JumpTable
	ret

.ptrs
	dw BattleCommand_paralyzetarget ; paralyze
	dw BattleCommand_freezetarget ; freeze
	dw BattleCommand_burntarget ; burn
; 365a7


BattleCommand_curl: ; 365a7
; curl
	ld a, BATTLE_VARS_SUBSTATUS4
	call GetBattleVarAddr
	set SUBSTATUS_CURLED, [hl]
	ret

; 365af


BattleCommand_burn:
	ld hl, DoesntAffectText
	ld a, [wTypeModifier]
	and a
	jp z, .failed

	call CheckSubstituteOpp
	ld hl, ButItFailedText
	jr nz, .failed
	ld a, [wAttackMissed]
	and a
	ld hl, AttackMissedText
	jr nz, .failed

	ld b, 1
	call CanBurnTarget
	jr c, .ability_ok
	jr nz, .failed

	call AnimateCurrentMove
	ld c, 30
	call DelayFrames
	xor a
	ld [wNumHits], a
	ld de, ANIM_BRN
	call PlayOpponentBattleAnim
	ld a, $1
	ld [hBGMapMode], a
	ld a, BATTLE_VARS_STATUS_OPP
	call GetBattleVarAddr
	set BRN, [hl]
	call UpdateOpponentInParty
	call UpdateBattleHuds
	ld hl, WasBurnedText
	call StdBattleTextBox
	jp PostStatusWithSynchronize

.failed
	push hl
	call AnimateFailedMove
	pop hl
	jp StdBattleTextBox

.ability_ok
	farcall ShowEnemyAbilityActivation
	call AnimateFailedMove
	jp PrintDoesntAffect


BattleCommand_raisesubnoanim: ; 365af
	ld hl, GetMonBackpic
	ld a, [hBattleTurn]
	and a
	jr z, .PlayerTurn
	ld hl, GetMonFrontpic
.PlayerTurn:
	xor a
	ld [hBGMapMode], a
	call CallBattleCore
	jp ApplyTilemapInVBlank

; 365c3


BattleCommand_lowersubnoanim: ; 365c3
	ld hl, DropPlayerSub
	ld a, [hBattleTurn]
	and a
	jr z, .PlayerTurn
	ld hl, DropEnemySub
.PlayerTurn:
	xor a
	ld [hBGMapMode], a
	call CallBattleCore
	jp ApplyTilemapInVBlank

BattleCommand_checkrampage: ; 3671a
; checkrampage

	ld de, wPlayerRolloutCount
	ld a, [hBattleTurn]
	and a
	jr z, .player
	ld de, wEnemyRolloutCount
.player
	ld a, BATTLE_VARS_SUBSTATUS3
	call GetBattleVarAddr
	bit SUBSTATUS_RAMPAGE, [hl]
	ret z
	ld a, [de]
	dec a
	ld [de], a
	jr nz, .continue_rampage

	res SUBSTATUS_RAMPAGE, [hl]
	call SwitchTurn
	call SafeCheckSafeguard
	jr nz, .switchturn_continue_rampage
	ld a, BATTLE_VARS_ABILITY
	call GetBattleVar
	cp OWN_TEMPO
	jr z, .switchturn_continue_rampage

	set SUBSTATUS_CONFUSED, [hl]
	call BattleRandom
	and %00000001
	inc a
	inc a
	inc de ; ConfuseCount
	ld [de], a
.switchturn_continue_rampage
	call SwitchTurn
.continue_rampage
	ld b, rampage_command
	jp SkipToBattleCommandAfter

; 36751


BattleCommand_rampage: ; 36751
; rampage

; No rampage during Sleep Talk.
	ld a, BATTLE_VARS_STATUS
	call GetBattleVar
	and SLP
	ret nz

	ld de, wPlayerRolloutCount
	ld a, [hBattleTurn]
	and a
	jr z, .ok
	ld de, wEnemyRolloutCount
.ok
	ld a, BATTLE_VARS_SUBSTATUS3
	call GetBattleVarAddr
	set SUBSTATUS_RAMPAGE, [hl]
; Rampage for 1 or 2 more turns
	call BattleRandom
	and %00000001
	inc a
	ld [de], a
	ld a, 1
	ld [wSomeoneIsRampaging], a
	ret

; 36778


BattleCommand_teleport: ; 36778
; teleport

	ld a, [wBattleType]
	cp BATTLETYPE_TRAP ; or BATTLETYPE_FORCEITEM, BATTLETYPE_RED_GYARADOS, BATTLETYPE_LEGENDARY
	jr nc, .failed

; Switch, don't run, in trainer battles
	ld a, [wBattleMode]
	dec a
	jr nz, .trainer_battle

	ld a, BATTLE_VARS_ABILITY
	call GetBattleVar
	cp RUN_AWAY
	jr z, .run_away
	ld a, BATTLE_VARS_SUBSTATUS2_OPP
	call GetBattleVar
	bit SUBSTATUS_CANT_RUN, a
	jr nz, .failed
	call CheckIfTrappedByAbility
	jr z, .failed

.run_away
	call UpdateBattleMonInParty
	xor a
	ld [wNumHits], a
	inc a
	ld [wBattleEnded], a
	ld [wKickCounter], a
	call BattleCommand_lowersub
	call LoadMoveAnim
	ld c, 20
	call DelayFrames
	call SetBattleDraw

	ld hl, FledFromBattleText
	jp StdBattleTextBox

.trainer_battle
	call CheckAnyOtherAliveMons
	jr z, .failed
	call AnimateCurrentMove
	ld c, 20
	call DelayFrames
	ld a, 1 << SWITCH_DEFERRED
	jp SetDeferredSwitch

.failed
	call AnimateFailedMove
	jp PrintButItFailed

CheckIfTrappedByAbility:
; Wrapper around ability checks to ensure that no double-traps happen.
	call .CheckTrap
	ret nz
	call .CheckOpponentTrap
	jr z, .not_trapped
.trapped
	xor a
	ret
.not_trapped
	or 1
	ret

.CheckOpponentTrap:
	call CallOpponentTurn
.CheckTrap:
	; Ghost types are immune to all trapping abilities
	call CheckIfUserIsGhostType
	jr z, .not_trapped
	ld a, BATTLE_VARS_ABILITY_OPP
	call GetBattleVar
	cp MAGNET_PULL
	jr z, .has_magnet_pull
	cp ARENA_TRAP
	jr z, .has_arena_trap
	cp SHADOW_TAG
	ret
.has_magnet_pull
	; Only works on Steel types
	jp CheckIfUserIsSteelType
.has_arena_trap
	; Doesn't work on airborne mons
	ld d, 0
	call CheckAirborne
	jr nz, .not_trapped
	xor a
	ret

SetBattleDraw: ; 36804
	ld a, [wBattleResult]
	and $c0
	or $2
	ld [wBattleResult], a
	ret

; 3680f


BattleCommand_forceswitch: ; 3680f
; forceswitch

	ld a, [wBattleType]
	cp BATTLETYPE_TRAP ; or BATTLETYPE_FORCEITEM, BATTLETYPE_RED_GYARADOS, BATTLETYPE_LEGENDARY
	jr nc, .but_it_failed
	call GetOpponentAbilityAfterMoldBreaker
	cp SUCTION_CUPS
	ld a, ATKFAIL_ABILITY
	jr z, .fail
	ld a, [wAttackMissed]
	and a
	jr nz, .fail
	ld a, [wBattleMode]
	dec a
	jr nz, .trainer
	jr .wild

.but_it_failed
	ld a, ATKFAIL_GENERIC
.fail
	ld [wAttackMissed], a
	call BattleCommand_lowersub
	call BattleCommand_movedelay
	call BattleCommand_raisesub
	jp FailText_CheckOpponentProtect

.wild
	ld a, [wEnemyMonLevel]
	ld b, a
	ld a, [wBattleMonLevel]
	ld c, a

	ld a, [hBattleTurn]
	and a
	jr z, .wild_got_party_vars

	ld a, b
	ld b, c
	ld c, a

.wild_got_party_vars
	; b: opponent level, c: user level
	ld a, c
	cp b
	jr nc, .wild_succeed

	add b
	ld c, a
	inc c
	jr nz, .random_loop_wild
	dec c
.random_loop_wild
	call BattleRandom
	cp c
	jr nc, .random_loop_wild
	srl b
	srl b
	cp b
	jr c, .but_it_failed

.wild_succeed
	call UpdateBattleMonInParty
	xor a
	ld [wNumHits], a
	inc a
	ld [wBattleEnded], a
	call SetBattleDraw
	ld a, $1
	ld [wKickCounter], a
	call AnimateCurrentMove
	ld c, 20
	call DelayFrames
	ld hl, FledInFearText
	jp StdBattleTextBox

.trainer
	call CheckAnyOtherAliveOpponentMons
	jr z, .but_it_failed
	call AnimateCurrentMove
	ld c, 20
	call DelayFrames
	ld a, 1 << SWITCH_DEFERRED | 1 << SWITCH_TARGET | 1 << SWITCH_FORCED
	; fallthrough

SetDeferredSwitch:
	push af
	ld a, [wDeferredSwitch]
	and a
	jr nz, .done
	pop af
	ld [wDeferredSwitch], a
	push af
.done
	pop af
	ret

CheckPlayerHasMonToSwitchTo: ; 36994
	ld a, [wPartyCount]
	ld d, a
	ld e, 0
	ld bc, PARTYMON_STRUCT_LENGTH
.loop
	ld a, [wCurBattleMon]
	cp e
	jr z, .next

	ld a, e
	ld hl, wPartyMon1HP
	rst AddNTimes
	ld a, [hli]
	or [hl]
	jr nz, .not_fainted

.next
	inc e
	dec d
	jr nz, .loop

	scf
	ret

.not_fainted
	and a
	ret

; 369b6


BattleCommand_endloop: ; 369b6
; endloop

; Loop back to the command before 'critical'.

	ld de, wPlayerRolloutCount
	ld bc, wPlayerDamageTaken
	ld a, [hBattleTurn]
	and a
	jr z, .got_addrs
	ld de, wEnemyRolloutCount
	ld bc, wEnemyDamageTaken
.got_addrs

	ld a, BATTLE_VARS_SUBSTATUS3
	call GetBattleVarAddr
	bit SUBSTATUS_IN_LOOP, [hl]
	jp nz, .in_loop
	set SUBSTATUS_IN_LOOP, [hl]
	ld a, BATTLE_VARS_MOVE_EFFECT
	call GetBattleVarAddr
	ld a, [hl]
	cp EFFECT_DOUBLE_HIT
	ld a, 1
	jr z, .double_hit
	ld a, [hl]
	cp EFFECT_TRIPLE_KICK
	jr nz, .not_triple_kick
.reject_triple_kick_sample
	call BattleRandom
	and $3
	jr z, .reject_triple_kick_sample
	dec a
	jr nz, .double_hit
	ld a, 1
	ld [bc], a
	jr .done_loop

.not_triple_kick
	ld a, BATTLE_VARS_ABILITY
	call GetBattleVar
	cp SKILL_LINK
	jr nz, .no_skill_link
	ld a, 3 ; ends up being 5 hits
	jr .got_number_hits
.no_skill_link
	call BattleRandom
	and $3
	cp 2
	jr c, .got_number_hits
	call BattleRandom
	and $3
.got_number_hits
	inc a
.double_hit
	ld [de], a
	inc a
	ld [bc], a
	jr .loop_back_to_critical

.in_loop
	ld a, [de]
	dec a
	ld [de], a
	jr nz, .loop_back_to_critical
.done_loop
	ld a, BATTLE_VARS_SUBSTATUS3
	call GetBattleVarAddr
	res SUBSTATUS_IN_LOOP, [hl]

	ld a, [hBattleTurn]
	and a
	ld hl, PlayerHitTimesText
	jr z, .got_hit_n_times_text
	ld hl, EnemyHitTimesText
.got_hit_n_times_text
	push bc
	call StdBattleTextBox
	pop bc
	xor a
	ld [bc], a
	ret

; Loop back to the command before 'critical'.
.loop_back_to_critical
	ld b, critical_command
	jp SkipToBattleCommandBackwards


BattleCommand_flinchtarget: ; 36aa0
	call CheckSubstituteOpp
	ret nz

	ld a, BATTLE_VARS_STATUS_OPP
	call GetBattleVar
	and 1 << FRZ | SLP
	ret nz

	call CheckOpponentWentFirst
	ret nz

	ld a, [wEffectFailed]
	and a
	ret nz

	; fallthrough
; 36ab5


FlinchTarget: ; 36ab5
	ld a, BATTLE_VARS_SUBSTATUS3_OPP
	call GetBattleVarAddr
	set SUBSTATUS_FLINCHED, [hl]
	jp EndRechargeOpp

; 36abf


CheckOpponentWentFirst:
; Returns a=0, z if user went first
; Returns a=1, nz if opponent went first
	push hl
	ld hl, wEnemyGoesFirst
	ld a, [hBattleTurn]
	xor [hl]
	pop hl
	ret

BattleCommand_checkcharge: ; 36b3a
; checkcharge

	ld a, BATTLE_VARS_SUBSTATUS3
	call GetBattleVarAddr
	bit SUBSTATUS_CHARGED, [hl]
	ret z
	res SUBSTATUS_CHARGED, [hl]
	res SUBSTATUS_UNDERGROUND, [hl]
	res SUBSTATUS_FLYING, [hl]
	ld b, charge_command
	jp SkipToBattleCommandAfter

; 36b4d


BattleCommand_charge:
	call BattleCommand_cleartext
	ld a, BATTLE_VARS_STATUS
	call GetBattleVar
	and SLP
	jr z, .awake

	call BattleCommand_movedelay
	call BattleCommand_raisesub
	call PrintButItFailed
	jp EndMoveEffect

.awake
	ld a, BATTLE_VARS_SUBSTATUS3
	call GetBattleVarAddr
	set SUBSTATUS_CHARGED, [hl]

	ld hl, IgnoredOrders2Text
	ld a, [wAlreadyDisobeyed]
	and a
	call nz, StdBattleTextBox

	call BattleCommand_lowersub
	xor a
	ld [wNumHits], a
	inc a
	ld [wKickCounter], a
	call LoadMoveAnim
	ld a, BATTLE_VARS_MOVE_ANIM
	call GetBattleVar
	cp FLY
	jr z, .flying
	cp DIG
	jr z, .flying
	call BattleCommand_raisesub
	jr .not_flying

.flying
	call DisappearUser
.not_flying
	ld a, BATTLE_VARS_SUBSTATUS3
	call GetBattleVarAddr
	ld a, BATTLE_VARS_MOVE_ANIM
	call GetBattleVar
	ld b, a
	cp FLY
	jr z, .set_flying
	cp DIG
	jr nz, .dont_set_digging
	set SUBSTATUS_UNDERGROUND, [hl]
	jr .dont_set_digging

.set_flying
	set SUBSTATUS_FLYING, [hl]

.dont_set_digging
	; If we called this move from something else, update last move appropriately.
	call CheckUserIsCharging
	jr nz, .last_move_ok
	ld a, BATTLE_VARS_LAST_COUNTER_MOVE
	call GetBattleVarAddr
	ld [hl], b
	ld a, BATTLE_VARS_LAST_MOVE
	call GetBattleVarAddr
	ld [hl], b

.last_move_ok
	call ResetDamage

	ld hl, .UsedText
	call BattleTextBox
	jp EndMoveEffect

.UsedText:
	text_jump UnknownText_0x1c0d0e ; "[USER]"
	start_asm
	ld a, BATTLE_VARS_MOVE_ANIM
	call GetBattleVar

	ld hl, .SolarBeam
	cp SOLAR_BEAM
	ret z

	ld hl, .Fly
	cp FLY
	ret z

	ld hl, .Dig
	cp DIG
	ret

.SolarBeam:
; 'took in sunlight!'
	text_jump UnknownText_0x1c0d26
	db "@"

.Fly:
; 'flew up high!'
	text_jump UnknownText_0x1c0d5c
	db "@"

.Dig:
; 'dug a hole!'
	text_jump UnknownText_0x1c0d6c
	db "@"
; 36c2c

BattleCommand_traptarget: ; 36c2d
; traptarget

	ld a, [wAttackMissed]
	and a
	ret nz
	ld hl, wEnemyWrapCount
	ld de, wEnemyTrappingMove
	ld a, [hBattleTurn]
	and a
	jr z, .got_trap
	ld hl, wPlayerWrapCount
	ld de, wPlayerTrappingMove

.got_trap
	ld a, [hl]
	and a
	ret nz
	call CheckSubstituteOpp
	ret nz
	push bc
	push de
	call CheckIfTargetIsGhostType
	pop de
	pop bc
	ret z
	push bc
	push de
	push hl
	call GetUserItem
	ld a, b
	cp HELD_PROLONG_WRAP
	pop hl
	pop de
	pop bc
	jr z, .seven_turns
	call BattleRandom
	and 1
	add 4
	jr .got_count
.seven_turns
	ld a, 7
.got_count
	ld [hl], a
	ld a, BATTLE_VARS_MOVE_ANIM
	call GetBattleVar
	ld [de], a
	ld b, a
	ld hl, .Traps

.find_trap_text
	ld a, [hli]
	cp b
	jr z, .found_trap_text
	inc hl
	inc hl
	jr .find_trap_text

.found_trap_text
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jp StdBattleTextBox

.Traps:
	dbw WRAP,      WrappedByText     ; 'was WRAPPED by'
	dbw FIRE_SPIN, FireSpinTrapText  ; 'was trapped!'
	dbw WHIRLPOOL, WhirlpoolTrapText ; 'was trapped!'
; 36c7e


BattleCommand_focusenergy: ; 36c98
; focusenergy

	ld a, BATTLE_VARS_SUBSTATUS4
	call GetBattleVarAddr
	bit SUBSTATUS_FOCUS_ENERGY, [hl]
	jr nz, .already_pumped
	set SUBSTATUS_FOCUS_ENERGY, [hl]
	call AnimateCurrentMove
	ld hl, GettingPumpedText
	jp StdBattleTextBox

.already_pumped
	call AnimateFailedMove
	jp PrintButItFailed

; 36cb2

BattleCommand_recoil: ; 36cb2
; recoil

	ld a, BATTLE_VARS_MOVE_ANIM
	call GetBattleVar
	cp STRUGGLE
	jp z, .StruggleRecoil

	; For all other moves, potentially disable
	; recoil based on ability
	ld a, BATTLE_VARS_ABILITY
	call GetBattleVar
	cp ROCK_HEAD
	ret z
	cp MAGIC_GUARD
	ret z

	ld a, b
	cp DOUBLE_EDGE
	jr z, .OneThirdRecoil
	cp FLARE_BLITZ
	jr z, .OneThirdRecoil
	ld a, BATTLE_VARS_MOVE_ANIM
	call GetBattleVar
	ld d, a
; get 1/4 damage or 1 HP, whichever is higher
	ld a, [wCurDamage]
	ld b, a
	ld a, [wCurDamage + 1]
	ld c, a
	call HalveBC
	call HalveBC
.recoil_floor
	call FloorBC
	farcall SubtractHPFromUser

.recoil_text
	ld hl, RecoilText
	jp StdBattleTextBox

.StruggleRecoil
	call GetQuarterMaxHP
	jr .recoil_floor

.OneThirdRecoil
	ld a, BATTLE_VARS_MOVE_ANIM
	call GetBattleVar
	ld d, a
	ld a, [wCurDamage]
	ld [hDividend], a
	ld a, [wCurDamage + 1]
	ld [hDividend + 1], a
	ld a, 3
	ld [hDivisor], a
	ld b, 2
	call Divide
	ld a, [hQuotient + 2]
	ld c, a
	ld a, [hQuotient + 1]
	ld b, a
	jr .recoil_floor

; 36d1d


BattleCommand_confusetarget: ; 36d1d
; confusetarget

	call GetOpponentItem
	ld a, b
	cp HELD_PREVENT_CONFUSE
	ret z
	call GetOpponentAbilityAfterMoldBreaker
	cp OWN_TEMPO
	ret z
	ld a, [wEffectFailed]
	and a
	ret nz
	call SafeCheckSafeguard
	ret nz
	call CheckSubstituteOpp
	ret nz
	ld a, BATTLE_VARS_SUBSTATUS3_OPP
	call GetBattleVarAddr
	bit SUBSTATUS_CONFUSED, [hl]
	ret nz
	jr FinishConfusingTarget


BattleCommand_confuse: ; 36d3b
; confuse

	call GetOpponentItem
	ld a, b
	cp HELD_PREVENT_CONFUSE
	jr nz, .no_item_protection
	call GetCurItemName
	call AnimateFailedMove
	ld hl, ProtectedByText
	jp StdBattleTextBox

.no_item_protection
	call GetOpponentAbilityAfterMoldBreaker
	cp OWN_TEMPO
	jr nz, .no_ability_protection
	farcall ShowEnemyAbilityActivation
	ld hl, DoesntAffectText
	jp StdBattleTextBox

.no_ability_protection
	ld a, BATTLE_VARS_SUBSTATUS3_OPP
	call GetBattleVarAddr
	bit SUBSTATUS_CONFUSED, [hl]
	jr z, .not_already_confused
	call AnimateFailedMove
	ld hl, AlreadyConfusedText
	jp StdBattleTextBox

.not_already_confused
	call CheckSubstituteOpp
	jr nz, Confuse_CheckSwagger_ConfuseHit
	ld a, [wAttackMissed]
	and a
	jr nz, Confuse_CheckSwagger_ConfuseHit
FinishConfusingTarget: ; 36d70
	ld bc, wEnemyConfuseCount
	ld a, [hBattleTurn]
	and a
	jr z, .got_confuse_count
	ld bc, wPlayerConfuseCount

.got_confuse_count
	set SUBSTATUS_CONFUSED, [hl]
	call BattleRandom
	and %11
	inc a
	inc a
	ld [bc], a

	ld a, BATTLE_VARS_MOVE_EFFECT
	call GetBattleVar
	cp EFFECT_CONFUSE_HIT
	jr z, .got_effect
	cp EFFECT_SWAGGER
	jr z, .got_effect
	call AnimateCurrentMove

.got_effect
	ld de, ANIM_CONFUSED
	call PlayOpponentBattleAnim

	ld hl, BecameConfusedText
	call StdBattleTextBox

	farcall UseOpponentConfusionHealingItem
	farjp RunEnemyStatusHealAbilities

; 36db6

Confuse_CheckSwagger_ConfuseHit: ; 36db6
	ld a, BATTLE_VARS_MOVE_EFFECT
	call GetBattleVar
	cp EFFECT_CONFUSE_HIT
	ret z
	cp EFFECT_SWAGGER
	ret z
	jp PrintDidntAffect2

; 36dc7


BattleCommand_paralyze:
	ld hl, DoesntAffectText
	ld a, [wTypeModifier]
	and a
	jp z, .failed

	ld b, 1
	call CanParalyzeTarget
	jr c, .ability_ok
	jr nz, .failed

	call CheckSubstituteOpp
	ld hl, ButItFailedText
	jr nz, .failed
	ld a, [wAttackMissed]
	and a
	ld hl, AttackMissedText
	jr nz, .failed

	call AnimateCurrentMove
	ld c, 30
	call DelayFrames
	xor a
	ld [wNumHits], a
	ld de, ANIM_PAR
	call PlayOpponentBattleAnim
	ld a, $1
	ld [hBGMapMode], a
	ld a, BATTLE_VARS_STATUS_OPP
	call GetBattleVarAddr
	set PAR, [hl]
	call UpdateOpponentInParty
	call UpdateBattleHuds
	ld hl, ParalyzedText
	call StdBattleTextBox
	jp PostStatusWithSynchronize

.failed
	push hl
	call AnimateFailedMove
	pop hl
	jp StdBattleTextBox

.ability_ok
	farcall ShowEnemyAbilityActivation
	call AnimateFailedMove
	jp PrintDoesntAffect


BattleCommand_substitute: ; 36e7c
; substitute
	call BattleCommand_movedelay

	ld a, BATTLE_VARS_SUBSTATUS4
	call GetBattleVar
	bit SUBSTATUS_SUBSTITUTE, a
	jr nz, .already_has_sub
	call GetQuarterMaxHP
	push bc
	call CompareHP
	pop bc
	jr c, .too_weak_to_sub
	jr z, .too_weak_to_sub

	ld hl, wPlayerSubstituteHP
	ld a, [hBattleTurn]
	and a
	jr z, .got_hp
	ld hl, wEnemySubstituteHP
.got_hp
	ld a, b
	ld [hli], a
	ld [hl], c
	farcall SubtractHPFromUser
	ld a, BATTLE_VARS_SUBSTATUS4
	call GetBattleVarAddr
	set SUBSTATUS_SUBSTITUTE, [hl]

	ld hl, wPlayerWrapCount
	ld de, wPlayerTrappingMove
	ld a, [hBattleTurn]
	and a
	jr z, .player
	ld hl, wEnemyWrapCount
	ld de, wEnemyTrappingMove
.player
	xor a
	ld [hl], a
	ld [de], a
	call _CheckBattleEffects
	jr c, .no_anim

	xor a
	ld [wNumHits], a
	ld [wFXAnimIDHi], a
	ld [wKickCounter], a
	ld a, SUBSTITUTE
	call LoadAnim
	jr .finish

.no_anim
	call BattleCommand_raisesubnoanim
.finish
	ld hl, MadeSubstituteText
	call StdBattleTextBox
	jp RefreshBattleHuds

.already_has_sub
	call CheckUserIsCharging
	call nz, BattleCommand_raisesub
	ld hl, HasSubstituteText
	jr .jp_stdbattletextbox

.too_weak_to_sub
	call CheckUserIsCharging
	call nz, BattleCommand_raisesub
	ld hl, TooWeakSubText
.jp_stdbattletextbox
	jp StdBattleTextBox

; 36f0b

BattleCommand_rechargenextturn: ; 36f0b
; rechargenextturn
	ld a, BATTLE_VARS_SUBSTATUS4
	call GetBattleVarAddr
	set SUBSTATUS_RECHARGE, [hl]
	ret

; 36f13


EndRechargeOpp: ; 36f13
	push hl
	ld a, BATTLE_VARS_SUBSTATUS4_OPP
	call GetBattleVarAddr
	res SUBSTATUS_RECHARGE, [hl]
	pop hl
	ret

; 36f1d


BattleCommand_rage: ; 36f1d
; rage
	ld a, BATTLE_VARS_SUBSTATUS4
	call GetBattleVarAddr
	set SUBSTATUS_RAGE, [hl]
	ret

; 36f25


BattleCommand_leechseed: ; 36f9d
; leechseed
	ld a, [wAttackMissed]
	and a
	jr nz, .evaded
	call CheckSubstituteOpp
	jr nz, .evaded
	call CheckIfTargetIsGrassType
	jr z, .grass

	ld a, BATTLE_VARS_SUBSTATUS4_OPP
	call GetBattleVarAddr
	bit SUBSTATUS_LEECH_SEED, [hl]
	jr nz, .evaded
	set SUBSTATUS_LEECH_SEED, [hl]
	call AnimateCurrentMove
	ld hl, WasSeededText
	jp StdBattleTextBox

.grass
	call AnimateFailedMove
	jp PrintDoesntAffect

.evaded
	call AnimateFailedMove
	ld hl, EvadedText
	jp StdBattleTextBox

; 36fe1


BattleCommand_splash: ; 36fe1
	call AnimateCurrentMove
	jp PrintNothingHappened

; 36fed


BattleCommand_disable: ; 36fed
; disable

	ld a, [wAttackMissed]
	and a
	jr nz, .failed

	ld de, wEnemyDisableCount
	ld hl, wEnemyMonMoves
	ld a, [hBattleTurn]
	and a
	jr z, .got_moves
	ld de, wPlayerDisableCount
	ld hl, wBattleMonMoves
.got_moves

	ld a, [de]
	and a
	jr nz, .failed

	ld a, BATTLE_VARS_LAST_COUNTER_MOVE_OPP
	call GetBattleVar
	and a
	jr z, .failed
	cp STRUGGLE
	jr z, .failed

	ld b, a
	ld c, $ff
.loop
	inc c
	ld a, [hli]
	cp b
	jr nz, .loop

	ld a, [hBattleTurn]
	and a
	ld hl, wEnemyMonPP
	jr z, .got_pp
	ld hl, wBattleMonPP
.got_pp
	ld b, 0
	add hl, bc
	ld a, [hl]
	and a
	jr z, .failed
	call ShowPotentialAbilityActivation
	; check for wAnimationsDisabled to determine if this is via Cursed Body, in
	; which we want to change the duration to always be 3 turns
	ld a, [wAnimationsDisabled]
	and a
	ld a, 4
	jr z, .got_duration
	ld a, 2
.got_duration
	inc c
	swap c
	add c
	ld [de], a
	call AnimateCurrentMove
	ld hl, wDisabledMove
	ld a, [hBattleTurn]
	and a
	jr nz, .got_disabled_move_pointer
	inc hl
.got_disabled_move_pointer
	ld a, BATTLE_VARS_LAST_COUNTER_MOVE_OPP
	call GetBattleVar
	ld [hl], a
	ld [wNamedObjectIndexBuffer], a
	call GetMoveName
	ld hl, WasDisabledText
	call StdBattleTextBox
	jp CheckOpponentMentalHerb

.failed
	jp FailDisable

; 3705c

BattleCommand_knockoff:
	ld a, [wAttackMissed]
	and a
	ret nz

	; Maybe Substitute/Sheer Force prevents the steal
	call CheckSubstituteOpp
	ret nz

	; Sticky Hold prevents item loss
	call GetOpponentAbilityAfterMoldBreaker
	cp STICKY_HOLD
	ret z

	call OpponentCanLoseItem
	ret z

	call GetOpponentItem
	xor a
	ld [hl], a
	call GetCurItemName
	ld hl, KnockedOffItemText
	call StdBattleTextBox
	ld a, MON_ITEM
	call OpponentPartyAttr
	ret z
	xor a
	ld [hl], a
	ret

BattleCommand_bugbite:
	; these abilities prevent us from eating it
	call GetOpponentAbilityAfterMoldBreaker
	cp STICKY_HOLD
	ret z
	cp UNNERVE
	ret z

	; does the opponent even have a berry? DON'T check EdibleBerries,
	; there are non-edible ones which we'll still eat (with no effect)
	call GetOpponentItem
	ld a, [hl]
	ld [wCurItem], a
	push bc
	push hl
	farcall CheckItemPocket
	pop hl
	pop bc
	ld a, [wItemAttributeParamBuffer]
	cp BERRIES
	ret nz

	; OK, we will eat the berry. Done by reusing item effect functions,
	; and if the opponent still has an item, eating it with no effect
	farcall StealHeldStatusHealingItem
	farcall StealHPHealingItem ; also Enigma Berry
	farcall StealStatBoostBerry ; also Lansat Berry
	farcall StealDefendHitBerry
	farcall StealLeppaBerry

	; check if the opponent still has a berry
	call GetOpponentItem
	ld a, [hl]
	and a
	ret z
	farcall ItemRecoveryAnim
	call GetCurItemName
	ld hl, BattleText_UserAteItem
	call StdBattleTextBox
	call ConsumeOpponentItem
	ld hl, NothingHappenedText
	jp StdBattleTextBox

BattleCommand_payday:
	call CheckSubstituteOpp
	ret nz

	xor a
	ld hl, wStringBuffer1
	ld [hli], a

	ld a, [hBattleTurn]
	and a
	ld a, [wBattleMonLevel]
	jr z, .ok
	ld a, [wEnemyMonLevel]
.ok

	push bc
	ld b, a
	add a
	add a
	add b
	pop bc

	ld hl, wPayDayMoney + 2
	add [hl]
	ld [hld], a
	jr nc, .done
	inc [hl]
	dec hl
	jr nz, .done
	inc [hl]
.done
	ld hl, CoinsScatteredText
	jp StdBattleTextBox

; 3707f

BattleCommand_skillswap:
	call CheckHiddenOpponent
	jr nz, .failed

	call AnimateCurrentMove

	ld a, [wPlayerAbility]
	ld b, a
	ld a, [wEnemyAbility]
	ld [wPlayerAbility], a
	ld a, b
	ld [wEnemyAbility], a

	ld hl, SwappedAbilitiesText
	call StdBattleTextBox

	; Don't use RunBothActivationAbilities, because
	; Skill Swap always runs the user first
	farcall RunActivationAbilitiesInner
	call SwitchTurn
	farcall RunActivationAbilitiesInner
	jp SwitchTurn

.failed
	call AnimateFailedMove
	jp PrintButItFailed

BattleCommand_trick:
	ld a, [wAttackMissed]
	and a
	jr nz, .failed

	call CheckSubstituteOpp
	jr nz, .failed

	call GetOpponentAbilityAfterMoldBreaker
	cp STICKY_HOLD
	jr z, .ability_failed

	call UserCanLoseItem
	jr z, .failed
	call OpponentCanLoseItem
	jr z, .failed

	call AnimateCurrentMove

	call GetUserItem
	push hl
	call GetOpponentItem
	pop de

	ld a, [de]
	ld b, [hl]
	ld [hl], a
	ld a, b
	ld [de], a

	ld hl, SwappedItemsText
	call StdBattleTextBox

	ld a, MON_ITEM
	call BattlePartyAttr
	ld a, [wBattleMonItem]
	ld [hl], a

	ld a, MON_ITEM
	call OTPartyAttr
	ret z
	ld a, [wEnemyMonItem]
	ld [hl], a
	ret

.ability_failed
	call ShowEnemyAbilityActivation
	jp PrintDoesntAffect
.failed
	call AnimateFailedMove
	jp PrintButItFailed

BattleCommand_conversion:
; In vanilla later generations, we change type into what is in the first slot.
; However, since we can swap moves during battle here, and the alternative
; (don't allow it, or remember what used to be our first move) is unintuitive.
; As a result, we buff Conversion instead. It might actually make the move
; useful, too.
	ld a, [hBattleTurn]
	and a
	ld hl, wBattleMonMoves
	ld de, wBattleMonType1
	jr z, .got_moves
	ld hl, wEnemyMonMoves
	ld de, wEnemyMonType1
.got_moves
	push de
	ld c, 0
	ld de, wStringBuffer3
.loop
	push hl
	ld b, 0
	add hl, bc
	ld a, [hl]
	pop hl
	and a
	jr z, .okay
	push hl
	push bc
	dec a
	ld hl, Moves + MOVE_TYPE
	call GetMoveAttr
	ld [de], a
	inc de
	pop bc
	pop hl
	inc c
	ld a, c
	cp NUM_MOVES
	jr c, .loop
.okay
	ld a, $ff
	ld [de], a
	inc de
	ld [de], a
	inc de
	ld [de], a
	pop de
	ld hl, wStringBuffer3
.loop2
	ld a, [hl]
	cp -1
	jr z, .fail
	cp UNKNOWN_T
	jr z, .next
	ld a, [de]
	cp [hl]
	jr z, .next
	inc de
	ld a, [de]
	dec de
	cp [hl]
	jr nz, .choose_move
.next
	inc hl
	jr .loop2

.fail
	call AnimateFailedMove
	jp PrintButItFailed

.choose_move
	push de
	ld a, [hBattleTurn]
	and a
	jr nz, .enemy

	; Choose what move's type to change into
	call BattleCommand_movedelay
	pop de
.player_choose_move
	push de
	ld hl, ChangeIntoTypeText
	call StdBattleTextBox

	ld a, [wCurMoveNum]
	ld d, a
	ld a, [wCurPlayerMove]
	ld e, a
	push de

	xor a
	ld [wCurMoveNum], a
	ld a, 2
	ld [wMoveSelectionMenuType], a
	farcall MoveSelectionScreen
	ld a, [wMenuCursorY]
	ld [wCurMoveNum], a

	call UpdateBattleHuds
	call Call_LoadTempTileMapToTileMap

	ld a, [wLinkMode]
	and a
	jr z, .player_link_done
	farcall LinkBattleSendReceiveAction
.player_link_done
	ld a, [wCurMoveNum]
	ld b, a
	pop de
	ld a, d
	ld [wCurMoveNum], a
	ld a, e
	ld [wCurPlayerMove], a

	push bc
	farcall UpdateMoveData
	pop bc
	ld a, b
	jr .validate_choice
.enemy
	ld a, [wLinkMode]
	and a
	jr nz, .enemy_link
	ld a, [wBattleMode]
	dec a
	jr z, .enemy_wild

	; Check trainer AI. If "Smart" mode is disabled, change randomly.
	; Otherwise, try to be intelligent about our choice.
	ld hl, TrainerClassAttributes + TRNATTR_AI_MOVE_WEIGHTS

	; If we have a battle in BattleTower just load the Attributes of the first wTrainerClass (Falkner)
	; so we have always the same AI, regardless of the loaded class of trainer
	ld a, [wInBattleTowerBattle]
	bit 0, a
	jr nz, .battle_tower_skip

	ld a, [wTrainerClass]
	dec a
	ld b, 0
	ld c, a
	ld a, NUM_TRAINER_ATTRIBUTES
	rst AddNTimes

.battle_tower_skip
	lb bc, CHECK_FLAG, AI_SMART
	ld d, BANK(TrainerClassAttributes)
	predef FlagPredef
	jr z, .not_smart
	farcall AI_Conversion
	jr .validate_choice

.enemy_link
	farcall LinkBattleSendReceiveAction
	ld a, [wBattleAction]
	cp 4
	jr c, .validate_choice

	farjp LinkBattleError
	jr .validate_choice
.not_smart
.enemy_wild
	call BattleRandom
	and %11 ; NUM_MOVES - 1
.validate_choice
	pop de
	ld c, a
	ld b, 0
	ld hl, wStringBuffer3
	add hl, bc
	ld a, [hl]
	cp -1
	jr z, .invalid_selection
	cp UNKNOWN_T
	jr z, .invalid_selection
	ld a, [de]
	cp [hl]
	jr z, .invalid_selection
	inc de
	ld a, [de]
	dec de
	cp [hl]
	jr z, .invalid_selection
	ld a, [hl]
	ld [de], a
	inc de
	ld [de], a
	ld [wNamedObjectIndexBuffer], a
	farcall GetTypeName
	call AnimateCurrentMove
	ld hl, TransformedTypeText
	jp StdBattleTextBox
.invalid_selection
	; If the player chose an invalid move, give an appropriate message.
	; Otherwise, just loop back to move selection.
	ld a, [hBattleTurn]
	and a
	ld hl, InvalidTypeChangeText
	call z, StdBattleTextBox

	; skip move delay after the first selection
	ld a, [hBattleTurn]
	and a
	jp z, .player_choose_move
	jp .choose_move

BattleCommand_resetstats:
	ld a, BASE_STAT_LEVEL
	ld hl, wPlayerStatLevels
	call .Fill
	ld hl, wEnemyStatLevels
	call .Fill

	call AnimateCurrentMove

	ld hl, EliminatedStatsText
	jp StdBattleTextBox

; same structure as ResetPlayerStatLevels and ResetEnemyStatLevels
.Fill:
	ld b, NUM_LEVEL_STATS
.loop
	ld [hli], a
	dec b
	jr nz, .loop
	ret

BattleCommand_heal:
	farcall CheckFullHP
	jr z, .hp_full
	ld a, BATTLE_VARS_MOVE_ANIM
	call GetBattleVar
	cp REST
	jr nz, .not_rest
	ld a, BATTLE_VARS_STATUS
	call GetBattleVar
	and SLP
	jp nz, BattleEffect_ButItFailed
	ld a, BATTLE_VARS_ABILITY
	call GetBattleVar
	cp INSOMNIA
	jr z, .ability_prevents_rest
	cp VITAL_SPIRIT
	jr z, .ability_prevents_rest
	call IsOpponentLeafGuardActive
	jr z, .ability_prevents_rest
	call BattleCommand_movedelay
	ld a, BATTLE_VARS_STATUS
	call GetBattleVarAddr
	ld a, [hl]
	and a
	ld [hl], REST_TURNS + 1
	ld hl, WentToSleepText
	jr z, .no_status_to_heal
	ld hl, RestedText
.no_status_to_heal
	call StdBattleTextBox
	call GetMaxHP
	jr .finish
.not_rest
	call GetHalfMaxHP
.finish
	call AnimateCurrentMove
	farcall RestoreHP
	call UpdateUserInParty
	call RefreshBattleHuds
	ld hl, RegainedHealthText
	jp StdBattleTextBox

.ability_prevents_rest
	call AnimateFailedMove
	farjp ShowAbilityActivation

.hp_full
	call AnimateFailedMove
	ld hl, HPIsFullText
	jp StdBattleTextBox

BattleCommand_roost:
; Remove the flying type until endturn
	call CheckIfUserIsFlyingType
	ret nz

	ld a, [hBattleTurn]
	and a
	ld hl, wBattleMonType1
	jr z, .got_types
	ld hl, wEnemyMonType1
.got_types
	; Check if both types are flying
	ld a, [hli]
	cp FLYING
	jr nz, .not_double_flying
	ld a, [hld]
	cp FLYING
	jr z, .normalize
.not_double_flying
	ld [hl], UNKNOWN_T
	jr .types_ok
.normalize
	; Pure Flying types become Normal
	ld a, NORMAL
	ld [hli], a
	ld [hl], a
.types_ok
	ld a, BATTLE_VARS_SUBSTATUS4
	call GetBattleVarAddr
	set SUBSTATUS_ROOST, [hl]
	ret

INCLUDE "engine/battle/effect_commands/transform.asm"

BattleSideCopy: ; 372c6
; Copy bc bytes from hl to de if it's the player's turn.
; Copy bc bytes from de to hl if it's the enemy's turn.
	ld a, [hBattleTurn]
	and a
	jr z, .copy

; Swap hl and de
	push hl
	ld h, d
	ld l, e
	pop de
.copy
	rst CopyBytes
	ret

; 372d2


BattleEffect_ButItFailed: ; 372d2
	call AnimateFailedMove
	jp PrintButItFailed

; 372d8


ClearLastMove: ; 372d8
	ld a, BATTLE_VARS_LAST_COUNTER_MOVE
	call GetBattleVarAddr
	xor a
	ld [hl], a

	ld a, BATTLE_VARS_LAST_MOVE
	call GetBattleVarAddr
	xor a
	ld [hl], a
	ret

; 372e7


ResetActorDisable: ; 372e7
	ld a, [hBattleTurn]
	and a
	jr z, .player

	xor a
	ld [wEnemyDisableCount], a
	ld [wEnemyDisabledMove], a
	ret

.player
	xor a
	ld [wPlayerDisableCount], a
	ld [wDisabledMove], a
	ret

; 372fc

BattleCommand_trickroom:
	ld hl, wTrickRoom
	ld a, [hl]
	and a
	jr nz, .failed
	ld [hl], 5
	call AnimateCurrentMove
	ld hl, TrickRoomText
	call StdBattleTextBox

	call GetUserItemAfterUnnerve
	ld a, b
	cp HELD_ROOM_SERVICE
	ret nz

	ld b, SPEED
	ld a, STAT_SKIPTEXT
	call _ForceLowerStat
	ld a, [wFailedMessage]
	and a
	ret nz

	farcall UseStatItemText
	jp ConsumeUserItem

.failed
	call AnimateFailedMove
	jp PrintButItFailed

BattleCommand_screen: ; 372fc
; screen

	ld hl, wPlayerScreens
	ld bc, wPlayerLightScreenCount
	ld a, [hBattleTurn]
	and a
	jr z, .got_screens_pointer
	ld hl, wEnemyScreens
	ld bc, wEnemyLightScreenCount

.got_screens_pointer
	ld a, BATTLE_VARS_MOVE_EFFECT
	call GetBattleVar
	cp EFFECT_LIGHT_SCREEN
	jr nz, .reflect

	bit SCREENS_LIGHT_SCREEN, [hl]
	jr nz, .failed
	set SCREENS_LIGHT_SCREEN, [hl]
	ld hl, LightScreenEffectText
	jr .set_timer
.reflect
	bit SCREENS_REFLECT, [hl]
	jr nz, .failed
	set SCREENS_REFLECT, [hl]
	inc bc ; LightScreenCount -> ReflectCount
	ld hl, ReflectEffectText
.set_timer
	ld a, HELD_PROLONG_SCREENS
	call GetItemBoostedDuration
	ld [bc], a
	call AnimateCurrentMove
	jp StdBattleTextBox

.failed
	call AnimateFailedMove
	jp PrintButItFailed

; 3733d


GetItemBoostedDuration:
	push bc
	push hl
	ld c, a
	push bc
	call GetUserItem
	ld a, b
	pop bc
	cp c
	ld a, 5
	jr nz, .got_duration
	ld a, 8
.got_duration
	pop hl
	pop bc
	ret


PrintDoesntAffect: ; 3733d
; 'it doesn't affect'
	ld hl, DoesntAffectText
	jp StdBattleTextBox

; 37343


PrintNothingHappened: ; 37343
; 'but nothing happened!'
	ld hl, NothingHappenedText
	jp StdBattleTextBox

; 37349


TryPrintButItFailed:
	call CheckAlreadyExecuted
	ret nz
PrintButItFailed: ; 3734e
; 'but it failed!'
	ld hl, ButItFailedText
	jp StdBattleTextBox

; 37354


FailDisable:
FailAttract:
FailForesight:
FailSpikes:
PrintDidntAffect2:
	call AnimateFailedMove
	; fallthrough

PrintDidntAffect:
; 'it didn't affect'
	ld hl, DidntAffectText
	jp StdBattleTextBox

PrintParalyze: ; 37372
; 'paralyzed! maybe it can't attack!'
	ld hl, ParalyzedText
	jp StdBattleTextBox

; 37378

CheckSubstituteOpp: ; 37378
; returns z when not behind a sub (or if overridden by Infiltrator or sound)
	ld a, BATTLE_VARS_ABILITY
	call GetBattleVar
	cp INFILTRATOR
	ret z
	; don't let move effects impact ability processing
	ld a, [wAnimationsDisabled]
	and a
	jr nz, .no_sound_move
	push bc
	push de
	push hl
	ld a, BATTLE_VARS_MOVE_ANIM
	call GetBattleVar
	ld hl, SoundMoves
	ld de, 1
	call IsInArray
	pop hl
	pop de
	pop bc
	jr nc, .no_sound_move
	xor a
	ret
.no_sound_move
	ld a, BATTLE_VARS_SUBSTATUS4_OPP
	call GetBattleVar
	bit SUBSTATUS_SUBSTITUTE, a
	ret

; 37380


BattleCommand_selfdestruct: ; 37380
	call GetOpponentAbilityAfterMoldBreaker
	cp DAMP
	ret z ; nullification ability checks handle messages
	ld hl, wWhichMonFaintedFirst
	ld a, [hl]
	and a
	jr nz, .faint_target_chosen
	ld a, [hBattleTurn]
	inc a
	ld [hl], a
.faint_target_chosen
	ld a, BATTLEANIM_PLAYER_DAMAGE
	ld [wNumHits], a
	ld c, 3
	call DelayFrames
	ld a, BATTLE_VARS_STATUS
	call GetBattleVarAddr
	xor a
	ld [hli], a
	inc hl
	ld [hli], a
	ld [hl], a
	ld a, $1
	ld [wKickCounter], a
	call BattleCommand_lowersub
	call LoadMoveAnim
	ld a, BATTLE_VARS_SUBSTATUS4
	call GetBattleVarAddr
	res SUBSTATUS_LEECH_SEED, [hl]
	ld a, BATTLE_VARS_SUBSTATUS2_OPP
	call GetBattleVarAddr
	res SUBSTATUS_DESTINY_BOND, [hl]
	call _CheckBattleEffects
	ret nc
	farcall DrawPlayerHUD
	farcall DrawEnemyHUD
	call ApplyTilemapInVBlank
	jp RefreshBattleHuds

; 373c9


INCLUDE "engine/battle/effect_commands/metronome.asm"


CheckUserMove: ; 37462
; Return z if the user has move a.
	ld b, a
	ld de, wBattleMonMoves
	ld a, [hBattleTurn]
	and a
	jr z, .ok
	ld de, wEnemyMonMoves
.ok

	ld c, NUM_MOVES
.loop
	ld a, [de]
	inc de
	cp b
	ret z

	dec c
	jr nz, .loop

	ld a, 1
	and a
	ret

; 3747b


ResetTurn: ; 3747b
	ld hl, wPlayerCharging
	ld a, [hBattleTurn]
	and a
	jr z, .player
	ld hl, wEnemyCharging

.player
	ld [hl], 1
	xor a
	ld [wAlreadyDisobeyed], a
	call DoMove
	jp EndMoveEffect

; 37492


INCLUDE "engine/battle/effect_commands/thief.asm"


BattleCommand_arenatrap: ; 37517
; arenatrap

	; Doesn't work on an absent opponent.
	call CheckHiddenOpponent
	jr nz, .failed

	; Don't trap if the opponent is already trapped.
	ld a, BATTLE_VARS_SUBSTATUS2
	call GetBattleVarAddr
	bit SUBSTATUS_CANT_RUN, [hl]
	jr nz, .failed

	; Don't trap Ghost types
	call CheckIfTargetIsGhostType
	jr z, .immune

	; Otherwise trap the opponent.
	set SUBSTATUS_CANT_RUN, [hl]
	call AnimateCurrentMove
	ld hl, CantEscapeNowText
	jp StdBattleTextBox

.immune
	call AnimateFailedMove
	ld hl, DoesntAffectText
	jp StdBattleTextBox

.failed
	call AnimateFailedMove
	jp PrintButItFailed

; 37536


BattleCommand_defrost: ; 37563
; defrost

; Thaw the user.

	ld a, BATTLE_VARS_STATUS
	call GetBattleVarAddr
	bit FRZ, [hl]
	ret z
	res FRZ, [hl]

; Don't update the enemy's party struct in a wild battle.

	ld a, MON_STATUS
	call UserPartyAttr
	res FRZ, [hl]

.done
	call RefreshBattleHuds
	ld hl, WasDefrostedText
	jp StdBattleTextBox

; 37588


INCLUDE "engine/battle/effect_commands/curse.asm"

INCLUDE "engine/battle/effect_commands/protect.asm"

INCLUDE "engine/battle/effect_commands/endure.asm"

INCLUDE "engine/battle/effect_commands/spikes.asm"

INCLUDE "engine/battle/effect_commands/foresight.asm"

INCLUDE "engine/battle/effect_commands/perish_song.asm"

INCLUDE "engine/battle/effect_commands/rollout.asm"

BoostJumptable:
	dbw AVALANCHE, DoAvalanche
	dbw ACROBATICS, DoAcrobatics
	dbw FACADE, DoFacade
	dbw HEX, DoHex
	dbw VENOSHOCK, DoVenoshock
	dbw KNOCK_OFF, DoKnockOff
	dbw -1, -1

BattleCommand_conditionalboost:
	ld hl, BoostJumptable
	ld a, BATTLE_VARS_MOVE_ANIM
	call GetBattleVar
	jp BattleJumptable

DoAvalanche:
	call CheckOpponentWentFirst
	jr DoubleDamageIfNZ

DoAcrobatics:
	ld a, [hBattleTurn]
	and a
	ld hl, wBattleMonItem
	jr z, .got_item
	ld hl, wEnemyMonItem
.got_item
	ld a, [hl]
	and a
	ret nz
	jr DoubleDamage

DoFacade:
	ld a, BATTLE_VARS_STATUS
	call GetBattleVar
	and 1 << BRN | 1 << PSN | 1 << PAR
	jr DoubleDamageIfNZ

DoHex:
	ld a, BATTLE_VARS_STATUS_OPP
	call GetBattleVar
	and a
	jr DoubleDamageIfNZ

DoVenoshock:
	ld a, BATTLE_VARS_STATUS_OPP
	call GetBattleVar
	bit PSN, a
	jr DoubleDamageIfNZ

BattleCommand_doubleflyingdamage:
	ld a, BATTLE_VARS_SUBSTATUS3_OPP
	call GetBattleVar
	bit SUBSTATUS_FLYING, a
	jr DoubleDamageIfNZ

BattleCommand_doubleundergrounddamage:
	ld a, BATTLE_VARS_SUBSTATUS3_OPP
	call GetBattleVar
	bit SUBSTATUS_UNDERGROUND, a
	; fallthrough
DoubleDamageIfNZ:
	ret z
	; fallthrough
DoubleDamage:
	ld hl, wCurDamage + 1
	sla [hl]
	dec hl
	rl [hl]
	ret nc

	ld a, $ff
	ld [hli], a
	ld [hl], a
	ret

DoKnockOff:
	call CheckSubstituteOpp
	ret nz

	call OpponentCanLoseItem
	ret z

	ld hl, wCurDamage
	ld a, [hli]
	ld b, a
	ld c, [hl]
	push bc
	srl b
	rr c
	pop hl
	add hl, bc
	ld a, h
	ld [wCurDamage], a
	ld a, l
	ld [wCurDamage + 1], a
	ret

INCLUDE "engine/battle/effect_commands/attract.asm"

BattleCommand_happinesspower: ; 3784b
; happinesspower
	push bc
	ld hl, wBattleMonHappiness
	ld a, [hBattleTurn]
	and a
	jr z, .ok
	ld hl, wEnemyMonHappiness
.ok
	xor a
	ld [hMultiplicand + 0], a
	ld [hMultiplicand + 1], a
	ld a, [hl]
	ld [hMultiplicand + 2], a
	ld a, 10
	ld [hMultiplier], a
	call Multiply
	ld a, 25
	ld [hDivisor], a
	ld b, 4
	call Divide
	ld a, [hQuotient + 2]
	ld d, a
	pop bc
	ret

; 37874


BattleCommand_safeguard: ; 37939
; safeguard

	ld hl, wPlayerScreens
	ld de, wPlayerSafeguardCount
	ld a, [hBattleTurn]
	and a
	jr z, .ok
	ld hl, wEnemyScreens
	ld de, wEnemySafeguardCount
.ok
	bit SCREENS_SAFEGUARD, [hl]
	jr nz, .failed
	set SCREENS_SAFEGUARD, [hl]
	ld a, 5
	ld [de], a
	call AnimateCurrentMove
	ld hl, CoveredByVeilText
	jp StdBattleTextBox

.failed
	call AnimateFailedMove
	jp PrintButItFailed

; 37962


SafeCheckSafeguard: ; 37962
	push hl
	ld hl, wEnemyScreens
	ld a, [wEnemyAbility]
	ld b, a
	ld a, [hBattleTurn]
	and a
	jr z, .got_turn
	ld hl, wPlayerScreens
	ld a, [wPlayerAbility]
	ld b, a

.got_turn
	bit SCREENS_SAFEGUARD, [hl]
	jr z, .done
	ld a, b
	cp INFILTRATOR

.done
	pop hl
	ret

; 37972


BattleCommand_checksafeguard: ; 37972
; checksafeguard
	ld hl, wEnemyScreens
	ld a, [wEnemyAbility]
	ld b, a
	ld a, [hBattleTurn]
	and a
	jr z, .got_turn
	ld hl, wPlayerScreens
	ld a, [wPlayerAbility]
	ld b, a
.got_turn
	bit SCREENS_SAFEGUARD, [hl]
	ret z
	ld a, b
	cp INFILTRATOR
	ret z
	ld a, 1
	ld [wAttackMissed], a
	call BattleCommand_movedelay
	ld hl, SafeguardProtectText
	call StdBattleTextBox
	jp EndMoveEffect

; 37991


BattleCommand_getmagnitude: ; 37991
; getmagnitude

	push bc
	call BattleRandom
	ld b, a
	ld hl, .Magnitudes
.loop
	ld a, [hli]
	cp b
	jr nc, .ok
	inc hl
	inc hl
	jr .loop

.ok
	ld d, [hl]
	push de
	inc hl
	ld a, [hl]
	ld [wTypeMatchup], a
	call BattleCommand_movedelay
	ld hl, MagnitudeText
	call StdBattleTextBox
	pop de
	pop bc
	ret

.Magnitudes:
	;  /255, BP, magnitude
	db  13,  10,  4
	db  38,  30,  5
	db  89,  50,  6
	db 166,  70,  7
	db 217,  90,  8
	db 242, 110,  9
	db 255, 150, 10
; 379c9

BattleCommand_gyroball:
	push bc
	push de
	call SwitchTurn
	farcall GetSpeed
	push bc
	call SwitchTurn
	farcall GetSpeed
	pop de
	; User speed in BC, target speed in DE

	; This is counterintuitive (the logical choice is to set speed to 1),
	; but is how it's done in VII...
	ld a, b
	or c
	ld a, 1
	jr z, .got_power

	; We can't divide numbers >255, so scale down speed in that case
.scaledown_loop
	ld a, b
	and a
	jr z, .scaledown_ok
	srl b
	rr c
	srl d
	rr e
	jr .scaledown_loop
.scaledown_ok
	; Base Power = 25 * (Target Speed / User Speed), capped at 150
	xor a
	ld [hMultiplicand + 0], a
	ld a, d
	ld [hMultiplicand + 1], a
	ld a, e
	ld [hMultiplicand + 2], a
	ld a, 25
	ld [hMultiplier], a
	call Multiply

	ld a, c
	ld [hDivisor], a
	ld b, 4
	call Divide

	; Cap at min 1, max 150
	ld hl, hMultiplicand
	ld a, [hli]
	or [hl]
	ld a, 150
	jr nz, .got_power
	inc hl
	ld a, [hl]
	and a
	jr nz, .nonzero_power
	ld a, 1
	jr .got_power

.nonzero_power
	cp 151
	jr c, .got_power

	ld a, 150
.got_power
	pop de
	ld d, a
	pop bc
	ret

BattleCommand_lowkick:
	push bc
	push de
	ld a, [hBattleTurn]
	and a
	ld hl, wBattleMonSpecies
	jr nz, .got_opp_species
	ld hl, wEnemyMonSpecies
.got_opp_species
	ld a, [hl]
	ld hl, PokedexDataPointerTable
	dec a
	ld e, a
	ld d, 0
	add hl, de
	add hl, de
	ld a, BANK(PokedexDataPointerTable)
	call GetFarHalfword

	; skip the pokémon "type" (seed for bulbasaur, genetic for mewtwo, etc)
.loop
	farcall GetPokedexEntryBank
	call GetFarByte
	inc hl
	cp "@"
	jr nz, .loop

	; skip height by inc hl twice
	farcall GetPokedexEntryBank
	inc hl
	inc hl
	call GetFarHalfword ; now we have weight in hl
	ld d, h
	ld e, l

	ld a, BATTLE_VARS_ABILITY
	call GetBattleVar
	cp LIGHT_METAL
	jr nz, .not_light_metal
	srl d
	rr e

.not_light_metal
	ld hl, .WeightTable
.loop2
	ld a, [hli]
	ld c, a
	ld a, [hli]
	ld b, a
	ld a, [hli]
	sub e
	ld a, b
	sbc d
	jr nc, .loop2
.got_power
	pop de
	ld d, c
	pop bc
	ret

.WeightTable
	;    BP, weight
	dbw 120, 4407
	dbw 100, 2202
	dbw  80, 1100
	dbw  60, 550
	dbw  40, 218
	dbw  20, 0

CheckAnyOtherAliveMons:
; These return nz if any is alive
	ld a, [hBattleTurn]
	and a
	jr nz, CheckAnyOtherAliveEnemyMons
	; fallthrough
CheckAnyOtherAlivePartyMons:
	ld hl, wPartyMon1HP
	ld de, wCurPartyMon
	ld a, [wPartyCount]
	jr DoCheckAnyOtherAliveMons

CheckAnyOtherAliveOpponentMons:
	ld a, [hBattleTurn]
	and a
	jr nz, CheckAnyOtherAlivePartyMons
	; fallthrough
CheckAnyOtherAliveEnemyMons:
	ld a, [wBattleMode]
	dec a
	ret z
	ld hl, wOTPartyMon1HP
	ld de, wCurOTMon
	ld a, [wOTPartyCount]
	; fallthrough
DoCheckAnyOtherAliveMons:
	ld b, a
	ld a, [de]
	ld e, a
	ld d, b
	inc e
	; - 1 to account for the hl++
	ld bc, PARTYMON_STRUCT_LENGTH - 1

.loop
	ld a, [hli]
	or [hl]
	jr z, .not_alive

	; Ignore current mon
	dec e
	jr z, .not_alive2
	ret
.not_alive
	dec e
.not_alive2
	add hl, bc
	dec d
	jr nz, .loop
	ret

BattleCommand_switchout:
	call CheckAnyOtherAliveMons
	ret z
	ld a, 1 << SWITCH_DEFERRED | 1 << SWITCH_PURSUIT
	jp SetDeferredSwitch

BattleCommand_batonpass:
	call CheckAnyOtherAliveMons
	jr z, .failed

	ld a, [hBattleTurn]
	and a
	ld hl, wPlayerMinimized
	jr z, .got_minimize
	ld hl, wEnemyMinimized
.got_minimize
	xor a
	ld [hl], a

	call AnimateCurrentMove
	ld c, 20
	call DelayFrames
	ld a, 1 << SWITCH_DEFERRED | 1 << SWITCH_BATON_PASS
	jp SetDeferredSwitch

.failed
	call AnimateFailedMove
	jp PrintButItFailed

BattleCommand_pursuit: ; 37b1d
; pursuit
; Double damage if the opponent is switching.

	ld a, [wDeferredSwitch]
	and a
	ret z

	ld hl, wCurDamage + 1
	sla [hl]
	dec hl
	rl [hl]
	ret nc

	ld a, $ff
	ld [hli], a
	ld [hl], a
	ret

; 37b39


BattleCommand_clearhazards: ; 37b39
; clearhazards

	ld a, BATTLE_VARS_SUBSTATUS4
	call GetBattleVarAddr
	bit SUBSTATUS_LEECH_SEED, [hl]
	jr z, .not_leeched
	res SUBSTATUS_LEECH_SEED, [hl]
	ld hl, ShedLeechSeedText
	call StdBattleTextBox
.not_leeched
	ld a, [hBattleTurn]
	and a
	ld hl, wPlayerScreens
	ld de, wPlayerWrapCount
	jr z, .got_screens_wrap
	ld hl, wEnemyScreens
	ld de, wEnemyWrapCount
.got_screens_wrap
	push de
	ld a, [hl]
	and SCREENS_SPIKES
	jr z, .no_spikes
	cpl
	and [hl]
	ld [hl], a
	push hl
	ld hl, BlewSpikesText
	call StdBattleTextBox
	pop hl
.no_spikes
	ld a, [hl]
	and SCREENS_TOXIC_SPIKES
	jr z, .no_toxic_spikes
	cpl
	and [hl]
	ld [hl], a
	ld hl, BlewToxicSpikesText
	call StdBattleTextBox
.no_toxic_spikes
	pop de
	ld a, [de]
	and a
	ret z
	xor a
	ld [de], a
	ld hl, ReleasedByText
	jp StdBattleTextBox

; 37b74


BattleCommand_healweather:
	farcall CheckFullHP
	jr z, .full

	ld a, [hBattleTurn]
	and a
	ld a, [wBattleMonType1]
	ld b, a
	ld a, [wBattleMonType2]
	ld c, a
	jr z, .got_types
	ld a, [wEnemyMonType1]
	ld b, a
	ld a, [wEnemyMonType2]
	ld c, a
.got_types
	ld a, b
	cp GRASS
	jr z, .synthesis_anim
	ld a, c
	cp GRASS
	jr z, .synthesis_anim
	ld a, [wTimeOfDay]
	cp NITE
	jr nc, .moonlight_anim
	xor a ; Morning Sun anim
	jr .got_anim
.moonlight_anim
	ld a, $1
	jr .got_anim
.synthesis_anim
	ld a, $2
.got_anim
	ld [wKickCounter], a
	call AnimateCurrentMove

	call GetWeatherAfterCloudNine
	cp WEATHER_SUN
	jr z, .goodheal
	and a
	jr nz, .badheal
	call GetHalfMaxHP
	jr .amount_ok
.badheal
	call GetQuarterMaxHP
	jr .amount_ok
.goodheal
	call GetThirdMaxHP
	sla c
	rl b
.amount_ok
	farcall RestoreHP
	call UpdateUserInParty

; 'regained health!'
	ld hl, RegainedHealthText
	jp StdBattleTextBox

.full
	call AnimateFailedMove
	ld hl, HPIsFullText
	jp StdBattleTextBox

BattleCommand_hiddenpower: ; 37be8
; hiddenpower

	ld a, [wAttackMissed]
	and a
	ret nz
	farjp HiddenPowerDamageStats

; 37bf4


BattleCommand_startsun:
	lb bc, WEATHER_SUN, HELD_PROLONG_SUN
	ld hl, SunGotBrightText
	jr StartWeather
BattleCommand_startrain:
	lb bc, WEATHER_RAIN, HELD_PROLONG_RAIN
	ld hl, DownpourText
	jr StartWeather
BattleCommand_startsandstorm:
	lb bc, WEATHER_SANDSTORM, HELD_PROLONG_SANDSTORM
	ld hl, SandstormBrewedText
	jr StartWeather
BattleCommand_starthail:
	lb bc, WEATHER_HAIL, HELD_PROLONG_HAIL
	ld hl, HailStartedText
StartWeather:
	ld a, b
	ld [wWeather], a
	ld a, c
	call GetItemBoostedDuration
	ld [wWeatherCount], a
	call AnimateCurrentMove
	jp StdBattleTextBox ; hl has text pointer already


BattleCommand_bellydrum: ; 37c1a
; bellydrum
	call GetHalfMaxHP
	call CompareHP
	jr c, .failed
	jr z, .failed

	call BattleCommand_attackup2
	ld a, [wAttackMissed]
	and a
	jr nz, .failed

	push bc
	call AnimateCurrentMove
	pop bc
	call GetHalfMaxHP
	farcall SubtractHPFromUser
	call UpdateUserInParty
	ld a, 5

.max_attack_loop
	push af
	call BattleCommand_attackup2
	pop af
	dec a
	jr nz, .max_attack_loop

	ld hl, BellyDrumText
	jp StdBattleTextBox

.failed
	call AnimateFailedMove
	jp PrintButItFailed

; 37c55


BattleCommand_doubleminimizedamage: ; 37ce6
; doubleminimizedamage

	ld hl, wEnemyMinimized
	ld a, [hBattleTurn]
	and a
	jr z, .ok
	ld hl, wPlayerMinimized
.ok
	ld a, [hl]
	and a
	ret z
	ld hl, wCurDamage + 1
	sla [hl]
	dec hl
	rl [hl]
	ret nc
	ld a, $ff
	ld [hli], a
	ld [hl], a
	ret

; 37d02


BattleCommand_skipsuncharge: ; 37d02
; mimicsuncharge
	call GetWeatherAfterCloudNine
	cp WEATHER_SUN
	ret nz
	ld b, charge_command
	jp SkipToBattleCommandAfter

; 37d0d


BattleCommand_checkfuturesight: ; 37d0d
; checkfuturesight

	ld hl, wPlayerFutureSightCount
	ld de, wPlayerFutureSightDamage
	ld a, [hBattleTurn]
	and a
	jr z, .ok
	ld hl, wEnemyFutureSightCount
	ld de, wEnemyFutureSightDamage
.ok

	ld a, [hl]
	and a
	ret z
	cp 1
	ret nz

	ld [hl], 0
	ld a, [de]
	inc de
	ld [wCurDamage], a
	ld a, [de]
	ld [wCurDamage + 1], a
	ld b, futuresight_command
	jp SkipToBattleCommandAfter

; 37d34

BattleCommand_futuresight: ; 37d34
; futuresight

	call CheckUserIsCharging
	jr nz, .AlreadyChargingFutureSight
	ld a, BATTLE_VARS_MOVE_ANIM
	call GetBattleVar
	ld b, a
	ld a, BATTLE_VARS_LAST_COUNTER_MOVE
	call GetBattleVarAddr
	ld [hl], b
	ld a, BATTLE_VARS_LAST_MOVE
	call GetBattleVarAddr
	ld [hl], b
.AlreadyChargingFutureSight:
	ld hl, wPlayerFutureSightCount
	ld a, [hBattleTurn]
	and a
	jr z, .GotFutureSightCount
	ld hl, wEnemyFutureSightCount
.GotFutureSightCount:
	ld a, [hl]
	and a
	jr nz, .failed
	ld a, 4
	ld [hl], a
	call BattleCommand_lowersub
	call BattleCommand_movedelay
	ld hl, ForesawAttackText
	call StdBattleTextBox
	call BattleCommand_raisesub
	ld de, wPlayerFutureSightDamage
	ld a, [hBattleTurn]
	and a
	jr z, .StoreDamage
	ld de, wEnemyFutureSightDamage
.StoreDamage:
	ld hl, wCurDamage
	ld a, [hl]
	ld [de], a
	ld [hl], 0
	inc hl
	inc de
	ld a, [hl]
	ld [de], a
	ld [hl], 0
	jp EndMoveEffect

.failed
	pop bc
	call ResetDamage
	call AnimateFailedMove
	call PrintButItFailed
	jp EndMoveEffect

; 37d94


BattleCommand_thunderaccuracy: ; 37d94
; thunderaccuracy

	ld a, BATTLE_VARS_MOVE_TYPE
	call GetBattleVarAddr
	inc hl
	call GetWeatherAfterCloudNine
	cp WEATHER_RAIN
	jr z, .rain
	cp WEATHER_SUN
	ret nz
	ld [hl], 50 percent + 1
	ret

.rain
	ld [hl], 100 percent
	ret

; 37daa


CheckHiddenOpponent: ; 37daa
	ld a, BATTLE_VARS_SUBSTATUS3_OPP
	call GetBattleVar
	and 1 << SUBSTATUS_FLYING | 1 << SUBSTATUS_UNDERGROUND
	ret

; 37db2

GetPlayerItem::
	ld hl, wBattleMonItem
	ld b, [hl]
	jr GetItemHeldEffect

GetEnemyItem::
	ld hl, wEnemyMonItem
	ld b, [hl]
	jr GetItemHeldEffect

GetOpponentItem:
	call CallOpponentTurn
GetUserItem::
; Return the effect of the user's item in bc, and its id at hl.
; Also updates the object name buffer, allowing you to just
; GetCurItemName to get the item name
	ld hl, wBattleMonItem
	ld a, [hBattleTurn]
	and a
	jr z, .go
	ld hl, wEnemyMonItem
.go
	ld a, [hl]
	ld [wCurItem], a
	ld b, a
	jp GetItemHeldEffect

GetOpponentItemAfterUnnerve:
	call CallOpponentTurn
GetUserItemAfterUnnerve::
; Returns the effect of the user's item in bc, and its id at hl,
; unless it's a Berry and Unnerve is in effect.
	call GetUserItem
	ld a, BATTLE_VARS_ABILITY_OPP
	call GetBattleVar
	cp UNNERVE
	ret nz
	ld a, [hl]
	push de
	push hl
	ld de, 1
	ld hl, EdibleBerries
	call IsInArray
	pop hl
	pop de
	ret c
	ld hl, NoItem
	ld b, HELD_NONE
	ret

EdibleBerries:
	db CHERI_BERRY
	db CHESTO_BERRY
	db PECHA_BERRY
	db RAWST_BERRY
	db ASPEAR_BERRY
	db LEPPA_BERRY
	db ORAN_BERRY
	db PERSIM_BERRY
	db LUM_BERRY
	db SITRUS_BERRY
	db FIGY_BERRY
	db LIECHI_BERRY
	db GANLON_BERRY
	db SALAC_BERRY
	db PETAYA_BERRY
	db APICOT_BERRY
	db LANSAT_BERRY
	db STARF_BERRY
	db ENIGMA_BERRY
	db CUSTAP_BERRY
	db KEE_BERRY
	db MARANGABERRY
	; not eaten, so unaffected:
	; pomeg, kelpsy, qualot, hondew, grepa, tamato, jaboca, rowap
	db -1
NoItem:
	db NO_ITEM


GetItemHeldEffect: ; 37dd0
; Return the effect of item b in b and the param in c.
	ld a, b
	and a
	ret z

	push hl
	ld hl, ItemAttributes + ITEMATTR_EFFECT
	dec a
	ld c, a
	ld b, 0
	ld a, NUM_ITEMATTRS
	rst AddNTimes
	ld a, BANK(ItemAttributes)
	call GetFarHalfword
	ld b, l
	ld c, h
	pop hl
	ret


TryAnimateCurrentMove:
	call CheckAlreadyExecuted
	ret nz
	; fallthrough
AnimateCurrentMove: ; 37e01
	ld a, [wAnimationsDisabled]
	and a
	ret nz
	push hl
	push de
	push bc
	ld a, [wKickCounter]
	push af
	call BattleCommand_lowersub
	pop af
	ld [wKickCounter], a
	call LoadMoveAnim
	call BattleCommand_raisesub
	pop bc
	pop de
	pop hl
	ret

; 37e19


PlayDamageAnim: ; 37e19
	xor a
	ld [wFXAnimIDHi], a

	ld a, BATTLE_VARS_MOVE_ANIM
	call GetBattleVar
	and a
	ret z

	ld [wFXAnimIDLo], a

	ld a, [hBattleTurn]
	and a
	ld a, BATTLEANIM_ENEMY_DAMAGE
	jr z, .player
	ld a, BATTLEANIM_PLAYER_DAMAGE

.player
	ld [wNumHits], a

	jp PlayUserBattleAnim

; 37e36


LoadMoveAnim: ; 37e36
	xor a
	ld [wNumHits], a
	ld [wFXAnimIDHi], a

	ld a, BATTLE_VARS_MOVE_ANIM
	call GetBattleVar
	and a
	ret z

	; fallthrough
; 37e44


LoadAnim:
	ld [wFXAnimIDLo], a
	jr PlayUserBattleAnim

PlayOpponentBattleAnim: ; 37e54
	ld a, e
	ld [wFXAnimIDLo], a
	ld a, d
	ld [wFXAnimIDHi], a
	xor a
	ld [wNumHits], a
	call CallOpponentTurn
PlayUserBattleAnim:
	push hl
	push de
	push bc
	farcall PlayBattleAnim
	pop bc
	pop de
	pop hl
	ret


CallBattleCore: ; 37e73
	ld a, BANK(BattleCore)
	jp FarCall_hl

ShowPotentialAbilityActivation:
; This avoids duplicating checks to avoid text spam. This will run
; ShowAbilityActivation if animations are disabled (something only abilities do)
	ld a, [wAnimationsDisabled]
	and a
	ret z
	push hl
	ld h, a
	ld a, [hBattleTurn]
	inc a
	rrca
	rrca
	and h
	pop hl
	ret nz
	farcall ShowAbilityActivation
	ld a, [hBattleTurn]
	inc a
	rrca
	rrca
	push hl
	ld h, a
	ld a, [wAnimationsDisabled]
	or h
	ld [wAnimationsDisabled], a
	pop hl
	ret

AnimateFailedMove: ; 37e77
	ld a, [wAnimationsDisabled]
	and a
	ret nz
	call BattleCommand_lowersub
	call BattleCommand_movedelay
	jp BattleCommand_raisesub

; 37e80


BattleCommand_movedelay: ; 37e80
; movedelay
; Wait 40 frames.
	ld c, 40
	jp DelayFrames

; 37e85


BattleCommand_cleartext: ; 37e85
; cleartext

; Used in multi-hit moves.
	ld hl, .text
	jp BattleTextBox

.text
	db "@"
; 37e8c

EndMoveEffect:
	ld b, endmove_command
	; fallthrough
SkipToBattleCommand:
	ld c, 1
	jr BattleCommandJump
SkipToBattleCommandAfter:
	ld c, 2
	jr BattleCommandJump
SkipToBattleCommandBackwards:
	ld c, 0
BattleCommandJump:
; Skip over commands until reaching command b.
	ld a, [wBattleScriptBufferLoc]
	ld l, a
	ld a, [wBattleScriptBufferLoc + 1]
	ld h, a
.loop
	ld a, BANK(MoveEffects)
	call GetFarByte
	cp b
	jr z, .got_target
	ld a, c
	and a
	inc hl
	jr nz, .loop
	dec hl
	dec hl
	jr .loop

.got_target
	; Verify that this isn't actually a command argument
	dec hl
	ld a, BANK(MoveEffects)
	call GetFarByte
	inc hl
	cp FIRST_MOVEARG_COMMAND
	jr c, .target_valid
	cp LAST_MOVEARG_COMMAND + 1
	jr c, .loop

.target_valid
	ld a, c
	cp 2
	jr nz, .jump_done
	; c = 2: skip to command after
	inc hl
.jump_done
	ld a, l
	ld [wBattleScriptBufferLoc], a
	ld a, h
	ld [wBattleScriptBufferLoc + 1], a
	ret

AppearUserLowerSub: ; 37ec7
	farjp _AppearUserLowerSub

; 37ece


AppearUserRaiseSub: ; 37ece
	farjp _AppearUserRaiseSub

; 37ed5


_CheckBattleEffects: ; 37ed5
; Checks the options.  Returns carry if battle animations are disabled.
	push hl
	push de
	push bc
	farcall CheckBattleEffects
	pop bc
	pop de
	pop hl
	ret
