GoldenrodMuseum2F_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event 13,  7, GOLDENROD_MUSEUM_1F, 3

	def_coord_events

	def_bg_events
	bg_event  1,  0, BGEVENT_READ, LugiaPaintingScript
	bg_event  2,  0, BGEVENT_READ, LugiaPaintingScript
	bg_event  4,  0, BGEVENT_READ, BellTowerPaintingScript
	bg_event  5,  0, BGEVENT_READ, BellTowerPaintingScript
	bg_event  7,  0, BGEVENT_READ, HoOhPaintingScript
	bg_event  8,  0, BGEVENT_READ, HoOhPaintingScript
	bg_event  0,  4, BGEVENT_READ, KabutoPuzzleScript
	bg_event  0,  5, BGEVENT_READ, KabutoPuzzleScript
	bg_event  3,  4, BGEVENT_READ, OmanytePuzzleScript
	bg_event  3,  5, BGEVENT_READ, OmanytePuzzleScript
	bg_event  0,  6, BGEVENT_READ, AerodactylPuzzleScript
	bg_event  0,  7, BGEVENT_READ, AerodactylPuzzleScript
	bg_event  3,  6, BGEVENT_READ, HoOhPuzzleScript
	bg_event  3,  7, BGEVENT_READ, HoOhPuzzleScript

	def_object_events
	object_event  6,  3, SPRITE_BIG_LAPRAS, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_ROCK, OBJECTTYPE_COMMAND, jumptext, GoldenrodMuseum2FBigPearlText, -1

LugiaPaintingScript:
	refreshscreen
	paintingpic LUGIA_PAINTING
	waitbutton
	closepokepic
	jumpthistext

	text "  The Leviathan"
	line "     Awakens"
	done

HoOhPaintingScript:
	refreshscreen
	paintingpic HO_OH_PAINTING
	waitbutton
	closepokepic
	jumpthistext

	text "   The Phoenix"
	line "    Ascending"
	done

BellTowerPaintingScript:
	refreshscreen
	paintingpic BELL_TOWER_PAINTING
	waitbutton
	closepokepic
	jumpthistext

	text "    Friendship"
	line "     and Hope"
	done

KabutoPuzzleScript:
	checkevent EVENT_SOLVED_KABUTO_PUZZLE
	iffalse_jumptext UnsolvedPuzzleText
	refreshscreen
	paintingpic KABUTO_PUZZLE
	waitbutton
	closepokepic
	jumpthistext

	text "It's the completed"
	line "Kabuto panel!"
	done

OmanytePuzzleScript:
	checkevent EVENT_SOLVED_OMANYTE_PUZZLE
	iffalse_jumptext UnsolvedPuzzleText
	refreshscreen
	paintingpic OMANYTE_PUZZLE
	waitbutton
	closepokepic
	jumpthistext

	text "It's the completed"
	line "Omanyte panel!"
	done

AerodactylPuzzleScript:
	checkevent EVENT_SOLVED_AERODACTYL_PUZZLE
	iffalse_jumptext UnsolvedPuzzleText
	refreshscreen
	paintingpic AERODACTYL_PUZZLE
	waitbutton
	closepokepic
	jumpthistext

	text "It's the completed"
	line "Aerodactyl panel!"
	done

HoOhPuzzleScript:
	checkevent EVENT_SOLVED_HO_OH_PUZZLE
	iffalse_jumptext UnsolvedPuzzleText
	refreshscreen
	paintingpic HO_OH_PUZZLE
	waitbutton
	closepokepic
	jumpthistext

	text "It's the completed"
	line "Ho-Oh panel!"
	done

UnsolvedPuzzleText:
	text "The display is"
	line "still empty…"
	done

GoldenrodMuseum2FBigPearlText:
	text "It's a huge pearl"
	line "fished up from"
	cont "Goldenrod Harbor."
	done
