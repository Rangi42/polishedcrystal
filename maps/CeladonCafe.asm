CeladonCafe_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 2 ; warp events
	warp_event  6,  7, CELADON_CITY, 9
	warp_event  7,  7, CELADON_CITY, 9

	db 0 ; coord events

	db 2 ; bg events
	bg_event  5,  0, SIGNPOST_JUMPTEXT, EatathonContestPosterText
	bg_event  7,  1, SIGNPOST_JUMPTEXT, EatathonContestTrashCanText

	db 7 ; object events
	object_event  7,  4, SPRITE_MAYLENE, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, MayleneScript, -1
	object_event  4,  3, SPRITE_TEACHER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, TeacherScript_0x73084, -1
	object_event  4,  6, SPRITE_FISHER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, FisherScript_0x73051, -1
	object_event  1,  7, SPRITE_FISHER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_GREEN, PERSONTYPE_SCRIPT, 0, FisherScript_0x73062, -1
	object_event  1,  2, SPRITE_FISHER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, FisherScript_0x73073, -1
	object_event  9,  3, SPRITE_SUPER_NERD, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_BROWN, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x730de, -1
	object_event 11,  4, SPRITE_BAKER, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, 0, PERSONTYPE_COMMAND, jumptextfaceplayer, CeladonCafeBakerText, -1

	const_def 1 ; object constants
	const CELADONCAFE_MAYLENE
	const CELADONCAFE_TEACHER

MayleneScript:
	showtext MayleneText1
	faceplayer
	opentext
	writetext MayleneText2
	waitbutton
	checkevent EVENT_BEAT_MAYLENE
	iftrue .Done
	writetext MayleneText3
	yesorno
	iffalse .Refused
	writetext MayleneSeenText
	waitbutton
	closetext
	winlosstext MayleneBeatenText, 0
	setlasttalked CELADONCAFE_MAYLENE
	checkevent EVENT_BEAT_ELITE_FOUR_AGAIN
	iftrue .Rematch
	loadtrainer MAYLENE, 1
	jump .StartBattle
.Rematch
	loadtrainer MAYLENE, 2
.StartBattle
	startbattle
	reloadmapafterbattle
	setevent EVENT_BEAT_MAYLENE
	opentext
	writetext MayleneAfterText
	waitbutton
.Done
	closetext
	turnobject CELADONCAFE_MAYLENE, RIGHT
	end

.Refused
	writetext MayleneRefusedText
	waitbutton
	closetext
	turnobject CELADONCAFE_MAYLENE, RIGHT
	end

TeacherScript_0x73084:
	checkitem COIN_CASE
	iftrue .NoCoinCase
	showtext UnknownText_0x73201
	showtextfaceplayer UnknownText_0x73212
	turnobject LAST_TALKED, LEFT
	end

.NoCoinCase:
	showtext UnknownText_0x73254
	turnobject CELADONCAFE_TEACHER, RIGHT
	showtext UnknownText_0x73278
	turnobject CELADONCAFE_TEACHER, LEFT
	end

FisherScript_0x73051:
	showtext UnknownText_0x73129
	showtextfaceplayer UnknownText_0x7313a
	turnobject LAST_TALKED, LEFT
	end

FisherScript_0x73062:
	showtext UnknownText_0x7316a
	showtextfaceplayer UnknownText_0x73178
	turnobject LAST_TALKED, RIGHT
	end

FisherScript_0x73073:
	showtext UnknownText_0x731ae
	showtextfaceplayer UnknownText_0x731bd
	turnobject LAST_TALKED, RIGHT
	end

UnknownText_0x730de:
	text "Hi!"

	para "We're holding an"
	line "eatathon contest."

	para "We can't serve you"
	line "right now. Sorry."
	done

UnknownText_0x73129:
	text "…Snarfle, chew…"
	done

UnknownText_0x7313a:
	text "Don't talk to me!"

	para "You'll break my"
	line "concentration!"
	done

UnknownText_0x7316a:
	text "…Gulp… Chew…"
	done

UnknownText_0x73178:
	text "I take quantity"
	line "over quality!"

	para "I'm happy when I'm"
	line "full!"
	done

UnknownText_0x731ae:
	text "Munch, munch…"
	done

UnknownText_0x731bd:
	text "The food is good"
	line "here, but Golden-"
	cont "rod has the best"
	cont "food anywhere."
	done

UnknownText_0x73201:
	text "Crunch… Crunch…"
	done

UnknownText_0x73212:
	text "Nobody here will"
	line "give you a Coin"

	para "Case. You should"
	line "look in Johto."
	done

UnknownText_0x73254:
	text "Crunch… Crunch…"

	para "I can keep eating!"
	done

UnknownText_0x73278:
	text "More, Chef!"
	done

MayleneText1:
	text "Maylene: Munch"
	line "munch munch…"
	done

MayleneText2:
	text "The eatathon"
	line "contest!"

	para "I never dreamed of"
	line "such a wonderful"
	cont "thing."

	para "After a strict"
	line "diet during train-"
	cont "ing, I can eat"
	cont "like a Snorlax."

	para "The winner eats"
	line "for free, too."

	para "That's just a"
	line "dream come true!"
	done

MayleneText3:
	text "I'm starting to"
	line "feel full…"

	para "Um, as a break,"
	line "do you want to"
	cont "battle with me?"
	done

MayleneRefusedText:
	text "Sigh… OK."
	done

MayleneSeenText:
	text "OK! Rei!"

	para "Oh, that's my bow"
	line "before a match."

	para "I'm throwing every-"
	line "thing I have at"
	cont "you!"
	done

MayleneBeatenText:
	text "I'm forced to admit"
	line "defeat…"

	para "You are much too"
	line "strong."
	done

MayleneAfterText:
	text "Thank you,"
	line "<PLAYER>!"

	para "I'm ready to keep"
	line "on eating!"
	done

CeladonCafeBakerText:
	text "I'm working here"
	line "'cause I get to"

	para "eat any time I"
	line "want. Simple."
	done

EatathonContestPosterText:
	text "Eatathon Contest!"
	line "No time limit!"

	para "A battle without"
	line "end! The biggest"

	para "muncher gets it"
	line "all for free!"
	done

EatathonContestTrashCanText:
	text "The trash is full"
	line "of eatathon left-"
	cont "overs…"
	done
