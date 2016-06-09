const_value set 2
	const YELLOWFOREST_YELLOW
	const YELLOWFOREST_POKE_BALL1
	const YELLOWFOREST_POKE_BALL2
	const YELLOWFOREST_POKE_BALL3

YellowForest_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

YellowScript:
	faceplayer
	opentext
	checkevent EVENT_BEAT_YELLOW
	iffalse YellowBattleScript
	checkevent EVENT_GOT_LIGHT_BALL_FROM_YELLOW
	iffalse YellowBattleAfterBallScript
	writetext YellowText_Goodbye
	waitbutton
	closetext
	end

YellowBattleScript:
	writetext YellowText_Greeting
	waitbutton
	closetext
	winlosstext YellowText_WinBattle, 0
	setlasttalked YELLOWFOREST_YELLOW
	loadtrainer YELLOW, 1
	startbattle
	reloadmapafterbattle
	setevent EVENT_BEAT_YELLOW
	opentext
	writetext YellowText_AfterBattle
	scall YellowTryGiveLightBallScript
	end

YellowBattleAfterBallScript:
	faceplayer
	opentext YellowText_AfterBattle
YellowTryGiveLightBallScript:
	buttonsound
	verbosegiveitem LIGHT_BALL
	iffalse NoRoomForLightBallScript
	setevent EVENT_GOT_LIGHT_BALL_FROM_YELLOW
	writetext YellowText_Goodbye
	waitbutton
NoRoomForLightBallScript:
	closetext
	end

YellowForestThunderStone:
	itemball THUNDERSTONE

YellowForestMiracleSeed:
	itemball MIRACLE_SEED

YellowForestUltraBall:
	itemball ULTRA_BALL

YellowForestHiddenBigMushroom1:
	dwb EVENT_YELLOW_FOREST_HIDDEN_BIG_MUSHROOM_1, BIG_MUSHROOM

YellowForestHiddenBigMushroom2:
	dwb EVENT_YELLOW_FOREST_HIDDEN_BIG_MUSHROOM_2, BIG_MUSHROOM

YellowText_Greeting:
	text "Yellow: Hi!"
	line "I'm Yellow!"

	para "This forest full"
	line "of Pikachu…"
	cont "It reminds me of"
	cont "home in Kanto."
	cont "Where I caught my"
	cont "first #mon."

	para "The trainer who"
	line "helped me catch it"
	cont "told me something."

	para "That if you care"
	line "for them with all"
	cont "your heart,"
	cont "they'll always be"
	cont "your friends!"

	para "I can sense that"
	line "you care about"
	cont "your #mon."

	para "So let me see"
	line "what your friends"
	cont "can do!"
	done

YellowText_WinBattle:
	text "Haha! What a"
	line "battle!"
	done

YellowText_AfterBattle:
	text "Yellow: Wow!"
	line "You really are a"
	cont "good trainer."

	para "Here's something"
	line "that your friends"
	cont "will appreciate!"
	done

YellowText_Goodbye:
	text "Yellow: Give that"
	line "Light Ball to a"
	cont "Pikachu to raise"
	cont "its power."
	done

YellowForest_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 2
	warp_def $2d, $1b, 1, YELLOW_FOREST_GATE
	warp_def $2d, $1c, 2, YELLOW_FOREST_GATE

.XYTriggers:
	db 0

.Signposts:
	db 2
	signpost 4, 30, SIGNPOST_ITEM, YellowForestHiddenBigMushroom1
	signpost 36, 34, SIGNPOST_ITEM, YellowForestHiddenBigMushroom2

.PersonEvents:
	db 4
	person_event SPRITE_YELLOW, 5, 48, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, YellowScript, -1
	person_event SPRITE_POKE_BALL, 16, 25, SPRITEMOVEDATA_ITEM_TREE, 0, 0, -1, -1, 0, PERSONTYPE_ITEMBALL, 0, YellowForestThunderStone, EVENT_YELLOW_FOREST_THUNDERSTONE
	person_event SPRITE_POKE_BALL, 24, 32, SPRITEMOVEDATA_ITEM_TREE, 0, 0, -1, -1, 0, PERSONTYPE_ITEMBALL, 0, YellowForestMiracleSeed, EVENT_YELLOW_FOREST_MIRACLE_SEED
	person_event SPRITE_POKE_BALL, 21, 11, SPRITEMOVEDATA_ITEM_TREE, 0, 0, -1, -1, 0, PERSONTYPE_ITEMBALL, 0, YellowForestUltraBall, EVENT_YELLOW_FOREST_ULTRA_BALL
	; person_event SPRITE_POKE_BALL, 24, 49, SPRITEMOVEDATA_ITEM_TREE, 0, 0, -1, -1, 0, PERSONTYPE_ITEMBALL, 0, YellowForestSurfPikachuDoll, EVENT_YELLOW_FOREST_SURF_PIKACHU_DOLL
