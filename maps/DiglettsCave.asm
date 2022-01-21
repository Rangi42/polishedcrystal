DiglettsCave_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event 37, 15, VERMILION_CITY, 10
	warp_event 39, 13, DIGLETTS_CAVE, 5
	warp_event 37,  5, ROUTE_2_NORTH, 4
	warp_event 39,  3, DIGLETTS_CAVE, 6
	warp_event 37, 31, DIGLETTS_CAVE, 2
	warp_event  5,  5, DIGLETTS_CAVE, 4

	def_coord_events

	def_bg_events
	bg_event  8, 15, BGEVENT_ITEM + MAX_REVIVE, EVENT_DIGLETTS_CAVE_HIDDEN_MAX_REVIVE
	bg_event 34, 33, BGEVENT_ITEM + MAX_REPEL, EVENT_DIGLETTS_CAVE_HIDDEN_MAX_REPEL

	def_object_events
	object_event 11, 15, SPRITE_POKEMANIAC, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, DiglettsCaveFossilManiacScript, -1
	object_event  5, 13, SPRITE_HIKER, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerHikerGerard, -1
	object_event 25, 31, SPRITE_HIKER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 4, GenericTrainerHikerDent, -1
	object_event 16, 21, SPRITE_BLACK_BELT, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerBlackbeltInigo, -1
	object_event  9, 20, SPRITE_ENGINEER, SPRITEMOVEDATA_SPINCLOCKWISE, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerEngineerSmith, -1
	object_event 37, 13, SPRITE_HIKER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, DiglettsCavePokefanMText, -1
	object_event 20, 27, SPRITE_BATTLE_GIRL, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_COMMAND, jumptextfaceplayer, DiglettsCaveCooltrainerfText, -1
	itemball_event 13, 28, RARE_BONE, 1, EVENT_DIGLETTS_CAVE_RARE_BONE

DiglettsCaveFossilManiacScript:
	faceplayer
	opentext
	writetext .GreetingText
	promptbutton
	special Special_ChooseItem
	iffalse_jumpopenedtext .NoItemText
	special GetFossilManiacPrice
	iffalse_jumpopenedtext .WrongItemText
	writetext .OfferText
	special PlaceMoneyTopRight
	yesorno
	iffalse_jumpopenedtext .NoItemText
	readmem wCurItem
	takeitem ITEM_FROM_MEM
	waitsfx
	playsound SFX_TRANSACTION
	special Give_hMoneyTemp
	special PlaceMoneyTopRight
	jumpthisopenedtext

	text "Hey, thanks!"

	para "I bet I can sell"
	line "this for way more"
	cont "than I just gave"
	cont "you. Ha!"

	para "That's business"
	line "for ya!"
	done

.GreetingText:
	text "Hey, check it out."
	line "I've got a sweet"
	cont "deal for ya!"

	para "You know how #-"
	line "mon fossils turn"
	cont "up in rocks?"

	para "If you find one,"
	line "bring it to me."

	para "I'll make it worth"
	line "your while."
	done

.OfferText:
	text "Hey, nice! Let me"
	line "check that out."

	para "I'll give you"
	line "¥"
	text_decimal hMoneyTemp, 3, 7
	text " for it."
	cont "Whaddaya say?"
	done

.WrongItemText:
	text "Nope, this is no"
	line "good. Not worth"
	cont "my while."
	done

.NoItemText:
	text "…Nope, nothing"
	line "cool in your Bag."

	para "Oh well. Maybe"
	line "next time!"
	done

GenericTrainerHikerGerard:
	generictrainer HIKER, GERARD, EVENT_BEAT_HIKER_GERARD, .SeenText, .BeatenText

	text "This place makes"
	line "me so nervous."

	para "What if a Diglett"
	line "attacks me out of"
	cont "nowhere?"
	done

.SeenText:
	text "Aah! I think that"
	line "rock just moved!"
	done

.BeatenText:
	text "Must have been"
	line "my imagination."
	done

GenericTrainerHikerDent:
	generictrainer HIKER, DENT, EVENT_BEAT_HIKER_DENT, .SeenText, .BeatenText

	text "I'll fit right in"
	line "with Pewter Gym's"
	cont "buff crew. Hohoh!"
	done

.SeenText:
	text "I'm headed to"
	line "Pewter."

	para "Its Rock-type Gym"
	line "is perfect for a"
	cont "buff guy like me!"
	done

.BeatenText:
	text "Hohoh!"
	line "Someone more buff"
	cont "than me!"
	done

GenericTrainerBlackbeltInigo:
	generictrainer BLACKBELT_T, INIGO, EVENT_BEAT_BLACKBELT_INIGO, .SeenText, .BeatenText

	text "Making noises won't"
	line "make you a better"
	cont "fighter, but it"

	para "can intimidate"
	line "your foes."
	done

.SeenText:
	text "Prepare for"
	line "battle!"
	cont "HOO-HAH!"
	done

.BeatenText:
	text "HIIYAAAH!"
	done

GenericTrainerEngineerSmith:
	generictrainer ENGINEER, SMITH, EVENT_BEAT_ENGINEER_SMITH, .SeenText, .BeatenText

	text "Those Diglett are"
	line "just natural"
	cont "engineers."
	done

.SeenText:
	text "How did Diglett"
	line "create such a long"
	cont "tunnel?"
	done

.BeatenText:
	text "Amazing!"
	done

DiglettsCaveCooltrainerfText:
	text "Look at all these"
	line "cute Diglett!"

	para "I swear I saw one"
	line "with a blue nose!"
	done

DiglettsCavePokefanMText:
if DEF(FAITHFUL)
	text "A bunch of Diglett"
	line "popped out of the"

	para "ground! That was"
	line "shocking."
else
	text "When the volcano"
	line "on Cinnabar Island"
	cont "erupted, it radic-"

	para "ally affected some"
	line "#mon species."

	para "Diglett and Dug-"
	line "trio burrowing"
	cont "underground got"

	para "covered in strands"
	line "of cooled lava,"

	para "blown here all the"
	line "way from Cinnabar."

	para "It's made them even"
	line "tougher. Good luck"
	cont "in the caves!"
endc
	done
