BuenaPhoneScript1:
	checkflag ENGINE_ROCKETS_IN_RADIO_TOWER
	iftrue BuenaPhoneScript_Rocket
	readvar VAR_HOUR
	ifgreater 17, BuenaPhoneScript_AfterMidnight1
	scall BuenaPhoneScript_CheckTimeOfDay1
	sjump BuenaPhoneScript_Random1

BuenaPhoneScript2:
	checkflag ENGINE_ROCKETS_IN_RADIO_TOWER
	iftrue BuenaPhoneScript_Rocket
	scall BuenaPhoneScript_CheckTimeOfDay2
	sjump BuenaPhoneScript_Random2

BuenaPhoneScript_CheckTimeOfDay1:
	checktime 1 << MORN
	iftrue .morn
	checktime 1 << DAY
	iftrue .day
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
	iftrue .morn
	checktime 1 << DAY
	iftrue .day
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
	iftrue .PostE4
	random 11
	sjump .Jumptable

.PostE4:
	random 14

.Jumptable:
	ifequal 0, .zero
	ifequal 1, .one
	ifequal 2, .two
	ifequal 3, .three
	ifequal 4, .four
	ifequal 5, .five
	ifequal 6, .six
	ifequal 7, .seven
	ifequal 8, .eight
	ifequal 9, .nine
	ifequal 10, .ten
	ifequal 11, .eleven
	ifequal 12, .twelve
	ifequal 13, .thirteen

.zero
	writetext BuenaPhoneWentOutWithBenText
	sjump .finish

.one
	writetext BuenaPhoneReceptionistText
	sjump .finish

.two
	writetext BuenaPhoneLuckyNumberShowText
	sjump .finish

.three
	writetext BuenaPhoneStressedFromWorkText
	sjump .finish

.four
	writetext BuenaPhoneProfessorOakText
	sjump .finish

.five
	writetext BuenaPhoneGotAColdText
	sjump .finish

.six
	writetext BuenaPhoneRadioCardQuestionsText
	sjump .finish

.seven
	writetext BuenaPhonePikachuFanClubText
	sjump .finish

.eight
	writetext BuenaPhoneRadioTowerDirectorText
	sjump .finish

.nine
	writetext BuenaPhoneWhenDoYouRelaxText
	sjump .finish

.ten
	writetext BuenaPhoneStarterPokemonText
	sjump .finish

.eleven
	writetext BuenaPhoneCompanyVacationText
	sjump .finish

.twelve
	writetext BuenaPhoneBenAndFernText
	sjump .finish

.thirteen
	writetext BuenaPhoneGoingShoppingText

.finish
	end

BuenaPhoneScript_Random1:
	random 3
	ifequal 0, .zero
	ifequal 1, .one
	ifequal 2, .two

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
