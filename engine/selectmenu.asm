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

	ld a, [WhichRegisteredItem]
	and a
	jr z, .NoRegisteredItem
	and REGISTERED_POCKET
	rlca
	rlca
	ld hl, .Pockets
	rst JumpTable
	ret

.Pockets:
	dw .CheckItem
	dw .CheckMedicine
	dw .CheckBall
	dw .CheckTMHM
	dw .CheckBerry
	dw .CheckKeyItem

.CheckItem:
	ld hl, NumItems
	jr .ContinueCheck

.CheckMedicine:
	ld hl, NumMedicine
	jr .ContinueCheck

.CheckBall:
	ld hl, NumBalls
	jr .ContinueCheck

.CheckBerry:
	ld hl, NumBerries
.ContinueCheck
	call .CheckRegisteredNo
	jr c, .NoRegisteredItem
	inc hl
	ld e, a
	ld d, 0
rept 2
	add hl, de
endr
	call .IsSameItem
	jr c, .NoRegisteredItem
	and a
	ret

.CheckKeyItem:
	ld a, [RegisteredItem]
	ld hl, KeyItems
	ld de, 1
	call IsInArray
	jr nc, .NoRegisteredItem
	ld a, [RegisteredItem]
	ld [CurItem], a
	and a
	ret

.CheckTMHM:
	jr .NoRegisteredItem

.NoRegisteredItem:
	xor a
	ld [WhichRegisteredItem], a
	ld [RegisteredItem], a
	scf
	ret
; 133a6


.CheckRegisteredNo: ; 133a6
	ld a, [WhichRegisteredItem]
	and REGISTERED_NUMBER
	dec a
	cp [hl]
	jr nc, .NotEnoughItems
	ld [wd107], a
	and a
	ret

.NotEnoughItems:
	scf
	ret
; 133b6


.IsSameItem: ; 133b6
	ld a, [RegisteredItem]
	cp [hl]
	jr nz, .NotSameItem
	ld [CurItem], a
	and a
	ret

.NotSameItem:
	scf
	ret
; 133c3


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
