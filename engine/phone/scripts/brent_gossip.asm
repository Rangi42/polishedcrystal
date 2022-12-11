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
