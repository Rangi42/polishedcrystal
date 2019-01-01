NewBarkTown_MapScriptHeader:
	db 0 ; scene scripts

	db 1 ; callbacks
	callback MAPCALLBACK_NEWMAP, NewBarkTownFlyPoint

	db 5 ; warp events
	warp_event  6,  3, ELMS_LAB, 1
	warp_event 15,  5, KRISS_HOUSE_1F, 1
	warp_event  3, 11, KRISS_NEIGHBORS_HOUSE, 1
	warp_event 11, 13, LYRAS_HOUSE_1F, 1
	warp_event 10,  2, ELMS_HOUSE, 2

	db 7 ; coord events
	coord_event  1,  8, 0, NewBarkTown_TeacherStopsYouTrigger1
	coord_event  1,  9, 0, NewBarkTown_TeacherStopsYouTrigger2
	coord_event  6,  4, 0, NewBarkTown_LyraIntroTrigger
	coord_event 17,  6, 1, NewBarkTown_LyraFinalTrigger1
	coord_event 17,  7, 1, NewBarkTown_LyraFinalTrigger2
	coord_event 17,  8, 1, NewBarkTown_LyraFinalTrigger3
	coord_event 17,  9, 1, NewBarkTown_LyraFinalTrigger4

	db 5 ; bg events
	bg_event  8,  8, SIGNPOST_JUMPTEXT, NewBarkTownSignText
	bg_event 13,  5, SIGNPOST_JUMPTEXT, PlayersHouseSignText
	bg_event  3,  3, SIGNPOST_JUMPTEXT, ElmsLabSignText
	bg_event  9, 13, SIGNPOST_JUMPTEXT, LyrasHouseSignText
	bg_event  3,  2, SIGNPOST_ITEM + POTION, EVENT_NEW_BARK_TOWN_HIDDEN_POTION

	db 6 ; object events
	object_event  3,  2, SPRITE_CHERRYGROVE_RIVAL, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, NewBarkTownSilverScript, EVENT_RIVAL_NEW_BARK_TOWN
	object_event  1,  6, SPRITE_NEW_BARK_LYRA, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, ObjectEvent, EVENT_LYRA_NEW_BARK_TOWN
	object_event  6,  8, SPRITE_NEW_BARK_TEACHER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_RED, PERSONTYPE_SCRIPT, 0, ObjectEvent, EVENT_TEACHER_NEW_BARK_TOWN
	object_event  6,  8, SPRITE_TEACHER, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, PAL_NPC_RED, PERSONTYPE_SCRIPT, 0, NewBarkTownTeacherScript, -1
	object_event 13,  8, SPRITE_FISHER, SPRITEMOVEDATA_WALK_UP_DOWN, 1, 0, -1, -1, PAL_NPC_GREEN, PERSONTYPE_COMMAND, jumptextfaceplayer, Text_ElmDiscoveredNewMon, -1
	object_event  7, 15, SPRITE_YOUNGSTER, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, (1 << MORN) | (1 << DAY), 0, PERSONTYPE_COMMAND, jumptextfaceplayer, Text_GearIsImpressive, -1

	const_def 1 ; object constants
	const NEWBARKTOWN_SILVER
	const NEWBARKTOWN_LYRA
	const NEWBARKTOWN_TEACHER
	const NEWBARKTOWN_STILL_TEACHER

NewBarkTownFlyPoint:
	setflag ENGINE_FLYPOINT_NEW_BARK
	clearevent EVENT_FIRST_TIME_BANKING_WITH_MOM
	return

NewBarkTown_TeacherStopsYouTrigger1:
	playmusic MUSIC_MOM
	turnobject NEWBARKTOWN_STILL_TEACHER, LEFT
	appear NEWBARKTOWN_TEACHER
	turnobject NEWBARKTOWN_STILL_TEACHER, LEFT
	disappear NEWBARKTOWN_STILL_TEACHER
	showtext Text_WaitPlayer
	turnobject PLAYER, RIGHT
	applymovement NEWBARKTOWN_TEACHER, Movement_TeacherRunsToYou1_NBT
	showtext Text_WhatDoYouThinkYoureDoing
	follow NEWBARKTOWN_TEACHER, PLAYER
	applymovement NEWBARKTOWN_TEACHER, Movement_TeacherBringsYouBack1_NBT
	stopfollow
	showtext Text_ItsDangerousToGoAlone
	appear NEWBARKTOWN_STILL_TEACHER
	turnobject NEWBARKTOWN_TEACHER, LEFT
	disappear NEWBARKTOWN_TEACHER
	special RestartMapMusic
	end

NewBarkTown_TeacherStopsYouTrigger2:
	playmusic MUSIC_MOM
	turnobject NEWBARKTOWN_TEACHER, LEFT
	appear NEWBARKTOWN_TEACHER
	turnobject NEWBARKTOWN_STILL_TEACHER, LEFT
	disappear NEWBARKTOWN_STILL_TEACHER
	showtext Text_WaitPlayer
	turnobject PLAYER, RIGHT
	applymovement NEWBARKTOWN_TEACHER, Movement_TeacherRunsToYou2_NBT
	turnobject PLAYER, UP
	showtext Text_WhatDoYouThinkYoureDoing
	follow NEWBARKTOWN_TEACHER, PLAYER
	applymovement NEWBARKTOWN_TEACHER, Movement_TeacherBringsYouBack2_NBT
	stopfollow
	showtext Text_ItsDangerousToGoAlone
	appear NEWBARKTOWN_STILL_TEACHER
	turnobject NEWBARKTOWN_TEACHER, LEFT
	disappear NEWBARKTOWN_TEACHER
	special RestartMapMusic
	end

NewBarkTown_LyraIntroTrigger:
	appear NEWBARKTOWN_LYRA
	special Special_FadeOutMusic
	applymovement NEWBARKTOWN_LYRA, Movement_LyraEnters_NBT
	playmusic MUSIC_LYRA_ENCOUNTER_HGSS
	showemote EMOTE_SHOCK, NEWBARKTOWN_LYRA, 15
	applymovement NEWBARKTOWN_LYRA, Movement_LyraApproaches_NBT
	turnobject PLAYER, LEFT
	showtext Text_LyraIntro
	follow PLAYER, NEWBARKTOWN_LYRA
	applyonemovement PLAYER, step_up
	stopfollow
	playsound SFX_EXIT_BUILDING
	disappear PLAYER
	applyonemovement NEWBARKTOWN_LYRA, step_up
	playsound SFX_EXIT_BUILDING
	disappear NEWBARKTOWN_LYRA
	setscene $2
	special FadeOutPalettes
	pause 15
	warpfacing UP, ELMS_LAB, 4, 11
	end

NewBarkTown_LyraFinalTrigger1:
	moveobject NEWBARKTOWN_LYRA, 14, 11
	jump NewBarkTown_LyraFinalTrigger

NewBarkTown_LyraFinalTrigger2:
	moveobject NEWBARKTOWN_LYRA, 14, 12
	jump NewBarkTown_LyraFinalTrigger

NewBarkTown_LyraFinalTrigger3:
	moveobject NEWBARKTOWN_LYRA, 14, 13
	jump NewBarkTown_LyraFinalTrigger

NewBarkTown_LyraFinalTrigger4:
	moveobject NEWBARKTOWN_LYRA, 14, 14
NewBarkTown_LyraFinalTrigger:
	variablesprite SPRITE_NEW_BARK_LYRA, SPRITE_LYRA
	special MapCallbackSprites_LoadUsedSpritesGFX
	appear NEWBARKTOWN_LYRA
	applymovement NEWBARKTOWN_LYRA, Movement_LyraSaysGoodbye1_NBT
	showemote EMOTE_SHOCK, NEWBARKTOWN_LYRA, 15
	special Special_FadeOutMusic
	pause 15
	applymovement NEWBARKTOWN_LYRA, Movement_LyraSaysGoodbye2_NBT
	turnobject PLAYER, LEFT
	showtext Text_LyraGoodbye1
	setevent EVENT_LYRA_NEW_BARK_TOWN
	variablesprite SPRITE_NEW_BARK_LYRA, SPRITE_LASS
	winlosstext Text_LyraGoodbyeWin, Text_LyraGoodbyeLoss
	setlasttalked NEWBARKTOWN_LYRA
	checkevent EVENT_GOT_TOTODILE_FROM_ELM
	iftrue .Totodile
	checkevent EVENT_GOT_CHIKORITA_FROM_ELM
	iftrue .Chikorita
	loadtrainer LYRA1, LYRA1_10
	jump .AfterBattle

.Totodile:
	loadtrainer LYRA1, LYRA1_11
	jump .AfterBattle

.Chikorita:
	loadtrainer LYRA1, LYRA1_12
.AfterBattle
	startbattle
	dontrestartmapmusic
	variablesprite SPRITE_NEW_BARK_LYRA, SPRITE_LYRA
	reloadmapafterbattle
	special DeleteSavedMusic
	playmusic MUSIC_LYRA_DEPARTURE_HGSS
	showtext Text_LyraGoodbye2
	applymovement NEWBARKTOWN_LYRA, Movement_LyraSaysGoodbye3_NBT
	disappear NEWBARKTOWN_LYRA
	variablesprite SPRITE_NEW_BARK_LYRA, SPRITE_LASS
	special MapCallbackSprites_LoadUsedSpritesGFX
	setscene $2
	playmapmusic
	end

NewBarkTownTeacherScript:
	checkevent EVENT_TALKED_TO_MOM_AFTER_MYSTERY_EGG_QUEST
	iftrue_jumptextfaceplayer Text_CallMomOnGear
	checkevent EVENT_GAVE_MYSTERY_EGG_TO_ELM
	iftrue_jumptextfaceplayer Text_TellMomIfLeaving
	checkevent EVENT_GOT_A_POKEMON_FROM_ELM
	iftrue_jumptextfaceplayer Text_YourMonIsAdorable
	jumptextfaceplayer Text_RefreshingBreeze

NewBarkTownSilverScript:
	showtext NewBarkTownRivalText1
	turnobject NEWBARKTOWN_SILVER, LEFT
	showtext NewBarkTownRivalText2
	follow PLAYER, NEWBARKTOWN_SILVER
	applymovement PLAYER, Movement_SilverPushesYouAway_NBT
	stopfollow
	pause 5
	turnobject NEWBARKTOWN_SILVER, DOWN
	pause 5
	playsound SFX_TACKLE
	applymovement PLAYER, Movement_SilverShovesYouOut_NBT
	applyonemovement NEWBARKTOWN_SILVER, step_right
	end

Movement_TeacherRunsToYou1_NBT:
	step_left
	step_left
	step_left
	step_left
	step_end

Movement_TeacherRunsToYou2_NBT:
	step_left
	step_left
	step_left
	step_left
	step_left
	turn_head_down
	step_end

Movement_TeacherBringsYouBack2_NBT:
	step_right
Movement_TeacherBringsYouBack1_NBT:
	step_right
	step_right
	step_right
	step_right
	turn_head_left
	step_end

Movement_SilverPushesYouAway_NBT:
	turn_head_up
	step_down
	step_end

Movement_SilverShovesYouOut_NBT:
	turn_head_up
	fix_facing
	jump_step_down
	remove_fixed_facing
	step_end

Movement_LyraEnters_NBT:
	step_right
	step_right
	step_end

Movement_LyraApproaches_NBT:
	step_right
	step_up
	step_up
	step_right
	step_end

Movement_LyraSaysGoodbye1_NBT:
	step_up
	step_up
	step_end

Movement_LyraSaysGoodbye2_NBT:
	step_right
	step_up
	step_up
	step_up
	step_right
	step_end

Movement_LyraSaysGoodbye3_NBT:
	step_left
	step_down
	step_down
	step_down
	step_down
	step_down
	step_end

Text_GearIsImpressive:
	text "Wow, your #gear"
	line "is impressive!"

	para "Did your mom get"
	line "it for you?"
	done

Text_RefreshingBreeze:
	text "There's always"
	line "such a refreshing"
	cont "breeze here."
	done

Text_WaitPlayer:
	text "Wait, <PLAYER>!"
	done

Text_WhatDoYouThinkYoureDoing:
	text "What do you think"
	line "you're doing?"
	done

Text_ItsDangerousToGoAlone:
	text "It's dangerous to"
	line "go out without a"
	cont "#mon!"

	para "Wild #mon"
	line "jump out of the"

	para "grass on the way"
	line "to the next town."
	done

Text_YourMonIsAdorable:
	text "Oh! Your #mon"
	line "is adorable!"
	cont "I wish I had one!"
	done

Text_TellMomIfLeaving:
	text "Hi, <PLAYER>!"
	line "Leaving again?"

	para "You should tell"
	line "your mom if you"
	cont "are leaving."
	done

Text_CallMomOnGear:
	text "Call your mom on"
	line "your #gear to"

	para "let her know how"
	line "you're doing."
	done

Text_ElmDiscoveredNewMon:
	text "Yo, <PLAYER>!"

	para "I hear Prof.Elm"
	line "discovered some"
	cont "new #mon."
	done

NewBarkTownRivalText1:
	text "……"

	para "So this is the"
	line "famous Elm #mon"
	cont "Lab…"
	done

NewBarkTownRivalText2:
	text "…What are you"
	line "staring at?"
	done

Text_LyraIntro:
	text "Lyra: Oh, hello,"
	line "<PLAYER>!"

	para "I came by your"
	line "house earlier,"

	para "but you were"
	line "still sleeping."

	para "You know how I"
	line "assist Prof.Elm"
	cont "sometimes?"

	para "He's starting new"
	line "#mon research"

	para "and would like us"
	line "both to help."

	para "Let's go and see"
	line "what he wants!"
	done

Text_LyraGoodbye1:
	text "Lyra: <PLAYER>!"

	para "I heard that you"
	line "have all the Gym"
	cont "badges in Johto."

	para "…You're really"
	line "something,"
	cont "<PLAYER>."

	para "To think that we"
	line "both started our"

	para "journeys in this"
	line "town…"

	para "I do what I can"
	line "to help the Prof-"
	cont "essor, but I could"

	para "never take on the"
	line "League Champion."

	para "…Before you go…"

	para "How about one"
	line "more battle?"

	para "I want to see the"
	line "kind of trainer"
	cont "you've become!"
	done

Text_LyraGoodbyeWin:
	text "You're as talented"
	line "as I expected!"
	done

Text_LyraGoodbyeLoss:
	text "I hope you didn't"
	line "let me win…"
	done

Text_LyraGoodbye2:
	text "…Thanks, <PLAYER>."

	para "I can tell how"
	line "much work and"

	para "love you put into"
	line "raising your"
	cont "#mon."

	para "…So, this is"
	line "goodbye."

	para "I know you can win"
	line "at the #mon"
	cont "League!"

	para "You're going to be"
	line "a great Champion!"
	done

NewBarkTownSignText:
	text "New Bark Town"

	para "The Town Where the"
	line "Winds of a New"
	cont "Beginning Blow"
	done

PlayersHouseSignText:
	text "<PLAYER>'s House"
	done

ElmsLabSignText:
	text "Elm #mon Lab"
	done

LyrasHouseSignText:
	text "Lyra's House"
	done
