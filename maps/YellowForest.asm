const_value set 2
	const YELLOWFOREST_YELLOW
	const YELLOWFOREST_COOLTRAINER_F
	const YELLOWFOREST_POKE_BALL1
	const YELLOWFOREST_POKE_BALL2
	const YELLOWFOREST_POKE_BALL3
	const YELLOWFOREST_POKE_BALL4

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

YellowForestCooltrainerFScript:
	faceplayer
	opentext
	checkevent EVENT_LISTENED_TO_SEED_BOMB_INTRO
	iftrue YellowForestTutorSeedBombScript
	writetext YellowForestCooltrainerFText
	waitbutton
	setevent EVENT_LISTENED_TO_SEED_BOMB_INTRO
YellowForestTutorSeedBombScript:
	writetext Text_YellowForestTutorSeedBomb
	waitbutton
	checkitem SILVER_LEAF
	iffalse .NoSilverLeaf
	writetext Text_YellowForestTutorQuestion
	yesorno
	iffalse .TutorRefused
	writebyte SEED_BOMB
	writetext Text_YellowForestTutorClear
	special Special_MoveTutor
	if_equal $0, .TeachMove
.TutorRefused
	writetext Text_YellowForestTutorRefused
	waitbutton
	closetext
	end

.NoSilverLeaf
	writetext Text_YellowForestTutorNoSilverLeaf
	waitbutton
	closetext
	end

.TeachMove
	takeitem SILVER_LEAF
	writetext Text_YellowForestTutorTaught
	waitbutton
	closetext
	end

YellowForestThunderStone:
	itemball THUNDERSTONE

YellowForestMiracleSeed:
	itemball MIRACLE_SEED

YellowForestUltraBall:
	itemball ULTRA_BALL

YellowForestSurfPikachuDoll:
	disappear YELLOWFOREST_POKE_BALL4
	setevent EVENT_DECO_SURFING_PIKACHU_DOLL
	opentext
	writetext YellowForestSurfPikachuDollText
	playsound SFX_ITEM
	pause 60
	waitbutton
	writetext YellowForestSurfPikachuDollSentText
	waitbutton
	closetext
	end

YellowForestHiddenBigMushroom1:
	dwb EVENT_YELLOW_FOREST_HIDDEN_BIG_MUSHROOM_1, BIG_MUSHROOM

YellowForestHiddenBigMushroom2:
	dwb EVENT_YELLOW_FOREST_HIDDEN_BIG_MUSHROOM_2, BIG_MUSHROOM

YellowForestHiddenGoldLeaf1:
	dwb EVENT_YELLOW_FOREST_HIDDEN_GOLD_LEAF_1, GOLD_LEAF

YellowForestHiddenGoldLeaf2:
	dwb EVENT_YELLOW_FOREST_HIDDEN_GOLD_LEAF_2, GOLD_LEAF

YellowText_Greeting:
	text "Yellow: Hi!"
	line "I'm Yellow!"

	para "This forest full"
	line "of Pikachu…"

	para "It reminds me of"
	line "home in Kanto."

	para "Where I caught my"
	line "first #mon."

	para "The trainer who"
	line "helped me catch it"
	cont "told me something."

	para "That if you care"
	line "for #mon with"

	para "all your heart,"
	line "they'll always be"
	cont "your friends!"

	para "I can sense that"
	line "you care about"

	para "your #mon."
	line "So let me see"

	para "what your friends"
	line "can do!"
	done

YellowText_WinBattle:
	text "Haha! What a"
	line "battle!"
	done

YellowText_AfterBattle:
	text "Yellow: Wow!"
	line "You really are a"

	para "good trainer."
	line "Here's something"

	para "that your friends"
	line "will appreciate!"
	done

YellowText_Goodbye:
	text "Yellow: Give that"
	line "Light Ball to a"

	para "Pikachu to raise"
	line "its power."
	done

YellowForestCooltrainerFText:
	text "Seeds are surpris-"
	line "ingly powerful."

	para "Over many years,"
	line "a small seed can"

	para "grow into a huge"
	line "tree."

	para "And a big seed can"
	line "just fall down and"
	cont "hit you!"
	done

Text_YellowForestTutorSeedBomb:
	text "I can teach your"
	line "#mon how to"

	para "use Seed Bomb"
	line "for a Silver Leaf."
	done

Text_YellowForestTutorNoSilverLeaf:
	text "Aw, you don't have"
	line "a Silver Leaf."
	done

Text_YellowForestTutorQuestion:
	text "Should I teach"
	line "your #mon"
	cont "Seed Bomb?"
	done

Text_YellowForestTutorRefused:
	text "Talk to me if you"
	line "change your mind!"
	done

Text_YellowForestTutorClear:
	text ""
	done

Text_YellowForestTutorTaught:
	text "Now your #mon"
	line "knows how to use"
	cont "Seed Bomb!"
	done

YellowForestSurfPikachuDollText:
	text "<PLAYER> found"
	line "Surf Pikachu Doll."
	done

YellowForestSurfPikachuDollSentText:
	text "Surf Pikachu Doll"
	line "was sent home."
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
	db 4
	signpost 4, 30, SIGNPOST_ITEM, YellowForestHiddenBigMushroom1
	signpost 36, 34, SIGNPOST_ITEM, YellowForestHiddenBigMushroom2
	signpost 37, 5, SIGNPOST_ITEM, YellowForestHiddenGoldLeaf1
	signpost 16, 17, SIGNPOST_ITEM, YellowForestHiddenGoldLeaf2

.PersonEvents:
	db 6
	person_event SPRITE_YELLOW, 5, 48, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, YellowScript, -1
	person_event SPRITE_COOLTRAINER_F, 32, 20, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, YellowForestCooltrainerFScript, -1
	person_event SPRITE_POKE_BALL, 16, 25, SPRITEMOVEDATA_ITEM_TREE, 0, 0, -1, -1, 0, PERSONTYPE_ITEMBALL, 0, YellowForestThunderStone, EVENT_YELLOW_FOREST_THUNDERSTONE
	person_event SPRITE_POKE_BALL, 24, 32, SPRITEMOVEDATA_ITEM_TREE, 0, 0, -1, -1, 0, PERSONTYPE_ITEMBALL, 0, YellowForestMiracleSeed, EVENT_YELLOW_FOREST_MIRACLE_SEED
	person_event SPRITE_POKE_BALL, 21, 11, SPRITEMOVEDATA_ITEM_TREE, 0, 0, -1, -1, 0, PERSONTYPE_ITEMBALL, 0, YellowForestUltraBall, EVENT_YELLOW_FOREST_ULTRA_BALL
	person_event SPRITE_POKE_BALL, 24, 49, SPRITEMOVEDATA_ITEM_TREE, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, YellowForestSurfPikachuDoll, EVENT_DECO_SURFING_PIKACHU_DOLL
