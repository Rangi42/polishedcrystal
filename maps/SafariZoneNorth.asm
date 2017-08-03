SafariZoneNorth_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

SafariZoneNorth_MapEventHeader:

.Warps: db 9
	warp_def $20, $29, 3, SAFARI_ZONE_EAST
	warp_def $21, $29, 4, SAFARI_ZONE_EAST
	warp_def $25, $a, 3, SAFARI_ZONE_WEST
	warp_def $25, $b, 4, SAFARI_ZONE_WEST
	warp_def $25, $16, 7, SAFARI_ZONE_HUB
	warp_def $25, $17, 8, SAFARI_ZONE_HUB
	warp_def $5, $25, 1, SAFARI_ZONE_NORTH_REST_HOUSE
	warp_def $25, $4, 1, SAFARI_ZONE_WEST
	warp_def $25, $5, 2, SAFARI_ZONE_WEST

.XYTriggers: db 0

.Signposts: db 6
	signpost 33, 15, SIGNPOST_READ, SafariZoneNorthAreaSign
	signpost 6, 38, SIGNPOST_READ, SafariZoneNorthRestHouseSign
	signpost 30, 28, SIGNPOST_READ, SafariZoneNorthTrainerTips1Sign
	signpost 34, 20, SIGNPOST_READ, SafariZoneNorthTrainerTips2Sign
	signpost 27, 5, SIGNPOST_READ, SafariZoneNorthTrainerTips3Sign
	signpost 19, 31, SIGNPOST_ITEM, SafariZoneNorthHiddenLuckyPunch

.PersonEvents: db 6
	person_event SPRITE_COOLTRAINER_F, 23, 18, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_TRAINER, 4, TrainerBattleGirlPadma, -1
	person_event SPRITE_YOUNGSTER, 7, 7, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_TRAINER, 3, TrainerYoungsterTyler, -1
	person_event SPRITE_BEAUTY, 9, 36, SPRITEMOVEDATA_SPINCLOCKWISE, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_TRAINER, 3, TrainerBeautyRachael, -1
	person_event SPRITE_COOLTRAINER_F, 14, 15, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, SafariZoneNorthCooltrainerFScript, -1
	person_event SPRITE_BALL_CUT_FRUIT, 18, 24, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_ITEMBALL, 0, SafariZoneNorthEviolite, EVENT_SAFARI_ZONE_NORTH_EVIOLITE
	person_event SPRITE_BALL_CUT_FRUIT, 9, 21, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_ITEMBALL, 0, SafariZoneNorthProtein, EVENT_SAFARI_ZONE_NORTH_PROTEIN

TrainerBattleGirlPadma:
	trainer EVENT_BEAT_BATTLE_GIRL_PADMA, BATTLE_GIRL, PADMA, BattleGirlPadmaSeenText, BattleGirlPadmaBeatenText, 0, BattleGirlPadmaScript

BattleGirlPadmaScript:
	end_if_just_battled
	opentext
	writetext BattleGirlPadmaAfterText
	waitbutton
	closetext
	end

TrainerYoungsterTyler:
	trainer EVENT_BEAT_YOUNGSTER_TYLER, YOUNGSTER, TYLER, YoungsterTylerSeenText, YoungsterTylerBeatenText, 0, YoungsterTylerScript

YoungsterTylerScript:
	end_if_just_battled
	opentext
	writetext YoungsterTylerAfterText
	waitbutton
	closetext
	end

TrainerBeautyRachael:
	trainer EVENT_BEAT_BEAUTY_RACHAEL, BEAUTY, RACHAEL, BeautyRachaelSeenText, BeautyRachaelBeatenText, 0, BeautyRachaelScript

BeautyRachaelScript:
	end_if_just_battled
	opentext
	writetext BeautyRachaelAfterText
	waitbutton
	closetext
	end

SafariZoneNorthCooltrainerFScript:
	faceplayer
	opentext
	checkevent EVENT_LISTENED_TO_DOUBLE_EDGE_INTRO
	iftrue SafariZoneNorthTutorDoubleEdgeScript
	writetext SafariZoneNorthCooltrainerFText
	waitbutton
	setevent EVENT_LISTENED_TO_DOUBLE_EDGE_INTRO
SafariZoneNorthTutorDoubleEdgeScript:
	writetext Text_SafariZoneNorthTutorDoubleEdge
	waitbutton
	checkitem SILVER_LEAF
	iffalse .NoSilverLeaf
	writetext Text_SafariZoneNorthTutorQuestion
	yesorno
	iffalse .TutorRefused
	writebyte DOUBLE_EDGE
	writetext Text_SafariZoneNorthTutorClear
	special Special_MoveTutor
	if_equal $0, .TeachMove
.TutorRefused
	writetext Text_SafariZoneNorthTutorRefused
	waitbutton
	closetext
	end

.NoSilverLeaf
	writetext Text_SafariZoneNorthTutorNoSilverLeaf
	waitbutton
	closetext
	end

.TeachMove
	takeitem SILVER_LEAF
	writetext Text_SafariZoneNorthTutorTaught
	waitbutton
	closetext
	end

SafariZoneNorthAreaSign:
	jumptext SafariZoneNorthAreaSignText

SafariZoneNorthRestHouseSign:
	jumptext SafariZoneNorthRestHouseSignText

SafariZoneNorthTrainerTips1Sign:
	jumptext SafariZoneNorthTrainerTips1SignText

SafariZoneNorthTrainerTips2Sign:
	jumptext SafariZoneNorthTrainerTips2SignText

SafariZoneNorthTrainerTips3Sign:
	jumptext SafariZoneNorthTrainerTips3SignText

SafariZoneNorthEviolite:
	itemball EVIOLITE

SafariZoneNorthProtein:
	itemball PROTEIN

SafariZoneNorthHiddenLuckyPunch:
	dwb EVENT_SAFARI_ZONE_NORTH_HIDDEN_LUCKY_PUNCH, LUCKY_PUNCH

BattleGirlPadmaSeenText:
	text "I spar with my"
	line "#mon to improve"
	cont "as a team!"
	done

BattleGirlPadmaBeatenText:
	text "We'll have to"
	line "train harder!"
	done

BattleGirlPadmaAfterText:
	text "If you throw your"
	line "emotions into"

	para "training, you'll"
	line "become strong!"
	done

YoungsterTylerSeenText:
	text "You can find #-"
	line "mon anywhere!"

	para "In grass, in"
	line "water, or up a"
	cont "girl's skirt!"
	done

YoungsterTylerBeatenText:
	text "I'm sorry!"
	done

YoungsterTylerAfterText:
	text "#mon leap out"
	line "when you least"
	cont "expect it."
	done

BeautyRachaelSeenText:
	text "My sundress is"
	line "perfect for a day"
	cont "in the Safari"
	cont "Zone!"
	done

BeautyRachaelBeatenText:
	text "It's not great"
	line "for battling…"
	done

BeautyRachaelAfterText:
	text "I was a Black Belt"
	line "just one year ago."

	para "The power of med-"
	line "ical science is"

	para "amazing, wouldn't"
	line "you say?"
	done

SafariZoneNorthCooltrainerFText:
	text "I caught a"
	line "Chansey!"

	para "I'm so lucky!"
	line "I'm going to teach"

	para "it to do a really"
	line "powerful tackle."

	para "Let me share my"
	line "luck with you!"
	done

Text_SafariZoneNorthTutorDoubleEdge:
	text "I'll teach your"
	line "#mon how to"

	para "use Double-Edge"
	line "for a Silver Leaf."
	done

Text_SafariZoneNorthTutorNoSilverLeaf:
	text "You don't have any"
	line "Silver Leaves…"
	done

Text_SafariZoneNorthTutorQuestion:
	text "Should I teach"
	line "your #mon"
	cont "Double-Edge?"
	done

Text_SafariZoneNorthTutorRefused:
	text "Oh well."
	done

Text_SafariZoneNorthTutorClear:
	text ""
	done

Text_SafariZoneNorthTutorTaught:
	text "There!"
	line "Now your #mon"

	para "knows how to use"
	cont "Double-Edge!"
	done

SafariZoneNorthAreaSignText:
	text "Safari Zone"
	line "North Area"
	done

SafariZoneNorthRestHouseSignText:
	text "Rest House"
	done

SafariZoneNorthTrainerTips1SignText:
	text "Trainer Tips"

	para "Moves of the same"
	line "type can be"
	cont "physical, special,"
	cont "or status-based."
	done

SafariZoneNorthTrainerTips2SignText:
	text "Trainer Tips"

	para "#mon hide in"
	line "tall grass!"

	para "Zigzag through"
	line "grassy areas to"
	cont "flush them out."
	done

SafariZoneNorthTrainerTips3SignText:
	text "Trainer Tips"

	para "The rest of the"
	line "sign has been"
	cont "torn away…"
	done
