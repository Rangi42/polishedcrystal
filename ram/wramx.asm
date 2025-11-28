SECTION "WRAM 1", WRAMX

wRAM0End::
wRAM1Start:: db

wDefaultSpawnpoint:: db

UNION
; mon buffer
	ds 78
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
wTownMapPlayerIconLandmark:: db
UNION
wTownMapCursorLandmark:: db
wTownMapCursorObjectPointer:: dw
NEXTU
wTownMapCursorCoordinates:: dw
wStartFlypoint:: db
wEndFlypoint:: db
ENDU
wTownMapCanShowFly:: db

NEXTU
; phone call data
wPhoneScriptBank:: db
wPhoneCaller:: dw

NEXTU
; radio data
wCurRadioLine:: db
wNextRadioLine:: db
wRadioTextDelay:: db
wNumRadioLinesPrinted:: db
wOaksPkmnTalkSegmentCounter:: db
wRadioText:: ds 2 * SCREEN_WIDTH

NEXTU
; movement buffer data
wMovementBufferCount:: db
wMovementBufferObject:: db
	ds 3
wMovementBuffer:: ds 55

NEXTU
; trainer HUD data
	ds 1
wPlaceBallsDirection:: db
wTrainerHUDTiles:: ds 4

NEXTU
; battle exp gain
wExperienceGained:: ds 3

NEXTU
; earthquake data buffer
wEarthquakeMovementDataBuffer:: ds 5

NEXTU
; switching items in pack
wSwitchItemBuffer:: ds 2 ; may store 1 or 2 bytes

NEXTU
; Some trade stuff. Needs to be seperate from wSwitchMonBuffer.
wCurTradePartyMon:: db
wCurOTTradePartyMon:: db
wBufferTrademonNickname:: ds MON_NAME_LENGTH

; switching pokemon in party
; may store NAME_LENGTH, PARTYMON_STRUCT_LENGTH, or MAIL_STRUCT_LENGTH bytes
wSwitchMonBuffer:: ds 48

NEXTU
; giving pokemon mail
wMonMailMessageBuffer:: ds MAIL_MSG_LENGTH + 1

NEXTU
; player's room pc
UNION
wDecoNameBuffer:: ds ITEM_NAME_LENGTH
NEXTU
wNumOwnedDecoCategories:: db
wOwnedDecoCategories:: ds 16
ENDU

NEXTU
; link battle record data
wLinkBattleRecordBuffer::
wLinkBattleRecordName::   ds NAME_LENGTH
wLinkBattleRecordWins::   dw
wLinkBattleRecordLosses:: dw
wLinkBattleRecordDraws::  dw

NEXTU
wMoveScreenMode:: db ; normal, learning, reminder, deletion
wMoveScreenSelectedMove:: db ; move index
wMoveScreenCursor:: db ; cursor position
wMoveScreenOffset:: db ; offset from top of the list in view
wMoveScreenNumMoves:: db ; amount of moves in the list
wMoveScreenMoves:: ds 55

NEXTU
; miscellaneous
wTempItem::
wTempPartyCount::
wPrevPartyLevel::
wUnownPuzzleCornerTile::
wKeepSevenBiasChance::
wTempDayOfWeek::
	db

	ds 59

UNION
; trainer data
wSeenTrainerBank:: db
wSeenTrainerDistance:: db
wSeenTrainerDirection:: db
wTempTrainer::
wTempTrainerEventFlag::
wTempTrainerEventFlagLo:: db
wTempTrainerEventFlagHi:: db
wTempTrainerClass:: db
wTempTrainerID:: db
wSeenTextPointer:: dw
wWinTextPointer:: dw
wGenericTempTrainerHeaderEnd::
wLossTextPointer:: dw
wScriptAfterPointer:: dw
wTrainerPal:: db
wRunningTrainerBattleScript:: db
wTempTrainerEnd::
	ds 1
wStashedTextPointer:: dw

NEXTU
; menu items list
wMenuItemsList:: ds 16
wMenuItemsListEnd::

NEXTU
; fruit tree data
wCurFruitTree:: db
	ds 1
wCurFruit:: db

NEXTU
; item ball data
wItemBallItemID:: db
wItemBallQuantity:: db

NEXTU
; hidden item data
wHiddenItemEvent:: dw
wHiddenItemID:: db

NEXTU
; elevator data
wElevatorData::
wElevatorPointerBank:: db
wElevatorPointer::
wElevatorPointerLo:: db
wElevatorPointerHi:: db
wElevatorOriginFloor:: db
wElevatorDataEnd::

NEXTU
; coord event data
wCurCoordEvent::
wCurCoordEventSceneID:: db
wCurCoordEventMapY:: db
wCurCoordEventMapX:: db
wCurCoordEventScriptAddr:: dw

NEXTU
; BG event data
wCurBGEvent::
wCurBGEventYCoord:: db
wCurBGEventXCoord:: db
wCurBGEventType:: db
wCurBGEventScriptAddr:: dw

NEXTU
; mart data
wMartType:: db
wMartPointerBank:: db
wMartPointer:: dw
wMartJumptableIndex:: db
wBargainShopFlags:: db

NEXTU
; player movement data
wCurInput::
wFacingTileID:: db
	ds 2
wWalkingIntoEdgeWarp:: db
wMovementAnimation:: db
wWalkingDirection:: db
wFacingDirection:: db
wWalkingX:: db
wWalkingY:: db
wWalkingTileCollision:: db
	ds 6
wPlayerTurningDirection:: db

NEXTU
; temporary script buffers
wTempScriptBuffer:: db
wJumpStdScriptBuffer:: ds 15

NEXTU
; phone caller contact
	ds 1
wCallerContact:: ds PHONE_CONTACT_SIZE

NEXTU
; backup menu data
	ds 7
wMenuCursorBufferBackup:: db
wMenuScrollPositionBackup:: db

NEXTU
; poison step data
wPoisonStepData::
wPoisonStepFlagSum:: db
wPoisonStepPartyFlags:: ds PARTY_LENGTH
wPoisonStepDataEnd::
ENDU

ENDU

wBattleItemsPocketCursor:: db
wBattleMedicinePocketCursor:: db
wBattleBallsPocketCursor:: db
wBattleBerriesPocketCursor:: db
wBattleKeyItemsPocketCursor:: db
wLastBattlePocket:: db

	ds 1 ; unused

wBattleItemsPocketScrollPosition:: db
wBattleMedicinePocketScrollPosition:: db
wBattleBallsPocketScrollPosition:: db
wBattleBerriesPocketScrollPosition:: db
wBattleKeyItemsPocketScrollPosition:: db

	assert (wBattleItemsPocketScrollPosition - wBattleItemsPocketCursor) == (wItemsPocketScrollPosition - wItemsPocketCursor)

wTMHMMoveNameBackup:: ds MOVE_NAME_LENGTH

UNION
wStringBuffer1:: ds STRING_BUFFER_LENGTH + 5
wStringBuffer2:: ds STRING_BUFFER_LENGTH
wStringBuffer3:: ds STRING_BUFFER_LENGTH

UNION
; mostly used for the phone, Buffer4 is also used in some overworld events
wStringBuffer4:: ds STRING_BUFFER_LENGTH
wStringBuffer5:: ds STRING_BUFFER_LENGTH
NEXTU
wAIMoves:: ds 4 ; enemy moves excluding unusable moves
wAIMoveScore:: ds 4 ; score for each move
wAIFlags:: ds 2 ; modified from trainer struct as player get more badges
NEXTU
; Most of this data is tracked in SRAM to last between saves.
; It's only moved here as part of battle initialization, mostly.
; Thus, it's OK for it to reuse other WRAM space.
wBT_PartySelectCounter:: db
wBT_OpponentTypeArray:: ; fits within a party length.
wBT_PartySelections:: ds PARTY_LENGTH
wBT_MonParty:: ds BATTLETOWER_PARTYDATA_SIZE
wBT_SecondaryMonParty:: ds BATTLETOWER_PARTYDATA_SIZE ; last rental trainer
wBT_OTMonParty:: ds BATTLETOWER_PARTYDATA_SIZE ; also for starting rental setup
NEXTU
; Seen/Own iterator handling.
wTempDex::
wTempDexSeen:: dw
wTempDexOwn:: dw
wTempDexLast:: dw ; the last species marked as seen
wTempDexEnd::
NEXTU
wTempPocketCursor:: ds NUM_POCKETS
NEXTU
wCandyMaxLevelExp:: ds 3
wCandyPrevLevel:: db
ENDU
ENDU

wBattleMenuCursorBuffer:: dw

wCurBattleMon:: db
wCurMoveNum:: db

	ds 1 ; unused

wPCItemsCursor:: db
wPartyMenuCursor:: db
wItemsPocketCursor:: db
wMedicinePocketCursor:: db
wBallsPocketCursor:: db
wBerriesPocketCursor:: db
wKeyItemsPocketCursor:: db

wPCItemsScrollPosition:: db
wPartyMenuScrollPosition:: db ; unused
wItemsPocketScrollPosition:: db
wMedicinePocketScrollPosition:: db
wBallsPocketScrollPosition:: db
wBerriesPocketScrollPosition:: db
wKeyItemsPocketScrollPosition:: db

wSwitchMon::
wSwitchItem::
wMoveSwapBuffer:: db

wMenuScrollPosition:: ds 4

wQueuedScriptBank:: db
wQueuedScriptAddr:: dw

wNumMoves:: db

wFieldMoveSucceeded::
wItemEffectSucceeded::
wBattlePlayerAction::
; 0 - use move
; 1 - use item
; 2 - switch
wSolvedUnownPuzzle::
	db

wStateFlags::
; bit 0: overworld sprite updating on/off
; bit 1: last 12 sprite OAM structs reserved
; bit 6: in text state
; bit 7: in scripted movement
	db

wBattleResult::
; bit 7: mon is captured and sent to PC
; bit 6: legendary is captured (used for Celebi)
; bit 1: set on fleeing
; value of %xxxx0002: link battle draw (x is ignored)
; value of %xx000001: whiteout
	db

wUsingItemWithSelect:: db

UNION
; mart data
wCurMart:: ds 16
wCurMartEnd::
NEXTU
; miscellaneous
wCurElevator:: db
wCurElevatorFloors:: db
NEXTU
wInverseBattleScore::
wCurMessageScrollPosition:: db
wCurMessageIndex:: db
wMailboxCount:: db
wMailboxItems:: ds MAILBOX_CAPACITY
wMailboxEnd:: db
ENDU

wCurIconMonHasItemOrMail:: db

wCurBadge::
wCurSpecialItem::
wCurExpCandy::
wCurApricorn::
wCurKeyItem::
wCurTMHM::
wCurItem::
wCurWing::
	db
wMartItemID::
wCurItemQuantity::
wCurWingQuantity::
wGiftMonBall::
	db

wCurPartySpecies:: db

wCurPartyMon::
; contains which monster in a party
; is being dealt with at the moment
; 0-5
	db

wWhichHPBar::
; 0: Enemy
; 1: Player
; 2: Party Menu
	db

wPokemonWithdrawDepositParameter::
; 0: Take from PC
; 1: Put into PC
; 2: Take from Day-Care
; 3: Put into Day-Care
	db

wItemQuantityChangeBuffer:: db
wItemQuantityBuffer:: db

wSpriteFlags::
; 5: use vbk1 if set, otherwise vbk0
	db

wHandlePlayerStep:: db

wPartyMenuActionText:: db

wItemAttributeParamBuffer:: db

wCurPartyLevel:: db

wScrollingMenuListSize:: dw

; used when following a map warp
wFollowedWarpData::
wNextWarp:: db
wNextMapGroup:: db
wNextMapNumber:: db
wPrevWarp:: db
wPrevMapGroup:: db
wPrevMapNumber:: db
wFollowedWarpDataEnd::

wPlayerBGMapOffsetX:: db ; used in FollowNotExact; unit is pixels
wPlayerBGMapOffsetY:: db ; used in FollowNotExact; unit is pixels

; Player movement
wPlayerStepVectorX:: db
wPlayerStepVectorY:: db
wPlayerStepFlags::
; bit 7: Start step
; bit 6: Stop step
; bit 5: Doing step
; bit 4: In midair
; bits 0-3: unused
	db
wPlayerStepDirection:: db

wSpinning:: db

wBGMapAnchor:: dw

wOldTileset:: db

UNION
wTempMon:: party_struct wTempMon
wTempMonNickname:: ds MON_NAME_LENGTH
wTempMonOT:: ds PLAYER_NAME_LENGTH
wTempMonExtra::
wTempMonHyperTraining:: db
	ds 2 ; the other 2 extra bytes
NEXTU
wEncodedTempMon:: savemon_struct wEncodedTempMon
NEXTU
wPokedexShowPointerAddr:: dw
wPokedexShowPointerBank:: db
NEXTU
wPokedexShowNextLine:: ds SCREEN_WIDTH
ENDU

; Points towards box + slot if using GetStorageBoxMon. Slot set to 0 if empty.
wTempMonBox:: db
wTempMonSlot:: db

wDexCacheValid:: db
wDexCacheSeen:: dw
wDexCacheOwn:: dw
wDexPrevCursorPos:: db
wDexPrevOffset:: db

	ds 32 ; unused

wOverworldMapAnchor:: dw
wMetatileStandingY:: db
wMetatileStandingX:: db

	ds 1 ; unused

wMapTileset:: db
wEnvironment:: db
wSign:: db

	ds 1 ; unused

wMapAttributes::
wMapBorderBlock:: db
; width/height are in blocks (2x2 walkable tiles, 4x4 graphics tiles)
wMapHeight:: db
wMapWidth:: db
wMapBlocksBank:: db
wMapBlocksPointer:: dw
wMapScriptsBank:: db
wMapScriptsPointer:: dw
; bit set
wMapConnections:: db
wMapAttributesEnd::

wNorthMapConnection:: map_connection_struct wNorth
wSouthMapConnection:: map_connection_struct wSouth
wWestMapConnection:: map_connection_struct wWest
wEastMapConnection:: map_connection_struct wEast

wTileset::
wTilesetDataBank:: db
wTilesetBlocksAddress:: dw
wTilesetCollisionAddress:: dw
wTilesetAttributesAddress:: dw
wTilesetGFX0Bank:: db
wTilesetGFX0Address:: dw
wTilesetGFX1Bank:: db
wTilesetGFX1Address:: dw
wTilesetGFX2Bank:: db
wTilesetGFX2Address:: dw
wTilesetAnim:: dw ; BANK(_AnimateTileset)
wTilesetEnd::

	ds 2 ; unused

wEvolvableFlags:: flag_array PARTY_LENGTH

wForceEvolution:: db

UNION
; general-purpose buffers
wBuffer1:: db
wBuffer2:: db
wBuffer3:: db
wBuffer4:: db
wBuffer5:: db
wBuffer6:: db

NEXTU
; HP bar animations
wCurHPAnimMaxHP:: dw
wCurHPAnimOldHP:: dw
wCurHPAnimNewHP:: dw
wCurHPAnimPal:: db
wCurHPBarPixels:: db
wNewHPBarPixels:: db
wCurHPAnimDeltaHP:: dw
wCurHPAnimLowHP:: db
wCurHPAnimHighHP:: db

NEXTU
; evolution data
wEvolutionOldSpecies:: db
wEvolutionOldForm:: db
wEvolutionNewSpecies:: db
wEvolutionNewForm:: db
wEvolutionPicOffset:: db
wEvolutionCanceled:: db

NEXTU
; Magikarp length
wMagikarpLengthMm::
wMagikarpLengthMmHi:: db
wMagikarpLengthMmLo:: db

NEXTU
; mint tea woman
wMintTeaPartyMon:: db
wMintTeaLikedFlavor:: db
wMintTeaDislikedFlavor:: db

NEXTU
; link data
	ds 9
wLinkBattleRNPreamble:: ds 4
wLinkBattleRNs:: ds 10

NEXTU
; battle data
	ds 7
wCurEnemyItem:: db
	ds 15

ENDU

	ds 2 ; unused

wEnemyMon:: battle_struct wEnemyMon

wTempBattleMonSpecies:: db
wTempBattleMonForm:: db
wTempEnemyMonSpecies:: db
wTempEnemyMonForm:: db

	ds 1 ; unused

wEnemyMonCatchRate:: db
wEnemyMonBaseExp:: db
wEnemyMonEnd::

wBattleMode::
; 0: overworld
; 1: wild battle
; 2: trainer battle
	db

wBT_TrainerTextIndex::
wTempWildMonSpecies:: db

wOtherTrainerClass::
; class (Youngster, Bug Catcher, etc.) of opposing trainer
; 0 if opponent is a wild Pokémon, not a trainer
	db

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
	db

wOtherTrainerID::
; which trainer of the class that you're fighting
; (Joey, Mikey, Albert, etc.)
	db

wTrainerClass:: db

wMoveSelectionMenuType::
; 0: battle move selection
; 1: pp restore selection
; 2: conversion selection
	db

wCurBaseData::
wBaseStats::
wBaseHP:: db
wBaseAttack:: db
wBaseDefense:: db
wBaseSpeed:: db
wBaseSpecialAttack:: db
wBaseSpecialDefense:: db
wBaseType::
wBaseType1:: db
wBaseType2:: db
wBaseCatchRate:: db
wBaseExp:: db
wBaseItems:: dw
wBaseGender::
wBaseEggSteps:: db
wBaseAbility1:: db
wBaseAbility2:: db
wBaseHiddenAbility:: db
wBaseGrowthRate:: db
wBaseEggGroups:: db
wBaseEVYield1:: db
wBaseEVYield2:: db
wBaseTMHM:: flag_array NUM_TM_HM_TUTOR
wCurBaseDataEnd::

	ds 1 ; unused

wCurDamage:: dw

wMornEncounterRate:: db
wDayEncounterRate:: db
wNiteEncounterRate:: db
wEveEncounterRate:: db
wWaterEncounterRate:: db

wListMoves_MoveIndicesBuffer:: ds NUM_MOVES
wPutativeTMHMMove:: db
wForgettingMove:: db
wTotalBattleTurns:: db

wNamedObjectIndex::
wTextDecimalByte::
wTempByteValue::
wNumSetBits::
wTypeMatchup::
wTempSpecies::
wTempIconSpecies::
wTempKeyItem::
wTempTMHM::
wTempPP::
wChosenCableClubRoom::
wBreedingCompatibility::
wMoveGrammar::
wApplyStatLevelMultipliersToEnemy::
wUsePPUp::
	db

wTempForm:: db

	ds 1 ; unused

wMonTriedToEvolve:: db

wTimeOfDay:: db

wOtherTrainerType:: db

wTrainerGroupBank:: db


SECTION "Enemy Party", WRAMX

	ds 2 ; unused

wEnemyFleeing:: db
wNumFleeAttempts:: db

wOTPartyData::
wOTPlayerName:: ds NAME_LENGTH
wOTPlayerID:: dw
wOTPartyCount:: db

wMirrorHerbPendingBoosts::
	; 7 sets of nibbles $xy, one for each stat. x = player, y = enemy.
	ds NUM_LEVEL_STATS - 1 ; ignore MULTIPLE_STATS

UNION
wOTPartyMons::
for n, 1, PARTY_LENGTH + 1
wOTPartyMon{d:n}:: party_struct wOTPartyMon{d:n}
endr

wOTPartyMonOTs::
for n, 1, PARTY_LENGTH + 1
wOTPartyMon{d:n}OT:: ds PLAYER_NAME_LENGTH
wOTPartyMon{d:n}Extra:: ds 3
endr

wOTPartyMonNicknames::
for n, 1, PARTY_LENGTH + 1
wOTPartyMon{d:n}Nickname:: ds MON_NAME_LENGTH
endr
wOTPartyDataEnd::

NEXTU
	ds PARTYMON_STRUCT_LENGTH ; skip first OT partymon since wildmon use that

; catch tutorial dude bag
wDudeBag::
wDudeNumItems:: db
wDudeItems: ds 2 * 2
wDudeItemsEnd:: db
wDudeNumMedicine:: db
wDudeMedicine:: ds 3 * 2
wDudeMedicineEnd:: db
wDudeNumBalls:: db
wDudeBalls:: ds 2 * 2
wDudeBallsEnd:: db
wDudeBagEnd::

ENDU

wBattleAction:: db
wLinkBattleSentAction:: db

wMapStatus:: db
wMapEventStatus::
; 0: do map events
; 1: do background events
	db

wScriptFlags::
wScriptFlags1::
; bit 3: run deferred script
	db
wScriptFlags2::
	db
wEnabledPlayerEvents::
; bit 0: count steps
; bit 1: xy triggers
; bit 2: warps and connections
; bit 4: wild encounters
; bit 5: unknown
	db

wScriptMode:: db
wScriptRunning:: db

	ds 3 ; unused

wScriptStackSize:: db
wScriptStack:: ds 3 * 12
wScriptDelay:: db

wDeferredScriptBank::
wScriptTextBank::
	db
wDeferredScriptAddr::
wScriptTextAddr::
	dw

wWildEncounterCooldown:: db

wWildBattlePanic:: db

wBattleScriptFlags:: db
wWildMonForm:: db

wPlayerSpriteSetupFlags::
; bit 7: if set, cancel wPlayerAction
; bit 6: RefreshMapSprites doesn't reload player sprite
; bit 5: if set, set facing according to bits 0-1
; bit 2: female player has been transformed into male
; bits 0-1: direction facing
	db

wMapReentryScriptQueueFlag:: db ; MemScriptFlag
wMapReentryScriptBank:: db ; MemScriptBank
wMapReentryScriptAddress:: dw ; MemScriptAddr

wTimeCyclesSinceLastCall:: db
wReceiveCallDelay_MinsRemaining:: db
wReceiveCallDelay_StartTime:: ds 3

wBugContestMinsRemaining:: db
wBugContestSecsRemaining:: db

	ds 2 ; unused

wMapStatusEnd::

	ds 2 ; unused


SECTION "Game Data", WRAMX

wGameData::
wPlayerData::
wPlayerID:: dw

wPlayerGender:: db

wPlayerName:: ds NAME_LENGTH
wRivalName:: ds NAME_LENGTH
wBackupName:: ds NAME_LENGTH

wTrendyPhrase:: ds NAME_LENGTH

wSavedAtLeastOnce:: db
wSpawnAfterChampion:: db

; init time set at newgame
wStartDay:: db
wStartHour:: db
wStartMinute:: db
wStartSecond:: db

wRTC:: ds 4 ; in-game wall clock time at save

	ds 4 ; unused

wDST::
; bit 7: dst
	db

wGameTimeCap:: db ; flag for timer hitting 999:59:59.00
wGameTimeHours:: dw
wGameTimeMinutes:: db
wGameTimeSeconds:: db
wGameTimeFrames:: db

wCurDay:: db

; no-RTC patch needs to save/restore rtc state
; builds with rtc will simply overwrite the saved value
wRTCDayHi::   db
wRTCDayLo::   db
wRTCHours::   db
wRTCMinutes:: db
wRTCSeconds:: db

wPlayerGoingUpStairs:: db

wObjectFollow_Leader:: db
wObjectFollow_Follower:: db
wCenteredObject:: db
wFollowerMovementQueueLength:: db
wFollowMovementQueue:: ds 5

wObjectStructs::
wPlayerStruct::      object_struct wPlayer
for n, 1, NUM_OBJECT_STRUCTS ; discount player
wObject{d:n}Struct:: object_struct wObject{d:n}
endr
wObjectStructsEnd::

wStoneTableAddress:: dw

wBattleTowerCurStreak:: dw
wBattleTowerTopStreak:: dw
wBattleFactoryCurStreak:: dw
wBattleFactoryTopStreak:: dw
wBattleFactorySwapCount:: db ; Amount of swaps performed.

wMapObjects::
wPlayerObject::   map_object wPlayer
for n, 1, NUM_OBJECTS ; discount player
wMap{d:n}Object:: map_object wMap{d:n}
endr
wMapObjectsEnd::

wObjectMasks:: ds NUM_OBJECTS

wVariableSprites:: ds $100 - SPRITE_VARS

wStatusFlags3::
	; 0 - judge machine
	db

wEnteredMapFromContinue:: db

wTimeOfDayPal:: db

	ds 4 ; unused

wTimeOfDayPalFlags:: db
wTimeOfDayPalset:: db
wCurTimeOfDay:: db

wSecretID:: dw

wStatusFlags::
	; bit 0: pokedex
	; bit 1: unown dex
	; bit 2: flash
	; bit 3: caught pokerus
	; bit 4: rocket signal
	; bit 5: wild encounters on/off
	; bit 6: hall of fame
	; bit 7: bug contest on (unused?)
	db

wStatusFlags2::
	; bit 0: rockets
	; bit 1: safari game
	; bit 2: bug contest timer
	; bit 3: seen shamouti island
	; bit 4: bike shop call
	; bit 5: using sweet honey
	; bit 6: exorcised lav radio tower
	; bit 7: rockets in mahogany
	db

wMoney:: ds 3
wMomsMoney:: ds 3
wMoneyEnd::
wMomSavingMoney:: db

wCoins:: dw

wBadges::
wJohtoBadges:: flag_array NUM_JOHTO_BADGES
wKantoBadges:: flag_array NUM_KANTO_BADGES
wBadgesEnd::

wPokemonJournals:: flag_array NUM_POKEMON_JOURNALS
wPokemonJournalsEnd::

wTMsHMs:: flag_array NUM_TMS + NUM_HMS
wTMsHMsEnd::

wKeyItems:: ds NUM_KEY_ITEMS + 1
wKeyItemsEnd::

wNumItems:: db
wItems:: ds MAX_ITEMS * 2 + 1
wItemsEnd::

wNumMedicine:: db
wMedicine:: ds MAX_MEDICINE * 2 + 1
wMedicineEnd::

wNumBalls:: db
wBalls:: ds MAX_BALLS * 2 + 1
wBallsEnd::

wNumBerries:: db
wBerries:: ds MAX_BERRIES * 2 + 1
wBerriesEnd::

wNumPCItems:: db
wPCItems:: ds MAX_PC_ITEMS * 2 + 1
wPCItemsEnd::

wApricorns:: ds NUM_APRICORNS

wPokegearFlags::
; bit 0: map
; bit 1: radio
; bit 2: phone
; bit 3: expn
; bit 7: on/off
	db
wRadioTuningKnob:: db
wPokedexMode:: db

wTMHMPocketScrollPosition:: db
wTMHMPocketCursor::
; beyond the cursor position, bit 7 also controls how TMs are sorted
	db

wPlayerState:: db

wHallOfFameCount:: dw
wTradeFlags:: flag_array PARTY_LENGTH

wMooMooBerries:: db
wUndergroundSwitchPositions:: db
wFarfetchdPosition:: db

; map triggers
wAlways0SceneID:: db
wAzaleaTownSceneID:: db
wBattleFacilitySceneID:: db
wRoute39RuggedRoadGateSceneID:: db
wRuggedRoadSouthSceneID:: db
wSnowtopMountainOutsideSceneID:: db
wBattleTowerOutsideSceneID:: db
wBellchimeTrailSceneID:: db
wBrunosRoomSceneID:: db
wBurnedTower1FSceneID:: db
wBurnedTowerB1FSceneID:: db
wCeruleanCapeSceneID:: db
wCeruleanCave1FSceneID:: db
wCeruleanGymSceneID:: db
wCherrygroveCitySceneID:: db
wCianwoodCitySceneID:: db
wCinnabarLabSceneID:: db
wColosseumSceneID:: db
wDarkCaveVioletEntranceSceneID:: db
wDayCareSceneID:: db
wDragonsDenB1FSceneID:: db
wDragonShrineSceneID:: db
wEcruteakGymSceneID:: db
wEcruteakHouseSceneID:: db
wRocketHideoutB4FSceneID:: db
wElmsLabSceneID:: db
wFarawayIslandSceneID:: db
wFastShip1FSceneID:: db
wFastShipB1FSceneID:: db
wGiovannisCaveSceneID:: db
wGoldenrodCitySceneID:: db
wGoldenrodGymSceneID:: db
wGoldenrodMuseum1FSceneID:: db
wHallOfFameSceneID:: db
wIlexForestSceneID:: db
wKarensRoomSceneID:: db
wKogasRoomSceneID:: db
wPlayersHouse1FSceneID:: db
wLancesRoomSceneID:: db
wLavenderTownSceneID:: db
wMahoganyMart1FSceneID:: db
wMahoganyTownSceneID:: db
wMountMoon1FSceneID:: db
wMrPokemonsHouseSceneID:: db
wMystriStageSceneID:: db
wNewBarkTownSceneID:: db
wOlivineCitySceneID:: db
wOlivinePortSceneID:: db
wPokecenter2FSceneID:: db
wPokemonLeagueGateSceneID:: db
wPowerPlantSceneID:: db
wRadioTower5FSceneID:: db
wRoute10NorthSceneID:: db
wRoute23SceneID:: db
wRoute24SceneID:: db
wRoute27SceneID:: db
wRoute29SceneID:: db
wRoute32SceneID:: db
wRoute34SceneID:: db
wRoute35NationalParkGateSceneID:: db
wRoute36NationalParkGateSceneID:: db
wRoute36SceneID:: db
wRoute42SceneID:: db
wRoute43GateSceneID:: db
wRoute47SceneID:: db
wRoute48SceneID:: db
wRuinsOfAlphAerodactylChamberSceneID:: db
wRuinsOfAlphHoOhChamberSceneID:: db
wRuinsOfAlphInnerChamberSceneID:: db
wRuinsOfAlphKabutoChamberSceneID:: db
wRuinsOfAlphOmanyteChamberSceneID:: db
wRuinsOfAlphOutsideSceneID:: db
wRuinsOfAlphResearchCenterSceneID:: db
wSeagallopFerryNavelGateSceneID:: db
wSeagallopFerryShamoutiGateSceneID:: db
wSeagallopFerryVermilionGateSceneID:: db
wShamoutiHotelRestaurantSceneID:: db
wSproutTower3FSceneID:: db
wTeamRocketBaseB2FSceneID:: db
wTeamRocketBaseB3FSceneID:: db
wTinTower1FSceneID:: db
wTradeCenterSceneID:: db
wUndergroundPathSwitchRoomEntrancesSceneID:: db
wVermilionCitySceneID:: db
wVermilionPortSceneID:: db
wVictoryRoad2FSceneID:: db
wVioletGymSceneID:: db
wWillsRoomSceneID:: db
wWiseTriosRoomSceneID:: db
wYellowForestSceneID:: db

; fight counts
wJackFightCount::    db
wBeverlyFightCount:: db ; unused
wHueyFightCount::    db
wGavenFightCount::   db
wBethFightCount::    db
wJoseFightCount::    db
wReenaFightCount::   db
wJoeyFightCount::    db
wWadeFightCount::    db
wRalphFightCount::   db
wLizFightCount::     db
wAnthonyFightCount:: db
wToddFightCount::    db
wGinaFightCount::    db
wIrwinFightCount::   db ; unused
wArnieFightCount::   db
wAlanFightCount::    db
wDanaFightCount::    db
wChadFightCount::    db
wDerekFightCount::   db ; unused
wTullyFightCount::   db
wBrentFightCount::   db
wTiffanyFightCount:: db
wVanceFightCount::   db
wWiltonFightCount::  db
wKenjiFightCount::   db ; unused
wParryFightCount::   db
wErinFightCount::    db

wEventFlags:: flag_array NUM_EVENTS

wCurBox:: db

wPlayerCaught:: db
wPlayerCaught2:: db

wUsedObjectPals:: db
for n, 8
wLoadedObjPal{d:n}:: db
endr
wNeededPalIndex:: db

wEmotePal:: db

	ds 64 ; unused

wCandyAmounts::
wExpCandyXSAmount:: db
wExpCandySAmount:: db
wExpCandyMAmount:: db
wExpCandyLAmount:: db
wExpCandyXLAmount:: db

wWingAmounts::
wHealthWingAmount:: dw
wMuscleWingAmount:: dw
wResistWingAmount:: dw
wSwiftWingAmount:: dw
wGeniusWingAmount:: dw
wCleverWingAmount:: dw

wCelebiEvent:: db

wDailyTrainerHouseOpponent:: db

wOWState:: dw

wCurMapSceneScriptPointer:: dw

wCurCaller:: dw
wCurMapWarpEventCount:: db
wCurMapWarpEventsPointer:: dw
wCurMapCoordEventCount:: db
wCurMapCoordEventsPointer:: dw
wCurMapBGEventCount:: db
wCurMapBGEventsPointer:: dw
wCurMapObjectEventCount:: db
wCurMapObjectEventsPointer:: dw
wCurMapSceneScriptCount:: db
wCurMapSceneScriptsPointer:: dw
wCurMapCallbackCount:: db
wCurMapCallbacksPointer:: dw

	ds 1 ; unused

; Sprite id of each decoration
wDecoBed:: db
wDecoCarpet:: db
wDecoPlant:: db
wDecoPoster:: db
wDecoConsole:: db
wDecoLeftOrnament:: db
wDecoRightOrnament:: db
wDecoBigDoll:: db

; Items bought from Mom
wWhichMomItem:: db
wWhichMomItemSet:: db
wMomItemTriggerBalance:: ds 3

wDailyResetTimer:: dw
wDailyFlags:: db
wDailyFlags2:: db
wDailyFlags3:: db
wDailyFlags4:: db
wWeeklyFlags:: db
wWeeklyFlags2:: db
wSwarmFlags:: db
wTimerEventStartDay:: db

wFruitTreeFlags:: flag_array NUM_FRUIT_TREES

	ds 19 ; unused

wHiddenGrottoContents::
; dbw content type, content id
	ds NUM_HIDDEN_GROTTOES * 3

wLastMapYCoord:: db ; current y coordinate relative to top-left corner of the previous map
wLastMapXCoord:: db ; current x coordinate relative to top-left corner of previous map

wCurHiddenGrotto:: db

wLuckyNumberDayBuffer:: dw
wSpecialPhoneCallID:: db
wBugContestStartTime:: ds 4 ; day, hour, min, sec

wLastPocket:: db

wBuenasPassword:: db
wBlueCardBalance:: db

wBugContestOfficerPrize:: db

wInPokegear:: db
wWalkingOnBridge:: db

wDailyRematchFlags:: ds 4
wDailyPhoneItemFlags:: ds 4
wDailyPhoneTimeOfDayFlags:: ds 4
wKenjiBreakTimer:: dw ; Kenji
wYanmaMapGroup:: db
wYanmaMapNumber:: db

wVermilionGymTrashCan1:: db
wVermilionGymTrashCan2:: db

wBattlePoints:: dw
wBattlePointsEnd::

wStepCount:: db
wPoisonStepCount:: db

wPhoneList:: flag_array NUM_PHONE_CONTACTS
wPhoneListEnd::

	ds 1 ; unused

wParkBallsRemaining::
wSafariBallsRemaining:: db
wSafariTimeRemaining:: dw

wLuckyNumberShowFlag:: dw
wLuckyIDNumber:: dw

wRepelEffect:: db ; If a Repel is in use, it contains the nr of steps it's still active
wRepelType:: db

wBikeStep:: dw

wKurtApricornQuantity:: db

wPlayerDataEnd::

wCurMapData::

wVisitedSpawns:: flag_array NUM_SPAWNS

wDigWarpNumber:: db
wDigMapGroup:: db
wDigMapNumber:: db

; used on maps like second floor pokécenter, which are reused, so we know which
; map to return to
wBackupWarpNumber:: db
wBackupMapGroup:: db
wBackupMapNumber:: db

wLastSpawnMapGroup:: db
wLastSpawnMapNumber:: db

wWarpNumber:: db
wMapGroup:: db ; map group of current map
wMapNumber:: db ; map number of current map
wYCoord:: db ; current y coordinate relative to top-left corner of current map
wXCoord:: db ; current x coordinate relative to top-left corner of current map
wScreenSave:: ds SCREEN_META_WIDTH * SCREEN_META_HEIGHT

wCurMapDataEnd::


SECTION "Party", WRAMX

wPokemonData::

wPartyCount::   db ; number of Pokémon in party

	ds 7 ; unused

wPartyMons::
for n, 1, PARTY_LENGTH + 1
wPartyMon{d:n}:: party_struct wPartyMon{d:n}
endr

wPartyMonOTs::
for n, 1, PARTY_LENGTH + 1
wPartyMon{d:n}OT:: ds PLAYER_NAME_LENGTH
wPartyMon{d:n}Extra::
wPartyMon{d:n}HyperTraining:: db
	ds 2 ; the other 2 extra bytes
endr

wPartyMonNicknames::
for n, 1, PARTY_LENGTH + 1
wPartyMon{d:n}Nickname:: ds MON_NAME_LENGTH
endr
wPartyMonNicknamesEnd::

	ds 1 ; unused

wPokedexFlags::
wPokedexCaught:: flag_array NUM_UNIQUE_POKEMON
wEndPokedexCaught::

wPokedexSeen:: flag_array NUM_UNIQUE_POKEMON
wEndPokedexSeen::
wEndPokedexFlags::

wUnlockedUnowns:: db

	ds 2 ; unused

wDayCareMan::
; bit 7: active
; bit 6: monsters are compatible
; bit 5: egg ready
; bit 0: monster 1 in daycare
	db

wBreedMon1Nickname:: ds MON_NAME_LENGTH
wBreedMon1OT:: ds PLAYER_NAME_LENGTH
wBreedMon1Extra:: ds 3
wBreedMon1:: breed_struct wBreedMon1

wDayCareLady::
; bit 7: active
; bit 0: monster 2 in daycare
	db

wStepsToEgg:: db
wBreedMotherOrNonDitto::
;  z: yes
; nz: no
	db

wBreedMon2Nickname:: ds MON_NAME_LENGTH
wBreedMon2OT:: ds PLAYER_NAME_LENGTH
wBreedMon2Extra:: ds 3
wBreedMon2:: breed_struct wBreedMon2

; TODO: space for a Day-Care on Route 5 which just levels up one Pokémon;
; Route 34 will have a Nursery that breeds with two Pokémon.
wLevelUpMonNickname:: ds MON_NAME_LENGTH
wLevelUpMonOT:: ds PLAYER_NAME_LENGTH
wLevelUpMonExtra:: ds 3
wLevelUpMon:: breed_struct wLevelUpMon

wBugContestBackupPartyCount:: db
wContestMon:: party_struct wContestMon

wDunsparceMapGroup:: db
wDunsparceMapNumber:: db
wFishingSwarmFlag:: db

wRoamMon1:: roam_struct wRoamMon1
wRoamMon2:: roam_struct wRoamMon2
wRoamMon3:: roam_struct wRoamMon3

	ds 4 ; previously used

wBestMagikarpLengthMm::
wBestMagikarpLengthMmHi:: db
wBestMagikarpLengthMmLo:: db
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
	db

; You can map 4 items, to select + directions
wRegisteredItems:: ds 4

wPokemonDataEnd::
wGameDataEnd::


SECTION "Sound Stack", WRAMX

wSoundEngineBackup:: ds wChannelsEnd - wMusic
wBackupMapMusic:: db
wSoundEngineBattleBackup:: ds wChannelsEnd - wMusic
wBattleBackupMapMusic:: db


SECTION "Music Player RAM", WRAMX

wMPNotes:: ds 4 * 256


SECTION "Pic Animations RAM", WRAMX

wTempTileMap::
; 20x18 grid of 8x8 tiles
	ds SCREEN_AREA

; PokeAnim data
wPokeAnimStruct::
wPokeAnimSceneIndex:: db
wPokeAnimPointer:: dw
wPokeAnimSpecies:: db
wPokeAnimVariant:: db
	ds 1 ; unused
wPokeAnimGraphicStartTile:: db
wPokeAnimCoord:: dw
wPokeAnimFrontpicHeight:: db
wPokeAnimIdleFlag:: db
wPokeAnimSpeed:: db
wPokeAnimPointerBank:: db
wPokeAnimPointerAddr:: dw
wPokeAnimFramesBank:: db
wPokeAnimFramesAddr:: dw
wPokeAnimBitmaskBank:: db
wPokeAnimBitmaskAddr:: dw
wPokeAnimFrame:: db
wPokeAnimJumptableIndex:: db
wPokeAnimRepeatTimer:: db
wPokeAnimCurBitmask:: db
wPokeAnimWaitCounter:: db
wPokeAnimCommand:: db
wPokeAnimParameter:: db
	ds 1 ; unused
wPokeAnimBitmaskCurCol:: db
wPokeAnimBitmaskCurRow:: db
wPokeAnimBitmaskCurBit:: db
wPokeAnimBitmaskBuffer:: db
	ds 8 ; unused
wPokeAnimStructEnd::


SECTION "Used Storage", WRAMX

wPokeDB1UsedEntries:: flag_array MONDB_ENTRIES
wPokeDB1UsedEntriesEnd::

wPokeDB2UsedEntries:: flag_array MONDB_ENTRIES
wPokeDB2UsedEntriesEnd::


SECTION "Sprites Backup", WRAMX

wShadowOAMBackup::
; wShadowOAMSpriteBackup00 - wShadowOAMSpriteBackup39
for n, OAM_COUNT
wShadowOAMSpriteBackup{02d:n}:: sprite_oam_struct wShadowOAMSpriteBackup{02d:n}
endr
wShadowOAMBackupEnd::


SECTION UNION "Metatiles", WRAMX

wDecompressedMetatiles:: ds 256 tiles


SECTION UNION "Metatiles", WRAMX

UNION
wDex2bpp:: ds $60 tiles

NEXTU
; copied using hdma transfers (which is orders of magnitudes faster), so it uses
; 32x19 as opposed to only the 21x19 that we need.
wDexTilemap:: ds TILEMAP_WIDTH * (SCREEN_HEIGHT + 1)
wDexAttrmap:: ds TILEMAP_WIDTH * (SCREEN_HEIGHT + 1)
wDexMapEnd::

UNION
wDexVWFTiles:: ds 19 tiles ; 1 tile padding
wDexIconTiles:: ds 24 tiles ; 4 tiles padding
wDexRowTilesDest::
wDexVWFTilesDest:: dw
wDexIconTilesDest:: dw
NEXTU
; Copied using GDMA in VBlank. Ideally we want to do GDMA as part of hblank,
; but there is some issues with that yet to be fully researched (issue #639).
	ds 49 tiles
wDexMonTiles::
wDexMonType1Tiles:: ds 4 tiles
wDexMonType2Tiles:: ds 4 tiles
wDexMonFootprintTiles:: ds 4 tiles
wDexMonIconTiles:: ds 4 tiles
wDexMonShapeTiles:: ds 4 tiles
wDexAreaTypeTiles:: ds 7 tiles
wDexAreaTypeTilesEnd::
ENDU

; Copy of dex row tile info. H-Blank uses a copy in wram0.
wDexPalCopy::
wDexRow1Tile: db ; Sprite offset for dex minis col 2-4
wDexRow1Pals:: ds COLOR_SIZE * 3 * 5 ; 3 15bit colors per pal, 5 columns
wDexRow2Tile: db
wDexRow2Pals:: ds COLOR_SIZE * 3 * 5
wDexRow3Tile: db
wDexRow3Pals:: ds COLOR_SIZE * 3 * 5
wDexPalCopyEnd::

wDexNoStr::
wDexNoStrBall:: db ; ball if caught, $7f otherwise
wDexNoStrNo:: ds 2 ; "No."
wDexNoStrNumber:: ds 3 ; the dex number

; These are for the list view. For the "No.123", see wPokedexOAM_DexNo in wram0.
wDexNumber:: dw
wDexNumberString:: ds 4 ; 3 numbers including leading zeroes + terminator

; Landmark to highlight if mon is at player location. Note that this is exact,
; including things like the proper floor. This is -1 to denote no highlight,
wDexAreaHighlight:: db

; Needed because when we reload the screen, wShadowOAM is wiped clean.
wDexAreaHighlightY:: db
wDexAreaHighlightX:: db

wDexAreaValidGroups::
UNION
wDexAreaValidFishGroups:: ds NUM_FISHGROUPS
NEXTU
wDexAreaValidTreeGroups:: ds NUM_TREEMON_SETS
ENDU
wDexAreaValidGroupsEnd::

	assert HIGH(wDexAreaValidGroupsEnd) == HIGH(wDexAreaValidGroups)

; The last location type the player cycled to explicitly.
; The game will try to prefer this when changing region/mon/form. Updates when:
; * the player presses A, cycling to a different location type
; * the player switches mon/form if the last region is different from current,
;   and area is NOT unknown for the current region.
wDexAreaLastMode:: db

; Table of xy coords for landmarks. These contain either zero, or xy of the
; landmark to display. We don't actually care about the exact landmark beyond
; knowing if we should highlight the one that players are at (see above).

	; Used to align wDexAreaMons. Feel free to add more data here, just don't
	; let wDexAreaMons be misaligned (an assert will tell you if you do).
	ds 4

ALIGN 8
wDexAreaMons::
; Array size needs to be a multiple of 10 covering all landmarks for a region.
; Upper cap is 120.
for n, 1, 100
wDexAreaMon{d:n}::
wDexAreaMon{d:n}YCoord:: db
wDexAreaMon{d:n}XCoord:: db
endr
wDexAreaMonsTerminator:: db
wDexAreaMonsEnd::

; Bitflag array of regions with locations for each area type
wDexAreaRegionLocations:: ds NUM_DEXAREAS

; Things handled by hblank
wDexAreaMonOffset:: db ; current area mon index to process in h-blank
wDexAreaSpriteSlot:: db ; LOW(address) to oamSprite to use.
wDexAreaModeCopy:: db ; written to from hPokedexAreaMode on screen reload

	; Used to align wDexAreaMons2. Feel free to add more data here, just don't
	; let wDexAreaMons2 be misaligned (an assert will tell you if you do).
	ds 43

ALIGN 8
wDexAreaMons2:: ds (wDexAreaMonsEnd - wDexAreaMons)

	; Used to align wDexAreaShadowOAM. Feel free to add more data here, just
	; don't let it be misaligned.
	ds 57

ALIGN 8
wDexAreaShadowOAM:: ds (wShadowOAMEnd - wShadowOAM)

ENDU


SECTION UNION "Attributes", WRAMX

wDecompressedAttributes:: ds 256 tiles


SECTION UNION "Attributes", WRAMX

; Array of Pokémon in the pokédex list.
wDexMons::
for n, 1, NUM_POKEMON_PADDED + 1
wDexMon{d:n}::
wDexMon{d:n}Species:: db
wDexMon{d:n}Form:: db
endr
wDexMonsEnd::

; Conversion table to get johto dex number from national dex number.
wDexConversionTable:: ds NUM_SPECIES * 2


SECTION UNION "Attributes", WRAMX

wDecompressedCreditsGFX:: ds (4 * 4 tiles) * 13


SECTION "Collisions", WRAMX

wDecompressedCollisions:: ds 256 * 4


SECTION "Battle Animations RAM", WRAMX

wBattleAnims::
wBattleAnimTileDict:: ds 10

wActiveAnimObjects::
for n, 1, NUM_ANIM_OBJECTS + 1
wAnimObject{02d:n}:: battle_anim_struct wAnimObject{02d:n}
endr
wActiveAnimObjectsEnd::

wActiveBGEffects::
for n, 1, NUM_BG_EFFECTS + 1
wBGEffect{d:n}:: battle_bg_effect wBGEffect{d:n}
endr
wActiveBGEffectsEnd::

wLastAnimObjectIndex:: db

; TODO: Fill in variable names for wBattleAnimTemp4-8 (identified in pret/pokecrystal)
wBattleAnimFlags:: db
wBattleAnimAddress:: dw
wBattleAnimDelay:: db
wBattleAnimParent:: dw
wBattleAnimLoops:: db
wBattleAnimVar:: db
wBattleAnimByte:: db
wBattleAnimOAMPointerLo:: db
wBattleAnimTempOAMFlags::
wBattleAnimTemp0:: db
wBattleAnimTemp1:: db
wBattleAnimTempTileID::
wBattleAnimTemp2:: db
wBattleAnimTempXCoord::
wBattleAnimTemp3:: db
wBattleAnimTempYCoord::
wBattleAnimTemp4:: db
wBattleAnimTempXOffset::
wBattleAnimTemp5:: db
wBattleAnimTempYOffset::
wBattleAnimTemp6:: db
wBattleAnimTemp7:: db
wBattleAnimTempPalette::
wBattleAnimTemp8:: db

wSurfWaveBGEffect:: ds $32
wBattleAnimsEnd::
	ds $e
wSurfWaveBGEffectEnd::


SECTION "GBC Video", WRAMX

; 8 4-color palettes
wBGPals1:: ds 8 palettes
wOBPals1:: ds 8 palettes
wBGPals2:: ds 8 palettes
wOBPals2:: ds 8 palettes

	align 8
wLYOverrides:: ds SCREEN_HEIGHT_PX
wLYOverridesEnd::

wMagnetTrain::
wMagnetTrainDirection:: db
wMagnetTrainInitPosition:: db
wMagnetTrainHoldPosition:: db
wMagnetTrainFinalPosition:: db
wMagnetTrainPlayerSpriteInitX:: db

wColorVaryDVs:: ds 3
wColorVarySpecies:: db
wColorVaryForm:: db
wColorVaryShiny:: db

wPalFadeDelayFrames:: db
wPalFadeDelay:: db
wPalFadeTotalSteps:: db
wPalFadeStepValue:: db

	ds 97 ; unused

	align 8
wLYOverridesBackup:: ds SCREEN_HEIGHT_PX
wLYOverridesBackupEnd::


SECTION "Scratch RAM", WRAMX

UNION
wDecompressScratch:: ds $100 tiles
NEXTU
wScratchTileMap:: ds TILEMAP_AREA
wScratchAttrMap:: ds TILEMAP_AREA
NEXTU
wAbilityTiles:: ds 22 tiles
; + 1 to include the "'s"
wAbilityPkmn:: ds MON_NAME_LENGTH + 1
wAbilityName:: ds 20
NEXTU
wWeatherScratch:: ds SCREEN_HEIGHT_PX
ENDU


SECTION "Window Stack", WRAMX

wWindowStack:: ds $1000 - 1
wWindowStackBottom:: db
