SpecialGiveShinyDitto:
; Adding to the party.
; Level 5 Ditto.
	ld hl, wTempMonNickname
	ld de, .Nickname
	call CopyName2
	ld de, wTempMonOT
	ld hl, .OTAndExtra
	ld bc, PLAYER_NAME_LENGTH + 3
	rst CopyBytes
	
	ld hl, wTempMonSpecies
	ld a, DITTO
	ld [hli], a
	ld [wCurPartySpecies], a
	ld [wCurSpecies], a
	call GetBaseData
	ld a, EVERSTONE
	ld [hli], a
	ld a, TRANSFORM
	ld [hli], a
	xor a
rept NUM_MOVES - 1
	ld [hli], a
endr
	ld a, [wPlayerID]
	add %01100101
	ld [hli], a
	ld a, [wPlayerID + 1]
	adc %10100110
	ld [hli], a
	ld d, 5
	push hl
	farcall CalcExpAtLevel
	pop hl
	ldh a, [hProduct + 1]
	ld [hli], a
	ldh a, [hProduct + 2]
	ld [hli], a
	ldh a, [hProduct + 3]
	ld [hli], a
	xor a
rept MON_DVS - MON_EVS
	ld [hli], a
endr
	ld a, $ff ; Max DVs
rept MON_PERSONALITY - MON_DVS
	ld [hli], a
endr
	ld a, SHINY_MASK | HIDDEN_ABILITY | QUIRKY
	ld [hli], a
	ld [hl], MALE
	ld hl, wTempMonHappiness
	ld a, BASE_HAPPINESS
	ld [hli], a
	xor a
	ld [hli], a
	lb bc, MALE, PREMIER_BALL
	farcall SetGiftMonCaughtData
	inc hl
	ld [hl], 5
	farcall SetTempPartyMonData
	farcall AddTempMonToParty
	jr c, .box
	ld a, 1
	jr .done

.box
	farcall NewStorageBoxPointer
	jr c, .NotGiven
	ld a, c
	ld [wTempMonSlot], a
	ld a, b
	ld [wTempMonBox], a
	ld a, [wCurPartySpecies]
	dec a
	call SetSeenAndCaughtMon
	farcall UpdateStorageBoxMonFromTemp
	ld a, 2
	jr .done

.NotGiven:
	xor a ; ld a, FALSE
.done
	ldh [hScriptVar], a
	ret

.OTAndExtra:
	rawchar "Mr.<PK><MN>@@@"
	db 0, 0, 0

.Nickname:
	rawchar "Masuda@"
