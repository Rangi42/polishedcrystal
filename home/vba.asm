CheckVBA:
	xor a
	ldh [rSC], a ; no-optimize redundant loads (VBA loads this wrong)
	ldh a, [rSC]
	or ~%01111100
	inc a
	ret
