SaffronBookSpeechHouse_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 2 ; warp events
	warp_event  2,  7, SAFFRON_CITY, 18
	warp_event  3,  7, SAFFRON_CITY, 18

	db 0 ; coord events

	db 2 ; bg events
	bg_event  5,  1, SIGNPOST_JUMPSTD, picturebookshelf
	bg_event  7,  1, SIGNPOST_JUMPSTD, difficultbookshelf

	db 2 ; object events
	object_event  2,  3, SPRITE_LASS, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_PURPLE, PERSONTYPE_COMMAND, jumptextfaceplayer, SaffronBookSpeechHouseLassText, -1
	object_event  3,  3, SPRITE_BOOK_PAPER_POKEDEX, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, PERSONTYPE_COMMAND, jumptext, SaffronBookSpeechHouseBookText, -1

SaffronBookSpeechHouseLassText:
	text "I absolutely love"
	line "to read!"

	para "I borrowed a bunch"
	line "of books from the"

	para "university library"
	line "in Celadon."
	done

SaffronBookSpeechHouseBookText:
	text "It's a stack of"
	line "story books."

	para "The Princess and"
	line "the #mon,"

	para "Edward Scizor-"
	line "hands, Dr.Jekyll"
	cont "& Mr.Mime…"
	done
