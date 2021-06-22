RunActivationAbilitiesInner:
	; Chain-triggering causes graphical glitches, so ensure animations
	; are re-enabled (which also takes care of existing ability slideouts)
	call EnableAnimations
	call HasUserFainted
	ret z
	call HasOpponentFainted
	ld hl, BattleEntryAbilities
	jr z, UserAbilityJumptable
	ld hl, BattleEntryAbilitiesNonfainted
	jr UserAbilityJumptable

RunEnemyStatusHealAbilities:
	call CallOpponentTurn
RunStatusHealAbilities:
	ld hl, StatusHealAbilities
UserAbilityJumptable:
	call GetTrueUserAbility
AbilityJumptable:
	; If we at some point make the AI learn abilities, keep this.
	; For now it just jumps to the general jumptable function
	jmp BattleJumptable

BattleEntryAbilitiesNonfainted:
	dbw TRACE, TraceAbility
	dbw IMPOSTER, ImposterAbility
	dbw INTIMIDATE, IntimidateAbility
	dbw DOWNLOAD, DownloadAbility
	dbw ANTICIPATION, AnticipationAbility
	dbw FOREWARN, ForewarnAbility
	dbw FRISK, FriskAbility
	dbw UNNERVE, UnnerveAbility
BattleEntryAbilities:
	dbw DRIZZLE, DrizzleAbility
	dbw DROUGHT, DroughtAbility
	dbw SAND_STREAM, SandStreamAbility
	dbw SNOW_WARNING, SnowWarningAbility
	dbw CLOUD_NINE, CloudNineAbility
	dbw PRESSURE, PressureAbility
	dbw MOLD_BREAKER, MoldBreakerAbility
	dbw NEUTRALIZING_GAS, NeutralizingGasAbility
	; fallthrough
StatusHealAbilities:
; Status immunity abilities that autoproc if the user gets the status or the ability
	dbw LIMBER, LimberAbility
	dbw IMMUNITY, ImmunityAbility
	dbw PASTEL_VEIL, PastelVeilAbility
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
	jr NotificationAbilities
NeutralizingGasAbility:
	ld hl, NotifyNeutralizingGas
NotificationAbilities:
	push hl
	call DisableAnimations
	call ShowAbilityActivation
	pop hl
	call StdBattleTextbox
	jmp EnableAnimations

ImmunityAbility:
PastelVeilAbility:
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
	call DisableAnimations
	call ShowAbilityActivation
	ld a, BATTLE_VARS_STATUS
	call GetBattleVarAddr
	xor a
	ld [hl], a
	ld hl, BecameHealthyText
	call StdBattleTextbox
	call EnableAnimations
	ldh a, [hBattleTurn]
	and a
	jmp z, UpdateBattleMonInParty
	jmp UpdateEnemyMonInParty

OwnTempoAbility:
	ld a, BATTLE_VARS_SUBSTATUS3
	call GetBattleVar
	bit SUBSTATUS_CONFUSED, a
	ret z ; not confused
	call DisableAnimations
	call ShowAbilityActivation
	ld a, BATTLE_VARS_SUBSTATUS3
	call GetBattleVarAddr
	res SUBSTATUS_CONFUSED, [hl]
	ld hl, ConfusedNoMoreText
	call StdBattleTextbox
	jmp EnableAnimations

ObliviousAbility:
	ld a, BATTLE_VARS_SUBSTATUS1
	call GetBattleVar
	bit SUBSTATUS_IN_LOVE, a
	ret z ; not infatuated
	call DisableAnimations
	call ShowAbilityActivation
	ld a, BATTLE_VARS_SUBSTATUS1
	call GetBattleVarAddr
	res SUBSTATUS_IN_LOVE, [hl]
	ld hl, NoLongerInfatuatedText
	call StdBattleTextbox
	jmp EnableAnimations

TraceAbility:
	call GetOpponentAbility
	inc a
	ret z ; Neutralizing Gas sentinel upon fainting
	dec a
	ret z
	cp TRACE
	jr z, .trace_failure
	cp IMPOSTER
	jr z, .trace_failure
	; just in case
	cp NEUTRALIZING_GAS
	ret z
	push af
	ld b, a
	farcall BufferAbility

	; TODO: fancier graphics?
	call DisableAnimations
	call ShowAbilityActivation
	call ShowEnemyAbilityActivation
	ld hl, TraceActivationText
	call StdBattleTextbox
	call EnableAnimations

	ld a, BATTLE_VARS_ABILITY
	call GetBattleVarAddr
	pop af
	ld [hl], a
	jmp RunActivationAbilitiesInner
.trace_failure
	ld hl, TraceFailureText
	jmp StdBattleTextbox

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
	ld a, [wBattleWeather]
	cp b
	ret z ; don't re-activate it

	call DisableAnimations
	call ShowAbilityActivation
	; Disable running animations as part of Start(wWeather) commands. This will not block
	; Call_PlayBattleAnim that plays the animation manually.
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
	farcall BattleCommand_startsandstorm
	jmp EnableAnimations
.handlerain
	ld de, RAIN_DANCE
	farcall Call_PlayBattleAnim
	farcall BattleCommand_startrain
	jmp EnableAnimations
.handlesun
	ld de, SUNNY_DAY
	farcall Call_PlayBattleAnim
	farcall BattleCommand_startsun
	jmp EnableAnimations
.handlehail
	ld de, HAIL
	farcall Call_PlayBattleAnim
	farcall BattleCommand_starthail
	jmp EnableAnimations

IntimidateAbility:
	; does not work against Inner Focus, Own Tempo, Oblivious, Scrappy
	call GetOpponentAbility
	ld b, a
	push af
	farcall BufferAbility
	pop af
	ld hl, NoIntimidateAbilities
	call IsInByteArray
	jr nc, .intimidate_ok
	call DisableAnimations
	call ShowAbilityActivation
	call ShowEnemyAbilityActivation
	ld hl, BattleText_IntimidateResisted
	call StdBattleTextbox
	jmp EnableAnimations

.intimidate_ok
	call DisableAnimations
	ld b, ATTACK
	farcall ForceLowerOppStat

	; if stat decrease happened, proc Rattled
	call SwitchTurn
	ld a, [wFailedMessage]
	and a
	jr nz, .continue
	call GetTrueUserAbility
	cp RATTLED
	ld b, SPEED
	call z, StatUpAbility

.continue
	call EnableAnimations
	farcall CheckWhiteHerb
	jmp SwitchTurn

INCLUDE "data/abilities/no_intimidate_abilities.asm"

DownloadAbility:
; Increase Atk if enemy Def is lower than SpDef, otherwise SpAtk
	call DisableAnimations
	ld hl, wEnemyMonDefense
	ldh a, [hBattleTurn]
	and a
	jr z, .ok
	ld hl, wBattleMonDefense
.ok
	ld a, [hli]
	ld b, a
	ld a, [hl]
	ld c, a
	ld hl, wEnemyMonSpclDef + 1
	ldh a, [hBattleTurn]
	and a
	jr z, .ok2
	ld hl, wBattleMonSpclDef + 1
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
	ld b, SP_ATTACK
	jr .got_stat
.inc_atk
	ld b, ATTACK
.got_stat
	farcall ForceRaiseStat
	jmp EnableAnimations

ImposterAbility:
	; Disallowed on Neutralizing Gas (even in switch-out mode)
	call GetOpponentAbility
	inc a
	ret z

	call DisableAnimations
	; flags for the transform wave anim to not affect slideouts
	farcall ShowPotentialAbilityActivation
	farcall BattleCommand_transform
	jmp EnableAnimations

AnticipationAbility:
; Anticipation considers special types (just Hidden Power is applicable here) as
; whatever type they are listed as (e.g. HP is Normal). It will also (as of 5gen)
; treat Counter/Mirror Coat (and Metal Burst) as attacking moves of their type.
; It also ignores Pixilate and Galvanize.
	ldh a, [hBattleTurn]
	and a
	ld hl, wEnemyMonMoves
	jr z, .got_move_ptr
	ld hl, wBattleMonMoves
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
	push af
	ldh a, [hBattleTurn]
	and a
	ld de, wPlayerMoveStruct
	jr z, .got_move_struct
	ld de, wEnemyMoveStruct
.got_move_struct
	pop af
	call GetFixedMoveStruct
	; Ignore status moves. Don't ignore Counter/Mirror Coat (counterintuitive)
	ld a, BATTLE_VARS_MOVE_CATEGORY
	call GetBattleVar
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
	call DisableAnimations
	call ShowEnemyAbilityActivation
	ld hl, ShudderedText
	call StdBattleTextbox
	call EnableAnimations
.done
	; now restore the move struct
	pop af
	push af
	ldh a, [hBattleTurn]
	and a
	ld de, wPlayerMoveStruct
	jr z, .got_move_struct2
	ld de, wEnemyMoveStruct
.got_move_struct2
	pop af
	call GetFixedMoveStruct
	jmp SwitchTurn

ForewarnAbility:
; A note on moves with non-regular damage: Bulbapedia and Showdown has conflicting info on
; what power these moves actually have. I am using Showdown numbers here which assigns
; 160 to counter moves and 80 to everything else with nonstandard base power.
	ldh a, [hBattleTurn]
	and a
	ld hl, wEnemyMonMoves
	jr z, .got_move_ptr
	ld hl, wBattleMonMoves
.got_move_ptr
	ld a, NUM_MOVES + 1
	ld [wBuffer1], a ; iterator
	xor a
	ld [wBuffer2], a ; used when randomizing between equal-power moves
	ld [wBuffer3], a ; highest power move index
	ld [wBuffer4], a ; power of said move for comparing
.loop
	ld a, [wBuffer1]
	dec a
	jr z, .done
	ld [wBuffer1], a
	; a mon can have less than 4 moves
	ld a, [hli]
	and a
	jr z, .done
	push af
	push hl
	; Check for special cases
	ld hl, DynamicPowerMoves
	call IsInByteArray
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
	call GetMoveAttr
	pop hl
	ld c, a
	; Status moves have 0 power
	and a
	jr z, .loop
.compare_power
	; b: current move ID, c: current move power
	ld a, [wBuffer4]
	cp c
	jr z, .randomize
	jr nc, .loop
	; This move has higher BP, reset the random range
	xor a
	ld [wBuffer2], a
	jr .replace
.randomize
	; Move power was equal: randomize. This is done as follows as to give even results:
	; 2 moves share power: 2nd move replaces 1/2 of the time
	; 3 moves share power: 3rd move replaces 2/3 of the time
	; 4 moves share power: 4th move replaces 3/4 of the time
	ld a, [wBuffer2]
	inc a
	ld [wBuffer2], a
	inc a
	call BattleRandomRange
	and a
	jr z, .loop
.replace
	ld a, b
	ld [wBuffer3], a
	ld a, c
	ld [wBuffer4], a
	jr .loop
.done
	; Check if we have an attacking move in first place
	ld a, [wBuffer3]
	and a
	ret z
	push af
	call DisableAnimations
	call ShowAbilityActivation
	pop af
	ld [wNamedObjectIndex], a
	call GetMoveName
	ld hl, ForewarnText
	call StdBattleTextbox
	jmp EnableAnimations

FriskAbility:
	farcall GetOpponentItem
	ld a, [hl]
	and a
	ret z ; no item
	call DisableAnimations
	call ShowAbilityActivation
	call GetCurItemName
	ld hl, FriskedItemText
	call StdBattleTextbox
	jmp EnableAnimations

RunEnemyOwnTempoAbility:
	call SwitchTurn
	call GetTrueUserAbility
	cp OWN_TEMPO
	call z, OwnTempoAbility
	jmp SwitchTurn

RunEnemySynchronizeAbility:
	call SwitchTurn
	call GetTrueUserAbility
	cp SYNCHRONIZE
	call z, SynchronizeAbility
	jmp SwitchTurn

SynchronizeAbility:
	ld a, BATTLE_VARS_STATUS
	call GetBattleVar
	and 1 << PAR | 1 << BRN | 1 << PSN
	ret z ; not statused or frozen/asleep (which doesn't proc Synchronize)
	call DisableAnimations
	call ShowAbilityActivation
	farcall ResetMiss
	ld a, BATTLE_VARS_STATUS
	call GetBattleVar
	cp 1 << PAR
	jr z, .is_par
	cp 1 << BRN
	jr z, .is_brn
	cp 1 << PSN
	jr z, .is_psn
	farcall BattleCommand_toxic
	jmp EnableAnimations
.is_psn
	farcall BattleCommand_poison
	jmp EnableAnimations
.is_par
	farcall BattleCommand_paralyze
	jmp EnableAnimations
.is_brn
	farcall BattleCommand_burn
	jmp EnableAnimations

ResolveOpponentBerserk_CheckMultihit:
; Does nothing if we're currently in an ongoing multihit move.
	; Regular multihit
	ld a, BATTLE_VARS_SUBSTATUS3
	call GetBattleVarAddr
	bit SUBSTATUS_IN_LOOP, [hl]
	ret nz

	; Check if user has Parental Bond
	call GetTrueUserAbility
	cp PARENTAL_BOND
	ret z

	; fallthrough
ResolveOpponentBerserk:
	ld a, BATTLE_VARS_SUBSTATUS2_OPP
	call GetBattleVarAddr
	bit SUBSTATUS_IN_ABILITY, [hl]
	ret z
	res SUBSTATUS_IN_ABILITY, [hl]

	call GetOpponentAbilityAfterMoldBreaker
	cp BERSERK
	ret nz

	farcall CheckSheerForceNegation
	ret z

	call SwitchTurn
	ld b, SP_ATTACK
	call StatUpAbility
	jmp SwitchTurn

RunFaintAbilities:
; abilities that run after an attack faints an enemy
	farcall GetFutureSightUser
	ret nz
	call GetTrueUserAbility
	call _RunFaintUserAbilities
	call GetOpponentAbilityAfterMoldBreaker
	push af
	call SwitchTurn
	pop af
	call _RunFaintOpponentAbilities
	jmp SwitchTurn

_RunFaintOpponentAbilities:
	cp AFTERMATH
	ret nz
	; fallthrough
AftermathAbility:
	; Damp protects against this
	call GetOpponentAbility
	cp DAMP
	ret z
	; Only contact moves proc Aftermath
	call CheckOpponentContactMove
	ret c
.is_contact
	call DisableAnimations
	call ShowAbilityActivation
	call SwitchTurn
	call GetQuarterMaxHP
	predef SubtractHPFromUser
	ld hl, IsHurtText
	call StdBattleTextbox
	call EnableAnimations
	jmp SwitchTurn

RunHitAbilities:
; abilities that run on hitting the enemy with an offensive attack
	call CheckContactMove
	call nc, RunContactAbilities
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
	jmp SwitchTurn

.do_enemy_abilities
	cp CURSED_BODY
	jr z, CursedBodyAbility
	push bc
	push af
	call HasUserFainted
	pop bc
	ld a, b
	pop bc
	ret z
	cp JUSTIFIED
	jmp z, JustifiedAbility
	cp RATTLED
	jmp z, RattledAbility
	cp WEAK_ARMOR
	jmp z, WeakArmorAbility
	ret

CursedBodyAbility:
	call SwitchTurn
	farcall GetFutureSightUser
	push af
	call SwitchTurn
	pop af
	ret nz
	ld a, 10
	call BattleRandomRange
	cp 3
	ret nc
	call DisableAnimations
	; this runs ShowAbilityActivation when relevant
	farcall BattleCommand_disable
	jmp EnableAnimations

RunContactAbilities:
; turn perspective is from the attacker
	call GetTrueUserAbility
	ld hl, UserContactAbilities
	call AbilityJumptable
	call GetOpponentAbilityAfterMoldBreaker
	call SwitchTurn
	ld hl, TargetContactAbilities
	call AbilityJumptable
	jmp SwitchTurn

UserContactAbilities:
	dbw POISON_TOUCH, PoisonTouchAbility
	dbw -1, -1

TargetContactAbilities:
	dbw EFFECT_SPORE, EffectSporeAbility
	dbw FLAME_BODY, FlameBodyAbility
	dbw POISON_POINT, PoisonPointAbility
	dbw STATIC, StaticAbility
	dbw CUTE_CHARM, CuteCharmAbility
	dbw TANGLING_HAIR, TanglingHairAbility
	dbw -1, -1

CuteCharmAbility:
	call HasUserFainted
	ret z

	; Only works 30% of the time.
	ld a, 10
	call BattleRandomRange
	cp 3
	ret nc

	call DisableAnimations
	; this runs ShowAbilityActivation when relevant
	farcall BattleCommand_attract
	jmp EnableAnimations

TanglingHairAbility:
	call HasOpponentFainted
	ret z

	call DisableAnimations
	ld b, SPEED
	ld a, STAT_SILENT
	farcall _ForceLowerOppStat
	jmp EnableAnimations

EffectSporeAbility:
	call CheckIfTargetIsGrassType
	ret z
	call GetOpponentAbility
	cp OVERCOAT
	ret z
	farcall GetOpponentItemAfterUnnerve
	ld a, b
	cp HELD_SAFETY_GOGGLES
	ret z
	call BattleRandom
	cp 1 + 33 percent
	jr c, PoisonPointAbility
	cp 1 + 66 percent
	jr c, StaticAbility

	ld hl, CanSleepTarget
	ld c, SLP
	jr AfflictStatusAbility
FlameBodyAbility:
	ld hl, CanBurnTarget
	ld c, 1 << BRN
	jr AfflictStatusAbility
PoisonTouchAbility:
	; Poison Touch is the same as an opposing Poison Point, and since
	; abilities always run from the ability user's POV...
	; Doesn't apply when opponent has a Substitute up...
	ld b, 1
	jr DoPoisonAbility
PoisonPointAbility:
	ld b, 0
	; fallthrough
DoPoisonAbility:
	ld hl, CanPoisonTarget
	ld c, 1 << PSN
	jr _AfflictStatusAbility
StaticAbility:
	ld hl, CanParalyzeTarget
	ld c, 1 << PAR
	; fallthrough
AfflictStatusAbility:
	ld b, 0
_AfflictStatusAbility:
	; Only works 30% of the time.
	ld a, 10
	call BattleRandomRange
	cp 3
	ret nc

	push hl
	push bc
	ld a, BANK(CanPoisonTarget)
	call FarCall_hl
	pop bc
	pop hl
	ret nz

	call HasOpponentFainted
	ret z

	ld a, BATTLE_VARS_STATUS_OPP
	call GetBattleVarAddr
	ld a, c
	cp SLP
	jr nz, .got_status

	; sleep for 1-3 turns (+1 including wakeup turn)
	ld a, 3
	call RandomRange
	inc a
.got_status
	ld [hl], a

	call DisableAnimations
	farcall DisplayStatusProblem
	call UpdateOpponentInParty
	call UpdateBattleHuds
	farcall PostStatusWithSynchronize
	jmp EnableAnimations

CheckNullificationAbilities:
; Doesn't deal with the active effect of this, but just checking if they apply vs
; an opponent's used attack (not Overcoat vs powder which is checked with Grass)
	; Most abilities depends on types and can use a lookup table, but a few
	; don't. Check these first.
	call GetOpponentAbilityAfterMoldBreaker
	ld b, a
	cp DAMP
	jr z, .damp
	cp SOUNDPROOF
	jr z, .soundproof
	cp FLASH_FIRE
	jr z, .flash_fire
	cp LIGHTNING_ROD
	jr z, .check_others

	ld a, BATTLE_VARS_MOVE_CATEGORY
	call GetBattleVar
	cp STATUS
	ret z

.check_others
	ld hl, TypeNullificationAbilities
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
	call IsInByteArray
	jr c, .ability_ok
	ret

.flash_fire
	; Also affected by status moves and Will-O-Wisp
	ld a, BATTLE_VARS_MOVE_EFFECT
	call GetBattleVar
	cp EFFECT_BURN
	jr nz, .check_others

.ability_ok
	ld a, ATKFAIL_ABILITY
	ld [wAttackMissed], a
	xor a ; kind of redundant, but helpful for the AI
	ld [wTypeMatchup], a
	ret

INCLUDE "data/abilities/type_nullification_abilities.asm"

RunEnemyNullificationAbilities:
; At this point, we are already certain that the ability will activate, so no additional
; checks are required.
	call CallOpponentTurn
.do_enemy_abilities
	ld hl, NullificationAbilities
	call UserAbilityJumptable
	ret nz

	; For other abilities, don't do anything except print a message (for example Levitate)
	call DisableAnimations
	call ShowAbilityActivation
	call SwitchTurn
	ld hl, DoesntAffectText
	call StdBattleTextbox
	call EnableAnimations
	jmp SwitchTurn

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
	ld a, BATTLE_VARS_MOVE_OPP
	call GetBattleVar
	ld [wNamedObjectIndex], a
	call GetMoveName
	call DisableAnimations
	call ShowAbilityActivation
	ld hl, CannotUseText
	call StdBattleTextbox
	jmp EnableAnimations

RunStatIncreaseAbilities:
	call CallOpponentTurn
RunEnemyStatIncreaseAbilities:
	call SwitchTurn
	ld hl, StatIncreaseAbilities
	call UserAbilityJumptable
	jmp SwitchTurn

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
_RunFaintUserAbilities:
	cp MOXIE
	ret nz
	; fallthrough
MoxieAbility:
	; Don't run if battle is over
	farcall CheckAnyOtherAliveOpponentMons
	ret z
	; fallthrough
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
	ret nz
.ok
	; fallthrough
MotorDriveAbility:
SteadfastAbility:
SpeedBoostAbility:
	ld b, SPEED
StatUpAbility:
	call HasUserFainted
	ret z
	call DisableAnimations
	ld a, STAT_SILENT
	farcall _ForceRaiseStat
	ld a, [wFailedMessage]
	and a
	jr z, .done

; Lightning Rod, Motor Drive and Sap Sipper prints a "doesn't affect" message instead.
	call GetTrueUserAbility
	cp LIGHTNING_ROD
	jr z, .print_immunity
	cp MOTOR_DRIVE
	jr z, .print_immunity
	cp SAP_SIPPER
	jr nz, .done
.print_immunity
	call DisableAnimations
	call ShowAbilityActivation
	call SwitchTurn
	ld hl, DoesntAffectText
	call StdBattleTextbox
	call EnableAnimations
	call SwitchTurn
.done
	jmp EnableAnimations

WeakArmorAbility:
	; only physical moves activate this
	ld a, b
	and a ; cp PHYSICAL
	ret nz

	call DisableAnimations
	ld b, DEFENSE
	farcall LowerStat
	ld b, $10 | SPEED
	farcall RaiseStat
	jmp EnableAnimations

FlashFireAbility:
	call DisableAnimations
	call ShowAbilityActivation
	ld a, BATTLE_VARS_SUBSTATUS1
	call GetBattleVarAddr
	ld a, [hl]
	and 1 << SUBSTATUS_FLASH_FIRE
	jr nz, .already_fired_up
	set SUBSTATUS_FLASH_FIRE, [hl]
	ld hl, FirePoweredUpText
	call StdBattleTextbox
	jmp EnableAnimations
.already_fired_up
	call SwitchTurn
	ld hl, DoesntAffectText
	call StdBattleTextbox
	call EnableAnimations
	jmp SwitchTurn

DrySkinAbility:
VoltAbsorbAbility:
WaterAbsorbAbility:
	call DisableAnimations
	call ShowAbilityActivation
	farcall CheckFullHP
	jr z, .full_hp
	call GetQuarterMaxHP
	farcall RestoreHP
	ld hl, RegainedHealthText
	call StdBattleTextbox
	jmp EnableAnimations
.full_hp
	ld hl, HPIsFullText
	call StdBattleTextbox
	jmp EnableAnimations

ApplySpeedAbilities:
; Passive speed boost abilities
	call GetTrueUserAbility
	cp UNBURDEN
	jr z, .unburden
	cp SWIFT_SWIM
	jr z, .swift_swim
	cp CHLOROPHYLL
	jr z, .clorophyll
	cp SAND_RUSH
	jr z, .sand_rush
	cp SLUSH_RUSH
	jr z, .slush_rush
	cp QUICK_FEET
	ret nz
	ld a, BATTLE_VARS_STATUS
	call GetBattleVar
	and a
	ret z
	ln a, 3, 2 ; x1.5
	jr .apply_mod
.unburden
	; Only if we have the Unburden volatile
	ld a, BATTLE_VARS_SUBSTATUS1
	call GetBattleVar
	bit SUBSTATUS_UNBURDEN, a
	ret z
	ln a, 2, 1 ; x2
	jr .apply_mod
.swift_swim
	ld h, WEATHER_RAIN
	jr .weather_ability
.clorophyll
	ld h, WEATHER_SUN
	jr .weather_ability
.sand_rush
	ld h, WEATHER_SANDSTORM
	jr .weather_ability
.slush_rush
	ld h, WEATHER_HAIL
.weather_ability
	call GetWeatherAfterUserUmbrella
	cp h
	ret nz
	ln a, 2, 1 ; x2
.apply_mod
	jmp MultiplyAndDivide

ApplyAccuracyAbilities:
	call GetTrueUserAbility
	ld hl, UserAccuracyAbilities
	call AbilityJumptable
	call GetOpponentAbilityAfterMoldBreaker
	ld hl, TargetAccuracyAbilities
	jmp AbilityJumptable

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
	ln a, 13, 10 ; x1.3
	jmp MultiplyAndDivide

HustleAccuracyAbility:
; Decrease accuracy for physical attacks by 20%
	ld a, $45
	jmp ApplyPhysicalAttackDamageMod

TangledFeetAbility:
; Double evasion if confused
	ld a, BATTLE_VARS_SUBSTATUS3_OPP
	call GetBattleVar
	bit SUBSTATUS_CONFUSED, a
	ret z
	ln a, 1, 2 ; x0.5
	jmp MultiplyAndDivide

WonderSkinAbility:
; Double evasion for status moves
	ld a, BATTLE_VARS_MOVE_CATEGORY
	call GetBattleVar
	cp STATUS
	ret nz
	ln a, 1, 2 ; x0.5
	jmp MultiplyAndDivide

SandVeilAbility:
	ld b, WEATHER_SANDSTORM
	jr WeatherAccAbility
SnowCloakAbility:
	ld b, WEATHER_HAIL
WeatherAccAbility:
; Decrease target accuracy by 20% in relevant weather
	call GetWeatherAfterOpponentUmbrella
	cp b
	ret nz
	ln a, 4, 5 ; x0.8
	jmp MultiplyAndDivide

RunWeatherAbilities:
	ld hl, WeatherAbilities
	jmp UserAbilityJumptable

WeatherAbilities:
	dbw DRY_SKIN, DrySkinWeatherAbility
	dbw SOLAR_POWER, SolarPowerWeatherAbility
	dbw ICE_BODY, IceBodyAbility
	dbw RAIN_DISH, RainDishAbility
	dbw -1, -1

DrySkinWeatherAbility:
	call RainRecoveryAbility
	; fallthrough (these need different weather so calling both is OK)
SolarPowerWeatherAbility:
	call GetWeatherAfterUserUmbrella
	cp WEATHER_SUN
	ret nz
	call DisableAnimations
	call ShowAbilityActivation
	call GetEighthMaxHP
	predef SubtractHPFromUser
	ld hl, IsHurtText
	call StdBattleTextbox
	jmp EnableAnimations

IceBodyAbility:
	ld b, WEATHER_HAIL
	jr WeatherRecoveryAbility
RainDishAbility:
RainRecoveryAbility:
	ld b, WEATHER_RAIN
WeatherRecoveryAbility:
	call GetWeatherAfterUserUmbrella
	cp b
	ret nz
	farcall CheckFullHP
	ret z
	call DisableAnimations
	call ShowAbilityActivation
	call GetTrueUserAbility
	cp DRY_SKIN
	jr z, .eighth_max_hp
	call GetSixteenthMaxHP
	jr .restore
.eighth_max_hp
	call GetEighthMaxHP
.restore
	farcall RestoreHP
	ld hl, RegainedHealthText
	call StdBattleTextbox
	jmp EnableAnimations

EndturnAbilitiesA:
	ld hl, EndturnAbilityTableA
	jr _EndturnAbilities

EndturnAbilitiesB:
; these 2 routines are deliberately seperate to maintain vanilla accuracy
	ld hl, EndturnAbilityTableB
	; fallthrough
_EndturnAbilities:
	push hl
	call HasUserFainted
	pop hl
	ret z
	call UserAbilityJumptable
	ld hl, StatusHealAbilities
	jmp UserAbilityJumptable

EndturnAbilityTableA:
	dbw SHED_SKIN, ShedSkinAbility
	dbw HYDRATION, HydrationAbility
	dbw -1, -1

EndturnAbilityTableB:
	dbw HARVEST, HarvestAbility
	dbw MOODY, MoodyAbility
	dbw PICKUP, PickupAbility
	dbw SPEED_BOOST, SpeedBoostAbility
	dbw -1, -1

HarvestAbility:
; At end of turn, re-harvest an used up Berry (100% in sun, 50% otherwise)
	call GetWeatherAfterUserUmbrella
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
	ld [wCurItem], a
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
	ldh a, [hBattleTurn]
	and a
	ret nz
	jmp SetBackupItem

PickupAbility:
; At end of turn, pickup consumed opponent items if we don't have any
	; Don't do anything if we have an item already
	farcall GetUserItem
	ld a, [hl]
	and a
	ret nz

	; Wild opponents may not use this ability (prevent item duplication)
	ldh a, [hBattleTurn]
	and a
	jr z, .player
	ld a, [wBattleMode]
	dec a
	ret z

.player
	; Does the opponent have a consumed item?
	push hl
	call GetOpponentUsedItemAddr
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
	push af
	push hl
	call DisableAnimations
	call ShowAbilityActivation
	pop hl
	pop af

	ld [wNamedObjectIndex], a
	push af
	push hl
	call GetItemName
	pop hl
	call StdBattleTextbox
	pop bc
	ldh a, [hBattleTurn]
	and a
	ld a, [wCurPartyMon]
	ld hl, wPartyMon1Item
	jr z, .got_item_addr
	ld a, [wCurOTMon]
	ld hl, wOTPartyMon1Item
.got_item_addr
	call GetPartyLocation
	ld [hl], b
	jmp EnableAnimations

GetCappedStats:
	; First, check how many stats aren't maxed out
	ld hl, wPlayerStatLevels
	ldh a, [hBattleTurn]
	and a
	jr z, .got_stat_levels
	ld hl, wEnemyStatLevels
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
	cp 5
	jr c, .loop1
	ret

SelectRandomRaiseStat:
; Returns stat to raise in e.
; Intended for use after GetCappedStats.
; Automatically disallows the stat from SelectRandomLowerStat. If this is
; unwanted, just re-run GetCappedStats after performing the stat raise.
; Returns z if all stats are maxed.
	; If all stats are maxed (b=0), skip increasing stats
	ld a, b
	and a
	ret z

	ld h, b
	call SelectRandomStat

	; Disallow the stat to be lowered
	ld a, d
	cpl
	and c
	ld c, a
	or 1
	ret

SelectRandomLowerStat:
	; If all stats are minimized (c=0), skip decreasing stats
	ld a, c
	and a
	ret z

	ld h, c
	call SelectRandomStat

	ld a, d
	cpl
	and c
	ld c, a
	or 1
	ret

SelectRandomStat:
	; Randomize values until we get one matching a nonmaxed stat
.loop1
	call BattleRandom
	and $7
	cp 5
	jr nc, .loop1 ; don't raise acc/eva, only 0-4 (atk/def/spe/sat/sdf)
	lb de, 1, 0 ; e = counter
.loop2
	cp e
	jr z, .loop2_done
	sla d
	inc e
	jr .loop2
.loop2_done
	ld a, h
	and d
	jr z, .loop1
	ret

MoodyAbility:
; Moody raises one stat by 2 stages and lowers another (not the same one!) by 1.
; It will not try to raise a stat at +6 (or lower one at -6). This means that, should all
; stats be +6, Moody will not raise any stat, and vice versa.

	call DisableAnimations

	call GetCappedStats
	call SelectRandomRaiseStat
	jr z, .raise_done
	push bc
	ld a, $10
	or e
	ld b, a
	farcall ForceRaiseStat
	pop bc
.raise_done
	call SelectRandomLowerStat
	jr z, .lower_done
	ld b, e
	farcall ForceLowerStat
.lower_done
	jmp EnableAnimations

ApplyDamageAbilities_AfterTypeMatchup:
	call GetTrueUserAbility
	ld hl, OffensiveDamageAbilities_AfterTypeMatchup
	call AbilityJumptable
	call GetOpponentAbilityAfterMoldBreaker
	ld hl, DefensiveDamageAbilities_AfterTypeMatchup
	jmp AbilityJumptable

OffensiveDamageAbilities_AfterTypeMatchup:
	dbw TINTED_LENS, TintedLensAbility
	dbw -1, -1

DefensiveDamageAbilities_AfterTypeMatchup:
	dbw SOLID_ROCK, EnemySolidRockAbility
	dbw FILTER, EnemyFilterAbility
	dbw -1, -1

ApplyDamageAbilities:
	call GetTrueUserAbility
	ld hl, OffensiveDamageAbilities
	call AbilityJumptable
	call GetOpponentAbilityAfterMoldBreaker
	ld hl, DefensiveDamageAbilities
	jmp AbilityJumptable

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
	dbw SOLAR_POWER, SolarPowerAbility
	dbw IRON_FIST, IronFistAbility
	dbw TOUGH_CLAWS, ToughClawsAbility
	dbw MEGA_LAUNCHER, MegaLauncherAbility
	dbw SAND_FORCE, SandForceAbility
	dbw RECKLESS, RecklessAbility
	dbw GUTS, GutsAbility
	dbw PIXILATE, PixilateAbility
	dbw GALVANIZE, GalvanizeAbility
	dbw GORILLA_TACTICS, GorillaTacticsAbility
	dbw -1, -1

DefensiveDamageAbilities:
	dbw MULTISCALE, EnemyMultiscaleAbility
	dbw MARVEL_SCALE, EnemyMarvelScaleAbility
	dbw THICK_FAT, EnemyThickFatAbility
	dbw DRY_SKIN, EnemyDrySkinAbility
	dbw FUR_COAT, EnemyFurCoatAbility
	dbw -1, -1

TechnicianAbility:
	ld a, d
	cp 61
	ret nc
	ln a, 3, 2 ; x1.5
	jmp MultiplyAndDivide

HugePowerAbility:
; Doubles physical attack
	ld a, $21
	jmp ApplyPhysicalAttackDamageMod

HustleAbility:
; 150% physical attack, 80% accuracy (done elsewhere)
GorillaTacticsAbility:
; 150% physical attack, locks into one move (done elsewhere)
	ld a, $32
	jmp ApplyPhysicalAttackDamageMod

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
	ln a, 3, 2 ; x1.5
	jmp MultiplyAndDivide

RivalryAbility:
; 100% damage if either mon is genderless, 125% if same gender, 75% if opposite gender
	farcall CheckOppositeGender
	ret c
	ln a, 5, 4 ; x1.25
	jr z, .apply_damage_mod
	ln a, 3, 4 ; x0.75
.apply_damage_mod
	jmp MultiplyAndDivide

SheerForceAbility:
; 130% damage if a secondary effect is suppressed
	ld a, [wEffectFailed]
	and a
	ret z
	ln a, 13, 10 ; x1.3
	jmp MultiplyAndDivide

AnalyticAbility:
; 130% damage if opponent went first
	farcall GetFutureSightUser
	jr nc, .future_sight
	ld a, [wEnemyGoesFirst] ; 0 = player goes first
	ld b, a
	ldh a, [hBattleTurn] ; 0 = player's turn
	xor b ; nz if opponent went first
	ret z
.future_sight
	ln a, 13, 10 ; x1.3
	jmp MultiplyAndDivide

TintedLensAbility:
; Doubles damage for not very effective moves (x0.5/x0.25)
	ld a, [wTypeModifier]
	cp $10
	ret nc
	ln a, 2, 1 ; x2
	jmp MultiplyAndDivide

SolarPowerAbility:
; 150% special attack in sun, take 1/8 damage at turn end in sun (done elsewhere)
	call GetWeatherAfterUserUmbrella
	cp WEATHER_SUN
	ret nz
	ln a, 3, 2 ; x1.5
	jmp ApplySpecialAttackDamageMod

ToughClawsAbility:
	call CheckContactMove
	ret c
	ln a, 13, 10 ; x1.3
	jmp MultiplyAndDivide

MegaLauncherAbility:
	ld hl, LauncherMoves
	ln b, 3, 2 ; x1.5
	jr MoveBoostAbility

INCLUDE "data/moves/launcher_moves.asm"

IronFistAbility:
; 120% damage for punching moves
	ld hl, PunchingMoves
	ln b, 6, 5 ; x1.2
	jr MoveBoostAbility

INCLUDE "data/moves/punching_moves.asm"

MoveBoostAbility:
	ld a, BATTLE_VARS_MOVE
	call GetBattleVar
	push bc
	call IsInByteArray
	pop bc
	ret nc
	ld a, b
	jmp MultiplyAndDivide

SandForceAbility:
; 130% damage for Ground/Rock/Steel-type moves in a sandstorm, not hurt by Sandstorm
	call GetWeatherAfterUserUmbrella
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
	ln a, 13, 10 ; x1.3
	jmp MultiplyAndDivide

RecklessAbility:
; 120% damage for (Hi) Jump Kick and recoil moves except for Struggle
	ld a, BATTLE_VARS_MOVE
	call GetBattleVar
	inc a ; cp STRUGGLE
	ret z
	ld a, BATTLE_VARS_MOVE_EFFECT
	call GetBattleVar
	cp EFFECT_RECOIL_HIT
	jr z, .ok
	cp EFFECT_JUMP_KICK
	ret nz
.ok
	ln a, 6, 5 ; x1.2
	jmp MultiplyAndDivide

GutsAbility:
; 150% physical attack if user is statused
	farcall GetFutureSightUser
	jr z, .not_external
	ld a, MON_STATUS
	call TrueUserPartyAttr
	jr .got_status
.not_external
	ld a, BATTLE_VARS_STATUS
	call GetBattleVar
.got_status
	and a
	ret z
	ld a, $32
	jmp ApplyPhysicalAttackDamageMod

PixilateAbility:
	ld b, FAIRY
	jr AteAbilities
GalvanizeAbility:
	ld b, ELECTRIC
AteAbilities:
	ld a, BATTLE_VARS_MOVE_TYPE
	call GetBattleVarAddr
	ld a, [hl]
	and a ; cp NORMAL
	ret nz

	; change move type
	ld [hl], b
	ln a, 6, 5 ; x1.2
	jmp MultiplyAndDivide

EnemyMultiscaleAbility:
; 50% damage if user is at full HP
	farcall CheckOpponentFullHP
	ret nz
	ln a, 1, 2 ; x0.5
	jmp MultiplyAndDivide

EnemyMarvelScaleAbility:
; 150% physical Defense if statused
	ld a, BATTLE_VARS_STATUS_OPP
	call GetBattleVar
	and a
	ret z
	ld a, $23
	jmp ApplyPhysicalDefenseDamageMod

EnemySolidRockAbility:
EnemyFilterAbility:
; 75% damage for super effective moves
	ld a, [wTypeModifier]
	cp $11
	ret c
	ln a, 3, 4 ; x0.75
	jmp MultiplyAndDivide

EnemyThickFatAbility:
; 50% damage for Fire and Ice-type moves
	ld a, BATTLE_VARS_MOVE_TYPE
	call GetBattleVar
	cp FIRE
	jr z, .ok
	cp ICE
	ret nz
.ok
	ln a, 1, 2 ; x0.5
	jmp MultiplyAndDivide

EnemyDrySkinAbility:
; 125% damage for Fire-type moves, heals 1/4 from Water, regenerates 1/8 at end of turn in
; rain, takes 1/8 damage at end of turn in sun. This only handles Fire damage bonus, other
; stuff is elsewhere
	ld a, BATTLE_VARS_MOVE_TYPE
	call GetBattleVar
	cp FIRE
	ret nz
	ln a, 5, 4 ; x1.25
	jmp MultiplyAndDivide

EnemyFurCoatAbility:
; Doubles physical Defense
	ld a, $12
	jmp ApplyPhysicalDefenseDamageMod

HydrationAbility:
	call GetWeatherAfterUserUmbrella
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
	jmp HealStatusAbility

AngerPointAbility:
	call DisableAnimations
	ld b, $f0 | ATTACK
	ld a, STAT_SILENT | STAT_SKIPTEXT
	farcall _RaiseStat
	ld a, [wFailedMessage]
	and a
	jr nz, .done
	call ShowAbilityActivation
	ld hl, AngerPointMaximizedAttackText
	xor a
	farcall DoPrintStatChange
.done
	jmp EnableAnimations

RunSwitchAbilities:
; abilities that activate when you switch out
	call GetTrueUserAbility
	cp NATURAL_CURE
	jr z, NaturalCureAbility
	cp REGENERATOR
	ret nz
	; fallthrough
RegeneratorAbility:
	farcall CheckFullHP
	ret z
	call DisableAnimations
	call ShowAbilityActivation
	call GetThirdMaxHP
	farcall RestoreHP
	call EnableAnimations
	ldh a, [hBattleTurn]
	and a
	jmp z, UpdateBattleMonInParty
	jmp UpdateEnemyMonInParty

_GetOpponentAbilityAfterMoldBreaker::
; Returns an opponent's ability unless Mold Breaker
; will suppress it. Preserves bc/de/hl.
	push de
	push bc
	call GetOpponentAbility
	ld b, a
	call GetTrueUserAbility
	cp MOLD_BREAKER
	ld a, b
	jr nz, .end
	push hl
	push bc
	ld hl, MoldBreakerSuppressedAbilities
	call IsInByteArray
	pop bc
	pop hl
	ld a, b
	jr nc, .end
	xor a ; ld a, NO_ABILITY
.end
	pop bc
	pop de
	ret

INCLUDE "data/abilities/mold_breaker_suppressed_abilities.asm"

DisableAnimations:
	ld a, [wAnimationsDisabled]
	and a
	ret nz
	push hl
	push de
	push bc
	call LoadTileMapToTempTileMap
	pop bc
	pop de
	pop hl
	ld a, 1
	ld [wAnimationsDisabled], a
	ret

EnableAnimations:
	ld a, [wAnimationsDisabled]
	and a
	ret z
	call DismissAbilityOverlays
	xor a
	ld [wAnimationsDisabled], a
	ret

ShowEnemyAbilityActivation::
	call CallOpponentTurn
ShowAbilityActivation::
	push hl
	push de
	push bc
	ld a, BATTLE_VARS_ABILITY
	call GetBattleVar
	ld b, a
	call PerformAbilityGFX

	jmp PopBCDEHL

RunPostBattleAbilities::
; Checks party for potentially finding items (Pickup) or curing status (Natural Cure)
	; Ensure that ability slideouts appear for the correct side for Pickup.
	call SetPlayerTurn
	ld a, [wPartyCount]
	jr .first_pass
.loop
	ld a, [wCurPartyMon]
.first_pass
	dec a
	cp $ff
	ret z

	ld [wCurPartyMon], a

	ld a, MON_SPECIES
	call GetPartyParamLocation
	ld c, [hl]
	ld a, MON_IS_EGG
	call GetPartyParamLocation
	bit MON_IS_EGG_F, [hl]
	jr nz, .loop
	assert MON_PERSONALITY == MON_IS_EGG - 1
	dec hl

	call GetAbility
	ld a, b
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

	call DisableAnimations

	ld a, MON_LEVEL
	call GetPartyParamLocation
	ld a, [hl]
	call GetRandomPickupItem
	ld b, a
	ld a, MON_ITEM
	call GetPartyParamLocation
	ld a, b
	ld [hl], a
	push bc
	push de
	ld [wNamedObjectIndex], a
	call GetItemName
	ld hl, wStringBuffer1
	ld de, wStringBuffer2
	ld bc, ITEM_NAME_LENGTH
	rst CopyBytes
	pop de
	pop bc
	push bc
	push de
	ld a, MON_SPECIES
	call GetPartyParamLocation
	ld a, [hl]
	ld [wNamedObjectIndex], a
	call GetPokemonName
	ld hl, wStringBuffer1
	ld de, wBattleMonNickname
	ld bc, MON_NAME_LENGTH
	rst CopyBytes
	ld b, PICKUP
	call PerformAbilityGFX
	ld hl, BattleText_PickedUpItem
	call StdBattleTextbox
	pop de
	pop bc
	jmp EnableAnimations

GetRandomPickupItem::
	push de
	ld hl, BasePickupTable
	ld de, RarePickupTable
	ld b, a
	ld a, BANK(BasePickupTable) ; aka BANK(RarePickupTable)
	call GetScaledItemReward
	pop de
	ret

INCLUDE "data/items/pickup_items.asm"

GetScaledItemReward:
; Returns a scaled item reward from item tables in de (rare) and hl (base).
; The base table has 18 entries, the rare one 11.
; The rewards scale like pre-7gen (starting from Emerald) Pickup.
; a = bank of item tables
; b = level
; de = rare table
; hl = base table
	push de
	ld d, a
	ld a, b
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
	ld a, d
	pop de
	jr .ok

.rare:
; 2% of Pickup results use a different table with generally better items
	call Random
	cp 1 + 50 percent
	call c, .inc_bc
	ld a, d
	pop de
	ld h, d
	ld l, e
.ok:
	add hl, bc
	jmp GetFarByte

.inc_bc:
	inc bc
	ret

INCLUDE "engine/battle/ability_gfx.asm"
