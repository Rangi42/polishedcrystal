PlayersHouse1F_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  2,  7, HOLLOWPORT, 1
	warp_event  3,  7, HOLLOWPORT, 1
	warp_event  0,  0, PLAYERS_HOUSE_2F, 1

	def_coord_events
	coord_event  0,  2, 0, MotherTrigger1
	coord_event  1,  1, 0, MotherTrigger2
	coord_event  3,  2, 0, SisTrigger

	def_bg_events
	bg_event  6,  1, BGEVENT_JUMPTEXT, PlayerHouse1FFridgeText
	bg_event  7,  1, BGEVENT_JUMPTEXT, PlayerHouse1FSinkText
	bg_event  8,  1, BGEVENT_JUMPTEXT, PlayerHouse1FStoveText
	bg_event  3,  1, BGEVENT_UP, PlayerHouse1FTVScript

	def_object_events
	object_event  2,  5, SPRITE_MOM, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, 0, OBJECTTYPE_SCRIPT, 0, MotherScript, EVENT_PLAYERS_HOUSE_MOTHER
	object_event  3,  3, SPRITE_LASS, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, SisTrigger, EVENT_PLAYERS_SISTER
	object_event  8,  3, SPRITE_DAD, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, DadText, -1

	pokemon_event  3,  5, MEOWTH, SPRITEMOVEDATA_POKEMON, -1, PAL_NPC_BROWN, HomeMeowthText, -1


	object_const_def
	const PLAYERSHOUSE1F_MOTHER
	const PLAYERSHOUSE1F_SISTER

MotherTrigger1:
	playmusic MUSIC_MOM
	showemote EMOTE_SHOCK, PLAYERSHOUSE1F_MOTHER, 15
	turnobject PLAYERSHOUSE1F_MOTHER, LEFT
	applymovement PLAYERSHOUSE1F_MOTHER, .mom_steps_1
	turnobject PLAYERSHOUSE1F_MOTHER, LEFT
	turnobject PLAYER, RIGHT
	sjumpfwd MotherEventScript

.mom_steps_1
	step_left
	step_up
	step_up
	step_up
	step_end

MotherTrigger2:
	playmusic MUSIC_MOM
	showemote EMOTE_SHOCK, PLAYERSHOUSE1F_MOTHER, 15
	turnobject PLAYERSHOUSE1F_MOTHER, LEFT
	applymovement PLAYERSHOUSE1F_MOTHER, .mom_steps_2
	turnobject PLAYER, DOWN
	sjumpfwd MotherEventScript

  .mom_steps_2
	step_left
	step_up
	step_up
	step_up
	step_end

MotherEventScript:
	opentext
	writetext MotherIntroText
	promptbutton
	givespecialitem POKEGEAR 
	setflag ENGINE_POKEGEAR
	setflag ENGINE_PHONE_CARD
	addcellnum PHONE_MOM
	setscene $1
	setevent EVENT_PLAYERS_HOUSE_MOTHER
	clearevent EVENT_PLAYERS_HOUSE_MOM_2
	writetext MotherPokegearText
	promptbutton
	special Special_SetDayOfWeek
.InitialSetDSTFlag:
	writetext MotherDSTText
	yesorno
	iffalsefwd .NotDST
	special Special_InitialSetDSTFlag
	yesorno
	iffalse .InitialSetDSTFlag
	sjumpfwd .InitializedDSTFlag
.NotDST:
	special Special_InitialClearDSTFlag
	yesorno
	iffalse .InitialSetDSTFlag
.InitializedDSTFlag:
	writetext MotherRunningShoesText
	yesorno
	iftruefwd .NoInstructions
	writetext MotherInstructionsText
	promptbutton
.NoInstructions:
	writetext MotherOutroText
	waitbutton
	closetext
	turnobject PLAYERSHOUSE1F_MOTHER, DOWN
	applymovement PLAYERSHOUSE1F_MOTHER, .mom_steps_3
	special RestartMapMusic
	end

.mom_steps_3
	step_down
	step_down
	step_down
	step_right
	step_end


SisTrigger:
	playmusic MUSIC_RIVAL_ENCOUNTER
	showemote EMOTE_SHOCK, PLAYERSHOUSE1F_SISTER, 15
	turnobject PLAYER, DOWN
	showtext SisterTVText
	applyonemovement PLAYER, step_left
	special RestartMapMusic
	end

PlayerHouse1FFridgeText:
	text "Let's see what's"
	line "in the fridge…"

	para "Sweet Tea and"
	line "tasty Lemonade!"
	done

PlayerHouse1FSinkText:
	text "Ugh, I hate"
	line "washing dishes"
	done

PlayerHouse1FStoveText:
	text "Mom's specialty!"

	para "Combusken &"
	line "Dumplins!"
	done

PlayerHouse1FTVScript:
	jumpthistext

	text "There's a show on"
	line "TV: An armor clad"

	para "knight rides a"
	line "Charizard into bat-"

	para "tle. I'd better go"
	line "before I get"
	cont "sucked in!"
	done

SisterTVText:
	text "HEY!"

	para "Move! I'm watching"
	line "this!"
	done


MotherScript:
	faceplayer
	checkscene
	iffalsefwd .MotherEvent
	opentext
	checkevent EVENT_PLAYERS_HOUSE_MOTHER
	iftrue_jumpopenedtext MotherDoItText
	checkevent EVENT_GOT_A_POKEMON_FROM_ELM
	iftrue_jumpopenedtext MotherErrandText
end

.MotherEvent:
	playmusic MUSIC_MOM
	sjump MotherEventScript

MotherIntroText:
; if DEF(DEBUG)
; 	text "Don't forget to use"
; 	line "your debug radio!"
; 	done
; else
	text "Oh, <PLAYER>!"
	line "You're awake."

	para "Your friend"
	line "was just here."

	para "They said some-"
	line "thing about"

	para "a professor"
	line "setting up a"

	para "a lab in town?"
	line "I hope they"

	para "don't cause"
	line "any ruckus."

	para "Oh! I almost"
	line "forgot! Your dad"

	para "fixed your"
	line "#gear!"
	cont "Here ya go!"
	done
end

MotherPokegearText:
	text "#mon Gear, or"
	line "just #gear."

	para "I'm sorry it's"
	line "secondhand,"
	cont "honey..."

	para "Oh, the day of the"
	line "week isn't set."

	para "Go ahead and"
	line "do that now."
	done

MotherDSTText:
	text "Is it Daylight"
	line "Saving Time now?"
	done

MotherRunningShoesText:
	text "Come home to"
	line "adjust your clock"

	para "for Daylight"
	line "Saving Time."

	para "By the way, do"
	line "you know how to"

	para "use your new"
	line "Running Shoes?"
	done

MotherInstructionsText:
	para "Just hold down the"
	line "B Button to run,"
	cont "indoors or out."

	para "Or use the Option"
	line "to always run, and"
	cont "hold B to walk."
	done

MotherOutroText:
	text "Back in my day,"
	line "we didn't even"

	para "have running"
	line "shoes!"

	done

MotherErrandText:
	text "So, what was up"
	line "with the"
	cont "professor?"

	para "…"

	para "Oh my, that"
	line "is quite the."
	cont "proposition!"

	para "That's my"
	line "kiddo!"
	cont "I'm so proud!"
	done

MotherDoItText:
	text "<PLAYER>, go on!"

	para "Go see what your"
	line "friend is up to!"
	done

DadText:
	text "<PLAYER>, have you"
	line "heard?"

	para "The academy"
	line "a town over"

	para "sent a #mon"
	line "Professor"

	para "I wonder what"
	line "they're study-"
	cont "ing here."
	done

	HomeMeowthText:
	text "Meowster: Mrrow?"
	done
