YellowForest_MapScriptHeader:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_NEWMAP, YellowForestFlyPoint
	callback MAPCALLBACK_TILES, YellowForestTileScript

	def_warp_events
	warp_event 28, 47, YELLOW_FOREST_GATE, 1
	warp_event 29, 47, YELLOW_FOREST_GATE, 2

	def_coord_events
	coord_event 32, 16, 1, YellowForestBridgeOverheadTrigger
	coord_event 32, 17, 1, YellowForestBridgeOverheadTrigger
	coord_event 39, 16, 1, YellowForestBridgeOverheadTrigger
	coord_event 39, 17, 1, YellowForestBridgeOverheadTrigger
	coord_event 33, 16, 0, YellowForestBridgeUnderfootTrigger
	coord_event 33, 17, 0, YellowForestBridgeUnderfootTrigger
	coord_event 38, 16, 0, YellowForestBridgeUnderfootTrigger
	coord_event 38, 17, 0, YellowForestBridgeUnderfootTrigger

	def_bg_events
	bg_event 39, 14, BGEVENT_ITEM + BIG_MUSHROOM, EVENT_YELLOW_FOREST_HIDDEN_BIG_MUSHROOM
	bg_event 43, 36, BGEVENT_ITEM + BALMMUSHROOM, EVENT_YELLOW_FOREST_HIDDEN_BALM_MUSHROOM
	bg_event 32, 11, BGEVENT_ITEM + GOLD_LEAF, EVENT_YELLOW_FOREST_HIDDEN_GOLD_LEAF_1
	bg_event  9, 40, BGEVENT_ITEM + GOLD_LEAF, EVENT_YELLOW_FOREST_HIDDEN_GOLD_LEAF_2

	def_object_events
	object_event  7, 24, SPRITE_WALKER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 1, YellowForestWalkerScript, EVENT_YELLOW_FOREST_WALKER
	object_event  8, 24, SPRITE_MON_ICON, SPRITEMOVEDATA_POKEMON, 0, SKARMORY, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_SCRIPT, 0, ObjectEvent, EVENT_YELLOW_FOREST_SKARMORY
	object_event 47,  6, SPRITE_YELLOW, SPRITEMOVEDATA_WANDER, 1, 2, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, YellowForestYellowScript, -1
	object_event 49, 26, SPRITE_BALL_CUT_FRUIT, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_PURPLE, OBJECTTYPE_SCRIPT, 0, YellowForestSurfPikachuDoll, EVENT_DECO_SURFING_PIKACHU_DOLL
	object_event 31,  8, SPRITE_SUPER_NERD, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, YellowForestSuperNerdText, -1
	object_event 19, 41, SPRITE_SCHOOLGIRL, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 2, GenericTrainerSchoolgirlSarah, -1
	object_event 13, 34, SPRITE_SCHOOLGIRL, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 2, GenericTrainerSchoolgirlIsabel, -1
	object_event  4, 38, SPRITE_TEACHER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerTeacherKathryn, -1
	object_event 43, 42, SPRITE_BREEDER, SPRITEMOVEDATA_SPINCLOCKWISE, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerBreederSophie, -1
	object_event 15, 18, SPRITE_ACE_TRAINER_M, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, YellowForestCooltrainerMScript, -1
	tmhmball_event 25, 18, TM_LEECH_LIFE, EVENT_YELLOW_FOREST_TM_LEECH_LIFE
	itemball_event 32, 26, MIRACLE_SEED, 1, EVENT_YELLOW_FOREST_MIRACLE_SEED
	itemball_event 11, 23, BIG_ROOT, 1, EVENT_YELLOW_FOREST_BIG_ROOT
	itemball_event 50, 13, LEMONADE, 1, EVENT_YELLOW_FOREST_LEMONADE

	object_const_def
	const YELLOWFOREST_WALKER
	const YELLOWFOREST_SKARMORY
	const YELLOWFOREST_YELLOW
	const YELLOWFOREST_POKE_BALL5

YellowForestFlyPoint:
	setflag ENGINE_FLYPOINT_YELLOW_FOREST
	endcallback

YellowForestTileScript:
	checkscene
	iftrue .underfoot
	callasm YellowForest_OverheadBridgeAsm
	endcallback

.underfoot:
	callasm YellowForest_UnderfootBridgeAsm
	endcallback

YellowForest_OverheadBridgeAsm:
	changebridgeblock 32, 16, $9d, YELLOW_FOREST
	changebridgeblock 34, 16, $9e, YELLOW_FOREST
	changebridgeblock 36, 16, $9e, YELLOW_FOREST
	changebridgeblock 38, 16, $9f, YELLOW_FOREST
	jmp BufferScreen

YellowForest_UnderfootBridgeAsm:
	changebridgeblock 32, 16, $86, YELLOW_FOREST
	changebridgeblock 34, 16, $97, YELLOW_FOREST
	changebridgeblock 36, 16, $97, YELLOW_FOREST
	changebridgeblock 38, 16, $87, YELLOW_FOREST
	jmp BufferScreen

YellowForestBridgeOverheadTrigger:
	callasm YellowForest_OverheadBridgeAsm
	callthisasm
	xor a
	jr YellowForest_FinishBridge

YellowForestBridgeUnderfootTrigger:
	callasm YellowForest_UnderfootBridgeAsm
	callthisasm
	ld a, $1
YellowForest_FinishBridge:
	ld [wWalkingOnBridge], a
	ld [wYellowForestSceneID], a ; setscene a
	jmp GenericFinishBridge

GenericTrainerSchoolgirlSarah:
	generictrainer SCHOOLGIRL, SARAH, EVENT_BEAT_SCHOOLGIRL_SARAH, SchoolgirlSarahSeenText, SchoolgirlSarahBeatenText

	text "If we were at my"
	line "school, I'd have"
	cont "beaten you!"
	done

GenericTrainerSchoolgirlIsabel:
	generictrainer SCHOOLGIRL, ISABEL, EVENT_BEAT_SCHOOLGIRL_ISABEL, SchoolgirlIsabelSeenText, SchoolgirlIsabelBeatenText

	text "We're learning"
	line "about how #mon"

	para "thrive together"
	line "in the wild."
	done

GenericTrainerTeacherKathryn:
	generictrainer TEACHER, KATHRYN, EVENT_BEAT_TEACHER_KATHRYN, TeacherKathrynSeenText, TeacherKathrynBeatenText

	text "Keeping an eye on"
	line "everyone during a"

	para "field trip is"
	line "hard work."
	done

GenericTrainerBreederSophie:
	generictrainer BREEDER, SOPHIE, EVENT_BEAT_BREEDER_SOPHIE, BreederSophieSeenText, BreederSophieBeatenText

	text "Sometimes Pikachu"
	line "use their electric"

	para "shocks to revive"
	line "fainted ones."

	para "That's just the"
	line "cutest!"
	done

YellowForestWalkerScript:
	showtextfaceplayer YellowForestWalkerSeenText
	winlosstext YellowForestWalkerBeatenText, 0
	setlasttalked YELLOWFOREST_WALKER
	loadtrainer WALKER, 1
	startbattle
	reloadmapafterbattle
	setevent EVENT_BEAT_WALKER
	opentext
	writetext YellowForestWalkerAfterText
	promptbutton
	verbosegivetmhm HM_FLY
	setevent EVENT_GOT_HM02_FLY
	writetext YellowForestWalkerFinalText
	waitbutton
	closetext
	appear YELLOWFOREST_SKARMORY
	playsound SFX_BALL_POOF
	turnobject YELLOWFOREST_WALKER, RIGHT
	waitsfx
	pause 15
	cry SKARMORY
	waitsfx
	turnobject YELLOWFOREST_WALKER, DOWN
	showtext YellowForestWalkerFlyText
	playsound SFX_FLY
	special Special_FadeBlackQuickly
	special Special_ReloadSpritesNoPalettes
	disappear YELLOWFOREST_WALKER
	disappear YELLOWFOREST_SKARMORY
	waitsfx
	pause 15
	special Special_FadeInQuickly
	end

YellowForestYellowScript:
	faceplayer
	opentext
	checkevent EVENT_BEAT_YELLOW
	iffalse YellowForestYellowBattleScript
	checkevent EVENT_GOT_LIGHT_BALL_FROM_YELLOW
	iffalse YellowBattleAfterBallScript
	jumpopenedtext YellowForestYellowGoodbyeText

YellowForestYellowBattleScript:
	writetext YellowForestYellowGreetingText
	waitbutton
	closetext
	winlosstext YellowForestYellowWinLossText, 0
	setlasttalked YELLOWFOREST_YELLOW
	loadtrainer YELLOW, 1
	startbattle
	reloadmapafterbattle
	setevent EVENT_BEAT_YELLOW
	checkevent EVENT_GOT_A_POKEMON_FROM_IVY
	iffalse .skip
	clearevent EVENT_INDIGO_PLATEAU_POKECENTER_YELLOW
.skip
	opentext
	writetext YellowForestYellowAfterText
	scall YellowTryGiveLightBallScript
	end

YellowBattleAfterBallScript:
	faceplayer
	opentext
	writetext YellowForestYellowAfterText
YellowTryGiveLightBallScript:
	promptbutton
	verbosegiveitem LIGHT_BALL
	iffalse NoRoomForLightBallScript
	setevent EVENT_GOT_LIGHT_BALL_FROM_YELLOW
	writetext YellowForestYellowGoodbyeText
	waitbutton
NoRoomForLightBallScript:
	endtext

YellowForestCooltrainerMScript:
	faceplayer
	opentext
	checkevent EVENT_LISTENED_TO_SEED_BOMB_INTRO
	iftrue YellowForestTutorSeedBombScript
	writetext YellowForestCooltrainerMText
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
	setval SEED_BOMB
	writetext ClearText
	special Special_MoveTutor
	ifequal $0, .TeachMove
.TutorRefused
	jumpopenedtext Text_YellowForestTutorRefused

.NoSilverLeaf
	jumpopenedtext Text_YellowForestTutorNoSilverLeaf

.TeachMove
	takeitem SILVER_LEAF
	jumpopenedtext Text_YellowForestTutorTaught

YellowForestSurfPikachuDoll:
	disappear YELLOWFOREST_POKE_BALL5
	setevent EVENT_DECO_SURFING_PIKACHU_DOLL
	opentext
	writetext YellowForestSurfPikachuDollText
	playsound SFX_ITEM
	pause 60
	waitbutton
	jumpopenedtext YellowForestSurfPikachuDollSentText

SchoolgirlSarahSeenText:
	text "Ooh, a trainer!"
	line "I want to battle!"
	done

SchoolgirlSarahBeatenText:
	text "Sniff…"
	line "You made me lose!"
	done

SchoolgirlIsabelSeenText:
	text "Do you have cute"
	line "#mon like the"
	cont "ones here?"
	done

SchoolgirlIsabelBeatenText:
	text "You have really"
	line "strong #mon!"
	done

TeacherKathrynSeenText:
	text "You there!"
	line "You're a trainer?"

	para "You had better not"
	line "make my students"
	cont "cry!"
	done

TeacherKathrynBeatenText:
	text "I won't let this"
	line "make me cry…"
	done

BreederSophieSeenText:
	text "Did you know that"
	line "Pikachu is an"
	cont "evolved #mon?"
	done

BreederSophieBeatenText:
	text "I thought so!"
	done

YellowForestWalkerSeenText:
	text "Hello there!"
	line "The name's Walker."

	para "I was once the Gym"
	line "Leader of Violet"

	para "City, but I left"
	line "that to my son."

	para "Now I wander"
	line "through Johto and"

	para "take in the"
	line "sights."

	para "Walker: You're"
	line "collecting Gym"
	cont "badges, huh?"

	para "Then my son lost"
	line "to you!"

	para "Now I want to"
	line "test your skill"
	cont "for myself."

	para "I don't have a"
	line "badge, but you'll"

	para "get something"
	line "nice if you win!"
	done

YellowForestWalkerBeatenText:
	text "My bird #mon…"
	line "Taken down!"
	done

YellowForestWalkerAfterText:
	text "Walker: Well, I"
	line "can see why you"

	para "won against"
	line "Falkner."

	para "You know your"
	line "#mon inside"
	cont "and out!"

	para "You've earned"
	line "this HM."
	done

YellowForestWalkerFinalText:
	text "Walker: Bird"
	line "#mon soar"

	para "through the sky"
	line "because that's"

	para "what they want to"
	line "do with all their"
	cont "heart."

	para "If you want some-"
	line "thing that badly,"

	para "I know you can"
	line "reach it."

	para "What I want is"
	line "to keep wandering."

	para "Goodbye!"
	done

YellowForestWalkerFlyText:
	text "Skarmory,"
	line "let's Fly!"
	done

YellowForestYellowGreetingText:
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

YellowForestYellowWinLossText:
	text "Haha! What a"
	line "battle!"
	done

YellowForestYellowAfterText:
	text "Yellow: Wow!"
	line "You really are a"

	para "good trainer."
	line "Here's something"

	para "that your friends"
	line "will appreciate!"
	done

YellowForestYellowGoodbyeText:
	text "Yellow: Give that"
	line "Light Ball to a"

	para "Pikachu to raise"
	line "its power."
	done

YellowForestCooltrainerMText:
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

Text_YellowForestTutorTaught:
	text "Now your #mon"
	line "knows how to use"
	cont "Seed Bomb!"
	done

YellowForestSuperNerdText:
	text "There's a protein"
	line "in your body"
	cont "called pikachurin."

	para "What inspired that"
	line "name?"

	para "Pikachu, of"
	line "course!"
	done

YellowForestSurfPikachuDollText:
	text "<PLAYER> found"
	line "Surf Pikachu Doll."
	done

YellowForestSurfPikachuDollSentText:
	text "Surf Pikachu Doll"
	line "was sent home."
	done
