const_value set 2
	const GOLDENRODHARBOR_FISHER
	const GOLDENRODHARBOR_POKE_BALL
	const GOLDENRODHARBOR_ROCKET

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

GoldenrodHarborStarPiece:
	itemball STAR_PIECE

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

GoldenrodHarbor_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 0

.XYTriggers:
	db 0

.Signposts:
	db 0

.PersonEvents:
	db 3
	person_event SPRITE_FISHER, 7, 11, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, GoldenrodHarborFisherScript, -1
	person_event SPRITE_POKE_BALL, 8, 7, SPRITEMOVEDATA_ITEM_TREE, 0, 0, -1, -1, 0, PERSONTYPE_ITEMBALL, 0, GoldenrodHarborStarPiece, EVENT_GOLDENROD_HARBOR_STAR_PIECE
	person_event SPRITE_ROCKET, 16, 32, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, ObjectEvent, EVENT_GOLDENROD_CITY_ROCKET_SCOUT
