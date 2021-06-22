InitVerticalMenuCursor::
	farjp _InitVerticalMenuCursor

CloseWindow::
	push af
	call ExitMenu
	call ApplyTilemap
	call UpdateSprites
	pop af
	ret

ExitMenu::
	push af
	farcall _ExitMenu
	pop af
	ret

RestoreTileBackup::
	call PushWindow_MenuBoxCoordToTile
	call .copy
	call PushWindow_MenuBoxCoordToAttr
	; fallthrough

.copy
	call GetTileBackupMenuBoxDims

.row
	push bc
	push hl

.col
	ld a, [de]
	ld [hli], a
	dec de
	dec c
	jr nz, .col

	pop hl
	ld bc, SCREEN_WIDTH
	add hl, bc
	pop bc
	dec b
	jr nz, .row
	ret

GetTileBackupMenuBoxDims::
	call GetMenuBoxDims
	ld a, [wMenuFlags]
	bit 1, a
	jr z, .offsetOfOne
	inc b
	inc b
	inc c
	inc c
.offsetOfOne
	inc b
	inc c
	ret

PopWindow::
	ld b, $10
	ld de, wMenuFlags
.loop
	ld a, [hld]
	ld [de], a
	inc de
	dec b
	jr nz, .loop
	ret

GetMenuBoxDims::
	ld a, [wMenuBorderTopCoord] ; top
	ld b, a
	ld a, [wMenuBorderBottomCoord] ; bottom
	sub b
	jr nc, .positive
	cpl
.positive
	ld b, a
	ld a, [wMenuBorderLeftCoord] ; left
	ld c, a
	ld a, [wMenuBorderRightCoord] ; right
	sub c
	ld c, a
	ret nc
	cpl
	ld c, a
	ret

CopyMenuData2::
	push hl
	push de
	push bc
	push af
	ld hl, wMenuDataPointer
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld de, wMenuDataFlags
	ld bc, wMenuDataEnd - wMenuDataFlags
	rst CopyBytes
	jmp PopAFBCDEHL

GetWindowStackTop::
	ld hl, wWindowStackPointer
	ld a, [hli]
	ld h, [hl]
	ld l, a
	inc hl
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ret

PlaceVerticalMenuItems::
	call CopyMenuData2
	ld a, [wMenuDataItems]
	and a
	jmp z, SetUpVariableDataMenu
	ld hl, wMenuDataPointer
	ld a, [hli]
	ld d, [hl]
	ld e, a
	call GetMenuTextStartCoord
	call Coord2Tile ; hl now contains the tilemap address where we will start printing text.
	inc de
	ld a, [de] ; Number of items
	inc de
	ld b, a
.loop
	push bc
	rst PlaceString
	inc de
	ld bc, 2 * SCREEN_WIDTH
	add hl, bc
	pop bc
	dec b
	jr nz, .loop

	ld a, [wMenuDataFlags]
	bit 4, a
	ret z

	call MenuBoxCoord2Tile
	ld a, [de]
	ld c, a
	inc de
	ld b, $0
	add hl, bc
	rst PlaceString
	ret

MenuBox::
	call MenuBoxCoord2Tile
	call GetMenuBoxDims
	dec b
	dec c
	jmp Textbox

GetMenuTextStartCoord::
	ld a, [wMenuBorderTopCoord]
	ld b, a
	inc b
	ld a, [wMenuBorderLeftCoord]
	ld c, a
	inc c
; bit 6: if not set, leave extra room on top
	ld a, [wMenuDataFlags]
	bit 6, a
	jr nz, .bit_6_set
	inc b

.bit_6_set
; bit 7: if set, leave extra room on the left
	ld a, [wMenuDataFlags]
	bit 7, a
	ret z
	inc c
	ret

ClearMenuBoxInterior::
	call MenuBoxCoord2Tile
	ld bc, SCREEN_WIDTH + 1
	add hl, bc
	call GetMenuBoxDims
	dec b
	dec c
	jmp ClearBox

ClearWholeMenuBox::
	call MenuBoxCoord2Tile
	call GetMenuBoxDims
	inc c
	inc b
	jmp ClearBox

PushWindow_MenuBoxCoordToTile::
	bccoord 0, 0
	jr PushWindow_MenuBoxCoordToAbsolute

PushWindow_MenuBoxCoordToAttr::
	bccoord 0, 0, wAttrMap

; fallthrough
PushWindow_MenuBoxCoordToAbsolute:
	push bc
	call LoadMenuBoxCoords
	ld a, [wMenuFlags]
	bit 1, a
	jr z, .noDec
	dec b
	dec c
.noDec
	call Coord2Absolute
	pop bc
	add hl, bc
	ret

MenuBoxCoord2Tile::
	call LoadMenuBoxCoords
	; fallthrough

Coord2Tile::
; Return the address of wTileMap(c, b) in hl.
	call Coord2Absolute
	bccoord 0, 0
	add hl, bc
	ret

LoadMenuBoxCoords:
	ld a, [wMenuBorderLeftCoord]
	ld c, a
	ld a, [wMenuBorderTopCoord]
	ld b, a
	ret

MenuBoxCoord2Attr::
	call LoadMenuBoxCoords
	; fallthrough

Coord2Attr::
; Return the address of wAttrMap(c, b) in hl.
	call Coord2Absolute
	bccoord 0, 0, wAttrMap
	add hl, bc
	ret

Coord2Absolute:
; Returns the address of (c, b) as a linear tile value in hl.
	ld l, c
	ld h, 0
	ld c, b
	ld b, h
	ld a, SCREEN_WIDTH
	rst AddNTimes
	ret

CopyMenuHeader::
	ld de, wMenuHeader
	ld bc, wMenuHeaderEnd - wMenuHeader
	rst CopyBytes
	ldh a, [hROMBank]
	ld [wMenuDataBank], a
	ret

MenuTextbox::
	push hl
	call LoadMenuTextbox
	pop hl
	jmp PrintText

MenuTextboxBackup::
	call MenuTextbox
	jmp CloseWindow

LoadMenuTextbox::
	ld hl, MenuTextboxDataHeader
	jr LoadMenuHeader

LoadStandardMenuHeader::
	ld hl, StandardMenuDataHeader
	; fallthrough

LoadMenuHeader::
	call CopyMenuHeader
	jmp PushWindow

StandardMenuDataHeader:
	db $40 ; tile backup
	db 0, 0 ; start coords
	db 17, 19 ; end coords
	dw 0
	db 1 ; default option

MenuTextboxDataHeader:
	db $40 ; tile backup
	db 12, 0 ; start coords
	db 17, 19 ; end coords
	dw vTiles0
	db 0 ; default option

VerticalMenu::
	xor a
	ldh [hBGMapMode], a
	call MenuBox
	call UpdateSprites
	call PlaceVerticalMenuItems
	call ApplyTilemap
	ld a, [wMenuDataFlags]
	bit 7, a
	jr z, .cancel
	call InitVerticalMenuCursor
	call DoMenuJoypadLoop
	call MenuClickSound
	ld b, a
	ld a, [wMenuFlags]
	bit 2, a
	ld a, b
	jmp nz, GetVariableDataMenuResult
	bit 1, b
	jr z, .okay
.cancel
	scf
	ret
.okay
	and a
	ret

GetMenu2::
	call LoadMenuHeader
	call VerticalMenu
	call CloseWindow
	ld a, [wMenuCursorY]
	ret

GetYesNoBoxPosition:
	ld a, [wInPokegear]
	and a
	lb bc, SCREEN_WIDTH - 6, 7
	ret z
	dec b
	ret

NoYesBox:
; Returns c (no) or nc (yes). Doesn't mess with menu cursor.
	call GetYesNoBoxPosition
	; fallthrough
PlaceNoYesBox:
	ld hl, NoYesMenuDataHeader
	call HandleYesNoMenu
	ret c
	add 1 ; no-optimize a++|a--
	ret

YesNoBox:
; Returns c (no) or nc (yes) and sets menu cursor appropriately.
	call GetYesNoBoxPosition
	; fallthrough
PlaceYesNoBox::
	ld hl, YesNoMenuDataHeader
	call HandleYesNoMenu
	jr c, .fix_menu
	sub 1 ; no-optimize a++|a--
	ret
.fix_menu
	ld a, 2
	ld [wMenuCursorY], a
	ret

HandleYesNoMenu:
; Returns c if cancelled, otherwise $ff or $00 in a for first or second option.
	push bc
	call CopyMenuHeader
	pop bc
	ld a, b
	ld [wMenuBorderLeftCoord], a
	add 5
	ld [wMenuBorderRightCoord], a
	ld a, c
	ld [wMenuBorderTopCoord], a
	add 4
	ld [wMenuBorderBottomCoord], a
	call PushWindow
	call VerticalMenu
	push af
	ld c, 15
	call DelayFrames
	call CloseWindow
	pop af
	ret c
	ld a, [wMenuCursorY]
	dec a
	dec a
	ret

YesNoMenuDataHeader::
	db $40 ; tile backup
	db 5, 10 ; start coords
	db 9, 15 ; end coords
	dw .MenuData2
	db 1 ; default option

.MenuData2
	db $c0 ; flags
	db 2
	db "Yes@"
	db "No@"

NoYesMenuDataHeader::
	db $40 ; tile backup
	db  7, 14 ; start coords
	db 11, 19 ; end coords
	dw .MenuData2
	db 1 ; default option

.MenuData2
	db $c0 ; flags
	db 2
	db "No@"
	db "Yes@"

OffsetMenuDataHeader::
	call _OffsetMenuDataHeader
	jmp PushWindow

_OffsetMenuDataHeader::
	push de
	call CopyMenuHeader
	pop de
	ld a, [wMenuBorderLeftCoord]
	ld h, a
	ld a, [wMenuBorderRightCoord]
	sub h
	ld h, a
	ld a, d
	ld [wMenuBorderLeftCoord], a
	add h
	ld [wMenuBorderRightCoord], a
	ld a, [wMenuBorderTopCoord]
	ld l, a
	ld a, [wMenuBorderBottomCoord]
	sub l
	ld l, a
	ld a, e
	ld [wMenuBorderTopCoord], a
	add l
	ld [wMenuBorderBottomCoord], a
	ret

DoNthMenu::
	call DrawVariableLengthMenuBox
	call MenuWriteText
	call InitMenuCursorAndButtonPermissions
	call GetStaticMenuJoypad
	call GetMenuJoypad
	jmp MenuClickSound

SetUpMenu::
	call DrawVariableLengthMenuBox ; ???
	call MenuWriteText
	call InitMenuCursorAndButtonPermissions ; set up selection pointer
	ld hl, w2DMenuFlags1
	set 7, [hl]
	ret

DrawVariableLengthMenuBox::
	call CopyMenuData2
	call GetMenuIndexSet
	call AutomaticGetMenuBottomCoord
	jmp MenuBox

SetUpVariableDataMenu:
	ld hl, wMenuFlags
	set 2, [hl]
	call AutomaticGetMenuBottomCoord

MenuWriteText::
	xor a
	ldh [hBGMapMode], a
	call GetMenuIndexSet ; sort out the text
	call RunMenuItemPrintingFunction ; actually write it
	call SafeUpdateSprites
	ldh a, [hOAMUpdate]
	push af
	ld a, $1
	ldh [hOAMUpdate], a
	call ApplyTilemap
	pop af
	ldh [hOAMUpdate], a
	ret

AutomaticGetMenuBottomCoord::
	ld a, [wMenuBorderLeftCoord]
	ld c, a
	ld a, [wMenuBorderRightCoord]
	sub c
	ld c, a
	ld a, [wMenuDataItems]
	add a
	inc a
	ld b, a
	ld a, [wMenuBorderTopCoord]
	add b
	ld [wMenuBorderBottomCoord], a
	ret

GetMenuIndexSet::
	ld hl, wMenuDataIndicesPointer
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, [wWhichIndexSet]
	and a
	jr z, .skip
	ld b, a
	ld c, -1
.loop
	ld a, [hli]
	cp c
	jr nz, .loop
	dec b
	jr nz, .loop

.skip
	ld d, h
	ld e, l
	ld a, [hl]
	ld [wMenuDataItems], a
	ret

RunMenuItemPrintingFunction::
	call MenuBoxCoord2Tile
	ld bc, 2 * SCREEN_WIDTH + 2
	add hl, bc
.loop
	inc de
	ld a, [de]
	cp -1
	ret z
	ld [wMenuSelection], a
	push de
	push hl
	ld d, h
	ld e, l
	ld hl, wMenuDataDisplayFunctionPointer
	call IndirectHL
	pop hl
	ld de, 2 * SCREEN_WIDTH
	add hl, de
	pop de
	jr .loop

InitMenuCursorAndButtonPermissions::
	call InitVerticalMenuCursor
	ld hl, wMenuJoypadFilter
	ld a, [wMenuDataFlags]
	bit 3, a
	jr z, .disallow_select
	set START_F, [hl]
.disallow_select
	ld a, [wMenuDataFlags]
	bit 2, a
	ret z
	set D_LEFT_F, [hl]
	set D_RIGHT_F, [hl]
	ret

ReadMenuJoypad::
	call DoMenuJoypadLoop
GetVariableDataMenuResult:
	ld hl, wMenuJoypadFilter
	and [hl]
	jr ContinueGettingMenuJoypad

GetStaticMenuJoypad::
	xor a
	ld [wMenuJoypad], a
	call DoMenuJoypadLoop

ContinueGettingMenuJoypad:
	bit A_BUTTON_F, a
	jr nz, .a_button
	bit B_BUTTON_F, a
	jr nz, .b_start
	bit START_F, a
	jr nz, .b_start
	bit D_RIGHT_F, a
	jr nz, .d_right
	bit D_LEFT_F, a
	jr nz, .d_left
	xor a
	jr .done

.d_right
	ld a, D_RIGHT
	jr .done

.d_left
	ld a, D_LEFT
	jr .done

.a_button
	ld a, A_BUTTON

.done
	ld [wMenuJoypad], a
	call GetMenuIndexSet
	ld a, [wMenuCursorY]
	ld l, a
	ld h, $0
	add hl, de
	ld a, [hl]
	ld [wMenuSelection], a
	ld a, [wMenuCursorY]
	ld [wMenuCursorBuffer], a
	and a
	ret

.b_start
	ld a, B_BUTTON
	ld [wMenuJoypad], a
	ld a, -1
	ld [wMenuSelection], a
	scf
	ret

PlaceMenuStrings::
	push de
	ld hl, wMenuDataPointerTableAddr
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, [wMenuSelection]
	call GetNthString
	ld d, h
	ld e, l
	pop hl
	rst PlaceString
	ret

PlaceNthMenuStrings::
	push de
	ld a, [wMenuSelection]
	call GetMenuDataPointerTableEntry
	inc hl
	inc hl
	ld a, [hli]
	ld d, [hl]
	ld e, a
	pop hl
	rst PlaceString
	ret

MenuJumptable::
	ld a, [wMenuSelection]
	call GetMenuDataPointerTableEntry
	jmp IndirectHL

GetMenuDataPointerTableEntry::
	ld e, a
	ld d, $0
	ld hl, wMenuDataPointerTableAddr
	ld a, [hli]
	ld h, [hl]
	ld l, a
	add hl, de
	add hl, de
	add hl, de
	add hl, de
	ret

ClearWindowData::
	ld hl, wWindowStackPointer
	call .bytefill
	ld hl, wMenuHeader
	call .bytefill
	ld hl, wMenuDataFlags
	call .bytefill
	ld hl, w2DMenuCursorInitY
	call .bytefill

	ldh a, [rSVBK]
	push af
	ld a, $7
	ldh [rSVBK], a

	xor a
	ld hl, wWindowStackBottom
	ld [hld], a
	ld [hld], a
	ld a, l
	ld [wWindowStackPointer], a
	ld a, h
	ld [wWindowStackPointer + 1], a

	pop af
	ldh [rSVBK], a
	ret

.bytefill
	ld bc, $0010
	xor a
	rst ByteFill
	ret

MenuClickSound::
	push af
	and A_BUTTON | B_BUTTON
	jr z, .nosound
	ld hl, wMenuFlags
	bit 3, [hl]
	call z, PlayClickSFX
.nosound
	pop af
	ret

PlayClickSFX::
	push de
	ld de, SFX_READ_TEXT_2
	call PlaySFX
	pop de
	ret

MenuTextboxWaitButton::
	call MenuTextbox
	call WaitButton
	jmp ExitMenu

_2DMenu::
	ldh a, [hROMBank]
	ld [wMenuData_2DMenuItemStringsBank], a
	farcall _2DMenu_
	ld a, [wMenuCursorBuffer]
	ret

SetMenuAttributes::
	push hl
	push bc
	ld hl, w2DMenuCursorInitY
	ld b, $8
.loop
	ld a, [de]
	inc de
	ld [hli], a
	dec b
	jr nz, .loop
	ld a, $1
	ld [hli], a
	ld [hli], a
	xor a
	ld [hli], a
	ld [hli], a
	ld [hli], a
	pop bc
	pop hl
	ret

DoMenuJoypadLoop::
	farcall _DoMenuJoypadLoop

GetMenuJoypad::
	push bc
	push af
	ldh a, [hJoyPressed]
	and BUTTONS
	ld b, a
	ldh a, [hJoyLast]
	and D_PAD
	or b
	ld b, a
	pop af
	ld a, b
	pop bc
	ret

PlaceHollowCursor::
	ld hl, wCursorCurrentTile
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld [hl], "▷"
	ret

HideCursor::
	ld hl, wCursorCurrentTile
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld [hl], " "
	ret
