

JackTriviaScript:
	random 11
	ifequalfwd  0, .Thunder
	ifequalfwd  1, .Rollout
	ifequalfwd  2, .Solarbeam
	ifequalfwd  3, .Stomp
	ifequalfwd  4, .Gust
	ifequalfwd  5, .Twister
	ifequalfwd  6, .Earthquake
	ifequalfwd  7, .Magnitude
	ifequalfwd  8, .Sandstorm
	ifequalfwd  9, .SunnyDay
	ifequalfwd 10, .RainDance

.Thunder:
	farwritetext JackThunderTriviaText
	promptbutton
	sjump PhoneScript_HangupText_Male

.Rollout:
	farwritetext JackRolloutTriviaText
	promptbutton
	sjump PhoneScript_HangupText_Male

.Solarbeam:
	farwritetext JackSolarbeamTriviaText
	promptbutton
	sjump PhoneScript_HangupText_Male

.Stomp:
	farwritetext JackStompTriviaText
	promptbutton
	sjump PhoneScript_HangupText_Male

.Gust:
	farwritetext JackGustTriviaText
	promptbutton
	sjump PhoneScript_HangupText_Male

.Twister:
	farwritetext JackKnockOffTriviaText
	promptbutton
	sjump PhoneScript_HangupText_Male

.Earthquake:
	farwritetext JackEarthquakeTriviaText
	promptbutton
	sjump PhoneScript_HangupText_Male

.Magnitude:
	farwritetext JackMagnitudeTriviaText
	promptbutton
	sjump PhoneScript_HangupText_Male

.Sandstorm:
	farwritetext JackSandstormTriviaText
	promptbutton
	sjump PhoneScript_HangupText_Male

.SunnyDay:
	farwritetext JackSunnyDayTriviaText
	promptbutton
	sjump PhoneScript_HangupText_Male

.RainDance:
	farwritetext JackRainDanceTriviaText
	promptbutton
	sjump PhoneScript_HangupText_Male

LizGossipRandomScript:
	random 10
	ifequalfwd 0, .RuinsOfAlph
	ifequalfwd 1, .Falkner
	ifequalfwd 2, .Earl
	ifequalfwd 3, .SurfPikachu
	ifequalfwd 4, .MooMooMilk
	ifequalfwd 5, .Salon
	ifequalfwd 6, .Whitney
	ifequalfwd 7, .BugCatchingContest
	ifequalfwd 8, .BeautifulTrainer
	ifequalfwd 9, .Forgot

.RuinsOfAlph:
	farwritetext LizRuinsOfAlphGossipText
	promptbutton
	sjump PhoneScript_HangupText_Female

.Falkner:
	farwritetext LizFalknerGossipText
	promptbutton
	sjump PhoneScript_HangupText_Female

.Earl:
	farwritetext LizEarlGossipText
	promptbutton
	sjump PhoneScript_HangupText_Female

.SurfPikachu:
	farwritetext LizSurfPikachuGossipText
	promptbutton
	sjump PhoneScript_HangupText_Female

.MooMooMilk:
	farwritetext LizMooMooMilkGossipText
	promptbutton
	sjump PhoneScript_HangupText_Female

.Salon:
	farwritetext LizSalonGossipText
	promptbutton
	sjump PhoneScript_HangupText_Female

.Whitney:
	farwritetext LizWhitneyGossipText
	promptbutton
	sjump PhoneScript_HangupText_Female

.BugCatchingContest:
	farwritetext LizBugCatchingContestGossipText
	promptbutton
	sjump PhoneScript_HangupText_Female

.BeautifulTrainer:
	farwritetext LizBeautifulMonGossipText
	promptbutton
	sjump PhoneScript_HangupText_Female

.Forgot:
	farwritetext LizForgotGossipText
	promptbutton
	sjump PhoneScript_HangupText_Female

ChadOakGossipScript:
	random 10
	ifequalfwd 0, .Blue
	ifequalfwd 1, .Daisy
	ifequalfwd 2, .ProfElm
	ifequalfwd 3, .Dream
	ifequalfwd 4, .Kurt
	ifequalfwd 5, .League
	ifequalfwd 6, .RadioShow
	ifequalfwd 7, .Battling
	ifequalfwd 8, .DaisyTea
	ifequalfwd 9, .Traveled

.Blue:
	farwritetext ChadBlueGossipText
	promptbutton
	sjump PhoneScript_HangupText_Male

.Daisy:
	farwritetext ChadDaisyGossipText
	promptbutton
	sjump PhoneScript_HangupText_Male

.ProfElm:
	farwritetext ChadProfElmGossipText
	promptbutton
	sjump PhoneScript_HangupText_Male

.Dream:
	farwritetext ChadProfOaksDreamGossipText
	promptbutton
	sjump PhoneScript_HangupText_Male

.Kurt:
	farwritetext ChadKurtGossipText
	promptbutton
	sjump PhoneScript_HangupText_Male

.League:
	farwritetext ChadLeagueGossipText
	promptbutton
	sjump PhoneScript_HangupText_Male

.RadioShow:
	farwritetext ChadPokemonTalkGossipText
	promptbutton
	sjump PhoneScript_HangupText_Male

.Battling:
	farwritetext ChadProfOakTrainerGossipText
	promptbutton
	sjump PhoneScript_HangupText_Male

.DaisyTea:
	farwritetext ChadDaisyTeaGossipText
	promptbutton
	sjump PhoneScript_HangupText_Male

.Traveled:
	farwritetext ChadProfOakTravelingGossipText
	promptbutton
	sjump PhoneScript_HangupText_Male

BrentBillTriviaScript:
	random 10
	ifequalfwd 0, .Father
	ifequalfwd 1, .Grandpa
	ifequalfwd 2, .Goldenrod
	ifequalfwd 3, .Route25
	ifequalfwd 4, .Abra
	ifequalfwd 5, .Sister
	ifequalfwd 6, .Milk
	ifequalfwd 7, .Battling
	ifequalfwd 8, .FlowerShop
	ifequalfwd 9, .KimonoGirl

.Father:
	farwritetext BrentFatherGossipText
	promptbutton
	sjump PhoneScript_HangupText_Male

.Grandpa:
	farwritetext BrentGrandpaGossipText
	promptbutton
	sjump PhoneScript_HangupText_Male

.Goldenrod:
	farwritetext BrentGoldenrodGossipText
	promptbutton
	sjump PhoneScript_HangupText_Male

.Route25:
	farwritetext BrentRoute25GossipText
	promptbutton
	sjump PhoneScript_HangupText_Male

.Abra:
	farwritetext BrentAbraGossipText
	promptbutton
	sjump PhoneScript_HangupText_Male

.Sister:
	farwritetext BrentSisterGossipText
	promptbutton
	sjump PhoneScript_HangupText_Male

.Milk:
	farwritetext BrentMilkGossipText
	promptbutton
	sjump PhoneScript_HangupText_Male

.Battling:
	farwritetext BrentBattlingGossipText
	promptbutton
	sjump PhoneScript_HangupText_Male

.FlowerShop:
	farwritetext BrentFlowerShopGossipText
	promptbutton
	sjump PhoneScript_HangupText_Male

.KimonoGirl:
	farwritetext BrentKimonoGirlGossipText
	promptbutton
	sjump PhoneScript_HangupText_Male

IrwinRumorScript:
	checkevent EVENT_OPENED_MT_SILVER
	iftruefwd .MtSilver
	checkevent EVENT_FOUGHT_SNORLAX
	iftruefwd .Snorlax
	checkevent EVENT_GOT_PASS_FROM_COPYCAT
	iftruefwd .TrainPass
	checkflag ENGINE_SOULBADGE
	iftruefwd .MarshBadge
	checkflag ENGINE_FLYPOINT_VERMILION
	iftruefwd .VermilionCity
	checkevent EVENT_BEAT_ELITE_FOUR
	iftruefwd .EliteFour
	checkflag ENGINE_RISINGBADGE
	iftruefwd .RisingBadge
	checkevent EVENT_CLEARED_RADIO_TOWER
	iftruefwd .RadioTower
	checkevent EVENT_CLEARED_ROCKET_HIDEOUT
	iftruefwd .RocketHideout
	checkevent EVENT_JASMINE_RETURNED_TO_GYM
	iftruefwd .JasmineReturned
	checkflag ENGINE_FOGBADGE
	iftruefwd .FogBadge
	checkflag ENGINE_PLAINBADGE
	iftruefwd .PlainBadge
	farwritetext IrwinCalledRightAwayText
	promptbutton
	sjump PhoneScript_HangupText_Male

.PlainBadge:
	farwritetext IrwinPlainBadgeGossipText
	promptbutton
	sjump PhoneScript_HangupText_Male

.JasmineReturned:
	farwritetext IrwinJasmineReturnedGossipText
	promptbutton
	sjump PhoneScript_HangupText_Male

.RocketHideout:
	farwritetext IrwinRocketHideoutGossipText
	promptbutton
	sjump PhoneScript_HangupText_Male

.RadioTower:
	farwritetext IrwinRadioTowerGossipText
	promptbutton
	sjump PhoneScript_HangupText_Male

.RisingBadge:
	farwritetext IrwinRisingBadgeGossipText
	promptbutton
	sjump PhoneScript_HangupText_Male

.EliteFour:
	farwritetext IrwinEliteFourGossipText
	promptbutton
	sjump PhoneScript_HangupText_Male

.VermilionCity:
	farwritetext IrwinVermilionCityGossipText
	promptbutton
	sjump PhoneScript_HangupText_Male

.TrainPass:
	farwritetext IrwinTrainPassGossipText
	promptbutton
	sjump PhoneScript_HangupText_Male

.Snorlax:
	farwritetext IrwinSnorlaxGossipText
	promptbutton
	sjump PhoneScript_HangupText_Male

.MtSilver:
	farwritetext IrwinMtSilverGossipText
	promptbutton
	sjump PhoneScript_HangupText_Male

.FogBadge:
	farwritetext IrwinFogBadgeGossipText
	promptbutton
	sjump PhoneScript_HangupText_Male

.MarshBadge:
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
	ifequalfwd 0, IrwinEscapadeScript
	ifequalfwd 1, IrwinGoodMatchScript
	ifequalfwd 2, IrwinSoMuchToChatAboutScript

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
	ifequalfwd 2, .Training
	ifequalfwd 1, .OnBreak
	farwritetext KenjiCallMeBackAnotherTimeText
	promptbutton
	sjump PhoneScript_HangupText_Male

.Training:
	farwritetext KenjiIllHaveTimeToChatTomorrowText
	promptbutton
	sjump PhoneScript_HangupText_Male

.OnBreak:
	checktime 1 << MORN
	iftruefwd .Morning
	checktime 1 << DAY
	iffalsefwd .Night
	setevent EVENT_KENJI_ON_BREAK
	farwritetext KenjiTakingABreakText
	promptbutton
	sjump PhoneScript_HangupText_Male

.Morning:
	farwritetext KenjiHangUpMorningText
	promptbutton
	sjump PhoneScript_HangupText_Male

.Night:
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


