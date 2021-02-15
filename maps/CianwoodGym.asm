CianwoodGym_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  4, 17, CIANWOOD_CITY, 2
	warp_event  5, 17, CIANWOOD_CITY, 2

	def_coord_events

	def_bg_events
	bg_event  3, 15, BGEVENT_READ, CianwoodGymStatue
	bg_event  6, 15, BGEVENT_READ, CianwoodGymStatue

	def_object_events
	object_event  4,  1, SPRITE_CHUCK, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, CianwoodGymChuckScript, -1
	strengthboulder_event  5, 1
	object_event  2, 12, SPRITE_BLACK_BELT, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerBlackbeltYoshi, -1
	object_event  7, 12, SPRITE_BLACK_BELT, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerBlackbeltLao, -1
	object_event  3,  9, SPRITE_BLACK_BELT, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 2, GenericTrainerBlackbeltNob, -1
	object_event  5,  5, SPRITE_BLACK_BELT, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 1, GenericTrainerBlackbeltLung, -1
	object_event  7, 15, SPRITE_BLACK_BELT, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, CianwoodGymBlackBeltText, -1
	strengthboulder_event  3, 7
	strengthboulder_event  4, 7
	strengthboulder_event  5, 7

	object_const_def
	const CIANWOODGYM_CHUCK
	const CIANWOODGYM_BOULDER1

CianwoodGymChuckScript:
	faceplayer
	opentext
	checkevent EVENT_BEAT_CHUCK
	iftrue .FightDone
	writetext ChuckIntroText1
	waitbutton
	closetext
	turnobject CIANWOODGYM_CHUCK, RIGHT
	showtext ChuckIntroText2
	applymovement CIANWOODGYM_BOULDER1, CianwoodGymMovement_ChuckChucksBoulder
	playsound SFX_STRENGTH
	earthquake 80
	disappear CIANWOODGYM_BOULDER1
	pause 30
	showtextfaceplayer ChuckIntroText3
	winlosstext ChuckLossText, 0
	loadtrainer CHUCK, 1
	startbattle
	reloadmapafterbattle
	setevent EVENT_BEAT_CHUCK
	opentext
	writetext GetStormBadgeText
	playsound SFX_GET_BADGE
	waitsfx
	setflag ENGINE_STORMBADGE
	specialphonecall SPECIALCALL_YELLOWFOREST
.FightDone:
	checkevent EVENT_GOT_TM01_DYNAMICPUNCH
	iftrue_jumpopenedtext ChuckAfterText
	setevent EVENT_BEAT_BLACKBELT_YOSHI
	setevent EVENT_BEAT_BLACKBELT_LAO
	setevent EVENT_BEAT_BLACKBELT_NOB
	setevent EVENT_BEAT_BLACKBELT_LUNG
	writetext ChuckExplainBadgeText
	buttonsound
	verbosegivetmhm TM_DYNAMICPUNCH
	setevent EVENT_GOT_TM01_DYNAMICPUNCH
	jumpopenedtext ChuckExplainTMText

GenericTrainerBlackbeltYoshi:
	generictrainer BLACKBELT_T, YOSHI, EVENT_BEAT_BLACKBELT_YOSHI, BlackbeltYoshiSeenText, BlackbeltYoshiBeatenText

	text "You seem to have a"
	line "strong bond with"
	cont "your #mon too!"
	done

GenericTrainerBlackbeltLao:
	generictrainer BLACKBELT_T, LAO, EVENT_BEAT_BLACKBELT_LAO, BlackbeltLaoSeenText, BlackbeltLaoBeatenText

	text "Fighting #mon"
	line "are afraid of psy-"
	cont "chics…"
	done

GenericTrainerBlackbeltNob:
	generictrainer BLACKBELT_T, NOB, EVENT_BEAT_BLACKBELT_NOB, BlackbeltNobSeenText, BlackbeltNobBeatenText

	text "I lost!"
	line "I'm speechless!"
	done

GenericTrainerBlackbeltLung:
	generictrainer BLACKBELT_T, LUNG, EVENT_BEAT_BLACKBELT_LUNG, BlackbeltLungSeenText, BlackbeltLungBeatenText

	text "My #mon lost…"
	line "My… my pride is"
	cont "shattered…"
	done

CianwoodGymStatue:
	trainertotext CHUCK, 1, $1
	checkflag ENGINE_STORMBADGE
	iftrue .Beaten
	jumpstd gymstatue1
.Beaten:
	checkcode VAR_BADGES
	ifgreater 12, .LyraToo
	jumpstd gymstatue2
.LyraToo
	jumpstd gymstatue3

CianwoodGymMovement_ChuckChucksBoulder:
	set_sliding
	run_step_left
	run_step_up
	fast_jump_step_right
	remove_sliding
	step_end

ChuckIntroText1:
	text "WAHAHAH!"

	para "So you've come"
	line "this far!"

	para "Let me tell you,"
	line "I'm tough!"

	para "My #mon will"
	line "crush stones and"
	cont "shatter bones!"

	para "Watch this!"
	done

ChuckIntroText2:
	text "Chuck: Urggh!"
	line "…"

	para "Oooarrgh!"
	done

ChuckIntroText3:
	text "There! Scared now,"
	line "are you?"

	para "What?"
	line "It has nothing to"

	para "do with #mon?"
	line "That's true!"

	para "Come on. We shall"
	line "do battle!"
	done

ChuckLossText:
	text "Wha? Huh?"
	line "I lost?"

	para "How about that!"
	line "You're worthy of"
	cont "the Storm Badge!"
	done

GetStormBadgeText:
	text "<PLAYER> received"
	line "the Storm Badge."
	done

ChuckExplainBadgeText:
	text "The Storm Badge"
	line "lets your #mon"

	para "Fly to any city"
	line "or town you've"
	cont "already been to."

	para "Here, take this"
	line "too!"
	done

ChuckExplainTMText:
	text "That is Dynamic-"
	line "Punch."

	para "It doesn't always"
	line "hit, but when it"

	para "does, it causes"
	line "confusion!"
	done

ChuckAfterText:
	text "WAHAHAH! I enjoyed"
	line "battling you!"

	para "But a loss is a"
	line "loss!"

	para "From now on, I'm"
	line "going to train 24"
	cont "hours a day!"
	done

BlackbeltYoshiSeenText:
	text "My #mon and I"
	line "are bound togeth-"
	cont "er by friendship."

	para "Our bond will"
	line "never be broken!"
	done

BlackbeltYoshiBeatenText:
	text "This isn't real!"
	done

BlackbeltLaoSeenText:
	text "We martial artists"
	line "fear nothing!"
	done

BlackbeltLaoBeatenText:
	text "That's shocking!"
	done

BlackbeltNobSeenText:
	text "Words are useless."
	line "Let your fists do"
	cont "the talking!"
	done

BlackbeltNobBeatenText:
	text "…"
	done

BlackbeltLungSeenText:
	text "My raging fists"
	line "will shatter your"
	cont "#mon!"
	done

BlackbeltLungBeatenText:
	text "I got shattered!"
	done

CianwoodGymBlackBeltText:
	text "The Gym guide is"
	line "too scared of us"
	cont "to stay here."

	para "What a wimp!"
	done
