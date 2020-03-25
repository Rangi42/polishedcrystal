Special_BankOfMom:
	ldh a, [hInMenu]
	push af
	ld a, $1
	ldh [hInMenu], a
	xor a
	ld [wJumptableIndex], a
.loop
	ld a, [wJumptableIndex]
	bit 7, a
	jr nz, .done
	call .RunJumptable
	jr .loop

.done
	pop af
	ldh [hInMenu], a
	ret

.RunJumptable:
	ld a, [wJumptableIndex]
	ld hl, .dw
	jp JumpTable

.dw
	dw .CheckIfBankInitialized
	dw .InitializeBank
	dw .IsThisAboutYourMoney
	dw .AccessBankOfMom
	dw .StoreMoney
	dw .TakeMoney
	dw .StopOrStartSavingMoney
	dw .AskDST
	dw .JustDoWhatYouCan

.CheckIfBankInitialized:
	ld a, [wMomSavingMoney]
	bit 7, a
	jr nz, .savingmoneyalready
	set 7, a
	ld [wMomSavingMoney], a
	ld a, $1
	jr .done_0

.savingmoneyalready
	ld a, $2

.done_0
	ld [wJumptableIndex], a
	ret

.InitializeBank:
	ld hl, UnknownText_0x16649
	call PrintText
	call YesNoBox
	jr c, .DontSaveMoney
	ld hl, UnknownText_0x1664e
	call PrintText
	ld a, %10000001
	jr .done_1

.DontSaveMoney:
	ld a, %10000000

.done_1
	ld [wMomSavingMoney], a
	ld hl, UnknownText_0x16653
	call PrintText
	ld a, $8
	ld [wJumptableIndex], a
	ret

.IsThisAboutYourMoney:
	ld hl, UnknownText_0x16658
	call PrintText
	call YesNoBox
	jr c, .nope
	ld a, $3
	jr .done_2

.nope
	call DSTChecks
	ld a, $7

.done_2
	ld [wJumptableIndex], a
	ret

.AccessBankOfMom:
	ld hl, UnknownText_0x1665d
	call PrintText
	call LoadStandardMenuDataHeader
	ld hl, MenuDataHeader_0x166b5
	call CopyMenuDataHeader
	call VerticalMenu
	call CloseWindow
	jr c, .cancel
	ld a, [wMenuCursorY]
	cp $1
	jr z, .withdraw
	cp $2
	jr z, .deposit
	cp $3
	jr z, .stopsaving

.cancel
	ld a, $7
	jr .done_3

.withdraw
	ld a, $5
	jr .done_3

.deposit
	ld a, $4
	jr .done_3

.stopsaving
	ld a, $6

.done_3
	ld [wJumptableIndex], a
	ret

.StoreMoney:
	ld hl, UnknownText_0x16662
	call PrintText
	xor a
	ld hl, wStringBuffer2
	ld [hli], a
	ld [hli], a
	ld [hl], a
	ld a, $6
	ld [wcf64], a
	call LoadStandardMenuDataHeader
	call Mom_SetUpDepositMenu
	call Mom_Wait10Frames
	call Mom_WithdrawDepositMenuJoypad
	call CloseWindow
	jr c, .CancelDeposit
	ld hl, wStringBuffer2
	ld a, [hli]
	or [hl]
	inc hl
	or [hl]
	jr z, .CancelDeposit
	ld de, wMoney
	ld bc, wStringBuffer2
	farcall CompareMoney
	jr c, .DontHaveThatMuchToDeposit
	ld hl, wStringBuffer2
	ld de, wStringBuffer2 + 3
	ld bc, 3
	rst CopyBytes
	ld bc, wMomsMoney
	ld de, wStringBuffer2
	farcall GiveMoney
	jr c, .CantDepositThatMuch
	ld bc, wStringBuffer2 + 3
	ld de, wMoney
	farcall TakeMoney
	ld hl, wStringBuffer2
	ld de, wMomsMoney
	ld bc, 3
	rst CopyBytes
	ld de, SFX_TRANSACTION
	call PlaySFX
	call WaitSFX
	ld hl, UnknownText_0x1668a
	call PrintText
	ld a, $8
	jr .done_4

.DontHaveThatMuchToDeposit:
	ld hl, UnknownText_0x1667b
	jp PrintText

.CantDepositThatMuch:
	ld hl, UnknownText_0x16680
	jp PrintText

.CancelDeposit:
	ld a, $7

.done_4
	ld [wJumptableIndex], a
	ret

.TakeMoney:
	ld hl, UnknownText_0x16667
	call PrintText
	xor a
	ld hl, wStringBuffer2
	ld [hli], a
	ld [hli], a
	ld [hl], a
	ld a, $6
	ld [wcf64], a
	call LoadStandardMenuDataHeader
	call Mom_SetUpWithdrawMenu
	call Mom_Wait10Frames
	call Mom_WithdrawDepositMenuJoypad
	call CloseWindow
	jr c, .CancelWithdraw
	ld hl, wStringBuffer2
	ld a, [hli]
	or [hl]
	inc hl
	or [hl]
	jr z, .CancelWithdraw
	ld hl, wStringBuffer2
	ld de, wStringBuffer2 + 3
	ld bc, 3
	rst CopyBytes
	ld de, wMomsMoney
	ld bc, wStringBuffer2
	farcall CompareMoney
	jr c, .InsufficientFundsInBank
	ld bc, wMoney
	ld de, wStringBuffer2
	farcall GiveMoney
	jr c, .NotEnoughRoomInWallet
	ld bc, wStringBuffer2 + 3
	ld de, wMomsMoney
	farcall TakeMoney
	ld hl, wStringBuffer2
	ld de, wMoney
	ld bc, 3
	rst CopyBytes
	ld de, SFX_TRANSACTION
	call PlaySFX
	call WaitSFX
	ld hl, UnknownText_0x1668f
	call PrintText
	ld a, $8
	jr .done_5

.InsufficientFundsInBank:
	ld hl, UnknownText_0x16671
	jp PrintText

.NotEnoughRoomInWallet:
	ld hl, UnknownText_0x16676
	jp PrintText

.CancelWithdraw:
	ld a, $7

.done_5
	ld [wJumptableIndex], a
	ret

.StopOrStartSavingMoney:
	ld hl, UnknownText_0x1666c
	call PrintText
	call YesNoBox
	jr c, .StopSavingMoney
	ld a, $81
	ld [wMomSavingMoney], a
	ld hl, UnknownText_0x16685
	call PrintText
	ld a, $8
	ld [wJumptableIndex], a
	ret

.StopSavingMoney:
	ld a, $80
	ld [wMomSavingMoney], a
	ld a, $7
	ld [wJumptableIndex], a
	ret

.AskDST:
	ld hl, UnknownText_0x16694
	call PrintText

.JustDoWhatYouCan:
	ld hl, wJumptableIndex
	set 7, [hl]
	ret

DSTChecks:
; check the time; avoid changing DST if doing so would change the current day
	ld a, [wDST]
	bit 7, a
	ldh a, [hHours]
	jr z, .NotDST
	and a ; within one hour of 00:00?
	jr z, .LostBooklet
	jr .loop

.NotDST:
	cp 23 ; within one hour of 23:00?
	jr nz, .loop
	; fallthrough

.LostBooklet:
	call .ClearBox
	bccoord 1, 14
	ld hl, .Text_AdjustClock
	call PlaceWholeStringInBoxAtOnce
	call YesNoBox
	ret c
	call .ClearBox
	bccoord 1, 14
	ld hl, .Text_LostInstructionBooklet
	jp PlaceWholeStringInBoxAtOnce

.loop
	call .ClearBox
	bccoord 1, 14
	ld a, [wDST]
	bit 7, a
	jr z, .SetDST
	ld hl, .Text_IsDSTOver
	call PlaceWholeStringInBoxAtOnce
	call YesNoBox
	ret c
	ld a, [wDST]
	res 7, a
	ld [wDST], a
	call .SetClockBack
	call .ClearBox
	bccoord 1, 14
	ld hl, .Text_SetClockBack
	jp PlaceWholeStringInBoxAtOnce

.SetDST:
	ld hl, .Text_SwitchToDST
	call PlaceWholeStringInBoxAtOnce
	call YesNoBox
	ret c
	ld a, [wDST]
	set 7, a
	ld [wDST], a
	call .SetClockForward
	call .ClearBox
	bccoord 1, 14
	ld hl, .Text_SetClockForward
	jp PlaceWholeStringInBoxAtOnce

.SetClockForward:
	ld a, [wStartHour]
	add 1
	sub 24
	jr nc, .DontLoopHourForward
	add 24
.DontLoopHourForward:
	ld [wStartHour], a
	ccf
	ld a, [wStartDay]
	adc 0
	ld [wStartDay], a
	ret

.SetClockBack:
	ld a, [wStartHour]
	sub 1
	jr nc, .DontLoopHourBack
	add 24
.DontLoopHourBack:
	ld [wStartHour], a
	ld a, [wStartDay]
	sbc 0
	jr nc, .DontLoopDayBack
	add 7
.DontLoopDayBack:
	ld [wStartDay], a
	ret

.ClearBox:
	hlcoord 1, 14
	lb bc, 3, 18
	jp ClearBox

.Text_AdjustClock:
	; Do you want to adjust your clock for Daylight Saving Time?
	text_jump UnknownText_0x1c6095
	text_end

.Text_LostInstructionBooklet:
	; I lost the instruction booklet for the POKéGEAR.
	; Come back again in a while.
	text_jump UnknownText_0x1c60d1
	text_end

.Text_SwitchToDST:
	; Do you want to switch to Daylight Saving Time?
	text_jump UnknownText_0x1c6000
	text_end

.Text_SetClockForward:
	; I set the clock forward by one hour.
	text_jump UnknownText_0x1c6030
	text_end

.Text_IsDSTOver:
	; Is Daylight Saving Time over?
	text_jump UnknownText_0x1c6056
	text_end

.Text_SetClockBack:
	; I put the clock back one hour.
	text_jump UnknownText_0x1c6075
	text_end

Mom_SetUpWithdrawMenu:
	ld de, Mom_WithdrawString
	jr Mom_ContinueMenuSetup

Mom_SetUpDepositMenu:
	ld de, Mom_DepositString

Mom_ContinueMenuSetup:
	push de
	xor a
	ldh [hBGMapMode], a
	hlcoord 0, 0
	lb bc, 6, 18
	call TextBox
	hlcoord 1, 2
	ld de, Mom_SavedString
	rst PlaceString
	hlcoord 11, 2
	ld de, wMomsMoney
	lb bc, PRINTNUM_MONEY | 3, 7
	call PrintNum
	hlcoord 1, 4
	ld de, Mom_HeldString
	rst PlaceString
	hlcoord 11, 4
	ld de, wMoney
	lb bc, PRINTNUM_MONEY | 3, 7
	call PrintNum
	hlcoord 1, 6
	pop de
	rst PlaceString
	hlcoord 11, 6
	ld de, wStringBuffer2
	lb bc, PRINTNUM_MONEY | PRINTNUM_LEADINGZEROS | 3, 7
	call PrintNum
	call UpdateSprites
	jp CopyTilemapAtOnce

Mom_Wait10Frames:
	ld c, 10
	jp DelayFrames

Mom_WithdrawDepositMenuJoypad:
.loop
	call JoyTextDelay
	ld hl, hJoyPressed
	ld a, [hl]
	and B_BUTTON
	jr nz, .pressedB
	ld a, [hl]
	and A_BUTTON
	jr nz, .pressedA
	call .dpadaction
	xor a
	ldh [hBGMapMode], a
	hlcoord 11, 6
	ld bc, 8
	ld a, " "
	rst ByteFill
	hlcoord 11, 6
	ld de, wStringBuffer2
	lb bc, PRINTNUM_MONEY | PRINTNUM_LEADINGZEROS | 3, 7
	call PrintNum
	ldh a, [hVBlankCounter]
	and $10
	jr nz, .skip
	hlcoord 12, 6
	ld a, [wMomBankDigitCursorPosition]
	ld c, a
	ld b, 0
	add hl, bc
	ld [hl], " "

.skip
	call ApplyTilemapInVBlank
	jr .loop

.pressedB
	scf
	ret

.pressedA
	and a
	ret

.dpadaction
	ld hl, hJoyLast
	ld a, [hl]
	and D_UP
	jr nz, .incrementdigit
	ld a, [hl]
	and D_DOWN
	jr nz, .decrementdigit
	ld a, [hl]
	and D_LEFT
	jr nz, .movecursorleft
	ld a, [hl]
	and D_RIGHT
	jr nz, .movecursorright
	and a
	ret

.movecursorleft
	ld hl, wMomBankDigitCursorPosition
	ld a, [hl]
	and a
	ret z
	dec [hl]
	ret

.movecursorright
	ld hl, wMomBankDigitCursorPosition
	ld a, [hl]
	cp 6
	ret nc
	inc [hl]
	ret

.incrementdigit
	ld hl, .DigitQuantities
	call .getdigitquantity
	ld c, l
	ld b, h
	ld de, wStringBuffer2
	farjp GiveMoney

.decrementdigit
	ld hl, .DigitQuantities
	call .getdigitquantity
	ld c, l
	ld b, h
	ld de, wStringBuffer2
	farjp TakeMoney

.getdigitquantity
	ld a, [wMomBankDigitCursorPosition]
	push de
	ld e, a
	ld d, 0
	add hl, de
	add hl, de
	add hl, de
	pop de
	ret

.DigitQuantities:
	dt 1000000
	dt 100000
	dt 10000
	dt 1000
	dt 100
	dt 10
	dt 1

	dt 1000000
	dt 100000
	dt 10000
	dt 1000
	dt 100
	dt 10
	dt 1

	dt 9000000
	dt 900000
	dt 90000
	dt 9000
	dt 900
	dt 90
	dt 9

UnknownText_0x16649:
	; Wow, that's a cute #MON. Where did you get it? … So, you're leaving on an adventure… OK! I'll help too. But what can I do for you? I know! I'll save money for you. On a long journey, money's important. Do you want me to save your money?
	text_jump UnknownText_0x1bd77f
	text_end

UnknownText_0x1664e:
	; OK, I'll take care of your money.
	text_jump UnknownText_0x1bd868
	text_end

UnknownText_0x16653:
	; Be careful. #MON are your friends. You need to work as a team. Now, go on!
	text_jump UnknownText_0x1bd88e
	text_end

UnknownText_0x16658:
	; Hi! Welcome home! You're trying very hard, I see. I've kept your room tidy. Or is this about your money?
	text_jump UnknownText_0x1bd8da
	text_end

UnknownText_0x1665d:
	; What do you want to do?
	text_jump UnknownText_0x1bd942
	text_end

UnknownText_0x16662:
	; How much do you want to save?
	text_jump UnknownText_0x1bd95b
	text_end

UnknownText_0x16667:
	; How much do you want to take?
	text_jump UnknownText_0x1bd97a
	text_end

UnknownText_0x1666c:
	; Do you want to save some money?
	text_jump UnknownText_0x1bd999
	text_end

UnknownText_0x16671:
	; You haven't saved that much.
	text_jump UnknownText_0x1bd9ba
	text_end

UnknownText_0x16676:
	; You can't take that much.
	text_jump UnknownText_0x1bd9d7
	text_end

UnknownText_0x1667b:
	; You don't have that much.
	text_jump UnknownText_0x1bd9f1
	text_end

UnknownText_0x16680:
	; You can't save that much.
	text_jump UnknownText_0x1bda0b
	text_end

UnknownText_0x16685:
	; OK, I'll save your money. Trust me! , stick with it!
	text_jump UnknownText_0x1bda25
	text_end

UnknownText_0x1668a:
	; Your money's safe here! Get going!
	text_jump UnknownText_0x1bda5b
	text_end

UnknownText_0x1668f:
	; , don't give up!
	text_jump UnknownText_0x1bda7e
	text_end

UnknownText_0x16694:
	; Just do what you can.
	text_jump UnknownText_0x1bda90
	text_end

Mom_SavedString:
	db "Saved@"

Mom_WithdrawString:
	db "Withdraw@"

Mom_DepositString:
	db "Deposit@"

Mom_HeldString:
	db "Held@"

MenuDataHeader_0x166b5:
	db $40 ; flags
	db 00, 00 ; start coords
	db 10, 10 ; end coords
	dw MenuData2_0x166bd
	db 1 ; default option

MenuData2_0x166bd:
	db $80 ; flags
	db 4 ; items
	db "Get@"
	db "Save@"
	db "Change@"
	db "Cancel@"
