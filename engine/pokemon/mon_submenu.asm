INCLUDE "data/mon_menu.asm"

MonSubmenu:
	xor a
	ldh [hBGMapMode], a
	call GetMonSubmenuItems
	farcall FreezeMonIcons
	ld hl, .MenuDataHeader
	call LoadMenuHeader
	call .GetTopCoord
	call PopulateMonMenu

	ld a, 1
	ldh [hBGMapMode], a
	call MonMenuLoop
	ld [wMenuSelection], a

	jmp ExitMenu

.MenuDataHeader:
	db MENU_BACKUP_TILES
	menu_coords 6, 0, 19, 17
	dw 0
	db 1 ; default option

.GetTopCoord:
; TopCoord = 1 + BottomCoord - 2 * (NumSubmenuItems + 1)
	ld a, [wMonSubmenuCount]
	inc a
	add a
	ld b, a
	ld a, [wMenuBorderBottomCoord]
	sub b
	inc a
	ld [wMenuBorderTopCoord], a
	jmp MenuBox

MonMenuLoop:
.loop
	ld a, $a0 ; flags
	ld [wMenuDataFlags], a
	ld a, [wMonSubmenuCount] ; items
	ld [wMenuDataItems], a
	call InitVerticalMenuCursor
	ld hl, w2DMenuFlags1
	set 6, [hl]
	call DoMenuJoypadLoop
	ld de, SFX_READ_TEXT_2
	call PlaySFX
	ldh a, [hJoyPressed]
	bit 0, a ; A
	jr nz, .select
	bit 1, a ; B
	jr z, .loop
	ld a, MONMENUITEM_CANCEL
	ret

.select
	ld a, [wMenuCursorY]
	dec a
	ld c, a
	ld b, 0
	ld hl, wMonSubmenuItems
	add hl, bc
	ld a, [hl]
	ret

PopulateMonMenu:
	call MenuBoxCoord2Tile
	ld bc, $2a ; 42
	add hl, bc
	ld de, wMonSubmenuItems
.loop
	ld a, [de]
	inc de
	cp -1
	ret z
	push de
	push hl
	call GetMonMenuString
	pop hl
	rst PlaceString
	ld bc, $28 ; 40
	add hl, bc
	pop de
	jr .loop

GetMonMenuString:
	ld hl, MonMenuOptions + 1
	ld de, 3
	call IsInArray
	dec hl
	ld a, [hli]
	cp MONMENU_MENUOPTION
	jr z, .NotMove
	inc hl
	ld a, [hl]
	ld [wNamedObjectIndex], a
	jmp GetMoveName

.NotMove:
	inc hl
	ld a, [hl]
	dec a
	ld hl, MonMenuOptionStrings
	call GetNthString
	ld d, h
	ld e, l
	ret

GetMonSubmenuItems:
	call ResetMonSubmenu
	ld a, MON_IS_EGG
	call GetPartyParamLocationAndValue
	bit MON_IS_EGG_F, a
	jr nz, .egg
	ld a, [wLinkMode]
	and a
	jr nz, .skip_moves
	ld a, MON_MOVES
	call GetPartyParamLocationAndValue
	ld d, h
	ld e, l
	ld c, NUM_MOVES
.loop
	push bc
	push de
	ld a, [de]
	and a
	jr z, .next
	push hl
	call IsFieldMove
	pop hl
	call c, AddMonMenuItem
.next
	pop de
	inc de
	pop bc
	dec c
	jr nz, .loop

.skip_moves
	ld a, MONMENUITEM_SUMMARY
	call AddMonMenuItem
	ld a, MONMENUITEM_SWITCH
	call AddMonMenuItem
	ld a, [wLinkMode]
	and a
	jr nz, .skip2
	push hl
	ld a, MON_ITEM
	call GetPartyParamLocationAndValue
	ld d, a
	call ItemIsMail ; set carry if mail
	pop hl
	; a = carry ? MONMENUITEM_MAIL : MONMENUITEM_ITEM
	sbc a
	and MONMENUITEM_MAIL - MONMENUITEM_ITEM
	add MONMENUITEM_ITEM
	call AddMonMenuItem

.skip2
	ld a, [wMonSubmenuCount]
	cp NUM_MONMENU_ITEMS
	jr z, TerminateMonSubmenu
	ld a, MONMENUITEM_CANCEL
	call AddMonMenuItem
	jr TerminateMonSubmenu

.egg
	ld a, MONMENUITEM_SUMMARY
	call AddMonMenuItem
	ld a, MONMENUITEM_SWITCH
	call AddMonMenuItem
	ld a, MONMENUITEM_CANCEL
	call AddMonMenuItem
	jr TerminateMonSubmenu

IsFieldMove:
	ld b, a
	ld hl, MonMenuOptions
.next
	ld a, [hli]
	cp -1
	ret z
	cp MONMENU_MENUOPTION
	ret z
	ld a, [hli]
	ld d, a
	ld a, [hli]
	cp b
	jr nz, .next
	ld a, d
	scf
	ret

ResetMonSubmenu:
	xor a
	ld [wMonSubmenuCount], a
	ld hl, wMonSubmenuItems
	ld bc, NUM_MONMENU_ITEMS + 1
	rst ByteFill
	ret

TerminateMonSubmenu:
	ld a, [wMonSubmenuCount]
	ld e, a
	ld d, $0
	ld hl, wMonSubmenuItems
	add hl, de
	ld [hl], -1
	ret

AddMonMenuItem:
	push hl
	push de
	push af
	ld a, [wMonSubmenuCount]
	ld e, a
	inc a
	ld [wMonSubmenuCount], a
	ld d, $0
	ld hl, wMonSubmenuItems
	add hl, de
	pop af
	ld [hl], a
	pop de
	pop hl
	ret
