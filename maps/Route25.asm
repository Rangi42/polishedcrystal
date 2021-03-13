Route25_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events

	def_coord_events

	def_bg_events

	def_object_events
	object_event 30,  8, SPRITE_ACE_TRAINER_M, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, TrainerCooltrainermKevin, EVENT_ROUTE_25_COOLTRAINER_M_BEFORE
	object_event 32,  8, SPRITE_ACE_TRAINER_M, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, CooltrainermKevinAfterBattleText, EVENT_ROUTE_25_COOLTRAINER_M_AFTER
	object_event  7, 11, SPRITE_SCHOOLBOY, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerSchoolboyDudley, -1
	object_event 11,  8, SPRITE_LASS, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 1, GenericTrainerLassEllen, -1
	object_event 14, 10, SPRITE_SCHOOLBOY, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 1, GenericTrainerSchoolboyJoe, -1
	object_event 12,  6, SPRITE_LASS, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerLassLaura, -1
	object_event 18,  9, SPRITE_CAMPER, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerCamperLloyd, -1
	object_event 22, 11, SPRITE_LASS, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 1, GenericTrainerLassShannon, -1
	object_event 25,  7, SPRITE_SUPER_NERD, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 1, GenericTrainerSupernerdPat, -1
	itemball_event 25,  4, PROTEIN, 1, EVENT_ROUTE_25_PROTEIN
	cuttree_event 28,  6, EVENT_ROUTE_25_CUT_TREE
	object_event 20,  4, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, Route25MewYoungsterText, -1
	object_event 21,  4, SPRITE_MON_ICON, SPRITEMOVEDATA_POKEMON, 0, SLOWPOKE, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, Route25SlowpokeScript, -1

	object_const_def
	const ROUTE25_COOLTRAINERM_BEFORE
	const ROUTE25_COOLTRAINERM_AFTER

GenericTrainerSchoolboyDudley:
	generictrainer SCHOOLBOY, DUDLEY, EVENT_BEAT_SCHOOLBOY_DUDLEY, SchoolboyDudleySeenText, SchoolboyDudleyBeatenText

	text "I did my best."
	line "I have no regrets."
	done

GenericTrainerLassEllen:
	generictrainer LASS, ELLEN, EVENT_BEAT_LASS_ELLEN, LassEllenSeenText, LassEllenBeatenText

	text "I did my best."
	line "I have no regrets."
	done

GenericTrainerSchoolboyJoe:
	generictrainer SCHOOLBOY, JOE, EVENT_BEAT_SCHOOLBOY_JOE, SchoolboyJoeSeenText, SchoolboyJoeBeatenText

	text "I did my best."
	line "I have no regrets."
	done

GenericTrainerLassLaura:
	generictrainer LASS, LAURA, EVENT_BEAT_LASS_LAURA, LassLauraSeenText, LassLauraBeatenText

	text "I did my best."
	line "I have no regrets."
	done

GenericTrainerCamperLloyd:
	generictrainer CAMPER, LLOYD, EVENT_BEAT_CAMPER_LLOYD, CamperLloydSeenText, CamperLloydBeatenText

	text "I did my best."
	line "I have no regrets."
	done

GenericTrainerLassShannon:
	generictrainer LASS, SHANNON, EVENT_BEAT_LASS_SHANNON, LassShannonSeenText, LassShannonBeatenText

	text "I did my best."
	line "I have no regrets."
	done

GenericTrainerSupernerdPat:
	generictrainer SUPER_NERD, PAT, EVENT_BEAT_SUPER_NERD_PAT, SupernerdPatSeenText, SupernerdPatBeatenText

	text "I'm sorry… I won't"
	line "cheat anymore…"
	done

Route25SlowpokeScript:
	opentext
	writetext Route25SlowpokeText1
	pause 60
	writetext Route25SlowpokeText2
	cry SLOWPOKE
	waitendtext

TrainerCooltrainermKevin:
	checkevent EVENT_BEAT_SUPER_NERD_PAT
	iffalse_jumptextfaceplayer NuggetBridgeNotClearedText
	faceplayer
	opentext
	checkevent EVENT_CLEARED_NUGGET_BRIDGE
	iftrue .AfterNuggetBridge
	writetext CooltrainermKevinNuggetText
	promptbutton
	verbosegiveitem NUGGET
	iffalse_endtext
	setevent EVENT_CLEARED_NUGGET_BRIDGE
.AfterNuggetBridge:
	writetext CooltrainermKevinSeenText
	waitbutton
	closetext
	follow ROUTE25_COOLTRAINERM_BEFORE, PLAYER
	applymovement ROUTE25_COOLTRAINERM_BEFORE, Route25CooltrainerMovementData
	stopfollow
	turnobject ROUTE25_COOLTRAINERM_BEFORE, LEFT
	winlosstext CooltrainermKevinBeatenText, 0
	loadtrainer COOLTRAINERM, KEVIN
	startbattle
	disappear ROUTE25_COOLTRAINERM_BEFORE
	appear ROUTE25_COOLTRAINERM_AFTER
	reloadmapafterbattle
	setevent EVENT_BEAT_COOLTRAINERM_KEVIN
	jumptext CooltrainermKevinAfterBattleText

Route25CooltrainerMovementData:
	step_right
	step_right
	step_end

SchoolboyDudleySeenText:
	text "Beat the six of us"
	line "trainers to win a"
	cont "fabulous prize!"

	para "Think you've got"
	line "what it takes?"
	done

SchoolboyDudleyBeatenText:
	text "Whoo! Good stuff."
	done

LassEllenSeenText:
	text "I'm second."
	line "Now it's serious!"
	done

LassEllenBeatenText:
	text "How could I lose?"
	done

SchoolboyJoeSeenText:
	text "Here's No. 3!"
	line "I won't be easy."
	done

SchoolboyJoeBeatenText:
	text "Ow! Stomped flat!"
	done

LassLauraSeenText:
	text "I'm No. 4!"
	line "Getting tired?"
	done

LassLauraBeatenText:
	text "I lost too…"
	done

CamperLloydSeenText:
	text "OK! I'm No. 5."
	line "I'll stomp you!"
	done

CamperLloydBeatenText:
	text "Whoa! Too much."
	done

LassShannonSeenText:
	text "I'm the last in"
	line "line, but I tell"
	cont "you, I'm tough!"
	done

LassShannonBeatenText:
	text "You're kidding."
	done

SupernerdPatSeenText:
	text "Mufufufu…"

	para "I have nothing to"
	line "do with the six-"
	cont "pack trainers."

	para "I waited here to"
	line "beat you when you"

	para "were tired out by"
	line "all the battles."
	done

SupernerdPatBeatenText:
	text "Aren't you tired"
	line "at all?"
	done

Route25MewYoungsterText:
	text "One time I saw a"
	line "Mew around here!"

	para "You don't believe"
	line "me? Slowpoke saw"
	cont "it too!"
	done

Route25SlowpokeText1:
	text "Slowpoke: …"

	para "…… …… ……"
	done

Route25SlowpokeText2:
	text "…… ……Yawn?"
	done

CooltrainermKevinNuggetText:
	text "You took on one"
	line "more battle than"

	para "you expected, but"
	line "you won anyway."

	para "As promised, you"
	line "win a prize."
	done

CooltrainermKevinSeenText:
	text "But after seeing"
	line "how you battle, I"

	para "want to see how"
	line "I'll fare."

	para "How about it? Let"
	line "me take you on."
	done

CooltrainermKevinBeatenText:
	text "I've never had a"
	line "battle this good!"
	done

CooltrainermKevinAfterBattleText:
	text "That was a great"
	line "battle!"

	para "You and your #-"
	line "mon are truly out-"
	cont "standing!"
	done

NuggetBridgeNotClearedText:
	text "Hey there!"

	para "Six trainers and"
	line "I are hosting a"

	para "battle challenge"
	line "on this route."

	para "You can't skip"
	line "ahead of them!"

	para "There's a shortcut"
	line "just below us back"
	cont "to Route 24."
	done
