Pointers445f: ; 445f
	dw SetFacingStanding,              SetFacingStanding     ; PERSON_ACTION_00
	dw SetFacingStandAction,           SetFacingCurrent      ; PERSON_ACTION_STAND
	dw SetFacingStepAction,            SetFacingCurrent      ; PERSON_ACTION_STEP
	dw SetFacingBumpAction,            SetFacingCurrent      ; PERSON_ACTION_BUMP
	dw SetFacingCounterclockwiseSpin,  SetFacingCurrent      ; PERSON_ACTION_SPIN
	dw SetFacingCounterclockwiseSpin2, SetFacingStanding     ; PERSON_ACTION_SPIN_FLICKER
	dw SetFacingFish,                  SetFacingFish         ; PERSON_ACTION_FISHING
	dw SetFacingShadow,                SetFacingStanding     ; PERSON_ACTION_SHADOW
	dw SetFacingEmote,                 SetFacingEmote        ; PERSON_ACTION_EMOTE
	dw SetFacingBigDollSym,            SetFacingBigDollSym   ; PERSON_ACTION_BIG_SNORLAX
	dw SetFacingBounce,                SetFacingFreezeBounce ; PERSON_ACTION_BOUNCE
	dw SetFacingWeirdTree,             SetFacingCurrent      ; PERSON_ACTION_WEIRD_TREE
	dw SetFacingBigDoll,               SetFacingBigDoll      ; PERSON_ACTION_BIG_DOLL
	dw SetFacingBoulderDust,           SetFacingStanding     ; PERSON_ACTION_BOULDER_DUST
	dw SetFacingGrassShake,            SetFacingStanding     ; PERSON_ACTION_GRASS_SHAKE
	dw SetFacingSkyfall,               SetFacingCurrent      ; PERSON_ACTION_SKYFALL
	dw SetFacingRun,                   SetFacingCurrent      ; PERSON_ACTION_RUN
; 44a3

SetFacingStanding: ; 44a3
	ld hl, OBJECT_FACING_STEP
	add hl, bc
	ld [hl], STANDING
	ret
; 44aa

SetFacingCurrent: ; 44aa
	call GetSpriteDirection
	ld hl, OBJECT_FACING_STEP
	add hl, bc
	ld [hl], a
	ret
; 44b5

SetFacingStandAction:
	ld hl, OBJECT_FACING_STEP
	add hl, bc
	ld a, [hl]
	and 1
	jp z, SetFacingCurrent
	; fallthrough

SetFacingStepAction:
SetFacingBumpAction:
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
	jp nz, SetFacingCurrent

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
	ld hl, OBJECT_FACING_STEP
	add hl, bc
	ld [hl], a
	ret

SetFacingCounterclockwiseSpin: ; 4529
	call CounterclockwiseSpinAction
	ld hl, OBJECT_FACING
	add hl, bc
	ld a, [hl]
	ld hl, OBJECT_FACING_STEP
	add hl, bc
	ld [hl], a
	ret
; 4539

SetFacingCounterclockwiseSpin2: ; 4539
	call CounterclockwiseSpinAction
	jp SetFacingStanding
; 453f

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

SetFacingFish: ; 456e
	call GetSpriteDirection
	rrca
	rrca
	add $10
	ld hl, OBJECT_FACING_STEP
	add hl, bc
	ld [hl], a
	ret

SetFacingShadow:
	ld hl, OBJECT_FACING_STEP
	add hl, bc
	ld [hl], FACING_SHADOW
	ret

SetFacingEmote:
	ld hl, OBJECT_FACING_STEP
	add hl, bc
	ld [hl], FACING_EMOTE
	ret

SetFacingBigDollSym:
	ld hl, OBJECT_FACING_STEP
	add hl, bc
	ld [hl], FACING_BIG_DOLL_SYM
	ret

SetFacingBounce: ; 4590
	ld hl, OBJECT_STEP_FRAME
	add hl, bc
	ld a, [hl]
	inc a
	and %00001111
	ld [hl], a
	and %00001000
	jr z, SetFacingFreezeBounce
	ld hl, OBJECT_FACING_STEP
	add hl, bc
	ld [hl], FACING_STEP_UP_0
	ret
; 45a4

SetFacingFreezeBounce: ; 45a4
	ld hl, OBJECT_FACING_STEP
	add hl, bc
	ld [hl], 0
	ret
; 45ab

SetFacingWeirdTree: ; 45ab
	ld hl, OBJECT_STEP_FRAME
	add hl, bc
	ld a, [hl]
	inc a
	ld [hl], a
	and %00001100
	rrca
	rrca
	add FACING_WEIRD_TREE_0
	ld hl, OBJECT_FACING_STEP
	add hl, bc
	ld [hl], a
	ret
; 45be

SetFacingBigDoll: ; 45c5
	ld a, [VariableSprites + SPRITE_BIG_DOLL - SPRITE_VARS]
	ld d, FACING_BIG_DOLL_SYM ; symmetric
	cp SPRITE_BIG_SNORLAX
	jr z, .ok
	cp SPRITE_BIG_LAPRAS
	jr z, .ok
	ld d, FACING_BIG_DOLL_ASYM ; asymmetric

.ok
	ld hl, OBJECT_FACING_STEP
	add hl, bc
	ld [hl], d
	ret
; 45da

SetFacingBoulderDust: ; 45da
	ld hl, OBJECT_STEP_FRAME
	add hl, bc
	inc [hl]
	ld a, [hl]

	ld hl, OBJECT_FACING_STEP
	add hl, bc
	and 2
	ld a, FACING_BOULDER_DUST_1
	jr z, .ok
	inc a ; FACING_BOULDER_DUST_2
.ok
	ld [hl], a
	ret
; 45ed

SetFacingGrassShake:
	ld hl, OBJECT_STEP_FRAME
	add hl, bc
	inc [hl]
	ld a, [hl]
	ld hl, OBJECT_FACING_STEP
	add hl, bc
	and 4
	ld a, FACING_GRASS_1
	jr z, .ok
	inc a ; FACING_GRASS_2

.ok
	ld [hl], a
	ret

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
