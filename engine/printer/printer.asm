DEF VBLANK_GBPRINTER EQU 8

SendScreenToPrinter:
.loop
	call JoyTextDelay
	call CheckCancelPrint
	jr c, .cancel
	ld a, [wJumptableIndex]
	bit JUMPTABLE_EXIT_F, a
	jr nz, .finished
	call PrinterJumptableIteration
	call CheckPrinterStatus
	call PlacePrinterStatusString
	call DelayFrame
	jr .loop

.finished
	and a
	ret

.cancel
	scf
	ret

Printer_CleanUpAfterSend:
	xor a
	ld [wPrinterConnectionOpen], a
	ld [wPrinterOpcode], a
	ret

Printer_PrepareTilemapForPrint:
	push af
	call Printer_StartTransmission
	pop af
	ld [wPrinterMargins], a
	jmp Printer_CopyTilemapToBuffer

Printer_ExitPrinter:
	call ReturnToMapFromSubmenu
	jmp RestartMapMusic

_PrintDiploma:
	ld a, [wPrinterQueueLength]
	push af

	farcall PlaceDiplomaPage1OnScreen

	xor a
	ldh [hPrinter], a
	call Printer_PlayMusic

	ldh a, [rIE]
	push af
	xor a
	ldh [rIF], a
	ld a, IE_SERIAL | IE_VBLANK
	ldh [rIE], a

	ld hl, hVBlank
	ld a, [hl]
	push af
	ld [hl], VBLANK_GBPRINTER

	ln a, 1, 0 ; to be loaded to wPrinterMargins
	call Printer_PrepareTilemapForPrint
	call Printer_ResetJoypadRegisters

	ld a, 18 / 2
	ld [wPrinterQueueLength], a
	call SendScreenToPrinter
	jr c, .cancel
	call Printer_CleanUpAfterSend
	ld c, 12
	call DelayFrames

	call LoadTileMapToTempTileMap
	xor a
	ldh [hBGMapMode], a

	farcall PlaceDiplomaPage2OnScreen

	ln a, 0, 3 ; to be loaded to wPrinterMargins
	call Printer_PrepareTilemapForPrint
	call SafeLoadTempTileMapToTileMap
	call Printer_ResetJoypadRegisters

	ld a, 18 / 2
	ld [wPrinterQueueLength], a
	call SendScreenToPrinter
.cancel
	pop af
	ldh [hVBlank], a
	call Printer_CleanUpAfterSend
	farcall FadeOutPalettes
	xor a
	ldh [rIF], a
	pop af
	ldh [rIE], a
	call Printer_ExitPrinter

	pop af
	ld [wPrinterQueueLength], a
	ret

CheckCancelPrint:
	ldh a, [hJoyDown]
	and PAD_B
	jr nz, .loop
	and a
	ret

; wait for printer activity to finish before canceling?
.loop
	ld a, [wPrinterOpcode]
	and a
	jr nz, .loop
	ld a, $16 ; cancel
	ld [wPrinterOpcode], a
	ld a, $88
	ldh [rSB], a
	ld a, SC_INTERNAL
	ldh [rSC], a
	ld a, SC_START | SC_INTERNAL
	ldh [rSC], a
.loop2
	ld a, [wPrinterOpcode]
	and a
	jr nz, .loop2

	ld a, $1
	ldh [hPrinter], a
	scf
	ret

Printer_CopyTilemapToBuffer:
	hlcoord 0, 0
	ld de, wPrinterTilemapBuffer
	ld bc, SCREEN_AREA
	jmp CopyBytes

Printer_ResetJoypadRegisters:
	xor a
	ldh [hJoyReleased], a
	ldh [hJoyPressed], a
	ldh [hJoyDown], a
	ldh [hJoyLast], a
	ret

Printer_PlayMusic:
	ld de, MUSIC_PRINTER
	jmp PlayMusic2

CheckPrinterStatus:
; Check for printer errors
; If [wPrinterHandshake] == -1, we're disconnected
	ld a, [wPrinterHandshake]
	cp -1
	jr nz, .printer_connected
	ld a, [wPrinterStatusFlags]
	cp -1
	jr z, .error_2
.printer_connected
	ld a, [wPrinterStatusFlags]
	and PRINTER_STATUS_ERROR_3 | PRINTER_STATUS_ERROR_4 | PRINTER_STATUS_ERROR_1
	ret z ; no error

	bit PRINTER_STATUS_ERROR_1_F, a
	jr nz, .error_1
	bit PRINTER_STATUS_ERROR_4_F, a
	; temperature error
	ld a, PRINTER_ERROR_4
	jr nz, .load_text_index
	; paper error
	ld a, PRINTER_ERROR_3
	jr .load_text_index

.error_1
	; printer battery low
	ld a, PRINTER_ERROR_1
	jr .load_text_index

.error_2
	; connection error
	ld a, PRINTER_ERROR_2
.load_text_index
	ld [wPrinterStatus], a
	ret

PlacePrinterStatusString:
; Print nonzero printer status
	ld a, [wPrinterStatus]
	and a
	ret z
	push af
	xor a
	ldh [hBGMapMode], a
	hlcoord 0, 5
	lb bc, 10, 18
	call Textbox
	pop af
	ld e, a
	ld d, 0
	ld hl, PrinterStatusStringPointers
	add hl, de
	add hl, de
	ld a, [hli]
	ld d, [hl]
	ld e, a
	hlcoord 1, 7
	rst PlaceString
	hlcoord 2, 15
	ld de, String_PressBToCancel
	rst PlaceString
	ld a, $1
	ldh [hBGMapMode], a
	xor a
	ld [wPrinterStatus], a
	ret

String_PressBToCancel:
	db "Press B to Cancel@"

PrinterStatusStringPointers:
	dw GBPrinterString_Null ; @
	dw GBPrinterString_CheckingLink ; CHECKING LINK
	dw GBPrinterString_Transmitting ; TRANSMITTING
	dw GBPrinterString_Printing ; PRINTING
	dw GBPrinterString_PrinterError1 ; error 1
	dw GBPrinterString_PrinterError2 ; error 2
	dw GBPrinterString_PrinterError3 ; error 3
	dw GBPrinterString_PrinterError4 ; error 4

GBPrinterString_Null: db "@"
GBPrinterString_CheckingLink: next " Checking link…@"
GBPrinterString_Transmitting: next "  Transmitting…@"
GBPrinterString_Printing:     next "    Printing…@"
GBPrinterString_PrinterError1:
	db   " Printer Error 1"
	next ""
	next "The batteries have"
	next "lost their charge."
	db   "@"
GBPrinterString_PrinterError2:
	db   " Printer Error 2"
	next ""
	next "The Game Link"
	next "Cable is not set."
	db   "@"
GBPrinterString_PrinterError3:
	db   " Printer Error 3"
	next ""
	next "The paper is"
	next "jammed or empty."
	db   "@"
GBPrinterString_PrinterError4:
	db   " Printer Error 4"
	next ""
	next "The temperature is"
	next "too hot or cold."
	db   "@"
