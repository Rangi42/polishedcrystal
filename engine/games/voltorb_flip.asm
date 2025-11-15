; RAM:
; wVoltorbFlipCardProperties (VOLTORB_FLIP_CARD_COUNT bytes)
; wVoltorbFlipState
; wVoltorbFlipLevel
; wVoltorbFlipCursorX / wVoltorbFlipCursorY
; wVoltorbFlipLastX / wVoltorbFlipLastY
; wVoltorbFlipCardsFlipped
; wVoltorbFlipUnflippedMultipliers
; wVoltorbFlipNumberTotals / wVoltorbFlipVoltorbTotals
; wVoltorbFlipCoinsThisGame

DEF VOLTORB_FLIP_BOARD_SIZE     EQU 5
DEF VOLTORB_FLIP_CARD_COUNT     EQU VOLTORB_FLIP_BOARD_SIZE * VOLTORB_FLIP_BOARD_SIZE
DEF VOLTORB_FLIP_ROWCOL_COUNT   EQU VOLTORB_FLIP_BOARD_SIZE * 2
DEF VOLTORB_FLIP_BASE_VOLTORB   EQU 5
DEF VOLTORB_FLIP_MAX_VOLTORB    EQU 10
DEF VOLTORB_FLIP_LEVEL_LIMIT    EQU 8
DEF VOLTORB_FLIP_LEVEL_CAP_GUARD EQU VOLTORB_FLIP_LEVEL_LIMIT + 1
DEF VOLTORB_FLIP_HIGH_LEVEL_THRESHOLD EQU 5
DEF VOLTORB_FLIP_LOW_LEVEL_BASE EQU 7
DEF VOLTORB_FLIP_HIGH_LEVEL_BASE EQU 12
DEF VOLTORB_FLIP_MAX_INDEX      EQU VOLTORB_FLIP_BOARD_SIZE - 1
DEF VOLTORB_FLIP_LEVEL_HEADER_TILE_BASE EQU $29
DEF VOLTORB_FLIP_NUMBER2_TILE_BASE  EQU $66
DEF VOLTORB_FLIP_COUNTER_BORDER_TILE EQU $17
DEF VOLTORB_FLIP_NUMBER1_TILE_BASE EQU $e0
DEF VOLTORB_FLIP_RANDOM_MASK    EQU $f
DEF VOLTORB_FLIP_TILEMAP_ROW_BACK_OFFSET EQU $ffd9
DEF VOLTORB_FLIP_HIGHLIGHT_ATTR_OFFSET EQU $90f
DEF VOLTORB_FLIP_HIGHLIGHT_ROW_OFFSET EQU $11
DEF VOLTORB_FLIP_VRAM_ROW_STRIDE EQU $1d
DEF VOLTORB_FLIP_VRAM_ROW_OFFSET EQU $11
DEF VOLTORB_FLIP_VRAM_FLIP_STRIDE EQU $3C
DEF VOLTORB_FLIP_ANIM_DIRECTION_DELTA EQU $06fd
DEF VOLTORB_FLIP_ANIM_END_SENTINEL EQU $fd
DEF VOLTORB_FLIP_DIRECTION_MASK EQU $f0
DEF VOLTORB_FLIP_BG_MAP_WIDTH   EQU $18
DEF VOLTORB_FLIP_COUNTER_BOTTOM_OFFSET EQU $0011
DEF VOLTORB_FLIP_REFRESH_WIDTH   EQU VOLTORB_FLIP_BOARD_SIZE + 1
DEF VOLTORB_FLIP_REFRESH_HEIGHT  EQU VOLTORB_FLIP_BOARD_SIZE + 2
DEF VOLTORB_FLIP_CARD_TILE_SIZE  EQU 3
DEF VOLTORB_FLIP_INTENSE_DELAY_FRAMES EQU 120 ; 2 seconds
DEF VOLTORB_FLIP_LEVEL_CLEAR_DELAY_FRAMES EQU 60 ; 1 second
DEF VOLTORB_FLIP_GAME_OVER_DELAY_FRAMES EQU 240 ; 4 seconds
DEF VOLTORB_FLIP_TILE_UL_BLANK EQU $00
DEF VOLTORB_FLIP_TILE_UM_BLANK EQU $01
DEF VOLTORB_FLIP_TILE_UR_BLANK EQU $02
DEF VOLTORB_FLIP_TILE_ML_BLANK EQU $10
DEF VOLTORB_FLIP_TILE_MM_BLANK EQU $11
DEF VOLTORB_FLIP_TILE_MR_BLANK EQU $12
DEF VOLTORB_FLIP_TILE_LL_BLANK EQU $20
DEF VOLTORB_FLIP_TILE_LM_BLANK EQU $21
DEF VOLTORB_FLIP_TILE_LR_BLANK EQU $22
DEF VOLTORB_FLIP_TILE_UL_MARK EQU $06
DEF VOLTORB_FLIP_TILE_UR_MARK EQU $08
DEF VOLTORB_FLIP_TILE_LL_MARK EQU $16
DEF VOLTORB_FLIP_TILE_LR_MARK EQU $18
DEF VOLTORB_FLIP_TILE_VOLTORB_TOP_BASE    EQU $03
DEF VOLTORB_FLIP_TILE_VOLTORB_MIDDLE_BASE EQU $13
DEF VOLTORB_FLIP_TILE_VOLTORB_BOTTOM_BASE EQU $23
DEF VOLTORB_FLIP_TILE_CARD_NUMBER_BASE EQU $26
DEF VOLTORB_FLIP_TILE_FLIP_TOP_BASE EQU $30
DEF VOLTORB_FLIP_TILE_FLIP_MID_BASE EQU $40
DEF VOLTORB_FLIP_TILE_FLIP_BOTTOM_BASE EQU $50
DEF VOLTORB_FLIP_COUNTER_ATTR_OFFSET EQU VOLTORB_FLIP_NUMBER1_TILE_BASE - VOLTORB_FLIP_NUMBER2_TILE_BASE
DEF VOLTORB_FLIP_COUNTER_PRINT_BC EQU $0102
DEF VOLTORB_FLIP_COIN_PRINT_BC EQU $0204

; wVoltorbFlipCardProperties
	const_def
	const_skip                                ; 0
	const_skip                                ; 1
	shift_const VOLTORB_FLIP_CARD_FLIPPED     ; 2
	shift_const VOLTORB_FLIP_CARD_HIGHLIGHTED ; 3
	shift_const VOLTORB_FLIP_CARD_MARKED3     ; 4
	shift_const VOLTORB_FLIP_CARD_MARKED2     ; 5
	shift_const VOLTORB_FLIP_CARD_MARKED1     ; 6
	shift_const VOLTORB_FLIP_CARD_MARKED0     ; 7

DEF VOLTORB_FLIP_CARD_NUMBER_MASK EQU %00000011

; Card Properties (Bits):
; 7-marked 0
; 6-marked 1
; 5-marked 2
; 4-marked 3
; 3-highlighted
; 2-Card Flipped
; 1,0-Card number

; States:
; sounds:
; SFX_READ_TEXT move cursor
; SFX_QUIT_SLOTS game over
; SFX_INTRO_SUICUNE_1 flip card
; SFX_CHOOSE_A_CARD are you sure?
; SFX_DEX_FANFARE_LESS_THAN_20 quit
; SFX_3RD_PLACE level clear
; SFX_TRANSACTION coin
; SFX_EGG_BOMB boom!

VoltorbFlipGFX:
INCBIN "gfx/voltorb_flip/voltorb_flip.2bpp"

VoltorbFlipPalette:
	RGB 31,25,01, 31,31,31, 04,22,09, 00,00,00
	RGB 31,25,01, 31,15,04, 04,22,09, 00,00,00
	RGB 31,00,00, 31,31,31, 04,22,09, 00,00,00
	RGB 31,00,00, 31,31,31, 31,25,01, 00,00,00
	RGB 31,00,00, 31,31,31, 00,20,29, 00,00,00
	RGB 31,00,00, 31,31,31, 20,09,20, 00,00,00
	RGB 31,00,00, 31,31,31, 09,27,14, 00,00,00
	RGB 31,00,00, 31,15,04, 09,27,14, 00,00,00

VoltorbFlipPaletteBlank:
	RGB 31,31,31, 31,31,31, 31,31,31, 31,31,31
	RGB 31,31,31, 31,31,31, 31,31,31, 31,31,31
	RGB 31,31,31, 31,31,31, 31,31,31, 31,31,31
	RGB 31,31,31, 31,31,31, 31,31,31, 31,31,31
	RGB 31,31,31, 31,31,31, 31,31,31, 31,31,31
	RGB 31,31,31, 31,31,31, 31,31,31, 31,31,31
	RGB 31,31,31, 31,31,31, 31,31,31, 31,31,31
	RGB 31,31,31, 31,31,31, 31,31,31, 31,31,31

_VoltorbFlip::; this is where the magic happens
	;ld a, IE_VBLANK | IE_TIMER | IE_SERIAL
	;ldh [rIE], a
	call VFLoadGFX
	call VFLoadPalette
	call VFInitRAM
	call VFInitMap
	ld hl, rLCDC
	set B_LCDC_ENABLE, [hl]
	xor a
	ldh [hBGMapMode], a
	ld a, 1
	ldh [hOAMUpdate], a ; disable sprite update
	ld [wVoltorbFlipLevel], a
	call VFInitLevel
	jp VFMainLoop

VFInitLevel:
	ld hl, wVoltorbFlipNumberTotals
	ld b, wVoltorbFlipDataEnd - wVoltorbFlipNumberTotals
	xor a
	ld [wVoltorbFlipCardsFlipped], a
	ld [wVoltorbFlipCoinsThisGame], a
	ld [wVoltorbFlipCoinsThisGame + 1], a
.clearrowcol
	ld [hli], a
	dec b
	jr nz, .clearrowcol
	ld a, 1
	ld hl, wVoltorbFlipCardProperties ; card start
	ld b, VOLTORB_FLIP_CARD_COUNT
.set1
	ld [hli], a ; starts off every card as a 1
	dec b
	jr nz, .set1
	ld a, [wVoltorbFlipLevel] ; level
	cp VOLTORB_FLIP_HIGH_LEVEL_THRESHOLD
	jr nc, .highlevel
	add a
	add VOLTORB_FLIP_LOW_LEVEL_BASE ; calculate the "base"
	ld c, a
	jr .retry23
	.highlevel ; base is calculated differently starting at level VOLTORB_FLIP_HIGH_LEVEL_THRESHOLD
	add VOLTORB_FLIP_HIGH_LEVEL_BASE
	ld c, a
.retry23
	ld hl, wVoltorbFlipCardProperties ; card start
	ld b, VOLTORB_FLIP_CARD_COUNT
.loop23
	call Random
	ldh a, [hRandomSub]
	xor VOLTORB_FLIP_RANDOM_MASK
	jr z, .generate2
	dec a
	jr nz, .continue23
.generate3
	ld a, [hl]
	dec a
	jr nz, .continue23 ; only write it if it's a 1
	ld [hl], 3
	ld a, c
	sub 3
	ld c, a
	jr c, .done
	jr z, .done
	jr .continue23
.generate2
	ld a, [hl]
	dec a
	jr nz, .continue23 ; only write it if it's a 1
	ld [hl], 2
	ld a, c
	sub 2
	ld c, a
	jr c, .done
	jr z, .done
; fallthrough
.continue23
	inc hl
	dec b
	jr nz, .loop23
	jr .retry23
.done
	ld a, [wVoltorbFlipLevel]
	add VOLTORB_FLIP_BASE_VOLTORB ; number of voltorb
	cp VOLTORB_FLIP_MAX_VOLTORB
	ld c, a
	jr nc, .retryv
	ld c, VOLTORB_FLIP_MAX_VOLTORB ; max of 10 voltorb
.retryv
	ld hl, wVoltorbFlipCardProperties ; card start
	ld b, VOLTORB_FLIP_CARD_COUNT
.loopv
	call Random
	ldh a, [hRandomSub]
	xor VOLTORB_FLIP_RANDOM_MASK
	jr z, .generatev
	dec a
	jr nz, .continuev
.generatev
	ld a, [hl]
	dec a
	jr nz, .continuev ; only write it if it's a 1
	xor a
	ld [hl], a
	dec c
	jr z, .donev
; fallthrough
.continuev
	inc hl
	dec b
	jr nz, .loopv
	jr .retryv
.donev
	ld de, wVoltorbFlipCardProperties
	ld b, VOLTORB_FLIP_BOARD_SIZE
	ld hl, wVoltorbFlipNumberTotals + VOLTORB_FLIP_BOARD_SIZE
.addrowstart
	ld c, VOLTORB_FLIP_BOARD_SIZE
.addrow
	ld a, [de]
	and VOLTORB_FLIP_CARD_NUMBER_MASK
	push bc
	ld b, a
	ld a, [hl]
	add b
	ld [hl], a
	pop bc
	inc de
	dec c
	jr nz, .addrow
	inc hl
	dec b
	jr nz, .addrowstart
	ld de, wVoltorbFlipCardProperties
	ld b, VOLTORB_FLIP_BOARD_SIZE
	ld hl, wVoltorbFlipNumberTotals
.addcolstart
	ld c, VOLTORB_FLIP_BOARD_SIZE
.addcol
	ld a, [de]
	and VOLTORB_FLIP_CARD_NUMBER_MASK
	push bc
	ld b, a
	ld a, [hl]
	add b
	ld [hli], a
	pop bc
	inc de
	dec c
	jr nz, .addcol
	ld hl, wVoltorbFlipNumberTotals
	dec b
	jr nz, .addcolstart
	ld de, wVoltorbFlipCardProperties
	ld b, VOLTORB_FLIP_BOARD_SIZE
	ld hl, wVoltorbFlipVoltorbTotals + VOLTORB_FLIP_BOARD_SIZE
.voltrowstart
	ld c, VOLTORB_FLIP_BOARD_SIZE
.voltrow
	ld a, [de]
	and VOLTORB_FLIP_CARD_NUMBER_MASK
	jr nz, .rowskip
	inc [hl]
.rowskip
	inc de
	dec c
	jr nz, .voltrow
	inc hl
	dec b
	jr nz, .voltrowstart
	ld de, wVoltorbFlipCardProperties
	ld b, VOLTORB_FLIP_BOARD_SIZE
	ld hl, wVoltorbFlipVoltorbTotals
.voltcolstart
	ld c, VOLTORB_FLIP_BOARD_SIZE
.voltcol
	ld a, [de]
	and VOLTORB_FLIP_CARD_NUMBER_MASK
	jr nz, .colskip
	inc [hl]
.colskip
	inc hl
	inc de
	dec c
	jr nz, .voltcol
	ld hl, wVoltorbFlipVoltorbTotals
	dec b
	jr nz, .voltcolstart
	ld hl, rSTAT
	ld a, 1
.wait
	ld a, [hl]
	and 3
	dec a
	jr nz, .wait
	dec hl
	res 7, [hl]
	call VFInitMap
	ld hl, rLCDC
	set B_LCDC_ENABLE, [hl]
	ret

VFMainLoop:
	call VFRefreshMap
	call VFInput
	jr VFMainLoop
	;ld a, IE_VBLANK | IE_STAT | IE_TIMER | IE_SERIAL
	;ldh [rIE], a
	ret

VFInput:
	ld hl, wVoltorbFlipCursorX
	ld a, [hli]
	ld b, a
	ld a, [hli]
	ld c, a
	di
	push hl
	call VFRefreshScreen
	pop hl
	ld a, [hli]
	ld b, a
	ld a, [hli]
	ld c, a
	call VFRefreshScreen
	ei
	ld hl, wVoltorbFlipCardProperties
	ld a, [wVoltorbFlipCursorX]
	ld b, a
	ld a, [wVoltorbFlipCursorY]
	ld c, a
	add a
	add a
	add c
	add b
	ld e, a
	ld d, 0
	add hl, de
	ld d, h
	ld e, l
	ldh a, [hJoypadDown]
	bit B_PAD_B, a
	jp nz, .bbutton
	ldh a, [hJoypadPressed]
	and a
	ret z
	bit B_PAD_A, a
	jr nz, .abutton
	bit B_PAD_SELECT, a
	jp nz, VFKeepCoins
	bit B_PAD_START, a
	jp nz, VFExit
	push af
	ld a, [wVoltorbFlipCursorX]
	ld [wVoltorbFlipLastX], a
	ld a, [wVoltorbFlipCursorY]
	ld [wVoltorbFlipLastY], a
	push de
	ld de, SFX_READ_TEXT
	call PlaySFX
	pop de
	pop af
	bit B_PAD_RIGHT, a
	jp nz, .rightbutton
	bit B_PAD_LEFT, a
	jp nz, .leftbutton
	bit B_PAD_UP, a
	jp nz, .upbutton
	bit B_PAD_DOWN, a
	jp nz, .downbutton

	ret

.abutton
	ld a, [de]
	bit VOLTORB_FLIP_CARD_FLIPPED_F, a
	ret nz
	set VOLTORB_FLIP_CARD_FLIPPED_F, a
	ld [de], a
	and VOLTORB_FLIP_CARD_NUMBER_MASK
	dec a
	jr z, .skipintense
	ld a, [wVoltorbFlipUnflippedMultipliers]
	dec a
	jr nz, .skipintense
	call Random
	ldh a, [hRandomSub]
	and 3
	jr nz, .skipintense
	push de
	ld de, SFX_CHOOSE_A_CARD
	call WaitPlaySFX
	pop de
	push bc
	ld c, VOLTORB_FLIP_INTENSE_DELAY_FRAMES
	call DelayFrames
	pop bc
.skipintense
	call VFFlipAnimation
	ld a, [de]
	and VOLTORB_FLIP_CARD_NUMBER_MASK
	jp z, VFBoom
	call VFMultiplyCoins
	ld hl, wVoltorbFlipCardsFlipped
	ld a, [wVoltorbFlipLevel]
	cp [hl]
	jr z, .skipcardinc
	inc [hl]
.skipcardinc
	ld hl, wVoltorbFlipCardProperties
	ld bc, VOLTORB_FLIP_CARD_COUNT
.check23left
	ld a, [hli]
	and VOLTORB_FLIP_CARD_NUMBER_MASK | VOLTORB_FLIP_CARD_FLIPPED
	cp 2
	jr nz, .skip2add
	inc b
.skip2add
	cp 3
	jr nz, .skip3add
	inc b
.skip3add
	dec c
	jr nz, .check23left
	ld a, b
	ld [wVoltorbFlipUnflippedMultipliers], a ; for the are you sure song
	and a
	ret nz
	call VFRefreshMap
	ld hl, wVoltorbFlipCursorX
	ld a, [hli]
	ld b, a
	ld a, [hli]
	ld c, a
	di
	call VFRefreshScreen
	ei
	ld de, SFX_3RD_PLACE ; level clear
	call WaitPlaySFX
	ld c, VOLTORB_FLIP_LEVEL_CLEAR_DELAY_FRAMES
	call DelayFrames
	ld a, [wVoltorbFlipLevel]
	inc a
	cp VOLTORB_FLIP_LEVEL_CAP_GUARD
	call z, .caplevel
	ld [wVoltorbFlipLevel], a
	ld de, SFX_TRANSACTION
	call WaitPlaySFX
	ld hl, wVoltorbFlipCoinsThisGame
	ld a, [hli]
	ld d, a
	ld a, [hld]
	ld e, a
	push hl
	ld hl, wCoins
	ld a, [hli]
	ld l, [hl]
	ld h, a
	add hl, de
	push hl
	pop de
	pop hl
	ld a, d
	cp HIGH(MAX_COINS)
	jr nc, .maybecap
.totalcoins
	ld a, d
	ld [wCoins], a
	ld a, e
	ld [wCoins + 1], a
	jp VFInitLevel
.caplevel
	ld a, VOLTORB_FLIP_LEVEL_LIMIT
	ret
.maybecap
	cp HIGH(MAX_COINS)
	jr nz, .capcoins
	ld a, e
	cp LOW(MAX_COINS)
	jr c, .totalcoins
; fallthrough
.capcoins
	ld de, MAX_COINS
	jr .totalcoins

.bbutton
	and VOLTORB_FLIP_DIRECTION_MASK
	ret z
	ld b, a
	ldh a, [hJoypadPressed]
	ld c, a
	ld a, [de]
	bit B_PAD_DOWN, b
	call nz, .bdown
	bit B_PAD_UP, b
	call nz, .bup
	bit B_PAD_LEFT, b
	jr nz, .bleft
	bit B_PAD_RIGHT, b
	ret z
.bright
	bit B_PAD_DOWN, c
	jr nz, .toggle3
	bit B_PAD_UP, c
	jr nz, .toggle1
	ret
.bleft
	bit B_PAD_DOWN, c
	jr nz, .toggle2
	bit B_PAD_UP, c
	jr nz, .toggle0
	ret
.bup
	bit B_PAD_LEFT, c
	jr nz, .toggle0
	bit B_PAD_RIGHT, c
	jr nz, .toggle1
	ret
.bdown
	bit B_PAD_LEFT, c
	jr nz, .toggle2
	bit B_PAD_RIGHT, c
	jr nz, .toggle3
	ret
.toggle0
	xor VOLTORB_FLIP_CARD_MARKED0
	ld [de], a
	ret
.toggle1
	xor VOLTORB_FLIP_CARD_MARKED1
	ld [de], a
	ret
.toggle2
	xor VOLTORB_FLIP_CARD_MARKED2
	ld [de], a
	ret
.toggle3
	xor VOLTORB_FLIP_CARD_MARKED3
	ld [de], a
	ret

.rightbutton
	ld a, b
	inc a
	cp VOLTORB_FLIP_BOARD_SIZE
	jr nz, .norowwrap
	xor a
.norowwrap
	ld [wVoltorbFlipCursorX], a
	ret
.leftbutton
	ld a, b
	dec a
	cp $ff
	jr nz, .norowwrap
	ld a, VOLTORB_FLIP_MAX_INDEX
	jr .norowwrap

.upbutton
	ld a, c
	dec a
	cp $ff
	jr nz, .nocolwrap
	ld a, VOLTORB_FLIP_MAX_INDEX
.nocolwrap
	ld [wVoltorbFlipCursorY], a
	ret
.downbutton
	ld a, c
	inc a
	cp VOLTORB_FLIP_BOARD_SIZE
	jr nz, .nocolwrap
	xor a
	jr .nocolwrap

VFLoadGFX:
	ld hl, rSTAT
	ld a, 1
.wait
	ld a, [hl]
	and STAT_MODE
	cp STAT_VBLANK
	jr nz, .wait
	dec hl ; rLCDC
	res B_LCDC_ENABLE, [hl]
	lb bc, BANK(VoltorbFlipGFX), 128 ; load the full gfx sheet so number tiles are present
	ld de, VoltorbFlipGFX
	ld hl, vTiles2
	jp Copy2bpp

VFLoadPalette:
	ldh a, [rSVBK] ; $ff00+$70
	push af
	ld a, BANK(wBGPals2)
	ldh [rSVBK], a
	lb bc, $e4, 8
	ld hl, wBGPals2
	ld de, VoltorbFlipPalette
	call CopyPals
	pop af
	ldh [rSVBK], a
	jp ForceUpdateCGBPals

VFInitRAM:
	ld hl, wVoltorbFlipCardProperties
	ld bc, wVoltorbFlipDataEnd - wVoltorbFlipCardProperties
	xor a
	call ByteFill
	ld hl, wVoltorbFlipState
	ld [hli], a ; state
	ld a, 1
	ld [hli], a ; level
	ld a, 2
	ld [hli], a ; x
	ld [hli], a ; y
	ret

VFInitMap:
	ld hl, wTilemap
	ld bc, wTilemapEnd - wTilemap
	ld a, 17
	call ByteFill
	ld hl, wAttrmap
	ld bc, wAttrmapEnd - wAttrmap
	xor a
	call ByteFill
	ld b, VOLTORB_FLIP_ROWCOL_COUNT
	di
	xor a
	ldh [rVBK], a
	hlcoord 0, 15
	call .redcounter
	hlcoord 3, 15
	ld a, 6
	call .drawcounter
	hlcoord 6, 15
	ld a, 3
	call .drawcounter
	hlcoord 9, 15
	ld a, 4
	call .drawcounter
	hlcoord 12, 15
	ld a, 5
	call .drawcounter
	hlcoord 15, 0
	call .redcounter
	hlcoord 15, 3
	ld a, 6
	call .drawcounter
	hlcoord 15, 6
	ld a, 3
	call .drawcounter
	hlcoord 15, 9
	ld a, 4
	call .drawcounter
	hlcoord 15, 12
	ld a, 5
	call .drawcounter
	hlcoord 15, 15
	ld de, .coinstring
	call PlaceString
	hlcoord 15, 16
	ld de, .blank
	call PlaceString
	hlcoord 15, 17
	ld de, .blank
	call PlaceString
	ei
	call VFRefreshMap
	di
	xor a
	ldh [rVBK], a
	ld a, VOLTORB_FLIP_LEVEL_HEADER_TILE_BASE
	hlcoord 19, 4
	ld [hl], a
	inc a
	hlcoord 19, 5
	ld [hl], a
	inc a
	hlcoord 19, 6
	ld [hl], a
	inc a
	hlcoord 19, 7
	ld [hl], a
	inc a
	hlcoord 19, 8
	ld [hl], a
	ld a, [wVoltorbFlipLevel]
	add VOLTORB_FLIP_NUMBER2_TILE_BASE
	hlcoord 19, 10
	ld [hl], a
	ld b, 0
.loopa
	ld c, 0
.loopb
	call VFRefreshScreen1
	inc c
	ld a, c
	cp VOLTORB_FLIP_REFRESH_WIDTH
	jr nz, .loopb
	inc b
	ld a, b
	cp VOLTORB_FLIP_REFRESH_HEIGHT
	jr nz, .loopa
	reti

.coinstring
	db "COINS@"
.blank
	db "     @"

.drawcounter
	push bc
	push hl
	ld bc, wAttrmap - wTilemap
	add hl,bc
	ld [hli], a
	ld [hli], a
	ld [hl], a
	push de
	ld de, SCREEN_HEIGHT
	add hl, de
	pop de
	ld [hli], a
	ld [hli], a
	ld [hl], a
	push de
	ld de, SCREEN_HEIGHT
	add hl, de
	pop de
	ld [hli], a
	ld [hli], a
	ld [hl], a
	pop hl
	pop bc
	ld a, VOLTORB_FLIP_COUNTER_BORDER_TILE
	ld [hli], a
	ld [hl], VOLTORB_FLIP_NUMBER1_TILE_BASE
	ld de, wVoltorbFlipNumberTotals + VOLTORB_FLIP_ROWCOL_COUNT ; wVoltorbFlipNumberTotals is start of total numbers in row
	ld a, e
	sub b
	ld e, a ; load the correct row
	push bc
	ld bc, VOLTORB_FLIP_COUNTER_PRINT_BC
	call PrintNum
	pop bc
	dec hl
	dec hl
	ld a, [hl]
	sub VOLTORB_FLIP_COUNTER_ATTR_OFFSET
	ld [hli], a
	ld a, [hl]
	sub VOLTORB_FLIP_COUNTER_ATTR_OFFSET
	ld [hl], a
	ld de, SCREEN_HEIGHT
	add hl, de
	ld a, 9
	ld [hli], a
	inc a
	ld [hli], a
	ld a, VOLTORB_FLIP_COUNTER_BORDER_TILE
	add hl, de ; should move us to the bottom row of the counter
	ld a, 25
	ld [hli], a
	inc a
	ld [hli], a
	ld de, wVoltorbFlipVoltorbTotals + VOLTORB_FLIP_ROWCOL_COUNT ; wVoltorbFlipVoltorbTotals is start of total voltorb in row
	ld a, e
	sub b
	ld e, a ; load the correct row
	ld a, [de]
	add VOLTORB_FLIP_NUMBER2_TILE_BASE
	ld [hl], a
	dec b
	ret

.redcounter
	ld a, 2
	push bc
	push hl
	ld bc, wAttrmap - wTilemap
	add hl,bc
	ld [hli], a
	ld [hli], a
	ld [hl], a
	push de
	ld de, SCREEN_HEIGHT
	add hl, de
	pop de
	ld [hli], a
	ld [hli], a
	ld [hl], a
	push de
	ld de, SCREEN_HEIGHT
	add hl, de
	pop de
	ld [hli], a
	ld [hli], a
	ld [hl], a
	pop hl
	pop bc
	ld a, 7
	ld [hli], a
	ld [hl], VOLTORB_FLIP_NUMBER1_TILE_BASE
	ld de, wVoltorbFlipNumberTotals + VOLTORB_FLIP_ROWCOL_COUNT ; wVoltorbFlipNumberTotals is start of total numbers in row
	ld a, e
	sub b
	ld e, a ; load the correct row
	push bc
	ld bc, VOLTORB_FLIP_COUNTER_PRINT_BC
	call PrintNum
	pop bc
	ld de, VOLTORB_FLIP_COUNTER_BOTTOM_OFFSET
	add hl, de
	ld a, 11
	ld [hli], a
	inc a
	ld [hli], a
	ld [hl], 7
	inc de
	add hl, de ; should move us to the bottom row of the counter
	ld a, 27
	ld [hli], a
	inc a
	ld [hli], a
	ld de, wVoltorbFlipVoltorbTotals + VOLTORB_FLIP_ROWCOL_COUNT ; wVoltorbFlipVoltorbTotals is start of total voltorb in row
	ld a, e
	sub b
	ld e, a ; load the correct row
	ld a, [de]
	add VOLTORB_FLIP_NUMBER1_TILE_BASE
	ld [hl], a
	dec b
	ret

VFRefreshMap:
	ld de, wVoltorbFlipCardProperties ; start of card properties
	lb bc, VOLTORB_FLIP_BOARD_SIZE, VOLTORB_FLIP_BOARD_SIZE
	ld hl, wTilemap ; tiles on screen
.g1x1
	push bc
	ld a, [wVoltorbFlipCursorX]
	ld b, a
	ld a, [wVoltorbFlipCursorY]
	ld c, a
	add a
	add a
	add c
	add b
	add LOW(wVoltorbFlipCardProperties)
	pop bc
	cp e
	ld a, [de]
	jr z, .highlighted
	res VOLTORB_FLIP_CARD_HIGHLIGHTED_F, a
	jr .checkflip
.highlighted
	set VOLTORB_FLIP_CARD_HIGHLIGHTED_F, a
.checkflip
	ld [de], a
	bit VOLTORB_FLIP_CARD_FLIPPED_F, a ; is the card flipped
	jp nz, .flipped
	bit VOLTORB_FLIP_CARD_MARKED0_F, a ; is 0 marked?
	jp nz, .marked0
	ld a, VOLTORB_FLIP_TILE_UL_BLANK ; upper left corner blank
	ld [hli], a
.g2x1
	push bc
	push hl
	ld bc, wAttrmap - wTilemap - 1
	add hl,bc
	xor a
	ld [hli], a
	ld a, VOLTORB_FLIP_TILE_UL_MARK
	ld [hli], a
	xor a
	ld [hl], a
	push de
	ld de, SCREEN_HEIGHT
	add hl, de
	pop de
	ld a, VOLTORB_FLIP_TILE_UL_MARK
	ld [hli], a
	xor a
	ld [hli], a
	ld [hl], VOLTORB_FLIP_TILE_UL_MARK
	push de
	ld de, SCREEN_HEIGHT
	add hl, de
	pop de
	xor a
	ld [hli], a
	ld a, VOLTORB_FLIP_TILE_UL_MARK
	ld [hli], a
	xor a
	ld [hl], a
	pop hl
	pop bc
	ld a, VOLTORB_FLIP_TILE_UM_BLANK ; upper middle blank
	ld [hli], a
.g3x1
	ld a, [de]
	bit VOLTORB_FLIP_CARD_MARKED1_F, a ; is 1 marked?
	jp nz, .marked1
	ld [hl], VOLTORB_FLIP_TILE_UR_BLANK ; upper right corner blank
.g1x2
	push de
	ld de, SCREEN_HEIGHT
	add hl, de
	pop de
	ld a, VOLTORB_FLIP_TILE_ML_BLANK ; left middle blank
	ld [hli], a
.g2x2
	ld a, VOLTORB_FLIP_TILE_MM_BLANK ; middle blank
	ld [hli], a
.g3x2
	ld [hl], VOLTORB_FLIP_TILE_MR_BLANK ; right middle blank
.g1x3
	push de
	ld de, SCREEN_HEIGHT
	add hl, de
	pop de
	ld a, [de]
	bit VOLTORB_FLIP_CARD_MARKED2_F, a ; is 2 marked?
	jp nz, .marked2
	ld a, VOLTORB_FLIP_TILE_LL_BLANK ; lower left corner blank
	ld [hli], a
.g2x3
	ld a, VOLTORB_FLIP_TILE_LM_BLANK ; lower middle blank
	ld [hli], a
.g3x3
	ld a, [de]
	bit VOLTORB_FLIP_CARD_MARKED3_F, a ; is 3 marked?
	jp nz, .marked3
	ld [hl], VOLTORB_FLIP_TILE_LR_BLANK ; lower right corner blank
.carddone
	ld a, [de]
	bit VOLTORB_FLIP_CARD_HIGHLIGHTED_F, a
	jr nz, .highlight
.finishcard
	inc de
	dec c
	jr z, .rowdone
	push de
	ld de, VOLTORB_FLIP_TILEMAP_ROW_BACK_OFFSET
	add hl, de
	pop de
	jp .g1x1
.highlight
	push bc
	push de
	push hl
	ld b, VOLTORB_FLIP_CARD_TILE_SIZE
	ld de, VOLTORB_FLIP_HIGHLIGHT_ATTR_OFFSET
	add hl, de
	ld de, VOLTORB_FLIP_HIGHLIGHT_ROW_OFFSET
.highlightloopa
	ld c, VOLTORB_FLIP_CARD_TILE_SIZE
.highlightloopb
	ld a, [hl]
	inc a
	ld [hli], a
	dec c
	jr nz, .highlightloopb
	add hl, de
	dec b
	jr nz, .highlightloopa
	pop hl
	pop de
	pop bc
	jr .finishcard
.rowdone
	dec b
	jr z, .done
	ld c, VOLTORB_FLIP_BOARD_SIZE
	push de
	ld de, VOLTORB_FLIP_REFRESH_WIDTH
	add hl, de
	pop de
	jp .g1x1
.done
	hlcoord 15, 16
	ld de, .blank
	call PlaceString
	inc hl
	ld de, wVoltorbFlipCoinsThisGame ; coins this game
	ld bc, VOLTORB_FLIP_COIN_PRINT_BC
	call PrintNum
	hlcoord 15, 17
	ld de, .blank
	call PlaceString
	inc hl
	ld de, wCoins
	ld bc, VOLTORB_FLIP_COIN_PRINT_BC
	jp PrintNum
.coinstring
	db "COINS@"
.blank
	db "    0@"

.flipped
	and VOLTORB_FLIP_CARD_NUMBER_MASK
	jr z, .voltorb
	xor a
	ld [hli], a
	push bc
	push hl
	ld bc, wAttrmap - wTilemap - 1
	add hl,bc
	ld [hli], a
	ld [hli], a
	ld [hl], a
	push de
	ld de, SCREEN_HEIGHT
	add hl, de
	pop de
	ld [hli], a
	ld [hli], a
	ld [hl], a
	push de
	ld de, SCREEN_HEIGHT
	add hl, de
	pop de
	ld [hli], a
	ld [hli], a
	ld [hl], a
	pop hl
	pop bc
	inc a
	ld [hli], a
	inc a
	ld [hl], a
	push de
	ld de, SCREEN_HEIGHT
	add hl, de
	pop de
	ld a, VOLTORB_FLIP_TILE_ML_BLANK
	ld [hli], a
	ld a, [de]
	and $3
	add VOLTORB_FLIP_TILE_CARD_NUMBER_BASE - 1
	ld [hli], a
	ld [hl], VOLTORB_FLIP_TILE_MR_BLANK
	push de
	ld de, SCREEN_HEIGHT
	add hl, de
	pop de
	ld a, VOLTORB_FLIP_TILE_LL_BLANK
	ld [hli], a
	inc a
	ld [hli], a
	inc a
	ld [hl], a
	jp .carddone
.marked0
	ld a, VOLTORB_FLIP_TILE_UL_MARK ; upper left corner marked
	ld [hli], a
	jp .g2x1
.marked1
	ld [hl], VOLTORB_FLIP_TILE_UR_MARK ; upper right corner marked
	jp .g1x2
.marked2
	ld a, VOLTORB_FLIP_TILE_LL_MARK ; lower left corner marked
	ld [hli], a
	jp .g2x3
.marked3
	ld [hl], VOLTORB_FLIP_TILE_LR_MARK ; lower right corner marked
	jp .carddone
.voltorb
	ld a, VOLTORB_FLIP_TILE_VOLTORB_TOP_BASE
	ld [hli], a
	dec a
	push bc
	push hl
	ld bc, wAttrmap - wTilemap - 1
	add hl,bc
	ld [hli], a
	ld [hli], a
	ld [hl], a
	push de
	ld de, SCREEN_HEIGHT
	add hl, de
	pop de
	ld [hli], a
	ld [hli], a
	ld [hl], a
	push de
	ld de, SCREEN_HEIGHT
	add hl, de
	pop de
	ld [hli], a
	ld [hli], a
	ld [hl], a
	pop hl
	pop bc
	inc a
	inc a
	ld [hli], a
	inc a
	ld [hl], a
	push de
	ld de, SCREEN_HEIGHT
	add hl, de
	pop de
	ld a, VOLTORB_FLIP_TILE_VOLTORB_MIDDLE_BASE
	ld [hli], a
	inc a
	ld [hli], a
	inc a
	ld [hl], a
	push de
	ld de, SCREEN_HEIGHT
	add hl, de
	pop de
	ld a, VOLTORB_FLIP_TILE_VOLTORB_BOTTOM_BASE
	ld [hli], a
	inc a
	ld [hli], a
	inc a
	ld [hl], a
	jp .finishcard ; a voltorb card will never have a highlighted palette

VFRefreshScreen: ; bc is the coordinates to refresh (3x3 tiles)
	push bc
	ld a, c
	ld c, 15
	call SimpleMultiply
	ld h, 0
	ld l, a
	add hl, hl
	ld a, b
	add a
	add b
	ld b, 0
	ld c, a
	add hl, hl
	add hl, bc
	pop bc
	push bc
	push hl
	ld de, wTilemap
	add hl, de
	push hl
	ld de, vBGMap0
	ld a, c
	ld c, VOLTORB_FLIP_BG_MAP_WIDTH
	call SimpleMultiply
	ld h, 0
	ld l, a
	add hl, hl
	add hl, hl
	ld a, b
	add a
	add b
	ld b, 0
	ld c, a
	add hl, bc
	add hl, de
	push hl
	pop de
	ld hl, rSTAT
	ld a, 1
.wait
	ld a, [hl]
	and STAT_MODE
	cp STAT_VBLANK
	jr nz, .wait
	pop hl
	push de
	ld b, VOLTORB_FLIP_CARD_TILE_SIZE
.loopa
	ld c, VOLTORB_FLIP_CARD_TILE_SIZE
.loopb
	ld a, [hli]
	ld [de], a
	inc de
	dec c
	jr nz, .loopb
	push bc
	ld bc, VOLTORB_FLIP_VRAM_ROW_STRIDE
	push hl
	push de
	pop hl
	add hl, bc
	push hl
	pop de
	pop hl
	ld bc, VOLTORB_FLIP_VRAM_ROW_OFFSET
	add hl, bc
	pop bc
	dec b
	jr nz, .loopa
	pop de
	pop hl
	ld bc, wAttrmap
	add hl, bc
	ld a, 1
	ldh [rVBK], a
	ld b, VOLTORB_FLIP_CARD_TILE_SIZE
.loopc
	ld c, VOLTORB_FLIP_CARD_TILE_SIZE
.loopd
	ld a, [hli]
	ld [de], a
	inc de
	dec c
	jr nz, .loopd
	push bc
	ld bc, VOLTORB_FLIP_VRAM_ROW_STRIDE
	push hl
	push de
	pop hl
	add hl, bc
	push hl
	pop de
	pop hl
	ld bc, VOLTORB_FLIP_VRAM_ROW_OFFSET
	add hl, bc
	pop bc
	dec b
	jr nz, .loopc
	xor a
	ldh [rVBK], a
	pop bc
	ret

VFRefreshScreen1: ; bc is the coordinates to refresh (3x3 tiles)
	push bc
	ld a, c
	ld c, 15
	call SimpleMultiply
	ld h, 0
	ld l, a
	add hl, hl
	ld a, b
	add a
	add b
	ld b, 0
	ld c, a
	add hl, hl
	add hl, bc
	pop bc
	push bc
	push hl
	ld de, wTilemap
	add hl, de
	push hl
	ld de, vBGMap0
	ld a, c
	ld c, VOLTORB_FLIP_BG_MAP_WIDTH
	call SimpleMultiply
	ld h, 0
	ld l, a
	add hl, hl
	add hl, hl
	ld a, b
	add a
	add b
	ld b, 0
	ld c, a
	add hl, bc
	add hl, de
	push hl
	pop de
	pop hl
	push de
	ld b, VOLTORB_FLIP_CARD_TILE_SIZE
.loopa
	ld c, VOLTORB_FLIP_CARD_TILE_SIZE
.loopb
	ld a, [hli]
	ld [de], a
	inc de
	dec c
	jr nz, .loopb
	push bc
	ld bc, VOLTORB_FLIP_VRAM_ROW_STRIDE
	push hl
	push de
	pop hl
	add hl, bc
	push hl
	pop de
	pop hl
	ld bc, VOLTORB_FLIP_VRAM_ROW_OFFSET
	add hl, bc
	pop bc
	dec b
	jr nz, .loopa
	pop de
	pop hl
	ld bc, wAttrmap
	add hl, bc
	ld a, 1
	ldh [rVBK], a
	ld b, VOLTORB_FLIP_CARD_TILE_SIZE
.loopc
	ld c, VOLTORB_FLIP_CARD_TILE_SIZE
.loopd
	ld a, [hli]
	ld [de], a
	inc de
	dec c
	jr nz, .loopd
	push bc
	ld bc, VOLTORB_FLIP_VRAM_ROW_STRIDE
	push hl
	push de
	pop hl
	add hl, bc
	push hl
	pop de
	pop hl
	ld bc, VOLTORB_FLIP_VRAM_ROW_OFFSET
	add hl, bc
	pop bc
	dec b
	jr nz, .loopc
	xor a
	ldh [rVBK], a
	pop bc
	ret

VFFlipAnimation:
	push de
	ld de, SFX_INTRO_SUICUNE_1 ; flip sound
	call WaitPlaySFX
	ld de, 3 ; first frame of the flip
.flipframe
	push de
	ld hl, wVoltorbFlipCardProperties
	ld a, c
	add a
	add a
	add c
	add b
	ld e, a
	ld d, 0
	add hl, de
	ld d, h
	ld e, l
	ld a, c
	push bc
	ld c, VOLTORB_FLIP_VRAM_FLIP_STRIDE
	call SimpleMultiply
	ld h, 0
	ld l, a
	ld a, b
	add a
	add b
	ld bc, wTilemap
	add hl, bc
	ld b, 0
	ld c, a
	add hl, bc
	pop bc
	ld a, [de]
	set 3, a
	ld [de], a

	pop de
	ld a, VOLTORB_FLIP_TILE_FLIP_TOP_BASE
	add d
	ld [hli], a
	push bc
	push af
	push hl
	ld bc, wAttrmap - wTilemap - 1
	add hl,bc
	ld a, 1
	ld [hli], a
	ld [hli], a
	ld [hl], a
	ld bc, SCREEN_HEIGHT
	add hl, bc
	ld [hli], a
	ld [hli], a
	ld [hl], a
	add hl, bc
	ld [hli], a
	ld [hli], a
	ld [hl], a
	pop hl
	pop af

	inc a
	ld [hli], a
	inc a
	ld [hl], a
	add hl, bc
	ld a, VOLTORB_FLIP_TILE_FLIP_MID_BASE
	add d
	ld [hli], a
	inc a
	ld [hli], a
	inc a
	ld [hl], a
	add hl, bc
	ld a, VOLTORB_FLIP_TILE_FLIP_BOTTOM_BASE
	add d
	ld [hli], a
	inc a
	ld [hli], a
	inc a
	ld [hl], a
	pop bc
	push de
	call .finish
	pop de
	ld a, d
	add e
	ld d, a
	cp 12
	jr z, .switchdir
	cp VOLTORB_FLIP_ANIM_END_SENTINEL
	jp nz, .flipframe
	pop de
	ret
.switchdir
	ld de, VOLTORB_FLIP_ANIM_DIRECTION_DELTA
	jp .flipframe
.finish
	ld hl, wVoltorbFlipCursorX
	ld a, [hli]
	ld b, a
	ld a, [hli]
	ld c, a
	di
	push hl
	call VFRefreshScreen
	pop hl
	ei
	jp DelayFrame

VFBoom:
	call VFRefreshMap
	ld hl, wVoltorbFlipCursorX
	ld a, [hli]
	ld b, a
	ld a, [hli]
	ld c, a
	di
	call VFRefreshScreen
	ei
	ld de, SFX_EGG_BOMB
	call WaitPlaySFX
	ld de, SFX_QUIT_SLOTS
	call WaitPlaySFX
	ld c, VOLTORB_FLIP_GAME_OVER_DELAY_FRAMES
	call DelayFrames
	ld a, [wVoltorbFlipCardsFlipped]
	and a
	jr z, .level0
.reset
	ld [wVoltorbFlipLevel], a
	jp VFInitLevel
.level0
	ld a, 1
	jr .reset

VFMultiplyCoins:
	push bc
	push de
	push hl
	push af
	ld a, [wVoltorbFlipCoinsThisGame]
	ld d, a
	ld a, [wVoltorbFlipCoinsThisGame + 1]
	ld e, a
	pop af
	cp 2
	jr z, .coinsound
	cp 3
	jr z, .coinsound
.resume
	push af
	ld b, a
	ld hl, 0
	and a
	jr z, .doneadd
.keepadd
	add hl, de
	dec b
	jr nz, .keepadd
.doneadd
	ld a, h
	cp HIGH(MAX_COINS)
	jr nc, .maybecap
	ld d, l
	or d
	jr z, .initcoins
	pop af
.updatecoins
	ld a, h
	ld [wVoltorbFlipCoinsThisGame], a
	ld a, l
	ld [wVoltorbFlipCoinsThisGame + 1], a
	call VFRefreshMap
	push bc
	lb bc, VOLTORB_FLIP_BOARD_SIZE, VOLTORB_FLIP_BOARD_SIZE
	di
	call VFRefreshScreen
	lb bc, VOLTORB_FLIP_BOARD_SIZE + 1, VOLTORB_FLIP_BOARD_SIZE
	call VFRefreshScreen
	ei
	pop bc
	pop hl
	pop de
	pop bc
	ret
.initcoins
	pop af
	ld h, 0
	ld l, a
	jr .updatecoins
.coinsound
	push de
	ld de, SFX_TRANSACTION
	call WaitPlaySFX
	pop de
	jr .resume
.maybecap
	cp HIGH(MAX_COINS)
	jr nz, .capcoins
	ld a, l
	cp LOW(MAX_COINS)
	jr nc, .capcoins
	pop af
	jr .updatecoins
.capcoins
	pop af
	ld hl, MAX_COINS
	jr .updatecoins

VFKeepCoins:
	ld de, SFX_DEX_FANFARE_LESS_THAN_20 ; level clear
	call WaitPlaySFX
	ld c, VOLTORB_FLIP_INTENSE_DELAY_FRAMES
	call DelayFrames
	ld a, [wVoltorbFlipCardsFlipped]
	and a
	jr z, .fixlevel
.setlevel
	ld [wVoltorbFlipLevel], a
	ld de, SFX_TRANSACTION
	call WaitPlaySFX
	ld hl, wVoltorbFlipCoinsThisGame
	ld a, [hli]
	ld d, a
	ld a, [hld]
	ld e, a
	push hl
	ld hl, wCoins
	ld a, [hli]
	ld l, [hl]
	ld h, a
	add hl, de
	push hl
	pop de
	pop hl
	ld a, d
	cp HIGH(MAX_COINS)
	jr nc, .maybecap
.totalcoins
	ld a, d
	ld [wCoins], a
	ld a, e
	ld [wCoins + 1], a
	jp VFInitLevel
.maybecap
	cp HIGH(MAX_COINS)
	jr nz, .capcoins
	ld a, e
	cp LOW(MAX_COINS)
	jr c, .totalcoins
; fallthrough
.capcoins
	ld de, MAX_COINS
	jr .totalcoins
.fixlevel
	inc a
	jr .setlevel
VFExit:
	call VFKeepCoins
	ld a, 1
	ldh [hBGMapMode], a
	;ld a, IE_VBLANK | IE_STAT | IE_TIMER | IE_SERIAL
	;ldh [rIE], a
	xor a
	ldh [hOAMUpdate], a ; enable sprite update
	pop af
	ret
