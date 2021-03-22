	const_def

	const tradeanim_next_command
tradeanim_next: MACRO
	db tradeanim_next_command ; 00
ENDM

	const tradeanim_show_givemon_data_command
tradeanim_show_givemon_data: MACRO
	db tradeanim_show_givemon_data_command ; 01
ENDM

	const tradeanim_show_getmon_data_command
tradeanim_show_getmon_data: MACRO
	db tradeanim_show_getmon_data_command ; 02
ENDM

	const tradeanim_enter_link_tube_command
tradeanim_enter_link_tube: MACRO
	db tradeanim_enter_link_tube_command ; 03
ENDM

	const_skip

	const tradeanim_exit_link_tube_command
tradeanim_exit_link_tube: MACRO
	db tradeanim_exit_link_tube_command ; 05
ENDM

	const tradeanim_tube_to_ot_command
tradeanim_tube_to_ot: MACRO
	db tradeanim_tube_to_ot_command ; 06
ENDM

	const_skip 7

	const tradeanim_tube_to_player_command
tradeanim_tube_to_player: MACRO
	db tradeanim_tube_to_player_command ; 0e
ENDM

	const_skip 7

	const tradeanim_sent_to_ot_text_command
tradeanim_sent_to_ot_text: MACRO
	db tradeanim_sent_to_ot_text_command ; 16
ENDM

	const tradeanim_ot_bids_farewell_command
tradeanim_ot_bids_farewell: MACRO
	db tradeanim_ot_bids_farewell_command ; 17
ENDM

	const tradeanim_take_care_of_text_command
tradeanim_take_care_of_text: MACRO
	db tradeanim_take_care_of_text_command ; 18
ENDM

	const tradeanim_ot_sends_text_1_command
tradeanim_ot_sends_text_1: MACRO
	db tradeanim_ot_sends_text_1_command ; 19
ENDM

	const tradeanim_ot_sends_text_2_command
tradeanim_ot_sends_text_2: MACRO
	db tradeanim_ot_sends_text_2_command ; 1a
ENDM

	const tradeanim_setup_givemon_scroll_command
tradeanim_setup_givemon_scroll: MACRO
	db tradeanim_setup_givemon_scroll_command ; 1b
ENDM

	const tradeanim_do_givemon_scroll_command
tradeanim_do_givemon_scroll: MACRO
	db tradeanim_do_givemon_scroll_command ; 1c
ENDM

	const tradeanim_frontpic_scroll_command
tradeanim_frontpic_scroll: MACRO
	db tradeanim_frontpic_scroll_command ; 1d
ENDM

	const tradeanim_textbox_scroll_command
tradeanim_textbox_scroll: MACRO
	db tradeanim_textbox_scroll_command ; 1e
ENDM

	const tradeanim_scroll_out_right_command
tradeanim_scroll_out_right: MACRO
	db tradeanim_scroll_out_right_command ; 1f
ENDM

	const_skip

	const tradeanim_wait_80_command
tradeanim_wait_80: MACRO
	db tradeanim_wait_80_command ; 21
ENDM

	const tradeanim_wait_40_command
tradeanim_wait_40: MACRO
	db tradeanim_wait_40_command ; 22
ENDM

	const tradeanim_rocking_ball_command
tradeanim_rocking_ball: MACRO
	db tradeanim_rocking_ball_command ; 23
ENDM

	const tradeanim_drop_ball_command
tradeanim_drop_ball: MACRO
	db tradeanim_drop_ball_command ; 24
ENDM

	const tradeanim_wait_anim_command
tradeanim_wait_anim: MACRO
	db tradeanim_wait_anim_command ; 25
ENDM

	const_skip

	const tradeanim_poof_command
tradeanim_poof: MACRO
	db tradeanim_poof_command ; 27
ENDM

	const tradeanim_bulge_through_tube_command
tradeanim_bulge_through_tube: MACRO
	db tradeanim_bulge_through_tube_command ; 28
ENDM

	const tradeanim_give_trademon_sfx_command
tradeanim_give_trademon_sfx: MACRO
	db tradeanim_give_trademon_sfx_command ; 29
ENDM

	const tradeanim_get_trademon_sfx_command
tradeanim_get_trademon_sfx: MACRO
	db tradeanim_get_trademon_sfx_command ; 2a
ENDM

	const tradeanim_end_command
tradeanim_end: MACRO
	db tradeanim_end_command ; 2b
ENDM

	const tradeanim_animate_frontpic_command
tradeanim_animate_frontpic: MACRO
	db tradeanim_animate_frontpic_command ; 2c
ENDM

	const tradeanim_wait_96_command
tradeanim_wait_96: MACRO
	db tradeanim_wait_96_command ; 2d
ENDM

	const tradeanim_wait_80_if_ot_egg_command
tradeanim_wait_80_if_ot_egg: MACRO
	db tradeanim_wait_80_if_ot_egg_command ; 2e
ENDM

	const tradeanim_wait_180_if_ot_egg_command
tradeanim_wait_180_if_ot_egg: MACRO
	db tradeanim_wait_180_if_ot_egg_command ; 2f
ENDM
