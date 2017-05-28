const_value set 2

ShamoutiHotelRestaurant_MapScriptHeader:
.MapTriggers:
	db 2

	; triggers
	maptrigger .Trigger0
	maptrigger .Trigger1

.MapCallbacks:
	db 0

.Trigger0:
	end

.Trigger1:
	end

ShamoutiHotelRestaurant_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 2
	warp_def $7, $10, 4, SHAMOUTI_HOTEL_1F
	warp_def $7, $11, 4, SHAMOUTI_HOTEL_1F

.XYTriggers:
	db 0

.Signposts:
	db 0

.PersonEvents:
	db 0
