InitializeHiddenGrotto::
	ld hl, HiddenGrottoData
	ld bc, HiddenGrotto2 - HiddenGrotto1
	ld a, [CurHiddenGrotto]
	dec a ; since hidden grotto IDs start at 1
	call AddNTimes
	ld a, [hl]
	ld [BackupWarpNumber], a
; TODO: if this grotto is not marked in HiddenGrottoFlags, mark it and
; spawn an item or Pokémon
; (also need to unmark grottoes randomly somehow—daily or while walking?)
	ret

HiddenGrottoData:
	; warp id, 1% item id, 15% mon, 4% mon, 1% mon
HiddenGrotto1:
	db 4, SUN_STONE, SNUBBULL, YANMA, YANMA ; HIDDENGROTTO_ROUTE_35
HiddenGrotto2:
	db 2, WATER_STONE, FLAAFFY, GIRAFARIG, FARFETCH_D ; HIDDENGROTTO_LAKE_OF_RAGE_SOUTH
