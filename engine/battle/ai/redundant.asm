AI_Redundant:
; Check if move effect c will fail because it's already been used.
; Return z if the move is a good choice.
; Return nz if the move is a bad choice.
	ld a, c
	ld de, 3
	ld hl, .Moves
	call IsInArray
	jp nc, .NotRedundant
	inc hl
	jp IndirectHL

.Moves:
	dbw EFFECT_DREAM_EATER,   .DreamEater
	dbw EFFECT_HEAL,          .Heal
	dbw EFFECT_ROAR,          .Roar
	dbw EFFECT_LIGHT_SCREEN,  .LightScreen
	dbw EFFECT_FOCUS_ENERGY,  .FocusEnergy
	dbw EFFECT_CONFUSE,       .Confuse
	dbw EFFECT_TRANSFORM,     .Transform
	dbw EFFECT_REFLECT,       .Reflect
	dbw EFFECT_SUBSTITUTE,    .Substitute
	dbw EFFECT_LEECH_SEED,    .LeechSeed
	dbw EFFECT_DISABLE,       .Disable
	dbw EFFECT_ENCORE,        .Encore
	dbw EFFECT_SLEEP_TALK,    .SleepTalk
	dbw EFFECT_MEAN_LOOK,     .MeanLook
	dbw EFFECT_SPIKES,        .Spikes
	dbw EFFECT_TOXIC_SPIKES,  .ToxicSpikes
	dbw EFFECT_FORESIGHT,     .Foresight
	dbw EFFECT_PERISH_SONG,   .PerishSong
	dbw EFFECT_SANDSTORM,     .Sandstorm
	dbw EFFECT_HAIL,          .Hail
	dbw EFFECT_ATTRACT,       .Attract
	dbw EFFECT_SAFEGUARD,     .Safeguard
	dbw EFFECT_RAIN_DANCE,    .RainDance
	dbw EFFECT_SUNNY_DAY,     .SunnyDay
	dbw EFFECT_TELEPORT,      .Teleport
	dbw EFFECT_HEALING_LIGHT, .HealingLight
	dbw EFFECT_SWAGGER,       .Swagger
	dbw EFFECT_FUTURE_SIGHT,  .FutureSight
	dbw EFFECT_BATON_PASS,    .BatonPass
	dbw EFFECT_ROOST,         .Roost
	dbw EFFECT_TRICK_ROOM,    .TrickRoom
	db -1

.Confuse:
	ld a, [wPlayerSubStatus3]
	bit SUBSTATUS_CONFUSED, a
	ret nz
	ld a, [wPlayerGuards]
	and GUARD_SAFEGUARD
	ret

.Disable:
	ld a, [wPlayerDisableCount]
	and a
	ret

.Encore:
	ld a, [wPlayerEncoreCount]
	and a
	ret

.FocusEnergy:
	ld a, [wEnemySubStatus4]
	bit SUBSTATUS_FOCUS_ENERGY, a
	ret

.Foresight:
	ld a, [wPlayerSubStatus1]
	bit SUBSTATUS_IDENTIFIED, a
	ret

.FutureSight:
	ld a, [wEnemyFutureSightCount]
	and a
	ret

.LeechSeed:
	ld a, [wPlayerSubStatus4]
	bit SUBSTATUS_LEECH_SEED, a
	ret

.LightScreen:
	ld a, [wEnemyScreens]
	and SCREENS_LIGHT_SCREEN
	ret

.MeanLook:
	ld a, [wEnemySubStatus2]
	bit SUBSTATUS_CANT_RUN, a
	ret

.PerishSong:
	ld a, [wPlayerPerishCount]
	and a
	ret

.Reflect:
	ld a, [wEnemyScreens]
	and SCREENS_REFLECT
	ret

.BatonPass:
	call CallOpponentTurn
.Roar:
	push hl
	push de
	push bc
	farcall CheckAnyOtherAliveOpponentMons
	pop bc
	pop de
	pop hl
	jr .InvertZero

.Safeguard:
	ld a, [wEnemyGuards]
	and GUARD_SAFEGUARD
	ret

.Substitute:
	ld a, [wEnemySubStatus4]
	bit SUBSTATUS_SUBSTITUTE, a
	ret

.Swagger:
	ld a, [wPlayerSubStatus3]
	bit SUBSTATUS_CONFUSED, a
	ret

.Transform:
	ld a, [wEnemySubStatus2]
	bit SUBSTATUS_TRANSFORMED, a
	ret

.SleepTalk:
	ld a, [wEnemyMonStatus]
	and SLP
	jr .InvertZero

.Spikes:
	ld a, [wPlayerHazards]
	and HAZARDS_SPIKES
	cp HAZARDS_SPIKES
	jr .InvertZero

.ToxicSpikes:
	ld a, [wPlayerHazards]
	and HAZARDS_TOXIC_SPIKES
	cp (HAZARDS_TOXIC_SPIKES / 3) * 2
	jr .InvertZero

.Sandstorm:
	ld a, [wBattleWeather]
	cp WEATHER_SANDSTORM
	jr .InvertZero

.Hail:
	ld a, [wBattleWeather]
	cp WEATHER_HAIL
	jr .InvertZero

.Attract:
	farcall CheckOppositeGender
	jr c, .Redundant
	jr z, .Redundant
	ld a, [wPlayerSubStatus1]
	bit SUBSTATUS_IN_LOVE, a
	ret

.RainDance:
	ld a, [wBattleWeather]
	cp WEATHER_RAIN
	jr .InvertZero

.SunnyDay:
	ld a, [wBattleWeather]
	cp WEATHER_SUN
	jr .InvertZero

.DreamEater:
	ld a, [wBattleMonStatus]
	and SLP
	; fallthrough
.InvertZero:
	jr z, .Redundant
.NotRedundant:
	xor a
	ret

.TrickRoom:
	; normally this kind of logic is relegated to smart AI, but since this move
	; never fails, we need to avoid the AI spamming it because it doesn't
	; understand how it works...
	farcall AICompareSpeed
	jr c, .Redundant
	jr .NotRedundant

.Heal:
.HealingLight:
.Roost:
	farcall AICheckEnemyMaxHP
	jr nc, .NotRedundant

.Teleport:
.Redundant:
	ld a, 1
	and a
	ret
