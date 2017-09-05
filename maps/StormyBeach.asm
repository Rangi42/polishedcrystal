StormyBeach_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

StormyBeach_MapEventHeader:

.Warps: db 2
	warp_def 4, 30, 1, MURKY_SWAMP
	warp_def 4, 31, 2, MURKY_SWAMP

.XYTriggers: db 0

.Signposts: db 1
	signpost 6, 17, SIGNPOST_ITEM + STARDUST, EVENT_STORMY_BEACH_HIDDEN_STARDUST

.PersonEvents: db 11
	person_event SPRITE_GOLDENROD_LYRA, 13, 5, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_TRAINER, 4, TrainerSwimmerfBarbara, -1
	person_event SPRITE_YOUNGSTER, 8, 14, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_TRAINER, 3, TrainerBird_keeperJulian, -1
	person_event SPRITE_YOUNGSTER, 7, 28, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_TRAINER, 4, TrainerCamperFelix, -1
	person_event SPRITE_LASS, 11, 24, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_TRAINER, 3, TrainerPicnickerLily, -1
	person_event SPRITE_SWIMMER_GUY, 17, 26, SPRITEMOVEDATA_SWIM_AROUND, 1, 1, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_COMMAND, jumptextfaceplayer, StormyBeachSwimmermText, -1
	person_event SPRITE_GRAMPS, 12, 32, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, -1, (1 << 3) | PAL_OW_PURPLE, PERSONTYPE_COMMAND, jumptextfaceplayer, StormyBeachGrampsText, -1
	itemball_event 7, 34, ZINC, 1, EVENT_STORMY_BEACH_ZINC
	smashrock_event 6, 16
	smashrock_event 7, 17
	smashrock_event 9, 12
	smashrock_event 10, 18

TrainerSwimmerfBarbara:
	trainer EVENT_BEAT_SWIMMERF_BARBARA, SWIMMERF, BARBARA, .SeenText, .BeatenText, 0, .Script

.Script:
	end_if_just_battled
	jumptextfaceplayer .AfterText

.SeenText:
	text "I was resting for"
	line "a while, but I am"

	para "always ready to"
	line "fight!"
	done

.BeatenText:
	text "It was a good"
	line "battle, even if"
	cont "I lost."
	done

.AfterText:
	text "I'm being dragged"
	line "by the tides…"
	done

TrainerBird_keeperJulian:
	trainer EVENT_BEAT_BIRD_KEEPER_JULIAN, BIRD_KEEPER, JULIAN, .SeenText, .BeatenText, 0, .Script

.Script:
	end_if_just_battled
	jumptextfaceplayer .AfterText

.SeenText:
	text "I'm training my"
	line "Flying-type #-"
	cont "mon here."

	para "Want to help me?"
	done

.BeatenText:
	text "I lost…"
	line "What a pity!"
	done

.AfterText:
	text "It's harder to fly"
	line "in stormy places"
	cont "like this."
	done

TrainerCamperFelix:
	trainer EVENT_BEAT_CAMPER_FELIX, CAMPER, FELIX, .SeenText, .BeatenText, 0, .Script

.Script:
	end_if_just_battled
	jumptextfaceplayer .AfterText

.SeenText:
	text "I'm searching for"
	line "firewood."
	cont "Wanna help?"
	done

.BeatenText:
	text "I'll take that as"
	line "a no…"
	done

.AfterText:
	text "We're having a"
	line "barbecue later!"

	para "All I need is some"
	line "firewood for my"
	cont "#mon to light."
	done

TrainerPicnickerLily:
	trainer EVENT_BEAT_PICNICKER_LILY, PICNICKER, LILY, .SeenText, .BeatenText, 0, .Script

.Script:
	end_if_just_battled
	jumptextfaceplayer .AfterText

.SeenText:
	text "I'm hungry!"
	done

.BeatenText:
	text "I was battling on"
	line "an empty stomach!"
	done

.AfterText:
	text "I came here for a"
	line "picnic, but forgot"
	cont "the food!"
	cont "How embarrassing!"
	done

StormyBeachSwimmermText:
	text "We're here on a"
	line "camping trip,"

	para "but the weather"
	line "doesn't look great…"
	done

StormyBeachGrampsText:
	text "Can you feel it in"
	line "the air? A storm"
	cont "is brewing."

	para "A befitting omen"
	line "for those looking"
	cont "to explore the"
	cont "swamp."
	done
