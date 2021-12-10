PlaySlowCry:
	ldh a, [hScriptVar]
	ld c, a
	ldh a, [hScriptVar+1]
	ld b, a
PlaySlowCryBC:
	call LoadCryHeader
	ret c

	; TODO: handle cry pitch better
;	ld hl, wCryPitch
;	ld a, [hli]
;	ld h, [hl]
;	ld l, a
;	ld bc, -$140
;	add hl, bc
;	ld a, l
;	ld [wCryPitch], a
;	ld a, h
;	ld [wCryPitch + 1], a
	ld hl, wCryLength
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld bc, $60
	add hl, bc
	ld a, l
	ld [wCryLength], a
	ld a, h
	ld [wCryLength + 1], a
	farcall _PlayCryHeader
	jmp WaitSFX
