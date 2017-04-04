const_value set 2

CeladonHotel2F_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

CeladonHotel2F_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 4
	warp_def $0, $10, 3, CELADON_HOTEL_1F
	warp_def $0, $4, 1, CELADON_HOTEL_ROOM_1
	warp_def $0, $8, 1, CELADON_HOTEL_ROOM_2
	warp_def $0, $c, 1, CELADON_HOTEL_ROOM_3

.XYTriggers:
	db 0

.Signposts:
	db 0

.PersonEvents:
	db 0
