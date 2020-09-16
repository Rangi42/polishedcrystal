SpecialBuenasPassword:
	xor a
	ld [wWhichIndexSet], a
	ld hl, .MenuDataHeader
	call CopyMenuHeader
	ld a, [wBuenasPassword]
	ld c, a
	farcall GetBuenasPassword
	ld a, [wMenuBorderLeftCoord]
	add c
	add $2
	ld [wMenuBorderRightCoord], a
	call PushWindow
	call DoNthMenu ; menu
	farcall Buena_ExitMenu
	ld b, $0
	ld a, [wMenuSelection]
	ld c, a
	ld a, [wBuenasPassword]
	and $3
	cp c
	jr nz, .wrong
	ld b, $1

.wrong
	ld a, b
	ldh [hScriptVar], a
	ret

.MenuDataHeader:
	db $40 ; flags
	db 00, 00 ; start coords
	db 07, 10 ; end coords
	dw .MenuData2
	db 1 ; default option

	db 0

.MenuData2:
	db $81 ; flags
	db 0 ; items
	dw .PasswordIndices
	dw .PlacePasswordChoices

.PasswordIndices:
	db 3
	db 0, 1, 2
	db -1

.PlacePasswordChoices:
	push de
	ld a, [wBuenasPassword]
	and $f0
	ld c, a
	ld a, [wMenuSelection]
	add c
	ld c, a
	farcall GetBuenasPassword
	pop hl
	rst PlaceString
	ret
