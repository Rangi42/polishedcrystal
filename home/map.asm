; Functions dealing with rendering and interacting with maps.

CheckTriggers:: ; 211b
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
; 212a

GetCurrentMapTrigger:: ; 212a
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
; 2147

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

LoadMapPart:: ; 217a
	farjp _LoadMapPart

ReturnToMapFromSubmenu::
	ld a, MAPSETUP_SUBMENU
	ld [hMapEntryMethod], a
	farcall RunMapSetupScript
	xor a
	ld [hMapEntryMethod], a
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

GetDestinationWarpNumber:: ; 2252
	farcall CheckWarpCollision
	ret nc

	ld a, [hROMBank]
	push af

	call SwitchToMapScriptHeaderBank
	call .GetDestinationWarpNumber

	pop de
	ld a, d
	rst Bankswitch
	ret
; 2266

.GetDestinationWarpNumber: ; 2266
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
	jr nc, .okay
	inc h

.okay
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

CopyWarpData:: ; 22a7
	ld a, [hROMBank]
	push af

	call SwitchToMapScriptHeaderBank
	call .CopyWarpData

	pop af
	rst Bankswitch
	scf
	ret
; 22b4

.CopyWarpData: ; 22b4
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
; 22ee

CheckOutdoorMapOrPerm5::
	cp PERM_5
	ret z
CheckOutdoorMap:: ; 22ee
	cp ROUTE
	ret z
	cp TOWN
	ret
; 22f4

CheckIndoorMap:: ; 22f4
	cp INDOOR
	ret z
	cp CAVE
	ret z
	cp DUNGEON
	ret z
	cp GATE
	ret
; 2300

LoadMapAttributes:: ; 2309
	call CopyMapHeaders
	call SwitchToMapScriptHeaderBank
	xor a ; FALSE
	jr ReadMapScripts
; 2317

LoadMapAttributes_SkipPeople:: ; 2317
	call CopyMapHeaders
	call SwitchToMapScriptHeaderBank
	ld a, TRUE
	; fallthrough
ReadMapScripts:: ; 234f
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
	jp ReadObjectEvents
; 235c

CopySecondMapHeader:: ; 235c
	ld de, wMapHeader
	ld c, 10 ; size of the second map header
.loop
	ld a, [hli]
	ld [de], a
	inc de
	dec c
	jr nz, .loop
	ret
; 2368

CopyMapHeaders:: ; 2326
	call PartiallyCopyMapHeader
	call SwitchToMapBank
	call GetSecondaryMapHeaderPointer
	call CopySecondMapHeader
	; fallthrough
GetMapConnections:: ; 2368
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

GetMapConnection:: ; 23a3
; Load map connection struct at hl into de.
	ld c, wSouthMapConnection - wNorthMapConnection
.loop
	ld a, [hli]
	ld [de], a
	inc de
	dec c
	jr nz, .loop
	ret
; 23ac

ReadMapTriggers:: ; 23ac
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
; 23c3

ReadMapCallbacks:: ; 23c3
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
; 23da

ReadWarps:: ; 23da
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
; 23f1

ReadCoordEvents:: ; 23f1
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
; 2408

ReadSignposts:: ; 2408
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
; 241f

ReadObjectEvents:: ; 241f
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
; 2457

CopyMapObjectHeaders:: ; 2457
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
; 2471

ClearObjectStructs:: ; 2471
	ld hl, wObject1Struct
	ld bc, OBJECT_STRUCT_LENGTH * (NUM_OBJECT_STRUCTS - 1)
	xor a
	jp ByteFill
; 248a

RestoreFacingAfterWarp:: ; 248a
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
; 24ba

LoadBlockData:: ; 24cd
	ld a, [hVBlank]
	push af
	ld a, 2
	ld [hVBlank], a
	ld hl, wOverworldMap
	ld bc, wOverworldMapEnd - wOverworldMap
	xor a
	call ByteFill
	call ChangeMap
	call FillMapConnections
	ld a, MAPCALLBACK_TILES
	call RunMapCallback
	pop af
	ld [hVBlank], a
	ret

ChangeMap:: ; 24e4
	ld a, [wMapBlockDataBank]
	ld b, a
	ld a, [wMapBlockDataPointer]
	ld l, a
	ld a, [wMapBlockDataPointer+1]
	ld h, a
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
	ld [hConnectedMapWidth], a
	add $6
	ld [hConnectionStripLength], a
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
	ld a, [hConnectedMapWidth]
	ld c, a
.col
	ld a, [de]
	inc de
	ld [hli], a
	dec c
	jr nz, .col
	pop hl
	ld a, [hConnectionStripLength]
	add l
	ld l, a
	jr nc, .okay
	inc h
.okay
	dec b
	jr nz, .row
	ret
; 2524

DecompressConnectionMap:
	ld a, [rSVBK]
	push af
	ld a, BANK(wDecompressScratch)
	ld [rSVBK], a
	push de
	push bc
	ld de, wDecompressScratch
	call Decompress
	pop bc
	pop de
	pop af
	ld [rSVBK], a
	ret

FillMapConnections:: ; 2524

; North
	ld a, [wNorthConnectedMapGroup]
	cp $ff
	jr z, .South
	ld b, a
	ld a, [wNorthConnectedMapNumber]
	ld c, a
	call GetAnyMapBlockdataBankPointer
	call DecompressConnectionMap

	ld a, [wNorthConnectionStripPointer]
	ld l, a
	ld a, [wNorthConnectionStripPointer + 1]
	ld h, a

	ld a, [wNorthConnectionStripLocation]
	ld e, a
	ld a, [wNorthConnectionStripLocation + 1]
	ld d, a
	ld a, [wNorthConnectionStripLength]
	ld [hConnectionStripLength], a
	ld a, [wNorthConnectedMapWidth]
	ld [hConnectedMapWidth], a
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

	ld a, [wSouthConnectionStripPointer]
	ld l, a
	ld a, [wSouthConnectionStripPointer + 1]
	ld h, a
	ld a, [wSouthConnectionStripLocation]
	ld e, a
	ld a, [wSouthConnectionStripLocation + 1]
	ld d, a
	ld a, [wSouthConnectionStripLength]
	ld [hConnectionStripLength], a
	ld a, [wSouthConnectedMapWidth]
	ld [hConnectedMapWidth], a
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

	ld a, [wWestConnectionStripPointer]
	ld l, a
	ld a, [wWestConnectionStripPointer + 1]
	ld h, a
	ld a, [wWestConnectionStripLocation]
	ld e, a
	ld a, [wWestConnectionStripLocation + 1]
	ld d, a
	ld a, [wWestConnectionStripLength]
	ld b, a
	ld a, [wWestConnectedMapWidth]
	ld [hConnectionStripLength], a
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

	ld a, [wEastConnectionStripPointer]
	ld l, a
	ld a, [wEastConnectionStripPointer + 1]
	ld h, a
	ld a, [wEastConnectionStripLocation]
	ld e, a
	ld a, [wEastConnectionStripLocation + 1]
	ld d, a
	ld a, [wEastConnectionStripLength]
	ld b, a
	ld a, [wEastConnectedMapWidth]
	ld [hConnectionStripLength], a

; fallthrough
FillWestConnectionStrip::
FillEastConnectionStrip:: ; 25f6
	ld a, [wMapWidth]
	add 6
	ld [hConnectedMapWidth], a

	ld a, [rSVBK]
	push af
	ld a, BANK(wDecompressScratch)
	ld [rSVBK], a
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

	ld a, [hConnectionStripLength]
	ld e, a
	ld d, 0
	add hl, de
	pop de

	ld a, [hConnectedMapWidth]
	add e
	ld e, a
	jr nc, .okay
	inc d
.okay
	dec b
	jr nz, .loop
	pop af
	ld [rSVBK], a
	ret
; 261b

FillNorthConnectionStrip::
FillSouthConnectionStrip:: ; 25d3
	ld a, [wMapWidth]
	add 6
	ld [hMapWidthPlus6], a
	ld a, [rSVBK]
	push af
	ld a, BANK(wDecompressScratch)
	ld [rSVBK], a

	ld c, 3
.y
	push de

	push hl
	ld a, [hConnectionStripLength]
	ld b, a
.x
	ld a, [hli]
	ld [de], a
	inc de
	dec b
	jr nz, .x
	pop hl

	ld a, [hConnectedMapWidth]
	ld e, a
	ld d, 0
	add hl, de
	pop de

	ld a, [hMapWidthPlus6]
	add e
	ld e, a
	jr nc, .okay
	inc d
.okay
	dec c
	jr nz, .y
	pop af
	ld [rSVBK], a
	ret
; 25f6

LoadMapStatus:: ; 261b
	ld [wMapStatus], a
	ret
; 261f

CallScript:: ; 261f
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
; 2631

CallMapScript:: ; 2631
; Call a script at hl in the current bank if there isn't already a script running
	ld a, [wScriptRunning]
	and a
	ret nz
	ld a, [wMapScriptHeaderBank]
	jr CallScript
; 263b

RunMapCallback:: ; 263b
; Will run the first callback found in the map header with execution index equal to a.
	ld b, a
	ld a, [hROMBank]
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
; 2653

.FindCallback: ; 2653
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
; 2674

ExecuteCallbackScript:: ; 2674
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
; 269a

MapTextbox:: ; 269a
	ld a, [hROMBank]
	push af

	ld a, b
	rst Bankswitch

	push hl
	call SpeechTextBox
	call SafeUpdateSprites
	ld a, 1
	ld [hOAMUpdate], a
	call ApplyTilemap
	pop hl
	call PrintTextBoxText
	xor a
	ld [hOAMUpdate], a

	pop af
	rst Bankswitch
	ret
; 26b7

Call_a_de:: ; 26b7
; Call a:de.

	ld [hBuffer], a
	ld a, [hROMBank]
	push af
	ld a, [hBuffer]
	rst Bankswitch

	call .de

	pop af
	rst Bankswitch
	ret

.de
	push de
	ret
; 26c7

GetMovementData:: ; 26c7
; Initialize the movement data for person c at b:hl
	ld a, [hROMBank]
	push af
	ld a, b
	rst Bankswitch

	ld a, c
	call LoadMovementDataPointer

	pop hl
	ld a, h
	rst Bankswitch
	ret
; 26d4

GetScriptByte:: ; 0x26d4
; Return byte at wScriptBank:wScriptPos in a.

	push hl
	push bc
	ld a, [hROMBank]
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
; 0x26ef

ObjectEvent:: ; 0x26ef
	jumptextfaceplayer ObjectEventText
; 0x26f2

ObjectEventText::
	text_jump _ObjectEventText
	db "@"
; 0x26f7

EndEvent::
	end

CheckObjectMask:: ; 2707
	ld a, [hMapObjectIndexBuffer]
	ld e, a
	ld d, $0
	ld hl, wObjectMasks
	add hl, de
	ld a, [hl]
	ret
; 2712

MaskObject:: ; 2712
	ld a, [hMapObjectIndexBuffer]
	ld e, a
	ld d, $0
	ld hl, wObjectMasks
	add hl, de
	ld [hl], -1 ; , masked
	ret
; 271e

UnmaskObject:: ; 271e
	ld a, [hMapObjectIndexBuffer]
	ld e, a
	ld d, $0
	ld hl, wObjectMasks
	add hl, de
	ld [hl], 0 ; unmasked
	ret
; 272a

ScrollMapDown:: ; 272a
	hlcoord 0, 0
	ld de, wBGMapBuffer
	call BackupBGMapRow
	hlcoord 0, 0, wAttrMap
	ld de, wBGMapPalBuffer
	call BackupBGMapRow
	ld a, [wBGMapAnchor]
	ld e, a
	ld a, [wBGMapAnchor + 1]
	ld d, a
	call UpdateBGMapRow
	ld a, $1
	ld [hBGMapUpdate], a
	ret
; 2748

ScrollMapUp:: ; 2748
	hlcoord 0, SCREEN_HEIGHT - 2
	ld de, wBGMapBuffer
	call BackupBGMapRow
	hlcoord 0, SCREEN_HEIGHT - 2, wAttrMap
	ld de, wBGMapPalBuffer
	call BackupBGMapRow
	ld a, [wBGMapAnchor]
	ld l, a
	ld a, [wBGMapAnchor + 1]
	ld h, a
	ld bc, $0200
	add hl, bc
; cap d at VBGMap1 / $100
	ld a, h
	and %00000011
	or VBGMap0 / $100
	ld e, l
	ld d, a
	call UpdateBGMapRow
	ld a, $1
	ld [hBGMapUpdate], a
	ret
; 2771

ScrollMapRight:: ; 2771
	hlcoord 0, 0
	ld de, wBGMapBuffer
	call BackupBGMapColumn
	hlcoord 0, 0, wAttrMap
	ld de, wBGMapPalBuffer
	call BackupBGMapColumn
	ld a, [wBGMapAnchor]
	ld e, a
	ld a, [wBGMapAnchor + 1]
	ld d, a
	call UpdateBGMapColumn
	ld a, $1
	ld [hBGMapUpdate], a
	ret
; 278f

ScrollMapLeft:: ; 278f
	hlcoord SCREEN_WIDTH - 2, 0
	ld de, wBGMapBuffer
	call BackupBGMapColumn
	hlcoord SCREEN_WIDTH - 2, 0, wAttrMap
	ld de, wBGMapPalBuffer
	call BackupBGMapColumn
	ld a, [wBGMapAnchor]
	ld e, a
	and %11100000
	ld b, a
	ld a, e
	add SCREEN_HEIGHT
	and %00011111
	or b
	ld e, a
	ld a, [wBGMapAnchor + 1]
	ld d, a
	call UpdateBGMapColumn
	ld a, $1
	ld [hBGMapUpdate], a
	ret
; 27b7

BackupBGMapRow:: ; 27b7
	ld c, 2 * SCREEN_WIDTH
.loop
	ld a, [hli]
	ld [de], a
	inc de
	dec c
	jr nz, .loop
	ret
; 27c0

BackupBGMapColumn:: ; 27c0
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
	jr nc, .skip
	inc h

.skip
	dec c
	jr nz, .loop
	ret
; 27d3

UpdateBGMapRow:: ; 27d3
	ld hl, wBGMapBufferPtrs
	push de
	call .iteration
	pop de
	ld a, $20
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
	ld a, SCREEN_WIDTH
	ld [hBGMapTileCount], a
	ret
; 27f8

UpdateBGMapColumn:: ; 27f8
	ld hl, wBGMapBufferPtrs
	ld c, SCREEN_HEIGHT
.loop
	ld a, e
	ld [hli], a
	ld a, d
	ld [hli], a
	ld a, $20
	add e
	ld e, a
	jr nc, .skip
	inc d
; cap d at VBGMap1 / $100
	ld a, d
	and $3
	or VBGMap0 / $100
	ld d, a

.skip
	dec c
	jr nz, .loop
	ld a, SCREEN_HEIGHT
	ld [hBGMapTileCount], a
	ret
; 2816

LoadTileset:: ; 2821
	ld hl, wTilesetGFXAddress
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, [wTilesetGFXBank]
	ld [hTilesetGFXBank], a

	ld a, BANK(wDecompressScratch)
	ld [rSVBK], a

	ld a, [hTilesetGFXBank]
	ld de, wDecompressScratch
	call FarDecompress

	ld hl, wDecompressScratch
	ld de, VTiles2
	ld bc, $7f tiles
	rst CopyBytes

	ld a, $1
	ld [rVBK], a

	ld hl, wDecompressScratch + $80 tiles
	ld de, VTiles5
	ld bc, $80 tiles
	rst CopyBytes

	ld a, $1
	ld [rSVBK], a

	ld hl, wTilesetGFX2Address
	ld a, [hli]
	and a
	jr z, .no_gfx2
	ld h, [hl]
	ld l, a

	ld a, BANK(wDecompressScratch)
	ld [rSVBK], a

	ld a, [hTilesetGFXBank]
	ld de, wDecompressScratch
	call FarDecompress

	ld hl, wDecompressScratch
	ld de, VTiles4
	ld bc, $80 tiles
	rst CopyBytes

.no_gfx2
	xor a
	ld [rVBK], a

	inc a
	ld [rSVBK], a

	ld a, [wTileset]
	cp TILESET_JOHTO_TRADITIONAL
	jr z, .load_roof
	cp TILESET_JOHTO_MODERN
	jr z, .load_roof
	cp TILESET_JOHTO_OVERCAST
	jr nz, .skip_roof

.load_roof
	farcall LoadMapGroupRoof

.skip_roof
	xor a
	ld [hTileAnimFrame], a
	ret
; 2879

BufferScreen:: ; 2879
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
; 289d

SaveScreen:: ; 289d
	ld hl, wOverworldMapAnchor
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld de, wScreenSave
	ld a, [wMapWidth]
	add 6
	ld [hMapObjectIndexBuffer], a
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
	ld a, [hMapObjectIndexBuffer]
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

LoadNeighboringBlockData:: ; 28e3
	ld hl, wOverworldMapAnchor
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, [wMapWidth]
	add 6
	ld [hConnectionStripLength], a
	ld de, wScreenSave
	lb bc, 6, 5

SaveScreen_LoadNeighbor:: ; 28f7
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
	ld a, [hConnectionStripLength]
	ld c, a
	ld b, 0
	add hl, bc
	pop bc
	dec c
	jr nz, .row
	ret
; 2914

GetMovementPermissions:: ; 2914
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
	ld a, 0 ; not xor a; preserve carry flag
	adc h
	ld h, a
	ld a, [hl]
	ld hl, wTilePermissions
	or [hl]
	ld [hl], a
	ret
; 2945

.MovementPermissionsData: ; 2945
	db 1 << DOWN
	db 1 << UP
	db 1 << LEFT
	db 1 << RIGHT
	db (1 << DOWN) | (1 << RIGHT)
	db (1 << UP) | (1 << RIGHT)
	db (1 << DOWN) | (1 << LEFT)
	db (1 << UP) | (1 << LEFT)
; 294d

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
; 296c

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
; 298b

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
; 29a8

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
; 29c5

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
; 29e2

.Left:
	call .CheckHiNybble
	ret nz
	ld a, [wTileLeft]
	and 7
	cp $0
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
; 29ff

.CheckHiNybble:
	and $f0
	cp $b0
	ret z
	cp $c0
	ret
; 2a07

GetFacingTileCoord:: ; 2a07
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
; 2a3c

GetCoordTile:: ; 2a3c
; Get the collision byte for tile d, e
	call GetBlockLocation
	ld a, [hl]
	and a
	jr z, .nope
	ld l, a
	ld h, $0
	add hl, hl
	add hl, hl
	ld a, [wTilesetCollisionAddress]
	ld c, a
	ld a, [wTilesetCollisionAddress + 1]
	ld b, a
	add hl, bc
	rr d
	jr nc, .nocarry
	inc hl

.nocarry
	rr e
	jr nc, .nocarry2
	inc hl
	inc hl

.nocarry2
	ld a, [wTilesetCollisionBank]
	jp GetFarByte

.nope
	ld a, -1
	ret
; 2a66

GetBlockLocation:: ; 2a66
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
; 2a8b

CheckFacingSign:: ; 2a8b
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
	ld a, [hROMBank]
	push af
	call SwitchToMapScriptHeaderBank
	call CheckIfFacingTileCoordIsSign
	pop hl
	ld a, h
	rst Bankswitch
	ret
; 2aaa

CheckIfFacingTileCoordIsSign:: ; 2aaa
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
	jr nc, .nocarry
	inc h

.nocarry
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
; 2ad4

CheckCurrentMapXYTriggers:: ; 2ad4
; If there are no xy triggers, we don't need to be here.
	ld a, [wCurrentMapXYTriggerCount]
	and a
	ret z
; Copy the trigger count into c.
	ld c, a
	ld a, [hROMBank]
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
	jr nc, .nocarry
	inc h

.nocarry
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
; 2b29

FadeToMenu:: ; 2b29
	xor a
	ld [hBGMapMode], a
	call LoadStandardMenuDataHeader
	farcall FadeOutPalettes
	call ClearSprites
	jp DisableSpriteUpdates
; 2b3c

CloseSubmenu:: ; 2b3c
	call ClearBGPalettes
	call ReloadTilesetAndPalettes
	call UpdateSprites
	call ExitMenu
	jr FinishExitMenu
; 2b4d

ExitAllMenus:: ; 2b4d
	call ClearBGPalettes
	call ExitMenu
	call ReloadTilesetAndPalettes
	call UpdateSprites
FinishExitMenu:: ; 2b5c
	ld b, CGB_MAPPALS
	call GetCGBLayout
	farcall LoadBlindingFlashPalette
	call ApplyAttrAndTilemapInVBlank
	farcall FadeInPalettes
	jp EnableSpriteUpdates
; 2b74

ReturnToMapWithSpeechTextbox:: ; 0x2b74
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
	ld b, CGB_MAPPALS
	call GetCGBLayout
	farcall LoadBlindingFlashPalette
	call UpdateTimePals
	call DelayFrame
	ld a, $1
	ld [hMapAnims], a
	pop af
	ret
; 0x2bae

ReloadTilesetAndPalettes:: ; 2bae
	call DisableLCD
	call ClearSprites
	farcall ReloadVisibleSprites
	call LoadStandardFont
	call LoadFontsExtra
	ld a, [hROMBank]
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
; 2be5

GetMapHeaderPointer:: ; 2be5
	ld a, [wMapGroup]
	ld b, a
	ld a, [wMapNumber]
	ld c, a
GetAnyMapHeaderPointer:: ; 0x2bed
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
; 0x2c04

GetMapHeaderMember:: ; 0x2c04
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
GetAnyMapHeaderMember:: ; 0x2c0c
	; bankswitch
	ld a, [hROMBank]
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
; 0x2c1c

SwitchToMapBank:: ; 2c1c
	ld a, [wMapGroup]
	ld b, a
	ld a, [wMapNumber]
	ld c, a
SwitchToAnyMapBank:: ; 2c24
	call GetAnyMapBank
	rst Bankswitch
	ret
; 2c29

GetAnyMapBank:: ; 2c31
	push hl
	push de
	ld de, 0
	call GetAnyMapHeaderMember
	ld a, c
	pop de
	pop hl
	ret
; 2c3d

PartiallyCopyMapHeader:: ; 2c3d
; Copy second map header bank, tileset, permission, and second map header address
; from the current map's map header.
	ld a, [hROMBank]
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
; 2c52

SwitchToMapScriptHeaderBank:: ; 2c52
	ld a, [wMapScriptHeaderBank]
	rst Bankswitch
	ret
; 2c57

GetAnyMapBlockdataBankPointer:: ; 2c5b
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
; 2c7d

GetSecondaryMapHeaderPointer:: ; 0x2c7d
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
; 2c8a

GetMapPermission:: ; 2c8a
	push hl
	push de
	push bc
	ld de, 2 ; permission
	call GetMapHeaderMember
	ld a, c
	pop bc
	pop de
	pop hl
	ret
; 2c98

GetAnyMapPermission:: ; 2c99
	push hl
	push de
	push bc
	ld de, 2 ; permission
	call GetAnyMapHeaderMember
	ld a, c
	pop bc
	pop de
	pop hl
	ret
; 2ca7

GetAnyMapTileset:: ; 2ca7
	ld de, 1 ; tileset
	call GetAnyMapHeaderMember
	ld a, c
	ret
; 2caf

GetWorldMapLocation:: ; 0x2caf
; given a map group/id in bc, return its location on the Pokégear map.
	push hl
	push de
	push bc

	ld de, 5 ; landmark
	call GetAnyMapHeaderMember
	ld a, c

	pop bc
	pop de
	pop hl
	ret
; 0x2cbd

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

GetMapHeaderMusic:: ; 2cbd
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
; 2cff

Function8b342: ; 8b342
	call GetSecondaryMapHeaderPointer
	ld d, h
	ld e, l
	ret
; 8b35d

GetMapHeaderTimeOfDayNybble:: ; 2cff
	call GetPhoneServiceTimeOfDayByte
	and $f
	ret
; 2d05

GetMapHeaderPhoneServiceNybble:: ; 2d05
	call GetPhoneServiceTimeOfDayByte
	and $f0
	swap a
	ret
; 2d0d

GetPhoneServiceTimeOfDayByte:: ; 2d0d
	push hl
	push bc

	ld de, 7 ; phone service and time of day
	call GetMapHeaderMember
	ld a, c

	pop bc
	pop hl
	ret
; 2d19

GetFishingGroup:: ; 2d19
	push de
	push hl
	push bc

	ld de, 8 ; fishing group
	call GetMapHeaderMember
	ld a, c

	pop bc
	pop hl
	pop de
	ret
; 2d27

LoadTilesetHeader:: ; 2d27
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
; 2d43

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
; Stormy Beach or Goldenrod City, Route 34, and ROute 34 Coast
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
