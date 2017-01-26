const_value set 2
	const ROUTE9_YOUNGSTER1
	const ROUTE9_LASS1
	const ROUTE9_YOUNGSTER2
	const ROUTE9_LASS2
	const ROUTE9_POKEFAN_M1
	const ROUTE9_POKEFAN_M2
	const ROUTE9_POKE_BALL
	const ROUTE9_CUT_TREE

Route9_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

TrainerCamperDean:
	trainer EVENT_BEAT_CAMPER_DEAN, CAMPER, DEAN, CamperDeanSeenText, CamperDeanBeatenText, 0, CamperDeanScript

CamperDeanScript:
	end_if_just_battled
	opentext
	writetext UnknownText_0x1aafd9
	waitbutton
	closetext
	end

TrainerPicnickerHeidi:
	trainer EVENT_BEAT_PICNICKER_HEIDI, PICNICKER, HEIDI, PicnickerHeidiSeenText, PicnickerHeidiBeatenText, 0, PicnickerHeidiScript

PicnickerHeidiScript:
	end_if_just_battled
	opentext
	writetext UnknownText_0x1ab07c
	waitbutton
	closetext
	end

TrainerCamperSid:
	trainer EVENT_BEAT_CAMPER_SID, CAMPER, SID, CamperSidSeenText, CamperSidBeatenText, 0, CamperSidScript

CamperSidScript:
	end_if_just_battled
	opentext
	writetext UnknownText_0x1ab0f6
	waitbutton
	closetext
	end

TrainerPicnickerEdna:
	trainer EVENT_BEAT_PICNICKER_EDNA, PICNICKER, EDNA, PicnickerEdnaSeenText, PicnickerEdnaBeatenText, 0, PicnickerEdnaScript

PicnickerEdnaScript:
	end_if_just_battled
	opentext
	writetext UnknownText_0x1ab15f
	waitbutton
	closetext
	end

TrainerHikerTim:
	trainer EVENT_BEAT_HIKER_TIM, HIKER, TIM, HikerTimSeenText, HikerTimBeatenText, 0, HikerTimScript

HikerTimScript:
	end_if_just_battled
	opentext
	writetext UnknownText_0x1ab210
	waitbutton
	closetext
	end

TrainerHikerSidney:
	trainer EVENT_BEAT_HIKER_SIDNEY, HIKER, SIDNEY, HikerSidneySeenText, HikerSidneyBeatenText, 0, HikerSidneyScript

HikerSidneyScript:
	end_if_just_battled
	opentext
	writetext UnknownText_0x1ab278
	waitbutton
	closetext
	end

Route9TMFlashCannon:
	tmhmball TM_FLASH_CANNON

Route9CutTree:
	jumpstd cuttree

Route9Sign:
	jumptext Route9SignText

Route9HiddenEther:
	dwb EVENT_ROUTE_9_HIDDEN_ETHER, ETHER

Route9HiddenSoftSand:
	dwb EVENT_ROUTE_9_HIDDEN_SOFT_SAND, SOFT_SAND

CamperDeanSeenText:
	text "I came to explore"
	line "Rock Tunnel."
	done

CamperDeanBeatenText:
	text "Whoa! Danger, man."
	done

UnknownText_0x1aafd9:
	text "My #mon were"
	line "hurt before even"

	para "entering Rock"
	line "Tunnel."

	para "I'd better take"
	line "them to a #mon"
	cont "Center right away."
	done

PicnickerHeidiSeenText:
	text "Have you ever been"
	line "to a picnic?"

	para "They're so much"
	line "fun!"
	done

PicnickerHeidiBeatenText:
	text "Ohhhh!"
	done

UnknownText_0x1ab07c:
	text "We bake lots of"
	line "goodies and share"

	para "them all around."
	line "They're delicious!"
	done

CamperSidSeenText:
	text "Hey, you!"
	line "Don't litter!"
	done

CamperSidBeatenText:
	text "I was just point-"
	line "ing out…"
	done

UnknownText_0x1ab0f6:
	text "Sorry. You weren't"
	line "littering. It was"
	cont "my mistake."
	done

PicnickerEdnaSeenText:
	text "People shouldn't"
	line "leave any litter"
	cont "behind."
	done

PicnickerEdnaBeatenText:
	text "Ohh… I lost…"
	done

UnknownText_0x1ab15f:
	text "Conserving energy"
	line "is important, but"

	para "the environment is"
	line "even more vital."
	done

HikerTimSeenText:
	text "♪ She'll be coming"
	line "'round Mt.Silver"
	cont "when she comes… ♪"

	para "Mt.Silver is in"
	line "Johto, right?"
	done

HikerTimBeatenText:
	text "I was too busy"
	line "singing…"
	done

UnknownText_0x1ab210:
	text "Battles are about"
	line "concentration."
	done

HikerSidneySeenText:
	text "I'll tell you a"
	line "secret."

	para "But first, we"
	line "battle!"
	done

HikerSidneyBeatenText:
	text "Oh, dang!"
	line "I lost that…"
	done

UnknownText_0x1ab278:
	text "The Power Plant is"
	line "across a small"
	cont "river."
	done

Route9SignText:
	text "Route 9"

	para "Cerulean City -"
	line "Rock Tunnel"
	done

Route9_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 0

.XYTriggers:
	db 0

.Signposts:
	db 3
	signpost 7, 21, SIGNPOST_READ, Route9Sign
	signpost 15, 51, SIGNPOST_ITEM, Route9HiddenEther
	signpost 12, 42, SIGNPOST_ITEM, Route9HiddenSoftSand

.PersonEvents:
	db 8
	person_event SPRITE_YOUNGSTER, 11, 25, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_TRAINER, 3, TrainerCamperDean, -1
	person_event SPRITE_LASS, 8, 43, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_TRAINER, 2, TrainerPicnickerHeidi, -1
	person_event SPRITE_YOUNGSTER, 4, 15, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_TRAINER, 5, TrainerCamperSid, -1
	person_event SPRITE_LASS, 15, 16, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_TRAINER, 1, TrainerPicnickerEdna, -1
	person_event SPRITE_POKEFAN_M, 3, 34, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_TRAINER, 2, TrainerHikerTim, -1
	person_event SPRITE_POKEFAN_M, 15, 44, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_TRAINER, 4, TrainerHikerSidney, -1
	person_event SPRITE_POKE_BALL, 2, 26, SPRITEMOVEDATA_ITEM_TREE, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_TMHMBALL, 0, Route9TMFlashCannon, EVENT_ROUTE_9_TM_FLASH_CANNON
	person_event SPRITE_CUT_TREE, 8, 5, SPRITEMOVEDATA_CUTTABLE_TREE, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, Route9CutTree, EVENT_ROUTE_9_CUT_TREE
