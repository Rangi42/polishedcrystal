Hollowport_MapScriptHeader:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_NEWMAP, HollowportFlyPoint

	def_warp_events
	warp_event 17,  5, PLAYERS_HOUSE_1F, 1
	warp_event  5,  3, FIELD_LAB, 1
	warp_event 13, 11, HOLLOWPORT_RIVAL_1F, 1
	warp_event  5, 15, HOLLOWPORT_NEIGHBOR, 1
	warp_event  1,  7, ECHOING_CAVE, 1


	def_coord_events
	coord_event 13,  0, 0, Hollowport_ElderStopsYouTrigger1
	coord_event 12,  0, 0, Hollowport_ElderStopsYouTrigger2
	; coord_event  5,  6, 0, Hollowport_RivalIntroTrigger

	def_bg_events
	bg_event 10,  4, BGEVENT_JUMPTEXT, HollowportRouteSignText
	bg_event  9, 11, BGEVENT_JUMPTEXT, HollowportSignText
	bg_event 16,  6, BGEVENT_JUMPTEXT, PlayerHouseSignText
	bg_event  3,  4, BGEVENT_JUMPTEXT, FieldLabSignText
	bg_event 14, 12, BGEVENT_JUMPTEXT, RivalsHouseSignText
	; bg_event  2,  8, BGEVENT_ITEM + POTION, EVENT_NEW_BARK_TOWN_HIDDEN_POTION

	def_object_events
	object_event  0,  8, SPRITE_ROCKET, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, 0, OBJECTTYPE_SCRIPT, 0, HollowportRivalScript, EVENT_HOLLOWPORT_THIEF
	; object_event  6,  5, SPRITE_LYRA, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, 0, OBJECTTYPE_SCRIPT, 0, ObjectEvent, EVENT_RIVAL_NEW_BARK_TOWN
	object_event  8,  5, SPRITE_LYRA, SPRITEMOVEDATA_STANDING_DOWN, 1, 0, -1, PAL_NPC_GREEN, OBJECTTYPE_COMMAND, jumptextfaceplayer, Text_HollowportRival, -1
	object_event 14,  5, SPRITE_ELDER, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, HollowportElderScript, -1
	object_event 12, 15, SPRITE_FAT_GUY, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 1, 0, -1, PAL_NPC_GREEN, OBJECTTYPE_COMMAND, jumptextfaceplayer, Text_Technologia, -1
	object_event  6, 10, SPRITE_PICNICKER, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, (1 << MORN) | (1 << DAY), 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, Text_HollowportBirdFriend, -1
	object_event 17, 13, SPRITE_FISHER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, PAL_NPC_RED, OBJECTTYPE_COMMAND, jumptextfaceplayer, Text_HollowportFisher, -1
	pokemon_event  8, 10, MURKROW, SPRITEMOVEDATA_POKEMON, -1, PAL_NPC_PURPLE, HollowportMurkrowText, -1

	object_const_def
	; const HOLLOWPORT_RIVAL
	const HOLLOWPORT_ELDER
	const HOLLOWPORT_THIEF
HollowportFlyPoint:
	setflag ENGINE_FLYPOINT_HOLLOWPORT
	clearevent EVENT_FIRST_TIME_BANKING_WITH_MOM
	endcallback

Hollowport_ElderStopsYouTrigger1:
	playmusic MUSIC_MOM
	turnobject HOLLOWPORT_ELDER, LEFT
	showtext Text_WaitPlayer
	turnobject PLAYER, RIGHT
	applymovement HOLLOWPORT_ELDER, Movement_ElderRunsToYou1_NBT
	showtext Text_WhatDoYouThinkYoureDoing
	follow HOLLOWPORT_ELDER, PLAYER
	applymovement HOLLOWPORT_ELDER, Movement_ElderBringsYouBack1_NBT
	stopfollow
	showtext Text_ItsDangerousToGoAlone
	special RestartMapMusic
	end

Hollowport_ElderStopsYouTrigger2:
	playmusic MUSIC_MOM
	turnobject HOLLOWPORT_ELDER, LEFT
	showtext Text_WaitPlayer
	turnobject PLAYER, RIGHT
	applymovement HOLLOWPORT_ELDER, Movement_ElderRunsToYou2_NBT
	turnobject PLAYER, UP
	showtext Text_WhatDoYouThinkYoureDoing
	follow HOLLOWPORT_ELDER, PLAYER
	applymovement HOLLOWPORT_ELDER, Movement_ElderBringsYouBack2_NBT
	stopfollow
	showtext Text_ItsDangerousToGoAlone
	special RestartMapMusic
	end

; Hollowport_RivalIntroTrigger:
; 	appear HOLLOWPORT_RIVAL
; 	special Special_FadeOutMusic
; 	applymovement HOLLOWPORT_RIVAL, Movement_RIVALEnters_NBT
; 	playmusic MUSIC_RIVAL_ENCOUNTER_HGSS
; 	showemote EMOTE_SHOCK, HOLLOWPORT_RIVAL, 15
; 	applymovement HOLLOWPORT_RIVAL, Movement_LyraApproaches_NBT
; 	turnobject PLAYER, LEFT
; 	showtext Text_LyraIntro
; 	follow PLAYER, HOLLOWPORT_RIVAL
; 	applyonemovement PLAYER, step_up
; 	stopfollow
; 	playsound SFX_EXIT_BUILDING
; 	disappear PLAYER
; 	applyonemovement HOLLOWPORT_RIVAL, step_up
; 	playsound SFX_EXIT_BUILDING
; 	disappear HOLLOWPORT_RIVAL
; 	setscene $2
; 	special FadeOutPalettes
; 	pause 15
; 	warpfacing UP, ELMS_LAB, 4, 11
; 	end

; .Totodile:
; 	loadtrainer LYRA1, LYRA1_11
; 	sjumpfwd .AfterBattle

; .Chikorita:
; 	loadtrainer LYRA1, LYRA1_12
; .AfterBattle
; 	startbattle
; 	dontrestartmapmusic
; 	reloadmapafterbattle
; 	special DeleteSavedMusic
; 	playmusic MUSIC_LYRA_DEPARTURE_HGSS
; 	showtext Text_LyraGoodbye2
; 	applymovement HOLLOWPORT_LYRA, Movement_LyraSaysGoodbye3_NBT
; 	disappear HOLLOWPORT_LYRA
; 	setscene $2
; 	playmapmusic
; 	end

HollowportElderScript:
	checkevent EVENT_TALKED_TO_MOM_AFTER_MYSTERY_EGG_QUEST
	iftrue_jumptextfaceplayer Text_CallMom
	checkevent EVENT_GAVE_MYSTERY_EGG_TO_ELM
	iftrue_jumptextfaceplayer Text_TellMomLeaving
	checkevent EVENT_GOT_A_POKEMON_FROM_ELM
	iftrue_jumptextfaceplayer Text_MonIsAdorable
	jumptextfaceplayer Text_NiceBreeze

Movement_ElderRunsToYou1_NBT:
	step_left
	step_up
	step_up
	step_up
	step_end

Movement_ElderRunsToYou2_NBT:
	step_left
	step_left
	step_up
	step_up
	step_up
	step_end

Movement_ElderBringsYouBack2_NBT:
	step_right
	step_down
	step_down
	step_down
	step_right
	turn_head_left
	step_end
Movement_ElderBringsYouBack1_NBT:
	step_down
	step_down
	step_down
	step_right
	turn_head_left
	step_end

Movement_RivalEnters_NBT:
	step_right
	step_right
	step_end

Movement_RivalApproaches_NBT:
	step_right
	step_up
	step_up
	step_right
	step_end

HollowportRivalScript:
	showtext HollowportRivalText1
	turnobject HOLLOWPORT_THIEF, LEFT
	showtext HollowportRivalText2
	turnobject PLAYER, UP
	applyonemovement PLAYER, fix_facing
	follow PLAYER, HOLLOWPORT_THIEF
	applyonemovement PLAYER, step_down
	stopfollow
	pause 5
	turnobject HOLLOWPORT_THIEF, DOWN
	pause 5
	playsound SFX_TACKLE
	applyonemovement PLAYER, jump_step_down
	applyonemovement PLAYER, remove_fixed_facing
	applyonemovement HOLLOWPORT_THIEF, step_right
	end

	HollowportRivalText1:
	text "……"

	para "So this is where"
	line "Pawpaw is"
	cont "setting up..."
	done

HollowportRivalText2:
	text "…What are you"
	line "staring at?"
	done
Text_HollowportBirdFriend:
	text "KIKIKI"
	line "..."

	para "Shh I'm trying to"
	line "make friends with"
	cont "that Murkrow"
	done

Text_NiceBreeze:
	text "The breeze from"
	line "the river is real"
	cont "nice, ain't it?"
	done
Text_HollowportFisher:
	text "Hush!"
	line "You'll scare away"
	cont "all the fish"
	cont "#mon!"
	done

Text_Wait:
	text "Wait, <PLAYER>!"
	done

Text_WhatDoing:
	text "Now just what do"
	line "you think"
	cont "you're doin?"
	done

Text_DangerousToGoAlone:
	text "It's dangerous to"
	line "go out without a"
	cont "#mon!"

	para "There are Wild #mon"
	line "in the tall grass!"

	para "grass on the way"
	line "to the next town."
	done

Text_MonIsAdorable:
	text "Oh! Your #mon"
	line "is so cool!"
	cont "You're so lucky!"
	done

Text_TellMomLeaving:
	text "Hi, <PLAYER>!"
	line "Leaving again?"

	para "You should tell"
	line "your mom if you"
	cont "are leaving."
	done

Text_CallMom:
	text "Call your mom on"
	line "your #gear to"

	para "let her know how"
	line "you're doing."
	done

Text_Technologia:
	text "Yo, <PLAYER>!"

	para "You can create"
	line "new games"
	cont "by modifying"
	cont "the original"

	para "Isn't technology"
	line "incredible?!"
	done
	
HollowportMurkrowText:
	text "Murkrow: MrrKAW!"
	done

Text_HollowportRival:
	text "Lyra: Oh, hello,"
	line "<PLAYER>!"

	para "I came by your"
	line "house earlier,"

	para "but you were"
	line "still sleeping."

	para "You know how I"
	line "assist Prof.Pawpaw"
	cont "sometimes?"

	para "He's starting new"
	line "#mon research"

	para "and would like us"
	line "both to help."

	para "Let's go and see"
	line "what he wants!"
	done

HollowportSignText:
	text "Hollowport"

	para "Where Home is"
	line "Just Around the"
	cont "Rivers' Bend"
	done

HollowportRouteSignText:
	text "NORTH:"
	line "Route 101"

	para "SOUTH:"
	line "Hollowport"

	done
PlayerHouseSignText:
	text "<PLAYER>'s House"
	done

FieldLabSignText:
	text "Pawpaw #mon"
	line "Field Lab"
	done

RivalsHouseSignText:
	text "Rival's House"
	done
