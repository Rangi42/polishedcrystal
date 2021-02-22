SaveMenu:
	ld c, 4
	call SFXDelayFrames
	call LoadStandardMenuHeader
	farcall DisplaySaveInfoOnSave
	call SpeechTextbox
	call UpdateSprites
	call ApplyTilemap
	ld hl, WouldYouLikeToSaveTheGameText
	ld b, BANK(WouldYouLikeToSaveTheGameText)
	call MapTextbox
	call LoadMenuTextbox
	call YesNoBox
	ld a, [wMenuCursorY]
	dec a
	call CloseWindow
	and a
	jr nz, .refused
	call AskOverwriteSaveFile
	jr c, .refused
	call SetWRAMStateForSave
	call SavedTheGame
	call ClearWRAMStateAfterSave
	call ExitMenu
	and a
	ret

.refused
	call ExitMenu
	call CopyTilemapAtOnce
	scf
	ret

SaveAfterLinkTrade:
	call SetWRAMStateForSave
	farcall StageRTCTimeForSave
	call SavePokemonData
	call SaveChecksum
	call SaveBackupPokemonData
	call SaveBackupChecksum
	farcall BackupPartyMonMail
	farcall SaveRTC
	jp ClearWRAMStateAfterSave

Link_SaveGame:
	call AskOverwriteSaveFile
	ret c
ForceGameSave:
	call SetWRAMStateForSave
	call SavedTheGame
	call ClearWRAMStateAfterSave
	and a
	ret

MovePkmnWOMail_SaveGame:
	call SetWRAMStateForSave
	push de
	call SaveBox
	pop de
	ld a, e
	ld [wCurBox], a
	call LoadBox
	jp ClearWRAMStateAfterSave

MovePkmnWOMail_InsertMon_SaveGame:
	call SetWRAMStateForSave
	push de
	call SaveBox
	pop de
	ld a, e
	ld [wCurBox], a
	ld a, $1
	ld [wSaveFileExists], a
	farcall StageRTCTimeForSave
	call ValidateSave
	call SaveOptions
	call SavePlayerData
	call SavePokemonData
	call SaveChecksum
	call ValidateBackupSave
	call SaveBackupOptions
	call SaveBackupPlayerData
	call SaveBackupPokemonData
	call SaveBackupChecksum
	farcall BackupPartyMonMail
	farcall SaveRTC
	call LoadBox
	call ClearWRAMStateAfterSave
	ld de, SFX_SAVE
	jp PlaySFX

StartMovePkmnWOMail_SaveGame:
	ld hl, MoveMonWOMailSaveText
	call MenuTextbox
	call YesNoBox
	call ExitMenu
	jr c, .refused
	call AskOverwriteSaveFile
	jr c, .refused
	call SetWRAMStateForSave
	call SavedTheGame
	call ClearWRAMStateAfterSave
	and a
	ret

.refused
	scf
	ret

SetWRAMStateForSave:
	ld a, $1
	ld [wGameLogicPaused], a
	ret

ClearWRAMStateAfterSave:
	xor a
	ld [wGameLogicPaused], a
	ret

AddHallOfFameEntry:
	ld a, BANK(sHallOfFame)
	call GetSRAMBank
	ld hl, sHallOfFame + HOF_LENGTH * (NUM_HOF_TEAMS - 1) - 1
	ld de, sHallOfFame + HOF_LENGTH * NUM_HOF_TEAMS - 1
	ld bc, HOF_LENGTH * (NUM_HOF_TEAMS - 1)
.loop
	ld a, [hld]
	ld [de], a
	dec de
	dec bc
	ld a, c
	or b
	jr nz, .loop
	ld hl, wOverworldMapBlocks
	ld de, sHallOfFame
	ld bc, HOF_LENGTH
	rst CopyBytes
	jp CloseSRAM

AskOverwriteSaveFile:
	ld a, [wSaveFileExists]
	and a
	jr z, .erase
	call CompareLoadedAndSavedPlayerID
	jr z, .ok
	ld hl, AnotherSaveFileText
	ld b, BANK(AnotherSaveFileText)
	call MapTextbox
	call LoadMenuTextbox
	call YesNoBox
	ld a, [wMenuCursorY]
	dec a
	call CloseWindow
	and a
	jr nz, .refused
.erase
	call ErasePreviousSave
.ok
	and a
	ret

.refused
	scf
	ret

CompareLoadedAndSavedPlayerID:
	ld a, BANK(sPlayerData)
	call GetSRAMBank
	ld hl, sPlayerData + (wPlayerID - wPlayerData)
	ld a, [hli]
	ld c, [hl]
	ld b, a
	call CloseSRAM
	ld a, [wPlayerID]
	cp b
	ret nz
	ld a, [wPlayerID + 1]
	cp c
	ret

SavedTheGame:
	call SaveGameData
	; <PLAYER> saved the game!
	ld hl, SavedTheGameText
	call PrintText
	ld de, SFX_SAVE
	call WaitPlaySFX
	jp WaitSFX

SaveGameData::
	ldh a, [hVBlank]
	push af
	ld a, 2
	ldh [hVBlank], a
	dec a ; ld a, TRUE
	ld [wSaveFileExists], a
	farcall StageRTCTimeForSave
	call ValidateSave
	call SaveOptions
	call SavePlayerData
	call SavePokemonData
	call SaveBox

	; This function is never called mid-Battle Tower (only in the beginning).
	; So this is always a safe action, and gets rid of potential old BT state
	; from a previous save. Done before checksum generation in case user resets
	; mid-save.
	ld a, BANK(sBattleTowerChallengeState)
	call GetSRAMBank
	xor a
	ld [sBattleTowerChallengeState], a

	call SaveChecksum
	call ValidateBackupSave
	call SaveBackupOptions
	call SaveBackupPlayerData
	call SaveBackupPokemonData
	call SaveBackupChecksum
	farcall BackupPartyMonMail
	farcall SaveRTC
	call CloseSRAM ; just in case
	pop af
	ldh [hVBlank], a
	ret

ErasePreviousSave:
	call EraseBoxes
	call EraseHallOfFame
	call EraseLinkBattleStats
	call EraseBattleTowerStatus
	ld a, $1
	ld [wSavedAtLeastOnce], a
	ret

EraseLinkBattleStats:
	ld a, BANK(sLinkBattleStats)
	call GetSRAMBank
	ld hl, sLinkBattleStats
	ld bc, sLinkBattleStatsEnd - sLinkBattleStats
	xor a
	rst ByteFill
	jp CloseSRAM

EraseHallOfFame:
	ld a, BANK(sHallOfFame)
	call GetSRAMBank
	ld hl, sHallOfFame
	ld bc, sHallOfFameEnd - sHallOfFame
	xor a
	rst ByteFill
	jp CloseSRAM

EraseBattleTowerStatus:
	ld a, BANK(sBattleTowerChallengeState)
	call GetSRAMBank
	xor a
	ld [sBattleTowerChallengeState], a
	jp CloseSRAM

HallOfFame_InitSaveIfNeeded:
	ld a, [wSavedAtLeastOnce]
	and a
	ret nz
	jp ErasePreviousSave

ValidateSave:
	ld a, BANK(sCheckValue1)
	call GetSRAMBank
	ld a, SAVE_CHECK_VALUE_1
	ld [sCheckValue1], a
	ld a, SAVE_CHECK_VALUE_2
	ld [sCheckValue2], a
	jp CloseSRAM

SaveOptions:
	ld a, BANK(sOptions)
	call GetSRAMBank
	ld hl, wOptions1
	ld de, sOptions
	ld bc, wOptionsEnd - wOptions1
	rst CopyBytes
	ld a, [wOptions1]
	and $ff ^ (1 << NO_TEXT_SCROLL)
	ld [sOptions], a
	jp CloseSRAM

SavePlayerData:
	ld a, BANK(sPlayerData)
	call GetSRAMBank
	ld hl, wPlayerData
	ld de, sPlayerData
	ld bc, wPlayerDataEnd - wPlayerData
	rst CopyBytes
	ld hl, wCurMapData
	ld de, sMapData
	ld bc, wCurMapDataEnd - wCurMapData
	rst CopyBytes
	jp CloseSRAM

SavePokemonData:
	ld a, BANK(sPokemonData)
	call GetSRAMBank
	ld hl, wPokemonData
	ld de, sPokemonData
	ld bc, wPokemonDataEnd - wPokemonData
	rst CopyBytes
	jp CloseSRAM

SaveBox:
	call GetBoxAddress
	jp SaveBoxAddress

SaveChecksum:
	ld hl, sGameData
	ld bc, sGameDataEnd - sGameData
	ld a, BANK(sGameData)
	call GetSRAMBank
	call Checksum
	ld a, e
	ld [sChecksum + 0], a
	ld a, d
	ld [sChecksum + 1], a
	jp CloseSRAM

ValidateBackupSave:
	ld a, BANK(sBackupCheckValue1)
	call GetSRAMBank
	ld a, SAVE_CHECK_VALUE_1
	ld [sBackupCheckValue1], a
	ld a, SAVE_CHECK_VALUE_2
	ld [sBackupCheckValue2], a
	jp CloseSRAM

SaveBackupOptions:
	ld a, BANK(sBackupOptions)
	call GetSRAMBank
	ld hl, wOptions1
	ld de, sBackupOptions
	ld bc, wOptionsEnd - wOptions1
	rst CopyBytes
	jp CloseSRAM

SaveBackupPlayerData:
	ld a, BANK(sBackupPlayerData)
	call GetSRAMBank
	ld hl, wPlayerData
	ld de, sBackupPlayerData
	ld bc, wPlayerDataEnd - wPlayerData
	rst CopyBytes
	ld hl, wCurMapData
	ld de, sBackupMapData
	ld bc, wCurMapDataEnd - wCurMapData
	rst CopyBytes
	jp CloseSRAM

SaveBackupPokemonData:
	ld a, BANK(sBackupPokemonData)
	call GetSRAMBank
	ld hl, wPokemonData
	ld de, sBackupPokemonData
	ld bc, wPokemonDataEnd - wPokemonData
	rst CopyBytes
	jp CloseSRAM

SaveBackupChecksum:
	ld hl, sBackupGameData
	ld bc, sBackupGameDataEnd - sBackupGameData
	ld a, BANK(sBackupGameData)
	call GetSRAMBank
	call Checksum
	ld a, e
	ld [sBackupChecksum + 0], a
	ld a, d
	ld [sBackupChecksum + 1], a
	jp CloseSRAM

TryLoadSaveFile:
	call VerifyChecksum
	jr nz, .backup
	call LoadPlayerData
	call LoadPokemonData
	call LoadBox
	farcall RestorePartyMonMail
	call ValidateBackupSave
	call SaveBackupOptions
	call SaveBackupPlayerData
	call SaveBackupPokemonData
	call SaveBackupChecksum
	call UpgradeSaveVersion
	and a
	ret

.backup
	call VerifyBackupChecksum
	jr nz, .corrupt
	call LoadBackupPlayerData
	call LoadBackupPokemonData
	call LoadBox
	farcall RestorePartyMonMail
	call ValidateSave
	call SaveOptions
	call SavePlayerData
	call SavePokemonData
	call SaveChecksum
	and a
	ret

.corrupt
	ld a, [wOptions1]
	push af
	set NO_TEXT_SCROLL, a
	ld [wOptions1], a
	ld hl, SaveFileCorruptedText
	call PrintText
	pop af
	ld [wOptions1], a
	scf
	ret

TryLoadSaveData:
	xor a
	ld [wSaveFileExists], a
	call CheckPrimarySaveFile
	ld a, [wSaveFileExists]
	and a
	jr z, .backup

	ld a, BANK(sPlayerData)
	call GetSRAMBank
	ld hl, sPlayerData + wStartDay - wPlayerData
	ld de, wStartDay
	ld bc, 8
	rst CopyBytes
	ld hl, sPlayerData + wStatusFlags - wPlayerData
	ld de, wStatusFlags
	ld a, [hl]
	ld [de], a
	jp CloseSRAM

.backup
	call CheckBackupSaveFile
	ld a, [wSaveFileExists]
	and a
	jr z, .corrupt

	ld a, BANK(sBackupPlayerData)
	call GetSRAMBank
	ld hl, sBackupPlayerData + wStartDay - wPlayerData
	ld de, wStartDay
	ld bc, 8
	rst CopyBytes
	ld hl, sBackupPlayerData + wStatusFlags - wPlayerData
	ld de, wStatusFlags
	ld a, [hl]
	ld [de], a
	jp CloseSRAM

.corrupt
	ld hl, DefaultOptions
	ld de, wOptions1
	ld bc, wOptionsEnd - wOptions1
	rst CopyBytes
	jp PanicResetClock

INCLUDE "data/default_options.asm"

CheckPrimarySaveFile:
	ld a, BANK(sCheckValue1)
	call GetSRAMBank
	ld a, [sCheckValue1]
	cp SAVE_CHECK_VALUE_1
	jr nz, .nope
	ld a, [sCheckValue2]
	cp SAVE_CHECK_VALUE_2
	jr nz, .nope
	ld hl, sOptions
	ld de, wOptions1
	ld bc, wOptionsEnd - wOptions1
	rst CopyBytes
	call CloseSRAM
	ld a, $1
	ld [wSaveFileExists], a

.nope
	jp CloseSRAM

CheckBackupSaveFile:
	ld a, BANK(sBackupCheckValue1)
	call GetSRAMBank
	ld a, [sBackupCheckValue1]
	cp SAVE_CHECK_VALUE_1
	jr nz, .nope
	ld a, [sBackupCheckValue2]
	cp SAVE_CHECK_VALUE_2
	jr nz, .nope
	ld hl, sBackupOptions
	ld de, wOptions1
	ld bc, wOptionsEnd - wOptions1
	rst CopyBytes
	ld a, $2
	ld [wSaveFileExists], a

.nope
	jp CloseSRAM

LoadPlayerData:
	ld a, BANK(sPlayerData)
	call GetSRAMBank
	ld hl, sPlayerData
	ld de, wPlayerData
	ld bc, wPlayerDataEnd - wPlayerData
	rst CopyBytes
	ld hl, sMapData
	ld de, wCurMapData
	ld bc, wCurMapDataEnd - wCurMapData
	rst CopyBytes
	jp CloseSRAM

LoadPokemonData:
	ld a, BANK(sPokemonData)
	call GetSRAMBank
	ld hl, sPokemonData
	ld de, wPokemonData
	ld bc, wPokemonDataEnd - wPokemonData
	rst CopyBytes
	jp CloseSRAM

LoadBox:
	call GetBoxAddress
	jp LoadBoxAddress

VerifyChecksum:
	ld hl, sGameData
	ld bc, sGameDataEnd - sGameData
	ld a, BANK(sGameData)
	call GetSRAMBank
	call Checksum
	ld a, [sChecksum + 0]
	cp e
	jr nz, .fail
	ld a, [sChecksum + 1]
	cp d
.fail
	push af
	call CloseSRAM
	pop af
	ret

LoadBackupPlayerData:
	ld a, BANK(sBackupPlayerData)
	call GetSRAMBank
	ld hl, sBackupPlayerData
	ld de, wPlayerData
	ld bc, wPlayerDataEnd - wPlayerData
	rst CopyBytes
	ld hl, sBackupMapData
	ld de, wCurMapData
	ld bc, wCurMapDataEnd - wCurMapData
	rst CopyBytes
	jp CloseSRAM

LoadBackupPokemonData:
	ld a, BANK(sBackupPokemonData)
	call GetSRAMBank
	ld hl, sBackupPokemonData
	ld de, wPokemonData
	ld bc, wPokemonDataEnd - wPokemonData
	rst CopyBytes
	jp CloseSRAM

VerifyBackupChecksum:
	ld hl, sBackupGameData
	ld bc, sBackupGameDataEnd - sBackupGameData
	ld a, BANK(sBackupGameData)
	call GetSRAMBank
	call Checksum
	ld a, [sBackupChecksum + 0]
	cp e
	jr nz, .fail
	ld a, [sBackupChecksum + 1]
	cp d
.fail
	push af
	call CloseSRAM
	pop af
	ret

GetBoxAddress:
	ld a, [wCurBox]
	cp NUM_BOXES
	jr c, .ok
	xor a
	ld [wCurBox], a

.ok
	ld e, a
	ld d, 0
	ld hl, BoxAddresses
rept 5
	add hl, de
endr
	ld a, [hli]
	push af
	ld a, [hli]
	ld e, a
	ld a, [hli]
	ld d, a
	ld a, [hli]
	ld h, [hl]
	ld l, a
	pop af
	ret

SaveBoxAddress:
; Save box via wMisc.
; We do this in three steps because the size of wMisc is less than
; the size of sBox.
	push hl
; Load the first part of the active box.
	push af
	push de
	ld a, BANK(sBox)
	call GetSRAMBank
	ld hl, sBox
	ld de, wMisc
	ld bc, (wMiscEnd - wMisc)
	rst CopyBytes
	call CloseSRAM
	pop de
	pop af
; Save it to the target box.
	push af
	push de
	call GetSRAMBank
	ld hl, wMisc
	ld bc, (wMiscEnd - wMisc)
	rst CopyBytes
	call CloseSRAM

; Load the second part of the active box.
	ld a, BANK(sBox)
	call GetSRAMBank
	ld hl, sBox + (wMiscEnd - wMisc)
	ld de, wMisc
	ld bc, (wMiscEnd - wMisc)
	rst CopyBytes
	call CloseSRAM
	pop de
	pop af

	ld hl, (wMiscEnd - wMisc)
	add hl, de
	ld e, l
	ld d, h
; Save it to the next part of the target box.
	push af
	push de
	call GetSRAMBank
	ld hl, wMisc
	ld bc, (wMiscEnd - wMisc)
	rst CopyBytes
	call CloseSRAM

; Load the third and final part of the active box.
	ld a, BANK(sBox)
	call GetSRAMBank
	ld hl, sBox + (wMiscEnd - wMisc) * 2
	ld de, wMisc
	ld bc, sBoxEnd - (sBox + (wMiscEnd - wMisc) * 2) ; $8e
	rst CopyBytes
	call CloseSRAM
	pop de
	pop af

	ld hl, (wMiscEnd - wMisc)
	add hl, de
	ld e, l
	ld d, h
; Save it to the final part of the target box.
	call GetSRAMBank
	ld hl, wMisc
	ld bc, sBoxEnd - (sBox + (wMiscEnd - wMisc) * 2) ; $8e
	rst CopyBytes
	call CloseSRAM

	pop hl
	ret

LoadBoxAddress:
; Load box via wMisc.
; We do this in three steps because the size of wMisc is less than
; the size of sBox.
	push hl
	ld l, e
	ld h, d
; Load part 1
	push af
	push hl
	call GetSRAMBank
	ld de, wMisc
	ld bc, (wMiscEnd - wMisc)
	rst CopyBytes
	call CloseSRAM
	ld a, BANK(sBox)
	call GetSRAMBank
	ld hl, wMisc
	ld de, sBox
	ld bc, (wMiscEnd - wMisc)
	rst CopyBytes
	call CloseSRAM
	pop hl
	pop af

	ld de, (wMiscEnd - wMisc)
	add hl, de
; Load part 2
	push af
	push hl
	call GetSRAMBank
	ld de, wMisc
	ld bc, (wMiscEnd - wMisc)
	rst CopyBytes
	call CloseSRAM
	ld a, BANK(sBox)
	call GetSRAMBank
	ld hl, wMisc
	ld de, sBox + (wMiscEnd - wMisc)
	ld bc, (wMiscEnd - wMisc)
	rst CopyBytes
	call CloseSRAM
	pop hl
	pop af
; Load part 3
	ld de, (wMiscEnd - wMisc)
	add hl, de
	call GetSRAMBank
	ld de, wMisc
	ld bc, sBoxEnd - (sBox + (wMiscEnd - wMisc) * 2) ; $8e
	rst CopyBytes
	call CloseSRAM
	ld a, BANK(sBox)
	call GetSRAMBank
	ld hl, wMisc
	ld de, sBox + (wMiscEnd - wMisc) * 2
	ld bc, sBoxEnd - (sBox + (wMiscEnd - wMisc) * 2) ; $8e
	rst CopyBytes
	call CloseSRAM

	pop hl
	ret

EraseBoxes:
	ld hl, BoxAddresses
	ld c, NUM_BOXES
.next
	push bc
	ld a, [hli]
	call GetSRAMBank
	ld a, [hli]
	ld e, a
	ld a, [hli]
	ld d, a
	xor a
	ld [de], a
	inc de
	ld a, -1
	ld [de], a
	inc de
	ld bc, sBoxEnd - (sBox + 2)
.clear
	xor a
	ld [de], a
	inc de
	dec bc
	ld a, b
	or c
	jr nz, .clear
	ld a, [hli]
	ld e, a
	ld a, [hli]
	ld d, a
	ld a, -1
	ld [de], a
	inc de
	xor a
	ld [de], a
	call CloseSRAM
	pop bc
	dec c
	jr nz, .next
	ret

BoxAddresses:
; dbww bank, address, address
	dbww BANK(sBox1),  sBox1,  sBox1End
	dbww BANK(sBox2),  sBox2,  sBox2End
	dbww BANK(sBox3),  sBox3,  sBox3End
	dbww BANK(sBox4),  sBox4,  sBox4End
	dbww BANK(sBox5),  sBox5,  sBox5End
	dbww BANK(sBox6),  sBox6,  sBox6End
	dbww BANK(sBox7),  sBox7,  sBox7End
	dbww BANK(sBox8),  sBox8,  sBox8End
	dbww BANK(sBox9),  sBox9,  sBox9End
	dbww BANK(sBox10), sBox10, sBox10End
	dbww BANK(sBox11), sBox11, sBox11End
	dbww BANK(sBox12), sBox12, sBox12End
	dbww BANK(sBox13), sBox13, sBox13End
	dbww BANK(sBox14), sBox14, sBox14End

Checksum:
	ld de, 0
.loop
	ld a, [hli]
	; de += a
	add e
	ld e, a
	adc d
	sub e
	ld d, a
	dec bc
	ld a, b
	or c
	jr nz, .loop
	ret

WouldYouLikeToSaveTheGameText:
	; Would you like to save the game?
	text_jump _WouldYouLikeToSaveTheGameText
	text_end

SavingDontTurnOffThePowerText:
	; SAVING… DON'T TURN OFF THE POWER.
	text_jump _SavingDontTurnOffThePowerText
	text_end

SavedTheGameText:
	; saved the game.
	text_jump _SavedTheGameText
	text_end

AnotherSaveFileText:
	; There is another save file. Is it OK to overwrite?
	text_jump _AnotherSaveFileText
	text_end

SaveFileCorruptedText:
	; The save file is corrupted!
	text_jump _SaveFileCorruptedText
	text_end

MoveMonWOMailSaveText:
	; Each time you move a #MON, data will be saved. OK?
	text_jump _MoveMonWOMailSaveText
	text_end

UpgradeSaveVersion:
; upgrade older saves to a newer version
	ld a, BANK(sSaveVersion)
	call GetSRAMBank
	ld a, [sSaveVersion]
	ld b, a
	ld a, [sSaveVersion + 1]
	ld c, a
	call CloseSRAM

.version_upgrade_loop
	ld a, b
	cp HIGH(SAVE_VERSION)
	jr nz, .needs_upgrade
	ld a, c
	cp LOW(SAVE_VERSION)
	jr z, .write_current_version
.needs_upgrade
	ld hl, SaveUpgrades
	add hl, bc
	add hl, bc
	ld a, [hli]
	ld h, [hl]
	ld l, a
	push bc
	call _hl_
	call SaveGameData
	pop bc
	inc bc
	jr .version_upgrade_loop
.write_current_version
	ld a, BANK(sSaveVersion)
	call GetSRAMBank
	ld a, b
	ld [sSaveVersion], a
	ld a, c
	ld [sSaveVersion + 1], a
	jp CloseSRAM

SaveUpgrades:
	dw ResetHyperTrainingBits
	assert (@ - SaveUpgrades) == SAVE_VERSION * 2, "Missing save upgrade"
	dw UpgradeStorageSystem

ResetHyperTrainingBits:
	; reset player name
	ld hl, wPlayerName + PLAYER_NAME_LENGTH
	call .ZeroBits

	; reset daycare names
	ld hl, wBreedMon1OT + PLAYER_NAME_LENGTH
	call .ZeroBits
	ld hl, wBreedMon2OT + PLAYER_NAME_LENGTH
	call .ZeroBits

	; reset party names
	ld hl, wPartyMonOT
	ld d, PARTY_LENGTH
	ld bc, PLAYER_NAME_LENGTH
.loop
	add hl, bc
	call .ZeroBits
	dec d
	jr nz, .loop

	; reset Storage System names
	ld a, BANK(sBox1)
	call GetSRAMBank
	call .storage_loop
	ld a, BANK(sBox8)
	call GetSRAMBank
	call .storage_loop
	jp CloseSRAM

.storage_loop
	ld hl, sBox1MonOT
	lb de, MONS_PER_BOX, 7
	ld bc, PLAYER_NAME_LENGTH
.loop2
	add hl, bc
	call .ZeroBits
	dec d
	jr nz, .loop2
	push bc
	ld bc, sBox2MonOT - sBox1MonNicknames
	add hl, bc
	pop bc
	ld d, MONS_PER_BOX
	dec e
	jr nz, .loop2
	ret

.ZeroBits:
	xor a
	ld [hli], a
	ld [hli], a
	ld [hli], a
	ret

UpgradeStorageSystem:
; Upgrades the Storage System to the modern Polished system
	; Normally, we don't care about Pokémon allocation order. However,
	; to preserve Box organization from older saves in this case, we allocate
	; Pokémon entries in the same order as they are in the boxes. The reason is
	; that in case the user decides it's a Good Idea(TM) to reset the game mid-
	; upgrade, we can still preserve the upgrade process fully, which we can't
	; otherwise do since we need to overwrite old data as we go (we don't have
	; the space to store both old and new completely, so sBox is used as backup
	; while we write the new data).

	; Maybe continue where we left off.
.outer_loop
	call GetUpgradePhase
	cp 28
	jr nc, .finalize
	and a
	jr nz, .init_done

	; Clear pokedb usage flags (Safe, the data was previously unused).
	ld a, BANK(sBoxMons1)
	call .clearusedentries
	ld a, BANK(sBoxMons2)
	call .clearusedentries

.init_done
	; Odd phases has already extracted
	ccf
	rra
	jr c, .extraction_done

	; Extract a box to sBox
	ld [wCurBox], a
	call LoadBox
	jp .next_phase

.clearusedentries
	call GetSRAMBank
	ld hl, sBoxMons1UsedEntries
	ld bc, (MONDB_ENTRIES + 7) / 8
	xor a
	rst ByteFill
	ret

.extraction_done
	; Allocate entries for the given box
	; At this point, we know that sBox is complete, so we can safely overwrite
	; its former box data.

	; Check which bank to use.
	ld d, 1
	cp 7
	jr c, .got_pokedb_bank
	sub 7
	inc d
.got_pokedb_bank
	ld b, a
	ld a, -20
	inc b
.entry_loop
	add 20
	dec b
	jr nz, .entry_loop
	ld e, a
	; de contains pokedb bank and entry-1.

	; Figure out how many Pokémon there are in the box.
	ld a, BANK(sBox)
	call GetSRAMBank
	ld a, [sBoxCount]
	ld b, a
	ld c, -1
	inc b
.loop
	inc c
	inc e
	dec b
	jr z, .next_phase

	; Copy the Pokémon to a buffer for use for NewStorageMon
	push bc
	push de
	ld a, BANK(sBox)
	call GetSRAMBank
	ld hl, sBoxMons
	ld a, c
	ld bc, BOXMON_STRUCT_LENGTH
	push af
	rst AddNTimes
	ld de, wBufferMon
	rst CopyBytes

	ld hl, sBoxMonNicknames
	pop af
	push af
	call SkipNames
	ld de, wBufferMonNick
	rst CopyBytes
	ld hl, sBoxMonOT
	pop af
	call SkipNames
	ld de, wBufferMonOT
	rst CopyBytes
	pop de
	farcall _NewStorageMon
	pop bc
	jr .loop

.finalize
	; At this point, we have a complete storage. Write the new box structure.

	; Initializes new boxes
	call InitializeBoxes

	; Populate boxes
	ld d, 1 ; 1-7
	call .do_storage_loop
	inc d ; 8-14
.do_storage_loop
	ld e, 140
.storage_loop
	farcall GetStorageMon
	call nz, .add_to_box
	dec e
	jr nz, .storage_loop
	ret

.add_to_box
	ld a, d
	dec a
	ld b, 0
	jr z, .got_box_half
	ld b, 7
.got_box_half
	ld a, e
	dec a
.box_count_loop
	inc b
	sub 20
	jr nc, .box_count_loop
	add 21
	ld c, a
	farjp SetBoxPointer

.next_phase
	call GetUpgradePhase
	inc a
	call SetUpgradePhase
	jp .outer_loop

GetUpgradePhase:
SetUpgradePhase:
	ret
