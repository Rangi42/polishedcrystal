CeladonGameCorner_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 2 ; warp events
	warp_event 14, 13, CELADON_CITY, 6
	warp_event 15, 13, CELADON_CITY, 6

	db 0 ; coord events

	db 38 ; bg events
	bg_event  1,  6, SIGNPOST_READ, MapCeladonGameCornerSignpost11Script
	bg_event  1,  7, SIGNPOST_READ, MapCeladonGameCornerSignpost11Script
	bg_event  1,  8, SIGNPOST_READ, MapCeladonGameCornerSignpost11Script
	bg_event  1,  9, SIGNPOST_READ, MapCeladonGameCornerSignpost11Script
	bg_event  1, 10, SIGNPOST_READ, MapCeladonGameCornerSignpost11Script
	bg_event  1, 11, SIGNPOST_LEFT, MapCeladonGameCornerSignpost11Script
	bg_event  6,  6, SIGNPOST_READ, MapCeladonGameCornerSignpost11Script
	bg_event  6,  7, SIGNPOST_READ, MapCeladonGameCornerSignpost11Script
	bg_event  6,  8, SIGNPOST_READ, MapCeladonGameCornerSignpost11Script
	bg_event  6,  9, SIGNPOST_READ, MapCeladonGameCornerSignpost9Script
	bg_event  6, 10, SIGNPOST_READ, MapCeladonGameCornerSignpost11Script
	bg_event  6, 11, SIGNPOST_RIGHT, MapCeladonGameCornerSignpost11Script
	bg_event  7,  6, SIGNPOST_READ, MapCeladonGameCornerSignpost35Script
	bg_event  7,  7, SIGNPOST_READ, MapCeladonGameCornerSignpost35Script
	bg_event  7,  8, SIGNPOST_READ, MapCeladonGameCornerSignpost35Script
	bg_event  7,  9, SIGNPOST_READ, MapCeladonGameCornerSignpost35Script
	bg_event  7, 10, SIGNPOST_READ, MapCeladonGameCornerSignpost16Script
	bg_event  7, 11, SIGNPOST_LEFT, MapCeladonGameCornerSignpost35Script
	bg_event 12,  6, SIGNPOST_READ, MapCeladonGameCornerSignpost35Script
	bg_event 12,  7, SIGNPOST_READ, MapCeladonGameCornerSignpost35Script
	bg_event 12,  8, SIGNPOST_READ, MapCeladonGameCornerSignpost35Script
	bg_event 12,  9, SIGNPOST_READ, MapCeladonGameCornerSignpost35Script
	bg_event 12, 10, SIGNPOST_READ, MapCeladonGameCornerSignpost35Script
	bg_event 12, 11, SIGNPOST_RIGHT, MapCeladonGameCornerSignpost35Script
	bg_event 13,  6, SIGNPOST_READ, MapCeladonGameCornerSignpost35Script
	bg_event 13,  7, SIGNPOST_READ, MapCeladonGameCornerSignpost35Script
	bg_event 13,  8, SIGNPOST_READ, MapCeladonGameCornerSignpost35Script
	bg_event 13,  9, SIGNPOST_READ, MapCeladonGameCornerSignpost35Script
	bg_event 13, 10, SIGNPOST_READ, MapCeladonGameCornerSignpost35Script
	bg_event 13, 11, SIGNPOST_LEFT, MapCeladonGameCornerSignpost35Script
	bg_event 18,  6, SIGNPOST_READ, MapCeladonGameCornerSignpost35Script
	bg_event 18,  7, SIGNPOST_READ, MapCeladonGameCornerSignpost35Script
	bg_event 18,  8, SIGNPOST_JUMPTEXT, UnknownText_0x7254f
	bg_event 18,  9, SIGNPOST_READ, MapCeladonGameCornerSignpost35Script
	bg_event 18, 10, SIGNPOST_READ, MapCeladonGameCornerSignpost35Script
	bg_event 18, 11, SIGNPOST_RIGHT, MapCeladonGameCornerSignpost35Script
	bg_event 15,  0, SIGNPOST_JUMPTEXT, UnknownText_0x724f3
	bg_event  9,  0, SIGNPOST_JUMPTEXT, UnknownText_0x72521

	db 8 ; object events
	object_event  5,  2, SPRITE_CLERK, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_GREEN, PERSONTYPE_COMMAND, jumpstd, gamecornercoinvendor, -1
	object_event  3,  2, SPRITE_RECEPTIONIST, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_GREEN, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x721d0, -1
	object_event 14, 10, SPRITE_POKEFAN_M, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_RED, PERSONTYPE_SCRIPT, 0, PokefanMScript_0x72123, -1
	object_event 17,  7, SPRITE_TEACHER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_BLUE, PERSONTYPE_SCRIPT, 0, TeacherScript_0x7212e, -1
	object_event 11,  7, SPRITE_FISHING_GURU, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_GREEN, PERSONTYPE_SCRIPT, 0, FishingGuruScript_0x72139, -1
	object_event  8, 10, SPRITE_FISHER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_RED, PERSONTYPE_SCRIPT, 0, FisherScript_0x72144, -1
	object_event 11,  3, SPRITE_GYM_GUY, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, PERSONTYPE_COMMAND, jumptextfaceplayer, CeladonGymGuyText, -1
	object_event  2,  8, SPRITE_GRAMPS, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_GREEN, PERSONTYPE_SCRIPT, 0, GrampsScript_0x72190, -1

PokefanMScript_0x72123:
	showtextfaceplayer UnknownText_0x72215
	turnobject LAST_TALKED, LEFT
	end

TeacherScript_0x7212e:
	showtextfaceplayer UnknownText_0x72242
	turnobject LAST_TALKED, RIGHT
	end

FishingGuruScript_0x72139:
	showtextfaceplayer UnknownText_0x72295
	turnobject LAST_TALKED, RIGHT
	end

FisherScript_0x72144:
	faceplayer
	opentext
	checkevent EVENT_GOT_COINS_FROM_GAMBLER_AT_CELADON
	iftrue .FisherOffer
	writetext UnknownText_0x722dc
	buttonsound
	checkitem COIN_CASE
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
	writetext UnknownText_0x72345
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
	writetext UnknownText_0x7238a
	waitbutton
	closetext
	turnobject LAST_TALKED, LEFT
	end

UnknownScript_0x72184:
	writetext UnknownText_0x723d9
	waitbutton
	closetext
	turnobject LAST_TALKED, LEFT
	end

GrampsScript_0x72190:
	showtextfaceplayer UnknownText_0x724ad
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
	writetext UnknownText_0x72567
	waitbutton
	special Special_CardFlip
	endtext

UnknownText_0x721d0:
	text "Welcome!"

	para "You may exchange"
	line "your coins for"

	para "fabulous prizes"
	line "next door."
	done

UnknownText_0x72215:
	text "The slot machines"
	line "are all state of"
	cont "the art."
	done

UnknownText_0x72242:
	text "It's this machine"
	line "I want."

	para "It cleaned me out"
	line "yesterday, so it"

	para "should pay out"
	line "today."
	done

UnknownText_0x72295:
	text "I think this slot"
	line "machine will pay"
	cont "out…"

	para "The odds vary"
	line "among machines."
	done

UnknownText_0x722dc:
	text "Gahahaha!"

	para "The coins just"
	line "keep popping out!"

	para "Hm? What, kid? You"
	line "want to play?"

	para "I'll share my luck"
	line "with you!"
	done

UnknownText_0x72345:
	text "Gahahaha!"

	para "It makes me feel"
	line "good to do nice"

	para "things for other"
	line "people!"
	done

UnknownText_0x7238a:
	text "Hey, you don't"
	line "have a Coin Case."

	para "How am I supposed"
	line "to give you any"
	cont "coins, kid?"
	done

UnknownText_0x723d9:
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

UnknownText_0x724ad:
	text "Hmmm… The odds are"
	line "surely better for"

	para "Pikachu's line,"
	line "but… What to do?"
	done

UnknownText_0x724f3:
	text "Hey!"

	para "Underneath this"
	line "poster…"

	para "There's nothing!"
	done

UnknownText_0x72521:
	text "Hey!"

	para "Underneath this"
	line "poster…"

	para "There's nothing!"
	done

UnknownText_0x7254f:
	text "There's a lighter"
	line "here."
	done

UnknownText_0x72567:
	text "A can of soda…"

	para "Someone must be"
	line "coming back…"

	para "Huh? It's empty!"
	done
