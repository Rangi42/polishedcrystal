SeafoamGym_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event 12, 20, SEAFOAM_ISLANDS_1F, 2

	def_coord_events

	def_bg_events

	def_object_events
	object_event 10, 20, SPRITE_GYM_GUY, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, SeafoamGymGuyScript, EVENT_SEAFOAM_GYM_GYM_GUY
	object_event  7, 16, SPRITE_SCIENTIST, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 1, GenericTrainerScientistLowell, -1
	object_event 14, 14, SPRITE_SCIENTIST, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 1, GenericTrainerScientistDennett, -1
	object_event 19, 12, SPRITE_SUPER_NERD, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 1, GenericTrainerSupernerdCary, -1
	object_event 12,  7, SPRITE_SCIENTIST, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 1, GenericTrainerScientistLinden, -1
	object_event 10,  5, SPRITE_SUPER_NERD, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 1, GenericTrainerSupernerdWaldo, -1
	object_event  6, 14, SPRITE_SUPER_NERD, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 1, GenericTrainerSupernerdMerle, -1
	object_event 12, 11, SPRITE_BLAINE, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, SeafoamGymBlaineScript, -1

	object_const_def
	const SEAFOAMGYM_GYM_GUY

GenericTrainerScientistLowell:
	generictrainer SCIENTIST, LOWELL, EVENT_BEAT_SCIENTIST_LOWELL, ScientistLowellSeenText, ScientistLowellBeatenText

	text "We may be in a"
	line "cave, but we"
	cont "always do the"
	cont "laundry."
	done

GenericTrainerScientistDennett:
	generictrainer SCIENTIST, DENNETT, EVENT_BEAT_SCIENTIST_DENNETT, ScientistDennettSeenText, ScientistDennettBeatenText

	text "Together with"
	line "Blaine, we will"
	cont "rebuild our Gym!"
	done

GenericTrainerSupernerdCary:
	generictrainer SUPER_NERD, CARY, EVENT_BEAT_SUPER_NERD_CARY, SupernerdCarySeenText, SupernerdCaryBeatenText

	text "Bitterness leads"
	line "to improvement."
	done

GenericTrainerScientistLinden:
	generictrainer SCIENTIST, LINDEN, EVENT_BEAT_SCIENTIST_LINDEN, ScientistLindenSeenText, ScientistLindenBeatenText

	text "Not all scientists"
	line "help the bad guys."
	done

GenericTrainerSupernerdWaldo:
	generictrainer SUPER_NERD, WALDO, EVENT_BEAT_SUPER_NERD_WALDO, SupernerdWaldoSeenText, SupernerdWaldoBeatenText

	text "Who in the world"
	line "are you?"
	done

GenericTrainerSupernerdMerle:
	generictrainer SUPER_NERD, MERLE, EVENT_BEAT_SUPER_NERD_MERLE, SupernerdMerleSeenText, SupernerdMerleBeatenText

	text "I failed to"
	line "sense how strong"
	cont "you are."
	done

SeafoamGymBlaineScript:
	faceplayer
	opentext
	checkflag ENGINE_VOLCANOBADGE
	iftrue .FightDone
	writetext BlaineIntroText
	waitbutton
	closetext
	winlosstext BlaineWinLossText, 0
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
	writetext ReceivedVolcanoBadgeText
	playsound SFX_GET_BADGE
	waitsfx
	setflag ENGINE_VOLCANOBADGE
	checkcode VAR_BADGES
	ifequal 9, .FirstBadge
	ifequal 10, .SecondBadge
	ifequal 12, .LyrasEgg
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
	iftrue_jumpopenedtext BlaineFightDoneText
	writetext BlaineAfterBattleText
	buttonsound
	verbosegivetmhm TM_WILL_O_WISP
	setevent EVENT_GOT_TM61_WILL_O_WISP
	jumpthisopenedtext

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

SeafoamGymGuyScript:
	checkevent EVENT_TALKED_TO_SEAFOAM_GYM_GUY_ONCE
	iftrue_jumptextfaceplayer SeafoamGymGuyWinText2
	setevent EVENT_TALKED_TO_SEAFOAM_GYM_GUY_ONCE
	jumpthistextfaceplayer

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

ScientistDennettSeenText:
	text "Blaine may have"
	line "lost his Gym, but"
	cont "he never gives up!"
	done

ScientistDennettBeatenText:
	text "Blaine's persever-"
	line "ance motivates me!"
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

ScientistLindenSeenText:
	text "We lost the Gym on"
	line "Cinnabar Island,"
	cont "but we came here."
	done

ScientistLindenBeatenText:
	text "We accept defeat"
	line "gracefully…"
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

SupernerdMerleSeenText:
	text "Ooh!"
	line "You look easily"
	cont "defeated!"
	done

SupernerdMerleBeatenText:
	text "Pardon me!"
	done

BlaineIntroText:
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

BlaineWinLossText:
	text "Blaine: Awesome."
	line "I've burned out…"

	para "You've earned the"
	line "Volcano Badge!"
	done

ReceivedVolcanoBadgeText:
	text "<PLAYER> received"
	line "the Volcano Badge."
	done

BlaineAfterBattleText:
	text "Here, I'll give you"
	line "this, too."
	done

BlaineFightDoneText:
	text "Blaine: My fire"
	line "#mon will be"

	para "even stronger."
	line "Just you watch!"
	done

SeafoamGymGuyWinText2:
	text "A #mon Gym can"
	line "be anywhere as"

	para "long as the Gym"
	line "Leader is there."

	para "There's no need"
	line "for a building."
	done
