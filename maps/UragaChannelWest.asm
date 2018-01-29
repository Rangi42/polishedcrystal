UragaChannelWest_MapScriptHeader:
	db 0 ; map triggers

	db 0 ; map callbacks

UragaChannelWest_MapEventHeader:
	db 1 ; warps
	warp_def 9, 8, 2, SCARY_CAVE_1F

	db 0 ; xy triggers

	db 2 ; signposts
	signpost 11, 9, SIGNPOST_JUMPTEXT, ScaryCaveWestSignText
	signpost 11, 7, SIGNPOST_ITEM + BIG_PEARL, EVENT_URAGA_CHANNEL_WEST_HIDDEN_BIG_PEARL

	db 1 ; person events
	person_event SPRITE_ENGINEER, 9, 5, SPRITEMOVEDATA_WALK_UP_DOWN, 2, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_COMMAND, jumptextfaceplayer, UragaChannelWestEngineerText, -1

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
