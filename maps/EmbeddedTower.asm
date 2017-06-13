const_value set 2
	const EMBEDDEDTOWER_STEVEN1
	const EMBEDDEDTOWER_STEVEN2

EmbeddedTower_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

EmbeddedTowerSteven1Script:
	faceplayer
	opentext
	checkevent EVENT_BEAT_STEVEN
	iftrue EmbeddedTowerBeatSteven1Script
	checkevent EVENT_LISTENED_TO_STEVEN_INTRO
	iftrue .HeardIntro
	writetext EmbeddedTowerSteven1IntroText
	waitbutton
	setevent EVENT_LISTENED_TO_STEVEN_INTRO
.HeardIntro
	writetext EmbeddedTowerSteven1TowerText
	waitbutton
	checkevent EVENT_BEAT_ELITE_FOUR
	iffalse .NotYet
	writetext EmbeddedTowerSteven1ChallengeText
	yesorno
	iffalse .Refused
	writetext EmbeddedTowerSteven1YesText
	waitbutton
	closetext
	winlosstext EmbeddedTowerSteven1WinText, 0
	setlasttalked EMBEDDEDTOWER_STEVEN1
	loadtrainer STEVEN, 1
	startbattle
	reloadmapafterbattle
	setevent EVENT_BEAT_STEVEN
	opentext
	jump EmbeddedTowerBeatSteven1Script

.NotYet:
	writetext EmbeddedTowerSteven1NotNowText
	waitbutton
	closetext
	end

.Refused:
	writetext EmbeddedTowerSteven1NoText
	waitbutton
	closetext
	end

EmbeddedTowerBeatSteven1Script:
	checkevent EVENT_GOT_MUSCLE_BAND_FROM_STEVEN
	iftrue .GotMuscleBand
	writetext EmbeddedTowerSteven1ItemText
	waitbutton
	verbosegiveitem MUSCLE_BAND
	iffalse .Done
	setevent EVENT_GOT_MUSCLE_BAND_FROM_STEVEN
.GotMuscleBand
	writetext EmbeddedTowerSteven1AfterText
	waitbutton
.Done:
	closetext
	end

EmbeddedTowerSteven2Script:
	faceplayer
	opentext
	checkevent EVENT_BEAT_STEVEN
	iftrue .Beat
	writetext EmbeddedTowerSteven2ChallengeText
	yesorno
	iffalse .Refused
	writetext EmbeddedTowerSteven2YesText
	waitbutton
	closetext
	winlosstext EmbeddedTowerSteven2WinText, 0
	setlasttalked EMBEDDEDTOWER_STEVEN2
	loadtrainer STEVEN, 2
	startbattle
	reloadmapafterbattle
	setevent EVENT_BEAT_STEVEN
	opentext
.Beat:
	writetext EmbeddedTowerSteven2AfterText
	waitbutton
	closetext
	end

.Refused:
	writetext EmbeddedTowerSteven2NoText
	waitbutton
	closetext
	end

EmbeddedTowerSteven1IntroText:
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

EmbeddedTowerSteven1TowerText:
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

EmbeddedTowerSteven1NotNowText:
	text "Steven: Your"
	line "Pokemon are look-"
	cont "ing pretty good."

	para "If you can beat"
	line "the Elite Four,"

	para "come back here to"
	line "battle with me."
	done

EmbeddedTowerSteven1ChallengeText:
	text "Steven: Your"
	line "Pokemon are look-"
	cont "ing pretty good."

	para "Since we're both"
	line "here, why don't we"
	cont "have a battle?"
	done

EmbeddedTowerSteven1NoText:
EmbeddedTowerSteven2NoText:
	text "Steven: Hmm."
	line "If you change"

	para "your mind, I'll"
	line "be right here."
	done

EmbeddedTowerSteven1YesText:
EmbeddedTowerSteven2YesText:
	text "Steven: I want"
	line "you to hit me"

	para "with it all!"
	line "Now, bring it!"
	done

EmbeddedTowerSteven1WinText:
EmbeddedTowerSteven2WinText:
	text "You are a truly"
	line "noble #mon"
	cont "trainer!"
	done

EmbeddedTowerSteven1ItemText:
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

EmbeddedTowerSteven1AfterText:
	text "Steven: May our"
	line "paths cross again."
	done

EmbeddedTowerSteven2ChallengeText:
	text "Steven: We meet"
	line "again, <PLAYER>!"

	para "I've found some"
	line "excellent stones"
	cont "for my collection."

	para "So what have you"
	line "been doing?"

	para "You battled the"
	line "Elite Four and won"
	cont "again? Great job!"

	para "Why don't we have"
	line "another battle?"
	done

EmbeddedTowerSteven2AfterText:
	text "Steven: In the"
	line "end, you are still"
	cont "the strongest."

	para "But I don't regret"
	line "our battle."

	para "Because each time"
	line "that I battle you,"

	para "I learn more about"
	line "#mon!"
	done

EmbeddedTower_MapEventHeader:
.Warps:
	db 2
	warp_def $17, $a, 6, ROUTE_47
	warp_def $17, $b, 6, ROUTE_47

.XYTriggers:
	db 0

.Signposts:
	db 0

.PersonEvents:
	db 2
	person_event SPRITE_STEVEN, 9, 12, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, EmbeddedTowerSteven1Script, EVENT_EMBEDDED_TOWER_STEVEN_1
	person_event SPRITE_STEVEN, 11, 8, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, EmbeddedTowerSteven2Script, EVENT_EMBEDDED_TOWER_STEVEN_2
