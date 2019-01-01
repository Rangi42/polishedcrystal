SafariZoneWestRestHouse2_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 2 ; warp events
	warp_event  2,  7, SAFARI_ZONE_WEST, 8
	warp_event  3,  7, SAFARI_ZONE_WEST, 8

	db 0 ; coord events

	db 4 ; bg events
	bg_event  4,  1, SIGNPOST_READ, PokemonJournalKogaScript
	bg_event  5,  1, SIGNPOST_READ, PokemonJournalKogaScript
	bg_event  6,  1, SIGNPOST_READ, PokemonJournalKogaScript
	bg_event  7,  1, SIGNPOST_READ, PokemonJournalKogaScript

	db 1 ; object events
	object_event  3,  4, SPRITE_FLANNERY, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, 0, PERSONTYPE_SCRIPT, 0, SafariZoneWestRestHouse2FlanneryScript, -1

	const_def 1 ; object constants
	const SAFARIZONEWESTRESTHOUSE2_FLANNERY

SafariZoneWestRestHouse2FlanneryScript:
	faceplayer
	opentext
	checkevent EVENT_BEAT_FLANNERY
	iftrue .Beaten
	checkevent EVENT_INTRODUCED_FLANNERY
	iftrue .Introduced
	writetext .IntroText
	jump .Question
.Introduced
	writetext .RematchText
.Question
	yesorno
	iffalse .Refused
	writetext .SeenText
	waitbutton
	closetext
	winlosstext .BeatenText, 0
	setlasttalked SAFARIZONEWESTRESTHOUSE2_FLANNERY
	checkevent EVENT_BEAT_ELITE_FOUR_AGAIN
	iftrue .Rematch
	loadtrainer FLANNERY, 1
	jump .StartBattle
.Rematch
	loadtrainer FLANNERY, 2
.StartBattle
	startbattle
	reloadmapafterbattle
	setevent EVENT_INTRODUCED_FLANNERY
	setevent EVENT_BEAT_FLANNERY
	opentext
.Beaten:
	jumpopenedtext .AfterText

.Refused:
	jumpopenedtext .RefusedText

.IntroText:
	text "Hi there!"

	para "Good to see some-"
	line "one else exploring"
	cont "this place!"

	para "I am Flannery."

	para "I'm from the Hoenn"
	line "region, so I like"

	para "humidity and hot"
	line "springs."

	para "The Safari Zone"
	line "feels like home!"

	para "Let's exchange"
	line "superhot moves in"
	cont "a battle!"
	done

.RematchText:
	text "Hi there,"
	line "<PLAYER>!"

	para "Good to see you"
	line "again!"

	para "Losing a match"
	line "isn't going to"
	cont "deflate me."

	para "Let's exchange"
	line "superhot moves in"
	cont "another battle!"
	done

.SeenText:
	text "I'm going to demo-"
	line "nstrate the hot"

	para "moves I honed"
	line "close to a vol-"
	cont "cano!"
	done

.BeatenText:
	text "Whew! On the verge"
	line "of eruption!"
	done

.AfterText:
	text "I lost the match,"
	line "but I'm completely"
	cont "satisfied."

	para "It's not often I"
	line "get to enjoy a"

	para "battle this"
	line "heated."

	para "Let's have another"
	line "one like this"
	cont "sometime!"
	done

.RefusedText:
	text "OK then… Uh…"
	line "Don't be shy about"
	cont "it if you return!"
	done
