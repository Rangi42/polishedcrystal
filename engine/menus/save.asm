SaveMenu:
	ld c, 4
	call SFXDelayFrames
	call LoadStandardMenuDataHeader
	farcall DisplaySaveInfoOnSave
	call SpeechTextBox
	call UpdateSprites
	call ApplyTilemap
	ld hl, UnknownText_0x15283
	ld b, BANK(UnknownText_0x15283)
	call MapTextbox
	call LoadMenuTextBox
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

ChangeBoxSaveGame:
	push de
	ld hl, UnknownText_0x152a1
	call MenuTextBox
	call YesNoBox
	call ExitMenu
	jr c, .refused
	call AskOverwriteSaveFile
	jr c, .refused
	jr nc, SaveAndChangeBox
.refused
	pop de
	ret

ChangeBoxSaveGameNoConfirm:
	push de
SaveAndChangeBox:
	call SetWRAMStateForSave
	call SaveBox
	pop de
	ld a, e
	ld [wCurBox], a
	call LoadBox
	call SavedTheGame
	call ClearWRAMStateAfterSave
	and a
	ret

Link_SaveGame:
	call AskOverwriteSaveFile
	ret c
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
	ld hl, UnknownText_0x152a6
	call MenuTextBox
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
	ld hl, wOverworldMap
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
	ld hl, UnknownText_0x15297
	ld b, BANK(UnknownText_0x15297)
	call MapTextbox
	call LoadMenuTextBox
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
	ld hl, UnknownText_0x1528d
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
	call SaveChecksum
	call ValidateBackupSave
	call SaveBackupOptions
	call SaveBackupPlayerData
	call SaveBackupPokemonData
	call SaveBackupChecksum
	farcall BackupPartyMonMail
	farcall SaveRTC
	ld a, BANK(sBattleTowerChallengeState)
	call GetSRAMBank
	ld a, [sBattleTowerChallengeState]
	cp BATTLETOWER_RECEIVED_REWARD
	jr nz, .ok
	xor a
	ld [sBattleTowerChallengeState], a
.ok
	call CloseSRAM
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
	ld hl, wMapData
	ld de, sMapData
	ld bc, wMapDataEnd - wMapData
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
	ld hl, wMapData
	ld de, sBackupMapData
	ld bc, wMapDataEnd - wMapData
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
	ld hl, UnknownText_0x1529c
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
	ld de, wMapData
	ld bc, wMapDataEnd - wMapData
	rst CopyBytes
	call CloseSRAM
	ld a, BANK(sBattleTowerChallengeState)
	call GetSRAMBank
	ld a, [sBattleTowerChallengeState]
	cp BATTLETOWER_RECEIVED_REWARD
	jr nz, .not_4
	ld a, BATTLETOWER_WON_CHALLENGE
	ld [sBattleTowerChallengeState], a
.not_4
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
	ld de, wMapData
	ld bc, wMapDataEnd - wMapData
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

UnknownText_0x15283:
	; Would you like to save the game?
	text_jump UnknownText_0x1c454b
	text_end

UnknownText_0x15288:
	; SAVING… DON'T TURN OFF THE POWER.
	text_jump UnknownText_0x1c456d
	text_end

UnknownText_0x1528d:
	; saved the game.
	text_jump UnknownText_0x1c4590
	text_end

UnknownText_0x15297:
	; There is another save file. Is it OK to overwrite?
	text_jump UnknownText_0x1c45d9
	text_end

UnknownText_0x1529c:
	; The save file is corrupted!
	text_jump UnknownText_0x1c460d
	text_end

UnknownText_0x152a1:
	; When you change a #MON BOX, data will be saved. OK?
	text_jump UnknownText_0x1c462a
	text_end

UnknownText_0x152a6:
	; Each time you move a #MON, data will be saved. OK?
	text_jump UnknownText_0x1c465f
	text_end
