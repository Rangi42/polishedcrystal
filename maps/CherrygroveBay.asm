CherrygroveBay_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events

	def_coord_events

	def_bg_events

	def_object_events
	object_event  9, 32, SPRITE_HIKER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, CherrygroveBayHikerScript, -1
	object_event 20, 22, SPRITE_HIKER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 2, GenericTrainerHikerTony, -1
	object_event 15, 43, SPRITE_FISHER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, CherrygroveBayFisherText, -1
	object_event  7, 39, SPRITE_SWIMMER_GUY, SPRITEMOVEDATA_SPINCLOCKWISE, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 2, GenericTrainerSwimmermThomas, -1
	object_event  7, 22, SPRITE_SWIMMER_GIRL, SPRITEMOVEDATA_SPINCOUNTERCLOCKWISE, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 4, GenericTrainerSwimmerfSally, -1
	object_event 22, 39, SPRITE_SWIMMER_GIRL, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 4, GenericTrainerSwimmerfTara, -1
	itemball_event 22, 24, SHINY_STONE, 1, EVENT_CHERRYGROVE_BAY_SHINY_STONE
	cuttree_event  3,  8, EVENT_CHERRYGROVE_BAY_CUT_TREE

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
	setval EARTH_POWER
	writetext ClearText
	special Special_MoveTutor
	ifequal $0, .TeachMove
.TutorRefused
	jumpopenedtext Text_CherrygroveBayTutorRefused

.NoSilverLeaf
	jumpopenedtext Text_CherrygroveBayTutorNoSilverLeaf

.TeachMove
	takeitem SILVER_LEAF
	jumpopenedtext Text_CherrygroveBayTutorTaught

GenericTrainerSwimmermThomas:
	generictrainer SWIMMERM, THOMAS, EVENT_BEAT_SWIMMERM_THOMAS, .SeenText, .BeatenText

	ctxt "My #mon knows"
	line "how to Surf, but"
	cont "I prefer swimming."
	done

.SeenText:
	ctxt "Do you know how to"
	line "swim? I can teach"
	cont "you, if you want."
	done

.BeatenText:
	ctxt "Glub, glub, glub…"
	done

GenericTrainerSwimmerfSally:
	generictrainer SWIMMERF, SALLY, EVENT_BEAT_SWIMMERF_SALLY, .SeenText, .BeatenText

	ctxt "I like drifting on"
	line "the waves along-"
	cont "side my #mon!"
	done

.SeenText:
	ctxt "I like this bay."
	line "Its waters are so"

	para "much calmer than"
	line "the open ocean."
	done

.BeatenText:
	ctxt "I don't like"
	line "losing, however…"
	done

GenericTrainerSwimmerfTara:
	generictrainer SWIMMERF, TARA, EVENT_BEAT_SWIMMERF_TARA, .SeenText, .BeatenText

	ctxt "There's a grove of"
	line "golden trees north"
	cont "of Ecruteak City."

	para "I'd love to visit"
	line "someday."
	done

.SeenText:
	ctxt "Ah, swimming amid"
	line "cherry blossoms is"
	cont "so relaxing!"
	done

.BeatenText:
	ctxt "I don't even mind"
	line "losing…"
	done

GenericTrainerHikerTony:
	generictrainer HIKER, TONY, EVENT_BEAT_HIKER_TONY, .SeenText, .BeatenText

	ctxt "After a long hike,"
	line "resting under the"

	para "cherry trees hits"
	line "the spot."
	done

.SeenText:
	ctxt "I hiked through"
	line "miles of woods"
	cont "to get here!"
	done

.BeatenText:
	ctxt "I'm exhausted…"
	done

CherrygroveBayFisherText:
	ctxt "I can watch"
	line "Cherrygrove City"

	para "from afar while"
	line "I fish."
	done

CherrygroveBayHikerText:
	ctxt "I don't believe in"
	line "legendary #mon"
	cont "creation myths."

	para "Johto was formed"
	line "over millions of"

	para "years by the power"
	line "of the earth!"
	done

Text_CherrygroveBayTutorEarthPower:
	ctxt "I can teach your"
	line "#mon how to"

	para "use Earth Power"
	line "for a Silver Leaf."
	done

Text_CherrygroveBayTutorNoSilverLeaf:
	ctxt "You don't have any"
	line "Silver Leaves…"
	done

Text_CherrygroveBayTutorQuestion:
	ctxt "Should I teach"
	line "your #mon"
	cont "Earth Power?"
	done

Text_CherrygroveBayTutorRefused:
	ctxt "Oh well."
	done

Text_CherrygroveBayTutorTaught:
	ctxt "Now your #mon"
	line "knows how to use"
	cont "Earth Power."
	done
