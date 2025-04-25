Special::
; Run script special de.
	ld hl, SpecialsPointers
	add hl, de
	add hl, de
	add hl, de
	ld a, [hli]
	ld b, a
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, b
	jmp FarCall_hl

INCLUDE "data/events/special_pointers.asm"

Special_GameCornerPrizeMonCheckDex:
	ldh a, [hScriptVar]
	ld c, a
	ldh a, [hScriptVar+1]
	ld b, a
	push bc
	call CheckCosmeticCaughtMon
	pop bc
	ret nz
	call SetSeenAndCaughtMon
	call FadeToMenu_BackupSprites
	ld hl, wNamedObjectIndex
	ldh a, [hScriptVar]
	ld [hli], a
	ldh a, [hScriptVar+1]
	ld [hl], a
	farcall NewPokedexEntry
	jmp ExitAllMenus

SpecialSeenMon:
	ldh a, [hScriptVar]
	ld c, a
	ldh a, [hScriptVar+1]
	ld b, a
	jmp SetSeenMon

Special_FindThatSpecies:
	ldh a, [hScriptVar]
	ld c, a
	ldh a, [hScriptVar+1]
	ld b, a
	push de ; being cautious
	farcall FindThatSpecies
	pop de
	jr z, FoundNone
	jr FoundOne

Special_FindThatSpeciesYourTrainerID:
	ldh a, [hScriptVar]
	ld c, a
	ldh a, [hScriptVar+1]
	ld b, a
	push de
	farcall _FindThatSpeciesYourTrainerID
	pop de
	jr z, FoundNone
	; fallthrough

FoundOne:
	ld a, TRUE
	ldh [hScriptVar], a
	ret

FoundNone:
	xor a
	ldh [hScriptVar], a
	ret

SpecialNameRival:
	ld b, $2 ; rival
	ld de, wRivalName
	farcall _NamingScreen
	; default to "Silver"
	ld hl, wRivalName
	ld de, .DefaultRivalName
	jmp InitName

.DefaultRivalName:
	rawchar "Silver@"

SpecialTrendyPhrase:
	ld b, $3 ; trendy phrase
	ld de, wTrendyPhrase
	farcall _NamingScreen
	; default to "Nothing"
	ld hl, wTrendyPhrase
	ld de, .DefaultTrendyPhrase
	jmp InitName

.DefaultTrendyPhrase:
	rawchar "Nothing@"

SpecialNameRater:
	farjp NameRater

Special_TownMap:
	call FadeToMenu_BackupSprites
	farcall _TownMap
	jmp ExitAllMenus

Special_DisplayLinkRecord:
	call FadeToMenu_BackupSprites
	farcall DisplayLinkRecord
	jmp ExitAllMenus

Special_PlayersHousePC:
	xor a
	ldh [hScriptVar], a
	farcall _PlayersHousePC
	ld a, c
	ldh [hScriptVar], a
	ret

BugContestJudging:
	farcall _BugContestJudging
	ld a, b
	ldh [hScriptVar], a
	dec a
	jr z, .firstplace
	dec a
	jr z, .secondplace
	dec a
	jr z, .thirdplace
	ld a, SHED_SHELL
	jr .finish
.firstplace
	ld hl, .FirstPlacePrizes
	call GetValueByTimeOfDay
	jr .finish
.secondplace
	ld a, EVERSTONE
	jr .finish
.thirdplace
	ld a, SITRUS_BERRY
.finish
	ld [wBugContestOfficerPrize], a
	ret

.FirstPlacePrizes:
	db SHINY_STONE ; morn
	db SUN_STONE   ; day
	db DUSK_STONE  ; eve
	db MOON_STONE  ; nite

MapRadio:
	ldh a, [hScriptVar]
	ld e, a
	farjp PlayRadio

Special_UnownPuzzle:
	call FadeToMenu_BackupSprites
	farcall UnownPuzzle
	ld a, [wSolvedUnownPuzzle]
	ldh [hScriptVar], a
	jmp ExitAllMenus

Special_SlotMachine:
	call Special_CheckCoins
	ret c
	ld a, BANK(_SlotMachine)
	ld hl, _SlotMachine
	jr Special_StartGameCornerGame

Special_CardFlip:
	call Special_CheckCoins
	ret c
	ld a, BANK(_CardFlip)
	ld hl, _CardFlip
	; fallthrough

;Special_UnusedMemoryGame:
;	call Special_CheckCoins
;	ret c
;	ld a, BANK(_MemoryGame)
;	ld hl, _MemoryGame
;	call Special_StartGameCornerGame
;	ret

Special_StartGameCornerGame:
	call FarQueueScript
	call FadeToMenu_BackupSprites
	ld hl, wQueuedScriptBank
	ld a, [hli]
	push af
	ld a, [hli]
	ld h, [hl]
	ld l, a
	pop af
	call FarCall_hl
	jmp ExitAllMenus

Special_CheckCoins:
	ld hl, wCoins
	ld a, [hli]
	or [hl]
	jr z, .no_coins
	ld a, COIN_CASE
	ld [wCurKeyItem], a
	call CheckKeyItem
	jr nc, .no_coin_case
	and a
	ret

.no_coins
	ld hl, .NoCoinsText
	jr .print

.no_coin_case
	ld hl, .NoCoinCaseText

.print
	call PrintText
	scf
	ret

.NoCoinsText:
	; You have no coins.
	text_far _NoCoinsText
	text_end

.NoCoinCaseText:
	; You don't have a COIN CASE.
	text_far _NoCoinCaseText
	text_end

Special_CheckLuckyNumberShowFlag:
	ld hl, wLuckyNumberShowFlag
	bit LUCKYNUMBERSHOW_GAME_OVER_F, [hl]
	ret

SpecialCheckPokerus:
; Check if a monster in your party has Pokerus
	farcall CheckPokerus
	; a = carry ? TRUE : FALSE
	sbc a
	and TRUE
	ldh [hScriptVar], a
	ret

Special_ActivateFishingSwarm:
	ldh a, [hScriptVar]
	ld [wFishingSwarmFlag], a
	ret

StoreSwarmMapIndices::
	ld a, c
	and a
	jr nz, .yanma
; swarm dark cave violet entrance
	ld a, d
	ld [wDunsparceMapGroup], a
	ld a, e
	ld [wDunsparceMapNumber], a
	ret

.yanma
	ld a, d
	ld [wYanmaMapGroup], a
	ld a, e
	ld [wYanmaMapNumber], a
	ret

Special_ResetLuckyNumberShowFlag:
	farjp LoadOrRegenerateLuckyIDNumber

SpecialSnorlaxAwake:
; Check if the Poké Flute channel is playing.

; outputs:
; hScriptVar is 1 if the conditions are met, otherwise 0.

; check background music
	ld a, [wMapMusic]
	cp MUSIC_POKE_FLUTE_CHANNEL
	ld a, TRUE
	jr z, .done
	xor a ; ld a, FALSE
.done
	ldh [hScriptVar], a
	ret

PlayCurMonCry:
	ld a, [wCurPartySpecies]
	ld c, a
	ld a, [wCurForm]
	ld b, a
	jmp PlayMonCry

Special_FadeOutMusic:
	xor a ; MUSIC_NONE
	ld [wMusicFadeIDLo], a
	ld [wMusicFadeIDHi], a
	ld a, $2
	ld [wMusicFade], a
	ret

Diploma:
	call FadeToMenu_BackupSprites
	farcall _Diploma
	jmp ExitAllMenus

PrintDiploma:
	call FadeToMenu_BackupSprites
	farcall _PrintDiploma
	jmp ExitAllMenus

Special_GetOvercastIndex::
	call GetOvercastIndex
	ldh [hScriptVar], a
	ret

CheckIfTrendyPhraseIsLucky:
	xor a
	ldh [hScriptVar], a
	ld hl, wTrendyPhrase
	ld bc, .KeyPhrase
	ld d, 6
.loop
	ld a, [bc]
	ld e, a
	ld a, [hli]
	cp e
	ret nz
	inc bc
	dec d
	jr nz, .loop
	ld a, 1
	ldh [hScriptVar], a
	ret

.KeyPhrase:
	rawchar "Lucky@"

RespawnOneOffs:
	eventflagreset EVENT_BEAT_FLANNERY
	eventflagreset EVENT_BEAT_KATY
	eventflagreset EVENT_BEAT_KUKUI
	eventflagreset EVENT_BEAT_LAWRENCE
	eventflagreset EVENT_BEAT_MARLON_AGAIN
	eventflagreset EVENT_BEAT_MAYLENE
	eventflagreset EVENT_BEAT_PIERS_AGAIN

	eventflagcheck EVENT_GOT_MUSCLE_BAND_FROM_STEVEN
	jr z, .SkipSteven
	eventflagset EVENT_EMBEDDED_TOWER_STEVEN_1
	eventflagreset EVENT_EMBEDDED_TOWER_STEVEN_2
	eventflagreset EVENT_BEAT_STEVEN
.SkipSteven

	eventflagcheck EVENT_GOT_WISE_GLASSES_FROM_CYNTHIA
	jr z, .SkipCynthia
	eventflagset EVENT_MYSTRI_STAGE_CYNTHIA
	eventflagreset EVENT_SINJOH_RUINS_HOUSE_CYNTHIA
	eventflagreset EVENT_BEAT_CYNTHIA
.SkipCynthia

	; Set CHECK_FLAG once to be used multiple times
	ld b, CHECK_FLAG
	ld de, ENGINE_PLAYER_CAUGHT_SUDOWOODO
	farcall EngineFlagAction
	jr nz, .CaughtSudowoodo
	eventflagreset EVENT_ROUTE_36_SUDOWOODO
.CaughtSudowoodo

	ld de, ENGINE_PLAYER_CAUGHT_BLOODMOON_URSALUNA
	farcall EngineFlagAction
	jr nz, .CaughtBloodmoonUrsaluna
	eventflagreset EVENT_MURKY_SWAMP_BLOODMOON_URSALUNA
.CaughtBloodmoonUrsaluna

	ld de, ENGINE_PLAYER_CAUGHT_ARTICUNO
	farcall EngineFlagAction
	jr nz, .CaughtArticuno
	eventflagreset EVENT_SEAFOAM_ISLANDS_ARTICUNO
.CaughtArticuno

	ld de, ENGINE_PLAYER_CAUGHT_ZAPDOS
	farcall EngineFlagAction
	jr nz, .CaughtZapdos
	eventflagreset EVENT_ROUTE_10_ZAPDOS
	eventflagreset EVENT_ZAPDOS_GONE
.CaughtZapdos

	ld de, ENGINE_PLAYER_CAUGHT_MOLTRES
	farcall EngineFlagAction
	jr nz, .CaughtMoltres
	eventflagreset EVENT_CINNABAR_VOLCANO_MOLTRES
.CaughtMoltres

	ld de, ENGINE_PLAYER_CAUGHT_MEWTWO
	farcall EngineFlagAction
	jr nz, .CaughtMewtwo
	eventflagreset EVENT_CERULEAN_CAVE_MEWTWO
.CaughtMewtwo

	ld de, ENGINE_PLAYER_CAUGHT_MEW
	farcall EngineFlagAction
	jr nz, .CaughtMew
	eventflagreset EVENT_FARAWAY_JUNGLE_MEW
.CaughtMew

	ld de, ENGINE_PLAYER_CAUGHT_RAIKOU
	farcall EngineFlagAction
	jr nz, .CaughtRaikou
	ld hl, wRoamMon1Species
	ld a, [hl]
	and a
	call z, RespawnRoamingRaikou
.CaughtRaikou

	ld de, ENGINE_PLAYER_CAUGHT_ENTEI
	farcall EngineFlagAction
	jr nz, .CaughtEntei
	ld hl, wRoamMon2Species
	ld a, [hl]
	and a
	call z, RespawnRoamingEntei
.CaughtEntei

	eventflagcheck EVENT_FOUGHT_SUICUNE
	jr z, .CaughtOrNeverFoughtSuicune
	ld de, ENGINE_PLAYER_CAUGHT_SUICUNE
	farcall EngineFlagAction
	jr nz, .CaughtOrNeverFoughtSuicune
	ld hl, wRoamMon3Species
	ld a, [hl]
	and a
	call z, RespawnRoamingSuicune
.CaughtOrNeverFoughtSuicune

	ld de, ENGINE_PLAYER_CAUGHT_LUGIA
	farcall EngineFlagAction
	jr nz, .CaughtLugia
	eventflagreset EVENT_WHIRL_ISLAND_LUGIA_CHAMBER_LUGIA
	eventflagreset EVENT_FOUGHT_LUGIA
.CaughtLugia

	ld de, ENGINE_PLAYER_CAUGHT_HO_OH
	farcall EngineFlagAction
	jr nz, .CaughtHoOh
	eventflagreset EVENT_TIN_TOWER_ROOF_HO_OH
	eventflagreset EVENT_FOUGHT_HO_OH
	eventflagreset EVENT_EUSINES_HOUSE_EUSINE
.CaughtHoOh

	ld de, ENGINE_PLAYER_CAUGHT_GALARIAN_ARTICUNO
	farcall EngineFlagAction
	jr nz, .CaughtGalarianArticuno
	eventflagreset EVENT_CHERRYGROVE_BAY_FOUGHT_GALARIAN_ARTICUNO
.CaughtGalarianArticuno

	ld de, ENGINE_PLAYER_CAUGHT_GALARIAN_ZAPDOS
	farcall EngineFlagAction
	jr nz, .CaughtGalarianZapdos
	eventflagreset EVENT_CHERRYGROVE_BAY_FOUGHT_GALARIAN_ZAPDOS
.CaughtGalarianZapdos

	ld de, ENGINE_PLAYER_CAUGHT_GALARIAN_MOLTRES
	farcall EngineFlagAction
	ret nz
	eventflagreset EVENT_CHERRYGROVE_BAY_FOUGHT_GALARIAN_MOLTRES
	ret

RespawnRoamingRaikou:
	ld a, RAIKOU
	ld [wRoamMon1Species], a
	ld a, 50
	ld [wRoamMon1Level], a
	ld a, GROUP_ROUTE_42
	ld [wRoamMon1MapGroup], a
	ld a, MAP_ROUTE_42
	ld [wRoamMon1MapNumber], a
	xor a ; generate new stats
	ld [wRoamMon1HP], a
	ret

RespawnRoamingEntei:
	ld a, ENTEI
	ld [wRoamMon2Species], a
	ld a, 50
	ld [wRoamMon2Level], a
	ld a, GROUP_ROUTE_37
	ld [wRoamMon2MapGroup], a
	ld a, MAP_ROUTE_37
	ld [wRoamMon2MapNumber], a
	xor a ; generate new stats
	ld [wRoamMon2HP], a
	ret

RespawnRoamingSuicune:
	ld a, SUICUNE
	ld [wRoamMon3Species], a
	ld a, 50
	ld [wRoamMon3Level], a
	ld a, GROUP_ROUTE_38
	ld [wRoamMon3MapGroup], a
	ld a, MAP_ROUTE_38
	ld [wRoamMon3MapNumber], a
	xor a ; generate new stats
	ld [wRoamMon3HP], a
	ret

BillBoxSwitchCheck:
; Returns 0 if our storage system box-wise is completely full, 1 otherwise.
	farcall NewStorageBoxPointer
	ld b, 1
	jr nc, .ok
	jr nz, .ok
	dec b
.ok
	ld a, b
	ldh [hScriptVar], a
	ret
