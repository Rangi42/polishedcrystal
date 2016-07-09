const_value set 2

PokemonMansion1F_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

PokemonMansion1F_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 3
	warp_def $1b, $5, 3, CINNABAR_ISLAND
	warp_def $1b, $6, 3, CINNABAR_ISLAND
	warp_def $17, $15, 1, POKEMON_MANSION_B1F

.XYTriggers:
	db 0

.Signposts:
	db 0

.PersonEvents:
	db 0
