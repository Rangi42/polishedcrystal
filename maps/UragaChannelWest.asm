UragaChannelWest_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

UragaChannelWest_MapEventHeader:

.Warps: db 1
	warp_def 9, 8, 2, SCARY_CAVE_1F

.XYTriggers: db 0

.Signposts: db 2
	signpost 11, 9, SIGNPOST_JUMPTEXT, ScaryCaveWestSignText
	signpost 11, 7, SIGNPOST_ITEM + BIG_PEARL, EVENT_URAGA_CHANNEL_WEST_HIDDEN_BIG_PEARL

.PersonEvents: db 1
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
