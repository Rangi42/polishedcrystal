MahoganyTown_MapScriptHeader:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_NEWMAP, MahoganyTownFlyPoint

	def_warp_events
	warp_event 11,  7, MAHOGANY_MART_1F, 1
	warp_event 17,  7, MAHOGANY_RED_GYARADOS_SPEECH_HOUSE, 1
	warp_event  6, 13, MAHOGANY_GYM, 1
	warp_event 15, 13, MAHOGANY_POKECENTER_1F, 1
	warp_event  9,  1, ROUTE_43_MAHOGANY_GATE, 3

	def_coord_events
	coord_event 19,  8, 0, MahoganyTownTryARageCandyBarScript
	coord_event 19,  9, 0, MahoganyTownTryARageCandyBarScript

	def_bg_events
	bg_event  1,  5, BGEVENT_JUMPTEXT, MahoganyTownSignText
	bg_event  9,  7, BGEVENT_READ, MahoganyTownSouvenirShopSign
	bg_event  3, 13, BGEVENT_JUMPTEXT, MahoganyGymSignText

	def_object_events
	object_event 19,  8, SPRITE_POKEFAN_M, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_SCRIPT, 0, MahoganyTownPokefanMScript, EVENT_MAHOGANY_TOWN_POKEFAN_M_BLOCKS_EAST
	object_event  6,  9, SPRITE_GRAMPS, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, MahoganyTownGrampsScript, -1
	object_event  6, 14, SPRITE_FISHER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, MahoganyTownFisherText, EVENT_MAHOGANY_TOWN_POKEFAN_M_BLOCKS_GYM
	object_event 12,  8, SPRITE_CUTE_GIRL, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_COMMAND, jumptextfaceplayer, MahoganyTownLassText, EVENT_MAHOGANY_MART_OWNERS

	object_const_def
	const MAHOGANYTOWN_POKEFAN_M

MahoganyTownFlyPoint:
	setflag ENGINE_FLYPOINT_MAHOGANY
	return

MahoganyTownTryARageCandyBarScript:
	showemote EMOTE_SHOCK, MAHOGANYTOWN_POKEFAN_M, 15
	applymovement MAHOGANYTOWN_POKEFAN_M, MahoganyTownRageCandyBarMerchantBlocksYouMovement
	follow PLAYER, MAHOGANYTOWN_POKEFAN_M
	applyonemovement PLAYER, step_left
	stopfollow
	turnobject PLAYER, RIGHT
	scall RageCandyBarMerchantScript
	applymovement MAHOGANYTOWN_POKEFAN_M, MahoganyTownRageCandyBarMerchantReturnsMovement
	end

MahoganyTownPokefanMScript:
	faceplayer
RageCandyBarMerchantScript:
	checkevent EVENT_CLEARED_ROCKET_HIDEOUT
	iftrue_jumptext RageCandyBarMerchantSoldOutText
	opentext
	writetext RageCandyBarMerchantTryOneText
	special PlaceMoneyTopRight
	yesorno
	iffalse_jumpopenedtext RageCandyBarMerchantRefusedText
	checkmoney $0, 300
	ifequal $2, UnknownScript_0x19006c
	giveitem RAGECANDYBAR
	iffalse_jumpopenedtext RageCandyBarMerchantNoRoomText
	waitsfx
	playsound SFX_TRANSACTION
	takemoney $0, 300
	special PlaceMoneyTopRight
	jumpthisopenedtext

	text "Good! Savor it!"
	done

UnknownScript_0x19006c:
	jumpthisopenedtext

	text "You don't have"
	line "enough money."
	done

MahoganyTownGrampsScript:
	checkevent EVENT_CLEARED_ROCKET_HIDEOUT
	iftrue_jumptextfaceplayer MahoganyTownGrampsText_ClearedRocketHideout
	jumptextfaceplayer MahoganyTownGrampsText

MahoganyTownSouvenirShopSign:
	checkevent EVENT_MAHOGANY_MART_OWNERS
	iftrue_jumptext MahoganyTownSouvenirShopSignText1
	jumpthistext

	text "Grandma's"
	line "Souvenir Shop"
	done

MahoganyTownRageCandyBarMerchantBlocksYouMovement:
	step_right
	step_down
	turn_head_left
	step_end

MahoganyTownRageCandyBarMerchantReturnsMovement:
	step_up
	turn_head_down
	step_end

RageCandyBarMerchantTryOneText:
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

RageCandyBarMerchantRefusedText:
	text "Oh, fine then…"
	done

RageCandyBarMerchantNoRoomText:
	text "You don't have"
	line "room for this."
	done

RageCandyBarMerchantSoldOutText:
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

MahoganyTownGrampsText:
	text "Are you off to see"
	line "the Gyarados ram-"
	cont "page at the lake?"
	done

MahoganyTownGrampsText_ClearedRocketHideout:
	text "Magikarp have"
	line "returned to Lake"
	cont "of Rage."

	para "That should be"
	line "good news for the"
	cont "anglers there."
	done

MahoganyTownFisherText:
	text "Since you came"
	line "this far, take the"

	para "time to do some"
	line "sightseeing."

	para "You should head"
	line "north and check"

	para "out Lake of Rage"
	line "right now."
	done

MahoganyTownLassText:
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
