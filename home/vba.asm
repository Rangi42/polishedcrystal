CheckVBA:
	xor a
	ldh [rSC], a ; no-optimize redundant loads (VBA loads this wrong)
	ldh a, [rSC]
	or ~%01111100
	inc a
	ret z
	assert STARTOF(WRAM0) <= wEchoRAMTest && wEchoRAMTest < STARTOF(WRAM0) + SIZEOF(WRAM0), \
		"wEchoRAMTest is not in WRAM0"
	ld hl, wEchoRAMTest
	ld [hl], %11100100
	ld hl, wEchoRAMTest + $2000 ; echo RAM
	ld [hl], %00100111
	ld a, [wEchoRAMTest]
	cp %00100111
	ret
