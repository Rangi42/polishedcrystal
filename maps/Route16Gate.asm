Route16Gate_MapScriptHeader:
	db 0 ; map triggers

	db 0 ; map callbacks

Route16Gate_MapEventHeader:
	db 4 ; warps
	warp_def 4, 0, 2, ROUTE_16_NORTHWEST
	warp_def 5, 0, 3, ROUTE_16_NORTHWEST
	warp_def 4, 9, 3, ROUTE_16_NORTHEAST
	warp_def 5, 9, 4, ROUTE_16_NORTHEAST

	db 0 ; xy triggers

	db 0 ; signposts

	db 1 ; person events
	person_event SPRITE_OFFICER, 1, 5, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_COMMAND, jumptextfaceplayer, Route16GateOfficerText, -1

	end

Route16GateOfficerText:
	text "Route 16 is a bit"
	line "untamed."

	para "You'll need HM"
	line "moves to get"
	cont "through."
	done
