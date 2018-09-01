SpecialGiveShinyDitto:

; Adding to the party.
	xor a
	ld [MonType], a

; Level 5 Ditto.
	ld a, DITTO
	ld [CurPartySpecies], a
	ld a, 5
	ld [CurPartyLevel], a

	predef TryAddMonToParty
	jr nc, .NotGiven

; Caught data.
	lb bc, MALE, PREMIER_BALL
	farcall SetGiftPartyMonCaughtData

; Holding an Everstone for breeding natures.
	ld hl, PartyMon1Item
	call _GetLastPartyMonAttribute
	ld [hl], EVERSTONE

; OT ID. Guaranteed to not be the same as the player's for Masuda method breeding.
	ld hl, PartyMon1ID + 1
	call _GetLastPartyMonAttribute
	ld a, [PlayerID + 1]
	add %01100101
	ld [hld], a
	ld a, [PlayerID]
	adc %10100110
	ld [hl], a

; DVs and personality.
	ld hl, PartyMon1DVs
	call _GetLastPartyMonAttribute
; Max IVs.
rept 3
	ld a, $ff
	ld [hli], a
endr
; Shiny with hidden ability.
	ld a, SHINY_MASK | HIDDEN_ABILITY | QUIRKY
	ld [hli], a
	ld a, MALE
	ld [hl], a

; Recalculate stats after changing DVs and Nature
	ld hl, PartyMon1MaxHP
	call _GetLastPartyMonAttribute
	ld d, h
	ld e, l
	ld hl, PartyMon1EVs - 1
	call _GetLastPartyMonAttribute
	ld b, TRUE
	predef CalcPkmnStats

; Nickname.
	ld a, [PartyCount]
	dec a
	ld hl, PartyMonNicknames
	call SkipNames
	ld de, .Nickname
	call CopyName2

; OT.
	ld a, [PartyCount]
	dec a
	ld hl, PartyMonOT
	call SkipNames
	ld de, .OT
	call CopyName2

	ld a, TRUE
	ld [ScriptVar], a
	ret

.NotGiven:
	xor a ; ld a, FALSE
	ld [ScriptVar], a
	ret

.OT:
	db "Mr.<PK><MN>@"
.Nickname:
	db "Masuda@"

KIRK_BUFFY_ID EQU 00518

SpecialGiveWobbuffet: ; 7305

; Adding to the party.
	xor a
	ld [MonType], a

; Level 20 Wobbuffet.
	ld a, WOBBUFFET
	ld [CurPartySpecies], a
	ld a, 20
	ld [CurPartyLevel], a

	predef TryAddMonToParty
	jr nc, .NotGiven

; Caught data.
	lb bc, MALE, DUSK_BALL
	farcall SetGiftPartyMonCaughtData

; Holding a Berry.
	ld hl, PartyMon1Item
	call _GetLastPartyMonAttribute
	ld [hl], SITRUS_BERRY

; OT ID.
	ld hl, PartyMon1ID
	call _GetLastPartyMonAttribute
	ld a, KIRK_BUFFY_ID / $100
	ld [hli], a
	ld [hl], KIRK_BUFFY_ID % $100

; Nickname.
	ld a, [PartyCount]
	dec a
	ld hl, PartyMonNicknames
	call SkipNames
	ld de, SpecialWobbuffetNick
	call CopyName2

; OT.
	ld a, [PartyCount]
	dec a
	ld hl, PartyMonOT
	call SkipNames
	ld de, SpecialWobbuffetOT
	call CopyName2

; Engine flag for this event.
	ld hl, DailyFlags
	set 5, [hl] ; ENGINE_WOBBUFFET_GIVEN
	ld a, TRUE
	ld [ScriptVar], a
	ret

.NotGiven:
	xor a ; ld a, FALSE
	ld [ScriptVar], a
	ret

_GetLastPartyMonAttribute:
	ld a, [PartyCount]
	dec a
	ld bc, PARTYMON_STRUCT_LENGTH
	jp AddNTimes

SpecialReturnWobbuffet: ; 737e
	farcall SelectMonFromParty
	jr c, .refused

	ld a, [CurPartySpecies]
	cp WOBBUFFET
	jr nz, .DontReturn

	ld a, [CurPartyMon]
	ld hl, PartyMon1ID
	ld bc, PARTYMON_STRUCT_LENGTH
	call AddNTimes

; OT ID
	ld a, [hli]
	cp KIRK_BUFFY_ID / $100
	jr nz, .DontReturn
	ld a, [hl]
	cp KIRK_BUFFY_ID % $100
	jr nz, .DontReturn

; OT
	ld a, [CurPartyMon]
	ld hl, PartyMonOT
	call SkipNames
	ld de, SpecialWobbuffetOT
.CheckOT:
	ld a, [de]
	cp [hl]
	jr nz, .DontReturn
	cp "@"
	jr z, .done
	inc de
	inc hl
	jr .CheckOT

.done
	farcall CheckCurPartyMonFainted
	jr c, .fainted
	ld a, [CurPartyMon]
	ld hl, PartyMon1Happiness
	ld bc, PARTYMON_STRUCT_LENGTH
	call AddNTimes
	ld a, [hl]
	cp 150
	ld a, $3
	jr nc, .HappyToStayWithYou
	xor a ; take from pc
	ld [wPokemonWithdrawDepositParameter], a
	farcall RemoveMonFromPartyOrBox
	ld a, $2
.HappyToStayWithYou:
	ld [ScriptVar], a
	ret

.refused
	ld a, $1
	ld [ScriptVar], a
	ret

.DontReturn:
	xor a
	ld [ScriptVar], a
	ret

.fainted
	ld a, $4
	ld [ScriptVar], a
	ret

SpecialWobbuffetOT:
	db "Kirk@"
SpecialWobbuffetNick:
	db "Buffy@"

Special_BillsGrandfather: ; 73f7
	farcall SelectMonFromParty
	jr c, .cancel
	ld a, [CurPartySpecies]
	ld [ScriptVar], a
	ld [wNamedObjectIndexBuffer], a
	call GetPokemonName
	jp CopyPokemonName_Buffer1_Buffer3

.cancel
	xor a
	ld [ScriptVar], a
	ret

Special_HiddenPowerGuru:
	farcall SelectMonFromParty
	jr c, .cancel
	ld a, [CurPartySpecies]
	cp EGG
	jr z, .egg
	ld [wNamedObjectIndexBuffer], a
	call GetPokemonName
	call CopyPokemonName_Buffer1_Buffer3
	ld a, [CurPartyMon]
	ld hl, PartyMon1DVs
	call GetPartyLocation
	call GetHiddenPowerType
	ld [wNamedObjectIndexBuffer], a
	farcall GetTypeName
	ld a, $2
.done
	ld [ScriptVar], a
	ret

.cancel
	ld a, $0
	jr .done

.egg
	ld a, $1
	jr .done

Special_YoungerHaircutBrother: ; 7413
	ld hl, Data_YoungerHaircutBrother
	jr MassageOrHaircut

Special_OlderHaircutBrother: ; 7418
	ld hl, Data_OlderHaircutBrother
	jr MassageOrHaircut

Special_DaisyMassage: ; 741d
	ld hl, Data_DaisyMassage
	jr MassageOrHaircut

Special_CianwoodPhotograph:
	ld hl, Data_CianwoodPhotograph
	jr MassageOrHaircut

Special_ReiBlessing:
	ld hl, Data_ReiBlessing

MassageOrHaircut: ; 7420
	push hl
	farcall SelectMonFromParty
	pop hl
	jr c, .nope
	ld a, [CurPartySpecies]
	cp EGG
	jr z, .egg
	push hl
	call GetCurNick
	call CopyPokemonName_Buffer1_Buffer3
	pop hl
	call Random
.loop
	sub [hl]
	jr c, .ok
	inc hl
	inc hl
	inc hl
	jr .loop

.ok
	inc hl
	ld a, [hli]
	ld [ScriptVar], a
	ld c, [hl]
	jp ChangeHappiness

.nope
	xor a
	ld [ScriptVar], a
	ret

.egg
	ld a, 1
	ld [ScriptVar], a
	ret

INCLUDE "data/events/happiness_probabilities.asm"

CopyPokemonName_Buffer1_Buffer3: ; 746e
	ld hl, StringBuffer1
	ld de, StringBuffer3
	ld bc, PKMN_NAME_LENGTH
	jp CopyBytes
