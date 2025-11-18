HandleNewMap:
	call ResetOWMapState
	call GetCurrentMapSceneID
	ld a, MAPCALLBACK_NEWMAP
	call RunMapCallback
HandleContinueMap:
	xor a
	ld [wStoneTableAddress], a
	ld [wStoneTableAddress+1], a
	ld a, MAPCALLBACK_STONETABLE
	call RunMapCallback
	call GetMapTimeOfDay
	ld [wMapTimeOfDay], a
	ret

ResetOWMapState:
; reset flash if out of cave
	ld a, [wEnvironment]
	cp ROUTE
	jr z, .reset_flash
	cp TOWN
	jr nz, .keep_flash
.reset_flash
	ld hl, wStatusFlags
	res 2, [hl]
.keep_flash
	xor a
; reset map buffer event flags
	ld [wEventFlags], a
; reset ow state
	ld hl, wOWState
	ld [hli], a
	ld [hl], a
	ret

EnterMapConnection:
; Return carry if a connection has been entered.

	ld hl, wPalFlags
	set MAP_CONNECTION_PAL_F, [hl]

	ld hl, DualMapConnections
.dual_loop
; check end
	ld a, [hli]
	and a
	jr z, .not_dual
; check map group
	ld b, a
	ld a, [wMapGroup]
	cp b
	jr nz, .skip31
; check map number
	ld a, [hli]
	ld b, a
	ld a, [wMapNumber]
	cp b
	jr nz, .skip30
; check step direction
	ld a, [hli]
	ld b, a
	ld a, [wPlayerStepDirection]
	cp b
	jr nz, .skip29
; check coordinate
	ld a, [hli]
	ld e, a
	ld a, [hli]
	ld d, a
	ld a, [hli]
	ld b, a
	ld a, [de]
	cp b
; de = map connection struct
	ld a, [hli]
	ld e, a
	ld a, [hli]
	ld d, a
; hl = connection data
	jr c, .lesser
	ld bc, 12 ; size of connection
	add hl, bc
.lesser
	call GetMapConnection
	; fallthrough

.not_dual
	xor a
	ld hl, wFollowedWarpData
	ld bc, wFollowedWarpDataEnd - wFollowedWarpData
	rst ByteFill

	ld a, [wPlayerStepDirection]
	and a
	jmp z, EnterSouthConnection
	dec a
	jmp z, EnterNorthConnection
	dec a
	jr z, EnterWestConnection
	dec a
	jr z, EnterEastConnection
	ret

.skip31
	inc hl
.skip30
	inc hl
.skip29
	ld bc, 8 + 12 * 2 - 3 ; size of dual_connection, minus 3 bytes passed already
	add hl, bc
	jr .dual_loop

EnterWestConnection:
	ld a, [wWestConnectedMapGroup]
	ld [wMapGroup], a
	ld a, [wWestConnectedMapNumber]
	ld [wMapNumber], a
	ld a, [wXCoord]
	ld [wLastMapXCoord], a
	ld a, [wWestConnectionStripXOffset]
	ld [wXCoord], a
	ld a, [wYCoord]
	ld [wLastMapYCoord], a
	ld a, [wWestConnectionStripYOffset]
	ld hl, wYCoord
	add [hl]
	ld [hl], a
	ld c, a
	ld hl, wWestConnectionWindow
	ld a, [hli]
	ld h, [hl]
	ld l, a
	srl c
	ld a, [wWestConnectedMapWidth]
_FinishEastWestConnection:
	jr z, .skip_to_load
	add 6
	ld e, a
	ld d, 0

.loop
	add hl, de
	dec c
	jr nz, .loop

.skip_to_load
	ld a, l
	ld [wOverworldMapAnchor], a
	ld a, h
	ld [wOverworldMapAnchor + 1], a
	scf
	ret

EnterEastConnection:
	ld a, [wEastConnectedMapGroup]
	ld [wMapGroup], a
	ld a, [wEastConnectedMapNumber]
	ld [wMapNumber], a
	ld a, [wXCoord]
	ld [wLastMapXCoord], a
	ld a, [wEastConnectionStripXOffset]
	ld [wXCoord], a
	ld a, [wYCoord]
	ld [wLastMapYCoord], a
	ld a, [wEastConnectionStripYOffset]
	ld hl, wYCoord
	add [hl]
	ld [hl], a
	ld c, a
	ld hl, wEastConnectionWindow
	ld a, [hli]
	ld h, [hl]
	ld l, a
	srl c
	ld a, [wEastConnectedMapWidth]
	jr _FinishEastWestConnection

EnterNorthConnection:
	ld a, [wNorthConnectedMapGroup]
	ld [wMapGroup], a
	ld a, [wNorthConnectedMapNumber]
	ld [wMapNumber], a
	ld a, [wYCoord]
	ld [wLastMapYCoord], a
	ld a, [wNorthConnectionStripYOffset]
	ld [wYCoord], a
	ld a, [wXCoord]
	ld [wLastMapXCoord], a
	ld a, [wNorthConnectionStripXOffset]
	ld hl, wXCoord
	add [hl]
	ld [hl], a
	ld hl, wNorthConnectionWindow
	jr _FinishNorthSouthConnection

EnterSouthConnection:
	ld a, [wSouthConnectedMapGroup]
	ld [wMapGroup], a
	ld a, [wSouthConnectedMapNumber]
	ld [wMapNumber], a
	ld a, [wYCoord]
	ld [wLastMapYCoord], a
	ld a, [wSouthConnectionStripYOffset]
	ld [wYCoord], a
	ld a, [wXCoord]
	ld [wLastMapXCoord], a
	ld a, [wSouthConnectionStripXOffset]
	ld hl, wXCoord
	add [hl]
	ld [hl], a
	ld hl, wSouthConnectionWindow
_FinishNorthSouthConnection:
	ld c, a
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld b, 0
	srl c
	add hl, bc
	ld a, l
	ld [wOverworldMapAnchor], a
	ld a, h
	ld [wOverworldMapAnchor + 1], a
	scf
	ret

EnterMapWarp:
	call .SaveDigWarp
	call .SetSpawn
	ld a, [wNextWarp]
	ld [wWarpNumber], a
	ld a, [wNextMapGroup]
	ld [wMapGroup], a
	ld a, [wNextMapNumber]
	ld [wMapNumber], a
	ret

.SaveDigWarp:
	call GetMapEnvironment
	call CheckOutdoorOrIsolatedMap
	ret nz
	ld a, [wNextMapGroup]
	ld b, a
	ld a, [wNextMapNumber]
	ld c, a
	call GetAnyMapEnvironment
	call CheckIndoorMap
	ret nz
	ld a, [wPrevWarp]
	ld [wDigWarpNumber], a
	ld a, [wPrevMapGroup]
	ld [wDigMapGroup], a
	ld a, [wPrevMapNumber]
	ld [wDigMapNumber], a
	ret

.SetSpawn:
	call GetMapEnvironment
	call CheckOutdoorMap
	ret nz
	ld a, [wNextMapGroup]
	ld b, a
	ld a, [wNextMapNumber]
	ld c, a
	call GetAnyMapEnvironment
	call CheckIndoorMap
	ret nz
	ld a, [wNextMapGroup]
	ld b, a
	ld a, [wNextMapNumber]
	ld c, a
	call GetAnyMapTileset
	ld a, c
	cp TILESET_POKECENTER
	jr z, .pokecenter_pokecom
	cp TILESET_POKECOM_CENTER
	ret nz
.pokecenter_pokecom
	ld a, [wPrevMapGroup]
	ld [wLastSpawnMapGroup], a
	ld a, [wPrevMapNumber]
	ld [wLastSpawnMapNumber], a
	ret

LoadMapTimeOfDay:
	ld hl, wStateFlags
	res TEXT_STATE_F, [hl]
	ld a, TRUE
	ld [wSpriteUpdatesEnabled], a
	farcall ReplaceTimeOfDayPals
	farcall UpdateTimeOfDayPal
	call LoadMapPart
	call .ClearBGMap
	decoord 0, 0
	call .copy
	decoord 0, 0, wAttrmap
	ld a, $1
	ldh [rVBK], a
.copy
	hlbgcoord 0, 0
	lb bc, SCREEN_HEIGHT, SCREEN_WIDTH
.row
	push bc
.column
	ld a, [de]
	inc de
	ld [hli], a
	dec c
	jr nz, .column
	ld bc, TILEMAP_WIDTH - SCREEN_WIDTH
	add hl, bc
	pop bc
	dec b
	jr nz, .row
	xor a
	ldh [rVBK], a
	ret

.ClearBGMap:
	ld a, vBGMap0 / $100
	ld [wBGMapAnchor + 1], a
	xor a
	ld [wBGMapAnchor], a
	ldh [hSCY], a
	ldh [hSCX], a
	farcall ApplyBGMapAnchorToObjects
	ldh a, [rVBK]
	push af
	ld a, $1
	ldh [rVBK], a
	xor a
	ld bc, vBGMap1 - vBGMap0
	hlbgcoord 0, 0
	rst ByteFill
	pop af
	ldh [rVBK], a
	ld a, '<BLACK>'
	ld bc, vBGMap1 - vBGMap0
	hlbgcoord 0, 0
	rst ByteFill
	ret

DeferredLoadMapGraphics:
	call TilesetUnchanged
	jr z, .done
	call LoadMapTileset
	ld a, 3
	ld [wPendingOverworldGraphics], a
.done
	xor a
	ldh [hMapAnims], a
	ldh [hTileAnimFrame], a
	ret

LoadMapTilesetGFX:
	call LoadMapTileset
	call LoadTilesetGFX
	xor a
	ldh [hMapAnims], a
	ldh [hTileAnimFrame], a
	ret

LoadMapGraphics:
	call LoadMapTilesetGFX
	farjp RefreshSprites

LoadMapPalettes:
	ld a, CGB_MAPPALS
	jmp GetCGBLayout

RefreshMapSprites:
	call ClearSprites
	xor a
	ldh [hBGMapMode], a

	farcall InitMapNameSign
	call GetMovementPermissions
	farcall RefreshPlayerSprite
	farcall CheckUpdatePlayerSprite
	ld hl, wPlayerSpriteSetupFlags
	bit 6, [hl]
	jr nz, .skip
	ld hl, wStateFlags
	set SPRITE_UPDATES_DISABLED_F, [hl]
	call SafeUpdateSprites
.skip
	ld a, [wPlayerSpriteSetupFlags]
	and %00011100
	ld [wPlayerSpriteSetupFlags], a
	ret

CheckMovingOffEdgeOfMap::
	ld a, [wPlayerStepDirection]
	cp STANDING
	ret z
	and a ; DOWN
	jr z, .down
	cp UP
	jr z, .up
	cp LEFT
	jr z, .left
	cp RIGHT
	jr z, .right
	and a
	ret

.down
	ld a, [wPlayerMapY]
	sub 4
	ld b, a
	ld a, [wMapHeight]
	add a
	cp b
	jr z, .ok
	and a
	ret

.up
	ld a, [wPlayerMapY]
	sub 4
	cp -1
	jr z, .ok
	and a
	ret

.left
	ld a, [wPlayerMapX]
	sub $4
	cp -1
	jr z, .ok
	and a
	ret

.right
	ld a, [wPlayerMapX]
	sub 4
	ld b, a
	ld a, [wMapWidth]
	add a
	cp b
	jr z, .ok
	and a
	ret

.ok
	scf
	ret

GetMapScreenCoords::
	ld hl, wOverworldMapBlocks
	ld a, [wXCoord]
	bit 0, a
	jr nz, .increment_then_halve1
	srl a
	inc a
	jr .resume

.increment_then_halve1
	inc a
	srl a

.resume
	ld c, a
	ld b, $0
	add hl, bc
	ld a, [wMapWidth]
	add $6
	ld c, a
	ld b, $0
	ld a, [wYCoord]
	bit 0, a
	jr nz, .increment_then_halve2
	srl a
	inc a
	jr .resume2

.increment_then_halve2
	inc a
	srl a

.resume2
	rst AddNTimes
	ld a, l
	ld [wOverworldMapAnchor], a
	ld a, h
	ld [wOverworldMapAnchor + 1], a
	ld a, [wYCoord]
	and $1
	ld [wMetatileStandingY], a
	ld a, [wXCoord]
	and $1
	ld [wMetatileStandingX], a
	ret

INCLUDE "data/maps/dual_connections.asm"
