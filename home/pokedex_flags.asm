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

CountSetBits16::
; Count the number of set bits in bc bytes starting from hl - assumes bc < $1000
; Returns in bc; hl points to the end of the buffer; clobbers everything else
; Assumes that CountSetBits will leave hl pointing to the end of the buffer
	swap b
	ld a, c
	swap a
	and $f
	or b
	ld d, a
	ld a, c
	jr z, .small_count
	ld bc, 0
	and $f
	jr z, .loop
	push de
	call .small_count
	pop de
.loop
	push bc
	push de
	ld b, $10
	call CountSetBits
	pop de
	pop bc
	add a, c
	ld c, a
	jr nc, .handle_loop
	inc b
.handle_loop
	dec d
	jr nz, .loop
	ld a, b
	ld [wNumSetBits], a
	ld a, c
	ld [wNumSetBits+1], a
	ret

.small_count
	ld b, a
	call CountSetBits
	ld b, 0
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
	call GetPokedexNumber
	pop af
	ld b, a
	dec de
	call FlagAction
	ld a, c
	and a
	ret
