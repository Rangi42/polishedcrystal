OlsteetonUniWaterLab_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  7,  9, OLSTEETON_UNI_SCIENCE_CENTER, 4
	warp_event  8,  9, OLSTEETON_UNI_SCIENCE_CENTER, 4

	def_coord_events

	def_bg_events

	def_object_events
	object_event  8,  3, SPRITE_CUTE_GIRL, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 2, -1, PAL_NPC_GREEN, OBJECTTYPE_COMMAND, jumptextfaceplayer, OlsteetonUniWaterLabLassText, -1
	object_event  3,  4, SPRITE_SWIMMER_GIRL, SPRITEMOVEDATA_SWIM_UP_DOWN, 1, 0, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, OlsteetonUniWaterLabSwimmer_girlText, -1
	object_event  8,  7, SPRITE_POKEFAN_F, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, PAL_NPC_BLUE, OBJECTTYPE_COMMAND, jumptextfaceplayer, OlsteetonUniWaterLabTeacherText, -1
	itemball_event 15,  1, WATER_STONE, 1, EVENT_CELADON_UNIVERSITY_POOL_WATER_STONE
	pokemon_event  2,  3, CORSOLA, SPRITEMOVEDATA_POKEMON, -1, PAL_NPC_PINK, WaterLabCorsolaText, -1
	pokemon_event 12,  4, POLITOED, SPRITEMOVEDATA_POKEMON, -1, PAL_NPC_GREEN, WaterLabPolitoedText, -1
	pokemon_event 10,  3, SEAKING, SPRITEMOVEDATA_POKEMON, -1, PAL_NPC_ORANGE, WaterLabSeakingText, -1
	pokemon_event  4,  6, CORPHISH, SPRITEMOVEDATA_POKEMON, -1, PAL_NPC_RED, WaterLabCorphishText, -1
	pokemon_event 13,  6, PSYDUCK, SPRITEMOVEDATA_POKEMON, -1, PAL_NPC_YELLOW, WaterLabPsyduckText, -1


	object_const_def

OlsteetonUniWaterLabLassText:
	text "Needs dialogue"
	done

OlsteetonUniWaterLabSwimmer_girlText:
	text "Needs dialogue"
	done

OlsteetonUniWaterLabTeacherText:
	text "Needs dialogue"
	done


WaterLabCorsolaText:
	text "Corsola: Corsc"
	done

WaterLabPolitoedText:
	text "Politoed: poli"
	done

WaterLabSeakingText:
	text "Seaking: Sknng"
	done

WaterLabCorphishText:
	text "Corphish: Kikik"
	done


WaterLabPsyduckText:
	text "Psyduck: Sayeayeay"
	done