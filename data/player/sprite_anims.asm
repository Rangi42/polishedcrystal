; This file is INCLUDEd in:
; - engine/pokegear/pokegear.asm
; - engine/menus/naming_screen.asm

	table_width 1
	db SPRITE_ANIM_INDEX_RED_WALK    ; PLAYER_MALE
	db SPRITE_ANIM_INDEX_BLUE_WALK   ; PLAYER_FEMALE
	db SPRITE_ANIM_INDEX_GREEN_WALK  ; PLAYER_ENBY
	db SPRITE_ANIM_INDEX_PURPLE_WALK ; PLAYER_BETA
	assert_table_length NUM_PLAYER_GENDERS
