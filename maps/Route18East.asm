Route18East_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

Route18East_MapEventHeader:

.Warps: db 2
	warp_def 6, 4, 3, ROUTE_18_GATE
	warp_def 7, 4, 4, ROUTE_18_GATE

.XYTriggers: db 0

.Signposts: db 1
	signpost 5, 11, SIGNPOST_JUMPTEXT, Route18SignText

.PersonEvents: db 2
	person_event SPRITE_YOUNGSTER, 12, 11, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_TRAINER, 3, TrainerBird_keeperBoris, -1
	person_event SPRITE_YOUNGSTER, 6, 15, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_TRAINER, 3, TrainerBird_keeperBob, -1

TrainerBird_keeperBoris:
	trainer EVENT_BEAT_BIRD_KEEPER_BORIS, BIRD_KEEPER, BORIS, Bird_keeperBorisSeenText, Bird_keeperBorisBeatenText, 0, Bird_keeperBorisScript

Bird_keeperBorisScript:
	end_if_just_battled
	jumptextfaceplayer UnknownText_0x1acfa5

TrainerBird_keeperBob:
	trainer EVENT_BEAT_BIRD_KEEPER_BOB, BIRD_KEEPER, BOB, Bird_keeperBobSeenText, Bird_keeperBobBeatenText, 0, Bird_keeperBobScript

Bird_keeperBobScript:
	end_if_just_battled
	jumptextfaceplayer UnknownText_0x1ad00d

Bird_keeperBorisSeenText:
	text "If you're looking"
	line "for #mon, you"

	para "have to look in"
	line "the tall grass."
	done

Bird_keeperBorisBeatenText:
	text "Ayieee!"
	done

UnknownText_0x1acfa5:
	text "Since you're so"
	line "strong, it must be"
	cont "fun to battle."
	done

Bird_keeperBobSeenText:
	text "Cycling Road is a"
	line "quick shortcut to"
	cont "Celadon."
	done

Bird_keeperBobBeatenText:
	text "…Whew!"
	done

UnknownText_0x1ad00d:
	text "If you don't have"
	line "a Bicycle, you're"

	para "not allowed to use"
	line "the shortcut."
	done

Route18SignText:
	text "Route 18"

	para "Celadon City -"
	line "Fuchsia City"
	done
