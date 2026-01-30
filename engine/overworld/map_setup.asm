RunMapSetupScript::
	ldh a, [hMapEntryMethod]
	and $f
	dec a
	ld c, a
	ld b, 0
	ld hl, MapSetupScripts
	add hl, bc
	add hl, bc
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jmp ReadMapSetupScript

INCLUDE "data/maps/setup_scripts.asm"

ReadMapSetupScript:
.loop
	ld a, [hli]
	cp -1 ; end?
	ret z

	push hl

	ld c, a
	ld b, 0
	ld hl, MapSetupCommands
	add hl, bc
	add hl, bc
	add hl, bc

	; bank
	ld a, [hli]
	ld b, a

	; address
	ld a, [hli]
	ld h, [hl]
	ld l, a

	; Bit 7 of the bank indicates a parameter.
	; This is left unused.
	bit 7, b
	jr z, .go

	pop de
	ld a, [de]
	ld c, a
	inc de
	push de

.go
	ld a, b
	and $7f
	call FarCall_hl

	pop hl
	jr .loop

INCLUDE "data/maps/setup_script_pointers.asm"

ActivateMapAnims:
	ld a, TRUE
	ldh [hMapAnims], a
	ret

SuspendMapAnims:
	xor a ; FALSE
	ldh [hMapAnims], a
	ret

LoadMapObjects_Connection:
	call ReassociateMapObjectsOrDelete
LoadMapObjects:
	ld a, MAPCALLBACK_OBJECTS
	call RunMapCallback
	call LoadObjectMasks
	farjp InitializeVisibleSprites

ReassociateMapObjectsOrDelete:
; Reassociates the objects if their coordinates match the relative coordinates
; of an object in the new map relative to the player, or it deletes the object.
	ld a, 1
	ldh [hObjectStructIndexBuffer], a
	ld bc, wObjectStructs + OBJECT_LENGTH
	ld e, NUM_OBJECT_STRUCTS - 1
.loop_objects
	push de
	ld hl, OBJECT_LAST_MAP_X
	add hl, bc
	ld a, [hli]
	ld e, [hl]
	ld d, a
	ld hl, OBJECT_SPRITE
	add hl, bc
	ld a, [hl]
	ld [wCurIcon], a
	call .CheckForMatchingMapObject
	jr nc, .DeleteObjectStruct

	; reassociate the object to the new matching mapobject.
	ld hl, OBJECT_MAP_OBJECT_INDEX
	add hl, bc
	ldh a, [hMapObjectIndexBuffer]
	ld [hl], a

	; Update the object's map xy coordinates.
	ld hl, OBJECT_MAP_X
	add hl, bc
	ld a, d
	ld [hli], a ; MapX
	ld a, e
	ld [hli], a; MapY
	ld a, d
	ld [hli], a ; LastMapX
	ld a, e
	ld [hli], a ; LastMapY
	ld a, d
	ld [hli], a ; InitX
	ld [hl], e ; InitY
.continue
	pop de
	ld hl, OBJECT_LENGTH
	add hl, bc
	ld b, h
	ld c, l
	ldh a, [hObjectStructIndexBuffer]
	inc a
	ldh [hObjectStructIndexBuffer], a
	dec e
	jr nz, .loop_objects
	ret

.DeleteObjectStruct
	; delete the object struct.
	ld hl, OBJECT_SPRITE
	add hl, bc
	ld d, OBJECT_LENGTH
	xor a
.delete_loop
	ld [hli], a
	dec d
	jr nz, .delete_loop
	; mark the object as free.
	ld hl, OBJECT_MAP_OBJECT_INDEX
	add hl, bc
	ld [hl], UNASSOCIATED_OBJECT
	jr .continue

.CheckForMatchingMapObject
	push bc

	; Get the old object's coordinates relative to the player's old map coordinates.
	ld hl, wLastMapXCoord
	ld a, d
	sub 4
	sub [hl]
	dec hl ; wLastMapYCoord
	ld d, a
	ld a, e
	sub 4
	sub [hl]
	ld e, a

	ld a, 1
	ldh [hMapObjectIndexBuffer], a
	ld bc, wMapObjects + MAPOBJECT_LENGTH
.loop_map_objects
	push bc

	ld hl, MAPOBJECT_SPRITE
	add hl, bc
	ld a, [wCurIcon]
	cp [hl]
	jr nz, .next_map_object
	inc hl ; MAPOBJECT_Y_COORD

	; get map object's xy and convert
	ld a, [hli]
	sub 4
	ld c, a
	ld a, [hl]
	sub 4
	ld b, a

	; get the map object's coordinates relative to the player's new map coordinates.
	push hl
	ld hl, wXCoord
	ld a, b
	sub [hl]
	dec hl ; wYCoord
	ld b, a
	ld a, c
	sub [hl]
	ld c, a
	pop hl

	; compare the old and new coordinates
	cp e
	jr nz, .next_map_object
	ld a, b
	cp d
	jr nz, .next_map_object

	; they match, so reassociate the the mapobject to the object.
	ld d, b
	ld e, c
	pop bc
	ld hl, MAPOBJECT_OBJECT_STRUCT_ID
	add hl, bc
	ldh a, [hObjectStructIndexBuffer]
	ld [hl], a

	; convert the mapobject's xy relative coordinates to the new map's xy coordinates.
	ld a, [wXCoord]
	add d
	add 4
	ld d, a
	ld a, [wYCoord]
	add e
	add 4
	ld e, a
	scf
	jr .done

.next_map_object
	pop bc
	ldh a, [hMapObjectIndexBuffer]
	inc a
	ldh [hMapObjectIndexBuffer], a
	ld hl, MAPOBJECT_LENGTH
	add hl, bc
	ld b, h
	ld c, l
	ld a, h
	cp HIGH(wMapObjectsEnd)
	jr nz, .loop_map_objects
	ld a, l
	cp LOW(wMapObjectsEnd)
	jr nz, .loop_map_objects
.done
	pop bc
	ret

LoadObjectMasks:
	ld hl, wObjectMasks
	xor a
	ld bc, NUM_OBJECTS
	rst ByteFill
	ld bc, wMapObjects
	ld de, wObjectMasks
	xor a
.loop
	push af
	push bc
	push de
	call GetObjectTimeMask
	call nc, CheckObjectFlag
	pop de
	ld [de], a
	inc de
	pop bc
	ld hl, MAPOBJECT_LENGTH
	add hl, bc
	ld b, h
	ld c, l
	pop af
	inc a
	cp NUM_OBJECTS
	jr nz, .loop
	ret

CheckObjectFlag:
	ld hl, MAPOBJECT_SPRITE
	add hl, bc
	ld a, [hl]
	and a
	jr z, .masked
	ld hl, MAPOBJECT_EVENT_FLAG
	add hl, bc
	ld a, [hli]
	ld e, a
	ld a, [hl]
	ld d, a
	inc a ; cp -1
	jr nz, .check
	ld a, e
	inc a ; cp -1
	jr z, .unmasked
.masked
	ld a, -1
	scf
	ret

.check
	ld b, CHECK_FLAG
	call EventFlagAction
	jr nz, .masked
.unmasked
	xor a
	ret

GetObjectTimeMask:
	call CheckObjectTime
	ld a, -1
	ret c
	xor a
	ret

ResetPlayerObjectAction:
	ld hl, wPlayerSpriteSetupFlags
	set PLAYERSPRITESETUP_RESET_ACTION_F, [hl]
	ret

SkipUpdateMapSprites:
	ld hl, wPlayerSpriteSetupFlags
	set PLAYERSPRITESETUP_SKIP_RELOAD_GFX_F, [hl]
	ret

CheckUpdatePlayerSprite:
	call .CheckForcedBiking
	jr c, .ok
	call .CheckSurfing
	jr c, .ok
	call .ResetSurfingOrBikingState
	ret nc
.ok
	jmp UpdatePlayerSprite

.CheckForcedBiking:
	and a
	ld hl, wOWState
	bit OWSTATE_BIKING_FORCED, [hl]
	ret z
	ld a, PLAYER_BIKE
	ld [wPlayerState], a
	scf
	ret

.ResetSurfingOrBikingState:
	ld a, [wPlayerState]
	cp PLAYER_SURF
	jr z, .reset
	cp PLAYER_SURF_PIKA
	jr z, .reset
	cp PLAYER_BIKE
	jr nz, .nope
	call GetMapEnvironment
	cp INDOOR
	jr z, .reset
	cp DUNGEON
	jr nz, .nope
.reset
	xor a ; ld a, PLAYER_NORMAL
	ld [wPlayerState], a
	scf
	ret

.nope
	and a
	ret

.CheckSurfing:
	call GetPlayerStandingTile
	dec a ; cp WATER_TILE
	jr nz, .nope2
	ld a, [wPlayerState]
	cp PLAYER_SURF
	jr z, .is_surfing
	cp PLAYER_SURF_PIKA
	jr z, .is_surfing
	ld a, PLAYER_SURF
	ld [wPlayerState], a
.is_surfing
	scf
	ret
.nope2
	and a
	ret

FadeOutMapMusic:
	ld a, 6
	jmp SkipMusic

ApplyMapPalettes:
	farjp _UpdateTimePals

FadeMapMusicAndPalettes:
	xor a
	ld [wMusicFadeIDLo], a
	ld [wMusicFadeIDHi], a
	ld [wMusicFade], a
	farjp FadeOutPalettes

ForceMapMusic:
	ld a, [wPlayerState]
	cp PLAYER_BIKE
	jr nz, .notbiking
	call MinVolume
	ld a, $88
	ld [wMusicFade], a
.notbiking
	jmp TryRestartMapMusic

DecompressMetatiles:
	call TilesetUnchanged
	ret z
	; fallthrough
_DecompressMetatiles:
	assert wDecompressedMetatiles == STARTOF(WRAMX)
	ld hl, wTilesetBlocksAddress
	ld c, BANK(wDecompressedMetatiles)
	call .Decompress

	assert wDecompressedAttributes == STARTOF(WRAMX)
	ld hl, wTilesetAttributesAddress
	ld c, BANK(wDecompressedAttributes)
	call .Decompress

	assert wDecompressedCollisions == STARTOF(WRAMX)
	ld hl, wTilesetCollisionAddress
	ld c, BANK(wDecompressedCollisions)
	; fallthrough
.Decompress:
	ld a, [wTilesetDataBank]
	ld b, a
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, c
	call StackCallInWRAMBankA

.FunctionD000
	jmp FarDecompressInB
