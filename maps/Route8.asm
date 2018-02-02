Route8_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 2 ; warp events
	warp_event 4, 10, ROUTE_8_SAFFRON_GATE, 3
	warp_event 4, 11, ROUTE_8_SAFFRON_GATE, 4

	db 0 ; coord events

	db 2 ; bg events
	bg_event 11, 9, SIGNPOST_JUMPTEXT, Route8UndergroundPathSignText
	bg_event 10, 7, SIGNPOST_JUMPTEXT, Route8LockedDoorText

	db 15 ; object events
	object_event 10, 10, SPRITE_BIKER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_TRAINER, 5, TrainerBikerDwayne, EVENT_ROUTE_8_KANTO_POKEMON_FEDERATION
	object_event 10, 11, SPRITE_BIKER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_TRAINER, 5, TrainerBikerHarris, EVENT_ROUTE_8_KANTO_POKEMON_FEDERATION
	object_event 10, 12, SPRITE_BIKER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_TRAINER, 5, TrainerBikerZeke, EVENT_ROUTE_8_KANTO_POKEMON_FEDERATION
	object_event 17, 9, SPRITE_SUPER_NERD, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_TRAINER, 3, TrainerSupernerdSam, -1
	object_event 32, 9, SPRITE_SUPER_NERD, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_TRAINER, 3, TrainerSupernerdTom, -1
	object_event 43, 14, SPRITE_GENTLEMAN, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_TRAINER, 3, TrainerGentlemanMilton, -1
	object_event 23, 4, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_TRAINER, 1, TrainerCoupleMoeandlulu1, -1
	object_event 24, 4, SPRITE_LASS, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_TRAINER, 1, TrainerCoupleMoeandlulu2, -1
	object_event 29, 4, SPRITE_LASS, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_TRAINER, 3, TrainerLassMeadow, -1
	cuttree_event 21, 14, EVENT_ROUTE_8_CUT_TREE_1
	cuttree_event 32, 12, EVENT_ROUTE_8_CUT_TREE_2
	fruittree_event 45, 7, FRUITTREE_ROUTE_8, SALAC_BERRY
	object_event 6, 9, SPRITE_BIKER, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_COMMAND, jumptextfaceplayer, Route8BikerDwayneProtestText, EVENT_ROUTE_8_PROTESTORS
	object_event 7, 10, SPRITE_BIKER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_COMMAND, jumptextfaceplayer, Route8BikerHarrisProtestText, EVENT_ROUTE_8_PROTESTORS
	object_event 6, 11, SPRITE_BIKER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_COMMAND, jumptextfaceplayer, Route8BikerZekeProtestText, EVENT_ROUTE_8_PROTESTORS

TrainerBikerDwayne:
	trainer BIKER, DWAYNE, EVENT_BEAT_BIKER_DWAYNE, BikerDwayneSeenText, BikerDwayneBeatenText, 0, BikerDwayneScript

BikerDwayneScript:
	end_if_just_battled
	jumptextfaceplayer UnknownText_0x6c0c8

TrainerBikerHarris:
	trainer BIKER, HARRIS, EVENT_BEAT_BIKER_HARRIS, BikerHarrisSeenText, BikerHarrisBeatenText, 0, BikerHarrisScript

BikerHarrisScript:
	end_if_just_battled
	jumptextfaceplayer UnknownText_0x6c143

TrainerBikerZeke:
	trainer BIKER, ZEKE, EVENT_BEAT_BIKER_ZEKE, BikerZekeSeenText, BikerZekeBeatenText, 0, BikerZekeScript

BikerZekeScript:
	end_if_just_battled
	jumptextfaceplayer UnknownText_0x6c1a3

TrainerSupernerdSam:
	trainer SUPER_NERD, SAM, EVENT_BEAT_SUPER_NERD_SAM, SupernerdSamSeenText, SupernerdSamBeatenText, 0, SupernerdSamScript

SupernerdSamScript:
	end_if_just_battled
	jumptextfaceplayer UnknownText_0x6c219

TrainerSupernerdTom:
	trainer SUPER_NERD, TOM, EVENT_BEAT_SUPER_NERD_TOM, SupernerdTomSeenText, SupernerdTomBeatenText, 0, SupernerdTomScript

SupernerdTomScript:
	end_if_just_battled
	jumptextfaceplayer UnknownText_0x6c27e

TrainerGentlemanMilton:
	trainer GENTLEMAN, MILTON, EVENT_BEAT_GENTLEMAN_MILTON, GentlemanMiltonSeenText, GentlemanMiltonBeatenText, 0, GentlemanMiltonScript

GentlemanMiltonScript:
	end_if_just_battled
	jumptextfaceplayer GentlemanMiltonAfterText

TrainerCoupleMoeandlulu1:
	trainer COUPLE, MOEANDLULU1, EVENT_BEAT_COUPLE_MOE_AND_LULU, CoupleMoeandlulu1SeenText, CoupleMoeandlulu1BeatenText, 0, CoupleMoeandlulu1Script

CoupleMoeandlulu1Script:
	end_if_just_battled
	jumptextfaceplayer CoupleMoeandlulu1AfterText

TrainerCoupleMoeandlulu2:
	trainer COUPLE, MOEANDLULU2, EVENT_BEAT_COUPLE_MOE_AND_LULU, CoupleMoeandlulu2SeenText, CoupleMoeandlulu2BeatenText, 0, CoupleMoeandlulu2Script

CoupleMoeandlulu2Script:
	end_if_just_battled
	jumptextfaceplayer CoupleMoeandlulu2AfterText

TrainerLassMeadow:
	trainer LASS, MEADOW, EVENT_BEAT_LASS_MEADOW, LassMeadowSeenText, LassMeadowBeatenText, 0, LassMeadowScript

LassMeadowScript:
	end_if_just_battled
	jumptextfaceplayer LassMeadowAfterText

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

UnknownText_0x6c0c8:
	text "The Kanto #mon"
	line "Federation will"
	cont "never fall!"
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

UnknownText_0x6c143:
	text "Wiped out by some"
	line "punk from Johto…"
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

UnknownText_0x6c1a3:
	text "We'll try not to"
	line "disturb anyone"
	cont "from now on…"
	done

SupernerdSamSeenText:
	text "How does the Mag-"
	line "net Train work?"
	done

SupernerdSamBeatenText:
	text "I just want to see"
	line "the Magnet Train…"
	done

UnknownText_0x6c219:
	text "The power of mag-"
	line "nets is awesome!"
	done

SupernerdTomSeenText:
	text "Hm… You've got"
	line "many Gym Badges."
	done

SupernerdTomBeatenText:
	text "Just as I thought…"
	line "You're tough!"
	done

UnknownText_0x6c27e:
	text "Gym Badges are"
	line "proof of your"
	cont "skill at battles."
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

GentlemanMiltonAfterText:
	text "Stopping in the"
	line "road for a battle"
	cont "isn't rude."

	para "No matter what,"
	line "I am a gentleman"
	cont "first!"
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

CoupleMoeandlulu1AfterText:
	text "Moe: In short,"
	line "you're just too"
	cont "strong…"
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

CoupleMoeandlulu2AfterText:
	text "Lulu: It's not that"
	line "Moe's weak, it's"

	para "that you're too"
	line "strong!"
	done

LassMeadowSeenText:
	text "I like skirts!"
	line "They're cute and"
	cont "comfy to wear!"
	done

LassMeadowBeatenText:
	text "Oh my!"
	done

LassMeadowAfterText:
	text "Oh well, I'm more"
	line "worried about"

	para "having fun than"
    line "being competitive."
	done

Route8LockedDoorText:
	text "It's locked…"
	done

Route8UndergroundPathSignText:
	text "The flyer's torn."

	para "It's impossible to"
	line "read…"
	done
