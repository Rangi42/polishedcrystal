GetModifiedCaptureRate:
; Modified capture rate uses the following formula:
; (3M - 2H * b * r * s) / 3M
; M: Max HP, H = Current HP, b = ball bonus
; r = base capture rate, s = status bonus
; Heavy Ball is special: it will interact directly with r, giving
; an additive bonus (or penalty), capped at min 1 and max 255
	; Check if capture is guranteed
	ld a, [wBattleType]
	cp BATTLETYPE_TUTORIAL
	ld a, 255
	ret z
	ld a, [wCurItem]
	cp MASTER_BALL
	ld a, 255
	ret z

	; Start with 3M-2H
	ld hl, wEnemyMonHP
	ld a, [hli]
	ld b, a
	ld a, [hli]
	ld c, a
	ld a, [hli]
	ld d, a
	ld e, [hl]
	ld h, d
	ld l, e

	; Save M for later division
	push hl
	add hl, de
	add hl, de

	sla c
	rl b
	ld a, l
	sub c
	ldh [hMultiplicand + 2], a
	ld a, h
	sbc b
	ldh [hMultiplicand + 1], a
	xor a
	ldh [hMultiplicand], a

	; * ball bonus
	ld a, [wCurItem]
	ld hl, BallMultiplierFunctionTable
	call BattleJumptable

	; * base capture rate (might have been modified by Heavy Ball)
	ld a, [wEnemyMonCatchRate]
	ldh [hMultiplier], a
	call Multiply
	call CheckBallOverflow
	jr z, .pop_hl_and_gurantee

	; * status bonus
	ld a, [wEnemyMonStatus]
	bit FRZ, a
	jr nz, .frozen
	bit PAR, a
	jr nz, .psn_brn_par
	bit BRN, a
	jr nz, .psn_brn_par
	bit PSN, a
	jr nz, .psn_brn_par
	and SLP
	jr z, .status_done
.frozen
	ln a, 5, 2 ; x2.5
	jr .apply_status_mod
.psn_brn_par
	ln a, 3, 2 ; x1.5
.apply_status_mod
	call MultiplyAndDivide
	call CheckBallOverflow
	jr z, .pop_hl_and_gurantee

.status_done
	; Divide by 3
	ln a, 1, 3 ; x1/3
	call MultiplyAndDivide

	; Divide by M (first reduce it to a 1-byte number)
	pop hl

.loop
	xor a
	or h
	jr z, .done
	srl h
	rr l
	ln a, 1, 2 ; x0.5
	call MultiplyAndDivide
	jr .loop
.done
	ld a, l
	ldh [hDivisor], a
	ld b, 4
	call Divide

	ld hl, hQuotient
	ld a, [hli]
	or [hl]
	ld a, 255
	ret nz
	inc hl
	ld a, [hl]
	and a
	ret nz

	; Minimum modified catch rate is 1.
	inc a
	ret

.pop_hl_and_gurantee
	pop hl
	ld a, 255
	ret

CheckCriticalCapture:
; Returns c on critical capture
	xor a
	ld hl, hMultiplier
	ld [hli], a
	ld [hli], a
	ld a, [wBuffer1]
	ld [hl], a

	ld hl, wPokedexCaught
	ld b, wEndPokedexCaught - wPokedexCaught
	call CountSetBits
	inc a
	ld b, 5
	jr z, .got_multiplier
	dec a
	ld b, 0
	ld hl, .multipliers
.loop
	cp [hl]
	jr c, .got_multiplier
	inc b
	inc hl
	jr .loop
.got_multiplier
	; Catch Charm doubles capture rate (Unverified for SwSh!)
	ld a, [wCurItem]
	push af
	ld a, CATCH_CHARM
	ld [wCurKeyItem], a
	push hl
	push de
	push bc
	call CheckKeyItem
	pop bc
	pop de
	pop hl
	ld a, $6
	jr c, .catch_charm
	add a
.catch_charm
	swap b
	or b
	call MultiplyAndDivide
	pop af
	ld [wCurItem], a
	ldh a, [hQuotient + 2]
	ld b, a
	call Random
	cp b
	ret

.multipliers
	; Taken from Prism. Vanilla numbers don't work since we only have 254 mons.
	; Multiplier applies if we have less than that amount of mons.
	db 31 ; x0
	db 101 ; x0.5
	db 151 ; x1
	db 201 ; x1.5
	db 231 ; x2
	db 255 ; x2.5

CheckBallOverflow:
; Returns z if capture rate math is currently more than 24bit, which means
; it has overflowed what we can calculate. This allows us to simply return
; early, because at that point, nothing can stop it from being >255.
	ldh a, [hProduct]
	and a
	jr nz, .overflow
	or 1
	ret

.overflow
	xor a
	ret

BallMultiplierFunctionTable:
; table of routines that increase or decrease the catch rate based on
; which ball is used in a certain situation.
	dbw GREAT_BALL,  GreatBallMultiplier
	dbw ULTRA_BALL,  UltraBallMultiplier
	dbw SAFARI_BALL, SafariBallMultiplier
	dbw LEVEL_BALL,  LevelBallMultiplier
	dbw LURE_BALL,   LureBallMultiplier
	dbw MOON_BALL,   MoonBallMultiplier
	dbw FAST_BALL,   FastBallMultiplier
	dbw HEAVY_BALL,  HeavyBallMultiplier
	dbw LOVE_BALL,   LoveBallMultiplier
	dbw PARK_BALL,   ParkBallMultiplier
	dbw REPEAT_BALL, RepeatBallMultiplier
	dbw TIMER_BALL,  TimerBallMultiplier
	dbw NEST_BALL,   NestBallMultiplier
	dbw NET_BALL,    NetBallMultiplier
	dbw DIVE_BALL,   DiveBallMultiplier
	dbw QUICK_BALL,  QuickBallMultiplier
	dbw DUSK_BALL,   DuskBallMultiplier
	dbw DREAM_BALL,  DreamBallMultiplier
	db $ff

UltraBallMultiplier:
SafariBallMultiplier:
; multiply catch rate by 2
	ln a, 2, 1 ; x2
	jp MultiplyAndDivide

GreatBallMultiplier:
ParkBallMultiplier:
; multiply catch rate by 1.5
	ln a, 3, 2 ; x1.5
	jp MultiplyAndDivide

GetSpeciesWeight::
; input: a = species
; output: hl = weight
	ld hl, PokedexDataPointerTable
	dec a
	ld e, a
	ld d, 0
	add hl, de
	add hl, de
	add hl, de
	ld a, BANK(PokedexDataPointerTable)
	call GetFarByte
	push af
	inc hl
	ld a, BANK(PokedexDataPointerTable)
	call GetFarHalfword
	pop de

.skip_species
	ld a, d
	call GetFarByte
	inc hl
	cp "@"
	jr nz, .skip_species

	; skip height
	ld a, d
	inc hl
	inc hl

	; get weight
	jp GetFarHalfword

HeavyBallMultiplier:
; subtract 20 from base catch rate if weight < 102.4 kg
; else add 0 to base catch rate if weight < 204.8 kg
; else add 20 to base catch rate if weight < 307.2 kg
; else add 30 to base catch rate if weight < 409.6 kg
; else add 40 to base catch rate (never happens)
	ld a, [wEnemyMonCatchRate]
	ld b, a
	call .do_it
	ld a, b
	ld [wEnemyMonCatchRate], a

.do_it
	ld a, [wEnemyMonSpecies]
	call GetSpeciesWeight

	push bc
	srl h
	rr l
	ld b, h
	ld c, l
rept 4
	srl b
	rr c
endr
	call .subbc
	srl b
	rr c
	call .subbc
	ld a, h
	pop bc

	ld c, a
	cp HIGH(1024) ; 102.4 kg
	jr c, .lightmon

	ld hl, .WeightsTable
.lookup
	ld a, c
	cp [hl]
	jr c, .heavymon
	inc hl
	inc hl
	jr .lookup

.heavymon
	inc hl
	ld a, b
	add [hl]
	ld b, a
	ret nc
	ld b, 255
	ret

.lightmon
	ld a, b
	sub 20
	ld b, a
	ret nc
	ld b, 1
	ret

.subbc
	; subtract bc from hl
	push bc
	ld a, b
	cpl
	ld b, a
	ld a, c
	cpl
	ld c, a
	inc bc
	add hl, bc
	pop bc
	ret

.WeightsTable:
; weight factor, boost
	db HIGH(2048),   0
	db HIGH(3072),  20
	db HIGH(4096),  30
	db HIGH(65280), 40

LureBallMultiplier:
; multiply catch rate by 3 if this is a fishing rod battle
	ld a, [wBattleType]
	cp BATTLETYPE_FISH
	ret nz

	ln a, 3, 1 ; x3
	jp MultiplyAndDivide

MoonBallMultiplier:
; multiply catch rate by 4 if mon evolves with moon stone
	push bc
	; c = species
	ld a, [wTempEnemyMonSpecies]
	ld c, a
	; b = form
	ld a, [wEnemyMonForm]
	and BASEMON_MASK
	ld b, a
	; bc = index
	call GetSpeciesAndFormIndex
	dec bc
	ld hl, EvosAttacksPointers
	add hl, bc
	add hl, bc
	ld a, BANK(EvosAttacksPointers)
	call GetFarHalfword
	pop bc

	push bc
	ld a, BANK(EvosAttacks)
	call GetFarByte
	cp EVOLVE_ITEM
	pop bc
	ret nz

	inc hl
	inc hl
	inc hl

	push bc
	ld a, BANK(EvosAttacks)
	call GetFarByte
	cp MOON_STONE
	pop bc
	ret nz

	ln a, 4, 1 ; x4
	jp MultiplyAndDivide

LoveBallMultiplier:
; multiply catch rate by 8 if mons are of same species, different sex

	; does species match?
	ld a, [wTempEnemyMonSpecies]
	ld c, a
	ld a, [wTempBattleMonSpecies]
	cp c
	ret nz

	farcall CheckOppositeGender
	ret c ; genderless
	ret z ; same gender

	ln a, 8, 1 ; x8
	jp MultiplyAndDivide

FastBallMultiplier:
; multiply catch rate by 4 if enemy mon is in one of the three
; FleeMons tables.
	ld a, [wTempEnemyMonSpecies]
	ld c, a
	ld hl, FleeMons
	ld d, 3

.loop
	ld a, BANK(FleeMons)
	call GetFarByte

	inc hl
	cp -1
	jr z, .next
	cp c
	jr nz, .loop

	ln a, 4, 1 ; x4
	jp MultiplyAndDivide
.next
	dec d
	jr nz, .loop
	ret

LevelBallMultiplier:
; multiply catch rate by 8 if player mon level / 4 > enemy mon level
; multiply catch rate by 4 if player mon level / 2 > enemy mon level
; multiply catch rate by 2 if player mon level > enemy mon level
	ld a, [wBattleMonLevel]
	ld c, a
	ld a, [wEnemyMonLevel]
	call DoLevelBallMultiplier
	call DoLevelBallMultiplier
DoLevelBallMultiplier:
	cp c
	ret nc ; if player is lower level, we're done here

	push af
	ln a, 2, 1 ; x2
	call MultiplyAndDivide
	pop af
	srl c
	ret

RepeatBallMultiplier:
; multiply catch rate by 3.5 if enemy mon is already in Pokédex
	ld a, [wTempEnemyMonSpecies]
	dec a
	push bc
	call CheckCaughtMon
	pop bc
	ret z

	ln a, 7, 2 ; x3.5
	jp MultiplyAndDivide

TimerBallMultiplier:
; multiply catch rate by 1 + (turns passed * 3) / 10, capped at 4
	ld a, [wTotalBattleTurns]
	ld b, a
	add a
	add b
	add 10
	cp 40
	jr c, .nocap
	ld a, 40
.nocap
	ldh [hMultiplier], a
	call Multiply
	ln a, 1, 10 ; x0.1 after the above multiplier gives 1.3x, 1.6x, 1.9x, ..., 4x.
	jp MultiplyAndDivide

NestBallMultiplier:
; multiply catch rate by (41 - enemy mon level) / 5, floored at 1
	ld a, [wEnemyMonLevel]
	cp 36
	ret nc
	cpl
	add 41 + 1 ; a = 41 - a
	ldh [hMultiplier], a
	call Multiply
	ln a, 1, 5 ; x0.2
	jp MultiplyAndDivide

NetBallMultiplier:
; multiply catch rate by 3 if mon is water or bug type
	ld a, [wEnemyMonType1]
	cp WATER
	jr z, .ok
	cp BUG
	jr z, .ok
	ld a, [wEnemyMonType2]
	cp WATER
	jr z, .ok
	cp BUG
	ret nz

.ok
	ln a, 3, 1 ; x3
	jp MultiplyAndDivide

DiveBallMultiplier:
; multiply catch rate by 3.5 if surfing or fishing
	ld a, [wPlayerState]
	cp PLAYER_SURF
	jr z, .water
	cp PLAYER_SURF_PIKA
	jr z, .water

	ld a, [wBattleType]
	cp BATTLETYPE_FISH
	ret nz

.water
	ln a, 7, 2 ; x3.5
	jp MultiplyAndDivide

QuickBallMultiplier:
; multiply catch rate by 5 on first turn
	ld a, [wTotalBattleTurns]
	and a
	ret nz

	ln a, 5, 1 ; x5
	jp MultiplyAndDivide

DuskBallMultiplier:
; multiply catch rate by 3.5 at evening, night, or in caves
	ld a, [wEnvironment]
	cp CAVE
	jr z, .dusk

	ld a, [wTimeOfDay]
	cp 1 << EVE
	jr z, .dusk
	cp 1 << NITE
	ret nz

.dusk
	ln a, 7, 2 ; x3.5
	jp MultiplyAndDivide

DreamBallMultiplier:
; multiply catch rate by 4 if mon is asleep (on top of regular sleep bonus)
	ld a, [wEnemyMonStatus]
	and SLP
	ret z

	ln a, 4, 1 ; x4
	jp MultiplyAndDivide
