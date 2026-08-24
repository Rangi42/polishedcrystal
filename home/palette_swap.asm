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
	jr z, .no_palette_swaps

	ld a, CURR_PALSTATE
	ld [wPalState], a
	farcall CalculateStates
	ld c, 1 ; one state bit per palette swap entry (up to four)
	jr .loop

.no_palette_swaps
	pop af
	rst Bankswitch
	and a
	ret

.loop
	push bc
	; If there are no more palette swap rectangles, just return.
	call CheckPaletteSwapRectangle
	jr z, .done_loop
	ld c, 0
	jr nc, .got_current_state
	inc c
.got_current_state

	; Preserve this entry's state bit across palette loading. `c` returns bit 0
	; set inside the rectangle and bit 7 set if this entry changed.
	pop de
	farcall UpdatePaletteSwapState
	push de

	; Get the BG palette ID in `b`.
	ld a, [hli]
	ld b, a

	; Get the palette list in `de`.
	; Advance `hl` past the two palettes.
	bit 0, c
	jr z, .get_palette
	; Skip the regular palette to get the swapped one.
	inc hl
	inc hl
.get_palette
	ld a, [hli]
	ld e, a
	ld a, [hli]
	ld d, a
	bit 0, c
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

	farcall CheckPaletteFading
	jr z, .swap_current
	bit 7, c
	jr z, .swap_current

	; Rebuild this palette under the fade's previous conditions, then catch it
	; up to the current fade step toward the same palette's current conditions.
	push bc
	push de
	ld a, [wPalWhiteState]
	and a
	jr z, .swap_previous
	ld hl, wBGPals2
	ld a, b
	ld bc, 1 palettes
	rst AddNTimes
	ld d, h
	ld e, l
	farcall CopyWhitePal
	jr .got_previous

.swap_previous
	xor a
	assert PREV_PALSTATE == 0
	ld [wPalState], a
	ld a, BANK(SwapColorPalette)
	rst Bankswitch
	call SwapColorPalette

.got_previous
	pop de
	pop bc
	ld a, CURR_PALSTATE
	ld [wPalState], a
	ld a, BANK(SwapColorPalette)
	rst Bankswitch
	push bc
	call SwapColorPalette
	pop bc
	ld a, b
	farcall CatchUpBGPaletteFade
	jr .swapped

.swap_current
	ld a, BANK(SwapColorPalette)
	rst Bankswitch
	call SwapColorPalette

.swapped
	pop hl

	; Continue processing more than one `paletteswap` rectangle.
	call SwitchToMapScriptsBank
	pop bc
	sla c
	jr .loop

.done_loop
	pop bc
.done
	; Return carry when there were some `paletteswap` rectangles.
	pop af
	rst Bankswitch
	scf
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
