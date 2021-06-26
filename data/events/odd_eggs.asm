NUM_ODD_EGGS EQU 10
ODD_EGG_LENGTH EQU 10

prob: MACRO
prob_total = prob_total + (\1)
	dw prob_total * $ffff / 100
ENDM

OddEggProbabilities:
	table_width 2, OddEggProbabilities
prob_total = 0
; Pichu
	prob 10
; Cleffa
	prob 16
; Igglybuff
	prob 16
; Tyrogue
	prob 2
; Smoochum
	prob 12
; Elekid
	prob 12
; Magby
	prob 12
; Mime Jr.
	prob 8
; Happiny
	prob 4
; Munchlax
	prob 8
	assert_table_length NUM_ODD_EGGS

OddEggs:
	table_width ODD_EGG_LENGTH, OddEggs
	dp PICHU, IS_EGG_MASK | PLAIN_FORM
	db THUNDERSHOCK, CHARM, DIZZY_PUNCH, NO_MOVE
	db $BB, $BB, $BB ; DVs
	db SHINY_MASK | HIDDEN_ABILITY | QUIRKY ; Personality

	dp CLEFFA, IS_EGG_MASK | PLAIN_FORM
	db TACKLE, CHARM, DIZZY_PUNCH, NO_MOVE
	db $BB, $BB, $BB ; DVs
	db SHINY_MASK | HIDDEN_ABILITY | QUIRKY ; Personality

	dp IGGLYBUFF, IS_EGG_MASK | PLAIN_FORM
	db SING, CHARM, DIZZY_PUNCH, NO_MOVE
	db $BB, $BB, $BB ; DVs
	db SHINY_MASK | HIDDEN_ABILITY | QUIRKY ; Personality

	dp TYROGUE, IS_EGG_MASK | PLAIN_FORM
	db TACKLE, RAGE, FORESIGHT, DIZZY_PUNCH
	db $BB, $BB, $BB ; DVs
	db SHINY_MASK | HIDDEN_ABILITY | QUIRKY ; Personality

	dp SMOOCHUM, IS_EGG_MASK | PLAIN_FORM
	db TACKLE, LICK, DIZZY_PUNCH, NO_MOVE
	db $BB, $BB, $BB ; DVs
	db SHINY_MASK | HIDDEN_ABILITY | QUIRKY ; Personality

	dp ELEKID, IS_EGG_MASK | PLAIN_FORM
	db QUICK_ATTACK, LEER, DIZZY_PUNCH, NO_MOVE
	db $BB, $BB, $BB ; DVs
	db SHINY_MASK | HIDDEN_ABILITY | QUIRKY ; Personality

	dp MAGBY, IS_EGG_MASK | PLAIN_FORM
	db HAZE, LEER, DIZZY_PUNCH, NO_MOVE
	db $BB, $BB, $BB ; DVs
	db SHINY_MASK | HIDDEN_ABILITY | QUIRKY ; Personality

	dp MIME_JR_, IS_EGG_MASK | PLAIN_FORM
	db BARRIER, CONFUSION, TACKLE, DIZZY_PUNCH
	db $BB, $BB, $BB ; DVs
	db SHINY_MASK | HIDDEN_ABILITY | QUIRKY ; Personality

	dp HAPPINY, IS_EGG_MASK | PLAIN_FORM
	db MINIMIZE, TACKLE, METRONOME, DIZZY_PUNCH
	db $BB, $BB, $BB ; DVs
	db SHINY_MASK | HIDDEN_ABILITY | QUIRKY ; Personality

	dp MUNCHLAX, IS_EGG_MASK | PLAIN_FORM
	db SWEET_KISS, METRONOME, TACKLE, DIZZY_PUNCH
	db $BB, $BB, $BB ; DVs
	db SHINY_MASK | HIDDEN_ABILITY | QUIRKY ; Personality

	assert_table_length NUM_ODD_EGGS

MystriEgg:
	dp TOGEPI, FEMALE | IS_EGG_MASK | PLAIN_FORM
	db GROWL, CHARM, MOONBLAST, AEROBLAST
	db $FF, $FF, $FF ; DVs
	db SHINY_MASK | HIDDEN_ABILITY | QUIRKY ; Personality
