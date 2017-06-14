const_value set 2
	const URAGACHANNELWEST_ENGINEER

UragaChannelWest_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

UragaChannelWestEngineerScript:
	jumptextfaceplayer UragaChannelWestEngineerText

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

ScaryCaveWestSign:
	habitatlist ScaryCaveWestSignText, URAGA_CHANNEL

ScaryCaveWestSignText:
	text "Uraga Channel"
	line "Ahead"

	para "Enter west from"
	line "Route 18 only!"
	done

UragaChannelWestHiddenBigPearl:
	dwb EVENT_URAGA_CHANNEL_WEST_HIDDEN_BIG_PEARL, BIG_PEARL

UragaChannelWest_MapEventHeader:
.Warps:
	db 1
	warp_def $9, $8, 2, SCARY_CAVE_1F

.XYTriggers:
	db 0

.Signposts:
	db 2
	signpost 11, 9, SIGNPOST_READ, ScaryCaveWestSign
	signpost 11, 7, SIGNPOST_ITEM, UragaChannelWestHiddenBigPearl

.PersonEvents:
	db 1
	person_event SPRITE_ENGINEER, 9, 5, SPRITEMOVEDATA_WALK_UP_DOWN, 2, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_SCRIPT, 0, UragaChannelWestEngineerScript, -1
