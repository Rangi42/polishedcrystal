const_value set 2
	const ROUTE12_FISHER1
	const ROUTE12_FISHER2
	const ROUTE12_FISHER3
	const ROUTE12_FISHER4
	const ROUTE12_POKE_BALL1
	const ROUTE12_POKE_BALL2
	const ROUTE12_CUT_TREE1
	const ROUTE12_CUT_TREE2

Route12_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

TrainerFisherKyle:
	trainer EVENT_BEAT_FISHER_KYLE, FISHER, KYLE, FisherKyleSeenText, FisherKyleBeatenText, 0, FisherKyleScript

FisherKyleScript:
	end_if_just_battled
	opentext
	writetext UnknownText_0x1a7238
	waitbutton
	closetext
	end

TrainerFisherMartin:
	trainer EVENT_BEAT_FISHER_MARTIN, FISHER, MARTIN, FisherMartinSeenText, FisherMartinBeatenText, 0, FisherMartinScript

FisherMartinScript:
	end_if_just_battled
	opentext
	writetext UnknownText_0x1a704c
	waitbutton
	closetext
	end

TrainerFisherStephen:
	trainer EVENT_BEAT_FISHER_STEPHEN, FISHER, STEPHEN, FisherStephenSeenText, FisherStephenBeatenText, 0, FisherStephenScript

FisherStephenScript:
	end_if_just_battled
	opentext
	writetext UnknownText_0x1a70d4
	waitbutton
	closetext
	end

TrainerFisherBarney:
	trainer EVENT_BEAT_FISHER_BARNEY, FISHER, BARNEY, FisherBarneySeenText, FisherBarneyBeatenText, 0, FisherBarneyScript

FisherBarneyScript:
	end_if_just_battled
	opentext
	writetext UnknownText_0x1a716d
	waitbutton
	closetext
	end

Route12CutTree:
	jumpstd cuttree

Route12Sign:
	jumptext Route12SignText

FishingSpotSign:
	jumptext FishingSpotSignText

Route12Calcium:
	itemball CALCIUM

Route12Nugget:
	itemball NUGGET

Route12HiddenElixer:
	dwb EVENT_ROUTE_12_HIDDEN_ELIXER, ELIXER

FisherMartinSeenText:
	text "Patience is the"
	line "key to both fish-"
	cont "ing and #mon."
	done

FisherMartinBeatenText:
	text "Gwaaah!"
	done

UnknownText_0x1a704c:
	text "I'm too impatient"
	line "for fishing…"
	done

FisherStephenSeenText:
	text "I feel so content,"
	line "fishing while lis-"
	cont "tening to some"
	cont "tunes on my radio."
	done

FisherStephenBeatenText:
	text "My stupid radio"
	line "distracted me!"
	done

UnknownText_0x1a70d4:
	text "Have you checked"
	line "out Kanto's radio"

	para "programs? We get a"
	line "good variety here."
	done

FisherBarneySeenText:
	text "What's most impor-"
	line "tant in our every-"
	cont "day lives?"
	done

FisherBarneyBeatenText:
	text "The answer is"
	line "coming up next!"
	done

UnknownText_0x1a716d:
	text "I think electric-"
	line "ity is the most"

	para "important thing in"
	line "our daily lives."

	para "If it weren't,"
	line "people wouldn't"

	para "have made such a"
	line "fuss when the"

	para "Power Plant went"
	line "out of commission."
	done

FisherKyleSeenText:
	text "Do you remember?"
	done

FisherKyleBeatenText:
	text "You do remember?"
	done

UnknownText_0x1a7238:
	text "The tug you feel"
	line "on the Rod when"

	para "you hook a #-"
	line "mon…"

	para "That's the best"
	line "feeling ever for"
	cont "an angler like me."
	done

Route12SignText:
	text "Route 12"

	para "North to Lavender"
	line "Town"
	done

FishingSpotSignText:
	text "Fishing Spot"
	done

Route12_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 6
	warp_def $27, $b, 1, ROUTE_12_SUPER_ROD_HOUSE
	warp_def $20, $0, 3, ROUTE_11_GATE
	warp_def $21, $0, 4, ROUTE_11_GATE
	warp_def $b, $a, 1, ROUTE_12_GATE
	warp_def $b, $b, 2, ROUTE_12_GATE
	warp_def $f, $a, 3, ROUTE_12_GATE

.XYTriggers:
	db 0

.Signposts:
	db 3
	signpost 33, 11, SIGNPOST_READ, Route12Sign
	signpost 9, 13, SIGNPOST_READ, FishingSpotSign
	signpost 19, 14, SIGNPOST_ITEM, Route12HiddenElixer

.PersonEvents:
	db 8
	person_event SPRITE_FISHER, 19, 5, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_TRAINER, 1, TrainerFisherMartin, -1
	person_event SPRITE_FISHER, 29, 14, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_TRAINER, 1, TrainerFisherStephen, -1
	person_event SPRITE_FISHER, 44, 10, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_TRAINER, 5, TrainerFisherBarney, -1
	person_event SPRITE_FISHER, 7, 6, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_TRAINER, 3, TrainerFisherKyle, -1
	person_event SPRITE_POKE_BALL, 51, 5, SPRITEMOVEDATA_ITEM_TREE, 0, 0, -1, -1, 0, PERSONTYPE_ITEMBALL, 0, Route12Calcium, EVENT_ROUTE_12_CALCIUM
	person_event SPRITE_POKE_BALL, 58, 5, SPRITEMOVEDATA_ITEM_TREE, 0, 0, -1, -1, 0, PERSONTYPE_ITEMBALL, 0, Route12Nugget, EVENT_ROUTE_12_NUGGET
	person_event SPRITE_CUT_TREE, 51, 7, SPRITEMOVEDATA_ITEM_TREE, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, Route12CutTree, EVENT_ROUTE_12_CUT_TREE_1
	person_event SPRITE_CUT_TREE, 57, 7, SPRITEMOVEDATA_ITEM_TREE, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, Route12CutTree, EVENT_ROUTE_12_CUT_TREE_2
