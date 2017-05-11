const_value set 2
	const BILLSHOUSE_BILL

BillsHouse_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

BillsHouseBill:
	faceplayer
	opentext
	checkevent EVENT_BEAT_POKEMANIAC_BILL
	iftrue AfterBillBattleScript
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

BillsHousePCScript:
	jumptext BillsHousePCText

PokemonJournalBillScript:
	setflag ENGINE_READ_BILL_JOURNAL
	jumptext PokemonJournalBillText

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

	para "Still, I'd sure"
	line "love to see them…"
	done

PokemaniacBillSeenText:
	text "You caught all"
	line "three of the"
	cont "legendary beasts?"

	para "That's so cool,"
	line "<PLAYER>!"

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

BillsHousePCText:
	text "There's a spinning"
	line "3D model of a"
	cont "Porygon."
	done

PokemonJournalBillText:
	text "#mon Journal"

	para "Special Feature:"
	line "#Maniac Bill!"

	para "Bill invented the"
	line "#mon Storage"
	cont "System to hold his"

	para "own vast #mon"
	line "collection."

	para "Apparently, the"
	line "first one he"

	para "caught was an"
	line "Abra."
	done

BillsHouse_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 2
	warp_def $7, $2, 1, CERULEAN_CAPE
	warp_def $7, $3, 1, CERULEAN_CAPE

.XYTriggers:
	db 0

.Signposts:
	db 3
	signpost 1, 5, SIGNPOST_READ, BillsHousePCScript
	signpost 1, 6, SIGNPOST_READ, PokemonJournalBillScript
	signpost 1, 7, SIGNPOST_READ, PokemonJournalBillScript

.PersonEvents:
	db 1
	person_event SPRITE_BILL, 3, 2, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, BillsHouseBill, EVENT_NEVER_MET_BILL
