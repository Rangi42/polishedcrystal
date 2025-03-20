MACRO plural ; TODO: move this elsewhere?
	for i, charlen(\1)
		db charsub(\1, charlen(\1) - i)
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
