TradeCenter_MapScriptHeader:
	def_scene_scripts
	scene_script TradeCenterTrigger0

	def_callbacks
	callback MAPCALLBACK_OBJECTS, TradeCenter_SetWhichChris

	def_warp_events
	warp_event  4,  7, POKECENTER_2F, 2
	warp_event  5,  7, POKECENTER_2F, 2

	def_coord_events

	def_bg_events
	bg_event  4,  4, BGEVENT_RIGHT, MapTradeCenterSignpost1Script
	bg_event  5,  4, BGEVENT_LEFT, MapTradeCenterSignpost1Script

	def_object_events
	object_event  3,  4, SPRITE_CHRIS, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, CableClubFriendScript, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	object_event  6,  4, SPRITE_CHRIS, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, CableClubFriendScript, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_2

	object_const_def
	const TRADECENTER_CHRIS1
	const TRADECENTER_CHRIS2

TradeCenterTrigger0:
	sdefer TradeCenter_Initialize
	end

TradeCenter_SetWhichChris:
	special Special_CableClubCheckWhichChris
	iffalse .Chris2
	disappear TRADECENTER_CHRIS2
	appear TRADECENTER_CHRIS1
	endcallback

.Chris2:
	disappear TRADECENTER_CHRIS1
	appear TRADECENTER_CHRIS2
	endcallback

TradeCenter_Initialize:
	setscene $1
	setmapscene POKECENTER_2F, $1
	end

MapTradeCenterSignpost1Script:
	special Special_TradeCenter
	newloadmap MAPSETUP_LINKRETURN
	end
