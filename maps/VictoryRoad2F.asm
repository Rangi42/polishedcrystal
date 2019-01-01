VictoryRoad2F_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 5 ; warp events
	warp_event 25,  9, ROUTE_23, 4
	warp_event  3, 11, VICTORY_ROAD_1F, 2
	warp_event  3,  4, VICTORY_ROAD_3F, 1
	warp_event 15,  7, VICTORY_ROAD_3F, 2
	warp_event 19,  9, VICTORY_ROAD_3F, 3

	db 1 ; coord events
	coord_event 25,  9, 0, UnknownScript_0x74492

	db 1 ; bg events
	bg_event  5,  5, SIGNPOST_ITEM + MAX_POTION, EVENT_VICTORY_ROAD_2F_HIDDEN_MAX_POTION

	db 6 ; object events
	object_event 20,  9, SPRITE_SILVER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, ObjectEvent, EVENT_RIVAL_VICTORY_ROAD
	object_event 11, 11, SPRITE_VETERAN_F, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_BROWN, PERSONTYPE_GENERICTRAINER, 4, GenericTrainerVeteranfJoanne, -1
	object_event  5,  3, SPRITE_VETERAN_F, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, PAL_NPC_BROWN, PERSONTYPE_GENERICTRAINER, 2, GenericTrainerVeteranfSylvie, -1
	tmhmball_event  8,  4, TM_EARTHQUAKE, EVENT_VICTORY_ROAD_2F_TM_EARTHQUAKE
	itemball_event 20,  5, FULL_RESTORE, 1, EVENT_VICTORY_ROAD_2F_FULL_RESTORE
	itemball_event  9, 14, HP_UP, 1, EVENT_VICTORY_ROAD_2F_HP_UP

	const_def 1 ; object constants
	const VICTORYROAD2F_SILVER

UnknownScript_0x74492:
	showemote EMOTE_SHOCK, PLAYER, 15
	turnobject PLAYER, LEFT
	special Special_FadeOutMusic
	pause 15
	appear VICTORYROAD2F_SILVER
	applymovement VICTORYROAD2F_SILVER, MovementData_0x74539
	playmusic MUSIC_RIVAL_ENCOUNTER
	showtext UnknownText_0x7455f
	setevent EVENT_RIVAL_VICTORY_ROAD
	checkevent EVENT_GOT_TOTODILE_FROM_ELM
	iftrue UnknownScript_0x744ff
	checkevent EVENT_GOT_CHIKORITA_FROM_ELM
	iftrue UnknownScript_0x7450f
	winlosstext UnknownText_0x7463d, UnknownText_0x747aa
	setlasttalked VICTORYROAD2F_SILVER
	loadtrainer RIVAL1, RIVAL1_15
	startbattle
	dontrestartmapmusic
	reloadmapafterbattle
	jump UnknownScript_0x7451f

UnknownScript_0x744ff:
	winlosstext UnknownText_0x7463d, UnknownText_0x747aa
	setlasttalked VICTORYROAD2F_SILVER
	loadtrainer RIVAL1, RIVAL1_13
	startbattle
	dontrestartmapmusic
	reloadmapafterbattle
	jump UnknownScript_0x7451f

UnknownScript_0x7450f:
	winlosstext UnknownText_0x7463d, UnknownText_0x747aa
	setlasttalked VICTORYROAD2F_SILVER
	loadtrainer RIVAL1, RIVAL1_14
	startbattle
	dontrestartmapmusic
	reloadmapafterbattle
	jump UnknownScript_0x7451f

UnknownScript_0x7451f:
	special DeleteSavedMusic
	playmusic MUSIC_RIVAL_AFTER
	showtext UnknownText_0x746ce
	applymovement VICTORYROAD2F_SILVER, MovementData_0x7454c
	disappear VICTORYROAD2F_SILVER
	setscene $1
	playmapmusic
	end

GenericTrainerVeteranfJoanne:
	generictrainer VETERANF, JOANNE, EVENT_BEAT_VETERANF_JOANNE, VeteranfJoanneSeenText, VeteranfJoanneBeatenText

	text "You earned the"
	line "right to be on"
	cont "Victory Road!"
	done

GenericTrainerVeteranfSylvie:
	generictrainer VETERANF, SYLVIE, EVENT_BEAT_VETERANF_SYLVIE, VeteranfSylvieSeenText, VeteranfSylvieBeatenText

	text "Did somebody"
	line "capture Moltres"
	cont "already?"
	done

MovementData_0x74539:
	step_right
	step_right
	step_right
	step_right
	step_end

MovementData_0x7454c:
	step_left
	step_left
	step_left
	step_left
	step_end

UnknownText_0x7455f:
	text "Hold it."

	para "…Are you going to"
	line "take the #mon"
	cont "League challenge?"

	para "…Don't make me"
	line "laugh."

	para "You're so much"
	line "weaker than I am."

	para "I'm not like I was"
	line "before."

	para "I now have the"
	line "best and strongest"

	para "#mon with me."
	line "I'm invincible!"

	para "<PLAYER>!"
	line "I challenge you!"
	done

UnknownText_0x7463d:
	text "…I couldn't win…"

	para "I gave it every-"
	line "thing I had…"

	para "What you possess,"
	line "and what I lack…"

	para "I'm beginning to"
	line "understand what"

	para "that dragon master"
	line "said to me…"
	done

UnknownText_0x746ce:
	text "…I haven't given up"
	line "on becoming the"
	cont "greatest trainer…"

	para "I'm going to find"
	line "out why I can't"

	para "win and become"
	line "stronger…"

	para "When I do, I will"
	line "challenge you."

	para "And I'll beat you"
	line "down with all my"
	cont "power."

	para "…Humph! You keep"
	line "at it until then."
	done

UnknownText_0x747aa:
	text "…Humph!"

	para "When it comes down"
	line "to it, nothing can"
	cont "beat power."

	para "I don't need any-"
	line "thing else."
	done

VeteranfJoanneSeenText:
	text "Victory Road is"
	line "the final test"
	cont "for trainers!"
	done

VeteranfJoanneBeatenText:
	text "Aiyah!"
	done

VeteranfSylvieSeenText:
	text "There's supposed"
	line "to be a Moltres"
	cont "roosting here."

	para "I'm going to catch"
	line "it!"
	done

VeteranfSylvieBeatenText:
	text "I'd have won if"
	line "I had a legendary"
	cont "#mon…"
	done

