EcruteakGym_MapScriptHeader:

.MapTriggers: db 1
	dw EcruteakGymTrigger0

.MapCallbacks: db 0

EcruteakGym_MapEventHeader:

.Warps: db 33
	warp_def 17, 4, 10, ECRUTEAK_CITY
	warp_def 17, 5, 10, ECRUTEAK_CITY
	warp_def 14, 4, 4, ECRUTEAK_GYM
	warp_def 4, 2, 3, ECRUTEAK_GYM
	warp_def 4, 3, 3, ECRUTEAK_GYM
	warp_def 4, 4, 3, ECRUTEAK_GYM
	warp_def 5, 4, 3, ECRUTEAK_GYM
	warp_def 7, 6, 3, ECRUTEAK_GYM
	warp_def 4, 7, 3, ECRUTEAK_GYM
	warp_def 6, 2, 3, ECRUTEAK_GYM
	warp_def 6, 3, 3, ECRUTEAK_GYM
	warp_def 6, 4, 3, ECRUTEAK_GYM
	warp_def 6, 5, 3, ECRUTEAK_GYM
	warp_def 6, 7, 3, ECRUTEAK_GYM
	warp_def 7, 7, 3, ECRUTEAK_GYM
	warp_def 8, 4, 3, ECRUTEAK_GYM
	warp_def 8, 5, 3, ECRUTEAK_GYM
	warp_def 8, 6, 3, ECRUTEAK_GYM
	warp_def 8, 7, 3, ECRUTEAK_GYM
	warp_def 8, 2, 3, ECRUTEAK_GYM
	warp_def 9, 2, 3, ECRUTEAK_GYM
	warp_def 10, 2, 3, ECRUTEAK_GYM
	warp_def 11, 2, 3, ECRUTEAK_GYM
	warp_def 10, 4, 3, ECRUTEAK_GYM
	warp_def 10, 5, 3, ECRUTEAK_GYM
	warp_def 12, 2, 3, ECRUTEAK_GYM
	warp_def 12, 3, 3, ECRUTEAK_GYM
	warp_def 12, 4, 3, ECRUTEAK_GYM
	warp_def 12, 5, 3, ECRUTEAK_GYM
	warp_def 10, 7, 3, ECRUTEAK_GYM
	warp_def 11, 7, 3, ECRUTEAK_GYM
	warp_def 12, 7, 3, ECRUTEAK_GYM
	warp_def 13, 7, 3, ECRUTEAK_GYM

.XYTriggers: db 0

.Signposts: db 2
	signpost 15, 3, SIGNPOST_READ, EcruteakGymStatue
	signpost 15, 6, SIGNPOST_READ, EcruteakGymStatue

.PersonEvents: db 7
	person_event SPRITE_GRAMPS, 14, 4, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_SCRIPT, 0, ObjectEvent, EVENT_ECRUTEAK_GYM_GRAMPS
	person_event SPRITE_MORTY, 1, 5, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_SCRIPT, 0, MortyScript_0x99d58, -1
	person_event SPRITE_SAGE, 7, 2, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_TRAINER, 1, TrainerSageJeffrey, -1
	person_event SPRITE_SAGE, 13, 3, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_TRAINER, 3, TrainerSagePing, -1
	person_event SPRITE_GRANNY, 5, 7, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_TRAINER, 1, TrainerMediumMartha, -1
	person_event SPRITE_GRANNY, 9, 7, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_TRAINER, 1, TrainerMediumGrace, -1
	person_event SPRITE_GYM_GUY, 15, 7, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, EcruteakGymGuyScript, -1

const_value set 1
	const ECRUTEAKGYM_GRAMPS

EcruteakGymTrigger0:
	priorityjump UnknownScript_0x99dc6
	end

MortyScript_0x99d58:
	faceplayer
	opentext
	checkevent EVENT_BEAT_MORTY
	iftrue .FightDone
	writetext UnknownText_0x99e65
	waitbutton
	closetext
	winlosstext UnknownText_0x9a00a, 0
	loadtrainer MORTY, 1
	startbattle
	reloadmapafterbattle
	setevent EVENT_BEAT_MORTY
	opentext
	writetext UnknownText_0x9a043
	playsound SFX_GET_BADGE
	waitsfx
	setflag ENGINE_FOGBADGE
	domaptrigger ECRUTEAK_HOUSE, $1
	setevent EVENT_RANG_CLEAR_BELL_1
	setevent EVENT_RANG_CLEAR_BELL_2
.FightDone:
	checkevent EVENT_GOT_TM30_SHADOW_BALL
	iftrue UnknownScript_0x99db1
	setevent EVENT_BEAT_SAGE_JEFFREY
	setevent EVENT_BEAT_SAGE_PING
	setevent EVENT_BEAT_MEDIUM_MARTHA
	setevent EVENT_BEAT_MEDIUM_GRACE
	writetext UnknownText_0x9a059
	buttonsound
	verbosegivetmhm TM_SHADOW_BALL
	setevent EVENT_GOT_TM30_SHADOW_BALL
	jumpopenedtext UnknownText_0x9a0ec

UnknownScript_0x99db1:
	jumpopenedtext UnknownText_0x9a145

UnknownScript_0x99dc6:
	applyonemovement PLAYER, step_up
	applyonemovement ECRUTEAKGYM_GRAMPS, slow_step_down
	showtext UnknownText_0x9a49c
	follow PLAYER, ECRUTEAKGYM_GRAMPS
	applymovement PLAYER, MovementData_0x99e5f
	stopfollow
	special FadeOutPalettes
	playsound SFX_ENTER_DOOR
	waitsfx
	warp ECRUTEAK_CITY, 6, 27
	end

TrainerSageJeffrey:
	trainer EVENT_BEAT_SAGE_JEFFREY, SAGE, JEFFREY, SageJeffreySeenText, SageJeffreyBeatenText, 0, SageJeffreyScript

SageJeffreyScript:
	end_if_just_battled
	jumptextfaceplayer UnknownText_0x9a263

TrainerSagePing:
	trainer EVENT_BEAT_SAGE_PING, SAGE, PING, SagePingSeenText, SagePingBeatenText, 0, SagePingScript

SagePingScript:
	end_if_just_battled
	jumptextfaceplayer UnknownText_0x9a2b7

TrainerMediumMartha:
	trainer EVENT_BEAT_MEDIUM_MARTHA, MEDIUM, MARTHA, MediumMarthaSeenText, MediumMarthaBeatenText, 0, MediumMarthaScript

MediumMarthaScript:
	end_if_just_battled
	jumptextfaceplayer UnknownText_0x9a318

TrainerMediumGrace:
	trainer EVENT_BEAT_MEDIUM_GRACE, MEDIUM, GRACE, MediumGraceSeenText, MediumGraceBeatenText, 0, MediumGraceScript

MediumGraceScript:
	end_if_just_battled
	jumptextfaceplayer UnknownText_0x9a38a

EcruteakGymGuyScript:
	checkevent EVENT_BEAT_MORTY
	iftrue_jumptextfaceplayer EcruteakGymGuyWinText
	jumptextfaceplayer EcruteakGymGuyText

EcruteakGymStatue:
	trainertotext MORTY, 1, $1
	checkflag ENGINE_FOGBADGE
	iftrue .Beaten
	jumpstd gymstatue1
.Beaten:
	checkcode VAR_BADGES
	if_greater_than 11, .LyraToo
	jumpstd gymstatue2
.LyraToo
	jumpstd gymstatue3

MovementData_0x99e5f:
	fix_facing
	slow_step_down
	remove_fixed_facing
	step_end

UnknownText_0x99e65:
	text "Good of you to"
	line "have come."

	para "Here in Ecruteak,"
	line "#mon have been"
	cont "revered."

	para "It's said that a"
	line "rainbow-colored"

	para "#mon will come"
	line "down to appear"

	para "before a truly"
	line "powerful trainer."

	para "I believed that"
	line "tale, so I have"

	para "secretly trained"
	line "here all my life."

	para "As a result, I can"
	line "now see what"
	cont "others cannot."

	para "Just a bit more…"

	para "With a little"
	line "more, I could see"

	para "a future in which"
	line "I meet the #mon"
	cont "of rainbow colors."

	para "You're going to"
	line "help me reach that"
	cont "level!"
	done

UnknownText_0x9a00a:
	text "I'm not good"
	line "enough yet…"

	para "All right. This"
	line "Badge is yours."
	done

UnknownText_0x9a043:
	text "<PLAYER> received"
	line "the Fog Badge."
	done

UnknownText_0x9a059:
	text "By having the Fog"
	line "Badge, #mon up"

	para "to <LV>50 will obey"
	line "you."

	para "Also, #mon that"
	line "know Surf will be"

	para "able to use that"
	line "move anytime."

	para "I want you to have"
	line "this too."
	done

UnknownText_0x9a0ec:
	text "It's Shadow Ball."
	line "It causes damage"

	para "and may reduce"
	line "Spcl.Def."

	para "Use it if it"
	line "appeals to you."
	done

UnknownText_0x9a145:
	text "I see…"

	para "Your journey has"
	line "taken you to far-"
	cont "away places."

	para "And you have wit-"
	line "nessed much more"
	cont "than I."

	para "I envy you for"
	line "that…"
	done

SageJeffreySeenText:
	text "I spent the spring"
	line "with my #mon."

	para "Then summer, fall"
	line "and winter…"

	para "Then spring came"
	line "again. We have"

	para "lived together"
	line "for a long time."
	done

SageJeffreyBeatenText:
	text "Wins and losses, I"
	line "experienced both."
	done

UnknownText_0x9a263:
	text "Where did #mon"
	line "come from?"
	done

SagePingSeenText:
	text "Can you inflict"
	line "any damage on our"
	cont "#mon?"
	done

SagePingBeatenText:
	text "Ah! Well done!"
	done

UnknownText_0x9a2b7:
	text "We use only Ghost-"
	line "type #mon."

	para "No Normal-type"
	line "attack can harm"
	cont "them!"
	done

MediumMarthaSeenText:
	text "I shall win!"
	done

MediumMarthaBeatenText:
	text "I, I, I lost!"
	done

UnknownText_0x9a318:
	text "The one who wants"
	line "to win most--will!"
	done

MediumGraceSeenText:
	text "Stumped by our in-"
	line "visible floor?"

	para "Defeat me if you"
	line "want a hint!"
	done

MediumGraceBeatenText:
	text "Wha-what?"
	done

UnknownText_0x9a38a:
	text "Fine. I shall tell"
	line "you the secret of"

	para "the invisible"
	line "floor."

	para "The path is right"
	line "before our eyes!"
	done

EcruteakGymGuyText:
	text "The trainers here"
	line "have secret mo-"
	cont "tives."

	para "If you win, they"
	line "may tell you some"

	para "deep secrets about"
	line "Ecruteak."
	done

EcruteakGymGuyWinText:
	text "Whew, <PLAYER>."
	line "You did great!"

	para "I was cowering in"
	line "the corner out of"
	cont "pure terror!"
	done

UnknownText_0x9a49c:
	text "Morty, the Gym"
	line "Leader, is absent."

	para "Sorry, but you'll"
	line "have to leave."

	para "Hohohoho."
	done
