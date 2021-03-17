CeladonUniversityPool_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  6,  9, CELADON_UNIVERSITY_2F, 6
	warp_event  7,  9, CELADON_UNIVERSITY_2F, 6

	def_coord_events

	def_bg_events

	def_object_events
	object_event 11,  5, SPRITE_SWIMMER_GUY, SPRITEMOVEDATA_SPINCLOCKWISE, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, CeladonUniversityPoolFergusScript, -1
	object_event  9,  1, SPRITE_CUTE_GIRL, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 2, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_COMMAND, jumptextfaceplayer, CeladonUniversityPoolLassText, -1
	object_event  4,  4, SPRITE_SWIMMER_GIRL, SPRITEMOVEDATA_SWIM_UP_DOWN, 1, 0, -1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, CeladonUniversityPoolSwimmer_girlText, -1
	object_event  3,  8, SPRITE_POKEFAN_F, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_COMMAND, jumptextfaceplayer, CeladonUniversityPoolTeacherText, -1
	itemball_event 12,  8, WATER_STONE, 1, EVENT_CELADON_UNIVERSITY_POOL_WATER_STONE

	object_const_def
	const CELADONUNIVERSITYPOOL_FERGUS

CeladonUniversityPoolFergusScript:
	faceplayer
	checkevent EVENT_BEAT_COOLTRAINERM_FERGUS
	iftrue .Beaten
	opentext
	checkevent EVENT_INTRODUCED_CELADON_FOUR
	iftrue .IntroducedCeladonFour1
	writetext .IntroText1
	sjump .AfterIntro
.IntroducedCeladonFour1
	writetext .IntroText2
.AfterIntro
	yesorno
	iffalse_jumpopenedtext .NoBattleText
	writetext .SeenText
	waitbutton
	closetext
	winlosstext .BeatenText, 0
	setlasttalked CELADONUNIVERSITYPOOL_FERGUS
	loadtrainer COOLTRAINERM, FERGUS
	startbattle
	reloadmapafterbattle
	setevent EVENT_BEAT_COOLTRAINERM_FERGUS
.Beaten
	opentext
	setevent EVENT_INTRODUCED_CELADON_FOUR
	checkevent EVENT_BEAT_COOLTRAINERM_COREY
	iffalse_jumpopenedtext .AfterText1
	checkevent EVENT_BEAT_COOLTRAINERM_RAYMOND
	iffalse_jumpopenedtext .AfterText1
	checkevent EVENT_BEAT_COOLTRAINERF_NEESHA
	iffalse_jumpopenedtext .AfterText1
	checkevent EVENT_GOT_CHOICE_BAND_FROM_CELADON_FOUR
	iftrue_jumpopenedtext .FinalText
	writetext .AfterText2
	promptbutton
	verbosegiveitem CHOICE_BAND
	iffalse_endtext
	setevent EVENT_GOT_CHOICE_BAND_FROM_CELADON_FOUR
	jumpopenedtext .FinalText

.IntroText1:
	text "The name's Fergus!"
	line "I'm one of top four"

	para "trainers at Cela-"
	line "don University."

	para "They call us the"
	line "Celadon Four!"

	para "I'll prove to you"
	line "that I earned my"
	cont "rep with a battle!"
	done

.IntroText2:
	text "The name's Fergus!"
	line "I'm one of the"
	cont "Celadon Four!"

	para "You're taking on"
	line "all four of us?"

	para "Well then, let's"
	line "battle!"
	done

.NoBattleText:
	text "Then don't get in"
	line "my way."
	done

.SeenText:
	text "We'll show you!"
	line "Let's go!"
	done

.BeatenText:
	text "No way!"
	done

.AfterText1:
	text "I've spent so much"
	line "time training my"
	cont "team, but you beat"
	cont "us anyway."

	para "With your power,"
	line "you should take on"

	para "the rest of the"
	line "Celadon Four!"
	done

.AfterText2:
	text "All of the Celadon"
	line "Four lost to you?"

	para "You really are"
	line "something!"

	para "You've earned this"
	line "reward!"
	done

.FinalText:
	text "The Celadon Four"
	line "are a big deal"
	cont "here, but you're"

	para "making waves in"
	line "the real world."

	para "Keep it up!"
	done

CeladonUniversityPoolLassText:
	text "Ouch!"

	para "I'm working out a"
	line "cramp in my leg."
	done

CeladonUniversityPoolSwimmer_girlText:
	text "I applied for a"
	line "special program to"

	para "study in the Sea-"
	line "foam Islands!"

	para "I need to be pre-"
	line "pared for intense"
	cont "swimming."
	done

CeladonUniversityPoolTeacherText:
	text "OK, five more"
	line "laps!"
	done

