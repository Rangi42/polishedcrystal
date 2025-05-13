; TODO: do `dp mon[, form] / db level` and eliminate this macro
MACRO dbp
	db (\1)
	shift
	dp \#
ENDM

DEF NUM_DV_SPREADS = 0
DEF NUM_EV_SPREADS = 0

; Hidden Power DVs ($00 is converted to $ff in regular trainer sets)
; Chosen for stat importance: Speed > * > Atk (hidden power is a special move)
if DEF(FAITHFUL)
	DEF DVS_HP_FIGHTING EQUS "14 Def, 14 Spe, 14 SAt, 14 SDf"
	DEF DVS_HP_FLYING   EQUS "14 HP, 14 Atk, 14 Def, 14 SAt, 14 SDf"
	DEF DVS_HP_POISON   EQUS "14 Def, 14 SAt, 14 SDf"
	DEF DVS_HP_GROUND   EQUS "14 SAt, 14 SDf"
	DEF DVS_HP_ROCK     EQUS "14 Def, 14 Spe, 14 SDf"
	DEF DVS_HP_BUG      EQUS "14 Atk, 14 Def, 14 SDf"
	DEF DVS_HP_GHOST    EQUS "14 Atk, 14 SDf"
	DEF DVS_HP_STEEL    EQUS "14 SDf"
	DEF DVS_HP_FIRE     EQUS "14 Atk, 14 Spe, 14 SAt"
	DEF DVS_HP_WATER    EQUS "14 Atk, 14 Def, 14 SAt"
	DEF DVS_HP_GRASS    EQUS "14 Atk, 14 SAt"
	DEF DVS_HP_ELECTRIC EQUS "14 SAt"
	DEF DVS_HP_PSYCHIC  EQUS "14 Atk, 14 Spe"
	DEF DVS_HP_ICE      EQUS "14 Atk, 14 Def"
	DEF DVS_HP_DRAGON   EQUS "14 Atk"
	DEF DVS_HP_DARK     EQUS "15 All"
else
	DEF DVS_HP_FIGHTING EQUS "14 Def, 14 Spe, 14 SAt, 14 SDf"
	DEF DVS_HP_FLYING   EQUS "14 Spe, 14 SAt, 14 SDf"
	DEF DVS_HP_POISON   EQUS "14 Def, 14 SAt, 14 SDf"
	DEF DVS_HP_GROUND   EQUS "14 SAt, 14 SDf"
	DEF DVS_HP_ROCK     EQUS "14 Def, 14 Spe, 14 SDf"
	DEF DVS_HP_BUG      EQUS "14 Spe, 14 SDf"
	DEF DVS_HP_GHOST    EQUS "14 Def, 14 SDf"
	DEF DVS_HP_STEEL    EQUS "14 SDf"
	DEF DVS_HP_FIRE     EQUS "14 Def, 14 Spe, 14 SAt"
	DEF DVS_HP_WATER    EQUS "14 Spe, 14 SAt"
	DEF DVS_HP_GRASS    EQUS "14 Def, 14 SAt"
	DEF DVS_HP_ELECTRIC EQUS "14 SAt"
	DEF DVS_HP_PSYCHIC  EQUS "14 Def, 14 Spe"
	DEF DVS_HP_ICE      EQUS "14 Spe"
	DEF DVS_HP_DRAGON   EQUS "14 Def"
	DEF DVS_HP_DARK     EQUS "14 Atk"
	DEF DVS_HP_FAIRY    EQUS "15 All" ; only in nonfaithful
endc

MACRO dv_spread
	def_dvs \#
	if !DEF(DV_SPREAD_FOR_{d:EV_HP}_{d:EV_ATK}_{d:EV_DEF}_{d:EV_SPE}_{d:EV_SAT}_{d:EV_SDF})
		def DV_SPREAD_FOR_{d:EV_HP}_{d:EV_ATK}_{d:EV_DEF}_{d:EV_SPE}_{d:EV_SAT}_{d:EV_SDF} = NUM_DV_SPREADS
		with_each_stat "def DV_SPREAD_{d:NUM_DV_SPREADS}_? EQU EV_?"
		redef NUM_DV_SPREADS += 1
	endc
	db DV_SPREAD_FOR_{d:EV_HP}_{d:EV_ATK}_{d:EV_DEF}_{d:EV_SPE}_{d:EV_SAT}_{d:EV_SDF}
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

DEF _tr_class = 0

MACRO def_trainer_class
; Usage: def_trainer_class <CLASS_CONSTANT>
; CLASS_CONSTANT is defined in trainer_constants.asm
	assert \1 == _tr_class, "Trainer class ID mismatch"
	def _tr_class += 1
	def _tr_party = 1
ENDM

MACRO def_trainer
; Usage: def_trainer <TRAINER_CONSTANT>, <Name>
; TRAINER_CONSTANT is defined in trainer_constants.asm
; If there is no constant associated with the trainer, just use raw
; numbers.
; Name is formatted as "TEXT". Terminator ("@") is implicit.
	; Reset trainer macro state.
	def _tr_flags = 0
	def _tr_mons = 0
	def _tr_nick_lengths = 0
	assert \1 == _tr_party, "Trainer party ID mismatch"
	redef _tr_name EQUS \2
	def _tr_name_length = CHARLEN(\2) + 1
	def _tr_size = 0
	def _tr_party += 1
ENDM

MACRO tr_mon
; Usage: tr_mon <LEVEL>, [Nickname], <SPECIES/SPECIES @ ITEM>, [GENDER+FORM]
; LEVEL determines the level of the mon.
; Nickname (optional) is formatted as "TEXT". Terminator ("@") is implicit.
; SPECIES is the species.
; ITEM (optional) is the held item.
; GENDER?FORM is the secondary species byte, used to define a mon's form and
; gender. Note that if you specify a gender on one mon, you need to do so for
; the entire party for technical reasons. Otherwise, both gender and form is
; optional.
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
	if STRFIND("\2", "\"") == 0
		; The pokémon is nicknamed.
		def _tr_flags |= TRAINERTYPE_NICKNAME
		redef _tr_pk{d:p}_nickname EQUS \2
		def _tr_nick_lengths += CHARLEN(\2)
		shift ; since it's optional
	endc

	if STRIN("\2", "@") != 0
		; Format "Species @ Item" was used, so add the item.
		def _tr_flags |= TRAINERTYPE_ITEM
		redef _tr_pk{d:p}_item EQUS STRSLICE("\2", STRFIND("\2", " @ ") + 3, STRLEN("\2"))
		redef _tr_pk{d:p}_species EQUS STRSLICE("\2", 0, STRFIND("\2", " @ "))
	else
		; Just "Species", no held item.
		redef _tr_pk{d:p}_species EQUS "\2"
	endc

	; Ability constant prefix.
	redef _tr_curabil EQUS "ABIL_{_tr_pk{d:p}_species}"

	; Was form/gender specified?
	if _NARG == 3
		; Is gender defined?
		if STRFIND("\3", "MALE") == -1 && STRFIND("\3", "GENDERLESS") == -1
			; Check if we must define gender (TRAINERTYPE_PERSONALITY enabled).
			if _tr_flags & TRAINERTYPE_PERSONALITY
				fail "No gender specified for current mon."
			endc
		else
			if !(_tr_flags & TRAINERTYPE_PERSONALITY) && p > 0
				fail "No gender specified for previous mon."
			endc
			def _tr_flags |= TRAINERTYPE_PERSONALITY
		endc
		def _tr_pk{d:p}_form = \3

		; Possibly change ability constant prefix based on form.
		if STRFIND("\3", "ALOLAN_FORM") != -1
			redef _tr_curabil EQUS "{_tr_curabil}_ALOLAN"
		elif STRFIND("\3", "GALARIAN_FORM") != -1
			redef _tr_curabil EQUS "{_tr_curabil}_GALARIAN"
		elif STRFIND("\3", "HISUIAN_FORM") != -1
			redef _tr_curabil EQUS "{_tr_curabil}_HISUIAN"
		elif STRFIND("\3", "PALDEAN_FORM") != -1
			redef _tr_curabil EQUS "{_tr_curabil}_PALDEAN"
		endc
	endc

	def _tr_mons += 1
ENDM

MACRO tr_extra
; Usage: tr_extra [ABILITY], [NATURE], [SHINY]
; ABILITY defines a mon's ability. Note that this must be one that the
; species normally gets.
; NATURE defines a mon's nature, in the format "STAT_UP_STAT_DOWN", not
; "ADAMANT". For example, ATK_UP_SATK_DOWN would be Adamant (+Atk -SAt).
; SHINY, if written out, will make a mon shiny.
; All of these parameters are optional, you can choose to just set a mon's
; ability, or just make it shiny.
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
; Usage: tr_evs <SPREAD>
; Spread is written as "X HP/Atk/Def/Spe/SAt/SDf/All" to give a mon X EVs
; in the given stat. You can use "All" to set all EVs to a single value.
; Setting multiple different EV values in different stats is done by separating
; them with commas. For example, "tr_evs 4 Atk, 64 SDf" will give a mon 4 EVs
; in attack and 64 EVs in special defense. Unmentioned stats are set to 0.
	def _tr_flags |= TRAINERTYPE_EVS
	redef _tr_pk{d:p}_evs EQUS "\#"
ENDM

MACRO tr_dvs
; Usage: tr_dvs <SPREAD>
; See tr_evs for SPREAD's syntax, it's the same for tr_dvs.
; WARNING: Unlike tr_evs, unmentioned DVs will be set to 15, not 0!
	def _tr_flags |= TRAINERTYPE_DVS

	; check if a constant was used
	if STRFIND("\#", "_") != -1
		redef _tr_pk{d:p}_dvs EQUS "{\#}"
	else
		redef _tr_pk{d:p}_dvs EQUS "\#"
	endc
	def _tr_pk{d:p}_dvs_explicit = TRUE
ENDM

MACRO tr_moves
; Usage: tr_moves <MOVE1>, [MOVE2], [MOVE3], [MOVE4]
; MOVE* defines a mon's moves. You can specify between 1-4 moves.
; For Hidden Power, use "HP_xxx" where xxx is a type. This will configure
; DVs automatically unless you have already done so.
	def _tr_flags |= TRAINERTYPE_MOVES
	if _NARG > NUM_MOVES
		fail "A mon may only have {d:NUM_MOVES} moves."
	endc
	for i, 1, _NARG + 1
		if STRFIND("\<i>", "HP_") == 0
			def _tr_flags |= TRAINERTYPE_DVS ; for Hidden Power type
			def _tr_pk{d:p}_move{d:i} = HIDDEN_POWER
			redef _tr_pk{d:p}_hp_type EQUS "\<i>"
		else
			def _tr_pk{d:p}_move{d:i} = \<i>
		endc
	endr
ENDM

MACRO end_trainer
; Write out the party data from stored trainer buffer.
	; First, write the byte length of the party.
	; Pokémon data
	def _tr_size += 3 ; level, species, form
	if _tr_flags & TRAINERTYPE_ITEM
		def _tr_size += 1
	endc
	if _tr_flags & TRAINERTYPE_PERSONALITY
		def _tr_size += 1
	endc
	if _tr_flags & TRAINERTYPE_DVS
		def _tr_size += 1
	endc
	if _tr_flags & TRAINERTYPE_EVS
		def _tr_size += 1
	endc
	if _tr_flags & TRAINERTYPE_MOVES
		def _tr_size += NUM_MOVES
	endc
	def _tr_size *= _tr_mons

	if _tr_flags & TRAINERTYPE_NICKNAME
		def _tr_size += _tr_nick_lengths + _tr_mons ; append terminators
	endc

	; Trainer name
	def _tr_size += _tr_name_length

	; Trainer flags
	def _tr_size += 1

	; Party size should never exceed 255, but just in case...
	if _tr_size > 255
		fail "Party size too large"
	endc
	db _tr_size

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
		if STRFIND("{_tr_pk{d:p}_hp_type}", "HP_") != -1 && _tr_pk{d:p}_dvs_explicit != TRUE
			redef _tr_pk{d:p}_dvs EQUS "{DVS_{_tr_pk{d:p}_hp_type}}"
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
ENDM
