RuinsOfAlphHoOhChamber_MapScriptHeader:
	def_scene_scripts
	scene_script RuinsOfAlphHoOhChamberCheckWallScene, SCENE_RUINSOFALPHHOOHCHAMBER_CHECK_WALL
	scene_const SCENE_RUINSOFALPHHOOHCHAMBER_NOOP

	def_callbacks
	callback MAPCALLBACK_TILES, RuinsOfAlphHoOhChamberHiddenDoorsCallback

	def_warp_events
	warp_event  3,  9, RUINS_OF_ALPH_OUTSIDE, 1
	warp_event  4,  9, RUINS_OF_ALPH_OUTSIDE, 1
	warp_event  3,  3, RUINS_OF_ALPH_INNER_CHAMBER, 2
	warp_event  4,  3, RUINS_OF_ALPH_INNER_CHAMBER, 3
	warp_event  4,  0, RUINS_OF_ALPH_HO_OH_ITEM_ROOM, 1

	def_coord_events

	def_bg_events
	bg_event  2,  3, BGEVENT_JUMPTEXT, RuinsofAlphStatueText
	bg_event  5,  3, BGEVENT_JUMPTEXT, RuinsofAlphStatueText
	bg_event  3,  2, BGEVENT_UP, MapRuinsofAlphHoOhChamberSignpost2Script
	bg_event  4,  2, BGEVENT_UP, MapRuinsofAlphHoOhChamberSignpost3Script
	bg_event  3,  0, BGEVENT_UP, MapRuinsofAlphHoOhChamberSignpost4Script
	bg_event  4,  0, BGEVENT_UP, MapRuinsofAlphHoOhChamberSignpost5Script

	def_object_events

RuinsOfAlphHoOhChamberCheckWallScene:
	special SpecialHoOhChamber
	checkevent EVENT_WALL_OPENED_IN_HO_OH_CHAMBER
	iffalsefwd .End
	sdefer RuinsOfAlphHoOhChamberWallOpenScript
.End
	end

RuinsOfAlphHoOhChamberHiddenDoorsCallback:
	checkevent EVENT_WALL_OPENED_IN_HO_OH_CHAMBER
	iftruefwd .WallOpen
	changeblock 4, 0, $24
.WallOpen:
	checkevent EVENT_SOLVED_HO_OH_PUZZLE
	iffalsefwd .FloorClosed
	endcallback

.FloorClosed:
	changeblock 2, 2, $1
	changeblock 4, 2, $2
	endcallback

RuinsOfAlphHoOhChamberWallOpenScript:
	pause 30
	earthquake 30
	showemote EMOTE_SHOCK, PLAYER, 20
	pause 30
	playsound SFX_STRENGTH
	changeblock 4, 0, $25
	refreshmap
	earthquake 50
	setscene SCENE_RUINSOFALPHHOOHCHAMBER_NOOP
	endtext

MapRuinsofAlphHoOhChamberSignpost2Script:
	reanchormap
	setval $3
	special Special_UnownPuzzle
	closetext
	iftruefwd .PuzzleComplete
	end

.PuzzleComplete:
	setevent EVENT_RUINS_OF_ALPH_INNER_CHAMBER_TOURISTS
	setevent EVENT_SOLVED_HO_OH_PUZZLE
	setflag ENGINE_UNLOCKED_UNOWNS_X_TO_QUESTION
	setmapscene RUINS_OF_ALPH_INNER_CHAMBER, SCENE_RUINSOFALPHINNERCHAMBER_STRANGE_PRESENCE
	earthquake 30
	showemote EMOTE_SHOCK, PLAYER, 15
	changeblock 2, 2, $14
	changeblock 4, 2, $15
	refreshmap
	playsound SFX_STRENGTH
	earthquake 80
	applyonemovement PLAYER, skyfall_top
	playsound SFX_KINESIS
	waitsfx
	pause 20
	warpcheck
	end

MapRuinsofAlphHoOhChamberSignpost3Script:
	opentext
	unowntypeface
	writetext RuinsOfAlphHoOhChamberDescriptionText
	waitbutton
	closetext
	restoretypeface
	special RefreshSprites
	end

MapRuinsofAlphHoOhChamberSignpost5Script:
	checkevent EVENT_WALL_OPENED_IN_HO_OH_CHAMBER
	iftrue_jumptext RuinsOfAlphAerodactylChamberWallHoleText
MapRuinsofAlphHoOhChamberSignpost4Script:
	opentext
	checkevent EVENT_RUINS_OF_ALPH_OUTSIDE_TOURIST_YOUNGSTERS
	iftruefwd .unsolved
	writetext RuinsOfAlphChambersItsUnownText
	sjumpfwd .unownwords
.unsolved
	writetext RuinsOfAlphAerodactylChamberWallPatternLeftText
.unownwords
	setval $3
	special Special_DisplayUnownWords
	endtext

RuinsOfAlphHoOhChamberDescriptionText:
	text "A #mon that"
	line "flew gracefully on"

	para "rainbow-colored"
	line "wings."
	done
