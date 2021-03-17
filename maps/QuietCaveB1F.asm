QuietCaveB1F_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  5, 25, QUIET_CAVE_1F, 2
	warp_event 29, 23, QUIET_CAVE_1F, 3
	warp_event 19, 11, QUIET_CAVE_1F, 4
	warp_event  3, 15, QUIET_CAVE_1F, 5
	warp_event 31, 15, QUIET_CAVE_1F, 6
	warp_event 21,  3, QUIET_CAVE_B2F, 1
	warp_event 17, 25, QUIET_CAVE_B2F, 2
	warp_event 23, 33, QUIET_CAVE_B2F, 3
	warp_event 32,  2, QUIET_CAVE_B2F, 4

	def_coord_events

	def_bg_events
	bg_event 26, 33, BGEVENT_ITEM + HYPER_POTION, EVENT_QUIET_CAVE_B1F_HIDDEN_HYPER_POTION

	def_object_events
	object_event 25,  4, SPRITE_BATTLE_GIRL, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 1, GenericTrainerBattleGirlKagami, -1
	object_event 21, 17, SPRITE_POKEMANIAC, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 4, GenericTrainerPokemaniacAidan, -1
	object_event 33, 30, SPRITE_HIKER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 4, GenericTrainerHikerSteve, -1
	object_event  4,  7, SPRITE_PSYCHIC, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 2, GenericTrainerPsychicVirgil, -1
	itemball_event  8,  3, BIG_PEARL, 1, EVENT_QUIET_CAVE_B1F_BIG_PEARL
	itemball_event 14, 13, ELIXIR, 1, EVENT_QUIET_CAVE_B1F_ELIXIR

GenericTrainerBattleGirlKagami:
	generictrainer BATTLE_GIRL, KAGAMI, EVENT_BEAT_BATTLE_GIRL_KAGAMI, BattleGirlKagamiSeenText, BattleGirlKagamiBeatenText

	text "I come here to"
	line "train in peace"
	cont "and solitude."
	done

GenericTrainerPokemaniacAidan:
	generictrainer POKEMANIAC, AIDAN, EVENT_BEAT_POKEMANIAC_AIDAN, PokemaniacAidanSeenText, PokemaniacAidanBeatenText

	text "Sometimes a"
	line "#mon in a"

	para "certain area will"
	line "know a rare move."
	done

GenericTrainerHikerSteve:
	generictrainer HIKER, STEVE, EVENT_BEAT_HIKER_STEVE, HikerSteveSeenText, HikerSteveBeatenText

	text "Spelunking is also"
	line "called caving."

	para "It means exploring"
	line "caves!"
	done

GenericTrainerPsychicVirgil:
	generictrainer PSYCHIC_T, VIRGIL, EVENT_BEAT_PSYCHIC_VIRGIL, PsychicVirgilSeenText, PsychicVirgilBeatenText

	text "The silence helps"
	line "focus my ESP."
	done

BattleGirlKagamiSeenText:
	text "Don't disturb my"
	line "training!"
	done

BattleGirlKagamiBeatenText:
	text "Not good enough…"
	done

PokemaniacAidanSeenText:
	text "My #mon!"

	para "Let me show"
	line "you them!"
	done

PokemaniacAidanBeatenText:
	text "My #mon…"
	done

HikerSteveSeenText:
	text "They call me a"
	line "Hiker, but right"

	para "now I'm a spelunk-"
	line "er!"
	done

HikerSteveBeatenText:
	text "And now I'm a"
	line "loser…"
	done

PsychicVirgilSeenText:
	text "Shh! Be quiet!"
	done

PsychicVirgilBeatenText:
	text "Why must battling"
	line "be so loud?"
	done

