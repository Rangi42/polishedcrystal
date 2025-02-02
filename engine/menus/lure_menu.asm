	const_def
	const HARSH_LURE_F  ; 0
	const POTENT_LURE_F ; 1
	const MALIGN_LURE_F ; 2

CheckForLures:
	xor a
	ldh [hScriptVar], a
	ld a, HARSH_LURE
	ld [wCurKeyItem], a
	call CheckKeyItem
	jr nc, .no_harsh_lure
	ld a, (1 << HARSH_LURE_F)
	ldh [hScriptVar], a
.no_harsh_lure
	ld a, POTENT_LURE
	ld [wCurKeyItem], a
	call CheckKeyItem
	jr nc, .no_potent_lure
	ld hl, hScriptVar
	set POTENT_LURE_F, [hl]
.no_potent_lure
	ld a, MALIGN_LURE
	ld [wCurKeyItem], a
	call CheckKeyItem
	ret nc
	ld hl, hScriptVar
	set MALIGN_LURE_F, [hl]
	ret

SetUpLureMenu:
	ldh a, [hScriptVar]
	and a
	ret z
	ld [wWhichIndexSet], a
	ld hl, .LureMenu
	call LoadMenuHeader
	call DoNthMenu
	jr nc, .continue
	xor a
	ldh [hScriptVar], a
	jmp ExitMenu
.continue
	ld a, [wMenuSelection]
	ldh [hScriptVar], a
	jmp ExitMenu

.LureMenu
	db MENU_BACKUP_TILES | MENU_NO_CLICK_SFX
	menu_coords 0, 0, 15, 12
	dw .MenuData
	db 1 ; default option

.MenuData
	db $a0 ; flags
	db 0 ; items
	dw .WhichLures
	dw PlaceMenuStrings
	dw .MenuStrings

.WhichLures
	; dummy for no lures
	db 0
	db 0
	db -1

	db 1
	db HARSH_LURE_MENU_OPT
	db -1

	db 1
	db POTENT_LURE_MENU_OPT
	db -1

	db 2
	db HARSH_LURE_MENU_OPT, POTENT_LURE_MENU_OPT
	db -1

	db 1
	db MALIGN_LURE_MENU_OPT
	db -1

	db 2
	db HARSH_LURE_MENU_OPT, MALIGN_LURE_MENU_OPT
	db -1

	db 2
	db POTENT_LURE_MENU_OPT, MALIGN_LURE_MENU_OPT
	db -1

	db 3
	db HARSH_LURE_MENU_OPT, POTENT_LURE_MENU_OPT, MALIGN_LURE_MENU_OPT
	db -1

.MenuStrings
	db "@" ; dummy string so we don't return 0
	db "Harsh Lure@"
	db "Potent Lure@"
	db "Malign Lure@"
