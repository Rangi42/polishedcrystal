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

	ds 162

sRTCStatusFlags:: ds 8
sLuckyNumberDay:: db
sLuckyIDNumber:: dw


SECTION "Backup Save", SRAM

sBackupOptions:: ds wOptionsEnd - wOptions1

sBackupCheckValue1:: db ; loaded with 99, used to check save corruption

sBackupGameData::
sBackupPlayerData::  ds wPlayerDataEnd - wPlayerData
sBackupMapData::     ds wCurMapDataEnd - wCurMapData
sBackupPokemonData:: ds wPokemonDataEnd - wPokemonData
sBackupGameDataEnd::

	ds 394

sBackupChecksum:: dw

sBackupCheckValue2:: db ; loaded with 127, used to check save corruption


SECTION "Save", SRAM

sOptions:: ds wOptionsEnd - wOptions1

sCheckValue1:: db ; loaded with 99, used to check save corruption

sGameData::
sPlayerData::  ds wPlayerDataEnd - wPlayerData
sMapData::     ds wCurMapDataEnd - wCurMapData
sPokemonData:: ds wPokemonDataEnd - wPokemonData
sGameDataEnd::

	ds 394

sChecksum:: dw

sCheckValue2:: db ; loaded with 127, used to check save corruption


SECTION "Active Box", SRAM

sBox:: box sBox

	ds $f4


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
sBTTrainers:: ds BATTLETOWER_NROFTRAINERS

	ds 1 ; unused, may be 0 or 2 in old saves

sBT_PartySelections:: ds PARTY_LENGTH

; Repeat prevention
sBT_OTMonParties:: ds BATTLETOWER_PARTYDATA_SIZE * BATTLETOWER_SAVEDPARTIES


SECTION "Boxes 1-7",  SRAM

sBox1::  box sBox1
sBox2::  box sBox2
sBox3::  box sBox3
sBox4::  box sBox4
sBox5::  box sBox5
sBox6::  box sBox6
sBox7::  box sBox7


SECTION "Boxes 8-14", SRAM

sBox8::  box sBox8
sBox9::  box sBox9
sBox10:: box sBox10
sBox11:: box sBox11
sBox12:: box sBox12
sBox13:: box sBox13
sBox14:: box sBox14
