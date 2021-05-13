; Functions handling map objects.

GetSpritePalette::
	push hl
	push de
	push bc
	farcall _GetSpritePalette
	jmp PopBCDEHL

GetSpriteVTile::
	push hl
	push de
	push bc
	ldh [hUsedSpriteIndex], a
	push bc
	farcall GetSprite
	pop bc
	ld hl, wSpriteFlags
	res 5, [hl]
	; SPRITE_BIG_GYARADOS and SPRITE_SAILBOAT use the last object_struct
	; (SPRITE_BIG_GYARADOS has more than 12 tiles, and SPRITE_SAILBOAT
	; needs to be in VRAM1)
	ldh a, [hUsedSpriteIndex]
	cp SPRITE_BIG_GYARADOS
	jr z, .use_last_struct
	cp SPRITE_SAILBOAT
	ldh a, [hObjectStructIndexBuffer]
	jr nz, .got_sprite_tile
.use_last_struct
	ld a, NUM_OBJECT_STRUCTS - 1
.got_sprite_tile
	cp FIRST_VRAM1_OBJECT_STRUCT
	jr c, .continue
	set 5, [hl]
	sub FIRST_VRAM1_OBJECT_STRUCT
.continue
	add a
	add a
	ld d, a
	add d
	add d
	ldh [hUsedSpriteTile], a
	push af
	farcall GetUsedSprite
	pop af
	ld d, a
	xor a
	ld a, d
	ld hl, wSpriteFlags
	bit 5, [hl]
	jr nz, .using_vbk1
	or $80
.using_vbk1
	jmp PopBCDEHL

GetPlayerStandingTile::
	ld a, [wPlayerStandingTile]
	; fallthrough

GetTileCollision::
; Get the collision type of tile a.
	push hl

	add LOW(TileCollisionTable)
	ld l, a
	adc HIGH(TileCollisionTable)
	sub l
	ld h, a

	ld a, BANK(TileCollisionTable)
	call GetFarByte
	and $f ; lo nybble only

	pop hl
	ret

GetMapObject::
; Return the location of map object a in bc.
	ld hl, wMapObjects
	ld bc, MAPOBJECT_LENGTH
	rst AddNTimes
	ld b, h
	ld c, l
	ret

CheckObjectVisibility::
; Sets carry if the object is not visible on the screen.
	ldh [hMapObjectIndexBuffer], a
	call GetMapObject
	ld hl, MAPOBJECT_OBJECT_STRUCT_ID
	add hl, bc
	ld a, [hl]
	cp -1
	jr z, .not_visible
	ldh [hObjectStructIndexBuffer], a
	call GetObjectStruct
	and a
	ret

.not_visible
	scf
	ret

CheckObjectTime::
	ld hl, MAPOBJECT_HOUR
	add hl, bc
	ld a, [hl]
	cp -1
	jr nz, .check_hour
	ld hl, MAPOBJECT_TIMEOFDAY
	add hl, bc
	ld a, [hl]
	cp -1
	jr z, .timeofday_always
	ld hl, .TimeOfDayValues_191e
	ld a, [wTimeOfDay]
	ld e, a
	ld d, 0
	add hl, de
	ld a, [hl]
	ld hl, MAPOBJECT_TIMEOFDAY
	add hl, bc
	and [hl]
	jr nz, .timeofday_always
	scf
	ret

.timeofday_always
	and a
	ret

.TimeOfDayValues_191e:
	db 1 << MORN ; 1
	db 1 << DAY  ; 2
	db 1 << NITE ; 4
	db 1 << EVE  ; 8

.check_hour
	ld hl, MAPOBJECT_HOUR
	add hl, bc
	ld d, [hl]
	ld hl, MAPOBJECT_TIMEOFDAY
	add hl, bc
	ld e, [hl]
	ld hl, hHours
	ld a, d
	cp e
	jr z, .yes
	jr c, .check_timeofday
	ld a, [hl]
	cp d
	jr nc, .yes
	cp e
	jr c, .yes
	jr z, .yes
	jr .no

.check_timeofday
	ld a, e
	cp [hl]
	jr c, .no
	ld a, [hl]
	cp d
	jr c, .no

.yes
	and a
	ret

.no
	scf
	ret

_CopyObjectStruct::
	ldh [hMapObjectIndexBuffer], a
	call UnmaskObject
	ldh a, [hMapObjectIndexBuffer]
	call GetMapObject
	farjp CopyObjectStruct

ApplyDeletionToMapObject::
	ldh [hMapObjectIndexBuffer], a
	call GetMapObject
	ld hl, MAPOBJECT_OBJECT_STRUCT_ID
	add hl, bc
	ld a, [hl]
	cp -1
	ret z ; already hidden
	ld [hl], -1
	push af
	call .CheckStopFollow
	pop af
	call GetObjectStruct
	farjp DeleteMapObject

.CheckStopFollow:
	ld hl, wObjectFollow_Leader
	cp [hl]
	jr z, .ok
	ld hl, wObjectFollow_Follower
	cp [hl]
	ret nz
.ok
	farcall StopFollow
	ld a, -1
	ld [wObjectFollow_Leader], a
	ld [wObjectFollow_Follower], a
	ret

DeleteObjectStruct::
	call ApplyDeletionToMapObject
	jmp MaskObject

CopyPlayerObjectTemplate::
	push hl
	call GetMapObject
	ld d, b
	ld e, c
	ld a, -1
	ld [de], a
	inc de
	pop hl
	ld bc, MAPOBJECT_LENGTH - 1
	rst CopyBytes
	ret

LoadMovementDataPointer::
; Load the movement data pointer for person a.
	ld [wMovementObject], a
	ldh a, [hROMBank]
	ld [wMovementDataPointer], a
	ld a, l
	ld [wMovementDataPointer + 1], a
	ld a, h
	ld [wMovementDataPointer + 2], a

	ld a, [wMovementObject]
	call CheckObjectVisibility
	ret c

	ld hl, OBJECT_MOVEMENTTYPE
	add hl, bc
	ld [hl], SPRITEMOVEDATA_SCRIPTED

	ld hl, OBJECT_STEP_TYPE
	add hl, bc
	ld [hl], STEP_TYPE_RESET

	ld hl, wVramState
	set 7, [hl]
	and a
	ret

FindFirstEmptyObjectStruct::
; Returns the index of the first empty object struct in A and its address in HL, then sets carry.
; If all object structs are occupied, A = 0 and Z is set.
; Preserves BC and DE.
	push bc
	push de
	ld hl, wObjectStructs
	ld de, OBJECT_LENGTH
	ld c, NUM_OBJECT_STRUCTS
.loop
	ld a, [hl]
	and a
	jr z, .break
	add hl, de
	dec c
	jr nz, .loop
	xor a
	jr .done

.break
	ld a, NUM_OBJECT_STRUCTS
	sub c
	scf

.done
	pop de
	pop bc
	ret

GetInitialFacing::
	push bc
	push de
	ld e, a
	ld d, 0
	ld hl, SpriteMovementData + 1 ; init facing
rept NUM_SPRITEMOVEDATA_FIELDS
	add hl, de
endr
	ld a, BANK(SpriteMovementData)
	call GetFarByte
	add a
	add a
	and $c
	pop de
	pop bc
	ret

_GetMovementByte::
; Switch to the movement data bank
	ldh a, [hROMBank]
	push af
	ld a, [hli]
	rst Bankswitch
; Load the current script byte as given by OBJECT_MOVEMENT_BYTE_INDEX, and increment OBJECT_MOVEMENT_BYTE_INDEX
	ld a, [hli]
	ld d, [hl]
	ld hl, OBJECT_MOVEMENT_BYTE_INDEX
	add hl, bc
	add [hl]
	ld e, a
	adc d
	sub e
	ld d, a
	inc [hl]
	ld a, [de]
	ld h, a
	pop af
	rst Bankswitch

	ld a, h
	ret

UpdateSprites::
	ld a, [wVramState]
	bit 0, a
	ret z

	farcall UpdateMapObjectDataAndSprites
	farjp _UpdateSprites

GetObjectStruct::
	ld bc, OBJECT_LENGTH
	ld hl, wObjectStructs
	rst AddNTimes
	ld b, h
	ld c, l
	ret

DoesObjectHaveASprite::
	ld hl, OBJECT_SPRITE
	add hl, bc
	ld a, [hl]
	and a
	ret

SetSpriteDirection::
	; preserves other flags
	push af
	ld hl, OBJECT_FACING
	add hl, bc
	ld a, [hl]
	and %11110011
	ld e, a
	pop af
	and %00001100
	or e
	ld [hl], a
	ret

GetSpriteDirection::
	ld hl, OBJECT_FACING
	add hl, bc
	ld a, [hl]
	and %00001100
	ret
