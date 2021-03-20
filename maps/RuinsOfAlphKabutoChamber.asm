RuinsOfAlphKabutoChamber_MapScriptHeader:
	def_scene_scripts
	scene_script RuinsofAlphKabutoChamberTrigger0

	def_callbacks
	callback MAPCALLBACK_TILES, RuinsofAlphKabutoChamberHiddenDoorsCallback

	def_warp_events
	warp_event  3,  9, RUINS_OF_ALPH_OUTSIDE, 2
	warp_event  4,  9, RUINS_OF_ALPH_OUTSIDE, 2
	warp_event  3,  3, RUINS_OF_ALPH_INNER_CHAMBER, 4
	warp_event  4,  3, RUINS_OF_ALPH_INNER_CHAMBER, 5
	warp_event  4,  0, RUINS_OF_ALPH_KABUTO_ITEM_ROOM, 1

	def_coord_events

	def_bg_events
	bg_event  2,  3, BGEVENT_JUMPTEXT, RuinsofAlphStatueText
	bg_event  5,  3, BGEVENT_JUMPTEXT, RuinsofAlphStatueText
	bg_event  3,  2, BGEVENT_UP, MapRuinsofAlphKabutoChamberSignpost2Script
	bg_event  4,  2, BGEVENT_UP, MapRuinsofAlphKabutoChamberSignpost3Script
	bg_event  3,  0, BGEVENT_UP, MapRuinsofAlphKabutoChamberSignpost4Script
	bg_event  4,  0, BGEVENT_UP, MapRuinsofAlphKabutoChamberSignpost5Script

	def_object_events
	object_event  5,  5, SPRITE_RECEPTIONIST, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_COMMAND, jumptextfaceplayer, RuinsOfAlphKabutoChamberReceptionistText, EVENT_RUINS_OF_ALPH_KABUTO_CHAMBER_RECEPTIONIST
	object_event  3,  1, SPRITE_SCIENTIST, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_SCRIPT, 0, RuinsOfAlphKabutoChamberScientistScript, -1

RuinsofAlphKabutoChamberTrigger0:
	checkevent EVENT_WALL_OPENED_IN_KABUTO_CHAMBER
	iffalse .End
	prioritysjump RuinsofAlphKabutoChamberWallOpenScript
.End
	end

RuinsofAlphKabutoChamberHiddenDoorsCallback:
	checkevent EVENT_WALL_OPENED_IN_KABUTO_CHAMBER
	iftrue .WallOpen
	changeblock 4, 0, $24
.WallOpen:
	checkevent EVENT_SOLVED_KABUTO_PUZZLE
	iffalse .FloorClosed
	endcallback

.FloorClosed:
	changeblock 2, 2, $1
	changeblock 4, 2, $2
	endcallback

RuinsofAlphKabutoChamberWallOpenScript:
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

MapRuinsofAlphKabutoChamberSignpost2Script:
	refreshscreen
	setval $0
	special Special_UnownPuzzle
	closetext
	iftrue .PuzzleComplete
	end

.PuzzleComplete:
	setevent EVENT_RUINS_OF_ALPH_INNER_CHAMBER_TOURISTS
	setevent EVENT_SOLVED_KABUTO_PUZZLE
	setflag ENGINE_UNLOCKED_UNOWNS_A_TO_J
	setevent EVENT_RUINS_OF_ALPH_KABUTO_CHAMBER_RECEPTIONIST
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

RuinsOfAlphKabutoChamberScientistScript:
	readvar VAR_UNOWNCOUNT
	ifequal NUM_UNOWN, .AllUnownCaught
	checkevent EVENT_WALL_OPENED_IN_KABUTO_CHAMBER
	iftrue_jumptextfaceplayer RuinsOfAlphKabutoChamberScientistHoleText
	faceplayer
	opentext
	checkevent EVENT_SOLVED_KABUTO_PUZZLE
	iffalse .PuzzleIncomplete
	writetext RuinsOfAlphKabutoChamberScientistTremorText
	promptbutton
.PuzzleIncomplete:
	writetext RuinsOfAlphKabutoChamberScientistCrypticText
	waitbutton
	closetext
	turnobject LAST_TALKED, UP
	end

.AllUnownCaught:
	jumptextfaceplayer RuinsOfAlphResearchCenterScientist1Text_GotAllUnown

MapRuinsofAlphKabutoChamberSignpost3Script:
	unowntypeface
	showtext RuinsOfAlphKabutoChamberDescriptionText
	restoretypeface
	special MapCallbackSprites_LoadUsedSpritesGFX
	end

MapRuinsofAlphKabutoChamberSignpost5Script:
	checkevent EVENT_WALL_OPENED_IN_KABUTO_CHAMBER
	iftrue_jumptext RuinsOfAlphAerodactylChamberWallHoleText
MapRuinsofAlphKabutoChamberSignpost4Script:
	opentext
	checkevent EVENT_RUINS_OF_ALPH_OUTSIDE_TOURIST_YOUNGSTERS
	iftrue .unsolved
	writetext RuinsOfAlphChambersItsUnownText
	sjump .unownwords
.unsolved
	writetext RuinsOfAlphAerodactylChamberWallPatternLeftText
.unownwords
	setval $0
	special Special_DisplayUnownWords
	endtext

RuinsOfAlphKabutoChamberReceptionistText:
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

RuinsOfAlphKabutoChamberScientistCrypticText:
	text "Recently, strange,"
	line "cryptic patterns"
	cont "have appeared."

	para "It's odd. They"
	line "weren't here a"
	cont "little while ago…"

	para "You should take a"
	line "look at the walls."
	done

RuinsOfAlphKabutoChamberScientistHoleText:
	text "Ah! Here's another"
	line "huge hole!"

	para "It's big enough to"
	line "go through!"
	done

RuinsOfAlphKabutoChamberScientistTremorText:
	text "That tremor was"
	line "pretty scary!"

	para "But I'm more"
	line "concerned about"
	cont "this wall here…"
	done

RuinsOfAlphKabutoChamberDescriptionText:
	text "A #mon that hid"
	line "on the sea floor."

	para "Eyes on its back"
	line "scanned the area."
	done
