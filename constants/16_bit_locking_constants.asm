; Move locked ID table constants
	const_def

if const_value > MOVE_TABLE_LOCKED_ENTRIES
	fail "Too many locked move IDs"
endc
