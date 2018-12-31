VictoryRoad2F_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

VictoryRoad2F_MapEventHeader:

.Warps: db 5
	warp_def 9, 25, 4, ROUTE_23
	warp_def 11, 3, 2, VICTORY_ROAD_1F
	warp_def 4, 3, 1, VICTORY_ROAD_3F
	warp_def 7, 15, 2, VICTORY_ROAD_3F
	warp_def 9, 19, 3, VICTORY_ROAD_3F

.XYTriggers: db 1
	xy_trigger 0, 9, 25, UnknownScript_0x74492

.Signposts: db 1
	signpost 5, 5, SIGNPOST_ITEM + MAX_POTION, EVENT_VICTORY_ROAD_2F_HIDDEN_MAX_POTION

.PersonEvents: db 6
	person_event SPRITE_SILVER, 9, 20, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, ObjectEvent, EVENT_RIVAL_VICTORY_ROAD
	person_event SPRITE_VETERAN_F, 11, 11, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_TRAINER, 4, TrainerVeteranfJoanne, -1
	person_event SPRITE_VETERAN_F, 3, 5, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_TRAINER, 2, TrainerVeteranfSylvie, -1
	tmhmball_event 4, 8, TM_EARTHQUAKE, EVENT_VICTORY_ROAD_2F_TM_EARTHQUAKE
	itemball_event 5, 20, FULL_RESTORE, 1, EVENT_VICTORY_ROAD_2F_FULL_RESTORE
	itemball_event 14, 9, HP_UP, 1, EVENT_VICTORY_ROAD_2F_HP_UP

const_value set 1
	const VICTORYROAD2F_SILVER

UnknownScript_0x74492:
	showemote EMOTE_SHOCK, PLAYER, 15
	spriteface PLAYER, LEFT
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
	dotrigger $1
	playmapmusic
	end

TrainerVeteranfJoanne:
	trainer EVENT_BEAT_VETERANF_JOANNE, VETERANF, JOANNE, VeteranfJoanneSeenText, VeteranfJoanneBeatenText, 0, VeteranfJoanneScript

VeteranfJoanneScript:
	end_if_just_battled
	jumptextfaceplayer VeteranfJoanneAfterText

TrainerVeteranfSylvie:
	trainer EVENT_BEAT_VETERANF_SYLVIE, VETERANF, SYLVIE, VeteranfSylvieSeenText, VeteranfSylvieBeatenText, 0, VeteranfSylvieScript

VeteranfSylvieScript:
	end_if_just_battled
	jumptextfaceplayer VeteranfSylvieAfterText

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
