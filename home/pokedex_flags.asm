CountSetBits::
; Count the number of set bits in b bytes starting from hl.
; Return in a, c and [wNumSetBits].

	ld c, 0
.next
	ld a, [hli]
	ld e, a
	ld d, 8

.count
	srl e
	jr nc, .no_carry
	inc c
.no_carry

	dec d
	jr nz, .count

	dec b
	jr nz, .next

	ld a, c
	ld [wNumSetBits], a
	ret

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
