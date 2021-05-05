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

SetSeenAndCaughtMon::
	push bc
	ld hl, wPokedexCaught
	ld a, SET_FLAG
	call PokedexFlagAction
	pop bc
	; fallthrough

SetSeenMon::
	ld hl, wPokedexSeen
	ld a, SET_FLAG
	jr PokedexFlagAction

CheckCaughtMon::
	ld hl, wPokedexCaught
	ld a, CHECK_FLAG
	jr PokedexFlagAction

CheckSeenMon::
	ld hl, wPokedexSeen
	ld a, CHECK_FLAG
	; fallthrough

PokedexFlagAction::
	push af
	call GetPokedexNumber
	pop af
	ld d, b
	ld b, a
	ld e, c
	call FlagAction
	ld a, c
	and a
	ret
