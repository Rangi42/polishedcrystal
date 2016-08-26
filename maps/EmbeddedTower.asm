const_value set 2
	const EMBEDDEDTOWER_STEVEN

EmbeddedTower_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

EmbeddedTowerStevenScript:
	faceplayer
	opentext
	checkevent EVENT_BEAT_STEVEN
	iftrue EmbeddedTowerBeatStevenScript
	checkevent EVENT_LISTENED_TO_STEVEN_INTRO
	iftrue .HeardIntro
	writetext EmbeddedTowerStevenIntroText
	waitbutton
	setevent EVENT_LISTENED_TO_STEVEN_INTRO
.HeardIntro
	writetext EmbeddedTowerStevenTowerText
	waitbutton
	checkevent EVENT_BEAT_ELITE_FOUR
	iffalse .NotYet
	writetext EmbeddedTowerStevenChallengeText
	yesorno
	iffalse .Refused
	writetext EmbeddedTowerStevenYesText
	waitbutton
	closetext
	winlosstext EmbeddedTowerStevenWinText, 0
	setlasttalked EMBEDDEDTOWER_STEVEN
	loadtrainer STEVEN, 1
	startbattle
	reloadmapafterbattle
	setevent EVENT_BEAT_STEVEN
	opentext
	jump EmbeddedTowerBeatStevenScript

.NotYet:
	writetext EmbeddedTowerStevenNotNowText
	waitbutton
	closetext
	end

.Refused:
	writetext EmbeddedTowerStevenNoText
	waitbutton
	closetext
	end

EmbeddedTowerBeatStevenScript:
	checkevent EVENT_GOT_MUSCLE_BAND_FROM_STEVEN
	iftrue .GotMuscleBand
	writetext EmbeddedTowerStevenItemText
	waitbutton
	verbosegiveitem MUSCLE_BAND
	iffalse .Done
	setevent EVENT_GOT_MUSCLE_BAND_FROM_STEVEN
.GotMuscleBand
	writetext EmbeddedTowerStevenAfterText
	waitbutton
.Done:
	closetext
	end

EmbeddedTowerStevenIntroText:
	text "Hello! I'm Steven."
	line "Rare stones are"
	cont "my passion."

	para "I'm from the Hoenn"
	line "region. It's a"

	para "beautiful place,"
	line "with the clearest"

	para "ocean you can"
	line "imagine."

	para "You should visit"
	line "sometime."
	done

EmbeddedTowerStevenTowerText:
	text "Steven: I'm here in"
	line "search of stones"
	cont "for my collection."

	para "This is the"
	line "Embedded Tower."

	para "It was built by"
	line "people from Hoenn"

	para "to bind together"
	line "the sea, the land,"
	cont "and the sky."
	done

EmbeddedTowerStevenNotNowText:
	text "Steven: Your"
	line "Pokemon are look-"
	cont "ing pretty good."

	para "If you can beat"
	line "the Elite Four,"

	para "come back here to"
	line "battle with me."
	done

EmbeddedTowerStevenChallengeText:
	text "Steven: Your"
	line "Pokemon are look-"
	cont "ing pretty good."

	para "Since we're both"
	line "here, why don't we"
	cont "have a battle?"
	done

EmbeddedTowerStevenNoText:
	text "Steven: Hmm."
	line "If you change"

	para "your mind, I'll"
	line "be right here."
	done

EmbeddedTowerStevenYesText:
	text "Steven: I want"
	line "you to hit me"

	para "with it all!"
	line "Now, bring it!"
	done

EmbeddedTowerStevenWinText:
	text "You are a truly"
	line "noble #mon"
	cont "trainer!"
	done

EmbeddedTowerStevenItemText:
	text "Steven: Congratu-"
	line "lations!"

	para "The feelings you"
	line "have for your"
	cont "#mon…"

	para "And the #mon"
	line "that responded to"

	para "those feelings"
	line "with all their"
	cont "might…"

	para "They came toge-"
	line "ther as one and"

	para "created an even"
	line "greater power."

	para "And thus, you"
	line "were able to"
	cont "grasp victory!"

	para "I'm sure you can"
	line "benefit from this"
	cont "item."
	done

EmbeddedTowerStevenAfterText:
	text "Steven: May our"
	line "paths cross again."
	done


EmbeddedTower_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 2
	warp_def $17, $a, 6, ROUTE_47
	warp_def $17, $b, 6, ROUTE_47

.XYTriggers:
	db 0

.Signposts:
	db 0

.PersonEvents:
	db 1
	person_event SPRITE_STEVEN, 9, 12, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, EmbeddedTowerStevenScript, -1
