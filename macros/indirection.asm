DEF ___current_indirect_size = 0

; usage:
; Table:
;   indirect_table <entry size>, <start index> (0-1)
;   indirect_entries <max index>, <optional far label>
;   (repeat as many times as necessary)
;   indirect_table_end

MACRO indirect_table
	; arguments: entry size, initial index (0 or 1)
	assert ((\2) * (\2)) == (\2), \
		"indirect table error: invalid initial index (must be 0 or 1)"
	assert !___current_indirect_size, \
		"indirect table error: there's already an active indirect table"
	assert (\1) > 0, \
		"indirect table error: the entry size must be positive"
	assert (\1) <= $7FFF, \
		"indirect table error: entry size is set to an invalid value"
	DEF ___current_indirect_index = \2
	DEF ___current_indirect_size = \1
	dw (\1) | ((\2) << 15)
ENDM

MACRO indirect_entries
	; arguments: next max index, far label (omit for zero/no data), far bank (if different from label)
	assert ___current_indirect_size != 0, \
		"indirect table error: there's no active indirect table"
	assert (\1) >= ___current_indirect_index, \
		"indirect table error: attempted to move backwards"
	DEF ___current_indirect_count = (\1) + 1 - ___current_indirect_index
	DEF ___current_indirect_index = (\1) + 1
	DEF ___current_indirect_iteration_limit = ___current_indirect_count / $FF
	DEF ___current_indirect_count = ___current_indirect_count % $FF
	DEF ___current_indirect_count_total = ((___current_indirect_iteration_limit * $FF) + ___current_indirect_count)
	if _NARG > 1
		assert (\2.IndirectEnd - \2) == ___current_indirect_size * ___current_indirect_count_total, \
			"\2: expected {d:___current_indirect_count_total} entries, each {d:___current_indirect_size} bytes"
	endc
	if ___current_indirect_iteration_limit
		FOR ___current_indirect_iteration, ___current_indirect_iteration_limit
			db $FF
			if _NARG == 1
				db 0, 0, 0
			else
				if _NARG == 2
					db BANK(\2)
				else
					db \3
				endc
				dw (\2) + $FF * ___current_indirect_size * ___current_indirect_iteration
			endc
		endr
	endc
	if ___current_indirect_count
		db ___current_indirect_count
		if _NARG == 1
			db 0, 0, 0
		else
			if _NARG == 2
				db BANK(\2)
			else
				db \3
			endc
			dw (\2) + $FF * ___current_indirect_size * ___current_indirect_iteration_limit
		endc
	endc
ENDM

MACRO indirect_table_end
	; no arguments
	assert ___current_indirect_size != 0, \
		"indirect table error: there's no active indirect table"
	db 0
	DEF ___current_indirect_size = 0
ENDM
