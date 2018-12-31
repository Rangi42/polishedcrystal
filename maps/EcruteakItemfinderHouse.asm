EcruteakItemfinderHouse_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

EcruteakItemfinderHouse_MapEventHeader:

.Warps: db 2
	warp_def 7, 3, 11, ECRUTEAK_CITY
	warp_def 7, 4, 11, ECRUTEAK_CITY

.XYTriggers: db 0

.Signposts: db 1
	signpost 1, 2, SIGNPOST_JUMPSTD, radio2

.PersonEvents: db 2
	person_event SPRITE_COOLTRAINER_M, 3, 2, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, CooltrainerMScript_0x9a5fb, -1
	person_event SPRITE_BOOK, 3, 3, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_SCRIPT, 0, BookScript_0x9a620, -1

CooltrainerMScript_0x9a5fb:
	faceplayer
	opentext
	checkevent EVENT_GOT_ITEMFINDER
	iftrue UnknownScript_0x9a614
	writetext UnknownText_0x9a63c
	yesorno
	iffalse UnknownScript_0x9a61a
	writetext UnknownText_0x9a6b5
	buttonsound
	verbosegiveitem ITEMFINDER
	setevent EVENT_GOT_ITEMFINDER
UnknownScript_0x9a614:
	jumpopenedtext UnknownText_0x9a70e

UnknownScript_0x9a61a:
	jumpopenedtext UnknownText_0x9a805

BookScript_0x9a620:
	opentext
	writetext UnknownText_0x9a826
	yesorno
	iftrue UnknownScript_0x9a62a
	endtext

UnknownScript_0x9a62a:
	writetext UnknownText_0x9a84c
	yesorno
	iftrue UnknownScript_0x9a633
	endtext

UnknownScript_0x9a633:
	jumpopenedtext UnknownText_0x9a902

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

UnknownText_0x9a902:
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
