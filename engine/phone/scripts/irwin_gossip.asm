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
