CeruleanCity_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 1
	dbw MAPCALLBACK_NEWMAP, CeruleanCityFlyPoint

CeruleanCity_MapEventHeader:

.Warps: db 11
	warp_def 11, 7, 1, CERULEAN_GYM_BADGE_SPEECH_HOUSE
	warp_def 13, 28, 1, CERULEAN_POLICE_STATION
	warp_def 15, 13, 1, CERULEAN_TRADE_SPEECH_HOUSE
	warp_def 17, 19, 1, CERULEAN_POKECENTER_1F
	warp_def 19, 30, 1, CERULEAN_GYM
	warp_def 25, 25, 2, CERULEAN_MART
	warp_def 9, 2, 1, CERULEAN_CAVE_1F
	warp_def 25, 14, 1, CERULEAN_BIKE_SHOP
	warp_def 11, 15, 1, CERULEAN_BERRY_POWDER_HOUSE
	warp_def 25, 19, 1, CERULEAN_COUPLE_HOUSE
	warp_def 5, 29, 1, CERULEAN_WATER_SHOW_SPEECH_HOUSE

.XYTriggers: db 0

.Signposts: db 7
	signpost 19, 23, SIGNPOST_JUMPTEXT, CeruleanCitySignText
	signpost 21, 27, SIGNPOST_JUMPTEXT, CeruleanGymSignText
	signpost 25, 11, SIGNPOST_JUMPTEXT, CeruleanBikeShopSignText
	signpost 13, 25, SIGNPOST_JUMPTEXT, CeruleanPoliceSignText
	signpost 4, 23, SIGNPOST_JUMPTEXT, CeruleanCapeSignText
	signpost 19, 11, SIGNPOST_JUMPTEXT, CeruleanBubblerText
	signpost 13, 4, SIGNPOST_ITEM + BERSERK_GENE, EVENT_FOUND_BERSERK_GENE_IN_CERULEAN_CITY

.PersonEvents: db 8
	person_event SPRITE_COOLTRAINER_F, 20, 21, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_SCRIPT, 0, CooltrainerFScript_0x18402a, -1
	person_event SPRITE_YOUNGSTER, 8, 6, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 1, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, YoungsterScript_0x184064, -1
	person_event SPRITE_COOLTRAINER_M, 22, 30, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, CooltrainerMScript_0x184009, -1
	person_event SPRITE_SUPER_NERD, 11, 23, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x1841a8, -1
	person_event SPRITE_SLOWBRO, 20, 20, SPRITEMOVEDATA_DOLL, 0, 0, -1, -1, 0, PERSONTYPE_POKEMON, SLOWBRO, CeruleanCitySlowbroText, -1
	person_event SPRITE_FISHER, 18, 14, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, FisherScript_0x18404a, -1
	person_event SPRITE_COOLTRAINER_M, 10, 2, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_COMMAND, jumptextfaceplayer, CeruleanCaveGuardText, EVENT_BEAT_BLUE
	person_event SPRITE_BALL_CUT_FRUIT, 16, 44, SPRITEMOVEDATA_CUTTABLE_TREE, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, ObjectEvent, EVENT_ROUTE_9_CUT_TREE

const_value set 1
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
	spriteface CERULEANCITY_COOLTRAINER_F, LEFT
	showtext UnknownText_0x184229
	showcrytext CeruleanCitySlowbroText, SLOWBRO
	jumptext UnknownText_0x18424b

FisherScript_0x18404a:
	faceplayer
	opentext
	checkevent EVENT_RETURNED_MACHINE_PART
	iftrue UnknownScript_0x184058
	checkevent EVENT_MET_ROCKET_GRUNT_AT_CERULEAN_GYM
	iftrue UnknownScript_0x18405e
UnknownScript_0x184058:
	jumpopenedtext UnknownText_0x18424e

UnknownScript_0x18405e:
	jumpopenedtext UnknownText_0x184275

YoungsterScript_0x184064:
	faceplayer
	opentext
	checkevent EVENT_FOUND_BERSERK_GENE_IN_CERULEAN_CITY
	iftrue .FoundBerserkGene
	writetext UnknownText_0x1842a9
	waitbutton
	closetext
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
	spriteface CERULEANCITY_YOUNGSTER, LEFT
	jumptext UnknownText_0x1842ee

.FoundBerserkGene:
	jumpopenedtext CeruleanCityYoungsterText

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
