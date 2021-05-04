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
; Structure:
;	dbpb  %, species, level

TreeMonSet_City:
TreeMonSet_Canyon:
	dbpb 50, PIDGEY,     10
	dbpb 15, PIDGEY,     10
	dbpb 15, PIDGEY,     10
	dbpb 10, PIDGEY,     10
	dbpb  5, MEOWTH,     10
	dbpb  5, MEOWTH,     10
	db -1
	; rare
	dbpb 50, PIDGEY,     10
	dbpb 15, HERACROSS,  10
	dbpb 15, HERACROSS,  10
	dbpb 10, PIDGEY,     10
	dbpb  5, MEOWTH,     10
	dbpb  5, MEOWTH,     10
	db -1

TreeMonSet_Town:
	dbpb 50, PIDGEY,     10
	dbpb 15, EKANS,      10
	dbpb 15, EKANS,      10
	dbpb 10, PIDGEY,     10
	dbpb  5, MEOWTH,     10
	dbpb  5, MEOWTH,     10
	db -1
	; rare
	dbpb 50, PIDGEY,     10
	dbpb 15, HERACROSS,  10
	dbpb 15, HERACROSS,  10
	dbpb 10, PIDGEY,     10
	dbpb  5, MEOWTH,     10
	dbpb  5, MEOWTH,     10
	db -1

TreeMonSet_Route:
	dbpb 50, HOOTHOOT,   10
	dbpb 15, SPINARAK,   10
	dbpb 15, LEDYBA,     10
	dbpb 10, EXEGGCUTE,  10
	dbpb  5, EXEGGCUTE,  10
	dbpb  5, EXEGGCUTE,  10
	db -1
	; rare
	dbpb 40, MURKROW,    10
	dbpb 20, PINECO,     10
	dbpb 20, PINECO,     10
	dbpb 10, EXEGGCUTE,  10
	dbpb  5, EXEGGCUTE,  10
	dbpb  5, EXEGGCUTE,  10
	db -1

TreeMonSet_Kanto:
	dbpb 50, HOOTHOOT,   10
	dbpb 15, EKANS,      10
	dbpb 15, HOOTHOOT,   10
	dbpb 10, EXEGGCUTE,  10
	dbpb  5, EXEGGCUTE,  10
	dbpb  5, EXEGGCUTE,  10
	db -1
	; rare
	dbpb 40, MURKROW,    10
	dbpb 20, PINECO,     10
	dbpb 20, PINECO,     10
	dbpb 10, EXEGGCUTE,  10
	dbpb  5, EXEGGCUTE,  10
	dbpb  5, EXEGGCUTE,  10
	db -1

TreeMonSet_Lake:
	dbpb 50, HOOTHOOT,   10
	dbpb 15, VENONAT,    10
	dbpb 15, HOOTHOOT,   10
	dbpb 10, EXEGGCUTE,  10
	dbpb  5, EXEGGCUTE,  10
	dbpb  5, EXEGGCUTE,  10
	db -1
	; rare
	dbpb 50, HOOTHOOT,   10
	dbpb 15, PINECO,     10
	dbpb 15, PINECO,     10
	dbpb 10, EXEGGCUTE,  10
	dbpb  5, EXEGGCUTE,  10
	dbpb  5, EXEGGCUTE,  10
	db -1

TreeMonSet_Forest:
	dbpb 50, HOOTHOOT,   10
	dbpb 15, PINECO,     10
	dbpb 15, PINECO,     10
	dbpb 10, NOCTOWL,    10
	dbpb  5, BUTTERFREE, 10
	dbpb  5, BEEDRILL,   10
	db -1
	; rare
	dbpb 50, HOOTHOOT,   10
	dbpb 15, CATERPIE,   10
	dbpb 15, WEEDLE,     10
	dbpb 10, HOOTHOOT,   10
	dbpb  5, METAPOD,    10
	dbpb  5, KAKUNA,     10
	db -1

TreeMonSet_Rock:
	dbpb 70, KRABBY,     15
	dbpb 25, GEODUDE,    15
	dbpb  5, SHUCKLE,    15
	db -1
