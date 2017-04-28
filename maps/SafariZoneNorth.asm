const_value set 2
	const SAFARIZONENORTH_BATTLE_GIRL
	const SAFARIZONENORTH_COOLTRAINER_F
	const SAFARIZONENORTH_POKE_BALL1
	const SAFARIZONENORTH_POKE_BALL2

SafariZoneNorth_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

TrainerBattleGirlPadma:
	trainer EVENT_BEAT_BATTLE_GIRL_PADMA, BATTLE_GIRL, PADMA, BattleGirlPadmaSeenText, BattleGirlPadmaBeatenText, 0, BattleGirlPadmaScript

BattleGirlPadmaScript:
	end_if_just_battled
	opentext
	writetext BattleGirlPadmaAfterText
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

SafariZoneNorth_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 7
	warp_def $1c, $1f, 3, SAFARI_ZONE_EAST
	warp_def $1d, $1f, 4, SAFARI_ZONE_EAST
	warp_def $21, $6, 5, SAFARI_ZONE_HUB
	warp_def $21, $7, 6, SAFARI_ZONE_HUB
	warp_def $21, $10, 7, SAFARI_ZONE_HUB
	warp_def $21, $11, 8, SAFARI_ZONE_HUB
	warp_def $5, $1b, 1, SAFARI_ZONE_NORTH_REST_HOUSE

.XYTriggers:
	db 0

.Signposts:
	db 5
	signpost 29, 11, SIGNPOST_READ, SafariZoneNorthAreaSign
	signpost 6, 28, SIGNPOST_READ, SafariZoneNorthRestHouseSign
	signpost 26, 22, SIGNPOST_READ, SafariZoneNorthTrainerTips1Sign
	signpost 31, 15, SIGNPOST_READ, SafariZoneNorthTrainerTips2Sign
	signpost 15, 25, SIGNPOST_ITEM, SafariZoneNorthHiddenLuckyPunch

.PersonEvents:
	db 4
	person_event SPRITE_COOLTRAINER_F, 19, 12, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_TRAINER, 4, TrainerBattleGirlPadma, -1
	person_event SPRITE_COOLTRAINER_F, 10, 11, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, SafariZoneNorthCooltrainerFScript, -1
	person_event SPRITE_BALL_CUT_FRUIT, 14, 20, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_ITEMBALL, 0, SafariZoneNorthEviolite, EVENT_SAFARI_ZONE_NORTH_EVIOLITE
	person_event SPRITE_BALL_CUT_FRUIT, 5, 13, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_ITEMBALL, 0, SafariZoneNorthProtein, EVENT_SAFARI_ZONE_NORTH_PROTEIN
