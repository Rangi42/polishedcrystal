SaveMenu: ; 14a1a
	call LoadStandardMenuDataHeader
	farcall DisplaySaveInfoOnSave
	call SpeechTextBox
	call UpdateSprites
	farcall SaveMenu_LoadEDTile
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
	call _SavingDontTurnOffThePower
	call ClearWRAMStateAfterSave
	call ExitMenu
	and a
	ret

.refused
	call ExitMenu
	farcall SaveMenu_LoadEDTile
	scf
	ret

SaveAfterLinkTrade: ; 14a58
	call SetWRAMStateForSave
	farcall StageRTCTimeForSave
	call SavePokemonData
	call SaveChecksum
	call SaveBackupPokemonData
	call SaveBackupChecksum
	farcall BackupPartyMonMail
	farcall SaveRTC
	jp ClearWRAMStateAfterSave
; 14a83

ChangeBoxSaveGame: ; 14a83 (5:4a83)
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
;	call SavingDontTurnOffThePower
	call SaveBox
	pop de
	ld a, e
	ld [wCurBox], a
	call LoadBox
	call SavedTheGame
	call ClearWRAMStateAfterSave
	and a
	ret

Link_SaveGame: ; 14ab2
	call AskOverwriteSaveFile
	ret c
	call SetWRAMStateForSave
	call _SavingDontTurnOffThePower
	call ClearWRAMStateAfterSave
	and a
	ret
; 14ac2

MovePkmnWOMail_SaveGame: ; 14ac2
	call SetWRAMStateForSave
	push de
	call SaveBox
	pop de
	ld a, e
	ld [wCurBox], a
	call LoadBox
	jp ClearWRAMStateAfterSave
; 14ad5

MovePkmnWOMail_InsertMon_SaveGame: ; 14ad5
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
	call PlaySFX
	ld c, 24
	jp DelayFrames
; 14b34

StartMovePkmnWOMail_SaveGame: ; 14b34
	ld hl, UnknownText_0x152a6
	call MenuTextBox
	call YesNoBox
	call ExitMenu
	jr c, .refused
	call AskOverwriteSaveFile
	jr c, .refused
	call SetWRAMStateForSave
	call _SavingDontTurnOffThePower
	call ClearWRAMStateAfterSave
	and a
	ret

.refused
	scf
	ret
; 14b54

SetWRAMStateForSave: ; 14b54
	ld a, $1
	ld [wGameLogicPaused], a
	ret
; 14b5a

ClearWRAMStateAfterSave: ; 14b5a
	xor a
	ld [wGameLogicPaused], a
	ret
; 14b5f

AddHallOfFameEntry: ; 14b5f
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
	ld hl, OverworldMap
	ld de, sHallOfFame
	ld bc, HOF_LENGTH
	call CopyBytes
	jp CloseSRAM
; 14b85

AskOverwriteSaveFile: ; 14b89
	ld a, [wSaveFileExists]
	and a
	jr nz, .ok
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
	call ErasePreviousSave
.ok
	and a
	ret

.refused
	scf
	ret
; 14baf

CompareLoadedAndSavedPlayerID: ; 14bcb
	ld a, BANK(sPlayerData)
	call GetSRAMBank
	ld hl, sPlayerData + (PlayerID - wPlayerData)
	ld a, [hli]
	ld c, [hl]
	ld b, a
	call CloseSRAM
	ld a, [PlayerID]
	cp b
	ret nz
	ld a, [PlayerID + 1]
	cp c
	ret
; 14be3

_SavingDontTurnOffThePower: ; 14be3
;	call SavingDontTurnOffThePower
SavedTheGame: ; 14be6
	call SaveGameData
;	; wait 32 frames
;	ld c, $20
;	call DelayFrames
;	; copy the original text speed setting to the stack
;	ld a, [Options1]
;	push af
;	; set text speed super slow
;	ld a, $3
;	ld [Options1], a
	; <PLAYER> saved the game!
	ld hl, UnknownText_0x1528d
	call PrintText
;	; restore the original text speed setting
;	pop af
;	ld [Options1], a
	ld de, SFX_SAVE
	call WaitPlaySFX
	call WaitSFX
;	; wait 30 frames
;	ld c, $1e
;	call DelayFrames
	ret
; 14c10


SaveGameData:: ; 14c10
	ld a, [hVBlank]
	push af
	ld a, 2
	ld [hVBlank], a
	dec a ; ld a, 1
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
	ld [hVBlank], a
	ret
; 14c6b

;SavingDontTurnOffThePower: ; 14c99
;	; Prevent joypad interrupts
;	xor a
;	ld [hJoypadReleased], a
;	ld [hJoypadPressed], a
;	ld [hJoypadSum], a
;	ld [hJoypadDown], a
;;	; Save the text speed setting to the stack
;;	ld a, [Options1]
;;	push af
;;	; Set the text speed to super slow
;;	ld a, $3
;;	ld [Options1], a
;	; SAVING... DON'T TURN OFF THE POWER.
;	ld hl, UnknownText_0x15288
;	call PrintText
;;	; Restore the text speed setting
;;	pop af
;;	ld [Options1], a
;;	; Wait for 16 frames
;;	ld c, $10
;;	call DelayFrames
;	ret
;; 14cbb


ErasePreviousSave: ; 14cbb
	call EraseBoxes
	call EraseHallOfFame
	call EraseLinkBattleStats
	call EraseBattleTowerStatus
	ld a, $1
	ld [wSavedAtLeastOnce], a
	ret
; 14ce2

EraseLinkBattleStats: ; 14ce2
	ld a, BANK(sLinkBattleStats)
	call GetSRAMBank
	ld hl, sLinkBattleStats
	ld bc, sLinkBattleStatsEnd - sLinkBattleStats
	xor a
	call ByteFill
	jp CloseSRAM
; 14cf4

EraseHallOfFame: ; 14d06
	ld a, BANK(sHallOfFame)
	call GetSRAMBank
	ld hl, sHallOfFame
	ld bc, sHallOfFameEnd - sHallOfFame
	xor a
	call ByteFill
	jp CloseSRAM
; 14d18

EraseBattleTowerStatus: ; 14d5c
	ld a, BANK(sBattleTowerChallengeState)
	call GetSRAMBank
	xor a
	ld [sBattleTowerChallengeState], a
	jp CloseSRAM
; 14d68

HallOfFame_InitSaveIfNeeded: ; 14da0
	ld a, [wSavedAtLeastOnce]
	and a
	ret nz
	jp ErasePreviousSave
; 14da9

ValidateSave: ; 14da9
	ld a, BANK(sCheckValue1)
	call GetSRAMBank
	ld a, SAVE_CHECK_VALUE_1
	ld [sCheckValue1], a
	ld a, SAVE_CHECK_VALUE_2
	ld [sCheckValue2], a
	jp CloseSRAM
; 14dbb

SaveOptions: ; 14dbb
	ld a, BANK(sOptions)
	call GetSRAMBank
	ld hl, Options1
	ld de, sOptions
	ld bc, OptionsEnd - Options1
	call CopyBytes
	ld a, [Options1]
	and $ff ^ (1 << NO_TEXT_SCROLL)
	ld [sOptions], a
	jp CloseSRAM
; 14dd7

SavePlayerData: ; 14dd7
	ld a, BANK(sPlayerData)
	call GetSRAMBank
	ld hl, wPlayerData
	ld de, sPlayerData
	ld bc, wPlayerDataEnd - wPlayerData
	call CopyBytes
	ld hl, wMapData
	ld de, sMapData
	ld bc, wMapDataEnd - wMapData
	call CopyBytes
	jp CloseSRAM
; 14df7

SavePokemonData: ; 14df7
	ld a, BANK(sPokemonData)
	call GetSRAMBank
	ld hl, wPokemonData
	ld de, sPokemonData
	ld bc, wPokemonDataEnd - wPokemonData
	call CopyBytes
	jp CloseSRAM
; 14e0c

SaveBox: ; 14e0c
	call GetBoxAddress
	jp SaveBoxAddress
; 14e13

SaveChecksum: ; 14e13
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
; 14e2d

ValidateBackupSave: ; 14e2d
	ld a, BANK(sBackupCheckValue1)
	call GetSRAMBank
	ld a, SAVE_CHECK_VALUE_1
	ld [sBackupCheckValue1], a
	ld a, SAVE_CHECK_VALUE_2
	ld [sBackupCheckValue2], a
	jp CloseSRAM
; 14e40

SaveBackupOptions: ; 14e40
	ld a, BANK(sBackupOptions)
	call GetSRAMBank
	ld hl, Options1
	ld de, sBackupOptions
	ld bc, OptionsEnd - Options1
	call CopyBytes
	jp CloseSRAM
; 14e55

SaveBackupPlayerData: ; 14e55
	ld a, BANK(sBackupPlayerData)
	call GetSRAMBank
	ld hl, wPlayerData
	ld de, sBackupPlayerData
	ld bc, wPlayerDataEnd - wPlayerData
	call CopyBytes
	ld hl, wMapData
	ld de, sBackupMapData
	ld bc, wMapDataEnd - wMapData
	call CopyBytes
	jp CloseSRAM
; 14e76

SaveBackupPokemonData: ; 14e76
	ld a, BANK(sBackupPokemonData)
	call GetSRAMBank
	ld hl, wPokemonData
	ld de, sBackupPokemonData
	ld bc, wPokemonDataEnd - wPokemonData
	call CopyBytes
	jp CloseSRAM
; 14e8b

SaveBackupChecksum: ; 14e8b
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
; 14ea5


TryLoadSaveFile: ; 14ea5 (5:4ea5)
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
	ld a, [Options1]
	push af
	set NO_TEXT_SCROLL, a
	ld [Options1], a
	ld hl, UnknownText_0x1529c
	call PrintText
	pop af
	ld [Options1], a
	scf
	ret


TryLoadSaveData: ; 14f1c
	xor a
	ld [wSaveFileExists], a
	call CheckPrimarySaveFile
	ld a, [wSaveFileExists]
	and a
	jr z, .backup

	ld a, BANK(sPlayerData)
	call GetSRAMBank
	ld hl, sPlayerData + StartDay - wPlayerData
	ld de, StartDay
	ld bc, 8
	call CopyBytes
	ld hl, sPlayerData + StatusFlags - wPlayerData
	ld de, StatusFlags
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
	ld hl, sBackupPlayerData + StartDay - wPlayerData
	ld de, StartDay
	ld bc, 8
	call CopyBytes
	ld hl, sBackupPlayerData + StatusFlags - wPlayerData
	ld de, StatusFlags
	ld a, [hl]
	ld [de], a
	jp CloseSRAM

.corrupt
	ld hl, DefaultOptions
	ld de, Options1
	ld bc, OptionsEnd - Options1
	call CopyBytes
	jp PanicResetClock
; 14f7c

INCLUDE "data/default_options.asm"

CheckPrimarySaveFile: ; 14f84
	ld a, BANK(sCheckValue1)
	call GetSRAMBank
	ld a, [sCheckValue1]
	cp SAVE_CHECK_VALUE_1
	jr nz, .nope
	ld a, [sCheckValue2]
	cp SAVE_CHECK_VALUE_2
	jr nz, .nope
	ld hl, sOptions
	ld de, Options1
	ld bc, OptionsEnd - Options1
	call CopyBytes
	call CloseSRAM
	ld a, $1
	ld [wSaveFileExists], a

.nope
	jp CloseSRAM
; 14faf

CheckBackupSaveFile: ; 14faf
	ld a, BANK(sBackupCheckValue1)
	call GetSRAMBank
	ld a, [sBackupCheckValue1]
	cp SAVE_CHECK_VALUE_1
	jr nz, .nope
	ld a, [sBackupCheckValue2]
	cp SAVE_CHECK_VALUE_2
	jr nz, .nope
	ld hl, sBackupOptions
	ld de, Options1
	ld bc, OptionsEnd - Options1
	call CopyBytes
	ld a, $2
	ld [wSaveFileExists], a

.nope
	jp CloseSRAM
; 14fd7


LoadPlayerData: ; 14fd7 (5:4fd7)
	ld a, BANK(sPlayerData)
	call GetSRAMBank
	ld hl, sPlayerData
	ld de, wPlayerData
	ld bc, wPlayerDataEnd - wPlayerData
	call CopyBytes
	ld hl, sMapData
	ld de, wMapData
	ld bc, wMapDataEnd - wMapData
	call CopyBytes
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

LoadPokemonData: ; 1500c
	ld a, BANK(sPokemonData)
	call GetSRAMBank
	ld hl, sPokemonData
	ld de, wPokemonData
	ld bc, wPokemonDataEnd - wPokemonData
	call CopyBytes
	jp CloseSRAM
; 15021

LoadBox: ; 15021 (5:5021)
	call GetBoxAddress
	jp LoadBoxAddress

VerifyChecksum: ; 15028 (5:5028)
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

LoadBackupPlayerData: ; 15046 (5:5046)
	ld a, BANK(sBackupPlayerData)
	call GetSRAMBank
	ld hl, sBackupPlayerData
	ld de, wPlayerData
	ld bc, wPlayerDataEnd - wPlayerData
	call CopyBytes
	ld hl, sBackupMapData
	ld de, wMapData
	ld bc, wMapDataEnd - wMapData
	call CopyBytes
	jp CloseSRAM

LoadBackupPokemonData: ; 15067 (5:5067)
	ld a, BANK(sBackupPokemonData)
	call GetSRAMBank
	ld hl, sBackupPokemonData
	ld de, wPokemonData
	ld bc, wPokemonDataEnd - wPokemonData
	call CopyBytes
	jp CloseSRAM

VerifyBackupChecksum: ; 1507c (5:507c)
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


GetBoxAddress: ; 150d8
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
; 150f9

SaveBoxAddress: ; 150f9
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
	call CopyBytes
	call CloseSRAM
	pop de
	pop af
; Save it to the target box.
	push af
	push de
	call GetSRAMBank
	ld hl, wMisc
	ld bc, (wMiscEnd - wMisc)
	call CopyBytes
	call CloseSRAM

; Load the second part of the active box.
	ld a, BANK(sBox)
	call GetSRAMBank
	ld hl, sBox + (wMiscEnd - wMisc)
	ld de, wMisc
	ld bc, (wMiscEnd - wMisc)
	call CopyBytes
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
	call CopyBytes
	call CloseSRAM

; Load the third and final part of the active box.
	ld a, BANK(sBox)
	call GetSRAMBank
	ld hl, sBox + (wMiscEnd - wMisc) * 2
	ld de, wMisc
	ld bc, sBoxEnd - (sBox + (wMiscEnd - wMisc) * 2) ; $8e
	call CopyBytes
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
	call CopyBytes
	call CloseSRAM

	pop hl
	ret
; 1517d


LoadBoxAddress: ; 1517d (5:517d)
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
	call CopyBytes
	call CloseSRAM
	ld a, BANK(sBox)
	call GetSRAMBank
	ld hl, wMisc
	ld de, sBox
	ld bc, (wMiscEnd - wMisc)
	call CopyBytes
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
	call CopyBytes
	call CloseSRAM
	ld a, BANK(sBox)
	call GetSRAMBank
	ld hl, wMisc
	ld de, sBox + (wMiscEnd - wMisc)
	ld bc, (wMiscEnd - wMisc)
	call CopyBytes
	call CloseSRAM
	pop hl
	pop af
; Load part 3
	ld de, (wMiscEnd - wMisc)
	add hl, de
	call GetSRAMBank
	ld de, wMisc
	ld bc, sBoxEnd - (sBox + (wMiscEnd - wMisc) * 2) ; $8e
	call CopyBytes
	call CloseSRAM
	ld a, BANK(sBox)
	call GetSRAMBank
	ld hl, wMisc
	ld de, sBox + (wMiscEnd - wMisc) * 2
	ld bc, sBoxEnd - (sBox + (wMiscEnd - wMisc) * 2) ; $8e
	call CopyBytes
	call CloseSRAM

	pop hl
	ret


EraseBoxes: ; 151fb
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
; 1522d

BoxAddresses: ; 1522d
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
; 15273


Checksum: ; 15273
	ld de, 0
.loop
	ld a, [hli]
	add e
	ld e, a
	ld a, 0 ; not xor a; preserve carry flag?
	adc d
	ld d, a
	dec bc
	ld a, b
	or c
	jr nz, .loop
	ret
; 15283


UnknownText_0x15283: ; 0x15283
	; Would you like to save the game?
	text_jump UnknownText_0x1c454b
	db "@"
; 0x15288

UnknownText_0x15288: ; 0x15288
	; SAVING… DON'T TURN OFF THE POWER.
	text_jump UnknownText_0x1c456d
	db "@"
; 0x1528d

UnknownText_0x1528d: ; 0x1528d
	; saved the game.
	text_jump UnknownText_0x1c4590
	db "@"
; 0x15292

UnknownText_0x15297: ; 0x15297
	; There is another save file. Is it OK to overwrite?
	text_jump UnknownText_0x1c45d9
	db "@"
; 0x1529c

UnknownText_0x1529c: ; 0x1529c
	; The save file is corrupted!
	text_jump UnknownText_0x1c460d
	db "@"
; 0x152a1

UnknownText_0x152a1: ; 0x152a1
	; When you change a #MON BOX, data will be saved. OK?
	text_jump UnknownText_0x1c462a
	db "@"
; 0x152a6

UnknownText_0x152a6: ; 0x152a6
	; Each time you move a #MON, data will be saved. OK?
	text_jump UnknownText_0x1c465f
	db "@"
; 0x152ab
