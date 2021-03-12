Route4_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  4,  7, MOUNT_MOON_B1F, 8
	warp_event 19,  5, MOUNT_MOON_SQUARE, 1

	def_coord_events

	def_bg_events
	bg_event  7,  9, BGEVENT_JUMPTEXT, MtMoonSignText
	bg_event 17,  9, BGEVENT_JUMPTEXT, CableCarSignText
	bg_event 15,  4, BGEVENT_ITEM + ULTRA_BALL, EVENT_ROUTE_4_HIDDEN_ULTRA_BALL

	def_object_events
	object_event 51,  5, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 5, GenericTrainerYoungsterOliver, -1
	object_event 38, 13, SPRITE_LASS, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 5, GenericTrainerLassJennifer, -1
	object_event 28,  6, SPRITE_BIRD_KEEPER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerBird_keeperHank, -1
	object_event 12, 10, SPRITE_PICNICKER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 5, GenericTrainerPicnickerHope, -1
	object_event 35,  8, SPRITE_PICNICKER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 4, GenericTrainerPicnickerSharon, -1
	object_event 26, 13, SPRITE_POKEMANIAC, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, Route4SuperNerd1Script, -1
	object_event 29, 13, SPRITE_POKEMANIAC, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, Route4SuperNerd2Script, -1
	object_event 19,  7, SPRITE_ENGINEER, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, Route4EngineerScript, EVENT_MT_MOON_RIVAL
	object_event 17,  5, SPRITE_ENGINEER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, ObjectEvent, EVENT_MT_MOON_RIVAL
	itemball_event 42,  5, HP_UP, 1, EVENT_ROUTE_4_HP_UP
	object_event 68,  6, SPRITE_ACE_TRAINER_M, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, ObjectEvent, EVENT_BEAT_BLUE

GenericTrainerYoungsterOliver:
	generictrainer YOUNGSTER, OLIVER, EVENT_BEAT_YOUNGSTER_OLIVER, YoungsterOliverSeenText, YoungsterOliverBeatenText

	text "People say that"
	line "I ask too many"
	cont "questions, but"

	para "that's what kids"
	line "do, right?"
	done

GenericTrainerLassJennifer:
	generictrainer LASS, JENNIFER, EVENT_BEAT_LASS_JENNIFER, LassJenniferSeenText, LassJenniferBeatenText

	text "#mon are so"
	line "much fun."
	cont "Don't you agree?"
	done

GenericTrainerBird_keeperHank:
	generictrainer BIRD_KEEPER, HANK, EVENT_BEAT_BIRD_KEEPER_HANK, Bird_keeperHankSeenText, Bird_keeperHankBeatenText

	text "If you have a"
	line "specific #mon"

	para "that you want to"
	line "raise, put it out"

	para "first, then switch"
	line "it right away."

	para "That's how to do"
	line "it."
	done

GenericTrainerPicnickerHope:
	generictrainer PICNICKER, HOPE, EVENT_BEAT_PICNICKER_HOPE, PicnickerHopeSeenText, PicnickerHopeBeatenText

	text "I heard Clefairy"
	line "appear at Mt.Moon."

	para "But where could"
	line "they be?"
	done

GenericTrainerPicnickerSharon:
	generictrainer PICNICKER, SHARON, EVENT_BEAT_PICNICKER_SHARON, PicnickerSharonSeenText, PicnickerSharonBeatenText

	text "……I'll go train"
	line "some more…"
	done

Route4SuperNerd1Script:
	faceplayer
	opentext
	checkevent EVENT_LISTENED_TO_IRON_HEAD_INTRO
	iftrue Route4TutorIronHeadScript
	writetext Route4SuperNerd1Text
	waitbutton
	setevent EVENT_LISTENED_TO_IRON_HEAD_INTRO
Route4TutorIronHeadScript:
	writetext Text_Route4TutorIronHead
	waitbutton
	checkitem SILVER_LEAF
	iffalse .NoSilverLeaf
	writetext Text_Route4Tutor1Question
	yesorno
	iffalse .TutorRefused
	setval IRON_HEAD
	writetext ClearText
	special Special_MoveTutor
	ifequal $0, .TeachMove
.TutorRefused
	jumpopenedtext Text_Route4Tutor1Refused

.NoSilverLeaf
	jumpopenedtext Text_Route4TutorsNoSilverLeaf

.TeachMove
	takeitem SILVER_LEAF
	jumpopenedtext Text_Route4Tutor1Taught

Route4SuperNerd2Script:
	faceplayer
	opentext
	checkevent EVENT_LISTENED_TO_AQUA_TAIL_INTRO
	iftrue Route4TutorAquaTailScript
	writetext Route4SuperNerd2Text
	waitbutton
	setevent EVENT_LISTENED_TO_AQUA_TAIL_INTRO
Route4TutorAquaTailScript:
	writetext Text_Route4TutorAquaTail
	waitbutton
	checkitem SILVER_LEAF
	iffalse .NoSilverLeaf
	writetext Text_Route4Tutor2Question
	yesorno
	iffalse .TutorRefused
	setval AQUA_TAIL
	writetext ClearText
	special Special_MoveTutor
	ifequal $0, .TeachMove
.TutorRefused
	jumpopenedtext Text_Route4Tutor2Refused

.NoSilverLeaf
	jumpopenedtext Text_Route4TutorsNoSilverLeaf

.TeachMove
	takeitem SILVER_LEAF
	jumpopenedtext Text_Route4Tutor2Taught

Route4EngineerScript:
	showtext Route4EngineerText1
	showtextfaceplayer Route4EngineerText2
	turnobject LAST_TALKED, UP
	end

YoungsterOliverSeenText:
	text "Hi! What's your"
	line "name? Where are"
	cont "you going?"
	done

YoungsterOliverBeatenText:
	text "I was just"
	line "asking…"
	done

LassJenniferSeenText:
	text "I battle every"
	line "chance I get,"

	para "just to spend time"
	line "with my #mon."
	done

LassJenniferBeatenText:
	text "Wheeee!"
	done

Bird_keeperHankSeenText:
	text "I'm raising my"
	line "#mon. Want to"
	cont "battle with me?"
	done

Bird_keeperHankBeatenText:
	text "Ack! I lost that"
	line "one…"
	done

PicnickerHopeSeenText:
	text "I have a feeling"
	line "that I can win."

	para "Let's see if I'm"
	line "right!"
	done

PicnickerHopeBeatenText:
	text "Aww, you are too"
	line "strong."
	done

PicnickerSharonSeenText:
	text "Um…"
	line "I…"
	done

PicnickerSharonBeatenText:
	text "…"
	done

Route4SuperNerd1Text:
	text "#mon with tough"
	line "heads are best!"

	para "Arcanine, Golem,"
	line "Snorlax!"

	para "Don't you agree?"
	done

Route4SuperNerd2Text:
	text "#mon with long"
	line "tails are best!"

	para "Slowbro, Golduck,"
	line "Feraligatr!"

	para "Don't you agree?"
	done

Text_Route4TutorIronHead:
	text "If you give me a"
	line "Silver Leaf, I'll"

	para "teach your #mon"
	line "to use Iron Head!"
	done

Text_Route4TutorAquaTail:
	text "If you give me a"
	line "Silver Leaf, I'll"

	para "teach your #mon"
	line "to use Aqua Tail!"
	done

Text_Route4TutorsNoSilverLeaf:
	text "But you don't have"
	line "a Silver Leaf."
	done

Text_Route4Tutor1Question:
	text "Should I teach"
	line "your #mon"
	cont "Iron Head?"
	done

Text_Route4Tutor2Question:
	text "Should I teach"
	line "your #mon"
	cont "Aqua Tail?"
	done

Text_Route4Tutor1Refused:
	text "But it's better"
	line "than Aqua Tail!"
	done

Text_Route4Tutor2Refused:
	text "But it's better"
	line "than Iron Head!"
	done

Text_Route4Tutor1Taught:
	text "Now your #mon"
	line "knows how to use"
	cont "Iron Head!"
	done

Text_Route4Tutor2Taught:
	text "Now your #mon"
	line "knows how to use"
	cont "Aqua Tail!"
	done

Route4EngineerText1:
	text "Get those bolts"
	line "tighter!"
	done

Route4EngineerText2:
	text "The cable car's"
	line "out right now."

	para "Until we're done"
	line "fixing it,"

	para "Mt.Moon Square"
	line "is closed."
	done

MtMoonSignText:
	text "Mt.Moon Tunnel"
	done

CableCarSignText:
	text "Cable Car to"
	line "Mt.Moon Square"
	done
