Pointers445f:
	dw SetFacingStanding,              SetFacingStanding          ; PERSON_ACTION_00
	dw SetFacingStandAction,           SetFacingCurrent           ; PERSON_ACTION_STAND
	dw SetFacingStepAction,            SetFacingCurrent           ; PERSON_ACTION_STEP
	dw SetFacingBumpAction,            SetFacingCurrent           ; PERSON_ACTION_BUMP
	dw SetFacingCounterclockwiseSpin,  SetFacingCurrent           ; PERSON_ACTION_SPIN
	dw SetFacingCounterclockwiseSpin2, SetFacingStanding          ; PERSON_ACTION_SPIN_FLICKER
	dw SetFacingFish,                  SetFacingFish              ; PERSON_ACTION_FISHING
	dw SetFacingShadow,                SetFacingStanding          ; PERSON_ACTION_SHADOW
	dw SetFacingEmote,                 SetFacingEmote             ; PERSON_ACTION_EMOTE
	dw SetFacingBigDollSym,            SetFacingBigDollSym        ; PERSON_ACTION_BIG_SNORLAX
	dw SetFacingBounce,                SetFacingFreezeBounce      ; PERSON_ACTION_BOUNCE
	dw SetFacingWeirdTree,             SetFacingCurrent           ; PERSON_ACTION_WEIRD_TREE
	dw SetFacingBigDoll,               SetFacingBigDoll           ; PERSON_ACTION_BIG_DOLL
	dw SetFacingBoulderDust,           SetFacingStanding          ; PERSON_ACTION_BOULDER_DUST
	dw SetFacingGrassShake,            SetFacingStanding          ; PERSON_ACTION_GRASS_SHAKE
	dw SetFacingPuddleSplash,          SetFacingStanding          ; PERSON_ACTION_PUDDLE_SPLASH
	dw SetFacingCutTree,               SetFacingCutTree           ; PERSON_ACTION_CUT_TREE
	dw SetFacingSkyfall,               SetFacingCurrent           ; PERSON_ACTION_SKYFALL
	dw SetFacingFruit,                 SetFacingFruit             ; PERSON_ACTION_FRUIT
	dw SetFacingBigGyarados,           SetFacingFreezeBigGyarados ; PERSON_ACTION_BIG_GYARADOS
	dw SetFacingStandFlip,             SetFacingStandFlip         ; PERSON_ACTION_STAND_FLIP
	dw SetFacingPokecomNews,           SetFacingPokecomNews       ; PERSON_ACTION_POKECOM_NEWS
	dw SetFacingArchTree,              SetFacingArchTree          ; PERSON_ACTION_ARCH_TREE
	dw SetFacingRun,                   SetFacingCurrent           ; PERSON_ACTION_RUN
	dw SetFacingSailboatTop,           SetFacingSailboatTop       ; PERSON_ACTION_SAILBOAT_TOP
	dw SetFacingSailboatBottom,        SetFacingSailboatBottom    ; PERSON_ACTION_SAILBOAT_BOTTOM

SetFacingStanding:
	ld a, STANDING
	jr SetFixedFacing

SetFacingCurrent:
	call GetSpriteDirection
	jr SetFixedFacing

SetFacingShadow:
	ld a, FACING_SHADOW
	jr SetFixedFacing

SetFacingEmote: ; 4582 emote
	ld a, FACING_EMOTE
	jr SetFixedFacing

SetFacingCutTree:
	ld a, FACING_CUT_TREE
	jr SetFixedFacing

SetFacingPokecomNews:
	ld a, FACING_POKECOM_NEWS
	jr SetFixedFacing

SetFacingSailboatTop:
	ld a, FACING_SAILBOAT_TOP
	jr SetFixedFacing

SetFacingSailboatBottom:
	ld a, FACING_SAILBOAT_BOTTOM
	jr SetFixedFacing

SetFacingBigDoll:
	ld a, [wVariableSprites + SPRITE_BIG_DOLL - SPRITE_VARS]
	cp SPRITE_BIG_ONIX
	ld a, FACING_BIG_DOLL_ASYM
	jr z, SetFixedFacing
SetFacingBigDollSym:
	ld a, FACING_BIG_DOLL_SYM
	jr SetFixedFacing

SetFacingFish:
	call GetSpriteDirection
	rrca
	rrca
	add FACING_FISH_DOWN
	jr SetFixedFacing

SetFacingArchTree:
	call GetSpriteDirection
	rrca
	rrca
	add FACING_ARCH_TREE_DOWN
	jr SetFixedFacing

SetFacingStandFlip:
	call GetSpriteDirection
	rrca
	rrca
	add FACING_STEP_DOWN_FLIP
SetFixedFacing:
	ld hl, OBJECT_FACING_STEP
	add hl, bc
	ld [hl], a
	ret

SetFacingStandAction:
	ld hl, OBJECT_FACING_STEP
	add hl, bc
	ld a, [hl]
	and 1
	jr z, SetFacingCurrent
	; fallthrough

SetFacingStepAction:
SetFacingBumpAction:
	ld hl, OBJECT_FLAGS1
	add hl, bc
	bit SLIDING, [hl]
	jr nz, SetFacingCurrent

	ld hl, OBJECT_STEP_FRAME
	add hl, bc
	inc [hl]
	ld a, [hl]
	rrca
	rrca
	rrca
	and %11
	ld d, a
	call GetSpriteDirection
	or d
	ld hl, OBJECT_FACING_STEP
	add hl, bc
	ld [hl], a
	ret

SetFacingSkyfall:
	ld hl, OBJECT_FLAGS1
	add hl, bc
	bit SLIDING, [hl]
	jr nz, SetFacingCurrent

	ld hl, OBJECT_STEP_FRAME
	add hl, bc
	ld a, [hl]
	add 2
	ld [hl], a
	rrca
	rrca
	rrca
	and %11
	ld d, a

	call GetSpriteDirection
	or d
	jr SetFixedFacing

SetFacingCounterclockwiseSpin:
	call CounterclockwiseSpinAction
	ld hl, OBJECT_FACING
	add hl, bc
	ld a, [hl]
	jr SetFixedFacing

SetFacingCounterclockwiseSpin2:
	call CounterclockwiseSpinAction
	jp SetFacingStanding

CounterclockwiseSpinAction:
	ld hl, OBJECT_STEP_FRAME
	add hl, bc
	ld a, [hl]
	and %11110000
	ld e, a

	ld a, [hl]
	inc a
	and %00001111
	ld d, a
	cp 2
	jr c, .ok

	ld d, 0
	ld a, e
	add $10
	and %00110000
	ld e, a

.ok
	ld a, d
	or e
	ld [hl], a

	swap e
	ld d, 0
	ld hl, .Directions
	add hl, de
	ld a, [hl]
	ld hl, OBJECT_FACING
	add hl, bc
	ld [hl], a
	ret

.Directions
	db OW_DOWN, OW_RIGHT, OW_UP, OW_LEFT

SetFacingBounce:
	ld hl, OBJECT_STEP_FRAME
	add hl, bc
	ld a, [hl]
	inc a
	and %00001111
	ld [hl], a
	and %00001000
	ld a, FACING_STEP_UP_0
	jp nz, SetFixedFacing
SetFacingFreezeBounce:
	xor a ; FACING_STEP_DOWN_0
	jp SetFixedFacing

SetFacingFruit:
	ld hl, OBJECT_RADIUS
	add hl, bc
	ld a, [hl]
	push bc
	ld hl, wFruitTreeFlags
	ld e, a
	ld d, 0
	ld b, CHECK_FLAG
	push de
	call FlagAction
	pop de
	ld a, c
	pop bc
	and a ; 0 = show fruit, 1 = hide fruit
	ld a, FACING_PICKED_FRUIT
	jr nz, .ok
	ld a, e
	cp FIRST_BERRY_TREE - 1
	ld a, FACING_APRICORN
	jr c, .ok
	dec a ; ld a, FACING_BERRY
.ok
	jp SetFixedFacing

SetFacingBigGyarados:
	ld hl, OBJECT_STEP_FRAME
	add hl, bc
	ld a, [hl]
	inc a
	and %00001111
	ld [hl], a
	and %00001000
	ld a, FACING_BIG_GYARADOS_2
	jp nz, SetFixedFacing
SetFacingFreezeBigGyarados:
	ld a, FACING_BIG_GYARADOS_1
	jp SetFixedFacing

SetFacingWeirdTree:
	ld hl, OBJECT_STEP_FRAME
	add hl, bc
	ld a, [hl]
	inc a
	ld [hl], a
	and %00001100
	rrca
	rrca
	add FACING_WEIRD_TREE_0
	jp SetFixedFacing

SetFacingBoulderDust:
	ld hl, OBJECT_STEP_FRAME
	add hl, bc
	inc [hl]
	ld a, [hl]
	and 2
	ld a, FACING_BOULDER_DUST_1
	jr z, .ok
	inc a ; FACING_BOULDER_DUST_2
.ok
	jp SetFixedFacing

SetFacingGrassShake:
	ld hl, OBJECT_STEP_FRAME
	add hl, bc
	inc [hl]
	ld a, [hl]
	and 4
	ld a, FACING_GRASS_1
	jr z, .ok
	inc a ; FACING_GRASS_2
.ok
	jp SetFixedFacing

SetFacingPuddleSplash:
	ld hl, OBJECT_STEP_FRAME
	add hl, bc
	inc [hl]
	ld a, [hl]
	and 4
	ld a, FACING_SPLASH_1
	jr z, .ok
	inc a ; FACING_SPLASH_2
.ok
	jp SetFixedFacing

SetFacingRun:
	ld hl, OBJECT_FLAGS1
	add hl, bc
	bit SLIDING, [hl]
	jp nz, SetFacingCurrent

	ld hl, OBJECT_STEP_FRAME
	add hl, bc
	inc [hl]
	ld a, [hl]
	rrca
	rrca
	and %11
	ld d, a
	call GetSpriteDirection
	or d
	ld hl, OBJECT_FACING_STEP
	add hl, bc
	ld [hl], a
	ret
