Route1_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event 10,  1, ROUTE_1_VIRIDIAN_GATE, 3

	def_coord_events

	def_bg_events
	bg_event  9, 27, BGEVENT_JUMPTEXT, Route1SignText

	def_object_events
	object_event  6, 12, SPRITE_SCHOOLBOY, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerSchoolboyDanny, -1
	object_event 17, 14, SPRITE_SCHOOLBOY, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerSchoolboySherman, -1
	object_event 16, 21, SPRITE_ACE_TRAINER_M, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 2, GenericTrainerCooltrainermFrench, -1
	object_event 11, 25, SPRITE_ACE_TRAINER_F, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 2, GenericTrainerCooltrainerfQuinn, -1
	fruittree_event  5,  7, FRUITTREE_ROUTE_1, FIGY_BERRY, PAL_NPC_BROWN

GenericTrainerSchoolboyDanny:
	generictrainer SCHOOLBOY, DANNY, EVENT_BEAT_SCHOOLBOY_DANNY, SchoolboyDannySeenText, SchoolboyDannyBeatenText

	ctxt "For trainers, it's"
	line "a given that we'll"

	para "battle whenever we"
	line "meet."
	done

GenericTrainerSchoolboySherman:
	generictrainer SCHOOLBOY, SHERMAN, EVENT_BEAT_SCHOOLBOY_SHERMAN, SchoolboyShermanSeenText, SchoolboyShermanBeatenText

	ctxt "I should record"
	line "all of today's"
	cont "mistakes."
	done

GenericTrainerCooltrainermFrench:
	generictrainer COOLTRAINERM, FRENCH, EVENT_BEAT_COOLTRAINERM_FRENCH, CooltrainermFrenchSeenText, CooltrainermFrenchBeatenText

	ctxt "That was a great"
	line "fight!"
	cont "Don't you agree?"
	done

GenericTrainerCooltrainerfQuinn:
	generictrainer COOLTRAINERF, QUINN, EVENT_BEAT_COOLTRAINERF_QUINN, CooltrainerfQuinnSeenText, CooltrainerfQuinnBeatenText

	ctxt "You're strong."

	para "You obviously must"
	line "have trained hard."
	done

SchoolboyDannySeenText:
	ctxt "If trainers meet,"
	line "the first thing to"
	cont "do is battle."
	done

SchoolboyDannyBeatenText:
	ctxt "Awww… I've got a"
	line "losing record…"
	done

SchoolboyShermanSeenText:
	ctxt "Right after class,"
	line "I head outside to"
	cont "practice!"
	done

SchoolboyShermanBeatenText:
	ctxt "I need to follow"
	line "the textbook."
	done

CooltrainermFrenchSeenText:
	ctxt "You!"

	para "I've been waiting"
	line "for someone like"
	cont "you!"
	done

CooltrainermFrenchBeatenText:
	ctxt "Yep, as strong as"
	line "expected!"
	done

CooltrainerfQuinnSeenText:
	ctxt "You there!"
	line "Want to battle?"
	done

CooltrainerfQuinnBeatenText:
	ctxt "Down and out…"
	done

Route1SignText:
	ctxt "Route 1"

	para "Pallet Town -"
	line "Viridian City"
	done
