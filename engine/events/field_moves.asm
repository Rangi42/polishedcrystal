BlindingFlash::
	call FadeOutPalettes
	ld hl, wStatusFlags
	set 2, [hl] ; Flash
	call ReplaceTimeOfDayPals
	call UpdateTimeOfDayPal
	ld a, CGB_MAPPALS
	call GetCGBLayout
	farcall LoadBlindingFlashPalette
	jmp FadeInPalettes_EnableDynNoApply

ShakeHeadbuttTree:
	ld hl, wWeatherFlags
	set OW_WEATHER_LIGHTNING_DISABLED_F, [hl]
	farcall CancelOWFadePalettes
	farcall CopyBGGreenToOBPal7
	call ClearSpriteAnims
	call GetCurrentLandmark
	cp NOISY_FOREST
	ld hl, HeadbuttTree2GFX
	jr z, .got_gfx
	ld hl, HeadbuttTreeGFX
.got_gfx
	ld de, vTiles0 tile $61
	lb bc, BANK("Overworld Effect Graphics"), 12
	call DecompressRequest2bpp
	call Cut_Headbutt_GetPixelFacing
	ld a, SPRITE_ANIM_INDEX_HEADBUTT
	call InitSpriteAnimStruct
	ld hl, SPRITEANIMSTRUCT_TILE_ID
	add hl, bc
	ld [hl], $61

	; shift all sprites left in OAM by 4 slots
	; hl = source, de = destination, bc = length
	ldh a, [hUsedOAMIndex]
	; a = OAM_SIZE - a
	cpl
	add OAM_SIZE + 1
	ld h, HIGH(wShadowOAM)
	ld l, a
	sub (4 * OBJ_SIZE)
	ld e, a
	ld d, h
	ld b, 0
	ldh a, [hUsedOAMIndex]
	ld c, a
.copy_loop
	ld a, [hli]
	ld [de], a
	inc de
	dec c
	jr nz, .copy_loop

	ld a, LOW(wShadowOAMSprite36)
	ld [wCurSpriteOAMAddr], a
	call DoNextFrameForAllSprites
	call HideHeadbuttTree
	ld a, 32
	ld [wFrameCounter], a
	call WaitSFX
	ld de, SFX_SANDSTORM
	call PlaySFX
.loop
	ld hl, wFrameCounter
	ld a, [hl]
	and a
	jr z, .done
	dec [hl]

	ld a, LOW(wShadowOAMSprite36)
	ld [wCurSpriteOAMAddr], a
	call DoNextFrameForAllSprites_OW
	farcall DoOverworldWeather
	call DelayFrame
	jr .loop

.done
	call LoadMapPart
	call ApplyTilemapInVBlank
	xor a
	ldh [hBGMapMode], a

	; shift all sprites right in OAM by 4 slots
	; hl = source, de = destination, bc = length
	ldh a, [hUsedOAMIndex]
	; a = OAM_SIZE - a - 1
	cpl
	add OAM_SIZE
	ld l, a
	ld h, HIGH(wShadowOAM)
	ld de, wShadowOAMSprite39 + 3
	ld c, OBJ_SIZE * 4
.copy_done_loop
	ld a, [hld]
	ld [de], a
	dec de
	dec c
	jr nz, .copy_done_loop
	ld h, HIGH(wShadowOAM)
	ldh a, [hUsedOAMIndex]
	; a = (OAM_COUNT - 4) * OBJ_SIZE - a
	cpl
	add (OAM_COUNT - 4) * OBJ_SIZE + 1
	ld l, a

	ld c, 4
	ld de, OBJ_SIZE
	ld a, OAM_YCOORD_HIDDEN
.hide_loop
	ld [hl], a
	add hl, de
	dec c
	jr nz, .hide_loop

	call ClearSpriteAnims
	call DelayFrame
	ld hl, wWeatherFlags
	res OW_WEATHER_LIGHTNING_DISABLED_F, [hl]
	jmp UpdatePlayerSprite

HideHeadbuttTree:
	xor a
	ldh [hBGMapMode], a
	ld a, [wPlayerDirection]
	and %00001100
	srl a
	ld e, a
	ld d, 0
	ld hl, TreeRelativeLocationTable
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a

	ld a, ' '
	ld [hli], a
	ld [hld], a
	ld bc, SCREEN_WIDTH
	add hl, bc
	ld [hli], a
	ld [hld], a
	call ApplyTilemapInVBlank
	xor a
	ldh [hBGMapMode], a
	ret

TreeRelativeLocationTable:
	dwcoord 8,     8 + 2 ; RIGHT
	dwcoord 8,     8 - 2 ; LEFT
	dwcoord 8 - 2, 8     ; DOWN
	dwcoord 8 + 2, 8     ; UP

OWCutAnimation:
	; Animation index in a
	; 0: Split tree in half
	; 1: Mow the lawn
	ld [wJumptableIndex], a
	call ClearSpriteAnims
	call WaitSFX
	ld de, SFX_PLACE_PUZZLE_PIECE_DOWN
	call PlaySFX
	; shift all sprites left in OAM by 4 slots
	; hl = source, de = destination, bc = length
	ldh a, [hUsedOAMIndex]
	; a = OAM_SIZE - a
	cpl
	add OAM_SIZE + 1
	ld h, HIGH(wShadowOAM)
	ld l, a
	sub (4 * OBJ_SIZE)
	ld e, a
	ld d, h
	ld b, 0
	ldh a, [hUsedOAMIndex]
	ld c, a
.copy_loop
	ld a, [hli]
	ld [de], a
	inc de
	dec c
	jr nz, .copy_loop
.loop
	ld a, [wJumptableIndex]
	bit 7, a
	jr nz, .finish

	ld a, LOW(wShadowOAMSprite36)
	ld [wCurSpriteOAMAddr], a
	call DoNextFrameForAllSprites
	farcall DoOverworldWeather
	call OWCutJumptable
	call DelayFrame
	jr .loop

.finish
	; hide tree/leaf sprites

	; shift all sprites right in OAM by 4 slots
	; hl = source, de = destination, bc = length
	ldh a, [hUsedOAMIndex]
	; a = OAM_SIZE - a - 1
	cpl
	add OAM_SIZE
	ld l, a
	ld h, HIGH(wShadowOAM)
	ld de, wShadowOAMSprite39 + 3
	ld c, OBJ_SIZE * 4
.copy_done_loop
	ld a, [hld]
	ld [de], a
	dec de
	dec c
	jr nz, .copy_done_loop

	ld h, HIGH(wShadowOAM)
	ldh a, [hUsedOAMIndex]
	; a = (OAM_COUNT - 4) * OBJ_SIZE - a
	cpl
	add (OAM_COUNT - 4) * OBJ_SIZE + 1
	ld l, a
	ld c, 4
	ld de, OBJ_SIZE
	ld a, OAM_YCOORD_HIDDEN
.hide_loop
	ld [hl], a
	add hl, de
	dec c
	jr nz, .hide_loop
	ret

OWCutJumptable:
	call StandardStackJumpTable

.Jumptable:
	dw Cut_SpawnAnimateTree
	dw Cut_SpawnAnimateLeaves
	dw Cut_StartWaiting
	dw Cut_WaitAnimSFX

Cut_SpawnAnimateTree:
	call Cut_Headbutt_GetPixelFacing
	ld a, SPRITE_ANIM_INDEX_CUT_TREE
	call InitSpriteAnimStruct
	ld hl, SPRITEANIMSTRUCT_TILE_ID
	add hl, bc
	ld [hl], $74
	ld a, 32
	ld [wFrameCounter], a
; Cut_StartWaiting
	ld hl, wJumptableIndex
	inc [hl]
	inc [hl]
	ret

Cut_SpawnAnimateLeaves:
	call Cut_GetLeafSpawnCoords
	xor a
	call Cut_SpawnLeaf
	ld a, $10
	call Cut_SpawnLeaf
	ld a, $20
	call Cut_SpawnLeaf
	ld a, $30
	call Cut_SpawnLeaf
	ld a, 32 ; frames
	ld [wFrameCounter], a
; Cut_StartWaiting
	ld hl, wJumptableIndex
	inc [hl]
	ret

Cut_StartWaiting:
	ld a, $1
	ldh [hBGMapMode], a
; Cut_WaitAnimSFX
	ld hl, wJumptableIndex
	inc [hl]

Cut_WaitAnimSFX:
	ld hl, wFrameCounter
	ld a, [hl]
	and a
	jr z, .finished
	dec [hl]
	ret

.finished
	ld hl, wJumptableIndex
	set 7, [hl]
	ret

Cut_SpawnLeaf:
	push de
	push af
	ld a, SPRITE_ANIM_INDEX_LEAF ; leaf
	call InitSpriteAnimStruct
	ld hl, SPRITEANIMSTRUCT_TILE_ID
	add hl, bc
	ld [hl], $70
	ld hl, SPRITEANIMSTRUCT_VAR3
	add hl, bc
	ld [hl], $4
	pop af
	ld hl, SPRITEANIMSTRUCT_VAR1
	add hl, bc
	ld [hl], a
	pop de
	ret

Cut_GetLeafSpawnCoords:
	ld de, 0
	ld a, [wMetatileStandingX]
	bit 0, a
	jr z, .left_side
	set 0, e
.left_side
	ld a, [wMetatileStandingY]
	bit 0, a
	jr z, .top_side
	set 1, e
.top_side
	ld a, [wPlayerDirection]
	and %00001100
	add e
	ld e, a
	ld hl, .Coords
	add hl, de
	add hl, de
	ld a, [hli]
	ld d, [hl]
	ld e, a
	ret

.Coords:
	dbpixel 11, 12 ; facing down,  top left
	dbpixel  9, 12 ; facing down,  top right
	dbpixel 11, 14 ; facing down,  bottom left
	dbpixel  9, 14 ; facing down,  bottom right

	dbpixel 11,  8 ; facing up,    top left
	dbpixel  9,  8 ; facing up,    top right
	dbpixel 11, 10 ; facing up,    bottom left
	dbpixel  9, 10 ; facing up,    bottom right

	dbpixel  7, 12 ; facing left,  top left
	dbpixel  9, 12 ; facing left,  top right
	dbpixel  7, 10 ; facing left,  bottom left
	dbpixel  9, 10 ; facing left,  bottom right

	dbpixel 11, 12 ; facing right, top left
	dbpixel 13, 12 ; facing right, top right
	dbpixel 11, 10 ; facing right, bottom left
	dbpixel 13, 10 ; facing right, bottom right

Cut_Headbutt_GetPixelFacing:
	ld a, [wPlayerDirection]
	and %00001100
	srl a
	ld e, a
	ld d, 0
	ld hl, .Coords
	add hl, de
	ld a, [hli]
	ld d, [hl]
	ld e, a
	ret

.Coords:
	dbpixel 10, 13
	dbpixel 10,  9
	dbpixel  8, 11
	dbpixel 12, 11

FlyFromAnim:
	farcall CheckForUsedObjPals
	ldh a, [hUsedOAMIndex]
	cp (OAM_COUNT - NUM_FLYFROM_ANIM_OAMS - 1) * OBJ_SIZE
	call nc, ClearNormalSprites ; not enough OAM slots, clear all sprites.
	ld a, [wUsedObjectPals]
	set 7, a ; slot 7 already reserved for leaves.
	ld [wUsedObjectPals], a
	inc a
	call z, ClearSprites ; no more object palettes available, clear all sprites.
	call HidePlayerSprite
	call DelayFrame
	ld a, [wStateFlags]
	push af
	xor a
	ld [wStateFlags], a
	call FlyFunction_InitGFX
	depixel 10, 10, 4, 0
	ld a, SPRITE_ANIM_INDEX_FLY_MON
	call InitSpriteAnimStruct
	ld hl, SPRITEANIMSTRUCT_TILE_ID
	add hl, bc
	ld [hl], $64
	ld hl, SPRITEANIMSTRUCT_ANIM_SEQ_ID
	add hl, bc
	ld [hl], SPRITE_ANIM_SEQ_FLY_FROM
	ld a, 128
	ld [wFrameCounter], a
.loop
	ld a, [wJumptableIndex]
	bit 7, a
	jr nz, .exit

	ldh a, [hUsedOAMIndex]
	cp (OAM_COUNT - NUM_FLYFROM_ANIM_OAMS - 1) * OBJ_SIZE
	ld a, (OAM_COUNT - NUM_FLYFROM_ANIM_OAMS) * OBJ_SIZE
	jr nc, .got_oam_addr
	ldh a, [hUsedOAMIndex]
	; a = (OAM_COUNT - NUM_FLYFROM_ANIM_OAMS) * OBJ_SIZE - a
	cpl
	add (OAM_COUNT - NUM_FLYFROM_ANIM_OAMS) * OBJ_SIZE + 1
.got_oam_addr
	ld [wCurSpriteOAMAddr], a
	call DoNextFrameForAllSprites_OW
	farcall DoOverworldWeather
	call FlyFunction_FrameTimer
	call DelayFrame
	jr .loop

.exit
	pop af
	ld [wStateFlags], a
	ret

FlyToAnim:
	call HideSprites
	farcall LoadWeatherGraphics
	farcall LoadWeatherPal
	farcall SpawnRandomWeatherFullScreen
	call DelayFrame
	ld a, [wStateFlags]
	push af
	xor a
	ld [wStateFlags], a
	call FlyFunction_InitGFX
	depixel 31, 10, 4, 0
	ld a, SPRITE_ANIM_INDEX_FLY_MON
	call InitSpriteAnimStruct
	ld hl, SPRITEANIMSTRUCT_TILE_ID
	add hl, bc
	ld [hl], $64
	ld hl, SPRITEANIMSTRUCT_ANIM_SEQ_ID
	add hl, bc
	ld [hl], SPRITE_ANIM_SEQ_FLY_TO
	ld hl, SPRITEANIMSTRUCT_VAR4
	add hl, bc
	ld [hl], 11 * 8
	ld a, 64
	ld [wFrameCounter], a
.loop
	ld a, [wJumptableIndex]
	bit 7, a
	jr nz, .exit

	ldh a, [hUsedOAMIndex]
	cp (OAM_COUNT - NUM_FLYFROM_ANIM_OAMS - 1) * OBJ_SIZE
	ld a, (OAM_COUNT - NUM_FLYFROM_ANIM_OAMS) * OBJ_SIZE
	jr nc, .got_oam_addr
	ldh a, [hUsedOAMIndex]
	; a = (OAM_COUNT - NUM_FLYFROM_ANIM_OAMS) * OBJ_SIZE - a
	cpl
	add (OAM_COUNT - NUM_FLYFROM_ANIM_OAMS) * OBJ_SIZE + 1
.got_oam_addr

	ld [wCurSpriteOAMAddr], a
	call DoNextFrameForAllSprites_OW
	farcall DoOverworldWeather
	call FlyFunction_FrameTimer
	call DelayFrame
	jr .loop

.exit
	pop af
	ld [wStateFlags], a

	ld a, [wCurSpriteOAMAddr]
	sub NUM_FLYTO_ANIM_OAMS * OBJ_SIZE
	cpl
	add LOW(wShadowOAMEnd) + 1
	ld b, a
	ld h, HIGH(wShadowOAM)
	ld a, [wCurSpriteOAMAddr]
	sub NUM_FLYTO_ANIM_OAMS * OBJ_SIZE
	ld l, a
	call HideSpritesInRange


	ld hl, wShadowOAMSprite36TileID
	xor a
	ld c, $4
.loop2
	ld [hli], a
	inc hl
	inc hl
	inc hl
	inc a
	dec c
	jr nz, .loop2
	ret

FlyFunction_InitGFX:
	call ClearSpriteAnims
	call SetOWFlyMonColor
	ld e, $64
	call FlyFunction_GetMonIcon
	xor a
	ld [wJumptableIndex], a
	ret

FlyFunction_FrameTimer:
	call .SpawnLeaf
	ld hl, wFrameCounter
	ld a, [hl]
	and a
	jr z, .exit
	dec [hl]
	cp $40
	ret c
	and $7
	ret nz
	ld de, SFX_FLY
	jmp PlaySFX

.exit
	ld hl, wJumptableIndex
	set 7, [hl]
	ret

.SpawnLeaf:
	ld hl, wFrameCounter2
	ld a, [hl]
	inc [hl]
	and $7
	ret nz
	ld a, [hl]
	and (6 * 8) >> 1
	add a
	add 8 * 8 ; gives a number in [$40, $50, $60, $70]
	ld d, a
	ld e, 0
	ld a, SPRITE_ANIM_INDEX_FLY_LEAF ; fly land
	call InitSpriteAnimStruct
	ld hl, SPRITEANIMSTRUCT_TILE_ID
	add hl, bc
	ld [hl], $70
	ret
