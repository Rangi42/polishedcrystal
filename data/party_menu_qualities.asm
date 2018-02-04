	const_def
	const PLACE_PARTYMON_NICKNAMES
	const PLACE_PARTYMON_HP_BAR
	const PLACE_PARTYMON_HP_DIGITS
	const PLACE_PARTYMON_LEVEL
	const PLACE_PARTYMON_STATUS
	const PLACE_PARTYMON_TMHM
	const PLACE_PARTYMON_EVO
	const PLACE_PARTYMON_GENDER

PartyMenuQualityPointers: ; 503b2
; entries correspond to PARTYMENUACTION_* constants
	dw .Default
	dw .Default
	dw .Default
	dw .TMHM
	dw .Default
	dw .EvoStone
	dw .Gender
	dw .Gender
	dw .Default
	dw .Default
; 503c6

placepartymon: macro
rept _NARG
	db PLACE_PARTYMON_\1
shift
endr
	db -1
endm

.Default:
.Gender:   placepartymon NICKNAMES, HP_BAR, HP_DIGITS, LEVEL, GENDER, STATUS
.TMHM:     placepartymon NICKNAMES, TMHM,              LEVEL, GENDER, STATUS
.EvoStone: placepartymon NICKNAMES, EVO,               LEVEL, GENDER, STATUS
; 503e0
