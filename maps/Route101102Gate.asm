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

Route101102GateOfficerScript:
	faceplayer
	opentext
	jumpopenedtext Route101102GateOfficerText1

Route101102GateOfficerText1:
	text "Gosh, I need"
	line "some dialogue,"

	para "like really"
	line "badly."
	done

Route101102GateYoungsterText:
	text "Plants are living"
	line "things too!"

	para "Plants can't"
	line "write dialogue"
	cont "though!"
	done
