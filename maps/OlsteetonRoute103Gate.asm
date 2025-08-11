OlsteetonRoute103Gate_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  0,  4, OLSTEETON, 25
	warp_event  0,  5, OLSTEETON, 26
	; warp_event  9,  4, ROUTE_103, 3
	; warp_event  9,  5, ROUTE_103, 4


	def_coord_events

	def_bg_events

	def_object_events
	object_event  3,  3, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, OlsteetonRoute103GateOfficerScript, -1
	pokemon_event  6,  4, MR__MIME, SPRITEMOVEDATA_POKEMON, -1, PAL_NPC_PINK, OlsteetonGateMimeText, -1

OlsteetonRoute103GateOfficerScript:
	faceplayer
	opentext
	jumpopenedtext OlsteetonRoute103GateOfficerText1

OlsteetonRoute103GateOfficerText1:
	text "Nobody's getting"
	line "to Route 103"

	para "until these walls"
	line "come down."
	done


OlsteetonGateMimeText:
	text "HOOHOO"
	line "Mimeime"
	cont "MR. MIME"
	done