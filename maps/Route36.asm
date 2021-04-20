Route36_MapScriptHeader:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_OBJECTS, Route36ArthurCallback

	def_warp_events
	warp_event 22,  8, ROUTE_36_NATIONAL_PARK_GATE, 3
	warp_event 22,  9, ROUTE_36_NATIONAL_PARK_GATE, 4
	warp_event 51, 13, ROUTE_36_RUINS_OF_ALPH_GATE, 1
	warp_event 52, 13, ROUTE_36_RUINS_OF_ALPH_GATE, 2
	warp_event 61,  8, ROUTE_36_VIOLET_GATE, 1
	warp_event 61,  9, ROUTE_36_VIOLET_GATE, 2

	def_coord_events
	coord_event 24,  7, 1, Route36SuicuneScript
	coord_event 26,  7, 1, Route36SuicuneScript

	def_bg_events
	bg_event 33,  1, BGEVENT_JUMPTEXT, Route36TrainerTips2Text
	bg_event 49, 11, BGEVENT_JUMPTEXT, RuinsOfAlphNorthSignText
	bg_event 59,  7, BGEVENT_JUMPTEXT, Route36SignText
	bg_event 25,  7, BGEVENT_JUMPTEXT, Route36TrainerTips1Text

	def_object_events
	object_event 39,  9, SPRITE_WEIRD_TREE, SPRITEMOVEDATA_SUDOWOODO, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, SudowoodoScript, EVENT_ROUTE_36_SUDOWOODO
	object_event 53,  6, SPRITE_SCHOOLBOY, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, ArthurScript, EVENT_ROUTE_36_ARTHUR_OF_THURSDAY
	object_event 37, 12, SPRITE_CUTE_GIRL, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, Route36FloriaScript, EVENT_FLORIA_AT_SUDOWOODO
	object_event 25,  6, SPRITE_MON_ICON, SPRITEMOVEDATA_POKEMON, 0, SUICUNE, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, ObjectEvent, EVENT_SAW_SUICUNE_ON_ROUTE_36
	object_event 30,  6, SPRITE_ACE_TRAINER_F, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, Route36CooltrainerfChiaraScript, -1
	object_event 24, 13, SPRITE_PSYCHIC, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerPsychicMark, -1
	object_event 35, 14, SPRITE_SCHOOLBOY, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, OBJECTTYPE_TRAINER, 5, TrainerSchoolboyAlan1, -1
	object_event 57,  9, SPRITE_CUTE_GIRL, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 2, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, Route36LassScript, -1
	object_event 48,  9, SPRITE_FAT_GUY, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_PURPLE, OBJECTTYPE_SCRIPT, 0, Route36RockSmashGuyScript, -1
	fruittree_event 25,  4, FRUITTREE_ROUTE_36, RAWST_BERRY, PAL_NPC_BLUE
	object_event 50,  5, SPRITE_SCHOOLGIRL, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 2, GenericTrainerSchoolgirlMolly, -1

	object_const_def
	const ROUTE36_WEIRD_TREE
	const ROUTE36_ARTHUR
	const ROUTE36_FLORIA
	const ROUTE36_SUICUNE
	const ROUTE36_COOLTRAINERF

Route36ArthurCallback:
	readvar VAR_WEEKDAY
	ifequal THURSDAY, .ArthurAppears
	disappear ROUTE36_ARTHUR
	endcallback

.ArthurAppears:
	appear ROUTE36_ARTHUR
	endcallback

Route36SuicuneScript:
	showemote EMOTE_SHOCK, PLAYER, 15
	pause 15
	playsound SFX_WARP_FROM
	turnobject PLAYER, UP
	applymovement ROUTE36_SUICUNE, Route36SuicuneMovement
	disappear ROUTE36_SUICUNE
	turnobject PLAYER, DOWN
	pause 10
	setscene $0
	clearevent EVENT_SAW_SUICUNE_AT_CIANWOOD_CITY
	setmapscene CIANWOOD_CITY, $1
	end

SudowoodoScript:
	checkkeyitem SQUIRTBOTTLE
	iftrue .Fight
	waitsfx
	playsound SFX_SANDSTORM
	applyonemovement ROUTE36_WEIRD_TREE, tree_shake
	end

.Fight:
	opentext
	writetext UseSquirtbottleText
	yesorno
	iffalse_endtext
	closetext
WateredWeirdTreeScript:: ; export (for when you use Squirtbottle from pack)
	showtext UsedSquirtbottleText
	waitsfx
	playsound SFX_SANDSTORM
	applyonemovement ROUTE36_WEIRD_TREE, tree_shake
	showtext SudowoodoAttackedText
	loadvar VAR_BATTLETYPE, BATTLETYPE_TRAP
	loadwildmon SUDOWOODO, 20
	startbattle
	setevent EVENT_FOUGHT_SUDOWOODO
	ifequal $2, DidntCatchSudowoodo
	disappear ROUTE36_WEIRD_TREE
	reloadmapafterbattle
	end

DidntCatchSudowoodo:
	reloadmapafterbattle
	applymovement ROUTE36_WEIRD_TREE, WeirdTreeMovement_Flee
	disappear ROUTE36_WEIRD_TREE
	special MapCallbackSprites_LoadUsedSpritesGFX
	end

Route36FloriaScript:
	faceplayer
	opentext
	checkevent EVENT_TALKED_TO_FLORIA_AT_FLOWER_SHOP
	iftrue .SecondTimeTalking
	setevent EVENT_MET_FLORIA
	writetext FloriaText1
	waitbutton
	closetext
	clearevent EVENT_FLORIA_AT_FLOWER_SHOP
	readvar VAR_FACING
	ifequal UP, .Up
	applymovement ROUTE36_FLORIA, FloriaMovement1
	disappear ROUTE36_FLORIA
	end

.Up:
	applymovement ROUTE36_FLORIA, FloriaMovement2
	disappear ROUTE36_FLORIA
	end

.SecondTimeTalking:
	jumpopenedtext FloriaText2

Route36RockSmashGuyScript:
	faceplayer
	opentext
	checkevent EVENT_GOT_TM50_ROCK_SMASH
	iftrue .AlreadyGotRockSmash
	checkevent EVENT_FOUGHT_SUDOWOODO
	iftrue .ClearedSudowoodo
	jumpopenedtext RockSmashGuyText1

.ClearedSudowoodo:
	writetext RockSmashGuyText2
	promptbutton
	verbosegivetmhm TM_ROCK_SMASH
	setevent EVENT_GOT_TM50_ROCK_SMASH
.AlreadyGotRockSmash:
	jumpopenedtext RockSmashGuyText3

Route36LassScript:
	checkevent EVENT_FOUGHT_SUDOWOODO
	iftrue_jumptextfaceplayer Route36LassText_ClearedSudowoodo
	jumptextfaceplayer Route36LassText_OddTree

TrainerSchoolboyAlan1:
	trainer SCHOOLBOY, ALAN1, EVENT_BEAT_SCHOOLBOY_ALAN, SchoolboyAlan1SeenText, SchoolboyAlan1BeatenText, 0, .Script

.Script:
	loadvar VAR_CALLERID, PHONE_SCHOOLBOY_ALAN
	opentext
	checkflag ENGINE_ALAN_READY_FOR_REMATCH
	iftrue .ChooseRematch
	checkflag ENGINE_ALAN_HAS_FIRE_STONE
	iftrue .GiveFireStone
	checkcellnum PHONE_SCHOOLBOY_ALAN
	iftrue .NumberAccepted
	checkevent EVENT_ALAN_ASKED_FOR_PHONE_NUMBER
	iftrue .AskAgainForPhoneNumber
	writetext SchoolboyAlanBooksText
	promptbutton
	setevent EVENT_ALAN_ASKED_FOR_PHONE_NUMBER
	callstd asknumber1m
	sjump .ContinueAskForPhoneNumber

.AskAgainForPhoneNumber:
	callstd asknumber2m
.ContinueAskForPhoneNumber:
	askforphonenumber PHONE_SCHOOLBOY_ALAN
	ifequal $1, .PhoneFull
	ifequal $2, .NumberDeclined
	gettrainername SCHOOLBOY, ALAN1, $0
	callstd registerednumberm
	jumpstd numberacceptedm

.ChooseRematch:
	callstd rematchm
	winlosstext SchoolboyAlan1BeatenText, 0
	readmem wAlanFightCount
	ifequal 4, .Fight4
	ifequal 3, .Fight3
	ifequal 2, .Fight2
	ifequal 1, .Fight1
	ifequal 0, .LoadFight0
.Fight4:
	checkevent EVENT_RESTORED_POWER_TO_KANTO
	iftrue .LoadFight4
.Fight3:
	checkevent EVENT_BEAT_ELITE_FOUR
	iftrue .LoadFight3
.Fight2:
	checkflag ENGINE_FLYPOINT_BLACKTHORN
	iftrue .LoadFight2
.Fight1:
	checkflag ENGINE_FLYPOINT_OLIVINE
	iftrue .LoadFight1
.LoadFight0:
	loadtrainer SCHOOLBOY, ALAN1
	startbattle
	reloadmapafterbattle
	loadmem wAlanFightCount, 1
	clearflag ENGINE_ALAN_READY_FOR_REMATCH
	end

.LoadFight1:
	loadtrainer SCHOOLBOY, ALAN2
	startbattle
	reloadmapafterbattle
	loadmem wAlanFightCount, 2
	clearflag ENGINE_ALAN_READY_FOR_REMATCH
	end

.LoadFight2:
	loadtrainer SCHOOLBOY, ALAN3
	startbattle
	reloadmapafterbattle
	loadmem wAlanFightCount, 3
	clearflag ENGINE_ALAN_READY_FOR_REMATCH
	end

.LoadFight3:
	loadtrainer SCHOOLBOY, ALAN4
	startbattle
	reloadmapafterbattle
	loadmem wAlanFightCount, 4
	clearflag ENGINE_ALAN_READY_FOR_REMATCH
	end

.LoadFight4:
	loadtrainer SCHOOLBOY, ALAN5
	startbattle
	reloadmapafterbattle
	clearflag ENGINE_ALAN_READY_FOR_REMATCH
	end

.GiveFireStone:
	callstd giftm
	verbosegiveitem FIRE_STONE
	iffalse .BagFull
	clearflag ENGINE_ALAN_HAS_FIRE_STONE
	setevent EVENT_ALAN_GAVE_FIRE_STONE
	jumpstd numberacceptedm

.BagFull:
	jumpstd packfullm

.NumberAccepted:
	jumpstd numberacceptedm

.NumberDeclined:
	jumpstd numberdeclinedm

.PhoneFull:
	jumpstd phonefullm

Route36CooltrainerfChiaraScript:
	checkevent EVENT_GOT_BINDING_BAND_FROM_ROUTE_36_LEADER
	iftrue_jumptextfaceplayer .AfterText2
	faceplayer
	checkevent EVENT_BEAT_COOLTRAINERF_CHIARA
	iftrue .Beaten
	checkevent EVENT_BEAT_SCHOOLBOY_ALAN
	iffalse_jumptext .IntroText
	checkevent EVENT_BEAT_PSYCHIC_MARK
	iffalse_jumptext .IntroText
	checkevent EVENT_BEAT_SCHOOLGIRL_MOLLY
	iffalse_jumptext .IntroText
	checkevent EVENT_BEAT_TWINS_ANN_AND_ANNE
	iffalse_jumptext .IntroText
	checkevent EVENT_BEAT_PSYCHIC_GREG
	iffalse_jumptext .IntroText
	checkevent EVENT_BEAT_BEAUTY_CALLIE
	iffalse_jumptext .IntroText
	checkevent EVENT_BEAT_BEAUTY_CASSANDRA
	iffalse_jumptext .IntroText
	opentext
	writetext .QuestionText
	yesorno
	iffalse_jumpopenedtext .RefusedText
	writetext .SeenText
	waitbutton
	closetext
	winlosstext .BeatenText, 0
	setlasttalked ROUTE36_COOLTRAINERF
	loadtrainer COOLTRAINERF, CHIARA
	startbattle
	reloadmapafterbattle
	setevent EVENT_BEAT_COOLTRAINERF_CHIARA
.Beaten:
	opentext
	writetext .AfterText1
	promptbutton
	verbosegiveitem BINDING_BAND
	iffalse_endtext
	setevent EVENT_GOT_BINDING_BAND_FROM_ROUTE_36_LEADER
	jumpthisopenedtext

.AfterText2:
	text "With skill like"
	line "yours, I'm not the"

	para "only elite trainer"
	line "who'll want to test"
	cont "you."
	done

.IntroText:
	text "I saw how you woke"
	line "up that Sudowoodo."

	para "You did great!"

	para "And you have a"
	line "Plain Badge."
	cont "So do I!"

	para "How about this?"
	line "Take out all the"

	para "trainers on Routes"
	line "36 and 37."

	para "Then I'll fight"
	line "you myself!"
	done

.QuestionText:
	text "So you beat every-"
	line "one else in the"
	cont "area."

	para "Then it's time for"
	line "our showdown!"

	para "I use a Binding"
	line "Band to press my"
	cont "advantage."

	para "Think you're ready"
	line "for me?"
	done

.RefusedText:
	text "Well, I'm ready"
	line "when you are!"
	done

.SeenText:
	text "You won't last"
	line "long against my"
	cont "technique!"
	done

.BeatenText:
	text "I'm the one who"
	line "didn't last?!"
	done

.AfterText1:
	text "You observed my"
	line "technique and"
	cont "countered it."

	para "Why not try it"
	line "yourself?"

	para "Here, it's for"
	line "you!"
	done

GenericTrainerPsychicMark:
	generictrainer PSYCHIC_T, MARK, EVENT_BEAT_PSYCHIC_MARK, PsychicMarkSeenText, PsychicMarkBeatenText

	text "I'd be strong if"
	line "only I could tell"

	para "what my opponent"
	line "was thinking."
	done

GenericTrainerSchoolgirlMolly:
	generictrainer SCHOOLGIRL, MOLLY, EVENT_BEAT_SCHOOLGIRL_MOLLY, SchoolgirlMollySeenText, SchoolgirlMollyBeatenText

	text "I still have a"
	line "lot to learn."
	done

ArthurScript:
	faceplayer
	opentext
	checkevent EVENT_GOT_HARD_STONE_FROM_ARTHUR
	iftrue .AlreadyGotStone
	readvar VAR_WEEKDAY
	ifnotequal THURSDAY, ArthurNotThursdayScript
	checkevent EVENT_MET_ARTHUR_OF_THURSDAY
	iftrue .MetArthur
	writetext MeetArthurText
	promptbutton
	setevent EVENT_MET_ARTHUR_OF_THURSDAY
.MetArthur:
	writetext ArthurGivesGiftText
	promptbutton
	verbosegiveitem HARD_STONE
	iffalse .BagFull
	setevent EVENT_GOT_HARD_STONE_FROM_ARTHUR
	jumpopenedtext ArthurGaveGiftText

.AlreadyGotStone:
	writetext ArthurThursdayText
	waitbutton
.BagFull:
	endtext

ArthurNotThursdayScript:
	jumpopenedtext ArthurNotThursdayText

WeirdTreeMovement_Flee:
	fast_jump_step_up
	fast_jump_step_up
	step_end

FloriaMovement1:
	step_down
	step_down
	step_down
	step_left
	step_left
	step_left
	step_left
	step_left
	step_left
	step_end

FloriaMovement2:
	step_left
	step_down
	step_down
	step_down
	step_left
	step_left
	step_left
	step_left
	step_left
	step_end

Route36SuicuneMovement:
	fix_facing
	fast_jump_step_down
	fast_jump_step_down
	fast_jump_step_down
	fast_jump_step_right
	fast_jump_step_right
	fast_jump_step_right
	step_end

UseSquirtbottleText:
	text "It's a weird tree."
	line "Use SquirtBottle?"
	done

UsedSquirtbottleText:
	text "<PLAYER> used the"
	line "SquirtBottle."
	done

SudowoodoAttackedText:
	text "The weird tree"
	line "doesn't like the"
	cont "SquirtBottle!"

	para "The weird tree"
	line "attacked!"
	done

FloriaText1:
	text "I'm the Flower"
	line "Shop's Floria!"

	para "Listen, listen!"

	para "When I sprinkled"
	line "water on that"

	para "wiggly tree, it"
	line "jumped right up!"

	para "It just has to be"
	line "a #mon."

	para "I bet it would be"
	line "shocked out of its"

	para "disguise if you"
	line "soaked it!"

	para "I know! I'll tell"
	line "my sis and borrow"
	cont "her water bottle!"
	done

FloriaText2:
	text "When I told my sis"
	line "about the jiggly"

	para "tree, she said"
	line "it's dangerous."

	para "If I beat Whitney,"
	line "I wonder if she'll"

	para "lend me her water"
	line "bottle…"
	done

RockSmashGuyText1:
	text "Wa-hey!"

	para "I was going to"
	line "snap that tree"

	para "with my straight-"
	line "arm punch."

	para "But I couldn't!"
	line "I'm a failure!"
	done

RockSmashGuyText2:
	text "Did you clear that"
	line "wretched tree?"

	para "I'm impressed!"
	line "I want you to"
	cont "have this."
	done

RockSmashGuyText3:
	text "That happens to be"
if DEF(FAITHFUL)
	line "Rock Smash."
else
	line "Brick Break."
endc

	para "You can shatter"
	line "rocks with just a"

	para "single well-aimed"
	line "smack."

	para "If any rocks are"
	line "in your way, just"
if DEF(FAITHFUL)
	cont "smash 'em up!"
else
	cont "break 'em up!"
endc
	done

Route36LassText_OddTree:
	text "An odd tree is"
	line "blocking the way"
	cont "to Goldenrod City."

	para "I wanted to go see"
	line "the huge #mon"

	para "Center they just"
	line "opened…"
	done

Route36LassText_ClearedSudowoodo:
	text "That odd tree dis-"
	line "appeared without a"
	cont "trace."

	para "Oh! That tree was"
	line "really a #mon?"
	done

PsychicMarkSeenText:
	text "I'm going to read"
	line "your thoughts!"
	done

PsychicMarkBeatenText:
	text "I misread you!"
	done

SchoolgirlMollySeenText:
	text "Mr.Earl taught me"
	line "how to battle with"
	cont "#mon!"
	done

SchoolgirlMollyBeatenText:
	text "My studying…"
	done

SchoolboyAlan1SeenText:
	text "Thanks to my stud-"
	line "ies, I'm ready for"
	cont "any #mon!"
	done

SchoolboyAlan1BeatenText:
	text "Oops! Computation"
	line "error?"
	done

SchoolboyAlanBooksText:
	text "Darn. I study five"
	line "hours a day too."

	para "There's more to"
	line "learning than just"
	cont "reading books."
	done

MeetArthurText:
	text "Arthur: Who are"
	line "you?"

	para "I'm Arthur of"
	line "Thursday."
	done

ArthurGivesGiftText:
	text "Here. You can have"
	line "this."
	done

ArthurGaveGiftText:
	text "Arthur: A #mon"
	line "that uses Rock-"

	para "type moves should"
	line "hold on to that."

	para "It pumps up Rock-"
	line "type attacks."
	done

ArthurThursdayText:
	text "Arthur: I'm Arthur"
	line "of Thursday. I'm"

	para "the second son out"
	line "of seven children."
	done

ArthurNotThursdayText:
	text "Arthur: Today's"
	line "not Thursday. How"
	cont "disappointing."
	done

Route36SignText:
	text "Route 36"
	done

RuinsOfAlphNorthSignText:
	text "Ruins of Alph"
	line "North Entrance"
	done

Route36TrainerTips1Text:
	text "Trainer Tips"

	para "#mon stats"
	line "vary--even within"
	cont "the same species."

	para "Their stats may be"
	line "similar at first."

	para "However, differ-"
	line "ences will become"

	para "pronounced as the"
	line "#mon grow."
	done

Route36TrainerTips2Text:
	text "Trainer Tips"

	para "Use Dig to return"
	line "to the entrance of"
	cont "any place."

	para "It is convenient"
	line "for exploring"

	para "caves and other"
	line "landmarks."
	done
