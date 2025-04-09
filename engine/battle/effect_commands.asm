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
	ld [wBattleAnimParam], a
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
	and SLP_MASK
	jr z, .not_asleep

	; Early Bird decreases the sleep timer twice as fast (including Rest).
	call GetTrueUserAbility
	sub EARLY_BIRD
	jr nz, .no_early_bird
	dec [hl]
	jr z, .woke_up
.no_early_bird
	dec [hl]
	jr z, .woke_up

	; Still asleep.
	xor a
	ld [wNumHits], a
	ld de, ANIM_SLP
	call FarPlayBattleAnimation
	jr .fast_asleep

.woke_up
	; if user has Early Bird, display ability activation
	; a is still (user's ability - EARLY_BIRD)
	and a
	jr nz, .woke_up_no_early_bird
	farcall BeginAbility
	farcall ShowAbilityActivation
.woke_up_no_early_bird
	ld hl, WokeUpText
	call StdBattleTextbox
	; does nothing in case we never showed an ability activation
	farcall EndAbility
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
	call VerifyChosenMove
	jr nz, .not_disabled

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

CantMove:
	; Reset Destiny Bond state.
	ld a, BATTLE_VARS_SUBSTATUS2
	call GetBattleVarAddr
	res SUBSTATUS_DESTINY_BOND, [hl]

	call .cancel_fly_dig
	call CheckRampageStatusAndGetRolloutCount ; hl becomes pointer to user substatus3
	jr z, .rampage_done
	ld a, [de]
	dec a
	push hl
	call z, HandleRampage_ConfuseUser ; confuses user on last turn of rampage
	pop hl
.rampage_done
	ld a, ~(1 << SUBSTATUS_RAMPAGE | 1 << SUBSTATUS_CHARGED | 1 << SUBSTATUS_FLYING | 1 << SUBSTATUS_UNDERGROUND | 1 << SUBSTATUS_ROLLOUT)
	and [hl]
	ld [hl], a
	ret

.cancel_fly_dig
	ld a, BATTLE_VARS_MOVE_ANIM
	call GetBattleVarAddr
	cp FLY
	jr z, .fly_dig
	cp DIG
	ret nz
.fly_dig
	jmp AppearUserRaiseSub

VerifyChosenMove:
; Returns z if the used move is the move we selected in the move screen.
; Used to avoid problems caused by Struggle or similar.
	ldh a, [hBattleTurn]
	and a
	ld a, [wCurMoveNum]
	ld de, wPlayerMoveStructAnimation
	ld hl, wBattleMonMoves
	jr z, .got_move
	ld a, [wCurEnemyMoveNum]
	ld de, wEnemyMoveStructAnimation
	ld hl, wEnemyMonMoves
.got_move
	ld c, a
	ld b, 0
	add hl, bc
	ld a, [de]
	cp [hl]
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

CheckOpponentAffection:
	call StackCallOpponentTurn
CheckAffection:
; Returns an Affection level between 0-3.
; If affection level is 0, also return z.
	; Affection has to be enabled.
	ld a, [wInitialOptions]
	bit AFFECTION_OPT, a
	jr z, .no_affection

	; Affection doesn't function in Link or Battle Tower battles.
	ld a, [wLinkMode]
	and a
	jr nz, .no_affection
	ld a, [wInBattleTowerBattle]
	and a
	jr z, .cont
.no_affection
	xor a
	ret

.cont
	push hl
	push bc
	ld b, 3

	; Convert current friendship value to Affection thresholds.
	ld a, MON_HAPPINESS
	call TrueUserPartyAttr

	ld hl, .AffectionThresholds
.loop
	cp [hl]
	jr nc, .done
	inc hl
	dec b
	jr .loop
.done
	ld a, b
	and a
	pop bc
	pop hl
	ret

.AffectionThresholds:
	db 255
	db 220
	db 180
	db 0

OpponentAffectionText:
	call StackCallOpponentTurn
AffectionText:
; Prints battle text and displays an affection animation.
	; If it's the enemy's turn, text is in de.
	ldh a, [hBattleTurn]
	and a
	jr z, _AffectionText
	ld h, d
	ld l, e
_AffectionText:
	call StdBattleTextbox
	xor a
	ld [wNumHits], a
	ld de, ANIM_AFFECTION
	farjp PlayBattleAnimDE_OnlyIfVisible

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
	call GenericHitAnim

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
	and SLP_MASK
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
	and SLP_MASK
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

	call BattleCommand_movedelay
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
	ld a, [wCurBattleMon]
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

	predef GetUserItemAfterUnnerve
	ld c, 0
	ld a, [hl]
	cp LUCKY_PUNCH
	jr z, .crit_item
	cp LEEK
	jr nz, .FocusEnergy
.crit_item
	call UserValidBattleItem
	jr nz, .FocusEnergy
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
	ld b, [hl]

	; Sufficient Affection doubles critrate, independently of stages.
	call CheckAffection
	cp 3
	jr c, .no_affection_boost
	sla b
.no_affection_boost
	ld a, 24
	call BattleRandomRange

	cp b
	ret nc
.guranteed_crit
	ld a, TRUE
	ld [wCriticalHit], a
	ret

TrueUserValidBattleItem:
; Items (and Abilities) never apply to external Future Sight users.
	call GetFutureSightUser
	ret nz
	jr UserValidBattleItem

OpponentValidBattleItem:
	call StackCallOpponentTurn
UserValidBattleItem:
; Checks if the user's held item applies to the species+form.
; Used for items like Leek, Lucky Punch, Thick Club, etc.
; Returns z if the item is valid.
	push hl
	push de
	push bc

	; Get item, species and form data.
	ld hl, wBattleMonItem
	call GetUserMonAttr
	ld a, [hl]
	ld de, wBattleMonSpecies - wBattleMonItem
	add hl, de
	ld c, [hl]
	ld de, wBattleMonForm - wBattleMonSpecies
	add hl, de
	ld b, [hl]
	ld d, a
	ld hl, .ValidBattleItemTable

.loop
	; Check if we reached the end of the table.
	ld a, [hli]
	inc a
	jr z, .failed

	; Does the item match the held one?
	dec a
	cp d
	ld a, [hli]
	jr nz, .next

	; Does the item apply to the species?
	cp c
	jr nz, .next

	; Check exact species+form.
	ld a, [hl]
	call CompareSpeciesForm
	jr z, .matched
.next
	inc hl
	jr .loop
.matched
	xor a
	jr .done
.failed
	or 1
.done
	jmp PopBCDEHL

MACRO species_battle_item
	db \1
	shift
	dp \#
ENDM

.ValidBattleItemTable:
	species_battle_item LIGHT_BALL, PIKACHU
	species_battle_item LEEK, FARFETCH_D
	species_battle_item LEEK, SIRFETCH_D
	species_battle_item LUCKY_PUNCH, CHANSEY
	species_battle_item QUICK_POWDER, DITTO
	species_battle_item THICK_CLUB, CUBONE
	species_battle_item THICK_CLUB, MAROWAK
	db -1

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
	add a
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
	farcall Multiply

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
	farcall Divide

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

	; Check Iron Ball
	push bc
	predef GetUserItemAfterUnnerve
	ld a, b
	pop bc
	pop de
	ld c, a
	sub HELD_IRON_BALL
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
	ld a, [hli]
	ld c, [hl]
	ld b, a
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
	jr z, .end
	cp MINDS_EYE
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
	add a
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

INCLUDE "data/moves/powder_moves.asm"

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
	farcall Multiply

	; ...divide by 100%...
	ld a, 100
	ldh [hDivisor], a
	ld b, $4
	farcall Divide

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

	; Affection-based evasion
	call CheckOpponentAffection
	cp 3
	jr c, .no_affection_evasion

	ld a, 10
	call BattleRandomRange
	and a
	ld a, ATKFAIL_AFFECTION
	jmp z, .Miss_skipset

.no_affection_evasion
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
	jr z, .avoid_evasion_boost
	cp ILLUMINATE
	jr z, .avoid_evasion_boost
	cp MINDS_EYE
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
	and SLP_MASK
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

BattleCommand_checkpriority:
; Checks for abilities and conditions that would block priority moves from occuring
	call HasOpponentFainted
	ret z
	farcall GetMovePriority
	cp $81
	jr c, .check_prankster
	; Armor Tail blocks moves with priority > 0 (so does not block moves like Prankster Roar)
	call GetOpponentAbilityAfterMoldBreaker
	cp ARMOR_TAIL
	ld b, ATKFAIL_ABILITY
	jr z, .attack_fails
	; Dark-type are immune to (most) Prankster-boosted moves that could affect it
.check_prankster
	call GetTrueUserAbility
	cp PRANKSTER
	jr z, .prankster
	call GetOpponentAbilityAfterMoldBreaker
	cp SOUNDPROOF
	ret nz

	; Soundproof vs status moves is handled here.
	ld a, BATTLE_VARS_MOVE_ANIM
	call GetBattleVar
	ld hl, SoundMoves
	call IsInByteArray
	ld b, ATKFAIL_ABILITY
	jr c, .attack_fails
	ret

.prankster
	ld a, BATTLE_VARS_MOVE_CATEGORY
	call GetBattleVar
	cp STATUS
	ret nz
	call CheckIfTargetIsDarkType
	ret nz
	ld b, ATKFAIL_IMMUNE
.attack_fails
	xor a
	ld [wTypeMatchup], a
	ld [wTypeModifier], a
	ld hl, wAttackMissed
	or [hl]
	jmp nz, BattleCommand_failuretext
	ld [hl], b
	jmp BattleCommand_failuretext

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
	call GetOpponentItemAfterUnnerve
	ld a, b
	cp HELD_COVERT_CLOAK
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
	jr c, EffectChanceEnd ; The effect byte overflowed, so guarantee it

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
	ld [wBattleAnimParam], a
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
	cp STATUS
	jr z, .movestate_done
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

.movestate_done
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
	cp EFFECT_CONVERSION
	jr z, .conversion
	cp EFFECT_DOUBLE_HIT
	jr z, .doublehit

.normal_move
	xor a
	ld [wBattleAnimParam], a
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
	ld a, [wBattleAnimParam]
	and 1
	xor 1
	ld [wBattleAnimParam], a
	ld a, [de]
	dec a
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


StatUpDownAnim:
	ld a, [wInAbility]
	and a
	ret nz
	call _CheckBattleEffects
	ret c

	call CheckAlreadyExecuted
	ret nz

	xor a
	ld [wNumHits], a
	ld [wBattleAnimParam], a

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
	ld [wBattleAnimParam], a
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
; 5 - High Affection
	ld a, BATTLE_VARS_SUBSTATUS1_OPP
	call GetBattleVar
	bit SUBSTATUS_ENDURE, a
	jr z, .not_enduring
	ld b, $1
	jr .enduring

.not_enduring
	call CheckOpponentAffection
	jr z, .cont

	; chance to endure: AffLevel * 5 + 5
	inc a
	ld b, a
	ld a, 20
	call BattleRandomRange
	cp b
	ld b, $5
	jr c, .enduring

.cont
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

	cp 5
	ld hl, PlayerAffectionEndureText
	ld de, EnemyAffectionEndureText
	jmp z, OpponentAffectionText

	dec a
	jr nz, .not_enduring2
	ld hl, EnduredText
	jmp StdBattleTextbox

.not_enduring2
	dec a
	jr nz, .enduring_with_item
	farcall BeginAbility
	farcall ShowEnemyAbilityActivation
	ld hl, EnduredText
	call StdBattleTextbox
	farjp EndAbility

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
	ld [wBattleAnimParam], a
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
	dec a
	jr nz, .no_affection_evasion
	push de
	ld hl, PlayerAffectionEvasionText
	ld de, EnemyAffectionEvasionText
	call OpponentAffectionText
	pop de

	; Still counts as a miss in general.
	jr .cont_atkmiss

.no_affection_evasion
	ld hl, AttackMissedText
	call StdBattleTextbox
.cont_atkmiss
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

	; At level 3 affection, critical hit chance is doubled.
	; Thus, if this applies, show the relevant msg 50% of the
	; time in place of the regular one.
	call CheckAffection
	cp 3
	jr c, .no_affection_boost
	call BattleRandom
	add a
	jr c, .no_affection_boost
	ld hl, AffectionCriticalText
	call _AffectionText
	jr .crit_text_done

.no_affection_boost
	ld hl, CriticalHitText
	call StdBattleTextbox

.crit_text_done
	; Add 1 to the critical hit count if it's the player's turn
	ld a, [wLinkMode]
	and a
	jr nz, .cont
	ld a, [wInBattleTowerBattle]
	and a
	jr nz, .cont
	ldh a, [hBattleTurn]
	and a
	jr nz, .cont
	ld hl, wCriticalCount
	ld a, [wCurBattleMon]
	ld c, a
	ld b, 0
	add hl, bc
	inc [hl]
	ld a, [hl]
	cp 3
	jr c, .cont
	ld b, SET_FLAG
	ld hl, wEvolvableFlags
	predef FlagPredef ; c still contains wCurBatlteMon

.cont
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
	push hl
	predef GetUserItemAfterUnnerve
	pop hl
	ld a, b
	cp HELD_LOADED_DICE
	jr nz, .not_loaded_dice
	call BattleRandom
	and 1
	add 4
	jr .got_count

.not_loaded_dice
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
	ld b, 0
	push bc
	ld a, STAT_SKIPTEXT
	ld b, $10 | ATTACK
	call _RaiseStat
	ld a, [wFailedMessage]
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

ConsumeStolenOpponentItem::
; Separate function, since used items/cud chew berry shouldn't (necessarily)
; be updated when force-eating a berry via Bug Bite
	call StackCallOpponentTurn
.Function:
	call GetConsumedItemVars
	jr _ConsumeUserItem

ConsumeOpponentItem::
	call StackCallOpponentTurn
ConsumeUserItem::
	call GetConsumedItemVars
	; Air Balloons are consumed permanently, so don't write it to UsedItems
	ld a, [de]
	ld [wCurItem], a
	cp AIR_BALLOON
	jr z, _ConsumeUserItem
	push hl
	push af
	call GetUsedItemAddr
	pop af
	ld [hl], a
	pop hl
	call SetCudChewBerry

_ConsumeUserItem::
	xor a
	ld [de], a

	ld a, [hl]
	ld d, a
	ld [wCurItem], a
	xor a
	ld [hl], a
	ldh a, [hBattleTurn]
	and a
	jr nz, .apply_unburden

	; For players, maybe remove the backup item too if we're dealing with a berry
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

GetConsumedItemVars::
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
	jmp GetPartyLocation

SetCudChewBerry::
; Uses item in wCurItem to set user's cud chew Berry, if applicable
	call GetTrueUserAbility
	cp CUD_CHEW
	ret nz
	farcall CheckItemPocket
	cp BERRIES
	ret nz
	push hl
	ld a, BATTLE_VARS_CUD_CHEW_BERRY
	call GetBattleVarAddr
	ld a, [wCurItem]
	add $80 - FIRST_BERRY + 1 ; 1-index berries from $01-$7f, with bit 7 set as the timer
	ld [hl], a
	pop hl
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
	ld [wBattleAnimParam], a
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
	call GetFutureSightUser
	jr nc, .rocky_helmet_done

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
	call CheckThroatSpray

	; Only check white herb if we didn't do damage
	ld a, [wDamageTaken]
	ld b, a
	ld a, [wDamageTaken + 1]
	or b
	call nz, EndMoveDamageChecks
	; fallthrough
CheckStatHerbs:
	ldh a, [hBattleTurn]
	ld b, a
	push bc
	call CheckWhiteHerbEjectPack
	call CheckMirrorHerb
	pop bc
	ld a, b
	ldh [hBattleTurn], a
	ret

CheckThroatSpray:
	ld a, [wBattleEnded]
	and a
	ret nz

	ld a, [wAttackMissed]
	and a
	ret nz

	call HasUserFainted
	ret z

	predef GetUserItemAfterUnnerve
	ld a, b
	cp HELD_THROAT_SPRAY
	ret nz

	push bc
	call GetCurItemName
	ld a, BATTLE_VARS_MOVE_ANIM
	call GetBattleVar
	ld hl, SoundMoves
	call IsInByteArray
	pop bc
	ret nc

	ld b, c
	jmp RaiseStatWithItem

CheckWhiteHerbEjectPack:
; Preserve b, which holds true player's turn (to handle Eject Pack switches).
	push bc
	call SetFastestTurn
	pop bc
	push bc
	call .do_it
	pop bc
	call SwitchTurn

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

CheckMirrorHerb:
; Preserves whose turn it is (so we can call this without worrying about that).
	call HasUserFainted
	call nz, HasOpponentFainted
	ret z

	ldh a, [hBattleTurn]
	push af
	call SetFastestTurn
	call .do_it
	call SwitchTurn
	call .do_it
	pop af
	ldh [hBattleTurn], a
	ret

.do_it
	; Go through the entire pending stat change table no matter what,
	; because even if we're not holding Mirror Herb, we need to reset them.
	ld hl, wMirrorHerbPendingBoosts

	xor a
	ld [wAlreadyExecuted], a

	; Set up fields to bitmask against.
	ldh a, [hBattleTurn]
	and a
	lb bc, $0f, $f0
	jr z, .loop
	lb bc, $f0, $0f
.loop
	ld a, [hl]

	; Does the user have a pending mirror herb change?
	and b
	jr z, .next

	; Found stat pending change. Store in d.
	ld d, a

	; d should always hold the change in the high nibble, even for foes.
	ldh a, [hBattleTurn]
	and a
	jr nz, .stat_amount_ok
	swap d

.stat_amount_ok
	; Store adjustment to the relevant pending boost field. Do this now
	; because the Mirror Herb stat change can induce changes to this field,
	; which we want to undo (Mirror Herb cannot trigger foe's Mirror Herb).
	ld a, [hl]
	and c
	ld e, a

	; Now, assuming the user is actually holding a Mirror Herb, proc the effect.
	push bc
	push hl
	push de
	predef GetUserItemAfterUnnerve
	ld a, b
	cp HELD_MIRROR_HERB
	jr nz, .stat_raise_failed
	pop de
	pop hl

	; This will give us a value between 0-6 pointing to the relevant stat.
	ld a, l
	sub LOW(wMirrorHerbPendingBoosts)
	add d
	sub $10 ; amount of stat increments is given as high nibble - $10.
	ld b, a
	ld a, STAT_SKIPTEXT
	push hl
	push de
	call _RaiseStat
	ld a, [wFailedMessage]
	and a
	jr nz, .stat_raise_failed
	farcall UseStatItemText
.stat_raise_failed
	pop de
	pop hl
	pop bc
	ld [hl], e
.next
	inc hl
	ld a, l
	cp LOW(wMirrorHerbPendingBoosts + NUM_LEVEL_STATS - 1)
	jr nz, .loop

	call CheckAlreadyExecuted
	call nz, ConsumeUserItem
	xor a
	ld [wAlreadyExecuted], a
	ret

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
	farcall BeginAbility
	farcall ShowAbilityActivation
	call BattleCommand_thief
	farcall EndAbility
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
	cp HELD_SWITCH
.deferred_switch
	ret nz
	call GetFutureSightUser
	ret nc
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
	call GetFutureSightUser
	ret nc
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
	farcall Divide
	ldh a, [hQuotient + 1]
	ld b, a
	ldh a, [hQuotient + 2]
	ld c, a
	predef SubtractHPFromUser
	ld hl, BattleText_UserLostSomeOfItsHP
	jmp StdBattleTextbox

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

RaiseOpponentStatWithItem:
	call StackCallOpponentTurn
RaiseStatWithItem:
	ld a, STAT_SKIPTEXT
	call _RaiseStat
	ld a, [wFailedMessage]
	and a
	ret nz
	farcall UseStatItemText
	jmp ConsumeUserItem

DittoMetalPowder:
	assert !HIGH(DITTO)
if !DEF(FAITHFUL)
	; grabs true species -- works even if transformed to non-Ditto
	ld a, MON_FORM
	call OpponentPartyAttr
	and EXTSPECIES_MASK
	ret nz
	ld a, MON_SPECIES
	call OpponentPartyAttr
else
	; only works if current species is Ditto
	ld hl, wBattleMonForm
	call GetOpponentMonAttr
	ld a, [hl]
	and EXTSPECIES_MASK
	ret nz
	ld hl, wBattleMonSpecies
	call GetOpponentMonAttr
	ld a, [hl]
endc
	cp DITTO
	ret nz

	push bc
	call GetOpponentItem
	ld a, b
	cp HELD_METAL_POWDER
	pop bc
	ret nz
	jr SetDefenseBoost

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
	predef GetEvosAttacksPointer
	ld a, BANK(EvosAttacks)
	call GetFarByte
	inc a
	pop bc
	pop hl
	ret z

	push bc
	call GetOpponentItem
	ld a, [hl]
	cp EVIOLITE
	pop bc
	ret nz
	; fallthrough
SetDefenseBoost:
; Boosts defense in bc by x1.5. Assumes bc<43690
	ld h, b
	ld l, c
	srl b
	rr c
	add hl, bc
	ld b, h
	ld c, l
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

	call HailDefenseBoost
	call DittoMetalPowder
	call UnevolvedEviolite

	ld hl, wBattleMonAttack
	call GetUserMonAttr
	call GetFutureSightUser
	jr z, .atk_ok
	ld a, MON_ATK
	call TrueUserPartyAttr
.atk_ok
	call GetOpponentActiveScreens
	and SCREENS_REFLECT
	jr z, .thickcluborlightball
	sla c
	rl b
	jr .thickcluborlightball

.special
	ld a, BATTLE_VARS_MOVE_EFFECT
	call GetBattleVar
	cp EFFECT_PSYSTRIKE
	jr z, .psystrike

	ld hl, wBattleMonSpDef
	call GetOpponentMonAttr
	ld a, [hli]
	ld b, a
	ld c, [hl]

	call SandstormSpDefBoost
	call UnevolvedEviolite

	jr .lightscreen

.psystrike
	ld hl, wBattleMonDefense
	call GetOpponentMonAttr
	ld a, [hli]
	ld b, a
	ld c, [hl]

	call HailDefenseBoost
	call DittoMetalPowder
	call UnevolvedEviolite

.lightscreen
	ld hl, wBattleMonSpAtk
	call GetUserMonAttr
	call GetFutureSightUser
	jr z, .sat_ok
	ld a, MON_SAT
	call TrueUserPartyAttr
.sat_ok
	call GetOpponentActiveScreens
	and SCREENS_LIGHT_SCREEN
	jr z, .lightball
	sla c
	rl b

.lightball
; Note: Returns player special attack at hl in hl.
	ld a, [hli]
	ld l, [hl]
	ld h, a
	call LightBallBoost
	jr .done

.thickcluborlightball
; Note: Returns player attack at hl in hl.
	ld a, [hli]
	ld l, [hl]
	ld h, a
	call ThickClubOrLightBallBoost

.done
	call TruncateHL_BC

	ld a, MON_LEVEL
	push hl
	call TrueUserPartyAttr
	pop hl
	ld e, a
	ret

GetOpponentActiveScreens:
; Returns the opponent screens after Infiltrator, crits and Brick Break.
	; Brick Break screen breaking is handled later, so that we can avoid it
	; if the attack is ineffective. Thus, make it ignore screens here.
	ld a, BATTLE_VARS_MOVE_EFFECT
	call GetBattleVar
	xor EFFECT_BRICK_BREAK
	jr nz, .no_brick_break

	; Set move anim param to notify that we are breaking screens.
	call .GetScreen
	ld [wBattleAnimParam], a
	xor a
	ret

.no_brick_break
	call GetTrueUserAbility
	xor INFILTRATOR
	ret z

	ld a, [wCriticalHit]
	dec a ; cp TRUE
	ret z
	; fallthrough
.GetScreen:
	ldh a, [hBattleTurn]
	and a
	ld a, [wEnemyScreens]
	ret z
	ld a, [wPlayerScreens]
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
; If the attacking monster is Cubone or Marowak and
; it's holding a Thick Club, or if it's Pikachu and
; it's holding a Light Ball, double it.
	ld a, THICK_CLUB
	call CheckAttackItemBoost
	; fallthrough
LightBallBoost:
	ld a, LIGHT_BALL
	; fallthrough
CheckAttackItemBoost:
	push bc
	push de
	push hl
	ld b, a
	ld a, MON_ITEM
	call TrueUserPartyAttr
	cp b
	pop hl
	call z, TrueUserValidBattleItem
	pop de
	pop bc
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
	ret nz
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
	ld hl, wBattleMonLevel
	call GetUserMonAttr
	; e = Level
	ld e, [hl]
	ld bc, wBattleMonDefense + 1 - wBattleMonLevel
	assert wBattleMonDefense - 2 == wBattleMonAttack
	add hl, bc
	; bc = Defense
	ld a, [hld]
	ld c, a
	ld a, [hld]
	ld b, a
	; hl = Attack
	ld a, [hld]
	ld h, [hl]
	ld l, a
	call TruncateHL_BC
	ld d, 40
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
	sub b ; between $23 (6, i.e. -1 stat change) and $28 (1, i.e. -6 stat change)
	ret
.higher
	ln a, 1, 11
	add b ; between $23 (8, i.e. +1 stat change) and $28 (13, i.e. +6 stat change)
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
	ln a, 1, 2 ; 1/2 = 50%
	call nz, ApplyPhysicalAttackDamageMod

.burn_done
	; Flash Fire
	call GetFutureSightUser
	jr nz, .no_flash_fire
	ld a, BATTLE_VARS_SUBSTATUS1
	call GetBattleVar
	bit SUBSTATUS_FLASH_FIRE, a
	jr z, .no_flash_fire
	call GetOpponentAbility
	cp NEUTRALIZING_GAS
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
	cp HELD_PUNCHING_GLOVE
	jr z, .punching_glove

	cp HELD_LIFE_ORB
	ln a, 13, 10 ; x1.3
	jr z, .life_orb
	jr .done_attacker_item
.type_boost
	ld a, BATTLE_VARS_MOVE_TYPE
	call GetBattleVar
	cp c
	ln a, 6, 5 ; x1.2
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
.punching_glove
	farcall IsPunchingMove
	ln a, 11, 10 ; x1.1
	call z, MultiplyAndDivide
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
	ln a, 2, 3 ; 2/3 = 67%
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
	farcall Divide
	pop bc

	; + 2
	inc [hl]
	inc [hl]
	ret

DamagePass2:
	; * bp
	ld hl, hMultiplier
	ld [hl], d
	farcall Multiply

	; * Attack
	ld [hl], b
	farjp Multiply

DamagePass3:
	; / Defense
	ld hl, hMultiplier
	ld [hl], c
	ld b, $4
	farcall Divide

	; / 50
	ld [hl], 50
	ld b, $4
	farjp Divide

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
	sub EFFECT_LEVEL_DAMAGE
	ld b, [hl]
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
	cp b
	jr nz, .got_power
	inc b
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
	farcall Multiply
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
	farcall Divide
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

	farjp PlayBattleAnim

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
	predef SubtractHPFromUser
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
	ld a, 0 ; no-optimize a = 0 (1 cycle faster than `ld [hl], 0 / inc hl`)
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
	jr PostStatus

.failed_ineffective
	call AnimateFailedMove
	jmp FailText_CheckOpponentProtect

.failed
	push hl
	call AnimateFailedMove
	pop hl
	jmp StdBattleTextbox

.ability_ok
	farcall BeginAbility
	farcall ShowEnemyAbilityActivation
	call AnimateFailedMove
	call PrintDoesntAffect
	farjp EndAbility

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
	ld h, SLP_MASK
	jr CanStatusTarget
CanFreezeTarget:
	; Harsh sunlight prevents freeze.
	call GetWeatherAfterOpponentUmbrella
	cp WEATHER_SUN
	ret z
	ld a, b
	lb bc, ICE, ICE
	lb de, MAGMA_ARMOR, HELD_PREVENT_FREEZE
	ld h, 1 << FRZ
CanStatusTarget:
; Input:
; a=0: Check Mold Breaker and Substitute (user directly poisoning foe)
; a=1: Ignore MB and sub (Toxic Spikes, target on-contact abilities)
; a=2: Ignore MB, sub, and Safeguard, check victim for Corrosion (Toxic Orb)
; bc: Type immunities
; d: Ability immunity
; e: Item immunity
; h: Status
; Returns:
;     z -- we can
;  c|nz -- we can't, due to ability
; nc|nz -- we can't, failure msg in HL
	and a
	push af
	ld a, BATTLE_VARS_STATUS_OPP
	call GetBattleVar
	and h
	jmp nz, .already_statused

	; Corrosion bypasses everything except existing status problems
	ld a, h
	cp 1 << PSN
	jr nz, .not_corrosive

	pop af
	push af
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

	; Toxic/Flame Orb bypasses Safeguard.
	pop af
	push af
	cp 2
	jr z, .no_safeguard
	call SafeCheckSafeguard
	ld hl, SafeguardProtectText
	jr nz, .pop_and_end

.no_safeguard
	pop af ; "and a" was performed earlier.
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
	; return nc|nz -- we can't, failure msg in HL
	or 1
	ret
.cant_ability
	; return c|nz -- we can't, due to ability
	scf
	sbc a
	ret

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
	cp DRAINING_KISS
	jr nz, .skip_draining_kiss
	ld h, b
	ld l, c
	srl b
	rr c
	add hl, bc
	ld b, h
	ld c, l

.skip_draining_kiss
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
	farcall BeginAbility
	farcall ShowEnemyAbilityActivation
	predef SubtractHPFromUser
	ld hl, SuckedUpOozeText
	call StdBattleTextbox
	farjp EndAbility

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
	ld a, b
	ld [hli], a
	ld [hl], c
	ld hl, hMultiplier
	ld [hl], 13
	farcall Multiply
	ld [hl], 10
	ld b, 4
	farcall Divide
	ldh a, [hQuotient + 1]
	ld b, a
	ldh a, [hQuotient + 2]
	ld c, a
	ret

BattleCommand_burntarget:
	; Needs to be checked here too, because it should prevent defrosting
	call CheckSubstituteOpp
	ret nz
	ld a, BATTLE_VARS_STATUS_OPP
	call GetBattleVarAddr ; Addr to set hl for Defrost benefit
	and a
	jr nz, Defrost
	ld b, a ; a == 0
	call CanBurnTarget
	ret nz
	ld b, 1 << BRN
	jr StatusTarget
BattleCommand_poisontarget:
	ld b, 0
	call CanPoisonTarget
	ret nz
	ld b, 1 << PSN
	jr StatusTarget
BattleCommand_paralyzetarget:
	ld b, 0
	call CanParalyzeTarget
	ret nz
	ld b, 1 << PAR
	jr StatusTarget
BattleCommand_freezetarget:
	ld b, 0
	call CanFreezeTarget
	ret nz
	ld b, 1 << FRZ
	; fallthrough
StatusTarget:
	ld a, [wTypeModifier]
	and a
	ret z
	ld a, [wEffectFailed]
	and a
	ret nz
	; fallthrough
DisplayAndSetStatusProblem:
	xor a
	ld [wBattleAnimParam], a
	ld a, BATTLE_VARS_STATUS_OPP
	call GetBattleVarAddr
	ld [hl], b
	call UpdateOpponentInParty
	call DisplayStatusProblem
	call RefreshBattleHuds
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
	ld a, [wCurBattleMon]
	ld hl, wPartyMon1Status
.ok

	call GetPartyLocation
	xor a
	ld [hl], a
	call UpdateOpponentInParty

	ld hl, DefrostedOpponentText
	jmp StdBattleTextbox

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
	or STAT_CANMISS | STAT_SILENT
	jr ChangeStat

BattleCommand_lowerstat:
	ld b, -1
LowerStat:
	xor a
_LowerStat:
	or STAT_LOWER | STAT_CANMISS | STAT_SILENT
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
	or STAT_CANMISS | STAT_SECONDARY | STAT_SILENT
	jr ChangeStat

BattleCommand_lowerstathit:
	ld b, -1
LowerStatHit:
	xor a
_LowerStatHit:
	or STAT_LOWER | STAT_CANMISS | STAT_SECONDARY | STAT_SILENT
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
	or STAT_TARGET | STAT_CANMISS
	jr ChangeStat

BattleCommand_loweroppstat:
	ld b, -1
LowerOppStat:
	xor a
_LowerOppStat:
	or STAT_TARGET | STAT_LOWER | STAT_CANMISS
	jr ChangeStat

BattleCommand_raiseoppstathit:
	ld b, -1
RaiseOppStatHit:
	xor a
_RaiseOppStatHit:
	or STAT_TARGET | STAT_CANMISS | STAT_SECONDARY | STAT_SILENT
	jr ChangeStat

BattleCommand_loweroppstathit:
	ld b, -1
LowerOppStatHit:
	xor a
_LowerOppStatHit:
	or STAT_TARGET | STAT_LOWER | STAT_CANMISS | STAT_SECONDARY | STAT_SILENT
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
	farcall ShowPotentialAbilityActivation
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

MACRO status_problem
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
	status_problem SLP_MASK, ANIM_SLP, FellAsleepText

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
	farcall BeginAbility
	farcall ShowEnemyAbilityActivation
	ld hl, DoesntAffectText
.failed
	push hl
	call AnimateFailedMove
	pop hl
	call StdBattleTextbox
	farcall EndAbility
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
	and SLP_MASK
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
	call StackCallOpponentTurn
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
	call StackCallOpponentTurn
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
	and BATTLERESULT_BITMASK
	or DRAW
	ld [wBattleResult], a
	ret

BattleCommand_switchout:
	call CheckAnyOtherAliveMons
	ret z
	ld a, 1 << SWITCH_DEFERRED | 1 << SWITCH_PURSUIT
	; fallthrough
SetDeferredSwitch:
	push hl
	ld hl, wDeferredSwitch
	inc [hl]
	dec [hl]
	jr nz, .done
	ld [hl], a
.done
	pop hl
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
	and 1 << FRZ | SLP_MASK
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

HasOpponentDamagedUs:
; Check if the opponent has damaged us for the given category bits in a
; this turn. Returns nz if they have.
	push bc
	ld b, a
	ldh a, [hBattleTurn]
	and a
	ld a, b
	pop bc
	jr nz, .got_cat_opp_side
	swap a
.got_cat_opp_side
	ld hl, wMoveState
	and [hl]
	ret z
	; fallthrough
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
	ld a, BATTLE_VARS_STATUS
	call GetBattleVar
	and SLP_MASK
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
	ld [wBattleAnimParam], a
	call LoadMoveAnim
	ld a, BATTLE_VARS_MOVE_EFFECT
	call GetBattleVar
	cp EFFECT_FLY
	jr nz, .not_flying

.flying
	farcall DisappearUser
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
	farcall Divide
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
	farcall BeginAbility
	farcall ShowEnemyAbilityActivation
	ld hl, DoesntAffectText
	call StdBattleTextbox
	farjp EndAbility

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
	jr z, .hp_full
	ld a, BATTLE_VARS_MOVE_ANIM
	call GetBattleVar
	cp REST
	jr nz, .not_rest
	ld a, BATTLE_VARS_STATUS
	call GetBattleVar
	and SLP_MASK
	jr nz, BattleEffect_ButItFailed
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
	call AnimateCurrentMove
	farcall RestoreHP
	call UpdateUserInParty
	call RefreshBattleHuds
	ld hl, RegainedHealthText
	jmp StdBattleTextbox

.ability_prevents_rest
	farcall BeginAbility
	farcall ShowAbilityActivation
	call AnimateFailedMove
	farjp EndAbility

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
	ld a, [wInAbility]
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
	ld a, 1 << PHYSICAL | 1 << SPECIAL
	call HasOpponentDamagedUs
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
	ld de, wCurBattleMon
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
	call StackCallOpponentTurn
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
	call StackCallOpponentTurn
GetUserItemAfterUnnerve::
; Returns the effect of the user's item in bc, and its id at hl,
; unless it's a Berry and Unnerve is in effect.
	call GetUserItem
	call GetOpponentAbility
	cp UNNERVE
	ret nz
	ld a, [hl]
	push bc
	push de
	push hl
	ld hl, EdibleBerries
	call IsInByteArray
	pop hl
	pop de
	pop bc
	ret nc
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
	ld a, [wInAbility]
	and a
	ret nz
	push hl
	push de
	push bc
	ld a, [wBattleAnimParam]
	push af
	call BattleCommand_lowersub
	pop af
	ld [wBattleAnimParam], a
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
	call StackCallOpponentTurn
PlayUserBattleAnim:
	push hl
	push de
	push bc
	farcall PlayBattleAnim
	jmp PopBCDEHL

CallBattleCore:
	ld a, BANK(BattleCore)
	jmp FarCall_hl

AnimateFailedMove:
	ld a, [wInAbility]
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

CheckBattleAnimSubstitution:
; Checks the animation ID and possibly change it based on species.
	assert !HIGH(NUM_ATTACKS), "This function is now obsolete."

	; Moves are 1-255.
	ld a, [wFXAnimIDHi]
	and a
	ret nz

	ld a, [wFXAnimIDLo]
	cp FRESH_SNACK
	ld de, ANIM_MILK_DRINK
	ld hl, .MilkDrinkUsers
	jr z, .check_species_list
	cp FURY_STRIKES
	ld de, ANIM_FURY_ATTACK
	ld hl, FuryAttackUsers
	jr z, .check_species_list
	cp DEFENSE_CURL
	ret nz

	; Defense Curl has 3 variations
	ld de, ANIM_WITHDRAW
	ld hl, WithdrawUsers
	call .check_species_list
	ld de, ANIM_HARDEN
	ld hl, HardenUsers
	; fallthrough
.check_species_list
	push hl
	ld hl, wBattleMonSpecies
	call GetUserMonAttr
	ld a, [hl]
	ld bc, wBattleMonForm - wBattleMonSpecies
	add hl, bc
	ld c, a
	ld b, [hl]
	pop hl
	call GetSpeciesAndFormIndexFromHL
	ret nc
	ld a, e
	ld [wFXAnimIDLo], a
	ld a, d
	ld [wFXAnimIDHi], a
	ret

.MilkDrinkUsers:
	dp MILTANK
	db 0

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
