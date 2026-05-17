MACRO movement
if _NARG == 2
	db \2
else
	db 0
endc
	dw \1
ENDM

DoMovementFunction:
	push af
	call ApplyMovementToFollower
	pop af
	ld hl, .MovementPointers
	ld e, a
	ld d, 0
	add hl, de
	add hl, de
	add hl, de
	ld a, [hli]
	ld d, a
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, d
	jp hl

.MovementPointers:
; entries correspond to movement_* constants (see macros/scripts/movement.asm)
	table_width 3
	movement TurnHead,           OW_DOWN                  ; 00
	movement TurnHead,           OW_UP                    ; 01
	movement TurnHead,           OW_LEFT                  ; 02
	movement TurnHead,           OW_RIGHT                 ; 03
	movement TurnStep,           OW_DOWN                  ; 04
	movement TurnStep,           OW_UP                    ; 05
	movement TurnStep,           OW_LEFT                  ; 06
	movement TurnStep,           OW_RIGHT                 ; 07
	movement NormalStep,         STEP_SLOW << 2 | DOWN    ; 08
	movement NormalStep,         STEP_SLOW << 2 | UP      ; 09
	movement NormalStep,         STEP_SLOW << 2 | LEFT    ; 0a
	movement NormalStep,         STEP_SLOW << 2 | RIGHT   ; 0b
	movement NormalStep,         STEP_WALK << 2 | DOWN    ; 0c
	movement NormalStep,         STEP_WALK << 2 | UP      ; 0d
	movement NormalStep,         STEP_WALK << 2 | LEFT    ; 0e
	movement NormalStep,         STEP_WALK << 2 | RIGHT   ; 0f
	movement NormalStep,         STEP_BIKE << 2 | DOWN    ; 10
	movement NormalStep,         STEP_BIKE << 2 | UP      ; 11
	movement NormalStep,         STEP_BIKE << 2 | LEFT    ; 12
	movement NormalStep,         STEP_BIKE << 2 | RIGHT   ; 13
	movement SlideStep,          STEP_SLOW << 2 | DOWN    ; 14
	movement SlideStep,          STEP_SLOW << 2 | UP      ; 15
	movement SlideStep,          STEP_SLOW << 2 | LEFT    ; 16
	movement SlideStep,          STEP_SLOW << 2 | RIGHT   ; 17
	movement SlideStep,          STEP_WALK << 2 | DOWN    ; 18
	movement SlideStep,          STEP_WALK << 2 | UP      ; 19
	movement SlideStep,          STEP_WALK << 2 | LEFT    ; 1a
	movement SlideStep,          STEP_WALK << 2 | RIGHT   ; 1b
	movement SlideStep,          STEP_RUN << 2 | DOWN     ; 1c
	movement SlideStep,          STEP_RUN << 2 | UP       ; 1d
	movement SlideStep,          STEP_RUN << 2 | LEFT     ; 1e
	movement SlideStep,          STEP_RUN << 2 | RIGHT    ; 1f
	movement TurningStep,        STEP_SLOW << 2 | DOWN    ; 20
	movement TurningStep,        STEP_SLOW << 2 | UP      ; 21
	movement TurningStep,        STEP_SLOW << 2 | LEFT    ; 22
	movement TurningStep,        STEP_SLOW << 2 | RIGHT   ; 23
	movement TurningStep,        STEP_WALK << 2 | DOWN    ; 24
	movement TurningStep,        STEP_WALK << 2 | UP      ; 25
	movement TurningStep,        STEP_WALK << 2 | LEFT    ; 26
	movement TurningStep,        STEP_WALK << 2 | RIGHT   ; 27
	movement TurningStep,        STEP_WALK << 2 | DOWN    ; 28
	movement TurningStep,        STEP_WALK << 2 | UP      ; 29
	movement TurningStep,        STEP_WALK << 2 | LEFT    ; 2a
	movement TurningStep,        STEP_WALK << 2 | RIGHT   ; 2b
	movement JumpStep,           STEP_SLOW << 2 | DOWN    ; 2c
	movement JumpStep,           STEP_SLOW << 2 | UP      ; 2d
	movement JumpStep,           STEP_SLOW << 2 | LEFT    ; 2e
	movement JumpStep,           STEP_SLOW << 2 | RIGHT   ; 2f
	movement JumpStep,           STEP_WALK << 2 | DOWN    ; 30
	movement JumpStep,           STEP_WALK << 2 | UP      ; 31
	movement JumpStep,           STEP_WALK << 2 | LEFT    ; 32
	movement JumpStep,           STEP_WALK << 2 | RIGHT   ; 33
	movement JumpStep,           STEP_BIKE << 2 | DOWN    ; 34
	movement JumpStep,           STEP_BIKE << 2 | UP      ; 35
	movement JumpStep,           STEP_BIKE << 2 | LEFT    ; 36
	movement JumpStep,           STEP_BIKE << 2 | RIGHT   ; 37
	movement ObjectFlags1Step,   $86 + 8 * SLIDING_F      ; 38
	movement ObjectFlags1Step,   $c6 + 8 * SLIDING_F      ; 39
	movement ObjectFlags1Step,   $86 + 8 * FIXED_FACING_F ; 3a
	movement ObjectFlags1Step,   $c6 + 8 * FIXED_FACING_F ; 3b
	movement ObjectFlags1Step,   $86 + 8 * INVISIBLE_F    ; 3c
	movement ObjectFlags1Step,   $c6 + 8 * INVISIBLE_F    ; 3d
	movement SleepStep,          1                        ; 3e
	movement SleepStep,          2                        ; 3f
	movement SleepStep,          3                        ; 40
	movement SleepStep,          4                        ; 41
	movement SleepStep,          5                        ; 42
	movement SleepStep,          6                        ; 43
	movement SleepStep,          7                        ; 44
	movement SleepStep,          8                        ; 45
	movement LongSleepStep                                ; 46
	movement EndStep                                      ; 47
	movement RemoveObject                                 ; 48
	movement SetStepType,        STEP_TYPE_TELEPORT_FROM  ; 49
	movement SetStepType,        STEP_TYPE_TELEPORT_TO    ; 4a
	movement SetStepType,        STEP_TYPE_SKYFALL        ; 4b
	movement DigStep,            STEP_TYPE_SLEEP          ; 4c
	movement BumpStep,           1                        ; 4d
	movement FishingStep,        STEP_TYPE_GOT_BITE       ; 4e
	movement FishingStep,        STEP_TYPE_FROM_MOVEMENT  ; 4f
	movement HideEmote                                    ; 50
	movement ShowEmote                                    ; 51
	movement ShakeScreenStep                              ; 52
	movement ShakeTree,          24                       ; 53
	movement SmashRock                                    ; 54
	movement ReturnDig,          STEP_TYPE_RETURN_DIG     ; 55
	movement SetStepType,        STEP_TYPE_SKYFALL_TOP    ; 56
	movement RunStep,            STEP_RUN << 2 | DOWN     ; 57
	movement RunStep,            STEP_RUN << 2 | UP       ; 58
	movement RunStep,            STEP_RUN << 2 | LEFT     ; 59
	movement RunStep,            STEP_RUN << 2 | RIGHT    ; 5a
	movement NormalStep,         STEP_RUN << 2 | DOWN     ; 5b
	movement NormalStep,         STEP_RUN << 2 | UP       ; 5c
	movement NormalStep,         STEP_RUN << 2 | LEFT     ; 5d
	movement NormalStep,         STEP_RUN << 2 | RIGHT    ; 5e
	movement DiagonalStairsStep, STEP_WALK << 2 | DOWN    ; 5f
	movement DiagonalStairsStep, STEP_WALK << 2 | UP      ; 60
	movement DiagonalStairsStep, STEP_WALK << 2 | LEFT    ; 61
	movement DiagonalStairsStep, STEP_WALK << 2 | RIGHT   ; 62
	movement ShakeExeggutor,     64                       ; 63
	movement NormalStep,         STEP_WALK << 2 | RIGHT   ; 64
	movement HalfStep,           STEP_WALK << 2 | DOWN    ; 65
	movement HalfStep,           STEP_WALK << 2 | UP      ; 66
	movement HalfStep,           STEP_WALK << 2 | LEFT    ; 67
	movement HalfStep,           STEP_WALK << 2 | RIGHT   ; 68
	assert_table_length NUM_MOVEMENT_CMDS

FishingStep:
	ld hl, OBJECT_ACTION
	add hl, bc
	ld [hl], OBJECT_ACTION_FISHING
	; fallthrough
SetStepType:
	ld hl, OBJECT_STEP_TYPE
	add hl, bc
	ld [hl], a
	ret

DigStep:
	ld hl, OBJECT_ACTION
	add hl, bc
	ld [hl], OBJECT_ACTION_SPIN
	; fallthrough
ReturnDig:
	ld hl, OBJECT_STEP_TYPE
	add hl, bc
	ld [hl], a

	call GetSpriteDirection
	rlca
	rlca
	ld hl, OBJECT_STEP_FRAME
	add hl, bc
	ld [hl], a

	call JumpMovementPointer
	ld hl, OBJECT_STEP_DURATION
	add hl, bc
	ld [hl], a

	ld hl, OBJECT_WALKING
	add hl, bc
	ld [hl], STANDING
	ret

SmashRock:
	call JumpMovementPointer
	ld hl, OBJECT_STEP_DURATION
	add hl, bc
	ld [hl], a

	ld hl, OBJECT_ACTION
	add hl, bc
	ld [hl], OBJECT_ACTION_STAND

	ld hl, OBJECT_STEP_TYPE
	add hl, bc
	ld [hl], STEP_TYPE_ROCK_SMASH
	ret

EndStep:
	call RestoreDefaultMovement
	ld hl, OBJECT_MOVEMENT_TYPE
	add hl, bc
	ld [hl], a

	ld hl, OBJECT_MOVEMENT_INDEX
	add hl, bc
	ld [hl], $0

	ld hl, wStateFlags
	res SCRIPTED_MOVEMENT_STATE_F, [hl]

	ld hl, OBJECT_STEP_TYPE
	add hl, bc
	ld [hl], STEP_TYPE_FROM_MOVEMENT
	ret

RemoveObject:
	call DeleteMapObject
	ld hl, wObjectFollow_Leader
	ldh a, [hMapObjectIndexBuffer]
	cp [hl]
	jr nz, .not_leading
	ld [hl], -1
.not_leading
	ld hl, wStateFlags
	res SCRIPTED_MOVEMENT_STATE_F, [hl]
	ret

LongSleepStep:
	call JumpMovementPointer
	; fallthrough
SleepStep:
	ld hl, OBJECT_STEP_TYPE
	add hl, bc
	ld [hl], STEP_TYPE_SLEEP

	ld hl, OBJECT_ACTION
	add hl, bc
	ld [hl], OBJECT_ACTION_STAND
	; fallthrough
_ContinueDurationStep:
	ld hl, OBJECT_STEP_DURATION
	add hl, bc
	ld [hl], a

	ld hl, OBJECT_WALKING
	add hl, bc
	ld [hl], STANDING
	ret

BumpStep:
	ld hl, OBJECT_STEP_TYPE
	add hl, bc
	ld [hl], STEP_TYPE_BUMP

	ld hl, OBJECT_ACTION
	add hl, bc
	ld [hl], OBJECT_ACTION_BUMP

	jr _ContinueDurationStep

ShakeExeggutor:
	ld d, OBJECT_ACTION_SHAKE_EXEGGUTOR
	jr _ShakeStep

ShakeTree:
	ld d, OBJECT_ACTION_WEIRD_TREE
_ShakeStep:
	ld hl, OBJECT_STEP_DURATION
	add hl, bc
	ld [hl], a

	ld hl, OBJECT_STEP_TYPE
	add hl, bc
	ld [hl], STEP_TYPE_SLEEP

	ld hl, OBJECT_ACTION
	add hl, bc
	ld [hl], d

	ld hl, OBJECT_WALKING
	add hl, bc
	ld [hl], STANDING
	ret

ObjectFlags1Step:
; $86 + 8 * <FLAG>_F = res <FLAG>_F, [hl]
; $c6 + 8 * <FLAG>_F = set <FLAG>_F, [hl]
	ld hl, OBJECT_FLAGS1
	add hl, bc
	ldh [hBitwiseFunctionOpcode], a
	call hBitwiseFunction
	jmp ContinueReadingMovement

HideEmote:
	call DespawnEmote
	jmp ContinueReadingMovement

ShowEmote:
	call SpawnEmote
	jmp ContinueReadingMovement

ShakeScreenStep:
	call JumpMovementPointer
	call ShakeScreen
	jmp ContinueReadingMovement

TurnHead:
	ld hl, OBJECT_DIRECTION
	add hl, bc
	ld [hl], a

	ld hl, OBJECT_ACTION
	add hl, bc
	ld [hl], OBJECT_ACTION_STAND

	ld hl, OBJECT_WALKING
	add hl, bc
	ld [hl], STANDING
	ret

TurnStep:
	ld hl, OBJECT_1D ; new facing
	add hl, bc
	ld [hl], a

	ld hl, OBJECT_ACTION
	add hl, bc
	ld [hl], OBJECT_ACTION_STEP

	ld hl, OBJECT_STEP_TYPE
	add hl, bc
	ld [hl], STEP_TYPE_TURN
	ret

RunStep:
	lb de, OBJECT_ACTION_RUN, TRUE
	jr _ContinueStep

TurningStep:
	lb de, OBJECT_ACTION_SPIN, FALSE
	jr _ContinueStep

SlideStep:
	lb de, OBJECT_ACTION_STAND, FALSE
	jr _ContinueStep

NormalStep:
	lb de, OBJECT_ACTION_STEP, TRUE
	; fallthrough
_ContinueStep:
	push de
	call InitStep
	call UpdateTallGrassFlags
	pop de

	ld hl, OBJECT_ACTION
	add hl, bc
	ld [hl], d

	ld a, e
	and a
	call nz, DoStepSideEffect

	ld d, STEP_TYPE_NPC_WALK
	assert STEP_TYPE_NPC_WALK + 1 == STEP_TYPE_PLAYER_WALK
	; fallthrough
SetNPCOrPlayerStepType:
	ld hl, wCenteredObject
	ldh a, [hMapObjectIndexBuffer]
	cp [hl]
	ld hl, OBJECT_STEP_TYPE
	add hl, bc
	jr nz, .not_player
	inc d
.not_player
	ld [hl], d
	ret

DoStepSideEffect:
	ld hl, OBJECT_FLAGS1
	add hl, bc
	bit INVISIBLE_F, [hl]
	ret nz
	ld a, [wFollowInSync]
	and a
	jr z, .no_sync
	ld de, SFX_SQUEAK ; for Spinarak carts in Azalea Gym
	call PlaySFX
.no_sync
	ld hl, OBJECT_TILE_COLLISION
	add hl, bc
	ld a, [hl]
	cp COLL_LONG_GRASS
	jmp z, ShakeGrass
	cp COLL_TALL_GRASS
	jmp z, ShakeGrass
	cp COLL_PUDDLE
	jmp z, SplashPuddle
	ret

JumpStep:
	call InitStep
	ld hl, OBJECT_JUMP_HEIGHT
	add hl, bc
	ld [hl], $0

	ld hl, OBJECT_FLAGS2
	add hl, bc
	res IN_GRASS_F, [hl]

	ld hl, OBJECT_ACTION
	add hl, bc
	ld [hl], OBJECT_ACTION_STEP

	call SpawnShadow

	ld d, STEP_TYPE_NPC_JUMP
	assert STEP_TYPE_NPC_JUMP + 1 == STEP_TYPE_PLAYER_JUMP
	jr SetNPCOrPlayerStepType

DiagonalStairsStep:
	call InitStep
	ld hl, OBJECT_JUMP_HEIGHT
	add hl, bc
	ld [hl], $0

	ld hl, OBJECT_ACTION
	add hl, bc
	ld [hl], OBJECT_ACTION_STEP

	ld d, STEP_TYPE_NPC_STAIRS
	assert STEP_TYPE_NPC_STAIRS + 1 == STEP_TYPE_PLAYER_STAIRS
	jr SetNPCOrPlayerStepType

HalfStep:
	ld hl, OBJECT_ACTION
	add hl, bc
	ld [hl], OBJECT_ACTION_STEP

	call StartInitStep

	ld hl, OBJECT_WALKING
	add hl, bc
	assert LEFT == %10 && RIGHT == %11
	bit 1, [hl]
	ld hl, OBJECT_SPRITE_X_OFFSET
	jr nz, .ok
	assert OBJECT_SPRITE_X_OFFSET + 1 == OBJECT_SPRITE_Y_OFFSET
	inc hl
.ok
	add hl, bc
	ld a, [hl]
	and a
	jr nz, .part2

	ld hl, OBJECT_STEP_DURATION
	add hl, bc
	ld [hl], 8

	ld hl, OBJECT_STEP_TYPE
	add hl, bc
	ld [hl], STEP_TYPE_HALF1
	ret

.part2
	call GetNextTile
	call UpdateTallGrassFlags

	call DoStepSideEffect

	ld d, STEP_TYPE_NPC_HALF2
	assert STEP_TYPE_NPC_HALF2 + 1 == STEP_TYPE_PLAYER_HALF2
	jmp SetNPCOrPlayerStepType
