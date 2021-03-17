ShamoutiHotel1F_MapScriptHeader:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_NEWMAP, ShamoutiHotel1FRestaurantTrigger

	def_warp_events
	warp_event  8,  7, SHAMOUTI_ISLAND, 2
	warp_event  9,  7, SHAMOUTI_ISLAND, 2
	warp_event  2,  0, SHAMOUTI_HOTEL_2F, 1
	warp_event 14,  0, SHAMOUTI_HOTEL_RESTAURANT, 1

	def_coord_events

	def_bg_events
	bg_event 15,  0, BGEVENT_JUMPTEXT, ShamoutiHotelRestaurantSignText

	def_object_events
	object_event  8,  1, SPRITE_RECEPTIONIST, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_COMMAND, jumptextfaceplayer, ShamoutiHotel1FReceptionistText, -1
	object_event  2,  4, SPRITE_ARTIST, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, ShamoutiHotel1FArtistScript, -1
	object_event  5,  4, SPRITE_ACE_TRAINER_M, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, ShamoutiHotel1FCooltrainermText, -1
	object_event 12,  5, SPRITE_LADY, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_COMMAND, jumptextfaceplayer, ShamoutiHotel1FLadyText, -1
	object_event 14,  7, SPRITE_CAMPER, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 2, -1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, ShamoutiHotel1FYoungsterText, -1

ShamoutiHotel1FRestaurantTrigger:
	setmapscene SHAMOUTI_HOTEL_RESTAURANT, $0
	endcallback

ShamoutiHotel1FReceptionistText:
	text "Welcome to the"
	line "Shamouti Hotel."

	para "I'm afraid our"
	line "rooms are all"
	cont "booked, but please"

	para "visit our deluxe"
	line "Oasis Restaurant."
	done

ShamoutiHotel1FArtistScript:
	faceplayer
	opentext
	checkflag ENGINE_CHANGED_TRENDY_PHRASE
	iftrue .SetTrendyPhraseToday
	writetext .Text1
	yesorno
	iftrue .Yes
	writetext .Text2
	promptbutton
	special SpecialTrendyPhrase
	setflag ENGINE_CHANGED_TRENDY_PHRASE
	jumpopenedtext .Text3

.SetTrendyPhraseToday
	jumpopenedtext .Text4

.Yes
	jumpopenedtext .Text5

.Text1:
	text "No matter where"
	line "you go, <TRENDY>"

	para "is the coolest"
	line "thing around!"
	cont "Isn't that so?"
	done

.Text2:
	text "What?! <TRENDY>"
	line "isn't the coolest"
	cont "thing around?"

	para "Well, what is the"
	line "coolest thing"
	cont "these days?"
	done

.Text3:
	text "Oh, yeah! I've got"
	line "it now!"

	para "<TRENDY> is"
	line "totally the best"
	cont "thing ever!"
	done

.Text4:
	text "<TRENDY> is the"
	line "hip and happening"
	cont "thing right now!"
	done

.Text5:
	text "You know it!"
	line "I just can't get"
	cont "enough of"
	cont "<TRENDY>!"
	done

ShamoutiHotel1FCooltrainermText:
	text "So <TRENDY> is"
	line "the hot new thing?"

	cont "That's so cool!"
	done

ShamoutiHotel1FLadyText:
	text "Have you ever"
	line "found a Bottle Cap"
	cont "while fishing?"

	para "In Alola, where I'm"
	line "from, there's a man"

	para "who will “Hyper"
	line "Train” your #-"
	cont "mon--bringing out"

	para "its full poten-"
	line "tial--just for a"
	cont "Bottle Cap."
	done

ShamoutiHotel1FYoungsterText:
	text "I heard that"
	line "<TRENDY> is “in”"
	cont "right now!"
	done

ShamoutiHotelRestaurantSignText:
	text "Oasis Restaurant"
	done
