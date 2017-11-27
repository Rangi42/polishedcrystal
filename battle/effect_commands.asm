DoPlayerTurn: ; 34000
	call SetPlayerTurn

	ld a, [wPlayerAction]
	and a
	ret nz

	ld a, [BattleType]
	cp BATTLETYPE_GHOST
	jr nz, DoTurn

	ld hl, ScaredText
	jp StdBattleTextBox

; 3400a


DoEnemyTurn: ; 3400a
	call SetEnemyTurn

	ld a, [BattleType]
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
	ld [BattleScriptBufferLoc], a
	ld a, h
	ld [BattleScriptBufferLoc + 1], a

.ReadMoveEffectCommand:
	ld a, [BattleScriptBufferLoc]
	ld l, a
	ld a, [BattleScriptBufferLoc + 1]
	ld h, a

	inc hl
	ld a, l
	ld [BattleScriptBufferLoc], a
	ld a, h
	ld [BattleScriptBufferLoc + 1], a
	dec hl

	ld a, BANK(MoveEffectsPointers)
	call GetFarByte

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
	; Proc White Herb
	push af
	call CheckWhiteHerb
	call SwitchTurn
	call CheckWhiteHerb
	call SwitchTurn
	call CheckPowerHerb
	pop af
	ret

CheckTurn:
BattleCommand_CheckTurn:
; Repurposed as hardcoded turn handling. Useless as a command.
	; Move 0 immediately ends the turn (Used by Pursuit)
	ld a, BATTLE_VARS_MOVE
	call GetBattleVar
	and a
	jp z, EndTurn

	xor a
	ld [AttackMissed], a
	ld [EffectFailed], a
	ld [wKickCounter], a
	ld [AlreadyDisobeyed], a
	ld [AlreadyFailed], a
	ld [wSomeoneIsRampaging], a

	ld a, $10 ; 1.0
	ld [TypeModifier], a

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

	dec a
	ld [hl], a
	and a ; check if the sleep timer ran out
	jr z, .woke_up

	; Early Bird decreases the sleep timer twice as fast (including Rest).
	ld a, BATTLE_VARS_ABILITY
	call GetBattleVar
	cp EARLY_BIRD
	jr nz, .no_early_bird
	; duplicated, but too few lines to make merging it worth it
	ld a, [hl]
	dec a
	ld [hl], a
	and a ; check if the sleep timer ran out
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
	call CantMove
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
	ld a, BATTLE_VARS_MOVE
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
	ld a, BATTLE_VARS_MOVE
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
	call BattleCommand_Defrost

.not_frozen
	ld a, [hBattleTurn]
	and a
	jr nz, .enemy3
	ld hl, PlayerDisableCount
	jr .ok3
.enemy3
	ld hl, EnemyDisableCount
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
	ld [DisabledMove], a
	jr .ok4
.enemy4
	xor a
	ld [EnemyDisabledMove], a
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
	ld hl, PlayerConfuseCount
	jr .ok5
.enemy5
	ld hl, EnemyConfuseCount
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
	ld a, [DisabledMove]
	ld hl, CurPlayerMove
	jr .ok6
.enemy6
	ld a, [EnemyDisabledMove]
	ld hl, CurEnemyMove
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


CantMove: ; 341f0
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

; 34216

IncreaseMetronomeCount:
	; Don't arbitrarily boost usage counter twice on a turn
	call CheckUserIsCharging
	ret nz

	ld a, [hBattleTurn]
	and a
	ld de, PlayerSelectedMove
	ld hl, PlayerMetronomeCount
	jr z, .got_move_usage
	ld de, EnemySelectedMove
	ld hl, EnemyMetronomeCount
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
	call GetUserItemAfterUnnerve
	ld a, b
	cp HELD_WHITE_HERB
	ret nz

	call HasUserFainted
	ret z

	; Check if we have any reduced stat changes
	ld a, [hBattleTurn]
	and a
	ld hl, PlayerStatLevels
	jr z, .got_stat_levels
	ld hl, EnemyStatLevels
.got_stat_levels
	lb bc, NUM_LEVEL_STATS, 0
.stat_loop
	ld a, [hl]
	cp BASE_STAT_LEVEL
	jr nc, .not_lowered
	ld [hl], BASE_STAT_LEVEL
	ld c, 1
.not_lowered
	inc hl
	dec b
	jr nz, .stat_loop
	dec c
	ret nz
	farcall ItemRecoveryAnim
	call GetUserItem
	ld a, [hl]
	ld [wNamedObjectIndexBuffer], a
	call GetItemName
	ld hl, RegainedStatsWithItem
	call StdBattleTextBox
	farjp ConsumeUserItem

CheckPowerHerb:
	call GetUserItemAfterUnnerve
	ld a, b
	cp HELD_POWER_HERB
	ret nz

	ld a, [hl]
	ld [wNamedObjectIndexBuffer], a
	call GetItemName

	call HasUserFainted
	ret z

	ld a, BATTLE_VARS_SUBSTATUS3
	call GetBattleVar
	bit SUBSTATUS_CHARGED, a
	ret z

	farcall ItemRecoveryAnim
	call GetUserItem
	ld a, [hl]
	ld [wNamedObjectIndexBuffer], a
	call GetItemName

	ld hl, BattleText_UserChargedWithItem
	call StdBattleTextBox
	farcall ConsumeUserItem
	jp ResetTurn

OpponentCantMove: ; 34216
	call SwitchTurn
	call CantMove
	jp SwitchTurn

; 3421f


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
	ld [CriticalHit], a

	call HitSelfInConfusion
	call BattleCommand_ConfusedDamageCalc
	call BattleCommand_LowerSub

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
	ld c, $1
	call PlayerHurtItself
	jp BattleCommand_RaiseSub
.enemy
	ld c, $1
	call EnemyHurtItself
	jp BattleCommand_RaiseSub

; 343db


BattleCommand_CheckObedience: ; 343db
; checkobedience

	; Enemy can't disobey
	ld a, [hBattleTurn]
	and a
	ret nz

	call CheckUserIsCharging
	ret nz

	; If we've already checked this turn
	ld a, [AlreadyDisobeyed]
	and a
	ret nz

	xor a
	ld [AlreadyDisobeyed], a

	; No obedience in link battles
	; (since no handling exists for enemy)
	ld a, [wLinkMode]
	and a
	ret nz

	ld a, [InBattleTowerBattle]
	and a
	ret nz

	ld a, [InitialOptions]
	bit TRADED_AS_OT_OPT, a
	ret nz

	; If the monster's id doesn't match the player's,
	; some conditions need to be met.
	ld a, MON_ID
	call BattlePartyAttr
	ld a, [PlayerID]
	cp [hl]
	jr nz, .obeylevel
	inc hl
	ld a, [PlayerID + 1]
	cp [hl]
	ret z

.obeylevel
	; The maximum obedience level is constrained by owned badges:
	ld hl, JohtoBadges

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

	ld a, [BattleMonLevel]
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

	ld [BattleMonStatus], a

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
	ld a, [BattleMonMoves + 1]
	and a
	jr z, .DoNothing

; Don't bother trying to handle Disable.
	ld a, [DisabledMove]
	and a
	jr nz, .DoNothing


	ld hl, BattleMonPP
	ld de, BattleMonMoves
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
	ld hl, BattleMonPP
	ld a, [CurMoveNum]
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
	ld [AlreadyDisobeyed], a

	ld a, [w2DMenuNumRows]
	ld b, a

; Save the move we originally picked for afterward.
	ld a, [CurMoveNum]
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
	ld [CurMoveNum], a
	ld hl, BattleMonPP
	ld e, a
	ld d, 0
	add hl, de
	ld a, [hl]
	and $3f
	jr z, .RandomMove


; Use it.
	ld a, [CurMoveNum]
	ld c, a
	ld b, 0
	ld hl, BattleMonMoves
	add hl, bc
	ld a, [hl]
	ld [CurPlayerMove], a

	call SetPlayerTurn
	call UpdateMoveData
	call DoMove


; Restore original move choice.
	pop af
	ld [CurMoveNum], a


.EndDisobedience:
	xor a
	ld [LastPlayerMove], a
	ld [LastEnemyCounterMove], a

	; Break Encore too.
	ld hl, PlayerSubStatus2
	res SUBSTATUS_ENCORED, [hl]
	xor a
	ld [PlayerEncoreCount], a

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


BattleCommand_UsedMoveText: ; 34541
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

BattleCommand_DoTurn:
	call CheckUserIsCharging
	ret nz

	ld a, [hBattleTurn]
	and a
	ld hl, PlayerTurnsTaken
	jr z, .got_turns_taken
	ld hl, EnemyTurnsTaken
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
	call BattleCommand_MoveDelay

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

BattleCommand_Pressure:
	; Ignores Mold Breaker
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
	ld a, [CurPartyMon]
	ld bc, CurMoveNum
	ld de, BattleMonPP
	ld hl, PartyMon1PP
	jr z, .set_party_pp
	ld a, [wBattleMode]
	dec a
	ld a, [CurOTMon]
	ld bc, CurEnemyMoveNum
	ld de, EnemyMonPP
	ld hl, wWildMonPP
	jr z, .pp_vars_ok
	ld hl, OTPartyMon1PP
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

BattleCommand_Critical: ; 34631
; critical

; Determine whether this attack's hit will be critical.

	xor a
	ld [CriticalHit], a

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

	ld hl, BattleMonItem
	ld a, [BattleMonSpecies]
	jr .Item

.EnemyTurn:
	ld hl, EnemyMonItem
	ld a, [EnemyMonSpecies]

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

; +2 critical level (TODO: this also affects Dire Hit)
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
	ld [CriticalHit], a
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
	; 6.25% 12.5%  50%   100%
	db $10,  $20,  $80,  $ff
	;   0     1     2     3+
; 346b2


BattleCommand_TripleKick: ; 346b2
; triplekick

	ld a, [wKickCounter]
	ld b, a
	inc b
	ld hl, CurDamage + 1
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

BattleCommand_KickCounter: ; 346cd
; kickcounter

	ld hl, wKickCounter
	inc [hl]
	ret

; 346d2


BattleCommand_Stab: ; 346d2
; STAB = Same Type Attack Bonus
; Also handles type matchups and fire/water in sun/rain
; Uses an one-byte var to finally use for damage calculation. Max/min listed in case
; future extension is done to keep potential overflow/rounding errors in mind.
; Min value: $02 (quad-resist, no STAB, bad weather modifier)
; Base value: $10
; Max value: $c0 (quad-weak, STAB, good weather modifier
	; Struggle doesn't apply STAB or matchups
	ld a, BATTLE_VARS_MOVE
	call GetBattleVar
	cp STRUGGLE
	ret z

	; Apply type matchups
	call BattleCheckTypeMatchup
	; Store TypeModifier (handles effectiveness)
	ld a, [wTypeMatchup]
	ld [TypeModifier], a
	and a
	jr nz, .not_immune
	; Immunities are treated as we missing and dealing 0 damage
	ld hl, CurDamage
	xor a
	ld [hli], a
	ld [hl], a
	; AttackMissed being nonzero can mean special immunity, so avoid overriding it
	ld a, [AttackMissed]
	and a
	ret nz
	ld a, 1
	ld [AttackMissed], a
	ret

.not_immune
	; Apply STAB
	ld a, BATTLE_VARS_MOVE_TYPE
	call GetBattleVar
	ld b, a
	ld a, [hBattleTurn]
	and a
	ld hl, BattleMonType1
	jr z, .got_attacker_types
	ld hl, EnemyMonType1
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
	ld hl, CurDamage
	ld a, [hli]
	ld [hMultiplicand + 1], a
	ld a, [hld]
	ld [hMultiplicand + 2], a
	call Multiply

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


BattleCheckTypeMatchup:
	ld a, [hBattleTurn]
	and a
	ld hl, EnemyMonType1
	jr z, CheckTypeMatchup
	ld hl, BattleMonType1
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

	; check Air Balloon for Ground-type attacks
	ld a, BATTLE_VARS_MOVE_TYPE
	call GetBattleVar
	cp GROUND
	jr nz, .done_air_balloon

	call CheckAirBalloon
	jr nz, .done_air_balloon
	xor a
	ld [wTypeMatchup], a

.done_air_balloon
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
	ld a, BATTLE_VARS_MOVE
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
	ld a, [BattleType]
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
	jr z, .Immune
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

.AbilImmune:
	; most abilities are checked seperately, but Overcoat ends up here (powder)
	ld a, 3
	ld [AttackMissed], a
.Immune:
	xor a
	ld [wTypeMatchup], a
.End:
	pop hl
	ret

; 34833


BattleCommand_ResetTypeMatchup: ; 34833
; Reset the type matchup multiplier to 1.0, if the type matchup is not 0.
; If there is immunity in play, the move automatically misses.
	call BattleCheckTypeMatchup
	ld a, [wTypeMatchup]
	and a
	ld a, $10 ; 1.0
	jr nz, .reset
	call ResetDamage
	xor a
	ld [TypeModifier], a
	inc a
	ld [AttackMissed], a
	ret

.reset
	ld [wTypeMatchup], a
	ret

; 3484e

INCLUDE "battle/ai/switch.asm"

TypeMatchup: ; 34bb1
INCLUDE "battle/type_matchup.asm"
; 34cfd

InverseTypeMatchup:
INCLUDE "battle/inverse_type_matchup.asm"


BattleCommand_DamageVariation: ; 34cfd
; damagevariation

; Modify the damage spread between 85% and 100%.

; Because of the method of division the probability distribution
; is not consistent. This makes the highest damage multipliers
; rarer than normal.


; No point in reducing 1 or 0 damage.
	ld hl, CurDamage
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
	ld hl, CurDamage
	ld [hli], a
	ld a, [hQuotient + 2]
	ld [hl], a
	ret

BattleCommand_BounceBack:
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
	ld [TypeModifier], a
	ld hl, AttackMissed
	or [hl]
	ret nz
	inc [hl]
	ret

.prankster_done
	call GetOpponentAbilityAfterMoldBreaker
	cp MAGIC_BOUNCE
	ret nz

	; Someone behind Protect will not bounceback
	ld a, [AttackMissed]
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


BattleCommand_CheckHit:
	call .DreamEater
	jp z, .Miss

	call .Protect
	jp nz, .Miss_skipset

	call .Substitute
	jp nz, .Miss

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
	ld a, [TypeModifier]
	and a
	ret z

	; Now doing usual accuracy check
	ld a, [PlayerAccLevel]
	ld b, a
	ld a, [EnemyEvaLevel]
	ld c, a
	ld a, [hBattleTurn]
	and a
	jr z, .got_acc_eva
	ld a, [EnemyAccLevel]
	ld b, a
	ld a, [PlayerEvaLevel]
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
	cp 255
	jr nz, .got_base_acc
	; If internal accuracy is 255, insert
	; $100 instead to avoid 1/256 miss
	ld a, 1
	ld [hMultiplicand + 1], a
	xor a
.got_base_acc
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
	call BattleRandom
	cp b
	jr nc, .Miss
	ret


.Miss:
; Keep the damage value intact if we're using (Hi) Jump Kick.
	ld a, 1
.Miss_skipset:
; Used to set a special value to AttackMissed for message customization
	ld [AttackMissed], a
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
	ret z
	ld a, 2
	and a
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
	ld a, [PlayerAbility]
	cp NO_GUARD
	ret z
	ld a, [EnemyAbility]
	cp NO_GUARD
	ret


BattleCommand_EffectChance: ; 34ecc
; effectchance
	push bc
	push hl
	xor a
	ld [EffectFailed], a
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
	call BattleRandom
	cp b
	jr c, .end

.failed
	ld a, 1
	ld [EffectFailed], a
	and a
.end
	pop hl
	pop bc
	ret

; 34eee


BattleCommand_LowerSub: ; 34eee
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
	ld [FXAnimIDHi], a
	inc a
	ld [wKickCounter], a
	ld a, SUBSTITUTE
	jp LoadAnim

.mimic_anims
	call BattleCommand_LowerSubNoAnim
	jp BattleCommand_MoveDelay

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


BattleCommand_HitTarget: ; 34f57
; hittarget
	call BattleCommand_LowerSub
	call BattleCommand_HitTargetNoSub
	jp BattleCommand_RaiseSub

; 34f60


BattleCommand_HitTargetNoSub: ; 34f60
	ld a, [AttackMissed]
	and a
	jp nz, BattleCommand_MoveDelay

	ld a, [hBattleTurn]
	and a
	ld de, PlayerRolloutCount
	ld a, BATTLEANIM_ENEMY_DAMAGE
	jr z, .got_rollout_count
	ld de, EnemyRolloutCount
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
	ld a, [BattleMonSpecies]
	jr z, .got_user_species
	ld a, [EnemyMonSpecies]
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


BattleCommand_StatUpAnim: ; 34fd1
	ld a, [AttackMissed]
	and a
	jp nz, BattleCommand_MoveDelay

	xor a
	jr BattleCommand_StatUpDownAnim

; 34fdb


BattleCommand_StatDownAnim: ; 34fdb
	ld a, [AttackMissed]
	and a
	jp nz, BattleCommand_MoveDelay

	ld a, [hBattleTurn]
	and a
	ld a, BATTLEANIM_ENEMY_STAT_DOWN
	jr z, BattleCommand_StatUpDownAnim
	ld a, BATTLEANIM_WOBBLE

	; fallthrough
; 34feb


BattleCommand_StatUpDownAnim: ; 34feb
	ld [wNumHits], a

	ld a, BATTLE_VARS_MOVE_ANIM
	call GetBattleVar
	ld e, a
	ld d, 0
	cp DEFENSE_CURL
	jr nz, .not_defense_curl
	ld a, [hBattleTurn]
	and a
	ld a, [BattleMonSpecies]
	jr z, .got_user_species
	ld a, [EnemyMonSpecies]
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


BattleCommand_SwitchTurn: ; 34ffd
; switchturn

	ld a, [hBattleTurn]
	xor 1
	ld [hBattleTurn], a
	ret

; 35004


BattleCommand_RaiseSub: ; 35004
; raisesub

	ld a, BATTLE_VARS_SUBSTATUS4
	call GetBattleVar
	bit SUBSTATUS_SUBSTITUTE, a
	ret z

	call _CheckBattleEffects
	jp c, BattleCommand_RaiseSubNoAnim

	xor a
	ld [wNumHits], a
	ld [FXAnimIDHi], a
	ld a, $2
	ld [wKickCounter], a
	ld a, SUBSTITUTE
	jp LoadAnim

; 35023


BattleCommand_FailureText: ; 35023
; failuretext
; If the move missed or failed, load the appropriate
; text, and end the effects of multi-turn or multi-
; hit moves.
	ld a, [AttackMissed]
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
	call BattleCommand_RaiseSub
	jp EndMoveEffect

.fly_dig
	ld a, BATTLE_VARS_SUBSTATUS3
	call GetBattleVarAddr
	res SUBSTATUS_UNDERGROUND, [hl]
	res SUBSTATUS_FLYING, [hl]
	call AppearUserRaiseSub
	jp EndMoveEffect

; 3505e


BattleCommand_CheckFaint:
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
	call SwitchTurn
	farcall CheckFullHP
	push af
	call SwitchTurn
	pop af
	pop bc
	jr nz, .no_endure
	jr .enduring
.focus_band
	call BattleRandom
	cp c
	jr nc, .no_endure
.enduring
	push bc
	call BattleCommand_FalseSwipe
	pop bc
	jr nc, .no_endure
	jr .okay
.no_endure
	ld b, $0
.okay
	push bc
	call .check_sub
	ld c, $0
	ld a, [hBattleTurn]
	and a
	jr nz, .damage_player
	call EnemyHurtItself
	jr .done_damage

.damage_player
	call PlayerHurtItself

.done_damage
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
	ld a, [hl]
	ld [wNamedObjectIndexBuffer], a
	call GetItemName

	ld hl, HungOnText
	call StdBattleTextBox
	pop af
	dec a
	jp nz, ConsumeEnemyItem
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
	ld de, PlayerDamageTaken + 1
	ld a, [hBattleTurn]
	and a
	jr nz, .damage_taken
	ld de, EnemyDamageTaken + 1

.damage_taken
	ld a, [CurDamage + 1]
	ld b, a
	ld a, [de]
	add b
	ld [de], a
	dec de
	ld a, [CurDamage]
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
	ld a, [TypeModifier]
	and a
	jr z, .got_text
	ld a, BATTLE_VARS_MOVE_EFFECT
	call GetBattleVar
	cp EFFECT_FUTURE_SIGHT
	ld hl, ButItFailedText
	jr z, .got_text
	ld hl, AttackMissedText
	ld a, [CriticalHit]
	cp $ff
	jr nz, .got_text
	ld hl, UnaffectedText
.got_text
	call FailText_CheckOpponentProtect
	xor a
	ld [CriticalHit], a

	ld a, BATTLE_VARS_MOVE_EFFECT
	call GetBattleVar
	cp EFFECT_JUMP_KICK
	ret nz

	ld a, [TypeModifier]
	and a
	ret z

	ld hl, CurDamage
	ld a, [hli]
	ld b, [hl]
rept 3
	srl a
	rr b
endr
	ld [hl], b
	dec hl
	ld [hli], a
	or b
	jr nz, .do_at_least_1_damage
	inc a
	ld [hl], a
.do_at_least_1_damage
	ld hl, CrashedText
	call StdBattleTextBox
	ld a, $1
	ld [wKickCounter], a
	call LoadMoveAnim
	ld c, $1
	ld a, [hBattleTurn]
	and a
	jp nz, EnemyHurtItself
	jp PlayerHurtItself

FailText_CheckOpponentProtect: ; 35157
; Print an appropriate failure message, usually AttackMissed.
; An AttackMissed value of something other than 1 can override
; the message, used for Protect and some abilities.
; Important: To ensure proper message order, AttackMissed=3
; has side effects -- it triggers the ability.
; TODO: perhaps an enum?
	ld a, [AttackMissed]
	cp 1
	jr z, .printmsg
	cp 2
	jr z, .protected
	cp 3
	jr z, .ability_immune
	jr .printmsg ; just in case
.protected
	ld hl, ProtectingItselfText
.printmsg
	jp StdBattleTextBox
.ability_immune
	farjp RunEnemyNullificationAbilities

; 35165

BattleCommand_SuckerPunch:
	call CheckOpponentWentFirst
	jr nz, .failed

	; TODO: Is there a better way to check "player didn't fight"?
	; Because of how the battle core is designed, a player switch
	; or item use wont neccessarily imply going first from the
	; battle move scripts' point of view...
	ld a, [wPlayerAction]
	and a
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

BattleCommand_CriticalText: ; 35175
; criticaltext
; Prints the message for critical hits.

; If there is no message to be printed, wait 20 frames.
	ld a, [CriticalHit]
	and a
	jr z, .wait

	ld hl, CriticalHitText
	call StdBattleTextBox

	xor a
	ld [CriticalHit], a

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


BattleCommand_StartLoop: ; 35197
; startloop

	ld hl, PlayerRolloutCount
	ld a, [hBattleTurn]
	and a
	jr z, .ok
	ld hl, EnemyRolloutCount
.ok
	xor a
	ld [hl], a
	ret

; 351a5


BattleCommand_SuperEffectiveLoopText: ; 351a5
; supereffectivelooptext

	ld a, BATTLE_VARS_SUBSTATUS3
	call GetBattleVarAddr
	bit SUBSTATUS_IN_LOOP, a
	ret nz

	; fallthrough
; 351ad


BattleCommand_SuperEffectiveText: ; 351ad
; supereffectivetext

	ld a, [TypeModifier]
	cp $10 ; 1.0
	ret z
	push af
	ld a, [InverseBattleScore]
	ld hl, SuperEffectiveText
	jr nc, .super_effective
	ld hl, NotVeryEffectiveText
	dec a
	dec a
.super_effective
	inc a
	cp $80
	jr z, .score_ok
	ld [InverseBattleScore], a
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
	ret nz

	push hl
	call SwitchTurn
	call ResetMiss
	call BattleCommand_AttackUp2
	xor a
	ld b, a
	ld c, a
	ld a, [FailedMessage]
	and a
	jr z, .ok
	inc b
.ok
	push bc
	call ResetMiss
	call BattleCommand_SpecialAttackUp2
	pop bc
	ld a, [FailedMessage]
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
	ld a, [hl]
	ld [wNamedObjectIndexBuffer], a
	call GetItemName
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
	farcall ConsumeUserItem
.end
	pop hl
	jp SwitchTurn
.print_msg
	ld b, a
	inc b
	farcall GetStatName
	ld hl, BattleText_ItemSharplyRaised
	jp StdBattleTextBox

BattleCommand_PostFaintEffects:
; Effects that run after faint by an attack (Destiny Bond, Moxie, Aftermath, etc)
	ld hl, EnemyMonHP
	ld a, [hBattleTurn]
	and a
	jr z, .got_hp
	ld hl, BattleMonHP

.got_hp
	ld a, [hli]
	or [hl]
	ret nz

	ld a, BATTLE_VARS_SUBSTATUS2_OPP
	call GetBattleVar
	bit SUBSTATUS_DESTINY_BOND, a
	jr z, .no_dbond

	ld hl, TookDownWithItText
	call StdBattleTextBox

	farcall GetMaxHP
	farcall SubtractHPFromUser
	call SwitchTurn
	xor a
	ld [wNumHits], a
	ld [FXAnimIDHi], a
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
	call BattleCommand_PostHitEffects
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
	call nz, BattleCommand_SwitchOut
	jr .finish

.multiple_hit_raise_sub
	call BattleCommand_RaiseSub

.finish
	jp EndMoveEffect

BattleCommand_PostHitEffects:
; This can run even if someone is fainted. Take this into account.
	call HasEnemyFainted
	jr z, .skip_sub_check
	call CheckSubstituteOpp
	ret nz

.skip_sub_check
	ld a, [AttackMissed]
	and a
	ret nz

	farcall RunHitAbilities

	; Burst air balloons
	call HasEnemyFainted
	jr z, .air_balloon_done
	call CheckAirBalloon
	jr nz, .air_balloon_done

	ld hl, AirBalloonPoppedText
	call StdBattleTextBox
	call ConsumeEnemyItem

.air_balloon_done
	call HasEnemyFainted
	jr z, .rage_done
	ld a, BATTLE_VARS_SUBSTATUS4_OPP
	call GetBattleVar
	bit SUBSTATUS_RAGE, a
	jr z, .rage_done

	call SwitchTurn
	call ResetMiss
	call BattleCommand_AttackUp

	; don't print a failure message if we're maxed out in atk
	ld a, [FailedMessage]
	and a
	jr nz, .rage_done_switchturn

	ld hl, RageBuildingText
	call StdBattleTextBox
	call BattleCommand_StatUpMessage

.rage_done_switchturn
	call SwitchTurn
.rage_done
	; Do Rocky Helmet
	call HasUserFainted
	jr z, .rocky_helmet_done
	call CheckContactMove
	jr c, .rocky_helmet_done
	call GetOpponentItemAfterUnnerve
	ld a, b
	cp HELD_ROCKY_HELMET
	jr nz, .rocky_helmet_done
	push hl
	farcall GetThirdMaxHP
	srl b
	rr c
	ld a, b
	or c
	jr nz, .damage_ok
	inc c
.damage_ok
	farcall SubtractHPFromUser
	pop hl
	ld a, [hl]
	ld [wNamedObjectIndexBuffer], a
	call GetItemName
	ld hl, BattleText_UserHurtByItem
	call StdBattleTextBox

.rocky_helmet_done
	call GetUserItem
	ld a, [hl]
	ld [wNamedObjectIndexBuffer], a
	push bc
	call GetItemName
	pop bc
	ld a, b
	cp HELD_LIFE_ORB
	jr z, .life_orb
	cp HELD_SHELL_BELL
	jr z, .shell_bell
	cp HELD_FLINCH_UP
	call z, .flinch_up
	jp .checkfaint
.flinch_up
	; Ensure that the move doesn't already have a flinch rate.
	call HasEnemyFainted
	ret z
	ld a, BATTLE_VARS_MOVE_EFFECT
	call GetBattleVar
	cp EFFECT_FLINCH_HIT
	ret z
	cp EFFECT_STOMP
	ret z

	; Flinch items procs even after Rocky Helmet fainting
	ld a, 100
	call BattleRandomRange
	cp c
	call c, FlinchTarget
	ret
.shell_bell
	call .checkfaint
	ret z

	ld a, [CurDamage]
	ld b, a
	ld a, [CurDamage + 1]
	ld c, a
	or b
	ret z ; No damage was done
	srl b
	rr c
	srl b
	rr c
	srl b
	rr c
	ld a, b
	or c
	jr nz, .damage_ok2
	inc c
.damage_ok2
	farcall ItemRecoveryAnim
	farcall RestoreHP
	ld hl, BattleText_UserRecoveredWithItem
	jp StdBattleTextBox

.life_orb
	call .checkfaint
	ret z

	; Sheer Force weirdness (Ignore Life Orb recoil if a secondary effect was suppressed)
	ld a, [EffectFailed]
	and a
	jr z, .no_suppressed_effect
	ld a, BATTLE_VARS_ABILITY
	call GetBattleVar
	cp SHEER_FORCE
	ret z

.no_suppressed_effect
	xor a
	farcall GetMaxHP
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

BattleCommand_Pickpocket:
; If the opponent has Pickpocket, proc the item steal now
	; At this point, we can safely reset EffectFailed (This runs after everything else)
	xor a
	ld [EffectFailed], a
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
	call BattleCommand_Thief
.no_pickpocket
	jp SwitchTurn

BattleCommand_RageDamage:
; unused (Rage is now Attack boosts again)
	ret


DittoMetalPowder: ; 352b1
	ld a, MON_SPECIES
	call BattlePartyAttr
	ld a, [hBattleTurn]
	and a
	ld a, [hl]
	jr nz, .Ditto
	ld a, [TempEnemyMonSpecies]

.Ditto:
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
	call BattlePartyAttr
	ld a, [hBattleTurn]
	and a
	ld a, [hl]
	jr nz, .Unevolved
	ld a, [TempEnemyMonSpecies]

.Unevolved:
	dec a
	push hl
	push bc
	ld c, a
	ld b, 0
	ld hl, EvosAttacksPointers
	add hl, bc
	add hl, bc
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


BattleCommand_DamageStats: ; 352dc
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
	ld hl, EnemyMonDefense
	ld a, [hli]
	ld b, a
	ld c, [hl]

if !DEF(FAITHFUL)
	call HailDefenseBoost
endc

	ld hl, BattleMonAttack
	ld a, [EnemyAbility]
	cp INFILTRATOR
	jr z, .thickcluborlightball
	ld a, [EnemyScreens]
	bit SCREENS_REFLECT, a
	jr z, .thickcluborlightball
	ld a, [CriticalHit]
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

	ld hl, EnemyMonSpclDef
	ld a, [hli]
	ld b, a
	ld c, [hl]

	call SandstormSpDefBoost

	jr .lightscreen

.psystrike
	ld hl, EnemyMonDefense
	ld a, [hli]
	ld b, a
	ld c, [hl]

.lightscreen
	ld hl, BattleMonSpclAtk
	ld a, [EnemyAbility]
	cp INFILTRATOR
	jr z, .lightball
	ld a, [EnemyScreens]
	bit SCREENS_LIGHT_SCREEN, a
	jr z, .lightball
	ld a, [CriticalHit]
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

	ld a, [BattleMonLevel]
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
	ld hl, BattleMonDefense
	ld a, [hli]
	ld b, a
	ld c, [hl]

if !DEF(FAITHFUL)
	call HailDefenseBoost
endc

	ld hl, EnemyMonAttack
	ld a, [PlayerAbility]
	cp INFILTRATOR
	jr z, .thickcluborlightball
	ld a, [PlayerScreens]
	bit SCREENS_REFLECT, a
	jr z, .thickcluborlightball
	ld a, [CriticalHit]
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

	ld hl, BattleMonSpclDef
	ld a, [hli]
	ld b, a
	ld c, [hl]

	call SandstormSpDefBoost

	jr .lightscreen

.psystrike
	ld hl, BattleMonDefense
	ld a, [hli]
	ld b, a
	ld c, [hl]

.lightscreen
	ld hl, EnemyMonSpclAtk
	ld a, [PlayerAbility]
	cp INFILTRATOR
	jr z, .lightball
	ld a, [PlayerScreens]
	bit SCREENS_LIGHT_SCREEN, a
	jr z, .lightball
	ld a, [CriticalHit]
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

	ld a, [EnemyMonLevel]
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

	srl b
	rr c
	srl b
	rr c

	ld a, c
	or b
	jr nz, .done_bc
	inc c

.done_bc
	srl h
	rr l
	srl h
	rr l

	ld a, l
	or h
	jr nz, .finish
	inc l

.finish
	ld a, [wLinkMode]
	cp 3
	jr z, .done
; If we go back to the loop point,
; it's the same as doing this exact
; same check twice.
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
	call BattlePartyAttr
	ld a, [hBattleTurn]
	and a
	ld a, [hl]
	jr z, .checkpikachu
	ld a, [TempEnemyMonSpecies]
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
	call BattlePartyAttr
	ld a, [hBattleTurn]
	and a
	ld a, [hl]
	jr z, .CompareSpecies
	ld a, [TempEnemyMonSpecies]
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


BattleCommand_ClearMissDamage: ; 355d5
; clearmissdamage
	ld a, [AttackMissed]
	and a
	ret z

	jp ResetDamage

; 355dd


HitSelfInConfusion: ; 355dd
	call ResetDamage
	ld a, [hBattleTurn]
	and a
	ld hl, BattleMonDefense
	ld de, PlayerScreens
	ld a, [BattleMonLevel]
	jr z, .got_it

	ld hl, EnemyMonDefense
	ld de, EnemyScreens
	ld a, [EnemyMonLevel]
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
rept 3
	dec hl
endr
	ld a, [hli]
	ld l, [hl]
	ld h, a
	call TruncateHL_BC
	ld d, 40
	pop af
	ld e, a
	ret

ApplyAttackBoosts:
	ld hl, PlayerAtkLevel
	ld de, EnemyAtkLevel
	jr ApplyStatBoostDamageAfterUnaware
ApplySpecialAttackBoosts:
	ld hl, PlayerSAtkLevel
	ld de, EnemySAtkLevel
	jr ApplyStatBoostDamageAfterUnaware

ApplyDefenseBoosts:
	ld hl, EnemyDefLevel
	ld de, PlayerDefLevel
	jr ApplyDefStatBoostDamageAfterUnaware

ApplySpecialDefenseBoosts:
	ld hl, EnemySDefLevel
	ld de, PlayerSDefLevel
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
	ld a, [CriticalHit]
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
	ld a, [CriticalHit]
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

BattleCommand_ConfusedDamageCalc:
; Needed because several things are skipped
	call DamagePass1
	call DamagePass2
	push bc
	; This way we ignore Unnerve
	ld hl, PlayerAtkLevel
	ld de, EnemyAtkLevel
	call ApplyStatBoostDamage
	ld hl, PlayerDefLevel
	ld de, EnemyDefLevel
	call ApplyDefStatBoostDamage
	pop bc
	call DamagePass3
	jp DamagePass4

BattleCommand_DamageCalc: ; 35612
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
	ld a, $12
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
	ld a, $32
	call z, ApplyDamageMod

.no_flash_fire
	; Critical hits
	ld a, [CriticalHit]
	and a
	jr z, .no_crit

	ld a, BATTLE_VARS_ABILITY
	call GetBattleVar
	cp SNIPER
	ld a, $94
	jr z, .got_crit_mod
	ld a, $32
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
	ld a, $da
	jr z, .life_orb
	jr .done_attacker_item
.type_boost
	ld a, BATTLE_VARS_MOVE_TYPE
	call GetBattleVar
	cp c
	ld a, $65
.life_orb
	call z, ApplyDamageMod
	jr .done_attacker_item
.category_boost
	ld a, BATTLE_VARS_MOVE_CATEGORY
	call GetBattleVar
	cp c
	ld a, $ba
	call z, ApplyDamageMod
	jr .done_attacker_item
.choice
	ld a, c
	cp SP_ATTACK
	jr z, .choice_sat
	and a ; cp ATTACK
	jr nz, .done_attacker_item
	ld a, $32
	call ApplyPhysicalAttackDamageMod
	jr .done_attacker_item
.choice_sat
	ld a, $32
	call ApplySpecialAttackDamageMod
	jr .done_attacker_item
.metronome_item
	ld b, $55
	ld a, [hBattleTurn]
	and a
	ld a, [PlayerMetronomeCount]
	jr z, .got_metronome_count
	ld a, [EnemyMetronomeCount]
.got_metronome_count
	swap a
	add b
	call ApplyDamageMod
	jr .done_attacker_item
.expert_belt
	ld a, [TypeModifier]
	cp $11
	ld a, $65
	call nc, ApplyDamageMod
	; fallthrough
.done_attacker_item
	call GetOpponentItem

	ld a, b
	cp HELD_ASSAULT_VEST
	jr z, .assault_vest
	jr .done_defender_item
.assault_vest
	ld a, $23
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
	; Add 2 unless damage is at least $ff00 -- set CurDamage to $ff** in that case.
	ld hl, CurDamage
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


BattleCommand_ConstantDamage: ; 35726
; constantdamage

	ld hl, BattleMonLevel
	ld a, [hBattleTurn]
	and a
	jr z, .got_turn
	ld hl, EnemyMonLevel

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
	ld hl, EnemyMonHP
	ld a, [hBattleTurn]
	and a
	jr z, .got_hp
	ld hl, BattleMonHP
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
	ld hl, CurDamage
	ld [hli], a
	ld [hl], b
	ret

.reversal
	ld hl, BattleMonHP
	ld a, [hBattleTurn]
	and a
	jr z, .reversal_got_hp
	ld hl, EnemyMonHP
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
	call BattleCommand_DamageCalc
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


BattleCommand_Counter:
	lb bc, EFFECT_COUNTER, PHYSICAL
	jr BattleCommand_Counterattack
BattleCommand_MirrorCoat:
	lb bc, EFFECT_MIRROR_COAT, SPECIAL
BattleCommand_Counterattack:
	ld a, 1
	ld [AttackMissed], a
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

	call BattleCommand_ResetTypeMatchup
	ld a, [wTypeMatchup]
	and a
	ret z

	call CheckOpponentWentFirst
	ret z

	push bc
	ld a, BATTLE_VARS_LAST_COUNTER_MOVE_OPP
	call GetBattleVar
	dec a
	ld de, StringBuffer1
	call GetMoveData
	pop bc

	ld a, [StringBuffer1 + MOVE_POWER]
	and a
	ret z

	ld a, [StringBuffer1 + MOVE_CATEGORY]
	cp c
	ret nz

	ld hl, CurDamage
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
	ld [AttackMissed], a
	ret


BattleCommand_Encore: ; 35864
; encore

	ld hl, EnemyMonMoves
	ld de, EnemyEncoreCount
	ld a, [hBattleTurn]
	and a
	jr z, .ok
	ld hl, BattleMonMoves
	ld de, PlayerEncoreCount
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

	ld bc, BattleMonPP - BattleMonMoves - 1
	add hl, bc
	ld a, [hl]
	and $3f
	jp z, .failed
	ld a, [AttackMissed]
	and a
	jp nz, .failed
	ld a, BATTLE_VARS_SUBSTATUS2_OPP
	call GetBattleVarAddr
	bit SUBSTATUS_ENCORED, [hl]
	jp nz, .failed
	set SUBSTATUS_ENCORED, [hl]
	call BattleRandom
	and $3
rept 3
	inc a
endr
	ld [de], a
	call CheckOpponentWentFirst
	jr nz, .finish_move
	ld a, [hBattleTurn]
	and a
	jr z, .force_last_enemy_move

	push hl
	ld a, [LastPlayerMove]
	ld b, a
	ld c, 0
	ld hl, BattleMonMoves
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
	ld [CurMoveNum], a
	ld a, b
	ld [CurPlayerMove], a
	dec a
	ld de, wPlayerMoveStruct
	call GetMoveData
	jr .finish_move

.force_last_enemy_move
	push hl
	ld a, [LastEnemyMove]
	ld b, a
	ld c, 0
	ld hl, EnemyMonMoves
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
	ld [CurEnemyMoveNum], a
	ld a, b
	ld [CurEnemyMove], a
	dec a
	ld de, wEnemyMoveStruct
	call GetMoveData

.finish_move
	call AnimateCurrentMove
	ld hl, GotAnEncoreText
	call StdBattleTextBox
	jp CheckEnemyMentalHerb

.failed
	jp PrintDidntAffect2

; 35926


BattleCommand_PainSplit:
	call CheckHiddenOpponent
	jr nz, .failed

	call AnimateCurrentMove

	; Get HP
	ld a, [hBattleTurn]
	and a
	ld de, BattleMonHP + 1
	ld hl, EnemyMonHP + 1
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
	farcall GetMaxHP
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
	farcall GetMaxHP
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


BattleCommand_Sketch: ; 35a74
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
; If the opponent is transformed, fail.
	ld a, BATTLE_VARS_SUBSTATUS2_OPP
	call GetBattleVarAddr
	bit SUBSTATUS_TRANSFORMED, [hl]
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
	ld hl, BattleMonMoves
	ld a, [hBattleTurn]
	and a
	jr z, .get_last_move
	ld hl, EnemyMonMoves
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
	ld bc, BattleMonPP - BattleMonMoves
	add hl, bc
	ld [hl], a
	pop bc

	ld a, [hBattleTurn]
	and a
	jr z, .user_trainer
	ld a, [wBattleMode]
	dec a
	jr nz, .user_trainer
; wildmon
	ld a, [hl]
	push bc
	ld hl, wWildMonPP
	ld b, 0
	add hl, bc
	ld [hl], a
	ld hl, wWildMonMoves
	add hl, bc
	pop bc
	ld [hl], b
	jr .done_copy

.user_trainer
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


BattleCommand_SleepTalk: ; 35b33
; sleeptalk

	call ClearLastMove
	ld a, [AttackMissed]
	and a
	jr nz, .fail
	ld a, [hBattleTurn]
	and a
	ld hl, BattleMonMoves + 1
	ld a, [DisabledMove]
	ld d, a
	jr z, .got_moves
	ld hl, EnemyMonMoves + 1
	ld a, [EnemyDisabledMove]
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
	ld a, BATTLE_VARS_MOVE_ANIM
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
	call BattleCommand_LowerSub
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
	ld a, [DisabledMove]
	jr z, .got_move_2

	ld a, [EnemyDisabledMove]
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


BattleCommand_DestinyBond: ; 35bff
; destinybond

	ld a, BATTLE_VARS_SUBSTATUS2
	call GetBattleVarAddr
	set SUBSTATUS_DESTINY_BOND, [hl]
	call AnimateCurrentMove
	ld hl, DestinyBondEffectText
	jp StdBattleTextBox

; 35c0f


BattleCommand_FalseSwipe: ; 35c94
; falseswipe

	ld hl, EnemyMonHP
	ld a, [hBattleTurn]
	and a
	jr z, .got_hp
	ld hl, BattleMonHP
.got_hp
	ld de, CurDamage
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
	ld a, [CriticalHit]
	cp $2
	jr nz, .carry
	xor a
	ld [CriticalHit], a
.carry
	scf
	ret

.done
	and a
	ret

; 35cc9


BattleCommand_HealBell: ; 35cc9
; healbell

	ld de, PartyMon1Status
	ld a, [hBattleTurn]
	and a
	jr z, .got_status
	ld de, OTPartyMon1Status
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
	ld [FXAnimIDLo], a
	ld a, d
	ld [FXAnimIDHi], a

	ld c, 3
	call DelayFrames

	farcall PlayBattleAnim

	ret

; 35d1c


EnemyHurtItself: ; 35d1c
	ld hl, CurDamage
	ld a, [hli]
	ld b, a
	ld a, [hl]
	or b
	jr z, .did_no_damage

	ld a, c
	and a
	jr nz, .mimic_sub_check

	ld a, [EnemySubStatus4]
	bit SUBSTATUS_SUBSTITUTE, a
	jp nz, SelfInflictDamageToSubstitute

.mimic_sub_check
	ld a, [hld]
	ld b, a
	ld a, [EnemyMonHP + 1]
	ld [Buffer3], a
	sub b
	ld [EnemyMonHP + 1], a
	ld a, [hl]
	ld b, a
	ld a, [EnemyMonHP]
	ld [Buffer4], a
	sbc b
	ld [EnemyMonHP], a
	jr nc, .mimic_faint

	ld a, [Buffer4]
	ld [hli], a
	ld a, [Buffer3]
	ld [hl], a

	xor a
	ld hl, EnemyMonHP
	ld [hli], a
	ld [hl], a

.mimic_faint
	ld hl, EnemyMonMaxHP
	ld a, [hli]
	ld [Buffer2], a
	ld a, [hl]
	ld [Buffer1], a
	ld hl, EnemyMonHP
	ld a, [hli]
	ld [Buffer6], a
	ld a, [hl]
	ld [Buffer5], a
	hlcoord 1, 2
	xor a
	ld [wWhichHPBar], a
	predef AnimateHPBar
.did_no_damage
	jp RefreshBattleHuds

; 35d7e


PlayerHurtItself: ; 35d7e
	ld hl, CurDamage
	ld a, [hli]
	ld b, a
	ld a, [hl]
	or b
	jr z, .did_no_damage

	ld a, c
	and a
	jr nz, .mimic_sub_check

	ld a, [PlayerSubStatus4]
	bit SUBSTATUS_SUBSTITUTE, a
	jp nz, SelfInflictDamageToSubstitute
.mimic_sub_check
	ld a, [hld]
	ld b, a
	ld a, [BattleMonHP + 1]
	ld [Buffer3], a
	sub b
	ld [BattleMonHP + 1], a
	ld [Buffer5], a
	ld b, [hl]
	ld a, [BattleMonHP]
	ld [Buffer4], a
	sbc b
	ld [BattleMonHP], a
	ld [Buffer6], a
	jr nc, .mimic_faint

	ld a, [Buffer4]
	ld [hli], a
	ld a, [Buffer3]
	ld [hl], a
	xor a

	ld hl, BattleMonHP
	ld [hli], a
	ld [hl], a
	ld hl, Buffer5
	ld [hli], a
	ld [hl], a

.mimic_faint
	ld hl, BattleMonMaxHP
	ld a, [hli]
	ld [Buffer2], a
	ld a, [hl]
	ld [Buffer1], a
	hlcoord 11, 9
	ld a, $1
	ld [wWhichHPBar], a
	predef AnimateHPBar
.did_no_damage
	jp RefreshBattleHuds

; 35de0


SelfInflictDamageToSubstitute: ; 35de0

	ld hl, SubTookDamageText
	call StdBattleTextBox

	ld de, EnemySubstituteHP
	ld a, [hBattleTurn]
	and a
	jr z, .got_hp
	ld de, PlayerSubstituteHP
.got_hp

	ld hl, CurDamage
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
	call BattleCommand_LowerSubNoAnim
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

	ld [CurMove], a
	ld [wNamedObjectIndexBuffer], a

	dec a
	call GetMoveData
	call GetMoveName
	jp CopyName1

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
	farcall UseEnemyHeldStatusHealingItem
	farjp RunEnemyStatusHealAbilities

BattleCommand_SleepTarget:
	ld b, 1
	call CanSleepTarget
	jr c, .ability_ok
	jr nz, .failed

	call CheckSubstituteOpp
	ld hl, ButItFailedText
	jr nz, .failed
	ld a, [AttackMissed]
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
	ld a, [hl]
	ld [wNamedObjectIndexBuffer], a
	call GetItemName
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

BattleCommand_PoisonTarget:
	call CheckSubstituteOpp
	ret nz
	ld b, 1
	call CanPoisonTarget
	ret nz
	ld a, [TypeModifier]
	and a
	ret z
	ld a, [EffectFailed]
	and a
	ret nz

	call PoisonOpponent
	ld de, ANIM_PSN
	call PlayOpponentBattleAnim
	call RefreshBattleHuds

	ld hl, WasPoisonedText
	call StdBattleTextBox

	jp PostStatusWithSynchronize


BattleCommand_Poison:
	ld hl, DoesntAffectText
	ld a, [TypeModifier]
	and a
	jp z, .failed

	call CheckSubstituteOpp
	ld hl, ButItFailedText
	jr nz, .failed
	ld a, [AttackMissed]
	and a
	ld hl, AttackMissedText
	jr nz, .failed

	ld b, 1
	call CanPoisonTarget
	jr c, .ability_ok
	jr nz, .failed

	call .check_toxic
	jr z, .toxic

	call .apply_poison
	ld hl, WasPoisonedText
	call StdBattleTextBox
	jr .finished

.toxic
	set TOX, [hl]
	xor a
	ld [de], a
	call .apply_poison

	ld hl, BadlyPoisonedText
	call StdBattleTextBox

.finished
	jp PostStatusWithSynchronize

.ability_ok
	farcall ShowEnemyAbilityActivation
	ld hl, DoesntAffectText
.failed
	push hl
	call AnimateFailedMove
	pop hl
	jp StdBattleTextBox

; 35fc0


.apply_poison ; 35fc0
	call AnimateCurrentMove
	call PoisonOpponent
	jp RefreshBattleHuds

; 35fc9


.check_toxic ; 35fc9
	ld a, BATTLE_VARS_STATUS_OPP
	call GetBattleVarAddr
	ld a, [hBattleTurn]
	and a
	ld de, EnemyToxicCount
	jr z, .ok
	ld de, PlayerToxicCount
.ok
	ld a, BATTLE_VARS_MOVE_EFFECT
	call GetBattleVar
	cp EFFECT_TOXIC
	ret

; 35fe1


PoisonOpponent: ; 35ff5
	ld a, BATTLE_VARS_STATUS_OPP
	call GetBattleVarAddr
	set PSN, [hl]
	jp UpdateOpponentInParty

; 35fff


BattleCommand_DrainTarget: ; 35fff
; draintarget
	call SapHealth
	ld hl, SuckedHealthText
	jp StdBattleTextBox

; 36008


BattleCommand_EatDream: ; 36008
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
	ld hl, CurDamage
	ld a, [hli]
	ld b, a
	ld c, [hl]

	; halve result
	srl b
	rr c

	; for Drain Kiss, we want 75% drain instead of 50%
	ld a, BATTLE_VARS_MOVE
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
	; ensure minimum 1HP drained
	ld a, b
	and a
	jr nz, .skip_increase
	ld a, c
	and a
	jr nz, .skip_increase
	ld c, 1
.skip_increase
	call HandleBigRoot
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

BattleCommand_BurnTarget:
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
	ld a, [TypeModifier]
	and a
	ret z
	ld a, [EffectFailed]
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
	ld a, [CurOTMon]
	ld hl, OTPartyMon1Status
	jr z, .ok
	ld hl, PartyMon1Status
	ld a, [CurBattleMon]
.ok

	call GetPartyLocation
	xor a
	ld [hl], a
	call UpdateOpponentInParty

	ld hl, DefrostedOpponentText
	jp StdBattleTextBox

BattleCommand_FreezeTarget:
	xor a
	ld [wNumHits], a
	call CheckSubstituteOpp
	ret nz
	ld a, BATTLE_VARS_STATUS_OPP
	call GetBattleVarAddr
	and a
	ret nz
	ld a, [TypeModifier]
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
	ld a, [EffectFailed]
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
	call EndRechargeOpp
	ld hl, wEnemyJustGotFrozen
	ld a, [hBattleTurn]
	and a
	jr z, .finish
	ld hl, wPlayerJustGotFrozen
.finish
	ld [hl], $1
	ret

BattleCommand_ParalyzeTarget:
	xor a
	ld [wNumHits], a
	call CheckSubstituteOpp
	ret nz
	ld b, 1
	call CanParalyzeTarget
	ret nz
	ld a, [TypeModifier]
	and a
	ret z
	ld a, [EffectFailed]
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

BattleCommand_CloseCombat:
	ld a, [AttackMissed]
	and a
	ret nz

	lb bc, DEFENSE, SP_DEFENSE
BattleCommand_SelfStatDownHit:
; input: 1-2 stats to decrease in b and c respectivey
	push bc
	call .lower
	pop bc
	ld b, c
.lower
	ld a, b
	and a
	ret z
	push bc
	call ResetMiss
	pop bc
	call LowerStat
	call SwitchTurn
	call BattleCommand_StatDownMessage
	jp SwitchTurn

BattleCommand_BulkUp:
	lb bc, ATTACK, DEFENSE
	jr BattleCommand_DoubleUp
BattleCommand_CalmMind:
	lb bc, SP_ATTACK, SP_DEFENSE
	jr BattleCommand_DoubleUp
BattleCommand_DragonDance:
	lb bc, ATTACK, SPEED
	jr BattleCommand_DoubleUp
BattleCommand_Growth:
	lb bc, ATTACK, SP_ATTACK
	call GetWeatherAfterCloudNine
	cp WEATHER_SUN
	jr nz, BattleCommand_DoubleUp
	lb bc, ($10 | ATTACK), ($10 | SP_ATTACK)
	jr BattleCommand_DoubleUp
BattleCommand_HoneClaws:
	lb bc, ATTACK, ACCURACY
BattleCommand_DoubleUp:
; stats to raise are in bc
	push bc ; StatUp clobbers c (via CheckIfStatCanBeRaised), which we want to retain
	call ResetMiss
	call BattleCommand_StatUp
	ld a, [FailedMessage]
	ld d, a ; note for 2nd stat
	ld e, 0	; track if we've shown animation
	and a
	call z, .msg_animate
	pop bc
	ld b, c
	push de
	call ResetMiss
	call BattleCommand_StatUp
	pop de
	ld a, [FailedMessage]
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
	call BattleCommand_StatUpMessage
	pop de
	ret

BattleCommand_AttackUp: ; 361ac
; attackup
	ld b, ATTACK
	jr BattleCommand_StatUp

BattleCommand_DefenseUp: ; 361b0
; defenseup
	ld b, DEFENSE
	jr BattleCommand_StatUp

BattleCommand_SpeedUp: ; 361b4
; speedup
	ld b, SPEED
	jr BattleCommand_StatUp

BattleCommand_SpecialAttackUp: ; 361b8
; specialattackup
	ld b, SP_ATTACK
	jr BattleCommand_StatUp

BattleCommand_SpecialDefenseUp: ; 361bc
; specialdefenseup
	ld b, SP_DEFENSE
	jr BattleCommand_StatUp

BattleCommand_AccuracyUp: ; 361c0
; accuracyup
	ld b, ACCURACY
	jr BattleCommand_StatUp

BattleCommand_EvasionUp: ; 361c4
; evasionup
	ld b, EVASION
	jr BattleCommand_StatUp

BattleCommand_AttackUp2: ; 361c8
; attackup2
	ld b, $10 | ATTACK
	jr BattleCommand_StatUp

BattleCommand_DefenseUp2: ; 361cc
; defenseup2
	ld b, $10 | DEFENSE
	jr BattleCommand_StatUp

BattleCommand_SpeedUp2: ; 361d0
; speedup2
	ld b, $10 | SPEED
	jr BattleCommand_StatUp

BattleCommand_SpecialAttackUp2: ; 361d4
; specialattackup2
	ld b, $10 | SP_ATTACK
	jr BattleCommand_StatUp

BattleCommand_SpecialDefenseUp2: ; 361d8
; specialdefenseup2
	ld b, $10 | SP_DEFENSE
	jr BattleCommand_StatUp

BattleCommand_AccuracyUp2: ; 361dc
; accuracyup2
	ld b, $10 | ACCURACY
	jr BattleCommand_StatUp

BattleCommand_EvasionUp2: ; 361e0
; evasionup2
	ld b, $10 | EVASION
	; fallthrough

BattleCommand_StatUp: ; 361e4
; statup
	call CheckIfStatCanBeRaised
	ld a, [FailedMessage]
	and a
	ret nz
	jp StatUpAnimation

; 361ef


CheckIfStatCanBeRaised:
	ld a, b
	ld [LoweredStat], a
	ld hl, PlayerStatLevels
	ld a, [hBattleTurn]
	and a
	jr z, .got_stat_levels
	ld hl, EnemyStatLevels
.got_stat_levels
	ld a, [AttackMissed]
	and a
	jp nz, .stat_raise_failed
	ld a, [EffectFailed]
	and a
	jp nz, .stat_raise_failed
	ld a, [LoweredStat]
	and $f
	ld c, a
	ld b, 0
	add hl, bc
	ld b, [hl]
	inc b
	ld a, $d
	cp b
	jp c, .cant_raise_stat
	ld a, [LoweredStat]
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
	ld [FailedMessage], a
	ret

.cant_raise_stat
	ld a, $2
	ld [FailedMessage], a
	ld a, $1
	ld [AttackMissed], a
	ret

.stat_raise_failed
	ld a, $1
	ld [FailedMessage], a
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
	call WaitBGMap
	jp BattleCommand_MoveDelay

; 362ad


BattleCommand_AttackDown: ; 362ad
; attackdown
	ld a, ATTACK
	jr BattleCommand_StatDown

BattleCommand_DefenseDown: ; 362b1
; defensedown
	ld a, DEFENSE
	jr BattleCommand_StatDown

BattleCommand_SpeedDown: ; 362b5
; speeddown
	ld a, SPEED
	jr BattleCommand_StatDown

BattleCommand_SpecialAttackDown: ; 362b9
; specialattackdown
	ld a, SP_ATTACK
	jr BattleCommand_StatDown

BattleCommand_SpecialDefenseDown: ; 362bd
; specialdefensedown
	ld a, SP_DEFENSE
	jr BattleCommand_StatDown

BattleCommand_AccuracyDown: ; 362c1
; accuracydown
	ld a, ACCURACY
	jr BattleCommand_StatDown

BattleCommand_EvasionDown: ; 362c5
; evasiondown
	ld a, EVASION
	jr BattleCommand_StatDown

BattleCommand_AttackDown2: ; 362c9
; attackdown2
	ld a, $10 | ATTACK
	jr BattleCommand_StatDown

BattleCommand_DefenseDown2: ; 362cd
; defensedown2
	ld a, $10 | DEFENSE
	jr BattleCommand_StatDown

BattleCommand_SpeedDown2: ; 362d1
; speeddown2
	ld a, $10 | SPEED
	jr BattleCommand_StatDown

BattleCommand_SpecialAttackDown2: ; 362d5
; specialattackdown2
	ld a, $10 | SP_ATTACK
	jr BattleCommand_StatDown

BattleCommand_SpecialDefenseDown2: ; 362d9
; specialdefensedown2
	ld a, $10 | SP_DEFENSE
	jr BattleCommand_StatDown

BattleCommand_AccuracyDown2: ; 362dd
; accuracydown2
	ld a, $10 | ACCURACY
	jr BattleCommand_StatDown

BattleCommand_EvasionDown2: ; 362e1
; evasiondown2
	ld a, $10 | EVASION

BattleCommand_StatDown: ; 362e3
; statdown

	ld [LoweredStat], a

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

	ld hl, EnemyStatLevels
	ld a, [hBattleTurn]
	and a
	jr z, .GetStatLevel
	ld hl, PlayerStatLevels

.GetStatLevel:
; Attempt to lower the stat.
	ld a, [LoweredStat]
	and $f
	ld c, a
	ld b, 0
	add hl, bc
	ld b, [hl]
	dec b
	jp z, .CantLower

; Sharply lower the stat if applicable.
	ld a, [LoweredStat]
	and $f0
	jr z, .ComputerMiss
	dec b
	jr nz, .ComputerMiss
	inc b

.ComputerMiss:
	call CheckSubstituteOpp
	jr nz, .Failed

	ld a, [AttackMissed]
	and a
	jr nz, .Failed

	ld a, [EffectFailed]
	and a
	jr nz, .Failed

	call CheckHiddenOpponent
	jr nz, .Failed

	ld [hl], b
	xor a
	ld [FailedMessage], a
	ret

.CouldntLower:
	inc [hl]
.CantLower:
	ld a, 3
	ld [FailedMessage], a
	ld a, 1
	ld [AttackMissed], a
	ret

.Failed:
	ld a, 1
	ld [FailedMessage], a
	ld [AttackMissed], a
	ret

.Mist:
	ld a, 2
	ld [FailedMessage], a
	ld a, 1
	ld [AttackMissed], a
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


BattleCommand_StatUpMessage: ; 363b8
	ld a, [FailedMessage]
	and a
	ret nz
	ld a, [LoweredStat]
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
	ld a, [LoweredStat]
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

BattleCommand_StatDownMessage:
	ld a, [FailedMessage]
	and a
	ret nz
	ld a, [LoweredStat]
	and $f
	ld b, a
	inc b
	call GetStatName
	ld hl, .stat
	call BattleTextBox
	; Competitive/Defiant activates here to give proper messages. A bit awkward,
	; but the alternative is to rewrite the stat-down logic.
	farjp RunEnemyStatIncreaseAbilities

.stat
	text_jump UnknownText_0x1c0ceb
	start_asm
	ld hl, .fell
	ld a, [LoweredStat]
	and $f0
	ret z
	ld hl, .sharplyfell
	ret

.sharplyfell
	text_jump UnknownText_0x1c0cf5
	db "@"
.fell
	text_jump UnknownText_0x1c0d06
	db "@"

BattleCommand_StatUpFailText: ; 3644c
; statupfailtext
	ld a, [FailedMessage]
	and a
	ret z
	push af
	call BattleCommand_MoveDelay
	pop af
	dec a
	jp z, TryPrintButItFailed
	ld a, [LoweredStat]
	and $f
	ld b, a
	inc b
	call GetStatName
	ld hl, WontRiseAnymoreText
	jp StdBattleTextBox

; 3646a


BattleCommand_StatDownFailText: ; 3646a
; statdownfailtext
	ld a, [FailedMessage]
	and a
	ret z
	push af
	call BattleCommand_MoveDelay
	pop af
	dec a
	jp z, TryPrintButItFailed
	dec a
	ld hl, ProtectedByMistText
	jp z, StdBattleTextBox
	ld a, [LoweredStat]
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
	ld de, StringBuffer2
	ld bc, StringBuffer3 - StringBuffer2
	jp CopyBytes

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


BattleCommand_AllStatsUp: ; 36500
; allstatsup

; Attack
	call ResetMiss
	call BattleCommand_AttackUp
	call BattleCommand_StatUpMessage

; Defense
	call ResetMiss
	call BattleCommand_DefenseUp
	call BattleCommand_StatUpMessage

; Speed
	call ResetMiss
	call BattleCommand_SpeedUp
	call BattleCommand_StatUpMessage

; Special Attack
	call ResetMiss
	call BattleCommand_SpecialAttackUp
	call BattleCommand_StatUpMessage

; Special Defense
	call ResetMiss
	call BattleCommand_SpecialDefenseUp
	jp   BattleCommand_StatUpMessage
; 3652d


ResetMiss: ; 3652d
	xor a
	ld [AttackMissed], a
	ret

; 36532

LowerStat:: ; 36532
	ld a, b
	ld [LoweredStat], a

	ld hl, PlayerStatLevels
	ld a, [hBattleTurn]
	and a
	jr z, .got_target
	ld hl, EnemyStatLevels

.got_target
	ld a, [LoweredStat]
	and $f
	ld c, a
	ld b, 0
	add hl, bc
	ld b, [hl]
	dec b
	jr z, .cant_lower_anymore

	ld a, [LoweredStat]
	and $f0
	jr z, .got_num_stages
	dec b
	jr nz, .got_num_stages
	inc b

.got_num_stages
	ld [hl], b
	xor a
	ld [FailedMessage], a
	ret

.failed
	inc [hl]

.cant_lower_anymore
	ld a, 2
	ld [FailedMessage], a
	ret

; 3658f


BattleCommand_TriStatusChance: ; 3658f
; tristatuschance

	call BattleCommand_EffectChance

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
	dw BattleCommand_ParalyzeTarget ; paralyze
	dw BattleCommand_FreezeTarget ; freeze
	dw BattleCommand_BurnTarget ; burn
; 365a7


BattleCommand_Curl: ; 365a7
; curl
	ld a, BATTLE_VARS_SUBSTATUS4
	call GetBattleVarAddr
	set SUBSTATUS_CURLED, [hl]
	ret

; 365af


BattleCommand_Burn:
	ld hl, DoesntAffectText
	ld a, [TypeModifier]
	and a
	jp z, .failed

	call CheckSubstituteOpp
	ld hl, ButItFailedText
	jr nz, .failed
	ld a, [AttackMissed]
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


BattleCommand_RaiseSubNoAnim: ; 365af
	ld hl, GetMonBackpic
	ld a, [hBattleTurn]
	and a
	jr z, .PlayerTurn
	ld hl, GetMonFrontpic
.PlayerTurn:
	xor a
	ld [hBGMapMode], a
	call CallBattleCore
	jp WaitBGMap

; 365c3


BattleCommand_LowerSubNoAnim: ; 365c3
	ld hl, DropPlayerSub
	ld a, [hBattleTurn]
	and a
	jr z, .PlayerTurn
	ld hl, DropEnemySub
.PlayerTurn:
	xor a
	ld [hBGMapMode], a
	call CallBattleCore
	jp WaitBGMap

BattleCommand_CheckRampage: ; 3671a
; checkrampage

	ld de, PlayerRolloutCount
	ld a, [hBattleTurn]
	and a
	jr z, .player
	ld de, EnemyRolloutCount
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
	push af
	call SwitchTurn
	pop af
	jr nz, .continue_rampage

	set SUBSTATUS_CONFUSED, [hl]
	call BattleRandom
	and %00000001
	inc a
	inc a
	inc de ; ConfuseCount
	ld [de], a
.continue_rampage
	ld b, rampage_command
	jp SkipToBattleCommandAfter

; 36751


BattleCommand_Rampage: ; 36751
; rampage

; No rampage during Sleep Talk.
	ld a, BATTLE_VARS_STATUS
	call GetBattleVar
	and SLP
	ret nz

	ld de, PlayerRolloutCount
	ld a, [hBattleTurn]
	and a
	jr z, .ok
	ld de, EnemyRolloutCount
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


BattleCommand_Teleport: ; 36778
; teleport

	ld a, [BattleType]
	cp BATTLETYPE_SHINY
	jr z, .failed
	cp BATTLETYPE_TRAP ; or BATTLETYPE_LEGENDARY
	jr nc, .failed

; Can't teleport from a trainer battle
	ld a, [wBattleMode]
	dec a
	jr nz, .failed
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
	ld [wForcedSwitch], a
	ld [wKickCounter], a
	call SetBattleDraw
	call BattleCommand_LowerSub
	call LoadMoveAnim
	ld c, 20
	call DelayFrames
	call SetBattleDraw

	ld hl, FledFromBattleText
	jp StdBattleTextBox
.failed
	call AnimateFailedMove
	jp PrintButItFailed

CheckIfTrappedByAbility:
	call _CheckIfTrappedByAbility
	ld a, b
	and a
	ret

_CheckIfTrappedByAbility:
	; Wrapper around ability checks to ensure that no double-traps happen.
	call CheckIfTrappedByAbilityInner
	ld a, b
	and a
	ret nz ; we aren't trapped
	call SwitchTurn
	call CheckIfTrappedByAbilityInner
	call SwitchTurn
	ld a, b
	and a
	jp z, .is_double_trap
	ld b, 0
	ret
.is_double_trap
	ld b, 1
	ret

CheckIfTrappedByAbilityInner:
	; Returns b=0 if trapped, b=1 otherwise
	ld b, 1
	; Ghost types are immune to all trapping abilities
	call CheckIfUserIsGhostType
	ret z
	ld a, BATTLE_VARS_ABILITY_OPP
	call GetBattleVar
	cp MAGNET_PULL
	jr z, .has_magnet_pull
	cp ARENA_TRAP
	jr z, .has_arena_trap
	cp SHADOW_TAG
	jr z, .is_trapped
	ret
.has_magnet_pull
	; Only works on Steel types
	call CheckIfUserIsSteelType
	ret nz
	jr .is_trapped
.has_arena_trap
	; Doesn't work on flying types or levitate users
	call CheckIfUserIsFlyingType
	ret z
	ld a, BATTLE_VARS_ABILITY
	cp LEVITATE
	ret z
	call CheckAirBalloon
	ret z
.is_trapped
	ld b, 0
	ret

SetBattleDraw: ; 36804
	ld a, [wBattleResult]
	and $c0
	or $2
	ld [wBattleResult], a
	ret

; 3680f


BattleCommand_ForceSwitch: ; 3680f
; forceswitch

	ld a, [BattleType]
	cp BATTLETYPE_SHINY
	jp z, .fail
	cp BATTLETYPE_TRAP ; or BATTLETYPE_LEGENDARY
	jp nc, .fail
	call GetOpponentAbilityAfterMoldBreaker
	cp SUCTION_CUPS
	jp z, .fail
	ld a, [AttackMissed]
	and a
	jr nz, .missed
	ld a, [hBattleTurn]
	and a
	jp nz, .force_player_switch
	ld a, [wBattleMode]
	dec a
	jr nz, .trainer
	ld a, [CurPartyLevel]
	ld b, a
	ld a, [BattleMonLevel]
	cp b
	jr nc, .wild_force_flee
	add b
	ld c, a
	inc c
.random_loop_wild
	call BattleRandom
	cp c
	jr nc, .random_loop_wild
	srl b
	srl b
	cp b
	jr nc, .wild_force_flee
.missed
	jp .fail

.wild_force_flee
	call UpdateBattleMonInParty
	xor a
	ld [wNumHits], a
	inc a
	ld [wForcedSwitch], a
	call SetBattleDraw
	ld a, [wPlayerMoveStructAnimation]
	jp .succeed

.trainer
	call CheckAnyOtherAliveOpponentMons
	jp z, .fail
	ld a, [wEnemyGoesFirst]
	and a
	jr z, .switch_fail
	call UpdateEnemyMonInParty
	ld a, $1
	ld [wKickCounter], a
	call AnimateCurrentMove
	ld c, $14
	call DelayFrames
	hlcoord 1, 0
	lb bc, 4, 10
	call ClearBox
	ld c, 20
	call DelayFrames
	ld a, [OTPartyCount]
	ld b, a
	ld a, [CurOTMon]
	ld c, a
; select a random enemy mon to switch to
.random_loop_trainer
	call BattleRandom
	and $7
	cp b
	jr nc, .random_loop_trainer
	cp c
	jr z, .random_loop_trainer
	push af
	ld hl, OTPartyMon1HP
	call GetPartyLocation
	ld a, [hli]
	or [hl]
	pop de
	jr z, .random_loop_trainer
	ld a, d
	inc a
	ld [wEnemySwitchMonIndex], a
	farcall ForceEnemySwitch

	ld hl, DraggedOutText
	call StdBattleTextBox

	ld hl, SpikesDamage_CheckMoldBreaker
	call CallBattleCore

	ld hl, RunActivationAbilities
	jp CallBattleCore

.switch_fail
	jp .fail

.force_player_switch
	ld a, [wBattleMode]
	dec a
	jr nz, .vs_trainer

	ld a, [BattleMonLevel]
	ld b, a
	ld a, [CurPartyLevel]
	cp b
	jr nc, .wild_succeed_playeristarget

	add b
	ld c, a
	inc c
.wild_random_loop_playeristarget
	call BattleRandom
	cp c
	jr nc, .wild_random_loop_playeristarget

	srl b
	srl b
	cp b
	jr nc, .wild_succeed_playeristarget

.player_miss
	jp .fail

.wild_succeed_playeristarget
	call UpdateBattleMonInParty
	xor a
	ld [wNumHits], a
	inc a
	ld [wForcedSwitch], a
	call SetBattleDraw
	ld a, [wEnemyMoveStructAnimation]
	jr .succeed

.vs_trainer
	call CheckAnyOtherAliveOpponentMons
	jr z, .fail
	ld a, [wEnemyGoesFirst]
	cp $1
	jr z, .switch_fail

	call UpdateBattleMonInParty
	ld a, $1
	ld [wKickCounter], a
	call AnimateCurrentMove
	ld c, 20
	call DelayFrames
	hlcoord 9, 7
	lb bc, 5, 11
	call ClearBox
	ld c, 20
	call DelayFrames
	ld a, [PartyCount]
	ld b, a
	ld a, [CurBattleMon]
	ld c, a
.random_loop_trainer_playeristarget
	call BattleRandom
	and $7
	cp b
	jr nc, .random_loop_trainer_playeristarget

	cp c
	jr z, .random_loop_trainer_playeristarget

	push af
	ld hl, PartyMon1HP
	call GetPartyLocation
	ld a, [hli]
	or [hl]
	pop de
	jr z, .random_loop_trainer_playeristarget

	ld a, d
	ld [CurPartyMon], a
	ld hl, SwitchPlayerMon
	call CallBattleCore

	ld hl, DraggedOutText
	call StdBattleTextBox

	ld hl, SpikesDamage_CheckMoldBreaker
	call CallBattleCore

	ld hl, RunActivationAbilities
	jp CallBattleCore

.fail
	call BattleCommand_LowerSub
	call BattleCommand_MoveDelay
	call BattleCommand_RaiseSub
	jp PrintButItFailed

.succeed
	push af
	call SetBattleDraw
	ld a, $1
	ld [wKickCounter], a
	call AnimateCurrentMove
	ld c, 20
	call DelayFrames
	pop af
	ld hl, FledInFearText
	jp StdBattleTextBox

; 36994


CheckPlayerHasMonToSwitchTo: ; 36994
	ld a, [PartyCount]
	ld d, a
	ld e, 0
	ld bc, PARTYMON_STRUCT_LENGTH
.loop
	ld a, [CurBattleMon]
	cp e
	jr z, .next

	ld a, e
	ld hl, PartyMon1HP
	call AddNTimes
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


BattleCommand_EndLoop: ; 369b6
; endloop

; Loop back to the command before 'critical'.

	ld de, PlayerRolloutCount
	ld bc, PlayerDamageTaken
	ld a, [hBattleTurn]
	and a
	jr z, .got_addrs
	ld de, EnemyRolloutCount
	ld bc, EnemyDamageTaken
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

	ld hl, PlayerHitTimesText
	ld a, [hBattleTurn]
	and a
	jr z, .got_hit_n_times_text
	ld hl, EnemyHitTimesText
.got_hit_n_times_text
	xor a
	ld [bc], a
	ret

; Loop back to the command before 'critical'.
.loop_back_to_critical
	ld b, critical_command
	jp SkipToBattleCommandBackwards


BattleCommand_FlinchTarget: ; 36aa0
	call CheckSubstituteOpp
	ret nz

	ld a, BATTLE_VARS_STATUS_OPP
	call GetBattleVar
	and 1 << FRZ | SLP
	ret nz

	call CheckOpponentWentFirst
	ret nz

	ld a, [EffectFailed]
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
	push bc
	ld a, [wEnemyGoesFirst] ; 0 if player went first
	ld b, a
	ld a, [hBattleTurn] ; 0 if it's the player's turn
	xor b ; 1 if opponent went first
	pop bc
	ret

BattleCommand_CheckCharge: ; 36b3a
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


BattleCommand_Charge:
	call BattleCommand_ClearText
	ld a, BATTLE_VARS_STATUS
	call GetBattleVar
	and SLP
	jr z, .awake

	call BattleCommand_MoveDelay
	call BattleCommand_RaiseSub
	call PrintButItFailed
	jp EndMoveEffect

.awake
	ld a, BATTLE_VARS_SUBSTATUS3
	call GetBattleVarAddr
	set SUBSTATUS_CHARGED, [hl]

	ld hl, IgnoredOrders2Text
	ld a, [AlreadyDisobeyed]
	and a
	call nz, StdBattleTextBox

	call BattleCommand_LowerSub
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
	call BattleCommand_RaiseSub
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

BattleCommand_TrapTarget: ; 36c2d
; traptarget

	ld a, [AttackMissed]
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


BattleCommand_FocusEnergy: ; 36c98
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


BattleCommand_Recoil: ; 36cb2
; recoil

	ld hl, BattleMonMaxHP
	ld a, [hBattleTurn]
	and a
	ld a, [LastPlayerMove]
	jr z, .got_hp
	ld hl, EnemyMonMaxHP
	ld a, [LastEnemyMove]
.got_hp
	ld b, a
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
	ld a, [CurDamage]
	ld b, a
	ld a, [CurDamage + 1]
	ld c, a
	srl b
	rr c
	srl b
	rr c
.recoil_floor
	ld a, b
	or c
	jr nz, .min_damage
	inc c
.min_damage
	ld a, [hli]
	ld [Buffer2], a
	ld a, [hl]
	ld [Buffer1], a
	dec hl
	dec hl
	ld a, [hl]
	ld [Buffer3], a
	sub c
	ld [hld], a
	ld [Buffer5], a
	ld a, [hl]
	ld [Buffer4], a
	sbc b
	ld [hl], a
	ld [Buffer6], a
	jr nc, .dont_ko
	xor a
	ld [hli], a
	ld [hl], a
	ld hl, Buffer5
	ld [hli], a
	ld [hl], a
.dont_ko
	hlcoord 11, 9
	ld a, [hBattleTurn]
	and a
	ld a, 1
	jr z, .animate_hp_bar
	hlcoord 1, 2
	xor a
.animate_hp_bar
	ld [wWhichHPBar], a
	predef AnimateHPBar
	call RefreshBattleHuds
.recoil_text
	ld hl, RecoilText
	jp StdBattleTextBox

.StruggleRecoil
	ld hl, GetQuarterMaxHP
	call CallBattleCore
	ld hl, SubtractHPFromUser
	call CallBattleCore
	call UpdateUserInParty
	jp .recoil_text

.OneThirdRecoil
	ld a, BATTLE_VARS_MOVE_ANIM
	call GetBattleVar
	ld d, a
	ld a, [CurDamage]
	ld [hDividend], a
	ld a, [CurDamage + 1]
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


BattleCommand_ConfuseTarget: ; 36d1d
; confusetarget

	call GetOpponentItem
	ld a, b
	cp HELD_PREVENT_CONFUSE
	ret z
	call GetOpponentAbilityAfterMoldBreaker
	cp OWN_TEMPO
	jr nz, .no_own_tempo
	farjp ShowEnemyAbilityActivation
.no_own_tempo
	ld a, [EffectFailed]
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
	jr BattleCommand_FinishConfusingTarget


BattleCommand_Confuse: ; 36d3b
; confuse

	call GetOpponentItem
	ld a, b
	cp HELD_PREVENT_CONFUSE
	jr nz, .no_item_protection
	ld a, [hl]
	ld [wNamedObjectIndexBuffer], a
	call GetItemName
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
	jr nz, BattleCommand_Confuse_CheckSwagger_ConfuseHit
	ld a, [AttackMissed]
	and a
	jr nz, BattleCommand_Confuse_CheckSwagger_ConfuseHit
BattleCommand_FinishConfusingTarget: ; 36d70
	ld bc, EnemyConfuseCount
	ld a, [hBattleTurn]
	and a
	jr z, .got_confuse_count
	ld bc, PlayerConfuseCount

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

	farcall UseEnemyConfusionHealingItem
	farjp RunEnemyStatusHealAbilities

; 36db6

BattleCommand_Confuse_CheckSwagger_ConfuseHit: ; 36db6
	ld a, BATTLE_VARS_MOVE_EFFECT
	call GetBattleVar
	cp EFFECT_CONFUSE_HIT
	ret z
	cp EFFECT_SWAGGER
	ret z
	jp PrintDidntAffect2

; 36dc7


BattleCommand_Paralyze:
	ld hl, DoesntAffectText
	ld a, [TypeModifier]
	and a
	jp z, .failed

	ld b, 1
	call CanParalyzeTarget
	jr c, .ability_ok
	jr nz, .failed

	call CheckSubstituteOpp
	ld hl, ButItFailedText
	jr nz, .failed
	ld a, [AttackMissed]
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


BattleCommand_Substitute: ; 36e7c
; substitute
	call BattleCommand_MoveDelay

	ld a, BATTLE_VARS_SUBSTATUS4
	call GetBattleVar
	bit SUBSTATUS_SUBSTITUTE, a
	jr nz, .already_has_sub
	farcall GetQuarterMaxHP
	push bc
	call CompareHP
	pop bc
	jr c, .too_weak_to_sub
	jr z, .too_weak_to_sub

	ld hl, PlayerSubstituteHP
	ld a, [hBattleTurn]
	and a
	jr z, .got_hp
	ld hl, EnemySubstituteHP
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
	ld [FXAnimIDHi], a
	ld [wKickCounter], a
	ld a, SUBSTITUTE
	call LoadAnim
	jr .finish

.no_anim
	call BattleCommand_RaiseSubNoAnim
.finish
	ld hl, MadeSubstituteText
	call StdBattleTextBox
	jp RefreshBattleHuds

.already_has_sub
	call CheckUserIsCharging
	call nz, BattleCommand_RaiseSub
	ld hl, HasSubstituteText
	jr .jp_stdbattletextbox

.too_weak_to_sub
	call CheckUserIsCharging
	call nz, BattleCommand_RaiseSub
	ld hl, TooWeakSubText
.jp_stdbattletextbox
	jp StdBattleTextBox

; 36f0b

BattleCommand_RechargeNextTurn: ; 36f0b
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


BattleCommand_Rage: ; 36f1d
; rage
	ld a, BATTLE_VARS_SUBSTATUS4
	call GetBattleVarAddr
	set SUBSTATUS_RAGE, [hl]
	ret

; 36f25


BattleCommand_LeechSeed: ; 36f9d
; leechseed
	ld a, [AttackMissed]
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


BattleCommand_Splash: ; 36fe1
	call AnimateCurrentMove
	jp PrintNothingHappened

; 36fed


BattleCommand_Disable: ; 36fed
; disable

	ld a, [AttackMissed]
	and a
	jr nz, .failed

	ld de, EnemyDisableCount
	ld hl, EnemyMonMoves
	ld a, [hBattleTurn]
	and a
	jr z, .got_moves
	ld de, PlayerDisableCount
	ld hl, BattleMonMoves
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
	ld hl, EnemyMonPP
	jr z, .got_pp
	ld hl, BattleMonPP
.got_pp
	ld b, 0
	add hl, bc
	ld a, [hl]
	and a
	jr z, .failed
	call ShowPotentialAbilityActivation
	; check for AnimationsDisabled to determine if this is via Cursed Body, in
	; which we want to change the duration to always be 3 turns
	ld a, [AnimationsDisabled]
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
	ld hl, DisabledMove
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
	jp CheckEnemyMentalHerb

.failed
	jp FailDisable

; 3705c

BattleCommand_KnockOff:
	ld a, [AttackMissed]
	and a
	ret nz

	; Maybe Substitute/Sheer Force prevents the steal
	call CheckSubstituteOpp
	ret nz

	; Sticky Hold prevents item loss
	call GetOpponentAbilityAfterMoldBreaker
	cp STICKY_HOLD
	ret z

	; Check if target has an item to knock off
	call GetOpponentItem
	ld a, [hl]
	and a
	ret z

	; Armor Suit can't be knocked off
	cp ARMOR_SUIT
	ret z

	; Mail can't be knocked off
	ld d, a
	push hl
	farcall ItemIsMail
	pop hl
	ret c

	ld [wNamedObjectIndexBuffer], a
	xor a
	ld [hl], a
	call GetItemName
	ld hl, KnockedOffItemText
	call StdBattleTextBox
	ld a, MON_ITEM
	call OpponentPartyAttr
	ret z
	xor a
	ld [hl], a
	ret

BattleCommand_BugBite:
; TODO: bugbite
	ret

BattleCommand_PayDay: ; 3705c
; payday

	call CheckSubstituteOpp
	ret nz

	xor a
	ld hl, StringBuffer1
	ld [hli], a

	ld a, [hBattleTurn]
	and a
	ld a, [BattleMonLevel]
	jr z, .ok
	ld a, [EnemyMonLevel]
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

BattleCommand_SkillSwap:
	call CheckHiddenOpponent
	jr nz, .failed

	ld a, [PlayerAbility]
	ld b, a
	ld a, [EnemyAbility]
	ld [PlayerAbility], a
	ld a, b
	ld [EnemyAbility], a

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

BattleCommand_Trick:
	ld a, [AttackMissed]
	and a
	jr nz, .failed

	call CheckSubstituteOpp
	jr nz, .failed

	call GetOpponentAbilityAfterMoldBreaker
	cp STICKY_HOLD
	jr z, .ability_failed

	call GetUserItem
	ld a, [hl]
	and a
	jr z, .failed
	push hl
	call GetOpponentItem
	ld a, [hl]
	and a
	pop de
	jr z, .failed

	ld a, [de]
	ld b, [hl]
	ld [hl], a
	ld a, b
	ld [de], a

	ld hl, SwappedItemsText
	call StdBattleTextBox

	ld a, MON_ITEM
	call BattlePartyAttr
	ld a, [BattleMonItem]
	ld [hl], a

	ld a, MON_ITEM
	call OTPartyAttr
	ret z
	ld a, [EnemyMonItem]
	ld [hl], a
	ret

.ability_failed
	call ShowEnemyAbilityActivation
.failed
	call AnimateFailedMove
	jp PrintButItFailed

BattleCommand_Conversion: ; 3707f
; conversion

	ld hl, BattleMonMoves
	ld de, BattleMonType1
	ld a, [hBattleTurn]
	and a
	jr z, .got_moves
	ld hl, EnemyMonMoves
	ld de, EnemyMonType1
.got_moves
	push de
	ld c, 0
	ld de, StringBuffer1
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
	ld hl, StringBuffer1
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
	jr nz, .done
.next
	inc hl
	jr .loop2

.fail
	call AnimateFailedMove
	jp PrintButItFailed

.done
.loop3
	call BattleRandom
	and %11 ; NUM_MOVES - 1
	ld c, a
	ld b, 0
	ld hl, StringBuffer1
	add hl, bc
	ld a, [hl]
	cp -1
	jr z, .loop3
	cp UNKNOWN_T
	jr z, .loop3
	ld a, [de]
	cp [hl]
	jr z, .loop3
	inc de
	ld a, [de]
	dec de
	cp [hl]
	jr z, .loop3
	ld a, [hl]
	ld [de], a
	inc de
	ld [de], a
	ld [wNamedObjectIndexBuffer], a
	farcall GetTypeName
	call AnimateCurrentMove
	ld hl, TransformedTypeText
	jp StdBattleTextBox

; 3710e


BattleCommand_ResetStats:
	ld a, BASE_STAT_LEVEL
	ld hl, PlayerStatLevels
	call .Fill
	ld hl, EnemyStatLevels
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

BattleCommand_Heal:
	farcall CheckFullHP
	jr z, .hp_full
	ld a, BATTLE_VARS_MOVE
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
	call SwitchTurn
	call IsLeafGuardActive
	push af
	call SwitchTurn
	pop af
	jr z, .ability_prevents_rest
	call BattleCommand_MoveDelay
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
	farcall GetMaxHP
	jr .finish
.not_rest
	farcall GetHalfMaxHP
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

BattleCommand_Roost:
; Remove the flying type until endturn
	call CheckIfUserIsFlyingType
	ret nz

	ld a, [hBattleTurn]
	and a
	ld hl, BattleMonType1
	jr z, .got_types
	ld hl, EnemyMonType1
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

INCLUDE "battle/effects/transform.asm"

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
	jp CopyBytes

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
	ld [EnemyDisableCount], a
	ld [EnemyDisabledMove], a
	ret

.player
	xor a
	ld [PlayerDisableCount], a
	ld [DisabledMove], a
	ret

; 372fc


BattleCommand_Screen: ; 372fc
; screen

	ld hl, PlayerScreens
	ld bc, PlayerLightScreenCount
	ld a, [hBattleTurn]
	and a
	jr z, .got_screens_pointer
	ld hl, EnemyScreens
	ld bc, EnemyLightScreenCount

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
	cp b
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


TryPrintButItFailed: ; 37349
	ld a, [AlreadyFailed]
	and a
	ret nz

	; fallthrough
; 3734e


PrintButItFailed: ; 3734e
; 'but it failed!'
	ld hl, ButItFailedText
	jp StdBattleTextBox

; 37354


FailDisable:
FailAttract:
FailForesight:
FailSpikes:
	call AnimateFailedMove
	; fallthrough
; 37357

PrintDidntAffect: ; 37360
; 'it didn't affect'
	ld hl, DidntAffect1Text
	jp StdBattleTextBox

; 37366


PrintDidntAffect2: ; 37366
	call AnimateFailedMove
	ld hl, DidntAffect1Text ; 'it didn't affect'
	ld de, DidntAffect2Text ; 'it didn't affect'
	jp FailText_CheckOpponentProtect

; 37372


PrintParalyze: ; 37372
; 'paralyzed! maybe it can't attack!'
	ld hl, ParalyzedText
	jp StdBattleTextBox

; 37378

CheckSubstituteOpp_b:
; stores result in b rather than zero flag (ld a, b; and a for equavilent result),
; used for farcalls
	call CheckSubstituteOpp
	ld b, 0
	ret z
	ld b, 1
	ret

CheckSubstituteOpp: ; 37378
; returns z when not behind a sub (or if overridden by Infiltrator or sound)
	ld a, BATTLE_VARS_ABILITY
	call GetBattleVar
	cp INFILTRATOR
	ret z
	push bc
	push de
	push hl
	ld a, BATTLE_VARS_MOVE
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


BattleCommand_SelfDestruct: ; 37380
	call GetOpponentAbilityAfterMoldBreaker
	cp DAMP
	ret z ; nullification ability checks handle messages
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
	call BattleCommand_LowerSub
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
	call WaitBGMap
	jp RefreshBattleHuds

; 373c9


INCLUDE "battle/effects/metronome.asm"


CheckUserMove: ; 37462
; Return z if the user has move a.
	ld b, a
	ld de, BattleMonMoves
	ld a, [hBattleTurn]
	and a
	jr z, .ok
	ld de, EnemyMonMoves
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
	ld [AlreadyDisobeyed], a
	call DoMove
	jp EndMoveEffect

; 37492


INCLUDE "battle/effects/thief.asm"


BattleCommand_ArenaTrap: ; 37517
; arenatrap

; Doesn't work on an absent opponent.

	call CheckHiddenOpponent
	jr nz, .failed

; Don't trap if the opponent is already trapped.

	ld a, BATTLE_VARS_SUBSTATUS2
	call GetBattleVarAddr
	bit SUBSTATUS_CANT_RUN, [hl]
	jr nz, .failed

; Otherwise trap the opponent.

	set SUBSTATUS_CANT_RUN, [hl]
	call AnimateCurrentMove
	ld hl, CantEscapeNowText
	jp StdBattleTextBox

.failed
	call AnimateFailedMove
	jp PrintButItFailed

; 37536


BattleCommand_Defrost: ; 37563
; defrost

; Thaw the user.

	ld a, BATTLE_VARS_STATUS
	call GetBattleVarAddr
	bit FRZ, [hl]
	ret z
	res FRZ, [hl]

; Don't update the enemy's party struct in a wild battle.

	ld a, [hBattleTurn]
	and a
	jr z, .party

	ld a, [wBattleMode]
	dec a
	jr z, .done

.party
	ld a, MON_STATUS
	call UserPartyAttr
	res FRZ, [hl]

.done
	call RefreshBattleHuds
	ld hl, WasDefrostedText
	jp StdBattleTextBox

; 37588


INCLUDE "battle/effects/curse.asm"

INCLUDE "battle/effects/protect.asm"

INCLUDE "battle/effects/endure.asm"

INCLUDE "battle/effects/spikes.asm"

INCLUDE "battle/effects/foresight.asm"

INCLUDE "battle/effects/perish_song.asm"

INCLUDE "battle/effects/rollout.asm"

BoostJumptable:
	dbw AVALANCHE, DoAvalanche
	dbw ACROBATICS, DoAcrobatics
	dbw FACADE, DoFacade
	dbw HEX, DoHex
	dbw VENOSHOCK, DoVenoshock
	dbw KNOCK_OFF, DoKnockOff
	dbw -1, -1

BattleCommand_ConditionalBoost:
	ld hl, BoostJumptable
	ld a, BATTLE_VARS_MOVE
	call GetBattleVar
	jp BattleJumptable

DoAvalanche:
	call CheckOpponentWentFirst
	jr DoubleDamageIfNZ

DoAcrobatics:
	ld a, [hBattleTurn]
	and a
	ld hl, BattleMonItem
	jr z, .got_item
	ld hl, EnemyMonItem
.got_item
	ld a, [hl]
	and a
	jr DoubleDamageIfNZ

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

BattleCommand_DoubleFlyingDamage:
	ld a, BATTLE_VARS_SUBSTATUS3_OPP
	call GetBattleVar
	bit SUBSTATUS_FLYING, a
	jr DoubleDamageIfNZ

BattleCommand_DoubleUndergroundDamage:
	ld a, BATTLE_VARS_SUBSTATUS3_OPP
	call GetBattleVar
	bit SUBSTATUS_UNDERGROUND, a
	; fallthrough
DoubleDamageIfNZ:
	ret z
	; fallthrough
DoubleDamage:
	ld hl, CurDamage + 1
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

	call GetOpponentItem
	ld a, [hl]
	and a
	ret z

	ld hl, CurDamage
	ld a, [hli]
	ld b, a
	ld c, [hl]
	push bc
	srl b
	rr c
	pop hl
	add hl, bc
	ld a, h
	ld [CurDamage], a
	ld a, l
	ld [CurDamage + 1], a
	ret

INCLUDE "battle/effects/attract.asm"

BattleCommand_HappinessPower: ; 3784b
; happinesspower
	push bc
	ld hl, BattleMonHappiness
	ld a, [hBattleTurn]
	and a
	jr z, .ok
	ld hl, EnemyMonHappiness
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


BattleCommand_Safeguard: ; 37939
; safeguard

	ld hl, PlayerScreens
	ld de, PlayerSafeguardCount
	ld a, [hBattleTurn]
	and a
	jr z, .ok
	ld hl, EnemyScreens
	ld de, EnemySafeguardCount
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
	ld hl, EnemyScreens
	ld a, [EnemyAbility]
	ld b, a
	ld a, [hBattleTurn]
	and a
	jr z, .got_turn
	ld hl, PlayerScreens
	ld a, [PlayerAbility]
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


BattleCommand_CheckSafeguard: ; 37972
; checksafeguard
	ld hl, EnemyScreens
	ld a, [EnemyAbility]
	ld b, a
	ld a, [hBattleTurn]
	and a
	jr z, .got_turn
	ld hl, PlayerScreens
	ld a, [PlayerAbility]
	ld b, a
.got_turn
	bit SCREENS_SAFEGUARD, [hl]
	ret z
	ld a, b
	cp INFILTRATOR
	ret z
	ld a, 1
	ld [AttackMissed], a
	call BattleCommand_MoveDelay
	ld hl, SafeguardProtectText
	call StdBattleTextBox
	jp EndMoveEffect

; 37991


BattleCommand_GetMagnitude: ; 37991
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
	call BattleCommand_MoveDelay
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

CheckAnyOtherAliveMons:
; These return nz if any is alive
	ld a, [hBattleTurn]
	and a
	jr nz, CheckAnyOtherAliveEnemyMons
	; fallthrough
CheckAnyOtherAlivePartyMons:
	ld hl, PartyMon1HP
	ld de, CurPartyMon
	ld a, [PartyCount]
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
	ld hl, OTPartyMon1HP
	ld de, CurOTMon
	ld a, [OTPartyCount]
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

BattleCommand_SwitchOut:
	call CheckAnyOtherAliveMons
	ret z
	call UpdateUserInParty
	ld a, [hBattleTurn]
	and a
	ld hl, BattleText_WentBackToPlayer
	jr z, .got_text
	ld hl, BattleText_WentBackToEnemy
.got_text
	call StdBattleTextBox
	farcall SlideUserPicOut
	ld c, 20
	call DelayFrames
	hlcoord TEXTBOX_INNERX, TEXTBOX_INNERY
	lb bc, TEXTBOX_INNERH - 1, TEXTBOX_INNERW
	call ClearBox

	ld a, [hBattleTurn]
	and a
	jr nz, .enemy

	hlcoord 9, 7
	lb bc, 5, 11
	call ClearBox

	; Piggyback on Baton Pass routines
	call DoPlayerBatonPass

	; Baton Pass routines preserve some stuff, get rid of it
	; unless we fainted
	ld hl, BattleMonHP
	ld a, [hli]
	or [hl]
	ret z

	farcall NewBattleMonStatus
	farjp ResetPlayerStatLevels
.enemy
	call DoEnemyBatonPass
	ld hl, EnemyMonHP
	ld a, [hli]
	or [hl]
	ret z

	farcall NewEnemyMonStatus
	farjp ResetEnemyStatLevels

BattleCommand_BatonPass:
	call CheckAnyOtherAliveMons
	jp z, FailedBatonPass

	call AnimateCurrentMove
	ld c, 30
	call DelayFrames
	call UpdateUserInParty

	ld a, [hBattleTurn]
	and a
	jr nz, DoEnemyBatonPass
	; fallthrough
DoPlayerBatonPass:
	; Transition into switchmon menu
	call LoadStandardMenuDataHeader
	farcall SetUpBattlePartyMenu_NoLoop

	farcall ForcePickSwitchMonInBattle

	; Return to battle scene
	call ClearPalettes
	farcall _LoadBattleFontsHPBar
	call CloseWindow
	call ClearSprites
	hlcoord 1, 0
	lb bc, 4, 10
	call ClearBox
	ld b, SCGB_BATTLE_COLORS
	call GetSGBLayout
	call SetPalettes
	call BatonPass_LinkPlayerSwitch

	ld hl, PassedBattleMonEntrance
	call CallBattleCore

	jr ResetBatonPassStatus

DoEnemyBatonPass:
	call BatonPass_LinkEnemySwitch

	; Passed enemy PartyMon entrance
	xor a
	ld [wEnemySwitchMonIndex], a
	ld hl, EnemySwitch_SetMode
	call CallBattleCore
	ld hl, ResetBattleParticipants
	call CallBattleCore
	ld a, 1
	ld [wTypeMatchup], a

	ld hl, SpikesDamage
	call CallBattleCore

	ld hl, RunActivationAbilities
	call CallBattleCore
	; fallthrough

ResetBatonPassStatus:
; Reset status changes that aren't passed by Baton Pass.
	; Disable isn't passed.
	call ResetActorDisable
	farcall BreakAttraction
	ld a, BATTLE_VARS_SUBSTATUS2
	call GetBattleVarAddr
	res SUBSTATUS_TRANSFORMED, [hl]
	res SUBSTATUS_ENCORED, [hl]

	; New mon hasn't used a move yet.
	ld a, BATTLE_VARS_LAST_MOVE
	call GetBattleVarAddr
	ld [hl], 0

	xor a
	ld [wPlayerWrapCount], a
	ld [wEnemyWrapCount], a
	ret

BatonPass_LinkPlayerSwitch:
	ld a, [wLinkMode]
	and a
	ret z

	ld a, 1
	ld [wPlayerAction], a

	call LoadStandardMenuDataHeader
	ld hl, LinkBattleSendReceiveAction
	call CallBattleCore
	call CloseWindow

	xor a
	ld [wPlayerAction], a
	ret

BatonPass_LinkEnemySwitch:
	ld a, [wLinkMode]
	and a
	ret z

	call LoadStandardMenuDataHeader
	ld hl, LinkBattleSendReceiveAction
	call CallBattleCore

	ld a, [OTPartyCount]
	add BATTLEACTION_SWITCH1
	ld b, a
	ld a, [wBattleAction]
	cp BATTLEACTION_SWITCH1
	jr c, .baton_pass
	cp b
	jr c, .switch

.baton_pass
	ld a, [CurOTMon]
	add BATTLEACTION_SWITCH1
	ld [wBattleAction], a
.switch
	jp CloseWindow

FailedBatonPass:
	call AnimateFailedMove
	jp PrintButItFailed

BattleCommand_Pursuit: ; 37b1d
; pursuit
; Double damage if the opponent is switching.

	ld hl, wEnemyIsSwitching
	ld a, [hBattleTurn]
	and a
	jr z, .ok
	ld hl, wPlayerIsSwitching
.ok
	ld a, [hl]
	and a
	ret z

	ld hl, CurDamage + 1
	sla [hl]
	dec hl
	rl [hl]
	ret nc

	ld a, $ff
	ld [hli], a
	ld [hl], a
	ret

; 37b39


BattleCommand_ClearHazards: ; 37b39
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
	ld hl, PlayerScreens
	ld de, wPlayerWrapCount
	jr z, .got_screens_wrap
	ld hl, EnemyScreens
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


BattleCommand_HealWeather:
	farcall CheckFullHP
	jr z, .full

	ld a, [hBattleTurn]
	and a
	ld a, [BattleMonType1]
	ld b, a
	ld a, [BattleMonType2]
	ld c, a
	jr z, .got_types
	ld a, [EnemyMonType1]
	ld b, a
	ld a, [EnemyMonType2]
	ld c, a
.got_types
	ld a, b
	cp GRASS
	jr z, .synthesis_anim
	ld a, c
	cp GRASS
	jr z, .synthesis_anim
	ld a, [TimeOfDay]
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
	farcall GetHalfMaxHP
	jr .amount_ok
.badheal
	farcall GetQuarterMaxHP
	jr .amount_ok
.goodheal
	farcall GetThirdMaxHP
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

BattleCommand_HiddenPower: ; 37be8
; hiddenpower

	ld a, [AttackMissed]
	and a
	ret nz
	farjp HiddenPowerDamageStats

; 37bf4


BattleCommand_StartSun:
	lb bc, WEATHER_SUN, HELD_PROLONG_SUN
	ld hl, SunGotBrightText
	jr BattleCommand_StartWeather
BattleCommand_StartRain:
	lb bc, WEATHER_RAIN, HELD_PROLONG_RAIN
	ld hl, DownpourText
	jr BattleCommand_StartWeather
BattleCommand_StartSandstorm:
	lb bc, WEATHER_SANDSTORM, HELD_PROLONG_SANDSTORM
	ld hl, SandstormBrewedText
	jr BattleCommand_StartWeather
BattleCommand_StartHail:
	lb bc, WEATHER_HAIL, HELD_PROLONG_HAIL
	ld hl, HailStartedText
BattleCommand_StartWeather:
	ld a, [Weather]
	cp b
	jr z, .failed

	ld a, b
	ld [Weather], a
	ld a, c
	call GetItemBoostedDuration
	ld [WeatherCount], a
	call AnimateCurrentMove
	jp StdBattleTextBox ; hl has text pointer already

.failed
	call AnimateFailedMove
	jp PrintButItFailed


BattleCommand_BellyDrum: ; 37c1a
; bellydrum
	farcall GetHalfMaxHP
	call CompareHP
	jr c, .failed
	jr z, .failed

	call BattleCommand_AttackUp2
	ld a, [AttackMissed]
	and a
	jr nz, .failed

	push bc
	call AnimateCurrentMove
	pop bc
	farcall GetHalfMaxHP
	farcall SubtractHPFromUser
	call UpdateUserInParty
	ld a, 5

.max_attack_loop
	push af
	call BattleCommand_AttackUp2
	pop af
	dec a
	jr nz, .max_attack_loop

	ld hl, BellyDrumText
	jp StdBattleTextBox

.failed
	call AnimateFailedMove
	jp PrintButItFailed

; 37c55


BattleCommand_DoubleMinimizeDamage: ; 37ce6
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
	ld hl, CurDamage + 1
	sla [hl]
	dec hl
	rl [hl]
	ret nc
	ld a, $ff
	ld [hli], a
	ld [hl], a
	ret

; 37d02


BattleCommand_SkipSunCharge: ; 37d02
; mimicsuncharge
	call GetWeatherAfterCloudNine
	cp WEATHER_SUN
	ret nz
	ld b, charge_command
	jp SkipToBattleCommandAfter

; 37d0d


BattleCommand_CheckFutureSight: ; 37d0d
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
	ld [CurDamage], a
	ld a, [de]
	ld [CurDamage + 1], a
	ld b, futuresight_command
	jp SkipToBattleCommandAfter

; 37d34

BattleCommand_FutureSight: ; 37d34
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
	call BattleCommand_LowerSub
	call BattleCommand_MoveDelay
	ld hl, ForesawAttackText
	call StdBattleTextBox
	call BattleCommand_RaiseSub
	ld de, wPlayerFutureSightDamage
	ld a, [hBattleTurn]
	and a
	jr z, .StoreDamage
	ld de, wEnemyFutureSightDamage
.StoreDamage:
	ld hl, CurDamage
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


BattleCommand_ThunderAccuracy: ; 37d94
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

GetPlayerItem:
	ld hl, BattleMonItem
	ld b, [hl]
	jp GetItemHeldEffect

GetEnemyItem:
	ld hl, EnemyMonItem
	ld b, [hl]
	jp GetItemHeldEffect

GetUserItem: ; 37db2
; Return the effect of the user's item in bc, and its id at hl.
	ld hl, BattleMonItem
	ld a, [hBattleTurn]
	and a
	jr z, .go
	ld hl, EnemyMonItem
.go
	ld b, [hl]
	jp GetItemHeldEffect

; 37dc1


GetOpponentItemAfterUnnerve:
; Return the effect of the opponent's item in bc, and its id at hl unless Unnerve applies
	call SwitchTurn
	call GetUserItemAfterUnnerve
	jp SwitchTurn

GetOpponentItem:
; Return the effect of the opponent's item in bc, and its id at hl.
	call SwitchTurn
	call GetUserItem
	jp SwitchTurn

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
	ld hl, UnnerveItemsBlocked
	call IsInArray
	pop hl
	pop de
	ret c
	ld hl, NoItem
	ld b, HELD_NONE
	ret

UnnerveItemsBlocked:
	db ORAN_BERRY
	db SITRUS_BERRY
	db PECHA_BERRY
	db RAWST_BERRY
	db CHERI_BERRY
	db CHESTO_BERRY
	db ASPEAR_BERRY
	db PERSIM_BERRY
	db LUM_BERRY
	db LEPPA_BERRY
	db FIGY_BERRY
	db LIECHI_BERRY
	db GANLON_BERRY
	db SALAC_BERRY
	db PETAYA_BERRY
	db APICOT_BERRY
	db -1
NoItem:
	db NO_ITEM


GetItemHeldEffect: ; 37dd0
; Return the effect of item b in bc.
	ld a, b
	and a
	ret z

	push hl
	ld hl, ItemAttributes + 2
	dec a
	ld c, a
	ld b, 0
	ld a, Item2Attributes - Item1Attributes
	call AddNTimes
	ld a, BANK(ItemAttributes)
	call GetFarHalfword
	ld b, l
	ld c, h
	pop hl
	ret

; 37de9


;AnimateCurrentMoveEitherSide: ; 37de9
;	push hl
;	push de
;	push bc
;	ld a, [wKickCounter]
;	push af
;	call BattleCommand_LowerSub
;	pop af
;	ld [wKickCounter], a
;	call PlayDamageAnim
;	call BattleCommand_RaiseSub
;	pop bc
;	pop de
;	pop hl
;	ret

; 37e01


AnimateCurrentMove: ; 37e01
	ld a, [AnimationsDisabled]
	and a
	ret nz
	push hl
	push de
	push bc
	ld a, [wKickCounter]
	push af
	call BattleCommand_LowerSub
	pop af
	ld [wKickCounter], a
	call LoadMoveAnim
	call BattleCommand_RaiseSub
	pop bc
	pop de
	pop hl
	ret

; 37e19


PlayDamageAnim: ; 37e19
	xor a
	ld [FXAnimIDHi], a

	ld a, BATTLE_VARS_MOVE_ANIM
	call GetBattleVar
	and a
	ret z

	ld [FXAnimIDLo], a

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
	ld [FXAnimIDHi], a

	ld a, BATTLE_VARS_MOVE_ANIM
	call GetBattleVar
	and a
	ret z

	; fallthrough
; 37e44


LoadAnim: ; 37e44

	ld [FXAnimIDLo], a

	; fallthrough
; 37e47


PlayUserBattleAnim: ; 37e47
	push hl
	push de
	push bc
	farcall PlayBattleAnim
	pop bc
	pop de
	pop hl
	ret

; 37e54


PlayOpponentBattleAnim: ; 37e54
	ld a, e
	ld [FXAnimIDLo], a
	ld a, d
	ld [FXAnimIDHi], a
	xor a
	ld [wNumHits], a

	push hl
	push de
	push bc
	call SwitchTurn

	farcall PlayBattleAnim

	call SwitchTurn
	pop bc
	pop de
	pop hl
	ret

; 37e73


CallBattleCore: ; 37e73
	ld a, BANK(BattleCore)
	jp FarCall_hl

ShowPotentialAbilityActivation:
; This avoids duplicating checks to avoid text spam. This will run
; ShowAbilityActivation if animations are disabled (something only abilities do)
	ld a, [AnimationsDisabled]
	and a
	ret z
	; push/pop hl isn't redundant, farcall clobbers it
	push hl
	farcall ShowAbilityActivation
	pop hl
	ret

AnimateFailedMove: ; 37e77
	ld a, [AnimationsDisabled]
	and a
	ret nz
	call BattleCommand_LowerSub
	call BattleCommand_MoveDelay
	jp BattleCommand_RaiseSub

; 37e80


BattleCommand_MoveDelay: ; 37e80
; movedelay
; Wait 40 frames.
	ld c, 40
	jp DelayFrames

; 37e85


BattleCommand_ClearText: ; 37e85
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
	ld a, [BattleScriptBufferLoc]
	ld l, a
	ld a, [BattleScriptBufferLoc + 1]
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
	ld a, c
	cp 2
	jr nz, .jump_done
	; c = 2: skip to command after
	inc hl
.jump_done
	ld a, l
	ld [BattleScriptBufferLoc], a
	ld a, h
	ld [BattleScriptBufferLoc + 1], a
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
