GiveOddEgg:
	ld a, 100
	call RandomRange
	ld hl, OddEggProbabilities
.loop
	cp [hl]
	inc hl
	jr nc, .loop
	ld a, LOW(OddEggProbabilities)
	sub l
	cpl
	ld hl, OddEggs
	ld bc, ODD_EGG_LENGTH
	rst AddNTimes

	; Get random gender
	call Random
	and GENDER_MASK
	ld [wCurForm], a
	jr GiveSpecialEgg

GiveMystriEgg::
	; Gender is specified in the egg struct
	xor a
	ld [wCurForm], a
	ld hl, MystriEgg
; fallthrough
GiveSpecialEgg:
	ld de, wTempMonSpecies
	ld a, [hli]
	ld [de], a
	inc de

	; form byte
	ld a, [wCurForm] ; gender is stored here
	or [hl]
	inc hl
	ld [wTempMonForm], a

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

	; DVs, first personality byte (form byte handled above)
	ld bc, 4
	rst CopyBytes

; Clear PP bytes
	xor a
	ld hl, wTempMonPP
rept NUM_MOVES - 1
	ld [hli], a
endr
	ld [hl], a

	ld hl, wTempMonEggCycles
	ld a, 20
	ld [hli], a
	xor a
rept MON_CAUGHTDATA - MON_PKRUS
	ld [hli], a
endr
	ld a, POKE_BALL
	ld [hli], a
	xor a
	ld [hli], a ; caught level
	ld [hli], a ; caught location
	assert EGG_LEVEL == 1
	inc a
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
