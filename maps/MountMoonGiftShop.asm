MountMoonGiftShop_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  3,  7, MOUNT_MOON_SQUARE, 2
	warp_event  4,  7, MOUNT_MOON_SQUARE, 2

	def_coord_events

	def_bg_events

	def_object_events
	object_event  4,  3, SPRITE_GRAMPS, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, (1 << MORN), 0, OBJECTTYPE_COMMAND, pokemart, MARTTYPE_STANDARD, MART_MT_MOON, -1
	object_event  1,  2, SPRITE_GRAMPS, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, (1 << DAY), 0, OBJECTTYPE_COMMAND, pokemart, MARTTYPE_STANDARD, MART_MT_MOON, -1
	object_event  1,  6, SPRITE_CUTE_GIRL, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, (1 << MORN), PAL_NPC_RED, OBJECTTYPE_COMMAND, jumptextfaceplayer, MountMoonGiftShopLassText, -1
	object_event  5,  4, SPRITE_CUTE_GIRL, SPRITEMOVEDATA_WALK_UP_DOWN, 1, 0, -1, (1 << DAY), PAL_NPC_RED, OBJECTTYPE_COMMAND, jumptextfaceplayer, MountMoonGiftShopLassText, -1

MountMoonGiftShopLassText:
	text "When the sun goes"
	line "down, Clefairy"
	cont "come out to play."
	done
