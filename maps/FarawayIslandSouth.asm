FarawayIslandSouth_MapScriptHeader:
	def_scene_scripts
	scene_script DoNothingScript, SCENE_FARAWAYISLANDSOUTH_NOOP
	scene_script FarawayIslandSouthArrivalScene, SCENE_FARAWAYISLANDSOUTH_ARRIVAL

	def_callbacks
	callback MAPCALLBACK_NEWMAP, FarawayIslandVisited
	callback MAPCALLBACK_OBJECTS, FarawayIslandSouthSetupLawrence

	def_warp_events

	def_coord_events

	def_bg_events
	bg_event  4,  4, BGEVENT_JUMPTEXT, FarawayIslandSouthSignText

	def_object_events
	object_event 12, 12, SPRITE_SAILOR, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, 0, OBJECTTYPE_SCRIPT, 0, FarawayIslandSouthSailorScript, EVENT_OLIVINE_PORT_SAILOR_AT_GANGWAY
	object_event  3,  7, SPRITE_LAWRENCE, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, 0, OBJECTTYPE_SCRIPT, 0, FarawayIslandSouthLawrenceScript, EVENT_LAWRENCE_FARAWAY_ISLAND
	object_event 22,  4, SPRITE_PEARL, SPRITEMOVEDATA_CUTTABLE_TREE, 0, 0, -1, PAL_NPC_FARAWAY_ROCK, OBJECTTYPE_COMMAND, end, NULL, -1
	object_event  8,  8, SPRITE_PEARL, SPRITEMOVEDATA_CUTTABLE_TREE, 0, 0, -1, PAL_NPC_FARAWAY_ROCK, OBJECTTYPE_COMMAND, end, NULL, -1
	object_event  7,  9, SPRITE_PEARL, SPRITEMOVEDATA_CUTTABLE_TREE, 0, 0, -1, PAL_NPC_FARAWAY_ROCK, OBJECTTYPE_COMMAND, end, NULL, -1
	object_event  3, 11, SPRITE_PEARL, SPRITEMOVEDATA_CUTTABLE_TREE, 0, 0, -1, PAL_NPC_FARAWAY_ROCK, OBJECTTYPE_COMMAND, end, NULL, -1
	object_event  6, 14, SPRITE_PEARL, SPRITEMOVEDATA_CUTTABLE_TREE, 0, 0, -1, PAL_NPC_FARAWAY_ROCK, OBJECTTYPE_COMMAND, end, NULL, -1

	object_const_def
	const FARAWAYISLANDSOUTH_SAILOR
	const FARAWAYISLANDSOUTH_LAWRENCE

FarawayIslandVisited:
	setevent EVENT_VISITED_FARAWAY_ISLAND
	endcallback

FarawayIslandSouthSetupLawrence:
	disappear FARAWAYISLANDSOUTH_LAWRENCE
	checkevent EVENT_BEAT_LAWRENCE
	iffalsefwd .Done
	checkevent EVENT_BEAT_LAWRENCE_AGAIN
	iftruefwd .Done
	appear FARAWAYISLANDSOUTH_LAWRENCE
.Done
	endcallback

FarawayIslandSouthArrivalScene:
	sdefer .Script
	end

.Script:
	applymovement FARAWAYISLANDSOUTH_SAILOR, FarawayIslandSouthSailorArrive1MovementData
	applymovement PLAYER, FarawayIslandSouthPlayerArriveMovementData
	showtext SeagallopFerryFarawayIslandRefusedText
	applymovement FARAWAYISLANDSOUTH_SAILOR, FarawayIslandSouthSailorArrive2MovementData
	setscene SCENE_FARAWAYISLANDSOUTH_NOOP
	end

FarawayIslandSouthSailorScript:
	faceplayer
	opentext
	writetext SeagallopFerryFarawayToVermilionQuestionText
	yesorno
	iffalsefwd .RefuseFerry
	writetext SeagallopFerryFarawayToVermilionText
	waitbutton
	closetext
	turnobject FARAWAYISLANDSOUTH_SAILOR, DOWN
	pause 10
	applyonemovement FARAWAYISLANDSOUTH_SAILOR, turn_head_down
	playsound SFX_EXIT_BUILDING
	disappear FARAWAYISLANDSOUTH_SAILOR
	waitsfx
	applyonemovement PLAYER, step_down
	playsound SFX_EXIT_BUILDING
	special FadeOutPalettes
	waitsfx
	appear FARAWAYISLANDSOUTH_SAILOR
	setmapscene SEAGALLOP_FERRY_VERMILION_GATE, SCENE_SEAGALLOPFERRYVERMILIONGATE_LEAVE
	warp SEAGALLOP_FERRY_VERMILION_GATE, 6, 5
	end

.RefuseFerry
	jumpopenedtext SeagallopFerryFarawayIslandRefusedText

FarawayIslandSouthLawrenceScript:
	special Special_FadeOutMusic
	pause 15
	playmusic MUSIC_ZINNIA_ENCOUNTER_ORAS
	faceplayer
	opentext
	writetext FarawayIslandSouthLawrenceText1
	yesorno
	iffalsefwd .no_battle
	writetext FarawayIslandSouthLawrenceYesText
	waitbutton
	closetext
	winlosstext FarawayIslandSouthLawrenceBeatenText, 0
	setlasttalked FARAWAYISLANDSOUTH_LAWRENCE
	loadtrainer LAWRENCE, 2
	startbattle
	dontrestartmapmusic
	reloadmapafterbattle
	faceplayer
	special DeleteSavedMusic
	playmusic MUSIC_ZINNIA_ENCOUNTER_ORAS
	showtext FarawayIslandSouthLawrenceText2
	pause 15
	playsound SFX_WARP_TO
	special Special_FadeBlackQuickly
	special Special_ReloadSpritesNoPalettes
	disappear FARAWAYISLANDSOUTH_LAWRENCE
	waitsfx
	special Special_FadeInQuickly
	setevent EVENT_BEAT_LAWRENCE_AGAIN
	setevent EVENT_LAWRENCE_FARAWAY_ISLAND
	playmapmusic
	end

.no_battle:
	writetext FarawayIslandSouthLawrenceNoText
	waitbutton
	closetext
	turnobject FARAWAYISLANDSOUTH_LAWRENCE, DOWN
	playmapmusic
	end

FarawayIslandSouthPlayerArriveMovementData:
	step_up
	step_up
	turn_head_down
	step_end

FarawayIslandSouthSailorArrive1MovementData:
	step_up
	step_left
	turn_head_right
	step_end

FarawayIslandSouthSailorArrive2MovementData:
	step_right
	step_down
	turn_head_up
	step_end

SeagallopFerryFarawayToVermilionQuestionText:
	text "Ready to head back"
	line "to Vermilion City?"
	done

SeagallopFerryFarawayToVermilionText:
	text "All right!"

	para "All aboard the"
	line "Seagallop Ferry!"
	done

SeagallopFerryFarawayIslandRefusedText:
	text "I'll be waiting"
	line "right here."
	done

FarawayIslandSouthLawrenceText1:
	text "Lawrence: Well,"
	line "this certainly is"

	para "a pleasure, though"
	line "an unexpected one."

	para "I came here to"
	line "remember how my"
	cont "collection began…"

	para "with a Mew carving"
	line "found on this very"
	cont "island."

	para "…I have been"
	line "thinking about our"
	cont "last battle."

	para "I want to under-"
	line "stand the bond"

	para "you have with your"
	line "collection."

	para "Will you battle"
	line "me again?"
	done

FarawayIslandSouthLawrenceYesText:
	text "Excellent!"
	done

FarawayIslandSouthLawrenceNoText:
	text "…Very well."
	done

FarawayIslandSouthLawrenceBeatenText:
	text "You beat me once"
	line "again…"
	done

FarawayIslandSouthLawrenceText2:
	text "Lawrence: …I see."
	line "I still have far"
	cont "to go before I"

	para "can build an even"
	line "better collection."

	para "Farewell."
	done

FarawayIslandSouthSignText:
	text "The writing is"
	line "fading as if it"

	para "was written a long"
	line "time ago…"

	para "“…ber, 6th day"

	para "If any human…sets"
	line "foot here…"
	cont "again…et it be a"
	cont "kindhearted pers…"

	para "…ith that hope,"
	line "I depar…"

	para "…ji”"
	done
