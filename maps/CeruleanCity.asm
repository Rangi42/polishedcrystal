CeruleanCity_MapScriptHeader:
	db 0 ; scene scripts

	db 1 ; callbacks
	callback MAPCALLBACK_NEWMAP, CeruleanCityFlyPoint

	db 11 ; warp events
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
	warp_event 29,  5, CERULEAN_WATER_SHOW_SPEECH_HOUSE, 1

	db 0 ; coord events

	db 8 ; bg events
	bg_event 23, 19, SIGNPOST_JUMPTEXT, CeruleanCitySignText
	bg_event 27, 21, SIGNPOST_JUMPTEXT, CeruleanGymSignText
	bg_event 11, 25, SIGNPOST_JUMPTEXT, CeruleanBikeShopSignText
	bg_event 25, 13, SIGNPOST_JUMPTEXT, CeruleanPoliceSignText
	bg_event 23,  4, SIGNPOST_JUMPTEXT, CeruleanCapeSignText
	bg_event 11, 19, SIGNPOST_JUMPTEXT, CeruleanBubblerText
	bg_event 17, 27, SIGNPOST_JUMPTEXT, CeruleanTrainerTipsText
	bg_event  4, 13, SIGNPOST_ITEM + BERSERK_GENE, EVENT_FOUND_BERSERK_GENE_IN_CERULEAN_CITY

	db 9 ; object events
	object_event 21, 20, SPRITE_VERMILION_LAWRENCE, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_GREEN, PERSONTYPE_SCRIPT, 0, CooltrainerFScript_0x18402a, -1
	object_event  6,  8, SPRITE_YOUNGSTER, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 1, -1, -1, PAL_NPC_RED, PERSONTYPE_SCRIPT, 0, YoungsterScript_0x184064, -1
	object_event 30, 22, SPRITE_COOLTRAINER_M, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, -1, PAL_NPC_BLUE, PERSONTYPE_SCRIPT, 0, CooltrainerMScript_0x184009, -1
	object_event 23, 11, SPRITE_SUPER_NERD, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, PAL_NPC_BLUE, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x1841a8, -1
	object_event 20, 20, SPRITE_SLOWBRO, SPRITEMOVEDATA_DOLL, 0, 0, -1, -1, 0, PERSONTYPE_POKEMON, SLOWBRO, CeruleanCitySlowbroText, -1
	object_event 14, 18, SPRITE_FISHER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, PERSONTYPE_SCRIPT, 0, FisherScript_0x18404a, -1
	object_event  2, 10, SPRITE_COOLTRAINER_M, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BLUE, PERSONTYPE_COMMAND, jumptextfaceplayer, CeruleanCaveGuardText, EVENT_BEAT_BLUE
	object_event 44, 16, SPRITE_BALL_CUT_FRUIT, SPRITEMOVEDATA_CUTTABLE_TREE, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, ObjectEvent, EVENT_ROUTE_9_CUT_TREE
	cuttree_event 20, 27, EVENT_CERULEAN_CITY_CUT_TREE

	const_def 1 ; object constants
	const CERULEANCITY_COOLTRAINER_F
	const CERULEANCITY_YOUNGSTER

CeruleanCityFlyPoint:
	setflag ENGINE_FLYPOINT_CERULEAN
	return

CooltrainerMScript_0x184009:
	checkevent EVENT_RETURNED_MACHINE_PART
	iftrue_jumptextfaceplayer UnknownText_0x184144
	jumptextfaceplayer UnknownText_0x1840bc

CooltrainerFScript_0x18402a:
	showtextfaceplayer UnknownText_0x1841fa
	turnobject CERULEANCITY_COOLTRAINER_F, LEFT
	showtext UnknownText_0x184229
	showcrytext CeruleanCitySlowbroText, SLOWBRO
	jumptext UnknownText_0x18424b

FisherScript_0x18404a:
	checkevent EVENT_RETURNED_MACHINE_PART
	iftrue_jumptextfaceplayer UnknownText_0x18424e
	checkevent EVENT_MET_ROCKET_GRUNT_AT_CERULEAN_GYM
	iftrue_jumptextfaceplayer UnknownText_0x184275
	jumptextfaceplayer UnknownText_0x18424e

YoungsterScript_0x184064:
	checkevent EVENT_FOUND_BERSERK_GENE_IN_CERULEAN_CITY
	iftrue_jumptextfaceplayer CeruleanCityYoungsterText
	faceplayer
	showtext UnknownText_0x1842a9
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
	jumptext UnknownText_0x1842ee

UnknownText_0x1840bc:
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

UnknownText_0x184144:
	text "You're collecting"
	line "every single kind"
	cont "of #mon?"

	para "That must be quite"
	line "a challenge, but"
	cont "it sounds fun too."
	done

UnknownText_0x1841a8:
	text "The Cape in the"
	line "north is a good"

	para "place for dates."
	line "Girls like it!"
	done

CeruleanCitySlowbroText:
	text "Slowbro: Yarah?"
	done

UnknownText_0x1841fa:
	text "My Slowbro and I"
	line "make an awesome"
	cont "combination!"
	done

UnknownText_0x184229:
	text "Slowbro, show me"
	line "your Confusion!"
	done

UnknownText_0x18424b:
	text "…"
	done

UnknownText_0x18424e:
	text "I'm a huge fan of"
	line "Cerulean Gym's"
	cont "Misty."
	done

UnknownText_0x184275:
	text "I saw this shady"
	line "guy go off toward"
	cont "Cerulean Cape."
	done

UnknownText_0x1842a9:
	text "There's a cave"
	line "here with scary-"
	cont "powerful #mon"
	cont "in it."
	done

UnknownText_0x1842ee:
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
