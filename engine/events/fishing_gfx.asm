LoadFishingGFX:
	ldh a, [rVBK]
	push af
	xor a
	ldh [rVBK], a

	ld a, [wPlayerState]
	cp PLAYER_SURF
	jr z, .surfing

	ld de, FishingGFX
	ld a, [wPlayerGender]
	bit 0, a
	jr z, .got_gender
	ld de, KrisFishingGFX
	jr .got_gender
.surfing

	ld de, SurfFishingGFX
	ld a, [wPlayerGender]
	bit 0, a
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
	lb bc, BANK(FishingGFX), 2
	push de
	call Get2bpp
	pop de
	ld hl, 2 tiles
	add hl, de
	ld d, h
	ld e, l
	ret

FishingGFX:
INCBIN "gfx/overworld/chris_fish.2bpp"

KrisFishingGFX:
INCBIN "gfx/overworld/kris_fish.2bpp"

SurfFishingGFX:
INCBIN "gfx/overworld/chris_surf_fish.2bpp"

KrisSurfFishingGFX:
INCBIN "gfx/overworld/kris_surf_fish.2bpp"
