const_value set 2
	const GOLDENRODHARBOR_FISHER1
	const GOLDENRODHARBOR_POKE_BALL
	const GOLDENRODHARBOR_ROCKET
	const GOLDENRODHARBOR_COOLTRAINER_F
	const GOLDENRODHARBOR_CLEFAIRY
	const GOLDENRODHARBOR_POKEFAN_M
	const GOLDENRODHARBOR_YOUNGSTER
	const GOLDENRODHARBOR_FISHER2

GoldenrodHarbor_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

GoldenrodHarborFisher1Script:
	faceplayer
	opentext
	checkevent EVENT_LISTENED_TO_HYPER_VOICE_INTRO
	iftrue GoldenrodHarborTutorHyperVoiceScript
	writetext GoldenrodHarborFisher1Text
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

GoldenrodHarborCooltrainerfScript:
	faceplayer
	opentext
	writetext GoldenrodHarborCooltrainerfText
	waitbutton
	pokemart MARTTYPE_STANDARD, MART_GOLDENROD_HARBOR
	closetext
	end

GoldenrodHarborClefairyDollScript:
	jumptextfaceplayer GoldenrodHarborClefairyDollText

GoldenrodHarborPokefanmScript:
	; EVENT_DECO_TENTACOOL_DOLL
	; EVENT_DECO_STARYU_DOLL
	; EVENT_DECO_SHELLDER_DOLL
	; EVENT_DECO_MAGIKARP_DOLL
	jumptextfaceplayer GoldenrodHarborPokefanmText

GoldenrodHarborYoungsterScript:
	; EVENT_DECO_PLANT_1
	; EVENT_DECO_PLANT_2
	; EVENT_DECO_PLANT_3
	jumptextfaceplayer GoldenrodHarborYoungsterText

GoldenrodHarborFisher2Script:
	jumptextfaceplayer GoldenrodHarborFisher2Text

GoldenrodHarborStarPiece:
	itemball STAR_PIECE

GoldenrodHarborSign:
	jumptext GoldenrodHarborSignText

GoldenrodHarborCrateSign:
	jumptext GoldenrodHarborCrateSignText

GoldenrodHarborFisher1Text:
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
	text "Okay then."
	done

Text_GoldenrodHarborTutorClear:
	text ""
	done

Text_GoldenrodHarborTutorTaught:
	text "Now your #mon"
	line "knows how to use"
	cont "Hyper Voice!"
	done

GoldenrodHarborCooltrainerfText:
	text "I picked up some"
	line "rare items abroad!"
	done

GoldenrodHarborClefairyDollText:
	text "This is a rare"
	line "#mon! Huh?"

	para "It's only a doll…"
	done

GoldenrodHarborPokefanmText:
	text "TODO"
	line "Doll Mart"
	done

GoldenrodHarborYoungsterText:
	text "TODO"
	line "Magna Plant"
	done

GoldenrodHarborFisher2Text:
	text "TODO"
	line "Chinchou"
	done

GoldenrodHarborSignText:
	text "Goldenrod Harbor"
	done

GoldenrodHarborCrateSignText:
	text "A crate full of"
	line "rare items!"
	done

GoldenrodHarbor_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 0

.XYTriggers:
	db 0

.Signposts:
	db 2
	signpost 19, 23, SIGNPOST_READ, GoldenrodHarborSign
	signpost 15, 24, SIGNPOST_READ, GoldenrodHarborCrateSign

.PersonEvents:
	db 8
	person_event SPRITE_FISHER, 7, 11, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, GoldenrodHarborFisher1Script, -1
	person_event SPRITE_POKE_BALL, 8, 7, SPRITEMOVEDATA_ITEM_TREE, 0, 0, -1, -1, 0, PERSONTYPE_ITEMBALL, 0, GoldenrodHarborStarPiece, EVENT_GOLDENROD_HARBOR_STAR_PIECE
	person_event SPRITE_ROCKET, 16, 32, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, ObjectEvent, EVENT_GOLDENROD_CITY_ROCKET_SCOUT
	person_event SPRITE_COOLTRAINER_F, 15, 23, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_SCRIPT, 0, GoldenrodHarborCooltrainerfScript, -1
	person_event SPRITE_CLEFAIRY, 15, 18, SPRITEMOVEDATA_ITEM_TREE, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, GoldenrodHarborClefairyDollScript, -1
	person_event SPRITE_POKEFAN_M, 15, 17, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, GoldenrodHarborPokefanmScript, -1
	person_event SPRITE_YOUNGSTER, 15, 12, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_SCRIPT, 0, GoldenrodHarborYoungsterScript, -1
	person_event SPRITE_FISHER, 21, 10, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, GoldenrodHarborFisher2Script, -1
