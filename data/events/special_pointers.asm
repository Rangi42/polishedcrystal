MACRO add_special
\1Special::
	dba \1
ENDM

SpecialsPointers::
	add_special WarpToSpawnPoint

; Communications
	add_special Special_SetBitsForLinkTradeRequest
	add_special Special_WaitForLinkedFriend
	add_special Special_CheckLinkTimeout
	add_special Special_TryQuickSave
	add_special PerformLinkChecks
	add_special Special_FailedLinkToPast
	add_special Special_CloseLink
	add_special WaitForOtherPlayerToExit
	add_special Special_SetBitsForBattleRequest
	add_special Special_TradeCenter
	add_special Special_Colosseum
	add_special Special_CableClubCheckWhichChris

; Map Events
	add_special BugContestJudging
	add_special CheckPartyFullAfterContest
	add_special ContestDropOffMons
	add_special ContestReturnMons
	add_special Special_GiveParkBalls
	add_special CheckMagikarpLength
	add_special Special_MagikarpHouseSign
	add_special HealParty
	add_special PokemonCenterPC
	add_special Special_PlayersHousePC
	add_special Special_DayCareMan
	add_special Special_DayCareLady
	add_special Special_DayCareManOutside
	add_special MoveDeletion
	add_special Special_BankOfMom
	add_special Special_MagnetTrain
	add_special SpecialNameRival
	add_special SpecialTrendyPhrase
	add_special Special_SetDayOfWeek
	add_special Special_TownMap
	add_special MapRadio
	add_special Special_UnownPuzzle
	add_special Special_SlotMachine
	add_special Special_CardFlip
;	add_special Special_UnusedMemoryGame
	add_special FadeOutPalettes
	add_special Special_FadeBlackQuickly
	add_special FadeInPalettes
	add_special Special_FadeInQuickly
	add_special Special_ReloadSpritesNoPalettes
	add_special ClearBGPalettes
	add_special UpdateTimePals
	add_special ClearTileMap
	add_special UpdateSprites
	add_special UpdatePlayerSprite
	add_special Special_GameCornerPrizeMonCheckDex
	add_special SpecialSeenMon
	add_special WaitSFX
	add_special PlayMapMusic
	add_special RestartMapMusic
	add_special HealMachineAnim
	add_special Special_SurfStartStep
	add_special Special_FindThatSpecies
	add_special Special_FindThatSpeciesYourTrainerID
	add_special Special_DayCareMon1
	add_special Special_DayCareMon2
	add_special Special_SelectRandomBugContestContestants
	add_special Special_ActivateFishingSwarm
	add_special ToggleMaptileDecorations
	add_special ToggleDecorationsVisibility
	add_special ReturnShuckie
	add_special Special_BillsGrandfather
	add_special SpecialCheckPokerus
	add_special Special_DisplayCoinCaseBalance
	add_special Special_DisplayMoneyAndCoinBalance
	add_special PlaceMoneyTopRight
	add_special Special_CheckForLuckyNumberWinners
	add_special Special_CheckLuckyNumberShowFlag
	add_special Special_ResetLuckyNumberShowFlag
	add_special Special_PrintTodaysLuckyNumber
	add_special Special_SelectApricornForKurt
	add_special SpecialNameRater
	add_special Special_DisplayLinkRecord
	add_special GetFirstPokemonHappiness
	add_special CheckFirstMonIsEgg
	add_special RandomPhoneRareWildMon
	add_special RandomPhoneWildMon
	add_special RandomPhoneMon
	add_special RefreshSprites
	add_special PlaySlowCry
	add_special SpecialSnorlaxAwake
	add_special Special_OlderHaircutBrother
	add_special Special_YoungerHaircutBrother
	add_special Special_DaisyMassage
	add_special PlayCurMonCry
	add_special ProfOaksPCBoot
	add_special Special_CianwoodPhotograph
	add_special InitRoamMons
	add_special Special_FadeOutMusic
	add_special Diploma
	add_special Special_HyperTrain

; Crystal
	add_special GiveOddEgg
	add_special SoftReset
	add_special Special_MoveTutor
	add_special SpecialOmanyteChamber
	add_special Special_DisplayUnownWords
	add_special SpecialHoOhChamber
	add_special Special_CelebiShrineEvent
	add_special CheckBattleCaughtResult
	add_special JudgeMachine
	add_special SpecialBuenasPassword
	add_special Special_SampleKenjiBreakCountdown
	add_special SpecialBeastsCheck
	add_special SpecialBirdsCheck
	add_special SpecialDuoCheck
	add_special AskRememberPassword
	add_special LoadMapPalettes
	add_special Special_InitialSetDSTFlag
	add_special Special_InitialClearDSTFlag

; Battle Tower
	add_special Special_BattleTower_Battle
	add_special Special_BattleTower_GetBattleResult
	add_special Special_BattleTower_CommitChallengeResult
	add_special Special_BattleTower_GetChallengeState
	add_special Special_BattleTower_SetChallengeState
	add_special Special_BattleTower_GenerateNextOpponent
	add_special Special_BattleTower_NextRentalBattle
	add_special Special_BattleTower_SetupRentalMode
	add_special Special_BattleTower_SelectParticipants
	add_special Special_BattleTower_MaxVolume
	add_special Special_BattleTower_BeginChallenge
	add_special Special_BattleTower_LoadOpponentTrainerAndPokemonsWithOTSprite

; Polished Crystal
	add_special SaveOptions
	add_special WonderTrade
	add_special RespawnOneOffs
	add_special SpecialGiveShinyDitto
	add_special GiveMystriEgg
	add_special Special_ReiBlessing
	add_special BillBoxSwitchCheck
	add_special HealPartyEvenForNuzlocke
	add_special SaveMusic
	add_special RestoreMusic
	add_special DeleteSavedMusic
	add_special CheckIfTrendyPhraseIsLucky
	add_special Special_ChooseItem
	add_special GetGourmetManiacPrice
	add_special GetOreManiacPrice
	add_special GetFossilManiacPrice
	add_special Give_hMoneyTemp
	add_special CheckForSurfingPikachu
	add_special InitializeHiddenGrotto
	add_special GetHiddenGrottoContents
	add_special EmptiedHiddenGrotto
	add_special Special_HiddenPowerGuru
	add_special Special_MintTeaPickMon
	add_special Special_MintTeaChangeNature
	add_special Special_GetOvercastIndex
	add_special Special_SetCopycatPalette
	add_special Special_CurBoxFullCheck
	add_special GetCurBoxName
	add_special CountCaught
	add_special CountSeen
	add_special PickPsychicInverParty
	add_special ShowItemIcon
	add_special ShowKeyItemIcon
	add_special ShowTMHMIcon
	add_special FixPlayerEVsAndStats
