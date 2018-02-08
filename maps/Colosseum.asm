Colosseum_MapScriptHeader:
	db 1 ; scene scripts
	scene_script ColosseumTrigger0

	db 2 ; callbacks
	callback MAPCALLBACK_OBJECTS, ColosseumScript_SetWhichChris
	callback MAPCALLBACK_NEWMAP, ColosseumScript_InitializeCB

	db 2 ; warp events
	warp_event  4,  7, POKECENTER_2F, 3
	warp_event  5,  7, POKECENTER_2F, 3

	db 0 ; coord events

	db 2 ; bg events
	bg_event  4,  4, SIGNPOST_RIGHT, MapColosseumSignpost1Script
	bg_event  5,  4, SIGNPOST_LEFT, MapColosseumSignpost1Script

	db 2 ; object events
	object_event  3,  4, SPRITE_CHRIS, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, ChrisScript_0x193499, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	object_event  6,  4, SPRITE_CHRIS, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, ChrisScript_0x193499, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_2

	const_def 1 ; object constants
	const COLOSSEUM_CHRIS1
	const COLOSSEUM_CHRIS2

ColosseumTrigger0:
	priorityjump ColosseumScript_Initialize
	end

ColosseumScript_SetWhichChris:
	special Special_CableClubCheckWhichChris
	iffalse .Chris2
	disappear COLOSSEUM_CHRIS2
	appear COLOSSEUM_CHRIS1
	return

.Chris2:
	disappear COLOSSEUM_CHRIS1
	appear COLOSSEUM_CHRIS2
	return

ColosseumScript_InitializeCB:
	setmapscene POKECENTER_2F, $2
	return

ColosseumScript_Initialize:
	setscene $1
	setmapscene POKECENTER_2F, $2
	end

MapColosseumSignpost1Script:
	special Special_Colosseum
	newloadmap MAPSETUP_LINKRETURN
	end

ChrisScript_0x193499:
	thistext

	text "Your friend is"
	line "ready."
	done
