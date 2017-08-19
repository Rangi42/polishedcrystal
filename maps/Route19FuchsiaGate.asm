Route19FuchsiaGate_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

Route19FuchsiaGate_MapEventHeader:

.Warps: db 4
	warp_def 0, 4, 9, FUCHSIA_CITY
	warp_def 0, 5, 10, FUCHSIA_CITY
	warp_def 7, 4, 1, ROUTE_19
	warp_def 7, 5, 1, ROUTE_19

.XYTriggers: db 0

.Signposts: db 0

.PersonEvents: db 1
	person_event SPRITE_OFFICER, 4, 0, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, OfficerScript_0x1ab3f6, -1

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
