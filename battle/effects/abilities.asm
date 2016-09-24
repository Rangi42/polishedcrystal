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
	cp DRIZZLE
	jp z, DrizzleAbility
	cp LIMBER ; if acquired
	jp z, LimberAbility
	cp CLOUD_NINE
	jp z, CloudNineAbility
	cp INSOMNIA ; if acquired
	jp z, InsomniaAbility
	cp IMMUNITY ; if acquired
	jp z, ImmunityAbility
	cp INTIMIDATE
	jp z, IntimidateAbility
	cp MAGMA_ARMOR ; if acquired
	jp z, MagmaArmorAbility
	cp WATER_VEIL ; if acquired
	jp z, WaterVeilAbility
	cp SAND_STREAM
	jp z, SandStreamAbility
	cp PRESSURE ; just prints a message
	jr nz, .skip_pressure
	ld hl, NotifyPressure
	call StdBattleTextBox
.skip_pressure
	cp SAND_STREAM
	jp z, SandStreamAbility
	cp DROUGHT
	jp z, DroughtAbility
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
	cp IMPOSTER
	jp z, ImposterAbility
	ret

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
	callab CalcEnemyStats
	ret
.is_player
	callab CalcPlayerStats
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
	ld a, 0
	call ShowAbilityActivation
	ld a, 5
	ld [WeatherCount], a
	ld a, b
	ld [Weather], a
	; handle swift swim, etc.
	push bc
	callab CalcPlayerStats
	callab CalcEnemyStats
	pop bc
	ld a, b
	cp WEATHER_RAIN
	jr z, .handlerain
	cp WEATHER_SUN
	jr z, .handlesun
	cp WEATHER_SANDSTORM
	jr z, .handlesandstorm
	; we're dealing with cloud nine
	ld a, 0
	ld [WeatherCount], a
	ld hl, BattleText_TheWeatherSubsided
	jp StdBattleTextBox
.handlerain
	ld de, RAIN_DANCE
	callab Call_PlayBattleAnim
	ld hl, DownpourText
	jp StdBattleTextBox
.handlesun
	ld de, SUNNY_DAY
	callab Call_PlayBattleAnim
	ld hl, SunGotBrightText
	jp StdBattleTextBox
.handlesandstorm
	ld de, SANDSTORM
	callab Call_PlayBattleAnim
	ld hl, SandstormBrewedText
	jp StdBattleTextBox

ImmunityAbility:
	ld a, PSN
	jr HealStatusAbility
WaterVeilAbility:
	ld a, BRN
	jr HealStatusAbility
MagmaArmorAbility:
	ld a, FRZ
	jr HealStatusAbility
LimberAbility:
	ld a, PAR
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
	ld a, 0
	call ShowAbilityActivation
	ld a, BATTLE_VARS_STATUS
	call GetBattleVarAddr
	xor a
	ld [hl], a
	ld a, [hBattleTurn]
	and a
	jr z, .is_player
	callab CalcEnemyStats
	ret
.is_player
	callab CalcPlayerStats
	ret

IntimidateAbility:
	ld a, 0
	call ShowAbilityActivation
	callab ResetMiss
	callab BattleCommand_AttackDown
	ret

DownloadAbility:
AnticipationAbility:
ForewarnAbility:
FriskAbility:
ImposterAbility:
	ld a, 0
	call ShowAbilityActivation
	ret

ShowAbilityActivation:
; I always liked BW2's ability sliding, but
; while replicating something similar would
; be cool, it would probably be major work
; for little gain. Preserves bc.
; a=0: turn user's ability, a=1: opponent's
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
