NUM_ODD_EGGS EQU 10

prob: MACRO
prob_total = prob_total + (\1)
	dw prob_total * $ffff / 100
ENDM

OddEggProbabilities:
	table_width 2, OddEggProbabilities
prob_total = 0
; Pichu
	prob 6
	prob 6
; Magby
	prob 12
	prob 12
; Elekid
	prob 12
	prob 12
; Tyrogue
	prob 10
	prob 10
; Munchlax
	prob 10
	prob 10
	assert_table_length NUM_ODD_EGGS

OddEggs:
	table_width PARTYMON_STRUCT_LENGTH + MON_NAME_LENGTH, OddEggs

	db PICHU
	db NO_ITEM
	db THUNDERSHOCK, CHARM, DIZZY_PUNCH, 0
	dw 02048 ; OT ID
	dt 0 ; Exp
	db 0, 0, 0, 0, 0, 0 ; EVs
	db $BB, $BB, $BB ; DVs
	db SHINY_MASK | HIDDEN_ABILITY | QUIRKY, MALE | IS_EGG_MASK | 1 ; Personality
	db 30, 20, 10, 0 ; PP
	db 20 ; Happiness
	db 0 ; Pokerus
	db 0, 0, 0 ; Caught data
	db EGG_LEVEL ; Level
	db 0, 0 ; Status
	bigdw 0 ; HP
	bigdw 11 ; Max HP
	bigdw 6 ; Atk
	bigdw 5 ; Def
	bigdw 6 ; Spd
	bigdw 6 ; SAtk
	bigdw 6 ; SDef
	rawchar "Egg@@@@@@@@"

	db PICHU
	db NO_ITEM
	db THUNDERSHOCK, CHARM, DIZZY_PUNCH, 0
	dw 00256 ; OT ID
	dt 0 ; Exp
	db 0, 0, 0, 0, 0, 0 ; EVs
	db $BB, $BB, $BB ; DVs
	db SHINY_MASK | HIDDEN_ABILITY | QUIRKY, FEMALE | IS_EGG_MASK | 1 ; Personality
	db 30, 20, 10, 0 ; PP
	db 20 ; Happiness
	db 0 ; Pokerus
	db 0, 0, 0 ; Caught data
	db EGG_LEVEL ; Level
	db 0, 0 ; Status
	bigdw 0 ; HP
	bigdw 11 ; Max HP
	bigdw 5 ; Atk
	bigdw 5 ; Def
	bigdw 6 ; Spd
	bigdw 6 ; SAtk
	bigdw 6 ; SDef
	rawchar "Egg@@@@@@@@"

	db MAGBY
	db NO_ITEM
	db HAZE, LEER, DIZZY_PUNCH, 0
	dw 02560 ; OT ID
	dt 0 ; Exp
	db 0, 0, 0, 0, 0, 0 ; EVs
	db $BB, $BB, $BB ; DVs
	db SHINY_MASK | HIDDEN_ABILITY | QUIRKY, MALE | IS_EGG_MASK ; Personality
	db 30, 30, 10, 0 ; PP
	db 20 ; Happiness
	db 0 ; Pokerus
	db 0, 0, 0 ; Caught data
	db EGG_LEVEL ; Level
	db 0, 0 ; Status
	bigdw 0 ; HP
	bigdw 12 ; Max HP
	bigdw 6 ; Atk
	bigdw 5 ; Def
	bigdw 6 ; Spd
	bigdw 6 ; SAtk
	bigdw 6 ; SDef
	rawchar "Egg@@@@@@@@"

	db MAGBY
	db NO_ITEM
	db HAZE, LEER, DIZZY_PUNCH, 0
	dw 00512 ; OT ID
	dt 0 ; Exp
	db 0, 0, 0, 0, 0, 0 ; EVs
	db $BB, $BB, $BB ; DVs
	db SHINY_MASK | HIDDEN_ABILITY | QUIRKY, FEMALE | IS_EGG_MASK ; Personality
	db 30, 30, 10, 0 ; PP
	db 20 ; Happiness
	db 0 ; Pokerus
	db 0, 0, 0 ; Caught data
	db EGG_LEVEL ; Level
	db 0, 0 ; Status
	bigdw 0 ; HP
	bigdw 12 ; Max HP
	bigdw 6 ; Atk
	bigdw 5 ; Def
	bigdw 6 ; Spd
	bigdw 6 ; SAtk
	bigdw 6 ; SDef
	rawchar "Egg@@@@@@@@"

	db ELEKID
	db NO_ITEM
	db QUICK_ATTACK, LEER, DIZZY_PUNCH, 0
	dw 03072 ; OT ID
	dt 0 ; Exp
	db 0, 0, 0, 0, 0, 0 ; EVs
	db $BB, $BB, $BB ; DVs
	db SHINY_MASK | HIDDEN_ABILITY | QUIRKY, MALE | IS_EGG_MASK ; Personality
	db 30, 30, 10, 0 ; PP
	db 20 ; Happiness
	db 0 ; Pokerus
	db 0, 0, 0 ; Caught data
	db EGG_LEVEL ; Level
	db 0, 0 ; Status
	bigdw 0 ; HP
	bigdw 12 ; Max HP
	bigdw 6 ; Atk
	bigdw 5 ; Def
	bigdw 7 ; Spd
	bigdw 6 ; SAtk
	bigdw 6 ; SDef
	rawchar "Egg@@@@@@@@"

	db ELEKID
	db NO_ITEM
	db QUICK_ATTACK, LEER, DIZZY_PUNCH, 0
	dw 00512 ; OT ID
	dt 0 ; Exp
	db 0, 0, 0, 0, 0, 0 ; EVs
	db $BB, $BB, $BB ; DVs
	db SHINY_MASK | HIDDEN_ABILITY | QUIRKY, FEMALE | IS_EGG_MASK ; Personality
	db 30, 30, 10, 0 ; PP
	db 20 ; Happiness
	db 0 ; Pokerus
	db 0, 0, 0 ; Caught data
	db EGG_LEVEL ; Level
	db 0, 0 ; Status
	bigdw 0 ; HP
	bigdw 12 ; Max HP
	bigdw 6 ; Atk
	bigdw 5 ; Def
	bigdw 7 ; Spd
	bigdw 6 ; SAtk
	bigdw 6 ; SDef
	rawchar "Egg@@@@@@@@"

	db TYROGUE
	db NO_ITEM
	db TACKLE, RAGE, FORESIGHT, DIZZY_PUNCH
	dw 02560 ; OT ID
	dt 0 ; Exp
	db 0, 0, 0, 0, 0, 0 ; EVs
	db $BB, $BB, $BB ; DVs
	db SHINY_MASK | HIDDEN_ABILITY | QUIRKY, MALE | IS_EGG_MASK ; Personality
	db 35, 20, 40, 10 ; PP
	db 20 ; Happiness
	db 0 ; Pokerus
	db 0, 0, 0 ; Caught data
	db EGG_LEVEL ; Level
	db 0, 0 ; Status
	bigdw 0 ; HP
	bigdw 12 ; Max HP
	bigdw 6 ; Atk
	bigdw 5 ; Def
	bigdw 5 ; Spd
	bigdw 6 ; SAtk
	bigdw 6 ; SDef
	rawchar "Egg@@@@@@@@"

	db TYROGUE
	db NO_ITEM
	db TACKLE, RAGE, FORESIGHT, DIZZY_PUNCH
	dw 00256 ; OT ID
	dt 0 ; Exp
	db 0, 0, 0, 0, 0, 0 ; EVs
	db $BB, $BB, $BB ; DVs
	db SHINY_MASK | HIDDEN_ABILITY | QUIRKY, FEMALE | IS_EGG_MASK ; Personality
	db 35, 20, 40, 10 ; PP
	db 20 ; Happiness
	db 0 ; Pokerus
	db 0, 0, 0 ; Caught data
	db EGG_LEVEL ; Level
	db 0, 0 ; Status
	bigdw 0 ; HP
	bigdw 12 ; Max HP
	bigdw 5 ; Atk
	bigdw 5 ; Def
	bigdw 5 ; Spd
	bigdw 6 ; SAtk
	bigdw 6 ; SDef
	rawchar "Egg@@@@@@@@"

	db MUNCHLAX
	db NO_ITEM
	db SWEET_KISS, METRONOME, TACKLE, DIZZY_PUNCH
	dw 04096 ; OT ID
	dt 0 ; Exp
	db 0, 0, 0, 0, 0, 0 ; EVs
	db $BB, $BB, $BB ; DVs
	db SHINY_MASK | HIDDEN_ABILITY | QUIRKY, MALE | IS_EGG_MASK ; Personality
	db 10, 10, 35, 10 ; PP
	db 20 ; Happiness
	db 0 ; Pokerus
	db 0, 0, 0 ; Caught data
	db EGG_LEVEL ; Level
	db 0, 0 ; Status
	bigdw 0 ; HP
	bigdw 14 ; Max HP
	bigdw 7 ; Atk
	bigdw 6 ; Def
	bigdw 5 ; Spd
	bigdw 6 ; SAtk
	bigdw 7 ; SDef
	rawchar "Egg@@@@@@@@"

	db MUNCHLAX
	db NO_ITEM
	db SWEET_KISS, METRONOME, TACKLE, DIZZY_PUNCH
	dw 00768 ; OT ID
	dt 0 ; Exp
	db 0, 0, 0, 0, 0, 0 ; EVs
	db $BB, $BB, $BB ; DVs
	db SHINY_MASK | HIDDEN_ABILITY | QUIRKY, FEMALE | IS_EGG_MASK ; Personality
	db 10, 10, 35, 10 ; PP
	db 20 ; Happiness
	db 0 ; Pokerus
	db 0, 0, 0 ; Caught data
	db EGG_LEVEL ; Level
	db 0, 0 ; Status
	bigdw 0 ; HP
	bigdw 14 ; Max HP
	bigdw 6 ; Atk
	bigdw 6 ; Def
	bigdw 5 ; Spd
	bigdw 6 ; SAtk
	bigdw 7 ; SDef
	rawchar "Egg@@@@@@@@"

	assert_table_length NUM_ODD_EGGS

MystriEgg:
	db TOGEPI
	db NO_ITEM
	db GROWL, CHARM, MOONBLAST, AEROBLAST
	dw 08192 ; OT ID
	dt 0 ; Exp
	db 0, 0, 0, 0, 0, 0 ; EVs
	db $FF, $FF, $FF ; DVs
	db SHINY_MASK | HIDDEN_ABILITY | QUIRKY, FEMALE | IS_EGG_MASK ; Personality
	db 40, 20, 15, 5 ; PP
	db 20 ; Happiness
	db 0 ; Pokerus
	db 0, 0, 0 ; Caught data
	db EGG_LEVEL ; Level
	db 0, 0 ; Status
	bigdw 0 ; HP
	bigdw 12 ; Max HP
	bigdw 5 ; Atk
	bigdw 6 ; Def
	bigdw 5 ; Spd
	bigdw 6 ; SAtk
	bigdw 6 ; SDef
	rawchar "Egg@@@@@@@@"
