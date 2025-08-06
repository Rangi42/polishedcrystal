NationalForest1_MapScriptHeader:
    def_scene_scripts

    def_callbacks

    def_warp_events
	warp_event 21,  5, OLSTEETON_FOREST_GATE, 3

    def_coord_events

    def_bg_events
	bg_event 25,  7, BGEVENT_JUMPTEXT, NationalForest1EntranceSignText
	bg_event 30, 18, BGEVENT_JUMPTEXT, NationalForest1PondSignText
	bg_event 21, 17, BGEVENT_ITEM + SUPER_POTION, EVENT_NATIONAL_FOREST1_HIDDEN_SUPER_POTION

    def_object_events
	object_event  7, 16, SPRITE_SAGE, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, PAL_NPC_BROWN, OBJECTTYPE_SCRIPT, 0, ConcernedCitizenScript1, EVENT_TALKED_TO_CC
	object_event  5, 16, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, MegaCorpScript1, EVENT_TALKED_MEGACORP_GOON
	pokemon_event  7, 15, BULBASAUR, SPRITEMOVEDATA_POKEMON, -1, PAL_NPC_GREEN, NatForest1BulbasaurText, -1
	object_event 29, 20, SPRITE_FISHER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, PAL_NPC_BLUE, OBJECTTYPE_COMMAND, jumptextfaceplayer, NatForest1FishermanText, -1
	object_event 30, 20, SPRITE_FISHER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, PAL_NPC_BROWN, OBJECTTYPE_COMMAND, jumptextfaceplayer, NatForest1Fisherman2Text, -1
	object_event 13, 6, SPRITE_LASS, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 1, 0, -1, PAL_NPC_PURPLE, OBJECTTYPE_COMMAND, jumptextfaceplayer, NatForest1GirlText, -1
	pokemon_event 15, 6, MEOWTH, SPRITEMOVEDATA_POKEMON, -1, PAL_NPC_BLUE, NatForest1MeowthText, -1
    ; object_event 29, 4, SPRITE_GRANNY, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 2, GenericTrainerOld_TimerSue, -1
	itemball_event 31, 27, ANTIDOTE, 1, EVENT_NATIONAL_FOREST1_ANTIDOTE

    object_const_def
    const NATIONALFOREST1_SAGE
    const NATIONALFOREST1_OFFICER



; ||Scripts||

ConcernedCitizenScript1:
    checkevent EVENT_TALKED_TO_CC
    iftrue_jumptextfaceplayer CCText2
    setscene $0
    jumptextfaceplayer CCText1
    setevent EVENT_TALKED_TO_CC
end

MegaCorpScript1:
    checkevent EVENT_TALKED_MEGACORP_GOON
    iftrue_jumptextfaceplayer GoonText2
    setscene $0
    jumptextfaceplayer GoonText1
    setevent EVENT_TALKED_MEGACORP_GOON
end



; ||Dialogue||

CCText1:
    text "Hey kid! Get a"
    line "load of this!"

    para "Look what this"
    line "no-good Megacorp"
    cont "did!"

    para "This whole region"
    line "used to be forests"
    cont "and woodlands!"

    para "Nowadays we can't"
    line "even expect our"
    
    para "own parks to stay"
    line "untouched!"
    done

CCText2:
    text "Such a darn shame"
    line "to see all this..."
    done

GoonText1:
    text "C'mon, c'mon,"
    line "just stay out of"
    cont "the way, now."

    para "Megacorp received"
    line "permission from"
    
    para "the region to cut"
    line "'non-threatening'"
    
    para "amounts of non-"
    line "vital lumber."

    para "It's just some"
    line "trees, anyway."
    done

GoonText2:
    text "Geez, find some-"
    line "one else to gripe"
    cont "at!"

    para "Go call the"
    line "company number"
    
    para "if you've got a"
    line "complaint!"
    done

NatForest1BulbasaurText:
    text "This Bulbasaur"
    line "sadly looks out"
    
    para "across all the"
    line "logged trees."
    done

NatForest1FishermanText:
    text "Be careful in"
    line "streams and"
    
    para "ponds like"
    line "this one!"

    para "#mon like to"
    line "hide in the"
    cont "shallow water!"
    done

NatForest1Fisherman2Text:
    text "I was wading"
    line "in the pond"
    
    para "earlier, and"
    line "a #mon nearly"
    
    para "nibbled off my"
    line "toe!"
    done

NatForest1GirlText:
    text "I used to come"
    line "here all the time"

    para "with Meowth, but"
    line "its been so loud"
    cont "lately."

    para "It just seems"
    line "different now."
    done

NatForest1MeowthText:
    text "Meowth: MrrOOWW!"
    done

Old_TimerSueSeenText:
    text "You're the nosy"
    line "sort, aren't ya'!"
    done

Old_TimerSueBeatenText:
    text "Well, since you"
    line "want to know so"
    cont "badly..."

    para "I was looking for"
    line "berries!"

    para "Don't tell no one"
    line "about this spot!"
    done



; ||Object Text||

NationalForest1EntranceSignText:
    text "Jolly Sods"
    line "Regional Park"
    done

NationalForest1PondSignText:
    text "Jolly Pond"

    para "Get your feet wet"
    line "but watch out for"
    cont "wild #mon!"
    done



; ||Battles||

GenericTrainerOld_TimerSue:
    generictrainer OLD_TIMER, SUE, EVENT_BEAT_OLD_TIMER_SUE, Old_TimerSueSeenText, Old_TimerSueBeatenText

    text 