SECTION "Stack", WRAM0

wRAM0Start::
wStackBottom::
	ds $100 - 1
wStack::
wStackTop::
	db


SECTION "Audio RAM", WRAM0

wMusic::
wMusicPlaying:: db ; nonzero if playing

wChannels::
for n, 1, NUM_MUSIC_CHANS + 1
wChannel{d:n}:: channel_struct wChannel{d:n}
endr

wSFXChannels::
for n, NUM_MUSIC_CHANS + 1, NUM_CHANNELS + 1
wChannel{d:n}:: channel_struct wChannel{d:n}
endr

wCurTrackDuty:: db
wCurTrackIntensity:: db
wCurTrackFrequency:: dw
	ds 1 ; BCD value, dummied out
wCurNoteDuration:: db ; used in MusicE0 and LoadNote

wCurMusicByte:: db
wCurChannel:: db
wVolume::
; corresponds to rNR50
; Channel control / ON-OFF / Volume (R/W)
;   bit 7 - Vin->SO2 ON/OFF
;   bit 6-4 - SO2 output level (volume) (# 0-7)
;   bit 3 - Vin->SO1 ON/OFF
;   bit 2-0 - SO1 output level (volume) (# 0-7)
	db
wSoundOutput::
; corresponds to rNR51
; bit 4-7: ch1-4 so2 on/off
; bit 0-3: ch1-4 so1 on/off
	db
wSoundInput::
; corresponds to rNR52
; bit 7: global on/off
; bit 0: ch1 on/off
; bit 1: ch2 on/off
; bit 2: ch3 on/off
; bit 3: ch4 on/off
	db

wMusicID::
wMusicIDLo:: db
wMusicIDHi:: db
wMusicBank:: db
wNoiseSampleAddress::
wNoiseSampleAddressLo:: db
wNoiseSampleAddressHi:: db
wNoiseSampleDelay:: db ; noise delay?
	ds 1
wMusicNoiseSampleSet:: db
wSFXNoiseSampleSet:: db
wLowHealthAlarm::
; bit 7: on/off
; bit 4: pitch
; bit 0-3: counter
	db
wMusicFade::
; fades volume over x frames
; bit 7: fade in/out
; bit 0-5: number of frames for each volume level
; $00 = none (default)
	db
wMusicFadeCount:: db
wMusicFadeID::
wMusicFadeIDLo:: db
wMusicFadeIDHi:: db
	ds 5
wCryPitch:: dw
wCryLength:: dw
wLastVolume:: db
	ds 1
wSFXPriority:: db ; if nonzero, turn off music when playing sfx
	ds 1
wChannel1JumpCondition:: db
wChannel2JumpCondition:: db
wChannel3JumpCondition:: db
wChannel4JumpCondition:: db
wStereoPanningMask:: db
wCryTracks::
; plays only in left or right track depending on what side the monster is on
; both tracks active outside of battle
	db
wSFXDuration:: db
wCurSFX:: db ; id of sfx currently playing
wChannelsEnd::

wMapMusic:: db
wDontPlayMapMusicOnReload:: db
wMusicEnd::


SECTION "WRAM 0", WRAM0

wMonType:: db

wCurSpecies::
wCurMove::
wCreditsSpawn::
	db

wNamedObjectTypeBuffer:: db

wCurOptionsPage:: db

wBattleTowerBattleEnded::
	db

wCurForm:: db

wRNGState:: ds 4
wRNGCumulativeDividerPlus:: dw
wRNGCumulativeDividerMinus:: db

wBoxAlignment:: db
wInputType:: db
wAutoInputAddress:: dw
wAutoInputBank:: db
wAutoInputLength:: db

wMonStatusFlags:: db
wGameLogicPaused:: db
wSpriteUpdatesEnabled:: db
wMapTimeOfDay:: db

wPrevDexEntry:: db

wPrevLandmark:: db
wCurLandmark:: db
wLandmarkSignTimer:: dw
wLinkMode::
; 0 not in link battle
; 1 link battle
; 4 mobile battle
	db

wPlayerNextMovement:: db
wPlayerMovement:: db

wMovementObject:: db
wMovementDataPointer:: ds 3 ; dba

wMovementByteWasControlSwitch:: db

UNION
wObjectPriorities:: ds NUM_OBJECT_STRUCTS
NEXTU
wMovementPointer:: dw
	ds 2
wTempObjectCopyMapObjectIndex:: db
wTempObjectCopySprite:: db
wTempObjectCopySpriteVTile:: db
wTempObjectCopyPalette:: db
wTempObjectCopyMovement:: db
wTempObjectCopyRange:: db
wTempObjectCopyX:: db
wTempObjectCopyY:: db
wTempObjectCopyRadius:: db
ENDU

wTileDown:: db
wTileUp:: db
wTileLeft:: db
wTileRight:: db

wTilePermissions::
; set if tile behavior prevents
; you from walking in that direction
; bit 3: down
; bit 2: up
; bit 1: left
; bit 0: right
	db

	ds 13


SECTION "Sprite Animations", WRAM0

; wSpriteAnimDict is a 10x2 dictionary.
; keys: taken from third column of SpriteAnimSeqData
; values: vTiles
wSpriteAnimDict:: ds 10 * 2

wSpriteAnimationStructs::
; Field  0: Index
; Fields 1-3: Loaded from SpriteAnimSeqData
for n, 1, NUM_SPRITE_ANIM_STRUCTS + 1
wSpriteAnim{d:n}:: sprite_anim_struct wSpriteAnim{d:n}
endr
wSpriteAnimationStructsEnd::

wSpriteAnimCount:: db
wCurSpriteOAMAddr:: db

wCurIcon:: db
wCurIconPersonality::
wCurIconShiny:: db
wCurIconForm:: db
wCurIconTile:: db

wSpriteAnimAddrBackup::
wCurSpriteAddSubFlags::
	dw
wCurAnimVTile:: db
wCurAnimXCoord:: db
wCurAnimYCoord:: db
wCurAnimXOffset:: db
wCurAnimYOffset:: db
wGlobalAnimYOffset:: db
wGlobalAnimXOffset:: db
wSpriteAnimsEnd::


SECTION "Music Player RAM", WRAM0

wMusicPlayerWRAM::
wSongSelection:: dw
wNumNoteLines:: db
wTmpCh:: db
wChLastNotes:: ds 3
wVolTimer:: db
wC1Vol:: db
wC1VolSub:: db
wC2Vol:: db
wC2VolSub:: db
wC3Vol:: db
wC3VolSub:: db
wC4Vol:: db
wC4VolSub:: db
wNoteEnded:: ds 3
wSongInfoSwitch:: db
;wRenderedWaveform:: db
wPitchesTmp:: ds 4
;wWaveformTmp:: ds 16
wTmpValue:: db
; song list
wSelectorTop:: db
wSelectorCur:: db
; song editor
wChannelSelector:: db
wAdjustingTempo:: db
; audio engine input
wChannelSelectorSwitches:: ds 4
wPitchTransposition:: db
wTempoAdjustment:: db
; audio engine output
wNoiseHit:: db
wMusicPlayerWRAMEnd::


SECTION "Sprites", WRAM0

wVirtualOAM::
for n, NUM_SPRITE_OAM_STRUCTS
wVirtualOAMSprite{02d:n}:: sprite_oam_struct wVirtualOAMSprite{02d:n}
endr
wVirtualOAMEnd::


SECTION "Tilemap and Attrmap", WRAM0

wTileMap::
; 20x18 grid of 8x8 tiles
	ds SCREEN_WIDTH * SCREEN_HEIGHT
wTileMapEnd::

wAttrMap::
; 20x18 grid of palettes for 8x8 tiles
; read horizontally from the top row
; bit 7: priority
; bit 6: y flip
; bit 5: x flip
; bit 4: pal # (non-cgb)
; bit 3: vram bank (cgb only)
; bit 2-0: pal # (cgb only)
	ds SCREEN_WIDTH * SCREEN_HEIGHT
wAttrMapEnd::


SECTION UNION "Misc 480", WRAM0
; misc

wMisc:: ds (SCREEN_WIDTH + 4) * (SCREEN_HEIGHT + 2)
wMiscEnd::


SECTION UNION "Misc 480", WRAM0
; odd egg

wOddEgg:: party_struct wOddEgg
wOddEggName:: ds MON_NAME_LENGTH
wOddEggOTName:: ds MON_NAME_LENGTH


SECTION UNION "Misc 480", WRAM0
; hall of fame temp struct

wHallOfFameTemp:: hall_of_fame wHallOfFameTemp


SECTION UNION "Misc 480", WRAM0
; timeset temp storage

wTimeSetBuffer:: ds 20
wInitHourBuffer:: ds 13
wInitMinuteBuffer:: ds 17


SECTION UNION "Misc 480", WRAM0
; link patch lists

wPlayerPatchLists:: ds 200
wOTPatchLists:: ds 200


SECTION UNION "Misc 480", WRAM0
; link engine

wLinkMisc:: ds 10
wLinkPlayerFixedPartyMon1ID:: ds 3
	ds 37


SECTION UNION "Misc 480", WRAM0
; battle

wBattle::
wEnemyMoveStruct::  move_struct wEnemyMoveStruct
wPlayerMoveStruct:: move_struct wPlayerMoveStruct

wEnemyMonNickname::  ds MON_NAME_LENGTH
wBattleMonNickname:: ds MON_NAME_LENGTH

wBattleMon:: battle_struct wBattleMon

	ds 2

wWildMon:: db
	ds 1
wEnemyTrainerItem1:: db
wEnemyTrainerItem2:: db
wEnemyTrainerBaseReward:: db
wEnemyTrainerAIFlags:: ds 3
wOTClassName:: ds TRAINER_CLASS_NAME_LENGTH

wCurOTMon:: db

wTypeModifier::
; >10: super effective
;  10: normal
; <10: not very effective
; bit 7: stab
	db

wCriticalHit::
; 0 if not critical
; 1 for a critical hit
; 2 for a OHKO
	db

wAttackMissed::
; nonzero for a miss
	db

wBattleSubStatusWRAM::
wPlayerSubStatus1::
; bit
; 7 attract
; 6 flash fire
; 5 endure
; 4 perish song
; 3 identified
; 2 protect
; 1 curse
; 0 unburden
	db
wPlayerSubStatus2::
; bit
; 7 cant run
; 6 destiny bond
; 5 lock-on
; 4 transformed
; 3 magic bounce
; 2 fainted
; 1 minimized
; 0 unused
	db
wPlayerSubStatus3::
; NOTE: these should all stay together!
; bit
; 7 confused
; 6 flying
; 5 underground
; 4 charged
; 3 recharge
; 2 in loop
; 1 rampage
; 0 rollout
	db
wPlayerSubStatus4::
; bit
; 7 leech seed
; 6 rage
; 5 flinched
; 4 substitute
; 3 roost
; 2 focus energy
; 1 unused
; 0 curled
	db

wEnemySubStatus1::
; see wPlayerSubStatus1
	db
wEnemySubStatus2::
; see wPlayerSubStatus2
	db
wEnemySubStatus3::
; see wPlayerSubStatus3
	db
wEnemySubStatus4::
; see wPlayerSubStatus4
	db

; Some code (e.g. HandleRampage) depend on the order of these
wPlayerAbility:: db
wPlayerRolloutCount:: db
wPlayerConfuseCount:: db
wPlayerToxicCount:: db
wPlayerDisableCount:: db
wPlayerEncoreCount:: db ; also for choice-locking
wPlayerPerishCount:: db
wPlayerProtectCount:: db
	ds 1

wEnemyAbility:: db
wEnemyRolloutCount:: db
wEnemyConfuseCount:: db
wEnemyToxicCount:: db
wEnemyDisableCount:: db
wEnemyEncoreCount:: db
wEnemyPerishCount:: db
wEnemyProtectCount:: db
	ds 1
wBattleSubStatusWRAMEnd::

wDamageTaken::
; Format: $xy yy, x = total multihit hits, y = total damage
	dw

	ds 2 ; unused

wBattleReward:: ds 3
wBattleAnimParam::
wKickCounter:: db

wPartyBackupItems::
; Back up of party items before a battle. Modified in-battle for consumed/harvested.
; Berries and items stolen from wild Pokémon since those changes are retained.
	ds PARTY_LENGTH

wPartyUsedItems::
; For the benefit of Pickup/Harvest
	ds PARTY_LENGTH

wOTPartyUsedItems::
; See PartyUsedItems
	ds PARTY_LENGTH

; What move was selected last.
; Used for Choice locking and the Metronome item
wPlayerSelectedMove:: db
wEnemySelectedMove:: db

; How much the Metronome item is boosted. (Counts even if you don't have the item.)
wPlayerMetronomeCount:: db
wEnemyMetronomeCount:: db

wPartyParticipants:: ds PARTY_LENGTH

wDeferredSwitch:: db

wPlayerSwitchTarget:: db
wEnemySwitchTarget:: db

wBattleScriptBufferLoc:: dw
wMoveState:: db

wPlayerStatLevels::
; 07 neutral
wPlayerAtkLevel:: db
wPlayerDefLevel:: db
wPlayerSpdLevel:: db
wPlayerSAtkLevel:: db
wPlayerSDefLevel:: db
wPlayerAccLevel:: db
wPlayerEvaLevel:: db
	ds 1

wEnemyStatLevels::
; 07 neutral
wEnemyAtkLevel:: db
wEnemyDefLevel:: db
wEnemySpdLevel:: db
wEnemySAtkLevel:: db
wEnemySDefLevel:: db
wEnemyAccLevel:: db
wEnemyEvaLevel:: db
	ds 1

wEnemyTurnsTaken:: db
wPlayerTurnsTaken:: db

wPlayerSubstituteHP:: dw
wEnemySubstituteHP:: dw

wBackupEnemyMonBaseExp:: db

wCurPlayerMove:: db
wCurEnemyMove:: db

wLinkBattleRNCount:: db ; how far through the prng stream

wEnemyItemState:: db

	ds 2

wCurEnemyMoveNum:: db

wEnemyHPAtTimeOfPlayerSwitch:: dw
wPayDayMoney:: ds 3

wSafariMonAngerCount:: db
wSafariMonEating:: db

wAlreadyDisobeyed:: db

	ds 1 ; unused

wAlreadySawWeather:: db

wWhichMonFaintedFirst:: db

; exists so you can't counter on switch
wLastPlayerCounterMove:: db
wLastEnemyCounterMove:: db

	ds 1 ; unused

wAlreadyExecuted:: db

wTrickRoom:: db

wBattleLowHealthAlarm:: db

	ds 1 ; unused

wPlayerHazards::
; bit
; 6-7 toxic spikes
; 4-5 spikes
; 0-3 unused
	db

wEnemyHazards::
; see wPlayerHazards
	db

wPlayerScreens::
; bit
; 4-7 light screen
; 0-3 reflect
	db
wPlayerGuards::
; bit
; 4-7 mist
; 0-3 safeguard
	db

	ds 2

wEnemyScreens::
; see wPlayerScreens
	db
wEnemyGuards::
; see wPlayerGuards
	db

	ds 2

wBattleWeather::
; 00 normal
; 01 rain
; 02 sun
; 03 sandstorm
; 04 rain stopped
; 05 sunlight faded
; 06 sandstorm subsided
	db

wWeatherCount:: db ; # turns remaining

wChangedStat::
; bit 4-7: how many stages to raise/lower + 1 (between +1 and +12)
; bit 0-3: which stat to raise/lower
	db

wEffectFailed:: db
wFailedMessage:: db
wEnemyGoesFirst:: db

wPlayerUsedMoves::
; add a move that has been used once by the player
; added in order of use
	ds NUM_MOVES

wEnemyAISwitchScore:: db
wEnemySwitchMonParam:: db
wEnemySwitchMonIndex:: db

wTempLevel:: db

wLastPlayerMon:: db

wLastPlayerMove:: db
wLastEnemyMove:: db

wEnemyUsingItem:: db

wPlayerFutureSightCount:: db
wEnemyFutureSightCount:: db
wPlayerFutureSightDamage:: dw
wEnemyFutureSightDamage:: dw
wPlayerTrappingMove:: db
wEnemyTrappingMove:: db
wPlayerWrapCount:: db
wEnemyWrapCount:: db
wPlayerCharging:: db
wEnemyCharging:: db

wGivingExperienceToExpShareHolders:: db

wAnimationsDisabled:: db ; used to temporarily disable animations for abilities

wBattleEnded:: db

wAmuletCoin:: db

	ds 1

wDVAndPersonalityBuffer:: ds 5
wBattleEnd::


SECTION UNION "Misc 480", WRAM0
; trade
	ds 172

wTrademons::
wPlayerTrademon:: trademon wPlayerTrademon
wOTTrademon:: trademon wOTTrademon
wTrademonsEnd::
wTradeAnimPointer:: dw
wLinkPlayer1Name:: ds NAME_LENGTH
wLinkPlayer2Name:: ds NAME_LENGTH
wLinkTradeSendmonData::
wLinkTradeSendmonSpecies:: db
wLinkTradeSendmonPersonality::
wLinkTradeSendmonShiny:: db
wLinkTradeSendmonForm:: db
wLinkTradeGetmonData::
wLinkTradeGetmonSpecies:: db
wLinkTradeGetmonPersonality::
wLinkTradeGetmonShiny:: db
wLinkTradeGetmonForm:: db


SECTION UNION "Misc 480", WRAM0
; naming screen
	ds 172

wNamingScreenDestinationPointer:: dw
wNamingScreenCurNameLength:: db
wNamingScreenMaxNameLength:: db
wNamingScreenType:: db
wNamingScreenCursorObjectPointer:: dw
wNamingScreenLastCharacter:: db
wNamingScreenStringEntryCoord:: dw


SECTION UNION "Misc 480", WRAM0
; pokegear
	ds 172

wPokegearPhoneLoadNameBuffer:: db
wPokegearPhoneCursorPosition:: db
wPokegearPhoneScrollPosition:: db
wPokegearPhoneSelectedPerson:: db
wPokegearPhoneSubmenuCursor:: db
wPokegearMapCursorObjectPointer:: dw
wPokegearMapCursorLandmark:: db
wPokegearMapPlayerIconLandmark:: db
wPokegearRadioChannelBank:: db
wPokegearRadioChannelAddr:: dw
wPokegearRadioMusicPlaying:: db
wPokegearNumberBuffer:: db


SECTION UNION "Misc 480", WRAM0
; slot machine
	ds 172

wSlots::
wReel1:: slot_reel wReel1
wReel2:: slot_reel wReel2
wReel3:: slot_reel wReel3
wReel1Stopped:: ds 3
wReel2Stopped:: ds 3
wReel3Stopped:: ds 3
wSlotBias:: db
wSlotBet:: db
wFirstTwoReelsMatching:: db
wFirstTwoReelsMatchingSevens:: db
wSlotMatched:: db
wCurReelStopped:: ds 3
wPayout:: dw
wCurReelXCoord:: db
wCurReelYCoord:: db
	ds 2
wSlotBuildingMatch:: db
wSlotsDataEnd::
	ds 28
wSlotsEnd::


SECTION UNION "Misc 480", WRAM0
; card flip
	ds 172

wCardFlip::
wDeck:: ds 24
wDeckEnd::
wCardFlipNumCardsPlayed:: db
wCardFlipFaceUpCard:: db
wDiscardPile:: ds 24
wDiscardPileEnd::
wCardFlipEnd::


;SECTION UNION "Misc 480", WRAM0
;; memory game
;	ds 172
;
;wMemoryGame::
;wMemoryGameCards:: ds 9 * 5
;wMemoryGameCardsEnd::
;wMemoryGameLastCardPicked:: db
;wMemoryGameCard1:: db
;wMemoryGameCard2:: db
;wMemoryGameCard1Location:: db
;wMemoryGameCard2Location:: db
;wMemoryGameNumberTriesRemaining:: db
;wMemoryGameLastMatches:: ds 5
;wMemoryGameCounter:: db
;wMemoryGameNumCardsMatched:: db
;wMemoryGameEnd::


SECTION UNION "Misc 480", WRAM0
; Unown puzzle
	ds 172

wUnownPuzzle::
wPuzzlePieces:: ds 6 * 6
wUnownPuzzleEnd::


SECTION UNION "Misc 480", WRAM0
; Pokedex
	ds 172

wPokedexDataStart::
wPokedexOrder:: ds NUM_POKEMON - 1
wPokedexOrderEnd:: ds 6
wPokedexMetadata::
wDexListingScrollOffset:: db ; offset of the first displayed entry from the start
wDexListingCursor:: db ; Dex cursor
wDexListingEnd:: db ; Last mon to display
wDexListingHeight:: db ; number of entries displayed at once in the dex listing
wCurDexMode:: db ; Pokedex Mode
wDexSearchMonType1:: db ; first type to search
wDexSearchMonType2:: db ; second type to search
wDexSearchResultCount:: db
wDexArrowCursorPosIndex:: db
wDexArrowCursorDelayCounter:: db
wDexArrowCursorBlinkCounter:: db
wDexSearchSlowpokeFrame:: db
wUnlockedUnownMode:: db
wDexCurUnownIndex:: db
wDexUnownCount:: db
wDexConvertedMonType:: db ; mon type converted from dex search mon type
wDexListingScrollOffsetBackup:: db
wDexListingCursorBackup:: db
wBackupDexListingCursor:: db
wBackupDexListingPage:: db
wDexCurLocation:: db
wPokedexStatus:: db
wDexMonPersonality::
wDexMonShiny:: db
wDexMonForm:: db
wPokedexDataEnd::


SECTION UNION "Misc 1300", WRAM0
; overworld map

; large enough for 45x20 NavelRockInside.ablk; (45+6)x(20+6) = 1326 < 1408
; was originally only 1300 bytes
wOverworldMapBlocks:: ds $580
wOverworldMapBlocksEnd::


SECTION UNION "Misc 1300", WRAM0
; credits image

wCreditsBlankFrame2bpp:: ds 8 * 8 * 2


SECTION UNION "Misc 1300", WRAM0
; Bill's PC

; If you change ordering of this, remember to fix LCD hblank code too.
; Note that (as of when comment was written), hblank can't always keep up
; if doing 4 pals in one go during party shifting.
wBillsPC_CurPals::
wBillsPC_CurPartyPals:: ds 2 * 2 * 2 ; 2 bytes per color, 2 colors, 2 mons
wBillsPC_CurMonPals:: ds 2 * 2 * 4 ; 2 bytes per color, 2 colors, 4 mons

; Stores palettes used for party+box.
wBillsPC_PalList::
wBillsPC_PokepicPal:: ds 2 * 2 * 1
wBillsPC_PokerusShinyPal:: ds 2 * 2 * 1
wBillsPC_MonPals1:: ds 2 * 2 * 4

	ds 2 * 2 * 2 ; unused row2 BG2-3

wBillsPC_MonPals2:: ds 2 * 2 * 4
wBillsPC_PartyPals3:: ds 2 * 2 * 2
wBillsPC_MonPals3:: ds 2 * 2 * 4
wBillsPC_PartyPals4:: ds 2 * 2 * 2
wBillsPC_MonPals4:: ds 2 * 2 * 4
wBillsPC_PartyPals5:: ds 2 * 2 * 2
wBillsPC_MonPals5:: ds 2 * 2 * 4

; Species lists
wBillsPC_PartyList:: ds 6 * 2
wBillsPC_BoxList:: ds 20 * 2

wBillsPC_HeldIcon:: dw
wBillsPC_QuickIcon:: dw

; Cursor data
wBillsPC_CursorItem:: db ; what item is selected.
wBillsPC_CursorPos:: db ; 0-3 * 4*row, row 0 is title. Bit 7 means in party.
wBillsPC_CursorHeldBox:: db ; 0 for party, 1-15 otherwise
wBillsPC_CursorHeldSlot:: db ; 0 for nothing held, or 1-20 (1-6 if party)
wBillsPC_CursorDestBox:: db ; 0 for party, 1-15 otherwise
wBillsPC_CursorDestSlot:: db ; 0 for release, or 1-20 (1-6 if party)
wBillsPC_CursorMode:: db ; 0 for regular mode (red), 1 for swap mode (blue), 2 for item mode (green)
wBillsPC_CursorAnimFlag:: db ; manage cursor behaviour
wBillsPC_ItemVWF:: ds 10 tiles

; Quick-move sprite data.
wBillsPC_QuickFrom::
wBillsPC_QuickFromBox:: db
wBillsPC_QuickFromSlot:: db
wBillsPC_QuickFromX:: db
wBillsPC_QuickFromY:: db

wBillsPC_QuickTo::
wBillsPC_QuickToBox:: db
wBillsPC_QuickToSlot:: db
wBillsPC_QuickToX:: db
wBillsPC_QuickToY:: db
wBillsPC_QuickFrames:: db

wBillsPC_ApplyThemePals:: db ; used by _CGB_BillsPC


SECTION UNION "Misc 1300", WRAM0
; raw link data

wLinkData:: ds 1300
wLinkDataEnd::


SECTION UNION "Misc 1300", WRAM0
; link data members

wLinkPlayerName:: ds NAME_LENGTH
wLinkPartyCount:: db
wLinkPartySpecies:: ds PARTY_LENGTH
wLinkPartyEnd:: db ; older code doesn't check PartyCount

UNION
; link player data
wLinkPlayerData::
for n, 1, PARTY_LENGTH + 1
wLinkPlayerPartyMon{d:n}:: party_struct wLinkPlayerPartyMon{d:n}
endr

wLinkPlayerPartyMonOTs::
for n, 1, PARTY_LENGTH + 1
wLinkPlayerPartyMon{d:n}OT:: ds NAME_LENGTH
endr

wLinkPlayerPartyMonNicknames::
for n, 1, PARTY_LENGTH + 1
wLinkPlayerPartyMon{d:n}Nickname:: ds MON_NAME_LENGTH
endr
wLinkPlayerDataEnd::

NEXTU
; link patch lists
wLinkPatchList1:: ds SERIAL_PATCH_LIST_LENGTH
wLinkPatchList2:: ds SERIAL_PATCH_LIST_LENGTH
ENDU


SECTION UNION "Misc 1300", WRAM0
; link mail data
	ds 500

wLinkPlayerMail::
wLinkPlayerMailPreamble:: ds SERIAL_MAIL_PREAMBLE_LENGTH
wLinkPlayerMailMessages:: ds (MAIL_MSG_LENGTH + 1) * PARTY_LENGTH
wLinkPlayerMailMetadata:: ds (MAIL_STRUCT_LENGTH - (MAIL_MSG_LENGTH + 1)) * PARTY_LENGTH
wLinkPlayerMailPatchSet:: ds 103
wLinkPlayerMailEnd::
	ds 10
wLinkOTMail::
wLinkOTMailMessages:: ds (MAIL_MSG_LENGTH + 1) * PARTY_LENGTH
wLinkOTMailMetadata:: ds (MAIL_STRUCT_LENGTH - (MAIL_MSG_LENGTH + 1)) * PARTY_LENGTH
wOTPlayerMailPatchSet:: ds 103 + SERIAL_MAIL_PREAMBLE_LENGTH
wLinkOTMailEnd::
	ds 10


SECTION UNION "Misc 1300", WRAM0
; received link mail data
	ds 500

wLinkReceivedMail:: ds MAIL_STRUCT_LENGTH * PARTY_LENGTH
wLinkReceivedMailEnd:: db


SECTION "Video", WRAM0

wBGMapBuffer:: ds 48
wBGMapPalBuffer:: ds 48
wBGMapBufferPtrs:: ds 48 ; 24 bg map addresses (16x8 tiles)

wMemCGBLayout:: db

UNION
wCreditsPos:: dw
wCreditsTimer:: db
wTrainerCardBadgePaletteAddr:: dw

NEXTU
wPlayerHPPal:: db
wEnemyHPPal:: db
wHPPals:: ds PARTY_LENGTH
wCurHPPal:: db
wHPPalIndex:: db

ENDU

wTileAnimBuffer:: ds 1 tiles

; link data
UNION
wOtherPlayerLinkMode:: db
wOtherPlayerLinkAction:: db
	ds 3
wPlayerLinkAction:: db
	ds 4
NEXTU
wLinkReceivedSyncBuffer:: ds 5
wLinkPlayerSyncBuffer:: ds 5
ENDU

wLinkTimeoutFrames:: dw
wLinkByteTimeout:: dw

wJumptableIndex:: db ; must come right before the union

UNION
; intro and title data
wIntroSceneFrameCounter:: db
wIntroSceneTimer:: db

NEXTU
; title data
	ds 1
wTitleScreenTimer:: dw

NEXTU
; credits data
wCreditsBorderFrame:: db
wCreditsBorderMon:: db
wCreditsLYOverride:: db

NEXTU
; pokedex
wPrevDexEntryJumptableIndex:: db
wPrevDexEntryBackup:: db

NEXTU
; pokegear
wPokegearCard:: db
wPokegearMapRegion:: db

NEXTU
; pack
wPackJumptableIndex:: db
wCurPocket:: db
wPackUsedItem:: db

NEXTU
; trainer card badges
wTrainerCardBadgeFrameCounter:: db
wTrainerCardBadgeTileID:: db

NEXTU
; slot machine
wSlotsDelay:: db

NEXTU
; card flip
wCardFlipCursorY:: db
wCardFlipCursorX:: db
wCardFlipWhichCard:: db

;NEXTU
;; unused memory game
;wMemoryGameCardChoice:: db

NEXTU
; magnet train
wMagnetTrainOffset:: db
wMagnetTrainPosition:: db
wMagnetTrainWaitCounter:: db

NEXTU
; unown puzzle data
wHoldingUnownPuzzlePiece:: db
wUnownPuzzleCursorPosition:: db
wUnownPuzzleHeldPiece:: db

NEXTU
; battle transitions
wBattleTransitionCounter:: db
wBattleTransitionSineWaveOffset::
wBattleTransitionSpinQuadrant:: db

NEXTU
; stats screen
wStatsScreenFlags:: db

NEXTU
; miscellaneous
wFrameCounter::
wMomBankDigitCursorPosition::
wNamingScreenLetterCase::
wHallOfFameMonCounter::
wTradeDialog::
	db
wFrameCounter2:: db
wUnusedTradeAnimPlayEvolutionMusic:: db

ENDU

wPalFadeMode::
; bit 0-1: which (0: everything, 1: BG, 2: OBJ)
; bit 2: perform a smooth dark flash
; bit 3: partial fade (fade b of c frames)
; bit 4: skip the last palette
	db

wWindowStackPointer:: dw
wMenuJoypad:: db
wMenuSelection:: db
wMenuSelectionQuantity:: db
wWhichIndexSet:: db
wScrollingMenuCursorPosition:: db
wWindowStackSize:: db

	ds 8

; menu header
wMenuHeader::
wMenuFlags:: db
wMenuBorderTopCoord:: db
wMenuBorderLeftCoord:: db
wMenuBorderBottomCoord:: db
wMenuBorderRightCoord:: db
wMenuDataPointer:: dw
wMenuCursorBuffer:: dw
; end menu data header
wMenuDataBank:: db ; menu data bank?
	ds 6
wMenuHeaderEnd::

; TODO: organize this section better (integrate unions from pret/pokecrystal)
wMenuData::
wMenuDataFlags::
; bit 7: When set, start printing text one tile to the right of the border
;        In scrolling menus, SELECT is functional
; bit 6: When set, start printing text one tile below the border
;        In scrolling menus, START is functional
; bit 5: ????
; bit 4: ????
; bit 3: ????
; bit 2: Enable Start button
; bit 1: Enable Select button
; bit 0: Disable B button
	db
wMenuData_ScrollingMenuHeight::
wMenuDataItems::
	db
wMenuDataIndicesPointer::
wMenuDataSpacing::
wMenuData_ScrollingMenuWidth::
	db
wMenuData_2DMenuItemStringsBank::
wMenuData_ScrollingMenuSpacing::
	db
wMenuData_2DMenuItemStringsAddr::
wMenuDataDisplayFunctionPointer::
wMenuData_ItemsPointerBank::
	db
wMenuData_ItemsPointerAddr::
	db
wMenuDataPointerTableAddr::
wMenuData_2DMenuFunctionBank::
	db
wMenuData_2DMenuFunctionAddr::
wMenuData_ScrollingMenuFunction1::
	ds 3
wMenuData_ScrollingMenuFunction2::
	ds 3
wMenuData_ScrollingMenuFunction3::
	ds 3
wMenuDataEnd::

w2DMenuData::
w2DMenuCursorInitY:: db
w2DMenuCursorInitX:: db
w2DMenuNumRows:: db
w2DMenuNumCols:: db
w2DMenuFlags1::
; bit 7: Disable checking of wMenuJoypadFilter
; bit 6: Enable sprite animations
; bit 5: Wrap around vertically
; bit 4: Wrap around horizontally
; bit 3: Set bit 7 in w2DMenuFlags2 and exit the loop if bit 5 is disabled and we tried to go too far down
; bit 2: Set bit 7 in w2DMenuFlags2 and exit the loop if bit 5 is disabled and we tried to go too far up
; bit 1: Set bit 7 in w2DMenuFlags2 and exit the loop if bit 4 is disabled and we tried to go too far left
; bit 0: Set bit 7 in w2DMenuFlags2 and exit the loop if bit 4 is disabled and we tried to go too far right
	db
w2DMenuFlags2:: db
w2DMenuCursorOffsets:: db
wMenuJoypadFilter:: db
w2DMenuDataEnd::

wMenuCursorY:: db
wMenuCursorX:: db
wCursorOffCharacter:: db
wCursorCurrentTile:: dw

wBTTempOTSprite:: db

wPendingOverworldGraphics:: db
wTextDelayFrames:: db

	ds 1

wGenericDelay:: db

wGameTimerPaused::
; bit 0
	db

wInputFlags::
; bits 7, 6, and 4 can be used to disable joypad input
; bit 4
; bit 6: mon fainted?
; bit 7: SGB flag?
	db

wOverworldDelaySkip::
; amount of overworld frames to skip DelayFrame for
	db

wInBattleTowerBattle::
; 0 not in BattleTower-Battle
; 1 BattleTower-Battle
	db

wBattleMenuFlags::
; bit 0-2: quick-access buttons (b/start/select)
; bit 3: quick-select last pack item
	db

wFXAnimID::
wFXAnimIDLo:: db
wFXAnimIDHi:: db

wPlaceBallsX:: db
wPlaceBallsY:: db

wTileAnimationTimer:: db

; palette backups?
wBGP:: db
wOBP0:: db
wOBP1:: db

wNumHits:: db

wOptions3::
; bit 0: keyword abc/qwerty
; bits 1-7: unused
	db

wOptions::

wOptions1::
; bit 0-1: text delay
;   inst 0; fast 1; mid 2; slow 3
; bit 2-3: text autoscroll
;   none 0; start 1; a+b 2; a or b 3
; bit 4: turning step
; bit 5: no text delay
; bit 6: stereo off/on
; bit 7: battle scene off/on
	db

wSaveFileExists:: db

wTextboxFrame::
; bits 0-3: textbox frame 0-8
	db
wTextboxFlags::
; bit 0: 1-frame text delay
; bit 4: no text delay
	db

wOptions2::
; bit 0-2: typeface
; bit 3: running shoes off/on
; bit 4: clock format 12/24-hour
; bit 5: pokédex units imperial/metric
; bit 6: battle style set/switch
; bit 7: battle style set/predict
; (bits 6 and 7 are never both set)
	db

wInitialOptions::
; bit 0: natures off/on
; bit 1: abilities off/on
; bit 2: color variation off/on
; bit 3: perfect IVs off/on
; bit 4: traded behavior off/on
; bit 5: nuzlocke mode off/on
; bit 6: scaled exp on/off
; bit 7: physical-special split on/off
	db

wInitialOptions2::
; bits 0-6: unused
; bit 7: ask to reset at start
	db
wOptionsEnd::

; Time buffer, for counting the amount of time since an event began
wSecondsSince:: db
wMinutesSince:: db
wHoursSince:: db
wDaysSince:: db

; Temporary backup for options
wOptionsBuffer:: db
