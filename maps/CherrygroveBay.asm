CherrygroveBay_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 0 ; warp events

	db 0 ; coord events

	db 0 ; bg events

	db 8 ; object events
	object_event 9, 32, SPRITE_POKEFAN_M, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_SCRIPT, 0, CherrygroveBayHikerScript, -1
	object_event 21, 22, SPRITE_POKEFAN_M, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_TRAINER, 1, TrainerHikerTony, -1
	object_event 15, 33, SPRITE_FISHER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_COMMAND, jumptextfaceplayer, CherrygroveBayFisherText, -1
	object_event 7, 39, SPRITE_GUIDE_GENT, SPRITEMOVEDATA_SPINCLOCKWISE, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_TRAINER, 2, TrainerSwimmermThomas, -1
	object_event 7, 22, SPRITE_SWIMMER_GIRL, SPRITEMOVEDATA_SPINCOUNTERCLOCKWISE, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_TRAINER, 4, TrainerSwimmerfSally, -1
	object_event 22, 39, SPRITE_SWIMMER_GIRL, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_TRAINER, 4, TrainerSwimmerfTara, -1
	itemball_event 22, 24, SHINY_STONE, 1, EVENT_CHERRYGROVE_BAY_SHINY_STONE
	cuttree_event 3, 8, EVENT_CHERRYGROVE_BAY_CUT_TREE

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
	jumpopenedtext Text_CherrygroveBayTutorRefused

.NoSilverLeaf
	jumpopenedtext Text_CherrygroveBayTutorNoSilverLeaf

.TeachMove
	takeitem SILVER_LEAF
	jumpopenedtext Text_CherrygroveBayTutorTaught

TrainerSwimmermThomas:
	trainer SWIMMERM, THOMAS, EVENT_BEAT_SWIMMERM_THOMAS, .SeenText, .BeatenText, 0, .Script

.Script:
	end_if_just_battled
	jumptextfaceplayer .AfterText

.SeenText:
	text "Do you know how to"
	line "swim? I can teach"
	cont "you, if you want."
	done

.BeatenText:
	text "Glub, glub, glub…"
	done

.AfterText:
	text "My #mon knows"
	line "how to Surf, but"
	cont "I prefer swimming."
	done

TrainerSwimmerfSally:
	trainer SWIMMERF, SALLY, EVENT_BEAT_SWIMMERF_SALLY, .SeenText, .BeatenText, 0, .Script

.Script:
	end_if_just_battled
	jumptextfaceplayer .AfterText

.SeenText:
	text "I like this bay."
	line "Its waters are so"

	para "much calmer than"
	line "the open ocean."
	done

.BeatenText:
	text "I don't like"
	line "losing, however…"
	done

.AfterText:
	text "I like drifting on"
	line "the waves along-"
	cont "side my #mon!"
	done

TrainerSwimmerfTara:
	trainer SWIMMERF, TARA, EVENT_BEAT_SWIMMERF_TARA, .SeenText, .BeatenText, 0, .Script

.Script:
	end_if_just_battled
	jumptextfaceplayer .AfterText

.SeenText:
	text "Ah, swimming amid"
	line "cherry blossoms is"
	cont "so relaxing!"
	done

.BeatenText:
	text "I don't even mind"
	line "losing…"
	done

.AfterText:
	text "There's a grove of"
	line "golden trees north"
	cont "of Ecruteak City."

	para "I'd love to visit"
	line "someday."
	done

TrainerHikerTony:
	trainer HIKER, TONY, EVENT_BEAT_HIKER_TONY, .SeenText, .BeatenText, 0, .Script

.Script:
	end_if_just_battled
	jumptextfaceplayer .AfterText

.SeenText:
	text "I hiked through"
	line "miles of woods"
	cont "to get here!"
	done

.BeatenText:
	text "I'm exhausted…"
	done

.AfterText:
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
