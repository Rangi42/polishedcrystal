const_value set 2

PokemonTrainerFanClub_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

PokemonTrainerFanClub_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 2
	warp_def $9, $4, 16, SAFFRON_CITY
	warp_def $9, $5, 16, SAFFRON_CITY

.XYTriggers:
	db 0

.Signposts:
	db 0

.PersonEvents:
	db 0
