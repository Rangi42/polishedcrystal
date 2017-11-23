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
	ld a, [UsedSprites]
	ld [hUsedSpriteIndex], a
	ld a, [UsedSprites + 1]
	ld [hUsedSpriteTile], a
	jp GetUsedSprite
; 14146

RefreshSprites:: ; 14168
	xor a
	ld bc, UsedSpritesEnd - UsedSprites
	ld hl, UsedSprites
	call ByteFill
	call GetPlayerSprite
	call AddMapSprites
	call LoadSpriteGFX
	call SortUsedSprites
	call ArrangeUsedSprites
	jp MapCallbackSprites_LoadUsedSpritesGFX
; 1416f

GetPlayerSprite: ; 14183
; Get Chris or Kris's sprite.
	ld hl, .Chris
	ld a, [wPlayerSpriteSetupFlags]
	bit 2, a
	jr nz, .go
	ld a, [PlayerGender]
	bit 0, a
	jr z, .go
	ld hl, .Kris

.go
	ld a, [PlayerState]
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
	ld [PlayerState], a
	ld a, SPRITE_CHRIS
	jr .finish

.good
	ld a, [hl]

.finish
	ld [UsedSprites + 0], a
	ld [PlayerSprite], a
	ld [PlayerObjectSprite], a
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


AddMapSprites: ; 141c9
	call GetMapPermission
	call CheckOutdoorMap
	jr z, AddOutdoorSprites
	; fallthrough

AddIndoorSprites: ; 141d9
	ld hl, Map1ObjectSprite
	ld a, 1
.loop
	push af
	ld a, [hl]
	call AddSpriteGFX
	ld de, OBJECT_LENGTH
	add hl, de
	pop af
	inc a
	cp NUM_OBJECTS
	jr nz, .loop
	ret
; 141ee

AddOutdoorSprites: ; 141ee
	ld a, [MapGroup]
	dec a
	ld c, a
	ld b, 0
	ld hl, OutdoorSprites
rept 2
	add hl, bc
endr
	ld a, [hli]
	ld h, [hl]
	ld l, a
.loop
	ld a, [hli]
	and a ; cp SPRITE_NONE
	ret z
	call AddSpriteGFX
	jr .loop
; 14209


MapCallbackSprites_LoadUsedSpritesGFX: ; 14209
	ld a, MAPCALLBACK_SPRITES
	call RunMapCallback
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

GetSprite: ; 1423c
	call GetMonSprite
	ret c

	ld hl, SpriteHeaders ; address
	dec a
	ld c, a
	ld b, 0
	ld a, 6
	call AddNTimes
	; load the address into de
	ld a, [hli]
	ld e, a
	ld a, [hli]
	ld d, a
	; load the length into c
	ld a, [hli]
	swap a
	ld c, a
	; load the sprite bank into both b and h
	ld b, [hl]
	ld a, [hli]
	; load the sprite type into l
	ld l, [hl]
	ld h, a
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
	ld hl, VariableSprites
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
	call AddNTimes
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

	ld hl, SpriteHeaders + 5 ; palette
	dec a
	ld c, a
	ld b, 0
	ld a, 6
	call AddNTimes
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
	ld hl, UsedSprites + 2
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


LoadSpriteGFX: ; 14306
	ld hl, UsedSprites
	ld b, SPRITE_GFX_LIST_CAPACITY
.loop
	ld a, [hli]
	and a
	ret z
	push hl
	push bc
	call .LoadSprite
	pop bc
	pop hl
	ld [hli], a
	dec b
	jr nz, .loop
	ret

.LoadSprite:
	call GetSprite
	ld a, l
	ret
; 1431e


SortUsedSprites: ; 1431e
; Bubble-sort sprites by type.

; Overworld map sprite sets are assumed to be manually sorted.

	call GetMapPermission
	call CheckOutdoorMap
	ret z

; Run backwards through UsedSprites to find the last one.

	ld c, SPRITE_GFX_LIST_CAPACITY
	ld de, UsedSprites + (SPRITE_GFX_LIST_CAPACITY - 1) * 2
.FindLastSprite:
	ld a, [de]
	and a
	jr nz, .FoundLastSprite
	dec de
	dec de
	dec c
	jr nz, .FindLastSprite
.FoundLastSprite:
	dec c
	ret z

; If the length of the current sprite is
; higher than a later one, swap them.

	inc de
	ld hl, UsedSprites + 1

.CheckSprite:
	push bc
	push de
	push hl

.CheckFollowing:
	ld a, [de]
	cp [hl]
	jr nc, .loop

; Swap the two sprites.

	ld b, a
	ld a, [hl]
	ld [hl], b
	ld [de], a
	dec de
	dec hl
	ld a, [de]
	ld b, a
	ld a, [hl]
	ld [hl], b
	ld [de], a
	inc de
	inc hl

; Keep doing this until everything's in order.

.loop
	dec de
	dec de
	dec c
	jr nz, .CheckFollowing

	pop hl
	inc hl
	inc hl
	pop de
	pop bc
	dec c
	jr nz, .CheckSprite
	ret
; 14355


ArrangeUsedSprites: ; 14355
; Get the length of each sprite and space them out in VRAM.
; Crystal introduces a second table in VRAM bank 0.

	ld hl, UsedSprites
	lb bc, 0, SPRITE_GFX_LIST_CAPACITY
.FirstTableLength:
; Keep going until the end of the list.
	ld a, [hli]
	and a
	ret z

	ld a, [hl]
	call GetSpriteLength

; Spill over into the second table after $78 tiles.
	add b
	cp $78
	jr z, .loop
	jr nc, .SecondTable

.loop
	ld [hl], b
	inc hl
	ld b, a

; Assumes the next table will be reached before c hits 0.
	dec c
	jr nz, .FirstTableLength

.SecondTable:
; The second tile table starts at tile $80.
	ld b, $80
	dec hl
.SecondTableLength:
; Keep going until the end of the list.
	ld a, [hli]
	and a
	ret z

	ld a, [hl]
	call GetSpriteLength

; There are only two tables, so don't go any further than that.
	add b
	ret c

	ld [hl], b
	ld b, a
	inc hl

	dec c
	jr nz, .SecondTableLength
	ret
; 14386


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
	ld hl, UsedSprites
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

GetUsedSprite: ; 143c8
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
	bit 5, a
	ret nz
	bit 6, a
	ret nz

	ld a, [hUsedSpriteIndex]
	call _DoesSpriteHaveFacings
	ret c

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
	call AddNTimes
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

emote_header: MACRO
	dw \1
	db \2 tiles, BANK(\1)
	dw VTiles0 tile \3
ENDM

EmotesPointers: ; 144d
; dw source address
; db length, bank
; dw dest address
	emote_header ShockEmote,      4, $78 ; EMOTE_SHOCK
	emote_header QuestionEmote,   4, $78 ; EMOTE_QUESTION
	emote_header HappyEmote,      4, $78 ; EMOTE_HAPPY
	emote_header SadEmote,        4, $78 ; EMOTE_SAD
	emote_header HeartEmote,      4, $78 ; EMOTE_HEART
	emote_header BoltEmote,       4, $78 ; EMOTE_HEART
	emote_header SleepEmote,      4, $78 ; EMOTE_SLEEP
	emote_header FishEmote,       4, $78 ; EMOTE_FISH
	emote_header JumpShadowGFX,   1, $7c ; EMOTE_SHADOW
	emote_header FishingRodGFX,   2, $7c ; EMOTE_ROD
	emote_header BoulderDustGFX,  2, $7e ; EMOTE_BOULDER_DUST
	emote_header ShakingGrassGFX, 1, $7e ; EMOTE_SHAKING_GRASS
	emote_header PuddleSplashGFX, 1, $7f ; EMOTE_PUDDLE_SPLASH
; 14495


SpriteMons: ; 14495
	db BULBASAUR
	db CHARMANDER
	db SQUIRTLE
	db WEEDLE
	db PIDGEY
	db PIDGEOTTO
	db RATTATA
	db PIKACHU
	db NIDORAN_F
	db NIDORAN_M
	db NIDORINO
	db CLEFAIRY
	db JIGGLYPUFF
	db ODDISH
	db VILEPLUME
	db DIGLETT
	db MEOWTH
	db PERSIAN
	db PSYDUCK
	db POLIWAG
	db POLIWRATH
	db ABRA
	db MACHOP
	db MACHOKE
	db TENTACOOL
	db GEODUDE
	db SLOWPOKE
	db SLOWBRO
	db DODRIO
	db GRIMER
	db SHELLDER
	db GENGAR
	db VOLTORB
	db ELECTRODE
	db RHYDON
	db CHANSEY
	db STARYU
	db MAGIKARP
	db ARTICUNO
	db ZAPDOS
	db MOLTRES
	db DRATINI
	db MEWTWO
	db FURRET
	db HOOTHOOT
	db AMPHAROS
	db MARILL
	db MURKROW
	db SLOWKING
	db UNOWN
	db HERACROSS
	db WEAVILE
	db URSARING
	db SKARMORY
	db SMEARGLE
	db MILTANK
	db BLISSEY
	db RAIKOU
	db ENTEI
	db SUICUNE
	db LUGIA
	db HO_OH
	db EGG
; 144b8


OutdoorSprites: ; 144b8
; Valid sprite IDs for each map group.
; Maximum 9 walking sprites and 18-32 total sprites used per group.

	dw Group1Sprites
	dw Group2Sprites
	dw Group3Sprites
	dw Group4Sprites
	dw Group5Sprites
	dw Group6Sprites
	dw Group7Sprites
	dw Group8Sprites
	dw Group9Sprites
	dw Group10Sprites
	dw Group11Sprites
	dw Group12Sprites
	dw Group13Sprites
	dw Group14Sprites
	dw Group15Sprites
	dw Group16Sprites
	dw Group17Sprites
	dw Group18Sprites
	dw Group19Sprites
	dw Group20Sprites
	dw Group21Sprites
	dw Group22Sprites
	dw Group23Sprites
	dw Group24Sprites
	dw Group25Sprites
	dw Group26Sprites
	dw Group27Sprites
	dw Group28Sprites
	dw Group29Sprites
	dw Group30Sprites
	dw Group31Sprites
	dw Group32Sprites
	dw Group33Sprites
	dw Group34Sprites
	dw Group35Sprites
	dw Group36Sprites


; OlivineCity connects to Route40
Group1Sprites:
; Route38
; Route39
; OlivineCity
; Route35Coast
Group22Sprites:
; Route40
; Route41
; CianwoodCity
; BattleTowerOutside
Group29Sprites:
; GoldenrodHarbor
	db SPRITE_BEAUTY
	db SPRITE_FISHER
	db SPRITE_LASS
	db SPRITE_POKEFAN_F
	db SPRITE_POKEFAN_M
	db SPRITE_SAILOR
	db SPRITE_SWIMMER_GIRL
	db SPRITE_SWIMMER_GUY
	db SPRITE_OLIVINE_RIVAL ; SPRITE_SILVER, SPRITE_EUSINE, SPRITE_COWGIRL
	db SPRITE_YOUNGSTER ; doesn't walk
	db SPRITE_ROCKET ; doesn't walk
	; 11 walking sprites (9 that walk)
	db SPRITE_BALL_CUT_FRUIT
	db SPRITE_BOULDER_ROCK_FOSSIL
	db SPRITE_MAGIKARP
	db SPRITE_MILTANK
	db SPRITE_SUICUNE
	db SPRITE_N64
	; 17 total sprites
	db 0


; Route42 connects to VioletOutskirts
; Route32 connects to CherrygroveBay
; Route29 connects to CherrygroveCity
Group2Sprites:
; Route42
; Route44
; MahoganyTown
Group10Sprites:
; Route32
; VioletCity
; MagnetTunnelEast
; VioletOutskirts
Group24Sprites:
; Route26
; Route27
; Route29
; NewBarkTown
Group26Sprites:
; Route30
; Route31
; CherrygroveBay
; CherrygroveCity
	db SPRITE_NEW_BARK_LYRA ; SPRITE_LYRA, SPRITE_LASS
	db SPRITE_CHERRYGROVE_RIVAL ; SPRITE_SILVER, SPRITE_BUG_CATCHER
	db SPRITE_GUIDE_GENT ; SPRITE_GUIDE_GENT, SPRITE_SWIMMER_GUY, SPRITE_DRAGON_TAMER
	db SPRITE_COOLTRAINER_F
	db SPRITE_COOLTRAINER_M
	db SPRITE_FISHER
	db SPRITE_SWIMMER_GIRL
	db SPRITE_TEACHER
	db SPRITE_YOUNGSTER
	db SPRITE_GRAMPS ; doesn't walk
	db SPRITE_OFFICER ; doesn't walk
	db SPRITE_POKEFAN_M ; doesn't walk
	db SPRITE_SUPER_NERD ; doesn't walk
	db SPRITE_VETERAN_F ; doesn't walk
	db SPRITE_VETERAN_M ; doesn't walk
	db SPRITE_COSPLAYER ; doesn't walk
	; 16 walking sprites (9 that walk)
	db SPRITE_BALL_CUT_FRUIT
	db SPRITE_BOULDER_ROCK_FOSSIL
	db SPRITE_ROUTE_30_RATTATA ; SPRITE_RATTATA, SPRITE_SUICUNE
	db SPRITE_PIDGEY
	; 21 total sprites
	db 0


Group3Sprites:
; NationalPark
; NationalParkBugContest
	db SPRITE_BUG_CATCHER
	db SPRITE_BUG_MANIAC
	db SPRITE_COOLTRAINER_M
	db SPRITE_LASS
	db SPRITE_POKEFAN_F
	db SPRITE_POKEFAN_M
	db SPRITE_TEACHER
	db SPRITE_TWIN
	db SPRITE_YOUNGSTER
	; 9 walking sprites
	db SPRITE_BALL_CUT_FRUIT
	db SPRITE_GAMEBOY_KID
	db SPRITE_PERSIAN
	; 12 total sprites
	db 0


; EcruteakCity connects to Route36
Group4Sprites:
; EcruteakCity
; Route37
Group36Sprites:
; Route35
; Route36
	db SPRITE_BREEDER
	db SPRITE_BEAUTY
	db SPRITE_BUG_CATCHER
	db SPRITE_FISHER
	db SPRITE_GRAMPS
	db SPRITE_LASS
	db SPRITE_SUPER_NERD
	db SPRITE_TWIN
	db SPRITE_YOUNGSTER
	db SPRITE_COOLTRAINER_F ; doesn't walk
	db SPRITE_SIGHTSEER_M ; doesn't walk
	db SPRITE_HEX_MANIAC ; doesn't walk
	db SPRITE_OFFICER ; doesn't walk
	; 13 walking sprites (9 that walk)
	db SPRITE_BALL_CUT_FRUIT
	db SPRITE_WEIRD_TREE
	db SPRITE_SMEARGLE
	db SPRITE_SUICUNE
	; 17 total sprites
	db 0


Group5Sprites:
; Route45
; Route46
; BlackthornCity
	db SPRITE_BLACK_BELT
	db SPRITE_COOLTRAINER_F
	db SPRITE_COOLTRAINER_M
	db SPRITE_DRAGON_TAMER
	db SPRITE_GRAMPS
	db SPRITE_LASS
	db SPRITE_POKEFAN_M
	db SPRITE_SUPER_NERD
	db SPRITE_YOUNGSTER
	; 9 walking sprites
	db SPRITE_BALL_CUT_FRUIT
	; 10 total sprites
	db 0


; Route21 connects to PalletTown
Group6Sprites:
; Route19
; Route20
; Route21
; UragaChannelWest
; CinnabarIsland
Group13Sprites:
; Route1
; PalletTown
	db SPRITE_COOLTRAINER_F
	db SPRITE_COOLTRAINER_M
	db SPRITE_ENGINEER
	db SPRITE_FISHER
	db SPRITE_LASS
	db SPRITE_SWIMMER_GIRL
	db SPRITE_SWIMMER_GUY
	db SPRITE_TEACHER
	db SPRITE_YOUNGSTER
	db SPRITE_BLUE ; doesn't walk
	db SPRITE_COSPLAYER ; doesn't walk
	; 11 walking sprites (9 that walk)
	db SPRITE_BALL_CUT_FRUIT
	db SPRITE_BOULDER_ROCK_FOSSIL
	; 13 total sprites
	db 0


; CeruleanCity connects to Route5
; CeruleanCity connects to Route9
Group7Sprites:
; Route4
; Route24
; Route25
; CeruleanCape
; CeruleanCity
Group25Sprites:
; Route5
Group28Sprites:
; Route9
; Route10North
	db SPRITE_CERULEAN_CAPE_MISTY ; SPRITE_MISTY, SPRITE_LAWRENCE
	db SPRITE_COOLTRAINER_M
	db SPRITE_BEAUTY
	db SPRITE_GENTLEMAN
	db SPRITE_LASS
	db SPRITE_POKEFAN_M
	db SPRITE_SUPER_NERD
	db SPRITE_YOUNGSTER
	db SPRITE_SWIMMER_GUY
	db SPRITE_COOLTRAINER_F ; doesn't walk
	db SPRITE_ENGINEER ; doesn't walk
	db SPRITE_FISHER ; doesn't walk
	db SPRITE_LADY ; doesn't walk
	db SPRITE_ROCKET ; doesn't walk
	; 14 walking sprites (9 that walk)
	db SPRITE_BALL_CUT_FRUIT
	db SPRITE_SLOWPOKE
	db SPRITE_SLOWBRO
	db SPRITE_ZAPDOS
	; 18 total sprites
	db 0


Group8Sprites:
; Route33
; AzaleaTown
	db SPRITE_GRAMPS
	db SPRITE_LASS
	db SPRITE_POKEFAN_M
	db SPRITE_ROCKET
	db SPRITE_SILVER
	db SPRITE_TEACHER
	db SPRITE_TWIN
	db SPRITE_YOUNGSTER
	db SPRITE_KURT ; doesn't walk
	; 9 walking sprites (8 that walk)
	db SPRITE_BALL_CUT_FRUIT
	db SPRITE_SLOWPOKE
	; 11 total sprites
	db 0


Group9Sprites:
; Route43
; LakeofRage
	db SPRITE_BIG_GYARADOS
	db SPRITE_BREEDER
	db SPRITE_COOLTRAINER_F
	db SPRITE_FISHER
	db SPRITE_SUPER_NERD
	db SPRITE_YOUNGSTER
	db SPRITE_LASS
	db SPRITE_LAKE_OF_RAGE_LANCE ; doesn't walk
	db SPRITE_GRAMPS ; doesn't walk
	db SPRITE_COOLTRAINER_M ; doesn't walk
	db SPRITE_LADY ; doesn't walk
	; 11/14 walking sprites (7/10 that walk) (SPRITE_BIG_GYARADOS counts as 4)
	db SPRITE_BALL_CUT_FRUIT
	; 12/15 total sprites
	db 0


Group11Sprites:
; Route34
; Route34Coast
; StormyBeach
; GoldenrodCity
; MagnetTunnelWest
	db SPRITE_BREEDER
	db SPRITE_COOLTRAINER_F
	db SPRITE_GOLDENROD_LYRA ; SPRITE_LYRA, SPRITE_SWIMMER_GIRL
	db SPRITE_GRAMPS
	db SPRITE_LASS
	db SPRITE_POKEFAN_M
	db SPRITE_RICH_BOY
	db SPRITE_YOUNGSTER
	db SPRITE_SWIMMER_GUY
	db SPRITE_FISHER ; doesn't walk
	db SPRITE_OFFICER_F ; doesn't walk
	db SPRITE_ROCKET ; doesn't walk
	; 12 walking sprites (9 that walk)
	db SPRITE_BALL_CUT_FRUIT
	db SPRITE_BOULDER_ROCK_FOSSIL
	db SPRITE_DAYCARE_MON_1
	db SPRITE_DAYCARE_MON_2
	; 16 total sprites
	db 0


Group12Sprites:
; Route6
; Route11
; VermilionCity
	db SPRITE_COOLTRAINER_F
	db SPRITE_ENGINEER
	db SPRITE_LAWRENCE
	db SPRITE_POKEFAN_M
	db SPRITE_ROCKER
	db SPRITE_SAILOR
	db SPRITE_TWIN
	db SPRITE_YOUNGSTER
	db SPRITE_GRAMPS ; doesn't walk
	db SPRITE_OFFICER_F ; doesn't walk
	db SPRITE_SUPER_NERD ; doesn't walk
	; 11 walking sprites (9 that walk)
	db SPRITE_BALL_CUT_FRUIT
	db SPRITE_BOULDER_ROCK_FOSSIL
	db SPRITE_BIG_SNORLAX
	db SPRITE_MACHOP
	; 15 total sprites
	db 0


Group14Sprites:
; Route2North
; Route3
; PewterCity
	db SPRITE_CHILD
	db SPRITE_BLACK_BELT
	db SPRITE_BUG_MANIAC
	db SPRITE_FISHER
	db SPRITE_GRAMPS
	db SPRITE_POKEFAN_M
	db SPRITE_YOUNGSTER
	db SPRITE_COOLTRAINER_M ; doesn't walk
	db SPRITE_COOLTRAINER_F ; doesn't walk
	; 9 walking sprites (7 that walk)
	db SPRITE_BALL_CUT_FRUIT
	; 10 total sprites
	db 0


Group15Sprites:
; OlivinePort
; VermilionPort
; MountMoonSquare
; TinTowerRoof
	db SPRITE_COOLTRAINER_F
	db SPRITE_CLEFAIRY_WALK
	db SPRITE_FISHING_GURU
	db SPRITE_SAILOR
	db SPRITE_SUPER_NERD
	db SPRITE_YOUNGSTER
	; 6 walking sprites
	db SPRITE_N64
	db SPRITE_HO_OH
	; 8 total sprites
	db 0


Group16Sprites:
; Route23
; IndigoPlateau
; BellchimeTrail
	db SPRITE_VALERIE
	db SPRITE_OFFICER
	db SPRITE_OFFICER_F
	db SPRITE_SWIMMING_OFFICER
	db SPRITE_SWIMMING_OFFICER_F
	; 5 walking sprites
	; 5 total sprites
	db 0


Group17Sprites:
; Route12South
; Route13East
; Route13West
; Route14
; Route15
; Route18East
; FuchsiaCity
; LuckyIsland
	db SPRITE_FISHER
	db SPRITE_POKEFAN_F
	db SPRITE_POKEFAN_M
	db SPRITE_TEACHER
	db SPRITE_TWIN
	db SPRITE_YOUNGSTER
	db SPRITE_LASS
	db SPRITE_BAKER
	db SPRITE_ARTIST
	db SPRITE_GRAMPS ; doesn't walk
	db SPRITE_SIGHTSEER_M ; doesn't walk
	db SPRITE_LADY ; doesn't walk
	; 12 walking sprites (9 that walk)
	db SPRITE_BALL_CUT_FRUIT
	; 13 total sprites
	db 0


Group18Sprites:
; Route8
; Route10South
; Route12North
; LavenderTown
	db SPRITE_BIKER
	db SPRITE_GENTLEMAN
	db SPRITE_FISHER
	db SPRITE_GRAMPS
	db SPRITE_HEX_MANIAC
	db SPRITE_POKEFAN_M
	db SPRITE_SUPER_NERD
	db SPRITE_TEACHER
	db SPRITE_YOUNGSTER
	db SPRITE_COOLTRAINER_F ; doesn't walk
	db SPRITE_LASS ; doesn't walk
	db SPRITE_ROCKER ; doesn't walk
	; 11 walking sprites (9 that walk)
	db SPRITE_BALL_CUT_FRUIT
	; 12 total sprites
	db 0


Group19Sprites:
; Route28
; SilverCaveOutside
; FarawayIsland
; FarawayJungle
	db SPRITE_SAILOR
	db SPRITE_LAWRENCE
	; 2 walking sprites
	db SPRITE_BALL_CUT_FRUIT
	db SPRITE_MEW
	; 4 total sprites
	db 0


Group20Sprites:
; YellowForest
; EcruteakShrineOutside
	db SPRITE_BREEDER
	db SPRITE_COOLTRAINER_M
	db SPRITE_SAGE
	db SPRITE_SUPER_NERD
	db SPRITE_TEACHER
	db SPRITE_TWIN
	db SPRITE_WALKER
	db SPRITE_YELLOW
	; 8 walking sprites
	db SPRITE_BALL_CUT_FRUIT
	db SPRITE_HOOTHOOT
	db SPRITE_SKARMORY
	; 11 total sprites
	db 0


Group21Sprites:
; Route7
; Route16North
; Route16South
; Route17
; UragaChannelEast
; CeladonCity
	db SPRITE_BIKER
	db SPRITE_BREEDER
	db SPRITE_FISHER
	db SPRITE_GRAMPS
	db SPRITE_LASS
	db SPRITE_RICH_BOY
	db SPRITE_TEACHER
	db SPRITE_ROUGHNECK
	db SPRITE_YOUNGSTER
	db SPRITE_OFFICER_F ; doesn't walk
	db SPRITE_SWIMMER_GIRL ; doesn't walk
	db SPRITE_COOLTRAINER_M ; doesn't walk
	; 12 walking sprites (9 that walk)
	db SPRITE_BALL_CUT_FRUIT
	db SPRITE_BIG_SNORLAX
	db SPRITE_POLIWRATH
	; 15 total sprites
	db 0


Group23Sprites:
; Route2South
; Route22
; ViridianCity
; ViridianForest
; Route16West
	db SPRITE_BEAUTY
	db SPRITE_BUG_CATCHER
	db SPRITE_BUG_MANIAC
	db SPRITE_COSPLAYER
	db SPRITE_FISHER
	db SPRITE_GRAMPS
	db SPRITE_LADY
	db SPRITE_LASS
	db SPRITE_YOUNGSTER
	db SPRITE_COOLTRAINER_F ; doesn't walk
	; 10 walking sprites (9 that walk)
	db SPRITE_KUKUI
	db SPRITE_BALL_CUT_FRUIT
	; 12 total sprites
	db 0


Group27Sprites:
; Route47
; Route48
	db SPRITE_COOLTRAINER_F
	db SPRITE_COOLTRAINER_M
	db SPRITE_COWGIRL
	db SPRITE_JAMES
	db SPRITE_JESSIE
	db SPRITE_POKEFAN_M
	db SPRITE_ROCKET
	db SPRITE_ROCKET_GIRL
	db SPRITE_YOUNGSTER
	db SPRITE_ARCHER ; doesn't walk
	db SPRITE_LASS ; doesn't walk
	; 11 walking sprites (9 that walk)
	db SPRITE_BALL_CUT_FRUIT
	; 12 total sprites
	db 0


Group30Sprites:
; RuinsofAlphOutside
; Route22Past
	db SPRITE_FISHER
	db SPRITE_SCIENTIST
	db SPRITE_SUPER_NERD
	db SPRITE_YOUNGSTER
	db SPRITE_CELEBI
	db SPRITE_LYRA
	db SPRITE_SILVER
	db SPRITE_GIOVANNI
	; 8 walking sprites
	db SPRITE_BOULDER_ROCK_FOSSIL
	; 9 total sprites
	db 0


Group31Sprites:
; ShamoutiIsland
; BeautifulBeach
; RockyBeach
; WarmBeach
; ShamoutiCoast
	db SPRITE_ARTIST
	db SPRITE_COOLTRAINER_M
	db SPRITE_COOLTRAINER_F
	db SPRITE_SIGHTSEER_M
	db SPRITE_SWIMMER_GIRL
	db SPRITE_SWIMMER_GUY
	db SPRITE_LADY
	db SPRITE_LASS
	db SPRITE_BREEDER
	db SPRITE_YOUNGSTER ; doesnt walk
	db SPRITE_BEAUTY ; doesn't walk
	db SPRITE_FISHER ; doesn't walk
	db SPRITE_GRAMPS ; doesnt walk
	db SPRITE_CANDELA ; doesn't walk
	db SPRITE_BLANCHE ; doesn't walk
	db SPRITE_SPARK ; doesn't walk
	; 16 walking sprites (9 that walk)
	db SPRITE_BALL_CUT_FRUIT
	db SPRITE_MARILL
	db SPRITE_VILEPLUME
	db SPRITE_SLOWKING
	; 20 total sprites
	db 0


Group32Sprites:
; SafariZoneEast
; SafariZoneHub
; SafariZoneNorth
; SafariZoneWest
	db SPRITE_BEAUTY
	db SPRITE_COOLTRAINER_F
	db SPRITE_COOLTRAINER_M
	db SPRITE_COWGIRL
	db SPRITE_LASS
	db SPRITE_BUG_MANIAC
	db SPRITE_YOUNGSTER
	; 7 walking sprites
	db SPRITE_BALL_CUT_FRUIT
	; 8 total sprites
	db 0


Group33Sprites:
; ValenciaIsland
; Route49
	db SPRITE_ARTIST
	db SPRITE_COOLTRAINER_F
	db SPRITE_COOLTRAINER_M
	db SPRITE_FISHER
	db SPRITE_LADY
	db SPRITE_LASS
	db SPRITE_SAILOR
	db SPRITE_SIGHTSEER_M
	db SPRITE_YOUNGSTER
	db SPRITE_ROCKER ; doesn't walk
	; 10 walking sprites (9 that walk)
	db SPRITE_BALL_CUT_FRUIT
	; 11 total sprites
	db 0


Group34Sprites:
; SinjohRuins
	; 0 walking sprites
	; 0 total sprites
	db 0


Group35Sprites:
; SaffronCity
; ShamoutiShrineRuins
	db SPRITE_BLACK_BELT
	db SPRITE_COOLTRAINER_F
	db SPRITE_COOLTRAINER_M
	db SPRITE_LADY
	db SPRITE_LASS
	db SPRITE_POKEFAN_M
	db SPRITE_YOUNGSTER
	db SPRITE_LAWRENCE ; doesn't walk
	db SPRITE_FISHER ; doesn't walk
	db SPRITE_GRAMPS ; doesn't walk
	db SPRITE_SCIENTIST ; doesn't walk
	db SPRITE_SUPER_NERD ; doesn't walk
	; 12 walking sprites (6 that walk)
	db SPRITE_SILPH_EMPLOYEE
	db SPRITE_BALL_CUT_FRUIT
	; 14 total sprites
	db 0


SpriteHeaders: ; 14736
INCLUDE "gfx/overworld/sprite_headers.asm"
; 1499a
