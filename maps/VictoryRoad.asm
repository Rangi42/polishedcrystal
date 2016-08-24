const_value set 2
	const VICTORYROAD_SILVER
	const VICTORYROAD_LAWRENCE
	const VICTORYROAD_COOLTRAINERM1
	const VICTORYROAD_COOLTRAINERF1
	const VICTORYROAD_COOLTRAINERF2
	const VICTORYROAD_COOLTRAINERM2
	const VICTORYROAD_POKE_BALL1
	const VICTORYROAD_POKE_BALL2
	const VICTORYROAD_POKE_BALL3
	const VICTORYROAD_POKE_BALL4
	const VICTORYROAD_POKE_BALL5
	const VICTORYROAD_POKE_BALL6

VictoryRoad_MapScriptHeader:
.MapTriggers:
	db 4

	; triggers
	maptrigger .Trigger0
	maptrigger .Trigger1
	maptrigger .Trigger2
	maptrigger .Trigger3

.MapCallbacks:
	db 0

.Trigger0:
	end

.Trigger1:
	end

.Trigger2:
	end

.Trigger3:
	end

UnknownScript_0x74492:
	moveperson VICTORYROAD_SILVER, $12, $b
	spriteface PLAYER, DOWN
	showemote EMOTE_SHOCK, PLAYER, 15
	special Special_FadeOutMusic
	pause 15
	appear VICTORYROAD_SILVER
	applymovement VICTORYROAD_SILVER, MovementData_0x74539
	scall UnknownScript_0x744d4
	applymovement VICTORYROAD_SILVER, MovementData_0x7454c
	disappear VICTORYROAD_SILVER
	dotrigger $1
	playmapmusic
	end

UnknownScript_0x744b5:
	spriteface PLAYER, DOWN
	showemote EMOTE_SHOCK, PLAYER, 15
	special Special_FadeOutMusic
	pause 15
	appear VICTORYROAD_SILVER
	applymovement VICTORYROAD_SILVER, MovementData_0x74542
	scall UnknownScript_0x744d4
	applymovement VICTORYROAD_SILVER, MovementData_0x74555
	disappear VICTORYROAD_SILVER
	dotrigger $1
	playmapmusic
	end

UnknownScript_0x744d4:
	spriteface PLAYER, DOWN
	playmusic MUSIC_RIVAL_ENCOUNTER
	opentext
	writetext UnknownText_0x7455f
	waitbutton
	closetext
	setevent EVENT_RIVAL_VICTORY_ROAD
	checkevent EVENT_GOT_TOTODILE_FROM_ELM
	iftrue UnknownScript_0x744ff
	checkevent EVENT_GOT_CHIKORITA_FROM_ELM
	iftrue UnknownScript_0x7450f
	winlosstext UnknownText_0x7463d, UnknownText_0x747aa
	setlasttalked VICTORYROAD_SILVER
	loadtrainer RIVAL1, RIVAL1_15
	startbattle
	dontrestartmapmusic
	reloadmapafterbattle
	jump UnknownScript_0x7451f

UnknownScript_0x744ff:
	winlosstext UnknownText_0x7463d, UnknownText_0x747aa
	setlasttalked VICTORYROAD_SILVER
	loadtrainer RIVAL1, RIVAL1_13
	startbattle
	dontrestartmapmusic
	reloadmapafterbattle
	jump UnknownScript_0x7451f

UnknownScript_0x7450f:
	winlosstext UnknownText_0x7463d, UnknownText_0x747aa
	setlasttalked VICTORYROAD_SILVER
	loadtrainer RIVAL1, RIVAL1_14
	startbattle
	dontrestartmapmusic
	reloadmapafterbattle
	jump UnknownScript_0x7451f

UnknownScript_0x7451f:
	playmusic MUSIC_RIVAL_AFTER
	opentext
	writetext UnknownText_0x746ce
	waitbutton
	closetext
	end

LawrenceUpScript:
	special SpecialBirdsCheck
	iffalse .End
	spriteface PLAYER, LEFT
	showemote EMOTE_SHOCK, PLAYER, 15
	special Special_FadeOutMusic
	pause 15
	disappear VICTORYROAD_LAWRENCE
	appear VICTORYROAD_LAWRENCE
	applymovement VICTORYROAD_LAWRENCE, LawrenceUpApproachMovementData
	scall BattleLawrenceScript
	applymovement VICTORYROAD_LAWRENCE, LawrenceUpPauseMovementData
	opentext
	writetext LawrenceGoodbyeText
	waitbutton
	closetext
	applymovement VICTORYROAD_LAWRENCE, LawrenceUpLeaveMovementData
	playsound SFX_EXIT_BUILDING
	disappear VICTORYROAD_LAWRENCE
	dotrigger $2
	waitsfx
	;special RestartMapMusic
	playmusic MUSIC_VICTORY_ROAD
.End
	end

LawrenceLeftScript:
	special SpecialBirdsCheck
	iffalse .End
	spriteface PLAYER, UP
	showemote EMOTE_SHOCK, PLAYER, 15
	special Special_FadeOutMusic
	pause 15
	disappear VICTORYROAD_LAWRENCE
	appear VICTORYROAD_LAWRENCE
	applymovement VICTORYROAD_LAWRENCE, LawrenceLeftApproachMovementData
	scall BattleLawrenceScript
	applymovement VICTORYROAD_LAWRENCE, LawrenceLeftPauseMovementData
	opentext
	writetext LawrenceGoodbyeText
	waitbutton
	closetext
	applymovement VICTORYROAD_LAWRENCE, LawrenceLeftLeaveMovementData
	playsound SFX_EXIT_BUILDING
	disappear VICTORYROAD_LAWRENCE
	dotrigger $2
	waitsfx
	;special RestartMapMusic
	playmusic MUSIC_VICTORY_ROAD
.End
	end

BattleLawrenceScript:
	playmusic MUSIC_LAWRENCE
	opentext
	writetext LawrenceSeenText
	waitbutton
	closetext
	winlosstext LawrenceBeatenText, 0
	setlasttalked VICTORYROAD_LAWRENCE
	loadtrainer LAWRENCE, 1
	startbattle
	dontrestartmapmusic
	reloadmapafterbattle
	playmusic MUSIC_LAWRENCE
	opentext
	writetext LawrenceAfterText
	buttonsound
	verbosegiveitem SILVER_WING
	writetext LawrenceSilverWingText
	waitbutton
	closetext
	end

LawrenceUpApproachMovementData:
	step_down
	step_down
	step_down
	step_down
	turn_head_right
	step_right
	step_end

LawrenceLeftApproachMovementData:
	step_down
	step_down
	step_down
	step_down
	step_right
	turn_head_down
	step_end

LawrenceUpPauseMovementData:
	turn_head_left
	step_sleep_8
	step_sleep_8
	step_sleep_8
	step_sleep_8
	step_sleep_8
	step_sleep_8
	turn_head_right
	step_end

LawrenceLeftPauseMovementData:
	turn_head_up
	step_sleep_8
	step_sleep_8
	turn_head_down
	step_end

LawrenceUpLeaveMovementData:
	step_down
	step_right
	step_down
	step_end

LawrenceLeftLeaveMovementData:
	step_right
	step_down
	step_down
	step_end

TrainerCooltrainermMatt:
	trainer EVENT_BEAT_COOLTRAINERM_MATT, COOLTRAINERM, MATT, CooltrainermMattSeenText, CooltrainermMattBeatenText, 0, CooltrainermMattScript

CooltrainermMattScript:
	end_if_just_battled
	opentext
	writetext CooltrainermMattAfterText
	waitbutton
	closetext
	end

TrainerCooltrainerfJoanne:
	trainer EVENT_BEAT_COOLTRAINERF_JOANNE, COOLTRAINERF, JOANNE, CooltrainerfJoanneSeenText, CooltrainerfJoanneBeatenText, 0, CooltrainerfJoanneScript

CooltrainerfJoanneScript:
	end_if_just_battled
	opentext
	writetext CooltrainerfJoanneAfterText
	waitbutton
	closetext
	end

TrainerCooltrainerfKotori:
	trainer EVENT_BEAT_COOLTRAINERF_KOTORI, COOLTRAINERF, KOTORI, CooltrainerfKotoriSeenText, CooltrainerfKotoriBeatenText, 0, CooltrainerfKotoriScript

CooltrainerfKotoriScript:
	end_if_just_battled
	opentext
	writetext CooltrainerfKotoriAfterText
	waitbutton
	closetext
	end

TrainerCooltrainermRingo:
	trainer EVENT_BEAT_COOLTRAINERM_RINGO, COOLTRAINERM, RINGO, CooltrainermRingoSeenText, CooltrainermRingoBeatenText, 0, CooltrainermRingoScript

CooltrainermRingoScript:
	end_if_just_battled
	opentext
	writetext CooltrainermRingoAfterText
	waitbutton
	closetext
	end

VictoryRoadTMEarthquake:
	itemball TM_EARTHQUAKE

VictoryRoadMaxRevive:
	itemball MAX_REVIVE

VictoryRoadFullRestore:
	itemball FULL_RESTORE

VictoryRoadFullHeal:
	itemball FULL_HEAL

VictoryRoadHPUp:
	itemball HP_UP

VictoryRoadRazorFang
	itemball RAZOR_FANG

VictoryRoadHiddenMaxPotion:
	dwb EVENT_VICTORY_ROAD_HIDDEN_MAX_POTION, MAX_POTION

VictoryRoadHiddenFullHeal:
	dwb EVENT_VICTORY_ROAD_HIDDEN_FULL_HEAL, FULL_HEAL

MovementData_0x74539:
	step_left
	step_left
	step_left
	step_left
	step_left
	step_left
	step_up
	step_up
	step_end

MovementData_0x74542:
	step_up
	step_up
	step_left
	step_left
	step_left
	step_left
	step_left
	step_up
	step_up
	step_end

MovementData_0x7454c:
	step_down
	step_down
	step_right
	step_right
	step_right
	step_right
	step_right
	step_right
	step_end

MovementData_0x74555:
	step_down
	step_down
	step_right
	step_right
	step_right
	step_right
	step_right
	step_down
	step_down
	step_end

UnknownText_0x7455f:
	text "Hold it."

	para "…Are you going to"
	line "take the #mon"
	cont "League challenge?"

	para "…Don't make me"
	line "laugh."

	para "You're so much"
	line "weaker than I am."

	para "I'm not like I was"
	line "before."

	para "I now have the"
	line "best and strongest"

	para "#mon with me."
	line "I'm invincible!"

	para "<PLAYER>!"
	line "I challenge you!"
	done

UnknownText_0x7463d:
	text "…I couldn't win…"

	para "I gave it every-"
	line "thing I had…"

	para "What you possess,"
	line "and what I lack…"

	para "I'm beginning to"
	line "understand what"

	para "that dragon master"
	line "said to me…"
	done

UnknownText_0x746ce:
	text "…I haven't given up"
	line "on becoming the"
	cont "greatest trainer…"

	para "I'm going to find"
	line "out why I can't"

	para "win and become"
	line "stronger…"

	para "When I do, I will"
	line "challenge you."

	para "And I'll beat you"
	line "down with all my"
	cont "power."

	para "…Humph! You keep"
	line "at it until then."
	done

UnknownText_0x747aa:
	text "…Humph!"

	para "When it comes down"
	line "to it, nothing can"
	cont "beat power."

	para "I don't need any-"
	line "thing else."
	done

LawrenceSeenText:
	text "Lawrence: I don't"
	line "understand."

	para "Where is the"
	line "legendary bird of"
	cont "fire?"

	para "I looked all over"
	line "Mt.Ember, Fire"

	para "Island, now"
	line "Victory Road…"

	para "But Moltres is"
	line "nowhere to be"
	cont "seen."

	para "Without the"
	line "complete set, I"

	para "cannot awaken the"
	line "guardian of the"
	cont "sea…"

	para "What?!"

	para "You encountered"
	line "the legendary"
	cont "birds? Before me?"

	para "Can you appreciate"
	line "the majesty of"
	cont "legendary #mon?"

	para "Have you even"
	line "heard of the"

	para "guardian of the"
	line "sea before?"

	para "This is unaccept-"
	line "able."

	para "You're going to"
	line"help me complete"
	cont "my collection!"
	done

LawrenceBeatenText:
	text "Unbelievable."
	line "You beat my legen-"
	cont "dary collection…"
	done

LawrenceAfterText:
	text "Lawrence: Your"
	line "#mon aren't"

	para "just a collection"
	line "to you, are they?"

	para "You treat them"
	line "almost like"
	cont "friends."

	para "Could that be how"
	line "you defeated my"
	cont "legendary #mon?"

	para "Well, I think you"
	line "earned this."
	done

LawrenceSilverWingText:
	text "That silver wing"
	line "feather comes from"

	para "the guardian of"
	line "the sea."

	para "The scent should"
	line "attract it, but"

	para "only if you've"
	line "mastered the three"

	para "winged mirages--"
	line "the birds of fire,"

	para "ice, and light-"
	line "ning."

	para "Or so the legends"
	line "say."
	done

LawrenceGoodbyeText:
	text "My dream was to"
	line "own that Pokemon,"

	para "but you've proven"
	line "yourself worthy."
	cont "Take it."

	para "I'll begin my"
	line "collection anew."

	para "Farewell."
	done

CooltrainermMattSeenText:
	text "I can see you're"
	line "good! Let me see"
	cont "exactly how good!"
	done

CooltrainermMattBeatenText:
	text "I had a chance…"
	done

CooltrainermMattAfterText:
	text "I concede, you're"
	line "better than me!"
	done

CooltrainerfJoanneSeenText:
	text "Victory Road is"
	line "the final test"
	cont "for trainers!"
	done

CooltrainerfJoanneBeatenText:
	text "Aiyah!"
	done

CooltrainerfJoanneAfterText:
	text "You earned the"
	line "right to be on"
	cont "Victory Road!"
	done

CooltrainerfKotoriSeenText:
	text "There's supposed"
	line "to be a Moltres"
	cont "roosting here."

	para "I'm going to catch"
	line "it!"
	done

CooltrainerfKotoriBeatenText:
	text "I'd have won if"
	line "I had a legendary"
	cont "#mon…"
	done

CooltrainerfKotoriAfterText:
	text "Did somebody"
	line "capture Moltres"
	cont "already?"
	done

CooltrainermRingoSeenText:
	text "If you can get"
	line "through here, you"

	para "can challenge the"
	line "Elite Four!"
	done

CooltrainermRingoBeatenText:
	text "No!"
	line "Inconceivable!"
	done

CooltrainermRingoAfterText:
	text "I can beat you"
	line "when it comes to"

	para "knowledge about"
	line "#mon!"
	done

VictoryRoad_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 10
	warp_def $43, $9, 5, VICTORY_ROAD_GATE
	warp_def $31, $1, 3, VICTORY_ROAD
	warp_def $23, $1, 2, VICTORY_ROAD
	warp_def $1f, $d, 5, VICTORY_ROAD
	warp_def $11, $d, 4, VICTORY_ROAD
	warp_def $21, $11, 7, VICTORY_ROAD
	warp_def $13, $11, 6, VICTORY_ROAD
	warp_def $b, $0, 9, VICTORY_ROAD
	warp_def $1b, $0, 8, VICTORY_ROAD
	warp_def $5, $d, 3, ROUTE_23

.XYTriggers:
	db 4
	xy_trigger 0, $8, $c, $0, UnknownScript_0x74492, $0, $0
	xy_trigger 0, $8, $d, $0, UnknownScript_0x744b5, $0, $0
	xy_trigger 1, $42, $9, $0, LawrenceUpScript, $0, $0
	xy_trigger 1, $43, $8, $0, LawrenceLeftScript, $0, $0

.Signposts:
	db 2
	signpost 29, 3, SIGNPOST_ITEM, VictoryRoadHiddenMaxPotion
	signpost 65, 3, SIGNPOST_ITEM, VictoryRoadHiddenFullHeal

.PersonEvents:
	db 12
	person_event SPRITE_SILVER, 13, 18, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, ObjectEvent, EVENT_RIVAL_VICTORY_ROAD
	person_event SPRITE_LAWRENCE, 62, 7, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, ObjectEvent, EVENT_RIVAL_VICTORY_ROAD
	person_event SPRITE_COOLTRAINER_M, 52, 10, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_TRAINER, 3, TrainerCooltrainermMatt, -1
	person_event SPRITE_COOLTRAINER_F, 35, 9, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_TRAINER, 4, TrainerCooltrainerfJoanne, -1
	person_event SPRITE_COOLTRAINER_F, 27, 2, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_TRAINER, 1, TrainerCooltrainerfKotori, -1
	person_event SPRITE_COOLTRAINER_M, 13, 14, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_TRAINER, 4, TrainerCooltrainermRingo, -1
	person_event SPRITE_POKE_BALL, 28, 3, SPRITEMOVEDATA_ITEM_TREE, 0, 0, -1, -1, 0, PERSONTYPE_ITEMBALL, 0, VictoryRoadTMEarthquake, EVENT_VICTORY_ROAD_TM_EARTHQUAKE
	person_event SPRITE_POKE_BALL, 48, 12, SPRITEMOVEDATA_ITEM_TREE, 0, 0, -1, -1, 0, PERSONTYPE_ITEMBALL, 0, VictoryRoadMaxRevive, EVENT_VICTORY_ROAD_MAX_REVIVE
	person_event SPRITE_POKE_BALL, 29, 18, SPRITEMOVEDATA_ITEM_TREE, 0, 0, -1, -1, 0, PERSONTYPE_ITEMBALL, 0, VictoryRoadFullRestore, EVENT_VICTORY_ROAD_FULL_RESTORE
	person_event SPRITE_POKE_BALL, 48, 15, SPRITEMOVEDATA_ITEM_TREE, 0, 0, -1, -1, 0, PERSONTYPE_ITEMBALL, 0, VictoryRoadFullHeal, EVENT_VICTORY_ROAD_FULL_HEAL
	person_event SPRITE_POKE_BALL, 38, 7, SPRITEMOVEDATA_ITEM_TREE, 0, 0, -1, -1, 0, PERSONTYPE_ITEMBALL, 0, VictoryRoadHPUp, EVENT_VICTORY_ROAD_HP_UP
	person_event SPRITE_POKE_BALL, 19, 14, SPRITEMOVEDATA_ITEM_TREE, 0, 0, -1, -1, 0, PERSONTYPE_ITEMBALL, 0, VictoryRoadRazorFang, EVENT_VICTORY_ROAD_RAZOR_FANG
