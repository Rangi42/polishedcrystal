GiveOddEgg:
	; Compare a random word to
	; probabilities out of 0xffff.
	call Random
	ld hl, OddEggProbabilities
	ld c, 0
	ld b, c
.loop
	ld a, [hli]
	ld e, a
	ld a, [hli]
	ld d, a
	; Break on $ffff.
	cp HIGH($ffff)
	jr nz, .not_done
	ld a, e
	cp LOW($ffff)
	jr z, .done
.not_done

	; Break when [hRandom] <= de.
	ldh a, [hRandom + 1]
	cp d
	jr c, .done
	jr nz, .next

	ldh a, [hRandom + 0]
	cp e
	jr c, .done
	jr z, .done
.next
	inc bc
	jr .loop
.done

	ld hl, OddEggs
	ld a, OddEgg2 - OddEgg1
	rst AddNTimes
	jr GiveEggMon

GiveMystriEgg::
	ld hl, MystriEgg
; fallthrough
GiveEggMon:
	ld de, wOddEggSpecies
	ld bc, PARTYMON_STRUCT_LENGTH + 2 * MON_NAME_LENGTH
	rst CopyBytes
; fallthrough
AddEggMonToParty:
	ld hl, wPartyCount
	ld a, [hl]
	ld e, a
	inc [hl]

	ld bc, wPartySpecies
	ld d, e
.loop1
	inc bc
	dec d
	jr nz, .loop1
	ld a, e
	ld [wCurPartyMon], a
	ld [bc], a
	inc bc
	ld a, -1
	ld [bc], a

	ld hl, wPartyMon1Species
	ld bc, PARTYMON_STRUCT_LENGTH
	ld a, e
	ld [wTempPartyCount], a
.loop2
	add hl, bc
	dec a
	and a
	jr nz, .loop2
	ld e, l
	ld d, h
	ld hl, wOddEggSpecies
	ld bc, PARTYMON_STRUCT_LENGTH
	rst CopyBytes

	ld hl, wPartyMonOT
	ld bc, NAME_LENGTH
	ld a, [wTempPartyCount]
.loop3
	add hl, bc
	dec a
	and a
	jr nz, .loop3
	ld e, l
	ld d, h
	ld hl, wOddEggName
	ld bc, MON_NAME_LENGTH - 1
	rst CopyBytes
	ld a, "@"
	ld [de], a

	ld hl, wPartyMonNicknames
	ld bc, MON_NAME_LENGTH
	ld a, [wTempPartyCount]
.loop4
	add hl, bc
	dec a
	and a
	jr nz, .loop4
	ld e, l
	ld d, h
	ld hl, wOddEggName
	ld bc, MON_NAME_LENGTH - 1
	rst CopyBytes
	ld a, "@"
	ld [de], a

	jp CloseSRAM

INCLUDE "data/events/odd_eggs.asm"
