const_value set 2
	const CHERRYGROVEBAY_HIKER1
	const CHERRYGROVEBAY_HIKER2
	const CHERRYGROVEBAY_FISHER
	const CHERRYGROVEBAY_POKE_BALL

CherrygroveBay_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

CherrygroveBayHikerScript:
	faceplayer
	opentext
	checkevent EVENT_LISTENED_TO_EARTH_POWER_INTRO
	iftrue CherrygroveBayTutorEarthPowerScript
	writetext CherrygroveBayHikerText
	waitbutton
	setevent EVENT_LISTENED_TO_EARTH_POWER_INTRO
CherrygroveBayTutorEarthPowerScript:
	writetext Text_CherrygroveBayTutorEarthPower
	waitbutton
	checkitem SILVER_LEAF
	iffalse .NoSilverLeaf
	writetext Text_CherrygroveBayTutorQuestion
	yesorno
	iffalse .TutorRefused
	writebyte EARTH_POWER
	writetext Text_CherrygroveBayTutorClear
	special Special_MoveTutor
	if_equal $0, .TeachMove
.TutorRefused
	writetext Text_CherrygroveBayTutorRefused
	waitbutton
	closetext
	end

.NoSilverLeaf
	writetext Text_CherrygroveBayTutorNoSilverLeaf
	waitbutton
	closetext
	end

.TeachMove
	takeitem SILVER_LEAF
	writetext Text_CherrygroveBayTutorTaught
	waitbutton
	closetext
	end

TrainerHikerTony:
	trainer EVENT_BEAT_HIKER_TONY, HIKER, TONY, HikerTonySeenText, HikerTonyBeatenText, 0, TrainerHikerTonyScript

TrainerHikerTonyScript:
	end_if_just_battled
	opentext
	writetext HikerTonyAfterText
	waitbutton
	closetext
	end

CherrygroveBayFisherScript:
	jumptextfaceplayer CherrygroveBayFisherText

CherrygroveBayShinyStone:
	itemball SHINY_STONE

CherrygroveBayHikerText:
	text "I don't believe in"
	line "legendary #mon"
	cont "creation myths."

	para "Johto was formed"
	line "over millions of"

	para "years by the power"
	line "of the earth!"
	done

Text_CherrygroveBayTutorEarthPower:
	text "I can teach your"
	line "#mon how to"

	para "use Earth Power"
	line "for a Silver Leaf."
	done

Text_CherrygroveBayTutorNoSilverLeaf:
	text "You don't have any"
	line "Silver Leaves…"
	done

Text_CherrygroveBayTutorQuestion:
	text "Should I teach"
	line "your #mon"
	cont "Earth Power?"
	done

Text_CherrygroveBayTutorRefused:
	text "Oh well."
	done

Text_CherrygroveBayTutorClear:
	text ""
	done

Text_CherrygroveBayTutorTaught:
	text "Now your #mon"
	line "knows how to use"
	cont "Earth Power."
	done

HikerTonySeenText:
	text "I hiked through"
	line "miles of woods"
	cont "to get here!"
	done

HikerTonyBeatenText:
	text "I'm exhausted…"
	done

HikerTonyAfterText:
	text "After a long hike,"
	line "resting under the"

	para "cherry trees hits"
	line "the spot."
	done

CherrygroveBayFisherText:
	text "I can watch"
	line "Cherrygrove City"

	para "from afar while"
	line "I fish."
	done

CherrygroveBay_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 0

.XYTriggers:
	db 0

.Signposts:
	db 0

.PersonEvents:
	db 4
	person_event SPRITE_POKEFAN_M, 20, 9, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_SCRIPT, 0, CherrygroveBayHikerScript, -1
	person_event SPRITE_POKEFAN_M, 10, 21, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_TRAINER, 1, TrainerHikerTony, -1
	person_event SPRITE_FISHER, 21, 15, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_SCRIPT, 2, CherrygroveBayFisherScript, -1
	person_event SPRITE_BALL_CUT_FRUIT, 12, 22, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_ITEMBALL, 0, CherrygroveBayShinyStone, EVENT_CHERRYGROVE_BAY_SHINY_STONE
