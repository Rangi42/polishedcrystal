CeladonHotelPool_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

CeladonHotelPool_MapEventHeader:

.Warps: db 2
	warp_def 7, 10, 4, CELADON_HOTEL_1F
	warp_def 7, 11, 4, CELADON_HOTEL_1F

.XYTriggers: db 0

.Signposts: db 0

.PersonEvents: db 3
	person_event SPRITE_POKEFAN_M, 3, 10, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_COMMAND, jumptextfaceplayer, CeladonHotelPoolPokefanMText, -1
	person_event SPRITE_CHILD, 6, 4, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_COMMAND, jumptextfaceplayer, CeladonHotelPoolChildText, -1
	person_event SPRITE_SWIMMER_GUY, 3, 5, SPRITEMOVEDATA_SWIM_LEFT_RIGHT, 0, 1, -1, -1, (1 << 3) | PAL_OW_PURPLE, PERSONTYPE_SCRIPT, 0, CeladonHotelPoolSwimmerMScript, -1

CeladonHotelPoolSwimmerMScript:
	checkevent EVENT_GOT_SAFE_GOGGLES_FROM_CELADON
	iftrue_jumptextfaceplayer .Text2
	faceplayer
	opentext
	writetext .Text1
	buttonsound
	verbosegiveitem SAFE_GOGGLES
	iffalse_endtext
	setevent EVENT_GOT_SAFE_GOGGLES_FROM_CELADON
	thisopenedtext

.Text2:
	text "This is quite a"
	line "relaxing swim…"
	done

.Text1:
	text "For a slow back-"
	line "stroke, I don't"
	cont "need my goggles."

	para "You can have them."
	done

CeladonHotelPoolPokefanMText:
	text "Well, color me"
	line "impressed."

	para "This hotel's"
	line "facilities are"
	cont "second-to-none!"
	done

CeladonHotelPoolChildText:
	text "Whee!"
	done
