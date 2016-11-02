SelectMenu:: ; 13327

	call CheckRegisteredItem
	jr c, .NotRegistered
	jp UseRegisteredItem

.NotRegistered:
	call OpenText
	ld b, BANK(ItemMayBeRegisteredText)
	ld hl, ItemMayBeRegisteredText
	call MapTextbox
	call WaitButton
	jp CloseText
; 13340


ItemMayBeRegisteredText: ; 13340
	text_jump UnknownText_0x1c1cf3
	db "@"
; 13345


CheckRegisteredItem: ; 13345
; assume that only key items can be registered
; (Bicycle, Old/Good/Super Rod, Itemfinder)
	ld a, [RegisteredItem]
	and a
	jr z, .NoRegisteredItem
	ld hl, KeyItems
	ld de, 1
	call IsInArray
	jr nc, .NoRegisteredItem
	ld a, [RegisteredItem]
	ld [CurItem], a
	and a
	ret

.NoRegisteredItem:
	xor a
	ld [RegisteredItem], a
	scf
	ret
; 133a6


UseRegisteredItem: ; 133c3

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
; 133df

.NoFunction: ; 133df
	call OpenText
	call CantUseItem
	call CloseText
	and a
	ret
; 133ea

.Current: ; 133ea
	call OpenText
	call DoItemEffect
	call CloseText
	and a
	ret
; 133f5

.Party: ; 133f5
	call RefreshScreen
	call FadeToMenu
	call DoItemEffect
	call CloseSubmenu
	call CloseText
	and a
	ret
; 13406

.Overworld: ; 13406
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
; 13422

.CantUse: ; 13422
	call RefreshScreen

._cantuse
	call CantUseItem
	call CloseText
	and a
	ret
; 1342d
