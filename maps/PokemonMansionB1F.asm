PokemonMansionB1F_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

PokemonMansionB1F_MapEventHeader:

.Warps: db 1
	warp_def 24, 25, 3, POKEMON_MANSION_1F

.XYTriggers: db 0

.Signposts: db 9
	signpost 4, 26, SIGNPOST_ITEM + MAX_ELIXER, EVENT_POKEMON_MANSION_B1F_HIDDEN_MAX_ELIXIR
	signpost 13, 8, SIGNPOST_READ, PokemonMansionB1FHiddenRareCandy
	signpost 27, 20, SIGNPOST_READ, PokemonMansionB1FHiddenBerserkGene
	signpost 5, 22, SIGNPOST_JUMPTEXT, PokemonMansion1FMewtwoStatueText
	signpost 13, 9, SIGNPOST_JUMPTEXT, PokemonMansion1FFlowerPotText
	signpost 17, 4, SIGNPOST_JUMPTEXT, PokemonMansion1FFlowerPotText
	signpost 17, 5, SIGNPOST_JUMPTEXT, PokemonMansion1FFlowerPotText
	signpost 17, 8, SIGNPOST_JUMPTEXT, PokemonMansion1FFlowerPotText
	signpost 17, 9, SIGNPOST_JUMPTEXT, PokemonMansion1FFlowerPotText

.PersonEvents: db 6
	person_event SPRITE_SCIENTIST, 5, 18, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_TRAINER, 4, TrainerScientistBraydon, -1
	person_event SPRITE_PAPER, 22, 18, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_SCRIPT, 0, PokemonMansionDiaryScript, -1
	itemball_event 5, 13, CARBOS, 1, EVENT_POKEMON_MANSION_B1F_CARBOS
	itemball_event 6, 7, CALCIUM, 1, EVENT_POKEMON_MANSION_B1F_CALCIUM
	itemball_event 27, 16, HP_UP, 1, EVENT_POKEMON_MANSION_B1F_HP_UP
	itemball_event 23, 4, OLD_SEA_MAP, 1, EVENT_POKEMON_MANSION_B1F_OLD_SEA_MAP

TrainerScientistBraydon:
	trainer EVENT_BEAT_SCIENTIST_BRAYDON, SCIENTIST, BRAYDON, ScientistBraydonSeenText, ScientistBraydonBeatenText, 0, ScientistBraydonScript

ScientistBraydonScript:
	end_if_just_battled
	jumptextfaceplayer ScientistBraydonAfterText

PokemonMansionDiaryScript:
	jumptext PokemonMansionDiaryText

PokemonMansionB1FHiddenRareCandy:
	checkevent EVENT_POKEMON_MANSION_B1F_HIDDEN_RARE_CANDY
	iftrue_jumptext PokemonMansion1FFlowerPotText
	giveitem RARE_CANDY
	iffalse .PackFull
	opentext
	itemtotext RARE_CANDY, $0
	writetext PokemonMansion1FFoundItemText
	playsound SFX_ITEM
	waitsfx
	itemnotify
	closetext
	setevent EVENT_POKEMON_MANSION_B1F_HIDDEN_RARE_CANDY
	end

.PackFull:
	opentext
	itemtotext RARE_CANDY, $0
	writetext PokemonMansion1FFoundItemText
	buttonsound
	jumpopenedtext PokemonMansion1FNoRoomForItemText

PokemonMansionB1FHiddenBerserkGene:
	checkevent EVENT_POKEMON_MANSION_B1F_HIDDEN_BERSERK_GENE
	iftrue_jumptext PokemonMansion1FMewtwoStatueText
	giveitem BERSERK_GENE
	iffalse .PackFull
	opentext
	itemtotext BERSERK_GENE, $0
	writetext PokemonMansion1FFoundItemText
	playsound SFX_ITEM
	waitsfx
	itemnotify
	closetext
	setevent EVENT_POKEMON_MANSION_B1F_HIDDEN_BERSERK_GENE
	end

.PackFull:
	opentext
	itemtotext BERSERK_GENE, $0
	writetext PokemonMansion1FFoundItemText
	buttonsound
	jumpopenedtext PokemonMansion1FNoRoomForItemText

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
