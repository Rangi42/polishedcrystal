const_value set 2
	const MAHOGANYTOWN_POKEFAN_M
	const MAHOGANYTOWN_GRAMPS
	const MAHOGANYTOWN_FISHER
	const MAHOGANYTOWN_LASS

MahoganyTown_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 1
	dbw MAPCALLBACK_NEWMAP, .FlyPoint

.FlyPoint:
	setflag ENGINE_FLYPOINT_MAHOGANY
	return

UnknownScript_0x190013:
	showemote EMOTE_SHOCK, MAHOGANYTOWN_POKEFAN_M, 15
	applymovement MAHOGANYTOWN_POKEFAN_M, MovementData_0x1900a9
	follow PLAYER, MAHOGANYTOWN_POKEFAN_M
	applymovement PLAYER, MovementData_0x1900a7
	stopfollow
	spriteface PLAYER, RIGHT
	scall UnknownScript_0x19002f
	applymovement MAHOGANYTOWN_POKEFAN_M, MovementData_0x1900ad
	end

PokefanMScript_0x19002e:
	faceplayer
UnknownScript_0x19002f:
	checkevent EVENT_CLEARED_ROCKET_HIDEOUT
	iftrue UnknownScript_0x190039
	scall UnknownScript_0x190040
	end

UnknownScript_0x190039:
	opentext
	writetext UnknownText_0x1901a6
	waitbutton
	closetext
	end

UnknownScript_0x190040:
	opentext
	writetext UnknownText_0x1900b0
	special PlaceMoneyTopRight
	yesorno
	iffalse UnknownScript_0x190072
	checkmoney $0, 300
	if_equal $2, UnknownScript_0x19006c
	giveitem RAGECANDYBAR
	iffalse UnknownScript_0x190078
	waitsfx
	playsound SFX_TRANSACTION
	takemoney $0, 300
	special PlaceMoneyTopRight
	writetext UnknownText_0x19014a
	waitbutton
	closetext
	end

UnknownScript_0x19006c:
	writetext UnknownText_0x19015b
	waitbutton
	closetext
	end

UnknownScript_0x190072:
	writetext UnknownText_0x190178
	waitbutton
	closetext
	end

UnknownScript_0x190078:
	writetext UnknownText_0x190188
	waitbutton
	closetext
	end

GrampsScript_0x19007e:
	faceplayer
	opentext
	checkevent EVENT_CLEARED_ROCKET_HIDEOUT
	iftrue UnknownScript_0x19008c
	writetext UnknownText_0x1901e5
	waitbutton
	closetext
	end

UnknownScript_0x19008c:
	writetext UnknownText_0x19021d
	waitbutton
	closetext
	end

FisherScript_0x190092:
	jumptextfaceplayer UnknownText_0x190276

LassScript_0x190095:
	jumptextfaceplayer UnknownText_0x1902f2

MahoganyTownSign:
	jumptext MahoganyTownSignText

MahoganyTownSouvenirShopSign:
	checkevent EVENT_MAHOGANY_MART_OWNERS
	iftrue .rockets
	jumptext MahoganyTownSouvenirShopSignText2

.rockets
	jumptext MahoganyTownSouvenirShopSignText1

MahoganyGymSign:
	jumptext MahoganyGymSignText

MovementData_0x1900a7:
	step_left
	step_end

MovementData_0x1900a9:
	step_right
	step_down
	turn_head_left
	step_end

MovementData_0x1900ad:
	step_up
	turn_head_down
	step_end

UnknownText_0x1900b0:
	text "Hiya, kid!"

	para "I see you're new"
	line "in Mahogany Town."

	para "Since you're new,"
	line "you should try a"

	para "yummy RageCandy-"
	line "Bar!"

	para "Right now, it can"
	line "be yours for just"
	cont "¥300! Want one?"
	done

UnknownText_0x19014a:
	text "Good! Savor it!"
	done

UnknownText_0x19015b:
	text "You don't have"
	line "enough money."
	done

UnknownText_0x190178:
	text "Oh, fine then…"
	done

UnknownText_0x190188:
	text "You don't have"
	line "room for this."
	done

UnknownText_0x1901a6:
	text "RageCandyBar's"
	line "sold out."

	para "I'm packing up."
	line "Don't bother me,"
	cont "kiddo."
	done

UnknownText_0x1901e5:
	text "Are you off to see"
	line "the Gyarados ram-"
	cont "page at the lake?"
	done

UnknownText_0x19021d:
	text "Magikarp have"
	line "returned to Lake"
	cont "of Rage."

	para "That should be"
	line "good news for the"
	cont "anglers there."
	done

UnknownText_0x190276:
	text "Since you came"
	line "this far, take the"

	para "time to do some"
	line "sightseeing."

	para "You should head"
	line "north and check"

	para "out Lake of Rage"
	line "right now."
	done

UnknownText_0x1902f2:
	text "Visit Grandma's"
	line "shop. She sells"

	para "stuff that nobody"
	line "else has."
	done

MahoganyTownSignText:
	text "Mahogany Town"

	para "Welcome to the"
	line "Home of the Ninja"
	done

MahoganyTownSouvenirShopSignText1:
	text "Just a Souvenir"
	line "Shop"

	para "Nothing Suspicious"
	line "About It"

	para "No Need to Be"
	line "Alarmed"
	done

MahoganyTownSouvenirShopSignText2:
	text "Grandma's"
	line "Souvenir Shop"
	done

MahoganyGymSignText:
	text "Mahogany Town"
	line "#mon Gym"
	cont "Leader: Pryce"

	para "The Teacher of"
	line "Winter's Harshness"
	done

MahoganyTown_MapEventHeader:
.Warps:
	db 5
	warp_def $7, $b, 1, MAHOGANY_MART_1F
	warp_def $7, $11, 1, MAHOGANY_RED_GYARADOS_SPEECH_HOUSE
	warp_def $d, $6, 1, MAHOGANY_GYM
	warp_def $d, $f, 1, MAHOGANY_POKECENTER_1F
	warp_def $1, $9, 3, ROUTE_43_MAHOGANY_GATE

.XYTriggers:
	db 2
	xy_trigger 0, $8, $13, UnknownScript_0x190013
	xy_trigger 0, $9, $13, UnknownScript_0x190013

.Signposts:
	db 3
	signpost 5, 1, SIGNPOST_READ, MahoganyTownSign
	signpost 7, 9, SIGNPOST_READ, MahoganyTownSouvenirShopSign
	signpost 13, 3, SIGNPOST_READ, MahoganyGymSign

.PersonEvents:
	db 4
	person_event SPRITE_POKEFAN_M, 8, 19, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, PokefanMScript_0x19002e, EVENT_MAHOGANY_TOWN_POKEFAN_M_BLOCKS_EAST
	person_event SPRITE_GRAMPS, 9, 6, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, -1, 0, PERSONTYPE_SCRIPT, 0, GrampsScript_0x19007e, -1
	person_event SPRITE_FISHER, 14, 6, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_SCRIPT, 0, FisherScript_0x190092, EVENT_MAHOGANY_TOWN_POKEFAN_M_BLOCKS_GYM
	person_event SPRITE_NEW_BARK_LYRA, 8, 12, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, LassScript_0x190095, EVENT_MAHOGANY_MART_OWNERS
