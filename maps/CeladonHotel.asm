const_value set 2
	const CELADONHOTEL_GRAMPS
	const CELADONHOTEL_COOLTRAINERF
	const CELADONHOTEL_RICH_BOY

CeladonHotel_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

CeladonHotelGrampsScript:
	jumptextfaceplayer CeladonHotelGrampsText

CeladonHotelCooltrainerFScript:
	jumptextfaceplayer CeladonHotelCooltrainerFText

CeladonHotelRichBoyGeraldScript:
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
	setlasttalked CELADONHOTEL_RICH_BOY
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

CeladonHotelGrampsText:
	text "#mon? No, this"
	line "is a hotel for"
	cont "people."

	para "We're full up."
	done

CeladonHotelCooltrainerFText:
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

CeladonHotel_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 2
	warp_def $7, $4, 11, CELADON_CITY
	warp_def $7, $5, 11, CELADON_CITY

.XYTriggers:
	db 0

.Signposts:
	db 0

.PersonEvents:
	db 3
	person_event SPRITE_GRAMPS, 1, 4, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_SCRIPT, 0, CeladonHotelGrampsScript, -1
	person_event SPRITE_COOLTRAINER_F, 4, 7, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, CeladonHotelCooltrainerFScript, -1
	person_event SPRITE_RICH_BOY, 3, 9, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, CeladonHotelRichBoyGeraldScript, -1
