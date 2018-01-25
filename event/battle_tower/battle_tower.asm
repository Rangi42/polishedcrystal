Special_BattleTower_FindChallengeLevel: ; 1700b0
	; e = maximum party level [1-100]
	ld a, [rSVBK]
	push af
	ld a, $1
	ld [rSVBK], a
	ld hl, PartyMon1Level
	ld bc, PARTYMON_STRUCT_LENGTH
	ld a, [PartyCount]
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
	ld [rSVBK], a

	; wBTChoiceOfLvlGroup = (e + 9) / 10 [1-10]
	ld a, 9
	add e
	ld c, 10
	call SimpleDivide

	ld a, [rSVBK]
	push af
	ld a, $3
	ld [rSVBK], a
	ld a, b
	ld [wBTChoiceOfLvlGroup], a
	ld [ScriptVar], a
	pop af
	ld [rSVBK], a
	ret
; 1700ba

Special_BattleTower_Battle: ; 170215
	xor a
	ld [wBattleTowerBattleEnded], a
.loop
	call .do_dw
	call DelayFrame
	ld a, [wBattleTowerBattleEnded]
	cp $1
	jr nz, .loop
	ret
; 17023a

.do_dw ; 17023a
	ld a, [wBattleTowerBattleEnded]
	ld e, a
	ld d, 0
	ld hl, .dw
	add hl, de
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jp hl
; 170249

.dw ; 170249
	dw RunBattleTowerTrainer
	dw SkipBattleTowerTrainer
; 17024d

RunBattleTowerTrainer: ; 17024d
	ld a, [Options2]
	push af
	; force Set mode
	ld hl, Options2
	res BATTLE_SWITCH, [hl]
	res BATTLE_PREDICT, [hl]

	ld a, [InBattleTowerBattle]
	push af
	or $1
	ld [InBattleTowerBattle], a

	xor a
	ld [wLinkMode], a
	farcall HealPartyEvenForNuzlocke
	call ReadBTTrainerParty
	farcall PopulateBattleTowerTeam

	predef StartBattle

	farcall LoadPokemonData
	farcall HealPartyEvenForNuzlocke
	ld a, [wBattleResult]
	ld [ScriptVar], a
	and a
	jr nz, .lost
	ld a, BANK(sNrOfBeatenBattleTowerTrainers)
	call GetSRAMBank
	ld a, [sNrOfBeatenBattleTowerTrainers]
	ld [wNrOfBeatenBattleTowerTrainers], a
	call CloseSRAM
	ld hl, StringBuffer3
	ld a, [wNrOfBeatenBattleTowerTrainers]
	add "1"
	ld [hli], a
	ld a, "@"
	ld [hl], a

.lost
	pop af
	ld [InBattleTowerBattle], a
	pop af
	ld [Options2], a
	ld a, $1
	ld [wBattleTowerBattleEnded], a
SkipBattleTowerTrainer: ; 1704c9
	ret

ReadBTTrainerParty: ; 1702b7
; Initialise the BattleTower-Trainer and his Pkmn
	call CopyBTTrainerToTemp

	ld hl, wBT_OTTempName ; 0xc608
	ld de, OTPlayerName
	ld bc, NAME_LENGTH - 1
	call CopyBytes
	ld a, "@"
	ld [de], a

	ld hl, wBT_OTTempTrainerClass
	ld a, [hli]
	ld [OtherTrainerClass], a
	ld a, OTPartyMonNicknames % $100
	ld [BGMapBuffer], a
	ld a, OTPartyMonNicknames / $100
	ld [BGMapBuffer + 1], a

	; Copy Pkmn into Memory from the address in hl
	ld de, OTPartyMon1Species
	ld bc, OTPartyCount
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
	call CopyBytes
	push de
	ld a, [BGMapBuffer]
	ld e, a
	ld a, [BGMapBuffer + 1]
	ld d, a
	ld bc, PKMN_NAME_LENGTH
	call CopyBytes
	ld a, e
	ld [BGMapBuffer], a
	ld a, d
	ld [BGMapBuffer + 1], a
	pop de
	pop bc
	pop af
	dec a
	and a
	jr nz, .otpartymon_loop
	ld a, -1
	ld [bc], a
	ret
; 170394

CopyBTTrainerToTemp: ; 1704a2
; copy the BattleTower-Trainer data that lies at 'BT_OTTrainer' to 'wBT_OTTemp'
	ld a, [rSVBK]
	push af
	ld a, BANK(BT_OTTrainer)
	ld [rSVBK], a

	ld hl, BT_OTTrainer ; $d100
	ld de, wBT_OTTemp ; wMisc
	ld bc, BATTLE_TOWER_STRUCT_LENGTH
	call CopyBytes

	pop af
	ld [rSVBK], a

	ld a, BANK(sBattleTowerChallengeState)
	call GetSRAMBank
	ld a, BATTLETOWER_CHALLENGE_IN_PROGESS
	ld [sBattleTowerChallengeState], a
	ld hl, sNrOfBeatenBattleTowerTrainers
	inc [hl]
	jp CloseSRAM
; 1704ca

Special_BattleTower_ResetTrainersSRAM: ; 1706d6 (5c:46d6)
	ld a, BANK(sBTTrainers)
	call GetSRAMBank
	ld a, $ff
	ld hl, sBTTrainers
	ld bc, BATTLETOWER_NROFTRAINERS
	call ByteFill
	xor a
	ld [sNrOfBeatenBattleTowerTrainers], a
	jp CloseSRAM

Special_BattleTower_CheckNewSaveFile: ; 17075f (5c:475f)
	call Special_BattleTower_CheckSaveFileExistsAndIsYours
	ld a, [ScriptVar]
	and a
	ret z

	ld a, BANK(sBattleTowerNewSaveFile)
	call GetSRAMBank
	ld a, [sBattleTowerNewSaveFile]
	and $2
	ld [ScriptVar], a
	jp CloseSRAM

Special_BattleTower_GetChallengeState: ; 170778 (5c:4778)
	ld hl, sBattleTowerChallengeState
	ld a, BANK(sBattleTowerChallengeState)
	call GetSRAMBank
	ld a, [hl]
	ld [ScriptVar], a
	jp CloseSRAM

Special_BattleTower_SetChallengeState:
	ld a, [ScriptVar]
	ld c, a
	ld a, BANK(sBattleTowerChallengeState)
	call GetSRAMBank
	ld a, c
	ld [sBattleTowerChallengeState], a
	jp CloseSRAM

Special_BattleTower_MarkNewSaveFile: ; 170788 (5c:4788)
	ld a, BANK(sBattleTowerNewSaveFile)
	call GetSRAMBank
	ld a, [sBattleTowerNewSaveFile]
	or $2
	ld [sBattleTowerNewSaveFile], a
	jp CloseSRAM

Special_BattleTower_SaveLevelGroup: ; 170868 (5c:4868)
	ld a, BANK(sBTChoiceOfLevelGroup)
	call GetSRAMBank
	ld a, [rSVBK]
	push af
	ld a, $3
	ld [rSVBK], a
	ld a, [wBTChoiceOfLvlGroup]
	ld [sBTChoiceOfLevelGroup], a
	pop af
	ld [rSVBK], a
	jp CloseSRAM

Special_BattleTower_LoadLevelGroup: ; 170881 (5c:4881)
	ld a, BANK(sBTChoiceOfLevelGroup)
	call GetSRAMBank
	ld a, [rSVBK]
	push af
	ld a, $3
	ld [rSVBK], a
	ld a, [sBTChoiceOfLevelGroup]
	ld [wBTChoiceOfLvlGroup], a
	pop af
	ld [rSVBK], a
	jp CloseSRAM

Special_BattleTower_CheckSaveFileExistsAndIsYours: ; 17089a
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
	ld [ScriptVar], a
	ret
; 1708b1

Special_BattleTower_MaxVolume: ; 1708b1 (5c:48b1)
	xor a
	ld [MusicFade], a
	jp MaxVolume

Special_BattleTower_BeginChallenge: ; 170a9c (5c:4a9c)
	xor a
	ld [wBattleTowerBattleEnded], a
	ld [wNrOfBeatenBattleTowerTrainers], a
	ld [wcf65], a
	ld [wcf66], a
	ret

Special_BattleTower_LoadOpponentTrainerAndPokemonsWithOTSprite: ; 0x170b44
	farcall Function_LoadOpponentTrainer
	ld a, [rSVBK]
	push af
	ld a, BANK(BT_OTTrainerClass)
	ld [rSVBK], a
	ld hl, BT_OTTrainerClass
	ld a, [hl]
	dec a
	ld c, a
	ld b, $0
	pop af
	ld [rSVBK], a
	ld hl, BTTrainerClassSprites
	add hl, bc
	ld a, [hl]
	ld [wBTTempOTSprite], a

; Load sprite of the opponent trainer
; because s/he is chosen randomly and appears out of nowhere
	ld a, [wBTTempOTSprite]
	ld [Map1ObjectSprite], a
	ld [UsedSprites + 2], a
	ld [hUsedSpriteIndex], a
	ld a, [UsedSprites + 3]
	ld [hUsedSpriteTile], a
	farjp GetUsedSprite
; 170b90

INCLUDE "data/trainers/sprites.asm"

Special_BattleTower_CheckForRules: ; 170bd3
	farcall CheckForBattleTowerRules
	jr c, .yes
	xor a
	jr .done
.yes
	ld a, 1
.done
	ld [ScriptVar], a
	ret
; 170c06

Special_BattleTower_MainMenu: ; 17d224
	ld a, $4
	ld [ScriptVar], a
	ld hl, MenuDataHeader_ChallengeExplanationCancel
	call LoadMenuDataHeader
	call ChallengeExplanationCancelMenu
	jp CloseWindow
; 17d246

ChallengeExplanationCancelMenu: ; 17d246
	call VerticalMenu
	jr c, .Exit
	ld a, [ScriptVar]
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
	ld [ScriptVar], a
	ret

.Exit:
	ld a, $4
	ld [ScriptVar], a
	ret
; 17d26a

MenuDataHeader_ChallengeExplanationCancel: ; 17d28f
	db $40 ; flags
	db  0,  0 ; start coords
	db  7, 14 ; end coords
	dw MenuData2_ChallengeExplanationCancel
	db 1 ; default option

MenuData2_ChallengeExplanationCancel: ; 17d297
	db $a0 ; flags
	db 3
	db "Challenge@"
	db "Explanation@"
	db "Cancel@"
; 17d2b6

CheckForBattleTowerRules: ; 8b201
	ld de, .PointerTables
	call BattleTower_ExecuteJumptable
	ret z
	call BattleTower_PleaseReturnWhenReady
	scf
	ret
; 8b215

.PointerTables: ; 8b215
	db 5
	dw .Functions
	dw .TextPointers

.Functions: ; 8b21a
	dw Function_PartyCountEq3
	dw Function_PartySpeciesAreUnique
	dw Function_PartyItemsAreUnique
	dw Function_HasPartyAnEgg
	dw Function_UberRestriction
; 8b222

.TextPointers: ; 8b222
	dw JumpText_ExcuseMeYoureNotReady
	dw JumpText_OnlyThreePkmnMayBeEntered
	dw JumpText_ThePkmnMustAllBeDifferentKinds
	dw JumpText_ThePkmnMustNotHoldTheSameItems
	dw JumpText_YouCantTakeAnEgg
	dw JumpText_UberRestriction
; 8b22c

JumpText_ExcuseMeYoureNotReady: ; 0x8b22c
	; Excuse me. You're not ready.
	text_jump Text_ExcuseMeYoureNotReady
	db "@"
; 0x8b231

BattleTower_PleaseReturnWhenReady: ; 8b231
	ld hl, .PleaseReturnWhenReady
	jp PrintText
; 8b238

.PleaseReturnWhenReady: ; 0x8b238
	; Please return when you're ready.
	text_jump UnknownText_0x1c5962
	db "@"
; 0x8b23d

JumpText_OnlyThreePkmnMayBeEntered: ; 0x8b247
	; Three #MON must be entered.
	text_jump Text_OnlyThreePkmnMayBeEntered
	db "@"
; 0x8b24c

JumpText_ThePkmnMustAllBeDifferentKinds: ; 0x8b24c
	; The @  #MON must all be different kinds.
	text_jump Text_ThePkmnMustAllBeDifferentKinds
	db "@"
; 0x8b251

JumpText_ThePkmnMustNotHoldTheSameItems: ; 0x8b251
	; The @  #MON must not hold the same items.
	text_jump Text_ThePkmnMustNotHoldTheSameItems
	db "@"
; 0x8b256

JumpText_YouCantTakeAnEgg: ; 0x8b256
	; You can't take an EGG!
	text_jump Text_YouCantTakeAnEgg
	db "@"
; 0x8b25b

JumpText_UberRestriction:
	; @  must be <LV>70 or higher.
	text_jump Text_UberRestriction
	db "@"

BattleTower_ExecuteJumptable: ; 8b25b
	ld bc, 0
.loop
	call .DoJumptableFunction
	call c, .PrintFailureText
	call .Next_CheckReachedEnd
	jr nz, .loop
	ld a, b
	and a
	ret
; 8b26c

.DoJumptableFunction: ; 8b26c
	push de
	push bc
	call .GetFunctionPointer
	ld a, c
	rst JumpTable
	pop bc
	pop de
	ret
; 8b276

.Next_CheckReachedEnd: ; 8b276
	inc c
	ld a, [de]
	cp c
	ret
; 8b27a

.GetFunctionPointer: ; 8b27a
	inc de
	ld a, [de]
	ld l, a
	inc de
	ld a, [de]
	ld h, a
	ret
; 8b281

.GetTextPointers: ; 8b281
	inc de
	inc de
	inc de
	ld a, [de]
	ld l, a
	inc de
	ld a, [de]
	ld h, a
	ret
; 8b28a

.LoadTextPointer: ; 8b28a
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ret
; 8b28e

.PrintFailureText: ; 8b28e
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
; 8b29d

.PrintFirstText: ; 8b29d
	push de
	call .GetTextPointers
	call .LoadTextPointer
	call PrintText
	pop de
	ret
; 8b2a9

.PrintNthText: ; 8b2a9
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
; 8b2bb

Function_PartyCountEq3: ; 8b2da
	ld a, [PartyCount]
	cp 3
	ret z
	scf
	ret
; 8b2e2

Function_PartySpeciesAreUnique: ; 8b2e2
	ld hl, PartyMon1Species
	jr VerifyUniqueness

Function_PartyItemsAreUnique: ; 8b32a
	ld hl, PartyMon1Item
	; fallthrough

VerifyUniqueness: ; 8b2e9
	ld de, PartyCount
	ld a, [de]
	inc de
	dec a
	jr z, .done
	ld b, a
.loop
	push hl
	push de
	ld c, b
	call .isegg
	jr z, .next
	ld a, [hl]
	and a
	jr z, .next
.loop2
	call .nextmon
	call .isegg
	jr z, .next2
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
; 8b31a

.nextmon ; 8b31a
	push bc
	ld bc, PARTYMON_STRUCT_LENGTH
	add hl, bc
	inc de
	pop bc
	ret
; 8b322

.isegg ; 8b322
	push bc
	ld b, a
	ld a, [de]
	cp EGG
	ld a, b
	pop bc
	ret
; 8b32a

Function_HasPartyAnEgg: ; 8b331
	ld hl, PartyCount
	ld a, [hli]
	ld c, a
.loop
	ld a, [hli]
	cp EGG
	jr z, .found
	dec c
	jr nz, .loop
	and a
	ret

.found
	scf
	ret
; 8b342

Function_UberRestriction:
	ld hl, PartyMon1Level
	ld bc, PARTYMON_STRUCT_LENGTH
	ld de, PartySpecies
	ld a, [PartyCount]
.loop
	push af
	ld a, [de]
	cp MEWTWO
	jr z, .uber
	cp MEW
	jr z, .uber
	cp LUGIA
	jr z, .uber
	cp HO_OH
	jr z, .uber
	cp CELEBI
	jr nz, .next
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
