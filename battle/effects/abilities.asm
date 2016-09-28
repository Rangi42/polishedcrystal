RunActivationAbilitiesInner:
	ld a, BATTLE_VARS_ABILITY
	call GetBattleVar
	; do Trace first in case it traces an activation ability,
	; that way we can run one of the others after the trace.
	cp TRACE
	call z, TraceAbility
	; reload the ability byte if it changed
	ld a, BATTLE_VARS_ABILITY
	call GetBattleVar
	cp TRACE
	jr nz, .continue
	ret ; the trace failed, so don't continue
.continue
	; Do Imposter second to allow Transformed abilities to activate
	cp IMPOSTER
	jp z, ImposterAbility
	cp DRIZZLE
	jp z, DrizzleAbility
	cp DROUGHT
	jp z, DroughtAbility
	cp SAND_STREAM
	jp z, SandStreamAbility
	cp CLOUD_NINE
	jp z, CloudNineAbility
	cp INTIMIDATE
	jp z, IntimidateAbility
	cp PRESSURE ; just prints a message
	jr nz, .skip_pressure
	ld hl, NotifyPressure
	call StdBattleTextBox
.skip_pressure
	cp DOWNLOAD
	jp z, DownloadAbility
	cp MOLD_BREAKER ; just prints a message
	jr nz, .skip_mold_breaker
	ld hl, NotifyMoldBreaker
	call StdBattleTextBox
.skip_mold_breaker
	cp ANTICIPATION
	jp z, AnticipationAbility
	cp FOREWARN
	jp z, ForewarnAbility
	cp FRISK
	jp z, FriskAbility
	cp UNNERVE ; just prints a message
	jr nz, .skip_unnerve
	ld hl, NotifyUnnerve
	call StdBattleTextBox
.skip_unnerve
	jp RunStatusHealAbilities

RunEnemyStatusHealAbilities:
	farcall BattleCommand_SwitchTurn
	call RunStatusHealAbilities
	farcall BattleCommand_SwitchTurn
	ret

RunStatusHealAbilities:
; Procs abilities that protect against statuses.
	; Needed because this is called elsewhere.
	ld a, BATTLE_VARS_ABILITY
	call GetBattleVar
	cp LIMBER
	jp z, LimberAbility
	cp IMMUNITY
	jp z, ImmunityAbility
	cp MAGMA_ARMOR
	jp z, MagmaArmorAbility
	cp WATER_VEIL
	jp z, WaterVeilAbility
	cp INSOMNIA
	jp z, InsomniaAbility
	cp VITAL_SPIRIT
	jp z, VitalSpiritAbility
	cp OWN_TEMPO
	jp z, OwnTempoAbility
	cp OBLIVIOUS
	jp z, ObliviousAbility
	ret

ImmunityAbility:
	ld a, 1 << PSN
	jr HealStatusAbility
WaterVeilAbility:
	ld a, 1 << BRN
	jr HealStatusAbility
MagmaArmorAbility:
	ld a, 1 << FRZ
	jr HealStatusAbility
LimberAbility:
	ld a, 1 << PAR
	jr HealStatusAbility
InsomniaAbility:
VitalSpiritAbility:
	ld a, 1 << SLP
	jr HealStatusAbility
HealStatusAbility:
	ld b, a
	ld a, BATTLE_VARS_STATUS
	call GetBattleVar
	and b
	ret z ; not afflicted/wrong status
	call ShowAbilityActivation
	ld a, BATTLE_VARS_STATUS
	call GetBattleVarAddr
	xor a
	ld [hl], a
	ld hl, BecameHealthyText
	call StdBattleTextBox
	ld a, [hBattleTurn]
	and a
	jr z, .is_player
	farcall CalcEnemyStats
	ret
.is_player
	farcall CalcPlayerStats
	ret

OwnTempoAbility:
	ld a, BATTLE_VARS_SUBSTATUS3
	call GetBattleVar
	and SUBSTATUS_CONFUSED
	ret z ; not confused
	call ShowAbilityActivation
	ld a, BATTLE_VARS_SUBSTATUS3
	call GetBattleVarAddr
	res SUBSTATUS_CONFUSED, [hl]
	ld hl, ConfusedNoMoreText
	jp StdBattleTextBox

ObliviousAbility:
	ld a, BATTLE_VARS_SUBSTATUS1
	call GetBattleVar
	and SUBSTATUS_IN_LOVE
	ret z ; not infatuated
	call ShowAbilityActivation
	ld a, BATTLE_VARS_SUBSTATUS1
	call GetBattleVarAddr
	res SUBSTATUS_IN_LOVE, [hl]
	ld hl, ConfusedNoMoreText
	jp StdBattleTextBox

TraceAbility:
	ld a, BATTLE_VARS_ABILITY_OPP
	call GetBattleVar
	cp TRACE
	jr z, .trace_failure
	cp IMPOSTER
	jr z, .trace_failure
	push af
	ld a, BATTLE_VARS_ABILITY
	call GetBattleVarAddr
	pop af
	ld [hl], a
	ld hl, TraceActivationText
	call StdBattleTextBox
	; handle swift swim, etc.
	ld a, [hBattleTurn]
	jr z, .is_player
	farcall CalcEnemyStats
	ret
.is_player
	farcall CalcPlayerStats
	ret
.trace_failure
	ld hl, TraceFailureText
	call StdBattleTextBox
	ret

; Lasts 5 turns consistent with Generation VI.
DrizzleAbility:
	ld a, WEATHER_RAIN
	jr WeatherAbility
DroughtAbility:
	ld a, WEATHER_SUN
	jr WeatherAbility
SandStreamAbility:
	ld a, WEATHER_SANDSTORM
	jr WeatherAbility
CloudNineAbility:
	ld a, WEATHER_NONE
	jr WeatherAbility
WeatherAbility:
	ld b, a
	ld a, [Weather]
	cp b
	ret z ; don't re-activate it
	call ShowAbilityActivation
	ld a, 5
	ld [WeatherCount], a
	ld a, b
	ld [Weather], a
	; handle swift swim, etc.
	push bc
	farcall CalcPlayerStats
	farcall CalcEnemyStats
	pop bc
	ld a, b
	cp WEATHER_RAIN
	jr z, .handlerain
	cp WEATHER_SUN
	jr z, .handlesun
	cp WEATHER_SANDSTORM
	jr z, .handlesandstorm
	; we're dealing with cloud nine
	xor a
	ld [WeatherCount], a
	ld hl, BattleText_TheWeatherSubsided
	jp StdBattleTextBox
.handlerain
	ld de, RAIN_DANCE
	farcall Call_PlayBattleAnim
	ld hl, DownpourText
	jp StdBattleTextBox
.handlesun
	ld de, SUNNY_DAY
	farcall Call_PlayBattleAnim
	ld hl, SunGotBrightText
	jp StdBattleTextBox
.handlesandstorm
	ld de, SANDSTORM
	farcall Call_PlayBattleAnim
	ld hl, SandstormBrewedText
	jp StdBattleTextBox

IntimidateAbility:
	call ShowAbilityActivation
	farcall DisableAnimations
	farcall ResetMiss
	farcall BattleCommand_AttackDown
	farcall BattleCommand_StatDownMessage
	ret

DownloadAbility:
; Increase Atk if enemy Def is lower than SpDef, otherwise SpAtk
	call ShowAbilityActivation
	farcall DisableAnimations
	ld hl, EnemyMonDefense
	ld a, [hBattleTurn]
	and a
	jr z, .ok
	ld hl, BattleMonDefense
.ok
	ld a, [hli]
	ld b, a
	ld a, [hl]
	ld c, a
	ld hl, EnemyMonSpclDef + 1
	ld a, [hBattleTurn]
	and a
	jr z, .ok2
	ld hl, BattleMonSpclDef + 1
.ok2
	ld a, [hld]
	ld e, a
	ld a, [hl]
	cp b
	jr c, .inc_spatk
	jr nz, .inc_atk
	; The high defense bits are equal, so compare the lower bits
	ld a, c
	cp e
	jr c, .inc_atk
.inc_spatk
	farcall ResetMiss
	farcall BattleCommand_SpecialAttackUp
	farcall BattleCommand_StatUpMessage
	ret
.inc_atk
	farcall ResetMiss
	farcall BattleCommand_AttackUp
	farcall BattleCommand_StatUpMessage
	ret

ImposterAbility:
	call ShowAbilityActivation
	farcall DisableAnimations
	farcall ResetMiss
	farcall BattleCommand_Transform
	ld de, TRANSFORM
	farcall Call_PlayBattleAnim
	ret

AnticipationAbility:
ForewarnAbility:
FriskAbility:
	ret

RunEnemyOwnTempoAbility:
	farcall BattleCommand_SwitchTurn
	ld a, BATTLE_VARS_ABILITY
	call GetBattleVar
	cp OWN_TEMPO
	call z, SynchronizeAbility
	farcall BattleCommand_SwitchTurn
	ret

RunEnemySynchronizeAbility:
	farcall BattleCommand_SwitchTurn
	ld a, BATTLE_VARS_ABILITY
	call GetBattleVar
	cp SYNCHRONIZE
	call z, SynchronizeAbility
	farcall BattleCommand_SwitchTurn
	ret

SynchronizeAbility:
	ld a, BATTLE_VARS_STATUS
	call GetBattleVar
	and ALL_STATUS
	ret z ; not statused
	call ShowAbilityActivation
	farcall ResetMiss
	farcall DisableAnimations
	ld a, BATTLE_VARS_STATUS
	call GetBattleVar
	cp 1 << PSN
	jr z, .is_psn
	cp 1 << BRN
	jr z, .is_brn
	farcall BattleCommand_Paralyze
	ret
.is_psn
	farcall BattleCommand_Poison
	ret
.is_brn
	farcall BattleCommand_Burn
	ret

RunContactAbilities:
; turn perspective is from the attacker
; 30% of the time, activate Poison Touch
	call BattleRandom
	cp 1 + 30 percent
	jr nc, .skip_user_ability
	ld a, BATTLE_VARS_ABILITY
	cp POISON_TOUCH
	call z, PoisonTouchAbility
.skip_user_ability
	call GetOpponentAbilityAfterMoldBreaker
	cp PICKPOCKET
	jr nz, .not_pickpocket
	farcall BattleCommand_SwitchTurn
	call PickPocketAbility
	farcall BattleCommand_SwitchTurn
	ret
.not_pickpocket
; other abilities only trigger 30% of the time
;
; Abilities always run from the ability user's perspective. This is
; consistent. Thus, a switchturn happens here. Feel free to rework
; the logic if you feel that this reduces readability.
	call BattleRandom
	cp 1 + 30 percent
	ret nc
	call GetOpponentAbilityAfterMoldBreaker
	ld b, a
	farcall BattleCommand_SwitchTurn
	call .do_enemy_abilities
	farcall BattleCommand_SwitchTurn
	ret
.do_enemy_abilities
	ld a, b
	cp CUTE_CHARM
	jp z, CuteCharmAbility
	cp EFFECT_SPORE
	jp z, EffectSporeAbility
	cp FLAME_BODY
	jp z, FlameBodyAbility
	cp POISON_POINT
	jp z, PoisonPointAbility
	cp STATIC
	jp z, StaticAbility
	ret

PickPocketAbility:
CuteCharmAbility:
	ret
EffectSporeAbility:
	call CheckIfTargetIsGrassType
	ret z
	ld a, BATTLE_VARS_ABILITY_OPP
	call GetBattleVar
	cp OVERCOAT
	ret z
	call BattleRandom
	cp 1 + 33 percent
	jr c, PoisonPointAbility
	cp 1 + 66 percent
	jr c, StaticAbility
	; there are 2 sleep resistance abilities, so check one here
	ld a, BATTLE_VARS_ABILITY_OPP
	cp VITAL_SPIRIT
	ret z
	ld b, INSOMNIA
	ld c, HELD_PREVENT_SLEEP
	ld d, SLP
	jr AfflictStatusAbility
FlameBodyAbility:
	call CheckIfTargetIsFireType
	ret z
	ld b, WATER_VEIL
	ld c, HELD_PREVENT_BURN
	ld d, BRN
	jr AfflictStatusAbility
PoisonTouchAbility:
	; Poison Touch is the same as an opposing Poison Point, and since
	; abilities always run from the ability user's POV...
PoisonPointAbility:
	call CheckIfTargetIsPoisonType
	ret z
	call CheckIfTargetIsSteelType
	ret z
	ld b, IMMUNITY
	ld c, HELD_PREVENT_POISON
	ld d, PSN
	jr AfflictStatusAbility
StaticAbility:
	call CheckIfTargetIsElectricType
	ret z
	ld b, LIMBER
	ld c, HELD_PREVENT_PARALYZE
	ld d, PAR
AfflictStatusAbility
; While BattleCommand_Whatever already does all these checks,
; duplicating them here is minor logic, and it avoids spamming
; needless ability activations that ends up not actually doing
; anything.
	ld a, BATTLE_VARS_ABILITY_OPP
	push de
	call GetBattleVar
	pop de
	cp b
	ret z
	push de
	call GetOpponentItem
	pop de
	ld a, b
	cp c
	ret z
	ld b, d
	ld a, BATTLE_VARS_STATUS_OPP
	call GetBattleVar
	and a
	ret nz
	call ShowAbilityActivation
	farcall DisableAnimations
	ld a, b
	cp SLP
	jr z, .slp
	cp BRN
	jr z, .brn
	cp PSN
	jr z, .psn
	farcall BattleCommand_Paralyze
	ret
.slp
	farcall BattleCommand_SleepTarget
	ret
.brn
	farcall BattleCommand_Burn
	ret
.psn
	farcall BattleCommand_Poison
	ret

RunEnemyStatIncreaseAbilities:
	farcall BattleCommand_SwitchTurn
	ld a, BATTLE_VARS_ABILITY
	call GetBattleVar
	cp DEFIANT
	call z, DefiantAbility
	cp COMPETITIVE
	call z, CompetitiveAbility
	farcall BattleCommand_SwitchTurn
	ret

DefiantAbility:
	ld a, ATTACK
	jr StatIncreaseAbility
CompetitiveAbility:
	ld a, SP_ATTACK
StatIncreaseAbility:
	ld b, a
	call ShowAbilityActivation
	farcall DisableAnimations
	farcall ResetMiss
	ld a, b
	cp ATTACK
	jr nz, .sp_atk
	farcall BattleCommand_AttackUp2
	farcall BattleCommand_StatUpMessage
	ret
.sp_atk
	farcall BattleCommand_SpecialAttackUp2
	farcall BattleCommand_StatUpMessage
	ret

CheckOpponentStatLowerAbilities:
; sets FailedMessage if an ability prevented a stat from lowering
	call GetOpponentAbilityAfterMoldBreaker
	cp CLEAR_BODY
	jr z, .triggered_ability
	cp HYPER_CUTTER
	jr nz, .skip_hyper_cutter
	ld a, [LoweredStat]
	and ATTACK
	ret z
	jr .triggered_ability
.skip_hyper_cutter
	cp KEEN_EYE
	jr nz, .skip_keen_eye
	ld a, [LoweredStat]
	and ACCURACY
	ret z
	jr .triggered_ability
.skip_keen_eye
	cp BIG_PECKS
	ret nz
	ld a, [LoweredStat]
	and DEFENSE
	ret z
.triggered_ability
	call ShowEnemyAbilityActivation
	ld a, 1
	ld [FailedMessage], a
	ret

ShowAbilityActivation::
	xor a
	jr ShowAbilityActivationInner
ShowEnemyAbilityActivation::
	ld a, 1
ShowAbilityActivationInner:
; a=0: show player's ability, a=1: opponent's
	push bc
	and a
	jr nz, .enemy_activation
	ld hl, AbilityActivationText
	call StdBattleTextBox
	pop bc
	ret

.enemy_activation
	ld hl, EnemyAbilityActivationText
	call StdBattleTextBox
	pop bc
	ret

RunOverworldPickupAbility::
; iterates the party and checks for potentially picking up items.
	ld a, [PartyMons]
	and a
	ret z ; no Pokémon in party?
.loop
	dec a
	ret c
	cp $ff
	ret z

	ld [CurPartyMon], a

	ld a, MON_ITEM
	call GetPartyParamLocation
	ld a, [hl]
	and a
	ld a, [CurPartyMon]
	jr nz, .loop

	push bc
	ld a, MON_DVS + 1
	call GetPartyParamLocation
	ld b, [hl]
	ld a, MON_SPECIES
	call GetPartyParamLocation
	ld c, [hl]
	farcall GetAbility
	ld a, b
	pop bc
	cp PICKUP
	ld a, [CurPartyMon]
	jr nz, .loop

	call Random
	cp 1 + (10 percent)
	ld a, [CurPartyMon]
	jr c, .loop

	call .Pickup
	ld a, [CurPartyMon]
	jr .loop

.Pickup:
	ld b, 0
	ld c, 0
; Pickup selects from a table, giving better rewards scaling with level and randomness
	call Random
	cp 1 + (2 percent)
	jr c, .RarePickup
	cp 1 + (6 percent)
	call c, .IncBC
	cp 1 + (10 percent)
	call c, .IncBC
	cp 1 + (20 percent)
	call c, .IncBC
	cp 1 + (30 percent)
	call c, .IncBC
	cp 1 + (40 percent)
	call c, .IncBC
	cp 1 + (50 percent)
	call c, .IncBC
	cp 1 + (60 percent)
	call c, .IncBC
	cp 1 + (70 percent)
	call c, .IncBC
	ld hl, BasePickupTable
.DoneRandomizing:
; Increase bc based on level
	push hl
	ld a, MON_LEVEL
	call GetPartyParamLocation
	ld a, [hl]
	dec a ; 1-10, 11-20, ..., not 0-9, 10-19, ...
.level_loop
	sub 10
	jr c, .level_loop_done
	inc bc
	jr .level_loop
.level_loop_done
	pop hl
	add hl, bc
	ld a, [hl]
	ld b, a
	ld a, MON_ITEM
	call GetPartyParamLocation
	ld a, b
	ld [hl], a
	ret

.RarePickup:
; 2% of Pickup results use a different table with generally better items.
	call Random
	cp 1 + 50 percent
	call c, .IncBC
	ld hl, RarePickupTable
	jr .DoneRandomizing

.IncBC:
; This just exists to avoid a million labels
	inc bc
	ret

BasePickupTable:
	db POTION
	db ANTIDOTE
	db SUPER_POTION
	db GREAT_BALL
	db REPEL
	db ESCAPE_ROPE
	db FULL_HEAL
	db HYPER_POTION
	db ULTRA_BALL
	db REVIVE
	db RARE_CANDY
	db SILVER_LEAF
	db GOLD_LEAF
	db FULL_RESTORE
	db MAX_REVIVE
	db PP_UP
	db MAX_ELIXER
	db EXP_SHARE

RarePickupTable:
	db HYPER_POTION
	db NUGGET
	db KINGS_ROCK
	db FULL_RESTORE
	db ETHER
	db LUCKY_EGG
	db MAX_ETHER
	db LUCKY_EGG
	db ELIXER
	db LUCKY_EGG
	db LEFTOVERS
