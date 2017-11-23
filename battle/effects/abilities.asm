RunActivationAbilitiesInner:
	ld hl, BattleEntryAbilities
	jr UserAbilityJumptable
RunStatusHealAbilities:
	ld hl, StatusHealAbilities
UserAbilityJumptable:
	ld a, BATTLE_VARS_ABILITY
	call GetBattleVar
	jp AbilityJumptable

RunEnemyStatusHealAbilities:
	call SwitchTurn
	call RunStatusHealAbilities
	jp SwitchTurn

BattleEntryAbilities:
	dbw TRACE, TraceAbility
	dbw IMPOSTER, ImposterAbility
	dbw DRIZZLE, DrizzleAbility
	dbw DROUGHT, DroughtAbility
	dbw SAND_STREAM, SandStreamAbility
	dbw SNOW_WARNING, SnowWarningAbility
	dbw CLOUD_NINE, CloudNineAbility
	dbw INTIMIDATE, IntimidateAbility
	dbw PRESSURE, PressureAbility
	dbw DOWNLOAD, DownloadAbility
	dbw MOLD_BREAKER, MoldBreakerAbility
	dbw ANTICIPATION, AnticipationAbility
	dbw FOREWARN, ForewarnAbility
	dbw FRISK, FriskAbility
	dbw UNNERVE, UnnerveAbility
	; fallthrough
StatusHealAbilities:
; Status immunity abilities that autoproc if the user gets the status or the ability
	dbw LIMBER, LimberAbility
	dbw IMMUNITY, ImmunityAbility
	dbw MAGMA_ARMOR, MagmaArmorAbility
	dbw WATER_VEIL, WaterVeilAbility
	dbw INSOMNIA, InsomniaAbility
	dbw VITAL_SPIRIT, VitalSpiritAbility
	dbw OWN_TEMPO, OwnTempoAbility
	dbw OBLIVIOUS, ObliviousAbility
	dbw -1, -1

CloudNineAbility:
	ld hl, NotifyCloudNine
	jr NotificationAbilities
PressureAbility:
	ld hl, NotifyPressure
	jr NotificationAbilities
MoldBreakerAbility:
	ld hl, NotifyMoldBreaker
	jr NotificationAbilities
UnnerveAbility:
	ld hl, NotifyUnnerve
NotificationAbilities:
	jp StdBattleTextBox

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
	; fallthrough
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
	jp z, UpdateBattleMonInParty
	jp UpdateEnemyMonInParty

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
	jp StdBattleTextBox

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
	; fallthrough
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
; Anticipation considers special types (just Hidden Power is applicable here) as
; whatever type they are listed as (e.g. HP is Normal). It will also (as of 5gen)
; treat Counter/Mirror Coat (and Metal Burst) as attacking moves of their type.
; It also ignores Pixilate.
	ld a, [hBattleTurn]
	and a
	ld hl, EnemyMonMoves
	jr z, .got_move_ptr
	ld hl, BattleMonMoves
.got_move_ptr
	; Since Anticipation can run in the middle of a turn and we don't want to ruin the
	; opponent's move struct, save the current move of it to be reapplied afterwards.
	call SwitchTurn
	ld a, BATTLE_VARS_MOVE
	call GetBattleVar
	push af
	ld b, NUM_MOVES
.loop
	; a mon can have less than 4 moves
	ld a, [hli]
	and a
	jr z, .done
	; copy the current move into the move structure to make CheckTypeMatchup happy
	push hl
	push bc
	dec a
	ld hl, Moves
	ld bc, MOVE_LENGTH
	call AddNTimes
	ld a, [hBattleTurn]
	and a
	ld de, wPlayerMoveStruct
	jr z, .got_move_struct
	ld de, wEnemyMoveStruct
.got_move_struct
	ld a, BANK(Moves)
	call FarCopyBytes
	; Ignore status moves. Don't ignore Counter/Mirror Coat (counterintuitive)
	ld a, BATTLE_VARS_MOVE_CATEGORY
	cp STATUS
	jr z, .end_of_loop
	; If the move is super effective, shudder
	farcall BattleCheckTypeMatchup
	ld a, [wTypeMatchup]
	cp SUPER_EFFECTIVE
	jr nc, .shudder
.end_of_loop
	pop bc
	pop hl
	dec b
	jr nz, .loop
	jr .done
.shudder
	pop bc
	pop hl
	call ShowEnemyAbilityActivation
	ld hl, ShudderedText
	call StdBattleTextBox
.done
	; now restore the move struct
	pop af
	dec a
	ld hl, Moves
	ld bc, MOVE_LENGTH
	call AddNTimes
	ld a, [hBattleTurn]
	and a
	ld de, wPlayerMoveStruct
	jr z, .got_move_struct2
	ld de, wEnemyMoveStruct
.got_move_struct2
	ld a, BANK(Moves)
	call FarCopyBytes
	jp SwitchTurn

ForewarnAbility:
; A note on moves with non-regular damage: Bulbapedia and Showdown has conflicting info on
; what power these moves actually have. I am using Showdown numbers here which assigns
; 160 to counter moves and 80 to everything else with nonstandard base power.
	ld a, [hBattleTurn]
	and a
	ld hl, EnemyMonMoves
	jr z, .got_move_ptr
	ld hl, BattleMonMoves
.got_move_ptr
	ld a, NUM_MOVES + 1
	ld [Buffer1], a ; iterator
	xor a
	ld [Buffer2], a ; used when randomizing between equal-power moves
	ld [Buffer3], a ; highest power move index
	ld [Buffer4], a	; power of said move for comparing
.loop
	ld a, [Buffer1]
	dec a
	jr z, .done
	ld [Buffer1], a
	; a mon can have less than 4 moves
	ld a, [hli]
	and a
	jr z, .done
	push af
	push hl
	; Check for special cases
	ld de, 1
	ld hl, DynamicPowerMoves
	call IsInArray
	pop hl
	pop bc
	jr nc, .not_special
	; Counter/Mirror Coat are regarded as 160BP moves, everything else as 80BP
	ld c, 160
	cp COUNTER
	jr z, .compare_power
	cp MIRROR_COAT
	jr z, .compare_power
	ld c, 80
	jr .compare_power
.not_special
	ld a, b
	dec a
	push hl
	ld hl, Moves + MOVE_POWER
	push bc
	call GetMoveAttr
	pop bc
	pop hl
	ld c, a
	; Status moves have 0 power
	and a
	jr z, .loop
.compare_power
	; b: current move ID, c: current move power
	ld a, [Buffer4]
	cp c
	jr z, .randomize
	jr nc, .loop
	; This move has higher BP, reset the random range
	xor a
	ld [Buffer2], a
	jr .replace
.randomize
	; Move power was equal: randomize. This is done as follows as to give even results:
	; 2 moves share power: 2nd move replaces 1/2 of the time
	; 3 moves share power: 3rd move replaces 2/3 of the time
	; 4 moves share power: 4th move replaces 3/4 of the time
	ld a, [Buffer2]
	inc a
	ld [Buffer2], a
	inc a
	call BattleRandomRange
	and a
	jr z, .loop
.replace
	ld a, b
	ld [Buffer3], a
	ld a, c
	ld [Buffer4], a
	jr .loop
.done
	; Check if we have an attacking move in first place
	ld a, [Buffer3]
	and a
	ret z
	push af
	call ShowAbilityActivation
	pop af
	ld [wNamedObjectIndexBuffer], a
	call GetMoveName
	ld hl, ForewarnText
	jp StdBattleTextBox

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
	call SwitchTurn
	ld a, BATTLE_VARS_ABILITY
	call GetBattleVar
	cp OWN_TEMPO
	call z, OwnTempoAbility
	jp SwitchTurn

RunEnemySynchronizeAbility:
	call SwitchTurn
	ld a, BATTLE_VARS_ABILITY
	call GetBattleVar
	cp SYNCHRONIZE
	call z, SynchronizeAbility
	jp SwitchTurn

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
	call SwitchTurn
	pop af
	call .opponent_abilities
	jp SwitchTurn

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
	call SwitchTurn
	call CheckContactMove
	push af
	call SwitchTurn
	pop af
	ret c
.is_contact
	call ShowAbilityActivation
	call SwitchTurn
	farcall GetQuarterMaxHP
	farcall SubtractHPFromUser
	jp SwitchTurn

RunHitAbilities:
; abilities that run on hitting the enemy with an offensive attack
	call CheckContactMove
	jr c, .skip_contact_abilities
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
	call SwitchTurn
	pop af
	pop bc
	call .do_enemy_abilities
	jp SwitchTurn

.do_enemy_abilities
	cp CURSED_BODY
	jp z, CursedBodyAbility
	push bc
	push af
	call HasUserFainted
	pop bc
	ld a, b
	pop bc
	ret z
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
; abilities only trigger 30% of the time
;
; Abilities always run from the ability user's perspective. This is
; consistent. Thus, a switchturn happens here. Feel free to rework
; the logic if you feel that this reduces readability.
	call BattleRandom
	cp 1 + 30 percent
	ret nc
	call GetOpponentAbilityAfterMoldBreaker
	ld b, a
	call SwitchTurn
	call .do_enemy_abilities
	jp SwitchTurn

.do_enemy_abilities
	ld a, b
	cp EFFECT_SPORE
	jp z, EffectSporeAbility
	cp FLAME_BODY
	jp z, FlameBodyAbility
	cp POISON_POINT
	jp z, PoisonPointAbility
	cp STATIC
	jp z, StaticAbility
	cp CUTE_CHARM
	jp z, CuteCharmAbility
	ret

CursedBodyAbility:
	ld a, 10
	call BattleRandomRange
	cp 3
	ret nc
	call DisableAnimations
	; this runs ShowAbilityActivation when relevant
	farcall BattleCommand_Disable
	jp EnableAnimations

CuteCharmAbility:
	call HasUserFainted
	ret z
	call DisableAnimations
	; this runs ShowAbilityActivation when relevant
	farcall BattleCommand_Attract
	jp EnableAnimations

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
	lb bc, INSOMNIA, HELD_PREVENT_SLEEP
	ld d, SLP
	jr AfflictStatusAbility
FlameBodyAbility:
	call CheckIfTargetIsFireType
	ret z
	lb bc, WATER_VEIL, HELD_PREVENT_BURN
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
	lb bc, IMMUNITY, HELD_PREVENT_POISON
	ld d, PSN
	jr AfflictStatusAbility
StaticAbility:
	call CheckIfTargetIsElectricType
	ret z
	lb bc, LIMBER, HELD_PREVENT_PARALYZE
	ld d, PAR
AfflictStatusAbility
; While BattleCommand_Whatever already does all these checks,
; duplicating them here is minor logic, and it avoids spamming
; needless ability activations that ends up not actually doing
; anything.
	call HasEnemyFainted
	ret z
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
	ret nc

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
	call SwitchTurn
	call .do_enemy_abilities
	jp SwitchTurn
.do_enemy_abilities
	ld hl, NullificationAbilities
	call UserAbilityJumptable
	ret nz

	; For other abilities, don't do anything except print a message (for example Levitate)
	call ShowAbilityActivation
	call SwitchTurn
	ld hl, DoesntAffectText
	call StdBattleTextBox
	jp SwitchTurn

NullificationAbilities:
	dbw DRY_SKIN, DrySkinAbility
	dbw FLASH_FIRE, FlashFireAbility
	dbw LIGHTNING_ROD, LightningRodAbility
	dbw MOTOR_DRIVE, MotorDriveAbility
	dbw SAP_SIPPER, SapSipperAbility
	dbw VOLT_ABSORB, VoltAbsorbAbility
	dbw WATER_ABSORB, WaterAbsorbAbility
	dbw DAMP, DampAbility
	dbw -1, -1

DampAbility:
	; doesn't use the normal activation message or "doesn't affect", because it
	; would be confusing
	ld hl, DampAbilityText
	jp StdBattleTextBox

RunEnemyStatIncreaseAbilities:
	call SwitchTurn
	ld hl, StatIncreaseAbilities
	call UserAbilityJumptable
	jp SwitchTurn

StatIncreaseAbilities:
	dbw COMPETITIVE, CompetitiveAbility
	dbw DEFIANT, DefiantAbility
	dbw -1, -1

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
	jr AttackUpAbility
MoxieAbility:
	; Don't run if battle is over
	ld a, [hBattleTurn]
	and a
	jr nz, .enemy
	ld a, [wBattleMode]
	dec a
	ret z
.enemy
	farcall CheckAnyOtherAliveOpponentMons
	ret z
SapSipperAbility:
AttackUpAbility:
	ld b, ATTACK
	jr StatUpAbility
LightningRodAbility:
	ld b, SP_ATTACK
	jr StatUpAbility
RattledAbility:
	; only for bug-, dark or ghost type moves
	ld a, c
	cp BUG
	jr z, .ok
	cp DARK
	jr z, .ok
	cp GHOST
	jr z, .ok
	ret
.ok
	; fallthrough
MotorDriveAbility:
SteadfastAbility:
SpeedBoostAbility:
	ld b, SPEED
StatUpAbility:
	call HasUserFainted
	ret z
	ld a, [AttackMissed]
	push af
	xor a
	ld [AttackMissed], a
	call DisableAnimations
	farcall ResetMiss
	farcall BattleCommand_StatUp
	ld a, [FailedMessage]
	and a
	jr nz, .cant_raise
	call ShowAbilityActivation
	farcall BattleCommand_StatUpMessage
	jr .done
.cant_raise
; Lightning Rod, Motor Drive and Sap Sipper prints a "doesn't affect" message instead.
	ld a, BATTLE_VARS_ABILITY
	call GetBattleVar
	cp LIGHTNING_ROD
	jr z, .print_immunity
	cp MOTOR_DRIVE
	jr z, .print_immunity
	cp SAP_SIPPER
	jr nz, .done
.print_immunity
	call ShowAbilityActivation
	call SwitchTurn
	ld hl, DoesntAffectText
	call StdBattleTextBox
	call SwitchTurn
.done
	pop af
	ld [AttackMissed], a
	jp EnableAnimations

WeakArmorAbility:
	; only physical moves activate this
	ld a, b
	and a ; cp PHYSICAL
	ret nz

	ld b, DEFENSE
	call DisableAnimations
	farcall ResetMiss
	farcall LowerStat ; can't be resisted
	ld a, [FailedMessage]
	and a
	jr nz, .failed_defensedown
	call ShowAbilityActivation
	call SwitchTurn
	farcall BattleCommand_StatDownMessage
	call SwitchTurn
	farcall ResetMiss
	farcall BattleCommand_SpeedUp2
	ld a, [FailedMessage]
	and a
	jp nz, EnableAnimations
.speedupmessage
	farjp BattleCommand_StatUpMessage
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
	farcall CheckFullHP
	jr z, .full_hp
	farcall GetQuarterMaxHP
	farjp RestoreHP
.full_hp
	ld hl, HPIsFullText
	jp StdBattleTextBox

ApplySpeedAbilities:
; Passive speed boost abilities
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
	ld a, $32
	jr .apply_mod
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
	ld a, $21
.apply_mod
	jp ApplyDamageMod

ApplyAccuracyAbilities:
	ld a, BATTLE_VARS_ABILITY
	call GetBattleVar
	ld hl, UserAccuracyAbilities
	call AbilityJumptable
	call GetOpponentAbilityAfterMoldBreaker
	ld hl, TargetAccuracyAbilities
	jp AbilityJumptable

UserAccuracyAbilities:
	dbw COMPOUND_EYES, CompoundEyesAbility
	dbw HUSTLE, HustleAccuracyAbility
	dbw -1, -1

TargetAccuracyAbilities:
	dbw TANGLED_FEET, TangledFeetAbility
	dbw WONDER_SKIN, WonderSkinAbility
	dbw SAND_VEIL, SandVeilAbility
	dbw SNOW_CLOAK, SnowCloakAbility
	dbw -1, -1

CompoundEyesAbility:
; Increase accuracy by 30%
	ld a, $da
	jp ApplyDamageMod

HustleAccuracyAbility:
; Decrease accuracy for physical attacks by 20%
	ld a, $45
	jp ApplyPhysicalAttackDamageMod

TangledFeetAbility:
; Double evasion if confused
	ld a, BATTLE_VARS_SUBSTATUS3_OPP
	call GetBattleVar
	bit SUBSTATUS_CONFUSED, a
	ret z
	ld a, $12
	jp ApplyDamageMod

WonderSkinAbility:
; Double evasion for status moves
	ld a, BATTLE_VARS_MOVE_CATEGORY
	call GetBattleVar
	cp STATUS
	ret nz
	ld a, $12
	jp ApplyDamageMod

SandVeilAbility:
	ld b, WEATHER_SANDSTORM
	jr WeatherAccAbility
SnowCloakAbility:
	ld b, WEATHER_HAIL
WeatherAccAbility:
; Decrease target accuracy by 20% in relevant weather
	call GetWeatherAfterCloudNine
	cp b
	ret nz
	ld a, $45
	jp ApplyDamageMod

RunWeatherAbilities:
	ld hl, WeatherAbilities
	jp UserAbilityJumptable

WeatherAbilities:
	dbw DRY_SKIN, DrySkinWeatherAbility
	dbw SOLAR_POWER, SolarPowerWeatherAbility
	dbw ICE_BODY, IceBodyAbility
	dbw RAIN_DISH, RainDishAbility
	dbw HYDRATION, HydrationAbility
	dbw -1, -1

DrySkinWeatherAbility:
	call RainRecoveryAbility
	; fallthrough (these need different weather so calling both is OK)
SolarPowerWeatherAbility:
	call GetWeatherAfterCloudNine
	cp WEATHER_SUN
	ret nz
	call ShowAbilityActivation
	farcall GetEighthMaxHP
	farjp SubtractHPFromUser

IceBodyAbility:
	ld b, WEATHER_HAIL
	jr WeatherRecoveryAbility
RainDishAbility:
RainRecoveryAbility:
	ld b, WEATHER_RAIN
WeatherRecoveryAbility:
	call GetWeatherAfterCloudNine
	cp b
	ret nz
	farcall CheckFullHP
	ret z
	call ShowAbilityActivation
	ld a, BATTLE_VARS_ABILITY
	call GetBattleVar
	cp DRY_SKIN
	jr z, .eighth_max_hp
	farcall GetSixteenthMaxHP
	jr .restore
.eighth_max_hp
	farcall GetEighthMaxHP
.restore
	farjp RestoreHP

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
	ld hl, EndTurnAbilities
	call UserAbilityJumptable
	ld hl, StatusHealAbilities
	jp UserAbilityJumptable

EndTurnAbilities:
	dbw HARVEST, HarvestAbility
	dbw MOODY, MoodyAbility
	dbw PICKUP, PickupAbility
	dbw SHED_SKIN, ShedSkinAbility
	dbw SPEED_BOOST, SpeedBoostAbility
	dbw -1, -1

HarvestAbility:
; At end of turn, re-harvest an used up Berry (100% in sun, 50% otherwise)
	call GetWeatherAfterCloudNine
	cp WEATHER_SUN
	jr z, .ok
	call BattleRandom
	and 1
	ret z

.ok
	; Don't do anything if we have an item already
	farcall GetUserItem
	ld a, [hl]
	and a
	ret nz

	; Only Berries are picked
	push hl
	call GetUsedItemAddr
	pop de
	ld a, [hl]
	and a
	ret z
	ld [CurItem], a
	ld b, a
	push bc
	push de
	push hl
	farcall CheckItemPocket
	pop hl
	pop de
	pop bc
	ld a, [wItemAttributeParamBuffer]
	cp BERRIES
	ret nz

	; Kill the used item
	xor a
	ld [hl], a

	; Pick up the item
	ld a, b
	ld [de], a

	ld hl, HarvestedItemText
	call RegainItemByAbility

	; For the player, update backup items
	ld a, [hBattleTurn]
	and a
	ret nz
	jp SetBackupItem

PickupAbility:
; At end of turn, pickup consumed opponent items if we don't have any
	; Don't do anything if we have an item already
	farcall GetUserItem
	ld a, [hl]
	and a
	ret nz

	; Does the opponent have a consumed item?
	push hl
	call SwitchTurn
	call GetUsedItemAddr
	call SwitchTurn
	pop de
	ld a, [hl]
	and a
	ret z

	; Pick up the item
	ld [de], a

	; Kill the used item
	ld b, a
	xor a
	ld [hl], a
	ld a, b

	ld hl, PickedItemText
	; fallthrough
RegainItemByAbility:
	; Update party struct if applicable
	ld [wNamedObjectIndexBuffer], a
	push af
	push hl
	call GetItemName
	pop hl
	call StdBattleTextBox
	pop bc
	ld a, [hBattleTurn]
	and a
	ld a, [CurPartyMon]
	ld hl, PartyMon1Item
	jr z, .got_item_addr
	ld a, [wBattleMode]
	dec a
	ret z
	ld a, [CurOTMon]
	ld hl, OTPartyMon1Item
.got_item_addr
	call GetPartyLocation
	ld [hl], b
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
	lb bc, 0, 0 ; bitfield of nonmaxed stats, bitfield of nonminimized stats
	lb de, 1, 0 ; bit to OR into b/c, loop counter
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
	lb de, 1, 0 ; e = counter
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
	lb de, 1, 0 ; e = counter
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
	call SwitchTurn
	farcall BattleCommand_StatDownMessage
	call SwitchTurn
	jp EnableAnimations

ApplyDamageAbilities:
	ld a, BATTLE_VARS_ABILITY
	call GetBattleVar
	ld hl, OffensiveDamageAbilities
	call AbilityJumptable
	call GetOpponentAbilityAfterMoldBreaker
	ld hl, DefensiveDamageAbilities
	jp AbilityJumptable

OffensiveDamageAbilities:
	dbw TECHNICIAN, TechnicianAbility
	dbw HUGE_POWER, HugePowerAbility
	dbw HUSTLE, HustleAbility
	dbw OVERGROW, OvergrowAbility
	dbw BLAZE, BlazeAbility
	dbw TORRENT, TorrentAbility
	dbw SWARM, SwarmAbility
	dbw RIVALRY, RivalryAbility
	dbw SHEER_FORCE, SheerForceAbility
	dbw ANALYTIC, AnalyticAbility
	dbw TINTED_LENS, TintedLensAbility
	dbw SOLAR_POWER, SolarPowerAbility
	dbw IRON_FIST, IronFistAbility
	dbw SAND_FORCE, SandForceAbility
	dbw RECKLESS, RecklessAbility
	dbw GUTS, GutsAbility
	dbw PIXILATE, PixilateAbility
	dbw -1, -1

DefensiveDamageAbilities:
	dbw MULTISCALE, EnemyMultiscaleAbility
	dbw MARVEL_SCALE, EnemyMarvelScaleAbility
	dbw SOLID_ROCK, EnemySolidRockAbility
	dbw FILTER, EnemyFilterAbility
	dbw THICK_FAT, EnemyThickFatAbility
	dbw DRY_SKIN, EnemyDrySkinAbility
	dbw FUR_COAT, EnemyFurCoatAbility
	dbw -1, -1

TechnicianAbility:
	ld a, d
	cp 61
	ret nc
	ld a, $32
	jp ApplyDamageMod

HugePowerAbility:
; Doubles physical attack
	ld a, $21
	jp ApplyPhysicalAttackDamageMod

HustleAbility:
; 150% physical attack, 80% accuracy (done elsewhere)
	ld a, $32
	jp ApplyPhysicalAttackDamageMod

OvergrowAbility:
	ld b, GRASS
	jr PinchAbility
BlazeAbility:
	ld b, FIRE
	jr PinchAbility
TorrentAbility:
	ld b, WATER
	jr PinchAbility
SwarmAbility:
	ld b, BUG
PinchAbility:
; 150% damage if the user is in a pinch (1/3HP or less) for given type
	ld a, BATTLE_VARS_MOVE_TYPE
	call GetBattleVar
	cp b
	ret nz
	call CheckPinch
	ret nz
	ld a, $32
	jp ApplyDamageMod

RivalryAbility:
; 100% damage if either mon is genderless, 125% if same gender, 75% if opposite gender
	farcall CheckOppositeGender
	ret c
	ld a, $54
	jr z, .apply_damage_mod
	ld a, $34
.apply_damage_mod
	jp ApplyDamageMod

SheerForceAbility:
; 130% damage if a secondary effect is suppressed
	ld a, [EffectFailed]
	and a
	ret z
	ld a, $da
	jp ApplyDamageMod

AnalyticAbility:
; 130% damage if opponent went first
	ld a, [wEnemyGoesFirst] ; 0 = player goes first
	ld b, a
	ld a, [hBattleTurn] ; 0 = player's turn
	xor b ; nz if opponent went first
	ret z
	ld a, $da
	jp ApplyDamageMod

TintedLensAbility:
; Doubles damage for not very effective moves (x0.5/x0.25)
	ld a, [TypeModifier]
	cp $10
	ret nc
	ld a, $21
	jp ApplyDamageMod

SolarPowerAbility:
; 150% special attack in sun, take 1/8 damage at turn end in sun (done elsewhere)
	call GetWeatherAfterCloudNine
	cp WEATHER_SUN
	ret nz
	ld a, $32
	jp ApplySpecialAttackDamageMod

IronFistAbility:
; 120% damage for punching moves
	ld a, BATTLE_VARS_MOVE
	call GetBattleVar
	ld hl, PunchingMoves
	call IsInArray
	ret c
	ld a, $65
	jp ApplyDamageMod

SandForceAbility:
; 130% damage for Ground/Rock/Steel-type moves in a sandstorm, not hurt by Sandstorm
	call GetWeatherAfterCloudNine
	cp WEATHER_SANDSTORM
	ret nz
	ld a, BATTLE_VARS_MOVE_TYPE
	call GetBattleVar
	cp GROUND
	jr z, .ok
	cp ROCK
	jr z, .ok
	cp STEEL
	ret nz
.ok
	ld a, $da
	jp ApplyDamageMod

RecklessAbility:
; 120% damage for (Hi) Jump Kick and recoil moves except for Struggle
	ld a, BATTLE_VARS_MOVE
	call GetBattleVar
	cp STRUGGLE
	ret z
	ld a, BATTLE_VARS_MOVE_EFFECT
	call GetBattleVar
	cp EFFECT_RECOIL_HIT
	jr z, .ok
	cp EFFECT_JUMP_KICK
	ret nz
.ok
	ld a, $65
	jp ApplyDamageMod

GutsAbility:
; 150% physical attack if user is statused
	ld a, BATTLE_VARS_STATUS
	call GetBattleVar
	and a
	ret z
	ld a, $32
	jp ApplyPhysicalAttackDamageMod

PixilateAbility:
	ld a, BATTLE_VARS_MOVE_TYPE
	call GetBattleVar
	and a ; cp NORMAL
	ret nz
	ld a, $65
	jp ApplyDamageMod

EnemyMultiscaleAbility:
; 50% damage if user is at full HP
	call SwitchTurn
	farcall CheckFullHP
	push af
	call SwitchTurn
	pop af
	ret nz
	ld a, $12
	jp ApplyDamageMod

EnemyMarvelScaleAbility:
; 150% physical Defense if statused
	ld a, BATTLE_VARS_STATUS_OPP
	call GetBattleVar
	and a
	ret z
	ld a, $23
	jp ApplyPhysicalDefenseDamageMod

EnemySolidRockAbility:
EnemyFilterAbility:
; 75% damage for super effective moves
	ld a, [TypeModifier]
	cp $11
	ret c
	ld a, $34
	jp ApplyDamageMod

EnemyThickFatAbility:
; 50% damage for Fire and Ice-type moves
	ld a, BATTLE_VARS_MOVE_TYPE
	call GetBattleVar
	cp FIRE
	jr z, .ok
	cp ICE
	ret nz
.ok
	ld a, $12
	jp ApplyDamageMod

EnemyDrySkinAbility:
; 125% damage for Fire-type moves, heals 1/4 from Water, regenerates 1/8 at end of turn in
; rain, takes 1/8 damage at end of turn in sun. This only handles Fire damage bonus, other
; stuff is elsewhere
	ld a, BATTLE_VARS_MOVE_TYPE
	call GetBattleVar
	cp FIRE
	ret nz
	ld a, $54
	jp ApplyDamageMod

EnemyFurCoatAbility:
; Doubles physical Defense
	ld a, $12
	jp ApplyPhysicalDefenseDamageMod


HydrationAbility:
	call GetWeatherAfterCloudNine
	cp WEATHER_RAIN
	ret nz
	jr HealAllStatusAbility
ShedSkinAbility:
; Cure a non-volatile status 30% of the time
	call BattleRandom
	cp 1 + (30 percent)
	ret nc
	; fallthrough
NaturalCureAbility:
HealAllStatusAbility:
	ld a, ALL_STATUS
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
	farcall CheckFullHP
	ret z
	call ShowAbilityActivation
	farcall GetThirdMaxHP
	farcall RestoreHP
	ld a, [hBattleTurn]
	and a
	jp z, UpdateBattleMonInParty
	jp UpdateEnemyMonInParty

AbilityJumptable:
	; If we at some point make the AI learn abilities, keep this.
	; For now it just jumps to the general jumptable function
	jp BattleJumptable

DisableAnimations:
	ld a, 1
	ld [AnimationsDisabled], a
	ret

EnableAnimations:
	xor a
	ld [AnimationsDisabled], a
	ret

ShowEnemyAbilityActivation::
	call SwitchTurn
	call ShowAbilityActivation
	jp SwitchTurn
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

RunPostBattleAbilities::
; Checks party for potentially finding items (Pickup) or curing status (Natural Cure)
	ld a, [PartyCount]
	jr .first_pass
.loop
	ld a, [CurPartyMon]
.first_pass
	dec a
	cp $ff
	ret z

	ld [CurPartyMon], a

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
	cp NATURAL_CURE
	jr z, .natural_cure
	cp PICKUP
	call z, .Pickup
	jr .loop

.natural_cure
	; Heal status
	ld a, MON_STATUS
	call GetPartyParamLocation
	xor a
	ld [hl], a
	jr .loop

.Pickup:
	ld a, MON_ITEM
	call GetPartyParamLocation
	ld a, [hl]
	and a
	ret nz

	call Random
	cp 1 + (10 percent)
	ret nc

	ld a, MON_LEVEL
	call GetPartyParamLocation
	ld a, [hl]
	call GetRandomPickupItem
	ld b, a
	ld a, MON_ITEM
	call GetPartyParamLocation
	ld a, b
	ld [hl], a
	ret

GetRandomPickupItem::
; a = level

; bc = floor((level - 1) / 10)
	ld bc, 0
	dec a ; 1-10 → 0-9, etc
.loop
	sub 10
	jr c, .done
	inc bc
	jr .loop
.done

; Pickup selects from a table, giving better rewards scaling with level and randomness
	ld a, 100
	call RandomRange
	cp 2
	jr c, .rare
	cp 6
	call c, .inc_bc
	cp 10
	call c, .inc_bc
	cp 20
	call c, .inc_bc
	cp 30
	call c, .inc_bc
	cp 40
	call c, .inc_bc
	cp 50
	call c, .inc_bc
	cp 60
	call c, .inc_bc
	cp 70
	call c, .inc_bc
	ld hl, .BasePickupTable
	jr .ok

.rare:
; 2% of Pickup results use a different table with generally better items
	call Random
	cp 1 + 50 percent
	call c, .inc_bc
	ld hl, .RarePickupTable
.ok:
	add hl, bc
	ld a, [hl]
	ret

.inc_bc:
	inc bc
	ret

.BasePickupTable:
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
	db DUSK_STONE
	db SHINY_STONE
	db MAX_ETHER
	db FULL_RESTORE
	db MAX_REVIVE
	db PP_UP
	db MAX_ELIXER

.RarePickupTable:
	db HYPER_POTION
	db NUGGET
	db KINGS_ROCK
	db FULL_RESTORE
	db ETHER
	db LUCKY_EGG
	db DESTINY_KNOT
	db ELIXER
	db BIG_NUGGET
	db LEFTOVERS
	db BOTTLE_CAP
