UragaChannelEast_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 1 ; warp events
	warp_event  2, 11, SCARY_CAVE_1F, 1

	db 0 ; coord events

	db 6 ; bg events
	bg_event 45,  5, SIGNPOST_JUMPTEXT, UragaChannelSignText
	bg_event  3, 13, SIGNPOST_JUMPTEXT, ScaryCaveEastSignText
	bg_event 33,  4, SIGNPOST_ITEM + NUGGET, EVENT_URAGA_CHANNEL_EAST_HIDDEN_NUGGET
	bg_event 34, 14, SIGNPOST_ITEM + PEARL, EVENT_URAGA_CHANNEL_EAST_HIDDEN_PEARL
	bg_event 22, 12, SIGNPOST_ITEM + BOTTLE_CAP, EVENT_URAGA_CHANNEL_EAST_HIDDEN_BOTTLE_CAP
	bg_event  9, 11, SIGNPOST_ITEM + STAR_PIECE, EVENT_URAGA_CHANNEL_EAST_HIDDEN_STAR_PIECE

	db 5 ; object events
	object_event  5,  2, SPRITE_SWIMMER_GIRL, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_TRAINER, 1, TrainerSwimmerfWoda, -1
	object_event 22,  7, SPRITE_COOLTRAINER_M, SPRITEMOVEDATA_SPINCLOCKWISE, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_TRAINER, 1, TrainerCooltrainermKieran, -1
	object_event 34, 15, SPRITE_BIKER, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_TRAINER, 1, TrainerBikerTyrone, -1
	itemball_event  9,  2, DIVE_BALL, 1, EVENT_URAGA_CHANNEL_EAST_DIVE_BALL
	itemball_event 20,  8, EVIOLITE, 1, EVENT_URAGA_CHANNEL_EAST_EVIOLITE

TrainerSwimmerfWoda:
	trainer SWIMMERF, WODA, EVENT_BEAT_SWIMMERF_WODA, .SeenText, .BeatenText, 0, .Script

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
	trainer COOLTRAINERM, KIERAN, EVENT_BEAT_COOLTRAINERM_KIERAN, .SeenText, .BeatenText, 0, .Script

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
	trainer BIKER, TYRONE, EVENT_BEAT_BIKER_TYRONE, .SeenText, .BeatenText, 0, .Script

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
