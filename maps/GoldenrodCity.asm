GoldenrodCity_MapScriptHeader:
	db 1 ; scene scripts
	scene_script GoldenrodCityTrigger0

	db 2 ; callbacks
	callback MAPCALLBACK_NEWMAP, GoldenrodCityFlyPointAndFloria
	callback MAPCALLBACK_OBJECTS, GoldenrodCityMoveTutorAndRocketScoutAndGymLass

	db 21 ; warp events
	warp_event 28,  7, GOLDENROD_GYM, 1
	warp_event 33, 29, GOLDENROD_BIKE_SHOP, 1
	warp_event 37, 15, GOLDENROD_HAPPINESS_RATER, 1
	warp_event  9, 25, GOLDENROD_BILLS_HOUSE, 1
	warp_event 13, 13, GOLDENROD_MAGNET_TRAIN_STATION, 2
	warp_event 33,  5, GOLDENROD_FLOWER_SHOP, 1
	warp_event 37,  9, GOLDENROD_PP_SPEECH_HOUSE, 1
	warp_event 19,  7, GOLDENROD_NAME_RATER, 1
	warp_event 28, 27, GOLDENROD_DEPT_STORE_1F, 1
	warp_event 18, 21, GOLDENROD_GAME_CORNER, 1
	warp_event  9, 15, RADIO_TOWER_1F, 1 ; hole
	warp_event 23,  1, ROUTE_35_GOLDENROD_GATE, 3
	warp_event 13,  5, UNDERGROUND_PATH_SWITCH_ROOM_ENTRANCES, 8
	warp_event 13, 29, UNDERGROUND_PATH_SWITCH_ROOM_ENTRANCES, 5
	warp_event 18, 27, GOLDENROD_POKECOM_CENTER_1F, 2
	warp_event  4, 16, GOLDENROD_HARBOR_GATE, 3
	warp_event  4, 17, GOLDENROD_HARBOR_GATE, 4
	warp_event 30, 15, GOLDENROD_MUSEUM_1F, 2
	warp_event 37, 19, GOLDENROD_NET_BALL_HOUSE, 1
	warp_event 33, 23, GOLDENROD_BAND_HOUSE, 1
	warp_event 13, 21, GOLDENROD_HP_UP_HOUSE, 1

	db 1 ; coord events
	coord_event  9, 15, 1, GoldenrodCityPanUpScript

	db 13 ; bg events
	bg_event 14, 14, SIGNPOST_JUMPTEXT, GoldenrodCityStationSignText
	bg_event  7, 15, SIGNPOST_JUMPTEXT, GoldenrodCityRadioTowerSignText
	bg_event 30, 27, SIGNPOST_JUMPTEXT, GoldenrodDeptStoreSignText
	bg_event 30,  9, SIGNPOST_JUMPTEXT, GoldenrodGymSignText
	bg_event 26, 18, SIGNPOST_JUMPTEXT, GoldenrodCitySignText
	bg_event 32, 30, SIGNPOST_JUMPTEXT, GoldenrodCityBikeShopSignText
	bg_event 20, 22, SIGNPOST_JUMPTEXT, GoldenrodCityGameCornerSignText
	bg_event 16,  7, SIGNPOST_JUMPTEXT, GoldenrodCityNameRaterSignText
	bg_event 12,  6, SIGNPOST_JUMPTEXT, GoldenrodCityUndergroundSignNorthText
	bg_event 14, 30, SIGNPOST_JUMPTEXT, GoldenrodCityUndergroundSignSouthText
	bg_event 20, 27, SIGNPOST_JUMPTEXT, PokeComCenterSignText
	bg_event 34,  6, SIGNPOST_JUMPTEXT, GoldenrodCityFlowerShopSignText
	bg_event 27, 15, SIGNPOST_JUMPTEXT, GoldenrodMuseumSignText

	db 15 ; object events
	object_event  8, 16, SPRITE_ROCKET, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, RocketScript_0x198a1a, EVENT_GOLDENROD_CITY_ROCKET_SCOUT
	object_event 16, 22, SPRITE_POKEFAN_M, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, PAL_NPC_RED, PERSONTYPE_SCRIPT, 0, MoveTutor, EVENT_GOLDENROD_CITY_MOVE_TUTOR
	object_event 28,  8, SPRITE_LASS, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, PERSONTYPE_SCRIPT, 0, GoldenrodCityGymLassScript, EVENT_GOLDENROD_CITY_CIVILIANS
	object_event 11, 18, SPRITE_POKEFAN_M, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x198a69, EVENT_GOLDENROD_CITY_CIVILIANS
	object_event 38, 17, SPRITE_YOUNGSTER, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 2, -1, -1, 0, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x198aa9, EVENT_GOLDENROD_CITY_CIVILIANS
	object_event 16, 16, SPRITE_COOLTRAINER_F, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_GREEN, PERSONTYPE_SCRIPT, 0, CooltrainerFScript_0x1989e9, EVENT_GOLDENROD_CITY_CIVILIANS
	object_event 25, 25, SPRITE_COOLTRAINER_F, SPRITEMOVEDATA_WANDER, 2, 1, -1, -1, 0, PERSONTYPE_SCRIPT, 0, CooltrainerFScript_0x1989fd, EVENT_GOLDENROD_CITY_CIVILIANS
	object_event 25, 17, SPRITE_YOUNGSTER, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, PAL_NPC_RED, PERSONTYPE_SCRIPT, 0, YoungsterScript_0x198a11, EVENT_GOLDENROD_CITY_CIVILIANS
	object_event 20, 10, SPRITE_LASS, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, -1, PAL_NPC_GREEN, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x198c83, EVENT_GOLDENROD_CITY_CIVILIANS
	object_event 15, 27, SPRITE_GRAMPS, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, -1, 0, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x198ccf, EVENT_GOLDENROD_CITY_CIVILIANS
	object_event 29, 16, SPRITE_ROCKET, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x198d4e, EVENT_GOLDENROD_CITY_ROCKET_TAKEOVER
	object_event 12, 15, SPRITE_ROCKET, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x198d6d, EVENT_GOLDENROD_CITY_ROCKET_TAKEOVER
	object_event 20, 23, SPRITE_ROCKET, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x198daa, EVENT_RADIO_TOWER_ROCKET_TAKEOVER
	object_event 33,  7, SPRITE_ROCKET, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x198e1f, EVENT_RADIO_TOWER_ROCKET_TAKEOVER
	object_event 35, 10, SPRITE_ROCKET, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x198e4b, EVENT_RADIO_TOWER_ROCKET_TAKEOVER

	const_def 1 ; object constants
	const GOLDENRODCITY_ROCKET1
	const GOLDENRODCITY_POKEFAN_M2
	const GOLDENRODCITY_LASS2

GoldenrodCityFlyPointAndFloria:
	setflag ENGINE_FLYPOINT_GOLDENROD
	checkevent EVENT_MET_FLORIA
	iftrue .Done
	clearevent EVENT_FLORIA_AT_SUDOWOODO
.Done:
	return

GoldenrodCityMoveTutorAndRocketScoutAndGymLass:
; Move Tutor
	checkevent EVENT_BEAT_WHITNEY
	iffalse .MoveTutorDisappear
	checkitem COIN_CASE
	iffalse .MoveTutorDisappear
	appear GOLDENRODCITY_POKEFAN_M2
	jump .MoveTutorDone
.MoveTutorDisappear
	disappear GOLDENRODCITY_POKEFAN_M2
.MoveTutorDone
; Rocket scout
	checkevent EVENT_RADIO_TOWER_ROCKET_TAKEOVER
	iftrue .RocketScoutDone
	moveobject GOLDENRODCITY_ROCKET1, 29, 17
.RocketScoutDone
; Gym Lass
	checkevent EVENT_GOLDENROD_GYM_WHITNEY
	iffalse .GymLassDone
	moveobject GOLDENRODCITY_LASS2, 38, 24
.GymLassDone
	return

GoldenrodCityTrigger0:
	priorityjump GoldenrodCityStepDownScript
	end

GoldenrodCityStepDownScript:
	checkcode VAR_YCOORD
	ifnotequal $f, .Done
	checkcode VAR_XCOORD
	ifnotequal $9, .Done
	applyonemovement PLAYER, step_down
.Done
	setscene $1
	end

GoldenrodCityPanUpScript:
	playsound SFX_EXIT_BUILDING
	applyonemovement PLAYER, hide_person
	waitsfx
	applymovement PLAYER, GoldenrodCityPanUpMovementData
	disappear PLAYER
	pause 10
	special Special_FadeOutMusic
	special FadeOutPalettes
	pause 15
	setscene $0
	warpfacing UP, RADIO_TOWER_1F, 2, 7
	end

MoveTutor:
	faceplayer
	opentext
	writetext UnknownText_0x199042
	yesorno
	iffalse_jumpopenedtext UnknownText_0x1990b4
	special Special_DisplayCoinCaseBalance
	writetext UnknownText_0x199090
	yesorno
	iffalse_jumpopenedtext UnknownText_0x199107
	checkcoins 200
	ifequal $2, .NotEnoughMoney
	writetext UnknownText_0x1990ce
	loadmenu .MoveMenuDataHeader
	verticalmenu
	closewindow
	ifequal $1, .FirePunch
	ifequal $2, .ThunderPunch
	ifequal $3, .IcePunch
	jumpopenedtext UnknownText_0x1991a4

.FirePunch:
	writebyte FIRE_PUNCH
	writetext UnknownText_0x1991cf
	special Special_MoveTutor
	ifequal $0, .TeachMove
	jumpopenedtext UnknownText_0x1991a4

.ThunderPunch:
	writebyte THUNDERPUNCH
	writetext UnknownText_0x1991cf
	special Special_MoveTutor
	ifequal $0, .TeachMove
	jumpopenedtext UnknownText_0x1991a4

.IcePunch:
	writebyte ICE_PUNCH
	writetext UnknownText_0x1991cf
	special Special_MoveTutor
	ifequal $0, .TeachMove
	jumpopenedtext UnknownText_0x1991a4

.MoveMenuDataHeader:
	db $40 ; flags
	db 02, 00 ; start coords
	db 11, 15 ; end coords
	dw .MenuData2
	db 1 ; default option

.MenuData2:
	db $80 ; flags
	db 4 ; items
	db "Fire Punch@"
	db "ThunderPunch@"
	db "Ice Punch@"
	db "Cancel@"

.TeachMove:
	writetext UnknownText_0x19913a
	buttonsound
	takecoins 200
	waitsfx
	playsound SFX_TRANSACTION
	special Special_DisplayCoinCaseBalance
	jumpopenedtext UnknownText_0x19918b

.NotEnoughMoney:
	jumpopenedtext UnknownText_0x1991ac

CooltrainerFScript_0x1989e9:
	checkevent EVENT_CLEARED_RADIO_TOWER
	iftrue_jumptextfaceplayer UnknownText_0x198b2d
	jumptextfaceplayer UnknownText_0x198ae6

CooltrainerFScript_0x1989fd:
	checkflag ENGINE_RADIO_CARD
	iffalse_jumptextfaceplayer UnknownText_0x198b73
	checkevent EVENT_RESTORED_POWER_TO_KANTO
	iffalse_jumptextfaceplayer GoldenrodCityCooltrainerFOlivineText
	jumptextfaceplayer UnknownText_0x198c14

YoungsterScript_0x198a11:
	faceplayer
	opentext
	checktime 1 << NITE
	iftrue .nite
	jumpopenedtext GoldenrodCityYoungsterDayText

.nite
	jumpopenedtext UnknownText_0x198c36

RocketScript_0x198a1a:
	checkevent EVENT_RADIO_TOWER_ROCKET_TAKEOVER
	iftrue .RocketScout
	jumptextfaceplayer UnknownText_0x198de2

.RocketScout:
	opentext
	writetext UnknownText_0x198d0d
	buttonsound
	faceplayer
	writetext UnknownText_0x198d2a
	waitbutton
	closetext
	turnobject LAST_TALKED, UP
	end

GoldenrodCityGymLassScript:
	checkevent EVENT_GOLDENROD_GYM_WHITNEY
	iffalse .GymLass
	jumptextfaceplayer GoldenrodCityLass2Text

.GymLass
	jumptextfaceplayer GoldenrodCityGymLassText

GoldenrodCityPanUpMovementData:
	step_up
	step_up
	step_up
	step_up
	step_up
	step_up
	step_up
	step_end

UnknownText_0x198a69:
	text "They built the new"
	line "Radio Tower to"

	para "replace the old,"
	line "creaky one."

	para "Now it transmits"
	line "every #gear"

	para "broadcast in"
	line "Johto."
	done

UnknownText_0x198aa9:
	text "I know there's a"
	line "new bike shop, but"

	para "I can't find it"
	line "anywhere."
	done

UnknownText_0x198ae6:
	text "Is that man in"
	line "black dressed up"

	para "like a Team Rocket"
	line "member? How silly!"
	done

UnknownText_0x198b2d:
	text "Was that man in"
	line "black really part"

	para "of Team Rocket? I"
	line "can't believe it!"
	done

UnknownText_0x198b73:
	text "The Radio Tower in"
	line "Goldenrod City is"
	cont "a landmark."

	para "They're running a"
	line "promotional cam-"
	cont "paign right now."

	para "They'll modify"
	line "your #gear,"

	para "so it can also"
	line "serve as a radio."
	done

GoldenrodCityCooltrainerFOlivineText:
	text "I came here on"
	line "the S.S.Aqua."

	para "It's slower than"
	line "the Magnet Train,"
	cont "but more scenic."
	done

UnknownText_0x198c14:
	text "I came here on the"
	line "Magnet Train."

	para "Time to do some"
	line "shopping!"
	done

GoldenrodCityYoungsterDayText:
	text "Have you been to"
	line "the Museum?"

	para "It's full of cool"
	line "exhibits!"
	done

UnknownText_0x198c36:
	text "E-he-he-he…"

	para "I got in trouble"
	line "for playing in the"

	para "basement of the"
	line "Dept.Store."
	done

UnknownText_0x198c83:
	text "The man at that"
	line "house rates your"
	cont "#mon names."

	para "He can help rename"
	line "your #mon too."

	para "He liked all of"
	line "my nicknames, even"
	cont "the silly ones!"
	done

UnknownText_0x198ccf:
	text "Whew! This is one"
	line "big town. I don't"

	para "know where any-"
	line "thing is."
	done

UnknownText_0x198d0d:
	text "So this is the"
	line "Radio Tower…"
	done

UnknownText_0x198d2a:
	text "What do you want,"
	line "you pest? Scram!"
	done

UnknownText_0x198d4e:
	text "Stay out of the"
	line "way! Beat it!"
	done

UnknownText_0x198d6d:
	text "Take over the"
	line "Radio Tower…"

	para "What? It's none of"
	line "your business!"
	done

UnknownText_0x198daa:
	text "#mon? They're"
	line "nothing more than"

	para "tools for making"
	line "money!"
	done

UnknownText_0x198de2:
	text "Our dream will"
	line "soon come true…"

	para "It was such a long"
	line "struggle…"
	done

UnknownText_0x198e1f:
	text "Hey, brat! You"
	line "don't belong here!"
	cont "Get lost!"
	done

UnknownText_0x198e4b:
	text "Come taste the"
	line "true terror of"
	cont "Team Rocket!"
	done

GoldenrodCityGymLassText:
	text "The Gym Leader,"
	line "Whitney, went"
	cont "flying by saying,"

	para "“I have got to get"
	line "a Radio Card!”"
	done

GoldenrodCityLass2Text:
	text "I went on a tour"
	line "of the Radio"

	para "Tower. I saw all"
	line "three studios and"

	para "even ate in the"
	line "café."
	done

GoldenrodCityStationSignText:
	text "Goldenrod City"
	line "Station"
	done

GoldenrodCityRadioTowerSignText:
	text "Goldenrod City"
	line "Radio Tower"
	done

GoldenrodDeptStoreSignText:
	text "Full Selection of"
	line "#mon Goods!"

	para "Goldenrod City"
	line "Dept.Store"
	done

GoldenrodGymSignText:
	text "Goldenrod City"
	line "#mon Gym"
	cont "Leader: Whitney"

	para "The Incredibly"
	line "Pretty Girl!"
	done

GoldenrodCitySignText:
	text "Goldenrod City"

	para "The Festive City"
	line "of Opulent Charm"
	done

GoldenrodCityBikeShopSignText:
	text "The World is a"
	line "Cycle Path!"

	para "Miracle Cycle"
	done

GoldenrodCityGameCornerSignText:
	text "Your Playground!"

	para "Goldenrod City"
	line "Game Corner"
	done

GoldenrodCityNameRaterSignText:
	text "Name Rater"

	para "Get Your #mon"
	line "Nicknames Rated"
	done

GoldenrodCityUndergroundSignNorthText:
	text "Underground"
	line "Entrance"
	done

GoldenrodCityUndergroundSignSouthText:
	text "Underground"
	line "Entrance"
	done

PokeComCenterSignText:
	text "Connect the World!"
	line "#Com Center"
	done

GoldenrodCityFlowerShopSignText:
	text "Blooming Beautiful"
	line "Flower Shop"
	done

GoldenrodMuseumSignText:
	text "Goldenrod Museum"
	done

UnknownText_0x199042:
	text "I can teach your"
	line "#mon amazing"

	para "moves if you'd"
	line "like."

	para "Should I teach a"
	line "new move?"
	done

UnknownText_0x199090:
	text "It will cost you"
	line "200 coins. OK?"
	done

UnknownText_0x1990b4:
	text "Aww… But they're"
	line "amazing…"
	done

UnknownText_0x1990ce:
	text "Wahahah! You won't"
	line "regret it!"

	para "Which move should"
	line "I teach?"
	done

UnknownText_0x199107:
	text "Hm, too bad. I'll"
	line "have to get some"
	cont "cash from home…"
	done

UnknownText_0x19913a:
	text "If you understand"
	line "what's so amazing"

	para "about this move,"
	line "you've made it as"
	cont "a trainer."
	done

UnknownText_0x19918b:
	text "Wahahah!"
	line "Good day, kid!"
	done

UnknownText_0x1991a4:
	text "B-but…"
	done

UnknownText_0x1991ac:
	text "…You don't have"
	line "enough coins here…"
	done

UnknownText_0x1991cf:
	text ""
	done
