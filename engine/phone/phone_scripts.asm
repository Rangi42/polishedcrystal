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
	sjump MomPhoneNoPokemonScript

.bcec5
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_8
	iftrue MomPhoneHangUpScript
	farwritetext MomPhoneGreetingText
	promptbutton
	getcurlandmarkname $0
	readvar VAR_ENVIRONMENT
	ifequal TOWN, MomPhoneInTown
	ifequal ROUTE, MomPhoneOnRoute
	sjump MomPhoneOther

MomPhoneLandmark:
	farwritetext MomPhoneLandmarkText
	promptbutton
	sjump MomSavingMoney

MomPhoneInTown:
	readvar VAR_MAPGROUP
	ifequal GROUP_NEW_BARK_TOWN, .newbark
	ifequal GROUP_CHERRYGROVE_CITY, .cherrygrove
	ifequal GROUP_VIOLET_CITY, .violet
	ifequal GROUP_AZALEA_TOWN, .azalea
	ifequal GROUP_GOLDENROD_CITY, .goldenrod
	farwritetext MomPhoneGenericAreaText
	promptbutton
	sjump MomSavingMoney

.newbark
	farwritetext MomPhoneNewBarkText
	promptbutton
	sjump MomSavingMoney

.cherrygrove
	farwritetext MomPhoneCherrygroveText
	promptbutton
	sjump MomSavingMoney

.violet
	getlandmarkname SPROUT_TOWER, 1
	sjump MomPhoneLandmark
.azalea
	getlandmarkname SLOWPOKE_WELL, 1
	sjump MomPhoneLandmark
.goldenrod
	getlandmarkname RADIO_TOWER, 1
	sjump MomPhoneLandmark

MomPhoneOnRoute:
	farwritetext MomOtherAreaText
	promptbutton
	sjump MomSavingMoney

MomPhoneOther:
	farwritetext MomDeterminedText
	promptbutton
	sjump MomSavingMoney

MomSavingMoney:
	checkflag ENGINE_MOM_SAVING_MONEY
	iffalse UnknownScript_0xbcf49
	checkmoney $1, 0
	ifequal $0, UnknownScript_0xbcf55
	sjump UnknownScript_0xbcf63

UnknownScript_0xbcf49:
	checkmoney $1, 0
	ifequal $0, UnknownScript_0xbcf79
	sjump UnknownScript_0xbcf6e

UnknownScript_0xbcf55:
	getmoney $1, $0
	farwritetext MomCheckBalanceText
	yesorno
	iftrue MomPhoneSaveMoneyScript
	sjump MomPhoneWontSaveMoneyScript

UnknownScript_0xbcf63:
	farwritetext MomImportantToSaveText
	yesorno
	iftrue MomPhoneSaveMoneyScript
	sjump MomPhoneWontSaveMoneyScript

UnknownScript_0xbcf6e:
	farwritetext MomYoureNotSavingText
	yesorno
	iftrue MomPhoneSaveMoneyScript
	sjump MomPhoneWontSaveMoneyScript

UnknownScript_0xbcf79:
	getmoney $1, $0
	farwritetext MomYouveSavedText
	yesorno
	iftrue MomPhoneSaveMoneyScript
	sjump MomPhoneWontSaveMoneyScript

MomPhoneSaveMoneyScript:
	setflag ENGINE_MOM_SAVING_MONEY
	farwritetext MomOKIllSaveText
	promptbutton
	sjump MomPhoneHangUpScript

MomPhoneWontSaveMoneyScript:
	clearflag ENGINE_MOM_SAVING_MONEY
	farwritetext MomPhoneWontSaveMoneyText
	promptbutton
	sjump MomPhoneHangUpScript

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
	setflag ENGINE_MOM_ACTIVE
	specialphonecall SPECIALCALL_NONE
	farwritetext MomPhoneLectureText
	yesorno
	iftrue MomPhoneSaveMoneyScript
	sjump MomPhoneWontSaveMoneyScript

; Bill

BillPhoneScript1:
	checktime 1 << DAY
	iftrue .daygreet
	checktime 1 << MORN
	iffalse .nitegreet
	farwritetext BillPhoneMornGreetingText
	promptbutton
	sjump .main

.daygreet
	farwritetext BillPhoneDayGreetingText
	promptbutton
	sjump .main

.nitegreet
	farwritetext BillPhoneNiteGreetingText
	promptbutton
	sjump .main

.main
	farwritetext BillPhoneGenericText
	promptbutton
	readvar VAR_BOXSPACE
	getnum $0
	ifequal $0, .full
	ifless $6, .nearlyfull
	farwritetext BillPhoneNotFullText
	end

.nearlyfull
	farwritetext BillPhoneNearlyFullText
	end

.full
	farwritetext BillPhoneFullText
	sjump BillPhoneScriptCheckForBoxes

BillPhoneScript2:
	readvar VAR_SPECIALPHONECALL
	ifequal SPECIALCALL_SECONDBADGE, BillPhoneScriptSecondBadge
	farwritetext BillPhoneNewlyFullText
BillPhoneScriptCheckForBoxes:
	special BillBoxSwitchCheck
	ifequal 0, BillPhoneWholePCFull
	farwritetext BillFlushBySaving
	yesorno
	iffalse .rejected
	special Special_TryQuickSave
	iftrue .hang_up
.rejected
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
	readvar VAR_SPECIALPHONECALL
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
	readvar VAR_SPECIALPHONECALL
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
	promptbutton
	sjump .main

.daygreet
	farwritetext LyraPhoneDayGreetingText
	promptbutton
	sjump .main

.evegreet
	farwritetext LyraPhoneEveGreetingText
	promptbutton
	sjump .main

.nitegreet
	farwritetext LyraPhoneNiteGreetingText
	promptbutton
	sjump .main

.main
	checkpoke MAGNETON
	iftrue .magneton
	farwritetext LyraPhoneMainText
	end

.magneton
	farwritetext LyraPhoneMagnetonText
	promptbutton	
	sjump .endpokemon

.endpokemon
	farwritetext LyraPhoneEndText
	end

LyraPhoneScript2:
	readvar VAR_SPECIALPHONECALL
	ifequal SPECIALCALL_YELLOWFOREST, .yellowforest
	ifequal SPECIALCALL_FIRSTBADGE, .firstbadge
	ifequal SPECIALCALL_LYRASEGG, .lyrasegg
	specialphonecall SPECIALCALL_NONE
	sjump LyraPhoneScript

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
	promptbutton
	checkevent EVENT_GOT_TOTODILE_FROM_ELM
	iftrue .lyrasegg_totodile
	checkevent EVENT_GOT_CHIKORITA_FROM_ELM
	iftrue .lyrasegg_chikorita
	farwritetext LyraPhoneLyrasEggChikoritaText
	sjump .lyrasegg_end

.lyrasegg_totodile
	farwritetext LyraPhoneLyrasEggCyndaquilText
	sjump .lyrasegg_end

.lyrasegg_chikorita:
	farwritetext LyraPhoneLyrasEggTotodileText
.lyrasegg_end
	promptbutton
	farwritetext LyraPhoneLyrasEggEndText
	setevent EVENT_LYRA_GAVE_AWAY_EGG
	specialphonecall SPECIALCALL_NONE
	end

; Jack

JackPhoneScript1:
	gettrainername SCHOOLBOY, JACK1, $0
	checkflag ENGINE_JACK_READY_FOR_REMATCH
	iftrue UnknownScript_0xbd0f3
	farscall PhoneScript_AnswerPhone_Male
	checkflag ENGINE_JACK_MONDAY_MORNING
	iftrue UnknownScript_0xbd0ef
	readvar VAR_WEEKDAY
	ifnotequal MONDAY, UnknownScript_0xbd0ef
	checktime 1 << MORN
	iftrue JackMondayMorning

UnknownScript_0xbd0ef:
	farsjump JackPhoneTipsScript

UnknownScript_0xbd0f3:
	getlandmarkname NATIONAL_PARK, $2
	farsjump JackWantsBattleScript

JackPhoneScript2:
	gettrainername SCHOOLBOY, JACK1, $0
	farscall PhoneScript_GreetPhone_Male
	farscall PhoneScript_Random2
	ifequal $0, JackBattleTrivia
	checkflag ENGINE_JACK_READY_FOR_REMATCH
	iftrue UnknownScript_0xbd11e
	checkflag ENGINE_JACK_MONDAY_MORNING
	iftrue UnknownScript_0xbd11e
	farscall PhoneScript_Random2
	ifequal $0, JackWantsToBattle

UnknownScript_0xbd11e:
	farscall PhoneScript_Random3
	ifequal $0, JackFindsRare
	farsjump Phone_GenericCall_Male

JackMondayMorning:
	setflag ENGINE_JACK_MONDAY_MORNING

JackWantsToBattle:
	getlandmarkname NATIONAL_PARK, $2
	setflag ENGINE_JACK_READY_FOR_REMATCH
	farsjump PhoneScript_WantsToBattle_Male

JackFindsRare:
	farsjump Phone_CheckIfUnseenRare_Male

JackBattleTrivia:
	farsjump JackTriviaScript

; Beverly

BeverlyPhoneScript1:
	gettrainername POKEFANF, BEVERLY1, $0
	farscall PhoneScript_AnswerPhone_Female
	checkflag ENGINE_BEVERLY_HAS_NUGGET
	iftrue UnknownScript_0xbd151
	farsjump BeverlyHangUpScript

UnknownScript_0xbd151:
	getlandmarkname NATIONAL_PARK, $2
	farsjump BeverlyComePickUpScript

BeverlyPhoneScript2:
	gettrainername POKEFANF, BEVERLY1, $0
	farscall PhoneScript_GreetPhone_Female
	checkflag ENGINE_BEVERLY_HAS_NUGGET
	iftrue UnknownScript_0xbd16e
	farscall PhoneScript_Random4
	ifequal $0, UnknownScript_0xbd172

UnknownScript_0xbd16e:
	farsjump Phone_GenericCall_Female

UnknownScript_0xbd172:
	setflag ENGINE_BEVERLY_HAS_NUGGET
	getlandmarkname NATIONAL_PARK, $2
	farsjump PhoneScript_FoundItem_Female

; Huey

HueyPhoneScript1:
	gettrainername SAILOR, HUEY1, $0
	checkflag ENGINE_HUEY_READY_FOR_REMATCH
	iftrue UnknownScript_0xbd1a2
	farscall PhoneScript_AnswerPhone_Male
	checkflag ENGINE_HUEY_WEDNESDAY_NIGHT
	iftrue UnknownScript_0xbd19b
	readvar VAR_WEEKDAY
	ifnotequal WEDNESDAY, UnknownScript_0xbd19b
	checktime (1 << EVE) | (1 << NITE)
	iftrue HueyWednesdayNight

UnknownScript_0xbd19b:
	special RandomPhoneMon
	farsjump HueyHangUpScript

UnknownScript_0xbd1a2:
	getlandmarkname LIGHTHOUSE, $2
	farsjump HueyWantsBattleScript

HueyPhoneScript2:
	gettrainername SAILOR, HUEY1, $0
	farscall PhoneScript_GreetPhone_Male
	checkflag ENGINE_HUEY_READY_FOR_REMATCH
	iftrue UnknownScript_0xbd1c9
	checkflag ENGINE_HUEY_WEDNESDAY_NIGHT
	iftrue UnknownScript_0xbd1c9
	farscall PhoneScript_Random3
	ifequal $0, HueyWantsBattle
	ifequal $1, HueyWantsBattle

UnknownScript_0xbd1c9:
	farsjump PhoneScript_MonFlavorText

HueyWednesdayNight:
	setflag ENGINE_HUEY_WEDNESDAY_NIGHT

HueyWantsBattle:
	getlandmarkname LIGHTHOUSE, $2
	setflag ENGINE_HUEY_READY_FOR_REMATCH
	farsjump PhoneScript_WantsToBattle_Male

; Gaven

GavenPhoneScript1:
	gettrainername COOLTRAINERM, GAVEN1, $0
	checkflag ENGINE_GAVEN_READY_FOR_REMATCH
	iftrue UnknownScript_0xbd1fd
	farscall PhoneScript_AnswerPhone_Male
	checkflag ENGINE_GAVEN_THURSDAY_MORNING
	iftrue UnknownScript_0xbd1f9
	readvar VAR_WEEKDAY
	ifnotequal THURSDAY, UnknownScript_0xbd1f9
	checktime 1 << MORN
	iftrue GavenThursdayMorningScript

UnknownScript_0xbd1f9:
	farsjump GavenHangUpNotThursdayScript

UnknownScript_0xbd1fd:
	getlandmarkname ROUTE_26, $2
	farsjump GavenReminderScript

GavenPhoneScript2:
	gettrainername COOLTRAINERM, GAVEN1, $0
	farscall PhoneScript_GreetPhone_Male
	checkflag ENGINE_GAVEN_READY_FOR_REMATCH
	iftrue UnknownScript_0xbd220
	checkflag ENGINE_GAVEN_THURSDAY_MORNING
	iftrue UnknownScript_0xbd220
	farscall PhoneScript_Random2
	ifequal $0, GavenWantsRematch

UnknownScript_0xbd220:
	farscall PhoneScript_Random3
	ifequal $0, GavenFoundRare
	farsjump Phone_GenericCall_Male

GavenThursdayMorningScript:
	setflag ENGINE_GAVEN_THURSDAY_MORNING

GavenWantsRematch:
	getlandmarkname ROUTE_26, $2
	setflag ENGINE_GAVEN_READY_FOR_REMATCH
	farsjump PhoneScript_WantsToBattle_Male

GavenFoundRare:
	farsjump Phone_CheckIfUnseenRare_Male

; Beth

BethPhoneScript1:
	gettrainername COOLTRAINERF, BETH1, $0
	checkflag ENGINE_BETH_READY_FOR_REMATCH
	iftrue UnknownScript_0xbd260
	farscall PhoneScript_AnswerPhone_Female
	checkflag ENGINE_BETH_FRIDAY_AFTERNOON
	iftrue UnknownScript_0xbd25c
	readvar VAR_WEEKDAY
	ifnotequal FRIDAY, UnknownScript_0xbd25c
	checktime 1 << DAY
	iftrue BethFridayAfternoon

UnknownScript_0xbd25c:
	farsjump BethHangUpScript

UnknownScript_0xbd260:
	getlandmarkname ROUTE_26, $2
	farsjump BethBattleReminderScript

BethPhoneScript2:
	gettrainername COOLTRAINERF, BETH1, $0
	farscall PhoneScript_GreetPhone_Female
	checkflag ENGINE_BETH_READY_FOR_REMATCH
	iftrue UnknownScript_0xbd283
	checkflag ENGINE_BETH_FRIDAY_AFTERNOON
	iftrue UnknownScript_0xbd283
	farscall PhoneScript_Random2
	ifequal $0, BethWantsBattle

UnknownScript_0xbd283:
	farsjump Phone_GenericCall_Female

BethFridayAfternoon:
	setflag ENGINE_BETH_FRIDAY_AFTERNOON

BethWantsBattle:
	getlandmarkname ROUTE_26, $2
	setflag ENGINE_BETH_READY_FOR_REMATCH
	farsjump PhoneScript_WantsToBattle_Female

; Jose

JosePhoneScript1:
	gettrainername BIRD_KEEPER, JOSE2, $0
	checkflag ENGINE_JOSE_READY_FOR_REMATCH
	iftrue UnknownScript_0xbd2bd
	farscall PhoneScript_AnswerPhone_Male
	checkflag ENGINE_JOSE_SATURDAY_NIGHT
	iftrue UnknownScript_0xbd2b9
	checkflag ENGINE_JOSE_HAS_STAR_PIECE
	iftrue UnknownScript_0xbd2c4
	readvar VAR_WEEKDAY
	ifnotequal SATURDAY, UnknownScript_0xbd2b9
	checktime (1 << EVE) | (1 << NITE)
	iftrue JoseSaturdayNight

UnknownScript_0xbd2b9:
	farsjump JoseHangUpScript

UnknownScript_0xbd2bd:
	getlandmarkname ROUTE_27, $2
	farsjump JoseReminderScript

UnknownScript_0xbd2c4:
	getlandmarkname ROUTE_27, $2
	farsjump JoseReminderScript

JosePhoneScript2:
	gettrainername BIRD_KEEPER, JOSE2, $0
	farscall PhoneScript_GreetPhone_Male
	checkflag ENGINE_JOSE_READY_FOR_REMATCH
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
	farsjump Phone_GenericCall_Male

JoseSaturdayNight:
	setflag ENGINE_JOSE_SATURDAY_NIGHT

JoseWantsBattle:
	getlandmarkname ROUTE_27, $2
	setflag ENGINE_JOSE_READY_FOR_REMATCH
	farsjump PhoneScript_WantsToBattle_Male

JoseFoundRare:
	farsjump Phone_CheckIfUnseenRare_Male

JoseHasStarPiece:
	setflag ENGINE_JOSE_HAS_STAR_PIECE
	getlandmarkname ROUTE_27, $2
	farsjump PhoneScript_FoundItem_Male

; Reena

ReenaPhoneScript1:
	gettrainername COOLTRAINERF, REENA1, $0
	checkflag ENGINE_REENA_READY_FOR_REMATCH
	iftrue UnknownScript_0xbd33f
	farscall PhoneScript_AnswerPhone_Female
	checkflag ENGINE_REENA_SUNDAY_MORNING
	iftrue UnknownScript_0xbd33b
	readvar VAR_WEEKDAY
	ifnotequal SUNDAY, UnknownScript_0xbd33b
	checktime 1 << MORN
	iftrue ReenaSundayMorning

UnknownScript_0xbd33b:
	farsjump ReenaForwardScript

UnknownScript_0xbd33f:
	getlandmarkname ROUTE_27, $2
	farsjump ReenaHurryScript

ReenaPhoneScript2:
	gettrainername COOLTRAINERF, REENA1, $0
	farscall PhoneScript_GreetPhone_Female
	checkflag ENGINE_REENA_READY_FOR_REMATCH
	iftrue UnknownScript_0xbd362
	checkflag ENGINE_REENA_SUNDAY_MORNING
	iftrue UnknownScript_0xbd362
	farscall PhoneScript_Random2
	ifequal $0, ReenaWantsBattle

UnknownScript_0xbd362:
	farsjump Phone_GenericCall_Female

ReenaSundayMorning:
	setflag ENGINE_REENA_SUNDAY_MORNING

ReenaWantsBattle:
	getlandmarkname ROUTE_27, $2
	setflag ENGINE_REENA_READY_FOR_REMATCH
	farsjump PhoneScript_WantsToBattle_Female

; Joey

JoeyPhoneScript1:
	gettrainername YOUNGSTER, JOEY1, $0
	checkflag ENGINE_JOEY_READY_FOR_REMATCH
	iftrue UnknownScript_0xbd399
	farscall PhoneScript_AnswerPhone_Male
	checkflag ENGINE_JOEY_MONDAY_AFTERNOON
	iftrue UnknownScript_0xbd392
	readvar VAR_WEEKDAY
	ifnotequal MONDAY, UnknownScript_0xbd392
	checktime 1 << DAY
	iftrue JoeyMondayAfternoon

UnknownScript_0xbd392:
	special RandomPhoneMon
	farwritetext JoeyDevisingStrategiesText
	promptbutton
	farsjump PhoneScript_HangupText_Male

UnknownScript_0xbd399:
	getlandmarkname ROUTE_30, $2
	farsjump JoeyReminderScript

JoeyPhoneScript2:
	gettrainername YOUNGSTER, JOEY1, $0
	farscall PhoneScript_GreetPhone_Male
	checkflag ENGINE_JOEY_READY_FOR_REMATCH
	iftrue UnknownScript_0xbd3c0
	checkflag ENGINE_JOEY_MONDAY_AFTERNOON
	iftrue UnknownScript_0xbd3c0
	farscall PhoneScript_Random3
	ifequal $0, JoeyWantsBattle
	ifequal $1, JoeyWantsBattle

UnknownScript_0xbd3c0:
	farsjump Phone_GenericCall_Male

JoeyMondayAfternoon:
	setflag ENGINE_JOEY_MONDAY_AFTERNOON

JoeyWantsBattle:
	getlandmarkname ROUTE_30, $2
	setflag ENGINE_JOEY_READY_FOR_REMATCH
	farsjump PhoneScript_WantsToBattle_Male

; Wade

WadePhoneScript1:
	gettrainername BUG_CATCHER, WADE1, $0
	checkflag ENGINE_WADE_READY_FOR_REMATCH
	iftrue UnknownScript_0xbd41a
	farscall PhoneScript_AnswerPhone_Male
	checkflag ENGINE_WADE_TUESDAY_NIGHT
	iftrue UnknownScript_0xbd3f6
	checkflag ENGINE_WADE_HAS_ITEM
	iftrue UnknownScript_0xbd421
	readvar VAR_WEEKDAY
	ifnotequal TUESDAY, UnknownScript_0xbd3f6
	checktime (1 << EVE) | (1 << NITE)
	iftrue WadeTuesdayNight

UnknownScript_0xbd3f6:
	farscall PhoneScript_Random2
	ifequal $0, UnknownScript_0xbd412
	checkflag ENGINE_DAILY_BUG_CONTEST
	iftrue UnknownScript_0xbd412
	readvar VAR_WEEKDAY
	ifequal TUESDAY, UnknownScript_0xbd416
	ifequal THURSDAY, UnknownScript_0xbd416
	ifequal SATURDAY, UnknownScript_0xbd416

UnknownScript_0xbd412:
	farsjump WadeNoBerriesScript

UnknownScript_0xbd416:
	farsjump PhoneScript_BugCatchingContest

UnknownScript_0xbd41a:
	getlandmarkname ROUTE_31, $2
	farsjump WadeQuickBattleScript

UnknownScript_0xbd421:
	getlandmarkname ROUTE_31, $2
	farsjump WadeComeQuickScript

WadePhoneScript2:
	gettrainername BUG_CATCHER, WADE1, $0
	farscall PhoneScript_GreetPhone_Male
	farscall PhoneScript_Random2
	ifequal $0, UnknownScript_0xbd44c
	checkflag ENGINE_DAILY_BUG_CONTEST
	iftrue UnknownScript_0xbd44c
	readvar VAR_WEEKDAY
	ifequal TUESDAY, UnknownScript_0xbd480
	ifequal THURSDAY, UnknownScript_0xbd480
	ifequal SATURDAY, UnknownScript_0xbd480

UnknownScript_0xbd44c:
	checkflag ENGINE_WADE_READY_FOR_REMATCH
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
	farsjump Phone_GenericCall_Male

UnknownScript_0xbd480:
	farsjump PhoneScript_BugCatchingContest

WadeTuesdayNight:
	setflag ENGINE_WADE_TUESDAY_NIGHT

WadeWantsBattle2:
	getlandmarkname ROUTE_31, $2
	setflag ENGINE_WADE_READY_FOR_REMATCH
	farsjump PhoneScript_WantsToBattle_Male

WadeFoundRare:
	farsjump Phone_CheckIfUnseenRare_Male

WadeHasItem2:
	setflag ENGINE_WADE_HAS_ITEM
	getlandmarkname ROUTE_31, $2
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
	sjump UnknownScript_0xbd4ce

UnknownScript_0xbd4bf:
	setevent EVENT_WADE_HAS_PECHA_BERRY
	sjump UnknownScript_0xbd4ce

UnknownScript_0xbd4c5:
	setevent EVENT_WADE_HAS_CHERI_BERRY
	sjump UnknownScript_0xbd4ce

UnknownScript_0xbd4cb:
	setevent EVENT_WADE_HAS_PERSIM_BERRY

UnknownScript_0xbd4ce:
	farsjump PhoneScript_FoundItem_Male

; Ralph

RalphPhoneScript1:
	gettrainername FISHER, RALPH1, $0
	checkflag ENGINE_RALPH_READY_FOR_REMATCH
	iftrue Ralph_Rematch
	farscall PhoneScript_AnswerPhone_Male
	checkflag ENGINE_RALPH_WEDNESDAY_MORNING
	iftrue Ralph_CheckSwarm
	readvar VAR_WEEKDAY
	ifnotequal WEDNESDAY, Ralph_CheckSwarm
	checktime 1 << MORN
	iftrue Ralph_WednesdayMorning
Ralph_CheckSwarm:
	checkflag ENGINE_FISH_SWARM
	iftrue Ralph_ReportSwarm
	farsjump RalphNoItemScript

Ralph_Rematch:
	getlandmarkname ROUTE_32, $2
	farsjump RalphReminderScript

Ralph_ReportSwarm:
	getlandmarkname ROUTE_32, $2
	farsjump RalphHurryScript

RalphPhoneScript2:
	gettrainername FISHER, RALPH1, $0
	farscall PhoneScript_GreetPhone_Male
	checkflag ENGINE_FLYPOINT_GOLDENROD
	iffalse Ralph_CheckSwarm2
	checkflag ENGINE_RALPH_READY_FOR_REMATCH
	iftrue Ralph_CheckSwarm2
	checkflag ENGINE_RALPH_WEDNESDAY_MORNING
	iftrue Ralph_CheckSwarm2
	farscall PhoneScript_Random2
	ifequal $0, Ralph_FightMe
Ralph_CheckSwarm2:
	farscall PhoneScript_Random5
	ifequal $0, Ralph_SetUpSwarm
	farsjump Phone_GenericCall_Male

Ralph_WednesdayMorning:
	setflag ENGINE_RALPH_WEDNESDAY_MORNING
Ralph_FightMe:
	getlandmarkname ROUTE_32, $2
	setflag ENGINE_RALPH_READY_FOR_REMATCH
	farsjump PhoneScript_WantsToBattle_Male

Ralph_SetUpSwarm:
	checkflag ENGINE_FISH_SWARM
	iftrue UnknownScript_0xbd55c
	setflag ENGINE_FISH_SWARM
	getmonname QWILFISH, $1
	getlandmarkname ROUTE_32, $2
	setval FISHSWARM_QWILFISH
	special Special_ActivateFishingSwarm
	farsjump RalphItemScript

UnknownScript_0xbd55c:
	farsjump Phone_GenericCall_Male

; Liz

LizPhoneScript1:
	gettrainername PICNICKER, LIZ1, $0
	checkflag ENGINE_LIZ_READY_FOR_REMATCH
	iftrue UnknownScript_0xbd586
	farscall PhoneScript_AnswerPhone_Female
	checkflag ENGINE_LIZ_THURSDAY_AFTERNOON
	iftrue UnknownScript_0xbd57f
	readvar VAR_WEEKDAY
	ifnotequal THURSDAY, UnknownScript_0xbd57f
	checktime 1 << DAY
	iftrue LizThursdayAfternoon

UnknownScript_0xbd57f:
	special RandomPhoneMon
	farsjump LizHangUpScript

UnknownScript_0xbd586:
	getlandmarkname ROUTE_32, $2
	farsjump LizReminderScript

LizPhoneScript2:
	gettrainername PICNICKER, LIZ1, $0
	farscall PhoneScript_Random4
	ifequal $0, LizWrongNumber
	farscall PhoneScript_GreetPhone_Female
	checkflag ENGINE_LIZ_READY_FOR_REMATCH
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
	farsjump Phone_GenericCall_Female

LizThursdayAfternoon:
	setflag ENGINE_LIZ_THURSDAY_AFTERNOON

LizWantsBattle:
	getlandmarkname ROUTE_32, $2
	setflag ENGINE_LIZ_READY_FOR_REMATCH
	farsjump PhoneScript_WantsToBattle_Female

LizWrongNumber:
	farsjump LizWrongNumberScript

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
	gettrainerclassname COOLTRAINERM, $1
	sjump LizGossipScript

UnknownScript_0xbd600:
	gettrainerclassname BEAUTY, $1
	sjump LizGossipScript

UnknownScript_0xbd606:
	gettrainerclassname GRUNTM, $1
	sjump LizGossipScript

UnknownScript_0xbd60c:
	gettrainerclassname TEACHER, $1
	sjump LizGossipScript

UnknownScript_0xbd612:
	gettrainerclassname SWIMMERF, $1
	sjump LizGossipScript

UnknownScript_0xbd618:
	gettrainerclassname KIMONO_GIRL_1, $1
	sjump LizGossipScript

UnknownScript_0xbd61e:
	gettrainerclassname SKIER, $1
	sjump LizGossipScript

UnknownScript_0xbd624:
	gettrainerclassname MEDIUM, $1
	sjump LizGossipScript

UnknownScript_0xbd62a:
	gettrainerclassname POKEFANM, $1
	sjump LizGossipScript

LizGossipScript:
	farsjump LizGossipRandomScript

; Anthony

AnthonyPhoneScript1:
	gettrainername HIKER, ANTHONY1, $0
	checkflag ENGINE_ANTHONY_READY_FOR_REMATCH
	iftrue UnknownScript_0xbd65d
	farscall PhoneScript_AnswerPhone_Male
	checkflag ENGINE_ANTHONY_FRIDAY_NIGHT
	iftrue UnknownScript_0xbd653
	readvar VAR_WEEKDAY
	ifnotequal FRIDAY, UnknownScript_0xbd653
	checktime (1 << EVE) | (1 << NITE)
	iftrue AnthonyFridayNight

UnknownScript_0xbd653:
	checkflag ENGINE_DUNSPARCE_SWARM
	iftrue UnknownScript_0xbd664
	farsjump AnthonyHangUpScript

UnknownScript_0xbd65d:
	getlandmarkname ROUTE_33, $2
	farsjump AnthonyReminderScript

UnknownScript_0xbd664:
	getlandmarkname ROUTE_33, $2
	farsjump AnthonyHurryScript

AnthonyPhoneScript2:
	gettrainername HIKER, ANTHONY1, $0
	farscall PhoneScript_GreetPhone_Male
	checkflag ENGINE_FLYPOINT_GOLDENROD
	iffalse UnknownScript_0xbd68d
	checkflag ENGINE_ANTHONY_READY_FOR_REMATCH
	iftrue UnknownScript_0xbd68d
	checkflag ENGINE_ANTHONY_FRIDAY_NIGHT
	iftrue UnknownScript_0xbd68d
	farscall PhoneScript_Random2
	ifequal $0, AnthonyWantsBattle

UnknownScript_0xbd68d:
	farscall PhoneScript_Random5
	ifequal $0, AnthonyTriesDunsparceSwarm
	farsjump Phone_GenericCall_Male

AnthonyFridayNight:
	setflag ENGINE_ANTHONY_FRIDAY_NIGHT

AnthonyWantsBattle:
	getlandmarkname ROUTE_33, $2
	setflag ENGINE_ANTHONY_READY_FOR_REMATCH
	farsjump PhoneScript_WantsToBattle_Male

AnthonyTriesDunsparceSwarm:
	checkflag ENGINE_DUNSPARCE_SWARM
	iftrue UnknownScript_0xbd6bd
	setflag ENGINE_DUNSPARCE_SWARM
	getmonname DUNSPARCE, $1
	swarm SWARM_DUNSPARCE, DARK_CAVE_VIOLET_ENTRANCE
	getlandmarkname DARK_CAVE, $2
	farsjump AnthonySwarmScript

UnknownScript_0xbd6bd:
	farsjump Phone_GenericCall_Male

; Todd

ToddPhoneScript1:
	gettrainername CAMPER, TODD1, $0
	checkflag ENGINE_TODD_READY_FOR_REMATCH
	iftrue UnknownScript_0xbd6ea
	farscall PhoneScript_AnswerPhone_Male
	checkflag ENGINE_TODD_SATURDAY_MORNING
	iftrue UnknownScript_0xbd6e0
	readvar VAR_WEEKDAY
	ifnotequal SATURDAY, UnknownScript_0xbd6e0
	checktime 1 << MORN
	iftrue ToddSaturdayMorning

UnknownScript_0xbd6e0:
	checkflag ENGINE_GOLDENROD_DEPT_STORE_SALE_IS_ON
	iftrue UnknownScript_0xbd6f1
	farsjump ToddNoItemScript

UnknownScript_0xbd6ea:
	getlandmarkname ROUTE_34, $2
	farsjump ToddForwardScript

UnknownScript_0xbd6f1:
	farsjump ToddHurryScript

ToddPhoneScript2:
	gettrainername CAMPER, TODD1, $0
	farscall PhoneScript_GreetPhone_Male
	checkflag ENGINE_TODD_READY_FOR_REMATCH
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
	farsjump Phone_GenericCall_Male

ToddSaturdayMorning:
	setflag ENGINE_TODD_SATURDAY_MORNING

ToddWantsBattle:
	getlandmarkname ROUTE_34, $2
	setflag ENGINE_TODD_READY_FOR_REMATCH
	farsjump PhoneScript_WantsToBattle_Male

ToddFoundRare:
	farsjump Phone_CheckIfUnseenRare_Male

ToddDeptStoreSale:
	setflag ENGINE_GOLDENROD_DEPT_STORE_SALE_IS_ON
	farsjump ToddItemScript

; Gina

GinaPhoneScript1:
	gettrainername PICNICKER, GINA1, $0
	checkflag ENGINE_GINA_READY_FOR_REMATCH
	iftrue UnknownScript_0xbd776
	farscall PhoneScript_AnswerPhone_Female
	checkflag ENGINE_GINA_SUNDAY_AFTERNOON
	iftrue UnknownScript_0xbd768
	checkflag ENGINE_GINA_HAS_LEAF_STONE
	iftrue UnknownScript_0xbd77d
	readvar VAR_WEEKDAY
	ifnotequal SUNDAY, UnknownScript_0xbd768
	checktime 1 << DAY
	iftrue GinaSundayDay

UnknownScript_0xbd768:
	checkflag ENGINE_ROCKETS_IN_RADIO_TOWER
	iftrue UnknownScript_0xbd772
	farsjump GinaHangUpScript

UnknownScript_0xbd772:
	farsjump GinaRocketRumorScript

UnknownScript_0xbd776:
	getlandmarkname ROUTE_34, $2
	farsjump GinaReminderScript

UnknownScript_0xbd77d:
	getlandmarkname ROUTE_34, $2
	farsjump GinaComePickUpScript

GinaPhoneScript2:
	gettrainername PICNICKER, GINA1, $0
	farscall PhoneScript_GreetPhone_Female
	checkflag ENGINE_ROCKETS_IN_RADIO_TOWER
	iftrue GinaRockets
	checkflag ENGINE_GINA_READY_FOR_REMATCH
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
	farsjump Phone_GenericCall_Female

GinaSundayDay:
	setflag ENGINE_GINA_SUNDAY_AFTERNOON

GinaWantsBattle:
	getlandmarkname ROUTE_34, $2
	setflag ENGINE_GINA_READY_FOR_REMATCH
	farsjump PhoneScript_WantsToBattle_Female

GinaRockets:
	farsjump GinaRocketRumorScript

GinaHasLeafStone:
	setflag ENGINE_GINA_HAS_LEAF_STONE
	getlandmarkname ROUTE_34, $2
	farsjump PhoneScript_FoundItem_Female

; Irwin

IrwinPhoneScript1:
	gettrainername JUGGLER, IRWIN1, $0
	farscall PhoneScript_AnswerPhone_Male
	checkflag ENGINE_ROCKETS_IN_RADIO_TOWER
	iftrue UnknownScript_0xbd7f9
	farsjump IrwinRandomTextScript

UnknownScript_0xbd7f9:
	farsjump IrwinRocketRumorScript

IrwinPhoneScript2:
	gettrainername JUGGLER, IRWIN1, $0
	farscall PhoneScript_GreetPhone_Male
	checkflag ENGINE_ROCKETS_IN_RADIO_TOWER
	iftrue UnknownScript_0xbd80f
	farsjump IrwinRumorScript

UnknownScript_0xbd80f:
	farsjump IrwinRocketRumorScript

; Arnie

ArniePhoneScript1:
	gettrainername BUG_CATCHER, ARNIE1, $0
	checkflag ENGINE_ARNIE_READY_FOR_REMATCH
	iftrue UnknownScript_0xbd83c
	farscall PhoneScript_AnswerPhone_Male
	checkflag ENGINE_ARNIE_TUESDAY_MORNING
	iftrue UnknownScript_0xbd832
	readvar VAR_WEEKDAY
	ifnotequal TUESDAY, UnknownScript_0xbd832
	checktime 1 << MORN
	iftrue ArnieTuesdayMorning

UnknownScript_0xbd832:
	checkflag ENGINE_YANMA_SWARM
	iftrue UnknownScript_0xbd843
	farsjump ArnieHangUpScript

UnknownScript_0xbd83c:
	getlandmarkname ROUTE_35, $2
	farsjump ArnieReminderScript

UnknownScript_0xbd843:
	getlandmarkname ROUTE_35, $2
	farsjump ArnieHurryScript

ArniePhoneScript2:
	gettrainername BUG_CATCHER, ARNIE1, $0
	farscall PhoneScript_GreetPhone_Male
	checkflag ENGINE_ARNIE_READY_FOR_REMATCH
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
	farsjump Phone_GenericCall_Male

ArnieTuesdayMorning:
	setflag ENGINE_ARNIE_TUESDAY_MORNING

ArnieWantsBattle:
	getlandmarkname ROUTE_35, $2
	setflag ENGINE_ARNIE_READY_FOR_REMATCH
	farsjump PhoneScript_WantsToBattle_Male

ArnieYanmaSwarm: ; start swarm
	checkflag ENGINE_YANMA_SWARM
	iftrue ArnieYanmaAlreadySwarming
	setflag ENGINE_YANMA_SWARM
	getmonname YANMA, $1
	swarm SWARM_YANMA, ROUTE_35
	getlandmarkname ROUTE_35, $2
	farsjump ArnieSwarmScript

ArnieFoundRare:
	farsjump Phone_CheckIfUnseenRare_Male

ArnieYanmaAlreadySwarming:
	farsjump Phone_GenericCall_Male

; Alan

AlanPhoneScript1:
	gettrainername SCHOOLBOY, ALAN1, $0
	checkflag ENGINE_ALAN_READY_FOR_REMATCH
	iftrue UnknownScript_0xbd8cf
	farscall PhoneScript_AnswerPhone_Male
	checkflag ENGINE_ALAN_WEDNESDAY_AFTERNOON
	iftrue UnknownScript_0xbd8cb
	checkflag ENGINE_ALAN_HAS_FIRE_STONE
	iftrue UnknownScript_0xbd8d6
	readvar VAR_WEEKDAY
	ifnotequal WEDNESDAY, UnknownScript_0xbd8cb
	checktime 1 << DAY
	iftrue AlanWednesdayDay

UnknownScript_0xbd8cb:
	farsjump AlanHangUpScript

UnknownScript_0xbd8cf:
	getlandmarkname ROUTE_36, $2
	farsjump AlanReminderScript

UnknownScript_0xbd8d6:
	getlandmarkname ROUTE_36, $2
	farsjump AlanComePickUpScript

AlanPhoneScript2:
	gettrainername SCHOOLBOY, ALAN1, $0
	farscall PhoneScript_GreetPhone_Male
	checkflag ENGINE_ALAN_READY_FOR_REMATCH
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
	farsjump Phone_GenericCall_Male

AlanWednesdayDay:
	setflag ENGINE_ALAN_WEDNESDAY_AFTERNOON

AlanWantsBattle:
	getlandmarkname ROUTE_36, $2
	setflag ENGINE_ALAN_READY_FOR_REMATCH
	farsjump PhoneScript_WantsToBattle_Male

AlanHasFireStone:
	setflag ENGINE_ALAN_HAS_FIRE_STONE
	getlandmarkname ROUTE_36, $2
	farsjump PhoneScript_FoundItem_Male

; Dana

DanaPhoneScript1:
	gettrainername LASS, DANA1, $0
	checkflag ENGINE_DANA_READY_FOR_REMATCH
	iftrue UnknownScript_0xbd959
	farscall PhoneScript_AnswerPhone_Female
	checkflag ENGINE_DANA_THURSDAY_NIGHT
	iftrue UnknownScript_0xbd955
	checkflag ENGINE_DANA_HAS_THUNDERSTONE
	iftrue UnknownScript_0xbd960
	readvar VAR_WEEKDAY
	ifnotequal THURSDAY, UnknownScript_0xbd955
	checktime (1 << EVE) | (1 << NITE)
	iftrue DanaThursdayNight

UnknownScript_0xbd955:
	farsjump DanaHangUpScript

UnknownScript_0xbd959:
	getlandmarkname ROUTE_38, $2
	farsjump DanaReminderScript

UnknownScript_0xbd960:
	getlandmarkname ROUTE_38, $2
	farsjump DanaComePickUpScript

DanaPhoneScript2:
	gettrainername LASS, DANA1, $0
	farscall PhoneScript_GreetPhone_Female
	checkflag ENGINE_DANA_READY_FOR_REMATCH
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
	farsjump Phone_GenericCall_Female

DanaThursdayNight:
	setflag ENGINE_DANA_THURSDAY_NIGHT

DanaWantsBattle:
	getlandmarkname ROUTE_38, $2
	setflag ENGINE_DANA_READY_FOR_REMATCH
	farsjump PhoneScript_WantsToBattle_Female

DanaFoundRare:
	farsjump Phone_CheckIfUnseenRare_Female

DanaHasThunderstone:
	setflag ENGINE_DANA_HAS_THUNDERSTONE
	getlandmarkname ROUTE_38, $2
	farsjump PhoneScript_FoundItem_Female

; Chad

ChadPhoneScript1:
	gettrainername SCHOOLBOY, CHAD1, $0
	checkflag ENGINE_CHAD_READY_FOR_REMATCH
	iftrue UnknownScript_0xbd9e9
	farscall PhoneScript_AnswerPhone_Male
	checkflag ENGINE_CHAD_FRIDAY_MORNING
	iftrue UnknownScript_0xbd9e5
	readvar VAR_WEEKDAY
	ifnotequal FRIDAY, UnknownScript_0xbd9e5
	checktime 1 << MORN
	iftrue ChadFridayMorning

UnknownScript_0xbd9e5:
	farsjump ChadHangUpScript

UnknownScript_0xbd9e9:
	getlandmarkname ROUTE_38, $2
	farsjump ChadReminderScript

ChadPhoneScript2:
	gettrainername SCHOOLBOY, CHAD1, $0
	farscall PhoneScript_GreetPhone_Male
	farscall PhoneScript_Random2
	ifequal $0, ChadOakGossip
	checkflag ENGINE_CHAD_READY_FOR_REMATCH
	iftrue UnknownScript_0xbda14
	checkflag ENGINE_CHAD_FRIDAY_MORNING
	iftrue UnknownScript_0xbda14
	farscall PhoneScript_Random2
	ifequal $0, ChadWantsBattle

UnknownScript_0xbda14:
	farscall PhoneScript_Random3
	ifequal $0, ChadFoundRare
	farsjump Phone_GenericCall_Male

ChadFridayMorning:
	setflag ENGINE_CHAD_FRIDAY_MORNING

ChadWantsBattle:
	getlandmarkname ROUTE_38, $2
	setflag ENGINE_CHAD_READY_FOR_REMATCH
	farsjump PhoneScript_WantsToBattle_Male

ChadFoundRare:
	farsjump Phone_CheckIfUnseenRare_Male

ChadOakGossip:
	farsjump ChadOakGossipScript

DerekPhoneScript1:
	gettrainername POKEFANM, DEREK1, $0
	farscall PhoneScript_AnswerPhone_Male
	checkflag ENGINE_DEREK_HAS_NUGGET
	iftrue UnknownScript_0xbda67
	farscall PhoneScript_Random2
	ifequal $0, UnknownScript_0xbda5f
	checkflag ENGINE_DAILY_BUG_CONTEST
	iftrue UnknownScript_0xbda5f
	readvar VAR_WEEKDAY
	ifequal TUESDAY, UnknownScript_0xbda63
	ifequal THURSDAY, UnknownScript_0xbda63
	ifequal SATURDAY, UnknownScript_0xbda63

UnknownScript_0xbda5f:
	farsjump DerekHangUpScript

UnknownScript_0xbda63:
	farsjump PhoneScript_BugCatchingContest

UnknownScript_0xbda67:
	getlandmarkname ROUTE_39, $2
	farsjump DerekComePickUpScript

DerekPhoneScript2:
	gettrainername POKEFANM, DEREK1, $0
	farscall PhoneScript_GreetPhone_Male
	farscall PhoneScript_Random2
	ifequal $0, UnknownScript_0xbda92
	checkflag ENGINE_DAILY_BUG_CONTEST
	iftrue UnknownScript_0xbda92
	readvar VAR_WEEKDAY
	ifequal TUESDAY, UnknownScript_0xbda9e
	ifequal THURSDAY, UnknownScript_0xbda9e
	ifequal SATURDAY, UnknownScript_0xbda9e

UnknownScript_0xbda92:
	farscall PhoneScript_Random4
	ifequal $0, UnknownScript_0xbdaa2
	farsjump Phone_GenericCall_Male

UnknownScript_0xbda9e:
	farsjump PhoneScript_BugCatchingContest

UnknownScript_0xbdaa2:
	setflag ENGINE_DEREK_HAS_NUGGET
	getlandmarkname ROUTE_39, $2
	farsjump PhoneScript_FoundItem_Male

TullyPhoneScript1:
	gettrainername FISHER, TULLY1, $0
	checkflag ENGINE_TULLY_READY_FOR_REMATCH
	iftrue UnknownScript_0xbdad5
	farscall PhoneScript_AnswerPhone_Male
	checkflag ENGINE_TULLY_SUNDAY_NIGHT
	iftrue UnknownScript_0xbdad1
	checkflag ENGINE_TULLY_HAS_WATER_STONE
	iftrue UnknownScript_0xbdadc
	readvar VAR_WEEKDAY
	ifnotequal SUNDAY, UnknownScript_0xbdad1
	checktime (1 << EVE) | (1 << NITE)
	iftrue TullySundayNight

UnknownScript_0xbdad1:
	farsjump TullyNoItemScript

UnknownScript_0xbdad5:
	getlandmarkname ROUTE_42, $2
	farsjump TullyForwardScript

UnknownScript_0xbdadc:
	getlandmarkname ROUTE_42, $2
	farsjump TullyHurryScript

TullyPhoneScript2:
	gettrainername FISHER, TULLY1, $0
	farscall PhoneScript_GreetPhone_Male
	checkflag ENGINE_TULLY_READY_FOR_REMATCH
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
	farsjump Phone_GenericCall_Male

TullySundayNight:
	setflag ENGINE_TULLY_SUNDAY_NIGHT

TullyWantsBattle:
	getlandmarkname ROUTE_42, $2
	setflag ENGINE_TULLY_READY_FOR_REMATCH
	farsjump PhoneScript_WantsToBattle_Male

TullyFoundWaterStone:
	setflag ENGINE_TULLY_HAS_WATER_STONE
	getlandmarkname ROUTE_42, $2
	farsjump PhoneScript_FoundItem_Male

BrentPhoneScript1:
	gettrainername POKEMANIAC, BRENT1, $0
	checkflag ENGINE_BRENT_READY_FOR_REMATCH
	iftrue UnknownScript_0xbdb59
	farscall PhoneScript_AnswerPhone_Male
	checkflag ENGINE_BRENT_MONDAY_MORNING
	iftrue UnknownScript_0xbdb55
	readvar VAR_WEEKDAY
	ifnotequal MONDAY, UnknownScript_0xbdb55
	checktime 1 << MORN
	iftrue BrentMondayMorning

UnknownScript_0xbdb55:
	farsjump BrentHangUpScript

UnknownScript_0xbdb59:
	getlandmarkname ROUTE_43, $2
	farsjump BrentReminderScript

BrentPhoneScript2:
	gettrainername POKEMANIAC, BRENT1, $0
	farscall PhoneScript_GreetPhone_Male
	farscall PhoneScript_Random2
	ifequal $0, BrentBillTrivia
	checkflag ENGINE_BRENT_READY_FOR_REMATCH
	iftrue UnknownScript_0xbdb84
	checkflag ENGINE_BRENT_MONDAY_MORNING
	iftrue UnknownScript_0xbdb84
	farscall PhoneScript_Random2
	ifequal $0, BrentWantsBattle

UnknownScript_0xbdb84:
	farsjump Phone_GenericCall_Male

BrentMondayMorning:
	setflag ENGINE_BRENT_MONDAY_MORNING

BrentWantsBattle:
	getlandmarkname ROUTE_43, $2
	setflag ENGINE_BRENT_READY_FOR_REMATCH
	farsjump PhoneScript_WantsToBattle_Male

BrentBillTrivia:
	farsjump BrentBillTriviaScript

TiffanyPhoneScript1:
	gettrainername PICNICKER, TIFFANY1, $0
	checkflag ENGINE_TIFFANY_READY_FOR_REMATCH
	iftrue UnknownScript_0xbdbc2
	farscall PhoneScript_AnswerPhone_Female
	checkflag ENGINE_TIFFANY_TUESDAY_AFTERNOON
	iftrue UnknownScript_0xbdbbe
	checkflag ENGINE_TIFFANY_HAS_PINK_BOW
	iftrue UnknownScript_0xbdbc9
	readvar VAR_WEEKDAY
	ifnotequal TUESDAY, UnknownScript_0xbdbbe
	checktime 1 << DAY
	iftrue TiffanyTuesdayAfternoon

UnknownScript_0xbdbbe:
	farsjump TiffanyNoItemScript

UnknownScript_0xbdbc2:
	getlandmarkname ROUTE_43, $2
	farsjump TiffanyAsleepScript

UnknownScript_0xbdbc9:
	getlandmarkname ROUTE_43, $2
	farsjump TiffanyHurryScript

TiffanyPhoneScript2:
	gettrainername PICNICKER, TIFFANY1, $0
	farscall PhoneScript_Random4
	ifequal $0, TiffanysFamilyMembers
	farscall PhoneScript_GreetPhone_Female
	checkflag ENGINE_TIFFANY_READY_FOR_REMATCH
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
	farsjump Phone_GenericCall_Female

TiffanyTuesdayAfternoon:
	setflag ENGINE_TIFFANY_TUESDAY_AFTERNOON

TiffanyWantsBattle:
	getlandmarkname ROUTE_43, $2
	setflag ENGINE_TIFFANY_READY_FOR_REMATCH
	farsjump PhoneScript_WantsToBattle_Female

TiffanysFamilyMembers:
	random $6
	ifequal $0, UnknownScript_0xbdc3b
	ifequal $1, UnknownScript_0xbdc42
	ifequal $2, UnknownScript_0xbdc49
	ifequal $3, UnknownScript_0xbdc50
	ifequal $4, UnknownScript_0xbdc57
	ifequal $5, UnknownScript_0xbdc5e

UnknownScript_0xbdc3b:
	getstring Phone_GrandmaString, $1
	sjump UnknownScript_0xbdc65

UnknownScript_0xbdc42:
	getstring Phone_GrandpaString, $1
	sjump UnknownScript_0xbdc65

UnknownScript_0xbdc49:
	getstring Phone_MomString, $1
	sjump UnknownScript_0xbdc65

UnknownScript_0xbdc50:
	getstring Phone_DadString, $1
	sjump UnknownScript_0xbdc65

UnknownScript_0xbdc57:
	getstring Phone_SisterString, $1
	sjump UnknownScript_0xbdc65

UnknownScript_0xbdc5e:
	getstring Phone_BrotherString, $1
	sjump UnknownScript_0xbdc65

UnknownScript_0xbdc65:
	farsjump TiffanyItsAwful

TiffanyHasPinkBow:
	setflag ENGINE_TIFFANY_HAS_PINK_BOW
	getlandmarkname ROUTE_43, $2
	farsjump PhoneScript_FoundItem_Female

; Vance

VancePhoneScript1:
	gettrainername BIRD_KEEPER, VANCE1, $0
	checkflag ENGINE_VANCE_READY_FOR_REMATCH
	iftrue UnknownScript_0xbdc96
	farscall PhoneScript_AnswerPhone_Male
	checkflag ENGINE_VANCE_WEDNESDAY_NIGHT
	iftrue UnknownScript_0xbdc92
	readvar VAR_WEEKDAY
	ifnotequal WEDNESDAY, UnknownScript_0xbdc92
	checktime (1 << EVE) | (1 << NITE)
	iftrue VanceWednesdayNight

UnknownScript_0xbdc92:
	farsjump VanceLookingForwardScript

UnknownScript_0xbdc96:
	getlandmarkname ROUTE_44, $2
	farsjump VanceHurryHurryScript

VancePhoneScript2:
	gettrainername BIRD_KEEPER, VANCE1, $0
	farscall PhoneScript_GreetPhone_Male
	checkflag ENGINE_VANCE_READY_FOR_REMATCH
	iftrue UnknownScript_0xbdcbd
	checkflag ENGINE_VANCE_WEDNESDAY_NIGHT
	iftrue UnknownScript_0xbdcbd
	farscall PhoneScript_Random3
	ifequal $0, VanceWantsRematch
	ifequal $1, VanceWantsRematch

UnknownScript_0xbdcbd:
	farsjump Phone_GenericCall_Male

VanceWednesdayNight:
	setflag ENGINE_VANCE_WEDNESDAY_NIGHT

VanceWantsRematch:
	getlandmarkname ROUTE_44, $2
	setflag ENGINE_VANCE_READY_FOR_REMATCH
	farsjump PhoneScript_WantsToBattle_Male

WiltonPhoneScript1:
	gettrainername FISHER, WILTON1, $0
	checkflag ENGINE_WILTON_READY_FOR_REMATCH
	iftrue UnknownScript_0xbdcf7
	farscall PhoneScript_AnswerPhone_Male
	checkflag ENGINE_WILTON_THRUSDAY_MORNING
	iftrue UnknownScript_0xbdcf3
	checkflag ENGINE_WILTON_HAS_ITEM
	iftrue UnknownScript_0xbdcfe
	readvar VAR_WEEKDAY
	ifnotequal THURSDAY, UnknownScript_0xbdcf3
	checktime 1 << MORN
	iftrue WiltonThursdayMorning

UnknownScript_0xbdcf3:
	farsjump WiltonHaventFoundAnythingScript

UnknownScript_0xbdcf7:
	getlandmarkname ROUTE_44, $2
	farsjump WiltonNotBitingScript

UnknownScript_0xbdcfe:
	getlandmarkname ROUTE_44, $2
	farsjump WiltonWantThisScript

WiltonPhoneScript2:
	gettrainername FISHER, WILTON1, $0
	farscall PhoneScript_GreetPhone_Male
	checkflag ENGINE_WILTON_READY_FOR_REMATCH
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
	farsjump Phone_GenericCall_Male

WiltonThursdayMorning:
	setflag ENGINE_WILTON_THRUSDAY_MORNING

WiltonWantsBattle:
	getlandmarkname ROUTE_44, $2
	setflag ENGINE_WILTON_READY_FOR_REMATCH
	farsjump PhoneScript_WantsToBattle_Male

WiltonHasItem:
	setflag ENGINE_WILTON_HAS_ITEM
	getlandmarkname ROUTE_44, $2
	clearevent EVENT_WILTON_HAS_ULTRA_BALL
	clearevent EVENT_WILTON_HAS_GREAT_BALL
	clearevent EVENT_WILTON_HAS_POKE_BALL
	random $5
	ifequal $0, UnknownScript_0xbdd5e
	random $3
	ifequal $0, UnknownScript_0xbdd64
	sjump UnknownScript_0xbdd6a

UnknownScript_0xbdd5e:
	setevent EVENT_WILTON_HAS_ULTRA_BALL
	sjump UnknownScript_0xbdd6d

UnknownScript_0xbdd64:
	setevent EVENT_WILTON_HAS_GREAT_BALL
	sjump UnknownScript_0xbdd6d

UnknownScript_0xbdd6a:
	setevent EVENT_WILTON_HAS_POKE_BALL

UnknownScript_0xbdd6d:
	farsjump PhoneScript_FoundItem_Male

; Kenji

KenjiPhoneScript1:
	gettrainername BLACKBELT_T, KENJI1, $0
	farscall PhoneScript_AnswerPhone_Male
	farsjump KenjiAnswerPhoneScript

KenjiPhoneScript2:
	gettrainername BLACKBELT_T, KENJI1, $0
	farscall PhoneScript_GreetPhone_Male
	farsjump KenjiCallingPhoneScript

; Parry

ParryPhoneScript1:
	gettrainername HIKER, PARRY1, $0
	checkflag ENGINE_PARRY_READY_FOR_REMATCH
	iftrue UnknownScript_0xbddac
	farscall PhoneScript_AnswerPhone_Male
	checkflag ENGINE_PARRY_FRIDAY_AFTERNOON
	iftrue UnknownScript_0xbdda8
	readvar VAR_WEEKDAY
	ifnotequal FRIDAY, UnknownScript_0xbdda8
	checktime 1 << DAY
	iftrue ParryFridayDay

UnknownScript_0xbdda8:
	farsjump ParryBattleWithMeScript

UnknownScript_0xbddac:
	getlandmarkname ROUTE_45, $2
	farsjump ParryHaventYouGottenToScript

ParryPhoneScript2:
	gettrainername HIKER, PARRY1, $0
	farscall PhoneScript_GreetPhone_Male
	checkflag ENGINE_PARRY_READY_FOR_REMATCH
	iftrue UnknownScript_0xbddd3
	checkflag ENGINE_PARRY_FRIDAY_AFTERNOON
	iftrue UnknownScript_0xbddd3
	farscall PhoneScript_Random2
	ifequal $0, ParryWantsBattle
	ifequal $1, ParryWantsBattle

UnknownScript_0xbddd3:
	farsjump Phone_GenericCall_Male

ParryFridayDay:
	setflag ENGINE_PARRY_FRIDAY_AFTERNOON

ParryWantsBattle:
	getlandmarkname ROUTE_45, $2
	setflag ENGINE_PARRY_READY_FOR_REMATCH
	farsjump PhoneScript_WantsToBattle_Male

; Erin

ErinPhoneScript1:
	gettrainername PICNICKER, ERIN1, $0
	checkflag ENGINE_ERIN_READY_FOR_REMATCH
	iftrue UnknownScript_0xbde07
	farscall PhoneScript_AnswerPhone_Female
	checkflag ENGINE_ERIN_SATURDAY_NIGHT
	iftrue UnknownScript_0xbde03
	readvar VAR_WEEKDAY
	ifnotequal SATURDAY, UnknownScript_0xbde03
	checktime (1 << EVE) | (1 << NITE)
	iftrue ErinSaturdayNight

UnknownScript_0xbde03:
	farsjump ErinWorkingHardScript

UnknownScript_0xbde07:
	getlandmarkname ROUTE_46, $2
	farsjump ErinComeBattleScript

ErinPhoneScript2:
	gettrainername PICNICKER, ERIN1, $0
	farscall PhoneScript_GreetPhone_Female
	checkflag ENGINE_ERIN_READY_FOR_REMATCH
	iftrue UnknownScript_0xbde2e
	checkflag ENGINE_ERIN_SATURDAY_NIGHT
	iftrue UnknownScript_0xbde2e
	farscall PhoneScript_Random3
	ifequal $0, ErinWantsBattle
	ifequal $1, ErinWantsBattle

UnknownScript_0xbde2e:
	farsjump Phone_GenericCall_Female

ErinSaturdayNight:
	setflag ENGINE_ERIN_SATURDAY_NIGHT

ErinWantsBattle:
	getlandmarkname ROUTE_46, $2
	setflag ENGINE_ERIN_READY_FOR_REMATCH
	farsjump PhoneScript_WantsToBattle_Female

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
	readvar VAR_CALLERID
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
	promptbutton
	end

.Huey:
	farwritetext HueyAnswerPhoneText
	promptbutton
	end

.Gaven:
	farwritetext GavenAnswerPhoneText
	promptbutton
	end

.Jose:
	farwritetext JoseAnswerPhoneText
	promptbutton
	end

.Joey:
	farwritetext JoeyAnswerPhoneText
	promptbutton
	end

.Wade:
	farwritetext WadeAnswerPhoneText
	promptbutton
	end

.Ralph:
	farwritetext RalphAnswerPhoneText
	promptbutton
	end

.Anthony:
	farwritetext AnthonyAnswerPhoneText
	promptbutton
	end

.Todd:
	farwritetext ToddAnswerPhoneText
	promptbutton
	end

.Irwin:
	farwritetext IrwinAnswerPhoneText
	promptbutton
	end

.Arnie:
	farwritetext ArnieAnswerPhoneText
	promptbutton
	end

.Alan:
	farwritetext AlanAnswerPhoneText
	promptbutton
	end

.Chad:
	farwritetext ChadAnswerPhoneText
	promptbutton
	end

.Derek:
	farwritetext DerekAnswerPhoneText
	promptbutton
	end

.Tully:
	farwritetext TullyAnswerPhoneText
	promptbutton
	end

.Brent:
	farwritetext BrentAnswerPhoneText
	promptbutton
	end

.Vance:
	farwritetext VanceAnswerPhoneText
	promptbutton
	end

.Wilton:
	farwritetext WiltonAnswerPhoneText
	promptbutton
	end

.Kenji:
	farwritetext KenjiAnswerPhoneText
	promptbutton
	end

.Parry:
	farwritetext ParryAnswerPhoneText
	promptbutton
	end

PhoneScript_AnswerPhone_Male_Day:
	readvar VAR_CALLERID
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
	promptbutton
	end

.Huey:
	farwritetext HueyAnswerPhoneDayText
	promptbutton
	end

.Gaven:
	farwritetext GavenAnswerPhoneDayText
	promptbutton
	end

.Jose:
	farwritetext JoseAnswerPhoneDayText
	promptbutton
	end

.Joey:
	farwritetext JoeyAnswerPhoneDayText
	promptbutton
	end

.Wade:
	farwritetext WadeAnswerPhoneDayText
	promptbutton
	end

.Ralph:
	farwritetext RalphAnswerPhoneDayText
	promptbutton
	end

.Anthony:
	farwritetext AnthonyAnswerPhoneDayText
	promptbutton
	end

.Todd:
	farwritetext ToddAnswerPhoneDayText
	promptbutton
	end

.Irwin:
	farwritetext IrwinAnswerPhoneDayText
	promptbutton
	end

.Arnie:
	farwritetext ArnieAnswerPhoneDayText
	promptbutton
	end

.Alan:
	farwritetext AlanAnswerPhoneDayText
	promptbutton
	end

.Chad:
	farwritetext ChadAnswerPhoneDayText
	promptbutton
	end

.Derek:
	farwritetext DerekAnswerPhoneDayText
	promptbutton
	end

.Tully:
	farwritetext TullyAnswerPhoneDayText
	promptbutton
	end

.Brent:
	farwritetext BrentAnswerPhoneDayText
	promptbutton
	end

.Vance:
	farwritetext VanceAnswerPhoneDayText
	promptbutton
	end

.Wilton:
	farwritetext WiltonAnswerPhoneDayText
	promptbutton
	end

.Kenji:
	farwritetext KenjiAnswerPhoneDayText
	promptbutton
	end

.Parry:
	farwritetext ParryAnswerPhoneDayText
	promptbutton
	end

PhoneScript_AnswerPhone_Male_Nite:
	readvar VAR_CALLERID
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
	promptbutton
	end

.Huey:
	farwritetext HueyAnswerPhoneNiteText
	promptbutton
	end

.Gaven:
	farwritetext GavenAnswerPhoneNiteText
	promptbutton
	end

.Jose:
	farwritetext JoseAnswerPhoneNiteText
	promptbutton
	end

.Joey:
	farwritetext JoeyAnswerPhoneNiteText
	promptbutton
	end

.Wade:
	farwritetext WadeAnswerPhoneNiteText
	promptbutton
	end

.Ralph:
	farwritetext RalphAnswerPhoneNiteText
	promptbutton
	end

.Anthony:
	farwritetext AnthonyAnswerPhoneNiteText
	promptbutton
	end

.Todd:
	farwritetext ToddAnswerPhoneNiteText
	promptbutton
	end

.Irwin:
	farwritetext IrwinAnswerPhoneNiteText
	promptbutton
	end

.Arnie:
	farwritetext ArnieAnswerPhoneNiteText
	promptbutton
	end

.Alan:
	farwritetext AlanAnswerPhoneNiteText
	promptbutton
	end

.Chad:
	farwritetext ChadAnswerPhoneNiteText
	promptbutton
	end

.Derek:
	farwritetext DerekAnswerPhoneNiteText
	promptbutton
	end

.Tully:
	farwritetext TullyAnswerPhoneNiteText
	promptbutton
	end

.Brent:
	farwritetext BrentAnswerPhoneNiteText
	promptbutton
	end

.Vance:
	farwritetext VanceAnswerPhoneNiteText
	promptbutton
	end

.Wilton:
	farwritetext WiltonAnswerPhoneNiteText
	promptbutton
	end

.Kenji:
	farwritetext KenjiAnswerPhoneNiteText
	promptbutton
	end

.Parry:
	farwritetext ParryAnswerPhoneNiteText
	promptbutton
	end

PhoneScript_AnswerPhone_Female:
	checktime 1 << DAY
	iftrue PhoneScript_AnswerPhone_Female_Day
	checktime (1 << EVE) | (1 << NITE)
	iftrue PhoneScript_AnswerPhone_Female_Nite
	readvar VAR_CALLERID
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
	promptbutton
	end

.Beth:
	farwritetext BethAnswerPhoneText
	promptbutton
	end

.Reena:
	farwritetext ReenaAnswerPhoneText
	promptbutton
	end

.Liz:
	farwritetext LizAnswerPhoneText
	promptbutton
	end

.Gina:
	farwritetext GinaAnswerPhoneText
	promptbutton
	end

.Dana:
	farwritetext DanaAnswerPhoneText
	promptbutton
	end

.Tiffany:
	farwritetext TiffanyAnswerPhoneText
	promptbutton
	end

.Erin:
	farwritetext ErinAnswerPhoneText
	promptbutton
	end

PhoneScript_AnswerPhone_Female_Day:
	readvar VAR_CALLERID
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
	promptbutton
	end

.Beth:
	farwritetext BethAnswerPhoneDayText
	promptbutton
	end

.Reena:
	farwritetext ReenaAnswerPhoneDayText
	promptbutton
	end

.Liz:
	farwritetext LizAnswerPhoneDayText
	promptbutton
	end

.Gina:
	farwritetext GinaAnswerPhoneDayText
	promptbutton
	end

.Dana:
	farwritetext DanaAnswerPhoneDayText
	promptbutton
	end

.Tiffany:
	farwritetext TiffanyAnswerPhoneDayText
	promptbutton
	end

.Erin:
	farwritetext ErinAnswerPhoneDayText
	promptbutton
	end

PhoneScript_AnswerPhone_Female_Nite:
	readvar VAR_CALLERID
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
	promptbutton
	end

.Beth:
	farwritetext BethAnswerPhoneNiteText
	promptbutton
	end

.Reena:
	farwritetext ReenaAnswerPhoneNiteText
	promptbutton
	end

.Liz:
	farwritetext LizAnswerPhoneNiteText
	promptbutton
	end

.Gina:
	farwritetext GinaAnswerPhoneNiteText
	promptbutton
	end

.Dana:
	farwritetext DanaAnswerPhoneNiteText
	promptbutton
	end

.Tiffany:
	farwritetext TiffanyAnswerPhoneNiteText
	promptbutton
	end

.Erin:
	farwritetext ErinAnswerPhoneNiteText
	promptbutton
	end

PhoneScript_GreetPhone_Male:
	checktime 1 << DAY
	iftrue PhoneScript_GreetPhone_Male_Day
	checktime (1 << EVE) | (1 << NITE)
	iftrue PhoneScript_GreetPhone_Male_Nite
	readvar VAR_CALLERID
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
	promptbutton
	end

.Huey:
	farwritetext HueyGreetText
	promptbutton
	end

.Gaven:
	farwritetext GavenGreetText
	promptbutton
	end

.Jose:
	farwritetext JoseGreetText
	promptbutton
	end

.Joey:
	farwritetext JoeyGreetText
	promptbutton
	end

.Wade:
	farwritetext WadeGreetText
	promptbutton
	end

.Ralph:
	farwritetext RalphGreetText
	promptbutton
	end

.Anthony:
	farwritetext AnthonyGreetText
	promptbutton
	end

.Todd:
	farwritetext ToddGreetText
	promptbutton
	end

.Irwin:
	farwritetext IrwinGreetText
	promptbutton
	end

.Arnie:
	farwritetext ArnieGreetText
	promptbutton
	end

.Alan:
	farwritetext AlanGreetText
	promptbutton
	end

.Chad:
	farwritetext ChadGreetText
	promptbutton
	end

.Derek:
	farwritetext DerekGreetText
	promptbutton
	end

.Tully:
	farwritetext TullyGreetText
	promptbutton
	end

.Brent:
	farwritetext BrentGreetText
	promptbutton
	end

.Vance:
	farwritetext VanceGreetText
	promptbutton
	end

.Wilton:
	farwritetext WiltonGreetText
	promptbutton
	end

.Kenji:
	farwritetext KenjiGreetText
	promptbutton
	end

.Parry:
	farwritetext ParryGreetText
	promptbutton
	end

PhoneScript_GreetPhone_Male_Day:
	readvar VAR_CALLERID
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
	promptbutton
	end

.Huey:
	farwritetext HueyGreetDayText
	promptbutton
	end

.Gaven:
	farwritetext GavenGreetDayText
	promptbutton
	end

.Jose:
	farwritetext JoseGreetDayText
	promptbutton
	end

.Joey:
	farwritetext JoeyGreetDayText
	promptbutton
	end

.Wade:
	farwritetext WadeGreetDayText
	promptbutton
	end

.Ralph:
	farwritetext RalphGreetDayText
	promptbutton
	end

.Anthony:
	farwritetext AnthonyGreetDayText
	promptbutton
	end

.Todd:
	farwritetext ToddGreetDayText
	promptbutton
	end

.Irwin:
	farwritetext IrwinGreetDayText
	promptbutton
	end

.Arnie:
	farwritetext ArnieGreetDayText
	promptbutton
	end

.Alan:
	farwritetext AlanGreetDayText
	promptbutton
	end

.Chad:
	farwritetext ChadGreetDayText
	promptbutton
	end

.Derek:
	farwritetext DerekGreetDayText
	promptbutton
	end

.Tully:
	farwritetext TullyGreetDayText
	promptbutton
	end

.Brent:
	farwritetext BrentGreetDayText
	promptbutton
	end

.Vance:
	farwritetext VanceGreetDayText
	promptbutton
	end

.Wilton:
	farwritetext WiltonGreetDayText
	promptbutton
	end

.Kenji:
	farwritetext KenjiGreetDayText
	promptbutton
	end

.Parry:
	farwritetext ParryGreetDayText
	promptbutton
	end

PhoneScript_GreetPhone_Male_Nite:
	readvar VAR_CALLERID
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
	promptbutton
	end

.Huey:
	farwritetext HueyGreetNiteText
	promptbutton
	end

.Gaven:
	farwritetext GavenGreetNiteText
	promptbutton
	end

.Jose:
	farwritetext JoseGreetNiteText
	promptbutton
	end

.Joey:
	farwritetext JoeyGreetNiteText
	promptbutton
	end

.Wade:
	farwritetext WadeGreetNiteText
	promptbutton
	end

.Ralph:
	farwritetext RalphGreetNiteText
	promptbutton
	end

.Anthony:
	farwritetext AnthonyGreetNiteText
	promptbutton
	end

.Todd:
	farwritetext ToddGreetNiteText
	promptbutton
	end

.Irwin:
	farwritetext IrwinGreetNiteText
	promptbutton
	end

.Arnie:
	farwritetext ArnieGreetNiteText
	promptbutton
	end

.Alan:
	farwritetext AlanGreetNiteText
	promptbutton
	end

.Chad:
	farwritetext ChadGreetNiteText
	promptbutton
	end

.Derek:
	farwritetext DerekGreetNiteText
	promptbutton
	end

.Tully:
	farwritetext TullyGreetNiteText
	promptbutton
	end

.Brent:
	farwritetext BrentGreetNiteText
	promptbutton
	end

.Vance:
	farwritetext VanceGreetNiteText
	promptbutton
	end

.Wilton:
	farwritetext WiltonGreetNiteText
	promptbutton
	end

.Kenji:
	farwritetext KenjiGreetNiteText
	promptbutton
	end

.Parry:
	farwritetext ParryGreetNiteText
	promptbutton
	end

PhoneScript_GreetPhone_Female:
	checktime 1 << DAY
	iftrue PhoneScript_GreetPhone_Female_Day
	checktime (1 << EVE) | (1 << NITE)
	iftrue PhoneScript_GreetPhone_Female_Nite
	readvar VAR_CALLERID
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
	promptbutton
	end

.Beth:
	farwritetext BethGreetText
	promptbutton
	end

.Reena:
	farwritetext ReenaGreetText
	promptbutton
	end

.Liz:
	farwritetext LizGreetText
	promptbutton
	end

.Gina:
	farwritetext GinaGreetText
	promptbutton
	end

.Dana:
	farwritetext DanaGreetText
	promptbutton
	end

.Tiffany:
	farwritetext TiffanyGreetText
	promptbutton
	end

.Erin:
	farwritetext ErinGreetText
	promptbutton
	end

PhoneScript_GreetPhone_Female_Day:
	readvar VAR_CALLERID
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
	promptbutton
	end

.Beth:
	farwritetext BethGreetDayText
	promptbutton
	end

.Reena:
	farwritetext ReenaGreetDayText
	promptbutton
	end

.Liz:
	farwritetext LizGreetDayText
	promptbutton
	end

.Gina:
	farwritetext GinaGreetDayText
	promptbutton
	end

.Dana:
	farwritetext DanaGreetDayText
	promptbutton
	end

.Tiffany:
	farwritetext TiffanyGreetDayText
	promptbutton
	end

.Erin:
	farwritetext ErinGreetDayText
	promptbutton
	end

PhoneScript_GreetPhone_Female_Nite:
	readvar VAR_CALLERID
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
	promptbutton
	end

.Beth:
	farwritetext BethGreetNiteText
	promptbutton
	end

.Reena:
	farwritetext ReenaGreetNiteText
	promptbutton
	end

.Liz:
	farwritetext LizGreetNiteText
	promptbutton
	end

.Gina:
	farwritetext GinaGreetNiteText
	promptbutton
	end

.Dana:
	farwritetext DanaGreetNiteText
	promptbutton
	end

.Tiffany:
	farwritetext TiffanyGreetNiteText
	promptbutton
	end

.Erin:
	farwritetext ErinGreetNiteText
	promptbutton
	end

PhoneScript_Generic_Male:
	readvar VAR_CALLERID
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
	promptbutton
	end

.Unknown:
	farwritetext UnknownGenericText
	promptbutton
	end

.Gaven:
	farwritetext GavenGenericText
	promptbutton
	end

.Jose:
	farwritetext JoseGenericText
	promptbutton
	end

.Joey:
	farwritetext JoeyGenericText
	promptbutton
	end

.Wade:
	farwritetext WadeGenericText
	promptbutton
	end

.Ralph:
	farwritetext RalphGenericText
	promptbutton
	end

.Anthony:
	farwritetext AnthonyGenericText
	promptbutton
	end

.Todd:
	farwritetext ToddGenericText
	promptbutton
	end

.Arnie:
	farwritetext ArnieGenericText
	promptbutton
	end

.Alan:
	farwritetext AlanGenericText
	promptbutton
	end

.Chad:
	farwritetext ChadGenericText
	promptbutton
	end

.Derek:
	farwritetext DerekGenericText
	promptbutton
	end

.Tully:
	farwritetext TullyGenericText
	promptbutton
	end

.Brent:
	farwritetext BrentGenericText
	promptbutton
	end

.Vance:
	farwritetext VanceGenericText
	promptbutton
	end

.Wilton:
	farwritetext WiltonGenericText
	promptbutton
	end

.Parry:
	farwritetext ParryGenericText
	promptbutton
	end

PhoneScript_Generic_Female:
	readvar VAR_CALLERID
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
	promptbutton
	end

.Beth:
	farwritetext BethGenericText
	promptbutton
	end

.Reena:
	farwritetext ReenaGenericText
	promptbutton
	end

.Liz:
	farwritetext LizGenericText
	promptbutton
	end

.Gina:
	farwritetext GinaGenericText
	promptbutton
	end

.Dana:
	farwritetext DanaGenericText
	promptbutton
	end

.Tiffany:
	farwritetext TiffanyGenericText
	promptbutton
	end

.Erin:
	farwritetext ErinGenericText
	promptbutton
	end

PhoneScript_MonFlavorText:
	special RandomPhoneMon
	farscall PhoneScript_Random2
	ifequal $0, .TooEnergetic
	farwritetext UnknownGenericText
	promptbutton
	farsjump PhoneScript_HangupText_Male

.TooEnergetic:
	farwritetext UnknownTougherThanEverText
	promptbutton
	farsjump PhoneScript_HangupText_Male

Phone_GrandmaString: db "Grandma@"
Phone_GrandpaString: db "Grandpa@"
Phone_MomString:     db "Mom@"
Phone_DadString:     db "Dad@"
Phone_SisterString:  db "Sister@"
Phone_BrotherString: db "Brother@"

