MountMoonB1F_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event 26,  4, MOUNT_MOON_1F, 2
	warp_event  5,  3, MOUNT_MOON_1F, 3
	warp_event  3, 11, MOUNT_MOON_1F, 4
	warp_event 15, 15, MOUNT_MOON_B2F, 1
	warp_event 13,  3, MOUNT_MOON_B2F, 2
	warp_event 16, 22, MOUNT_MOON_B2F, 3
	warp_event 27, 23, MOUNT_MOON_B2F, 4
	warp_event 27, 25, ROUTE_4, 1

	def_coord_events

	def_bg_events
	bg_event  5, 18, BGEVENT_ITEM + STAR_PIECE, EVENT_MOUNT_MOON_B1F_HIDDEN_STAR_PIECE
	bg_event 24, 10, BGEVENT_ITEM + MOON_STONE, EVENT_MOUNT_MOON_B1F_HIDDEN_MOON_STONE

	def_object_events
	object_event  5, 20, SPRITE_HIKER, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_COMMAND, jumptextfaceplayer, MountMoonB1FPokefanmText, -1

MountMoonB1FPokefanmText:
	text "I'm excavating for"
	line "fossils here under"
	cont "Mt.Moon."

	para "Sometimes Brock of"
	line "Pewter Gym lends"
	cont "me a hand."
	done
