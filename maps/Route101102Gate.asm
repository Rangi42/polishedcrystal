Route101102Gate_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  0,  4, ROUTE_101, 1
	warp_event  0,  5, ROUTE_101, 2
	warp_event  9,  4, ROUTE_102, 1
	warp_event  9,  5, ROUTE_102, 2

	def_coord_events

	def_bg_events

	def_object_events
	object_event  5,  2, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, Route101102GateOfficerScript, -1
	object_event  5,  5, SPRITE_YOUNGSTER, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, Route101102GateYoungsterText, -1
	pokemon_event 4,  2, DROWZEE, SPRITEMOVEDATA_POKEMON, -1, PAL_NPC_YELLOW, Route101102GateDrowzeeText, -1

Route101102GateOfficerScript:
	faceplayer
	opentext
	jumpopenedtext Route101102GateOfficerText1

Route101102GateOfficerText1:
	text "It's nice"
	line "they let us"

	para "bring our"
	line "#mon in to"
	cont "work."

	para "But I need to"
	line "bring a different"
	cont "#mon next time"

	para "I'm getting"
	line "sooooo sleeeepy!"
	done

Route101102GateYoungsterText:
	text "Plants are living"
	line "things too!"

	para "Some #mon"
	line "are even"
	cont "part plant!"
	done

Route101102GateDrowzeeText:
	text "Drowzee: zee?"
	done