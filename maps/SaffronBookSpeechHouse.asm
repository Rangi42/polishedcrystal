SaffronBookSpeechHouse_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

SaffronBookSpeechHouse_MapEventHeader:

.Warps: db 2
	warp_def 7, 2, 18, SAFFRON_CITY
	warp_def 7, 3, 18, SAFFRON_CITY

.XYTriggers: db 0

.Signposts: db 2
	signpost 1, 5, SIGNPOST_JUMPSTD, picturebookshelf
	signpost 1, 7, SIGNPOST_JUMPSTD, difficultbookshelf

.PersonEvents: db 2
	person_event SPRITE_LASS, 3, 2, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_PURPLE, PERSONTYPE_COMMAND, jumptextfaceplayer, SaffronBookSpeechHouseLassText, -1
	person_event SPRITE_BOOK, 3, 3, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_COMMAND, jumptext, SaffronBookSpeechHouseBookText, -1

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
