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

; Which meta tile are we facing, which should we replace it with, and which animation?

.shamouti_island
	db $95, $4c, $01
.johto_traditional
.johto_modern
.johto_overcast
.valencia_island
	db $03, $02, $01
	db -1

.kanto
	db $94, $0a, $01
	db $95, $0a, $01
	db $96, $0a, $01
	db $97, $0a, $01
	db $98, $0a, $01
	db $99, $0a, $01
	db $9c, $0a, $01
	db $9d, $0a, $01
	db $a0, $0a, $01
	db $a1, $0a, $01
.indigo_plateau
	db $0b, $0a, $01
	db -1

.park
	db $03, $04, $01
	db $13, $03, $01
	db -1

.forest
	db $03, $01, $01
	db $07, $05, $01
	db $13, $11, $01
	db $17, $19, $01
	db $3b, $37, $01
	db $4b, $47, $01
	db $57, $0b, $01
	db -1

.safari_zone
	db $03, $01, $01
	db $07, $03, $01
	db $24, $20, $01
	db $25, $21, $01
	db $26, $22, $01
	db $27, $23, $01
	db $28, $0a, $01
	db $29, $0a, $01
	db $2a, $0a, $01
	db $2b, $0a, $01
	db $2c, $28, $01
	db $2d, $29, $01
	db $2e, $2a, $01
	db $2f, $2b, $01
	db $4b, $27, $01
	db -1

.faraway_island
	db $03, $02, $01
	db $08, $74, $01
	db $09, $75, $01
	db $0a, $76, $01
	db $0b, $77, $01
	db $0c, $02, $01
	db $0d, $02, $01
	db $0e, $02, $01
	db $0f, $02, $01
	db -1

WhirlpoolBlockPointers:
	dbw TILESET_JOHTO_TRADITIONAL, .johto_traditional
	dbw TILESET_JOHTO_MODERN, .johto_modern
	dbw TILESET_JOHTO_OVERCAST, .johto_overcast
	db -1

.johto_traditional
.johto_overcast
	db $07, $07, $00
	db -1

.johto_modern
	db $83, $83, $00
	db -1
