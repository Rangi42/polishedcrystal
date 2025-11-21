DoPlayerMovement::

	call .GetDPad
	ld a, movement_step_sleep_1
	ld [wMovementAnimation], a
	xor a
	ld [wWalkingIntoEdgeWarp], a
	call .TranslateIntoMovement
	ld c, a
	ld a, [wMovementAnimation]
	ld [wPlayerNextMovement], a
	ret

.GetDPad:

	ldh a, [hJoyDown]
	ld [wCurInput], a

; Standing downhill instead moves down.

	ld hl, wOWState
	bit OWSTATE_BIKING_DOWNHILL, [hl]
	ret z

	ld c, a
	and PAD_CTRL_PAD
	ret nz

	ld a, c
	and PAD_B ; holding b will brake
	ret nz

	ld a, c
	or PAD_DOWN
	ld [wCurInput], a
	ret

.TranslateIntoMovement:
	ld a, [wPlayerState]
	and a ; cp PLAYER_NORMAL
	jr z, .Normal
	cp PLAYER_SURF
	jr z, .Surf
	cp PLAYER_SURF_PIKA
	jr z, .Surf
	cp PLAYER_SKATE
	jr z, .Ice

.Normal:
	call .CheckForced
	call .GetAction
	call .CheckTile
	ret c
	call .CheckTurning
	ret c
	call .TryStep
	ret c
	call .TryJump
	ret c
	call .TryStairs
	ret c
	call .CheckWarp
	ret c
	jr .NotMoving

.Surf:
	call .CheckForced
	call .GetAction
	call .CheckTile
	ret c
	call .CheckTurning
	ret c
	call .TrySurf
	ret c
	jr .NotMoving

.Ice:
	call .CheckForced
	call .GetAction
	call .CheckTile
	ret c
	call .CheckTurning
	ret c
	call .TryStep
	ret c
	call .TryJump
	ret c
	call .TryStairs
	ret c
	call .CheckWarp
	ret c

; Walking into a wall will bump.
	ld a, [wWalkingDirection]
	cp STANDING
	call nz, .BumpSound
	call .StandInPlace
	xor a
	ret

.NotMoving:
	ld a, [wWalkingDirection]
	cp STANDING
	jr z, .Standing

; Walking into an edge warp won't bump.
	ld a, [wWalkingIntoEdgeWarp]
	and a
	call z, .BumpSound
	call ._WalkInPlace
	xor a
	ret

.Standing:
	call .StandInPlace
	xor a
	ret

.CheckTile:
; Tiles such as waterfalls and warps move the player
; in a given direction, overriding input.

	ld a, [wPlayerTileCollision]
	ld c, a
	cp COLL_WHIRLPOOL
	jr nz, .not_whirlpool
	ld a, 3
	scf
	ret

.not_whirlpool
	and $f0
	cp HI_NYBBLE_CURRENT
	jr z, .water
	cp HI_NYBBLE_WARPS
	jr z, .warps
	jr .no_walk

.water
	ld a, c
	and 3
	ld c, a
	ld b, 0
	ld hl, .water_table
	add hl, bc
	ld a, [hl]
	ld [wWalkingDirection], a
	ld a, STEP_RUN
	jr .finish

.water_table
	db RIGHT
	db LEFT
	db UP
	db DOWN

.warps
	ld a, c
	cp COLL_AWNING
	jr z, .up
	cp COLL_DOOR
	jr z, .down
	cp COLL_STAIRCASE
	jr z, .down
	cp COLL_CAVE
	jr nz, .no_walk

.down
	xor a ; DOWN
	jr .set_direction
.up
	ld a, UP
.set_direction
	ld [wWalkingDirection], a
	jr .continue_walk

.no_walk
	xor a
	ret

.continue_walk
	ld a, STEP_WALK
.finish
	call .DoStep
	ld a, 5
	scf
	ret

.CheckTurning:
; If the player is turning, change direction first. This also lets
; the player change facing without moving by tapping a direction.

	ld a, [wPlayerTurningDirection]
	and a
	jr nz, .not_turning
	ld a, [wWalkingDirection]
	cp STANDING
	jr z, .not_turning

	ld e, a
	ld a, [wPlayerDirection]
	rrca
	rrca
	and 3
	cp e
	jr z, .not_turning

	ld a, STEP_TURN
	call .DoStep
	ld a, 2
	scf
	ret

.not_turning
	xor a
	ret

.TryStep:

; Surfing actually calls .TrySurf directly instead of passing through here.
	ld a, [wPlayerState]
	cp PLAYER_SURF
	jr z, .TrySurf
	cp PLAYER_SURF_PIKA
	jr z, .TrySurf

	call .CheckLandPerms
	jr c, .bump

	ld a, [wPanningAroundTinyMap]
	and a
	jr nz, .walk

	call .CheckNPC
	and a
	jr z, .bump
	cp 2
	jr z, .bump

	ld a, [wSpinning]
	and a
	jr nz, .spin

	ld a, [wPlayerTileCollision]
	cp COLL_ICE
	jr z, .ice

	call .RunCheck
	jr z, .run

; Downhill riding is slower when not moving down.
	call .BikeCheck
	jr nz, .walk

	ld hl, wOWState
	bit OWSTATE_BIKING_DOWNHILL, [hl]
	jr z, .fast

	ld a, [wWalkingDirection]
	cp DOWN
	jr z, .fast

	ld a, STEP_WALK
	call .DoStep
	scf
	ret

.fast
	ld a, STEP_BIKE
	call .DoStep
	scf
	ret

.walk
	ld a, STEP_WALK
	call .DoStep
	scf
	ret

.ice
	ld a, STEP_ICE
	call .DoStep
	scf
	ret

.run
	ld a, STEP_RUN
	call .DoStep
; Trainer faces player if they're running
	push af
	ld a, [wWalkingDirection]
	cp STANDING
	call nz, CheckTrainerRun
	pop af
	scf
	ret

.spin
	ld de, SFX_SQUEAK
	call PlaySFX
	ld a, STEP_SPIN
	call .DoStep
	scf
	ret

.bump
	xor a
	ld [wSpinning], a
	ret

.TrySurf:

	call .CheckNPC
	and a
	jr z, .surf_bump
	cp 2
	jr z, .surf_bump

	call .CheckSurfPerms
	jr c, .surf_bump

	and a
	jr nz, .ExitWater

	ld a, [wOWState]
	set OWSTATE_SURF, a
	ld [wOWState], a
	ld a, STEP_FAST
	call .DoStep
	scf
	ret

.ExitWater:
	call .GetOutOfWater
	call PlayMapMusic
	ld a, STEP_WALK
	call .DoStep
	ld a, 6
	scf
	ret

.surf_bump
	xor a
	ret

.TryJump:
	ld a, [wPlayerTileCollision]
	ld e, a
	and $f0
	cp HI_NYBBLE_LEDGES
	jr nz, .DontJump

	ld a, e
	and 7
	ld e, a
	ld d, 0
	ld hl, .ledge_table
	add hl, de
	ld a, [wFacingDirection]
	ld e, a
	and [hl]
	jr z, .DontJump

	ld a, [wPlayerMapX]
	ld d, a
	ld a, [wWalkingX]
	add a
	add d
	ld d, a
	ld a, [wPlayerMapY]
	ld e, a
	ld a, [wWalkingY]
	add a
	add e
	ld e, a
	call GetCoordTileCollision
	call .CheckWalkable
	jr c, .DontJump

	ld de, SFX_JUMP_OVER_LEDGE
	call PlaySFX
	ld a, STEP_LEDGE
	call .DoStep
	ld a, 7
	scf
	ret

.DontJump:
	xor a
	ret

.ledge_table:
	db FACE_RIGHT
	db FACE_LEFT
	db FACE_UP
	db FACE_DOWN
	db FACE_RIGHT | FACE_DOWN
	db FACE_DOWN | FACE_LEFT
	db FACE_UP | FACE_RIGHT
	db FACE_UP | FACE_LEFT

.TryStairs:
	ld a, [wPlayerTileCollision]
	ld e, a
	and $f0
	cp HI_NYBBLE_SIDEWAYS_STAIRS
	jr nz, .DontStairs

	ld a, e
	and 7
	ld e, a
	ld d, 0
	ld hl, .FacingStairsTable
	add hl, de
	ld a, [wFacingDirection]
	and [hl]
	jr z, .DontStairs

	ld a, [wPlayerTileCollision]
	cp COLL_STAIRS_RIGHT_UP
	; a = carry ? FALSE : TRUE
	sbc a
	inc a
	ld [wPlayerGoingUpStairs], a

	ld a, STEP_STAIRS
	call .DoStep
	ld a, 7
	scf
	ret

.FacingStairsTable:
	db FACE_RIGHT
	db FACE_LEFT
	db FACE_RIGHT
	db FACE_LEFT

.DontStairs:
	xor a
	ret

.CheckWarp:

	ld a, [wWalkingDirection]
	cp STANDING
	jr z, .not_warp
	ld e, a
	ld d, 0
	ld hl, .EdgeWarps
	add hl, de
	ld a, [wPlayerTileCollision]
	cp [hl]
	jr nz, .not_warp

	ld a, TRUE
	ld [wWalkingIntoEdgeWarp], a
	ld a, [wPlayerDirection]
	rrca
	rrca
	and 3
	cp e
	jr nz, .not_warp
	call WarpCheck
	jr nc, .not_warp

	call .StandInPlace
	scf
	ld a, 1
	ret

.not_warp
	xor a
	ret

.EdgeWarps:
	db COLL_WARP_CARPET_DOWN
	db COLL_WARP_CARPET_UP
	db COLL_WARP_CARPET_LEFT
	db COLL_WARP_CARPET_RIGHT

.DoStep:
	ld e, a
	ld d, 0
	ld hl, .Steps
	add hl, de
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a

	ld a, [wWalkingDirection]
	ld e, a
	cp STANDING
	jr z, .StandInPlace

	add hl, de
	ld a, [hl]
	ld [wMovementAnimation], a

	ld hl, .InPlace
	add hl, de
	ld a, [hl]
	ld [wPlayerTurningDirection], a

	ld a, [wOverworldWeatherCooldown]
	and a
	jr z, .no_cooldown
	dec a
	ld [wOverworldWeatherCooldown], a
.no_cooldown

	ld a, 4
	ret

.Steps:
; entries correspond to STEP_* constants (see constants/map_object_constants.asm)
	table_width 2
	dw .SlowStep ; x0.5
	dw .NormalStep ; x1
	dw .FastStep ; x4
	dw .Run ; x2, doubles animation speed
	dw .JumpStep
	dw .SlideStep
	dw .TurningStep
	dw .BackJumpStep
	dw .InPlace
	dw .SpinStep
	dw .Fast ; x2
	dw .StairsStep
	assert_table_length NUM_STEPS

.SlowStep:
	slow_step_down
	slow_step_up
	slow_step_left
	slow_step_right
.NormalStep:
	step_down
	step_up
	step_left
	step_right
.FastStep:
	big_step_down
	big_step_up
	big_step_left
	big_step_right
.Run
	run_step_down
	run_step_up
	run_step_left
	run_step_right
.JumpStep:
	jump_step_down
	jump_step_up
	jump_step_left
	jump_step_right
.SlideStep:
	fast_slide_step_down
	fast_slide_step_up
	fast_slide_step_left
	fast_slide_step_right
.BackJumpStep:
	jump_step_up
	jump_step_down
	jump_step_right
	jump_step_left
.TurningStep:
	turn_step_down
	turn_step_up
	turn_step_left
	turn_step_right
.InPlace:
	db $80 + movement_turn_head_down
	db $80 + movement_turn_head_up
	db $80 + movement_turn_head_left
	db $80 + movement_turn_head_right
.SpinStep
	turn_in_down
	turn_in_up
	turn_in_left
	turn_in_right
.Fast
	fast_step_down
	fast_step_up
	fast_step_left
	fast_step_right
.StairsStep
	stairs_step_down
	stairs_step_up
	stairs_step_left
	stairs_step_right

.StandInPlace:
	ld a, movement_step_sleep_1
	ld [wMovementAnimation], a
	xor a
	ld [wPlayerTurningDirection], a
	ret

._WalkInPlace:
	ld a, movement_step_bump
	ld [wMovementAnimation], a
	xor a
	ld [wPlayerTurningDirection], a
	ret

.CheckForced:
; When sliding on ice, input is forced to remain in the same direction.

	call CheckSpinning
	jr z, .not_spinning
	dec a
	jr .force

.not_spinning
	call CheckStandingOnIce
	ret nc

	ld a, [wPlayerTurningDirection]
	and a
	ret z

.force
	and 3
	ld e, a
	ld d, 0
	ld hl, .forced_dpad
	add hl, de
	ld a, [wCurInput]
	and PAD_BUTTONS
	or [hl]
	ld [wCurInput], a
	ret

.forced_dpad
	db PAD_DOWN, PAD_UP, PAD_LEFT, PAD_RIGHT

.GetAction:
; Poll player input and update movement info.

	ld hl, .table
	ld de, .table2 - .table1
	ld a, [wCurInput]
	bit B_PAD_DOWN, a
	jr nz, .d_down
	bit B_PAD_UP, a
	jr nz, .d_up
	bit B_PAD_LEFT, a
	jr nz, .d_left
	bit B_PAD_RIGHT, a
	jr nz, .d_right
; Standing
	jr .update

.d_down
	add hl, de
.d_up
	add hl, de
.d_left
	add hl, de
.d_right
	add hl, de
.update
	ld a, [hli]
	ld [wWalkingDirection], a
	ld a, [hli]
	ld [wFacingDirection], a
	ld a, [hli]
	ld [wWalkingX], a
	ld a, [hli]
	ld [wWalkingY], a
	ld a, [hli]
	ld h, [hl]
	ld l, a
if DEF(DEBUG)
	ldh a, [hJoyDown]
	or ~(PAD_A | PAD_B)
	inc a
	ld a, [hl]
	jr nz, .no_wtw
	cp COLL_VOID
	jr z, .no_wtw
	ld a, COLL_LADDER
.no_wtw
else
	ld a, [hl]
endc
	ld [wWalkingTileCollision], a
	ret

.table
; struct:
;	walk direction
;	facing
;	x movement
;	y movement
;	tile collision pointer
.table1
	db STANDING, FACE_CURRENT, 0, 0
	dw wPlayerTileCollision
.table2
	db RIGHT, FACE_RIGHT,  1,  0
	dw wTileRight
	db LEFT,  FACE_LEFT,  -1,  0
	dw wTileLeft
	db UP,    FACE_UP,     0, -1
	dw wTileUp
	db DOWN,  FACE_DOWN,   0,  1
	dw wTileDown

.CheckNPC:
; Returns 0 if there is an NPC in front that you can't move
; Returns 1 if there is no NPC in front
; Returns 2 if there is a movable NPC in front. The game actually treats
; this the same as an NPC in front (bump).
	xor a
	ldh [hMapObjectIndexBuffer], a
; Load the next X coordinate into d
	ld a, [wPlayerMapX]
	ld d, a
	ld a, [wWalkingX]
	add d
	ld d, a
; Load the next Y coordinate into e
	ld a, [wPlayerMapY]
	ld e, a
	ld a, [wWalkingY]
	add e
	ld e, a
; Find an object struct with coordinates equal to d,e
	farcall IsNPCAtCoord
	jr nc, .no_npc
	call .CheckStrengthBoulder
	jr c, .no_bump

	xor a ; bump
	ret

.no_npc
	ld a, 1
	ret

.no_bump
	ld a, 2
	ret

.CheckStrengthBoulder:

	ld hl, wOWState
	bit OWSTATE_STRENGTH, [hl]
	jr z, .not_boulder

	ld hl, OBJECT_WALKING
	add hl, bc
	ld a, [hl]
	cp STANDING
	jr nz, .not_boulder

	ld hl, OBJECT_PALETTE
	add hl, bc
	bit 6, [hl]
	jr z, .not_boulder

	ld hl, OBJECT_FLAGS2
	add hl, bc
	set 2, [hl]

	ld a, [wWalkingDirection]
	ld d, a
	ld hl, OBJECT_RANGE
	add hl, bc
	ld a, [hl]
	and $fc
	or d
	ld [hl], a

	scf
	ret

.not_boulder
	xor a
	ret

.CheckLandPerms:
; Return 0 if walking onto land and tile permissions allow it.
; Otherwise, return carry.

	ld a, [wTilePermissions]
	ld d, a
	ld a, [wFacingDirection]
	and d
	jr nz, .NotWalkable

	ld a, [wWalkingTileCollision]
	call .CheckWalkable
	jr c, .NotWalkable

	xor a
	ret

.NotWalkable:
	scf
	ret

.CheckSurfPerms:
; Return 0 if moving in water, or 1 if moving onto land.
; Otherwise, return carry.

	ld a, [wTilePermissions]
	ld d, a
	ld a, [wFacingDirection]
	and d
	jr nz, .NotSurfable

	ld a, [wWalkingTileCollision]
	call .CheckSurfable
	jr c, .NotSurfable

	and a
	ret

.NotSurfable:
	scf
	ret

.BikeCheck:
	ld a, [wPlayerState]
	cp PLAYER_BIKE
	ret z
	cp PLAYER_SKATE
	ret

.RunCheck:
	; Check if we have regular movement active
	ld a, [wPlayerState]
	and a ; cp PLAYER_NORMAL
	ret nz

	; If RUNNING_SHOES is active, invert B button effect.
	push hl
	ld hl, wOptions2
	ldh a, [hJoypadDown]
	and PAD_B

	; We want to return z on success, not nz.
	cpl

	; PAD_B is bit 1, RUNNING_SHOES is bit 3
	add a
	add a
	xor [hl]
	pop hl
	and 1 << RUNNING_SHOES
	ret

.CheckWalkable:
; Return 0 if tile a is land. Otherwise, return carry.

	call GetTilePermission
	and a ; cp LAND_TILE
	ret z
	scf
	ret

.CheckSurfable:
; Return 0 if tile a is water, or 1 if land.
; Otherwise, return carry.

	call GetTilePermission
; Can walk back onto land from water.
	and a ; cp LAND_TILE
	jr z, .Land
	dec a ; cp WATER_TILE
	jr nz, .Neither

.Water:
	xor a
	ret

.Land:
	ld a, 1
	and a
	ret

.Neither:
	scf
	ret

.BumpSound:
	ld a, [wPanningAroundTinyMap]
	and a
	ret nz

	call CheckSFX
	ret nz
	ld de, SFX_BUMP
	jmp PlaySFX

.GetOutOfWater:
	push bc
	ld a, PLAYER_NORMAL
	ld [wPlayerState], a
	call UpdatePlayerSprite ; UpdateSprites
	pop bc
	ret

CheckStandingOnIce::
	ld a, [wPlayerTurningDirection]
	and a
	jr z, .not_ice
	cp $f0
	jr z, .not_ice
	ld a, [wPlayerTileCollision]
	cp COLL_ICE
	jr z, .ice
	ld a, [wPlayerState]
	cp PLAYER_SKATE
	jr nz, .not_ice

.ice
	scf
	ret

.not_ice
	and a
	ret

CheckTrainerRun:
; Check if any trainer on the map sees the player.

; Skip the player object.
	ld a, 1
	ld de, wMap1Object

.loop

; Have them face the player if the object:

	push af
	push de

; Is a trainer
	ld hl, MAPOBJECT_TYPE
	add hl, de
	ld a, [hl]
	cp OBJECTTYPE_TRAINER
	jr z, .trainer
	cp OBJECTTYPE_GENERICTRAINER
	jr nz, .next
.trainer

; Spins around
	ld hl, MAPOBJECT_MOVEMENT
	add hl, de
	ld a, [hl]
	cp SPRITEMOVEDATA_SPINRANDOM_SLOW
	jr z, .spinner
	cp SPRITEMOVEDATA_SPINRANDOM_FAST
	jr z, .spinner
	cp SPRITEMOVEDATA_SPINCOUNTERCLOCKWISE
	jr z, .spinner
	cp SPRITEMOVEDATA_SPINCLOCKWISE
	jr nz, .next
.spinner

; Has a sprite
	ld hl, MAPOBJECT_SPRITE
	add hl, de
	ld a, [hl]
	and a
	jr z, .next

; Is visible on the map
	ld hl, MAPOBJECT_OBJECT_STRUCT_ID
	add hl, de
	ld a, [hl]
	inc a
	assert UNASSOCIATED_MAPOBJECT == -1
	jr z, .next

; You're within their sight range
	ld hl, MAPOBJECT_OBJECT_STRUCT_ID
	add hl, de
	ld a, [hl]
	call GetObjectStruct
	push de
	call AnyFacingPlayerDistance
	pop de
	ld hl, MAPOBJECT_SIGHT_RANGE
	add hl, de
	ld a, [hl]
	cp c
	jr c, .next

; Get them to face you
	ld a, b
	push af
	ld hl, MAPOBJECT_OBJECT_STRUCT_ID
	add hl, de
	ld a, [hl]
	call GetObjectStruct
	pop af
	call SetSpriteDirection
	ld hl, OBJECT_STEP_DURATION
	add hl, bc
	ld a, [hl]
	cp $40
	jr nc, .next
	ld [hl], $40

.next
	pop de
	ld hl, MAPOBJECT_LENGTH
	add hl, de
	ld d, h
	ld e, l

	pop af
	inc a
	cp NUM_OBJECTS
	jr nz, .loop
	xor a
	ret

AnyFacingPlayerDistance:
; Returns distance in c and direction in b.
	ld hl, OBJECT_MAP_X
	add hl, bc
	ld d, [hl]

	ld hl, OBJECT_MAP_Y
	add hl, bc
	ld e, [hl]

	ldh a, [hJoypadDown]
	ld bc, 0
	bit B_PAD_DOWN, a
	jr nz, .down
	bit B_PAD_UP, a
	jr nz, .up
	bit B_PAD_LEFT, a
	jr nz, .left
	bit B_PAD_RIGHT, a
	jr nz, .right
.down
	inc b
	jr .got_vector
.up
	dec b
	jr .got_vector
.left
	dec c
	jr .got_vector
.right
	inc c
.got_vector

	ld a, [wPlayerMapX]
	add c
	sub d
	ld l, OW_RIGHT
	jr nc, .check_y
	cpl
	inc a
	ld l, OW_LEFT
.check_y
	ld d, a
	ld a, [wPlayerMapY]
	add b
	sub e
	ld h, OW_DOWN
	jr nc, .compare
	cpl
	inc a
	ld h, OW_UP
.compare
	cp d
	ld c, a
	ld b, h
	ret nc
	ld c, d
	ld b, l
	ret

CheckSpinning::
	ld a, [wPlayerTileCollision]
	cp COLL_STOP_SPIN
	jr z, .stop_spin
	call CheckSpinTile
	jr z, .start_spin
	ld a, [wSpinning]
	and a
	ret

.start_spin
	ld a, c
	inc a
	ld [wSpinning], a
	and a
	ret

.stop_spin
	xor a
	ld [wSpinning], a
	ret

CheckSpinTile:
	cp COLL_SPIN_UP
	ld c, UP
	ret z
	cp COLL_SPIN_DOWN
	ld c, DOWN
	ret z
	cp COLL_SPIN_LEFT
	ld c, LEFT
	ret z
	cp COLL_SPIN_RIGHT
	ld c, RIGHT
	ret z
	ld c, STANDING
	ret

StopPlayerForEvent::
	ld hl, wPlayerNextMovement
	ld a, movement_step_sleep_1
	cp [hl]
	ret z

	ld [hl], a
	xor a
	ld [wPlayerTurningDirection], a
	ret
