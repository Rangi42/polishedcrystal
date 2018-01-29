MountMoonGiftShop_MapScriptHeader:
	db 0 ; map triggers

	db 0 ; map callbacks

MountMoonGiftShop_MapEventHeader:
	db 2 ; warps
	warp_def 7, 3, 2, MOUNT_MOON_SQUARE
	warp_def 7, 4, 2, MOUNT_MOON_SQUARE

	db 0 ; xy triggers

	db 0 ; signposts

	db 4 ; person events
	person_event SPRITE_GRAMPS, 3, 4, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, (1 << MORN), 0, PERSONTYPE_COMMAND, pokemart, MARTTYPE_STANDARD, MART_MT_MOON, -1
	person_event SPRITE_GRAMPS, 2, 1, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, (1 << DAY), 0, PERSONTYPE_COMMAND, pokemart, MARTTYPE_STANDARD, MART_MT_MOON, -1
	person_event SPRITE_LASS, 6, 1, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, (1 << MORN), 0, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x771b3, -1
	person_event SPRITE_LASS, 4, 5, SPRITEMOVEDATA_WALK_UP_DOWN, 1, 0, -1, (1 << DAY), 0, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x771b3, -1

UnknownText_0x771b3:
	text "When the sun goes"
	line "down, Clefairy"
	cont "come out to play."
	done
