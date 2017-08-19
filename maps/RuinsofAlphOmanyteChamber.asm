RuinsofAlphOmanyteChamber_MapScriptHeader:

.MapTriggers: db 1
	dw RuinsofAlphOmanyteChamberTrigger0

.MapCallbacks: db 1
	dbw MAPCALLBACK_TILES, UnknownScript_0x58bf8

RuinsofAlphOmanyteChamber_MapEventHeader:

.Warps: db 5
	warp_def 9, 3, 3, RUINS_OF_ALPH_OUTSIDE
	warp_def 9, 4, 3, RUINS_OF_ALPH_OUTSIDE
	warp_def 3, 3, 6, RUINS_OF_ALPH_INNER_CHAMBER
	warp_def 3, 4, 7, RUINS_OF_ALPH_INNER_CHAMBER
	warp_def 0, 4, 1, RUINS_OF_ALPH_OMANYTE_ITEM_ROOM

.XYTriggers: db 0

.Signposts: db 6
	signpost 3, 2, SIGNPOST_JUMPTEXT, UnknownText_0x58d01
	signpost 3, 5, SIGNPOST_JUMPTEXT, UnknownText_0x58d01
	signpost 2, 3, SIGNPOST_UP, MapRuinsofAlphOmanyteChamberSignpost2Script
	signpost 2, 4, SIGNPOST_UP, MapRuinsofAlphOmanyteChamberSignpost3Script
	signpost 0, 3, SIGNPOST_UP, MapRuinsofAlphOmanyteChamberSignpost4Script
	signpost 0, 4, SIGNPOST_UP, MapRuinsofAlphOmanyteChamberSignpost5Script

.PersonEvents: db 0

RuinsofAlphOmanyteChamberTrigger0:
	special SpecialOmanyteChamber
	checkevent EVENT_WALL_OPENED_IN_OMANYTE_CHAMBER
	iffalse .End
	priorityjump UnknownScript_0x58c12
.End
	end

UnknownScript_0x58bf8:
	checkevent EVENT_WALL_OPENED_IN_OMANYTE_CHAMBER
	iftrue UnknownScript_0x58c02
	changeblock 4, 0, $24
UnknownScript_0x58c02:
	checkevent EVENT_SOLVED_OMANYTE_PUZZLE
	iffalse UnknownScript_0x58c09
	return

UnknownScript_0x58c09:
	changeblock 2, 2, $1
	changeblock 4, 2, $2
	return

UnknownScript_0x58c12:
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

MapRuinsofAlphOmanyteChamberSignpost2Script:
	refreshscreen
	writebyte $1
	special Special_UnownPuzzle
	closetext
	iftrue UnknownScript_0x58c36
	end

UnknownScript_0x58c36:
	setevent EVENT_RUINS_OF_ALPH_INNER_CHAMBER_TOURISTS
	setevent EVENT_SOLVED_OMANYTE_PUZZLE
	setflag ENGINE_UNLOCKED_UNOWNS_2
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

MapRuinsofAlphOmanyteChamberSignpost3Script:
	unowntypeface
	showtext UnknownText_0x58d26
	restoretypeface
	end

MapRuinsofAlphOmanyteChamberSignpost5Script:
	checkevent EVENT_WALL_OPENED_IN_OMANYTE_CHAMBER
	iftrue_jumptext UnknownText_0x58ce1
MapRuinsofAlphOmanyteChamberSignpost4Script:
	opentext
	writetext UnknownText_0x58c8e
	writebyte $2
	special Special_DisplayUnownWords
	endtext

UnknownText_0x58c8e:
	text "Patterns appeared"
	line "on the walls…"
	done

UnknownText_0x58ce1:
	text "There's a big hole"
	line "in the wall!"
	done

UnknownText_0x58d01:
	text "It's a replica of"
	line "an ancient #-"
	cont "mon."
	done

UnknownText_0x58d26:
	text "This #mon"
	line "drifted in the"

	para "sea by twisting"
	line "its ten tentacles."
	done
