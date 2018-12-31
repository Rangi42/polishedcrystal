BattleTower2F_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

BattleTower2F_MapEventHeader:
.Warps: db 1
	warp_def 1, 0, 4, BATTLE_TOWER_1F

.XYTriggers: db 0

.Signposts: db 4
	signpost 3, 4, SIGNPOST_UP, BattleTower2FTVScript
	signpost 3, 5, SIGNPOST_UP, BattleTower2FTVScript
	signpost 3, 16, SIGNPOST_UP, BattleTower2FTVScript
	signpost 3, 17, SIGNPOST_UP, BattleTower2FTVScript

.PersonEvents: db 13
	person_event SPRITE_RILEY, 7, 7, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, -1, 0, PERSONTYPE_SCRIPT, 0, BattleTower2FRileyScript, EVENT_BATTLE_TOWER_RILEY
	person_event SPRITE_BUCK, 4, 9, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, 0, PERSONTYPE_SCRIPT, 0, BattleTower2FBuckScript, EVENT_BATTLE_TOWER_BUCK
	person_event SPRITE_MIRA, 7, 12, SPRITEMOVEDATA_WALK_UP_DOWN, 1, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, BattleTower2FMiraScript, EVENT_BATTLE_TOWER_MIRA
	person_event SPRITE_LADY, 7, 7, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_COMMAND, jumptextfaceplayer, BattleTower2FLadyText, EVENT_DIM_CAVE_RILEY
	person_event SPRITE_TWIN, 4, 9, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_COMMAND, jumptextfaceplayer, BattleTower2FTwinText, EVENT_CINNABAR_VOLCANO_BUCK
	person_event SPRITE_YOUNGSTER, 7, 12, SPRITEMOVEDATA_WALK_UP_DOWN, 1, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_COMMAND, jumptextfaceplayer, BattleTower2FYoungsterText, EVENT_SCARY_CAVE_MIRA
	person_event SPRITE_CHERYL, 6, 4, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, BattleTower2FCherylScript, EVENT_BATTLE_TOWER_CHERYL
	person_event SPRITE_MARLEY, 8, 17, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, BattleTower2FMarleyScript, EVENT_BATTLE_TOWER_MARLEY
	person_event SPRITE_ANABEL, 6, 15, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, BattleTower2FAnabelScript, EVENT_BATTLE_TOWER_ANABEL
	person_event SPRITE_COOLTRAINER_M, 6, 4, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_COMMAND, jumptextfaceplayer, BattleTower2FCooltrainermText, EVENT_MURKY_SWAMP_CHERYL
	person_event SPRITE_SUPER_NERD, 8, 17, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, (1 << 3) | PAL_OW_PURPLE, PERSONTYPE_COMMAND, jumptextfaceplayer, BattleTower2FSuperNerdText, EVENT_QUIET_CAVE_MARLEY
	person_event SPRITE_PIKACHU, 8, 18, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_POKEMON, PIKACHU, BattleTower2FPikachuText, EVENT_QUIET_CAVE_MARLEY
	person_event SPRITE_BLACK_BELT, 6, 15, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_COMMAND, jumptextfaceplayer, BattleTower2FBlackbeltText, EVENT_NOISY_FOREST_ANABEL

const_value set 1
	const BATTLETOWER2F_RILEY
	const BATTLETOWER2F_BUCK
	const BATTLETOWER2F_MIRA
	const BATTLETOWER2F_LADY
	const BATTLETOWER2F_TWIN
	const BATTLETOWER2F_YOUNGSTER
	const BATTLETOWER2F_CHERYL
	const BATTLETOWER2F_MARLEY
	const BATTLETOWER2F_ANABEL

BattleTower2FTVScript:
	thistext

	text "There's an intense"
	line "battle on the TV."
	done

BattleTower2FCherylScript:
	checkflag ENGINE_CHERYL_DONE_TODAY
	iftrue_jumptextfaceplayer .AfterText
	faceplayer
	opentext
	writetext .GreetingText
	yesorno
	iffalse_jumpopenedtext .RefuseText
	setflag ENGINE_CHERYL_DONE_TODAY
	writetext .SeenText
	waitbutton
	closetext
	winlosstext .BeatenText, 0
	setlasttalked BATTLETOWER2F_CHERYL
	checkevent EVENT_BEAT_ELITE_FOUR_AGAIN
	iftrue .Team3
	checkevent EVENT_BEAT_ELITE_FOUR
	iftrue .Team2
	loadtrainer CHERYL, 1
	jump .StartBattle
.Team2
	loadtrainer CHERYL, 2
	jump .StartBattle
.Team3
	loadtrainer CHERYL, 3
.StartBattle
	startbattle
	reloadmapafterbattle
	thistext

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

.GreetingText:
	text "Oh, hello,"
	line "<PLAYER>."

	para "It's been a long"
	line "time… Hasn't it?"

	para "Would you care"
	line "to have a battle"
	cont "with me?"
	done

.SeenText:
	text "I should warn you,"
	line "my #mon can be"
	cont "quite rambunc-"
	cont "tious."
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
	writetext .GreetingText
	yesorno
	iffalse_jumpopenedtext .RefuseText
	setflag ENGINE_RILEY_DONE_TODAY
	writetext .SeenText
	waitbutton
	closetext
	winlosstext .BeatenText, 0
	setlasttalked BATTLETOWER2F_RILEY
	checkevent EVENT_BEAT_ELITE_FOUR_AGAIN
	iftrue .Team2
	loadtrainer RILEY, 1
	jump .StartBattle
.Team2
	loadtrainer RILEY, 2
.StartBattle
	startbattle
	reloadmapafterbattle
	thistext

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

.GreetingText:
	text "Hi. Long time,"
	line "no see."

	para "That look you"
	line "have… I take it"

	para "you're ready for"
	line "battle?"
	done

.SeenText:
	text "Battling is our"
	line "way of greeting!"
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
	writetext .GreetingText
	yesorno
	iffalse_jumpopenedtext .RefuseText
	setflag ENGINE_BUCK_DONE_TODAY
	writetext .SeenText
	waitbutton
	closetext
	winlosstext .BeatenText, 0
	setlasttalked BATTLETOWER2F_BUCK
	checkevent EVENT_BEAT_ELITE_FOUR_AGAIN
	iftrue .Team2
	loadtrainer BUCK, 1
	jump .StartBattle
.Team2
	loadtrainer BUCK, 2
.StartBattle
	startbattle
	reloadmapafterbattle
	thistext

.AfterText:
	text "Fweh! Too much!"

	para "I guess I'll keep"
	line "improving my team."
	done

.GreetingText:
	text "Ehehehe! You're"
	line "here at last!"

	para "So we are going"
	line "to battle?"
	done

.SeenText:
	text "I can feel my"
	line "#mon shivering"

	para "inside their #"
	line "Balls with antici-"
	cont "pation!"
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
	writetext .GreetingText
	yesorno
	iffalse_jumpopenedtext .RefuseText
	setflag ENGINE_MARLEY_DONE_TODAY
	writetext .SeenText
	waitbutton
	closetext
	winlosstext .BeatenText, 0
	setlasttalked BATTLETOWER2F_MARLEY
	checkevent EVENT_BEAT_ELITE_FOUR_AGAIN
	iftrue .Team3
	checkevent EVENT_BEAT_ELITE_FOUR
	iftrue .Team2
	loadtrainer MARLEY, 1
	jump .StartBattle
.Team2
	loadtrainer MARLEY, 2
	jump .StartBattle
.Team3
	loadtrainer MARLEY, 3
.StartBattle
	startbattle
	reloadmapafterbattle
	thistext

.AfterText:
	text "…I might like"
	line "battling with you."

	para "…Just a little."
	line "Only a tiny bit."
	done

.GreetingText:
	text "…Oh? A battle?"
	line "With me?"
	done

.SeenText:
	text "…OK. I… won't"
	line "lose…!"
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
	writetext .GreetingText
	yesorno
	iffalse_jumpopenedtext .RefuseText
	setflag ENGINE_MIRA_DONE_TODAY
	writetext .SeenText
	waitbutton
	closetext
	winlosstext .BeatenText, 0
	setlasttalked BATTLETOWER2F_MIRA
	checkevent EVENT_BEAT_ELITE_FOUR_AGAIN
	iftrue .Team2
	loadtrainer MIRA, 1
	jump .StartBattle
.Team2
	loadtrainer MIRA, 2
.StartBattle
	startbattle
	reloadmapafterbattle
	thistext

.AfterText:
	text "<PLAYER>, you are"
	line "always with your"
	cont "#mon."

	para "That's how you got"
	line "to be so strong."

	para "Mira is beginning"
	line "to understand!"
	done

.GreetingText:
	text "<PLAYER>! Mira is"
	line "stronger now!"

	para "Please! Battle"
	line "with Mira!"
	done

.SeenText:
	text "Mira will show you"
	line "that Mira doesn't"

	para "get lost anymore,"
	line "<PLAYER>!"
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
	writetext .GreetingText
	yesorno
	iffalse_jumpopenedtext .RefuseText
	setflag ENGINE_ANABEL_DONE_TODAY
	writetext .SeenText
	waitbutton
	closetext
	winlosstext .BeatenText, 0
	setlasttalked BATTLETOWER2F_ANABEL
	checkevent EVENT_BEAT_ELITE_FOUR_AGAIN
	iftrue .Team2
	loadtrainer ANABEL, 1
	jump .StartBattle
.Team2
	loadtrainer ANABEL, 2
.StartBattle
	startbattle
	reloadmapafterbattle
	thistext

.AfterText:
	text "That was fun…"

	para "I have never had"
	line "a #mon battle"

	para "so enjoyable"
	line "before…"
	done

.GreetingText:
	text "You really did"
	line "come to see me…"

	para "I won't have to"
	line "hold back against"
	cont "you…"

	para "Are you ready?"
	done

.SeenText:
	text "Let's begin,"
	line "shall we?"
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
	line "Pokemon will bring"

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
