

JackTriviaScript:
	random 11
	ifequalfwd  0, UnknownScript_0xa0682
	ifequalfwd  1, UnknownScript_0xa068a
	ifequalfwd  2, UnknownScript_0xa0692
	ifequalfwd  3, UnknownScript_0xa069a
	ifequalfwd  4, UnknownScript_0xa06a2
	ifequalfwd  5, UnknownScript_0xa06aa
	ifequalfwd  6, UnknownScript_0xa06b2
	ifequalfwd  7, UnknownScript_0xa06ba
	ifequalfwd  8, UnknownScript_0xa06c2
	ifequalfwd  9, UnknownScript_0xa06ca
	ifequalfwd 10, UnknownScript_0xa06d2

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
	farwritetext JackKnockOffTriviaText
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
	ifequalfwd 0, UnknownScript_0xa0704
	ifequalfwd 1, UnknownScript_0xa070c
	ifequalfwd 2, UnknownScript_0xa0714
	ifequalfwd 3, UnknownScript_0xa071c
	ifequalfwd 4, UnknownScript_0xa0724
	ifequalfwd 5, UnknownScript_0xa072c
	ifequalfwd 6, UnknownScript_0xa0734
	ifequalfwd 7, UnknownScript_0xa073c
	ifequalfwd 8, UnknownScript_0xa0744
	ifequalfwd 9, UnknownScript_0xa074c

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
	ifequalfwd 0, UnknownScript_0xa077e
	ifequalfwd 1, UnknownScript_0xa0786
	ifequalfwd 2, UnknownScript_0xa078e
	ifequalfwd 3, UnknownScript_0xa0796
	ifequalfwd 4, UnknownScript_0xa079e
	ifequalfwd 5, UnknownScript_0xa07a6
	ifequalfwd 6, UnknownScript_0xa07ae
	ifequalfwd 7, UnknownScript_0xa07b6
	ifequalfwd 8, UnknownScript_0xa07be
	ifequalfwd 9, UnknownScript_0xa07c6

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
	ifequalfwd 0, UnknownScript_0xa07f8
	ifequalfwd 1, UnknownScript_0xa0800
	ifequalfwd 2, UnknownScript_0xa0808
	ifequalfwd 3, UnknownScript_0xa0810
	ifequalfwd 4, UnknownScript_0xa0818
	ifequalfwd 5, UnknownScript_0xa0820
	ifequalfwd 6, UnknownScript_0xa0828
	ifequalfwd 7, UnknownScript_0xa0830
	ifequalfwd 8, UnknownScript_0xa0838
	ifequalfwd 9, UnknownScript_0xa0840

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
	iftruefwd UnknownScript_0xa08e0
	checkevent EVENT_FOUGHT_SNORLAX
	iftruefwd UnknownScript_0xa08d8
	checkevent EVENT_GOT_PASS_FROM_COPYCAT
	iftruefwd UnknownScript_0xa08d0
	checkflag ENGINE_SOULBADGE
	iftruefwd UnknownScript_0xa08f0
	checkflag ENGINE_FLYPOINT_VERMILION
	iftruefwd UnknownScript_0xa08c8
	checkevent EVENT_BEAT_ELITE_FOUR
	iftruefwd UnknownScript_0xa08c0
	checkflag ENGINE_RISINGBADGE
	iftruefwd UnknownScript_0xa08b8
	checkevent EVENT_CLEARED_RADIO_TOWER
	iftruefwd UnknownScript_0xa08b0
	checkevent EVENT_CLEARED_ROCKET_HIDEOUT
	iftruefwd UnknownScript_0xa08a8
	checkevent EVENT_JASMINE_RETURNED_TO_GYM
	iftruefwd UnknownScript_0xa08a0
	checkflag ENGINE_FOGBADGE
	iftruefwd UnknownScript_0xa08e8
	checkflag ENGINE_PLAINBADGE
	iftruefwd UnknownScript_0xa0898
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
	ifequalfwd 2, UnknownScript_0xa0a00
	ifequalfwd 1, UnknownScript_0xa0a08
	farwritetext KenjiCallMeBackAnotherTimeText
	promptbutton
	sjump PhoneScript_HangupText_Male

UnknownScript_0xa0a00:
	farwritetext KenjiIllHaveTimeToChatTomorrowText
	promptbutton
	sjump PhoneScript_HangupText_Male

UnknownScript_0xa0a08:
	checktime 1 << MORN
	iftruefwd UnknownScript_0xa0a1d
	checktime 1 << DAY
	iffalsefwd UnknownScript_0xa0a25
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


