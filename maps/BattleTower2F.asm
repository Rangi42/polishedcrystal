const_value set 2

BattleTower2F_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

BattleTower2F_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 1
	warp_def $1, $0, 4, BATTLE_TOWER_1F

.XYTriggers:
	db 0

.Signposts:
	db 0

.PersonEvents:
	db 0
