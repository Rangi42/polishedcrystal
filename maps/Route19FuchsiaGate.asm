Route19FuchsiaGate_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 4 ; warp events
	warp_event  4,  0, FUCHSIA_CITY, 9
	warp_event  5,  0, FUCHSIA_CITY, 10
	warp_event  4,  7, ROUTE_19, 1
	warp_event  5,  7, ROUTE_19, 1

	db 0 ; coord events

	db 0 ; bg events

	db 1 ; object events
	object_event  0,  4, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_BLUE, PERSONTYPE_SCRIPT, 0, OfficerScript_0x1ab3f6, -1

OfficerScript_0x1ab3f6:
	checkevent EVENT_CINNABAR_ROCKS_CLEARED
	iftrue_jumptextfaceplayer UnknownText_0x1ab48a
	thistextfaceplayer

	text "Cinnabar's volcano"
	line "erupted."

	para "It hurled boulders"
	line "that cut off Route"
	cont "19 indefinitely."

	para "I wonder if the"
	line "people of Cinnabar"
	cont "are safe…"
	done

UnknownText_0x1ab48a:
	text "No Cinnabar citi-"
	line "zens were injured"

	para "by the eruption."
	line "That's great!"
	done
