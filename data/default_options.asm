DefaultOptions:
; wOptions1
	db (1 << BATTLE_EFFECTS) | (1 << STEREO) | FAST_TEXT
; wSaveFileExists
	db FALSE
; wTextBoxFrame
	db 0
; wTextBoxFlags
	db $01 ; ???
; wOptions2
	db 0
; wInitialOptions
	db (1 << NATURES_OPT) | (1 << ABILITIES_OPT) | (1 << COLOR_VARY_OPT)
; wInitialOptions2
	db (1 << PSS_OPT)
