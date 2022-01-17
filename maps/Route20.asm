Route20_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event 70,  9, SEAFOAM_ISLANDS_1F, 1
	warp_event 62,  5, SEAFOAM_ISLANDS_1F, 4

	def_coord_events

	def_bg_events
	bg_event 69, 11, BGEVENT_JUMPTEXT, CinnabarGymSignText
	bg_event 65,  7, BGEVENT_JUMPTEXT, SeafoamIslandsSignText
	bg_event 23, 10, BGEVENT_ITEM + STARDUST, EVENT_ROUTE_20_HIDDEN_STARDUST

	def_object_events
	object_event 99, 10, SPRITE_SWIMMER_GIRL, SPRITEMOVEDATA_SPINCLOCKWISE, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerSwimmerfNicole, -1
	object_event 78, 13, SPRITE_SWIMMER_GIRL, SPRITEMOVEDATA_SPINCOUNTERCLOCKWISE, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerSwimmerfLori, -1
	object_event 32,  4, SPRITE_SWIMMER_GIRL, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerSwimmerfMina, -1
	object_event 62, 14, SPRITE_SWIMMER_GIRL, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 2, GenericTrainerSwimmerfLeona, -1
	object_event  8,  6, SPRITE_SWIMMER_GUY, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerSwimmermCameron, -1
	object_event 77,  3, SPRITE_SWIMMER_GUY, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerSwimmermLuis, -1
	object_event 88,  8, SPRITE_SWIMMER_GUY, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerSwimmermElmo, -1
	object_event 18, 12, SPRITE_PICNICKER, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 2, GenericTrainerPicnickerCheyenne, -1
	object_event 26, 14, SPRITE_PICNICKER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 5, GenericTrainerPicnickerAdrian, -1
	object_event 14, 14, SPRITE_CAMPER, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 2, GenericTrainerCamperPedro, -1
	object_event 46,  9, SPRITE_BIRD_KEEPER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 1, GenericTrainerBird_keeperBert, -1
	object_event 69,  5, SPRITE_BIRD_KEEPER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerBird_keeperErnie, -1
	itemball_event 72,  3, BIG_PEARL, 1, EVENT_ROUTE_20_BIG_PEARL

GenericTrainerSwimmerfNicole:
	generictrainer SWIMMERF, NICOLE, EVENT_BEAT_SWIMMERF_NICOLE, SwimmerfNicoleSeenText, SwimmerfNicoleBeatenText

	ctxt "Swimming exercises"
	line "your full body."

	para "It's really good"
	line "for you."
	done

SwimmerfNicoleSeenText:
	ctxt "I feel so much"
	line "lighter in water."
	done

SwimmerfNicoleBeatenText:
	ctxt "Oh, no!"
	done

GenericTrainerSwimmerfLori:
	generictrainer SWIMMERF, LORI, EVENT_BEAT_SWIMMERF_LORI, SwimmerfLoriSeenText, SwimmerfLoriBeatenText

	ctxt "Surf is no longer"
	line "the only HM move"
	cont "you use in water."
	done

SwimmerfLoriSeenText:
	ctxt "What an impressive"
	line "collection of Gym"

	para "Badges. We should"
	line "battle!"
	done

SwimmerfLoriBeatenText:
	ctxt "No!"
	done

GenericTrainerSwimmerfMina:
	generictrainer SWIMMERF, MINA, EVENT_BEAT_SWIMMERF_MINA, .SeenText, .BeatenText

	ctxt "I was trying to"
	line "see how long I"

	para "could hold my"
	line "breath!"
	done

.SeenText:
	ctxt "Mmph? Mmmph"
	line "mmmmphh?"

	para "Mmmmph"
	line "mmmmmppphh!"
	done

.BeatenText:
	ctxt "Pwah!"
	done

GenericTrainerSwimmerfLeona:
	generictrainer SWIMMERF, LEONA, EVENT_BEAT_SWIMMERF_LEONA, .SeenText, .BeatenText

	ctxt "Your #mon--are"
	line "you following the"

	para "latest trend in"
	line "teams?"
	done

.SeenText:
	ctxt "Look! It's my very"
	line "best swimsuit and"

	para "my very best"
	line "#mon!"
	done

.BeatenText:
	ctxt "Ohhh!"
	done

GenericTrainerSwimmermCameron:
	generictrainer SWIMMERM, CAMERON, EVENT_BEAT_SWIMMERM_CAMERON, SwimmermCameronSeenText, SwimmermCameronBeatenText

	ctxt "Besides the sea, I"
	line "can also swim in"
	cont "ponds and rivers."
	done

SwimmermCameronSeenText:
	ctxt "I guess it's im-"
	line "possible to swim"

	para "all the way to"
	line "Johto."
	done

SwimmermCameronBeatenText:
	ctxt "Aiyah!"
	done

GenericTrainerSwimmermLuis:
	generictrainer SWIMMERM, SWIMMERM_LUIS, EVENT_BEAT_SWIMMERM_LUIS, .SeenText, .BeatenText

	ctxt "All right! Next"
	line "time I'll wear"
	cont "party swim trunks!"
	done

.SeenText:
	ctxt "I've worn my best"
	line "swim trunks today!"
	done

.BeatenText:
	ctxt "Even with my best"
	line "pants, I just"
	cont "didn't win."
	done

GenericTrainerSwimmermElmo:
	generictrainer SWIMMERM, ELMO, EVENT_BEAT_SWIMMERM_ELMO, .SeenText, .BeatenText

	ctxt "Maybe I should go"
	line "back to fishing…"
	done

.SeenText:
	ctxt "I used to be a"
	line "Fisherman."

	para "I've grown to love"
	line "swimming so much,"

	para "I'm always in my"
	line "swim trunks!"
	done

.BeatenText:
	ctxt "Ulp…"
	done

GenericTrainerPicnickerCheyenne:
	generictrainer PICNICKER, CHEYENNE, EVENT_BEAT_PICNICKER_CHEYENNE, .SeenText, .BeatenText

	ctxt "If I'm with #-"
	line "mon, I don't mind"
	cont "losing so much!"
	done

.SeenText:
	ctxt "When I was a kid,"
	line "I only played in-"
	cont "side the house."

	para "Now I love playing"
	line "outside with #-"
	cont "mon!"
	done

.BeatenText:
	ctxt "Argh!"
	done

GenericTrainerPicnickerAdrian:
	generictrainer PICNICKER, ADRIAN, EVENT_BEAT_PICNICKER_ADRIAN, .SeenText, .BeatenText

	ctxt "Even though I"
	line "lost, I had fun!"
	done

.SeenText:
	ctxt "Are you in a"
	line "hurry?"

	para "How about a quick"
	line "battle break?"
	done

.BeatenText:
	ctxt "Aaahh… that's it."
	done

GenericTrainerCamperPedro:
	generictrainer CAMPER, PEDRO, EVENT_BEAT_CAMPER_PEDRO, .SeenText, .BeatenText

	ctxt "If you forget your"
	line "blanket, you can"

	para "snuggle up to a"
	line "warm #mon!"
	done

.SeenText:
	ctxt "Have you ever gone"
	line "camping with #-"
	cont "mon?"
	done

.BeatenText:
	ctxt "You're strong!"
	done

GenericTrainerBird_keeperBert:
	generictrainer BIRD_KEEPER, BERT, EVENT_BEAT_BIRD_KEEPER_BERT, .SeenText, .BeatenText

	ctxt "That was an in-"
	line "credible battle!"

	para "I've got goose"
	line "bumps!"
	done

.SeenText:
	ctxt "Found it! A"
	line "trainer that I can"
	cont "enjoy fighting!"
	done

.BeatenText:
	ctxt "I lost with all my"
	line "strength!"
	done

GenericTrainerBird_keeperErnie:
	generictrainer BIRD_KEEPER, ERNIE, EVENT_BEAT_BIRD_KEEPER_ERNIE, .SeenText, .BeatenText

	ctxt "You're something"
	line "special!"
	done

.SeenText:
	ctxt "Hey, hey. Will you"
	line "battle me?"
	done

.BeatenText:
	ctxt "That was pretty"
	line "incredible."
	done

CinnabarGymSignText:
	ctxt "Seafoam Islands"

	para "…What does this"
	line "notice say?"

	para "Cinnabar Gym"
	line "Leader: Blaine"
	done

SeafoamIslandsSignText:
	ctxt "Seafoam Islands"
	done
