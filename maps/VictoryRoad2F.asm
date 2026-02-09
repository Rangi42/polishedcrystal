VictoryRoad2F_MapScriptHeader:
	def_scene_scripts
	scene_const SCENE_VICTORYROAD2F_RIVAL_BATTLE
	scene_const SCENE_VICTORYROAD2F_NOOP

	def_callbacks

	def_warp_events
	warp_event 25,  9, ROUTE_23_NORTH, 2
	warp_event  3, 11, VICTORY_ROAD_1F, 2
	warp_event  3,  4, VICTORY_ROAD_3F, 1
	warp_event 15,  7, VICTORY_ROAD_3F, 2
	warp_event 19,  9, VICTORY_ROAD_3F, 3

	def_coord_events
	coord_event 25,  9, SCENE_VICTORYROAD2F_RIVAL_BATTLE, VictoryRoadRivalLeft

	def_bg_events
	bg_event  5,  5, BGEVENT_ITEM + MAX_POTION, EVENT_VICTORY_ROAD_2F_HIDDEN_MAX_POTION

	def_object_events
	object_event 20,  9, SPRITE_RIVAL, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, 0, OBJECTTYPE_SCRIPT, 0, ObjectEvent, EVENT_RIVAL_VICTORY_ROAD
	object_event 11, 11, SPRITE_VETERAN_F, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 4, GenericTrainerVeteranfJoanne, -1
	object_event  5,  3, SPRITE_VETERAN_F, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 2, GenericTrainerVeteranfJonet, -1
	tmhmball_event  8,  4, TM_EARTHQUAKE, EVENT_VICTORY_ROAD_2F_TM_EARTHQUAKE
	itemball_event 20,  5, FULL_RESTORE, 1, EVENT_VICTORY_ROAD_2F_FULL_RESTORE
	itemball_event  9, 14, HP_UP, 1, EVENT_VICTORY_ROAD_2F_HP_UP

	object_const_def
	const VICTORYROAD2F_RIVAL

VictoryRoadRivalLeft:
	showemote EMOTE_SHOCK, PLAYER, 15
	turnobject PLAYER, LEFT
	special Special_FadeOutMusic
	pause 15
	appear VICTORYROAD2F_RIVAL
	applymovement VICTORYROAD2F_RIVAL, VictoryRoadRivalBattleApproachMovement1
	playmusic MUSIC_RIVAL_ENCOUNTER
	showtext VictoryRoadRivalBeforeText
	setevent EVENT_RIVAL_VICTORY_ROAD
	checkevent EVENT_GOT_TOTODILE_FROM_ELM
	iftruefwd .GotTotodile
	checkevent EVENT_GOT_CHIKORITA_FROM_ELM
	iftruefwd .GotChikorita
	winlosstext VictoryRoadRivalDefeatText, VictoryRoadRivalVictoryText
	setlasttalked VICTORYROAD2F_RIVAL
	loadtrainer RIVAL1, RIVAL1_15
	startbattle
	dontrestartmapmusic
	reloadmapafterbattle
	sjumpfwd .AfterBattle

.GotTotodile:
	winlosstext VictoryRoadRivalDefeatText, VictoryRoadRivalVictoryText
	setlasttalked VICTORYROAD2F_RIVAL
	loadtrainer RIVAL1, RIVAL1_13
	startbattle
	dontrestartmapmusic
	reloadmapafterbattle
	sjumpfwd .AfterBattle

.GotChikorita:
	winlosstext VictoryRoadRivalDefeatText, VictoryRoadRivalVictoryText
	setlasttalked VICTORYROAD2F_RIVAL
	loadtrainer RIVAL1, RIVAL1_14
	startbattle
	dontrestartmapmusic
	reloadmapafterbattle
	; fallthrough

.AfterBattle:
	special DeleteSavedMusic
	playmusic MUSIC_RIVAL_AFTER
	showtext VictoryRoadRivalAfterText
	applymovement VICTORYROAD2F_RIVAL, VictoryRoadRivalBattleExitMovement1
	disappear VICTORYROAD2F_RIVAL
	setscene SCENE_VICTORYROAD2F_NOOP
	playmapmusic
	end

GenericTrainerVeteranfJoanne:
	generictrainer VETERANF, JOANNE, EVENT_BEAT_VETERANF_JOANNE, VeteranfJoanneSeenText, VeteranfJoanneBeatenText

	text "You earned the"
	line "right to be on"
	cont "Victory Road!"
	done

GenericTrainerVeteranfJonet:
	generictrainer VETERANF, JONET, EVENT_BEAT_VETERANF_JONET, VeteranfJonetSeenText, VeteranfJonetBeatenText

	text "Did somebody"
	line "capture Moltres"
	cont "already?"
	done

VictoryRoadRivalBattleApproachMovement1:
	step_right
	step_right
	step_right
	step_right
	step_end

VictoryRoadRivalBattleExitMovement1:
	step_left
	step_left
	step_left
	step_left
	step_end

VictoryRoadRivalBeforeText:
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

VictoryRoadRivalDefeatText:
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

VictoryRoadRivalAfterText:
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

VictoryRoadRivalVictoryText:
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

VeteranfJonetSeenText:
	text "There's supposed"
	line "to be a Moltres"
	cont "roosting here."

	para "I'm going to catch"
	line "it!"
	done

VeteranfJonetBeatenText:
	text "I'd have won if"
	line "I had a legendary"
	cont "#mon…"
	done

