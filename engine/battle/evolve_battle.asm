EvolveDuringBattle::
	ld a, MON_SPECIES
	call GetPartyParamLocationAndValue
	ld [wEvolutionOldSpecies], a
	ld bc, MON_FORM - MON_SPECIES
	add hl, bc
	ld a, [hl]
	ld [wEvolutionOldForm], a

	ld a, BANK("Sound Stack")
	ldh [rSVBK], a
	ld hl, wSoundEngineBackup
	ld de, wSoundEngineBattleBackup
	ld bc, wChannelsEnd - wMusic + 1
	rst CopyBytes
	ld a, [wMapMusic]
	ld [wBackupMapMusic], a
	di
	ld hl, wMusic
	ld de, wSoundEngineBackup
	ld bc, wChannelsEnd - wMusic
	rst CopyBytes
	ei
	ld a, $1
	ldh [rSVBK], a

	farcall CheckHowToEvolve
	ret z

	farcall TryToEvolve
	jr c, .canceled

	ld hl, wPartyMon1Species
	ld a, [wCurPartyMon]
	call GetPartyLocation
	push hl
	ld de, wBattleMonSpecies
	ld a, [hli]
	ld [de], a ; copy Species
	ld [wCurSpecies], a
	ld [wCurPartySpecies], a
	ld [wTempBattleMonSpecies], a
	inc hl ; skip Item
	inc de
	inc de
	ld bc, MON_ID - MON_MOVES
	rst CopyBytes ; copy Moves
	ld bc, MON_DVS - MON_ID
	add hl, bc ; skip ID, Exp, EVs
	ld de, wBattleMonDVs
	ld bc, MON_PP - MON_DVS
	rst CopyBytes ; copy DVs, Personality
	ld bc, MON_LEVEL - MON_PP
	add hl, bc ; skip PP, Happiness, PokerusStatus, CaughtData
	ld de, wBattleMonLevel
	ld bc, PARTYMON_STRUCT_LENGTH - MON_LEVEL
	rst CopyBytes ; copy Level, Status, Unused, HP, MaxHP, Stats
	pop hl

	ld bc, MON_FORM - MON_SPECIES
	add hl, bc
	ld a, [hl]
	ld [wCurForm], a
	ld [wTempBattleMonForm], a

	push de
	call GetBaseData
	ld hl, wBaseType1
	ld de, wBattleMonType1
	ld bc, 2
	rst CopyBytes
	pop de

	ld hl, wPartyMonNicknames
	ld a, [wCurPartyMon]
	call SkipNames
	ld de, wBattleMonNickname
	ld bc, MON_NAME_LENGTH
	rst CopyBytes

	call ResetPlayerAbility

	jr .done

.canceled
	farcall CancelEvolution

.done
	ld a, BANK("Sound Stack")
	ldh [rSVBK], a
	ld a, [wBackupMapMusic]
	ld [wMapMusic], a
	di
	ld hl, wSoundEngineBackup
	ld de, wMusic
	ld bc, wChannelsEnd - wMusic
	rst CopyBytes
	ei
	ld hl, wSoundEngineBattleBackup
	ld de, wSoundEngineBackup
	ld bc, wChannelsEnd - wMusic + 1
	rst CopyBytes
	ld a, $1
	ldh [rSVBK], a

	ret
