SECTION "Stack", WRAM0

wRAM0Start::
StackBottom::
	ds $100 - 1
Stack::
StackTop::
	ds 1


SECTION "Audio RAM", WRAM0

wMusic::
MusicPlaying:: ds 1 ; nonzero if playing

Channels::
Channel1:: channel_struct Channel1
Channel2:: channel_struct Channel2
Channel3:: channel_struct Channel3
Channel4:: channel_struct Channel4

SFXChannels::
Channel5:: channel_struct Channel5
Channel6:: channel_struct Channel6
Channel7:: channel_struct Channel7
Channel8:: channel_struct Channel8

	ds 1 ; unused

wCurTrackDuty:: ds 1
wCurTrackIntensity:: ds 1
wCurTrackFrequency:: ds 2
	ds 1 ; BCD value, dummied out
wCurNoteDuration:: ds 1 ; used in MusicE0 and LoadNote

CurMusicByte:: ds 1
CurChannel:: ds 1
Volume::
; corresponds to rNR50
; Channel control / ON-OFF / Volume (R/W)
;   bit 7 - Vin->SO2 ON/OFF
;   bit 6-4 - SO2 output level (volume) (# 0-7)
;   bit 3 - Vin->SO1 ON/OFF
;   bit 2-0 - SO1 output level (volume) (# 0-7)
	ds 1
SoundOutput::
; corresponds to rNR51
; bit 4-7: ch1-4 so2 on/off
; bit 0-3: ch1-4 so1 on/off
	ds 1
SoundInput::
; corresponds to rNR52
; bit 7: global on/off
; bit 0: ch1 on/off
; bit 1: ch2 on/off
; bit 2: ch3 on/off
; bit 3: ch4 on/off
	ds 1

MusicID::
MusicIDLo:: ds 1
MusicIDHi:: ds 1
MusicBank:: ds 1
NoiseSampleAddress::
NoiseSampleAddressLo:: ds 1
NoiseSampleAddressHi:: ds 1
wNoiseSampleDelay:: ds 1 ; noise delay?
	ds 1
MusicNoiseSampleSet:: ds 1
SFXNoiseSampleSet:: ds 1
Danger::
; bit 7: on/off
; bit 4: pitch
; bit 0-3: counter
	ds 1
MusicFade::
; fades volume over x frames
; bit 7: fade in/out
; bit 0-5: number of frames for each volume level
; $00 = none (default)
	ds 1
MusicFadeCount:: ds 1
MusicFadeID::
MusicFadeIDLo:: ds 1
MusicFadeIDHi:: ds 1
	ds 5
CryPitch:: ds 2
CryLength:: ds 2
LastVolume:: ds 1
	ds 1
SFXPriority:: ds 1 ; if nonzero, turn off music when playing sfx
	ds 1
Channel1JumpCondition:: ds 1
Channel2JumpCondition:: ds 1
Channel3JumpCondition:: ds 1
Channel4JumpCondition:: ds 1
wStereoPanningMask:: ds 1
CryTracks::
; plays only in left or right track depending on what side the monster is on
; both tracks active outside of battle
	ds 1
wSFXDuration:: ds 1
CurSFX:: ds 1 ; id of sfx currently playing
ChannelsEnd::

wMapMusic:: ds 1
wDontPlayMapMusicOnReload:: ds 1
wMusicEnd::


SECTION "WRAM 0", WRAM0

wLZAddress:: ds 2
wLZBank:: ds 1

	ds 1

wRNGState:: ds 4
wRNGCumulativeDividerPlus:: ds 2
wRNGCumulativeDividerMinus:: ds 1

wBoxAlignment:: ds 1
InputType:: ds 1
AutoInputAddress:: ds 2
AutoInputBank:: ds 1
AutoInputLength:: ds 1

wMonStatusFlags:: ds 1
wGameLogicPaused:: ds 1
wSpriteUpdatesEnabled:: ds 1
	ds 1
wMapTimeOfDay:: ds 1
	ds 3
wPrinterConnectionOpen:: ds 1
wPrinterOpcode:: ds 1
wLastDexEntry:: ds 1
wDisableTextAcceleration:: ds 1
wPreviousLandmark:: ds 1
wCurrentLandmark:: ds 1
wLandmarkSignTimer:: ds 2
wLinkMode::
; 0 not in link battle
; 1 link battle
; 4 mobile battle
	ds 1

ScriptVar:: ds 1

wPlayerNextMovement:: ds 1
wPlayerMovement:: ds 1
	ds 2
wMovementPerson:: ds 1
wMovementDataPointer:: ds 3 ; dba
	ds 4
wMovementByteWasControlSwitch:: ds 1
wMovementPointer:: ds 2
	ds 3

wTempObjectCopyMapObjectIndex:: ds 1
wTempObjectCopySprite:: ds 1
wTempObjectCopySpriteVTile:: ds 1
wTempObjectCopyPalette:: ds 1
wTempObjectCopyMovement:: ds 1
wTempObjectCopyRange:: ds 1
wTempObjectCopyX:: ds 1
wTempObjectCopyY:: ds 1
wTempObjectCopyRadius:: ds 1

TileDown:: ds 1
TileUp:: ds 1
TileLeft:: ds 1
TileRight:: ds 1

TilePermissions::
; set if tile behavior prevents
; you from walking in that direction
; bit 3: down
; bit 2: up
; bit 1: left
; bit 0: right
	ds 1


SECTION "Sprite Animations", WRAM0

; wSpriteAnimDict is a 10x2 dictionary.
; keys: taken from third column of SpriteAnimSeqData
; values: VTiles
wSpriteAnimDict:: ds 10 * 2

wSpriteAnimationStructs::
; Field  0: Index
; Fields 1-3: Loaded from SpriteAnimSeqData
SpriteAnim1::  sprite_anim_struct SpriteAnim1
SpriteAnim2::  sprite_anim_struct SpriteAnim2
SpriteAnim3::  sprite_anim_struct SpriteAnim3
SpriteAnim4::  sprite_anim_struct SpriteAnim4
SpriteAnim5::  sprite_anim_struct SpriteAnim5
SpriteAnim6::  sprite_anim_struct SpriteAnim6
SpriteAnim7::  sprite_anim_struct SpriteAnim7
SpriteAnim8::  sprite_anim_struct SpriteAnim8
SpriteAnim9::  sprite_anim_struct SpriteAnim9
SpriteAnim10:: sprite_anim_struct SpriteAnim10
wSpriteAnimationStructsEnd::

wSpriteAnimCount:: ds 1
wCurrSpriteOAMAddr:: ds 1

CurIcon:: ds 1


wCurIconTile:: ds 1
wSpriteAnimAddrBackup::
wSpriteAnimIDBuffer::
wCurrSpriteAddSubFlags::
	ds 2
wCurrAnimVTile:: ds 1
wCurrAnimXCoord:: ds 1
wCurrAnimYCoord:: ds 1
wCurrAnimXOffset:: ds 1
wCurrAnimYOffset:: ds 1
wGlobalAnimYOffset:: ds 1
wGlobalAnimXOffset:: ds 1
wSpriteAnimsEnd::


SECTION "Music Player RAM", WRAM0

MusicPlayerWRAM::
wSongSelection:: ds 2
wNumNoteLines:: ds 1
wTmpCh:: ds 1
wChLastNotes:: ds 3
wVolTimer:: ds 1
wC1Vol:: ds 1
wC1VolSub:: ds 1
wC2Vol:: ds 1
wC2VolSub:: ds 1
wC3Vol:: ds 1
wC3VolSub:: ds 1
wC4Vol:: ds 1
wC4VolSub:: ds 1
wNoteEnded:: ds 3
wSongInfoSwitch:: ds 1
;wRenderedWaveform:: ds 1
wPitchesTmp:: ds 4
;wWaveformTmp:: ds 16
wTmpValue:: ds 1
; song list
wSelectorTop:: ds 1
wSelectorCur:: ds 1
; song editor
wChannelSelector:: ds 1
wAdjustingTempo:: ds 1
; audio engine input
wChannelSelectorSwitches:: ds 4
wPitchTransposition:: ds 1
wTempoAdjustment:: ds 1
; audio engine output
wNoiseHit:: ds 1
MusicPlayerWRAMEnd::


SECTION "Sprites", WRAM0

Sprites::
; 4 bytes per sprite
; 40 sprites
; struct:
;	y (px)
;	x (px)
;	tile id
;	attributes:
;		bit 7: priority
;		bit 6: y flip
;		bit 5: x flip
;		bit 4: pal # (non-cgb)
;		bit 3: vram bank (cgb only)
;		bit 2-0: pal # (cgb only)
	ds 4 * 40
SpritesEnd::


SECTION "Tilemap", WRAM0

TileMap:: ds SCREEN_WIDTH * SCREEN_HEIGHT ; 20x18 grid of 8x8 tiles
TileMapEnd::


SECTION "Battle", WRAM0

UNION
; miscellaneous
wMisc:: ds (SCREEN_WIDTH + 4) * (SCREEN_HEIGHT + 2)
wMiscEnd::

NEXTU
; odd egg
wOddEgg:: party_struct OddEgg
wOddEggName:: ds PKMN_NAME_LENGTH
wOddEggOTName:: ds PKMN_NAME_LENGTH

NEXTU
; battle tower temp struct
wBT_OTTemp:: battle_tower_struct wBT_OTTemp

NEXTU
; hall of fame temp struct
	hall_of_fame wHallOfFameTemp

NEXTU
; timeset temp storage
wTimesetBuffer:: ds 20
wInitHourBuffer:: ds 13
wInitMinuteBuffer:: ds 17

NEXTU
; link engine
wLinkMisc:: ds 10
wLinkPlayerFixedPartyMon1ID:: ds 3
	ds 37

NEXTU
; battle
	ds 1

wBattle::
wEnemyMoveStruct::  move_struct wEnemyMoveStruct
wPlayerMoveStruct:: move_struct wPlayerMoveStruct

EnemyMonNick:: ds PKMN_NAME_LENGTH
BattleMonNick:: ds PKMN_NAME_LENGTH

BattleMon:: battle_struct BattleMon

	ds 2

wWildMon:: ds 1
	ds 1
wEnemyTrainerItem1:: ds 1
wEnemyTrainerItem2:: ds 1
wEnemyTrainerBaseReward:: ds 1
wEnemyTrainerAIFlags:: ds 3
OTClassName:: ds TRAINER_CLASS_NAME_LENGTH

CurOTMon:: ds 1

wBattleParticipantsNotFainted::
; Bit array.  Bits 0 - 5 correspond to party members 1 - 6.
; Bit set if the mon appears in battle.
; Bit cleared if the mon faints.
; Backed up if the enemy switches.
; All bits cleared if the enemy faints.
	ds 1

TypeModifier::
; >10: super-effective
;  10: normal
; <10: not very effective
; bit 7: stab
	ds 1

CriticalHit::
; 0 if not critical
; 1 for a critical hit
; 2 for a OHKO
	ds 1

AttackMissed::
; nonzero for a miss
	ds 1

BattleSubStatusWRAM::
PlayerSubStatus1::
; bit
; 7 attract
; 6 encore
; 5 endure
; 4 perish song
; 3 identified
; 2 protect
; 1 curse
; 0 unburden
	ds 1
PlayerSubStatus2::
; bit
; 7 cant run
; 6 destiny bond
; 5 lock-on
; 4 encore
; 3 transformed
; 2
; 1
; 0 toxic
	ds 1
PlayerSubStatus3::
; bit
; 7 confused
; 6 flying
; 5 underground
; 4 charged
; 3 flinch
; 2
; 1 rollout
; 0 bide
	ds 1
PlayerSubStatus4::
; bit
; 7 leech seed
; 6 rage
; 5 recharge
; 4 substitute
; 3
; 2 focus energy
; 1 mist
; 0 curled
	ds 1

EnemySubStatus1::
; see PlayerSubStatus1
	ds 1
EnemySubStatus2::
; see PlayerSubStatus2
	ds 1
EnemySubStatus3::
; see PlayerSubStatus3
	ds 1
EnemySubStatus4::
; see PlayerSubStatus4
	ds 1

PlayerAbility:: ds 1
PlayerRolloutCount:: ds 1
PlayerConfuseCount:: ds 1
PlayerToxicCount:: ds 1
PlayerDisableCount:: ds 1
PlayerEncoreCount:: ds 1
PlayerPerishCount:: ds 1
PlayerProtectCount:: ds 1
	ds 1

EnemyAbility:: ds 1
EnemyRolloutCount:: ds 1
EnemyConfuseCount:: ds 1
EnemyToxicCount:: ds 1
EnemyDisableCount:: ds 1
EnemyEncoreCount:: ds 1
EnemyPerishCount:: ds 1
EnemyProtectCount:: ds 1
	ds 1
BattleSubStatusWRAMEnd::

PlayerDamageTaken:: ds 2
EnemyDamageTaken:: ds 2

wBattleReward:: ds 3
wBattleAnimParam::
wKickCounter:: ds 1

PartyBackupItems::
; Back up of party items before a battle. Modified in-battle for consumed/harvested.
; Berries and items stolen from wild Pokémon since those changes are retained.
	ds PARTY_LENGTH

PartyUsedItems::
; For the benefit of Pickup/Harvest
	ds PARTY_LENGTH

OTPartyUsedItems::
; See PartyUsedItems
	ds PARTY_LENGTH

; What move was selected last.
; Used for Choice locking and the Metronome item
PlayerSelectedMove:: ds 1
EnemySelectedMove:: ds 1

; How much the Metronome item is boosted. (Counts even if you don't have the item.)
PlayerMetronomeCount:: ds 1
EnemyMetronomeCount:: ds 1

; Stores enemy struct data temporarily when checking non-current mons
AITempAbility:: ds 1
AITempItem:: ds 1

wEnemyBackupSpecies:: ds 1

	ds 15

BattleScriptBufferLoc:: ds 2

wTurnEnded:: ds 1

	ds 13

PlayerStatLevels::
; 07 neutral
PlayerAtkLevel:: ds 1
PlayerDefLevel:: ds 1
PlayerSpdLevel:: ds 1
PlayerSAtkLevel:: ds 1

UNION
; battle subsection
PlayerSDefLevel:: ds 1
PlayerAccLevel:: ds 1
PlayerEvaLevel:: ds 1
	ds 1

EnemyStatLevels::
; 07 neutral
EnemyAtkLevel:: ds 1
EnemyDefLevel:: ds 1
EnemySpdLevel:: ds 1
EnemySAtkLevel:: ds 1
EnemySDefLevel:: ds 1
EnemyAccLevel:: ds 1
EnemyEvaLevel:: ds 1
	ds 1

EnemyTurnsTaken:: ds 1
PlayerTurnsTaken:: ds 1

PlayerSubstituteHP:: ds 2
EnemySubstituteHP:: ds 2

	ds 1

CurPlayerMove:: ds 1
CurEnemyMove:: ds 1

LinkBattleRNCount:: ds 1 ; how far through the prng stream

wEnemyItemState:: ds 1

	ds 2

CurEnemyMoveNum:: ds 1

wEnemyHPAtTimeOfPlayerSwitch:: ds 2
wPayDayMoney:: ds 3

wSafariMonAngerCount:: ds 1
wSafariMonEating:: ds 1

	ds 1

; used when enemy is transformed
wEnemyBackupDVs:: ds 3
wEnemyBackupPersonality:: ; assumed to be after DVs
wEnemyBackupShiny::
wEnemyBackupAbility::
wEnemyBackupNature::
	ds 1
wEnemyBackupGender::
wEnemyBackupFainted::
wEnemyBackupForm::
	ds 1

AlreadyDisobeyed:: ds 1

DisabledMove:: ds 1
EnemyDisabledMove:: ds 1

wWhichMonFaintedFirst:: ds 1

; exists so you can't counter on switch
LastEnemyCounterMove:: ds 1
LastPlayerCounterMove:: ds 1

wEnemyMinimized:: ds 1

AlreadyFailed:: ds 1

wBattleParticipantsIncludingFainted:: ds 1

wDanger:: ds 1

wPlayerMinimized:: ds 1

PlayerScreens::
; bit
; 4 reflect
; 3 light screen
; 2 safeguard
; 0 spikes
	ds 1

EnemyScreens::
; see PlayerScreens
	ds 1

PlayerSafeguardCount:: ds 1
PlayerLightScreenCount:: ds 1
PlayerReflectCount:: ds 1
	ds 1

EnemySafeguardCount:: ds 1
EnemyLightScreenCount:: ds 1
EnemyReflectCount:: ds 1
	ds 1

	ds 1

Weather::
; 00 normal
; 01 rain
; 02 sun
; 03 sandstorm
; 04 rain stopped
; 05 sunliight faded
; 06 sandstorm subsided
	ds 1

WeatherCount:: ds 1 ; # turns remaining

LoweredStat:: ds 1
EffectFailed:: ds 1
FailedMessage:: ds 1

wEnemyGoesFirst:: ds 1

wPlayerIsSwitching:: ds 1
wEnemyIsSwitching::  ds 1

PlayerUsedMoves::
; add a move that has been used once by the player
; added in order of use
	ds NUM_MOVES

wEnemyAISwitchScore:: ds 1
wEnemySwitchMonParam:: ds 1
wEnemySwitchMonIndex:: ds 1

wTempLevel:: ds 1

LastPlayerMon:: ds 1

LastPlayerMove:: ds 1
LastEnemyMove:: ds 1

	ds 9

wPlayerFutureSightCount:: ds 1
wEnemyFutureSightCount:: ds 1
wPlayerFutureSightDamage:: ds 2
wEnemyFutureSightDamage:: ds 2
wPlayerTrappingMove:: ds 1
wEnemyTrappingMove:: ds 1
wPlayerWrapCount:: ds 1
wEnemyWrapCount:: ds 1
wPlayerCharging:: ds 1
wEnemyCharging:: ds 1

wGivingExperienceToExpShareHolders:: ds 1

AnimationsDisabled:: ds 1 ; used to temporarily disable animations for abilities

BattleEnded:: ds 1

wWildMonMoves:: ds NUM_MOVES
wWildMonPP:: ds NUM_MOVES

wAmuletCoin:: ds 1

wSomeoneIsRampaging:: ds 1

wPlayerJustGotFrozen:: ds 1
wEnemyJustGotFrozen:: ds 1

DVAndPersonalityBuffer:: ds 5
wBattleEnd::

NEXTU
; trade
wTrademons::
wPlayerTrademon:: trademon wPlayerTrademon
wOTTrademon:: trademon wOTTrademon
wTrademonsEnd::
wTradeAnimPointer:: ds 2
wLinkPlayer1Name:: ds NAME_LENGTH
wLinkPlayer2Name:: ds NAME_LENGTH
wLinkTradeSendmonSpecies:: ds 1
wLinkTradeGetmonSpecies:: ds 1

NEXTU
; naming screen
wNamingScreenDestinationPointer:: ds 2
wNamingScreenCurrNameLength:: ds 1
wNamingScreenMaxNameLength:: ds 1
wNamingScreenType:: ds 1
wNamingScreenCursorObjectPointer:: ds 2
wNamingScreenLastCharacter:: ds 1
wNamingScreenStringEntryCoord:: ds 2

NEXTU
; pokegear
wPokegearPhoneLoadNameBuffer:: ds 1
wPokegearPhoneCursorPosition:: ds 1
wPokegearPhoneScrollPosition:: ds 1
wPokegearPhoneSelectedPerson:: ds 1
wPokegearPhoneSubmenuCursor:: ds 1
wPokegearMapCursorObjectPointer:: ds 2
wPokegearMapCursorLandmark:: ds 1
wPokegearMapPlayerIconLandmark:: ds 1
wPokegearRadioChannelBank:: ds 1
wPokegearRadioChannelAddr:: ds 2
wPokegearRadioMusicPlaying:: ds 1
wPokegearNumberBuffer:: ds 1

NEXTU
; slot machine
wSlots::
wReel1:: slot_reel wReel1
wReel2:: slot_reel wReel2
wReel3:: slot_reel wReel3
wReel1Stopped:: ds 3
wReel2Stopped:: ds 3
wReel3Stopped:: ds 3
wSlotBias:: ds 1
wSlotBet:: ds 1
wFirstTwoReelsMatching:: ds 1
wFirstTwoReelsMatchingSevens:: ds 1
wSlotMatched:: ds 1
wCurrReelStopped:: ds 3
wPayout:: ds 2
wCurrReelXCoord:: ds 1
wCurrReelYCoord:: ds 1
	ds 2
wSlotBuildingMatch:: ds 1
wSlotsDataEnd::
	ds 28
wSlotsEnd::

NEXTU
; card flip
wCardFlip::
wDeck:: ds 24
wDeckEnd::
wCardFlipNumCardsPlayed:: ds 1
wCardFlipFaceUpCard:: ds 1
wDiscardPile:: ds 24
wDiscardPileEnd::
wCardFlipEnd::

;NEXTU
;; dummy game
;wDummyGame::
;wDummyGameCards:: ds 9 * 5
;wDummyGameCardsEnd::
;wDummyGameLastCardPicked:: ds 1
;wDummyGameCard1:: ds 1
;wDummyGameCard2:: ds 1
;wDummyGameCard1Location:: ds 1
;wDummyGameCard2Location:: ds 1
;wDummyGameNumberTriesRemaining:: ds 1
;wDummyGameLastMatches:: ds 5
;wDummyGameCounter:: ds 1
;wDummyGameNumCardsMatched:: ds 1
;wDummyGameEnd::

NEXTU
; Unown puzzle
wUnownPuzzle::
wPuzzlePieces:: ds 6 * 6
wUnownPuzzleEnd::

NEXTU
; Pokedex
wPokedexDataStart::
wPokedexOrder:: ds NUM_POKEMON +- 1
wPokedexOrderEnd:: ds 6
wPokedexMetadata::
wDexListingScrollOffset:: ds 1 ; offset of the first displayed entry from the start
wDexListingCursor:: ds 1 ; Dex cursor
wDexListingEnd:: ds 1 ; Last mon to display
wDexListingHeight:: ds 1 ; number of entries displayed at once in the dex listing
wCurrentDexMode:: ds 1 ; Pokedex Mode
wDexSearchMonType1:: ds 1 ; first type to search
wDexSearchMonType2:: ds 1 ; second type to search
wDexSearchResultCount:: ds 1
wDexArrowCursorPosIndex:: ds 1
wDexArrowCursorDelayCounter:: ds 1
wDexArrowCursorBlinkCounter:: ds 1
wDexSearchSlowpokeFrame:: ds 1
wUnlockedUnownMode:: ds 1
wDexCurrentUnownIndex:: ds 1
wDexUnownCount:: ds 1
wDexConvertedMonType:: ds 1 ; mon type converted from dex search mon type
wDexListingScrollOffsetBackup:: ds 1
wDexListingCursorBackup:: ds 1
wBackupDexListingCursor:: ds 1
wBackupDexListingPage:: ds 1
wDexCurrentLocation:: ds 1
wPokedexStatus:: ds 1
wDexMonShiny:: ds 1
wPokedexDataEnd::

ENDU

ENDU


SECTION "Overworld Map", WRAM0

UNION
; overworld map
OverworldMap:: ds 1300
OverworldMapEnd::

NEXTU
; credits image
wCreditsFaux2bpp:: ds 8 * 8 * 2

NEXTU
; Bill's PC
wBillsPCPokemonList::
; Pokemon, box number, list index
	ds 811
wBillsPC_ScrollPosition:: ds 1
wBillsPC_CursorPosition:: ds 1
wBillsPC_NumMonsInBox:: ds 1
wBillsPC_NumMonsOnScreen:: ds 1
wBillsPC_LoadedBox:: ds 1 ; 0 if party, 1 - 14 if box, 15 if active box
wBillsPC_BackupScrollPosition:: ds 1
wBillsPC_BackupCursorPosition:: ds 1
wBillsPC_BackupLoadedBox:: ds 1
wBillsPC_MonHasMail:: ds 1

NEXTU
; link data
wLinkData::
wLinkPlayerName:: ds NAME_LENGTH
wLinkPartyCount:: ds 1
wLinkPartySpecies:: ds PARTY_LENGTH + 1 ; legacy scripts don't check PartyCount

wLinkPlayerData::
wLinkPlayerPartyMon1:: party_struct wLinkPlayerPartyMon1
wLinkPlayerPartyMon2:: party_struct wLinkPlayerPartyMon2
wLinkPlayerPartyMon3:: party_struct wLinkPlayerPartyMon3
wLinkPlayerPartyMon4:: party_struct wLinkPlayerPartyMon4
wLinkPlayerPartyMon5:: party_struct wLinkPlayerPartyMon5
wLinkPlayerPartyMon6:: party_struct wLinkPlayerPartyMon6
wLinkPlayerPartyMonOTNames:: ds PARTY_LENGTH * NAME_LENGTH
wLinkPlayerPartyMonNicks:: ds PARTY_LENGTH * PKMN_NAME_LENGTH
wLinkPlayerDataEnd::
	ds 861
wLinkDataEnd::

NEXTU
; more link data
; TODO: replace with meaningful labels
	ds 271
wc90f:: ds 229
wc9f4:: ds 5
wc9f9:: ds 145
wHandshakeFrameDelay:: ds 53
wcabf:: ds 79
wcb0e:: ds 5
wcb13:: ds 113
wcb84:: ds 102
	ds 96
wcc4a:: ds 84
wcc9e:: ds 130

ENDU


SECTION "Video", WRAM0

BGMapBuffer:: ds 40
BGMapPalBuffer:: ds 40
BGMapBufferPtrs:: ds 40 ; 20 bg map addresses (16x8 tiles)

CreditsPos:: ds 2
CreditsTimer:: ds 1

MemCGBLayout:: ds 1

PlayerHPPal:: ds 1
EnemyHPPal:: ds 1
wHPPals:: ds PARTY_LENGTH
wCurHPPal:: ds 1
wHPPalIndex:: ds 1

	ds 51

AttrMap::
; 20x18 grid of palettes for 8x8 tiles
; read horizontally from the top row
; bit 7: priority
; bit 6: y flip
; bit 5: x flip
; bit 4: pal # (non-cgb)
; bit 3: vram bank (cgb only)
; bit 2-0: pal # (cgb only)
	ds SCREEN_WIDTH * SCREEN_HEIGHT
AttrMapEnd::

wTileAnimBuffer:: ds 16

; addresses dealing with serial comms
wOtherPlayerLinkMode:: ds 1
wOtherPlayerLinkAction:: ds 4
wPlayerLinkAction:: ds 1
wcf57:: ds 4 ; TODO: replace with meaningful label
wLinkTimeoutFrames:: ds 2
wcf5d:: ds 2 ; TODO: replace with meaningful label

MonType:: ds 1

CurSpecies::
CurMove::
wCreditsSpawn::
	ds 1

wNamedObjectTypeBuffer:: ds 1
wCurrentOptionsPage:: ds 1

wJumptableIndex::
wBattleTowerBattleEnded::
	ds 1

UNION
; intro and title data
wIntroSceneFrameCounter:: ds 1
wTitleScreenTimerLo:: ds 1
wTitleScreenTimerHi:: ds 1

NEXTU
; credits data
wCreditsBorderFrame:: ds 1
wCreditsBorderMon:: ds 1
wCreditsLYOverride:: ds 1

NEXTU
; unown puzzle data
wHoldingUnownPuzzlePiece:: ds 1
wUnownPuzzleCursorPosition:: ds 1
wUnownPuzzleHeldPiece:: ds 1

NEXTU
; card flip data
wCardFlipCursorY:: ds 1
wCardFlipCursorX:: ds 1
wCardFlipWhichCard:: ds 1

NEXTU
; miscellaneous
wDexEntryPrevJumptableIndex::
wMomBankDigitCursorPosition::
wNrOfBeatenBattleTowerTrainers::
	ds 1
wCurrPocket:: ds 1

NEXTU
; unidentified
wcf64:: ds 1 ; TODO: replace with meaningful labels
wcf65:: ds 1 ; TODO: replace with meaningful labels
wcf66:: ds 1 ; TODO: replace with meaningful labels

ENDU

Requested2bpp::
Requested2bppSize:: ds 1
Requested2bppSource:: ds 2
Requested2bppDest:: ds 2

Requested1bpp::
Requested1bppSize:: ds 1
Requested1bppSource:: ds 2
Requested1bppDest:: ds 2

wWindowStackPointer:: ds 2
wMenuJoypad:: ds 1
MenuSelection:: ds 1
MenuSelectionQuantity:: ds 1
wWhichIndexSet:: ds 1
wScrollingMenuCursorPosition:: ds 1
wWindowStackSize:: ds 9

; menu data header
wMenuDataHeader::
wMenuFlags:: ds 1
wMenuBorderTopCoord:: ds 1
wMenuBorderLeftCoord:: ds 1
wMenuBorderBottomCoord:: ds 1
wMenuBorderRightCoord:: ds 1
wMenuData2Pointer:: ds 2
wMenuCursorBuffer:: ds 2
; end menu data header
wMenuDataBank:: ds 1 ; menu data bank?
	ds 6
wMenuDataHeaderEnd::

wMenuData2::
wMenuData2Flags::
; bit 7: When set, start printing text one tile to the right of the border
;        In scrolling menus, SELECT is functional
; bit 6: When set, start printing text one tile below the border
;        In scrolling menus, START is functional
; bit 5: ????
; bit 4: ????
; bit 3: ????
; bit 2: ????
; bit 1: Enable Select button
; bit 0: Disable B button
	ds 1
wMenuData2_ScrollingMenuHeight::
wMenuData2Items::
	ds 1
wMenuData2IndicesPointer::
wMenuData2Spacing::
wMenuData2_ScrollingMenuWidth::
	ds 1
wMenuData2_2DMenuItemStringsBank::
wMenuData2_ScrollingMenuSpacing::
	ds 1
wMenuData2_2DMenuItemStringsAddr::
wMenuData2DisplayFunctionPointer::
wMenuData2_ItemsPointerBank::
	ds 1
wMenuData2_ItemsPointerAddr::
	ds 1
wMenuData2PointerTableAddr::
wMenuData2_2DMenuFunctionBank::
	ds 1
wMenuData2_2DMenuFunctionAddr::
wMenuData2_ScrollingMenuFunction1::
	ds 3
wMenuData2_ScrollingMenuFunction2::
	ds 3
wMenuData2_ScrollingMenuFunction3::
	ds 3
wMenuData2End::

wMenuData3::
w2DMenuCursorInitY:: ds 1
w2DMenuCursorInitX:: ds 1
w2DMenuNumRows:: ds 1
w2DMenuNumCols:: ds 1
w2DMenuFlags1:: ds 1
w2DMenuFlags2:: ds 1
w2DMenuCursorOffsets:: ds 1
wMenuJoypadFilter:: ds 1
wMenuData3End::

wMenuCursorY:: ds 1
wMenuCursorX:: ds 1
wCursorOffCharacter:: ds 1
wCursorCurrentTile:: ds 2

wTrainerCardBadgePaletteAddr:: ds 2

wBTTempOTSprite:: ds 1

OverworldDelay:: ds 1
TextDelayFrames:: ds 1
VBlankOccurred:: ds 1

	ds 8 ; unused

GameTimerPause::
; bit 0
	ds 1

InputFlags::
; bits 7, 6, and 4 can be used to disable joypad input
	ds 2

InBattleTowerBattle:: ds 1

	ds 1

FXAnimID::
FXAnimIDLo:: ds 1
FXAnimIDHi:: ds 1

wPlaceBallsX:: ds 1
wPlaceBallsY:: ds 1

TileAnimationTimer:: ds 1

; palette backups?
wBGP:: ds 1
wOBP0:: ds 1
wOBP1:: ds 1

wNumHits:: ds 2

Options1::
; bit 0-2: number of frames to delay when printing text
;   fast 1; mid 3; slow 5
; bit 3: ?
; bit 4: no text delay
; bit 5: stereo off/on
; bit 6: battle scene off/on
; bit 7: unused
	ds 1

wSaveFileExists:: ds 1

TextBoxFrame::
; bits 0-3: textbox frame 0-8
	ds 1

TextBoxFlags:: ds 1

	ds 1

Options2::
; bit 0-2: typeface
; bit 3: running shoes off/on
; bit 4: clock format 12/24-hour
; bit 5: pokédex units imperial/metric
; bit 6: battle style set/switch
; bit 7: battle style set/predict
; (bits 6 and 7 are never both set)
	ds 1

InitialOptions::
; bit 0: natures off/on
; bit 1: abilities off/on
; bit 2: color variation off/on
; bit 3: perfect IVs off/on
; bit 4: traded behavior off/on
; bit 5: nuzlocke mode off/on
; bit 6: unused
; bit 7: ask to reset at start
	ds 1

OptionsBuffer:: ds 1
OptionsEnd::

; Time buffer, for counting the amount of time since an event began
wSecondsSince:: ds 1
wMinutesSince:: ds 1
wHoursSince:: ds 1
wDaysSince:: ds 1
