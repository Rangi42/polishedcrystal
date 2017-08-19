RuinsofAlphKabutoChamber_MapScriptHeader:

.MapTriggers: db 1
	dw RuinsofAlphKabutoChamberTrigger0

.MapCallbacks: db 1
	dbw MAPCALLBACK_TILES, UnknownScript_0x58737

RuinsofAlphKabutoChamber_MapEventHeader:

.Warps: db 5
	warp_def 9, 3, 2, RUINS_OF_ALPH_OUTSIDE
	warp_def 9, 4, 2, RUINS_OF_ALPH_OUTSIDE
	warp_def 3, 3, 4, RUINS_OF_ALPH_INNER_CHAMBER
	warp_def 3, 4, 5, RUINS_OF_ALPH_INNER_CHAMBER
	warp_def 0, 4, 1, RUINS_OF_ALPH_KABUTO_ITEM_ROOM

.XYTriggers: db 0

.Signposts: db 6
	signpost 3, 2, SIGNPOST_JUMPTEXT, UnknownText_0x58b1a
	signpost 3, 5, SIGNPOST_JUMPTEXT, UnknownText_0x58b1a
	signpost 2, 3, SIGNPOST_UP, MapRuinsofAlphKabutoChamberSignpost2Script
	signpost 2, 4, SIGNPOST_UP, MapRuinsofAlphKabutoChamberSignpost3Script
	signpost 0, 3, SIGNPOST_UP, MapRuinsofAlphKabutoChamberSignpost4Script
	signpost 0, 4, SIGNPOST_UP, MapRuinsofAlphKabutoChamberSignpost5Script

.PersonEvents: db 2
	person_event SPRITE_RECEPTIONIST, 5, 5, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x58800, EVENT_RUINS_OF_ALPH_KABUTO_CHAMBER_RECEPTIONIST
	person_event SPRITE_SCIENTIST, 1, 3, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, ScientistScript_0x587a8, -1

RuinsofAlphKabutoChamberTrigger0:
	checkevent EVENT_WALL_OPENED_IN_KABUTO_CHAMBER
	iffalse .End
	priorityjump UnknownScript_0x58751
.End
	end

UnknownScript_0x58737:
	checkevent EVENT_WALL_OPENED_IN_KABUTO_CHAMBER
	iftrue UnknownScript_0x58741
	changeblock 4, 0, $24
UnknownScript_0x58741:
	checkevent EVENT_SOLVED_KABUTO_PUZZLE
	iffalse UnknownScript_0x58748
	return

UnknownScript_0x58748:
	changeblock 2, 2, $1
	changeblock 4, 2, $2
	return

UnknownScript_0x58751:
	pause 30
	earthquake 30
	showemote EMOTE_SHOCK, PLAYER, 20
	pause 30
	playsound SFX_STRENGTH
	changeblock 4, 0, $25
	reloadmappart
	earthquake 50
	dotrigger $1
	endtext

MapRuinsofAlphKabutoChamberSignpost2Script:
	refreshscreen
	writebyte $0
	special Special_UnownPuzzle
	closetext
	iftrue UnknownScript_0x58778
	end

UnknownScript_0x58778:
	setevent EVENT_RUINS_OF_ALPH_INNER_CHAMBER_TOURISTS
	setevent EVENT_SOLVED_KABUTO_PUZZLE
	setflag ENGINE_UNLOCKED_UNOWNS_1
	setevent EVENT_RUINS_OF_ALPH_KABUTO_CHAMBER_RECEPTIONIST
	domaptrigger RUINS_OF_ALPH_INNER_CHAMBER, $1
	earthquake 30
	showemote EMOTE_SHOCK, PLAYER, 15
	changeblock 2, 2, $14
	changeblock 4, 2, $15
	reloadmappart
	playsound SFX_STRENGTH
	earthquake 80
	applyonemovement PLAYER, skyfall_top
	playsound SFX_KINESIS
	waitsfx
	pause 20
	warpcheck
	end

ScientistScript_0x587a8:
	checkcode VAR_UNOWNCOUNT
	if_equal NUM_UNOWN, UnknownScript_0x587cf
	checkevent EVENT_WALL_OPENED_IN_KABUTO_CHAMBER
	iftrue_jumptextfaceplayer UnknownText_0x5897c
	faceplayer
	opentext
	checkevent EVENT_SOLVED_KABUTO_PUZZLE
	iffalse UnknownScript_0x587c0
	writetext UnknownText_0x589b8
	buttonsound
UnknownScript_0x587c0:
	writetext UnknownText_0x588f5
	waitbutton
	closetext
	spriteface LAST_TALKED, UP
	end

UnknownScript_0x587cf:
	jumptextfaceplayer UnknownText_0x594cb

MapRuinsofAlphKabutoChamberSignpost3Script:
	unowntypeface
	showtext UnknownText_0x58b3f
	restoretypeface
	end

MapRuinsofAlphKabutoChamberSignpost5Script:
	checkevent EVENT_WALL_OPENED_IN_KABUTO_CHAMBER
	iftrue_jumptext UnknownText_0x58afa
MapRuinsofAlphKabutoChamberSignpost4Script:
	opentext
	writetext UnknownText_0x58aa7
	writebyte $0
	special Special_DisplayUnownWords
	endtext

UnknownText_0x58800:
	text "Welcome to this"
	line "chamber."

	para "There are sliding"
	line "panels that depict"

	para "a #mon drawn by"
	line "the ancients."

	para "Slide the panels"
	line "around to form the"
	cont "picture."

	para "To the right is a"
	line "description of the"
	cont "#mon."

	para "Scientists in the"
	line "back are examining"

	para "some newly found"
	line "patterns."
	done

UnknownText_0x588f5:
	text "Recently, strange,"
	line "cryptic patterns"
	cont "have appeared."

	para "It's odd. They"
	line "weren't here a"
	cont "little while ago…"

	para "You should take a"
	line "look at the walls."
	done

UnknownText_0x5897c:
	text "Ah! Here's another"
	line "huge hole!"

	para "It's big enough to"
	line "go through!"
	done

UnknownText_0x589b8:
	text "That tremor was"
	line "pretty scary!"

	para "But I'm more"
	line "concerned about"
	cont "this wall here…"
	done

UnknownText_0x58aa7:
	text "Patterns appeared"
	line "on the walls…"
	done

UnknownText_0x58afa:
	text "There's a big hole"
	line "in the wall!"
	done

UnknownText_0x58b1a:
	text "It's a replica of"
	line "an ancient #-"
	cont "mon."
	done

UnknownText_0x58b3f:
	text "A #mon that hid"
	line "on the sea floor."

	para "Eyes on its back"
	line "scanned the area."
	done
