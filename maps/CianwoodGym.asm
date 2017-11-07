CianwoodGym_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

CianwoodGym_MapEventHeader:

.Warps: db 2
	warp_def 17, 4, 2, CIANWOOD_CITY
	warp_def 17, 5, 2, CIANWOOD_CITY

.XYTriggers: db 0

.Signposts: db 2
	signpost 15, 3, SIGNPOST_READ, CianwoodGymStatue
	signpost 15, 6, SIGNPOST_READ, CianwoodGymStatue

.PersonEvents: db 10
	person_event SPRITE_CHUCK, 1, 4, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_SCRIPT, 0, ChuckScript_0x9d60f, -1
	strengthboulder_event 1, 5
	person_event SPRITE_BLACK_BELT, 12, 2, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_TRAINER, 3, TrainerBlackbeltYoshi, -1
	person_event SPRITE_BLACK_BELT, 12, 7, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_TRAINER, 3, TrainerBlackbeltLao, -1
	person_event SPRITE_BLACK_BELT, 9, 3, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_TRAINER, 2, TrainerBlackbeltNob, -1
	person_event SPRITE_BLACK_BELT, 5, 5, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_TRAINER, 1, TrainerBlackbeltLung, -1
	person_event SPRITE_BLACK_BELT, 15, 7, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_COMMAND, jumptextfaceplayer, CianwoodGymBlackBeltText, -1
	strengthboulder_event 7, 3
	strengthboulder_event 7, 4
	strengthboulder_event 7, 5

const_value set 1
	const CIANWOODGYM_CHUCK
	const CIANWOODGYM_BOULDER1

ChuckScript_0x9d60f:
	faceplayer
	opentext
	checkevent EVENT_BEAT_CHUCK
	iftrue .FightDone
	writetext ChuckIntroText1
	waitbutton
	closetext
	spriteface CIANWOODGYM_CHUCK, RIGHT
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

TrainerBlackbeltYoshi:
	trainer EVENT_BEAT_BLACKBELT_YOSHI, BLACKBELT_T, YOSHI, BlackbeltYoshiSeenText, BlackbeltYoshiBeatenText, 0, .Script

.Script:
	end_if_just_battled
	jumptextfaceplayer BlackbeltYoshiAfterText

TrainerBlackbeltLao:
	trainer EVENT_BEAT_BLACKBELT_LAO, BLACKBELT_T, LAO, BlackbeltLaoSeenText, BlackbeltLaoBeatenText, 0, .Script

.Script:
	end_if_just_battled
	jumptextfaceplayer BlackbeltLaoAfterText

TrainerBlackbeltNob:
	trainer EVENT_BEAT_BLACKBELT_NOB, BLACKBELT_T, NOB, BlackbeltNobSeenText, BlackbeltNobBeatenText, 0, .Script

.Script:
	end_if_just_battled
	jumptextfaceplayer BlackbeltNobAfterText

TrainerBlackbeltLung:
	trainer EVENT_BEAT_BLACKBELT_LUNG, BLACKBELT_T, LUNG, BlackbeltLungSeenText, BlackbeltLungBeatenText, 0, .Script

.Script:
	end_if_just_battled
	jumptextfaceplayer BlackbeltLungAfterText

CianwoodGymStatue:
	trainertotext CHUCK, 1, $1
	checkflag ENGINE_STORMBADGE
	iftrue .Beaten
	jumpstd gymstatue1
.Beaten:
	checkcode VAR_BADGES
	if_greater_than 12, .LyraToo
	jumpstd gymstatue2
.LyraToo
	jumpstd gymstatue3

CianwoodGymMovement_ChuckChucksBoulder:
	set_sliding
	big_step_left
	big_step_up
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

BlackbeltYoshiAfterText:
	text "You seem to have a"
	line "strong bond with"
	cont "your #mon too!"
	done

BlackbeltLaoSeenText:
	text "We martial artists"
	line "fear nothing!"
	done

BlackbeltLaoBeatenText:
	text "That's shocking!"
	done

BlackbeltLaoAfterText:
	text "Fighting #mon"
	line "are afraid of psy-"
	cont "chics…"
	done

BlackbeltNobSeenText:
	text "Words are useless."
	line "Let your fists do"
	cont "the talking!"
	done

BlackbeltNobBeatenText:
	text "…"
	done

BlackbeltNobAfterText:
	text "I lost!"
	line "I'm speechless!"
	done

BlackbeltLungSeenText:
	text "My raging fists"
	line "will shatter your"
	cont "#mon!"
	done

BlackbeltLungBeatenText:
	text "I got shattered!"
	done

BlackbeltLungAfterText:
	text "My #mon lost…"
	line "My… my pride is"
	cont "shattered…"
	done

CianwoodGymBlackBeltText:
	text "The Gym guide is"
	line "too scared of us"
	cont "to stay here."

	para "What a wimp!"
	done
