LakeofRageNorth_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 1
	dbw MAPCALLBACK_OBJECTS, LakeofRageWesley

LakeofRageNorth_MapEventHeader:

.Warps: db 1
	warp_def 3, 7, 1, LAKE_OF_RAGE_HIDDEN_POWER_HOUSE

.XYTriggers: db 0

.Signposts: db 2
	signpost 4, 4, SIGNPOST_ITEM + RARE_CANDY, EVENT_LAKE_OF_RAGE_HIDDEN_RARE_CANDY
	signpost 5, 35, SIGNPOST_ITEM + MAX_POTION, EVENT_LAKE_OF_RAGE_HIDDEN_MAX_POTION

.PersonEvents: db 11
	person_event SPRITE_SUPER_NERD, 4, 4, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, WesleyScript, EVENT_LAKE_OF_RAGE_WESLEY_OF_WEDNESDAY
	person_event SPRITE_COOLTRAINER_M, 15, 4, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_GENERICTRAINER, 1, GenericTrainerCooltrainermAaron, EVENT_LAKE_OF_RAGE_CIVILIANS
	person_event SPRITE_COOLTRAINER_F, 7, 36, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_GENERICTRAINER, 0, GenericTrainerCooltrainerfLois, EVENT_LAKE_OF_RAGE_CIVILIANS
	person_event SPRITE_SUPER_NERD, 13, 36, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, PERSONTYPE_COMMAND, jumptextfaceplayer, LakeOfRageSuperNerdText, -1
	itemball_event 2, 35, ELIXER, 1, EVENT_LAKE_OF_RAGE_ELIXER
	itemball_event 10, 7, MAX_REVIVE, 1, EVENT_LAKE_OF_RAGE_MAX_REVIVE
	tmhmball_event 2, 13, TM_SUBSTITUTE, EVENT_LAKE_OF_RAGE_TM_SUBSTITUTE
	cuttree_event 4, 23, EVENT_LAKE_OF_RAGE_CUT_TREE_1
	cuttree_event 9, 18, EVENT_LAKE_OF_RAGE_CUT_TREE_2
	cuttree_event 12, 11, EVENT_LAKE_OF_RAGE_CUT_TREE_3
	cuttree_event 14, 5, EVENT_LAKE_OF_RAGE_CUT_TREE_4

const_value set 2
	const LAKEOFRAGE_WESLEY

LakeofRageWesley:
	checkcode VAR_WEEKDAY
	if_equal WEDNESDAY, .WesleyAppears
	disappear LAKEOFRAGE_WESLEY
	return

.WesleyAppears:
	appear LAKEOFRAGE_WESLEY
	return

WesleyScript:
	checkevent EVENT_GOT_BLACK_BELT_FROM_WESLEY
	iftrue_jumptextfaceplayer .WednesdayText
	checkcode VAR_WEEKDAY
	if_not_equal WEDNESDAY, .NotWednesday
	faceplayer
	opentext
	checkevent EVENT_MET_WESLEY_OF_WEDNESDAY
	iftrue .MetWesley
	writetext .MeetText
	buttonsound
	setevent EVENT_MET_WESLEY_OF_WEDNESDAY
.MetWesley:
	writetext .GivesGiftText
	buttonsound
	verbosegiveitem BLACK_BELT
	iffalse_endtext
	setevent EVENT_GOT_BLACK_BELT_FROM_WESLEY
	thisopenedtext

	text "Wesley: Black Belt"
	line "beefs up the power"
	cont "of Fighting moves."
	done

.NotWednesday:
	thisopenedtext

	text "Wesley: Today's"
	line "not Wednesday."
	cont "That's too bad."
	done

.MeetText:
	text "Wesley: Well, how"
	line "do you do?"

	para "Seeing as how it's"
	line "Wednesday today,"

	para "I'm Wesley of"
	line "Wednesday."
	done

.GivesGiftText:
	text "Pleased to meet"
	line "you. Please take a"
	cont "souvenir."
	done

.WednesdayText:
	text "Wesley: Since you"
	line "found me, you must"

	para "have met my broth-"
	line "ers and sisters."

	para "Or did you just"
	line "get lucky?"
	done

GenericTrainerCooltrainermAaron:
	generictrainer EVENT_BEAT_COOLTRAINERM_AARON, COOLTRAINERM, AARON, .SeenText, .BeatenText

	text "#mon and their"
	line "trainer become"

	para "powerful through"
	line "constant battling."
	done

.SeenText:
	text "If a trainer spots"
	line "another trainer,"

	para "he has to make a"
	line "challenge."

	para "That is our"
	line "destiny."
	done

.BeatenText:
	text "Whew…"
	line "Good battle."
	done

GenericTrainerCooltrainerfLois:
	generictrainer EVENT_BEAT_COOLTRAINERF_LOIS, COOLTRAINERF, LOIS, .SeenText, .BeatenText

	text "Come to think of"
	line "it, I've seen a"
	cont "pink Butterfree."
	done

.SeenText:
	text "What happened to"
	line "the red Gyarados?"

	para "It's gone?"

	para "Oh, darn. I came"
	line "here for nothing?"

	para "I know--let's"
	line "battle!"
	done

.BeatenText:
	text "Good going!"
	done

LakeOfRageSuperNerdText:
	text "I heard this lake"
	line "was made by ram-"
	cont "paging Gyarados."

	para "I wonder if there"
	line "is any connection"

	para "to their mass out-"
	line "break now?"
	done
