LoadFishingGFX:
	ldh a, [rVBK]
	push af
	xor a
	ldh [rVBK], a

	ld a, [wPlayerState]
	cp PLAYER_SURF
	ld hl, .FishingGFXTable
	jr nz, .got_table
	ld hl, .SurfFishingGFXTable
.got_table
	; de = [hl + [wPlayerGender] * 2]
	ld a, [wPlayerGender]
	add a
	add l
	ld l, a
	adc h
	sub l
	ld h, a
	ld a, [hli]
	ld d, [hl]
	ld e, a

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

.FishingGFXTable:
	dw ChrisFishingGFX ; far-ok
	dw KrisFishingGFX ; far-ok
	dw CrysFishingGFX ; far-ok

.SurfFishingGFXTable:
	dw ChrisSurfFishingGFX ; far-ok
	dw KrisSurfFishingGFX ; far-ok
	dw CrysSurfFishingGFX ; far-ok
