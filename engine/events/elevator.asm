Elevator::
	call .LoadPointer
	call .FindCurrentFloor
	jr c, .quit
	ld [wElevatorOriginFloor], a
	call Elevator_AskWhichFloor
	jr c, .quit
	ld hl, wElevatorOriginFloor
	cp [hl]
	jr z, .quit
	call Elevator_GoToFloor
	and a
	ret

.quit
	scf
	ret

.LoadPointer:
	ld a, b
	ld [wElevatorPointerBank], a
	ld a, e
	ld [wElevatorPointerLo], a
	ld a, d
	ld [wElevatorPointerHi], a
	ld de, wCurElevator
	ld bc, 4
	ld hl, wElevatorPointerLo
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, [wElevatorPointerBank]
	call GetFarByte
	inc hl
	ld [de], a
	inc de
.loop
	ld a, [wElevatorPointerBank]
	call GetFarByte
	ld [de], a
	inc de
	add hl, bc
	cp -1
	jr nz, .loop
	ret

.FindCurrentFloor:
	ld hl, wElevatorPointerLo
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, [wElevatorPointerBank]
	call GetFarByte
	ld c, a
	inc hl
	ld a, [wBackupMapGroup]
	ld d, a
	ld a, [wBackupMapNumber]
	ld e, a
	ld b, 0
.loop2
	ld a, [wElevatorPointerBank]
	call GetFarByte
	cp -1
	jr z, .fail
	inc hl
	inc hl
	ld a, [wElevatorPointerBank]
	call GetFarByte
	inc hl
	cp d
	jr nz, .next1
	ld a, [wElevatorPointerBank]
	call GetFarByte
	inc hl
	cp e
	jr nz, .next2
	jr .done

.next1
	inc hl
.next2
	inc b
	jr .loop2

.done
	xor a
	ld a, b
	ret

.fail
	scf
	ret

Elevator_GoToFloor:
	push af
	ld hl, wElevatorPointerLo
	ld a, [hli]
	ld h, [hl]
	ld l, a
	inc hl
	pop af
	ld bc, 4
	rst AddNTimes
	inc hl
	ld de, wBackupWarpNumber
	ld a, [wElevatorPointerBank]
	ld bc, 3
	jp FarCopyBytes

Elevator_AskWhichFloor:
	call LoadStandardMenuHeader
	ld hl, Elevator_WhichFloorText
	call PrintText
	call Elevator_GetCurrentFloorText
	ld hl, Elevator_MenuDataHeader
	call CopyMenuHeader
	call InitScrollingMenu
	call UpdateSprites
	xor a
	ld [wMenuScrollPosition], a
	call ScrollingMenu
	call CloseWindow
	ld a, [wMenuJoypad]
	cp B_BUTTON
	jr z, .cancel
	xor a
	ld a, [wScrollingMenuCursorPosition]
	ret

.cancel
	scf
	ret

Elevator_WhichFloorText:
	; Which floor?
	text_jump _AskFloorElevatorText
	text_end

Elevator_GetCurrentFloorText:
	ld hl, wOptions1
	ld a, [hl]
	push af
	set NO_TEXT_SCROLL, [hl]
	hlcoord 0, 0
	lb bc, 4, 8
	call Textbox
	hlcoord 1, 2
	ld de, Elevator_CurrentFloorText
	rst PlaceString
	hlcoord 4, 4
	call Elevator_GetCurrentFloorString
	pop af
	ld [wOptions1], a
	ret

Elevator_CurrentFloorText:
	db "Now on:@"

Elevator_GetCurrentFloorString:
	push hl
	ld a, [wElevatorOriginFloor]
	ld e, a
	ld d, 0
	ld hl, wCurElevatorFloors
	add hl, de
	ld a, [hl]
	pop de
	jp GetFloorString

Elevator_MenuDataHeader:
	db $40 ; flags
	db 01, 12 ; start coords
	db 09, 18 ; end coords
	dw Elevator_MenuData2
	db 1 ; default option

Elevator_MenuData2:
	db $10 ; flags
	db 4, 0 ; rows, columns
	db 1 ; horizontal spacing
	dbw 0, wCurElevator
	dba GetElevatorFlorStrings
	dba NULL
	dba NULL

GetElevatorFlorStrings:
	ld a, [wMenuSelection]
GetFloorString:
	push de
	call FloorToString
	ld d, h
	ld e, l
	pop hl
	rst PlaceString
	ret

FloorToString:
	push de
	ld e, a
	ld d, 0
	ld hl, ElevatorFloorNames
	add hl, de
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	pop de
	ret

INCLUDE "data/events/elevator_floors.asm"
