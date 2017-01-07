RunActivationAbilitiesInner:
	ld a, BATTLE_VARS_ABILITY
	call GetBattleVar
	cp TRACE
	jp z, TraceAbility
	cp IMPOSTER
	jp z, ImposterAbility
	cp DRIZZLE
	jp z, DrizzleAbility
	cp DROUGHT
	jp z, DroughtAbility
	cp SAND_STREAM
	jp z, SandStreamAbility
	cp SNOW_WARNING
	jp z, SnowWarningAbility
	cp CLOUD_NINE ; just prints a message
	jr nz, .skip_cloud_nine
	ld hl, NotifyCloudNine
	jp StdBattleTextBox
.skip_cloud_nine
	cp INTIMIDATE
	jp z, IntimidateAbility
	cp PRESSURE ; just prints a message
	jr nz, .skip_pressure
	ld hl, NotifyPressure
	jp StdBattleTextBox
.skip_pressure
	cp DOWNLOAD
	jp z, DownloadAbility
	cp MOLD_BREAKER ; just prints a message
	jr nz, .skip_mold_breaker
	ld hl, NotifyMoldBreaker
	jp StdBattleTextBox
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
	jp StdBattleTextBox
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
	ld a, SLP
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
	ld a, BATTLE_VARS_SUBSTATUS2
	call GetBattleVarAddr
	and [hl]
	res SUBSTATUS_TOXIC, [hl]
	ld a, BATTLE_VARS_SUBSTATUS1
	call GetBattleVarAddr
	and [hl]
	res SUBSTATUS_NIGHTMARE, [hl]
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
	ld b, a
	farcall BufferAbility
	ld a, BATTLE_VARS_ABILITY
	call GetBattleVarAddr
	pop af
	ld [hl], a
	ld hl, TraceActivationText
	call StdBattleTextBox
	jp RunActivationAbilitiesInner
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
SnowWarningAbility:
	ld a, WEATHER_HAIL
	jr WeatherAbility
WeatherAbility:
	ld b, a
	ld a, [Weather]
	cp b
	ret z ; don't re-activate it
	call ShowAbilityActivation
	; Disable running animations as part of Start(Weather) commands. This will not block
	; Call_PlayBattleAnim that plays the animation manually.
	call DisableAnimations
	ld a, b
	cp WEATHER_RAIN
	jr z, .handlerain
	cp WEATHER_SUN
	jr z, .handlesun
	cp WEATHER_HAIL
	jr z, .handlehail
	; is sandstorm
	ld de, SANDSTORM
	farcall Call_PlayBattleAnim
	farcall BattleCommand_StartSandstorm
	jp EnableAnimations
.handlerain
	ld de, RAIN_DANCE
	farcall Call_PlayBattleAnim
	farcall BattleCommand_StartRain
	jp EnableAnimations
.handlesun
	ld de, SUNNY_DAY
	farcall Call_PlayBattleAnim
	farcall BattleCommand_StartSun
	jp EnableAnimations
.handlesandstorm
	ld de, SANDSTORM
	farcall Call_PlayBattleAnim
	farcall BattleCommand_StartSandstorm
	jp EnableAnimations
.handlehail
	ld de, HAIL
	farcall Call_PlayBattleAnim
	farcall BattleCommand_StartHail
	jp EnableAnimations

IntimidateAbility:
	call ShowAbilityActivation
	call DisableAnimations
	farcall ResetMiss
	farcall BattleCommand_AttackDown
	farcall BattleCommand_StatDownMessage
	jp EnableAnimations

DownloadAbility:
; Increase Atk if enemy Def is lower than SpDef, otherwise SpAtk
	call ShowAbilityActivation
	call DisableAnimations
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
	jp EnableAnimations
.inc_atk
	farcall ResetMiss
	farcall BattleCommand_AttackUp
	farcall BattleCommand_StatUpMessage
	jp EnableAnimations

ImposterAbility:
	call ShowAbilityActivation
	call DisableAnimations
	farcall ResetMiss
	farcall BattleCommand_Transform
	jp EnableAnimations

AnticipationAbility:
ForewarnAbility:
	ret

FriskAbility:
	farcall GetOpponentItem
	ld a, [hl]
	and a
	ret z ; no item
	ld [wNamedObjectIndexBuffer], a
	call GetItemName
	ld hl, FriskedItemText
	jp StdBattleTextBox

RunEnemyOwnTempoAbility:
	farcall BattleCommand_SwitchTurn
	ld a, BATTLE_VARS_ABILITY
	call GetBattleVar
	cp OWN_TEMPO
	call z, OwnTempoAbility
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
	call DisableAnimations
	ld a, BATTLE_VARS_STATUS
	call GetBattleVar
	cp 1 << PSN
	jr z, .is_psn
	cp 1 << BRN
	jr z, .is_brn
	farcall BattleCommand_Paralyze
	jp EnableAnimations
.is_psn
	farcall BattleCommand_Poison
	jp EnableAnimations
.is_brn
	farcall BattleCommand_Burn
	jp EnableAnimations

RunFaintAbilities:
; abilities that run after an attack faints an enemy
	ld a, BATTLE_VARS_ABILITY
	call GetBattleVar
	call .user_abilities
	call GetOpponentAbilityAfterMoldBreaker
	push af
	farcall BattleCommand_SwitchTurn
	pop af
	call .opponent_abilities
	farcall BattleCommand_SwitchTurn
	ret
.user_abilities
	cp MOXIE
	jp z, MoxieAbility
	ret
.opponent_abilities
	cp AFTERMATH
	jp z, AftermathAbility
	ret

AftermathAbility:
	; Damp protects against this
	ld a, BATTLE_VARS_ABILITY_OPP
	call GetBattleVar
	cp DAMP
	ret z
	; Only contact moves proc Aftermath
	farcall BattleCommand_SwitchTurn
	ld a, BATTLE_VARS_MOVE
	call GetBattleVar
	cp STRUGGLE
	push af
	farcall BattleCommand_SwitchTurn
	pop af
	jr z, .is_contact
	ld hl, ContactMoves
	call IsInArray
	ret c
.is_contact
	call ShowAbilityActivation
	farcall BattleCommand_SwitchTurn
	farcall GetQuarterMaxHP
	farcall SubtractHPFromUser
	farcall BattleCommand_SwitchTurn
	ret

RunHitAbilities:
; abilities that run on hitting the enemy with an offensive attack
	; First, check contact moves. Struggle makes contact, but can't be part of
	; the array check, being 0xFF (the array terminator)
	ld a, BATTLE_VARS_MOVE
	call GetBattleVar
	cp STRUGGLE
	jr z, .run_contact_abilities
	ld hl, ContactMoves
	call IsInArray
	jr c, .skip_contact_abilities
.run_contact_abilities
	call RunContactAbilities
.skip_contact_abilities
	; Store type and category (phy/spe/sta) so that abilities can check on them
	ld a, BATTLE_VARS_MOVE_CATEGORY
	call GetBattleVar
	ld b, a
	ld a, BATTLE_VARS_MOVE_TYPE
	call GetBattleVar
	ld c, a
	push bc
	call GetOpponentAbilityAfterMoldBreaker
	push af
	farcall BattleCommand_SwitchTurn
	pop af
	pop bc
	call .do_enemy_abilities
	farcall BattleCommand_SwitchTurn
	ret
.do_enemy_abilities
	cp CURSED_BODY
	jp z, CursedBodyAbility
	cp JUSTIFIED
	jp z, JustifiedAbility
	cp RATTLED
	jp z, RattledAbility
	cp WEAK_ARMOR
	jp z, WeakArmorAbility
	ret

RunContactAbilities:
; turn perspective is from the attacker
; 30% of the time, activate Poison Touch
	call BattleRandom
	cp 1 + 30 percent
	jr nc, .skip_user_ability
	ld a, BATTLE_VARS_ABILITY
	call GetBattleVar
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

CursedBodyAbility:
	call DisableAnimations
	; this runs ShowAbilityActivation when relevant
	farcall BattleCommand_Disable
	jp EnableAnimations

CuteCharmAbility:
	call DisableAnimations
	; this runs ShowAbilityActivation when relevant
	farcall BattleCommand_Attract
	jp EnableAnimations

PickPocketAbility:
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
	call GetBattleVar
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
	farcall GetOpponentItem
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
	call DisableAnimations
	ld a, b
	cp SLP
	jr z, .slp
	cp BRN
	jr z, .brn
	cp PSN
	jr z, .psn
	farcall BattleCommand_Paralyze
	jp EnableAnimations
.slp
	farcall BattleCommand_SleepTarget
	jp EnableAnimations
.brn
	farcall BattleCommand_Burn
	jp EnableAnimations
.psn
	farcall BattleCommand_Poison
	jp EnableAnimations

CheckNullificationAbilities:
; Doesn't deal with the active effect of this, but just checking if they apply vs
; an opponent's used attack (not Overcoat vs powder which is checked with Grass)
	; Most abilities depends on types and can use a lookup table, but a few
	; doesn't. Check these first.
	call GetOpponentAbilityAfterMoldBreaker
	cp DAMP
	jr z, .damp
	cp SOUNDPROOF
	jr z, .soundproof
	ld b, a
	ld hl, .NullificationAbilityTypes
.loop
	ld a, [hli]
	cp b
	jr z, .found_ability
	inc hl
	cp -1
	jr nz, .loop
	ret

.found_ability
	ld a, [hl]
	ld b, a
	ld a, BATTLE_VARS_MOVE_TYPE
	call GetBattleVar
	cp b
	jr z, .ability_ok
	ret

.damp
	ld a, BATTLE_VARS_MOVE_EFFECT
	call GetBattleVar
	cp EFFECT_EXPLOSION
	jr z, .ability_ok
	ret

.soundproof
	ld a, BATTLE_VARS_MOVE
	call GetBattleVar
	ld hl, SoundMoves
	ld de, 1
	call IsInArray
	jr c, .ability_ok
	ret

.ability_ok
	; Set AttackMissed to 3 (means ability immunity kicked in), and wTypeMatchup
	; to 0 (not neccessary for the engine itself, but helps the AI)
	ld a, 3
	ld [AttackMissed], a
	xor a
	ld [wTypeMatchup], a
	ret

.NullificationAbilityTypes:
	db VOLT_ABSORB,   ELECTRIC
	db LIGHTNING_ROD, ELECTRIC
	db MOTOR_DRIVE,   ELECTRIC
	db DRY_SKIN,      WATER
	db WATER_ABSORB,  WATER
	db FLASH_FIRE,    FIRE
	db SAP_SIPPER,    GRASS
	db LEVITATE,      GROUND
	db -1


RunEnemyNullificationAbilities:
; At this point, we are already certain that the ability will activate, so no additional
; checks are required.
	farcall BattleCommand_SwitchTurn
	call .do_enemy_abilities
	farcall BattleCommand_SwitchTurn
	ret
.do_enemy_abilities
	ld a, BATTLE_VARS_ABILITY
	call GetBattleVar
	cp DRY_SKIN
	jp z, DrySkinAbility
	cp FLASH_FIRE
	jp z, FlashFireAbility
	cp LIGHTNING_ROD
	jp z, LightningRodAbility
	cp MOTOR_DRIVE
	jp z, MotorDriveAbility
	cp SAP_SIPPER
	jp z, SapSipperAbility
	cp VOLT_ABSORB
	jp z, VoltAbsorbAbility
	cp WATER_ABSORB
	jp z, WaterAbsorbAbility
	cp DAMP
	jp z, DampAbility
	; For other abilities, don't do anything except print a message (for example Levitate)
	call ShowAbilityActivation
	farcall BattleCommand_SwitchTurn
	ld hl, DoesntAffectText
	call StdBattleTextBox
	farcall BattleCommand_SwitchTurn
	ret

DampAbility:
	; doesn't use the normal activation message or "doesn't affect", because it
	; would be confusing
	ld hl, DampAbilityText
	jp StdBattleTextBox

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

CompetitiveAbility:
	ld b, $10 | SP_ATTACK
	jr StatUpAbility
DefiantAbility:
	ld b, $10 | ATTACK
	jr StatUpAbility
JustifiedAbility:
	; only for dark type moves
	ld a, c
	cp DARK
	ret nz
MoxieAbility:
SapSipperAbility:
	ld b, ATTACK
	jr StatUpAbility
LightningRodAbility:
	ld b, SP_ATTACK
	jr StatUpAbility
RattledAbility:
	; only for bug-, dark or ghost type moves
	ld a, c
	cp BUG
	jr .ok
	cp DARK
	jr .ok
	cp GHOST
	jr .ok
	ret
.ok
	; fallthrough
MotorDriveAbility:
SteadfastAbility:
SpeedBoostAbility:
	ld b, SPEED
StatUpAbility:
	call DisableAnimations
	farcall ResetMiss
	farcall BattleCommand_StatUp
	ld a, [FailedMessage]
	and a
	jr nz, .cant_raise
	call ShowAbilityActivation
	farcall BattleCommand_StatUpMessage
	jp EnableAnimations
.cant_raise
; Lightning Rod, Motor Drive and Sap Sipper prints a "doesn't affect" message instead.
	ld a, BATTLE_VARS_ABILITY
	cp LIGHTNING_ROD
	jr z, .print_immunity
	cp MOTOR_DRIVE
	jr z, .print_immunity
	cp SAP_SIPPER
	jp nz, EnableAnimations
.print_immunity
	call ShowAbilityActivation
	ld hl, DoesntAffectText
	call StdBattleTextBox
	jp EnableAnimations

WeakArmorAbility:
	; only physical moves activate this
	ld a, b
	cp PHYSICAL
	ret nz

	ld b, DEFENSE
	call DisableAnimations
	farcall ResetMiss
	farcall LowerStat
	ld a, [FailedMessage]
	and a
	jr nz, .failed_defensedown
	call ShowAbilityActivation
	farcall BattleCommand_SwitchTurn
	farcall BattleCommand_StatDownMessage
	farcall BattleCommand_SwitchTurn
	farcall ResetMiss
	farcall BattleCommand_SpeedUp2
	ld a, [FailedMessage]
	and a
	jp nz, EnableAnimations
.speedupmessage
	farcall BattleCommand_StatUpMessage
	ret
.failed_defensedown
; If we can still raise Speed, do that and show ability activation anyway
	farcall ResetMiss
	farcall BattleCommand_SpeedUp2
	ld a, [FailedMessage]
	and a
	jp nz, EnableAnimations
	call ShowAbilityActivation
	jr .speedupmessage

FlashFireAbility:
	call ShowAbilityActivation
	ld a, BATTLE_VARS_SUBSTATUS3
	call GetBattleVarAddr
	ld a, [hl]
	and 1<<SUBSTATUS_FLASH_FIRE
	jr nz, .already_fired_up
	set SUBSTATUS_FLASH_FIRE, [hl]
	ld hl, FirePoweredUpText
	jp StdBattleTextBox
.already_fired_up
	ld hl, DoesntAffectText
	jp StdBattleTextBox

DrySkinAbility:
VoltAbsorbAbility:
WaterAbsorbAbility:
	call ShowAbilityActivation
	farcall CheckFullHP_b
	ld a, b
	and a
	jr z, .full_hp
	farcall GetQuarterMaxHP
	farcall RestoreHP
	ret
.full_hp
	ld hl, HPIsFullText
	jp StdBattleTextBox

ApplySpeedAbilities:
; Passive speed boost abilities. Speed in bc
	ld a, BATTLE_VARS_ABILITY
	call GetBattleVar
	cp SWIFT_SWIM
	jr z, .swift_swim
	cp CHLOROPHYLL
	jr z, .clorophyll
	cp SAND_RUSH
	jr z, .sand_rush
	cp QUICK_FEET
	ret nz
	ld a, BATTLE_VARS_STATUS
	and a
	ret z
	jr .semidouble
.swift_swim
	ld h, WEATHER_RAIN
	jr .weather_ability
.clorophyll
	ld h, WEATHER_SUN
	jr .weather_ability
.sand_rush
	ld h, WEATHER_SANDSTORM
.weather_ability
	call GetWeatherAfterCloudNine
	cp h
	ret nz
	; double
	sla c
	rl b
	ret
.semidouble
	; 50% boost
	ld h, b
	ld l, c
	srl b
	rr c
	add hl, bc
	ld b, h
	ld c, l
	ret

ApplyAccuracyAbilities:
; Passive accuracy boost/reduction abilities.
; Current accuracy is in mul/div addresses
	ld a, BATTLE_VARS_ABILITY
	call GetBattleVar
	call .user_abilities
	call GetOpponentAbilityAfterMoldBreaker
	ld b, a
	farcall BattleCommand_SwitchTurn
	ld a, b
	call .enemy_abilities
	farcall BattleCommand_SwitchTurn
	ret

.user_abilities
	ld hl, hMultiplier
	cp COMPOUND_EYES
	jr z, CompoundEyesAbility
	cp HUSTLE
	jr z, HustleAccuracyAbility
	ret

.enemy_abilities
	ld hl, hMultiplier
	cp SAND_VEIL
	jr z, SandVeilAbility
	cp TANGLED_FEET
	jr z, TangledFeetAbility
	cp SNOW_CLOAK
	jr z, SnowCloakAbility
	cp WONDER_SKIN
	jr z, WonderSkinAbility
	ret

CompoundEyesAbility:
; Increase accuracy by 30%
	ld [hl], 13
	call Multiply
	ld [hl], 10
	ld b, 4
	jp Divide

HustleAccuracyAbility:
; Decrease accuracy by 50%
	ld [hl], 2
	ld b, 4
	jp Divide

TangledFeetAbility:
; Decrease accuracy by 50% while confused
	push hl
	ld a, BATTLE_VARS_SUBSTATUS3
	call GetBattleVarAddr
	bit SUBSTATUS_CONFUSED, [hl]
	pop hl
	ret z
	ld [hl], 2
	ld b, 4
	jp Divide

WonderSkinAbility:
; Decrease accuracy by 50% for status moves
	ld a, [wEnemyMoveStructCategory]
	ld b, a
	ld a, [hBattleTurn]
	and a
	jr z, .got_cat
	ld a, [wPlayerMoveStructCategory]
	ld b, a
.got_cat
	ld a, b
	cp STATUS
	ret nz

	ld [hl], 2
	ld b, 4
	jp Divide

SandVeilAbility:
	ld b, WEATHER_SANDSTORM
	jr WeatherAccAbility
SnowCloakAbility:
	ld b, WEATHER_HAIL
WeatherAccAbility:
; Decrease accuracy by 20% in relevant weather
	call GetWeatherAfterCloudNine
	cp b
	ret z
	ld [hl], 4
	call Multiply
	ld [hl], 5
	ld b, 4
	jp Divide

RunWeatherAbilities:
	ld a, BATTLE_VARS_ABILITY
	call GetBattleVar
	ld b, a
	call GetWeatherAfterCloudNine
	cp WEATHER_HAIL
	jr z, .hail
	cp WEATHER_SANDSTORM
	jr z, .sandstorm
	cp WEATHER_RAIN
	jr z, .rain
	cp WEATHER_SUN
	jr z, .sun
	ret
.hail
	ld a, b
	cp ICE_BODY
	jp z, IceBodyAbility
	ret
.sandstorm
	ret ; No active abilities for sandstorm
.rain
	ld a, b
	cp DRY_SKIN
	jp z, DrySkinRainAbility
	cp HYDRATION
	jp z, HydrationAbility
	cp RAIN_DISH
	jp z, RainDishAbility
	ret
.sun
	ld a, b
	cp DRY_SKIN
	jp z, DrySkinSunAbility
	cp SOLAR_POWER
	jp z, SolarPowerAbility
	ret

IceBodyAbility:
DrySkinRainAbility: ; restores 1/8 max HP rather than 1/16
RainDishAbility:
	farcall CheckFullHP_b
	ld a, b
	and a
	ret z
	call ShowAbilityActivation
	ld a, BATTLE_VARS_ABILITY
	call GetBattleVar
	cp DRY_SKIN
	jr z, .eighth_max_hp
	farcall GetSixteenthMaxHP
.got_hp
	farcall RestoreHP
	ret

.eighth_max_hp
	farcall GetEighthMaxHP
	jr .got_hp

DrySkinSunAbility:
SolarPowerAbility:
	call ShowAbilityActivation
	farcall GetEighthMaxHP
	farcall SubtractHPFromUser
	ret

HandleAbilities:
; Abilities handled at the end of the turn.
	call CheckSpeed
	jr nz, .enemy_first
	call SetPlayerTurn
	call .do_it
	call SetEnemyTurn
	jp .do_it

.enemy_first
	call SetEnemyTurn
	call .do_it
	call SetPlayerTurn

.do_it
	ld a, BATTLE_VARS_ABILITY
	call GetBattleVar
	cp HARVEST
	jp z, HarvestAbility
	cp MOODY
	jp z, MoodyAbility
	cp PICKUP
	jp z, PickupAbility
	cp SHED_SKIN
	jp z, ShedSkinAbility
	cp SPEED_BOOST
	jp z, SpeedBoostAbility
	ret

HarvestAbility:
PickupAbility:
; TODO: save used up items
	ret

MoodyAbility:
; Moody raises one stat by 2 stages and lowers another (not the same one!) by 1.
; It will not try to raise a stat at +6 (or lower one at -6). This means that, should all
; stats be +6, Moody will not raise any stat, and vice versa.

	call ShowAbilityActivation ; Safe -- Moody is certain to work for at least one part.
	call DisableAnimations

	; First, check how many stats aren't maxed out
	ld hl, PlayerStatLevels
	ld a, [hBattleTurn]
	and a
	jr z, .got_stat_levels
	ld hl, EnemyStatLevels
.got_stat_levels
	ld b, 0 ; bitfield of nonmaxed stats
	ld c, 0 ; bitfield of nonminimized stats
	ld d, 1 ; bit to OR into b/c
	ld e, 0 ; loop counter
.loop1
	ld a, [hl]
	cp 13
	jr z, .maxed
	ld a, b
	or d
	ld b, a
	ld a, [hl]
	cp 1
	jr z, .minimized
.maxed
	ld a, c
	or d
	ld c, a
.minimized
	inc hl
	inc e
	sla d
	ld a, e
	cp 7
	jr c, .loop1

	; If all stats are maxed (b=0), skip increasing stats
	ld a, b
	and a
	jr z, .all_stats_maxed

	; Randomize values until we get one matching a nonmaxed stat
.loop2
	call BattleRandom
	and $7
	cp 7
	jr z, .loop2 ; there are only 7 stats (0-6)
	ld d, 1
	ld e, 0 ; counter
.loop3
	cp e
	jr z, .loop3_done
	sla d
	inc e
	jr .loop3
.loop3_done
	ld a, b
	and d
	jr z, .loop2

	; We got the stat to raise. Set the e:th bit (using d) in c to 0
	; to avoid lowering the stat as well.
	ld a, d
	cpl
	and c
	ld c, a
	ld a, e
	or $10 ; raise it sharply
	ld b, a
	push bc
	farcall ResetMiss
	farcall BattleCommand_StatUp
	farcall BattleCommand_StatUpMessage
	pop bc

.all_stats_maxed
	ld a, c
	and a
	jp z, EnableAnimations ; no stat to lower

.loop4
	call BattleRandom
	and $7
	cp 7
	jr z, .loop4
	ld d, 1
	ld e, 0 ; counter
.loop5
	cp e
	jr z, .loop5_done
	sla d
	inc e
	jr .loop5
.loop5_done
	ld a, c
	and d
	jr z, .loop4

	ld b, e
	farcall ResetMiss
	farcall LowerStat
	farcall BattleCommand_SwitchTurn
	farcall BattleCommand_StatDownMessage
	farcall BattleCommand_SwitchTurn
	jp EnableAnimations

ShedSkinAbility:
; Cure a non-volatile status 30% of the time
	call BattleRandom
	cp 1 + (30 percent)
	ret nc
	; fallthrough
NaturalCureAbility:
HydrationAbility:
	ld a, 1 << PSN | 1 << BRN | 1 << FRZ | 1 << PAR | SLP
	jp HealStatusAbility

AngerPointAbility:
	call DisableAnimations
	farcall ResetMiss
	farcall BattleCommand_AttackUp2
	ld a, [FailedMessage]
	and a
	jp nz, EnableAnimations
	call ShowAbilityActivation
	farcall BattleCommand_AttackUp2
	farcall BattleCommand_AttackUp2
	farcall BattleCommand_AttackUp2
	farcall BattleCommand_AttackUp2
	farcall BattleCommand_AttackUp2
	ld hl, AngerPointMaximizedAttackText
	call StdBattleTextBox
	jp EnableAnimations

RunSwitchAbilities:
; abilities that activate when you switch out
	ld a, BATTLE_VARS_ABILITY
	call GetBattleVar
	cp NATURAL_CURE
	jr z, NaturalCureAbility
	cp REGENERATOR
	jr z, RegeneratorAbility
	ret

RegeneratorAbility:
	farcall CheckFullHP_b
	ld a, b
	and a
	ret z
	call ShowAbilityActivation
	farcall GetThirdMaxHP
	farcall RestoreHP
	ret

DisableAnimations:
	ld a, 1
	ld [AnimationsDisabled], a
	ret

EnableAnimations:
	xor a
	ld [AnimationsDisabled], a
	ret

ShowEnemyAbilityActivation::
	farcall BattleCommand_SwitchTurn
	call ShowAbilityActivation
	farcall BattleCommand_SwitchTurn
	ret
ShowAbilityActivation::
	push bc
	push de
	push hl
	ld a, BATTLE_VARS_ABILITY
	call GetBattleVar
	ld b, a
	farcall BufferAbility
	ld hl, BattleText_UsersStringBuffer1Activated
	call StdBattleTextBox
	pop hl
	pop de
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
	ld a, MON_ABILITY
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
