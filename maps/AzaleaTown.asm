AzaleaTown_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 2
	dbw MAPCALLBACK_NEWMAP, AzaleaTownFlypointCallback
	dbw MAPCALLBACK_TILES, AzaleaTownRainScript

AzaleaTown_MapEventHeader:

.Warps: db 8
	warp_def 9, 15, 1, AZALEA_POKECENTER_1F
	warp_def 13, 21, 1, CHARCOAL_KILN
	warp_def 5, 21, 2, AZALEA_MART
	warp_def 5, 9, 1, KURTS_HOUSE
	warp_def 15, 10, 1, AZALEA_GYM
	warp_def 7, 31, 1, SLOWPOKE_WELL_B1F
	warp_def 10, 2, 3, ILEX_FOREST_AZALEA_GATE
	warp_def 11, 2, 4, ILEX_FOREST_AZALEA_GATE

.XYTriggers: db 3
	xy_trigger 1, 10, 5, AzaleaTownRivalBattleTrigger1
	xy_trigger 1, 11, 5, AzaleaTownRivalBattleTrigger2
	xy_trigger 2, 6, 9, AzaleaTown_CelebiTrigger

.Signposts: db 7
	signpost 9, 19, SIGNPOST_JUMPTEXT, AzaleaTownSignText
	signpost 9, 10, SIGNPOST_JUMPTEXT, KurtsHouseSignText
	signpost 15, 14, SIGNPOST_JUMPTEXT, AzaleaGymSignText
	signpost 8, 29, SIGNPOST_JUMPTEXT, SlowpokeWellSignText
	signpost 13, 19, SIGNPOST_JUMPTEXT, CharcoalKilnSignText
	signpost 9, 3, SIGNPOST_JUMPTEXT, AzaleaTownIlexForestSignText
	signpost 6, 31, SIGNPOST_ITEM + FULL_HEAL, EVENT_AZALEA_TOWN_HIDDEN_FULL_HEAL

.PersonEvents: db 12
	person_event SPRITE_SILVER, 10, 11, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, ObjectEvent, EVENT_RIVAL_AZALEA_TOWN
	person_event SPRITE_KURT, 5, 6, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, AzaleaTownKurtScript, EVENT_AZALEA_TOWN_KURT
	person_event SPRITE_GRAMPS, 9, 21, SPRITEMOVEDATA_WANDER, 2, 1, -1, -1, 0, PERSONTYPE_SCRIPT, 0, AzaleaTownGrampsScript, -1
	person_event SPRITE_TEACHER, 13, 15, SPRITEMOVEDATA_WALK_UP_DOWN, 2, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_COMMAND, jumptextfaceplayer, AzaleaTownTeacherText, -1
	person_event SPRITE_YOUNGSTER, 9, 7, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_COMMAND, jumptextfaceplayer, AzaleaTownYoungsterText, -1
	person_event SPRITE_ROCKET, 9, 31, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, PERSONTYPE_COMMAND, jumptextfaceplayer, AzaleaTownRocket1Text, EVENT_AZALEA_TOWN_SLOWPOKETAIL_ROCKET
	person_event SPRITE_ROCKET, 16, 10, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, PERSONTYPE_COMMAND, jumptextfaceplayer, AzaleaTownRocket2Text, EVENT_SLOWPOKE_WELL_ROCKETS
	person_event SPRITE_SLOWPOKE, 17, 8, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, AzaleaTownSlowpokeScript, EVENT_AZALEA_TOWN_SLOWPOKES
	person_event SPRITE_SLOWPOKE, 9, 18, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, AzaleaTownSlowpokeScript, EVENT_AZALEA_TOWN_SLOWPOKES
	person_event SPRITE_SLOWPOKE, 9, 29, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, AzaleaTownSlowpokeScript, EVENT_AZALEA_TOWN_SLOWPOKES
	person_event SPRITE_SLOWPOKE, 15, 15, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, AzaleaTownSlowpokeScript, EVENT_AZALEA_TOWN_SLOWPOKES
	fruittree_event 2, 8, FRUITTREE_AZALEA_TOWN, WHT_APRICORN

const_value set 1
	const AZALEATOWN_SILVER
	const AZALEATOWN_KURT

AzaleaTownFlypointCallback:
	setflag ENGINE_FLYPOINT_AZALEA
	return

AzaleaTownRainScript:
	special Special_GetOvercastIndex
	if_equal AZALEA_OVERCAST, .rain
	changemap AzaleaTown_BlockData
	return

.rain
	changemap AzaleaTownRaining_BlockData
	return

AzaleaTownRivalBattleTrigger1:
	moveperson AZALEATOWN_SILVER, 11, 11
AzaleaTownRivalBattleTrigger2:
	spriteface PLAYER, RIGHT
	showemote EMOTE_SHOCK, PLAYER, 15
	special Special_FadeOutMusic
	pause 15
	appear AZALEATOWN_SILVER
	applymovement AZALEATOWN_SILVER, .ApproachMovement
	faceperson AZALEATOWN_SILVER, PLAYER
	faceperson PLAYER, AZALEATOWN_SILVER
	playmusic MUSIC_RIVAL_ENCOUNTER
	showtext .SeenText
	setevent EVENT_RIVAL_AZALEA_TOWN
	checkevent EVENT_GOT_TOTODILE_FROM_ELM
	iftrue .Totodile
	checkevent EVENT_GOT_CHIKORITA_FROM_ELM
	iftrue .Chikorita
	winlosstext .WinText, .LossText
	setlasttalked AZALEATOWN_SILVER
	loadtrainer RIVAL1, RIVAL1_6
	startbattle
	dontrestartmapmusic
	reloadmapafterbattle
	jump .AfterBattle

.Totodile:
	winlosstext .WinText, .LossText
	setlasttalked AZALEATOWN_SILVER
	loadtrainer RIVAL1, RIVAL1_4
	startbattle
	dontrestartmapmusic
	reloadmapafterbattle
	jump .AfterBattle

.Chikorita:
	winlosstext .WinText, .LossText
	setlasttalked AZALEATOWN_SILVER
	loadtrainer RIVAL1, RIVAL1_5
	startbattle
	dontrestartmapmusic
	reloadmapafterbattle
	jump .AfterBattle

.AfterBattle:
	special DeleteSavedMusic
	playmusic MUSIC_RIVAL_AFTER
	showtext .AfterText
	spriteface PLAYER, LEFT
	applymovement AZALEATOWN_SILVER, .ExitMovement
	playsound SFX_EXIT_BUILDING
	disappear AZALEATOWN_SILVER
	domaptrigger ROUTE_34, $1
	dotrigger $0
	waitsfx
	playmapmusic
	end

.SeenText:
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

.WinText:
	text "…Humph! Useless"
	line "#mon!"

	para "Listen, you. You"
	line "only won because"

	para "my #mon were"
	line "weak."
	done

.LossText:
	text "…Humph! I knew"
	line "you were lying."
	done

.AfterText:
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

.ApproachMovement:
	step_left
	step_left
	step_left
	step_left
	step_left
	step_left
	step_end

.ExitMovement:
	step_left
	step_left
	step_left
	step_end

AzaleaTown_CelebiTrigger:
	applymovement PLAYER, .WalkOutOfKurtsHouseMovement
	opentext
	writetext .Text1
	buttonsound
	spriteface AZALEATOWN_KURT, RIGHT
	writetext .Text2
	buttonsound
	writetext AzaleaTownKurtText
	waitbutton
	verbosegiveitem GS_BALL
	spriteface AZALEATOWN_KURT, LEFT
	setflag ENGINE_HAVE_EXAMINED_GS_BALL
	clearevent EVENT_ILEX_FOREST_LASS
	setevent EVENT_ROUTE_34_ILEX_FOREST_GATE_LASS
	dotrigger $0
	endtext

.Text1:
	text "Ilex Forest is"
	line "restless!"

	para "What is going on?"
	done

.Text2:
	text "<PLAYER>, here's"
	line "your GS Ball back!"
	done

.WalkOutOfKurtsHouseMovement:
	step_left
	step_left
	step_up
	turn_head_left
	step_end

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

AzaleaTownGrampsScript:
	checkevent EVENT_CLEARED_SLOWPOKE_WELL
	iftrue_jumptextfaceplayer .Text2
	thistextfaceplayer

	text "The Slowpoke have"
	line "disappeared from"
	cont "town…"

	para "I heard their"
	line "Tails are being"
	cont "sold somewhere."
	done

.Text2:
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

AzaleaTownRocket1Text:
	text "It's unsafe to go"
	line "in there, so I'm"
	cont "standing guard."

	para "Aren't I a good"
	line "Samaritan?"
	done

AzaleaTownRocket2Text:
	text "Do you know about"
	line "SlowpokeTail? I"
	cont "heard it's tasty!"

	para "Aren't you glad I"
	line "told you that?"
	done

AzaleaTownSlowpokeScript:
	opentext
	writetext .Text1
	pause 60
	writetext .Text2
	cry SLOWPOKE
	waitendtext

.Text1:
	text "Slowpoke: …"

	para "…… …… ……"
	done

.Text2:
	text "…… ……Yawn?"
	done

AzaleaTownKurtScript:
	showtextfaceplayer AzaleaTownKurtText
	spriteface LAST_TALKED, LEFT
	end

AzaleaTownKurtText:
	text "Could you go see"
	line "why Ilex Forest is"
	cont "so restless?"
	done
