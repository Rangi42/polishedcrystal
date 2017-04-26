const_value set 2
	const OLIVINECITY_OLIVINE_RIVAL
	const OLIVINECITY_YOUNGSTER1
	const OLIVINECITY_SAILOR1
	const OLIVINECITY_SAILOR2
	const OLIVINECITY_FISHER
	const OLIVINECITY_SAILOR3
	const OLIVINECITY_POKEFAN_F
	const OLIVINECITY_POKEFAN_M
	const OLIVINECITY_SAILOR4
	const OLIVINECITY_SAILOR5
	const OLIVINECITY_LASS1
	const OLIVINECITY_YOUNGSTER2
	const OLIVINECITY_LASS2
	const OLIVINECITY_SAILOR6
	const OLIVINECITY_LASS3

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

TrainerSailorHarvey:
	trainer EVENT_BEAT_SAILOR_HARVEY, SAILOR, HARVEY, SailorHarveySeenText, SailorHarveyBeatenText, 0, TrainerSailorHarveyScript

TrainerSailorHarveyScript:
	end_if_just_battled
	opentext
	writetext SailorHarveyAfterText
	waitbutton
	closetext
	end

TrainerLassRose:
	trainer EVENT_BEAT_LASS_ROSE, LASS, ROSE, LassRoseSeenText, LassRoseBeatenText, 0, TrainerLassRoseScript

TrainerLassRoseScript:
	end_if_just_battled
	opentext
	writetext LassRoseAfterText
	waitbutton
	closetext
	end

OlivineCityYoungster1Script:
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

OlivineCitySailor1Script:
	jumptextfaceplayer OlivineCitySailor1Text

OlivineCitySailor2Script:
	jumptextfaceplayer OlivineCitySailor2Text

OlivineCityFisherScript:
	jumptextfaceplayer OlivineCityFisherText

OlivineCitySailor3Script:
	jumptextfaceplayer OlivineCitySailor3Text

OlivineCityPokefanFScript:
	jumptextfaceplayer OlivineCityPokefanFText

OlivineCityPokefanMScript:
	jumptextfaceplayer OlivineCityPokefanMText

OlivineCitySailor4Script:
	jumptextfaceplayer OlivineCitySailor4Text

OlivineCitySailor5Script:
	jumptextfaceplayer OlivineCitySailor5Text

OlivineCityLass1Script:
	jumptextfaceplayer OlivineCityLass1Text

OlivineCityYoungster2Script:
	jumptextfaceplayer OlivineCityYoungster2Text

OlivineCityLass2Script:
	jumptextfaceplayer OlivineCityLass2Text

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

OlivineCityHiddenRareCandy:
	dwb EVENT_OLIVINE_CITY_HIDDEN_RARE_CANDY, RARE_CANDY

OlivineCityHiddenBigPearl:
	dwb EVENT_OLIVINE_CITY_HIDDEN_BIG_PEARL, BIG_PEARL

OlivineCityHiddenSoftSand:
	dwb EVENT_OLIVINE_CITY_HIDDEN_SOFT_SAND, SOFT_SAND

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

SailorHarveySeenText:
	text "Hah! Your #mon"
	line "sure look like"
	cont "lightweights!"
	done

SailorHarveyBeatenText:
	text "What power!"
	line "How would you like"

	para "to sail the seas"
	line "with me?"
	done

SailorHarveyAfterText:
	text "On the sea, the"
	line "only thing you can"

	para "count on is your"
	line "own good self!"

	para "I'm so proud of my"
	line "buff bod!"
	done

LassRoseSeenText:
	text "I collected these"
	line "#mon from all"
	cont "around the world!"
	done

LassRoseBeatenText:
	text "Oh no!"
	line "I went around the"
	cont "world for these!"
	done

LassRoseAfterText:
	text "You hurt my poor"
	line "worldly #mon!"

	para "I demand that you"
	line "heal them at a"
	cont "#mon Center!"
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

UnknownText_0x1a8cba:
	text "Battle Tower Ahead"
	done

OlivineCity_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 10
	warp_def $11, $d, 1, OLIVINE_POKECENTER_1F
	warp_def $7, $a, 1, OLIVINE_GYM
	warp_def $7, $19, 1, OLIVINE_TIMS_HOUSE
	warp_def $7, $1d, 1, OLIVINE_PUNISHMENT_SPEECH_HOUSE
	warp_def $b, $d, 1, OLIVINE_GOOD_ROD_HOUSE
	warp_def $11, $7, 1, OLIVINE_CAFE
	warp_def $d, $13, 2, OLIVINE_MART
	warp_def $13, $21, 1, OLIVINE_LIGHTHOUSE_1F
	warp_def $1f, $13, 1, OLIVINE_PORT_PASSAGE
	warp_def $1f, $14, 2, OLIVINE_PORT_PASSAGE

.XYTriggers:
	db 2
	xy_trigger 0, $8, $a, $0, OlivineCityRivalGymScript, $0, $0
	xy_trigger 0, $17, $21, $0, OlivineCityRivalLighthouseScript, $0, $0

.Signposts:
	db 8
	signpost 7, 17, SIGNPOST_READ, OlivineCitySign
	signpost 22, 20, SIGNPOST_READ, OlivineCityPortSign
	signpost 7, 7, SIGNPOST_READ, OlivineGymSign
	signpost 20, 34, SIGNPOST_READ, OlivineLighthouseSign
	signpost 21, 1, SIGNPOST_READ, OlivineCityBattleTowerSign
	signpost 14, 36, SIGNPOST_ITEM, OlivineCityHiddenRareCandy
	signpost 14, 47, SIGNPOST_ITEM, OlivineCityHiddenBigPearl
	signpost 29, 49, SIGNPOST_ITEM, OlivineCityHiddenSoftSand

.PersonEvents:
	db 15
	person_event SPRITE_OLIVINE_RIVAL, 7, 10, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, ObjectEvent, EVENT_RIVAL_OLIVINE_CITY
	person_event SPRITE_YOUNGSTER, 8, 20, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, OlivineCityYoungster1Script, -1
	person_event SPRITE_SAILOR, 22, 26, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 2, -1, -1, 0, PERSONTYPE_SCRIPT, 0, OlivineCitySailor1Script, -1
	person_event SPRITE_SAILOR, 21, 15, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, (1 << DAY) | (1 << NITE), 0, PERSONTYPE_SCRIPT, 0, OlivineCitySailor2Script, -1
	person_event SPRITE_FISHER, 17, 31, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, (1 << MORN) | (1 << DAY), (1 << 3) | PAL_OW_GREEN, PERSONTYPE_SCRIPT, 0, OlivineCityFisherScript, -1
	person_event SPRITE_SAILOR, 17, 31, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, (1 << NITE), 0, PERSONTYPE_SCRIPT, 0, OlivineCitySailor3Script, -1
	person_event SPRITE_POKEFAN_F, 26, 18, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, (1 << DAY), 0, PERSONTYPE_SCRIPT, 0, OlivineCityPokefanFScript, -1
	person_event SPRITE_POKEFAN_M, 27, 21, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, (1 << MORN) | (1 << NITE), 0, PERSONTYPE_SCRIPT, 0, OlivineCityPokefanMScript, -1
	person_event SPRITE_SAILOR, 16, 23, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, OlivineCitySailor4Script, -1
	person_event SPRITE_SAILOR, 17, 23, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, OlivineCitySailor5Script, -1
	person_event SPRITE_LASS, 11, 26, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, (1 << MORN), (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, OlivineCityLass1Script, -1
	person_event SPRITE_YOUNGSTER, 11, 28, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, (1 << DAY) | (1 << NITE), (1 << 3) | PAL_OW_GREEN, PERSONTYPE_SCRIPT, 0, OlivineCityYoungster2Script, -1
	person_event SPRITE_LASS, 21, 8, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, (1 << MORN) | (1 << DAY), (1 << 3) | PAL_OW_BROWN, PERSONTYPE_SCRIPT, 0, OlivineCityLass2Script, -1
	person_event SPRITE_SAILOR, 19, 49, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, PERSONTYPE_TRAINER, 3, TrainerSailorHarvey, -1
	person_event SPRITE_LASS, 26, 52, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_TRAINER, 3, TrainerLassRose, -1
