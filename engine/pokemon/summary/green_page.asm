SummaryScreen_GreenPage:
	ld a, SUMMARY_TILE_OAM_ITEM_TITLE
	call SummaryScreen_UpdateTabTitle
	ld hl, .GreenPalettes
	ld bc, 1 palettes
	ld de, wSummaryScreenPals palette SUMMARY_PAL_LOWER_WINDOW
	rst CopyBytes
	ld bc, 1 palettes
	ld de, wSummaryScreenPals palette SUMMARY_PAL_SIDE_WINDOW
	rst CopyBytes
	; when choosing a move to forget, show level and gender like the other pages,
	; and the selected move's details instead of the item
	ld a, [wSummaryScreenFlags]
	bit SUMMARY_FLAGS_FORGET_MOVE_F, a
	call z, .PlaceItemText
	ld a, [wSummaryScreenFlags]
	bit SUMMARY_FLAGS_FORGET_MOVE_F, a
	hlcoord 2, 8
	call z, .ReplaceLevelGenderWithItemIcon

	call .PrintMoves

	ld a, -1
	ld [wSummaryMoveSwap], a
.PlaceAInfo:
	lb bc, 132, SUMMARY_TILE_OAM_A_INFO
	ld hl, wSummaryScreenOAMSprite20
.aInfoLoop
	ld a, 108
	ld [hli], a
	ld a, b
	ld [hli], a
	ld a, c
	ld [hli], a
	ld a, SUMMARY_PAL_A_INFO
	ld [hli], a
	ld a, 8
	add b
	ld b, a
	inc c
	cp 132 + 8 * OBJ_SIZE
	jr nz, .aInfoLoop
	ret

.ReplaceLevelGenderWithItemIcon:
	ld a, [wTempMonItem]
	and a
	ret z
	ld de, 17
	lb bc, 3, 3
	ld a, SUMMARY_TILE_ITEM
.item_icon_loop
	ld [hli], a
	inc a
	dec c
	jr nz, .item_icon_loop
	ld c, 3
	add hl, de
	dec b
	jr nz, .item_icon_loop
	ld a, ' '
	hlcoord 1, 9
	ld [hl], a
	hlcoord 5, 9
	ld [hl], a
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
	ld de, .NoHeldItemString
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
INCLUDE "gfx/stats/green_page.pal"

.NoHeldItemString:
	db "No held item@"

.PrintMoves
	; Clear move names
	hlbgcoord 0, 0, wSummaryScreenWindowBuffer
	ld de, 64 - 12
	ld a, ' '
	ld bc, 12
	rst ByteFill
	ld c, 12
	add hl, de
	rst ByteFill
	ld c, 12
	add hl, de
	rst ByteFill
	ld c, 12
	add hl, de
	rst ByteFill

	ld hl, wTempMonMoves
	ld de, wListMoves_MoveIndicesBuffer
	ld bc, NUM_MOVES
	rst CopyBytes
	hlbgcoord 0, 0, wSummaryScreenWindowBuffer
	ld a, TILEMAP_WIDTH * 2
	ld [wListMovesLineSpacing], a
	farcall ListMoves
	hlbgcoord 4, 1, wSummaryScreenWindowBuffer
	ld a, TILEMAP_WIDTH * 2
	ld [wListMovesLineSpacing], a
	farcall ListMovePP

for n, NUM_MOVES
	ld a, [wTempMonMoves + n]
	and a
	ret z
	ld a, [wSummaryScreenTypes + 2 + n]
	ld d, (2 + n) | 8
	lb bc, 72, 41 + n * 20
	ld hl, wSummaryScreenOAMSprite04 + n * 4 * OBJ_SIZE
	call SummaryScreen_PlaceTypeOBJ
	debgcoord 0, 1 + n * 2, wSummaryScreenWindowBuffer
	call SummaryScreen_PlaceTypeBG
endr

	ld a, [wSummaryScreenFlags]
	bit SUMMARY_FLAGS_FORGET_MOVE_F, a
	ret z

	; move the type icons up with the move list
	ld hl, wSummaryScreenOAMSprite04YCoord
	ld c, NUM_MOVES * 4
	call .ShiftSpritesForForgetMove

	; show the new move below the current ones
	ld a, [wPutativeTMHMMove]
	ld [wNamedObjectIndex], a
	ld [wCurMove], a
	call GetMoveName
	hlbgcoord 0, NUM_MOVES * 2, wSummaryScreenWindowBuffer
	rst PlaceString

	ld a, [wSummaryScreenTypes + 1]
	ld d, 1 | 8
	lb bc, 72, 41 + NUM_MOVES * 20 - SUMMARY_FORGET_MOVE_SHIFT
	ld hl, wSummaryScreenOAMSprite28
	call SummaryScreen_PlaceTypeOBJ
	debgcoord 0, 1 + NUM_MOVES * 2, wSummaryScreenWindowBuffer
	call SummaryScreen_PlaceTypeBG

	; a new move has full PP
	hlbgcoord 4, 1 + NUM_MOVES * 2, wSummaryScreenWindowBuffer
	ld a, SUMMARY_TILE_PP_START
	ld [hli], a
	inc a
	ld [hli], a
	inc a
	ld [hli], a
	push hl
	ld hl, Moves + MOVE_PP
	call GetCurMoveProperty
	ld [wTextDecimalByte], a
	pop hl
	ld de, wTextDecimalByte
	lb bc, 1, 2
	call PrintNum
	ld a, '/'
	ld [hli], a
	ld de, wTextDecimalByte
	lb bc, 1, 2
	jmp PrintNum

; hl = first sprite's y coord, c = number of sprites
.ShiftSpritesForForgetMove:
	ld de, OBJ_SIZE
.shift_loop
	ld a, [hl]
	sub SUMMARY_FORGET_MOVE_SHIFT
	ld [hl], a
	add hl, de
	dec c
	jr nz, .shift_loop
	ret

; a = move
.ShowMove:
	push af
	ld e, a
	ld a, [wSummaryMoveSwap]
	cp e

	jr z, .no_swap
	inc a
	jr z, .no_swap
	dec a
	ld hl, 0
	ld bc, 20
	rst AddNTimes
	ld a, 31
	add l
	ld c, a
	ld b, 58
	call SummaryScreen_PlaceSwapArrow
.no_swap
	pop af
	push af
	ld hl, 0
	ld bc, 20
	rst AddNTimes
	ld a, 31
	add l
	ld c, a
	ld b, 58
	call SummaryScreen_PlaceArrow
	ld a, [wSummaryScreenFlags]
	bit SUMMARY_FLAGS_FORGET_MOVE_F, a
	jr z, .arrow_done
	ld hl, wSummaryScreenOAMSprite20YCoord
	ld c, 4
	call .ShiftSpritesForForgetMove
.arrow_done
	call SummaryScreen_GetLowerBox
	call ClearBox
	pop af
	ld b, 0
	ld c, a
	ld hl, wTempMonMoves
	add hl, bc
	cp NUM_MOVES
	ld a, [hl]
	jr c, .got_move
	; the new move, when choosing a move to forget
	ld a, [wPutativeTMHMMove]
.got_move
	ld [wCurMove], a
	hlcoord 4, 13
	ld de, .String_PowAcc
	ld a, [wSummaryScreenFlags]
	bit SUMMARY_FLAGS_FORGET_MOVE_F, a
	jr z, .got_pow_acc
	hlcoord 8, 14
	ld de, .String_ForgetMovePowAcc
.got_pow_acc
	rst PlaceString

	call GetCurMoveFixedCategory
	add a
	push af ; keep doubled category for later
	add a
	ld b, 0
	ld c, a
	ld hl, CategoryIconPals
	add hl, bc

	ldh a, [rWBK]
	push af
	ld a, BANK(wBGPals1)
	ldh [rWBK], a

	ld de, wBGPals1 color 1
	farcall LoadOneColor
	farcall LoadOneColor
	call SetDefaultBGPAndOBP

	pop af
	ldh [rWBK], a

	pop af ; get category back
	add SUMMARY_TILE_CATEGORY_START
	hlcoord 1, 13
	decoord 1, 14
	call SummaryScreen_PickLowerCoord
	ld [hli], a
	inc a
	ld [hl], a

	ld hl, Moves + MOVE_POWER
	call GetCurMoveProperty
	hlcoord 3, 13
	decoord 5, 14
	call SummaryScreen_PickLowerCoord
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
	decoord 11, 14
	call SummaryScreen_PickLowerCoord
	cp 255
	jr z, .no_acc
	ld [wTextDecimalByte], a
	ld de, wTextDecimalByte
	lb bc, 1, 3
	call PrintNum
	jr .description
.no_acc
	ld de, .String_na
	rst PlaceString

.description
	ld a, [wSummaryScreenFlags]
	bit SUMMARY_FLAGS_FORGET_MOVE_F, a
	hlcoord 1, 15
	jr nz, .forget_move_description
	farjp PrintMoveDesc

.forget_move_description
	; a row lower, with no blank line between its lines
	hlcoord 1, 16
	ld de, .PrintMoveDesc
	jmp SummaryScreen_PlaceSingleSpaced

.PrintMoveDesc:
	farjp PrintMoveDesc

.String_na:
	db "---@"

.String_PowAcc:
	db "  <BOLDP>/   %@"

.String_ForgetMovePowAcc:
	db "<BOLDP>     %@"

SummaryScreen_MoveInfoLoop:
	ld a, SUMMARY_TILE_OAM_MOVE_TITLE
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
	bit B_PAD_B, a
	jr nz, .b_button
	bit B_PAD_A, a
	jr nz, .a_button
	bit B_PAD_SELECT, a
	jr nz, .select
	bit B_PAD_UP, a
	jr nz, .d_up
	bit B_PAD_DOWN, a
	ret z
.d_down
	inc c
	ld b, 0
	jr .adjust_move_index
.a_button
	ld a, [wSummaryScreenFlags]
	bit SUMMARY_FLAGS_FORGET_MOVE_F, a
	jr nz, .choose_move_to_forget
.select
	; Don't swap moves while choosing one to forget
	ld a, [wSummaryScreenFlags]
	bit SUMMARY_FLAGS_FORGET_MOVE_F, a
	ret nz

	; Don't swap moves during battle
	ld a, [wBattleMode]
	ld b, a
	ld a, [wLinkMode]
	or b
	ret nz
	; TODO support battle swapping?

	; Disallow move swapping if we can't update storage boxmon data.
	farcall UpdateStorageBoxMonFromTemp
	ret nz

	ld a, [wSummaryMoveSwap]
	inc a
	jr nz, .swap_moves
	ld de, SFX_READ_TEXT_2
	call PlaySFX
	ld a, [wSummaryScreenPage]
	rrca
	rrca
	and %00000111
	ld [wSummaryMoveSwap], a
	ret
.choose_move_to_forget
	call SummaryScreen_ChooseMoveToForget
	ret nc
	jr .quit

.b_button
	ld de, SFX_READ_TEXT_2
	call PlaySFX
	ld a, [wSummaryMoveSwap]
	inc a
	jr z, .quit
	ld a, -1
	ld [wSummaryMoveSwap], a
	call SummaryScreen_ClearSwapArrow
	jmp SummaryScreen_UpdateGFX
.quit
	; choosing a move to forget closes the screen right away
	ld a, [wSummaryScreenFlags]
	bit SUMMARY_FLAGS_FORGET_MOVE_F, a
	jr nz, .exit
	ld a, SUMMARY_TILE_OAM_ITEM_TITLE
	call SummaryScreen_UpdateTabTitle
	call SummaryScreen_GreenPage.PlaceItemText
	call SummaryScreen_GreenPage.PlaceAInfo
	call SummaryScreen_UpdateGFX
.exit
	add sp, 2 ; exit SummaryScreen_MoveInfoLoop, return to SummaryScreenLoop
	ret
.d_up
	dec c
	ld a, [wSummaryScreenMoveCount]
	dec a
	ld b, a
.adjust_move_index
	ld a, [wSummaryScreenMoveCount]
	dec a
	cp c
	jr nc, .set_move_index
	ld c, b
.set_move_index
	ld a, c
	push af
	call SummaryScreen_GreenPage.ShowMove
	call SummaryScreen_UpdateGFX
	pop af
	add a
	add a
	and %00011100
	ld c, a
	ld a, [wSummaryScreenPage]
	and %11100011
	or c
	ld [wSummaryScreenPage], a
	ret
.swap_moves
	dec a ; back to original value
	ld b, a

	ld a, BANK(wTempMonMoves)
	ldh [rWBK], a

	ld a, [wSummaryScreenPage]
	rrca
	rrca
	and %00000111
	push af
	cp b
	jr z, .end_swap
	ld c, a
	push bc
	ld hl, wTempMonMoves
	call .swap_addresses
	pop bc
	push bc
	ld hl, wTempMonPP
	call .swap_addresses
	pop bc
	ld hl, wSummaryScreenTypes + 2
	call .swap_addresses
	farcall UpdateStorageBoxMonFromTemp
	call SummaryScreen_GreenPage.PrintMoves
	call SummaryScreen_InitLayout.ApplySummaryPalettes
	call SummaryScreen_SwitchPage
	ld de, SFX_SWITCH_POKEMON
	call PlaySFX
.end_swap
	pop af
	call SummaryScreen_GreenPage.ShowMove
	ld a, -1
	ld [wSummaryMoveSwap], a
	call SummaryScreen_ClearSwapArrow
	call WaitSFX
	ld de, SFX_SWITCH_POKEMON
	call PlaySFX
	jmp SummaryScreen_UpdateGFX
; hl = address
.swap_addresses:
	ld d, h
	ld e, l

	ld a, b
	add l
	ld l, a
	adc h
	sub l
	ld h, a

	ld a, c
	add e
	ld e, a
	adc d
	sub e
	ld d, a

	ld b, [hl]
	ld a, [de]
	ld [hl], a
	ld a, b
	ld [de], a
	ret

SummaryScreen_ChooseMoveToForget:
; c = cursor position
; Returns c if a move was chosen, with its 1-based slot in wMoveScreenCursor
; and the move in wMoveScreenSelectedMove.
	ld b, 0
	ld hl, wTempMonMoves
	add hl, bc
	ld a, c
	cp NUM_MOVES
	ld a, [hl]
	jr nc, .ok ; the new move
	push bc
	push af
	farcall CheckUnforgettableHM
	jr c, .cant_forget
	pop af
	pop bc
.ok
	ld [wMoveScreenSelectedMove], a
	ld a, c
	inc a
	ld [wMoveScreenCursor], a
	ld de, SFX_READ_TEXT_2
	call PlaySFX
	scf
	ret

.cant_forget
	pop af
	pop bc
	ld de, SFX_WRONG
	call PlaySFX
	; replace the move's description until the cursor moves
	hlcoord 1, 16
	lb bc, 2, 18
	call ClearBox
	hlcoord 1, 16
	ld de, .PlaceCantForgetHMString
	call SummaryScreen_PlaceSingleSpaced
	call SummaryScreen_UpdateGFX
	and a
	ret

.PlaceCantForgetHMString:
	ld de, .CantForgetHMString
	rst PlaceString
	ret

.CantForgetHMString:
	db "HM moves can't be"
	next "forgotten now.@"

SummaryScreen_PlaceSingleSpaced:
; Call de with no blank line between lines of text (for text at hl).
	ld a, [wTextboxFlags]
	set NO_LINE_SPACING_F, a
	ld [wTextboxFlags], a
	call _de_
	ld a, [wTextboxFlags]
	res NO_LINE_SPACING_F, a
	ld [wTextboxFlags], a
	ret

SummaryScreen_ClearSwapArrow:
	ld hl, wSummaryScreenOAMSprite24
	ld bc, 4 * OBJ_SIZE
	rst ByteFill
	ret

SummaryScreen_UpdateGFX:
	ld hl, wSummaryScreenOAM
	ld de, wShadowOAM
	ld bc, wShadowOAMEnd - wShadowOAM
	rst CopyBytes
	farjp HDMATransferTileMapToWRAMBank3
