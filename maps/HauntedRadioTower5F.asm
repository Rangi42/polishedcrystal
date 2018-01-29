HauntedRadioTower5F_MapScriptHeader:
	db 0 ; map triggers

	db 0 ; map callbacks

HauntedRadioTower5F_MapEventHeader:
	db 2 ; warps
	warp_def 10, 15, 2, HAUNTED_RADIO_TOWER_4F
	warp_def 17, 6, 1, HAUNTED_RADIO_TOWER_6F

	db 0 ; xy triggers

	db 0 ; signposts

	db 0 ; person events
