Kurt_PrintTextWhichApricorn:
	ld hl, .Text
	jp PrintText

.Text:
	; Which APRICORN should I use?
	text_jump _WhichApricornText
	text_end

Kurt_PrintTextHowMany:
	ld hl, .Text
	jp PrintText

.Text:
	; How many should I make?
	text_jump _HowManyShouldIMakeText
	text_end

Special_SelectApricornForKurt:
	call LoadStandardMenuHeader
	ld c, $1
	xor a
	ld [wMenuScrollPosition], a
	ld [wKurtApricornQuantity], a
.loop
	push bc
	call Kurt_PrintTextWhichApricorn
	pop bc
	ld a, c
	ld [wMenuSelection], a
	call Kurt_SelectApricorn
	ld a, c
	ldh [hScriptVar], a
	and a
	jr z, .done
	ld [wCurItem], a
	ld a, [wMenuCursorY]
	ld c, a
	push bc
	call Kurt_PrintTextHowMany
	call Kurt_SelectQuantity
	pop bc
	jr nc, .loop
	ld a, [wItemQuantityChangeBuffer]
	ld [wKurtApricornQuantity], a
	call Kurt_GiveUpSelectedQuantityOfSelectedApricorn

.done
	jp ExitMenu

Kurt_SelectApricorn:
	call Kurt_FindApricornsInBag
	jr c, .nope
	ld hl, .MenuDataHeader
	call CopyMenuHeader
	ld a, [wMenuSelection]
	ld [wMenuCursorBuffer], a
	xor a
	ldh [hBGMapMode], a
	call InitScrollingMenu
	call UpdateSprites
	call ScrollingMenu
	ld a, [wMenuJoypad]
	cp B_BUTTON
	jr z, .nope
	ld a, [wMenuSelection]
	cp -1
	jr nz, .done

.nope
	xor a

.done
	ld c, a
	ret

.MenuDataHeader:
	db $40 ; flags
	db 01, 01 ; start coords
	db 10, 13 ; end coords
	dw .MenuData2
	db 1 ; default option

	db 0

.MenuData2:
	db $10 ; flags
	db 4, 7
	db 1
	dbw 0, wBuffer1
	dba .Name
	dba .Quantity
	dba NULL

.Name:
	ld a, [wMenuSelection]
	and a
	ret z
	push de
	ld [wNamedObjectIndexBuffer], a
	call GetApricornName
	pop hl
	rst PlaceString
	ret

.Quantity:
	ld a, [wMenuSelection]
	ld [wCurItem], a
	call Kurt_GetQuantityOfApricorn
	ret z
	ld a, [wItemQuantityChangeBuffer]
	ld [wMenuSelectionQuantity], a
	farjp PlaceMenuApricornQuantity

Kurt_SelectQuantity:
	ld a, [wCurItem]
	ld [wMenuSelection], a
	call Kurt_GetQuantityOfApricorn
	jr z, .done
	ld a, [wItemQuantityChangeBuffer]
	ld [wItemQuantityBuffer], a
	ld a, $1
	ld [wItemQuantityChangeBuffer], a
	ld hl, .MenuDataHeader
	call LoadMenuHeader
	call MenuBox
	call ApplyTilemap
.loop
	ld a, 1
	ldh [hBGMapMode], a
	call MenuBox
	call .PlaceApricornName
	call .PlaceApricornQuantity
	call UpdateSprites
	farcall BuySellToss_InterpretJoypad
	ld b, a
	jr nc, .loop

	push bc
	call PlayClickSFX
	pop bc
	ld a, b
	cp -1
	jr z, .done
	scf

.done
	jp CloseWindow

.MenuDataHeader:
	db $40 ; flags
	db 09, 06 ; start coords
	db 12, 19 ; end coords

.PlaceApricornName:
	call MenuBoxCoord2Tile
	ld de, SCREEN_WIDTH + 1
	add hl, de
	ld a, [wCurItem]
	ld [wNamedObjectIndexBuffer], a
	call GetApricornName
	rst PlaceString
	ret

.PlaceApricornQuantity:
	call MenuBoxCoord2Tile
	ld de, 2 * SCREEN_WIDTH + 10
	add hl, de
	ld [hl], "×"
	inc hl
	ld de, wItemQuantityChangeBuffer
	lb bc, PRINTNUM_LEADINGZEROS | 1, 2
	jp PrintNum

Kurt_GetQuantityOfApricorn:
	push bc
	ld hl, wApricorns
	ld a, [wCurItem]
	dec a
	ld c, a
	ld b, 0
	add hl, bc
	pop bc
	ld a, [hl]
	ld [wItemQuantityChangeBuffer], a
	and a
	ret

Kurt_GiveUpSelectedQuantityOfSelectedApricorn:
	ld hl, wApricorns
	ld a, [wCurItem]
	dec a
	ld c, a
	ld b, 0
	add hl, bc
	ld a, [wKurtApricornQuantity]
	sub [hl]
	cpl
	inc a
	ld [hl], a
	ret

Kurt_FindApricornsInBag:
; Checks the bag for Apricorns.
	ld hl, wBuffer1
	xor a
	ld [hli], a
	dec a
	ld bc, 10
	rst ByteFill

	ld hl, wApricorns
	ld b, RED_APRICORN
.loop
	ld a, [hli]
	and a
	call nz, .addtobuffer
	inc b
	ld a, b
	cp NUM_APRICORNS + 1
	jr c, .loop
	ld a, [wBuffer1]
	and a
	ret nz
	scf
	ret

.addtobuffer
	push hl
	ld hl, wBuffer1
	inc [hl]
	ld e, [hl]
	ld d, 0
	add hl, de
	ld a, b
	ld [hl], a
	pop hl
	ret
