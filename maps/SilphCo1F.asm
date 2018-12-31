SilphCo1F_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 1
	dbw MAPCALLBACK_SPRITES, SilphCo1FMoveOfficerCallback

SilphCo1F_MapEventHeader:

.Warps: db 3
	warp_def 7, 2, 7, SAFFRON_CITY
	warp_def 7, 3, 7, SAFFRON_CITY
	warp_def 0, 13, 1, SILPH_CO_2F

.XYTriggers: db 0

.Signposts: db 0

.PersonEvents: db 4
	person_event SPRITE_OFFICER, 1, 13, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, OfficerScript_0x18abe8, -1
	person_event SPRITE_RECEPTIONIST, 2, 4, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_COMMAND, jumptextfaceplayer, SilphCoReceptionistText, -1
	person_event SPRITE_GENTLEMAN, 4, 11, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_COMMAND, jumptextfaceplayer, SilphCo1FGentlemanText, -1
	person_event SPRITE_COOLTRAINER_F, 2, 8, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_COMMAND, jumptextfaceplayer, SilphCo1FCooltrainerfText, -1

const_value set 1
	const SILPHCO1F_OFFICER

SilphCo1FMoveOfficerCallback:
	checkevent EVENT_RETURNED_MACHINE_PART
	iffalse .Nothing
	moveperson SILPHCO1F_OFFICER, 14, 1
.Nothing
	return

OfficerScript_0x18abe8:
	faceplayer
	opentext
	checkevent EVENT_RETURNED_MACHINE_PART
	iftrue .OfficerScriptAfterPowerRestored
	jumpopenedtext UnknownText_0x18ac36

.OfficerScriptAfterPowerRestored
	jumpopenedtext UnknownText_0x18aca8

SilphCoReceptionistText:
	text "Welcome. This is"
	line "Silph Co.'s Head"
	cont "Office Building."
	done

UnknownText_0x18ac36:
	text "Only employees are"
	line "permitted to go"
	cont "upstairs."

	para "The main power"
	line "isn't working,"

	para "and the CEO wants"
	line "high security in"

	para "case of an"
	line "emergency."

	para "We learned our"
	line "lesson about that"
	cont "three years ago."
	done

UnknownText_0x18aca8:
	text "You're responsible"
	line "for restoring the"
	cont "power supply?"

	para "Thank you! Now"
	line "R&D can continue."

	para "Feel free to take"
	line "a tour upstairs."
	done

SilphCo1FGentlemanText:
	text "I have an appoint-"
	line "ment with the"

	para "chief engineer"
	line "here at Silph Co."
	done

SilphCo1FCooltrainerfText:
	text "I'm trying to"
	line "pluck up the"
	cont "courage to ask"

	para "the receptionist"
	line "out on a date."

	para "Just as soon as"
	line "she's done on the"
	cont "phone…"
	done
