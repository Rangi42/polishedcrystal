GoldenrodHarborGate_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

GoldenrodHarborGate_MapEventHeader:

.Warps: db 4
	warp_def 4, 0, 1, GOLDENROD_HARBOR
	warp_def 5, 0, 2, GOLDENROD_HARBOR
	warp_def 4, 9, 16, GOLDENROD_CITY
	warp_def 5, 9, 17, GOLDENROD_CITY

.XYTriggers: db 0

.Signposts: db 0

.PersonEvents: db 1
	person_event SPRITE_OFFICER, 2, 5, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_COMMAND, jumptextfaceplayer, GoldenrodHarborGateOfficerText, -1

GoldenrodHarborGateOfficerText:
	text "If your #mon"
	line "knows how to Surf,"

	para "you can head north"
	line "to Olivine City."
	done
