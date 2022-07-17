BuenaPhoneScript1:
	checkflag ENGINE_ROCKETS_IN_RADIO_TOWER
	iftruefwd BuenaPhoneScript_Rocket
	readvar VAR_HOUR
	ifgreater 17, BuenaPhoneScript_AfterMidnight1
	scall BuenaPhoneScript_CheckTimeOfDay1
	sjumpfwd BuenaPhoneScript_Random1

BuenaPhoneScript2:
	checkflag ENGINE_ROCKETS_IN_RADIO_TOWER
	iftruefwd BuenaPhoneScript_Rocket
	scall BuenaPhoneScript_CheckTimeOfDay2
	sjumpfwd BuenaPhoneScript_Random2

BuenaPhoneScript_CheckTimeOfDay1:
	checktime 1 << MORN
	iftruefwd .morn
	checktime 1 << DAY
	iftruefwd .day
	writetext BuenaPhoneNiteAnswerText
	promptbutton
	end

.morn
	writetext BuenaPhoneMorningAnswerText
	promptbutton
	end

.day
	writetext BuenaPhoneDayAnswerText
	promptbutton
	end

BuenaPhoneScript_AfterMidnight1:
	writetext BuenaPhoneMidnightAnswerText
	end

BuenaPhoneScript_CheckTimeOfDay2:
	readvar VAR_HOUR
	ifgreater 17, BuenaPhoneScript_AfterMidnight2
	checktime 1 << MORN
	iftruefwd .morn
	checktime 1 << DAY
	iftruefwd .day
	writetext BuenaPhoneNiteText
	promptbutton
	end

.morn
	writetext BuenaPhoneMorningText
	promptbutton
	end

.day
	writetext BuenaPhoneDayText
	promptbutton
	end

BuenaPhoneScript_AfterMidnight2:
	writetext BuenaPhoneMidnightText
	promptbutton
	end

BuenaPhoneScript_Rocket:
	writetext BuenaPhoneRocketText
	end

BuenaPhoneScript_Random2:
	checkevent EVENT_BEAT_ELITE_FOUR
	iftruefwd .PostE4
	random 11
	sjumpfwd .Jumptable

.PostE4:
	random 14

.Jumptable:
	ifequalfwd 0, .zero
	ifequalfwd 1, .one
	ifequalfwd 2, .two
	ifequalfwd 3, .three
	ifequalfwd 4, .four
	ifequalfwd 5, .five
	ifequalfwd 6, .six
	ifequalfwd 7, .seven
	ifequalfwd 8, .eight
	ifequalfwd 9, .nine
	ifequalfwd 10, .ten
	ifequalfwd 11, .eleven
	ifequalfwd 12, .twelve
	ifequalfwd 13, .thirteen

.zero
	writetext BuenaPhoneWentOutWithBenText
	sjumpfwd .finish

.one
	writetext BuenaPhoneReceptionistText
	sjumpfwd .finish

.two
	writetext BuenaPhoneLuckyNumberShowText
	sjumpfwd .finish

.three
	writetext BuenaPhoneStressedFromWorkText
	sjumpfwd .finish

.four
	writetext BuenaPhoneProfessorOakText
	sjumpfwd .finish

.five
	writetext BuenaPhoneGotAColdText
	sjumpfwd .finish

.six
	writetext BuenaPhoneRadioCardQuestionsText
	sjumpfwd .finish

.seven
	writetext BuenaPhonePikachuFanClubText
	sjumpfwd .finish

.eight
	writetext BuenaPhoneRadioTowerDirectorText
	sjumpfwd .finish

.nine
	writetext BuenaPhoneWhenDoYouRelaxText
	sjumpfwd .finish

.ten
	writetext BuenaPhoneStarterPokemonText
	sjumpfwd .finish

.eleven
	writetext BuenaPhoneCompanyVacationText
	sjumpfwd .finish

.twelve
	writetext BuenaPhoneBenAndFernText
	sjumpfwd .finish

.thirteen
	writetext BuenaPhoneGoingShoppingText

.finish
	end

BuenaPhoneScript_Random1:
	random 3
	ifequalfwd 0, .zero
	ifequalfwd 1, .one
	ifequalfwd 2, .two

.zero
	writetext BuenaPhoneFavoriteSlotMachineAnswerText
	end

.one
	writetext BuenaPhonePokegearAnswerText
	end

.two
	writetext BuenaPhoneCoopedUpInRadioTowerAnswerText
	end

INCLUDE "data/phone/text/buena.asm"
