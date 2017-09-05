PokemonMansion1F_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

PokemonMansion1F_MapEventHeader:

.Warps: db 3
	warp_def 27, 5, 3, CINNABAR_ISLAND
	warp_def 27, 6, 3, CINNABAR_ISLAND
	warp_def 23, 21, 1, POKEMON_MANSION_B1F

.XYTriggers: db 0

.Signposts: db 8
	signpost 12, 21, SIGNPOST_ITEM + FULL_RESTORE, EVENT_POKEMON_MANSION_1F_HIDDEN_FULL_RESTORE
	signpost 23, 14, SIGNPOST_READ, PokemonMansion1FHiddenPPUp
	signpost 5, 2, SIGNPOST_JUMPTEXT, PokemonMansion1FMewtwoStatueText
	signpost 23, 15, SIGNPOST_JUMPTEXT, PokemonMansion1FFlowerPotText
	signpost 23, 18, SIGNPOST_JUMPTEXT, PokemonMansion1FFlowerPotText
	signpost 23, 19, SIGNPOST_JUMPTEXT, PokemonMansion1FFlowerPotText
	signpost 19, 18, SIGNPOST_JUMPTEXT, PokemonMansion1FFlowerPotText
	signpost 19, 19, SIGNPOST_JUMPTEXT, PokemonMansion1FFlowerPotText

.PersonEvents: db 6
	person_event SPRITE_PHARMACIST, 10, 9, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_PURPLE, PERSONTYPE_TRAINER, 3, TrainerBurglarPete, -1
	person_event SPRITE_PHARMACIST, 14, 27, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_PURPLE, PERSONTYPE_TRAINER, 3, TrainerBurglarLouis, -1
	itemball_event 4, 6, MOON_STONE, 1, EVENT_POKEMON_MANSION_1F_MOON_STONE
	itemball_event 3, 14, ESCAPE_ROPE, 1, EVENT_POKEMON_MANSION_1F_ESCAPE_ROPE
	itemball_event 22, 17, PROTEIN, 1, EVENT_POKEMON_MANSION_1F_PROTEIN
	itemball_event 22, 27, IRON, 1, EVENT_POKEMON_MANSION_1F_IRON

TrainerBurglarPete:
	trainer EVENT_BEAT_BURGLAR_PETE, BURGLAR, PETE, BurglarPeteSeenText, BurglarPeteBeatenText, 0, BurglarPeteScript

BurglarPeteScript:
	end_if_just_battled
	jumptextfaceplayer BurglarPeteAfterText

TrainerBurglarLouis:
	trainer EVENT_BEAT_BURGLAR_LOUIS, BURGLAR, LOUIS, BurglarLouisSeenText, BurglarLouisBeatenText, 0, BurglarLouisScript

BurglarLouisScript:
	end_if_just_battled
	jumptextfaceplayer BurglarLouisAfterText

PokemonMansion1FHiddenPPUp:
	checkevent EVENT_POKEMON_MANSION_1F_HIDDEN_PP_UP
	iftrue_jumptext PokemonMansion1FFlowerPotText
	giveitem PP_UP
	iffalse .PackFull
	opentext
	itemtotext PP_UP, $0
	writetext PokemonMansion1FFoundItemText
	playsound SFX_ITEM
	waitsfx
	itemnotify
	closetext
	setevent EVENT_POKEMON_MANSION_1F_HIDDEN_PP_UP
	end

.PackFull:
	opentext
	itemtotext PP_UP, $0
	writetext PokemonMansion1FFoundItemText
	buttonsound
	jumpopenedtext PokemonMansion1FNoRoomForItemText

BurglarPeteSeenText:
	text "Who are you? There"
	line "shouldn't be"
	cont "anyone here."
	done

BurglarPeteBeatenText:
	text "Ouch!"
	done

BurglarPeteAfterText:
	text "Some valuable"
	line "items probably"

	para "survived the"
	line "eruption."
	done

BurglarLouisSeenText:
	text "This place is"
	line "creepy!"
	done

BurglarLouisBeatenText:
	text "Ayah!"
	done

BurglarLouisAfterText:
	text "I just want to"
	line "find some loot"
	cont "and get out."
	done

PokemonMansion1FFoundItemText:
	text "<PLAYER> found"
	line "@"
	text_from_ram StringBuffer3
	text "!"
	done

PokemonMansion1FNoRoomForItemText:
	text "But <PLAYER> can't"
	line "hold another item…"
	done

PokemonMansion1FMewtwoStatueText:
	text "A #mon statue…"

	para "It looks very"
	line "threatening."
	done

PokemonMansion1FFlowerPotText:
	text "It's filled with"
	line "soil and ashes…"
	done
