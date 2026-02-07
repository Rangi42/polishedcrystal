_TitleScreen:

	call ClearBGPalettes
	call ClearSprites
	call ClearTileMap

; Turn BG Map update off
	xor a
	ldh [hBGMapMode], a

; Reset timing variables
	ld hl, wJumptableIndex
	ld [hli], a ; wJumptableIndex
	ld [hli], a ; wIntroSceneFrameCounter
	ld [hli], a ; wTitleScreenTimer
	ld [hl], a  ; wTitleScreenTimer+1

; Turn LCD off
	call DisableLCD

; VRAM bank 1
	ld a, 1
	ldh [rVBK], a

; Decompress running Suicune and floating Unown gfx
	ld hl, TitleSuicuneUnownsGFX0
	ld de, vTiles2
	call Decompress
	ld hl, TitleSuicuneUnownsGFX1
	ld de, vTiles1
	call Decompress

; Clear screen palettes
	hlbgcoord 0, 0
	ld bc, SCREEN_WIDTH * TILEMAP_WIDTH
	xor a
	rst ByteFill

; Fill tile palettes:

; BG Map 1:

; line 0 (copyright)
	hlbgcoord 0, 0, vBGMap1
	ld bc, TILEMAP_WIDTH
	ld a, 7 ; palette
	rst ByteFill

; BG Map 0:

; Apply logo gradient:

; lines 3-6
	hlbgcoord 0, 3
	ld bc, 4 * TILEMAP_WIDTH
	ld a, 2
	rst ByteFill
; line 7-9
	hlbgcoord 0, 7
	ld bc, 3 * TILEMAP_WIDTH
	ld a, 3
	rst ByteFill

; 'CRYSTAL VERSION'
	hlbgcoord 5, 9
	ld bc, NAME_LENGTH ; length of version text
	ld a, 1
	rst ByteFill

; Suicune and Unown gfx
	hlbgcoord 1, 11
	lb bc, 7, 18
	ld a, 0 | BG_BANK1
	call DrawTitleBGBox

; Suicune palette
	hlbgcoord 6, 12
	lb bc, 6, 8
	ld a, 4 | BG_BANK1
	call DrawTitleBGBox

; Back to VRAM bank 0
	xor a
	ldh [rVBK], a

; Decompress logo
	ld hl, TitleLogoGFX
	ld de, vTiles1
	call Decompress

; Decompress background crystal
	ld hl, TitleCrystalGFX
	ld de, vTiles0
	call Decompress

; Clear screen tiles
	hlbgcoord 0, 0
	ld bc, 64 * TILEMAP_WIDTH
	ld a, ' '
	rst ByteFill

; Draw Pokemon logo
	hlcoord 0, 3
	lb bc, 7, SCREEN_WIDTH
	lb de, $80, SCREEN_WIDTH
	call DrawTitleGraphic

; Draw copyright text
	hlbgcoord 4, 0, vBGMap1
	lb bc, 1, 13
	lb de, $0c, 0
	call DrawTitleGraphic

IF DEF(FAITHFUL)
	hlbgcoord 17, 0, vBGMap1
	lb bc, 1, 1
	lb de, $19, 0
	call DrawTitleGraphic
endc

; Initialize background crystal
	call InitializeCrystalSprites

; Save WRAM bank
	ldh a, [rWBK]
	push af
; WRAM bank 5
	ld a, 5
	ldh [rWBK], a

; Update palette colors
	ld hl, TitleScreenPalettes
	ld de, wBGPals1
	ld bc, 16 palettes
	rst CopyBytes

	ld hl, TitleScreenPalettes
	ld de, wBGPals2
	ld bc, 16 palettes
	rst CopyBytes

; Restore WRAM bank
	pop af
	ldh [rWBK], a

; LY/SCX trickery starts here

	push af
	ld a, BANK(wLYOverrides)
	ldh [rWBK], a

; Make sure the LYOverrides buffer is empty
	ld hl, wLYOverrides
	xor a
	ld bc, wLYOverridesEnd - wLYOverrides
	rst ByteFill

; Let LCD Stat know we're messing around with SCX
	ld hl, rIE
	set B_IE_STAT, [hl]
	ld a, rSCX - rJOYP
	ldh [hLCDCPointer], a

	pop af
	ldh [rWBK], a

; Reset audio
	call ChannelsOff
	call EnableLCD

	ldh a, [rLCDC]
	set B_LCDC_OBJ_SIZE, a
	ldh [rLCDC], a

	ld a, +112
	ldh [hSCX], a
	ld a, 8
	ldh [hSCY], a
	ld a, 7
	ldh [hWX], a
	ld a, -112
	ldh [hWY], a

	ld a, $1
	ldh [hCGBPalUpdate], a

; Update BG Map 0 (bank 0)
	ldh [hBGMapMode], a

	xor a
	ld [wSuicuneFrame], a

; Play starting sound effect
	call SFXChannelsOff
	ld de, SFX_TITLE_SCREEN_ENTRANCE
	jmp PlaySFX

SuicuneFrameIterator:
	ld hl, wSuicuneFrame
	ld a, [hl]
	ld c, a
	inc [hl]

; Only do this once every eight frames
	and (1 << 3) - 1
	ret nz

	ld a, c
	and 3 << 3
	add a
	swap a
	ld hl, SuicuneUnownsTilemaps
	ld bc, 18 * 7
	rst AddNTimes

	xor a
	ldh [hBGMapMode], a

	decoord 1, 11
	ld b, 7
.bgrows
	ld c, 18
.col
	ld a, [hli]
	ld [de], a
	inc de
	dec c
	jr nz, .col
rept SCREEN_WIDTH - 18
	inc de
endr
	dec b
	jr nz, .bgrows

	ld a, $1
	ldh [hBGMapMode], a
	ldh [hBGMapHalf], a
	ret

DrawTitleGraphic:
; input:
;   hl: draw location
;   b: height
;   c: width
;   d: tile to start drawing from
;   e: number of tiles to advance for each bgrows
.bgrows
	push de
	push bc
	push hl
.col
	ld a, d
	ld [hli], a
	inc d
	dec c
	jr nz, .col
	pop hl
	ld bc, SCREEN_WIDTH
	add hl, bc
	pop bc
	pop de
	ld a, e
	add d
	ld d, a
	dec b
	jr nz, .bgrows
	ret

DrawTitleBGBox:
; input:
;   hl: draw location
;   b: height
;   c: width
;   a: tile or attribute value
.row
	push bc
	push hl
.col
	ld [hli], a
	dec c
	jr nz, .col
	pop hl
	ld bc, TILEMAP_WIDTH
	add hl, bc
	pop bc
	dec b
	jr nz, .row
	ret

InitializeCrystalSprites:
	ld hl, wShadowOAM
	lb de, -$22, $00 ; initial top-left Y coord, top-left tile ID
	ld c, 5 ; column height
.loop
	push bc
	call .InitRow
	pop bc
	ld a, $10 ; increment Y coord
	add d
	ld d, a
	dec c
	jr nz, .loop

	; set palettes for crystal sprites besides #0
	ld a, 0 | OAM_PRIO
	ld [wShadowOAMSprite00Attributes], a
	ld [wShadowOAMSprite01Attributes], a
	ld [wShadowOAMSprite02Attributes], a
	ld [wShadowOAMSprite06Attributes], a
	ld [wShadowOAMSprite21Attributes], a
	ld [wShadowOAMSprite24Attributes], a
	ld [wShadowOAMSprite25Attributes], a
	ld [wShadowOAMSprite26Attributes], a
	ld a, 2 | OAM_PRIO
	ld [wShadowOAMSprite07Attributes], a
	ld [wShadowOAMSprite19Attributes], a
	ld [wShadowOAMSprite20Attributes], a
	inc a ; 3 | OAM_PRIO
	ld [wShadowOAMSprite08Attributes], a

	; create overlapping sprites
	ld hl, .OverlappingSprites
	ld de, wShadowOAMSprite30
	ld bc, 6 * OBJ_SIZE
	rst CopyBytes
	ret

.InitRow:
	lb bc, $40, 6 ; left X coord, row width
.loop2
	ld a, d
	ld [hli], a ; Y coord
	ld a, b
	ld [hli], a ; X coord
	add 8 ; increment X coord
	ld b, a
	ld a, e
	ld [hli], a ; tile ID
	inc e ; increment tile ID
	inc e
	ld a, 1 | OAM_PRIO
	ld [hli], a ; attribute
	dec c
	jr nz, .loop2
	ret

.OverlappingSprites:
	db -$12, $40, $3c, 1 | OAM_PRIO
	db -$12, $48, $3e, 4 | OAM_PRIO
	db  $1e, $40, $40, 1 | OAM_PRIO
	db  $1d, $48, $42, 1 | OAM_PRIO
	db  $1e, $50, $44, 1 | OAM_PRIO
	db  $0e, $60, $46, 0 | OAM_PRIO

AnimateTitleCrystal:
; Move the title screen crystal downward until it's fully visible

; Stop at y=6
; y is really from the bottom of the sprite, which is two tiles high
	ld hl, wShadowOAM
	ld a, [hl]
	cp 6 + $10
	ret z

; Move all 36 parts of the crystal down by 2
	ld c, 36
.loop
	ld a, [hl]
	add 2
	ld [hli], a
	inc hl
	inc hl
	inc hl
	dec c
	jr nz, .loop

	ret

SuicuneUnownsTilemaps:
	table_width 18 * 7
INCBIN "gfx/title/suicune_unowns.tilemap"
	assert_table_length 4

TitleSuicuneUnownsGFX0:
INCBIN "gfx/title/suicune_unowns.2bpp.vram0p.lz"

TitleSuicuneUnownsGFX1:
INCBIN "gfx/title/suicune_unowns.2bpp.vram1p.lz"

TitleLogoGFX:
INCBIN "gfx/title/logo_bg.2bpp.lz"

TitleCrystalGFX:
INCBIN "gfx/title/crystal.2bpp.lz"

TitleScreenPalettes:
INCLUDE "gfx/title/title.pal"
