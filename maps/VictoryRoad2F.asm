const_value set 2
	const VICTORYROAD2F_SILVER
	const VICTORYROAD2F_VETERAN_F1
	const VICTORYROAD2F_VETERAN_F2
	const VICTORYROAD2F_POKE_BALL1
	const VICTORYROAD2F_POKE_BALL2
	const VICTORYROAD2F_POKE_BALL3

VictoryRoad2F_MapScriptHeader:
.MapTriggers:
	db 2

	; triggers
	maptrigger .Trigger0
	maptrigger .Trigger1

.MapCallbacks:
	db 0

.Trigger0:
	end

.Trigger1:
	end

UnknownScript_0x74492:
	spriteface PLAYER, LEFT
	showemote EMOTE_SHOCK, PLAYER, 15
	special Special_FadeOutMusic
	pause 15
	appear VICTORYROAD2F_SILVER
	applymovement VICTORYROAD2F_SILVER, MovementData_0x74539
	playmusic MUSIC_RIVAL_ENCOUNTER
	opentext
	writetext UnknownText_0x7455f
	waitbutton
	closetext
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
	opentext
	writetext UnknownText_0x746ce
	waitbutton
	closetext
	applymovement VICTORYROAD2F_SILVER, MovementData_0x7454c
	disappear VICTORYROAD2F_SILVER
	dotrigger $1
	playmapmusic
	end

TrainerVeteranfJoanne:
	trainer EVENT_BEAT_VETERANF_JOANNE, VETERANF, JOANNE, VeteranfJoanneSeenText, VeteranfJoanneBeatenText, 0, VeteranfJoanneScript

VeteranfJoanneScript:
	end_if_just_battled
	opentext
	writetext VeteranfJoanneAfterText
	waitbutton
	closetext
	end

TrainerVeteranfSylvie:
	trainer EVENT_BEAT_VETERANF_SYLVIE, VETERANF, SYLVIE, VeteranfSylvieSeenText, VeteranfSylvieBeatenText, 0, VeteranfSylvieScript

VeteranfSylvieScript:
	end_if_just_battled
	opentext
	writetext VeteranfSylvieAfterText
	waitbutton
	closetext
	end

VictoryRoad2FTMEarthquake:
	tmhmball TM_EARTHQUAKE

VictoryRoad2FFullRestore:
	itemball FULL_RESTORE

VictoryRoad2FHPUp:
	itemball HP_UP

VictoryRoad2FHiddenMaxPotion:
	dwb EVENT_VICTORY_ROAD_2F_HIDDEN_MAX_POTION, MAX_POTION

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

VeteranfJoanneAfterText:
	text "You earned the"
	line "right to be on"
	cont "Victory Road!"
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

VeteranfSylvieAfterText:
	text "Did somebody"
	line "capture Moltres"
	cont "already?"
	done

VictoryRoad2F_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 5
	warp_def $9, $19, 4, ROUTE_23
	warp_def $b, $3, 2, VICTORY_ROAD_1F
	warp_def $4, $3, 1, VICTORY_ROAD_3F
	warp_def $7, $f, 2, VICTORY_ROAD_3F
	warp_def $9, $13, 3, VICTORY_ROAD_3F

.XYTriggers:
	db 1
	xy_trigger 0, $9, $19, $0, UnknownScript_0x74492, $0, $0

.Signposts:
	db 1
	signpost 5, 5, SIGNPOST_ITEM, VictoryRoad2FHiddenMaxPotion

.PersonEvents:
	db 6
	person_event SPRITE_SILVER, 9, 20, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, ObjectEvent, EVENT_RIVAL_VICTORY_ROAD
	person_event SPRITE_VETERAN_F, 11, 11, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_TRAINER, 4, TrainerVeteranfJoanne, -1
	person_event SPRITE_VETERAN_F, 3, 5, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_TRAINER, 2, TrainerVeteranfSylvie, -1
	person_event SPRITE_BALL_CUT_FRUIT, 4, 8, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_TMHMBALL, 0, VictoryRoad2FTMEarthquake, EVENT_VICTORY_ROAD_2F_TM_EARTHQUAKE
	person_event SPRITE_BALL_CUT_FRUIT, 5, 20, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_ITEMBALL, 0, VictoryRoad2FFullRestore, EVENT_VICTORY_ROAD_2F_FULL_RESTORE
	person_event SPRITE_BALL_CUT_FRUIT, 14, 9, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_ITEMBALL, 0, VictoryRoad2FHPUp, EVENT_VICTORY_ROAD_2F_HP_UP
