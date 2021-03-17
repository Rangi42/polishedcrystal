UnownWalls:
	db $08, $44, $04, $00, $2e, $08, $ff ; E, S, C, A, P, E
	db $26, $20, $0c, $0e, $46, $ff ; L, I, G, H, T
	db $4c, $00, $46, $08, $42, $ff ; W, A, T, E, R
	db $0a, $00, $20, $42, $60, $ff ; F, A, I, R, Y

MenuHeaders_UnownWalls:
; ESCAPE
	db $40 ; flags
	db 04, 03 ; start coords
	db 09, 16 ; end coords
; LIGHT
	db $40 ; flags
	db 04, 04 ; start coords
	db 09, 15 ; end coords
; WATER
	db $40 ; flags
	db 04, 04 ; start coords
	db 09, 15 ; end coords
; FAIRY
	db $40 ; flags
	db 04, 04 ; start coords
	db 09, 15 ; end coords
