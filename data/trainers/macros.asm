; TODO: do `dp mon[, form] / db level` and eliminate this macro
MACRO dbp
	db (\1)
	shift
	dp \#
ENDM

DEF NUM_EV_SPREADS = 0

MACRO ev_spread
	def_evs \#
	if !DEF(EV_SPREAD_FOR_{d:EV_HP}_{d:EV_ATK}_{d:EV_DEF}_{d:EV_SPE}_{d:EV_SAT}_{d:EV_SDF})
		def EV_SPREAD_FOR_{d:EV_HP}_{d:EV_ATK}_{d:EV_DEF}_{d:EV_SPE}_{d:EV_SAT}_{d:EV_SDF} = NUM_EV_SPREADS
		with_each_stat "def EV_SPREAD_{d:NUM_EV_SPREADS}_? EQU EV_?"
		redef NUM_EV_SPREADS += 1
	endc
	db EV_SPREAD_FOR_{d:EV_HP}_{d:EV_ATK}_{d:EV_DEF}_{d:EV_SPE}_{d:EV_SAT}_{d:EV_SDF}
ENDM

MACRO tr_name
	; Reset trainer macro state.
	def _tr_flags = 0
	def _tr_mons = 0
	redef _tr_name EQUS \1
ENDM

MACRO tr_mon
	; First, reset all stale data from the previous Trainer's mons.
	def x = {d:_tr_mons}
	def _tr_mons += 1
	redef _tr_pk{d:x}_nickname EQUS ""
	redef _tr_pk{d:x}_item EQUS "NO_ITEM"
	def _tr_pk{d:x}_form = NO_FORM

	; Provides a default null EV spread if 1+ mon has explicit EVs. Should we
	; instead reference the trainer class EV define?
	redef _tr_pk{d:x}_evs EQUS "0 HP"

	; DVs need to be defined individually for Hidden Power benefit.
	; "Explicit" will override standard Hidden Power DV recalculation,
	; and error out if it results in a different Hidden Power type than
	; specified.
	def _tr_pk{d:x}_dvs_explicit = FALSE
	def _tr_pk{d:x}_dvs_hp = 0
	def _tr_pk{d:x}_dvs_atk = 0
	def _tr_pk{d:x}_dvs_def = 0
	def _tr_pk{d:x}_dvs_spe = 0
	def _tr_pk{d:x}_dvs_sat = 0
	def _tr_pk{d:x}_dvs_sdf = 0
	def _tr_pk{d:x}_extra = NAT_NEUTRAL
	for i, 1, NUM_MOVES + 1
		def _tr_pk{d:x}_move{d:i} = NO_MOVE
	endr

	; Then actually define the data. Level is always required.
	def _tr_pk{d:x}_level = \1

	; Is the mon nicknamed?
	if STRIN("\2", "\"") != 0
		; The pokémon is nicknamed.
		def _tr_flags |= TRAINERTYPE_NICKNAME
		redef _tr_pk{d:x}_nickname = \2
		shift ; since it's optional
	endc

	if STRIN("\2", "@") != 0
		; Format "Species @ Item" was used, so add the item.
		def _tr_flags |= TRAINERTYPE_ITEM
		redef _tr_pk{d:x}_item EQUS STRSUB("\2", STRIN("\2", "@") + 2)
		redef _tr_pk{d:x}_species EQUS STRSUB("\2", 1, STRIN("\2", "@") - 2)
	else
		; Just "Species", no held item.
		redef _tr_pk{d:x}_species EQUS \2
	endc

	; Was form/gender specified?
	if _NARG == 3
		def _tr_pk{d:x}_form = \3
	endc
ENDM

MACRO tr_moves
	def _tr_flags |= TRAINERTYPE_MOVES
	if _NARG > NUM_MOVES
		error "A mon may only have {d:NUM_MOVES} moves."
	endc
	for i, 1, _NARG + 1
		def _tr_pk{d:x}_move{d:i} = \<i>
	endr
ENDM

MACRO tr_end
; Write out the party data from stored trainer buffer.
	; First, the trainer name and flags.
	db "{_tr_name}@"
	db _tr_flags

	; Now for all the mon data.
	for x, 0, _tr_mons
		; We can't have implicit moves, for now.
		if _tr_flags & TRAINERTYPE_MOVES && _tr_pk{d:x}_move1 == NO_MOVE
			error "Unspecified move list for _tr_pk{d:x}_species"
		endc
		db _tr_pk{d:x}_level
		dp _tr_pk{d:x}_species, _tr_pk{d:x}_form

		if _tr_flags & TRAINERTYPE_ITEM
			db _tr_pk{d:x}_item
		endc
		if _tr_flags & TRAINERTYPE_MOVES
			for i, 1, NUM_MOVES + 1
				db _tr_pk{d:x}_move{d:i}
			endr
		endc
	endr

	db -1
ENDM
