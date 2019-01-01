SproutTower3F_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 1 ; warp events
	warp_event  8, 14, SPROUT_TOWER_2F, 4

	db 1 ; coord events
	coord_event  9,  9, 0, UnknownScript_0x184947

	db 6 ; bg events
	bg_event  6,  1, SIGNPOST_JUMPTEXT, UnknownText_0x184f61
	bg_event  9,  1, SIGNPOST_JUMPTEXT, UnknownText_0x184f61
	bg_event  7,  0, SIGNPOST_JUMPTEXT, UnknownText_0x184f37
	bg_event  8,  0, SIGNPOST_JUMPTEXT, UnknownText_0x184f37
	bg_event  3, 15, SIGNPOST_JUMPTEXT, UnknownText_0x184f61
	bg_event 12, 15, SIGNPOST_JUMPTEXT, UnknownText_0x184f61

	db 7 ; object events
	object_event  8,  4, SPRITE_SILVER, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, ObjectEvent, EVENT_RIVAL_SPROUT_TOWER
	object_event  6, 13, SPRITE_SAGE, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_BLUE, PERSONTYPE_GENERICTRAINER, 3, GenericTrainerSageJin, -1
	object_event  6,  8, SPRITE_SAGE, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BLUE, PERSONTYPE_GENERICTRAINER, 2, GenericTrainerSageTroy, -1
	object_event  9, 11, SPRITE_SAGE, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_BLUE, PERSONTYPE_GENERICTRAINER, 3, GenericTrainerSageNeal, -1
	object_event  8,  2, SPRITE_ELDER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_GREEN, PERSONTYPE_SCRIPT, 0, ElderLiScript, -1
	itemball_event  4, 14, POTION, 1, EVENT_SPROUT_TOWER_3F_POTION
	itemball_event 12,  1, ESCAPE_ROPE, 1, EVENT_SPROUT_TOWER_3F_ESCAPE_ROPE

	const_def 1 ; object constants
	const SPROUTTOWER3F_SILVER

UnknownScript_0x184947:
	turnobject PLAYER, UP
	showemote EMOTE_SHOCK, PLAYER, 15
	special Special_FadeOutMusic
	playsound SFX_TACKLE
	playsound SFX_ELEVATOR
	earthquake 79
	pause 15
	playsound SFX_TACKLE
	playsound SFX_ELEVATOR
	earthquake 79
	applymovement PLAYER, MovementData_0x184a1d
	applyonemovement SPROUTTOWER3F_SILVER, step_up
	showtext UnknownText_0x184a27
	showemote EMOTE_SHOCK, SPROUTTOWER3F_SILVER, 15
	turnobject SPROUTTOWER3F_SILVER, DOWN
	pause 15
	applymovement SPROUTTOWER3F_SILVER, MovementData_0x184a24
	playmusic MUSIC_RIVAL_ENCOUNTER
	showtext UnknownText_0x184aec
	turnobject SPROUTTOWER3F_SILVER, UP
	opentext
	writetext UnknownText_0x184bc8
	pause 15
	closetext
	playsound SFX_WARP_TO
	special Special_FadeBlackQuickly
	special Special_ReloadSpritesNoPalettes
	disappear SPROUTTOWER3F_SILVER
	waitsfx
	special Special_FadeInQuickly
	setscene $1
	special RestartMapMusic
	end

ElderLiScript:
	checkevent EVENT_GOT_TM70_FLASH
	iftrue_jumptextfaceplayer UnknownText_0x184d88
	faceplayer
	showtext SageLiSeenText
	winlosstext SageLiBeatenText, 0
	loadtrainer ELDER, LI
	startbattle
	reloadmapafterbattle
	opentext
	writetext UnknownText_0x184cc2
	buttonsound
	verbosegivetmhm TM_FLASH
	setevent EVENT_GOT_TM70_FLASH
	setevent EVENT_BEAT_ELDER_LI
	thisopenedtext

	text "Flash illuminates"
	line "even the darkest"
	cont "of all places."
	done

GenericTrainerSageJin:
	generictrainer SAGE, JIN, EVENT_BEAT_SAGE_JIN, SageJinSeenText, SageJinBeatenText

	text "As #mon grow"
	line "stronger, so does"
	cont "the trainer."

	para "No, wait. As the"
	line "trainer grows"

	para "stronger, so do"
	line "the #mon."
	done

GenericTrainerSageTroy:
	generictrainer SAGE, TROY, EVENT_BEAT_SAGE_TROY, SageTroySeenText, SageTroyBeatenText

	text "It is not far to"
	line "the Elder."
	done

GenericTrainerSageNeal:
	generictrainer SAGE, NEAL, EVENT_BEAT_SAGE_NEAL, SageNealSeenText, SageNealBeatenText

	text "Let there be light"
	line "on your journey."
	done

MovementData_0x184a1d:
	step_up
	step_up
	step_up
	step_up
	step_end

MovementData_0x184a24:
	step_right
	step_down
	step_end

UnknownText_0x184a27:
	text "Elder: You are in-"
	line "deed skilled as a"
	cont "trainer."

	para "As promised, here"
	line "is your TM."

	para "But let me say"
	line "this: You should"

	para "treat your"
	line "#mon better."

	para "The way you battle"
	line "is far too harsh."

	para "#mon are not"
	line "tools of war…"
	done

UnknownText_0x184aec:
	text "…"
	line "…Humph!"

	para "He claims to be"
	line "the Elder but"
	cont "he's weak."

	para "It stands to"
	line "reason."

	para "I'd never lose to"
	line "fools who babble"

	para "about being nice"
	line "to #mon."

	para "I only care about"
	line "strong #mon"
	cont "that can win."

	para "I really couldn't"
	line "care less about"
	cont "weak #mon."
	done

UnknownText_0x184bc8:
	text "<RIVAL> used an"
	line "Escape Rope!"
	done

SageLiSeenText:
	text "So good of you to"
	line "come here!"

	para "Sprout Tower is a"
	line "place of training."

	para "People and #mon"
	line "test their bonds"

	para "to build a bright"
	line "future together."

	para "I am the final"
	line "test."

	para "Allow me to check"
	line "the ties between"

	para "your #mon and"
	line "you!"
	done

SageLiBeatenText:
	text "Ah, excellent!"
	done

UnknownText_0x184cc2:
	text "You and your #-"
	line "mon should have"

	para "no problem using"
	line "this move."

	para "Take this Flash"
	line "TM."
	done

UnknownText_0x184d88:
	text "I hope you learn"
	line "and grow from your"
	cont "journey."
	done

SageJinSeenText:
	text "I train to find"
	line "enlightenment in"
	cont "#mon!"
	done

SageJinBeatenText:
	text "My training is"
	line "incomplete…"
	done

SageTroySeenText:
	text "Let me see how"
	line "much you trust"
	cont "your #mon."
	done

SageTroyBeatenText:
	text "Yes, your trust is"
	line "real!"
	done

SageNealSeenText:
	text "The Elder's TM"
	line "lights even pitch-"
	cont "black darkness."
	done

SageNealBeatenText:
	text "It is my head that"
	line "is bright!"
	done

UnknownText_0x184f37:
	text "It's a powerful"
	line "painting of a"
	cont "Bellsprout."
	done

UnknownText_0x184f61:
	text "A #mon statue…"

	para "It looks very"
	line "distinguished."
	done
