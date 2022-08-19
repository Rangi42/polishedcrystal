LoadFishingGFX:
	ldh a, [rVBK]
	push af
	xor a
	ldh [rVBK], a

	ld hl, wPlayerGender
	ld a, [wPlayerState]
	cp PLAYER_SURF
	jr z, .surfing

	ld de, ChrisFishingGFX
	bit 0, [hl]
	jr z, .got_gender
	ld de, KrisFishingGFX
	jr .got_gender

.surfing
	ld de, ChrisSurfFishingGFX
	bit 0, [hl]
	jr z, .got_gender
	ld de, KrisSurfFishingGFX

.got_gender
	ld hl, vTiles0 tile $02
	call .LoadGFX
	ld hl, vTiles0 tile $06
	call .LoadGFX
	ld hl, vTiles0 tile $0a
	call .LoadGFX

	pop af
	ldh [rVBK], a
	ret

.LoadGFX:
	lb bc, BANK("Fishing Graphics"), 2
	push de
	call Get2bpp
	pop de
	ld hl, 2 tiles
	add hl, de
	ld d, h
	ld e, l
	ret
