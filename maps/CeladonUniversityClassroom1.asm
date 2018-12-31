CeladonUniversityClassroom1_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

CeladonUniversityClassroom1_MapEventHeader:

.Warps: db 2
	warp_def 11, 2, 6, CELADON_UNIVERSITY_1F
	warp_def 11, 3, 6, CELADON_UNIVERSITY_1F

.XYTriggers: db 0

.Signposts: db 5
	signpost 0, 2, SIGNPOST_JUMPTEXT, CeladonUniversityClassroom1BlackboardText
	signpost 0, 3, SIGNPOST_JUMPTEXT, CeladonUniversityClassroom1BlackboardText
	signpost 0, 4, SIGNPOST_JUMPTEXT, CeladonUniversityClassroom1BlackboardText
	signpost 1, 6, SIGNPOST_JUMPTEXT, CeladonUniversityClassroom1Bookshelf1Text
	signpost 1, 7, SIGNPOST_JUMPTEXT, CeladonUniversityClassroom1Bookshelf2Text

.PersonEvents: db 7
	person_event SPRITE_IMAKUNI, 7, 0, SPRITEMOVEDATA_WALK_UP_DOWN, 1, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, CeladonUniversityClassroom1ImakuniScript, -1
	person_event SPRITE_ANDY, 2, 1, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, PERSONTYPE_COMMAND, jumptextfaceplayer, CeladonUniversityClassroom1AndyText, -1
	person_event SPRITE_DRAGON_TAMER, 2, 5, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_COMMAND, jumptextfaceplayer, CeladonUniversityClassroom1Dragon_tamerText, -1
	person_event SPRITE_LADY, 5, 2, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_COMMAND, jumptextfaceplayer, CeladonUniversityClassroom1LadyText, -1
	person_event SPRITE_ARTIST, 5, 5, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_COMMAND, jumptextfaceplayer, CeladonUniversityClassroom1Artist1Text, -1
	person_event SPRITE_ARTIST, 7, 4, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, (1 << MORN) | (1 << DAY), (1 << 3) | PAL_OW_PURPLE, PERSONTYPE_COMMAND, jumptextfaceplayer, CeladonUniversityClassroom1Artist2Text, -1
	person_event SPRITE_ARTIST, 9, 3, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, (1 << NITE), (1 << 3) | PAL_OW_PURPLE, PERSONTYPE_COMMAND, jumptextfaceplayer, CeladonUniversityClassroom1Artist3Text, -1

const_value set 1
	const CELADONUNIVERSITYCLASSROOM1_IMAKUNI

CeladonUniversityClassroom1ImakuniScript:
	faceplayer
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
	buttonsound
	verbosegiveitem PERSIM_BERRY
	iffalse_endtext
	setevent EVENT_GOT_PERSIM_BERRY_FROM_IMAKUNI
	thisopenedtext

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
