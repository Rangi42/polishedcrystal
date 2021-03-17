Route8_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  4, 10, ROUTE_8_SAFFRON_GATE, 3
	warp_event  4, 11, ROUTE_8_SAFFRON_GATE, 4

	def_coord_events

	def_bg_events
	bg_event 11,  9, BGEVENT_JUMPTEXT, Route8UndergroundPathSignText
	bg_event 10,  7, BGEVENT_JUMPTEXT, Route8LockedDoorText

	def_object_events
	object_event 10, 10, SPRITE_BIKER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_GENERICTRAINER, 5, GenericTrainerBikerDwayne, EVENT_ROUTE_8_KANTO_POKEMON_FEDERATION
	object_event 10, 11, SPRITE_BIKER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_GENERICTRAINER, 5, GenericTrainerBikerHarris, EVENT_ROUTE_8_KANTO_POKEMON_FEDERATION
	object_event 10, 12, SPRITE_BIKER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_GENERICTRAINER, 5, GenericTrainerBikerZeke, EVENT_ROUTE_8_KANTO_POKEMON_FEDERATION
	object_event 17,  9, SPRITE_SUPER_NERD, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerSupernerdSam, -1
	object_event 32,  9, SPRITE_SUPER_NERD, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerSupernerdTom, -1
	object_event 43, 14, SPRITE_GENTLEMAN, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerGentlemanMilton, -1
	object_event 23,  4, SPRITE_COOL_DUDE, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_GENERICTRAINER, 1, GenericTrainerCoupleMoeandlulu1, -1
	object_event 24,  4, SPRITE_CUTE_GIRL, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_GENERICTRAINER, 1, GenericTrainerCoupleMoeandlulu2, -1
	object_event 29,  4, SPRITE_LASS, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerLassMeadow, -1
	cuttree_event 21, 14, EVENT_ROUTE_8_CUT_TREE_1
	cuttree_event 32, 12, EVENT_ROUTE_8_CUT_TREE_2
	fruittree_event 45,  7, FRUITTREE_ROUTE_8, SALAC_BERRY, PAL_NPC_GREEN
	object_event  6,  9, SPRITE_BIKER, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_COMMAND, jumptextfaceplayer, Route8BikerDwayneProtestText, EVENT_ROUTE_8_PROTESTORS
	object_event  7, 10, SPRITE_BIKER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_COMMAND, jumptextfaceplayer, Route8BikerHarrisProtestText, EVENT_ROUTE_8_PROTESTORS
	object_event  6, 11, SPRITE_BIKER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_COMMAND, jumptextfaceplayer, Route8BikerZekeProtestText, EVENT_ROUTE_8_PROTESTORS

GenericTrainerBikerDwayne:
	generictrainer BIKER, DWAYNE, EVENT_BEAT_BIKER_DWAYNE, BikerDwayneSeenText, BikerDwayneBeatenText

	text "The Kanto #mon"
	line "Federation will"
	cont "never fall!"
	done

GenericTrainerBikerHarris:
	generictrainer BIKER, HARRIS, EVENT_BEAT_BIKER_HARRIS, BikerHarrisSeenText, BikerHarrisBeatenText

	text "Wiped out by some"
	line "punk from Johto…"
	done

GenericTrainerBikerZeke:
	generictrainer BIKER, ZEKE, EVENT_BEAT_BIKER_ZEKE, BikerZekeSeenText, BikerZekeBeatenText

	text "We'll try not to"
	line "disturb anyone"
	cont "from now on…"
	done

GenericTrainerSupernerdSam:
	generictrainer SUPER_NERD, SAM, EVENT_BEAT_SUPER_NERD_SAM, SupernerdSamSeenText, SupernerdSamBeatenText

	text "The power of mag-"
	line "nets is awesome!"
	done

GenericTrainerSupernerdTom:
	generictrainer SUPER_NERD, TOM, EVENT_BEAT_SUPER_NERD_TOM, SupernerdTomSeenText, SupernerdTomBeatenText

	text "Gym Badges are"
	line "proof of your"
	cont "skill at battles."
	done

GenericTrainerGentlemanMilton:
	generictrainer GENTLEMAN, MILTON, EVENT_BEAT_GENTLEMAN_MILTON, GentlemanMiltonSeenText, GentlemanMiltonBeatenText

	text "Stopping in the"
	line "road for a battle"
	cont "isn't rude."

	para "No matter what,"
	line "I am a gentleman"
	cont "first!"
	done

GenericTrainerCoupleMoeandlulu1:
	generictrainer COUPLE, MOEANDLULU1, EVENT_BEAT_COUPLE_MOE_AND_LULU, CoupleMoeandlulu1SeenText, CoupleMoeandlulu1BeatenText

	text "Moe: In short,"
	line "you're just too"
	cont "strong…"
	done

GenericTrainerCoupleMoeandlulu2:
	generictrainer COUPLE, MOEANDLULU2, EVENT_BEAT_COUPLE_MOE_AND_LULU, CoupleMoeandlulu2SeenText, CoupleMoeandlulu2BeatenText

	text "Lulu: It's not that"
	line "Moe's weak, it's"

	para "that you're too"
	line "strong!"
	done

GenericTrainerLassMeadow:
	generictrainer LASS, MEADOW, EVENT_BEAT_LASS_MEADOW, LassMeadowSeenText, LassMeadowBeatenText

	text "Oh well, I'm more"
	line "worried about"

	para "having fun than"
	line "being competitive."
	done

Route8BikerDwayneProtestText:
	text "We're the Kanto"
	line "#mon Federation"
	cont "trainer group."

	para "We're holding a"
	line "protest!"
	done

Route8BikerZekeProtestText:
	text "We're the Kanto"
	line "#mon Federa-"
	cont "tion!"

	para "The cops can't"
	line "stop us from"

	para "using the Under-"
	line "ground Path!"
	done

BikerDwayneSeenText:
	text "We're the Kanto"
	line "#mon Federation"
	cont "trainer group."

	para "We'll drive you"
	line "under our wheels!"
	done

BikerDwayneBeatenText:
	text "S-sorry!"
	done

Route8BikerHarrisProtestText:
BikerHarrisSeenText:
	text "The cops shut down"
	line "our Underground"

	para "Path! That really"
	line "fries me!"
	done

BikerHarrisBeatenText:
	text "F-forgive me!"
	done

BikerZekeSeenText:
	text "We're the Kanto"
	line "#mon Federa-"
	cont "tion!"
	cont "Right on!"
	done

BikerZekeBeatenText:
	text "Yikes! Sorry!"
	done

SupernerdSamSeenText:
	text "How does the Mag-"
	line "net Train work?"
	done

SupernerdSamBeatenText:
	text "I just want to see"
	line "the Magnet Train…"
	done

SupernerdTomSeenText:
	text "Hm… You've got"
	line "many Gym Badges."
	done

SupernerdTomBeatenText:
	text "Just as I thought…"
	line "You're tough!"
	done

GentlemanMiltonSeenText:
	text "Would you care to"
	line "join me in a"
	cont "quick contest?"
	done

GentlemanMiltonBeatenText:
	text "You were very"
	line "skillful."
	done

CoupleMoeandlulu1SeenText:
	text "Moe: Do I look"
	line "weak? Don't make"
	cont "me laugh!"

	para "When I'm with Lulu,"
	line "I've got a hundred"
	cont "times the courage!"
	done

CoupleMoeandlulu1BeatenText:
	text "Moe: Uwaaaahhh…"
	done

CoupleMoeandlulu2SeenText:
	text "Lulu: Moe and I"
	line "make a great pair!"

	para "You should prepare"
	line "yourself!"
	done

CoupleMoeandlulu2BeatenText:
	text "Lulu: Eeek!"
	done

LassMeadowSeenText:
	text "I like skirts!"
	line "They're cute and"
	cont "comfy to wear!"
	done

LassMeadowBeatenText:
	text "Oh my!"
	done

Route8LockedDoorText:
	text "It's locked…"
	done

Route8UndergroundPathSignText:
	text "The flyer's torn."

	para "It's impossible to"
	line "read…"
	done
