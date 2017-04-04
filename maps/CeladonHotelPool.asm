const_value set 2

CeladonHotelPool_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

CeladonHotelPool_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 2
	warp_def $7, $a, 4, CELADON_HOTEL_1F
	warp_def $7, $b, 4, CELADON_HOTEL_1F

.XYTriggers:
	db 0

.Signposts:
	db 0

.PersonEvents:
	db 0
