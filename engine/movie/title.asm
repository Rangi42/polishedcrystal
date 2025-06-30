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

; Decompress running Suicune gfx
	ld hl, TitleSuicuneGFX
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

; lines 3-4
	hlbgcoord 0, 3
	ld bc, 2 * TILEMAP_WIDTH
	ld a, 2
	rst ByteFill
; line 5
	hlbgcoord 0, 5
	ld bc, TILEMAP_WIDTH
	ld a, 3
	rst ByteFill
; line 6
	hlbgcoord 0, 6
	ld bc, TILEMAP_WIDTH
	ld a, 4
	rst ByteFill
; line 7
	hlbgcoord 0, 7
	ld bc, TILEMAP_WIDTH
	ld a, 5
	rst ByteFill
; lines 8-9
	hlbgcoord 0, 8
	ld bc, 2 * TILEMAP_WIDTH
	ld a, 6
	rst ByteFill

; 'CRYSTAL VERSION'
	hlbgcoord 5, 9
	ld bc, NAME_LENGTH ; length of version text
	ld a, 1
	rst ByteFill

; Suicune gfx
	hlbgcoord 0, 12
	ld bc, 6 * TILEMAP_WIDTH ; the rest of the screen
	ld a, 8
	rst ByteFill

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
	ld a, " "
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

; Initialize running Suicune?
	ld d, $0
	call LoadSuicuneFrame

; Initialize background crystal
	call InitializeBackground

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
	ld [wBGPals1 palette 0 + 2], a

; Play starting sound effect
	call SFXChannelsOff
	ld de, SFX_TITLE_SCREEN_ENTRANCE
	jmp PlaySFX

SuicuneFrameIterator:
	ld hl, wBGPals1 palette 0 + 2
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
	ld e, a
	ld d, 0
	ld hl, .Frames
	add hl, de
	ld d, [hl]
	xor a
	ldh [hBGMapMode], a
	call LoadSuicuneFrame
	ld a, $1
	ldh [hBGMapMode], a
	ldh [hBGMapHalf], a
	ret

.Frames:
	db $80 ; vTiles4 tile $00
	db $88 ; vTiles4 tile $08
	db $00 ; vTiles5 tile $00
	db $08 ; vTiles5 tile $08

LoadSuicuneFrame:
	hlcoord 6, 12
	ld b, 6
.bgrows
	ld c, 8
.col
	ld a, d
	ld [hli], a
	inc d
	dec c
	jr nz, .col
; "add hl, SCREEN_WIDTH - 8"
; 6 bytes, 12 cycles
	push de
	ld de, SCREEN_WIDTH - 8
	add hl, de
	pop de
;; 8 bytes, 8 cycles
;	ld a, SCREEN_WIDTH - 8
;	add l
;	ld l, a
;	ld a, 0
;	adc h
;	ld h, a
	ld a, 8
	add d
	ld d, a
	dec b
	jr nz, .bgrows
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

InitializeBackground:
	ld hl, wShadowOAM
	lb de, -$22, $0
	ld c, 5
.loop
	push bc
	call .InitColumn
	pop bc
	ld a, $10
	add d
	ld d, a
	dec c
	jr nz, .loop
	ret

.InitColumn:
	lb bc, $40, $6
.loop2
	ld a, d
	ld [hli], a
	ld a, b
	ld [hli], a
	add $8
	ld b, a
	ld a, e
	ld [hli], a
	inc e
	inc e
	ld a, $80
	ld [hli], a
	dec c
	jr nz, .loop2
	ret

AnimateTitleCrystal:
; Move the title screen crystal downward until it's fully visible

; Stop at y=6
; y is really from the bottom of the sprite, which is two tiles high
	ld hl, wShadowOAM
	ld a, [hl]
	cp 6 + $10
	ret z

; Move all 30 parts of the crystal down by 2
	ld c, 30
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

TitleSuicuneGFX:
INCBIN "gfx/title/suicune.2bpp.lz"

TitleLogoGFX:
INCBIN "gfx/title/logo_version.2bpp.lz"

TitleCrystalGFX:
INCBIN "gfx/title/crystal.2bpp.lz"

TitleScreenPalettes:
INCLUDE "gfx/title/title.pal"
