GoldenrodGym_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  2, 17, GOLDENROD_CITY, 1
	warp_event  3, 17, GOLDENROD_CITY, 1

	def_coord_events
	coord_event  8,  5, 1, WhitneyCriesScript

	def_bg_events
	bg_event  1, 15, BGEVENT_READ, GoldenrodGymStatue
	bg_event  4, 15, BGEVENT_READ, GoldenrodGymStatue

	def_object_events
	object_event  9,  6, SPRITE_CUTE_GIRL, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 1, GenericTrainerSrandjrJoandcath1, -1
	object_event  8,  3, SPRITE_WHITNEY, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, GoldenrodGymWhitneyScript, -1
	object_event  9, 13, SPRITE_LASS, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 4, GenericTrainerLassCathy, -1
	object_event  9,  7, SPRITE_CUTE_GIRL, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 1, GenericTrainerSrandjrJoandcath2, -1
	object_event  0,  2, SPRITE_BEAUTY, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerBeautyVictoria, -1
	object_event 19,  5, SPRITE_BEAUTY, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 2, GenericTrainerBeautySamantha, -1
	object_event  5, 15, SPRITE_GYM_GUY, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, GoldenrodGymGuyScript, -1

	object_const_def
	const GOLDENRODGYM_LASS2

GoldenrodGymWhitneyScript:
	faceplayer
	checkevent EVENT_BEAT_WHITNEY
	iftrue .FightDone
	showtext WhitneyBeforeText
	winlosstext WhitneyShouldntBeSoSeriousText, 0
	loadtrainer WHITNEY, 1
	startbattle
	reloadmapafterbattle
	setevent EVENT_BEAT_WHITNEY
	setevent EVENT_MADE_WHITNEY_CRY
	setscene $1
	setevent EVENT_BEAT_BEAUTY_VICTORIA
	setevent EVENT_BEAT_BEAUTY_SAMANTHA
	setevent EVENT_BEAT_LASS_CATHY
	setevent EVENT_BEAT_SR_AND_JR_JO_AND_CATH
.FightDone:
	opentext
	checkevent EVENT_MADE_WHITNEY_CRY
	iffalse .StoppedCrying
	jumpopenedtext WhitneyYouMeanieText

.StoppedCrying:
	checkevent EVENT_GOT_TM45_ATTRACT
	iftrue_jumpopenedtext WhitneyGoodCryText
	checkflag ENGINE_PLAINBADGE
	iftrue .GotPlainBadge
	writetext WhitneyWhatDoYouWantText
	promptbutton
	waitsfx
	writetext PlayerReceivedPlainBadgeText
	playsound SFX_GET_BADGE
	waitsfx
	setflag ENGINE_PLAINBADGE
.GotPlainBadge:
	writetext WhitneyPlainBadgeText
	promptbutton
	verbosegivetmhm TM_ATTRACT
	setevent EVENT_GOT_TM45_ATTRACT
	jumpthisopenedtext

	ctxt "It's Attract!"
	line "It makes full use"

	para "of a #mon's"
	line "charm."

	para "Isn't it just per-"
	line "fect for a cutie"
	cont "like me?"
	done

GenericTrainerLassCathy:
	generictrainer LASS, CATHY, EVENT_BEAT_LASS_CATHY, LassCathySeenText, LassCathyBeatenText

	ctxt "Do my #mon"
	line "think I'm cute?"
	done

WhitneyCriesScript:
	showemote EMOTE_SHOCK, GOLDENRODGYM_LASS2, 15
	applymovement GOLDENRODGYM_LASS2, JoWalksUpMovement
	turnobject PLAYER, DOWN
	showtext JoWhitneyCriesText
	applymovement GOLDENRODGYM_LASS2, JoWalksAwayMovement
	setscene $0
	clearevent EVENT_MADE_WHITNEY_CRY
	end

GenericTrainerSrandjrJoandcath1:
	generictrainer SR_AND_JR, JOANDCATH1, EVENT_BEAT_SR_AND_JR_JO_AND_CATH, SrandjrJoandcath1SeenText, SrandjrJoandcath1BeatenText

	ctxt "Jo: I'm helping my"
	line "junior Cath to"

	para "earn a badge"
	line "from Whitney."

	para "She's improving"
	line "gradually."
	done

GenericTrainerSrandjrJoandcath2:
	generictrainer SR_AND_JR, JOANDCATH2, EVENT_BEAT_SR_AND_JR_JO_AND_CATH, SrandjrJoandcath2SeenText, SrandjrJoandcath2BeatenText

	ctxt "Cath: I keep on"
	line "losing to Whitney."
	cont "It's depressing."

	para "I'm OK! If I lose,"
	line "I'll just try"
	cont "harder next time!"
	done

GenericTrainerBeautyVictoria:
	generictrainer BEAUTY, VICTORIA, EVENT_BEAT_BEAUTY_VICTORIA, BeautyVictoriaSeenText, BeautyVictoriaBeatenText

	ctxt "Wow, you must be"
	line "good to beat me!"
	cont "Keep it up!"
	done

GenericTrainerBeautySamantha:
	generictrainer BEAUTY, SAMANTHA, EVENT_BEAT_BEAUTY_SAMANTHA, BeautySamanthaSeenText, BeautySamanthaBeatenText

	ctxt "I taught Meowth"
	line "moves for taking"
	cont "on any type…"
	done

GoldenrodGymGuyScript:
	checkevent EVENT_BEAT_WHITNEY
	iftrue_jumptextfaceplayer GoldenrodGymGuyWinText
	jumpthistextfaceplayer

	ctxt "Yo! Champ in"
	line "making!"

	para "This Gym is home"
	line "to Normal-type"
	cont "#mon trainers."

	para "I recommend you"
	line "use Fighting-type"
	cont "#mon."

	para "But be careful--"
	line "Fairy #mon"

	para "resist Fighting-"
	line "type moves,"

	para "and they're used"
	line "here too!"
	done

GoldenrodGymStatue:
	gettrainername WHITNEY, 1, $1
	checkflag ENGINE_PLAINBADGE
	iftrue .Beaten
	jumpstd gymstatue1
.Beaten:
	readvar VAR_BADGES
	ifgreater 10, .LyraToo
	jumpstd gymstatue2
.LyraToo
	jumpstd gymstatue3

JoWalksUpMovement:
	step_left
	turn_head_up
	step_end

JoWalksAwayMovement:
	step_right
	turn_head_left
	step_end

WhitneyBeforeText:
	ctxt "Hi! I'm Whitney!"

	para "Everyone was into"
	line "#mon, so I got"
	cont "into it too!"

	para "#mon are"
	line "super cute!"

	para "You want to bat-"
	line "tle? I'm warning"
	cont "you--I'm good!"
	done

WhitneyShouldntBeSoSeriousText:
	ctxt "Sob…"

	para "…Waaaaaaah!"
	line "You're mean!"

	para "You shouldn't be"
	line "so serious! You…"
	cont "you child, you!"
	done

WhitneyYouMeanieText:
	ctxt "Waaaaah!"

	para "Waaaaah!"

	para "…Snivel, hic…"
	line "…You meanie!"
	done

WhitneyWhatDoYouWantText:
	ctxt "…Sniff…"

	para "What? What do you"
	line "want? A Badge?"

	para "Oh, right."
	line "I forgot. Here's"
	cont "the Plain Badge."
	done

PlayerReceivedPlainBadgeText:
	ctxt "<PLAYER> received"
	line "the Plain Badge."
	done

WhitneyPlainBadgeText:
	ctxt "The Plain Badge"
	line "lets your #mon"

	para "use Strength out-"
	line "side of battle."

	para "Oh, you can have"
	line "this too!"
	done

WhitneyGoodCryText:
	ctxt "Ah, that was a"
	line "good cry!"

	para "Come for a visit"
	line "again! Bye-bye!"
	done

LassCathySeenText:
	ctxt "Don't let my"
	line "#mon's cute"

	para "looks fool you."
	line "They can whip you!"
	done

LassCathyBeatenText:
	ctxt "Darn… I thought"
	line "you were weak…"
	done

SrandjrJoandcath1SeenText:
	ctxt "Jo: If you want to"
	line "face Whitney,"

	para "you'll have to go"
	line "through me!"

	para "Cath, did that"
	line "sound cool?"
	done

SrandjrJoandcath1BeatenText:
	ctxt "Jo: Losing isn't"
	line "cool at all!"
	done

SrandjrJoandcath2SeenText:
	ctxt "Cath: I'm trying"
	line "to beat Whitney,"
	cont "but my senior and"

	para "I can beat you"
	line "first!"
	done

SrandjrJoandcath2BeatenText:
	ctxt "Cath: Oh, no,"
	line "no, no!"
	done

JoWhitneyCriesText:
	ctxt "Oh, no. You made"
	line "Whitney cry."

	para "It's OK. She'll"
	line "stop soon. She"

	para "always cries when"
	line "she loses."
	done

BeautyVictoriaSeenText:
	ctxt "Oh, you are a cute"
	line "little trainer!"

	para "I like you, but I"
	line "won't hold back!"
	done

BeautyVictoriaBeatenText:
	ctxt "Let's see… Oops,"
	line "it's over?"
	done

BeautySamanthaSeenText:
	ctxt "Give it your best"
	line "shot, or I'll take"
	cont "you down!"
	done

BeautySamanthaBeatenText:
	ctxt "No! Oh, Meowth,"
	line "I'm so sorry!"
	done

GoldenrodGymGuyWinText:
	ctxt "You won? Great! I"
	line "was busy admiring"
	cont "the ladies here."
	done
