const_value set 2
	const CELADONHOTEL1F_GRAMPS
	const CELADONHOTEL1F_COOLTRAINERF
	const CELADONHOTEL1F_RICH_BOY

CeladonHotel1F_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

CeladonHotel1FGrampsScript:
	jumptextfaceplayer CeladonHotel1FGrampsText

CeladonHotel1FCooltrainerFScript:
	jumptextfaceplayer CeladonHotel1FCooltrainerFText

CeladonHotel1FRichBoyGeraldScript:
	faceplayer
	opentext
	checkevent EVENT_BEAT_RICH_BOY_GERALD
	iftrue RichBoyGeraldAfterScript
	writetext RichBoyGeraldGreetingText
	yesorno
	iffalse RichBoyGeraldNoBattleScript
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

RichBoyGeraldAfterScript:
	writetext RichBoyGeraldAfterText
	waitbutton
	closetext
	end

RichBoyGeraldNoBattleScript:
	writetext RichBoyGeraldNoBattleText
	waitbutton
	closetext
	end

CeladonHotel1FGrampsText:
	text "#mon? No, this"
	line "is a hotel for"
	cont "people."

	para "We're full up."
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

CeladonHotel1F_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 4
	warp_def $7, $3, 11, CELADON_CITY
	warp_def $7, $4, 11, CELADON_CITY
	warp_def $0, $10, 1, CELADON_HOTEL_2F
	warp_def $0, $c, 1, CELADON_HOTEL_POOL

.XYTriggers:
	db 0

.Signposts:
	db 0

.PersonEvents:
	db 3
	person_event SPRITE_GRAMPS, 1, 3, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_SCRIPT, 0, CeladonHotel1FGrampsScript, -1
	person_event SPRITE_COOLTRAINER_F, 4, 7, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, CeladonHotel1FCooltrainerFScript, -1
	person_event SPRITE_RICH_BOY, 6, 11, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, CeladonHotel1FRichBoyGeraldScript, -1
