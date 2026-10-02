Serial::
; The serial interrupt.

	push hl
	push de
	push bc
	push af

	ld a, [wPrinterConnectionOpen]
	bit PRINTER_CONNECTION_OPEN, a
	jr nz, .printer

	ldh a, [hSerialConnectionStatus]
	inc a ; is it equal to CONNECTION_NOT_ESTABLISHED?
	jr z, .establish_connection

	ldh a, [rSB]
	ldh [hSerialReceive], a

	ldh a, [hSerialSend]
	ldh [rSB], a

	ldh a, [hSerialConnectionStatus]
	cp USING_INTERNAL_CLOCK
	jr z, .player2

	xor a
	ldh [rSC], a
	ld a, SC_START | SC_EXTERNAL
	ldh [rSC], a
	jr .player2

.establish_connection
	ldh a, [rSB]
	cp USING_EXTERNAL_CLOCK
	jr z, .player1
	cp USING_INTERNAL_CLOCK
	jr nz, .player2

.player1
	ldh [hSerialReceive], a
	ldh [hSerialConnectionStatus], a
	cp USING_INTERNAL_CLOCK
	jr z, ._player2

	xor a
	ldh [rSB], a
; Writing rDIV resets the divider, regardless of the written value.
	ld a, 3
	ldh [rDIV], a

.delay_loop
	ldh a, [rDIV]
	bit 7, a ; repeat while the divider's high bit is set
	jr nz, .delay_loop

	xor a
	ldh [rSC], a
	ld a, SC_START | SC_EXTERNAL
	ldh [rSC], a
	jr .player2

._player2
	xor a
	ldh [rSB], a

.player2
	ld a, TRUE
	ldh [hSerialReceivedNewData], a
	ld a, SERIAL_NO_DATA_BYTE
	ldh [hSerialSend], a

.end
	pop af
	pop bc
	pop de
	pop hl
	reti

.printer
	farcall _PrinterReceive
	jr .end

SafeLoadTempTileMapToTileMap::
	xor a
	assert NO_BG_MAP_TRANSFER == 0
	ldh [hBGMapMode], a
	call LoadTempTileMapToTileMap
	ld a, TRANSFER_TILEMAP
	ldh [hBGMapMode], a
	ret

LinkTransfer::
; Send the local action in the low nybble, qualified by the selected room.
	push bc
	ld a, [wLinkMode]
	cp LINK_TRADECENTER
	ld b, SERIAL_TRADECENTER
	jr z, .got_high_nybble
	ld b, SERIAL_BATTLE

.got_high_nybble
	call .Receive
	ld a, [wPlayerLinkAction]
	add b
	ldh [hSerialSend], a
	ldh a, [hSerialConnectionStatus]
	cp USING_INTERNAL_CLOCK
	jr nz, .player_1
	ld a, SC_INTERNAL
	ldh [rSC], a
	ld a, SC_START | SC_INTERNAL
	ldh [rSC], a

.player_1
	call .Receive
	pop bc
	ret

.Receive:
; Accept a peer action only when its high nybble matches the room.
	ldh a, [hSerialReceive]
	ld [wOtherPlayerLinkMode], a
	and SERIAL_MODE_MASK
	cp b
	ret nz
	xor a
	ldh [hSerialReceive], a
	ld a, [wOtherPlayerLinkMode]
	and SERIAL_ACTION_MASK
	ld [wOtherPlayerLinkAction], a
	ret

LinkDataReceived::
; Let the other system know that the data has been received.
	xor a
	ldh [hSerialSend], a
	ldh a, [hSerialConnectionStatus]
	cp USING_INTERNAL_CLOCK
	ret nz
	ld a, SC_INTERNAL
	ldh [rSC], a
	ld a, SC_START | SC_INTERNAL
	ldh [rSC], a
	ret
