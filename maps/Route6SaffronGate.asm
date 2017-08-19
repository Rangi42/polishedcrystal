Route6SaffronGate_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

Route6SaffronGate_MapEventHeader:

.Warps: db 4
	warp_def 0, 4, 12, SAFFRON_CITY
	warp_def 0, 5, 13, SAFFRON_CITY
	warp_def 7, 4, 2, ROUTE_6
	warp_def 7, 5, 2, ROUTE_6

.XYTriggers: db 0

.Signposts: db 0

.PersonEvents: db 1
	person_event SPRITE_OFFICER, 4, 0, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, OfficerScript_0x1926ea, -1

OfficerScript_0x1926ea:
	checkevent EVENT_RETURNED_MACHINE_PART
	iftrue_jumptextfaceplayer UnknownText_0x1927cb
	thistextfaceplayer

	text "Welcome to Saffron"
	line "City, home of the"
	cont "Magnet Train!"

	para "…That's what I'd"
	line "normally say, but"

	para "the Magnet Train"
	line "isn't running now."

	para "It's not getting"
	line "any electricity"

	para "because there's"
	line "something wrong"

	para "with the Power"
	line "Plant."
	done

UnknownText_0x1927cb:
	text "The Magnet Train"
	line "is the most famous"

	para "thing about Saf-"
	line "fron."
	done
