Printer_StartTransmission:
	ld hl, wGameboyPrinterRAM
	ld bc, wGameboyPrinterRAMEnd - wGameboyPrinterRAM
	xor a
	rst ByteFill
	xor a
	ldh [rSB], a
	ldh [rSC], a
	ld [wPrinterOpcode], a
	ld hl, wPrinterConnectionOpen
	set PRINTER_CONNECTION_OPEN, [hl]
	ld a, $40 ; GBPRINTER_NORMAL brightness
	ld [wPrinterExposureTime], a
	xor a
	ld [wJumptableIndex], a
	ret

PrinterJumptableIteration:
	ld hl, .Jumptable
	jmp JumpTable

.Jumptable:
	dw Print_InitPrinterHandshake ; 00
	dw Printer_CheckConnectionStatus ; 01
	dw Printer_WaitSerial ; 02
	dw Printer_StartTransmittingTilemap ; 03
	dw Printer_TransmissionLoop ; 04
	dw Printer_WaitSerialAndLoopBack2 ; 05

	dw Printer_EndTilemapTransmission ; 06
	dw Printer_TransmissionLoop ; 07
	dw Printer_WaitSerial ; 08
	dw Printer_SignalSendHeader ; 09
	dw Printer_TransmissionLoop ; 0a
	dw Printer_WaitSerial ; 0b
	dw Printer_WaitUntilFinished ; 0c
	dw Printer_Quit ; 0d

	dw Printer_NextSection ; 0e
	dw Printer_WaitSerial ; 0f
	dw Printer_SignalLoopBack ; 10
	dw Printer_SectionOne ; 11
	dw Printer_NextSectionWaitLoopBack ; 12
	dw Printer_WaitLoopBack ; 13

Printer_NextSection:
	ld hl, wJumptableIndex
	inc [hl]
	ret

Printer_PrevSection:
	ld hl, wJumptableIndex
	dec [hl]
	ret

Printer_Quit:
	xor a
	ld [wPrinterStatusFlags], a
	ld hl, wJumptableIndex
	set JUMPTABLE_EXIT_F, [hl]
	ret

Printer_SectionOne:
	ld a, $1
	ld [wJumptableIndex], a
	ret

Print_InitPrinterHandshake:
	call Printer_ResetData
	ld hl, PrinterDataPacket1
	call Printer_CopyPacket
	xor a
	ld [wPrinterSendByteCounter], a
	ld [wPrinterSendByteCounter + 1], a
	ld a, [wPrinterQueueLength]
	ld [wPrinterRowIndex], a
	call Printer_NextSection
	call Printer_WaitHandshake
	ld a, PRINTER_STATUS_CHECKING
	ld [wPrinterStatus], a
	ret

Printer_StartTransmittingTilemap:
	call Printer_ResetData
	; check remaining tile data
	ld hl, wPrinterRowIndex
	ld a, [hl]
	and a
	jr z, Printer_EndTilemapTransmission
	; send packet 3
	ld hl, PrinterDataPacket3 ; signal start of transmission
	call Printer_CopyPacket
	; prepare to send 40 tiles
	call Printer_Convert2RowsTo2bpp
	ld a, LOW(40 tiles)
	ld [wPrinterSendByteCounter], a
	ld a, HIGH(40 tiles)
	ld [wPrinterSendByteCounter + 1], a
	; compute the checksum
	call Printer_ComputeChecksum
	call Printer_NextSection
	call Printer_WaitHandshake
	ld a, PRINTER_STATUS_TRANSMITTING
	ld [wPrinterStatus], a
	ret

Printer_EndTilemapTransmission:
	; ensure that we go from here to routine 7
	ld a, $6
	ld [wJumptableIndex], a
	; send packet 4
	ld hl, PrinterDataPacket4 ; signal no transmission
	call Printer_CopyPacket
	; send no tile data
	xor a
	ld [wPrinterSendByteCounter], a
	ld [wPrinterSendByteCounter + 1], a
	call Printer_NextSection
	jmp Printer_WaitHandshake

Printer_SignalSendHeader:
	call Printer_ResetData
	ld hl, PrinterDataPacket2 ; signal request print
	call Printer_CopyPacket
	; prepare to send 1 tile
	call Printer_StageHeaderForSend
	ld a, LOW(4)
	ld [wPrinterSendByteCounter], a
	ld a, HIGH(4)
	ld [wPrinterSendByteCounter + 1], a
	; compute the checksum
	call Printer_ComputeChecksum
	call Printer_NextSection
	call Printer_WaitHandshake
	ld a, PRINTER_STATUS_PRINTING
	ld [wPrinterStatus], a
	ret

Printer_SignalLoopBack:
	call Printer_ResetData
	; send packet 1
	ld hl, PrinterDataPacket1 ; signal no transmission
	call Printer_CopyPacket
	; send no tile data
	xor a
	ld [wPrinterSendByteCounter], a
	ld [wPrinterSendByteCounter + 1], a
	ld a, [wPrinterQueueLength]
	ld [wPrinterRowIndex], a
	call Printer_NextSection
	jmp Printer_WaitHandshake

Printer_WaitSerial:
	ld hl, wPrinterSerialFrameDelay
	inc [hl]
	ld a, [hl]
	cp $6
	ret c
	xor a
	ld [hl], a
	jmp Printer_NextSection

Printer_WaitSerialAndLoopBack2:
	ld hl, wPrinterSerialFrameDelay
	inc [hl]
	ld a, [hl]
	cp $6
	ret c
	xor a
	ld [hl], a
	ld hl, wPrinterRowIndex
	dec [hl]
	call Printer_PrevSection
	jmp Printer_PrevSection

Printer_CheckConnectionStatus:
	ld a, [wPrinterOpcode]
	and a
	ret nz
	ld a, [wPrinterHandshake]
	cp $ff
	jr nz, .printer_connected
	ld a, [wPrinterStatusFlags]
	cp $ff
	jr z, .printer_error

.printer_connected
	ld a, [wPrinterHandshake]
	cp $81
	jr nz, .printer_error
	ld a, [wPrinterStatusFlags]
	and a
	jr nz, .printer_error
	ld hl, wPrinterConnectionOpen
	set PRINTER_CONNECTION_SUCCESS, [hl]
	ld a, $5
	ld [wHandshakeFrameDelay], a
	jmp Printer_NextSection

.printer_error
	ld a, $ff
	ld [wPrinterHandshake], a
	ld [wPrinterStatusFlags], a
	ld a, $e
	ld [wJumptableIndex], a
	ret

Printer_TransmissionLoop:
	ld a, [wPrinterOpcode]
	and a
	ret nz
	ld a, [wPrinterStatusFlags]
	and $f0
	jr nz, .enter_wait_loop
	ld a, [wPrinterStatusFlags]
	and $1
	jmp z, Printer_NextSection
	jmp Printer_PrevSection

.enter_wait_loop
	ld a, $12 ; Printer_NextSectionWaitLoopBack
	ld [wJumptableIndex], a
	ret

Printer_WaitUntilFinished:
	ld a, [wPrinterOpcode]
	and a
	ret nz
	ld a, [wPrinterStatusFlags]
	and $f3
	ret nz
	jmp Printer_NextSection

Printer_NextSectionWaitLoopBack:
	call Printer_NextSection
Printer_WaitLoopBack:
	ld a, [wPrinterOpcode]
	and a
	ret nz
	ld a, [wPrinterStatusFlags]
	and $f0
	ret nz
	xor a
	ld [wJumptableIndex], a
	ret

Printer_WaitHandshake:
.loop
	ld a, [wPrinterOpcode]
	and a
	jr nz, .loop
	xor a
	ld [wPrinterSendByteOffset], a
	ld [wPrinterSendByteOffset + 1], a
	ld a, $1
	ld [wPrinterOpcode], a
	ld a, $88
	ldh [rSB], a
	ld a, SC_INTERNAL
	ldh [rSC], a
	ld a, SC_START | SC_INTERNAL
	ldh [rSC], a
	ret

Printer_CopyPacket:
	ld a, [hli]
	ld [wPrinterData], a
	ld a, [hli]
	ld [wPrinterData + 1], a
	ld a, [hli]
	ld [wPrinterData + 2], a
	ld a, [hli]
	ld [wPrinterData + 3], a
	ld a, [hli]
	ld [wPrinterChecksum], a
	ld a, [hl]
	ld [wPrinterChecksum + 1], a
	ret

Printer_ResetData:
	xor a
	ld hl, wPrinterData
	ld [hli], a
	ld [hli], a
	ld [hli], a
	ld [hl], a
	ld hl, wPrinterChecksum
	ld [hli], a
	ld [hl], a
	xor a
	ld [wPrinterSendByteCounter], a
	ld [wPrinterSendByteCounter + 1], a
	ld hl, wGameboyPrinter2bppSource
	ld bc, wGameboyPrinter2bppSourceEnd - wGameboyPrinter2bppSource
	jmp ByteFill

Printer_ComputeChecksum:
	ld hl, 0
	ld bc, 4
	ld de, wPrinterData
	call .ComputeChecksum
	ld a, [wPrinterSendByteCounter]
	ld c, a
	ld a, [wPrinterSendByteCounter + 1]
	ld b, a
	ld de, wGameboyPrinterRAM
	call .ComputeChecksum
	ld a, l
	ld [wPrinterChecksum], a
	ld a, h
	ld [wPrinterChecksum + 1], a
	ret

.ComputeChecksum:
.loop
	ld a, [de]
	inc de
	add l
	jr nc, .no_overflow
	inc h
.no_overflow
	ld l, a
	dec bc
	ld a, c
	or b
	jr nz, .loop
	ret

Printer_StageHeaderForSend:
	ld a, $1
	ld [wGameboyPrinter2bppSource + 0], a
	ld a, [wPrinterMargins]
	ld [wGameboyPrinter2bppSource + 1], a
	ld a, %11100100 ; 3,2,1,0
	ld [wGameboyPrinter2bppSource + 2], a
	ld a, [wPrinterExposureTime]
	ld [wGameboyPrinter2bppSource + 3], a
	ret

Printer_Convert2RowsTo2bpp:
	; de = wPrinterTilemapBuffer + 2 * SCREEN_WIDTH * ([wPrinterQueueLength] - [wPrinterRowIndex])
	ld a, [wPrinterRowIndex]
	cpl
	ld d, a
	ld a, [wPrinterQueueLength]
	inc a
	add d
	ld hl, wPrinterTilemapBuffer
	ld de, 2 * SCREEN_WIDTH
.loop1
	and a
	jr z, .okay1
	add hl, de
	dec a
	jr .loop1
.okay1
	ld e, l
	ld d, h
	ld hl, wGameboyPrinter2bppSource
	ld c, 2 * SCREEN_WIDTH
.loop2
	ld a, [de]
	inc de
	push bc
	push de
	push hl
	; convert tile index to vram address
	swap a
	ld d, a
	and $f0
	ld e, a
	ld a, d
	and $f
	ld d, a
	and $8
	ld a, d
	jr nz, .vtiles_8xxx
	or $90
	jr .got_vtile_addr

.vtiles_8xxx
	or $80
.got_vtile_addr
	ld d, a
	call Printer_Get2bpp
	pop hl
	ld de, 1 tiles
	add hl, de
	pop de
	pop bc
	dec c
	jr nz, .loop2
	ret

Printer_Get2bpp:
; Copies 1 tiles from hl to de.
	di
.loop
	ldh a, [rLY]
	cp 144
	jr c, .loop
	cp 150
	jr nc, .loop
	call SwapHLDE
	ld bc, 16
	rst CopyBytes
	reti

PrinterDataPacket1:
	db  1, 0, $00, 0
	dw 1
PrinterDataPacket2:
	db  2, 0, $04, 0
	dw 0
PrinterDataPacket3:
	db  4, 0, $80, 2
	dw 0
PrinterDataPacket4:
	db  4, 0, $00, 0
	dw 4

_PrinterReceive::
	ld a, [wPrinterOpcode]
	add a
	ld e, a
	ld d, 0
	ld hl, .Jumptable
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jp hl

.Jumptable:
	dw DoNothing ; 00

	dw Printer_Send0x33 ; 01
	dw Printer_SendPrinterData1 ; 02
	dw Printer_SendPrinterData2 ; 03
	dw Printer_SendPrinterData3 ; 04
	dw Printer_SendPrinterData4 ; 05
	dw Printer_SendNextByte ; 06
	dw Printer_SendwPrinterChecksumLo ; 07
	dw Printer_SendwPrinterChecksumHi ; 08
	dw Printer_Send0x00 ; 09
	dw Printer_ReceiveTwoPrinterHandshakeAndSend0x00 ; 0a
	dw Printer_ReceiveTwoPrinterStatusFlagsAndExitSendLoop ; 0b

	dw Printer_Send0x33 ; 0c triggered by AskSerial
	dw Printer_Send0x0f ; 0d
	dw Printer_Send0x00 ; 0e
	dw Printer_Send0x00 ; 0f
	dw Printer_Send0x00 ; 10
	dw Printer_Send0x0f ; 11
	dw Printer_Send0x00 ; 12
	dw Printer_Send0x00 ; 13
	dw Printer_ReceiveTwoPrinterHandshakeAndSend0x00 ; 14
	dw Printer_ReceiveTwoPrinterStatusFlagsAndExitSendLoop ; 15

	dw Printer_Send0x33 ; 16 triggered by pressing B
	dw Printer_Send0x08 ; 17
	dw Printer_Send0x00 ; 18
	dw Printer_Send0x00 ; 19
	dw Printer_Send0x00 ; 1a
	dw Printer_Send0x08 ; 1b
	dw Printer_Send0x00 ; 1c
	dw Printer_Send0x00 ; 1d
	dw Printer_ReceiveTwoPrinterHandshakeAndSend0x00 ; 1e
	dw Printer_ReceiveTwoPrinterStatusFlagsAndExitSendLoop ; 1f

Printer_NextInstruction:
	ld hl, wPrinterOpcode
	inc [hl]
	ret

Printer_Send0x33:
	ld a, $33
	call Printer_SerialSend
	jr Printer_NextInstruction

Printer_SendPrinterData1:
	ld a, [wPrinterData]
	call Printer_SerialSend
	jr Printer_NextInstruction

Printer_SendPrinterData2:
	ld a, [wPrinterData + 1]
	call Printer_SerialSend
	jr Printer_NextInstruction

Printer_SendPrinterData3:
	ld a, [wPrinterData + 2]
	call Printer_SerialSend
	jr Printer_NextInstruction

Printer_SendPrinterData4:
	ld a, [wPrinterData + 3]
	call Printer_SerialSend
	jr Printer_NextInstruction

Printer_SendNextByte:
	; decrement 16-bit counter
	ld hl, wPrinterSendByteCounter
	ld a, [hli]
	ld d, [hl]
	ld e, a
	or d
	jr z, .done
	dec de
	ld a, d
	ld [hld], a
	ld [hl], e

	ld a, [wPrinterSendByteOffset]
	ld e, a
	ld a, [wPrinterSendByteOffset + 1]
	ld d, a
	ld hl, wGameboyPrinterRAM
	add hl, de
	inc de
	ld a, e
	ld [wPrinterSendByteOffset], a
	ld a, d
	ld [wPrinterSendByteOffset + 1], a
	ld a, [hl]
	jr Printer_SerialSend

.done
	call Printer_NextInstruction
Printer_SendwPrinterChecksumLo:
	ld a, [wPrinterChecksum]
	call Printer_SerialSend
	jr Printer_NextInstruction

Printer_SendwPrinterChecksumHi:
	ld a, [wPrinterChecksum + 1]
	call Printer_SerialSend
	jr Printer_NextInstruction

Printer_ReceiveTwoPrinterHandshakeAndSend0x00:
	ldh a, [rSB]
	ld [wPrinterHandshake], a
	xor a
	call Printer_SerialSend
	jr Printer_NextInstruction

Printer_ReceiveTwoPrinterStatusFlagsAndExitSendLoop:
	ldh a, [rSB]
	ld [wPrinterStatusFlags], a
	xor a
	ld [wPrinterOpcode], a
	ret

Printer_Send0x0f:
	ld a, $f
	call Printer_SerialSend
	jr Printer_NextInstruction

Printer_Send0x00:
	xor a
	call Printer_SerialSend
	jmp Printer_NextInstruction

Printer_Send0x08:
	ld a, $8
	call Printer_SerialSend
	jmp Printer_NextInstruction

Printer_SerialSend:
	ldh [rSB], a
	ld a, SC_INTERNAL
	ldh [rSC], a
	ld a, SC_START | SC_INTERNAL
	ldh [rSC], a
	ret

AskSerial::
; send out a handshake while serial int is off
	ld a, [wPrinterConnectionOpen]
	bit PRINTER_CONNECTION_OPEN, a
	ret z

; if we're still interpreting data, don't try to receive
	ld a, [wPrinterOpcode]
	and a
	ret nz

; once every 6 frames
	ld hl, wHandshakeFrameDelay
	inc [hl]
	ld a, [hl]
	cp 6
	ret c

	xor a
	ld [hl], a

	ld a, $0c
	ld [wPrinterOpcode], a

; handshake
	ld a, $88
	ldh [rSB], a

; switch to internal clock
	ld a, SC_INTERNAL
	ldh [rSC], a

; start transfer
	ld a, SC_START | SC_INTERNAL
	ldh [rSC], a

	ret
