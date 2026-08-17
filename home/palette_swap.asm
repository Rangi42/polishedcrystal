HandlePaletteSwap::
	call InitializeSwappedPalette
	homecall _CGB_ForceUpdateLayout
	ret

InitializeSwappedPalette::
	; wPaletteSwapAddress points to a `paletteswap` data struct inside
	; the current map script, so we must be in the [wMapScriptsBank].
	ldh a, [hROMBank]
	push af
	call SwitchToMapScriptsBank

	; If there are no active palette swap rectangles, just return.
	ld hl, wPaletteSwapAddress
	ld a, [hli]
	ld h, [hl]
	ld l, a
	or h
	jr nz, .loop

.done
	pop af
	rst Bankswitch
	ret

.loop
	; If there are no more palette swap rectangles, just return.
	call CheckPaletteSwapRectangle
	jr z, .done

	; If the current state in the carry flag differs from the previous state
	; in [wPaletteSwapFlag], then toggle the value of [wPaletteSwapFlag].
	; Both are 0/unset (outside) or 1/set (inside), so their sum is 0 or 2 if they match, and
	; 1 if they don't. So after summing them, `dec a` will yield `nz` if they match.
	ld de, wPaletteSwapFlag
	ld a, [de]
	adc 0
	dec a
	; Swap the palette even if we don't toggle, because CloseSubmenu
	; (e.g. from the Start menu) does not restore the non-default palette.
	; TODO: look into a more targeted fix for this.
	jr nz, .skip_toggle

	; Toggle the current [wPaletteSwapFlag] state.
	ld a, [de]
	xor 1
	ld [de], a

.skip_toggle
	; Get the BG palette ID in `b`.
	ld a, [hli]
	ld b, a

	; Get the palette list in `de`.
	; Advance `hl` past the two palettes.
	ld a, [de]
	ld c, a
	and a
	jr z, .get_palette
	; Skip the regular palette to get the swapped one.
	inc hl
	inc hl
.get_palette
	ld a, [hli]
	ld e, a
	ld a, [hli]
	ld d, a
	ld a, c
	and a
	jr nz, .got_palette
	; Skip the swapped palette if we already got the regular one.
	inc hl
	inc hl
.got_palette

	; Swap the palette in VRAM.
	push hl
	ld a, BANK(SwapColorPalette)
	rst Bankswitch
	call SwapColorPalette
	pop hl

	; Continue processing more than one `paletteswap` rectangle.
	call SwitchToMapScriptsBank
	jr .loop

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
