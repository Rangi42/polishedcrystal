Special_MagnetTrain:
	ldh a, [hScriptVar]
	and a
	jr nz, .ToGoldenrod
	ld a, 1 ; forwards
	lb bc,  $40,  $60
	lb de, ((11 * 8) - (11 * 8 + 4)), -$60
	jr .continue

.ToGoldenrod:
	ld a, -1 ; backwards
	lb bc, -$40, -$60
	lb de, ((11 * 8) + (11 * 8 + 4)), $60

.continue
	ld h, a
	ldh a, [rSVBK]
	push af
	ld a, $5
	ldh [rSVBK], a

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

	ld hl, rIE
	set LCD_STAT, [hl]
	ldh a, [hSCX]
	push af
	ldh a, [hSCY]
	push af
	call MagntTrain_LoadGFX_PlayMusic
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
	ld hl, rIE
	res LCD_STAT, [hl]
	xor a
	ldh [hBGMapMode], a
	pop af
	ldh [rSVBK], a
	ret

MagnetTrain_UpdateLYOverrides:
	ld hl, wLYOverridesBackup
	ld c, $2f
	ld a, [wMagnetTrainOffset]
	add a
	ldh [hSCX], a
	call .loadloop
	ld c, $30
	ld a, [wMagnetTrainPosition]
	call .loadloop
	ld c, $31
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

MagntTrain_LoadGFX_PlayMusic:
	call ClearBGPalettes
	call ClearSprites
	call DisableLCD
	call ClearSpriteAnims
	call SetMagnetTrainPals
	call DrawMagnetTrain
	ld a, $90
	ldh [hWY], a
	call EnableLCD
	xor a
	ldh [hBGMapMode], a
	ldh [hSCX], a
	ldh [hSCY], a
	ldh a, [rSVBK]
	push af
	ld a, $1
	ldh [rSVBK], a
	farcall GetPlayerIcon
	pop af
	ldh [rSVBK], a
	ld hl, vTiles0
	ld c, 4
	push bc
	push de
	call Request2bppInWRA6
	pop de
	pop bc
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
	ld [hli], a
	ld a, [wMagnetTrainInitPosition]
	ld [hli], a
	ld [hli], a
	ld [hli], a
	ld de, MUSIC_MAGNET_TRAIN
	jp PlayMusic2

DrawMagnetTrain:
	hlbgcoord 0, 0
	xor a
.loop
	call GetMagnetTrainBGTiles
	ld b, 32 / 2
	call .FillAlt
	inc a
	cp $12
	jr c, .loop
	hlbgcoord 0, 6
	ld de, MagnetTrainTilemap1
	ld c, 20
	call .FillLine
	hlbgcoord 0, 7
	ld de, MagnetTrainTilemap2
	ld c, 20
	call .FillLine
	hlbgcoord 0, 8
	ld de, MagnetTrainTilemap3
	ld c, 20
	call .FillLine
	hlbgcoord 0, 9
	ld de, MagnetTrainTilemap4
	ld c, 20
	; fallthrough

.FillLine:
	ld a, [de]
	inc de
	ld [hli], a
	dec c
	jr nz, .FillLine
	ret

.FillAlt:
	ld [hl], e
	inc hl
	ld [hl], d
	inc hl
	dec b
	jr nz, .FillAlt
	ret

GetMagnetTrainBGTiles:
	push hl
	ld e, a
	ld d, 0
	ld hl, MagnetTrainBGTiles
	add hl, de
	add hl, de
	ld e, [hl]
	inc hl
	ld d, [hl]
	pop hl
	ret

MagnetTrainBGTiles:
; Alternating tiles for each line
; of the Magnet Train tilemap.
	db $4a, $4b ; tree
	db $5a, $5b ; tree
	db $4a, $4b ; tree
	db $5a, $5b ; tree
	db $0e, $0e ; fence
	db $3f, $3f ; fence
	db $36, $36 ; track
	db $00, $00 ; track
	db $3a, $3a ; track
	db $3a, $3a ; track
	db $0f, $0f ; track
	db $1f, $1f ; track
	db $2f, $2f ; fence
	db $3f, $3f ; fence
	db $4a, $4b ; tree
	db $5a, $5b ; tree
	db $4a, $4b ; tree
	db $5a, $5b ; tree

MagnetTrain_InitLYOverrides:
	ld hl, wLYOverrides
	ld bc, wLYOverridesEnd - wLYOverrides
	ld a, [wMagnetTrainInitPosition]
	rst ByteFill
	ld hl, wLYOverridesBackup
	ld bc, wLYOverridesBackupEnd - wLYOverridesBackup
	ld a, [wMagnetTrainInitPosition]
	rst ByteFill
	ld a, $43
	ldh [hLCDCPointer], a
	ret

SetMagnetTrainPals:
	ld a, $1
	ldh [rVBK], a

	; trees
	hlbgcoord 0, 0
	ld bc, 4 * BG_MAP_WIDTH
	ld a, PAL_BG_GREEN
	rst ByteFill

	; train
	hlbgcoord 0, 4
	ld bc, 10 * BG_MAP_WIDTH
	xor a ; PAL_BG_GRAY
	rst ByteFill

	; more trees
	hlbgcoord 0, 14
	ld bc, 4 * BG_MAP_WIDTH
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
	ld d, 10 * 8 + 5
	ld a, [wMagnetTrainPlayerSpriteInitX]
	ld e, a
	ld b, SPRITE_ANIM_INDEX_MAGNET_TRAIN_RED
	ldh a, [rSVBK]
	push af
	ld a, $1
	ldh [rSVBK], a
	ld a, [wPlayerGender]
	bit 0, a
	jr z, .got_gender
	ld b, SPRITE_ANIM_INDEX_MAGNET_TRAIN_BLUE

.got_gender
	pop af
	ldh [rSVBK], a
	ld a, b
	call _InitSpriteAnimStruct
	ld hl, SPRITEANIMSTRUCT_TILE_ID
	add hl, bc
	ld [hl], $0
	call .Next
	ld a, $80
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
	ld a, $80
	ld [wMagnetTrainWaitCounter], a
	ret

.WaitScene:
	ld hl, wMagnetTrainWaitCounter
	ld a, [hl]
	and a
	jp z, .Next
	dec [hl]
	ret

.MoveTrain2:
	ld hl, wMagnetTrainFinalPosition
	ld a, [wMagnetTrainPosition]
	cp [hl]
	jp z, .Next
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
	ld a, $80
	ld [wJumptableIndex], a
	ld de, SFX_TRAIN_ARRIVED
	jp PlaySFX

MagnetTrain_Jumptable_FirstRunThrough:
	call PlaySpriteAnimations
	call MagnetTrain_Jumptable
	call MagnetTrain_UpdateLYOverrides
	call PushLYOverrides
	call DelayFrame
	ldh a, [rSVBK]
	push af
	ld a, $1
	ldh [rSVBK], a
	ld a, [wTimeOfDayPal]
	push af
	ld a, [wEnvironment]
	push af
	ld a, [wTimeOfDay]
	and $3
	ld [wTimeOfDayPal], a
	ld a, $1
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
	ldh [rSVBK], a
	ret

MagnetTrainTilemap1:
	db $36, $06, $07, $0b, $0b, $0b, $0a, $0b, $0b, $0b
	db $0b, $0b, $0b, $0a, $0b, $0b, $0b, $0c, $0d, $36
MagnetTrainTilemap2:
	db $15, $16, $17, $1b, $1b, $1b, $1a, $1b, $1b, $1b
	db $1b, $1b, $1b, $1a, $1b, $1b, $1b, $1c, $1d, $1e
MagnetTrainTilemap3:
	db $25, $26, $27, $28, $08, $09, $2a, $29, $29, $29
	db $29, $29, $29, $2a, $08, $09, $2b, $2c, $2d, $2e
MagnetTrainTilemap4:
	db $35, $36, $37, $36, $18, $19, $37, $36, $36, $36
	db $36, $36, $36, $37, $18, $19, $36, $37, $36, $3e
