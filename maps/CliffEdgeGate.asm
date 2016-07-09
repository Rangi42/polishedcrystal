const_value set 2
	const CLIFFEDGEGATE_RECEPTIONIST
	const CLIFFEDGEGATE_SCIENTIST

CliffEdgeGate_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

CliffEdgeGateReceptionistScript:
	jumptextfaceplayer CliffEdgeGateReceptionistText

ProfOaksAide2Script:
	faceplayer
	opentext
	checkevent EVENT_GOT_LUCKY_EGG_FROM_PROF_OAKS_AIDE
	iftrue .Explain
	writetext ProfOaksAide2HiText
	waitbutton
	count_caught
	checkcode VAR_DEXCAUGHT
	if_greater_than 49, .HereYouGo
.UhOh
	writetext ProfOaksAide2UhOhText
	waitbutton
	closetext
	end

.HereYouGo
	writetext ProfOaksAide2HereYouGoText
	waitbutton
	giveitem LUCKY_EGG
	waitsfx
	iffalse .NoRoom
	writetext ProfOaksAide2LuckyEggText
	playsound SFX_ITEM
	waitsfx
	itemnotify
	setevent EVENT_GOT_LUCKY_EGG_FROM_PROF_OAKS_AIDE
.Explain
	writetext ProfOaksAide2ExplainText
	waitbutton
	closetext
	end

.NoRoom
	writetext ProfOaksAide2NoRoomText
	waitbutton
	closetext
	end

CliffEdgeGateHiddenBigPearl:
	dwb EVENT_CLIFF_EDGE_GATE_HIDDEN_BIG_PEARL, BIG_PEARL

CliffEdgeGateReceptionistText:
	text "Yellow Forest is"
	line "this way!"

	para "It's a popular"
	line "tourist sight!"
	done

ProfOaksAide2HiText:
	text "Hello there! I'm"
	line "Prof.Oak's aide."

	para "If you caught 50"
	line "kinds of #mon,"

	para "I'm supposed to"
	line "give you an item."

	para "So, <PLAYER>,"
	line "have you caught"

	para "at least 50 kinds"
	line "of #mon?"
	done

ProfOaksAide2UhOhText:
	text "Let's see…"
	line "Uh-oh! You've only"

	para "caught @"
	deciram wd002, 1, 3
	text " kinds"
	line "of #mon."

	para "Come back and see"
	line "me when you catch"
	cont "50 kinds."
	done

ProfOaksAide2HereYouGoText:
	text "Let's see…"
	line "Great job! You've"

	para "caught @"
	deciram wd002, 1, 3
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

ProfOaksAide2LuckyEggText:
	text "<PLAYER> received"
	line "Lucky Egg."
	done

ProfOaksAide2ExplainText:
	text "That Lucky Egg"
	line "helps a #mon"

	para "gain experience"
	line "when it's held."

	para "Use it to com-"
	line "plete the #dex!"
	done

CliffEdgeGate_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 2
	warp_def $13, $11, 8, CIANWOOD_CITY
	warp_def $13, $3, 1, ROUTE_47

.XYTriggers:
	db 0

.Signposts:
	db 1
	signpost 6, 17, SIGNPOST_ITEM, CliffEdgeGateHiddenBigPearl

.PersonEvents:
	db 2
	person_event SPRITE_RECEPTIONIST, 16, 11, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_SCRIPT, 0, CliffEdgeGateReceptionistScript, -1
	person_event SPRITE_SCIENTIST, 4, 3, SPRITEMOVEDATA_STANDING_DOWN, 0, 1, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, ProfOaksAide2Script, -1
