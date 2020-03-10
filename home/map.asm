; Functions dealing with rendering and interacting with maps.

CheckTriggers::
; Checks wCurrentMapTriggerPointer.  If it's empty, returns -1 in a.  Otherwise, returns the active trigger ID in a.
	push hl
	ld hl, wCurrentMapTriggerPointer
	ld a, [hli]
	ld h, [hl]
	ld l, a
	or h
	ld a, [hl]
	jr nz, .triggerexists
	ld a, -1

.triggerexists
	pop hl
	ret

GetCurrentMapTrigger::
; Grabs the wram map trigger pointer for the current map and loads it into wCurrentMapTriggerPointer.
; If there are no triggers, both bytes of wCurrentMapTriggerPointer are wiped clean.
; Copy the current map group and number into bc.  This is needed for GetMapTrigger.
	ld a, [wMapGroup]
	ld b, a
	ld a, [wMapNumber]
	ld c, a
; Blank out wCurrentMapTriggerPointer; this is the default scenario.
	xor a
	ld [wCurrentMapTriggerPointer], a
	ld [wCurrentMapTriggerPointer + 1], a
	call GetMapTrigger
	ret c ; The map is not in the trigger table
; Load the trigger table pointer from de into wCurrentMapTriggerPointer
	ld a, e
	ld [wCurrentMapTriggerPointer], a
	ld a, d
	ld [wCurrentMapTriggerPointer + 1], a
	xor a
	ret

GetMapTrigger::
; Searches the trigger table for the map group and number loaded in bc, and returns the wram pointer in de.
; If the map is not in the trigger table, returns carry.
	anonbankpush MapTriggers

.Function:
	ld hl, MapTriggers
	ld de, 4
	jr .handleLoop
.loop
	pop hl
	add hl, de
.handleLoop
	push hl
	ld a, [hli] ; map group, or terminator
	cp -1
	jr z, .end ; the current map is not in the trigger table
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

	call SwitchToMapScriptHeaderBank
	call .GetDestinationWarpNumber

	pop de
	ld a, d
	rst Bankswitch
	ret

.GetDestinationWarpNumber:
	ld a, [wPlayerStandingMapY]
	sub $4
	ld e, a
	ld a, [wPlayerStandingMapX]
	sub $4
	ld d, a
	ld a, [wCurrMapWarpCount]
	and a
	ret z

	ld c, a
	ld hl, wCurrMapWarpHeaderPointer
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
	jr nz, .next
	jr .found_warp

.next
	pop hl
	ld a, 5
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

	ld a, [wCurrMapWarpCount]
	inc a
	sub c
	ld c, a
	scf
	ret

CopyWarpData::
	ldh a, [hROMBank]
	push af

	call SwitchToMapScriptHeaderBank
	call .CopyWarpData

	pop af
	rst Bankswitch
	scf
	ret

.CopyWarpData:
	push bc
	ld hl, wCurrMapWarpHeaderPointer
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, c
	dec a
	ld bc, 5 ; warp size
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

CheckOutdoorMapOrPerm5::
	cp PERM_5
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
	ld a, [wTileset]
	ld [wOldTileset], a
	call CopyMapHeaders
	call SwitchToMapScriptHeaderBank
	xor a ; FALSE
	jr ReadMapScripts

LoadMapAttributes_Continue::
	ld a, -1
	ld [wOldTileset], a
	call CopyMapHeaders
	call SwitchToMapScriptHeaderBank
	ld a, TRUE
	; fallthrough
ReadMapScripts::
	push af
	ld hl, wMapScriptHeaderPointer
	ld a, [hli]
	ld h, [hl]
	ld l, a
	call ReadMapTriggers
	call ReadMapCallbacks
	call ReadWarps
	call ReadCoordEvents
	call ReadSignposts
	pop af
	and a
	ret nz
	; fallthrough
ReadObjectEvents::
	push hl
	call ClearObjectStructs
	pop de
	ld hl, wMap1Object
	ld a, [de]
	inc de
	ld [wCurrentMapPersonEventCount], a
	ld a, e
	ld [wCurrentMapPersonEventHeaderPointer], a
	ld a, d
	ld [wCurrentMapPersonEventHeaderPointer + 1], a

	ld a, [wCurrentMapPersonEventCount]
	call CopyMapObjectHeaders

; get NUM_OBJECTS - 1 - [wCurrentMapPersonEventCount]
	ld a, [wCurrentMapPersonEventCount]
	ld c, a
	ld a, NUM_OBJECTS - 1
	sub c
	jr z, .skip
	jr c, .skip
	inc hl
; Fill the remaining sprite IDs and y coords with 0 and -1, respectively.
	ld bc, OBJECT_LENGTH
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

CopySecondMapHeader::
	ld de, wMapHeader
	ld c, 10 ; size of the second map header
.loop
	ld a, [hli]
	ld [de], a
	inc de
	dec c
	jr nz, .loop
	ret

CopyMapHeaders::
	call PartiallyCopyMapHeader
	call SwitchToMapBank
	call GetSecondaryMapHeaderPointer
	call CopySecondMapHeader
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

ReadMapTriggers::
	ld a, [hli] ; trigger count
	ld c, a
	ld [wCurrMapTriggerCount], a ; current map trigger count
	ld a, l
	ld [wCurrMapTriggerHeaderPointer], a ; map trigger pointer
	ld a, h
	ld [wCurrMapTriggerHeaderPointer + 1], a
	ld a, c
	and a
	ret z

	ld bc, 2 ; size of a map trigger header entry
	rst AddNTimes
	ret

ReadMapCallbacks::
	ld a, [hli]
	ld c, a
	ld [wCurrMapCallbackCount], a
	ld a, l
	ld [wCurrMapCallbackHeaderPointer], a
	ld a, h
	ld [wCurrMapCallbackHeaderPointer + 1], a
	ld a, c
	and a
	ret z

	ld bc, 3
	rst AddNTimes
	ret

ReadWarps::
	ld a, [hli]
	ld c, a
	ld [wCurrMapWarpCount], a
	ld a, l
	ld [wCurrMapWarpHeaderPointer], a
	ld a, h
	ld [wCurrMapWarpHeaderPointer + 1], a
	ld a, c
	and a
	ret z
	ld bc, 5
	rst AddNTimes
	ret

ReadCoordEvents::
	ld a, [hli]
	ld c, a
	ld [wCurrentMapXYTriggerCount], a
	ld a, l
	ld [wCurrentMapXYTriggerHeaderPointer], a
	ld a, h
	ld [wCurrentMapXYTriggerHeaderPointer + 1], a

	ld a, c
	and a
	ret z

	ld bc, 5
	rst AddNTimes
	ret

ReadSignposts::
	ld a, [hli]
	ld c, a
	ld [wCurrentMapSignpostCount], a
	ld a, l
	ld [wCurrentMapSignpostHeaderPointer], a
	ld a, h
	ld [wCurrentMapSignpostHeaderPointer + 1], a

	ld a, c
	and a
	ret z

	ld bc, 5
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
	ld b, MAPOBJECT_FLAG_HI - MAPOBJECT_SPRITE + 1 ; size of person_event
.loop2
	ld a, [de]
	inc de
	ld [hli], a
	dec b
	jr nz, .loop2

	pop hl
	ld bc, OBJECT_LENGTH
	add hl, bc
	pop bc
	dec c
	jr nz, .loop
	ret

ClearObjectStructs::
	ld hl, wObject1Struct
	ld bc, OBJECT_STRUCT_LENGTH * (NUM_OBJECT_STRUCTS - 1)
	xor a
	jp ByteFill

RestoreFacingAfterWarp::
	call SwitchToMapScriptHeaderBank

	ld hl, wMapScriptHeaderPointer
	ld a, [hli]
	ld h, [hl]
	ld l, a

	; get to the warp coords
	ld a, [hli] ; get map trigger count
	ld bc, 2 ; size of an entry in the map trigger table
	rst AddNTimes
	ld a, [hli] ; get callback count
	ld bc, 3 ; size of an entry in the callback table
	rst AddNTimes
	inc hl ; skip warp count
	ld a, [wWarpNumber]
	dec a
	ld bc, 5 ; size of an entry in the warps table
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
	farjp GetCoordOfUpperLeftCorner

LoadBlockData::
	ldh a, [hVBlank]
	push af
	ld a, 2
	ldh [hVBlank], a
	ld hl, wOverworldMap
	ld bc, wOverworldMapEnd - wOverworldMap
	xor a
	call ByteFill
	call ChangeMap
	call FillMapConnections
	ld a, MAPCALLBACK_TILES
	call RunMapCallback
	pop af
	ldh [hVBlank], a
	ret

ChangeMap::
	ld a, [wMapBlockDataBank]
	ld b, a
	ld hl, wMapBlockDataPointer
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
	ld hl, wOverworldMap

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
	call GetAnyMapBlockdataBankPointer
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
	call GetAnyMapBlockdataBankPointer
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
	call GetAnyMapBlockdataBankPointer
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
	call GetAnyMapBlockdataBankPointer
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
	ld a, [wMapScriptHeaderBank]
	jr CallScript

RunMapCallback::
; Will run the first callback found in the map header with execution index equal to a.
	ld b, a
	ldh a, [hROMBank]
	push af
	call SwitchToMapScriptHeaderBank
	call .FindCallback
	jr nc, .done

	ld a, [wMapScriptHeaderBank]
	ld b, a
	ld d, h
	ld e, l
	call ExecuteCallbackScript

.done
	pop af
	rst Bankswitch
	ret

.FindCallback:
	ld a, [wCurrMapCallbackCount]
	ld c, a
	and a
	ret z
	ld hl, wCurrMapCallbackHeaderPointer
	ld a, [hli]
	ld h, [hl]
	ld l, a
	or h
	ret z
	ld de, 3
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
	call SpeechTextBox
	call SafeUpdateSprites
	ld a, 1
	ldh [hOAMUpdate], a
	call ApplyTilemap
	pop hl
	call PrintTextBoxText
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
	jumptextfaceplayer ObjectEventText

ObjectEventText::
	text_jump _ObjectEventText
	db "@"

EndEvent::
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
	add l
	ld l, a
	adc h
	sub l
	ld h, a
	dec c
	ret

ScrollMapDown::
	call ReloadWalkedTile
	hlcoord 0, 0
	ld de, wBGMapBuffer + 8
	call BackupBGMapRow
	hlcoord 0, 0, wAttrMap
	ld de, wBGMapPalBuffer + 8
	call BackupBGMapRow
	ld a, [wBGMapAnchor]
	ld e, a
	ld a, [wBGMapAnchor + 1]
	ld d, a
	call UpdateBGMapRow
	ld a, $1
	ldh [hBGMapUpdate], a
	ret

ScrollMapUp::
	call ReloadWalkedTile
	hlcoord 0, SCREEN_HEIGHT - 2
	ld de, wBGMapBuffer + 8
	call BackupBGMapRow
	hlcoord 0, SCREEN_HEIGHT - 2, wAttrMap
	ld de, wBGMapPalBuffer + 8
	call BackupBGMapRow
	ld hl, wBGMapAnchor
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld bc, $0200
	add hl, bc
; cap d at vBGMap1 / $100
	ld a, h
	and %00000011
	or vBGMap0 / $100
	ld e, l
	ld d, a
	call UpdateBGMapRow
	ld a, $1
	ldh [hBGMapUpdate], a
	ret

ScrollMapRight::
	call ReloadWalkedTile
	hlcoord 0, 0
	ld de, wBGMapBuffer + 8
	call BackupBGMapColumn
	hlcoord 0, 0, wAttrMap
	ld de, wBGMapPalBuffer + 8
	call BackupBGMapColumn
	ld a, [wBGMapAnchor]
	ld e, a
	ld a, [wBGMapAnchor + 1]
	ld d, a
	call UpdateBGMapColumn
	ld a, $1
	ldh [hBGMapUpdate], a
	ret

ScrollMapLeft::
	call ReloadWalkedTile
	hlcoord SCREEN_WIDTH - 2, 0
	ld de, wBGMapBuffer + 8
	call BackupBGMapColumn
	hlcoord SCREEN_WIDTH - 2, 0, wAttrMap
	ld de, wBGMapPalBuffer + 8
	call BackupBGMapColumn
	ld a, [wBGMapAnchor]

	; add SCREEN_HEIGHT, but wrap-around the last 5 bits
	swap a
	rrca
	add SCREEN_HEIGHT << 3
	rlca
	swap a
	ld e, a
	ld a, [wBGMapAnchor + 1]
	ld d, a
	call UpdateBGMapColumn
	ld a, $1
	ldh [hBGMapUpdate], a
	ret

BackupBGMapRow::
	ld c, 2 * SCREEN_WIDTH
.loop
	ld a, [hli]
	ld [de], a
	inc de
	dec c
	jr nz, .loop
	ret

BackupBGMapColumn::
	ld c, SCREEN_HEIGHT
.loop
	ld a, [hli]
	ld [de], a
	inc de
	ld a, [hl]
	ld [de], a
	inc de
	ld a, SCREEN_WIDTH - 1
	add l
	ld l, a
	adc h
	sub l
	ld h, a
	dec c
	jr nz, .loop
	ret

UpdateBGMapRow::
	ld hl, wBGMapBufferPtrs + 8
	push de
	call .iteration
	pop de
	ld a, BG_MAP_WIDTH
	add e
	ld e, a

.iteration
	ld c, 10
.loop
	ld a, e
	ld [hli], a
	ld a, d
	ld [hli], a
	ld a, e
	inc a
	inc a
	and $1f
	ld b, a
	ld a, e
	and $e0
	or b
	ld e, a
	dec c
	jr nz, .loop
	ld a, SCREEN_WIDTH + 4
	ldh [hBGMapTileCount], a
	ret

UpdateBGMapColumn::
	ld hl, wBGMapBufferPtrs + 8
	ld c, SCREEN_HEIGHT
.loop
	ld a, e
	ld [hli], a
	ld a, d
	ld [hli], a
	ld a, BG_MAP_HEIGHT
	add e
	ld e, a
	jr nc, .skip
	inc d
; cap d at vBGMap1 / $100
	ld a, d
	and $3
	or vBGMap0 / $100
	ld d, a

.skip
	dec c
	jr nz, .loop
	ld a, SCREEN_HEIGHT + 4
	ldh [hBGMapTileCount], a
	ret

LoadGraphicsAndDelay::
	push hl
	push de
	push bc
	ldh a, [rVBK]
	push af
	xor a
	ldh [hDelayFrameLY], a

	; only allow this if we have time to spare
	ldh a, [rLY]
	cp $20
	jr nc, .done

	ld a, [wPendingOverworldGraphics]
	and a
	jr z, .done

	dec a
	ld [wPendingOverworldGraphics], a
	call _LoadTileset
	xor a
	ldh [hTileAnimFrame], a

.done
	ldh a, [hDelayFrameLY]
	and a
	call z, DelayFrame
	pop af
	ldh [rVBK], a
	jp PopBCDEHL

_LoadTileset:
; Loads one of up to 3 tileset groups depending on a
	jr z, _LoadTileset0
	dec a
	jr z, _LoadTileset1
_LoadTileset2:
	ld a, 1
	ldh [rVBK], a
	ld hl, wTilesetGFX2Address
	ld a, [wTilesetGFX2Bank]
	ld de, vTiles4
	jr _DoLoadTileset

_LoadTileset0:
	ldh a, [rSVBK]
	push af
	xor a
	ldh [rVBK], a
	inc a
	ldh [rSVBK], a

	; Check roof tiles
	ld a, [wTileset]
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
	call _DoLoadTileset0
	jr .done

.skip_roof
	ld hl, wTilesetGFX0Address
	ld a, [wTilesetGFX0Bank]
	ld de, vTiles2
	ld c, $7f
	call _DoLoadTileset0
.done
	pop af
	ldh [rSVBK], a
	ret

_LoadTileset1:
	ld a, 1
	ldh [rVBK], a
	ld hl, wTilesetGFX1Address
	ld a, [wTilesetGFX1Bank]
	ld de, vTiles5
	; fallthrough

_DoLoadTileset:
	ld c, $80
_DoLoadTileset0:
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

LoadTileset::
	xor a
	ld [wPendingOverworldGraphics], a
	call _LoadTileset1
	call _LoadTileset2
	call _LoadTileset0
	xor a
	ldh [hTileAnimFrame], a
	ret

BufferScreen::
	ld hl, wOverworldMapAnchor
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld de, wScreenSave
	lb bc, $6, $5
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
	add $6
	ld c, a
	ld b, $0
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
	ld de, wScreenSave + 6
	ldh a, [hMapObjectIndexBuffer]
	ld c, a
	ld b, $0
	add hl, bc
	jr .vertical

.down
	ld de, wScreenSave
.vertical
	lb bc, 6, 4
	jr SaveScreen_LoadNeighbor

.left
	ld de, wScreenSave + 1
	inc hl
	jr .horizontal

.right
	ld de, wScreenSave
.horizontal
	lb bc, 5, 5
	jr SaveScreen_LoadNeighbor

LoadNeighboringBlockData::
	ld hl, wOverworldMapAnchor
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, [wMapWidth]
	add 6
	ldh [hConnectionStripLength], a
	ld de, wScreenSave
	lb bc, 6, 5

SaveScreen_LoadNeighbor::
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
	ld a, e
	add 6
	ld e, a
	jr nc, .okay
	inc d

.okay
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
	ld hl, .MovementPermissionsData
	add l
	ld l, a
	adc h
	sub l
	ld h, a
	ld a, [hl]
	ld hl, wTilePermissions
	or [hl]
	ld [hl], a
	ret

.MovementPermissionsData:
	db 1 << DOWN
	db 1 << UP
	db 1 << LEFT
	db 1 << RIGHT
	db (1 << DOWN) | (1 << RIGHT)
	db (1 << UP) | (1 << RIGHT)
	db (1 << DOWN) | (1 << LEFT)
	db (1 << UP) | (1 << LEFT)

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
	and a
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
	cp $b0
	ret

GetFacingTileCoord::
; Return map coordinates in (d, e) and tile id in a
; of the tile the player is facing.

	ld a, [wPlayerDirection]
	and %1100
	srl a
	srl a
	ld l, a
	ld h, 0
	add hl, hl
	add hl, hl
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
	ld hl, wOverworldMap + 1
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

CheckFacingSign::
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
; If there are no signposts, we don't need to be here.
	ld a, [wCurrentMapSignpostCount]
	and a
	ret z

	ld c, a
	ldh a, [hROMBank]
	push af
	call SwitchToMapScriptHeaderBank
	call CheckIfFacingTileCoordIsSign
	pop hl
	ld a, h
	rst Bankswitch
	ret

CheckIfFacingTileCoordIsSign::
; Checks to see if you are facing a signpost.  If so, copies it into wEngineBuffer1 and sets carry.
	ld hl, wCurrentMapSignpostHeaderPointer
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
	jr nz, .next
	jr .copysign

.next
	pop hl
	ld a, 5 ; signpost event length
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
	ld de, wCurSignpostYCoord
	ld bc, 5 ; signpost event length
	rst CopyBytes
	scf
	ret

CheckCurrentMapXYTriggers::
; If there are no xy triggers, we don't need to be here.
	ld a, [wCurrentMapXYTriggerCount]
	and a
	ret z
; Copy the trigger count into c.
	ld c, a
	ldh a, [hROMBank]
	push af
	call SwitchToMapScriptHeaderBank
	call .TriggerCheck
	pop hl
	ld a, h
	rst Bankswitch
	ret

.TriggerCheck:
; Checks to see if you are standing on an xy-trigger.  If yes, copies the trigger to wEngineBuffer1 and sets carry.
	ld hl, wCurrentMapXYTriggerHeaderPointer
	ld a, [hli]
	ld h, [hl]
	ld l, a
; Load the active trigger ID into b
	call CheckTriggers
	ld b, a
; Load your current coordinates into de.  This will be used to check if your position is in the xy-trigger table for the current map.
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
	jr nz, .next
	jr .copytrigger

.next
	pop hl
	ld a, $5 ; xy-trigger size
	add l
	ld l, a
	adc h
	sub l
	ld h, a
	dec c
	jr nz, .loop
	xor a
	ret

.copytrigger
	pop hl
	ld de, wCurCoordEventTriggerID
	ld bc, 5 ; xy-trigger size
	rst CopyBytes
	scf
	ret

FadeToMenu::
	xor a
	ldh [hBGMapMode], a
	call LoadStandardMenuDataHeader
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
	call TextBox
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
	farcall ReloadVisibleSprites
	call LoadStandardFont
	call LoadFontsExtra
	ldh a, [hROMBank]
	push af
	ld a, [wMapGroup]
	ld b, a
	ld a, [wMapNumber]
	ld c, a
	call SwitchToAnyMapBank
	farcall UpdateTimeOfDayPal
	call LoadMapPart
	call LoadTileset
	ld a, 9
	call SkipMusic
	pop af
	rst Bankswitch

	jp EnableLCD

GetMapHeaderPointer::
	ld a, [wMapGroup]
	ld b, a
	ld a, [wMapNumber]
	ld c, a
GetAnyMapHeaderPointer::
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

	; find the cth map header
	dec c
	ld b, 0
	ld a, 9
	rst AddNTimes
	ret

GetMapHeaderMember::
; Extract data from the current map's header.

; inputs:
; de = offset of desired data within the mapheader

; outputs:
; bc = data from the current map's header
; (e.g., de = $0003 would return a pointer to the secondary map header)

	ld a, [wMapGroup]
	ld b, a
	ld a, [wMapNumber]
	ld c, a
GetAnyMapHeaderMember::
	; bankswitch
	ldh a, [hROMBank]
	push af
	ld a, BANK(MapGroupPointers)
	rst Bankswitch

	call GetAnyMapHeaderPointer
	add hl, de
	ld c, [hl]
	inc hl
	ld b, [hl]

	; bankswitch back
	pop af
	rst Bankswitch
	ret

SwitchToMapBank::
	ld a, [wMapGroup]
	ld b, a
	ld a, [wMapNumber]
	ld c, a
SwitchToAnyMapBank::
	call GetAnyMapBank
	rst Bankswitch
	ret

GetAnyMapBank::
	push hl
	push de
	ld de, 0
	call GetAnyMapHeaderMember
	ld a, c
	pop de
	pop hl
	ret

PartiallyCopyMapHeader::
; Copy second map header bank, tileset, permission, and second map header address
; from the current map's map header.
	ldh a, [hROMBank]
	push af
	ld a, BANK(MapGroupPointers)
	rst Bankswitch

	call GetMapHeaderPointer
	ld de, wSecondMapHeaderBank
	ld bc, wMapHeader - wSecondMapHeaderBank
	rst CopyBytes

	pop af
	rst Bankswitch
	ret

SwitchToMapScriptHeaderBank::
	ld a, [wMapScriptHeaderBank]
	rst Bankswitch
	ret

GetAnyMapBlockdataBankPointer::
; Return the blockdata bank for group b map c.
	push de
	push bc

	push bc
	ld de, 3 ; second map header pointer
	call GetAnyMapHeaderMember
	ld l, c
	ld h, b
	pop bc

	push hl
	ld de, 0 ; second map header bank
	call GetAnyMapHeaderMember
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

GetSecondaryMapHeaderPointer::
; returns the current map's secondary map header pointer in hl.
	push bc
	push de
	ld de, 3 ; secondary map header pointer (offset within header)
	call GetMapHeaderMember
	ld l, c
	ld h, b
	pop de
	pop bc
	ret

GetMapPermission::
	push hl
	push de
	push bc
	ld de, 2 ; permission
	call GetMapHeaderMember
	ld a, c
	jp PopBCDEHL

GetAnyMapPermission::
	push hl
	push de
	push bc
	ld de, 2 ; permission
	call GetAnyMapHeaderMember
	ld a, c
	jp PopBCDEHL

GetAnyMapTileset::
	ld de, 1 ; tileset
	call GetAnyMapHeaderMember
	ld a, c
	ret

GetWorldMapLocation::
; given a map group/id in bc, return its location on the Pokégear map.
	push hl
	push de
	push bc

	ld de, 5 ; landmark
	call GetAnyMapHeaderMember
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

GetMapHeaderMusic::
	push hl
	push bc
	ld de, 6 ; music
	call GetMapHeaderMember
	ld a, c
	cp MUSIC_RADIO_TOWER
	jr z, .radiotower
	cp MUSIC_MAHOGANY_MART
	jr z, .mahoganymart
	cp MUSIC_LAVENDER
	jr z, .lavender
	call Function8b342
	ld e, c
	ld d, 0
.done
	pop bc
	pop hl
	ret

.radiotower
	ld a, [wStatusFlags2]
	bit 0, a ; ENGINE_ROCKETS_IN_RADIO_TOWER
	jr z, .clearedradiotower
	ld de, MUSIC_ROCKET_OVERTURE
	jr .done

.clearedradiotower
	ld de, MUSIC_GOLDENROD_CITY
	jr .done

.mahoganymart
	ld a, [wStatusFlags2]
	bit 7, a ; ENGINE_ROCKETS_IN_MAHOGANY
	jr z, .clearedmahogany
	ld de, MUSIC_ROCKET_HIDEOUT
	jr .done

.clearedmahogany
	ld de, MUSIC_CHERRYGROVE_CITY
	jr .done

.lavender
	ld a, [wStatusFlags2]
	bit 6, a ; ENGINE_EXORCISED_LAV_RADIO_TOWER
	jr z, .exorcisedlavradiotower
	ld de, MUSIC_LAVENDER_TOWN_RBY
	jr .done

.exorcisedlavradiotower
	ld de, MUSIC_LAVENDER_TOWN
	jr .done

Function8b342:
	call GetSecondaryMapHeaderPointer
	ld d, h
	ld e, l
	ret

GetMapHeaderTimeOfDayNybble::
	call GetPhoneServiceTimeOfDayByte
	and $f
	ret

GetMapHeaderPhoneServiceNybble::
	call GetPhoneServiceTimeOfDayByte
	and $f0
	swap a
	ret

GetPhoneServiceTimeOfDayByte::
	push hl
	push bc

	ld de, 7 ; phone service and time of day
	call GetMapHeaderMember
	ld a, c

	pop bc
	pop hl
	ret

GetFishingGroup::
	push de
	push hl
	push bc

	ld de, 8 ; fishing group
	call GetMapHeaderMember
	ld a, c

	jp PopBCDEHL

TilesetUnchanged::
; returns z if tileset is unchanged from last tileset
	push bc
	ld a, [wOldTileset]
	ld b, a
	ld a, [wTileset]
	cp b
	pop bc
	ret

LoadTilesetHeader::
	call TilesetUnchanged
	ret z
	push hl
	push bc

	ld hl, Tilesets
	ld bc, wTilesetHeaderEnd - wTilesetHeader
	ld a, [wTileset]
	dec a
	rst AddNTimes

	ld de, wTilesetHeader
	ld bc, wTilesetHeaderEnd - wTilesetHeader

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
