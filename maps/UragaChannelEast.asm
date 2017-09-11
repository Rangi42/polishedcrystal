UragaChannelEast_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

UragaChannelEast_MapEventHeader:

.Warps: db 1
	warp_def 11, 2, 1, SCARY_CAVE_1F

.XYTriggers: db 0

.Signposts: db 6
	signpost 5, 45, SIGNPOST_JUMPTEXT, UragaChannelSignText
	signpost 13, 3, SIGNPOST_JUMPTEXT, ScaryCaveEastSignText
	signpost 4, 33, SIGNPOST_ITEM + NUGGET, EVENT_URAGA_CHANNEL_EAST_HIDDEN_NUGGET
	signpost 14, 34, SIGNPOST_ITEM + PEARL, EVENT_URAGA_CHANNEL_EAST_HIDDEN_PEARL
	signpost 12, 22, SIGNPOST_ITEM + BOTTLE_CAP, EVENT_URAGA_CHANNEL_EAST_HIDDEN_BOTTLE_CAP
	signpost 11, 9, SIGNPOST_ITEM + STAR_PIECE, EVENT_URAGA_CHANNEL_EAST_HIDDEN_STAR_PIECE

.PersonEvents: db 5
	person_event SPRITE_SWIMMER_GIRL, 2, 5, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_TRAINER, 1, TrainerSwimmerfWoda, -1
	person_event SPRITE_COOLTRAINER_M, 7, 22, SPRITEMOVEDATA_SPINCLOCKWISE, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_TRAINER, 1, TrainerCooltrainermKieran, -1
	person_event SPRITE_BIKER, 15, 34, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_TRAINER, 1, TrainerBikerTyrone, -1
	itemball_event 2, 9, DIVE_BALL, 1, EVENT_URAGA_CHANNEL_EAST_DIVE_BALL
	itemball_event 8, 20, EVIOLITE, 1, EVENT_URAGA_CHANNEL_EAST_EVIOLITE

TrainerSwimmerfWoda:
	trainer EVENT_BEAT_SWIMMERF_WODA, SWIMMERF, WODA, .SeenText, .BeatenText, 0, .Script

.Script:
	end_if_just_battled
	jumptextfaceplayer .AfterText

.SeenText:
	text "Did you come here"
	line "to train too?"
	done

.BeatenText:
	text "You don't need"
	line "more training!"
	done

.AfterText:
	text "The strong curr-"
	line "ents here make it"
	cont "a good place to"
	cont "train."
	done

TrainerCooltrainermKieran:
	trainer EVENT_BEAT_COOLTRAINERM_KIERAN, COOLTRAINERM, KIERAN, .SeenText, .BeatenText, 0, .Script

.Script:
	end_if_just_battled
	jumptextfaceplayer .AfterText

.SeenText:
	text "It's on like"
	line "#mon!"
	done

.BeatenText:
	text "Game over."
	done

.AfterText:
	text "I couldn't get my"
	line "#m-on."

	para "I need to get my"
	line "head back in the"
	cont "game."
	done

TrainerBikerTyrone:
	trainer EVENT_BEAT_BIKER_TYRONE, BIKER, TYRONE, .SeenText, .BeatenText, 0, .Script

.Script:
	end_if_just_battled
	jumptextfaceplayer .AfterText

.SeenText:
	text "Cough! Splutter!"
	done

.BeatenText:
	text "…Gasp!"
	done

.AfterText:
	text "I fell in the"
	line "water while show-"
	cont "ing off on Cycling"
	cont "Road."

	para "Then the strong"
	line "currents dragged"
	cont "me here."
	done

UragaChannelSignText:
	text "Uraga Channel"
	done

ScaryCaveEastSignText:
	text "There's graffiti"
	line "on this sign…"

	para "“This cave is"
	line "scary!”"
	done
