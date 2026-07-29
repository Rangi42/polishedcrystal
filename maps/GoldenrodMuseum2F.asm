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
	object_event  4,  2, SPRITE_SIGHTSEER_M, SPRITEMOVEDATA_STANDING_UP, 0, 0, (1 << EVE) | (1 << NITE), 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, GoldenrodMuseum2FSightseerMText, -1
	pokemon_event 5,  2, SMEARGLE, SPRITEMOVEDATA_POKEMON, (1 << EVE) | (1 << NITE), PAL_MON_BROWN, GoldenrodMuseum2FSmeargleText, -1
	object_event  3,  6, SPRITE_SCIENTIST, SPRITEMOVEDATA_WANDER, 1, 1, -1, PAL_NPC_BROWN, OBJECTTYPE_SCRIPT, 0, GoldenrodMuseum2FScientistScript, -1
	object_event 11,  3, SPRITE_POKEFAN_F, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, GoldenrodMuseum2FTeacherScript, -1

LugiaPaintingScript:
	reanchormap
	paintingpic LUGIA_PAINTING
	waitbutton
	closepokepic
	jumpthistext

	text "  The Leviathan"
	line "     Awakens"
	done

HoOhPaintingScript:
	reanchormap
	paintingpic HO_OH_PAINTING
	waitbutton
	closepokepic
	jumpthistext

	text "   The Phoenix"
	line "    Ascending"
	done

BellTowerPaintingScript:
	reanchormap
	paintingpic BELL_TOWER_PAINTING
	waitbutton
	closepokepic
	jumpthistext

	text "    Friendship"
	line "     and Hope"
	done

KabutoPuzzleScript:
	checkevent EVENT_SOLVED_KABUTO_PUZZLE
	iffalse_jumptext EmptyPuzzleText
	showtext .Text
	paintingpic KABUTO_PUZZLE
	waitbutton
	closepokepic
	end

.Text:
	text "It's the completed"
	line "Kabuto panel!"
	done

OmanytePuzzleScript:
	checkevent EVENT_SOLVED_OMANYTE_PUZZLE
	iffalse_jumptext EmptyPuzzleText
	showtext .Text
	paintingpic OMANYTE_PUZZLE
	waitbutton
	closepokepic
	end

.Text:
	text "It's the completed"
	line "Omanyte panel!"
	done

AerodactylPuzzleScript:
	checkevent EVENT_SOLVED_AERODACTYL_PUZZLE
	iffalse_jumptext EmptyPuzzleText
	showtext .Text
	paintingpic AERODACTYL_PUZZLE
	waitbutton
	closepokepic
	end

.Text:
	text "It's the completed"
	line "Aerodactyl panel!"
	done

HoOhPuzzleScript:
	checkevent EVENT_SOLVED_HO_OH_PUZZLE
	iffalse_jumptext EmptyPuzzleText
	showtext .Text
	paintingpic HO_OH_PUZZLE
	waitbutton
	closepokepic
	end

.Text:
	text "It's the completed"
	line "Ho-Oh panel!"
	done

EmptyPuzzleText:
	text "Ruins of Alph"
	line "panel replica"

	para "(restoration"
	line "in progress)"
	done

TowerRelicText:
	text "An ancient mural"
	line "depicting a mys-"
	cont "terious #mon."
	done

GoldenrodMuseum2FSightseerMText:
	text "These paintings"
	line "are beautiful!"

	para "One day, I hope my"
	line "art is hung in a"

	para "museum for all to"
	line "see too."
	done

GoldenrodMuseum2FSmeargleText:
	text "Smeargle: Smeer!"
	done

GoldenrodMuseum2FScientistScript:
	checkevent EVENT_SOLVED_KABUTO_PUZZLE
	iftrue_jumptextfaceplayer GoldenrodMuseum2FScientistSomeArtifactsText
	checkevent EVENT_SOLVED_OMANYTE_PUZZLE
	iftrue_jumptextfaceplayer GoldenrodMuseum2FScientistSomeArtifactsText
	checkevent EVENT_SOLVED_AERODACTYL_PUZZLE
	iftrue_jumptextfaceplayer GoldenrodMuseum2FScientistSomeArtifactsText
	checkevent EVENT_SOLVED_HO_OH_PUZZLE
	iftrue_jumptextfaceplayer GoldenrodMuseum2FScientistSomeArtifactsText
	jumpthistextfaceplayer

	text "I was expecting"
	line "there to be more"
	cont "exhibits…"

	para "Where are the"
	line "Alph carvings?"
	done

GoldenrodMuseum2FScientistSomeArtifactsText:
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
	checkevent EVENT_LISTENED_TO_BATON_PASS_INTRO
	iftruefwd GoldenrodMuseum2FTutorBatonPassScript
	writetext GoldenrodMuseum2FTutorIntroText
	waitbutton
	setevent EVENT_LISTENED_TO_BATON_PASS_INTRO
; fallthrough
GoldenrodMuseum2FTutorBatonPassScript:
	writetext GoldenrodMuseum2FTutorBatonPassText
	waitbutton
	checkitem SILVER_LEAF
	iffalsefwd .NoSilverLeaf
	writetext GoldenrodMuseum2FTutorQuestion
	yesorno
	iffalsefwd .TutorRefused
	setval BATON_PASS
	writetext ClearText
	special Special_MoveTutor
	ifequalfwd $0, .TeachMove
.TutorRefused
	jumpthisopenedtext

	text "If you say so."
	done

.NoSilverLeaf
	jumpthisopenedtext

	text "You don't have a"
	line "Silver Leaf!"
	done

.TeachMove
	takeitem SILVER_LEAF
	jumpthisopenedtext

	text "Now your #mon"
	line "knows how to use"
	cont "Baton Pass!"
	done

GoldenrodMuseum2FTutorIntroText:
	text "Before the con-"
	line "struction of the"

	para "new Radio Tower,"
	line "there once stood"

	para "an ancient wooden"
	line "tower."

	para "This mural was"
	line "originally in"
	cont "that tower."

	para "Moving it here"
	line "was necessary"

	para "to preserve a"
	line "piece of Johto's"
	cont "history."

	para "Even #mon"
	line "can understand"

	para "the value of"
	line "preservation!"
	done

GoldenrodMuseum2FTutorBatonPassText:
	text "I can teach your"
	line "#mon to use"

	para "Baton Pass for one"
	line "Silver Leaf."
	done


GoldenrodMuseum2FTutorQuestion:
	text "Should I teach"
	line "your #mon"
	cont "Baton Pass?"
	done
