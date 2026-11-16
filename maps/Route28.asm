Route28_MapScriptHeader:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_CMDQUEUE, Route28SetUpPaletteSwap

	def_warp_events
	warp_event  7,  3, ROUTE_28_FAMOUS_SPEECH_HOUSE, 1
	warp_event 33,  6, POKEMON_LEAGUE_GATE, 7
	warp_event 33,  7, POKEMON_LEAGUE_GATE, 8

	def_coord_events

	def_bg_events
	bg_event 29,  7, BGEVENT_JUMPTEXT, Route28SignText
	bg_event 25,  3, BGEVENT_ITEM + RARE_CANDY, EVENT_ROUTE_28_HIDDEN_RARE_CANDY

	def_object_events

Route28SetUpPaletteSwap:
	usepaletteswap .PaletteSwap
	endcallback

.PaletteSwap:
	paletteswap 0, 15, 0, 255, PAL_BG_RED, OverworldRedPalettes, SteelWingHouseRoofPalettes
	db -1 ; end

Route28SignText: ; text > text
	text "Route 28"
	done
