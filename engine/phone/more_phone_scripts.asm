Phone_GenericCall_Male:
	special RandomPhoneMon
	farscall PhoneScript_Random2
	ifequal 0, UnknownScript_0xa0013
	farscall PhoneScript_Generic_Male
	farsjump Phone_FoundAMon_Male

UnknownScript_0xa0013:
	farsjump Phone_BraggingCall_Male

Phone_GenericCall_Female:
	special RandomPhoneMon
	farscall PhoneScript_Random2
	ifequal 0, UnknownScript_0xa002a
	farscall PhoneScript_Generic_Female
	farsjump Phone_FoundAMon_Female

UnknownScript_0xa002a:
	farsjump Phone_BraggingCall_Female

Phone_BraggingCall_Male:
	farscall Phone_WhosBragging_Male
	farsjump Phone_FoundAMon_Male

Phone_BraggingCall_Female:
	farscall Phone_WhosBragging_Female
	farsjump Phone_FoundAMon_Female

Phone_FoundAMon_Male:
	special RandomPhoneWildMon
	farscall PhoneScript_Random2
	ifequal 0, UnknownScript_0xa0051
	farscall Phone_WhoDefeatedMon_Male
	farsjump PhoneScript_HangupText_Male

UnknownScript_0xa0051:
	farsjump Phone_GotAwayCall_Male

Phone_FoundAMon_Female:
	special RandomPhoneWildMon
	farscall PhoneScript_Random2
	ifequal 0, UnknownScript_0xa0068
	farscall Phone_WhoDefeatedMon_Female
	farsjump PhoneScript_HangupText_Female

UnknownScript_0xa0068:
	farsjump Phone_GotAwayCall_Female

Phone_GotAwayCall_Male:
	farscall Phone_WhoLostAMon_Male
	farsjump PhoneScript_HangupText_Male

Phone_GotAwayCall_Female:
	farscall Phone_WhoLostAMon_Female
	farsjump PhoneScript_HangupText_Female

Phone_WhosBragging_Male:
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
	farwritetext JackIntelligenceKeepsRisingText
	promptbutton
	end

.Gaven:
	farwritetext GavenMonGreaterThanImaginedText
	promptbutton
	end

.Jose:
	farwritetext JoseMonsStickHasADeliciousAromaText
	promptbutton
	end

.Joey:
	farwritetext JoeyMonLookingSharperText
	promptbutton
	end

.Wade:
	farwritetext WadeAreYourMonGrowingText
	promptbutton
	end

.Ralph:
	farwritetext RalphNeglectingKidsText
	promptbutton
	end

.Anthony:
	farwritetext AnthonyMonAteSomeBerriesText
	promptbutton
	end

.Todd:
	farwritetext ToddLooksCuteLikeMeText
	promptbutton
	end

.Arnie:
	farwritetext ArnieMonIsSoCuteText
	promptbutton
	end

.Alan:
	farwritetext AlanGettingStrongerText
	promptbutton
	end

.Chad:
	farwritetext ChadObservingWildText
	promptbutton
	end

.Derek:
	farwritetext DerekCheekPinchingText
	promptbutton
	end

.Tully:
	farwritetext TullyMonHasGrownText
	promptbutton
	end

.Brent:
	farwritetext BrentRareTradeText
	promptbutton
	end

.Vance:
	farwritetext VanceMonHasBecomeTougherText
	promptbutton
	end

.Wilton:
	farwritetext WiltonMonHasGrownText
	promptbutton
	end

.Parry:
	farwritetext ParryNothingCanMatchText
	promptbutton
	end

Phone_WhosBragging_Female:
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
	farwritetext BeverlyMadeMonEvenCuterText
	promptbutton
	end

.Beth:
	farwritetext BethExhilaratingRideText
	promptbutton
	end

.Reena:
	farwritetext ReenaMonsIsAPerfectMatchText
	promptbutton
	end

.Liz:
	farwritetext LizMonAlwaysWantsToNuzzleText
	promptbutton
	end

.Gina:
	farwritetext GinaGettingInSyncWithMonText
	promptbutton
	end

.Dana:
	farwritetext DanaTakingPhotosText
	promptbutton
	end

.Tiffany:
	farwritetext TiffanyMonIsAdorableText
	promptbutton
	end

.Erin:
	farwritetext ErinMonIsMuchStrongerText
	promptbutton
	end

Phone_WhoDefeatedMon_Male:
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
	farwritetext JackDefeatedMonText
	promptbutton
	end

.Gaven:
	farwritetext GavenDefeatedMonText
	promptbutton
	end

.Jose:
	farwritetext JoseDefeatedMonText
	promptbutton
	end

.Joey:
	farwritetext JoeyDefeatedMonText
	promptbutton
	end

.Wade:
	farwritetext WadeDefeatedMonText
	promptbutton
	end

.Ralph:
	farwritetext RalphDefeatedMonText
	promptbutton
	end

.Anthony:
	farwritetext AnthonyDefeatedMonText
	promptbutton
	end

.Todd:
	farwritetext ToddDefeatedMonText
	promptbutton
	end

.Arnie:
	farwritetext ArnieDefeatedMonText
	promptbutton
	end

.Alan:
	farwritetext AlanDefeatedMonText
	promptbutton
	end

.Chad:
	farwritetext ChadDefeatedMonText
	promptbutton
	end

.Derek:
	farwritetext DerekDefeatedMonText
	promptbutton
	end

.Tully:
	farwritetext TullyDefeatedMonText
	promptbutton
	end

.Brent:
	farwritetext BrentDefeatedMonText
	promptbutton
	end

.Vance:
	farwritetext VanceDefeatedMonText
	promptbutton
	end

.Wilton:
	farwritetext WiltonDefeatedMonText
	promptbutton
	end

.Parry:
	farwritetext ParryDefeatedMonText
	promptbutton
	end

Phone_WhoDefeatedMon_Female:
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
	farwritetext BeverlyDefeatedMonText
	promptbutton
	end

.Beth:
	farwritetext BethDefeatedMonText
	promptbutton
	end

.Reena:
	farwritetext ReenaDefeatedMonText
	promptbutton
	end

.Liz:
	farwritetext LizDefeatedMonText
	promptbutton
	end

.Gina:
	farwritetext GinaDefeatedMonText
	promptbutton
	end

.Dana:
	farwritetext DanaDefeatedMonText
	promptbutton
	end

.Tiffany:
	farwritetext TiffanyDefeatedMonText
	promptbutton
	end

.Erin:
	farwritetext ErinDefeatedMonText
	promptbutton
	end

Phone_WhoLostAMon_Male:
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
	farwritetext JackLostAMonText
	promptbutton
	end

.Gaven:
	farwritetext GavenLostAMonText
	promptbutton
	end

.Jose:
	farwritetext JoseLostAMonText
	promptbutton
	end

.Joey:
	farwritetext JoeyLostAMonText
	promptbutton
	end

.Wade:
	farwritetext WadeLostAMonText
	promptbutton
	end

.Ralph:
	farwritetext RalphLostAMonText
	promptbutton
	end

.Anthony:
	farwritetext AnthonyLostAMonText
	promptbutton
	end

.Todd:
	farwritetext ToddLostAMonText
	promptbutton
	end

.Arnie:
	farwritetext ArnieLostAMonText
	promptbutton
	end

.Alan:
	farwritetext AlanLostAMonText
	promptbutton
	end

.Chad:
	farwritetext ChadLostAMonText
	promptbutton
	end

.Derek:
	farwritetext DerekLostAMonText
	promptbutton
	end

.Tully:
	farwritetext TullyLostAMonText
	promptbutton
	end

.Brent:
	farwritetext BrentLostAMonText
	promptbutton
	end

.Vance:
	farwritetext VanceLostAMonText
	promptbutton
	end

.Wilton:
	farwritetext WiltonLostAMonText
	promptbutton
	end

.Parry:
	farwritetext ParryLostAMonText
	promptbutton
	end

Phone_WhoLostAMon_Female:
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
	farwritetext BeverlyLostAMonText
	promptbutton
	end

.Beth:
	farwritetext BethLostAMonText
	promptbutton
	end

.Reena:
	farwritetext ReenaLostAMonText
	promptbutton
	end

.Liz:
	farwritetext LizLostAMonText
	promptbutton
	end

.Gina:
	farwritetext GinaLostAMonText
	promptbutton
	end

.Dana:
	farwritetext DanaLostAMonText
	promptbutton
	end

.Tiffany:
	farwritetext TiffanyLostAMonText
	promptbutton
	end

.Erin:
	farwritetext ErinLostAMonText
	promptbutton
	end

PhoneScript_WantsToBattle_Male:
	farscall PhoneScript_RematchText_Male
	farsjump PhoneScript_HangupText_Male

PhoneScript_WantsToBattle_Female:
	farscall PhoneScript_RematchText_Female
	farsjump PhoneScript_HangupText_Female

PhoneScript_RematchText_Male:
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
	promptbutton
	end

.Huey:
	farwritetext HueyBattleRematchText
	promptbutton
	end

.Gaven:
	farwritetext GavenBattleRematchText
	promptbutton
	end

.Jose:
	farwritetext JoseBattleRematchText
	promptbutton
	end

.Joey:
	farwritetext JoeyBattleRematchText
	promptbutton
	end

.Wade:
	farwritetext WadeBattleRematchText
	promptbutton
	end

.Ralph:
	farwritetext RalphBattleRematchText
	promptbutton
	end

.Anthony:
	farwritetext AnthonyBattleRematchText
	promptbutton
	end

.Todd:
	farwritetext ToddBattleRematchText
	promptbutton
	end

.Arnie:
	farwritetext ArnieBattleRematchText
	promptbutton
	end

.Alan:
	farwritetext AlanBattleRematchText
	promptbutton
	end

.Chad:
	farwritetext ChadBattleRematchText
	promptbutton
	end

.Tully:
	farwritetext TullyBattleRematchText
	promptbutton
	end

.Brent:
	farwritetext BrentBattleRematchText
	promptbutton
	end

.Vance:
	farwritetext VanceBattleRematchText
	promptbutton
	end

.Wilton:
	farwritetext WiltonBattleRematchText
	promptbutton
	end

.Parry:
	farwritetext ParryBattleRematchText
	promptbutton
	end

PhoneScript_RematchText_Female:
	readvar VAR_CALLERID
	ifequal PHONE_COOLTRAINERF_BETH, .Beth
	ifequal PHONE_COOLTRAINERF_REENA, .Reena
	ifequal PHONE_PICNICKER_LIZ, .Liz
	ifequal PHONE_PICNICKER_GINA, .Gina
	ifequal PHONE_LASS_DANA, .Dana
	ifequal PHONE_PICNICKER_TIFFANY, .Tiffany
	ifequal PHONE_PICNICKER_ERIN, .Erin

.Beth:
	farwritetext BethBattleRematchText
	promptbutton
	end

.Reena:
	farwritetext ReenaBattleRematchText
	promptbutton
	end

.Liz:
	farwritetext LizBattleRematchText
	promptbutton
	end

.Gina:
	farwritetext GinaBattleRematchText
	promptbutton
	end

.Dana:
	farwritetext DanaBattleRematchText
	promptbutton
	end

.Tiffany:
	farwritetext TiffanyBattleRematchText
	promptbutton
	end

.Erin:
	farwritetext ErinBattleRematchText
	promptbutton
	end

LizWrongNumberScript:
	farwritetext LizWrongNumberText
	end

TiffanyItsAwful:
	farwritetext TiffanyItsAwfulText
	end

PhoneScript_HangupText_Male:
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
	farsjump Phone_GenericCall_Male

UnknownScript_0xa058e:
	farsjump PhoneScript_HangupText_Male

Phone_CheckIfUnseenRare_Female:
	scall PhoneScriptRareWildMon
	iffalse UnknownScript_0xa059c
	farsjump Phone_GenericCall_Female

UnknownScript_0xa059c:
	farsjump PhoneScript_HangupText_Female

PhoneScriptRareWildMon:
	special RandomPhoneRareWildMon
	end

PhoneScript_BugCatchingContest:
	readvar VAR_CALLERID
	ifequal PHONE_BUG_CATCHER_WADE, .Wade
	ifequal PHONE_POKEFANM_DEREK, .Derek

.Wade:
	farwritetext WadeBugCatchingContestText
	promptbutton
	sjump PhoneScript_HangupText_Male

.Derek:
	farwritetext DerekBugCatchingContestText
	promptbutton
	sjump PhoneScript_HangupText_Male

IrwinRocketRumorScript:
	farwritetext IrwinRocketTakeoverRumorText
	promptbutton
	sjump PhoneScript_HangupText_Male

GinaRocketRumorScript:
	farwritetext GinaRocketTakeoverRumorText
	promptbutton
	sjump PhoneScript_HangupText_Female

ArnieSwarmScript:
	farwritetext ArnieSwarmText
	promptbutton
	sjump PhoneScript_HangupText_Male

RalphItemScript:
	farwritetext RalphItemText
	promptbutton
	sjump PhoneScript_HangupText_Male

AnthonySwarmScript:
	farwritetext AnthonySwarmText
	promptbutton
	sjump PhoneScript_HangupText_Male

PhoneScript_FoundItem_Male:
	readvar VAR_CALLERID
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
	readvar VAR_CALLERID
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
	promptbutton
	sjump PhoneScript_HangupText_Male

KenjiCallingPhoneScript:
	farwritetext KenjiRemainDedicatedText
	promptbutton
	sjump PhoneScript_HangupText_Male

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
	promptbutton
	sjump PhoneScript_HangupText_Male

UnknownScript_0xa068a:
	farwritetext JackRolloutTriviaText
	promptbutton
	sjump PhoneScript_HangupText_Male

UnknownScript_0xa0692:
	farwritetext JackSolarbeamTriviaText
	promptbutton
	sjump PhoneScript_HangupText_Male

UnknownScript_0xa069a:
	farwritetext JackStompTriviaText
	promptbutton
	sjump PhoneScript_HangupText_Male

UnknownScript_0xa06a2:
	farwritetext JackGustTriviaText
	promptbutton
	sjump PhoneScript_HangupText_Male

UnknownScript_0xa06aa:
	farwritetext JackTwisterTriviaText
	promptbutton
	sjump PhoneScript_HangupText_Male

UnknownScript_0xa06b2:
	farwritetext JackEarthquakeTriviaText
	promptbutton
	sjump PhoneScript_HangupText_Male

UnknownScript_0xa06ba:
	farwritetext JackMagnitudeTriviaText
	promptbutton
	sjump PhoneScript_HangupText_Male

UnknownScript_0xa06c2:
	farwritetext JackSandstormTriviaText
	promptbutton
	sjump PhoneScript_HangupText_Male

UnknownScript_0xa06ca:
	farwritetext JackSunnyDayTriviaText
	promptbutton
	sjump PhoneScript_HangupText_Male

UnknownScript_0xa06d2:
	farwritetext JackRainDanceTriviaText
	promptbutton
	sjump PhoneScript_HangupText_Male

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
	promptbutton
	sjump PhoneScript_HangupText_Female

UnknownScript_0xa070c:
	farwritetext LizFalknerGossipText
	promptbutton
	sjump PhoneScript_HangupText_Female

UnknownScript_0xa0714:
	farwritetext LizEarlGossipText
	promptbutton
	sjump PhoneScript_HangupText_Female

UnknownScript_0xa071c:
	farwritetext LizSurfPikachuGossipText
	promptbutton
	sjump PhoneScript_HangupText_Female

UnknownScript_0xa0724:
	farwritetext LizMooMooMilkGossipText
	promptbutton
	sjump PhoneScript_HangupText_Female

UnknownScript_0xa072c:
	farwritetext LizSalonGossipText
	promptbutton
	sjump PhoneScript_HangupText_Female

UnknownScript_0xa0734:
	farwritetext LizWhitneyGossipText
	promptbutton
	sjump PhoneScript_HangupText_Female

UnknownScript_0xa073c:
	farwritetext LizBugCatchingContestGossipText
	promptbutton
	sjump PhoneScript_HangupText_Female

UnknownScript_0xa0744:
	farwritetext LizBeautifulMonGossipText
	promptbutton
	sjump PhoneScript_HangupText_Female

UnknownScript_0xa074c:
	farwritetext LizForgotGossipText
	promptbutton
	sjump PhoneScript_HangupText_Female

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
	promptbutton
	sjump PhoneScript_HangupText_Male

UnknownScript_0xa0786:
	farwritetext ChadDaisyGossipText
	promptbutton
	sjump PhoneScript_HangupText_Male

UnknownScript_0xa078e:
	farwritetext ChadProfElmGossipText
	promptbutton
	sjump PhoneScript_HangupText_Male

UnknownScript_0xa0796:
	farwritetext ChadProfOaksDreamGossipText
	promptbutton
	sjump PhoneScript_HangupText_Male

UnknownScript_0xa079e:
	farwritetext ChadKurtGossipText
	promptbutton
	sjump PhoneScript_HangupText_Male

UnknownScript_0xa07a6:
	farwritetext ChadLeagueGossipText
	promptbutton
	sjump PhoneScript_HangupText_Male

UnknownScript_0xa07ae:
	farwritetext ChadPokemonTalkGossipText
	promptbutton
	sjump PhoneScript_HangupText_Male

UnknownScript_0xa07b6:
	farwritetext ChadProfOakTrainerGossipText
	promptbutton
	sjump PhoneScript_HangupText_Male

UnknownScript_0xa07be:
	farwritetext ChadDaisyTeaGossipText
	promptbutton
	sjump PhoneScript_HangupText_Male

UnknownScript_0xa07c6:
	farwritetext ChadProfOakTravelingGossipText
	promptbutton
	sjump PhoneScript_HangupText_Male

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
	promptbutton
	sjump PhoneScript_HangupText_Male

UnknownScript_0xa0800:
	farwritetext BrentGrandpaGossipText
	promptbutton
	sjump PhoneScript_HangupText_Male

UnknownScript_0xa0808:
	farwritetext BrentGoldenrodGossipText
	promptbutton
	sjump PhoneScript_HangupText_Male

UnknownScript_0xa0810:
	farwritetext BrentRoute25GossipText
	promptbutton
	sjump PhoneScript_HangupText_Male

UnknownScript_0xa0818:
	farwritetext BrentAbraGossipText
	promptbutton
	sjump PhoneScript_HangupText_Male

UnknownScript_0xa0820:
	farwritetext BrentSisterGossipText
	promptbutton
	sjump PhoneScript_HangupText_Male

UnknownScript_0xa0828:
	farwritetext BrentMilkGossipText
	promptbutton
	sjump PhoneScript_HangupText_Male

UnknownScript_0xa0830:
	farwritetext BrentBattlingGossipText
	promptbutton
	sjump PhoneScript_HangupText_Male

UnknownScript_0xa0838:
	farwritetext BrentFlowerShopGossipText
	promptbutton
	sjump PhoneScript_HangupText_Male

UnknownScript_0xa0840:
	farwritetext BrentKimonoGirlGossipText
	promptbutton
	sjump PhoneScript_HangupText_Male

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
	promptbutton
	sjump PhoneScript_HangupText_Male

UnknownScript_0xa0898:
	farwritetext IrwinPlainBadgeGossipText
	promptbutton
	sjump PhoneScript_HangupText_Male

UnknownScript_0xa08a0:
	farwritetext IrwinJasmineReturnedGossipText
	promptbutton
	sjump PhoneScript_HangupText_Male

UnknownScript_0xa08a8:
	farwritetext IrwinRocketHideoutGossipText
	promptbutton
	sjump PhoneScript_HangupText_Male

UnknownScript_0xa08b0:
	farwritetext IrwinRadioTowerGossipText
	promptbutton
	sjump PhoneScript_HangupText_Male

UnknownScript_0xa08b8:
	farwritetext IrwinRisingBadgeGossipText
	promptbutton
	sjump PhoneScript_HangupText_Male

UnknownScript_0xa08c0:
	farwritetext IrwinEliteFourGossipText
	promptbutton
	sjump PhoneScript_HangupText_Male

UnknownScript_0xa08c8:
	farwritetext IrwinVermilionCityGossipText
	promptbutton
	sjump PhoneScript_HangupText_Male

UnknownScript_0xa08d0:
	farwritetext IrwinTrainPassGossipText
	promptbutton
	sjump PhoneScript_HangupText_Male

UnknownScript_0xa08d8:
	farwritetext IrwinSnorlaxGossipText
	promptbutton
	sjump PhoneScript_HangupText_Male

UnknownScript_0xa08e0:
	farwritetext IrwinMtSilverGossipText
	promptbutton
	sjump PhoneScript_HangupText_Male

UnknownScript_0xa08e8:
	farwritetext IrwinFogBadgeGossipText
	promptbutton
	sjump PhoneScript_HangupText_Male

UnknownScript_0xa08f0:
	farwritetext IrwinMarshBadgeGossipText
	promptbutton
	sjump PhoneScript_HangupText_Male

JackPhoneTipsScript:
	farwritetext JackHeardSomeGreatTipsText
	promptbutton
	sjump PhoneScript_HangupText_Male

BeverlyHangUpScript:
	farwritetext BeverlyLetsChatAboutMonAgainText
	promptbutton
	sjump PhoneScript_HangupText_Female

HueyHangUpScript:
	farwritetext HueyWeHaveToBattleAgainSometimeText
	promptbutton
	sjump PhoneScript_HangupText_Male

GavenHangUpNotThursdayScript:
	farwritetext GavenHangUpNotThursdayText
	promptbutton
	sjump PhoneScript_HangupText_Male

BethHangUpScript:
	farwritetext BethLetsBattleAgainSometimeText
	promptbutton
	sjump PhoneScript_HangupText_Female

JoseHangUpScript:
	farwritetext JoseHaventGottenItemYetText
	promptbutton
	sjump PhoneScript_HangupText_Male

ReenaForwardScript:
	farwritetext ReenaForwardText
	promptbutton
	sjump PhoneScript_HangupText_Female

JoeyHangUpScript:
	farwritetext JoeyDevisingStrategiesText
	promptbutton
	sjump PhoneScript_HangupText_Male

WadeNoBerriesScript:
	farwritetext WadeNoBerriesText
	promptbutton
	sjump PhoneScript_HangupText_Male

RalphNoItemScript:
	farwritetext RalphNoItemText
	promptbutton
	sjump PhoneScript_HangupText_Male

LizHangUpScript:
	farwritetext LizFawningOverMonText
	promptbutton
	sjump PhoneScript_HangupText_Female

AnthonyHangUpScript:
	farwritetext AnthonyWasntPayingAttentionText
	promptbutton
	sjump PhoneScript_HangupText_Male

ToddNoItemScript:
	farwritetext ToddSavingUpForBargainSaleText
	promptbutton
	sjump PhoneScript_HangupText_Male

GinaHangUpScript:
	farwritetext GinaHaventFoundAnythingYetText
	promptbutton
	sjump PhoneScript_HangupText_Female

ArnieHangUpScript:
	farwritetext ArnieHaventSeenRareMonText
	promptbutton
	sjump PhoneScript_HangupText_Male

AlanHangUpScript:
	farwritetext AlanHaventPickedUpAnythingText
	promptbutton
	sjump PhoneScript_HangupText_Male

DanaHangUpScript:
	farwritetext DanaCanYouWaitABitLongerText
	promptbutton
	sjump PhoneScript_HangupText_Female

ChadHangUpScript:
	farwritetext ChadGoingToStudyHardText
	promptbutton
	sjump PhoneScript_HangupText_Male

DerekHangUpScript:
	farwritetext DerekLetsGetTogetherText
	promptbutton
	sjump PhoneScript_HangupText_Male

TullyNoItemScript:
	farwritetext TullyNoItemText
	promptbutton
	sjump PhoneScript_HangupText_Male

BrentHangUpScript:
	farwritetext BrentSorryImTooBusyText
	promptbutton
	sjump PhoneScript_HangupText_Male

TiffanyNoItemScript:
	farwritetext TiffanyNoItemText
	promptbutton
	sjump PhoneScript_HangupText_Female

VanceLookingForwardScript:
	farwritetext VanceLookingForwardText
	promptbutton
	sjump PhoneScript_HangupText_Male

WiltonHaventFoundAnythingScript:
	farwritetext WiltonHaventFoundAnythingText
	promptbutton
	sjump PhoneScript_HangupText_Male

ParryBattleWithMeScript:
	farwritetext ParryBattleWithMeText
	promptbutton
	sjump PhoneScript_HangupText_Male

ErinWorkingHardScript:
	farwritetext ErinWorkingHardText
	promptbutton
	sjump PhoneScript_HangupText_Female

IrwinRandomTextScript:
	random 3
	ifequal 0, IrwinEscapadeScript
	ifequal 1, IrwinGoodMatchScript
	ifequal 2, IrwinSoMuchToChatAboutScript

IrwinEscapadeScript:
	farwritetext IrwinYourEscapadesRockText
	promptbutton
	sjump PhoneScript_HangupText_Male

IrwinGoodMatchScript:
	farwritetext IrwinGoodMatchText
	promptbutton
	sjump PhoneScript_HangupText_Male

IrwinSoMuchToChatAboutScript:
	farwritetext IrwinSoMuchToChatAboutText
	promptbutton
	sjump PhoneScript_HangupText_Male

KenjiAnswerPhoneScript:
	readvar VAR_KENJI_BREAK
	ifequal 2, UnknownScript_0xa0a00
	ifequal 1, UnknownScript_0xa0a08
	farwritetext KenjiCallMeBackAnotherTimeText
	promptbutton
	sjump PhoneScript_HangupText_Male

UnknownScript_0xa0a00:
	farwritetext KenjiIllHaveTimeToChatTomorrowText
	promptbutton
	sjump PhoneScript_HangupText_Male

UnknownScript_0xa0a08:
	checktime 1 << MORN
	iftrue UnknownScript_0xa0a1d
	checktime 1 << DAY
	iffalse UnknownScript_0xa0a25
	setevent EVENT_KENJI_ON_BREAK
	farwritetext KenjiTakingABreakText
	promptbutton
	sjump PhoneScript_HangupText_Male

UnknownScript_0xa0a1d:
	farwritetext KenjiHangUpMorningText
	promptbutton
	sjump PhoneScript_HangupText_Male

UnknownScript_0xa0a25:
	farwritetext KenjiHangUpNightText
	promptbutton
	sjump PhoneScript_HangupText_Male

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
	promptbutton
	sjump PhoneScript_HangupText_Female

WadeComeQuickScript:
	farwritetext WadeComeQuickText
	promptbutton
	sjump PhoneScript_HangupText_Male

GinaComePickUpScript:
	farwritetext GinaComePickUpText
	promptbutton
	sjump PhoneScript_HangupText_Female

AlanComePickUpScript:
	farwritetext AlanComePickUpGiftText
	promptbutton
	sjump PhoneScript_HangupText_Male

DanaComePickUpScript:
	farwritetext DanaComePickUpText
	promptbutton
	sjump PhoneScript_HangupText_Female

DerekComePickUpScript:
	farwritetext DerekComePickUpText
	promptbutton
	sjump PhoneScript_HangupText_Male

TullyHurryScript:
	farwritetext TullyHurryText
	promptbutton
	sjump PhoneScript_HangupText_Male

TiffanyHurryScript:
	farwritetext TiffanyHurryText
	promptbutton
	sjump PhoneScript_HangupText_Female

WiltonWantThisScript:
	farwritetext WiltonWantThisText
	promptbutton
	sjump PhoneScript_HangupText_Male

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
