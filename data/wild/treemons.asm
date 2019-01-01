TreeMons:
	dw TreeMons1
	dw TreeMons1
	dw TreeMons2
	dw TreeMons3
	dw TreeMons4
	dw TreeMons5
	dw TreeMons6
	dw RockMons
	dw TreeMons1

; Two tables each (normal, rare).
; Structure:
;	db  %, species, level

TreeMons1:
	db 50, PIDGEY,     10
	db 15, PIDGEY,     10
	db 15, PIDGEY,     10
	db 10, PIDGEY,     10
	db  5, MEOWTH,     10
	db  5, MEOWTH,     10
	db -1
	; rare
	db 50, PIDGEY,     10
	db 15, HERACROSS,  10
	db 15, HERACROSS,  10
	db 10, PIDGEY,     10
	db  5, MEOWTH,     10
	db  5, MEOWTH,     10
	db -1

TreeMons2:
	db 50, PIDGEY,     10
	db 15, EKANS,      10
	db 15, EKANS,      10
	db 10, PIDGEY,     10
	db  5, MEOWTH,     10
	db  5, MEOWTH,     10
	db -1
	; rare
	db 50, PIDGEY,     10
	db 15, HERACROSS,  10
	db 15, HERACROSS,  10
	db 10, PIDGEY,     10
	db  5, MEOWTH,     10
	db  5, MEOWTH,     10
	db -1

TreeMons3:
	db 50, HOOTHOOT,   10
	db 15, SPINARAK,   10
	db 15, LEDYBA,     10
	db 10, EXEGGCUTE,  10
	db  5, EXEGGCUTE,  10
	db  5, EXEGGCUTE,  10
	db -1
	; rare
	db 40, MURKROW,    10
	db 20, PINECO,     10
	db 20, PINECO,     10
	db 10, EXEGGCUTE,  10
	db  5, EXEGGCUTE,  10
	db  5, EXEGGCUTE,  10
	db -1

TreeMons4:
	db 50, HOOTHOOT,   10
	db 15, EKANS,      10
	db 15, HOOTHOOT,   10
	db 10, EXEGGCUTE,  10
	db  5, EXEGGCUTE,  10
	db  5, EXEGGCUTE,  10
	db -1
	; rare
	db 40, MURKROW,    10
	db 20, PINECO,     10
	db 20, PINECO,     10
	db 10, EXEGGCUTE,  10
	db  5, EXEGGCUTE,  10
	db  5, EXEGGCUTE,  10
	db -1

TreeMons5:
	db 50, HOOTHOOT,   10
	db 15, VENONAT,    10
	db 15, HOOTHOOT,   10
	db 10, EXEGGCUTE,  10
	db  5, EXEGGCUTE,  10
	db  5, EXEGGCUTE,  10
	db -1
	; rare
	db 50, HOOTHOOT,   10
	db 15, PINECO,     10
	db 15, PINECO,     10
	db 10, EXEGGCUTE,  10
	db  5, EXEGGCUTE,  10
	db  5, EXEGGCUTE,  10
	db -1

TreeMons6:
	db 50, HOOTHOOT,   10
	db 15, PINECO,     10
	db 15, PINECO,     10
	db 10, NOCTOWL,    10
	db  5, BUTTERFREE, 10
	db  5, BEEDRILL,   10
	db -1
	; rare
	db 50, HOOTHOOT,   10
	db 15, CATERPIE,   10
	db 15, WEEDLE,     10
	db 10, HOOTHOOT,   10
	db  5, METAPOD,    10
	db  5, KAKUNA,     10
	db -1

RockMons:
	db 70, KRABBY,     15
	db 30, GEODUDE,    15
	db -1
