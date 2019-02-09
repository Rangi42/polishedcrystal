GetEmote2bpp: ; 1412a
	ld a, $1
	ld [rVBK], a
	call Get2bpp
	xor a
	ld [rVBK], a
	ret
; 14135

_ReplaceKrisSprite:: ; 14135
	call GetPlayerSprite
	ld a, [wUsedSprites]
	ld [hUsedSpriteIndex], a
	ld a, [wUsedSprites + 1]
	ld [hUsedSpriteTile], a
	jp GetUsedSprite
; 14146

GetPlayerSprite: ; 14183
; Get Chris or Kris's sprite.
	ld hl, .Chris
	ld a, [wPlayerSpriteSetupFlags]
	bit 2, a
	jr nz, .go
	ld a, [wPlayerGender]
	bit 0, a
	jr z, .go
	ld hl, .Kris

.go
	ld a, [wPlayerState]
	ld c, a
.loop
	ld a, [hli]
	cp c
	jr z, .good
	inc hl
	cp $ff
	jr nz, .loop

; Any player state not in the array defaults to Chris's sprite.
	xor a ; ld a, PLAYER_NORMAL
	ld [wPlayerState], a
	ld a, SPRITE_CHRIS
	jr .finish

.good
	ld a, [hl]

.finish
	ld [wUsedSprites + 0], a
	ld [wPlayerSprite], a
	ld [wPlayerObjectSprite], a
	ret

.Chris:
	db PLAYER_NORMAL,    SPRITE_CHRIS
	db PLAYER_BIKE,      SPRITE_CHRIS_BIKE
	db PLAYER_SURF,      SPRITE_CHRIS_SURF
	db PLAYER_SURF_PIKA, SPRITE_SURFING_PIKACHU
	db $ff

.Kris:
	db PLAYER_NORMAL,    SPRITE_KRIS
	db PLAYER_BIKE,      SPRITE_KRIS_BIKE
	db PLAYER_SURF,      SPRITE_KRIS_SURF
	db PLAYER_SURF_PIKA, SPRITE_SURFING_PIKACHU
	db $ff
; 141c9


ReloadVisibleSprites::
	push hl
	push de
	push bc
	call GetPlayerSprite
	xor a
	ld [hUsedSpriteIndex], a
	call ReloadSpriteIndex
	pop bc
	pop de
	pop hl
	ret

ReloadSpriteIndex::
; Reloads sprites using hUsedSpriteIndex.
; Used to reload variable sprites
	ld hl, wObjectStructs
	ld de, OBJECT_STRUCT_LENGTH
	push bc
	ld a, [hUsedSpriteIndex]
	ld b, a
	xor a
.loop
	ld [hObjectStructIndexBuffer], a
	ld a, [hl]
	bit 7, b
	jr z, .continue
	cp b
	jr nz, .done
.continue
	push hl
	call GetSpriteVTile
	pop hl
	push hl
	inc hl
	inc hl
	ld [hl], a
	pop hl
.done
	add hl, de
	ld a, [hObjectStructIndexBuffer]
	inc a
	cp NUM_OBJECT_STRUCTS
	jr nz, .loop
	pop bc
	ret

MapCallbackSprites_LoadUsedSpritesGFX: ; 14209
	ld a, MAPCALLBACK_SPRITES
	call RunMapCallback
LoadUsedSpritesGFX::
	call GetUsedSprites

	ld a, [wSpriteFlags]
	bit 6, a
	ret nz

	ld c, EMOTE_SHADOW
	farcall LoadEmote
	call GetMapPermission
	call CheckOutdoorMapOrPerm5
	jr z, .outdoor
	ld c, EMOTE_BOULDER_DUST
	farjp LoadEmote

.outdoor
	ld c, EMOTE_SHAKING_GRASS
	farcall LoadEmote
	ld c, EMOTE_PUDDLE_SPLASH
	farjp LoadEmote
; 14236



SafeGetSprite: ; 14236
	push hl
	call GetSprite
	pop hl
	ret
; 1423c

GetSprite:: ; 1423c
	call GetMonSprite
	ret c

	ld hl, SpriteHeaders ; address
	dec a
	ld c, a
	ld b, 0
	ld a, NUM_SPRITEHEADER_FIELDS
	rst AddNTimes
	; load the address into de
	ld a, [hli]
	ld e, a
	ld a, [hli]
	ld d, a
	; load the sprite bank into both b and h
	ld a, [hli]
	ld b, a
	; load the sprite type into l
	ld l, [hl]
	ld h, a
	; load the length into c
	ld c, 15
	ld a, l
	cp BIG_GYARADOS_SPRITE
	ret z
	ld c, 12
	ret
; 14259


GetMonSprite: ; 14259
; Return carry if a monster sprite was loaded.

	cp SPRITE_POKEMON
	jr c, .Normal
	cp SPRITE_DAYCARE_MON_1
	jr z, .wBreedMon1
	cp SPRITE_DAYCARE_MON_2
	jr z, .wBreedMon2
	cp SPRITE_GROTTO_MON
	jr z, .GrottoMon
	cp SPRITE_VARS
	jr nc, .Variable
	jr .Icon

.Normal:
	and a
	ret

.Icon:
	sub SPRITE_POKEMON
	ld e, a
	ld d, 0
	ld hl, SpriteMons
	add hl, de
	ld a, [hl]
	jr .Mon

.wBreedMon1
	ld a, [wBreedMon1Species]
	jr .Mon

.wBreedMon2
	ld a, [wBreedMon2Species]
	jr .Mon

.GrottoMon
	farcall GetHiddenGrottoContents
	ld a, [hl]

.Mon:
	ld e, a
	and a
	jr z, .NoBreedmon

	farcall LoadOverworldMonIcon

	lb hl, 0, MON_SPRITE
	scf
	ret

.Variable:
	sub SPRITE_VARS
	ld e, a
	ld d, 0
	ld hl, wVariableSprites
	add hl, de
	ld a, [hl]
	and a
	jp nz, GetMonSprite

.NoBreedmon:
	ld a, 1
	lb hl, 0, MON_SPRITE
	and a
	ret
; 142a7


_DoesSpriteHaveFacings:: ; 142a7
; Checks to see whether we can apply a facing to a sprite.
; Returns carry unless the sprite is a Pokemon or a Still Sprite.
	cp SPRITE_POKEMON
	jr nc, .only_down

	push hl
	push bc
	ld hl, SpriteHeaders + SPRITEHEADER_TYPE ; type
	dec a
	ld c, a
	ld b, 0
	ld a, NUM_SPRITEHEADER_FIELDS
	rst AddNTimes
	ld a, [hl]
	pop bc
	pop hl
	cp STILL_SPRITE
	jr nz, .only_down
	scf
	ret

.only_down
	and a
	ret
; 142c4


_GetSpritePalette:: ; 142c4
	ld a, c
	call GetMonSprite
	jr c, .is_pokemon

	ld hl, SpriteHeaders + SPRITEHEADER_PALETTE
	dec a
	ld c, a
	ld b, 0
	ld a, NUM_SPRITEHEADER_FIELDS
	rst AddNTimes
	ld c, [hl]
	ret

.is_pokemon
	xor a
	ld c, a
	ret
; 142db


AddSpriteGFX: ; 142e5
; Add any new sprite ids to a list of graphics to be loaded.
; Return carry if the list is full.

	push hl
	push bc
	ld b, a
	ld hl, wUsedSprites + 2
	ld c, SPRITE_GFX_LIST_CAPACITY - 1
.loop
	ld a, [hl]
	cp b
	jr z, .exists
	and a
	jr z, .new
	inc hl
	inc hl
	dec c
	jr nz, .loop

	pop bc
	pop hl
	scf
	ret

.exists
	pop bc
	pop hl
	and a
	ret

.new
	ld [hl], b
	pop bc
	pop hl
	and a
	ret
; 14306


GetSpriteLength: ; 14386
; Return the length of sprite type a in tiles.

	cp WALKING_SPRITE
	jr z, .AnyDirection
	cp STANDING_SPRITE
	jr z, .AnyDirection
	cp STILL_SPRITE
	jr z, .OneDirection
	cp BIG_GYARADOS_SPRITE
	jr z, .BigGyarados
; MON_SPRITE
	ld a, 8
	ret

.AnyDirection:
	ld a, 12
	ret

.OneDirection:
	ld a, 4
	ret

.BigGyarados:
	ld a, 16
	ret
; 1439b


GetUsedSprites: ; 1439b
	ld hl, wUsedSprites
	ld c, SPRITE_GFX_LIST_CAPACITY

.loop
	ld a, [wSpriteFlags]
	res 5, a
	ld [wSpriteFlags], a

	ld a, [hli]
	and a
	ret z
	ld [hUsedSpriteIndex], a

	ld a, [hli]
	ld [hUsedSpriteTile], a

	bit 7, a
	jr z, .dont_set

	ld a, [wSpriteFlags]
	set 5, a ; load VBank0
	ld [wSpriteFlags], a

.dont_set
	push bc
	push hl
	call GetUsedSprite
	pop hl
	pop bc
	dec c
	jr nz, .loop
	ret
; 143c8

GetUsedSprite:: ; 143c8
	ld a, [hUsedSpriteIndex]
	call SafeGetSprite
	ld a, [hUsedSpriteTile]
	call .GetTileAddr
	push hl
	push de
	push bc
	ld a, [wSpriteFlags]
	bit 7, a
	jr nz, .skip
	call .CopyToVram

.skip
	pop bc
	ld l, c
	ld h, $0
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

	ld a, [hUsedSpriteIndex]
	call _DoesSpriteHaveFacings
	ret c

	ld a, [hUsedSpriteTile]
	add c
	dec a
	cp $ee
	ret nc

	ld a, h
	add $8
	ld h, a
	jp .CopyToVram
; 14406

.GetTileAddr: ; 14406
; Return the address of tile (a) in (hl).
	and $7f
	ld l, a
	ld h, 0
rept 4
	add hl, hl
endr
	ld a, l
	add VTiles0 % $100
	ld l, a
	ld a, h
	adc VTiles0 / $100
	ld h, a
	ret
; 14418

.CopyToVram: ; 14418
	ld a, [rVBK]
	push af
	ld a, [wSpriteFlags]
	bit 5, a
	ld a, $1
	jr z, .bankswitch
	xor a

.bankswitch
	ld [rVBK], a
	call Get2bpp
	pop af
	ld [rVBK], a
	ret
; 1442f

LoadEmote:: ; 1442f
; Get the address of the pointer to emote c.
	ld a, c
	ld bc, 6
	ld hl, EmotesPointers
	rst AddNTimes
; Load the emote address into de
	ld e, [hl]
	inc hl
	ld d, [hl]
; load the length of the emote (in tiles) into c
	inc hl
	ld c, [hl]
	swap c
; load the emote pointer bank into b
	inc hl
	ld b, [hl]
; load the VRAM destination into hl
	inc hl
	ld a, [hli]
	ld h, [hl]
	ld l, a
; if the emote has a length of 0, do not proceed (error handling)
	ld a, c
	and a
	ret z
	jp GetEmote2bpp
; 1444d


INCLUDE "data/sprites/emotes.asm"

INCLUDE "data/sprites/sprite_mons.asm"

INCLUDE "data/maps/outdoor_sprites.asm"

INCLUDE "data/sprites/sprites.asm"
