BillPhoneScript1:
	checktime 1 << DAY
	iftruefwd .daygreet
	checktime 1 << MORN
	iffalsefwd .nitegreet
	farwritetext BillPhoneMornGreetingText
	promptbutton
	sjumpfwd .main

.daygreet
	farwritetext BillPhoneDayGreetingText
	promptbutton
	sjumpfwd .main

.nitegreet
	farwritetext BillPhoneNiteGreetingText
	promptbutton
	; fallthrough

.main
	farwritetext BillPhoneGenericText
	promptbutton
	readvar VAR_BOXSPACE
	getnum $0
	ifequalfwd $0, .full
	ifless $6, .nearlyfull
	farwritetext BillPhoneNotFullText
	end

.nearlyfull
	farwritetext BillPhoneNearlyFullText
	end

.full
	farwritetext BillPhoneFullText
	sjumpfwd BillPhoneScriptCheckForBoxes

BillPhoneScript2:
	readvar VAR_SPECIALPHONECALL
	ifequalfwd SPECIALCALL_SECONDBADGE, BillPhoneScriptSecondBadge
	farwritetext BillPhoneNewlyFullText
BillPhoneScriptCheckForBoxes:
	special BillBoxSwitchCheck
	ifequalfwd 0, BillPhoneWholePCFull
	farwritetext BillFlushBySaving
	yesorno
	iffalsefwd .rejected
	special Special_TryQuickSave
	iftruefwd .hang_up
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
