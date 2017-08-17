OlivineGym_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

OlivineGym_MapEventHeader:

.Warps: db 2
	warp_def 15, 4, 2, OLIVINE_CITY
	warp_def 15, 5, 2, OLIVINE_CITY

.XYTriggers: db 0

.Signposts: db 2
	signpost 13, 3, SIGNPOST_READ, OlivineGymStatue
	signpost 13, 6, SIGNPOST_READ, OlivineGymStatue

.PersonEvents: db 4
	person_event SPRITE_JASMINE, 3, 5, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, JasmineScript_0x9c12f, EVENT_OLIVINE_GYM_JASMINE
	person_event SPRITE_GYM_GUY, 13, 7, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, OlivineGymGuyScript, -1
	person_event SPRITE_GENTLEMAN, 10, 3, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_TRAINER, 2, OlivineGymGentlemanPreston, EVENT_OLIVINE_GYM_JASMINE
	person_event SPRITE_LASS, 7, 6, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_TRAINER, 2, OlivineGymLassConnie, EVENT_OLIVINE_GYM_JASMINE

JasmineScript_0x9c12f:
	faceplayer
	opentext
	checkevent EVENT_BEAT_JASMINE
	iftrue .FightDone
	writetext UnknownText_0x9c1b9
	waitbutton
	closetext
	winlosstext UnknownText_0x9c2bb, 0
	loadtrainer JASMINE, 1
	startbattle
	reloadmapafterbattle
	setevent EVENT_BEAT_JASMINE
	clearevent EVENT_ROUTE_42_OFFICER
	domaptrigger ROUTE_42, $1
	opentext
	writetext UnknownText_0x9c33a
	playsound SFX_GET_BADGE
	waitsfx
	setflag ENGINE_MINERALBADGE
	callstd goldenrodrockets
.FightDone:
	checkevent EVENT_GOT_TM23_IRON_TAIL
	iftrue UnknownScript_0x9c172
	writetext UnknownText_0x9c354
	buttonsound
	verbosegivetmhm TM_IRON_TAIL
	setevent EVENT_GOT_TM23_IRON_TAIL
	jumpopenedtext UnknownText_0x9c3a5

UnknownScript_0x9c172:
	jumpopenedtext UnknownText_0x9c3d1

OlivineGymGuyScript:
	faceplayer
	checkevent EVENT_BEAT_JASMINE
	iftrue .OlivineGymGuyWinScript
	checkevent EVENT_JASMINE_RETURNED_TO_GYM
	iffalse .OlivineGymGuyPreScript
	jumptext OlivineGymGuyText

.OlivineGymGuyWinScript:
	jumptext OlivineGymGuyWinText

.OlivineGymGuyPreScript:
	jumptext OlivineGymGuyPreText

OlivineGymLassConnie:
	trainer EVENT_SPOKE_TO_LASS_CONNIE, 0, 0, OlivineGymLassConnieSeenText, 0, 0, OlivineGymLassConnieScript

OlivineGymLassConnieScript:
	end_if_just_battled
	faceplayer
	opentext
	checkevent EVENT_BEAT_JASMINE
	iftrue .BeatJasmine
	jumpopenedtext OlivineGymLassConnieSeenText

.BeatJasmine
	jumpopenedtext OlivineGymLassConnieAfterText

OlivineGymGentlemanPreston:
	trainer EVENT_SPOKE_TO_GENTLEMAN_PRESTON, 0, 0, OlivineGymGentlemanPrestonSeenText, 0, 0, OlivineGymGentlemanPrestonScript

OlivineGymGentlemanPrestonScript:
	end_if_just_battled
	faceplayer
	opentext
	checkevent EVENT_BEAT_JASMINE
	iftrue .BeatJasmine
	jumpopenedtext OlivineGymGentlemanPrestonSeenText

.BeatJasmine
	jumpopenedtext OlivineGymGentlemanPrestonAfterText

OlivineGymStatue:
	trainertotext JASMINE, 1, $1
	checkevent EVENT_JASMINE_RETURNED_TO_GYM
	iftrue .Returned
	jumpstd gymstatue0
.Returned
	checkflag ENGINE_MINERALBADGE
	iftrue .Beaten
	jumpstd gymstatue1
.Beaten
	checkcode VAR_BADGES
	if_greater_than 13, .LyraToo
	jumpstd gymstatue2
.LyraToo
	jumpstd gymstatue3

UnknownText_0x9c1b9:
	text "…Thank you for"
	line "your help at the"
	cont "Lighthouse…"

	para "But this is dif-"
	line "ferent. Please"

	para "allow me to intro-"
	line "duce myself."

	para "I am Jasmine, a"
	line "Gym Leader. I use"
	cont "the Steel-type."

	para "…Do you know about"
	line "the Steel-type?"

	para "They are very"
	line "hard, cold, sharp,"
	cont "and really strong."

	para "…Um… May I begin?"
	done

UnknownText_0x9c2bb:
	text "…You are a better"
	line "trainer than me,"

	para "in both skill and"
	line "kindness."

	para "In accordance with"
	line "League rules, I"

	para "confer upon you"
	line "this Badge."
	done

UnknownText_0x9c33a:
	text "<PLAYER> received"
	line "the Mineral Badge."
	done

UnknownText_0x9c354:
	text "With that Badge,"
	line "all #mon up"

	para "to <LV>70, even"
	line "traded ones, will"

	para "obey you without"
	line "question."

	para "…Um… Please take"
	line "this too…"
	done

UnknownText_0x9c3a5:
	text "…You could use"
	line "that TM to teach"
	cont "Iron Tail."
	done

UnknownText_0x9c3d1:
	text "Um… I don't know"
	line "how to say this,"
	cont "but good luck…"
	done

OlivineGymGuyText:
	text "Jasmine uses the"
	line "newly discovered"
	cont "Steel-type."

	para "I don't know very"
	line "much about it."
	done

OlivineGymGuyWinText:
	text "That was awesome."

	para "The Steel-type,"
	line "huh?"

	para "That was a close"
	line "encounter of an"
	cont "unknown kind!"
	done

OlivineGymGuyPreText:
	text "Jasmine, the Gym"
	line "Leader, is at the"
	cont "Lighthouse."

	para "She's been tending"
	line "to a sick #mon."

	para "A strong trainer"
	line "has to be compas-"
	cont "sionate."
	done

OlivineGymGentlemanPrestonSeenText:
	text "I knew you'd"
	line "come here."

	para "Thank you for"
	line "helping the"
	cont "Gym Leader,"

	para "but battle is a"
	line "separate matter."

	para "Go for it!"
	done

OlivineGymGentlemanPrestonAfterText:
	text "Impressive!"
	line "You should earn"

	para "more badges with"
	line "that much skill."
	done

OlivineGymLassConnieSeenText:
	text "Giggle… I know"
	line "how capable you"

	para "are from the"
	line "Lighthouse."

	para "It's time you"
	line "showed that to"
	cont "Jasmine!"

	para "Good luck!"
	done

OlivineGymLassConnieAfterText:
	text "You are amazing…"
	line "You should aim"

	para "even higher, with"
	line "such potential."

	para "Have you been to"
	line "Mahogany Town?"
	done
