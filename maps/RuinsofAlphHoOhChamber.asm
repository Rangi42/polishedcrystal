RuinsofAlphHoOhChamber_MapScriptHeader:
	db 1 ; scene scripts
	scene_script RuinsofAlphHoOhChamberTrigger0

	db 1 ; callbacks
	callback MAPCALLBACK_TILES, UnknownScript_0x5857c

	db 5 ; warp events
	warp_event  3,  9, RUINS_OF_ALPH_OUTSIDE, 1
	warp_event  4,  9, RUINS_OF_ALPH_OUTSIDE, 1
	warp_event  3,  3, RUINS_OF_ALPH_INNER_CHAMBER, 2
	warp_event  4,  3, RUINS_OF_ALPH_INNER_CHAMBER, 3
	warp_event  4,  0, RUINS_OF_ALPH_HO_OH_ITEM_ROOM, 1

	db 0 ; coord events

	db 6 ; bg events
	bg_event  2,  3, SIGNPOST_JUMPTEXT, RuinsofAlphStatueText
	bg_event  5,  3, SIGNPOST_JUMPTEXT, RuinsofAlphStatueText
	bg_event  3,  2, SIGNPOST_UP, MapRuinsofAlphHoOhChamberSignpost2Script
	bg_event  4,  2, SIGNPOST_UP, MapRuinsofAlphHoOhChamberSignpost3Script
	bg_event  3,  0, SIGNPOST_UP, MapRuinsofAlphHoOhChamberSignpost4Script
	bg_event  4,  0, SIGNPOST_UP, MapRuinsofAlphHoOhChamberSignpost5Script

	db 0 ; object events

RuinsofAlphHoOhChamberTrigger0:
	special SpecialHoOhChamber
	checkevent EVENT_WALL_OPENED_IN_HO_OH_CHAMBER
	iffalse .End
	priorityjump UnknownScript_0x58596
.End
	end

UnknownScript_0x5857c:
	checkevent EVENT_WALL_OPENED_IN_HO_OH_CHAMBER
	iftrue UnknownScript_0x58586
	changeblock 4, 0, $24
UnknownScript_0x58586:
	checkevent EVENT_SOLVED_HO_OH_PUZZLE
	iffalse UnknownScript_0x5858d
	return

UnknownScript_0x5858d:
	changeblock 2, 2, $1
	changeblock 4, 2, $2
	return

UnknownScript_0x58596:
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

MapRuinsofAlphHoOhChamberSignpost2Script:
	refreshscreen
	writebyte $3
	special Special_UnownPuzzle
	closetext
	iftrue UnknownScript_0x585ba
	end

UnknownScript_0x585ba:
	setevent EVENT_RUINS_OF_ALPH_INNER_CHAMBER_TOURISTS
	setevent EVENT_SOLVED_HO_OH_PUZZLE
	setflag ENGINE_UNLOCKED_UNOWNS_4
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

MapRuinsofAlphHoOhChamberSignpost3Script:
	unowntypeface
	showtext UnknownText_0x586aa
	restoretypeface
	end

MapRuinsofAlphHoOhChamberSignpost5Script:
	checkevent EVENT_WALL_OPENED_IN_HO_OH_CHAMBER
	iftrue_jumptext UnknownText_0x58ea2
MapRuinsofAlphHoOhChamberSignpost4Script:
	opentext
	checkevent EVENT_RUINS_OF_ALPH_OUTSIDE_TOURIST_YOUNGSTERS
	iftrue .unsolved
	writetext UnusedText_0x58e70
	jump .unownwords
.unsolved
	writetext UnknownText_0x58e4f
.unownwords
	writebyte $3
	special Special_DisplayUnownWords
	endtext

UnknownText_0x586aa:
	text "A #mon that"
	line "flew gracefully on"

	para "rainbow-colored"
	line "wings."
	done
