GoldenrodHarbor_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

GoldenrodHarbor_MapEventHeader:

.Warps: db 2
	warp_def 16, 31, 1, GOLDENROD_HARBOR_GATE
	warp_def 17, 31, 2, GOLDENROD_HARBOR_GATE

.XYTriggers: db 0

.Signposts: db 3
	signpost 19, 29, SIGNPOST_JUMPTEXT, GoldenrodHarborSignText
	signpost 15, 28, SIGNPOST_JUMPTEXT, GoldenrodHarborCrateSignText
	signpost 21, 22, SIGNPOST_ITEM + REVIVE, EVENT_GOLDENROD_HARBOR_HIDDEN_REVIVE

.PersonEvents: db 12
	person_event SPRITE_FISHER, 3, 17, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_SCRIPT, 0, GoldenrodHarborFisherScript, -1
	person_event SPRITE_FISHER, 5, 13, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_TRAINER, 1, TrainerFisherPaton, -1
	itemball_event 3, 13, STAR_PIECE, 1, EVENT_GOLDENROD_HARBOR_STAR_PIECE
	person_event SPRITE_LASS, 15, 27, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_COMMAND, pokemart, MARTTYPE_ADVENTURER, MART_GOLDENROD_HARBOR, -1
	person_event SPRITE_POKEFAN_M, 15, 22, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, GoldenrodHarborPokefanmScript, -1
	person_event SPRITE_MAGIKARP, 15, 21, SPRITEMOVEDATA_DOLL, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_COMMAND, jumptextfaceplayer, GoldenrodHarborMagikarpText, -1
	person_event SPRITE_YOUNGSTER, 15, 16, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_SCRIPT, 0, GoldenrodHarborYoungsterScript, -1
	person_event SPRITE_FISHER, 20, 14, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_COMMAND, trade, TRADE_WITH_JACQUES_FOR_GRIMER, -1
	person_event SPRITE_ROCKET, 16, 40, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, ObjectEvent, EVENT_GOLDENROD_CITY_ROCKET_SCOUT
	person_event SPRITE_SWIMMER_GIRL, 8, 31, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_TRAINER, 5, TrainerSwimmerfKatie, -1
	person_event SPRITE_SWIMMER_GUY, 28, 18, SPRITEMOVEDATA_SPINCLOCKWISE, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_TRAINER, 3, TrainerSwimmermJames, -1
	person_event SPRITE_LASS, 19, 18, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_COMMAND, jumptextfaceplayer, GoldenrodHarborLass2Text, -1

GoldenrodHarborFisherScript:
	faceplayer
	opentext
	checkevent EVENT_LISTENED_TO_HYPER_VOICE_INTRO
	iftrue GoldenrodHarborTutorHyperVoiceScript
	writetext GoldenrodHarborFisherText
	waitbutton
	setevent EVENT_LISTENED_TO_HYPER_VOICE_INTRO
GoldenrodHarborTutorHyperVoiceScript:
	writetext Text_GoldenrodHarborTutorHyperVoice
	waitbutton
	checkitem SILVER_LEAF
	iffalse .NoSilverLeaf
	writetext Text_GoldenrodHarborTutorQuestion
	yesorno
	iffalse .TutorRefused
	writebyte HYPER_VOICE
	writetext Text_GoldenrodHarborTutorClear
	special Special_MoveTutor
	if_equal $0, .TeachMove
.TutorRefused
	jumpopenedtext Text_GoldenrodHarborTutorRefused

.NoSilverLeaf
	jumpopenedtext Text_GoldenrodHarborTutorNoSilverLeaf

.TeachMove
	takeitem SILVER_LEAF
	jumpopenedtext Text_GoldenrodHarborTutorTaught

TrainerFisherPaton:
	trainer EVENT_BEAT_FISHER_PATON, FISHER, PATON, FisherPatonSeenText, FisherPatonBeatenText, 0, TrainerFisherPatonScript

TrainerFisherPatonScript:
	end_if_just_battled
	jumptextfaceplayer FisherPatonAfterText

TrainerSwimmerfKatie:
	trainer EVENT_BEAT_SWIMMERF_KATIE, SWIMMERF, KATIE, SwimmerfKatieSeenText, SwimmerfKatieBeatenText, 0, SwimmerfKatieScript

SwimmerfKatieScript:
	end_if_just_battled
	jumptextfaceplayer SwimmerfKatieAfterText

TrainerSwimmermJames:
	trainer EVENT_BEAT_SWIMMERM_JAMES, SWIMMERM, JAMES, SwimmermJamesSeenText, SwimmermJamesBeatenText, 0, SwimmermJamesScript

SwimmermJamesScript:
	end_if_just_battled
	jumptextfaceplayer SwimmermJamesAfterText

GoldenrodHarborPokefanmScript:
	faceplayer
	opentext
	writetext GoldenrodHarborDollVendorText
.Start:
	special PlaceMoneyTopRight
	loadmenudata .MenuData
	verticalmenu
	closewindow
	if_equal $1, .MagikarpDoll
	if_equal $2, .TentacoolDoll
	if_equal $3, .ShellderDoll
	endtext

.MagikarpDoll:
	checkmoney $0, 1200
	if_equal $2, .NotEnoughMoney
	checkevent EVENT_DECO_MAGIKARP_DOLL
	iftrue .AlreadyBought
	takemoney $0, 1200
	setevent EVENT_DECO_MAGIKARP_DOLL
	writetext GoldenrodHarborMagikarpDollText
	playsound SFX_TRANSACTION
	waitbutton
	writetext GoldenrodHarborMagikarpDollSentText
	waitbutton
	jump .Start

.TentacoolDoll:
	checkmoney $0, 2400
	if_equal $2, .NotEnoughMoney
	checkevent EVENT_DECO_TENTACOOL_DOLL
	iftrue .AlreadyBought
	takemoney $0, 2400
	setevent EVENT_DECO_TENTACOOL_DOLL
	writetext GoldenrodHarborTentacoolDollText
	playsound SFX_TRANSACTION
	waitbutton
	writetext GoldenrodHarborTentacoolDollSentText
	waitbutton
	jump .Start

.ShellderDoll:
	checkmoney $0, 3600
	if_equal $2, .NotEnoughMoney
	checkevent EVENT_DECO_SHELLDER_DOLL
	iftrue .AlreadyBought
	takemoney $0, 3600
	setevent EVENT_DECO_SHELLDER_DOLL
	writetext GoldenrodHarborShellderDollText
	playsound SFX_TRANSACTION
	waitbutton
	writetext GoldenrodHarborShellderDollSentText
	waitbutton
	jump .Start

.NotEnoughMoney:
	writetext GoldenrodHarborNoMoneyText
	waitbutton
	jump .Start

.AlreadyBought:
	writetext GoldenrodHarborAlreadyBoughtText
	waitbutton
	jump .Start

.MenuData:
	db $40 ; flags
	db 02, 00 ; start coords
	db 11, 19 ; end coords
	dw .MenuData2
	db 1 ; default option

.MenuData2:
	db $80 ; flags
	db 4 ; items
	db "Magikarp    ¥1200@"
	db "Tentacool   ¥2400@"
	db "Shellder    ¥3600@"
	db "Cancel@"

GoldenrodHarborYoungsterScript:
	faceplayer
	opentext
	writetext GoldenrodHarborPlantVendorText
.Start:
	special PlaceMoneyTopRight
	loadmenudata .MenuData
	verticalmenu
	closewindow
	if_equal $1, .MagnaPlant
	if_equal $2, .TropicPlant
	if_equal $3, .JumboPlant
	endtext

.MagnaPlant:
	checkmoney $0, 5400
	if_equal $2, .NotEnoughMoney
	checkevent EVENT_DECO_PLANT_1
	iftrue .AlreadyBought
	takemoney $0, 5400
	setevent EVENT_DECO_PLANT_1
	writetext GoldenrodHarborMagnaPlantText
	playsound SFX_TRANSACTION
	waitbutton
	writetext GoldenrodHarborMagnaPlantSentText
	waitbutton
	jump .Start

.TropicPlant:
	checkmoney $0, 8600
	if_equal $2, .NotEnoughMoney
	checkevent EVENT_DECO_PLANT_2
	iftrue .AlreadyBought
	takemoney $0, 8600
	setevent EVENT_DECO_PLANT_2
	writetext GoldenrodHarborTropicPlantText
	playsound SFX_TRANSACTION
	waitbutton
	writetext GoldenrodHarborTropicPlantSentText
	waitbutton
	jump .Start

.JumboPlant:
	checkmoney $0, 10800
	if_equal $2, .NotEnoughMoney
	checkevent EVENT_DECO_PLANT_3
	iftrue .AlreadyBought
	takemoney $0, 10800
	setevent EVENT_DECO_PLANT_3
	writetext GoldenrodHarborJumboPlantText
	playsound SFX_TRANSACTION
	waitbutton
	writetext GoldenrodHarborJumboPlantSentText
	waitbutton
	jump .Start

.NotEnoughMoney:
	writetext GoldenrodHarborNoMoneyText
	waitbutton
	jump .Start

.AlreadyBought:
	writetext GoldenrodHarborAlreadyBoughtText
	waitbutton
	jump .Start

.MenuData:
	db $40 ; flags
	db 02, 00 ; start coords
	db 11, 19 ; end coords
	dw .MenuData2
	db 1 ; default option

.MenuData2:
	db $80 ; flags
	db 4 ; items
	db "Magna P.    ¥5400@"
	db "Tropic P.   ¥8600@"
	db "Jumbo P.   ¥10800@"
	db "Cancel@"

GoldenrodHarborFisherText:
	text "If you're fishing,"
	line "you have to be"

	para "quiet so you don't"
	line "scare the #mon."

	para "But to be heard"
	line "over the waves,"

	para "you have to say"
	line "things LOUD!"
	done

Text_GoldenrodHarborTutorHyperVoice:
	text "I can teach your"
	line "#mon how to"

	para "use Hyper Voice"
	line "for a Silver Leaf."
	done

Text_GoldenrodHarborTutorNoSilverLeaf:
	text "You don't have a"
	line "Silver Leaf!"
	done

Text_GoldenrodHarborTutorQuestion:
	text "Should I teach"
	line "your #mon"
	cont "Hyper Voice?"
	done

Text_GoldenrodHarborTutorRefused:
	text "OK then."
	done

Text_GoldenrodHarborTutorClear:
	text ""
	done

Text_GoldenrodHarborTutorTaught:
	text "Now your #mon"
	line "knows how to use"
	cont "Hyper Voice!"
	done

FisherPatonSeenText:
	text "The fish I caught"
	line "was attached to"
	cont "another #mon!"
	done

FisherPatonBeatenText:
	text "Aren't #mon"
	line "interesting?"
	done

FisherPatonAfterText:
	text "You're working"
	line "on a #dex?"
	cont "That's neat!"
	done

SwimmerfKatieSeenText:
	text "Swimming in the"
	line "deep blue sea"
	cont "feels wonderful!"
	done

SwimmerfKatieBeatenText:
	text "I lost…"
	line "Now I feel blue…"
	done

SwimmerfKatieAfterText:
	text "Why is the sea"
	line "blue?"

	para "I heard it ref-"
	line "lects the sky…"

	para "But then why is"
	line "the sky blue?"
	done

SwimmermJamesSeenText:
	text "I can swim, but"
	line "I can also row!"
	done

SwimmermJamesBeatenText:
	text "Maybe I can't"
	line "battle…"
	done

SwimmermJamesAfterText:
	text "Can't a Swimmer"
	line "use a rowboat"
	cont "sometimes?"
	done

GoldenrodHarborMagikarpText:
	text "This is a Fish"
	line "#mon! Huh?"

	para "It's only a doll…"
	done

GoldenrodHarborDollVendorText:
	text "Welcome! I have"
	line "adorable aquatic"
	cont "dolls for sale."
	done

GoldenrodHarborMagikarpDollText:
	text "<PLAYER> bought"
	line "Magikarp Doll."
	done

GoldenrodHarborMagikarpDollSentText:
	text "Magikarp Doll"
	line "was sent home."
	done

GoldenrodHarborTentacoolDollText:
	text "<PLAYER> bought"
	line "Tentacool Doll."
	done

GoldenrodHarborTentacoolDollSentText:
	text "Tentacool Doll"
	line "was sent home."
	done

GoldenrodHarborShellderDollText:
	text "<PLAYER> bought"
	line "Shellder Doll."
	done

GoldenrodHarborShellderDollSentText:
	text "Shellder Doll"
	line "was sent home."
	done

GoldenrodHarborNoMoneyText:
	text "You can't afford"
	line "that!"
	done

GoldenrodHarborAlreadyBoughtText:
	text "You already have"
	line "that!"
	done

GoldenrodHarborPlantVendorText:
	text "Welcome! I have"
	line "a selection of"

	para "exotic plants to"
	line "adorn your home."
	done

GoldenrodHarborMagnaPlantText:
	text "<PLAYER> bought"
	line "Magna Plant."
	done

GoldenrodHarborMagnaPlantSentText:
	text "Magna Plant"
	line "was sent home."
	done

GoldenrodHarborTropicPlantText:
	text "<PLAYER> bought"
	line "Tropic Plant."
	done

GoldenrodHarborTropicPlantSentText:
	text "Tropic Plant"
	line "was sent home."
	done

GoldenrodHarborJumboPlantText:
	text "<PLAYER> bought"
	line "Jumbo Plant."
	done

GoldenrodHarborJumboPlantSentText:
	text "Jumbo Plant"
	line "was sent home."
	done

GoldenrodHarborLass2Text:
	text "All this water,"
	line "it's totally…"

	para "bloop-bloop,"
	line "splish-splish."

	para "Don't you agree?"
	done

GoldenrodHarborSignText:
	text "Goldenrod Harbor"
	done

GoldenrodHarborCrateSignText:
	text "A crate full of"
	line "rare items!"
	done
