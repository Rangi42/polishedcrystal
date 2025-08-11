Special_MagnetTrain:
	ldh a, [hScriptVar]
	and a
	jr nz, .ToGoldenrod
	ld a, 1 ; forwards
	lb bc, 8 * TILE_WIDTH, 12 * TILE_WIDTH
	lb de, (11 * TILE_WIDTH) - (11 * TILE_WIDTH + 4), -12 * TILE_WIDTH
	jr .continue

.ToGoldenrod:
	ld a, -1 ; backwards
	lb bc, -8 * TILE_WIDTH, -12 * TILE_WIDTH
	lb de, (11 * TILE_WIDTH) + (11 * TILE_WIDTH + 4), 12 * TILE_WIDTH

.continue
	ld h, a
	ldh a, [rWBK]
	push af
	ld a, BANK(wMagnetTrain)
	ldh [rWBK], a

	ld a, h
	ld [wMagnetTrainDirection], a
	ld a, c
	ld [wMagnetTrainInitPosition], a
	ld a, b
	ld [wMagnetTrainHoldPosition], a
	ld a, e
	ld [wMagnetTrainFinalPosition], a
	ld a, d
	ld [wMagnetTrainPlayerSpriteInitX], a

	ldh a, [hSCX]
	push af
	ldh a, [hSCY]
	push af
	call MagnetTrain_LoadGFX_PlayMusic
	ldh a, [hVBlank]
	push af
	ld a, $1
	ldh [hVBlank], a
.loop
	ld a, [wJumptableIndex]
	and a
	jr z, .initialize
	bit 7, a
	jr nz, .done
	call PlaySpriteAnimations
	call MagnetTrain_Jumptable
	call MagnetTrain_UpdateLYOverrides
	call PushLYOverrides
	call DelayFrame
	jr .loop

.initialize
	call MagnetTrain_Jumptable_FirstRunThrough
	jr .loop

.done
	pop af
	ldh [hVBlank], a
	call ClearBGPalettes
	ld hl, rIE
	res B_IE_STAT, [hl]
	xor a
	ldh [hLCDCPointer], a
	ldh [hLYOverrideStart], a
	ldh [hLYOverrideEnd], a
	ldh [hSCX], a
	ldh [hRequestedVTileSource], a
	ldh [hRequestedVTileSource + 1], a
	ldh [hRequestedVTileDest], a
	ldh [hRequestedVTileDest + 1], a
	ldh [hRequested2bpp], a
	call ClearTileMap

	pop af
	ldh [hSCY], a
	pop af
	ldh [hSCX], a
	xor a
	ldh [hBGMapMode], a

	pop af
	ldh [rWBK], a
	ret

MagnetTrain_UpdateLYOverrides:
	ld hl, wLYOverridesBackup
	ld c, 6 * TILE_WIDTH - 1
	ld a, [wMagnetTrainOffset]
	add a
	ldh [hSCX], a
	call .loadloop
	ld c, 4 * TILE_WIDTH
	ld a, [wMagnetTrainPosition]
	call .loadloop
	ld c, 8 * TILE_WIDTH + 1
	ld a, [wMagnetTrainOffset]
	add a
	call .loadloop

	ld a, [wMagnetTrainDirection]
	ld d, a
	ld hl, wMagnetTrainOffset
	ld a, [hl]
	add d
	add d
	ld [hl], a
	ret

.loadloop
	ld [hli], a
	dec c
	jr nz, .loadloop
	ret

MagnetTrain_LoadGFX_PlayMusic:
	call ClearBGPalettes
	call ClearSprites
	call DisableLCD
	call ClearSpriteAnims
	call SetMagnetTrainPals
	call DrawMagnetTrain
	ld a, SCREEN_HEIGHT_PX
	ldh [hWY], a
	call EnableLCD
	xor a
	ldh [hBGMapMode], a
	ldh [hSCX], a
	ldh [hSCY], a

	; Load the player sprite's standing frames
	ldh a, [rWBK]
	push af
	ld a, BANK(wPlayerGender)
	ldh [rWBK], a
	farcall GetPlayerIcon
	pop af
	ldh [rWBK], a
	ld hl, vTiles0
	ld c, 4
	push bc
	push de
	call Request2bppInWRA6
	pop de
	pop bc
	; Load the player sprite's walking frames
	ld hl, 12 tiles
	add hl, de
	ld d, h
	ld e, l
	ld hl, vTiles0 tile $04
	ld c, 4
	call Request2bppInWRA6

	call MagnetTrain_InitLYOverrides

	ld hl, wJumptableIndex
	xor a
	ld [hli], a ; wJumptableIndex
	ld a, [wMagnetTrainInitPosition]
	ld [hli], a ; wMagnetTrainOffset
	ld [hli], a ; wMagnetTrainPosition
	ld [hli], a ; wMagnetTrainWaitCounter

	ld e, MUSIC_MAGNET_TRAIN
	jmp PlayMusic2

DrawMagnetTrain:
	hlbgcoord 0, 0
	xor a
.loop
	call .GetBGTiles
	ld b, TILEMAP_WIDTH / 2
	call .FillAlt
	inc a
	cp SCREEN_HEIGHT
	jr c, .loop

	hlbgcoord 0, 6
	ld de, MagnetTrainTilemap
	ld c, SCREEN_WIDTH
	call .FillLine
	hlbgcoord 0, 7
	ld de, MagnetTrainTilemap + SCREEN_WIDTH
	ld c, SCREEN_WIDTH
	call .FillLine
	hlbgcoord 0, 8
	ld de, MagnetTrainTilemap + (SCREEN_WIDTH * 2)
	ld c, SCREEN_WIDTH
	call .FillLine
	hlbgcoord 0, 9
	ld de, MagnetTrainTilemap + (SCREEN_WIDTH * 3)
	ld c, SCREEN_WIDTH
	; fallthrough

.FillLine:
	ld a, [de]
	inc de
	ld [hli], a
	dec c
	jr nz, .FillLine
	ret

.FillAlt:
	ld [hl], e ; no-optimize *hl++|*hl-- = b|c|d|e (a is the .loop counter)
	inc hl
	ld [hl], d ; no-optimize *hl++|*hl-- = b|c|d|e (a is the .loop counter)
	inc hl
	dec b
	jr nz, .FillAlt
	ret

.GetBGTiles:
	push hl
	ld e, a
	ld d, 0
	ld hl, MagnetTrainBGTiles
	add hl, de
	add hl, de
	ld e, [hl] ; no-optimize b|c|d|e = *hl++|*hl-- (a is the .loop counter)
	inc hl
	ld d, [hl]
	pop hl
	ret

MagnetTrainBGTiles:
; 2x18 tilemap, repeated in vertical strips for the background.
INCBIN "gfx/overworld/magnet_train_bg.tilemap"

MagnetTrain_InitLYOverrides:
	ld hl, wLYOverrides
	ld bc, wLYOverridesEnd - wLYOverrides
	ld a, [wMagnetTrainInitPosition]
	rst ByteFill
	ld hl, wLYOverridesBackup
	ld bc, wLYOverridesBackupEnd - wLYOverridesBackup
	ld a, [wMagnetTrainInitPosition]
	rst ByteFill
	ld hl, rIE
	set B_IE_STAT, [hl]
	ld a, LOW(rSCX)
	ldh [hLCDCPointer], a
	ret

SetMagnetTrainPals:
	ld a, 1
	ldh [rVBK], a

	; bushes
	hlbgcoord 0, 0
	ld bc, 4 * TILEMAP_WIDTH
	ld a, PAL_BG_GREEN
	rst ByteFill

	; train
	hlbgcoord 0, 4
	ld bc, 10 * TILEMAP_WIDTH
	xor a ; PAL_BG_GRAY
	rst ByteFill

	; more bushes
	hlbgcoord 0, 14
	ld bc, 4 * TILEMAP_WIDTH
	ld a, PAL_BG_GREEN
	rst ByteFill

	; train window
	hlbgcoord 7, 8
	ld bc, 6
	ld a, PAL_BG_YELLOW
	rst ByteFill

	xor a
	ldh [rVBK], a
	ret

MagnetTrain_Jumptable:
	call StandardStackJumpTable

.Jumptable:
	dw .InitPlayerSpriteAnim
	dw .WaitScene
	dw .MoveTrain1
	dw .WaitScene
	dw .MoveTrain2
	dw .WaitScene
	dw .TrainArrived

.Next:
	ld hl, wJumptableIndex
	inc [hl]
	ret

.InitPlayerSpriteAnim:
	ld hl, wPalFlags
	set USE_DAYTIME_PAL_F, [hl]
	ld d, (8 + 2) * TILE_WIDTH + 5
	ld a, [wMagnetTrainPlayerSpriteInitX]
	ld e, a
	ld a, SPRITE_ANIM_INDEX_MAGNET_TRAIN
	call InitSpriteAnimStruct
	ld hl, SPRITEANIMSTRUCT_TILE_ID
	add hl, bc
	ld [hl], 0
	call .Next
	ld a, 128
	ld [wMagnetTrainWaitCounter], a
	ret

.MoveTrain1:
	ld hl, wMagnetTrainHoldPosition
	ld a, [wMagnetTrainPosition]
	cp [hl]
	jr z, .PrepareToHoldTrain
	ld e, a
	ld a, [wMagnetTrainDirection]
	cpl
	inc a
	add e
	ld [wMagnetTrainPosition], a
	ld hl, wGlobalAnimXOffset
	ld a, [wMagnetTrainDirection]
	add [hl]
	ld [hl], a
	ret

.PrepareToHoldTrain:
	call .Next
	ld a, 128
	ld [wMagnetTrainWaitCounter], a
	ret

.WaitScene:
	ld hl, wMagnetTrainWaitCounter
	ld a, [hl]
	and a
	jr z, .Next
	dec [hl]
	ret

.MoveTrain2:
	ld hl, wMagnetTrainFinalPosition
	ld a, [wMagnetTrainPosition]
	cp [hl]
	jr z, .Next
	ld e, a
	ld a, [wMagnetTrainDirection]
	cpl
	inc a
	ld d, a
	ld a, e
	add d
	add d
	ld [wMagnetTrainPosition], a
	ld hl, wGlobalAnimXOffset
	ld a, [wMagnetTrainDirection]
	ld d, a
	ld a, [hl]
	add d
	add d
	ld [hl], a
	ret

.TrainArrived:
	ld hl, wPalFlags
	res USE_DAYTIME_PAL_F, [hl]
	ld a, $80
	ld [wJumptableIndex], a
	ld de, SFX_TRAIN_ARRIVED
	jmp PlaySFX

MagnetTrain_Jumptable_FirstRunThrough:
	call PlaySpriteAnimations
	call MagnetTrain_Jumptable
	call MagnetTrain_UpdateLYOverrides
	call PushLYOverrides
	call DelayFrame

	ldh a, [rWBK]
	push af
	ld a, BANK(wEnvironment)
	ldh [rWBK], a
	ld a, [wTimeOfDayPal]
	push af
	ld a, [wEnvironment]
	push af

	ld a, [wTimeOfDay]
	maskbits NUM_DAYTIMES
	ld [wTimeOfDayPal], a
	ld a, TOWN
	ld [wEnvironment], a
	ld a, CGB_MAPPALS
	call GetCGBLayout
	call UpdateTimePals

	ldh a, [rBGP]
	ld [wBGP], a
	ldh a, [rOBP0]
	ld [wOBP0], a
	ldh a, [rOBP1]
	ld [wOBP1], a

	pop af
	ld [wEnvironment], a
	pop af
	ld [wTimeOfDayPal], a
	pop af
	ldh [rWBK], a
	ret

MagnetTrainTilemap:
; 20x4 tilemap
INCBIN "gfx/overworld/magnet_train_fg.tilemap"
