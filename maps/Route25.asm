const_value set 2
	const ROUTE25_YOUNGSTER1
	const ROUTE25_LASS1
	const ROUTE25_YOUNGSTER2
	const ROUTE25_LASS2
	const ROUTE25_YOUNGSTER3
	const ROUTE25_LASS3
	const ROUTE25_SUPER_NERD
	const ROUTE25_POKE_BALL
	const ROUTE25_CUT_TREE
	const ROUTE25_YOUNGSTER4
	const ROUTE25_SLOWPOKE
	const ROUTE25_COOLTRAINER_M

Route25_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

TrainerSchoolboyDudley:
	trainer EVENT_BEAT_SCHOOLBOY_DUDLEY, SCHOOLBOY, DUDLEY, SchoolboyDudleySeenText, SchoolboyDudleyBeatenText, 0, SchoolboyDudleyScript

SchoolboyDudleyScript:
	end_if_just_battled
	opentext
	writetext UnknownText_0x19f1b5
	waitbutton
	closetext
	end

TrainerLassEllen:
	trainer EVENT_BEAT_LASS_ELLEN, LASS, ELLEN, LassEllenSeenText, LassEllenBeatenText, 0, LassEllenScript

LassEllenScript:
	end_if_just_battled
	opentext
	writetext UnknownText_0x19f208
	waitbutton
	closetext
	end

TrainerSchoolboyJoe:
	trainer EVENT_BEAT_SCHOOLBOY_JOE, SCHOOLBOY, JOE, SchoolboyJoeSeenText, SchoolboyJoeBeatenText, 0, SchoolboyJoeScript

SchoolboyJoeScript:
	end_if_just_battled
	opentext
	writetext UnknownText_0x19f25c
	waitbutton
	closetext
	end

TrainerLassLaura:
	trainer EVENT_BEAT_LASS_LAURA, LASS, LAURA, LassLauraSeenText, LassLauraBeatenText, 0, LassLauraScript

LassLauraScript:
	end_if_just_battled
	opentext
	writetext UnknownText_0x19f2a6
	waitbutton
	closetext
	end

TrainerCamperLloyd:
	trainer EVENT_BEAT_CAMPER_LLOYD, CAMPER, LLOYD, CamperLloydSeenText, CamperLloydBeatenText, 0, CamperLloydScript

CamperLloydScript:
	end_if_just_battled
	opentext
	writetext UnknownText_0x19f2f8
	waitbutton
	closetext
	end

TrainerLassShannon:
	trainer EVENT_BEAT_LASS_SHANNON, LASS, SHANNON, LassShannonSeenText, LassShannonBeatenText, 0, LassShannonScript

LassShannonScript:
	end_if_just_battled
	opentext
	writetext UnknownText_0x19f35b
	waitbutton
	closetext
	end

TrainerSupernerdPat:
	trainer EVENT_BEAT_SUPER_NERD_PAT, SUPER_NERD, PAT, SupernerdPatSeenText, SupernerdPatBeatenText, 0, SupernerdPatScript

SupernerdPatScript:
	end_if_just_battled
	opentext
	writetext UnknownText_0x19f41a
	waitbutton
	closetext
	end

Route25MewYoungsterScript:
	jumptextfaceplayer Route25MewYoungsterText

Route25SlowpokeScript:
	opentext
	writetext Route25SlowpokeText1
	pause 60
	writetext Route25SlowpokeText2
	cry SLOWPOKE
	waitbutton
	closetext
	end

Route25CutTree:
	jumpstd cuttree

Route25Protein:
	itemball PROTEIN

Route25HiddenPotion:
	dwb EVENT_ROUTE_25_HIDDEN_POTION, POTION

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

UnknownText_0x19f1b5:
	text "I did my best."
	line "I have no regrets."
	done

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

Route25_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 0

.XYTriggers:
	db 0

.Signposts:
	db 1
	signpost 5, 4, SIGNPOST_ITEM, Route25HiddenPotion

.PersonEvents:
	db 12
	person_event SPRITE_YOUNGSTER, 8, 14, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_TRAINER, 3, TrainerSchoolboyDudley, -1
	person_event SPRITE_LASS, 11, 20, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_TRAINER, 3, TrainerLassEllen, -1
	person_event SPRITE_YOUNGSTER, 8, 27, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_TRAINER, 1, TrainerSchoolboyJoe, -1
	person_event SPRITE_LASS, 6, 28, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_TRAINER, 3, TrainerLassLaura, -1
	person_event SPRITE_YOUNGSTER, 9, 34, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_TRAINER, 3, TrainerCamperLloyd, -1
	person_event SPRITE_LASS, 11, 38, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_TRAINER, 1, TrainerLassShannon, -1
	person_event SPRITE_SUPER_NERD, 7, 41, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_TRAINER, 1, TrainerSupernerdPat, -1
	person_event SPRITE_POKE_BALL, 4, 42, SPRITEMOVEDATA_ITEM_TREE, 0, 0, -1, -1, 0, PERSONTYPE_ITEMBALL, 0, Route25Protein, EVENT_ROUTE_25_PROTEIN
	person_event SPRITE_CUT_TREE, 6, 44, SPRITEMOVEDATA_CUTTABLE_TREE, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, Route25CutTree, EVENT_ROUTE_25_CUT_TREE
	person_event SPRITE_YOUNGSTER, 4, 36, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, Route25MewYoungsterScript, -1
	person_event SPRITE_SLOWPOKE, 4, 37, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, Route25SlowpokeScript, -1
	person_event SPRITE_COOLTRAINER_M, 8, 47, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, ObjectEvent, -1
