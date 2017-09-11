QuietCaveB1F_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

QuietCaveB1F_MapEventHeader:

.Warps: db 9
	warp_def 25, 5, 2, QUIET_CAVE_1F
	warp_def 23, 29, 3, QUIET_CAVE_1F
	warp_def 11, 19, 4, QUIET_CAVE_1F
	warp_def 15, 3, 5, QUIET_CAVE_1F
	warp_def 15, 31, 6, QUIET_CAVE_1F
	warp_def 3, 21, 1, QUIET_CAVE_B2F
	warp_def 25, 17, 2, QUIET_CAVE_B2F
	warp_def 33, 23, 3, QUIET_CAVE_B2F
	warp_def 2, 32, 4, QUIET_CAVE_B2F

.XYTriggers: db 0

.Signposts: db 1
	signpost 33, 26, SIGNPOST_ITEM + HYPER_POTION, EVENT_QUIET_CAVE_B1F_HIDDEN_HYPER_POTION

.PersonEvents: db 6
	person_event SPRITE_COOLTRAINER_F, 4, 25, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_TRAINER, 1, TrainerBattleGirlKagami, -1
	person_event SPRITE_SUPER_NERD, 17, 21, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_PURPLE, PERSONTYPE_TRAINER, 4, TrainerPokemaniacAidan, -1
	person_event SPRITE_POKEFAN_M, 30, 33, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_TRAINER, 4, TrainerHikerSteve, -1
	person_event SPRITE_YOUNGSTER, 7, 4, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, (1 << 3) | PAL_OW_PURPLE, PERSONTYPE_TRAINER, 2, TrainerPsychicVirgil, -1
	itemball_event 3, 8, BIG_PEARL, 1, EVENT_QUIET_CAVE_B1F_BIG_PEARL
	itemball_event 13, 14, ELIXER, 1, EVENT_QUIET_CAVE_B1F_ELIXIR

TrainerBattleGirlKagami:
	trainer EVENT_BEAT_BATTLE_GIRL_KAGAMI, BATTLE_GIRL, KAGAMI, BattleGirlKagamiSeenText, BattleGirlKagamiBeatenText, 0, BattleGirlKagamiScript

BattleGirlKagamiScript:
	end_if_just_battled
	jumptextfaceplayer BattleGirlKagamiAfterText

TrainerPokemaniacAidan:
	trainer EVENT_BEAT_POKEMANIAC_AIDAN, POKEMANIAC, AIDAN, PokemaniacAidanSeenText, PokemaniacAidanBeatenText, 0, PokemaniacAidanScript

PokemaniacAidanScript:
	end_if_just_battled
	jumptextfaceplayer PokemaniacAidanAfterText

TrainerHikerSteve:
	trainer EVENT_BEAT_HIKER_STEVE, HIKER, STEVE, HikerSteveSeenText, HikerSteveBeatenText, 0, HikerSteveScript

HikerSteveScript:
	end_if_just_battled
	jumptextfaceplayer HikerSteveAfterText

TrainerPsychicVirgil:
	trainer EVENT_BEAT_PSYCHIC_VIRGIL, PSYCHIC_T, VIRGIL, PsychicVirgilSeenText, PsychicVirgilBeatenText, 0, PsychicVirgilScript

PsychicVirgilScript:
	end_if_just_battled
	jumptextfaceplayer PsychicVirgilAfterText

BattleGirlKagamiSeenText:
	text "Don't disturb my"
	line "training!"
	done

BattleGirlKagamiBeatenText:
	text "Not good enough…"
	done

BattleGirlKagamiAfterText:
	text "I come here to"
	line "train in peace"
	cont "and solitude."
	done

PokemaniacAidanSeenText:
	text "My #mon!"

	para "Let me show"
	line "you them!"
	done

PokemaniacAidanBeatenText:
	text "My #mon…"
	done

PokemaniacAidanAfterText:
	text "Sometimes a"
	line "#mon in a"

	para "certain area will"
	line "know a rare move."
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

HikerSteveAfterText:
	text "Spelunking is also"
	line "called caving."

	para "It means exploring"
	line "caves!"
	done

PsychicVirgilSeenText:
	text "Shh! Be quiet!"
	done

PsychicVirgilBeatenText:
	text "Why must battling"
	line "be so loud?"
	done

PsychicVirgilAfterText:
	text "The silence helps"
	line "focus my ESP."
	done
