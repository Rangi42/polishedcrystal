HauntedRadioTower6F_MapScriptHeader:
	db 0 ; map triggers

	db 0 ; map callbacks

	db 1 ; warps
	warp_def 17, 6, 2, HAUNTED_RADIO_TOWER_5F

	db 0 ; xy triggers

	db 0 ; signposts

	db 0 ; person events

; setflag ENGINE_EXORCISED_LAV_RADIO_TOWER
; setevent EVENT_EXORCISED_LAV_RADIO_TOWER
; clearevent EVENT_LAV_RADIO_TOWER_POPULATION
