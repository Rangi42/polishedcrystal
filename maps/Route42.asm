Route42_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  0,  8, ROUTE_42_ECRUTEAK_GATE, 3
	warp_event  0,  9, ROUTE_42_ECRUTEAK_GATE, 4
	warp_event 10,  5, MOUNT_MORTAR_1F_OUTSIDE, 1
	warp_event 28,  9, MOUNT_MORTAR_1F_OUTSIDE, 2
	warp_event 46,  7, MOUNT_MORTAR_1F_OUTSIDE, 3

	def_coord_events
	coord_event 12,  6, 1, Route42LyraScript1
	coord_event 12,  7, 1, Route42LyraScript2
	coord_event 12,  8, 1, Route42LyraScript3
	coord_event 12,  9, 1, Route42LyraScript4
	coord_event 10,  6, 1, Route42LyraScript5
	coord_event 24, 14, 2, Route42SuicuneScript

	def_bg_events
	bg_event  4, 10, BGEVENT_JUMPTEXT, Route42Sign1Text
	bg_event  7,  5, BGEVENT_JUMPTEXT, MtMortarSign1Text
	bg_event 45,  9, BGEVENT_JUMPTEXT, MtMortarSign2Text
	bg_event 54,  8, BGEVENT_JUMPTEXT, Route42Sign2Text
	bg_event 16, 11, BGEVENT_ITEM + MAX_POTION, EVENT_ROUTE_42_HIDDEN_MAX_POTION

	def_object_events
	object_event 26, 16, SPRITE_MON_ICON, SPRITEMOVEDATA_POKEMON, 0, SUICUNE, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, ObjectEvent, EVENT_SAW_SUICUNE_ON_ROUTE_42
	object_event 10,  5, SPRITE_LYRA, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, ObjectEvent, EVENT_LYRA_ROUTE_42
	object_event 40, 10, SPRITE_FISHER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, OBJECTTYPE_TRAINER, 1, TrainerFisherTully1, -1
	object_event 51,  9, SPRITE_HIKER, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerHikerBenjamin, -1
	object_event 47,  8, SPRITE_POKEMANIAC, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerPokemaniacShane, -1
	object_event  2,  8, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, Route42OfficerText, EVENT_BEAT_JASMINE
	object_event  2,  9, SPRITE_OFFICER_F, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, Route42OfficerText, EVENT_BEAT_JASMINE
	cuttree_event 24, 13, EVENT_ROUTE_42_CUT_TREE
	fruittree_event 27, 16, FRUITTREE_ROUTE_42_1, PNK_APRICORN, PAL_NPC_RED
	fruittree_event 28, 16, FRUITTREE_ROUTE_42_2, GRN_APRICORN, PAL_NPC_GREEN
	fruittree_event 29, 16, FRUITTREE_ROUTE_42_3, YLW_APRICORN, PAL_NPC_BROWN
	itemball_event  6,  4, ULTRA_BALL, 1, EVENT_ROUTE_42_ULTRA_BALL
	itemball_event 33,  8, SUPER_POTION, 1, EVENT_ROUTE_42_SUPER_POTION

	object_const_def
	const ROUTE42_SUICUNE
	const ROUTE42_LYRA

Route42LyraScript1:
	turnobject PLAYER, LEFT
	showemote EMOTE_SHOCK, PLAYER, 15
	special Special_FadeOutMusic
	pause 15
	playsound SFX_ENTER_DOOR
	appear ROUTE42_LYRA
	waitsfx
	applymovement ROUTE42_LYRA, MovementData_Route42LyraApproach1
	jump Route42LyraScript

Route42LyraScript2:
	turnobject PLAYER, LEFT
	showemote EMOTE_SHOCK, PLAYER, 15
	special Special_FadeOutMusic
	pause 15
	playsound SFX_ENTER_DOOR
	appear ROUTE42_LYRA
	waitsfx
	applymovement ROUTE42_LYRA, MovementData_Route42LyraApproach2
	jump Route42LyraScript

Route42LyraScript3:
	turnobject PLAYER, LEFT
	showemote EMOTE_SHOCK, PLAYER, 15
	special Special_FadeOutMusic
	pause 15
	playsound SFX_ENTER_DOOR
	appear ROUTE42_LYRA
	waitsfx
	applymovement ROUTE42_LYRA, MovementData_Route42LyraApproach3
	jump Route42LyraScript

Route42LyraScript4:
	turnobject PLAYER, LEFT
	showemote EMOTE_SHOCK, PLAYER, 15
	playsound SFX_ENTER_DOOR
	appear ROUTE42_LYRA
	waitsfx
	applymovement ROUTE42_LYRA, MovementData_Route42LyraApproach4
	jump Route42LyraScript

Route42LyraScript5:
	turnobject PLAYER, UP
	showemote EMOTE_SHOCK, PLAYER, 15
	playsound SFX_ENTER_DOOR
	appear ROUTE42_LYRA
	waitsfx
	applymovement PLAYER, MovementData_Route42PlayerStepsBack
	applyonemovement ROUTE42_LYRA, step_down

Route42LyraScript:
	playmusic MUSIC_LYRA_ENCOUNTER_HGSS
	showtext Route42LyraGreetingText
	setevent EVENT_LYRA_ROUTE_42
	winlosstext Route42LyraWinText, Route42LyraLossText
	setlasttalked ROUTE42_LYRA
	checkevent EVENT_GOT_TOTODILE_FROM_ELM
	iftrue .Totodile
	checkevent EVENT_GOT_CHIKORITA_FROM_ELM
	iftrue .Chikorita
	loadtrainer LYRA1, LYRA1_7
	jump .AfterBattle

.Totodile:
	loadtrainer LYRA1, LYRA1_8
	jump .AfterBattle

.Chikorita:
	loadtrainer LYRA1, LYRA1_9
.AfterBattle
	startbattle
	dontrestartmapmusic
	reloadmapafterbattle
	special DeleteSavedMusic
	playmusic MUSIC_LYRA_DEPARTURE_HGSS
	opentext
	writetext Route42LyraPresentText
	buttonsound
	verbosegivetmhm HM_WHIRLPOOL
	setevent EVENT_GOT_HM05_WHIRLPOOL
	writetext Route42LyraWhirlpoolText
	waitbutton
	closetext
	applymovement ROUTE42_LYRA, MovementData_Route42LyraLeave
	disappear ROUTE42_LYRA
	checkevent EVENT_SAW_SUICUNE_ON_ROUTE_42
	iftrue .NoSuicune
	setscene $2
	jump .Finish
.NoSuicune
	setscene $0
.Finish
	playmapmusic
	end

Route42SuicuneScript:
	showemote EMOTE_SHOCK, PLAYER, 15
	pause 15
	playsound SFX_WARP_FROM
	applymovement ROUTE42_SUICUNE, Route42SuicuneMovement
	disappear ROUTE42_SUICUNE
	pause 10
	setscene $0
	clearevent EVENT_SAW_SUICUNE_ON_ROUTE_36
	setmapscene ROUTE_36, $1
	end

TrainerFisherTully1:
	trainer FISHER, TULLY1, EVENT_BEAT_FISHER_TULLY, FisherTully1SeenText, FisherTully1BeatenText, 0, FisherTully1Script

FisherTully1Script:
	writecode VAR_CALLERID, PHONE_FISHER_TULLY
	opentext
	checkflag ENGINE_TULLY
	iftrue UnknownScript_0x1a927f
	checkflag ENGINE_TULLY_HAS_WATER_STONE
	iftrue UnknownScript_0x1a92dc
	checkcellnum PHONE_FISHER_TULLY
	iftrue UnknownScript_0x1a92fd
	checkevent EVENT_TULLY_ASKED_FOR_PHONE_NUMBER
	iftrue UnknownScript_0x1a9268
	writetext FisherTullyAfterBattleText
	buttonsound
	setevent EVENT_TULLY_ASKED_FOR_PHONE_NUMBER
	scall UnknownScript_0x1a92f1
	jump UnknownScript_0x1a926b

UnknownScript_0x1a9268:
	scall UnknownScript_0x1a92f5
UnknownScript_0x1a926b:
	askforphonenumber PHONE_FISHER_TULLY
	ifequal $1, UnknownScript_0x1a9305
	ifequal $2, UnknownScript_0x1a9301
	trainertotext FISHER, TULLY1, $0
	scall UnknownScript_0x1a92f9
	jump UnknownScript_0x1a92fd

UnknownScript_0x1a927f:
	scall UnknownScript_0x1a9309
	winlosstext FisherTully1BeatenText, 0
	copybytetovar wTullyFightCount
	ifequal 3, .Fight3
	ifequal 2, .Fight2
	ifequal 1, .Fight1
	ifequal 0, .LoadFight0
.Fight3:
	checkevent EVENT_RESTORED_POWER_TO_KANTO
	iftrue .LoadFight3
.Fight2:
	checkevent EVENT_BEAT_ELITE_FOUR
	iftrue .LoadFight2
.Fight1:
	checkevent EVENT_CLEARED_ROCKET_HIDEOUT
	iftrue .LoadFight1
.LoadFight0:
	loadtrainer FISHER, TULLY1
	startbattle
	reloadmapafterbattle
	loadvar wTullyFightCount, 1
	clearflag ENGINE_TULLY
	end

.LoadFight1:
	loadtrainer FISHER, TULLY2
	startbattle
	reloadmapafterbattle
	loadvar wTullyFightCount, 2
	clearflag ENGINE_TULLY
	end

.LoadFight2:
	loadtrainer FISHER, TULLY3
	startbattle
	reloadmapafterbattle
	loadvar wTullyFightCount, 3
	clearflag ENGINE_TULLY
	end

.LoadFight3:
	loadtrainer FISHER, TULLY4
	startbattle
	reloadmapafterbattle
	clearflag ENGINE_TULLY
	end

UnknownScript_0x1a92dc:
	scall UnknownScript_0x1a930d
	verbosegiveitem WATER_STONE
	iffalse UnknownScript_0x1a92ee
	clearflag ENGINE_TULLY_HAS_WATER_STONE
	setevent EVENT_TULLY_GAVE_WATER_STONE
	jump UnknownScript_0x1a92fd

UnknownScript_0x1a92ee:
	jump UnknownScript_0x1a9311

UnknownScript_0x1a92f1:
	jumpstd asknumber1m

UnknownScript_0x1a92f5:
	jumpstd asknumber2m

UnknownScript_0x1a92f9:
	jumpstd registerednumberm

UnknownScript_0x1a92fd:
	jumpstd numberacceptedm

UnknownScript_0x1a9301:
	jumpstd numberdeclinedm

UnknownScript_0x1a9305:
	jumpstd phonefullm

UnknownScript_0x1a9309:
	jumpstd rematchm

UnknownScript_0x1a930d:
	jumpstd giftm

UnknownScript_0x1a9311:
	jumpstd packfullm

GenericTrainerHikerBenjamin:
	generictrainer HIKER, BENJAMIN, EVENT_BEAT_HIKER_BENJAMIN, HikerBenjaminSeenText, HikerBenjaminBeatenText

	text "Losing feels in-"
	line "significant if you"

	para "look up at the big"
	line "sky!"
	done

GenericTrainerPokemaniacShane:
	generictrainer POKEMANIAC, SHANE, EVENT_BEAT_POKEMANIAC_SHANE, PokemaniacShaneSeenText, PokemaniacShaneBeatenText

	text "You're working on"
	line "a #dex?"

	para "Wow, you must know"
	line "some pretty rare"
	cont "#mon!"

	para "May I please see"
	line "it. Please?"
	done

MovementData_Route42LyraApproach4:
	step_down
MovementData_Route42LyraApproach3:
	step_down
MovementData_Route42LyraApproach2:
	step_down
MovementData_Route42LyraApproach1:
	step_down
	step_right
	step_end

MovementData_Route42PlayerStepsBack:
	fix_facing
	step_down
	remove_fixed_facing
	step_end

MovementData_Route42LyraLeave:
	step_left
	step_left
	step_left
	step_left
	step_left
	step_end

Route42SuicuneMovement:
	fix_facing
	fast_jump_step_up
	fast_jump_step_up
	fast_jump_step_up
	fast_jump_step_right
	fast_jump_step_right
	fast_jump_step_right
	step_end

Route42LyraGreetingText:
	text "Lyra: Hi, <PLAYER>!"

	para "What a coinci-"
	line "dence. I was just"

	para "studying the eff-"
	line "ects of the recent"

	para "avalanche on wild"
	line "#mon."

	para "So you're heading"
	line "to Mahogany Town"

	para "for another Gym"
	line "badge?"

	para "Then I have a"
	line "present for you!"

	para "But you'll have to"
	line "beat me first!"
	done

Route42LyraWinText:
	text "You've earned this"
	line "gift!"
	done

Route42LyraLossText:
	text "Better luck next"
	line "time…"
	done

Route42LyraPresentText:
	text "Lyra: Wow, you're"
	line "getting really"
	cont "strong, <PLAYER>!"

	para "I'm sure you can"
	line "beat the Mahogany"
	cont "Gym Leader."

	para "And then you can"
	line "use this!"
	done

Route42LyraWhirlpoolText:
	text "Lyra: That's"
	line "Whirlpool."

	para "Teach it to a"
	line "#mon to get"
	cont "across wild water."

	para "I should get"
	line "going. It was"

	para "nice seeing you,"
	line "<PLAYER>!"

	para "Bye now!"
	done

FisherTully1SeenText:
	text "Let me demonstrate"
	line "the power of the"
	cont "#mon I caught!"
	done

FisherTully1BeatenText:
	text "What? That's not"
	line "right."
	done

FisherTullyAfterBattleText:
	text "I want to become"
	line "the trainer Champ"

	para "using the #mon"
	line "I caught."

	para "That's the best"
	line "part of fishing!"
	done

HikerBenjaminSeenText:
	text "Ah, it's good to"
	line "be outside!"
	cont "I feel so free!"
	done

HikerBenjaminBeatenText:
	text "Gahahah!"
	done

PokemaniacShaneSeenText:
	text "HEY!"

	para "This is my secret"
	line "place! Get lost,"
	cont "you outsider!"
	done

PokemaniacShaneBeatenText:
	text "I should have used"
	line "my Moon Stone…"
	done

Route42OfficerText:
	text "Sorry, you can't"
	line "come this way."

	para "There's been an"
	line "avalanche on"
	cont "Mt.Mortar."

	para "We're still clear-"
	line "ing the rubble."
	done

Route42Sign1Text:
	text "Route 42"

	para "Ecruteak City -"
	line "Mahogany Town"
	done

MtMortarSign1Text:
	text "Mt.Mortar"

	para "Waterfall Cave"
	line "Inside"
	done

MtMortarSign2Text:
	text "Mt.Mortar"

	para "Waterfall Cave"
	line "Inside"
	done

Route42Sign2Text:
	text "Route 42"

	para "Ecruteak City -"
	line "Mahogany Town"
	done
