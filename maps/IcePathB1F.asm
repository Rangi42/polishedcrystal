IcePathB1F_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 1
	dbw MAPCALLBACK_CMDQUEUE, IcePathB1FSetUpStoneTable

IcePathB1F_MapEventHeader:

.Warps: db 8
	warp_def 15, 3, 3, ICE_PATH_1F
	warp_def 3, 17, 1, ICE_PATH_B2F_MAHOGANY_SIDE
	warp_def 2, 11, 3, ICE_PATH_B2F_MAHOGANY_SIDE ; hole
	warp_def 7, 4, 4, ICE_PATH_B2F_MAHOGANY_SIDE ; hole
	warp_def 12, 5, 5, ICE_PATH_B2F_MAHOGANY_SIDE ; hole
	warp_def 13, 12, 6, ICE_PATH_B2F_MAHOGANY_SIDE ; hole
	warp_def 25, 5, 4, ICE_PATH_1F
	warp_def 27, 11, 1, ICE_PATH_B2F_BLACKTHORN_SIDE

.XYTriggers: db 0

.Signposts: db 1
	signpost 30, 17, SIGNPOST_ITEM + MAX_POTION, EVENT_ICE_PATH_B1F_HIDDEN_MAX_POTION

.PersonEvents: db 8
	strengthboulder_event 7, 11, EVENT_BOULDER_IN_ICE_PATH_1
	strengthboulder_event 8, 7, EVENT_BOULDER_IN_ICE_PATH_2
	strengthboulder_event 9, 8, EVENT_BOULDER_IN_ICE_PATH_3
	strengthboulder_event 7, 17, EVENT_BOULDER_IN_ICE_PATH_4
	person_event SPRITE_SKIER, 1, 2, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, IcePathB1FSkierScript, -1
	person_event SPRITE_BOARDER, 23, 4, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_TRAINER, 3, TrainerBoarderMax, -1
	person_event SPRITE_SKIER, 24, 14, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_TRAINER, 2, TrainerSkierBecky, -1
	itemball_event 35, 5, IRON, 1, EVENT_ICE_PATH_B1F_IRON

const_value set 1
	const ICEPATHB1F_BOULDER1
	const ICEPATHB1F_BOULDER2
	const ICEPATHB1F_BOULDER3
	const ICEPATHB1F_BOULDER4

IcePathB1FSetUpStoneTable:
	writecmdqueue .CommandQueue
	return

.CommandQueue:
	dbw CMDQUEUE_STONETABLE, .StoneTable ; check if any stones are sitting on a warp
	dw 0 ; filler

.StoneTable:
	stonetable 3, ICEPATHB1F_BOULDER1, .Boulder1
	stonetable 4, ICEPATHB1F_BOULDER2, .Boulder2
	stonetable 5, ICEPATHB1F_BOULDER3, .Boulder3
	stonetable 6, ICEPATHB1F_BOULDER4, .Boulder4
	db -1

.Boulder1:
	disappear ICEPATHB1F_BOULDER1
	clearevent EVENT_BOULDER_IN_ICE_PATH_1A
	jump .FinishBoulder

.Boulder2:
	disappear ICEPATHB1F_BOULDER2
	clearevent EVENT_BOULDER_IN_ICE_PATH_2A
	jump .FinishBoulder

.Boulder3:
	disappear ICEPATHB1F_BOULDER3
	clearevent EVENT_BOULDER_IN_ICE_PATH_3A
	jump .FinishBoulder

.Boulder4:
	disappear ICEPATHB1F_BOULDER4
	clearevent EVENT_BOULDER_IN_ICE_PATH_4A
	jump .FinishBoulder

.FinishBoulder:
	pause 30
	scall .BoulderFallsThrough
	jumptext IcePathBoulderFellThroughText

.BoulderFallsThrough:
	playsound SFX_STRENGTH
	earthquake 80
	end

IcePathB1FSkierScript:
	faceplayer
	opentext
	checkevent EVENT_LISTENED_TO_ICY_WIND_INTRO
	iftrue IcePathB1FTutorIcyWindScript
	writetext IcePathB1FSkierText
	waitbutton
	setevent EVENT_LISTENED_TO_ICY_WIND_INTRO
IcePathB1FTutorIcyWindScript:
	writetext Text_IcePathB1FTutorIcyWind
	waitbutton
	checkitem SILVER_LEAF
	iffalse .NoSilverLeaf
	writetext Text_IcePathB1FTutorQuestion
	yesorno
	iffalse .TutorRefused
	writebyte ICY_WIND
	writetext Text_IcePathB1FTutorClear
	special Special_MoveTutor
	if_equal $0, .TeachMove
.TutorRefused
	jumpopenedtext Text_IcePathB1FTutorRefused

.NoSilverLeaf
	jumpopenedtext Text_IcePathB1FTutorNoSilverLeaf

.TeachMove
	takeitem SILVER_LEAF
	jumpopenedtext Text_IcePathB1FTutorTaught

TrainerBoarderMax:
	trainer EVENT_BEAT_BOARDER_MAX, BOARDER, MAX, BoarderMaxSeenText, BoarderMaxBeatenText, 0, BoarderMaxScript

BoarderMaxScript:
	end_if_just_battled
	jumptextfaceplayer BoarderMaxAfterText

TrainerSkierBecky:
	trainer EVENT_BEAT_SKIER_BECKY, SKIER, BECKY, SkierBeckySeenText, SkierBeckyBeatenText, 0, SkierBeckyScript

SkierBeckyScript:
	end_if_just_battled
	jumptextfaceplayer SkierBeckyAfterText

IcePathB1FSkierText:
	text "It's really cold"
	line "in here!"

	para "The pits in the"
	line "ground let cold"

	para "air blow through"
	line "this cavern."

	para "It actually seems"
	line "like a good tech-"

	para "nique for a"
	line "#mon!"
	done

Text_IcePathB1FTutorIcyWind:
	text "I'll teach a #-"
	line "mon of yours to"

	para "use Icy Wind if"
	line "you trade me a"
	cont "Silver Leaf."
	done

Text_IcePathB1FTutorNoSilverLeaf:
	text "Oh, but you don't"
	line "have a Silver"
	cont "Leaf."
	done

Text_IcePathB1FTutorQuestion:
	text "Should I teach"
	line "your #mon"
	cont "Icy Wind?"
	done

Text_IcePathB1FTutorRefused:
	text "Brr…"
	done

Text_IcePathB1FTutorClear:
	text ""
	done

Text_IcePathB1FTutorTaught:
	text "OK! Now your"
	line "#mon knows"
	cont "Icy Wind!"
	done

BoarderMaxSeenText:
	text "Blackthorn can't be"
	line "much farther…"
	done

BoarderMaxBeatenText:
	text "Wiped out!"
	done

BoarderMaxAfterText:
	text "I'm not giving up!"
	done

SkierBeckySeenText:
	text "I can see my"
	line "breath freezing!"
	done

SkierBeckyBeatenText:
	text "Achoo!"
	done

SkierBeckyAfterText:
	text "Don't forget to"
	line "wear a scarf!"
	done

IcePathBoulderFellThroughText:
	text "The boulder fell"
	line "through."
	done
