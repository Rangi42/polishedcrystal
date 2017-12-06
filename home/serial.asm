Serial:: ; 6ef
; The serial interrupt.

	push af
	push bc
	push de
	push hl

	ld a, [wPrinterConnectionOpen]

	ld a, [hSerialConnectionStatus]
	inc a ; is it equal to -1?
	jr z, .init_player_number

	ld a, [rSB]
	ld [hSerialReceive], a

	ld a, [hSerialSend]
	ld [rSB], a

	ld a, [hSerialConnectionStatus]
	cp USING_INTERNAL_CLOCK
	jr z, .player2

	xor a
	ld [rSC], a
	ld a, START_TRANSFER_EXTERNAL_CLOCK
	ld [rSC], a
	jr .player2

.init_player_number
	ld a, [rSB]
	cp USING_EXTERNAL_CLOCK
	jr z, .player1
	cp USING_INTERNAL_CLOCK
	jr nz, .player2

.player1
	ld [hSerialReceive], a
	ld [hSerialConnectionStatus], a
	cp USING_INTERNAL_CLOCK
	jr z, ._player2

	xor a
	ld [rSB], a
	ld a, $3
	ld [rDIV], a

.wait_bit_7
	ld a, [rDIV]
	bit 7, a
	jr nz, .wait_bit_7

	xor a
	ld [rSC], a
	ld a, START_TRANSFER_EXTERNAL_CLOCK
	ld [rSC], a
	jr .player2

._player2
	xor a
	ld [rSB], a

.player2
	ld a, $1
	ld [hSerialReceivedNewData], a
	ld a, SERIAL_NO_DATA_BYTE
	ld [hSerialSend], a

	pop hl
	pop de
	pop bc
	pop af
	reti
; 75f

Timer:: ; 3e93
	reti
; 3ed7

; hl = send data
; de = receive data
; bc = length of data
Serial_ExchangeBytes:: ; 75f
	ld a, $1
	ld [hSerialIgnoringInitialData], a
.loop
	ld a, [hl]
	ld [hSerialSend], a
	call Serial_ExchangeByte
	push bc
	ld b, a
	inc hl
	ld a, 48
.wait48
	dec a
	jr nz, .wait48
	ld a, [hSerialIgnoringInitialData]
	and a
	ld a, b
	pop bc
	jr z, .load
	dec hl
	cp SERIAL_PREAMBLE_BYTE
	jr nz, .loop
	xor a
	ld [hSerialIgnoringInitialData], a
	jr .loop

.load
	ld [de], a
	inc de
	dec bc
	ld a, b
	or c
	jr nz, .loop
	ret
; 78a

Serial_ExchangeByte:: ; 78a
	xor a
	ld [hSerialReceivedNewData], a
	ld a, [hSerialConnectionStatus]
	cp USING_INTERNAL_CLOCK
	jr nz, .loop
	ld a, $1
	ld [rSC], a
	ld a, START_TRANSFER_INTERNAL_CLOCK
	ld [rSC], a

.loop
	ld a, [hSerialReceivedNewData]
	and a
	jr nz, .ok
	ld a, [hSerialConnectionStatus]
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
	ld a, [rIE]
	and (1 << SERIAL) | (1 << TIMER) | (1 << LCD_STAT) | (1 << VBLANK)
	cp (1 << SERIAL)
	jr nz, .loop
	ld a, [wcf5d]
	dec a
	ld [wcf5d], a
	jr nz, .loop
	ld a, [wcf5d + 1]
	dec a
	ld [wcf5d + 1], a
	jr nz, .loop
	ld a, [hSerialConnectionStatus]
	cp USING_EXTERNAL_CLOCK
	jr z, .ok

	ld a, 255
.delay_255_cycles
	dec a
	jr nz, .delay_255_cycles

.ok
	xor a
	ld [hSerialReceivedNewData], a
	ld a, [rIE]
	and (1 << SERIAL) | (1 << TIMER) | (1 << LCD_STAT) | (1 << VBLANK)
	sub (1 << SERIAL)
	jr nz, .skipReloadingTimeoutCounter2

	;xor a
	ld [wcf5d], a
	ld a, $50
	ld [wcf5d + 1], a

.skipReloadingTimeoutCounter2
	ld a, [hSerialReceive]
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
	ld a, [rIE]
	and (1 << SERIAL) | (1 << TIMER) | (1 << LCD_STAT) | (1 << VBLANK)
	cp (1 << SERIAL)
	ld a, SERIAL_NO_DATA_BYTE
	ret z
	ld a, [hl]
	ld [hSerialSend], a
	call DelayFrame
	jp Serial_ExchangeByte

.delay_15_cycles
	ld a, 15
.delay_15_cycles_loop
	dec a
	jr nz, .delay_15_cycles_loop
	ret
; 82b

CheckwLinkTimeoutFramesNonzero:: ; 82b
	push hl
	ld hl, wLinkTimeoutFrames
	ld a, [hli]
	or [hl]
	pop hl
	ret
; 833

SerialDisconnected:: ; 833
; a is always 0 when this is called
	dec a
	ld [wLinkTimeoutFrames], a
	ld [wLinkTimeoutFrames + 1], a
	ret
; 83b

; This is used to exchange the button press and selected menu item on the link menu.
; The data is sent thrice and read twice to increase reliability.
Serial_ExchangeLinkMenuSelection:: ; 83b
	ld hl, wPlayerLinkAction
	ld de, wOtherPlayerLinkMode
	ld c, $2
	ld a, $1
	ld [hSerialIgnoringInitialData], a
.loop
	call DelayFrame
	ld a, [hl]
	ld [hSerialSend], a
	call Serial_ExchangeByte
	ld b, a
	inc hl
	ld a, [hSerialIgnoringInitialData]
	and a
	ld a, 0 ; not xor a; preserve carry flag
	ld [hSerialIgnoringInitialData], a
	jr nz, .loop
	ld a, b
	ld [de], a
	inc de
	dec c
	jr nz, .loop
	ret
; 862

Serial_PlaceWaitingTextAndSyncAndExchangeNybble:: ; 862
	call LoadTileMapToTempTileMap
	call PlaceWaitingText
	call Serial_SyncAndExchangeNybble
	jp Call_LoadTempTileMapToTileMap
; 871

PlaceWaitingText:: ; 4000
	hlcoord 4, 10
	lb bc, 1, 10

	ld a, [wBattleMode]
	and a
	jr z, .notinbattle

	call TextBox
	jr .proceed

.notinbattle
	farcall LinkTextbox

.proceed
	hlcoord 5, 11
	ld de, .Waiting
	call PlaceString
	ld c, 50
	jp DelayFrames

.Waiting: ; 4025
	db "Waiting…!@"

Serial_SyncAndExchangeNybble:: ; 87d
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
; 8c1

LinkTransfer:: ; 8c1
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
	ld [hSerialSend], a
	ld a, [hSerialConnectionStatus]
	cp USING_INTERNAL_CLOCK
	jr nz, .player_1
	ld a, $1
	ld [rSC], a
	ld a, START_TRANSFER_INTERNAL_CLOCK
	ld [rSC], a

.player_1
	call .Receive
	pop bc
	ret
; 8f3

.Receive: ; 8f3
	ld a, [hSerialReceive]
	ld [wOtherPlayerLinkMode], a
	and $f0
	cp b
	ret nz
	xor a
	ld [hSerialReceive], a
	ld a, [wOtherPlayerLinkMode]
	and $f
	ld [wOtherPlayerLinkAction], a
	ret
; 908

LinkDataReceived:: ; 908
; Let the other system know that the data has been received.
	xor a
	ld [hSerialSend], a
	ld a, [hSerialConnectionStatus]
	cp USING_INTERNAL_CLOCK
	ret nz
	ld a, $1
	ld [rSC], a
	ld a, START_TRANSFER_INTERNAL_CLOCK
	ld [rSC], a
	ret
; 919
