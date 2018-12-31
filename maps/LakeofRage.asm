LakeofRage_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 3
	dbw MAPCALLBACK_NEWMAP, LakeofRageFlyPoint
	dbw MAPCALLBACK_OBJECTS, LakeofRageWesleyAndEngineer
	dbw MAPCALLBACK_TILES, LakeofRageFloodScript

LakeofRage_MapEventHeader:

.Warps: db 3
	warp_def 3, 7, 1, LAKE_OF_RAGE_HIDDEN_POWER_HOUSE
	warp_def 31, 27, 1, LAKE_OF_RAGE_MAGIKARP_HOUSE
	warp_def 28, 10, 1, HIDDEN_TREE_GROTTO

.XYTriggers: db 0

.Signposts: db 7
	signpost 27, 21, SIGNPOST_JUMPTEXT, LakeOfRageSignText
	signpost 31, 25, SIGNPOST_READ, LakeOfRageFishingGuruSign
	signpost 4, 4, SIGNPOST_ITEM + RARE_CANDY, EVENT_LAKE_OF_RAGE_HIDDEN_RARE_CANDY
	signpost 5, 35, SIGNPOST_ITEM + MAX_POTION, EVENT_LAKE_OF_RAGE_HIDDEN_MAX_POTION
	signpost 28, 11, SIGNPOST_ITEM + FULL_RESTORE, EVENT_LAKE_OF_RAGE_HIDDEN_FULL_RESTORE
	signpost 27, 10, SIGNPOST_JUMPSTD, treegrotto, HIDDENGROTTO_LAKE_OF_RAGE
	signpost 27, 11, SIGNPOST_JUMPSTD, treegrotto, HIDDENGROTTO_LAKE_OF_RAGE

.PersonEvents: db 17
	person_event SPRITE_LAKE_OF_RAGE_LANCE, 28, 21, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, LakeOfRageLanceScript, EVENT_LAKE_OF_RAGE_LANCE
	person_event SPRITE_BIG_GYARADOS, 22, 18, SPRITEMOVEDATA_BIG_GYARADOS, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, LakeOfRageRedGyaradosScript, EVENT_LAKE_OF_RAGE_RED_GYARADOS
	person_event SPRITE_SUPER_NERD, 4, 4, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, WesleyScript, EVENT_LAKE_OF_RAGE_WESLEY_OF_WEDNESDAY
	person_event SPRITE_COOLTRAINER_M, 15, 4, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_GENERICTRAINER, 1, GenericTrainerCooltrainermAaron, EVENT_LAKE_OF_RAGE_CIVILIANS
	person_event SPRITE_COOLTRAINER_F, 7, 36, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_GENERICTRAINER, 0, GenericTrainerCooltrainerfLois, EVENT_LAKE_OF_RAGE_CIVILIANS
	person_event SPRITE_FISHER, 23, 30, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_TRAINER, 1, TrainerFisherAndre, EVENT_LAKE_OF_RAGE_CIVILIANS
	person_event SPRITE_FISHER, 26, 24, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_TRAINER, 1, TrainerFisherRaymond, EVENT_LAKE_OF_RAGE_CIVILIANS
	person_event SPRITE_GRAMPS, 26, 20, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, LakeOfRageGrampsScript, -1
	person_event SPRITE_SUPER_NERD, 13, 36, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, PERSONTYPE_COMMAND, jumptextfaceplayer, LakeOfRageSuperNerdText, -1
	person_event SPRITE_COOLTRAINER_F, 29, 25, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, -1, 0, PERSONTYPE_COMMAND, jumptextfaceplayer, LakeOfRageCooltrainerFText, -1
	itemball_event 2, 13, ELIXER, 1, EVENT_LAKE_OF_RAGE_ELIXER
	itemball_event 10, 7, MAX_REVIVE, 1, EVENT_LAKE_OF_RAGE_MAX_REVIVE
	tmhmball_event 2, 35, TM_SUBSTITUTE, EVENT_LAKE_OF_RAGE_TM_SUBSTITUTE
	cuttree_event 9, 18, EVENT_LAKE_OF_RAGE_CUT_TREE_1
	cuttree_event 12, 11, EVENT_LAKE_OF_RAGE_CUT_TREE_2
	cuttree_event 14, 5, EVENT_LAKE_OF_RAGE_CUT_TREE_3
	cuttree_event 21, 6, EVENT_LAKE_OF_RAGE_CUT_TREE_4

const_value set 1
	const LAKEOFRAGE_LANCE
	const LAKEOFRAGE_RED_GYARADOS
	const LAKEOFRAGE_WESLEY

LakeofRageFlyPoint:
	setflag ENGINE_FLYPOINT_LAKE_OF_RAGE
	return

LakeofRageWesleyAndEngineer:
	checkevent EVENT_LAKE_OF_RAGE_CIVILIANS
	iftrue .NoEngineer
	moveperson LAKEOFRAGE_LANCE, 18, 29
.NoEngineer
	checkcode VAR_WEEKDAY
	if_equal WEDNESDAY, .WesleyAppears
	disappear LAKEOFRAGE_WESLEY
	return

.WesleyAppears:
	appear LAKEOFRAGE_WESLEY
	return

LakeofRageFloodScript:
	special Special_GetOvercastIndex
	if_equal LAKE_OF_RAGE_OVERCAST, .flood
	changemap LakeofRage_BlockData
	return

.flood
	changemap LakeofRageFlooded_BlockData
	return

LakeOfRageSignText:
	text "Lake of Rage,"
	line "also known as"
	cont "Gyarados Lake."
	done

LakeOfRageFishingGuruSign:
	opentext
	writetext .Text
	checkevent EVENT_CLEARED_ROCKET_HIDEOUT
	iftrue .Continue
	waitendtext

.Continue:
	buttonsound
	special Special_MagikarpHouseSign
	endtext

.Text:
	text "Fishing Guru's"
	line "House"
	done

LakeOfRageLanceScript:
	checkevent EVENT_LAKE_OF_RAGE_CIVILIANS
	iffalse_jumptextfaceplayer .EngineerText
	checkevent EVENT_REFUSED_TO_HELP_LANCE_AT_LAKE_OF_RAGE
	iftrue .AskForHelpAgain
	opentext
	writetext .OverheardText
	buttonsound
	faceplayer
	writetext .IntroText
	yesorno
	iffalse .Refused
.Agreed:
	writetext .YesText
	waitbutton
	closetext
	playsound SFX_WARP_TO
	applyonemovement LAKEOFRAGE_LANCE, teleport_from
	disappear LAKEOFRAGE_LANCE
	clearevent EVENT_MAHOGANY_MART_LANCE_AND_DRAGONITE
	setevent EVENT_DECIDED_TO_HELP_LANCE
	domaptrigger MAHOGANY_MART_1F, $1
	end

.Refused:
	setevent EVENT_REFUSED_TO_HELP_LANCE_AT_LAKE_OF_RAGE
	jumpopenedtext .Notext

.AskForHelpAgain:
	faceplayer
	opentext
	writetext .QuestionText
	yesorno
	iffalse .Refused
	jump .Agreed

.OverheardText:
	text "This lake is full"
	line "of Gyarados but"
	cont "nothing else…"

	para "So the Magikarp"
	line "are being forced"
	cont "to evolve…"
	done

.IntroText:
	text "Did you come here"
	line "because of the"
	cont "rumors?"

	para "You're <PLAYER>?"
	line "I'm Lance, a"
	cont "trainer like you."

	para "I heard some ru-"
	line "mors, so I came to"
	cont "investigate…"

	para "I saw the way you"
	line "battled earlier,"
	cont "<PLAYER>."

	para "I can tell that"
	line "you're a trainer"

	para "with considerable"
	line "skill."

	para "If you don't mind,"
	line "could you help me"
	cont "investigate?"
	done

.YesText:
	text "Lance: Excellent!"

	para "It seems that the"
	line "lake's Magikarp"

	para "are being forced"
	line "to evolve."

	para "A mysterious radio"
	line "broadcast coming"

	para "from Mahogany is"
	line "the cause."

	para "I'll be waiting"
	line "for you, <PLAYER>."
	done

.Notext:
	text "Oh… Well, if you"
	line "change your mind,"
	cont "please help me."
	done

.QuestionText:
	text "Lance: Hm? Are you"
	line "going to help me?"
	done

.EngineerText:
	text "I'm an urban"
	line "planner."

	para "I've got big ideas"
	line "for this place,"
	cont "just you wait!"

	para "It's the perfect"
	line "spot for my next"
	cont "project."
	done

LakeOfRageRedGyaradosScript:
	opentext
	writetext .GyaradosText
	cry GYARADOS
	pause 15
	closetext
	loadwildmon GYARADOS, 35
	writecode VAR_BATTLETYPE, BATTLETYPE_SHINY
	startbattle
	if_equal $1, .Continue
	disappear LAKEOFRAGE_RED_GYARADOS
.Continue:
	reloadmapafterbattle
	opentext
	giveitem RED_SCALE
	waitsfx
	writetext .RedScaleText
	playsound SFX_ITEM
	waitsfx
	itemnotify
	closetext
	dotrigger $0
	appear LAKEOFRAGE_LANCE
	end

.GyaradosText:
	text "Gyarados: Gyashaa!"
	done

.RedScaleText:
	text "<PLAYER> obtained a"
	line "Red Scale."
	done

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

TrainerFisherAndre:
	trainer EVENT_BEAT_FISHER_ANDRE, FISHER, ANDRE, FisherAndreSeenText, FisherAndreBeatenText, 0, FisherAndreScript

FisherAndreScript:
	end_if_just_battled
	jumptextfaceplayer UnknownText_0x7058f

FisherAndreSeenText:
	text "Let me battle with"
	line "the #mon I just"
	cont "caught!"
	done

FisherAndreBeatenText:
	text "I might be an ex-"
	line "pert angler, but"

	para "I stink as a #-"
	line "mon trainer…"
	done

UnknownText_0x7058f:
	text "I won't lose as an"
	line "angler! I catch"
	cont "#mon all day."
	done

TrainerFisherRaymond:
	trainer EVENT_BEAT_FISHER_RAYMOND, FISHER, RAYMOND, FisherRaymondSeenText, FisherRaymondBeatenText, 0, FisherRaymondScript

FisherRaymondScript:
	end_if_just_battled
	jumptextfaceplayer UnknownText_0x70611

FisherRaymondSeenText:
	text "No matter what I"
	line "do, all I catch"

	para "are the same #-"
	line "mon…"
	done

FisherRaymondBeatenText:
	text "My line's all"
	line "tangled up…"
	done

UnknownText_0x70611:
	text "Why can't I catch"
	line "any good #mon?"
	done

LakeOfRageGrampsScript:
	checkevent EVENT_CLEARED_ROCKET_HIDEOUT
	iftrue_jumptextfaceplayer .Text2
	thistextfaceplayer

	text "The Gyarados are"
	line "angry!"

	para "It's a bad omen!"
	done

.Text2:
	text "Hahah! The Magi-"
	line "karp are biting!"
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

LakeOfRageCooltrainerFText:
	text "Did my eyes de-"
	line "ceive me? I saw a"

	para "red Gyarados in"
	line "the lake…"

	para "But I thought"
	line "Gyarados were"
	cont "usually blue?"
	done
