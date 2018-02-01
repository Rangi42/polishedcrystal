Route20_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 2 ; warp events
	warp_event 62, 9, 1, SEAFOAM_ISLANDS_1F
	warp_event 54, 5, 4, SEAFOAM_ISLANDS_1F

	db 0 ; coord events

	db 3 ; bg events
	bg_event 61, 11, SIGNPOST_JUMPTEXT, CinnabarGymSignText
	bg_event 57, 7, SIGNPOST_JUMPTEXT, SeafoamIslandsSignText
	bg_event 21, 10, SIGNPOST_ITEM + STARDUST, EVENT_ROUTE_20_HIDDEN_STARDUST

	db 13 ; object events
	object_event 91, 10, SPRITE_SWIMMER_GIRL, SPRITEMOVEDATA_SPINCLOCKWISE, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_TRAINER, 3, TrainerSwimmerfNicole, -1
	object_event 70, 13, SPRITE_SWIMMER_GIRL, SPRITEMOVEDATA_SPINCOUNTERCLOCKWISE, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_TRAINER, 3, TrainerSwimmerfLori, -1
	object_event 32, 4, SPRITE_SWIMMER_GIRL, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_TRAINER, 3, TrainerSwimmerfMina, -1
	object_event 54, 14, SPRITE_SWIMMER_GIRL, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_TRAINER, 2, TrainerSwimmerfLeona, -1
	object_event 6, 6, SPRITE_SWIMMER_GUY, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_TRAINER, 3, TrainerSwimmermCameron, -1
	object_event 69, 3, SPRITE_SWIMMER_GUY, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_TRAINER, 3, TrainerSwimmermLuis, -1
	object_event 80, 8, SPRITE_SWIMMER_GUY, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_TRAINER, 3, TrainerSwimmermElmo, -1
	object_event 16, 12, SPRITE_LASS, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_TRAINER, 2, TrainerPicnickerCheyenne, -1
	object_event 24, 14, SPRITE_LASS, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_TRAINER, 5, TrainerPicnickerAdrian, -1
	object_event 12, 14, SPRITE_YOUNGSTER, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_TRAINER, 2, TrainerCamperPedro, -1
	object_event 38, 9, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_TRAINER, 1, TrainerBird_keeperBert, -1
	object_event 61, 5, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_TRAINER, 3, TrainerBird_keeperErnie, -1
	itemball_event 64, 3, BIG_PEARL, 1, EVENT_ROUTE_20_BIG_PEARL

TrainerSwimmerfNicole:
	trainer SWIMMERF, NICOLE, EVENT_BEAT_SWIMMERF_NICOLE, SwimmerfNicoleSeenText, SwimmerfNicoleBeatenText, 0, SwimmerfNicoleScript

SwimmerfNicoleScript:
	end_if_just_battled
	jumptextfaceplayer UnknownText_0x1acd93

SwimmerfNicoleSeenText:
	text "I feel so much"
	line "lighter in water."
	done

SwimmerfNicoleBeatenText:
	text "Oh, no!"
	done

UnknownText_0x1acd93:
	text "Swimming exercises"
	line "your full body."

	para "It's really good"
	line "for you."
	done

TrainerSwimmerfLori:
	trainer SWIMMERF, LORI, EVENT_BEAT_SWIMMERF_LORI, SwimmerfLoriSeenText, SwimmerfLoriBeatenText, 0, SwimmerfLoriScript

SwimmerfLoriScript:
	end_if_just_battled
	jumptextfaceplayer UnknownText_0x1ace15

SwimmerfLoriSeenText:
	text "What an impressive"
	line "collection of Gym"

	para "Badges. We should"
	line "battle!"
	done

SwimmerfLoriBeatenText:
	text "No!"
	done

UnknownText_0x1ace15:
	text "Surf is no longer"
	line "the only HM move"
	cont "you use in water."
	done

TrainerSwimmerfMina:
	trainer SWIMMERF, MINA, EVENT_BEAT_SWIMMERF_MINA, .SeenText, .BeatenText, 0, .Script

.Script:
	end_if_just_battled
	jumptextfaceplayer .AfterText

.SeenText:
	text "Mmph? Mmmph"
	line "mmmmphh?"

	para "Mmmmph"
	line "mmmmmppphh!"
	done

.BeatenText:
	text "Pwah!"
	done

.AfterText:
	text "I was trying to"
	line "see how long I"

	para "could hold my"
	line "breath!"
	done

TrainerSwimmerfLeona:
	trainer SWIMMERF, LEONA, EVENT_BEAT_SWIMMERF_LEONA, .SeenText, .BeatenText, 0, .Script

.Script:
	end_if_just_battled
	jumptextfaceplayer .AfterText

.SeenText:
	text "Look! It's my very"
	line "best swimsuit and"

	para "my very best"
	line "#mon!"
	done

.BeatenText:
	text "Ohhh!"
	done

.AfterText:
	text "Your #mon--are"
	line "you following the"

	para "latest trend in"
	line "teams?"
	done

TrainerSwimmermCameron:
	trainer SWIMMERM, CAMERON, EVENT_BEAT_SWIMMERM_CAMERON, SwimmermCameronSeenText, SwimmermCameronBeatenText, 0, SwimmermCameronScript

SwimmermCameronScript:
	end_if_just_battled
	jumptextfaceplayer UnknownText_0x1ace8b

SwimmermCameronSeenText:
	text "I guess it's im-"
	line "possible to swim"

	para "all the way to"
	line "Johto."
	done

SwimmermCameronBeatenText:
	text "Aiyah!"
	done

UnknownText_0x1ace8b:
	text "Besides the sea, I"
	line "can also swim in"
	cont "ponds and rivers."
	done

TrainerSwimmermLuis:
	trainer SWIMMERM, SWIMMERM_LUIS, EVENT_BEAT_SWIMMERM_LUIS, .SeenText, .BeatenText, 0, .Script

.Script:
	end_if_just_battled
	jumptextfaceplayer .AfterText

.SeenText:
	text "I've worn my best"
	line "swim trunks today!"
	done

.BeatenText:
	text "Even with my best"
	line "pants, I just"
	cont "didn't win."
	done

.AfterText:
	text "All right! Next"
	line "time I'll wear"
	cont "party swim trunks!"
	done

TrainerSwimmermElmo:
	trainer SWIMMERM, ELMO, EVENT_BEAT_SWIMMERM_ELMO, .SeenText, .BeatenText, 0, .Script

.Script:
	end_if_just_battled
	jumptextfaceplayer .AfterText

.SeenText:
	text "I used to be a"
	line "Fisherman."

	para "I've grown to love"
	line "swimming so much,"

	para "I'm always in my"
	line "swim trunks!"
	done

.BeatenText:
	text "Ulp…"
	done

.AfterText:
	text "Maybe I should go"
	line "back to fishing…"
	done

TrainerPicnickerCheyenne:
	trainer PICNICKER, CHEYENNE, EVENT_BEAT_PICNICKER_CHEYENNE, .SeenText, .BeatenText, 0, .Script

.Script:
	end_if_just_battled
	jumptextfaceplayer .AfterText

.SeenText:
	text "When I was a kid,"
	line "I only played in-"
	cont "side the house."

	para "Now I love playing"
	line "outside with #-"
	cont "mon!"
	done

.BeatenText:
	text "Argh!"
	done

.AfterText:
	text "If I'm with #-"
	line "mon, I don't mind"
	cont "losing so much!"
	done

TrainerPicnickerAdrian:
	trainer PICNICKER, ADRIAN, EVENT_BEAT_PICNICKER_ADRIAN, .SeenText, .BeatenText, 0, .Script

.Script:
	end_if_just_battled
	jumptextfaceplayer .AfterText

.SeenText:
	text "Are you in a"
	line "hurry?"

	para "How about a quick"
	line "battle break?"
	done

.BeatenText:
	text "Aaahh… that's it."
	done

.AfterText:
	text "Even though I"
	line "lost, I had fun!"
	done

TrainerCamperPedro:
	trainer CAMPER, PEDRO, EVENT_BEAT_CAMPER_PEDRO, .SeenText, .BeatenText, 0, .Script

.Script:
	end_if_just_battled
	jumptextfaceplayer .AfterText

.SeenText:
	text "Have you ever gone"
	line "camping with #-"
	cont "mon?"
	done

.BeatenText:
	text "You're strong!"
	done

.AfterText:
	text "If you forget your"
	line "blanket, you can"

	para "snuggle up to a"
	line "warm #mon!"
	done

TrainerBird_keeperBert:
	trainer BIRD_KEEPER, BERT, EVENT_BEAT_BIRD_KEEPER_BERT, .SeenText, .BeatenText, 0, .Script

.Script:
	end_if_just_battled
	jumptextfaceplayer .AfterText

.SeenText:
	text "Found it! A"
	line "trainer that I can"
	cont "enjoy fighting!"
	done

.BeatenText:
	text "I lost with all my"
	line "strength!"
	done

.AfterText:
	text "That was an in-"
	line "credible battle!"

	para "I've got goose"
	line "bumps!"
	done

TrainerBird_keeperErnie:
	trainer BIRD_KEEPER, ERNIE, EVENT_BEAT_BIRD_KEEPER_ERNIE, .SeenText, .BeatenText, 0, .Script

.Script:
	end_if_just_battled
	jumptextfaceplayer .AfterText

.SeenText:
	text "Hey, hey. Will you"
	line "battle me?"
	done

.BeatenText:
	text "That was pretty"
	line "incredible."
	done

.AfterText:
	text "You're something"
	line "special!"
	done

CinnabarGymSignText:
	text "Seafoam Islands"

	para "…What does this"
	line "notice say?"

	para "Cinnabar Gym"
	line "Leader: Blaine"
	done

SeafoamIslandsSignText:
	text "Seafoam Islands"
	done
