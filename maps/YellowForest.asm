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
	checkevent EVENT_GOT_LIGHT_BALL_FROM_YELLOW
	iffalse YellowGiveLightBallScript
	writetext YellowText_Goodbye
	waitbutton
	closetext
	end

YellowGiveLightBallScript:
	writetext YellowText_Greeting
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
	text "Yellow: Hi! My"
	line "name is Yellow!"

	para "You're a #mon"
	line "trainer, right?"

	para "I can sense that"
	line "your #mon"
	cont "respect and trust"
	cont "you."

	para "Here, take this!"
	done

YellowText_Goodbye:
	text "Give that Light"
	line "Ball to a Pikachu"
	cont "to raise its"
	cont "power."
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
	person_event SPRITE_LASS, 5, 45, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, YellowScript, -1
	person_event SPRITE_POKE_BALL, 16, 25, SPRITEMOVEDATA_ITEM_TREE, 0, 0, -1, -1, 0, PERSONTYPE_ITEMBALL, 0, YellowForestThunderStone, EVENT_YELLOW_FOREST_THUNDERSTONE
	person_event SPRITE_POKE_BALL, 24, 32, SPRITEMOVEDATA_ITEM_TREE, 0, 0, -1, -1, 0, PERSONTYPE_ITEMBALL, 0, YellowForestMiracleSeed, EVENT_YELLOW_FOREST_MIRACLE_SEED
	person_event SPRITE_POKE_BALL, 21, 11, SPRITEMOVEDATA_ITEM_TREE, 0, 0, -1, -1, 0, PERSONTYPE_ITEMBALL, 0, YellowForestUltraBall, EVENT_YELLOW_FOREST_ULTRA_BALL
	; person_event SPRITE_POKE_BALL, 24, 49, SPRITEMOVEDATA_ITEM_TREE, 0, 0, -1, -1, 0, PERSONTYPE_ITEMBALL, 0, YellowForestSurfPikachuDoll, EVENT_YELLOW_FOREST_SURF_PIKACHU_DOLL
