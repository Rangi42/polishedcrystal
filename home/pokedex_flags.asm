CountSetBits::
; Count the number of set bits in b bytes starting from hl.
; Return in a, c and [wNumSetBits].

	ld c, 0
.outer_loop
	ld a, [hli]
.zerocheck
	and a
	jr nz, .inner_loop
	dec b
	jr nz, .outer_loop
	ld a, c
	ld [wNumSetBits], a
	ret
.inner_loop
	add a
	jr nc, .inner_loop
	inc c
	jr .zerocheck

GetWeekday::
	ld a, [wCurDay]
.mod
	sub 7
	jr nc, .mod
	add 7
	ret

; Pokedex Flag Actions:
; Input: bc = form, species
SetSeenAndCaughtMon::
	push bc
	ld hl, wPokedexCaught
	call SetDexMon
	pop bc
	; fallthrough

SetSeenMon::
	ld hl, wPokedexSeen
SetDexMon::
	ld a, SET_FLAG
	jr PokedexFlagAction

CheckCaughtMon::
	ld hl, wPokedexCaught
	jr CheckDexMon

CheckSeenMon::
	ld hl, wPokedexSeen
CheckDexMon::
	ld a, CHECK_FLAG
	; fallthrough

PokedexFlagAction::
	push af
	push hl
	call GetCosmeticSpeciesAndFormIndex
	ld d, b
	ld e, c
	pop hl
	pop af
	ld b, a
	call FlagAction
	ld a, c
	and a
	ret
