const_value set 2
	const CELADONUNIVERSITYCLASSROOM1_IMAKUNI
	const CELADONUNIVERSITYCLASSROOM1_ANDY
	const CELADONUNIVERSITYCLASSROOM1_DRAGON_TAMER
	const CELADONUNIVERSITYCLASSROOM1_LADY
	const CELADONUNIVERSITYCLASSROOM1_ARTIST1
	const CELADONUNIVERSITYCLASSROOM1_ARTIST2
	const CELADONUNIVERSITYCLASSROOM1_ARTIST3

CeladonUniversityClassroom1_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

CeladonUniversityClassroom1ImakuniScript:
	faceplayer
	opentext
	checkevent EVENT_BEAT_IMAKUNI
	iftrue .Beaten
	writetext .Text1
	yesorno
	iffalse .NoBattle
	writetext .Text3
	waitbutton
	closetext
	winlosstext .Text4, 0
	setlasttalked CELADONUNIVERSITYCLASSROOM1_IMAKUNI
	loadtrainer IMAKUNI, 1
	startbattle
	reloadmapafterbattle
	setevent EVENT_BEAT_IMAKUNI
	opentext
.Beaten
	checkevent EVENT_GOT_PERSIM_BERRY_FROM_IMAKUNI
	iftrue .GotItem
	writetext .Text5
	buttonsound
	verbosegiveitem PERSIM_BERRY
	iffalse .Done
	setevent EVENT_GOT_PERSIM_BERRY_FROM_IMAKUNI
.GotItem:
	writetext .Text6
	waitbutton
.Done:
	closetext
	end

.NoBattle:
	writetext .Text2
	waitbutton
	closetext
	end

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

CeladonUniversityClassroom1AndyScript:
	jumptextfaceplayer .Text

.Text:
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

CeladonUniversityClassroom1Dragon_tamerScript:
	jumptextfaceplayer .Text

.Text:
	text "I've been holding"
	line "this pose for a"
	cont "while now."
	done

CeladonUniversityClassroom1LadyScript:
	jumptextfaceplayer .Text

.Text:
	text "You meet some"
	line "unique people in"
	cont "art class, but"

	para "that guy in the"
	line "black costume is"
	cont "really suspicious!"
	done

CeladonUniversityClassroom1Artist1Script:
	jumptextfaceplayer .Text

.Text:
	text "It's tough getting"
	line "the folds of this"
	cont "cape just right."
	done

CeladonUniversityClassroom1Artist2Script:
	jumptextfaceplayer .Text

.Text:
	text "Aah-choo!"

	para "Ugh. We just had a"
	line "flower-arranging"
	cont "seminar, but now"

	para "I can't stop"
	line "sneezing."

	para "I must be aller-"
	line "gic…"
	done

CeladonUniversityClassroom1Artist3Script:
	jumptextfaceplayer .Text

.Text:
	text "I work a lot dur-"
	line "ing the day, so I"

	para "take classes in"
	line "the evenings."
	done

CeladonUniversityClassroom1Blackboard:
	jumptext .Text

.Text:
	text "There's a descrip-"
	line "tion of two-point"

	para "and three-point"
	line "perspective."
	done

CeladonUniversityClassroom1Bookshelf1:
	jumptext .Text

.Text:
	text "It's a book about"
	line "Smeargle, a"
	cont "#mon artist."

	para "It's full of beau-"
	line "tiful drawings."
	done

CeladonUniversityClassroom1Bookshelf2:
	jumptext .Text

.Text:
	text "It's a brochure"
	line "showcasing fine"
	cont "art from a place"

	para "called Lilycove"
	line "Museum."
	done

CeladonUniversityClassroom1_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 2
	warp_def $b, $2, 6, CELADON_UNIVERSITY_1F
	warp_def $b, $3, 6, CELADON_UNIVERSITY_1F

.XYTriggers:
	db 0

.Signposts:
	db 5
	signpost 0, 2, SIGNPOST_READ, CeladonUniversityClassroom1Blackboard
	signpost 0, 3, SIGNPOST_READ, CeladonUniversityClassroom1Blackboard
	signpost 0, 4, SIGNPOST_READ, CeladonUniversityClassroom1Blackboard
	signpost 1, 6, SIGNPOST_READ, CeladonUniversityClassroom1Bookshelf1
	signpost 1, 7, SIGNPOST_READ, CeladonUniversityClassroom1Bookshelf2

.PersonEvents:
	db 7
	person_event SPRITE_IMAKUNI, 7, 0, SPRITEMOVEDATA_WALK_UP_DOWN, 1, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, CeladonUniversityClassroom1ImakuniScript, -1
	person_event SPRITE_ANDY, 2, 1, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, CeladonUniversityClassroom1AndyScript, -1
	person_event SPRITE_DRAGON_TAMER, 2, 5, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, CeladonUniversityClassroom1Dragon_tamerScript, -1
	person_event SPRITE_LADY, 5, 2, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_SCRIPT, 0, CeladonUniversityClassroom1LadyScript, -1
	person_event SPRITE_ARTIST, 5, 5, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, CeladonUniversityClassroom1Artist1Script, -1
	person_event SPRITE_ARTIST, 7, 4, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, (1 << MORN) | (1 << DAY), (1 << 3) | PAL_OW_PURPLE, PERSONTYPE_SCRIPT, 0, CeladonUniversityClassroom1Artist2Script, -1
	person_event SPRITE_ARTIST, 9, 3, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, (1 << NITE), (1 << 3) | PAL_OW_PURPLE, PERSONTYPE_SCRIPT, 0, CeladonUniversityClassroom1Artist3Script, -1
