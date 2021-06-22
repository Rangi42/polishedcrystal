CheckVBA:
	xor a
	ldh [rSC], a ; no-optimize redundant loads (VBA loads this wrong)
	ldh a, [rSC]
	and %01111100
	cp %01111100
	ret
