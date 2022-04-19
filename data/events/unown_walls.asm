UnownWalls:
	db $08, $44, $04, $00, $2e, $08, $ff ; E, S, C, A, P, E
	db $26, $20, $0c, $0e, $46, $ff ; L, I, G, H, T
	db $4c, $00, $46, $08, $42, $ff ; W, A, T, E, R
	db $0a, $00, $20, $42, $60, $ff ; F, A, I, R, Y

MenuHeaders_UnownWalls:
; ESCAPE
	db MENU_BACKUP_TILES
	menu_coords 3, 4, 16, 9
; LIGHT
	db MENU_BACKUP_TILES
	menu_coords 4, 4, 15, 9
; WATER
	db MENU_BACKUP_TILES
	menu_coords 4, 4, 15, 9
; FAIRY
	db MENU_BACKUP_TILES
	menu_coords 4, 4, 15, 9
