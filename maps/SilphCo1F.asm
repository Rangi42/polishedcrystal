const_value set 2
	const SILPHCO1F_RECEPTIONIST
	const SILPHCO1F_OFFICER

SilphCo1F_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 1

	; callbacks

	dbw MAPCALLBACK_SPRITES, .MoveOfficerCallback

.MoveOfficerCallback:
	checkevent EVENT_RETURNED_MACHINE_PART
	iffalse .Nothing
	moveperson SILPHCO1F_OFFICER, 14, 1
.Nothing
	return

SilphCoReceptionist:
	jumptextfaceplayer SilphCoReceptionistText

OfficerScript_0x18abe8:
	faceplayer
	opentext
	checkevent EVENT_RETURNED_MACHINE_PART
	iftrue .OfficerScriptAfterPowerRestored
	writetext UnknownText_0x18ac36
	waitbutton
	closetext
	end

.OfficerScriptAfterPowerRestored
	writetext UnknownText_0x18aca8
	waitbutton
	closetext
	end

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

SilphCo1F_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 3
	warp_def $7, $2, 7, SAFFRON_CITY
	warp_def $7, $3, 7, SAFFRON_CITY
	warp_def $0, $d, 1, SILPH_CO_2F

.XYTriggers:
	db 0

.Signposts:
	db 0

.PersonEvents:
	db 2
	person_event SPRITE_RECEPTIONIST, 2, 4, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, SilphCoReceptionist, -1
	person_event SPRITE_OFFICER, 1, 13, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, OfficerScript_0x18abe8, -1
