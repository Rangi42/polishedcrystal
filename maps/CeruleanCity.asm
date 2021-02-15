CeruleanCity_MapScriptHeader:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_NEWMAP, CeruleanCityFlyPoint

	def_warp_events
	warp_event  7, 11, CERULEAN_GYM_BADGE_SPEECH_HOUSE, 1
	warp_event 28, 13, CERULEAN_POLICE_STATION, 1
	warp_event 13, 15, CERULEAN_TRADE_SPEECH_HOUSE, 1
	warp_event 19, 17, CERULEAN_POKECENTER_1F, 1
	warp_event 30, 19, CERULEAN_GYM, 1
	warp_event 25, 25, CERULEAN_MART, 2
	warp_event  2,  9, CERULEAN_CAVE_1F, 1
	warp_event 14, 25, CERULEAN_BIKE_SHOP, 1
	warp_event 15, 11, CERULEAN_BERRY_POWDER_HOUSE, 1
	warp_event 19, 25, CERULEAN_COUPLE_HOUSE, 1
	warp_event 29,  7, CERULEAN_WATER_SHOW_SPEECH_HOUSE, 1

	def_coord_events

	def_bg_events
	bg_event 17, 20, BGEVENT_JUMPTEXT, CeruleanCitySignText
	bg_event 23, 19, BGEVENT_JUMPTEXT, CeruleanGymSignText
	bg_event 11, 25, BGEVENT_JUMPTEXT, CeruleanBikeShopSignText
	bg_event 25, 13, BGEVENT_JUMPTEXT, CeruleanPoliceSignText
	bg_event 23,  5, BGEVENT_JUMPTEXT, CeruleanCapeSignText
	bg_event 11, 19, BGEVENT_JUMPTEXT, CeruleanBubblerText
	bg_event 21, 27, BGEVENT_JUMPTEXT, CeruleanTrainerTipsText
	bg_event  4, 13, BGEVENT_ITEM + BERSERK_GENE, EVENT_FOUND_BERSERK_GENE_IN_CERULEAN_CITY

	def_object_events
	object_event 21, 20, SPRITE_BATTLE_GIRL, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, CeruleanCityCooltrainerFScript, -1
	object_event  6,  8, SPRITE_SCHOOLBOY, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 1, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, CeruleanCityYoungsterScript, -1
	object_event 30, 22, SPRITE_COOL_DUDE, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, CeruleanCityCooltrainerMScript, -1
	object_event 23, 11, SPRITE_POKEMANIAC, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_COMMAND, jumptextfaceplayer, CeruleanCitySuperNerdText, -1
	object_event 20, 20, SPRITE_MON_ICON, SPRITEMOVEDATA_STILL, 0, SLOWBRO, -1, -1, PAL_NPC_RED, OBJECTTYPE_POKEMON, SLOWBRO, CeruleanCitySlowbroText, -1
	object_event 14, 18, SPRITE_FAT_GUY, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, CeruleanCityFisherScript, -1
	object_event  2, 10, SPRITE_ACE_TRAINER_M, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, CeruleanCaveGuardText, EVENT_BEAT_BLUE
	object_event 44, 16, SPRITE_BALL_CUT_FRUIT, SPRITEMOVEDATA_CUTTABLE_TREE, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, ObjectEvent, EVENT_ROUTE_9_CUT_TREE

	object_const_def
	const CERULEANCITY_COOLTRAINER_F
	const CERULEANCITY_YOUNGSTER

CeruleanCityFlyPoint:
	setflag ENGINE_FLYPOINT_CERULEAN
	return

CeruleanCityCooltrainerMScript:
	checkevent EVENT_RESTORED_POWER_TO_KANTO
	iftrue_jumptextfaceplayer CeruleanCityCooltrainerMText2
	jumptextfaceplayer CeruleanCityCooltrainerMText1

CeruleanCityCooltrainerFScript:
	showtextfaceplayer CeruleanCityCooltrainerFText1
	turnobject CERULEANCITY_COOLTRAINER_F, LEFT
	showtext CeruleanCityCooltrainerFText2
	showcrytext CeruleanCitySlowbroText, SLOWBRO
	jumptext CeruleanCityCooltrainerFText3

CeruleanCityFisherScript:
	checkevent EVENT_RESTORED_POWER_TO_KANTO
	iftrue_jumptextfaceplayer CeruleanCityFisherText
	checkevent EVENT_MET_ROCKET_GRUNT_AT_CERULEAN_GYM
	iftrue_jumptextfaceplayer CeruleanCityFisherRocketTipText
	jumptextfaceplayer CeruleanCityFisherText

CeruleanCityYoungsterScript:
	checkevent EVENT_FOUND_BERSERK_GENE_IN_CERULEAN_CITY
	iftrue_jumptextfaceplayer CeruleanCityYoungsterText
	faceplayer
	showtext CeruleanCityYoungsterText1
	waitsfx
	playsound SFX_SECOND_PART_OF_ITEMFINDER
	waitsfx
	playsound SFX_TRANSACTION
	waitsfx
	playsound SFX_SECOND_PART_OF_ITEMFINDER
	waitsfx
	playsound SFX_TRANSACTION
	waitsfx
	playsound SFX_SECOND_PART_OF_ITEMFINDER
	waitsfx
	playsound SFX_TRANSACTION
	waitsfx
	playsound SFX_SECOND_PART_OF_ITEMFINDER
	waitsfx
	playsound SFX_TRANSACTION
	waitsfx
	showemote EMOTE_SHOCK, CERULEANCITY_YOUNGSTER, 15
	turnobject CERULEANCITY_YOUNGSTER, LEFT
	jumptext CeruleanCityYoungsterText2

CeruleanCityCooltrainerMText1:
	text "Kanto's Power"
	line "Plant?"

	para "It's near the end"
	line "of Route 9, the"

	para "road that heads"
	line "east from here."

	para "I think there was"
	line "an accident of"
	cont "some sort there."
	done

CeruleanCityCooltrainerMText2:
	text "You're collecting"
	line "every single kind"
	cont "of #mon?"

	para "That must be quite"
	line "a challenge, but"
	cont "it sounds fun too."
	done

CeruleanCitySuperNerdText:
	text "The Cape in the"
	line "north is a good"

	para "place for dates."
	line "Girls like it!"
	done

CeruleanCitySlowbroText:
	text "Slowbro: Yarah?"
	done

CeruleanCityCooltrainerFText1:
	text "My Slowbro and I"
	line "make an awesome"
	cont "combination!"
	done

CeruleanCityCooltrainerFText2:
	text "Slowbro, show me"
	line "your Confusion!"
	done

CeruleanCityCooltrainerFText3:
	text "…"
	done

CeruleanCityFisherText:
	text "I'm a huge fan of"
	line "Cerulean Gym's"
	cont "Misty."
	done

CeruleanCityFisherRocketTipText:
	text "I saw this shady"
	line "guy go off toward"
	cont "Cerulean Cape."
	done

CeruleanCityYoungsterText1:
	text "There's a cave"
	line "here with scary-"
	cont "powerful #mon"
	cont "in it."
	done

CeruleanCityYoungsterText2:
	text "Ayuh?"

	para "My Itemfinder is"
	line "responding…"
	done

CeruleanCityYoungsterText:
	text "My Itemfinder"
	line "stopped respond-"
	cont "ing…"

	para "Someone must have"
	line "beat me to it."
	done

CeruleanCaveGuardText:
	text "This is…"

	para "The notorious"
	line "Cerulean Cave!"

	para "Horribly powerful"
	line "#mon live here."

	para "Only those who"
	line "have defeated all"

	para "eight Kanto Gym"
	line "Leaders are allow-"
	cont "ed inside."
	done

CeruleanCitySignText:
	text "Cerulean City"

	para "A Mysterious Blue"
	line "Aura Surrounds It"
	done

CeruleanGymSignText:
	text "Cerulean City"
	line "#mon Gym"
	cont "Leader: Misty"

	para "The Tomboyish"
	line "Mermaid"
	done

CeruleanBikeShopSignText:
	text "Trendsetter of"
	line "the Bicycle Boom"

	para "Miracle Cycle"
	done

CeruleanPoliceSignText:
	text "There's a notice"
	line "here…"

	para "Stamp out thievery"
	line "and make the city"

	para "a friendlier, more"
	line "cheerful place!"

	para "Cerulean Police"
	done

CeruleanCapeSignText:
	text "Cerulean Cape"
	line "Ahead"
	done

CeruleanBubblerText:
	text "The water"
	line "tastes good!"
	done

CeruleanTrainerTipsText:
	text "Trainer Tips"

	para "Even without an"
	line "ItemFinder, you"

	para "can find useful"
	line "items in trees,"

	para "beneath rocks,"
	line "or under water."
	done
