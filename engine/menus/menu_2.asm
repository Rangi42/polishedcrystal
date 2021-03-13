PlaceMenuItemName:
; places a star near the name if registered
	push hl
	push de
	dec de
	dec de
	ld a, " "
	ld [de], a
	ld a, [wMenuSelection]
	pop de
	pop hl
PlaceMartItemName:
	push de
	ld a, [wMenuSelection]
	cp CANCEL ; special case for Cancel in Key Items pocket
	ld de, ScrollingMenu_CancelString ; found in scrolling_menu.asm
	ld [wNamedObjectIndexBuffer], a
	call nz, GetItemName
	pop hl
	rst PlaceString
	ret

PlaceMenuTMHMName:
	push de
	ld a, [wMenuSelection]
	ld [wNamedObjectIndexBuffer], a
	call GetTMHMName
	pop hl
	rst PlaceString
	ret

PlaceMenuApricornQuantity:
	ld a, [wMenuSelection]
	ld [wCurItem], a
	and a
	ret nz
	ld l, e
	ld h, d
	jr _PlaceMenuQuantity

PlaceMenuItemQuantity:
	ld a, [wMenuSelection]
	ld [wCurItem], a
	push de
	pop hl
_PlaceMenuQuantity:
	ld de, $15
	add hl, de
	ld [hl], "×"
	inc hl
	ld de, wMenuSelectionQuantity
	lb bc, 1, 2
	jp PrintNum

PlaceMoneyTopRight:
	ld hl, MoneyTopRightMenuHeader
	call CopyMenuHeader
	jr PlaceMoneyDataHeader

PlaceMoneyBottomLeft:
	ld hl, MoneyBottomLeftMenuHeader
	call CopyMenuHeader
	jr PlaceMoneyDataHeader

PlaceMoneyAtTopLeftOfTextbox:
	ld hl, MoneyTopRightMenuHeader
	lb de, 0, 11
	call OffsetMenuDataHeader

PlaceMoneyDataHeader:
	call MenuBox
	call MenuBoxCoord2Tile
	ld de, SCREEN_WIDTH + 1
	add hl, de
	ld de, wMoney
	lb bc, PRINTNUM_MONEY | 3, 7
	jp PrintNum

MoneyTopRightMenuHeader:
	db $40 ; flags
	db 00, 10 ; start coords
	db 02, 19 ; end coords
	dw NULL
	db 1 ; default option

MoneyBottomLeftMenuHeader:
	db $40 ; flags
	db 11, 00 ; start coords
	db 13, 09 ; end coords
	dw NULL
	db 1 ; default option

PlaceBlueCardPointsTopRight:
	hlcoord 11, 0
	lb bc, 1, 7
	call Textbox
	hlcoord 12, 1
	ld de, wBlueCardBalance
	lb bc, 1, 3
	call PrintNum
	ld de, .PointsString
	rst PlaceString
	ret

.PointsString:
	db " Pts@"

PlaceBattlePointsTopRight:
	hlcoord 10, 0
	lb bc, 1, 8
	call Textbox
	hlcoord 11, 1
	ld de, wBattlePoints
	lb bc, 2, 5
	call PrintNum
	ld de, .BPString
	rst PlaceString
	ret

.BPString:
	db " BP@"

Special_DisplayCoinCaseBalance:
	; Place a text box of size 1x7 at 11, 0.
	hlcoord 11, 0
	lb bc, 1, 7
	call Textbox
	hlcoord 12, 0
	ld de, CoinString
	rst PlaceString
	ld de, wCoins
	lb bc, 2, 5
	hlcoord 13, 1
	jp PrintNum

Special_DisplayMoneyAndCoinBalance:
	hlcoord 5, 0
	lb bc, 3, 13
	call Textbox
	hlcoord 6, 1
	ld de, MoneyString
	rst PlaceString
	hlcoord 11, 1
	ld de, wMoney
	lb bc, PRINTNUM_MONEY | 3, 7
	call PrintNum
	hlcoord 6, 3
	ld de, CoinString
	rst PlaceString
	hlcoord 14, 3
	ld de, wCoins
	lb bc, 2, 5
	jp PrintNum

MoneyString:
	db "Money@"
CoinString:
	db "Coin@"

StartMenu_DrawBugContestStatusBox:
	hlcoord 0, 0
	lb bc, 5, 17
	jp Textbox

StartMenu_PrintBugContestStatus:
	ld hl, wOptions1
	ld a, [hl]
	push af
	set NO_TEXT_SCROLL, [hl]
	call StartMenu_DrawBugContestStatusBox
	hlcoord 1, 5
	ld de, .Balls
	rst PlaceString
	hlcoord 8, 5
	ld de, wParkBallsRemaining
	lb bc, PRINTNUM_LEFTALIGN | 1, 2
	call PrintNum
	hlcoord 1, 1
	ld de, .Caught
	rst PlaceString
	ld a, [wContestMon]
	and a
	ld de, .None
	jr z, .no_contest_mon
	ld [wd265], a
	call GetPokemonName

.no_contest_mon
	hlcoord 8, 1
	rst PlaceString
	ld a, [wContestMon]
	and a
	jr z, .skip_level
	hlcoord 1, 3
	ld de, .Level
	rst PlaceString
	ld a, [wContestMonLevel]
	ld h, b
	ld l, c
	inc hl
	ld c, 3
	call Print8BitNumRightAlign

.skip_level
	pop af
	ld [wOptions1], a
	ret

.Caught:
	db "Caught@"
.Balls:
	db "Balls:@"
.None:
	db "None@"
.Level:
	db "Level@"
