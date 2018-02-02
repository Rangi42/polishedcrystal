Route10South_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 1 ; warp events
	warp_event  6,  3, ROCK_TUNNEL_1F, 2

	db 0 ; coord events

	db 2 ; bg events
	bg_event  5,  5, SIGNPOST_JUMPTEXT, Route10SignText
	bg_event 16,  3, SIGNPOST_ITEM + MAX_ETHER, EVENT_ROUTE_10_HIDDEN_MAX_ETHER

	db 4 ; object events
	object_event 17,  5, SPRITE_POKEFAN_M, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_TRAINER, 3, TrainerHikerJim, -1
	object_event  4,  7, SPRITE_POKEFAN_M, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_TRAINER, 4, TrainerPokefanmRobert, -1
	object_event  8, 12, SPRITE_HEX_MANIAC, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_PURPLE, PERSONTYPE_TRAINER, 4, TrainerHexManiacAmy, -1
	tmhmball_event  9,  7, TM_VOLT_SWITCH, EVENT_ROUTE_10_TM_VOLT_SWITCH

TrainerHikerJim:
	trainer HIKER, JIM, EVENT_BEAT_HIKER_JIM, HikerJimSeenText, HikerJimBeatenText, 0, HikerJimScript

HikerJimScript:
	end_if_just_battled
	jumptextfaceplayer UnknownText_0x1ae43b

TrainerPokefanmRobert:
	trainer POKEFANM, ROBERT, EVENT_BEAT_POKEFANM_ROBERT, PokefanmRobertSeenText, PokefanmRobertBeatenText, 0, PokefanmRobertScript

PokefanmRobertScript:
	end_if_just_battled
	jumptextfaceplayer UnknownText_0x1ae4a9

TrainerHexManiacAmy:
	trainer HEX_MANIAC, AMY, EVENT_BEAT_HEX_MANIAC_AMY, HexManiacAmySeenText, HexManiacAmyBeatenText, 0, HexManiacAmyScript

HexManiacAmyScript:
	end_if_just_battled
	jumptextfaceplayer HexManiacAmyAfterText

HikerJimSeenText:
	text "Hahahah!"
	done

HikerJimBeatenText:
	text "Hahaha-hachoo!"
	done

UnknownText_0x1ae43b:
	text "Hay fever is"
	line "making me sneeze!"
	cont "Ahahah-CHOO!"
	done

PokefanmRobertSeenText:
	text "You like #mon,"
	line "don't you?"

	para "Me too!"
	done

PokefanmRobertBeatenText:
	text "I'd have to say"
	line "that's my loss."
	done

UnknownText_0x1ae4a9:
	text "Look what you did"
	line "to my #mon…"

	para "I won't forget"
	line "this…"
	done

HexManiacAmySeenText:
	text "Lavender Town…"

	para "Where the spirits"
	line "of #mon sleep…"
	done

HexManiacAmyBeatenText:
	text "Your #mon are"
	line "overflowing with"
	cont "vitality…"
	done

HexManiacAmyAfterText:
	text "A Hex Maniac is"
	line "at peace among"
	cont "the spirits…"
	done

Route10SignText:
	text "Route 10"

	para "Cerulean City -"
	line "Lavender Town"
	done
