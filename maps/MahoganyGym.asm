MahoganyGym_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

MahoganyGym_MapEventHeader:

.Warps: db 2
	warp_def 17, 4, 3, MAHOGANY_TOWN
	warp_def 17, 5, 3, MAHOGANY_TOWN

.XYTriggers: db 0

.Signposts: db 2
	signpost 15, 3, SIGNPOST_READ, MahoganyGymStatue
	signpost 15, 6, SIGNPOST_READ, MahoganyGymStatue

.PersonEvents: db 7
	person_event SPRITE_PRYCE, 3, 5, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_SCRIPT, 0, PryceScript_0x199a9e, -1
	person_event SPRITE_SKIER, 6, 4, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_TRAINER, 1, TrainerSkierRoxanne, -1
	person_event SPRITE_BOARDER, 17, 0, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_TRAINER, 1, TrainerBoarderRonald, -1
	person_event SPRITE_SKIER, 17, 9, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_TRAINER, 1, TrainerSkierClarissa, -1
	person_event SPRITE_BOARDER, 9, 5, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_TRAINER, 1, TrainerBoarderBrad, -1
	person_event SPRITE_BOARDER, 4, 2, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_TRAINER, 1, TrainerBoarderDouglas, -1
	person_event SPRITE_GYM_GUY, 15, 7, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, MahoganyGymGuyScript, -1

PryceScript_0x199a9e:
	faceplayer
	opentext
	checkevent EVENT_BEAT_PRYCE
	iftrue .FightDone
	writetext UnknownText_0x199b8d
	waitbutton
	closetext
	winlosstext UnknownText_0x199cb3, 0
	loadtrainer PRYCE, 1
	startbattle
	reloadmapafterbattle
	setevent EVENT_BEAT_PRYCE
	opentext
	writetext UnknownText_0x199d3b
	playsound SFX_GET_BADGE
	waitsfx
	setflag ENGINE_GLACIERBADGE
	callstd radiotowerrockets
.FightDone:
	checkevent EVENT_GOT_TM67_AVALANCHE
	iftrue UnknownScript_0x199af0
	setevent EVENT_BEAT_SKIER_ROXANNE
	setevent EVENT_BEAT_SKIER_CLARISSA
	setevent EVENT_BEAT_BOARDER_RONALD
	setevent EVENT_BEAT_BOARDER_BRAD
	setevent EVENT_BEAT_BOARDER_DOUGLAS
	writetext UnknownText_0x199d55
	buttonsound
	verbosegivetmhm TM_AVALANCHE
	setevent EVENT_GOT_TM67_AVALANCHE
	jumpopenedtext UnknownText_0x199def

UnknownScript_0x199af0:
	jumpopenedtext UnknownText_0x199e59

TrainerSkierRoxanne:
	trainer EVENT_BEAT_SKIER_ROXANNE, SKIER, ROXANNE, SkierRoxanneSeenText, SkierRoxanneBeatenText, 0, SkierRoxanneScript

SkierRoxanneScript:
	end_if_just_battled
	jumptextfaceplayer UnknownText_0x19a116

TrainerSkierClarissa:
	trainer EVENT_BEAT_SKIER_CLARISSA, SKIER, CLARISSA, SkierClarissaSeenText, SkierClarissaBeatenText, 0, SkierClarissaScript

SkierClarissaScript:
	end_if_just_battled
	jumptextfaceplayer UnknownText_0x19a18f

TrainerBoarderRonald:
	trainer EVENT_BEAT_BOARDER_RONALD, BOARDER, RONALD, BoarderRonaldSeenText, BoarderRonaldBeatenText, 0, BoarderRonaldScript

BoarderRonaldScript:
	end_if_just_battled
	jumptextfaceplayer UnknownText_0x199f2d

TrainerBoarderBrad:
	trainer EVENT_BEAT_BOARDER_BRAD, BOARDER, BRAD, BoarderBradSeenText, BoarderBradBeatenText, 0, BoarderBradScript

BoarderBradScript:
	end_if_just_battled
	jumptextfaceplayer UnknownText_0x199fdd

TrainerBoarderDouglas:
	trainer EVENT_BEAT_BOARDER_DOUGLAS, BOARDER, DOUGLAS, BoarderDouglasSeenText, BoarderDouglasBeatenText, 0, BoarderDouglasScript

BoarderDouglasScript:
	end_if_just_battled
	jumptextfaceplayer UnknownText_0x19a047

MahoganyGymGuyScript:
	checkevent EVENT_BEAT_PRYCE
	iftrue_jumptextfaceplayer MahoganyGymGuyWinText
	jumptextfaceplayer MahoganyGymGuyText

MahoganyGymStatue:
	trainertotext PRYCE, 1, $1
	checkflag ENGINE_GLACIERBADGE
	iftrue .Beaten
	jumpstd gymstatue1
.Beaten:
	checkcode VAR_BADGES
	if_greater_than 14, .LyraToo
	jumpstd gymstatue2
.LyraToo
	jumpstd gymstatue3

UnknownText_0x199b8d:
	text "#mon have many"
	line "experiences in"

	para "their lives, just"
	line "like we do."

	para "I, too, have seen"
	line "and suffered much"
	cont "in my life."

	para "Since I am your"
	line "elder, let me show"
	cont "you what I mean."

	para "I have been with"
	line "#mon since"

	para "before you were"
	line "born."

	para "I do not lose"
	line "easily."

	para "I, Pryce--the"
	line "winter trainer--"

	para "shall demonstrate"
	line "my power!"
	done

UnknownText_0x199cb3:
	text "Ah, I am impressed"
	line "by your prowess."

	para "With your strong"
	line "will, I know you"

	para "will overcome all"
	line "life's obstacles."

	para "You are worthy of"
	line "this Badge!"
	done

UnknownText_0x199d3b:
	text "<PLAYER> received"
	line "the Glacier Badge."
	done

UnknownText_0x199d55:
	text "That Badge will"
	line "let your #mon"

	para "use Whirlpool to"
	line "cross whirlpools."

	para "And this… This is"
	line "a gift from me!"
	done

UnknownText_0x199def:
	text "That TM contains"
	line "Avalanche."

	para "It deals more"
	line "damage if the user"
	cont "was hurt first."

	para "It demonstrates"
	line "the harshness of"
	cont "winter."
	done

UnknownText_0x199e59:
	text "When the ice and"
	line "snow melt, spring"
	cont "arrives."

	para "You and your #-"
	line "mon will be to-"

	para "gether for many"
	line "years to come."

	para "Cherish your time"
	line "together!"
	done

BoarderRonaldSeenText:
	text "I'll freeze your"
	line "#mon, so you"
	cont "can't do a thing!"
	done

BoarderRonaldBeatenText:
	text "Darn. I couldn't"
	line "do a thing."
	done

UnknownText_0x199f2d:
	text "I think there's a"
	line "move a #mon"

	para "can use while it's"
	line "frozen."
	done

BoarderBradSeenText:
	text "This Gym has a"
	line "slippery floor."

	para "It's fun, isn't"
	line "it?"

	para "But hey--we're"
	line "not playing games"
	cont "here!"
	done

BoarderBradBeatenText:
	text "Do you see how"
	line "serious we are?"
	done

UnknownText_0x199fdd:
	text "This Gym is great."
	line "I love boarding"
	cont "with my #mon!"
	done

BoarderDouglasSeenText:
	text "I know Pryce's"
	line "secret."
	done

BoarderDouglasBeatenText:
	text "OK. I'll tell you"
	line "Pryce's secret."
	done

UnknownText_0x19a047:
	text "The secret behind"
	line "Pryce's power…"

	para "He meditates under"
	line "a waterfall daily"

	para "to strengthen his"
	line "mind and body."
	done

SkierRoxanneSeenText:
	text "To get to Pryce,"
	line "our Gym Leader,"

	para "you need to think"
	line "before you skate."
	done

SkierRoxanneBeatenText:
	text "I wouldn't lose to"
	line "you in skiing!"
	done

UnknownText_0x19a116:
	text "If you don't skate"
	line "with precision,"

	para "you won't get far"
	line "in this Gym."
	done

SkierClarissaSeenText:
	text "Check out my"
	line "parallel turn!"
	done

SkierClarissaBeatenText:
	text "No! You made me"
	line "wipe out!"
	done

UnknownText_0x19a18f:
	text "I shouldn't have"
	line "been bragging"
	cont "about my skiing…"
	done

MahoganyGymGuyText:
	text "Pryce is a veteran"
	line "who has trained"

	para "#mon for some"
	line "50 years."

	para "He's said to be"
	line "good at freezing"

	para "opponents with"
	line "ice-type moves."

	para "That means you"
	line "should melt him"

	para "with your burning"
	line "ambition!"
	done

MahoganyGymGuyWinText:
	text "Pryce is some-"
	line "thing, but you're"
	cont "something else!"

	para "That was a hot"
	line "battle that"

	para "bridged the gen-"
	line "eration gap!"
	done
