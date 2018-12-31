SlowpokeWellB1F_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

SlowpokeWellB1F_MapEventHeader:

.Warps: db 2
	warp_def 15, 17, 6, AZALEA_TOWN
	warp_def 11, 7, 1, SLOWPOKE_WELL_B2F

.XYTriggers: db 0

.Signposts: db 0

.PersonEvents: db 9
	person_event SPRITE_PROTON, 2, 5, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_TRAINER, 1, TrainerProton2, EVENT_SLOWPOKE_WELL_ROCKETS
	person_event SPRITE_ROCKET, 7, 15, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, PERSONTYPE_TRAINER, 3, TrainerGruntM29, EVENT_SLOWPOKE_WELL_ROCKETS
	person_event SPRITE_ROCKET, 6, 5, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, PERSONTYPE_TRAINER, 2, TrainerGruntM2, EVENT_SLOWPOKE_WELL_ROCKETS
	person_event SPRITE_ROCKET_GIRL, 4, 10, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_TRAINER, 4, TrainerGruntF1, EVENT_SLOWPOKE_WELL_ROCKETS
	person_event SPRITE_KURT, 14, 16, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x5a6b5, EVENT_SLOWPOKE_WELL_KURT
	person_event SPRITE_SLOWPOKETAIL, 4, 7, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, SlowpokeScript_0x5a681, EVENT_SLOWPOKE_WELL_SLOWPOKES
	person_event SPRITE_SLOWPOKETAIL, 2, 6, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_POKEMON, SLOWPOKE, UnknownText_0x5ac61, EVENT_SLOWPOKE_WELL_SLOWPOKES
	strengthboulder_event 2, 3
	itemball_event 3, 10, SUPER_POTION, 1, EVENT_SLOWPOKE_WELL_B1F_SUPER_POTION

const_value set 1
	const SLOWPOKEWELLB1F_PROTON
	const SLOWPOKEWELLB1F_ROCKET1
	const SLOWPOKEWELLB1F_ROCKET2
	const SLOWPOKEWELLB1F_ROCKET_GIRL
	const SLOWPOKEWELLB1F_KURT

TrainerGruntM29:
	trainer EVENT_BEAT_ROCKET_GRUNTM_29, GRUNTM, 29, GruntM29SeenText, GruntM29BeatenText, 0, GruntM29Script

GruntM29Script:
	end_if_just_battled
	jumptextfaceplayer TrainerGruntM29SlowpokeProfitText

TrainerProton2:
	trainer EVENT_BEAT_PROTON_2, PROTON, PROTON2, Proton2SeenText, Proton2BeatenText, 0, Proton2Script

Proton2Script:
	showtext TrainerProton2WhenTalkText
	special Special_FadeBlackQuickly
	special Special_ReloadSpritesNoPalettes
	disappear SLOWPOKEWELLB1F_PROTON
	disappear SLOWPOKEWELLB1F_ROCKET1
	disappear SLOWPOKEWELLB1F_ROCKET2
	disappear SLOWPOKEWELLB1F_ROCKET_GIRL
	pause 15
	special Special_FadeInQuickly
	disappear SLOWPOKEWELLB1F_KURT
	moveperson SLOWPOKEWELLB1F_KURT, 11, 6
	appear SLOWPOKEWELLB1F_KURT
	applymovement SLOWPOKEWELLB1F_KURT, KurtSlowpokeWellVictoryMovementData
	spriteface PLAYER, RIGHT
	showtext KurtLeaveSlowpokeWellText
	setevent EVENT_CLEARED_SLOWPOKE_WELL
	domaptrigger ILEX_FOREST, $2
	clearevent EVENT_ILEX_FOREST_APPRENTICE
	clearevent EVENT_ILEX_FOREST_FARFETCHD
	setevent EVENT_CHARCOAL_KILN_FARFETCH_D
	setevent EVENT_CHARCOAL_KILN_APPRENTICE
	setevent EVENT_SLOWPOKE_WELL_SLOWPOKES
	setevent EVENT_SLOWPOKE_WELL_KURT
	clearevent EVENT_AZALEA_TOWN_SLOWPOKES
	clearevent EVENT_KURTS_HOUSE_SLOWPOKE
	clearevent EVENT_KURTS_HOUSE_KURT_1
	special FadeOutPalettes
	special HealParty
	pause 15
	warp KURTS_HOUSE, 3, 3
	end

TrainerGruntM2:
	trainer EVENT_BEAT_ROCKET_GRUNTM_2, GRUNTM, 2, GruntM2SeenText, GruntM2BeatenText, 0, GruntM2Script

GruntM2Script:
	end_if_just_battled
	jumptextfaceplayer UnknownText_0x5aaf2

TrainerGruntF1:
	trainer EVENT_BEAT_ROCKET_GRUNTF_1, GRUNTF, 1, GruntF1SeenText, GruntF1BeatenText, 0, GruntF1Script

GruntF1Script:
	end_if_just_battled
	jumptextfaceplayer UnknownText_0x5ab8d

SlowpokeScript_0x5a681:
	faceplayer
	opentext
	cry SLOWPOKE
	writetext UnknownText_0x5abcb
	yesorno
	iftrue_jumpopenedtext UnknownText_0x5ac09
	endtext

KurtSlowpokeWellVictoryMovementData:
	step_left
	step_left
	step_left
	step_left
	step_up
	step_sleep_8
	step_sleep_8
	step_sleep_8
	step_left
	step_up
	step_up
	step_sleep_8
	step_sleep_8
	step_sleep_8
	turn_head_left
	step_end

UnknownText_0x5a6b5:
	text "Kurt: Hey there,"
	line "<PLAYER>!"

	para "The guard up top"
	line "took off when I"
	cont "shouted at him."

	para "But then I took a"
	line "tumble down the"
	cont "well."

	para "I slammed down"
	line "hard on my back,"
	cont "so I can't move."

	para "Rats! If I were"
	line "fit, my #mon"

	para "would've punished"
	line "them…"

	para "Ah, it can't be"
	line "helped."

	para "<PLAYER>, show them"
	line "how gutsy you are"
	cont "in my place!"
	done

KurtLeaveSlowpokeWellText:
	text "Kurt: Way to go,"
	line "<PLAYER>!"

	para "Team Rocket has"
	line "taken off."

	para "My back's better"
	line "too. Let's get out"
	cont "of here."
	done

GruntM29SeenText:
	text "Darn! I was stand-"
	line "ing guard up top"

	para "when some old coot"
	line "yelled at me."

	para "He startled me so"
	line "much that I fell"
	cont "down here."

	para "I think I'll vent"
	line "my anger by taking"
	cont "it out on you!"
	done

GruntM29BeatenText:
	text "Arrgh! This is NOT"
	line "my day!"
	done

TrainerGruntM29SlowpokeProfitText:
	text "Sure, we've been"
	line "hacking the tails"

	para "off Slowpoke and"
	line "selling them."

	para "Everything we do"
	line "is for profit."

	para "That's right!"
	line "We're Team Rocket,"

	para "and we'll do any-"
	line "thing for money!"
	done

Proton2SeenText:
	text "What do you want?"

	para "I'm known as the"
	line "scariest and"

	para "cruelest guy in"
	line "Team Rocket…"

	para "If you interrupt"
	line "our work, don't"
	cont "expect any mercy!"
	done

Proton2BeatenText:
	text "You did OK today,"
	line "but wait till next"
	cont "time!"
	done

TrainerProton2WhenTalkText:
	text "Yeah, Team Rocket"
	line "was broken up"
	cont "three years ago."

	para "But we continued"
	line "our activities"
	cont "underground."

	para "Now you can have"
	line "fun watching us"
	cont "stir up trouble!"
	done

GruntM2SeenText:
	text "Quit taking Slow-"
	line "pokeTails?"

	para "If we obeyed you,"
	line "Team Rocket's rep"
	cont "would be ruined!"
	done

GruntM2BeatenText:
	text "Just…"
	line "Too strong…"
	done

UnknownText_0x5aaf2:
	text "We need the money,"
	line "but selling Slow-"
	cont "pokeTails?"

	para "It's tough being a"
	line "Rocket Grunt!"
	done

GruntF1SeenText:
	text "Stop taking Tails?"

	para "Yeah, just try to"
	line "defeat all of us!"
	done

GruntF1BeatenText:
	text "You rotten brat!"
	done

UnknownText_0x5ab8d:
	text "SlowpokeTails"
	line "grow back fast!"

	para "What's wrong with"
	line "selling them?"
	done

UnknownText_0x5abcb:
	text "A Slowpoke with"
	line "its tail cut off…"

	para "Huh? It has Mail."
	line "Read it?"
	done

UnknownText_0x5ac09:
	text "<PLAYER> read the"
	line "Mail."

	para "Be good and look"
	line "after the house"

	para "with Grandpa and"
	line "Slowpoke."

	para "Love, Dad"
	done

UnknownText_0x5ac61:
	text "A Slowpoke with"
	line "its tail cut off…"
	done
