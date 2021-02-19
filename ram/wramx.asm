SECTION "WRAM 1", WRAMX

wRAM0End::
wRAM1Start:: db

wDefaultSpawnpoint:: db

UNION
; mon buffer
wBufferMonNick:: ds MON_NAME_LENGTH
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
wTownMapPlayerIconLandmark:: db
UNION
wTownMapCursorLandmark:: db
wTownMapCursorObjectPointer:: dw
NEXTU
wTownMapCursorCoordinates:: dw
ENDU

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
	ds 5
wRadioText:: ds 2 * SCREEN_WIDTH
wRadioTextEnd::

NEXTU
; lucky number show
wLuckyNumberDigitsBuffer:: ds 5

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
wTrainerHUDTiles:: db

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
; switching pokemon in party
; may store NAME_LENGTH, PARTYMON_STRUCT_LENGTH, or MAIL_STRUCT_LENGTH bytes
wSwitchMonBuffer:: ds 48

NEXTU
; giving pokemon mail
wMonMailMessageBuffer:: ds MAIL_MSG_LENGTH + 1

NEXTU
; bill's pc
UNION
wBoxNameBuffer:: ds BOX_NAME_LENGTH
NEXTU
	ds 1
wBillsPCTempListIndex:: db
wBillsPCTempBoxCount:: db
ENDU

NEXTU
; prof. oak's pc
wTempPokedexSeenCount:: db
wTempPokedexCaughtCount:: db

NEXTU
; player's room pc
UNION
wDecoNameBuffer:: ds ITEM_NAME_LENGTH
NEXTU
wNumOwnedDecoCategories:: db
wOwnedDecoCategories:: ds 16
ENDU

NEXTU
; trade
wCurTradePartyMon:: db
wCurOTTradePartyMon:: db
wBufferTrademonNick:: ds MON_NAME_LENGTH

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

	ds 2 ; unused

wStartFlypoint:: db
wEndFlypoint:: db

	ds 55

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
wWalkingTile:: db
	ds 6
wPlayerTurningDirection:: db

NEXTU
; temporary script buffers
wTempScriptBuffer:: db
wJumpStdScriptBuffer:: ds 15

NEXTU
; phone script data
wCheckedTime:: db
wPhoneListIndex:: db
wNumAvailableCallers:: db
wAvailableCallers:: ds CONTACT_LIST_SIZE - 4 ; bug: available callers list affects mem addresses outside union (up to 4 bytes)
wAvailableCallersEnd::

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

	ds 3 ; unused

wLastBattlePocket:: db
wBattleItemsPocketCursor:: db
wBattleMedicinePocketCursor:: db
wBattleBallsPocketCursor:: db
wBattleBerriesPocketCursor:: db
wBattleItemsPocketScrollPosition:: db
wBattleMedicinePocketScrollPosition:: db
wBattleBallsPocketScrollPosition:: db
wBattleBerriesPocketScrollPosition:: db

wTMHMMoveNameBackup:: ds MOVE_NAME_LENGTH

wStringBuffer1:: ds 24
wStringBuffer2:: ds 19
wStringBuffer3:: ds 19

UNION
; mostly used for the phone, Buffer4 is also used in some overworld events
wStringBuffer4:: ds 19
wStringBuffer5:: ds 19
NEXTU
wAIMoves:: ds 4 ; enemy moves excluding unusable moves
wAIMoveScore:: ds 4 ; score for each move
wAIFlags:: ds 2 ; modified from trainer struct as player get more badges
NEXTU
; Most of this data is tracked in SRAM to last between saves.
; It's only moved here as part of battle initialization, mostly.
; Thus, it's OK for it to reuse other WRAM space.
wBT_PartySelectCounter:: db
wBT_PartySelections:: ds PARTY_LENGTH
wBT_OTMonParty:: ds BATTLETOWER_PARTYDATA_SIZE
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

wVramState::
; bit 0: overworld sprite updating on/off
; bit 6: something to do with text
; bit 7: on when surf initiates
;        flickers when climbing waterfall
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

	ds 5 ; unused

wCurIconMonHasItemOrMail:: db

wCurKeyItem::
wCurTMHM::
wCurItem::
	db
wMartItemID::
wCurItemQuantity::
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

	ds 1

wPartyMenuActionText:: db

wItemAttributeParamBuffer:: db

wCurPartyLevel:: db

wScrollingMenuListSize:: dw

; used when following a map warp
wNextWarp:: db
wNextMapGroup:: db
wNextMapNumber:: db
wPrevWarp:: db
wPrevMapGroup:: db
wPrevMapNumber:: db

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

wTempMon:: party_struct wTempMon
wTempMonOT:: ds NAME_LENGTH
wTempMonNickname:: ds MON_NAME_LENGTH

	ds 41 ; unused

wOverworldMapAnchor:: dw
wMetatileStandingY:: db
wMetatileStandingX:: db

wMapPartial::
wMapAttributesBank:: db
wMapTileset:: db
wEnvironment:: db
wMapAttributesPointer:: dw
wMapPartialEnd::

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
wTilesetBank::
wTilesetGFX0Bank:: db
wTilesetGFX0Address:: dw
wTilesetGFX1Bank:: db
wTilesetGFX1Address:: dw
wTilesetGFX2Bank:: db
wTilesetGFX2Address:: dw
wTilesetBlocksBank:: db
wTilesetBlocksAddress:: dw
wTilesetCollisionBank:: db
wTilesetCollisionAddress:: dw
wTilesetAttributesBank:: db
wTilesetAttributesAddress:: dw
wTilesetAnim:: dw ; bank 3f
wTilesetEnd::

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
wEvolutionNewSpecies:: db
wEvolutionPicOffset:: db
wEvolutionCanceled:: db

NEXTU
; Magikarp length
wMagikarpLengthMm::
wMagikarpLengthMmHi:: db
wMagikarpLengthMmLo:: db

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

wTempEnemyMonSpecies:: db
wTempBattleMonSpecies:: db

wEnemyMon:: battle_struct wEnemyMon

	ds 5 ; unused

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
wBasePicSize:: db
wBaseAbility1:: db
wBaseAbility2:: db
wBaseHiddenAbility:: db
wBaseGrowthRate:: db
wBaseEggGroups:: db
wBaseEVYield1:: db
wBaseEVYield2:: db
wBaseTMHM:: flag_array NUM_TM_HM_TUTOR
wCurBaseDataEnd::

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

; TODO: apply imported wd265 labels to appropriate locations
wNamedObjectIndexBuffer::
wDeciramBuffer::
wTempByteValue::
wNumSetBits::
wTypeMatchup::
wCurType::
wTempSpecies::
wTempIconSpecies::
wTempTMHM::
wTempPP::
wNextBoxOrPartyIndex::
wChosenCableClubRoom::
wBreedingCompatibility::
wMoveGrammar::
wApplyStatLevelMultipliersToEnemy::
wUsePPUp::
; TODO: which of our own wd265 labels override the above labels and vice versa?
wCurKeyItemBuffer::
wCurTMHMBuffer::
wFoundMatchingIDInParty::
wd265::
; usually 1 byte, may be up to 3 in some cases for wNamedObjectIndexBuffer
	ds 3

wMonTriedToEvolve:: db

wTimeOfDay:: db

wOtherTrainerType:: db

wTrainerGroupBank:: db


SECTION "Enemy Party", WRAMX

wPokedexShowPointerAddr:: dw
wPokedexShowPointerBank:: db

wEnemyFleeing:: db
wNumFleeAttempts:: db

wOTPartyData::
wOTPlayerName:: ds NAME_LENGTH
wOTPlayerID:: dw
wOTPartyCount:: db
wOTPartySpecies:: ds PARTY_LENGTH + 1 ; legacy scripts don't check PartyCount

; OT party data -- OTPartyMon1 and nicknames is always available (nicknames available because DudeBag doesn't extend very far)
wOTPartyMons::
wOTPartyMon1:: party_struct wOTPartyMon1

UNION
; OTPartymon2-6 (and OTs/nicknames)
wOTPartyMon2:: party_struct wOTPartyMon2
wOTPartyMon3:: party_struct wOTPartyMon3
wOTPartyMon4:: party_struct wOTPartyMon4
wOTPartyMon5:: party_struct wOTPartyMon5
wOTPartyMon6:: party_struct wOTPartyMon6

wOTPartyMonsEnd::
wOTPartyMonOT:: ds NAME_LENGTH * PARTY_LENGTH
wOTPartyMonNicknames:: ds MON_NAME_LENGTH * PARTY_LENGTH ; make sure this is always available!
wOTPartyDataEnd::

NEXTU
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
; bit 3: priority jump
	db
wScriptFlags2::
	db
wScriptFlags3::
; bit 0: count steps
; bit 1: xy triggers
; bit 2: warps and connections
; bit 4: wild encounters
; bit 5: unknown
	db

wScriptMode:: db
wScriptRunning:: db
wScriptBank:: db
wScriptPos:: dw

wScriptStackSize:: db
wScriptStack:: ds 3 * 12
wScriptDelay:: db

wPriorityScriptBank::
wScriptTextBank::
	db
wPriorityScriptAddr::
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

	ds 2


SECTION "Game Data", WRAMX

wGameData::
wPlayerData::
wPlayerID:: dw

wPlayerGender::
; bit 0:
;	0 male
;	1 female
	db

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

	ds 4

wDST::
; bit 7: dst
	db

wGameTimeCap:: db ; flag for timer hitting 999:59:59.00
wGameTimeHours:: dw
wGameTimeMinutes:: db
wGameTimeSeconds:: db
wGameTimeFrames:: db

wCurDay:: db

; do not talk to the RTC hardware in the no-RTC patch
if DEF(NO_RTC)
wNoRTC::
wNoRTCDayHi::   ds 1 ; copied to hRTCDayHi
wNoRTCDayLo::   ds 1 ; copied to hRTCDayLo
wNoRTCHours::   ds 1 ; copied to hRTCHours
wNoRTCMinutes:: db ; copied to hRTCMinutes
wNoRTCSeconds:: db ; copied to hRTCSeconds
else
; reserve equal space in RTC versions so that saved games remain compatible
	ds 5
endc

wPlayerGoingUpStairs:: db

wObjectFollow_Leader:: db
wObjectFollow_Follower:: db
wCenteredObject:: db
wFollowerMovementQueueLength:: db
wFollowMovementQueue:: ds 5

wObjectStructs::
wPlayerStruct::   object_struct wPlayer
wObject1Struct::  object_struct wObject1
wObject2Struct::  object_struct wObject2
wObject3Struct::  object_struct wObject3
wObject4Struct::  object_struct wObject4
wObject5Struct::  object_struct wObject5
wObject6Struct::  object_struct wObject6
wObject7Struct::  object_struct wObject7
wObject8Struct::  object_struct wObject8
wObject9Struct::  object_struct wObject9
wObject10Struct:: object_struct wObject10
wObject11Struct:: object_struct wObject11
wObject12Struct:: object_struct wObject12
wObjectStructsEnd::

wStoneTableAddress:: dw

wBattleTowerCurStreak:: dw
wBattleTowerTopStreak:: dw

	ds 18

wMapObjects::
wPlayerObject:: map_object wPlayer
wMap1Object::   map_object wMap1
wMap2Object::   map_object wMap2
wMap3Object::   map_object wMap3
wMap4Object::   map_object wMap4
wMap5Object::   map_object wMap5
wMap6Object::   map_object wMap6
wMap7Object::   map_object wMap7
wMap8Object::   map_object wMap8
wMap9Object::   map_object wMap9
wMap10Object::  map_object wMap10
wMap11Object::  map_object wMap11
wMap12Object::  map_object wMap12
wMap13Object::  map_object wMap13
wMap14Object::  map_object wMap14
wMap15Object::  map_object wMap15
wMap16Object::  map_object wMap16
wMap17Object::  map_object wMap17
wMap18Object::  map_object wMap18
wMap19Object::  map_object wMap19
wMap20Object::  map_object wMap20
wMapObjectsEnd::

wObjectMasks:: ds NUM_OBJECTS

wVariableSprites:: ds $100 - SPRITE_VARS

wEnteredMapFromContinue:: db

wStatusFlags3::
	; 0 - judge machine
	db

	ds 1
wTimeOfDayPal:: db
	ds 4
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
	; bit 5: can use sweet scent
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

wKeyItems:: flag_array NUM_KEY_ITEMS
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
	ds 1
wRadioTuningKnob:: db
wLastDexMode:: db

wTMHMPocketScrollPosition:: db
wTMHMPocketCursor::
; beyond the cursor position, bit 7 also controls how TMs are sorted
	ds 1

wPlayerState:: db

wHallOfFameCount:: dw
wTradeFlags:: flag_array PARTY_LENGTH

	ds 1 ; unused

wMooMooBerries:: db
wUndergroundSwitchPositions:: db
wFarfetchdPosition:: db

; map triggers
wAlways0SceneID:: db
wAzaleaTownSceneID:: db
wBattleTower1FSceneID:: db
wBattleTowerBattleRoomSceneID:: db ; unused
wBattleTowerElevatorSceneID:: db ; unused
wBattleTowerHallwaySceneID:: db ; unused
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
wEcruteakPokecenter1FSceneID:: db
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
wBoxNames:: ds BOX_NAME_LENGTH * NUM_BOXES
wBoxNamesEnd::

wCelebiEvent:: db

	ds 1 ; unused

wOWState:: dw

wCurMapSceneScriptPointer:: dw

wCurCaller:: dw
wCurMapWarpCount:: db
wCurMapWarpsPointer:: dw
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

	ds 2 ; unused

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

wNuzlockeLandmarkFlags:: flag_array NUM_LANDMARKS

wHiddenGrottoContents::
; content type, content id
	ds NUM_HIDDEN_GROTTOES * 2

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

wPhoneList:: ds CONTACT_LIST_SIZE + 1

wHappinessStepCount:: db

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
wPartySpecies:: ds PARTY_LENGTH
wPartyEnd::     db ; older code doesn't check wPartyCount

wPartyMons::
wPartyMon1:: party_struct wPartyMon1
wPartyMon2:: party_struct wPartyMon2
wPartyMon3:: party_struct wPartyMon3
wPartyMon4:: party_struct wPartyMon4
wPartyMon5:: party_struct wPartyMon5
wPartyMon6:: party_struct wPartyMon6

wPartyMonOT:: ds NAME_LENGTH * PARTY_LENGTH

wPartyMonNicknames:: ds MON_NAME_LENGTH * PARTY_LENGTH
wPartyMonNicknamesEnd::

	ds 9 ; unused

wPokedexCaught:: flag_array NUM_POKEMON
wEndPokedexCaught::

wPokedexSeen:: flag_array NUM_POKEMON
wEndPokedexSeen::

wUnownDex:: ds NUM_UNOWN
wUnlockedUnowns:: db

wFirstUnownSeen:: db
wFirstMagikarpSeen:: db

wDayCareMan::
; bit 7: active
; bit 6: monsters are compatible
; bit 5: egg ready
; bit 0: monster 1 in daycare
	db

wBreedMon1::
wBreedMon1Nick::  ds MON_NAME_LENGTH
wBreedMon1OT:: ds NAME_LENGTH
wBreedMon1Stats:: box_struct wBreedMon1

wDayCareLady::
; bit 7: active
; bit 0: monster 2 in daycare
	db

wStepsToEgg:: db
wBreedMotherOrNonDitto::
;  z: yes
; nz: no
	db

wBreedMon2::
wBreedMon2Nick:: ds MON_NAME_LENGTH
wBreedMon2OT:: ds NAME_LENGTH
wBreedMon2Stats:: box_struct wBreedMon2

wEggNick:: ds MON_NAME_LENGTH
wEggOT:: ds NAME_LENGTH
wEggMon:: box_struct wEggMon

wBugContestSecondPartySpecies:: db
wContestMon:: party_struct wContestMon

wDunsparceMapGroup:: db
wDunsparceMapNumber:: db
wFishingSwarmFlag:: db

wRoamMon1:: roam_struct wRoamMon1
wRoamMon2:: roam_struct wRoamMon2
wRoamMon3:: roam_struct wRoamMon3

wRoamMons_CurMapNumber:: db
wRoamMons_CurMapGroup:: db
wRoamMons_LastMapNumber:: db
wRoamMons_LastMapGroup:: db

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

wRegisteredItems::
; You can map 4 items, to select + directions
	ds 4

wPokemonDataEnd::
wGameDataEnd::


SECTION "Pic Animations RAM", WRAMX

wTempTileMap::
; 20x18 grid of 8x8 tiles
	ds SCREEN_WIDTH * SCREEN_HEIGHT

; PokeAnim data
wPokeAnimStruct::
wPokeAnimSceneIndex:: db
wPokeAnimPointer:: dw
wPokeAnimSpecies:: db
wPokeAnimVariant:: db
	ds 1
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
	ds 1
wPokeAnimBitmaskCurCol:: db
wPokeAnimBitmaskCurRow:: db
wPokeAnimBitmaskCurBit:: db
wPokeAnimBitmaskBuffer:: db
	ds 8
wPokeAnimStructEnd::


SECTION "Sound Stack", WRAMX

wSoundEngineBackup:: ds wChannelsEnd - wMusic


SECTION "Metatiles", WRAMX

wDecompressedMetatiles:: ds 256 tiles


SECTION "Attributes", WRAMX

wDecompressedAttributes:: ds 256 tiles


SECTION "Collisions or Music Player", WRAMX

UNION
wDecompressedCollisions:: ds 256 * 4
NEXTU
wMPNotes:: ds 4 * 256
NEXTU
wDecompressedCreditsGFX:: ; ds (4 * 4 tiles) * 13 ; ds $d00
ENDU


SECTION "Battle Animations RAM", WRAMX

wBattleAnims::
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
wColorVaryShiny:: db

wPalFadeDelayFrames:: db
wPalFadeDelay:: db

	ds 100 ; unused

wLYOverridesBackup:: ds SCREEN_HEIGHT_PX
wLYOverridesBackupEnd::


SECTION "Scratch RAM", WRAMX

UNION
wDecompressScratch:: ds $100 tiles
NEXTU
wScratchTileMap:: ds BG_MAP_WIDTH * BG_MAP_HEIGHT
wScratchAttrMap:: ds BG_MAP_WIDTH * BG_MAP_HEIGHT
NEXTU
wAbilityTiles:: ds 22 tiles
; + 1 to include the "'s"
wAbilityPkmn:: ds MON_NAME_LENGTH + 1
wAbilityName:: ds 20
ENDU


SECTION "Window Stack", WRAMX

wWindowStack:: ds $1000 - 1
wWindowStackBottom:: db
