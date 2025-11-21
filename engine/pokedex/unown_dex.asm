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

	call ClearSpriteAnims
	lb de, $5c, $24
	ld a, SPRITE_ANIM_INDEX_DEX_UNOWN_CURSOR
	call InitSpriteAnimStruct

	; fallthrough
_Pokedex_Unown:
	; Load current unown pic.
	call Pokedex_LoadUnownPic
	push af
	ld hl, DexTilemap_Unown
	call Pokedex_LoadTilemapWithPokepic

	; If we have caught the current Unown, we want to
	; display the relevant letter and a word alongside.
	; If not, we want to replace "UNOWN" with whitespace.
	pop af
	jr z, .not_caught

	; Since Unown forms are 1-indexed, load table from UnownWords-1.
	call Pokedex_GetUnownCursorForm
	ld a, b
	push af
	ld e, a
	ld d, 0
	ld hl, UnownWords - 1
	add hl, de
	ld e, [hl]
	add hl, de
	ld e, l
	ld d, h
	hlcoord 10, 5
	rst PlaceString
	pop af
	call Pokedex_GetPrintableUnownChar

	hlcoord 16, 3
	ld [hl], a
	jr .current_done

.not_caught
	; Remove "UNOWN"
	hlcoord 10, 3
	ld a, ' '
	ld bc, 5
	rst ByteFill

.current_done
	; Print a table of Unown characters for all forms we've caught.
	hlcoord 4, 10
	lb bc, UNOWN_A_FORM, LOW(UNOWN)
	ld d, 4
.outer_loop
	ld e, 7
.inner_loop
	; Check if this form is captured.
	push hl
	push de
	push bc
	call CheckCaughtMon
	pop bc
	pop de
	pop hl
	jr z, .next

	; Print character
	ld a, b
	call Pokedex_GetPrintableUnownChar
	ld [hl], a
.next
	inc b
	inc hl
	inc hl
	dec e
	jr nz, .inner_loop
	push bc
	; 2x(screen) - unown chars per line * 2
	ld bc, 2 * SCREEN_WIDTH - 7 * 2
	add hl, bc
	pop bc
	dec d
	jr nz, .outer_loop

	ld a, -1
	call Pokedex_ScheduleScreenUpdateWithHBlank
.joypad_loop
	call Pokedex_GetInput
	rrca ; ignore A press
	rrca
	jr c, .pressed_b
	rrca
	jr c, .pressed_select
	rrca ; ignore start
	rrca
	jr c, .pressed_right
	rrca
	jr c, .pressed_left
	rrca
	jr c, .pressed_up
	rrca
	jr c, .pressed_down
	jr .joypad_loop

.pressed_b
	call ClearSpriteAnims
	jmp Pokedex_Mode_ReloadPals

.pressed_select
	call Pokedex_SwitchNormalOrShinyPalette
	call Pokedex_ScheduleScreenUpdate
	jr .joypad_loop

.pressed_right
	ld b, 1
	jr .move_cursor
.pressed_left
	ld b, 7
	jr .move_cursor
.pressed_up
	ld b, $30
	jr .move_cursor
.pressed_down
	ld b, $10
.move_cursor
	ld a, [wPokedex_UnownCursor]
	add b
	and $37
	ld [wPokedex_UnownCursor], a

	; There's 7 columns, not 8.
	maskbits $7
	cp $7
	jr z, .move_cursor
	jmp _Pokedex_Unown

Pokedex_GetPrintableUnownChar:
; Convert unown form in a to printable character.
	add 'A' - 1

	cp (UNOWN_Z_FORM + 1) + ('A' - 1)
	ret c

	assert UNOWN_Z_FORM + 1 == UNOWN_EXCLAMATION_FORM
	ld a, '!'
	ret z

	assert '!' - 1 == '?'
	dec a
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
	swap a
	and %11
	ld c, a

	; Multiply vertical position by 7
	ld a, 7
	call SimpleMultiply

	; Add horizontal position
	add b

	; Forms are 1-indexed
	inc a

	; Now we have the form.
	assert !HIGH(UNOWN)
	ld b, a
	ld c, LOW(UNOWN)
	ret

INCLUDE "data/pokemon/unown_words.asm"

UnownModePals:
INCLUDE "gfx/pokedex/unown.pal"
