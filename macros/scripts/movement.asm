	const_def

	const movement_turn_head_down
turn_head_down: MACRO
	db movement_turn_head_down ; $00
ENDM

	const movement_turn_head_up
turn_head_up: MACRO
	db movement_turn_head_up ; $01
ENDM

	const movement_turn_head_left
turn_head_left: MACRO
	db movement_turn_head_left ; $02
ENDM

	const movement_turn_head_right
turn_head_right: MACRO
	db movement_turn_head_right ; $03
ENDM

	const movement_turn_step_down
turn_step_down: MACRO
	db movement_turn_step_down ; $04
ENDM

	const movement_turn_step_up
turn_step_up: MACRO
	db movement_turn_step_up ; $05
ENDM

	const movement_turn_step_left
turn_step_left: MACRO
	db movement_turn_step_left ; $06
ENDM

	const movement_turn_step_right
turn_step_right: MACRO
	db movement_turn_step_right ; $07
ENDM

	const movement_slow_step_down
slow_step_down: MACRO
	db movement_slow_step_down ; $08
ENDM

	const movement_slow_step_up
slow_step_up: MACRO
	db movement_slow_step_up ; $09
ENDM

	const movement_slow_step_left
slow_step_left: MACRO
	db movement_slow_step_left ; $0a
ENDM

	const movement_slow_step_right
slow_step_right: MACRO
	db movement_slow_step_right ; $0b
ENDM

	const movement_step_down
step_down: MACRO
	db movement_step_down ; $0c
ENDM

	const movement_step_up
step_up: MACRO
	db movement_step_up ; $0d
ENDM

	const movement_step_left
step_left: MACRO
	db movement_step_left ; $0e
ENDM

	const movement_step_right
step_right: MACRO
	db movement_step_right ; $0f
ENDM

	const movement_big_step_down
big_step_down: MACRO
	db movement_big_step_down ; $10
ENDM

	const movement_big_step_up
big_step_up: MACRO
	db movement_big_step_up ; $11
ENDM

	const movement_big_step_left
big_step_left: MACRO
	db movement_big_step_left ; $12
ENDM

	const movement_big_step_right
big_step_right: MACRO
	db movement_big_step_right ; $13
ENDM

	const movement_slow_slide_step_down
slow_slide_step_down: MACRO
	db movement_slow_slide_step_down ; $14
ENDM

	const movement_slow_slide_step_up
slow_slide_step_up: MACRO
	db movement_slow_slide_step_up ; $15
ENDM

	const movement_slow_slide_step_left
slow_slide_step_left: MACRO
	db movement_slow_slide_step_left ; $16
ENDM

	const movement_slow_slide_step_right
slow_slide_step_right: MACRO
	db movement_slow_slide_step_right ; $17
ENDM

	const movement_slide_step_down
slide_step_down: MACRO
	db movement_slide_step_down ; $18
ENDM

	const movement_slide_step_up
slide_step_up: MACRO
	db movement_slide_step_up ; $19
ENDM

	const movement_slide_step_left
slide_step_left: MACRO
	db movement_slide_step_left ; $1a
ENDM

	const movement_slide_step_right
slide_step_right: MACRO
	db movement_slide_step_right ; $1b
ENDM

	const movement_fast_slide_step_down
fast_slide_step_down: MACRO
	db movement_fast_slide_step_down ; $1c
ENDM

	const movement_fast_slide_step_up
fast_slide_step_up: MACRO
	db movement_fast_slide_step_up ; $1d
ENDM

	const movement_fast_slide_step_left
fast_slide_step_left: MACRO
	db movement_fast_slide_step_left ; $1e
ENDM

	const movement_fast_slide_step_right
fast_slide_step_right: MACRO
	db movement_fast_slide_step_right ; $1f
ENDM

	const movement_turn_away_down
turn_away_down: MACRO
	db movement_turn_away_down ; $20
ENDM

	const movement_turn_away_up
turn_away_up: MACRO
	db movement_turn_away_up ; $21
ENDM

	const movement_turn_away_left
turn_away_left: MACRO
	db movement_turn_away_left ; $22
ENDM

	const movement_turn_away_right
turn_away_right: MACRO
	db movement_turn_away_right ; $23
ENDM

	const movement_turn_in_down
turn_in_down: MACRO
	db movement_turn_in_down ; $24
ENDM

	const movement_turn_in_up
turn_in_up: MACRO
	db movement_turn_in_up ; $25
ENDM

	const movement_turn_in_left
turn_in_left: MACRO
	db movement_turn_in_left ; $26
ENDM

	const movement_turn_in_right
turn_in_right: MACRO
	db movement_turn_in_right ; $27
ENDM

	const movement_turn_waterfall_down
turn_waterfall_down: MACRO
	db movement_turn_waterfall_down ; $28
ENDM

	const movement_turn_waterfall_up
turn_waterfall_up: MACRO
	db movement_turn_waterfall_up ; $29
ENDM

	const movement_turn_waterfall_left
turn_waterfall_left: MACRO
	db movement_turn_waterfall_left ; $2a
ENDM

	const movement_turn_waterfall_right
turn_waterfall_right: MACRO
	db movement_turn_waterfall_right ; $2b
ENDM

	const movement_slow_jump_step_down
slow_jump_step_down: MACRO
	db movement_slow_jump_step_down ; $2c
ENDM

	const movement_slow_jump_step_up
slow_jump_step_up: MACRO
	db movement_slow_jump_step_up ; $2d
ENDM

	const movement_slow_jump_step_left
slow_jump_step_left: MACRO
	db movement_slow_jump_step_left ; $2e
ENDM

	const movement_slow_jump_step_right
slow_jump_step_right: MACRO
	db movement_slow_jump_step_right ; $2f
ENDM

	const movement_jump_step_down
jump_step_down: MACRO
	db movement_jump_step_down ; $30
ENDM

	const movement_jump_step_up
jump_step_up: MACRO
	db movement_jump_step_up ; $31
ENDM

	const movement_jump_step_left
jump_step_left: MACRO
	db movement_jump_step_left ; $32
ENDM

	const movement_jump_step_right
jump_step_right: MACRO
	db movement_jump_step_right ; $33
ENDM

	const movement_fast_jump_step_down
fast_jump_step_down: MACRO
	db movement_fast_jump_step_down ; $34
ENDM

	const movement_fast_jump_step_up
fast_jump_step_up: MACRO
	db movement_fast_jump_step_up ; $35
ENDM

	const movement_fast_jump_step_left
fast_jump_step_left: MACRO
	db movement_fast_jump_step_left ; $36
ENDM

	const movement_fast_jump_step_right
fast_jump_step_right: MACRO
	db movement_fast_jump_step_right ; $37
ENDM

	const movement_remove_sliding
remove_sliding: MACRO
	db movement_remove_sliding ; $38
ENDM

	const movement_set_sliding
set_sliding: MACRO
	db movement_set_sliding ; $39
ENDM

	const movement_remove_fixed_facing
remove_fixed_facing: MACRO
	db movement_remove_fixed_facing ; $3a
ENDM

	const movement_fix_facing
fix_facing: MACRO
	db movement_fix_facing ; $3b
ENDM

	const movement_show_object
show_object: MACRO
	db movement_show_object ; $3c
ENDM

	const movement_hide_object
hide_object: MACRO
	db movement_hide_object ; $3d
ENDM

	const movement_step_sleep_1
step_sleep_1: MACRO
	db movement_step_sleep_1 ; $3e
ENDM

	const movement_step_sleep_2
step_sleep_2: MACRO
	db movement_step_sleep_2 ; $3f
ENDM

	const movement_step_sleep_3
step_sleep_3: MACRO
	db movement_step_sleep_3 ; $40
ENDM

	const movement_step_sleep_4
step_sleep_4: MACRO
	db movement_step_sleep_4 ; $41
ENDM

	const movement_step_sleep_5
step_sleep_5: MACRO
	db movement_step_sleep_5 ; $42
ENDM

	const movement_step_sleep_6
step_sleep_6: MACRO
	db movement_step_sleep_6 ; $43
ENDM

	const movement_step_sleep_7
step_sleep_7: MACRO
	db movement_step_sleep_7 ; $44
ENDM

	const movement_step_sleep_8
step_sleep_8: MACRO
	db movement_step_sleep_8 ; $45
ENDM

	const movement_step_sleep
step_sleep: MACRO
	db movement_step_sleep ; $46
	db \1 ; duration
ENDM

	const movement_step_end
step_end: MACRO
	db movement_step_end ; $47
ENDM

	const movement_step_resume
step_resume: MACRO
	db movement_step_resume ; $48
ENDM

	const movement_remove_object
remove_object: MACRO
	db movement_remove_object ; $49
ENDM

	const movement_step_loop
step_loop: MACRO
	db movement_step_loop ; $4a
ENDM

	const movement_step_4b
step_4b: MACRO
	db movement_step_4b ; $4b
ENDM

	const movement_teleport_from
teleport_from: MACRO
	db movement_teleport_from ; $4c
ENDM

	const movement_teleport_to
teleport_to: MACRO
	db movement_teleport_to ; $4d
ENDM

	const movement_skyfall
skyfall: MACRO
	db movement_skyfall ; $4e
ENDM

	const movement_step_dig
step_dig: MACRO
	db movement_step_dig ; $4f
	db \1
ENDM

	const movement_step_bump
step_bump: MACRO
	db movement_step_bump ; $50
ENDM

	const movement_fish_got_bite
fish_got_bite: MACRO
	db movement_fish_got_bite ; $51
ENDM

	const movement_fish_cast_rod
fish_cast_rod: MACRO
	db movement_fish_cast_rod ; $52
ENDM

	const movement_hide_emote
hide_emote: MACRO
	db movement_hide_emote ; $53
ENDM

	const movement_show_emote
show_emote: MACRO
	db movement_show_emote ; $54
ENDM

	const movement_step_shake
step_shake: MACRO
	db movement_step_shake ; $55
	db \1 ; displacement
ENDM

	const movement_tree_shake
tree_shake: MACRO
	db movement_tree_shake
ENDM

	const movement_rock_smash
rock_smash: MACRO
	db movement_rock_smash ; $57
	db \1
ENDM

	const movement_return_dig
return_dig: MACRO
	db movement_return_dig ; $58
	db \1
ENDM

	const movement_skyfall_top
skyfall_top: MACRO
	db movement_skyfall_top ; $59
ENDM

	const movement_run_step_down
run_step_down: MACRO
	db movement_run_step_down ; $5a
ENDM

	const movement_run_step_up
run_step_up: MACRO
	db movement_run_step_up ; $5b
ENDM

	const movement_run_step_left
run_step_left: MACRO
	db movement_run_step_left ; $5c
ENDM

	const movement_run_step_right
run_step_right: MACRO
	db movement_run_step_right ; $5d
ENDM

	const movement_fast_step_down
fast_step_down: MACRO
	db movement_fast_step_down ; $5e
ENDM

	const movement_fast_step_up
fast_step_up: MACRO
	db movement_fast_step_up ; $5f
ENDM

	const movement_fast_step_left
fast_step_left: MACRO
	db movement_fast_step_left ; $60
ENDM

	const movement_fast_step_right
fast_step_right: MACRO
	db movement_fast_step_right ; $61
ENDM

	const movement_stairs_step_down
stairs_step_down: MACRO
	db movement_stairs_step_down ; $62
ENDM

	const movement_stairs_step_up
stairs_step_up: MACRO
	db movement_stairs_step_up ; $63
ENDM

	const movement_stairs_step_left
stairs_step_left: MACRO
	db movement_stairs_step_left ; $64
ENDM

	const movement_stairs_step_right
stairs_step_right: MACRO
	db movement_stairs_step_right ; $65
ENDM

NUM_MOVEMENT_CMDS EQU const_value
