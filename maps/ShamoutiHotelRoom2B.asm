const_value set 2

ShamoutiHotelRoom2B_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

ShamoutiHotelRoom2B_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 2
	warp_def $5, $3, 4, SHAMOUTI_HOTEL_2F
	warp_def $5, $4, 4, SHAMOUTI_HOTEL_2F

.XYTriggers:
	db 0

.Signposts:
	db 0

.PersonEvents:
	db 0
