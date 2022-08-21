PlaySlowCry:
	ldh a, [hScriptVar]
	ld c, a
	ldh a, [hScriptVar+1]
	ld b, a
PlaySlowCryBC:
	call LoadCryHeader
	ret c
	; cry length *= 1.5
	ld hl, wCryLength
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld b, h
	ld c, l
	srl b
	rr c
	add hl, bc
	ld a, l
	ld [wCryLength], a
	ld a, h
	ld [wCryLength + 1], a
	farcall _PlayCryHeader
	jmp WaitSFX
