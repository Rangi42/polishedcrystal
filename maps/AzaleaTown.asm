const_value set 2
	const AZALEATOWN_AZALEA_ROCKET1
	const AZALEATOWN_GRAMPS
	const AZALEATOWN_TEACHER
	const AZALEATOWN_YOUNGSTER
	const AZALEATOWN_SLOWPOKE1
	const AZALEATOWN_SLOWPOKE2
	const AZALEATOWN_SLOWPOKE3
	const AZALEATOWN_SLOWPOKE4
	const AZALEATOWN_FRUIT_TREE
	const AZALEATOWN_SILVER
	const AZALEATOWN_AZALEA_ROCKET3
	const AZALEATOWN_KURT

AzaleaTown_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 1
	dbw MAPCALLBACK_NEWMAP, .Flypoint

.Flypoint:
	setflag ENGINE_FLYPOINT_AZALEA
	return

AzaleaTownRivalBattleTrigger1:
	moveperson AZALEATOWN_SILVER, $b, $b
	spriteface PLAYER, RIGHT
	showemote EMOTE_SHOCK, PLAYER, 15
	special Special_FadeOutMusic
	pause 15
	appear AZALEATOWN_SILVER
	applymovement AZALEATOWN_SILVER, AzaleaTownRivalBattleApproachMovement1
	spriteface PLAYER, DOWN
	jump AzaleaTownRivalBattleScript

AzaleaTownRivalBattleTrigger2:
	spriteface PLAYER, RIGHT
	showemote EMOTE_SHOCK, PLAYER, 15
	special Special_FadeOutMusic
	pause 15
	appear AZALEATOWN_SILVER
	applymovement AZALEATOWN_SILVER, AzaleaTownRivalBattleApproachMovement2
	spriteface PLAYER, UP
AzaleaTownRivalBattleScript:
	playmusic MUSIC_RIVAL_ENCOUNTER
	opentext
	writetext AzaleaTownRivalBeforeText
	waitbutton
	closetext
	setevent EVENT_RIVAL_AZALEA_TOWN
	checkevent EVENT_GOT_TOTODILE_FROM_ELM
	iftrue .Totodile
	checkevent EVENT_GOT_CHIKORITA_FROM_ELM
	iftrue .Chikorita
	winlosstext AzaleaTownRivalWinText, AzaleaTownRivalLossText
	setlasttalked AZALEATOWN_SILVER
	loadtrainer RIVAL1, RIVAL1_6
	startbattle
	dontrestartmapmusic
	reloadmapafterbattle
	jump .AfterBattle

.Totodile:
	winlosstext AzaleaTownRivalWinText, AzaleaTownRivalLossText
	setlasttalked AZALEATOWN_SILVER
	loadtrainer RIVAL1, RIVAL1_4
	startbattle
	dontrestartmapmusic
	reloadmapafterbattle
	jump .AfterBattle

.Chikorita:
	winlosstext AzaleaTownRivalWinText, AzaleaTownRivalLossText
	setlasttalked AZALEATOWN_SILVER
	loadtrainer RIVAL1, RIVAL1_5
	startbattle
	dontrestartmapmusic
	reloadmapafterbattle
	jump .AfterBattle

.AfterBattle:
	special DeleteSavedMusic
	playmusic MUSIC_RIVAL_AFTER
	opentext
	writetext AzaleaTownRivalAfterText
	waitbutton
	closetext
	spriteface PLAYER, LEFT
	applymovement AZALEATOWN_SILVER, AzaleaTownRivalBattleExitMovement
	playsound SFX_EXIT_BUILDING
	disappear AZALEATOWN_SILVER
	domaptrigger ROUTE_34, $1
	dotrigger $0
	waitsfx
	playmapmusic
	end

AzaleaTownRocket1Script:
	jumptextfaceplayer GoodSamaritanRocketText

AzaleaTownRocket2Script:
	jumptextfaceplayer TastySlowpokeTailRocketText

AzaleaTownGrampsScript:
	faceplayer
	opentext
	checkevent EVENT_CLEARED_SLOWPOKE_WELL
	iftrue .ClearedWell
	writetext AzaleaTownGrampsTextBefore
	waitbutton
	closetext
	end

.ClearedWell:
	writetext AzaleaTownGrampsTextAfter
	waitbutton
	closetext
	end

AzaleaTownTeacherScript:
	jumptextfaceplayer AzaleaTownTeacherText

AzaleaTownYoungsterScript:
	jumptextfaceplayer AzaleaTownYoungsterText

AzaleaTownSlowpokeScript:
	opentext
	writetext AzaleaTownSlowpokeText1
	pause 60
	writetext AzaleaTownSlowpokeText2
	cry SLOWPOKE
	waitbutton
	closetext
	end

AzaleaTown_CelebiEventScript:
	applymovement PLAYER, Movement_PlayerWalksOutOfKurtsHouse
	opentext
	writetext IlexForestIsRestlessText
	buttonsound
	spriteface AZALEATOWN_KURT, RIGHT
	writetext HeresTheGSBallBackText
	buttonsound
	writetext PleaseInvestigateIlexForestText
	waitbutton
	verbosegiveitem GS_BALL
	spriteface AZALEATOWN_KURT, LEFT
	setflag ENGINE_HAVE_EXAMINED_GS_BALL
	clearevent EVENT_ILEX_FOREST_LASS
	setevent EVENT_ROUTE_34_ILEX_FOREST_GATE_LASS
	dotrigger $0
	closetext
	end

AzaleaTownKurtScript:
	faceplayer
	opentext
	writetext PleaseInvestigateIlexForestText
	waitbutton
	spriteface AZALEATOWN_KURT, LEFT
	closetext
	end

AzaleaTownSign:
	habitatlist AzaleaTownSignText, AZALEA_TOWN

KurtsHouseSign:
	jumptext KurtsHouseSignText

AzaleaGymSign:
	jumptext AzaleaGymSignText

SlowpokeWellSign:
	habitatlist SlowpokeWellSignText, SLOWPOKE_WELL

CharcoalKilnSign:
	jumptext CharcoalKilnSignText

AzaleaTownIlextForestSign:
	habitatlist AzaleaTownIlexForestSignText, ILEX_FOREST

WhiteApricornTree:
	fruittree FRUITTREE_AZALEA_TOWN

AzaleaTownHiddenFullHeal:
	dwb EVENT_AZALEA_TOWN_HIDDEN_FULL_HEAL, FULL_HEAL


AzaleaTownRivalBattleApproachMovement1:
	step_left
	step_left
	step_left
	step_left
	step_left
	step_left
	turn_head_up
	step_end

AzaleaTownRivalBattleApproachMovement2:
	step_left
	step_left
	step_left
	step_left
	step_left
	step_left
	turn_head_down
	step_end

AzaleaTownRivalBattleExitMovement:
	step_left
	step_left
	step_left
	step_end

Movement_PlayerWalksOutOfKurtsHouse:
	step_left
	step_left
	step_up
	turn_head_left
	step_end

AzaleaTownRivalBeforeText:
	text "…Tell me some-"
	line "thing."

	para "Is it true that"
	line "Team Rocket has"
	cont "returned?"

	para "What? You beat"
	line "them? Hah! Quit"
	cont "lying."

	para "You're not joking?"
	line "Then let's see how"
	cont "good you are."
	done

AzaleaTownRivalWinText:
	text "…Humph! Useless"
	line "#mon!"

	para "Listen, you. You"
	line "only won because"

	para "my #mon were"
	line "weak."
	done

AzaleaTownRivalAfterText:
	text "I hate the weak."

	para "#mon, trainers."
	line "It doesn't matter"
	cont "who or what."

	para "I'm going to be"
	line "strong and wipe"
	cont "out the weak."

	para "That goes for Team"
	line "Rocket too."

	para "They act big and"
	line "tough in a group."

	para "But get them"
	line "alone, and they're"
	cont "weak."

	para "I hate them all."

	para "You stay out of my"
	line "way. A weakling"

	para "like you is only a"
	line "distraction."
	done

AzaleaTownRivalLossText:
	text "…Humph! I knew"
	line "you were lying."
	done

GoodSamaritanRocketText:
	text "It's unsafe to go"
	line "in there, so I'm"
	cont "standing guard."

	para "Aren't I a good"
	line "Samaritan?"
	done

TastySlowpokeTailRocketText:
	text "Do you know about"
	line "SlowpokeTail? I"
	cont "heard it's tasty!"

	para "Aren't you glad I"
	line "told you that?"
	done

AzaleaTownGrampsTextBefore:
	text "The Slowpoke have"
	line "disappeared from"
	cont "town…"

	para "I heard their"
	line "Tails are being"
	cont "sold somewhere."
	done

AzaleaTownGrampsTextAfter:
	text "The Slowpoke have"
	line "returned."

	para "Knowing them, they"
	line "could've just been"

	para "goofing off some-"
	line "where."
	done

AzaleaTownTeacherText:
	text "Did you come to"
	line "get Kurt to make"
	cont "some Balls?"

	para "A lot of people do"
	line "just that."
	done

AzaleaTownYoungsterText:
	text "Cut through Azalea"
	line "and you'll be in"
	cont "Ilex Forest."

	para "But these skinny"
	line "trees make it"

	para "impossible to get"
	line "through."

	para "The Charcoal Man's"
	line "#mon can Cut"
	cont "down trees."
	done

AzaleaTownSlowpokeText1:
	text "Slowpoke: …"

	para "…… …… ……"
	done

AzaleaTownSlowpokeText2:
	text "…… ……Yawn?"
	done

IlexForestIsRestlessText:
	text "Ilex Forest is"
	line "restless!"

	para "What is going on?"
	done

HeresTheGSBallBackText:
	text "<PLAYER>, here's"
	line "your GS Ball back!"
	done

PleaseInvestigateIlexForestText:
	text "Could you go see"
	line "why Ilex Forest is"
	cont "so restless?"
	done

AzaleaTownSignText:
	text "Azalea Town"
	line "Where People and"

	para "#mon Live in"
	line "Happy Harmony"
	done

KurtsHouseSignText:
	text "Kurt's House"
	done

AzaleaGymSignText:
	text "Azalea Town"
	line "#mon Gym"
	cont "Leader: Bugsy"

	para "The Walking"
	line "Bug #mon"
	cont "Encyclopedia"
	done

SlowpokeWellSignText:
	text "Slowpoke Well"

	para "Also known as the"
	line "Rainmaker Well."

	para "Locals believe"
	line "that a Slowpoke's"
	cont "yawn summons rain."

	para "Records show that"
	line "a Slowpoke's yawn"

	para "ended a drought"
	line "400 years ago."
	done

CharcoalKilnSignText:
	text "Charcoal Kiln"
	done

AzaleaTownIlexForestSignText:
	text "Ilex Forest"

	para "Enter through the"
	line "gate."
	done

AzaleaTown_MapEventHeader:
.Warps:
	db 8
	warp_def $9, $f, 1, AZALEA_POKECENTER_1F
	warp_def $d, $15, 1, CHARCOAL_KILN
	warp_def $5, $15, 2, AZALEA_MART
	warp_def $5, $9, 1, KURTS_HOUSE
	warp_def $f, $a, 1, AZALEA_GYM
	warp_def $7, $1f, 1, SLOWPOKE_WELL_B1F
	warp_def $a, $2, 3, ILEX_FOREST_AZALEA_GATE
	warp_def $b, $2, 4, ILEX_FOREST_AZALEA_GATE

.XYTriggers:
	db 3
	xy_trigger 1, $a, $5, AzaleaTownRivalBattleTrigger1
	xy_trigger 1, $b, $5, AzaleaTownRivalBattleTrigger2
	xy_trigger 2, $6, $9, AzaleaTown_CelebiEventScript

.Signposts:
	db 7
	signpost 9, 19, SIGNPOST_READ, AzaleaTownSign
	signpost 9, 10, SIGNPOST_READ, KurtsHouseSign
	signpost 15, 14, SIGNPOST_READ, AzaleaGymSign
	signpost 7, 29, SIGNPOST_READ, SlowpokeWellSign
	signpost 13, 19, SIGNPOST_READ, CharcoalKilnSign
	signpost 9, 3, SIGNPOST_READ, AzaleaTownIlextForestSign
	signpost 6, 31, SIGNPOST_ITEM, AzaleaTownHiddenFullHeal

.PersonEvents:
	db 12
	person_event SPRITE_AZALEA_ROCKET, 9, 31, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, AzaleaTownRocket1Script, EVENT_AZALEA_TOWN_SLOWPOKETAIL_ROCKET
	person_event SPRITE_GRAMPS, 9, 21, SPRITEMOVEDATA_WANDER, 2, 1, -1, -1, 0, PERSONTYPE_SCRIPT, 0, AzaleaTownGrampsScript, -1
	person_event SPRITE_TEACHER, 13, 15, SPRITEMOVEDATA_WALK_UP_DOWN, 2, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, AzaleaTownTeacherScript, -1
	person_event SPRITE_YOUNGSTER, 9, 7, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_SCRIPT, 0, AzaleaTownYoungsterScript, -1
	person_event SPRITE_SLOWPOKE, 17, 8, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, AzaleaTownSlowpokeScript, EVENT_AZALEA_TOWN_SLOWPOKES
	person_event SPRITE_SLOWPOKE, 9, 18, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, AzaleaTownSlowpokeScript, EVENT_AZALEA_TOWN_SLOWPOKES
	person_event SPRITE_SLOWPOKE, 9, 29, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, AzaleaTownSlowpokeScript, EVENT_AZALEA_TOWN_SLOWPOKES
	person_event SPRITE_SLOWPOKE, 15, 15, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, AzaleaTownSlowpokeScript, EVENT_AZALEA_TOWN_SLOWPOKES
	person_event SPRITE_BALL_CUT_FRUIT, 2, 8, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, WhiteApricornTree, -1
	person_event SPRITE_AZALEA_ROCKET, 10, 11, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, ObjectEvent, EVENT_RIVAL_AZALEA_TOWN
	person_event SPRITE_AZALEA_ROCKET, 16, 10, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, AzaleaTownRocket2Script, EVENT_SLOWPOKE_WELL_ROCKETS
	person_event SPRITE_KURT, 5, 6, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, AzaleaTownKurtScript, EVENT_AZALEA_TOWN_KURT
