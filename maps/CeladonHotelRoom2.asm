CeladonHotelRoom2_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  3,  5, CELADON_HOTEL_2F, 3
	warp_event  4,  5, CELADON_HOTEL_2F, 3

	def_coord_events

	def_bg_events

	def_object_events
	object_event  3,  2, SPRITE_SUPER_NERD, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, CeladonHotelRoom2SuperNerdScript, -1

CeladonHotelRoom2SuperNerdScript:
	faceplayer
	opentext
	writetext .Text1
	waitbutton
	writetext .Text2
	yesorno
	iffalse_jumpopenedtext .Text5
	checkitem BOTTLE_CAP
	iffalse_jumpopenedtext .Text5
	takeitem BOTTLE_CAP
	writetext .Text3
	waitbutton
	writetext .Text4
	waitbutton
	verbosegiveitem CHERISH_BALL
	iftrue_endtext
	giveitem BOTTLE_CAP
	jumpthisopenedtext

	text "Drat. Maybe"
	line "later?"
	done

.Text1:
	text "I used to collect"
	line "Poke Balls, but I"
	cont "grew bored."

	para "Now I collect"
	line "Bottle Caps!"

	para "Will you help me"
	line "increase my coll-"
	cont "ection?"

	para "I'll trade you a"
	line "Cherish Ball for"
	cont "a Bottle Cap."

	para "You can't buy them"
	line "anywhere!"
	done

.Text2:
	text "Give away a"
	line "Bottle Cap?"
	done

.Text3:
	text "<PLAYER> gave away"
	line "the Bottle Cap."
	done

.Text4:
	text "Ooh, yes, this is"
	line "a rare specimen!"

	para "I'll happily part"
	line "with a Cherish"
	cont "Ball for it."
	done

.Text5:
	text "You don't have any"
	line "Bottle Caps?"

	para "I know Fishermen"
	line "snag them some-"
	cont "times…"
	done
