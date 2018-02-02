UragaChannelWest_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 1 ; warp events
	warp_event  8,  9, SCARY_CAVE_1F, 2

	db 0 ; coord events

	db 2 ; bg events
	bg_event  9, 11, SIGNPOST_JUMPTEXT, ScaryCaveWestSignText
	bg_event  7, 11, SIGNPOST_ITEM + BIG_PEARL, EVENT_URAGA_CHANNEL_WEST_HIDDEN_BIG_PEARL

	db 1 ; object events
	object_event  5,  9, SPRITE_ENGINEER, SPRITEMOVEDATA_WALK_UP_DOWN, 2, 0, -1, -1, PAL_NPC_BROWN, PERSONTYPE_COMMAND, jumptextfaceplayer, UragaChannelWestEngineerText, -1

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
