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
	bg_event  1,  4, BGEVENT_READ, KabutoPuzzleScript
	bg_event  1,  5, BGEVENT_READ, KabutoPuzzleScript
	bg_event  5,  4, BGEVENT_READ, OmanytePuzzleScript
	bg_event  5,  5, BGEVENT_READ, OmanytePuzzleScript
	bg_event  1,  6, BGEVENT_READ, AerodactylPuzzleScript
	bg_event  1,  7, BGEVENT_READ, AerodactylPuzzleScript
	bg_event  5,  6, BGEVENT_READ, HoOhPuzzleScript
	bg_event  5,  7, BGEVENT_READ, HoOhPuzzleScript
	bg_event 10,  1, BGEVENT_JUMPTEXT, TowerRelicText
	bg_event 11,  1, BGEVENT_JUMPTEXT, TowerRelicText
	bg_event 11,  1, BGEVENT_JUMPTEXT, TowerRelicText

	def_object_events
	object_event  4,  2, SPRITE_SIGHTSEER_M, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, (1 << EVE) | (1 << NITE), 0, OBJECTTYPE_SCRIPT, 0, GoldenrodMuseum2FSightseerMScript, -1
	pokemon_event 5,  2, SMEARGLE, SPRITEMOVEDATA_POKEMON, -1, (1 << EVE) | (1 << NITE), PAL_NPC_BROWN, GoldenrodMuseum2FSmeargleText, -1
	object_event  3,  6, SPRITE_SCIENTIST, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_COMMAND, jumptextfaceplayer, GoldenrodMuseum2FScientistText, -1
	object_event 11,  3, SPRITE_POKEFAN_F, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, GoldenrodMuseum2FTeacherScript, -1

LugiaPaintingScript:
	checkevent EVENT_FOUGHT_LUGIA
	iffalse_jumptext EmptyDisplayText
	refreshscreen
	paintingpic LUGIA_PAINTING
	waitbutton
	closepokepic
	jumpthistext

	text "  The Leviathan"
	line "     Awakens"
	done

HoOhPaintingScript:
	checkevent EVENT_FOUGHT_HO_OH
	iffalse_jumptext EmptyDisplayText
	refreshscreen
	paintingpic HO_OH_PAINTING
	waitbutton
	closepokepic
	jumpthistext

	text "   The Phoenix"
	line "    Ascending"
	done

BellTowerPaintingScript:
	checkevent EVENT_FOUGHT_SUICUNE
	iffalse_jumptext EmptyDisplayText
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
	iffalse_jumptext EmptyDisplayText
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
	iffalse_jumptext EmptyDisplayText
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
	iffalse_jumptext EmptyDisplayText
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
	iffalse_jumptext EmptyDisplayText
	refreshscreen
	paintingpic HO_OH_PUZZLE
	waitbutton
	closepokepic
	jumpthistext

	text "It's the completed"
	line "Ho-Oh panel!"
	done

EmptyDisplayText:
	text "The display is"
	line "still empty…"
	done

TowerRelicText:
	text "An ancient mural"
	line "depicting a mys-"
	para "terious #mon."
	done

GoldenrodMuseum2FSightseerMScript:
	checkevent EVENT_FOUGHT_SUICUNE
	iffalse_jumptextfaceplayer GoldenrodMuseum2FSightseerMNoPaintingText
	checkevent EVENT_FOUGHT_HO_OH
	iffalse_jumptextfaceplayer GoldenrodMuseum2FSightseerMNoPaintingText
	checkevent EVENT_FOUGHT_LUGIA
	iffalse_jumptextfaceplayer GoldenrodMuseum2FSightseerMNoPaintingText
	jumpthistextfaceplayer

	text "Wow! This painting"
	line "is beautiful!"

	para "One day, I hope my"
	line "art is hung in a"

	para "museum for all to"
	line "see too."
	done

GoldenrodMuseum2FSightseerMNoPaintingText:
	text "Aww…! Smeargle and"
	line "I came because we"

	para "heard an art exhi-"
	line "bit would be here"

	para "for the grand"
	line "opening."

	para "But it seems we"
	line "heard wrong…"

	para "All the displays"
	line "are empty!"
	done

GoldenrodMuseum2FSmeargleText:
	text "Smeargle: Smeer!"
	done

GoldenrodMuseum2FScientistText:
	text "These artifacts"
	line "are fascinating!"

	para "Its a shame they're"
	line "just replicas…"

	para "I'd love to study"
	line "the real thing"
	cont "up close."
	done

GoldenrodMuseum2FTeacherScript:
	faceplayer
	opentext
	checkevent EVENT_LISTENED_TO_ENDURE_INTRO
	iftruefwd GoldenrodMuseum2FTutorEndureScript
	writetext GoldenrodMuseum2FTutorIntroText
	waitbutton
	setevent EVENT_LISTENED_TO_ENDURE_INTRO
; fallthrough
GoldenrodMuseum2FTutorEndureScript:
	writetext GoldenrodMuseum2FTutorEndureText
	waitbutton
	checkitem SILVER_LEAF
	iffalsefwd .NoSilverLeaf
	writetext GoldenrodMuseum2FTutorQuestion
	yesorno
	iffalsefwd .TutorRefused
	setval ENDURE
	writetext ClearText
	special Special_MoveTutor
	ifequalfwd $0, .TeachMove
.TutorRefused
	jumpopenedtext GoldenrodMuseum2FTutorRefused

.NoSilverLeaf
	jumpopenedtext GoldenrodMuseum2FTutorNoSilverLeaf

.TeachMove
	takeitem SILVER_LEAF
	jumpopenedtext GoldenrodMuseum2FTutorTaught

GoldenrodMuseum2FTutorIntroText:
	text "Before the con-"
	line "struction of the"

	para "Radio Tower,"
	line "there once stood"

	para "an old wooden"
	line "tower."

	para "This mural was"
	line "carefully re-"

	para "moved during con-"
	line "struction so it"

	para "could endure the"
	line "test of time."

	para "You know what else"
	line "can endure?"

	para "#mon, of"
	line "course!"
	done

GoldenrodMuseum2FTutorEndureText:
	text "I can teach your"
	line "#mon to use"

	para "Endure for one"
	line "Silver Leaf."
	done

GoldenrodMuseum2FTutorNoSilverLeaf:
	text "You don't have a"
	line "Silver Leaf!"
	done

GoldenrodMuseum2FTutorQuestion:
	text "Should I teach"
	line "your #mon"
	cont "Endure?"
	done

GoldenrodMuseum2FTutorRefused:
	text "If you say so."
	done

GoldenrodMuseum2FTutorTaught:
	text "Now your #mon"
	line "knows how to use"
	cont "Endure!"
	done
