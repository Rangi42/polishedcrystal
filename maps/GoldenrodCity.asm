GoldenrodCity_MapScriptHeader:

.MapTriggers: db 1
	dw GoldenrodCityTrigger0

.MapCallbacks: db 2
	dbw MAPCALLBACK_NEWMAP, GoldenrodCityFlyPointAndFloria
	dbw MAPCALLBACK_OBJECTS, GoldenrodCityMoveTutorAndRocketScoutAndGymLass

GoldenrodCity_MapEventHeader:

.Warps: db 21
	warp_def 7, 28, 1, GOLDENROD_GYM
	warp_def 29, 33, 1, GOLDENROD_BIKE_SHOP
	warp_def 15, 37, 1, GOLDENROD_HAPPINESS_RATER
	warp_def 25, 9, 1, GOLDENROD_BILLS_HOUSE
	warp_def 13, 13, 2, GOLDENROD_MAGNET_TRAIN_STATION
	warp_def 5, 33, 1, GOLDENROD_FLOWER_SHOP
	warp_def 9, 37, 1, GOLDENROD_PP_SPEECH_HOUSE
	warp_def 7, 19, 1, GOLDENROD_NAME_RATER
	warp_def 27, 28, 1, GOLDENROD_DEPT_STORE_1F
	warp_def 21, 18, 1, GOLDENROD_GAME_CORNER
	warp_def 15, 9, 1, RADIO_TOWER_1F ; hole
	warp_def 1, 23, 3, ROUTE_35_GOLDENROD_GATE
	warp_def 5, 13, 8, UNDERGROUND_PATH_SWITCH_ROOM_ENTRANCES
	warp_def 29, 13, 5, UNDERGROUND_PATH_SWITCH_ROOM_ENTRANCES
	warp_def 27, 18, 2, GOLDENROD_POKECOM_CENTER_1F
	warp_def 16, 4, 3, GOLDENROD_HARBOR_GATE
	warp_def 17, 4, 4, GOLDENROD_HARBOR_GATE
	warp_def 15, 30, 1, GOLDENROD_SPEECH_HOUSE ; TODO: museum
	warp_def 19, 37, 1, GOLDENROD_NET_BALL_HOUSE
	warp_def 23, 33, 1, GOLDENROD_BAND_HOUSE
	warp_def 21, 13, 1, GOLDENROD_HP_UP_HOUSE

.XYTriggers: db 1
	xy_trigger 1, 15, 9, GoldenrodCityPanUpScript

.Signposts: db 13
	signpost 14, 14, SIGNPOST_JUMPTEXT, GoldenrodCityStationSignText
	signpost 15, 7, SIGNPOST_JUMPTEXT, GoldenrodCityRadioTowerSignText
	signpost 27, 30, SIGNPOST_JUMPTEXT, GoldenrodDeptStoreSignText
	signpost 9, 30, SIGNPOST_JUMPTEXT, GoldenrodGymSignText
	signpost 18, 26, SIGNPOST_JUMPTEXT, GoldenrodCitySignText
	signpost 30, 32, SIGNPOST_JUMPTEXT, GoldenrodCityBikeShopSignText
	signpost 22, 20, SIGNPOST_JUMPTEXT, GoldenrodCityGameCornerSignText
	signpost 7, 16, SIGNPOST_JUMPTEXT, GoldenrodCityNameRaterSignText
	signpost 6, 12, SIGNPOST_JUMPTEXT, GoldenrodCityUndergroundSignNorthText
	signpost 30, 14, SIGNPOST_JUMPTEXT, GoldenrodCityUndergroundSignSouthText
	signpost 27, 20, SIGNPOST_UP, GoldenrodCityPokeCenterSign
	signpost 6, 34, SIGNPOST_JUMPTEXT, GoldenrodCityFlowerShopSignText
	signpost 15, 27, SIGNPOST_JUMPTEXT, GoldenrodMuseumSignText

.PersonEvents: db 15
	person_event SPRITE_ROCKET, 16, 8, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, RocketScript_0x198a1a, EVENT_GOLDENROD_CITY_ROCKET_SCOUT
	person_event SPRITE_POKEFAN_M, 22, 16, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, MoveTutor, EVENT_GOLDENROD_CITY_MOVE_TUTOR
	person_event SPRITE_LASS, 8, 28, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, GoldenrodCityGymLassScript, EVENT_GOLDENROD_CITY_CIVILIANS
	person_event SPRITE_POKEFAN_M, 18, 11, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x198a69, EVENT_GOLDENROD_CITY_CIVILIANS
	person_event SPRITE_YOUNGSTER, 17, 38, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 2, -1, -1, 0, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x198aa9, EVENT_GOLDENROD_CITY_CIVILIANS
	person_event SPRITE_COOLTRAINER_F, 16, 16, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_SCRIPT, 0, CooltrainerFScript_0x1989e9, EVENT_GOLDENROD_CITY_CIVILIANS
	person_event SPRITE_COOLTRAINER_F, 25, 25, SPRITEMOVEDATA_WANDER, 2, 1, -1, -1, 0, PERSONTYPE_SCRIPT, 0, CooltrainerFScript_0x1989fd, EVENT_GOLDENROD_CITY_CIVILIANS
	person_event SPRITE_YOUNGSTER, 17, 25, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, YoungsterScript_0x198a11, EVENT_GOLDENROD_CITY_CIVILIANS
	person_event SPRITE_LASS, 10, 20, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x198c83, EVENT_GOLDENROD_CITY_CIVILIANS
	person_event SPRITE_GRAMPS, 27, 15, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, -1, 0, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x198ccf, EVENT_GOLDENROD_CITY_CIVILIANS
	person_event SPRITE_ROCKET, 16, 29, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x198d4e, EVENT_GOLDENROD_CITY_ROCKET_TAKEOVER
	person_event SPRITE_ROCKET, 15, 12, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x198d6d, EVENT_GOLDENROD_CITY_ROCKET_TAKEOVER
	person_event SPRITE_ROCKET, 23, 20, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x198daa, EVENT_RADIO_TOWER_ROCKET_TAKEOVER
	person_event SPRITE_ROCKET, 7, 33, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x198e1f, EVENT_RADIO_TOWER_ROCKET_TAKEOVER
	person_event SPRITE_ROCKET, 10, 35, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x198e4b, EVENT_RADIO_TOWER_ROCKET_TAKEOVER

const_value set 1
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
	moveperson GOLDENRODCITY_ROCKET1, 29, 17
.RocketScoutDone
; Gym Lass
	checkevent EVENT_GOLDENROD_GYM_WHITNEY
	iffalse .GymLassDone
	moveperson GOLDENRODCITY_LASS2, 38, 24
.GymLassDone
	return

GoldenrodCityTrigger0:
	priorityjump GoldenrodCityStepDownScript
	end

GoldenrodCityStepDownScript:
	checkcode VAR_YCOORD
	if_not_equal $f, .Done
	checkcode VAR_XCOORD
	if_not_equal $9, .Done
	applyonemovement PLAYER, step_down
.Done
	dotrigger $1
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
	dotrigger $0
	warpfacing UP, RADIO_TOWER_1F, 2, 7
	end

MoveTutor:
	faceplayer
	opentext
	writetext UnknownText_0x199042
	yesorno
	iffalse .Refused
	special Special_DisplayCoinCaseBalance
	writetext UnknownText_0x199090
	yesorno
	iffalse .Refused2
	checkcoins 200
	if_equal $2, .NotEnoughMoney
	writetext UnknownText_0x1990ce
	loadmenudata .MoveMenuDataHeader
	verticalmenu
	closewindow
	if_equal $1, .FirePunch
	if_equal $2, .ThunderPunch
	if_equal $3, .IcePunch
	jump .Incompatible

.FirePunch:
	writebyte FIRE_PUNCH
	writetext UnknownText_0x1991cf
	special Special_MoveTutor
	if_equal $0, .TeachMove
	jump .Incompatible

.ThunderPunch:
	writebyte THUNDERPUNCH
	writetext UnknownText_0x1991cf
	special Special_MoveTutor
	if_equal $0, .TeachMove
	jump .Incompatible

.IcePunch:
	writebyte ICE_PUNCH
	writetext UnknownText_0x1991cf
	special Special_MoveTutor
	if_equal $0, .TeachMove
	jump .Incompatible

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

.Refused:
	jumpopenedtext UnknownText_0x1990b4

.Refused2:
	jumpopenedtext UnknownText_0x199107

.TeachMove:
	writetext UnknownText_0x19913a
	buttonsound
	takecoins 200
	waitsfx
	playsound SFX_TRANSACTION
	special Special_DisplayCoinCaseBalance
	jumpopenedtext UnknownText_0x19918b

.Incompatible:
	jumpopenedtext UnknownText_0x1991a4

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
	checknite
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
	spriteface LAST_TALKED, UP
	end

GoldenrodCityGymLassScript:
	checkevent EVENT_GOLDENROD_GYM_WHITNEY
	iffalse .GymLass
	jumptextfaceplayer GoldenrodCityLass2Text

.GymLass
	jumptextfaceplayer GoldenrodCityGymLassText

GoldenrodCityPokeCenterSign:
	jumptext PokeComCenterSignText

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
