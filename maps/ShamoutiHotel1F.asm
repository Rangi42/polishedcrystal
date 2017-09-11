ShamoutiHotel1F_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 1
	dbw MAPCALLBACK_NEWMAP, ShamoutiHotel1FRestaurantTrigger

ShamoutiHotel1F_MapEventHeader:

.Warps: db 4
	warp_def 7, 8, 2, SHAMOUTI_ISLAND
	warp_def 7, 9, 2, SHAMOUTI_ISLAND
	warp_def 0, 2, 1, SHAMOUTI_HOTEL_2F
	warp_def 0, 14, 1, SHAMOUTI_HOTEL_RESTAURANT

.XYTriggers: db 0

.Signposts: db 1
	signpost 0, 15, SIGNPOST_JUMPTEXT, ShamoutiHotelRestaurantSignText

.PersonEvents: db 5
	person_event SPRITE_RECEPTIONIST, 1, 8, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_COMMAND, jumptextfaceplayer, ShamoutiHotel1FReceptionistText, -1
	person_event SPRITE_ARTIST, 4, 2, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, ShamoutiHotel1FArtistScript, -1
	person_event SPRITE_COOLTRAINER_M, 4, 5, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_COMMAND, jumptextfaceplayer, ShamoutiHotel1FCooltrainermText, -1
	person_event SPRITE_LADY, 5, 12, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_COMMAND, jumptextfaceplayer, ShamoutiHotel1FLadyText, -1
	person_event SPRITE_YOUNGSTER, 7, 14, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 2, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_COMMAND, jumptextfaceplayer, ShamoutiHotel1FYoungsterText, -1

ShamoutiHotel1FRestaurantTrigger:
	domaptrigger SHAMOUTI_HOTEL_RESTAURANT, $0
	return

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
	buttonsound
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
