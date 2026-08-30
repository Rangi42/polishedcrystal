HandlePaletteSwap::
	ld a, [wPlayerStepFlags]
	bit PLAYERSTEP_STOP_F, a
	jr nz, .update
	farcall CheckPaletteFading
	ret nz
.update
	call InitializeSwappedPalette
	ret nc
	; A fading swap has already caught up its own slot, so do not overwrite all
	; active palettes with their destinations.
	homecall ApplyPalsIfNotFading
	ret

InitializeSwappedPalette::
	; wPaletteSwapAddress points to a `paletteswap` data struct inside
	; the current map script, so we must be in the [wMapScriptsBank].
	ldh a, [hROMBank]
	push af
	call SwitchToMapScriptsBank

	; If there are no active palette swap rectangles, return nc.
	ld hl, wPaletteSwapAddress
	ld a, [hli]
	ld h, [hl]
	ld l, a
	or h
	jr nz, .has_palette_swaps
	pop af
	rst Bankswitch
	and a
	ret

.has_palette_swaps
	push hl
	ld a, CURR_PALSTATE
	ld [wPalState], a
	farcall CalculateStates
	lb de, 0, PALETTE_SWAP_INSIDE ; d: changed BG palettes, e: entry state bit

.state_loop
	; First update every entry's state and collect its destination palette.
	; This must finish before loading palettes: a later NULL entry can leave an
	; earlier entry for the same slot as the final effective palette.
	call CheckPaletteSwapRectangle
	jr z, .states_done
	sbc a
	and PALETTE_SWAP_INSIDE
	ld c, a

	; Preserve the accumulated palette mask around the farcall. `c` returns
	; PALETTE_SWAP_INSIDE_F set inside the rectangle and
	; PALETTE_SWAP_CHANGED_F set if this entry changed.
	push de
	farcall UpdatePaletteSwapState
	pop de

	ld a, [hli]
	ld b, a
	bit PALETTE_SWAP_CHANGED_F, c
	jr z, .state_updated
	call GetPaletteMask
	or d
	ld d, a

.state_updated
	; Skip the outside and inside palette pointers.
	ld bc, 4
	add hl, bc
	sla e
	jr .state_loop

.states_done
	; A changed palette only needs catch-up during an active fade.
	ld a, d
	and a
	jr z, .load_palettes
	farcall CheckPaletteFading
	jr nz, .load_palettes
	ld d, a ; a == 0

.load_palettes
	pop hl

.palette_loop
	call CheckPaletteSwapRectangle
	jr z, .done
	sbc a
	and PALETTE_SWAP_INSIDE
	ld c, a

	; Get the BG palette ID in `b`, and mark the slot if any entry targeting it
	; changed. This makes chained swaps resolve to their final effective palette.
	ld a, [hli]
	ld b, a
	ld a, d
	and a
	jr z, .got_changed_state
	call GetPaletteMask
	and d
	jr z, .got_changed_state
	set PALETTE_SWAP_CHANGED_F, c
.got_changed_state
	push de

	; Get the palette list in `de`.
	; Advance `hl` past the two palettes.
	bit PALETTE_SWAP_INSIDE_F, c
	jr z, .get_palette
	; Skip the regular palette to get the swapped one.
	inc hl
	inc hl
.get_palette
	ld a, [hli]
	ld e, a
	ld a, [hli]
	ld d, a
	bit PALETTE_SWAP_INSIDE_F, c
	jr nz, .got_palette
	; Skip the swapped palette if we already got the regular one.
	inc hl
	inc hl
.got_palette
	push hl
	; A NULL palette leaves an earlier swap for the same slot intact.
	ld a, d
	or e
	jr z, .swapped

	bit PALETTE_SWAP_CHANGED_F, c
	jr z, .swap_current

	farcall CatchUpPaletteSwapFade
	jr .swapped

.swap_current
	; Always reload the selected palette: CloseSubmenu does not restore
	; non-default palettes, even when this entry's state has not changed.
	; TODO: look into a more targeted fix for this.
	ld a, BANK(SwapColorPalette)
	rst Bankswitch
	call SwapColorPalette

.swapped
	pop hl
	pop de

	; Continue processing more than one `paletteswap` rectangle.
	call SwitchToMapScriptsBank
	jr .palette_loop

.done
	; Return carry when there were some `paletteswap` rectangles.
	pop af
	rst Bankswitch
	scf
	ret

GetPaletteMask:
; Return `a` = 1 << `b` given BG palette ID `b`, preserving `bc`.
	push bc
	ld a, $80
	inc b
.mask_loop
	rlca
	dec b
	jr nz, .mask_loop
	pop bc
	ret

CheckPaletteSwapRectangle:
; Input: `hl` points to the next palette swap rectangle.
; Return `z` if there's a terminator -1 byte.
; Return `nz` and `c` if we are inside the rectangle.
; Return `nz` and `nc` if we are outside the rectangle.
; If there is an active palette swap rectangle, return `hl` advanced past the
; Min/Max X/Y coords and pointing to the BG palette ID byte.

	; If there's a terminator -1 byte, we're done.
	ld a, [hl]
	inc a
	ret z

	; The `paletteswap` MinX/Y coords are *inside* the rectangle, and the MaxX/Y
	; coords are *outside* the rectangle. This is convenient for `cp` testing.
	; It also allows the rectangle to start at minimal (0, 0).
	ld a, [wXCoord]
	cp [hl] ; MinX
	inc hl
	jr c, .outside3 ; X < MinX
	cp [hl] ; MaxX
	inc hl
	jr nc, .outside2 ; X >= MaxX
	ld a, [wYCoord]
	cp [hl] ; MinY
	inc hl
	jr c, .outside1 ; Y < MinY
	cp [hl] ; MaxY
	inc hl
	jr nc, .outside0 ; Y >= MaxY

	; We are inside the rectangle, so return `nz` and `c`.
	; We just did `cp [hl]` to test `[wXCoord] - MaxY`, so we know the flags are
	; `nz` (they are not equal) and `c` ([wXCoord] < MaxY), which is returnable.
	ret

.outside3
	inc hl ; skip MaxX
.outside2
	inc hl ; skip MinY
.outside1
	inc hl ; skip MaxY
.outside0
	ld a, 1
	and a ; nz and nc
	ret
