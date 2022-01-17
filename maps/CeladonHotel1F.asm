CeladonHotel1F_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  3,  7, CELADON_CITY, 11
	warp_event  4,  7, CELADON_CITY, 11
	warp_event 16,  0, CELADON_HOTEL_2F, 1
	warp_event 12,  0, CELADON_HOTEL_POOL, 1

	def_coord_events

	def_bg_events
	bg_event  7,  2, BGEVENT_JUMPTEXT, CeladonHotel1FSignpost1Text
	bg_event 13,  0, BGEVENT_JUMPTEXT, CeladonHotel1FSignpost2Text
	bg_event 17,  0, BGEVENT_JUMPTEXT, CeladonHotel1FSignpost3Text

	def_object_events
	object_event 11,  6, SPRITE_RICH_BOY, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, CeladonHotel1FRichBoyGeraldScript, -1
	object_event  3,  1, SPRITE_GRAMPS, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_COMMAND, jumptextfaceplayer, CeladonHotel1FGrampsText, -1
	object_event  7,  4, SPRITE_LADY, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_COMMAND, jumptextfaceplayer, CeladonHotel1FLadyText, -1
	object_event 14,  6, SPRITE_ACE_TRAINER_F, SPRITEMOVEDATA_STANDING_LEFT, 0, 1, -1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, CeladonHotel1FCooltrainerFText, -1

	object_const_def
	const CELADONHOTEL1F_RICH_BOY

CeladonHotel1FRichBoyGeraldScript:
	checkevent EVENT_BEAT_RICH_BOY_GERALD
	iftrue_jumptextfaceplayer RichBoyGeraldAfterText
	faceplayer
	opentext
	writetext RichBoyGeraldGreetingText
	yesorno
	iffalse_jumpopenedtext RichBoyGeraldNoBattleText
	writetext RichBoyGeraldSeenText
	waitbutton
	closetext
	winlosstext RichBoyGeraldBeatenText, 0
	setlasttalked CELADONHOTEL1F_RICH_BOY
	loadtrainer RICH_BOY, GERALD
	startbattle
	reloadmapafterbattle
	setevent EVENT_BEAT_RICH_BOY_GERALD
	end

CeladonHotel1FGrampsText:
	ctxt "#mon? No, this"
	line "is a hotel for"
	cont "people."

	para "We're full up."
	done

CeladonHotel1FLadyText:
	ctxt "This is my first"
	line "trip to Kanto."

	para "There's so much to"
	line "see in Celadon!"
	done

CeladonHotel1FCooltrainerFText:
	ctxt "Ahh, I really"
	line "needed this"
	cont "vacation!"
	done

RichBoyGeraldGreetingText:
	ctxt "My sister's enjoy-"
	line "ing our vacation,"

	para "but I'm bored."
	line "Care for a battle?"
	done

RichBoyGeraldSeenText:
	ctxt "Then prepare to"
	line "lose!"
	done

RichBoyGeraldBeatenText:
	ctxt "At least you're"
	line "not boring."
	done

RichBoyGeraldAfterText:
	ctxt "Next time we ought"
	line "to vacation at"
	cont "Olivine City."

	para "I'd quite like to"
	line "challenge the"
	cont "Battle Tower."
	done

RichBoyGeraldNoBattleText:
	ctxt "Hmph! Fine."
	done

CeladonHotel1FSignpost1Text:
	ctxt "Celadon Hotel"

	para "Enjoy your stay!"
	done

CeladonHotel1FSignpost2Text:
	ctxt "Hotel Pool"

	para "Please wear a swim"
	line "cap in the water."
	done

CeladonHotel1FSignpost3Text:
	ctxt "Suites"
	line "Upstairs"
	done
