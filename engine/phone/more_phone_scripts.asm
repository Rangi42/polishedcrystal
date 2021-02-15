Phone_GenericCall_Male:
	special RandomPhoneMon
	farscall PhoneScript_Random2
	ifequal 0, UnknownScript_0xa0013
	farscall PhoneScript_Generic_Male
	farjump Phone_FoundAMon_Male

UnknownScript_0xa0013:
	farjump Phone_BraggingCall_Male

Phone_GenericCall_Female:
	special RandomPhoneMon
	farscall PhoneScript_Random2
	ifequal 0, UnknownScript_0xa002a
	farscall PhoneScript_Generic_Female
	farjump Phone_FoundAMon_Female

UnknownScript_0xa002a:
	farjump Phone_BraggingCall_Female

Phone_BraggingCall_Male:
	farscall Phone_WhosBragging_Male
	farjump Phone_FoundAMon_Male

Phone_BraggingCall_Female:
	farscall Phone_WhosBragging_Female
	farjump Phone_FoundAMon_Female

Phone_FoundAMon_Male:
	special RandomPhoneWildMon
	farscall PhoneScript_Random2
	ifequal 0, UnknownScript_0xa0051
	farscall Phone_WhoDefeatedMon_Male
	farjump PhoneScript_HangupText_Male

UnknownScript_0xa0051:
	farjump Phone_GotAwayCall_Male

Phone_FoundAMon_Female:
	special RandomPhoneWildMon
	farscall PhoneScript_Random2
	ifequal 0, UnknownScript_0xa0068
	farscall Phone_WhoDefeatedMon_Female
	farjump PhoneScript_HangupText_Female

UnknownScript_0xa0068:
	farjump Phone_GotAwayCall_Female

Phone_GotAwayCall_Male:
	farscall Phone_WhoLostAMon_Male
	farjump PhoneScript_HangupText_Male

Phone_GotAwayCall_Female:
	farscall Phone_WhoLostAMon_Female
	farjump PhoneScript_HangupText_Female

Phone_WhosBragging_Male:
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
	farwritetext JackIntelligenceKeepsRisingText
	buttonsound
	end

.Gaven:
	farwritetext GavenMonGreaterThanImaginedText
	buttonsound
	end

.Jose:
	farwritetext JoseMonsStickHasADeliciousAromaText
	buttonsound
	end

.Joey:
	farwritetext JoeyMonLookingSharperText
	buttonsound
	end

.Wade:
	farwritetext WadeAreYourMonGrowingText
	buttonsound
	end

.Ralph:
	farwritetext RalphNeglectingKidsText
	buttonsound
	end

.Anthony:
	farwritetext AnthonyMonAteSomeBerriesText
	buttonsound
	end

.Todd:
	farwritetext ToddLooksCuteLikeMeText
	buttonsound
	end

.Arnie:
	farwritetext ArnieMonIsSoCuteText
	buttonsound
	end

.Alan:
	farwritetext AlanGettingStrongerText
	buttonsound
	end

.Chad:
	farwritetext ChadObservingWildText
	buttonsound
	end

.Derek:
	farwritetext DerekCheekPinchingText
	buttonsound
	end

.Tully:
	farwritetext TullyMonHasGrownText
	buttonsound
	end

.Brent:
	farwritetext BrentRareTradeText
	buttonsound
	end

.Vance:
	farwritetext VanceMonHasBecomeTougherText
	buttonsound
	end

.Wilton:
	farwritetext WiltonMonHasGrownText
	buttonsound
	end

.Parry:
	farwritetext ParryNothingCanMatchText
	buttonsound
	end

Phone_WhosBragging_Female:
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
	farwritetext BeverlyMadeMonEvenCuterText
	buttonsound
	end

.Beth:
	farwritetext BethExhilaratingRideText
	buttonsound
	end

.Reena:
	farwritetext ReenaMonsIsAPerfectMatchText
	buttonsound
	end

.Liz:
	farwritetext LizMonAlwaysWantsToNuzzleText
	buttonsound
	end

.Gina:
	farwritetext GinaGettingInSyncWithMonText
	buttonsound
	end

.Dana:
	farwritetext DanaTakingPhotosText
	buttonsound
	end

.Tiffany:
	farwritetext TiffanyMonIsAdorableText
	buttonsound
	end

.Erin:
	farwritetext ErinMonIsMuchStrongerText
	buttonsound
	end

Phone_WhoDefeatedMon_Male:
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
	farwritetext JackDefeatedMonText
	buttonsound
	end

.Gaven:
	farwritetext GavenDefeatedMonText
	buttonsound
	end

.Jose:
	farwritetext JoseDefeatedMonText
	buttonsound
	end

.Joey:
	farwritetext JoeyDefeatedMonText
	buttonsound
	end

.Wade:
	farwritetext WadeDefeatedMonText
	buttonsound
	end

.Ralph:
	farwritetext RalphDefeatedMonText
	buttonsound
	end

.Anthony:
	farwritetext AnthonyDefeatedMonText
	buttonsound
	end

.Todd:
	farwritetext ToddDefeatedMonText
	buttonsound
	end

.Arnie:
	farwritetext ArnieDefeatedMonText
	buttonsound
	end

.Alan:
	farwritetext AlanDefeatedMonText
	buttonsound
	end

.Chad:
	farwritetext ChadDefeatedMonText
	buttonsound
	end

.Derek:
	farwritetext DerekDefeatedMonText
	buttonsound
	end

.Tully:
	farwritetext TullyDefeatedMonText
	buttonsound
	end

.Brent:
	farwritetext BrentDefeatedMonText
	buttonsound
	end

.Vance:
	farwritetext VanceDefeatedMonText
	buttonsound
	end

.Wilton:
	farwritetext WiltonDefeatedMonText
	buttonsound
	end

.Parry:
	farwritetext ParryDefeatedMonText
	buttonsound
	end

Phone_WhoDefeatedMon_Female:
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
	farwritetext BeverlyDefeatedMonText
	buttonsound
	end

.Beth:
	farwritetext BethDefeatedMonText
	buttonsound
	end

.Reena:
	farwritetext ReenaDefeatedMonText
	buttonsound
	end

.Liz:
	farwritetext LizDefeatedMonText
	buttonsound
	end

.Gina:
	farwritetext GinaDefeatedMonText
	buttonsound
	end

.Dana:
	farwritetext DanaDefeatedMonText
	buttonsound
	end

.Tiffany:
	farwritetext TiffanyDefeatedMonText
	buttonsound
	end

.Erin:
	farwritetext ErinDefeatedMonText
	buttonsound
	end

Phone_WhoLostAMon_Male:
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
	farwritetext JackLostAMonText
	buttonsound
	end

.Gaven:
	farwritetext GavenLostAMonText
	buttonsound
	end

.Jose:
	farwritetext JoseLostAMonText
	buttonsound
	end

.Joey:
	farwritetext JoeyLostAMonText
	buttonsound
	end

.Wade:
	farwritetext WadeLostAMonText
	buttonsound
	end

.Ralph:
	farwritetext RalphLostAMonText
	buttonsound
	end

.Anthony:
	farwritetext AnthonyLostAMonText
	buttonsound
	end

.Todd:
	farwritetext ToddLostAMonText
	buttonsound
	end

.Arnie:
	farwritetext ArnieLostAMonText
	buttonsound
	end

.Alan:
	farwritetext AlanLostAMonText
	buttonsound
	end

.Chad:
	farwritetext ChadLostAMonText
	buttonsound
	end

.Derek:
	farwritetext DerekLostAMonText
	buttonsound
	end

.Tully:
	farwritetext TullyLostAMonText
	buttonsound
	end

.Brent:
	farwritetext BrentLostAMonText
	buttonsound
	end

.Vance:
	farwritetext VanceLostAMonText
	buttonsound
	end

.Wilton:
	farwritetext WiltonLostAMonText
	buttonsound
	end

.Parry:
	farwritetext ParryLostAMonText
	buttonsound
	end

Phone_WhoLostAMon_Female:
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
	farwritetext BeverlyLostAMonText
	buttonsound
	end

.Beth:
	farwritetext BethLostAMonText
	buttonsound
	end

.Reena:
	farwritetext ReenaLostAMonText
	buttonsound
	end

.Liz:
	farwritetext LizLostAMonText
	buttonsound
	end

.Gina:
	farwritetext GinaLostAMonText
	buttonsound
	end

.Dana:
	farwritetext DanaLostAMonText
	buttonsound
	end

.Tiffany:
	farwritetext TiffanyLostAMonText
	buttonsound
	end

.Erin:
	farwritetext ErinLostAMonText
	buttonsound
	end

PhoneScript_WantsToBattle_Male:
	farscall PhoneScript_RematchText_Male
	farjump PhoneScript_HangupText_Male

PhoneScript_WantsToBattle_Female:
	farscall PhoneScript_RematchText_Female
	farjump PhoneScript_HangupText_Female

PhoneScript_RematchText_Male:
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
	ifequal PHONE_BUG_CATCHER_ARNIE, .Arnie
	ifequal PHONE_SCHOOLBOY_ALAN, .Alan
	ifequal PHONE_SCHOOLBOY_CHAD, .Chad
	ifequal PHONE_FISHER_TULLY, .Tully
	ifequal PHONE_POKEMANIAC_BRENT, .Brent
	ifequal PHONE_BIRDKEEPER_VANCE, .Vance
	ifequal PHONE_FISHER_WILTON, .Wilton
	ifequal PHONE_HIKER_PARRY, .Parry

.Jack:
	farwritetext JackBattleRematchText
	buttonsound
	end

.Huey:
	farwritetext HueyBattleRematchText
	buttonsound
	end

.Gaven:
	farwritetext GavenBattleRematchText
	buttonsound
	end

.Jose:
	farwritetext JoseBattleRematchText
	buttonsound
	end

.Joey:
	farwritetext JoeyBattleRematchText
	buttonsound
	end

.Wade:
	farwritetext WadeBattleRematchText
	buttonsound
	end

.Ralph:
	farwritetext RalphBattleRematchText
	buttonsound
	end

.Anthony:
	farwritetext AnthonyBattleRematchText
	buttonsound
	end

.Todd:
	farwritetext ToddBattleRematchText
	buttonsound
	end

.Arnie:
	farwritetext ArnieBattleRematchText
	buttonsound
	end

.Alan:
	farwritetext AlanBattleRematchText
	buttonsound
	end

.Chad:
	farwritetext ChadBattleRematchText
	buttonsound
	end

.Tully:
	farwritetext TullyBattleRematchText
	buttonsound
	end

.Brent:
	farwritetext BrentBattleRematchText
	buttonsound
	end

.Vance:
	farwritetext VanceBattleRematchText
	buttonsound
	end

.Wilton:
	farwritetext WiltonBattleRematchText
	buttonsound
	end

.Parry:
	farwritetext ParryBattleRematchText
	buttonsound
	end

PhoneScript_RematchText_Female:
	checkcode VAR_CALLERID
	ifequal PHONE_COOLTRAINERF_BETH, .Beth
	ifequal PHONE_COOLTRAINERF_REENA, .Reena
	ifequal PHONE_PICNICKER_LIZ, .Liz
	ifequal PHONE_PICNICKER_GINA, .Gina
	ifequal PHONE_LASS_DANA, .Dana
	ifequal PHONE_PICNICKER_TIFFANY, .Tiffany
	ifequal PHONE_PICNICKER_ERIN, .Erin

.Beth:
	farwritetext BethBattleRematchText
	buttonsound
	end

.Reena:
	farwritetext ReenaBattleRematchText
	buttonsound
	end

.Liz:
	farwritetext LizBattleRematchText
	buttonsound
	end

.Gina:
	farwritetext GinaBattleRematchText
	buttonsound
	end

.Dana:
	farwritetext DanaBattleRematchText
	buttonsound
	end

.Tiffany:
	farwritetext TiffanyBattleRematchText
	buttonsound
	end

.Erin:
	farwritetext ErinBattleRematchText
	buttonsound
	end

LizWrongNumberScript:
	farwritetext LizWrongNumberText
	end

TiffanyItsAwful:
	farwritetext TiffanyItsAwfulText
	end

PhoneScript_HangupText_Male:
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
	farwritetext JackHangUpText
	end

.Huey:
	farwritetext HueyHangUpText
	end

.Gaven:
	farwritetext GavenHangUpText
	end

.Jose:
	farwritetext JoseHangUpText
	end

.Joey:
	farwritetext JoeyHangUpText
	end

.Wade:
	farwritetext WadeHangUpText
	end

.Ralph:
	farwritetext RalphHangUpText
	end

.Anthony:
	farwritetext AnthonyHangUpText
	end

.Todd:
	farwritetext ToddHangUpText
	end

.Irwin:
	farwritetext IrwinHangUpText
	end

.Arnie:
	farwritetext ArnieHangUpText
	end

.Alan:
	farwritetext AlanHangUpText
	end

.Chad:
	farwritetext ChadHangUpText
	end

.Derek:
	farwritetext DerekHangUpText
	end

.Tully:
	farwritetext TullyHangUpText
	end

.Brent:
	farwritetext BrentHangUpText
	end

.Vance:
	farwritetext VanceHangUpText
	end

.Wilton:
	farwritetext WiltonHangUpText
	end

.Kenji:
	farwritetext KenjiHangUpText
	end

.Parry:
	farwritetext ParryHangUpText
	end

PhoneScript_HangupText_Female:
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
	farwritetext BeverlyHangUpText
	end

.Beth:
	farwritetext BethHangUpText
	end

.Reena:
	farwritetext ReenaHangUpText
	end

.Liz:
	farwritetext LizHangUpText
	end

.Gina:
	farwritetext GinaHangUpText
	end

.Dana:
	farwritetext DanaHangUpText
	end

.Tiffany:
	farwritetext TiffanyHangUpText
	end

.Erin:
	farwritetext ErinHangUpText
	end

Phone_CheckIfUnseenRare_Male:
	scall PhoneScriptRareWildMon
	iffalse UnknownScript_0xa058e
	farjump Phone_GenericCall_Male

UnknownScript_0xa058e:
	farjump PhoneScript_HangupText_Male

Phone_CheckIfUnseenRare_Female:
	scall PhoneScriptRareWildMon
	iffalse UnknownScript_0xa059c
	farjump Phone_GenericCall_Female

UnknownScript_0xa059c:
	farjump PhoneScript_HangupText_Female

PhoneScriptRareWildMon:
	special RandomPhoneRareWildMon
	end

PhoneScript_BugCatchingContest:
	checkcode VAR_CALLERID
	ifequal PHONE_BUG_CATCHER_WADE, .Wade
	ifequal PHONE_POKEFANM_DEREK, .Derek

.Wade:
	farwritetext WadeBugCatchingContestText
	buttonsound
	jump PhoneScript_HangupText_Male

.Derek:
	farwritetext DerekBugCatchingContestText
	buttonsound
	jump PhoneScript_HangupText_Male

IrwinRocketRumorScript:
	farwritetext IrwinRocketTakeoverRumorText
	buttonsound
	jump PhoneScript_HangupText_Male

GinaRocketRumorScript:
	farwritetext GinaRocketTakeoverRumorText
	buttonsound
	jump PhoneScript_HangupText_Female

ArnieSwarmScript:
	farwritetext ArnieSwarmText
	buttonsound
	jump PhoneScript_HangupText_Male

RalphItemScript:
	farwritetext RalphItemText
	buttonsound
	jump PhoneScript_HangupText_Male

AnthonySwarmScript:
	farwritetext AnthonySwarmText
	buttonsound
	jump PhoneScript_HangupText_Male

PhoneScript_FoundItem_Male:
	checkcode VAR_CALLERID
	ifequal PHONE_BIRDKEEPER_JOSE, .Jose
	ifequal PHONE_BUG_CATCHER_WADE, .Wade
	ifequal PHONE_SCHOOLBOY_ALAN, .Alan
	ifequal PHONE_POKEFANM_DEREK, .Derek
	ifequal PHONE_FISHER_TULLY, .Tully
	ifequal PHONE_FISHER_WILTON, .Wilton

.Jose:
	farwritetext JoseFoundItemText
	end

.Wade:
	farwritetext WadeFoundItemText
	end

.Alan:
	farwritetext AlanFoundItemText
	end

.Derek:
	farwritetext DerekFoundItemText
	end

.Tully:
	farwritetext TullyFoundItemText
	end

.Wilton:
	farwritetext WiltonFoundItemText
	end

PhoneScript_FoundItem_Female:
	checkcode VAR_CALLERID
	ifequal PHONE_POKEFAN_BEVERLY, .Beverly
	ifequal PHONE_PICNICKER_GINA, .Gina
	ifequal PHONE_LASS_DANA, .Dana
	ifequal PHONE_PICNICKER_TIFFANY, .Tiffany

.Beverly:
	farwritetext BeverlyFoundItemText
	end

.Gina:
	farwritetext GinaFoundItemText
	end

.Dana:
	farwritetext DanaFoundItemText
	end

.Tiffany:
	farwritetext TiffanyFoundItemText
	end

ToddItemScript:
	farwritetext ToddDepartmentStoreBargainSaleText
	buttonsound
	jump PhoneScript_HangupText_Male

KenjiCallingPhoneScript:
	farwritetext KenjiRemainDedicatedText
	buttonsound
	jump PhoneScript_HangupText_Male

JackTriviaScript:
	random 11
	ifequal  0, UnknownScript_0xa0682
	ifequal  1, UnknownScript_0xa068a
	ifequal  2, UnknownScript_0xa0692
	ifequal  3, UnknownScript_0xa069a
	ifequal  4, UnknownScript_0xa06a2
	ifequal  5, UnknownScript_0xa06aa
	ifequal  6, UnknownScript_0xa06b2
	ifequal  7, UnknownScript_0xa06ba
	ifequal  8, UnknownScript_0xa06c2
	ifequal  9, UnknownScript_0xa06ca
	ifequal 10, UnknownScript_0xa06d2

UnknownScript_0xa0682:
	farwritetext JackThunderTriviaText
	buttonsound
	jump PhoneScript_HangupText_Male

UnknownScript_0xa068a:
	farwritetext JackRolloutTriviaText
	buttonsound
	jump PhoneScript_HangupText_Male

UnknownScript_0xa0692:
	farwritetext JackSolarbeamTriviaText
	buttonsound
	jump PhoneScript_HangupText_Male

UnknownScript_0xa069a:
	farwritetext JackStompTriviaText
	buttonsound
	jump PhoneScript_HangupText_Male

UnknownScript_0xa06a2:
	farwritetext JackGustTriviaText
	buttonsound
	jump PhoneScript_HangupText_Male

UnknownScript_0xa06aa:
	farwritetext JackTwisterTriviaText
	buttonsound
	jump PhoneScript_HangupText_Male

UnknownScript_0xa06b2:
	farwritetext JackEarthquakeTriviaText
	buttonsound
	jump PhoneScript_HangupText_Male

UnknownScript_0xa06ba:
	farwritetext JackMagnitudeTriviaText
	buttonsound
	jump PhoneScript_HangupText_Male

UnknownScript_0xa06c2:
	farwritetext JackSandstormTriviaText
	buttonsound
	jump PhoneScript_HangupText_Male

UnknownScript_0xa06ca:
	farwritetext JackSunnyDayTriviaText
	buttonsound
	jump PhoneScript_HangupText_Male

UnknownScript_0xa06d2:
	farwritetext JackRainDanceTriviaText
	buttonsound
	jump PhoneScript_HangupText_Male

LizGossipRandomScript:
	random 10
	ifequal 0, UnknownScript_0xa0704
	ifequal 1, UnknownScript_0xa070c
	ifequal 2, UnknownScript_0xa0714
	ifequal 3, UnknownScript_0xa071c
	ifequal 4, UnknownScript_0xa0724
	ifequal 5, UnknownScript_0xa072c
	ifequal 6, UnknownScript_0xa0734
	ifequal 7, UnknownScript_0xa073c
	ifequal 8, UnknownScript_0xa0744
	ifequal 9, UnknownScript_0xa074c

UnknownScript_0xa0704:
	farwritetext LizRuinsOfAlphGossipText
	buttonsound
	jump PhoneScript_HangupText_Female

UnknownScript_0xa070c:
	farwritetext LizFalknerGossipText
	buttonsound
	jump PhoneScript_HangupText_Female

UnknownScript_0xa0714:
	farwritetext LizEarlGossipText
	buttonsound
	jump PhoneScript_HangupText_Female

UnknownScript_0xa071c:
	farwritetext LizSurfPikachuGossipText
	buttonsound
	jump PhoneScript_HangupText_Female

UnknownScript_0xa0724:
	farwritetext LizMooMooMilkGossipText
	buttonsound
	jump PhoneScript_HangupText_Female

UnknownScript_0xa072c:
	farwritetext LizSalonGossipText
	buttonsound
	jump PhoneScript_HangupText_Female

UnknownScript_0xa0734:
	farwritetext LizWhitneyGossipText
	buttonsound
	jump PhoneScript_HangupText_Female

UnknownScript_0xa073c:
	farwritetext LizBugCatchingContestGossipText
	buttonsound
	jump PhoneScript_HangupText_Female

UnknownScript_0xa0744:
	farwritetext LizBeautifulMonGossipText
	buttonsound
	jump PhoneScript_HangupText_Female

UnknownScript_0xa074c:
	farwritetext LizForgotGossipText
	buttonsound
	jump PhoneScript_HangupText_Female

ChadOakGossipScript:
	random 10
	ifequal 0, UnknownScript_0xa077e
	ifequal 1, UnknownScript_0xa0786
	ifequal 2, UnknownScript_0xa078e
	ifequal 3, UnknownScript_0xa0796
	ifequal 4, UnknownScript_0xa079e
	ifequal 5, UnknownScript_0xa07a6
	ifequal 6, UnknownScript_0xa07ae
	ifequal 7, UnknownScript_0xa07b6
	ifequal 8, UnknownScript_0xa07be
	ifequal 9, UnknownScript_0xa07c6

UnknownScript_0xa077e:
	farwritetext ChadBlueGossipText
	buttonsound
	jump PhoneScript_HangupText_Male

UnknownScript_0xa0786:
	farwritetext ChadDaisyGossipText
	buttonsound
	jump PhoneScript_HangupText_Male

UnknownScript_0xa078e:
	farwritetext ChadProfElmGossipText
	buttonsound
	jump PhoneScript_HangupText_Male

UnknownScript_0xa0796:
	farwritetext ChadProfOaksDreamGossipText
	buttonsound
	jump PhoneScript_HangupText_Male

UnknownScript_0xa079e:
	farwritetext ChadKurtGossipText
	buttonsound
	jump PhoneScript_HangupText_Male

UnknownScript_0xa07a6:
	farwritetext ChadLeagueGossipText
	buttonsound
	jump PhoneScript_HangupText_Male

UnknownScript_0xa07ae:
	farwritetext ChadPokemonTalkGossipText
	buttonsound
	jump PhoneScript_HangupText_Male

UnknownScript_0xa07b6:
	farwritetext ChadProfOakTrainerGossipText
	buttonsound
	jump PhoneScript_HangupText_Male

UnknownScript_0xa07be:
	farwritetext ChadDaisyTeaGossipText
	buttonsound
	jump PhoneScript_HangupText_Male

UnknownScript_0xa07c6:
	farwritetext ChadProfOakTravelingGossipText
	buttonsound
	jump PhoneScript_HangupText_Male

BrentBillTriviaScript:
	random 10
	ifequal 0, UnknownScript_0xa07f8
	ifequal 1, UnknownScript_0xa0800
	ifequal 2, UnknownScript_0xa0808
	ifequal 3, UnknownScript_0xa0810
	ifequal 4, UnknownScript_0xa0818
	ifequal 5, UnknownScript_0xa0820
	ifequal 6, UnknownScript_0xa0828
	ifequal 7, UnknownScript_0xa0830
	ifequal 8, UnknownScript_0xa0838
	ifequal 9, UnknownScript_0xa0840

UnknownScript_0xa07f8:
	farwritetext BrentFatherGossipText
	buttonsound
	jump PhoneScript_HangupText_Male

UnknownScript_0xa0800:
	farwritetext BrentGrandpaGossipText
	buttonsound
	jump PhoneScript_HangupText_Male

UnknownScript_0xa0808:
	farwritetext BrentGoldenrodGossipText
	buttonsound
	jump PhoneScript_HangupText_Male

UnknownScript_0xa0810:
	farwritetext BrentRoute25GossipText
	buttonsound
	jump PhoneScript_HangupText_Male

UnknownScript_0xa0818:
	farwritetext BrentAbraGossipText
	buttonsound
	jump PhoneScript_HangupText_Male

UnknownScript_0xa0820:
	farwritetext BrentSisterGossipText
	buttonsound
	jump PhoneScript_HangupText_Male

UnknownScript_0xa0828:
	farwritetext BrentMilkGossipText
	buttonsound
	jump PhoneScript_HangupText_Male

UnknownScript_0xa0830:
	farwritetext BrentBattlingGossipText
	buttonsound
	jump PhoneScript_HangupText_Male

UnknownScript_0xa0838:
	farwritetext BrentFlowerShopGossipText
	buttonsound
	jump PhoneScript_HangupText_Male

UnknownScript_0xa0840:
	farwritetext BrentKimonoGirlGossipText
	buttonsound
	jump PhoneScript_HangupText_Male

IrwinRumorScript:
	checkevent EVENT_OPENED_MT_SILVER
	iftrue UnknownScript_0xa08e0
	checkevent EVENT_FOUGHT_SNORLAX
	iftrue UnknownScript_0xa08d8
	checkevent EVENT_GOT_PASS_FROM_COPYCAT
	iftrue UnknownScript_0xa08d0
	checkflag ENGINE_SOULBADGE
	iftrue UnknownScript_0xa08f0
	checkflag ENGINE_FLYPOINT_VERMILION
	iftrue UnknownScript_0xa08c8
	checkevent EVENT_BEAT_ELITE_FOUR
	iftrue UnknownScript_0xa08c0
	checkflag ENGINE_RISINGBADGE
	iftrue UnknownScript_0xa08b8
	checkevent EVENT_CLEARED_RADIO_TOWER
	iftrue UnknownScript_0xa08b0
	checkevent EVENT_CLEARED_ROCKET_HIDEOUT
	iftrue UnknownScript_0xa08a8
	checkevent EVENT_JASMINE_RETURNED_TO_GYM
	iftrue UnknownScript_0xa08a0
	checkflag ENGINE_FOGBADGE
	iftrue UnknownScript_0xa08e8
	checkflag ENGINE_PLAINBADGE
	iftrue UnknownScript_0xa0898
	farwritetext IrwinCalledRightAwayText
	buttonsound
	jump PhoneScript_HangupText_Male

UnknownScript_0xa0898:
	farwritetext IrwinPlainBadgeGossipText
	buttonsound
	jump PhoneScript_HangupText_Male

UnknownScript_0xa08a0:
	farwritetext IrwinJasmineReturnedGossipText
	buttonsound
	jump PhoneScript_HangupText_Male

UnknownScript_0xa08a8:
	farwritetext IrwinRocketHideoutGossipText
	buttonsound
	jump PhoneScript_HangupText_Male

UnknownScript_0xa08b0:
	farwritetext IrwinRadioTowerGossipText
	buttonsound
	jump PhoneScript_HangupText_Male

UnknownScript_0xa08b8:
	farwritetext IrwinRisingBadgeGossipText
	buttonsound
	jump PhoneScript_HangupText_Male

UnknownScript_0xa08c0:
	farwritetext IrwinEliteFourGossipText
	buttonsound
	jump PhoneScript_HangupText_Male

UnknownScript_0xa08c8:
	farwritetext IrwinVermilionCityGossipText
	buttonsound
	jump PhoneScript_HangupText_Male

UnknownScript_0xa08d0:
	farwritetext IrwinTrainPassGossipText
	buttonsound
	jump PhoneScript_HangupText_Male

UnknownScript_0xa08d8:
	farwritetext IrwinSnorlaxGossipText
	buttonsound
	jump PhoneScript_HangupText_Male

UnknownScript_0xa08e0:
	farwritetext IrwinMtSilverGossipText
	buttonsound
	jump PhoneScript_HangupText_Male

UnknownScript_0xa08e8:
	farwritetext IrwinFogBadgeGossipText
	buttonsound
	jump PhoneScript_HangupText_Male

UnknownScript_0xa08f0:
	farwritetext IrwinMarshBadgeGossipText
	buttonsound
	jump PhoneScript_HangupText_Male

JackPhoneTipsScript:
	farwritetext JackHeardSomeGreatTipsText
	buttonsound
	jump PhoneScript_HangupText_Male

BeverlyHangUpScript:
	farwritetext BeverlyLetsChatAboutMonAgainText
	buttonsound
	jump PhoneScript_HangupText_Female

HueyHangUpScript:
	farwritetext HueyWeHaveToBattleAgainSometimeText
	buttonsound
	jump PhoneScript_HangupText_Male

GavenHangUpNotThursdayScript:
	farwritetext GavenHangUpNotThursdayText
	buttonsound
	jump PhoneScript_HangupText_Male

BethHangUpScript:
	farwritetext BethLetsBattleAgainSometimeText
	buttonsound
	jump PhoneScript_HangupText_Female

JoseHangUpScript:
	farwritetext JoseHaventGottenItemYetText
	buttonsound
	jump PhoneScript_HangupText_Male

ReenaForwardScript:
	farwritetext ReenaForwardText
	buttonsound
	jump PhoneScript_HangupText_Female

JoeyHangUpScript:
	farwritetext JoeyDevisingStrategiesText
	buttonsound
	jump PhoneScript_HangupText_Male

WadeNoBerriesScript:
	farwritetext WadeNoBerriesText
	buttonsound
	jump PhoneScript_HangupText_Male

RalphNoItemScript:
	farwritetext RalphNoItemText
	buttonsound
	jump PhoneScript_HangupText_Male

LizHangUpScript:
	farwritetext LizFawningOverMonText
	buttonsound
	jump PhoneScript_HangupText_Female

AnthonyHangUpScript:
	farwritetext AnthonyWasntPayingAttentionText
	buttonsound
	jump PhoneScript_HangupText_Male

ToddNoItemScript:
	farwritetext ToddSavingUpForBargainSaleText
	buttonsound
	jump PhoneScript_HangupText_Male

GinaHangUpScript:
	farwritetext GinaHaventFoundAnythingYetText
	buttonsound
	jump PhoneScript_HangupText_Female

ArnieHangUpScript:
	farwritetext ArnieHaventSeenRareMonText
	buttonsound
	jump PhoneScript_HangupText_Male

AlanHangUpScript:
	farwritetext AlanHaventPickedUpAnythingText
	buttonsound
	jump PhoneScript_HangupText_Male

DanaHangUpScript:
	farwritetext DanaCanYouWaitABitLongerText
	buttonsound
	jump PhoneScript_HangupText_Female

ChadHangUpScript:
	farwritetext ChadGoingToStudyHardText
	buttonsound
	jump PhoneScript_HangupText_Male

DerekHangUpScript:
	farwritetext DerekLetsGetTogetherText
	buttonsound
	jump PhoneScript_HangupText_Male

TullyNoItemScript:
	farwritetext TullyNoItemText
	buttonsound
	jump PhoneScript_HangupText_Male

BrentHangUpScript:
	farwritetext BrentSorryImTooBusyText
	buttonsound
	jump PhoneScript_HangupText_Male

TiffanyNoItemScript:
	farwritetext TiffanyNoItemText
	buttonsound
	jump PhoneScript_HangupText_Female

VanceLookingForwardScript:
	farwritetext VanceLookingForwardText
	buttonsound
	jump PhoneScript_HangupText_Male

WiltonHaventFoundAnythingScript:
	farwritetext WiltonHaventFoundAnythingText
	buttonsound
	jump PhoneScript_HangupText_Male

ParryBattleWithMeScript:
	farwritetext ParryBattleWithMeText
	buttonsound
	jump PhoneScript_HangupText_Male

ErinWorkingHardScript:
	farwritetext ErinWorkingHardText
	buttonsound
	jump PhoneScript_HangupText_Female

IrwinRandomTextScript:
	random 3
	ifequal 0, IrwinEscapadeScript
	ifequal 1, IrwinGoodMatchScript
	ifequal 2, IrwinSoMuchToChatAboutScript

IrwinEscapadeScript:
	farwritetext IrwinYourEscapadesRockText
	buttonsound
	jump PhoneScript_HangupText_Male

IrwinGoodMatchScript:
	farwritetext IrwinGoodMatchText
	buttonsound
	jump PhoneScript_HangupText_Male

IrwinSoMuchToChatAboutScript:
	farwritetext IrwinSoMuchToChatAboutText
	buttonsound
	jump PhoneScript_HangupText_Male

KenjiAnswerPhoneScript:
	checkcode VAR_KENJI_BREAK
	ifequal 2, UnknownScript_0xa0a00
	ifequal 1, UnknownScript_0xa0a08
	farwritetext KenjiCallMeBackAnotherTimeText
	buttonsound
	jump PhoneScript_HangupText_Male

UnknownScript_0xa0a00:
	farwritetext KenjiIllHaveTimeToChatTomorrowText
	buttonsound
	jump PhoneScript_HangupText_Male

UnknownScript_0xa0a08:
	checktime 1 << MORN
	iftrue UnknownScript_0xa0a1d
	checktime 1 << DAY
	iffalse UnknownScript_0xa0a25
	setevent EVENT_KENJI_ON_BREAK
	farwritetext KenjiTakingABreakText
	buttonsound
	jump PhoneScript_HangupText_Male

UnknownScript_0xa0a1d:
	farwritetext KenjiHangUpMorningText
	buttonsound
	jump PhoneScript_HangupText_Male

UnknownScript_0xa0a25:
	farwritetext KenjiHangUpNightText
	buttonsound
	jump PhoneScript_HangupText_Male

JackWantsBattleScript:
	farwritetext JackReminderText
	end

HueyWantsBattleScript:
	farwritetext HueyReminderText
	end

GavenReminderScript:
	farwritetext GavenReminderText
	end

BethBattleReminderScript:
	farwritetext BethReminderText
	end

JoseReminderScript:
	farwritetext JoseReminderText
	end

ReenaHurryScript:
	farwritetext ReenaHurryText
	end

JoeyReminderScript:
	farwritetext JoeyReminderText
	end

WadeQuickBattleScript:
	farwritetext WadeQuickBattleText
	end

RalphReminderScript:
	farwritetext RalphReminderText
	end

LizReminderScript:
	farwritetext LizReminderText
	end

AnthonyReminderScript:
	farwritetext AnthonyReminderText
	end

ToddForwardScript:
	farwritetext ToddLookingForwardToBattleText
	end

GinaReminderScript:
	farwritetext GinaReminderText
	end

ArnieReminderScript:
	farwritetext ArnieReminderText
	end

AlanReminderScript:
	farwritetext AlanReminderText
	end

DanaReminderScript:
	farwritetext DanaReminderText
	end

ChadReminderScript:
	farwritetext ChadReminderText
	end

TullyForwardScript:
	farwritetext TullyForwardText
	end

BrentReminderScript:
	farwritetext BrentReminderText
	end

TiffanyAsleepScript:
	farwritetext TiffanyAsleepText
	end

VanceHurryHurryScript:
	farwritetext VanceHurryHurryText
	end

WiltonNotBitingScript:
	farwritetext WiltonNotBitingText
	end

ParryHaventYouGottenToScript:
	farwritetext ParryHaventYouGottenToText
	end

ErinComeBattleScript:
	farwritetext ErinComeBattleText
	end

BeverlyComePickUpScript:
	farwritetext BeverlyComePickUpText
	buttonsound
	jump PhoneScript_HangupText_Female

WadeComeQuickScript:
	farwritetext WadeComeQuickText
	buttonsound
	jump PhoneScript_HangupText_Male

GinaComePickUpScript:
	farwritetext GinaComePickUpText
	buttonsound
	jump PhoneScript_HangupText_Female

AlanComePickUpScript:
	farwritetext AlanComePickUpGiftText
	buttonsound
	jump PhoneScript_HangupText_Male

DanaComePickUpScript:
	farwritetext DanaComePickUpText
	buttonsound
	jump PhoneScript_HangupText_Female

DerekComePickUpScript:
	farwritetext DerekComePickUpText
	buttonsound
	jump PhoneScript_HangupText_Male

TullyHurryScript:
	farwritetext TullyHurryText
	buttonsound
	jump PhoneScript_HangupText_Male

TiffanyHurryScript:
	farwritetext TiffanyHurryText
	buttonsound
	jump PhoneScript_HangupText_Female

WiltonWantThisScript:
	farwritetext WiltonWantThisText
	buttonsound
	jump PhoneScript_HangupText_Male

RalphHurryScript:
	farwritetext RalphHurryText
	end

AnthonyHurryScript:
	farwritetext AnthonyHurryText
	end

ArnieHurryScript:
	farwritetext ArnieHurryText
	end

ToddHurryScript:
	farwritetext ToddHaveYouGoneToDepartmentStoreText
	end

BikeShopPhoneScript:
	farwritetext BikeShopPhoneCallerText
	clearflag ENGINE_BIKE_SHOP_CALL_ENABLED
	specialphonecall SPECIALCALL_NONE
	end
