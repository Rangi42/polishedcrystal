Serial::
; The serial interrupt.

	push hl
	push de
	push bc
	push af

	ldh a, [hSerialConnectionStatus]
	inc a ; is it equal to -1?
	jr z, .init_player_number

	ldh a, [rSB]
	ldh [hSerialReceive], a

	ldh a, [hSerialSend]
	ldh [rSB], a

	ldh a, [hSerialConnectionStatus]
	cp USING_INTERNAL_CLOCK
	jr z, .player2

	xor a
	ldh [rSC], a
	ld a, START_TRANSFER_EXTERNAL_CLOCK
	ldh [rSC], a
	jr .player2

.init_player_number
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
	ld a, $3
	ldh [rDIV], a

.wait_bit_7
	ldh a, [rDIV]
	bit 7, a
	jr nz, .wait_bit_7

	xor a
	ldh [rSC], a
	ld a, START_TRANSFER_EXTERNAL_CLOCK
	ldh [rSC], a
	jr .player2

._player2
	xor a
	ldh [rSB], a

.player2
	ld a, $1
	ldh [hSerialReceivedNewData], a
	ld a, SERIAL_NO_DATA_BYTE
	ldh [hSerialSend], a

	pop af
	pop bc
	pop de
	pop hl
	reti

; hl = send data
; de = receive data
; bc = length of data
Serial_ExchangeBytes::
	ld a, $1
	ldh [hSerialIgnoringInitialData], a
.loop
	ld a, [hl]
	ldh [hSerialSend], a
	call Serial_ExchangeByte
	push bc
	ld b, a
	inc hl
	ld a, 48
.wait48
	dec a
	jr nz, .wait48
	ldh a, [hSerialIgnoringInitialData]
	and a
	ld a, b
	pop bc
	jr z, .load
	dec hl
	cp SERIAL_PREAMBLE_BYTE
	jr nz, .loop
	xor a
	ldh [hSerialIgnoringInitialData], a
	jr .loop

.load
	ld [de], a
	inc de
	dec bc
	ld a, b
	or c
	jr nz, .loop
	ret

Serial_ExchangeByte::
	xor a
	ldh [hSerialReceivedNewData], a
	ldh a, [hSerialConnectionStatus]
	cp USING_INTERNAL_CLOCK
	jr nz, .loop
	ld a, $1
	ldh [rSC], a
	ld a, START_TRANSFER_INTERNAL_CLOCK
	ldh [rSC], a

.loop
	ldh a, [hSerialReceivedNewData]
	and a
	jr nz, .ok
	ldh a, [hSerialConnectionStatus]
	cp $1
	jr nz, .doNotIncrementTimeoutCounter
	call CheckwLinkTimeoutFramesNonzero
	jr z, .doNotIncrementTimeoutCounter
	call .delay_15_cycles
	push hl
	ld hl, wLinkTimeoutFrames + 1
	inc [hl]
	jr nz, .no_rollover_up
	dec hl
	inc [hl]

.no_rollover_up
	pop hl
	call CheckwLinkTimeoutFramesNonzero
	jr nz, .loop
	jp SerialDisconnected

.doNotIncrementTimeoutCounter
	ldh a, [rIE]
	and 1 << SERIAL | 1 << TIMER | 1 << LCD_STAT | 1 << VBLANK
	cp 1 << SERIAL
	jr nz, .loop
	ld a, [wLinkByteTimeout]
	dec a
	ld [wLinkByteTimeout], a
	jr nz, .loop
	ld a, [wLinkByteTimeout + 1]
	dec a
	ld [wLinkByteTimeout + 1], a
	jr nz, .loop
	ldh a, [hSerialConnectionStatus]
	cp USING_EXTERNAL_CLOCK
	jr z, .ok

	ld a, 255
.delay_255_cycles
	dec a
	jr nz, .delay_255_cycles

.ok
	xor a
	ldh [hSerialReceivedNewData], a
	ldh a, [rIE]
	and 1 << SERIAL | 1 << TIMER | 1 << LCD_STAT | 1 << VBLANK
	sub 1 << SERIAL
	jr nz, .skipReloadingTimeoutCounter2

	;xor a
	ld [wLinkByteTimeout], a
	ld a, $50
	ld [wLinkByteTimeout + 1], a

.skipReloadingTimeoutCounter2
	ldh a, [hSerialReceive]
	cp SERIAL_NO_DATA_BYTE
	ret nz
	call CheckwLinkTimeoutFramesNonzero
	jr z, .done
	push hl
	ld hl, wLinkTimeoutFrames + 1
	ld a, [hl]
	dec a
	ld [hld], a
	inc a
	jr nz, .no_rollover
	dec [hl]

.no_rollover
	pop hl
	call CheckwLinkTimeoutFramesNonzero
	jr z, SerialDisconnected

.done
	ldh a, [rIE]
	and 1 << SERIAL | 1 << TIMER | 1 << LCD_STAT | 1 << VBLANK
	cp 1 << SERIAL
	ld a, SERIAL_NO_DATA_BYTE
	ret z
	ld a, [hl]
	ldh [hSerialSend], a
	call DelayFrame
	jp Serial_ExchangeByte

.delay_15_cycles
	ld a, 15
.delay_15_cycles_loop
	dec a
	jr nz, .delay_15_cycles_loop
	ret

CheckwLinkTimeoutFramesNonzero::
	push hl
	ld hl, wLinkTimeoutFrames
	ld a, [hli]
	or [hl]
	pop hl
	ret

SerialDisconnected::
; a is always 0 when this is called
	dec a
	ld [wLinkTimeoutFrames], a
	ld [wLinkTimeoutFrames + 1], a
	ret

; This is used to check that both players entered the same Cable Club room.
Serial_ExchangeSyncBytes::
	ld hl, wLinkPlayerSyncBuffer
	ld de, wLinkReceivedSyncBuffer
	ld c, $2
	ld a, $1
	ldh [hSerialIgnoringInitialData], a
.loop
	call DelayFrame
	ld a, [hl]
	ldh [hSerialSend], a
	call Serial_ExchangeByte
	ld b, a
	inc hl
	ldh a, [hSerialIgnoringInitialData]
	and a
	ld a, 0
	ldh [hSerialIgnoringInitialData], a
	jr nz, .loop
	ld a, b
	ld [de], a
	inc de
	dec c
	jr nz, .loop
	ret

Serial_PlaceWaitingTextAndSyncAndExchangeNybble::
	call LoadTileMapToTempTileMap
	call PlaceWaitingText
	call Serial_SyncAndExchangeNybble
	jp Call_LoadTempTileMapToTileMap

PlaceWaitingText::
	hlcoord 4, 10
	lb bc, 1, 10

	ld a, [wBattleMode]
	and a
	jr z, .notinbattle

	call Textbox
	jr .proceed

.notinbattle
	farcall LinkTextbox

.proceed
	hlcoord 5, 11
	ld de, .Waiting
	rst PlaceString
	ld c, 50
	jp DelayFrames

.Waiting:
	db "Waiting…!@"

Serial_SyncAndExchangeNybble::
	ld a, $ff
	ld [wOtherPlayerLinkAction], a
.loop
	call LinkTransfer
	call DelayFrame
	call CheckwLinkTimeoutFramesNonzero
	jr z, .check
	push hl
	ld hl, wLinkTimeoutFrames + 1
	dec [hl]
	jr nz, .skip
	dec hl
	dec [hl]
	jr nz, .skip
	pop hl
	xor a
	jp SerialDisconnected

.skip
	pop hl

.check
	ld a, [wOtherPlayerLinkAction]
	inc a
	jr z, .loop

	ld b, 10
.receive
	call DelayFrame
	call LinkTransfer
	dec b
	jr nz, .receive

	ld b, 10
.acknowledge
	call DelayFrame
	call LinkDataReceived
	dec b
	jr nz, .acknowledge

	ld a, [wOtherPlayerLinkAction]
	ld [wOtherPlayerLinkMode], a
	ret

LinkTransfer::
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
	ld a, $1
	ldh [rSC], a
	ld a, START_TRANSFER_INTERNAL_CLOCK
	ldh [rSC], a

.player_1
	call .Receive
	pop bc
	ret

.Receive:
	ldh a, [hSerialReceive]
	ld [wOtherPlayerLinkMode], a
	and $f0
	cp b
	ret nz
	xor a
	ldh [hSerialReceive], a
	ld a, [wOtherPlayerLinkMode]
	and $f
	ld [wOtherPlayerLinkAction], a
	ret

LinkDataReceived::
; Let the other system know that the data has been received.
	xor a
	ldh [hSerialSend], a
	ldh a, [hSerialConnectionStatus]
	cp USING_INTERNAL_CLOCK
	ret nz
	ld a, $1
	ldh [rSC], a
	ld a, START_TRANSFER_INTERNAL_CLOCK
	ldh [rSC], a
	ret
