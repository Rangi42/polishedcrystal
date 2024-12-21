; GSC summary screen by Emi
; Organized into ordered colored pages, similar to vanilla Crystal
; Every page has one panel on the right and one panel on the bottom
; All pages display an animated pokepic on the left, all pages except green also show level and gender below pokepic
; * Pink page:   Mon overview, nick, ball, and OT on right, experience on bottom
; * Blue page:   Stats on right, ability on bottom
; * Green page:  Moves on right, item on bottom (item icon replacing level and gender on left), can be toggled for detailed move info
; * Orange page: Nature and character on right, met info on bottom

; TODO entire egg page
; TODO allow swapping move order
; TODO replace move learning page
; TODO remove moves screen (by replacing it properly)
; TODO fix artifacts when exiting PC or in battle summary

; vTiles0
DEF SUMMARY_TILE_OAM_START                  EQU $3C
DEF SUMMARY_TILE_OAM_PAGE                   EQU $3C
DEF SUMMARY_TILE_OAM_SELECTED_PAGE          EQU $3D
DEF SUMMARY_TILE_OAM_BALL_TOP_BORDER        EQU $3E
DEF SUMMARY_TILE_OAM_A_INFO                 EQU $40
DEF SUMMARY_TILE_OAM_TITLES                 EQU $44
DEF SUMMARY_TILE_OAM_EXP_TITLE              EQU $44
DEF SUMMARY_TILE_OAM_ABILITY_TITLE          EQU $48
DEF SUMMARY_TILE_OAM_ITEM_TITLE             EQU $4C
DEF SUMMARY_TILE_OAM_MOVE_TITLE             EQU $50
DEF SUMMARY_TILE_OAM_MET_TITLE              EQU $54
DEF SUMMARY_TILE_OAM_ARROW                  EQU $58
DEF SUMMARY_TILE_OAM_STATUS                 EQU $5C

; vTiles2
DEF SUMMARY_TILE_START                      EQU $31
DEF SUMMARY_TILE_SIDE_WINDOW_TL             EQU $31
DEF SUMMARY_TILE_SIDE_WINDOW_L              EQU $32
DEF SUMMARY_TILE_SIDE_WINDOW_T              EQU $34
DEF SUMMARY_TILE_SIDE_WINDOW_BL             EQU $33
DEF SUMMARY_TILE_SIDE_WINDOW_B              EQU $35
DEF SUMMARY_TILE_BOTTOM_WINDOW_T            EQU $38
DEF SUMMARY_TILE_BOTTOM_WINDOW_B            EQU SUMMARY_TILE_SIDE_WINDOW_B
DEF SUMMARY_TILE_BOTTOM_WINDOW_CORNER       EQU $36
DEF SUMMARY_TILE_BOTTOM_WINDOW_INNER_CORNER EQU $37
DEF SUMMARY_TILE_BALL_SIDE_BORDER           EQU $39
DEF SUMMARY_TILE_TYPE_BG_LEFT               EQU $3A
DEF SUMMARY_TILE_TYPE_BG_MIDDLE             EQU $3B
DEF SUMMARY_TILE_TYPE_BG_RIGHT              EQU $3C
DEF SUMMARY_TILE_POKERUS                    EQU $3D
DEF SUMMARY_TILE_POKERUS_CURED              EQU $3E
DEF SUMMARY_TILE_HIDDEN_H                   EQU $3F
DEF SUMMARY_TILE_HYPER_TRAINING             EQU $40
DEF SUMMARY_TILE_LEFT_ARROW                 EQU $41
DEF SUMMARY_TILE_RIGHT_ARROW                EQU $42
DEF SUMMARY_TILE_BALL                       EQU $4F
DEF SUMMARY_TILE_CATEGORY_START             EQU $50
DEF SUMMARY_TILE_ITEM                       EQU $56

; vTiles3
DEF SUMMARY_TILE_TYPE_START                 EQU $00

; bg palettes
DEF SUMMARY_PAL_LOWER_WINDOW                EQU $00
DEF SUMMARY_PAL_POKEMON                     EQU $01
DEF SUMMARY_PAL_ITEM                        EQU $02
DEF SUMMARY_PAL_SIDE_WINDOW                 EQU $03
DEF SUMMARY_PAL_SHINY_POKERUS               EQU $04
DEF SUMMARY_PAL_NATURE_UP                   EQU $04
DEF SUMMARY_PAL_HP_BAR                      EQU $05
DEF SUMMARY_PAL_GENDER_MARKER               EQU $06
DEF SUMMARY_PAL_POKEBALL                    EQU $07
DEF SUMMARY_PAL_NATURE_DOWN                 EQU $07

SummaryScreenInit:
	ldh a, [hMapAnims]
	push af
	xor a
	ldh [hMapAnims], a ; disable overworld tile animations
	ld a, [wBoxAlignment] ; whether sprite is to be mirrorred
	push af
	ld a, [wJumptableIndex]
	ld b, a
	ld a, [wSummaryScreenFlags]
	ld c, a

	push bc
	call ClearBGPalettes
	call ClearTileMap
	farcall WipeAttrMap

	; "Scroll" the tilemap destination to write a 19th row of blank tiles below the generally visible area
	; This portion is visible due to hblank rWY scrolling
	; Presumes the low byte of hBGMapAddress is 00
	ld a, 32
	ldh [hBGMapAddress], a
	call ApplyTilemapInVBlank
	call ApplyAttrmapInVBlank
	xor a
	ldh [hBGMapAddress], a

	call UpdateSprites
	call LoadFontsBattleExtra
	call SummaryScreen_InitTiles

	ldh a, [rSVBK]
	push af
	ld a, BANK(wOBPals1)
	ldh [rSVBK], a
	ld hl, .SummaryScreenObjPalettes
	ld bc, 8 palettes
	ld de, wOBPals1
	rst CopyBytes
	farcall ApplyOBPals
	pop af
	ldh [rSVBK], a

	ld a, 1
	ldh [hCGBPalUpdate], a

	ld a, [wTempMonBox]
	ld b, a
	ld a, [wTempMonSlot]
	ld c, a
	farcall GetStorageBoxMon

	ld hl, wSummaryScreenInterrupts
	ld a, 143
	ld [hli], a
	ld [hli], a
	ld bc, 2 * 15
	ld a, -1
	rst ByteFill
	; Set up for HBlank

	ld hl, hFunctionTarget
	ld b, [hl]
	ld a, LOW(LCDSummaryScreenHideWindow)
	ld [hli], a
	ld c, [hl]
	push bc
	ld a, HIGH(LCDSummaryScreenHideWindow)
	ld [hl], a
	ld hl, rIE
	ld a, [hl]
	push af
	set LCD_STAT, [hl]
	; save old window position
	ldh a, [hWX]
	ld b, a
	ldh a, [hWY]
	ld c, a
	push bc

	; Load initial mon
	xor a
	ld [wSummaryScreenFlags], a
	call SummaryScreen_InitMon
	call DelayFrame
	call SummaryScreen_LoadPage

	; Enter loop
	call SummaryScreenLoop
	; Clean up

	call ClearBGPalettes
	call ClearTileMap

	; restore old values
	pop bc
	ld a, b
	ldh [hWX], a
	ld a, c
	ldh [hWY], a

	pop af
	ld [rIE], a

	pop bc
	ld hl, hFunctionTarget
	ld [hl], b
	inc hl
	ld [hl], c

	pop bc
	ld a, b
	ld [wJumptableIndex], a
	ld a, c
	ld [wSummaryScreenFlags], a
	pop af
	ld [wBoxAlignment], a
	pop af
	ldh [hMapAnims], a
	ret

.SummaryScreenObjPalettes:
; pink
	RGB 31, 31, 31
	RGB 31, 15, 31
	RGB 00, 00, 00
	RGB 00, 00, 00 ; placeholder
; blue
	RGB 31, 31, 31
	RGB 17, 31, 31
	RGB 00, 00, 00
	RGB 00, 00, 00 ; placeholder
; green
	RGB 31, 31, 31
	RGB 17, 31, 00
	RGB 00, 00, 00
	RGB 00, 00, 00 ; placeholder
; orange
	RGB 31, 31, 31
	RGB 30, 22, 12
	RGB 00, 00, 00
	RGB 00, 00, 00 ; placeholder
; green info button
	RGB 31, 31, 31
	RGB 16, 24, 10
	RGB 31, 31, 31
	RGB 00, 00, 00 ; placeholder
; unused
	RGB 31, 31, 31
	RGB 31, 31, 31 ; unused
	RGB 31, 31, 31 ; unused
	RGB 00, 00, 00 ; placeholder
; arrow dark
	RGB 31, 31, 31
	RGB 31, 31, 31
	RGB 31, 10, 06
	RGB 00, 00, 00 ; placeholder
; arrow light
	RGB 31, 31, 31
	RGB 31, 31, 31
	RGB 31, 20, 20
	RGB 00, 00, 00 ; placeholder

SummaryScreen_InitTiles:
	ld hl, GFX_Summary
	ld de, vTiles2 tile SUMMARY_TILE_START
	lb bc, BANK(GFX_Summary), 18
	call DecompressRequest2bpp

	ld a, 1
	ldh [rVBK], a
	ld de, TypeIconGFX
	ld hl, vTiles3 tile SUMMARY_TILE_TYPE_START
	lb bc, BANK(TypeIconGFX), 19 * 4
	call Request1bpp
	xor a
	ldh [rVBK], a

	ld de, CategoryIconGFX
	ld hl, vTiles2 tile SUMMARY_TILE_CATEGORY_START
	lb bc, BANK(CategoryIconGFX), 2 * NUM_CATEGORIES
	call Request2bpp

	ld hl, GFX_Summary_Sprites
	ld de, vTiles0 tile SUMMARY_TILE_OAM_START
	lb bc, BANK(GFX_Summary_Sprites), 8 * 4
	jmp DecompressRequest2bpp

; Main summary screen event loop
SummaryScreenLoop:
	call SummaryScreen_DoAnim
	call .Joypad
	jr SummaryScreenLoop

.Joypad:
	ld a, [wSummaryScreenFlags]
	and $3
	ld c, a ; page

	call GetJoypad
	ldh a, [hJoyPressed]
	and D_DOWN | D_UP | D_LEFT | D_RIGHT | A_BUTTON | B_BUTTON

	bit B_BUTTON_F, a
	jr nz, .quit
	bit D_LEFT_F, a
	jr nz, .d_left
	bit D_RIGHT_F, a
	jr nz, .d_right
	bit A_BUTTON_F, a
	jr nz, .a_button
	bit D_UP_F, a
	jr nz, .d_up
	bit D_DOWN_F, a
	ret z
	; fallthrough

.d_down
	farcall NextStorageBoxMon
	ret z
	jr .load_mon

.d_up
	farcall PrevStorageBoxMon
	ret z
	; fallthrough

.load_mon
	call SummaryScreen_InitMon
	call DelayFrame
	jmp SummaryScreen_LoadPage

.a_button
	ld a, c
	cp a, SUMMARY_GREEN_PAGE
	ret nz
	jmp SummaryScreen_MoveInfoLoop

.d_right
	inc c
	ld a, NUM_SUMMARY_PAGES - 1
	cp c
	jr nc, .set_page
	ld c, 0
	jr .set_page

.d_left
	ld a, c
	dec c
	and a
	jr nz, .set_page
	ld c, NUM_SUMMARY_PAGES - 1
	; fallthrough

.set_page
	ld a, [wSummaryScreenFlags]
	and %11111100
	or c
	ld [wSummaryScreenFlags], a
	ld hl, wSummaryScreenFlags
	res 4, [hl]
	jmp SummaryScreen_LoadPage

.quit
	pop af
	ret

SummaryScreen_DoAnim:
	ld hl, wSummaryScreenFlags
	bit 6, [hl]
	jr nz, .try_anim
	bit 5, [hl]
	jr nz, .finish
	jmp DelayFrame

.try_anim
	farcall SetUpPokeAnim
	jr nc, .finish
	ld hl, wSummaryScreenFlags
	res 6, [hl]
.finish
	ld hl, wSummaryScreenFlags
	res 5, [hl]
	farjp HDMATransferTileMapToWRAMBank3

SummaryScreen_InitMon:
	ld hl, wSummaryScreenFlags
	res 6, [hl]

	; Clear sprites except page icons
	ld hl, wShadowOAM + 4 * 4
	ld bc, wShadowOAMEnd - (wShadowOAM + 4 * 4)
	xor a
	rst ByteFill

	; Clear content portions of summary screen
	hlcoord 0, 1
	lb bc, 10, 7
	call ClearBox
	hlcoord 0, 13
	lb bc, 5, 20
	call ClearBox

	farcall HDMATransferTileMapToWRAMBank3

	; Disable window rendering
	ldh a, [rLCDC]
	res rLCDC_WINDOW_ENABLE, a
	ldh [rLCDC], a
	ldh a, [rIE]
	res LCD_STAT, a
	ldh [rIE], a

	ld a, 255
	ld [rLYC], a

	ld a, [wTempMonSlot]
	ld [wPartyMenuCursor], a
	dec a
	ld [wCurPartyMon], a
	ld a, [wTempMonSpecies]
	ld [wCurSpecies], a
	ld [wCurPartySpecies], a
	ld a, [wTempMonForm]
	ld [wCurForm], a
	ld a, [wTempMonIsEgg]
	bit MON_IS_EGG_F, a
	jr nz, EggSummaryInit

	; count the number of moves the current mon has
	xor a
	ld [wSummaryScreenPage], a
	lb bc, 0, NUM_MOVES
	ld hl, wTempMonMoves + 1
.moves_loop
	inc b
	ld a, [hli]
	and a
	jr z, .moves_loop_end
	dec c
	jr nz, .moves_loop
.moves_loop_end
	ld a, b
	ld [wSummaryScreenMoveCount], a

	call SummaryScreen_InitLayout
	ld hl, GFX_Balls
	ld de, vTiles2 tile SUMMARY_TILE_BALL
	lb bc, BANK(GFX_Balls), 1
	call DecompressRequest2bpp
	ld a, [wTempMonCaughtBall]
	and CAUGHT_BALL_MASK
	ld h, 0
	ld l, a
	add hl, hl
	add hl, hl
	add hl, hl
	add hl, hl
	ld de, wDecompressScratch
	add hl, de
	push hl
	pop de
	ld hl, vTiles2 tile SUMMARY_TILE_BALL
	ld c, 1
	call Request2bppInWRA6

	xor a
	ldh [rVBK], a
	farcall LoadSummaryStatusIcon
	ld a, [wTempMonItem]
	farcall LoadItemIconForSummaryScreen
	farcall _CGB_StatsScreenHPPals
	ld hl, wSummaryScreenFlags
	set 4, [hl]
	ret

EggSummaryInit:
	ld a, [wCurPartySpecies]
	push af
	ld a, EGG
	ld [wCurPartySpecies], a
	call EggSummaryScreen
	pop af
	ld [wCurPartySpecies], a
	ld hl, wJumptableIndex
	inc [hl]
	ret

SummaryScreen_InitLayout:
	call .PlaceHPBar

	ld hl, .PageSprites
	ld de, wSummaryScreenOAMSprite00
	ld bc, 4 * 4
	rst CopyBytes

	ld hl, .TabTitleSprites
	ld de, wSummaryScreenOAMSprite36
	ld bc, 4 * 4
	rst CopyBytes

	; Right window
	hlcoord 7, 1
	ld a, SUMMARY_TILE_SIDE_WINDOW_TL
	ld [hli], a
	; hlcoord 8, 1
	ld bc, 12
	ld a, SUMMARY_TILE_SIDE_WINDOW_T
	rst ByteFill

	hlcoord 7, 2
	ld a, SUMMARY_TILE_SIDE_WINDOW_L
	lb bc, 9, 1
	call FillBoxWithByte
	hlcoord 7, 11
	ld a, SUMMARY_TILE_SIDE_WINDOW_BL
	ld [hli], a
	; hlcoord 7, 12
	ld bc, 12
	ld a, SUMMARY_TILE_SIDE_WINDOW_B
	rst ByteFill

	; Bottom window
	hlcoord 0, 12
	ld bc, SCREEN_WIDTH
	ld a, SUMMARY_TILE_BOTTOM_WINDOW_T
	rst ByteFill

	hlcoord 1, 11
	ld a, SUMMARY_TILE_BOTTOM_WINDOW_CORNER
	ld [hli], a
	ld a, SUMMARY_TILE_BOTTOM_WINDOW_B
	ld bc, 3
	rst ByteFill
	ld [hl], SUMMARY_TILE_BOTTOM_WINDOW_CORNER

	hlcoord 1, 12
	ld a, SUMMARY_TILE_BOTTOM_WINDOW_INNER_CORNER
	ld [hli], a
	ld a, " "
	ld c, 3
	rst ByteFill
	ld [hl], SUMMARY_TILE_BOTTOM_WINDOW_INNER_CORNER

	ld hl, wSummaryScreenTypes
	ld a, [wBaseType1]
	ld [hli], a
	ld a, [wBaseType2]
	ld [hl], a

	lb bc, 0, 252
.moveTypes
	ld hl, wTempMonMoves - 252
	add hl, bc
	ld a, [hl]
	and a
	jr z, .moveTypesEnd
	ld [wCurMove], a
	ld hl, Moves + MOVE_TYPE
	call GetCurMoveProperty
	ld hl, wSummaryScreenTypes - 252 + 2
	add hl, bc
	ld [hl], a
	inc c
	jr nz, .moveTypes
.moveTypesEnd

	call .ApplySummaryPalettes

	hlcoord 19 - NUM_SUMMARY_PAGES * 2, 0
	ld [hl], SUMMARY_TILE_LEFT_ARROW
	hlcoord 19, 0
	ld [hl], SUMMARY_TILE_RIGHT_ARROW
	ret

.PlaceHPBar:
	ld hl, wTempMonHP
	ld a, [hli]
	ld b, a
	ld c, [hl]
	ld hl, wTempMonMaxHP
	ld a, [hli]
	ld d, a
	ld e, [hl]
	farcall ComputeHPBarPixels
	ld hl, wCurHPPal
	call SetHPPal
	jmp DelayFrame

.ApplySummaryPalettes:
	ldh a, [rSVBK]
	push af
	ld a, BANK(wOBPals1)
	ldh [rSVBK], a
	ld c, 0
.objPalettes
	ld d, 0
	ld hl, wSummaryScreenTypes
	add hl, bc
	ld e, [hl]
	sla e
	ld hl, TypeIconPals
	add hl, de
	push hl
	ld hl, wOBPals1 + 6
	add hl, bc
	add hl, bc
	add hl, bc
	add hl, bc
	add hl, bc
	add hl, bc
	add hl, bc
	add hl, bc
	ld d, h
	ld e, l
	pop hl
	push bc
	farcall LoadOneColor
	pop bc
	inc c
	ld a, 5
	cp a, c
	jr nc, .objPalettes

	farcall ApplyOBPals
	pop af
	ldh [rSVBK], a
	ret

.PageSprites:
	db 17, 104, SUMMARY_TILE_OAM_PAGE, $0
	db 17, 120, SUMMARY_TILE_OAM_PAGE, $1
	db 17, 136, SUMMARY_TILE_OAM_PAGE, $2
	db 17, 152, SUMMARY_TILE_OAM_PAGE, $3

.TabTitleSprites:
	db 108, 20, SUMMARY_TILE_OAM_TITLES + 0, $0
	db 108, 28, SUMMARY_TILE_OAM_TITLES + 1, $0
	db 108, 36, SUMMARY_TILE_OAM_TITLES + 2, $0
	db 108, 44, SUMMARY_TILE_OAM_TITLES + 3, $0

SummaryScreen_InitAttrmap:
	farcall WipeAttrMap

	hlcoord 0, 0, wAttrmap
	lb bc, 12, 8
	ld a, SUMMARY_PAL_POKEMON
	call FillBoxWithByte

	hlcoord 8, 0, wAttrmap
	lb bc, 1, 14
	; a == SUMMARY_PAL_POKEMON
	call FillBoxWithByte

	hlcoord 0, 12, wAttrmap
	lb bc, 1, 20
	ld a, SUMMARY_PAL_SIDE_WINDOW
	call FillBoxWithByte

	hlcoord 2, 12, wAttrmap
	lb bc, 1, 3
	xor a
	assert SUMMARY_PAL_LOWER_WINDOW == 0
	call FillBoxWithByte

	hlcoord 1, 11, wAttrmap
	ld a, SUMMARY_PAL_SIDE_WINDOW
	ld [hli], a
	ld a, Y_FLIP | SUMMARY_PAL_LOWER_WINDOW
	ld bc, 3
	rst ByteFill
	ld a, X_FLIP | SUMMARY_PAL_SIDE_WINDOW
	ld [hl], a
	hlcoord 5, 12, wAttrmap
	ld [hl], a

	hlcoord 7, 1, wAttrmap
	lb bc, 11, 13
	ld a, SUMMARY_PAL_SIDE_WINDOW
	call FillBoxWithByte

	hlcoord 5, 9, wAttrmap
	ld [hl], SUMMARY_PAL_GENDER_MARKER

	hlcoord 2, 8, wAttrmap
	lb bc, 3, 3
	ld a, SUMMARY_PAL_ITEM
	call FillBoxWithByte
	ret

SummaryScreen_LoadPage:
	ld a, [wCurPartySpecies]
	ld [wTempSpecies], a
	ld [wCurSpecies], a
	xor a
	ldh [hBGMapMode], a
	ldh [hOAMUpdate], a
	ldh [hCGBPalUpdate], a
	call .ClearBox
	call .PlaceLevelAndGender
	hlbgcoord 0, 0, wSummaryScreenWindowBuffer
	ld a, 10
	ld e, a
	ld b, 0
.loop
	ld c, $10
	ld a, " "
	rst ByteFill
	ld c, $10
	ld a, 3
	rst ByteFill
	dec e
	jr nz, .loop

	ld c, 4 * 20
	ld a, 0
	ld hl, wSummaryScreenOAMSprite04
	rst ByteFill
	call .PageTilemap
	ld hl, wSummaryScreenFlags
	bit 4, [hl]
	call nz, SummaryScreen_PlaceFrontpic
	call SummaryScreen_SwitchPage
	farcall HDMATransferTileMapToWRAMBank3
	ld a, 7 + 64
	ldh [hWX], a
	ld a, 16
	ldh [hWY], a

	ldh a, [rSVBK]
	push af
	ld a, BANK(wBGPals1)
	ldh [rSVBK], a
	ld hl, wSummaryScreenPals
	ld de, wBGPals1
	ld bc, 1 palettes
	rst CopyBytes
	ld hl, wSummaryScreenPals palette 2
	ld de, wBGPals1 palette 2
	ld bc, 6 palettes
	rst CopyBytes
	pop af
	ldh [rSVBK], a

	;jmp SafeCopyTilemapAtOnce
	ret

.ClearBox:
	ld a, [wSummaryScreenFlags]
	and $3
	ld c, a
	hlcoord 0, 13
	lb bc, 5, 20
	jmp ClearBox

.PlaceLevelAndGender:
	; Clear item tiles
	hlcoord 2, 8
	lb bc, 3, 3
	call ClearBox

	hlcoord 1, 9
	call PrintLevel
	hlcoord 5, 9
	push hl
	farcall GetGender
	pop hl
	ret c
	ld a, "<MALE>"
	jr nz, .got_gender
	inc a ; "<FEMALE>"
.got_gender
	ld [hl], a
	ret

.PageTilemap:
	ld a, [wSummaryScreenFlags]
	and $3
	call StackJumpTable

.Jumptable:
	dw SummaryScreen_PinkPage
	dw SummaryScreen_BluePage
	dw SummaryScreen_GreenPage
	dw SummaryScreen_OrangePage

INCLUDE "engine/pokemon/summary/pink_page.asm"
INCLUDE "engine/pokemon/summary/blue_page.asm"
INCLUDE "engine/pokemon/summary/green_page.asm"
INCLUDE "engine/pokemon/summary/orange_page.asm"
INCLUDE "engine/pokemon/summary/egg_page.asm"

; The semi-precisely timed routine responsible for updating the graphics during a page transition.
; Utilizes hblank over 2 frames to mostly seemlessly copy data before/after scanlines.
;
; Starting on rLY == 84, an HDMA is triggered to run over the next 19 hblanks.
; 19 blocks of 16 tiles are copied from wSummaryScreenWindowBuffer into the window tilemap.
; This represents 9.5 rows of tiles, however, only the leftmost 12 of 32 are ever visible.
; By the time of the hblank at rLY == 91, the lowest pixels of the window buffer will have been drawn.
; This will occur just before the HDMA copies in tile data affecting these tiles on all pages.
; The tilemap HDMA will conclude around rLY == 102
;
; At around rLY == 103, an HDMA is triggered to run over the next 19 hblanks.
; 19 blocks of 16 tiles are copied from wSummaryScreenWindowBuffer into the window attribute map.
; Like before, this is 9.5 rows of attributes, unlike before, this HDMA starts on the 16th attribute.
;
; wSummaryScreenWindowBuffer is a staggered buffer, 32 bytes per row, half tiles half attributes.
; It is simply much easier and faster to write garbage to the parts of the window that are invisible.
; After the HDMAs, a row of the tilemap will look like this:
; TTTT_TTTT_TTTT_TTTT_AAAA_AAAA_AAAA_AAAA
;              ^ last visible tile
; After the HDMAs, a row of the attribute map will look like this:
; AAAA_AAAA_AAAA_AAAA_TTTT_TTTT_TTTT_TTTT
;              ^ last visible attribute
;
; At rLY == 128, the new hblank routine is set up for toggling the window and scrolling the background.
; See home/lcd.asm
SummaryScreen_SwitchPage:
	xor a
	ld [rVBK], a
	ld a, HIGH(wSummaryScreenWindowBuffer)
	ld [rHDMA1], a
	ld a, LOW(wSummaryScreenWindowBuffer)
	ld [rHDMA2], a
	ld a, HIGH(vBGMap1)
	ld [rHDMA3], a
	ld a, LOW(vBGMap1)
	ld [rHDMA4], a

.lineWait
	ld a, [rLY]
	cp a, 84
	jr nz, .lineWait
	ld a, $80 | 18
	ld [rHDMA5], a ; HDMA 19 blocks of tiles

	ld hl, wSummaryScreenOAMSprite00TileID
	ld [hl], SUMMARY_TILE_OAM_PAGE
	ld hl, wSummaryScreenOAMSprite01TileID
	ld [hl], SUMMARY_TILE_OAM_PAGE
	ld hl, wSummaryScreenOAMSprite02TileID
	ld [hl], SUMMARY_TILE_OAM_PAGE
	ld hl, wSummaryScreenOAMSprite03TileID
	ld [hl], SUMMARY_TILE_OAM_PAGE
	ld a, [wSummaryScreenFlags]
	and $3
	add a, a
	add a, a
	ld d, 0
	ld e, a
	ld hl, wSummaryScreenOAMSprite00TileID
	add hl, de
	ld [hl], SUMMARY_TILE_OAM_SELECTED_PAGE
	ld hl, wSummaryScreenOAM
	ld de, wShadowOAM
	ld bc, wShadowOAMEnd - wShadowOAM
	rst CopyBytes

.copyWait
	ld a, [rHDMA5]
	inc a
	jr nz, .copyWait
	inc a ; 1
	ld [rVBK], a
	ld a, HIGH(wSummaryScreenWindowBuffer + $10)
	ld [rHDMA1], a
	ld a, LOW(wSummaryScreenWindowBuffer + $10)
	ld [rHDMA2], a
	ld a, HIGH(vBGMap3)
	ld [rHDMA3], a
	ld a, LOW(vBGMap3)
	ld [rHDMA4], a

	call .WaitUntilHBlank
	ld a, $80 | 18
	ld [rHDMA5], a ; HDMA 19 blocks of attributes

.l128
	ld a, [rLY]
	cp a, 128
	jr nz, .l128

	ld a, 10
	ld [rLYC], a
	ld a, 2
	ld [wSummaryScreenStep], a
	ld a, LOW(LCDSummaryScreenShowWindow)
	ldh [hFunctionTargetLo], a
	ld a, HIGH(LCDSummaryScreenShowWindow)
	ldh [hFunctionTargetHi], a

	ldh a, [rLCDC]
	set rLCDC_WINDOW_ENABLE, a
	ldh [rLCDC], a
	ldh a, [rIE]
	set LCD_STAT, a
	ldh [rIE], a

	ld hl, .InterruptTable
	ld b, 0
	ld a, [wSummaryScreenFlags]
	and $3
	sla a
	ld c, a
	add hl, bc
	ld a, [hli]
	ld b, a
	ld h, [hl]
	ld l, b
	ld de, wSummaryScreenInterrupts
	ld bc, 16 * 2
	rst CopyBytes

	xor a
	ldh [hCGBPalUpdate], a
	
	ld c, 6 * 2
	ld hl, wSummaryScreenPals + 2 palettes
	call .WaitUntilHBlank
	ld a, (2 palettes) | (1 << rBGPI_AUTO_INCREMENT)
	ldh [rBGPI], a
	call .CopyPalettes

.l60
	ld a, [rLY]
	cp a, 62
	jr nc, .l60
	
	ld c, 1 * 2
	ld hl, wSummaryScreenPals
	call .WaitUntilHBlank
	ld a, 1 << rBGPI_AUTO_INCREMENT
	ldh [rBGPI], a
	jr .CopyPalettes

; copies c palettes during hblanks
; assumed to be called durring hblank
.CopyPalettes:
rept 4
	ld a, [hli]
	ldh [rBGPD], a
endr
	dec c
	ret z
	call .WaitUntilHBlank
	jr .CopyPalettes

.WaitUntilHBlank:
	ldh a, [rSTAT]
	and rSTAT_MODE_MASK ; wait until mode 1-3
	jr z, .WaitUntilHBlank
.mode0
	ldh a, [rSTAT]
	and rSTAT_MODE_MASK ; wait until mode 0
	ret z
	jr .mode0

.InterruptTable:
	dw .PinkInterrupts
	dw .BlueInterrupts
	dw .GreenInterrupts
	dw .OrangeInterrupts

.PinkInterrupts:
	db 22,  SUMMARY_LCD_SHOW_WINDOW
	db 23,  SUMMARY_LCD_HIDE_WINDOW
	db 31,  SUMMARY_LCD_SHOW_WINDOW
	db 39,  SUMMARY_LCD_HIDE_WINDOW
	db 43,  SUMMARY_LCD_SHOW_WINDOW
	db 51,  SUMMARY_LCD_HIDE_WINDOW
	db 59,  SUMMARY_LCD_SHOW_WINDOW
	db 67,  SUMMARY_LCD_HIDE_WINDOW
	db 71,  SUMMARY_LCD_SHOW_WINDOW
	db 79,  SUMMARY_LCD_HIDE_WINDOW
	db 83,  SUMMARY_LCD_SHOW_WINDOW
	db 91,  SUMMARY_LCD_HIDE_WINDOW
	db 127, SUMMARY_LCD_SCROLL_BACKGROUND
	db -1
.BlueInterrupts:
	db 22,  SUMMARY_LCD_SHOW_WINDOW
	db 31,  SUMMARY_LCD_HIDE_WINDOW
	db 35,  SUMMARY_LCD_SHOW_WINDOW
	db 43,  SUMMARY_LCD_HIDE_WINDOW
	db 47,  SUMMARY_LCD_SHOW_WINDOW
	db 55,  SUMMARY_LCD_HIDE_WINDOW
	db 59,  SUMMARY_LCD_SHOW_WINDOW
	db 67,  SUMMARY_LCD_HIDE_WINDOW
	db 71,  SUMMARY_LCD_SHOW_WINDOW
	db 79,  SUMMARY_LCD_HIDE_WINDOW
	db 83,  SUMMARY_LCD_SHOW_WINDOW
	db 91,  SUMMARY_LCD_HIDE_WINDOW
	db 127, SUMMARY_LCD_SCROLL_BACKGROUND
	db -1
.GreenInterrupts:
	db 22,  SUMMARY_LCD_SHOW_WINDOW
	db 31,  SUMMARY_LCD_HIDE_WINDOW
	db 35,  SUMMARY_LCD_SHOW_WINDOW
	db 51,  SUMMARY_LCD_HIDE_WINDOW
	db 55,  SUMMARY_LCD_SHOW_WINDOW
	db 71,  SUMMARY_LCD_HIDE_WINDOW
	db 75,  SUMMARY_LCD_SHOW_WINDOW
	db 91,  SUMMARY_LCD_HIDE_WINDOW
	db 127, SUMMARY_LCD_SCROLL_BACKGROUND
	db -1
.OrangeInterrupts:
	db 22,  SUMMARY_LCD_SHOW_WINDOW
	db 23,  SUMMARY_LCD_HIDE_WINDOW
	db 27,  SUMMARY_LCD_SHOW_WINDOW
	db 35,  SUMMARY_LCD_HIDE_WINDOW
	db 47,  SUMMARY_LCD_SHOW_WINDOW
	db 55,  SUMMARY_LCD_HIDE_WINDOW
	db 59,  SUMMARY_LCD_SHOW_WINDOW
	db 67,  SUMMARY_LCD_HIDE_WINDOW
	db 71,  SUMMARY_LCD_SHOW_WINDOW
	db 79,  SUMMARY_LCD_HIDE_WINDOW
	db 83,  SUMMARY_LCD_SHOW_WINDOW
	db 91,  SUMMARY_LCD_HIDE_WINDOW
	db 127, SUMMARY_LCD_SCROLL_BACKGROUND
	db -1

; Animated PokePic

SummaryScreen_PlaceFrontpic:
	ld a, [wTempMonForm]
	ld [wCurForm], a
	call SummaryScreen_GetAnimationParam
	jr nc, .no_cry
	call .Animate
	jmp SetDefaultBGPAndOBP

.no_cry
	call .DontAnimate
	jmp SetDefaultBGPAndOBP

.DontAnimate:
	ld hl, wSummaryScreenFlags
	set 5, [hl]
	hlcoord 0, 1
	ld a, [wCurPartySpecies]
	cp UNOWN
	jmp z, PrepMonFrontpicFlipped
	jmp PrepMonFrontpic

.Animate:
	ld a, [wCurPartySpecies]
	sub UNOWN
	jr z, .got_align
	ld a, TRUE
.got_align
	ld [wBoxAlignment], a
	ld a, [wCurPartySpecies]
	call IsAPokemon
	ret c
	call SummaryScreen_LoadTextboxSpaceGFX
	ld de, vTiles2 tile $00
	predef FrontpicPredef
	hlcoord 0, 1
	lb de, $0, $2
	predef LoadMonAnimation
	ld hl, wSummaryScreenFlags
	set 6, [hl]
	ret

SummaryScreen_GetAnimationParam:
	ld bc, wTempMon
	ld a, [wTempMonIsEgg]
	bit MON_IS_EGG_F, a
	scf
	ret nz
	call CheckFaintedFrzSlp
	ccf
	ret

; TODO this routine is used elsewhere, move somewhere else?
CheckFaintedFrzSlp:
	ld hl, MON_HP
	add hl, bc
	ld a, [hli]
	or [hl]
	jr z, .fainted_frz_slp
	ld hl, MON_STATUS
	add hl, bc
	ld a, [hl]
	and (1 << FRZ) | SLP_MASK
	ret z
.fainted_frz_slp
	scf
	ret

SummaryScreen_LoadTextboxSpaceGFX:
	push hl
	push de
	push bc
	push af
	call DelayFrame
	ldh a, [rVBK]
	push af
	ld a, $1
	ldh [rVBK], a
	ld de, TextboxSpaceGFX
	lb bc, BANK(TextboxSpaceGFX), 1
	ld hl, vTiles2 tile $7f
	call Get1bpp
	pop af
	ldh [rVBK], a
	jmp PopAFBCDEHL

; Other utilities

; a  = first tile
SummaryScreen_UpdateTabTitle:
	ld [wSummaryScreenOAMSprite36TileID], a
	inc a
	ld [wSummaryScreenOAMSprite37TileID], a
	inc a
	ld [wSummaryScreenOAMSprite38TileID], a
	inc a
	ld [wSummaryScreenOAMSprite39TileID], a
	ret

; a  = type
; b  = x
; c  = y
; d  = attributes
; hl = destination
SummaryScreen_PlaceTypeOBJ:
	sla a
	sla a
	ld e, a
rept 4
	ld a, c
	ld [hli], a
	ld a, b
	ld [hli], a
	add a, 8
	ld b, a
	ld a, e
	inc e
	ld [hli], a
	inc a
	ld a, d
	ld [hli], a
endr
	ret

; de = destination
SummaryScreen_PlaceTypeBG:
	ld hl, .TypeBG
	ld bc, 4
	rst CopyBytes
	ret
.TypeBG:
	db SUMMARY_TILE_TYPE_BG_LEFT
	db SUMMARY_TILE_TYPE_BG_MIDDLE
	db SUMMARY_TILE_TYPE_BG_MIDDLE
	db SUMMARY_TILE_TYPE_BG_RIGHT

; b = x
; c = y
SummaryScreen_PlaceArrow:
	ld hl, wSummaryScreenOAMSprite20
	ld d, SUMMARY_TILE_OAM_ARROW
	ld e, $6
.arrowLoop
	ld a, c
	ld [hli], a ; y
	ld a, b
	ld [hli], a ; x
	ld a, d
	ld [hli], a ; tile
	ld a, e
	ld [hli], a ; attr
	ld a, 8
	add a, b
	ld b, a
	inc d
	ld a, SUMMARY_TILE_OAM_ARROW + 4
	cp a, d
	ret z
	ld a, SUMMARY_TILE_OAM_ARROW + 2
	cp a, d
	jr nz, .arrowLoop
	ld a, b
	sub a, 16
	ld b, a
	ld a, 8
	add a, c
	ld c, a
	inc e
	jr .arrowLoop
