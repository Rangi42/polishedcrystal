const_value set 2
	const KRISSHOUSE1F_MOM1
	const KRISSHOUSE1F_MOM2
	const KRISSHOUSE1F_MOM3
	const KRISSHOUSE1F_MOM4
	const KRISSHOUSE1F_POKEFAN_F

KrissHouse1F_MapScriptHeader:
.MapTriggers:
	db 2

	; triggers
	dw .Trigger0, 0
	dw .Trigger1, 0

.MapCallbacks:
	db 0

.Trigger0:
	end

.Trigger1:
	end

MomTrigger1:
	playmusic MUSIC_MOM
	showemote EMOTE_SHOCK, KRISSHOUSE1F_MOM1, 15
	spriteface KRISSHOUSE1F_MOM1, RIGHT
	spriteface PLAYER, LEFT
	jump MomEventScript

MomTrigger2:
	playmusic MUSIC_MOM
	showemote EMOTE_SHOCK, KRISSHOUSE1F_MOM1, 15
	spriteface KRISSHOUSE1F_MOM1, RIGHT
	applymovement PLAYER, KrissHouse1FSlowStepLeftMovementData
	jump MomEventScript

MomTrigger3:
	playmusic MUSIC_MOM
	showemote EMOTE_SHOCK, KRISSHOUSE1F_MOM1, 15
	spriteface KRISSHOUSE1F_MOM1, UP
	applymovement PLAYER, KrissHouse1FSlowStepDownMovementData
MomEventScript:
	opentext
	writetext MomIntroText
	buttonsound
	stringtotext GearName, $1
	callstd receiveitem
	setflag ENGINE_POKEGEAR
	setflag ENGINE_PHONE_CARD
	addcellnum PHONE_MOM
	dotrigger $1
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
	spriteface KRISSHOUSE1F_MOM1, LEFT
	special RestartMapMusic
	end

GearName:
	db "#gear@"

MomScript:
	faceplayer
	checktriggers
	iffalse .MomEvent
	opentext
	checkevent EVENT_FIRST_TIME_BANKING_WITH_MOM
	iftrue .DoIt
	checkevent EVENT_TALKED_TO_MOM_AFTER_MYSTERY_EGG_QUEST
	iftrue .BankOfMom
	checkevent EVENT_GAVE_MYSTERY_EGG_TO_ELM
	iftrue .FirstTimeBanking
	checkevent EVENT_GOT_A_POKEMON_FROM_ELM
	iftrue .Errand
	writetext MomHurryUpText
	waitbutton
	closetext
	end

.Errand:
	writetext MomErrandText
	waitbutton
	closetext
	end

.DoIt:
	writetext MomDoItText
	waitbutton
	closetext
	end

.FirstTimeBanking:
	setevent EVENT_FIRST_TIME_BANKING_WITH_MOM
.BankOfMom:
	setevent EVENT_TALKED_TO_MOM_AFTER_MYSTERY_EGG_QUEST
	special Special_BankOfMom
	waitbutton
	closetext
	end

.MomEvent:
	playmusic MUSIC_MOM
	jump MomEventScript

NeighborScript:
	faceplayer
	opentext
	checkmorn
	iftrue .MornScript
	checkday
	iftrue .DayScript
	checknite
	iftrue .NiteScript

.MornScript:
	writetext NeighborMornIntroText
	buttonsound
	jump .Main

.DayScript:
	writetext NeighborDayIntroText
	buttonsound
	jump .Main

.NiteScript:
	writetext NeighborNiteIntroText
	buttonsound
	jump .Main

.Main:
	writetext NeighborText
	waitbutton
	closetext
	spriteface KRISSHOUSE1F_POKEFAN_F, RIGHT
	end

FridgeScript:
	jumptext FridgeText

SinkScript:
	jumptext SinkText

StoveScript:
	jumptext StoveText

TVScript:
	jumptext TVText

MovementData_0x7a5fc:
	turn_head_right
	step_end

MovementData_0x7a5fe:
	slow_step_right
	step_end

MovementData_0x7a600:
	turn_head_left
	step_end

KrissHouse1FSlowStepLeftMovementData:
	slow_step_left
	step_end

KrissHouse1FSlowStepDownMovementData:
	slow_step_down
	step_end

MomIntroText:
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

MomHurryUpText:
	text "Prof.Elm is wait-"
	line "ing for you."

	para "Hurry up, baby!"
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

NeighborMornIntroText:
	text "Good morning,"
	line "<PLAYER>!"

	para "I'm visiting!"
	done

NeighborDayIntroText:
	text "Hello, <PLAYER>!"
	line "I'm visiting!"
	done

NeighborNiteIntroText:
	text "Good evening,"
	line "<PLAYER>!"

	para "I'm visiting!"
	done

NeighborText:
	text "<PLAYER>, have you"
	line "heard?"

	para "My daughter is"
	line "adamant about"

	para "becoming Prof."
	line "Elm's assistant."

	para "She really loves"
	line "#mon!"
	done

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

TVText:
	text "There's a movie on"
	line "TV: Stars dot the"

	para "sky as two boys"
	line "ride on a train…"

	para "I'd better get"
	line "rolling too!"
	done

KrissHouse1F_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 3
	warp_def $7, $6, 2, NEW_BARK_TOWN
	warp_def $7, $7, 2, NEW_BARK_TOWN
	warp_def $0, $9, 1, KRISS_HOUSE_2F

.XYTriggers:
	db 3
	xy_trigger 0, $4, $8, $0, MomTrigger1, $0, $0
	xy_trigger 0, $4, $9, $0, MomTrigger2, $0, $0
	xy_trigger 0, $2, $7, $0, MomTrigger3, $0, $0

.Signposts:
	db 4
	signpost 1, 0, SIGNPOST_READ, FridgeScript
	signpost 1, 1, SIGNPOST_READ, SinkScript
	signpost 1, 2, SIGNPOST_READ, StoveScript
	signpost 1, 7, SIGNPOST_READ, TVScript

.PersonEvents:
	db 5
	person_event SPRITE_MOM, 4, 7, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, MomScript, EVENT_KRISS_HOUSE_MOM_1
	person_event SPRITE_MOM, 2, 2, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, (1 << MORN), 0, PERSONTYPE_SCRIPT, 0, MomScript, EVENT_KRISS_HOUSE_MOM_2
	person_event SPRITE_MOM, 4, 7, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, (1 << DAY), 0, PERSONTYPE_SCRIPT, 0, MomScript, EVENT_KRISS_HOUSE_MOM_2
	person_event SPRITE_MOM, 2, 0, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, (1 << NITE), 0, PERSONTYPE_SCRIPT, 0, MomScript, EVENT_KRISS_HOUSE_MOM_2
	person_event SPRITE_POKEFAN_F, 4, 4, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, NeighborScript, EVENT_KRISS_HOUSE_1F_NEIGHBOR
