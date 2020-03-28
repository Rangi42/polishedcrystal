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
	jp ReadMapSetupScript

INCLUDE "data/maps/setup_scripts.asm"

ReadMapSetupScript:
.loop
	ld a, [hli]
	cp -1
	ret z

	push hl

	ld c, a
	ld b, 0
	ld hl, MapSetupCommands
	add hl, bc
	add hl, bc
	add hl, bc

	; bank
	ld b, [hl]
	inc hl

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

MapSetupCommands:
	dba EnableLCD ; 00
	dba DisableLCD ; 01
	dba MapSetup_Sound_Off ; 02
	dba PlayMapMusic ; 03
	dba RestartMapMusic ; 04
	dba FadeToMapMusic ; 05
	dba RotatePalettesRightMapAndMusic ; 06
	dba EnterMapMusic ; 07
	dba ForceMapMusic ; 08
	dba FadeInMusic ; 09
	dba LoadBlockData ; 0a (callback 1)
	dba LoadNeighboringBlockData ; 0b
	dba SaveScreen ; 0c
	dba BufferScreen ; 0d
	dba LoadGraphics ; 0e
	dba LoadTilesetHeader ; 0f
	dba LoadMapTimeOfDay ; 10
	dba LoadMapPalettes ; 11
	dba LoadWildMonData ; 12
	dba RefreshMapSprites ; 13
	dba RunCallback_05_03 ; 14
	dba RunCallback_03 ; 15
	dba LoadObjectsRunCallback_02 ; 16
	dba LoadSpawnPoint ; 17
	dba EnterMapConnection ; 18
	dba LoadWarpData ; 19
	dba LoadMapAttributes ; 1a
	dba LoadMapAttributes_Continue ; 1b
	dba ClearBGPalettes ; 1c
	dba FadeOutPalettes ; 1d
	dba FadeInPalettes ; 1e
	dba GetCoordOfUpperLeftCorner ; 1f
	dba RestoreFacingAfterWarp ; 20
	dba SpawnInFacingDown ; 21
	dba SpawnPlayer ; 22
	dba RefreshPlayerCoords ; 23
	dba DelayClearingOldSprites ; 24
	dba DelayLoadingNewSprites ; 25
	dba UpdateRoamMons ; 26
	dba JumpRoamMons ; 27
	dba FadeOldMapMusic ; 28
	dba ActivateMapAnims ; 29
	dba SuspendMapAnims ; 2a
	dba RetainOldPalettes ; 2b
	dba ReturnFromMapSetupScript ; 2c
	dba DecompressMetatiles ; 2d
	dba DeferredLoadGraphics ; 2e

ActivateMapAnims:
	ld a, $1
	ldh [hMapAnims], a
	ret

SuspendMapAnims:
	xor a
	ldh [hMapAnims], a
	ret

LoadObjectsRunCallback_02:
	ld a, MAPCALLBACK_OBJECTS
	call RunMapCallback
	call LoadObjectMasks
	farjp InitializeVisibleSprites

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
	jr c, .next
	call CheckObjectFlag
.next
	pop de
	ld [de], a
	inc de
	pop bc
	ld hl, OBJECT_LENGTH
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
	ld a, c
	and a
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

DelayClearingOldSprites:
	ld hl, wPlayerSpriteSetupFlags
	set 7, [hl]
	ret

DelayLoadingNewSprites:
	ld hl, wPlayerSpriteSetupFlags
	set 6, [hl]
	ret

CheckReplaceKrisSprite:
	call .CheckBiking
	jr c, .ok
	call .CheckSurfing
	jr c, .ok
	call .CheckSurfing2
	jr c, .ok
	ret

.ok
	jp ReplaceKrisSprite

.CheckBiking:
	and a
	ld hl, wOWState
	bit OWSTATE_BIKING_FORCED, [hl]
	ret z
	ld a, PLAYER_BIKE
	ld [wPlayerState], a
	scf
	ret

.CheckSurfing2:
	ld a, [wPlayerState]
	and a ; cp PLAYER_NORMAL
	jr z, .nope
	cp PLAYER_SLIP
	jr z, .nope
	cp PLAYER_SURF
	jr z, .surfing
	cp PLAYER_SURF_PIKA
	jr z, .surfing
	call GetMapPermission
	cp INDOOR
	jr z, .checkbiking
	cp DUNGEON
	jr nz, .nope
.checkbiking
	ld a, [wPlayerState]
	cp PLAYER_BIKE
	jr nz, .nope
.surfing
	ld a, PLAYER_NORMAL
	ld [wPlayerState], a
	scf
	ret

.nope
	and a
	ret

.CheckSurfing:
	call CheckOnWater
	jr nz, .ret_nc
	ld a, [wPlayerState]
	cp PLAYER_SURF
	jr z, ._surfing
	cp PLAYER_SURF_PIKA
	jr z, ._surfing
	ld a, PLAYER_SURF
	ld [wPlayerState], a
._surfing
	scf
	ret
.ret_nc
	and a
	ret

FadeOldMapMusic:
	ld a, 6
	jp SkipMusic

RetainOldPalettes:
	farjp _UpdateTimePals

RotatePalettesRightMapAndMusic:
	xor a
	ld [wMusicFadeIDLo] ,a
	ld [wMusicFadeIDHi] ,a
	ld [wMusicFade], a
	farjp FadeOutPalettes

ForceMapMusic:
	ld a, [wPlayerState]
	cp PLAYER_BIKE
	jr nz, .notbiking
	call VolumeOff
	ld a, $88
	ld [wMusicFade], a
.notbiking
	jp TryRestartMapMusic

DecompressMetatiles:
	call TilesetUnchanged
	ret z

	; Decompressed RAM is all at $d000
	ld hl, wTilesetBlocksBank
	ld c, BANK(wDecompressedMetatiles)
	call .Decompress

	ld hl, wTilesetAttributesBank
	ld c, BANK(wDecompressedAttributes)
	call .Decompress

	ld hl, wTilesetCollisionBank
	ld c, BANK(wDecompressedCollisions)

.Decompress:
	ld a, [hli]
	ld b, a
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld de, wDecompressedMetatiles
	ld a, c
	call StackCallInWRAMBankA

.FunctionD000
	jp FarDecompressAtB_D000
