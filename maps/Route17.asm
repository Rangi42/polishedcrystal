Route17_MapScriptHeader:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_NEWMAP, Route17AlwaysOnBikeCallback

	def_warp_events

	def_coord_events

	def_bg_events
	bg_event 11, 71, BGEVENT_ITEM + MAX_ETHER, EVENT_ROUTE_17_HIDDEN_MAX_ETHER
	bg_event 10, 123, BGEVENT_ITEM + MAX_ELIXIR, EVENT_ROUTE_17_HIDDEN_MAX_ELIXIR
	bg_event  9, 64, BGEVENT_JUMPTEXT, Route17Notice1Text
	bg_event  9, 71, BGEVENT_JUMPTEXT, Route17TrainerTips1Text
	bg_event  9, 94, BGEVENT_JUMPTEXT, Route17TrainerTips2Text
	bg_event  9, 101, BGEVENT_JUMPTEXT, Route17Notice2Text

	def_object_events
	object_event 12,  9, SPRITE_BIKER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 4, GenericTrainerBikerDale, -1
	object_event  4, 17, SPRITE_BIKER, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 4, GenericTrainerBikerReilly, -1
	object_event 18, 24, SPRITE_BIKER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerBikerJacob, -1
	object_event  2, 37, SPRITE_BIKER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerBikerDan, -1
	object_event  3, 56, SPRITE_BIKER, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerBikerGlenn, -1
	object_event  9, 65, SPRITE_BIKER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 2, GenericTrainerBikerJoel, -1
	object_event 13, 72, SPRITE_BIKER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 4, GenericTrainerBikerAiden, -1
	object_event  3, 86, SPRITE_BIKER, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 2, GenericTrainerBikerTeddy, -1
	object_event  6, 128, SPRITE_BIKER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, ObjectEvent, -1
	object_event  1, 29, SPRITE_ROUGHNECK, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerRoughneckBrian, -1
	object_event  6, 42, SPRITE_ROUGHNECK, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 2, GenericTrainerRoughneckTheron, -1
	object_event  4, 91, SPRITE_ROUGHNECK, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 2, GenericTrainerRoughneckMarkey, -1

Route17AlwaysOnBikeCallback:
	setflag ENGINE_ALWAYS_ON_BIKE
	setflag ENGINE_DOWNHILL
	endcallback

GenericTrainerBikerReilly:
	generictrainer BIKER, REILLY, EVENT_BEAT_BIKER_REILLY, BikerReillySeenText, BikerReillyBeatenText

	ctxt "Don't get cocky,"
	line "you Johto punk!"
	done

BikerReillySeenText:
	ctxt "Hey, you! You're"
	line "from Johto, huh?"
	done

BikerReillyBeatenText:
	ctxt "Whoa, you kick!"
	done

GenericTrainerBikerJoel:
	generictrainer BIKER, JOEL, EVENT_BEAT_BIKER_JOEL, BikerJoelSeenText, BikerJoelBeatenText

	ctxt "I look cool, but"
	line "I'm weak, so I'm"
	cont "not really cool."

	para "I have to train"
	line "harder…"
	done

BikerJoelSeenText:
	ctxt "Wow. That's a cool"
	line "Bicycle!"
	done

BikerJoelBeatenText:
	ctxt "But you don't just"
	line "look cool…"
	done

GenericTrainerBikerGlenn:
	generictrainer BIKER, GLENN, EVENT_BEAT_BIKER_GLENN, BikerGlennSeenText, BikerGlennBeatenText

	ctxt "Hands-free riding"
	line "is considered cool"
	cont "on Cycling Road."
	done

BikerGlennSeenText:
	ctxt "Hey! Want to have"
	line "a speed battle?"
	done

BikerGlennBeatenText:
	ctxt "Yikes! You've got"
	line "awesome torque!"
	done

GenericTrainerBikerDale:
	generictrainer BIKER, DALE, EVENT_BEAT_BIKER_DALE, BikerDaleSeenText, BikerDaleBeatenText

	ctxt "You're so cool!"
	line "You don't do any-"
	cont "thing halfway!"
	done

BikerDaleSeenText:
	ctxt "You're gonna lose!"
	line "I've got a hunch!"
	done

BikerDaleBeatenText:
	ctxt "Maybe my hunch was"
	line "a little off…"
	done

GenericTrainerBikerJacob:
	generictrainer BIKER, JACOB, EVENT_BEAT_BIKER_JACOB, BikerJacobSeenText, BikerJacobBeatenText

	ctxt "Chopper? Oh, I"
	line "was talking about"
	cont "my Bicycle!"
	done

BikerJacobSeenText:
	ctxt "Modding my"
	line "chopper costs a"

	para "bunch of money!"
	line "I need a job!"
	done

BikerJacobBeatenText:
	ctxt "Argh. I failed!"
	done

GenericTrainerBikerAiden:
	generictrainer BIKER, AIDEN, EVENT_BEAT_BIKER_AIDEN, BikerAidenSeenText, BikerAidenBeatenText

	ctxt "Gaon gaooon!"
	line "Buwaribaribari…!"

	para "There, my engine"
	line "imitation has"
	cont "evolved!"
	done

BikerAidenSeenText:
	ctxt "Vroom vroom!"
	line "Baribaribaribari!"

	para "What do you think"
	line "of my engine"
	cont "imitation?"
	done

BikerAidenBeatenText:
	ctxt "Hnnff… hnnff…"
	line "I'm out of breath…"
	done

GenericTrainerBikerDan:
	generictrainer BIKER, DAN, EVENT_BEAT_BIKER_DAN, BikerDanSeenText, BikerDanBeatenText

	ctxt "I love this melan-"
	line "choly melody."

	para "It really suits me"
	line "well…"
	done

BikerDanSeenText:
	ctxt "Parara parapara"
	line "para-parara!"

	para "My horn's got a"
	line "great sound to it,"
	cont "don't you think?"
	done

BikerDanBeatenText:
	ctxt "Paaraaraaaaa…"
	done

GenericTrainerBikerTeddy:
	generictrainer BIKER, TEDDY, EVENT_BEAT_BIKER_TEDDY, BikerTeddySeenText, BikerTeddyBeatenText

	ctxt "I love the way you"
	line "do battle, too!"

	cont "Consider me a fan!"
	done

BikerTeddySeenText:
	ctxt "Hey, that's a cool"
	line "Bike you're riding!"
	done

BikerTeddyBeatenText:
	ctxt "Great job."
	done

GenericTrainerRoughneckBrian:
	generictrainer ROUGHNECK, BRIAN, EVENT_BEAT_ROUGHNECK_BRIAN, RoughneckBrianSeenText, RoughneckBrianBeatenText

	ctxt "See you later!"
	line "Come back anytime!"
	done

RoughneckBrianSeenText:
	ctxt "Hey, who told you"
	line "you could ride"
	cont "on this road?"
	done

RoughneckBrianBeatenText:
	ctxt "Crash!"
	done

GenericTrainerRoughneckTheron:
	generictrainer ROUGHNECK, THERON, EVENT_BEAT_ROUGHNECK_THERON, RoughneckTheronSeenText, RoughneckTheronBeatenText

	ctxt "You wanna join"
	line "my team?"

	para "Won't you give it"
	line "a try?"
	done

RoughneckTheronSeenText:
	ctxt "I'll toughen you"
	line "up. Now, you come"
	cont "along with me."
	done

RoughneckTheronBeatenText:
	ctxt "I lost. I lost!"
	done

GenericTrainerRoughneckMarkey:
	generictrainer ROUGHNECK, MARKEY, EVENT_BEAT_ROUGHNECK_MARKEY, RoughneckMarkeySeenText, RoughneckMarkeyBeatenText

	ctxt "All right!"

	para "That fighting"
	line "yell was great!"
	done

RoughneckMarkeySeenText:
	ctxt "Hey hey hey!"
	line "You're in my way!"

	para "IN MY WAY!"
	done

RoughneckMarkeyBeatenText:
	ctxt "All right, thanks!"
	done

Route17Notice1Text:
	ctxt "It's a notice."

	para "Watch out for"
	line "discarded items!"
	done

Route17TrainerTips1Text:
	ctxt "Trainer Tips"

	para "All #mon are"
	line "unique."

	para "Two #mon of the"
	line "same species and"
	cont "level may still"

	para "look, act, and"
	line "grow differently."
	done

Route17TrainerTips2Text:
	ctxt "Trainer Tips"

	para "Open the Start"
	line "menu to stay in"
	cont "place while on a"
	cont "slope."
	done

Route17Notice2Text:
	ctxt "It's a notice."

	para "Don't throw the"
	line "game, throw #"
	cont "Balls instead!"
	done
