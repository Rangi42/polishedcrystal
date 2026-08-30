; Map connections listed here apply the destination palettes immediately.
; Each pair is automatically checked in both directions.

MACRO no_connection_palette_fade
	map_id \1
	map_id \2
	map_id \2
	map_id \1
ENDM

MapConnectionsWithoutPaletteFade:
	no_connection_palette_fade RUGGED_ROAD_NORTH, RUGGED_ROAD_SOUTH
	db -1 ; end
