Pokedex_Unown:
	ld a, DEXDISP_UNOWN
	ld [wPokedex_DisplayMode], a
	xor a
	ld [wPokedex_UnownCursor], a
	ld hl, UnownModePals
	ld de, wBGPals1 palette 2
	ld c, 2 palettes
	farcall LoadCPaletteBytesFromHLIntoDE

	ld hl, DexTilemap_Unown
	call Pokedex_LoadTilemapWithPokepic
	jmp Pokedex_Mode_ReloadPals
	ret

PrintUnownWord:
	hlcoord 4, 15
	ld bc, 12
	ld a, " "
	rst ByteFill
	ld a, [wDexCurUnownIndex]
	ld e, a
	ld d, 0
	ld hl, wUnownDex
	add hl, de
	ld a, [hl]
	ld e, a
	ld d, 0
	ld hl, UnownWords
	add hl, de
	add hl, de
	ld a, [hli]
	ld e, a
	ld d, [hl]
	hlcoord 4, 15
.loop
	ld a, [de]
	cp "@"
	ret z
	inc de
	ld [hli], a
	jr .loop

INCLUDE "data/pokemon/unown_words.asm"

UnownModePals:
INCLUDE "gfx/pokedex/unown.pal"
