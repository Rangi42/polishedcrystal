OlivineLighthouseRoof_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  9,  3, OLIVINE_LIGHTHOUSE_6F, 4

	def_coord_events

	def_bg_events

	def_object_events
	object_event  4, 13, SPRITE_SKYLA, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, OlivineLighthouseRoofSkylaScript, -1
	itemball_event 16,  8, SILVER_LEAF, 1, EVENT_OLIVINE_LIGHTHOUSE_ROOF_SILVER_LEAF

	object_const_def
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
	sjump .Battle
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
	iffalse_jumpopenedtext .RefusedText
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
	sjump .StartBattle
.Rematch1
	loadtrainer SKYLA, 2
	sjump .StartBattle
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
	iftrue_jumpopenedtext .WaitingText
	writetext .IntroText
	waitbutton
	setevent EVENT_INTRODUCED_SKYLA
	jumpthisopenedtext

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

