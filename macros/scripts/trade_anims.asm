	const_def

	const tradeanim_next_command
MACRO tradeanim_next
	db tradeanim_next_command ; 00
ENDM

	const tradeanim_show_givemon_data_command
MACRO tradeanim_show_givemon_data
	db tradeanim_show_givemon_data_command ; 01
ENDM

	const tradeanim_show_getmon_data_command
MACRO tradeanim_show_getmon_data
	db tradeanim_show_getmon_data_command ; 02
ENDM

	const tradeanim_enter_link_tube_command
MACRO tradeanim_enter_link_tube
	db tradeanim_enter_link_tube_command ; 03
ENDM

	const_skip

	const tradeanim_exit_link_tube_command
MACRO tradeanim_exit_link_tube
	db tradeanim_exit_link_tube_command ; 05
ENDM

	const tradeanim_tube_to_ot_command
MACRO tradeanim_tube_to_ot
	db tradeanim_tube_to_ot_command ; 06
ENDM

	const_skip 7

	const tradeanim_tube_to_player_command
MACRO tradeanim_tube_to_player
	db tradeanim_tube_to_player_command ; 0e
ENDM

	const_skip 7

	const tradeanim_sent_to_ot_text_command
MACRO tradeanim_sent_to_ot_text
	db tradeanim_sent_to_ot_text_command ; 16
ENDM

	const tradeanim_ot_bids_farewell_command
MACRO tradeanim_ot_bids_farewell
	db tradeanim_ot_bids_farewell_command ; 17
ENDM

	const tradeanim_take_care_of_text_command
MACRO tradeanim_take_care_of_text
	db tradeanim_take_care_of_text_command ; 18
ENDM

	const tradeanim_ot_sends_text_1_command
MACRO tradeanim_ot_sends_text_1
	db tradeanim_ot_sends_text_1_command ; 19
ENDM

	const tradeanim_ot_sends_text_2_command
MACRO tradeanim_ot_sends_text_2
	db tradeanim_ot_sends_text_2_command ; 1a
ENDM

	const tradeanim_setup_givemon_scroll_command
MACRO tradeanim_setup_givemon_scroll
	db tradeanim_setup_givemon_scroll_command ; 1b
ENDM

	const tradeanim_do_givemon_scroll_command
MACRO tradeanim_do_givemon_scroll
	db tradeanim_do_givemon_scroll_command ; 1c
ENDM

	const tradeanim_frontpic_scroll_command
MACRO tradeanim_frontpic_scroll
	db tradeanim_frontpic_scroll_command ; 1d
ENDM

	const tradeanim_textbox_scroll_command
MACRO tradeanim_textbox_scroll
	db tradeanim_textbox_scroll_command ; 1e
ENDM

	const tradeanim_scroll_out_right_command
MACRO tradeanim_scroll_out_right
	db tradeanim_scroll_out_right_command ; 1f
ENDM

	const_skip

	const tradeanim_wait_80_command
MACRO tradeanim_wait_80
	db tradeanim_wait_80_command ; 21
ENDM

	const tradeanim_wait_40_command
MACRO tradeanim_wait_40
	db tradeanim_wait_40_command ; 22
ENDM

	const tradeanim_rocking_ball_command
MACRO tradeanim_rocking_ball
	db tradeanim_rocking_ball_command ; 23
ENDM

	const tradeanim_drop_ball_command
MACRO tradeanim_drop_ball
	db tradeanim_drop_ball_command ; 24
ENDM

	const tradeanim_wait_anim_command
MACRO tradeanim_wait_anim
	db tradeanim_wait_anim_command ; 25
ENDM

	const_skip

	const tradeanim_poof_command
MACRO tradeanim_poof
	db tradeanim_poof_command ; 27
ENDM

	const tradeanim_bulge_through_tube_command
MACRO tradeanim_bulge_through_tube
	db tradeanim_bulge_through_tube_command ; 28
ENDM

	const tradeanim_give_trademon_sfx_command
MACRO tradeanim_give_trademon_sfx
	db tradeanim_give_trademon_sfx_command ; 29
ENDM

	const tradeanim_get_trademon_sfx_command
MACRO tradeanim_get_trademon_sfx
	db tradeanim_get_trademon_sfx_command ; 2a
ENDM

	const tradeanim_end_command
MACRO tradeanim_end
	db tradeanim_end_command ; 2b
ENDM

	const tradeanim_animate_frontpic_command
MACRO tradeanim_animate_frontpic
	db tradeanim_animate_frontpic_command ; 2c
ENDM

	const tradeanim_wait_96_command
MACRO tradeanim_wait_96
	db tradeanim_wait_96_command ; 2d
ENDM

	const tradeanim_wait_80_if_ot_egg_command
MACRO tradeanim_wait_80_if_ot_egg
	db tradeanim_wait_80_if_ot_egg_command ; 2e
ENDM

	const tradeanim_wait_180_if_ot_egg_command
MACRO tradeanim_wait_180_if_ot_egg
	db tradeanim_wait_180_if_ot_egg_command ; 2f
ENDM
