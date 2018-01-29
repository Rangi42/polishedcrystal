HauntedRadioTower4F_MapScriptHeader:
	db 0 ; map triggers

	db 0 ; map callbacks

HauntedRadioTower4F_MapEventHeader:
	db 2 ; warps
	warp_def 0, 15, 2, HAUNTED_RADIO_TOWER_3F
	warp_def 0, 8, 1, HAUNTED_RADIO_TOWER_5F

	db 0 ; xy triggers

	db 0 ; signposts

	db 0 ; person events
