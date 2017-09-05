Route43MahoganyGate_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

Route43MahoganyGate_MapEventHeader:

.Warps: db 4
	warp_def 0, 4, 1, ROUTE_43
	warp_def 0, 5, 2, ROUTE_43
	warp_def 7, 4, 5, MAHOGANY_TOWN
	warp_def 7, 5, 5, MAHOGANY_TOWN

.XYTriggers: db 0

.Signposts: db 0

.PersonEvents: db 1
	person_event SPRITE_OFFICER, 4, 0, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, OfficerScript_0x19ab0b, -1

OfficerScript_0x19ab0b:
	checkevent EVENT_CLEARED_ROCKET_HIDEOUT
	iftrue_jumptextfaceplayer UnknownText_0x19ab65
	thistextfaceplayer

	text "Only people headed"
	line "up to Lake of Rage"

	para "have been through"
	line "here lately."
	done

UnknownText_0x19ab65:
	text "Nobody goes up to"
	line "Lake of Rage these"
	cont "days."
	done
