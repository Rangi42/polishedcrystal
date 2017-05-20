const_value set 2

ShamoutiHotelRestaurant_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

ShamoutiHotelRestaurant_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 2
	warp_def $7, $f, 4, SHAMOUTI_HOTEL_1F
	warp_def $7, $10, 4, SHAMOUTI_HOTEL_1F

.XYTriggers:
	db 0

.Signposts:
	db 0

.PersonEvents:
	db 0
