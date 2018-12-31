FarawayIsland_MapScriptHeader:

.MapTriggers: db 2
	dw FarawayIslandTrigger0
	dw FarawayIslandTrigger1

.MapCallbacks: db 2
	dbw MAPCALLBACK_NEWMAP, FarawayIslandVisited
	dbw MAPCALLBACK_SPRITES, FarawayIslandSetupLawrence

FarawayIsland_MapEventHeader:

.Warps: db 2
	warp_def 8, 22, 1, FARAWAY_JUNGLE
	warp_def 8, 23, 2, FARAWAY_JUNGLE

.XYTriggers: db 0

.Signposts: db 1
	signpost 34, 4, SIGNPOST_JUMPTEXT, FarawayIslandSignText

.PersonEvents: db 2
	person_event SPRITE_SAILOR, 42, 12, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, FarawayIslandSailorScript, EVENT_OLIVINE_PORT_SAILOR_AT_GANGWAY
	person_event SPRITE_LAWRENCE, 37, 3, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, FarawayIslandLawrenceScript, EVENT_LAWRENCE_FARAWAY_ISLAND

const_value set 1
	const FARAWAYISLAND_SAILOR
	const FARAWAYISLAND_LAWRENCE

FarawayIslandTrigger1:
	priorityjump FarawayIsland_PlayerArrives
FarawayIslandTrigger0:
	end

FarawayIslandVisited:
	setevent EVENT_VISITED_FARAWAY_ISLAND
	return

FarawayIslandSetupLawrence:
	disappear FARAWAYISLAND_LAWRENCE
	checkevent EVENT_BEAT_LAWRENCE
	iffalse .Done
	checkevent EVENT_BEAT_LAWRENCE_AGAIN
	iftrue .Done
	appear FARAWAYISLAND_LAWRENCE
.Done
	return

FarawayIsland_PlayerArrives:
	applymovement FARAWAYISLAND_SAILOR, FarawayIslandSailorArrive1MovementData
	applymovement PLAYER, FarawayIslandPlayerArriveMovementData
	showtext SeagallopFerryFarawayIslandRefusedText
	applymovement FARAWAYISLAND_SAILOR, FarawayIslandSailorArrive2MovementData
	dotrigger $0
	end

FarawayIslandSailorScript:
	faceplayer
	opentext
	writetext SeagallopFerryFarawayToVermilionQuestionText
	yesorno
	iffalse .RefuseFerry
	writetext SeagallopFerryFarawayToVermilionText
	waitbutton
	closetext
	spriteface FARAWAYISLAND_SAILOR, DOWN
	pause 10
	applyonemovement FARAWAYISLAND_SAILOR, turn_head_down
	playsound SFX_EXIT_BUILDING
	disappear FARAWAYISLAND_SAILOR
	waitsfx
	applyonemovement PLAYER, step_down
	playsound SFX_EXIT_BUILDING
	special FadeOutPalettes
	waitsfx
	appear FARAWAYISLAND_SAILOR
	domaptrigger SEAGALLOP_FERRY_VERMILION_GATE, $1
	warp SEAGALLOP_FERRY_VERMILION_GATE, 6, 5
	end

.RefuseFerry
	jumpopenedtext SeagallopFerryFarawayIslandRefusedText

FarawayIslandLawrenceScript:
	special Special_FadeOutMusic
	pause 15
	playmusic MUSIC_ZINNIA_ENCOUNTER_ORAS
	faceplayer
	opentext
	writetext FarawayIslandLawrenceText1
	yesorno
	iffalse .no_battle
	writetext FarawayIslandLawrenceYesText
	waitbutton
	closetext
	winlosstext FarawayIslandLawrenceBeatenText, 0
	setlasttalked FARAWAYISLAND_LAWRENCE
	loadtrainer LAWRENCE, 2
	startbattle
	dontrestartmapmusic
	reloadmapafterbattle
	faceplayer
	special DeleteSavedMusic
	playmusic MUSIC_ZINNIA_ENCOUNTER_ORAS
	showtext FarawayIslandLawrenceText2
	pause 15
	playsound SFX_WARP_TO
	special Special_FadeBlackQuickly
	special Special_ReloadSpritesNoPalettes
	disappear FARAWAYISLAND_LAWRENCE
	waitsfx
	special Special_FadeInQuickly
	setevent EVENT_BEAT_LAWRENCE_AGAIN
	setevent EVENT_LAWRENCE_FARAWAY_ISLAND
	playmapmusic
	end

.no_battle:
	writetext FarawayIslandLawrenceNoText
	waitbutton
	closetext
	spriteface FARAWAYISLAND_LAWRENCE, DOWN
	playmapmusic
	end

FarawayIslandPlayerArriveMovementData:
	step_up
	step_up
	turn_head_down
	step_end

FarawayIslandSailorArrive1MovementData:
	step_up
	step_left
	turn_head_right
	step_end

FarawayIslandSailorArrive2MovementData:
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

FarawayIslandLawrenceText1:
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

FarawayIslandLawrenceYesText:
	text "Excellent!"
	done

FarawayIslandLawrenceNoText:
	text "…Very well."
	done

FarawayIslandLawrenceBeatenText:
	text "You beat me once"
	line "again…"
	done

FarawayIslandLawrenceText2:
	text "Lawrence: …I see."
	line "I still have far"
	cont "to go before I"

	para "can build an even"
	line "better collection."

	para "Farewell."
	done

FarawayIslandSignText:
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
