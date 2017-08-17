Route20_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

Route20_MapEventHeader:

.Warps: db 2
	warp_def 9, 62, 1, SEAFOAM_ISLANDS_1F
	warp_def 5, 54, 4, SEAFOAM_ISLANDS_1F

.XYTriggers: db 0

.Signposts: db 3
	signpost 11, 61, SIGNPOST_JUMPTEXT, CinnabarGymSignText
	signpost 7, 57, SIGNPOST_JUMPTEXT, SeafoamIslandsSignText
	signpost 10, 21, SIGNPOST_ITEM + STARDUST, EVENT_ROUTE_20_HIDDEN_STARDUST

.PersonEvents: db 13
	person_event SPRITE_SWIMMER_GIRL, 10, 91, SPRITEMOVEDATA_SPINCLOCKWISE, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_TRAINER, 3, TrainerSwimmerfNicole, -1
	person_event SPRITE_SWIMMER_GIRL, 13, 70, SPRITEMOVEDATA_SPINCOUNTERCLOCKWISE, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_TRAINER, 3, TrainerSwimmerfLori, -1
	person_event SPRITE_SWIMMER_GIRL, 4, 32, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_TRAINER, 3, TrainerSwimmerfMina, -1
	person_event SPRITE_SWIMMER_GIRL, 14, 54, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_TRAINER, 2, TrainerSwimmerfLeona, -1
	person_event SPRITE_SWIMMER_GUY, 6, 6, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_TRAINER, 3, TrainerSwimmermCameron, -1
	person_event SPRITE_SWIMMER_GUY, 3, 69, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_TRAINER, 3, TrainerSwimmermLuis, -1
	person_event SPRITE_SWIMMER_GUY, 8, 80, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_TRAINER, 3, TrainerSwimmermElmo, -1
	person_event SPRITE_LASS, 12, 16, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_TRAINER, 2, TrainerPicnickerCheyenne, -1
	person_event SPRITE_LASS, 14, 24, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_TRAINER, 5, TrainerPicnickerAdrian, -1
	person_event SPRITE_YOUNGSTER, 14, 12, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_TRAINER, 2, TrainerCamperPedro, -1
	person_event SPRITE_YOUNGSTER, 9, 38, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_TRAINER, 1, TrainerBird_keeperBert, -1
	person_event SPRITE_YOUNGSTER, 5, 61, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_TRAINER, 3, TrainerBird_keeperErnie, -1
	itemball_event 3, 64, BIG_PEARL, 1, EVENT_ROUTE_20_BIG_PEARL

TrainerSwimmerfNicole:
	trainer EVENT_BEAT_SWIMMERF_NICOLE, SWIMMERF, NICOLE, SwimmerfNicoleSeenText, SwimmerfNicoleBeatenText, 0, SwimmerfNicoleScript

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
	trainer EVENT_BEAT_SWIMMERF_LORI, SWIMMERF, LORI, SwimmerfLoriSeenText, SwimmerfLoriBeatenText, 0, SwimmerfLoriScript

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
	trainer EVENT_BEAT_SWIMMERF_MINA, SWIMMERF, MINA, .SeenText, .BeatenText, 0, .Script

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
	trainer EVENT_BEAT_SWIMMERF_LEONA, SWIMMERF, LEONA, .SeenText, .BeatenText, 0, .Script

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
	trainer EVENT_BEAT_SWIMMERM_CAMERON, SWIMMERM, CAMERON, SwimmermCameronSeenText, SwimmermCameronBeatenText, 0, SwimmermCameronScript

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
	trainer EVENT_BEAT_SWIMMERM_LUIS, SWIMMERM, SWIMMERM_LUIS, .SeenText, .BeatenText, 0, .Script

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
	trainer EVENT_BEAT_SWIMMERM_ELMO, SWIMMERM, ELMO, .SeenText, .BeatenText, 0, .Script

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
	trainer EVENT_BEAT_PICNICKER_CHEYENNE, PICNICKER, CHEYENNE, .SeenText, .BeatenText, 0, .Script

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
	trainer EVENT_BEAT_PICNICKER_ADRIAN, PICNICKER, ADRIAN, .SeenText, .BeatenText, 0, .Script

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
	trainer EVENT_BEAT_CAMPER_PEDRO, CAMPER, PEDRO, .SeenText, .BeatenText, 0, .Script

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
	trainer EVENT_BEAT_BIRD_KEEPER_BERT, BIRD_KEEPER, BERT, .SeenText, .BeatenText, 0, .Script

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
	trainer EVENT_BEAT_BIRD_KEEPER_ERNIE, BIRD_KEEPER, ERNIE, .SeenText, .BeatenText, 0, .Script

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
