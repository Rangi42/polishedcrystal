Route48_MapScriptHeader:
	db 0 ; scene scripts

	db 1 ; callbacks
	callback MAPCALLBACK_NEWMAP, Route48JessieJamesCallback

	db 1 ; warp events
	warp_event 11,  5, YELLOW_FOREST_GATE, 3

	db 2 ; coord events
	coord_event 20, 12, 0, Route48JessieJamesScript1
	coord_event 20, 13, 0, Route48JessieJamesScript2

	db 1 ; bg events
	bg_event 27, 11, SIGNPOST_JUMPTEXT, Route48YellowForestSignText

	db 4 ; object events
	object_event 11,  6, SPRITE_ARCHER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BLUE, PERSONTYPE_TRAINER, 1, TrainerArcher2, EVENT_CLEARED_YELLOW_FOREST
	object_event 15, 12, SPRITE_JESSIE, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_RED, PERSONTYPE_SCRIPT, 0, ObjectEvent, EVENT_ROUTE_48_JESSIE
	object_event 26, 12, SPRITE_JAMES, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_BLUE, PERSONTYPE_SCRIPT, 0, ObjectEvent, EVENT_ROUTE_48_JAMES
	itemball_event  4, 13, NUGGET, 1, EVENT_ROUTE_48_NUGGET

	const_def 1 ; object constants
	const ROUTE48_ARCHER
	const ROUTE48_JESSIE
	const ROUTE48_JAMES

Route48JessieJamesCallback:
	disappear ROUTE48_JESSIE
	disappear ROUTE48_JAMES
	return

Route48JessieJamesScript2:
	moveobject ROUTE48_JESSIE, 15, 13
	moveobject ROUTE48_JAMES, 26, 13
Route48JessieJamesScript1:
	appear ROUTE48_JESSIE
	appear ROUTE48_JAMES
	showemote EMOTE_SHOCK, PLAYER, 15
	special Special_FadeOutMusic
	pause 15
	playmusic MUSIC_JESSIE_JAMES_ENCOUNTER
	applymovement ROUTE48_JESSIE, JessieEnterMovementData
	applymovement ROUTE48_JAMES, JamesEnterMovementData
	showtext Route48JessieJamesSeenText
	setscene $1
	setevent EVENT_BEAT_JESSIE_AND_JAMES
	winlosstext Route48JessieJamesBeatenText, 0
	setlasttalked ROUTE48_JESSIE
	loadtrainer JESSIE_JAMES, 1
	startbattle
	dontrestartmapmusic
	reloadmapafterbattle
	special DeleteSavedMusic
	playmusic MUSIC_JESSIE_JAMES_ENCOUNTER
	showtext Route48JessieJamesAfterText
	applymovement ROUTE48_JESSIE, JessieLeaveMovementData
	applymovement ROUTE48_JAMES, JamesLeaveMovementData
	disappear ROUTE48_JESSIE
	disappear ROUTE48_JAMES
	playmapmusic
Route48JessieJamesScript_End:
	end

JessieEnterMovementData:
	step_right
	step_right
	step_right
	step_right
	step_end

JamesEnterMovementData:
	step_left
	step_left
	step_left
	step_left
	step_left
	step_end

JessieLeaveMovementData:
	big_step_left
	big_step_left
	big_step_left
	big_step_left
	step_end

JamesLeaveMovementData:
	big_step_right
	big_step_right
	big_step_right
	big_step_right
	big_step_right
	step_end

TrainerArcher2:
	trainer ARCHER, ARCHER2, EVENT_BEAT_ARCHER_2, Archer2SeenText, Archer2BeatenText, 0, Archer2Script

Archer2Script:
	showtext Archer2AfterText
	special Special_FadeBlackQuickly
	special Special_ReloadSpritesNoPalettes
	disappear ROUTE48_ARCHER
	pause 15
	special Special_FadeInQuickly
	setevent EVENT_CLEARED_YELLOW_FOREST
	clearevent EVENT_YELLOW_FOREST_ROCKET_TAKEOVER
	end

Route48JessieJamesSeenText:
	text "Stop right there,"
	line "twerp!"

	para "You know what"
	line "#mon lives in"
	cont "that forest?"
	cont "Pikachu!"

	para "The boss will be"
	line "pleased if we"

	para "capture a power-"
	line "ful one!"

	para "Surrender now, or"
	line "prepare to fight!"
	done

Route48JessieJamesBeatenText:
	text "A brat beat us?"
	done

Route48JessieJamesAfterText:
	text "Looks like Team"
	line "Rocket's blasting"
	cont "off again!"
	done

Archer2SeenText:
	text "So you want to"
	line "interfere with"

	para "Team Rocket's"
	line "plans again."

	para "Always sticking"
	line "your nose where it"
	cont "doesn't belong."

	para "We're selling"
	line "those #mon,"

	para "and there's nothing"
	line "you can do about"
	cont "it!"
	done

Archer2BeatenText:
	text "This is so"
	line "frustrating…"
	done

Archer2AfterText:
	text "…Have it your"
	line "way."

	para "Team Rocket will"
	line "withdraw for now."

	para "Our other plan is"
	line "going smoothly"
	cont "anyway…"
	done

Route48YellowForestSignText:
	text "Route 48"

	para "North to"
	line "Yellow Forest"
	done
