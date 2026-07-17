; tile IDs meant for COLL_COAST_SAND
; should be followed by:
; - upper-right vertical footprint
; - lower-left vertical footprint
; - upper horizontal footprint
; - lower horizontal footprint
; - horizontal bicycle track
; - vertical bicycle track

CoastSandTiles:
	db TILESET_JOHTO_TRADITIONAL, $a1 ; bank 1
	db TILESET_JOHTO_MODERN,      $b7 ; bank 1
	db TILESET_JOHTO_COAST,       $b7 ; bank 1
	db TILESET_SHAMOUTI_ISLAND,   $58 ; bank 1
	db 0 ; end
