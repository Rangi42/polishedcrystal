CARDFLIP_LIGHT_OFF EQU $f3
CARDFLIP_LIGHT_ON  EQU $f4
CARDFLIP_DECK_SIZE EQU 4 * 6

_CardFlip:
	ld hl, wOptions1
	set NO_TEXT_SCROLL, [hl]
	call ClearBGPalettes
	call ClearTileMap
	call ClearSprites
;	ld de, MUSIC_NONE
;	call PlayMusic
	call DelayFrame
	call DisableLCD
	call LoadStandardFont
	call LoadFontsExtra

	ld hl, CardFlipLZ01
	ld de, vTiles2 tile $00
	call Decompress
	ld hl, CardFlipLZ02
	ld de, vTiles2 tile $3e
	call Decompress
	ld hl, CardFlipLZ03
	ld de, vTiles0 tile $00
	call Decompress
	ld hl, CardFlipOffButtonGFX
	ld de, vTiles1 tile (CARDFLIP_LIGHT_OFF - $80)
	ld bc, 1 tiles
	rst CopyBytes
	ld hl, CardFlipOnButtonGFX
	ld de, vTiles1 tile (CARDFLIP_LIGHT_ON - $80)
	ld bc, 1 tiles
	rst CopyBytes

	call CardFlip_InitTilemap
	call CardFlip_InitAttrPals
	call EnableLCD
	call ApplyAttrAndTilemapInVBlank
	ld a, $e4
	call DmgToCgbBGPals
	ld de, $e4e4
	call DmgToCgbObjPals
	call DelayFrame
	xor a
	ld [wJumptableIndex], a
	ld a, $2
	ld [wCardFlipCursorY], a
	ld [wCardFlipCursorX], a

;	ld de, MUSIC_GAME_CORNER
;	ld a, [wMapGroup]
;	cp GROUP_GOLDENROD_GAME_CORNER
;	jr nz, .celadon_game_corner
;	ld a, [wMapNumber]
;	cp MAP_GOLDENROD_GAME_CORNER
;	jr nz, .celadon_game_corner
;	ld de, MUSIC_GAME_CORNER_DPPT
;.celadon_game_corner
;	call PlayMusic

.MasterLoop:
	ld a, [wJumptableIndex]
	bit 7, a
	jr nz, .leavethegame
	call .CardFlip
	jr .MasterLoop
.leavethegame
	call WaitSFX
	ld de, SFX_QUIT_SLOTS
	call PlaySFX
	call WaitSFX
	call ClearBGPalettes
	ld hl, wOptions1
	res NO_TEXT_SCROLL, [hl]
	ret

.CardFlip:
	call StandardStackJumpTable

.Jumptable:
	dw .AskPlayWithThree
	dw .DeductCoins
	dw .ChooseACard
	dw .PlaceYourBet
	dw .CheckTheCard
	dw .TabulateTheResult
	dw .PlayAgain
	dw .Quit

.AskPlayWithThree:
	ld hl, .PlayWithThreeCoinsText
	call CardFlip_UpdateCoinBalanceDisplay
	call YesNoBox
	jr c, .SaidNo
	call CardFlip_ShuffleDeck
	; fallthrough

.Increment:
	ld hl, wJumptableIndex
	inc [hl]
	ret

.SaidNo:
	ld a, 7
	ld [wJumptableIndex], a
	ret

.PlayWithThreeCoinsText:
	; Play with three coins?
	text_far _CardFlipPlayWithThreeCoinsText
	text_end

.DeductCoins:
	ld hl, wCoins
	ld a, [hli]
	ld l, [hl]
	ld h, a
	and a
	jr nz, .deduct ; You have at least 256 coins.
	ld a, l
	cp 3
	jr nc, .deduct ; You have at least 3 coins.
	ld hl, .NotEnoughCoinsText
	call CardFlip_UpdateCoinBalanceDisplay
	ld a, 7
	ld [wJumptableIndex], a
	ret

.deduct
	ld de, -3
	add hl, de
	ld a, h
	ld [wCoins], a
	ld a, l
	ld [wCoins + 1], a
	ld de, SFX_TRANSACTION
	call PlaySFX
	xor a
	ldh [hBGMapMode], a
	call CardFlip_PrintCoinBalance
	ld a, $1
	ldh [hBGMapMode], a
	call WaitSFX
	jr .Increment

.NotEnoughCoinsText:
	; Not enough coins…
	text_far _CardFlipNotEnoughCoinsText
	text_end

.ChooseACard:
	xor a
	ldh [hBGMapMode], a
	hlcoord 0, 0
	lb bc, 12, 9
	ld a, $29
	call FillBoxWithByte
	hlcoord 9, 0
	ld bc, SCREEN_WIDTH
	ld a, [wCardFlipNumCardsPlayed]
	rst AddNTimes
	ld [hl], CARDFLIP_LIGHT_ON
	ld a, $1
	ldh [hBGMapMode], a
	ld c, 20
	call DelayFrames
	hlcoord 2, 0
	call PlaceCardFaceDown
	ld a, $1
	ldh [hBGMapMode], a
	ld c, 20
	call DelayFrames
	hlcoord 2, 6
	call PlaceCardFaceDown
	call ApplyTilemapInVBlank
	ld hl, .ChooseACardText
	call CardFlip_UpdateCoinBalanceDisplay
	xor a
	ld [wCardFlipWhichCard], a
.loop
	call JoyTextDelay
	ldh a, [hJoyLast]
	and A_BUTTON
	jr nz, .next
	ld de, SFX_KINESIS
	call PlaySFX
	call PlaceOAMCardBorder
	ld c, 4
	call DelayFrames
	ld hl, wCardFlipWhichCard
	ld a, [hl]
	xor $1
	ld [hl], a
	jr .loop

.next
	ld de, SFX_SLOT_MACHINE_START
	call PlaySFX
	ld a, $3
.loop2
	push af
	call PlaceOAMCardBorder
	ld c, 4
	call DelayFrames
	call ClearSprites
	ld c, 4
	call DelayFrames
	pop af
	dec a
	jr nz, .loop2
	ld hl, wCardFlipWhichCard
	ld a, [hl]
	push af
	xor $1
	ld [hl], a
	call GetCoordsOfChosenCard
	lb bc, 6, 5
	ld a, $29
	call FillBoxWithByte
	pop af
	ld [wCardFlipWhichCard], a
	jmp .Increment

.ChooseACardText:
	; Choose a card.
	text_far _CardFlipChooseACardText
	text_end

.PlaceYourBet:
	ld hl, .PlaceYourBetText
	call CardFlip_UpdateCoinBalanceDisplay
.betloop
	call JoyTextDelay
	ldh a, [hJoyLast]
	and A_BUTTON
	jmp nz, .Increment
	call ChooseCard_HandleJoypad
	call CardFlip_UpdateCursorOAM
	call DelayFrame
	jr .betloop

.PlaceYourBetText:
	; Place your bet.
	text_far _CardFlipPlaceYourBetText
	text_end

.CheckTheCard:
	xor a
	ldh [hVBlankCounter], a
	call CardFlip_UpdateCursorOAM
	call WaitSFX
	ld de, SFX_CHOOSE_A_CARD
	call PlaySFX
	call WaitSFX
	ld a, [wCardFlipNumCardsPlayed]
	ld e, a
	ld d, 0
	ld hl, wDeck
	add hl, de
	add hl, de
	ld a, [wCardFlipWhichCard]
	ld e, a
	add hl, de
	ld a, [hl]
	ld [wCardFlipFaceUpCard], a
	ld e, a
	ld hl, wDiscardPile
	add hl, de
	ld [hl], TRUE
	call GetCoordsOfChosenCard
	call CardFlip_DisplayCardFaceUp
	call ApplyAttrAndTilemapInVBlank
	jmp .Increment

.TabulateTheResult:
	call CardFlip_CheckWinCondition
	call WaitPressAorB_BlinkCursor
	jmp .Increment

.PlayAgain:
	call ClearSprites
	ld hl, .PlayAgainText
	call CardFlip_UpdateCoinBalanceDisplay
	call YesNoBox
	jmp c, .Increment
	ld a, [wCardFlipNumCardsPlayed]
	inc a
	ld [wCardFlipNumCardsPlayed], a
	cp 12
	jr c, .KeepTheCurrentDeck
	call CardFlip_InitTilemap
	ld a, $1
	ldh [hBGMapMode], a
	call CardFlip_ShuffleDeck
	ld hl, .CardsShuffledText
	call PrintText
	jr .LoopAround

.KeepTheCurrentDeck:
	call CardFlip_BlankDiscardedCardSlot

.LoopAround:
	ld a, 1
	ld [wJumptableIndex], a
	ret

.PlayAgainText:
	; Want to play again?
	text_far _CardFlipPlayAgainText
	text_end

.CardsShuffledText:
	; The cards have been shuffled.
	text_far _CardFlipShuffledText
	text_end

.Quit:
	ld hl, wJumptableIndex
	set 7, [hl]
	ret

CardFlip_ShuffleDeck:
	ld hl, wDeck
	ld bc, CARDFLIP_DECK_SIZE
	xor a
	rst ByteFill
	ld de, wDeck
	ld c, CARDFLIP_DECK_SIZE - 1
.loop
	call Random
	and $1f
	cp CARDFLIP_DECK_SIZE
	jr nc, .loop
	ld l, a
	ld h, $0
	add hl, de
	ld a, [hl]
	and a
	jr nz, .loop
	ld [hl], c
	dec c
	jr nz, .loop
	xor a
	ld [wCardFlipNumCardsPlayed], a
	ld hl, wDiscardPile
	ld bc, CARDFLIP_DECK_SIZE
	rst ByteFill
	ret

CollapseCursorPosition:
	ld hl, 0
	ld bc, 6
	ld a, [wCardFlipCursorY]
	rst AddNTimes
	ld b, 0
	ld a, [wCardFlipCursorX]
	ld c, a
	add hl, bc
	ret

GetCoordsOfChosenCard:
	ld a, [wCardFlipWhichCard]
	and a
	jr nz, .BottomCard
	hlcoord 2, 0
	bcpixel 2, 3
	ret

.BottomCard:
	hlcoord 2, 6
	bcpixel 8, 3
	ret

PlaceCardFaceDown:
	xor a
	ldh [hBGMapMode], a
	ld de, .FaceDownCardTilemap
	lb bc, 6, 5
	jmp CardFlip_CopyToBox

.FaceDownCardTilemap:
	db $08, $09, $09, $09, $0a
	db $0b, $28, $2b, $28, $0c
	db $0b, $2c, $2d, $2e, $0c
	db $0b, $2f, $30, $31, $0c
	db $0b, $32, $33, $34, $0c
	db $0d, $0e, $0e, $0e, $0f

CardFlip_DisplayCardFaceUp:
	xor a
	ldh [hBGMapMode], a
	push hl
	push hl
	; Flip the card face up.
	ld de, .FaceUpCardTilemap
	lb bc, 6, 5
	call CardFlip_CopyToBox

	; Get the level and species of the upturned card.
	ld a, [wCardFlipFaceUpCard]
	ld e, a
	ld d, 0
	ld hl, .Deck
	add hl, de
	add hl, de
	ld a, [hli]
	ld e, a
	ld d, [hl]

	; Place the level.
	pop hl
	ld bc, 3 + SCREEN_WIDTH
	add hl, bc
	ld [hl], e

	; Place the Pokepic.
	ld bc, SCREEN_HEIGHT
	add hl, bc
	ld a, d
	ld de, SCREEN_WIDTH
	ld b, 3
.row
	push hl
	ld c, 3
.col
	ld [hli], a
	inc a
	dec c
	jr nz, .col
	pop hl
	add hl, de
	dec b
	jr nz, .row
	pop hl

	; Set the attributes
	ld de, wAttrMap - wTileMap
	add hl, de
	ld a, [wCardFlipFaceUpCard]
	and 3
	inc a
	lb bc, 6, 5
	jmp FillBoxWithByte

.FaceUpCardTilemap:
	db $18, $19, $19, $19, $1a
	db $1b, $35, $7f, $7f, $1c
	db $0b, $28, $28, $28, $0c
	db $0b, $28, $28, $28, $0c
	db $0b, $28, $28, $28, $0c
	db $1d, $1e, $1e, $1e, $1f

.Deck:
	; level, pic anchor (3x3)
	db "1",$4e, "1",$57, "1",$69, "1",$60
	db "2",$4e, "2",$57, "2",$69, "2",$60
	db "3",$4e, "3",$57, "3",$69, "3",$60
	db "4",$4e, "4",$57, "4",$69, "4",$60
	db "5",$4e, "5",$57, "5",$69, "5",$60
	db "6",$4e, "6",$57, "6",$69, "6",$60

CardFlip_UpdateCoinBalanceDisplay:
	push hl
	hlcoord 0, 12
	lb bc, 4, SCREEN_WIDTH - 2
	call Textbox
	pop hl
	call PrintTextboxText
	; fallthrough

CardFlip_PrintCoinBalance:
	hlcoord 8, 15
	lb bc, 1, 10
	call Textbox
	hlcoord 9, 16
	ld de, .CoinStr
	rst PlaceString
	hlcoord 14, 16
	ld de, wCoins
	lb bc, PRINTNUM_LEADINGZEROS | 2, 5
	jmp PrintNum

.CoinStr:
	db "Coin@"

CardFlip_InitTilemap:
	xor a
	ldh [hBGMapMode], a
	hlcoord 0, 0
	ld bc, SCREEN_HEIGHT * SCREEN_WIDTH
	ld a, $29
	rst ByteFill
	hlcoord 9, 0
	ld de, CardFlipTilemap
	lb bc, 12, 11
	call CardFlip_CopyToBox
	hlcoord 0, 12
	lb bc, 4, 18
	jmp Textbox

CardFlip_CopyToBox:
.row
	push bc
	push hl
.col
	ld a, [de]
	inc de
	ld [hli], a
	dec c
	jr nz, .col
	pop hl
	ld bc, SCREEN_WIDTH
	add hl, bc
	pop bc
	dec b
	jr nz, .row
	ret

CardFlip_CopyOAM:
	ld de, wVirtualOAM
	ld a, [hli]
.loop
	push af
	ld a, [hli]
	add b
	ld [de], a
	inc de
	ld a, [hli]
	add c
	ld [de], a
	inc de
	ld a, [hli]
	ld [de], a
	inc de
	ld a, [hli]
	ld [de], a
	inc de
	pop af
	dec a
	jr nz, .loop
	ret

CardFlip_BlankDiscardedCardSlot:
	xor a
	ldh [hBGMapMode], a
	ld a, [wCardFlipFaceUpCard]
	ld e, a
	ld d, 0

	and 3 ; get mon
	ld c, a
	ld b, 0

	ld a, e
	and %0011100 ; get level
	srl a
	srl a
	call StackJumpTable

.Jumptable:
	dw .Level1
	dw .Level2
	dw .Level3
	dw .Level4
	dw .Level5
	dw .Level6

.Level1:
	ld hl, wDiscardPile + 4
	add hl, de
	ld a, [hl]
	and a
	jr nz, .discarded2
	hlcoord 13, 3
	add hl, bc
	add hl, bc
	ld [hl], $36
	ld bc, SCREEN_WIDTH
	add hl, bc
	ld [hl], $37
	ret

.discarded2
	hlcoord 13, 3
	add hl, bc
	add hl, bc
	ld [hl], $36
	ld bc, SCREEN_WIDTH
	add hl, bc
	ld [hl], $3d
	ret

.Level2:
	ld hl, wDiscardPile - 4
	add hl, de
	ld a, [hl]
	and a
	jr nz, .discarded1
	hlcoord 13, 4
	add hl, bc
	add hl, bc
	ld [hl], $3b
	ld bc, SCREEN_WIDTH
	add hl, bc
	ld [hl], $3a
	ret

.discarded1
	hlcoord 13, 4
	add hl, bc
	add hl, bc
	ld [hl], $3d
	ld bc, SCREEN_WIDTH
	add hl, bc
	ld [hl], $3a
	ret

.Level3:
	ld hl, wDiscardPile + 4
	add hl, de
	ld a, [hl]
	and a
	jr nz, .discarded4
	hlcoord 13, 6
	add hl, bc
	add hl, bc
	ld [hl], $36
	ld bc, SCREEN_WIDTH
	add hl, bc
	ld [hl], $38
	ret

.discarded4
	hlcoord 13, 6
	add hl, bc
	add hl, bc
	ld [hl], $36
	ld bc, SCREEN_WIDTH
	add hl, bc
	ld [hl], $3d
	ret

.Level4:
	ld hl, wDiscardPile - 4
	add hl, de
	ld a, [hl]
	and a
	jr nz, .discarded3
	hlcoord 13, 7
	add hl, bc
	add hl, bc
	ld [hl], $3c
	ld bc, SCREEN_WIDTH
	add hl, bc
	ld [hl], $3a
	ret

.discarded3
	hlcoord 13, 7
	add hl, bc
	add hl, bc
	ld [hl], $3d
	ld bc, SCREEN_WIDTH
	add hl, bc
	ld [hl], $3a
	ret

.Level5:
	ld hl, wDiscardPile + 4
	add hl, de
	ld a, [hl]
	and a
	jr nz, .discarded6
	hlcoord 13, 9
	add hl, bc
	add hl, bc
	ld [hl], $36
	ld bc, SCREEN_WIDTH
	add hl, bc
	ld [hl], $39
	ret

.discarded6
	hlcoord 13, 9
	add hl, bc
	add hl, bc
	ld [hl], $36
	ld bc, SCREEN_WIDTH
	add hl, bc
	ld [hl], $3d
	ret

.Level6:
	ld hl, wDiscardPile - 4
	add hl, de
	ld a, [hl]
	and a
	jr nz, .discarded5
	hlcoord 13, 10
	add hl, bc
	add hl, bc
	ld [hl], $3c
	ld bc, SCREEN_WIDTH
	add hl, bc
	ld [hl], $3a
	ret

.discarded5
	hlcoord 13, 10
	add hl, bc
	add hl, bc
	ld [hl], $3d
	ld bc, SCREEN_WIDTH
	add hl, bc
	ld [hl], $3a
	ret

CardFlip_CheckWinCondition:
	call CollapseCursorPosition
	ld a, l
	call StackJumpTable

.Jumptable:
	dw .Impossible
	dw .Impossible
	dw .PikaJiggly
	dw .PikaJiggly
	dw .PoliOddish
	dw .PoliOddish

	dw .Impossible
	dw .Impossible
	dw .Pikachu
	dw .Jigglypuff
	dw .Poliwag
	dw .Oddish

	dw .OneTwo
	dw .One
	dw .PikaOne
	dw .JigglyOne
	dw .PoliOne
	dw .OddOne

	dw .OneTwo
	dw .Two
	dw .PikaTwo
	dw .JigglyTwo
	dw .PoliTwo
	dw .OddTwo

	dw .ThreeFour
	dw .Three
	dw .PikaThree
	dw .JigglyThree
	dw .PoliThree
	dw .OddThree

	dw .ThreeFour
	dw .Four
	dw .PikaFour
	dw .JigglyFour
	dw .PoliFour
	dw .OddFour

	dw .FiveSix
	dw .Five
	dw .PikaFive
	dw .JigglyFive
	dw .PoliFive
	dw .OddFive

	dw .FiveSix
	dw .Six
	dw .PikaSix
	dw .JigglySix
	dw .PoliSix
	dw .OddSix

.Impossible:
	jmp .Lose

.PikaJiggly:
	ld a, [wCardFlipFaceUpCard]
	and $2
	jmp nz, .Lose
	jr .WinSix

.PoliOddish:
	ld a, [wCardFlipFaceUpCard]
	and $2
	jmp z, .Lose
	; fallthrough

.WinSix:
	ld c, $6
	ld de, SFX_2ND_PLACE
	jmp .Payout

.OneTwo:
	ld a, [wCardFlipFaceUpCard]
	and $18
	jr z, .WinNine
	jmp .Lose

.ThreeFour:
	ld a, [wCardFlipFaceUpCard]
	and $18
	cp $8
	jr z, .WinNine
	jmp .Lose

.FiveSix:
	ld a, [wCardFlipFaceUpCard]
	and $18
	cp $10
	jmp nz, .Lose
	; fallthrough

.WinNine:
	ld c, $9
	ld de, SFX_2ND_PLACE
	jmp .Payout

.Pikachu:
	ld a, [wCardFlipFaceUpCard]
	and $3
	jr z, .WinTwelve
	jmp .Lose

.Jigglypuff:
	ld a, [wCardFlipFaceUpCard]
	and $3
	cp $1
	jr z, .WinTwelve
	jmp .Lose

.Poliwag:
	ld a, [wCardFlipFaceUpCard]
	and $3
	cp $2
	jr z, .WinTwelve
	jmp .Lose

.Oddish:
	ld a, [wCardFlipFaceUpCard]
	and $3
	cp $3
	jmp nz, .Lose
	; fallthrough

.WinTwelve:
	ld c, $c
	ld de, SFX_2ND_PLACE
	jmp .Payout

.One:
	ld a, [wCardFlipFaceUpCard]
	and $1c
	jr z, .WinEighteen
	jmp .Lose

.Two:
	ld a, [wCardFlipFaceUpCard]
	and $1c
	cp $4
	jr z, .WinEighteen
	jmp .Lose

.Three:
	ld a, [wCardFlipFaceUpCard]
	and $1c
	cp $8
	jr z, .WinEighteen
	jmp .Lose

.Four:
	ld a, [wCardFlipFaceUpCard]
	and $1c
	cp $c
	jr z, .WinEighteen
	jmp .Lose

.Five:
	ld a, [wCardFlipFaceUpCard]
	and $1c
	cp $10
	jr z, .WinEighteen
	jr .Lose

.Six:
	ld a, [wCardFlipFaceUpCard]
	and $1c
	cp $14
	jr nz, .Lose
	; fallthrough

.WinEighteen:
	ld c, $12
	ld de, SFX_2ND_PLACE
	jr .Payout

.PikaOne:
	ld e, $0
	jr .CheckWin72

.JigglyOne:
	ld e, $1
	jr .CheckWin72

.PoliOne:
	ld e, $2
	jr .CheckWin72

.OddOne:
	ld e, $3
	jr .CheckWin72

.PikaTwo:
	ld e, $4
	jr .CheckWin72

.JigglyTwo:
	ld e, $5
	jr .CheckWin72

.PoliTwo:
	ld e, $6
	jr .CheckWin72

.OddTwo:
	ld e, $7
	jr .CheckWin72

.PikaThree:
	ld e, $8
	jr .CheckWin72

.JigglyThree:
	ld e, $9
	jr .CheckWin72

.PoliThree:
	ld e, $a
	jr .CheckWin72

.OddThree:
	ld e, $b
	jr .CheckWin72

.PikaFour:
	ld e, $c
	jr .CheckWin72

.JigglyFour:
	ld e, $d
	jr .CheckWin72

.PoliFour:
	ld e, $e
	jr .CheckWin72

.OddFour:
	ld e, $f
	jr .CheckWin72

.PikaFive:
	ld e, $10
	jr .CheckWin72

.JigglyFive:
	ld e, $11
	jr .CheckWin72

.PoliFive:
	ld e, $12
	jr .CheckWin72

.OddFive:
	ld e, $13
	jr .CheckWin72

.PikaSix:
	ld e, $14
	jr .CheckWin72

.JigglySix:
	ld e, $15
	jr .CheckWin72

.PoliSix:
	ld e, $16
	jr .CheckWin72

.OddSix:
	ld e, $17

.CheckWin72:
	ld a, [wCardFlipFaceUpCard]
	cp e
	jr nz, .Lose
	ld c, 72
	ld de, SFX_2ND_PLACE
	jr .Payout

.Lose:
	ld de, SFX_WRONG
	call PlaySFX
	ld hl, .Text_Darn
	call CardFlip_UpdateCoinBalanceDisplay
	jmp WaitSFX

.Payout:
	push bc
	push de
	ld hl, .Text_Yeah
	call CardFlip_UpdateCoinBalanceDisplay
	pop de
	call PlaySFX
	call WaitSFX
	pop bc
.loop
	push bc
	call .IsCoinCaseFull
	call nc, .AddCoinPlaySFX
	call CardFlip_PrintCoinBalance
	ld c, 2
	call DelayFrames
	pop bc
	dec c
	jr nz, .loop
	ret

.Text_Yeah:
	; Yeah!
	text_far _CardFlipYeahText
	text_end

.Text_Darn:
	; Darn…
	text_far _CardFlipDarnText
	text_end

.AddCoinPlaySFX:
	ld hl, wCoins
	ld a, [hli]
	ld l, [hl]
	ld h, a
	inc hl
	ld a, h
	ld [wCoins], a
	ld a, l
	ld [wCoins + 1], a
	ld de, SFX_PAY_DAY
	jmp PlaySFX

.IsCoinCaseFull:
	ld a, [wCoins]
	cp HIGH(50000)
	jr c, .less
	jr nz, .more

	ld a, [wCoins + 1]
	cp LOW(50000)
	jr c, .less

.more
	scf
	ret

.less
	and a
	ret

PlaceOAMCardBorder:
	call GetCoordsOfChosenCard
	ld hl, .SpriteData
	jmp CardFlip_CopyOAM

.SpriteData:
	db 18
	dsprite 0, 0, 0, 0, $04, $0
	dsprite 0, 0, 1, 0, $06, $0
	dsprite 0, 0, 2, 0, $06, $0
	dsprite 0, 0, 3, 0, $06, $0
	dsprite 0, 0, 4, 0, $04, $0 | X_FLIP

	dsprite 1, 0, 0, 0, $05, $0
	dsprite 1, 0, 4, 0, $05, $0 | X_FLIP

	dsprite 2, 0, 0, 0, $05, $0
	dsprite 2, 0, 4, 0, $05, $0 | X_FLIP

	dsprite 3, 0, 0, 0, $05, $0
	dsprite 3, 0, 4, 0, $05, $0 | X_FLIP

	dsprite 4, 0, 0, 0, $05, $0
	dsprite 4, 0, 4, 0, $05, $0 | X_FLIP

	dsprite 5, 0, 0, 0, $04, $0 | Y_FLIP
	dsprite 5, 0, 1, 0, $06, $0 | Y_FLIP
	dsprite 5, 0, 2, 0, $06, $0 | Y_FLIP
	dsprite 5, 0, 3, 0, $06, $0 | Y_FLIP
	dsprite 5, 0, 4, 0, $04, $0 | X_FLIP | Y_FLIP

ChooseCard_HandleJoypad:
	ld hl, hJoyLast
	ld a, [hl]
	and D_LEFT
	jr nz, .d_left
	ld a, [hl]
	and D_RIGHT
	jr nz, .d_right
	ld a, [hl]
	and D_UP
	jr nz, .d_up
	ld a, [hl]
	and D_DOWN
	jmp nz, .d_down
	ret

.d_left
	ld hl, wCardFlipCursorX
	ld a, [wCardFlipCursorY]
	and a
	jr z, .mon_pair_left
	cp $1
	jr z, .mon_group_left
	ld a, [hl]
	and a
	ret z
	dec [hl]
	jmp .play_sound

.mon_group_left
	ld a, [hl]
	cp $3
	jr c, .left_to_number_gp
	dec [hl]
	jmp .play_sound

.mon_pair_left
	ld a, [hl]
	and $e
	ld [hl], a
	cp $3
	jr c, .left_to_number_gp
	dec [hl]
	dec [hl]
	jr .play_sound

.left_to_number_gp
	ld a, $2
	ld [wCardFlipCursorY], a
	ld a, $1
	ld [wCardFlipCursorX], a
	jr .play_sound

.d_right
	ld hl, wCardFlipCursorX
	ld a, [wCardFlipCursorY]
	and a
	jr z, .mon_pair_right
	ld a, [hl]
	cp $5
	ret nc
	inc [hl]
	jr .play_sound

.mon_pair_right
	ld a, [hl]
	and $e
	ld [hl], a
	cp $4
	ret nc
	inc [hl]
	inc [hl]
	jr .play_sound

.d_up
	ld hl, wCardFlipCursorY
	ld a, [wCardFlipCursorX]
	and a
	jr z, .num_pair_up
	cp $1
	jr z, .num_gp_up
	ld a, [hl]
	and a
	ret z
	dec [hl]
	jr .play_sound

.num_gp_up
	ld a, [hl]
	cp $3
	jr c, .up_to_mon_group
	dec [hl]
	jr .play_sound

.num_pair_up
	ld a, [hl]
	and $e
	ld [hl], a
	cp $3
	jr c, .up_to_mon_group
	dec [hl]
	dec [hl]
	jr .play_sound

.up_to_mon_group
	ld a, $1
	ld [wCardFlipCursorY], a
	ld a, $2
	ld [wCardFlipCursorX], a
	jr .play_sound

.d_down
	ld hl, wCardFlipCursorY
	ld a, [wCardFlipCursorX]
	and a
	jr z, .num_pair_down
	ld hl, wCardFlipCursorY
	ld a, [hl]
	cp $7
	ret nc
	inc [hl]
	jr .play_sound

.num_pair_down
	ld a, [hl]
	and $e
	ld [hl], a
	cp $6
	ret nc
	inc [hl]
	inc [hl]

.play_sound
	ld de, SFX_POKEBALLS_PLACED_ON_TABLE
	jmp PlaySFX

CardFlip_UpdateCursorOAM:
	call ClearSprites
	call CollapseCursorPosition
	add hl, hl
	add hl, hl
	ld de, .OAMData
	add hl, de
	ld a, [hli]
	ld c, a
	ld a, [hli]
	ld b, a
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jmp CardFlip_CopyOAM

.OAMData:
cardflip_cursor: MACRO
if _NARG >= 5
	dbpixel \1, \2, \3, \4
	dw \5
else
	dbpixel \1, \2
	dw \3
endc
ENDM

	cardflip_cursor 11,  2,       .Impossible
	cardflip_cursor 12,  2,       .Impossible
	cardflip_cursor 13,  2,       .PokeGroupPair
	cardflip_cursor 13,  2,       .PokeGroupPair
	cardflip_cursor 17,  2,       .PokeGroupPair
	cardflip_cursor 17,  2,       .PokeGroupPair

	cardflip_cursor 11,  3,       .Impossible
	cardflip_cursor 12,  3,       .Impossible
	cardflip_cursor 13,  3,       .PokeGroup
	cardflip_cursor 15,  3,       .PokeGroup
	cardflip_cursor 17,  3,       .PokeGroup
	cardflip_cursor 19,  3,       .PokeGroup

	cardflip_cursor 11,  5,       .NumGroupPair
	cardflip_cursor 12,  5,       .NumGroup
	cardflip_cursor 13,  5,       .SingleTile
	cardflip_cursor 15,  5,       .SingleTile
	cardflip_cursor 17,  5,       .SingleTile
	cardflip_cursor 19,  5,       .SingleTile

	cardflip_cursor 11,  5,       .NumGroupPair
	cardflip_cursor 12,  6, 0, 4, .NumGroup
	cardflip_cursor 13,  6, 0, 4, .SingleTile
	cardflip_cursor 15,  6, 0, 4, .SingleTile
	cardflip_cursor 17,  6, 0, 4, .SingleTile
	cardflip_cursor 19,  6, 0, 4, .SingleTile

	cardflip_cursor 11,  8,       .NumGroupPair
	cardflip_cursor 12,  8,       .NumGroup
	cardflip_cursor 13,  8,       .SingleTile
	cardflip_cursor 15,  8,       .SingleTile
	cardflip_cursor 17,  8,       .SingleTile
	cardflip_cursor 19,  8,       .SingleTile

	cardflip_cursor 11,  8,       .NumGroupPair
	cardflip_cursor 12,  9, 0, 4, .NumGroup
	cardflip_cursor 13,  9, 0, 4, .SingleTile
	cardflip_cursor 15,  9, 0, 4, .SingleTile
	cardflip_cursor 17,  9, 0, 4, .SingleTile
	cardflip_cursor 19,  9, 0, 4, .SingleTile

	cardflip_cursor 11, 11,       .NumGroupPair
	cardflip_cursor 12, 11,       .NumGroup
	cardflip_cursor 13, 11,       .SingleTile
	cardflip_cursor 15, 11,       .SingleTile
	cardflip_cursor 17, 11,       .SingleTile
	cardflip_cursor 19, 11,       .SingleTile

	cardflip_cursor 11, 11,       .NumGroupPair
	cardflip_cursor 12, 12, 0, 4, .NumGroup
	cardflip_cursor 13, 12, 0, 4, .SingleTile
	cardflip_cursor 15, 12, 0, 4, .SingleTile
	cardflip_cursor 17, 12, 0, 4, .SingleTile
	cardflip_cursor 19, 12, 0, 4, .SingleTile

.SingleTile:
	db 6
	dsprite   0, 0,  -1, 7, $00, $0 | PRIORITY
	dsprite   0, 0,   0, 0, $02, $0 | PRIORITY
	dsprite   0, 0,   1, 0, $03, $0 | PRIORITY
	dsprite   0, 5,  -1, 7, $00, $0 | Y_FLIP | PRIORITY
	dsprite   0, 5,   0, 0, $02, $0 | Y_FLIP | PRIORITY
	dsprite   0, 5,   1, 0, $03, $0 | PRIORITY

.PokeGroup:
	db 26
	dsprite   0, 0,  -1, 7, $00, $0 | PRIORITY
	dsprite   0, 0,   0, 0, $02, $0 | PRIORITY
	dsprite   0, 0,   1, 0, $00, $0 | X_FLIP | PRIORITY
	dsprite   1, 0,  -1, 7, $01, $0 | PRIORITY
	dsprite   1, 0,   1, 0, $01, $0 | X_FLIP | PRIORITY
	dsprite   2, 0,  -1, 7, $01, $0 | PRIORITY
	dsprite   2, 0,   1, 0, $03, $0 | PRIORITY
	dsprite   3, 0,  -1, 7, $01, $0 | PRIORITY
	dsprite   3, 0,   1, 0, $03, $0 | PRIORITY
	dsprite   4, 0,  -1, 7, $01, $0 | PRIORITY
	dsprite   4, 0,   1, 0, $03, $0 | PRIORITY
	dsprite   5, 0,  -1, 7, $01, $0 | PRIORITY
	dsprite   5, 0,   1, 0, $03, $0 | PRIORITY
	dsprite   6, 0,  -1, 7, $01, $0 | PRIORITY
	dsprite   6, 0,   1, 0, $03, $0 | PRIORITY
	dsprite   7, 0,  -1, 7, $01, $0 | PRIORITY
	dsprite   7, 0,   1, 0, $03, $0 | PRIORITY
	dsprite   8, 0,  -1, 7, $01, $0 | PRIORITY
	dsprite   8, 0,   1, 0, $03, $0 | PRIORITY
	dsprite   9, 0,  -1, 7, $01, $0 | PRIORITY
	dsprite   9, 0,   1, 0, $03, $0 | PRIORITY
	dsprite  10, 0,  -1, 7, $01, $0 | PRIORITY
	dsprite  10, 0,   1, 0, $03, $0 | PRIORITY
	dsprite  10, 1,  -1, 7, $00, $0 | Y_FLIP | PRIORITY
	dsprite  10, 1,   0, 0, $02, $0 | Y_FLIP | PRIORITY
	dsprite  10, 1,   1, 0, $03, $0 | PRIORITY

.NumGroup:
	db 20
	dsprite   0, 0,  -1, 7, $00, $0 | PRIORITY
	dsprite   0, 0,   0, 0, $02, $0 | PRIORITY
	dsprite   0, 0,   1, 0, $02, $0 | PRIORITY
	dsprite   0, 0,   2, 0, $03, $0 | PRIORITY
	dsprite   0, 0,   3, 0, $02, $0 | PRIORITY
	dsprite   0, 0,   4, 0, $03, $0 | PRIORITY
	dsprite   0, 0,   5, 0, $02, $0 | PRIORITY
	dsprite   0, 0,   6, 0, $03, $0 | PRIORITY
	dsprite   0, 0,   7, 0, $02, $0 | PRIORITY
	dsprite   0, 0,   8, 0, $03, $0 | PRIORITY
	dsprite   0, 5,  -1, 7, $00, $0 | Y_FLIP | PRIORITY
	dsprite   0, 5,   0, 0, $02, $0 | Y_FLIP | PRIORITY
	dsprite   0, 5,   1, 0, $02, $0 | Y_FLIP | PRIORITY
	dsprite   0, 5,   2, 0, $03, $0 | PRIORITY
	dsprite   0, 5,   3, 0, $02, $0 | Y_FLIP | PRIORITY
	dsprite   0, 5,   4, 0, $03, $0 | PRIORITY
	dsprite   0, 5,   5, 0, $02, $0 | Y_FLIP | PRIORITY
	dsprite   0, 5,   6, 0, $03, $0 | PRIORITY
	dsprite   0, 5,   7, 0, $02, $0 | Y_FLIP | PRIORITY
	dsprite   0, 5,   8, 0, $03, $0 | PRIORITY

.NumGroupPair:
	db 30
	dsprite   0, 0,   0, 0, $00, $0 | PRIORITY
	dsprite   0, 0,   1, 0, $02, $0 | PRIORITY
	dsprite   0, 0,   2, 0, $02, $0 | PRIORITY
	dsprite   0, 0,   3, 0, $03, $0 | PRIORITY
	dsprite   0, 0,   4, 0, $02, $0 | PRIORITY
	dsprite   0, 0,   5, 0, $03, $0 | PRIORITY
	dsprite   0, 0,   6, 0, $02, $0 | PRIORITY
	dsprite   0, 0,   7, 0, $03, $0 | PRIORITY
	dsprite   0, 0,   8, 0, $02, $0 | PRIORITY
	dsprite   0, 0,   9, 0, $03, $0 | PRIORITY
	dsprite   1, 0,   0, 0, $01, $0 | PRIORITY
	dsprite   1, 0,   3, 0, $03, $0 | PRIORITY
	dsprite   1, 0,   5, 0, $03, $0 | PRIORITY
	dsprite   1, 0,   7, 0, $03, $0 | PRIORITY
	dsprite   1, 0,   9, 0, $03, $0 | PRIORITY
	dsprite   2, 0,   0, 0, $01, $0 | PRIORITY
	dsprite   2, 0,   3, 0, $03, $0 | PRIORITY
	dsprite   2, 0,   5, 0, $03, $0 | PRIORITY
	dsprite   2, 0,   7, 0, $03, $0 | PRIORITY
	dsprite   2, 0,   9, 0, $03, $0 | PRIORITY
	dsprite   2, 1,   0, 0, $00, $0 | Y_FLIP | PRIORITY
	dsprite   2, 1,   1, 0, $02, $0 | Y_FLIP | PRIORITY
	dsprite   2, 1,   2, 0, $02, $0 | Y_FLIP | PRIORITY
	dsprite   2, 1,   3, 0, $03, $0 | PRIORITY
	dsprite   2, 1,   4, 0, $03, $0 | PRIORITY
	dsprite   2, 1,   5, 0, $03, $0 | PRIORITY
	dsprite   2, 1,   6, 0, $03, $0 | PRIORITY
	dsprite   2, 1,   7, 0, $03, $0 | PRIORITY
	dsprite   2, 1,   8, 0, $03, $0 | PRIORITY
	dsprite   2, 1,   9, 0, $03, $0 | PRIORITY

.PokeGroupPair:
	db 38
	dsprite   0, 0,  -1, 7, $00, $0 | PRIORITY
	dsprite   0, 0,   3, 0, $00, $0 | X_FLIP | PRIORITY
	dsprite   1, 0,  -1, 7, $01, $0 | PRIORITY
	dsprite   1, 0,   3, 0, $01, $0 | X_FLIP | PRIORITY
	dsprite   2, 0,  -1, 7, $01, $0 | PRIORITY
	dsprite   2, 0,   3, 0, $01, $0 | X_FLIP | PRIORITY
	dsprite   3, 0,  -1, 7, $01, $0 | PRIORITY
	dsprite   3, 0,   1, 0, $03, $0 | PRIORITY
	dsprite   3, 0,   3, 0, $03, $0 | PRIORITY
	dsprite   4, 0,  -1, 7, $01, $0 | PRIORITY
	dsprite   4, 0,   1, 0, $03, $0 | PRIORITY
	dsprite   4, 0,   3, 0, $03, $0 | PRIORITY
	dsprite   5, 0,  -1, 7, $01, $0 | PRIORITY
	dsprite   5, 0,   1, 0, $03, $0 | PRIORITY
	dsprite   5, 0,   3, 0, $03, $0 | PRIORITY
	dsprite   6, 0,  -1, 7, $01, $0 | PRIORITY
	dsprite   6, 0,   1, 0, $03, $0 | PRIORITY
	dsprite   6, 0,   3, 0, $03, $0 | PRIORITY
	dsprite   7, 0,  -1, 7, $01, $0 | PRIORITY
	dsprite   7, 0,   1, 0, $03, $0 | PRIORITY
	dsprite   7, 0,   3, 0, $03, $0 | PRIORITY
	dsprite   8, 0,  -1, 7, $01, $0 | PRIORITY
	dsprite   8, 0,   1, 0, $03, $0 | PRIORITY
	dsprite   8, 0,   3, 0, $03, $0 | PRIORITY
	dsprite   9, 0,  -1, 7, $01, $0 | PRIORITY
	dsprite   9, 0,   1, 0, $03, $0 | PRIORITY
	dsprite   9, 0,   3, 0, $03, $0 | PRIORITY
	dsprite  10, 0,  -1, 7, $01, $0 | PRIORITY
	dsprite  10, 0,   1, 0, $03, $0 | PRIORITY
	dsprite  10, 0,   3, 0, $03, $0 | PRIORITY
	dsprite  11, 0,  -1, 7, $01, $0 | PRIORITY
	dsprite  11, 0,   1, 0, $03, $0 | PRIORITY
	dsprite  11, 0,   3, 0, $03, $0 | PRIORITY
	dsprite  11, 1,  -1, 7, $00, $0 | Y_FLIP | PRIORITY
	dsprite  11, 1,   0, 0, $02, $0 | Y_FLIP | PRIORITY
	dsprite  11, 1,   1, 0, $03, $0 | Y_FLIP | PRIORITY
	dsprite  11, 1,   2, 0, $02, $0 | Y_FLIP | PRIORITY
	dsprite  11, 1,   3, 0, $03, $0 | X_FLIP | Y_FLIP | PRIORITY

.Impossible:
	db 4
	dsprite   0, 0,   0, 0, $00, $0 | PRIORITY
	dsprite   0, 0,   1, 0, $00, $0 | X_FLIP | PRIORITY
	dsprite   1, 0,   0, 0, $00, $0 | Y_FLIP | PRIORITY
	dsprite   1, 0,   1, 0, $00, $0 | X_FLIP | Y_FLIP | PRIORITY

CardFlip_InitAttrPals:
	hlcoord 0, 0, wAttrMap
	ld bc, SCREEN_HEIGHT * SCREEN_WIDTH
	xor a
	rst ByteFill

	hlcoord 12, 1, wAttrMap
	lb bc, 2, 2
	ld a, $1
	call FillBoxWithByte

	hlcoord 14, 1, wAttrMap
	lb bc, 2, 2
	ld a, $2
	call FillBoxWithByte

	hlcoord 16, 1, wAttrMap
	lb bc, 2, 2
	ld a, $3
	call FillBoxWithByte

	hlcoord 18, 1, wAttrMap
	lb bc, 2, 2
	ld a, $4
	call FillBoxWithByte

	hlcoord 9, 0, wAttrMap
	lb bc, 12, 1
	ld a, $1
	call FillBoxWithByte

	ldh a, [rSVBK]
	push af
	ld a, $5
	ldh [rSVBK], a
	ld hl, .palettes
	ld de, wBGPals1
	ld bc, 9 palettes
	rst CopyBytes
	pop af
	ldh [rSVBK], a
	ret

.palettes
if !DEF(MONOCHROME)
	RGB 31, 31, 31
	RGB 17, 07, 31
	RGB 06, 19, 08
	RGB 00, 00, 00

	RGB 31, 31, 31
	RGB 29, 25, 00
	RGB 06, 19, 08
	RGB 00, 00, 00

	RGB 31, 31, 31
	RGB 31, 13, 30
	RGB 06, 19, 08
	RGB 00, 00, 00

	RGB 31, 31, 31
	RGB 08, 17, 30
	RGB 06, 19, 08
	RGB 00, 00, 00

	RGB 31, 31, 31
	RGB 08, 31, 08
	RGB 06, 19, 08
	RGB 00, 00, 00

	RGB 31, 31, 31
	RGB 17, 07, 31
	RGB 06, 19, 08
	RGB 00, 00, 00

	RGB 31, 31, 31
	RGB 17, 07, 31
	RGB 06, 19, 08
	RGB 00, 00, 00

	RGB 31, 31, 31
	RGB 17, 07, 31
	RGB 06, 19, 08
	RGB 00, 00, 00

	RGB 31, 31, 31
	RGB 31, 31, 31
	RGB 31, 00, 00
	RGB 31, 00, 00
else
	MONOCHROME_RGB_FOUR
	MONOCHROME_RGB_FOUR
	MONOCHROME_RGB_FOUR
	MONOCHROME_RGB_FOUR
	MONOCHROME_RGB_FOUR
	MONOCHROME_RGB_FOUR
	MONOCHROME_RGB_FOUR
	MONOCHROME_RGB_FOUR
	MONOCHROME_RGB_FOUR
endc

CardFlipLZ03:
INCBIN "gfx/card_flip/card_flip_3.2bpp.lz"

CardFlipOffButtonGFX:
INCBIN "gfx/card_flip/off_button.2bpp"

CardFlipOnButtonGFX:
INCBIN "gfx/card_flip/on_button.2bpp"

CardFlipLZ01:
INCBIN "gfx/card_flip/card_flip_1.2bpp.lz"

CardFlipLZ02:
INCBIN "gfx/card_flip/card_flip_2.2bpp.lz"

CardFlipTilemap:
INCBIN "gfx/card_flip/card_flip.tilemap"
