Route33_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 1
	dbw MAPCALLBACK_TILES, Route33RainScript

Route33_MapEventHeader:

.Warps: db 1
	warp_def 9, 11, 3, UNION_CAVE_1F

.XYTriggers: db 0

.Signposts: db 1
	signpost 11, 11, SIGNPOST_JUMPTEXT, Route33SignText

.PersonEvents: db 3
	person_event SPRITE_POKEFAN_M, 13, 6, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_TRAINER, 2, TrainerHikerAnthony, -1
	person_event SPRITE_TWIN, 17, 12, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_TRAINER, 3, TrainerSchoolgirlImogen, -1
	fruittree_event 16, 14, FRUITTREE_ROUTE_33, PECHA_BERRY

Route33RainScript:
	special Special_GetOvercastIndex
	if_equal AZALEA_OVERCAST, .rain
	changemap Route33_BlockData
	return

.rain
	changemap Route33Raining_BlockData
	return

TrainerHikerAnthony:
	trainer EVENT_BEAT_HIKER_ANTHONY, HIKER, ANTHONY1, HikerAnthony1SeenText, HikerAnthony1BeatenText, 0, .Script

.Script:
	writecode VAR_CALLERID, PHONE_HIKER_ANTHONY
	opentext
	checkflag ENGINE_ANTHONY
	iftrue .Rematch
	checkflag ENGINE_DUNSPARCE_SWARM
	iftrue .Swarm
	checkcellnum PHONE_HIKER_ANTHONY
	iftrue .NumberAccepted
	checkevent EVENT_ANTHONY_ASKED_FOR_PHONE_NUMBER
	iftrue .AskAgain
	writetext HikerAnthony1AfterText
	buttonsound
	setevent EVENT_ANTHONY_ASKED_FOR_PHONE_NUMBER
	scall .AskNumber1
	jump .AskForPhoneNumber

.AskAgain:
	scall .AskNumber2
.AskForPhoneNumber:
	askforphonenumber PHONE_HIKER_ANTHONY
	if_equal $1, .PhoneFull
	if_equal $2, .NumberDeclined
	trainertotext HIKER, ANTHONY1, $0
	scall .RegisteredNumber
	jump .NumberAccepted

.Rematch:
	scall .RematchStd
	winlosstext HikerAnthony1BeatenText, 0
	copybytetovar wAnthonyFightCount
	if_equal 4, .Fight4
	if_equal 3, .Fight3
	if_equal 2, .Fight2
	if_equal 1, .Fight1
	if_equal 0, .LoadFight0
.Fight4:
	checkevent EVENT_RESTORED_POWER_TO_KANTO
	iftrue .LoadFight4
.Fight3:
	checkevent EVENT_BEAT_ELITE_FOUR
	iftrue .LoadFight3
.Fight2:
	checkevent EVENT_CLEARED_RADIO_TOWER
	iftrue .LoadFight2
.Fight1:
	checkflag ENGINE_FLYPOINT_OLIVINE
	iftrue .LoadFight1
.LoadFight0:
	loadtrainer HIKER, ANTHONY1
	startbattle
	reloadmapafterbattle
	loadvar wAnthonyFightCount, 1
	clearflag ENGINE_ANTHONY
	end

.LoadFight1:
	loadtrainer HIKER, ANTHONY2
	startbattle
	reloadmapafterbattle
	loadvar wAnthonyFightCount, 2
	clearflag ENGINE_ANTHONY
	end

.LoadFight2:
	loadtrainer HIKER, ANTHONY3
	startbattle
	reloadmapafterbattle
	loadvar wAnthonyFightCount, 3
	clearflag ENGINE_ANTHONY
	end

.LoadFight3:
	loadtrainer HIKER, ANTHONY4
	startbattle
	reloadmapafterbattle
	loadvar wAnthonyFightCount, 4
	clearflag ENGINE_ANTHONY
	end

.LoadFight4:
	loadtrainer HIKER, ANTHONY5
	startbattle
	reloadmapafterbattle
	clearflag ENGINE_ANTHONY
	end

.Swarm:
	jumpopenedtext HikerAnthonyDunsparceText

.AskNumber1:
	jumpstd asknumber1m
	end

.AskNumber2:
	jumpstd asknumber2m
	end

.RegisteredNumber:
	jumpstd registerednumberm
	end

.NumberAccepted:
	jumpstd numberacceptedm
	end

.NumberDeclined:
	jumpstd numberdeclinedm
	end

.PhoneFull:
	jumpstd phonefullm
	end

.RematchStd:
	jumpstd rematchm
	end

TrainerSchoolgirlImogen:
	trainer EVENT_BEAT_SCHOOLGIRL_IMOGEN, SCHOOLGIRL, IMOGEN, SchoolgirlImogenSeenText, SchoolgirlImogenBeatenText, 0, SchoolgirlImogenScript

SchoolgirlImogenScript:
	end_if_just_battled
	jumptextfaceplayer SchoolgirlImogenAfterText

HikerAnthony1SeenText:
	text "I came through the"
	line "tunnel, but I"

	para "still have plenty"
	line "of energy left."
	done

HikerAnthony1BeatenText:
	text "Whoa! You've got"
	line "more zip than me!"
	done

HikerAnthony1AfterText:
	text "We Hikers are at"
	line "our best in the"
	cont "mountains."
	done

HikerAnthonyDunsparceText:
	text "Hey, did you get a"
	line "Dunsparce?"

	para "I caught one too."

	para "Take a look at it"
	line "in the light. It's"
	cont "got a funny face!"
	done

SchoolgirlImogenSeenText:
	text "I'm the best in my"
	line "class at #mon."
	done

SchoolgirlImogenBeatenText:
	text "So there are bet-"
	line "ter trainers…"
	done

SchoolgirlImogenAfterText:
	text "I'm trying hard so"
	line "I can be the star"
	cont "in my class."
	done

Route33SignText:
	text "Route 33"
	done
