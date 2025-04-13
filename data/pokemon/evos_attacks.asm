DEF EVOS_ATTACKS_STATE EQU -1
DEF EVOS_ATTACKS_LAST_LEVEL EQU -1
DEF EVOS_ATTACKS_CURRENT_MON EQUS ""
DEF EVOS_ATTACKS_FIRST EQU 1

MACRO evo_data
	if EVOS_ATTACKS_STATE == 0
		if !EVOS_ATTACKS_FIRST
			db -1 ; end of previous mon's moves
		endc
		REDEF EVOS_ATTACKS_FIRST EQU 0
		{EVOS_ATTACKS_CURRENT_MON}EvosAttacks:
	endc
	assert EVOS_ATTACKS_STATE != 2, "{EVOS_ATTACKS_CURRENT_MON} has evo_data after its learnset!"
	REDEF EVOS_ATTACKS_STATE EQU 1
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

MACRO evos_attacks
	REDEF EVOS_ATTACKS_CURRENT_MON EQUS "\1"
	assert EVOS_ATTACKS_STATE != 0, "Empty learnset preceding {EVOS_ATTACKS_CURRENT_MON}!"
	REDEF EVOS_ATTACKS_STATE EQU 0
	REDEF EVOS_ATTACKS_LAST_LEVEL EQU -1
ENDM

; For split banks, adds a terminator and resets tracking
MACRO end_evos_attacks
	assert EVOS_ATTACKS_STATE != 0, "Empty learnset for {EVOS_ATTACKS_CURRENT_MON}!"
	db -1
	REDEF EVOS_ATTACKS_STATE EQU -1
	REDEF EVOS_ATTACKS_FIRST EQU 1
ENDM

MACRO learnset
	REDEF EVOS_ATTACKS_FIRST EQU 0
	if \1 < EVOS_ATTACKS_LAST_LEVEL
		warn "{EVOS_ATTACKS_CURRENT_MON} learns \2 at a lower level than previous move!"
	endc
	if EVOS_ATTACKS_LAST_LEVEL == -1 && \1 != 1
		warn "{EVOS_ATTACKS_CURRENT_MON} learns its first move at level \1 instead of level 1!"
	endc
	if \1 < 1 || \1 > 100
		warn "{EVOS_ATTACKS_CURRENT_MON} learns a move at level \1, which should be impossible!"
	endc
	REDEF EVOS_ATTACKS_LAST_LEVEL EQU \1
	if EVOS_ATTACKS_STATE != 2
		if EVOS_ATTACKS_STATE == 0
			{EVOS_ATTACKS_CURRENT_MON}EvosAttacks:
		endc
		db -1 ; end of evolutions and, if there were no evos, previous mon's moves
	endc
	REDEF EVOS_ATTACKS_STATE EQU 2
	db \1 ; level
	dw \2 ; move
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
