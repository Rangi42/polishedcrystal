Route8_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

Route8_MapEventHeader:

.Warps: db 2
	warp_def 10, 4, 3, ROUTE_8_SAFFRON_GATE
	warp_def 11, 4, 4, ROUTE_8_SAFFRON_GATE

.XYTriggers: db 0

.Signposts: db 2
	signpost 9, 11, SIGNPOST_JUMPTEXT, Route8UndergroundPathSignText
	signpost 7, 10, SIGNPOST_JUMPTEXT, Route8LockedDoorText

.PersonEvents: db 15
	person_event SPRITE_BIKER, 10, 10, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_TRAINER, 5, TrainerBikerDwayne, EVENT_ROUTE_8_KANTO_POKEMON_FEDERATION
	person_event SPRITE_BIKER, 11, 10, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_TRAINER, 5, TrainerBikerHarris, EVENT_ROUTE_8_KANTO_POKEMON_FEDERATION
	person_event SPRITE_BIKER, 12, 10, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_TRAINER, 5, TrainerBikerZeke, EVENT_ROUTE_8_KANTO_POKEMON_FEDERATION
	person_event SPRITE_SUPER_NERD, 9, 17, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_TRAINER, 3, TrainerSupernerdSam, -1
	person_event SPRITE_SUPER_NERD, 9, 32, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_TRAINER, 3, TrainerSupernerdTom, -1
	person_event SPRITE_GENTLEMAN, 14, 43, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_TRAINER, 3, TrainerGentlemanMilton, -1
	person_event SPRITE_YOUNGSTER, 4, 23, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_TRAINER, 1, TrainerCoupleMoeandlulu1, -1
	person_event SPRITE_LASS, 4, 24, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_TRAINER, 1, TrainerCoupleMoeandlulu2, -1
	person_event SPRITE_LASS, 4, 29, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_TRAINER, 3, TrainerLassMeadow, -1
	cuttree_event 14, 21, EVENT_ROUTE_8_CUT_TREE_1
	cuttree_event 12, 32, EVENT_ROUTE_8_CUT_TREE_2
	fruittree_event 7, 45, FRUITTREE_ROUTE_8, SALAC_BERRY
	person_event SPRITE_BIKER, 9, 6, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_COMMAND, jumptextfaceplayer, Route8BikerDwayneProtestText, EVENT_ROUTE_8_PROTESTORS
	person_event SPRITE_BIKER, 10, 7, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_COMMAND, jumptextfaceplayer, Route8BikerHarrisProtestText, EVENT_ROUTE_8_PROTESTORS
	person_event SPRITE_BIKER, 11, 6, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_COMMAND, jumptextfaceplayer, Route8BikerZekeProtestText, EVENT_ROUTE_8_PROTESTORS

TrainerBikerDwayne:
	trainer EVENT_BEAT_BIKER_DWAYNE, BIKER, DWAYNE, BikerDwayneSeenText, BikerDwayneBeatenText, 0, BikerDwayneScript

BikerDwayneScript:
	end_if_just_battled
	jumptextfaceplayer UnknownText_0x6c0c8

TrainerBikerHarris:
	trainer EVENT_BEAT_BIKER_HARRIS, BIKER, HARRIS, BikerHarrisSeenText, BikerHarrisBeatenText, 0, BikerHarrisScript

BikerHarrisScript:
	end_if_just_battled
	jumptextfaceplayer UnknownText_0x6c143

TrainerBikerZeke:
	trainer EVENT_BEAT_BIKER_ZEKE, BIKER, ZEKE, BikerZekeSeenText, BikerZekeBeatenText, 0, BikerZekeScript

BikerZekeScript:
	end_if_just_battled
	jumptextfaceplayer UnknownText_0x6c1a3

TrainerSupernerdSam:
	trainer EVENT_BEAT_SUPER_NERD_SAM, SUPER_NERD, SAM, SupernerdSamSeenText, SupernerdSamBeatenText, 0, SupernerdSamScript

SupernerdSamScript:
	end_if_just_battled
	jumptextfaceplayer UnknownText_0x6c219

TrainerSupernerdTom:
	trainer EVENT_BEAT_SUPER_NERD_TOM, SUPER_NERD, TOM, SupernerdTomSeenText, SupernerdTomBeatenText, 0, SupernerdTomScript

SupernerdTomScript:
	end_if_just_battled
	jumptextfaceplayer UnknownText_0x6c27e

TrainerGentlemanMilton:
	trainer EVENT_BEAT_GENTLEMAN_MILTON, GENTLEMAN, MILTON, GentlemanMiltonSeenText, GentlemanMiltonBeatenText, 0, GentlemanMiltonScript

GentlemanMiltonScript:
	end_if_just_battled
	jumptextfaceplayer GentlemanMiltonAfterText

TrainerCoupleMoeandlulu1:
	trainer EVENT_BEAT_COUPLE_MOE_AND_LULU, COUPLE, MOEANDLULU1, CoupleMoeandlulu1SeenText, CoupleMoeandlulu1BeatenText, 0, CoupleMoeandlulu1Script

CoupleMoeandlulu1Script:
	end_if_just_battled
	jumptextfaceplayer CoupleMoeandlulu1AfterText

TrainerCoupleMoeandlulu2:
	trainer EVENT_BEAT_COUPLE_MOE_AND_LULU, COUPLE, MOEANDLULU2, CoupleMoeandlulu2SeenText, CoupleMoeandlulu2BeatenText, 0, CoupleMoeandlulu2Script

CoupleMoeandlulu2Script:
	end_if_just_battled
	jumptextfaceplayer CoupleMoeandlulu2AfterText

TrainerLassMeadow:
	trainer EVENT_BEAT_LASS_MEADOW, LASS, MEADOW, LassMeadowSeenText, LassMeadowBeatenText, 0, LassMeadowScript

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
