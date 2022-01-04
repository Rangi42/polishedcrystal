Pokedex_Unown:
	ld a, DEXDISP_UNOWN
	ld [wPokedex_DisplayMode], a
	xor a
	ld [wPokedex_UnownCursor], a
	ld hl, UnownModePals
	ld de, wBGPals1 palette 2
	ld bc, 2 palettes
	ld a, BANK(UnownModePals)
	call FarCopyBytesToColorWRAM

	ld hl, DexTilemap_Unown
	call Pokedex_LoadTilemapWithPokepic
	ld a, -1
	call Pokedex_ScheduleScreenUpdateWithHBlank
	call Pokedex_GetInput
	ld c, 240
	call DelayFrames
	jmp Pokedex_Mode_ReloadPals
	ret

Pokedex_LoadUnownPic:
; GetCursorMon does a lot of stuff we don't want, hence we use this instead.
	call Pokedex_SwitchMonInfoBank
	
	ld a, [wPokedex_MonInfoBank]
	xor 1
	ld [wPokedex_MonInfoBank], a
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
