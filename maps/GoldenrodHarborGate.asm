GoldenrodHarborGate_MapScriptHeader:
	db 0 ; map triggers

	db 0 ; map callbacks

	db 4 ; warps
	warp_def 4, 0, 1, GOLDENROD_HARBOR
	warp_def 5, 0, 2, GOLDENROD_HARBOR
	warp_def 4, 9, 16, GOLDENROD_CITY
	warp_def 5, 9, 17, GOLDENROD_CITY

	db 0 ; xy triggers

	db 0 ; signposts

	db 1 ; person events
	person_event SPRITE_OFFICER, 2, 5, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_COMMAND, jumptextfaceplayer, GoldenrodHarborGateOfficerText, -1

GoldenrodHarborGateOfficerText:
	text "If your #mon"
	line "knows how to Surf,"

	para "you can head north"
	line "to Olivine City."
	done
