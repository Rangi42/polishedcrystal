OlsteetonAbandonedMillOutside_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event 11,  5, OLSTEETON_ABANDONED_MILL, 1

	def_coord_events

	def_bg_events
	bg_event 12, 12, BGEVENT_JUMPTEXT, OlsteetonAbandonedMillOutsideSignText
	bg_event 10,  6, BGEVENT_JUMPTEXT, OlsteetonAbandonedMillOutsideDoorsClosedText

	def_object_events
	object_event  8, 12, SPRITE_SAILOR, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, OlsteetonAbandonedMillOutsideSailorText, -1
	object_event  9, 14, SPRITE_SAILBOAT, SPRITEMOVEDATA_SAILBOAT_BOTTOM, 0, 0, -1, 0, OBJECTTYPE_SCRIPT_SILENT, 0, OlsteetonAbandonedMillOutsideSailboatScript, -1
	object_const_def


OlsteetonAbandonedMillOutsideSailboatScript:
	; checkevent EVENT_BOAT_PERMISSION
	checkevent EVENT_GOT_A_POKEMON_FROM_ELM
	iftruefwd Olsteeton_MillBoatQuestion
	jumptext OlsteetonAbandonedMillOutsideSailboatText

Olsteeton_MillBoatQuestion:
	opentext
	writetext BoatMillText_Ask
	yesorno
	iftruefwd Olsteeton_MillBoatRide
	endtext

Olsteeton_MillBoatRide:
	warp OLSTEETON, $25, $3
	end
BoatMillText_Ask:
	text "Take the boat"
	line "to Olsteeton?"
	done

OlsteetonAbandonedMillOutsideSignText:
	text "Olstee Mill "

	para "There is a sign "
	line "nailed below..."
	
	para "PERMANENTLY"
	line "CLOSED"
	done

OlsteetonAbandonedMillOutsideSailorText:
	text "Heh, I ain't"
	line "gettin involved"

	para "any of Rusty's"
	line "crew drama."

	para "You just get back"
	line "in the boat"

	para "when you're"
	line "done here, ok?"
	done

OlsteetonAbandonedMillOutsideDoorsClosedText:
	text "NO GYM"
	line "TRAITORS ALLOWED"
	done

OlsteetonAbandonedMillOutsideSailboatText:
	text "It's a sailboat"
	line "named Magic Harp."
	done