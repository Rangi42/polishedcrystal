RuinsofAlphAerodactylChamber_MapScriptHeader:

.MapTriggers: db 1
	dw RuinsofAlphAerodactylChamberTrigger0

.MapCallbacks: db 1
	dbw MAPCALLBACK_TILES, UnknownScript_0x58db9

RuinsofAlphAerodactylChamber_MapEventHeader:

.Warps: db 5
	warp_def 9, 3, 4, RUINS_OF_ALPH_OUTSIDE
	warp_def 9, 4, 4, RUINS_OF_ALPH_OUTSIDE
	warp_def 3, 3, 8, RUINS_OF_ALPH_INNER_CHAMBER
	warp_def 3, 4, 9, RUINS_OF_ALPH_INNER_CHAMBER
	warp_def 0, 4, 1, RUINS_OF_ALPH_AERODACTYL_ITEM_ROOM

.XYTriggers: db 0

.Signposts: db 6
	signpost 3, 2, SIGNPOST_JUMPTEXT, UnknownText_0x58ec2
	signpost 3, 5, SIGNPOST_JUMPTEXT, UnknownText_0x58ec2
	signpost 2, 3, SIGNPOST_UP, MapRuinsofAlphAerodactylChamberSignpost2Script
	signpost 2, 4, SIGNPOST_UP, MapRuinsofAlphAerodactylChamberSignpost3Script
	signpost 0, 3, SIGNPOST_UP, MapRuinsofAlphAerodactylChamberSignpost4Script
	signpost 0, 4, SIGNPOST_UP, MapRuinsofAlphAerodactylChamberSignpost5Script

.PersonEvents: db 0

RuinsofAlphAerodactylChamberTrigger0:
	checkevent EVENT_WALL_OPENED_IN_AERODACTYL_CHAMBER
	iffalse .End
	priorityjump UnknownScript_0x58dd3
.End
	end

UnknownScript_0x58db9:
	checkevent EVENT_WALL_OPENED_IN_AERODACTYL_CHAMBER
	iftrue UnknownScript_0x58dc3
	changeblock 4, 0, $24
UnknownScript_0x58dc3:
	checkevent EVENT_SOLVED_AERODACTYL_PUZZLE
	iffalse UnknownScript_0x58dca
	return

UnknownScript_0x58dca:
	changeblock 2, 2, $1
	changeblock 4, 2, $2
	return

UnknownScript_0x58dd3:
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

MapRuinsofAlphAerodactylChamberSignpost2Script:
	refreshscreen
	writebyte $2
	special Special_UnownPuzzle
	closetext
	iftrue UnknownScript_0x58df7
	end

UnknownScript_0x58df7:
	setevent EVENT_RUINS_OF_ALPH_INNER_CHAMBER_TOURISTS
	setevent EVENT_SOLVED_AERODACTYL_PUZZLE
	setflag ENGINE_UNLOCKED_UNOWNS_3
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

MapRuinsofAlphAerodactylChamberSignpost3Script:
	unowntypeface
	showtext UnknownText_0x58ee7
	restoretypeface
	end

MapRuinsofAlphAerodactylChamberSignpost5Script:
	checkevent EVENT_WALL_OPENED_IN_AERODACTYL_CHAMBER
	iftrue_jumptext UnknownText_0x58ea2
MapRuinsofAlphAerodactylChamberSignpost4Script:
	opentext
	writetext UnknownText_0x58e4f
	writebyte $1
	special Special_DisplayUnownWords
	endtext

UnknownText_0x58e4f:
	text "Patterns appeared"
	line "on the walls…"
	done

UnknownText_0x58ea2:
	text "There's a big hole"
	line "in the wall!"
	done

UnknownText_0x58ec2:
	text "It's a replica of"
	line "an ancient #-"
	cont "mon."
	done

UnknownText_0x58ee7:
	text "This flying #-"
	line "mon attacked its"

	para "prey with saw-like"
	line "fangs."
	done
