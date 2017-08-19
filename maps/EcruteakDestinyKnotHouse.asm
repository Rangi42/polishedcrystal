EcruteakDestinyKnotHouse_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

EcruteakDestinyKnotHouse_MapEventHeader:

.Warps: db 2
	warp_def 7, 3, 17, ECRUTEAK_CITY
	warp_def 7, 4, 17, ECRUTEAK_CITY

.XYTriggers: db 0

.Signposts: db 1
	signpost 1, 2, SIGNPOST_JUMPSTD, radio2

.PersonEvents: db 2
	person_event SPRITE_COOLTRAINER_F, 4, 5, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, EcruteakDestinyKnotHouseCooltrainerFScript, -1
	person_event SPRITE_RICH_BOY, 3, 2, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_COMMAND, trade, TRADE_WITH_HARI_FOR_DODUO, -1

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
