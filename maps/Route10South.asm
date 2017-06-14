const_value set 2
	const ROUTE10SOUTH_POKEFAN_M1
	const ROUTE10SOUTH_POKEFAN_M2
	const ROUTE10SOUTH_HEX_MANIAC

Route10South_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

TrainerHikerJim:
	trainer EVENT_BEAT_HIKER_JIM, HIKER, JIM, HikerJimSeenText, HikerJimBeatenText, 0, HikerJimScript

HikerJimScript:
	end_if_just_battled
	opentext
	writetext UnknownText_0x1ae43b
	waitbutton
	closetext
	end

TrainerPokefanmRobert:
	trainer EVENT_BEAT_POKEFANM_ROBERT, POKEFANM, ROBERT, PokefanmRobertSeenText, PokefanmRobertBeatenText, 0, PokefanmRobertScript

PokefanmRobertScript:
	end_if_just_battled
	opentext
	writetext UnknownText_0x1ae4a9
	waitbutton
	closetext
	end

TrainerHexManiacAmy:
	trainer EVENT_BEAT_HEX_MANIAC_AMY, HEX_MANIAC, AMY, HexManiacAmySeenText, HexManiacAmyBeatenText, 0, HexManiacAmyScript

HexManiacAmyScript:
	end_if_just_battled
	opentext
	writetext HexManiacAmyAfterText
	waitbutton
	closetext
	end

Route10Sign:
	habitatlist Route10SignText, ROUTE_10

Route10HiddenMaxEther:
	dwb EVENT_ROUTE_10_HIDDEN_MAX_ETHER, MAX_ETHER

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

Route10South_MapEventHeader:
.Warps:
	db 1
	warp_def $3, $6, 2, ROCK_TUNNEL_1F

.XYTriggers:
	db 0

.Signposts:
	db 2
	signpost 5, 5, SIGNPOST_READ, Route10Sign
	signpost 3, 16, SIGNPOST_ITEM, Route10HiddenMaxEther

.PersonEvents:
	db 3
	person_event SPRITE_POKEFAN_M, 5, 17, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_TRAINER, 3, TrainerHikerJim, -1
	person_event SPRITE_POKEFAN_M, 7, 4, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_TRAINER, 2, TrainerPokefanmRobert, -1
	person_event SPRITE_HEX_MANIAC, 12, 8, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, (1 << 3) | PAL_OW_PURPLE, PERSONTYPE_TRAINER, 3, TrainerHexManiacAmy, -1
