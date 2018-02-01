TradeCenter_MapScriptHeader:
	db 1 ; map triggers
	dw TradeCenterTrigger0

	db 1 ; map callbacks
	dbw MAPCALLBACK_OBJECTS, TradeCenter_SetWhichChris

	db 2 ; warps
	warp_def 7, 4, 2, POKECENTER_2F
	warp_def 7, 5, 2, POKECENTER_2F

	db 0 ; xy triggers

	db 2 ; signposts
	signpost 4, 4, SIGNPOST_RIGHT, MapTradeCenterSignpost1Script
	signpost 4, 5, SIGNPOST_LEFT, MapTradeCenterSignpost1Script

	db 2 ; person events
	person_event SPRITE_CHRIS, 4, 3, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, ChrisScript_0x193499, EVENT_GAVE_KURT_APRICORNS
	person_event SPRITE_CHRIS, 4, 6, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, ChrisScript_0x193499, EVENT_RECEIVED_BALLS_FROM_KURT

	const_def 1 ; person constants
	const TRADECENTER_CHRIS1
	const TRADECENTER_CHRIS2

TradeCenterTrigger0:
	priorityjump TradeCenter_Initialize
	end

TradeCenter_SetWhichChris:
	special Special_CableClubCheckWhichChris
	iffalse .Chris2
	disappear TRADECENTER_CHRIS2
	appear TRADECENTER_CHRIS1
	return

.Chris2:
	disappear TRADECENTER_CHRIS1
	appear TRADECENTER_CHRIS2
	return

TradeCenter_Initialize:
	dotrigger $1
	domaptrigger POKECENTER_2F, $1
	end

MapTradeCenterSignpost1Script:
	special Special_TradeCenter
	newloadmap MAPSETUP_LINKRETURN
	end
