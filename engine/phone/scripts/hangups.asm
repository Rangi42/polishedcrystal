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

JoeyHangUpScript: ; TODO: use this
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
