WriteOAMDMACodeToHRAM::
	lb bc, (.PushOAMEnd - .PushOAM), LOW(hPushOAM)
	ld hl, .PushOAM
.loop
	ld a, [hli]
	ldh [c], a
	inc c
	dec b
	jr nz, .loop
	ret

.PushOAM:
	ld [c], a
.pushoam_loop
	dec b
	jr nz, .pushoam_loop
	ret
.PushOAMEnd
