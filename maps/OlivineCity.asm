const_value set 2
	const OLIVINECITY_SAILOR1
	const OLIVINECITY_STANDING_YOUNGSTER
	const OLIVINECITY_SAILOR2
	const OLIVINECITY_OLIVINE_RIVAL
	const OLIVINECITY_SWIMMER_GIRL

OlivineCity_MapScriptHeader:
.MapTriggers:
	db 2

	; triggers
	maptrigger .Trigger0
	maptrigger .Trigger1

.MapCallbacks:
	db 1

	; callbacks
	dbw MAPCALLBACK_NEWMAP, .FlyPoint

.Trigger0:
	end

.Trigger1:
	end

.FlyPoint:
	setflag ENGINE_FLYPOINT_OLIVINE
	return

OlivineCityRivalGymScript:
	spriteface PLAYER, UP
	showemote EMOTE_SHOCK, PLAYER, 15
	special Special_FadeOutMusic
	variablesprite SPRITE_OLIVINE_RIVAL, SPRITE_SILVER
	special RunCallback_04
	playsound SFX_ENTER_DOOR
	appear OLIVINECITY_OLIVINE_RIVAL
	waitsfx
	playsound SFX_TACKLE
	applymovement PLAYER, OlivineCityMovementData_ShovePlayerDown
	applymovement OLIVINECITY_OLIVINE_RIVAL, OlivineCityMovementData_RivalExitsGym
	playmusic MUSIC_RIVAL_ENCOUNTER
	opentext
	writetext OlivineCityRivalGymText
	waitbutton
	closetext
	spriteface PLAYER, RIGHT
	applymovement OLIVINECITY_OLIVINE_RIVAL, OlivineCityMovementData_RivalLeavesGym
	dotrigger $1
	disappear OLIVINECITY_OLIVINE_RIVAL
	special RestartMapMusic
	variablesprite SPRITE_OLIVINE_RIVAL, SPRITE_COWGIRL
	special RunCallback_04
	end

OlivineCityRivalLighthouseScript:
	spriteface PLAYER, UP
	showemote EMOTE_SHOCK, PLAYER, 15
	special Special_FadeOutMusic
	moveperson OLIVINECITY_OLIVINE_RIVAL, $21, $13
	variablesprite SPRITE_OLIVINE_RIVAL, SPRITE_SILVER
	special RunCallback_04
	playsound SFX_ENTER_DOOR
	appear OLIVINECITY_OLIVINE_RIVAL
	waitsfx
	applymovement OLIVINECITY_OLIVINE_RIVAL, OlivineCityMovementData_RivalExitsLighthouse
	playmusic MUSIC_RIVAL_ENCOUNTER
	opentext
	writetext OlivineCityRivalLighthouseText
	waitbutton
	closetext
	playsound SFX_TACKLE
	applymovement PLAYER, OlivineCityMovementData_ShovePlayerDown2
	spriteface PLAYER, LEFT
	applymovement OLIVINECITY_OLIVINE_RIVAL, OlivineCityMovementData_RivalLeavesLighthouse
	dotrigger $1
	disappear OLIVINECITY_OLIVINE_RIVAL
	special RestartMapMusic
	variablesprite SPRITE_OLIVINE_RIVAL, SPRITE_COWGIRL
	special RunCallback_04
	end

SailorScript_0x1a88a3:
	jumptextfaceplayer UnknownText_0x1a8a58

StandingYoungsterScript_0x1a88a6:
	faceplayer
	opentext
	random $2
	if_equal $0, UnknownScript_0x1a88b4
	writetext UnknownText_0x1a8b04
	waitbutton
	closetext
	end

UnknownScript_0x1a88b4:
	writetext UnknownText_0x1a8b41
	waitbutton
	closetext
	end

SailorScript_0x1a88ba:
	jumptextfaceplayer UnknownText_0x1a8b71

TrainerSwimmerfJill:
	trainer EVENT_BEAT_SWIMMERF_JILL, SWIMMERF, JILL, SwimmerfJillSeenText, SwimmerfJillBeatenText, 0, SwimmerfJillScript

SwimmerfJillScript:
	end_if_just_battled
	opentext
	writetext SwimmerfJillAfterText
	waitbutton
	closetext
	end

OlivineCitySign:
	jumptext OlivineCitySignText

OlivineCityPortSign:
	jumptext OlivineCityPortSignText

OlivineGymSign:
	jumptext OlivineGymSignText

OlivineLighthouseSign:
	jumptext OlivineLighthouseSignText

OlivineCityBattleTowerSign:
	jumptext OlivineCityBattleTowerSignText

OlivineCityPokeCenterSign:
	jumpstd pokecentersign

OlivineCityMartSign:
	jumpstd martsign

OlivineCityMovementData_ShovePlayerDown:
	turn_head_up
	fix_facing
	step_down
	remove_fixed_facing
	step_end

OlivineCityMovementData_RivalExitsLighthouse:
	step_down
	step_down
OlivineCityMovementData_RivalExitsGym:
	step_down
	step_end

OlivineCityMovementData_RivalLeavesGym:
	step_right
	step_right
	step_right
	step_right
	step_right
	step_right
	step_right
	step_right
	step_end

OlivineCityMovementData_ShovePlayerDown2:
	turn_head_up
	fix_facing
	jump_step_down
	remove_fixed_facing
	step_end

OlivineCityMovementData_RivalLeavesLighthouse:
	step_down
	step_down
	step_left
	step_left
	step_left
	step_left
	step_left
	step_end

OlivineCityRivalGymText:
	text "…"

	para "You again?"

	para "There's no need to"
	line "panic. I don't"

	para "bother with wimps"
	line "like you."

	para "Speaking of weak-"
	line "lings, the city's"

	para "Gym Leader isn't"
	line "here."

	para "Supposedly taking"
	line "care of a sick"

	para "#mon at the"
	line "Lighthouse."

	para "Humph! Boo-hoo!"
	line "Just let sick"
	cont "#mon go!"

	para "A #mon that"
	line "can't battle is"
	cont "worthless!"

	para "Why don't you go"
	line "train at the"
	cont "Lighthouse?"

	para "Who knows. It may"
	line "make you a bit"
	cont "less weak!"
	done

OlivineCityRivalLighthouseText:
	text "…"

	para "You again?"

	para "There's no need to"
	line "panic. I don't"

	para "bother with wimps"
	line "like you."

	para "Speaking of weak-"
	line "lings, the city's"

	para "Gym Leader is"
	line "taking care of a"

	para "sick #mon in"
	line "the Lighthouse."

	para "Humph! Boo-hoo!"
	line "Just let sick"
	cont "#mon go!"

	para "A #mon that"
	line "can't battle is"
	cont "worthless!"

	para "Why don't you go"
	line "train inside?"

	para "Who knows. It may"
	line "make you a bit"
	cont "less weak!"
	done

UnknownText_0x1a8a58:
	text "Dark roads are"
	line "dangerous at"
	cont "night."

	para "But in the pitch-"
	line "black of night,"

	para "the sea is even"
	line "more treacherous!"

	para "Without the beacon"
	line "of the Lighthouse"

	para "to guide it, no"
	line "ship can sail."
	done

UnknownText_0x1a8b04:
	text "That thing you"
	line "have--it's a #-"
	cont "gear, right? Wow,"
	cont "that's cool."
	done

UnknownText_0x1a8b41:
	text "Wow, you have a"
	line "#dex!"

	para "That is just so"
	line "awesome."
	done

UnknownText_0x1a8b71:
	text "The sea is sweet!"

	para "Sunsets on the sea"
	line "are marvelous!"

	para "Sing with me! "
	line "Yo-ho! Blow the"
	cont "man down!…"
	done

SwimmerfJillSeenText:
	text "Don't I look good"
	line "in this bikini?"
	done

SwimmerfJillBeatenText:
	text "Hmph!"
	done

SwimmerfJillAfterText:
	text "I'll forget my"
	line "loss with a swim."
	done

OlivineCitySignText:
	text "Olivine City"

	para "The Port Closest"
	line "to Foreign Lands"
	done

OlivineCityPortSignText:
	text "Olivine Port"
	line "Fast Ship Pier"
	done

OlivineGymSignText:
	text "Olivine City"
	line "#mon Gym"
	cont "Leader: Jasmine"

	para "The Steel-Clad"
	line "Defense Girl"
	done

OlivineLighthouseSignText:
	text "Olivine Lighthouse"
	line "Also known as the"
	cont "Glitter Lighthouse"
	done

OlivineCityBattleTowerSignText:
	text "Battle Tower Ahead"
	line "Opening Now!"
	done

UnknownText_0x1a8cba:
	text "Battle Tower Ahead"
	done

OlivineCity_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 11
	warp_def $11, $d, 1, OLIVINE_POKECENTER_1F
	warp_def $7, $a, 1, OLIVINE_GYM
	warp_def $7, $19, 1, OLIVINE_TIMS_HOUSE
	warp_def $0, $0, 1, OLIVINE_POKECENTER_1F ; OLIVINE_HOUSE_BETA
	warp_def $7, $1d, 1, OLIVINE_PUNISHMENT_SPEECH_HOUSE
	warp_def $b, $d, 1, OLIVINE_GOOD_ROD_HOUSE
	warp_def $11, $7, 1, OLIVINE_CAFE
	warp_def $f, $13, 2, OLIVINE_MART
	warp_def $13, $21, 1, OLIVINE_LIGHTHOUSE_1F
	warp_def $1f, $13, 1, OLIVINE_PORT_PASSAGE
	warp_def $1f, $14, 2, OLIVINE_PORT_PASSAGE

.XYTriggers:
	db 2
	xy_trigger 0, $8, $a, $0, OlivineCityRivalGymScript, $0, $0
	xy_trigger 0, $17, $21, $0, OlivineCityRivalLighthouseScript, $0, $0

.Signposts:
	db 7
	signpost 7, 17, SIGNPOST_READ, OlivineCitySign
	signpost 22, 20, SIGNPOST_READ, OlivineCityPortSign
	signpost 7, 7, SIGNPOST_READ, OlivineGymSign
	signpost 20, 34, SIGNPOST_READ, OlivineLighthouseSign
	signpost 21, 1, SIGNPOST_READ, OlivineCityBattleTowerSign
	signpost 17, 14, SIGNPOST_READ, OlivineCityPokeCenterSign
	signpost 15, 20, SIGNPOST_READ, OlivineCityMartSign

.PersonEvents:
	db 5
	person_event SPRITE_SAILOR, 22, 26, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 2, -1, -1, 0, PERSONTYPE_SCRIPT, 0, SailorScript_0x1a88a3, -1
	person_event SPRITE_STANDING_YOUNGSTER, 9, 20, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, StandingYoungsterScript_0x1a88a6, -1
	person_event SPRITE_SAILOR, 21, 15, SPRITEMOVEDATA_STANDING_DOWN, 1, 1, -1, -1, 0, PERSONTYPE_SCRIPT, 0, SailorScript_0x1a88ba, -1
	person_event SPRITE_OLIVINE_RIVAL, 7, 10, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, ObjectEvent, EVENT_RIVAL_OLIVINE_CITY
	person_event SPRITE_SWIMMER_GIRL, 23, 43, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_TRAINER, 3, TrainerSwimmerfJill, -1
