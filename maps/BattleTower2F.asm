BattleTower2F_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  0,  1, BATTLE_TOWER_1F, 4

	def_coord_events

	def_bg_events
	bg_event  4,  3, BGEVENT_UP, BattleTower2FTVScript
	bg_event  5,  3, BGEVENT_UP, BattleTower2FTVScript
	bg_event 16,  3, BGEVENT_UP, BattleTower2FTVScript
	bg_event 17,  3, BGEVENT_UP, BattleTower2FTVScript

	def_object_events
	object_event  4,  6, SPRITE_CHERYL, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, BattleTower2FCherylScript, EVENT_BATTLE_TOWER_CHERYL
	object_event  7,  7, SPRITE_RILEY, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, BattleTower2FRileyScript, EVENT_BATTLE_TOWER_RILEY
	object_event  9,  4, SPRITE_BUCK, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, BattleTower2FBuckScript, EVENT_BATTLE_TOWER_BUCK
	object_event 17,  8, SPRITE_MARLEY, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, BattleTower2FMarleyScript, EVENT_BATTLE_TOWER_MARLEY
	object_event 12,  7, SPRITE_MIRA, SPRITEMOVEDATA_WALK_UP_DOWN, 1, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, BattleTower2FMiraScript, EVENT_BATTLE_TOWER_MIRA
	object_event 15,  6, SPRITE_ANABEL, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, BattleTower2FAnabelScript, EVENT_BATTLE_TOWER_ANABEL
	object_event  4,  6, SPRITE_ACE_TRAINER_M, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, BattleTower2FCooltrainermText, EVENT_MURKY_SWAMP_CHERYL
	object_event  7,  7, SPRITE_LADY, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_COMMAND, jumptextfaceplayer, BattleTower2FLadyText, EVENT_DIM_CAVE_RILEY
	object_event  9,  4, SPRITE_SCHOOLGIRL, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, BattleTower2FTwinText, EVENT_CINNABAR_VOLCANO_BUCK
	object_event 17,  8, SPRITE_POKEMANIAC, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, BattleTower2FSuperNerdText, EVENT_QUIET_CAVE_MARLEY
	pokemon_event 18,  8, PIKACHU, -1, -1, PAL_NPC_RED, BattleTower2FPikachuText, EVENT_QUIET_CAVE_MARLEY
	object_event 12,  7, SPRITE_YOUNGSTER, SPRITEMOVEDATA_WALK_UP_DOWN, 1, 0, -1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, BattleTower2FYoungsterText, EVENT_SCARY_CAVE_MIRA
	object_event 15,  6, SPRITE_BLACK_BELT, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, BattleTower2FBlackbeltText, EVENT_NOISY_FOREST_ANABEL

	object_const_def
	const BATTLETOWER2F_CHERYL
	const BATTLETOWER2F_RILEY
	const BATTLETOWER2F_BUCK
	const BATTLETOWER2F_MARLEY
	const BATTLETOWER2F_MIRA
	const BATTLETOWER2F_ANABEL

BattleTower2FTVScript:
	jumpthistext

	text "There's an intense"
	line "battle on the TV."
	done

BattleTower2FCherylScript:
	checkflag ENGINE_CHERYL_DONE_TODAY
	iftrue_jumptextfaceplayer .AfterText
	faceplayer
	opentext
	writethistext
		text "Oh, hello,"
		line "<PLAYER>."

		para "It's been a long"
		line "time… Hasn't it?"

		para "Would you care"
		line "to have a battle"
		cont "with me?"
		done
	yesorno
	iffalse_jumpopenedtext .RefuseText
	setflag ENGINE_CHERYL_DONE_TODAY
	writethistext
		text "I should warn you,"
		line "my #mon can be"
		cont "quite rambunc-"
		cont "tious."
		done
	waitbutton
	closetext
	winlosstext .BeatenText, 0
	setlasttalked BATTLETOWER2F_CHERYL
	checkevent EVENT_BEAT_ELITE_FOUR_AGAIN
	iftrue .Team3
	checkevent EVENT_BEAT_ELITE_FOUR
	iftrue .Team2
	loadtrainer CHERYL, 1
	sjump .StartBattle
.Team2
	loadtrainer CHERYL, 2
	sjump .StartBattle
.Team3
	loadtrainer CHERYL, 3
.StartBattle
	startbattle
	reloadmapafterbattle
	jumpthistext

.AfterText:
	text "Being a trainer"
	line "isn't easy."

	para "The more you"
	line "battle, the more"
	cont "you discover."

	para "But, you know?"
	line "I love #mon"
	cont "for that, too!"
	done

.BeatenText:
	text "Striking the right"
	line "balance of offense"
	cont "and defense…"

	para "It's not easy"
	line "to do."
	done

.RefuseText:
	text "Giggle…"

	para "#mon would get"
	line "all worn out if we"

	para "battled all the"
	line "time, wouldn't"
	cont "they?"
	done

BattleTower2FRileyScript:
	checkflag ENGINE_RILEY_DONE_TODAY
	iftrue_jumptextfaceplayer .AfterText
	faceplayer
	opentext
	writethistext
		text "Hi. Long time,"
		line "no see."

		para "That look you"
		line "have… I take it"

		para "you're ready for"
		line "battle?"
		done
	yesorno
	iffalse_jumpopenedtext .RefuseText
	setflag ENGINE_RILEY_DONE_TODAY
	writethistext
		text "Battling is our"
		line "way of greeting!"
		done
	waitbutton
	closetext
	winlosstext .BeatenText, 0
	setlasttalked BATTLETOWER2F_RILEY
	checkevent EVENT_BEAT_ELITE_FOUR_AGAIN
	iftrue .Team2
	loadtrainer RILEY, 1
	sjump .StartBattle
.Team2
	loadtrainer RILEY, 2
.StartBattle
	startbattle
	reloadmapafterbattle
	jumpthistext

.AfterText:
	text "If I weren't in"
	line "Dim Cave then…"

	para "If you hadn't been"
	line "in Dim Cave then…"

	para "Perhaps we would"
	line "have never met."

	para "Or, would we have"
	line "met elsewhere?"
	done

.BeatenText:
	text "At times we bat-"
	line "tle, and sometimes"
	cont "we team up."

	para "It's great how"
	line "trainers can"
	cont "interact."
	done

.RefuseText:
	text "Oh, all right."
	line "Then we'll wait"
	cont "till you're ready."
	done

BattleTower2FBuckScript:
	checkflag ENGINE_BUCK_DONE_TODAY
	iftrue_jumptextfaceplayer .AfterText
	faceplayer
	opentext
	writethistext
		text "Ehehehe! You're"
		line "here at last!"

		para "So we are going"
		line "to battle?"
		done
	yesorno
	iffalse_jumpopenedtext .RefuseText
	setflag ENGINE_BUCK_DONE_TODAY
	writethistext
		text "I can feel my"
		line "#mon shivering"

		para "inside their #"
		line "Balls with antici-"
		cont "pation!"
		done
	waitbutton
	closetext
	winlosstext .BeatenText, 0
	setlasttalked BATTLETOWER2F_BUCK
	checkevent EVENT_BEAT_ELITE_FOUR_AGAIN
	iftrue .Team2
	loadtrainer BUCK, 1
	sjump .StartBattle
.Team2
	loadtrainer BUCK, 2
.StartBattle
	startbattle
	reloadmapafterbattle
	jumpthistext

.AfterText:
	text "Fweh! Too much!"

	para "I guess I'll keep"
	line "improving my team."
	done

.BeatenText:
	text "Heeheehee!"
	line "So hot, you!"
	done

.RefuseText:
	text "Huh, what? That"
	line "takes the wind out"
	cont "of my sails."
	done

BattleTower2FMarleyScript:
	checkflag ENGINE_MARLEY_DONE_TODAY
	iftrue_jumptextfaceplayer .AfterText
	faceplayer
	opentext
	writethistext
		text "…Oh? A battle?"
		line "With me?"
		done
	yesorno
	iffalse_jumpopenedtext .RefuseText
	setflag ENGINE_MARLEY_DONE_TODAY
	writethistext
		text "…OK. I… won't"
		line "lose…!"
		done
	waitbutton
	closetext
	winlosstext .BeatenText, 0
	setlasttalked BATTLETOWER2F_MARLEY
	checkevent EVENT_BEAT_ELITE_FOUR_AGAIN
	iftrue .Team3
	checkevent EVENT_BEAT_ELITE_FOUR
	iftrue .Team2
	loadtrainer MARLEY, 1
	sjump .StartBattle
.Team2
	loadtrainer MARLEY, 2
	sjump .StartBattle
.Team3
	loadtrainer MARLEY, 3
.StartBattle
	startbattle
	reloadmapafterbattle
	jumpthistext

.AfterText:
	text "…I might like"
	line "battling with you."

	para "…Just a little."
	line "Only a tiny bit."
	done

.BeatenText:
	text "…Awww."
	done

.RefuseText:
	text "…Oh, you. I'm get-"
	line "ting to dislike"
	cont "you a little."
	done

BattleTower2FMiraScript:
	checkflag ENGINE_MIRA_DONE_TODAY
	iftrue_jumptextfaceplayer .AfterText
	faceplayer
	opentext
	writethistext
		text "<PLAYER>! Mira is"
		line "stronger now!"

		para "Please! Battle"
		line "with Mira!"
		done
	yesorno
	iffalse_jumpopenedtext .RefuseText
	setflag ENGINE_MIRA_DONE_TODAY
	writethistext
		text "Mira will show you"
		line "that Mira doesn't"

		para "get lost anymore,"
		line "<PLAYER>!"
		done
	waitbutton
	closetext
	winlosstext .BeatenText, 0
	setlasttalked BATTLETOWER2F_MIRA
	checkevent EVENT_BEAT_ELITE_FOUR_AGAIN
	iftrue .Team2
	loadtrainer MIRA, 1
	sjump .StartBattle
.Team2
	loadtrainer MIRA, 2
.StartBattle
	startbattle
	reloadmapafterbattle
	jumpthistext

.AfterText:
	text "<PLAYER>, you are"
	line "always with your"
	cont "#mon."

	para "That's how you got"
	line "to be so strong."

	para "Mira is beginning"
	line "to understand!"
	done

.BeatenText:
	text "Mira wonders if"
	line "she can get very"

	para "far in the Battle"
	line "Tower."
	done

.RefuseText:
	text "Mira is a little"
	line "sad…"
	done

BattleTower2FAnabelScript:
	checkflag ENGINE_ANABEL_DONE_TODAY
	iftrue_jumptextfaceplayer .AfterText
	faceplayer
	opentext
	writethistext
		text "You really did"
		line "come to see me…"

		para "I won't have to"
		line "hold back against"
		cont "you…"

		para "Are you ready?"
		done
	yesorno
	iffalse_jumpopenedtext .RefuseText
	setflag ENGINE_ANABEL_DONE_TODAY
	writethistext
		text "Let's begin,"
		line "shall we?"
		done
	waitbutton
	closetext
	winlosstext .BeatenText, 0
	setlasttalked BATTLETOWER2F_ANABEL
	checkevent EVENT_BEAT_ELITE_FOUR_AGAIN
	iftrue .Team2
	loadtrainer ANABEL, 1
	sjump .StartBattle
.Team2
	loadtrainer ANABEL, 2
.StartBattle
	startbattle
	reloadmapafterbattle
	jumpthistext

.AfterText:
	text "That was fun…"

	para "I have never had"
	line "a #mon battle"

	para "so enjoyable"
	line "before…"
	done

.BeatenText:
	text "Thank you…"
	done

.RefuseText:
	text "It's very dis-"
	line "appointing…"
	done

BattleTower2FCooltrainermText:
	text "I need to go, but"
	line "I just can't stop"

	para "watching this"
	line "battle!"
	done

BattleTower2FLadyText:
	text "What makes me most"
	line "happy being a"
	cont "trainer?"

	para "The fact that"
	line "#mon will bring"

	para "me lots of"
	line "friends!"
	done

BattleTower2FTwinText:
	text "Some people are"
	line "surprised to see"

	para "a small girl like"
	line "me at the Battle"
	cont "Tower."

	para "It's not like I"
	line "have to battle"
	cont "myself, you know?"
	done

BattleTower2FSuperNerdText:
	text "Hehe! All the"
	line "trainers around us"
	cont "look so pathetic!"

	para "…Actually, that"
	line "mindset makes you"
	cont "lose with one hit!"

	para "Don't let your"
	line "guard down,"
	cont "Pikachu!"
	done

BattleTower2FPikachuText:
	text "Pikachu: Pichuu!"
	done

BattleTower2FYoungsterText:
	text "To be strong is to"
	line "be weak."

	para "To be weak is to"
	line "be strong."

	para "Somebody told me"
	line "that before."

	para "I don't understand"
	line "it, but it sounds"
	cont "deep."
	done

BattleTower2FBlackbeltText:
	text "The karate gi is"
	line "the uniform of"
	cont "fighters!"

	para "There is nothing"
	line "better suited for"

	para "the Battle Tower"
	line "than this!"
	done
