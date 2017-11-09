Route25_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

Route25_MapEventHeader:

.Warps: db 0

.XYTriggers: db 0

.Signposts: db 0

.PersonEvents: db 12
	person_event SPRITE_YOUNGSTER, 11, 7, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_TRAINER, 3, TrainerSchoolboyDudley, -1
	person_event SPRITE_LASS, 8, 11, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_TRAINER, 1, TrainerLassEllen, -1
	person_event SPRITE_YOUNGSTER, 10, 14, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_TRAINER, 1, TrainerSchoolboyJoe, -1
	person_event SPRITE_LASS, 6, 12, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_TRAINER, 3, TrainerLassLaura, -1
	person_event SPRITE_YOUNGSTER, 9, 18, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_TRAINER, 3, TrainerCamperLloyd, -1
	person_event SPRITE_LASS, 11, 22, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_TRAINER, 1, TrainerLassShannon, -1
	person_event SPRITE_SUPER_NERD, 7, 25, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_TRAINER, 1, TrainerSupernerdPat, -1
	itemball_event 4, 25, PROTEIN, 1, EVENT_ROUTE_25_PROTEIN
	cuttree_event 6, 28, EVENT_ROUTE_25_CUT_TREE
	person_event SPRITE_YOUNGSTER, 4, 20, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_COMMAND, jumptextfaceplayer, Route25MewYoungsterText, -1
	person_event SPRITE_SLOWPOKE, 4, 21, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, Route25SlowpokeScript, -1
	person_event SPRITE_COOLTRAINER_M, 8, 30, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, CooltrainerMScript_0x19efac, -1

TrainerLassEllen:
	trainer EVENT_BEAT_LASS_ELLEN, LASS, ELLEN, LassEllenSeenText, LassEllenBeatenText, 0, LassEllenScript

LassEllenScript:
	end_if_just_battled
	jumptextfaceplayer UnknownText_0x19f208

TrainerSchoolboyJoe:
	trainer EVENT_BEAT_SCHOOLBOY_JOE, SCHOOLBOY, JOE, SchoolboyJoeSeenText, SchoolboyJoeBeatenText, 0, SchoolboyJoeScript

SchoolboyJoeScript:
	end_if_just_battled
	jumptextfaceplayer UnknownText_0x19f25c

TrainerLassLaura:
	trainer EVENT_BEAT_LASS_LAURA, LASS, LAURA, LassLauraSeenText, LassLauraBeatenText, 0, LassLauraScript

LassLauraScript:
	end_if_just_battled
	jumptextfaceplayer UnknownText_0x19f2a6

TrainerCamperLloyd:
	trainer EVENT_BEAT_CAMPER_LLOYD, CAMPER, LLOYD, CamperLloydSeenText, CamperLloydBeatenText, 0, CamperLloydScript

CamperLloydScript:
	end_if_just_battled
	jumptextfaceplayer UnknownText_0x19f2f8

TrainerLassShannon:
	trainer EVENT_BEAT_LASS_SHANNON, LASS, SHANNON, LassShannonSeenText, LassShannonBeatenText, 0, LassShannonScript

LassShannonScript:
	end_if_just_battled
	jumptextfaceplayer UnknownText_0x19f35b

TrainerSupernerdPat:
	trainer EVENT_BEAT_SUPER_NERD_PAT, SUPER_NERD, PAT, SupernerdPatSeenText, SupernerdPatBeatenText, 0, SupernerdPatScript

SupernerdPatScript:
	end_if_just_battled
	jumptextfaceplayer UnknownText_0x19f41a

Route25SlowpokeScript:
	opentext
	writetext Route25SlowpokeText1
	pause 60
	writetext Route25SlowpokeText2
	cry SLOWPOKE
	waitendtext

CooltrainerMScript_0x19efac:
	checkevent EVENT_BEAT_COOLTRAINERM_KEVIN
	iftrue_jumptextfaceplayer UnknownText_0x19f520
	faceplayer
	opentext
	checkevent EVENT_CLEARED_NUGGET_BRIDGE
	iftrue UnknownScript_0x19efc7
	writetext UnknownText_0x19f43b
	buttonsound
	verbosegiveitem NUGGET
	iffalse_endtext
	setevent EVENT_CLEARED_NUGGET_BRIDGE
UnknownScript_0x19efc7:
	writetext UnknownText_0x19f49d
	waitbutton
	closetext
	winlosstext UnknownText_0x19f4fd, 0
	loadtrainer COOLTRAINERM, KEVIN
	startbattle
	reloadmapafterbattle
	setevent EVENT_BEAT_COOLTRAINERM_KEVIN
	jumptext UnknownText_0x19f520

LassEllenSeenText:
	text "I'm second."
	line "Now it's serious!"
	done

LassEllenBeatenText:
	text "How could I lose?"
	done

UnknownText_0x19f208:
	text "I did my best."
	line "I have no regrets."
	done

SchoolboyJoeSeenText:
	text "Here's No. 3!"
	line "I won't be easy."
	done

SchoolboyJoeBeatenText:
	text "Ow! Stomped flat!"
	done

UnknownText_0x19f25c:
	text "I did my best."
	line "I have no regrets."
	done

LassLauraSeenText:
	text "I'm No. 4!"
	line "Getting tired?"
	done

LassLauraBeatenText:
	text "I lost too…"
	done

UnknownText_0x19f2a6:
	text "I did my best."
	line "I have no regrets."
	done

CamperLloydSeenText:
	text "OK! I'm No. 5."
	line "I'll stomp you!"
	done

CamperLloydBeatenText:
	text "Whoa! Too much."
	done

UnknownText_0x19f2f8:
	text "I did my best."
	line "I have no regrets."
	done

LassShannonSeenText:
	text "I'm the last in"
	line "line, but I tell"
	cont "you, I'm tough!"
	done

LassShannonBeatenText:
	text "You're kidding."
	done

UnknownText_0x19f35b:
	text "I did my best."
	line "I have no regrets."
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

UnknownText_0x19f41a:
	text "I'm sorry… I won't"
	line "cheat anymore…"
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

UnknownText_0x19f43b:
	text "You took on one"
	line "more battle than"

	para "you expected, but"
	line "you won anyway."

	para "As promised, you"
	line "win a prize."
	done

UnknownText_0x19f49d:
	text "But after seeing"
	line "how you battle, I"

	para "want to see how"
	line "I'll fare."

	para "How about it? Let"
	line "me take you on."
	done

UnknownText_0x19f4fd:
	text "I've never had a"
	line "battle this good!"
	done

UnknownText_0x19f520:
	text "That was a great"
	line "battle!"

	para "You and your #-"
	line "mon are truly out-"
	cont "standing!"
	done
