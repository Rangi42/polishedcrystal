TreeMons:
; entries correspond to TREEMON_SET_* constants
	table_width 2, TreeMons
	dw TreeMonSet_City
	dw TreeMonSet_Canyon
	dw TreeMonSet_Town
	dw TreeMonSet_Route
	dw TreeMonSet_Kanto
	dw TreeMonSet_Lake
	dw TreeMonSet_Forest
	dw TreeMonSet_Rock
	assert_table_length NUM_TREEMON_SETS
	dw TreeMonSet_City ; unused

; Two tables each (normal, rare).

tree_mon: MACRO
; %, species, level
	db \1
	dp \2
	db \3
ENDM

TreeMonSet_City:
TreeMonSet_Canyon:
	tree_mon 50, SPEAROW,    10
	tree_mon 15, SPEAROW,    10
	tree_mon 15, SPEAROW,    10
	tree_mon 10, AIPOM,      10
	tree_mon  5, AIPOM,      10
	tree_mon  5, AIPOM,      10
	db -1
	; rare
	tree_mon 50, SPEAROW,    10
	tree_mon 15, HERACROSS,  10
	tree_mon 15, HERACROSS,  10
	tree_mon 10, AIPOM,      10
	tree_mon  5, AIPOM,      10
	tree_mon  5, AIPOM,      10
	db -1

TreeMonSet_Town:
	tree_mon 50, SPEAROW,    10
	tree_mon 15, EKANS,      10
	tree_mon 15, SPEAROW,    10
	tree_mon 10, AIPOM,      10
	tree_mon  5, AIPOM,      10
	tree_mon  5, AIPOM,      10
	db -1
	; rare
	tree_mon 50, PIDGEY,     10
	tree_mon 15, HERACROSS,  10
	tree_mon 15, HERACROSS,  10
	tree_mon 10, PIDGEY,     10
	tree_mon  5, MEOWTH,     10
	tree_mon  5, MEOWTH,     10
	db -1

TreeMonSet_Route:
	tree_mon 50, HOOTHOOT,   10
	tree_mon 15, SPINARAK,   10
	tree_mon 15, LEDYBA,     10
	tree_mon 10, EXEGGCUTE,  10
	tree_mon  5, EXEGGCUTE,  10
	tree_mon  5, EXEGGCUTE,  10
	db -1
	; rare
	tree_mon 40, MURKROW,    10
	tree_mon 20, PINECO,     10
	tree_mon 20, PINECO,     10
	tree_mon 10, EXEGGCUTE,  10
	tree_mon  5, EXEGGCUTE,  10
	tree_mon  5, EXEGGCUTE,  10
	db -1

TreeMonSet_Kanto:
	tree_mon 50, HOOTHOOT,   10
	tree_mon 15, EKANS,      10
	tree_mon 15, HOOTHOOT,   10
	tree_mon 10, EXEGGCUTE,  10
	tree_mon  5, EXEGGCUTE,  10
	tree_mon  5, EXEGGCUTE,  10
	db -1
	; rare
	tree_mon 40, MURKROW,    10
	tree_mon 20, PINECO,     10
	tree_mon 20, PINECO,     10
	tree_mon 10, EXEGGCUTE,  10
	tree_mon  5, EXEGGCUTE,  10
	tree_mon  5, EXEGGCUTE,  10
	db -1

TreeMonSet_Lake:
	tree_mon 50, HOOTHOOT,   10
	tree_mon 15, VENONAT,    10
	tree_mon 15, HOOTHOOT,   10
	tree_mon 10, EXEGGCUTE,  10
	tree_mon  5, EXEGGCUTE,  10
	tree_mon  5, EXEGGCUTE,  10
	db -1
	; rare
	tree_mon 50, HOOTHOOT,   10
	tree_mon 15, PINECO,     10
	tree_mon 15, PINECO,     10
	tree_mon 10, EXEGGCUTE,  10
	tree_mon  5, EXEGGCUTE,  10
	tree_mon  5, EXEGGCUTE,  10
	db -1

TreeMonSet_Forest:
	tree_mon 50, HOOTHOOT,   10
	tree_mon 15, PINECO,     10
	tree_mon 15, PINECO,     10
	tree_mon 10, NOCTOWL,    10
	tree_mon  5, BUTTERFREE, 10
	tree_mon  5, BEEDRILL,   10
	db -1
	; rare
	tree_mon 50, HOOTHOOT,   10
	tree_mon 15, CATERPIE,   10
	tree_mon 15, WEEDLE,     10
	tree_mon 10, HOOTHOOT,   10
	tree_mon  5, METAPOD,    10
	tree_mon  5, KAKUNA,     10
	db -1

TreeMonSet_Rock:
	tree_mon 70, KRABBY,     15
	tree_mon 25, GEODUDE,    15
	tree_mon  5, SHUCKLE,    15
	db -1
