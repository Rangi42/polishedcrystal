OlivineLighthouseRoof_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

OlivineLighthouseRoof_MapEventHeader:

.Warps: db 1
	warp_def 3, 9, 4, OLIVINE_LIGHTHOUSE_6F

.XYTriggers: db 0

.Signposts: db 0

.PersonEvents: db 2
	person_event SPRITE_SKYLA, 13, 4, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, 0, PERSONTYPE_SCRIPT, 0, OlivineLighthouseRoofSkylaScript, -1
	itemball_event 8, 16, SILVER_LEAF, 1, EVENT_OLIVINE_LIGHTHOUSE_ROOF_SILVER_LEAF

const_value set 1
	const OLIVINELIGHTHOUSEROOF_SKYLA

OlivineLighthouseRoofSkylaScript:
	faceplayer
	opentext
	checkevent EVENT_BEAT_SKYLA_AGAIN
	iftrue .Beaten
	checkevent EVENT_JASMINE_RETURNED_TO_GYM
	iffalse .Waiting
	checkevent EVENT_BEAT_SKYLA
	iffalse .NotYetBattled
	writetext .RematchText
	jump .Battle
.NotYetBattled
	checkevent EVENT_INTRODUCED_SKYLA
	iftrue .Introduced1
	writetext .IntroText
	waitbutton
	setevent EVENT_INTRODUCED_SKYLA
.Introduced1
	writetext .ChallengeText
.Battle
	yesorno
	iffalse .Refused
	writetext .SeenText
	waitbutton
	closetext
	winlosstext .BeatenText, 0
	setlasttalked OLIVINELIGHTHOUSEROOF_SKYLA
	checkevent EVENT_BEAT_ELITE_FOUR_AGAIN
	iftrue .Rematch2
	checkevent EVENT_BEAT_ELITE_FOUR
	iftrue .Rematch1
	loadtrainer SKYLA, 1
	jump .StartBattle
.Rematch1
	loadtrainer SKYLA, 2
	jump .StartBattle
.Rematch2
	loadtrainer SKYLA, 3
.StartBattle
	startbattle
	reloadmapafterbattle
	opentext
.Beaten:
	writetext .AfterText
	waitbutton
	closetext
	setevent EVENT_BEAT_SKYLA
	setevent EVENT_BEAT_SKYLA_AGAIN
	end

.Waiting:
	checkevent EVENT_INTRODUCED_SKYLA
	iftrue .Introduced2
	writetext .IntroText
	waitbutton
	setevent EVENT_INTRODUCED_SKYLA
.Introduced2
	jumpopenedtext .WaitingText

.Refused:
	jumpopenedtext .RefusedText

.IntroText:
	text "Skyla: Who are"
	line "you?"

	para "Oh, I see! You're"
	line "<PLAYER>, a #-"
	cont "mon trainer."

	para "I'm Skyla, a cargo"
	line "pilot from the"
	cont "Unova region."

	para "I've flown to the"
	line "top of Unova's"

	para "Celestial Tower"
	line "before, but this"

	para "Lighthouse is even"
	line "taller."
	done

.WaitingText:
	text "I saw a hurt #-"
	line "mon from my plane,"

	para "but I don't have"
	line "anything that can"
	cont "help it…"

	para "So even if you"
	line "want to battle,"

	para "I'm not in the"
	line "mood right now."
	done

.ChallengeText:
	text "I saw a hurt #-"
	line "mon from my plane,"

	para "but it looks just"
	line "fine now!"

	para "Oh, you brought"
	line "its medicine?"
	cont "Thank you!"

	para "<PLAYER>, you are"
	line "a kind and strong"
	cont "person."

	para "So, how about you"
	line "and I have some"
	cont "fun?"
	done

.RematchText:
	text "Hee-hee! I've been"
	line "waiting for you,"
	cont "<PLAYER>."

	para "You're a tough"
	line "trainer who can"

	para "face the wind and"
	line "not get blown off"
	cont "your feet!"

	para "Why don't you and"
	line "I have some fun?"
	done

.RefusedText:
	text "Come on, don't"
	line "be shy!"
	done

.SeenText:
	text "It's finally time"
	line "for a showdown!"
	done

.BeatenText:
	text "I won't forget"
	line "this battle!"

	para "I'm glad that I"
	line "could fight"
	cont "against you!"
	done

.AfterText:
	text "You're an amazing"
	line "#mon trainer."

	para "My #mon and I"
	line "are happy, because"

	para "for the first time"
	line "in a while, we"

	para "could fight with"
	line "our full strength."
	done

