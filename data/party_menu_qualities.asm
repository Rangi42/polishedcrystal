	const_def
	const PLACE_PARTYMON_NICKNAMES
	const PLACE_PARTYMON_HP_BAR
	const PLACE_PARTYMON_HP_DIGITS
	const PLACE_PARTYMON_LEVEL
	const PLACE_PARTYMON_STATUS
	const PLACE_PARTYMON_TMHM
	const PLACE_PARTYMON_EVO
	const PLACE_PARTYMON_GENDER
	const PLACE_PARTYMON_RELEARNER
	const PLACE_PARTYMON_BATTLETOWER

PartyMenuQualityPointers:
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
	dw .Reminder
	dw .BTLTower

placepartymon: MACRO
rept _NARG
	db PLACE_PARTYMON_\1
shift
endr
	db -1
ENDM

.Default:
.Gender:   placepartymon NICKNAMES, HP_BAR, HP_DIGITS, LEVEL, GENDER, STATUS
.TMHM:     placepartymon NICKNAMES, TMHM,              LEVEL, GENDER, STATUS
.EvoStone: placepartymon NICKNAMES, EVO,               LEVEL, GENDER, STATUS
.Reminder: placepartymon NICKNAMES, RELEARNER,         LEVEL, GENDER, STATUS
.BTLTower: placepartymon NICKNAMES, BATTLETOWER,       LEVEL, GENDER, STATUS
