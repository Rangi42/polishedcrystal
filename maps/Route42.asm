Route42_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

Route42_MapEventHeader:

.Warps: db 5
	warp_def 8, 0, 3, ROUTE_42_ECRUTEAK_GATE
	warp_def 9, 0, 4, ROUTE_42_ECRUTEAK_GATE
	warp_def 5, 10, 1, MOUNT_MORTAR_1F_OUTSIDE
	warp_def 9, 28, 2, MOUNT_MORTAR_1F_OUTSIDE
	warp_def 7, 46, 3, MOUNT_MORTAR_1F_OUTSIDE

.XYTriggers: db 6
	xy_trigger 1, 6, 12, Route42LyraScript1
	xy_trigger 1, 7, 12, Route42LyraScript2
	xy_trigger 1, 8, 12, Route42LyraScript3
	xy_trigger 1, 9, 12, Route42LyraScript4
	xy_trigger 1, 6, 10, Route42LyraScript5
	xy_trigger 2, 14, 24, Route42SuicuneScript

.Signposts: db 5
	signpost 10, 4, SIGNPOST_JUMPTEXT, Route42Sign1Text
	signpost 5, 7, SIGNPOST_JUMPTEXT, MtMortarSign1Text
	signpost 9, 45, SIGNPOST_JUMPTEXT, MtMortarSign2Text
	signpost 8, 54, SIGNPOST_JUMPTEXT, Route42Sign2Text
	signpost 11, 16, SIGNPOST_ITEM + MAX_POTION, EVENT_ROUTE_42_HIDDEN_MAX_POTION

.PersonEvents: db 14
	person_event SPRITE_ROUTE_30_RATTATA, 16, 26, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, ObjectEvent, EVENT_SAW_SUICUNE_ON_ROUTE_42
	person_event SPRITE_NEW_BARK_LYRA, 5, 10, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, ObjectEvent, EVENT_LYRA_ROUTE_42
	person_event SPRITE_FISHER, 10, 40, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_TRAINER, 1, TrainerFisherTully1, -1
	person_event SPRITE_POKEFAN_M, 9, 51, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_TRAINER, 1, TrainerHikerBenjamin, -1
	cuttree_event 13, 24, EVENT_ROUTE_42_CUT_TREE
	fruittree_event 16, 27, FRUITTREE_ROUTE_42_1, PNK_APRICORN
	fruittree_event 16, 28, FRUITTREE_ROUTE_42_2, GRN_APRICORN
	fruittree_event 16, 29, FRUITTREE_ROUTE_42_3, YLW_APRICORN
	itemball_event 4, 6, ULTRA_BALL, 1, EVENT_ROUTE_42_ULTRA_BALL
	itemball_event 8, 33, SUPER_POTION, 1, EVENT_ROUTE_42_SUPER_POTION
	person_event SPRITE_OFFICER, 8, 2, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_COMMAND, jumptextfaceplayer, Route42OfficerText, EVENT_BEAT_JASMINE
	person_event SPRITE_OFFICER, 9, 2, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_COMMAND, jumptextfaceplayer, Route42OfficerText, EVENT_BEAT_JASMINE
	person_event SPRITE_OFFICER, 6, 5, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, OfficermKeithScript, EVENT_ROUTE_42_OFFICER
	person_event SPRITE_SUPER_NERD, 20, 21, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_PURPLE, PERSONTYPE_SCRIPT, 0, ObjectEvent, -1

const_value set 1
	const ROUTE42_SUICUNE
	const ROUTE42_LYRA

Route42LyraScript1:
	spriteface PLAYER, LEFT
	showemote EMOTE_SHOCK, PLAYER, 15
	special Special_FadeOutMusic
	pause 15
	variablesprite SPRITE_NEW_BARK_LYRA, SPRITE_LYRA
	special MapCallbackSprites_LoadUsedSpritesGFX
	playsound SFX_ENTER_DOOR
	appear ROUTE42_LYRA
	waitsfx
	applymovement ROUTE42_LYRA, MovementData_Route42LyraApproach1
	jump Route42LyraScript

Route42LyraScript2:
	spriteface PLAYER, LEFT
	showemote EMOTE_SHOCK, PLAYER, 15
	special Special_FadeOutMusic
	pause 15
	variablesprite SPRITE_NEW_BARK_LYRA, SPRITE_LYRA
	special MapCallbackSprites_LoadUsedSpritesGFX
	playsound SFX_ENTER_DOOR
	appear ROUTE42_LYRA
	waitsfx
	applymovement ROUTE42_LYRA, MovementData_Route42LyraApproach2
	jump Route42LyraScript

Route42LyraScript3:
	spriteface PLAYER, LEFT
	showemote EMOTE_SHOCK, PLAYER, 15
	special Special_FadeOutMusic
	pause 15
	variablesprite SPRITE_NEW_BARK_LYRA, SPRITE_LYRA
	special MapCallbackSprites_LoadUsedSpritesGFX
	playsound SFX_ENTER_DOOR
	appear ROUTE42_LYRA
	waitsfx
	applymovement ROUTE42_LYRA, MovementData_Route42LyraApproach3
	jump Route42LyraScript

Route42LyraScript4:
	spriteface PLAYER, LEFT
	showemote EMOTE_SHOCK, PLAYER, 15
	variablesprite SPRITE_NEW_BARK_LYRA, SPRITE_LYRA
	special MapCallbackSprites_LoadUsedSpritesGFX
	playsound SFX_ENTER_DOOR
	appear ROUTE42_LYRA
	waitsfx
	applymovement ROUTE42_LYRA, MovementData_Route42LyraApproach4
	jump Route42LyraScript

Route42LyraScript5:
	spriteface PLAYER, UP
	showemote EMOTE_SHOCK, PLAYER, 15
	variablesprite SPRITE_NEW_BARK_LYRA, SPRITE_LYRA
	special MapCallbackSprites_LoadUsedSpritesGFX
	playsound SFX_ENTER_DOOR
	appear ROUTE42_LYRA
	waitsfx
	applymovement PLAYER, MovementData_Route42PlayerStepsBack
	applyonemovement ROUTE42_LYRA, step_down

Route42LyraScript:
	playmusic MUSIC_LYRA_ENCOUNTER_HGSS
	showtext Route42LyraGreetingText
	setevent EVENT_LYRA_ROUTE_42
	variablesprite SPRITE_NEW_BARK_LYRA, SPRITE_LASS
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
	variablesprite SPRITE_NEW_BARK_LYRA, SPRITE_LYRA
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
	dotrigger $2
	jump .Finish
.NoSuicune
	dotrigger $0
.Finish
	variablesprite SPRITE_NEW_BARK_LYRA, SPRITE_LASS
	special MapCallbackSprites_LoadUsedSpritesGFX
	playmapmusic
	end

Route42SuicuneScript:
	showemote EMOTE_SHOCK, PLAYER, 15
	pause 15
	playsound SFX_WARP_FROM
	applymovement ROUTE42_SUICUNE, MovementData_0x1a9356
	disappear ROUTE42_SUICUNE
	pause 10
	dotrigger $0
	clearevent EVENT_SAW_SUICUNE_ON_ROUTE_36
	domaptrigger ROUTE_36, $1
	end

TrainerFisherTully1:
	trainer EVENT_BEAT_FISHER_TULLY, FISHER, TULLY1, FisherTully1SeenText, FisherTully1BeatenText, 0, FisherTully1Script

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
	writetext UnknownText_0x1a93ab
	buttonsound
	setevent EVENT_TULLY_ASKED_FOR_PHONE_NUMBER
	scall UnknownScript_0x1a92f1
	jump UnknownScript_0x1a926b

UnknownScript_0x1a9268:
	scall UnknownScript_0x1a92f5
UnknownScript_0x1a926b:
	askforphonenumber PHONE_FISHER_TULLY
	if_equal $1, UnknownScript_0x1a9305
	if_equal $2, UnknownScript_0x1a9301
	trainertotext FISHER, TULLY1, $0
	scall UnknownScript_0x1a92f9
	jump UnknownScript_0x1a92fd

UnknownScript_0x1a927f:
	scall UnknownScript_0x1a9309
	winlosstext FisherTully1BeatenText, 0
	copybytetovar wTullyFightCount
	if_equal 3, .Fight3
	if_equal 2, .Fight2
	if_equal 1, .Fight1
	if_equal 0, .LoadFight0
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
	end

UnknownScript_0x1a92f5:
	jumpstd asknumber2m
	end

UnknownScript_0x1a92f9:
	jumpstd registerednumberm
	end

UnknownScript_0x1a92fd:
	jumpstd numberacceptedm
	end

UnknownScript_0x1a9301:
	jumpstd numberdeclinedm
	end

UnknownScript_0x1a9305:
	jumpstd phonefullm
	end

UnknownScript_0x1a9309:
	jumpstd rematchm
	end

UnknownScript_0x1a930d:
	jumpstd giftm
	end

UnknownScript_0x1a9311:
	jumpstd packfullm
	end

TrainerHikerBenjamin:
	trainer EVENT_BEAT_HIKER_BENJAMIN, HIKER, BENJAMIN, HikerBenjaminSeenText, HikerBenjaminBeatenText, 0, HikerBenjaminScript

HikerBenjaminScript:
	end_if_just_battled
	jumptextfaceplayer UnknownText_0x1a943f

OfficermKeithScript:
	faceplayer
	opentext
	checknite
	iffalse .NoFight
	checkevent EVENT_BEAT_OFFICERM_KEITH
	iftrue .AfterScript
	special SaveMusic
	playmusic MUSIC_OFFICER_ENCOUNTER
	writetext OfficermKeithSeenText
	waitbutton
	closetext
	winlosstext OfficermKeithWinText, 0
	loadtrainer OFFICERM, KEITH
	startbattle
	reloadmapafterbattle
	setevent EVENT_BEAT_OFFICERM_KEITH
	endtext

.AfterScript:
	jumpopenedtext OfficermKeithAfterText

.NoFight:
	jumpopenedtext OfficermKeithDaytimeText

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

MovementData_0x1a9356:
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

OfficermKeithSeenText:
	text "Halt! What are"
	line "you doing?"
	done

OfficermKeithWinText:
	text "You know how to"
	line "defend yourself."
	done

OfficermKeithAfterText:
	text "Explore the mount-"
	line "ain if you want."

	para "I'm not worried"
	line "about you."
	done

OfficermKeithDaytimeText:
	text "The avalanche is"
	line "cleared, but you"

	para "can still get lost"
	line "or hurt in caves."
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

UnknownText_0x1a93ab:
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

UnknownText_0x1a943f:
	text "Losing feels in-"
	line "significant if you"

	para "look up at the big"
	line "sky!"
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
