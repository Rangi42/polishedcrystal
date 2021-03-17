Route43MahoganyGate_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  4,  0, ROUTE_43, 1
	warp_event  5,  0, ROUTE_43, 2
	warp_event  4,  7, MAHOGANY_TOWN, 5
	warp_event  5,  7, MAHOGANY_TOWN, 5

	def_coord_events

	def_bg_events

	def_object_events
	object_event  0,  4, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, Route43MahoganyGateOfficer, -1

Route43MahoganyGateOfficer:
	checkevent EVENT_CLEARED_ROCKET_HIDEOUT
	iftrue_jumptextfaceplayer Route43MahoganyGateOfficerRocketsClearedText
	jumpthistextfaceplayer

	text "Only people headed"
	line "up to Lake of Rage"

	para "have been through"
	line "here lately."
	done

Route43MahoganyGateOfficerRocketsClearedText:
	text "Nobody goes up to"
	line "Lake of Rage these"
	cont "days."
	done
