INCLUDE "data/battle/critical_hit_chances.asm"
INCLUDE "data/items/edible_berries.asm"
INCLUDE "data/moves/continuous_moves.asm"
INCLUDE "data/moves/critical_hit_moves.asm"
INCLUDE "data/moves/reversal_power.asm"
INCLUDE "data/pokemon/fury_attack_users.asm"
INCLUDE "data/pokemon/withdraw_harden_users.asm"
INCLUDE "data/types/inverse_type_matchups.asm"
INCLUDE "data/types/type_matchups.asm"

INCLUDE "engine/battle/ai/switch.asm"
INCLUDE "engine/battle/move_effects/attract.asm"
INCLUDE "engine/battle/move_effects/baton_pass.asm"
INCLUDE "engine/battle/move_effects/belly_drum.asm"
INCLUDE "engine/battle/move_effects/brick_break.asm"
INCLUDE "engine/battle/move_effects/bug_bite.asm"
INCLUDE "engine/battle/move_effects/conversion.asm"
INCLUDE "engine/battle/move_effects/counter.asm"
INCLUDE "engine/battle/move_effects/curse.asm"
INCLUDE "engine/battle/move_effects/defense_curl.asm"
INCLUDE "engine/battle/move_effects/destiny_bond.asm"
INCLUDE "engine/battle/move_effects/dream_eater.asm"
INCLUDE "engine/battle/move_effects/encore_disable.asm"
INCLUDE "engine/battle/move_effects/endure.asm"
INCLUDE "engine/battle/move_effects/explosion.asm"
INCLUDE "engine/battle/move_effects/false_swipe.asm"
INCLUDE "engine/battle/move_effects/focus_energy.asm"
INCLUDE "engine/battle/move_effects/foresight.asm"
INCLUDE "engine/battle/move_effects/future_sight.asm"
INCLUDE "engine/battle/move_effects/growth.asm"
INCLUDE "engine/battle/move_effects/gyro_ball.asm"
INCLUDE "engine/battle/move_effects/heal_bell.asm"
INCLUDE "engine/battle/move_effects/healinglight.asm"
INCLUDE "engine/battle/move_effects/hidden_power.asm"
INCLUDE "engine/battle/move_effects/knock_off.asm"
INCLUDE "engine/battle/move_effects/leech_seed.asm"
INCLUDE "engine/battle/move_effects/low_kick.asm"
INCLUDE "engine/battle/move_effects/magic_bounce.asm"
INCLUDE "engine/battle/move_effects/magnitude.asm"
INCLUDE "engine/battle/move_effects/mean_look.asm"
INCLUDE "engine/battle/move_effects/metronome.asm"
INCLUDE "engine/battle/move_effects/minimize.asm"
INCLUDE "engine/battle/move_effects/pain_split.asm"
INCLUDE "engine/battle/move_effects/pay_day.asm"
INCLUDE "engine/battle/move_effects/perish_song.asm"
INCLUDE "engine/battle/move_effects/protect.asm"
INCLUDE "engine/battle/move_effects/pursuit.asm"
INCLUDE "engine/battle/move_effects/rage.asm"
INCLUDE "engine/battle/move_effects/rapid_spin.asm"
INCLUDE "engine/battle/move_effects/reflect_light_screen.asm"
INCLUDE "engine/battle/move_effects/return.asm"
INCLUDE "engine/battle/move_effects/roar.asm"
INCLUDE "engine/battle/move_effects/rollout.asm"
INCLUDE "engine/battle/move_effects/roost.asm"
INCLUDE "engine/battle/move_effects/safeguard.asm"
INCLUDE "engine/battle/move_effects/sketch.asm"
INCLUDE "engine/battle/move_effects/skill_swap.asm"
INCLUDE "engine/battle/move_effects/sleep_talk.asm"
INCLUDE "engine/battle/move_effects/spikes.asm"
INCLUDE "engine/battle/move_effects/splash.asm"
INCLUDE "engine/battle/move_effects/substitute.asm"
INCLUDE "engine/battle/move_effects/sucker_punch.asm"
INCLUDE "engine/battle/move_effects/teleport.asm"
INCLUDE "engine/battle/move_effects/thief.asm"
INCLUDE "engine/battle/move_effects/thunder.asm"
INCLUDE "engine/battle/move_effects/transform.asm"
INCLUDE "engine/battle/move_effects/tri_attack.asm"
INCLUDE "engine/battle/move_effects/trick.asm"
INCLUDE "engine/battle/move_effects/trick_room.asm"
INCLUDE "engine/battle/move_effects/triple_kick.asm"
INCLUDE "engine/battle/move_effects/toxic.asm"
INCLUDE "engine/battle/move_effects/weather.asm"


DoTurn:
	ld a, [wBattleType]
	cp BATTLETYPE_GHOST
	jr nz, .not_ghost

	ldh a, [hBattleTurn]
	and a
	ld hl, ScaredText
	jr z, .got_ghost_text
	ld hl, GetOutText
.got_ghost_text
	jmp StdBattleTextbox

.not_ghost
; Read in and execute the user's move effects for this turn.
	; Clear physical/special move use for user.
	; For Counter/Mirror Coat, we store last damage done.
	; This damage is stored alongside flags for whether it was physical
	; or special in wMoveState.
	ld hl, wMoveState
	ldh a, [hBattleTurn]
	and a
	ld a, 1 << PHYSICAL | 1 << SPECIAL
	jr nz, .got_cat_opp_side
	swap a
.got_cat_opp_side
	and [hl]
	ld [hl], a

	ldh a, [hBattleTurn]
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

	ld a, [wMoveState]
	bit 7, a
	ret nz

	call UpdateMoveData

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
	call GetFarWord

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
	call GetFarWord

	call _hl_

	jr .ReadMoveEffectCommand

.endturn_herb
	push af
	call CheckEndMoveEffects
	call CheckPowerHerb
	pop af
	ret

ReadMoveScriptByte:
	ld hl, wBattleScriptBufferLoc
	ld a, [hli]
	ld h, [hl]
	ld l, a

	inc hl
	ld a, l
	ld [wBattleScriptBufferLoc], a
	ld a, h
	ld [wBattleScriptBufferLoc + 1], a
	dec hl

	ld a, BANK(MoveEffectsPointers)
	jmp GetFarByte

CheckTurn:
BattleCommand_checkturn:
; Repurposed as hardcoded turn handling. Useless as a command.
	; Move 0 immediately ends the turn (Used by Pursuit)
	ld a, BATTLE_VARS_MOVE
	call GetBattleVar
	and a
	jmp z, EndTurn

	xor a
	ld [wAttackMissed], a
	ld [wEffectFailed], a
	ld [wKickCounter], a
	ld [wAlreadyDisobeyed], a
	ld [wAlreadyExecuted], a

	ld a, $10 ; 1.0
	ld [wTypeModifier], a

	ld a, BATTLE_VARS_SUBSTATUS3
	call GetBattleVarAddr
	bit SUBSTATUS_RECHARGE, [hl]
	jr z, .no_recharge

	res SUBSTATUS_RECHARGE, [hl]
	ld hl, MustRechargeText
	call StdBattleTextbox
	call CantMove
	jmp EndTurn

.no_recharge
	ld a, BATTLE_VARS_SUBSTATUS4
	call GetBattleVarAddr
	bit SUBSTATUS_FLINCHED, [hl]
	jr z, .not_flinched

	res SUBSTATUS_FLINCHED, [hl]
	call GetTrueUserAbility
	cp INNER_FOCUS
	jr z, .not_flinched
	push af
	ld hl, FlinchedText
	call StdBattleTextbox
	pop af
	cp STEADFAST
	jr nz, .skip_steadfast
	farcall SteadfastAbility

.skip_steadfast
	call CantMove
	jmp EndTurn

.not_flinched
	ld a, BATTLE_VARS_STATUS
	call GetBattleVarAddr
	ld a, [hl]
	and SLP
	jr z, .not_asleep

	dec [hl]
	jr z, .woke_up

	; Early Bird decreases the sleep timer twice as fast (including Rest).
	call GetTrueUserAbility
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
	; if user has Early Bird, display ability activation
	call GetTrueUserAbility
	cp EARLY_BIRD
	jr nz, .woke_up_no_early_bird
	farcall DisableAnimations
	farcall ShowAbilityActivation
.woke_up_no_early_bird
	ld hl, WokeUpText
	call StdBattleTextbox
	; does nothing in case we never showed an ability activation
	farcall EnableAnimations
	ldh a, [hBattleTurn]
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
	ldh [hBGMapMode], a
	jr .not_asleep

.fast_asleep
	ld hl, FastAsleepText
	call StdBattleTextbox

	; Sleep Talk bypasses sleep.
	ld a, BATTLE_VARS_MOVE_ANIM
	call GetBattleVar
	cp SLEEP_TALK
	jr z, .not_asleep

	call CantMove
	jmp EndTurn

.not_asleep
	ld a, BATTLE_VARS_STATUS
	call GetBattleVarAddr
	bit FRZ, [hl]
	jr z, .not_frozen

	; Sacred Fire, Scald, and Flare Blitz thaw the user.
	ld a, BATTLE_VARS_MOVE_ANIM
	call GetBattleVar
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
	call StdBattleTextbox
	xor a
	ld [wNumHits], a
	ld de, ANIM_FRZ
	call FarPlayBattleAnimation

	call CantMove
	jmp EndTurn

.thaw
	call BattleCommand_defrost

.not_frozen
	ld a, BATTLE_VARS_SUBSTATUS3
	call GetBattleVar
	add a ; bit SUBSTATUS_CONFUSED, a
	jr nc, .not_confused
	ldh a, [hBattleTurn]
	and a
	ld hl, wPlayerConfuseCount
	jr z, .check_confusion
	ld hl, wEnemyConfuseCount
.check_confusion
	dec [hl]
	jr nz, .confused

	ld a, BATTLE_VARS_SUBSTATUS3
	call GetBattleVarAddr
	res SUBSTATUS_CONFUSED, [hl]
	ld hl, ConfusedNoMoreText
	call StdBattleTextbox
	jr .not_confused

.confused
	ld hl, IsConfusedText
	call StdBattleTextbox
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
	jr EndTurn

.not_confused
	ld a, BATTLE_VARS_SUBSTATUS1
	call GetBattleVar
	add a ; bit SUBSTATUS_ATTRACT
	jr nc, .not_infatuated

	ld hl, InLoveWithText
	call StdBattleTextbox
	xor a
	ld [wNumHits], a
	ld de, ANIM_IN_LOVE
	call FarPlayBattleAnimation

	; 50% chance of infatuation
	call BattleRandom
	cp 1 + (50 percent)
	jr c, .not_infatuated

	ld hl, InfatuationText
	call StdBattleTextbox
	call CantMove
	jr EndTurn

.not_infatuated
	; Are we using a disabled move?
	ldh a, [hBattleTurn]
	and a
	ld a, [wPlayerDisableCount]
	ld hl, wCurMoveNum
	jr z, .check_disabled
	ld a, [wEnemyDisableCount]
	ld hl, wCurEnemyMoveNum
.check_disabled
	and a
	jr z, .not_disabled
	swap a
	and $f
	dec a
	cp [hl]
	jr nz, .not_disabled

	call MoveDisabled
	call CantMove
	jr EndTurn

.not_disabled
	ld a, BATTLE_VARS_STATUS
	call GetBattleVarAddr
	bit PAR, [hl]
	ret z

	; 25% chance to be fully paralyzed
	call BattleRandom
	cp 1 + (25 percent)
	ret nc

	ld hl, FullyParalyzedText
	call StdBattleTextbox
	xor a
	ld [wNumHits], a
	ld de, ANIM_PAR
	call FarPlayBattleAnimation
	call CantMove
	; fallthrough

EndTurn:
	ld a, [wMoveState]
	set 7, a
	ld [wMoveState], a
	jmp ResetDamage

OpponentCantMove:
	call CallOpponentTurn
CantMove:
	call CheckRampageStatusAndGetRolloutCount ; ; hl becomes pointer to user substatus3
	jr z, .rampage_done
	ld a, [de]
	dec a
	push hl
	call z, HandleRampage_ConfuseUser  ; confuses user on last turn of rampage
	pop hl
.rampage_done
	ld a, [hl]
	push hl
	and (1 << SUBSTATUS_FLYING | 1 << SUBSTATUS_UNDERGROUND)
	call nz, AppearUserRaiseSub
	pop hl
	ld a, ~(1 << SUBSTATUS_RAMPAGE | 1 << SUBSTATUS_CHARGED | 1 << SUBSTATUS_FLYING | 1 << SUBSTATUS_UNDERGROUND | 1 << SUBSTATUS_ROLLOUT)
	and [hl]
	ld [hl], a
	ret

IncreaseMetronomeCount:
	; Don't arbitrarily boost usage counter twice on a turn
	call CheckUserIsCharging
	ret nz

	; unaffected by Metronome
	call GetFutureSightUser
	ret nc

	ldh a, [hBattleTurn]
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
	inc a ; cp STRUGGLE
	jr z, .done_update_selected_move
	dec a
	ld [de], a
.done_update_selected_move
	xor a
	ld [hl], a
	ret

CheckPowerHerb:
	call HasUserFainted
	ret z

	ld a, BATTLE_VARS_SUBSTATUS3
	call GetBattleVar
	bit SUBSTATUS_CHARGED, a
	ret z

	ld a, BATTLE_VARS_MOVE_EFFECT
	call GetBattleVar
	cp EFFECT_SOLAR_BEAM
	jr nz, .no_solar_beam

	; check for sun
	call GetWeatherAfterUserUmbrella
	cp WEATHER_SUN
	jr z, .chargeup

.no_solar_beam
	predef GetUserItemAfterUnnerve
	ld a, b
	cp HELD_POWER_HERB
	jr z, .has_power_herb

	; Raise sub if we're using Solar Beam
	ld a, BATTLE_VARS_MOVE_EFFECT
	call GetBattleVar
	cp EFFECT_SOLAR_BEAM
	ret nz
	jmp BattleCommand_raisesub

.has_power_herb
	call GetCurItemName

	farcall ItemRecoveryAnim
	call GetUserItem
	call GetCurItemName

	ld hl, BattleText_UserChargedWithItem
	call StdBattleTextbox
	call ConsumeUserItem

	; If already called from a seperate move, don't change charging.
	; Otherwise, mark as repeated due to Power Herb
.chargeup
	call CheckUserIsCharging
	ld a, 2
	jr z, _ResetTurn
	; fallthrough
ResetTurn:
	ld a, 1
_ResetTurn:
	push af
	ldh a, [hBattleTurn]
	and a
	ld hl, wPlayerCharging
	jr z, .player
	ld hl, wEnemyCharging

.player
	pop af
	ld [hl], a
	xor a
	ld [wAlreadyDisobeyed], a
	call DoMove
	jmp EndMoveEffect

MoveDisabled:
	; Make sure any charged moves fail
	ld a, BATTLE_VARS_SUBSTATUS3
	call GetBattleVarAddr
	res SUBSTATUS_CHARGED, [hl]

	ld a, BATTLE_VARS_MOVE
	call GetBattleVar
	ld [wNamedObjectIndex], a
	call GetMoveName

	ld hl, DisabledMoveText
	jmp StdBattleTextbox

GenericHitAnim:
	; Flicker the monster pic unless flying or underground.
	xor a
	ld [wNumHits], a
	ld de, ANIM_HIT_CONFUSION
	ld a, BATTLE_VARS_SUBSTATUS3_OPP
	call GetBattleVar
	and 1 << SUBSTATUS_FLYING | 1 << SUBSTATUS_UNDERGROUND
	call z, PlayFXAnimID
	ret

HitConfusion:
	ld hl, HurtItselfText
	call StdBattleTextbox

	xor a
	ld [wCriticalHit], a

	call HitSelfInConfusion
	call ConfusedDamageCalc
	call BattleCommand_lowersub

	ldh a, [hBattleTurn]
	and a
	jr nz, .enemy
	farcall UpdatePlayerHUD
	ld a, $1
	ldh [hBGMapMode], a
.enemy
	ld c, $1
	call TakeOpponentDamage
	jmp BattleCommand_raisesub

BattleCommand_checkobedience:
	; Enemy can't disobey
	ldh a, [hBattleTurn]
	and a
	ret nz

	call CheckUserIsCharging
	ret nz

	ld a, BATTLE_VARS_SUBSTATUS3
	call GetBattleVar
	and 1 << SUBSTATUS_RAMPAGE | 1 << SUBSTATUS_CHARGED | 1 << SUBSTATUS_ROLLOUT
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
	call StdBattleTextbox
	call HitConfusion
	jmp .EndDisobedience

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
	call StdBattleTextbox
	jr .EndDisobedience

.UseInstead:

; Can't use another move if the monster only has one!
	ld a, [wBattleMonMoves + 1]
	and a
	jr z, .DoNothing

; Don't bother trying to handle Disable.
	ld a, [wPlayerDisableCount]
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
	ld [wLastPlayerCounterMove], a

	; Break Encore too.
	xor a
	ld [wPlayerEncoreCount], a

	jmp EndMoveEffect

IgnoreSleepOnly:

	ld a, BATTLE_VARS_MOVE_ANIM
	call GetBattleVar

	xor SLEEP_TALK
	ret nz

	ld a, BATTLE_VARS_STATUS
	call GetBattleVar
	and SLP
	ret z

; 'ignored orders…sleeping!'
	ld hl, IgnoredSleepingText
	call StdBattleTextbox

	call EndMoveEffect

	scf
	ret

BattleCommand_usedmovetext:
	farjp DisplayUsedMoveText

CheckUserIsCharging:
	ldh a, [hBattleTurn]
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

	ldh a, [hBattleTurn]
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
	; check if we're locked in to a multi-turn move
	ld a, BATTLE_VARS_SUBSTATUS3
	call GetBattleVar
	and 1 << SUBSTATUS_RAMPAGE | 1 << SUBSTATUS_CHARGED | 1 << SUBSTATUS_ROLLOUT
	ret nz

	; Consume PP
	call BattleConsumePP
	ret nz

	; Out of PP
	call BattleCommand_movedelay

	; Different message if continuous
	ld a, BATTLE_VARS_MOVE_EFFECT
	call GetBattleVar
	ld hl, ContinuousMoves
	call IsInByteArray

	ld hl, HasNoPPLeftText
	jr c, .print
	ld hl, NoPPLeftText
.print
	call StdBattleTextbox
	jmp EndMoveEffect

BattleCommand_hastarget:
	ld a, BATTLE_VARS_MOVE_EFFECT
	call GetBattleVar
	cp EFFECT_FLY
	jr z, .chargeup_move
	cp EFFECT_SOLAR_BEAM
	jr nz, .regular
.chargeup_move
	; We should still allow chargeup even if user is fainted
	ld a, BATTLE_VARS_SUBSTATUS3
	call GetBattleVar
	and 1 << SUBSTATUS_CHARGED
	jr z, .not_fainted

.regular
	; If the target is fainted, abort the move
	call HasOpponentFainted
	jr nz, .not_fainted

	ld hl, ButItFailedText
	call StdBattleTextbox
	call CantMove
	jmp EndMoveEffect

.not_fainted
	; Handle Pressure
	call GetOpponentAbility
	cp PRESSURE
	ret nz
	; fallthrough
BattleConsumePP:
; Also used by DoTurn: return z if user has no PP left
	call CheckUserIsCharging
	ret nz

	ld a, BATTLE_VARS_MOVE
	call GetBattleVar
	inc a ; cp STRUGGLE
	jr z, .end

	ld a, BATTLE_VARS_SUBSTATUS3
	call GetBattleVar
	and 1 << SUBSTATUS_IN_LOOP | 1 << SUBSTATUS_RAMPAGE | 1 << SUBSTATUS_CHARGED | 1 << SUBSTATUS_ROLLOUT
	ret nz

	ldh a, [hBattleTurn]
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
	call SwapHLDE
	add hl, bc
	ld a, [hl]
	and $3f
	ret z
	dec [hl]
	ld a, BATTLE_VARS_SUBSTATUS2
	call GetBattleVar
	bit SUBSTATUS_TRANSFORMED, a
	ret nz
	ld a, [hl]
	ld [de], a
.end
	or 1
	ret

BattleCommand_critical:
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
	call GetFutureSightUser
	ld c, 0
	jr nz, .Ability
	ldh a, [hBattleTurn]
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
	push bc
	ld hl, CriticalHitMoves
	call IsInByteArray
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
	call GetTrueUserAbility
	cp SUPER_LUCK
	jr nz, .Tally

; +1 critical level
	inc c

.Tally:
	; Check for c > 2 which always crits
	ld a, c
	cp 3
	jr nc, .guranteed_crit
	ld hl, CriticalHitChances
	ld b, 0
	add hl, bc
	call BattleRandom
	cp [hl]
	ret nc
.guranteed_crit
	ld a, 1
	ld [wCriticalHit], a
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

BattleCommand_stab:
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
	inc a ; cp STRUGGLE
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
	ld a, ATKFAIL_IMMUNE
	ld [wAttackMissed], a
	ret

.not_immune
	; Apply STAB
	ld a, BATTLE_VARS_MOVE_TYPE
	call GetBattleVar
	ld b, a
	call GetFutureSightUser
	jr z, .not_external
	ld a, MON_SPECIES
	call TrueUserPartyAttr
	ld [wCurSpecies], a
	ld a, MON_FORM
	call TrueUserPartyAttr
	and SPECIESFORM_MASK
	ld [wCurForm], a
	call GetBaseData
	ld hl, wBaseType
	jr .got_attacker_types
.not_external
	ldh a, [hBattleTurn]
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
	call GetTrueUserAbility
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
	ldh [hMultiplier], a
	xor a
	ldh [hMultiplicand + 0], a
	ld hl, wCurDamage
	ld a, [hli]
	ldh [hMultiplicand + 1], a
	ld a, [hld]
	ldh [hMultiplicand + 2], a
	call Multiply

	; Parental Bond
	ld a, BATTLE_VARS_SUBSTATUS2
	call GetBattleVar
	bit SUBSTATUS_IN_ABILITY, a
	ln a, 1, 4 ; x0.25
	call nz, MultiplyAndDivide

	; Second ability pass
	push hl
	farcall ApplyDamageAbilities_AfterTypeMatchup

	; Expert Belt
	call GetUserItem
	ld a, b
	cp HELD_EXPERT_BELT
	jr nz, .no_expert_belt

	ld a, [wTypeModifier]
	cp $11
	ln a, 6, 5 ; x1.2
	call nc, MultiplyAndDivide

.no_expert_belt
	pop hl

	ld a, $10
	ldh [hDivisor], a
	ld b, 4
	call Divide

	; Store in curDamage
	ldh a, [hMultiplicand]
	and a
	jr z, .damage_ok

	; Store $ffff
	ld a, $ff
	ld [hli], a
	ld [hl], a
	ret

.damage_ok
	ldh a, [hMultiplicand + 1]
	ld [hli], a
	ld b, a
	ldh a, [hMultiplicand + 2]
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
	call GetTrueUserAbility
	ld b, a
CheckAirborne_GotAbility:
; d=1: Skip type checks (used for Inverse Battle Ground->Flying matchup)
; Returns a=0 and z if grounded. Returns nz if not.
; a contains ATKFAIL_MISSED for air balloon, ATKFAIL_IMMUNE for flying type,
; ATKFAIL_ABILITY for Levitate.
	push bc

	; Check Iron Ball
	predef GetUserItemAfterUnnerve
	ld a, b
	cp HELD_IRON_BALL
	pop bc
	ld c, a
	ld a, 0
	pop de
	ret z

	; d=1 (inverse matchup checks/ring target) skips hardcoded immunity check
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
	ldh a, [hBattleTurn]
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

	; Ring Target or Inverse battles bypass the type matchup check.
	push bc
	predef GetUserItemAfterUnnerve
	ld a, b
	pop bc
	cp HELD_RING_TARGET
	ld d, 1
	jr z, .check_airborne
	ld a, [wBattleType]
	cp BATTLETYPE_INVERSE
	jr z, .check_airborne
	dec d
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
	jmp PopBCDEHL

_CheckTypeMatchup:
	push hl
; Handle powder moves
	ld a, BATTLE_VARS_MOVE_ANIM
	call GetBattleVar
	ld hl, PowderMoves
	call IsInByteArray
	jr nc, .skip_powder
	call GetOpponentItemAfterUnnerve
	ld a, b
	cp HELD_SAFETY_GOGGLES
	jmp z, .Immune
	pop hl
	push hl
	ld a, [hli]
	cp GRASS
	jmp z, .Immune
	ld a, [hl]
	cp GRASS
	jmp z, .Immune
	call GetOpponentAbilityAfterMoldBreaker
	cp OVERCOAT
	jr nz, .skip_powder
	ld a, ATKFAIL_ABILITY
	ld [wAttackMissed], a
	jr .Immune

.skip_powder
	pop hl
	push hl
	ld a, BATTLE_VARS_MOVE_TYPE
	call GetBattleVar
	ld d, a
	ld b, [hl]
	inc hl
	ld c, [hl]
	ld a, $10 ; 1.0
	ld [wTypeMatchup], a
	ld hl, InverseTypeMatchups
	ld a, [wBattleType]
	cp BATTLETYPE_INVERSE
	jr z, .TypesLoop
	ld hl, TypeMatchups
.TypesLoop:
	ld a, [hli]
	; terminator
	cp $ff
	jr z, .end
	cp $fe
	jr nz, .Next
	; stuff beyond this point is ignored if the foe is identified or we have Scrappy
	ld a, BATTLE_VARS_SUBSTATUS1_OPP
	call GetBattleVar
	bit SUBSTATUS_IDENTIFIED, a
	jr nz, .end
	call GetTrueUserAbility
	cp SCRAPPY
	jr nz, .TypesLoop
.end
	pop hl
	ret

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
.Immune:
	xor a
	ld [wTypeMatchup], a
	pop hl
	ret

BattleCommand_checkpowder:
	ld a, BATTLE_VARS_MOVE_ANIM
	call GetBattleVar
	cp SING
	jr nz, .not_sing
	farcall CheckNullificationAbilities
	ld a, [wTypeMatchup]
	and a
	ret nz
	ld [wTypeModifier], a
	ret

.not_sing
	cp THUNDER_WAVE
	jr z, BattleCommand_resettypematchup
	cp TOXIC
	jr z, .check_corrosion
	cp POISONPOWDER
	jr nz, .powder
.check_corrosion
	ld b, a
	call GetTrueUserAbility
	cp CORROSION
	ret z
	ld a, b
	cp TOXIC
	jr z, BattleCommand_resettypematchup
	; fallthrough for poisonpowder
.powder
	ld hl, PowderMoves
	call IsInByteArray
	ret nc
	; fallthrough
BattleCommand_resettypematchup:
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
	ld a, [wAttackMissed]
	and a
	ret nz
	ld a, ATKFAIL_IMMUNE
	ld [wAttackMissed], a
	ret

.reset
	ld [wTypeModifier], a
	ret

BattleCommand_damagevariation:
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
if DEF(DEBUG)
	push hl
	ld hl, DealtXDamageText
	call StdBattleTextbox
	pop hl
endc

	; Start with the current (100%) damage.
	xor a
	ldh [hMultiplicand + 0], a
	dec hl
	ld a, [hli]
	ldh [hMultiplicand + 1], a
	ld a, [hl]
	ldh [hMultiplicand + 2], a

	; Multiply by 85-100%...
	ld a, 16
	call BattleRandomRange
	add 85
	ldh [hMultiplier], a
	call Multiply

	; ...divide by 100%...
	ld a, 100
	ldh [hDivisor], a
	ld b, $4
	call Divide

	; ...to get .85-1.00x damage.
	ldh a, [hQuotient + 1]
	ld hl, wCurDamage
	ld [hli], a
	ldh a, [hQuotient + 2]
	ld [hl], a
	ret

BattleCommand_checkhit:
	; Skip accuracy checks for Magic Bounce/Parental Bond 2nd hit
	ld a, BATTLE_VARS_SUBSTATUS2
	call GetBattleVar
	bit SUBSTATUS_IN_ABILITY, a
	ret nz

	call .DreamEater
	ld a, ATKFAIL_IMMUNE
	jmp z, .Miss_skipset

	call .Protect
	ld a, ATKFAIL_PROTECT
	jmp nz, .Miss_skipset

	call .Substitute
	ld a, ATKFAIL_GENERIC
	jmp nz, .Miss_skipset

	call .PursuitCheck
	ret z

	call .PoisonTypeUsingToxic
	ret z

	call .NoGuardCheck
	ret z

	call .FlyDigMoves
	jmp nz, .Miss

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
	cp EFFECT_COUNTER
	ret z
	cp EFFECT_MIRROR_COAT
	ret z
	ld a, BATTLE_VARS_MOVE_ANIM
	call GetBattleVar
	inc a ; cp STRUGGLE
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
	ldh a, [hBattleTurn]
	and a
	jr z, .got_acc_eva
	ld a, [wEnemyAccLevel]
	ld b, a
	ld a, [wPlayerEvaLevel]
	ld c, a

.got_acc_eva
	call GetFutureSightUser
	jr z, .not_external_acc
	ld b, 7

.not_external_acc
	; Handle stat modifiers
	; Unaware ignores enemy stat changes, identification also does if above 0
	call GetTrueUserAbility
	cp UNAWARE
	jr z, .reset_evasion

	; check Foresight
	ld a, BATTLE_VARS_SUBSTATUS1_OPP
	call GetBattleVar
	bit SUBSTATUS_IDENTIFIED, a
	jr nz, .avoid_evasion_boost
	call GetTrueUserAbility
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
	ldh [hMultiplicand + 0], a
	ldh [hMultiplicand + 1], a
	ld a, BATTLE_VARS_MOVE_ACCURACY
	call GetBattleVar
	ldh [hMultiplicand + 2], a

	ld hl, hMultiplier

	; Apply stat changes
	call DoStatChangeMod
	add $11
	call MultiplyAndDivide
	farcall ApplyAccuracyAbilities

	; Check user items
	predef GetUserItemAfterUnnerve
	ld a, b
	cp HELD_ACCURACY_BOOST
	jr z, .accuracy_boost_item
	cp HELD_ZOOM_LENS
	jr nz, .done_user_items
	call CheckOpponentWentFirst
	jr z, .done_user_items
.accuracy_boost_item
	ld a, c
	call MultiplyAndDivide

.done_user_items
	; Check opponent items
	call GetOpponentItemAfterUnnerve
	ld a, b
	cp HELD_BRIGHTPOWDER
	jr nz, .brightpowder_done
	ld a, c
	call MultiplyAndDivide
.brightpowder_done
	; Accuracy modifiers done. Grab data
	; from hMultiplicand
	ldh a, [hMultiplicand + 0]
	ld b, a
	ldh a, [hMultiplicand + 1]
	or b
	ret nz ; final acc ended up >=100%
	ldh a, [hMultiplicand + 2]
	ld b, a
	ld a, 100
	call BattleRandomRange
	cp b
	ret c
	ld a, ATKFAIL_ACCMISS
	jr .Miss_skipset

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
	call GetWeatherAfterOpponentUmbrella
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
; Returns z if either the user or opponent has the No Guard ability
	call GetTrueUserAbility
	cp NO_GUARD
	ret z
	call GetOpponentAbility
	cp NO_GUARD
	ret

.AntiMinimize:
; Returns z if Stomp or Body Slam is used against a minimized target
	ld a, BATTLE_VARS_SUBSTATUS2_OPP
	call GetBattleVar
	bit SUBSTATUS_MINIMIZED, a
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

BattleCommand_effectchance:
; Doesn't work against Substitute or Shield Dust
	push bc
	push hl
	xor a
	ld [wEffectFailed], a
	call CheckSubstituteOpp
	jr nz, EffectChanceFailed

	call GetOpponentAbilityAfterMoldBreaker
	cp SHIELD_DUST
	jr z, EffectChanceFailed
	jr _CheckEffectChance

BattleCommand_selfeffectchance:
; Works even if opponent has Substitute or Shield Dust up
	push bc
	push hl
	xor a
	ld [wEffectFailed], a
	; fallthrough
_CheckEffectChance:
	ld hl, wPlayerMoveStruct + MOVE_CHANCE
	ldh a, [hBattleTurn]
	and a
	jr z, .got_move_chance
	ld hl, wEnemyMoveStruct + MOVE_CHANCE
.got_move_chance

	ld a, [hl]
	ld b, a
	call GetTrueUserAbility
	cp SHEER_FORCE
	jr z, EffectChanceFailed
	cp SERENE_GRACE
	jr nz, .skip_serene_grace
	sla b
	jr c, EffectChanceEnd ; The effect byte overflowed, so gurantee it

.skip_serene_grace
	ld a, 100
	call BattleRandomRange
	cp b
	jr c, EffectChanceEnd
	; fallthrough
EffectChanceFailed:
	ld a, 1
	ld [wEffectFailed], a
	and a
EffectChanceEnd:
	pop hl
	pop bc
	ret

BattleCommand_lowersub:
	ld a, BATTLE_VARS_SUBSTATUS4
	call GetBattleVar
	bit SUBSTATUS_SUBSTITUTE, a
	ret z

	call CheckUserIsCharging
	ret nz

	call _CheckBattleEffects
	jr c, .mimic_anims

	xor a
	ld [wNumHits], a
	ld [wFXAnimIDHi], a
	inc a
	ld [wKickCounter], a
	ld a, SUBSTITUTE
	jmp LoadAnim

.mimic_anims
	call BattleCommand_lowersubnoanim
	jmp BattleCommand_movedelay

BattleCommand_moveanim:
	; Check for Parental Bond hit
	ld a, BATTLE_VARS_SUBSTATUS2
	call GetBattleVar
	bit SUBSTATUS_IN_ABILITY, a
	jr z, .not_parental_bond

	; Flicker the monster pic unless flying or underground.
	call SwitchTurn
	call GenericHitAnim
	jmp SwitchTurn

.not_parental_bond
	call BattleCommand_lowersub
	call BattleCommand_moveanimnosub
	jmp BattleCommand_raisesub

BattleCommand_moveanimnosub:
	ld a, [wAttackMissed]
	and a
	jmp nz, BattleCommand_movedelay

	call GetFutureSightUser
	jr nc, .normal_move

	; We hit, mark physical/special damage on opponent.
	ld a, BATTLE_VARS_MOVE_CATEGORY
	call GetBattleVar
	cp PHYSICAL
	ld a, 1 << PHYSICAL
	jr z, .got_cat
	ld a, 1 << SPECIAL
.got_cat
	push bc
	ld b, a
	ldh a, [hBattleTurn]
	and a
	ld a, b
	pop bc
	jr z, .got_cat_side
	swap a
.got_cat_side
	push hl
	ld hl, wMoveState
	or [hl]
	ld [hl], a
	pop hl

	ldh a, [hBattleTurn]
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
	cp EFFECT_PURSUIT
	jr z, .pursuit
	cp EFFECT_MULTI_HIT
	jr z, .multihit
	cp EFFECT_FURY_STRIKES
	jr z, .fury_strikes
	cp EFFECT_CONVERSION
	jr z, .conversion
	cp EFFECT_DOUBLE_HIT
	jr z, .doublehit

.normal_move
	xor a
	ld [wKickCounter], a
.pursuit
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
	jmp AppearUserLowerSub

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
	jmp z, PlayFXAnimID
	xor a
	ld [wNumHits], a
	jmp PlayFXAnimID

; Fury Swipes and Fury Attack were merged into Fury Strikes, so use the correct
; animation for the Pokémon that learned each one
.fury_strikes
	push de
	ldh a, [hBattleTurn]
	and a
	ld a, [wBattleMonSpecies]
	jr z, .got_user_species
	ld a, [wEnemyMonSpecies]
.got_user_species
	ld hl, FuryAttackUsers
	call IsInByteArray
	pop de
	jr nc, .multihit
	ld a, $2
	ld [wKickCounter], a
	jr .fury_attack

StatUpDownAnim:
	ld a, [wAnimationsDisabled]
	and a
	ret nz
	call _CheckBattleEffects
	ret c

	call CheckAlreadyExecuted
	ret nz

	xor a
	ld [wNumHits], a

; Defense Curl, Withdraw, and Harden were merged, so use the correct
; animation for the Pokémon that learned each one
	ld a, BATTLE_VARS_MOVE_ANIM
	call GetBattleVar
	ld e, a
	ld d, 0
	cp DEFENSE_CURL
	jr nz, .not_defense_curl
	ldh a, [hBattleTurn]
	and a
	ld a, [wBattleMonSpecies]
	jr z, .got_user_species
	ld a, [wEnemyMonSpecies]
.got_user_species
	push af
	ld hl, WithdrawUsers
	call IsInByteArray
	jr nc, .not_withdraw
	pop af
	ld a, $1
	jr .got_kick_counter
.not_withdraw
	pop af ; restore species to a
	inc hl ; ld hl, HardenUsers
	call IsInByteArray
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
	jmp PlayFXAnimID

BattleCommand_raisesub:
	ld a, BATTLE_VARS_SUBSTATUS4
	call GetBattleVar
	bit SUBSTATUS_SUBSTITUTE, a
	ret z

	call _CheckBattleEffects
	jmp c, BattleCommand_raisesubnoanim

	xor a
	ld [wNumHits], a
	ld [wFXAnimIDHi], a
	ld a, $2
	ld [wKickCounter], a
	ld a, SUBSTITUTE
	jmp LoadAnim

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
	jmp nz, EndMoveEffect

.multihit
	ld a, BATTLE_VARS_SUBSTATUS3
	call GetBattleVarAddr
	res SUBSTATUS_IN_LOOP, [hl]
	call BattleCommand_raisesub
	jmp EndMoveEffect

.fly_dig
	ld a, BATTLE_VARS_SUBSTATUS3
	call GetBattleVarAddr
	res SUBSTATUS_UNDERGROUND, [hl]
	res SUBSTATUS_FLYING, [hl]
	call AppearUserRaiseSub
	jmp EndMoveEffect

BattleCommand_applydamage:
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
	jr c, .okay
.no_endure
	ld b, $0
.okay
	push bc
	ld c, $0
	call TakeDamage
	call .damage_taken
	pop bc
	ld a, b
	and a
	ret z
	dec a
	jr nz, .not_enduring2
	ld hl, EnduredText
	jmp StdBattleTextbox

.not_enduring2
	dec a
	jr nz, .enduring_with_item
	farcall DisableAnimations
	farcall ShowEnemyAbilityActivation
	ld hl, EnduredText
	call StdBattleTextbox
	farjp EnableAnimations

.enduring_with_item
	push af
	call GetOpponentItem
	call GetCurItemName

	ld hl, HungOnText
	call StdBattleTextbox
	pop af
	dec a
	jmp nz, ConsumeOpponentItem
	ret

.damage_taken
	ld hl, wCurDamage + 1
	ld de, wDamageTaken + 1
	ld a, [de]
	add [hl]
	ld [de], a
	dec de
	dec hl
	ld a, [de]
	push af
	and $f0
	ld b, a
	pop af
	ld a, [de]
	adc [hl]
	ld c, a
	sub b
	and $f0
	ld a, $f
	jr nz, .got_hi_damage
	ld a, c
.got_hi_damage
	and $f
	or b
	ld [de], a
	ret

GetFailureResultText:
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
	call StdBattleTextbox
	ld a, $1
	ld [wKickCounter], a
	call LoadMoveAnim
	ld c, $1
	jmp TakeOpponentDamage

FailText_CheckOpponentProtect:
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
	dec a
	ld hl, DoesntAffectText
	jr z, .printmsg
	ld hl, AttackMissedText
	call StdBattleTextbox
	predef GetUserItemAfterUnnerve
	ld a, b
	cp HELD_BLUNDER_POLICY
	ret nz
	call GetCurItemName
	ld a, [wAlreadyExecuted]
	push af
	ld a, [wFailedMessage]
	push af
	xor a
	ld [wAlreadyExecuted], a
	ld a, STAT_SKIPTEXT | STAT_SILENT
	ld b, $10 | SPEED
	call _ForceRaiseStat
	ld a, [wFailedMessage]
	and a
	jr nz, .policy_done
	farcall UseStatItemText
	call ConsumeUserItem
.policy_done
	pop af
	ld [wFailedMessage], a
	pop af
	ld [wAlreadyExecuted], a
	ret
.printmsg
	jmp StdBattleTextbox
.ability_immune
	farjp RunEnemyNullificationAbilities

BattleCommand_criticaltext:
; Prints the message for critical hits.

; If there is no message to be printed, wait 20 frames.
	ld a, [wCriticalHit]
	and a
	jr z, .wait

	ld hl, CriticalHitText
	call StdBattleTextbox

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
	jmp DelayFrames

BattleCommand_startloop:
	; mark that we're currently in a loop
	ld a, BATTLE_VARS_SUBSTATUS3
	call GetBattleVarAddr
	set SUBSTATUS_IN_LOOP, [hl]

	ldh a, [hBattleTurn]
	and a
	ld hl, wPlayerRolloutCount
	jr z, .got_counter
	ld hl, wEnemyRolloutCount
.got_counter
	ld de, wDamageTaken
	; Reset hit counter
	ld a, $10
	ld [de], a

	; Figure out how many hits we should do.
	ld a, BATTLE_VARS_MOVE_EFFECT
	call GetBattleVar
	cp EFFECT_DOUBLE_HIT
	ld a, 2
	jr z, .got_count

	call GetTrueUserAbility
	cp SKILL_LINK
	ld a, 5
	jr z, .got_count

	; Hit 2-5 times with 2 and 3 being twice as common.
	; So randomize a number 0-5, take (result mod 4) + 2.
	ld a, 6
	call BattleRandomRange
	cp 4
	jr c, .random_ok
	sub 4
.random_ok
	add 2
.got_count
	ld [hl], a
	ret

BattleCommand_supereffectivetext:
	; Only print the message once for Parental Bond
	ld a, BATTLE_VARS_SUBSTATUS2
	call GetBattleVar
	bit SUBSTATUS_IN_ABILITY, a
	ret nz

	ld a, BATTLE_VARS_SUBSTATUS3
	call GetBattleVar
	bit SUBSTATUS_IN_LOOP, a
	jr z, .continue
	ldh a, [hBattleTurn]
	and a
	ld hl, wPlayerRolloutCount
	jr z, .got_multi_count
	ld hl, wEnemyRolloutCount
.got_multi_count
	ld a, [hl]
	dec a
	ret nz

.continue
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
	call StdBattleTextbox
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
	call SwitchTurn
	ld a, STAT_SKIPTEXT
	ld b, $10 | ATTACK
	call _RaiseStat
	ld a, [wFailedMessage]
	ld b, 0
	push bc
	and a
	jr nz, .atk_done
	farcall UseStatItemText
	pop bc
	inc b
	push bc
.atk_done
	ld a, STAT_SKIPTEXT
	ld b, $10 | SP_ATTACK
	call _RaiseStat
	ld a, [wFailedMessage]
	and a
	jr nz, .spatk_done
	farcall UseStatItemText
	pop bc
	inc b
	push bc
.spatk_done
	pop bc
	ld a, b
	and a
	call nz, ConsumeUserItem
	xor a
	ld [wAlreadyExecuted], a
	jmp SwitchTurn

CheckSheerForceNegation:
; Check if a secondary effect was suppressed due to Sheer Force.
; Most likely a bug introduced in Gen V, it is an established
; mechanic at this point (VII) that if Sheer Force negates the
; secondary effect of a move, various side effects don't trigger.
; Returns z if an effect is negated.
	call GetTrueUserAbility
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
	ldh a, [hBattleTurn]
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
	ldh a, [hBattleTurn]
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
	call GetTrueUserAbility
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

	ld a, BATTLE_VARS_SUBSTATUS3
	call GetBattleVar
	bit SUBSTATUS_IN_LOOP, a
	jr z, .no_multi

	call EndMultihit
	call BattleCommand_supereffectivetext
	call BattleCommand_endloop
	call BattleCommand_raisesub

.no_multi
	ld a, BATTLE_VARS_SUBSTATUS2_OPP
	call GetBattleVar
	bit SUBSTATUS_DESTINY_BOND, a
	jr z, .no_dbond

	call GetFutureSightUser
	jr nc, .no_dbond

	ld hl, TookDownWithItText
	call StdBattleTextbox

	call GetMaxHP
	predef SubtractHPFromUser
	call SwitchTurn
	xor a
	ld [wNumHits], a
	ld [wFXAnimIDHi], a
	inc a
	ld [wKickCounter], a
	ld a, DESTINY_BOND
	call LoadAnim
	call SwitchTurn

	ldh a, [hBattleTurn]
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
	cp EFFECT_SWITCH_HIT
	jr nz, .finish
	call HasUserFainted
	call nz, BattleCommand_switchout
.finish
	jmp EndMoveEffect

BattleCommand_posthiteffects:
; This can run even if someone is fainted. Take this into account.
	call HandleRampage

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
	call StdBattleTextbox
	call ConsumeOpponentItem

.air_balloon_done
	call HasOpponentFainted
	jr z, .rage_done
	ld a, BATTLE_VARS_SUBSTATUS4_OPP
	call GetBattleVar
	bit SUBSTATUS_RAGE, a
	jr z, .rage_done

	call SwitchTurn

	; use skiptext so we can print the rage msg first
	ld b, ATTACK
	ld a, STAT_SKIPTEXT
	call _RaiseStat
	ld a, [wFailedMessage]
	and a
	jr nz, .rage_done_switchturn

	push bc
	ld hl, RageBuildingText
	call StdBattleTextbox
	pop bc
	farcall PrintStatChange

.rage_done_switchturn
	call SwitchTurn
.rage_done
	; Do Jaboca and Rowap berries, Rocky Helmet,
	; Absorb Bulb, Snowball, Cell Battery, Luminous Moss
	call HasUserFainted
	jr z, .rocky_helmet_done
	call GetFutureSightUser
	jr nz, .rocky_helmet_done
	call GetOpponentItemAfterUnnerve
	call GetCurItemName
	ld a, b
	cp HELD_ROCKY_HELMET
	jr z, .rocky_helmet
	cp HELD_OFFEND_HIT
	jr z, .offend_hit

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
	call GetCurItemName
	call RaiseStatWithItem
	call SwitchTurn
	jr .rocky_helmet_done

.offend_hit
	ld a, BATTLE_VARS_MOVE_CATEGORY
	call GetBattleVar
	cp c
	jr nz, .rocky_helmet_done

	call GetEighthMaxHP
	jr .got_hurt_item_damage
.rocky_helmet
	call CheckContactMove
	jr c, .rocky_helmet_done
	call GetSixthMaxHP
.got_hurt_item_damage
	call GetTrueUserAbility
	cp MAGIC_GUARD
	jr z, .rocky_helmet_done
	predef SubtractHPFromUser
	call GetOpponentItem
	call GetCurItemName
	ld hl, BattleText_UserHurtByItem
	push bc
	call StdBattleTextbox
	pop bc

	; unless the item is Rocky Helmet, consume it
	ld a, b
	cp HELD_ROCKY_HELMET
	call nz, ConsumeOpponentItem

.rocky_helmet_done
	call GetTrueUserAbility
	cp STENCH
	ld c, 10
	jr z, .do_flinch_up
	call GetUserItem
	push bc
	call GetCurItemName
	pop bc
	ld a, b
	cp HELD_FLINCH_UP
.do_flinch_up
	call z, .flinch_up

	; if we fainted, abort the rest of the move sequence
	call HasUserFainted
	jr nz, .check_parental_bond
	call EndMoveEffect ; oops
	xor a
	ret

.check_parental_bond
	call HasOpponentFainted
	ret z

	call GetTrueUserAbility
	cp PARENTAL_BOND
	ret nz

	; Multi-hit attacks have their own multihit code
	ld a, BATTLE_VARS_SUBSTATUS3
	call GetBattleVarAddr
	bit SUBSTATUS_IN_LOOP, [hl]
	ret nz

	ld a, BATTLE_VARS_SUBSTATUS2
	call GetBattleVarAddr
	bit SUBSTATUS_IN_ABILITY, [hl]
	res SUBSTATUS_IN_ABILITY, [hl]
	jr nz, .resolve_berserk
	set SUBSTATUS_IN_ABILITY, [hl]
	ld b, checkhit_command
	jmp SkipToBattleCommandBackwards

.resolve_berserk
	farjp ResolveOpponentBerserk

.flinch_up:
	; Ensure that the move doesn't already have a flinch rate.
	call HasOpponentFainted
	ret z
	call GetOpponentAbilityAfterMoldBreaker
	cp SHIELD_DUST
	ret z
	ld a, BATTLE_VARS_MOVE_EFFECT
	call GetBattleVar
	cp EFFECT_FLINCH_HIT
	ret z
	cp EFFECT_STOMP
	ret z

	; Serene Grace boosts King's Rock
	call GetTrueUserAbility
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

CheckEndMoveEffects:
; Effects handled at move end skipped by Sheer Force negation except for rampage
	call HandleRampage
	call CheckSheerForceNegation
	ret z
	call GetFutureSightUser
	ret nz

	; Only check white herb if we didn't do damage
	ld a, [wDamageTaken]
	ld b, a
	ld a, [wDamageTaken + 1]
	or b
	call nz, EndMoveDamageChecks
	; fallthrough
CheckWhiteHerb:
	ldh a, [hBattleTurn]
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
	ldh [hBattleTurn], a
	ret

.do_it
	push bc
	predef GetUserItemAfterUnnerve
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
	ldh a, [hBattleTurn]
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
	predef GetUserItemAfterUnnerve
	ld a, b
	pop hl
	pop de
	pop bc
	cp HELD_EJECT_PACK
	jr nz, .not_eject_pack

	ldh a, [hBattleTurn]
	cp b
	ld a, 1 << SWITCH_DEFERRED | 1 << SWITCH_ITEM
	jr z, .move_user_switching
	ld a, 1 << SWITCH_DEFERRED | 1 << SWITCH_TARGET | 1 << SWITCH_OPPITEM
.move_user_switching
	jmp SetDeferredSwitch

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
	call StdBattleTextbox
	jmp ConsumeUserItem

EndMoveDamageChecks:
	call .EndMoveUserItems
	call .EndMoveOpponentItems

	; Pickpocket
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
	farcall DisableAnimations
	farcall ShowAbilityActivation
	call BattleCommand_thief
	farcall EnableAnimations
.no_pickpocket
	jmp SwitchTurn

.EndMoveUserItems:
	; life orb, shell bell
	call HasUserFainted
	ret z
	predef GetUserItemAfterUnnerve
	push bc
	call GetCurItemName
	pop bc
	ld a, b
	cp HELD_LIFE_ORB
	jr z, .life_orb
	cp HELD_SHELL_BELL
	jr z, .shell_bell
	cp HELD_THROAT_SPRAY
	jr z, .throat_spray
	cp HELD_SWITCH
.deferred_switch
	ret nz
	ld a, c
	jmp SetDeferredSwitch

.EndMoveOpponentItems:
	call HasOpponentFainted
	ret z
	call GetOpponentItemAfterUnnerve
	push bc
	call GetCurItemName
	pop bc
	ld a, b
	cp HELD_DEFEND_HIT
	jr z, .defend_hit
	cp HELD_SWITCH_TARGET
	jr .deferred_switch

.shell_bell
	farcall CheckFullHP
	ret z
	ld a, [wDamageTaken]
	and $f
	ld b, a
	ld a, [wDamageTaken + 1]
	ld c, a
	or b
	ret z ; No damage was done
	call HalveBC
	call HalveBC
	call HalveBC
	farcall ItemRecoveryAnim
	farcall RestoreHP
	ld hl, BattleText_UserRecoveredWithItem
	jmp StdBattleTextbox

.life_orb
	call GetTrueUserAbility
	cp MAGIC_GUARD
	ret z

	xor a
	call GetMaxHP
	ld a, b
	ldh [hDividend], a
	ld a, c
	ldh [hDividend + 1], a
	ld a, 10
	ldh [hDivisor], a
	ld b, 2
	call Divide
	ldh a, [hQuotient + 1]
	ld b, a
	ldh a, [hQuotient + 2]
	ld c, a
	predef SubtractHPFromUser
	ld hl, BattleText_UserLostSomeOfItsHP
	jmp StdBattleTextbox

.throat_spray
	push bc
	ld a, BATTLE_VARS_MOVE_ANIM
	call GetBattleVar
	ld hl, SoundMoves
	call IsInByteArray
	pop bc
	ret nc

	ld b, c
	jr RaiseStatWithItem

.defend_hit
	ld a, c
	cp PHYSICAL
	ld b, DEFENSE
	jr z, .got_stat
	ld b, SP_DEFENSE
.got_stat
	ld a, BATTLE_VARS_MOVE_CATEGORY
	call GetBattleVar
	cp c
	ret nz
	call SwitchTurn
	call RaiseStatWithItem
	jmp SwitchTurn

RaiseStatWithItem:
	ld a, STAT_SKIPTEXT
	call _RaiseStat
	ld a, [wFailedMessage]
	and a
	ret nz
	farcall UseStatItemText
	jmp ConsumeUserItem

DittoMetalPowder:
if !DEF(FAITHFUL)
	; grabs true species -- works even if transformed to non-Ditto
	ld a, MON_SPECIES
	call OpponentPartyAttr
else
	; only works if current species is Ditto
	push hl
	ld hl, wBattleMonSpecies
	call GetOpponentMonAttr
	ld a, [hl]
	pop hl
endc
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

UnevolvedEviolite:
	push hl
	push bc
	; c = species
	ld a, MON_SPECIES
	call OpponentPartyAttr
	ld c, a
	; b = form
	ld a, MON_FORM
	call OpponentPartyAttr
	and SPECIESFORM_MASK
	ld b, a
	; bc = index
	call GetSpeciesAndFormIndex
	dec bc
	ld hl, EvosAttacksPointers
	add hl, bc
	add hl, bc
	ld a, BANK(EvosAttacksPointers)
	call GetFarWord
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

BattleCommand_damagestats:
; Return move power d, player level e, enemy defense c and player attack b.

	call ResetDamage

; No damage dealt with 0 power.
	ld a, BATTLE_VARS_MOVE_POWER
	call GetBattleVar
	and a
	ld d, a
	ret z

	ld a, BATTLE_VARS_MOVE_CATEGORY
	call GetBattleVar
	cp SPECIAL
	jr nc, .special

.physical
	ld hl, wBattleMonDefense
	call GetOpponentMonAttr
	ld a, [hli]
	ld b, a
	ld c, [hl]

if !DEF(FAITHFUL)
	call HailDefenseBoost
endc

	ld hl, wBattleMonAttack
	call GetUserMonAttr
	call GetFutureSightUser
	jr z, .atk_ok
	ld a, MON_ATK
	call TrueUserPartyAttr
.atk_ok
	call GetTrueUserAbility
	cp INFILTRATOR
	jr z, .thickcluborlightball
	ldh a, [hBattleTurn]
	and a
	ld a, [wEnemyScreens]
	jr z, .got_opp_screens
	ld a, [wPlayerScreens]
.got_opp_screens
	and SCREENS_REFLECT
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
	call GetOpponentMonAttr
	ld a, [hli]
	ld b, a
	ld c, [hl]

	call SandstormSpDefBoost

	jr .lightscreen

.psystrike
	ld hl, wBattleMonDefense
	call GetOpponentMonAttr
	ld a, [hli]
	ld b, a
	ld c, [hl]

.lightscreen
	ld hl, wBattleMonSpclAtk
	call GetUserMonAttr
	call GetFutureSightUser
	jr z, .sat_ok
	ld a, MON_SAT
	call TrueUserPartyAttr
.sat_ok
	call GetTrueUserAbility
	cp INFILTRATOR
	jr z, .lightball
	ldh a, [hBattleTurn]
	and a
	ld a, [wEnemyScreens]
	jr z, .got_opp_screens2
	ld a, [wPlayerScreens]
.got_opp_screens2
	and SCREENS_LIGHT_SCREEN
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

	ld a, MON_LEVEL
	push hl
	call TrueUserPartyAttr
	pop hl
	ld e, a
	call DittoMetalPowder
	call UnevolvedEviolite

	ld a, 1
	and a
	ret

TruncateHL_BC:
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

ThickClubOrLightBallBoost:
; Return in hl the stat value at hl.

; If the attacking monster is Cubone or Marowak and
; it's holding a Thick Club, or if it's Pikachu and
; it's holding a Light Ball, double it.
	push bc
	push de
	push hl
	ld a, MON_SPECIES
	call TrueUserPartyAttr
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

LightBallBoost:
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

SpeciesItemBoost:
; Return in hl the stat value at hl.

; If the attacking monster is species b or c and
; it's holding item d, double it.

	ld a, [hli]
	ld l, [hl]
	ld h, a

	push hl
	ld a, MON_SPECIES
	call TrueUserPartyAttr
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

SandstormSpDefBoost:
	push bc
	lb bc, WEATHER_SANDSTORM, ROCK
	jr WeatherDefenseBoost
HailDefenseBoost:
	push bc
	lb bc, WEATHER_HAIL, ICE
WeatherDefenseBoost:
	call GetWeatherAfterOpponentUmbrella
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

BattleCommand_clearmissdamage:
	ld a, [wAttackMissed]
	and a
	ret z

	jmp ResetDamage

HitSelfInConfusion:
	call ResetDamage
	ldh a, [hBattleTurn]
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
	and SCREENS_REFLECT
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
	ldh a, [hBattleTurn]
	and a
	ld a, [hl]
	ret z
	ld a, [de]
	ret

ApplyStatBoostDamageAfterUnaware:
	call GetFutureSightUser
	ret nz
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
	call GetTrueUserAbility
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
	jmp MultiplyAndDivide

FarDoStatChangeMod:
	call DoStatChangeMod
	ld b, a
	ret

DoStatChangeMod:
	ld a, b
	cp 7
	jr nc, .higher
	ln a, 2, 9
	sub b ; between $23 (6, e.g. -1 stat change) and $28 (1, e.g. -6 stat change)
	ret
.higher
	ln a, 1, 11
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
	jmp DamagePass4

BattleCommand_damagecalc:
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
	; May have side effects (Pixilates changes move type here).
	farcall ApplyDamageAbilities

	; If we're burned (and don't have Guts), halve damage
	call GetFutureSightUser
	jr z, .not_external_burn
	ld a, MON_STATUS
	call TrueUserPartyAttr
	jr .check_burn
.not_external_burn
	ld a, BATTLE_VARS_STATUS
	call GetBattleVar
.check_burn
	bit BRN, a
	jr z, .burn_done
	call GetTrueUserAbility
	cp GUTS
	ld a, $12 ; 1/2 = 50%
	call nz, ApplyPhysicalAttackDamageMod

.burn_done
	; Flash Fire
	call GetFutureSightUser
	jr nz, .no_flash_fire
	ld a, BATTLE_VARS_SUBSTATUS1
	call GetBattleVar
	bit SUBSTATUS_FLASH_FIRE, a
	jr z, .no_flash_fire
	ld a, BATTLE_VARS_MOVE_TYPE
	call GetBattleVar
	cp FIRE
	ln a, 3, 2 ; x1.5
	call z, MultiplyAndDivide

.no_flash_fire
	; Critical hits
	ld a, [wCriticalHit]
	and a
	jr z, .no_crit

	call GetTrueUserAbility
	cp SNIPER
	ln a, 9, 4 ; x2.25
	jr z, .got_crit_mod
	ln a, 3, 2 ; x1.5
.got_crit_mod
	call MultiplyAndDivide

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
	cp HELD_METRONOME
	jr z, .metronome_item

	cp HELD_LIFE_ORB
	ln a, 13, 10 ; x1.3
	jr z, .life_orb
	jr .done_attacker_item
.type_boost
	ld a, BATTLE_VARS_MOVE_TYPE
	call GetBattleVar
	cp c
	ln a, 6, 5 ; x12
.life_orb
	call z, MultiplyAndDivide
	jr .done_attacker_item
.category_boost
	ld a, BATTLE_VARS_MOVE_CATEGORY
	call GetBattleVar
	cp c
	ln a, 11, 10 ; x1.1
	call z, MultiplyAndDivide
	jr .done_attacker_item
.choice
	ld a, c
	cp SP_ATTACK
	jr z, .choice_sat
	and a ; cp ATTACK
	jr nz, .done_attacker_item
	ln a, 3, 2 ; x1.5
	call ApplyPhysicalAttackDamageMod
	jr .done_attacker_item
.choice_sat
	ln a, 3, 2 ; x1.5
	call ApplySpecialAttackDamageMod
	jr .done_attacker_item
.metronome_item
	; Skip Metronome for Future Sight
	call GetFutureSightUser
	jr nc, .done_attacker_item
	ln b, 5, 5 ; (5+n)/5 = 100% + 20% * n
	ldh a, [hBattleTurn]
	and a
	ld a, [wPlayerMetronomeCount]
	jr z, .got_metronome_count
	ld a, [wEnemyMetronomeCount]
.got_metronome_count
	swap a
	add b
	call MultiplyAndDivide
	; fallthrough
.done_attacker_item
	call GetOpponentItem

	ld a, b
	cp HELD_ASSAULT_VEST
	jr nz, .done_defender_item
	ld a, $23 ; 2/3 = 67%
	call ApplySpecialDefenseDamageMod
	; fallthrough
.done_defender_item
	pop bc
	call DamagePass3
	jr DamagePass4

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
	jmp Multiply

DamagePass3:
	; / Defense
	ld hl, hMultiplier
	ld [hl], c
	ld b, $4
	call Divide

	; / 50
	ld [hl], 50
	ld b, $4
	jmp Divide

DamagePass4:
	; Add 2 unless damage is at least $ff00 -- set wCurDamage to $ff** in that case.
	ld hl, wCurDamage
	ldh a, [hQuotient]
	and a
	jr z, .damage_ok

	; Store $ff**
	ld [hl], $ff
.end
	or 1
	ret

.damage_ok
	ldh a, [hQuotient + 1]
	ld [hli], a
	ld b, a
	inc b
	jr z, .end
	ldh a, [hQuotient + 2]
	add 2
	ld [hld], a
	jr nc, .end
	inc [hl]
	jr .end

BattleCommand_constantdamage:
	ld hl, wBattleMonLevel
	ldh a, [hBattleTurn]
	and a
	jr z, .got_turn
	ld hl, wEnemyMonLevel

.got_turn
	ld a, BATTLE_VARS_MOVE_EFFECT
	call GetBattleVar
	cp EFFECT_LEVEL_DAMAGE
	ld b, [hl]
	ld a, 0
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
	ldh a, [hBattleTurn]
	and a
	jr z, .got_hp
	ld hl, wBattleMonHP
.got_hp
	ld a, [hli]
	srl a
	ld b, a
	ld a, [hl]
	rra
	push af
	ld a, b
	pop bc
	and a
	jr nz, .got_power
	or b
	ld a, 0
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
	ldh a, [hBattleTurn]
	and a
	jr z, .reversal_got_hp
	ld hl, wEnemyMonHP
.reversal_got_hp
	xor a
	ldh [hDividend], a
	ldh [hMultiplicand + 0], a
	ld a, [hli]
	ldh [hMultiplicand + 1], a
	ld a, [hli]
	ldh [hMultiplicand + 2], a
	ld a, $30
	ldh [hMultiplier], a
	call Multiply
	ld a, [hli]
	ld b, a
	ld a, [hl]
	ldh [hDivisor], a
	ld a, b
	and a
	jr z, .skip_to_divide

	ldh a, [hProduct + 4]
	srl b
	rra
	srl b
	rra
	ldh [hDivisor], a
	ldh a, [hProduct + 2]
	ld b, a
	srl b
	ldh a, [hProduct + 3]
	rra
	srl b
	rra
	ldh [hDividend + 3], a
	ld a, b
	ldh [hDividend + 2], a

.skip_to_divide
	ld b, $4
	call Divide
	ldh a, [hQuotient + 2]
	ld b, a
	ld hl, ReversalPower

.reversal_loop
	ld a, [hli]
	cp b
	jr nc, .break_loop
	inc hl
	jr .reversal_loop

.break_loop
	ld a, [hl]
	push af
	ld a, BATTLE_VARS_MOVE_POWER
	call GetBattleVarAddr
	pop af
	ld [hl], a
	push hl
	call BattleCommand_damagestats
	call BattleCommand_damagecalc
	pop hl
	ld [hl], 1
	ret

UserKnowsMove:
; Returns z if user knows move a starting from hl to NUM_MOVES
; If so, c points to move offset, hl to move address
	ld c, NUM_MOVES
.loop
	cp [hl]
	jr z, .got_move
	inc hl
	dec c
	jr nz, .loop

	; User doesn't know move
	inc c
	ret
.got_move
	ld a, NUM_MOVES
	sub c
	ld c, a
	xor a
	ret

FarPlayBattleAnimation:
; play animation de

	ld a, BATTLE_VARS_SUBSTATUS3
	call GetBattleVar
	and 1 << SUBSTATUS_FLYING | 1 << SUBSTATUS_UNDERGROUND
	ret nz

	; fallthrough

PlayFXAnimID:
	ld a, e
	ld [wFXAnimIDLo], a
	ld a, d
	ld [wFXAnimIDHi], a

	ld c, 3
	call DelayFrames

	farcall PlayBattleAnim

	ret

TakeOpponentDamage:
; user takes damage, doesn't apply berserk so don't run the regular damage func
	ld hl, wCurDamage
	ld a, [hli]
	ld b, a
	ld a, [hl]
	or b
	jr z, .did_no_damage

	ld a, c
	and a
	jr nz, .mimic_sub_check

	ld a, BATTLE_VARS_SUBSTATUS4
	call GetBattleVar
	bit SUBSTATUS_SUBSTITUTE, a
	jr z, .mimic_sub_check
	call SwitchTurn
	call SelfInflictDamageToSubstitute
	jmp SwitchTurn

.mimic_sub_check
	ld a, [hld]
	ld c, a
	ld b, [hl]
	farcall SubtractHPFromUser
.did_no_damage
	jmp RefreshBattleHuds

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
	jr nz, SelfInflictDamageToSubstitute
.mimic_sub_check
	ld a, [hld]
	ld c, a
	ld b, [hl]
	farcall DealDamageToOpponent
.did_no_damage
	jmp RefreshBattleHuds

SelfInflictDamageToSubstitute:
	ld hl, SubTookDamageText
	call StdBattleTextbox

	ld de, wEnemySubstituteHP+1 ; hp is big-endian
	ldh a, [hBattleTurn]
	and a
	jr z, .got_hp
	ld de, wPlayerSubstituteHP+1
.got_hp

	ld hl, wCurDamage
	ld a, [hl]
	and a
	ld a, 0
	ld [hli], a
	jr nz, .broke

	ld a, [de]
	sub [hl]
	jr z, .broke
	jr c, .broke
	ld [de], a
	ret

.broke
	; Set damage done to be equal to remaining substitute HP.
	; This makes recoil and draining moves be handled correctly.
	; We've already set the upper byte to zero.
	ld a, [de]
	ld [hl], a

	ld a, BATTLE_VARS_SUBSTATUS4_OPP
	call GetBattleVarAddr
	res SUBSTATUS_SUBSTITUTE, [hl]

	ld hl, SubFadedText
	call StdBattleTextbox

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
	cp EFFECT_FURY_STRIKES
	jr z, .ok
	xor a
	ld [hl], a
.ok
	jmp RefreshBattleHuds

UpdateMoveData:
	ld a, BATTLE_VARS_MOVE_ANIM
	call GetBattleVarAddr
	ld d, h
	ld e, l

	; Zerofill if the move doesn't exist
	ld a, BATTLE_VARS_MOVE
	call GetBattleVar
	and a
	jr nz, .not_null
	push hl
	push de
	push bc
	ld a, BATTLE_VARS_MOVE_ANIM
	call GetBattleVarAddr
	ld bc, wPlayerMoveStructEnd - wPlayerMoveStruct
	xor a
	rst ByteFill
	jmp PopBCDEHL

.not_null
	ld [wCurMove], a
	ld [wNamedObjectIndex], a

	push hl
	push de
	push bc
	push af

	; Write to move selection
	ld c, a
	ld hl, wBattleMonMoves
	call GetUserMonAttr
	ld a, c
	call UserKnowsMove
	jr nz, .done

	ldh a, [hBattleTurn]
	and a
	ld hl, wCurMoveNum
	jr z, .got_move_num
	ld hl, wCurEnemyMoveNum
.got_move_num
	ld [hl], c

.done
	pop af
	pop bc
	pop de
	pop hl

	call GetFixedMoveStruct
	call GetMoveName
	jmp CopyName1

IsOpponentLeafGuardActive:
	call GetTrueUserAbility
	jr DoLeafGuardCheck
IsLeafGuardActive:
; returns z if leaf guard applies for enemy
	call GetOpponentAbilityAfterMoldBreaker
DoLeafGuardCheck:
	cp LEAF_GUARD
	ret nz
	call GetWeatherAfterOpponentUmbrella
	cp WEATHER_SUN
	ret

PostStatusWithSynchronize:
	farcall RunEnemySynchronizeAbility
PostStatus:
	farcall UseOpponentHeldStatusHealingItem
	farjp RunEnemyStatusHealAbilities

BattleCommand_sleep:
	ld a, [wTypeModifier]
	and a
	jr z, .failed_ineffective

	ld b, 0
	call CanSleepTarget
	jr c, .ability_ok
	jr nz, .failed

	ld a, [wAttackMissed]
	and a
	jr nz, .failed_ineffective

	call AnimateCurrentMove
	ld c, 30
	call DelayFrames
	xor a
	ld [wNumHits], a
	ld de, ANIM_SLP
	call PlayOpponentBattleAnim
	ld a, $1
	ldh [hBGMapMode], a
	ld a, BATTLE_VARS_STATUS_OPP
	call GetBattleVarAddr

	; 1-3 turns of sleep, rnd(0-2) + 2 since Pokémon wake up once it ticks to 0.
	push hl
	ld a, 3
	call BattleRandomRange
	add 2
	pop hl
	ld [hl], a
	call UpdateOpponentInParty
	call UpdateBattleHuds
	ld hl, FellAsleepText
	call StdBattleTextbox
	call PostStatus

	; Check if we were cured
	ld a, BATTLE_VARS_STATUS_OPP
	cp 1 << SLP
	jmp z, OpponentCantMove
	ret

.failed_ineffective
	call AnimateFailedMove
	jmp FailText_CheckOpponentProtect

.failed
	push hl
	call AnimateFailedMove
	pop hl
	jmp StdBattleTextbox

.ability_ok
	farcall DisableAnimations
	farcall ShowEnemyAbilityActivation
	call AnimateFailedMove
	call PrintDoesntAffect
	farjp EnableAnimations

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
; Input:
; a=0: Check Mold Breaker and Substitute (user directly poisoning foe)
; a=1: Ignore MB and sub (Toxic Spikes, target on-contact abilities)
; a=2: Ignore MB and sub, check victim for Corrosion (Toxic Orb)
; bc: Type immunities
; d: Ability immunity
; e: Item immunity
; h: Status
; Returns:
;     z -- we can
;  c|nz -- we can't, due to ability
; nc|nz -- we can't, failure msg in HL
	push af
	ld a, BATTLE_VARS_STATUS_OPP
	call GetBattleVar
	and h
	jr nz, .already_statused

	; Corrosion bypasses everything except existing status problems
	ld a, h
	cp 1 << PSN
	jr nz, .not_corrosive

	pop af
	and a
	push af
	and a
	jr z, .check_psn_status_move
	dec a
	jr z, .not_corrosive

	; Check target (not user!) for corrosion, used with Toxic Orb.
	call GetOpponentAbility
	jr .check_corrosion

.check_psn_status_move
	; We can't check if the move is a status move in general, because
	; this causes problems with Roar + Corrosion into Toxic Spikes,
	; which shouldn't poison Poison/Steel-types. Instead, we have to
	; specifically check for status moves that cause poisoning.
	ld a, BATTLE_VARS_MOVE_EFFECT
	call GetBattleVar
	cp EFFECT_POISON
	jr z, .check_user_corrosion
	cp EFFECT_TOXIC
	jr nz, .not_corrosive
.check_user_corrosion
	call GetTrueUserAbility
.check_corrosion
	cp CORROSION
	jr nz, .not_corrosive
	pop af
	jr .immunities_done

.not_corrosive
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
	jr nz, .no_mold_breaker
	call CheckSubstituteOpp
	ld hl, ButItFailedText
	jr nz, .end
	call GetOpponentAbilityAfterMoldBreaker
	jr .got_ability
.no_mold_breaker
	call GetOpponentAbility
.got_ability
	; Vital Spirit does the same thing as Insomnia so treat it as Insomnia.
	cp VITAL_SPIRIT
	ld e, INSOMNIA
	jr z, .ability_replace
	cp PASTEL_VEIL
	ld e, IMMUNITY
	jr nz, .replace_done
.ability_replace
	ld a, e
.replace_done
	cp d
	jr z, .cant_ability
	call DoLeafGuardCheck
	jr z, .cant_ability
.immunities_done
	ld a, BATTLE_VARS_STATUS_OPP
	call GetBattleVar
	and a
	ld hl, ButItFailedText
	ret
.already_statused
	bit BRN, a
	ld hl, AlreadyBurnedText
	jr nz, .pop_and_end
	bit PSN, a
	ld hl, AlreadyPoisonedText
	jr nz, .pop_and_end
	bit PAR, a
	ld hl, AlreadyParalyzedText
	jr nz, .pop_and_end
	; Shouldn't happen
	bit FRZ, a
	ld hl, AlreadyConfusedText ; no AlreadyFrozen
	jr nz, .pop_and_end
	ld hl, AlreadyAsleepText
	jr .pop_and_end
.cant_type
	ld hl, DoesntAffectText
	pop de
	jr .pop_and_end
.cant_item
	call GetCurItemName
	ld hl, ProtectedByText
	; fallthrough
.pop_and_end
	pop af
.end
	or 1
	ret
.cant_ability
	xor a
	cp 1
	ret

BattleCommand_poisontarget:
	ld b, 0
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
	call StdBattleTextbox

	jmp PostStatusWithSynchronize

PoisonOpponent:
	ld a, BATTLE_VARS_STATUS_OPP
	call GetBattleVarAddr
	set PSN, [hl]
	jmp UpdateOpponentInParty

BattleCommand_draintarget:
	ld hl, SuckedHealthText
	; fallthrough
SapHealth:
	; Don't do anything if HP is full unless opponent has Liquid Ooze
	call GetOpponentAbilityAfterMoldBreaker
	cp LIQUID_OOZE
	jr z, .continue
	push hl
	farcall CheckFullHP
	pop hl
	ret z

.continue
	; get damage
	push hl
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
	farcall RestoreHP
	pop hl
	jmp StdBattleTextbox

.damage
	pop hl
	farcall DisableAnimations
	farcall ShowEnemyAbilityActivation
	predef SubtractHPFromUser
	ld hl, SuckedUpOozeText
	call StdBattleTextbox
	farjp EnableAnimations

GetHPAbsorption:
; From damage in bc, get resulting absorbed HP
	call HandleBigRoot
	jmp HalveBC

HandleBigRoot:
; Bonus +30% HP drain (or reduction if Liquid Ooze)
	push bc
	predef GetUserItemAfterUnnerve
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
	ldh a, [hQuotient + 1]
	ld b, a
	ldh a, [hQuotient + 2]
	ld c, a
	ret

BattleCommand_burntarget:
	xor a
	ld [wNumHits], a

	; Needs to be checked here too, because it should prevent defrosting
	call CheckSubstituteOpp
	ret nz
	ld a, BATTLE_VARS_STATUS_OPP
	call GetBattleVarAddr
	and a
	jr nz, Defrost
	ld b, 0
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
	call StdBattleTextbox
	jmp PostStatusWithSynchronize

Defrost:
	ld a, [hl]
	and 1 << FRZ
	ret z

	xor a
	ld [hl], a

	ldh a, [hBattleTurn]
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
	jmp StdBattleTextbox

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
	call GetWeatherAfterOpponentUmbrella
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
	call StdBattleTextbox

	jmp PostStatus
.no_magma_armor
	call OpponentCantMove
	jmp EndRechargeOpp

BattleCommand_paralyzetarget:
	xor a
	ld [wNumHits], a
	ld b, 0
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
	jmp PostStatusWithSynchronize

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
_ForceRaiseStat: ; no-optimize stub jump
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
	or STAT_TARGET
	jr ChangeStat

BattleCommand_forceloweroppstat:
	ld b, -1
ForceLowerOppStat:
	xor a
_ForceLowerOppStat:
	or STAT_TARGET | STAT_LOWER
	jr ChangeStat

BattleCommand_raiseoppstat:
	ld b, -1
RaiseOppStat:
	xor a
_RaiseOppStat:
	or STAT_TARGET | STAT_MISS
	jr ChangeStat

BattleCommand_loweroppstat:
	ld b, -1
LowerOppStat:
	xor a
_LowerOppStat:
	or STAT_TARGET | STAT_LOWER | STAT_MISS
	jr ChangeStat

BattleCommand_raiseoppstathit:
	ld b, -1
RaiseOppStatHit:
	xor a
_RaiseOppStatHit:
	or STAT_TARGET | STAT_MISS | STAT_SECONDARY | STAT_SILENT
	jr ChangeStat

BattleCommand_loweroppstathit:
	ld b, -1
LowerOppStatHit:
	xor a
_LowerOppStatHit:
	or STAT_TARGET | STAT_LOWER | STAT_MISS | STAT_SECONDARY | STAT_SILENT
ChangeStat:
; b contains stat to alter, or zero if it should be read from the move script
	farjp FarChangeStat

ResetMiss:
	xor a
	ld [wAttackMissed], a
	ret

DisplayStatusProblem:
; Prints message and an animation upon being afflicted by a status problem.
	ld a, BATTLE_VARS_STATUS_OPP
	call GetBattleVar
	and a
	ret z ; Nothing happened?

	ld e, a
	call ShowPotentialAbilityActivation
	ld bc, 4
	ld hl, StatusProblemTable - 4
.loop
	add hl, bc
	ld a, [hli]
	and e
	jr z, .loop

	ld a, [hli]
	ld d, [hl]
	ld e, a
	inc hl
	push hl
	call PlayOpponentBattleAnim
	pop hl
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jmp StdBattleTextbox

status_problem: MACRO
	db \1 ; status mask
	dw \2 ; animation
	dw \3 ; text
ENDM

StatusProblemTable:
	status_problem 1 << TOX, ANIM_PSN, BadlyPoisonedText ; needs to be before PSN
	status_problem 1 << PAR, ANIM_PAR, ParalyzedText
	status_problem 1 << FRZ, ANIM_FRZ, FrozenSolidText
	status_problem 1 << BRN, ANIM_BRN, WasBurnedText
	status_problem 1 << PSN, ANIM_PSN, WasPoisonedText
	status_problem      SLP, ANIM_SLP, FellAsleepText

BattleCommand_poison:
	ld a, 1 << PSN
	; fallthrough (the part below is called by BC_toxic)
_BattleCommand_poison:
	ld hl, CanPoisonTarget
	jr StatusTargetVerbose
BattleCommand_paralyze:
	ld a, 1 << PAR
	ld hl, CanParalyzeTarget
	jr StatusTargetVerbose
BattleCommand_burn:
	ld a, 1 << BRN
	ld hl, CanBurnTarget
	; fallthrough
StatusTargetVerbose:
; Returns z if we successfully inflicted a status problem.
	push af
	ld a, [wTypeModifier]
	and a
	jr z, .failed_ineffective

	ld b, 0
	call _hl_
	jr c, .ability_ok
	jr nz, .failed

	ld a, [wAttackMissed]
	and a
	jr nz, .failed_ineffective

	call AnimateCurrentMove
	ld c, 30
	call DelayFrames
	xor a
	ld [wNumHits], a

	ld a, BATTLE_VARS_STATUS_OPP
	call GetBattleVarAddr
	pop af
	ld [hl], a
	call DisplayStatusProblem
	call UpdateOpponentInParty
	call UpdateBattleHuds
	call PostStatusWithSynchronize
	xor a
	ret

.failed_ineffective
	call AnimateFailedMove
	call FailText_CheckOpponentProtect
	jr .done

.ability_ok
	farcall DisableAnimations
	farcall ShowEnemyAbilityActivation
	ld hl, DoesntAffectText
.failed
	push hl
	call AnimateFailedMove
	pop hl
	call StdBattleTextbox
	farcall EnableAnimations
.done
	pop af
	; a contains the status problem we wanted to afflict. So this returns nz.
	and a
	ret

BattleCommand_raisesubnoanim:
	ld hl, GetMonBackpic
	ldh a, [hBattleTurn]
	and a
	jr z, .PlayerTurn
	ld hl, GetMonFrontpic
.PlayerTurn:
	xor a
	ldh [hBGMapMode], a
	call CallBattleCore
	jmp ApplyTilemapInVBlank

BattleCommand_lowersubnoanim:
	ld hl, DropPlayerSub
	ldh a, [hBattleTurn]
	and a
	jr z, .PlayerTurn
	ld hl, DropEnemySub
.PlayerTurn:
	xor a
	ldh [hBGMapMode], a
	call CallBattleCore
	jmp ApplyTilemapInVBlank

BattleCommand_rampage:
; No rampage during Sleep Talk.
	ld a, BATTLE_VARS_STATUS
	call GetBattleVar
	and SLP
	ret nz

	call CheckRampageStatusAndGetRolloutCount
	jr nz, .already_rampaging
	set SUBSTATUS_RAMPAGE, [hl]
; Rampage for 1 or 2 more turns
	call BattleRandom
	and %00000001
	inc a
	ld [de], a
	ret

.already_rampaging
	ld a, [de]
	dec a
	ld [de], a
	ret

HandleRampage:
; Decrements rampage counter and confuses the user if rampage count is zero,
; otherwise ends rampage if the attack missed for any reason
	call HasUserFainted
	ret z

	call CheckRampageStatusAndGetRolloutCount
	ret z
	ld a, [de]
	and a
	jr nz, HandleRampage_CheckMiss
	res SUBSTATUS_RAMPAGE, [hl]
HandleRampage_ConfuseUser:
	bit SUBSTATUS_CONFUSED, [hl]
	ret nz
	call GetTrueUserAbility
	cp OWN_TEMPO
	ret z

	set SUBSTATUS_CONFUSED, [hl]
	inc de ; ConfuseCount
	call BattleRandom
	and %11
	inc a
	inc a
	ld [de], a
	call CallOpponentTurn
	ld hl, BecameConfusedDueToFatigueText
	jmp FinishConfusingTargetAnim

HandleRampage_CheckMiss:
	ld a, [wAttackMissed]
	and a
	ret z
	res SUBSTATUS_RAMPAGE, [hl]
	ret

CheckRampageStatusAndGetRolloutCount:
; returns z if not rampaging
; returns hl: address to user substatus 3
; returns de: user rampage count
	ld de, wPlayerRolloutCount
	ldh a, [hBattleTurn]
	and a
	jr z, .ok
	ld de, wEnemyRolloutCount
.ok
	ld a, BATTLE_VARS_SUBSTATUS3
	call GetBattleVarAddr
	bit SUBSTATUS_RAMPAGE, [hl]
	ret

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
	call GetOpponentAbility
	cp MAGNET_PULL
	jr z, .has_magnet_pull
	cp ARENA_TRAP
	jr z, .has_arena_trap
	cp SHADOW_TAG
	ret
.has_magnet_pull
	; Only works on Steel types
	jmp CheckIfUserIsSteelType
.has_arena_trap
	; Doesn't work on airborne mons
	ld d, 0
	call CheckAirborne
	jr nz, .not_trapped
	xor a
	ret

SetBattleDraw:
	ld a, [wBattleResult]
	and $c0
	or $2
	ld [wBattleResult], a
	ret

BattleCommand_switchout:
	call CheckAnyOtherAliveMons
	ret z
	ld a, 1 << SWITCH_DEFERRED | 1 << SWITCH_PURSUIT
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

InvertDeferredSwitch:
; For reflecting move effects
	ld a, [wDeferredSwitch]
	and a
	ret z
	xor 1 << SWITCH_TARGET
	ld [wDeferredSwitch], a
	ret

CheckPlayerHasMonToSwitchTo:
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

EndMultihit:
	ld a, BATTLE_VARS_SUBSTATUS3
	call GetBattleVar
	bit SUBSTATUS_IN_LOOP, a
	ret z

	; force this to be the last loop iteration
	push hl
	ldh a, [hBattleTurn]
	and a
	ld hl, wPlayerRolloutCount
	jr z, .got_loop_counter
	ld hl, wEnemyRolloutCount
.got_loop_counter
	ld [hl], 1
	pop hl
	ret

BattleCommand_endloop:
	ldh a, [hBattleTurn]
	and a
	ld hl, wPlayerRolloutCount
	jr z, .got_counter
	ld hl, wEnemyRolloutCount
.got_counter
	ld de, wDamageTaken
	dec [hl]
	jr nz, .loop_back_to_critical

	ld a, BATTLE_VARS_SUBSTATUS3
	call GetBattleVarAddr
	res SUBSTATUS_IN_LOOP, [hl]

	push de
	farcall ResolveOpponentBerserk
	pop de
	ld hl, wStringBuffer1
	ld a, [de]
	swap a
	and $f
	ld [hl], a
	dec a
	ld hl, Hit1TimeText
	jr z, .got_hit_n_times_text
	ld hl, HitNTimesText
.got_hit_n_times_text
	jmp StdBattleTextbox

; Loop back to the command before 'critical'.
.loop_back_to_critical
	ld a, [de]
	add $10
	ld [de], a
	ld b, critical_command
	jmp SkipToBattleCommandBackwards

BattleCommand_flinchtarget:
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

FlinchTarget:
	ld a, BATTLE_VARS_SUBSTATUS4_OPP
	call GetBattleVarAddr
	set SUBSTATUS_FLINCHED, [hl]
	jmp EndRechargeOpp

CheckOpponentWentFirst:
; Returns a=0, z if user went first
; Returns a=1, nz if opponent went first
	push hl
	ld hl, wEnemyGoesFirst
	ldh a, [hBattleTurn]
	xor [hl]
	pop hl
	ret

BattleCommand_charge:
	ld a, BATTLE_VARS_SUBSTATUS3
	call GetBattleVarAddr
	bit SUBSTATUS_CHARGED, [hl]
	jr z, .not_charging
	and ~(1 << SUBSTATUS_CHARGED | 1 << SUBSTATUS_UNDERGROUND | 1 << SUBSTATUS_FLYING)
	ld [hl], a
	ret

.not_charging
	push hl
	call BattleCommand_cleartext
	pop hl
	ld a, BATTLE_VARS_STATUS
	call GetBattleVar
	and SLP
	jr z, .awake

	call BattleCommand_movedelay
	call BattleCommand_raisesub
	call PrintButItFailed
	jmp EndMoveEffect

.awake
	set SUBSTATUS_CHARGED, [hl]

	ld hl, IgnoredOrders2Text
	ld a, [wAlreadyDisobeyed]
	and a
	call nz, StdBattleTextbox

	call BattleCommand_lowersub
	xor a
	ld [wNumHits], a
	inc a
	ld [wKickCounter], a
	call LoadMoveAnim
	ld a, BATTLE_VARS_MOVE_EFFECT
	call GetBattleVar
	cp EFFECT_FLY
	jr nz, .not_flying

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
	call ResetDamage

	ld hl, .UsedText
	call BattleTextbox
	jmp EndMoveEffect

.UsedText:
	text_far Text_BattleUser ; "[USER]"
	text_asm
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
	text_far _BattleTookSunlightText
	text_end

.Fly:
; 'flew up high!'
	text_far _BattleFlewText
	text_end

.Dig:
; 'dug a hole!'
	text_far _BattleDugText
	text_end

BattleCommand_traptarget:
	ld a, [wAttackMissed]
	and a
	ret nz
	ld hl, wEnemyWrapCount
	ld de, wEnemyTrappingMove
	ldh a, [hBattleTurn]
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
	jmp StdBattleTextbox

.Traps:
	dbw WRAP,      WrappedByText     ; 'was WRAPPED by'
	dbw FIRE_SPIN, FireSpinTrapText  ; 'was trapped!'
	dbw WHIRLPOOL, WhirlpoolTrapText ; 'was trapped!'

BattleCommand_recoil:
	ld a, BATTLE_VARS_MOVE_ANIM
	call GetBattleVar
	ld b, a
	inc a ; cp STRUGGLE
	jr z, .StruggleRecoil

	; For all other moves, potentially disable
	; recoil based on ability
	call GetTrueUserAbility
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
	predef SubtractHPFromUser
.recoil_text
	ld hl, RecoilText
	jmp StdBattleTextbox

.StruggleRecoil
	call GetQuarterMaxHP
	jr .recoil_floor

.OneThirdRecoil
	ld a, BATTLE_VARS_MOVE_ANIM
	call GetBattleVar
	ld d, a
	ld a, [wCurDamage]
	ldh [hDividend], a
	ld a, [wCurDamage + 1]
	ldh [hDividend + 1], a
	ld a, 3
	ldh [hDivisor], a
	ld b, 2
	call Divide
	ldh a, [hQuotient + 2]
	ld c, a
	ldh a, [hQuotient + 1]
	ld b, a
	jr .recoil_floor

BattleCommand_confusetarget:
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
	ld a, [wAttackMissed]
	and a
	ret nz
	jr FinishConfusingTarget

BattleCommand_confuse:
	call GetOpponentItem
	ld a, b
	cp HELD_PREVENT_CONFUSE
	jr nz, .no_item_protection
	call GetCurItemName
	call AnimateFailedMove
	ld hl, ProtectedByText
	jmp StdBattleTextbox

.no_item_protection
	call GetOpponentAbilityAfterMoldBreaker
	cp OWN_TEMPO
	jr nz, .no_ability_protection
	farcall DisableAnimations
	farcall ShowEnemyAbilityActivation
	ld hl, DoesntAffectText
	call StdBattleTextbox
	farjp EnableAnimations

.no_ability_protection
	ld a, BATTLE_VARS_SUBSTATUS3_OPP
	call GetBattleVarAddr
	bit SUBSTATUS_CONFUSED, [hl]
	jr z, .not_already_confused
	call AnimateFailedMove
	ld hl, AlreadyConfusedText
	jmp StdBattleTextbox

.not_already_confused
	call CheckSubstituteOpp
	jr nz, Confuse_CheckSwagger_ConfuseHit
	ld a, [wAttackMissed]
	and a
	jr nz, Confuse_CheckSwagger_ConfuseHit
FinishConfusingTarget:
	ld bc, wEnemyConfuseCount
	ldh a, [hBattleTurn]
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
	call nz, AnimateCurrentMove
.got_effect
	ld hl, BecameConfusedText
	; fallthrough
FinishConfusingTargetAnim:
; parameter hl: contains pointer to text box
	ld de, ANIM_CONFUSED
	call PlayOpponentBattleAnim

	call StdBattleTextbox

	farcall UseOpponentConfusionHealingItem
	farjp RunEnemyStatusHealAbilities

Confuse_CheckSwagger_ConfuseHit:
	ld a, BATTLE_VARS_MOVE_EFFECT
	call GetBattleVar
	cp EFFECT_CONFUSE_HIT
	ret z
	cp EFFECT_SWAGGER
	ret z
	jmp PrintDidntAffect2

BattleCommand_rechargenextturn:
	ld a, BATTLE_VARS_SUBSTATUS3
	call GetBattleVarAddr
	set SUBSTATUS_RECHARGE, [hl]
	ret

EndRechargeOpp:
	push hl
	ld a, BATTLE_VARS_SUBSTATUS3_OPP
	call GetBattleVarAddr
	res SUBSTATUS_RECHARGE, [hl]
	pop hl
	ret

BattleCommand_resetstats:
	ld a, BASE_STAT_LEVEL
	ld hl, wPlayerStatLevels
	call .Fill
	ld hl, wEnemyStatLevels
	call .Fill

	call AnimateCurrentMove

	ld hl, EliminatedStatsText
	jmp StdBattleTextbox

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
	jmp z, .hp_full
	ld a, BATTLE_VARS_MOVE_ANIM
	call GetBattleVar
	cp REST
	jr nz, .not_rest
	ld a, BATTLE_VARS_STATUS
	call GetBattleVar
	and SLP
	jmp nz, BattleEffect_ButItFailed
	call GetTrueUserAbility
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
	ld [hl], REST_SLEEP_TURNS + 1
	ld hl, WentToSleepText
	jr z, .no_status_to_heal
	ld hl, RestedText
.no_status_to_heal
	call StdBattleTextbox
	call GetMaxHP
	jr .finish
.not_rest
	call GetHalfMaxHP
.finish

; Softboiled and Milk Drink were merged into Fresh Snack, so use the correct
; animation for the Pokémon that learned each one
	ld a, BATTLE_VARS_MOVE_ANIM
	call GetBattleVar
	cp FRESH_SNACK
	ld a, 0
	jr nz, .not_fresh_snack
	ldh a, [hBattleTurn]
	and a
	ld a, [wBattleMonSpecies]
	jr z, .got_user_species
	ld a, [wEnemyMonSpecies]
.got_user_species
	cp MILTANK
	ld a, 0
	jr nz, .got_kick_counter
	inc a
.got_kick_counter
	ld [wKickCounter], a
.not_fresh_snack

	call AnimateCurrentMove
	farcall RestoreHP
	call UpdateUserInParty
	call RefreshBattleHuds
	ld hl, RegainedHealthText
	jmp StdBattleTextbox

.ability_prevents_rest
	farcall DisableAnimations
	farcall ShowAbilityActivation
	call AnimateFailedMove
	farjp EnableAnimations

.hp_full
	call AnimateFailedMove
	ld hl, HPIsFullText
	jmp StdBattleTextbox

BattleSideCopy:
; Copy bc bytes from hl to de if it's the player's turn.
; Copy bc bytes from de to hl if it's the enemy's turn.
	ldh a, [hBattleTurn]
	and a
	call nz, SwapHLDE
	rst CopyBytes
	ret

BattleEffect_ButItFailed:
	call AnimateFailedMove
	jr PrintButItFailed

ClearLastMove:
	ld a, BATTLE_VARS_LAST_COUNTER_MOVE
	call GetBattleVarAddr
	xor a
	ld [hl], a

	ld a, BATTLE_VARS_LAST_MOVE
	call GetBattleVarAddr
	xor a
	ld [hl], a
	ret

ResetActorDisable:
	ldh a, [hBattleTurn]
	and a
	jr z, .player

	xor a
	ld [wEnemyDisableCount], a
	ret

.player
	xor a
	ld [wPlayerDisableCount], a
	ret

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

PrintDoesntAffect:
; 'it doesn't affect'
	ld hl, DoesntAffectText
	jmp StdBattleTextbox

PrintNothingHappened:
; 'but nothing happened!'
	ld hl, NothingHappenedText
	jmp StdBattleTextbox

TryPrintButItFailed:
	call CheckAlreadyExecuted
	ret nz
PrintButItFailed:
; 'but it failed!'
	ld hl, ButItFailedText
	jmp StdBattleTextbox

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
	jmp StdBattleTextbox

PrintParalyze:
; 'paralyzed! maybe it can't attack!'
	ld hl, ParalyzedText
	jmp StdBattleTextbox

CheckSubstituteOpp:
; returns z when not behind a sub (or if overridden by Infiltrator or sound)
	call GetTrueUserAbility
	cp INFILTRATOR
	ret z
	call GetFutureSightUser
	jr c, .not_future_sight
	xor a
	ret

.not_future_sight
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
	call IsInByteArray
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

CheckUserMove:
; Return z if the user has move a.
	ld b, a
	ld de, wBattleMonMoves
	ldh a, [hBattleTurn]
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

BattleCommand_defrost:
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
	jmp StdBattleTextbox

BoostJumptable:
	dbw AVALANCHE,  DoAvalanche
	dbw ACROBATICS, DoAcrobatics
	dbw FACADE,     DoFacade
	dbw HEX,        DoHex
	dbw VENOSHOCK,  DoVenoshock
	dbw KNOCK_OFF,  DoKnockOff
	dbw PURSUIT,    DoPursuit
	dbw -1, -1

BattleCommand_conditionalboost:
	ld hl, BoostJumptable
	ld a, BATTLE_VARS_MOVE_ANIM
	call GetBattleVar
	jmp BattleJumptable

DoAvalanche:
	call CheckOpponentWentFirst
	jr DoubleDamageIfNZ

DoAcrobatics:
	ldh a, [hBattleTurn]
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

DoPursuit:
	ld a, [wDeferredSwitch]
	and a
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

CheckAnyOtherAliveMons:
; These return nz if any is alive
	ldh a, [hBattleTurn]
	and a
	jr nz, CheckAnyOtherAliveEnemyMons
	; fallthrough
CheckAnyOtherAlivePartyMons:
	ld hl, wPartyMon1HP
	ld de, wCurPartyMon
	ld a, [wPartyCount]
	jr DoCheckAnyOtherAliveMons

CheckAnyOtherAliveOpponentMons:
	ldh a, [hBattleTurn]
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

BattleCommand_doubleminimizedamage:
	ld a, BATTLE_VARS_SUBSTATUS2_OPP
	call GetBattleVarAddr
	bit SUBSTATUS_MINIMIZED, a
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

GetFutureSightUser::
; Returns:
; c|z: Regular user in a (Future Sight not involved)
; nc|z: Active user in a (Future Sight applying)
; nc|nz: External user in a (or active fainted), future sight applying.
	push hl
	push de
	push bc
	ldh a, [hBattleTurn]
	and a
	ld hl, wPlayerFutureSightCount
	ld bc, wCurBattleMon
	jr z, .got_future
	ld hl, wEnemyFutureSightCount
	ld bc, wCurOTMon
.got_future
	ld a, [hl]
	and a
	jr z, .future_sight_offline
	and $f
	jr nz, .future_sight_offline
	ld a, [hl]
	swap a
	dec a
	and $f
	ld d, a
	ld a, [bc]
	cp d
	ld a, d
	pop bc
	pop de
	pop hl
	scf
	ccf
	ret nz

	; If user is fainted, treat as non-active
	push af
	push hl
	call HasUserFainted
	pop hl
	jr z, .active_fainted
	pop af
	ret

.active_fainted
	pop af
	and a
	ret nz
	rrca
	ret

.future_sight_offline
	xor a
	ld a, [bc]
	pop bc
	pop de
	pop hl
	scf
	ret

_GetTrueUserAbility::
; Returns current user's ability, or 0 (no ability) for external future sight user
; Also returns 0 (no ability) if opponent has Neutralizing Gas and user doesn't
	call GetFutureSightUser
	jr nz, .external

	ld a, BATTLE_VARS_ABILITY
	call GetBattleVar
	push bc
	ld b, a
	call GetOpponentAbility
	cp b
	jr z, .same_ability
	cp NEUTRALIZING_GAS
	ld a, b
	pop bc
	ret nz
.external
	xor a ; ld a, NO_ABILITY
	ret
.same_ability
	pop bc
	ret

CheckHiddenOpponent:
	ld a, BATTLE_VARS_SUBSTATUS3_OPP
	call GetBattleVar
	and 1 << SUBSTATUS_FLYING | 1 << SUBSTATUS_UNDERGROUND
	ret

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
	call GetFutureSightUser
	jr z, .not_external

	; External users may not use their items
	xor a
	jr .got_item
.not_external
	ld hl, wBattleMonItem
	ldh a, [hBattleTurn]
	and a
	jr z, .go
	ld hl, wEnemyMonItem
.go
	ld a, [hl]
.got_item
	ld [wCurItem], a
	ld b, a
	jr GetItemHeldEffect

GetOpponentItemAfterUnnerve:
	call CallOpponentTurn
GetUserItemAfterUnnerve::
; Returns the effect of the user's item in bc, and its id at hl,
; unless it's a Berry and Unnerve is in effect.
	call GetUserItem
	call GetOpponentAbility
	cp UNNERVE
	ret nz
	ld a, [hl]
	push de
	push hl
	ld hl, EdibleBerries
	call IsInByteArray
	pop hl
	pop de
	ret c
	ld hl, NoItem
	ld b, HELD_NONE
	ret

NoItem:
	db NO_ITEM

GetItemHeldEffect:
; Return the effect of item b in b and the param in c.
	ld a, b
	and a
	ret z

	push hl
	ld hl, ItemAttributes + ITEMATTR_EFFECT
	dec a
	ld c, a
	ld b, 0
	ld a, ITEMATTR_STRUCT_LENGTH
	rst AddNTimes
	ld a, BANK(ItemAttributes)
	call GetFarWord
	ld b, l
	ld c, h
	pop hl
	ret

TryAnimateCurrentMove:
	call CheckAlreadyExecuted
	ret nz
	; fallthrough
AnimateCurrentMove:
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
	jmp PopBCDEHL

PlayDamageAnim:
	xor a
	ld [wFXAnimIDHi], a

	ld a, BATTLE_VARS_MOVE_ANIM
	call GetBattleVar
	and a
	ret z

	ld [wFXAnimIDLo], a

	ldh a, [hBattleTurn]
	and a
	ld a, BATTLEANIM_ENEMY_DAMAGE
	jr z, .player
	ld a, BATTLEANIM_PLAYER_DAMAGE

.player
	ld [wNumHits], a

	jr PlayUserBattleAnim

LoadMoveAnim:
	xor a
	ld [wNumHits], a
	ld [wFXAnimIDHi], a

	ld a, BATTLE_VARS_MOVE_ANIM
	call GetBattleVar
	and a
	ret z

	; fallthrough

LoadAnim:
	ld [wFXAnimIDLo], a
	jr PlayUserBattleAnim

PlayOpponentBattleAnim:
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
	jmp PopBCDEHL

CallBattleCore:
	ld a, BANK(BattleCore)
	jmp FarCall_hl

ShowPotentialAbilityActivation:
; This avoids duplicating checks to avoid text spam. This will run
; ShowAbilityActivation if animations are disabled (something only abilities do)
	ld a, [wAnimationsDisabled]
	and a
	ret z
	push hl
	ld h, a
	ldh a, [hBattleTurn]
	inc a
	rrca
	rrca
	and h
	pop hl
	ret nz
	farcall ShowAbilityActivation
	ldh a, [hBattleTurn]
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

AnimateFailedMove:
	ld a, [wAnimationsDisabled]
	and a
	ret nz
	call BattleCommand_lowersub
	call BattleCommand_movedelay
	jmp BattleCommand_raisesub

BattleCommand_movedelay:
; Wait 30 frames.
	ld c, 30
	jmp DelayFrames

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
	ld hl, wBattleScriptBufferLoc
	ld a, [hli]
	ld h, [hl]
	ld l, a
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

AppearUserLowerSub:
	farjp _AppearUserLowerSub

AppearUserRaiseSub:
	farjp _AppearUserRaiseSub

_CheckBattleEffects:
; Checks the options. Returns carry if battle animations are disabled.
	push hl
	push de
	push bc
	call CheckBattleEffects
	jmp PopBCDEHL

CheckBattleEffects:
; Return carry if battle scene is turned off.
	ld a, [wOptions1]
	bit BATTLE_EFFECTS, a
	jr z, .off
	and a
	ret
.off
	scf
	ret
