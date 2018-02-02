ShamoutiCoast_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 3 ; warp events
	warp_event 22, 15, FIRE_ISLAND, 1
	warp_event 54, 11, ICE_ISLAND, 1
	warp_event 84, 13, LIGHTNING_ISLAND, 1

	db 0 ; coord events

	db 0 ; bg events

	db 12 ; object events
	object_event  4,  9, SPRITE_ARTIST, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, PERSONTYPE_TRAINER, 3, TrainerArtistRin, -1
	object_event 12,  5, SPRITE_SWIMMER_GIRL, SPRITEMOVEDATA_SPINCOUNTERCLOCKWISE, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_TRAINER, 3, TrainerSwimmerfMarina, -1
	object_event 34,  9, SPRITE_FISHER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_TRAINER, 1, TrainerFisherDallas, -1
	object_event 39, 13, SPRITE_LADY, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_TRAINER, 2, TrainerSightseerfPilar, -1
	object_event 66,  4, SPRITE_SIGHTSEER_M, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_PURPLE, PERSONTYPE_TRAINER, 1, TrainerSightseersCyandvi1, -1
	object_event 67,  4, SPRITE_LADY, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_PURPLE, PERSONTYPE_TRAINER, 1, TrainerSightseersCyandvi2, -1
	object_event 71, 16, SPRITE_SWIMMER_GUY, SPRITEMOVEDATA_SPINCLOCKWISE, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_TRAINER, 3, TrainerSwimmermAshe, -1
	object_event 21, 11, SPRITE_CANDELA, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, ObjectEvent, EVENT_SHAMOUTI_COAST_CANDELA
	object_event 53,  7, SPRITE_BLANCHE, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, ObjectEvent, EVENT_SHAMOUTI_COAST_BLANCHE
	object_event 83,  9, SPRITE_SPARK, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, ObjectEvent, EVENT_SHAMOUTI_COAST_SPARK
	itemball_event  6, 11, STAR_PIECE, 1, EVENT_SHAMOUTI_COAST_STAR_PIECE
	object_event  6, -3, SPRITE_LADY, SPRITEMOVEDATA_STANDING_DOWN, 0, 2, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, ObjectEvent, -1

TrainerArtistRin:
	trainer ARTIST, RIN, EVENT_BEAT_ARTIST_RIN, .SeenText, .BeatenText, 0, .Script

.Script:
	end_if_just_battled
	jumptextfaceplayer .AfterText

.SeenText:
	text "I'm painting the"
	line "three islands!"

	para "Please don't block"
	line "my view!"
	done

.BeatenText:
	text "I can't paint and"
	line "battle at the same"
	cont "time."
	done

.AfterText:
	text "There's a strange"
	line "sense of power"
	cont "from the islands."

	para "I want to capture"
	line "that in my paint-"
	cont "ing."
	done

TrainerSwimmerfMarina:
	trainer SWIMMERF, MARINA, EVENT_BEAT_SWIMMERF_MARINA, .SeenText, .BeatenText, 0, .Script

.Script:
	end_if_just_battled
	jumptextfaceplayer .AfterText

.SeenText:
	text "If you were stran-"
	line "ded on a desert"
	cont "island, what three"

	para "things would you"
	line "bring?"
	done

.BeatenText:
	text "Washed away with-"
	line "out a paddle!"
	done

.AfterText:
	text "If I were stran-"
	line "ded on a desert"
	cont "island, I'd take…"

	para "my #mon, of"
	line "course!"
	done

TrainerFisherDallas:
	trainer FISHER, DALLAS, EVENT_BEAT_FISHER_DALLAS, .SeenText, .BeatenText, 0, .Script

.Script:
	end_if_just_battled
	jumptextfaceplayer .AfterText

.SeenText:
	text "Gah! Not another"
	line "one!"
	done

.BeatenText:
	text "Huh? Oh, not you--"
	line "you're fine."
	done

.AfterText:
	text "No matter where I"
	line "fish, I just keep"

	para "reeling in Bottle"
	line "Caps."

	para "It's driving me"
	line "nuts!"
	done

TrainerSightseerfPilar:
	trainer SIGHTSEERF, PILAR, EVENT_BEAT_SIGHTSEERF_PILAR, .SeenText, .BeatenText, 0, .Script

.Script:
	end_if_just_battled
	jumptextfaceplayer .AfterText

.SeenText:
	text "¡Hola! He venido"
	line "hasta acá desde"
	cont "muy lejos."

	para "¿Que tal si"
	line "combatimos?"
	done

.BeatenText:
	text "Pense que duraría"
	line "más…"
	done

.AfterText:
	text "¡Que fuertes son"
	line "tus #mon!"

	para "Debes de haber"
	line "viajado un montón"

	para "para tener tanta"
	line "experiencia."
	done

TrainerSightseersCyandvi1:
	trainer SIGHTSEERS, CYANDVI1, EVENT_BEAT_SIGHTSEERS_CY_AND_VI, .SeenText, .BeatenText, 0, .Script

.Script:
	end_if_just_battled
	jumptextfaceplayer .AfterText

.SeenText:
	text "Cy: TODO"
	done

.BeatenText:
	text "Cy: TODO"
	done

.AfterText:
	text "Cy: TODO"
	done

TrainerSightseersCyandvi2:
	trainer SIGHTSEERS, CYANDVI2, EVENT_BEAT_SIGHTSEERS_CY_AND_VI, .SeenText, .BeatenText, 0, .Script

.Script:
	end_if_just_battled
	jumptextfaceplayer .AfterText

.SeenText:
	text "Vi: TODO"
	done

.BeatenText:
	text "Vi: TODO"
	done

.AfterText:
	text "Vi: TODO"
	done

TrainerSwimmermAshe:
	trainer SWIMMERM, ASHE, EVENT_BEAT_SWIMMERM_ASHE, .SeenText, .BeatenText, 0, .Script

.Script:
	end_if_just_battled
	jumptextfaceplayer .AfterText

.SeenText:
	text "Swimming? Me?"
	line "Yeah, I dig it."
	done

.BeatenText:
	text "I have that sink-"
	line "ing feeling…"
	done

.AfterText:
	text "I couldn't swim at"
	line "all a while ago."

	para "Now I do it so"
	line "much it's hard to"

	para "remember what I"
	line "did before. Haha!"
	done

