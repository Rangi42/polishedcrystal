GoldenrodHarborGate_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 4 ; warp events
	warp_event  0,  4, GOLDENROD_HARBOR, 1
	warp_event  0,  5, GOLDENROD_HARBOR, 2
	warp_event  9,  4, GOLDENROD_CITY, 16
	warp_event  9,  5, GOLDENROD_CITY, 17

	db 0 ; coord events

	db 0 ; bg events

	db 1 ; object events
	object_event  5,  2, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, PERSONTYPE_COMMAND, jumptextfaceplayer, GoldenrodHarborGateOfficerText, -1

GoldenrodHarborGateOfficerText:
	text "If your #mon"
	line "knows how to Surf,"

	para "you can head north"
	line "to Olivine City."
	done
