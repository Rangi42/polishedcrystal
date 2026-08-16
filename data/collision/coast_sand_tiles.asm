; tile IDs meant for COLL_COAST_SAND
; should be followed by:
; - upper-right vertical footprint
; - lower-left vertical footprint
; - upper horizontal footprint
; - lower horizontal footprint
; - horizontal bicycle track
; - vertical bicycle track

CoastSandTiles:
	db TILESET_JOHTO_TRADITIONAL, $a6 ; bank 1
	db TILESET_JOHTO_MODERN,      $98 ; bank 1
	db TILESET_JOHTO_COAST,       $98 ; bank 1
	db TILESET_JOHTO_SACRED,      $a6 ; bank 1
	db TILESET_SHAMOUTI_ISLAND,   $58 ; bank 1
	db 0 ; end
