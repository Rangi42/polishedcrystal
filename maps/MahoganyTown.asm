MahoganyTown_MapScriptHeader:
	db 0 ; scene scripts

	db 1 ; callbacks
	callback MAPCALLBACK_NEWMAP, MahoganyTownFlyPoint

	db 5 ; warp events
	warp_event 11,  7, MAHOGANY_MART_1F, 1
	warp_event 17,  7, MAHOGANY_RED_GYARADOS_SPEECH_HOUSE, 1
	warp_event  6, 13, MAHOGANY_GYM, 1
	warp_event 15, 13, MAHOGANY_POKECENTER_1F, 1
	warp_event  9,  1, ROUTE_43_MAHOGANY_GATE, 3

	db 2 ; coord events
	coord_event 19,  8, 0, UnknownScript_0x190013
	coord_event 19,  9, 0, UnknownScript_0x190013

	db 3 ; bg events
	bg_event  1,  5, SIGNPOST_JUMPTEXT, MahoganyTownSignText
	bg_event  9,  7, SIGNPOST_READ, MahoganyTownSouvenirShopSign
	bg_event  3, 13, SIGNPOST_JUMPTEXT, MahoganyGymSignText

	db 4 ; object events
	object_event 19,  8, SPRITE_NEW_BARK_TEACHER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BROWN, PERSONTYPE_SCRIPT, 0, PokefanMScript_0x19002e, EVENT_MAHOGANY_TOWN_POKEFAN_M_BLOCKS_EAST
	object_event  5,  8, SPRITE_GRAMPS, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 1, -1, -1, 0, PERSONTYPE_SCRIPT, 0, GrampsScript_0x19007e, -1
	object_event  6, 14, SPRITE_FISHER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_GREEN, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x190276, EVENT_MAHOGANY_TOWN_POKEFAN_M_BLOCKS_GYM
	object_event 12,  8, SPRITE_NEW_BARK_LYRA, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x1902f2, EVENT_MAHOGANY_MART_OWNERS

	const_def 1 ; object constants
	const MAHOGANYTOWN_POKEFAN_M

MahoganyTownFlyPoint:
	setflag ENGINE_FLYPOINT_MAHOGANY
	return

UnknownScript_0x190013:
	showemote EMOTE_SHOCK, MAHOGANYTOWN_POKEFAN_M, 15
	applymovement MAHOGANYTOWN_POKEFAN_M, MovementData_0x1900a9
	follow PLAYER, MAHOGANYTOWN_POKEFAN_M
	applyonemovement PLAYER, step_left
	stopfollow
	turnobject PLAYER, RIGHT
	scall UnknownScript_0x19002f
	applymovement MAHOGANYTOWN_POKEFAN_M, MovementData_0x1900ad
	end

PokefanMScript_0x19002e:
	faceplayer
UnknownScript_0x19002f:
	checkevent EVENT_CLEARED_ROCKET_HIDEOUT
	iftrue_jumptext UnknownText_0x1901a6
	opentext
	writetext UnknownText_0x1900b0
	special PlaceMoneyTopRight
	yesorno
	iffalse_jumpopenedtext UnknownText_0x190178
	checkmoney $0, 300
	ifequal $2, UnknownScript_0x19006c
	giveitem RAGECANDYBAR
	iffalse_jumpopenedtext UnknownText_0x190188
	waitsfx
	playsound SFX_TRANSACTION
	takemoney $0, 300
	special PlaceMoneyTopRight
	thisopenedtext

	text "Good! Savor it!"
	done

UnknownScript_0x19006c:
	thisopenedtext

	text "You don't have"
	line "enough money."
	done

GrampsScript_0x19007e:
	checkevent EVENT_CLEARED_ROCKET_HIDEOUT
	iftrue_jumptextfaceplayer UnknownText_0x19021d
	jumptextfaceplayer UnknownText_0x1901e5

MahoganyTownSouvenirShopSign:
	checkevent EVENT_MAHOGANY_MART_OWNERS
	iftrue_jumptext MahoganyTownSouvenirShopSignText1
	thistext

	text "Grandma's"
	line "Souvenir Shop"
	done

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

if DEF(FAITHFUL)
	para "yummy RageCandy-"
	line "Bar!"
else
	para "yummy Cake of"
	line "Rage!"
endc

	para "Right now, it can"
	line "be yours for just"
	cont "¥300! Want one?"
	done

UnknownText_0x190178:
	text "Oh, fine then…"
	done

UnknownText_0x190188:
	text "You don't have"
	line "room for this."
	done

UnknownText_0x1901a6:
if DEF(FAITHFUL)
	text "RageCandyBars are"
else
	text "Cakes of Rage are"
endc
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

MahoganyGymSignText:
	text "Mahogany Town"
	line "#mon Gym"
	cont "Leader: Pryce"

	para "The Teacher of"
	line "Winter's Harshness"
	done
