Route10South_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  6,  3, ROCK_TUNNEL_1F, 2

	def_coord_events

	def_bg_events
	bg_event  5,  5, BGEVENT_JUMPTEXT, Route10SignText
	bg_event 16,  3, BGEVENT_ITEM + MAX_ETHER, EVENT_ROUTE_10_HIDDEN_MAX_ETHER

	def_object_events
	object_event 17,  5, SPRITE_HIKER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerHikerJim, -1
	object_event  4,  7, SPRITE_POKEFAN_M, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 4, GenericTrainerPokefanmRobert, -1
	object_event  8, 12, SPRITE_HEX_MANIAC, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 4, GenericTrainerHexManiacAmy, -1
	tmhmball_event  9,  7, TM_VOLT_SWITCH, EVENT_ROUTE_10_TM_VOLT_SWITCH

GenericTrainerHikerJim:
	generictrainer HIKER, JIM, EVENT_BEAT_HIKER_JIM, HikerJimSeenText, HikerJimBeatenText

	text "Hay fever is"
	line "making me sneeze!"
	cont "Ahahah-CHOO!"
	done

GenericTrainerPokefanmRobert:
	generictrainer POKEFANM, ROBERT, EVENT_BEAT_POKEFANM_ROBERT, PokefanmRobertSeenText, PokefanmRobertBeatenText

	text "Look what you did"
	line "to my #mon…"

	para "I won't forget"
	line "this…"
	done

GenericTrainerHexManiacAmy:
	generictrainer HEX_MANIAC, AMY, EVENT_BEAT_HEX_MANIAC_AMY, HexManiacAmySeenText, HexManiacAmyBeatenText

	text "A Hex Maniac is"
	line "at peace among"
	cont "the spirits…"
	done

HikerJimSeenText:
	text "Hahahah!"
	done

HikerJimBeatenText:
	text "Hahaha-hachoo!"
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

Route10SignText:
	text "Route 10"

	para "Cerulean City -"
	line "Lavender Town"
	done
