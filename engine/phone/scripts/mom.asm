MomPhoneScript:
	checkevent EVENT_TALKED_TO_MOM_AFTER_MYSTERY_EGG_QUEST
	iftruefwd .bcec5
	checkevent EVENT_LEARNED_TO_CATCH_POKEMON
	iftruefwd MomPhoneLectureScript
	checkevent EVENT_GAVE_MYSTERY_EGG_TO_ELM
	iftruefwd MomPhoneNoGymQuestScript
	checkevent EVENT_GOT_A_POKEMON_FROM_ELM
	iftruefwd MomPhoneNoPokedexScript
	sjumpfwd MomPhoneNoPokemonScript

.bcec5
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_8
	iftruefwd MomPhoneHangUpScript
	farwritetext MomPhoneGreetingText
	promptbutton
	getcurlandmarkname $0
	readvar VAR_ENVIRONMENT
	ifequalfwd TOWN, MomPhoneInTown
	ifequalfwd ROUTE, MomPhoneOnRoute
	sjumpfwd MomPhoneOther

MomPhoneLandmark:
	farwritetext MomPhoneLandmarkText
	promptbutton
	sjumpfwd MomSavingMoney

MomPhoneInTown:
	readvar VAR_MAPGROUP
	ifequalfwd GROUP_NEW_BARK_TOWN, .newbark
	ifequalfwd GROUP_CHERRYGROVE_CITY, .cherrygrove
	ifequalfwd GROUP_VIOLET_CITY, .violet
	ifequalfwd GROUP_AZALEA_TOWN, .azalea
	ifequalfwd GROUP_GOLDENROD_CITY, .goldenrod
	farwritetext MomPhoneGenericAreaText
	promptbutton
	sjumpfwd MomSavingMoney

.newbark
	farwritetext MomPhoneNewBarkText
	promptbutton
	sjumpfwd MomSavingMoney

.cherrygrove
	farwritetext MomPhoneCherrygroveText
	promptbutton
	sjumpfwd MomSavingMoney

.violet
	getlandmarkname SPROUT_TOWER, 1
	sjump MomPhoneLandmark
.azalea
	getlandmarkname SLOWPOKE_WELL, 1
	sjump MomPhoneLandmark
.goldenrod
	getlandmarkname RADIO_TOWER, 1
	sjump MomPhoneLandmark

MomPhoneOnRoute:
	farwritetext MomOtherAreaText
	promptbutton
	sjumpfwd MomSavingMoney

MomPhoneOther:
	farwritetext MomDeterminedText
	promptbutton
	; fallthrough

MomSavingMoney:
	checkflag ENGINE_MOM_SAVING_MONEY
	iffalsefwd .NotSaving
	checkmoney $1, 0
	ifequalfwd $0, .SavingHasMoney
	sjumpfwd .SavingNoMoney

.NotSaving:
	checkmoney $1, 0
	ifequalfwd $0, .HasMoney
	sjumpfwd .NoMoney

.SavingHasMoney:
	getmoney $1, $0
	farwritetext MomCheckBalanceText
	yesorno
	iftruefwd MomPhoneSaveMoneyScript
	sjumpfwd MomPhoneWontSaveMoneyScript

.SavingNoMoney:
	farwritetext MomImportantToSaveText
	yesorno
	iftruefwd MomPhoneSaveMoneyScript
	sjumpfwd MomPhoneWontSaveMoneyScript

.NoMoney:
	farwritetext MomYoureNotSavingText
	yesorno
	iftruefwd MomPhoneSaveMoneyScript
	sjumpfwd MomPhoneWontSaveMoneyScript

.HasMoney:
	getmoney $1, $0
	farwritetext MomYouveSavedText
	yesorno
	iftruefwd MomPhoneSaveMoneyScript
	sjumpfwd MomPhoneWontSaveMoneyScript

MomPhoneSaveMoneyScript:
	setflag ENGINE_MOM_SAVING_MONEY
	farwritetext MomOKIllSaveText
	promptbutton
	sjumpfwd MomPhoneHangUpScript

MomPhoneWontSaveMoneyScript:
	clearflag ENGINE_MOM_SAVING_MONEY
	farwritetext MomPhoneWontSaveMoneyText
	promptbutton
	; fallthrough

MomPhoneHangUpScript:
	farwritetext MomPhoneHangUpText
	end

MomPhoneNoPokemonScript:
	farwritetext MomPhoneNoPokemonText
	end

MomPhoneNoPokedexScript:
	farwritetext MomPhoneNoPokedexText
	end

MomPhoneNoGymQuestScript:
	farwritetext MomPhoneNoGymQuestText
	end

MomPhoneLectureScript:
	setevent EVENT_TALKED_TO_MOM_AFTER_MYSTERY_EGG_QUEST
	setflag ENGINE_MOM_ACTIVE
	specialphonecall SPECIALCALL_NONE
	farwritetext MomPhoneLectureText
	yesorno
	iftrue MomPhoneSaveMoneyScript
	sjump MomPhoneWontSaveMoneyScript
