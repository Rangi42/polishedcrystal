InitialOptionNames:
	table_width 2
	dw .Natures
	dw .Abilities
	dw .PSS
	dw .EVs
	dw .Experience
	dw .Affection
	dw .RTC
	dw .PerfectStats
	dw .TradedMon
	dw .EvolveInBattle
	dw .ColorVariation
	assert_table_length NUM_INITIAL_MENU_OPTIONS

.Natures:
	db "Natures@"
.Abilities:
	db "Abilities@"
.PSS:
	db "Phys/Spcl split@"
.EVs:
	db "EV gain@"
.Experience:
	db "Experience gain@"
.Affection:
	db "Affection bonus@"
.RTC:
	db "Real-time clock@"
.PerfectStats:
	db "Perfect stats@"
.TradedMon:
	db "Traded <PK><MN> obey@"
.EvolveInBattle:
	db "Evolve in battle@"
.ColorVariation:
	db "Color variation@"
