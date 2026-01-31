_UpdatePlayerSprite::
	call GetPlayerSprite
	ld a, [wPlayerSprite]
	ldh [hUsedSpriteIndex], a
	xor a
	ldh [hUsedSpriteTile], a
	ld hl, wSpriteFlags
	res 5, [hl]
	jmp GetUsedSprite

GetPlayerSprite:
	ld a, [wPlayerGender]
	ld hl, ChrisStateSprites
	and a ; PLAYER_MALE
	jr z, .go
	ld hl, KrisStateSprites
	dec a ; PLAYER_FEMALE
	jr z, .go
	; PLAYER_ENBY
	ld hl, CrysStateSprites
.go
	ld a, [wPlayerState]
	add l
	ld l, a
	adc h
	sub l
	ld h, a
	ld a, [hl]
	ld [wPlayerSprite], a
	ld [wPlayerObjectSprite], a
	ret

INCLUDE "data/sprites/player_sprites.asm"

RefreshSprites::
	push hl
	push de
	push bc
	call GetPlayerSprite
	xor a
	ldh [hUsedSpriteIndex], a
	call ReloadSpriteIndex
	call LoadOverworldGFX
	jmp PopBCDEHL

ReloadSpriteIndex::
; Reloads sprites using hUsedSpriteIndex.
; Used to reload variable sprites
	ld hl, wObjectStructs
	ld de, OBJECT_LENGTH
	ldh a, [hUsedSpriteIndex]
	ld b, a
	xor a
	ldh [hIsMapObject], a
.loop
	ldh [hObjectStructIndexBuffer], a
	ld a, [hl]
	and a
	jr z, .done
	bit 7, b
	jr z, .continue
	cp b
	jr nz, .done
.continue
	push hl
	; hl points to an object_struct; we want bc to point to a map_object,
	; to get the radius (actually the SPRITE_MON_ICON species).
	push bc
	ld b, h
	ld c, l
	call GetSpriteVTile
	pop bc
	pop hl
	push hl
	inc hl ; skip OBJECT_SPRITE
	inc hl ; skip OBJECT_MAP_OBJECT_INDEX
	ld [hl], a ; OBJECT_SPRITE_TILE
	pop hl
.done
	add hl, de
	ldh a, [hObjectStructIndexBuffer]
	inc a
	cp NUM_OBJECT_STRUCTS
	jr nz, .loop
	ret

LoadOverworldGFX::
	ld hl, OverworldEffectGFX
	lb bc, BANK(OverworldEffectGFX), 17
	ld de, vTiles0 tile $6f
	jmp DecompressRequest2bpp

SafeGetSprite:
	push hl
	call GetSprite
	pop hl
	ret

GetSprite::
	call GetMonSprite
	ret c

	ld hl, SpriteHeaders ; address
	dec a
	ld c, a
	ld b, 0
	ld a, SPRITEDATA_LENGTH
	rst AddNTimes
	; load the address into de
	ld a, [hli]
	ld e, a
	ld a, [hli]
	ld d, a
	; load the sprite bank into b
	ld a, [hli]
	ld b, a
	; load the sprite type into l
	ld l, [hl]
	assert SPRITEDATA_TYPE_MASK == %11000000
	ld a, l
	rlca
	rlca
	and %11
	inc a
	ld l, a
	; load the sprite bank into h too
	ld h, b
	; load the length into c
	ld c, 15
	cp BIG_GYARADOS_SPRITE
	ret z
	ld c, 12
	ret

GetMonSprite:
; Return carry if a monster sprite was loaded.
	cp SPRITE_MON_ICON
	jr z, .MonIcon
	cp SPRITE_MON_DOLL_1
	jr z, .MonDoll1
	cp SPRITE_MON_DOLL_2
	jr z, .MonDoll2
	cp SPRITE_DAYCARE_MON_1
	jr z, .BreedMon1
	cp SPRITE_DAYCARE_MON_2
	jr z, .BreedMon2
	cp SPRITE_GROTTO_MON
	jr z, .GrottoMon

	cp SPRITE_VARS
	jr c, .Normal
	sub SPRITE_VARS
	ld e, a
	ld d, 0
	ld hl, wVariableSprites
	add hl, de
	ld a, [hl]
	and a
	jr nz, GetMonSprite
	; fallthrough

.NoSprite:
	ld a, 1
	lb hl, 0, MON_SPRITE
.Normal:
	and a
	ret

.MonIcon:
; Everything that calls GetMonSprite either points to a map_object struct in bc,
; or will not be used for Pokémon icons, so this SPRITE_MON_ICON can assume
; that bc takes MAPOBJECT_* offsets.
; (That means the player, Battle Tower trainers, and variable sprites cannot
;  use Pokémon icons.)
	ldh a, [hIsMapObject]
	and a
	ld hl, OBJECT_RADIUS - OBJECT_SPRITE
	ld de, OBJECT_RANGE - OBJECT_RADIUS
	jr z, .object
	ld hl, MAPOBJECT_RADIUS - MAPOBJECT_OBJECT_STRUCT_ID
	ld de, MAPOBJECT_SIGHT_RANGE - MAPOBJECT_RADIUS
.object
	add hl, bc
	ld a, [hl]
	add hl, de
	ld e, [hl]
	ld d, 0
	jr .Mon

.BreedMon1:
	ld a, [wBreedMon1Shiny]
	ld d, a
	ld a, [wBreedMon1Form]
	and SPECIESFORM_MASK
	ld e, a
	ld a, [wBreedMon1Species]
	jr .Mon

.BreedMon2:
	ld a, [wBreedMon2Shiny]
	ld d, a
	ld a, [wBreedMon2Form]
	and SPECIESFORM_MASK
	ld e, a
	ld a, [wBreedMon2Species]
	jr .Mon

.GrottoMon:
	farcall GetHiddenGrottoContents
	ld a, c
	ld e, b
	ld d, 0
	jr .Mon

.MonDoll1:
	ld a, [wDecoLeftOrnament]
	jr .MonDoll

.MonDoll2:
	ld a, [wDecoRightOrnament]
.MonDoll:
	farcall GetDecorationSpecies
	; fallthrough

.NoFormMon:
	lb de, 0, 0
.Mon:
	and a
	jr z, .NoSprite
	ld [wCurIcon], a
	ld hl, wCurIconPersonality
	ld a, d
	ld [hli], a
	ld [hl], e
	farcall LoadOverworldMonIcon
	lb hl, 0, MON_SPRITE
	scf
	ret

DoesSpriteHaveFacings::
; Checks to see whether we can apply a facing to a sprite.
; Returns zero for Pokémon sprites, carry for the rest.
	cp SPRITE_POKEMON
	jr c, .facings
	cp SPRITE_VARS
	jr nc, .facings
	scf
	ret

.facings
	and a
	ret

_GetSpritePalette::
	call GetMonSprite
	jr c, .is_pokemon

	ld hl, SpriteHeaders + SPRITEDATA_TYPE_PAL - SPRITEDATA_LENGTH
	ld c, a
	ld b, 0
	ld a, SPRITEDATA_LENGTH
	rst AddNTimes
	ld a, [hl]
	and SPRITEDATA_PALETTE_MASK
	ret

.is_pokemon
	farjp GetOverworldMonIconPalette

GetUsedSprite::
	ldh a, [hUsedSpriteIndex]
	call SafeGetSprite
	ldh a, [hUsedSpriteTile]
	call .GetTileAddr
	push bc
	push hl
	call SwapHLDE
	call FarDecompressWRA6InB
	pop hl
	pop bc
	ld de, wDecompressScratch
	push hl
	push de
	push bc
	ld a, [wSpriteFlags]
	bit 7, a
	call z, .CopyToVram
	pop bc
	ld l, c
	ld h, 0
rept 4
	add hl, hl
endr
	pop de
	add hl, de
	ld d, h
	ld e, l
	pop hl

	ld a, [wSpriteFlags]
	bit 6, a
	ret nz

	ldh a, [hUsedSpriteIndex]
	call DoesSpriteHaveFacings
	ret c

	ld a, [wSpriteFlags]
	bit 5, a
	ld a, h
	jr nz, .vram1
	add 4
.vram1
	add 4
	ld h, a

.CopyToVram:
	ldh a, [rVBK]
	push af
	ld a, [wSpriteFlags]
	and 1 << 5
	swap a
	rra
	ldh [rVBK], a
	call Request2bppInWRA6
	pop af
	ldh [rVBK], a
	ret

.GetTileAddr:
; Return the address of tile (a) in (hl).
	and $7f
	swap a
	ld l, a
	and $f
	ld h, a
	xor l
	add LOW(vTiles0)
	ld l, a
	ld a, h
	adc HIGH(vTiles0)
	ld h, a
	ret

LoadEmote::
	push bc
; Get the address of the palette for emote c.
	ld b, 0
	ld hl, EmotePalettes
	add hl, bc
	ld a, [hl]
	ld [wEmotePal], a
	pop bc
; Get the address of the pointer to emote c.
	ld b, 0
	ld hl, Emotes
	add hl, bc
	add hl, bc
; load the emote address into hl
	ld a, [hli]
	ld h, [hl]
	ld l, a
; load the bank and length of the emote (in tiles) into bc
	lb bc, BANK("Emote Graphics"), 4
; load the VRAM destination into de
	ld de, vTiles0 tile $60
; load into vram0
	jmp DecompressRequest2bpp

INCLUDE "data/sprites/emotes.asm"

INCLUDE "data/sprites/sprites.asm"
