CutGrassBlockPointers:
; Which tileset are we in?
	dbw TILESET_JOHTO_TRADITIONAL, .johto_traditional
	dbw TILESET_JOHTO_MODERN, .johto_modern
	dbw TILESET_JOHTO_OUTLANDS, .johto_outlands
	dbw TILESET_JOHTO_ANCIENT, .johto_ancient
	dbw TILESET_KANTO, .kanto
	dbw TILESET_INDIGO_PLATEAU, .indigo_plateau
	dbw TILESET_SHAMOUTI_ISLAND, .shamouti_island
	dbw TILESET_VALENCIA_ISLAND, .valencia_island
	dbw TILESET_FARAWAY_ISLAND, .faraway_island
	dbw TILESET_FOREST, .forest
	dbw TILESET_PARK, .park
	dbw TILESET_SAFARI_ZONE, .safari_zone
	db -1

; Which meta tile are we facing, and which should we replace it with?

.johto_traditional
	db $f9, $02
.johto_modern
.johto_ancient
.valencia_island
	db $03, $02
	db -1

.johto_outlands
	db $03, $02
	db $4f, $03 ; long
	db $92, $8e
	db $93, $8f
	db $97, $02
	db -1

.kanto
	db $0b, $0a
	db $87, $94
	db -1

.indigo_plateau
	db $0b, $0a
	db $a2, $f9
	db $a3, $14
	db $bc, $0a
	db $bd, $0a
	db $be, $0a
	db $bf, $0a
	db $c0, $0a
	db $c1, $0a
	db $c4, $0a
	db $c5, $0a
	db $c8, $0a
	db $c9, $0a
	db $cd, $4c
	db $d0, $ce
	db $d1, $4c
	db $d2, $6f
	db $e5, $e8
	db $ea, $c2
	db $ed, $fa
	db -1

.shamouti_island
	db $03, $02
	db $95, $4c
	db -1

.faraway_island
	db $03, $02
	db $08, $74
	db $09, $75
	db $0a, $76
	db $0b, $77
	db $0c, $02
	db $0d, $02
	db $0e, $02
	db $0f, $02
	db -1

.forest
	db $03, $01
	db $07, $05
	db $13, $11
	db $17, $19
	db $3b, $37
	db $4b, $47
	db $57, $0b
	db -1

.park
	db $03, $04
	db $13, $03 ; long
	db -1

.safari_zone
	db $03, $01
	db $07, $03 ; long
	db $24, $20
	db $25, $21
	db $26, $22
	db $27, $23
	db $28, $0a
	db $29, $0a
	db $2a, $0a
	db $2b, $0a
	db $2c, $28 ; long
	db $2d, $29 ; long
	db $2e, $2a ; long
	db $2f, $2b ; long
	db $4b, $27
	db -1

WhirlpoolBlockPointers:
	dbw TILESET_JOHTO_TRADITIONAL, .johto_traditional
	dbw TILESET_JOHTO_MODERN, .johto_modern
	dbw TILESET_JOHTO_OUTLANDS, .johto_outlands
	db -1

.johto_traditional
.johto_outlands
	db $07, $07
	db -1

.johto_modern
	db $83, $83
	db -1
