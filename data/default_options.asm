DefaultOptions3:
; wOptions3
	db 0

DefaultOptions:
; wOptions1
	db (1 << BATTLE_EFFECTS) | (1 << STEREO) | FAST_TEXT
; wSaveFileExists
	db FALSE
; wTextboxFrame
	db 0
; wTextboxFlags
	db $01 ; ???
; wOptions2
	db 0
; wInitialOptions
	db (1 << NATURES_OPT) | (1 << ABILITIES_OPT) | (1 << PSS_OPT) | (1 << COLOR_VARY_OPT)
; wInitialOptions2
	db 0
