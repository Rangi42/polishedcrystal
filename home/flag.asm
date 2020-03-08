EventFlagAction::
	ld hl, wEventFlags
FlagAction::
; Perform action b on bit de in flag array hl.

; inputs:
; b: function
;    0 clear bit
;    1 set bit
;    2 check bit
; de: bit number
; hl: index within bit table

	; get index within the byte
	ld a, 1

	; shift de right by three bits (get the index within memory)
	srl d
	rr e
	jr nc, .one
	add a
.one
	srl d
	rr e
	jr nc, .two
	add a
	add a
.two
	srl d
	rr e
	jr nc, .three
	swap a
.three
	add hl, de
	ld c, a ; mimic behaviour of old FlagAction to appease legacy code

	; check b's value: 0, 1, 2
	inc b
	dec b
	jr z, .clearbit
	dec b
	jr z, .setbit

	; Check bit
	and [hl]
	ld c, a ; legacy code assumes the flag check places the result here
	ret

.clearbit
	cpl
	and [hl]
	ld [hl], a
	ret

.setbit
	or [hl]
	ld [hl], a
	ret

CheckReceivedDex::
	ld de, ENGINE_POKEDEX
	ld b, CHECK_FLAG
	farcall EngineFlagAction
	ld a, c
	and a
	ret
