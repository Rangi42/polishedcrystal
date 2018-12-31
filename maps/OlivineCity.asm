OlivineCity_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 1
	dbw MAPCALLBACK_NEWMAP, OlivineCityFlyPoint

OlivineCity_MapEventHeader:

.Warps: db 12
	warp_def 17, 13, 1, OLIVINE_POKECENTER_1F
	warp_def 7, 10, 1, OLIVINE_GYM
	warp_def 7, 25, 1, OLIVINE_TIMS_HOUSE
	warp_def 7, 29, 1, OLIVINE_PUNISHMENT_SPEECH_HOUSE
	warp_def 11, 13, 1, OLIVINE_GOOD_ROD_HOUSE
	warp_def 17, 7, 1, OLIVINE_CAFE
	warp_def 13, 19, 2, OLIVINE_MART
	warp_def 19, 33, 1, OLIVINE_LIGHTHOUSE_1F
	warp_def 31, 19, 1, OLIVINE_PORT_PASSAGE
	warp_def 31, 20, 2, OLIVINE_PORT_PASSAGE
	warp_def 30, 57, 5, ROUTE_35_NATIONAL_PARK_GATE
	warp_def 31, 57, 6, ROUTE_35_NATIONAL_PARK_GATE

.XYTriggers: db 2
	xy_trigger 0, 8, 10, OlivineCityRivalGymScript
	xy_trigger 0, 23, 33, OlivineCityRivalLighthouseScript

.Signposts: db 9
	signpost 7, 17, SIGNPOST_JUMPTEXT, OlivineCitySignText
	signpost 22, 20, SIGNPOST_JUMPTEXT, OlivineCityPortSignText
	signpost 7, 7, SIGNPOST_JUMPTEXT, OlivineGymSignText
	signpost 20, 34, SIGNPOST_JUMPTEXT, OlivineLighthouseSignText
	signpost 21, 1, SIGNPOST_JUMPTEXT, OlivineCityBattleTowerSignText
	signpost 27, 50, SIGNPOST_JUMPTEXT, OlivineCityPokeathlonDomeSignText
	signpost 14, 36, SIGNPOST_ITEM + RARE_CANDY, EVENT_OLIVINE_CITY_HIDDEN_RARE_CANDY
	signpost 14, 47, SIGNPOST_ITEM + BIG_PEARL, EVENT_OLIVINE_CITY_HIDDEN_BIG_PEARL
	signpost 29, 49, SIGNPOST_ITEM + SOFT_SAND, EVENT_OLIVINE_CITY_HIDDEN_SOFT_SAND

.PersonEvents: db 15
	person_event SPRITE_OLIVINE_RIVAL, 7, 10, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, ObjectEvent, EVENT_RIVAL_OLIVINE_CITY
	person_event SPRITE_YOUNGSTER, 8, 20, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, OlivineCityYoungster1Script, -1
	person_event SPRITE_SAILOR, 22, 26, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 2, -1, -1, 0, PERSONTYPE_COMMAND, jumptextfaceplayer, OlivineCitySailor1Text, -1
	person_event SPRITE_SAILOR, 21, 15, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, (1 << DAY) | (1 << NITE), 0, PERSONTYPE_COMMAND, jumptextfaceplayer, OlivineCitySailor2Text, -1
	person_event SPRITE_FISHER, 17, 31, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, (1 << MORN) | (1 << DAY), (1 << 3) | PAL_OW_GREEN, PERSONTYPE_COMMAND, jumptextfaceplayer, OlivineCityFisherText, -1
	person_event SPRITE_SAILOR, 17, 31, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, (1 << NITE), 0, PERSONTYPE_COMMAND, jumptextfaceplayer, OlivineCitySailor3Text, -1
	person_event SPRITE_POKEFAN_F, 26, 18, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, (1 << DAY), 0, PERSONTYPE_COMMAND, jumptextfaceplayer, OlivineCityPokefanFText, -1
	person_event SPRITE_POKEFAN_M, 27, 21, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, (1 << MORN) | (1 << NITE), 0, PERSONTYPE_COMMAND, jumptextfaceplayer, OlivineCityPokefanMText, -1
	person_event SPRITE_SAILOR, 16, 23, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, PERSONTYPE_COMMAND, jumptextfaceplayer, OlivineCitySailor4Text, -1
	person_event SPRITE_SAILOR, 17, 23, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, PERSONTYPE_COMMAND, jumptextfaceplayer, OlivineCitySailor5Text, -1
	person_event SPRITE_LASS, 11, 26, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, (1 << MORN), (1 << 3) | PAL_OW_RED, PERSONTYPE_COMMAND, jumptextfaceplayer, OlivineCityLass1Text, -1
	person_event SPRITE_YOUNGSTER, 11, 28, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, (1 << DAY) | (1 << NITE), (1 << 3) | PAL_OW_GREEN, PERSONTYPE_COMMAND, jumptextfaceplayer, OlivineCityYoungster2Text, -1
	person_event SPRITE_LASS, 21, 8, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, (1 << MORN) | (1 << DAY), (1 << 3) | PAL_OW_BROWN, PERSONTYPE_COMMAND, jumptextfaceplayer, OlivineCityLass2Text, -1
	smashrock_event 23, 52
	smashrock_event 26, 55

const_value set 1
	const OLIVINECITY_OLIVINE_RIVAL

OlivineCityFlyPoint:
	setflag ENGINE_FLYPOINT_OLIVINE
	return

OlivineCityRivalGymScript:
	spriteface PLAYER, UP
	showemote EMOTE_SHOCK, PLAYER, 15
	special Special_FadeOutMusic
	variablesprite SPRITE_OLIVINE_RIVAL, SPRITE_SILVER
	special MapCallbackSprites_LoadUsedSpritesGFX
	playsound SFX_ENTER_DOOR
	appear OLIVINECITY_OLIVINE_RIVAL
	waitsfx
	playsound SFX_TACKLE
	applymovement PLAYER, OlivineCityMovementData_ShovePlayerDown
	applyonemovement OLIVINECITY_OLIVINE_RIVAL, step_down
	playmusic MUSIC_RIVAL_ENCOUNTER
	showtext OlivineCityRivalGymText
	spriteface PLAYER, RIGHT
	applymovement OLIVINECITY_OLIVINE_RIVAL, OlivineCityMovementData_RivalLeavesGym
	dotrigger $1
	disappear OLIVINECITY_OLIVINE_RIVAL
	special RestartMapMusic
	variablesprite SPRITE_OLIVINE_RIVAL, SPRITE_COWGIRL
	special MapCallbackSprites_LoadUsedSpritesGFX
	end

OlivineCityRivalLighthouseScript:
	spriteface PLAYER, UP
	showemote EMOTE_SHOCK, PLAYER, 15
	special Special_FadeOutMusic
	moveperson OLIVINECITY_OLIVINE_RIVAL, 33, 19
	variablesprite SPRITE_OLIVINE_RIVAL, SPRITE_SILVER
	special MapCallbackSprites_LoadUsedSpritesGFX
	playsound SFX_ENTER_DOOR
	appear OLIVINECITY_OLIVINE_RIVAL
	waitsfx
	applymovement OLIVINECITY_OLIVINE_RIVAL, OlivineCityMovementData_RivalExitsLighthouse
	playmusic MUSIC_RIVAL_ENCOUNTER
	showtext OlivineCityRivalLighthouseText
	playsound SFX_TACKLE
	applymovement PLAYER, OlivineCityMovementData_ShovePlayerDown2
	spriteface PLAYER, LEFT
	applymovement OLIVINECITY_OLIVINE_RIVAL, OlivineCityMovementData_RivalLeavesLighthouse
	dotrigger $1
	disappear OLIVINECITY_OLIVINE_RIVAL
	special RestartMapMusic
	variablesprite SPRITE_OLIVINE_RIVAL, SPRITE_COWGIRL
	special MapCallbackSprites_LoadUsedSpritesGFX
	end

OlivineCityYoungster1Script:
	faceplayer
	opentext
	random $2
	if_equal $0, UnknownScript_0x1a88b4
	jumpopenedtext UnknownText_0x1a8b04

UnknownScript_0x1a88b4:
	jumpopenedtext UnknownText_0x1a8b41

OlivineCityMovementData_ShovePlayerDown:
	turn_head_up
	fix_facing
	step_down
	remove_fixed_facing
	step_end

OlivineCityMovementData_RivalExitsLighthouse:
	step_down
	step_down
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

OlivineCitySailor1Text:
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

OlivineCitySailor2Text:
	text "The sea is sweet!"

	para "Sunsets on the sea"
	line "are marvelous!"

	para "Sing with me!"
	line "♪ Yo-ho! Blow the"
	cont "man down!… ♪"
	done

OlivineCityFisherText:
	text "You remind me of"
	line "a kid who used to"
	cont "live here."

	para "The family moved"
	line "away when their"

	para "father became a"
	line "Gym Leader in"
	cont "another region."
	done

OlivineCitySailor3Text:
	text "To see the Light-"
	line "house illuminate"

	para "the sea at night--"
	line "it's beautiful!"
	done

OlivineCityPokefanFText:
	text "Have you been to"
	line "Olivine Café?"

	para "The food is"
	line "delicious."
	done

OlivineCityPokefanMText:
	text "Most trainers who"
	line "visit Olivine head"

	para "straight for the"
	line "Battle Tower."

	para "Only the best can"
	line "compete there."
	done

OlivineCitySailor4Text:
	text "♪ A home like"
	line "O-li-vine,"

	para "I'm so hap-py I"
	line "can call you mine,"

	para "Next to the deep"
	line "blue brine,"

	para "Ci-ty oh so"
	line "di-vine,"

	para "Shine bright my"
	line "O-li-vine!… ♪"
	done

OlivineCitySailor5Text:
	text "Us sailors love"
	line "a sing-song."
	cont "Join in!"

	para "♪ From off the"
	line "plank,"

	para "'twas then he"
	line "thank,"

	para "oh fiddle-dee"
	line "fiddle-dee dee… ♪"
	done

OlivineCityLass1Text:
	text "The sailors here"
	line "may seem like a"

	para "handful, but"
	line "they're harmless."
	done

OlivineCityYoungster2Text:
	text "Why do sailors"
	line "like singing so"
	cont "much?"

	para "I don't get it."
	done

OlivineCityLass2Text:
	text "Jasmine, our Gym"
	line "Leader, is a shy"

	para "girl. She's no"
	line "pushover, mind!"
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

OlivineCityPokeathlonDomeSignText:
	text "The #athlon"
	line "Project Has"
	cont "Started!"
	done
