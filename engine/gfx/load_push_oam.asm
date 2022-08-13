WriteOAMDMACodeToHRAM::
	lb bc, (OAMDMACodeEnd - OAMDMACode), LOW(hPushOAM)
	ld hl, OAMDMACode
.copy
	ld a, [hli]
	ldh [c], a
	inc c
	dec b
	jr nz, .copy
	ret

OAMDMACode:
LOAD "OAM DMA", HRAM
hPushOAM::
	ldh [c], a
.wait
	dec b
	jr nz, .wait
	ret z ; not ret! otherwise OAM copy isn't done yet!
ENDL
OAMDMACodeEnd:
