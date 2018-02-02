MountMoonGiftShop_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 2 ; warp events
	warp_event  3,  7, MOUNT_MOON_SQUARE, 2
	warp_event  4,  7, MOUNT_MOON_SQUARE, 2

	db 0 ; coord events

	db 0 ; bg events

	db 4 ; object events
	object_event  4,  3, SPRITE_GRAMPS, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, (1 << MORN), 0, PERSONTYPE_COMMAND, pokemart, MARTTYPE_STANDARD, MART_MT_MOON, -1
	object_event  1,  2, SPRITE_GRAMPS, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, (1 << DAY), 0, PERSONTYPE_COMMAND, pokemart, MARTTYPE_STANDARD, MART_MT_MOON, -1
	object_event  1,  6, SPRITE_LASS, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, (1 << MORN), 0, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x771b3, -1
	object_event  5,  4, SPRITE_LASS, SPRITEMOVEDATA_WALK_UP_DOWN, 1, 0, -1, (1 << DAY), 0, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x771b3, -1

UnknownText_0x771b3:
	text "When the sun goes"
	line "down, Clefairy"
	cont "come out to play."
	done
