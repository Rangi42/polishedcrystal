LoadTileMapToTempTileMap::
; Load wTilemap into wTempTileMap
	ldh a, [rWBK]
	push af
	ld a, BANK(wTempTileMap)
	ldh [rWBK], a
	hlcoord 0, 0
	decoord 0, 0, wTempTileMap
	ld bc, wTilemapEnd - wTilemap
	rst CopyBytes
	pop af
	ldh [rWBK], a
	ret

LoadTempTileMapToTileMap::
; Load wTempTileMap into wTilemap
	ldh a, [rWBK]
	push af
	ld a, BANK(wTempTileMap)
	ldh [rWBK], a
	hlcoord 0, 0, wTempTileMap
	decoord 0, 0
	ld bc, wTilemapEnd - wTilemap
	rst CopyBytes
	pop af
	ldh [rWBK], a
	ret
