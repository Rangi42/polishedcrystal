SECTION "Scratch", SRAM

sScratch:: ds $600


SECTION "SRAM Bank 0", SRAM

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

sSaveVersion:: dw
sUpgradeStep:: db
sWritingBackup:: db ; 1 if we're saving, anything else if not.

	ds 160

sRTCStatusFlags:: ds 8
sLuckyNumberDay:: db
sLuckyIDNumber:: dw


SECTION "Backup Save", SRAM

sBackupOptions:: ds wOptionsEnd - wOptions

sBackupCheckValue1:: db ; loaded with 99, used to check save corruption

sBackupGameData::
sBackupPlayerData::  ds wPlayerDataEnd - wPlayerData
sBackupMapData::     ds wCurMapDataEnd - wCurMapData
sBackupPokemonData:: ds wPokemonDataEnd - wPokemonData
sBackupGameDataEnd::

sBackupOptions3:: db

	ds 393

sBackupChecksum:: dw

sBackupCheckValue2:: db ; loaded with 127, used to check save corruption


SECTION "Save", SRAM

sOptions:: ds wOptionsEnd - wOptions

sCheckValue1:: db ; loaded with 99, used to check save corruption

sGameData::
sPlayerData::  ds wPlayerDataEnd - wPlayerData
sMapData::     ds wCurMapDataEnd - wCurMapData
sPokemonData:: ds wPokemonDataEnd - wPokemonData
sGameDataEnd::

sOptions3:: db

	ds 393

sChecksum:: dw

sCheckValue2:: db ; loaded with 127, used to check save corruption


SECTION "Active Box", SRAM

for n, 1, NUM_BOXES + 1
sNewBox{d:n}:: newbox sNewBox{d:n}
endr
sNewBoxEnd::

for n, 1, NUM_BOXES + 1
sBackupNewBox{d:n}:: newbox sBackupNewBox{d:n}
endr

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


SECTION "SRAM Battle Tower", SRAM

; Battle Tower data must be in SRAM because you can reset between battles
sBattleTowerChallengeState:: db ; current challenge progress status

sBattleTower::
sBT_CurTrainerAndSwap:: db

	ds 1 ; unused, may be 0-4 in old saves

; Battle Tower trainers are saved here, so nobody appears more than once
sBTTrainers:: ds BATTLETOWER_STREAK_LENGTH

	ds 1 ; unused, may be 0 or 2 in old saves

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


SECTION "Boxes 1-7",  SRAM

sBoxMons1:: pokedb sBoxMons1


SECTION "Boxes 8-14", SRAM

sBoxMons2:: pokedb sBoxMons2
