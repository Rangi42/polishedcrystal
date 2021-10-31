password_group: MACRO
	db \1, \2
	if \1 == BUENA_MON
		dp \3, NO_FORM
		dp \4, NO_FORM
		dp \5, NO_FORM
	else
		db \3, \4, \5
	endc
ENDM

BuenasPasswordTable:
	table_width 2, BuenasPasswordTable
	dw .JohtoStarters
	dw .Beverages
	dw .HealingItems
	dw .Balls
	dw .Pokemon1
	dw .Pokemon2
	dw .JohtoTowns
	dw .Types
	dw .Moves
	dw .XItems
	dw .RadioStations
	assert_table_length NUM_PASSWORD_CATEGORIES

                ; string type, points, option 1, option 2, option 3
.JohtoStarters: password_group BUENA_MON,    10, CYNDAQUIL, TOTODILE, CHIKORITA
.Beverages:     password_group BUENA_ITEM,   12, FRESH_WATER, SODA_POP, LEMONADE
.HealingItems:  password_group BUENA_ITEM,   12, POTION, ANTIDOTE, PARALYZEHEAL
.Balls:         password_group BUENA_ITEM,   12, POKE_BALL, GREAT_BALL, ULTRA_BALL
.Pokemon1:      password_group BUENA_MON,    10, PIKACHU, RATTATA, GEODUDE
.Pokemon2:      password_group BUENA_MON,    10, HOOTHOOT, SPINARAK, DROWZEE
.JohtoTowns:    password_group BUENA_STRING, 16, "New Bark Town@", "Cherrygrove City@", "Azalea Town@"
.Types:         password_group BUENA_STRING,  6, "Flying@", "Bug@", "Grass@"
.Moves:         password_group BUENA_MOVE,   12, TACKLE, GROWL, MUD_SLAP
.XItems:        password_group BUENA_ITEM,   12, X_ATTACK, X_DEFEND, X_SPEED
.RadioStations: password_group BUENA_STRING, 13, "#mon Talk@", "#mon Music@", "Lucky Channel@"
