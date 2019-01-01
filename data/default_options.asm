DefaultOptions:
	db %01100001 ; Options1: fast text speed, stereo sound, battle scene on
	db $00       ; wSaveFileExists: no
	db $00       ; TextBoxFrame: frame 0
	db $01       ; TextBoxFlags: ?
	db $0        ; ???
	db %00000000 ; Options2: default typeface, running shoes off, 12-hour clock,
	             ;           imperial units, battle style set
	db %00000111 ; InitialOptions: natures on, abilities on, color variation on,
	             ;                 perfect IVs off, traded as OT off,
	             ;                 nuzlocke mode off
	db $0        ; ???
