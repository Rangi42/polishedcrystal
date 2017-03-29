const_value set 2
	const ROUTE3_FISHER1
	const ROUTE3_YOUNGSTER1
	const ROUTE3_YOUNGSTER2
	const ROUTE3_FISHER2
	const ROUTE3_COOLTRAINER_M
	const ROUTE3_COOLTRAINER_F

Route3_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 1

	; callbacks

	dbw MAPCALLBACK_NEWMAP, .FlyPoint

.FlyPoint:
	setflag ENGINE_FLYPOINT_MT_MOON
	return

TrainerFirebreatherOtis:
	trainer EVENT_BEAT_FIREBREATHER_OTIS, FIREBREATHER, OTIS, FirebreatherOtisSeenText, FirebreatherOtisBeatenText, 0, FirebreatherOtisScript

FirebreatherOtisScript:
	end_if_just_battled
	opentext
	writetext UnknownText_0x1adff7
	waitbutton
	closetext
	end

TrainerYoungsterWarren:
	trainer EVENT_BEAT_YOUNGSTER_WARREN, YOUNGSTER, WARREN, YoungsterWarrenSeenText, YoungsterWarrenBeatenText, 0, YoungsterWarrenScript

YoungsterWarrenScript:
	end_if_just_battled
	opentext
	writetext UnknownText_0x1ae051
	waitbutton
	closetext
	end

TrainerYoungsterJimmy:
	trainer EVENT_BEAT_YOUNGSTER_JIMMY, YOUNGSTER, JIMMY, YoungsterJimmySeenText, YoungsterJimmyBeatenText, 0, YoungsterJimmyScript

YoungsterJimmyScript:
	end_if_just_battled
	opentext
	writetext UnknownText_0x1ae0a9
	waitbutton
	closetext
	end

TrainerFirebreatherBurt:
	trainer EVENT_BEAT_FIREBREATHER_BURT, FIREBREATHER, BURT, FirebreatherBurtSeenText, FirebreatherBurtBeatenText, 0, FirebreatherBurtScript

FirebreatherBurtScript:
	end_if_just_battled
	opentext
	writetext UnknownText_0x1ae118
	waitbutton
	closetext
	end

TrainerAceDuoZacandjen1:
	trainer EVENT_BEAT_ACE_DUO_ZAC_AND_JEN, ACE_DUO, ZACANDJEN1, AceDuoZacandjen1SeenText, AceDuoZacandjen1BeatenText, 0, AceDuoZacandjen1Script

AceDuoZacandjen1Script:
	end_if_just_battled
	opentext
	writetext AceDuoZacandjen1AfterText
	waitbutton
	closetext
	end

TrainerAceDuoZacandjen2:
	trainer EVENT_BEAT_ACE_DUO_ZAC_AND_JEN, ACE_DUO, ZACANDJEN2, AceDuoZacandjen2SeenText, AceDuoZacandjen2BeatenText, 0, AceDuoZacandjen2Script

AceDuoZacandjen2Script:
	end_if_just_battled
	opentext
	writetext AceDuoZacandjen2AfterText
	waitbutton
	closetext
	end

MapRoute3Signpost0Script:
	jumptext UnknownText_0x1ae163

Route3HiddenMoonStone:
	dwb EVENT_ROUTE_3_HIDDEN_MOON_STONE, MOON_STONE

FirebreatherOtisSeenText:
	text "Ah! The weather's"
	line "as fine as ever."
	done

FirebreatherOtisBeatenText:
	text "It's sunny, but"
	line "I'm all wet…"
	done

UnknownText_0x1adff7:
	text "When it rains,"
	line "it's hard to get"
	cont "ignition…"
	done

YoungsterWarrenSeenText:
	text "Hmmm… I don't know"
	line "what to do…"
	done

YoungsterWarrenBeatenText:
	text "I knew I'd lose…"
	done

UnknownText_0x1ae051:
	text "You looked strong."

	para "I was afraid to"
	line "take you on…"
	done

YoungsterJimmySeenText:
	text "I can run like the"
	line "wind!"
	done

YoungsterJimmyBeatenText:
	text "Blown away!"
	done

UnknownText_0x1ae0a9:
	text "I wear shorts the"
	line "whole year round."

	para "That's my fashion"
	line "policy."
	done

FirebreatherBurtSeenText:
	text "Step right up and"
	line "take a look!"
	done

FirebreatherBurtBeatenText:
	text "Yow! That's hot!"
	done

UnknownText_0x1ae118:
	text "The greatest fire-"
	line "breather in Kanto,"
	cont "that's me."

	para "But not the best"
	line "trainer…"
	done

AceDuoZacandjen1SeenText:
	text "Zac: Really, you"
	line "want to battle us?"

	para "You've got a lot"
	line "of courage for"
	cont "someone so young."
	done

AceDuoZacandjen1BeatenText:
	text "Zac: You weren't"
	line "bluffing…"
	done

AceDuoZacandjen1AfterText:
	text "Zac: Your future"
	line "looks promising."
	done

AceDuoZacandjen2SeenText:
	text "Jen: Huh? You'd"
	line "like to go up"
	cont "against us? Great!"
	done

AceDuoZacandjen2BeatenText:
	text "Jen: You're so"
	line "much stronger than"
	cont "I thought."
	done

AceDuoZacandjen2AfterText:
	text "Jen: I'm looking"
	line "forward to seeing"
	para "what kind of"
	line "trainer you'll"
	cont "become."
	done

UnknownText_0x1ae163:
	text "Mt.Moon"
	line "Tunnel Entrance"
	done

Route3_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 2
	warp_def $1, $44, 1, MOUNT_MOON_1F
	warp_def $3, $3d, 1, ROUTE_3_POKECENTER_1F

.XYTriggers:
	db 0

.Signposts:
	db 2
	signpost 15, 63, SIGNPOST_READ, MapRoute3Signpost0Script
	signpost 17, 11, SIGNPOST_ITEM, Route3HiddenMoonStone

.PersonEvents:
	db 6
	person_event SPRITE_FISHER, 12, 30, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_TRAINER, 2, TrainerFirebreatherOtis, -1
	person_event SPRITE_YOUNGSTER, 7, 12, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_TRAINER, 3, TrainerYoungsterWarren, -1
	person_event SPRITE_YOUNGSTER, 3, 18, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_TRAINER, 1, TrainerYoungsterJimmy, -1
	person_event SPRITE_FISHER, 13, 45, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_TRAINER, 3, TrainerFirebreatherBurt, -1
	person_event SPRITE_COOLTRAINER_M, 12, 14, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_TRAINER, 1, TrainerAceDuoZacandjen1, -1
	person_event SPRITE_COOLTRAINER_F, 12, 15, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_TRAINER, 1, TrainerAceDuoZacandjen2, -1
