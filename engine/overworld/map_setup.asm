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

INCLUDE "data/maps/setup_script_pointers.asm"

ActivateMapAnims:
	ld a, TRUE
	ldh [hMapAnims], a
	ret

SuspendMapAnims:
	xor a ; FALSE
	ldh [hMapAnims], a
	ret

LoadMapObjects:
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

ResetPlayerObjectAction:
	ld hl, wPlayerSpriteSetupFlags
	set PLAYERSPRITESETUP_RESET_ACTION_F, [hl]
	ret

SkipUpdateMapSprites:
	ld hl, wPlayerSpriteSetupFlags
	set PLAYERSPRITESETUP_SKIP_RELOAD_GFX_F, [hl]
	ret

CheckUpdatePlayerSprite:
	call .CheckBiking
	jr c, .ok
	call .CheckSurfing
	jr c, .ok
	call .CheckSurfing2
	ret nc
.ok
	jmp UpdatePlayerSprite

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
	cp PLAYER_SKATE
	jr z, .nope
	cp PLAYER_SURF
	jr z, .surfing
	cp PLAYER_SURF_PIKA
	jr z, .surfing
	call GetMapEnvironment
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
	jr z, .done

	assert wDecompressedMetatiles == WRAM1_Begin
	ld hl, wTilesetBlocksBank
	ld c, BANK(wDecompressedMetatiles)
	call .Decompress

	assert wDecompressedAttributes == WRAM1_Begin
	ld hl, wTilesetAttributesBank
	ld c, BANK(wDecompressedAttributes)
	call .Decompress

	assert wDecompressedCollisions == WRAM1_Begin
	ld hl, wTilesetCollisionBank
	ld c, BANK(wDecompressedCollisions)
	call .Decompress

.done
	ld a, MAPCALLBACK_BLOCKS
	jmp RunMapCallback

.Decompress:
	ld a, [hli]
	ld b, a
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, c
	call StackCallInWRAMBankA

.FunctionD000
	jmp FarDecompressInB
