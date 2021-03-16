CutGrassBlockPointers:
; Which tileset are we in?
	dbw TILESET_JOHTO_TRADITIONAL, .johto_traditional
	dbw TILESET_JOHTO_MODERN, .johto_modern
	dbw TILESET_JOHTO_OVERCAST, .johto_overcast
	dbw TILESET_KANTO, .kanto
	dbw TILESET_INDIGO_PLATEAU, .indigo_plateau
	dbw TILESET_PARK, .park
	dbw TILESET_FOREST, .forest
	dbw TILESET_SAFARI_ZONE, .safari_zone
	dbw TILESET_SHAMOUTI_ISLAND, .shamouti_island
	dbw TILESET_VALENCIA_ISLAND, .valencia_island
	dbw TILESET_FARAWAY_ISLAND, .faraway_island
	db -1

; Which meta tile are we facing, and which should we replace it with?

.shamouti_island
	db $95, $4c
.johto_traditional
.johto_modern
.johto_overcast
.valencia_island
	db $03, $02
	db -1

.kanto
	db $94, $0a
	db $95, $0a
	db $96, $0a
	db $97, $0a
	db $98, $0a
	db $99, $0a
	db $9c, $0a
	db $9d, $0a
	db $a0, $0a
	db $a1, $0a
.indigo_plateau
	db $0b, $0a
	db -1

.park
	db $03, $04
	db $13, $03
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

.safari_zone
	db $03, $01
	db $07, $03
	db $24, $20
	db $25, $21
	db $26, $22
	db $27, $23
	db $28, $0a
	db $29, $0a
	db $2a, $0a
	db $2b, $0a
	db $2c, $28
	db $2d, $29
	db $2e, $2a
	db $2f, $2b
	db $4b, $27
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

WhirlpoolBlockPointers:
	dbw TILESET_JOHTO_TRADITIONAL, .johto_traditional
	dbw TILESET_JOHTO_MODERN, .johto_modern
	dbw TILESET_JOHTO_OVERCAST, .johto_overcast
	db -1

.johto_traditional
.johto_overcast
	db $07, $07
	db -1

.johto_modern
	db $83, $83
	db -1
