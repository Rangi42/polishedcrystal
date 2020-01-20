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
	ld a, HIGH(wSprites)
	ld [rDMA], a
	ld a, (wSpritesEnd - wSprites) / 4
.pushoam_loop
	dec a
	jr nz, .pushoam_loop
	ret
.PushOAMEnd
