TreeMons:
; entries correspond to TREEMON_SET_* constants
	table_width 2
	dw TreeMonSet_City
	dw TreeMonSet_Canyon
	dw TreeMonSet_Town
	dw TreeMonSet_Route
	dw TreeMonSet_Kanto
	dw TreeMonSet_Lake
	dw TreeMonSet_Forest
	dw TreeMonSet_Apricorns
	dw TreeMonSet_NoisyForest
	dw TreeMonSet_Rock
	assert_table_length NUM_TREEMON_SETS
	dw TreeMonSet_City ; unused

; Two tables each (normal, rare).

MACRO tree_mon
; %, species, level
	db \1
	if _NARG == 4
		dp \2, \3
		shift
	else
		dp \2
	endc
	db \3
ENDM

TreeMonSet_City:
TreeMonSet_Canyon:
	tree_mon 80, SPEAROW,    10
	tree_mon 20, AIPOM,      10
	db -1
	; rare
	tree_mon 50, SPEAROW,    10
	tree_mon 30, HERACROSS,  10
	tree_mon 20, AIPOM,      10
	db -1

TreeMonSet_Town:
	tree_mon 65, SPEAROW,    10
	tree_mon 15, EKANS,      10
	tree_mon 20, AIPOM,      10
	db -1
	; rare
	tree_mon 60, SPEAROW,    10
	tree_mon 30, HERACROSS,  10
	tree_mon 10, MEOWTH,     10
	db -1

TreeMonSet_Route:
	tree_mon 50, HOOTHOOT,   10
	tree_mon 15, SPINARAK,   10
	tree_mon 15, LEDYBA,     10
	tree_mon 20, EXEGGCUTE,  10
	db -1
	; rare
	tree_mon 40, MURKROW,    10
	tree_mon 40, PINECO,     10
	tree_mon 20, EXEGGCUTE,  10
	db -1

TreeMonSet_Kanto:
	tree_mon 65, HOOTHOOT,   10
	tree_mon 15, EKANS,      10
	tree_mon 20, EXEGGCUTE,  10
	db -1
	; rare
	tree_mon 40, MURKROW,    10
	tree_mon 40, PINECO,     10
	tree_mon 20, EXEGGCUTE,  10
	db -1

TreeMonSet_Lake:
	tree_mon 65, HOOTHOOT,   10
	tree_mon 15, VENONAT,    10
	tree_mon 20, EXEGGCUTE,  10
	db -1
	; rare
	tree_mon 50, HOOTHOOT,   10
	tree_mon 30, PINECO,     10
	tree_mon 20, EXEGGCUTE,  10
	db -1

TreeMonSet_Forest:
	tree_mon 50, HOOTHOOT,   10
	tree_mon 30, PINECO,     10
	tree_mon 10, NOCTOWL,    10
	tree_mon  5, BUTTERFREE, 10
	tree_mon  5, BEEDRILL,   10
	db -1
	; rare
	tree_mon 60, HOOTHOOT,   10
	tree_mon 15, CATERPIE,   10
	tree_mon 15, WEEDLE,     10
	tree_mon  5, METAPOD,    10
	tree_mon  5, KAKUNA,     10
	db -1

TreeMonSet_Apricorns:
	tree_mon 50, SPEAROW,               10
	tree_mon 20, EKANS,                 10
	tree_mon 20, AIPOM,                 10
	tree_mon 10, VOLTORB, HISUIAN_FORM, 10
	db -1
	; rare
	tree_mon 40, SPEAROW,               10
	tree_mon 20, VOLTORB, HISUIAN_FORM, 10
	tree_mon 20, HERACROSS,             10
	tree_mon 20, MEOWTH,                10
	db -1

TreeMonSet_NoisyForest:
	tree_mon 60, PINECO,                  LEVEL_FROM_BADGES - 3
	tree_mon  5, FORRETRESS,              LEVEL_FROM_BADGES + 2
	tree_mon 35, ELECTRODE, HISUIAN_FORM, LEVEL_FROM_BADGES + 0
	db -1
	; rare
	tree_mon 60, ELECTRODE, HISUIAN_FORM, LEVEL_FROM_BADGES + 0
	tree_mon 30, PINECO,                  LEVEL_FROM_BADGES - 2
	tree_mon 10, FORRETRESS,              LEVEL_FROM_BADGES + 3
	db -1

TreeMonSet_Rock:
	tree_mon 70, KRABBY,     15
	tree_mon 25, GEODUDE,    15
	tree_mon  5, SHUCKLE,    15
	db -1
