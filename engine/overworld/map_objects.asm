INCLUDE "data/sprites/facings.asm"
INCLUDE "data/sprites/map_objects.asm"

DeleteMapObject::
	push bc
	ld hl, OBJECT_MAP_OBJECT_INDEX
	add hl, bc
	ld a, [hl]
	push af
	ld h, b
	ld l, c
	ld bc, OBJECT_STRUCT_LENGTH
	xor a
	rst ByteFill
	pop af
	cp -1
	jr z, .ok
	bit 7, a
	jr nz, .ok
	call GetMapObject
	ld hl, OBJECT_SPRITE
	add hl, bc
	ld [hl], -1
.ok
	pop bc
	ret

HandleCurNPCStep:
	call .CheckObjectStillVisible
	ret c
	call .HandleStepType
	jp .HandleObjectAction

.CheckObjectStillVisible
	ld hl, OBJECT_FLAGS2
	add hl, bc
	res 6, [hl]
	ldh a, [hMapObjectIndexBuffer]
	and a
	jr nz, .notPlayer
; hardcode for crossing over connections
	ld a, [wYCoord]
	inc a
	jr z, .yes
	ld a, [wXCoord]
	inc a
	jr z, .yes
.notPlayer
	ld a, [wXCoord]
	ld e, a
	ld hl, OBJECT_NEXT_MAP_X
	add hl, bc
	ld a, [hl]
	inc a
	sub e
	jr c, .ok
	cp MAPOBJECT_SCREEN_WIDTH
	jr nc, .ok
	ld a, [wYCoord]
	ld e, a
	ld hl, OBJECT_NEXT_MAP_Y
	add hl, bc
	ld a, [hl]
	inc a
	sub e
	jr c, .ok
	cp MAPOBJECT_SCREEN_HEIGHT
	jr c, .yes

.ok
	ld hl, OBJECT_FLAGS2
	add hl, bc
	set 6, [hl]
	ld a, [wXCoord]
	ld e, a
	ld hl, OBJECT_INIT_X
	add hl, bc
	ld a, [hl]
	inc a
	sub e
	jr c, .ok2
	cp MAPOBJECT_SCREEN_WIDTH
	jr nc, .ok2
	ld a, [wYCoord]
	ld e, a
	ld hl, OBJECT_INIT_Y
	add hl, bc
	ld a, [hl]
	inc a
	sub e
	jr c, .ok2
	cp MAPOBJECT_SCREEN_HEIGHT
	jr nc, .ok2
.yes
	and a
	ret

.ok2
	ld hl, OBJECT_FLAGS1
	add hl, bc
	bit 1, [hl]
	jr nz, .yes2
	call DeleteMapObject
	scf
	ret

.yes2
	ld hl, OBJECT_FLAGS2
	add hl, bc
	set 6, [hl]
	and a
	ret

.HandleStepType
	ld hl, OBJECT_STEP_TYPE
	add hl, bc
	ld a, [hl]
	and a
	jr z, .null_step_type
	ld hl, OBJECT_FLAGS2
	add hl, bc
	bit OBJECT_DISABLE_STEP_TYPE, [hl]
	ret nz
	cp STEP_TYPE_SLEEP
	jr z, .map_object_movement_pattern
	jr .do_step_type

.null_step_type
	call ObjectMovementReset
	ld hl, OBJECT_FLAGS2
	add hl, bc
	bit OBJECT_DISABLE_STEP_TYPE, [hl]
	ret nz
.map_object_movement_pattern
	call MapObjectMovementPattern
	ld hl, OBJECT_STEP_TYPE
	add hl, bc
	ld a, [hl]
	and a
	ret z
	cp STEP_TYPE_SLEEP
	ret z
.do_step_type
	ld hl, StepTypesJumptable
	call JumpTable
	ret

.HandleObjectAction
	ld hl, OBJECT_FLAGS1
	add hl, bc
	bit INVISIBLE, [hl]
	jp nz, SetFacingStanding
	ld hl, OBJECT_FLAGS2
	add hl, bc
	bit 6, [hl]
	jp nz, SetFacingStanding
	bit OBJECT_DISABLE_STEP_TYPE, [hl]
	jr nz, asm_4448
	ld de, Pointers445f ; use first column
	jr asm_444d

HandleMapObjectAction_Stationary:
	ld hl, OBJECT_FLAGS1
	add hl, bc
	bit INVISIBLE, [hl]
	jr nz, SetFacingStanding
asm_4448: ; use second column
	ld de, Pointers445f + 2
	; fallthrough

asm_444d:
	; call [4 * wObjectStructs[ObjInd, OBJECT_ACTION] + de]
	ld hl, OBJECT_ACTION
	add hl, bc
	ld a, [hl]
	ld l, a
	ld h, 0
	add hl, hl
	add hl, hl
	add hl, de
	jp IndirectHL

INCLUDE "engine/overworld/map_object_action.asm"

CopyNextCoordsTileToStandingCoordsTile:
	ld hl, OBJECT_NEXT_MAP_X
	add hl, bc
	ld a, [hl]
	ld hl, OBJECT_MAP_X
	add hl, bc
	ld [hl], a
	ld hl, OBJECT_NEXT_MAP_Y
	add hl, bc
	ld a, [hl]
	ld hl, OBJECT_MAP_Y
	add hl, bc
	ld [hl], a
	ld hl, OBJECT_NEXT_TILE
	add hl, bc
	ld a, [hl]
	ld hl, OBJECT_STANDING_TILE
	add hl, bc
	ld [hl], a
	call SetTallGrassFlags
	ld hl, OBJECT_NEXT_TILE
	add hl, bc
	ld a, [hl]
	ret

CopyCurCoordsToNextCoords:
	ld hl, OBJECT_MAP_X
	add hl, bc
	ld a, [hl]
	ld hl, OBJECT_NEXT_MAP_X
	add hl, bc
	ld [hl], a
	ld hl, OBJECT_MAP_Y
	add hl, bc
	ld a, [hl]
	ld hl, OBJECT_NEXT_MAP_Y
	add hl, bc
	ld [hl], a
	ret

UpdateTallGrassFlags:
	ld hl, OBJECT_FLAGS2
	add hl, bc
	bit OVERHEAD, [hl]
	jr z, .ok
	ld hl, OBJECT_NEXT_TILE
	add hl, bc
	ld a, [hl]
	call SetTallGrassFlags
.ok
	ld hl, OBJECT_STANDING_TILE
	add hl, bc
	ld a, [hl]
	ret

SetTallGrassFlags:
	ld hl, OBJECT_FLAGS2
	add hl, bc
	cp COLL_OVERHEAD
	jr z, .set
	cp COLL_LONG_GRASS
	jr z, .set
	cp COLL_TALL_GRASS
	jr z, .set
	res OVERHEAD, [hl]
	ret

.set
	set OVERHEAD, [hl]
	ret

EndSpriteMovement:
	xor a
	ld hl, OBJECT_STEP_FRAME
	add hl, bc
	ld [hl], a
	ld hl, OBJECT_MOVEMENT_BYTE_INDEX
	add hl, bc
	ld [hli], a ; OBJECT_MOVEMENT_BYTE_INDEX
	ld [hli], a ; OBJECT_28
	ld [hli], a ; OBJECT_29
	ld [hl], a ; OBJECT_30
	ld hl, OBJECT_DIRECTION_WALKING
	add hl, bc
	ld [hl], STANDING
	ret

InitStep:
	ld hl, OBJECT_DIRECTION_WALKING
	add hl, bc
	ld [hl], a
	ld hl, OBJECT_FLAGS1
	add hl, bc
	bit FIXED_FACING, [hl]
	jr nz, GetNextTile
	add a
	add a
	and %00001100
	ld hl, OBJECT_FACING
	add hl, bc
	ld [hl], a
GetNextTile:
	call GetStepVector
	ld hl, OBJECT_STEP_DURATION
	add hl, bc
	ld [hl], a
	ld a, d
	call GetStepVectorSign
	ld hl, OBJECT_MAP_X
	add hl, bc
	add [hl]
	ld hl, OBJECT_NEXT_MAP_X
	add hl, bc
	ld [hl], a
	ld d, a
	ld a, e
	call GetStepVectorSign
	ld hl, OBJECT_MAP_Y
	add hl, bc
	add [hl]
	ld hl, OBJECT_NEXT_MAP_Y
	add hl, bc
	ld [hl], a
	ld e, a
	push bc
	call GetCoordTile
	pop bc
	ld hl, OBJECT_NEXT_TILE
	add hl, bc
	ld [hl], a
	ret

AddStepVector:
	call GetStepVector
	jr nc, .ok
	ld hl, OBJECT_STEP_DURATION
	add hl, bc
	ld a, [hl]
	and %1
	jr nz, .ok
	lb de, 0, 0
.ok
	ld hl, OBJECT_SPRITE_X
	add hl, bc
	ld a, [hl]
	add d
	ld [hl], a
	ld hl, OBJECT_SPRITE_Y
	add hl, bc
	ld a, [hl]
	add e
	ld [hl], a
	ret

GetStepVector:
; Return (x, y, duration, speed) in (d, e, a, h).
	ld hl, OBJECT_DIRECTION_WALKING
	add hl, bc
	ld a, [hl]
	and %00001111
	add a
	add a
	ld l, a
	ld h, 0
	ld de, StepVectors
	add hl, de
	ld d, [hl]
	inc hl
	ld e, [hl]
	inc hl
	ld a, [hli]
	ld h, [hl]
	push af
	push hl
	ld hl, OBJECT_DIRECTION_WALKING
	add hl, bc
	ld a, [hl]
	cp (STEP_SLOW << 2 | RIGHT) + 1
	jr c, .slowStep
	pop hl
	pop af
	and a
	ret
.slowStep
	pop hl
	pop af
	scf
	ret

StepVectors:
; x,  y, duration, speed
	; slow
	db  0,  1, 32, 1
	db  0, -1, 32, 1
	db -1,  0, 32, 1
	db  1,  0, 32, 1
	; normal
	db  0,  1, 16, 1
	db  0, -1, 16, 1
	db -1,  0, 16, 1
	db  1,  0, 16, 1
	; fast/bike
	db  0,  4,  4, 4
	db  0, -4,  4, 4
	db -4,  0,  4, 4
	db  4,  0,  4, 4
	; running shoes
	db  0,  2,  8, 2
	db  0, -2,  8, 2
	db -2,  0,  8, 2
	db  2,  0,  8, 2

GetStepVectorSign:
	add a
	ret z  ; 0 or 128
	ld a, 1
	ret nc ; 1 - 127
	ld a, -1
	ret    ; 129 - 255

UpdatePlayerStep:
	ld hl, OBJECT_DIRECTION_WALKING
	add hl, bc
	ld a, [hl]
	and %00000011
	ld [wPlayerStepDirection], a
	call AddStepVector
	ld a, [wPlayerStepVectorX]
	add d
	ld [wPlayerStepVectorX], a
	ld a, [wPlayerStepVectorY]
	add e
	ld [wPlayerStepVectorY], a
	ld hl, wPlayerStepFlags
	set 5, [hl]
	ret

RestoreDefaultMovement:
	ld hl, OBJECT_MAP_OBJECT_INDEX
	add hl, bc
	ld a, [hl]
	cp -1
	jr z, .ok
	push bc
	call GetMapObject
	ld hl, MAPOBJECT_MOVEMENT
	add hl, bc
	ld a, [hl]
	pop bc
	ret

.ok
	ld a, SPRITEMOVEFN_STANDING
	ret

IncrementObjectMovementByteIndex:
	ld hl, OBJECT_MOVEMENT_BYTE_INDEX
	add hl, bc
	inc [hl]
	ret

DecrementObjectMovementByteIndex:
	ld hl, OBJECT_MOVEMENT_BYTE_INDEX
	add hl, bc
	dec [hl]
	ret

MovementAnonymousJumptable:
	ld hl, OBJECT_MOVEMENT_BYTE_INDEX
	add hl, bc
	ld a, [hl]
	pop hl
	call JumpTable
	ret

ClearObjectStructField28:
	ld hl, OBJECT_28
	add hl, bc
	ld [hl], 0
	ret

IncrementObjectStructField28:
	ld hl, OBJECT_28
	add hl, bc
	inc [hl]
	ret

Object28AnonymousJumptable:
	ld hl, OBJECT_28
	add hl, bc
	ld a, [hl]
	pop hl
	call JumpTable
	ret

ObjectMovementReset:
	ld hl, OBJECT_NEXT_MAP_X
	add hl, bc
	ld d, [hl]
	ld hl, OBJECT_NEXT_MAP_Y
	add hl, bc
	ld e, [hl]
	push bc
	call GetCoordTile
	pop bc
	ld hl, OBJECT_NEXT_TILE
	add hl, bc
	ld [hl], a
	call CopyNextCoordsTileToStandingCoordsTile
	call EndSpriteMovement
	ld hl, OBJECT_STEP_TYPE
	add hl, bc
	ld [hl], STEP_TYPE_SLEEP
	ret

MapObjectMovementPattern:
	call ClearObjectStructField28
	call GetSpriteMovementFunction
	ld a, [hl]
	ld hl, .Pointers
	call JumpTable
	ret

.Pointers:
	dw DoNothing                     ; SPRITEMOVEFN_00
	dw .RandomWalkY                  ; SPRITEMOVEFN_RANDOM_WALK_Y
	dw .RandomWalkX                  ; SPRITEMOVEFN_RANDOM_WALK_X
	dw .RandomWalkXY                 ; SPRITEMOVEFN_RANDOM_WALK_XY
	dw .RandomSpin1                  ; SPRITEMOVEFN_SLOW_RANDOM_SPIN
	dw .RandomSpin2                  ; SPRITEMOVEFN_FAST_RANDOM_SPIN
	dw .Standing                     ; SPRITEMOVEFN_STANDING
	dw .ObeyDPad                     ; SPRITEMOVEFN_OBEY_DPAD
	dw .Follow                       ; SPRITEMOVEFN_FOLLOW
	dw .Script                       ; SPRITEMOVEFN_SCRIPTED
	dw .Strength                     ; SPRITEMOVEFN_STRENGTH
	dw .FollowNotExact               ; SPRITEMOVEFN_FOLLOWNOTEXACT
	dw .MovementShadow               ; SPRITEMOVEFN_SHADOW
	dw .MovementEmote                ; SPRITEMOVEFN_EMOTE
	dw .MovementBigStanding          ; SPRITEMOVEFN_BIG_SNORLAX
	dw .MovementBouncing             ; SPRITEMOVEFN_BOUNCE
	dw .MovementScreenShake          ; SPRITEMOVEFN_SCREENSHAKE
	dw .MovementSpinClockwise        ; SPRITEMOVEFN_SPIN_CLOCKWISE
	dw .MovementSpinCounterclockwise ; SPRITEMOVEFN_SPIN_COUNTERCLOCKWISE
	dw .MovementBoulderDust          ; SPRITEMOVEFN_BOULDERDUST
	dw .MovementShakingGrass         ; SPRITEMOVEFN_GRASS
	dw .MovementSplashingPuddle      ; SPRITEMOVEFN_PUDDLE
	dw .MovementCutTree              ; SPRITEMOVEFN_CUT_TREE
	dw .MovementFruit                ; SPRITEMOVEFN_FRUIT
	dw .MovementBigGyarados          ; SPRITEMOVEFN_BIG_GYARADOS
	dw .StandingFlip                 ; SPRITEMOVEFN_STANDING_FLIP
	dw .MovementPokecomNews          ; SPRITEMOVEFN_POKECOM_NEWS
	dw .MovementArchTree             ; SPRITEMOVEFN_ARCH_TREE
	dw .MovementSailboatTop          ; SPRITEMOVEFN_SAILBOAT_TOP
	dw .MovementSailboatBottom       ; SPRITEMOVEFN_SAILBOAT_BOTTOM

.RandomWalkY:
	call Random
	ldh a, [hRandomAdd]
	and %00000001
	jp .RandomWalkContinue

.RandomWalkX:
	call Random
	ldh a, [hRandomAdd]
	and %00000001
	or  %00000010
	jp .RandomWalkContinue

.RandomWalkXY:
	call Random
	ldh a, [hRandomAdd]
	and %00000011
	jp .RandomWalkContinue

.RandomSpin1:
	call Random
	ldh a, [hRandomAdd]
	and %00001100
	ld hl, OBJECT_FACING
	add hl, bc
	ld [hl], a
	jp RandomStepDuration_Slow

.RandomSpin2:
	ld hl, OBJECT_FACING
	add hl, bc
	ld a, [hl]
	and %00001100
	ld d, a
	call Random
	ldh a, [hRandomAdd]
	and %00001100
	cp d
	jr nz, .keep
	xor %00001100
.keep
	ld [hl], a
	jp RandomStepDuration_Fast

.Standing:
	call CopyCurCoordsToNextCoords
	call EndSpriteMovement
	ld hl, OBJECT_ACTION
	add hl, bc
	ld [hl], PERSON_ACTION_STAND
	ld hl, OBJECT_STEP_TYPE
	add hl, bc
	ld [hl], STEP_TYPE_05
	ret

.ObeyDPad:
.Movement0d:
	ld hl, Function5000
	jp HandleMovementData

.Follow:
	ld hl, GetFollowerNextMovementByte
	jp HandleMovementData

.Script:
	ld hl, GetMovementByte
	jp HandleMovementData

.Strength:
	call MovementAnonymousJumptable
	dw .Strength_Start
	dw .Strength_Stop

.Strength_Start:
	ld hl, OBJECT_NEXT_TILE
	add hl, bc
	ld a, [hl]
	cp COLL_HOLE
	jr z, .on_pit
	ld hl, OBJECT_FLAGS2
	add hl, bc
	bit 2, [hl]
	res 2, [hl]
	jr z, .ok
	ld hl, OBJECT_RANGE
	add hl, bc
	ld a, [hl]
	and %00000011
	call InitStep
	call Function6ec1
	jr c, .ok2
	ld de, SFX_STRENGTH
	call PlaySFX
	call SpawnStrengthBoulderDust
	call UpdateTallGrassFlags
	ld hl, OBJECT_STEP_TYPE
	add hl, bc
	ld [hl], STEP_TYPE_0F
	ret

.ok2
	call CopyCurCoordsToNextCoords
.ok
	ld hl, OBJECT_DIRECTION_WALKING
	add hl, bc
	ld [hl], STANDING
	ret

.on_pit
	call IncrementObjectMovementByteIndex
.Strength_Stop:
	ld hl, OBJECT_DIRECTION_WALKING
	add hl, bc
	ld [hl], STANDING
	ret

.FollowNotExact:
	ld hl, OBJECT_NEXT_MAP_X
	add hl, bc
	ld d, [hl]
	ld hl, OBJECT_NEXT_MAP_Y
	add hl, bc
	ld e, [hl]
	ld hl, OBJECT_RANGE
	add hl, bc
	ld a, [hl]
	push bc
	call GetObjectStruct
	ld hl, OBJECT_DIRECTION_WALKING
	add hl, bc
	ld a, [hl]
	cp STANDING
	jr z, .standing
	ld hl, OBJECT_MAP_X
	add hl, bc
	ld a, [hl]
	cp d
	jr z, .equal
	jr c, .less
	ld a, 3
	jr .done

.less
	ld a, 2
	jr .done

.equal
	ld hl, OBJECT_MAP_Y
	add hl, bc
	ld a, [hl]
	cp e
	jr z, .standing
	jr c, .less2
	xor a
	jr .done

.less2
	ld a, 1
.done
	ld d, a
	ld hl, OBJECT_DIRECTION_WALKING
	add hl, bc
	ld a, [hl]
	and %00001100
	or d
	pop bc
	jp NormalStep

.standing
	pop bc
	ld hl, OBJECT_DIRECTION_WALKING
	add hl, bc
	ld [hl], STANDING
	ld hl, OBJECT_ACTION
	add hl, bc
	ld [hl], PERSON_ACTION_STAND
	ret

.MovementBigStanding:
	ld a, PERSON_ACTION_BIG_SNORLAX
	jr ._ActionA_StepType04

.MovementBouncing:
	ld a, PERSON_ACTION_BOUNCE
	jr ._ActionA_StepType04

.MovementBigGyarados:
	ld a, PERSON_ACTION_BIG_GYARADOS
	jr ._ActionA_StepType04

.MovementPokecomNews:
	ld a, PERSON_ACTION_POKECOM_NEWS
	jr ._ActionA_StepType04

.MovementCutTree:
	ld a, PERSON_ACTION_CUT_TREE
	jr ._ActionA_StepType04

.MovementFruit:
	ld a, PERSON_ACTION_FRUIT
	jr ._ActionA_StepType04

.MovementArchTree:
	ld a, PERSON_ACTION_ARCH_TREE
	jr ._ActionA_StepType04

.MovementSailboatTop:
	ld a, PERSON_ACTION_SAILBOAT_TOP
	jr ._ActionA_StepType04

.MovementSailboatBottom:
	ld a, PERSON_ACTION_SAILBOAT_BOTTOM
	jr ._ActionA_StepType04

.StandingFlip:
	ld a, PERSON_ACTION_STAND_FLIP
._ActionA_StepType04
	push af
	call EndSpriteMovement
	pop af
	ld hl, OBJECT_ACTION
	add hl, bc
	ld [hl], a
	ld hl, OBJECT_STEP_TYPE
	add hl, bc
	ld [hl], STEP_TYPE_04
	ret

.MovementSpinCounterclockwise:
	call MovementAnonymousJumptable
	dw .MovementSpinInit
	dw .MovementSpinRepeat
	dw .MovementSpinTurnLeft

.MovementSpinClockwise:
	call MovementAnonymousJumptable
	dw .MovementSpinInit
	dw .MovementSpinRepeat
	dw .MovementSpinTurnRight

.MovementSpinInit:
	call EndSpriteMovement
	call IncrementObjectMovementByteIndex
.MovementSpinRepeat:
	ld hl, OBJECT_ACTION
	add hl, bc
	ld [hl], PERSON_ACTION_STAND
	ld hl, OBJECT_STEP_DURATION
	add hl, bc
	ld [hl], $20
	ld hl, OBJECT_STEP_TYPE
	add hl, bc
	ld [hl], STEP_TYPE_03
	jp IncrementObjectMovementByteIndex

.MovementSpinTurnLeft:
	ld de, .DirectionData_Counterclockwise
	call .MovementSpinNextFacing
	jr .MovementSpinCounterclockwise

.DirectionData_Counterclockwise:
	db OW_RIGHT, OW_LEFT, OW_DOWN, OW_UP

.MovementSpinTurnRight:
	ld de, .DirectionData_Clockwise
	call .MovementSpinNextFacing
	jr .MovementSpinClockwise

.DirectionData_Clockwise:
	db OW_LEFT, OW_RIGHT, OW_UP, OW_DOWN

.MovementSpinNextFacing:
	ld hl, OBJECT_FACING
	add hl, bc
	ld a, [hl]
	and %00001100
	rrca
	rrca
	push hl
	ld l, a
	ld h, 0
	add hl, de
	ld a, [hl]
	pop hl
	ld [hl], a
	jp DecrementObjectMovementByteIndex

.MovementShadow:
	call ._MovementShadow_Grass_Puddle_Dust_Emote
	ld hl, OBJECT_ACTION
	add hl, bc
	ld [hl], PERSON_ACTION_SHADOW
	ld hl, OBJECT_STEP_DURATION
	add hl, de
	ld a, [hl]
	inc a
	add a
	ld hl, OBJECT_STEP_DURATION
	add hl, bc
	ld [hl], a
	ld hl, OBJECT_DIRECTION_WALKING
	add hl, de
	ld a, [hl]
	and 3
	ld d, 1 * 8 + 6
	cp DOWN
	jr z, .ok_13
	cp UP
	jr z, .ok_13
	ld d, 1 * 8 + 4
.ok_13
	ld hl, OBJECT_SPRITE_Y_OFFSET
	add hl, bc
	ld [hl], d
	ld hl, OBJECT_SPRITE_X_OFFSET
	add hl, bc
	ld [hl], 0
	ld hl, OBJECT_STEP_TYPE
	add hl, bc
	ld [hl], STEP_TYPE_TRACKING_OBJECT
	ret

.MovementEmote:
	call EndSpriteMovement
	call ._MovementShadow_Grass_Puddle_Dust_Emote
	ld hl, OBJECT_ACTION
	add hl, bc
	ld [hl], PERSON_ACTION_EMOTE
	ld hl, OBJECT_STEP_DURATION
	add hl, bc
	ld [hl], 0
	ld hl, OBJECT_SPRITE_Y_OFFSET
	add hl, bc
	ld [hl], -2 * 8
	ld hl, OBJECT_SPRITE_X_OFFSET
	add hl, bc
	ld [hl], 0
	ld hl, OBJECT_STEP_TYPE
	add hl, bc
	ld [hl], STEP_TYPE_TRACKING_OBJECT
	ret

.MovementBoulderDust:
	call EndSpriteMovement
	call ._MovementShadow_Grass_Puddle_Dust_Emote
	ld hl, OBJECT_ACTION
	add hl, bc
	ld [hl], PERSON_ACTION_BOULDER_DUST
	ld hl, OBJECT_STEP_DURATION
	add hl, de
	ld a, [hl]
	inc a
	add a
	ld hl, OBJECT_STEP_DURATION
	add hl, bc
	ld [hl], a
	ld hl, OBJECT_DIRECTION_WALKING
	add hl, de
	ld a, [hl]
	and %00000011
	ld e, a
	ld d, 0
	ld hl, .data_4a81
	add hl, de
	add hl, de
	ld d, [hl]
	inc hl
	ld e, [hl]
	ld hl, OBJECT_SPRITE_X_OFFSET
	add hl, bc
	ld [hl], d
	ld hl, OBJECT_SPRITE_Y_OFFSET
	add hl, bc
	ld [hl], e
	ld hl, OBJECT_STEP_TYPE
	add hl, bc
	ld [hl], STEP_TYPE_TRACKING_OBJECT
	ret

.data_4a81
	;   x,  y
	db  0, -4
	db  0,  8
	db  6,  2
	db -6,  2

.MovementShakingGrass:
	call EndSpriteMovement
	call ._MovementShadow_Grass_Puddle_Dust_Emote
	ld hl, OBJECT_ACTION
	add hl, bc
	ld [hl], PERSON_ACTION_GRASS_SHAKE
	jr ._MovementGrass_Puddle_End

.MovementSplashingPuddle:
	call EndSpriteMovement
	call ._MovementShadow_Grass_Puddle_Dust_Emote
	ld hl, OBJECT_ACTION
	add hl, bc
	ld [hl], PERSON_ACTION_PUDDLE_SPLASH
._MovementGrass_Puddle_End:
	ld hl, OBJECT_STEP_DURATION
	add hl, de
	ld a, [hl]
	add -1
	ld hl, OBJECT_STEP_DURATION
	add hl, bc
	ld [hl], a
	ld hl, OBJECT_STEP_TYPE
	add hl, bc
	ld [hl], STEP_TYPE_TRACKING_OBJECT
	ret

._MovementShadow_Grass_Puddle_Dust_Emote:
	ld hl, OBJECT_RANGE
	add hl, bc
	ld a, [hl]
	push bc
	call GetObjectStruct
	ld d, b
	ld e, c
	pop bc
	ld hl, OBJECT_29
	add hl, bc
	ld [hl], e
	inc hl
	ld [hl], d
	ret

.MovementScreenShake:
	call EndSpriteMovement
	ld hl, OBJECT_ACTION
	add hl, bc
	ld [hl], PERSON_ACTION_00
	ld hl, OBJECT_RANGE
	add hl, bc
	ld a, [hl]
	call ._MovementScreenShake
	ld hl, OBJECT_STEP_DURATION
	add hl, bc
	ld [hl], e
	ld hl, OBJECT_30
	add hl, bc
	ld [hl], a
	ld hl, OBJECT_STEP_TYPE
	add hl, bc
	ld [hl], STEP_TYPE_14
	ret

._MovementScreenShake:
	ld d, a
	and %00111111
	add a
	ld e, a
	ld a, d
	rlca
	rlca
	and %00000011
	ld d, a
	inc d
	ld a, 1
.loop
	dec d
	ret z
	add a
	jr .loop

.RandomWalkContinue:
	call InitStep
	call Function6ec1 ; check whether the object can move in that direction
	jr c, .NewDuration
	call UpdateTallGrassFlags
	ld hl, OBJECT_ACTION
	add hl, bc
	ld [hl], PERSON_ACTION_STEP
	ld hl, wCenteredObject
	ldh a, [hMapObjectIndexBuffer]
	cp [hl]
	jr z, .load_6
	ld hl, OBJECT_STEP_TYPE
	add hl, bc
	ld [hl], STEP_TYPE_07
	ret

.load_6
	ld hl, OBJECT_STEP_TYPE
	add hl, bc
	ld [hl], STEP_TYPE_PLAYER_WALK
	ret

.NewDuration:
	call EndSpriteMovement
	call CopyCurCoordsToNextCoords
RandomStepDuration_Slow:
	call Random
	ldh a, [hRandomAdd]
	and $fe
	jr SetRandomStepDuration

RandomStepDuration_Fast:
	call Random
	ldh a, [hRandomAdd]
	and $3e
SetRandomStepDuration:
	ld hl, OBJECT_STEP_DURATION
	add hl, bc
	ld [hl], a
	ld hl, OBJECT_DIRECTION_WALKING
	add hl, bc
	ld [hl], STANDING
	ld hl, OBJECT_ACTION
	add hl, bc
	ld [hl], PERSON_ACTION_STAND
	ld hl, OBJECT_STEP_TYPE
	add hl, bc
	ld [hl], STEP_TYPE_03
	ret

StepTypesJumptable:
; These pointers use OBJECT_STEP_TYPE. See constants/sprite_constants.asm
	dw ObjectMovementReset      ; STEP_TYPE_00
	dw MapObjectMovementPattern ; STEP_TYPE_SLEEP
	dw NPCStep                  ; STEP_TYPE_NPC_WALK
	dw StepType03               ; STEP_TYPE_03
	dw StepType04               ; STEP_TYPE_04
	dw StepType05               ; STEP_TYPE_05
	dw PlayerStep               ; STEP_TYPE_PLAYER_WALK
	dw StepType07               ; STEP_TYPE_07
	dw NPCJump                  ; STEP_TYPE_NPC_JUMP
	dw PlayerJump               ; STEP_TYPE_PLAYER_JUMP
	dw PlayerOrNPCTurnStep      ; STEP_TYPE_HALF_STEP
	dw StepTypeBump             ; STEP_TYPE_BUMP
	dw TeleportFrom             ; STEP_TYPE_TELEPORT_FROM
	dw TeleportTo               ; STEP_TYPE_TELEPORT_TO
	dw Skyfall                  ; STEP_TYPE_SKYFALL
	dw StepType0f               ; STEP_TYPE_0F
	dw GotBiteStep              ; STEP_TYPE_GOT_BITE
	dw RockSmashStep            ; STEP_TYPE_ROCK_SMASH
	dw ReturnDigStep            ; STEP_TYPE_RETURN_DIG
	dw StepTypeTrackingObject   ; STEP_TYPE_TRACKING_OBJECT
	dw StepType14               ; STEP_TYPE_14
	dw SkyfallTop               ; STEP_TYPE_SKYFALL_TOP
	dw NPCSidewaysStairs        ; STEP_TYPE_NPC_STAIRS
	dw PlayerSidewaysStairs     ; STEP_TYPE_PLAYER_STAIRS

WaitStep_InPlace:
	ld hl, OBJECT_STEP_DURATION
	add hl, bc
	dec [hl]
	ret nz
	ld hl, OBJECT_STEP_TYPE
	add hl, bc
	ld [hl], STEP_TYPE_SLEEP
	ret

NPCJump:
	call Object28AnonymousJumptable
; anonymous dw
	dw .Jump
	dw .Land

.Jump:
	call AddStepVector
	call UpdateJumpPosition
	ld hl, OBJECT_STEP_DURATION
	add hl, bc
	dec [hl]
	ret nz
	call CopyNextCoordsTileToStandingCoordsTile
	call GetNextTile
	ld hl, OBJECT_FLAGS2
	add hl, bc
	res OVERHEAD, [hl]
	jp IncrementObjectStructField28

.Land:
	call AddStepVector
	call UpdateJumpPosition
	ld hl, OBJECT_STEP_DURATION
	add hl, bc
	dec [hl]
	ret nz
	call CopyNextCoordsTileToStandingCoordsTile
	ld hl, OBJECT_STEP_TYPE
	add hl, bc
	ld [hl], STEP_TYPE_SLEEP
	ret

PlayerJump:
	call Object28AnonymousJumptable
; anonymous dw
	dw .initjump
	dw .stepjump
	dw .initland
	dw .stepland

.initjump
	ld hl, wPlayerStepFlags
	set 7, [hl]
	call IncrementObjectStructField28
.stepjump
	call UpdateJumpPosition
	call UpdatePlayerStep
	ld hl, OBJECT_STEP_DURATION
	add hl, bc
	dec [hl]
	ret nz
	call CopyNextCoordsTileToStandingCoordsTile
	ld hl, OBJECT_FLAGS2
	add hl, bc
	res OVERHEAD, [hl]
	ld hl, wPlayerStepFlags
	set 6, [hl]
	set 4, [hl]
	jp IncrementObjectStructField28

.initland
	call GetNextTile
	ld hl, wPlayerStepFlags
	set 7, [hl]
	call IncrementObjectStructField28
.stepland
	call UpdateJumpPosition
	call UpdatePlayerStep
	ld hl, OBJECT_STEP_DURATION
	add hl, bc
	dec [hl]
	ret nz
	ld hl, wPlayerStepFlags
	set 6, [hl]
	call CopyNextCoordsTileToStandingCoordsTile
	ld hl, OBJECT_STEP_TYPE
	add hl, bc
	ld [hl], STEP_TYPE_SLEEP
	ret

TeleportFrom:
	call Object28AnonymousJumptable
; anonymous dw
	dw .InitSpin
	dw .DoSpin
	dw .InitSpinRise
	dw .DoSpinRise

.InitSpin:
	ld hl, OBJECT_STEP_FRAME
	add hl, bc
	ld [hl], 0
	ld hl, OBJECT_STEP_DURATION
	add hl, bc
	ld [hl], 32
	call IncrementObjectStructField28
.DoSpin:
	ld hl, OBJECT_ACTION
	add hl, bc
	ld [hl], PERSON_ACTION_SPIN
	ld hl, OBJECT_STEP_DURATION
	add hl, bc
	dec [hl]
	ret nz
	jp IncrementObjectStructField28

.InitSpinRise:
	ld hl, OBJECT_STEP_FRAME
	add hl, bc
	ld [hl], 0
	ld hl, OBJECT_31
	add hl, bc
	ld [hl], $10
	ld hl, OBJECT_STEP_DURATION
	add hl, bc
	ld [hl], 16
	ld hl, OBJECT_FLAGS2
	add hl, bc
	res OVERHEAD, [hl]
	call IncrementObjectStructField28
.DoSpinRise:
	ld hl, OBJECT_ACTION
	add hl, bc
	ld [hl], PERSON_ACTION_SPIN
	ld hl, OBJECT_31
	add hl, bc
	inc [hl]
	ld a, [hl]
	ld d, $60
	call Sine
	ld a, h
	sub $60
	ld hl, OBJECT_SPRITE_Y_OFFSET
	add hl, bc
	ld [hl], a
	ld hl, OBJECT_STEP_DURATION
	add hl, bc
	dec [hl]
	ret nz
	ld hl, OBJECT_STEP_FRAME
	add hl, bc
	ld [hl], 0
	ld hl, OBJECT_STEP_TYPE
	add hl, bc
	ld [hl], STEP_TYPE_SLEEP
	ret

TeleportTo:
	call Object28AnonymousJumptable
; anonymous dw
	dw .InitWait
	dw .DoWait
	dw .InitDescent
	dw .DoDescent
	dw .InitFinalSpin
	dw .DoFinalSpin
	dw .FinishStep

.InitWait:
	ld hl, OBJECT_ACTION
	add hl, bc
	ld [hl], PERSON_ACTION_00
	ld hl, OBJECT_STEP_DURATION
	add hl, bc
	ld [hl], 32
	jp IncrementObjectStructField28

.DoWait:
	ld hl, OBJECT_STEP_DURATION
	add hl, bc
	dec [hl]
	ret nz
	call IncrementObjectStructField28
.InitDescent:
	ld hl, OBJECT_STEP_FRAME
	add hl, bc
	ld [hl], 0
	ld hl, OBJECT_31
	add hl, bc
	ld [hl], 0
	ld hl, OBJECT_STEP_DURATION
	add hl, bc
	ld [hl], 16
	jp IncrementObjectStructField28

.DoDescent:
	ld hl, OBJECT_ACTION
	add hl, bc
	ld [hl], PERSON_ACTION_SPIN
	ld hl, OBJECT_31
	add hl, bc
	inc [hl]
	ld a, [hl]
	ld d, $60
	call Sine
	ld a, h
	sub $60
	ld hl, OBJECT_SPRITE_Y_OFFSET
	add hl, bc
	ld [hl], a
	ld hl, OBJECT_STEP_DURATION
	add hl, bc
	dec [hl]
	ret nz
	call IncrementObjectStructField28
.InitFinalSpin:
	ld hl, OBJECT_STEP_DURATION
	add hl, bc
	ld [hl], 32
	jp IncrementObjectStructField28

.DoFinalSpin:
	ld hl, OBJECT_ACTION
	add hl, bc
	ld [hl], PERSON_ACTION_SPIN
	ld hl, OBJECT_STEP_DURATION
	add hl, bc
	dec [hl]
	ret nz
.FinishStep:
	ld hl, OBJECT_STEP_FRAME
	add hl, bc
	ld [hl], 0
	ld hl, OBJECT_SPRITE_Y_OFFSET
	add hl, bc
	ld [hl], 0
	ld hl, OBJECT_STEP_TYPE
	add hl, bc
	ld [hl], STEP_TYPE_SLEEP
	ret

Skyfall:
	call Object28AnonymousJumptable
; anonymous dw
	dw .Init
	dw .Step
	dw .Fall
	dw .Finish

.Init:
	ld hl, OBJECT_ACTION
	add hl, bc
	ld [hl], PERSON_ACTION_00
	ld hl, OBJECT_STEP_DURATION
	add hl, bc
	ld [hl], 16
	call IncrementObjectStructField28
.Step:
	ld hl, OBJECT_STEP_DURATION
	add hl, bc
	dec [hl]
	ret nz
	ld hl, OBJECT_ACTION
	add hl, bc
	ld [hl], PERSON_ACTION_STEP
	ld hl, OBJECT_STEP_FRAME
	add hl, bc
	ld [hl], 0
	ld hl, OBJECT_31
	add hl, bc
	ld [hl], 0
	ld hl, OBJECT_STEP_DURATION
	add hl, bc
	ld [hl], 16
	call IncrementObjectStructField28
.Fall:
	ld hl, OBJECT_31
	add hl, bc
	inc [hl]
	ld a, [hl]
	ld d, $60
	call Sine
	ld a, h
	sub $60
	ld hl, OBJECT_SPRITE_Y_OFFSET
	add hl, bc
	ld [hl], a
	ld hl, OBJECT_STEP_DURATION
	add hl, bc
	dec [hl]
	ret nz
	call IncrementObjectStructField28
.Finish:
	ld hl, OBJECT_STEP_FRAME
	add hl, bc
	ld [hl], 0
	ld hl, OBJECT_SPRITE_Y_OFFSET
	add hl, bc
	ld [hl], 0
	ld hl, OBJECT_STEP_TYPE
	add hl, bc
	ld [hl], STEP_TYPE_SLEEP
	ret

GotBiteStep:
	call Object28AnonymousJumptable
; anonymous dw
	dw .Init
	dw .Run

.Init:
	ld hl, OBJECT_STEP_DURATION
	add hl, bc
	ld [hl], 8
	ld hl, OBJECT_SPRITE_Y_OFFSET
	add hl, bc
	ld [hl], 0
	call IncrementObjectStructField28
.Run:
	ld hl, OBJECT_SPRITE_Y_OFFSET
	add hl, bc
	ld a, [hl]
	xor 1
	ld [hl], a
	ld hl, OBJECT_STEP_DURATION
	add hl, bc
	dec [hl]
	ret nz
	ld hl, OBJECT_SPRITE_Y_OFFSET
	add hl, bc
	ld [hl], 0
	ld hl, OBJECT_STEP_TYPE
	add hl, bc
	ld [hl], STEP_TYPE_SLEEP
	ret

RockSmashStep:
	ld hl, OBJECT_STEP_DURATION
	add hl, bc
	ld a, [hl]
	and %00000001
	ld a, PERSON_ACTION_STAND
	jr z, .yes
	ld a, PERSON_ACTION_00
.yes
	ld hl, OBJECT_ACTION
	add hl, bc
	ld [hl], a
	jp WaitStep_InPlace

ReturnDigStep:
	ld hl, OBJECT_STEP_DURATION
	add hl, bc
	ld a, [hl]
	and %00000001
	ld a, PERSON_ACTION_SPIN
	jr z, .yes
	ld a, PERSON_ACTION_SPIN_FLICKER
.yes
	ld hl, OBJECT_ACTION
	add hl, bc
	ld [hl], a
	jp WaitStep_InPlace

StepType03:
	ld hl, OBJECT_DIRECTION_WALKING
	add hl, bc
	ld [hl], STANDING
	ld hl, OBJECT_STEP_DURATION
	add hl, bc
	dec [hl]
	ret nz
	ld hl, OBJECT_STEP_TYPE
	add hl, bc
	ld [hl], STEP_TYPE_SLEEP
	ret

StepTypeBump:
	ld hl, OBJECT_STEP_DURATION
	add hl, bc
	dec [hl]
	ret nz
	ld hl, OBJECT_STEP_TYPE
	add hl, bc
	ld [hl], STEP_TYPE_SLEEP
	ret

StepType05:
	call Object28AnonymousJumptable
; anonymous dw
	dw .Reset
	dw StepType04

.Reset:
	call RestoreDefaultMovement
	call GetInitialFacing
	ld hl, OBJECT_FACING
	add hl, bc
	ld [hl], a
	call IncrementObjectStructField28
StepType04:
	ld hl, OBJECT_DIRECTION_WALKING
	add hl, bc
	ld [hl], STANDING
	ret

NPCStep:
	call AddStepVector
	ld hl, OBJECT_STEP_DURATION
	add hl, bc
	dec [hl]
	ret nz
	call CopyNextCoordsTileToStandingCoordsTile
	ld hl, OBJECT_DIRECTION_WALKING
	add hl, bc
	ld [hl], STANDING
	ld hl, OBJECT_STEP_TYPE
	add hl, bc
	ld [hl], STEP_TYPE_SLEEP
	ret

StepType07:
	call AddStepVector
	ld hl, OBJECT_STEP_DURATION
	add hl, bc
	dec [hl]
	ret nz
	call CopyNextCoordsTileToStandingCoordsTile
	jp RandomStepDuration_Slow

PlayerStep:
; AnimateStep?
	call Object28AnonymousJumptable
; anonymous dw
	dw .init
	dw .step

.init
	ld hl, wPlayerStepFlags
	set 7, [hl]
	call IncrementObjectStructField28
.step
	call UpdatePlayerStep
	ld hl, OBJECT_STEP_DURATION
	add hl, bc
	dec [hl]
	ret nz
	ld hl, wPlayerStepFlags
	set 6, [hl]
	call CopyNextCoordsTileToStandingCoordsTile
	ld hl, OBJECT_DIRECTION_WALKING
	add hl, bc
	ld [hl], STANDING
	ld hl, OBJECT_STEP_TYPE
	add hl, bc
	ld [hl], STEP_TYPE_SLEEP
	ret

PlayerOrNPCTurnStep:
	call Object28AnonymousJumptable
; anonymous dw
	dw .init1
	dw .step1
	dw .init2
	dw .step2

.init1
	ld hl, OBJECT_DIRECTION_WALKING
	add hl, bc
	ld [hl], STANDING
	ld hl, OBJECT_STEP_FRAME
	add hl, bc
	ld a, [hl]
	ld [hl], 4
	ld hl, OBJECT_STEP_DURATION
	add hl, bc
	call .GetTurningSpeed
	ld [hl], a
	call IncrementObjectStructField28
.step1
	ld hl, OBJECT_STEP_DURATION
	add hl, bc
	dec [hl]
	ret nz
	call IncrementObjectStructField28
.init2
	ld hl, OBJECT_29 ; new facing
	add hl, bc
	ld a, [hl]
	ld hl, OBJECT_FACING
	add hl, bc
	ld [hl], a
	ld hl, OBJECT_STEP_DURATION
	add hl, bc
	call .GetTurningSpeed
	ld [hl], a
	call IncrementObjectStructField28
.step2
	ld hl, OBJECT_STEP_DURATION
	add hl, bc
	dec [hl]
	ret nz
	ld hl, OBJECT_STEP_TYPE
	add hl, bc
	ld [hl], STEP_TYPE_SLEEP
	ret

.GetTurningSpeed:
	ld a, [wOptions1]
	bit TURNING_SPEED, a
	ld a, 4
	ret z
	ld a, 2
	ret

StepType0f:
	call AddStepVector
	ld hl, OBJECT_STEP_DURATION
	add hl, bc
	dec [hl]
	ret nz
	push bc
	ld hl, OBJECT_NEXT_MAP_X
	add hl, bc
	ld d, [hl]
	ld hl, OBJECT_NEXT_MAP_Y
	add hl, bc
	ld e, [hl]
	ld hl, OBJECT_MAP_OBJECT_INDEX
	add hl, bc
	ld a, [hl]
	ld b, a
	farcall CopyDECoordsToMapObject
	pop bc
	ld hl, OBJECT_FLAGS2
	add hl, bc
	res 2, [hl]
	call CopyNextCoordsTileToStandingCoordsTile
	ld hl, OBJECT_DIRECTION_WALKING
	add hl, bc
	ld [hl], STANDING
	ld hl, OBJECT_STEP_TYPE
	add hl, bc
	ld [hl], STEP_TYPE_SLEEP
	ret

StepTypeTrackingObject:
	ld hl, OBJECT_29
	add hl, bc
	ld e, [hl]
	inc hl
	ld d, [hl]
	ld hl, OBJECT_SPRITE
	add hl, de
	ld a, [hl]
	and a
	jr z, .nope
	ld hl, OBJECT_SPRITE_X
	add hl, de
	ld a, [hl]
	ld hl, OBJECT_SPRITE_X
	add hl, bc
	ld [hl], a
	ld hl, OBJECT_SPRITE_Y
	add hl, de
	ld a, [hl]
	ld hl, OBJECT_SPRITE_Y
	add hl, bc
	ld [hl], a
	ld hl, OBJECT_STEP_DURATION
	add hl, bc
	ld a, [hl]
	and a
	ret z
	dec [hl]
	ret nz
.nope
	jp DeleteMapObject

StepType14:
	call Object28AnonymousJumptable
; anonymous dw
	dw .Init
	dw .Run

.Init:
	xor a
	ld hl, OBJECT_29
	add hl, bc
	ld [hl], a
	call IncrementObjectStructField28
.Run:
	ld hl, OBJECT_29
	add hl, bc
	ld d, [hl]
	ld a, [wPlayerStepVectorY]
	sub d
	ld [wPlayerStepVectorY], a
	ld hl, OBJECT_STEP_DURATION
	add hl, bc
	dec [hl]
	jr z, .ok
	ld a, [hl]
	call .GetSign
	ld hl, OBJECT_29
	add hl, bc
	ld [hl], a
	ld d, a
	ld a, [wPlayerStepVectorY]
	add d
	ld [wPlayerStepVectorY], a
	ret

.ok
	jp DeleteMapObject

.GetSign:
	ld hl, OBJECT_30
	add hl, bc
	and 1
	ld a, [hl]
	ret z
	cpl
	inc a
	ret

SkyfallTop:
	call Object28AnonymousJumptable
; anonymous dw
	dw .Init
	dw .Run

.Init:
	ld hl, OBJECT_ACTION
	add hl, bc
	ld [hl], PERSON_ACTION_SKYFALL
	ld hl, OBJECT_STEP_DURATION
	add hl, bc
	ld [hl], 16
	call IncrementObjectStructField28

.Run:
	ld hl, OBJECT_STEP_DURATION
	add hl, bc
	dec [hl]
	ret nz
	ld hl, OBJECT_SPRITE_Y_OFFSET
	add hl, bc
	ld [hl], $60
	ld hl, OBJECT_STEP_FRAME
	add hl, bc
	ld [hl], 0
	ld hl, OBJECT_STEP_TYPE
	add hl, bc
	ld [hl], STEP_TYPE_SLEEP
	ret

UpdateJumpPosition:
	call GetStepVector
	push af
	ld a, h
	ld hl, OBJECT_31
	add hl, bc
	ld e, [hl]
	add e
	ld [hl], a
	pop af
	cp 32 ; is duration slow jump?
	jr nz, .not_slow_jump
	srl e
.not_slow_jump
	srl e
	ld d, 0
	ld hl, .y
	add hl, de
	ld a, [hl]
	ld hl, OBJECT_SPRITE_Y_OFFSET
	add hl, bc
	ld [hl], a
	ret

.y
	db  -4,  -6,  -8, -10, -11, -12, -12, -12
	db -11, -10,  -9,  -8,  -6,  -4,   0,   0

NPCSidewaysStairs:
	; TODO
	ret

PlayerSidewaysStairs:
	call Object28AnonymousJumptable
; anonymous dw
	dw .InitHorizontal1
	dw .StepHorizontal
	dw .InitHorizontal2
	dw .StepHorizontal
	dw .InitVertical
	dw .StepVertical

.InitHorizontal2:
	call GetNextTile
.InitHorizontal1:
	ld hl, wPlayerStepFlags
	set 7, [hl]
	call IncrementObjectStructField28
.StepHorizontal:
	call UpdateDiagonalStairsPosition
	call UpdatePlayerStep
	ld hl, OBJECT_STEP_DURATION
	add hl, bc
	dec [hl]
	ret nz
	call CopyNextCoordsTileToStandingCoordsTile
	ld hl, OBJECT_FLAGS2
	add hl, bc
	res 3, [hl]
	ld hl, wPlayerStepFlags
	set 6, [hl]
	set 4, [hl]
	jp IncrementObjectStructField28

.InitVertical:
 	ld hl, OBJECT_ACTION
	add hl, bc
	ld [hl], PERSON_ACTION_STAND
	ld a, [wPlayerGoingUpStairs]
	and a
	ld a, DOWN
	jr z, .got_dir
	ld a, UP
.got_dir
	ld hl, OBJECT_DIRECTION_WALKING
	add hl, bc
	ld [hl], a
	ld a, [wPlayerGoingUpStairs]
	xor 1
	ld [wPlayerGoingUpStairs], a
	call GetNextTile
	ld hl, wPlayerStepFlags
	set 7, [hl]
	call IncrementObjectStructField28
.StepVertical:
	call UpdateDiagonalStairsPosition
	call UpdatePlayerStep
	ld hl, OBJECT_STEP_DURATION
	add hl, bc
	dec [hl]
	ret nz
	ld hl, wPlayerStepFlags
	set 6, [hl]
	call CopyNextCoordsTileToStandingCoordsTile
	ld hl, OBJECT_STEP_TYPE
	add hl, bc
	ld [hl], STEP_TYPE_SLEEP
	ret

UpdateDiagonalStairsPosition:
	ld hl, OBJECT_STEP_DURATION
	add hl, bc
	ld a, [hl]
	and 1
	ret z
	ld a, [wPlayerGoingUpStairs]
	and a
	ld e, 1
	jr z, .got_dir
	ld e, -1
.got_dir
	ld hl, OBJECT_SPRITE_Y_OFFSET
	add hl, bc
	ld a, [hl]
	add e
	ld [hl], a
	ret

Function5000: ; unscripted?
; copy [wPlayerNextMovement] to [wPlayerMovement]
	ld a, [wPlayerNextMovement]
	ld hl, wPlayerMovement
	ld [hl], a
; load [wPlayerNextMovement] with movement_step_sleep_1
	ld a, movement_step_sleep_1
	ld [wPlayerNextMovement], a
; recover the previous value of [wPlayerNextMovement]
	ld a, [hl]
	ret

GetMovementByte:
	ld hl, wMovementDataPointer
	jp _GetMovementByte

_GetMovementPerson:
	ld hl, GetMovementPerson
	jp HandleMovementData

GetMovementPerson:
	ld a, [wMovementObject]
	ret

HandleMovementData:
	call .StorePointer
.loop
	xor a
	ld [wMovementByteWasControlSwitch], a
	call JumpMovementPointer
	call DoMovementFunction
	ld a, [wMovementByteWasControlSwitch]
	and a
	jr nz, .loop
	ret

.StorePointer:
	ld a, l
	ld [wMovementPointer], a
	ld a, h
	ld [wMovementPointer + 1], a
	ret

JumpMovementPointer:
	ld hl, wMovementPointer
	jp IndirectHL

ContinueReadingMovement:
	ld a, 1
	ld [wMovementByteWasControlSwitch], a
	ret

DoMovementFunction:
	push af
	call ApplyMovementToFollower
	pop af
	ld hl, MovementPointers
	call JumpTable
	ret

INCLUDE "engine/overworld/movement.asm"

ApplyMovementToFollower:
	ld e, a
	ld a, [wObjectFollow_Follower]
	cp -1
	ret z
	ld a, [wObjectFollow_Leader]
	ld d, a
	ldh a, [hMapObjectIndexBuffer]
	cp d
	ret nz
	ld a, e
	cp movement_step_sleep_1
	ret z
	cp movement_step_end
	ret z
	cp movement_step_bump
	ret z
	cp movement_turn_step_right + 1
	ret c
	push af
	ld hl, wFollowerMovementQueueLength
	inc [hl]
	ld e, [hl]
	ld d, 0
	ld hl, wFollowMovementQueue
	add hl, de
	pop af
	ld [hl], a
	ret

GetFollowerNextMovementByte:
	ld hl, wFollowerMovementQueueLength
	ld a, [hl]
	and a
	jr z, .done
	cp -1
	jr z, .done
	dec [hl]
	ld e, a
	ld d, 0
	ld hl, wFollowMovementQueue
	add hl, de
	inc e
	ld a, -1
.loop
	ld d, [hl]
	ld [hld], a
	ld a, d
	dec e
	jr nz, .loop
	ret

.done
	call .CancelFollowIfLeaderMissing
	ret c
	ld a, movement_step_sleep_1
	ret

.CancelFollowIfLeaderMissing:
	ld a, [wObjectFollow_Leader]
	cp -1
	jr z, .nope
	push bc
	call GetObjectStruct
	ld hl, OBJECT_SPRITE
	add hl, bc
	ld a, [hl]
	pop bc
	and a
	jr z, .nope
	and a
	ret

.nope
	ld a, -1
	ld [wObjectFollow_Follower], a
	ld a, movement_step_end
	scf
	ret

SpawnShadow:
	push bc
	ld de, .ShadowObject
	call CopyTempObjectData
	call InitTempObject
	pop bc
	ret

.ShadowObject:
	; vtile, palette, movement
	db $80, PAL_OW_SILVER, SPRITEMOVEDATA_SHADOW
SpawnStrengthBoulderDust:
	push bc
	ld de, .BoulderDustObject
	call CopyTempObjectData
	call InitTempObject
	pop bc
	ret

.BoulderDustObject:
	db $80, PAL_OW_SILVER, SPRITEMOVEDATA_BOULDERDUST

SpawnEmote:
	push bc
	ld de, .EmoteObject
	call CopyTempObjectData
	call InitTempObject
	pop bc
	ret

.EmoteObject:
	db $80, PAL_OW_SILVER, SPRITEMOVEDATA_EMOTE

ShakeGrass:
	push bc
	ld de, .data_5562
	call CopyTempObjectData
	call InitTempObject
	pop bc
	ret

.data_5562
	db $80, PAL_OW_TREE, SPRITEMOVEDATA_GRASS

SplashPuddle:
	push bc
	ld de, .puddle_data
	call CopyTempObjectData
	call InitTempObject
	pop bc
	ld de, SFX_PUDDLE
	jp PlaySFX

.puddle_data
	db $80, PAL_OW_BLUE, SPRITEMOVEDATA_PUDDLE

ShakeScreen:
	push bc
	push af
	ld de, .ScreenShakeObject
	call CopyTempObjectData
	pop af
	ld [wTempObjectCopyRange], a
	call InitTempObject
	pop bc
	ret

.ScreenShakeObject:
	db $80, PAL_OW_SILVER, SPRITEMOVEDATA_SCREENSHAKE

DespawnEmote:
	push bc
	ldh a, [hMapObjectIndexBuffer]
	ld c, a
	call .DeleteEmote
	pop bc
	ret

.DeleteEmote:
	ld de, wObjectStructs
	ld a, NUM_OBJECT_STRUCTS
.loop
	push af
	ld hl, OBJECT_FLAGS1
	add hl, de
	bit EMOTE_OBJECT, [hl]
	jr z, .next
	ld hl, OBJECT_SPRITE
	add hl, de
	ld a, [hl]
	and a
	jr z, .next
	push bc
	xor a
	ld bc, OBJECT_STRUCT_LENGTH
	rst ByteFill
	pop bc
.next
	ld hl, OBJECT_STRUCT_LENGTH
	add hl, de
	ld d, h
	ld e, l
	pop af
	dec a
	jr nz, .loop
	ret

InitTempObject:
	call FindFirstEmptyObjectStruct
	ret nc
	ld d, h
	ld e, l
	farjp CopyTempObjectToObjectStruct

CopyTempObjectData:
; load into wTempObjectCopy:
; -1, -1, [de], [de + 1], [de + 2], [hMapObjectIndexBuffer], [NextMapX], [NextMapY], -1
; This spawns the object at the same place as whichever object is loaded into bc.
	ld hl, wTempObjectCopyMapObjectIndex
	ld [hl], -1
	inc hl
	ld [hl], -1
	inc hl
	ld a, [de]
	inc de
	ld [hli], a
	ld a, [de]
	inc de
	ld [hli], a
	ld a, [de]
	ld [hli], a
	ldh a, [hMapObjectIndexBuffer]
	ld [hli], a
	push hl
	ld hl, OBJECT_NEXT_MAP_X
	add hl, bc
	ld d, [hl]
	ld hl, OBJECT_NEXT_MAP_Y
	add hl, bc
	ld e, [hl]
	pop hl
	ld [hl], d
	inc hl
	ld [hl], e
	inc hl
	ld [hl], -1
	ret

UpdateMapObjectDataAndSprites::
	ld a, [wVramState]
	bit 0, a
	ret z
	ld bc, wObjectStructs
	xor a
.loop
	ldh [hMapObjectIndexBuffer], a
	call DoesObjectHaveASprite
	jr z, .ok
	call UpdateCurObjectData
.ok
	ld hl, OBJECT_STRUCT_LENGTH
	add hl, bc
	ld b, h
	ld c, l
	ldh a, [hMapObjectIndexBuffer]
	inc a
	cp NUM_OBJECT_STRUCTS
	jr nz, .loop
	ret

BattleStart_HideAllSpritesExceptBattleParticipants: ; 5602, called at battle start
	call MaskAllObjectStructs ; clear sprites
	ld a, PLAYER
	call RespawnObject ; respawn player
	ld a, [wBattleScriptFlags]
	bit 7, a
	jr z, .ok
	ldh a, [hLastTalked]
	and a
	jr z, .ok
	call RespawnObject ; respawn opponent
.ok
	jp _UpdateSprites

ReturnFromFly_SpawnOnlyPlayer:
	call MaskAllObjectStructs ; clear sprites
	ld a, PLAYER
	call RespawnObject ; respawn player
	jp _UpdateSprites

RespawnObject:
	cp NUM_OBJECTS
	ret nc
	call GetMapObject
	ld hl, MAPOBJECT_OBJECT_STRUCT_ID
	add hl, bc
	ld a, [hl]
	cp -1
	ret z
	cp NUM_OBJECT_STRUCTS
	ret nc
	call GetObjectStruct
	call DoesObjectHaveASprite
	ret z
	call IsObjectOnScreen
	jr c, SetFacing_Standing
	call HandleMapObjectAction_Stationary
	xor a
	ret

MaskAllObjectStructs:
	xor a
	ld bc, wObjectStructs
.loop
	ldh [hMapObjectIndexBuffer], a
	call SetFacing_Standing
	ld hl, OBJECT_STRUCT_LENGTH
	add hl, bc
	ld b, h
	ld c, l
	ldh a, [hMapObjectIndexBuffer]
	inc a
	cp NUM_OBJECT_STRUCTS
	jr nz, .loop
	ret

UpdateCurObjectData:
	push bc
	call CheckCurSpriteCoveredByTextBox
	pop bc
	jr c, SetFacing_Standing
	call IsObjectOnScreen
	jr c, SetFacing_Standing
	push bc
	ld hl, OBJECT_NEXT_MAP_X
	add hl, bc
	ld d, [hl]
	ld hl, OBJECT_NEXT_MAP_Y
	add hl, bc
	ld e, [hl]
	call GetCoordTile
	pop bc
	ld hl, OBJECT_NEXT_TILE
	add hl, bc
	ld [hl], a
	call UpdateTallGrassFlags
	call HandleMapObjectAction_Stationary
	xor a
	ret

SetFacing_Standing:
	ld hl, OBJECT_FACING_STEP
	add hl, bc
	ld [hl], STANDING
	scf
	ret

IsObjectOnScreen:
	ld hl, OBJECT_NEXT_MAP_X
	add hl, bc
	ld d, [hl]
	ld hl, OBJECT_NEXT_MAP_Y
	add hl, bc
	ld e, [hl]
	inc d
	inc e
	ld a, [wXCoord]
	cp d
	jr z, .equal_x
	jr nc, .nope
	add SCREEN_WIDTH / 2 + 1
	cp d
	jr c, .nope
.equal_x
	ld a, [wYCoord]
	cp e
	jr z, .equal_y
	jr nc, .nope
	add SCREEN_HEIGHT / 2 + 1
	cp e
	jr c, .nope
.equal_y
	xor a
	ret

.nope
	scf
	ret

CheckCurSpriteCoveredByTextBox:
; x coord
	ld a, [wPlayerBGMapOffsetX]
	ld d, a
	ld hl, OBJECT_SPRITE_X_OFFSET
	add hl, bc
	ld a, [hl]
	ld hl, OBJECT_SPRITE_X
	add hl, bc
	add [hl]
	add d
	cp -2 * 8
	jr nc, .ok1
	cp SCREEN_WIDTH * 8
	jp nc, .nope
.ok1
	and %00000111
	ld d, 2
	cp 4
	jr c, .ok2
	ld d, 3
.ok2
	ld a, [hl]
	rrca
	rrca
	rrca
	and %00011111
	cp SCREEN_WIDTH
	jr c, .ok3
	sub BG_MAP_WIDTH
.ok3
	ldh [hCurSpriteXCoord], a
; y coord
	ld a, [wPlayerBGMapOffsetY]
	ld e, a
	ld hl, OBJECT_SPRITE_Y_OFFSET
	add hl, bc
	ld a, [hl]
	ld hl, OBJECT_SPRITE_Y
	add hl, bc
	add [hl]
	add e
	cp -2 * 8
	jr nc, .ok4
	cp SCREEN_HEIGHT * 8
	jr nc, .nope
.ok4
	and %00000111
	ld e, 2
	cp 4
	jr c, .ok5
	ld e, 3
.ok5
	ld a, [hl]
	rrca
	rrca
	rrca
	and %00011111
	cp SCREEN_HEIGHT
	jr c, .ok6
	sub BG_MAP_HEIGHT
.ok6
	ldh [hCurSpriteYCoord], a
	; priority check
	ld hl, OBJECT_PALETTE
	add hl, bc
	bit OAM_PRIORITY, [hl]
	jr z, .ok7
	ld a, d
	add 2
	ld d, a
	ld a, e
	add 2
	ld e, a
.ok7
	ld a, d
	ldh [hCurSpriteXPixel], a
.loop
	ldh a, [hCurSpriteXPixel]
	ld d, a
	ldh a, [hUsedSpriteTile]
	add e
	dec a
	cp SCREEN_HEIGHT
	jr nc, .ok9
	ld b, a
.next
	ldh a, [hUsedSpriteIndex]
	add d
	dec a
	cp SCREEN_WIDTH
	jr nc, .ok8
	ld c, a
	push bc
	call Coord2Attr
	pop bc
	bit OAM_TILE_BANK, [hl] ; show sprites standing on tiles $1:00-FF
	jr nz, .ok8
	push bc
	call Coord2Tile
	pop bc
	ld a, [hl]
	cp $7f ; hide sprites standing on tiles $1:7F-FF
	jr nc, .nope
.ok8
	dec d
	jr nz, .next
.ok9
	dec e
	jr nz, .loop
	and a
	ret

.nope
	scf
	ret

HandleNPCStep::
	call .ResetStepVector
	xor a
	ld bc, wObjectStructs
.loop
	ldh [hMapObjectIndexBuffer], a
	call DoesObjectHaveASprite
	call nz, HandleCurNPCStep
	ld hl, OBJECT_STRUCT_LENGTH
	add hl, bc
	ld b, h
	ld c, l
	ldh a, [hMapObjectIndexBuffer]
	inc a
	cp NUM_OBJECT_STRUCTS
	jr nz, .loop
	ret

.ResetStepVector
	xor a
	ld [wPlayerStepVectorX], a
	ld [wPlayerStepVectorY], a
	ld a, [wPlayerStepFlags]
	bit 6, a
	ld a, $0
	ld [wPlayerStepFlags], a
	ret nz
	dec a
	ld [wPlayerStepDirection], a
	ret

RefreshPlayerSprite:
	ld a, movement_step_sleep_1
	ld [wPlayerNextMovement], a
	ld [wPlayerMovement], a
	xor a
	ld [wPlayerTurningDirection], a
	ld [wPlayerObjectStepFrame], a
	call .TryResetPlayerAction
	farcall CheckWarpFacingDown
	call c, SpawnInFacingDown
	jp .SpawnInCustomFacing

.TryResetPlayerAction:
	ld hl, wPlayerSpriteSetupFlags
	bit 7, [hl]
	ret z
	xor a
	ld [wPlayerAction], a
	ret

.SpawnInCustomFacing:
	ld hl, wPlayerSpriteSetupFlags
	bit 5, [hl]
	ret z
	ld a, [wPlayerSpriteSetupFlags]
	and 3
	add a
	add a
	jr ContinueSpawnFacing

SpawnInFacingDown:
	xor a
ContinueSpawnFacing:
	ld bc, wPlayerStruct
	jp SetSpriteDirection

SetCopycatPalette:
	ld bc, wObject1Struct
	jr SetSpritePalette

SetPlayerPalette:
	ld bc, wPlayerStruct
SetSpritePalette:
	and %10000000
	ret z
	ld a, d
	swap a
	and OAM_PALETTE
	ld d, a
	ld hl, OBJECT_PALETTE
	add hl, bc
	ld a, [hl]
	and $ff ^ OAM_PALETTE
	or d
	ld [hl], a
	ret

StartFollow::
	push bc
	ld a, b
	call SetLeaderIfVisible
	pop bc
	ret c
	ld a, c
	call SetFollowerIfVisible
	farjp QueueFollowerFirstStep

SetLeaderIfVisible:
	call CheckObjectVisibility
	ret c
	ldh a, [hObjectStructIndexBuffer]
	ld [wObjectFollow_Leader], a
	ret

SetFollowerIfVisible:
	push af
	call ResetFollower
	pop af
	call CheckObjectVisibility
	ret c
	ld hl, OBJECT_MOVEMENTTYPE
	add hl, bc
	ld [hl], SPRITEMOVEDATA_FOLLOWING
	ld hl, OBJECT_STEP_TYPE
	add hl, bc
	ld [hl], STEP_TYPE_00
	ldh a, [hObjectStructIndexBuffer]
	ld [wObjectFollow_Follower], a
	ret

StopFollow::
	ld a, -1
	ld [wObjectFollow_Leader], a
	; fallthrough
ResetFollower:
	ld a, [wObjectFollow_Follower]
	cp -1
	ret z
	call GetObjectStruct
	call Function58e3
	ld a, -1
	ld [wObjectFollow_Follower], a
	ret

SetFlagsForMovement_1::
	ld a, c
	call CheckObjectVisibility
	ret c
	push bc
	call Function587a
	pop bc
	ld hl, OBJECT_FLAGS2
	add hl, bc
	res 5, [hl]
	xor a
	ret

Function587a:
	ld bc, wObjectStructs
	xor a
.loop
	push af
	call DoesObjectHaveASprite
	jr z, .next
	ld hl, OBJECT_FLAGS2
	add hl, bc
	set 5, [hl]
.next
	ld hl, OBJECT_STRUCT_LENGTH
	add hl, bc
	ld b, h
	ld c, l
	pop af
	inc a
	cp NUM_OBJECT_STRUCTS
	jr nz, .loop
	ret

SetFlagsForMovement_2::
	ld a, [wObjectFollow_Leader]
	cp -1
	ret z
	push bc
	call GetObjectStruct
	ld hl, OBJECT_MAP_OBJECT_INDEX
	add hl, bc
	ld a, [hl]
	pop bc
	cp c
	ret nz
	ld a, [wObjectFollow_Follower]
	cp -1
	ret z
	call GetObjectStruct
	ld hl, OBJECT_FLAGS2
	add hl, bc
	res 5, [hl]
	ret

ReleaseAllMapObjects::
	push bc
	ld bc, wObjectStructs
	xor a
.loop
	push af
	call DoesObjectHaveASprite
	jr z, .next
	ld hl, OBJECT_FLAGS2
	add hl, bc
	res 5, [hl]
.next
	ld hl, OBJECT_STRUCT_LENGTH
	add hl, bc
	ld b, h
	ld c, l
	pop af
	inc a
	cp NUM_OBJECT_STRUCTS
	jr nz, .loop
	pop bc
	ret

Function58e3:
	ld hl, OBJECT_MAP_OBJECT_INDEX
	add hl, bc
	ld a, [hl]
	cp -1
	jr z, Function5903
	push bc
	call GetMapObject
	ld hl, MAPOBJECT_MOVEMENT
	add hl, bc
	ld a, [hl]
	pop bc
	ld hl, OBJECT_MOVEMENTTYPE
	add hl, bc
	ld [hl], a
	ld hl, OBJECT_STEP_TYPE
	add hl, bc
	ld [hl], STEP_TYPE_00
	ret

Function5903:
	call GetSpriteDirection
	rrca
	rrca
	ld e, a
	ld d, 0
	ld hl, .standing_movefns
	add hl, de
	ld a, [hl]
	ld hl, OBJECT_MOVEMENTTYPE
	add hl, bc
	ld [hl], a
	ld hl, OBJECT_STEP_TYPE
	add hl, bc
	ld [hl], STEP_TYPE_00
	ret

.standing_movefns
	db SPRITEMOVEDATA_STANDING_DOWN
	db SPRITEMOVEDATA_STANDING_UP
	db SPRITEMOVEDATA_STANDING_LEFT
	db SPRITEMOVEDATA_STANDING_RIGHT
_UpdateSprites::
	ld a, [wVramState]
	bit 0, a
	ret z
	xor a
	ldh [hUsedSpriteIndex], a
	ldh a, [hOAMUpdate]
	push af
	ld a, 1
	ldh [hOAMUpdate], a
	call InitSprites
	call .fill
	pop af
	ldh [hOAMUpdate], a
	ret

.fill
	ld a, [wVramState]
	bit 1, a
	ld b, LOW(wVirtualOAMEnd)
	jr z, .ok
	ld b, 28 * 4
.ok
	ldh a, [hUsedSpriteIndex]
	cp b
	ret nc
	ld l, a
	ld h, HIGH(wVirtualOAM)
	ld de, 4
	ld a, b
	ld c, SCREEN_HEIGHT_PX + 16
.loop
	ld [hl], c
	add hl, de
	cp l
	jr nz, .loop
	ret

ApplyBGMapAnchorToObjects:
	push hl
	push de
	push bc
	ld a, [wPlayerBGMapOffsetX]
	ld d, a
	ld a, [wPlayerBGMapOffsetY]
	ld e, a
	ld bc, wObjectStructs
	ld a, NUM_OBJECT_STRUCTS
.loop
	push af
	call DoesObjectHaveASprite
	jr z, .skip
	ld hl, OBJECT_SPRITE_X
	add hl, bc
	ld a, [hl]
	add d
	ld [hl], a
	ld hl, OBJECT_SPRITE_Y
	add hl, bc
	ld a, [hl]
	add e
	ld [hl], a
.skip
	ld hl, OBJECT_STRUCT_LENGTH
	add hl, bc
	ld b, h
	ld c, l
	pop af
	dec a
	jr nz, .loop
	xor a
	ld [wPlayerBGMapOffsetX], a
	ld [wPlayerBGMapOffsetY], a
	jp PopBCDEHL

InitSprites:
PRIORITY_LOW  EQU $10
PRIORITY_NORM EQU $20
PRIORITY_HIGH EQU $30
	call .DeterminePriorities
	ld c, PRIORITY_HIGH
	call .InitSpritesByPriority
	ld c, PRIORITY_NORM
	call .InitSpritesByPriority
	ld c, PRIORITY_LOW
	jp .InitSpritesByPriority

.DeterminePriorities:
	xor a
	ld hl, wMovementPointer
	ld bc, NUM_OBJECT_STRUCTS
	rst ByteFill
	ld d, 0
	ld bc, wObjectStructs
	ld hl, wMovementPointer
.loop
	push hl
	call DoesObjectHaveASprite
	jr z, .skip
	ld hl, OBJECT_FACING_STEP
	add hl, bc
	ld a, [hl]
	cp STANDING
	jr z, .skip
; Define the sprite priority.
	ld e, PRIORITY_LOW
	ld hl, OBJECT_FLAGS2
	add hl, bc
	bit 0, [hl]
	jr nz, .add
	ld e, PRIORITY_NORM
	bit 1, [hl]
	jr z, .add
	ld e, PRIORITY_HIGH
	jr .add

.skip
	ld hl, OBJECT_STRUCT_LENGTH
	add hl, bc
	ld b, h
	ld c, l
	pop hl
	jr .next

.add
	ld hl, OBJECT_STRUCT_LENGTH
	add hl, bc
	ld b, h
	ld c, l
	pop hl
	ld a, d
	or e
	ld [hli], a
.next
	inc d
	ld a, d
	cp NUM_OBJECT_STRUCTS
	jr nz, .loop
	ret

.InitSpritesByPriority:
	ld hl, wMovementPointer
.next_sprite
	ld a, [hli]
	ld d, a
	and $f0
	ret z
	cp c
	jr nz, .next_sprite
	push bc
	push hl
	ld a, d
	and $f
	call .GetObjectStructPointer
	call .InitSprite
	pop hl
	pop bc
	jr .next_sprite

.InitSprite:
	ld hl, OBJECT_SPRITE_TILE
	add hl, bc
	ld a, [hl]
	and %01111111
	ldh [hCurSpriteTile], a
	xor a
	bit 7, [hl]
	jr nz, .skip1
	or %00001000
.skip1
	ld hl, OBJECT_FLAGS2
	add hl, bc
	ld e, [hl]
	bit 7, e
	jr z, .skip2
	or %10000000
.skip2
	bit 4, e
	jr z, .skip3
	or %00010000
.skip3
	ld hl, OBJECT_PALETTE
	add hl, bc
	ld d, a
	ld a, [hl]
	and %00000111
	or d
	ld d, a
	xor a
	bit OVERHEAD, e
	jr z, .skip4
	or %10000000
.skip4
	ldh [hCurSpriteOAMFlags], a
	ld hl, OBJECT_SPRITE_X
	add hl, bc
	ld a, [hl]
	ld hl, OBJECT_SPRITE_X_OFFSET
	add hl, bc
	add [hl]
	add 8
	ld e, a
	ld a, [wPlayerBGMapOffsetX]
	add e
	ldh [hCurSpriteXPixel], a
	ld hl, OBJECT_SPRITE_Y
	add hl, bc
	ld a, [hl]
	ld hl, OBJECT_SPRITE_Y_OFFSET
	add hl, bc
	add [hl]
	add 12
	ld e, a
	ld a, [wPlayerBGMapOffsetY]
	add e
	ldh [hCurSpriteYPixel], a
	ld hl, OBJECT_FACING_STEP
	add hl, bc
	ld a, [hl]
	cp STANDING
	jp z, .done
	cp NUM_FACINGS
	jp nc, .done
	ld l, a
	ld h, 0
	add hl, hl
	ld bc, Facings
	add hl, bc
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ldh a, [hUsedSpriteIndex]
	ld c, a
	ld b, HIGH(wVirtualOAM)
	ld a, [hli]
	ldh [hUsedSpriteTile], a
	add c
	cp LOW(wVirtualOAMEnd)
	jr nc, .full
.addsprite
	ldh a, [hCurSpriteYPixel]
	add [hl]
	inc hl
	ld [bc], a
	inc c
	ldh a, [hCurSpriteXPixel]
	add [hl]
	inc hl
	ld [bc], a
	inc c
	ld e, [hl]
	inc hl
	ldh a, [hCurSpriteTile]
	bit 2, e
	jr z, .nope1
	xor a
.nope1
	add [hl]
	inc hl
	ld [bc], a

	ld a, d
	and %00001000
	jr z, .vram0
	ld a, [bc]
	cp $80
	jr c, .standing
	sub $40
	ld [bc], a
.standing
.vram0

	inc c
	ld a, e
	bit 1, a
	jr z, .nope2
	ldh a, [hCurSpriteOAMFlags]
	or e
.nope2
	and %11110000
	or d
	ld [bc], a
	inc c
	ldh a, [hUsedSpriteTile]
	dec a
	ldh [hUsedSpriteTile], a
	jr nz, .addsprite
	ld a, c
	ldh [hUsedSpriteIndex], a
.done
	xor a
	ret

.full
	scf
	ret

.GetObjectStructPointer:
	ld c, a
	ld b, 0
	ld hl, .Addresses
	add hl, bc
	add hl, bc
	ld c, [hl]
	inc hl
	ld b, [hl]
	ret

.Addresses:
	dw wPlayerStruct
	dw wObject1Struct
	dw wObject2Struct
	dw wObject3Struct
	dw wObject4Struct
	dw wObject5Struct
	dw wObject6Struct
	dw wObject7Struct
	dw wObject8Struct
	dw wObject9Struct
	dw wObject10Struct
	dw wObject11Struct
	dw wObject12Struct
