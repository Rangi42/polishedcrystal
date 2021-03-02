	; Object palettes
	const_def 1
	const PAL_CURSOR_MODE
	const PAL_MINI_ICON

_BillsPC:
	call .CheckCanUsePC
	ret c
	ld hl, wOptions1
	ld a, [hl]
	push af
	set NO_TEXT_SCROLL, [hl]
	ld a, 71
	ldh [rLYC], a
	call LoadStandardMenuHeader
	call UseBillsPC
	call ReturnToMapFromSubmenu

	ld hl, rIE
	res LCD_STAT, [hl]
	ld a, LOW(LCDGeneric)
	ldh [hFunctionTargetLo], a
	ld a, HIGH(LCDGeneric)
	ldh [hFunctionTargetHi], a

	pop af
	ld [wOptions1], a
	jp CloseSubmenu

.CheckCanUsePC:
	ld a, [wPartyCount]
	and a
	ret nz
	ld hl, .Text_GottaHavePokemon
	call MenuTextboxBackup
	scf
	ret

.Text_GottaHavePokemon:
	; You gotta have #MON to call!
	text_jump _PCGottaHavePokemonText
	text_end

BillsPC_LoadUI:
	ld a, 1
	ld [rVBK], a

	; Cursor tiles
	ld de, BillsPC_CursorTiles
	ld hl, vTiles0 + 4 tiles
	lb bc, BANK(BillsPC_CursorTiles), 4
	call Get2bpp

	; Blank held cursor mini + item icons
	ld hl, vTiles0 + 8 tiles
	ld a, 3 ; mini + shadowmask + items (only uses 2 tiles, but this is ok).
	call BillsPC_BlankTiles

	xor a
	ld [rVBK], a

	; Cursor sprite OAM
	lb de, 46, 24
	ld a, SPRITE_ANIM_INDEX_PC_CURSOR
	call _InitSpriteAnimStruct
	ld a, PCANIM_ANIMATE
	ld [wBillsPC_CursorAnimFlag], a

	; Colored gender symbols are housed in misc battle gfx stuff
	ld hl, BattleExtrasGFX
	ld de, vTiles2 tile $40
	lb bc, BANK(BattleExtrasGFX), 4
	call DecompressRequest2bpp

	; Box frame tiles
	ld de, BillsPC_Tiles
	ld hl, vTiles2 tile $31
	lb bc, BANK(BillsPC_Tiles), 15
	call Get2bpp

	; Held item icon
	ld hl, vTiles0 tile 4
	ld de, HeldItemIcons
	lb bc, BANK(HeldItemIcons), 2
	call Get2bpp

	; Set up background + outline palettes
	ld a, CGB_BILLS_PC
	jp GetCGBLayout

UseBillsPC:
	call ClearTileMap
	call ClearPalettes
	farcall WipeAttrMap
	call ClearSprites
	call ClearSpriteAnims
	ld a, [wVramState]
	res 0, a
	ld [wVramState], a

	xor a
	call BillsPC_SetCursorMode

	call BillsPC_LoadUI

	; Default cursor data (top left of storage, not holding anything)
	ld a, $12
	ld [wBillsPC_CursorPos], a
	xor a
	ld [wBillsPC_CursorHeldSlot], a

	; Reserve 4 blank tiles for empty slots
	ld a, 1
	ldh [rVBK], a
	ld a, 4
	ld hl, vTiles3
.blank_loop
	ld de, vTiles5 tile $7f
	push af
	ld c, 1
	push hl
	push de
	call Get2bpp
	pop de
	pop hl
	ld bc, 1 tiles
	add hl, bc
	pop af
	dec a
	jr nz, .blank_loop

	; Pokepic attributes
	hlcoord 0, 0, wAttrMap
	lb bc, 7, 7
	ld a, 2
	call FillBoxWithByte

	; Item name is in vbk1
	hlcoord 10, 3, wAttrMap
	ld bc, 10
	ld a, TILE_BANK
	rst ByteFill

	; Storage box
	hlcoord 7, 4
	lb bc, 12, 11
	ld de, .BoxTiles
	call .Box

	; Seperator between box name and content
	hlcoord 7, 6
	lb bc, $3e, 11
	call .SpecialRow

	; set up box title to use vbk0 (previously set to vbk1 by .Box)
	hlcoord 8, 5, wAttrMap
	ld bc, 11
	ld a, 7
	rst ByteFill

	; initialize icon graphics + palettes (tilemaps are set up later)
	ld a, 1
	ldh [rVBK], a
	call SetPartyIcons
	call SetBoxIconsAndName
	xor a
	ldh [rVBK], a

	; Party box
	hlcoord 0, 9
	lb bc, 7, 5
	ld de, .PartyTiles
	call .Box

	; Party label borders
	hlcoord 0, 10
	lb bc, $36, 5
	call .SpecialRow

	; Party label text
	hlcoord 2, 9
	ld a, $38
	ld [hli], a
	inc a
	ld [hli], a
	inc a
	ld [hli], a
	inc a
	hlcoord 2, 10
	ld [hli], a
	inc a
	ld [hli], a
	inc a
	ld [hli], a

	; Write icon tilemaps
	; Party
	hlcoord 1, 11
	lb bc, 3, 2
	lb de, $80, 2 | TILE_BANK
	call .WriteIconTilemap

	; Storage
	hlcoord 8, 7
	lb bc, 5, 4
	lb de, $98, 4 | TILE_BANK
	call .WriteIconTilemap

	; Update attribute map data
	ld b, 2
	call SafeCopyTilemapAtOnce

	; Set up for HBlank palette switching
	ld a, LOW(LCDBillsPC1)
	ldh [hFunctionTargetLo], a
	ld a, HIGH(LCDBillsPC1)
	ldh [hFunctionTargetHi], a
	ld hl, rIE
	set LCD_STAT, [hl]

	; Display data about current Pokémon pointed to by cursor
	call GetCursorMon

	; Begin storage system interaction
	call ManageBoxes

	; Finished with storage system. Cleanup
	call ClearTileMap
	jp ClearPalettes

.Box:
; Draws a box with tiles and attributes
	push bc
	push hl
	call CreateBoxBorders
	pop hl
	ld bc, wAttrMap - wTileMap
	add hl, bc
	pop bc
	ld de, .BoxAttr
	jp CreateBoxBorders

.BoxTiles:
	db $33, $32, $33 ; top
	db $31, $7f, $31 ; middle
	db $33, $32, $33 ; bottom
.PartyTiles:
	db $35, $34, $35 ; top
	db $31, $7f, $31 ; middle
	db $33, $32, $33 ; bottom
.BoxAttr:
	db 1, 1, 1 | X_FLIP ; top
	db 1, 2 | TILE_BANK, 1 | X_FLIP ; middle
	db 1 | Y_FLIP, 1 | Y_FLIP, 1 | X_FLIP | Y_FLIP ; bottom

.SpecialRow:
; Draws a nonstandard box outline
	ld a, b
	ld [hli], a
	inc a
	ld b, 0
	push bc
	push hl
	rst ByteFill
	dec a
	ld [hl], a
	pop hl
	ld bc, wAttrMap - wTileMap
	add hl, bc
	pop bc
	ld a, 1
	rst ByteFill
	ret

.WriteIconTilemap:
; Writes icon tile+attr data for b rows, c cols starting from hlcoord, tile a
	ld a, d
.tile_row
	push bc
	push de
	push hl
.tile_col
	call .icon
	dec c
	jr nz, .tile_col
	pop hl
	ld bc, SCREEN_WIDTH * 2
	add hl, bc
	pop de
	pop bc
	dec b
	jr nz, .tile_row
	ret

.icon
	push bc
	ld [hli], a
	inc a
	ld [hld], a
	inc a
	ld bc, SCREEN_WIDTH
	add hl, bc
	ld [hli], a
	inc a
	ld [hld], a
	inc a
	ld bc, -SCREEN_WIDTH + (wAttrMap - wTileMap)
	add hl, bc
	ld [hl], e
	inc hl
	ld [hl], e
	ld bc, SCREEN_WIDTH - 1
	add hl, bc
	ld [hl], e
	inc hl
	ld [hl], e
	inc e
	ld bc, -SCREEN_WIDTH + 2 + (wTileMap - wAttrMap)
	add hl, bc
	pop bc
	ret

BillsPC_CursorTiles:
	dw `33330000
	dw `22230000
	dw `22230000
	dw `22300000
	dw `22300000
	dw `23000000
	dw `23000000
	dw `30000000

	dw `00003333
	dw `00003111
	dw `00003111
	dw `00000311
	dw `00000311
	dw `00000031
	dw `00000031
	dw `00000003

	dw `00000000
	dw `00000000
	dw `00000000
	dw `00000000
	dw `00000000
	dw `00000000
	dw `00033333
	dw `00030000

	dw `00030000
	dw `00030000
	dw `00003000
	dw `00003000
	dw `00000300
	dw `00000300
	dw `00000030
	dw `00000003

BillsPC_Tiles:
	dw `01223333
	dw `01223333
	dw `01223333
	dw `01223333
	dw `01223333
	dw `01223333
	dw `01223333
	dw `01223333

	dw `00000000
	dw `11111111
	dw `22222222
	dw `22222222
	dw `33333333
	dw `33333333
	dw `33333333
	dw `33333333

	dw `00000000
	dw `00011111
	dw `00122222
	dw `01222222
	dw `01222333
	dw `01223333
	dw `01223333
	dw `01223333

	dw `00000000
	dw `11111111
	dw `22222222
	dw `22222222
	dw `22222222
	dw `22222222
	dw `22222222
	dw `22222222

	dw `00000000
	dw `00011111
	dw `00122222
	dw `01222222
	dw `01222222
	dw `01222222
	dw `01222222
	dw `01222222

	dw `01222222
	dw `01222222
	dw `01222222
	dw `01222222
	dw `01222333
	dw `01223333
	dw `01223333
	dw `01223333

	dw `22222222
	dw `22222222
	dw `22222222
	dw `22222222
	dw `33333333
	dw `33333333
	dw `33333333
	dw `33333333

	dw `00000000
	dw `11111111
	dw `22222222
	dw `22222222
	dw `23332222
	dw `23223222
	dw `23223223
	dw `23332232

	dw `00000000
	dw `11111111
	dw `22222222
	dw `22222222
	dw `22222222
	dw `22222222
	dw `33232323
	dw `23233222

	dw `00000000
	dw `11111111
	dw `22222222
	dw `22222222
	dw `22222222
	dw `32222222
	dw `33232232
	dw `32232232

	dw `23222232
	dw `23222223
	dw `22222222
	dw `22222222
	dw `33333333
	dw `33333333
	dw `33333333
	dw `33333333

	dw `33232222
	dw `23232222
	dw `22222222
	dw `22222222
	dw `33333333
	dw `33333333
	dw `33333333
	dw `33333333

	dw `32223332
	dw `33222232
	dw `22233322
	dw `22222222
	dw `33333333
	dw `33333333
	dw `33333333
	dw `33333333

	dw `01223333
	dw `01222333
	dw `01222222
	dw `01222222
	dw `01111111
	dw `01222222
	dw `01222222
	dw `01222333

	dw `33333333
	dw `33333333
	dw `22222222
	dw `22222222
	dw `11111111
	dw `22222222
	dw `22222222
	dw `33333333

BillsPC_BlankTiles:
; Used as input to blank empty slots
	ld de, vTiles3 tile $00
	ld bc, 4 tiles
.loop
	push hl
	push de
	push bc
	push af
	ld c, 4
	call BillsPC_SafeGet2bpp
	pop af
	pop bc
	pop de
	pop hl
	add hl, bc
	dec a
	jr nz, .loop
	ret

BillsPC_SetCursorMode:
; Switches cursor mode and updates the cursor palette.
	ld [wBillsPC_CursorMode], a
	ld a, BANK("GBC Video")
	call StackCallInWRAMBankA
.Function:
	ld a, [wBillsPC_CursorMode]
	ld de, wOBPals1 palette PAL_CURSOR_MODE
	and a
	ld hl, .Red
	jr z, .got_cursor_pal
	dec a
	ld hl, .Blue
	jr z, .got_cursor_pal
	ld hl, .Green
.got_cursor_pal
	ld bc, 1 palettes
	rst CopyBytes
	jp BillsPC_SetOBPals

.Red:
if !DEF(MONOCHROME)
	RGB 31, 31, 31
	RGB 31, 20, 20
	RGB 31, 10, 06
	RGB 31, 31, 31
else
	MONOCHROME_RGB_FOUR
endc

.Blue:
if !DEF(MONOCHROME)
	RGB 31, 31, 31
	RGB 20, 20, 31
	RGB 06, 10, 31
	RGB 31, 31, 31
else
	MONOCHROME_RGB_FOUR
endc

.Green:
if !DEF(MONOCHROME)
	RGB 31, 31, 31
	RGB 20, 31, 20
	RGB 10, 31, 06
	RGB 31, 31, 31
else
	MONOCHROME_RGB_FOUR
endc


BillsPC_SafeRequest2bppInWRA6::
	ldh a, [hROMBank]
	ld b, a
	call RunFunctionInWRA6

BillsPC_SafeGet2bpp:
; Only copies graphics when doing so wont interfere with hblank palette usage.
; Otherwise, wait until next frame.
	ldh a, [rLY]
	cp $40
	jp c, Get2bpp
	call DelayFrame
	jr BillsPC_SafeGet2bpp

SetBoxName:
; Writes name of current Box to box name area in storage system
	hlcoord 9, 5
	ld a, " "
	ld bc, 9
	rst ByteFill

	; Write new box name
	ld a, [wCurBox]
	ld b, a
	inc b
	farcall GetBoxName
	ld hl, wStringBuffer1
	ld d, h
	ld e, l

	; Center the name
	ld b, 0
.loop
	ld a, [hli]
	inc b
	cp "@"
	jr nz, .loop
	inc b
	srl b
	ld a, 5
	sub b
	ld c, a
	ld b, 0
	hlcoord 9, 5
	add hl, bc
	jp PlaceString

SetPartyIcons:
; Writes party list
	; Blank current list
	xor a
	ld hl, wBillsPC_PartyList
	ld bc, PARTY_LENGTH * 2
	rst ByteFill

	ld hl, vTiles4 tile $00
	ld a, PARTY_LENGTH
	call BillsPC_BlankTiles

_SetPartyIcons:
	; Write party members
	lb bc, 0, 1
	ld hl, wBillsPC_PartyList
	lb de, PARTY_LENGTH, $80
	jr PCIconLoop

SetBoxIconsAndName:
	; Blank previous box name
	call SetBoxName
	; fallthrough
SetBoxIcons:
	; Blank current list
	xor a
	ld hl, wBillsPC_BoxList
	ld bc, MONS_PER_BOX * 2
	rst ByteFill

	ld hl, vTiles4 tile $18
	ld a, MONS_PER_BOX
	call BillsPC_BlankTiles

_SetBoxIcons:
	; Write box members
	ld a, [wCurBox]
	inc a
	ld b, a
	ld c, 1
	ld hl, wBillsPC_BoxList
	lb de, MONS_PER_BOX, $98
	; fallthrough
PCIconLoop:
	call GetStorageBoxMon
	jr z, .next
	ld a, [wTempMonIsEgg]
	bit MON_IS_EGG_F, a
	ld a, [wTempMon]
	jr z, .got_curicon
	ld a, EGG
.got_curicon
	ld [wCurIcon], a
	ld [hli], a
	ld a, [wTempMonForm]
	ld [wCurIconForm], a
	ld a, e
	push hl
	push de
	push bc
	farcall GetStorageIcon_a
	pop bc
	pop de
	pop hl
	call WriteIconPaletteData
.next
	ld a, e
	add 4
	ld e, a
	inc c
	dec d
	jr nz, PCIconLoop
	ret

WriteIconPaletteData:
; Write box slot c's palette data. If b is zero, write party palette instead.
; (This is the same input as various "box mon data" functions).
	push hl
	push de
	push bc
	ld a, [wTempMonSpecies]
	ld hl, wTempMonPersonality
	farcall _GetMonIconPalette
	pop bc
	push bc
	push af
	ld a, c
	dec a
	inc b
	dec b
	ld bc, wBillsPC_MonPals2 - wBillsPC_MonPals1
	ld d, 2
	ld hl, wBillsPC_PartyPals3
	jr z, .loop
	ld d, 4
	ld hl, wBillsPC_MonPals1
.loop
	sub d
	jr c, .found_row
	add hl, bc
	jr .loop
.found_row
	add d
	add a
	add a
	ld c, a
	add hl, bc

	; TODO: per-mon palettes
	ld [hl], $7f
	inc hl
	ld [hl], $2a
	inc hl
	pop af
	and a ; PAL_OW_RED
	ld de, $04ff
	jr z, .got_pal
	dec a ; PAL_OW_BLUE
	ld de, $7d2a
	jr z, .got_pal
	dec a ; PAL_OW_GREEN
	ld de, $0ee7
	jr z, .got_pal
	dec a ; PAL_OW_BROWN
	ld de, $0d4f
	jr z, .got_pal
	dec a ; PAL_OW_PURPLE
	ld de, $4892
	jr z, .got_pal
	dec a ; PAL_OW_GRAY
	ld de, $35ad
	jr z, .got_pal
	dec a ; PAL_OW_PINK
	ld de, $2d5f
	jr z, .got_pal
	ld de, $56e3 ; PAL_OW_TEAL
.got_pal
	ld [hl], e
	inc hl
	ld [hl], d
	jp PopBCDEHL

BillsPC_HideCursor:
	ld hl, wVirtualOAM
	ld bc, 64
	xor a
	rst ByteFill
	ret

BillsPC_UpdateCursorLocation:
	push hl
	push de
	push bc
	ld hl, wVirtualOAM + 64
	ld de, wStringBuffer1
	ld bc, 4
	rst CopyBytes
	farcall PlaySpriteAnimations
	ld hl, wStringBuffer1
	ld de, wVirtualOAM + 64
	ld bc, 4
	rst CopyBytes
	jp PopBCDEHL

BillsPC_GetCursorHeldSlot:
; Returns current held box+slot to slot bc. Returns z if nothing is held.
	ld a, [wBillsPC_CursorHeldBox]
	ld b, a
	ld a, [wBillsPC_CursorHeldSlot]
	ld c, a
	and a
	ret

BillsPC_GetCursorSlot:
; Converts cursor position to slot bc. Returns c if hovering on box name.
; b is 0 for party, 1-15 for box, c is 1-20 for slot, 0 fir boxname.
	ld c, 0
	ld a, [wCurBox]
	inc a
	ld b, a
	ld a, [wBillsPC_CursorPos]
	sub $10
	ret c

	ld b, a
	and $f
	; Column 0-1 is party
	cp 2
	jr c, .party

	; Otherwise we're checking storage
	; With existing $yx row 0-4 col 2-5, we want to get y*4+x-1.
	ld c, a
	ld a, b
	swap a
	and $f
	add a
	add a
	add c
	dec a
	ld c, a
	ld a, [wCurBox]
	inc a
	ld b, a
	ret
.party
	; With existing $yx row 2-4 col 0-1, we want to get y*2+x-3.
	ld c, a
	ld a, b
	swap a
	and $f
	add a
	add c
	sub 3
	ld c, a
	ld b, 0
	ret

BillsPC_SetBoxArrows:
	ld a, [wBillsPC_CursorPos]
	cp $10
	jr c, .box_cursors

	; Clear box switch arrows.
	ld a, " "
	hlcoord 8, 5
	ld [hl], a
	hlcoord 18, 5
	ld [hl], a
	xor a
	ret

.box_cursors
	hlcoord 8, 5
	ld [hl], "◀"
	hlcoord 18, 5
	ld [hl], "▶"
	ret

BillsPC_Withdraw:
	ld b, 0
	jr MoveCurMonToBox

BillsPC_Deposit:
	ld a, [wCurBox]
	inc a
	ld b, a
	; fallthrough
MoveCurMonToBox:
	push bc
	call BillsPC_GetCursorSlot
	ld d, b
	ld e, c
	pop bc
	ld c, 0
	call BillsPC_SwapStorage
	ret nz
	ld a, 1
	ldh [rVBK], a
	ldh a, [hBGMapMode]
	push af
	xor a
	ldh [hBGMapMode], a
	call SetPartyIcons
	call SetBoxIcons
	pop af
	ldh [hBGMapMode], a
	xor a
	ldh [rVBK], a
	; fallthrough
GetCursorMon:
; Prints data about Pokémon at cursor if nothing is held (underline to force).
; Returns z if cursor is on an empty pkmn slot.
	; Only handle box arrows if we're holding a mon
	ld a, [wBillsPC_CursorHeldSlot]
	and a
	jr z, _GetCursorMon

	call BillsPC_UpdateCursorLocation
	jr BillsPC_SetBoxArrows

_GetCursorMon:
	call BillsPC_UpdateCursorLocation

	; Check if cursor is currently hovering over a mon.
	call BillsPC_GetCursorSlot
	jr c, .clear

	call GetStorageBoxMon
	jr nz, .not_clear
	ld a, -1
	ld [wVirtualOAM + 64], a
	; fallthrough
.clear
	; Clear existing data

	; Clear nickname+species+icon
	hlcoord 7, 0
	lb bc, 4, 13
	call ClearBox

	; Clear pokepic
	hlcoord 0, 0
	lb bc, 9, 7
	call ClearBox
	call BillsPC_SetBoxArrows
	ld a, [wBillsPC_CursorPos]
	cp $10
	jp c, .reset_item
	xor a
	ret
.reset_item
	ld a, -1
	ld [wVirtualOAM + 64], a
	or 1
	ret

.not_clear
	; Prepare frontpic. Split into decompression + loading to make sure we
	; refresh the pokepic and the palette in a single frame (decompression
	; is unpredictable, but bpp copy can be relied upon).
	ld a, [wTempMonSpecies]
	ld hl, wTempMonForm
	ld de, vTiles2
	push de
	push af
	predef GetVariant
	ld a, [wTempMonIsEgg]
	ld d, a
	pop af
	bit MON_IS_EGG_F, d
	jr z, .not_egg
	ld a, EGG
.not_egg
	ld [wCurPartySpecies], a
	ld [wCurSpecies], a
	call GetBaseData
	pop de
	farcall PrepareFrontpic

	push hl
	ld a, "@"
	ld [wStringBuffer2], a
	ld a, [wTempMonItem]
	and a
	jr z, .no_item
	ld [wNamedObjectIndexBuffer], a
	call GetItemName
	ld hl, wStringBuffer1
	ld de, wStringBuffer2
	ld bc, ITEM_NAME_LENGTH
	rst CopyBytes

.no_item
	; Delay first before finishing frontpic
	call DelayFrame
	ld a, [wAttrMap]
	and TILE_BANK
	pop hl
	push af
	ld a, 0
	jr nz, .dont_switch_vbk
	ld a, 1
	ld [rVBK], a
.dont_switch_vbk
	farcall GetPreparedFrontpic
	xor a
	ld [rVBK], a
	ld hl, wBillsPC_ItemVWF
	ld bc, 10 tiles
	xor a
	push hl
	rst ByteFill
	pop hl
	ld de, wStringBuffer1
	ld a, [wTempMonItem]
	and a
	call nz, PlaceVWFString
	call DelayFrame

	ld a, 1
	ld [rVBK], a
	ld hl, vTiles2 tile $31
	ld de, wBillsPC_ItemVWF
	ld c, 10
	call Get2bpp
	xor a
	ld [rVBK], a

	pop af
	ld a, 2
	jr nz, .got_new_tile_bank
	ld a, 2 | TILE_BANK
.got_new_tile_bank
	hlcoord 0, 0, wAttrMap
	lb bc, 7, 7
	call FillBoxWithByte

	; Colors
	ld bc, wTempMonPersonality
	ld a, [wTempMonSpecies]
	farcall GetMonNormalOrShinyPalettePointer
	ld de, wBillsPC_PokepicPal
	ld b, 4
.loop
	ld a, BANK(PokemonPalettes)
	call GetFarByte
	inc hl
	ld [de], a
	inc de
	dec b
	jr nz, .loop

	; Show or hide item icon
	ld hl, wVirtualOAM + 64
	ld a, [wTempMonItem]
	and a
	ld [hl], -1
	jr z, .item_icon_done

	ld [hl], 40
	inc hl
	ld [hl], 72
	inc hl
	inc hl
	ld [hl], 0
	dec hl
	ld [hl], 4
	call ItemIsMail
	jr c, .item_icon_done
	inc [hl]
.item_icon_done

	ld b, 0
	call SafeCopyTilemapAtOnce

	; Clear text
	call .clear

	; Poképic tilemap
	hlcoord 0, 0
	farcall PlaceFrontpicAtHL

	; Nickname
	hlcoord 8, 0
	ld de, wTempMonNickname
	call PlaceString

	; If we're dealing with an egg, we're done now.
	ld a, [wTempMonIsEgg]
	bit MON_IS_EGG_F, a
	ret nz

	; Species name
	ld a, [wTempMonSpecies]
	ld [wNamedObjectIndexBuffer], a
	hlcoord 8, 1
	ld a, "/"
	ld [hli], a
	call GetPokemonName
	ld de, wStringBuffer1
	call PlaceString

	; Level
	hlcoord 0, 8
	call PrintLevel

	; Gender
	ld a, TEMPMON
	ld [wMonType], a
	farcall GetGender
	jr c, .genderless
	hlcoord 4, 8
	ld a, $41
	jr nz, .male
	; female
	inc a
.male
	ld [hl], a
.genderless

	; Item
	hlcoord 10, 3
	ld a, $31
	ld b, 10
.item_loop
	ld [hli], a
	inc a
	dec b
	jr nz, .item_loop
.ret_nz
	or 1
	ret

ManageBoxes:
; Main box management function
.loop
	call BillsPC_UpdateCursorLocation
	call DelayFrame
	call JoyTextDelay
.redo_input
	ldh a, [hJoyPressed]
	ld hl, wInputFlags
	rrca
	jp c, .pressed_a
	rrca
	jp c, .pressed_b
	rrca
	jp c, .pressed_select
	rrca
	jp c, .pressed_start
	rrca
	jp c, .pressed_right
	rrca
	jp c, .pressed_left
	rrca
	jp c, .pressed_up
	rrca
	jp c, .pressed_down
	jr .loop
.pressed_a
	; If we're holding a mon, try to place it in the current cursor location.
	ld a, [wBillsPC_CursorHeldSlot]
	and a
	jr z, .nothing_held_a
	call BillsPC_PlaceHeldMon ; might not do anything
	jr .loop

.nothing_held_a
	; Check if this slot is empty.
	call GetCursorMon
	jr z, .loop

	; check if we're on top row (hovering over box name)
	ld a, [wBillsPC_CursorPos]
	cp $10
	ld hl, .BoxMenu
	jr c, .got_menu

	; If we're in cursor mode 0, open a menu.
	ld a, [wBillsPC_CursorMode]
	and a
	jr z, .prepare_menu

	; Otherwise, either pick the mon up...
	dec a
	push af
	call z, BillsPC_Switch
	pop af

	; ...or pickup the item.
	call nz, BillsPC_MoveItem
	jr .loop

.prepare_menu
	; check if we're in party or storage
	and $f
	cp $2
	ld hl, .PartyMonMenu
	jr c, .got_menu

	; hide the cursor
	call BillsPC_HideCursor
	ld hl, .StorageMonMenu
.got_menu
	ld b, 1
	call BillsPC_Menu
	jr .loop

.pressed_b
	; If we're holding a mon, abort the selection.
	ld a, [wBillsPC_CursorHeldSlot]
	and a
	jr z, .nothing_held_b
	call BillsPC_AbortSelection
	jr .loop

.nothing_held_b
	; Prompt if we want to exit Box operations or not.
	call BillsPC_HideCursor
	ld hl, .ContinueBoxUse
	call MenuTextbox
	call YesNoBox
	push af
	call BillsPC_UpdateCursorLocation
	call CloseWindow
	pop af
	ret c
	jp .loop

.pressed_select
	; Don't allow modeswitch from/to mode 2 if holding something.
	ld a, [wBillsPC_CursorHeldSlot]
	and a
	ld a, [wBillsPC_CursorMode]
	jr z, .not_holding_anything
	cp 2
	jp z, .loop
	xor 1
	jr .got_new_mode
.not_holding_anything
	inc a
	cp 3
	jr nz, .got_new_mode
	xor a
.got_new_mode
	call BillsPC_SetCursorMode
	jp .loop

.pressed_start
	; Immediately leave the storage system (TODO: Maybe allow searching?)
	ret

.pressed_right
	ld a, [wBillsPC_CursorPos]
	cp $10
	jr nc, .regular_right
	ld a, [wCurBox]
	inc a
	jr .new_box

.regular_right
	; Move right, wrapping around
	inc a ; 6 columns, CursorPosValid fixes up final column 6+
	and LOW(~$8)
	jr .new_cursor_pos

.pressed_left
	ld a, [wBillsPC_CursorPos]
	cp $10
	jr nc, .regular_left
	ld a, [wCurBox]
	add NUM_BOXES - 1
	; fallthrough
.new_box
	cp NUM_BOXES
	jr c, .valid_box
	sub NUM_BOXES
.valid_box
	ld [wCurBox], a
	call SetBoxName
	call Delay2
	ldh a, [hBGMapMode]
	push af
	xor a
	ldh [hBGMapMode], a
	ld a, 1
	ldh [rVBK], a
	call SetBoxIcons
	xor a
	ldh [rVBK], a
	pop af
	ldh [hBGMapMode], a
	jp .loop

.regular_left
	; Move left, wrapping around
	or $8 ; 6 columns, CursorPosValid fixes up final column 6+
	dec a
	and LOW(~$8)
	jr .new_cursor_pos

.pressed_up
	ld a, [wBillsPC_CursorPos]
	sub $10
	jr .new_cursor_pos
.pressed_down
	ld a, [wBillsPC_CursorPos]
	add $10
	; fallthrough
.new_cursor_pos
	ld [wBillsPC_CursorPos], a
	call BillsPC_CursorPosValid
	jp nz, .redo_input
	call GetCursorMon
	jp .loop

.ContinueBoxUse:
	text "Continue Box"
	line "operations?"
	done

.StorageMonMenu:
	db $40 ; flags
	db 02, 09 ; start coords
	db 17, 19 ; end coords
	dw .StorageMenuData2
	db 1 ; default option

.StorageMenuData2:
	db $20 ; flags
	db 0 ; items
	dw .storageitems
	dw PlaceMenuStrings
	dw BillsPC_MenuStrings

.PartyMonMenu:
	db $40 ; flags
	db 02, 10 ; start coords
	db 17, 19 ; end coords
	dw .PartyMenuData2
	db 1 ; default option

.PartyMenuData2:
	db $20 ; flags
	db 0 ; items
	dw .partyitems
	dw PlaceMenuStrings
	dw BillsPC_MenuStrings

.BoxMenu:
	db $40 ; flags
	db 10, 07 ; start coords
	db 17, 19 ; end coords
	dw .BoxMenuData2
	db 1 ; default option

.BoxMenuData2:
	db $20 ; flags
	db 0 ; items
	dw .boxitems
	dw PlaceMenuStrings
	dw BillsPC_MenuStrings

.storageitems
	db 7
	db BOXMENU_WITHDRAW
	db BOXMENU_STATS
	db BOXMENU_SWITCH
	db BOXMENU_MOVES
	db BOXMENU_ITEM
	db BOXMENU_RELEASE
	db BOXMENU_CANCEL
	db -1

.partyitems
	db 7
	db BOXMENU_DEPOSIT
	db BOXMENU_STATS
	db BOXMENU_SWITCH
	db BOXMENU_MOVES
	db BOXMENU_ITEM
	db BOXMENU_RELEASE
	db BOXMENU_CANCEL
	db -1

.boxitems
	db 3
	db BOXMENU_SWITCHBOX
	db BOXMENU_RENAME
	db BOXMENU_CANCEL
	db -1

BillsPC_MenuStrings:
	db "Cancel@"
	; pokémon management options
	db "Withdraw@"
	db "Deposit@"
	db "Stats@"
	db "Switch@"
	db "Moves@"
	db "Item@"
	db "Release@"
	; box options
	db "Switch box@"
	db "Rename@"
	; holds and item
	db "Move@"
	db "Bag@"
	; doesn't hold an item
	db "Give@"

BillsPC_MenuJumptable:
	dw DoNothing
	dw BillsPC_Withdraw
	dw BillsPC_Deposit
	dw BillsPC_Stats
	dw BillsPC_Switch
	dw BillsPC_Moves
	dw BillsPC_Item
	dw BillsPC_Release
	dw BillsPC_SwitchBox
	dw BillsPC_Rename
	dw BillsPC_MoveItem
	dw BillsPC_BagItem
	dw BillsPC_GiveItem

BillsPC_Stats:
	ld hl, rIE
	res LCD_STAT, [hl]

	farcall _OpenPartyStats
	jp BillsPC_RestoreUI

BillsPC_CursorPick1:
; Plays the first part of the cursor pickup animation
	ld hl, wBillsPC_CursorAnimFlag
	ld a, [hl]
	cp PCANIM_ANIMATE / 2 + 1
	ld a, PCANIM_PICKUP + 1
	sbc 0
	ld [hl], a
	ld [wBillsPC_CursorAnimFlag], a
.pick_loop
	call BillsPC_UpdateCursorLocation
	call DelayFrame
	ld a, [hl]
	cp PCANIM_PICKUP_NEXT
	ret z
	inc [hl]
	jr .pick_loop

BillsPC_CursorPick2:
; Plays the second part of the cursor pickup animation. Stops at regular bop.
; Just write PCANIM_STATIC to [hl] afterwards if this isn't what you want.
	ld hl, wBillsPC_CursorAnimFlag

	; Skip first delay since we already did one at the end of CursorPick1.
	jr .start_loop
.pick_loop2
	call BillsPC_UpdateCursorLocation
	call DelayFrame
.start_loop
	dec [hl]
	ld a, [hl]
	cp PCANIM_PICKUP
	jr nc, .pick_loop2
	ret ; [hl] is now PCANIM_ANIMATE.

BillsPC_Switch:
; Pick up mon for movement.
	; Mark current cursor slot for movement.
	call BillsPC_GetCursorSlot
	ld a, b
	ld [wBillsPC_CursorHeldBox], a
	ld a, c
	ld [wBillsPC_CursorHeldSlot], a

	push bc
	call BillsPC_CursorPick1

	; Update pal for the cursor mini, in case we pick it up.
	ld a, [wTempMonSpecies]
	ld hl, wTempMonPersonality
	farcall _GetMonIconPalette
	ld de, wOBPals1 palette PAL_MINI_ICON
	farcall SetPartyMenuPal
	call BillsPC_SetOBPals

	; Write mini graphics to cursor sprite area
	ld a, 1
	ld [rVBK], a
	ld a, [wTempMon]
	ld [wCurIcon], a
	ld a, [wTempMonForm]
	ld [wCurIconForm], a
	ld a, 8
	farcall GetStorageIcon_a

	; Blank the mini in the box/party itself
	pop bc
	inc b
	dec b
	ld hl, vTiles4 tile $00
	jr z, .got_tile_pointer
	ld hl, vTiles4 tile $18
.got_tile_pointer
	ld b, 0
	dec c
	ld a, 4 tiles
	rst AddNTimes
	ld a, 1
	call BillsPC_BlankTiles

	xor a
	ld [rVBK], a

	call BillsPC_CursorPick2
	ld [hl], PCANIM_STATIC
	ret

BillsPC_AbortSelection:
; Deselects the mon currently held, moving it to where it was prior.
	xor a
	ld [wBillsPC_CursorHeldBox], a
	ld [wBillsPC_CursorHeldSlot], a

	; Blank the cursor sprite
	ld a, 1
	ldh [rVBK], a
	ld hl, vTiles3 + 8 tiles
	call BillsPC_BlankTiles

	; Ensure that the icon is returned, if in party/current Box.
	ldh a, [hBGMapMode]
	push af
	xor a
	ldh [hBGMapMode], a
	call _SetPartyIcons
	call _SetBoxIcons
	pop af
	ldh [hBGMapMode], a
	ld a, PCANIM_ANIMATE
	ld [wBillsPC_CursorAnimFlag], a

	xor a
	ldh [rVBK], a
	ret

BillsPC_Moves:
	ld hl, rIE
	res LCD_STAT, [hl]

	call LoadStandardMenuHeader
	call ClearSprites
	farcall _ManagePokemonMoves
	call ExitMenu
	jp BillsPC_RestoreUI

BillsPC_GetStorageSpace:
; Forces game save until we have at least a free pokedb entries left.
; Returns nz if we abort the prompt with insufficient storage space left.
	ld b, a
.loop
	ld a, b
	push bc
	farcall EnsureStorageSpace
	pop bc
	ret z

	push bc
	ld hl, BillsPC_MustSaveToContinue
	call MenuTextbox
	call YesNoBox
	push af
	jr c, .menutext_abort
	farcall ForceGameSave
	ld hl, BillsPC_GameSaved
	call PrintText
	; fallthrough
.menutext_abort
	call BillsPC_UpdateCursorLocation
	call CloseWindow
	pop af
	pop bc
	jr nc, .loop
	or 1
	ret

BillsPC_GiveItem:
	ret

BillsPC_MoveItem:
	ret

BillsPC_BagItem:
	; If we're dealing with a Box mon, we must have at least 1 free pokedb
	; entry.
	call BillsPC_GetCursorSlot
	ld a, b
	and a
	jr z, .entries_not_full

	ld a, 1
	call BillsPC_GetStorageSpace
	ret nz

.entries_not_full
	ld a, [wTempMonItem]
	ld [wCurItem], a
	ld a, 1
	ld [wItemQuantityChangeBuffer], a
	ld hl, wNumItems
	call ReceiveItem
	ld hl, .PackFullText
	jr nc, .print
	xor a
	ld [wTempMonItem], a
	farcall UpdateStorageBoxMonFromTemp
	call GetCursorMon
	ld hl, .MovedToPackText
.print
	call MenuTextbox
	call BillsPC_UpdateCursorLocation
	jp CloseWindow

.PackFullText:
	text "The Pack is full…"
	prompt

.MovedToPackText:
	text "Moved item to Bag."
	prompt


BillsPC_Menu:
; hl: menu data header, b: amount of menus to close
	inc b
	push bc
	call LoadMenuHeader
	xor a
	ld [wWhichIndexSet], a
	call DoNthMenu
	pop bc
	push af
	push bc
	call BillsPC_UpdateCursorLocation
.closemenu_loop
	pop bc
	dec b
	jr z, .menus_closed
	push bc
	call CloseWindow
	jr .closemenu_loop
.menus_closed
	pop af
	ret c
	ld a, [wMenuSelection]
	ld hl, BillsPC_MenuJumptable
	jp JumpTable

BillsPC_Item:
	call BillsPC_HideCursor
	ld a, [wTempMonItem]
	and a
	ld hl, .ItemIsSelected
	ld de, .ItemMenu
	jr nz, .got_menu
	ld hl, .ItCanHoldAnItem
	ld de, .NoItemMenu
.got_menu
	push de
	call MenuTextbox
	pop hl
	ld b, 2
	jp BillsPC_Menu

.ItemIsSelected:
	text_from_ram wStringBuffer2
	text " is"
	line "selected."
	done

.ItCanHoldAnItem:
	text_from_ram wTempMonNickname
	text " can"
	line "hold an item."
	done

.ItemMenu:
	db $40 ; flags
	db 05, 11 ; start coords
	db 12, 19 ; end coords
	dw .ItemMenuData
	db 1 ; default option

.ItemMenuData:
	db $20 ; flags
	db 3 ; items
	dw .items
	dw PlaceMenuStrings
	dw BillsPC_MenuStrings

.NoItemMenu:
	db $40 ; flags
	db 07, 11 ; start coords
	db 12, 19 ; end coords
	dw .NoItemMenuData
	db 1 ; default option

.NoItemMenuData:
	db $20 ; flags
	db 2 ; items
	dw .noitems
	dw PlaceMenuStrings
	dw BillsPC_MenuStrings

.items
	db 3
	db BOXMENU_MOVEITEM
	db BOXMENU_BAGITEM
	db BOXMENU_CANCEL
	db -1

.noitems
	db 2
	db BOXMENU_GIVEITEM
	db BOXMENU_CANCEL
	db -1

BillsPC_Release:
BillsPC_SwitchBox:
BillsPC_Rename:
	ret

BillsPC_GetCursorFromTo:
; Returns source (held mon) in de and destination (cursor location) in bc.
	call BillsPC_GetCursorHeldSlot
	ld d, b
	ld e, c
	jp BillsPC_GetCursorSlot

BillsPC_SwapStorage:
; Swaps slots bc and de. Returns z on success.
	push de
	push bc

	; Try to swap slots bc and de and interpret result.
	call SwapStorageBoxSlots
	and a
	jr z, .done
	sub 2
	ld hl, BillsPC_MustSaveToContinue
	jr c, .swap_failed
	ld hl, .PartyIsFull
	jr z, .swap_failed
	ld hl, .BoxIsFull
	dec a
	jr z, .swap_failed
	ld hl, .LastPartyMon
	dec a
	jr z, .swap_failed
	ld hl, .IsHoldingMail
	; fallthrough
.swap_failed
	; Print error message
	push af
	call MenuTextbox
	pop af

	; On carry, we got a confirmation prompt which re-runs this on "yes".
	jr nc, .menutext_abort

	call YesNoBox
	jr c, .menutext_abort

	; Just re-run this function.
	farcall ForceGameSave
	ld hl, BillsPC_GameSaved
	call PrintText
	call BillsPC_UpdateCursorLocation
	call CloseWindow
	pop bc
	pop de
	jr BillsPC_SwapStorage
.menutext_abort
	call BillsPC_UpdateCursorLocation
	call CloseWindow
.abort
	or 1
.done
	pop bc
	pop de
	ret

.PartyIsFull:
	text "The party is full."
	prompt

.BoxIsFull:
	text "The box is full."
	prompt

.LastPartyMon:
	text "That's your last"
	line "healthy #mon!"
	prompt

.IsHoldingMail:
	text "Held Mail must be"
	line "remove first."
	prompt

BillsPC_MustSaveToContinue:
	text "Save the game to"
	line "do this?"
	done

BillsPC_GameSaved:
	text_jump _SavedTheGameText
	text_end

BillsPC_PlaceHeldMon:
; Places held mon at the current cursor location. Might perform swaps, or even
; be aborted, depending on circumstances.
	; Get source in de and destination in bc.
	call BillsPC_GetCursorFromTo

	; Try to swap slots bc and de and interpret result.
	call BillsPC_SwapStorage
	ret nz

	; TODO: graphics
	ret

BillsPC_SetOBPals:
; Sets object palettes. Plays nice with PC hblank interrupt.
	ld a, BANK("GBC Video")
	call StackCallInWRAMBankA
.Function:
	; Wait until a hblank we can make use of.
	ld c, LOW(rLY)
	ld d, 8
.busyloop
	ld a, [c]
	cp d
	jr nz, .busyloop
	; The double inc here is intentional, just in case of a badly timed hblank.
	inc d
	inc d
	di
.busyloop2
	ld a, [c]
	cp d
	jr nz, .busyloop2
	ld a, $80
	ldh [rOBPI], a
	ld hl, wOBPals1
	ld e, 8 ; amount of palettes
	inc d
.busyloop3
	ld a, [c]
	cp d
	jr nz, .busyloop3

	ld c, LOW(rOBPD)

rept 8
	ld a, [hli]
	ld [c], a
endr

	ld c, LOW(rLY)
	inc d
	dec e
	jr nz, .busyloop3
	reti

BillsPC_RestoreUI:
	call ClearSprites
	call ClearSpriteAnims

	ld hl, rIE
	set LCD_STAT, [hl]

	call BillsPC_LoadUI
	call GetCursorMon

	ld a, CGB_BILLS_PC
	call GetCGBLayout
	call SetPalettes
	ld a, 1
	ldh [hBGMapMode], a
	ret

BillsPC_CursorPosValid:
; Returns z if the cursor position is valid
	; Check for columns beyond 5
	ld b, a
	and $f
	cp 6
	jr nc, .invalid

	; Check for party rows less than 3
	cp 2
	jr nc, .not_party
	ld a, b
	cp $30
	jr c, .invalid

.not_party
	; Check for rows beyond 5
	ld a, b
	cp $60
	jr c, .valid
.invalid
	or 1
	ld a, b
	ret
.valid
	xor a
	ld a, b
	ret
