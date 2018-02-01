Route35Coast_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 0 ; warp events

	db 0 ; coord events

	db 1 ; bg events
	bg_event 35, 14, SIGNPOST_ITEM + STAR_PIECE, EVENT_ROUTE_35_COAST_HIDDEN_STAR_PIECE

	db 8 ; object events
	object_event 26, 7, SPRITE_SWIMMER_GUY, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_TRAINER, 5, TrainerSwimmermWalter, -1
	object_event 25, 20, SPRITE_SWIMMER_GIRL, SPRITEMOVEDATA_SPINCOUNTERCLOCKWISE, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_TRAINER, 3, TrainerSwimmerfLisa, -1
	object_event 14, 6, SPRITE_SWIMMER_GIRL, SPRITEMOVEDATA_SPINCLOCKWISE, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_TRAINER, 3, TrainerSwimmerfJill, -1
	object_event 35, 12, SPRITE_YOUNGSTER, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_TRAINER, 1, TrainerBird_keeperBryan, -1
	object_event 39, 16, SPRITE_LASS, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_TRAINER, 1, TrainerSrandjrBeaandmay1, -1
	object_event 39, 17, SPRITE_LASS, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_TRAINER, 1, TrainerSrandjrBeaandmay2, -1
	object_event 17, 11, SPRITE_SAILOR, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, 0, PERSONTYPE_TRAINER, 2, TrainerSailorHarvey, -1
	object_event 38, 6, SPRITE_LASS, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_TRAINER, 3, TrainerLassRose, -1
	itemball_event 37, 5, BIG_PEARL, 1, EVENT_ROUTE_35_COAST_BIG_PEARL

TrainerSwimmermWalter:
	trainer SWIMMERM, WALTER, EVENT_BEAT_SWIMMERM_WALTER, SwimmermWalterSeenText, SwimmermWalterBeatenText, 0, TrainerSwimmermWalterScript

TrainerSwimmermWalterScript:
	end_if_just_battled
	jumptextfaceplayer SwimmermWalterAfterText

TrainerSwimmerfLisa:
	trainer SWIMMERF, LISA, EVENT_BEAT_SWIMMERF_LISA, SwimmerfLisaSeenText, SwimmerfLisaBeatenText, 0, TrainerSwimmerfLisaScript

TrainerSwimmerfLisaScript:
	end_if_just_battled
	jumptextfaceplayer SwimmerfLisaAfterText

TrainerSwimmerfJill:
	trainer SWIMMERF, JILL, EVENT_BEAT_SWIMMERF_JILL, SwimmerfJillSeenText, SwimmerfJillBeatenText, 0, SwimmerfJillScript

SwimmerfJillScript:
	end_if_just_battled
	jumptextfaceplayer SwimmerfJillAfterText

TrainerBird_keeperBryan:
	trainer BIRD_KEEPER, BRYAN, EVENT_BEAT_BIRD_KEEPER_BRYAN, Bird_keeperBryanSeenText, Bird_keeperBryanBeatenText, 0, Bird_keeperBryanScript

Bird_keeperBryanScript:
	end_if_just_battled
	jumptextfaceplayer Bird_keeperBryanAfterText

TrainerSrandjrBeaandmay1:
	trainer SR_AND_JR, BEAANDMAY1, EVENT_BEAT_SR_AND_JR_BEA_AND_MAY, SrandjrBeaandmay1SeenText, SrandjrBeaandmay1BeatenText, 0, TrainerSrandjrBeaandmay1Script

TrainerSrandjrBeaandmay1Script:
	end_if_just_battled
	jumptextfaceplayer SrandjrBeaandmay1AfterText

TrainerSrandjrBeaandmay2:
	trainer SR_AND_JR, BEAANDMAY2, EVENT_BEAT_SR_AND_JR_BEA_AND_MAY, SrandjrBeaandmay2SeenText, SrandjrBeaandmay2BeatenText, 0, TrainerSrandjrBeaandmay2Script

TrainerSrandjrBeaandmay2Script:
	end_if_just_battled
	jumptextfaceplayer SrandjrBeaandmay2AfterText

TrainerSailorHarvey:
	trainer SAILOR, HARVEY, EVENT_BEAT_SAILOR_HARVEY, SailorHarveySeenText, SailorHarveyBeatenText, 0, TrainerSailorHarveyScript

TrainerSailorHarveyScript:
	end_if_just_battled
	jumptextfaceplayer SailorHarveyAfterText

TrainerLassRose:
	trainer LASS, ROSE, EVENT_BEAT_LASS_ROSE, LassRoseSeenText, LassRoseBeatenText, 0, TrainerLassRoseScript

TrainerLassRoseScript:
	end_if_just_battled
	jumptextfaceplayer LassRoseAfterText

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

SwimmerfJillSeenText:
	text "Don't I look good"
	line "in this bikini?"
	done

SwimmerfJillBeatenText:
	text "Hmph!"
	done

SwimmerfJillAfterText:
	text "I'll forget my"
	line "loss with a swim."
	done

Bird_keeperBryanSeenText:
	text "What kinds of"
	line "Balls do you use?"
	done

Bird_keeperBryanBeatenText:
	text "Yikes! Not fast"
	line "enough!"
	done

Bird_keeperBryanAfterText:
	text "Some #mon flee"
	line "right away."

	para "Try catching them"
	line "with Kurt's Fast"
	cont "Ball."

	para "Whenever I find a"
	line "Wht Apricorn, I"
	cont "take it to Kurt."

	para "He turns it into a"
	line "custom Ball."
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

SailorHarveySeenText:
	text "Hah! Your #mon"
	line "sure look like"
	cont "lightweights!"
	done

SailorHarveyBeatenText:
	text "What power!"
	line "How would you like"

	para "to sail the seas"
	line "with me?"
	done

SailorHarveyAfterText:
	text "On the sea, the"
	line "only thing you can"

	para "count on is your"
	line "own good self!"

	para "I'm so proud of my"
	line "buff bod!"
	done

LassRoseSeenText:
	text "I collected these"
	line "#mon from all"
	cont "around the world!"
	done

LassRoseBeatenText:
	text "Oh no!"
	line "I went around the"
	cont "world for these!"
	done

LassRoseAfterText:
	text "You hurt my poor"
	line "worldly #mon!"

	para "I demand that you"
	line "heal them at a"
	cont "#mon Center!"
	done
