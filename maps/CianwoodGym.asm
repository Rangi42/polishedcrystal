CianwoodGym_MapScriptHeader:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_TILES, CianwoodGymBouldersCallback
	callback MAPCALLBACK_STONETABLE, CianwoodGymSetUpStoneTable

	def_warp_events
	warp_event 12, 17, CIANWOOD_CITY, 2
	warp_event 13, 17, CIANWOOD_CITY, 2
	warp_event 12,  4, CIANWOOD_GYM, 1 ; for stonetable
	warp_event 13,  4, CIANWOOD_GYM, 2 ; for stonetable

	def_coord_events

	def_bg_events
	bg_event 11, 15, BGEVENT_READ, CianwoodGymStatue
	bg_event 14, 15, BGEVENT_READ, CianwoodGymStatue

	def_object_events
	object_event 12, 11, SPRITE_CHUCK, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, 0, OBJECTTYPE_SCRIPT, 0, CianwoodGymChuckScript, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_4
	object_event 12, 11, SPRITE_BIG_HO_OH, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, PAL_NPC_BROWN, OBJECTTYPE_COMMAND, jumptext, CianwoodGymChuckTrainingText, EVENT_BOULDERS_IN_CIANWOOD_GYM
	object_event 13, 11, SPRITE_BOULDER_ROCK_FOSSIL, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, 0, OBJECTTYPE_COMMAND, jumptext, CianwoodGymChucksBoulderText, -1
	strengthboulder_event  9,  4, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_2
	strengthboulder_event 16,  4, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_3
	object_event 12,  4, SPRITE_BOULDER_ROCK_FOSSIL, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, 0, OBJECTTYPE_COMMAND, jumptext, CianwoodGymBoulderText, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_4
	object_event 13,  4, SPRITE_BOULDER_ROCK_FOSSIL, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, 0, OBJECTTYPE_COMMAND, jumptext, CianwoodGymBoulderText, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_5
	object_event  5, 10, SPRITE_BLACK_BELT, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 2, GenericTrainerBlackbeltYoshi, -1
	object_event 21, 10, SPRITE_BLACK_BELT, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 2, GenericTrainerBlackbeltLao, -1
	object_event  9,  6, SPRITE_BLACK_BELT, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 2, GenericTrainerBlackbeltNob, -1
	object_event 20,  6, SPRITE_BLACK_BELT, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 2, GenericTrainerBlackbeltLung, -1
	object_event 15, 15, SPRITE_BLACK_BELT, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, CianwoodGymBlackBeltText, -1

	object_const_def
	const CIANWOODGYM_CHUCK1
	const CIANWOODGYM_CHUCK2
	const CIANWOODGYM_BOULDER1
	const CIANWOODGYM_BOULDER2
	const CIANWOODGYM_BOULDER3
	const CIANWOODGYM_BOULDER4
	const CIANWOODGYM_BOULDER5

CianwoodGymBouldersCallback:
	checkevent EVENT_BOULDERS_IN_CIANWOOD_GYM
	iftruefwd .WaterfallBlocked
	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_4
	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_5
	endcallback

.WaterfallBlocked:
	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_2
	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_3
	changeblock 12,  4, $83
	changeblock 12,  6, $7d
	changeblock 12,  8, $7d
	changeblock 12, 10, $8f
	endcallback

CianwoodGymSetUpStoneTable:
	usestonetable .StoneTable
	endcallback

.StoneTable:
	stonetable 3, CIANWOODGYM_BOULDER2, .Boulder2
	stonetable 4, CIANWOODGYM_BOULDER3, .Boulder3
	db -1

.Boulder2:
	appear CIANWOODGYM_BOULDER4
	disappear CIANWOODGYM_BOULDER2
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_3
	iffalsefwd .Done
	sjumpfwd .BlockWaterfall

.Boulder3:
	appear CIANWOODGYM_BOULDER5
	disappear CIANWOODGYM_BOULDER3
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_2
	iftruefwd .BlockWaterfall
.Done:
	end

.BlockWaterfall:
	appear CIANWOODGYM_CHUCK1
	disappear CIANWOODGYM_CHUCK2
	applyonemovement PLAYER, step_end
	reanchormap
	pause 10
	playsound SFX_STRENGTH
	changeblock 12,  4, $98
	refreshmap
	pause 7
	changeblock 12,  4, $83
	changeblock 12,  6, $94
	refreshmap
	pause 7
	changeblock 12,  6, $95
	refreshmap
	pause 7
	changeblock 12,  6, $96
	refreshmap
	pause 7
	changeblock 12,  6, $97
	refreshmap
	pause 7
	changeblock 12,  6, $7d
	changeblock 12,  8, $94
	refreshmap
	pause 7
	changeblock 12,  8, $95
	refreshmap
	pause 7
	changeblock 12,  8, $96
	refreshmap
	pause 7
	changeblock 12,  8, $97
	refreshmap
	pause 7
	changeblock 12,  8, $7d
	changeblock 12, 10, $8f
	refreshmap
	jumpthistext

	text "The boulders"
	line "blocked the"
	cont "waterfall!"
	done

CianwoodGymChuckScript:
	faceplayer
	opentext
	checkevent EVENT_BEAT_CHUCK
	iftruefwd .FightDone
	writetext ChuckIntroText1
	waitbutton
	closetext
	turnobject CIANWOODGYM_CHUCK1, RIGHT
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
	givebadge STORMBADGE, JOHTO_REGION
	specialphonecall SPECIALCALL_YELLOWFOREST
.FightDone:
	checkevent EVENT_GOT_TM01_DYNAMICPUNCH
	iftrue_jumpopenedtext ChuckAfterText
	setevent EVENT_BEAT_BLACKBELT_YOSHI
	setevent EVENT_BEAT_BLACKBELT_LAO
	setevent EVENT_BEAT_BLACKBELT_NOB
	setevent EVENT_BEAT_BLACKBELT_LUNG
	writetext ChuckExplainBadgeText
	promptbutton
	verbosegivetmhm TM_DYNAMICPUNCH
	setevent EVENT_GOT_TM01_DYNAMICPUNCH
	jumpthisopenedtext

	text "That is Dynamic-"
	line "Punch."

	para "It doesn't always"
	line "hit, but when it"

	para "does, it causes"
	line "confusion!"
	done

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
	gettrainername CHUCK, 1, STRING_BUFFER_4
	checkflag ENGINE_STORMBADGE
	iftruefwd .Beaten
	jumpstd gymstatue1
.Beaten:
	readvar VAR_BADGES
	ifgreater 12, .LyraToo
	jumpstd gymstatue2
.LyraToo
	jumpstd gymstatue3

CianwoodGymMovement_ChuckChucksBoulder:
	fix_facing
	set_sliding
	run_step_left
	run_step_up
	fast_jump_step_right
	remove_sliding
	remove_fixed_facing
	step_end

ChuckIntroText1:
	text "WARRGH!"

	para "The water pound-"
	line "ing right onto my"
	cont "head…"

	para "Why did you stop"
	line "the waterfall?"

	para "You just spoiled"
	line "my training!"

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

ChuckExplainBadgeText:
	text "The Storm Badge"
	line "lets your #mon"

	para "Fly to any city"
	line "or town you've"
	cont "already been to."

	para "Here, take this"
	line "too!"
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

BlackbeltNobBeatenText: ; text > text
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

CianwoodGymChuckTrainingText:
	text "He's so into his"
	line "training that he"
	cont "doesn't notice you."
	done

CianwoodGymBoulderText:
	text "The boulder is"
	line "blocking the"
	cont "waterfall."
	done

CianwoodGymChucksBoulderText:
	text "The boulder is"
	line "too heavy to move."
	done
