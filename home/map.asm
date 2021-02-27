; Functions dealing with rendering and interacting with maps.

CheckScenes::
; Checks wCurMapSceneScriptPointer.  If it's empty, returns -1 in a.  Otherwise, returns the active scene ID in a.
	push hl
	ld hl, wCurMapSceneScriptPointer
	ld a, [hli]
	ld h, [hl]
	ld l, a
	or h
	ld a, [hl]
	jr nz, .scene_exists
	ld a, -1

.scene_exists
	pop hl
	ret

GetCurrentMapSceneID::
; Grabs the wram map scene script pointer for the current map and loads it into wCurMapSceneScriptPointer.
; If there is no scene, both bytes of wCurMapSceneScriptPointer are wiped clean.
; Copy the current map group and number into bc.  This is needed for GetMapSceneID.
	ld a, [wMapGroup]
	ld b, a
	ld a, [wMapNumber]
	ld c, a
; Blank out wCurMapSceneScriptPointer; this is the default scenario.
	xor a
	ld [wCurMapSceneScriptPointer], a
	ld [wCurMapSceneScriptPointer + 1], a
	call GetMapSceneID
	ret c ; The map is not in the scene script table
; Load the scene script table pointer from de into wCurMapSceneScriptPointer
	ld a, e
	ld [wCurMapSceneScriptPointer], a
	ld a, d
	ld [wCurMapSceneScriptPointer + 1], a
	xor a
	ret

GetMapSceneID::
; Searches the scene_var table for the map group and number loaded in bc, and returns the wram pointer in de.
; If the map is not in the scene_var table, returns carry.
	anonbankpush MapScenes

.Function:
	ld hl, MapScenes
	ld de, 4 ; scene_var size
	jr .handleLoop
.loop
	pop hl
	add hl, de
.handleLoop
	push hl
	ld a, [hli] ; map group, or terminator
	cp -1
	jr z, .end ; the current map is not in the scene_var table
	cp b
	jr nz, .loop ; map group did not match
	ld a, [hli] ; map number
	cp c
	jr nz, .loop ; map number did not match
	ld a, [hli]
	ld d, [hl]
	ld e, a
	jr .done
.end
	scf
.done
	pop hl
	ret

LoadMapPart::
	farjp _LoadMapPart

ReturnToMapFromSubmenu::
	ld a, MAPSETUP_SUBMENU
	ldh [hMapEntryMethod], a
	farcall RunMapSetupScript
	xor a
	ldh [hMapEntryMethod], a
	ret

CheckWarpTile::
	call GetDestinationWarpNumber
	ret nc

	push bc
	farcall CheckDirectionalWarp
	pop bc
	ret nc

	call CopyWarpData
	scf
	ret

WarpCheck::
	call GetDestinationWarpNumber
	ret nc
	jp CopyWarpData

GetDestinationWarpNumber::
	farcall CheckWarpCollision
	ret nc

	ldh a, [hROMBank]
	push af

	call SwitchToMapScriptsBank
	call .GetDestinationWarpNumber

	pop de
	ld a, d
	rst Bankswitch
	ret

.GetDestinationWarpNumber:
	ld a, [wPlayerStandingMapY]
	sub 4
	ld e, a
	ld a, [wPlayerStandingMapX]
	sub 4
	ld d, a
	ld a, [wCurMapWarpCount]
	and a
	ret z

	ld c, a
	ld hl, wCurMapWarpsPointer
	ld a, [hli]
	ld h, [hl]
	ld l, a
.loop
	push hl
	ld a, [hli]
	cp e
	jr nz, .next
	ld a, [hli]
	cp d
	jr z, .found_warp

.next
	pop hl
	ld a, WARP_EVENT_SIZE
	; hl += a
	add l
	ld l, a
	adc h
	sub l
	ld h, a
	dec c
	jr nz, .loop
	xor a
	ret

.found_warp
	pop hl
	inc hl
	inc hl

	ld a, [wCurMapWarpCount]
	inc a
	sub c
	ld c, a
	scf
	ret

CopyWarpData::
	ldh a, [hROMBank]
	push af

	call SwitchToMapScriptsBank
	call .CopyWarpData

	pop af
	rst Bankswitch
	scf
	ret

.CopyWarpData:
	push bc
	ld hl, wCurMapWarpsPointer
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, c
	dec a
	ld bc, WARP_EVENT_SIZE
	rst AddNTimes
	ld bc, 2 ; warp number
	add hl, bc
	ld a, [hli]
	cp $ff
	jr nz, .skip
	ld hl, wBackupWarpNumber
	ld a, [hli]

.skip
	pop bc
	ld [wNextWarp], a
	ld a, [hli]
	ld [wNextMapGroup], a
	ld a, [hli]
	ld [wNextMapNumber], a

	ld a, c
	ld [wPrevWarp], a
	ld a, [wMapGroup]
	ld [wPrevMapGroup], a
	ld a, [wMapNumber]
	ld [wPrevMapNumber], a
	scf
	ret

CheckOutdoorOrIsolatedMap::
	cp ISOLATED
	ret z
CheckOutdoorMap::
	cp ROUTE
	ret z
	cp TOWN
	ret

CheckIndoorMap::
	cp INDOOR
	ret z
	cp CAVE
	ret z
	cp DUNGEON
	ret z
	cp GATE
	ret

LoadMapAttributes::
	ld a, [wMapTileset]
	ld [wOldTileset], a
	call CopyMapPartialAndAttributes
	call SwitchToMapScriptsBank
	xor a ; do not skip object events
	jr ReadMapScripts

LoadMapAttributes_SkipObjects::
	ld a, -1
	ld [wOldTileset], a
	call CopyMapPartialAndAttributes
	call SwitchToMapScriptsBank
	ld a, TRUE
	; fallthrough
ReadMapScripts::
	push af
	ld hl, wMapScriptsPointer
	ld a, [hli]
	ld h, [hl]
	ld l, a
	call ReadMapSceneScripts
	call ReadMapCallbacks
	call ReadWarps
	call ReadCoordEvents
	call ReadBGEvents
	pop af
	and a ; skip object events?
	ret nz
	; fallthrough
ReadObjectEvents::
	push hl
	call ClearObjectStructs
	pop de
	ld hl, wMap1Object
	ld a, [de]
	inc de
	ld [wCurMapObjectEventCount], a
	ld a, e
	ld [wCurMapObjectEventsPointer], a
	ld a, d
	ld [wCurMapObjectEventsPointer + 1], a

	ld a, [wCurMapObjectEventCount]
	call CopyMapObjectHeaders

; get NUM_OBJECTS - 1 - [wCurMapObjectEventCount]
	ld a, [wCurMapObjectEventCount]
	cp NUM_OBJECTS - 1
	jr nc, .skip
	; a = NUM_OBJECTS - 1 - a
	cpl
	add NUM_OBJECTS - 1 + 1
	inc hl
; Fill the remaining sprite IDs and y coords with 0 and -1, respectively.
	ld bc, MAPOBJECT_LENGTH
.loop
	ld [hl],  0
	inc hl
	ld [hl], -1
	dec hl
	add hl, bc
	dec a
	jr nz, .loop

.skip
	ld h, d
	ld l, e
	ret

CopyMapAttributes::
	ld de, wMapAttributes
	ld c, wMapAttributesEnd - wMapAttributes
.loop
	ld a, [hli]
	ld [de], a
	inc de
	dec c
	jr nz, .loop
	ret

CopyMapPartialAndAttributes::
; Copy map data bank, tileset, environment, and map data address
; from the current map's entry within its group.
	call CopyMapPartial
	call SwitchToMapAttributesBank
	call GetMapAttributesPointer
	call CopyMapAttributes
	; fallthrough
GetMapConnections::
	ld a, $ff
	ld [wNorthConnectedMapGroup], a
	ld [wSouthConnectedMapGroup], a
	ld [wWestConnectedMapGroup], a
	ld [wEastConnectedMapGroup], a

	ld a, [wMapConnections]
	ld b, a

	bit NORTH_F, b
	jr z, .no_north
	ld de, wNorthMapConnection
	call GetMapConnection
.no_north

	bit SOUTH_F, b
	jr z, .no_south
	ld de, wSouthMapConnection
	call GetMapConnection
.no_south

	bit WEST_F, b
	jr z, .no_west
	ld de, wWestMapConnection
	call GetMapConnection
.no_west

	bit EAST_F, b
	ret z
	ld de, wEastMapConnection
	; fallthrough
GetMapConnection::
; Load map connection struct at hl into de.
	ld c, wSouthMapConnection - wNorthMapConnection
.loop
	ld a, [hli]
	ld [de], a
	inc de
	dec c
	jr nz, .loop
	ret

ReadMapSceneScripts::
	ld a, [hli] ; scene_script count
	ld c, a
	ld [wCurMapSceneScriptCount], a
	ld a, l
	ld [wCurMapSceneScriptsPointer], a
	ld a, h
	ld [wCurMapSceneScriptsPointer + 1], a
	ld a, c
	and a
	ret z

	ld bc, SCENE_SCRIPT_SIZE
	rst AddNTimes
	ret

ReadMapCallbacks::
	ld a, [hli]
	ld c, a
	ld [wCurMapCallbackCount], a
	ld a, l
	ld [wCurMapCallbacksPointer], a
	ld a, h
	ld [wCurMapCallbacksPointer + 1], a
	ld a, c
	and a
	ret z

	ld bc, CALLBACK_SIZE
	rst AddNTimes
	ret

ReadWarps::
	ld a, [hli]
	ld c, a
	ld [wCurMapWarpCount], a
	ld a, l
	ld [wCurMapWarpsPointer], a
	ld a, h
	ld [wCurMapWarpsPointer + 1], a
	ld a, c
	and a
	ret z
	ld bc, WARP_EVENT_SIZE
	rst AddNTimes
	ret

ReadCoordEvents::
	ld a, [hli]
	ld c, a
	ld [wCurMapCoordEventCount], a
	ld a, l
	ld [wCurMapCoordEventsPointer], a
	ld a, h
	ld [wCurMapCoordEventsPointer + 1], a

	ld a, c
	and a
	ret z

	ld bc, COORD_EVENT_SIZE
	rst AddNTimes
	ret

ReadBGEvents::
	ld a, [hli]
	ld c, a
	ld [wCurMapBGEventCount], a
	ld a, l
	ld [wCurMapBGEventsPointer], a
	ld a, h
	ld [wCurMapBGEventsPointer + 1], a

	ld a, c
	and a
	ret z

	ld bc, BG_EVENT_SIZE
	rst AddNTimes
	ret

CopyMapObjectHeaders::
	and a
	ret z

	ld c, a
.loop
	push bc
	push hl
	ld a, $ff
	ld [hli], a
	ld b, OBJECT_EVENT_SIZE
.loop2
	ld a, [de]
	inc de
	ld [hli], a
	dec b
	jr nz, .loop2

	pop hl
	ld bc, MAPOBJECT_LENGTH
	add hl, bc
	pop bc
	dec c
	jr nz, .loop
	ret

ClearObjectStructs::
	ld hl, wObject1Struct
	ld bc, OBJECT_LENGTH * (NUM_OBJECT_STRUCTS - 1)
	xor a
	rst ByteFill
	ret

GetWarpDestCoords::
	call SwitchToMapScriptsBank

	ld hl, wMapScriptsPointer
	ld a, [hli]
	ld h, [hl]
	ld l, a

	; get to the warp coords
	ld a, [hli] ; get map scene script count
	ld bc, SCENE_SCRIPT_SIZE
	rst AddNTimes
	ld a, [hli] ; get callback count
	ld bc, CALLBACK_SIZE
	rst AddNTimes
	inc hl ; skip warp count
	ld a, [wWarpNumber]
	dec a
	ld bc, WARP_EVENT_SIZE
	rst AddNTimes

	ld a, [hli]
	ld [wYCoord], a
	ld a, [hli]
	ld [wXCoord], a
	ld a, [hli]
	cp -1
	jr nz, .skip

	ld a, [wPrevWarp]
	ld [wBackupWarpNumber], a
	ld a, [wPrevMapGroup]
	ld [wBackupMapGroup], a
	ld a, [wPrevMapNumber]
	ld [wBackupMapNumber], a

.skip
	farjp GetMapScreenCoords

LoadBlockData::
	ldh a, [hVBlank]
	push af
	ld a, 2
	ldh [hVBlank], a
	ld hl, wOverworldMapBlocks
	ld bc, wOverworldMapBlocksEnd - wOverworldMapBlocks
	xor a
	rst ByteFill
	call ChangeMap
	call FillMapConnections
	ld a, MAPCALLBACK_TILES
	call RunMapCallback
	pop af
	ldh [hVBlank], a
	ret

ChangeMap::
	ld a, [wMapBlocksBank]
	ld b, a
	ld hl, wMapBlocksPointer
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, [wMapWidth]
	ld d, a
	ld a, [wMapHeight]
	ld e, a

	call RunFunctionInWRA6

.Function:
	push de
	call FarDecompressAtB_D000
	pop de

	ld a, d
	ldh [hConnectedMapWidth], a
	add $6
	ldh [hConnectionStripLength], a
	ld hl, wOverworldMapBlocks

	ld c, a
	ld b, 0
	add hl, bc
	add hl, bc
	add hl, bc
	ld c, 3
	add hl, bc

	ld b, e
	ld de, wDecompressScratch
.row
	push hl
	ldh a, [hConnectedMapWidth]
	ld c, a
.col
	ld a, [de]
	inc de
	ld [hli], a
	dec c
	jr nz, .col
	pop hl
	ldh a, [hConnectionStripLength]
	; hl += a
	add l
	ld l, a
	adc h
	sub l
	ld h, a
	dec b
	jr nz, .row
	ret

DecompressConnectionMap:
	ldh a, [rSVBK]
	push af
	ld a, BANK(wDecompressScratch)
	ldh [rSVBK], a
	push de
	push bc
	ld de, wDecompressScratch
	call Decompress
	pop bc
	pop de
	pop af
	ldh [rSVBK], a
	ret

FillMapConnections::
; North
	ld a, [wNorthConnectedMapGroup]
	cp $ff
	jr z, .South
	ld b, a
	ld a, [wNorthConnectedMapNumber]
	ld c, a
	call GetAnyMapBlocksBank
	call DecompressConnectionMap

	ld hl, wNorthConnectionStripPointer
	ld a, [hli]
	ld h, [hl]
	ld l, a

	ld a, [wNorthConnectionStripLocation]
	ld e, a
	ld a, [wNorthConnectionStripLocation + 1]
	ld d, a
	ld a, [wNorthConnectionStripLength]
	ldh [hConnectionStripLength], a
	ld a, [wNorthConnectedMapWidth]
	ldh [hConnectedMapWidth], a
	call FillNorthConnectionStrip

.South
	ld a, [wSouthConnectedMapGroup]
	cp $ff
	jr z, .West
	ld b, a
	ld a, [wSouthConnectedMapNumber]
	ld c, a
	call GetAnyMapBlocksBank
	call DecompressConnectionMap

	ld hl, wSouthConnectionStripPointer
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, [wSouthConnectionStripLocation]
	ld e, a
	ld a, [wSouthConnectionStripLocation + 1]
	ld d, a
	ld a, [wSouthConnectionStripLength]
	ldh [hConnectionStripLength], a
	ld a, [wSouthConnectedMapWidth]
	ldh [hConnectedMapWidth], a
	call FillSouthConnectionStrip

.West
	ld a, [wWestConnectedMapGroup]
	cp $ff
	jr z, .East
	ld b, a
	ld a, [wWestConnectedMapNumber]
	ld c, a
	call GetAnyMapBlocksBank
	call DecompressConnectionMap

	ld hl, wWestConnectionStripPointer
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, [wWestConnectionStripLocation]
	ld e, a
	ld a, [wWestConnectionStripLocation + 1]
	ld d, a
	ld a, [wWestConnectionStripLength]
	ld b, a
	ld a, [wWestConnectedMapWidth]
	ldh [hConnectionStripLength], a
	call FillWestConnectionStrip

.East
	ld a, [wEastConnectedMapGroup]
	cp $ff
	ret z
	ld b, a
	ld a, [wEastConnectedMapNumber]
	ld c, a
	call GetAnyMapBlocksBank
	call DecompressConnectionMap

	ld hl, wEastConnectionStripPointer
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, [wEastConnectionStripLocation]
	ld e, a
	ld a, [wEastConnectionStripLocation + 1]
	ld d, a
	ld a, [wEastConnectionStripLength]
	ld b, a
	ld a, [wEastConnectedMapWidth]
	ldh [hConnectionStripLength], a

; fallthrough
FillWestConnectionStrip::
FillEastConnectionStrip::
	ld a, [wMapWidth]
	add 6
	ldh [hConnectedMapWidth], a

	ldh a, [rSVBK]
	push af
	ld a, BANK(wDecompressScratch)
	ldh [rSVBK], a
.loop
	push de

	push hl
	ld a, [hli]
	ld [de], a
	inc de
	ld a, [hli]
	ld [de], a
	inc de
	ld a, [hli]
	ld [de], a
	inc de
	pop hl

	ldh a, [hConnectionStripLength]
	ld e, a
	ld d, 0
	add hl, de
	pop de

	ldh a, [hConnectedMapWidth]
	; de += a
	add e
	ld e, a
	adc d
	sub e
	ld d, a
	dec b
	jr nz, .loop
	pop af
	ldh [rSVBK], a
	ret

FillNorthConnectionStrip::
FillSouthConnectionStrip::
	ld a, [wMapWidth]
	add 6
	ldh [hMapWidthPlus6], a
	ldh a, [rSVBK]
	push af
	ld a, BANK(wDecompressScratch)
	ldh [rSVBK], a

	ld c, 3
.y
	push de

	push hl
	ldh a, [hConnectionStripLength]
	ld b, a
.x
	ld a, [hli]
	ld [de], a
	inc de
	dec b
	jr nz, .x
	pop hl

	ldh a, [hConnectedMapWidth]
	ld e, a
	ld d, 0
	add hl, de
	pop de

	ldh a, [hMapWidthPlus6]
	; de += a
	add e
	ld e, a
	adc d
	sub e
	ld d, a
	dec c
	jr nz, .y
	pop af
	ldh [rSVBK], a
	ret

CallScript::
; Call a script at a:hl.

	ld [wScriptBank], a
	ld a, l
	ld [wScriptPos], a
	ld a, h
	ld [wScriptPos + 1], a

	ld a, PLAYEREVENT_MAPSCRIPT
	ld [wScriptRunning], a

	scf
	ret

CallMapScript::
; Call a script at hl in the current bank if there isn't already a script running
	ld a, [wScriptRunning]
	and a
	ret nz
	ld a, [wMapScriptsBank]
	jr CallScript

RunMapCallback::
; Will run the first callback found in the map header with execution index equal to a.
	ld b, a
	ldh a, [hROMBank]
	push af
	call SwitchToMapScriptsBank
	call .FindCallback
	jr nc, .done

	ld a, [wMapScriptsBank]
	ld b, a
	ld d, h
	ld e, l
	call ExecuteCallbackScript

.done
	pop af
	rst Bankswitch
	ret

.FindCallback:
	ld a, [wCurMapCallbackCount]
	ld c, a
	and a
	ret z
	ld hl, wCurMapCallbacksPointer
	ld a, [hli]
	ld h, [hl]
	ld l, a
	or h
	ret z
	ld de, CALLBACK_SIZE
.loop
	ld a, [hl]
	cp b
	jr z, .found
	add hl, de
	dec c
	jr nz, .loop
	xor a
	ret

.found
	inc hl
	ld a, [hli]
	ld h, [hl]
	ld l, a
	scf
	ret

ExecuteCallbackScript::
; Do map callback de and return to script bank b.
	farcall CallCallback
	ld a, [wScriptMode]
	push af
	ld hl, wScriptFlags
	ld a, [hl]
	push af
	set 1, [hl]
	farcall EnableScriptMode
	farcall ScriptEvents
	pop af
	ld [wScriptFlags], a
	pop af
	ld [wScriptMode], a
	ret

MapTextbox::
	ldh a, [hROMBank]
	push af

	ld a, b
	rst Bankswitch

	push hl
	call SpeechTextbox
	call SafeUpdateSprites
	ld a, 1
	ldh [hOAMUpdate], a
	call ApplyTilemap
	pop hl
	call PrintTextboxText
	xor a
	ldh [hOAMUpdate], a

	pop af
	rst Bankswitch
	ret

GetMovementData::
; Initialize the movement data for person c at b:hl
	ldh a, [hROMBank]
	push af
	ld a, b
	rst Bankswitch

	ld a, c
	call LoadMovementDataPointer

	pop hl
	ld a, h
	rst Bankswitch
	ret

GetScriptByte::
; Return byte at wScriptBank:wScriptPos in a.

	push hl
	push bc
	ldh a, [hROMBank]
	push af
	ld a, [wScriptBank]
	rst Bankswitch

	ld hl, wScriptPos
	ld c, [hl]
	inc hl
	ld b, [hl]

	ld a, [bc]

	inc bc
	ld [hl], b
	dec hl
	ld [hl], c

	ld b, a
	pop af
	rst Bankswitch
	ld a, b
	pop bc
	pop hl
	ret

ObjectEvent::
	faceplayer
	farjumptext _ObjectEventText

DoNothingScript::
	end

CheckObjectMask::
	ldh a, [hMapObjectIndexBuffer]
	ld e, a
	ld d, $0
	ld hl, wObjectMasks
	add hl, de
	ld a, [hl]
	ret

MaskObject::
	ldh a, [hMapObjectIndexBuffer]
	ld e, a
	ld d, $0
	ld hl, wObjectMasks
	add hl, de
	ld [hl], -1 ; , masked
	ret

UnmaskObject::
	ldh a, [hMapObjectIndexBuffer]
	ld e, a
	ld d, $0
	ld hl, wObjectMasks
	add hl, de
	ld [hl], 0 ; unmasked
	ret

ReloadWalkedTile:
; Update tile player is to walk on
	hlcoord 8, 6
	ld de, wBGMapBuffer
	call .CommitTiles
	hlcoord 8, 6, wAttrMap
	ld de, wBGMapPalBuffer
	call .CommitTiles
	ld a, [wBGMapAnchor]
	swap a
	rrca
	add 8 << 3
	rlca
	swap a
	add $c0
	ld l, a
	ld a, [wBGMapAnchor + 1]
	adc 0
	ld h, a
	ld c, 4
	ld de, wBGMapBufferPtrs
.ptr_loop
	ld a, h
	and HIGH($9800 | $9900 | $9a00 | $9b00) ; clamp within VRAM addresses
	ld h, a
	ld a, l
	ld [de], a
	inc de
	ld a, h
	ld [de], a
	inc de

	ld a, BG_MAP_WIDTH
	call .AddHLDecC
	jr nz, .ptr_loop
	ret

.CommitTiles:
	ld c, 4
.tile_loop
	ld a, [hli]
	ld [de], a
	inc de
	ld a, [hl]
	ld [de], a
	inc de
	ld a, SCREEN_WIDTH - 1
	call .AddHLDecC
	jr nz, .tile_loop
	ret

.AddHLDecC:
	; hl += a
	add l
	ld l, a
	adc h
	sub l
	ld h, a
	dec c
	ret

_LoadTilesetGFX:
; Loads one of up to 3 tileset groups depending on a
	jr z, _LoadTilesetGFX0
	dec a
	jr z, _LoadTilesetGFX1
_LoadTilesetGFX2:
	ld a, 1
	ldh [rVBK], a
	ld hl, wTilesetGFX2Address
	ld a, [wTilesetGFX2Bank]
	ld de, vTiles4
	jr _DoLoadTilesetGFX

_LoadTilesetGFX0:
	ldh a, [rSVBK]
	push af
	xor a
	ldh [rVBK], a
	inc a
	ldh [rSVBK], a

	; Check roof tiles
	ld a, [wMapTileset]
	cp TILESET_JOHTO_TRADITIONAL
	jr z, .load_roof
	cp TILESET_JOHTO_MODERN
	jr z, .load_roof
	cp TILESET_JOHTO_OVERCAST
	jr nz, .skip_roof

.load_roof
	farcall LoadMapGroupRoof
	ld hl, wTilesetGFX0Address
	ld a, [wTilesetGFX0Bank]
	ld de, vTiles2
	ld c, $ff
	call _DoLoadTilesetGFX0
	jr .done

.skip_roof
	ld hl, wTilesetGFX0Address
	ld a, [wTilesetGFX0Bank]
	ld de, vTiles2
	ld c, $7f
	call _DoLoadTilesetGFX0
.done
	pop af
	ldh [rSVBK], a
	ret

_LoadTilesetGFX1:
	ld a, 1
	ldh [rVBK], a
	ld hl, wTilesetGFX1Address
	ld a, [wTilesetGFX1Bank]
	ld de, vTiles5
	; fallthrough

_DoLoadTilesetGFX:
	ld c, $80
_DoLoadTilesetGFX0:
	ld b, a
	ld a, [hli]
	ld h, [hl]
	ld l, a

	; if the compressed GFX data starts with $ff, the decompressed data would
	; be empty, so don't decompress or copy
	ld a, b
	call GetFarByte
	inc a
	ret z

	inc c
	jr z, .special_load
	dec c
	jp DecompressRequest2bpp

.special_load
	; Skip roof tiles when writing to VRAM
	ld c, $7f
	push de
	push bc
	call FarDecompressWRA6InB
	pop bc
	pop hl
	ld de, wDecompressScratch
	ld c, $a ; write tiles $00-09
	call Request2bppInWRA6
	ld de, wDecompressScratch tile $13
	ld hl, vTiles2 tile $13
	ld c, $6c ; write tiles $13-$7e
	jp Request2bppInWRA6

LoadTilesetGFX::
	xor a
	ld [wPendingOverworldGraphics], a
	call _LoadTilesetGFX1
	call _LoadTilesetGFX2
	call _LoadTilesetGFX0
	xor a
	ldh [hTileAnimFrame], a
	ret

BufferScreen::
	ld hl, wOverworldMapAnchor
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld de, wScreenSave
	lb bc, SCREEN_META_WIDTH, SCREEN_META_HEIGHT
.row
	push bc
	push hl
.col
	ld a, [hli]
	ld [de], a
	inc de
	dec b
	jr nz, .col
	pop hl
	ld a, [wMapWidth]
	add 6
	ld c, a
	ld b, 0
	add hl, bc
	pop bc
	dec c
	jr nz, .row
	ret

SaveScreen::
	ld hl, wOverworldMapAnchor
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld de, wScreenSave
	ld a, [wMapWidth]
	add 6
	ldh [hMapObjectIndexBuffer], a
	ld a, [wPlayerStepDirection]
	and a
	jr z, .down
	cp UP
	jr z, .up
	cp LEFT
	jr z, .left
	cp RIGHT
	jr z, .right
	ret

.up
	ld de, wScreenSave + SCREEN_META_WIDTH
	ldh a, [hMapObjectIndexBuffer]
	ld c, a
	ld b, 0
	add hl, bc
	jr .vertical

.down
	ld de, wScreenSave
.vertical
	lb bc, SCREEN_META_WIDTH, SCREEN_META_HEIGHT - 1
	jr SaveScreen_LoadConnection

.left
	ld de, wScreenSave + 1
	inc hl
	jr .horizontal

.right
	ld de, wScreenSave
.horizontal
	lb bc, SCREEN_META_WIDTH - 1, SCREEN_META_HEIGHT
	jr SaveScreen_LoadConnection

LoadConnectionBlockData::
	ld hl, wOverworldMapAnchor
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, [wMapWidth]
	add 6
	ldh [hConnectionStripLength], a
	ld de, wScreenSave
	lb bc, SCREEN_META_WIDTH, SCREEN_META_HEIGHT

SaveScreen_LoadConnection::
.row
	push bc
	push hl
	push de
.col
	ld a, [de]
	inc de
	ld [hli], a
	dec b
	jr nz, .col
	pop de
	; de += 6
	ld a, e
	add 6
	ld e, a
	adc d
	sub e
	ld d, a
	pop hl
	ldh a, [hConnectionStripLength]
	ld c, a
	ld b, 0
	add hl, bc
	pop bc
	dec c
	jr nz, .row
	ret

GenericFinishBridge::
	ld a, 1
	ld [wOverworldDelaySkip], a
GetMovementPermissions::
	xor a
	ld [wTilePermissions], a
	call .LeftRight
	call .UpDown
; get coords of current tile
	ld a, [wPlayerStandingMapX]
	ld d, a
	ld a, [wPlayerStandingMapY]
	ld e, a
	call GetCoordTile
	ld [wPlayerStandingTile], a
	call .CheckHiNybble
	ret nz

	ld a, [wPlayerStandingTile]
	and 7
	; a = [.MovementPermissionsData + a]
	add LOW(.MovementPermissionsData)
	ld l, a
	adc HIGH(.MovementPermissionsData)
	sub l
	ld h, a
	ld a, [hl]
	ld hl, wTilePermissions
	or [hl]
	ld [hl], a
	ret

.MovementPermissionsData:
	db DOWN_MASK
	db UP_MASK
	db LEFT_MASK
	db RIGHT_MASK
	db DOWN_MASK | RIGHT_MASK
	db UP_MASK | RIGHT_MASK
	db DOWN_MASK | LEFT_MASK
	db UP_MASK | LEFT_MASK

.UpDown:
	ld a, [wPlayerStandingMapX]
	ld d, a
	ld a, [wPlayerStandingMapY]
	ld e, a

	push de
	inc e
	call GetCoordTile
	ld [wTileDown], a
	call .Down

	pop de
	dec e
	call GetCoordTile
	ld [wTileUp], a
	jp .Up

.LeftRight:
	ld a, [wPlayerStandingMapX]
	ld d, a
	ld a, [wPlayerStandingMapY]
	ld e, a

	push de
	dec d
	call GetCoordTile
	ld [wTileLeft], a
	call .Left

	pop de
	inc d
	call GetCoordTile
	ld [wTileRight], a
	jp .Right

.Down:
	call .CheckHiNybble
	ret nz
	ld a, [wTileDown]
	and 7
	cp $2
	jr z, .ok_down
	cp $6
	jr z, .ok_down
	cp $7
	ret nz

.ok_down
	ld a, [wTilePermissions]
	or FACE_DOWN
	ld [wTilePermissions], a
	ret

.Up:
	call .CheckHiNybble
	ret nz
	ld a, [wTileUp]
	and 7
	cp $3
	jr z, .ok_up
	cp $4
	jr z, .ok_up
	cp $5
	ret nz

.ok_up
	ld a, [wTilePermissions]
	or FACE_UP
	ld [wTilePermissions], a
	ret

.Right:
	call .CheckHiNybble
	ret nz
	ld a, [wTileRight]
	and 7
	cp $1
	jr z, .ok_right
	cp $5
	jr z, .ok_right
	cp $7
	ret nz

.ok_right
	ld a, [wTilePermissions]
	or FACE_RIGHT
	ld [wTilePermissions], a
	ret

.Left:
	call .CheckHiNybble
	ret nz
	ld a, [wTileLeft]
	and 7
	jr z, .ok_left
	cp $4
	jr z, .ok_left
	cp $6
	ret nz

.ok_left
	ld a, [wTilePermissions]
	or FACE_LEFT
	ld [wTilePermissions], a
	ret

.CheckHiNybble:
	and $f0
	cp HI_NYBBLE_SIDE_WALLS
	ret

GetFacingTileCoord::
; Return map coordinates in (d, e) and tile id in a
; of the tile the player is facing.

	ld a, [wPlayerDirection]
	and %1100
	ld l, a
	ld h, 0
	ld de, .Directions
	add hl, de

	ld d, [hl]
	inc hl
	ld e, [hl]
	inc hl

	ld a, [hli]
	ld h, [hl]
	ld l, a

	ld a, [wPlayerStandingMapX]
	add d
	ld d, a
	ld a, [wPlayerStandingMapY]
	add e
	ld e, a
	ld a, [hl]
	ret

.Directions:
	;   x,  y
	db  0,  1
	dw wTileDown
	db  0, -1
	dw wTileUp
	db -1,  0
	dw wTileLeft
	db  1,  0
	dw wTileRight

GetCoordTile::
; Get the collision byte for tile d, e
	call GetBlockLocation
	ld a, [hl]
	ld l, a
	ld h, $0
	add hl, hl
	add hl, hl
	ld a, h
	add HIGH(wDecompressedCollisions)
	ld h, a
	rr d
	jr nc, .nocarry
	inc hl

.nocarry
	rr e
	jr nc, .nocarry2
	inc hl
	inc hl

.nocarry2
	ld a, BANK(wDecompressedCollisions)
	jp GetFarWRAMByte

GetBlockLocation::
	ld a, [wMapWidth]
	add 6
	ld c, a
	ld b, 0
	ld hl, wOverworldMapBlocks + 1
	add hl, bc
	ld a, e
	srl a
	jr z, .nope
	and a
.loop
	srl a
	jr nc, .ok
	add hl, bc

.ok
	sla c
	rl b
	and a
	jr nz, .loop

.nope
	ld c, d
	srl c
	ld b, 0
	add hl, bc
	ret

CheckFacingBGEvent::
	call GetFacingTileCoord
; Load facing into b.
	ld b, a
; Convert the coordinates at de to within-boundaries coordinates.
	ld a, d
	sub 4
	ld d, a
	ld a, e
	sub 4
	ld e, a
; If there are no BG events, we don't need to be here.
	ld a, [wCurMapBGEventCount]
	and a
	ret z

	ld c, a
	ldh a, [hROMBank]
	push af
	call SwitchToMapScriptsBank
	call CheckIfFacingTileCoordIsBGEvent
	pop hl
	ld a, h
	rst Bankswitch
	ret

CheckIfFacingTileCoordIsBGEvent::
; Checks to see if you are facing a BG event.  If so, copies it into wCurBGEvent and sets carry.
	ld hl, wCurMapBGEventsPointer
	ld a, [hli]
	ld h, [hl]
	ld l, a
.loop
	push hl
	ld a, [hli]
	cp e
	jr nz, .next
	ld a, [hli]
	cp d
	jr z, .copysign

.next
	pop hl
	ld a, BG_EVENT_SIZE
	; hl += a
	add l
	ld l, a
	adc h
	sub l
	ld h, a
	dec c
	jr nz, .loop
	xor a
	ret

.copysign
	pop hl
	ld de, wCurBGEvent
	ld bc, BG_EVENT_SIZE
	rst CopyBytes
	scf
	ret

CheckCurrentMapCoordEvents::
; If there are no coord events, we don't need to be here.
	ld a, [wCurMapCoordEventCount]
	and a
	ret z
; Copy the coord event count into c.
	ld c, a
	ldh a, [hROMBank]
	push af
	call SwitchToMapScriptsBank
	call .CoordEventCheck
	pop hl
	ld a, h
	rst Bankswitch
	ret

.CoordEventCheck:
; Checks to see if you are standing on a coord event.  If yes, copies the coord event to wCurCoordEvent and sets carry.
	ld hl, wCurMapCoordEventsPointer
	ld a, [hli]
	ld h, [hl]
	ld l, a
; Load the active scene ID into b
	call CheckScenes
	ld b, a
; Load your current coordinates into de.  This will be used to check if your position is in the coord event table for the current map.
	ld a, [wPlayerStandingMapX]
	sub 4
	ld d, a
	ld a, [wPlayerStandingMapY]
	sub 4
	ld e, a

.loop
	push hl
	ld a, [hli]
	cp b
	jr z, .got_id
	cp -1
	jr nz, .next

.got_id
	ld a, [hli]
	cp e
	jr nz, .next
	ld a, [hli]
	cp d
	jr z, .copy_coord_event

.next
	pop hl
	ld a, COORD_EVENT_SIZE
	; hl += a
	add l
	ld l, a
	adc h
	sub l
	ld h, a
	dec c
	jr nz, .loop
	xor a
	ret

.copy_coord_event
	pop hl
	ld de, wCurCoordEventSceneID
	ld bc, COORD_EVENT_SIZE
	rst CopyBytes
	scf
	ret

FadeToMenu::
	xor a
	ldh [hBGMapMode], a
	call LoadStandardMenuHeader
	farcall FadeOutPalettes
	call ClearSprites
	jp DisableSpriteUpdates

CloseSubmenu::
	call ClearBGPalettes
	call ReloadTilesetAndPalettes
	call UpdateSprites
	call ExitMenu
	jr FinishExitMenu

ExitAllMenus::
	call ClearBGPalettes
	call ExitMenu
	call ReloadTilesetAndPalettes
	call UpdateSprites
FinishExitMenu::
	ld a, CGB_MAPPALS
	call GetCGBLayout
	farcall LoadBlindingFlashPalette
	call ApplyAttrAndTilemapInVBlank
	farcall FadeInPalettes
	jp EnableSpriteUpdates

ReturnToMapWithSpeechTextbox::
	push af
	ld a, $1
	ld [wSpriteUpdatesEnabled], a
	call ClearBGPalettes
	call ClearSprites
	call ReloadTilesetAndPalettes
	hlcoord 0, 12
	lb bc, 4, 18
	call Textbox
	ld hl, wVramState
	set 0, [hl]
	call UpdateSprites
	call ApplyAttrAndTilemapInVBlank
	ld a, CGB_MAPPALS
	call GetCGBLayout
	farcall LoadBlindingFlashPalette
	call UpdateTimePals
	call DelayFrame
	ld a, $1
	ldh [hMapAnims], a
	pop af
	ret

ReloadTilesetAndPalettes::
	call DisableLCD
	call ClearSprites
	farcall RefreshSprites
	call LoadStandardFont
	call LoadFontsExtra
	ldh a, [hROMBank]
	push af
	ld a, [wMapGroup]
	ld b, a
	ld a, [wMapNumber]
	ld c, a
	call SwitchToAnyMapAttributesBank
	farcall UpdateTimeOfDayPal
	call LoadMapPart
	call LoadTilesetGFX
	ld a, 9
	call SkipMusic
	pop af
	rst Bankswitch

	jp EnableLCD

GetMapPointer::
	ld a, [wMapGroup]
	ld b, a
	ld a, [wMapNumber]
	ld c, a
GetAnyMapPointer::
; Prior to calling this function, you must have switched banks so that
; MapGroupPointers is visible.

; inputs:
; b = map group, c = map number

; outputs:
; hl points to the map header
	push bc ; save map number for later

	; get pointer to map group
	dec b
	ld c, b
	ld b, 0
	ld hl, MapGroupPointers
	add hl, bc
	add hl, bc

	ld a, [hli]
	ld h, [hl]
	ld l, a
	pop bc ; restore map number

	; find the cth map within the group
	dec c
	ld b, 0
	ld a, 9
	rst AddNTimes
	ret

GetMapField::
; Extract data from the current map's group entry.

; inputs:
; de = offset of desired data within the map (a MAP_* constant)

; outputs:
; bc = data from the current map's field
; (e.g., de = MAP_TILESET would return a pointer to the tileset id)

	ld a, [wMapGroup]
	ld b, a
	ld a, [wMapNumber]
	ld c, a
GetAnyMapField::
	anonbankpush MapGroupPointers

.Function:
	call GetAnyMapPointer
	add hl, de
	ld c, [hl]
	inc hl
	ld b, [hl]
	ret

SwitchToMapAttributesBank::
	ld a, [wMapGroup]
	ld b, a
	ld a, [wMapNumber]
	ld c, a
SwitchToAnyMapAttributesBank::
	call GetAnyMapAttributesBank
	rst Bankswitch
	ret

GetAnyMapAttributesBank::
	push hl
	push de
	ld de, MAP_MAPATTRIBUTES_BANK
	call GetAnyMapField
	ld a, c
	pop de
	pop hl
	ret

CopyMapPartial::
; Copy map data bank, tileset, permission, and map data address
; from the current map's entry within its group.
	anonbankpush MapGroupPointers

.Function:
	call GetMapPointer
	ld de, wMapAttributesBank
	ld bc, wMapPartialEnd - wMapPartial
	rst CopyBytes
	ret

SwitchToMapScriptsBank::
	ld a, [wMapScriptsBank]
	rst Bankswitch
	ret

GetAnyMapBlocksBank::
; Return the blockdata bank for group b map c.
	push de
	push bc

	push bc
	ld de, MAP_MAPATTRIBUTES
	call GetAnyMapField
	ld l, c
	ld h, b
	pop bc

	push hl
	ld de, MAP_MAPATTRIBUTES_BANK
	call GetAnyMapField
	pop hl

	inc hl
	inc hl
	inc hl
	ld a, c
	rst Bankswitch
	ld a, [hli]
	ld c, a
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, c
	rst Bankswitch

	pop bc
	pop de
	ret

GetMapAttributesPointer::
; returns the current map's data pointer in hl.
	push bc
	push de
	ld de, MAP_MAPATTRIBUTES
	call GetMapField
	ld l, c
	ld h, b
	pop de
	pop bc
	ret

GetMapEnvironment::
	push hl
	push de
	push bc
	ld de, MAP_ENVIRONMENT
	call GetMapField
	ld a, c
	jp PopBCDEHL

GetAnyMapEnvironment::
	push hl
	push de
	push bc
	ld de, MAP_ENVIRONMENT
	call GetAnyMapField
	ld a, c
	jp PopBCDEHL

GetAnyMapTileset::
	ld de, MAP_TILESET
	call GetAnyMapField
	ld a, c
	ret

GetWorldMapLocation::
; given a map group/id in bc, return its location on the Pokégear map.
	push hl
	push de
	push bc

	ld de, MAP_LOCATION
	call GetAnyMapField
	ld a, c
	jp PopBCDEHL

GetCurrentLandmark::
	ld a, [wMapGroup]
	ld b, a
	ld a, [wMapNumber]
	ld c, a
	call GetWorldMapLocation
	and a ; cp SPECIAL_MAP
	ret nz

; In a special map, get the backup map group / map id
GetBackupLandmark::
	ld a, [wBackupMapGroup]
	ld b, a
	ld a, [wBackupMapNumber]
	ld c, a
	jp GetWorldMapLocation

RandomRegionCheck::
; Returns current region, like RegionCheck, except that Mt. Silver and Route 28
; is considered Kanto or Johto at random.
; e returns 0 in Johto, 1 in Kanto and 2 in Shamouti Island.
	call GetCurrentLandmark
	cp SILVER_CAVE
	jr z, .random
	cp ROUTE_28
	jr nz, RegionCheck
	; fallthrough
.random
	call Random
	and 1
	ld e, a
	ret

RegionCheck::
; Checks if the player is in Kanto or Johto.
; If in Johto, returns 0 in e.
; If in Kanto, returns 1 in e.
; If on Shamouti Island, returns 2 in e.
	call GetCurrentLandmark
	ld e, ORANGE_REGION
	cp SHAMOUTI_LANDMARK
	ret nc
	dec e ; KANTO_REGION
	cp KANTO_LANDMARK
	ret nc
	dec e ; JOHTO_REGION
	ret

GetMapMusic::
	push hl
	push bc
	ld de, MAP_MUSIC
	call GetMapField
	ld hl, SpecialMapMusic
.loop
	ld a, [hli]
	and a
	jr z, .done
	cp c
	jr nz, .next
	ld a, [hli]
	ld e, a
	ld a, [hli]
	ld d, a
	ld a, [de]
	ld b, a
	ld a, [hli]
	and b
	jr z, .false
	inc hl
.false
	ld a, [hl]
	ld c, a
.done
	ld e, c
	ld d, 0
	pop bc
	pop hl
	ret

.next
rept 5
	inc hl
endr
	jr .loop

GetMapTimeOfDay::
	call GetPhoneServiceTimeOfDayByte
	and $f
	ret

GetMapPhoneService::
	call GetPhoneServiceTimeOfDayByte
	and $f0
	swap a
	ret

GetPhoneServiceTimeOfDayByte::
	push hl
	push bc

	ld de, MAP_PALETTE
	call GetMapField
	ld a, c

	pop bc
	pop hl
	ret

GetFishingGroup::
	push de
	push hl
	push bc

	ld de, MAP_FISHGROUP
	call GetMapField
	ld a, c

	jp PopBCDEHL

TilesetUnchanged::
; returns z if tileset is unchanged from last tileset
	push bc
	ld a, [wOldTileset]
	ld b, a
	ld a, [wMapTileset]
	cp b
	pop bc
	ret

LoadMapTileset::
	call TilesetUnchanged
	ret z
	push hl
	push bc

	ld hl, Tilesets
	ld bc, wTilesetEnd - wTileset
	ld a, [wMapTileset]
	dec a
	rst AddNTimes

	ld de, wTilesetBank
	ld bc, wTilesetEnd - wTileset

	ld a, BANK(Tilesets)
	call FarCopyBytes

	pop bc
	pop hl
	ret

GetOvercastIndex::
; Some maps are overcast, depending on certain conditions
	ld a, [wMapGroup]
	cp GROUP_AZALEA_TOWN ; GROUP_ROUTE_33
	jr z, .azalea_route_33
	cp GROUP_LAKE_OF_RAGE ; GROUP_ROUTE_43
	jr z, .lake_of_rage_route_43
	cp GROUP_STORMY_BEACH ; GROUP_GOLDENROD_CITY, GROUP_ROUTE_34, GROUP_ROUTE_34_COAST
	jr z, .stormy_beach
.not_overcast:
	xor a ; NOT_OVERCAST
	ret

.azalea_route_33:
; Azalea Town and Route 33
	ld a, [wMapNumber]
	cp MAP_AZALEA_TOWN
	jr z, .azalea_town
	cp MAP_ROUTE_33
	jr nz, .not_overcast
.azalea_town
; Not overcast until Slowpokes appear (Team Rocket beaten)
	eventflagcheck EVENT_AZALEA_TOWN_SLOWPOKES
	jr nz, .not_overcast
; Overcast on Sunday, Tuesday, Thursday, and Saturday
	call GetWeekday
	cp MONDAY
	jr z, .not_overcast
	cp WEDNESDAY
	jr z, .not_overcast
	cp FRIDAY
	jr z, .not_overcast
	ld a, AZALEA_OVERCAST
	ret

.lake_of_rage_route_43:
; Lake of Rage and Route 43
	ld a, [wMapNumber]
	cp MAP_LAKE_OF_RAGE
	jr z, .lake_of_rage
	cp MAP_ROUTE_43
	jr nz, .not_overcast
.lake_of_rage
; Always overcast until civilians appear (Team Rocket beaten)
	eventflagcheck EVENT_LAKE_OF_RAGE_CIVILIANS
	jr nz, .overcast_lake_of_rage
; Overcast on Monday, Wednesday, and Friday
	call GetWeekday
	cp MONDAY
	jr z, .overcast_lake_of_rage
	cp WEDNESDAY
	jr z, .overcast_lake_of_rage
	cp FRIDAY
	jr nz, .not_overcast
.overcast_lake_of_rage
	ld a, LAKE_OF_RAGE_OVERCAST
	ret

.stormy_beach:
; Stormy Beach or Goldenrod City, Route 34, and Route 34 Coast
	ld a, [wMapNumber]
; Stormy Beach is always overcast
	cp MAP_STORMY_BEACH
	jr z, .overcast_stormy_beach
	cp MAP_ROUTE_34_COAST
	jr z, .maybe_stormy_beach
	cp MAP_ROUTE_34
	jr z, .maybe_stormy_beach
	cp MAP_GOLDENROD_CITY
	jr nz, .not_overcast
; Only overcast while Team Rocket is present
.maybe_stormy_beach
	eventflagcheck EVENT_GOLDENROD_CITY_ROCKET_TAKEOVER
	jr nz, .not_overcast
.overcast_stormy_beach
	ld a, STORMY_BEACH_OVERCAST
	ret
