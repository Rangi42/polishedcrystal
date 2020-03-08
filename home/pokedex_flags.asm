CountSetBits:: ; 0x335f
; Count the number of set bits in b bytes starting from hl.
; Return in a, c and [wd265].

	ld c, 0
.next
	ld a, [hli]
	ld e, a
	ld d, 8

.count
	srl e
	ld a, 0 ; not xor a; preserve carry flag?
	adc c
	ld c, a
	dec d
	jr nz, .count

	dec b
	jr nz, .next

	ld a, c
	ld [wd265], a
	ret
; 0x3376

GetWeekday:: ; 3376
	ld a, [wCurDay]
.mod
	sub 7
	jr nc, .mod
	add 7
	ret
; 3380

SetSeenAndCaughtMon:: ; 3380
	push af
	ld c, a
	ld hl, wPokedexCaught
	ld b, SET_FLAG
	call PokedexFlagAction
	pop af
	; fallthrough
; 338b

SetSeenMon:: ; 338b
	ld c, a
	ld hl, wPokedexSeen
	ld b, SET_FLAG
	jr PokedexFlagAction
; 3393

CheckCaughtMon:: ; 3393
	ld c, a
	ld hl, wPokedexCaught
	ld b, CHECK_FLAG
	jr PokedexFlagAction
; 339b

CheckSeenMon:: ; 339b
	ld c, a
	ld hl, wPokedexSeen
	ld b, CHECK_FLAG
	; fallthrough
; 33a1

PokedexFlagAction:: ; 33a1
	ld d, 0
	predef FlagPredef
	ld a, c
	and a
	ret
; 33ab
