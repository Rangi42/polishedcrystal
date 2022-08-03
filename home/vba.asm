CheckVBA:
	xor a
	ldh [rSC], a ; no-optimize redundant loads (VBA loads this wrong)
	ldh a, [rSC]
	or ~%01111100
	inc a
	ret z
	ld hl, $d000
	ld [hl], %11100100
	ld hl, $e000
	ld [hl], %00100111
	ld a, [$d000]
	cp %00100111
	ret
