const_value set 2
	const GOLDENRODBILLSHOUSE_BILL
	const GOLDENRODBILLSHOUSE_POKEFAN_F
	const GOLDENRODBILLSHOUSE_TWIN

GoldenrodBillsHouse_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

BillsHouseBill:
	faceplayer
	opentext
	checkevent EVENT_BEAT_POKEMANIAC_BILL
	iftrue AfterBillBattleScript
	checkevent EVENT_GOT_EEVEE
	iftrue BattleBillScript
	writetext UnknownText_0x54c74
	yesorno
	iffalse UnknownScript_0x54c19
	writetext UnknownText_0x54d3f
	buttonsound
	waitsfx
	checkcode VAR_PARTYCOUNT
	if_equal $6, UnknownScript_0x54c13
	writetext UnknownText_0x54dae
	playsound SFX_CAUGHT_MON
	waitsfx
	givepoke EEVEE, 20
	setevent EVENT_GOT_EEVEE
	writetext UnknownText_0x54dc1
	waitbutton
	closetext
	end

UnknownScript_0x54c13:
	writetext UnknownText_0x54e02
	waitbutton
	closetext
	end

UnknownScript_0x54c19:
	writetext UnknownText_0x54e2d
	waitbutton
	closetext
	end

BattleBillScript:
	writetext BillEeveelutionLegendText
	waitbutton
	special SpecialBeastsCheck
	iffalse DontBattleBillScript
	writetext PokemaniacBillSeenText
	waitbutton
	closetext
	winlosstext PokemaniacBillBeatenText, 0
	loadtrainer BILL_T, 1
	startbattle
	reloadmapafterbattle
	setevent EVENT_BEAT_POKEMANIAC_BILL
	opentext
AfterBillBattleScript:
	writetext PokemaniacBillAfterText
	waitbutton
DontBattleBillScript:
	closetext
	end

BillsMom:
	faceplayer
	opentext
	checkevent EVENT_MET_BILL
	iffalse UnknownScript_0x54c33
	writetext UnknownText_0x54ea8
	waitbutton
	closetext
	end

UnknownScript_0x54c33:
	writetext UnknownText_0x54f4e
	waitbutton
	closetext
	end

BillsSister:
	faceplayer
	opentext
	checkcellnum PHONE_BILL
	iftrue UnknownScript_0x54c58
	writetext UnknownText_0x54f9e
	askforphonenumber PHONE_BILL
	if_equal $1, UnknownScript_0x54c64
	if_equal $2, UnknownScript_0x54c5e
	waitsfx
	addcellnum PHONE_BILL
	writetext UnknownText_0x54fd9
	playsound SFX_REGISTER_PHONE_NUMBER
	waitsfx
	buttonsound
UnknownScript_0x54c58: ;0x54c58
	writetext UnknownText_0x55069
	waitbutton
	closetext
	end

UnknownScript_0x54c5e:
	writetext UnknownText_0x54ff3
	waitbutton
	closetext
	end

UnknownScript_0x54c64:
	writetext UnknownText_0x55046
	buttonsound
	jump UnknownScript_0x54c5e

BillsHouseBookshelf1:
	jumpstd picturebookshelf

BillsHouseBookshelf2:
	jumpstd magazinebookshelf

BillsHouseRadio:
	jumpstd radio2

UnknownText_0x54c74:
	text "Bill: Hi, <PLAYER>!"
	line "Do us a favor and"
	cont "take this Eevee."

	para "It came over when"
	line "I was adjusting"
	cont "the Time Capsule."

	para "Someone has to"
	line "take care of it,"

	para "but I don't like"
	line "being outside."

	para "Can I count on you"
	line "to play with it,"
	cont "<PLAYER>?"
	done

UnknownText_0x54d3f:
	text "Bill: I knew you'd"
	line "come through!"

	para "Way to go! You're"
	line "the real deal!"

	para "OK, I'm counting"
	line "on you."

	para "Take good care of"
	line "it!"
	done

UnknownText_0x54dae:
	text "<PLAYER> received"
	line "Eevee!"
	done

UnknownText_0x54dc1:
	text "Bill: Prof.Elm"
	line "claims Eevee may"

	para "evolve in new and"
	line "unknown ways."
	done

UnknownText_0x54e02:
	text "Whoa, wait. You"
	line "can't carry any"
	cont "more #mon."
	done

UnknownText_0x54e2d:
	text "Oh… Now what to"
	line "do?"
	done

BillEeveelutionLegendText:
	text "Bill: Eevee is"
	line "such a fascinating"
	cont "#mon."

	para "Some say that the"
	line "three legendary"

	para "beasts of Johto"
	line "were once three"

	para "#mon that"
	line "evolve from Eevee."

	para "But that might be"
	line "only a rumor."
	done

PokemaniacBillSeenText:
	text "You caught all"
	line "three of the"
	cont "legendary beasts?"

	para "That's so cool,"
	line "<PLAY_G>!"

	para "Do you think they"
	line "were once related"
	cont "to Eevee?"

	para "Oh man, now I have"
	line "to show you my"
	cont "team!"

	para "You can compare"
	line "the three legends"

	para "you battled to"
	line "my own #mon!"
	done

PokemaniacBillBeatenText:
	text "Yeehah!"
	done

PokemaniacBillAfterText:
	text "That was one rad"
	line "battle!"

	para "Any #Maniac"
	line "would be thrilled"

	para "to see what"
	line "you've caught."
	done

UnknownText_0x54ea8:
	text "Oh, you collect"
	line "#mon? My son"
	cont "Bill is an expert."

	para "He just got called"
	line "to the #mon"

	para "Center in Ecruteak"
	line "City."

	para "My husband went"
	line "off to the Game"

	para "Corner without"
	line "being called…"
	done

UnknownText_0x54f4e:
	text "My husband was"
	line "once known as a"

	para "#Maniac."
	line "Bill must have"

	para "taken after his"
	line "father."

	para "But now my husband"
	line "won't work. He"

	para "just goofs off"
	line "all day long."
	done

UnknownText_0x54f9e:
	text "Are you a trainer?"

	para "I've got a useful"
	line "phone number for"
	cont "you."
	done

UnknownText_0x54fd9:
	text "<PLAYER> recorded"
	line "Bill's number."
	done

UnknownText_0x54ff3:
	text "My brother made"
	line "the PC #mon"
	cont "storage system."

	para "I was going to"
	line "give you Bill's"
	cont "number…"
	done

UnknownText_0x55046:
	text "You can't record"
	line "any more numbers."
	done

UnknownText_0x55069:
	text "My big brother"
	line "Bill made the PC"

	para "#mon storage"
	line "system."
	done

GoldenrodBillsHouse_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 2
	warp_def $7, $2, 4, GOLDENROD_CITY
	warp_def $7, $3, 4, GOLDENROD_CITY

.XYTriggers:
	db 0

.Signposts:
	db 3
	signpost 1, 0, SIGNPOST_READ, BillsHouseBookshelf2
	signpost 1, 1, SIGNPOST_READ, BillsHouseBookshelf1
	signpost 1, 7, SIGNPOST_READ, BillsHouseRadio

.PersonEvents:
	db 3
	person_event SPRITE_BILL, 3, 2, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, BillsHouseBill, EVENT_MET_BILL
	person_event SPRITE_POKEFAN_F, 3, 5, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, BillsMom, -1
	person_event SPRITE_TWIN, 4, 5, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_SCRIPT, 0, BillsSister, -1
