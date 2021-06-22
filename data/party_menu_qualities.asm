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

partymenuqualities: MACRO
for i, 1, _NARG + 1
	db PLACE_PARTYMON_\<i>
endr
	db -1 ; end
ENDM

PartyMenuQualityPointers:
; entries correspond to PARTYMENUACTION_* constants
	table_width 2, PartyMenuQualityPointers
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
	assert_table_length NUM_PARTYMENUACTIONS

.Default:
.Gender:   partymenuqualities NICKNAMES, HP_BAR, HP_DIGITS, LEVEL, GENDER, STATUS
.TMHM:     partymenuqualities NICKNAMES, TMHM,              LEVEL, GENDER, STATUS
.EvoStone: partymenuqualities NICKNAMES, EVO,               LEVEL, GENDER, STATUS
.Reminder: partymenuqualities NICKNAMES, RELEARNER,         LEVEL, GENDER, STATUS
.BTLTower: partymenuqualities NICKNAMES, BATTLETOWER,       LEVEL, GENDER, STATUS
