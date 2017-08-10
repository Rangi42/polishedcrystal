LakeofRage_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 2
	dbw MAPCALLBACK_NEWMAP, LakeofRageFlyPoint
	dbw MAPCALLBACK_OBJECTS, LakeofRageWesley

LakeofRage_MapEventHeader:

.Warps: db 2
	warp_def $3, $7, 1, LAKE_OF_RAGE_HIDDEN_POWER_HOUSE
	warp_def $1f, $1b, 1, LAKE_OF_RAGE_MAGIKARP_HOUSE

.XYTriggers: db 0

.Signposts: db 6
	signpost 27, 21, SIGNPOST_READ, MapLakeofRageSignpost0Script
	signpost 31, 25, SIGNPOST_READ, MapLakeofRageSignpost1Script
	signpost 28, 11, SIGNPOST_ITEM, LakeofRageHiddenFullRestore
	signpost 4, 4, SIGNPOST_ITEM, LakeofRageHiddenRareCandy
	signpost 5, 35, SIGNPOST_ITEM, LakeofRageHiddenMaxPotion
	signpost 10, 7, SIGNPOST_ITEM, LakeofRageHiddenMaxRevive

.PersonEvents: db 15
	person_event SPRITE_LAKE_OF_RAGE_LANCE, 28, 21, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, LanceScript_0x70022, EVENT_LAKE_OF_RAGE_LANCE
	person_event SPRITE_GYARADOS_TOP_LEFT, 21, 18, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, GyaradosScript_0x70063, EVENT_LAKE_OF_RAGE_RED_GYARADOS
	person_event SPRITE_GYARADOS_TOP_RIGHT, 21, 19, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, GyaradosScript_0x70063, EVENT_LAKE_OF_RAGE_RED_GYARADOS
	person_event SPRITE_GYARADOS_BOTTOM_LEFT, 22, 18, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, GyaradosScript_0x70063, EVENT_LAKE_OF_RAGE_RED_GYARADOS
	person_event SPRITE_GYARADOS_BOTTOM_RIGHT, 22, 19, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, GyaradosScript_0x70063, EVENT_LAKE_OF_RAGE_RED_GYARADOS
	person_event SPRITE_SUPER_NERD, 4, 4, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, WesleyScript, EVENT_LAKE_OF_RAGE_WESLEY_OF_WEDNESDAY
	person_event SPRITE_GRAMPS, 26, 20, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, GrampsScript_0x7008e, -1
	person_event SPRITE_SUPER_NERD, 13, 36, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, SuperNerdScript_0x700a2, -1
	person_event SPRITE_COOLTRAINER_F, 29, 25, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, -1, 0, PERSONTYPE_SCRIPT, 0, CooltrainerFScript_0x700a5, -1
	person_event SPRITE_FISHER, 23, 30, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_TRAINER, 1, TrainerFisherAndre, EVENT_LAKE_OF_RAGE_CIVILIANS
	person_event SPRITE_FISHER, 26, 24, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_TRAINER, 1, TrainerFisherRaymond, EVENT_LAKE_OF_RAGE_CIVILIANS
	person_event SPRITE_COOLTRAINER_M, 15, 4, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_TRAINER, 1, TrainerCooltrainermAaron, EVENT_LAKE_OF_RAGE_CIVILIANS
	person_event SPRITE_COOLTRAINER_F, 7, 36, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_TRAINER, 0, TrainerCooltrainerfLois, EVENT_LAKE_OF_RAGE_CIVILIANS
	person_event SPRITE_BALL_CUT_FRUIT, 2, 35, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_ITEMBALL, 0, ELIXER, 1, EVENT_LAKE_OF_RAGE_ELIXER
	person_event SPRITE_BALL_CUT_FRUIT, 21, 6, SPRITEMOVEDATA_CUTTABLE_TREE, 0, 0, -1, -1, 0, PERSONTYPE_JUMPSTD, 0, cuttree, EVENT_LAKE_OF_RAGE_CUT_TREE

const_value set 2
	const LAKEOFRAGE_LANCE
	const LAKEOFRAGE_GYARADOS_TOP_LEFT
	const LAKEOFRAGE_GYARADOS_TOP_RIGHT
	const LAKEOFRAGE_GYARADOS_BOTTOM_LEFT
	const LAKEOFRAGE_GYARADOS_BOTTOM_RIGHT
	const LAKEOFRAGE_WESLEY

LakeofRageFlyPoint:
	setflag ENGINE_FLYPOINT_LAKE_OF_RAGE
	return

LakeofRageWesley:
	checkcode VAR_WEEKDAY
	if_equal WEDNESDAY, .WesleyAppears
	disappear LAKEOFRAGE_WESLEY
	return

.WesleyAppears:
	appear LAKEOFRAGE_WESLEY
	return

LanceScript_0x70022:
	checkevent EVENT_LAKE_OF_RAGE_CIVILIANS
	iffalse LakeofRageEngineerScript
	checkevent EVENT_REFUSED_TO_HELP_LANCE_AT_LAKE_OF_RAGE
	iftrue UnknownScript_0x70057
	opentext
	writetext UnknownText_0x70157
	buttonsound
	faceplayer
	writetext UnknownText_0x701b4
	yesorno
	iffalse UnknownScript_0x7004e
UnknownScript_0x70035:
	writetext UnknownText_0x702c6
	waitbutton
	closetext
	playsound SFX_WARP_TO
	applymovement LAKEOFRAGE_LANCE, MovementData_0x70155
	disappear LAKEOFRAGE_LANCE
	clearevent EVENT_MAHOGANY_MART_LANCE_AND_DRAGONITE
	setevent EVENT_DECIDED_TO_HELP_LANCE
	domaptrigger MAHOGANY_MART_1F, $1
	end

UnknownScript_0x7004e:
	writetext UnknownText_0x70371
	waitbutton
	closetext
	setevent EVENT_REFUSED_TO_HELP_LANCE_AT_LAKE_OF_RAGE
	end

UnknownScript_0x70057:
	faceplayer
	opentext
	writetext UnknownText_0x703a5
	yesorno
	iffalse UnknownScript_0x7004e
	jump UnknownScript_0x70035

LakeofRageEngineerScript:
	jumptextfaceplayer LakeofRageEngineerText

GyaradosScript_0x70063:
	opentext
	writetext UnknownText_0x703cb
	pause 15
	cry GYARADOS
	closetext
	loadwildmon GYARADOS, 35
	writecode VAR_BATTLETYPE, BATTLETYPE_SHINY
	startbattle
	if_equal $1, UnknownScript_0x7007a
	disappear LAKEOFRAGE_GYARADOS_TOP_LEFT
	disappear LAKEOFRAGE_GYARADOS_TOP_RIGHT
	disappear LAKEOFRAGE_GYARADOS_BOTTOM_LEFT
	disappear LAKEOFRAGE_GYARADOS_BOTTOM_RIGHT
UnknownScript_0x7007a:
	reloadmapafterbattle
	opentext
	giveitem RED_SCALE
	waitsfx
	writetext UnknownText_0x703df
	playsound SFX_ITEM
	waitsfx
	itemnotify
	closetext
	dotrigger $0
	appear LAKEOFRAGE_LANCE
	end

GrampsScript_0x7008e:
	faceplayer
	opentext
	checkevent EVENT_CLEARED_ROCKET_HIDEOUT
	iftrue UnknownScript_0x7009c
	writetext UnknownText_0x703f8
	waitbutton
	closetext
	end

UnknownScript_0x7009c:
	writetext UnknownText_0x70421
	waitbutton
	closetext
	end

SuperNerdScript_0x700a2:
	jumptextfaceplayer UnknownText_0x70444

CooltrainerFScript_0x700a5:
	jumptextfaceplayer UnknownText_0x704bb

MapLakeofRageSignpost0Script:
	jumptext UnknownText_0x708d7

MapLakeofRageSignpost1Script:
	opentext
	writetext UnknownText_0x70903
	checkevent EVENT_CLEARED_ROCKET_HIDEOUT
	iftrue UnknownScript_0x700b8
	waitbutton
	closetext
	end

UnknownScript_0x700b8:
	buttonsound
	special Special_MagikarpHouseSign
	closetext
	end

TrainerFisherAndre:
	trainer EVENT_BEAT_FISHER_ANDRE, FISHER, ANDRE, FisherAndreSeenText, FisherAndreBeatenText, 0, FisherAndreScript

FisherAndreScript:
	end_if_just_battled
	opentext
	writetext UnknownText_0x7058f
	waitbutton
	closetext
	end

TrainerFisherRaymond:
	trainer EVENT_BEAT_FISHER_RAYMOND, FISHER, RAYMOND, FisherRaymondSeenText, FisherRaymondBeatenText, 0, FisherRaymondScript

FisherRaymondScript:
	end_if_just_battled
	opentext
	writetext UnknownText_0x70611
	waitbutton
	closetext
	end

TrainerCooltrainermAaron:
	trainer EVENT_BEAT_COOLTRAINERM_AARON, COOLTRAINERM, AARON, CooltrainermAaronSeenText, CooltrainermAaronBeatenText, 0, CooltrainermAaronScript

CooltrainermAaronScript:
	end_if_just_battled
	opentext
	writetext UnknownText_0x7069c
	waitbutton
	closetext
	end

TrainerCooltrainerfLois:
	trainer EVENT_BEAT_COOLTRAINERF_LOIS, COOLTRAINERF, LOIS, CooltrainerfLoisSeenText, CooltrainerfLoisBeatenText, 0, CooltrainerfLoisScript

CooltrainerfLoisScript:
	end_if_just_battled
	opentext
	writetext UnknownText_0x70752
	waitbutton
	closetext
	end

WesleyScript:
	faceplayer
	opentext
	checkevent EVENT_GOT_BLACK_BELT_FROM_WESLEY
	iftrue WesleyWednesdayScript
	checkcode VAR_WEEKDAY
	if_not_equal WEDNESDAY, WesleyNotWednesdayScript
	checkevent EVENT_MET_WESLEY_OF_WEDNESDAY
	iftrue .MetWesley
	writetext MeetWesleyText
	buttonsound
	setevent EVENT_MET_WESLEY_OF_WEDNESDAY
.MetWesley:
	writetext WesleyGivesGiftText
	buttonsound
	verbosegiveitem BLACK_BELT
	iffalse WesleyDoneScript
	setevent EVENT_GOT_BLACK_BELT_FROM_WESLEY
	writetext WesleyGaveGiftText
	waitbutton
	closetext
	end

WesleyWednesdayScript:
	writetext WesleyWednesdayText
	waitbutton
WesleyDoneScript:
	closetext
	end

WesleyNotWednesdayScript:
	writetext WesleyNotWednesdayText
	waitbutton
	closetext
	end

LakeofRageHiddenFullRestore:
	dwb EVENT_LAKE_OF_RAGE_HIDDEN_FULL_RESTORE, FULL_RESTORE

LakeofRageHiddenRareCandy:
	dwb EVENT_LAKE_OF_RAGE_HIDDEN_RARE_CANDY, RARE_CANDY

LakeofRageHiddenMaxPotion:
	dwb EVENT_LAKE_OF_RAGE_HIDDEN_MAX_POTION, MAX_POTION

LakeofRageHiddenMaxRevive:
	dwb EVENT_LAKE_OF_RAGE_HIDDEN_MAX_REVIVE, MAX_REVIVE

MovementData_0x70155:
	teleport_from
	step_end

UnknownText_0x70157:
	text "This lake is full"
	line "of Gyarados but"
	cont "nothing else…"

	para "So the Magikarp"
	line "are being forced"
	cont "to evolve…"
	done

UnknownText_0x701b4:
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

UnknownText_0x702c6:
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

UnknownText_0x70371:
	text "Oh… Well, if you"
	line "change your mind,"
	cont "please help me."
	done

UnknownText_0x703a5:
	text "Lance: Hm? Are you"
	line "going to help me?"
	done

LakeofRageEngineerText:
	text "I'm an urban"
	line "planner."

	para "I've got big ideas"
	line "for this place,"
	cont "just you wait!"

	para "It's the perfect"
	line "spot for my next"
	cont "project."
	done

UnknownText_0x703cb:
	text "Gyarados: Gyashaa!"
	done

UnknownText_0x703df:
	text "<PLAYER> obtained a"
	line "Red Scale."
	done

UnknownText_0x703f8:
	text "The Gyarados are"
	line "angry!"

	para "It's a bad omen!"
	done

UnknownText_0x70421:
	text "Hahah! The Magi-"
	line "karp are biting!"
	done

UnknownText_0x70444:
	text "I heard this lake"
	line "was made by ram-"
	cont "paging Gyarados."

	para "I wonder if there"
	line "is any connection"

	para "to their mass out-"
	line "break now?"
	done

UnknownText_0x704bb:
	text "Did my eyes de-"
	line "ceive me? I saw a"

	para "red Gyarados in"
	line "the lake…"

	para "But I thought"
	line "Gyarados were"
	cont "usually blue?"
	done

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

CooltrainermAaronSeenText:
	text "If a trainer spots"
	line "another trainer,"

	para "he has to make a"
	line "challenge."

	para "That is our"
	line "destiny."
	done

CooltrainermAaronBeatenText:
	text "Whew…"
	line "Good battle."
	done

UnknownText_0x7069c:
	text "#mon and their"
	line "trainer become"

	para "powerful through"
	line "constant battling."
	done

CooltrainerfLoisSeenText:
	text "What happened to"
	line "the red Gyarados?"

	para "It's gone?"

	para "Oh, darn. I came"
	line "here for nothing?"

	para "I know--let's"
	line "battle!"
	done

CooltrainerfLoisBeatenText:
	text "Good going!"
	done

UnknownText_0x70752:
	text "Come to think of"
	line "it, I've seen a"
	cont "pink Butterfree."
	done

MeetWesleyText:
	text "Wesley: Well, how"
	line "do you do?"

	para "Seeing as how it's"
	line "Wednesday today,"

	para "I'm Wesley of"
	line "Wednesday."
	done

WesleyGivesGiftText:
	text "Pleased to meet"
	line "you. Please take a"
	cont "souvenir."
	done

WesleyGaveGiftText:
	text "Wesley: Black Belt"
	line "beefs up the power"
	cont "of Fighting moves."
	done

WesleyWednesdayText:
	text "Wesley: Since you"
	line "found me, you must"

	para "have met my broth-"
	line "ers and sisters."

	para "Or did you just"
	line "get lucky?"
	done

WesleyNotWednesdayText:
	text "Wesley: Today's"
	line "not Wednesday."
	cont "That's too bad."
	done

UnknownText_0x708d7:
	text "Lake of Rage,"
	line "also known as"
	cont "Gyarados Lake."
	done

UnknownText_0x70903:
	text "Fishing Guru's"
	line "House"
	done
