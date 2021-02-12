AIScoring:

AI_Basic:
; Don't do anything redundant:
;  -Using status-only moves if the player can't be statused
;  -Using moves that fail if they've already been used

	ld hl, wAIMoveScore - 1
	ld de, wAIMoves
	ld b, NUM_MOVES + 1
.checkmove
	dec b
	ret z

	inc hl
	ld a, [de]
	and a
	ret z

	inc de
	call AIGetEnemyMove

	ld a, [wEnemyMoveStruct + MOVE_EFFECT]
	ld c, a

; Dismiss moves with special effects if they are
; useless or not a good choice right now.
; For example, healing moves, weather moves, Dream Eater...
	push hl
	push de
	push bc
	farcall AI_Redundant
	pop bc
	pop de
	pop hl
	jr nz, .discourage

; Dismiss status-only moves if the player can't be statused.
	ld a, [wEnemyMoveStruct + MOVE_EFFECT]
	push hl
	push de
	push bc
	ld hl, .statusonlyeffects
	ld de, 1
	call IsInArray

	pop bc
	pop de
	pop hl
	jr nc, .checkmove

	ld a, [wBattleMonStatus]
	and a
	jr nz, .discourage

; Dismiss Safeguard if it's already active.
	ld a, [wPlayerGuards]
	and GUARD_SAFEGUARD
	jr z, .checkmove

.discourage
	call AIDiscourageMove
	jr .checkmove

.statusonlyeffects
	db EFFECT_SLEEP
	db EFFECT_TOXIC
	db EFFECT_POISON
	db EFFECT_PARALYZE
	db EFFECT_BURN
	db EFFECT_FREEZE
	db $ff

AI_Conversion:
; not a layer, called by Conversion to allow the AI to select a good move type
; TODO: implement
	call BattleRandom
	and %11
	ret

AI_Setup:
; Use stat-modifying moves on turn 1.

; 50% chance to greatly encourage stat-up moves during the first turn of enemy's Pokemon.
; 50% chance to greatly encourage stat-down moves during the first turn of player's Pokemon.
; Almost 90% chance to greatly discourage stat-modifying moves otherwise.

	ld hl, wAIMoveScore - 1
	ld de, wAIMoves
	ld b, NUM_MOVES + 1
.checkmove
	dec b
	ret z

	inc hl
	ld a, [de]
	and a
	ret z

	inc de
	call AIGetEnemyMove

	ld a, [wEnemyMoveStruct + MOVE_EFFECT]

	cp EFFECT_CURSE
	jr nz, .not_curse
	call CheckIfUserIsGhostType
	jr nz, .checkmove
	jr .statup

.not_curse
	cp EFFECT_ATTACK_UP
	jr c, .checkmove
	cp EFFECT_ATTACK_DOWN
	jr c, .statup
	cp EFFECT_EVASION_DOWN_2 + 1
	jr nc, .checkmove

	; stat-down move
	ld a, [wPlayerTurnsTaken]
	and a
	jr nz, .discourage
	jr .encourage

.statup
	ld a, [wEnemyTurnsTaken]
	and a
	jr nz, .discourage

.encourage
	call AI_50_50
	jr c, .checkmove

	dec [hl]
	dec [hl]
	jr .checkmove

.discourage
	call Random
	cp 30
	jr c, .checkmove
	inc [hl]
	inc [hl]
	jr .checkmove

AI_Types:
; Dismiss any move that the player is immune to.
; Encourage super effective moves.
; Discourage not very effective moves unless
; all damaging moves are of the same type.
; Overridden by the "Aggressive" AI layer
	ld hl, wAIMoveScore - 1
	ld de, wAIMoves
	ld b, NUM_MOVES + 1
.checkmove
	dec b
	ret z

	inc hl
	ld a, [de]
	and a
	ret z

	inc de
	call AIGetEnemyMove

	push hl
	push bc
	push de
	ld a, 1
	ldh [hBattleTurn], a
	farcall BattleCheckTypeMatchup
	pop de
	pop bc
	pop hl

	ld a, [wd265]
	and a
	jr z, .immune

	ld a, [wEnemyMoveStruct + MOVE_EFFECT]
	call AI_IsFixedDamageMove
	jr c, .checkmove

	ld a, [wd265]
	cp $10 ; 1.0
	jr z, .checkmove
	jr c, .noteffective

; effective
	ld a, [wEnemyMoveStruct + MOVE_POWER]
	and a
	jr z, .checkmove
	dec [hl]
	jr .checkmove

.noteffective
; Discourage this move if there are any moves
; that do damage of a different type.
	push hl
	push de
	push bc
	ld a, [wEnemyMoveStruct + MOVE_TYPE]
	ld d, a
	ld hl, wAIMoves
	lb bc, (NUM_MOVES + 1), 0
.checkmove2
	dec b
	jr z, .asm_38693

	ld a, [hli]
	and a
	jr z, .asm_38693

	call AIGetEnemyMove
	ld a, [wEnemyMoveStruct + MOVE_TYPE]
	cp d
	jr z, .checkmove2
	ld a, [wEnemyMoveStruct + MOVE_POWER]
	and a
	jr z, .checkmove2
	ld c, a

.asm_38693
	ld a, c
	pop bc
	pop de
	pop hl
	and a
	jr z, .checkmove
	inc [hl]
	jr .checkmove

.immune
	call AIDiscourageMove
	jr .checkmove

AI_IsFixedDamageMove:
; Returns c if move effect a does fixed damage (or is Counter/Mirror Coat)
	push hl
	push de
	push bc
	ld de, 1
	ld hl, .FixedDamageMoves
	call IsInArray
	jp PopBCDEHL

.FixedDamageMoves:
	db EFFECT_COUNTER
	db EFFECT_MIRROR_COAT
	db EFFECT_STATIC_DAMAGE
	db EFFECT_LEVEL_DAMAGE
	db EFFECT_SUPER_FANG
	db -1

AI_Offensive:
; Greatly discourage non-damaging moves.

	ld hl, wAIMoveScore - 1
	ld de, wAIMoves
	ld b, NUM_MOVES + 1
.checkmove
	dec b
	ret z

	inc hl
	ld a, [de]
	and a
	ret z

	inc de
	call AIGetEnemyMove

	ld a, [wEnemyMoveStruct + MOVE_POWER]
	and a
	jr nz, .checkmove

	inc [hl]
	inc [hl]
	jr .checkmove

AI_Smart:
; Context-specific scoring.

	ld hl, wAIMoveScore
	ld de, wAIMoves
	ld b, NUM_MOVES + 1
.checkmove
	dec b
	ret z

	ld a, [de]
	inc de
	and a
	ret z

	push de
	push bc
	push hl
	call AIGetEnemyMove

	ld a, [wEnemyMoveStruct + MOVE_EFFECT]
	ld hl, .smart_ai_table
	ld de, 3
	call IsInArray

	inc hl
	jr nc, .nextmove

	ld a, [hli]
	ld e, a
	ld d, [hl]

	pop hl
	push hl

	ld bc, .nextmove
	push bc

	push de
	ret

.nextmove
	pop hl
	pop bc
	pop de
	inc hl
	jr .checkmove

.smart_ai_table
	dbw EFFECT_SLEEP,             AI_Smart_Sleep
	dbw EFFECT_LEECH_HIT,         AI_Smart_LeechHit
	dbw EFFECT_EXPLOSION,         AI_Smart_Explosion
	dbw EFFECT_DREAM_EATER,       AI_Smart_DreamEater
	dbw EFFECT_EVASION_UP,        AI_Smart_EvasionUp
	dbw EFFECT_ALWAYS_HIT,        AI_Smart_AlwaysHit
	dbw EFFECT_ACCURACY_DOWN,     AI_Smart_AccuracyDown
	dbw EFFECT_HAZE,              AI_Smart_Haze
	dbw EFFECT_ROAR,              AI_Smart_Roar
	dbw EFFECT_HEAL,              AI_Smart_Heal
	dbw EFFECT_TOXIC,             AI_Smart_Toxic
	dbw EFFECT_LIGHT_SCREEN,      AI_Smart_LightScreen
	dbw EFFECT_TRAP,              AI_Smart_Bind
	dbw EFFECT_CONFUSE,           AI_Smart_Confuse
	dbw EFFECT_SP_DEF_UP_2,       AI_Smart_SpDefenseUp2
	dbw EFFECT_REFLECT,           AI_Smart_Reflect
	dbw EFFECT_PARALYZE,          AI_Smart_Paralyze
	dbw EFFECT_SPEED_DOWN_HIT,    AI_Smart_SpeedDownHit
	dbw EFFECT_SUBSTITUTE,        AI_Smart_Substitute
	dbw EFFECT_HYPER_BEAM,        AI_Smart_HyperBeam
	dbw EFFECT_RAGE,              AI_Smart_Rage
	dbw EFFECT_LEECH_SEED,        AI_Smart_LeechSeed
	dbw EFFECT_DISABLE,           AI_Smart_Disable
	dbw EFFECT_COUNTER,           AI_Smart_Counter
	dbw EFFECT_ENCORE,            AI_Smart_Encore
	dbw EFFECT_PAIN_SPLIT,        AI_Smart_PainSplit
	dbw EFFECT_SLEEP_TALK,        AI_Smart_SleepTalk
	dbw EFFECT_DESTINY_BOND,      AI_Smart_DestinyBond
	dbw EFFECT_HEAL_BELL,         AI_Smart_HealBell
	dbw EFFECT_PRIORITY_HIT,      AI_Smart_PriorityHit
	dbw EFFECT_MEAN_LOOK,         AI_Smart_MeanLook
	dbw EFFECT_FLARE_BLITZ,       AI_Smart_Defrost
	dbw EFFECT_SACRED_FIRE,       AI_Smart_Defrost
	dbw EFFECT_CURSE,             AI_Smart_Curse
	dbw EFFECT_PROTECT,           AI_Smart_Protect
	dbw EFFECT_FORESIGHT,         AI_Smart_Foresight
	dbw EFFECT_PERISH_SONG,       AI_Smart_PerishSong
	dbw EFFECT_ENDURE,            AI_Smart_Endure
	dbw EFFECT_ROLLOUT,           AI_Smart_Rollout
	dbw EFFECT_SWAGGER,           AI_Smart_Swagger
	dbw EFFECT_ATTRACT,           AI_Smart_Attract
	dbw EFFECT_SAFEGUARD,         AI_Smart_Safeguard
	dbw EFFECT_MAGNITUDE,         AI_Smart_Magnitude
	dbw EFFECT_BATON_PASS,        AI_Smart_BatonPass
	dbw EFFECT_PURSUIT,           AI_Smart_Pursuit
	dbw EFFECT_RAPID_SPIN,        AI_Smart_RapidSpin
	dbw EFFECT_HEALING_LIGHT,     AI_Smart_HealingLight
	dbw EFFECT_RAIN_DANCE,        AI_Smart_RainDance
	dbw EFFECT_SUNNY_DAY,         AI_Smart_SunnyDay
	dbw EFFECT_SANDSTORM,         AI_Smart_Sandstorm
	dbw EFFECT_HAIL,              AI_Smart_Hail
	dbw EFFECT_BELLY_DRUM,        AI_Smart_BellyDrum
	dbw EFFECT_MIRROR_COAT,       AI_Smart_MirrorCoat
	dbw EFFECT_EARTHQUAKE,        AI_Smart_Earthquake
	dbw EFFECT_FUTURE_SIGHT,      AI_Smart_FutureSight
	dbw EFFECT_GUST,              AI_Smart_Gust
	dbw EFFECT_STOMP,             AI_Smart_Stomp
	dbw EFFECT_BODY_SLAM,         AI_Smart_Stomp
	dbw EFFECT_SOLAR_BEAM,        AI_Smart_SolarBeam
	dbw EFFECT_THUNDER,           AI_Smart_Thunder
	dbw EFFECT_FLY,               AI_Smart_Fly
	dbw EFFECT_ROOST,             AI_Smart_Roost
	dbw EFFECT_TRICK_ROOM,        AI_Smart_TrickRoom
	db $ff

AI_Smart_Sleep:
; Greatly encourage sleep inducing moves if the enemy has Dream Eater.
; 50% chance to greatly encourage sleep inducing moves otherwise.

	ld b, EFFECT_DREAM_EATER
	call AIHasMoveEffect
	ret nc

	call AI_50_50
	ret c
	dec [hl]
	dec [hl]
	ret

AI_Smart_LeechHit:
	push hl
	ld a, 1
	ldh [hBattleTurn], a
	farcall BattleCheckTypeMatchup
	pop hl

; 60% chance to discourage this move if not very effective.
	ld a, [wd265]
	cp 10 ; 1.0
	jr c, .asm_38815

; Do nothing if effectiveness is neutral.
	ret z

; Do nothing if enemy's HP is full.
	call AICheckEnemyMaxHP
	ret c

; 80% chance to encourage this move otherwise.
	call AI_80_20
	ret c

	dec [hl]
	ret

.asm_38815
	call Random
	cp 100
	ret c

	inc [hl]
	ret

AI_Smart_Explosion:
; Explosion
	; If opponent only has 1 mon left
	push hl
	farcall CheckAnyOtherAliveEnemyMons
	pop hl
	jr nz, .asm_388b7

	; Then discourage the move unless the player also has 1 mon left
	push hl
	call AICheckLastPlayerMon
	pop hl
	jr nz, .asm_388c6

.asm_388b7
	; Discourage if healthy (50%+)
	call AICheckEnemyHalfHP
	jr c, .asm_388c6

	; If <25%, don't discourage
	call AICheckEnemyQuarterHP
	ret nc

	; If 25-50%, probably discourage (236/256 of the time)
	call Random
	cp 20
	ret c

.asm_388c6
	inc [hl]
	inc [hl]
	inc [hl]
	ret

AI_Smart_DreamEater:
; 90% chance to greatly encourage this move.
; The AI_Basic layer will make sure that
; Dream Eater is only used against sleeping targets.
	call Random
	cp 25
	ret c
	dec [hl]
	dec [hl]
	dec [hl]
	ret

AI_Smart_EvasionUp:

; Dismiss this move if enemy's evasion can't raise anymore.
	ld a, [wEnemyEvaLevel]
	cp $d
	jp nc, AIDiscourageMove

; If enemy's HP is full...
	call AICheckEnemyMaxHP
	jr nc, .asm_388f2

; ...greatly encourage this move if player is badly poisoned.
	ld a, [wBattleMonStatus]
	bit TOX, a
	jr nz, .asm_388ef

; ...70% chance to greatly encourage this move if player is not badly poisoned.
	call Random
	cp $b2
	jr nc, .asm_38911

.asm_388ef
	dec [hl]
	dec [hl]
	ret

.asm_388f2

; Greatly discourage this move if enemy's HP is below 25%.
	call AICheckEnemyQuarterHP
	jr nc, .asm_3890f

; If enemy's HP is above 25% but not full, 4% chance to greatly encourage this move.
	call Random
	cp $a
	jr c, .asm_388ef

; If enemy's HP is between 25% and 50%,...
	call AICheckEnemyHalfHP
	jr nc, .asm_3890a

; If enemy's HP is above 50% but not full, 20% chance to greatly encourage this move.
	call AI_80_20
	jr c, .asm_388ef
	jr .asm_38911

.asm_3890a
; ...50% chance to greatly discourage this move.
	call AI_50_50
	jr c, .asm_38911

.asm_3890f
	inc [hl]
	inc [hl]

; 30% chance to end up here if enemy's HP is full and player is not badly poisoned.
; 77% chance to end up here if enemy's HP is above 50% but not full.
; 96% chance to end up here if enemy's HP is between 25% and 50%.
; 100% chance to end up here if enemy's HP is below 25%.
; In other words, we only end up here if the move has not been encouraged or dismissed.
.asm_38911
	ld a, [wBattleMonStatus]
	bit TOX, a
	jr nz, .asm_38938

	ld a, [wPlayerSubStatus4]
	bit SUBSTATUS_LEECH_SEED, a
	jr nz, .asm_38941

; Discourage this move if enemy's evasion level is higher than player's accuracy level.
	ld a, [wEnemyEvaLevel]
	ld b, a
	ld a, [wPlayerAccLevel]
	cp b
	jr c, .asm_38936

; Greatly encourage this move if the player is in the middle of Rollout.
	ld a, [wPlayerSubStatus3]
	bit SUBSTATUS_ROLLOUT, a
	jr nz, .asm_388ef

.asm_38936
	inc [hl]
	ret

; Player is badly poisoned.
; 80% chance to greatly encourage this move.
; This would counter any previous discouragement.
.asm_38938
	call Random
	cp $50
	ret c
	dec [hl]
	dec [hl]
	ret

; Player is seeded.
; 50% chance to encourage this move.
; This would partly counter any previous discouragement.
.asm_38941
	call AI_50_50
	ret c

	dec [hl]
	ret

AI_Smart_AlwaysHit:
; 80% chance to greatly encourage this move if either...

; ...enemy's accuracy level has been lowered three or more stages
	ld a, [wEnemyAccLevel]
	cp $5
	jr c, .asm_38954

; ...or player's evasion level has been raised three or more stages.
	ld a, [wPlayerEvaLevel]
	cp $a
	ret c

.asm_38954
	call AI_80_20
	ret c

	dec [hl]
	dec [hl]
	ret

AI_Smart_AccuracyDown:

; If player's HP is full...
	call AICheckPlayerMaxHP
	jr nc, .asm_389a0

; ...and enemy's HP is above 50%...
	call AICheckEnemyHalfHP
	jr nc, .asm_389a0

; ...greatly encourage this move if player is badly poisoned.
	ld a, [wBattleMonStatus]
	bit TOX, a
	jr nz, .asm_3899d

; ...70% chance to greatly encourage this move if player is not badly poisoned.
	call Random
	cp $b2
	jr nc, .asm_389bf

.asm_3899d
	dec [hl]
	dec [hl]
	ret

.asm_389a0

; Greatly discourage this move if player's HP is below 25%.
	call AICheckPlayerQuarterHP
	jr nc, .asm_389bd

; If player's HP is above 25% but not full, 4% chance to greatly encourage this move.
	call Random
	cp $a
	jr c, .asm_3899d

; If player's HP is between 25% and 50%,...
	call AICheckPlayerHalfHP
	jr nc, .asm_389b8

; If player's HP is above 50% but not full, 20% chance to greatly encourage this move.
	call AI_80_20
	jr c, .asm_3899d
	jr .asm_389bf

; ...50% chance to greatly discourage this move.
.asm_389b8
	call AI_50_50
	jr c, .asm_389bf

.asm_389bd
	inc [hl]
	inc [hl]

; We only end up here if the move has not been already encouraged.
.asm_389bf
	ld a, [wBattleMonStatus]
	bit TOX, a
	jr nz, .asm_389e6

	ld a, [wPlayerSubStatus4]
	bit SUBSTATUS_LEECH_SEED, a
	jr nz, .asm_389ef

; Discourage this move if enemy's evasion level is higher than player's accuracy level.
	ld a, [wEnemyEvaLevel]
	ld b, a
	ld a, [wPlayerAccLevel]
	cp b
	jr c, .asm_389e4

; Greatly encourage this move if the player is in the middle of Rollout.
	ld a, [wPlayerSubStatus3]
	bit SUBSTATUS_ROLLOUT, a
	jr nz, .asm_3899d

.asm_389e4
	inc [hl]
	ret

; Player is badly poisoned.
; 80% chance to greatly encourage this move.
; This would counter any previous discouragement.
.asm_389e6
	call Random
	cp $50
	ret c
	dec [hl]
	dec [hl]
	ret

; Player is seeded.
; 50% chance to encourage this move.
; This would partly counter any previous discouragement.
.asm_389ef
	call AI_50_50
	ret c

	dec [hl]
	ret

AI_Smart_Haze:

; 85% chance to encourage this move if any of enemy's stat levels is lower than -2.
	push hl
	ld hl, wEnemyAtkLevel
	ld c, $8
.asm_389fb
	dec c
	jr z, .asm_38a05
	ld a, [hli]
	cp $5
	jr c, .asm_38a12
	jr .asm_389fb

; 85% chance to encourage this move if any of player's stat levels is higher than +2.
.asm_38a05
	ld hl, wPlayerAtkLevel
	ld c, $8
.asm_38a0a
	dec c
	jr z, .asm_38a1b
	ld a, [hli]
	cp $a
	jr c, .asm_38a0a

.asm_38a12
	pop hl
	call Random
	cp $28
	ret c
	dec [hl]
	ret

; Discourage this move if neither:
; Any of enemy's stat levels is	lower than -2.
; Any of player's stat levels is higher than +2.
.asm_38a1b
	pop hl
	inc [hl]
	ret

AI_Smart_Roar:
; Discourage this move if the player has not shown
; a super effective move against the enemy.
; Consider player's type(s) if its moves are unknown.

	push hl
	farcall CheckPlayerMoveTypeMatchups
	ld a, [wEnemyAISwitchScore]
	cp 10 ; neutral
	pop hl
	ret c
	inc [hl]
	ret

AI_Smart_HealingLight:
; use healing scoring, then -1 in sun, +2 in other weather
	call AI_Smart_Heal

	call GetWeatherAfterUserUmbrella
	and a
	ret z
	dec [hl]
	cp WEATHER_SUN
	ret z
	inc [hl]
	inc [hl]
	ret

AI_Smart_Heal:
AI_Smart_Roost:
; Score the move as follows (lower is better):
; <33%: -2
; 33-50%: -1
; 50-66%: +0
; >66%: +2
	dec [hl]
	call CheckPinch
	jr nz, .no_pinch
	dec [hl]
	ret

.no_pinch
	push hl
	call GetHalfMaxHP
	call CompareHP
	pop hl
	ret c
	inc [hl]
	push hl
	call GetThirdMaxHP
	sla c
	rl b
	call CompareHP
	pop hl
	ret c
	inc [hl]
	inc [hl]
	ret

AI_Smart_Toxic:
AI_Smart_LeechSeed:
; Discourage this move if player's HP is below 50%.

	call AICheckPlayerHalfHP
	ret c
	inc [hl]
	ret

AI_Smart_LightScreen:
AI_Smart_Reflect:
; Over 90% chance to discourage this move unless enemy's HP is full.

	call AICheckEnemyMaxHP
	ret c
	call Random
	cp $14
	ret c
	inc [hl]
	ret

AI_Smart_Bind:
; Wrap, Fire Spin, Whirlpool

	; 50% chance to discourage this move if already trapper or can't trap
	ld a, [wPlayerWrapCount]
	and a
	jr nz, .coinflip_discourage
	call CheckIfTargetIsGhostType
	jr z, .coinflip_discourage

	; 50% chance to greatly encourage this move if player is either
	; badly poisoned, in love, identified, or stuck in Rollout, or first turn.
	; Don't encourage it if we're at low HP.
	ld a, [wBattleMonStatus]
	bit TOX, a
	jr nz, .coinflip_encourage

	ld a, [wPlayerSubStatus1]
	and 1<<SUBSTATUS_IN_LOVE | 1<<SUBSTATUS_IDENTIFIED
	jr nz, .coinflip_encourage
	ld a, [wPlayerSubStatus3]
	and 1<<SUBSTATUS_ROLLOUT
	jr nz, .coinflip_encourage
	ld a, [wPlayerTurnsTaken]
	and a
	jr z, .coinflip_encourage

.coinflip_discourage
	call AI_50_50
	ret c
	inc [hl]
	ret

.coinflip_encourage
	call AICheckEnemyQuarterHP
	ret nc
	call AI_50_50
	ret c
	dec [hl]
	dec [hl]
	ret

AI_Smart_Confuse:

; 90% chance to discourage this move if player's HP is between 25% and 50%.
	call AICheckPlayerHalfHP
	ret c
	call Random
	cp $19
	jr c, .asm_38ae7
	inc [hl]

.asm_38ae7
; Discourage again if player's HP is below 25%.
	call AICheckPlayerQuarterHP
	ret c
	inc [hl]
	ret

AI_Smart_SpDefenseUp2:

; Discourage this move if enemy's HP is lower than 50%.
	call AICheckEnemyHalfHP
	jr nc, .asm_38b10

; Discourage this move if enemy's special defense level is higher than +3.
	ld a, [wEnemySDefLevel]
	cp $b
	jr nc, .asm_38b10

; 80% chance to greatly encourage this move if
; enemy's Special Defense level is lower than +2.
	cp $9
	ret nc

.asm_38b09
	call AI_80_20
	ret c
	dec [hl]
	dec [hl]
	ret

.asm_38b10
	inc [hl]
	ret

AI_Smart_Fly:
; Fly, Dig

; Greatly encourage this move if the player is
; flying or underground, and slower than the enemy.

	ld a, [wPlayerSubStatus3]
	and 1 << SUBSTATUS_FLYING | 1 << SUBSTATUS_UNDERGROUND
	ret z

	call AICompareSpeed
	ret nc

	dec [hl]
	dec [hl]
	dec [hl]
	ret

AI_Smart_TrickRoom:
; Greatly encourage this move if it would make us outspeed, discourage otherwise
	call AICompareSpeed
	jp c, AIDiscourageMove

	; Avoid obvious PP stall by only encouraging the move if setting TR up
	ld a, [wTrickRoom]
	and a
	ret nz

	dec [hl]
	dec [hl]
	dec [hl]
	ret

AI_Smart_Paralyze:

; 50% chance to discourage this move if player's HP is below 25%.
	call AICheckPlayerQuarterHP
	jr nc, .asm_38b3a

; 80% chance to greatly encourage this move
; if enemy is slower than player and its HP is above 25%.
	call AICompareSpeed
	ret c
	call AICheckEnemyQuarterHP
	ret nc
	call AI_80_20
	ret c
	dec [hl]
	dec [hl]
	ret

.asm_38b3a
	call AI_50_50
	ret c
	inc [hl]
	ret

AI_Smart_SpeedDownHit:
; Icy Wind

; Almost 90% chance to greatly encourage this move if the following conditions all meet:
; Enemy's HP is higher than 25%.
; It's the first turn of player's Pokemon.
; Player is faster than enemy.

	ld a, [wEnemyMoveStruct + MOVE_ANIM]
	cp ICY_WIND
	ret nz
	call AICheckEnemyQuarterHP
	ret nc
	ld a, [wPlayerTurnsTaken]
	and a
	ret nz
	call AICompareSpeed
	ret c
	call Random
	cp 30
	ret c
	dec [hl]
	dec [hl]
	ret

AI_Smart_Substitute:
; Dismiss this move if enemy's HP is below 50%.

	call AICheckEnemyHalfHP
	ret c
	jp AIDiscourageMove

AI_Smart_HyperBeam:
	call AICheckEnemyHalfHP
	jr c, .asm_38b72

; 50% chance to encourage this move if enemy's HP is below 25%.
	call AICheckEnemyQuarterHP
	ret c
	call AI_50_50
	ret c
	dec [hl]
	ret

.asm_38b72
; If enemy's HP is above 50%, discourage this move at random
	call Random
	cp 40
	ret c
	inc [hl]
	call AI_50_50
	ret c
	inc [hl]
	ret

AI_Smart_Rage:
	ld a, [wEnemySubStatus4]
	bit SUBSTATUS_RAGE, a
	jr z, .asm_38b9b

; If enemy's Rage is building, 50% chance to encourage this move.
	call AI_50_50
	ret c

	dec [hl]
	ret

.asm_38b9b
; If enemy's Rage is not building, discourage this move if enemy's HP is below 50%.
	call AICheckEnemyHalfHP
	jr nc, .asm_38ba6

; 50% chance to encourage this move otherwise.
	call AI_80_20
	ret nc
	dec [hl]
	ret

.asm_38ba6
	inc [hl]
	ret

AI_Smart_Counter:
	push hl
	ld hl, wPlayerUsedMoves
	lb bc, 0, 4

.loop
	ld a, [hli]
	and a
	jr z, .next

	call AIGetEnemyMove

	ld a, [wEnemyMoveStruct + MOVE_POWER]
	and a
	jr z, .next

	ld a, [wEnemyMoveStruct + MOVE_CATEGORY]
	cp SPECIAL
	jr nc, .next

	inc b

.next
	dec c
	jr nz, .loop

	pop hl
	ld a, b
	and a
	jr z, .none

	cp $3
	jr nc, .all

	ld a, [wPlayerSelectedMove]
	and a
	ret z

	call AIGetEnemyMove

	ld a, [wEnemyMoveStruct + MOVE_POWER]
	and a
	ret z

	ld a, [wEnemyMoveStruct + MOVE_CATEGORY]
	cp SPECIAL
	ret nc

.all
	call Random
	cp 100
	ret c

	dec [hl]
	ret

.none
	inc [hl]
	ret

AI_Smart_Encore:
	call AICompareSpeed
	jr nc, .asm_38c81

	ld a, [wLastPlayerMove]
	and a
	jp z, AIDiscourageMove

	call AIGetEnemyMove

	ld a, [wEnemyMoveStruct + MOVE_POWER]
	and a
	jr z, .asm_38c68

	push hl
	call SetPlayerTurn
	farcall BattleCheckTypeMatchup
	call SetEnemyTurn

	pop hl
	ld a, [wd265]
	cp $a
	jr nc, .asm_38c68

	and a
	ret nz
	jr .asm_38c78

.asm_38c68
	push hl
	ld a, [wPlayerSelectedMove]
	ld hl, .EncoreMoves
	ld de, 1
	call IsInArray
	pop hl
	jr nc, .asm_38c81

.asm_38c78
	call Random
	cp $46
	ret c
	dec [hl]
	dec [hl]
	ret

.asm_38c81
	inc [hl]
	inc [hl]
	inc [hl]
	ret

.EncoreMoves:
	db AGILITY
	db CONVERSION
	db DISABLE
	db DREAM_EATER
	db FOCUS_ENERGY
	db GROWTH
	db HAZE
	db HONE_CLAWS
	db LEECH_SEED
	db LEER
	db POISONPOWDER
	db ROAR
	db SCREECH
	db SKILL_SWAP
	db SPLASH
	db STRING_SHOT
	db SUBSTITUTE
	db SUPER_FANG
	db SWORDS_DANCE
	db TELEPORT
	db TRICK
	db $ff

AI_Smart_PainSplit:
; Discourage this move if [enemy's current HP * 2 > player's current HP].

	push hl
	ld hl, wEnemyMonHP
	ld b, [hl]
	inc hl
	ld c, [hl]
	sla c
	rl b
	ld hl, wBattleMonHP + 1
	ld a, [hld]
	cp c
	ld a, [hl]
	sbc b
	pop hl
	ret nc
	inc [hl]
	ret

AI_Smart_SleepTalk:
; Greatly encourage this move if enemy is fast asleep.
; Greatly discourage this move otherwise.
; TODO: sleep talk is typically used with rest, but we shouldn't
; know how long we sleep for if it's randomly 1-3 turns...
	call GetTrueUserAbility
	cp EARLY_BIRD
	ld b, 3
	jr z, .got_wakeup_time
	dec b
.got_wakeup_time
	ld a, [wEnemyMonStatus]
	and $7
	cp b
	jp c, AIDiscourageMove

	; encourage it a ton to override everything else
	ld a, [hl]
	sub 10
	ld [hl], a
	ret

AI_Smart_DestinyBond:
; Discourage this move if enemy's HP is above 25%.

	call AICheckEnemyQuarterHP
	ret nc
	inc [hl]
	ret

AI_Smart_HealBell:
; Dismiss this move if none of the opponent's Pokemon is statused.
; Encourage this move if the enemy is statused.
; 50% chance to greatly encourage this move if the enemy is fast asleep or frozen.

	push hl
	ld a, [wOTPartyCount]
	ld b, a
	ld c, 0
	ld hl, wOTPartyMon1HP
	ld de, PARTYMON_STRUCT_LENGTH

.loop
	push hl
	ld a, [hli]
	or [hl]
	jr z, .next

	; status
	dec hl
	dec hl
	dec hl
	ld a, [hl]
	or c
	ld c, a

.next
	pop hl
	add hl, de
	dec b
	jr nz, .loop

	pop hl
	ld a, c
	and a
	jr z, .no_status

	ld a, [wEnemyMonStatus]
	and a
	jr z, .ok
	dec [hl]
.ok
	and 1 << FRZ | SLP
	ret z
	call AI_50_50
	ret c
	dec [hl]
	dec [hl]
	ret

.no_status
	ld a, [wEnemyMonStatus]
	and a
	ret nz
	jp AIDiscourageMove

AI_Smart_PriorityHit:
	call AICompareSpeed
	ret c

; Dismiss this move if the player is flying or underground.
	ld a, [wPlayerSubStatus3]
	and 1 << SUBSTATUS_FLYING | 1 << SUBSTATUS_UNDERGROUND
	jp nz, AIDiscourageMove

; Greatly encourage this move if it will KO the player.
	ld a, $1
	ldh [hBattleTurn], a
	push hl
	farcall BattleCommand_damagestats
	farcall BattleCommand_damagecalc
	farcall BattleCommand_stab
	pop hl
	ld a, [wCurDamage + 1]
	ld c, a
	ld a, [wCurDamage]
	ld b, a
	ld a, [wBattleMonHP + 1]
	cp c
	ld a, [wBattleMonHP]
	sbc b
	ret nc
	dec [hl]
	dec [hl]
	dec [hl]
	ret

AI_Smart_Disable:
	call AICompareSpeed
	jr nc, .asm_38df3

	push hl
	ld a, [wPlayerSelectedMove]
	ld hl, UsefulMoves
	ld de, 1
	call IsInArray

	pop hl
	jr nc, .asm_38dee

	call Random
	cp 100
	ret c
	dec [hl]
	ret

.asm_38dee
	ld a, [wEnemyMoveStruct + MOVE_POWER]
	and a
	ret nz

.asm_38df3
	call Random
	cp 20
	ret c
	inc [hl]
	ret

AI_Smart_MeanLook:
	call AICheckEnemyHalfHP
	jr nc, .asm_38e24

	push hl
	call AICheckLastPlayerMon
	pop hl
	jp z, AIDiscourageMove

	call CheckIfTargetIsGhostType
	jp z, AIDiscourageMove

; 80% chance to greatly encourage this move if the player is badly poisoned
	ld a, [wBattleMonStatus]
	bit TOX, a
	jr nz, .asm_38e26

; 80% chance to greatly encourage this move if the player is either
; in love, identified, or stuck in Rollout.
	ld a, [wPlayerSubStatus1]
	and 1<<SUBSTATUS_IN_LOVE | 1<<SUBSTATUS_IDENTIFIED
	jr nz, .asm_38e26
	ld a, [wPlayerSubStatus3]
	and 1<<SUBSTATUS_ROLLOUT
	jr nz, .asm_38e26

; Otherwise, discourage this move unless the player only has not very effective moves against the enemy.
	push hl
	farcall CheckPlayerMoveTypeMatchups
	ld a, [wEnemyAISwitchScore]
	cp $b ; not very effective
	pop hl
	ret nc

.asm_38e24
	inc [hl]
	ret

.asm_38e26
	call AI_80_20
	ret c
	dec [hl]
	dec [hl]
	dec [hl]
	ret

AICheckLastPlayerMon:
	ld a, [wPartyCount]
	ld b, a
	ld c, 0
	ld hl, wPartyMon1HP
	ld de, PARTYMON_STRUCT_LENGTH

.loop
	ld a, [wCurBattleMon]
	cp c
	jr z, .asm_38e44

	ld a, [hli]
	or [hl]
	ret nz
	dec hl

.asm_38e44
	add hl, de
	inc c
	dec b
	jr nz, .loop

	ret

AI_Smart_Defrost:
; Use this move if the enemy is frozen.

	ld a, [wEnemyMonStatus]
	bit FRZ, a
	ret z
rept 5
	dec [hl]
endr
	ret

AI_Smart_Curse:
	ld a, [wEnemyMonType1]
	cp GHOST
	jr z, .ghostcurse
	ld a, [wEnemyMonType2]
	cp GHOST
	jr z, .ghostcurse

	call AICheckEnemyHalfHP
	jr nc, .asm_38e93

	ld a, [wEnemyAtkLevel]
	cp $b
	jr nc, .asm_38e93
	cp $9
	ret nc

	ld a, [wBattleMonType1]
	cp GHOST
	jr z, .asm_38e92
	call AI_80_20
	ret c
	dec [hl]
	dec [hl]
	ret

.asm_38e90
	inc [hl]
	inc [hl]
.asm_38e92
	inc [hl]
.asm_38e93
	inc [hl]
	ret

.ghostcurse
	ld a, [wPlayerSubStatus1]
	bit SUBSTATUS_CURSE, a
	jp nz, AIDiscourageMove

	push hl
	farcall CheckAnyOtherAliveEnemyMons
	pop hl
	jr nc, .asm_38eb0

	push hl
	call AICheckLastPlayerMon
	pop hl
	jr nz, .asm_38e90

	jr .asm_38eb7

.asm_38eb0
	push hl
	call AICheckLastPlayerMon
	pop hl
	jr z, .asm_38ecb

.asm_38eb7
	call AICheckEnemyQuarterHP
	jp nc, .asm_38e90

	call AICheckEnemyHalfHP
	jr nc, .asm_38e92

	call AICheckEnemyMaxHP
	ret nc

	ld a, [wPlayerTurnsTaken]
	and a
	ret nz

.asm_38ecb
	call AI_50_50
	ret c

	dec [hl]
	dec [hl]
	ret

AI_Smart_Protect:
	ld a, [wEnemyProtectCount]
	and a
	jr nz, .asm_38f13

	ld a, [wPlayerSubStatus2]
	bit SUBSTATUS_LOCK_ON, a
	jr nz, .asm_38f14

	ld a, [wPlayerSubStatus3]
	bit SUBSTATUS_CHARGED, a
	jr nz, .asm_38f0d
	bit SUBSTATUS_ROLLOUT, a
	jr z, .asm_38f14

	ld a, [wBattleMonStatus]
	bit TOX, a
	jr nz, .asm_38f0d
	ld a, [wPlayerSubStatus4]
	bit SUBSTATUS_LEECH_SEED, a
	jr nz, .asm_38f0d
	ld a, [wPlayerSubStatus1]
	bit SUBSTATUS_CURSE, a
	jr nz, .asm_38f0d

	ld a, [wPlayerRolloutCount]
	cp 3
	jr c, .asm_38f14

.asm_38f0d
	call AI_80_20
	ret c
	dec [hl]
	ret

.asm_38f13
	inc [hl]

.asm_38f14
	call Random
	cp 20
	ret c
	inc [hl]
	inc [hl]
	ret

AI_Smart_Foresight:
	ld a, [wEnemyAccLevel]
	cp $5
	jr c, .asm_38f41
	ld a, [wPlayerEvaLevel]
	cp $a
	jr nc, .asm_38f41

	ld a, [wBattleMonType1]
	cp GHOST
	jr z, .asm_38f41
	ld a, [wBattleMonType2]
	cp GHOST
	jr z, .asm_38f41

	call Random
	cp 20
	ret c
	inc [hl]
	ret

.asm_38f41
	call Random
	cp 100
	ret c
	dec [hl]
	dec [hl]
	ret

AI_Smart_PerishSong:
	push hl

	; Strongly discourage if useless or if we can't switch out
	farcall CheckAnyOtherAliveEnemyMons
	jr z, .no

	ld a, [wPlayerPerishCount]
	and a
	jr nz, .no

	call GetOpponentAbilityAfterMoldBreaker
	cp SOUNDPROOF
	jr z, .no

	farcall GetSwitchScores
	ld a, [wEnemyAISwitchScore]
	and a
	jr z, .no

	; Encourage if player can't switch out
	farcall CheckAnyOtherAlivePartyMons
	jr z, .yes

	call CheckIfTargetIsGhostType
	jr z, .neutral

	farcall GetOpponentItemAfterUnnerve
	ld a, b
	cp HELD_SHED_SHELL
	jr z, .neutral
	call SwitchTurn
	farcall CheckIfTrappedByAbility
	call SwitchTurn
	jr z, .yes

	ld a, [wPlayerWrapCount]
	and a
	jr nz, .yes
	ld a, [wEnemySubStatus2]
	bit SUBSTATUS_CANT_RUN, a
	jr nz, .yes

.neutral
	pop hl
	ret

.yes
	pop hl
	dec [hl]
	dec [hl]
	dec [hl]
	ret

.no
	pop hl
	ld a, [hl]
	add 5
	ld [hl], a
	ret


AI_Smart_Endure:
	ld a, [wEnemyProtectCount]
	and a
	jr nz, .asm_38fd8

	call AICheckEnemyMaxHP
	jr c, .asm_38fd8

	call AICheckEnemyQuarterHP
	jr c, .asm_38fd9

	ld b, EFFECT_REVERSAL
	call AIHasMoveEffect
	jr nc, .asm_38fcb

	call AI_80_20
	ret c

	dec [hl]
	dec [hl]
	dec [hl]
	ret

.asm_38fcb
	ld a, [wEnemySubStatus2]
	bit SUBSTATUS_LOCK_ON, a
	ret z

	call AI_50_50
	ret c

	dec [hl]
	dec [hl]
	ret

.asm_38fd8
	inc [hl]

.asm_38fd9
	inc [hl]
	ret

AI_Smart_Rollout:
; 80% chance to discourage this move if the enemy is in love, confused, or paralyzed.
	ld a, [wEnemySubStatus1]
	bit SUBSTATUS_IN_LOVE, a
	jr nz, .asm_39020

	ld a, [wEnemySubStatus3]
	bit SUBSTATUS_CONFUSED, a
	jr nz, .asm_39020

	ld a, [wEnemyMonStatus]
	bit PAR, a
	jr nz, .asm_39020

; 80% chance to discourage this move if the enemy's HP is below 25%,
; or if accuracy or evasion modifiers favour the player.
	call AICheckEnemyQuarterHP
	jr nc, .asm_39020

	ld a, [wEnemyAccLevel]
	cp 7
	jr c, .asm_39020
	ld a, [wPlayerEvaLevel]
	cp 8
	jr nc, .asm_39020

; Otherwise, 80% chance to greatly encourage this move.
	call Random
	cp 200
	ret nc
	dec [hl]
	dec [hl]
	ret

.asm_39020
	call AI_80_20
	ret c
	inc [hl]
	ret

AI_Smart_Swagger:
AI_Smart_Attract:
; 80% chance to encourage this move during the first turn of player's Pokemon.
; 80% chance to discourage this move otherwise.

	ld a, [wPlayerTurnsTaken]
	and a
	jr z, .first_turn

	call AI_80_20
	ret c
	inc [hl]
	ret

.first_turn
	call Random
	cp 200
	ret nc
	dec [hl]
	ret

AI_Smart_Safeguard:
; 80% chance to discourage this move if player's HP is below 50%.

	call AICheckPlayerHalfHP
	ret c
	call AI_80_20
	ret c
	inc [hl]
	ret

AI_Smart_Magnitude:
AI_Smart_Earthquake:

; Greatly encourage this move if the player is underground and the enemy is faster.
	ld a, [wPlayerSelectedMove]
	cp DIG
	ret nz

	ld a, [wPlayerSubStatus3]
	bit SUBSTATUS_UNDERGROUND, a
	jr z, .could_dig

	call AICompareSpeed
	ret nc
	dec [hl]
	dec [hl]
	ret

.could_dig
	; Try to predict if the player will use Dig this turn.

	; 50% chance to encourage this move if the enemy is slower than the player.
	call AICompareSpeed
	ret c

	call AI_50_50
	ret c

	dec [hl]
	ret

AI_Smart_BatonPass:
; Check total net stat boost effect:
; <0: Discourage
; >2: Encourage
	ld hl, wEnemyAtkLevel
	ld b, 7
	xor a
.loop
	add [hl]
	inc hl
	dec b
	jr nz, .loop

	sub BASE_STAT_LEVEL * 7
	jr c, .discourage
	cp 3
	ret c

	; Encourage
	dec [hl]
	dec [hl]
	ret

.discourage
	inc [hl]
	inc [hl]
	ret

AI_Smart_Pursuit:
; 50% chance to greatly encourage this move if player's HP is below 25%.
; 80% chance to discourage this move otherwise.

	call AICheckPlayerQuarterHP
	jr nc, .asm_3907d
	call AI_80_20
	ret c
	inc [hl]
	ret

.asm_3907d
	call AI_50_50
	ret c
	dec [hl]
	dec [hl]
	ret

AI_Smart_RapidSpin:
; 80% chance to greatly encourage this move if the enemy is
; trapped (Bind effect), seeded, or scattered with spikes.

	ld a, [wEnemyWrapCount]
	and a
	jr nz, .asm_39097

	ld a, [wEnemySubStatus4]
	bit SUBSTATUS_LEECH_SEED, a
	jr nz, .asm_39097

	ld a, [wEnemyHazards]
	and HAZARDS_SPIKES
	cp HAZARDS_SPIKES
	ret nz

.asm_39097
	call AI_80_20
	ret c

	dec [hl]
	dec [hl]
	ret

AI_Smart_RainDance:
	ld b, WEATHER_RAIN
	jr AI_Smart_Weather
AI_Smart_SunnyDay:
	ld b, WEATHER_SUN
	jr AI_Smart_Weather
AI_Smart_Sandstorm:
	ld b, WEATHER_SANDSTORM
	jr AI_Smart_Weather
AI_Smart_Hail:
	ld b, WEATHER_HAIL
	; fallthrough
AI_Smart_Weather:
; +10 if same weather is up (invalid move use)
; +2 if enemy has <50%HP, stacks with below checks
; -1 if no weather is up
; -2 if other weather is up
; Assumes AI only has a single weather setting move.
	; Discourage if redundant
	ld a, [wBattleWeather]
	cp b
	jp z, AIDiscourageMove

	; Encourage on neutral weather
	dec [hl]
	and a
	jr z, .check_own_hp

	; Encourage harder on opposing weather
	dec [hl]
.check_own_hp
	call AICheckEnemyHalfHP
	ret c
	inc [hl]
	inc [hl]
	ret

AI_Smart_BellyDrum:
; Dismiss this move if enemy's attack is higher than +2 or if enemy's HP is below 50%.
; Else, discourage this move if enemy's HP is not full.

	ld a, [wEnemyAtkLevel]
	cp $a
	jr nc, .asm_3914d

	call AICheckEnemyMaxHP
	ret c

	inc [hl]

	call AICheckEnemyHalfHP
	ret c

.asm_3914d
	ld a, [hl]
	add $5
	ld [hl], a
	ret

AI_Smart_MirrorCoat:
	push hl
	ld hl, wPlayerUsedMoves
	lb bc, 0, 4

.loop
	ld a, [hli]
	and a
	jr z, .next

	call AIGetEnemyMove

	ld a, [wEnemyMoveStruct + MOVE_POWER]
	and a
	jr z, .next

	ld a, [wEnemyMoveStruct + MOVE_CATEGORY]
	cp SPECIAL
	jr c, .next

	inc b

.next
	dec c
	jr nz, .loop

	pop hl
	ld a, b
	and a
	jr z, .none

	cp $3
	jr nc, .all

	ld a, [wPlayerSelectedMove]
	and a
	ret z

	call AIGetEnemyMove

	ld a, [wEnemyMoveStruct + MOVE_POWER]
	and a
	ret z

	ld a, [wEnemyMoveStruct + MOVE_CATEGORY]
	cp SPECIAL
	ret c

.all
	call Random
	cp 100
	ret c

	dec [hl]
	ret

.none
	inc [hl]
	ret

AI_Smart_Gust:

; Greatly encourage this move if the player is flying and the enemy is faster.
	ld a, [wPlayerSelectedMove]
	cp FLY
	ret nz

	ld a, [wPlayerSubStatus3]
	bit SUBSTATUS_FLYING, a
	jr z, .couldFly

	call AICompareSpeed
	ret nc

	dec [hl]
	dec [hl]
	ret

; Try to predict if the player will use Fly this turn.
.couldFly

; 50% chance to encourage this move if the enemy is slower than the player.
	call AICompareSpeed
	ret c
	call AI_50_50
	ret c
	dec [hl]
	ret

AI_Smart_FutureSight:
; Greatly encourage this move if the player is
; flying or underground, and slower than the enemy.
; Otherwise discourage.

	inc [hl]

	call AICompareSpeed
	ret nc

	ld a, [wPlayerSubStatus3]
	and 1 << SUBSTATUS_FLYING | 1 << SUBSTATUS_UNDERGROUND
	ret z

	dec [hl]
	dec [hl]
	dec [hl]
	ret

AI_Smart_Stomp:
; 80% chance to encourage this move if the player has used Minimize.

	ld a, [wPlayerSubStatus2]
	bit SUBSTATUS_MINIMIZED, a
	ret z

	call AI_80_20
	ret c

	dec [hl]
	ret

AI_Smart_SolarBeam:
; Discourage if we have Sunny Day and weather isn't sunny.
	ld a, [wBattleWeather]
	cp WEATHER_SUN
	ret z

	ld b, EFFECT_SUNNY_DAY
	call AIHasMoveEffect
	ret nc

	inc [hl]
	inc [hl]
	ret

AI_Smart_Thunder:
; 90% chance to discourage this move when it's sunny.

	ld a, [wBattleWeather]
	cp WEATHER_SUN
	ret nz

	call Random
	cp 25 ; 1/10
	ret c

	inc [hl]
	ret

AICompareSpeed:
; Return carry if enemy is faster than player.
	call CheckSpeed
	jr z, .no ; player outspeeds
	ccf ; nc->c (we outspeed), c->nc (tie)
	ret
.no
	xor a ; clears carry
	ret

AICheckPlayerMaxHP:
	push hl
	push de
	push bc
	ld de, wBattleMonHP
	ld hl, wBattleMonMaxHP
	jr AICheckMaxHP

AICheckEnemyMaxHP:
	push hl
	push de
	push bc
	ld de, wEnemyMonHP
	ld hl, wEnemyMonMaxHP
	; fallthrough

AICheckMaxHP:
; Return carry if hp at de matches max hp at hl.

	ld a, [de]
	inc de
	cp [hl]
	jr nz, .asm_39269

	inc hl
	ld a, [de]
	cp [hl]
	jr nz, .asm_39269

	pop bc
	pop de
	pop hl
	scf
	ret

.asm_39269
	pop bc
	pop de
	pop hl
	and a
	ret

AICheckPlayerHalfHP:
	push hl
	ld hl, wBattleMonHP
	ld b, [hl]
	inc hl
	ld c, [hl]
	sla c
	rl b
	inc hl
	inc hl
	ld a, [hld]
	cp c
	ld a, [hl]
	sbc b
	pop hl
	ret

AICheckEnemyHalfHP:
	push hl
	push de
	push bc
	ld hl, wEnemyMonHP
	ld b, [hl]
	inc hl
	ld c, [hl]
	sla c
	rl b
	inc hl
	inc hl
	ld a, [hld]
	cp c
	ld a, [hl]
	sbc b
	jp PopBCDEHL

AICheckEnemyQuarterHP:
	push hl
	push de
	push bc
	ld hl, wEnemyMonHP
	ld b, [hl]
	inc hl
	ld c, [hl]
	sla c
	rl b
	sla c
	rl b
	inc hl
	inc hl
	ld a, [hld]
	cp c
	ld a, [hl]
	sbc b
	jp PopBCDEHL

AICheckPlayerQuarterHP:
	push hl
	ld hl, wBattleMonHP
	ld b, [hl]
	inc hl
	ld c, [hl]
	sla c
	rl b
	sla c
	rl b
	inc hl
	inc hl
	ld a, [hld]
	cp c
	ld a, [hl]
	sbc b
	pop hl
	ret

AIHasMoveEffect:
; Return carry if the enemy has move b.

	push hl
	ld hl, wAIMoves
	ld c, NUM_MOVES

.checkmove
	ld a, [hli]
	and a
	jr z, .no

	call AIGetEnemyMove

	ld a, [wEnemyMoveStruct + MOVE_EFFECT]
	cp b
	jr z, .yes

	dec c
	jr nz, .checkmove

.no
	pop hl
	and a
	ret

.yes
	pop hl
	scf
	ret

AIHasMoveInArray:
; Return carry if the enemy has a move in array hl.

	push hl
	push de
	push bc

.next
	ld a, [hli]
	cp $ff
	jr z, .done

	ld b, a
	ld c, NUM_MOVES + 1
	ld de, wAIMoves

.check
	dec c
	jr z, .next

	ld a, [de]
	inc de
	cp b
	jr nz, .check

	scf

.done
	jp PopBCDEHL

UsefulMoves:
; Moves that are usable all-around.
	db DOUBLE_EDGE
	db SING
	db FLAMETHROWER
	db HYDRO_PUMP
	db SURF
	db ICE_BEAM
	db BLIZZARD
	db HYPER_BEAM
	db SLEEP_POWDER
	db THUNDERBOLT
	db THUNDER
	db EARTHQUAKE
	db TOXIC
	db PSYCHIC_M
	db HYPNOSIS
	db WILL_O_WISP
	db RECOVER
	db FIRE_BLAST
	db FRESH_SNACK
	db SUPER_FANG
	db MOONBLAST
	db PLAY_ROUGH
	db HURRICANE
	db $ff

AI_Opportunist:
; Discourage stall moves when the enemy's HP is low.

; Do nothing if enemy's HP is above 50%.
	call AICheckEnemyHalfHP
	ret c

; Discourage stall moves if enemy's HP is below 25%.
	call AICheckEnemyQuarterHP
	jr nc, .asm_39322

; 50% chance to discourage stall moves if enemy's HP is between 25% and 50%.
	call AI_50_50
	ret c

.asm_39322
	ld hl, wAIMoveScore - 1
	ld de, wAIMoves
	ld c, NUM_MOVES + 1
.checkmove
	inc hl
	dec c
	ret z

	ld a, [de]
	inc de
	and a
	ret z

	push hl
	push de
	push bc
	ld hl, .stallmoves
	ld de, 1
	call IsInArray

	pop bc
	pop de
	pop hl
	jr nc, .checkmove

	inc [hl]
	jr .checkmove

.stallmoves
	db AGILITY
	db BARRIER
	db BULK_UP
	db CALM_MIND
	db CONVERSION
	db COUNTER
	db DEFENSE_CURL
	db DISABLE
	db DRAGON_DANCE
	db FOCUS_ENERGY
	db GROWL
	db GROWTH
	db HAZE
	db HONE_CLAWS
	db LEECH_SEED
	db LEER
	db LIGHT_SCREEN
	db RAGE
	db REFLECT
	db SCREECH
	db SKILL_SWAP
	db SPLASH
	db STRING_SHOT
	db SUBSTITUTE
	db SWORDS_DANCE
	db TRANSFORM
	db TRICK
	db $ff

AI_Aggressive:
; Use whatever does the most damage.

; Discourage all damaging moves but the one that does the most damage.
; If no damaging move deals damage to the player (immune),
; no move will be discouraged

; Also greatly discourages ineffective moves since this overrides the
; regular type matchup layer

	; Figure out which attack does the most damage and put it in c.
	ld hl, wAIMoves
	ld bc, 0
	ld de, 0
.checkmove
	inc b
	ld a, b
	cp NUM_MOVES + 1
	jr z, .gotstrongestmove

	ld a, [hli]
	and a
	jr z, .gotstrongestmove

	push hl
	push de
	push bc
	call AIGetEnemyMove
	ld a, [wEnemyMoveStruct + MOVE_POWER]
	and a
	jr z, .nodamage
	ld a, [wEnemyMoveStruct + MOVE_EFFECT]
	cp EFFECT_COUNTER
	jr z, .nodamage
	cp EFFECT_MIRROR_COAT
	jr z, .nodamage
	call AIDamageCalc
	pop bc
	pop de
	pop hl

; Update current move if damage is highest so far
	ld a, [wCurDamage + 1]
	cp e
	ld a, [wCurDamage]
	sbc d
	jr c, .checkmove

	ld a, [wCurDamage + 1]
	ld e, a
	ld a, [wCurDamage]
	ld d, a
	ld c, b
	jr .checkmove

.nodamage
	pop bc
	pop de
	pop hl
	jr .checkmove

.gotstrongestmove
; Nothing we can do if no attacks did damage.
	ld a, c
	and a
	ret z

; Discourage moves that do less damage unless they're reckless too.
	ld hl, wAIMoveScore - 1
	ld de, wAIMoves
	ld b, 0
.checkmove2
	inc b
	ld a, b
	cp NUM_MOVES + 1
	ret z

; Ignore this move if it is the highest damaging one.
	cp c
	ld a, [de]
	inc de
	inc hl
	jr z, .checkmove2

	call AIGetEnemyMove

	; Ignore moves with no base power
	ld a, [wEnemyMoveStruct + MOVE_POWER]
	and a
	jr z, .checkmove2

	; Ignore Counter and Mirror Coat
	ld a, [wEnemyMoveStruct + MOVE_EFFECT]
	cp EFFECT_COUNTER
	jr z, .checkmove2
	cp EFFECT_MIRROR_COAT
	jr z, .checkmove2

	; This routine overrides the type matchup AI layer, since it's typically
	; superior to it. As a result, deal with ineffective moves here too which
	; is discouraged far more than other less damaging moves.
	push hl
	push de
	push bc
	farcall BattleCheckTypeMatchup
	pop bc
	pop de
	pop hl
	ld a, [wTypeMatchup]
	and a
	jp z, AIDiscourageMove

	; If we made it this far, discourage this move.
	inc [hl]
	jr .checkmove2

AIDamageCalc:
	ld a, 1
	ldh [hBattleTurn], a
	ld a, [wEnemyMoveStruct + MOVE_EFFECT]
	cp EFFECT_FURY_STRIKES
	jr z, .multihit
	cp EFFECT_MULTI_HIT
	jr z, .multihit
	cp EFFECT_DOUBLE_HIT
	jr z, .doublehit
	cp EFFECT_GYRO_BALL
	jr z, .gyro_ball
	cp EFFECT_HIDDEN_POWER
	jr z, .hidden_power
	cp EFFECT_LOW_KICK
	jr z, .low_kick
	cp EFFECT_MAGNITUDE
	jr z, .magnitude
	cp EFFECT_RETURN
	jr z, .return
	cp EFFECT_REVERSAL
	jr z, .reversal
	ld de, 1
	ld hl, .ConstantDamageEffects
	call IsInArray
	jr nc, .regular_damage
	farcall BattleCommand_constantdamage
	farjp BattleCommand_resettypematchup

.multihit
	; Multiply base power by 5 if Skill Link, 3 otherwise
	call GetTrueUserAbility
	cp SKILL_LINK
	ld b, 5
	jr z, .multihit_boost
	ld b, 3
	jr .multihit_boost
.doublehit
	; Multiply base power by 2
	ld b, 2
.multihit_boost
	ld a, [wEnemyMoveStruct + MOVE_POWER]
	ld c, a
.multihit_loop
	dec b
	jr z, .regular_damage ; With proper BP, we can use regular calc now
	add c
	ld [wEnemyMoveStruct + MOVE_POWER], a
	jr .multihit_loop
.gyro_ball
	farcall BattleCommand_damagestats
	farcall BattleCommand_gyroball
	jr .damagecalc
.hidden_power
	farcall HiddenPowerDamageStats
	jr .damagecalc
.low_kick
	farcall BattleCommand_damagestats
	farcall BattleCommand_lowkick
	jr .damagecalc
.return ; the move
	farcall BattleCommand_damagestats
	farcall BattleCommand_happinesspower
	jr .damagecalc
.reversal
	farcall BattleCommand_constantdamage
	jr .stab
.magnitude
	; Pretend that the base power is 70
	ld a, 70
	ld [wEnemyMoveStruct + MOVE_POWER], a
	; fallthrough
.regular_damage
	farcall BattleCommand_damagestats
.damagecalc
	farcall BattleCommand_damagecalc
.stab
	farcall BattleCommand_stab

	; harmless even if move doesn't have a conditional boost
	farjp BattleCommand_conditionalboost

.ConstantDamageEffects:
	db EFFECT_SUPER_FANG
	db EFFECT_STATIC_DAMAGE
	db EFFECT_LEVEL_DAMAGE
	db $ff

AI_Cautious:
; 90% chance to discourage moves with residual effects after the first turn.

	ld a, [wEnemyTurnsTaken]
	and a
	ret z

	ld hl, wAIMoveScore - 1
	ld de, wAIMoves
	ld c, NUM_MOVES + 1
.asm_39425
	inc hl
	dec c
	ret z

	ld a, [de]
	inc de
	and a
	ret z

	push hl
	push de
	push bc
	ld hl, .residualmoves
	ld de, 1
	call IsInArray

	pop bc
	pop de
	pop hl
	jr nc, .asm_39425

	call Random
	cp 230
	ret nc

	inc [hl]
	jr .asm_39425

.residualmoves
	db CONVERSION
	db FOCUS_ENERGY
	db LEECH_SEED
	db POISONPOWDER
	db SPIKES
	db STUN_SPORE
	db SUBSTITUTE
	db THUNDER_WAVE
	db TOXIC_SPIKES
	db TRANSFORM
	db $ff

AI_Status:
; Dismiss status moves that don't affect the player.
	ld a, 1
	ldh [hBattleTurn], a
	ld hl, wAIMoveScore - 1
	ld de, wAIMoves
	ld b, NUM_MOVES + 1
.checkmove
	dec b
	ret z

	inc hl
	ld a, [de]
	and a
	ret z

	inc de
	call AIGetEnemyMove

	ld a, [wEnemyMoveStruct + MOVE_CATEGORY]
	cp STATUS
	jr nz, .checkmove

	push bc
	push de
	push hl
	ld a, [wEnemyMoveStruct + MOVE_EFFECT]
	cp EFFECT_TOXIC
	jr z, .poison
	cp EFFECT_POISON
	jr z, .poison
	cp EFFECT_PARALYZE
	jr z, .paralyze
	cp EFFECT_BURN
	jr z, .burn
	cp EFFECT_FREEZE
	jr z, .freeze
	cp EFFECT_SLEEP
	jr z, .sleep
	cp EFFECT_CONFUSE
	jr z, .confusion
	cp EFFECT_ATTRACT
	jr z, .attract
	pop hl
	pop de
	pop bc
	jr .checkmove

.poison
	lb bc, IMMUNITY, HELD_PREVENT_POISON
	lb de, POISON, 1
	jr .checkstatus
.paralyze
	lb bc, LIMBER, HELD_PREVENT_PARALYZE
	lb de, ELECTRIC, 1
	jr .checkstatus
.burn
	lb bc, WATER_VEIL, HELD_PREVENT_BURN
	lb de, FIRE, 0
	jr .checkstatus
.freeze
	lb bc, MAGMA_ARMOR, HELD_PREVENT_FREEZE
	lb de, ICE, 0
	jr .checkstatus
.sleep
	; has 2 abilities, check one of them here
	call GetOpponentAbilityAfterMoldBreaker
	cp VITAL_SPIRIT
	jr z, .pop_and_discourage

	lb bc, INSOMNIA, HELD_PREVENT_SLEEP
	ld e, 1
	jr .checkstatus_after_type
.confusion
	lb bc, OWN_TEMPO, HELD_PREVENT_CONFUSE
	ld e, 0
	jr .checkstatus_after_type
.attract
	ld b, OBLIVIOUS
	ld e, 0
	jr .checkstatus_after_items

.checkstatus
	; Check opponent typings (fire types can't be burned and similar)
	push bc
	push de
	ld a, d
	call CheckIfTargetIsSomeType
	pop de
	pop bc
	jr z, .pop_and_discourage

.checkstatus_after_type
	; Check opponent type
	ld a, e
	and a
	jr z, .checkstatus_after_matchup
	push hl
	push de
	push bc
	farcall BattleCheckTypeMatchup
	pop bc
	pop de
	pop hl
	ld a, [wd265]
	and a
	jr z, .pop_and_discourage

.checkstatus_after_matchup
	; Check opponent item (Poison Guard/etc)
	push bc
	farcall GetOpponentItem
	ld a, b
	pop bc
	cp c
	jr z, .pop_and_discourage

.checkstatus_after_items
	; Check opponent ability
	push bc
	call GetOpponentAbilityAfterMoldBreaker
	pop bc
	cp b
	jr z, .pop_and_discourage
	; Also check for Leaf Guard
	cp LEAF_GUARD
	jr nz, .no_leaf_guard
	call GetWeatherAfterOpponentUmbrella
	cp WEATHER_SUN
	jr z, .pop_and_discourage

.no_leaf_guard
	; Check Substitute
	farcall CheckSubstituteOpp
	jr nz, .pop_and_discourage
	pop hl
	jr .nextmove

.pop_and_discourage
	pop hl
	call AIDiscourageMove
.nextmove
	pop de
	pop bc
	jp .checkmove

AI_Risky:
; Use any move that will KO the target.
; Risky moves will often be an exception (see below).

	ld hl, wAIMoveScore - 1
	ld de, wAIMoves
	ld c, NUM_MOVES + 1
.checkmove
	inc hl
	dec c
	ret z

	ld a, [de]
	inc de
	and a
	ret z

	push de
	push bc
	push hl
	call AIGetEnemyMove

	ld a, [wEnemyMoveStruct + MOVE_POWER]
	and a
	jr z, .nextmove

; Don't use risky moves at max hp.
	ld a, [wEnemyMoveStruct + MOVE_EFFECT]
	ld de, 1
	ld hl, .RiskyMoves
	call IsInArray
	jr nc, .checkko

	call AICheckEnemyMaxHP
	jr c, .nextmove

; Else, 80% chance to exclude them.
	call Random
	cp 200 ; 1/5
	jr c, .nextmove

.checkko
	call AIDamageCalc

	ld a, [wCurDamage + 1]
	ld e, a
	ld a, [wCurDamage]
	ld d, a
	ld a, [wBattleMonHP + 1]
	cp e
	ld a, [wBattleMonHP]
	sbc d
	jr nc, .nextmove

	pop hl
rept 5
	dec [hl]
endr
	push hl

.nextmove
	pop hl
	pop bc
	pop de
	jr .checkmove

.RiskyMoves:
	db EFFECT_EXPLOSION
	db $ff

AIDiscourageMove:
	ld a, [hl]
	add 10
	ld [hl], a
	ret

AIGetEnemyMove:
; Load attributes of move a into ram
	push hl
	push de
	push bc
	ld de, wEnemyMoveStruct
	call GetFixedMoveStruct
	jp PopBCDEHL

AI_80_20:
	call Random
	cp 50 ; 1/5
	ret

AI_50_50:
	call Random
	cp $80 ; 1/2
	ret
