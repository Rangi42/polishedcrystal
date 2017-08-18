HauntedRadioTower6F_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

HauntedRadioTower6F_MapEventHeader:

.Warps: db 1
	warp_def 17, 6, 2, HAUNTED_RADIO_TOWER_5F

.XYTriggers: db 0

.Signposts: db 0

.PersonEvents: db 0

; setflag ENGINE_EXORCISED_LAV_RADIO_TOWER
; setevent EVENT_EXORCISED_LAV_RADIO_TOWER
; clearevent EVENT_LAV_RADIO_TOWER_POPULATION
