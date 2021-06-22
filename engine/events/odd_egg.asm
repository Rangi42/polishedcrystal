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

	; Get random gender (50/50)
	call Random
	ldh a, [hRandom]
	cp $80
	ld a, FEMALE
	jr c, .got_gender
	assert !MALE
	xor a
.got_gender
	ld [wCurForm], a
	ld hl, OddEggs
	ld a, 10
	rst AddNTimes
	jr GiveSpecialEgg

GiveMystriEgg::
	ld hl, MystriEgg
; fallthrough
GiveSpecialEgg:
	ld de, wTempMonSpecies
	ld a, [hli]
	ld [de], a
	inc de
	xor a ; item
	ld [de], a
	inc de
	ld bc, NUM_MOVES
	rst CopyBytes
	call SwapHLDE
	xor a
	ld bc, MON_DVS - MON_ID
	rst ByteFill
	call SwapHLDE
	ld bc, 4 ; DVs, ability
	rst CopyBytes
	ld a, [wCurForm]
	or [hl]
	ld [de], a
	ld hl, wTempMonHappiness
	ld a, 20
	ld [hli], a
	xor a
rept MON_LEVEL - MON_PKRUS
	ld [hli], a
endr
	ld a, EGG_LEVEL
	ld [hl], a
	ld hl, wTempMonNickname
	ld de, .EggName
	call CopyName2
	ld hl, wTempMonOT
	ld de, .EggName
	call CopyName2
	ld hl, wTempMonExtra
	xor a
	ld [hli], a
	ld [hli], a
	ld [hl], a
	farcall SetTempPartyMonData
	farcall AddTempMonToParty
	jr c, .box
	ld a, 1
	jr .done

.box
	farcall NewStorageBoxPointer
	jr c, .failed
	ld a, c
	ld [wTempMonSlot], a
	ld a, b
	ld [wTempMonBox], a
	farcall UpdateStorageBoxMonFromTemp
	ld a, 2
	jr .done

.failed
	xor a
.done
	ldh [hScriptVar], a
	ret

.EggName:
	rawchar "Egg@"

INCLUDE "data/events/odd_eggs.asm"
