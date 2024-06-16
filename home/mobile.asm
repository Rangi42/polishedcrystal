DNSQuery::
; Performs a DNS lookup of domain in hl. Returns z if unsuccessful
	ld a, MOBILE_COMMAND_DNS_QUERY
	call SendMobileString
	farcall AwaitMobileResponse
	call CheckMobileError
	ret z
	ld hl, wMobilePacketContent
	ld de, wMobileDNSResponse
	ld bc, 4
	rst CopyBytes
	or 1
	ret

ConnectToDomain::
; Connects to domain in hl with port bc
	push bc
	call DNSQuery
	pop bc
	ret z
	ld hl, wMobileDNSResponse
ConnectToIP::
; Connects to IP in hl with port bc. Returns z if connection was unsuccessful
	ld de, wMobilePacketContent
	push bc
	ld bc, 4
	rst CopyBytes
	pop bc
	ld a, b
	ld [wMobilePacketContent + 4], a
	ld a, c
	ld [wMobilePacketContent + 5], a
	ld b, 6
	ld a, MOBILE_COMMAND_OPEN_TCP_CONNECTION
	farcall SendAndWait
	; fallthrough
CheckMobileError:
	ld a, [wMobilePacketCommand]
	xor $80
	cp MOBILE_ERROR_COMMAND
	ret
