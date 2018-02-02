EcruteakDestinyKnotHouse_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 2 ; warp events
	warp_event  3,  7, ECRUTEAK_CITY, 17
	warp_event  4,  7, ECRUTEAK_CITY, 17

	db 0 ; coord events

	db 1 ; bg events
	bg_event  2,  1, SIGNPOST_JUMPSTD, radio2

	db 2 ; object events
	object_event  5,  4, SPRITE_COOLTRAINER_F, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_RED, PERSONTYPE_SCRIPT, 0, EcruteakDestinyKnotHouseCooltrainerFScript, -1
	object_event  2,  3, SPRITE_RICH_BOY, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_BLUE, PERSONTYPE_COMMAND, trade, TRADE_WITH_HARI_FOR_DODUO, -1

EcruteakDestinyKnotHouseCooltrainerFScript:
	checkevent EVENT_GOT_DESTINY_KNOT_FROM_ECRUTEAK
	iftrue_jumptextfaceplayer .Text4
	faceplayer
	opentext
	writetext .Text1
	buttonsound
	special SpecialBeastsCheck
	iffalse_jumpopenedtext .Text2
	special SpecialBirdsCheck
	iffalse_jumpopenedtext .Text2
	special SpecialDuoCheck
	iffalse_jumpopenedtext .Text2
	writetext .Text3
	verbosegiveitem DESTINY_KNOT
	iffalse_endtext
	thisopenedtext

.Text4:
	text "The red string of"
	line "fate ties you to"

	para "the legendary"
	line "#mon…"

	para "Are you some kind"
	line "of Chosen One?"
	done

.Text1:
	text "Two mighty bird"
	line "#mon of Johto,"

	para "each guarding a"
	line "trio of legendary"
	cont "#mon."

	para "Legends within"
	line "legends…"
	done

.Text2:
	text "What if a trainer"
	line "were to catch all"
	cont "of them?"

	para "What an unlikely"
	line "destiny!"
	done

.Text3:
	text "What? You've seen"
	line "them? And you even"
	cont "caught them?!"

	para "Let me see your"
	line "#dex… Wow!"

	para "It must have been"
	line "your destiny."

	para "Here, you should"
	line "have this."
	done
