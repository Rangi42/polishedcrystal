BuenaPhoneScript1:
	checkflag ENGINE_ROCKETS_IN_RADIO_TOWER
	iftrue BuenaPhoneScript_Rocket
	checkcode VAR_HOUR
	ifgreater 17, BuenaPhoneScript_AfterMidnight1
	scall BuenaPhoneScript_CheckTimeOfDay1
	jump BuenaPhoneScript_Random1

BuenaPhoneScript2:
	checkflag ENGINE_ROCKETS_IN_RADIO_TOWER
	iftrue BuenaPhoneScript_Rocket
	scall BuenaPhoneScript_CheckTimeOfDay2
	jump BuenaPhoneScript_Random2

BuenaPhoneScript_CheckTimeOfDay1:
	checktime 1 << MORN
	iftrue .morn
	checktime 1 << DAY
	iftrue .day
	writetext BuenaPhoneNiteAnswerText
	buttonsound
	end

.morn
	writetext BuenaPhoneMorningAnswerText
	buttonsound
	end

.day
	writetext BuenaPhoneDayAnswerText
	buttonsound
	end

BuenaPhoneScript_AfterMidnight1:
	writetext BuenaPhoneMidnightAnswerText
	end

BuenaPhoneScript_CheckTimeOfDay2:
	checkcode VAR_HOUR
	ifgreater 17, BuenaPhoneScript_AfterMidnight2
	checktime 1 << MORN
	iftrue .morn
	checktime 1 << DAY
	iftrue .day
	writetext BuenaPhoneNiteText
	buttonsound
	end

.morn
	writetext BuenaPhoneMorningText
	buttonsound
	end

.day
	writetext BuenaPhoneDayText
	buttonsound
	end

BuenaPhoneScript_AfterMidnight2:
	writetext BuenaPhoneMidnightText
	buttonsound
	end

BuenaPhoneScript_Rocket:
	writetext BuenaPhoneRocketText
	end

BuenaPhoneScript_Random2:
	checkevent EVENT_BEAT_ELITE_FOUR
	iftrue .PostE4
	random 11
	jump .Jumptable

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
	jump .finish

.one
	writetext BuenaPhoneReceptionistText
	jump .finish

.two
	writetext BuenaPhoneLuckyNumberShowText
	jump .finish

.three
	writetext BuenaPhoneStressedFromWorkText
	jump .finish

.four
	writetext BuenaPhoneProfessorOakText
	jump .finish

.five
	writetext BuenaPhoneGotAColdText
	jump .finish

.six
	writetext BuenaPhoneRadioCardQuestionsText
	jump .finish

.seven
	writetext BuenaPhonePikachuFanClubText
	jump .finish

.eight
	writetext BuenaPhoneRadioTowerDirectorText
	jump .finish

.nine
	writetext BuenaPhoneWhenDoYouRelaxText
	jump .finish

.ten
	writetext BuenaPhoneStarterPokemonText
	jump .finish

.eleven
	writetext BuenaPhoneCompanyVacationText
	jump .finish

.twelve
	writetext BuenaPhoneBenAndFernText
	jump .finish

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
