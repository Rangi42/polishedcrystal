DimCave5F_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 1
	dbw MAPCALLBACK_CMDQUEUE, DimCave5FSetUpStoneTable

DimCave5F_MapEventHeader:

.Warps: db 4
	warp_def $1f, $d, 5, ROUTE_10_NORTH
	warp_def $10, $2, 1, DIM_CAVE_4F
	warp_def $1d, $1b, 2, DIM_CAVE_4F
	warp_def $19, $1c, 3, DIM_CAVE_4F

.XYTriggers: db 0

.Signposts: db 1
	signpost 28, 12, SIGNPOST_ITEM, DimCave5FHiddenXSpclAtk

.PersonEvents: db 8
	person_event SPRITE_ROCK_BOULDER_FOSSIL, 5, 25, SPRITEMOVEDATA_STRENGTH_BOULDER, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, DimCave5FBoulder, EVENT_BOULDER_IN_DIM_CAVE_5F
	person_event SPRITE_RILEY, 4, 13, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, 0, PERSONTYPE_SCRIPT, 0, DimCave5FRileyScript, EVENT_DIM_CAVE_RILEY
	person_event SPRITE_SUPER_NERD, 17, 24, SPRITEMOVEDATA_SPINCOUNTERCLOCKWISE, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_TRAINER, 3, TrainerSuper_nerdFoote, -1
	person_event SPRITE_ENGINEER, 25, 13, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_TRAINER, 3, TrainerEngineerHoward, -1
	person_event SPRITE_SUPER_NERD, 28, 21, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_TRAINER, 5, TrainerSuper_nerdDave, -1
	person_event SPRITE_BALL_CUT_FRUIT, 13, 13, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_ITEMBALL, 0, RARE_CANDY, 1, EVENT_DIM_CAVE_5F_RARE_CANDY
	person_event SPRITE_BALL_CUT_FRUIT, 26, 25, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_ITEMBALL, 0, DUSK_STONE, 1, EVENT_DIM_CAVE_5F_DUSK_STONE
	person_event SPRITE_BALL_CUT_FRUIT, 30, 9, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_ITEMBALL, 0, HYPER_POTION, 1, EVENT_DIM_CAVE_5F_HYPER_POTION

const_value set 2
	const DIMCAVE5F_BOULDER
	const DIMCAVE5F_RILEY

DimCave5FSetUpStoneTable:
	writecmdqueue .CommandQueue
	return

.CommandQueue:
	dbw CMDQUEUE_STONETABLE, .StoneTable ; check if any stones are sitting on a warp
	dw 0 ; filler

.StoneTable:
	stonetable 4, DIMCAVE5F_BOULDER, .Boulder
	db -1 ; end

.Boulder:
	disappear DIMCAVE5F_BOULDER
	clearevent EVENT_BOULDER_FELL_IN_DIM_CAVE_4F
	pause 30
	playsound SFX_STRENGTH
	earthquake 80
	opentext
	writetext .Text
	waitbutton
	closetext
	end

.Text:
	text "The boulder fell"
	line "through."
	done

DimCave5FRileyScript:
	faceplayer
	checkevent EVENT_BEAT_RILEY
	iftrue .Beaten
	opentext
	writetext .ChallengeText
	yesorno
	iffalse .No
	writetext .YesText
	waitbutton
	closetext
	winlosstext .BeatenText, 0
	setlasttalked DIMCAVE5F_RILEY
	loadtrainer RILEY, 1
	startbattle
	reloadmapafterbattle
	setevent EVENT_BEAT_RILEY
.Beaten
	opentext
	writetext .ItemText
	buttonsound
	verbosegiveitem POWER_BRACER
	iffalse .Done
	writetext .GoodbyeText
	waitbutton
	closetext
	special Special_FadeBlackQuickly
	special Special_ReloadSpritesNoPalettes
	disappear DIMCAVE5F_RILEY
	pause 15
	special Special_FadeInQuickly
	clearevent EVENT_BATTLE_TOWER_RILEY
	end

.Done:
	closetext
	end

.No:
	writetext .NoText
	waitbutton
	closetext
	end

.ChallengeText:
	text "…You are?"

	para "OK, you're"
	line "<PLAYER>."

	para "I'm Riley. I'm a"
	line "trainer, yes."

	para "I own a mine like"
	line "this one, so it's"
	cont "a good training"
	cont "spot for me."

	para "If you'd like, we"
	line "could have a"
	cont "battle."
	done

.YesText:
	text "We're pulling out"
	line "all the stops to"

	para "put your #mon"
	line "down."
	done

.NoText:
	text "Oh, all right."
	line "Then we'll continue"
	cont "training here."
	done

.BeatenText:
	text "At times we bat-"
	line "tle, and sometimes"
	cont "we team up."

	para "It's great how"
	line "trainers can"
	cont "interact."
	done

.ItemText:
	text "Know your enemy."

	para "If you know your"
	line "opponent's #mon"
	cont "and moves, your"

	para "chances of winning"
	line "are much improved."

	para "But strengthening"
	line "your own team is"
	cont "also important."

	para "This will help you"
	line "to do so."
	done

.GoodbyeText:
	text "Battling with you"
	line "was very enjoy-"
	cont "able."

	para "I intend to test"
	line "my skills in the"
	cont "Battle Tower now."

	para "Let's meet again!"

	para "Take care on the"
	line "way out."
	done

TrainerSuper_nerdFoote:
	trainer EVENT_BEAT_SUPER_NERD_FOOTE, SUPER_NERD, FOOTE, .SeenText, .BeatenText, 0, .Script

.Script:
	end_if_just_battled
	opentext
	writetext .AfterText
	waitbutton
	closetext
	end

.SeenText:
	text "I have a conundrum"
	line "for you!"

	para "Would you push one"
	line "#mon in front"

	para "of a mine cart to"
	line "save five?"
	done

.BeatenText:
	text "You answered"
	line "without words…"
	cont "How Zen!"
	done

.AfterText:
	text "Save one life or"
	line "save five?"

	para "As a #mon"
	line "trainer, you may"

	para "have the power to"
	line "save all six!"
	done

TrainerEngineerHoward:
	trainer EVENT_BEAT_ENGINEER_HOWARD, ENGINEER, HOWARD, .SeenText, .BeatenText, 0, .Script

.Script:
	end_if_just_battled
	opentext
	writetext .AfterText
	waitbutton
	closetext
	end

.SeenText:
	text "This waterfall"
	line "provides energy"
	cont "throughout Kanto!"
	done

.BeatenText:
	text "No! A blackout…"
	done

.AfterText:
	text "Water flows south"
	line "from Cerulean Cape"

	para "and follows a"
	line "steady course to"
	cont "the Power Plant."
	done

TrainerSuper_nerdDave:
	trainer EVENT_BEAT_SUPER_NERD_DAVE, SUPER_NERD, DAVE, .SeenText, .BeatenText, 0, .Script

.Script:
	end_if_just_battled
	opentext
	writetext .AfterText
	waitbutton
	closetext
	end

.SeenText:
	text "I've maxed out my"
	line "mining, jeweling,"

	para "smelting, and"
	line "crafting skills!"
	done

.BeatenText:
	text "But not"
	line "battling…"
	done

.AfterText:
	text "You need a mining"
	line "pick to mine."

	para "But you can't get"
	line "them around here."
	done

DimCave5FBoulder:
	jumpstd strengthboulder

DimCave5FHiddenXSpclAtk:
	dwb EVENT_DIM_CAVE_5F_HIDDEN_X_SPCL_ATK, X_SPCL_ATK
