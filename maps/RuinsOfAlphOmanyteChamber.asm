RuinsOfAlphOmanyteChamber_MapScriptHeader:
	def_scene_scripts
	scene_script RuinsofAlphOmanyteChamberTrigger0

	def_callbacks
	callback MAPCALLBACK_TILES, RuinsofAlphOmanyteChamberHiddenDoorsCallback

	def_warp_events
	warp_event  3,  9, RUINS_OF_ALPH_OUTSIDE, 3
	warp_event  4,  9, RUINS_OF_ALPH_OUTSIDE, 3
	warp_event  3,  3, RUINS_OF_ALPH_INNER_CHAMBER, 6
	warp_event  4,  3, RUINS_OF_ALPH_INNER_CHAMBER, 7
	warp_event  4,  0, RUINS_OF_ALPH_OMANYTE_ITEM_ROOM, 1

	def_coord_events

	def_bg_events
	bg_event  2,  3, BGEVENT_JUMPTEXT, RuinsofAlphStatueText
	bg_event  5,  3, BGEVENT_JUMPTEXT, RuinsofAlphStatueText
	bg_event  3,  2, BGEVENT_UP, MapRuinsofAlphOmanyteChamberSignpost2Script
	bg_event  4,  2, BGEVENT_UP, MapRuinsofAlphOmanyteChamberSignpost3Script
	bg_event  3,  0, BGEVENT_UP, MapRuinsofAlphOmanyteChamberSignpost4Script
	bg_event  4,  0, BGEVENT_UP, MapRuinsofAlphOmanyteChamberSignpost5Script

	def_object_events

RuinsofAlphOmanyteChamberTrigger0:
	special SpecialOmanyteChamber
	checkevent EVENT_WALL_OPENED_IN_OMANYTE_CHAMBER
	iffalse .End
	sdefer RuinsOfAlphOmanyteChamberWallOpenScript
.End
	end

RuinsofAlphOmanyteChamberHiddenDoorsCallback:
	checkevent EVENT_WALL_OPENED_IN_OMANYTE_CHAMBER
	iftrue .WallOpen
	changeblock 4, 0, $24
.WallOpen:
	checkevent EVENT_SOLVED_OMANYTE_PUZZLE
	iffalse .FloorClosed
	endcallback

.FloorClosed:
	changeblock 2, 2, $1
	changeblock 4, 2, $2
	endcallback

RuinsOfAlphOmanyteChamberWallOpenScript:
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

MapRuinsofAlphOmanyteChamberSignpost2Script:
	refreshscreen
	setval $1
	special Special_UnownPuzzle
	closetext
	iftrue .PuzzleComplete
	end

.PuzzleComplete:
	setevent EVENT_RUINS_OF_ALPH_INNER_CHAMBER_TOURISTS
	setevent EVENT_SOLVED_OMANYTE_PUZZLE
	setflag ENGINE_UNLOCKED_UNOWNS_K_TO_Q
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

MapRuinsofAlphOmanyteChamberSignpost3Script:
	unowntypeface
	showtext RuinsOfAlphOmanyteChamberDescriptionText
	restoretypeface
	special MapCallbackSprites_LoadUsedSpritesGFX
	end

MapRuinsofAlphOmanyteChamberSignpost5Script:
	checkevent EVENT_WALL_OPENED_IN_OMANYTE_CHAMBER
	iftrue_jumptext RuinsOfAlphAerodactylChamberWallHoleText
MapRuinsofAlphOmanyteChamberSignpost4Script:
	opentext
	checkevent EVENT_RUINS_OF_ALPH_OUTSIDE_TOURIST_YOUNGSTERS
	iftrue .unsolved
	writetext RuinsOfAlphChambersItsUnownText
	sjump .unownwords
.unsolved
	writetext RuinsOfAlphAerodactylChamberWallPatternLeftText
.unownwords
	setval $2
	special Special_DisplayUnownWords
	endtext

RuinsOfAlphOmanyteChamberDescriptionText:
	text "This #mon"
	line "drifted in the"

	para "sea by twisting"
	line "its ten tentacles."
	done
