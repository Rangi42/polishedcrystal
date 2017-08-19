CeladonGameCorner_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

CeladonGameCorner_MapEventHeader:

.Warps: db 2
	warp_def 13, 14, 6, CELADON_CITY
	warp_def 13, 15, 6, CELADON_CITY

.XYTriggers: db 0

.Signposts: db 38
	signpost 6, 1, SIGNPOST_READ, MapCeladonGameCornerSignpost11Script
	signpost 7, 1, SIGNPOST_READ, MapCeladonGameCornerSignpost11Script
	signpost 8, 1, SIGNPOST_READ, MapCeladonGameCornerSignpost11Script
	signpost 9, 1, SIGNPOST_READ, MapCeladonGameCornerSignpost11Script
	signpost 10, 1, SIGNPOST_READ, MapCeladonGameCornerSignpost11Script
	signpost 11, 1, SIGNPOST_LEFT, MapCeladonGameCornerSignpost11Script
	signpost 6, 6, SIGNPOST_READ, MapCeladonGameCornerSignpost11Script
	signpost 7, 6, SIGNPOST_READ, MapCeladonGameCornerSignpost11Script
	signpost 8, 6, SIGNPOST_READ, MapCeladonGameCornerSignpost11Script
	signpost 9, 6, SIGNPOST_READ, MapCeladonGameCornerSignpost9Script
	signpost 10, 6, SIGNPOST_READ, MapCeladonGameCornerSignpost11Script
	signpost 11, 6, SIGNPOST_RIGHT, MapCeladonGameCornerSignpost11Script
	signpost 6, 7, SIGNPOST_READ, MapCeladonGameCornerSignpost35Script
	signpost 7, 7, SIGNPOST_READ, MapCeladonGameCornerSignpost35Script
	signpost 8, 7, SIGNPOST_READ, MapCeladonGameCornerSignpost35Script
	signpost 9, 7, SIGNPOST_READ, MapCeladonGameCornerSignpost35Script
	signpost 10, 7, SIGNPOST_READ, MapCeladonGameCornerSignpost16Script
	signpost 11, 7, SIGNPOST_LEFT, MapCeladonGameCornerSignpost35Script
	signpost 6, 12, SIGNPOST_READ, MapCeladonGameCornerSignpost35Script
	signpost 7, 12, SIGNPOST_READ, MapCeladonGameCornerSignpost35Script
	signpost 8, 12, SIGNPOST_READ, MapCeladonGameCornerSignpost35Script
	signpost 9, 12, SIGNPOST_READ, MapCeladonGameCornerSignpost35Script
	signpost 10, 12, SIGNPOST_READ, MapCeladonGameCornerSignpost35Script
	signpost 11, 12, SIGNPOST_RIGHT, MapCeladonGameCornerSignpost35Script
	signpost 6, 13, SIGNPOST_READ, MapCeladonGameCornerSignpost35Script
	signpost 7, 13, SIGNPOST_READ, MapCeladonGameCornerSignpost35Script
	signpost 8, 13, SIGNPOST_READ, MapCeladonGameCornerSignpost35Script
	signpost 9, 13, SIGNPOST_READ, MapCeladonGameCornerSignpost35Script
	signpost 10, 13, SIGNPOST_READ, MapCeladonGameCornerSignpost35Script
	signpost 11, 13, SIGNPOST_LEFT, MapCeladonGameCornerSignpost35Script
	signpost 6, 18, SIGNPOST_READ, MapCeladonGameCornerSignpost35Script
	signpost 7, 18, SIGNPOST_READ, MapCeladonGameCornerSignpost35Script
	signpost 8, 18, SIGNPOST_JUMPTEXT, UnknownText_0x7254f
	signpost 9, 18, SIGNPOST_READ, MapCeladonGameCornerSignpost35Script
	signpost 10, 18, SIGNPOST_READ, MapCeladonGameCornerSignpost35Script
	signpost 11, 18, SIGNPOST_RIGHT, MapCeladonGameCornerSignpost35Script
	signpost 0, 15, SIGNPOST_JUMPTEXT, UnknownText_0x724f3
	signpost 0, 9, SIGNPOST_JUMPTEXT, UnknownText_0x72521

.PersonEvents: db 8
	person_event SPRITE_CLERK, 2, 5, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_COMMAND, jumpstd, gamecornercoinvendor, -1
	person_event SPRITE_RECEPTIONIST, 2, 3, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x721d0, -1
	person_event SPRITE_POKEFAN_M, 10, 14, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, PokefanMScript_0x72123, -1
	person_event SPRITE_TEACHER, 7, 17, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, TeacherScript_0x7212e, -1
	person_event SPRITE_FISHING_GURU, 7, 11, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_SCRIPT, 0, FishingGuruScript_0x72139, -1
	person_event SPRITE_FISHER, 10, 8, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, FisherScript_0x72144, -1
	person_event SPRITE_GYM_GUY, 3, 11, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_COMMAND, jumptextfaceplayer, CeladonGymGuyText, -1
	person_event SPRITE_GRAMPS, 8, 2, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_SCRIPT, 0, GrampsScript_0x72190, -1

PokefanMScript_0x72123:
	showtextfaceplayer UnknownText_0x72215
	spriteface LAST_TALKED, LEFT
	end

TeacherScript_0x7212e:
	showtextfaceplayer UnknownText_0x72242
	spriteface LAST_TALKED, RIGHT
	end

FishingGuruScript_0x72139:
	showtextfaceplayer UnknownText_0x72295
	spriteface LAST_TALKED, RIGHT
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
	if_equal $0, UnknownScript_0x72184
	stringtotext .coinname, $1
	scall .UnknownScript_0x72172
	givecoins 18
	setevent EVENT_GOT_COINS_FROM_GAMBLER_AT_CELADON
.FisherOffer:
	writetext FisherOfferText
	yesorno
	iffalse .UnknownScript_0x72169
	checkcoins 50
	if_equal $2, .FisherNotEnough
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
	spriteface LAST_TALKED, LEFT
	end

.UnknownScript_0x72172:
	jumpstd receiveitem
	end

.coinname
	db "Coin@"

UnknownScript_0x7217b:
	writetext UnknownText_0x7238a
	waitbutton
	closetext
	spriteface LAST_TALKED, LEFT
	end

UnknownScript_0x72184:
	writetext UnknownText_0x723d9
	waitbutton
	closetext
	spriteface LAST_TALKED, LEFT
	end

GrampsScript_0x72190:
	showtextfaceplayer UnknownText_0x724ad
	spriteface LAST_TALKED, LEFT
	end

MapCeladonGameCornerSignpost35Script:
	random $6
	if_equal $0, MapCeladonGameCornerSignpost16Script
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
