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
