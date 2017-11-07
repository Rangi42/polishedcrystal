SeafoamGym_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

SeafoamGym_MapEventHeader:

.Warps: db 1
	warp_def 20, 12, 2, SEAFOAM_ISLANDS_1F

.XYTriggers: db 0

.Signposts: db 0

.PersonEvents: db 8
	person_event SPRITE_GYM_GUY, 20, 10, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, SeafoamGymGuyScript, EVENT_SEAFOAM_GYM_GYM_GUY
	person_event SPRITE_SCIENTIST, 16, 7, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_TRAINER, 1, TrainerScientistLowell, -1
	person_event SPRITE_SCIENTIST, 14, 14, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_TRAINER, 1, TrainerScientistDennett, -1
	person_event SPRITE_SUPER_NERD, 12, 19, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_TRAINER, 1, TrainerSupernerdCary, -1
	person_event SPRITE_SCIENTIST, 7, 12, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_TRAINER, 1, TrainerScientistLinden, -1
	person_event SPRITE_SUPER_NERD, 5, 10, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_TRAINER, 1, TrainerSupernerdWaldo, -1
	person_event SPRITE_SUPER_NERD, 14, 6, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_TRAINER, 1, TrainerSupernerdMerle, -1
	person_event SPRITE_BLAINE, 11, 12, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_SCRIPT, 0, BlaineScript_0x1ab4fb, -1

const_value set 1
	const SEAFOAMGYM_GYM_GUY

TrainerScientistLowell:
	trainer EVENT_BEAT_SCIENTIST_LOWELL, SCIENTIST, LOWELL, ScientistLowellSeenText, ScientistLowellBeatenText, 0, ScientistLowellScript

ScientistLowellScript:
	end_if_just_battled
	jumptextfaceplayer ScientistLowellAfterText

TrainerScientistDennett:
	trainer EVENT_BEAT_SCIENTIST_DENNETT, SCIENTIST, DENNETT, ScientistDennettSeenText, ScientistDennettBeatenText, 0, ScientistDennettScript

ScientistDennettScript:
	end_if_just_battled
	jumptextfaceplayer ScientistDennettAfterText

TrainerSupernerdCary:
	trainer EVENT_BEAT_SUPER_NERD_CARY, SUPER_NERD, CARY, SupernerdCarySeenText, SupernerdCaryBeatenText, 0, SupernerdCaryScript

SupernerdCaryScript:
	end_if_just_battled
	jumptextfaceplayer SupernerdCaryAfterText

TrainerScientistLinden:
	trainer EVENT_BEAT_SCIENTIST_LINDEN, SCIENTIST, LINDEN, ScientistLindenSeenText, ScientistLindenBeatenText, 0, ScientistLindenScript

ScientistLindenScript:
	end_if_just_battled
	jumptextfaceplayer ScientistLindenAfterText

TrainerSupernerdWaldo:
	trainer EVENT_BEAT_SUPER_NERD_WALDO, SUPER_NERD, WALDO, SupernerdWaldoSeenText, SupernerdWaldoBeatenText, 0, SupernerdWaldoScript

SupernerdWaldoScript:
	end_if_just_battled
	jumptextfaceplayer SupernerdWaldoAfterText

TrainerSupernerdMerle:
	trainer EVENT_BEAT_SUPER_NERD_MERLE, SUPER_NERD, MERLE, SupernerdMerleSeenText, SupernerdMerleBeatenText, 0, SupernerdMerleScript

SupernerdMerleScript:
	end_if_just_battled
	jumptextfaceplayer SupernerdMerleAfterText

BlaineScript_0x1ab4fb:
	faceplayer
	opentext
	checkflag ENGINE_VOLCANOBADGE
	iftrue .FightDone
	writetext UnknownText_0x1ab548
	waitbutton
	closetext
	winlosstext UnknownText_0x1ab646, 0
	loadtrainer BLAINE, 1
	startbattle
	iftrue .ReturnAfterBattle
	appear SEAFOAMGYM_GYM_GUY
.ReturnAfterBattle:
	reloadmapafterbattle
	setevent EVENT_BEAT_BLAINE
	setevent EVENT_BEAT_SCIENTIST_LOWELL
	setevent EVENT_BEAT_SCIENTIST_DENNETT
	setevent EVENT_BEAT_SUPER_NERD_CARY
	setevent EVENT_BEAT_SCIENTIST_LINDEN
	setevent EVENT_BEAT_SUPER_NERD_WALDO
	setevent EVENT_BEAT_SUPER_NERD_MERLE
	opentext
	writetext UnknownText_0x1ab683
	playsound SFX_GET_BADGE
	waitsfx
	setflag ENGINE_VOLCANOBADGE
	checkcode VAR_BADGES
	if_equal 9, .FirstBadge
	if_equal 10, .SecondBadge
	if_equal 12, .LyrasEgg
	jump .FightDone
.FirstBadge:
	specialphonecall SPECIALCALL_FIRSTBADGE
	jump .FightDone
.SecondBadge:
	checkevent EVENT_GOT_GS_BALL_FROM_POKECOM_CENTER
	iftrue .FightDone
	specialphonecall SPECIALCALL_SECONDBADGE
	jump .FightDone
.LyrasEgg:
	specialphonecall SPECIALCALL_LYRASEGG
.FightDone:
	checkevent EVENT_GOT_TM61_WILL_O_WISP
	iftrue BlaineAfterTMScript
	writetext UnknownText_0x1ab69d
	buttonsound
	verbosegivetmhm TM_WILL_O_WISP
	setevent EVENT_GOT_TM61_WILL_O_WISP
	jumpopenedtext BlaineOutroText

BlaineAfterTMScript:
	jumpopenedtext UnknownText_0x1ab71c

SeafoamGymGuyScript:
	faceplayer
	opentext
	checkevent EVENT_TALKED_TO_SEAFOAM_GYM_GUY_ONCE
	iftrue .TalkedToSeafoamGymGuyScript
	writetext SeafoamGymGuyWinText
	waitbutton
	closetext
	setevent EVENT_TALKED_TO_SEAFOAM_GYM_GUY_ONCE
	end

.TalkedToSeafoamGymGuyScript:
	jumpopenedtext SeafoamGymGuyWinText2

ScientistLowellSeenText:
	text "This lab coat"
	line "makes me feel"
	cont "smarter for some"
	cont "reason."
	done

ScientistLowellBeatenText:
	text "A white lab coat"
	line "is a researcher's"
	cont "life."
	done

ScientistLowellAfterText:
	text "We may be in a"
	line "cave, but we"
	cont "always do the"
	cont "laundry."
	done

ScientistDennettSeenText:
	text "Blaine may have"
	line "lost his Gym, but"
	cont "he never gives up!"
	done

ScientistDennettBeatenText:
	text "Blaine's persever-"
	line "ance motivates me!"
	done

ScientistDennettAfterText:
	text "Together with"
	line "Blaine, we will"
	cont "rebuild our Gym!"
	done

SupernerdCarySeenText:
	text "Wow, a Gym in a"
	line "cave like this?"

	para "I'd love to"
	line "explore it."
	done

SupernerdCaryBeatenText:
	text "A bitter"
	line "defeat…"
	done

SupernerdCaryAfterText:
	text "Bitterness leads"
	line "to improvement."
	done

ScientistLindenSeenText:
	text "We lost the Gym on"
	line "Cinnabar Island,"
	cont "but we came here."
	done

ScientistLindenBeatenText:
	text "We accept defeat"
	line "gracefully…"
	done

ScientistLindenAfterText:
	text "Not all scientists"
	line "help the bad guys."
	done

SupernerdWaldoSeenText:
	text "I am collecting"
	line "battle records."

	para "Can you help me?"
	done

SupernerdWaldoBeatenText:
	text "I didn't expect"
	line "you to be so good!"
	done

SupernerdWaldoAfterText:
	text "Who in the world"
	line "are you?"
	done

SupernerdMerleSeenText:
	text "Ooh!"
	line "You look easily"
	cont "defeated!"
	done

SupernerdMerleBeatenText:
	text "Pardon me!"
	done

SupernerdMerleAfterText:
	text "I failed to"
	line "sense how strong"
	cont "you are."
	done

UnknownText_0x1ab548:
	text "Blaine: Waaah!"

	para "My Gym in Cinnabar"
	line "burned down."

	para "My fire-breathing"
	line "#mon and I are"

	para "homeless because"
	line "of the volcano."

	para "Waaah!"

	para "But I'm back in"
	line "business as a Gym"

	para "Leader here in"
	line "this cave."

	para "If you can beat"
	line "me, I'll give you"
	cont "a Badge."

	para "Ha! You'd better"
	line "have Burn Heal!"
	done

UnknownText_0x1ab646:
	text "Blaine: Awesome."
	line "I've burned out…"

	para "You've earned the"
	line "Volcano Badge!"
	done

UnknownText_0x1ab683:
	text "<PLAYER> received"
	line "the Volcano Badge."
	done

UnknownText_0x1ab69d:
	text "Here, I'll give you"
	line "this, too."
	done

BlaineOutroText:
	text "It's called Will-"
	line "O-Wisp!"

	para "It weakens your"
	line "foe by inflicting"
	cont "a burn."

	para "I did lose this"
	line "time, but I'm going"
	cont "to win next time."

	para "When I rebuild my"
	line "Cinnabar Gym,"

	para "we'll have to have"
	line "a rematch."
	done

UnknownText_0x1ab71c:
	text "Blaine: My fire"
	line "#mon will be"

	para "even stronger."
	line "Just you watch!"
	done

SeafoamGymGuyWinText:
	text "Yo!"

	para "…Huh? It's over"
	line "already?"

	para "Sorry, sorry!"

	para "Cinnabar Gym was"
	line "gone, so I didn't"

	para "know where to find"
	line "you."

	para "But, hey, you're"
	line "plenty strong even"

	para "without my advice."
	line "I knew you'd win!"
	done

SeafoamGymGuyWinText2:
	text "A #mon Gym can"
	line "be anywhere as"

	para "long as the Gym"
	line "Leader is there."

	para "There's no need"
	line "for a building."
	done
