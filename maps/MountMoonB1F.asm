MountMoonB1F_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 8 ; warp events
	warp_event 26, 4, 2, MOUNT_MOON_1F
	warp_event 5, 3, 3, MOUNT_MOON_1F
	warp_event 3, 11, 4, MOUNT_MOON_1F
	warp_event 15, 15, 1, MOUNT_MOON_B2F
	warp_event 13, 3, 2, MOUNT_MOON_B2F
	warp_event 16, 22, 3, MOUNT_MOON_B2F
	warp_event 27, 23, 4, MOUNT_MOON_B2F
	warp_event 27, 25, 1, ROUTE_4

	db 0 ; coord events

	db 2 ; bg events
	bg_event 5, 18, SIGNPOST_ITEM + STAR_PIECE, EVENT_MOUNT_MOON_B1F_HIDDEN_STAR_PIECE
	bg_event 24, 10, SIGNPOST_ITEM + MOON_STONE, EVENT_MOUNT_MOON_B1F_HIDDEN_MOON_STONE

	db 1 ; object events
	object_event 5, 20, SPRITE_POKEFAN_M, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_COMMAND, jumptextfaceplayer, MountMoonB1FPokefanmText, -1

MountMoonB1FPokefanmText:
	text "I'm excavating for"
	line "fossils here under"
	cont "Mt.Moon."

	para "Sometimes Brock of"
	line "Pewter Gym lends"
	cont "me a hand."
	done
