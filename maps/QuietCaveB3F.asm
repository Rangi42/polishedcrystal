const_value set 2
	const QUIETCAVEB3F_POKE_BALL
	const QUIETCAVEB3F_SCIENTIST

QuietCaveB3F_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

QuietCaveB3FScientistScript:
	checkevent EVENT_GOT_SILPHSCOPE2
	iftrue .GotSilphScope2
	showemote EMOTE_SHOCK, QUIETCAVEB3F_SCIENTIST, 15
	faceplayer
	opentext
	writetext QuietCaveB3FScientistIntroText
	waitbutton
	verbosegiveitem SILPHSCOPE2
	setevent EVENT_GOT_SILPHSCOPE2
	writetext QuietCaveB3FScientistSilphScopeText
	waitbutton
	closetext
	showemote EMOTE_SHOCK, QUIETCAVEB3F_SCIENTIST, 15
	waitsfx
	applymovement QUIETCAVEB3F_SCIENTIST, QuietCaveB3FScientistMovementData
	faceplayer
	opentext
	writetext QuietCaveB3FScientistChillText
	waitbutton
	writetext QuietCaveB3FScientistAaaahText
	cry GENGAR
	waitsfx
	closetext
	loadwildmon GENGAR, 35
	writecode VAR_BATTLETYPE, BATTLETYPE_FORCEITEM
	startbattle
	reloadmapafterbattle
	faceplayer
	opentext
	writetext QuietCaveB3FScientistAfterText
	waitbutton
	writetext QuietCaveB3FScientistText
	waitbutton
	closetext
	end

.GotSilphScope2
	jumptextfaceplayer QuietCaveB3FScientistText

QuietCaveB3FTMFocusBlast:
	tmhmball TM_FOCUS_BLAST

QuietCaveB3FHiddenPPUp:
	dwb EVENT_QUIET_CAVE_B3F_HIDDEN_PP_UP, PP_UP

QuietCaveB3FHiddenMaxRevive
	dwb EVENT_QUIET_CAVE_B3F_HIDDEN_MAX_REVIVE, MAX_REVIVE

QuietCaveB3FScientistMovementData:
	turn_head_up
	step_sleep_8
	turn_head_down
	step_sleep_8
	turn_head_left
	step_sleep_8
	turn_head_right
	step_sleep_8
	step_end

QuietCaveB3FScientistIntroText:
	text "Aaah! A Ghost?!"

	para "Oh, it's just a"
	line "#mon trainer…"

	para "You gave me quite"
	line "a scare!"

	para "I'm looking for"
	line "Ghost #mon in"
	cont "the shadows with"
	cont "this SilphScope2."

	para "It's a new device"
	line "made by Silph Co."
	cont "to detect hidden"
	cont "things."

	para "But I'm not having"
	line "much luck…"

	para "Maybe a trainer"
	line "like you can do"
	cont "better?"
	done

QuietCaveB3FScientistSilphScopeText:
	text "Put the Silph-"
	line "Scope2 on your"

	para "head and take a"
	line "look around."

	para "Some Ghosts like"
	line "to hide themselves"

	para "and frighten peo-"
	line "ple, or worse…"
	done

QuietCaveB3FScientistChillText:
	text "Wait! Did you feel"
	line "that sudden chill?"
	done

QuietCaveB3FScientistAaaahText:
	text "Aaaah!"
	done

QuietCaveB3FScientistAfterText:
	text "Thank you for"
	line "fighting that"
	cont "Gengar!"

	para "They're said to"
	line "attack people lost"

	para "in mountains and"
	line "curse them…"
	done

QuietCaveB3FScientistText:
	text "You can keep that"
	line "SilphScope2."

	para "Use it to stay"
	line "safe from Ghosts!"
	done

QuietCaveB3F_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 4
	warp_def $1f, $8, 5, QUIET_CAVE_B2F ; hole
	warp_def $7, $21, 6, QUIET_CAVE_B2F
	warp_def $9, $f, 4, QUIET_CAVE_B3F
	warp_def $b, $5, 3, QUIET_CAVE_B3F

.XYTriggers:
	db 0

.Signposts:
	db 2
	signpost 20, 16, SIGNPOST_ITEM, QuietCaveB3FHiddenPPUp
	signpost 22, 12, SIGNPOST_ITEM, QuietCaveB3FHiddenMaxRevive

.PersonEvents:
	db 2
	person_event SPRITE_BALL_CUT_FRUIT, 22, 7, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_TMHMBALL, 0, QuietCaveB3FTMFocusBlast, EVENT_QUIET_CAVE_B3F_TM_FOCUS_BLAST
	person_event SPRITE_SCIENTIST, 5, 5, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, QuietCaveB3FScientistScript, -1
