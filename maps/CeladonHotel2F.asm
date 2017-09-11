CeladonHotel2F_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

CeladonHotel2F_MapEventHeader:

.Warps: db 4
	warp_def 0, 16, 3, CELADON_HOTEL_1F
	warp_def 0, 4, 1, CELADON_HOTEL_ROOM_1
	warp_def 0, 8, 1, CELADON_HOTEL_ROOM_2
	warp_def 0, 12, 1, CELADON_HOTEL_ROOM_3

.XYTriggers: db 0

.Signposts: db 3
	signpost 0, 5, SIGNPOST_JUMPTEXT, CeladonHotel2FRoom1Text
	signpost 0, 9, SIGNPOST_JUMPTEXT, CeladonHotel2FRoom2Text
	signpost 0, 13, SIGNPOST_JUMPTEXT, CeladonHotel2FRoom3Text

.PersonEvents: db 1
	person_event SPRITE_TEACHER, 2, 11, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_COMMAND, jumptextfaceplayer, CeladonHotel2FTeacherText, -1

CeladonHotel2FTeacherText:
	text "I'm on a surprise"
	line "visit to see my"
	cont "son at university!"

	para "Hopefully he isn't"
	line "too embarrassed…"
	done

CeladonHotel2FRoom1Text:
	text "Room 1"
	done

CeladonHotel2FRoom2Text:
	text "Room 2"
	done

CeladonHotel2FRoom3Text:
	text "Room 3"
	done
