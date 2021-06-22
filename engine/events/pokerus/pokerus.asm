GivePokerusAndConvertBerries:
	call ConvertBerriesToBerryJuice
	ld hl, wPartyMon1PokerusStatus
	ld a, [wPartyCount]
	ld b, a
	ld de, PARTYMON_STRUCT_LENGTH
; Check to see if any of your Pokemon already has Pokerus.
; If so, sample its spread through your party.
; This means that you cannot get Pokerus de novo while
; a party member has an active infection.
.loopMons
	ld a, [hl]
	and $f
	jr nz, TrySpreadPokerus
	add hl, de
	dec b
	jr nz, .loopMons

; If we haven't been to Goldenrod City at least once,
; prevent the contraction of Pokerus.
	ld hl, wStatusFlags2
	bit 6, [hl] ; ENGINE_REACHED_GOLDENROD
	ret z
	call Random
	ldh a, [hRandomAdd]
	and a
	ret nz
	ldh a, [hRandomSub]
	cp $3
	ret nc                 ; 3/65536 chance (00 00, 00 01 or 00 02)
	ld a, [wPartyCount]
	ld b, a
.randomMonSelectLoop
	call Random
	and $7
	cp b
	jr nc, .randomMonSelectLoop
ContinueGivingPokerus:
	ld hl, wPartyMon1PokerusStatus
	call GetPartyLocation  ; get pokerus byte of random mon
	ld a, [hl]
	and $f0
	ret nz                 ; if it already has pokerus, do nothing
.randomPokerusLoop         ; Simultaneously sample the strain and duration
	call Random
	and a
	jr z, .randomPokerusLoop
	ld b, a
	and $f0
	jr z, .load_pkrs
	ld a, b
	and $7
	inc a
	ld b, a
.load_pkrs
	swap b
	and $3
	inc a
	add b
	ld [hl], a
	ret

GivePokerusToWonderTradeMon:
	call Random
	ldh a, [hRandomAdd]
	and a
	ret nz
	ldh a, [hRandomSub]
	cp $20
	ret nc                 ; 32/65536 = 1/2048 chance
	ld a, [wCurPartyMon]
	ld b, a
	jr ContinueGivingPokerus

TrySpreadPokerus:
	call Random
	cp 1 + 33 percent
	ret nc              ; 1/3 chance

	ld a, [wPartyCount]
	cp 1
	ret z               ; only one mon, nothing to do

	ld c, [hl]
	ld a, b
	cp 2
	jr c, .checkPreviousMonsLoop    ; no more mons after this one, go backwards

	call Random
	cp 1 + 50 percent
	jr c, .checkPreviousMonsLoop    ; 1/2 chance, go backwards
.checkFollowingMonsLoop
	add hl, de
	ld a, [hl]
	and a
	jr z, .infectMon
	ld c, a
	and $3
	ret z               ; if mon has cured pokerus, stop searching
	dec b               ; go on to next mon
	ld a, b
	cp 1
	jr nz, .checkFollowingMonsLoop ; no more mons left
	ret

.checkPreviousMonsLoop
	ld a, [wPartyCount]
	cp b
	ret z               ; no more mons
	ld a, l
	sub e
	ld l, a
	ld a, h
	sbc d
	ld h, a
	ld a, [hl]
	and a
	jr z, .infectMon
	ld c, a
	and $3
	ret z               ; if mon has cured pokerus, stop searching
	inc b               ; go on to next mon
	jr .checkPreviousMonsLoop

.infectMon
	ld a, c
	and $f0
	ld b, a
	ld a, c
	swap a
	and $3
	inc a
	add b
	ld [hl], a
	ret

ApplyPokerusTick:
; decreases all pokemon's pokerus counter by b. if the lower nybble reaches zero, the pokerus is cured.
	ld hl, wPartyMon1PokerusStatus ; PartyMon1 + MON_PKRS
	ld a, [wPartyCount]
	and a
	ret z ; make sure it's not wasting time on an empty party
	ld c, a
.loop
	ld a, [hl]
	and $f ; lower nybble is the number of days remaining
	jr z, .next ; if already 0, skip
	sub b ; subtract the number of days
	jr nc, .ok ; max(result, 0)
	xor a
.ok
	ld d, a ; back up this value because we need to preserve the strain (upper nybble)
	ld a, [hl]
	and $f0
	add d
	ld [hl], a ; this prevents a cured pokemon from recontracting pokerus
.next
	ld de, PARTYMON_STRUCT_LENGTH
	add hl, de
	dec c
	jr nz, .loop
	ret

ConvertBerriesToBerryJuice:
; If we haven't been to Goldenrod City at least once,
; prevent Shuckle from turning held Berry into Berry Juice.
	ld hl, wStatusFlags2
	bit 6, [hl]
	ret z
	call Random
	cp 6 percent + 1 ; 1/16 chance
	ret nc
	ld hl, wPartyMons
	ld a, [wPartyCount]
.partyMonLoop
	push af
	push hl
	ld a, [hl]
	cp SHUCKLE
	jr nz, .loopMon
	ld bc, MON_ITEM
	add hl, bc
	ld a, [hl]
	cp ORAN_BERRY
	jr z, .convertToJuice

.loopMon
	pop hl
	ld bc, PARTYMON_STRUCT_LENGTH
	add hl, bc
	pop af
	dec a
	jr nz, .partyMonLoop
	ret

.convertToJuice
	ld [hl], BERRY_JUICE
	pop hl
	pop af
	ret
