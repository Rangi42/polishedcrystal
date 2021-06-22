SendMailToPC:
	ld a, MON_ITEM
	call GetPartyParamLocation
	ld d, [hl]
	call ItemIsMail
	jr nc, .full
	call GetMailboxCount
	cp MAILBOX_CAPACITY
	jr nc, .full
	ld bc, MAIL_STRUCT_LENGTH
	ld hl, sMailbox
	rst AddNTimes
	ld d, h
	ld e, l
	ld a, [wCurPartyMon]
	ld bc, MAIL_STRUCT_LENGTH
	ld hl, sPartyMail
	rst AddNTimes
	push hl
	ld a, BANK(sMailboxCount)
	call GetSRAMBank
	ld bc, MAIL_STRUCT_LENGTH
	rst CopyBytes
	pop hl
	xor a
	ld bc, MAIL_STRUCT_LENGTH
	rst ByteFill
	ld a, MON_ITEM
	call GetPartyParamLocation
	ld [hl], 0
	ld hl, sMailboxCount
	inc [hl]
	call CloseSRAM
	xor a
	ret

.full
	scf
	ret

DeleteMailFromPC:
; Shift all mail messages in the mailbox
	ld a, BANK(sMailboxCount)
	call GetSRAMBank
	ld a, b
	push bc
	ld hl, sMailbox
	ld bc, MAIL_STRUCT_LENGTH
	rst AddNTimes
	push hl
	add hl, bc
	pop de
	pop bc
.loop
	ld a, b
	cp MAILBOX_CAPACITY - 1
	jr z, .done
	push bc
	ld bc, MAIL_STRUCT_LENGTH
	rst CopyBytes
	pop bc
	inc b
	jr .loop
.done
	ld h, d
	ld l, e
	xor a
	ld bc, MAIL_STRUCT_LENGTH
	rst ByteFill
	ld hl, sMailboxCount
	dec [hl]
	jmp CloseSRAM

ReadMailMessage:
	ld a, b
	ld hl, sMailbox
	ld bc, MAIL_STRUCT_LENGTH
	rst AddNTimes
	ld d, h
	ld e, l
	farjp ReadAnyMail

MoveMailFromPCToParty:
	ld a, BANK(sMailboxCount)
	call GetSRAMBank
	push bc
	ld a, b
	ld bc, MAIL_STRUCT_LENGTH
	ld hl, sMailbox
	rst AddNTimes
	push hl
	ld a, [wCurPartyMon]
	ld bc, MAIL_STRUCT_LENGTH
	ld hl, sPartyMail
	rst AddNTimes
	ld d, h
	ld e, l
	pop hl
	push hl
	ld bc, MAIL_STRUCT_LENGTH
	rst CopyBytes
	pop hl
	ld de, PARTYMON_STRUCT_LENGTH - MON_MOVES
	add hl, de
	ld d, [hl]
	ld a, [wCurPartyMon]
	ld hl, wPartyMon1Item
	ld bc, PARTYMON_STRUCT_LENGTH
	rst AddNTimes
	ld [hl], d
	call CloseSRAM
	pop bc
	jr DeleteMailFromPC

GetMailboxCount:
	ld a, BANK(sMailboxCount)
	call GetSRAMBank
	ld a, [sMailboxCount]
	ld c, a
	jmp CloseSRAM

CheckPokeItem::
	push bc
	push de
	farcall SelectMonFromParty
	ld a, $2
	jr c, .pop_return

	ld a, [wCurPartyMon]
	ld hl, wPartyMon1Item
	ld bc, PARTYMON_STRUCT_LENGTH
	rst AddNTimes
	ld d, [hl]
	call ItemIsMail
	ld a, $3
	jr nc, .pop_return

	ld a, BANK(sPartyMail)
	call GetSRAMBank
	ld a, [wCurPartyMon]
	ld hl, sPartyMail
	ld bc, MAIL_STRUCT_LENGTH
	rst AddNTimes
	ld d, h
	ld e, l
	pop hl
	pop bc

; Compare the mail message, byte for byte, with the expected message.
	ld a, MAIL_MSG_LENGTH
	ld [wTempByteValue], a
.loop
	ld a, [de]
	ld c, a
	ld a, b
	call GetFarByte
	cp "@"
	jr z, .done
	cp c
	ld a, 0
	jr nz, .close_sram_return
	inc hl
	inc de
	ld a, [wTempByteValue]
	dec a
	ld [wTempByteValue], a
	jr nz, .loop

.done
	farcall CheckCurPartyMonFainted
	ld a, $4
	jr c, .close_sram_return
	xor a
	ld [wPokemonWithdrawDepositParameter], a
	predef RemoveMonFromParty
	ld a, $1

.close_sram_return
	call CloseSRAM
	jr .return

.pop_return
	pop de
	pop bc

.return
	ldh [hScriptVar], a
	ret

GivePokeItem::
	ld a, [wPartyCount]
	dec a
	push af
	ld hl, wPartyMon1Item
	call GetPartyLocation
	ld [hl], b
	pop af
	push bc
	push af
	ld hl, sPartyMail
	ld bc, MAIL_STRUCT_LENGTH
	rst AddNTimes
	ld d, h
	ld e, l
	ld hl, wMonMailMessageBuffer
	ld bc, MAIL_MSG_LENGTH + 1
	ld a, BANK(sPartyMail)
	call GetSRAMBank
	rst CopyBytes
	pop af
	push af
	ld hl, wPartyMonOTs
	ld bc, NAME_LENGTH
	rst AddNTimes
	ld bc, NAME_LENGTH - 1
	rst CopyBytes
	pop af
	ld hl, wPartyMon1ID
	ld bc, PARTYMON_STRUCT_LENGTH
	rst AddNTimes
	ld a, [hli]
	ld [de], a
	inc de
	ld a, [hl]
	ld [de], a
	inc de
	ld a, [wCurPartySpecies]
	ld [de], a
	inc de
	pop bc
	ld a, b
	ld [de], a
	jmp CloseSRAM

BackupPartyMonMail:
	ld a, BANK(sPartyMail)
	call GetSRAMBank
	ld hl, sPartyMail
	ld de, sPartyMailBackup
	ld bc, 6 * MAIL_STRUCT_LENGTH
	rst CopyBytes
	ld hl, sMailboxCount
	ld de, sMailboxCountBackup
	ld bc, 1 + 10 * MAIL_STRUCT_LENGTH
	rst CopyBytes
	jmp CloseSRAM

RestorePartyMonMail:
	ld a, BANK(sPartyMail)
	call GetSRAMBank
	ld hl, sPartyMailBackup
	ld de, sPartyMail
	ld bc, 6 * MAIL_STRUCT_LENGTH
	rst CopyBytes
	ld hl, sMailboxCountBackup
	ld de, sMailboxCount
	ld bc, 1 + 10 * MAIL_STRUCT_LENGTH
	rst CopyBytes
	jmp CloseSRAM

DeletePartyMonMail:
	ld a, BANK(sPartyMail)
	call GetSRAMBank
	xor a
	ld hl, sPartyMail
	ld bc, 6 * MAIL_STRUCT_LENGTH
	rst ByteFill
	xor a
	ld hl, sMailboxCount
	ld bc, 1 + 10 * MAIL_STRUCT_LENGTH
	rst ByteFill
	jmp CloseSRAM

IsAnyMonHoldingMail:
	ld a, [wPartyCount]
	and a
	jr z, .no_mons
	ld e, a
	ld hl, wPartyMon1Item
.loop
	ld d, [hl]
	call ItemIsMail
	ret c
	ld bc, PARTYMON_STRUCT_LENGTH
	add hl, bc
	dec e
	jr nz, .loop

.no_mons
	and a
	ret

_PlayerMailBoxMenu:
	call InitMail
	jr z, .nomail
	call LoadStandardMenuHeader
	call MailboxPC
	jmp CloseWindow

.nomail
	ld hl, .EmptyMailboxText
	jmp MenuTextboxBackup

.EmptyMailboxText:
	text_far _EmptyMailboxText
	text_end

InitMail:
; initialize wMailboxCount and beyond with incrementing values, one per mail
; set z if no mail
	ld a, BANK(sMailboxCount)
	call GetSRAMBank
	ld a, [sMailboxCount]
	call CloseSRAM
	ld hl, wMailboxCount
	ld [hli], a
	and a

	jr z, .done ; if no mail, we're done

	; load values in memory with incrementing values starting at wMailboxCount
	ld b, a
	ld a, 1
.loop
	ld [hli], a
	inc a
	dec b
	jr nz, .loop
.done
	ld [hl], -1 ; terminate

	ld a, [wMailboxCount]
	and a
	ret

MailboxPC_GetMailAuthor:
	dec a
	ld hl, sMailbox1Author
	ld bc, MAIL_STRUCT_LENGTH
	rst AddNTimes
	ld a, BANK(sMailboxCount)
	call GetSRAMBank
	ld de, wStringBuffer2
	push de
	ld bc, NAME_LENGTH - 1
	rst CopyBytes
	ld a, "@"
	ld [de], a
	call CloseSRAM
	pop de
	ret

MailboxPC_PrintMailAuthor:
	push de
	ld a, [wMenuSelection]
	call MailboxPC_GetMailAuthor
	pop hl
	rst PlaceString
	ret

MailboxPC:
	xor a
	ld [wCurMessageScrollPosition], a
	ld a, 1
	ld [wCurMessageIndex], a
.loop
	call InitMail
	ld hl, .TopMenuDataHeader
	call CopyMenuHeader
	xor a
	ldh [hBGMapMode], a
	call InitScrollingMenu
	call UpdateSprites

	ld a, [wCurMessageIndex]
	ld [wMenuCursorBuffer], a
	ld a, [wCurMessageScrollPosition]
	ld [wMenuScrollPosition], a
	call ScrollingMenu
	ld a, [wMenuScrollPosition]
	ld [wCurMessageScrollPosition], a
	ld a, [wMenuCursorY]
	ld [wCurMessageIndex], a

	ld a, [wMenuJoypad]
	cp B_BUTTON
	jr z, .exit
	call .Submenu
	jr .loop

.exit
	xor a
	ret

.Submenu:
	ld hl, .SubMenuDataHeader
	call LoadMenuHeader
	call VerticalMenu
	call ExitMenu
	ret c
	ld a, [wMenuCursorY]
	dec a
	call StackJumpTable

.JumpTable:
	dw .ReadMail
	dw .PutInPack
	dw .AttachMail
	dw DoNothing

.ReadMail:
	call FadeToMenu
	ld a, [wMenuSelection]
	dec a
	ld b, a
	call ReadMailMessage
	jmp CloseSubmenu

.PutInPack:
	ld hl, .MessageLostText
	call MenuTextbox
	call YesNoBox
	call ExitMenu
	ret c
	ld a, [wMenuSelection]
	dec a
	call .GetMailType
	ld a, 1
	ld [wItemQuantityChangeBuffer], a
	ld hl, wNumItems
	call ReceiveItem
	jr c, .put_in_bag
	ld hl, .PackFullText
	jmp MenuTextboxBackup

.put_in_bag
	ld a, [wMenuSelection]
	dec a
	ld b, a
	call DeleteMailFromPC
	ld hl, .PutAwayText
	jmp MenuTextboxBackup

.PutAwayText:
	text_far ClearedMailPutAwayText
	text_end

.PackFullText:
	text_far MailPackFullText
	text_end

.MessageLostText:
	text_far MailMessageLostText
	text_end

.GetMailType:
	push af
	ld a, BANK(sMailboxCount)
	call GetSRAMBank
	pop af
	ld hl, sMailbox1Type
	ld bc, MAIL_STRUCT_LENGTH
	rst AddNTimes
	ld a, [hl]
	ld [wCurItem], a
	jmp CloseSRAM

.AttachMail:
	call FadeToMenu
	xor a
	ld [wPartyMenuActionText], a
	call ClearBGPalettes
.try_again
	farcall LoadPartyMenuGFX
	farcall InitPartyMenuWithCancel
	farcall InitPartyMenuGFX
	farcall WritePartyMenuTilemap
	farcall PrintPartyMenuText
	call ApplyTilemapInVBlank
	call SetPalettes
	call DelayFrame
	farcall PartyMenuSelect
	jr c, .exit2
	push hl
	ld a, MON_IS_EGG
	call GetPartyParamLocation
	bit MON_IS_EGG_F, [hl]
	pop hl
	jr nz, .egg
	ld a, MON_ITEM
	call GetPartyParamLocation
	ld a, [hl]
	and a
	jr z, .attach_mail
	ld hl, .HoldingMailText
	call PrintText
	jr .try_again

.egg
	ld hl, .EggText
	call PrintText
	jr .try_again

.attach_mail
	ld a, [wMenuSelection]
	dec a
	ld b, a
	call MoveMailFromPCToParty
	ld hl, .MailMovedText
	call PrintText

.exit2
	jmp CloseSubmenu

.HoldingMailText:
	text_far MailAlreadyHoldingItemText
	text_end

.EggText:
	text_far MailEggText
	text_end

.MailMovedText:
	text_far MailMovedFromBoxText
	text_end

.TopMenuDataHeader:
	db %01000000 ; flags
	db 1, 8 ; start coords
	db 10, 18 ; end coords
	dw .TopMenuData2
	db 1 ; default option

.TopMenuData2:
	db %00010000 ; flags
	db 4, 0 ; rows/columns?
	db 1 ; horizontal spacing?
	dbw 0, wMailboxCount ; text pointer
	dba MailboxPC_PrintMailAuthor
	dba NULL
	dba NULL

.SubMenuDataHeader:
	db %01000000 ; flags
	db 0,  0 ; start coords
	db 9, 13 ; end coords
	dw .SubMenuData2
	db 1 ; default option

.SubMenuData2:
	db %10000000 ; flags
	db 4 ; items
	db "Read Mail@"
	db "Put in Bag@"
	db "Attach Mail@"
	db "Cancel@"
