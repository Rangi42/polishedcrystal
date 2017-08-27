LakeofRageSouth_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 1
	dbw MAPCALLBACK_NEWMAP, LakeofRageFlyPoint

LakeofRageSouth_MapEventHeader:

.Warps: db 2
	warp_def 15, 27, 1, LAKE_OF_RAGE_MAGIKARP_HOUSE
	warp_def 12, 10, 1, HIDDEN_TREE_GROTTO

.XYTriggers: db 0

.Signposts: db 5
	signpost 11, 21, SIGNPOST_JUMPTEXT, LakeOfRageSignText
	signpost 15, 25, SIGNPOST_READ, LakeOfRageFishingGuruSign
	signpost 12, 11, SIGNPOST_ITEM + FULL_RESTORE, EVENT_LAKE_OF_RAGE_HIDDEN_FULL_RESTORE
	signpost 11, 10, SIGNPOST_JUMPSTD, treegrotto, HIDDENGROTTO_LAKE_OF_RAGE_SOUTH
	signpost 11, 11, SIGNPOST_JUMPSTD, treegrotto, HIDDENGROTTO_LAKE_OF_RAGE_SOUTH

.PersonEvents: db 15
	person_event SPRITE_LANCE, 12, 21, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, LakeOfRageLanceScript, EVENT_LAKE_OF_RAGE_LANCE
	person_event SPRITE_GYARADOS_TOP_LEFT, 5, 18, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, LakeOfRageRedGyaradosScript, EVENT_LAKE_OF_RAGE_RED_GYARADOS
	person_event SPRITE_GYARADOS_TOP_RIGHT, 5, 19, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, LakeOfRageRedGyaradosScript, EVENT_LAKE_OF_RAGE_RED_GYARADOS
	person_event SPRITE_GYARADOS_BOTTOM_LEFT, 6, 18, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, LakeOfRageRedGyaradosScript, EVENT_LAKE_OF_RAGE_RED_GYARADOS
	person_event SPRITE_GYARADOS_BOTTOM_RIGHT, 6, 19, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, LakeOfRageRedGyaradosScript, EVENT_LAKE_OF_RAGE_RED_GYARADOS
	person_event SPRITE_GRAMPS, 10, 20, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, LakeOfRageGrampsScript, -1
	person_event SPRITE_FISHER, 7, 30, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_TRAINER, 1, TrainerFisherAndre, EVENT_LAKE_OF_RAGE_CIVILIANS
	person_event SPRITE_FISHER, 10, 24, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_TRAINER, 1, TrainerFisherRaymond, EVENT_LAKE_OF_RAGE_CIVILIANS
	person_event SPRITE_COOLTRAINER_M, -1, 4, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_GENERICTRAINER, 1, GenericTrainerCooltrainermAaron, EVENT_LAKE_OF_RAGE_CIVILIANS
	person_event SPRITE_ENGINEER, 13, 18, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, PERSONTYPE_COMMAND, jumptextfaceplayer, LakeofRageEngineerText, EVENT_LAKE_OF_RAGE_CIVILIANS
	person_event SPRITE_COOLTRAINER_F, 13, 25, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, -1, 0, PERSONTYPE_COMMAND, jumptextfaceplayer, LakeOfRageCooltrainerFText, -1
	person_event SPRITE_SUPER_NERD, -3, 36, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, PERSONTYPE_COMMAND, jumptextfaceplayer, LakeOfRageSuperNerdText, -1
	cuttree_event -4, 11, EVENT_LAKE_OF_RAGE_CUT_TREE_3
	cuttree_event -2, 5, EVENT_LAKE_OF_RAGE_CUT_TREE_4
	cuttree_event 5, 6, EVENT_LAKE_OF_RAGE_CUT_TREE_5

const_value set 2
	const LAKEOFRAGE_LANCE
	const LAKEOFRAGE_GYARADOS_TOP_LEFT
	const LAKEOFRAGE_GYARADOS_TOP_RIGHT
	const LAKEOFRAGE_GYARADOS_BOTTOM_LEFT
	const LAKEOFRAGE_GYARADOS_BOTTOM_RIGHT

LakeofRageFlyPoint:
	setflag ENGINE_FLYPOINT_LAKE_OF_RAGE
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
	disappear LAKEOFRAGE_GYARADOS_TOP_LEFT
	disappear LAKEOFRAGE_GYARADOS_TOP_RIGHT
	disappear LAKEOFRAGE_GYARADOS_BOTTOM_LEFT
	disappear LAKEOFRAGE_GYARADOS_BOTTOM_RIGHT
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

LakeOfRageCooltrainerFText:
	text "Did my eyes de-"
	line "ceive me? I saw a"

	para "red Gyarados in"
	line "the lake…"

	para "But I thought"
	line "Gyarados were"
	cont "usually blue?"
	done
