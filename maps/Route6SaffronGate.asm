Route6SaffronGate_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  4,  0, SAFFRON_CITY, 12
	warp_event  5,  0, SAFFRON_CITY, 13
	warp_event  4,  7, ROUTE_6, 2
	warp_event  5,  7, ROUTE_6, 2

	def_coord_events

	def_bg_events

	def_object_events
	object_event  0,  4, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, Route6SaffronGuardScript, -1

Route6SaffronGuardScript:
	checkevent EVENT_RESTORED_POWER_TO_KANTO
	iftrue_jumptextfaceplayer Route6SaffronGuardMagnetTrainText
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

Route6SaffronGuardMagnetTrainText:
	text "The Magnet Train"
	line "is the most famous"

	para "thing about Saf-"
	line "fron."
	done
