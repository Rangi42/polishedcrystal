HauntedRadioTower6F_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 1 ; warp events
	warp_event  6, 17, HAUNTED_RADIO_TOWER_5F, 2

	db 0 ; coord events

	db 0 ; bg events

	db 0 ; object events

; setflag ENGINE_EXORCISED_LAV_RADIO_TOWER
; setevent EVENT_EXORCISED_LAV_RADIO_TOWER
; clearevent EVENT_LAV_RADIO_TOWER_POPULATION
