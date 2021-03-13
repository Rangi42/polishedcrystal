Route38EcruteakGate_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  0,  4, ROUTE_38, 1
	warp_event  0,  5, ROUTE_38, 2
	warp_event  9,  4, ECRUTEAK_CITY, 14
	warp_event  9,  5, ECRUTEAK_CITY, 15

	def_coord_events

	def_bg_events

	def_object_events
	object_event  5,  2, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_COMMAND, jumptextfaceplayer, Route38EcruteakGateOfficerText, -1
	object_event  8,  3, SPRITE_SCIENTIST, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, ProfOaksAide2Script, -1

ProfOaksAide2Script:
	faceplayer
	opentext
	checkevent EVENT_GOT_EXP_SHARE_FROM_PROF_OAKS_AIDE
	iftrue .Explain
	writetext ProfOaksAide2HiText
	waitbutton
	countseencaught
	readvar VAR_DEXCAUGHT
	ifgreater 29, .HereYouGo
.UhOh
	jumpopenedtext ProfOaksAide2UhOhText

.HereYouGo
	writetext ProfOaksAide2HereYouGoText
	waitbutton
	verbosegiveitem EXP_SHARE
	iffalse .NoRoom
	setevent EVENT_GOT_EXP_SHARE_FROM_PROF_OAKS_AIDE
.Explain
	jumpopenedtext ProfOaksAide2ExplainText

.NoRoom
	jumpopenedtext ProfOaksAide2NoRoomText

Route38EcruteakGateOfficerText:
	text "Where did you say"
	line "you're from?"

	para "New Bark Town?"

	para "Prof.Elm lives"
	line "over there, right?"

	para "You've come a long"
	line "way to get here."
	done

ProfOaksAide2HiText:
	text "Hello there! I'm"
	line "Prof.Oak's aide."

	para "If you caught 30"
	line "kinds of #mon,"

	para "I'm supposed to"
	line "give you an item."

	para "So, <PLAYER>,"
	line "have you caught"

	para "at least 30 kinds"
	line "of #mon?"
	done

ProfOaksAide2UhOhText:
	text "Let's see…"
	line "Uh-oh! You've only"

	para "caught "
	text_decimal wTempPokedexCaughtCount, 1, 3
	text " kinds"
	line "of #mon."

	para "Come back and see"
	line "me when you catch"
	cont "30 kinds."
	done

ProfOaksAide2HereYouGoText:
	text "Let's see…"
	line "Great job! You've"

	para "caught "
	text_decimal wTempPokedexCaughtCount, 1, 3
	text " kinds"
	line "of #mon."

	para "Congratulations!"
	line "Here you go!"
	done

ProfOaksAide2NoRoomText:
	text "Oh! I see you"
	line "don't have any"
	cont "room for this."
	done

ProfOaksAide2ExplainText:
	text "That Exp.Share"
	line "helps a #mon"

	para "gain experience"
	line "without even"
	cont "battling."

	para "Use it to com-"
	line "plete the #dex!"
	done
