UragaChannelWest_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event 16,  9, SCARY_CAVE_1F, 2

	def_coord_events

	def_bg_events
	bg_event 17, 11, BGEVENT_JUMPTEXT, ScaryCaveWestSignText
	bg_event 15, 11, BGEVENT_ITEM + BIG_PEARL, EVENT_URAGA_CHANNEL_WEST_HIDDEN_BIG_PEARL

	def_object_events
	object_event 13,  9, SPRITE_ENGINEER, SPRITEMOVEDATA_WALK_UP_DOWN, 2, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_COMMAND, jumptextfaceplayer, UragaChannelWestEngineerText, -1

UragaChannelWestEngineerText:
	text "The currents wash"
	line "up all kinds of"
	cont "debris here."

	para "I'm using a metal"
	line "detector to find"
	cont "hidden items."

	para "But an Itemfinder"
	line "would work better…"
	done

ScaryCaveWestSignText:
	text "Uraga Channel"
	line "Ahead"

	para "Enter west from"
	line "Route 18 only!"
	done
