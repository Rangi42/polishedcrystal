const_value set 2
	const FIGHTINGDOJO_BLACK_BELT
	const FIGHTINGDOJO_POKE_BALL
	const REMATCH_BROWN_LEFT
	const REMATCH_BROWN_RIGHT
	const REMATCH_BLUE_LEFT
	const REMATCH_BLUE_RIGHT
	const REMATCH_RED_RIGHT
	const REMATCH_ERIKA
	const REMATCH_JASMINE
	const REMATCH_MISTY
	const REMATCH_BUGSY

FightingDojo_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 1

	; callbacks

	dbw MAPCALLBACK_OBJECTS, CheckRematchesAvailable

CheckRematchesAvailable:
	disappear REMATCH_BROWN_LEFT
	disappear REMATCH_BROWN_RIGHT
	disappear REMATCH_BLUE_LEFT
	disappear REMATCH_BLUE_RIGHT
	disappear REMATCH_RED_RIGHT
	disappear REMATCH_ERIKA
	disappear REMATCH_JASMINE
	disappear REMATCH_MISTY
	disappear REMATCH_BUGSY
	checkflag EVENT_BEAT_ELITE_FOUR_AGAIN
	iftrue .CheckWhichRematchesAvailable
	return

.CheckWhichRematchesAvailable:
	disappear FIGHTINGDOJO_BLACK_BELT
	checkcode VAR_WEEKDAY
	if_equal MONDAY, .Monday
	if_equal TUESDAY, .Tuesday
	if_equal WEDNESDAY, .Wednesday
	if_equal THURSDAY, .Thursday
	if_equal FRIDAY, .Friday
	if_equal SATURDAY, .Saturday
.Sunday
	appear REMATCH_ERIKA ; green, left
	variablesprite SPRITE_REMATCH_GYM_LEADER_2, SPRITE_SABRINA; right, red
	appear REMATCH_RED_RIGHT ; Sabrina
	return

.Monday
	variablesprite SPRITE_AZALEA_ROCKET, SPRITE_FALKNER ; blue, left
	variablesprite SPRITE_REMATCH_GYM_LEADER_2, SPRITE_JANINE ; blue, right
	appear REMATCH_BLUE_LEFT ; Falkner
	appear REMATCH_BLUE_RIGHT ; Janine
	return

.Tuesday
	variablesprite SPRITE_AZALEA_ROCKET, SPRITE_BLAINE ; brown, left
	variablesprite SPRITE_REMATCH_GYM_LEADER_2, SPRITE_PRYCE ; brown, right
	appear REMATCH_BROWN_LEFT ; Blaine
	appear REMATCH_BROWN_RIGHT ; Pryce
	return

.Wednesday
	appear REMATCH_JASMINE ; red, left
	variablesprite SPRITE_REMATCH_GYM_LEADER_2, SPRITE_CHUCK ; brown, right
	appear REMATCH_BROWN_RIGHT ; Chuck
	return

.Thursday
	variablesprite SPRITE_AZALEA_ROCKET, SPRITE_BROCK ; brown, left
	variablesprite SPRITE_REMATCH_GYM_LEADER_2, SPRITE_BLUE ; blue, right
	appear REMATCH_BROWN_LEFT ; Brock
	appear REMATCH_BLUE_RIGHT ; Blue
	appear REMATCH_MISTY ; shifted left
	return

.Friday
	variablesprite SPRITE_AZALEA_ROCKET, SPRITE_SURGE ; brown, left
	variablesprite SPRITE_REMATCH_GYM_LEADER_2, SPRITE_CLAIR ; blue, right
	appear REMATCH_BROWN_LEFT ; Surge
	appear REMATCH_BLUE_RIGHT ; Clair
	return

.Saturday
	variablesprite SPRITE_AZALEA_ROCKET, SPRITE_MORTY ; brown, left
	variablesprite SPRITE_REMATCH_GYM_LEADER_2, SPRITE_WHITNEY ; red, right
	appear REMATCH_BROWN_LEFT ; Morty
	appear REMATCH_RED_RIGHT ; Whitney
	appear REMATCH_BUGSY ; shifted right
	return

BlackBeltScript_0x189b61:
	jumptextfaceplayer UnknownText_0x189b6c

MapFightingDojoSignpost0Script:
	jumptext UnknownText_0x189bc0

MapFightingDojoSignpost1Script:
	jumptext UnknownText_0x189be0

FightingDojoFocusBand:
	itemball FOCUS_BAND

RematchBrownLeftScript:
RematchBrownRightScript:
RematchBlueLeftScript:
RematchBlueRightScript:
RematchRedRightScript:
RematchErikaScript:
RematchJasmineScript:
RematchMistyScript:
RematchBugsyScript:
	jumptextfaceplayer ToDoText

UnknownText_0x189b6c:
	text "Hello!"

	para "Karate King, the"
	line "Fighting Dojo's"

	para "master, is in a"
	line "cave in Johto for"
	cont "training."
	done

UnknownText_0x189bc0:
	text "What goes around"
	line "comes around!"
	done

UnknownText_0x189be0:
	text "Enemies on every"
	line "side!"
	done

ToDoText:
	text "To Do: Add Gym"
	line "Leader rematches!"
	done

FightingDojo_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 2
	warp_def $b, $4, 1, SAFFRON_CITY
	warp_def $b, $5, 1, SAFFRON_CITY

.XYTriggers:
	db 0

.Signposts:
	db 2
	signpost 0, 4, SIGNPOST_READ, MapFightingDojoSignpost0Script
	signpost 0, 5, SIGNPOST_READ, MapFightingDojoSignpost1Script

.PersonEvents:
	db 11
	person_event SPRITE_BLACK_BELT, 4, 4, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, BlackBeltScript_0x189b61, -1
	person_event SPRITE_POKE_BALL, 1, 3, SPRITEMOVEDATA_ITEM_TREE, 0, 0, -1, -1, 0, PERSONTYPE_ITEMBALL, 0, FightingDojoFocusBand, EVENT_PICKED_UP_FOCUS_BAND
	person_event SPRITE_AZALEA_ROCKET, 6, 2, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_SCRIPT, 0, RematchBrownLeftScript, EVENT_BEAT_ELITE_FOUR_AGAIN
	person_event SPRITE_REMATCH_GYM_LEADER_2, 6, 7, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_SCRIPT, 0, RematchBrownRightScript, EVENT_BEAT_ELITE_FOUR_AGAIN
	person_event SPRITE_AZALEA_ROCKET, 6, 2, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, RematchBlueLeftScript, EVENT_BEAT_ELITE_FOUR_AGAIN
	person_event SPRITE_REMATCH_GYM_LEADER_2, 6, 7, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, RematchBlueRightScript, EVENT_BEAT_ELITE_FOUR_AGAIN
	person_event SPRITE_REMATCH_GYM_LEADER_2, 6, 7, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, RematchRedRightScript, EVENT_BEAT_ELITE_FOUR_AGAIN
	person_event SPRITE_ERIKA, 6, 2, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_SCRIPT, 0, RematchErikaScript, EVENT_BEAT_ELITE_FOUR_AGAIN
	person_event SPRITE_JASMINE, 6, 2, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, RematchJasmineScript, EVENT_BEAT_ELITE_FOUR_AGAIN
	person_event SPRITE_MISTY, 7, 3, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, RematchMistyScript, EVENT_BEAT_ELITE_FOUR_AGAIN
	person_event SPRITE_BUGSY, 7, 6, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_SCRIPT, 0, RematchBugsyScript, EVENT_BEAT_ELITE_FOUR_AGAIN
