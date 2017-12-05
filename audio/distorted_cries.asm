PlaySlowCry: ; fb841
	ld a, [ScriptVar]
	call LoadCryHeader
	ret c

	ld hl, CryPitch
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld bc, -$140
	add hl, bc
	ld a, l
	ld [CryPitch], a
	ld a, h
	ld [CryPitch + 1], a
	ld hl, CryLength
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld bc, $60
	add hl, bc
	ld a, l
	ld [CryLength], a
	ld a, h
	ld [CryLength + 1], a
	farcall _PlayCryHeader
	jp WaitSFX
; fb877

; Low-pitched fainting cry routine from Pokémon TPP Anniversary Crystal 251
; https://github.com/TwitchPlaysPokemon/tppcrystal251pub/blob/public/main.asm
PlayFaintingCry:
	ld a, b
	call LoadCryHeader
	ret c
	ld hl, CryPitch
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld bc, -$38
	add hl, bc
	ld a, l
	ld [CryPitch], a
	ld a, h
	ld [CryPitch + 1], a
	ld hl, CryLength
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld bc, $18
	add hl, bc
	ld a, l
	ld [CryLength], a
	ld a, h
	ld [CryLength + 1], a
	ld a, 1
	ld [wStereoPanningMask], a
	farcall _PlayCryHeader
	jp WaitSFX
