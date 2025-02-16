MACRO evo_data
	db \1 ; evolution type
	if \1 == EVOLVE_PARTY
		dp \2, PLAIN_FORM ; parameter
	elif \1 == EVOLVE_MOVE
		dw \2 ; parameter
	else
		db \2 ; parameter
	endc
	if \1 == EVOLVE_STAT || \1 == EVOLVE_HOLDING
		db \3 ; ATK_*_DEF | time of day
		shift
	endc
	if _NARG > 3
		dp \3, \4
	else
		dp \3, PLAIN_FORM
	endc
ENDM


SECTION "Evolutions and Attacks Pointers", ROMX

INCLUDE "data/pokemon/evolution_moves.asm"

EvosAttacksPointers::
	indirect_table 2, 1
	indirect_entries NUM_KANTO_POKEMON, EvosAttacksPointersKanto
	indirect_entries NUM_JOHTO_POKEMON, EvosAttacksPointersJohto
	indirect_entries NUM_SPECIES, EvosAttacksPointersLateGen
	indirect_entries NUM_UNIQUE_POKEMON - (FIRST_VARIANT_FORM_MON - 1 - NUM_SPECIES), EvosAttacksPointersVariants
	indirect_table_end

INCLUDE "data/pokemon/evos_attacks_kanto.asm"
INCLUDE "data/pokemon/evos_attacks_johto.asm"
INCLUDE "data/pokemon/evos_attacks_lategen.asm"
INCLUDE "data/pokemon/evos_attacks_variants.asm"
