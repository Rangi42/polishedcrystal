OlsteetonPokeCenter_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  5,  7, OLSTEETON, 4
	warp_event  6,  7, OLSTEETON, 4

	def_coord_events

	def_bg_events
	bg_event 10,  1, BGEVENT_READ, PokemonJournalRustyScript
	bg_event 10,  5, BGEVENT_JUMPSTD, difficultbookshelf
	bg_event 11,  5, BGEVENT_JUMPSTD, difficultbookshelf

	def_object_events
	pc_nurse_event  5, 1
	object_event  0,  6, SPRITE_PHARMACIST, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, PokeCenterPharmacist, -1
	pokemon_event  2,  3, SMEARGLE, SPRITEMOVEDATA_POKEMON, -1, PAL_NPC_BROWN, OlsteetonSmeargleText, -1
	pokemon_event  8,  1, SKARMORY, SPRITEMOVEDATA_POKEMON, -1, PAL_NPC_GRAY, OlsteetonSkarmoryText, -1
	object_event 11,  6, SPRITE_PI, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, OBJECTTYPE_COMMAND, jumptextfaceplayer, OlsteetonPokeCenterBusinessText, -1
	object_event  3,  3, SPRITE_ARTIST, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, OBJECTTYPE_COMMAND, jumptextfaceplayer, OlsteetonPokeCenterArtistText, -1
	object_event  9,  1, SPRITE_ENGINEER, , 0, 0, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, OlsteetonPokeCenterEngineerText, -1
	

PokeCenterPharmacist:
	scall .PokeMart
	turnobject LAST_TALKED, UP
	end

PokemonJournalRustyScript:
	setflag ENGINE_READ_RUSTY_JOURNAL
	jumpthistext

	text "#mon Journal"

	para "Special Feature:"
	line "Leader Rusty!"

	para "After the steel"
	line "mill closed, "

	para "Rusty insp-"
	line "ired his"

	para "former crew"
	line "to become his"
	cont "steely squad!"
	done

OlsteetonSmeargleText:
	text "Smeargle: Smeer!"
	done

OlsteetonPokeCenterBusinessText:
	text "…Yeah, and the"
	line "Gym isn't"

	para "even open yet."
	line "Such a waste."

	para "…Yes? I'm on the"
	line "phone. Go away!"
	done

OlsteetonPokeCenterEngineerText:
	text "Hey, kid!"
	line "check out the"

	para "journal article."
	line "about my boss!"
	cont "He's the best!"
	done


OlsteetonPokeCenterArtistText:
	text "Most #mon stop"
	line "to watch if"

	para "they come across"
	line "a Smeargle painting."

	para "The Smeargle"
	line "like it because"

	para "it gets a wide"
	line "variety of #mon"
	cont "to sketch."
	done

	OlsteetonSkarmoryText:
	text "Skarmory: Scree!"
	done
