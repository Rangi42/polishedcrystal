PlaySlowCry: ; fb841
	ld a, [wScriptVar]
	call LoadCryHeader
	ret c

	ld hl, wCryPitch
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld bc, -$140
	add hl, bc
	ld a, l
	ld [wCryPitch], a
	ld a, h
	ld [wCryPitch + 1], a
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
	jp WaitSFX
; fb877

; Low-pitched fainting cry routine from Pokémon TPP Anniversary Crystal 251
; https://github.com/TwitchPlaysPokemon/tppcrystal251pub/blob/public/main.asm
PlayFaintingCry:
	ld a, b
	call LoadCryHeader
	ret c
	ld hl, wCryPitch
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld bc, -$38
	add hl, bc
	jr nc, .ok
	ld hl, 0
.ok
	ld a, l
	ld [wCryPitch], a
	ld a, h
	ld [wCryPitch + 1], a
	ld hl, wCryLength
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld bc, $18
	add hl, bc
	ld a, l
	ld [wCryLength], a
	ld a, h
	ld [wCryLength + 1], a
	ld a, 1
	ld [wStereoPanningMask], a
	farcall _PlayCryHeader
	jp WaitSFX
