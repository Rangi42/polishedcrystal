const_value set 2
	const ILEXFORESTAZALEAGATE_OFFICER
	const ILEXFORESTAZALEAGATE_GRANNY
	const ILEXFORESTAZALEAGATE_SCIENTIST

IlexForestAzaleaGate_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

OfficerScript_0x62c7a:
	jumptextfaceplayer UnknownText_0x62c80

GrannyScript_0x62c7d:
	jumptextfaceplayer UnknownText_0x62cb0

ProfOaksAide1Script:
	faceplayer
	opentext
	checkevent EVENT_GOT_NET_BALLS_FROM_PROF_OAKS_AIDE
	iftrue .Explain
	writetext ProfOaksAide1HiText
	waitbutton
	count_caught
	checkcode VAR_DEXCAUGHT
	if_greater_than 14, .HereYouGo
.UhOh
	writetext ProfOaksAide1UhOhText
	waitbutton
	closetext
	end

.HereYouGo
	writetext ProfOaksAide1HereYouGoText
	waitbutton
	giveitem NET_BALL, 5
	waitsfx
	iffalse .NoRoom
	writetext ProfOaksAide1NetBallText
	playsound SFX_ITEM
	waitsfx
	itemnotify
	setevent EVENT_GOT_NET_BALLS_FROM_PROF_OAKS_AIDE
.Explain
	writetext ProfOaksAide1ExplainText
	waitbutton
	closetext
	end

.NoRoom
	writetext ProfOaksAide1NoRoomText
	waitbutton
	closetext
	end

UnknownText_0x62c80:
	text "Ilex Forest is"
	line "big. Be careful!"
	cont "Don't get lost."
	done

UnknownText_0x62cb0:
	text "The Forest is"
	line "watched over by"
	cont "its protector."

	para "Stay out of"
	line "mischief!"
	done

ProfOaksAide1HiText:
	text "Hello there! I'm"
	line "Prof.Oak's aide."

	para "If you caught 15"
	line "kinds of #mon,"

	para "I'm supposed to"
	line "give you an item."

	para "So, <PLAYER>,"
	line "have you caught"

	para "at least 15 kinds"
	line "of #mon?"
	done

ProfOaksAide1UhOhText:
	text "Let's see…"
	line "Uh-oh! You've only"

	para "caught @"
	deciram wd002, 1, 3
	text " kinds"
	line "of #mon."

	para "Come back and see"
	line "me when you catch"
	cont "15 kinds."
	done

ProfOaksAide1HereYouGoText:
	text "Let's see…"
	line "Great job! You've"

	para "caught @"
	deciram wd002, 1, 3
	text " kinds"
	line "of #mon."

	para "Congratulations!"
	line "Here you go!"
	done

ProfOaksAide1NoRoomText:
	text "Oh! I see you"
	line "don't have any"
	cont "room for this."
	done

ProfOaksAide1NetBallText:
	text "<PLAYER> received"
	line "5 Net Balls."
	done

ProfOaksAide1ExplainText:
	text "Those Net Balls"
	line "are like Apricorn"

	para "Balls, but they"
	line "were developed by"
	cont "Silph in Kanto."

	para "They work best"
	line "on Water- and"
	cont "Bug-type #mon."

	para "Use them to com-"
	line "plete the #dex!"
	done

IlexForestAzaleaGate_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 4
	warp_def $4, $0, 2, ILEX_FOREST
	warp_def $5, $0, 3, ILEX_FOREST
	warp_def $4, $9, 7, AZALEA_TOWN
	warp_def $5, $9, 8, AZALEA_TOWN

.XYTriggers:
	db 0

.Signposts:
	db 0

.PersonEvents:
	db 3
	person_event SPRITE_OFFICER, 2, 5, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, OfficerScript_0x62c7a, -1
	person_event SPRITE_GRANNY, 3, 1, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_SCRIPT, 0, GrannyScript_0x62c7d, -1
	person_event SPRITE_SCIENTIST, 6, 8, SPRITEMOVEDATA_STANDING_UP, 0, 1, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, ProfOaksAide1Script, -1
