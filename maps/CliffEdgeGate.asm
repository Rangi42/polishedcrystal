CliffEdgeGate_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event 17, 19, CIANWOOD_CITY, 8
	warp_event  3, 19, ROUTE_47, 1

	def_coord_events

	def_bg_events
	bg_event 17,  6, BGEVENT_ITEM + BIG_PEARL, EVENT_CLIFF_EDGE_GATE_HIDDEN_BIG_PEARL

	def_object_events
	object_event 11, 16, SPRITE_RECEPTIONIST, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_COMMAND, jumptextfaceplayer, CliffEdgeGateReceptionistText, EVENT_YELLOW_FOREST_ROCKET_TAKEOVER
	object_event  3,  4, SPRITE_SCIENTIST, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, ProfOaksAide3Script, EVENT_YELLOW_FOREST_ROCKET_TAKEOVER
	object_event 17, 16, SPRITE_ROCKET, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerGruntM12, EVENT_CLEARED_YELLOW_FOREST

ProfOaksAide3Script:
	faceplayer
	opentext
	checkevent EVENT_GOT_MACHO_BRACE_FROM_PROF_OAKS_AIDE
	iftrue .Explain
	writetext ProfOaksAide3HiText
	waitbutton
	count_seen_caught
	checkcode VAR_DEXCAUGHT
	ifgreater 44, .HereYouGo
.UhOh
	jumpopenedtext ProfOaksAide3UhOhText

.HereYouGo
	writetext ProfOaksAide3HereYouGoText
	waitbutton
	verbosegiveitem MACHO_BRACE
	iffalse .NoRoom
	setevent EVENT_GOT_MACHO_BRACE_FROM_PROF_OAKS_AIDE
.Explain
	jumpopenedtext ProfOaksAide3ExplainText

.NoRoom
	jumpopenedtext ProfOaksAide3NoRoomText

GenericTrainerGruntM12:
	generictrainer GRUNTM, 12, EVENT_BEAT_ROCKET_GRUNTM_12, GruntM12SeenText, GruntM12BeatenText

	text "Yellow Forest is"
	line "full of rare"
	cont "#mon."

	para "We're nabbing them"
	line "all for ourselves!"
	done

CliffEdgeGateReceptionistText:
	text "Yellow Forest is"
	line "this way!"

	para "It's a popular"
	line "tourist sight!"
	done

ProfOaksAide3HiText:
	text "Hello there! I'm"
	line "Prof.Oak's aide."

	para "If you caught 45"
	line "kinds of #mon,"

	para "I'm supposed to"
	line "give you an item."

	para "So, <PLAYER>,"
	line "have you caught"

	para "at least 45 kinds"
	line "of #mon?"
	done

ProfOaksAide3UhOhText:
	text "Let's see…"
	line "Uh-oh! You've only"

	para "caught "
	deciram wTempPokedexCaughtCount, 1, 3
	text " kinds"
	line "of #mon."

	para "Come back and see"
	line "me when you catch"
	cont "45 kinds."
	done

ProfOaksAide3HereYouGoText:
	text "Let's see…"
	line "Great job! You've"

	para "caught "
	deciram wTempPokedexCaughtCount, 1, 3
	text " kinds"
	line "of #mon."

	para "Congratulations!"
	line "Here you go!"
	done

ProfOaksAide3NoRoomText:
	text "Oh! I see you"
	line "don't have any"
	cont "room for this."
	done

ProfOaksAide3ExplainText:
	text "That Macho Brace"
	line "helps a #mon"

	para "grow more from"
	line "battling, but"
	cont "slows it down."

	para "According to"
	line "Prof.Elm, some"
	cont "#mon evolve"

	para "when one stat has"
	line "grown enough."

	para "Use it to com-"
	line "plete the #dex!"
	done

GruntM12SeenText:
	text "You're curious"
	line "about our plans?"

	para "Beat me and I'll"
	line "tell you!"
	done

GruntM12BeatenText:
	text "You were supposed"
	line "to lose!"
	done

