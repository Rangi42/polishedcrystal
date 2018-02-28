RuinsofAlphAerodactylChamber_MapScriptHeader:
	db 1 ; scene scripts
	scene_script RuinsofAlphAerodactylChamberTrigger0

	db 1 ; callbacks
	callback MAPCALLBACK_TILES, UnknownScript_0x58db9

	db 5 ; warp events
	warp_event  3,  9, RUINS_OF_ALPH_OUTSIDE, 4
	warp_event  4,  9, RUINS_OF_ALPH_OUTSIDE, 4
	warp_event  3,  3, RUINS_OF_ALPH_INNER_CHAMBER, 8
	warp_event  4,  3, RUINS_OF_ALPH_INNER_CHAMBER, 9
	warp_event  4,  0, RUINS_OF_ALPH_AERODACTYL_ITEM_ROOM, 1

	db 0 ; coord events

	db 6 ; bg events
	bg_event  2,  3, SIGNPOST_JUMPTEXT, RuinsofAlphStatueText
	bg_event  5,  3, SIGNPOST_JUMPTEXT, RuinsofAlphStatueText
	bg_event  3,  2, SIGNPOST_UP, MapRuinsofAlphAerodactylChamberSignpost2Script
	bg_event  4,  2, SIGNPOST_UP, MapRuinsofAlphAerodactylChamberSignpost3Script
	bg_event  3,  0, SIGNPOST_UP, MapRuinsofAlphAerodactylChamberSignpost4Script
	bg_event  4,  0, SIGNPOST_UP, MapRuinsofAlphAerodactylChamberSignpost5Script

	db 0 ; object events

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
	setscene $1
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
	setmapscene RUINS_OF_ALPH_INNER_CHAMBER, $1
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
	checkevent EVENT_RUINS_OF_ALPH_OUTSIDE_TOURIST_YOUNGSTERS
	iftrue .unsolved
	writetext UnusedText_0x58e70
	jump .unownwords
.unsolved
	writetext UnknownText_0x58e4f
.unownwords
	writebyte $1
	special Special_DisplayUnownWords
	endtext

UnknownText_0x58e4f:
	text "Patterns appeared"
	line "on the walls…"
	done

UnusedText_0x58e70:
	text "It's Unown text!"
	done

UnknownText_0x58ea2:
	text "There's a big hole"
	line "in the wall!"
	done

UnknownText_0x58ee7:
	text "This flying #-"
	line "mon attacked its"

	para "prey with saw-like"
	line "fangs."
	done
