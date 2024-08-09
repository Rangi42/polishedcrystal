SummaryScreen_GreenPage:
	ld a, $4C
	call SummaryScreen_UpdateTabTitle
	ld hl, .GreenPalettes
	ld bc, 1 palettes
	ld de, wSummaryScreenPals
	rst CopyBytes
	ld bc, 2 palettes
	ld de, wSummaryScreenPals + 3 palettes
	rst CopyBytes
	call .PlaceItemText
	hlcoord 2, 8
	call .PlaceItemIcon
	ld a, " "
	hlcoord 1, 9
	ld [hl], a
	hlcoord 5, 9
	ld [hl], a

	ld hl, wTempMonMoves
	ld de, wListMoves_MoveIndicesBuffer
	ld bc, NUM_MOVES
	rst CopyBytes
	hlbgcoord 0, 0, wSummaryScreenWindowBuffer
	ld a, $20 * 2
	ld [wBuffer1], a
	predef ListMoves
	hlbgcoord 4, 1, wSummaryScreenWindowBuffer
	ld a, $20 * 2
	ld [wBuffer1], a
	predef ListMovePP

for n, 4
	ld a, [wTempMonMoves + n]
	and a
	jr z, .moves_done
	ld a, [wSummaryScreenTypes + 2 + n]
	ld d, (2 + n) | 8
	lb bc, 72, 41 + n * 20
	ld hl, wSummaryScreenOAMSprite04 + n * 4 * 4
	call SummaryScreen_PlaceTypeOBJ
	debgcoord 0, 1 + n * 2, wSummaryScreenWindowBuffer
	call SummaryScreen_PlaceTypeBG
endr
.moves_done
.PlaceAInfo:
	lb bc, 132, $40
	ld hl, wSummaryScreenOAMSprite20
.aInfoLoop
	ld a, 108
	ld [hli], a
	ld a, b
	ld [hli], a
	ld a, c
	ld [hli], a
	ld a, $4
	ld [hli], a
	ld a, 8
	add a, b
	ld b, a
	inc c
	cp a, 132 + 8 * 4
	jr nz, .aInfoLoop
	ret

.PlaceItemIcon:
	ld de, 17
	lb bc, 3, 3
	ld a, $56
.item_icon_loop
	ld [hli], a
	inc a
	dec c
	jr nz, .item_icon_loop
	ld c, 3
	add hl, de
	dec b
	jr nz, .item_icon_loop
	ret

.PlaceItemText:
	hlcoord 0, 13
	lb bc, 5, 20
	call ClearBox
	ld a, [wTempMonItem]
	ld [wCurItem], a
	call .GetItemName
	hlcoord 1, 13
	rst PlaceString
	call .PrintItemDescription

.GetItemName:
	ld de, .ThreeDashes
	ld a, [wTempMonItem]
	and a
	ret z
	ld [wNamedObjectIndex], a
	jmp GetItemName

.PrintItemDescription:
	ld a, [wTempMonItem]
	and a
	ret z
	decoord 1, 15
	farjp PrintItemDescription

.GreenPalettes:
	RGB 21, 31, 14
	RGB 31, 31, 31
	RGB 31, 31, 31
	RGB 00, 00, 00
	
	RGB 30, 31, 29
	RGB 21, 31, 14
	RGB 31, 31, 31
	RGB 00, 00, 00

	RGB 21, 31, 14
	RGB 21, 31, 14
	RGB 31, 31, 31
	RGB 00, 00, 00

.ThreeDashes:
	db "---@"

; a = move
.ShowMove:
	push af
	ld e, a
	ld hl, 0
	ld bc, 20
	call AddNTimes
	ld a, 31
	add a, l
	ld c, a
	ld b, 58
	call SummaryScreen_PlaceArrow
	hlcoord 0, 13
	lb bc, 5, 20
	call ClearBox
	pop af
	ld b, 0
	ld c, a
	ld hl, wTempMonMoves
	add hl, bc
	ld a, [hl]
	ld [wCurMove], a
	hlcoord 4, 13
	ld de, .String_PowAcc
	rst PlaceString

	ld hl, Moves + MOVE_CATEGORY
	call GetCurMoveProperty
	add a, a
	push af ; keep doubled category for later
	add a, a
	ld b, 0
	ld c, a
	ld hl, CategoryIconPals
	add hl, bc

	ldh a, [rSVBK]
	push af
	ld a, BANK(wBGPals1)
	ldh [rSVBK], a

	ld de, wBGPals1 + 2
	farcall LoadOneColor
	farcall LoadOneColor
	call SetPalettes

	pop af
	ldh [rSVBK], a

	pop af ; get category back
	add a, $50
	hlcoord 1, 13
	ld [hli], a
	inc a
	ld [hl], a

	ld hl, Moves + MOVE_POWER
	call GetCurMoveProperty
	hlcoord 3, 13
	cp 2
	jr c, .no_power
	ld [wTextDecimalByte], a
	ld de, wTextDecimalByte
	lb bc, 1, 3
	call PrintNum
	jr .place_accuracy
.no_power
	ld de, .String_na
	rst PlaceString

.place_accuracy
	ld hl, Moves + MOVE_ACC
	call GetCurMoveProperty
	hlcoord 8, 13
	cp 2
	jr c, .no_acc
	ld [wTextDecimalByte], a
	ld de, wTextDecimalByte
	lb bc, 1, 3
	call PrintNum
	jr .description
.no_acc
	ld de, .String_na
	rst PlaceString

.description
	hlcoord 1, 15
	predef PrintMoveDesc
	ret

.String_na:
	db "---@"

.String_PowAcc:
	db "  <BOLDP>/   %@"

SummaryScreen_MoveInfoLoop:
	ld a, $50
	call SummaryScreen_UpdateTabTitle
	ld a, [wSummaryScreenPage]
	and %11100011
	ld [wSummaryScreenPage], a
	xor a
	call SummaryScreen_GreenPage.ShowMove
	call SummaryScreen_UpdateGFX
.loop
	call SummaryScreen_MoveInfoJoypad
	call SummaryScreen_DoAnim
	jr .loop

SummaryScreen_MoveInfoJoypad:
	ld a, [wSummaryScreenPage]
	srl a
	srl a
	and %00000111
	ld c, a

	call GetJoypad
	ldh a, [hJoyPressed]
	bit B_BUTTON_F, a
	jr nz, .b_button
	bit A_BUTTON_F, a
	jr nz, .a_button
	bit D_UP_F, a
	jr nz, .d_up
	bit D_DOWN_F, a
	ret z
.d_down
	inc c
	ld b, 0
	jr .adjust_move_index
.a_button
.b_button
	ld a, $4C
	call SummaryScreen_UpdateTabTitle
	call SummaryScreen_GreenPage.PlaceItemText
	call SummaryScreen_GreenPage.PlaceAInfo
	call SummaryScreen_UpdateGFX
	inc sp
	inc sp
	ret
.d_up
	dec c
	ld a, [wSummaryScreenMoveCount]
	dec a
	ld b, a
.adjust_move_index
	ld a, [wSummaryScreenMoveCount]
	dec a
	cp a, c
	jr nc, .set_move_index
	ld c, b
.set_move_index
	ld a, c
	push af
	call SummaryScreen_GreenPage.ShowMove
	call SummaryScreen_UpdateGFX
	pop af
	sla a
	sla a
	and %00011100
	ld c, a
	ld a, [wSummaryScreenPage]
	and %11100011
	or a, c
	ld [wSummaryScreenPage], a
	ret

SummaryScreen_UpdateGFX:
	ld hl, wSummaryScreenOAM
	ld de, wShadowOAM
	ld bc, wShadowOAMEnd - wShadowOAM
	rst CopyBytes
	farcall HDMATransferTileMapToWRAMBank3
	ret
