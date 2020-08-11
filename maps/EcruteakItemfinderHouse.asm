EcruteakItemfinderHouse_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  3,  7, ECRUTEAK_CITY, 11
	warp_event  4,  7, ECRUTEAK_CITY, 11

	def_coord_events

	def_bg_events
	bg_event  2,  1, BGEVENT_JUMPSTD, radio2

	def_object_events
	object_event  2,  3, SPRITE_ACE_TRAINER_M, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, CooltrainerMScript_0x9a5fb, -1
	object_event  3,  3, SPRITE_BOOK_PAPER_POKEDEX, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, BookScript_0x9a620, -1

CooltrainerMScript_0x9a5fb:
	checkevent EVENT_GOT_ITEMFINDER
	iftrue_jumptextfaceplayer UnknownText_0x9a70e
	faceplayer
	opentext
	writetext UnknownText_0x9a63c
	yesorno
	iffalse_jumpopenedtext UnknownText_0x9a805
	writetext UnknownText_0x9a6b5
	buttonsound
	verbosegivekeyitem ITEMFINDER
	setevent EVENT_GOT_ITEMFINDER
	jumpthisopenedtext

UnknownText_0x9a70e:
	text "There are many"
	line "items lying about"

	para "that aren't ob-"
	line "vious."

	para "Use Itemfinder to"
	line "check if there is"

	para "an item on the"
	line "ground near you."

	para "It doesn't show"
	line "the exact spot,"

	para "so you'll have to"
	line "look yourself."

	para "Oh yeah--I heard"
	line "there are items"

	para "in Ecruteak's"
	line "Burned Tower."
	done

BookScript_0x9a620:
	opentext
	writetext UnknownText_0x9a826
	yesorno
	iffalse_endtext
	writetext UnknownText_0x9a84c
	yesorno
	iffalse_endtext
	jumpthisopenedtext

	text "Ecruteak was also"
	line "home to three"

	para "#mon that raced"
	line "around the town."

	para "They were said to"
	line "have been born of"

	para "water, lightning"
	line "and fire."

	para "But they could not"
	line "contain their"
	cont "excessive power."

	para "So they say the"
	line "three ran like the"

	para "wind off into the"
	line "grassland."
	done

UnknownText_0x9a63c:
	text "Ah. You're on an"
	line "adventure with"
	cont "your #mon?"

	para "Well, what's an"
	line "adventure without"
	cont "treasure hunting?"

	para "Am I right, or am"
	line "I right?"
	done

UnknownText_0x9a6b5:
	text "Good! You under-"
	line "stand the true"

	para "spirit of adven-"
	line "ture."

	para "I like that! Take"
	line "this with you."
	done

UnknownText_0x9a805:
	text "Oh… To each his"
	line "own, I suppose…"
	done

UnknownText_0x9a826:
	text "History of"
	line "Ecruteak"

	para "Want to read it?"
	done

UnknownText_0x9a84c:
	text "In Ecruteak, there"
	line "were two towers."

	para "Each tower was the"
	line "roost of powerful"
	cont "flying #mon."

	para "But one of the"
	line "towers burned to"
	cont "the ground."

	para "The two #mon"
	line "haven't been seen"
	cont "since…"

	para "Keep reading?"
	done
