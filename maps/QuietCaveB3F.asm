QuietCaveB3F_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 4 ; warp events
	warp_event  8, 31, QUIET_CAVE_B2F, 5 ; hole
	warp_event 33,  7, QUIET_CAVE_B2F, 6
	warp_event 15,  9, QUIET_CAVE_B3F, 4
	warp_event  5, 11, QUIET_CAVE_B3F, 3

	db 0 ; coord events

	db 2 ; bg events
	bg_event 16, 20, SIGNPOST_ITEM + PP_UP, EVENT_QUIET_CAVE_B3F_HIDDEN_PP_UP
	bg_event 12, 22, SIGNPOST_ITEM + MAX_REVIVE, EVENT_QUIET_CAVE_B3F_HIDDEN_MAX_REVIVE

	db 2 ; object events
	object_event  5,  5, SPRITE_MARLEY, SPRITEMOVEDATA_WANDER, 1, 2, -1, -1, 0, PERSONTYPE_SCRIPT, 0, QuietCaveB3FMarleyScript, EVENT_QUIET_CAVE_MARLEY
	tmhmball_event  7, 22, TM_FOCUS_BLAST, EVENT_QUIET_CAVE_B3F_TM_FOCUS_BLAST

	const_def 1 ; object constants
	const QUIETCAVEB3F_MARLEY

QuietCaveB3FMarleyScript:
	faceplayer
	checkevent EVENT_BEAT_MARLEY
	iftrue .Beaten
	opentext
	writetext .ChallengeText
	yesorno
	iffalse_jumpopenedtext .NoText
	writetext .YesText
	waitbutton
	closetext
	winlosstext .BeatenText, 0
	setlasttalked QUIETCAVEB3F_MARLEY
	loadtrainer MARLEY, 1
	startbattle
	reloadmapafterbattle
	setevent EVENT_BEAT_MARLEY
.Beaten
	opentext
	writetext .ItemText
	buttonsound
	verbosegiveitem POWER_ANKLET
	iffalse_endtext
	writetext .GoodbyeText
	waitbutton
	closetext
	special Special_FadeBlackQuickly
	special Special_ReloadSpritesNoPalettes
	disappear QUIETCAVEB3F_MARLEY
	pause 15
	special Special_FadeInQuickly
	clearevent EVENT_BATTLE_TOWER_MARLEY
	end

.ChallengeText:
	text "…I'm Marley."
	line "…You are?"

	para "Oh… <PLAYER>,"
	line "will you battle"
	cont "me, please?"
	done

.YesText:
	text "…OK. I'll do my"
	line "best."
	done

.NoText:
	text "…Too bad…"
	done

.BeatenText:
	text "…Awww."
	done

.ItemText:
	text "I… I don't like to"
	line "talk…"

	para "I choose my words"
	line "carefully, but"

	para "they may still"
	line "hurt someone acci-"
	cont "dentally…"

	para "So, I'll have to"
	line "convey thanks an-"
	cont "other way…"
	done

.GoodbyeText:
	text "…I appreciate your"
	line "battling with me…"
	cont "…Just a little…"

	para "I'm going to"
	line "Battle Tower…"

	para "Bye-bye…"
	done
