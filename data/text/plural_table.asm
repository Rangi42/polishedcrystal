	; use rawchars so `plural` can reverse strings
	setcharmap no_ngrams

MACRO plural
	for i, CHARLEN(\1)
		db STRCHAR(\1, CHARLEN(\1) - 1 - i)
	endr
	db "@", \2, "@"
ENDM

PluralTable:
	; Note that order matters since "ay" is a subset of "y" for example.
if !DEF(FAITHFUL)
	plural "e of Rage", "es of Rage" ; Cakes of Rage
endc
	plural "Honey",     "Honey"      ; (Sweet) Honey
	plural "ay",        "ays"        ; Light Clays, and Throat Sprays
	plural "y",         "ies"        ; Rare Candies, Berries, etc
	plural "x",         "xes"        ; PP Maxes
	plural "lk",        "lk"         ; Moomoo Milk
	plural "runch",     "runchies"   ; PewterCrunchies
	plural "h",         "hes"        ; Sacred Ashes, Mulches, etc
	plural "der",       "der"        ; Powders (EnergyPowder, Heal Powder, etc)
if DEF(FAITHFUL)
	plural "c.",        "cs."        ; Guard Specs.
endc
	plural "ts",        "ts"         ; Guard Stats, Heavy Boots
	plural "ef",        "efs"        ; X Sp.Defs
	plural "f",         "ves"        ; Silk Scarves, Silver Leaves, etc
	plural "Sand",      "Sand"       ; Soft Sand
	plural "es",        "es"         ; BlackGlasses, Wise Glasses, Safe Goggles
	plural "rs",        "rs"         ; Leftovers
	plural "ds",        "ds"         ; Protect Pads
	plural "Dice",      "Dice"       ; Loaded Dice
	plural "ns",        "nses"       ; Lenses (Scope Lenses, Wide Lenses, etc)
	plural "s",         "s"          ; Carbos
	plural "",          "s"          ; everything else

	setcharmap default
