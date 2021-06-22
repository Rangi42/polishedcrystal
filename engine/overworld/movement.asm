MovementPointers:
; entries correspond to movement_* constants (see macros/scripts/movement.asm)
	table_width 2, MovementPointers
	dw Movement_turn_head_down        ; 00
	dw Movement_turn_head_up          ; 01
	dw Movement_turn_head_left        ; 02
	dw Movement_turn_head_right       ; 03
	dw Movement_turn_step_down        ; 04
	dw Movement_turn_step_up          ; 05
	dw Movement_turn_step_left        ; 06
	dw Movement_turn_step_right       ; 07
	dw Movement_slow_step_down        ; 08
	dw Movement_slow_step_up          ; 09
	dw Movement_slow_step_left        ; 0a
	dw Movement_slow_step_right       ; 0b
	dw Movement_step_down             ; 0c
	dw Movement_step_up               ; 0d
	dw Movement_step_left             ; 0e
	dw Movement_step_right            ; 0f
	dw Movement_big_step_down         ; 10
	dw Movement_big_step_up           ; 11
	dw Movement_big_step_left         ; 12
	dw Movement_big_step_right        ; 13
	dw Movement_slow_slide_step_down  ; 14
	dw Movement_slow_slide_step_up    ; 15
	dw Movement_slow_slide_step_left  ; 16
	dw Movement_slow_slide_step_right ; 17
	dw Movement_slide_step_down       ; 18
	dw Movement_slide_step_up         ; 19
	dw Movement_slide_step_left       ; 1a
	dw Movement_slide_step_right      ; 1b
	dw Movement_fast_slide_step_down  ; 1c
	dw Movement_fast_slide_step_up    ; 1d
	dw Movement_fast_slide_step_left  ; 1e
	dw Movement_fast_slide_step_right ; 1f
	dw Movement_turn_away_down        ; 20
	dw Movement_turn_away_up          ; 21
	dw Movement_turn_away_left        ; 22
	dw Movement_turn_away_right       ; 23
	dw Movement_turn_in_down          ; 24
	dw Movement_turn_in_up            ; 25
	dw Movement_turn_in_left          ; 26
	dw Movement_turn_in_right         ; 27
	dw Movement_turn_waterfall_down   ; 28
	dw Movement_turn_waterfall_up     ; 29
	dw Movement_turn_waterfall_left   ; 2a
	dw Movement_turn_waterfall_right  ; 2b
	dw Movement_slow_jump_step_down   ; 2c
	dw Movement_slow_jump_step_up     ; 2d
	dw Movement_slow_jump_step_left   ; 2e
	dw Movement_slow_jump_step_right  ; 2f
	dw Movement_jump_step_down        ; 30
	dw Movement_jump_step_up          ; 31
	dw Movement_jump_step_left        ; 32
	dw Movement_jump_step_right       ; 33
	dw Movement_fast_jump_step_down   ; 34
	dw Movement_fast_jump_step_up     ; 35
	dw Movement_fast_jump_step_left   ; 36
	dw Movement_fast_jump_step_right  ; 37
	dw Movement_remove_sliding        ; 38
	dw Movement_set_sliding           ; 39
	dw Movement_remove_fixed_facing   ; 3a
	dw Movement_fix_facing            ; 3b
	dw Movement_show_object           ; 3c
	dw Movement_hide_object           ; 3d
	dw Movement_step_sleep_1          ; 3e
	dw Movement_step_sleep_2          ; 3f
	dw Movement_step_sleep_3          ; 40
	dw Movement_step_sleep_4          ; 41
	dw Movement_step_sleep_5          ; 42
	dw Movement_step_sleep_6          ; 43
	dw Movement_step_sleep_7          ; 44
	dw Movement_step_sleep_8          ; 45
	dw Movement_step_sleep            ; 46
	dw Movement_step_end              ; 47
	dw Movement_step_resume           ; 48
	dw Movement_remove_object         ; 49
	dw Movement_step_loop             ; 4a
	dw Movement_4b                    ; 4b
	dw Movement_teleport_from         ; 4c
	dw Movement_teleport_to           ; 4d
	dw Movement_skyfall               ; 4e
	dw Movement_step_dig              ; 4f
	dw Movement_step_bump             ; 50
	dw Movement_fish_got_bite         ; 51
	dw Movement_fish_cast_rod         ; 52
	dw Movement_hide_emote            ; 53
	dw Movement_show_emote            ; 54
	dw Movement_step_shake            ; 55
	dw Movement_tree_shake            ; 56
	dw Movement_rock_smash            ; 57
	dw Movement_return_dig            ; 58
	dw Movement_skyfall_top           ; 59
	dw Movement_run_step_down         ; 5a
	dw Movement_run_step_up           ; 5b
	dw Movement_run_step_left         ; 5c
	dw Movement_run_step_right        ; 5d
	dw Movement_fast_step_down        ; 5e
	dw Movement_fast_step_up          ; 5f
	dw Movement_fast_step_left        ; 60
	dw Movement_fast_step_right       ; 61
	dw Movement_stairs_step_down      ; 62
	dw Movement_stairs_step_up        ; 63
	dw Movement_stairs_step_left      ; 64
	dw Movement_stairs_step_right     ; 65
	assert_table_length NUM_MOVEMENT_CMDS

Movement_teleport_from:
	ld hl, OBJECT_STEP_TYPE
	add hl, bc
	ld [hl], STEP_TYPE_TELEPORT_FROM
	ret

Movement_teleport_to:
	ld hl, OBJECT_STEP_TYPE
	add hl, bc
	ld [hl], STEP_TYPE_TELEPORT_TO
	ret

Movement_skyfall:
	ld hl, OBJECT_STEP_TYPE
	add hl, bc
	ld [hl], STEP_TYPE_SKYFALL
	ret

Movement_skyfall_top:
	ld hl, OBJECT_STEP_TYPE
	add hl, bc
	ld [hl], STEP_TYPE_SKYFALL_TOP
	ret

Movement_step_dig:
	call GetSpriteDirection
	rlca
	rlca
	ld hl, OBJECT_STEP_FRAME
	add hl, bc
	ld [hl], a
	ld hl, OBJECT_ACTION
	add hl, bc
	ld [hl], OBJECT_ACTION_SPIN
	call JumpMovementPointer
	ld hl, OBJECT_STEP_DURATION
	add hl, bc
	ld [hl], a
	ld hl, OBJECT_STEP_TYPE
	add hl, bc
	ld [hl], STEP_TYPE_SLEEP
	ld hl, OBJECT_DIRECTION_WALKING
	add hl, bc
	ld [hl], STANDING
	ret

Movement_return_dig:
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
	ld hl, OBJECT_DIRECTION_WALKING
	add hl, bc
	ld [hl], STANDING
	ld hl, OBJECT_STEP_TYPE
	add hl, bc
	ld [hl], STEP_TYPE_RETURN_DIG
	ret

Movement_fish_got_bite:
	ld hl, OBJECT_ACTION
	add hl, bc
	ld [hl], OBJECT_ACTION_FISHING
	ld hl, OBJECT_STEP_TYPE
	add hl, bc
	ld [hl], STEP_TYPE_GOT_BITE
	ret

Movement_rock_smash:
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

Movement_fish_cast_rod:
	ld hl, OBJECT_ACTION
	add hl, bc
	ld [hl], OBJECT_ACTION_FISHING
	ld hl, OBJECT_STEP_TYPE
	add hl, bc
	ld [hl], STEP_TYPE_FROM_MOVEMENT
	ret

Movement_step_loop:
	ld hl, OBJECT_MOVEMENT_BYTE_INDEX
	add hl, bc
	ld [hl], $0
	jmp ContinueReadingMovement

Movement_step_resume:
Movement_step_end:
	call RestoreDefaultMovement
	ld hl, OBJECT_MOVEMENTTYPE
	add hl, bc
	ld [hl], a

	ld hl, OBJECT_MOVEMENT_BYTE_INDEX
	add hl, bc
	ld [hl], $0

	ld hl, wVramState
	res 7, [hl]

	ld hl, OBJECT_STEP_TYPE
	add hl, bc
	ld [hl], STEP_TYPE_FROM_MOVEMENT
	ret

Movement_remove_object:
	call DeleteMapObject
	ld hl, wObjectFollow_Leader
	ldh a, [hMapObjectIndexBuffer]
	cp [hl]
	jr nz, .not_leading
	ld [hl], -1

.not_leading
	ld hl, wVramState
	res 7, [hl]
	ret

Movement_4b:
	ld hl, OBJECT_ACTION
	add hl, bc
	ld [hl], OBJECT_ACTION_STAND

	ld hl, OBJECT_STEP_TYPE
	add hl, bc
	ld [hl], STEP_TYPE_STANDING

	ld hl, wVramState
	res 7, [hl]
	ret

Movement_step_sleep_1:
	ld a, 1
	jr Movement_step_sleep_common

Movement_step_sleep_2:
	ld a, 2
	jr Movement_step_sleep_common

Movement_step_sleep_3:
	ld a, 3
	jr Movement_step_sleep_common

Movement_step_sleep_4:
	ld a, 4
	jr Movement_step_sleep_common

Movement_step_sleep_5:
	ld a, 5
	jr Movement_step_sleep_common

Movement_step_sleep_6:
	ld a, 6
	jr Movement_step_sleep_common

Movement_step_sleep_7:
	ld a, 7
	jr Movement_step_sleep_common

Movement_step_sleep_8:
	ld a, 8
	jr Movement_step_sleep_common

Movement_step_sleep:
; parameters:
;	duration (DecimalParam)
	call JumpMovementPointer
	; fallthrough
Movement_step_sleep_common:
	ld hl, OBJECT_STEP_DURATION
	add hl, bc
	ld [hl], a

	ld hl, OBJECT_STEP_TYPE
	add hl, bc
	ld [hl], STEP_TYPE_SLEEP

	ld hl, OBJECT_ACTION
	add hl, bc
	ld [hl], OBJECT_ACTION_STAND

	ld hl, OBJECT_DIRECTION_WALKING
	add hl, bc
	ld [hl], STANDING
	ret

Movement_step_bump:
	ld a, 1
	ld hl, OBJECT_STEP_DURATION
	add hl, bc
	ld [hl], a

	ld hl, OBJECT_STEP_TYPE
	add hl, bc
	ld [hl], STEP_TYPE_BUMP

	ld hl, OBJECT_ACTION
	add hl, bc
	ld [hl], OBJECT_ACTION_BUMP

	ld hl, OBJECT_DIRECTION_WALKING
	add hl, bc
	ld [hl], STANDING
	ret

Movement_tree_shake:
	ld a, 24
	ld hl, OBJECT_STEP_DURATION
	add hl, bc
	ld [hl], a

	ld hl, OBJECT_STEP_TYPE
	add hl, bc
	ld [hl], STEP_TYPE_SLEEP

	ld hl, OBJECT_ACTION
	add hl, bc
	ld [hl], OBJECT_ACTION_WEIRD_TREE

	ld hl, OBJECT_DIRECTION_WALKING
	add hl, bc
	ld [hl], STANDING
	ret

Movement_remove_sliding:
	ld hl, OBJECT_FLAGS1
	add hl, bc
	res SLIDING_F, [hl]
	jmp ContinueReadingMovement

Movement_set_sliding:
	ld hl, OBJECT_FLAGS1
	add hl, bc
	set SLIDING_F, [hl]
	jmp ContinueReadingMovement

Movement_remove_fixed_facing:
	ld hl, OBJECT_FLAGS1
	add hl, bc
	res FIXED_FACING_F, [hl]
	jmp ContinueReadingMovement

Movement_fix_facing:
	ld hl, OBJECT_FLAGS1
	add hl, bc
	set FIXED_FACING_F, [hl]
	jmp ContinueReadingMovement

Movement_show_object:
	ld hl, OBJECT_FLAGS1
	add hl, bc
	res INVISIBLE_F, [hl]
	jmp ContinueReadingMovement

Movement_hide_object:
	ld hl, OBJECT_FLAGS1
	add hl, bc
	set INVISIBLE_F, [hl]
	jmp ContinueReadingMovement

Movement_hide_emote:
	call DespawnEmote
	jmp ContinueReadingMovement

Movement_show_emote:
	call SpawnEmote
	jmp ContinueReadingMovement

Movement_step_shake:
; parameters:
;	displacement (DecimalParam)

	call JumpMovementPointer
	call ShakeScreen
	jmp ContinueReadingMovement

Movement_turn_head_down:
	ld a, OW_DOWN
	jr TurnHead

Movement_turn_head_up:
	ld a, OW_UP
	jr TurnHead

Movement_turn_head_left:
	ld a, OW_LEFT
	jr TurnHead

Movement_turn_head_right:
	ld a, OW_RIGHT
	; fallthrough
TurnHead:
	ld hl, OBJECT_FACING
	add hl, bc
	ld [hl], a

	ld hl, OBJECT_ACTION
	add hl, bc
	ld [hl], OBJECT_ACTION_STAND

	ld hl, OBJECT_DIRECTION_WALKING
	add hl, bc
	ld [hl], STANDING
	ret

Movement_slow_step_down:
	ld a, STEP_SLOW << 2 | DOWN
	jr Movement_do_step

Movement_slow_step_up:
	ld a, STEP_SLOW << 2 | UP
	jr Movement_do_step

Movement_slow_step_left:
	ld a, STEP_SLOW << 2 | LEFT
	jr Movement_do_step

Movement_slow_step_right:
	ld a, STEP_SLOW << 2 | RIGHT
	jr Movement_do_step

Movement_step_down:
	ld a, STEP_WALK << 2 | DOWN
	jr Movement_do_step

Movement_step_up:
	ld a, STEP_WALK << 2 | UP
	jr Movement_do_step

Movement_step_left:
	ld a, STEP_WALK << 2 | LEFT
	jr Movement_do_step

Movement_step_right:
	ld a, STEP_WALK << 2 | RIGHT
	jr Movement_do_step

Movement_fast_step_down:
	ld a, STEP_RUN << 2 | DOWN
	jr Movement_do_step

Movement_fast_step_up:
	ld a, STEP_RUN << 2 | UP
	jr Movement_do_step

Movement_fast_step_left:
	ld a, STEP_RUN << 2 | LEFT
	jr Movement_do_step

Movement_fast_step_right:
	ld a, STEP_RUN << 2 | RIGHT
	jr Movement_do_step

Movement_big_step_down:
	ld a, STEP_BIKE << 2 | DOWN
	jr Movement_do_step

Movement_big_step_up:
	ld a, STEP_BIKE << 2 | UP
	jr Movement_do_step

Movement_big_step_left:
	ld a, STEP_BIKE << 2 | LEFT
	jr Movement_do_step

Movement_big_step_right:
	ld a, STEP_BIKE << 2 | RIGHT
Movement_do_step:
	ld d, OBJECT_ACTION_STEP
Movement_normal_step:
	jmp NormalStep

Movement_run_step_down:
	ld a, STEP_RUN << 2 | DOWN  ; STEP_RUN
	jr Movement_do_run

Movement_run_step_up:
	ld a, STEP_RUN << 2 | UP    ; STEP_RUN
	jr Movement_do_run

Movement_run_step_left:
	ld a, STEP_RUN << 2 | LEFT  ; STEP_RUN
	jr Movement_do_run

Movement_run_step_right:
	ld a, STEP_RUN << 2 | RIGHT ; STEP_RUN
Movement_do_run:
	ld d, OBJECT_ACTION_RUN
	jr Movement_normal_step

Movement_turn_away_down:
	ld a, STEP_SLOW << 2 | DOWN
	jr Movement_turning_step

Movement_turn_away_up:
	ld a, STEP_SLOW << 2 | UP
	jr Movement_turning_step

Movement_turn_away_left:
	ld a, STEP_SLOW << 2 | LEFT
	jr Movement_turning_step

Movement_turn_away_right:
	ld a, STEP_SLOW << 2 | RIGHT
	jr Movement_turning_step

Movement_turn_in_down:
	ld a, STEP_WALK << 2 | DOWN
	jr Movement_turning_step

Movement_turn_in_up:
	ld a, STEP_WALK << 2 | UP
	jr Movement_turning_step

Movement_turn_in_left:
	ld a, STEP_WALK << 2 | LEFT
	jr Movement_turning_step

Movement_turn_in_right:
	ld a, STEP_WALK << 2 | RIGHT
	jr Movement_turning_step

Movement_turn_waterfall_down:
	ld a, STEP_WALK << 2 | DOWN
	jr Movement_turning_step

Movement_turn_waterfall_up:
	ld a, STEP_WALK << 2 | UP
	jr Movement_turning_step

Movement_turn_waterfall_left:
	ld a, STEP_WALK << 2 | LEFT
	jr Movement_turning_step

Movement_turn_waterfall_right:
	ld a, STEP_WALK << 2 | RIGHT
Movement_turning_step:
	jmp TurningStep

Movement_slow_slide_step_down:
	ld a, STEP_SLOW << 2 | DOWN
	jr Movement_slide_step

Movement_slow_slide_step_up:
	ld a, STEP_SLOW << 2 | UP
	jr Movement_slide_step

Movement_slow_slide_step_left:
	ld a, STEP_SLOW << 2 | LEFT
	jr Movement_slide_step

Movement_slow_slide_step_right:
	ld a, STEP_SLOW << 2 | RIGHT
	jr Movement_slide_step

Movement_slide_step_down:
	ld a, STEP_WALK << 2 | DOWN
	jr Movement_slide_step

Movement_slide_step_up:
	ld a, STEP_WALK << 2 | UP
	jr Movement_slide_step

Movement_slide_step_left:
	ld a, STEP_WALK << 2 | LEFT
	jr Movement_slide_step

Movement_slide_step_right:
	ld a, STEP_WALK << 2 | RIGHT
	jr Movement_slide_step

Movement_fast_slide_step_down:
	ld a, STEP_RUN << 2 | DOWN
	jr Movement_slide_step

Movement_fast_slide_step_up:
	ld a, STEP_RUN << 2 | UP
	jr Movement_slide_step

Movement_fast_slide_step_left:
	ld a, STEP_RUN << 2 | LEFT
	jr Movement_slide_step

Movement_fast_slide_step_right:
	ld a, STEP_RUN << 2 | RIGHT
Movement_slide_step:
	jmp SlideStep

Movement_slow_jump_step_down:
	ld a, STEP_SLOW << 2 | DOWN
	jr Movement_jump_step

Movement_slow_jump_step_up:
	ld a, STEP_SLOW << 2 | UP
	jr Movement_jump_step

Movement_slow_jump_step_left:
	ld a, STEP_SLOW << 2 | LEFT
	jr Movement_jump_step

Movement_slow_jump_step_right:
	ld a, STEP_SLOW << 2 | RIGHT
	jr Movement_jump_step

Movement_jump_step_down:
	ld a, STEP_WALK << 2 | DOWN
	jr Movement_jump_step

Movement_jump_step_up:
	ld a, STEP_WALK << 2 | UP
	jr Movement_jump_step

Movement_jump_step_left:
	ld a, STEP_WALK << 2 | LEFT
	jr Movement_jump_step

Movement_jump_step_right:
	ld a, STEP_WALK << 2 | RIGHT
	jr Movement_jump_step

Movement_fast_jump_step_down:
	ld a, STEP_BIKE << 2 | DOWN
	jr Movement_jump_step

Movement_fast_jump_step_up:
	ld a, STEP_BIKE << 2 | UP
	jr Movement_jump_step

Movement_fast_jump_step_left:
	ld a, STEP_BIKE << 2 | LEFT
	jr Movement_jump_step

Movement_fast_jump_step_right:
	ld a, STEP_BIKE << 2 | RIGHT
Movement_jump_step:
	jr JumpStep ; no-optimize stub jump

Movement_turn_step_down:
	ld a, OW_DOWN
	jr TurnStep

Movement_turn_step_up:
	ld a, OW_UP
	jr TurnStep

Movement_turn_step_left:
	ld a, OW_LEFT
	jr TurnStep

Movement_turn_step_right:
	ld a, OW_RIGHT
	; fallthrough
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

NormalStep:
	push de
	call InitStep
	call UpdateTallGrassFlags
	ld hl, OBJECT_ACTION
	add hl, bc
	ld [hl], OBJECT_ACTION_STEP
	pop de
	ld [hl], d

	ld hl, OBJECT_FLAGS1
	add hl, bc
	bit INVISIBLE_F, [hl]
	jr nz, SetWalkStepType

	ld hl, OBJECT_NEXT_TILE
	add hl, bc
	ld a, [hl]
	cp COLL_LONG_GRASS
	jr z, .shake_grass
	cp COLL_TALL_GRASS
	jr z, .shake_grass
	cp COLL_PUDDLE
	call z, SplashPuddle
	jr SetWalkStepType

.shake_grass
	call ShakeGrass
SetWalkStepType:
	ld hl, wCenteredObject
	ldh a, [hMapObjectIndexBuffer]
	cp [hl]
	ld hl, OBJECT_STEP_TYPE
	add hl, bc
	ld [hl], STEP_TYPE_NPC_WALK
	ret nz
	ld [hl], STEP_TYPE_PLAYER_WALK
	ret

TurningStep:
	call InitStep
	call UpdateTallGrassFlags

	ld hl, OBJECT_ACTION
	add hl, bc
	ld [hl], OBJECT_ACTION_SPIN
	jr SetWalkStepType

SlideStep:
	call InitStep
	call UpdateTallGrassFlags

	ld hl, OBJECT_ACTION
	add hl, bc
	ld [hl], OBJECT_ACTION_STAND
	jr SetWalkStepType

JumpStep:
	call InitStep
	ld hl, OBJECT_1F
	add hl, bc
	ld [hl], $0

	ld hl, OBJECT_FLAGS2
	add hl, bc
	res OVERHEAD_F, [hl]

	ld hl, OBJECT_ACTION
	add hl, bc
	ld [hl], OBJECT_ACTION_STEP

	call SpawnShadow

	ld hl, wCenteredObject
	ldh a, [hMapObjectIndexBuffer]
	cp [hl]
	ld hl, OBJECT_STEP_TYPE
	add hl, bc
	ld [hl], STEP_TYPE_NPC_JUMP
	ret nz
	ld [hl], STEP_TYPE_PLAYER_JUMP
	ret

Movement_stairs_step_down:
	ld a, STEP_WALK << 2 | DOWN
	jr DiagonalStairsStep

Movement_stairs_step_up:
	ld a, STEP_WALK << 2 | UP
	jr DiagonalStairsStep

Movement_stairs_step_left:
	ld a, STEP_WALK << 2 | LEFT
	jr DiagonalStairsStep

Movement_stairs_step_right:
	ld a, STEP_WALK << 2 | RIGHT

DiagonalStairsStep:
	call InitStep
	ld hl, OBJECT_1F
	add hl, bc
	ld [hl], $0

	ld hl, OBJECT_ACTION
	add hl, bc
	ld [hl], OBJECT_ACTION_STEP

	ld hl, wCenteredObject
	ldh a, [hMapObjectIndexBuffer]
	cp [hl]
	ld hl, OBJECT_STEP_TYPE
	add hl, bc
	ld [hl], STEP_TYPE_NPC_STAIRS
	ret nz
	ld [hl], STEP_TYPE_PLAYER_STAIRS
	ret
