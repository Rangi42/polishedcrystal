EnvironmentColorsPointers:
	dw .OutdoorColors ; unused
	dw .OutdoorColors ; TOWN
	dw .OutdoorColors ; ROUTE
	dw .IndoorColors ; INDOOR
	dw .DungeonColors ; CAVE
	dw .IsolatedColors ; ISOLATED
	dw .IndoorColors ; GATE
	dw .DungeonColors ; DUNGEON

; Valid indices: $00 - $2b
.OutdoorColors:
.IsolatedColors:
	db $00, $01, $02, $28, $04, $05, $06, $07 ; morn
	db $08, $09, $0a, $29, $0c, $0d, $0e, $0f ; day
	db $10, $11, $12, $2a, $14, $15, $16, $17 ; nite
	db $18, $19, $1a, $2b, $1c, $1d, $1e, $1f ; eve

.IndoorColors:
	db $20, $21, $22, $23, $24, $25, $26, $27 ; morn
	db $20, $21, $22, $23, $24, $25, $26, $27 ; day
	db $10, $11, $12, $13, $14, $15, $16, $17 ; nite
	db $18, $19, $1a, $1b, $1c, $1d, $1e, $1f ; eve

.DungeonColors:
	db $00, $01, $02, $03, $04, $05, $06, $07 ; morn
	db $08, $09, $0a, $0b, $0c, $0d, $0e, $0f ; day
	db $10, $11, $12, $13, $14, $15, $16, $17 ; nite
	db $18, $19, $1a, $1b, $1c, $1d, $1e, $1f ; eve
