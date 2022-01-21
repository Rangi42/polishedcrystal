CeladonUniversityClassroom1_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  2, 11, CELADON_UNIVERSITY_1F, 6
	warp_event  3, 11, CELADON_UNIVERSITY_1F, 6

	def_coord_events

	def_bg_events
	bg_event  2,  0, BGEVENT_JUMPTEXT, CeladonUniversityClassroom1BlackboardText
	bg_event  3,  0, BGEVENT_JUMPTEXT, CeladonUniversityClassroom1BlackboardText
	bg_event  4,  0, BGEVENT_JUMPTEXT, CeladonUniversityClassroom1BlackboardText
	bg_event  6,  1, BGEVENT_JUMPTEXT, CeladonUniversityClassroom1Bookshelf1Text
	bg_event  7,  1, BGEVENT_JUMPTEXT, CeladonUniversityClassroom1Bookshelf2Text

	def_object_events
	object_event  0,  6, SPRITE_IMAKUNI, SPRITEMOVEDATA_WANDER, 2, 1, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, CeladonUniversityClassroom1ImakuniScript, -1
	object_event  1,  2, SPRITE_ANDY, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, CeladonUniversityClassroom1AndyText, -1
	object_event  5,  2, SPRITE_DRAGON_TAMER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_COMMAND, jumptext, CeladonUniversityClassroom1Dragon_tamerText, -1
	object_event  2,  5, SPRITE_LADY, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_COMMAND, jumptextfaceplayer, CeladonUniversityClassroom1LadyText, -1
	object_event  5,  5, SPRITE_ARTIST, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, CeladonUniversityClassroom1Artist1Text, -1
	object_event  4,  7, SPRITE_ARTIST, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, (1 << MORN) | (1 << DAY), PAL_NPC_RED, OBJECTTYPE_COMMAND, jumptextfaceplayer, CeladonUniversityClassroom1Artist2Text, -1
	object_event  3,  9, SPRITE_ARTIST, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, (1 << EVE) | (1 << NITE), PAL_NPC_PURPLE, OBJECTTYPE_COMMAND, jumptextfaceplayer, CeladonUniversityClassroom1Artist3Text, -1

	object_const_def
	const CELADONUNIVERSITYCLASSROOM1_IMAKUNI

CeladonUniversityClassroom1ImakuniScript:
	readvar VAR_FACING
	ifequal UP, .Up
	ifequal DOWN, .Down
	ifequal LEFT, .Left
	turnobject CELADONUNIVERSITYCLASSROOM1_IMAKUNI, RIGHT
	sjump .Continue

.Up:
	turnobject CELADONUNIVERSITYCLASSROOM1_IMAKUNI, UP
	sjump .Continue

.Down:
	turnobject CELADONUNIVERSITYCLASSROOM1_IMAKUNI, DOWN
	sjump .Continue

.Left:
	turnobject CELADONUNIVERSITYCLASSROOM1_IMAKUNI, LEFT
.Continue:
	checkevent EVENT_BEAT_IMAKUNI
	iftrue .Beaten
	opentext
	writetext .Text1
	yesorno
	iffalse_jumpopenedtext .Text2
	writetext .Text3
	waitbutton
	closetext
	winlosstext .Text4, 0
	setlasttalked CELADONUNIVERSITYCLASSROOM1_IMAKUNI
	loadtrainer IMAKUNI, 1
	startbattle
	reloadmapafterbattle
	setevent EVENT_BEAT_IMAKUNI
.Beaten
	checkevent EVENT_GOT_PERSIM_BERRY_FROM_IMAKUNI
	iftrue_jumptext .Text6
	opentext
	writetext .Text5
	promptbutton
	verbosegiveitem PERSIM_BERRY
	iffalse_endtext
	setevent EVENT_GOT_PERSIM_BERRY_FROM_IMAKUNI
	jumpthisopenedtext

.Text6:
	text "In both battle and"
	line "dance, soul and"
	cont "rhythm are the"
	cont "secret."

	para "Hey, that sounds"
	line "pretty cool!"

	para "Maybe I'll become"
	line "a poet!"
	done

.Text1:
	text "Huh? W…Who are"
	line "you?"

	para "Who? Me? You don't"
	line "know who I am?"

	para "I am the super"
	line "musical star,"
	cont "Imakuni!"

	para "I'll sing the"
	line "#Rap--you"
	cont "dance!"

	para "♪ La di da di da,"
	line "La di da di da… ♪"

	para "Hey! Move those"
	line "feet!"

	para "What? #mon?"

	para "You want to"
	line "battle me?"
	done

.Text2:
	text "Come on, don't be"
	line "cruel!"

	para "You're going to"
	line "make me cry!"
	done

.Text3:
	text "OK, but if I win,"
	line "you dance!"
	done

.Text4:
	text "Even if I lost, is"
	line "it really so bad?"
	done

.Text5:
	text "Hey! You're pretty"
	line "good!"

	para "I'll give you this"
	line "Berry, so don't"

	para "tell anyone I"
	line "lost, OK?"
	done

CeladonUniversityClassroom1AndyText:
	text "Hello there!"
	line "I'm Prof.Andy,"

	para "and I teach what"
	line "I love--art!"

	para "Remember, draw"
	line "what you see,"

	para "not what you think"
	line "you see."

	para "Get past your pre-"
	line "conceptions about"
	cont "how things look."
	done

CeladonUniversityClassroom1Dragon_tamerText:
	text "I've been holding"
	line "this pose for a"
	cont "while now."
	done

CeladonUniversityClassroom1LadyText:
	text "You meet some"
	line "unique people in"
	cont "art class, but"

	para "that guy in the"
	line "black costume is"
	cont "really suspicious!"
	done

CeladonUniversityClassroom1Artist1Text:
	text "It's tough getting"
	line "the folds of this"
	cont "cape just right."
	done

CeladonUniversityClassroom1Artist2Text:
	text "Aah-choo!"

	para "Ugh. We just had a"
	line "flower-arranging"
	cont "seminar, but now"

	para "I can't stop"
	line "sneezing."

	para "I must be aller-"
	line "gic…"
	done

CeladonUniversityClassroom1Artist3Text:
	text "I work a lot dur-"
	line "ing the day, so I"

	para "take classes in"
	line "the evenings."
	done

CeladonUniversityClassroom1BlackboardText:
	text "There's a descrip-"
	line "tion of two-point"

	para "and three-point"
	line "perspective."
	done

CeladonUniversityClassroom1Bookshelf1Text:
	text "It's a book about"
	line "Smeargle, a"
	cont "#mon artist."

	para "It's full of beau-"
	line "tiful drawings."
	done

CeladonUniversityClassroom1Bookshelf2Text:
	text "It's a brochure"
	line "showcasing fine"
	cont "art from a place"

	para "called Lilycove"
	line "Museum."
	done
