CeladonGameCorner_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event 14, 13, CELADON_CITY, 6
	warp_event 15, 13, CELADON_CITY, 6

	def_coord_events

	def_bg_events
	bg_event  1,  6, BGEVENT_READ, MapCeladonGameCornerSignpost11Script
	bg_event  1,  7, BGEVENT_READ, MapCeladonGameCornerSignpost11Script
	bg_event  1,  8, BGEVENT_READ, MapCeladonGameCornerSignpost11Script
	bg_event  1,  9, BGEVENT_READ, MapCeladonGameCornerSignpost11Script
	bg_event  1, 10, BGEVENT_READ, MapCeladonGameCornerSignpost11Script
	bg_event  1, 11, BGEVENT_LEFT, MapCeladonGameCornerSignpost11Script
	bg_event  6,  6, BGEVENT_READ, MapCeladonGameCornerSignpost11Script
	bg_event  6,  7, BGEVENT_READ, MapCeladonGameCornerSignpost11Script
	bg_event  6,  8, BGEVENT_READ, MapCeladonGameCornerSignpost11Script
	bg_event  6,  9, BGEVENT_READ, MapCeladonGameCornerSignpost9Script
	bg_event  6, 10, BGEVENT_READ, MapCeladonGameCornerSignpost11Script
	bg_event  6, 11, BGEVENT_RIGHT, MapCeladonGameCornerSignpost11Script
	bg_event  7,  6, BGEVENT_READ, MapCeladonGameCornerSignpost35Script
	bg_event  7,  7, BGEVENT_READ, MapCeladonGameCornerSignpost35Script
	bg_event  7,  8, BGEVENT_READ, MapCeladonGameCornerSignpost35Script
	bg_event  7,  9, BGEVENT_READ, MapCeladonGameCornerSignpost35Script
	bg_event  7, 10, BGEVENT_READ, MapCeladonGameCornerSignpost16Script
	bg_event  7, 11, BGEVENT_LEFT, MapCeladonGameCornerSignpost35Script
	bg_event 12,  6, BGEVENT_READ, MapCeladonGameCornerSignpost35Script
	bg_event 12,  7, BGEVENT_READ, MapCeladonGameCornerSignpost35Script
	bg_event 12,  8, BGEVENT_READ, MapCeladonGameCornerSignpost35Script
	bg_event 12,  9, BGEVENT_READ, MapCeladonGameCornerSignpost35Script
	bg_event 12, 10, BGEVENT_READ, MapCeladonGameCornerSignpost35Script
	bg_event 12, 11, BGEVENT_RIGHT, MapCeladonGameCornerSignpost35Script
	bg_event 13,  6, BGEVENT_READ, MapCeladonGameCornerSignpost35Script
	bg_event 13,  7, BGEVENT_READ, MapCeladonGameCornerSignpost35Script
	bg_event 13,  8, BGEVENT_READ, MapCeladonGameCornerSignpost35Script
	bg_event 13,  9, BGEVENT_READ, MapCeladonGameCornerSignpost35Script
	bg_event 13, 10, BGEVENT_READ, MapCeladonGameCornerSignpost35Script
	bg_event 13, 11, BGEVENT_LEFT, MapCeladonGameCornerSignpost35Script
	bg_event 18,  6, BGEVENT_READ, MapCeladonGameCornerSignpost35Script
	bg_event 18,  7, BGEVENT_READ, MapCeladonGameCornerSignpost35Script
	bg_event 18,  8, BGEVENT_JUMPTEXT, CeladonGameCornerLighterText
	bg_event 18,  9, BGEVENT_READ, MapCeladonGameCornerSignpost35Script
	bg_event 18, 10, BGEVENT_READ, MapCeladonGameCornerSignpost35Script
	bg_event 18, 11, BGEVENT_RIGHT, MapCeladonGameCornerSignpost35Script
	bg_event 15,  0, BGEVENT_JUMPTEXT, CeladonGameCornerPoster1Text
	bg_event  9,  0, BGEVENT_JUMPTEXT, CeladonGameCornerPoster2Text

	def_object_events
	object_event  5,  2, SPRITE_CLERK, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_COMMAND, jumpstd, gamecornercoinvendor, -1
	object_event  3,  2, SPRITE_RECEPTIONIST, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_COMMAND, jumptextfaceplayer, CeladonGameCornerReceptionistText, -1
	object_event 14, 10, SPRITE_POKEFAN_M, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, CeladonGameCornerPokefanMScript, -1
	object_event 17,  7, SPRITE_POKEFAN_F, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, CeladonGameCornerTeacherScript, -1
	object_event 11,  7, SPRITE_FISHING_GURU, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, CeladonGameCornerFishingGuruScript, -1
	object_event  8, 10, SPRITE_FAT_GUY, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, (1 << DAY) | (1 << NITE), PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, CeladonGameCornerFisherScript, -1
	object_event 11,  3, SPRITE_GYM_GUY, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_COMMAND, jumptextfaceplayer, CeladonGymGuyText, -1
	object_event  2,  8, SPRITE_GRAMPS, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, CeladonGameCornerGrampsScript, -1

CeladonGameCornerPokefanMScript:
	showtextfaceplayer CeladonGameCornerPokefanMText
	turnobject LAST_TALKED, LEFT
	end

CeladonGameCornerTeacherScript:
	showtextfaceplayer CeladonGameCornerTeacherText
	turnobject LAST_TALKED, RIGHT
	end

CeladonGameCornerFishingGuruScript:
	showtextfaceplayer CeladonGameCornerFishingGuruText
	turnobject LAST_TALKED, RIGHT
	end

CeladonGameCornerFisherScript:
	faceplayer
	opentext
	checkevent EVENT_GOT_COINS_FROM_GAMBLER_AT_CELADON
	iftrue .FisherOffer
	writetext CeladonGameCornerFisherText1
	buttonsound
	checkkeyitem COIN_CASE
	iffalse UnknownScript_0x7217b
	checkcoins 49999
	ifequal $0, UnknownScript_0x72184
	stringtotext .coinname, $1
	callstd receiveitem
	givecoins 18
	setevent EVENT_GOT_COINS_FROM_GAMBLER_AT_CELADON
.FisherOffer:
	writetext FisherOfferText
	yesorno
	iffalse .UnknownScript_0x72169
	checkcoins 50
	ifequal $2, .FisherNotEnough
	takecoins 50
	playsound SFX_TRANSACTION
	scall MapCeladonGameCornerSignpost16Script
	opentext
.UnknownScript_0x72169:
	writetext CeladonGameCornerFisherText2
	jump .FisherEnd
.FisherNotEnough:
	writetext FisherNotEnoughText
.FisherEnd:
	waitbutton
	closetext
	turnobject LAST_TALKED, LEFT
	end

.coinname
	db "Coin@"

UnknownScript_0x7217b:
	writetext CeladonGameCornerFisherNoCoinCaseText
	waitbutton
	closetext
	turnobject LAST_TALKED, LEFT
	end

UnknownScript_0x72184:
	writetext CeladonGameCornerFisherFullCoinCaseText
	waitbutton
	closetext
	turnobject LAST_TALKED, LEFT
	end

CeladonGameCornerGrampsScript:
	showtextfaceplayer CeladonGameCornerGrampsText
	turnobject LAST_TALKED, LEFT
	end

MapCeladonGameCornerSignpost35Script:
	random $6
	ifequal $0, MapCeladonGameCornerSignpost16Script
	refreshscreen
	writebyte $0
	special Special_SlotMachine
	endtext

MapCeladonGameCornerSignpost16Script:
	refreshscreen
	writebyte $1
	special Special_SlotMachine
	endtext

MapCeladonGameCornerSignpost11Script:
	refreshscreen
	special Special_CardFlip
	endtext

MapCeladonGameCornerSignpost9Script:
	opentext
	writetext CeladonGameCornerSodaCanText
	waitbutton
	special Special_CardFlip
	endtext

CeladonGameCornerReceptionistText:
	text "Welcome!"

	para "You may exchange"
	line "your coins for"

	para "fabulous prizes"
	line "next door."
	done

CeladonGameCornerPokefanMText:
	text "The slot machines"
	line "are all state of"
	cont "the art."
	done

CeladonGameCornerTeacherText:
	text "It's this machine"
	line "I want."

	para "It cleaned me out"
	line "yesterday, so it"

	para "should pay out"
	line "today."
	done

CeladonGameCornerFishingGuruText:
	text "I think this slot"
	line "machine will pay"
	cont "out…"

	para "The odds vary"
	line "among machines."
	done

CeladonGameCornerFisherText1:
	text "Gahahaha!"

	para "The coins just"
	line "keep popping out!"

	para "Hm? What, kid? You"
	line "want to play?"

	para "I'll share my luck"
	line "with you!"
	done

CeladonGameCornerFisherText2:
	text "Gahahaha!"

	para "It makes me feel"
	line "good to do nice"

	para "things for other"
	line "people!"
	done

CeladonGameCornerFisherNoCoinCaseText:
	text "Hey, you don't"
	line "have a Coin Case."

	para "How am I supposed"
	line "to give you any"
	cont "coins, kid?"
	done

CeladonGameCornerFisherFullCoinCaseText:
	text "Hey, your Coin"
	line "Case is full, kid."

	para "You must be riding"
	line "a winning streak"
	cont "too."
	done

FisherOfferText:
	text "Hm? What, kid? You"
	line "still want to"
	cont "play?"

	para "I know! I'll let"
	line "you play for 50"
	cont "coins."

	para "How about it?"
	done

FisherNotEnoughText:
	text "Hey, your Coin"
	line "Case is almost"
	cont "empty, kid."

	para "Your luck must"
	line "be running dry."
	done

CeladonGymGuyText:
	text "Hey! Champ in"
	line "making!"

	para "Are you playing"
	line "the slots too?"

	para "I'm trying to get"
	line "enough coins for a"
	cont "prize #mon."

	para "But I don't have"
	line "enough coins yet…"
	done

CeladonGameCornerGrampsText:
	text "Hmmm… The odds are"
	line "surely better for"

	para "Pikachu's line,"
	line "but… What to do?"
	done

CeladonGameCornerPoster1Text:
	text "Hey!"

	para "Underneath this"
	line "poster…"

	para "There's nothing!"
	done

CeladonGameCornerPoster2Text:
	text "Hey!"

	para "Underneath this"
	line "poster…"

	para "There's nothing!"
	done

CeladonGameCornerLighterText:
	text "There's a lighter"
	line "here."
	done

CeladonGameCornerSodaCanText:
	text "A can of soda…"

	para "Someone must be"
	line "coming back…"

	para "Huh? It's empty!"
	done
