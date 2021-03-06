	; Object palettes
	const_def 1
	const PAL_CURSOR_MODE1
	const PAL_CURSOR_MODE2
	const PAL_MINI_ICON

	; Cursor modes
	const_def
	const PC_MENU_MODE ; 0
	const PC_MOVE_MODE ; 1
	const PC_ITEM_MODE ; 2

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
	ldh [rVBK], a

	; Reserve 4 blank tiles for empty slots
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

	; Load cursor tiles.
	ld de, BillsPC_CursorGFX
	ld hl, vTiles3 tile $04
	lb bc, BANK(BillsPC_CursorGFX), 2
	call Get2bpp

	; Blank held cursor mini + item icons.
	ld hl, vTiles3 tile $08
	ld a, 7 ; cursor+quick mini/shadow/item + hover item icon
	call BillsPC_BlankTiles

	call BillsPC_BlankCursorItem

	; Held item icon
	ld hl, vTiles3 tile $1c
	ld de, HeldItemIcons
	lb bc, BANK(HeldItemIcons), 2
	call Get2bpp

	xor a
	ldh [rVBK], a

	; Cursor sprite OAM
	lb de, 38, 16
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
	ld hl, BillsPC_TileGFX
	ld de, vTiles2 tile $31
	lb bc, BANK(BillsPC_TileGFX), 15
	call DecompressRequest2bpp

	; Set up background + outline palettes
	xor a
	ld [wBillsPC_PreserveCursorPal], a
	; fallthrough
BillsPC_RefreshTheme:
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

	call BillsPC_LoadUI

	xor a ; PC_MENU_MODE
	call BillsPC_SetCursorMode

	; Default cursor data (top left of storage, not holding anything)
	ld a, $12
	ld [wBillsPC_CursorPos], a
	xor a
	ld [wBillsPC_CursorHeldSlot], a

	ld a, 1
	ldh [rVBK], a

	; Pokepic attributes
	hlcoord 0, 0, wAttrMap
	lb bc, 7, 7
	ld a, 2
	call FillBoxWithByte

	; Item name is in vbk1
	hlcoord 10, 2, wAttrMap ; Cursor's item
	ld bc, 10
	ld a, TILE_BANK
	push bc
	rst ByteFill
	pop bc
	hlcoord 10, 3, wAttrMap ; Mon's item
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

BillsPC_CursorGFX:
INCBIN "gfx/pc/cursor.2bpp"

BillsPC_TileGFX:
INCBIN "gfx/pc/pc.2bpp.lz"

BillsPC_BlankTiles:
; Used as input to blank a*4 tiles (mon icons typically use 4 tiles).
	ld de, vTiles3 tile $00 ; Reserved blank tiles.
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
	call _BillsPC_SetCursorMode
	jp BillsPC_SetOBPals

_BillsPC_SetCursorMode:
; Switches cursor mode and updates the cursor palette. Doesn't write palettes,
; use the non-underscore version of this to do that.
	ld [wBillsPC_CursorMode], a
	ld a, BANK("GBC Video")
	call StackCallInWRAMBankA
.Function:
	; hl = .CursorPals + [wBillsPC_CursorMode] * 4
	ld a, [wBillsPC_CursorMode]
	add a
	add a
	add LOW(.CursorPals)
	ld l, a
	adc HIGH(.CursorPals)
	sub l
	ld h, a
	ld de, wOBPals1 palette PAL_CURSOR_MODE1 + 4
	ld a, [hli]
	ld [de], a
	inc de
	ld a, [hli]
	ld [de], a
	ld de, wOBPals1 palette PAL_CURSOR_MODE2 + 4
	ld a, [hli]
	ld [de], a
	inc de
	ld a, [hl]
	ld [de], a
	ret

.CursorPals:
; PC_MENU_MODE = red
if !DEF(MONOCHROME)
	RGB 31, 20, 20
	RGB 31, 10, 06
else
	MONOCHROME_RGB_TWO
endc
; PC_MOVE_MODE = blue
if !DEF(MONOCHROME)
	RGB 20, 20, 31
	RGB 06, 10, 31
else
	MONOCHROME_RGB_TWO
endc
; PC_ITEM_MODE = green
if !DEF(MONOCHROME)
	RGB 20, 28, 20
	RGB 06, 26, 10
else
	MONOCHROME_RGB_TWO
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

BillsPC_PrintBoxName:
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
	call BillsPC_PrintBoxName
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
	; Don't draw mons we're holding.
	ld a, [wBillsPC_CursorHeldBox]
	cp b
	jr nz, .not_holding
	ld a, [wBillsPC_CursorHeldSlot]
	cp c
	jr z, .blank
.not_holding
	call GetStorageBoxMon
	jr z, .blank
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
	ld [hli], a
	ld a, e
	push hl
	push de
	push bc
	farcall GetStorageIcon_a
	pop bc
	pop de
	pop hl
	call WriteIconPaletteData
	jr .next

.blank
	; Fill storage species slot with a blank species.
	xor a
	ld [hli], a
	ld [hli], a

.next
	ld a, e
	add 4
	ld e, a
	inc c
	dec d
	jr nz, PCIconLoop
	ret

BillsPC_GetMonPalAddr:
; Gets mon pal in hl for box b slot c.
	push de
	push bc
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
	pop bc
	pop de
	ret

WriteIconPaletteData:
; Write box slot c's palette data. If b is zero, write party palette instead.
; (This is the same input as various "box mon data" functions).
	push hl
	push de
	push bc
	ld a, [wTempMonIsEgg]
	bit MON_IS_EGG_F, a
	ld a, [wTempMonSpecies]
	jr z, .got_species
	ld a, EGG
.got_species
	ld hl, wTempMonPersonality
	farcall _GetMonIconPalette
	pop bc
	push bc
	push af
	call BillsPC_GetMonPalAddr

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
	ld de, wStringBuffer3
	ld bc, 4
	rst CopyBytes
	farcall PlaySpriteAnimations
	ld hl, wStringBuffer3
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
	ret nz ; failed

	; Perform movement animation.
	ld c, a
	push de
	ld d, b
	ld e, c
	pop bc
	push bc
	call BillsPC_PerformQuickAnim
	pop bc
	; fallthrough
CheckPartyShift:
; Shifts entries around to ensure there are no blank party entries.
; This is a purely graphical effect, internal PC functions has already
; taken care of any blank spots data-wise.
	xor a
	ld e, a
	ld d, a
	ld b, a
.outer_loop
	ld a, e
	inc e
	cp PARTY_LENGTH - 1
	ret z
	call .CheckBlankIcon
	jr nz, .outer_loop
	ld c, e
.inner_loop
	ld a, c
	inc c
	cp PARTY_LENGTH
	ret z
	call .CheckBlankIcon
	jr z, .inner_loop

	; Found icon to swap
	push de
	push bc
	call BillsPC_PerformQuickAnim
	pop bc
	pop de
	jr .outer_loop

.CheckBlankIcon:
	; a = [wBillsPC_PartyList + a * 2]
	add a
	add LOW(wBillsPC_PartyList)
	ld l, a
	adc HIGH(wBillsPC_PartyList)
	sub l
	ld h, a
	ld a, [hl]
	and a
	ret

GetCursorMon:
; Prints data about Pokémon at cursor if nothing is held (underline to force).
; Returns z if cursor is on an empty pkmn slot.
	; Only handle box arrows if we're holding a mon
	call BillsPC_GetCursorHeldSlot
	bit 7, b
	jr nz, _GetCursorMon
	inc c
	dec c
	jr z, _GetCursorMon

	call BillsPC_UpdateCursorLocation
	; fallthrough
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

	; Clear nickname+species+icon. Leave 3rd row (held item) alone.
	hlcoord 7, 0
	lb bc, 2, 13
	call ClearBox
	hlcoord 11, 0
	lb bc, 1, 13
	call ClearBox

	; Clear pokepic + level/gender
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
	call GetMonItemUnlessCursor
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
	ldh [rVBK], a
.dont_switch_vbk
	farcall GetPreparedFrontpic
	xor a
	ldh [rVBK], a
	ld hl, wBillsPC_ItemVWF
	ld bc, 10 tiles
	xor a
	push hl
	rst ByteFill
	pop hl
	ld de, wStringBuffer1
	call GetMonItemUnlessCursor
	push af
	call nz, PlaceVWFString
	call DelayFrame

	ld a, 1
	ldh [rVBK], a
	ld hl, vTiles5 tile $31
	ld de, wBillsPC_ItemVWF
	ld c, 10
	call Get2bpp
	pop af
	and a
	ld de, vTiles3 tile $00
	jr z, .got_item_tile
	ld d, a
	call ItemIsMail
	ld de, vTiles3 tile $1c
	jr c, .got_item_tile
	ld de, vTiles3 tile $1d
.got_item_tile
	ld hl, vTiles3 tile $20
	ld c, 1
	call Get2bpp
	xor a
	ldh [rVBK], a

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
	ld a, [wTempMonIsEgg]
	bit MON_IS_EGG_F, a
	ld a, EGG
	jr nz, .egg
	ld a, [wTempMonSpecies]
.egg
	farcall GetMonNormalOrShinyPalettePointer
	ld de, wBillsPC_PokepicPal
	push de
	ld b, 4
.loop
	ld a, BANK(PokemonPalettes)
	call GetFarByte
	inc hl
	ld [de], a
	inc de
	dec b
	jr nz, .loop

	pop hl
	farcall VaryBGPalByTempMonDVs

	; Show or hide item icon
	ld hl, wVirtualOAM + 64
	call GetMonItemUnlessCursor
	ld [hl], -1
	jr z, .item_icon_done

	ld [hl], 40
	inc hl
	ld [hl], 72
	inc hl
	inc hl
	ld [hl], TILE_BANK
	dec hl
	ld [hl], $20
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
	ld c, 2
	hlcoord 10, 3
	ld a, $31
.item_loop_begin
	ld b, 10
.item_loop
	ld [hli], a
	inc a
	dec b
	jr nz, .item_loop
	hlcoord 10, 2
	dec c
	jr nz, .item_loop_begin
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

	; In item move mode, check if the mon is holding an item.
	ld a, [wBillsPC_CursorMode]
	cp PC_ITEM_MODE
	jr nz, .confirm_ok
	ld a, [wTempMonItem]
	and a
	jr z, .loop

.confirm_ok
	ld de, SFX_READ_TEXT_2
	call PlaySFX

	; check if we're on top row (hovering over box name)
	ld a, [wBillsPC_CursorPos]
	cp $10
	ld hl, .BoxMenu
	jr c, .got_menu

	; If we're in PC_MENU_MODE, open a menu.
	ld a, [wBillsPC_CursorMode]
	and a ; PC_MENU_MODE?
	jr z, .prepare_menu

	; Otherwise, either pick the mon up in PC_MOVE_MODE...
	dec a
	push af
	call z, BillsPC_Switch
	pop af

	; ...or pick up the item in PC_ITEM_MODE.
	call nz, BillsPC_MoveItem
	jr .loop

.prepare_menu
	; check if we're in party or storage
	ld a, [wBillsPC_CursorPos]
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
	jp .loop

.pressed_b
	; If we're holding a mon, abort the selection.
	ld a, [wBillsPC_CursorHeldSlot]
	and a
	jr z, .nothing_held_b
	call BillsPC_AbortSelection
	jp .loop

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
	; TODO: pick a color scheme (only needs to update BG pals 0+1)
	jp .loop

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
	ld a, 1
	ld [wBillsPC_PreserveCursorPal], a
	call BillsPC_RefreshTheme
	call BillsPC_PrintBoxName
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
	db 12, 11 ; start coords
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
	db 2
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
	db "Rename@"
	; holding an item
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

BillsPC_SetIcon:
; Writes icon tiles to hl depending on species data in de. Assumes vbk1.
	ld a, [de]
	inc de
	ld [wCurIcon], a
	ld a, [de]
	ld [wCurIconForm], a
	push hl
	call BillsPC_SetOBPals
	pop hl
	farjp GetStorageIcon

BillsPC_MoveIconData:
; Copies icon data from slot bc to slot de, then blanks slot bc.
; Box -1 is a sentinel for held (slot 0) or quick (slot 1).
; TODO: can we make this code (.GetAddr especially) less messy?
	; Copy palette data
	ldh a, [rSVBK]
	push af
	ld a, BANK(wOBPals1)
	ldh [rSVBK], a
	xor a
	ldh [hBGMapMode], a

	; Copy palette data
	call .Copy
	pop af
	ldh [rSVBK], a

	; Handle held items seperately from this point.
	call BillsPC_IsHoldingItem
	jr z, .not_holding_item

	ld a, 1
	ldh [rVBK], a

	; Check if we're loading or unloading the icon
	ld a, [wBillsPC_QuickFrames]
	and a
	ld de, vTiles3 tile $00 ; Blank.
	jr z, .got_item_tile
	ld a, b
	inc a
	ld de, vTiles3 tile $20 ; Item for mon cursor is hovering
	jr nz, .got_item_tile
	ld de, vTiles3 tile $10 ; Item cursor is holding.
.got_item_tile
	ld hl, vTiles3 tile $14 ; Quick tile.
	push bc
	ld c, 1
	call BillsPC_SafeGet2bpp
	call BillsPC_SetOBPals
	pop bc

	; Check if we should blank the cursor tile.
	inc b
	ld a, c
	or b
	ld hl, vTiles3 tile $10
	ld a, 1
	call z, BillsPC_BlankTiles
	jr .done

.not_holding_item
	; Copy extspecies data
	ld a, 1
	call .Copy

	; Set new icon data.
	push bc
	ld b, d
	ld c, e
	ld a, 1
	call .GetAddr
	push hl
	ld a, 2
	call .GetAddr
	pop de
	call BillsPC_SetIcon
	pop bc

	; Blank old icon data.
	ld a, 1
	call .GetAddr
	xor a
	ld [hli], a
	ld [hli], a
	ld a, 2
	call .GetAddr
	ld a, 1
	call BillsPC_BlankTiles

.done
	xor a
	ldh [rVBK], a
	inc a
	ldh [hBGMapMode], a
	ret

.Copy:
; Copies from address depending on bc and a to addr depending on de and a.
	call .GetAddr
	push bc
	push de
	push hl
	ld b, d
	ld c, e
	call .GetAddr
	ld d, h
	ld e, l
	pop hl
	and a
	ld bc, 2
	jr nz, .got_len

	call BillsPC_IsHoldingItem
	ld c, 4
	jr z, .got_len

	; If holding an item, just copy icon pal to quickmove.
	ld hl, wOBPals1 palette $0 + 2
	ld de, wOBPals1 palette $5 + 2
.got_len
	rst CopyBytes
	pop de
	pop bc
	ret

.GetAddr:
; Depending on a, set hl to an address based on box b slot c.
	push bc
	push af
	inc b
	jr z, .held
	dec b
	jr z, .party

	; Box
	and a
	jr z, .box_party_pal
	dec a
	jr z, .box_extspecies

	; Boxmon tile
	ld hl, vTiles4 tile $18
	jr .get_tile_addr

.box_extspecies
	ld hl, wBillsPC_BoxList
	jr .get_ext_addr

.party
	and a
	jr z, .box_party_pal
	dec a
	jr z, .party_extspecies

	; Party tile
	ld hl, vTiles4 tile $00
	; fallthrough
.get_tile_addr
	ld b, 4 tiles
	jr .addntimes

.box_party_pal
	call BillsPC_GetMonPalAddr
	jr .got_addr

.party_extspecies
	ld hl, wBillsPC_PartyList
	; fallthrough
.get_ext_addr
	ld b, 2
	; fallthrough
.addntimes
	ld a, c
	ld c, b
	ld b, 0
	dec a
	rst AddNTimes
	jr .got_addr

.held
	and a
	jr z, .held_pal
	dec a
	jr z, .held_extspecies

	; Held tile
	ld hl, vTiles3 tile $14
	dec c
	jr z, .got_addr
	ld hl, vTiles3 tile $08
	jr .got_addr

.held_pal
	ld hl, wOBPals1 palette $5 + 2
	dec c
	jr z, .got_addr
	ld hl, wOBPals1 palette PAL_MINI_ICON + 2
	jr .got_addr

.held_extspecies
	ld hl, wBillsPC_QuickIcon
	dec c
	jr z, .got_addr
	ld hl, wBillsPC_HeldIcon
	; fallthrough
.got_addr
	pop af
	pop bc
	ret

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
	pop bc

	; Update pal for the cursor mini, in case we pick it up.
	lb de, -1, 0
	call BillsPC_MoveIconData

	call BillsPC_CursorPick2
	ld [hl], PCANIM_STATIC
	ret

BillsPC_PrepareQuickAnim:
; Sets up a quick-move animation from bc to de.
	ld hl, wBillsPC_QuickFrom
	push bc
	push de
	call .SetQuickStruct
	pop bc
	ld hl, wBillsPC_QuickTo
	call .SetQuickStruct
	ld a, PCANIM_QUICKFRAMES
	ld [wBillsPC_QuickFrames], a
	lb de, 0, 0
	ld a, SPRITE_ANIM_INDEX_PC_QUICK
	call _InitSpriteAnimStruct
	call BillsPC_UpdateCursorLocation
	pop bc
	lb de, -1, 1
	jp BillsPC_MoveIconData

.SetQuickStruct:
	ld a, b
	ld [hli], a
	ld a, c
	ld [hli], a
	push bc
	call BillsPC_GetXYFromStorageBox
	pop bc

	; If we're dealing with a held item, we need to offset XY slightly.

	; The cursor slot uses a different Y offset.
	inc b
	ld b, 0
	jr nz, .not_cursor
	ld b, 2
.not_cursor
	call BillsPC_IsHoldingItem
	ld c, 4
	jr nz, .got_offset
	lb bc, 0, 0
.got_offset
	ld a, d
	add c
	ld [hli], a
	ld a, e
	add b
	add c
	ld [hli], a
	ret

BillsPC_GetXYFromStorageBox:
; Returns appropriate icon XY pos in de from storage box b, slot c. Includes
; a +8 pixel offset as per normal sprite positioning.
; Box -1 means held by cursor.
	inc b
	jr nz, .not_cursor

	; Cursor held mons are just offset upwards a bit.
	dec b
	push bc
	call BillsPC_GetCursorSlot
	call BillsPC_GetXYFromStorageBox
	pop bc
	ld a, e
	sub PCANIM_PICKUP_NEXT - PCANIM_PICKUP + 1
	ld e, a
	ret

.not_cursor
	res 7, b
	dec b
	jr z, .party
	ld a, c
	and a
	jr nz, .not_on_boxname
	; fallthrough
.boxname_pos
	lb de, $6c, $38
	ret

.not_on_boxname
	; We're dealing with a boxmon. If this isn't part of the current Box, return
	; boxname position since we want to simulate moving the mon towards another
	; Box.
	ld a, [wCurBox]
	inc a
	cp b
	jr nz, .boxname_pos

	; The position is within our current Box.
	ld a, 4
	lb de, $48, $48
	jr .fix_xy

.party
	ld a, 2
	lb de, $10, $68
	; fallthrough
.fix_xy
	; Fix xy depending on slot c. For every a slots, y changes by 16. Then,
	; for the remainder, x changes by 24.
	push bc
	ld b, a
	ld a, c
	dec a
.loop
	sub b
	jr c, .got_y
	push af
	ld a, e
	add 16
	ld e, a
	pop af
	jr .loop
.got_y
	add b

	; Multiply remainder by 24.
	add a ; * 2
	add a ; * 4
	add a ; * 8
	ld b, a
	add b ; * 16
	add b ; * 24
	add d
	ld d, a
	pop bc
	ret

BillsPC_PerformQuickAnim:
; Performs a synchronous quickmove animation. Used when aborting a selection or
; when doing a party shift (otherwise it's asynchronous).
	call BillsPC_PrepareQuickAnim
.loop
	call BillsPC_UpdateCursorLocation
	call DelayFrame
	ld a, [wBillsPC_QuickFrames]
	and a
	jr nz, .loop
	jp BillsPC_UpdateCursorLocation

BillsPC_FinishQuickAnim:
; Called from sprite anim code.
	push hl
	push de
	push bc

	; Verify that the destination was either the party or the current Box.
	; If the destination is another Box, just vanish the sprite.
	ld a, [wBillsPC_QuickToSlot]
	ld e, a
	ld a, [wBillsPC_QuickToBox]
	ld d, a
	and a
	jr z, .ok
	ld a, [wCurBox]
	inc a
	cp d
.ok
	lb bc, -1, 1
	call z, BillsPC_MoveIconData

	; Blank the icon. MoveIconData might have done this already, but this makes
	; sure it's handled in case we never ran that function.
	ldh a, [rVBK]
	ld b, a
	ldh a, [hBGMapMode]
	ld c, a
	push bc
	xor a
	ldh [hBGMapMode], a
	inc a
	ldh [rVBK], a
	ld hl, vTiles3 tile $14
	call BillsPC_BlankTiles
	pop bc
	ld a, b
	ldh [rVBK], a
	ld a, c
	ldh [hBGMapMode], a
	jp PopBCDEHL

BillsPC_AbortSelection:
; Deselects the mon currently held, moving it to where it was prior.
	ld a, 1
	ldh [rVBK], a

	; If we're dealing with an item, we don't need to reload any tiles.
	call BillsPC_GetCursorHeldSlot
	bit 7, b
	push bc
	call nz, BillsPC_BlankCursorItem
	pop bc

	; Ensure that the icon is returned, if in party/current Box.
	ld d, b
	ld e, c
	lb bc, -1, 0
	call BillsPC_PerformQuickAnim

	xor a
	ld [wBillsPC_CursorHeldBox], a
	ld [wBillsPC_CursorHeldSlot], a

	ld a, PCANIM_ANIMATE
	ld [wBillsPC_CursorAnimFlag], a

	xor a
	ldh [rVBK], a
	jp GetCursorMon

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
	ld hl, rIE
	res LCD_STAT, [hl]

	call LoadStandardMenuHeader
	call ClearSprites
	farcall PCGiveItem
	call ClearPalettes
	call ExitMenu
	jp BillsPC_RestoreUI

GetMonItemUnlessCursor:
; Returns mon item unless the cursor is holding it. Returns z if cursor held.
	push de
	push bc
	call .do_it
	pop bc
	pop de
	ld a, 0
	ret z
	ld a, [wTempMonItem]
	and a
	ret

.do_it
	; Figure out if we're drawing to cursor item or general held item.
	call BillsPC_GetCursorFromTo

	; d is $80 | b if it's the same box + cursor is holding an item.
	ld a, d
	sub b
	xor $80
	ret nz
	ld a, e
	cp c
	ret

BillsPC_BlankCursorItem:
; Blanks cursor item and swap icon. Assumes vbk1.
	; Blank cursor item name. Only uses 10 tiles, but this is ok.
	ld hl, vTiles5 tile $3b
	ld a, 3
	jp BillsPC_BlankTiles

BillsPC_IsHoldingItem:
; Returns nz if we're holding an item.
	push bc
	call BillsPC_GetCursorHeldSlot
	bit 7, b
	pop bc
	ret

BillsPC_MoveItem:
; Pick up item for movement.
	; Removing items might reallocate a storage mon, so check that we have space
	; for that in the database.
	call BillsPC_GetCursorSlot
	ld a, b
	and a
	jr z, .entries_not_full

	ld a, 1
	push bc
	call BillsPC_GetStorageSpace
	pop bc
	ret nz

.entries_not_full
	; Mark current cursor slot for movement.
	ld a, b
	or $80 ; Mark that we're holding an item rather than a mon.
	ld [wBillsPC_CursorHeldBox], a
	ld a, c
	ld [wBillsPC_CursorHeldSlot], a

	push bc
	call BillsPC_CursorPick1
	pop bc

	ld a, 1
	ldh [rVBK], a
	dec a
	ldh [hBGMapMode], a

	; Load held item name
	ld hl, vTiles5 tile $3b
	ld de, wBillsPC_ItemVWF
	ld c, 10
	call BillsPC_SafeGet2bpp

	; Load held item icon.
	ld hl, vTiles3 tile $10
	lb bc, BANK(HeldItemIcons), 1

	ld a, [wTempMonItem]
	ld d, a
	call ItemIsMail
	ld de, HeldItemIcons ; mail icon
	jr c, .got_item_tile
	ld de, HeldItemIcons tile 1 ; regular item icon
.got_item_tile
	call BillsPC_SafeGet2bpp

	xor a
	ldh [rVBK], a
	inc a
	ldh [hBGMapMode], a

	call GetCursorMon

	call BillsPC_CursorPick2
	ld [hl], PCANIM_STATIC
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
	ld hl, BillsPC_PackFullText
	jr nc, BillsPC_PrintText
	xor a
	ld [wTempMonItem], a
	farcall UpdateStorageBoxMonFromTemp
	call GetCursorMon
	ld hl, BillsPC_MovedToPackText
	; fallthrough
BillsPC_PrintText:
	push hl
	call BillsPC_HideCursor
	pop hl
	call MenuTextbox
	call BillsPC_UpdateCursorLocation
	jp CloseWindow

BillsPC_PackFullText:
	text "The Pack is full…"
	prompt

BillsPC_MovedToPackText:
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

	; Eggs can't be given items.
	ld a, [wTempMonIsEgg]
	bit MON_IS_EGG_F, a
	ld hl, BillsPC_EggsCantHoldItemsText
	jp nz, BillsPC_PrintText

	; Give a slightly different menu depending on whether the mon is holding
	; an item right now or not.
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

BillsPC_EggsCantHoldItemsText:
	text "Eggs can't hold"
	line "items."
	prompt

BillsPC_Release:
	; Don't allow releasing the last healthy mon.
	call BillsPC_HideCursor
	call BillsPC_GetCursorSlot
	ld a, c
	dec a
	ld [wCurPartyMon], a
	farcall CheckCurPartyMonFainted
	ld hl, BillsPC_LastPartyMon
	jr c, .print

	; Don't allow releasing Eggs.
	ld a, [wTempMonIsEgg]
	bit MON_IS_EGG_F, a
	ld hl, .CantReleaseEgg
	jr nz, .print

	; Don't allow releasing the mon if it has HMs.
	ld hl, wTempMonMoves
	ld b, NUM_MOVES
.loop
	ld a, [hli]
	and a
	jr z, .no_hms
	push hl
	push bc
	ld hl, HMMoves
	ld de, 1
	call IsInArray
	pop bc
	pop hl
	jr c, .found_hm
	dec b
	jr nz, .loop

.no_hms
	ld hl, .ReallyReleaseMon
	call MenuTextbox
	call NoYesBox
	jr c, .done

	; Copy mon nick to a string buffer, since SetStorageBoxPointer might
	; mangle wTempMon.
	ld hl, wTempMonNickname
	ld de, wStringBuffer1
	ld bc, MON_NAME_LENGTH
	rst CopyBytes

	; Then release the mon.
	call BillsPC_GetCursorSlot
	push bc
	farcall RemoveStorageBoxMon

	; Print message and reload current cursor mon.
	ld hl, .WasReleasedOutside
	call PrintText

	; TODO: dedicated blanking routine rather than writing to quickslot? To be
	; clear, we can't just use BlankTiles, because we also need to fix the icon
	; address which some UI routines use to verify whether or not the location
	; is blank.
	call .done
	pop bc
	lb de, -1, 1
	call BillsPC_MoveIconData
	call CheckPartyShift
	jp GetCursorMon

.done
	call BillsPC_UpdateCursorLocation
	jp CloseWindow

.found_hm
	ld hl, .CantReleaseHMMons
.print
	jp BillsPC_PrintText

.CantReleaseEgg:
	text "You can't release"
	line "an Egg!"
	prompt

.CantReleaseHMMons:
	text "You can't release"
	line "<PK><MN> knowing HMs!"
	prompt

.ReallyReleaseMon:
	text "Really release"
	line ""
	text_from_ram wTempMonNickname
	text "?"
	done

.WasReleasedOutside:
	text ""
	text_from_ram wStringBuffer1
	text " was"
	line "released outside."
	cont "Bye, "
	text_from_ram wStringBuffer1
	text "!"
	prompt

BillsPC_Rename:
	ld hl, rIE
	res LCD_STAT, [hl]

	call LoadStandardMenuHeader
	call ClearSprites
	ld b, 4
	ld de, wStringBuffer2
	farcall NamingScreen
	ld hl, wStringBuffer2

	; Abort if no name was entered.
	ld a, "@"
	cp [hl]
	jr z, .abort
	ld de, wStringBuffer1
	ld bc, BOX_NAME_LENGTH
	rst CopyBytes
	ld a, [wCurBox]
	inc a
	ld b, a
	farcall SetBoxName
.abort
	call ExitMenu
	call BillsPC_PrintBoxName
	jp BillsPC_RestoreUI

BillsPC_GetCursorFromTo:
; Returns source (held mon) in de and destination (cursor location) in bc.
	call BillsPC_GetCursorHeldSlot
	ld d, b
	ld e, c
	jp BillsPC_GetCursorSlot

BillsPC_SwapStorage:
; Swaps slots bc and de. Returns z on success with effective slot in a.
	call BillsPC_UpdateCursorLocation
	push de
	push bc

	; Items are handled seperately.
	call BillsPC_IsHoldingItem
	jr z, .holding_mon

	; Don't do anything if we're hovering over an empty slot or boxname.
	ld a, c
	and a
	jp z, .abort
	farcall GetStorageBoxMon
	jp z, .abort

	; If we're moving to a Box, we might need to verify that we have the db
	; space to do so. Box source has already been verified, so box->party is
	; always safe.
	ld a, b
	and a
	jr z, .entries_not_full
	ld a, d
	and $7f
	ld a, 1
	jr z, .got_space_req
	inc a
.got_space_req
	call BillsPC_GetStorageSpace
	jp nz, .abort
	pop bc
	pop de
	push de
	push bc
	; fallthrough
.entries_not_full
	; Throw out the "is item" flag.
	ld a, d
	and $7f
	ld d, a
	or b
	jr nz, .party_check_done

	; If both mons are in the party, possibly transfer Mail.
	push de
	push bc
	farcall SwapPartyMonMail
	pop bc
	pop de

.party_check_done
	; Swap items.
	push de
	push bc
	ld hl, wTempMonItem
	ld b, d
	ld c, e
	farcall GetStorageBoxMon
	ld e, [hl]
	ld a, b
	pop bc
	push af
	farcall GetStorageBoxMon
	pop af
	ld d, [hl]

	; Ensure that we're not trying to move mail into storage.

	; Check if item d is a mail about to be given to a storage mon.
	and a
	call nz, ItemIsMail
	jr c, .mail_failure
	push de

	; Check if item e is a mail about to be given to a storage mon.
	ld a, b
	ld d, e
	and a
	call nz, ItemIsMail
	jr c, .pop_de_mail_failure
	ld [hl], e
	push hl
	farcall UpdateStorageBoxMonFromTemp
	pop hl
	pop de
	pop bc
	farcall GetStorageBoxMon
	ld [hl], d
	farcall UpdateStorageBoxMonFromTemp
	xor a
	jr .done

.pop_de_mail_failure
	pop de
	; fallthrough
.mail_failure
	pop bc
	ld a, 6
	jr .failed

.holding_mon
	; Try to swap slots bc and de and interpret result.
	call SwapStorageBoxSlots
	and a
	jr nz, .failed
	ld a, c
	jr .done

.failed
	push af
	push hl
	push bc
	call BillsPC_HideCursor
	pop bc
	pop hl
	pop af
	sub 2
	ld hl, BillsPC_MustSaveToContinue
	jr c, .swap_failed
	ld hl, .PartyIsFull
	jr z, .swap_failed
	ld hl, .BoxIsFull
	dec a
	jr z, .swap_failed
	ld hl, BillsPC_LastPartyMon
	dec a
	jr z, .swap_failed
	ld hl, .IsHoldingMail
	dec a
	jr z, .swap_failed

	; Not returned by SwapStorageBoxSlots, but rather if item move failed.
	ld hl, .CantStoreMail
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
	jp BillsPC_SwapStorage
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

.IsHoldingMail:
	text "Held Mail must be"
	line "removed first."
	prompt

.CantStoreMail:
	text "Can't place Mail in"
	line "storage."
	prompt

BillsPC_LastPartyMon:
	text "That's your last"
	line "healthy #mon!"
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
	ret nz ; failed

	; If we moved it onto a box, just move the sprite to its location without
	; any placing animation.
	inc c
	dec c
	jr nz, .not_on_boxname
	push de
	ld e, a
	ld d, b
	lb bc, -1, 0
	call BillsPC_PerformQuickAnim
	pop bc
	ld a, PCANIM_ANIMATE
	ld [wBillsPC_CursorAnimFlag], a
	jr .partyshift

.not_on_boxname
	; Check if the slot is blank.
	ld a, c
	dec a
	add a
	inc b
	dec b
	ld hl, wBillsPC_PartyList
	jr z, .got_monlist
	ld hl, wBillsPC_BoxList
.got_monlist
	add l
	ld l, a
	adc h
	sub l
	ld h, a
	ld a, [hl]
	and a
	push af
	push de
	push bc
	call nz, BillsPC_PrepareQuickAnim

	call BillsPC_CursorPick1
	pop de
	lb bc, -1, 0
	call BillsPC_MoveIconData
	call BillsPC_CursorPick2
	pop bc
	pop af
.partyshift
	call CheckPartyShift
	xor a
	ld [wBillsPC_CursorHeldBox], a
	ld [wBillsPC_CursorHeldSlot], a
	ret

BillsPC_SetOBPals:
; Sets object palettes. Plays nice with PC hblank interrupt.
	lb bc, 8, %10
	farjp HBlankCopyPals

BillsPC_RestoreUI:
	call ClearSprites
	call ClearSpriteAnims

	ld a, 1
	ldh [rVBK], a

	call SetPartyIcons
	call SetBoxIconsAndName

	xor a
	ldh [rVBK], a

	; TODO: this draws the pokepic in the wrong palette for a single frame.
	; Figure out how to best avoid this.
	call BillsPC_LoadUI

	; Fixes cursor palettes.
	ld a, [wBillsPC_CursorMode]
	call _BillsPC_SetCursorMode
	call GetCursorMon
	ld b, 2
	call SafeCopyTilemapAtOnce

	ld hl, rIE
	set LCD_STAT, [hl]

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
