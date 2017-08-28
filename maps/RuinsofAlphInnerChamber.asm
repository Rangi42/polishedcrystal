RuinsofAlphInnerChamber_MapScriptHeader:

.MapTriggers: db 2
	dw RuinsofAlphInnerChamberTrigger0
	dw RuinsofAlphInnerChamberTrigger1

.MapCallbacks: db 0

RuinsofAlphInnerChamber_MapEventHeader:

.Warps: db 9
	warp_def 13, 10, 3, RUINS_OF_ALPH_ENTRANCE_CHAMBER
	warp_def 15, 3, 3, RUINS_OF_ALPH_HO_OH_CHAMBER
	warp_def 15, 4, 4, RUINS_OF_ALPH_HO_OH_CHAMBER
	warp_def 3, 15, 3, RUINS_OF_ALPH_KABUTO_CHAMBER
	warp_def 3, 16, 4, RUINS_OF_ALPH_KABUTO_CHAMBER
	warp_def 21, 3, 3, RUINS_OF_ALPH_OMANYTE_CHAMBER
	warp_def 21, 4, 4, RUINS_OF_ALPH_OMANYTE_CHAMBER
	warp_def 24, 15, 3, RUINS_OF_ALPH_AERODACTYL_CHAMBER
	warp_def 24, 16, 4, RUINS_OF_ALPH_AERODACTYL_CHAMBER

.XYTriggers: db 0

.Signposts: db 28
	signpost 3, 2, SIGNPOST_JUMPTEXT, UnknownText_0x59072
	signpost 3, 5, SIGNPOST_JUMPTEXT, UnknownText_0x59072
	signpost 3, 8, SIGNPOST_JUMPTEXT, UnknownText_0x59072
	signpost 3, 11, SIGNPOST_JUMPTEXT, UnknownText_0x59072
	signpost 3, 14, SIGNPOST_JUMPTEXT, UnknownText_0x59072
	signpost 3, 17, SIGNPOST_JUMPTEXT, UnknownText_0x59072
	signpost 8, 2, SIGNPOST_JUMPTEXT, UnknownText_0x59072
	signpost 8, 5, SIGNPOST_JUMPTEXT, UnknownText_0x59072
	signpost 8, 8, SIGNPOST_JUMPTEXT, UnknownText_0x59072
	signpost 8, 11, SIGNPOST_JUMPTEXT, UnknownText_0x59072
	signpost 8, 14, SIGNPOST_JUMPTEXT, UnknownText_0x59072
	signpost 8, 17, SIGNPOST_JUMPTEXT, UnknownText_0x59072
	signpost 13, 2, SIGNPOST_JUMPTEXT, UnknownText_0x59072
	signpost 13, 5, SIGNPOST_JUMPTEXT, UnknownText_0x59072
	signpost 13, 14, SIGNPOST_JUMPTEXT, UnknownText_0x59072
	signpost 13, 17, SIGNPOST_JUMPTEXT, UnknownText_0x59072
	signpost 18, 2, SIGNPOST_JUMPTEXT, UnknownText_0x59072
	signpost 18, 5, SIGNPOST_JUMPTEXT, UnknownText_0x59072
	signpost 18, 8, SIGNPOST_JUMPTEXT, UnknownText_0x59072
	signpost 18, 11, SIGNPOST_JUMPTEXT, UnknownText_0x59072
	signpost 18, 14, SIGNPOST_JUMPTEXT, UnknownText_0x59072
	signpost 18, 17, SIGNPOST_JUMPTEXT, UnknownText_0x59072
	signpost 24, 2, SIGNPOST_JUMPTEXT, UnknownText_0x59072
	signpost 24, 5, SIGNPOST_JUMPTEXT, UnknownText_0x59072
	signpost 24, 8, SIGNPOST_JUMPTEXT, UnknownText_0x59072
	signpost 24, 11, SIGNPOST_JUMPTEXT, UnknownText_0x59072
	signpost 24, 14, SIGNPOST_JUMPTEXT, UnknownText_0x59072
	signpost 24, 17, SIGNPOST_JUMPTEXT, UnknownText_0x59072

.PersonEvents: db 4
	person_event SPRITE_FISHER, 7, 3, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x58fac, EVENT_RUINS_OF_ALPH_INNER_CHAMBER_TOURISTS
	person_event SPRITE_TEACHER, 14, 14, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, 0, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x58fda, EVENT_RUINS_OF_ALPH_INNER_CHAMBER_TOURISTS
	person_event SPRITE_GRAMPS, 19, 11, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x59024, EVENT_RUINS_OF_ALPH_INNER_CHAMBER_TOURISTS
	person_event SPRITE_SCIENTIST, 11, 7, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x58a03, EVENT_RUINS_OF_ALPH_INNER_CHAMBER_TOURISTS

RuinsofAlphInnerChamberTrigger1:
	priorityjump UnknownScript_0x58f6e
RuinsofAlphInnerChamberTrigger0:
	end

UnknownScript_0x58f6e:
	showtext UnknownText_0x58f89
	dotrigger $0
	setevent EVENT_MADE_UNOWN_APPEAR_IN_RUINS
	clearevent EVENT_RUINS_OF_ALPH_OUTSIDE_TOURIST_FISHER
	end

UnknownText_0x58f89:
	text "There is a strange"
	line "presence here…"
	done

UnknownText_0x58fac:
	text "This is a big"
	line "room, but there's"
	cont "nothing here."
	done

UnknownText_0x58fda:
	text "This place has a"
	line "mystical quality"
	cont "to it."

	para "It feels sort of"
	line "ethereal even."
	done

UnknownText_0x59024:
	text "The ruins have not"
	line "been robbed or"
	cont "tampered with."

	para "Something here"
	line "must make people"
	cont "want to preserve"
	cont "it."
	done

UnknownText_0x58a03:
	text "The patterns on"
	line "the wall appear to"
	cont "be words!"

	para "And those sliding"
	line "stone panels seem"

	para "to be signals of"
	line "some kind."

	para "I think they make"
	line "#mon appear,"

	para "but it's not clear"
	line "yet…"
	done

UnknownText_0x59072:
	text "It's a replica of"
	line "an ancient #-"
	cont "mon."
	done
