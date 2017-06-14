const_value set 2
	const URAGACHANNELEAST_SWIMMER_GIRL
	const URAGACHANNELEAST_COOLTRAINER_M
	const URAGACHANNELEAST_BIKER
	const URAGACHANNELEAST_POKE_BALL1
	const URAGACHANNELEAST_POKE_BALL2

UragaChannelEast_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

TrainerSwimmerfWoda:
	trainer EVENT_BEAT_SWIMMERF_WODA, SWIMMERF, WODA, .SeenText, .BeatenText, 0, .Script

.Script:
	end_if_just_battled
	opentext
	writetext .AfterText
	waitbutton
	closetext
	end

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
	opentext
	writetext .AfterText
	waitbutton
	closetext
	end

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
	opentext
	writetext .AfterText
	waitbutton
	closetext
	end

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

UragaChannelEastDiveBall:
	itemball DIVE_BALL

UragaChannelEastEviolite:
	itemball EVIOLITE

UragaChannelSign:
	habitatlist UragaChannelSignText, URAGA_CHANNEL

UragaChannelSignText:
	text "Uraga Channel"
	done

ScaryCaveEastSign:
	habitatlist ScaryCaveEastSignText, SCARY_CAVE

ScaryCaveEastSignText:
	text "There's graffiti"
	line "on this sign…"

	para "“This cave is"
	line "scary!”"
	done

UragaChannelEastHiddenNugget:
	dwb EVENT_URAGA_CHANNEL_EAST_HIDDEN_NUGGET, NUGGET

UragaChannelEastHiddenPearl:
	dwb EVENT_URAGA_CHANNEL_EAST_HIDDEN_PEARL, PEARL

UragaChannelEastHiddenBottleCap:
	dwb EVENT_URAGA_CHANNEL_EAST_HIDDEN_BOTTLE_CAP, BOTTLE_CAP

UragaChannelEastHiddenStarPiece:
	dwb EVENT_URAGA_CHANNEL_EAST_HIDDEN_STAR_PIECE, STAR_PIECE

UragaChannelEast_MapEventHeader:
.Warps:
	db 1
	warp_def $b, $2, 1, SCARY_CAVE_1F

.XYTriggers:
	db 0

.Signposts:
	db 6
	signpost 5, 45, SIGNPOST_READ, UragaChannelSign
	signpost 13, 3, SIGNPOST_READ, ScaryCaveEastSign
	signpost 4, 33, SIGNPOST_ITEM, UragaChannelEastHiddenNugget
	signpost 14, 34, SIGNPOST_ITEM, UragaChannelEastHiddenPearl
	signpost 12, 22, SIGNPOST_ITEM, UragaChannelEastHiddenBottleCap
	signpost 11, 9, SIGNPOST_ITEM, UragaChannelEastHiddenStarPiece

.PersonEvents:
	db 5
	person_event SPRITE_SWIMMER_GIRL, 2, 5, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_TRAINER, 1, TrainerSwimmerfWoda, -1
	person_event SPRITE_COOLTRAINER_M, 7, 22, SPRITEMOVEDATA_SPINCLOCKWISE, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_TRAINER, 1, TrainerCooltrainermKieran, -1
	person_event SPRITE_BIKER, 15, 34, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_TRAINER, 1, TrainerBikerTyrone, -1
	person_event SPRITE_BALL_CUT_FRUIT, 2, 9, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_ITEMBALL, 0, UragaChannelEastDiveBall, EVENT_URAGA_CHANNEL_EAST_DIVE_BALL
	person_event SPRITE_BALL_CUT_FRUIT, 8, 20, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_ITEMBALL, 0, UragaChannelEastEviolite, EVENT_URAGA_CHANNEL_EAST_EVIOLITE
