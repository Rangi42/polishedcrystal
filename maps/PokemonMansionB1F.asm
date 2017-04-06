const_value set 2
	const POKEMONMANSIONB1F_SCIENTIST
	const POKEMONMANSIONB1F_PAPER
	const POKEMONMANSIONB1F_POKE_BALL1
	const POKEMONMANSIONB1F_POKE_BALL2
	const POKEMONMANSIONB1F_POKE_BALL3
	const POKEMONMANSIONB1F_POKE_BALL4

PokemonMansionB1F_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

TrainerScientistBraydon:
	trainer EVENT_BEAT_SCIENTIST_BRAYDON, SCIENTIST, BRAYDON, ScientistBraydonSeenText, ScientistBraydonBeatenText, 0, ScientistBraydonScript

ScientistBraydonScript:
	end_if_just_battled
	opentext
	writetext ScientistBraydonAfterText
	waitbutton
	closetext
	end

PokemonMansionDiaryScript:
	jumptext PokemonMansionDiaryText

PokemonMansionB1FCarbos:
	itemball CARBOS

PokemonMansionB1FCalcium:
	itemball CALCIUM

PokemonMansionB1FHPUp:
	itemball HP_UP

PokemonMansionB1FOldSeaMap:
	itemball OLD_SEA_MAP

PokemonMansionB1FHiddenMaxElixir:
	dwb EVENT_POKEMON_MANSION_B1F_HIDDEN_MAX_ELIXIR, MAX_ELIXER

PokemonMansionB1FHiddenRareCandy:
	checkevent EVENT_POKEMON_MANSION_B1F_HIDDEN_RARE_CANDY
	iftrue PokemonMansionB1FFlowerPot
	giveitem RARE_CANDY
	iffalse .PackFull
	opentext
	itemtotext RARE_CANDY, $0
	writetext PokemonMansionB1FFoundRareCandyText
	playsound SFX_ITEM
	waitsfx
	itemnotify
	closetext
	setevent EVENT_POKEMON_MANSION_B1F_HIDDEN_RARE_CANDY
	end

.PackFull:
	opentext
	itemtotext RARE_CANDY, $0
	writetext PokemonMansionB1FFoundRareCandyText
	buttonsound
	writetext PokemonMansionB1FNoRoomForRareCandyText
	waitbutton
	closetext
	end

PokemonMansionB1FMewtwoStatue:
	jumptext PokemonMansionB1FMewtwoStatueText

PokemonMansionB1FFlowerPot:
	jumptext PokemonMansionB1FFlowerPotText

ScientistBraydonSeenText:
	text "I miss the old"
	line "Cinnabar Lab…"
	done

ScientistBraydonBeatenText:
	text "Whew!"
	line "Overwhelming!"
	done

ScientistBraydonAfterText:
	text "This place was"
	line "once the site of"

	para "serious #mon"
	line "research."
	done

PokemonMansionDiaryText:
	text "Diary: July 5"

	para "A new #mon was"
	line "discovered deep in"
	cont "the jungle."

	para "Diary: July 10"

	para "We christened the"
	line "newly discovered"
	cont "#mon, Mew."

	para "Diary: Feb. 6"

	para "Mew gave birth."
	line "We named the"
	cont "newborn Mewtwo."

	para "Diary: Sept. 1"

	para "Mewtwo is far"
	line "too powerful."

	para "We have failed to"
	line "curb its vicious"
	cont "tendencies…"
	done

PokemonMansionB1FFoundRareCandyText:
	text "<PLAYER> found"
	line "@"
	text_from_ram StringBuffer3
	text "!"
	done

PokemonMansionB1FNoRoomForRareCandyText:
	text "But <PLAYER> can't"
	line "hold another item…"
	done

PokemonMansionB1FMewtwoStatueText:
	text "A #mon statue…"

	para "It looks very"
	line "threatening."
	done

PokemonMansionB1FFlowerPotText:
	text "It's filled with"
	line "soil and ashes…"
	done

PokemonMansionB1F_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 1
	warp_def $18, $19, 3, POKEMON_MANSION_1F

.XYTriggers:
	db 0

.Signposts:
	db 9
	signpost 4, 26, SIGNPOST_ITEM, PokemonMansionB1FHiddenMaxElixir
	signpost 13, 8, SIGNPOST_READ, PokemonMansionB1FHiddenRareCandy
	signpost 5, 22, SIGNPOST_READ, PokemonMansionB1FMewtwoStatue
	signpost 27, 20, SIGNPOST_READ, PokemonMansionB1FMewtwoStatue
	signpost 13, 9, SIGNPOST_READ, PokemonMansionB1FFlowerPot
	signpost 17, 4, SIGNPOST_READ, PokemonMansionB1FFlowerPot
	signpost 17, 5, SIGNPOST_READ, PokemonMansionB1FFlowerPot
	signpost 17, 8, SIGNPOST_READ, PokemonMansionB1FFlowerPot
	signpost 17, 9, SIGNPOST_READ, PokemonMansionB1FFlowerPot

.PersonEvents:
	db 6
	person_event SPRITE_SCIENTIST, 5, 18, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_TRAINER, 4, TrainerScientistBraydon, -1
	person_event SPRITE_PAPER_UNOWN_W, 22, 18, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_SCRIPT, 0, PokemonMansionDiaryScript, -1
	person_event SPRITE_BALL_CUT_FRUIT, 5, 13, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_ITEMBALL, 0, PokemonMansionB1FCarbos, EVENT_POKEMON_MANSION_B1F_CARBOS
	person_event SPRITE_BALL_CUT_FRUIT, 6, 7, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_ITEMBALL, 0, PokemonMansionB1FCalcium, EVENT_POKEMON_MANSION_B1F_CALCIUM
	person_event SPRITE_BALL_CUT_FRUIT, 27, 16, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_ITEMBALL, 0, PokemonMansionB1FHPUp, EVENT_POKEMON_MANSION_B1F_HP_UP
	person_event SPRITE_BALL_CUT_FRUIT, 23, 4, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_ITEMBALL, 0, PokemonMansionB1FOldSeaMap, EVENT_POKEMON_MANSION_B1F_OLD_SEA_MAP
