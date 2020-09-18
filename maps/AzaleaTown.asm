AzaleaTown_MapScriptHeader:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_NEWMAP, AzaleaTownFlypointCallback
	callback MAPCALLBACK_TILES, AzaleaTownRainScript

	def_warp_events
	warp_event 15,  9, AZALEA_POKECENTER_1F, 1
	warp_event 21, 13, CHARCOAL_KILN, 1
	warp_event 21,  5, AZALEA_MART, 2
	warp_event  9,  5, KURTS_HOUSE, 1
	warp_event 10, 15, AZALEA_GYM, 1
	warp_event 31,  7, SLOWPOKE_WELL_ENTRANCE, 1
	warp_event  2, 10, ILEX_FOREST_AZALEA_GATE, 3
	warp_event  2, 11, ILEX_FOREST_AZALEA_GATE, 4

	def_coord_events
	coord_event  5, 10, 1, AzaleaTownRivalBattleTrigger1
	coord_event  5, 11, 1, AzaleaTownRivalBattleTrigger2
	coord_event  9,  6, 2, AzaleaTown_CelebiTrigger

	def_bg_events
	bg_event 19,  9, BGEVENT_JUMPTEXT, AzaleaTownSignText
	bg_event 10,  9, BGEVENT_JUMPTEXT, KurtsHouseSignText
	bg_event 14, 15, BGEVENT_JUMPTEXT, AzaleaGymSignText
	bg_event 29,  8, BGEVENT_JUMPTEXT, SlowpokeWellSignText
	bg_event 19, 13, BGEVENT_JUMPTEXT, CharcoalKilnSignText
	bg_event  3,  9, BGEVENT_JUMPTEXT, AzaleaTownIlexForestSignText
	bg_event 31,  6, BGEVENT_ITEM + FULL_HEAL, EVENT_AZALEA_TOWN_HIDDEN_FULL_HEAL

	def_object_events
	object_event 11, 10, SPRITE_SILVER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, ObjectEvent, EVENT_RIVAL_AZALEA_TOWN
	object_event  6,  5, SPRITE_KURT, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, AzaleaTownKurtScript, EVENT_AZALEA_TOWN_KURT
	object_event 21,  9, SPRITE_GRAMPS, SPRITEMOVEDATA_WANDER, 2, 1, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, AzaleaTownGrampsScript, -1
	object_event 15, 13, SPRITE_POKEFAN_F, SPRITEMOVEDATA_WALK_UP_DOWN, 2, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_COMMAND, jumptextfaceplayer, AzaleaTownTeacherText, -1
	object_event  7,  9, SPRITE_CAMPER, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, AzaleaTownYoungsterText, -1
	object_event 31,  9, SPRITE_ROCKET, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, AzaleaTownRocket1Text, EVENT_AZALEA_TOWN_SLOWPOKETAIL_ROCKET
	object_event 10, 16, SPRITE_ROCKET, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, AzaleaTownRocket2Text, EVENT_SLOWPOKE_WELL_ROCKETS
	object_event  8, 17, SPRITE_MON_ICON, SPRITEMOVEDATA_POKEMON, 0, SLOWPOKE, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, AzaleaTownSlowpokeScript, EVENT_AZALEA_TOWN_SLOWPOKES
	object_event 18,  9, SPRITE_MON_ICON, SPRITEMOVEDATA_POKEMON, 0, SLOWPOKE, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, AzaleaTownSlowpokeScript, EVENT_AZALEA_TOWN_SLOWPOKES
	object_event 29,  9, SPRITE_MON_ICON, SPRITEMOVEDATA_POKEMON, 0, SLOWPOKE, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, AzaleaTownSlowpokeScript, EVENT_AZALEA_TOWN_SLOWPOKES
	object_event 15, 15, SPRITE_MON_ICON, SPRITEMOVEDATA_POKEMON, 0, SLOWPOKE, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, AzaleaTownSlowpokeScript, EVENT_AZALEA_TOWN_SLOWPOKES
	fruittree_event  8,  2, FRUITTREE_AZALEA_TOWN, WHT_APRICORN, PAL_NPC_SILVER

	object_const_def
	const AZALEATOWN_SILVER
	const AZALEATOWN_KURT

AzaleaTownFlypointCallback:
	setflag ENGINE_FLYPOINT_AZALEA
	return

AzaleaTownRainScript:
	special Special_GetOvercastIndex
	ifequal AZALEA_OVERCAST, .rain
	changemap AzaleaTown_BlockData
	return

.rain
	changemap AzaleaTownRaining_BlockData
	return

AzaleaTownRivalBattleTrigger1:
	moveobject AZALEATOWN_SILVER, 11, 11
AzaleaTownRivalBattleTrigger2:
	turnobject PLAYER, RIGHT
	showemote EMOTE_SHOCK, PLAYER, 15
	special Special_FadeOutMusic
	pause 15
	appear AZALEATOWN_SILVER
	applymovement AZALEATOWN_SILVER, .ApproachMovement
	faceobject AZALEATOWN_SILVER, PLAYER
	faceobject PLAYER, AZALEATOWN_SILVER
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
	turnobject PLAYER, LEFT
	applymovement AZALEATOWN_SILVER, .ExitMovement
	playsound SFX_EXIT_BUILDING
	disappear AZALEATOWN_SILVER
	setmapscene ROUTE_34, $1
	setscene $0
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
	writethistext
		text "Ilex Forest is"
		line "restless!"

		para "What is going on?"
		done
	buttonsound
	turnobject AZALEATOWN_KURT, RIGHT
	writethistext
		text "<PLAYER>, here's"
		line "your GS Ball back!"
		done
	buttonsound
	writetext AzaleaTownKurtText
	waitbutton
	verbosegivekeyitem GS_BALL
	turnobject AZALEATOWN_KURT, LEFT
	setflag ENGINE_HAVE_EXAMINED_GS_BALL
	clearevent EVENT_ILEX_FOREST_LASS
	setevent EVENT_ROUTE_34_ILEX_FOREST_GATE_LASS
	setscene $0
	endtext

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
	jumpthistextfaceplayer

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
	writethistext
		text "Slowpoke: …"

		para "…… …… ……"
		done
	pause 60
	writethistext
		text "…… ……Yawn?"
		done
	cry SLOWPOKE
	waitendtext

AzaleaTownKurtScript:
	showtextfaceplayer AzaleaTownKurtText
	turnobject LAST_TALKED, LEFT
	end

AzaleaTownKurtText:
	text "Could you go see"
	line "why Ilex Forest is"
	cont "so restless?"
	done
