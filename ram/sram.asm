SECTION "Scratch", SRAM

sScratch:: ds $600


SECTION "SRAM Bank 0", SRAM

sPartyMail::
sPartyMon1Mail:: mailmsg sPartyMon1Mail
sPartyMon2Mail:: mailmsg sPartyMon2Mail
sPartyMon3Mail:: mailmsg sPartyMon3Mail
sPartyMon4Mail:: mailmsg sPartyMon4Mail
sPartyMon5Mail:: mailmsg sPartyMon5Mail
sPartyMon6Mail:: mailmsg sPartyMon6Mail

sPartyMailBackup::
sPartyMon1MailBackup:: mailmsg sPartyMon1MailBackup
sPartyMon2MailBackup:: mailmsg sPartyMon2MailBackup
sPartyMon3MailBackup:: mailmsg sPartyMon3MailBackup
sPartyMon4MailBackup:: mailmsg sPartyMon4MailBackup
sPartyMon5MailBackup:: mailmsg sPartyMon5MailBackup
sPartyMon6MailBackup:: mailmsg sPartyMon6MailBackup

sMailboxCount:: db
sMailbox::
sMailbox1::  mailmsg sMailbox1
sMailbox2::  mailmsg sMailbox2
sMailbox3::  mailmsg sMailbox3
sMailbox4::  mailmsg sMailbox4
sMailbox5::  mailmsg sMailbox5
sMailbox6::  mailmsg sMailbox6
sMailbox7::  mailmsg sMailbox7
sMailbox8::  mailmsg sMailbox8
sMailbox9::  mailmsg sMailbox9
sMailbox10:: mailmsg sMailbox10

sMailboxCountBackup:: db
sMailboxBackup::
sMailbox1Backup::  mailmsg sMailbox1Backup
sMailbox2Backup::  mailmsg sMailbox2Backup
sMailbox3Backup::  mailmsg sMailbox3Backup
sMailbox4Backup::  mailmsg sMailbox4Backup
sMailbox5Backup::  mailmsg sMailbox5Backup
sMailbox6Backup::  mailmsg sMailbox6Backup
sMailbox7Backup::  mailmsg sMailbox7Backup
sMailbox8Backup::  mailmsg sMailbox8Backup
sMailbox9Backup::  mailmsg sMailbox9Backup
sMailbox10Backup:: mailmsg sMailbox10Backup

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

sNewBox1:: newbox sNewBox1
sNewBox2:: newbox sNewBox2
sNewBox3:: newbox sNewBox3
sNewBox4:: newbox sNewBox4
sNewBox5:: newbox sNewBox5
sNewBox6:: newbox sNewBox6
sNewBox7:: newbox sNewBox7
sNewBox8:: newbox sNewBox8
sNewBox9:: newbox sNewBox9
sNewBox10:: newbox sNewBox10
sNewBox11:: newbox sNewBox11
sNewBox12:: newbox sNewBox12
sNewBox13:: newbox sNewBox13
sNewBox14:: newbox sNewBox14
sNewBox15:: newbox sNewBox15
sNewBoxEnd::

sBackupNewBox1:: newbox sBackupNewBox1
sBackupNewBox2:: newbox sBackupNewBox2
sBackupNewBox3:: newbox sBackupNewBox3
sBackupNewBox4:: newbox sBackupNewBox4
sBackupNewBox5:: newbox sBackupNewBox5
sBackupNewBox6:: newbox sBackupNewBox6
sBackupNewBox7:: newbox sBackupNewBox7
sBackupNewBox8:: newbox sBackupNewBox8
sBackupNewBox9:: newbox sBackupNewBox9
sBackupNewBox10:: newbox sBackupNewBox10
sBackupNewBox11:: newbox sBackupNewBox11
sBackupNewBox12:: newbox sBackupNewBox12
sBackupNewBox13:: newbox sBackupNewBox13
sBackupNewBox14:: newbox sBackupNewBox14
sBackupNewBox15:: newbox sBackupNewBox15

SECTION "Link Battle Data", SRAM

sLinkBattleResults:: ds $c

sLinkBattleStats::
sLinkBattleWins::   dw
sLinkBattleLosses:: dw
sLinkBattleDraws::  dw

sLinkBattleRecord::
sLinkBattleRecord1:: link_battle_record sLinkBattleRecord1
sLinkBattleRecord2:: link_battle_record sLinkBattleRecord2
sLinkBattleRecord3:: link_battle_record sLinkBattleRecord3
sLinkBattleRecord4:: link_battle_record sLinkBattleRecord4
sLinkBattleRecord5:: link_battle_record sLinkBattleRecord5
sLinkBattleStatsEnd::


SECTION "SRAM Hall of Fame", SRAM

sHallOfFame::
sHallOfFame01:: hall_of_fame sHallOfFame01
sHallOfFame02:: hall_of_fame sHallOfFame02
sHallOfFame03:: hall_of_fame sHallOfFame03
sHallOfFame04:: hall_of_fame sHallOfFame04
sHallOfFame05:: hall_of_fame sHallOfFame05
sHallOfFame06:: hall_of_fame sHallOfFame06
sHallOfFame07:: hall_of_fame sHallOfFame07
sHallOfFame08:: hall_of_fame sHallOfFame08
sHallOfFame09:: hall_of_fame sHallOfFame09
sHallOfFame10:: hall_of_fame sHallOfFame10
sHallOfFame11:: hall_of_fame sHallOfFame11
sHallOfFame12:: hall_of_fame sHallOfFame12
sHallOfFame13:: hall_of_fame sHallOfFame13
sHallOfFame14:: hall_of_fame sHallOfFame14
sHallOfFame15:: hall_of_fame sHallOfFame15
sHallOfFame16:: hall_of_fame sHallOfFame16
sHallOfFame17:: hall_of_fame sHallOfFame17
sHallOfFame18:: hall_of_fame sHallOfFame18
sHallOfFame19:: hall_of_fame sHallOfFame19
sHallOfFame20:: hall_of_fame sHallOfFame20
sHallOfFame21:: hall_of_fame sHallOfFame21
sHallOfFame22:: hall_of_fame sHallOfFame22
sHallOfFame23:: hall_of_fame sHallOfFame23
sHallOfFame24:: hall_of_fame sHallOfFame24
sHallOfFame25:: hall_of_fame sHallOfFame25
sHallOfFame26:: hall_of_fame sHallOfFame26
sHallOfFame27:: hall_of_fame sHallOfFame27
sHallOfFame28:: hall_of_fame sHallOfFame28
sHallOfFame29:: hall_of_fame sHallOfFame29
sHallOfFame30:: hall_of_fame sHallOfFame30
sHallOfFameEnd::

; x = 1
; rept NUM_HOF_TEAMS
; ; PRINTT("{x}\n")
; if STRLEN({x}) == 2
	; PRINTT(STRSUB({x},2,1))
	; hall_of_fame STRCAT("sHallOfFame0", STRSUB({x},2,1))
; else
	; PRINTT(STRSUB({x},2,2))
	; hall_of_fame STRCAT("sHallOfFame", STRSUB({x},2,2))
; endc
; x = x + 1
; endr


SECTION "SRAM Battle Tower", SRAM

; Battle Tower data must be in SRAM because you can reset between battles
sBattleTowerChallengeState:: db ; current challenge progress status

sBattleTower::
sBT_CurTrainer:: db

	ds 1 ; unused, may be 0-4 in old saves

; Battle Tower trainers are saved here, so nobody appears more than once
sBTTrainers:: ds BATTLETOWER_STREAK_LENGTH

	ds 1 ; unused, may be 0 or 2 in old saves

sBT_PartySelections:: ds PARTY_LENGTH

; Repeat prevention
sBT_OTMonParties:: ds BATTLETOWER_PARTYDATA_SIZE * BATTLETOWER_SAVEDPARTIES


SECTION "Boxes 1-7",  SRAM

sBoxMons1:: pokedb sBoxMons1


SECTION "Boxes 8-14", SRAM

sBoxMons2:: pokedb sBoxMons2
