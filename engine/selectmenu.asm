SelectMenu::
	call CheckRegisteredItem
	jr z, .NotRegistered
	jp UseRegisteredItem

.NotRegistered:
	call OpenText
	ld b, BANK(ItemMayBeRegisteredText)
	ld hl, ItemMayBeRegisteredText
	call MapTextbox
	call WaitButton
	jp CloseText


ItemMayBeRegisteredText:
	text_jump UnknownText_0x1c1cf3
	db "@"


CheckRegisteredItem:: ; 13345
; Returns amount of registered items and z if none is. Populates wCurItem
; with a valid registered item, useful if there's only a single one.
	ld hl, wRegisteredItems
	ld b, 4
	ld c, 0
.loop
	ld a, [hl]
	and a
	jr z, .next
	push hl
	push bc
	push af
	ld hl, wKeyItems
	ld de, 1
	call IsInArray
	jr c, .registration_ok

	; We can register regular items too (e.g. Repel)
	pop af
	push af
	ld hl, wItems
	ld de, 2
	call IsInArray
	jr c, .registration_ok
	pop af
	pop bc
	pop hl
	xor a
	ld [hl], a
	jr .next
.registration_ok
	pop af
	pop bc
	pop hl

	; Useful if we only have a single registered item
	ld [wCurItem], a
	inc c
.next
	inc hl
	dec b
	jr nz, .loop
	ld a, c
	and a
	ret

UseRegisteredItem:
	; If we only have a single valid item, use it
	cp 2
	jr c, .single_registered_item

	; Otherwise, show an item selection window
	call GetRegisteredItem
	ret z

.single_registered_item
	push de
	ld de, SFX_READ_TEXT_2
	call PlaySFX
	ld c, 3
	call SFXDelayFrames
	pop de
	farcall CheckItemMenu
	ld a, [wItemAttributeParamBuffer]
	ld hl, .SwitchTo
	rst JumpTable
	ret

.SwitchTo:
	dw .CantUse
	dw .NoFunction
	dw .NoFunction
	dw .NoFunction
	dw .Current
	dw .Party
	dw .Overworld

.NoFunction:
	call OpenText
	call CantUseItem
	call CloseText
	and a
	ret

.Current:
	call OpenText
	call DoItemEffect
	call CloseText
	and a
	ret

.Party:
	call RefreshScreen
	call FadeToMenu
	call DoItemEffect
	call CloseSubmenu
	call CloseText
	and a
	ret

.Overworld:
	call RefreshScreen
	ld a, 1
	ld [wUsingItemWithSelect], a
	call DoItemEffect
	xor a
	ld [wUsingItemWithSelect], a
	ld a, [wItemEffectSucceeded]
	cp 1
	jr nz, ._cantuse
	scf
	ld a, HMENURETURN_SCRIPT
	ld [hMenuReturn], a
	ret

.CantUse:
	call RefreshScreen

._cantuse
	call CantUseItem
	call CloseText
	and a
	ret

GetRegisteredItem:
; Shows a list of registered items, allowing you to select one with directions
	ld de, SFX_MENU
	call PlaySFX

	call ClearWindowData
	farcall ReanchorBGMap_NoOAMUpdate
	call SafeUpdateSprites
	call BGMapAnchorTopLeft
	call DelayFrame
	call LoadStandardOpaqueFont
	ld hl, InvertedTextPalette
	ld de, wUnknBGPals palette PAL_BG_TEXT
	ld bc, 1 palettes
	ld a, $5
	call FarCopyWRAM

	hlcoord 0, 0, wAttrMap
	ld a, BEHIND_BG | PAL_BG_TEXT
	ld bc, SCREEN_WIDTH * 4
	call ByteFill

	hlcoord 0, 0
	ld a, " "
	ld bc, SCREEN_WIDTH * 4
	call ByteFill

	; Insert registered items
	hlcoord 0, 0
	ld de, .RegisteredItemText
	call PlaceString
	hlcoord 2, 0
	ld de, wRegisteredItems
	ld b, 4
.loop
	push bc
	ld a, [de]
	and a
	jr z, .next
	ld [wNamedObjectIndexBuffer], a
	push de
	push hl
	call GetItemName
	pop hl
	push hl
	ld de, wStringBuffer1
	call PlaceString
	pop hl
	pop de
.next
	inc de
	ld bc, SCREEN_WIDTH
	add hl, bc
	pop bc
	dec b
	jr nz, .loop

	call SetPalettes
	farcall HDMATransfer_OnlyTopFourRows
	xor a
	ld a, $70
	ld [rWY], a
	ld [hWY], a

	; wait for input
.joy_loop
	call GetJoypad
	ld hl, hJoyPressed
	ld a, [hl]
	and a
	jr nz, .got_input
	call DelayFrame
	jr .joy_loop
.got_input
	bit A_BUTTON_F, a
	jr nz, .first
	and B_BUTTON | SELECT | START
	jr nz, .cancel
	ld de, wRegisteredItems
	ld a, [hl]
	bit D_UP_F, a
	jr nz, .got_item
	inc de
	bit D_LEFT_F, a
	jr nz, .got_item
	inc de
	bit D_RIGHT_F, a
	jr nz, .got_item
	inc de
.got_item
	ld a, [de]
.got_item_a
	ld [wCurItem], a
	and a
	jr z, .joy_loop
	jr .ret

.cancel
	xor a
.ret
	push af
	ld a, $90
	ld [rWY], a
	ld [hWY], a
	farcall ReloadVisibleSprites
	pop af
	ret

.first
	ld hl, wRegisteredItems
rept 3
	ld a, [hli]
	and a
	jr nz, .got_item_a
endr
	ld a, [hl]
	and a
	jr nz, .got_item_a
	jr .joy_loop

.RegisteredItemText:
	db    "▲ -"
	next1 "◀ -"
	next1 "▶ -"
	next1 "▼ -@"

InvertedTextPalette:
if !DEF(MONOCHROME)
	RGB 00, 00, 00
	RGB 00, 00, 00
	RGB 31, 31, 31
	RGB 31, 31, 31
else
	RGB_MONOCHROME_BLACK
	RGB_MONOCHROME_BLACK
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_WHITE
endc
