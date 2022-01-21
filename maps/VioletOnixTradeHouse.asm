VioletOnixTradeHouse_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  3,  7, VIOLET_CITY, 6
	warp_event  4,  7, VIOLET_CITY, 6

	def_coord_events

	def_bg_events

	def_object_events
	object_event  2,  3, SPRITE_POKEFAN_M, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_COMMAND, jumptextfaceplayer, VioletKylesHousePokefanMText, -1
	object_event  6,  5, SPRITE_SCHOOLBOY, SPRITEMOVEDATA_WALK_UP_DOWN, 2, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_COMMAND, trade, NPC_TRADE_KYLE, -1

VioletKylesHousePokefanMText:
	text "A #mon you get"
	line "in a trade grows"
	cont "quickly."

	para "But if you don't"
	line "have the right Gym"

	para "Badge, they may"
	line "disobey you."
	done
