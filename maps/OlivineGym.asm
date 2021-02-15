OlivineGym_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  4, 15, OLIVINE_CITY, 2
	warp_event  5, 15, OLIVINE_CITY, 2

	def_coord_events

	def_bg_events
	bg_event  3, 13, BGEVENT_READ, OlivineGymStatue
	bg_event  6, 13, BGEVENT_READ, OlivineGymStatue

	def_object_events
	object_event  5,  3, SPRITE_JASMINE, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, OlivineGymJasmineScript, EVENT_OLIVINE_GYM_JASMINE
	object_event  7, 13, SPRITE_GYM_GUY, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, OlivineGymGuyScript, -1
	object_event  3, 10, SPRITE_GENTLEMAN, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_TRAINER, 2, OlivineGymGentlemanPreston, EVENT_OLIVINE_GYM_JASMINE
	object_event  6,  7, SPRITE_LASS, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, OBJECTTYPE_TRAINER, 2, OlivineGymLassConnie, EVENT_OLIVINE_GYM_JASMINE

OlivineGymJasmineScript:
	faceplayer
	opentext
	checkevent EVENT_BEAT_JASMINE
	iftrue .FightDone
	writetext Jasmine_SteelTypeIntro
	waitbutton
	closetext
	winlosstext Jasmine_BetterTrainer, 0
	loadtrainer JASMINE, 1
	startbattle
	reloadmapafterbattle
	setevent EVENT_BEAT_JASMINE
	opentext
	writetext Text_ReceivedMineralBadge
	playsound SFX_GET_BADGE
	waitsfx
	setflag ENGINE_MINERALBADGE
	clearevent EVENT_GOLDENROD_CITY_ROCKET_TAKEOVER
	setmapscene ROUTE_42, $1
.FightDone:
	checkevent EVENT_GOT_TM23_IRON_TAIL
	iftrue_jumpopenedtext Jasmine_GoodLuck
	writetext Jasmine_BadgeSpeech
	buttonsound
	verbosegivetmhm TM_IRON_TAIL
	setevent EVENT_GOT_TM23_IRON_TAIL
	jumpthisopenedtext

	text "…You could use"
	line "that TM to teach"
	cont "Iron Tail."
	done

OlivineGymGuyScript:
	checkevent EVENT_BEAT_JASMINE
	iftrue_jumptextfaceplayer OlivineGymGuyWinText
	checkevent EVENT_JASMINE_RETURNED_TO_GYM
	iffalse_jumptextfaceplayer OlivineGymGuyPreText
	jumpthistextfaceplayer

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
	jumpthistextfaceplayer

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
	jumpthistextfaceplayer

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

Jasmine_SteelTypeIntro:
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

Jasmine_BetterTrainer:
	text "…You are a better"
	line "trainer than me,"

	para "in both skill and"
	line "kindness."

	para "In accordance with"
	line "League rules, I"

	para "confer upon you"
	line "this Badge."
	done

Text_ReceivedMineralBadge:
	text "<PLAYER> received"
	line "the Mineral Badge."
	done

Jasmine_BadgeSpeech:
	text "With that Badge,"
	line "all #mon up"

	para "to <LV>70, even"
	line "traded ones, will"

	para "obey you without"
	line "question."

	para "…Um… Please take"
	line "this too…"
	done

Jasmine_GoodLuck:
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
