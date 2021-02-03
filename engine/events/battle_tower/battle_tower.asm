Special_BattleTower_FindChallengeLevel:
	; e = maximum party level [1-100]
	ldh a, [rSVBK]
	push af
	ld a, $1
	ldh [rSVBK], a
	ld hl, wPartyMon1Level
	ld bc, PARTYMON_STRUCT_LENGTH
	ld a, [wPartyCount]
	ld d, a
	ld e, 1
.loop
	add hl, bc
	ld a, [hl]
	cp e
	jr c, .ok
	ld e, a
.ok
	dec d
	ld a, d
	jr nz, .loop
	pop af
	ldh [rSVBK], a

	; wBTChoiceOfLvlGroup = (e + 9) / 10 [1-10]
	ld a, 9
	add e
	ld c, 10
	call SimpleDivide

	ldh a, [rSVBK]
	push af
	ld a, $3
	ldh [rSVBK], a
	ld a, b
	ld [wBTChoiceOfLvlGroup], a
	ldh [hScriptVar], a
	pop af
	ldh [rSVBK], a
	ret

Special_BattleTower_Battle:
	xor a
	ld [wBattleTowerBattleEnded], a
.loop
	call RunBattleTowerTrainer
	call DelayFrame
	ld a, [wBattleTowerBattleEnded]
	and a
	ret nz
	jr .loop

RunBattleTowerTrainer:
	ld a, [wOptions2]
	push af
	; force Set mode
	ld hl, wOptions2
	res BATTLE_SWITCH, [hl]
	res BATTLE_PREDICT, [hl]

	ld a, [wInBattleTowerBattle]
	push af
	or $1
	ld [wInBattleTowerBattle], a

	xor a
	ld [wLinkMode], a
	farcall HealPartyEvenForNuzlocke
	call ReadBTTrainerParty
	farcall PopulateBattleTowerTeam

	predef StartBattle

	farcall LoadPokemonData
	farcall HealPartyEvenForNuzlocke
	ld a, [wBattleResult]
	ldh [hScriptVar], a
	and a
	jr nz, .lost
	ld a, BANK(sNrOfBeatenBattleTowerTrainers)
	call GetSRAMBank
	ld a, [sNrOfBeatenBattleTowerTrainers]
	ld [wNrOfBeatenBattleTowerTrainers], a
	call CloseSRAM
	ld hl, wStringBuffer3
	ld a, [wNrOfBeatenBattleTowerTrainers]
	add "1"
	ld [hli], a
	ld [hl], "@"

.lost
	pop af
	ld [wInBattleTowerBattle], a
	pop af
	ld [wOptions2], a
	ld a, $1
	ld [wBattleTowerBattleEnded], a
	ret

ReadBTTrainerParty:
; Initialise the BattleTower-Trainer and his Pkmn
	call CopyBTTrainerToTemp

	ld hl, wBT_OTTempName
	ld de, wOTPlayerName
	ld bc, NAME_LENGTH - 1
	rst CopyBytes
	ld a, "@"
	ld [de], a

	ld hl, wBT_OTTempTrainerClass
	ld a, [hli]
	ld [wOtherTrainerClass], a
	ld a, LOW(wOTPartyMonNicknames)
	ld [wBGMapBuffer], a
	ld a, HIGH(wOTPartyMonNicknames)
	ld [wBGMapBuffer + 1], a

	; Copy Pkmn into Memory from the address in hl
	ld de, wOTPartyMon1Species
	ld bc, wOTPartyCount
	ld a, BATTLETOWER_NROFPKMNS ; Number of Pkmn the BattleTower-Trainer has
	ld [bc], a
	inc bc
.otpartymon_loop
	push af
	ld a, [hl]
	ld [bc], a
	inc bc
	push bc
	ld bc, PARTYMON_STRUCT_LENGTH
	rst CopyBytes
	push de
	ld a, [wBGMapBuffer]
	ld e, a
	ld a, [wBGMapBuffer + 1]
	ld d, a
	ld bc, MON_NAME_LENGTH
	rst CopyBytes
	ld a, e
	ld [wBGMapBuffer], a
	ld a, d
	ld [wBGMapBuffer + 1], a
	pop de
	pop bc
	pop af
	dec a
	and a
	jr nz, .otpartymon_loop
	ld a, -1
	ld [bc], a
	ret

CopyBTTrainerToTemp:
; copy the BattleTower-Trainer data that lies at 'wBT_OTTrainer' to 'wBT_OTTemp'
	ldh a, [rSVBK]
	push af
	ld a, BANK(wBT_OTTrainer)
	ldh [rSVBK], a

	ld hl, wBT_OTTrainer
	ld de, wBT_OTTemp ; wMisc
	ld bc, BATTLE_TOWER_STRUCT_LENGTH
	rst CopyBytes

	pop af
	ldh [rSVBK], a

	ld a, BANK(sBattleTowerChallengeState)
	call GetSRAMBank
	ld a, BATTLETOWER_CHALLENGE_IN_PROGESS
	ld [sBattleTowerChallengeState], a
	ld hl, sNrOfBeatenBattleTowerTrainers
	inc [hl]
	jp CloseSRAM

Special_BattleTower_ResetTrainersSRAM:
	ld a, BANK(sBTTrainers)
	call GetSRAMBank
	ld a, $ff
	ld hl, sBTTrainers
	ld bc, BATTLETOWER_NROFTRAINERS
	rst ByteFill
	xor a
	ld [sNrOfBeatenBattleTowerTrainers], a
	jp CloseSRAM

Special_BattleTower_CheckNewSaveFile:
	call Special_BattleTower_CheckSaveFileExistsAndIsYours
	ldh a, [hScriptVar]
	and a
	ret z

	ld a, BANK(sBattleTowerSaveFileFlags)
	call GetSRAMBank
	ld a, [sBattleTowerSaveFileFlags]
	and $2
	ldh [hScriptVar], a
	jp CloseSRAM

Special_BattleTower_GetChallengeState:
	ld hl, sBattleTowerChallengeState
	ld a, BANK(sBattleTowerChallengeState)
	call GetSRAMBank
	ld a, [hl]
	ldh [hScriptVar], a
	jp CloseSRAM

Special_BattleTower_SetChallengeState:
	ldh a, [hScriptVar]
	ld c, a
	ld a, BANK(sBattleTowerChallengeState)
	call GetSRAMBank
	ld a, c
	ld [sBattleTowerChallengeState], a
	jp CloseSRAM

Special_BattleTower_MarkNewSaveFile:
	ld a, BANK(sBattleTowerSaveFileFlags)
	call GetSRAMBank
	ld a, [sBattleTowerSaveFileFlags]
	or $2
	ld [sBattleTowerSaveFileFlags], a
	jp CloseSRAM

Special_BattleTower_SaveLevelGroup:
	ld a, BANK(sBTChoiceOfLevelGroup)
	call GetSRAMBank
	ldh a, [rSVBK]
	push af
	ld a, $3
	ldh [rSVBK], a
	ld a, [wBTChoiceOfLvlGroup]
	ld [sBTChoiceOfLevelGroup], a
	pop af
	ldh [rSVBK], a
	jp CloseSRAM

Special_BattleTower_LoadLevelGroup:
	ld a, BANK(sBTChoiceOfLevelGroup)
	call GetSRAMBank
	ldh a, [rSVBK]
	push af
	ld a, $3
	ldh [rSVBK], a
	ld a, [sBTChoiceOfLevelGroup]
	ld [wBTChoiceOfLvlGroup], a
	pop af
	ldh [rSVBK], a
	jp CloseSRAM

Special_BattleTower_CheckSaveFileExistsAndIsYours:
	ld a, [wSaveFileExists]
	and a
	jr z, .nope
	farcall CompareLoadedAndSavedPlayerID
	jr z, .yes
	xor a
	jr .nope
.yes
	ld a, $1
.nope
	ldh [hScriptVar], a
	ret

Special_BattleTower_MaxVolume:
	xor a
	ld [wMusicFade], a
	jp MaxVolume

Special_BattleTower_BeginChallenge:
	; Reset battle count
	xor a
	ld [wBattleTowerBattleEnded], a
	ld [wNrOfBeatenBattleTowerTrainers], a

	; Commit party selection to SRAM
	
	ret

Special_BattleTower_LoadOpponentTrainerAndPokemonsWithOTSprite:
	farcall Function_LoadOpponentTrainer
	ldh a, [rSVBK]
	push af
	ld a, BANK(wBT_OTTrainerClass)
	ldh [rSVBK], a
	ld hl, wBT_OTTrainerClass
	ld a, [hl]
	dec a
	ld c, a
	ld b, $0
	pop af
	ldh [rSVBK], a
	ld hl, BTTrainerClassSprites
	add hl, bc
	ld a, [hl]
	ld [wBTTempOTSprite], a

; Load sprite of the opponent trainer
; because s/he is chosen randomly and appears out of nowhere
	ld [wMap1ObjectSprite], a
	ldh [hUsedSpriteIndex], a
	ld a, 24
	ldh [hUsedSpriteTile], a
	farjp GetUsedSprite

INCLUDE "data/trainers/sprites.asm"

Special_BattleTower_CheckForRules:
	farcall CheckForBattleTowerRules
	jr c, .yes
	xor a
	jr .done
.yes
	ld a, 1
.done
	ldh [hScriptVar], a
	ret

Special_BattleTower_MainMenu:
	ld a, $4
	ldh [hScriptVar], a
	ld hl, MenuDataHeader_ChallengeExplanationCancel
	call LoadMenuHeader
	call ChallengeExplanationCancelMenu
	jp CloseWindow

ChallengeExplanationCancelMenu:
	call VerticalMenu
	jr c, .Exit
	ldh a, [hScriptVar]
	cp $5
	jr nz, .UsewMenuCursorY
	ld a, [wMenuCursorY]
	cp $3
	ret z
	jr c, .UsewMenuCursorY
	dec a
	jr .LoadToScriptVar

.UsewMenuCursorY:
	ld a, [wMenuCursorY]

.LoadToScriptVar:
	ldh [hScriptVar], a
	ret

.Exit:
	ld a, $4
	ldh [hScriptVar], a
	ret

MenuDataHeader_ChallengeExplanationCancel:
	db $40 ; flags
	db  0,  0 ; start coords
	db  7, 14 ; end coords
	dw MenuData2_ChallengeExplanationCancel
	db 1 ; default option

MenuData2_ChallengeExplanationCancel:
	db $a0 ; flags
	db 3
	db "Challenge@"
	db "Explanation@"
	db "Cancel@"

CheckForBattleTowerRules:
	ld de, .PointerTables
	call BattleTower_ExecuteJumptable
	ret z
	call BattleTower_PleaseReturnWhenReady
	scf
	ret

.PointerTables:
	db 5
	dw .Functions
	dw .TextPointers

.Functions:
	dw Function_PartyCountEq3
	dw Function_HasPartyAnEgg
	dw Function_PartySpeciesAreUnique
	dw Function_PartyItemsAreUnique
	dw Function_UberRestriction

.TextPointers:
	dw JumpText_ExcuseMeYoureNotReady
	dw JumpText_OnlyThreePkmnMayBeEntered
	dw JumpText_YouCantTakeAnEgg
	dw JumpText_ThePkmnMustAllBeDifferentKinds
	dw JumpText_ThePkmnMustNotHoldTheSameItems
	dw JumpText_UberRestriction

JumpText_ExcuseMeYoureNotReady:
	; Excuse me. You're not ready.
	text_jump Text_ExcuseMeYoureNotReady
	text_end

BattleTower_PleaseReturnWhenReady:
	ld hl, .PleaseReturnWhenReady
	jp PrintText

.PleaseReturnWhenReady:
	; Please return when you're ready.
	text_jump UnknownText_0x1c5962
	text_end

JumpText_OnlyThreePkmnMayBeEntered:
	; Three #MON must be entered.
	text_jump Text_OnlyThreePkmnMayBeEntered
	text_end

JumpText_ThePkmnMustAllBeDifferentKinds:
	; The @  #MON must all be different kinds.
	text_jump Text_ThePkmnMustAllBeDifferentKinds
	text_end

JumpText_ThePkmnMustNotHoldTheSameItems:
	; The @  #MON must not hold the same items.
	text_jump Text_ThePkmnMustNotHoldTheSameItems
	text_end

JumpText_YouCantTakeAnEgg:
	; You can't take an EGG!
	text_jump Text_YouCantTakeAnEgg
	text_end

JumpText_UberRestriction:
	; @  must be <LV>70 or higher.
	text_jump Text_UberRestriction
	text_end

BattleTower_ExecuteJumptable:
	ld bc, 0
.loop
	call .DoJumptableFunction
	call c, .PrintFailureText
	call .Next_CheckReachedEnd
	jr nz, .loop
	ld a, b
	and a
	ret

.DoJumptableFunction:
	push de
	push bc
	call .GetFunctionPointer
	ld a, c
	call JumpTable
	pop bc
	pop de
	ret

.Next_CheckReachedEnd:
	inc c
	ld a, [de]
	cp c
	ret

.GetFunctionPointer:
	inc de
	ld a, [de]
	ld l, a
	inc de
	ld a, [de]
	ld h, a
	ret

.GetTextPointers:
	inc de
	inc de
	inc de
	ld a, [de]
	ld l, a
	inc de
	ld a, [de]
	ld h, a
	ret

.LoadTextPointer:
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ret

.PrintFailureText:
	push de
	push bc
	ld a, b
	and a
	call z, .PrintFirstText
	pop bc
	call .PrintNthText
	ld b, $1
	pop de
	ret

.PrintFirstText:
	push de
	call .GetTextPointers
	call .LoadTextPointer
	call PrintText
	pop de
	ret

.PrintNthText:
	push bc
	call .GetTextPointers
	inc hl
	inc hl
	ld b, $0
	add hl, bc
	add hl, bc
	call .LoadTextPointer
	call PrintText
	pop bc
	ret

Function_PartyCountEq3:
	ld a, [wPartyCount]
	cp 3
	ret z
	scf
	ret

Function_PartySpeciesAreUnique:
	ld hl, wPartyMon1Species
	jr VerifyUniqueness

Function_PartyItemsAreUnique:
	ld hl, wPartyMon1Item
	; fallthrough

VerifyUniqueness:
	ld de, wPartyCount
	ld a, [de]
	inc de
	dec a
	jr z, .done
	ld b, a
.loop
	push hl
	push de
	ld c, b
	ld a, [hl]
	and a
	jr z, .next
.loop2
	call .nextmon
	cp [hl]
	jr z, .gotcha

.next2
	dec c
	jr nz, .loop2

.next
	pop de
	pop hl
	call .nextmon
	dec b
	jr nz, .loop

.done
	and a
	ret

.gotcha
	pop de
	pop hl
	scf
	ret

.nextmon
	push bc
	ld bc, PARTYMON_STRUCT_LENGTH
	add hl, bc
	inc de
	pop bc
	ret

Function_HasPartyAnEgg:
	ld hl, wPartyMon1IsEgg
	ld a, [wPartyCount]
	ld c, a
	ld de, PARTYMON_STRUCT_LENGTH
.loop
	bit MON_IS_EGG_F, [hl]
	jr nz, .found
	add hl, de
	dec c
	jr nz, .loop
	and a
	ret

.found
	scf
	ret

BT_SetPlayerOT:
; Interprets the selected party mons for entering and populates wOTParty
; with the chosen Pokémon from the player. Used for 2 things: legality
; checking and to fix the party order according to player choices.
	; Number of party mons
	ld a, [wBT_PartySelectCounter]
	ld [wOTPartyCount], a

	; The rest is iterated
	ld bc, 0
	ld d, a
.loop
	; Party species array
	push de
	ld hl, wPartySpecies
	ld de, wOTPartySpecies
	ld a, 1 ; just a single byte to copy each iteration
	call .CopyPartyData

	; Main party struct
	ld hl, wPartyMons
	ld de, wOTPartyMons
	ld a, PARTYMON_STRUCT_LENGTH
	call .CopyPartyData

	; Nickname struct
	ld hl, wPartyMonNicknames
	ld de, wOTPartyMonNicknames
	ld a, MON_NAME_LENGTH
	call .CopyPartyData

	; OT name struct
	ld hl, wPartyMonOT
	ld de, wOTPartyMonOT
	ld a, NAME_LENGTH
	call .CopyPartyData
	pop de

	inc c
	ld a, c
	cp d
	jr nz, .loop

	; Add party species terminator, then we're done
	ld hl, wOTPartySpecies
	add hl, bc
	ld [hl], -1
	ret

.CopyPartyData:
; Copy a bytes from hl to de, with relative addresses depending on
; which mon we're currently working on. Preserves bc.
	; First, correct de to the current mon target index we're adding.
	; Just add a*bc (struct length * loop iterator)
	push hl
	ld h, d
	ld l, e
	push af
	rst AddNTimes
	pop af
	ld d, h
	ld e, l
	pop hl

	; Now, correct hl to the current mon source index.
	; Get the source index from party selection
	push bc
	push hl
	ld hl, wBT_PartySelections
	add hl, bc
	ld c, [hl] ; b always remains zero, no need to mess with it
	pop hl

	; Now bc holds party index, so we can AddNTimes like with de earlier
	push af
	rst AddNTimes
	pop af

	; Now copy the data
	ld c, a
	rst CopyBytes
	pop bc
	ret

BT_LegalityCheck:
; Check OT party for violations of Species or Item Clause. Used to verify
; both the player team when entering after copying to OT data, and the
; generated AI team. Returns z if the team is legal, otherwise nz and the error
; in a (1: 2+ share species, 2: 2+ share item)
; Species Clause: more than 1 Pokémon are the same species
; Item Clause: more than 1 Pokémon holds the same item
	; Party size
	ld hl, wOTPartyMon1Species
	call .CheckAnyIdentical
	ld a, 1
	jr c, .illegal
	ld hl, wOTPartyMon1Item
	call .CheckAnyIdentical
	ld a, 2
	jr c, .illegal
	xor a
.illegal
	and a
	ret

.CheckAnyIdentical:
; Check if any of the indexes referred to by hl in the party is identical.
; Ignores indexes with value 0 (to allow several mons holding no items).
	ld a, [wOTPartyCount]
	ld e, a ; Total party size
	ld d, 0 ; Outer iterator
.outer_loop
	; Check if we've finished validation. If so, everything is legal.
	ld a, d
	cp e
	ret z

	ld b, [hl] ; Current value to compare to

	; Don't check a value of 0, to allow for several mons holding no item
	ld a, b
	and a
	jr z, .next_outer

	; Now do the actual checking
	ld c, d ; Inner iterator
	push hl
.inner_loop
	; Is index identical?
	push bc
	ld bc, PARTYMON_STRUCT_LENGTH
	add hl, bc
	pop bc
	ld a, [hl]
	cp b
	jr z, .identical

	; Check next index if identical
	inc c
	ld a, c
	cp e
	jr nz, .inner_loop

.next_outer
	; No index was identical, or it was 0. Advance to next value to check.
	pop hl
	push bc
	ld bc, PARTYMON_STRUCT_LENGTH
	add hl, bc
	pop bc
	inc d
	jr .outer_loop
.identical
	pop hl
	scf
	ret

Function_UberRestriction:
	ld hl, wPartyMon1Level
	ld bc, PARTYMON_STRUCT_LENGTH
	ld de, wPartySpecies
	ld a, [wPartyCount]
.loop
	push af
	ld a, [de]
	push bc
	push de
	push hl
	ld de, 1
	ld hl, UberMons
	call IsInArray
	pop bc
	pop de
	pop hl
	jr nc, .next
.uber
	ld a, [hl]
	cp 70
	jr c, .uber_under_70
.next
	add hl, bc
	inc de
	pop af
	dec a
	jr nz, .loop
	and a
	ret

.uber_under_70
	pop af
	ld a, [de]
	ld [wd265], a
	call GetPokemonName
	scf
	ret
