MACRO plural ; TODO: move this elsewhere?
	for i, charlen(\1)
		db charsub(\1, charlen(\1) - i)
	endr
	db "@", \2, "@"
ENDM

PluralTable:
	plural "e of Rage", "es of Rage" ; Cakes of Rage
	plural "Honey", "Honey" ; (Sweet) Honey
	plural "ay", "ays" ; Light Clays
	plural "y", "ies" ; Rare Candies
	plural "x", "xes" ; PP Maxes
	plural "ilk", "ilk" ; Moomoo Milk
	plural "Crunch", "Crunchies" ; PewterCrunchies
	plural "h", "hes" ; Sacred Ashes
	plural "Powder", "Powder" ; EnergyPowder
	plural "c.", "cs." ; Guard Specs.
	plural "ts", "ts" ; Heavy Boots
	plural "ef", "efs" ; X Sp.Defs
	plural "f", "ves" ; Silk Scarves
	plural "Sand", "Sand" ; Soft Sand
	plural "es", "es" ; BlackGlasses
	plural "rs", "rs" ; Leftovers
	plural "ds", "ds" ; Protect Pads
	plural "Dice", "Dice" ; Loaded Dice
	plural "s", "ses" ; Scope Lenses
	plural "", "s" ; everything else
