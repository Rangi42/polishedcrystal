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
	; 'ret z' is timing-critical; it's one cycle slower
	; than 'ret', so OAM copy will be done.
	ret z
ENDL
OAMDMACodeEnd:
