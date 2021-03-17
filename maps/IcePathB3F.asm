IcePathB3F_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  3,  5, ICE_PATH_B2F_MAHOGANY_SIDE, 2
	warp_event 15,  5, ICE_PATH_B2F_BLACKTHORN_SIDE, 2

	def_coord_events

	def_bg_events
	bg_event 16,  3, BGEVENT_JUMPTEXT, Text_IcePathB3FIceRock

	def_object_events
	object_event 10,  3, SPRITE_LORELEI, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, LoreleiScript, -1
	itemball_event  5,  7, NEVERMELTICE, 1, EVENT_ICE_PATH_B3F_NEVERMELTICE
	smashrock_event  6, 6

	object_const_def
	const ICEPATHB3F_LORELEI

LoreleiScript:
	faceplayer
	opentext
	checkevent EVENT_BEAT_ELITE_FOUR
	iftrue LoreleiRematchScript
	checkevent EVENT_BEAT_LORELEI
	iftrue_jumpopenedtext LoreleiAfterText
	checkevent EVENT_INTRODUCED_LORELEI
	iftrue LoreleiAfterIntroScript
	writetext LoreleiIntroText
	waitbutton
	setevent EVENT_INTRODUCED_LORELEI
LoreleiAfterIntroScript:
	writetext LoreleiAfterIntroText
	yesorno
	iffalse_jumpopenedtext LoreleiNoBattleText
	writetext LoreleiSeenText
	waitbutton
	closetext
	winlosstext LoreleiBeatenText, 0
	setlasttalked ICEPATHB3F_LORELEI
	loadtrainer LORELEI, 1
	startbattle
	reloadmapafterbattle
	setevent EVENT_BEAT_LORELEI
	opentext
	writetext LoreleiRewardText
	promptbutton
	verbosegiveitem ICY_ROCK
	setevent EVENT_GOT_ICY_ROCK_FROM_LORELEI
	jumpthisopenedtext

LoreleiAfterText:
	text "Go on ahead. You"
	line "can challenge the"

	para "#mon League"
	line "with one more"
	cont "Badge."

	para "If you do beat"
	line "them, meet me here"
	cont "for a rematch."
	done

LoreleiRematchScript:
	checkevent EVENT_BEAT_LORELEI_AGAIN
	iftrue_jumpopenedtext LoreleiRematchAfterText
	checkevent EVENT_INTRODUCED_LORELEI
	iftrue LoreleiReintroductionScript
	writetext LoreleiIntroText
	waitbutton
	setevent EVENT_INTRODUCED_LORELEI
LoreleiAfterRematchIntroScript:
	writetext LoreleiRematchSeenText
	waitbutton
	closetext
	winlosstext LoreleiRematchBeatenText, 0
	setlasttalked ICEPATHB3F_LORELEI
	loadtrainer LORELEI, 3
	startbattle
	reloadmapafterbattle
	setevent EVENT_BEAT_LORELEI_AGAIN
	opentext
	checkevent EVENT_GOT_ICY_ROCK_FROM_LORELEI
	iftrue_jumpopenedtext LoreleiRematchAfterText
	writetext LoreleiRewardText
	promptbutton
	verbosegiveitem ICY_ROCK
	setevent EVENT_GOT_ICY_ROCK_FROM_LORELEI
	jumpthisopenedtext

LoreleiRematchAfterText:
	text "Your journey isn't"
	line "over, you know."

	para "You can earn more"
	line "badges in Kanto,"

	para "catch new species"
	line "of #mon,"

	para "improve yourself"
	line "and your team."

	para "Becoming a"
	line "#mon master is"
	cont "a life's work."
	done


LoreleiReintroductionScript:
	writetext LoreleiRematchIntroAgainText
	waitbutton
	sjump LoreleiAfterRematchIntroScript

Text_IcePathB3FIceRock:
	text "The boulder is"
	line "coated with ice."

	para "It is bone-chill-"
	line "ing to touch."
	done

LoreleiIntroText:
	text "Lorelei: Hello"
	line "there, trainer."
	cont "I am Lorelei."

	para "See that icy rock"
	line "over there?"

	para "It emits an energy"
	line "I've never seen in"
	cont "Kanto."

	para "As an expert on"
	line "Ice-type #mon,"
	cont "I had to investi-"
	cont "gate it."

	para "And what are you"
	line "doing here?"
	done

LoreleiAfterIntroText:
	text "Lorelei: You're"
	line "taking the #mon"

	para "League challenge."
	line "I see."
	cont "How ironic."

	para "Why don't I test"
	line "your skill?"
	done

LoreleiNoBattleText:
	text "If you can't face"
	line "me, you'll never"

	para "be able to beat"
	line "the Champion."
	done

LoreleiSeenText:
	text "Hahaha! Get ready"
	line "to be frozen"
	cont "solid!"
	done

LoreleiBeatenText:
	text "You're better than"
	line "I thought!"
	done

LoreleiRewardText:
	text "You know how to"
	line "handle Ice-type"
	cont "#mon."

	para "Then you can use"
	line "this item."
	done

LoreleiRematchIntroAgainText:
	text "Lorelei: Hello"
	line "again, <PLAYER>."
	done

LoreleiRematchSeenText:
	text "So you battled"
	line "the Elite Four?"

	para "I hope you took"
	line "Karen down a peg."

	para "…………You're the"
	line "new Champion."
	cont "I'm impressed."

	para "Then I won't have"
	line "to hold back!"
	done

LoreleiRematchBeatenText:
	text "As expected of"
	line "the Champion!"
	done
