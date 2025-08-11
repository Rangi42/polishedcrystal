SelectMenu::
	call CheckRegisteredItem
	jr nz, UseRegisteredItem

	call OpenText
	ld b, BANK(ItemMayBeRegisteredText)
	ld hl, ItemMayBeRegisteredText
	call MapTextbox
	call WaitButton
	jmp CloseText

ItemMayBeRegisteredText:
	text_far _MayRegisterItemText
	text_end

CheckRegisteredItem::
; Returns amount of registered items and z if none is. Populates wCurItem
; with a valid registered item, useful if there's only a single one.
	ld hl, wRegisteredItems
	lb bc, 4, 0
.loop
	ld a, [hl]
	and a
	jr z, .next
	ld [wCurKeyItem], a
	push hl
	push bc
	call CheckKeyItem
	pop bc
	pop hl
	jr nc, .next
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
	farcall CheckKeyItemMenu
	ld a, [wItemAttributeParamBuffer]
	call StackJumpTable

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
	predef DoKeyItemEffect
	call CloseText
	and a
	ret

.Party:
	call ReanchorMap
	call FadeToMenu
	predef DoKeyItemEffect
	call CloseSubmenu
	call CloseText
	and a
	ret

.Overworld:
	call ReanchorMap
	ld a, 1
	ld [wUsingItemWithSelect], a
	predef DoKeyItemEffect
	xor a
	ld [wUsingItemWithSelect], a
	ld a, [wItemEffectSucceeded]
	dec a ; TRUE?
	jr nz, ._cantuse
	scf
	ld a, HMENURETURN_SCRIPT
	ldh [hMenuReturn], a
	ret

.CantUse:
	call ReanchorMap

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
	call LoadStandardOpaqueFont
	ld hl, InvertedTextPalette
	ld de, wBGPals1 palette PAL_BG_TEXT
	ld bc, 1 palettes
	call FarCopyColorWRAM

	hlcoord 0, 0, wAttrmap
	ld a, OAM_PRIO | PAL_BG_TEXT
	ld bc, SCREEN_WIDTH * 4
	rst ByteFill

	hlcoord 0, 0
	ld a, " "
	ld bc, SCREEN_WIDTH * 4
	rst ByteFill

	; Insert registered items
	hlcoord 0, 0
	ld de, .RegisteredItemText
	rst PlaceString
	hlcoord 2, 0
	ld de, wRegisteredItems
	ld b, 4
.loop
	push bc
	ld a, [de]
	and a
	jr z, .next
	ld [wNamedObjectIndex], a
	push de
	push hl
	push af
	call GetKeyItemName
	pop af
	pop hl
	push hl
	ld de, wStringBuffer1
	rst PlaceString
	pop hl
	pop de
.next
	inc de
	ld bc, SCREEN_WIDTH
	add hl, bc
	pop bc
	dec b
	jr nz, .loop

	ld a, $70
	ldh [rWY], a
	ldh [hWY], a
	call SetDefaultBGPAndOBP
	call DelayFrame
	farcall HDMATransfer_OnlyTopFourRows

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
	bit B_PAD_A, a
	jr nz, .first
	and PAD_B | PAD_SELECT | PAD_START
	jr nz, .cancel
	ld de, wRegisteredItems
	ld a, [hl]
	bit B_PAD_UP, a
	jr nz, .got_item
	inc de
	bit B_PAD_LEFT, a
	jr nz, .got_item
	inc de
	bit B_PAD_RIGHT, a
	jr nz, .got_item
	inc de
.got_item
	ld a, [de]
.got_item_a
	ld [wCurKeyItem], a
	and a
	jr z, .joy_loop
	jr .ret

.cancel
	xor a
.ret
	push af
	ld a, $90
	ldh [rWY], a
	ldh [hWY], a
	farcall RefreshSprites
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
	db "▲ -<LNBRK>"
	db "◀ -<LNBRK>"
	db "▶ -<LNBRK>"
	db "▼ -@"

InvertedTextPalette:
INCLUDE "gfx/overworld/register_item.pal"
