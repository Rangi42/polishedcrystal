const_value set 2
	const GOLDENRODHARBOR_FISHER1
	const GOLDENRODHARBOR_FISHER2
	const GOLDENRODHARBOR_POKE_BALL
	const GOLDENRODHARBOR_LASS1
	const GOLDENRODHARBOR_POKEFAN_M
	const GOLDENRODHARBOR_MAGIKARP
	const GOLDENRODHARBOR_YOUNGSTER
	const GOLDENRODHARBOR_JACQUES
	const GOLDENRODHARBOR_ROCKET
	const GOLDENRODHARBOR_SWIMMER_GIRL
	const GOLDENRODHARBOR_SWIMMER_GUY
	const GOLDENRODHARBOR_LASS2

GoldenrodHarbor_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

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
	writetext Text_GoldenrodHarborTutorRefused
	waitbutton
	closetext
	end

.NoSilverLeaf
	writetext Text_GoldenrodHarborTutorNoSilverLeaf
	waitbutton
	closetext
	end

.TeachMove
	takeitem SILVER_LEAF
	writetext Text_GoldenrodHarborTutorTaught
	waitbutton
	closetext
	end

TrainerFisherPaton:
	trainer EVENT_BEAT_FISHER_PATON, FISHER, PATON, FisherPatonSeenText, FisherPatonBeatenText, 0, TrainerFisherPatonScript

TrainerFisherPatonScript:
	end_if_just_battled
	opentext
	writetext FisherPatonAfterText
	waitbutton
	closetext
	end

TrainerSwimmerfKatie:
	trainer EVENT_BEAT_SWIMMERF_KATIE, SWIMMERF, KATIE, SwimmerfKatieSeenText, SwimmerfKatieBeatenText, 0, SwimmerfKatieScript

SwimmerfKatieScript:
	end_if_just_battled
	opentext
	writetext SwimmerfKatieAfterText
	waitbutton
	closetext
	end

TrainerSwimmermJames:
	trainer EVENT_BEAT_SWIMMERM_JAMES, SWIMMERM, JAMES, SwimmermJamesSeenText, SwimmermJamesBeatenText, 0, SwimmermJamesScript

SwimmermJamesScript:
	end_if_just_battled
	opentext
	writetext SwimmermJamesAfterText
	waitbutton
	closetext
	end

GoldenrodHarborLass1Script:
	faceplayer
	opentext
	pokemart MARTTYPE_ADVENTURER, MART_GOLDENROD_HARBOR
	closetext
	end

GoldenrodHarborMagikarpScript:
	jumptextfaceplayer GoldenrodHarborMagikarpText

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
	closetext
	end

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
	closetext
	end

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

Jacques:
	faceplayer
	opentext
	trade $6
	waitbutton
	closetext
	end

GoldenrodHarborLass2Script:
	jumptextfaceplayer GoldenrodHarborLass2Text

GoldenrodHarborStarPiece:
	itemball STAR_PIECE

GoldenrodHarborSign:
	jumptext GoldenrodHarborSignText

GoldenrodHarborCrateSign:
	jumptext GoldenrodHarborCrateSignText

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

GoldenrodHarbor_MapEventHeader:
.Warps:
	db 2
	warp_def $10, $1f, 1, GOLDENROD_HARBOR_GATE
	warp_def $11, $1f, 2, GOLDENROD_HARBOR_GATE

.XYTriggers:
	db 0

.Signposts:
	db 2
	signpost 19, 29, SIGNPOST_READ, GoldenrodHarborSign
	signpost 15, 28, SIGNPOST_READ, GoldenrodHarborCrateSign

.PersonEvents:
	db 12
	person_event SPRITE_FISHER, 3, 17, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_SCRIPT, 0, GoldenrodHarborFisherScript, -1
	person_event SPRITE_FISHER, 5, 13, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_TRAINER, 1, TrainerFisherPaton, -1
	person_event SPRITE_BALL_CUT_FRUIT, 3, 13, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_ITEMBALL, 0, GoldenrodHarborStarPiece, EVENT_GOLDENROD_HARBOR_STAR_PIECE
	person_event SPRITE_LASS, 15, 27, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_SCRIPT, 0, GoldenrodHarborLass1Script, -1
	person_event SPRITE_POKEFAN_M, 15, 22, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, GoldenrodHarborPokefanmScript, -1
	person_event SPRITE_MAGIKARP, 15, 21, SPRITEMOVEDATA_DOLL, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, GoldenrodHarborMagikarpScript, -1
	person_event SPRITE_YOUNGSTER, 15, 16, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_SCRIPT, 0, GoldenrodHarborYoungsterScript, -1
	person_event SPRITE_FISHER, 20, 14, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_SCRIPT, 0, Jacques, -1
	person_event SPRITE_ROCKET, 16, 40, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, ObjectEvent, EVENT_GOLDENROD_CITY_ROCKET_SCOUT
	person_event SPRITE_SWIMMER_GIRL, 8, 31, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_TRAINER, 5, TrainerSwimmerfKatie, -1
	person_event SPRITE_SWIMMER_GUY, 28, 18, SPRITEMOVEDATA_SPINCLOCKWISE, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_TRAINER, 3, TrainerSwimmermJames, -1
	person_event SPRITE_LASS, 19, 18, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, GoldenrodHarborLass2Script, -1
