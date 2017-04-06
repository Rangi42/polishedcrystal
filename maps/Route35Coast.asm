const_value set 2
	const ROUTE35COAST_SWIMMER_GUY
	const ROUTE35COAST_SWIMMER_GIRL
	const ROUTE35COAST_LASS1
	const ROUTE35COAST_LASS2
	const ROUTE35COAST_POKE_BALL

Route35Coast_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

TrainerSwimmermWalter:
	trainer EVENT_BEAT_SWIMMERM_WALTER, SWIMMERM, WALTER, SwimmermWalterSeenText, SwimmermWalterBeatenText, 0, TrainerSwimmermWalterScript

TrainerSwimmermWalterScript:
	end_if_just_battled
	opentext
	writetext SwimmermWalterAfterText
	waitbutton
	closetext
	end

TrainerSwimmerfLisa:
	trainer EVENT_BEAT_SWIMMERF_LISA, SWIMMERF, LISA, SwimmerfLisaSeenText, SwimmerfLisaBeatenText, 0, TrainerSwimmerfLisaScript

TrainerSwimmerfLisaScript:
	end_if_just_battled
	opentext
	writetext SwimmerfLisaAfterText
	waitbutton
	closetext
	end

TrainerSrandjrBeaandmay1:
	trainer EVENT_BEAT_SR_AND_JR_BEA_AND_MAY, SR_AND_JR, BEAANDMAY1, SrandjrBeaandmay1SeenText, SrandjrBeaandmay1BeatenText, 0, TrainerSrandjrBeaandmay1Script

TrainerSrandjrBeaandmay1Script:
	end_if_just_battled
	opentext
	writetext SrandjrBeaandmay1AfterText
	waitbutton
	closetext
	end

TrainerSrandjrBeaandmay2:
	trainer EVENT_BEAT_SR_AND_JR_BEA_AND_MAY, SR_AND_JR, BEAANDMAY2, SrandjrBeaandmay2SeenText, SrandjrBeaandmay2BeatenText, 0, TrainerSrandjrBeaandmay2Script

TrainerSrandjrBeaandmay2Script:
	end_if_just_battled
	opentext
	writetext SrandjrBeaandmay2AfterText
	waitbutton
	closetext
	end

Route35CoastBigPearl:
	itemball BIG_PEARL

SwimmermWalterSeenText:
	text "I forgot to wear"
	line "sunscreen, so I'm"

	para "hiding by these"
	line "shady rocks."
	done

SwimmermWalterBeatenText:
	text "Ouch!"
	done

SwimmermWalterAfterText:
	text "The sun reflects"
	line "off the water"

	para "and it burned me"
	line "anyway!"
	done

SwimmerfLisaSeenText:
	text "The fishermen"
	line "yelled at me for"
	cont "bugging them…"
	done

SwimmerfLisaBeatenText:
	text "I only wanted"
	line "to battle…"
	done

SwimmerfLisaAfterText:
	text "There's enough"
	line "room in the sea"

	para "for fishing and"
	line "battling."
	done

SrandjrBeaandmay1SeenText:
	text "Bea: I like strong"
	line "#mon better"

	para "than cute"
	line "#mon."

	para "But together, we"
	line "have cute and"
	cont "strong #mon!"
	done

SrandjrBeaandmay1BeatenText:
	text "Bea: Strength and"
	line "cuteness weren't"
	cont "enough!"
	done

SrandjrBeaandmay1AfterText:
	text "Bea: I'll teach"
	line "May how to become"
	cont "stronger."
	done

SrandjrBeaandmay2SeenText:
	text "May: I like cute"
	line "#mon better"

	para "than strong"
	line "#mon."

	para "But together, we"
	line "have strong and"
	cont "cute #mon!"
	done

SrandjrBeaandmay2BeatenText:
	text "May: Cuteness and"
	line "strength weren't"
	cont "enough!"
	done

SrandjrBeaandmay2AfterText:
	text "May: I'll ask Bea"
	line "how to become"
	cont "stronger."
	done

Route35Coast_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 0

.XYTriggers:
	db 0

.Signposts:
	db 0

.PersonEvents:
	db 5
	person_event SPRITE_SWIMMER_GUY, 7, 26, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_TRAINER, 4, TrainerSwimmermWalter, -1
	person_event SPRITE_SWIMMER_GIRL, 17, 11, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_TRAINER, 4, TrainerSwimmerfLisa, -1
	person_event SPRITE_LASS, 13, 40, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_TRAINER, 1, TrainerSrandjrBeaandmay1, -1
	person_event SPRITE_LASS, 14, 40, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_TRAINER, 1, TrainerSrandjrBeaandmay2, -1
	person_event SPRITE_BALL_CUT_FRUIT, 5, 37, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_ITEMBALL, 0, Route35CoastBigPearl, EVENT_ROUTE_35_COAST_BIG_PEARL
