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
