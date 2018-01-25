AI_Basic: ; 38591
; Don't do anything redundant:
;  -Using status-only moves if the player can't be statused
;  -Using moves that fail if they've already been used

	ld hl, Buffer1 - 1
	ld de, EnemyMonMoves
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

	ld a, [BattleMonStatus]
	and a
	jr nz, .discourage

; Dismiss Safeguard if it's already active.
	ld a, [PlayerScreens]
	bit SCREENS_SAFEGUARD, a
	jr z, .checkmove

.discourage
	call AIDiscourageMove
	jr .checkmove
; 385db

.statusonlyeffects
	db EFFECT_SLEEP
	db EFFECT_TOXIC
	db EFFECT_POISON
	db EFFECT_PARALYZE
	db EFFECT_BURN
	db EFFECT_FREEZE
	db $ff
; 385e0



AI_Setup: ; 385e0
; Use stat-modifying moves on turn 1.

; 50% chance to greatly encourage stat-up moves during the first turn of enemy's Pokemon.
; 50% chance to greatly encourage stat-down moves during the first turn of player's Pokemon.
; Almost 90% chance to greatly discourage stat-modifying moves otherwise.

	ld hl, Buffer1 - 1
	ld de, EnemyMonMoves
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

	cp EFFECT_ATTACK_UP
	jr c, .checkmove
	cp EFFECT_EVASION_UP + 1
	jr c, .statup

;	cp EFFECT_ATTACK_DOWN - 1
	jr z, .checkmove
	cp EFFECT_EVASION_DOWN + 1
	jr c, .statdown

	cp EFFECT_ATTACK_UP_2
	jr c, .checkmove
	cp EFFECT_EVASION_UP_2 + 1
	jr c, .statup

;	cp EFFECT_ATTACK_DOWN_2 - 1
	jr z, .checkmove
	cp EFFECT_EVASION_DOWN_2 + 1
	jr c, .statdown

	jr .checkmove

.statup
	ld a, [EnemyTurnsTaken]
	and a
	jr nz, .discourage

	jr .encourage

.statdown
	ld a, [PlayerTurnsTaken]
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
; 38635



AI_Types: ; 38635
; Dismiss any move that the player is immune to.
; Encourage super-effective moves.
; Discourage not very effective moves unless
; all damaging moves are of the same type.

	ld hl, Buffer1 - 1
	ld de, EnemyMonMoves
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
	ld [hBattleTurn], a
	farcall BattleCheckTypeMatchup
	pop de
	pop bc
	pop hl

	ld a, [wd265]
	and a
	jr z, .immune
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
	ld hl, EnemyMonMoves
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
	jr nz, .asm_38692
	jr .checkmove2

.asm_38692
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
; 386a2



AI_Offensive: ; 386a2
; Greatly discourage non-damaging moves.

	ld hl, Buffer1 - 1
	ld de, EnemyMonMoves
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
; 386be



AI_Smart: ; 386be
; Context-specific scoring.

	ld hl, Buffer1
	ld de, EnemyMonMoves
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
	ld hl, .table_386f2
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

.table_386f2
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
	dbw EFFECT_SUPER_FANG,        AI_Smart_SuperFang
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
	dbw EFFECT_REVERSAL,          AI_Smart_Reversal
	dbw EFFECT_HEAL_BELL,         AI_Smart_HealBell
	dbw EFFECT_PRIORITY_HIT,      AI_Smart_PriorityHit
	dbw EFFECT_THIEF,             AI_Smart_Thief
	dbw EFFECT_MEAN_LOOK,         AI_Smart_MeanLook
	dbw EFFECT_FLAME_WHEEL,       AI_Smart_FlameWheel
	dbw EFFECT_FLARE_BLITZ,       AI_Smart_FlameWheel
	dbw EFFECT_SACRED_FIRE,       AI_Smart_FlameWheel
	dbw EFFECT_CURSE,             AI_Smart_Curse
	dbw EFFECT_PROTECT,           AI_Smart_Protect
	dbw EFFECT_FORESIGHT,         AI_Smart_Foresight
	dbw EFFECT_PERISH_SONG,       AI_Smart_PerishSong
	dbw EFFECT_SANDSTORM,         AI_Smart_Sandstorm
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
	dbw EFFECT_HIDDEN_POWER,      AI_Smart_HiddenPower
	dbw EFFECT_RAIN_DANCE,        AI_Smart_RainDance
	dbw EFFECT_SUNNY_DAY,         AI_Smart_SunnyDay
	dbw EFFECT_BELLY_DRUM,        AI_Smart_BellyDrum
	dbw EFFECT_MIRROR_COAT,       AI_Smart_MirrorCoat
	dbw EFFECT_EARTHQUAKE,        AI_Smart_Earthquake
	dbw EFFECT_FUTURE_SIGHT,      AI_Smart_FutureSight
	dbw EFFECT_GUST,              AI_Smart_Gust
	dbw EFFECT_STOMP,             AI_Smart_Stomp
	dbw EFFECT_SOLAR_BEAM,        AI_Smart_SolarBeam
	dbw EFFECT_THUNDER,           AI_Smart_Thunder
	dbw EFFECT_FLY,               AI_Smart_Fly
	dbw EFFECT_ROOST,             AI_Smart_Roost
	db $ff
; 387e3


AI_Smart_Sleep: ; 387e3
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
; 387f7


AI_Smart_LeechHit: ; 387f7
	push hl
	ld a, 1
	ld [hBattleTurn], a
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
; 3881d


AI_Smart_Explosion:
; Selfdestruct, Explosion
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


AI_Smart_DreamEater: ; 388ca
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
; 388d4


AI_Smart_EvasionUp: ; 388d4

; Dismiss this move if enemy's evasion can't raise anymore.
	ld a, [EnemyEvaLevel]
	cp $d
	jp nc, AIDiscourageMove

; If enemy's HP is full...
	call AICheckEnemyMaxHP
	jr nc, .asm_388f2

; ...greatly encourage this move if player is badly poisoned.
	ld a, [BattleMonStatus]
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
	ld a, [BattleMonStatus]
	bit TOX, a
	jr nz, .asm_38938

	ld a, [PlayerSubStatus4]
	bit SUBSTATUS_LEECH_SEED, a
	jr nz, .asm_38941

; Discourage this move if enemy's evasion level is higher than player's accuracy level.
	ld a, [EnemyEvaLevel]
	ld b, a
	ld a, [PlayerAccLevel]
	cp b
	jr c, .asm_38936

; Greatly encourage this move if the player is in the middle of Rollout.
	ld a, [PlayerSubStatus1]
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
; 38947


AI_Smart_AlwaysHit: ; 38947
; 80% chance to greatly encourage this move if either...

; ...enemy's accuracy level has been lowered three or more stages
	ld a, [EnemyAccLevel]
	cp $5
	jr c, .asm_38954

; ...or player's evasion level has been raised three or more stages.
	ld a, [PlayerEvaLevel]
	cp $a
	ret c

.asm_38954
	call AI_80_20
	ret c

	dec [hl]
	dec [hl]
	ret
; 3895b


AI_Smart_AccuracyDown: ; 38985

; If player's HP is full...
	call AICheckPlayerMaxHP
	jr nc, .asm_389a0

; ...and enemy's HP is above 50%...
	call AICheckEnemyHalfHP
	jr nc, .asm_389a0

; ...greatly encourage this move if player is badly poisoned.
	ld a, [BattleMonStatus]
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
	ld a, [BattleMonStatus]
	bit TOX, a
	jr nz, .asm_389e6

	ld a, [PlayerSubStatus4]
	bit SUBSTATUS_LEECH_SEED, a
	jr nz, .asm_389ef

; Discourage this move if enemy's evasion level is higher than player's accuracy level.
	ld a, [EnemyEvaLevel]
	ld b, a
	ld a, [PlayerAccLevel]
	cp b
	jr c, .asm_389e4

; Greatly encourage this move if the player is in the middle of Rollout.
	ld a, [PlayerSubStatus1]
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
; 389f5


AI_Smart_Haze: ; 389f5

; 85% chance to encourage this move if any of enemy's stat levels is lower than -2.
	push hl
	ld hl, EnemyAtkLevel
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
	ld hl, PlayerAtkLevel
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
; 38a1e


AI_Smart_Roar: ; 38a2a
; Discourage this move if the player has not shown
; a super-effective move against the enemy.
; Consider player's type(s) if its moves are unknown.

	push hl
	farcall CheckPlayerMoveTypeMatchups
	ld a, [wEnemyAISwitchScore]
	cp 10 ; neutral
	pop hl
	ret c
	inc [hl]
	ret
; 38a3a


AI_Smart_Heal:
AI_Smart_HealingLight:
AI_Smart_Roost:
; 90% chance to greatly encourage this move if enemy's HP is below 25%.
; Discourage this move if enemy's HP is higher than 50%.
; Do nothing otherwise.

	call AICheckEnemyQuarterHP
	jr nc, .asm_38a45
	call AICheckEnemyHalfHP
	ret nc
	inc [hl]
	ret

.asm_38a45
	call Random
	cp $19
	ret c
	dec [hl]
	dec [hl]
	ret
; 38a4e


AI_Smart_Toxic:
AI_Smart_LeechSeed: ; 38a4e
; Discourage this move if player's HP is below 50%.

	call AICheckPlayerHalfHP
	ret c
	inc [hl]
	ret
; 38a54


AI_Smart_LightScreen:
AI_Smart_Reflect: ; 38a54
; Over 90% chance to discourage this move unless enemy's HP is full.

	call AICheckEnemyMaxHP
	ret c
	call Random
	cp $14
	ret c
	inc [hl]
	ret
; 38a60


AI_Smart_Bind: ; 38a71
; Wrap, Fire Spin, Whirlpool

; 50% chance to discourage this move if the player is already trapped.
	ld a, [wPlayerWrapCount]
	and a
	jr nz, .asm_38a8b

; 50% chance to greatly encourage this move if player is either
; badly poisoned, in love, identified, or stuck in Rollout.
	ld a, [BattleMonStatus]
	bit TOX, a
	jr nz, .asm_38a91

	ld a, [PlayerSubStatus1]
	and 1<<SUBSTATUS_IN_LOVE | 1<<SUBSTATUS_ROLLOUT | 1<<SUBSTATUS_IDENTIFIED
	jr nz, .asm_38a91

; Else, 50% chance to greatly encourage this move if it's the player's Pokemon first turn.
	ld a, [PlayerTurnsTaken]
	and a
	jr z, .asm_38a91

; 50% chance to discourage this move otherwise.
.asm_38a8b
	call AI_50_50
	ret c
	inc [hl]
	ret

.asm_38a91
	call AICheckEnemyQuarterHP
	ret nc
	call AI_50_50
	ret c
	dec [hl]
	dec [hl]
	ret
; 38a9c


AI_Smart_Confuse: ; 38adb

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
; 38aed


AI_Smart_SpDefenseUp2: ; 38aed

; Discourage this move if enemy's HP is lower than 50%.
	call AICheckEnemyHalfHP
	jr nc, .asm_38b10

; Discourage this move if enemy's special defense level is higher than +3.
	ld a, [EnemySDefLevel]
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
; 38b12


AI_Smart_Fly: ; 38b12
; Fly, Dig

; Greatly encourage this move if the player is
; flying or underground, and slower than the enemy.

	ld a, [PlayerSubStatus3]
	and 1 << SUBSTATUS_FLYING | 1 << SUBSTATUS_UNDERGROUND
	ret z

	call AICompareSpeed
	ret nc

	dec [hl]
	dec [hl]
	dec [hl]
	ret
; 38b20


AI_Smart_SuperFang: ; 38b20
; Discourage this move if player's HP is below 25%.

	call AICheckPlayerQuarterHP
	ret c
	inc [hl]
	ret
; 38b26


AI_Smart_Paralyze: ; 38b26

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
; 38b40


AI_Smart_SpeedDownHit: ; 38b40
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
	ld a, [PlayerTurnsTaken]
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
; 38b5c


AI_Smart_Substitute: ; 38b5c
; Dismiss this move if enemy's HP is below 50%.

	call AICheckEnemyHalfHP
	ret c
	jp AIDiscourageMove
; 38b63


AI_Smart_HyperBeam: ; 38b63
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
; 38b7f


AI_Smart_Rage: ; 38b7f
	ld a, [EnemySubStatus4]
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
; 38ba8


AI_Smart_Counter: ; 38bf1
	push hl
	ld hl, PlayerUsedMoves
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

	ld a, [PlayerSelectedMove]
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
; 38c3b


AI_Smart_Encore: ; 38c3b
	call AICompareSpeed
	jr nc, .asm_38c81

	ld a, [LastPlayerMove]
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
	ld a, [PlayerSelectedMove]
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
	db FLAME_WHEEL
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
; 38ca4


AI_Smart_PainSplit: ; 38ca4
; Discourage this move if [enemy's current HP * 2 > player's current HP].

	push hl
	ld hl, EnemyMonHP
	ld b, [hl]
	inc hl
	ld c, [hl]
	sla c
	rl b
	ld hl, BattleMonHP + 1
	ld a, [hld]
	cp c
	ld a, [hl]
	sbc b
	pop hl
	ret nc
	inc [hl]
	ret
; 38cba


AI_Smart_SleepTalk: ; 38cba
; Greatly encourage this move if enemy is fast asleep.
; Greatly discourage this move otherwise.

	ld a, [EnemyMonStatus]
	and $7
	cp $1
	jr z, .asm_38cc7

	dec [hl]
	dec [hl]
	dec [hl]
	ret

.asm_38cc7
	inc [hl]
	inc [hl]
	inc [hl]
	ret
; 38ccb


AI_Smart_DestinyBond:
AI_Smart_Reversal: ; 38d19
; Discourage this move if enemy's HP is above 25%.

	call AICheckEnemyQuarterHP
	ret nc
	inc [hl]
	ret
; 38d1f


AI_Smart_HealBell: ; 38d1f
; Dismiss this move if none of the opponent's Pokemon is statused.
; Encourage this move if the enemy is statused.
; 50% chance to greatly encourage this move if the enemy is fast asleep or frozen.

	push hl
	ld a, [OTPartyCount]
	ld b, a
	ld c, 0
	ld hl, OTPartyMon1HP
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

	ld a, [EnemyMonStatus]
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
	ld a, [EnemyMonStatus]
	and a
	ret nz
	jp AIDiscourageMove

; 38d5a


AI_Smart_PriorityHit: ; 38d5a
	call AICompareSpeed
	ret c

; Dismiss this move if the player is flying or underground.
	ld a, [PlayerSubStatus3]
	and 1 << SUBSTATUS_FLYING | 1 << SUBSTATUS_UNDERGROUND
	jp nz, AIDiscourageMove

; Greatly encourage this move if it will KO the player.
	ld a, $1
	ld [hBattleTurn], a
	push hl
	farcall EnemyAttackDamage
	farcall BattleCommand_DamageCalc
	farcall BattleCommand_Stab
	pop hl
	ld a, [CurDamage + 1]
	ld c, a
	ld a, [CurDamage]
	ld b, a
	ld a, [BattleMonHP + 1]
	cp c
	ld a, [BattleMonHP]
	sbc b
	ret nc
	dec [hl]
	dec [hl]
	dec [hl]
	ret
; 38d93


AI_Smart_Thief: ; 38d93
; Don't use Thief unless it's the only move available.

	ld a, [hl]
	add $1e
	ld [hl], a
	ret
; 38d98


AI_Smart_Disable: ; 38dd1
	call AICompareSpeed
	jr nc, .asm_38df3

	push hl
	ld a, [PlayerSelectedMove]
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
; 38dfb


AI_Smart_MeanLook: ; 38dfb
	call AICheckEnemyHalfHP
	jr nc, .asm_38e24

	push hl
	call AICheckLastPlayerMon
	pop hl
	jp z, AIDiscourageMove

; 80% chance to greatly encourage this move if the player is badly poisoned
	ld a, [BattleMonStatus]
	bit TOX, a
	jr nz, .asm_38e26

; 80% chance to greatly encourage this move if the player is either
; in love, identified, or stuck in Rollout.
	ld a, [PlayerSubStatus1]
	and 1<<SUBSTATUS_IN_LOVE | 1<<SUBSTATUS_ROLLOUT | 1<<SUBSTATUS_IDENTIFIED
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
; 38e2e


AICheckLastPlayerMon: ; 38e2e
	ld a, [PartyCount]
	ld b, a
	ld c, 0
	ld hl, PartyMon1HP
	ld de, PARTYMON_STRUCT_LENGTH

.loop
	ld a, [CurBattleMon]
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
; 38e4a


AI_Smart_FlameWheel: ; 38e50
; Use this move if the enemy is frozen.

	ld a, [EnemyMonStatus]
	bit FRZ, a
	ret z
rept 5
	dec [hl]
endr
	ret
; 38e5c


AI_Smart_Curse: ; 38e5c
	ld a, [EnemyMonType1]
	cp GHOST
	jr z, .ghostcurse
	ld a, [EnemyMonType2]
	cp GHOST
	jr z, .ghostcurse

	call AICheckEnemyHalfHP
	jr nc, .asm_38e93

	ld a, [EnemyAtkLevel]
	cp $b
	jr nc, .asm_38e93
	cp $9
	ret nc

	ld a, [BattleMonType1]
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
	ld a, [PlayerSubStatus1]
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

	ld a, [PlayerTurnsTaken]
	and a
	ret nz

.asm_38ecb
	call AI_50_50
	ret c

	dec [hl]
	dec [hl]
	ret
; 38ed2


AI_Smart_Protect: ; 38ed2
	ld a, [EnemyProtectCount]
	and a
	jr nz, .asm_38f13

	ld a, [PlayerSubStatus2]
	bit SUBSTATUS_LOCK_ON, a
	jr nz, .asm_38f14

	ld a, [PlayerSubStatus3]
	bit SUBSTATUS_CHARGED, a
	jr nz, .asm_38f0d

	ld a, [BattleMonStatus]
	bit TOX, a
	jr nz, .asm_38f0d
	ld a, [PlayerSubStatus4]
	bit SUBSTATUS_LEECH_SEED, a
	jr nz, .asm_38f0d
	ld a, [PlayerSubStatus1]
	bit SUBSTATUS_CURSE, a
	jr nz, .asm_38f0d

	bit SUBSTATUS_ROLLOUT, a
	jr z, .asm_38f14

	ld a, [PlayerRolloutCount]
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
; 38f1d


AI_Smart_Foresight: ; 38f1d
	ld a, [EnemyAccLevel]
	cp $5
	jr c, .asm_38f41
	ld a, [PlayerEvaLevel]
	cp $a
	jr nc, .asm_38f41

	ld a, [BattleMonType1]
	cp GHOST
	jr z, .asm_38f41
	ld a, [BattleMonType2]
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
; 38f4a


AI_Smart_PerishSong: ; 38f4a
	push hl
	farcall CheckAnyOtherAliveEnemyMons
	pop hl
	jr z, .no

	ld a, [PlayerSubStatus2]
	bit SUBSTATUS_CANT_RUN, a
	jr nz, .yes

	push hl
	farcall CheckPlayerMoveTypeMatchups
	ld a, [wEnemyAISwitchScore]
	cp 10 ; 1.0
	pop hl
	ret c

	call AI_50_50
	ret c

	inc [hl]
	ret

.yes
	call AI_50_50
	ret c

	dec [hl]
	ret

.no
	ld a, [hl]
	add 5
	ld [hl], a
	ret
; 38f7a


AI_Smart_Sandstorm: ; 38f7a

; Greatly discourage this move if the player is immune to Sandstorm damage.
	ld a, [BattleMonType1]
	push hl
	ld hl, .SandstormImmuneTypes
	ld de, 1
	call IsInArray
	pop hl
	jr c, .asm_38fa5

	ld a, [BattleMonType2]
	push hl
	ld hl, .SandstormImmuneTypes
	ld de, 1
	call IsInArray
	pop hl
	jr c, .asm_38fa5

; Discourage this move if player's HP is below 50%.
	call AICheckPlayerHalfHP
	jr nc, .asm_38fa6

; 50% chance to encourage this move otherwise.
	call AI_50_50
	ret c

	dec [hl]
	ret

.asm_38fa5
	inc [hl]

.asm_38fa6
	inc [hl]
	ret

.SandstormImmuneTypes:
	db ROCK
	db GROUND
	db STEEL
	db $ff
; 38fac


AI_Smart_Endure: ; 38fac
	ld a, [EnemyProtectCount]
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
	ld a, [EnemySubStatus2]
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
; 38fdb


AI_Smart_Rollout:
; 80% chance to discourage this move if the enemy is in love, confused, or paralyzed.
	ld a, [EnemySubStatus1]
	bit SUBSTATUS_IN_LOVE, a
	jr nz, .asm_39020

	ld a, [EnemySubStatus3]
	bit SUBSTATUS_CONFUSED, a
	jr nz, .asm_39020

	ld a, [EnemyMonStatus]
	bit PAR, a
	jr nz, .asm_39020

; 80% chance to discourage this move if the enemy's HP is below 25%,
; or if accuracy or evasion modifiers favour the player.
	call AICheckEnemyQuarterHP
	jr nc, .asm_39020

	ld a, [EnemyAccLevel]
	cp 7
	jr c, .asm_39020
	ld a, [PlayerEvaLevel]
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
; 39026


AI_Smart_Swagger:
AI_Smart_Attract: ; 39026
; 80% chance to encourage this move during the first turn of player's Pokemon.
; 80% chance to discourage this move otherwise.

	ld a, [PlayerTurnsTaken]
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
; 3903a


AI_Smart_Safeguard: ; 3903a
; 80% chance to discourage this move if player's HP is below 50%.

	call AICheckPlayerHalfHP
	ret c
	call AI_80_20
	ret c
	inc [hl]
	ret
; 39044


AI_Smart_Magnitude:
AI_Smart_Earthquake: ; 39044

; Greatly encourage this move if the player is underground and the enemy is faster.
	ld a, [PlayerSelectedMove]
	cp DIG
	ret nz

	ld a, [PlayerSubStatus3]
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
; 39062


AI_Smart_BatonPass: ; 39062
; Changes scoring as follows:
; +1: Don't bother
; 0 or less: Good idea
	push hl
	farcall AIWantsSwitchCheck
	pop hl
	inc [hl]
	ld a, [wEnemySwitchMonParam]
	and $f0
	push af
	xor a
	ld [wEnemySwitchMonParam], a
	ld [wEnemyAISwitchScore], a
	pop af
	ret z
.loop
	dec [hl]
	sub $10
	ret z
	jr .loop


AI_Smart_Pursuit: ; 39072
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
; 39084


AI_Smart_RapidSpin: ; 39084
; 80% chance to greatly encourage this move if the enemy is
; trapped (Bind effect), seeded, or scattered with spikes.

	ld a, [wEnemyWrapCount]
	and a
	jr nz, .asm_39097

	ld a, [EnemySubStatus4]
	bit SUBSTATUS_LEECH_SEED, a
	jr nz, .asm_39097

	ld a, [EnemyScreens]
	and SCREENS_SPIKES
	cp SCREENS_SPIKES
	ret nz

.asm_39097
	call AI_80_20
	ret c

	dec [hl]
	dec [hl]
	ret
; 3909e


AI_Smart_HiddenPower: ; 3909e
	push hl
	ld a, 1
	ld [hBattleTurn], a

; Calculate Hidden Power's type and base power based on enemy's DVs.
	farcall HiddenPowerDamageStats
	farcall BattleCheckTypeMatchup
	pop hl

; Discourage Hidden Power if not very effective.
	ld a, [wd265]
	cp 10
	jr c, .bad

; Discourage Hidden Power if its base power	is lower than 50.
	ld a, d
	cp 50
	jr c, .bad

; Encourage Hidden Power if super-effective.
	ld a, [wd265]
	cp 11
	jr nc, .good

; Encourage Hidden Power if its base power is 70.
	ld a, d
	cp 70
	ret c

.good
	dec [hl]
	ret

.bad
	inc [hl]
	ret
; 390cb


AI_Smart_RainDance: ; 390cb

; Greatly discourage this move if it would favour the player type-wise.
; Particularly, if the player is a Water-type.
	ld a, [BattleMonType1]
	cp WATER
	jr z, AIBadWeatherType
	cp FIRE
	jr z, AIGoodWeatherType

	ld a, [BattleMonType2]
	cp WATER
	jr z, AIBadWeatherType
	cp FIRE
	jr z, AIGoodWeatherType

	push hl
	ld hl, RainDanceMoves
	jr AI_Smart_WeatherMove
; 390e7

RainDanceMoves: ; 390e7
	db AQUA_TAIL
	db BUBBLE_BEAM
	db CRABHAMMER
	db HYDRO_PUMP
	db OCTAZOOKA
	db SCALD
	db SURF
	db THUNDER
	db WATER_GUN
	db WATER_PULSE
	db WATERFALL
	db WHIRLPOOL
	db $ff
; 390f3


AI_Smart_SunnyDay: ; 390f3

; Greatly discourage this move if it would favour the player type-wise.
; Particularly, if the player is a Fire-type.
	ld a, [BattleMonType1]
	cp FIRE
	jr z, AIBadWeatherType
	cp WATER
	jr z, AIGoodWeatherType

	ld a, [BattleMonType2]
	cp FIRE
	jr z, AIBadWeatherType
	cp WATER
	jr z, AIGoodWeatherType

	push hl
	ld hl, SunnyDayMoves

	; fallthrough
; 3910d


AI_Smart_WeatherMove: ; 3910d
; Rain Dance, Sunny Day

; Greatly discourage this move if the enemy doesn't have
; one of the useful Rain Dance or Sunny Day moves.
	call AIHasMoveInArray
	pop hl
	jr nc, AIBadWeatherType

; Greatly discourage this move if player's HP is below 50%.
	call AICheckPlayerHalfHP
	jr nc, AIBadWeatherType

; 50% chance to encourage this move otherwise.
	call AI_50_50
	ret c

	dec [hl]
	ret
; 3911e

AIBadWeatherType: ; 3911e
	inc [hl]
	inc [hl]
	inc [hl]
	ret
; 39122

AIGoodWeatherType: ; 39122
; Rain Dance, Sunny Day

; Greatly encourage this move if it would disfavour the player type-wise and player's HP is above 50%...
	call AICheckPlayerHalfHP
	ret nc

; ...as long as one of the following conditions meet:
; It's the first turn of the player's Pokemon.
	ld a, [PlayerTurnsTaken]
	and a
	jr z, .good

; Or it's the first turn of the enemy's Pokemon.
	ld a, [EnemyTurnsTaken]
	and a
	ret nz

.good
	dec [hl]
	dec [hl]
	ret
; 39134


SunnyDayMoves: ; 39134
	db FIRE_PUNCH
	db EMBER
	db FLAMETHROWER
	db FIRE_SPIN
	db FIRE_BLAST
	db SACRED_FIRE
	db FLARE_BLITZ
	db HEALINGLIGHT
	db $ff
; 3913d


AI_Smart_BellyDrum: ; 3913d
; Dismiss this move if enemy's attack is higher than +2 or if enemy's HP is below 50%.
; Else, discourage this move if enemy's HP is not full.

	ld a, [EnemyAtkLevel]
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
; 39152


AI_Smart_MirrorCoat: ; 3918b
	push hl
	ld hl, PlayerUsedMoves
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

	ld a, [PlayerSelectedMove]
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
; 391d5


AI_Smart_Gust: ; 391d5

; Greatly encourage this move if the player is flying and the enemy is faster.
	ld a, [PlayerSelectedMove]
	cp FLY
	ret nz

	ld a, [PlayerSubStatus3]
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
; 391f3


AI_Smart_FutureSight: ; 391f3
; Greatly encourage this move if the player is
; flying or underground, and slower than the enemy.
; Otherwise discourage.

	inc [hl]

	call AICompareSpeed
	ret nc

	ld a, [PlayerSubStatus3]
	and 1 << SUBSTATUS_FLYING | 1 << SUBSTATUS_UNDERGROUND
	ret z

	dec [hl]
	dec [hl]
	dec [hl]
	ret
; 39200


AI_Smart_Stomp: ; 39200
; 80% chance to encourage this move if the player has used Minimize.

	ld a, [wPlayerMinimized]
	and a
	ret z

	call AI_80_20
	ret c

	dec [hl]
	ret
; 3920b


AI_Smart_SolarBeam: ; 3920b
; 80% chance to encourage this move when it's sunny.
; 90% chance to discourage this move when it's raining.

	ld a, [Weather]
	cp WEATHER_SUN
	jr z, .asm_3921e

	cp WEATHER_RAIN
	ret nz

	call Random
	cp 25 ; 1/10
	ret c

	inc [hl]
	inc [hl]
	ret

.asm_3921e
	call AI_80_20
	ret c

	dec [hl]
	dec [hl]
	ret
; 39225


AI_Smart_Thunder: ; 39225
; 90% chance to discourage this move when it's sunny.

	ld a, [Weather]
	cp WEATHER_SUN
	ret nz

	call Random
	cp 25 ; 1/10
	ret c

	inc [hl]
	ret
; 39233


AICompareSpeed:
; Return carry if enemy is faster than player.
	call CheckSpeed
	jr z, .no ; player outspeeds
	ccf ; nc->c (we outspeed), c->nc (tie)
	ret
.no
	xor a ; clears carry
	ret


AICheckPlayerMaxHP: ; 39246
	push hl
	push de
	push bc
	ld de, BattleMonHP
	ld hl, BattleMonMaxHP
	jr AICheckMaxHP
; 39251


AICheckEnemyMaxHP: ; 39251
	push hl
	push de
	push bc
	ld de, EnemyMonHP
	ld hl, EnemyMonMaxHP
	; fallthrough
; 3925a


AICheckMaxHP: ; 3925a
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
; 3926e


AICheckPlayerHalfHP: ; 3926e
	push hl
	ld hl, BattleMonHP
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
; 39281


AICheckEnemyHalfHP: ; 39281
	push hl
	push de
	push bc
	ld hl, EnemyMonHP
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
	pop bc
	pop de
	pop hl
	ret
; 39298


AICheckEnemyQuarterHP: ; 39298
	push hl
	push de
	push bc
	ld hl, EnemyMonHP
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
	pop bc
	pop de
	pop hl
	ret
; 392b3


AICheckPlayerQuarterHP: ; 392b3
	push hl
	ld hl, BattleMonHP
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
; 392ca


AIHasMoveEffect: ; 392ca
; Return carry if the enemy has move b.

	push hl
	ld hl, EnemyMonMoves
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
; 392e6


AIHasMoveInArray: ; 392e6
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
	ld de, EnemyMonMoves

.check
	dec c
	jr z, .next

	ld a, [de]
	inc de
	cp b
	jr nz, .check

	scf

.done
	pop bc
	pop de
	pop hl
	ret
; 39301


UsefulMoves: ; 39301
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
	db SOFTBOILED
	db SUPER_FANG
	db MOONBLAST
	db PLAY_ROUGH
	db HURRICANE
	db $ff
; 39315


AI_Opportunist: ; 39315
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
	ld hl, Buffer1 - 1
	ld de, EnemyMonMoves
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
; 39369



AI_Aggressive: ; 39369
; Use whatever does the most damage.

; Discourage all damaging moves but the one that does the most damage.
; If no damaging move deals damage to the player (immune),
; no move will be discouraged

; Figure out which attack does the most damage and put it in c.
	ld hl, EnemyMonMoves
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
	call AIDamageCalc
	pop bc
	pop de
	pop hl

; Update current move if damage is highest so far
	ld a, [CurDamage + 1]
	cp e
	ld a, [CurDamage]
	sbc d
	jr c, .checkmove

	ld a, [CurDamage + 1]
	ld e, a
	ld a, [CurDamage]
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
	ld hl, Buffer1 - 1
	ld de, EnemyMonMoves
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

; Ignore this move if its power is 0 or 1.
; Moves such as Seismic Toss, Hidden Power,
; Counter and Fissure have a base power of 1.
	ld a, [wEnemyMoveStruct + MOVE_POWER]
	cp 2
	jr c, .checkmove2

; Ignore this move if it is reckless.
	push hl
	push de
	push bc
	ld a, [wEnemyMoveStruct + MOVE_EFFECT]
	ld hl, .RecklessMoves
	ld de, 1
	call IsInArray
	pop bc
	pop de
	pop hl
	jr c, .checkmove2

; If we made it this far, discourage this move.
	inc [hl]
	jr .checkmove2

.RecklessMoves:
	db EFFECT_EXPLOSION
	db EFFECT_RAMPAGE
	db EFFECT_MULTI_HIT
	db EFFECT_DOUBLE_HIT
	db EFFECT_FURY_STRIKES
	db $ff
; 393e7


AIDamageCalc: ; 393e7
	ld a, 1
	ld [hBattleTurn], a
	ld a, [wEnemyMoveStruct + MOVE_EFFECT]
	ld de, 1
	ld hl, .ConstantDamageEffects
	call IsInArray
	jr nc, .no_special_damage
	farjp BattleCommand_ConstantDamage

.no_special_damage
	farcall EnemyAttackDamage
	farcall BattleCommand_DamageCalc
	farcall BattleCommand_Stab

	; Maybe run conditional boost if applicable
	ld a, [wEnemyMoveStruct + MOVE_EFFECT]
	cp EFFECT_CONDITIONAL_BOOST
	ret nz
	farjp BattleCommand_ConditionalBoost

.ConstantDamageEffects:
	db EFFECT_SUPER_FANG
	db EFFECT_STATIC_DAMAGE
	db EFFECT_LEVEL_DAMAGE
	db $ff

AI_Cautious: ; 39418
; 90% chance to discourage moves with residual effects after the first turn.

	ld a, [EnemyTurnsTaken]
	and a
	ret z

	ld hl, Buffer1 - 1
	ld de, EnemyMonMoves
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
; 39453



AI_Status: ; 39453
; Dismiss status moves that don't affect the player.
	ld a, 1
	ld [hBattleTurn], a
	ld hl, Buffer1 - 1
	ld de, EnemyMonMoves
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

	; For some reason, this routine also handles ordinary move hits to discourage immune
	; moves. This is redundant with AI_Types, but kept to avoid potential issues.
	ld a, BATTLE_VARS_MOVE_CATEGORY
	call GetBattleVar
	cp STATUS
	jp nz, .typematchup

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
	ld a, POISON
	lb bc, IMMUNITY, HELD_PREVENT_POISON
	jr .checkstatus
.paralyze
	ld a, ELECTRIC
	lb bc, LIMBER, HELD_PREVENT_PARALYZE
	jr .checkstatus
.burn
	ld a, FIRE
	lb bc, WATER_VEIL, HELD_PREVENT_BURN
	jr .checkstatus
.freeze
	ld a, ICE
	lb bc, MAGMA_ARMOR, HELD_PREVENT_FREEZE
	jr .checkstatus
.sleep
	; has 2 abilities, check one of them here
	call GetOpponentAbilityAfterMoldBreaker
	cp VITAL_SPIRIT
	jr z, .pop_and_discourage

	lb bc, INSOMNIA, HELD_PREVENT_SLEEP
	jr .checkstatus_after_type
.confusion
	lb bc, OWN_TEMPO, HELD_PREVENT_CONFUSE
	jr .checkstatus_after_type
.attract
	ld b, OBLIVIOUS
	jr .checkstatus_after_items

.checkstatus
	; Check opponent typings (fire types can't be burned and similar)
	push bc
	call CheckIfTargetIsSomeType
	pop bc
	jr z, .pop_and_discourage

.checkstatus_after_type
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
	call GetWeatherAfterCloudNine
	cp WEATHER_SUN
	jr z, .pop_and_discourage

.no_leaf_guard
	; Check Substitute
	farcall CheckSubstituteOpp_b
	ld a, b
	and a
	jr nz, .pop_and_discourage

	pop hl
	pop de
	pop bc
.typematchup
	; Check type matchups
	push hl
	farcall BattleCheckTypeMatchup
	pop hl
	ld a, [wd265]
	and a
	jr z, .immune
	jp .checkmove

.pop_and_discourage
	pop hl
	pop de
	pop bc
	; fallthrough
.immune
	call AIDiscourageMove
	jp .checkmove
; 394a9



AI_Risky: ; 394a9
; Use any move that will KO the target.
; Risky moves will often be an exception (see below).

	ld hl, Buffer1 - 1
	ld de, EnemyMonMoves
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

	ld a, [CurDamage + 1]
	ld e, a
	ld a, [CurDamage]
	ld d, a
	ld a, [BattleMonHP + 1]
	cp e
	ld a, [BattleMonHP]
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
; 39502



AI_None: ; 39502
	ret
; 39503


AIDiscourageMove: ; 39503
	ld a, [hl]
	add 10
	ld [hl], a
	ret
; 39508


AIGetEnemyMove: ; 39508
; Load attributes of move a into ram

	push hl
	push de
	push bc
	dec a
	ld hl, Moves
	ld bc, MOVE_LENGTH
	call AddNTimes

	ld de, wEnemyMoveStruct
	ld a, BANK(Moves)
	call FarCopyBytes

	pop bc
	pop de
	pop hl
	ret
; 39521


AI_80_20: ; 39521
	call Random
	cp 50 ; 1/5
	ret
; 39527


AI_50_50: ; 39527
	call Random
	cp $80 ; 1/2
	ret
; 3952d
