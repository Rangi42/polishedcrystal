const_value set 2

PewterMuseumOfScience2F_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

Museum2FScientistScript:
	jumptextfaceplayer Museum2FScientistText

Museum2FYoungsterScript:
	jumptextfaceplayer Museum2FYoungsterText

Museum2FLassScript:
	jumptextfaceplayer Museum2FLassText

Museum2FGrampsScript:
	jumptextfaceplayer Museum2FGrampsText

Museum2FMoonStoneSignpostScript:
	jumptext Museum2FMoonStoneSignpostText

Museum2FSpaceShuttleSignpostScript:
	jumptext Museum2FSpaceShuttleSignpostText

Museum2FBookshelfSignpostScript:
	jumptext Museum2FBookshelfSignpostText

Museum2FScientistText:
	text "Meteorites struck"
	line "Mt.Moon near"
	cont "Pewter City."

	para "We have one"
	line "on display."

	para "It seems to emit"
	line "strange energy..."
	done

Museum2FYoungsterText:
	text "There are two"
	line "places that I"
	cont "love!"

	para "One is the Ruins"
	line "of Alph in Johto."
	cont "The other is the"
	cont "Pewter Museum!"

	para "I get a sense of"
	line "history from both"
	cont "of them."
	done

Museum2FLassText:
	text "Scientists found"
	line "a way to resurr-"
	cont "ect #mon from"
	cont "fossils like the"
	cont "ones here."

	para "I heard that"
	line "Brock raises some"
	cont "of them."
	done

Museum2FGrampsText:
	text "I saw this shuttle"
	line "when it first"
	cont "launched!"

	para "I bought a color"
	line "TV to watch it!"
	done

Museum2FMoonStoneSignpostText:
	text "Meteorite that"
	line "fell on Mt.Moon."
	cont "(Moon Stone)"
	done

Museum2FSpaceShuttleSignpostText:
	text "Space Shuttle"
	done

Museum2FBookshelfSignpostText:
	text "Thick and well-"
	line "read books!"

	para "Archaeology Man-"
	line "ual, Lost #mon,"
	cont "#mon Ancestors,"

	para "Caring at the"
	line "Loamy Layer of"
	cont "Kanto..."
	done

PewterMuseumOfScience2F_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 1
	warp_def $7, $7, 5, PEWTER_MUSEUM_OF_SCIENCE_1F

.XYTriggers:
	db 0

.Signposts:
	db 6
	signpost 5, 2, SIGNPOST_READ, Museum2FMoonStoneSignpostScript
	signpost 2, 11, SIGNPOST_READ, Museum2FSpaceShuttleSignpostScript
	signpost 1, 0, SIGNPOST_READ, Museum2FBookshelfSignpostScript
	signpost 1, 1, SIGNPOST_READ, Museum2FBookshelfSignpostScript
	signpost 1, 4, SIGNPOST_READ, Museum2FBookshelfSignpostScript
	signpost 1, 5, SIGNPOST_READ, Museum2FBookshelfSignpostScript

.PersonEvents:
	db 4
	person_event SPRITE_SCIENTIST, 5, 7, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, Museum2FScientistScript, -1
	person_event SPRITE_YOUNGSTER, 7, 1, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, Museum2FYoungsterScript, -1
	person_event SPRITE_LASS, 1, 2, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, Museum2FLassScript, -1
	person_event SPRITE_GRAMPS, 5, 12, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, Museum2FGrampsScript, -1
