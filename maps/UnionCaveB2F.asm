UnionCaveB2F_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 1
	dbw MAPCALLBACK_OBJECTS, UnionCaveB2FLapras

UnionCaveB2F_MapEventHeader:

.Warps: db 1
	warp_def 3, 5, 2, UNION_CAVE_B1F_SOUTH

.XYTriggers: db 0

.Signposts: db 0

.PersonEvents: db 6
	person_event SPRITE_LAPRAS, 31, 11, SPRITEMOVEDATA_SWIM_AROUND, 1, 1, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, UnionCaveLapras, EVENT_UNION_CAVE_B2F_LAPRAS
	person_event SPRITE_COOLTRAINER_M, 19, 15, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_TRAINER, 1, TrainerCooltrainermNick, -1
	person_event SPRITE_COOLTRAINER_F, 13, 5, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_TRAINER, 1, TrainerCooltrainerfGwen, -1
	person_event SPRITE_COOLTRAINER_F, 30, 3, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_TRAINER, 3, TrainerCooltrainerfEmma, -1
	itemball_event 2, 16, ELIXER, 1, EVENT_UNION_CAVE_B2F_ELIXER
	itemball_event 19, 12, HYPER_POTION, 1, EVENT_UNION_CAVE_B2F_HYPER_POTION

const_value set 1
	const UNIONCAVEB2F_LAPRAS

UnionCaveB2FLapras:
	checkflag ENGINE_UNION_CAVE_LAPRAS
	iftrue .NoAppear
	checkcode VAR_WEEKDAY
	if_equal FRIDAY, .Appear
.NoAppear:
	disappear UNIONCAVEB2F_LAPRAS
	return

.Appear:
	appear UNIONCAVEB2F_LAPRAS
	return

UnionCaveLapras:
	faceplayer
	cry LAPRAS
	loadwildmon LAPRAS, 25
	startbattle
	disappear UNIONCAVEB2F_LAPRAS
	setflag ENGINE_UNION_CAVE_LAPRAS
	reloadmapafterbattle
	end

TrainerCooltrainermNick:
	trainer EVENT_BEAT_COOLTRAINERM_NICK, COOLTRAINERM, NICK, CooltrainermNickSeenText, CooltrainermNickBeatenText, 0, CooltrainermNickScript

CooltrainermNickScript:
	end_if_just_battled
	jumptextfaceplayer UnknownText_0x5a3f0

TrainerCooltrainerfGwen:
	trainer EVENT_BEAT_COOLTRAINERF_GWEN, COOLTRAINERF, GWEN, CooltrainerfGwenSeenText, CooltrainerfGwenBeatenText, 0, CooltrainerfGwenScript

CooltrainerfGwenScript:
	end_if_just_battled
	jumptextfaceplayer UnknownText_0x5a488

TrainerCooltrainerfEmma:
	trainer EVENT_BEAT_COOLTRAINERF_EMMA, COOLTRAINERF, EMMA, CooltrainerfEmmaSeenText, CooltrainerfEmmaBeatenText, 0, CooltrainerfEmmaScript

CooltrainerfEmmaScript:
	end_if_just_battled
	jumptextfaceplayer UnknownText_0x5a52b

CooltrainermNickSeenText:
	text "There are two"
	line "kinds of people."

	para "Those who have"
	line "style, and those"
	cont "who don't."

	para "What kind of"
	line "person are you?"
	done

CooltrainermNickBeatenText:
	text "You've got"
	line "dazzling style!"
	done

UnknownText_0x5a3f0:
	text "Your #mon style"
	line "is stunning and"
	cont "colorful, I admit."

	para "You'll just keep"
	line "getting better!"
	done

CooltrainerfGwenSeenText:
	text "I'm in training."
	line "Care for a round?"
	done

CooltrainerfGwenBeatenText:
	text "Aww, no! You're"
	line "too good for me."
	done

UnknownText_0x5a488:
	text "I'm going to train"
	line "by myself until I"
	cont "improve."
	done

CooltrainerfEmmaSeenText:
	text "If the #mon I"
	line "liked were there,"
	cont "I'd go anywhere."

	para "That's what a real"
	line "trainer does."
	done

CooltrainerfEmmaBeatenText:
	text "I'd rather pet my"
	line "babies than this!"
	done

UnknownText_0x5a52b:
	text "Just once a week,"
	line "a #mon comes to"
	cont "the water's edge."

	para "I wanted to see"
	line "that #mon…"
	done
