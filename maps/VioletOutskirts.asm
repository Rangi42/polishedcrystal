VioletOutskirts_MapScriptHeader:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_TILES, VioletOutskirtsAvalanche

	def_warp_events
	warp_event 10, 12, HIDDEN_TREE_GROTTO, 1
	warp_event 21,  9, VIOLET_OUTSKIRTS_HOUSE, 1

	def_coord_events

	def_bg_events
	bg_event 10, 11, BGEVENT_JUMPSTD, treegrotto, HIDDENGROTTO_VIOLET_OUTSKIRTS
	bg_event 11, 11, BGEVENT_JUMPSTD, treegrotto, HIDDENGROTTO_VIOLET_OUTSKIRTS
	bg_event 19,  9, BGEVENT_JUMPTEXT, VioletOutskirtsCemeterySignText
	bg_event 25,  8, BGEVENT_JUMPTEXT, VioletOutskirtsHeadstoneText
	bg_event 27,  8, BGEVENT_JUMPTEXT, VioletOutskirtsHeadstoneText
	bg_event 29,  8, BGEVENT_JUMPTEXT, VioletOutskirtsHeadstoneText
	bg_event 31,  8, BGEVENT_JUMPTEXT, VioletOutskirtsHeadstoneText
	bg_event 25, 10, BGEVENT_JUMPTEXT, VioletOutskirtsHeadstoneText
	bg_event 27, 10, BGEVENT_JUMPTEXT, VioletOutskirtsHeadstoneText
	bg_event 29, 10, BGEVENT_JUMPTEXT, VioletOutskirtsHeadstoneText
	bg_event 31, 10, BGEVENT_JUMPTEXT, VioletOutskirtsHeadstoneText

	def_object_events
	object_event 16, -2, SPRITE_MON_ICON, SPRITEMOVEDATA_POKEMON, 0, SUICUNE, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, NO_FORM, ObjectEvent, EVENT_SAW_SUICUNE_ON_ROUTE_42
	fruittree_event  2, 10, FRUITTREE_VIOLET_OUTSKIRTS, RAWST_BERRY, PAL_NPC_TEAL
	fruittree_event 17, -2, FRUITTREE_ROUTE_42_1, PNK_APRICORN, PAL_NPC_PINK
	fruittree_event 18, -2, FRUITTREE_ROUTE_42_2, GRN_APRICORN, PAL_NPC_GREEN
	fruittree_event 19, -2, FRUITTREE_ROUTE_42_3, YLW_APRICORN, PAL_NPC_YELLOW
	itemball_event 14, 24, PP_UP, 1, EVENT_VIOLET_CITY_PP_UP

VioletOutskirtsAvalanche:
	checkevent EVENT_GOT_HM05_WHIRLPOOL
	iftruefwd .end
	changeblock 4, -2, $0a
	changeblock 6, -2, $0a
.end
	endcallback

VioletOutskirtsCemeterySignText:
	text "Violet Cemetery"
	line "Caretaker's House"
	done

VioletOutskirtsHeadstoneText:
	text "It's too faded"
	line "to read…"
	done
