SinjohRuins_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 2 ; warp events
	warp_event 5, 7, 1, MYSTRI_STAGE
	warp_event 13, 21, 1, SINJOH_RUINS_HOUSE

	db 0 ; coord events

	db 1 ; bg events
	bg_event 7, 8, SIGNPOST_JUMPTEXT, SinjohRuinsSignpostText

	db 0 ; object events

SinjohRuinsSignpostText:
	text "The Sinjoh Ruins"
	done
