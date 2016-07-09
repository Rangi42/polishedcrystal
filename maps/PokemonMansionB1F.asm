const_value set 2

PokemonMansionB1F_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

PokemonMansionB1F_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 1
	warp_def $18, $19, 3, POKEMON_MANSION_1F

.XYTriggers:
	db 0

.Signposts:
	db 0

.PersonEvents:
	db 0
