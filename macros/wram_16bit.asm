MACRO ___wram_conversion_table
	; in:
	; 1: name of the table; will be prefixed to all definitions
	; 2: table size, in entries
	; 3: locked ID table size
	; 4: last allocations table size
	; 5: cache size
	assert (\2) <= $FE, \
		"16-bit conversion table error: too many table entries"
	assert (\2) >= $20, \
		"16-bit conversion table error: too many table entries"
	assert ((\3) + (\4)) <= (\2), \
		"16-bit conversion table error: too many fixed indexes"

	assert (\4) >= 2, \
		"16-bit conversion table error: recent allocations table must contain at least two entries"

	assert !((\5) & ((\5) - 1)), \
		"16-bit conversion table error: invalid cache size"

	assert ((\3) + (\4) + (\5)) <= $100, \
		"16-bit conversion table error: cache would straddle a $100 alignment boundary"

\1::

\1UsedSlots:: db
\1LastAllocatedIndex:: db ; index into LastAllocated
\1Entries:: ds 2 * (\2)
\1EntriesEnd::

; pad to a multiple of $100; ensure that the remaining values share the same high byte
	DEF ___total_bytes = 2 + (2 * (\2)) + (\3) + (\4) + (\5)
	if LOW(___total_bytes)
		ds $100 - LOW(___total_bytes)
	endc

	if \5
	\1EntryCache:: ds \5
	endc

	if \3
	\1LockedEntries:: ds \3
	endc

\1LastAllocated:: ds \4

\1End::

ENDM

MACRO wram_conversion_table
	; uses constants to invoke the macro above
	; in: WRAM prefix, constant prefix
	assert \2_MINIMUM_RESERVED_INDEX <= $FF, \
		"16-bit conversion table error: $FF must be declared as a reserved index"

	assert \2_ENTRIES < \2_MINIMUM_RESERVED_INDEX, \
		"16-bit conversion table error: table entries and reserved indexes overlap"

	___wram_conversion_table \1, \
	                         \2_ENTRIES, \
	                         \2_LOCKED_ENTRIES, \
	                         \2_SAVED_RECENT_INDEXES, \
	                         \2_CACHE_SIZE
ENDM
