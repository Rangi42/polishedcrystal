ScaryCaveShipwreck_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  5,  9, SCARY_CAVE_1F, 5

	def_coord_events

	def_bg_events
	bg_event  2,  4, BGEVENT_JUMPTEXT, ScaryCaveShipwreckText
	bg_event  3,  4, BGEVENT_JUMPTEXT, ScaryCaveShipwreckText
	bg_event  4,  4, BGEVENT_JUMPTEXT, ScaryCaveShipwreckText
	bg_event  5,  4, BGEVENT_JUMPTEXT, ScaryCaveShipwreckText
	bg_event  6,  4, BGEVENT_JUMPTEXT, ScaryCaveShipwreckText
	bg_event  7,  4, BGEVENT_JUMPTEXT, ScaryCaveShipwreckText
	bg_event  8,  4, BGEVENT_JUMPTEXT, ScaryCaveShipwreckText
	bg_event  9,  4, BGEVENT_JUMPTEXT, ScaryCaveShipwreckText

	def_object_events
	itemball_event  7,  8, RARE_BONE, 1, EVENT_SCARY_CAVE_SHIPWRECK_RARE_BONE

ScaryCaveShipwreckText:
	text "It's a rusty,"
	line "broken shipwreck."
	done
