Colosseum_MapScriptHeader:
	def_scene_scripts
	scene_script ColosseumTrigger0

	def_callbacks
	callback MAPCALLBACK_OBJECTS, ColosseumScript_SetWhichChris
	callback MAPCALLBACK_NEWMAP, ColosseumScript_InitializeCB

	def_warp_events
	warp_event  4,  7, POKECENTER_2F, 3
	warp_event  5,  7, POKECENTER_2F, 3

	def_coord_events

	def_bg_events
	bg_event  4,  4, BGEVENT_RIGHT, MapColosseumSignpost1Script
	bg_event  5,  4, BGEVENT_LEFT, MapColosseumSignpost1Script

	def_object_events
	object_event  3,  4, SPRITE_CHRIS, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, CableClubFriendScript, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	object_event  6,  4, SPRITE_CHRIS, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, CableClubFriendScript, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_2

	object_const_def
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

CableClubFriendScript:
	jumpthistext

	text "Your friend is"
	line "ready."
	done
