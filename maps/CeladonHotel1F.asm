CeladonHotel1F_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

CeladonHotel1F_MapEventHeader:

.Warps: db 4
	warp_def 7, 3, 11, CELADON_CITY
	warp_def 7, 4, 11, CELADON_CITY
	warp_def 0, 16, 1, CELADON_HOTEL_2F
	warp_def 0, 12, 1, CELADON_HOTEL_POOL

.XYTriggers: db 0

.Signposts: db 3
	signpost 2, 7, SIGNPOST_JUMPTEXT, CeladonHotel1FSignpost1Text
	signpost 0, 13, SIGNPOST_JUMPTEXT, CeladonHotel1FSignpost2Text
	signpost 0, 17, SIGNPOST_JUMPTEXT, CeladonHotel1FSignpost3Text

.PersonEvents: db 4
	person_event SPRITE_RICH_BOY, 6, 11, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, CeladonHotel1FRichBoyGeraldScript, -1
	person_event SPRITE_GRAMPS, 1, 3, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_COMMAND, jumptextfaceplayer, CeladonHotel1FGrampsText, -1
	person_event SPRITE_LADY, 4, 7, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_COMMAND, jumptextfaceplayer, CeladonHotel1FLadyText, -1
	person_event SPRITE_COOLTRAINER_F, 6, 14, SPRITEMOVEDATA_STANDING_LEFT, 0, 1, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_COMMAND, jumptextfaceplayer, CeladonHotel1FCooltrainerFText, -1

const_value set 1
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
	text "#mon? No, this"
	line "is a hotel for"
	cont "people."

	para "We're full up."
	done

CeladonHotel1FLadyText:
	text "This is my first"
	line "trip to Kanto."

	para "There's so much to"
	line "see in Celadon!"
	done

CeladonHotel1FCooltrainerFText:
	text "Ahh, I really"
	line "needed this"
	cont "vacation!"
	done

RichBoyGeraldGreetingText:
	text "My sister's enjoy-"
	line "ing our vacation,"

	para "but I'm bored."
	line "Care for a battle?"
	done

RichBoyGeraldSeenText:
	text "Then prepare to"
	line "lose!"
	done

RichBoyGeraldBeatenText:
	text "At least you're"
	line "not boring."
	done

RichBoyGeraldAfterText:
	text "Next time we ought"
	line "to vacation at"
	cont "Olivine City."

	para "I'd quite like to"
	line "challenge the"
	cont "Battle Tower."
	done

RichBoyGeraldNoBattleText:
	text "Hmph! Fine."
	done

CeladonHotel1FSignpost1Text:
	text "Celadon Hotel"

	para "Enjoy your stay!"
	done

CeladonHotel1FSignpost2Text:
	text "Hotel Pool"

	para "Please wear a swim"
	line "cap in the water."
	done

CeladonHotel1FSignpost3Text:
	text "Suites"
	line "Upstairs"
	done
