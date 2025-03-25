; TODO: do `dp mon[, form] / db level` and eliminate this macro
MACRO dbp
	db (\1)
	shift
	dp \#
ENDM

DEF NUM_EV_SPREADS = 0

; Hidden Power DVs ($00 is converted to $ff in regular trainer sets)
; Chosen for stat importance: Speed > * > Atk (hidden power is a special move)
; ("XDVS_" is a placeholder before I have replaced the full party table,
; will be replaced with "DVS_" when fully ready)
if DEF(FAITHFUL)
DEF XDVS_HP_FIGHTING EQUS "14 Def, 14 Spe, 14 SAt, 14 SDf"
DEF XDVS_HP_FLYING   EQUS "14 HP, 14 Atk, 14 Def, 14 SAt, 14 SDf"
DEF XDVS_HP_POISON   EQUS "14 Def, 14 SAt, 14 SDf"
DEF XDVS_HP_GROUND   EQUS "14 SAt, 14 SDf"
DEF XDVS_HP_ROCK     EQUS "14 Def, 14 Spe, 14 SDf"
DEF XDVS_HP_BUG      EQUS "14 Atk, 14 Def, 14 SDf"
DEF XDVS_HP_GHOST    EQUS "14 Atk, 14 SDf"
DEF XDVS_HP_STEEL    EQUS "14 SDf"
DEF XDVS_HP_FIRE     EQUS "14 Atk, 14 Spe, 14 SAt"
DEF XDVS_HP_WATER    EQUS "14 Atk, 14 Def, 14 SAt"
DEF XDVS_HP_GRASS    EQUS "14 Atk, 14 SAt"
DEF XDVS_HP_ELECTRIC EQUS "14 SAt"
DEF XDVS_HP_PSYCHIC  EQUS "14 Atk, 14 Spe"
DEF XDVS_HP_ICE      EQUS "14 Atk, 14 Def"
DEF XDVS_HP_DRAGON   EQUS "14 Atk"
DEF XDVS_HP_DARK     EQUS "15 All"
else
DEF XDVS_HP_FIGHTING EQUS "14 Def, 14 Spe, 14 SAt, 14 SDf"
DEF XDVS_HP_FLYING   EQUS "14 Spe, 14 SAt, 14 SDf"
DEF XDVS_HP_POISON   EQUS "14 Def, 14 SAt, 14 SDf"
DEF XDVS_HP_GROUND   EQUS "14 SAt, 14 SDf"
DEF XDVS_HP_ROCK     EQUS "14 Def, 14 Spe, 14 SDf"
DEF XDVS_HP_BUG      EQUS "14 Spe, 14 SDf"
DEF XDVS_HP_GHOST    EQUS "14 Def, 14 SDf"
DEF XDVS_HP_STEEL    EQUS "14 SDf"
DEF XDVS_HP_FIRE     EQUS "14 Def, 14 Spe, 14 SAt"
DEF XDVS_HP_WATER    EQUS "14 Spe, 14 SAt"
DEF XDVS_HP_GRASS    EQUS "14 Def, 14 SAt"
DEF XDVS_HP_ELECTRIC EQUS "14 SAt"
DEF XDVS_HP_PSYCHIC  EQUS "14 Def, 14 Spe"
DEF XDVS_HP_ICE      EQUS "14 Spe"
DEF XDVS_HP_DRAGON   EQUS "14 Def"
DEF XDVS_HP_DARK     EQUS "14 Atk"
endc

MACRO dv_spread
	def_dvs \#

	; This is a temporary way of handling DVs which replicate the legacy method,
	; so we can keep checking for whether the ROM matches or not.
	; When everything is verified and ready, this can behave like ev_spread.
	if EV_HP == 15 && EV_ATK == 15
		db 0
	else
		dn EV_HP, EV_ATK
	endc
	if EV_DEF == 15 && EV_SPE == 15
		db 0
	else
		dn EV_DEF, EV_SPE
	endc
	if EV_SAT == 15 && EV_SDF == 15
		db 0
	else
		dn EV_SAT, EV_SDF
	endc
ENDM

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
	def p = _tr_mons
	redef _tr_pk{d:p}_nickname EQUS ""
	redef _tr_pk{d:p}_item EQUS "NO_ITEM"
	def _tr_pk{d:p}_form = NO_FORM

	; Provides default null EV+DV spreads if 1+ mon has them explicitly. Should
	; we instead reference the trainer class defines?
	redef _tr_pk{d:p}_evs EQUS "0 HP"
	redef _tr_pk{d:p}_dvs EQUS "15 All"

	; If Hidden Power type is specified, track if we also have an explicit DV.
	; If we don't, the DV will be set to match the Hidden Power type.
	redef _tr_pk{d:p}_hp_type EQUS ""
	def _tr_pk{d:p}_dvs_explicit = FALSE

	redef _tr_pk{d:p}_ability EQUS "ABILITY_1"
	redef _tr_pk{d:p}_extra = NAT_NEUTRAL
	for i, 1, NUM_MOVES + 1
		def _tr_pk{d:p}_move{d:i} = NO_MOVE
	endr

	; Then actually define the data. Level is always required.
	def _tr_pk{d:p}_level = \1

	; Is the mon nicknamed?
	if STRIN("\2", "\"")
		; The pokémon is nicknamed.
		def _tr_flags |= TRAINERTYPE_NICKNAME
		redef _tr_pk{d:p}_nickname EQUS \2
		shift ; since it's optional
	endc

	if STRIN("\2", "@") != 0
		; Format "Species @ Item" was used, so add the item.
		def _tr_flags |= TRAINERTYPE_ITEM
		redef _tr_pk{d:p}_item EQUS STRSUB("\2", STRIN("\2", "@") + 2)
		redef _tr_pk{d:p}_species EQUS STRSUB("\2", 1, STRIN("\2", "@") - 2)
	else
		; Just "Species", no held item.
		redef _tr_pk{d:p}_species EQUS "\2"
	endc

	; Ability constant prefix.
	redef _tr_curabil EQUS "ABIL_{_tr_pk{d:p}_species}"

	; Was form/gender specified?
	if _NARG == 3
		; Is gender defined?
		if !STRIN("\3", "MALE") && !STRIN("\3", "GENDERLESS")
			; Check if we must define gender (TRAINERTYPE_PERSONALITY enabled).
			if (_tr_flags & TRAINERTYPE_PERSONALITY)
				fail "No gender specified for current mon."
			endc
		else
			if !(_tr_flags & TRAINERTYPE_PERSONALITY) && x > 0
				fail "No gender specified for previous mon."
			endc
			def _tr_flags |= TRAINERTYPE_PERSONALITY
		endc
		def _tr_pk{d:p}_form = \3

		; Possibly change ability constant prefix based on form.
		if STRIN("\3", "ALOLAN_FORM")
			redef _tr_curabil EQUS "{_tr_curabil}_ALOLAN"
		elif STRIN("\3", "GALARIAN_FORM")
			redef _tr_curabil EQUS "{_tr_curabil}_GALARIAN"
		elif STRIN("\3", "HISUIAN_FORM")
			redef _tr_curabil EQUS "{_tr_curabil}_HISUIAN"
		elif STRIN("\3", "PALDEAN_FORM")
			redef _tr_curabil EQUS "{_tr_curabil}_PALDEAN"
		endc
	endc

	def _tr_mons += 1
ENDM

MACRO tr_extra
	; If we specify extra data, we must also specify gender!
	if !(_tr_flags & TRAINERTYPE_PERSONALITY)
		fail "No gender specified for current mon."
	endc

	; All of these fields are optional.
	for i, 1, _NARG + 1
		if !STRCMP("\<i>", "SHINY")
			redef _tr_pk{d:p}_extra |= SHINY_MASK
		elif DEF(NAT_\<i>)
			redef _tr_pk{d:p}_extra |= NAT_\<i>
		else
			redef _tr_pk{d:p}_ability EQUS "{_tr_curabil}_\<i>"
		endc
	endr
ENDM

MACRO tr_evs
	def _tr_flags |= TRAINERTYPE_EVS
	redef _tr_pk{d:p}_evs EQUS "\#"
ENDM

MACRO tr_dvs
	def _tr_flags |= TRAINERTYPE_DVS

	; check if a constant was used
	if STRIN("\#", "_")
		redef _tr_pk{d:p}_dvs EQUS "{\#}"
	else
		redef _tr_pk{d:p}_dvs EQUS "\#"
	endc
	def _tr_pk{d:p}_dvs_explicit = TRUE
ENDM

MACRO tr_moves
	def _tr_flags |= TRAINERTYPE_MOVES
	if _NARG > NUM_MOVES
		fail "A mon may only have {d:NUM_MOVES} moves."
	endc
	for i, 1, _NARG + 1
		if STRIN("\<i>", "HP_") == 1
			def _tr_flags |= TRAINERTYPE_DVS ; for Hidden Power type
			def _tr_pk{d:p}_move{d:i} = HIDDEN_POWER
			redef _tr_pk{d:p}_hp_type EQUS "\<i>"
		else
			def _tr_pk{d:p}_move{d:i} = \<i>
		endc
	endr
ENDM

MACRO tr_end
; Write out the party data from stored trainer buffer.
	; First, the trainer name and flags.
	db "{_tr_name}@"
	db _tr_flags

	; Now for all the mon data.
	for p, _tr_mons
		; We can't have implicit moves, for now.
		if (_tr_flags & TRAINERTYPE_MOVES) && _tr_pk{d:p}_move1 == NO_MOVE
			fail "Unspecified move list for _tr_pk{d:p}_species"
		endc

		; If we have implicit DVs, but a Hidden Power type, set that now.
		if STRIN("{_tr_pk{d:p}_hp_type}", "HP_") && _tr_pk{d:p}_dvs_explicit != TRUE
			redef _tr_pk{d:p}_dvs EQUS "{XDVS_{_tr_pk{d:p}_hp_type}}"
		endc
		db _tr_pk{d:p}_level
		dp _tr_pk{d:p}_species, _tr_pk{d:p}_form

		if _tr_flags & TRAINERTYPE_ITEM
			db _tr_pk{d:p}_item
		endc

		if _tr_flags & TRAINERTYPE_DVS
			dv_spread {_tr_pk{d:p}_dvs}
		endc

		if _tr_flags & TRAINERTYPE_PERSONALITY
			db {_tr_pk{d:p}_ability} | {_tr_pk{d:p}_extra}
		endc

		if _tr_flags & TRAINERTYPE_NICKNAME
			db "{_tr_pk{d:p}_nickname}@"
		endc

		if _tr_flags & TRAINERTYPE_EVS
			ev_spread {_tr_pk{d:p}_evs}
		endc

		if _tr_flags & TRAINERTYPE_MOVES
			for i, 1, NUM_MOVES + 1
				db _tr_pk{d:p}_move{d:i}
			endr
		endc
	endr

	def _tr_mons = 0
	db -1
ENDM
