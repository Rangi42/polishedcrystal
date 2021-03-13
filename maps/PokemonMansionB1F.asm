PokemonMansionB1F_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event 25, 24, POKEMON_MANSION_1F, 3

	def_coord_events

	def_bg_events
	bg_event 26,  4, BGEVENT_ITEM + MAX_ELIXIR, EVENT_POKEMON_MANSION_B1F_HIDDEN_MAX_ELIXIR
	bg_event  8, 13, BGEVENT_READ, PokemonMansionB1FHiddenRareCandy
	bg_event 20, 27, BGEVENT_READ, PokemonMansionB1FHiddenBerserkGene
	bg_event 22,  5, BGEVENT_JUMPTEXT, PokemonMansion1FMewtwoStatueText
	bg_event  9, 13, BGEVENT_JUMPTEXT, PokemonMansion1FFlowerPotText
	bg_event  4, 17, BGEVENT_JUMPTEXT, PokemonMansion1FFlowerPotText
	bg_event  5, 17, BGEVENT_JUMPTEXT, PokemonMansion1FFlowerPotText
	bg_event  8, 17, BGEVENT_JUMPTEXT, PokemonMansion1FFlowerPotText
	bg_event  9, 17, BGEVENT_JUMPTEXT, PokemonMansion1FFlowerPotText

	def_object_events
	object_event 18,  5, SPRITE_SCIENTIST, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 4, GenericTrainerScientistBraydon, -1
	object_event 18, 22, SPRITE_BOOK_PAPER_POKEDEX, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, OBJECTTYPE_COMMAND, jumptext, PokemonMansionDiaryText, -1
	itemball_event 13,  5, CARBOS, 1, EVENT_POKEMON_MANSION_B1F_CARBOS
	itemball_event  7,  6, CALCIUM, 1, EVENT_POKEMON_MANSION_B1F_CALCIUM
	itemball_event 16, 27, HP_UP, 1, EVENT_POKEMON_MANSION_B1F_HP_UP
	keyitemball_event  4, 23, OLD_SEA_MAP, EVENT_POKEMON_MANSION_B1F_OLD_SEA_MAP

GenericTrainerScientistBraydon:
	generictrainer SCIENTIST, BRAYDON, EVENT_BEAT_SCIENTIST_BRAYDON, ScientistBraydonSeenText, ScientistBraydonBeatenText

	text "This place was"
	line "once the site of"

	para "serious #mon"
	line "research."
	done

PokemonMansionB1FHiddenRareCandy:
	checkevent EVENT_POKEMON_MANSION_B1F_HIDDEN_RARE_CANDY
	iftrue_jumptext PokemonMansion1FFlowerPotText
	giveitem RARE_CANDY
	iffalse .PackFull
	opentext
	getitemname RARE_CANDY, $0
	writetext PokemonMansion1FFoundItemText
	playsound SFX_ITEM
	waitsfx
	itemnotify
	closetext
	setevent EVENT_POKEMON_MANSION_B1F_HIDDEN_RARE_CANDY
	end

.PackFull:
	opentext
	getitemname RARE_CANDY, $0
	writetext PokemonMansion1FFoundItemText
	promptbutton
	jumpopenedtext PokemonMansion1FNoRoomForItemText

PokemonMansionB1FHiddenBerserkGene:
	checkevent EVENT_POKEMON_MANSION_B1F_HIDDEN_BERSERK_GENE
	iftrue_jumptext PokemonMansion1FMewtwoStatueText
	giveitem BERSERK_GENE
	iffalse .PackFull
	opentext
	getitemname BERSERK_GENE, $0
	writetext PokemonMansion1FFoundItemText
	playsound SFX_ITEM
	waitsfx
	itemnotify
	closetext
	setevent EVENT_POKEMON_MANSION_B1F_HIDDEN_BERSERK_GENE
	end

.PackFull:
	opentext
	getitemname BERSERK_GENE, $0
	writetext PokemonMansion1FFoundItemText
	promptbutton
	jumpopenedtext PokemonMansion1FNoRoomForItemText

ScientistBraydonSeenText:
	text "I miss the old"
	line "Cinnabar Lab…"
	done

ScientistBraydonBeatenText:
	text "Whew!"
	line "Overwhelming!"
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
