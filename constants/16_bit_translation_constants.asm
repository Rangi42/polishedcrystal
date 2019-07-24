; constants for 16-bit conversion tables:
; _ENTRIES: number of entries in the table; 8-bit indexes $01, $02, ..., _ENTRIES will point to table entries
; _LOCKED_ENTRIES: number of entries in a reserved ID array; valid IDs stored in this table will be protected from
;                  eviction when the table is garbage collected to make room for new entries (useful to preserve
;                  IDs being used in the current screen, map script, etc.)
; _CACHE_SIZE: number of entries in a fast-retrieval cache table that attempts to make retrieving recently-used
;              indexes faster; must be a power of two (or zero to disable the cache)
; _SAVED_RECENT_INDEXES: circular buffer of recently-allocated IDs, protecting them from eviction and thus simplifying
;                        code that allocates several IDs at once
; _MINIMUM_RESERVED_INDEX: minimum value that will be treated as a special value and not handled through the table;
;                          8-bit IDs that are greater or equal to this value convert to $FF00 + index, and the reverse
;                          conversion is also valid without using the table. This guarantees that high values (such
;                          as $FF), often handled as negative indexes, retain their special meanings without requiring
;                          an allocation
