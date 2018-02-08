OlivineGym_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 2 ; warp events
	warp_event  4, 15, OLIVINE_CITY, 2
	warp_event  5, 15, OLIVINE_CITY, 2

	db 0 ; coord events

	db 2 ; bg events
	bg_event  3, 13, SIGNPOST_READ, OlivineGymStatue
	bg_event  6, 13, SIGNPOST_READ, OlivineGymStatue

	db 4 ; object events
	object_event  5,  3, SPRITE_JASMINE, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, PERSONTYPE_SCRIPT, 0, JasmineScript_0x9c12f, EVENT_OLIVINE_GYM_JASMINE
	object_event  7, 13, SPRITE_GYM_GUY, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, PERSONTYPE_SCRIPT, 0, OlivineGymGuyScript, -1
	object_event  3, 10, SPRITE_GENTLEMAN, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_BLUE, PERSONTYPE_TRAINER, 2, OlivineGymGentlemanPreston, EVENT_OLIVINE_GYM_JASMINE
	object_event  6,  7, SPRITE_LASS, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_BLUE, PERSONTYPE_TRAINER, 2, OlivineGymLassConnie, EVENT_OLIVINE_GYM_JASMINE

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
	opentext
	writetext UnknownText_0x9c33a
	playsound SFX_GET_BADGE
	waitsfx
	setflag ENGINE_MINERALBADGE
	callstd goldenrodrockets
	setmapscene ROUTE_42, $1
	variablesprite SPRITE_NEW_BARK_TEACHER, SPRITE_POKEFAN_M
.FightDone:
	checkevent EVENT_GOT_TM23_IRON_TAIL
	iftrue_jumpopenedtext UnknownText_0x9c3d1
	writetext UnknownText_0x9c354
	buttonsound
	verbosegivetmhm TM_IRON_TAIL
	setevent EVENT_GOT_TM23_IRON_TAIL
	thisopenedtext

	text "…You could use"
	line "that TM to teach"
	cont "Iron Tail."
	done

OlivineGymGuyScript:
	checkevent EVENT_BEAT_JASMINE
	iftrue_jumptextfaceplayer OlivineGymGuyWinText
	checkevent EVENT_JASMINE_RETURNED_TO_GYM
	iffalse_jumptextfaceplayer OlivineGymGuyPreText
	thistextfaceplayer

	text "Jasmine uses the"
	line "newly discovered"
	cont "Steel-type."

	para "I don't know very"
	line "much about it."
	done

OlivineGymLassConnie:
	trainer 0, 0, EVENT_SPOKE_TO_LASS_CONNIE, .SeenText, 0, 0, .Script

.Script:
	end_if_just_battled
	checkevent EVENT_BEAT_JASMINE
	iftrue_jumptextfaceplayer .AfterText
	thistextfaceplayer

.SeenText:
	text "Giggle… I know"
	line "how capable you"

	para "are from the"
	line "Lighthouse."

	para "It's time you"
	line "showed that to"
	cont "Jasmine!"

	para "Good luck!"
	done

.AfterText:
	text "You are amazing…"
	line "You should aim"

	para "even higher, with"
	line "such potential."

	para "Have you been to"
	line "Mahogany Town?"
	done

OlivineGymGentlemanPreston:
	trainer 0, 0, EVENT_SPOKE_TO_GENTLEMAN_PRESTON, .SeenText, 0, 0, .Script

.Script:
	end_if_just_battled
	checkevent EVENT_BEAT_JASMINE
	iftrue_jumptextfaceplayer .AfterText
	thistextfaceplayer

.SeenText:
	text "I knew you'd"
	line "come here."

	para "Thank you for"
	line "helping the"
	cont "Gym Leader,"

	para "but battle is a"
	line "separate matter."

	para "Go for it!"
	done

.AfterText:
	text "Impressive!"
	line "You should earn"

	para "more badges with"
	line "that much skill."
	done

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
	ifgreater 13, .LyraToo
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

UnknownText_0x9c3d1:
	text "Um… I don't know"
	line "how to say this,"
	cont "but good luck…"
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
