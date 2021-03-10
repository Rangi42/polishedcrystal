UnusedPhoneScript:
	farwritetext UnusedPhoneText
	end

; Mom

MomPhoneScript:
	checkevent EVENT_TALKED_TO_MOM_AFTER_MYSTERY_EGG_QUEST
	iftrue .bcec5
	checkevent EVENT_LEARNED_TO_CATCH_POKEMON
	iftrue MomPhoneLectureScript
	checkevent EVENT_GAVE_MYSTERY_EGG_TO_ELM
	iftrue MomPhoneNoGymQuestScript
	checkevent EVENT_GOT_A_POKEMON_FROM_ELM
	iftrue MomPhoneNoPokedexScript
	jump MomPhoneNoPokemonScript

.bcec5
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_8
	iftrue MomPhoneHangUpScript
	farwritetext MomPhoneGreetingText
	buttonsound
	mapnametotext $0
	checkcode VAR_ROOFPALETTE
	ifequal $1, MomPhonePalette1
	ifequal $2, MomPhonePalette2
	jump MomPhoneOther

MomPhoneLandmark:
	farwritetext MomPhoneLandmarkText
	buttonsound
	jump MomSavingMoney

MomPhonePalette1:
	checkcode VAR_MAPGROUP
	ifequal GROUP_NEW_BARK_TOWN, .newbark
	ifequal GROUP_CHERRYGROVE_CITY, .cherrygrove
	ifequal GROUP_VIOLET_CITY, .violet
	ifequal GROUP_AZALEA_TOWN, .azalea
	ifequal GROUP_GOLDENROD_CITY, .goldenrod
	farwritetext MomPhoneGenericAreaText
	buttonsound
	jump MomSavingMoney

.newbark
	farwritetext MomPhoneNewBarkText
	buttonsound
	jump MomSavingMoney

.cherrygrove
	farwritetext MomPhoneCherrygroveText
	buttonsound
	jump MomSavingMoney

.violet
	landmarktotext SPROUT_TOWER, 1
	jump MomPhoneLandmark
.azalea
	landmarktotext SLOWPOKE_WELL, 1
	jump MomPhoneLandmark
.goldenrod
	landmarktotext RADIO_TOWER, 1
	jump MomPhoneLandmark

MomPhonePalette2:
	farwritetext MomOtherAreaText
	buttonsound
	jump MomSavingMoney

MomPhoneOther:
	farwritetext MomDeterminedText
	buttonsound
	jump MomSavingMoney

MomSavingMoney:
	checkflag ENGINE_MOM_SAVING_MONEY
	iffalse UnknownScript_0xbcf49
	checkmoney $1, 0
	ifequal $0, UnknownScript_0xbcf55
	jump UnknownScript_0xbcf63

UnknownScript_0xbcf49:
	checkmoney $1, 0
	ifequal $0, UnknownScript_0xbcf79
	jump UnknownScript_0xbcf6e

UnknownScript_0xbcf55:
	readmoney $1, $0
	farwritetext MomCheckBalanceText
	yesorno
	iftrue MomPhoneSaveMoneyScript
	jump MomPhoneWontSaveMoneyScript

UnknownScript_0xbcf63:
	farwritetext MomImportantToSaveText
	yesorno
	iftrue MomPhoneSaveMoneyScript
	jump MomPhoneWontSaveMoneyScript

UnknownScript_0xbcf6e:
	farwritetext MomYoureNotSavingText
	yesorno
	iftrue MomPhoneSaveMoneyScript
	jump MomPhoneWontSaveMoneyScript

UnknownScript_0xbcf79:
	readmoney $1, $0
	farwritetext MomYouveSavedText
	yesorno
	iftrue MomPhoneSaveMoneyScript
	jump MomPhoneWontSaveMoneyScript

MomPhoneSaveMoneyScript:
	setflag ENGINE_MOM_SAVING_MONEY
	farwritetext MomOKIllSaveText
	buttonsound
	jump MomPhoneHangUpScript

MomPhoneWontSaveMoneyScript:
	clearflag ENGINE_MOM_SAVING_MONEY
	farwritetext MomPhoneWontSaveMoneyText
	buttonsound
	jump MomPhoneHangUpScript

MomPhoneHangUpScript:
	farwritetext MomPhoneHangUpText
	end

MomPhoneNoPokemonScript:
	farwritetext MomPhoneNoPokemonText
	end

MomPhoneNoPokedexScript:
	farwritetext MomPhoneNoPokedexText
	end

MomPhoneNoGymQuestScript:
	farwritetext MomPhoneNoGymQuestText
	end

MomPhoneLectureScript:
	setevent EVENT_TALKED_TO_MOM_AFTER_MYSTERY_EGG_QUEST
	setflag ENGINE_DST
	specialphonecall SPECIALCALL_NONE
	farwritetext MomPhoneLectureText
	yesorno
	iftrue MomPhoneSaveMoneyScript
	jump MomPhoneWontSaveMoneyScript

; Bill

BillPhoneScript1:
	checktime 1 << DAY
	iftrue .daygreet
	checktime 1 << MORN
	iffalse .nitegreet
	farwritetext BillPhoneMornGreetingText
	buttonsound
	jump .main

.daygreet
	farwritetext BillPhoneDayGreetingText
	buttonsound
	jump .main

.nitegreet
	farwritetext BillPhoneNiteGreetingText
	buttonsound
	jump .main

.main
	farwritetext BillPhoneGenericText
	buttonsound
	checkcode VAR_BOXSPACE
	RAM2MEM $0
	ifequal $0, .full
	ifless $6, .nearlyfull
	farwritetext BillPhoneNotFullText
	end

.nearlyfull
	farwritetext BillPhoneNearlyFullText
	end

.full
	farwritetext BillPhoneFullText
	jump BillPhoneScriptCheckForBoxes

BillPhoneScript2:
	checkcode VAR_SPECIALPHONECALL
	ifequal SPECIALCALL_SECONDBADGE, BillPhoneScriptSecondBadge
	farwritetext BillPhoneNewlyFullText
BillPhoneScriptCheckForBoxes:
	special BillBoxSwitchCheck
	ifequal 0, BillPhoneWholePCFull
	farwritetext BillWantNextBox
	special BillBoxSwitch
	iftrue .hang_up
	farwritetext BillCallMeToSwitch
.hang_up
	farwritetext BillThankYouText
	end

BillPhoneScriptSecondBadge:
	farwritetext BillPhoneSecondBadgeText
	specialphonecall SPECIALCALL_NONE
	end

BillPhoneWholePCFull:
	farwritetext BillWholePCFullText
	waitbutton
	end

; Elm

ElmPhoneScript1:
	checkcode VAR_SPECIALPHONECALL
	ifequal SPECIALCALL_POKERUS, .pokerus
	checkevent EVENT_SHOWED_TOGEPI_TO_ELM
	iftrue .discovery
	checkevent EVENT_GOT_TOGEPI_EGG_FROM_ELMS_AIDE
	iffalse .next
	checkevent EVENT_TOGEPI_HATCHED
	iftrue .egghatched
.next
	checkevent EVENT_GOT_TOGEPI_EGG_FROM_ELMS_AIDE
	iftrue .eggunhatched
	checkevent EVENT_ELMS_AIDE_IN_LAB
	iftrue .assistant
	checkevent EVENT_GAVE_MYSTERY_EGG_TO_ELM
	iftrue .checkingegg
	checkevent EVENT_ELM_CALLED_ABOUT_STOLEN_POKEMON
	iftrue .stolen
	checkevent EVENT_GOT_MYSTERY_EGG_FROM_MR_POKEMON
	iftrue .sawmrpokemon
	farwritetext ElmPhoneStartText
	end

.sawmrpokemon
	farwritetext ElmPhoneSawMrPokemonText
	end

.stolen
	farwritetext ElmPhonePokemonStolenText
	end

.checkingegg
	farwritetext ElmPhoneCheckingEggText
	end

.assistant
	farwritetext ElmPhoneAssistantText
	end

.eggunhatched
	farwritetext ElmPhoneEggUnhatchedText
	end

.egghatched
	farwritetext ElmPhoneEggHatchedText
	setevent EVENT_TOLD_ELM_ABOUT_TOGEPI_OVER_THE_PHONE
	end

.discovery
	random $2
	ifequal $0, .nextdiscovery
	farwritetext ElmPhoneDiscovery1Text
	end

.nextdiscovery
	farwritetext ElmPhoneDiscovery2Text
	end

.pokerus
	farwritetext ElmPhonePokerusText
	specialphonecall SPECIALCALL_NONE
	end

ElmPhoneScript2:
	checkcode VAR_SPECIALPHONECALL
	ifequal SPECIALCALL_ROBBED, .disaster
	ifequal SPECIALCALL_ASSISTANT, .assistant
	ifequal SPECIALCALL_WEIRDBROADCAST, .rocket
	ifequal SPECIALCALL_SSTICKET, .gift
	ifequal SPECIALCALL_MASTERBALL, .gift
	farwritetext ElmPhonePokerusText
	specialphonecall SPECIALCALL_NONE
	end

.disaster
	farwritetext ElmPhoneDisasterText
	specialphonecall SPECIALCALL_NONE
	setevent EVENT_ELM_CALLED_ABOUT_STOLEN_POKEMON
	end

.assistant
	farwritetext ElmPhoneEggAssistantText
	specialphonecall SPECIALCALL_NONE
	clearevent EVENT_ELMS_AIDE_IN_VIOLET_POKEMON_CENTER
	setevent EVENT_ELMS_AIDE_IN_LAB
	end

.rocket
	farwritetext ElmPhoneRocketText
	specialphonecall SPECIALCALL_NONE
	end

.gift
	farwritetext ElmPhoneGiftText
	specialphonecall SPECIALCALL_NONE
	end

; Lyra

LyraPhoneScript:
	checktime 1 << DAY
	iftrue .daygreet
	checktime 1 << EVE
	iftrue .nitegreet
	checktime 1 << NITE
	iftrue .nitegreet
	farwritetext LyraPhoneMornGreetingText
	buttonsound
	jump .main

.daygreet
	farwritetext LyraPhoneDayGreetingText
	buttonsound
	jump .main

.evegreet
	farwritetext LyraPhoneEveGreetingText
	buttonsound
	jump .main

.nitegreet
	farwritetext LyraPhoneNiteGreetingText
	buttonsound
	jump .main

.main
	farwritetext LyraPhoneMainText
	end

LyraPhoneScript2:
	checkcode VAR_SPECIALPHONECALL
	ifequal SPECIALCALL_YELLOWFOREST, .yellowforest
	ifequal SPECIALCALL_FIRSTBADGE, .firstbadge
	ifequal SPECIALCALL_LYRASEGG, .lyrasegg
	specialphonecall SPECIALCALL_NONE
	jump LyraPhoneScript

.yellowforest
	farwritetext LyraPhoneYellowForestText
	specialphonecall SPECIALCALL_NONE
	end

.firstbadge
	farwritetext LyraPhoneFirstBadgeText
	specialphonecall SPECIALCALL_NONE
	end

.lyrasegg
	farwritetext LyraPhoneLyrasEggIntroText
	buttonsound
	checkevent EVENT_GOT_TOTODILE_FROM_ELM
	iftrue .lyrasegg_totodile
	checkevent EVENT_GOT_CHIKORITA_FROM_ELM
	iftrue .lyrasegg_chikorita
	farwritetext LyraPhoneLyrasEggChikoritaText
	jump .lyrasegg_end

.lyrasegg_totodile
	farwritetext LyraPhoneLyrasEggCyndaquilText
	jump .lyrasegg_end

.lyrasegg_chikorita:
	farwritetext LyraPhoneLyrasEggTotodileText
.lyrasegg_end
	buttonsound
	farwritetext LyraPhoneLyrasEggEndText
	setevent EVENT_LYRA_GAVE_AWAY_EGG
	specialphonecall SPECIALCALL_NONE
	end

; Jack

JackPhoneScript1:
	trainertotext SCHOOLBOY, JACK1, $0
	checkflag ENGINE_JACK
	iftrue UnknownScript_0xbd0f3
	farscall PhoneScript_AnswerPhone_Male
	checkflag ENGINE_JACK_MONDAY_MORNING
	iftrue UnknownScript_0xbd0ef
	checkcode VAR_WEEKDAY
	ifnotequal MONDAY, UnknownScript_0xbd0ef
	checktime 1 << MORN
	iftrue JackMondayMorning

UnknownScript_0xbd0ef:
	farjump JackPhoneTipsScript

UnknownScript_0xbd0f3:
	landmarktotext NATIONAL_PARK, $2
	farjump JackWantsBattleScript

JackPhoneScript2:
	trainertotext SCHOOLBOY, JACK1, $0
	farscall PhoneScript_GreetPhone_Male
	farscall PhoneScript_Random2
	ifequal $0, JackBattleTrivia
	checkflag ENGINE_JACK
	iftrue UnknownScript_0xbd11e
	checkflag ENGINE_JACK_MONDAY_MORNING
	iftrue UnknownScript_0xbd11e
	farscall PhoneScript_Random2
	ifequal $0, JackWantsToBattle

UnknownScript_0xbd11e:
	farscall PhoneScript_Random3
	ifequal $0, JackFindsRare
	farjump Phone_GenericCall_Male

JackMondayMorning:
	setflag ENGINE_JACK_MONDAY_MORNING

JackWantsToBattle:
	landmarktotext NATIONAL_PARK, $2
	setflag ENGINE_JACK
	farjump PhoneScript_WantsToBattle_Male

JackFindsRare:
	farjump Phone_CheckIfUnseenRare_Male

JackBattleTrivia:
	farjump JackTriviaScript

; Beverly

BeverlyPhoneScript1:
	trainertotext POKEFANF, BEVERLY1, $0
	farscall PhoneScript_AnswerPhone_Female
	checkflag ENGINE_BEVERLY_HAS_NUGGET
	iftrue UnknownScript_0xbd151
	farjump BeverlyHangUpScript

UnknownScript_0xbd151:
	landmarktotext NATIONAL_PARK, $2
	farjump BeverlyComePickUpScript

BeverlyPhoneScript2:
	trainertotext POKEFANF, BEVERLY1, $0
	farscall PhoneScript_GreetPhone_Female
	checkflag ENGINE_BEVERLY_HAS_NUGGET
	iftrue UnknownScript_0xbd16e
	farscall PhoneScript_Random4
	ifequal $0, UnknownScript_0xbd172

UnknownScript_0xbd16e:
	farjump Phone_GenericCall_Female

UnknownScript_0xbd172:
	setflag ENGINE_BEVERLY_HAS_NUGGET
	landmarktotext NATIONAL_PARK, $2
	farjump PhoneScript_FoundItem_Female

; Huey

HueyPhoneScript1:
	trainertotext SAILOR, HUEY1, $0
	checkflag ENGINE_HUEY
	iftrue UnknownScript_0xbd1a2
	farscall PhoneScript_AnswerPhone_Male
	checkflag ENGINE_HUEY_WEDNESDAY_NIGHT
	iftrue UnknownScript_0xbd19b
	checkcode VAR_WEEKDAY
	ifnotequal WEDNESDAY, UnknownScript_0xbd19b
	checktime (1 << EVE) | (1 << NITE)
	iftrue HueyWednesdayNight

UnknownScript_0xbd19b:
	special RandomPhoneMon
	farjump HueyHangUpScript

UnknownScript_0xbd1a2:
	landmarktotext LIGHTHOUSE, $2
	farjump HueyWantsBattleScript

HueyPhoneScript2:
	trainertotext SAILOR, HUEY1, $0
	farscall PhoneScript_GreetPhone_Male
	checkflag ENGINE_HUEY
	iftrue UnknownScript_0xbd1c9
	checkflag ENGINE_HUEY_WEDNESDAY_NIGHT
	iftrue UnknownScript_0xbd1c9
	farscall PhoneScript_Random3
	ifequal $0, HueyWantsBattle
	ifequal $1, HueyWantsBattle

UnknownScript_0xbd1c9:
	farjump PhoneScript_MonFlavorText

HueyWednesdayNight:
	setflag ENGINE_HUEY_WEDNESDAY_NIGHT

HueyWantsBattle:
	landmarktotext LIGHTHOUSE, $2
	setflag ENGINE_HUEY
	farjump PhoneScript_WantsToBattle_Male

; Gaven

GavenPhoneScript1:
	trainertotext COOLTRAINERM, GAVEN1, $0
	checkflag ENGINE_GAVEN
	iftrue UnknownScript_0xbd1fd
	farscall PhoneScript_AnswerPhone_Male
	checkflag ENGINE_GAVEN_THURSDAY_MORNING
	iftrue UnknownScript_0xbd1f9
	checkcode VAR_WEEKDAY
	ifnotequal THURSDAY, UnknownScript_0xbd1f9
	checktime 1 << MORN
	iftrue GavenThursdayMorningScript

UnknownScript_0xbd1f9:
	farjump GavenHangUpNotThursdayScript

UnknownScript_0xbd1fd:
	landmarktotext ROUTE_26, $2
	farjump GavenReminderScript

GavenPhoneScript2:
	trainertotext COOLTRAINERM, GAVEN1, $0
	farscall PhoneScript_GreetPhone_Male
	checkflag ENGINE_GAVEN
	iftrue UnknownScript_0xbd220
	checkflag ENGINE_GAVEN_THURSDAY_MORNING
	iftrue UnknownScript_0xbd220
	farscall PhoneScript_Random2
	ifequal $0, GavenWantsRematch

UnknownScript_0xbd220:
	farscall PhoneScript_Random3
	ifequal $0, GavenFoundRare
	farjump Phone_GenericCall_Male

GavenThursdayMorningScript:
	setflag ENGINE_GAVEN_THURSDAY_MORNING

GavenWantsRematch:
	landmarktotext ROUTE_26, $2
	setflag ENGINE_GAVEN
	farjump PhoneScript_WantsToBattle_Male

GavenFoundRare:
	farjump Phone_CheckIfUnseenRare_Male

; Beth

BethPhoneScript1:
	trainertotext COOLTRAINERF, BETH1, $0
	checkflag ENGINE_BETH
	iftrue UnknownScript_0xbd260
	farscall PhoneScript_AnswerPhone_Female
	checkflag ENGINE_BETH_FRIDAY_AFTERNOON
	iftrue UnknownScript_0xbd25c
	checkcode VAR_WEEKDAY
	ifnotequal FRIDAY, UnknownScript_0xbd25c
	checktime 1 << DAY
	iftrue BethFridayAfternoon

UnknownScript_0xbd25c:
	farjump BethHangUpScript

UnknownScript_0xbd260:
	landmarktotext ROUTE_26, $2
	farjump BethBattleReminderScript

BethPhoneScript2:
	trainertotext COOLTRAINERF, BETH1, $0
	farscall PhoneScript_GreetPhone_Female
	checkflag ENGINE_BETH
	iftrue UnknownScript_0xbd283
	checkflag ENGINE_BETH_FRIDAY_AFTERNOON
	iftrue UnknownScript_0xbd283
	farscall PhoneScript_Random2
	ifequal $0, BethWantsBattle

UnknownScript_0xbd283:
	farjump Phone_GenericCall_Female

BethFridayAfternoon:
	setflag ENGINE_BETH_FRIDAY_AFTERNOON

BethWantsBattle:
	landmarktotext ROUTE_26, $2
	setflag ENGINE_BETH
	farjump PhoneScript_WantsToBattle_Female

; Jose

JosePhoneScript1:
	trainertotext BIRD_KEEPER, JOSE2, $0
	checkflag ENGINE_JOSE
	iftrue UnknownScript_0xbd2bd
	farscall PhoneScript_AnswerPhone_Male
	checkflag ENGINE_JOSE_SATURDAY_NIGHT
	iftrue UnknownScript_0xbd2b9
	checkflag ENGINE_JOSE_HAS_STAR_PIECE
	iftrue UnknownScript_0xbd2c4
	checkcode VAR_WEEKDAY
	ifnotequal SATURDAY, UnknownScript_0xbd2b9
	checktime (1 << EVE) | (1 << NITE)
	iftrue JoseSaturdayNight

UnknownScript_0xbd2b9:
	farjump JoseHangUpScript

UnknownScript_0xbd2bd:
	landmarktotext ROUTE_27, $2
	farjump JoseReminderScript

UnknownScript_0xbd2c4:
	landmarktotext ROUTE_27, $2
	farjump JoseReminderScript

JosePhoneScript2:
	trainertotext BIRD_KEEPER, JOSE2, $0
	farscall PhoneScript_GreetPhone_Male
	checkflag ENGINE_JOSE
	iftrue UnknownScript_0xbd2f5
	checkflag ENGINE_JOSE_SATURDAY_NIGHT
	iftrue UnknownScript_0xbd2f5
	checkflag ENGINE_JOSE_HAS_STAR_PIECE
	iftrue UnknownScript_0xbd2f5
	farscall PhoneScript_Random3
	ifequal $0, JoseWantsBattle
	farscall PhoneScript_Random3
	ifequal $0, JoseHasStarPiece

UnknownScript_0xbd2f5:
	farscall PhoneScript_Random3
	ifequal $0, JoseFoundRare
	farjump Phone_GenericCall_Male

JoseSaturdayNight:
	setflag ENGINE_JOSE_SATURDAY_NIGHT

JoseWantsBattle:
	landmarktotext ROUTE_27, $2
	setflag ENGINE_JOSE
	farjump PhoneScript_WantsToBattle_Male

JoseFoundRare:
	farjump Phone_CheckIfUnseenRare_Male

JoseHasStarPiece:
	setflag ENGINE_JOSE_HAS_STAR_PIECE
	landmarktotext ROUTE_27, $2
	farjump PhoneScript_FoundItem_Male

; Reena

ReenaPhoneScript1:
	trainertotext COOLTRAINERF, REENA1, $0
	checkflag ENGINE_REENA
	iftrue UnknownScript_0xbd33f
	farscall PhoneScript_AnswerPhone_Female
	checkflag ENGINE_REENA_SUNDAY_MORNING
	iftrue UnknownScript_0xbd33b
	checkcode VAR_WEEKDAY
	ifnotequal SUNDAY, UnknownScript_0xbd33b
	checktime 1 << MORN
	iftrue ReenaSundayMorning

UnknownScript_0xbd33b:
	farjump ReenaForwardScript

UnknownScript_0xbd33f:
	landmarktotext ROUTE_27, $2
	farjump ReenaHurryScript

ReenaPhoneScript2:
	trainertotext COOLTRAINERF, REENA1, $0
	farscall PhoneScript_GreetPhone_Female
	checkflag ENGINE_REENA
	iftrue UnknownScript_0xbd362
	checkflag ENGINE_REENA_SUNDAY_MORNING
	iftrue UnknownScript_0xbd362
	farscall PhoneScript_Random2
	ifequal $0, ReenaWantsBattle

UnknownScript_0xbd362:
	farjump Phone_GenericCall_Female

ReenaSundayMorning:
	setflag ENGINE_REENA_SUNDAY_MORNING

ReenaWantsBattle:
	landmarktotext ROUTE_27, $2
	setflag ENGINE_REENA
	farjump PhoneScript_WantsToBattle_Female

; Joey

JoeyPhoneScript1:
	trainertotext YOUNGSTER, JOEY1, $0
	checkflag ENGINE_JOEY
	iftrue UnknownScript_0xbd399
	farscall PhoneScript_AnswerPhone_Male
	checkflag ENGINE_JOEY_MONDAY_AFTERNOON
	iftrue UnknownScript_0xbd392
	checkcode VAR_WEEKDAY
	ifnotequal MONDAY, UnknownScript_0xbd392
	checktime 1 << DAY
	iftrue JoeyMondayAfternoon

UnknownScript_0xbd392:
	special RandomPhoneMon
	farwritetext JoeyDevisingStrategiesText
	buttonsound
	farjump PhoneScript_HangupText_Male

UnknownScript_0xbd399:
	landmarktotext ROUTE_30, $2
	farjump JoeyReminderScript

JoeyPhoneScript2:
	trainertotext YOUNGSTER, JOEY1, $0
	farscall PhoneScript_GreetPhone_Male
	checkflag ENGINE_JOEY
	iftrue UnknownScript_0xbd3c0
	checkflag ENGINE_JOEY_MONDAY_AFTERNOON
	iftrue UnknownScript_0xbd3c0
	farscall PhoneScript_Random3
	ifequal $0, JoeyWantsBattle
	ifequal $1, JoeyWantsBattle

UnknownScript_0xbd3c0:
	farjump Phone_GenericCall_Male

JoeyMondayAfternoon:
	setflag ENGINE_JOEY_MONDAY_AFTERNOON

JoeyWantsBattle:
	landmarktotext ROUTE_30, $2
	setflag ENGINE_JOEY
	farjump PhoneScript_WantsToBattle_Male

; Wade

WadePhoneScript1:
	trainertotext BUG_CATCHER, WADE1, $0
	checkflag ENGINE_WADE
	iftrue UnknownScript_0xbd41a
	farscall PhoneScript_AnswerPhone_Male
	checkflag ENGINE_WADE_TUESDAY_NIGHT
	iftrue UnknownScript_0xbd3f6
	checkflag ENGINE_WADE_HAS_ITEM
	iftrue UnknownScript_0xbd421
	checkcode VAR_WEEKDAY
	ifnotequal TUESDAY, UnknownScript_0xbd3f6
	checktime (1 << EVE) | (1 << NITE)
	iftrue WadeTuesdayNight

UnknownScript_0xbd3f6:
	farscall PhoneScript_Random2
	ifequal $0, UnknownScript_0xbd412
	checkflag ENGINE_DAILY_BUG_CONTEST
	iftrue UnknownScript_0xbd412
	checkcode VAR_WEEKDAY
	ifequal TUESDAY, UnknownScript_0xbd416
	ifequal THURSDAY, UnknownScript_0xbd416
	ifequal SATURDAY, UnknownScript_0xbd416

UnknownScript_0xbd412:
	farjump WadeNoBerriesScript

UnknownScript_0xbd416:
	farjump PhoneScript_BugCatchingContest

UnknownScript_0xbd41a:
	landmarktotext ROUTE_31, $2
	farjump WadeQuickBattleScript

UnknownScript_0xbd421:
	landmarktotext ROUTE_31, $2
	farjump WadeComeQuickScript

WadePhoneScript2:
	trainertotext BUG_CATCHER, WADE1, $0
	farscall PhoneScript_GreetPhone_Male
	farscall PhoneScript_Random2
	ifequal $0, UnknownScript_0xbd44c
	checkflag ENGINE_DAILY_BUG_CONTEST
	iftrue UnknownScript_0xbd44c
	checkcode VAR_WEEKDAY
	ifequal TUESDAY, UnknownScript_0xbd480
	ifequal THURSDAY, UnknownScript_0xbd480
	ifequal SATURDAY, UnknownScript_0xbd480

UnknownScript_0xbd44c:
	checkflag ENGINE_WADE
	iftrue UnknownScript_0xbd474
	checkflag ENGINE_WADE_TUESDAY_NIGHT
	iftrue UnknownScript_0xbd474
	checkflag ENGINE_WADE_HAS_ITEM
	iftrue UnknownScript_0xbd474
	farscall PhoneScript_Random2
	ifequal $0, WadeHasItem2
	checkflag ENGINE_FLYPOINT_GOLDENROD
	iffalse UnknownScript_0xbd474
	farscall PhoneScript_Random2
	ifequal $0, WadeWantsBattle2

UnknownScript_0xbd474:
	farscall PhoneScript_Random3
	ifequal $0, WadeFoundRare
	farjump Phone_GenericCall_Male

UnknownScript_0xbd480:
	farjump PhoneScript_BugCatchingContest

WadeTuesdayNight:
	setflag ENGINE_WADE_TUESDAY_NIGHT

WadeWantsBattle2:
	landmarktotext ROUTE_31, $2
	setflag ENGINE_WADE
	farjump PhoneScript_WantsToBattle_Male

WadeFoundRare:
	farjump Phone_CheckIfUnseenRare_Male

WadeHasItem2:
	setflag ENGINE_WADE_HAS_ITEM
	landmarktotext ROUTE_31, $2
	clearevent EVENT_WADE_HAS_ORAN_BERRY
	clearevent EVENT_WADE_HAS_PECHA_BERRY
	clearevent EVENT_WADE_HAS_CHERI_BERRY
	clearevent EVENT_WADE_HAS_PERSIM_BERRY
	random $4
	ifequal $0, UnknownScript_0xbd4b9
	ifequal $1, UnknownScript_0xbd4bf
	ifequal $2, UnknownScript_0xbd4c5
	ifequal $3, UnknownScript_0xbd4cb

UnknownScript_0xbd4b9:
	setevent EVENT_WADE_HAS_ORAN_BERRY
	jump UnknownScript_0xbd4ce

UnknownScript_0xbd4bf:
	setevent EVENT_WADE_HAS_PECHA_BERRY
	jump UnknownScript_0xbd4ce

UnknownScript_0xbd4c5:
	setevent EVENT_WADE_HAS_CHERI_BERRY
	jump UnknownScript_0xbd4ce

UnknownScript_0xbd4cb:
	setevent EVENT_WADE_HAS_PERSIM_BERRY

UnknownScript_0xbd4ce:
	farjump PhoneScript_FoundItem_Male

; Ralph

RalphPhoneScript1:
	trainertotext FISHER, RALPH1, $0
	checkflag ENGINE_RALPH
	iftrue Ralph_Rematch
	farscall PhoneScript_AnswerPhone_Male
	checkflag ENGINE_RALPH_WEDNESDAY_MORNING
	iftrue Ralph_CheckSwarm
	checkcode VAR_WEEKDAY
	ifnotequal WEDNESDAY, Ralph_CheckSwarm
	checktime 1 << MORN
	iftrue Ralph_WednesdayMorning
Ralph_CheckSwarm:
	checkflag ENGINE_SPECIAL_WILDDATA
	iftrue Ralph_ReportSwarm
	farjump RalphNoItemScript

Ralph_Rematch:
	landmarktotext ROUTE_32, $2
	farjump RalphReminderScript

Ralph_ReportSwarm:
	landmarktotext ROUTE_32, $2
	farjump RalphHurryScript

RalphPhoneScript2:
	trainertotext FISHER, RALPH1, $0
	farscall PhoneScript_GreetPhone_Male
	checkflag ENGINE_FLYPOINT_GOLDENROD
	iffalse Ralph_CheckSwarm2
	checkflag ENGINE_RALPH
	iftrue Ralph_CheckSwarm2
	checkflag ENGINE_RALPH_WEDNESDAY_MORNING
	iftrue Ralph_CheckSwarm2
	farscall PhoneScript_Random2
	ifequal $0, Ralph_FightMe
Ralph_CheckSwarm2:
	farscall PhoneScript_Random5
	ifequal $0, Ralph_SetUpSwarm
	farjump Phone_GenericCall_Male

Ralph_WednesdayMorning:
	setflag ENGINE_RALPH_WEDNESDAY_MORNING
Ralph_FightMe:
	landmarktotext ROUTE_32, $2
	setflag ENGINE_RALPH
	farjump PhoneScript_WantsToBattle_Male

Ralph_SetUpSwarm:
	checkflag ENGINE_SPECIAL_WILDDATA
	iftrue UnknownScript_0xbd55c
	setflag ENGINE_SPECIAL_WILDDATA
	pokenamemem QWILFISH, $1
	landmarktotext ROUTE_32, $2
	writebyte FISHSWARM_QWILFISH
	special Special_ActivateFishingSwarm
	farjump RalphItemScript

UnknownScript_0xbd55c:
	farjump Phone_GenericCall_Male

; Liz

LizPhoneScript1:
	trainertotext PICNICKER, LIZ1, $0
	checkflag ENGINE_LIZ
	iftrue UnknownScript_0xbd586
	farscall PhoneScript_AnswerPhone_Female
	checkflag ENGINE_LIZ_THURSDAY_AFTERNOON
	iftrue UnknownScript_0xbd57f
	checkcode VAR_WEEKDAY
	ifnotequal THURSDAY, UnknownScript_0xbd57f
	checktime 1 << DAY
	iftrue LizThursdayAfternoon

UnknownScript_0xbd57f:
	special RandomPhoneMon
	farjump LizHangUpScript

UnknownScript_0xbd586:
	landmarktotext ROUTE_32, $2
	farjump LizReminderScript

LizPhoneScript2:
	trainertotext PICNICKER, LIZ1, $0
	farscall PhoneScript_Random4
	ifequal $0, LizWrongNumber
	farscall PhoneScript_GreetPhone_Female
	checkflag ENGINE_LIZ
	iftrue UnknownScript_0xbd5a9
	checkflag ENGINE_LIZ_THURSDAY_AFTERNOON
	iftrue UnknownScript_0xbd5a9

UnknownScript_0xbd5a9:
	farscall PhoneScript_Random2
	ifequal $0, LizGossip
	checkflag ENGINE_FLYPOINT_GOLDENROD
	iffalse UnknownScript_0xbd5bf
	farscall PhoneScript_Random2
	ifequal $0, LizWantsBattle

UnknownScript_0xbd5bf:
	farjump Phone_GenericCall_Female

LizThursdayAfternoon:
	setflag ENGINE_LIZ_THURSDAY_AFTERNOON

LizWantsBattle:
	landmarktotext ROUTE_32, $2
	setflag ENGINE_LIZ
	farjump PhoneScript_WantsToBattle_Female

LizWrongNumber:
	farjump LizWrongNumberScript

LizGossip:
	random $9
	ifequal $0, UnknownScript_0xbd5fa
	ifequal $1, UnknownScript_0xbd600
	ifequal $2, UnknownScript_0xbd606
	ifequal $3, UnknownScript_0xbd60c
	ifequal $4, UnknownScript_0xbd612
	ifequal $5, UnknownScript_0xbd618
	ifequal $6, UnknownScript_0xbd61e
	ifequal $7, UnknownScript_0xbd624
	ifequal $8, UnknownScript_0xbd62a

UnknownScript_0xbd5fa:
	trainerclassname COOLTRAINERM, $1
	jump LizGossipScript

UnknownScript_0xbd600:
	trainerclassname BEAUTY, $1
	jump LizGossipScript

UnknownScript_0xbd606:
	trainerclassname GRUNTM, $1
	jump LizGossipScript

UnknownScript_0xbd60c:
	trainerclassname TEACHER, $1
	jump LizGossipScript

UnknownScript_0xbd612:
	trainerclassname SWIMMERF, $1
	jump LizGossipScript

UnknownScript_0xbd618:
	trainerclassname KIMONO_GIRL_1, $1
	jump LizGossipScript

UnknownScript_0xbd61e:
	trainerclassname SKIER, $1
	jump LizGossipScript

UnknownScript_0xbd624:
	trainerclassname MEDIUM, $1
	jump LizGossipScript

UnknownScript_0xbd62a:
	trainerclassname POKEFANM, $1
	jump LizGossipScript

LizGossipScript:
	farjump LizGossipRandomScript

; Anthony

AnthonyPhoneScript1:
	trainertotext HIKER, ANTHONY1, $0
	checkflag ENGINE_ANTHONY
	iftrue UnknownScript_0xbd65d
	farscall PhoneScript_AnswerPhone_Male
	checkflag ENGINE_ANTHONY_FRIDAY_NIGHT
	iftrue UnknownScript_0xbd653
	checkcode VAR_WEEKDAY
	ifnotequal FRIDAY, UnknownScript_0xbd653
	checktime (1 << EVE) | (1 << NITE)
	iftrue AnthonyFridayNight

UnknownScript_0xbd653:
	checkflag ENGINE_DUNSPARCE_SWARM
	iftrue UnknownScript_0xbd664
	farjump AnthonyHangUpScript

UnknownScript_0xbd65d:
	landmarktotext ROUTE_33, $2
	farjump AnthonyReminderScript

UnknownScript_0xbd664:
	landmarktotext ROUTE_33, $2
	farjump AnthonyHurryScript

AnthonyPhoneScript2:
	trainertotext HIKER, ANTHONY1, $0
	farscall PhoneScript_GreetPhone_Male
	checkflag ENGINE_FLYPOINT_GOLDENROD
	iffalse UnknownScript_0xbd68d
	checkflag ENGINE_ANTHONY
	iftrue UnknownScript_0xbd68d
	checkflag ENGINE_ANTHONY_FRIDAY_NIGHT
	iftrue UnknownScript_0xbd68d
	farscall PhoneScript_Random2
	ifequal $0, AnthonyWantsBattle

UnknownScript_0xbd68d:
	farscall PhoneScript_Random5
	ifequal $0, AnthonyTriesDunsparceSwarm
	farjump Phone_GenericCall_Male

AnthonyFridayNight:
	setflag ENGINE_ANTHONY_FRIDAY_NIGHT

AnthonyWantsBattle:
	landmarktotext ROUTE_33, $2
	setflag ENGINE_ANTHONY
	farjump PhoneScript_WantsToBattle_Male

AnthonyTriesDunsparceSwarm:
	checkflag ENGINE_DUNSPARCE_SWARM
	iftrue UnknownScript_0xbd6bd
	setflag ENGINE_DUNSPARCE_SWARM
	pokenamemem DUNSPARCE, $1
	swarm SWARM_DUNSPARCE, DARK_CAVE_VIOLET_ENTRANCE
	landmarktotext DARK_CAVE, $2
	farjump AnthonySwarmScript

UnknownScript_0xbd6bd:
	farjump Phone_GenericCall_Male

; Todd

ToddPhoneScript1:
	trainertotext CAMPER, TODD1, $0
	checkflag ENGINE_TODD
	iftrue UnknownScript_0xbd6ea
	farscall PhoneScript_AnswerPhone_Male
	checkflag ENGINE_TODD_SATURDAY_MORNING
	iftrue UnknownScript_0xbd6e0
	checkcode VAR_WEEKDAY
	ifnotequal SATURDAY, UnknownScript_0xbd6e0
	checktime 1 << MORN
	iftrue ToddSaturdayMorning

UnknownScript_0xbd6e0:
	checkflag ENGINE_GOLDENROD_DEPT_STORE_SALE_IS_ON
	iftrue UnknownScript_0xbd6f1
	farjump ToddNoItemScript

UnknownScript_0xbd6ea:
	landmarktotext ROUTE_34, $2
	farjump ToddForwardScript

UnknownScript_0xbd6f1:
	farjump ToddHurryScript

ToddPhoneScript2:
	trainertotext CAMPER, TODD1, $0
	farscall PhoneScript_GreetPhone_Male
	checkflag ENGINE_TODD
	iftrue UnknownScript_0xbd717
	checkflag ENGINE_TODD_SATURDAY_MORNING
	iftrue UnknownScript_0xbd717
	checkflag ENGINE_FLYPOINT_GOLDENROD
	iffalse UnknownScript_0xbd71f
	farscall PhoneScript_Random2
	ifequal $0, ToddWantsBattle

UnknownScript_0xbd717:
	farscall PhoneScript_Random2
	ifequal $0, ToddDeptStoreSale

UnknownScript_0xbd71f:
	farscall PhoneScript_Random3
	ifequal $0, ToddFoundRare
	farjump Phone_GenericCall_Male

ToddSaturdayMorning:
	setflag ENGINE_TODD_SATURDAY_MORNING

ToddWantsBattle:
	landmarktotext ROUTE_34, $2
	setflag ENGINE_TODD
	farjump PhoneScript_WantsToBattle_Male

ToddFoundRare:
	farjump Phone_CheckIfUnseenRare_Male

ToddDeptStoreSale:
	setflag ENGINE_GOLDENROD_DEPT_STORE_SALE_IS_ON
	farjump ToddItemScript

; Gina

GinaPhoneScript1:
	trainertotext PICNICKER, GINA1, $0
	checkflag ENGINE_GINA
	iftrue UnknownScript_0xbd776
	farscall PhoneScript_AnswerPhone_Female
	checkflag ENGINE_GINA_SUNDAY_AFTERNOON
	iftrue UnknownScript_0xbd768
	checkflag ENGINE_GINA_HAS_LEAF_STONE
	iftrue UnknownScript_0xbd77d
	checkcode VAR_WEEKDAY
	ifnotequal SUNDAY, UnknownScript_0xbd768
	checktime 1 << DAY
	iftrue GinaSundayDay

UnknownScript_0xbd768:
	checkflag ENGINE_ROCKETS_IN_RADIO_TOWER
	iftrue UnknownScript_0xbd772
	farjump GinaHangUpScript

UnknownScript_0xbd772:
	farjump GinaRocketRumorScript

UnknownScript_0xbd776:
	landmarktotext ROUTE_34, $2
	farjump GinaReminderScript

UnknownScript_0xbd77d:
	landmarktotext ROUTE_34, $2
	farjump GinaComePickUpScript

GinaPhoneScript2:
	trainertotext PICNICKER, GINA1, $0
	farscall PhoneScript_GreetPhone_Female
	checkflag ENGINE_ROCKETS_IN_RADIO_TOWER
	iftrue GinaRockets
	checkflag ENGINE_GINA
	iftrue UnknownScript_0xbd7c8
	checkflag ENGINE_GINA_SUNDAY_AFTERNOON
	iftrue UnknownScript_0xbd7c8
	checkflag ENGINE_GINA_HAS_LEAF_STONE
	iftrue UnknownScript_0xbd7c8
	checkevent EVENT_GINA_GAVE_LEAF_STONE
	iftrue UnknownScript_0xbd7b2
	farscall PhoneScript_Random2
	ifequal $0, GinaHasLeafStone

UnknownScript_0xbd7b2:
	farscall PhoneScript_Random11
	ifequal $0, GinaHasLeafStone
	checkflag ENGINE_FLYPOINT_GOLDENROD
	iffalse UnknownScript_0xbd7c8
	farscall PhoneScript_Random3
	ifequal $0, GinaWantsBattle

UnknownScript_0xbd7c8:
	farjump Phone_GenericCall_Female

GinaSundayDay:
	setflag ENGINE_GINA_SUNDAY_AFTERNOON

GinaWantsBattle:
	landmarktotext ROUTE_34, $2
	setflag ENGINE_GINA
	farjump PhoneScript_WantsToBattle_Female

GinaRockets:
	farjump GinaRocketRumorScript

GinaHasLeafStone:
	setflag ENGINE_GINA_HAS_LEAF_STONE
	landmarktotext ROUTE_34, $2
	farjump PhoneScript_FoundItem_Female

; Irwin

IrwinPhoneScript1:
	trainertotext JUGGLER, IRWIN1, $0
	farscall PhoneScript_AnswerPhone_Male
	checkflag ENGINE_ROCKETS_IN_RADIO_TOWER
	iftrue UnknownScript_0xbd7f9
	farjump IrwinRandomTextScript

UnknownScript_0xbd7f9:
	farjump IrwinRocketRumorScript

IrwinPhoneScript2:
	trainertotext JUGGLER, IRWIN1, $0
	farscall PhoneScript_GreetPhone_Male
	checkflag ENGINE_ROCKETS_IN_RADIO_TOWER
	iftrue UnknownScript_0xbd80f
	farjump IrwinRumorScript

UnknownScript_0xbd80f:
	farjump IrwinRocketRumorScript

; Arnie

ArniePhoneScript1:
	trainertotext BUG_CATCHER, ARNIE1, $0
	checkflag ENGINE_ARNIE
	iftrue UnknownScript_0xbd83c
	farscall PhoneScript_AnswerPhone_Male
	checkflag ENGINE_ARNIE_TUESDAY_MORNING
	iftrue UnknownScript_0xbd832
	checkcode VAR_WEEKDAY
	ifnotequal TUESDAY, UnknownScript_0xbd832
	checktime 1 << MORN
	iftrue ArnieTuesdayMorning

UnknownScript_0xbd832:
	checkflag ENGINE_YANMA_SWARM
	iftrue UnknownScript_0xbd843
	farjump ArnieHangUpScript

UnknownScript_0xbd83c:
	landmarktotext ROUTE_35, $2
	farjump ArnieReminderScript

UnknownScript_0xbd843:
	landmarktotext ROUTE_35, $2
	farjump ArnieHurryScript

ArniePhoneScript2:
	trainertotext BUG_CATCHER, ARNIE1, $0
	farscall PhoneScript_GreetPhone_Male
	checkflag ENGINE_ARNIE
	iftrue UnknownScript_0xbd866
	checkflag ENGINE_ARNIE_TUESDAY_MORNING
	iftrue UnknownScript_0xbd866
	farscall PhoneScript_Random2
	ifequal $0, ArnieWantsBattle

UnknownScript_0xbd866:
	farscall PhoneScript_Random5
	ifequal $0, ArnieYanmaSwarm
	farscall PhoneScript_Random3
	ifequal $0, ArnieFoundRare
	farjump Phone_GenericCall_Male

ArnieTuesdayMorning:
	setflag ENGINE_ARNIE_TUESDAY_MORNING

ArnieWantsBattle:
	landmarktotext ROUTE_35, $2
	setflag ENGINE_ARNIE
	farjump PhoneScript_WantsToBattle_Male

ArnieYanmaSwarm: ; start swarm
	checkflag ENGINE_YANMA_SWARM
	iftrue ArnieYanmaAlreadySwarming
	setflag ENGINE_YANMA_SWARM
	pokenamemem YANMA, $1
	swarm SWARM_YANMA, ROUTE_35
	landmarktotext ROUTE_35, $2
	farjump ArnieSwarmScript

ArnieFoundRare:
	farjump Phone_CheckIfUnseenRare_Male

ArnieYanmaAlreadySwarming:
	farjump Phone_GenericCall_Male

; Alan

AlanPhoneScript1:
	trainertotext SCHOOLBOY, ALAN1, $0
	checkflag ENGINE_ALAN
	iftrue UnknownScript_0xbd8cf
	farscall PhoneScript_AnswerPhone_Male
	checkflag ENGINE_ALAN_WEDNESDAY_AFTERNOON
	iftrue UnknownScript_0xbd8cb
	checkflag ENGINE_ALAN_HAS_FIRE_STONE
	iftrue UnknownScript_0xbd8d6
	checkcode VAR_WEEKDAY
	ifnotequal WEDNESDAY, UnknownScript_0xbd8cb
	checktime 1 << DAY
	iftrue AlanWednesdayDay

UnknownScript_0xbd8cb:
	farjump AlanHangUpScript

UnknownScript_0xbd8cf:
	landmarktotext ROUTE_36, $2
	farjump AlanReminderScript

UnknownScript_0xbd8d6:
	landmarktotext ROUTE_36, $2
	farjump AlanComePickUpScript

AlanPhoneScript2:
	trainertotext SCHOOLBOY, ALAN1, $0
	farscall PhoneScript_GreetPhone_Male
	checkflag ENGINE_ALAN
	iftrue UnknownScript_0xbd915
	checkflag ENGINE_ALAN_WEDNESDAY_AFTERNOON
	iftrue UnknownScript_0xbd915
	checkflag ENGINE_ALAN_HAS_FIRE_STONE
	iftrue UnknownScript_0xbd915
	farscall PhoneScript_Random3
	ifequal $0, AlanWantsBattle
	checkevent EVENT_ALAN_GAVE_FIRE_STONE
	iftrue UnknownScript_0xbd90d
	farscall PhoneScript_Random2
	ifequal $0, AlanHasFireStone

UnknownScript_0xbd90d:
	farscall PhoneScript_Random11
	ifequal $0, AlanHasFireStone

UnknownScript_0xbd915:
	farjump Phone_GenericCall_Male

AlanWednesdayDay:
	setflag ENGINE_ALAN_WEDNESDAY_AFTERNOON

AlanWantsBattle:
	landmarktotext ROUTE_36, $2
	setflag ENGINE_ALAN
	farjump PhoneScript_WantsToBattle_Male

AlanHasFireStone:
	setflag ENGINE_ALAN_HAS_FIRE_STONE
	landmarktotext ROUTE_36, $2
	farjump PhoneScript_FoundItem_Male

; Dana

DanaPhoneScript1:
	trainertotext LASS, DANA1, $0
	checkflag ENGINE_DANA
	iftrue UnknownScript_0xbd959
	farscall PhoneScript_AnswerPhone_Female
	checkflag ENGINE_DANA_THURSDAY_NIGHT
	iftrue UnknownScript_0xbd955
	checkflag ENGINE_DANA_HAS_THUNDERSTONE
	iftrue UnknownScript_0xbd960
	checkcode VAR_WEEKDAY
	ifnotequal THURSDAY, UnknownScript_0xbd955
	checktime (1 << EVE) | (1 << NITE)
	iftrue DanaThursdayNight

UnknownScript_0xbd955:
	farjump DanaHangUpScript

UnknownScript_0xbd959:
	landmarktotext ROUTE_38, $2
	farjump DanaReminderScript

UnknownScript_0xbd960:
	landmarktotext ROUTE_38, $2
	farjump DanaComePickUpScript

DanaPhoneScript2:
	trainertotext LASS, DANA1, $0
	farscall PhoneScript_GreetPhone_Female
	checkflag ENGINE_DANA
	iftrue UnknownScript_0xbd99f
	checkflag ENGINE_DANA_THURSDAY_NIGHT
	iftrue UnknownScript_0xbd99f
	checkflag ENGINE_DANA_HAS_THUNDERSTONE
	iftrue UnknownScript_0xbd99f
	farscall PhoneScript_Random3
	ifequal $0, DanaWantsBattle
	checkevent EVENT_DANA_GAVE_THUNDERSTONE
	iftrue UnknownScript_0xbd997
	farscall PhoneScript_Random2
	ifequal $0, DanaHasThunderstone

UnknownScript_0xbd997:
	farscall PhoneScript_Random11
	ifequal $0, DanaHasThunderstone

UnknownScript_0xbd99f:
	farscall PhoneScript_Random3
	ifequal $0, DanaFoundRare
	farjump Phone_GenericCall_Female

DanaThursdayNight:
	setflag ENGINE_DANA_THURSDAY_NIGHT

DanaWantsBattle:
	landmarktotext ROUTE_38, $2
	setflag ENGINE_DANA
	farjump PhoneScript_WantsToBattle_Female

DanaFoundRare:
	farjump Phone_CheckIfUnseenRare_Female

DanaHasThunderstone:
	setflag ENGINE_DANA_HAS_THUNDERSTONE
	landmarktotext ROUTE_38, $2
	farjump PhoneScript_FoundItem_Female

; Chad

ChadPhoneScript1:
	trainertotext SCHOOLBOY, CHAD1, $0
	checkflag ENGINE_CHAD
	iftrue UnknownScript_0xbd9e9
	farscall PhoneScript_AnswerPhone_Male
	checkflag ENGINE_CHAD_FRIDAY_MORNING
	iftrue UnknownScript_0xbd9e5
	checkcode VAR_WEEKDAY
	ifnotequal FRIDAY, UnknownScript_0xbd9e5
	checktime 1 << MORN
	iftrue ChadFridayMorning

UnknownScript_0xbd9e5:
	farjump ChadHangUpScript

UnknownScript_0xbd9e9:
	landmarktotext ROUTE_38, $2
	farjump ChadReminderScript

ChadPhoneScript2:
	trainertotext SCHOOLBOY, CHAD1, $0
	farscall PhoneScript_GreetPhone_Male
	farscall PhoneScript_Random2
	ifequal $0, ChadOakGossip
	checkflag ENGINE_CHAD
	iftrue UnknownScript_0xbda14
	checkflag ENGINE_CHAD_FRIDAY_MORNING
	iftrue UnknownScript_0xbda14
	farscall PhoneScript_Random2
	ifequal $0, ChadWantsBattle

UnknownScript_0xbda14:
	farscall PhoneScript_Random3
	ifequal $0, ChadFoundRare
	farjump Phone_GenericCall_Male

ChadFridayMorning:
	setflag ENGINE_CHAD_FRIDAY_MORNING

ChadWantsBattle:
	landmarktotext ROUTE_38, $2
	setflag ENGINE_CHAD
	farjump PhoneScript_WantsToBattle_Male

ChadFoundRare:
	farjump Phone_CheckIfUnseenRare_Male

ChadOakGossip:
	farjump ChadOakGossipScript

DerekPhoneScript1:
	trainertotext POKEFANM, DEREK1, $0
	farscall PhoneScript_AnswerPhone_Male
	checkflag ENGINE_DEREK_HAS_NUGGET
	iftrue UnknownScript_0xbda67
	farscall PhoneScript_Random2
	ifequal $0, UnknownScript_0xbda5f
	checkflag ENGINE_DAILY_BUG_CONTEST
	iftrue UnknownScript_0xbda5f
	checkcode VAR_WEEKDAY
	ifequal TUESDAY, UnknownScript_0xbda63
	ifequal THURSDAY, UnknownScript_0xbda63
	ifequal SATURDAY, UnknownScript_0xbda63

UnknownScript_0xbda5f:
	farjump DerekHangUpScript

UnknownScript_0xbda63:
	farjump PhoneScript_BugCatchingContest

UnknownScript_0xbda67:
	landmarktotext ROUTE_39, $2
	farjump DerekComePickUpScript

DerekPhoneScript2:
	trainertotext POKEFANM, DEREK1, $0
	farscall PhoneScript_GreetPhone_Male
	farscall PhoneScript_Random2
	ifequal $0, UnknownScript_0xbda92
	checkflag ENGINE_DAILY_BUG_CONTEST
	iftrue UnknownScript_0xbda92
	checkcode VAR_WEEKDAY
	ifequal TUESDAY, UnknownScript_0xbda9e
	ifequal THURSDAY, UnknownScript_0xbda9e
	ifequal SATURDAY, UnknownScript_0xbda9e

UnknownScript_0xbda92:
	farscall PhoneScript_Random4
	ifequal $0, UnknownScript_0xbdaa2
	farjump Phone_GenericCall_Male

UnknownScript_0xbda9e:
	farjump PhoneScript_BugCatchingContest

UnknownScript_0xbdaa2:
	setflag ENGINE_DEREK_HAS_NUGGET
	landmarktotext ROUTE_39, $2
	farjump PhoneScript_FoundItem_Male

TullyPhoneScript1:
	trainertotext FISHER, TULLY1, $0
	checkflag ENGINE_TULLY
	iftrue UnknownScript_0xbdad5
	farscall PhoneScript_AnswerPhone_Male
	checkflag ENGINE_TULLY_SUNDAY_NIGHT
	iftrue UnknownScript_0xbdad1
	checkflag ENGINE_TULLY_HAS_WATER_STONE
	iftrue UnknownScript_0xbdadc
	checkcode VAR_WEEKDAY
	ifnotequal SUNDAY, UnknownScript_0xbdad1
	checktime (1 << EVE) | (1 << NITE)
	iftrue TullySundayNight

UnknownScript_0xbdad1:
	farjump TullyNoItemScript

UnknownScript_0xbdad5:
	landmarktotext ROUTE_42, $2
	farjump TullyForwardScript

UnknownScript_0xbdadc:
	landmarktotext ROUTE_42, $2
	farjump TullyHurryScript

TullyPhoneScript2:
	trainertotext FISHER, TULLY1, $0
	farscall PhoneScript_GreetPhone_Male
	checkflag ENGINE_TULLY
	iftrue UnknownScript_0xbdb1b
	checkflag ENGINE_TULLY_SUNDAY_NIGHT
	iftrue UnknownScript_0xbdb1b
	checkflag ENGINE_TULLY_HAS_WATER_STONE
	iftrue UnknownScript_0xbdb1b
	farscall PhoneScript_Random3
	ifequal $0, TullyWantsBattle
	checkevent EVENT_TULLY_GAVE_WATER_STONE
	iftrue UnknownScript_0xbdb13
	farscall PhoneScript_Random2
	ifequal $0, TullyFoundWaterStone

UnknownScript_0xbdb13:
	farscall PhoneScript_Random11
	ifequal $0, TullyFoundWaterStone

UnknownScript_0xbdb1b:
	farjump Phone_GenericCall_Male

TullySundayNight:
	setflag ENGINE_TULLY_SUNDAY_NIGHT

TullyWantsBattle:
	landmarktotext ROUTE_42, $2
	setflag ENGINE_TULLY
	farjump PhoneScript_WantsToBattle_Male

TullyFoundWaterStone:
	setflag ENGINE_TULLY_HAS_WATER_STONE
	landmarktotext ROUTE_42, $2
	farjump PhoneScript_FoundItem_Male

BrentPhoneScript1:
	trainertotext POKEMANIAC, BRENT1, $0
	checkflag ENGINE_BRENT
	iftrue UnknownScript_0xbdb59
	farscall PhoneScript_AnswerPhone_Male
	checkflag ENGINE_BRENT_MONDAY_MORNING
	iftrue UnknownScript_0xbdb55
	checkcode VAR_WEEKDAY
	ifnotequal MONDAY, UnknownScript_0xbdb55
	checktime 1 << MORN
	iftrue BrentMondayMorning

UnknownScript_0xbdb55:
	farjump BrentHangUpScript

UnknownScript_0xbdb59:
	landmarktotext ROUTE_43, $2
	farjump BrentReminderScript

BrentPhoneScript2:
	trainertotext POKEMANIAC, BRENT1, $0
	farscall PhoneScript_GreetPhone_Male
	farscall PhoneScript_Random2
	ifequal $0, BrentBillTrivia
	checkflag ENGINE_BRENT
	iftrue UnknownScript_0xbdb84
	checkflag ENGINE_BRENT_MONDAY_MORNING
	iftrue UnknownScript_0xbdb84
	farscall PhoneScript_Random2
	ifequal $0, BrentWantsBattle

UnknownScript_0xbdb84:
	farjump Phone_GenericCall_Male

BrentMondayMorning:
	setflag ENGINE_BRENT_MONDAY_MORNING

BrentWantsBattle:
	landmarktotext ROUTE_43, $2
	setflag ENGINE_BRENT
	farjump PhoneScript_WantsToBattle_Male

BrentBillTrivia:
	farjump BrentBillTriviaScript

TiffanyPhoneScript1:
	trainertotext PICNICKER, TIFFANY1, $0
	checkflag ENGINE_TIFFANY
	iftrue UnknownScript_0xbdbc2
	farscall PhoneScript_AnswerPhone_Female
	checkflag ENGINE_TIFFANY_TUESDAY_AFTERNOON
	iftrue UnknownScript_0xbdbbe
	checkflag ENGINE_TIFFANY_HAS_PINK_BOW
	iftrue UnknownScript_0xbdbc9
	checkcode VAR_WEEKDAY
	ifnotequal TUESDAY, UnknownScript_0xbdbbe
	checktime 1 << DAY
	iftrue TiffanyTuesdayAfternoon

UnknownScript_0xbdbbe:
	farjump TiffanyNoItemScript

UnknownScript_0xbdbc2:
	landmarktotext ROUTE_43, $2
	farjump TiffanyAsleepScript

UnknownScript_0xbdbc9:
	landmarktotext ROUTE_43, $2
	farjump TiffanyHurryScript

TiffanyPhoneScript2:
	trainertotext PICNICKER, TIFFANY1, $0
	farscall PhoneScript_Random4
	ifequal $0, TiffanysFamilyMembers
	farscall PhoneScript_GreetPhone_Female
	checkflag ENGINE_TIFFANY
	iftrue UnknownScript_0xbdc10
	checkflag ENGINE_TIFFANY_TUESDAY_AFTERNOON
	iftrue UnknownScript_0xbdc10
	checkflag ENGINE_TIFFANY_HAS_PINK_BOW
	iftrue UnknownScript_0xbdc10
	farscall PhoneScript_Random3
	ifequal $0, TiffanyWantsBattle
	checkevent EVENT_TIFFANY_GAVE_PINK_BOW
	iftrue UnknownScript_0xbdc08
	farscall PhoneScript_Random2
	ifequal $0, TiffanyHasPinkBow

UnknownScript_0xbdc08:
	farscall PhoneScript_Random11
	ifequal $0, TiffanyHasPinkBow

UnknownScript_0xbdc10:
	farjump Phone_GenericCall_Female

TiffanyTuesdayAfternoon:
	setflag ENGINE_TIFFANY_TUESDAY_AFTERNOON

TiffanyWantsBattle:
	landmarktotext ROUTE_43, $2
	setflag ENGINE_TIFFANY
	farjump PhoneScript_WantsToBattle_Female

TiffanysFamilyMembers:
	random $6
	ifequal $0, UnknownScript_0xbdc3b
	ifequal $1, UnknownScript_0xbdc42
	ifequal $2, UnknownScript_0xbdc49
	ifequal $3, UnknownScript_0xbdc50
	ifequal $4, UnknownScript_0xbdc57
	ifequal $5, UnknownScript_0xbdc5e

UnknownScript_0xbdc3b:
	stringtotext Phone_GrandmaString, $1
	jump UnknownScript_0xbdc65

UnknownScript_0xbdc42:
	stringtotext Phone_GrandpaString, $1
	jump UnknownScript_0xbdc65

UnknownScript_0xbdc49:
	stringtotext Phone_MomString, $1
	jump UnknownScript_0xbdc65

UnknownScript_0xbdc50:
	stringtotext Phone_DadString, $1
	jump UnknownScript_0xbdc65

UnknownScript_0xbdc57:
	stringtotext Phone_SisterString, $1
	jump UnknownScript_0xbdc65

UnknownScript_0xbdc5e:
	stringtotext Phone_BrotherString, $1
	jump UnknownScript_0xbdc65

UnknownScript_0xbdc65:
	farjump TiffanyItsAwful

TiffanyHasPinkBow:
	setflag ENGINE_TIFFANY_HAS_PINK_BOW
	landmarktotext ROUTE_43, $2
	farjump PhoneScript_FoundItem_Female

; Vance

VancePhoneScript1:
	trainertotext BIRD_KEEPER, VANCE1, $0
	checkflag ENGINE_VANCE
	iftrue UnknownScript_0xbdc96
	farscall PhoneScript_AnswerPhone_Male
	checkflag ENGINE_VANCE_WEDNESDAY_NIGHT
	iftrue UnknownScript_0xbdc92
	checkcode VAR_WEEKDAY
	ifnotequal WEDNESDAY, UnknownScript_0xbdc92
	checktime (1 << EVE) | (1 << NITE)
	iftrue VanceWednesdayNight

UnknownScript_0xbdc92:
	farjump VanceLookingForwardScript

UnknownScript_0xbdc96:
	landmarktotext ROUTE_44, $2
	farjump VanceHurryHurryScript

VancePhoneScript2:
	trainertotext BIRD_KEEPER, VANCE1, $0
	farscall PhoneScript_GreetPhone_Male
	checkflag ENGINE_VANCE
	iftrue UnknownScript_0xbdcbd
	checkflag ENGINE_VANCE_WEDNESDAY_NIGHT
	iftrue UnknownScript_0xbdcbd
	farscall PhoneScript_Random3
	ifequal $0, VanceWantsRematch
	ifequal $1, VanceWantsRematch

UnknownScript_0xbdcbd:
	farjump Phone_GenericCall_Male

VanceWednesdayNight:
	setflag ENGINE_VANCE_WEDNESDAY_NIGHT

VanceWantsRematch:
	landmarktotext ROUTE_44, $2
	setflag ENGINE_VANCE
	farjump PhoneScript_WantsToBattle_Male

WiltonPhoneScript1:
	trainertotext FISHER, WILTON1, $0
	checkflag ENGINE_WILTON
	iftrue UnknownScript_0xbdcf7
	farscall PhoneScript_AnswerPhone_Male
	checkflag ENGINE_WILTON_THRUSDAY_MORNING
	iftrue UnknownScript_0xbdcf3
	checkflag ENGINE_WILTON_HAS_ITEM
	iftrue UnknownScript_0xbdcfe
	checkcode VAR_WEEKDAY
	ifnotequal THURSDAY, UnknownScript_0xbdcf3
	checktime 1 << MORN
	iftrue WiltonThursdayMorning

UnknownScript_0xbdcf3:
	farjump WiltonHaventFoundAnythingScript

UnknownScript_0xbdcf7:
	landmarktotext ROUTE_44, $2
	farjump WiltonNotBitingScript

UnknownScript_0xbdcfe:
	landmarktotext ROUTE_44, $2
	farjump WiltonWantThisScript

WiltonPhoneScript2:
	trainertotext FISHER, WILTON1, $0
	farscall PhoneScript_GreetPhone_Male
	checkflag ENGINE_WILTON
	iftrue UnknownScript_0xbdd2f
	checkflag ENGINE_WILTON_THRUSDAY_MORNING
	iftrue UnknownScript_0xbdd2f
	checkflag ENGINE_WILTON_HAS_ITEM
	iftrue UnknownScript_0xbdd2f
	farscall PhoneScript_Random2
	ifequal $0, WiltonWantsBattle
	farscall PhoneScript_Random2
	ifequal $0, WiltonHasItem

UnknownScript_0xbdd2f:
	farjump Phone_GenericCall_Male

WiltonThursdayMorning:
	setflag ENGINE_WILTON_THRUSDAY_MORNING

WiltonWantsBattle:
	landmarktotext ROUTE_44, $2
	setflag ENGINE_WILTON
	farjump PhoneScript_WantsToBattle_Male

WiltonHasItem:
	setflag ENGINE_WILTON_HAS_ITEM
	landmarktotext ROUTE_44, $2
	clearevent EVENT_WILTON_HAS_ULTRA_BALL
	clearevent EVENT_WILTON_HAS_GREAT_BALL
	clearevent EVENT_WILTON_HAS_POKE_BALL
	random $5
	ifequal $0, UnknownScript_0xbdd5e
	random $3
	ifequal $0, UnknownScript_0xbdd64
	jump UnknownScript_0xbdd6a

UnknownScript_0xbdd5e:
	setevent EVENT_WILTON_HAS_ULTRA_BALL
	jump UnknownScript_0xbdd6d

UnknownScript_0xbdd64:
	setevent EVENT_WILTON_HAS_GREAT_BALL
	jump UnknownScript_0xbdd6d

UnknownScript_0xbdd6a:
	setevent EVENT_WILTON_HAS_POKE_BALL

UnknownScript_0xbdd6d:
	farjump PhoneScript_FoundItem_Male

; Kenji

KenjiPhoneScript1:
	trainertotext BLACKBELT_T, KENJI1, $0
	farscall PhoneScript_AnswerPhone_Male
	farjump KenjiAnswerPhoneScript

KenjiPhoneScript2:
	trainertotext BLACKBELT_T, KENJI1, $0
	farscall PhoneScript_GreetPhone_Male
	farjump KenjiCallingPhoneScript

; Parry

ParryPhoneScript1:
	trainertotext HIKER, PARRY1, $0
	checkflag ENGINE_PARRY
	iftrue UnknownScript_0xbddac
	farscall PhoneScript_AnswerPhone_Male
	checkflag ENGINE_PARRY_FRIDAY_AFTERNOON
	iftrue UnknownScript_0xbdda8
	checkcode VAR_WEEKDAY
	ifnotequal FRIDAY, UnknownScript_0xbdda8
	checktime 1 << DAY
	iftrue ParryFridayDay

UnknownScript_0xbdda8:
	farjump ParryBattleWithMeScript

UnknownScript_0xbddac:
	landmarktotext ROUTE_45, $2
	farjump ParryHaventYouGottenToScript

ParryPhoneScript2:
	trainertotext HIKER, PARRY1, $0
	farscall PhoneScript_GreetPhone_Male
	checkflag ENGINE_PARRY
	iftrue UnknownScript_0xbddd3
	checkflag ENGINE_PARRY_FRIDAY_AFTERNOON
	iftrue UnknownScript_0xbddd3
	farscall PhoneScript_Random2
	ifequal $0, ParryWantsBattle
	ifequal $1, ParryWantsBattle

UnknownScript_0xbddd3:
	farjump Phone_GenericCall_Male

ParryFridayDay:
	setflag ENGINE_PARRY_FRIDAY_AFTERNOON

ParryWantsBattle:
	landmarktotext ROUTE_45, $2
	setflag ENGINE_PARRY
	farjump PhoneScript_WantsToBattle_Male

; Erin

ErinPhoneScript1:
	trainertotext PICNICKER, ERIN1, $0
	checkflag ENGINE_ERIN
	iftrue UnknownScript_0xbde07
	farscall PhoneScript_AnswerPhone_Female
	checkflag ENGINE_ERIN_SATURDAY_NIGHT
	iftrue UnknownScript_0xbde03
	checkcode VAR_WEEKDAY
	ifnotequal SATURDAY, UnknownScript_0xbde03
	checktime (1 << EVE) | (1 << NITE)
	iftrue ErinSaturdayNight

UnknownScript_0xbde03:
	farjump ErinWorkingHardScript

UnknownScript_0xbde07:
	landmarktotext ROUTE_46, $2
	farjump ErinComeBattleScript

ErinPhoneScript2:
	trainertotext PICNICKER, ERIN1, $0
	farscall PhoneScript_GreetPhone_Female
	checkflag ENGINE_ERIN
	iftrue UnknownScript_0xbde2e
	checkflag ENGINE_ERIN_SATURDAY_NIGHT
	iftrue UnknownScript_0xbde2e
	farscall PhoneScript_Random3
	ifequal $0, ErinWantsBattle
	ifequal $1, ErinWantsBattle

UnknownScript_0xbde2e:
	farjump Phone_GenericCall_Female

ErinSaturdayNight:
	setflag ENGINE_ERIN_SATURDAY_NIGHT

ErinWantsBattle:
	landmarktotext ROUTE_46, $2
	setflag ENGINE_ERIN
	farjump PhoneScript_WantsToBattle_Female

PhoneScript_Random2:
	random 2
	end

PhoneScript_Random3:
	random 3
	end

PhoneScript_Random4:
	random 4
	end

PhoneScript_Random5:
	random 5
	end

PhoneScript_Random11:
	random 11
	end

PhoneScript_AnswerPhone_Male:
	checktime 1 << DAY
	iftrue PhoneScript_AnswerPhone_Male_Day
	checktime (1 << EVE) | (1 << NITE)
	iftrue PhoneScript_AnswerPhone_Male_Nite
	checkcode VAR_CALLERID
	ifequal PHONE_SCHOOLBOY_JACK, .Jack
	ifequal PHONE_SAILOR_HUEY, .Huey
	ifequal PHONE_COOLTRAINERM_GAVEN, .Gaven
	ifequal PHONE_BIRDKEEPER_JOSE, .Jose
	ifequal PHONE_YOUNGSTER_JOEY, .Joey
	ifequal PHONE_BUG_CATCHER_WADE, .Wade
	ifequal PHONE_FISHER_RALPH, .Ralph
	ifequal PHONE_HIKER_ANTHONY, .Anthony
	ifequal PHONE_CAMPER_TODD, .Todd
	ifequal PHONE_JUGGLER_IRWIN, .Irwin
	ifequal PHONE_BUG_CATCHER_ARNIE, .Arnie
	ifequal PHONE_SCHOOLBOY_ALAN, .Alan
	ifequal PHONE_SCHOOLBOY_CHAD, .Chad
	ifequal PHONE_POKEFANM_DEREK, .Derek
	ifequal PHONE_FISHER_TULLY, .Tully
	ifequal PHONE_POKEMANIAC_BRENT, .Brent
	ifequal PHONE_BIRDKEEPER_VANCE, .Vance
	ifequal PHONE_FISHER_WILTON, .Wilton
	ifequal PHONE_BLACKBELT_KENJI, .Kenji
	ifequal PHONE_HIKER_PARRY, .Parry

.Jack:
	farwritetext JackAnswerPhoneText
	buttonsound
	end

.Huey:
	farwritetext HueyAnswerPhoneText
	buttonsound
	end

.Gaven:
	farwritetext GavenAnswerPhoneText
	buttonsound
	end

.Jose:
	farwritetext JoseAnswerPhoneText
	buttonsound
	end

.Joey:
	farwritetext JoeyAnswerPhoneText
	buttonsound
	end

.Wade:
	farwritetext WadeAnswerPhoneText
	buttonsound
	end

.Ralph:
	farwritetext RalphAnswerPhoneText
	buttonsound
	end

.Anthony:
	farwritetext AnthonyAnswerPhoneText
	buttonsound
	end

.Todd:
	farwritetext ToddAnswerPhoneText
	buttonsound
	end

.Irwin:
	farwritetext IrwinAnswerPhoneText
	buttonsound
	end

.Arnie:
	farwritetext ArnieAnswerPhoneText
	buttonsound
	end

.Alan:
	farwritetext AlanAnswerPhoneText
	buttonsound
	end

.Chad:
	farwritetext ChadAnswerPhoneText
	buttonsound
	end

.Derek:
	farwritetext DerekAnswerPhoneText
	buttonsound
	end

.Tully:
	farwritetext TullyAnswerPhoneText
	buttonsound
	end

.Brent:
	farwritetext BrentAnswerPhoneText
	buttonsound
	end

.Vance:
	farwritetext VanceAnswerPhoneText
	buttonsound
	end

.Wilton:
	farwritetext WiltonAnswerPhoneText
	buttonsound
	end

.Kenji:
	farwritetext KenjiAnswerPhoneText
	buttonsound
	end

.Parry:
	farwritetext ParryAnswerPhoneText
	buttonsound
	end

PhoneScript_AnswerPhone_Male_Day:
	checkcode VAR_CALLERID
	ifequal PHONE_SCHOOLBOY_JACK, .Jack
	ifequal PHONE_SAILOR_HUEY, .Huey
	ifequal PHONE_COOLTRAINERM_GAVEN, .Gaven
	ifequal PHONE_BIRDKEEPER_JOSE, .Jose
	ifequal PHONE_YOUNGSTER_JOEY, .Joey
	ifequal PHONE_BUG_CATCHER_WADE, .Wade
	ifequal PHONE_FISHER_RALPH, .Ralph
	ifequal PHONE_HIKER_ANTHONY, .Anthony
	ifequal PHONE_CAMPER_TODD, .Todd
	ifequal PHONE_JUGGLER_IRWIN, .Irwin
	ifequal PHONE_BUG_CATCHER_ARNIE, .Arnie
	ifequal PHONE_SCHOOLBOY_ALAN, .Alan
	ifequal PHONE_SCHOOLBOY_CHAD, .Chad
	ifequal PHONE_POKEFANM_DEREK, .Derek
	ifequal PHONE_FISHER_TULLY, .Tully
	ifequal PHONE_POKEMANIAC_BRENT, .Brent
	ifequal PHONE_BIRDKEEPER_VANCE, .Vance
	ifequal PHONE_FISHER_WILTON, .Wilton
	ifequal PHONE_BLACKBELT_KENJI, .Kenji
	ifequal PHONE_HIKER_PARRY, .Parry

.Jack:
	farwritetext JackAnswerPhoneDayText
	buttonsound
	end

.Huey:
	farwritetext HueyAnswerPhoneDayText
	buttonsound
	end

.Gaven:
	farwritetext GavenAnswerPhoneDayText
	buttonsound
	end

.Jose:
	farwritetext JoseAnswerPhoneDayText
	buttonsound
	end

.Joey:
	farwritetext JoeyAnswerPhoneDayText
	buttonsound
	end

.Wade:
	farwritetext WadeAnswerPhoneDayText
	buttonsound
	end

.Ralph:
	farwritetext RalphAnswerPhoneDayText
	buttonsound
	end

.Anthony:
	farwritetext AnthonyAnswerPhoneDayText
	buttonsound
	end

.Todd:
	farwritetext ToddAnswerPhoneDayText
	buttonsound
	end

.Irwin:
	farwritetext IrwinAnswerPhoneDayText
	buttonsound
	end

.Arnie:
	farwritetext ArnieAnswerPhoneDayText
	buttonsound
	end

.Alan:
	farwritetext AlanAnswerPhoneDayText
	buttonsound
	end

.Chad:
	farwritetext ChadAnswerPhoneDayText
	buttonsound
	end

.Derek:
	farwritetext DerekAnswerPhoneDayText
	buttonsound
	end

.Tully:
	farwritetext TullyAnswerPhoneDayText
	buttonsound
	end

.Brent:
	farwritetext BrentAnswerPhoneDayText
	buttonsound
	end

.Vance:
	farwritetext VanceAnswerPhoneDayText
	buttonsound
	end

.Wilton:
	farwritetext WiltonAnswerPhoneDayText
	buttonsound
	end

.Kenji:
	farwritetext KenjiAnswerPhoneDayText
	buttonsound
	end

.Parry:
	farwritetext ParryAnswerPhoneDayText
	buttonsound
	end

PhoneScript_AnswerPhone_Male_Nite:
	checkcode VAR_CALLERID
	ifequal PHONE_SCHOOLBOY_JACK, .Jack
	ifequal PHONE_SAILOR_HUEY, .Huey
	ifequal PHONE_COOLTRAINERM_GAVEN, .Gaven
	ifequal PHONE_BIRDKEEPER_JOSE, .Jose
	ifequal PHONE_YOUNGSTER_JOEY, .Joey
	ifequal PHONE_BUG_CATCHER_WADE, .Wade
	ifequal PHONE_FISHER_RALPH, .Ralph
	ifequal PHONE_HIKER_ANTHONY, .Anthony
	ifequal PHONE_CAMPER_TODD, .Todd
	ifequal PHONE_JUGGLER_IRWIN, .Irwin
	ifequal PHONE_BUG_CATCHER_ARNIE, .Arnie
	ifequal PHONE_SCHOOLBOY_ALAN, .Alan
	ifequal PHONE_SCHOOLBOY_CHAD, .Chad
	ifequal PHONE_POKEFANM_DEREK, .Derek
	ifequal PHONE_FISHER_TULLY, .Tully
	ifequal PHONE_POKEMANIAC_BRENT, .Brent
	ifequal PHONE_BIRDKEEPER_VANCE, .Vance
	ifequal PHONE_FISHER_WILTON, .Wilton
	ifequal PHONE_BLACKBELT_KENJI, .Kenji
	ifequal PHONE_HIKER_PARRY, .Parry

.Jack:
	farwritetext JackAnswerPhoneNiteText
	buttonsound
	end

.Huey:
	farwritetext HueyAnswerPhoneNiteText
	buttonsound
	end

.Gaven:
	farwritetext GavenAnswerPhoneNiteText
	buttonsound
	end

.Jose:
	farwritetext JoseAnswerPhoneNiteText
	buttonsound
	end

.Joey:
	farwritetext JoeyAnswerPhoneNiteText
	buttonsound
	end

.Wade:
	farwritetext WadeAnswerPhoneNiteText
	buttonsound
	end

.Ralph:
	farwritetext RalphAnswerPhoneNiteText
	buttonsound
	end

.Anthony:
	farwritetext AnthonyAnswerPhoneNiteText
	buttonsound
	end

.Todd:
	farwritetext ToddAnswerPhoneNiteText
	buttonsound
	end

.Irwin:
	farwritetext IrwinAnswerPhoneNiteText
	buttonsound
	end

.Arnie:
	farwritetext ArnieAnswerPhoneNiteText
	buttonsound
	end

.Alan:
	farwritetext AlanAnswerPhoneNiteText
	buttonsound
	end

.Chad:
	farwritetext ChadAnswerPhoneNiteText
	buttonsound
	end

.Derek:
	farwritetext DerekAnswerPhoneNiteText
	buttonsound
	end

.Tully:
	farwritetext TullyAnswerPhoneNiteText
	buttonsound
	end

.Brent:
	farwritetext BrentAnswerPhoneNiteText
	buttonsound
	end

.Vance:
	farwritetext VanceAnswerPhoneNiteText
	buttonsound
	end

.Wilton:
	farwritetext WiltonAnswerPhoneNiteText
	buttonsound
	end

.Kenji:
	farwritetext KenjiAnswerPhoneNiteText
	buttonsound
	end

.Parry:
	farwritetext ParryAnswerPhoneNiteText
	buttonsound
	end

PhoneScript_AnswerPhone_Female:
	checktime 1 << DAY
	iftrue PhoneScript_AnswerPhone_Female_Day
	checktime (1 << EVE) | (1 << NITE)
	iftrue PhoneScript_AnswerPhone_Female_Nite
	checkcode VAR_CALLERID
	ifequal PHONE_POKEFAN_BEVERLY, .Beverly
	ifequal PHONE_COOLTRAINERF_BETH, .Beth
	ifequal PHONE_COOLTRAINERF_REENA, .Reena
	ifequal PHONE_PICNICKER_LIZ, .Liz
	ifequal PHONE_PICNICKER_GINA, .Gina
	ifequal PHONE_LASS_DANA, .Dana
	ifequal PHONE_PICNICKER_TIFFANY, .Tiffany
	ifequal PHONE_PICNICKER_ERIN, .Erin

.Beverly:
	farwritetext BeverlyAnswerPhoneText
	buttonsound
	end

.Beth:
	farwritetext BethAnswerPhoneText
	buttonsound
	end

.Reena:
	farwritetext ReenaAnswerPhoneText
	buttonsound
	end

.Liz:
	farwritetext LizAnswerPhoneText
	buttonsound
	end

.Gina:
	farwritetext GinaAnswerPhoneText
	buttonsound
	end

.Dana:
	farwritetext DanaAnswerPhoneText
	buttonsound
	end

.Tiffany:
	farwritetext TiffanyAnswerPhoneText
	buttonsound
	end

.Erin:
	farwritetext ErinAnswerPhoneText
	buttonsound
	end

PhoneScript_AnswerPhone_Female_Day:
	checkcode VAR_CALLERID
	ifequal PHONE_POKEFAN_BEVERLY, .Beverly
	ifequal PHONE_COOLTRAINERF_BETH, .Beth
	ifequal PHONE_COOLTRAINERF_REENA, .Reena
	ifequal PHONE_PICNICKER_LIZ, .Liz
	ifequal PHONE_PICNICKER_GINA, .Gina
	ifequal PHONE_LASS_DANA, .Dana
	ifequal PHONE_PICNICKER_TIFFANY, .Tiffany
	ifequal PHONE_PICNICKER_ERIN, .Erin

.Beverly:
	farwritetext BeverlyAnswerPhoneDayText
	buttonsound
	end

.Beth:
	farwritetext BethAnswerPhoneDayText
	buttonsound
	end

.Reena:
	farwritetext ReenaAnswerPhoneDayText
	buttonsound
	end

.Liz:
	farwritetext LizAnswerPhoneDayText
	buttonsound
	end

.Gina:
	farwritetext GinaAnswerPhoneDayText
	buttonsound
	end

.Dana:
	farwritetext DanaAnswerPhoneDayText
	buttonsound
	end

.Tiffany:
	farwritetext TiffanyAnswerPhoneDayText
	buttonsound
	end

.Erin:
	farwritetext ErinAnswerPhoneDayText
	buttonsound
	end

PhoneScript_AnswerPhone_Female_Nite:
	checkcode VAR_CALLERID
	ifequal PHONE_POKEFAN_BEVERLY, .Beverly
	ifequal PHONE_COOLTRAINERF_BETH, .Beth
	ifequal PHONE_COOLTRAINERF_REENA, .Reena
	ifequal PHONE_PICNICKER_LIZ, .Liz
	ifequal PHONE_PICNICKER_GINA, .Gina
	ifequal PHONE_LASS_DANA, .Dana
	ifequal PHONE_PICNICKER_TIFFANY, .Tiffany
	ifequal PHONE_PICNICKER_ERIN, .Erin

.Beverly:
	farwritetext BeverlyAnswerPhoneNiteText
	buttonsound
	end

.Beth:
	farwritetext BethAnswerPhoneNiteText
	buttonsound
	end

.Reena:
	farwritetext ReenaAnswerPhoneNiteText
	buttonsound
	end

.Liz:
	farwritetext LizAnswerPhoneNiteText
	buttonsound
	end

.Gina:
	farwritetext GinaAnswerPhoneNiteText
	buttonsound
	end

.Dana:
	farwritetext DanaAnswerPhoneNiteText
	buttonsound
	end

.Tiffany:
	farwritetext TiffanyAnswerPhoneNiteText
	buttonsound
	end

.Erin:
	farwritetext ErinAnswerPhoneNiteText
	buttonsound
	end

PhoneScript_GreetPhone_Male:
	checktime 1 << DAY
	iftrue PhoneScript_GreetPhone_Male_Day
	checktime (1 << EVE) | (1 << NITE)
	iftrue PhoneScript_GreetPhone_Male_Nite
	checkcode VAR_CALLERID
	ifequal PHONE_SCHOOLBOY_JACK, .Jack
	ifequal PHONE_SAILOR_HUEY, .Huey
	ifequal PHONE_COOLTRAINERM_GAVEN, .Gaven
	ifequal PHONE_BIRDKEEPER_JOSE, .Jose
	ifequal PHONE_YOUNGSTER_JOEY, .Joey
	ifequal PHONE_BUG_CATCHER_WADE, .Wade
	ifequal PHONE_FISHER_RALPH, .Ralph
	ifequal PHONE_HIKER_ANTHONY, .Anthony
	ifequal PHONE_CAMPER_TODD, .Todd
	ifequal PHONE_JUGGLER_IRWIN, .Irwin
	ifequal PHONE_BUG_CATCHER_ARNIE, .Arnie
	ifequal PHONE_SCHOOLBOY_ALAN, .Alan
	ifequal PHONE_SCHOOLBOY_CHAD, .Chad
	ifequal PHONE_POKEFANM_DEREK, .Derek
	ifequal PHONE_FISHER_TULLY, .Tully
	ifequal PHONE_POKEMANIAC_BRENT, .Brent
	ifequal PHONE_BIRDKEEPER_VANCE, .Vance
	ifequal PHONE_FISHER_WILTON, .Wilton
	ifequal PHONE_BLACKBELT_KENJI, .Kenji
	ifequal PHONE_HIKER_PARRY, .Parry

.Jack:
	farwritetext JackGreetText
	buttonsound
	end

.Huey:
	farwritetext HueyGreetText
	buttonsound
	end

.Gaven:
	farwritetext GavenGreetText
	buttonsound
	end

.Jose:
	farwritetext JoseGreetText
	buttonsound
	end

.Joey:
	farwritetext JoeyGreetText
	buttonsound
	end

.Wade:
	farwritetext WadeGreetText
	buttonsound
	end

.Ralph:
	farwritetext RalphGreetText
	buttonsound
	end

.Anthony:
	farwritetext AnthonyGreetText
	buttonsound
	end

.Todd:
	farwritetext ToddGreetText
	buttonsound
	end

.Irwin:
	farwritetext IrwinGreetText
	buttonsound
	end

.Arnie:
	farwritetext ArnieGreetText
	buttonsound
	end

.Alan:
	farwritetext AlanGreetText
	buttonsound
	end

.Chad:
	farwritetext ChadGreetText
	buttonsound
	end

.Derek:
	farwritetext DerekGreetText
	buttonsound
	end

.Tully:
	farwritetext TullyGreetText
	buttonsound
	end

.Brent:
	farwritetext BrentGreetText
	buttonsound
	end

.Vance:
	farwritetext VanceGreetText
	buttonsound
	end

.Wilton:
	farwritetext WiltonGreetText
	buttonsound
	end

.Kenji:
	farwritetext KenjiGreetText
	buttonsound
	end

.Parry:
	farwritetext ParryGreetText
	buttonsound
	end

PhoneScript_GreetPhone_Male_Day:
	checkcode VAR_CALLERID
	ifequal PHONE_SCHOOLBOY_JACK, .Jack
	ifequal PHONE_SAILOR_HUEY, .Huey
	ifequal PHONE_COOLTRAINERM_GAVEN, .Gaven
	ifequal PHONE_BIRDKEEPER_JOSE, .Jose
	ifequal PHONE_YOUNGSTER_JOEY, .Joey
	ifequal PHONE_BUG_CATCHER_WADE, .Wade
	ifequal PHONE_FISHER_RALPH, .Ralph
	ifequal PHONE_HIKER_ANTHONY, .Anthony
	ifequal PHONE_CAMPER_TODD, .Todd
	ifequal PHONE_JUGGLER_IRWIN, .Irwin
	ifequal PHONE_BUG_CATCHER_ARNIE, .Arnie
	ifequal PHONE_SCHOOLBOY_ALAN, .Alan
	ifequal PHONE_SCHOOLBOY_CHAD, .Chad
	ifequal PHONE_POKEFANM_DEREK, .Derek
	ifequal PHONE_FISHER_TULLY, .Tully
	ifequal PHONE_POKEMANIAC_BRENT, .Brent
	ifequal PHONE_BIRDKEEPER_VANCE, .Vance
	ifequal PHONE_FISHER_WILTON, .Wilton
	ifequal PHONE_BLACKBELT_KENJI, .Kenji
	ifequal PHONE_HIKER_PARRY, .Parry

.Jack:
	farwritetext JackGreetDayText
	buttonsound
	end

.Huey:
	farwritetext HueyGreetDayText
	buttonsound
	end

.Gaven:
	farwritetext GavenGreetDayText
	buttonsound
	end

.Jose:
	farwritetext JoseGreetDayText
	buttonsound
	end

.Joey:
	farwritetext JoeyGreetDayText
	buttonsound
	end

.Wade:
	farwritetext WadeGreetDayText
	buttonsound
	end

.Ralph:
	farwritetext RalphGreetDayText
	buttonsound
	end

.Anthony:
	farwritetext AnthonyGreetDayText
	buttonsound
	end

.Todd:
	farwritetext ToddGreetDayText
	buttonsound
	end

.Irwin:
	farwritetext IrwinGreetDayText
	buttonsound
	end

.Arnie:
	farwritetext ArnieGreetDayText
	buttonsound
	end

.Alan:
	farwritetext AlanGreetDayText
	buttonsound
	end

.Chad:
	farwritetext ChadGreetDayText
	buttonsound
	end

.Derek:
	farwritetext DerekGreetDayText
	buttonsound
	end

.Tully:
	farwritetext TullyGreetDayText
	buttonsound
	end

.Brent:
	farwritetext BrentGreetDayText
	buttonsound
	end

.Vance:
	farwritetext VanceGreetDayText
	buttonsound
	end

.Wilton:
	farwritetext WiltonGreetDayText
	buttonsound
	end

.Kenji:
	farwritetext KenjiGreetDayText
	buttonsound
	end

.Parry:
	farwritetext ParryGreetDayText
	buttonsound
	end

PhoneScript_GreetPhone_Male_Nite:
	checkcode VAR_CALLERID
	ifequal PHONE_SCHOOLBOY_JACK, .Jack
	ifequal PHONE_SAILOR_HUEY, .Huey
	ifequal PHONE_COOLTRAINERM_GAVEN, .Gaven
	ifequal PHONE_BIRDKEEPER_JOSE, .Jose
	ifequal PHONE_YOUNGSTER_JOEY, .Joey
	ifequal PHONE_BUG_CATCHER_WADE, .Wade
	ifequal PHONE_FISHER_RALPH, .Ralph
	ifequal PHONE_HIKER_ANTHONY, .Anthony
	ifequal PHONE_CAMPER_TODD, .Todd
	ifequal PHONE_JUGGLER_IRWIN, .Irwin
	ifequal PHONE_BUG_CATCHER_ARNIE, .Arnie
	ifequal PHONE_SCHOOLBOY_ALAN, .Alan
	ifequal PHONE_SCHOOLBOY_CHAD, .Chad
	ifequal PHONE_POKEFANM_DEREK, .Derek
	ifequal PHONE_FISHER_TULLY, .Tully
	ifequal PHONE_POKEMANIAC_BRENT, .Brent
	ifequal PHONE_BIRDKEEPER_VANCE, .Vance
	ifequal PHONE_FISHER_WILTON, .Wilton
	ifequal PHONE_BLACKBELT_KENJI, .Kenji
	ifequal PHONE_HIKER_PARRY, .Parry

.Jack:
	farwritetext JackGreetNiteText
	buttonsound
	end

.Huey:
	farwritetext HueyGreetNiteText
	buttonsound
	end

.Gaven:
	farwritetext GavenGreetNiteText
	buttonsound
	end

.Jose:
	farwritetext JoseGreetNiteText
	buttonsound
	end

.Joey:
	farwritetext JoeyGreetNiteText
	buttonsound
	end

.Wade:
	farwritetext WadeGreetNiteText
	buttonsound
	end

.Ralph:
	farwritetext RalphGreetNiteText
	buttonsound
	end

.Anthony:
	farwritetext AnthonyGreetNiteText
	buttonsound
	end

.Todd:
	farwritetext ToddGreetNiteText
	buttonsound
	end

.Irwin:
	farwritetext IrwinGreetNiteText
	buttonsound
	end

.Arnie:
	farwritetext ArnieGreetNiteText
	buttonsound
	end

.Alan:
	farwritetext AlanGreetNiteText
	buttonsound
	end

.Chad:
	farwritetext ChadGreetNiteText
	buttonsound
	end

.Derek:
	farwritetext DerekGreetNiteText
	buttonsound
	end

.Tully:
	farwritetext TullyGreetNiteText
	buttonsound
	end

.Brent:
	farwritetext BrentGreetNiteText
	buttonsound
	end

.Vance:
	farwritetext VanceGreetNiteText
	buttonsound
	end

.Wilton:
	farwritetext WiltonGreetNiteText
	buttonsound
	end

.Kenji:
	farwritetext KenjiGreetNiteText
	buttonsound
	end

.Parry:
	farwritetext ParryGreetNiteText
	buttonsound
	end

PhoneScript_GreetPhone_Female:
	checktime 1 << DAY
	iftrue PhoneScript_GreetPhone_Female_Day
	checktime (1 << EVE) | (1 << NITE)
	iftrue PhoneScript_GreetPhone_Female_Nite
	checkcode VAR_CALLERID
	ifequal PHONE_POKEFAN_BEVERLY, .Beverly
	ifequal PHONE_COOLTRAINERF_BETH, .Beth
	ifequal PHONE_COOLTRAINERF_REENA, .Reena
	ifequal PHONE_PICNICKER_LIZ, .Liz
	ifequal PHONE_PICNICKER_GINA, .Gina
	ifequal PHONE_LASS_DANA, .Dana
	ifequal PHONE_PICNICKER_TIFFANY, .Tiffany
	ifequal PHONE_PICNICKER_ERIN, .Erin

.Beverly:
	farwritetext BeverlyGreetText
	buttonsound
	end

.Beth:
	farwritetext BethGreetText
	buttonsound
	end

.Reena:
	farwritetext ReenaGreetText
	buttonsound
	end

.Liz:
	farwritetext LizGreetText
	buttonsound
	end

.Gina:
	farwritetext GinaGreetText
	buttonsound
	end

.Dana:
	farwritetext DanaGreetText
	buttonsound
	end

.Tiffany:
	farwritetext TiffanyGreetText
	buttonsound
	end

.Erin:
	farwritetext ErinGreetText
	buttonsound
	end

PhoneScript_GreetPhone_Female_Day:
	checkcode VAR_CALLERID
	ifequal PHONE_POKEFAN_BEVERLY, .Beverly
	ifequal PHONE_COOLTRAINERF_BETH, .Beth
	ifequal PHONE_COOLTRAINERF_REENA, .Reena
	ifequal PHONE_PICNICKER_LIZ, .Liz
	ifequal PHONE_PICNICKER_GINA, .Gina
	ifequal PHONE_LASS_DANA, .Dana
	ifequal PHONE_PICNICKER_TIFFANY, .Tiffany
	ifequal PHONE_PICNICKER_ERIN, .Erin

.Beverly:
	farwritetext BeverlyGreetDayText
	buttonsound
	end

.Beth:
	farwritetext BethGreetDayText
	buttonsound
	end

.Reena:
	farwritetext ReenaGreetDayText
	buttonsound
	end

.Liz:
	farwritetext LizGreetDayText
	buttonsound
	end

.Gina:
	farwritetext GinaGreetDayText
	buttonsound
	end

.Dana:
	farwritetext DanaGreetDayText
	buttonsound
	end

.Tiffany:
	farwritetext TiffanyGreetDayText
	buttonsound
	end

.Erin:
	farwritetext ErinGreetDayText
	buttonsound
	end

PhoneScript_GreetPhone_Female_Nite:
	checkcode VAR_CALLERID
	ifequal PHONE_POKEFAN_BEVERLY, .Beverly
	ifequal PHONE_COOLTRAINERF_BETH, .Beth
	ifequal PHONE_COOLTRAINERF_REENA, .Reena
	ifequal PHONE_PICNICKER_LIZ, .Liz
	ifequal PHONE_PICNICKER_GINA, .Gina
	ifequal PHONE_LASS_DANA, .Dana
	ifequal PHONE_PICNICKER_TIFFANY, .Tiffany
	ifequal PHONE_PICNICKER_ERIN, .Erin

.Beverly:
	farwritetext BeverlyGreetNiteText
	buttonsound
	end

.Beth:
	farwritetext BethGreetNiteText
	buttonsound
	end

.Reena:
	farwritetext ReenaGreetNiteText
	buttonsound
	end

.Liz:
	farwritetext LizGreetNiteText
	buttonsound
	end

.Gina:
	farwritetext GinaGreetNiteText
	buttonsound
	end

.Dana:
	farwritetext DanaGreetNiteText
	buttonsound
	end

.Tiffany:
	farwritetext TiffanyGreetNiteText
	buttonsound
	end

.Erin:
	farwritetext ErinGreetNiteText
	buttonsound
	end

PhoneScript_Generic_Male:
	checkcode VAR_CALLERID
	ifequal PHONE_SCHOOLBOY_JACK, .Jack
	ifequal PHONE_COOLTRAINERM_GAVEN, .Gaven
	ifequal PHONE_BIRDKEEPER_JOSE, .Jose
	ifequal PHONE_YOUNGSTER_JOEY, .Joey
	ifequal PHONE_BUG_CATCHER_WADE, .Wade
	ifequal PHONE_FISHER_RALPH, .Ralph
	ifequal PHONE_HIKER_ANTHONY, .Anthony
	ifequal PHONE_CAMPER_TODD, .Todd
	ifequal PHONE_BUG_CATCHER_ARNIE, .Arnie
	ifequal PHONE_SCHOOLBOY_ALAN, .Alan
	ifequal PHONE_SCHOOLBOY_CHAD, .Chad
	ifequal PHONE_POKEFANM_DEREK, .Derek
	ifequal PHONE_FISHER_TULLY, .Tully
	ifequal PHONE_POKEMANIAC_BRENT, .Brent
	ifequal PHONE_BIRDKEEPER_VANCE, .Vance
	ifequal PHONE_FISHER_WILTON, .Wilton
	ifequal PHONE_HIKER_PARRY, .Parry

.Jack:
	farwritetext JackGenericText
	buttonsound
	end

.Unknown:
	farwritetext UnknownGenericText
	buttonsound
	end

.Gaven:
	farwritetext GavenGenericText
	buttonsound
	end

.Jose:
	farwritetext JoseGenericText
	buttonsound
	end

.Joey:
	farwritetext JoeyGenericText
	buttonsound
	end

.Wade:
	farwritetext WadeGenericText
	buttonsound
	end

.Ralph:
	farwritetext RalphGenericText
	buttonsound
	end

.Anthony:
	farwritetext AnthonyGenericText
	buttonsound
	end

.Todd:
	farwritetext ToddGenericText
	buttonsound
	end

.Arnie:
	farwritetext ArnieGenericText
	buttonsound
	end

.Alan:
	farwritetext AlanGenericText
	buttonsound
	end

.Chad:
	farwritetext ChadGenericText
	buttonsound
	end

.Derek:
	farwritetext DerekGenericText
	buttonsound
	end

.Tully:
	farwritetext TullyGenericText
	buttonsound
	end

.Brent:
	farwritetext BrentGenericText
	buttonsound
	end

.Vance:
	farwritetext VanceGenericText
	buttonsound
	end

.Wilton:
	farwritetext WiltonGenericText
	buttonsound
	end

.Parry:
	farwritetext ParryGenericText
	buttonsound
	end

PhoneScript_Generic_Female:
	checkcode VAR_CALLERID
	ifequal PHONE_POKEFAN_BEVERLY, .Beverly
	ifequal PHONE_COOLTRAINERF_BETH, .Beth
	ifequal PHONE_COOLTRAINERF_REENA, .Reena
	ifequal PHONE_PICNICKER_LIZ, .Liz
	ifequal PHONE_PICNICKER_GINA, .Gina
	ifequal PHONE_LASS_DANA, .Dana
	ifequal PHONE_PICNICKER_TIFFANY, .Tiffany
	ifequal PHONE_PICNICKER_ERIN, .Erin

.Beverly:
	farwritetext BeverlyGenericText
	buttonsound
	end

.Beth:
	farwritetext BethGenericText
	buttonsound
	end

.Reena:
	farwritetext ReenaGenericText
	buttonsound
	end

.Liz:
	farwritetext LizGenericText
	buttonsound
	end

.Gina:
	farwritetext GinaGenericText
	buttonsound
	end

.Dana:
	farwritetext DanaGenericText
	buttonsound
	end

.Tiffany:
	farwritetext TiffanyGenericText
	buttonsound
	end

.Erin:
	farwritetext ErinGenericText
	buttonsound
	end

PhoneScript_MonFlavorText:
	special RandomPhoneMon
	farscall PhoneScript_Random2
	ifequal $0, .TooEnergetic
	farwritetext UnknownGenericText
	buttonsound
	farjump PhoneScript_HangupText_Male

.TooEnergetic:
	farwritetext UnknownTougherThanEverText
	buttonsound
	farjump PhoneScript_HangupText_Male

Phone_GrandmaString: db "Grandma@"
Phone_GrandpaString: db "Grandpa@"
Phone_MomString:     db "Mom@"
Phone_DadString:     db "Dad@"
Phone_SisterString:  db "Sister@"
Phone_BrotherString: db "Brother@"

