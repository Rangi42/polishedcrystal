SECTION "SRAM Bank 0", SRAM

sSaveVersion:: dw
sUpgradeStep:: db
sWritingBackup:: db ; 1 if we're saving, anything else if not.

sRTCStatusFlags:: ds 8

sLuckyNumberDay:: db
sLuckyIDNumber:: dw


SECTION "Save", SRAM

sOptions:: ds wOptionsEnd - wOptions

sCheckValue1:: db ; loaded with 99, used to check save corruption

sGameData::
sPlayerData::  ds wPlayerDataEnd - wPlayerData
sMapData::     ds wCurMapDataEnd - wCurMapData
sPokemonData:: ds wPokemonDataEnd - wPokemonData
sGameDataEnd::

sOptions3:: db

	ds 392 ; unused

sSRAMAccessCount:: db

sChecksum:: dw
	assert sChecksum == $ad0d, "Checksum has shifted."

sCheckValue2:: db ; loaded with 127, used to check save corruption

	; These need to remain constant. Otherwise, the game will fail to
	; recognize that a save exist.
	assert sCheckValue1 == $a007, "Save check value 1 has shifted."
	assert sCheckValue2 == $ad0f, "Save check value 2 has shifted."


SECTION "Backup Save", SRAM

sBackupOptions:: ds wOptionsEnd - wOptions

sBackupCheckValue1:: db ; loaded with 99, used to check save corruption

sBackupGameData::
sBackupPlayerData::  ds wPlayerDataEnd - wPlayerData
sBackupMapData::     ds wCurMapDataEnd - wCurMapData
sBackupPokemonData:: ds wPokemonDataEnd - wPokemonData
sBackupGameDataEnd::

sBackupOptions3:: db

	ds 393 ; unused

sBackupChecksum:: dw
	assert sBackupChecksum == $bf0d, "Backup checksum has shifted."

sBackupCheckValue2:: db ; loaded with 127, used to check save corruption


SECTION "Link Battle Data", SRAM

sLinkBattleResults:: ds $c

sLinkBattleStats::
sLinkBattleWins::   dw
sLinkBattleLosses:: dw
sLinkBattleDraws::  dw

sLinkBattleRecord::
for n, 1, NUM_LINK_BATTLE_RECORDS + 1
sLinkBattleRecord{d:n}:: link_battle_record sLinkBattleRecord{d:n}
endr
sLinkBattleStatsEnd::


SECTION "SRAM Hall of Fame", SRAM

sHallOfFame::
for n, 1, NUM_HOF_TEAMS + 1
sHallOfFame{02d:n}:: hall_of_fame sHallOfFame{02d:n}
endr
sHallOfFameEnd::


SECTION "SRAM Mail", SRAM

sPartyMail::
for n, 1, PARTY_LENGTH + 1
sPartyMon{d:n}Mail:: mailmsg sPartyMon{d:n}Mail
endr

sPartyMailBackup::
for n, 1, PARTY_LENGTH + 1
sPartyMon{d:n}MailBackup:: mailmsg sPartyMon{d:n}MailBackup
endr

sMailboxCount:: db
sMailbox::
for n, 1, MAILBOX_CAPACITY + 1
sMailbox{d:n}:: mailmsg sMailbox{d:n}
endr

sMailboxCountBackup:: db
sMailboxBackup::
for n, 1, MAILBOX_CAPACITY + 1
sMailbox{d:n}Backup:: mailmsg sMailbox{d:n}Backup
endr


SECTION "SRAM Battle Tower", SRAM

; Battle Tower data must be in SRAM because you can reset between battles
sBattleTowerChallengeState:: db ; current challenge progress status

sBattleTower::
sBT_CurTrainerAndSwap:: db

; Battle Tower trainers are saved here, so nobody appears more than once
sBTTrainers:: ds BATTLETOWER_STREAK_LENGTH

UNION
sBT_PartySelections:: ds PARTY_LENGTH
NEXTU
sBT_MonParty:: ds BATTLETOWER_PARTYDATA_SIZE
ENDU

; Repeat prevention
sBT_OTMonParties::
sBT_OTMonParty1:: ds BATTLETOWER_PARTYDATA_SIZE ; oldest
sBT_OTMonParty2:: ds BATTLETOWER_PARTYDATA_SIZE ; trainer before prev
sBT_OTMonParty3:: ds BATTLETOWER_PARTYDATA_SIZE ; previous trainer


SECTION "Box metadata", SRAM

for n, 1, NUM_BOXES + 1
sNewBox{d:n}:: newbox sNewBox{d:n}
endr
sNewBoxEnd::

for n, 1, NUM_BOXES + 1
sBackupNewBox{d:n}:: newbox sBackupNewBox{d:n}
endr


SECTION "PokeDB bank 1A",  SRAM

sBoxMons1A:: pokedb sBoxMons1A, MONDB_ENTRIES_A


SECTION "PokeDB bank 2A", SRAM

sBoxMons2A:: pokedb sBoxMons2A, MONDB_ENTRIES_A


SECTION "PokeDB bank 1B",  SRAM

sBoxMons1B:: pokedb sBoxMons1B, MONDB_ENTRIES_B


SECTION "PokeDB bank 2B", SRAM

sBoxMons2B:: pokedb sBoxMons2B, MONDB_ENTRIES_B


SECTION "PokeDB bank 1C",  SRAM

sBoxMons1C:: pokedb sBoxMons1C, MONDB_ENTRIES_C


SECTION "PokeDB bank 2C", SRAM

sBoxMons2C:: pokedb sBoxMons2C, MONDB_ENTRIES_C
