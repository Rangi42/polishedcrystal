const_value set 2
	const FIGHTINGDOJO_POKE_BALL
	const FIGHTINGDOJO_BLACK_BELT
	const REMATCH_RED_0
	const REMATCH_GREEN_1
	const REMATCH_BLUE_1
	const REMATCH_BLUE_2
	const REMATCH_BROWN_1
	const REMATCH_BROWN_2

FightingDojo_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 1

	; callbacks

	dbw MAPCALLBACK_OBJECTS, .SetupRematchesCallback

.SetupRematchesCallback:
	disappear REMATCH_RED_0
	disappear REMATCH_GREEN_1
	disappear REMATCH_BLUE_1
	disappear REMATCH_BLUE_2
	disappear REMATCH_BROWN_1
	disappear REMATCH_BROWN_2
	checkevent EVENT_BEAT_ELITE_FOUR_AGAIN
	iftrue .SetupDailyRematches
	return

rematch: MACRO
	; rematch person, varsprite, sprite, y, x, face
	moveperson \1, \5, \4
	appear \1
	spriteface \1, \6
	variablesprite \2, \3
ENDM

rematch_left: MACRO
	; rematch_left person, varsprite, sprite
	rematch \1, \2, \3, 6, 3, RIGHT
ENDM

rematch_right: MACRO
	; rematch_right person, varsprite, sprite
	rematch \1, \2, \3, 6, 6, LEFT
ENDM

.SetupDailyRematches:
	checkcode VAR_WEEKDAY
	if_equal MONDAY, .Monday
	if_equal TUESDAY, .Tuesday
	if_equal WEDNESDAY, .Wednesday
	if_equal THURSDAY, .Thursday
	if_equal FRIDAY, .Friday
	if_equal SATURDAY, .Saturday
.Sunday
	checknite
	iftrue .SundayNight
.SundayMorningAndDay
	rematch_left REMATCH_RED_0, SPRITE_AZALEA_ROCKET, SPRITE_JASMINE
	rematch_right REMATCH_GREEN_1, SPRITE_REMATCH_GYM_LEADER_1, SPRITE_ERIKA
	return
.SundayNight
	rematch REMATCH_RED_0, SPRITE_AZALEA_ROCKET, SPRITE_SABRINA, 4, 6, DOWN
	return
.Monday
	checknite
	iftrue .MondayNight
.MondayMorningAndDay
	rematch_left REMATCH_BLUE_1, SPRITE_REMATCH_GYM_LEADER_1, SPRITE_FALKNER
	rematch_right REMATCH_BLUE_2, SPRITE_REMATCH_GYM_LEADER_2, SPRITE_JANINE
.MondayNight
	return
.Tuesday
	checknite
	iftrue .TuesdayNight
.TuesdayMorningAndDay
	rematch_left REMATCH_BROWN_1, SPRITE_REMATCH_GYM_LEADER_1, SPRITE_PRYCE
	rematch_right REMATCH_BROWN_2, SPRITE_REMATCH_GYM_LEADER_2, SPRITE_BLAINE
.TuesdayNight
	return
.Wednesday
	checkmorn
	iftrue .WednesdayMorning
	checknite
	iftrue .WednesdayNight
.WednesdayDay
	rematch_left REMATCH_BROWN_1, SPRITE_REMATCH_GYM_LEADER_1, SPRITE_BROCK
	rematch REMATCH_RED_0, SPRITE_AZALEA_ROCKET, SPRITE_MISTY, 5, 2, RIGHT
	rematch_right REMATCH_BLUE_2, SPRITE_REMATCH_GYM_LEADER_2, SPRITE_BLUE
	return
.WednesdayMorning
	rematch_left REMATCH_BROWN_1, SPRITE_REMATCH_GYM_LEADER_1, SPRITE_BROCK
	rematch_right REMATCH_RED_0, SPRITE_AZALEA_ROCKET, SPRITE_MISTY
	return
.WednesdayNight
	rematch REMATCH_BLUE_2, SPRITE_REMATCH_GYM_LEADER_2, SPRITE_BLUE, 4, 8, DOWN
	return
.Thursday
	checkmorn
	iftrue .ThursdayMorning
	checknite
	iftrue .ThursdayNight
.ThursdayDay
	rematch_left REMATCH_GREEN_1, SPRITE_REMATCH_GYM_LEADER_1, SPRITE_BUGSY
	rematch_right REMATCH_BROWN_2, SPRITE_REMATCH_GYM_LEADER_2, SPRITE_MORTY
	return
.ThursdayMorning
	rematch REMATCH_GREEN_1, SPRITE_REMATCH_GYM_LEADER_1, SPRITE_BUGSY, 6, 1, DOWN
	return
.ThursdayNight
	rematch REMATCH_BROWN_2, SPRITE_REMATCH_GYM_LEADER_2, SPRITE_MORTY, 4, 2, DOWN
	return
.Friday
	checkmorn
	iftrue .FridayMorning
	checknite
	iftrue .FridayNight
.FridayDay
	return
.FridayMorning
	rematch REMATCH_BROWN_1, SPRITE_REMATCH_GYM_LEADER_1, SPRITE_SURGE, 7, 6, DOWN
	return
.FridayNight
	rematch REMATCH_BLUE_1, SPRITE_REMATCH_GYM_LEADER_1, SPRITE_CLAIR, 6, 2, RIGHT
	return
.Saturday
	checkday
	iffalse .SaturdayMorningAndNight
.SaturdayDay
	rematch_left REMATCH_RED_0, SPRITE_AZALEA_ROCKET, SPRITE_WHITNEY
	rematch_right REMATCH_BROWN_1, SPRITE_REMATCH_GYM_LEADER_1, SPRITE_CHUCK
.SaturdayMorningAndNight
	return

BlackBeltScript_0x189b61:
	jumptextfaceplayer UnknownText_0x189b6c

MapFightingDojoSignpost0Script:
	jumptext UnknownText_0x189bc0

MapFightingDojoSignpost1Script:
	jumptext UnknownText_0x189be0

FightingDojoFocusBand:
	itemball FOCUS_BAND

RematchRed0Script:
	checkcode VAR_WEEKDAY
	if_equal WEDNESDAY, .Red0Wednesday
	if_equal SATURDAY, .Red0Saturday
	checknite
	iftrue .Red0SundayNight
	jumptextfaceplayer JasmineText
.Red0SundayNight
	jumptextfaceplayer SabrinaText
.Red0Wednesday
	jumptextfaceplayer MistyText
.Red0Saturday
	jumptextfaceplayer WhitneyText

RematchGreen1Script:
	checkcode VAR_WEEKDAY
	if_equal THURSDAY, .Green1Thursday
	jumptextfaceplayer ErikaText
.Green1Thursday
	jumptextfaceplayer BugsyText

RematchBlue1Script:
	checkcode VAR_WEEKDAY
	if_equal FRIDAY, .Blue1Friday
	jumptextfaceplayer FalknerText
.Blue1Friday
	jumptextfaceplayer ClairText

RematchBlue2Script:
	checkcode VAR_WEEKDAY
	if_equal WEDNESDAY, .Blue2Wednesday
	jumptextfaceplayer JanineText
.Blue2Wednesday
	jumptextfaceplayer BlueText

RematchBrown1Script:
	checkcode VAR_WEEKDAY
	if_equal WEDNESDAY, .Brown1Wednesday
	if_equal FRIDAY, .Brown1Friday
	if_equal SATURDAY, .Brown1Saturday
	jumptextfaceplayer BlaineText
.Brown1Wednesday
	jumptextfaceplayer BrockText
.Brown1Friday
	jumptextfaceplayer SurgeText
.Brown1Saturday
	jumptextfaceplayer ChuckText

RematchBrown2Script:
	checkcode VAR_WEEKDAY
	if_equal THURSDAY, .Brown2Thursday
	jumptextfaceplayer PryceText
.Brown2Thursday
	jumptextfaceplayer MortyText

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

BrockText:
	text "Brock"
	done

MistyText:
	text "Misty"
	done

SurgeText:
	text "Surge"
	done

ErikaText:
	text "Erika"
	done

JanineText:
	text "Janine"
	done

SabrinaText:
	text "Sabrina"
	done

BlaineText:
	text "Blaine"
	done

BlueText:
	text "Blue"
	done

FalknerText:
	text "Falkner"
	done

BugsyText:
	text "Bugsy"
	done

WhitneyText:
	text "Whitney"
	done

MortyText:
	text "Morty"
	done

ChuckText:
	text "Chuck"
	done

JasmineText:
	text "Jasmine"
	done

PryceText:
	text "Pryce"
	done

ClairText:
	text "Clair"
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
	db 8
	person_event SPRITE_POKE_BALL, 1, 3, SPRITEMOVEDATA_ITEM_TREE, 0, 0, -1, -1, 0, PERSONTYPE_ITEMBALL, 0, FightingDojoFocusBand, EVENT_PICKED_UP_FOCUS_BAND
	person_event SPRITE_BLACK_BELT, 4, 4, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, BlackBeltScript_0x189b61, -1
	person_event SPRITE_AZALEA_ROCKET, 1, 0, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, RematchRed0Script, EVENT_REMATCH_GYM_LEADER_1
	person_event SPRITE_REMATCH_GYM_LEADER_1, 2, 0, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_SCRIPT, 0, RematchGreen1Script, EVENT_REMATCH_GYM_LEADER_2
	person_event SPRITE_REMATCH_GYM_LEADER_1, 3, 0, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, RematchBlue1Script, EVENT_REMATCH_GYM_LEADER_3
	person_event SPRITE_REMATCH_GYM_LEADER_2, 4, 0, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, RematchBlue2Script, EVENT_REMATCH_GYM_LEADER_4
	person_event SPRITE_REMATCH_GYM_LEADER_1, 5, 0, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_SCRIPT, 0, RematchBrown1Script, EVENT_REMATCH_GYM_LEADER_5
	person_event SPRITE_REMATCH_GYM_LEADER_2, 6, 0, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_SCRIPT, 0, RematchBrown2Script, EVENT_REMATCH_GYM_LEADER_6
