OlsteetonUniClassroomArt_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  5,  9, OLSTEETON_UNI_CLASSROOM_BLDG, 4
	warp_event  6,  9, OLSTEETON_UNI_CLASSROOM_BLDG, 4

	def_coord_events

	def_bg_events
	bg_event  2,  0, BGEVENT_JUMPTEXT, OlsteetonUniClassroomArtBlackboardText
	bg_event  3,  0, BGEVENT_JUMPTEXT, OlsteetonUniClassroomArtBlackboardText
	bg_event  8,  0, BGEVENT_JUMPTEXT, OlsteetonUniClassroomArtBlackboardText
	bg_event  0,  1, BGEVENT_JUMPTEXT, OlsteetonUniClassroomArtBookshelf1Text
	bg_event  1,  1, BGEVENT_JUMPTEXT, OlsteetonUniClassroomArtBookshelf2Text

	def_object_events
	object_event  7,  2, SPRITE_IMAKUNI, SPRITEMOVEDATA_WANDER, 2, 1, -1, 0, OBJECTTYPE_SCRIPT, 0, OlsteetonUniClassroomArtImakuniScript, -1
	object_event  5,  2, SPRITE_ANDY, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, OlsteetonUniClassroomArtAndyText, -1
	object_event  3,  5, SPRITE_DRAGON_TAMER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, PAL_NPC_RED, OBJECTTYPE_COMMAND, jumptext, OlsteetonUniClassroomArtDragon_tamerText, -1
	object_event 10,  5, SPRITE_LADY, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, PAL_NPC_GREEN, OBJECTTYPE_COMMAND, jumptextfaceplayer, OlsteetonUniClassroomArtLadyText, -1
	object_event  8,  3, SPRITE_ARTIST, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, OlsteetonUniClassroomArtArtist1Text, -1
	object_event  3,  7, SPRITE_ARTIST, SPRITEMOVEDATA_STANDING_UP, 0, 0, (1 << MORN) | (1 << DAY), PAL_NPC_RED, OBJECTTYPE_COMMAND, jumptextfaceplayer, OlsteetonUniClassroomArtArtist2Text, -1
	object_event  9,  9, SPRITE_ARTIST, SPRITEMOVEDATA_STANDING_UP, 0, 0, (1 << EVE) | (1 << NITE), PAL_NPC_PURPLE, OBJECTTYPE_COMMAND, jumptextfaceplayer, OlsteetonUniClassroomArtArtist3Text, -1
	pokemon_event  6,  3, SMEARGLE, SPRITEMOVEDATA_POKEMON, -1, PAL_NPC_BROWN, OlsteetonUniSmeargleText, -1


	object_const_def
	const OlsteetonUniClassroomArt_IMAKUNI

OlsteetonUniClassroomArtImakuniScript:
	readvar VAR_FACING
	ifequalfwd UP, .Up
	ifequalfwd DOWN, .Down
	ifequalfwd LEFT, .Left
	turnobject OlsteetonUniClassroomArt_IMAKUNI, RIGHT
	sjumpfwd .Continue

.Up:
	turnobject OlsteetonUniClassroomArt_IMAKUNI, UP
	sjumpfwd .Continue

.Down:
	turnobject OlsteetonUniClassroomArt_IMAKUNI, DOWN
	sjumpfwd .Continue

.Left:
	turnobject OlsteetonUniClassroomArt_IMAKUNI, LEFT
.Continue:
	checkevent EVENT_BEAT_IMAKUNI
	iftruefwd .Beaten
	opentext
	writetext .Text1
	yesorno
	iffalse_jumpopenedtext .Text2
	writetext .Text3
	waitbutton
	closetext
	winlosstext .Text4, 0
	setlasttalked OlsteetonUniClassroomArt_IMAKUNI
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

OlsteetonUniClassroomArtAndyText:
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

OlsteetonUniClassroomArtDragon_tamerText:
	text "I've been holding"
	line "this pose for a"
	cont "while now."
	done

OlsteetonUniClassroomArtLadyText:
	text "You meet some"
	line "unique people in"
	cont "art class, but"

	para "that guy in the"
	line "black costume is"
	cont "really suspicious!"
	done

OlsteetonUniClassroomArtArtist1Text:
	text "It's tough getting"
	line "the folds of this"
	cont "cape just right."
	done

OlsteetonUniClassroomArtArtist2Text:
	text "Aah-choo!"

	para "Ugh. We just had a"
	line "flower-arranging"
	cont "seminar, but now"

	para "I can't stop"
	line "sneezing."

	para "I must be aller-"
	line "gic…"
	done

OlsteetonUniClassroomArtArtist3Text:
	text "I work a lot dur-"
	line "ing the day, so I"

	para "take classes in"
	line "the evenings."
	done

OlsteetonUniClassroomArtBlackboardText:
	text "There's a descrip-"
	line "tion of two-point"

	para "and three-point"
	line "perspective."
	done

OlsteetonUniClassroomArtBookshelf1Text:
	text "It's a book about"
	line "Smeargle, a"
	cont "#mon artist."

	para "It's full of beau-"
	line "tiful drawings."
	done

OlsteetonUniClassroomArtBookshelf2Text:
	text "It's a brochure"
	line "showcasing fine"
	cont "art from a place"

	para "called Lilycove"
	line "Museum."
	done

OlsteetonUniSmeargleText:
	text "Smeargle: Smeer!"
	done