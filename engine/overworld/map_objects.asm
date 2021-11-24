INCLUDE "data/sprites/facings.asm"

DeleteMapObject::
	push bc
	ld hl, OBJECT_MAP_OBJECT_INDEX
	add hl, bc
	ld a, [hl]
	push af
	ld h, b
	ld l, c
	ld bc, OBJECT_LENGTH
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

HandleObjectStep:
	call _CheckObjectStillVisible
	ret c
	call _HandleStepType

	ld hl, OBJECT_FLAGS1
	add hl, bc
	bit INVISIBLE_F, [hl]
	jmp nz, SetFacingStanding
	ld hl, OBJECT_FLAGS2
	add hl, bc
	bit OBJ_FLAGS2_6, [hl]
	jmp nz, SetFacingStanding
	bit FROZEN_F, [hl]
	jr nz, HandleObjectAction
	ld de, ObjectActionPairPointers ; use first column
	jr _HandleObjectAction

HandleObjectAction_Stationary:
	ld hl, OBJECT_FLAGS1
	add hl, bc
	bit INVISIBLE_F, [hl]
	jr nz, SetFacingStanding
HandleObjectAction: ; use second column
	ld de, ObjectActionPairPointers + 2
	; fallthrough
_HandleObjectAction:
	; call [4 * wObjectStructs[ObjInd, OBJECT_ACTION] + de]
	ld hl, OBJECT_ACTION
	add hl, bc
	ld a, [hl]
	add a
	ld l, e
	ld h, d
	jmp JumpTable

INCLUDE "engine/overworld/map_object_action.asm"

_CheckObjectStillVisible:
	ld hl, OBJECT_FLAGS2
	add hl, bc
	res OBJ_FLAGS2_6, [hl]
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
	bit WONT_DELETE_F, [hl]
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

_HandleStepType:
	ld hl, OBJECT_STEP_TYPE
	add hl, bc
	ld a, [hl]
	and a
	jr z, .null_step_type
	ld hl, OBJECT_FLAGS2
	add hl, bc
	bit MOVE_ANYWHERE_F, [hl]
	ret nz
	cp STEP_TYPE_FROM_MOVEMENT
	jr z, .map_object_movement_pattern
	jr .do_step_type

.null_step_type
	call StepFunction_Reset
	ld hl, OBJECT_FLAGS2
	add hl, bc
	bit MOVE_ANYWHERE_F, [hl]
	ret nz
.map_object_movement_pattern
	call StepFunction_FromMovement
	ld hl, OBJECT_STEP_TYPE
	add hl, bc
	ld a, [hl]
	and a
	ret z
	cp STEP_TYPE_FROM_MOVEMENT
	ret z
.do_step_type
	call StackJumpTable

StepTypesJumptable:
; entries correspond to STEP_TYPE_* constants (see constants/map_object_constants.asm)
	table_width 2, StepTypesJumptable
	dw StepFunction_Reset           ; STEP_TYPE_RESET
	dw StepFunction_FromMovement    ; STEP_TYPE_FROM_MOVEMENT
	dw StepFunction_NPCWalk         ; STEP_TYPE_NPC_WALK
	dw StepFunction_Sleep           ; STEP_TYPE_SLEEP
	dw StepFunction_Standing        ; STEP_TYPE_STANDING
	dw StepFunction_Restore         ; STEP_TYPE_RESTORE
	dw StepFunction_PlayerWalk      ; STEP_TYPE_PLAYER_WALK
	dw StepFunction_ContinueWalk    ; STEP_TYPE_CONTINUE_WALK
	dw StepFunction_NPCJump         ; STEP_TYPE_NPC_JUMP
	dw StepFunction_PlayerJump      ; STEP_TYPE_PLAYER_JUMP
	dw StepFunction_Turn            ; STEP_TYPE_TURN
	dw StepFunction_Bump            ; STEP_TYPE_BUMP
	dw StepFunction_TeleportFrom    ; STEP_TYPE_TELEPORT_FROM
	dw StepFunction_TeleportTo      ; STEP_TYPE_TELEPORT_TO
	dw StepFunction_Skyfall         ; STEP_TYPE_SKYFALL
	dw StepFunction_StrengthBoulder ; STEP_TYPE_STRENGTH_BOULDER
	dw StepFunction_GotBite         ; STEP_TYPE_GOT_BITE
	dw StepFunction_RockSmash       ; STEP_TYPE_ROCK_SMASH
	dw StepFunction_DigTo           ; STEP_TYPE_RETURN_DIG
	dw StepFunction_TrackingObject  ; STEP_TYPE_TRACKING_OBJECT
	dw StepFunction_ScreenShake     ; STEP_TYPE_SCREENSHAKE
	dw StepFunction_SkyfallTop      ; STEP_TYPE_SKYFALL_TOP
	dw StepFunction_NPCStairs       ; STEP_TYPE_NPC_STAIRS
	dw StepFunction_PlayerStairs    ; STEP_TYPE_PLAYER_STAIRS
	assert_table_length NUM_STEP_TYPES

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
	bit OVERHEAD_F, [hl]
	ret z
	ld hl, OBJECT_NEXT_TILE
	add hl, bc
	ld a, [hl]
SetTallGrassFlags:
	ld hl, OBJECT_FLAGS2
	add hl, bc
	cp COLL_OVERHEAD
	jr z, .set
	cp COLL_LONG_GRASS
	jr z, .set
	cp COLL_TALL_GRASS
	jr z, .set
	res OVERHEAD_F, [hl]
	ret

.set
	set OVERHEAD_F, [hl]
	ret

EndSpriteMovement:
	xor a
	ld hl, OBJECT_STEP_FRAME
	add hl, bc
	ld [hl], a
	ld hl, OBJECT_MOVEMENT_BYTE_INDEX
	add hl, bc
	ld [hli], a ; OBJECT_MOVEMENT_BYTE_INDEX
	ld [hli], a ; OBJECT_1C
	ld [hli], a ; OBJECT_1D
	ld [hl], a ; OBJECT_1E
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
	bit FIXED_FACING_F, [hl]
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
	set PLAYERSTEP_CONTINUE_F, [hl]
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
	ld a, SPRITEMOVEDATA_STANDING_DOWN
	ret

MovementAnonymousJumptable:
	ld hl, OBJECT_MOVEMENT_BYTE_INDEX
	jmp OffsetStackJumpTable

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

Field1cAnonymousJumptable:
	ld hl, OBJECT_1C
	jmp OffsetStackJumpTable

IncrementObjectStructField1c:
	ld hl, OBJECT_1C
	add hl, bc
	inc [hl]
	ret

ClearObjectStructField1c:
	ld hl, OBJECT_1C
	add hl, bc
	ld [hl], 0
	ret

StepFunction_Reset:
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
	ld [hl], STEP_TYPE_FROM_MOVEMENT
	ret

StepFunction_FromMovement:
	call ClearObjectStructField1c

	ld hl, OBJECT_MOVEMENTTYPE
	add hl, bc
	ld a, [hl]
	cp NUM_SPRITEMOVEDATA
	jr c, .spritemovedata_ok
	xor a
.spritemovedata_ok
	ld hl, SpriteMovementData
	ld e, a
	ld d, 0
rept NUM_SPRITEMOVEDATA_FIELDS
	add hl, de
endr
	ld a, BANK(SpriteMovementData)
	call GetFarByte

	call StackJumpTable

.Pointers:
; entries correspond to SPRITEMOVEFN_* constants (see constants/map_object_constants.asm)
	table_width 2, StepFunction_FromMovement.Pointers
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
	assert_table_length NUM_SPRITEMOVEFN

.RandomWalkY:
	call Random
	ldh a, [hRandomAdd]
	and %00000001
	jmp .RandomWalkContinue

.RandomWalkX:
	call Random
	ldh a, [hRandomAdd]
	and %00000001
	or  %00000010
	jmp .RandomWalkContinue

.RandomWalkXY:
	call Random
	ldh a, [hRandomAdd]
	and %00000011
	jmp .RandomWalkContinue

.RandomSpin1:
	call Random
	ldh a, [hRandomAdd]
	and %00001100
	ld hl, OBJECT_FACING
	add hl, bc
	ld [hl], a
	jmp RandomStepDuration_Slow

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
	jmp RandomStepDuration_Fast

.Standing:
	call CopyCurCoordsToNextCoords
	call EndSpriteMovement
	ld hl, OBJECT_ACTION
	add hl, bc
	ld [hl], OBJECT_ACTION_STAND
	ld hl, OBJECT_STEP_TYPE
	add hl, bc
	ld [hl], STEP_TYPE_RESTORE
	ret

.ObeyDPad:
	ld hl, GetPlayerNextMovementByte
	jmp HandleMovementData

.Follow:
	ld hl, GetFollowerNextMovementByte
	jmp HandleMovementData

.Script:
	ld hl, GetMovementByte
	jmp HandleMovementData

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
	bit OBJ_FLAGS2_2, [hl]
	res OBJ_FLAGS2_2, [hl]
	jr z, .ok
	ld hl, OBJECT_RANGE
	add hl, bc
	ld a, [hl]
	and %00000011
	call InitStep
	call CanObjectMoveInDirection
	jr c, .ok2
	ld de, SFX_STRENGTH
	call PlaySFX
	call SpawnStrengthBoulderDust
	call UpdateTallGrassFlags
	ld hl, OBJECT_STEP_TYPE
	add hl, bc
	ld [hl], STEP_TYPE_STRENGTH_BOULDER
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
	; a = carry ? 2 : 3
	sbc a
	add 3
	jr .done

.equal
	ld hl, OBJECT_MAP_Y
	add hl, bc
	ld a, [hl]
	cp e
	jr z, .standing
	; a = carry ? 1 : 0
	sbc a
	and 1
.done
	ld d, a
	ld hl, OBJECT_DIRECTION_WALKING
	add hl, bc
	ld a, [hl]
	and %00001100
	or d
	pop bc
	jmp NormalStep

.standing
	pop bc
	ld hl, OBJECT_DIRECTION_WALKING
	add hl, bc
	ld [hl], STANDING
	ld hl, OBJECT_ACTION
	add hl, bc
	ld [hl], OBJECT_ACTION_STAND
	ret

.MovementBigStanding:
	ld a, OBJECT_ACTION_BIG_SNORLAX
	jr ._ActionA_StepFunction_Standing

.MovementBouncing:
	ld a, OBJECT_ACTION_BOUNCE
	jr ._ActionA_StepFunction_Standing

.MovementBigGyarados:
	ld a, OBJECT_ACTION_BIG_GYARADOS
	jr ._ActionA_StepFunction_Standing

.MovementPokecomNews:
	ld a, OBJECT_ACTION_POKECOM_NEWS
	jr ._ActionA_StepFunction_Standing

.MovementCutTree:
	ld a, OBJECT_ACTION_CUT_TREE
	jr ._ActionA_StepFunction_Standing

.MovementFruit:
	ld a, OBJECT_ACTION_FRUIT
	jr ._ActionA_StepFunction_Standing

.MovementArchTree:
	ld a, OBJECT_ACTION_ARCH_TREE
	jr ._ActionA_StepFunction_Standing

.MovementSailboatTop:
	ld a, OBJECT_ACTION_SAILBOAT_TOP
	jr ._ActionA_StepFunction_Standing

.MovementSailboatBottom:
	ld a, OBJECT_ACTION_SAILBOAT_BOTTOM
	jr ._ActionA_StepFunction_Standing

.StandingFlip:
	ld a, OBJECT_ACTION_STAND_FLIP
._ActionA_StepFunction_Standing
	push af
	call EndSpriteMovement
	pop af
	ld hl, OBJECT_ACTION
	add hl, bc
	ld [hl], a
	ld hl, OBJECT_STEP_TYPE
	add hl, bc
	ld [hl], STEP_TYPE_STANDING
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
	ld [hl], OBJECT_ACTION_STAND
	ld hl, OBJECT_STEP_DURATION
	add hl, bc
	ld [hl], $20
	ld hl, OBJECT_STEP_TYPE
	add hl, bc
	ld [hl], STEP_TYPE_SLEEP
	jmp IncrementObjectMovementByteIndex

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
	jmp DecrementObjectMovementByteIndex

.MovementShadow:
	call ._MovementShadow_Grass_Puddle_Dust_Emote
	ld hl, OBJECT_ACTION
	add hl, bc
	ld [hl], OBJECT_ACTION_SHADOW
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
	maskbits NUM_DIRECTIONS
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
	ld [hl], OBJECT_ACTION_EMOTE
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
	ld [hl], OBJECT_ACTION_BOULDER_DUST
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
	ld hl, .dust_coords
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

.dust_coords:
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
	ld [hl], OBJECT_ACTION_GRASS_SHAKE
	jr ._MovementGrass_Puddle_End

.MovementSplashingPuddle:
	call EndSpriteMovement
	call ._MovementShadow_Grass_Puddle_Dust_Emote
	ld hl, OBJECT_ACTION
	add hl, bc
	ld [hl], OBJECT_ACTION_PUDDLE_SPLASH
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
	ld hl, OBJECT_1D
	add hl, bc
	ld [hl], e
	inc hl
	ld [hl], d
	ret

.MovementScreenShake:
	call EndSpriteMovement
	ld hl, OBJECT_ACTION
	add hl, bc
	ld [hl], OBJECT_ACTION_00
	ld hl, OBJECT_RANGE
	add hl, bc
	ld a, [hl]
	call ._MovementScreenShake
	ld hl, OBJECT_STEP_DURATION
	add hl, bc
	ld [hl], e
	ld hl, OBJECT_1E
	add hl, bc
	ld [hl], a
	ld hl, OBJECT_STEP_TYPE
	add hl, bc
	ld [hl], STEP_TYPE_SCREENSHAKE
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
	call CanObjectMoveInDirection
	jr c, .NewDuration
	call UpdateTallGrassFlags
	ld hl, OBJECT_ACTION
	add hl, bc
	ld [hl], OBJECT_ACTION_STEP
	ld hl, wCenteredObject
	ldh a, [hMapObjectIndexBuffer]
	cp [hl]
	jr z, .load_6
	ld hl, OBJECT_STEP_TYPE
	add hl, bc
	ld [hl], STEP_TYPE_CONTINUE_WALK
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
	ld [hl], OBJECT_ACTION_STAND
	ld hl, OBJECT_STEP_TYPE
	add hl, bc
	ld [hl], STEP_TYPE_SLEEP
	ret

WaitStep_InPlace:
	ld hl, OBJECT_STEP_DURATION
	add hl, bc
	dec [hl]
	ret nz
	ld hl, OBJECT_STEP_TYPE
	add hl, bc
	ld [hl], STEP_TYPE_FROM_MOVEMENT
	ret

StepFunction_NPCJump:
	call Field1cAnonymousJumptable
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
	res OVERHEAD_F, [hl]
	jmp IncrementObjectStructField1c

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
	ld [hl], STEP_TYPE_FROM_MOVEMENT
	ret

StepFunction_PlayerJump:
	call Field1cAnonymousJumptable
; anonymous dw
	dw .initjump
	dw .stepjump
	dw .initland
	dw .stepland

.initjump
	ld hl, wPlayerStepFlags
	set PLAYERSTEP_START_F, [hl]
	call IncrementObjectStructField1c
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
	res OVERHEAD_F, [hl]
	ld hl, wPlayerStepFlags
	set PLAYERSTEP_STOP_F, [hl]
	set PLAYERSTEP_MIDAIR_F, [hl]
	jmp IncrementObjectStructField1c

.initland
	call GetNextTile
	ld hl, wPlayerStepFlags
	set PLAYERSTEP_START_F, [hl]
	call IncrementObjectStructField1c
.stepland
	call UpdateJumpPosition
	call UpdatePlayerStep
	ld hl, OBJECT_STEP_DURATION
	add hl, bc
	dec [hl]
	ret nz
	ld hl, wPlayerStepFlags
	set PLAYERSTEP_STOP_F, [hl]
	call CopyNextCoordsTileToStandingCoordsTile
	ld hl, OBJECT_STEP_TYPE
	add hl, bc
	ld [hl], STEP_TYPE_FROM_MOVEMENT
	ret

StepFunction_TeleportFrom:
	call Field1cAnonymousJumptable
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
	call IncrementObjectStructField1c
.DoSpin:
	ld hl, OBJECT_ACTION
	add hl, bc
	ld [hl], OBJECT_ACTION_SPIN
	ld hl, OBJECT_STEP_DURATION
	add hl, bc
	dec [hl]
	ret nz
	jmp IncrementObjectStructField1c

.InitSpinRise:
	ld hl, OBJECT_STEP_FRAME
	add hl, bc
	ld [hl], 0
	ld hl, OBJECT_1F
	add hl, bc
	ld [hl], $10
	ld hl, OBJECT_STEP_DURATION
	add hl, bc
	ld [hl], 16
	ld hl, OBJECT_FLAGS2
	add hl, bc
	res OVERHEAD_F, [hl]
	call IncrementObjectStructField1c
.DoSpinRise:
	ld hl, OBJECT_ACTION
	add hl, bc
	ld [hl], OBJECT_ACTION_SPIN
	ld hl, OBJECT_1F
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
	ld [hl], STEP_TYPE_FROM_MOVEMENT
	ret

StepFunction_TeleportTo:
	call Field1cAnonymousJumptable
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
	ld [hl], OBJECT_ACTION_00
	ld hl, OBJECT_STEP_DURATION
	add hl, bc
	ld [hl], 32
	jmp IncrementObjectStructField1c

.DoWait:
	ld hl, OBJECT_STEP_DURATION
	add hl, bc
	dec [hl]
	ret nz
	call IncrementObjectStructField1c
.InitDescent:
	ld hl, OBJECT_STEP_FRAME
	add hl, bc
	ld [hl], 0
	ld hl, OBJECT_1F
	add hl, bc
	ld [hl], 0
	ld hl, OBJECT_STEP_DURATION
	add hl, bc
	ld [hl], 16
	jmp IncrementObjectStructField1c

.DoDescent:
	ld hl, OBJECT_ACTION
	add hl, bc
	ld [hl], OBJECT_ACTION_SPIN
	ld hl, OBJECT_1F
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
	call IncrementObjectStructField1c
.InitFinalSpin:
	ld hl, OBJECT_STEP_DURATION
	add hl, bc
	ld [hl], 32
	jmp IncrementObjectStructField1c

.DoFinalSpin:
	ld hl, OBJECT_ACTION
	add hl, bc
	ld [hl], OBJECT_ACTION_SPIN
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
	ld [hl], STEP_TYPE_FROM_MOVEMENT
	ret

StepFunction_Skyfall:
	call Field1cAnonymousJumptable
; anonymous dw
	dw .Init
	dw .Step
	dw .Fall
	dw .Finish

.Init:
	ld hl, OBJECT_ACTION
	add hl, bc
	ld [hl], OBJECT_ACTION_00
	ld hl, OBJECT_STEP_DURATION
	add hl, bc
	ld [hl], 16
	call IncrementObjectStructField1c
.Step:
	ld hl, OBJECT_STEP_DURATION
	add hl, bc
	dec [hl]
	ret nz
	ld hl, OBJECT_ACTION
	add hl, bc
	ld [hl], OBJECT_ACTION_STEP
	ld hl, OBJECT_STEP_FRAME
	add hl, bc
	ld [hl], 0
	ld hl, OBJECT_1F
	add hl, bc
	ld [hl], 0
	ld hl, OBJECT_STEP_DURATION
	add hl, bc
	ld [hl], 16
	call IncrementObjectStructField1c
.Fall:
	ld hl, OBJECT_1F
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
	call IncrementObjectStructField1c
.Finish:
	ld hl, OBJECT_STEP_FRAME
	add hl, bc
	ld [hl], 0
	ld hl, OBJECT_SPRITE_Y_OFFSET
	add hl, bc
	ld [hl], 0
	ld hl, OBJECT_STEP_TYPE
	add hl, bc
	ld [hl], STEP_TYPE_FROM_MOVEMENT
	ret

StepFunction_GotBite:
	call Field1cAnonymousJumptable
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
	call IncrementObjectStructField1c
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
	ld [hl], STEP_TYPE_FROM_MOVEMENT
	ret

StepFunction_RockSmash:
	ld hl, OBJECT_STEP_DURATION
	add hl, bc
	ld a, [hl]
	and %00000001
	ld a, OBJECT_ACTION_STAND
	jr z, .yes
	ld a, OBJECT_ACTION_00
.yes
	ld hl, OBJECT_ACTION
	add hl, bc
	ld [hl], a
	jmp WaitStep_InPlace

StepFunction_DigTo:
	ld hl, OBJECT_STEP_DURATION
	add hl, bc
	ld a, [hl]
	and %00000001
	ld a, OBJECT_ACTION_SPIN
	jr z, .yes
	ld a, OBJECT_ACTION_SPIN_FLICKER
.yes
	ld hl, OBJECT_ACTION
	add hl, bc
	ld [hl], a
	jmp WaitStep_InPlace

StepFunction_Sleep:
	ld hl, OBJECT_DIRECTION_WALKING
	add hl, bc
	ld [hl], STANDING
	ld hl, OBJECT_STEP_DURATION
	add hl, bc
	dec [hl]
	ret nz
	ld hl, OBJECT_STEP_TYPE
	add hl, bc
	ld [hl], STEP_TYPE_FROM_MOVEMENT
	ret

StepFunction_Bump:
	ld hl, OBJECT_STEP_DURATION
	add hl, bc
	dec [hl]
	ret nz
	ld hl, OBJECT_STEP_TYPE
	add hl, bc
	ld [hl], STEP_TYPE_FROM_MOVEMENT
	ret

StepFunction_Restore:
	call Field1cAnonymousJumptable
; anonymous dw
	dw .Reset
	dw StepFunction_Standing

.Reset:
	call RestoreDefaultMovement
	call GetInitialFacing
	ld hl, OBJECT_FACING
	add hl, bc
	ld [hl], a
	call IncrementObjectStructField1c
StepFunction_Standing:
	ld hl, OBJECT_DIRECTION_WALKING
	add hl, bc
	ld [hl], STANDING
	ret

StepFunction_NPCWalk:
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
	ld [hl], STEP_TYPE_FROM_MOVEMENT
	ret

StepFunction_ContinueWalk:
	call AddStepVector
	ld hl, OBJECT_STEP_DURATION
	add hl, bc
	dec [hl]
	ret nz
	call CopyNextCoordsTileToStandingCoordsTile
	jmp RandomStepDuration_Slow

StepFunction_PlayerWalk:
; AnimateStep?
	call Field1cAnonymousJumptable
; anonymous dw
	dw .init
	dw .step

.init
	ld hl, wPlayerStepFlags
	set PLAYERSTEP_START_F, [hl]
	call IncrementObjectStructField1c
.step
	call UpdatePlayerStep
	ld hl, OBJECT_STEP_DURATION
	add hl, bc
	dec [hl]
	ret nz
	ld hl, wPlayerStepFlags
	set PLAYERSTEP_STOP_F, [hl]
	call CopyNextCoordsTileToStandingCoordsTile
	ld hl, OBJECT_DIRECTION_WALKING
	add hl, bc
	ld [hl], STANDING
	ld hl, OBJECT_STEP_TYPE
	add hl, bc
	ld [hl], STEP_TYPE_FROM_MOVEMENT
	ret

StepFunction_Turn:
	call Field1cAnonymousJumptable
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
	call IncrementObjectStructField1c
.step1
	ld hl, OBJECT_STEP_DURATION
	add hl, bc
	dec [hl]
	ret nz
	call IncrementObjectStructField1c
.init2
	ld hl, OBJECT_1D ; new facing
	add hl, bc
	ld a, [hl]
	ld hl, OBJECT_FACING
	add hl, bc
	ld [hl], a
	ld hl, OBJECT_STEP_DURATION
	add hl, bc
	call .GetTurningSpeed
	ld [hl], a
	call IncrementObjectStructField1c
.step2
	ld hl, OBJECT_STEP_DURATION
	add hl, bc
	dec [hl]
	ret nz
	ld hl, OBJECT_STEP_TYPE
	add hl, bc
	ld [hl], STEP_TYPE_FROM_MOVEMENT
	ret

.GetTurningSpeed:
	ld a, [wOptions1]
	bit TURNING_SPEED, a
	ld a, 4
	ret z
	ld a, 2
	ret

StepFunction_StrengthBoulder:
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
	res OBJ_FLAGS2_2, [hl]
	call CopyNextCoordsTileToStandingCoordsTile
	ld hl, OBJECT_DIRECTION_WALKING
	add hl, bc
	ld [hl], STANDING
	ld hl, OBJECT_STEP_TYPE
	add hl, bc
	ld [hl], STEP_TYPE_FROM_MOVEMENT
	ret

StepFunction_TrackingObject:
	ld hl, OBJECT_1D
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
	jmp DeleteMapObject

StepFunction_ScreenShake:
	call Field1cAnonymousJumptable
; anonymous dw
	dw .Init
	dw .Run

.Init:
	xor a
	ld hl, OBJECT_1D
	add hl, bc
	ld [hl], a
	call IncrementObjectStructField1c
.Run:
	ld hl, OBJECT_1D
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
	ld hl, OBJECT_1D
	add hl, bc
	ld [hl], a
	ld d, a
	ld a, [wPlayerStepVectorY]
	add d
	ld [wPlayerStepVectorY], a
	ret

.ok
	jmp DeleteMapObject

.GetSign:
	ld hl, OBJECT_1E
	add hl, bc
	and 1
	ld a, [hl]
	ret z
	cpl
	inc a
	ret

StepFunction_SkyfallTop:
	call Field1cAnonymousJumptable
; anonymous dw
	dw .Init
	dw .Run

.Init:
	ld hl, OBJECT_ACTION
	add hl, bc
	ld [hl], OBJECT_ACTION_SKYFALL
	ld hl, OBJECT_STEP_DURATION
	add hl, bc
	ld [hl], 16
	call IncrementObjectStructField1c

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
	ld [hl], STEP_TYPE_FROM_MOVEMENT
	ret

UpdateJumpPosition:
	call GetStepVector
	push af
	ld a, h
	ld hl, OBJECT_1F
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

StepFunction_NPCStairs:
	; TODO
	ret ; no-optimize stub function

StepFunction_PlayerStairs:
	call Field1cAnonymousJumptable
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
	set PLAYERSTEP_START_F, [hl]
	call IncrementObjectStructField1c
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
	res OVERHEAD_F, [hl]
	ld hl, wPlayerStepFlags
	set PLAYERSTEP_STOP_F, [hl]
	set PLAYERSTEP_MIDAIR_F, [hl]
	jmp IncrementObjectStructField1c

.InitVertical:
 	ld hl, OBJECT_ACTION
	add hl, bc
	ld [hl], OBJECT_ACTION_STAND
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
	set PLAYERSTEP_START_F, [hl]
	call IncrementObjectStructField1c
.StepVertical:
	call UpdateDiagonalStairsPosition
	call UpdatePlayerStep
	ld hl, OBJECT_STEP_DURATION
	add hl, bc
	dec [hl]
	ret nz
	ld hl, wPlayerStepFlags
	set PLAYERSTEP_STOP_F, [hl]
	call CopyNextCoordsTileToStandingCoordsTile
	ld hl, OBJECT_STEP_TYPE
	add hl, bc
	ld [hl], STEP_TYPE_FROM_MOVEMENT
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

GetPlayerNextMovementByte:
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
	jmp _GetMovementByte

GetMovementObject:
	ld a, [wMovementObject]
	ret

_GetMovementObject:
	ld hl, GetMovementObject
	; fallthrough

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
	jmp IndirectHL

ContinueReadingMovement:
	ld a, 1
	ld [wMovementByteWasControlSwitch], a
	ret

DoMovementFunction:
	push af
	call ApplyMovementToFollower
	pop af
	call StackJumpTable

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
	ld de, .GrassObject
	call CopyTempObjectData
	call InitTempObject
	pop bc
	ret

.GrassObject
	db $80, PAL_OW_TREE, SPRITEMOVEDATA_GRASS

SplashPuddle:
	push bc
	ld de, .PuddleObject
	call CopyTempObjectData
	call InitTempObject
	pop bc
	ld de, SFX_PUDDLE
	jmp PlaySFX

.PuddleObject
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
	bit EMOTE_OBJECT_F, [hl]
	jr z, .next
	ld hl, OBJECT_SPRITE
	add hl, de
	ld a, [hl]
	and a
	jr z, .next
	push bc
	xor a
	ld bc, OBJECT_LENGTH
	rst ByteFill
	pop bc
.next
	ld hl, OBJECT_LENGTH
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
	ld a, -1
	ld [hli], a
	ld [hli], a
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
	call nz, UpdateCurObjectData
	ld hl, OBJECT_LENGTH
	add hl, bc
	ld b, h
	ld c, l
	ldh a, [hMapObjectIndexBuffer]
	inc a
	cp NUM_OBJECT_STRUCTS
	jr nz, .loop
	ret

BattleStart_HideAllSpritesExceptBattleParticipants:
; called at battle start
	call MaskAllObjectStructs ; clear sprites
	ld a, PLAYER
	call RespawnObject ; respawn player
	ld a, [wBattleScriptFlags]
	bit 7, a
	jr z, .ok
	ldh a, [hLastTalked]
	and a
	call nz, RespawnObject ; respawn opponent
.ok
	jmp _UpdateSprites

ReturnFromFly_SpawnOnlyPlayer:
	call MaskAllObjectStructs ; clear sprites
	ld a, PLAYER
	call RespawnObject ; respawn player
	jmp _UpdateSprites

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
	call HandleObjectAction_Stationary
	xor a
	ret

MaskAllObjectStructs:
	xor a
	ld bc, wObjectStructs
.loop
	ldh [hMapObjectIndexBuffer], a
	call SetFacing_Standing
	ld hl, OBJECT_LENGTH
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
	call CheckCurSpriteCoveredByTextbox
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
	call HandleObjectAction_Stationary
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
	add MAPOBJECT_SCREEN_WIDTH - 1
	cp d
	jr c, .nope
.equal_x
	ld a, [wYCoord]
	cp e
	jr z, .equal_y
	jr nc, .nope
	add MAPOBJECT_SCREEN_HEIGHT - 1
	cp e
	jr c, .nope
.equal_y
	xor a
	ret

.nope
	scf
	ret

CheckCurSpriteCoveredByTextbox:
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
	cp $f0
	jr nc, .ok1
	cp SCREEN_WIDTH * 8
	jmp nc, .nope
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
	cp $f0
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
	ldh a, [hCurSpriteXCoord]
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
	cp FIRST_REGULAR_TEXT_CHAR
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
	call nz, HandleObjectStep
	ld hl, OBJECT_LENGTH
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
	bit PLAYERSTEP_STOP_F, a
	ld a, $0 ; preserve flags
	ld [wPlayerStepFlags], a
	ret nz
	dec a ; STANDING
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
	ld hl, wPlayerSpriteSetupFlags
	bit PLAYERSPRITESETUP_CUSTOM_FACING_F, [hl]
	ret z
	ld a, [wPlayerSpriteSetupFlags]
	and PLAYERSPRITESETUP_FACING_MASK
	add a
	add a
	jr ContinueSpawnFacing

.TryResetPlayerAction:
	ld hl, wPlayerSpriteSetupFlags
	bit PLAYERSPRITESETUP_RESET_ACTION_F, [hl]
	ret z
	xor a ; OBJECT_ACTION_00
	ld [wPlayerAction], a
	ret

SpawnInFacingDown:
	xor a ; DOWN
ContinueSpawnFacing:
	ld bc, wPlayerStruct
	jmp SetSpriteDirection

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
	and PALETTE_MASK
	ld d, a
	ld hl, OBJECT_PALETTE
	add hl, bc
	ld a, [hl]
	and ~PALETTE_MASK
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
	ld [hl], STEP_TYPE_RESET
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
	call ResetObject
	ld a, -1
	ld [wObjectFollow_Follower], a
	ret

FreezeAllOtherObjects::
	ld a, c
	call CheckObjectVisibility
	ret c
	push bc
	call FreezeAllObjects
	pop bc
	ld hl, OBJECT_FLAGS2
	add hl, bc
	res 5, [hl]
	xor a
	ret

FreezeAllObjects:
	ld bc, wObjectStructs
	xor a
.loop
	push af
	call DoesObjectHaveASprite
	jr z, .next
	ld hl, OBJECT_FLAGS2
	add hl, bc
	set FROZEN_F, [hl]
.next
	ld hl, OBJECT_LENGTH
	add hl, bc
	ld b, h
	ld c, l
	pop af
	inc a
	cp NUM_OBJECT_STRUCTS
	jr nz, .loop
	ret

_UnfreezeFollowerObject::
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
	res FROZEN_F, [hl]
	ret

UnfreezeAllObjects::
	push bc
	ld bc, wObjectStructs
	xor a
.loop
	push af
	call DoesObjectHaveASprite
	jr z, .next
	ld hl, OBJECT_FLAGS2
	add hl, bc
	res FROZEN_F, [hl]
.next
	ld hl, OBJECT_LENGTH
	add hl, bc
	ld b, h
	ld c, l
	pop af
	inc a
	cp NUM_OBJECT_STRUCTS
	jr nz, .loop
	pop bc
	ret

ResetObject:
	ld hl, OBJECT_MAP_OBJECT_INDEX
	add hl, bc
	ld a, [hl]
	cp -1
	jr z, .set_standing
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
	ld [hl], STEP_TYPE_RESET
	ret

.set_standing:
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
	ld [hl], STEP_TYPE_RESET
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
	ld b, 28 * SPRITEOAMSTRUCT_LENGTH
.ok
	ldh a, [hUsedSpriteIndex]
	cp b
	ret nc
	ld l, a
	ld h, HIGH(wVirtualOAM)
	ld de, 4
	ld a, b
	ld c, SCREEN_HEIGHT_PX + 2 * TILE_WIDTH
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
	ld hl, OBJECT_LENGTH
	add hl, bc
	ld b, h
	ld c, l
	pop af
	dec a
	jr nz, .loop
	xor a
	ld [wPlayerBGMapOffsetX], a
	ld [wPlayerBGMapOffsetY], a
	jmp PopBCDEHL

PRIORITY_LOW  EQU $10
PRIORITY_NORM EQU $20
PRIORITY_HIGH EQU $30

InitSprites:
	call .DeterminePriorities
	ld c, PRIORITY_HIGH
	call .InitSpritesByPriority
	ld c, PRIORITY_NORM
	call .InitSpritesByPriority
	ld c, PRIORITY_LOW
	jr .InitSpritesByPriority

.DeterminePriorities:
	xor a
	ld hl, wObjectPriorities
	ld bc, NUM_OBJECT_STRUCTS
	rst ByteFill
	ld d, 0
	ld bc, wObjectStructs
	ld hl, wObjectPriorities
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
	bit LOW_PRIORITY_F, [hl]
	jr nz, .add
	ld e, PRIORITY_NORM
	bit HIGH_PRIORITY_F, [hl]
	jr z, .add
	ld e, PRIORITY_HIGH
	jr .add

.skip
	ld hl, OBJECT_LENGTH
	add hl, bc
	ld b, h
	ld c, l
	pop hl
	jr .next

.add
	ld hl, OBJECT_LENGTH
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
	ld hl, wObjectPriorities
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
	and ~(1 << 7)
	ldh [hCurSpriteTile], a
	xor a
	bit 7, [hl]
	jr nz, .skip1
	or VRAM_BANK_1
.skip1
	ld hl, OBJECT_FLAGS2
	add hl, bc
	ld e, [hl]
	bit OBJ_FLAGS2_7, e
	jr z, .skip2
	or PRIORITY
.skip2
	bit USE_OBP1_F, e
	jr z, .skip3
	or OBP_NUM
.skip3
	ld hl, OBJECT_PALETTE
	add hl, bc
	ld d, a
	ld a, [hl]
	and PALETTE_MASK
	or d
	ld d, a
	xor a
	bit OVERHEAD_F, e
	jr z, .skip4
	or PRIORITY
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
	jr z, .done
	cp NUM_FACINGS
	jr nc, .done
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
	bit ABSOLUTE_TILE_ID_F, e
	jr z, .nope1
	xor a
.nope1
	add [hl]
	inc hl
	ld [bc], a
	ld a, d
	and VRAM_BANK_1
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
	bit RELATIVE_ATTRIBUTES_F, a
	jr z, .nope2
	ldh a, [hCurSpriteOAMFlags]
	or e
.nope2
	and OBP_NUM | X_FLIP | Y_FLIP | PRIORITY
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
