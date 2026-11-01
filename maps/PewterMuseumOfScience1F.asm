PewterMuseumOfScience1F_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event 10,  7, PEWTER_CITY, 6
	warp_event 11,  7, PEWTER_CITY, 8
	warp_event 16,  7, PEWTER_CITY, 7
	warp_event 17,  7, PEWTER_CITY, 7
	warp_event  7,  7, PEWTER_MUSEUM_OF_SCIENCE_2F, 1

	def_coord_events

	def_bg_events
	bg_event  2,  3, BGEVENT_READ, KabutopsFossilSignpostScript
	bg_event  6,  3, BGEVENT_READ, OmastarFossilSignpostScript
	bg_event  3,  6, BGEVENT_READ, AerodactylFossilSignpostScript
	bg_event 12,  1, BGEVENT_JUMPTEXT, Museum1FBookshelfSignpostText
	bg_event 13,  1, BGEVENT_JUMPTEXT, Museum1FBookshelfSignpostText
	bg_event 14,  1, BGEVENT_JUMPTEXT, Museum1FBookshelfSignpostText
	bg_event 15,  1, BGEVENT_JUMPTEXT, Museum1FBookshelfSignpostText
	bg_event 17,  1, BGEVENT_JUMPTEXT, Museum1FBookshelfSignpostText
	bg_event 18,  1, BGEVENT_JUMPTEXT, Museum1FBookshelfSignpostText

	def_object_events
	object_event 18,  3, SPRITE_SCIENTIST, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, PAL_NPC_GRAY, OBJECTTYPE_SCRIPT, 0, Museum1FFossilScientistScript, -1
	object_event 12,  4, SPRITE_RECEPTIONIST, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, Museum1FReceptionistScript, -1
	object_event 16,  2, SPRITE_SCIENTIST, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, PAL_NPC_GRAY, OBJECTTYPE_COMMAND, jumptextfaceplayer, Museum1FScientistText, -1
	object_event  1,  7, SPRITE_GRAMPS, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, Museum1FGrampsText, -1
	object_event  4,  3, SPRITE_SCHOOLBOY, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, Museum1FYoungsterText, -1

	object_const_def
	const PEWTERMUSEUMOFSCIENCE1F_SCIENTIST2

Museum1FFossilScientistScript:
	faceplayer
	opentext
	writetext Museum1FFossilScientistText
	waitbutton
	loadmem wResurrectFossilScriptBank, BANK(.FaceRight)
	loadmem wResurrectFossilScript+0, LOW(.FaceRight)
	loadmem wResurrectFossilScript+1, HIGH(.FaceRight)
	farsjump AskResurrectFossilScript

.FaceRight:
	turnobject PEWTERMUSEUMOFSCIENCE1F_SCIENTIST2, RIGHT
	end

Museum1FReceptionistScript:
	readvar VAR_FACING
	ifequalfwd DOWN, .Sneak
	ifequalfwd LEFT, .Sneak
	jumpthistextfaceplayer

	text "Welcome!"

	para "Thanks to a gene-"
	line "rous donation"
	cont "by Silph Co.,"

	para "admission is free"
	line "of charge!"

	para "Please go ahead."
	done

.Sneak:
	jumpthistextfaceplayer

	text "You can't sneak"
	line "in the back way!"
	done

KabutopsFossilSignpostScript:
	reanchormap
	trainerpic KABUTOPS_FOSSIL
	waitbutton
	closepokepic
	jumpthistext

	text "Kabutops Fossil"
	line "(Dome)"

	para "A primitive and"
	line "rare #mon."
	done

OmastarFossilSignpostScript:
	reanchormap
	trainerpic OMASTAR_FOSSIL
	waitbutton
	closepokepic
	jumpthistext

	text "Omastar Fossil"
	line "(Helix)"

	para "A primitive and"
	line "rare #mon."
	done

AerodactylFossilSignpostScript:
	reanchormap
	trainerpic AERODACTYL_FOSSIL
	waitbutton
	closepokepic
	jumpthistext

	text "Aerodactyl Fossil"

	para "A primitive and"
	line "rare #mon."
	done

Museum1FScientistText:
	text "We are proud of"
	line "three fossils of"

	para "rare, prehistoric"
	line "#mon."

	para "I helped assemble"
	line "them!"
	done

Museum1FFossilScientistText:
	text "Did you know that"
	line "you can extract"

	para "#mon from"
	line "fossils?"

	para "If you ever need"
	line "to, let me take"
	cont "care of it!"
	done

Museum1FGrampsText:
	text "That is one"
	line "magnificent"
	cont "fossil!"
	done

Museum1FYoungsterText:
	text "There are two"
	line "places that I"
	cont "love!"

	para "One is the Ruins"
	line "of Alph in Johto."

	para "The other is the"
	line "Pewter Museum!"

	para "I get a sense of"
	line "history from both"
	cont "of them."
	done

Museum1FBookshelfSignpostText:
	text "Thick and well-"
	line "read books!"

	para "Archaeology Man-"
	line "ual, Lost #mon,"
	cont "#mon Ancestors,"

	para "Caring at the"
	line "Loamy Layer of"
	cont "Kanto…"
	done
