TradeCenter_MapScriptHeader:
	def_scene_scripts
	scene_script TradeCenterInitializeScene, SCENE_TRADECENTER_INITIALIZE
	scene_const SCENE_TRADECENTER_NOOP

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
	object_event  3,  4, SPRITE_LINK_TRAINER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, 0, OBJECTTYPE_SCRIPT, 0, CableClubFriendScript, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	object_event  6,  4, SPRITE_LINK_TRAINER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, 0, OBJECTTYPE_SCRIPT, 0, CableClubFriendScript, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_2

	object_const_def
	const TRADECENTER_LINK_TRAINER1
	const TRADECENTER_LINK_TRAINER2

TradeCenterInitializeScene:
	sdefer TradeCenter_Initialize
	end

TradeCenter_SetWhichChris:
	special Special_CableClubCheckWhichChris
	iffalsefwd .Chris2
	disappear TRADECENTER_LINK_TRAINER2
	appear TRADECENTER_LINK_TRAINER1
	endcallback

.Chris2:
	disappear TRADECENTER_LINK_TRAINER1
	appear TRADECENTER_LINK_TRAINER2
	endcallback

TradeCenter_Initialize:
	setscene SCENE_TRADECENTER_NOOP
	setmapscene POKECENTER_2F, SCENE_POKECENTER2F_LEAVE_TRADE_CENTER
	end

MapTradeCenterSignpost1Script:
	special Special_TradeCenter
	newloadmap MAPSETUP_LINKRETURN
	end
