SECTION "WRAM 1", WRAMX

wRAM0End::
wRAM1Start:: ds 1

wDefaultSpawnpoint:: ds 1

UNION
; mon buffer
wBufferMonNick:: ds PKMN_NAME_LENGTH
wBufferMonOT:: ds NAME_LENGTH
wBufferMon:: party_struct wBufferMon
	ds 8
wMonOrItemNameBuffer:: ds NAME_LENGTH

NEXTU
; mail temp storage
wTempMail:: mailmsg wTempMail

NEXTU
; bug-catching contest
wBugContestResults::
	bugcontestwinner wBugContestFirstPlace
	bugcontestwinner wBugContestSecondPlace
	bugcontestwinner wBugContestThirdPlace
wBugContestWinnersEnd::
	bugcontestwinner wBugContestTemp
	ds 4
wBugContestWinnerName:: ds NAME_LENGTH

NEXTU
; mart items
wMartItem1BCD:: ds 3
wMartItem2BCD:: ds 3
wMartItem3BCD:: ds 3
wMartItem4BCD:: ds 3
wMartItem5BCD:: ds 3
wMartItem6BCD:: ds 3
wMartItem7BCD:: ds 3
wMartItem8BCD:: ds 3
wMartItem9BCD:: ds 3
wMartItem10BCD:: ds 3
wMartItem11BCD:: ds 3
wMartItem12BCD:: ds 3
wMartItemBCDEnd::

NEXTU
; town map data
wTownMapPlayerIconLandmark:: ds 1
UNION
wTownMapCursorLandmark:: ds 1
wTownMapCursorObjectPointer:: ds 2
NEXTU
wTownMapCursorCoordinates:: ds 2
ENDU

NEXTU
; phone call data
wPhoneScriptBank:: ds 1
wPhoneCallerLo:: ds 1
wPhoneCallerHi:: ds 1

NEXTU
; radio data
wCurrentRadioLine:: ds 1
wNextRadioLine:: ds 1
wRadioTextDelay:: ds 1
wNumRadioLinesPrinted:: ds 1
wOaksPkmnTalkSegmentCounter:: ds 1
	ds 5
wRadioText:: ds 2 * SCREEN_WIDTH
wRadioTextEnd::

NEXTU
; trainer HUD data
	ds 1
wPlaceBallsDirection:: ds 1
wTrainerHUDTiles:: ds 1

NEXTU
; movement buffer data
wMovementBufferCount:: ds 1
wMovementBufferPerson:: ds 1
	ds 3
wMovementBuffer:: ds 55

NEXTU
; other buffers
wEarthquakeMovementDataBuffer::
wLuckyNumberDigitsBuffer:: ds 5

NEXTU
; unidentified
wd002:: ds 1 ; TODO: replace with meaningful labels
wd003:: ds 1 ; TODO: replace with meaningful labels
wd004:: ds 1 ; TODO: replace with meaningful labels

NEXTU
wMoveScreenMode:: ds 1 ; normal, learning, reminder, deletion
wMoveScreenSelectedMove:: ds 1 ; move index
wMoveScreenCursor:: ds 1 ; cursor position
wMoveScreenOffset:: ds 1 ; offset from top of the list in view
wMoveScreenNumMoves:: ds 1 ; amount of moves in the list
wMoveScreenMoves:: ds 55

NEXTU
; miscellaneous
wTempDayOfWeek::
wUnusedApricorns:: ds 1
	ds 2

wStartFlypoint:: ds 1
wEndFlypoint:: ds 1

	ds 55

UNION
; engine buffers
wEngineBuffer1:: ds 1
wEngineBuffer2:: ds 1
wEngineBuffer3:: ds 1
wEngineBuffer4:: ds 1
wEngineBuffer5:: ds 1

NEXTU
; menu items list
wMenuItemsList:: ds 16
wMenuItemsListEnd::

NEXTU
; temporary script buffers
wTemporaryScriptBuffer:: ds 1
wJumpStdScriptBuffer:: ds 15

NEXTU
; item ball data
wCurItemBallContents:: ds 1
wCurItemBallQuantity:: ds 1

NEXTU
; fruit tree data
wCurFruitTree:: ds 1
	ds 1
wCurFruit:: ds 1

NEXTU
; elevator data
wElevatorPointerBank:: ds 1
wElevatorPointerLo:: ds 1
wElevatorPointerHi:: ds 1
wElevatorOriginFloor:: ds 1

NEXTU
; coord event data
wCurCoordEventTriggerID:: ds 1
wCurCoordEventMapY:: ds 1
wCurCoordEventMapX:: ds 1
wCurCoordEventScriptAddr:: ds 2

NEXTU
; signpost data
wCurSignpostYCoord:: ds 1
wCurSignpostXCoord:: ds 1
wCurSignpostType:: ds 1
wCurSignpostScriptAddr:: ds 1

NEXTU
; trainer data
	ds 3
wTempTrainerHeader::
wTempTrainerEventFlagLo:: ds 1
wTempTrainerEventFlagHi:: ds 1
wTempTrainerClass:: ds 1
wTempTrainerID:: ds 1
wSeenTextPointer:: ds 2
wWinTextPointer:: ds 2
wGenericTempTrainerHeaderEnd::
wLossTextPointer:: ds 2
wScriptAfterPointer:: ds 2
wRunningTrainerBattleScript:: ds 1
wTempTrainerHeaderEnd::
	ds 1
wStashedTextPointer:: ds 2

NEXTU
; mart data
	ds 1
wMartPointerBank:: ds 1
wMartPointer:: ds 2
	ds 1
wBargainShopFlags:: ds 1

NEXTU
; player movement data
wCurInput:: ds 1
	ds 3
wMovementAnimation:: ds 1
wWalkingDirection:: ds 1
wFacingDirection:: ds 1
wWalkingX:: ds 1
wWalkingY:: ds 1
wWalkingTile:: ds 1
	ds 6
wPlayerTurningDirection:: ds 1

NEXTU
; backup menu data
	ds 7
wMenuCursorBufferBackup:: ds 1
wMenuScrollPositionBackup:: ds 1

NEXTU
; phone script pointer
	ds 10
wPhoneScriptPointer:: ds 2

ENDU

ENDU

	ds 3 ; unused

wLastBattlePocket:: ds 1
wBattleItemsPocketCursor:: ds 1
wBattleMedicinePocketCursor:: ds 1
wBattleBallsPocketCursor:: ds 1
wBattleBerriesPocketCursor:: ds 1
wBattleItemsPocketScrollPosition:: ds 1
wBattleMedicinePocketScrollPosition:: ds 1
wBattleBallsPocketScrollPosition:: ds 1
wBattleBerriesPocketScrollPosition:: ds 1

wTMHMMoveNameBackup:: ds MOVE_NAME_LENGTH

wStringBuffer1:: ds 24
wStringBuffer2:: ds 19
wStringBuffer3:: ds 19
wStringBuffer4:: ds 19
wStringBuffer5:: ds 19

wBattleMenuCursorBuffer:: ds 2

wCurBattleMon:: ds 1
wCurMoveNum:: ds 1

	ds 1 ; unused

wPCItemsCursor:: ds 1
wPartyMenuCursor:: ds 1
wItemsPocketCursor:: ds 1
wMedicinePocketCursor:: ds 1
wBallsPocketCursor:: ds 1
wTMHMPocketCursor:: ds 1
wBerriesPocketCursor:: ds 1
wKeyItemsPocketCursor:: ds 1

wPCItemsScrollPosition:: ds 1
wPartyMenuScrollPosition:: ds 1 ; unused
wItemsPocketScrollPosition:: ds 1
wMedicinePocketScrollPosition:: ds 1
wBallsPocketScrollPosition:: ds 1
wTMHMPocketScrollPosition:: ds 1
wBerriesPocketScrollPosition:: ds 1
wKeyItemsPocketScrollPosition:: ds 1

wMoveSwapBuffer::
wSwitchMon::
wSwitchItem:: ds 1

wMenuScrollPosition:: ds 4
wQueuedScriptBank:: ds 1
wQueuedScriptAddr:: ds 2
wNumMoves:: ds 1

wBattlePlayerAction::
; 0 - use move
; 1 - use item
; 2 - switch
wFieldMoveSucceeded::
wItemEffectSucceeded::
wSolvedUnownPuzzle::
	ds 1

wVramState::
; bit 0: overworld sprite updating on/off
; bit 6: something to do with text
; bit 7: on when surf initiates
;        flickers when climbing waterfall
	ds 1

wBattleResult::
; bit 7: mon is captured and sent to PC
; bit 6: legendary is captured (used for Celebi)
; bit 1: set on fleeing
; value of %xxxx0002: link battle draw (x is ignored)
; value of %xx000001: whiteout
	ds 1

wUsingItemWithSelect:: ds 1

UNION
; mart data
wCurMart:: ds 16
wCurMartEnd::
NEXTU
; miscellaneous
wInverseBattleScore::
wCurElevator:: ds 1
wCurElevatorFloors::
wCurMessageIndex:: ds 1
wMailboxCount:: ds 1
wMailboxItems:: ds MAILBOX_CAPACITY
wMailboxEnd:: ds 1
ENDU

	ds 5 ; unused

wCurIconMonHasItemOrMail:: ds 1

wCurKeyItem::
wCurTMHM::
wCurItem::
	ds 1
wMartItemID::
wCurItemQuantity::
	ds 1
wCurPartySpecies::
	ds 1
wCurPartyMon::
; contains which monster in a party
; is being dealt with at the moment
; 0-5
	ds 1
wWhichHPBar::
; 0: Enemy
; 1: Player
; 2: Party Menu
	ds 1
wPokemonWithdrawDepositParameter::
; 0: Take from PC
; 1: Put into PC
; 2: Take from Daycare
; 3: Put into Daycare
	ds 1
wIsCurMonInParty::
wItemQuantityChangeBuffer::
	ds 1
wItemQuantityBuffer::
	ds 1

;TempMPWaveform::
wTempMon::
	party_struct wTempMon

wSpriteFlags:: ds 1
; 5: use vbk1 if set, otherwise vbk0

wHandlePlayerStep:: ds 2

wPartyMenuActionText:: ds 1

wItemAttributeParamBuffer:: ds 1

wCurPartyLevel:: ds 1

wScrollingMenuListSize:: ds 2

; used when following a map warp
wNextWarp:: ds 1
wNextMapGroup:: ds 1
wNextMapNumber:: ds 1
wPrevWarp:: ds 1
wPrevMapGroup:: ds 1
wPrevMapNumber:: ds 1

wPlayerBGMapOffsetX:: ds 1 ; used in FollowNotExact; unit is pixels
wPlayerBGMapOffsetY:: ds 1 ; used in FollowNotExact; unit is pixels

; Player movement
wPlayerStepVectorX:: ds 1
wPlayerStepVectorY:: ds 1
wPlayerStepFlags:: ds 1
; bit 7: Start step
; bit 6: Stop step
; bit 5: Doing step
; bit 4: In midair
; bits 0-3: unused
wPlayerStepDirection:: ds 1

wSpinning:: ds 1

wBGMapAnchor:: ds 2

	ds 64 ; unused

wOverworldMapAnchor:: ds 2
wMetatileStandingY:: ds 1
wMetatileStandingX:: ds 1
wSecondMapHeaderBank:: ds 1
wTileset:: ds 1
wPermission:: ds 1
wSecondMapHeaderAddr:: ds 2

; width/height are in blocks (2x2 walkable tiles, 4x4 graphics tiles)
wMapHeader::
wMapBorderBlock:: ds 1
wMapHeight:: ds 1
wMapWidth:: ds 1
wMapBlockDataBank:: ds 1
wMapBlockDataPointer:: ds 2
wMapScriptHeaderBank:: ds 1
wMapScriptHeaderPointer:: ds 2
wMapConnections:: ds 1 ; bit set

wNorthMapConnection::
wNorthConnectedMapGroup:: ds 1
wNorthConnectedMapNumber:: ds 1
wNorthConnectionStripPointer:: ds 2
wNorthConnectionStripLocation:: ds 2
wNorthConnectionStripLength:: ds 1
wNorthConnectedMapWidth:: ds 1
wNorthConnectionStripYOffset:: ds 1
wNorthConnectionStripXOffset:: ds 1
wNorthConnectionWindow:: ds 2

wSouthMapConnection::
wSouthConnectedMapGroup:: ds 1
wSouthConnectedMapNumber:: ds 1
wSouthConnectionStripPointer:: ds 2
wSouthConnectionStripLocation:: ds 2
wSouthConnectionStripLength:: ds 1
wSouthConnectedMapWidth:: ds 1
wSouthConnectionStripYOffset:: ds 1
wSouthConnectionStripXOffset:: ds 1
wSouthConnectionWindow:: ds 2

wWestMapConnection::
wWestConnectedMapGroup:: ds 1
wWestConnectedMapNumber:: ds 1
wWestConnectionStripPointer:: ds 2
wWestConnectionStripLocation:: ds 2
wWestConnectionStripLength:: ds 1
wWestConnectedMapWidth:: ds 1
wWestConnectionStripYOffset:: ds 1
wWestConnectionStripXOffset:: ds 1
wWestConnectionWindow:: ds 2

wEastMapConnection::
wEastConnectedMapGroup:: ds 1
wEastConnectedMapNumber:: ds 1
wEastConnectionStripPointer:: ds 2
wEastConnectionStripLocation:: ds 2
wEastConnectionStripLength:: ds 1
wEastConnectedMapWidth:: ds 1
wEastConnectionStripYOffset:: ds 1
wEastConnectionStripXOffset:: ds 1
wEastConnectionWindow:: ds 2

wTilesetHeader::
wTilesetGFXBank:: ds 1
wTilesetGFXAddress:: ds 2
wTilesetGFX2Address:: ds 2
wTilesetBlocksBank:: ds 1
wTilesetBlocksAddress:: ds 2
wTilesetCollisionBank:: ds 1
wTilesetCollisionAddress:: ds 2
wTilesetAttributesBank:: ds 1
wTilesetAttributesAddress:: ds 2
wTilesetAnim:: ds 2 ; bank 3f
wTilesetHeaderEnd::

wEvolvableFlags:: flag_array PARTY_LENGTH

wForceEvolution:: ds 1

UNION
; general-purpose buffers
wBuffer1:: ds 1
wBuffer2:: ds 1
wBuffer3:: ds 1
wBuffer4:: ds 1
wBuffer5:: ds 1
wBuffer6:: ds 1

NEXTU
; HP bar animations
wCurHPAnimMaxHP:: ds 2
wCurHPAnimOldHP:: ds 2
wCurHPAnimNewHP:: ds 2
wCurHPAnimPal:: ds 1
wCurHPBarPixels:: ds 1
wNewHPBarPixels:: ds 1
wCurHPAnimDeltaHP:: ds 2
wCurHPAnimLowHP:: ds 1
wCurHPAnimHighHP:: ds 1

NEXTU
; evolution data
wEvolutionOldSpecies:: ds 1
wEvolutionNewSpecies:: ds 1
wEvolutionPicOffset:: ds 1
wEvolutionCanceled:: ds 1

NEXTU
; Magikarp length
wMagikarpLengthMm::
wMagikarpLengthMmHi:: ds 1
wMagikarpLengthMmLo:: ds 1

NEXTU
; link data
	ds 9
wLinkBuffer:: ds 4
wLinkBattleRNs:: ds 10
wLinkBattleEarlyEnd:: ds 2
wLinkBufferEnd::

NEXTU
; battle data
	ds 7
wCurEnemyItem:: ds 1
	ds 15
wTempEnemyMonSpecies:: ds 1
wTempBattleMonSpecies:: ds 1

ENDU

wEnemyMon:: battle_struct wEnemyMon

	ds 5 ; unused

wEnemyMonCatchRate:: ds 1
wEnemyMonBaseExp:: ds 1
wEnemyMonEnd::

wBattleMode::
; 0: overworld
; 1: wild battle
; 2: trainer battle
	ds 1

wTempWildMonSpecies:: ds 1

wOtherTrainerClass::
; class (Youngster, Bug Catcher, etc.) of opposing trainer
; 0 if opponent is a wild Pokémon, not a trainer
	ds 1

wBattleType::
; $00 normal
; $01 can lose
; $02 tutorial
; $03 fishing
; $04 headbutt/rock smash
; $05 roaming
; $06 contest
; $07 ghost
; $08 inverse
; $09 shiny
; $0a force Item1
; $0b trap
; $0c legendary
	ds 1

wOtherTrainerID:: ds 1

wTrainerClass:: ds 1

	ds 1 ; unused

wMoveSelectionMenuType:: ds 1
; 0: battle move selection
; 1: pp restore selection
; 2: conversion selection

wCurBaseData::
wBaseStats::
wBaseHP:: ds 1
wBaseAttack:: ds 1
wBaseDefense:: ds 1
wBaseSpeed:: ds 1
wBaseSpecialAttack:: ds 1
wBaseSpecialDefense:: ds 1
wBaseType::
wBaseType1:: ds 1
wBaseType2:: ds 1
wBaseCatchRate:: ds 1
wBaseExp:: ds 1
wBaseItems:: ds 2
wBaseGender::
wBaseEggSteps:: ds 1
wBasePicSize:: ds 1
wBaseAbility1:: ds 1
wBaseAbility2:: ds 1
wBaseHiddenAbility:: ds 1
wBaseGrowthRate:: ds 1
wBaseEggGroups:: ds 1
wBaseEVYield1:: ds 1
wBaseEVYield2:: ds 1
wBaseTMHM:: flag_array NUM_TMHMS

wCurDamage:: ds 2

wMornEncounterRate:: ds 1
wDayEncounterRate:: ds 1
wNiteEncounterRate:: ds 1
wWaterEncounterRate:: ds 1

wListMoves_MoveIndicesBuffer:: ds NUM_MOVES

wPutativeTMHMMove:: ds 1

wForgettingMove:: ds 1

wBattleHasJustStarted:: ds 1

wd265:: ; TODO: replace with meaningful labels
wNamedObjectIndexBuffer::
wCurKeyItemBuffer::
wCurTMHMBuffer::
wTypeMatchup::
wFoundMatchingIDInParty::
; usually 1 byte, may be up to 3 in some cases for wNamedObjectIndexBuffer
	ds 3

wMonTriedToEvolve:: ds 1

wTimeOfDay:: ds 1

wOtherTrainerType:: ds 1

wTrainerGroupBank:: ds 1


SECTION "Enemy Party", WRAMX

wPokedexShowPointerAddr:: ds 2
wPokedexShowPointerBank:: ds 1

wFailedToFlee:: ds 1
wNumFleeAttempts:: ds 1

wOTPlayerName:: ds NAME_LENGTH
wOTPlayerID:: ds 2
wOTPartyCount:: ds 1
wOTPartySpecies:: ds PARTY_LENGTH + 1 ; legacy scripts don't check PartyCount

; OT party data -- OTPartyMon1 and nicknames is always available
wOTPartyMons::
wOTPartyMon1:: party_struct wOTPartyMon1
UNION
; catch tutorial dude bag
wDudeBag::
wDudeNumItems:: ds 1
wDudeItems: ds 2 * 2
wDudeItemsEnd:: ds 1
wDudeNumMedicine:: ds 1
wDudeMedicine:: ds 3 * 2
wDudeMedicineEnd:: ds 1
wDudeNumBalls:: ds 1
wDudeBalls:: ds 2 * 2
wDudeBallsEnd:: ds 1
wDudeBagEnd::

NEXTU
wOTPartyMon2:: party_struct wOTPartyMon2
wOTPartyMon3:: party_struct wOTPartyMon3
wOTPartyMon4:: party_struct wOTPartyMon4
wOTPartyMon5:: party_struct wOTPartyMon5
wOTPartyMon6:: party_struct wOTPartyMon6
ENDU
wOTPartyMonsEnd::
wOTPartyMonOT:: ds NAME_LENGTH * PARTY_LENGTH
wOTPartyMonNicknames:: ds PKMN_NAME_LENGTH * PARTY_LENGTH
wOTPartyDataEnd::

wBattleAction:: ds 1
wLinkBattleSentAction:: ds 1

wMapStatus:: ds 1
wMapEventStatus::
; 0: do map events
; 1: do background events
	ds 1

wScriptFlags::
wScriptFlags1::
; bit 3: priority jump
	ds 1
wScriptFlags2::
	ds 1
wScriptFlags3::
; bit 0: count steps
; bit 1: xy triggers
; bit 2: warps and connections
; bit 4: wild encounters
; bit 5: unknown
	ds 1

wScriptMode:: ds 1
wScriptRunning:: ds 1
wScriptBank:: ds 1
wScriptPos:: ds 2

wScriptStackSize:: ds 1
wScriptStack:: ds 3 * 12
wScriptDelay:: ds 1

wPriorityScriptBank::
wScriptTextBank:: ds 1
wPriorityScriptAddr::
wScriptTextAddr:: ds 2

wWildEncounterCooldown:: ds 1

wWildBattlePanic:: ds 1

wBattleScriptFlags:: ds 2
wPlayerSpriteSetupFlags::
; bit 7: if set, cancel PlayerAction
; bit 5: if set, set facing according to bits 0-1
; bits 0-1: direction facing
	ds 1

wMapReentryScriptQueueFlag:: ds 1 ; MemScriptFlag
wMapReentryScriptBank:: ds 1 ; MemScriptBank
wMapReentryScriptAddress:: ds 2 ; MemScriptAddr

wTimeCyclesSinceLastCall:: ds 1
wReceiveCallDelay_MinsRemaining:: ds 1
wReceiveCallDelay_StartTime:: ds 3

wBugContestMinsRemaining:: ds 1
wBugContestSecsRemaining:: ds 1

	ds 2 ; unused

wMapStatusEnd::

	ds 2


SECTION "Game Data", WRAMX

wGameData::
wPlayerData::
wPlayerID:: ds 2

wPlayerGender::
; bit 0:
;	0 male
;	1 female
	ds 1

wPlayerName:: ds NAME_LENGTH
wRivalName:: ds NAME_LENGTH
wBackupName:: ds NAME_LENGTH

wTrendyPhrase:: ds NAME_LENGTH

wSavedAtLeastOnce:: ds 1

wSpawnAfterChampion:: ds 1

; init time set at newgame
wStartDay:: ds 1
wStartHour:: ds 1
wStartMinute:: ds 1
wStartSecond:: ds 1

wGameSaveTime:: ds 8 ; in-game wall clock time at save
wDST:: ds 1

wGameTimeCap:: ds 1 ; flag for timer hitting 999:59:59.00
wGameTimeHours:: ds 2
wGameTimeMinutes:: ds 1
wGameTimeSeconds:: ds 1
wGameTimeFrames:: ds 1

wCurDay:: ds 1

; do not talk to the RTC hardware in the no-RTC patch
if DEF(NO_RTC)
wNoRTC::
wNoRTCDayHi::   ds 1 ; copied to hRTCDayHi
wNoRTCDayLo::   ds 1 ; copied to hRTCDayLo
wNoRTCHours::   ds 1 ; copied to hRTCHours
wNoRTCMinutes:: ds 1 ; copied to hRTCMinutes
wNoRTCSeconds:: ds 1 ; copied to hRTCSeconds
else
; reserve equal space in RTC versions so that saved games remain compatible
	ds 5
endc

wPlayerGoingUpStairs:: ds 1

wObjectFollow_Leader:: ds 1
wObjectFollow_Follower:: ds 1
wCenteredObject:: ds 1
wFollowerMovementQueueLength:: ds 1
wFollowMovementQueue:: ds 5

wObjectStructs::
	object_struct wPlayer
	object_struct wObject1
	object_struct wObject2
	object_struct wObject3
	object_struct wObject4
	object_struct wObject5
	object_struct wObject6
	object_struct wObject7
	object_struct wObject8
	object_struct wObject9
	object_struct wObject10
	object_struct wObject11
	object_struct wObject12
wObjectStructsEnd::

wCmdQueue:: ds CMDQUEUE_CAPACITY * CMDQUEUE_ENTRY_SIZE

wMapObjects::
	map_object wPlayer
	map_object wMap1
	map_object wMap2
	map_object wMap3
	map_object wMap4
	map_object wMap5
	map_object wMap6
	map_object wMap7
	map_object wMap8
	map_object wMap9
	map_object wMap10
	map_object wMap11
	map_object wMap12
	map_object wMap13
	map_object wMap14
	map_object wMap15
	map_object wMap16
	map_object wMap17
	map_object wMap18
	map_object wMap19
	map_object wMap20
wMapObjectsEnd::

wObjectMasks:: ds NUM_OBJECTS

wVariableSprites:: ds $100 - SPRITE_VARS

wEnteredMapFromContinue:: ds 1

	ds 2

wTimeOfDayPal:: ds 1
	ds 4
wTimeOfDayPalFlags:: ds 1
wTimeOfDayPalset:: ds 1
wCurTimeOfDay:: ds 1

wSecretID:: ds 2

wStatusFlags::
	; 0 - pokedex
	; 1 - unown dex
	; 2 - flash
	; 3 - pokerus
	; 4 - rocket signal
	; 5 - wild encounters on/off
	; 6 - hall of fame
	; 7 - bug contest on
	ds 1
wStatusFlags2::
	; 0 - rockets
	; 1 - safari game
	; 2 - bug contest timer
	; 3 - seen shamouti island
	; 4 - bike shop call
	; 5 - pokerus
	; 6 - exorcised lav radio tower
	; 7 - rockets in mahogany
	ds 1

wMoney:: ds 3
wMomsMoney:: ds 3
MoneyEnd::
wMomSavingMoney:: ds 1

wCoins:: ds 2

wBadges::
wJohtoBadges:: flag_array NUM_JOHTO_BADGES
wKantoBadges:: flag_array NUM_KANTO_BADGES
wBadgesEnd::

wPokemonJournals:: flag_array NUM_POKEMON_JOURNALS
wPokemonJournalsEnd::

wTMsHMs:: flag_array NUM_TMS + NUM_HMS
wTMsHMsEnd::

wKeyItems:: flag_array NUM_KEY_ITEMS
wKeyItemsEnd::

wNumItems:: ds 1
wItems:: ds MAX_ITEMS * 2 + 1
wItemsEnd::
wNumMedicine:: ds 1
wMedicine:: ds MAX_MEDICINE * 2 + 1
wMedicineEnd::
wNumBalls:: ds 1
wBalls:: ds MAX_BALLS * 2 + 1
wBallsEnd::
wNumBerries:: ds 1
wBerries:: ds MAX_BERRIES * 2 + 1
wBerriesEnd::
wNumPCItems:: ds 1
wPCItems:: ds MAX_PC_ITEMS * 2 + 1
wPCItemsEnd::

wApricorns:: ds NUM_APRICORNS

wPokegearFlags::
; bit 0: map
; bit 1: radio
; bit 2: phone
; bit 3: expn
; bit 7: on/off
	ds 1
wRadioTuningKnob:: ds 1
wLastDexMode:: ds 1

	ds 2 ; unused

wPlayerState:: ds 1

wHallOfFameCount:: ds 2
wTradeFlags:: flag_array PARTY_LENGTH

	ds 1 ; unused

wMooMooBerries:: ds 1
wUndergroundSwitchPositions:: ds 1
wFarfetchdPosition:: ds 1

; map triggers
wAlways0Trigger:: ds 1
wAzaleaTownTrigger:: ds 1
wBattleTower1FTrigger:: ds 1
wBattleTowerBattleRoomTrigger:: ds 1
wBattleTowerElevatorTrigger:: ds 1
wBattleTowerHallwayTrigger:: ds 1
wBattleTowerOutsideTrigger:: ds 1
wBellchimeTrailTrigger:: ds 1
wBrunosRoomTrigger:: ds 1
wBurnedTower1FTrigger:: ds 1
wBurnedTowerB1FTrigger:: ds 1
wCeruleanCapeTrigger:: ds 1
wCeruleanCave1FTrigger:: ds 1
wCeruleanGymTrigger:: ds 1
wCherrygroveCityTrigger:: ds 1
wCianwoodCityTrigger:: ds 1
wCinnabarLabTrigger:: ds 1
wColosseumTrigger:: ds 1
wDarkCaveVioletEntranceTrigger:: ds 1
wDayCareTrigger:: ds 1
wDragonsDenB1FTrigger:: ds 1
wDragonShrineTrigger:: ds 1
wEcruteakGymTrigger:: ds 1
wEcruteakHouseTrigger:: ds 1
wEcruteakPokecenter1FTrigger:: ds 1
wElmsLabTrigger:: ds 1
wFarawayIslandTrigger:: ds 1
wFastShip1FTrigger:: ds 1
wFastShipB1FTrigger:: ds 1
wGiovannisCaveTrigger:: ds 1
wGoldenrodCityTrigger:: ds 1
wGoldenrodGymTrigger:: ds 1
wGoldenrodMuseum1FTrigger:: ds 1
wHallOfFameTrigger:: ds 1
wIlexForestTrigger:: ds 1
wKarensRoomTrigger:: ds 1
wKogasRoomTrigger:: ds 1
wKrissHouse1FTrigger:: ds 1
wLancesRoomTrigger:: ds 1
wLavenderTownTrigger:: ds 1
wMahoganyMart1FTrigger:: ds 1
wMahoganyTownTrigger:: ds 1
wMountMoon1FTrigger:: ds 1
wMrPokemonsHouseTrigger:: ds 1
wMystriStageTrigger:: ds 1
wNewBarkTownTrigger:: ds 1
wOlivineCityTrigger:: ds 1
wOlivinePortTrigger:: ds 1
wPokecenter2FTrigger:: ds 1
wPokemonLeagueGateTrigger:: ds 1
wPowerPlantTrigger:: ds 1
wRadioTower5FTrigger:: ds 1
wRoute10NorthTrigger:: ds 1
wRoute23Trigger:: ds 1
wRoute24Trigger:: ds 1
wRoute27Trigger:: ds 1
wRoute29Trigger:: ds 1
wRoute32Trigger:: ds 1
wRoute34Trigger:: ds 1
wRoute35NationalParkGateTrigger:: ds 1
wRoute36NationalParkGateTrigger:: ds 1
wRoute36Trigger:: ds 1
wRoute42Trigger:: ds 1
wRoute43GateTrigger:: ds 1
wRoute47Trigger:: ds 1
wRoute48Trigger:: ds 1
wRuinsOfAlphAerodactylChamberTrigger:: ds 1
wRuinsOfAlphHoOhChamberTrigger:: ds 1
wRuinsOfAlphInnerChamberTrigger:: ds 1
wRuinsOfAlphKabutoChamberTrigger:: ds 1
wRuinsOfAlphOmanyteChamberTrigger:: ds 1
wRuinsOfAlphOutsideTrigger:: ds 1
wRuinsOfAlphResearchCenterTrigger:: ds 1
wSeagallopFerryNavelGateTrigger:: ds 1
wSeagallopFerryShamoutiGateTrigger:: ds 1
wSeagallopFerryVermilionGateTrigger:: ds 1
wShamoutiHotelRestaurantTrigger:: ds 1
wSproutTower3FTrigger:: ds 1
wTeamRocketBaseB2FTrigger:: ds 1
wTeamRocketBaseB3FTrigger:: ds 1
wTinTower1FTrigger:: ds 1
wTradeCenterTrigger:: ds 1
wUndergroundPathSwitchRoomEntrancesTrigger:: ds 1
wVermilionCityTrigger:: ds 1
wVermilionPortTrigger:: ds 1
wVictoryRoad2FTrigger:: ds 1
wVioletGymTrigger:: ds 1
wWillsRoomTrigger:: ds 1
wWiseTriosRoomTrigger:: ds 1
wYellowForestTrigger:: ds 1

; fight counts
wJackFightCount::    ds 1
wBeverlyFightCount:: ds 1 ; unused
wHueyFightCount::    ds 1
wGavenFightCount::   ds 1
wBethFightCount::    ds 1
wJoseFightCount::    ds 1
wReenaFightCount::   ds 1
wJoeyFightCount::    ds 1
wWadeFightCount::    ds 1
wRalphFightCount::   ds 1
wLizFightCount::     ds 1
wAnthonyFightCount:: ds 1
wToddFightCount::    ds 1
wGinaFightCount::    ds 1
wIrwinFightCount::   ds 1 ; unused
wArnieFightCount::   ds 1
wAlanFightCount::    ds 1
wDanaFightCount::    ds 1
wChadFightCount::    ds 1
wDerekFightCount::   ds 1 ; unused
wTullyFightCount::   ds 1
wBrentFightCount::   ds 1
wTiffanyFightCount:: ds 1
wVanceFightCount::   ds 1
wWiltonFightCount::  ds 1
wKenjiFightCount::   ds 1 ; unused
wParryFightCount::   ds 1
wErinFightCount::    ds 1

wEventFlags:: flag_array NUM_EVENTS

wCurBox:: ds 1
wBoxNames:: ds BOX_NAME_LENGTH * NUM_BOXES
wBoxNamesEnd::

wCelebiEvent:: ds 1

	ds 1 ; unused

wOWState:: ds 2

wCurrentMapTriggerPointer:: ds 2
wCurrentCaller:: ds 2
wCurrMapWarpCount:: ds 1
wCurrMapWarpHeaderPointer:: ds 2
wCurrentMapXYTriggerCount:: ds 1
wCurrentMapXYTriggerHeaderPointer:: ds 2
wCurrentMapSignpostCount:: ds 1
wCurrentMapSignpostHeaderPointer:: ds 2
wCurrentMapPersonEventCount:: ds 1
wCurrentMapPersonEventHeaderPointer:: ds 2
wCurrMapTriggerCount:: ds 1
wCurrMapTriggerHeaderPointer:: ds 2
wCurrMapCallbackCount:: ds 1
wCurrMapCallbackHeaderPointer:: ds 2

	ds 2 ; unused

; Sprite id of each decoration
wBed:: ds 1
wCarpet:: ds 1
wPlant:: ds 1
wPoster:: ds 1
wConsole:: ds 1
wLeftOrnament:: ds 1
wRightOrnament:: ds 1
wBigDoll:: ds 1

; Items bought from Mom
wWhichMomItem:: ds 1
wWhichMomItemSet:: ds 1
wMomItemTriggerBalance:: ds 3

wDailyResetTimer:: ds 2
wDailyFlags:: ds 1
wDailyFlags2:: ds 1
wDailyFlags3:: ds 1
wDailyFlags4:: ds 1
wWeeklyFlags:: ds 1
wWeeklyFlags2:: ds 1
wSwarmFlags:: ds 1
wTimerStartDay:: ds 1

wFruitTreeFlags:: flag_array NUM_FRUIT_TREES

wNuzlockeLandmarkFlags:: flag_array NUM_LANDMARKS

wHiddenGrottoContents::
; content type, content id
	ds NUM_HIDDEN_GROTTOES * 2

wCurHiddenGrotto:: ds 1

wLuckyNumberDayBuffer:: ds 2
wSpecialPhoneCallID:: ds 1
wBugContestStartTime:: ds 4 ; day, hour, min, sec

wLastPocket:: ds 1

wBuenasPassword:: ds 1
wBlueCardBalance:: ds 1

wBugContestOfficerPrize:: ds 1

wInPokegear:: ds 1
wWalkingOnBridge:: ds 1

wDailyRematchFlags:: ds 4
wDailyPhoneItemFlags:: ds 4
wDailyPhoneTimeOfDayFlags:: ds 4
wKenjiBreakTimer:: ds 2 ; Kenji

wYanmaMapGroup:: ds 1
wYanmaMapNumber:: ds 1

wVermilionGymTrashCan1:: ds 1
wVermilionGymTrashCan2:: ds 1

	ds 2 ; unused

wBattlePoints:: ds 1

wStepCount:: ds 1
wPoisonStepCount:: ds 1

wPhoneList:: ds CONTACT_LIST_SIZE

wHappinessStepCount:: ds 1

wParkBallsRemaining::
wSafariBallsRemaining:: ds 1
wSafariTimeRemaining:: ds 2

wLuckyNumberShowFlag:: ds 2
wLuckyIDNumber:: ds 2

wRepelEffect:: ds 1 ; If a Repel is in use, it contains the nr of steps it's still active
wRepelType:: ds 1

wBikeStep:: ds 2

wKurtApricornQuantity:: ds 1

wPlayerDataEnd::


wMapData::

wVisitedSpawns:: flag_array NUM_SPAWNS

wDigWarp:: ds 1
wDigMapGroup:: ds 1
wDigMapNumber:: ds 1

; used on maps like second floor pokécenter, which are reused, so we know which
; map to return to
wBackupWarpNumber:: ds 1
wBackupMapGroup:: ds 1
wBackupMapNumber:: ds 1

wLastSpawnMapGroup:: ds 1
wLastSpawnMapNumber:: ds 1

wWarpNumber:: ds 1
wMapGroup:: ds 1 ; map group of current map
wMapNumber:: ds 1 ; map number of current map
wYCoord:: ds 1 ; current y coordinate relative to top-left corner of current map
wXCoord:: ds 1 ; current x coordinate relative to top-left corner of current map
wScreenSave:: ds 6 * 5

wMapDataEnd::


SECTION "Party", WRAMX

wPokemonData::

wPartyCount:: ds 1 ; number of Pokémon in party
wPartySpecies:: ds PARTY_LENGTH + 1 ; legacy scripts don't check PartyCount

wPartyMons::
wPartyMon1:: party_struct wPartyMon1
wPartyMon2:: party_struct wPartyMon2
wPartyMon3:: party_struct wPartyMon3
wPartyMon4:: party_struct wPartyMon4
wPartyMon5:: party_struct wPartyMon5
wPartyMon6:: party_struct wPartyMon6

wPartyMonOT:: ds NAME_LENGTH * PARTY_LENGTH

wPartyMonNicknames:: ds PKMN_NAME_LENGTH * PARTY_LENGTH
wPartyMonNicknamesEnd::

	ds 12 ; unused

wPokedexCaught:: flag_array NUM_POKEMON
wEndPokedexCaught::

wPokedexSeen:: flag_array NUM_POKEMON
wEndPokedexSeen::

wUnownDex:: ds NUM_UNOWN
wUnlockedUnowns:: ds 1

wFirstUnownSeen:: ds 1
wFirstMagikarpSeen:: ds 1

wDaycareMan::
; bit 7: active
; bit 6: monsters are compatible
; bit 5: egg ready
; bit 0: monster 1 in daycare
	ds 1

wBreedMon1::
wBreedMon1Nick::  ds PKMN_NAME_LENGTH
wBreedMon1OT:: ds NAME_LENGTH
wBreedMon1Stats:: box_struct wBreedMon1

wDaycareLady::
; bit 7: active
; bit 0: monster 2 in daycare
	ds 1

wStepsToEgg:: ds 1
wBreedMotherOrNonDitto:: ds 1

wBreedMon2::
wBreedMon2Nick:: ds PKMN_NAME_LENGTH
wBreedMon2OT:: ds NAME_LENGTH
wBreedMon2Stats:: box_struct wBreedMon2

wEggNick:: ds PKMN_NAME_LENGTH
wEggOT:: ds NAME_LENGTH
wEggMon:: box_struct wEggMon

wBugContestSecondPartySpecies:: ds 1
wContestMon:: party_struct wContestMon

wDunsparceMapGroup:: ds 1
wDunsparceMapNumber:: ds 1
wFishingSwarmFlag:: ds 1

wRoamMon1:: roam_struct wRoamMon1
wRoamMon2:: roam_struct wRoamMon2
wRoamMon3:: roam_struct wRoamMon3

wRoamMons_CurrentMapNumber:: ds 1
wRoamMons_CurrentMapGroup:: ds 1
wRoamMons_LastMapNumber:: ds 1
wRoamMons_LastMapGroup:: ds 1

wBestMagikarpLengthMm::
wBestMagikarpLengthMmHi:: ds 1
wBestMagikarpLengthMmLo:: ds 1
wMagikarpRecordHoldersName:: ds NAME_LENGTH

wRegisteredItemFlags:: 
	; 0 - wRegisteredItems key item flag 
	; 1 - wRegisteredItems + 1 key item flag
	; 2 - wRegisteredItems + 2 key item flag
	; 3 - wRegisteredItems + 3 key item flag

	; 4 - wRegisteredItems second item list flag
	; 5 - wRegisteredItems + 1 second item list flag
	; 6 - wRegisteredItems + 2 second item list flag
	; 7 - wRegisteredItems + 3 second item list flag
	ds 1

wRegisteredItems::
; You can map 4 items, to select + directions
	ds 4

wPokemonDataEnd::
wGameDataEnd::


SECTION "Pic Animations RAM", WRAMX

wTempTileMap:: ds SCREEN_WIDTH * SCREEN_HEIGHT ; 20x18 grid of 8x8 tiles

; PokeAnim Header
wPokeAnimSceneIndex:: ds 1
wPokeAnimPointer:: ds 2
wPokeAnimSpecies:: ds 1
wPokeAnimVariant:: ds 1
wPokeAnimSpeciesOrVariant:: ds 1
wPokeAnimGraphicStartTile:: ds 1
wPokeAnimCoord:: ds 2
wPokeAnimFrontpicHeight:: ds 1
; PokeAnim Data
wPokeAnimExtraFlag:: ds 1
wPokeAnimSpeed:: ds 1
wPokeAnimPointerBank:: ds 1
wPokeAnimPointerAddr:: ds 2
wPokeAnimFramesBank:: ds 1
wPokeAnimFramesAddr:: ds 2
wPokeAnimBitmaskBank:: ds 1
wPokeAnimBitmaskAddr:: ds 2
wPokeAnimFrame:: ds 1
wPokeAnimJumptableIndex:: ds 1
wPokeAnimRepeatTimer:: ds 1
wPokeAnimCurBitmask:: ds 1
wPokeAnimWaitCounter:: ds 1
wPokeAnimCommand:: ds 1
wPokeAnimParameter:: ds 1
	ds 1
wPokeAnimBitmaskCurCol:: ds 1
wPokeAnimBitmaskCurRow:: ds 1
wPokeAnimBitmaskCurBit:: ds 1
wPokeAnimBitmaskBuffer:: ds 1
	ds 8
wPokeAnimStructEnd::


SECTION "Battle Tower", WRAMX

; BattleTower OpponentTrainer-Data (length = 0xe0 = $a + $1 + 3*$3b + $24)
wBT_OTTrainer:: battle_tower_struct wBT_OT

	ds $20

wBT_TrainerTextIndex:: ds 2

wBT_OTTrainer1:: battle_tower_struct wBT_OTTrainer1
wBT_OTTrainer2:: battle_tower_struct wBT_OTTrainer2
wBT_OTTrainer3:: battle_tower_struct wBT_OTTrainer3
wBT_OTTrainer4:: battle_tower_struct wBT_OTTrainer4
wBT_OTTrainer5:: battle_tower_struct wBT_OTTrainer5
wBT_OTTrainer6:: battle_tower_struct wBT_OTTrainer6
wBT_OTTrainer7:: battle_tower_struct wBT_OTTrainer7

wBTChoiceOfLvlGroup:: ds 1


SECTION "Sound Stack", WRAMX

wSoundEngineBackup:: ds wChannelsEnd - wMusic


SECTION "Metatiles", WRAMX

wDecompressedMetatiles:: ds 256 * 16


SECTION "Attributes", WRAMX

wDecompressedAttributes:: ds 256 * 16


SECTION "Music Player Notes", WRAMX

wMPNotes:: ds 4 * 256


SECTION "GBC Video", WRAMX

; 8 4-color palettes
wUnknBGPals:: ds 8 palettes
wUnknOBPals:: ds 8 palettes
wBGPals::     ds 8 palettes
wOBPals::     ds 8 palettes

wLYOverrides:: ds SCREEN_HEIGHT_PX
wLYOverridesEnd::

wMagnetTrainDirection:: ds 1
wMagnetTrainInitPosition:: ds 1
wMagnetTrainHoldPosition:: ds 1
wMagnetTrainFinalPosition:: ds 1
wMagnetTrainPlayerSpriteInitX:: ds 1

wColorVaryDVs:: ds 3
wColorVarySpecies:: ds 1
wColorVaryShiny:: ds 1

wPalFadeDelayFrames:: ds 1
wPalFadeDelay:: ds 1

	ds 100 ; unused

wLYOverridesBackup:: ds SCREEN_HEIGHT_PX
wLYOverridesBackupEnd::


SECTION "Battle Animations RAM", WRAMX

wBattleAnimTileDict:: ds 10

wActiveAnimObjects::
wAnimObject01:: battle_anim_struct wAnimObject01
wAnimObject02:: battle_anim_struct wAnimObject02
wAnimObject03:: battle_anim_struct wAnimObject03
wAnimObject04:: battle_anim_struct wAnimObject04
wAnimObject05:: battle_anim_struct wAnimObject05
wAnimObject06:: battle_anim_struct wAnimObject06
wAnimObject07:: battle_anim_struct wAnimObject07
wAnimObject08:: battle_anim_struct wAnimObject08
wAnimObject09:: battle_anim_struct wAnimObject09
wAnimObject10:: battle_anim_struct wAnimObject10
wActiveAnimObjectsEnd::

wActiveBGEffects::
wBGEffect1:: battle_bg_effect wBGEffect1
wBGEffect2:: battle_bg_effect wBGEffect2
wBGEffect3:: battle_bg_effect wBGEffect3
wBGEffect4:: battle_bg_effect wBGEffect4
wBGEffect5:: battle_bg_effect wBGEffect5
wActiveBGEffectsEnd::

wNumActiveBattleAnims:: ds 1

wBattleAnimFlags:: ds 1
wBattleAnimAddress:: ds 2
wBattleAnimDuration:: ds 1
wBattleAnimParent:: ds 2
wBattleAnimLoops:: ds 1
wBattleAnimVar:: ds 1
wBattleAnimByte:: ds 1
wBattleAnimOAMPointerLo:: ds 1
wBattleAnimTempOAMFlags::
wBattleAnimTemp0:: ds 1
wBattleAnimTemp1:: ds 1
wBattleAnimTempTileID::
wBattleAnimTemp2:: ds 1
wBattleAnimTempXCoord::
wBattleAnimTemp3:: ds 1
wBattleAnimTempYCoord::
wBattleAnimTemp4:: ds 1
wBattleAnimTempXOffset::
wBattleAnimTemp5:: ds 1
wBattleAnimTempYOffset::
wBattleAnimTemp6:: ds 1
wBattleAnimTemp7:: ds 1
wBattleAnimTempPalette::
wBattleAnimTemp8:: ds 1

wSurfWaveBGEffect:: ds $32
wBattleAnimEnd::
	ds $e
wSurfWaveBGEffectEnd::


SECTION "Collisions", WRAMX

wDecompressedCollisions:: ds 256 * 4


SECTION "Scratch RAM", WRAMX

UNION
wDecompressScratch:: ds $80 tiles
NEXTU
wScratchTileMap:: ds BG_MAP_WIDTH * BG_MAP_HEIGHT
wScratchAttrMap:: ds BG_MAP_WIDTH * BG_MAP_HEIGHT
ENDU


SECTION "Window Stack", WRAMX

wWindowStack:: ds $1000 - 1
wWindowStackBottom:: ds 1
