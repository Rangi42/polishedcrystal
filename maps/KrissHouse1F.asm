KrissHouse1F_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 3 ; warp events
	warp_event  6,  7, NEW_BARK_TOWN, 2
	warp_event  7,  7, NEW_BARK_TOWN, 2
	warp_event  9,  0, KRISS_HOUSE_2F, 1

	db 3 ; coord events
	coord_event  8,  4, 0, MomTrigger1
	coord_event  9,  4, 0, MomTrigger2
	coord_event  7,  2, 0, MomTrigger3

	db 4 ; bg events
	bg_event  0,  1, SIGNPOST_JUMPTEXT, FridgeText
	bg_event  1,  1, SIGNPOST_JUMPTEXT, SinkText
	bg_event  2,  1, SIGNPOST_JUMPTEXT, StoveText
	bg_event  7,  1, SIGNPOST_UP, TVScript

	db 5 ; object events
	object_event  7,  4, SPRITE_MOM, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, MomScript, EVENT_KRISS_HOUSE_MOM_1
	object_event  2,  2, SPRITE_MOM, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, (1 << MORN), 0, PERSONTYPE_SCRIPT, 0, MomScript, EVENT_KRISS_HOUSE_MOM_2
	object_event  7,  4, SPRITE_MOM, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, (1 << DAY), 0, PERSONTYPE_SCRIPT, 0, MomScript, EVENT_KRISS_HOUSE_MOM_2
	object_event  0,  2, SPRITE_MOM, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, (1 << NITE), 0, PERSONTYPE_SCRIPT, 0, MomScript, EVENT_KRISS_HOUSE_MOM_2
	object_event  4,  4, SPRITE_POKEFAN_F, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_RED, PERSONTYPE_SCRIPT, 0, NeighborScript, EVENT_KRISS_HOUSE_1F_NEIGHBOR

	const_def 1 ; object constants
	const KRISSHOUSE1F_MOM1

MomTrigger1:
	playmusic MUSIC_MOM
	showemote EMOTE_SHOCK, KRISSHOUSE1F_MOM1, 15
	turnobject KRISSHOUSE1F_MOM1, RIGHT
	turnobject PLAYER, LEFT
	jump MomEventScript

MomTrigger2:
	playmusic MUSIC_MOM
	showemote EMOTE_SHOCK, KRISSHOUSE1F_MOM1, 15
	turnobject KRISSHOUSE1F_MOM1, RIGHT
	applyonemovement PLAYER, slow_step_left
	jump MomEventScript

MomTrigger3:
	playmusic MUSIC_MOM
	showemote EMOTE_SHOCK, KRISSHOUSE1F_MOM1, 15
	turnobject KRISSHOUSE1F_MOM1, UP
	applyonemovement PLAYER, slow_step_down
MomEventScript:
	opentext
	writetext MomIntroText
	buttonsound
	stringtotext GearName, $1
	callstd receiveitem
	setflag ENGINE_POKEGEAR
	setflag ENGINE_PHONE_CARD
	addcellnum PHONE_MOM
	setscene $1
	setevent EVENT_KRISS_HOUSE_MOM_1
	clearevent EVENT_KRISS_HOUSE_MOM_2
	writetext MomPokegearText
	buttonsound
	special Special_SetDayOfWeek
.InitialSetDSTFlag:
	writetext MomDSTText
	yesorno
	iffalse .NotDST
	special Special_InitialSetDSTFlag
	yesorno
	iffalse .InitialSetDSTFlag
	jump .InitializedDSTFlag
.NotDST:
	special Special_InitialClearDSTFlag
	yesorno
	iffalse .InitialSetDSTFlag
.InitializedDSTFlag:
	writetext MomRunningShoesText
	yesorno
	iftrue .NoInstructions
	writetext MomInstructionsText
	buttonsound
.NoInstructions:
	writetext MomOutroText
	waitbutton
	closetext
	turnobject KRISSHOUSE1F_MOM1, LEFT
	special RestartMapMusic
	end

GearName:
	db "#gear@"

FridgeText:
	text "Let's see what's"
	line "in the fridge…"

	para "Fresh Water and"
	line "tasty Lemonade!"
	done

SinkText:
	text "The sink is spot-"
	line "less. Mom likes it"
	cont "clean."
	done

StoveText:
	text "Mom's specialty!"

	para "Cinnabar Volcano"
	line "Burger!"
	done

TVScript:
	thistext

	text "There's a movie on"
	line "TV: Stars dot the"

	para "sky as two boys"
	line "ride on a train…"

	para "I'd better get"
	line "rolling too!"
	done

MomScript:
	faceplayer
	checkscene
	iffalse .MomEvent
	opentext
	checkevent EVENT_FIRST_TIME_BANKING_WITH_MOM
	iftrue_jumpopenedtext MomDoItText
	checkevent EVENT_TALKED_TO_MOM_AFTER_MYSTERY_EGG_QUEST
	iftrue .BankOfMom
	checkevent EVENT_GAVE_MYSTERY_EGG_TO_ELM
	iftrue .FirstTimeBanking
	checkevent EVENT_GOT_A_POKEMON_FROM_ELM
	iftrue_jumpopenedtext MomErrandText
	thisopenedtext

	text "Prof.Elm is wait-"
	line "ing for you."

	para "Hurry up, baby!"
	done

.FirstTimeBanking:
	setevent EVENT_FIRST_TIME_BANKING_WITH_MOM
.BankOfMom:
	setevent EVENT_TALKED_TO_MOM_AFTER_MYSTERY_EGG_QUEST
	special Special_BankOfMom
	waitendtext

.MomEvent:
	playmusic MUSIC_MOM
	jump MomEventScript

MomIntroText:
if DEF(DEBUG)
	text "Don't forget to use"
	line "your debug radio!"
	done
else
	text "Oh, <PLAYER>!"
	line "You're awake."

	para "Your friend Lyra"
	line "was just here."

	para "She said that our"
	line "neighbor, Prof."

	para "Elm, was looking"
	line "for you."

	para "Oh! I almost for-"
	line "got! Your #mon"

	para "Gear is back from"
	line "the repair shop."

	para "Here you go!"
	done
endc

MomPokegearText:
	text "#mon Gear, or"
	line "just #gear."

	para "It's essential if"
	line "you want to be a"
	cont "good trainer."

	para "Oh, the day of the"
	line "week isn't set."

	para "You mustn't forget"
	line "that!"
	done

MomDSTText:
	text "Is it Daylight"
	line "Saving Time now?"
	done

MomRunningShoesText:
	text "Come home to"
	line "adjust your clock"

	para "for Daylight"
	line "Saving Time."

	para "By the way, do"
	line "you know how to"

	para "use your new"
	line "Running Shoes?"
	done

MomInstructionsText:
	text "I'll read the"
	line "instructions."

	para "Just hold down the"
	line "B Button to run,"
	cont "indoors or out."

	para "Or use the Option"
	line "to always run, and"
	cont "hold B to walk."
	done

MomOutroText:
	text "Gee, aren't they"
	line "convenient?"
	done

MomErrandText:
	text "So, what was Prof."
	line "Elm's errand?"

	para "…"

	para "That does sound"
	line "challenging."

	para "But, you should be"
	line "proud that people"
	cont "rely on you."
	done

MomDoItText:
	text "<PLAYER>, do it!"

	para "I'm behind you all"
	line "the way!"
	done

NeighborScript:
	faceplayer
	opentext
	checktime 1 << MORN
	iftrue .MornScript
	checktime 1 << DAY
	iftrue .DayScript
	checktime 1 << NITE
	iftrue .NiteScript

.MornScript:
	writetext .MornIntroText
	buttonsound
	jump .Main

.DayScript:
	writetext .DayIntroText
	buttonsound
	jump .Main

.NiteScript:
	writetext .NiteIntroText
	buttonsound
	jump .Main

.Main:
	writetext .NeighborText
	waitbutton
	closetext
	turnobject LAST_TALKED, RIGHT
	end

.MornIntroText:
	text "Good morning,"
	line "<PLAYER>!"

	para "I'm visiting!"
	done

.DayIntroText:
	text "Hello, <PLAYER>!"
	line "I'm visiting!"
	done

.NiteIntroText:
	text "Good evening,"
	line "<PLAYER>!"

	para "I'm visiting!"
	done

.NeighborText:
	text "<PLAYER>, have you"
	line "heard?"

	para "My daughter is"
	line "adamant about"

	para "becoming Prof."
	line "Elm's assistant."

	para "She really loves"
	line "#mon!"
	done
