OlsteetonForestGate_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  4,  0, OLSTEETON, 20
	warp_event  5,  0, OLSTEETON, 21
	warp_event  4,  7, NATIONAL_FOREST_1, 1
	warp_event  5,  7, NATIONAL_FOREST_1, 1

	def_coord_events

	def_bg_events

	def_object_events
	object_event  0,  4, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, OlsteetonForestGuardScript, -1

OlsteetonForestGuardScript:
	jumpthistextfaceplayer

	text "Welcome to Saffron"
	line "City, home of the"
	cont "Magnet Train!"

	para "…That's what I'd"
	line "normally say, but"

	para "the Magnet Train"
	line "isn't running now."

	para "It's not getting"
	line "any electricity"

	para "because there's"
	line "something wrong"

	para "with the Power"
	line "Plant."
	done
