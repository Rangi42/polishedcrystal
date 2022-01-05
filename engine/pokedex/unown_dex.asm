Pokedex_Unown:
	ld a, DEXDISP_UNOWN
	ld [wPokedex_DisplayMode], a

	; Reset the cursor for Unown Mode.
	xor a
	ld [wPokedex_UnownCursor], a

	; Writes interface palettes. Pokepic is handled seperately.
	ld hl, UnownModePals
	ld de, wBGPals1 palette 2
	ld bc, 2 palettes
	ld a, BANK(UnownModePals)
	call FarCopyBytesToColorWRAM
	; fallthrough
_Pokedex_Unown:
	; Load current unown pic.
	call Pokedex_LoadUnownPic
	push af
	ld hl, DexTilemap_Unown
	call Pokedex_LoadTilemapWithPokepic
	pop af
	ld a, -1
	call Pokedex_ScheduleScreenUpdateWithHBlank
	call Pokedex_GetInput
	ld c, 240
	call DelayFrames
	jmp Pokedex_Mode_ReloadPals
	ret

Pokedex_LoadUnownPic:
; Returns z if the Unown form we are hovering isn't captured.
	; Cycle pokepic VRAM. Pointless on initial setup, but necessary after.
	call Pokedex_SwitchMonInfoBank

	; Get relevant Unown.
	call Pokedex_GetUnownCursorForm

	; Have we captured this Unown?
	push bc
	call CheckCaughtMon
	pop bc
	jmp z, Pokedex_LoadUndiscoveredPokepic

	; We've captured it. Load the relevant pokepic and pal.
	; Load pokepic.
	ld a, b
	ld [wCurForm], a
	ld [wPokedex_Form], a
	ld a, c
	ld [wCurPartySpecies], a
	call GetBaseData
	farcall PrepareFrontpic

	; Schedule a write of frontpic in VBlank.
	ld hl, wPokedex_GFXFlags
	set DEXGFX_FRONTPIC, [hl]

	; Load palette.
	ld bc, wPokedex_Personality
	ld a, [wCurPartySpecies]
	farcall GetMonNormalOrShinyPalettePointer
	ld de, wBGPals1 palette 6 + 2
	ld a, BANK(PokemonPalettes)
	ld bc, 4
	call FarCopyBytesToColorWRAM

	; Return nz, to signify that we have caught this Unown.
	or 1
	ret

Pokedex_GetUnownCursorForm:
; Returns given Unown form in bc from what the cursor is hovering.
	ld a, [wPokedex_UnownCursor]
	ld c, a

	; Unown form is (vertical pos * 7 + horizontal pos + 1)
	; Horizontal position
	and %111
	ld b, a

	; Vertical position
	ld a, c
	rrca
	rrca
	rrca
	and %11
	ld c, a

	; Multiply vertical position by 7
	ld a, 7
	call SimpleMultiply

	; Add horizontal position
	add b

	; Formes are 1-indexed
	inc a

	; Now we have the form.
	assert !HIGH(UNOWN)
	ld b, a
	ld c, LOW(UNOWN)
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
