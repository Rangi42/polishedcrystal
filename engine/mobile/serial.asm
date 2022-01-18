	setcharmap ascii

Mobile_Init:
; Attempt to initialize a mobile session.
	; Check if we've already began an initialization.
	ldh a, [hMobile]
	and a
	ret nz

	; Reset mobile session flag
	xor a
	ld [wMobileSessionEnabled], a

	ld a, MOBILE_STANDBY
	ldh [hMobile], a

	; Set up the effective transfer speed.
	; The serial link speed itself is 64KiB/s, but we need to space the bytes
	; out to give the adapter time to process every byte. This should be no
	; faster than 0.5ms. The following settings will cause it to be slightly
	; slower (0.503ms to be precise).
	; We set rTMA to zero because we are handling the TMA's job in the timer
	; interrupt instead. The reason is because we don't want other interrupts
	; delaying a timer interrupt leading the next to fire too quickly.
	xor a
	ldh [rTMA], a
	; "65536" is actually 131072 in practice due to doublespeed...
	ld a, (1 << rTAC_ON) | rTAC_65536_HZ
	ldh [rTAC], a

	; Set relevant interrupts in case they're disabled.
	ldh a, [rIE]
	or 1 << SERIAL | 1 << TIMER
	ldh [rIE], a

	; Let the adapter know we want to initialize. It may take up to around 25ms,
	; so wait 2 frames (33ms).
	call PingMobileAdapter
	ld c, 2
	call DelayFrames

	; Initialization
	ld hl, .NintendoText
	ld a, MOBILE_COMMAND_BEGIN_SESSION
	call SendMobileString
	call AwaitMobileResponse
	ret c

	ld a, 1
	ld [wMobileSessionEnabled], a

	; Read configuration file
	jp MobileReadConfig

.NintendoText
	db "NINTENDO", 0

MobileReadConfig:
; Reads the MA configuration and stores it
	ld a, BANK(wMobileConfig)
	call StackCallInWRAMBankA
.Function:
	xor a
	call .GetConfigHalf
	ld a, MOBILE_CONFIGURATION_SIZE / 2
	call .GetConfigHalf

	; If this isn't a valid configuration, load a default one instead.
	ld hl, wMobileConfig + MACFG_REGISTERED
	ld a, [hl]
	cp MOBILE_CONFIG_IS_REGISTERED
	ret z

	ld bc, MOBILE_CONFIGURATION_SIZE
	ld hl, DefaultMobileConfig
	ld de, wMobileConfig
	rst CopyBytes
	ret

.GetConfigHalf:
	ld hl, wMobilePacketContent
	ld [hli], a
	ld [hl], MOBILE_CONFIGURATION_SIZE / 2
	ld b, 2
	push af
	ld a, MOBILE_COMMAND_READ_CONFIGURATION_DATA
	call SendAndWait
	jr nc, .continue
	pop af
	ret

.continue
	; Config data starts at the second content byte
	ld bc, MOBILE_CONFIGURATION_SIZE / 2
	ld hl, wMobilePacketContent + 1
	ld de, wMobileConfig
	pop af
	add e
	ld e, a
	adc d
	sub e
	ld d, a
	rst CopyBytes
	ret

Mobile_ISPLogin::
; Logs into the ISP, allowing for Internet communication. Returns z
; upon failure.
	ld a, BANK(wMobileConfig)
	call StackCallInWRAMBankA
.Function:
	; Verify that we have a proper config
	ld hl, wMobileConfig + MACFG_REGISTERED
	ld a, [hl]
	cp MOBILE_CONFIG_IS_REGISTERED
	jr z, .config_is_valid
	xor a
	ret

.config_is_valid
	ld b, 10
.wait_for_telephone
	call MobileLineBusy
	ret c ; phone disconnected
	jr z, .telephone_free
	dec b
	ret z
	ld c, 10
	call DelayFrames
	jr .wait_for_telephone

.telephone_free
	; The phone number is stored in a BCD variant (a=#, b=*, f=terminator)
	ld hl, wMobileConfig + MACFG_PHONE1
	ld bc, wMobilePacketContent
	ld d, MOBILE_CONFIG_PHONE_BYTES * 2

	; First byte is zero
	xor a
	ld [bc], a
	inc bc
.read_isp_phone_number
	ld a, [hl]
	bit 0, d
	jr z, .swap_a
	inc hl
	jr .get_phone_nibble
.swap_a
	swap a
.get_phone_nibble
	and $f
	sub $a
	ld e, "#"
	jr z, .got_digit
	dec a
	ld e, "*"
	jr z, .got_digit
	sub 4
	jr z, .got_phone_number
	add $3f
	ld e, a
.got_digit
	ld a, e
	ld [bc], a
	inc bc
	dec d
	jr z, .got_phone_number
	jr .read_isp_phone_number
.got_phone_number
	ld a, 16
	sub d
	inc a ; initial padding
	ld b, a

	ld a, MOBILE_COMMAND_DIAL_TELEPHONE
	call SendAndWait
	ret c

	; Verify that we successfully dialed the number
	call MobileLineBusy
	ret z ; failed to call

	; Log into DION
	; User ID length
	ld de, wMobilePacketContent
	ld a, MOBILE_CONFIG_LOGIN_BYTES
	ld [de], a
	inc de
	ld hl, wMobileConfig + MACFG_LOGIN
	ld bc, MOBILE_CONFIG_LOGIN_BYTES
	call CopyBytes

	; Dummy password
	ld a, 8
	ld [de], a
	inc de
	ld hl, .DION_DefaultPassword
	ld bc, 8
	call CopyBytes

	; Primary + secondary DNS is right after each other in config
	ld hl, wMobileConfig + MACFG_PRIMARY_DNS
	ld bc, 8
	call CopyBytes

	; packet length: login length + login + pw length + pw + dns
	ld b, 1 + MOBILE_CONFIG_LOGIN_BYTES + 1 + 8 + 8
	ld a, MOBILE_COMMAND_ISP_LOGIN
	call SendAndWait
	ret c

	; Return z upon login failure
	ld a, [wMobilePacketCommand]
	xor $80
	cp MOBILE_ERROR_COMMAND
	ret

.DION_DefaultPassword:
	; TODO: if this is ever going to matter, perhaps try this first,
	; and upon auth failure, prompt for a password. This confuses
	; users less in the (very common) case of password not mattering.
	db "test1337", 0

MobileLineBusy:
; Returns z if line is free, c if phone is disconnected, nz if busy.
	ld a, MOBILE_COMMAND_TELEPHONE_STATUS
	push bc
	ld b, 0
	call SendAndWait
	pop bc
	ret c

	; -1: disconnected, 0: free, 4-5: busy
	ld a, [wMobilePacketContent]
	add 1
	ret c
	dec a
	ret

ResetChecksum:
	push af
	xor a
	ld [wMobilePacketChecksum], a
	ld [wMobilePacketChecksum + 1], a
	pop af
	ret

ExchangeTCPData:
; Send TCP data for connection a, length b from hl and outputs
; c bytes of the response in de. Returns c if we got a transfer
; end response, nc otherwise, with actual length in b. If b is
; less than the requested byte length, the last packet would have
; written too much -- it is left unwritten to de and remains stored.
; as part of the MA packet data.
; TODO: async alternative?
	ld [wMobileConnectionID], a

	; Send data
	push de
	ld de, wMobilePacketContent
	ld [de], a
	inc de
	push bc
	ld c, b
	ld b, 0
	call CopyBytes
	pop bc
	push bc
	inc b
	ld a, MOBILE_COMMAND_TRANSFER_DATA
	call SendAndWait

	; Handle response
	pop bc
	pop de
	ret c
	ld b, 0
ContinueExchangeTCPData:
.loop
	; Check for transfer end
	ld a, [wMobilePacketCommand]
	cp MOBILE_COMMAND_TRANSFER_DATA_END ^ $80
	scf
	ret z

	ld a, [wMobilePacketSize]
	dec a

	; Check for overflow or if we reached the requested byte length
	add b
	sub b
	ccf
	ret nc
	add b
	cp c
	jr z, _GotRequestedTCPLength
	ret nc

	; We have more to copy
ForceContinueExchangeTCPData:
; Continues exchanging TCP data, forcing a copy of last packet even on overflow
	ld b, a
_GotRequestedTCPLength:
	push bc
	push af
	ld c, a
	ld b, 0
	ld hl, wMobilePacketContent + 1
	rst CopyBytes
	pop af
	pop bc
	ret z ; got the requested amount of bytes
_NextTCPSend:
	push bc
	push de
	ld b, 1
	ld a, MOBILE_COMMAND_TRANSFER_DATA
	call SendAndWait
	pop de
	pop bc
	ret c
	jr ContinueExchangeTCPData

SetTCPCallback:
; Sets callback function to signal upon async TCP handling to a:hl.
	ld [wMobileCallbackBank], a
	ld a, l
	ld [wMobileCallbackAddr], a
	ld a, h
	ld [wMobileCallbackAddr + 1], a
	ret

AsyncTCP::
; Send TCP data for connection b, length c from hl. If a is zero, return after
; staging data for sending
	ret

SendMobileString::
; Sends ASCII string in hl up to but not including null terminator as a packet,
; using a as packet command.
	ld [wMobilePacketCommand], a
	ld de, wMobilePacketContent
	call Copy256ASCII
	ld b, c
	ld a, [wMobilePacketCommand]
	jr SendMobileBytesFromContent

Copy256ASCII:
	ld bc, 0
.loop
	ld a, [hli]
	and a
	ret z
	ld [de], a
	inc de
	inc bc
	ld a, b
	and a
	ret nz
	jr .loop

SendMobileBytesFromContent::
	ld hl, wMobilePacketContent
	; fallthrough
SendMobileBytesFromHL:
; Sends a packet with command a, size b, content in hl
	call ResetChecksum

	ld [wMobilePacketCommand], a
	call Mobile_ChecksumAdd

	; Prepare the packet data
	ld a, b
	ld [wMobilePacketSize], a
	call Mobile_ChecksumAdd
	ld de, wMobilePacketContent
	inc b
.loop
	dec b
	jr z, .finished
	ld a, [hli]
	ld [de], a
	call Mobile_ChecksumAdd
	inc de
	jr .loop
.finished
	jr SendMobilePacket

Mobile_ChecksumAdd:
; Adds a to mobile checksum counter. Preserves hl
	push hl
	ld hl, wMobilePacketChecksum + 1
	add [hl]
	ld [hld], a
	jr nc, .done
	inc [hl]
.done
	pop hl
	ret

SendMobilePacket:
	; Mark that we are sending data. This might inadvertly abort a staged send
	; by VBlank, but that is fine since it's only done for keep-alive reasons.
	ld a, MOBILE_SENDING
	ldh [hMobile], a
	; fallthrough
PingMobileAdapter:
; Sends 0x4B to let the adapter know we want something
	xor a
	ld [wMobilePendingData], a

	; Just in case VBlank just issued a keep-alive byte, wait for it to finish.
.sc_loop
	ldh a, [rSC]
	bit rSC_ON, a
	jr nz, .sc_loop

	ld a, MOBILE_RECV_BYTE
	ldh [rSB], a
	; fallthrough
MobileRequestNextByte:
; Stages current byte for sending.
	ldh a, [hMobile]
	set MOBILE_NEXTBYTE_F, a
	ldh [hMobile], a
	ret

SendAndWait::
	call SendMobileBytesFromContent
	; fallthrough
AwaitMobileResponse::
; Waits until ongoing mobile communication is complete. Returns c if mobile
; communication is offline.
.loop
	ldh a, [hMobile]
	cp MOBILE_RECEIVING
	ret c
	cp MOBILE_STANDBY
	ret z
	call DelayFrame
	jr .loop

MobileSerial::
	ldh a, [hMobile]
	bit MOBILE_USEFUL_F, a
	ret z
	res MOBILE_USEFUL_F, a
	ldh [hMobile], a
	cp MOBILE_SENDING
	jp z, .sending
	cp MOBILE_RECEIVING
	ret nz
	ld a, [wMobilePendingData]

	; Magic Bytes (2 bytes)
	and a
	ld c, a
	ld a, $99
	jp z, .first_byte
	dec c
	ld a, $66
	jr z, .expect_a

	; Header (4 bytes)
	dec c
	ld hl, wMobilePacketCommand
	jr z, .reset_checksum_write_to_hl
	xor a
	dec c
	jr z, .expect_a
	dec c
	jr z, .expect_a
	dec c
	ld hl, wMobilePacketSize
	jr z, .write_to_hl

	; Data (0-254 bytes)
	ld a, [wMobilePacketSize]
	ld b, 0
	dec c
	ld hl, wMobilePacketContent
	add hl, bc
	ld b, a
	ld a, c
	sub b
	jr c, .write_to_hl

	; Checksum (2 bytes)
	ld c, a
	ld hl, wMobilePacketChecksum
	jr z, .validate_checksum
	inc hl
	dec c
	ld a, MOBILE_DEVICE_CGB
	jr z, .validate_checksum_transfer

	; ACK signal (2 bytes)
	ld hl, wMobilePacketDevice
	ld a, [wMobilePacketCommand]
	xor $80
	dec c
	jr z, .dual_transfer

	; Final packet received. Should be zero.
	ldh a, [rSB]
	and a
	ld [wMobilePacketResult], a
	; a certain emulator sends the wrong thing here...
	; jp nz, .maerror_on_nz
	jp MobileFinishTransfer

.first_byte
	; Stall on $d2 until we have a $99
	call .GetSB
	cp b
	jr z, .recv_filler
	ld a, b
	cp MOBILE_SEND_BYTE
	jp nz, .maerror_on_nz
	jp ReceiveMobilePacket
.expect_a
	call .GetSB
	cp b
.maerror_on_nz
	jp nz, MobileError
	jr .recv_filler
.validate_checksum
	ld a, MOBILE_RECV_BYTE
.validate_checksum_transfer
	; Don't call GetSB since we want to leave the checksum alone
	push af
	ldh a, [rSB]
	ld b, a
	pop af
	ldh [rSB], a
	ld a, b
	cp [hl]
	jp z, .valid_recv
	ld a, MOBILE_ERROR_CHECKSUM
	ld [wMobilePacketCommand], a
	jp .valid_recv
.reset_checksum_write_to_hl
	call ResetChecksum
.write_to_hl
	call .GetSB
	ld [hl], b
.recv_filler
	ld a, MOBILE_RECV_BYTE
	jr .recv_a
.dual_transfer
	call .GetSB
	ld [hl], b
	jr .recv_a

.recv_a
	ldh [rSB], a
	jr .valid_recv

.GetSB:
	push af
	ldh a, [rSB]
	ld b, a
	call Mobile_ChecksumAdd
	pop af
	ret

.sending
	ld a, [wMobilePendingData]

	; Magic Bytes (2 bytes)
	and a
	ld c, a
	ld a, $99
	jr z, .send_a
	dec c
	ld a, $66
	jr z, .send_a

	; Header (4 bytes)
	dec c
	ld a, [wMobilePacketCommand]
	jr z, .send_a
	xor a
	dec c
	jr z, .send_a
	dec c
	jr z, .send_a
	dec c
	ld a, [wMobilePacketSize]
	jr z, .send_a

	; Data (0-254 bytes)
	ld b, 0
	dec c
	ld hl, wMobilePacketContent
	add hl, bc
	ld b, a
	ld a, c
	sub b
	jr c, .send_hl

	; Checksum (2 bytes)
	ld c, a
	ld a, [wMobilePacketChecksum]
	jr z, .send_a
	dec c
	ld a, [wMobilePacketChecksum + 1]
	jr z, .send_a

	; ACK signal (2 bytes)
	ld a, MOBILE_DEVICE_CGB
	dec c
	jr z, .send_a
	ld hl, wMobilePacketDevice
	xor a
	dec c
	jr z, .set_hl_and_send_a

	; Packet send complete.
	inc hl
	ldh a, [rSB]
	ld [hl], a
	jp MobileFinishTransfer

.set_hl_and_send_a
	push af
	ldh a, [rSB]
	ld [hl], a
	pop af
	jr .send_a
.send_hl
	ld a, [hl]
.send_a
	ldh [rSB], a
.valid_recv
	ld a, [wMobilePendingData]
	inc a
	ld [wMobilePendingData], a
	jp MobileRequestNextByte

MobileFinishTransfer::
; Verify that we successfully sent the packet
	; Set mobile connection to standby
	ld hl, hMobile
	ld a, [hl]
	ld [hl], MOBILE_STANDBY
	cp MOBILE_SENDING
	jr z, .sending

	ld a, [wMobilePacketCommand]
	cp MOBILE_ERROR_CHECKSUM
	jr z, ReceiveMobilePacket
	ret

.sending
	ld a, [wMobilePacketResult]

	; If we ran into a checksum error, just retry.
	cp MOBILE_ERROR_CHECKSUM ^ $80
	jp z, SendMobilePacket
	; fallthrough
ReceiveMobilePacket:
; Prepares to receive packet
	; Mark that we are receiving data
	ld a, MOBILE_RECEIVING
	ldh [hMobile], a
	jp PingMobileAdapter

MobileError:
; If session isn't yet active, assume no MA connected
	ld a, [wMobileSessionEnabled]
	and a
	jr z, .done_timeout

	; First, wait 190 frames (slightly above 3 seconds) for the 3s timeout to
	; kick in. Note that interrupts are currently disabled.
	ei
	ld c, 190
	call DelayFrames
	di

.done_timeout
	; silently drop Mobile Adapter mode
	xor a
	ld [wMobileSessionEnabled], a
	ldh [hMobile], a
	ret

Mobile_Abort:
	; Disable current session if running
	ld a, [wMobileSessionEnabled]
	and a
	jr z, .not_enabled

	; Terminate session
	ld a, MOBILE_COMMAND_END_SESSION
	ld b, 0
	call SendAndWait
	ret c

.not_enabled
	xor a
	ldh [hMobile], a
	ldh a, [rIE]
	and ~(1 << TIMER)
	ldh [rIE], a
	ret

Special_CheckMobileAvailability:
; Check if we've successfully initialized a mobile session.
; Returns z and sets hScriptVar to zero if mobile is unavailable.
	ldh a, [hMobile]
	and a
	jr z, .error

	ld a, [wMobileSessionEnabled]
	and a
.error
	ld [hScriptVar], a
	ret

	setcharmap default

DefaultMobileConfig:
INCBIN "data/default_mobile_config.bin"
