Route102OlsteetonGate_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  0,  4, ROUTE_102, 3
	warp_event  0,  5, ROUTE_102, 4
	; warp_event  0,  4, OLSTEETON, 1
	; warp_event  0,  5, OLSTEETON, 2

	def_coord_events

	def_bg_events

	def_object_events
	object_event  5,  2, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, Route102OlsteetonGateOfficerScript, -1
	pokemon_event  4,  2, NOCTOWL, SPRITEMOVEDATA_POKEMON, -1, PAL_NPC_BROWN, OlsteetonGateNoctowlText, -1
	object_event  8,  6, SPRITE_GIOVANNI, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, Route102OlsteetonGateYoungsterText, -1

Route102OlsteetonGateOfficerScript:
	faceplayer
	opentext
	jumpopenedtext Route102OlsteetonGateOfficerText1

Route102OlsteetonGateOfficerText1:
	text "Watch out for"
	line "that guy..."

	para "He's not tech-"
	line "nically doing"
	cont "anything wrong"
	cont "though..."
	done

Route102OlsteetonGateYoungsterText:
	text "This is good news"
	line "...we can be bees"

	para "you'll be a bee"
	line "you'll live for"
	cont "30 years..."
	done

OlsteetonGateNoctowlText:
	text "Hoooo?"
	done