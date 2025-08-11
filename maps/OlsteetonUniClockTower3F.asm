OlsteetonUniClockTower3F_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  5,  9, OLSTEETON_UNI_CLOCK_TOWER_2F, 2

	def_coord_events
	; coord_event  9,  9, 0, OlsteetonUniClockTower3FRivalScene

	def_bg_events
	bg_event  5,  5, BGEVENT_JUMPTEXT, OlsteetonUniClockTower3FStatueText
	bg_event  6,  5, BGEVENT_JUMPTEXT, OlsteetonUniClockTower3FStatueText

	def_object_events
	; object_event  8,  4, SPRITE_RIVAL, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, 0, OBJECTTYPE_SCRIPT, 0, ObjectEvent, EVENT_RIVAL_SPROUT_TOWER
	; object_event  3,  7, SPRITE_SAGE, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 2, GenericTrainerClockTowerTroy, -1
	; object_event  8,  6, SPRITE_SAGE, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerClockTowerNeal, -1
	; object_event  6,  1, SPRITE_ELDER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, 0, OBJECTTYPE_SCRIPT, 0, ElderLiScript, -1
	itemball_event  8,  8, POTION, 1, EVENT_SPROUT_TOWER_3F_POTION
	itemball_event  3,  1, ESCAPE_ROPE, 1, EVENT_SPROUT_TOWER_3F_ESCAPE_ROPE

	object_const_def
	; const OlsteetonUniClockTower3F_RIVAL

; OlsteetonUniClockTower3FRivalScene:
; 	turnobject PLAYER, UP
; 	showemote EMOTE_SHOCK, PLAYER, 15
; 	special Special_FadeOutMusic
; 	playsound SFX_TACKLE
; 	earthquake 79
; 	pause 15
; 	playsound SFX_TACKLE
; 	earthquake 79
; 	applymovement PLAYER, OlsteetonUniClockTower3FPlayerApproachesRivalMovement
; 	applyonemovement OlsteetonUniClockTower3F_RIVAL, step_up
; 	showtext OlsteetonUniClockTowerElderLecturesRivalText
; 	showemote EMOTE_SHOCK, OlsteetonUniClockTower3F_RIVAL, 15
; 	turnobject OlsteetonUniClockTower3F_RIVAL, DOWN
; 	pause 15
; 	applymovement OlsteetonUniClockTower3F_RIVAL, OlsteetonUniClockTower3FRivalLeavesElderMovement
; 	playmusic MUSIC_RIVAL_ENCOUNTER
; 	showtext OlsteetonUniClockTowerRivalOnlyCareAboutStrongText
; 	turnobject OlsteetonUniClockTower3F_RIVAL, UP
; 	opentext
; 	writetext OlsteetonUniClockTowerRivalUsedEscapeRopeText
; 	pause 15
; 	closetext
; 	playsound SFX_WARP_TO
; 	special Special_FadeBlackQuickly
; 	special Special_ReloadSpritesNoPalettes
; 	disappear OlsteetonUniClockTower3F_RIVAL
; 	waitsfx
; 	special Special_FadeInQuickly
; 	setscene $1
; 	special RestartMapMusic
; 	end

; ElderLiScript:
; 	checkevent EVENT_GOT_TM70_FLASH
; 	iftrue_jumptextfaceplayer ClockTowerLiAfterBattleText
; 	faceplayer
; 	showtext ClockTowerLiSeenText
; 	winlosstext ClockTowerLiBeatenText, 0
; 	loadtrainer ELDER, LI
; 	startbattle
; 	reloadmapafterbattle
; 	opentext
; 	writetext ClockTowerLiTakeThisFlashText
; 	promptbutton
; 	verbosegivetmhm TM_FLASH
; 	setevent EVENT_GOT_TM70_FLASH
; 	setevent EVENT_BEAT_ELDER_LI
; 	jumpthisopenedtext

; 	text "Flash illuminates"
; 	line "even the darkest"
; 	cont "of all places."

; 	para "You need not teach"
; 	line "it to your #mon"

; 	para "unless you wish"
; 	line "to use Flash in"
; 	cont "battle."

; 	para "Simply press A in"
; 	line "the darkness, and"

; 	para "if any of your"
; 	line "#mon can use"
; 	cont "Flash, they will."
; 	done

; GenericTrainerClockTowerJin:
; 	generictrainer ClockTower, JIN, EVENT_BEAT_ClockTower_JIN, ClockTowerJinSeenText, ClockTowerJinBeatenText

; 	text "As #mon grow"
; 	line "stronger, so does"
; 	cont "the trainer."

; 	para "No, wait. As the"
; 	line "trainer grows"

; 	para "stronger, so do"
; 	line "the #mon."
; 	done

; GenericTrainerClockTowerTroy:
; 	generictrainer ClockTower, TROY, EVENT_BEAT_ClockTower_TROY, ClockTowerTroySeenText, ClockTowerTroyBeatenText

; 	text "It is not far to"
; 	line "the Elder."
; 	done

; GenericTrainerClockTowerNeal:
; 	generictrainer ClockTower, NEAL, EVENT_BEAT_ClockTower_NEAL, ClockTowerNealSeenText, ClockTowerNealBeatenText

; 	text "Let there be light"
; 	line "on your journey."
; 	done

OlsteetonUniClockTower3FPlayerApproachesRivalMovement:
	step_up
	step_up
	step_up
	step_up
	step_end

OlsteetonUniClockTower3FRivalLeavesElderMovement:
	step_right
	step_down
	step_end

; OlsteetonUniClockTowerElderLecturesRivalText:
; 	text "Elder: You are in-"
; 	line "deed skilled as a"
; 	cont "trainer."

; 	para "As promised, here"
; 	line "is your TM."

; 	para "But let me say"
; 	line "this: You should"

; 	para "treat your"
; 	line "#mon better."

; 	para "The way you battle"
; 	line "is far too harsh."

; 	para "#mon are not"
; 	line "tools of war…"
; 	done

; OlsteetonUniClockTowerRivalOnlyCareAboutStrongText:
; 	text "…"
; 	line "…Humph!"

; 	para "He claims to be"
; 	line "the Elder but"
; 	cont "he's weak."

; 	para "It stands to"
; 	line "reason."

; 	para "I'd never lose to"
; 	line "fools who babble"

; 	para "about being nice"
; 	line "to #mon."

; 	para "I only care about"
; 	line "strong #mon"
; 	cont "that can win."

; 	para "I really couldn't"
; 	line "care less about"
; 	cont "weak #mon."
; 	done

; OlsteetonUniClockTowerRivalUsedEscapeRopeText:
; 	text "<RIVAL> used an"
; 	line "Escape Rope!"
; 	done

; ClockTowerLiSeenText:
; 	text "So good of you to"
; 	line "come here!"

; 	para "Sprout Tower is a"
; 	line "place of training."

; 	para "People and #mon"
; 	line "test their bonds"

; 	para "to build a bright"
; 	line "future together."

; 	para "I am the final"
; 	line "test."

; 	para "Allow me to check"
; 	line "the ties between"

; 	para "your #mon and"
; 	line "you!"
; 	done

; ClockTowerLiBeatenText:
; 	text "Ah, excellent!"
; 	done

; ClockTowerLiTakeThisFlashText:
; 	text "You and your #-"
; 	line "mon should have"

; 	para "no problem using"
; 	line "this move."

; 	para "Take this Flash"
; 	line "TM."
; 	done

; ClockTowerLiAfterBattleText:
; 	text "I hope you learn"
; 	line "and grow from your"
; 	cont "journey."
; 	done

; ClockTowerJinSeenText:
; 	text "I train to find"
; 	line "enlightenment in"
; 	cont "#mon!"
; 	done

; ClockTowerJinBeatenText:
; 	text "My training is"
; 	line "incomplete…"
; 	done

; ClockTowerTroySeenText:
; 	text "Let me see how"
; 	line "much you trust"
; 	cont "your #mon."
; 	done

; ClockTowerTroyBeatenText:
; 	text "Yes, your trust is"
; 	line "real!"
; 	done

; ClockTowerNealSeenText:
; 	text "The Elder's TM"
; 	line "lights even pitch-"
; 	cont "black darkness."
; 	done

; ClockTowerNealBeatenText:
; 	text "It is my head that"
; 	line "is bright!"
; 	done

; OlsteetonUniClockTower3FPaintingText:
; 	text "It's a powerful"
; 	line "painting of a"
; 	cont "Bellsprout."
; 	done

OlsteetonUniClockTower3FStatueText:
	text "It's a"
	line "giant hourglass."
	done
