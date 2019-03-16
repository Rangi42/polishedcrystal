EventFlagAction:: ; 0x2e6f
	ld hl, wEventFlags
FlagAction:: ; 0x2e76
; Perform action b on bit de in flag array hl.

; inputs:
; b: function
;    0 clear bit
;    1 set bit
;    2 check bit
; de: bit number
; hl: index within bit table

	; get index within the byte
	ld a, e
	and 7

	; shift de right by three bits (get the index within memory)
	srl d
	rr e
	srl d
	rr e
	srl d
	rr e
	add hl, de

	; implement a decoder
	ld c, 1
	rrca
	jr nc, .one
	rlc c
.one
	rrca
	jr nc, .two
	rlc c
	rlc c
.two
	rrca
	jr nc, .three
	swap c
.three

	; check b's value: 0, 1, 2
	ld a, b
	cp 1
	jr c, .clearbit ; 0
	jr z, .setbit ; 1

	; check bit
	ld a, [hl]
	and c
	ld c, a
	ret

.setbit
	; set bit
	ld a, [hl]
	or c
	ld [hl], a
	ret

.clearbit
	; clear bit
	ld a, c
	cpl
	and [hl]
	ld [hl], a
	ret
; 0x2ead


CheckReceivedDex:: ; 2ead
	ld de, ENGINE_POKEDEX
	ld b, CHECK_FLAG
	farcall EngineFlagAction
	ld a, c
	and a
	ret
; 2ebb
