Route48_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

Route48_MapEventHeader:

.Warps: db 1
	warp_def $5, $b, 3, YELLOW_FOREST_GATE

.XYTriggers: db 1
	xy_trigger 0, $c, $14, Route48JessieJamesScript

.Signposts: db 1
	signpost 11, 27, SIGNPOST_READ, Route48YellowForestSign

.PersonEvents: db 4
	person_event SPRITE_ARCHER, 6, 11, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_TRAINER, 1, TrainerArcher2, EVENT_CLEARED_YELLOW_FOREST
	person_event SPRITE_JESSIE, 12, 15, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, ObjectEvent, EVENT_ROUTE_48_JESSIE
	person_event SPRITE_JAMES, 12, 26, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, ObjectEvent, EVENT_ROUTE_48_JAMES
	person_event SPRITE_BALL_CUT_FRUIT, 13, 4, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_ITEMBALL, 0, Route48Nugget, EVENT_ROUTE_48_NUGGET

const_value set 2
	const ROUTE48_ARCHER
	const ROUTE48_JESSIE
	const ROUTE48_JAMES

Route48JessieJamesScript:
	checkevent EVENT_BEAT_JESSIE_AND_JAMES
	iftrue .End
	disappear ROUTE48_JESSIE
	disappear ROUTE48_JAMES
	appear ROUTE48_JESSIE
	appear ROUTE48_JAMES
	showemote EMOTE_SHOCK, PLAYER, 15
	special Special_FadeOutMusic
	pause 15
	playmusic MUSIC_JESSIE_JAMES_ENCOUNTER
	applymovement ROUTE48_JESSIE, JessieEnterMovementData
	applymovement ROUTE48_JAMES, JamesEnterMovementData
	opentext
	writetext Route48JessieJamesSeenText
	waitbutton
	closetext
	winlosstext Route48JessieJamesBeatenText, 0
	setlasttalked ROUTE48_JESSIE
	loadtrainer JESSIE_JAMES, 1
	startbattle
	dontrestartmapmusic
	reloadmap
	special DeleteSavedMusic
	playmusic MUSIC_JESSIE_JAMES_ENCOUNTER
	opentext
	writetext Route48JessieJamesAfterText
	waitbutton
	closetext
	applymovement ROUTE48_JESSIE, JessieLeaveMovementData
	applymovement ROUTE48_JAMES, JamesLeaveMovementData
	disappear ROUTE48_JESSIE
	disappear ROUTE48_JAMES
	dotrigger $0
	setevent EVENT_BEAT_JESSIE_AND_JAMES
	playmapmusic
.End
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
	trainer EVENT_BEAT_ARCHER_2, ARCHER, ARCHER2, Archer2SeenText, Archer2BeatenText, 0, Archer2Script

Archer2Script:
	opentext
	writetext Archer2AfterText
	waitbutton
	closetext
	special Special_FadeBlackQuickly
	special Special_ReloadSpritesNoPalettes
	disappear ROUTE48_ARCHER
	pause 15
	special Special_FadeInQuickly
	setevent EVENT_CLEARED_YELLOW_FOREST
	clearevent EVENT_YELLOW_FOREST_ROCKET_TAKEOVER
	end

Route48YellowForestSign:
	jumptext Route48YellowForestSignText

Route48Nugget:
	itemball NUGGET

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
