CianwoodCity_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 1
	dbw MAPCALLBACK_NEWMAP, CianwoodCityFlyPointAndSuicune

CianwoodCity_MapEventHeader:

.Warps: db 8
	warp_def 41, 17, 1, MANIAS_HOUSE
	warp_def 43, 8, 1, CIANWOOD_GYM
	warp_def 43, 23, 1, CIANWOOD_POKECENTER_1F
	warp_def 47, 15, 1, CIANWOOD_PHARMACY
	warp_def 31, 9, 1, CIANWOOD_CITY_PHOTO_STUDIO
	warp_def 37, 15, 1, CIANWOOD_LUGIA_SPEECH_HOUSE
	warp_def 17, 5, 1, STATS_JUDGES_HOUSE
	warp_def 25, 4, 1, CLIFF_EDGE_GATE

.XYTriggers: db 1
	xy_trigger 1, 16, 11, UnknownScript_0x1a001e

.Signposts: db 8
	signpost 34, 20, SIGNPOST_JUMPTEXT, CianwoodCitySignText
	signpost 44, 6, SIGNPOST_JUMPTEXT, CianwoodGymSignText
	signpost 47, 19, SIGNPOST_JUMPTEXT, CianwoodPharmacySignText
	signpost 32, 8, SIGNPOST_JUMPTEXT, CianwoodPhotoStudioSignText
	signpost 26, 6, SIGNPOST_JUMPTEXT, CianwoodCliffEdgeGateSignText
	signpost 22, 8, SIGNPOST_JUMPTEXT, CianwoodStatsJudgeSignText
	signpost 19, 4, SIGNPOST_ITEM + REVIVE, EVENT_CIANWOOD_CITY_HIDDEN_REVIVE
	signpost 29, 5, SIGNPOST_ITEM + MAX_ETHER, EVENT_CIANWOOD_CITY_HIDDEN_MAX_ETHER

.PersonEvents: db 15
	person_event SPRITE_OLIVINE_RIVAL, 21, 11, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, (1 << 3) | PAL_OW_PURPLE, PERSONTYPE_SCRIPT, 0, ObjectEvent, EVENT_CIANWOOD_CITY_EUSINE
	person_event SPRITE_SUICUNE, 14, 10, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, ObjectEvent, EVENT_SAW_SUICUNE_AT_CIANWOOD_CITY
	person_event SPRITE_YOUNGSTER, 37, 21, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x1a02df, -1
	person_event SPRITE_POKEFAN_M, 33, 16, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, -1, 0, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x1a0319, -1
	person_event SPRITE_LASS, 42, 14, SPRITEMOVEDATA_WALK_UP_DOWN, 2, 0, -1, -1, 0, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x1a0394, -1
	smashrock_event 16, 8
	smashrock_event 17, 9
	smashrock_event 24, 6
	smashrock_event 29, 4
	smashrock_event 27, 10
	smashrock_event 19, 4
	person_event SPRITE_POKEFAN_F, 46, 10, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, -1, 0, PERSONTYPE_SCRIPT, 0, PokefanFScript_0x1a0084, -1
	person_event SPRITE_ROCKET, 26, 4, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, PERSONTYPE_COMMAND, jumptextfaceplayer, CianwoodCityRocketText, EVENT_BEAT_CHUCK
	person_event SPRITE_SAILOR, 25, 9, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_COMMAND, jumptextfaceplayer, CianwoodCitySailorText, -1
	person_event SPRITE_FISHER, 32, 22, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_COMMAND, jumptextfaceplayer, CianwoodCityFisherText, -1

const_value set 1
	const CIANWOODCITY_EUSINE
	const CIANWOODCITY_SUICUNE

CianwoodCityFlyPointAndSuicune:
	setflag ENGINE_FLYPOINT_CIANWOOD
	setevent EVENT_EUSINE_IN_BURNED_TOWER
	checkevent EVENT_BEAT_EUSINE
	iffalse .Done
	disappear CIANWOODCITY_EUSINE
.Done:
	return

UnknownScript_0x1a001e:
	spriteface PLAYER, UP
	showemote EMOTE_SHOCK, PLAYER, 15
	pause 15
	playsound SFX_WARP_FROM
	applymovement CIANWOODCITY_SUICUNE, MovementData_0x1a00da
	spriteface PLAYER, DOWN
	pause 15
	playsound SFX_WARP_FROM
	applymovement CIANWOODCITY_SUICUNE, MovementData_0x1a00e0
	disappear CIANWOODCITY_SUICUNE
	pause 10
	dotrigger $0
	clearevent EVENT_SAW_SUICUNE_ON_ROUTE_42
	checkevent EVENT_GOT_HM05_WHIRLPOOL
	iftrue .NoLyra
	domaptrigger ROUTE_42, $1
	jump .Continue
.NoLyra
	domaptrigger ROUTE_42, $2
.Continue
	checkevent EVENT_BEAT_EUSINE
	iftrue .Done
	setevent EVENT_BEAT_EUSINE
	variablesprite SPRITE_OLIVINE_RIVAL, SPRITE_EUSINE
	special MapCallbackSprites_LoadUsedSpritesGFX
	playmusic MUSIC_MYSTICALMAN_ENCOUNTER
	appear CIANWOODCITY_EUSINE
	applymovement CIANWOODCITY_EUSINE, MovementData_0x1a00e7
	showtext UnknownText_0x1a0433
	variablesprite SPRITE_OLIVINE_RIVAL, SPRITE_COWGIRL
	winlosstext UnknownText_0x1a05a1, EusineLossText
	setlasttalked CIANWOODCITY_EUSINE
	loadtrainer MYSTICALMAN, EUSINE
	startbattle
	dontrestartmapmusic
	variablesprite SPRITE_OLIVINE_RIVAL, SPRITE_EUSINE
	reloadmapafterbattle
	special DeleteSavedMusic
	playmusic MUSIC_MYSTICALMAN_ENCOUNTER
	showtext UnknownText_0x1a05c3
	applymovement CIANWOODCITY_EUSINE, MovementData_0x1a00ec
	disappear CIANWOODCITY_EUSINE
	variablesprite SPRITE_OLIVINE_RIVAL, SPRITE_COWGIRL
	special MapCallbackSprites_LoadUsedSpritesGFX
	pause 20
	special Special_FadeOutMusic
	playmapmusic
	pause 10
.Done:
	end

PokefanFScript_0x1a0084:
	checkevent EVENT_BEAT_CHUCK
	iftrue_jumptextfaceplayer UnknownText_0x1a0277
	jumptextfaceplayer UnknownText_0x1a00f1

MovementData_0x1a00da:
	fix_facing
	fast_jump_step_down
	fast_jump_step_down
	fast_jump_step_right
	step_end

MovementData_0x1a00e0:
	fix_facing
	fast_jump_step_right
	fast_jump_step_up
	fast_jump_step_right
	fast_jump_step_right
	step_end

MovementData_0x1a00e7:
	step_up
	step_up
	step_up
	step_up
	step_end

MovementData_0x1a00ec:
	step_down
	step_down
	step_down
	step_down
	step_end

UnknownText_0x1a00f1:
	text "You crossed the"
	line "sea to get here?"

	para "That must have"
	line "been hard."

	para "It would be much"
	line "easier if your"

	para "#mon knew how"
	line "to Fly…"
	done

UnknownText_0x1a0277:
	text "That's Cianwood's"
	line "Gym badge!"

	para "My husband lost to"
	line "you, so he needs"
	cont "to train harder."

	para "That's good, since"
	line "he was getting a"
	cont "little chubby."

	para "The waterfalls on"
	line "Route 47 north of"

	para "here are a good"
	line "training spot."
	done

UnknownText_0x1a02df:
	text "If you use Fly,"
	line "you can get back"

	para "to Olivine in-"
	line "stantly."
	done

UnknownText_0x1a0319:
	text "Boulders to the"
	line "north of town can"
	cont "be crushed."

	para "They may be hiding"
	line "something."

	para "Your #mon could"
	line "use Rock Smash to"
	cont "break them."
	done

UnknownText_0x1a0394:
	text "Chuck, the Gym"
	line "Leader, spars with"

	para "his fighting #-"
	line "mon."
	done

CianwoodCityRocketText:
	text "This way is off-"
	line "limits!"

	para "Why? Mind your"
	line "own business!"
	done

CianwoodCitySailorText:
	text "That cave is the"
	line "only way to reach"
	cont "Route 47."
	done

CianwoodCityFisherText:
	text "Cianwood Pharmacy"
	line "has been in busi-"
	cont "ness for over"
	cont "500 years."

	para "That's got to be"
	line "some kind of"
	cont "record, right?"
	done

UnknownText_0x1a0433:
	text "Eusine: Yo,"
	line "<PLAYER>."

	para "Wasn't that"
	line "Suicune just now?"

	para "I only caught a"
	line "quick glimpse, but"

	para "I thought I saw"
	line "Suicune running on"
	cont "the waves."

	para "Suicune is beau-"
	line "tiful and grand."

	para "And it races"
	line "through towns and"

	para "roads at simply"
	line "awesome speeds."

	para "It's wonderful…"

	para "I want to see"
	line "Suicune up close…"

	para "I've decided."

	para "I'll battle you as"
	line "a trainer to earn"
	cont "Suicune's respect!"

	para "Come on, <PLAYER>."
	line "Let's battle now!"
	done

UnknownText_0x1a05a1:
	text "I hate to admit"
	line "it, but you win."
	done

EusineLossText:
	text "Yes!"

	para "Surely Suicune"
	line "will recognize"
	cont "my greatness now!"
	done

UnknownText_0x1a05c3:
	text "You're amazing,"
	line "<PLAYER>!"

	para "No wonder #mon"
	line "gravitate to you."

	para "I get it now."

	para "I'm going to keep"
	line "searching for"
	cont "Suicune."

	para "I'm sure we'll see"
	line "each other again."

	para "See you around!"
	done

CianwoodCitySignText:
	text "Cianwood City"

	para "A Port Surrounded"
	line "by Rough Seas"
	done

CianwoodGymSignText:
	text "Cianwood City"
	line "#mon Gym"

	para "Leader: Chuck"

	para "His Roaring Fists"
	line "Do the Talking"
	done

CianwoodPharmacySignText:
	text "500 Years of"
	line "Tradition"

	para "Cianwood City"
	line "Pharmacy"

	para "We Await Your"
	line "Medicinal Queries"
	done

CianwoodPhotoStudioSignText:
	text "Cianwood City"
	line "Photo Studio"

	para "Take a Snapshot as"
	line "a Keepsake!"
	done

CianwoodCliffEdgeGateSignText:
	text "Cliff Edge Gate"

	para "Yellow Forest is"
	line "just ahead!"
	done

CianwoodStatsJudgeSignText:
	text "The Stats Judge"
	line "Ahead"
	done
