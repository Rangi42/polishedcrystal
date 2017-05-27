const_value set 2
	const SHAMOUTICOAST_ARTIST
	const SHAMOUTICOAST_SWIMMER_GIRL
	const SHAMOUTICOAST_FISHER
	const SHAMOUTICOAST_LADY1
	const SHAMOUTICOAST_SIGHTSEER_M
	const SHAMOUTICOAST_LADY2
	const SHAMOUTICOAST_SWIMMER_GUY
	const SHAMOUTICOAST_CANDELA
	const SHAMOUTICOAST_BLANCHE
	const SHAMOUTICOAST_SPARK
	const SHAMOUTICOAST_POKE_BALL

ShamoutiCoast_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

TrainerArtistRin:
	trainer EVENT_BEAT_ARTIST_RIN, ARTIST, RIN, .SeenText, .BeatenText, 0, .Script

.Script:
	end_if_just_battled
	opentext
	writetext .AfterText
	waitbutton
	closetext
	end

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
	trainer EVENT_BEAT_SWIMMERF_MARINA, SWIMMERF, MARINA, .SeenText, .BeatenText, 0, .Script

.Script:
	end_if_just_battled
	opentext
	writetext .AfterText
	waitbutton
	closetext
	end

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
	trainer EVENT_BEAT_FISHER_DALLAS, FISHER, DALLAS, .SeenText, .BeatenText, 0, .Script

.Script:
	end_if_just_battled
	opentext
	writetext .AfterText
	waitbutton
	closetext
	end

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
	trainer EVENT_BEAT_SIGHTSEERF_PILAR, SIGHTSEERF, PILAR, .SeenText, .BeatenText, 0, .Script

.Script:
	end_if_just_battled
	opentext
	writetext .AfterText
	waitbutton
	closetext
	end

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
	trainer EVENT_BEAT_SIGHTSEERS_CY_AND_VI, SIGHTSEERS, CYANDVI1, .SeenText, .BeatenText, 0, .Script

.Script:
	end_if_just_battled
	opentext
	writetext .AfterText
	waitbutton
	closetext
	end

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
	trainer EVENT_BEAT_SIGHTSEERS_CY_AND_VI, SIGHTSEERS, CYANDVI2, .SeenText, .BeatenText, 0, .Script

.Script:
	end_if_just_battled
	opentext
	writetext .AfterText
	waitbutton
	closetext
	end

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
	trainer EVENT_BEAT_SWIMMERM_ASHE, SWIMMERM, ASHE, .SeenText, .BeatenText, 0, .Script

.Script:
	end_if_just_battled
	opentext
	writetext .AfterText
	waitbutton
	closetext
	end

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

ShamoutiCoastStarPiece:
	itemball STAR_PIECE

ShamoutiCoast_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 3
	warp_def $f, $16, 1, FIRE_ISLAND
	warp_def $b, $36, 1, ICE_ISLAND
	warp_def $d, $54, 1, LIGHTNING_ISLAND

.XYTriggers:
	db 0

.Signposts:
	db 0

.PersonEvents:
	db 11
	person_event SPRITE_ARTIST, 9, 4, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, PERSONTYPE_TRAINER, 3, TrainerArtistRin, -1
	person_event SPRITE_SWIMMER_GIRL, 5, 12, SPRITEMOVEDATA_SPINCOUNTERCLOCKWISE, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_TRAINER, 3, TrainerSwimmerfMarina, -1
	person_event SPRITE_FISHER, 9, 34, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_TRAINER, 1, TrainerFisherDallas, -1
	person_event SPRITE_LADY, 13, 39, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_TRAINER, 2, TrainerSightseerfPilar, -1
	person_event SPRITE_SIGHTSEER_M, 4, 66, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_PURPLE, PERSONTYPE_TRAINER, 1, TrainerSightseersCyandvi1, -1
	person_event SPRITE_LADY, 4, 67, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_PURPLE, PERSONTYPE_TRAINER, 1, TrainerSightseersCyandvi2, -1
	person_event SPRITE_SWIMMER_GUY, 16, 71, SPRITEMOVEDATA_SPINCLOCKWISE, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_TRAINER, 3, TrainerSwimmermAshe, -1
	person_event SPRITE_CANDELA, 11, 21, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, ObjectEvent, EVENT_SHAMOUTI_COAST_CANDELA
	person_event SPRITE_BLANCHE, 7, 53, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, ObjectEvent, EVENT_SHAMOUTI_COAST_BLANCHE
	person_event SPRITE_SPARK, 9, 83, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, ObjectEvent, EVENT_SHAMOUTI_COAST_SPARK
	person_event SPRITE_BALL_CUT_FRUIT, 11, 6, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_ITEMBALL, 0, ShamoutiCoastStarPiece, EVENT_SHAMOUTI_COAST_STAR_PIECE
