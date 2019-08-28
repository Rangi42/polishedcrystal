; Some functions are defined as macros so they can be reused for multiple 16-bit tables
; (they are not parameterized due to performance constraints; loads and non-evicting stores should be as fast as possible)

MACRO ___conversion_table_load
	; macro arguments: WRAM prefix, constant prefix
	; in: a: 8-bit index
	; out: hl: 16-bit index; a: clobbered
	ld l, a
	ld h, $ff
	cp \2_MINIMUM_RESERVED_INDEX
	ret nc
	inc h
	and a
	ret z
	if (\2_ENTRIES + 1) < \2_MINIMUM_RESERVED_INDEX
		cp \2_ENTRIES + 1
		ld l, h ;return zero for invalid entries (since they will never be allocated)
		ret nc
	endc
	add a, a
	ld l, a
	if \2_ENTRIES >= $80
		; if there are $80 entries or more, we have to deal with carry
		adc HIGH(\1Entries)
		sub l
		ld h, a
	else
		ld h, HIGH(\1Entries)
	endc
	ldh a, [rSVBK]
	push af
	ld a, BANK(\1)
	ldh [rSVBK], a
	ld a, [hli]
	ld h, [hl]
	ld l, a
	pop af
	ldh [rSVBK], a
	ret
ENDM

MACRO ___conversion_table_store
	; macro arguments: WRAM prefix, constant prefix
	; in: hl: 16-bit index
	; out: a: 8-bit index; hl: clobbered
	; This macro must be followed by garbage collection code! The code will call the function at the end of the macro
	; when garbage collection is needed. That code must preserve de and rSVBK.
	ld a, l
	cp \2_MINIMUM_RESERVED_INDEX
	jr c, .not_reserved
	inc h
	ret z
	dec h
.not_reserved
	or h
	ret z

	; we know it's a real index (not zero or a negative reserved value), so check if it is already in the table
	ldh a, [rSVBK]
	push de
	push bc
	push af
	ld e, l
	ld d, h
	ld a, BANK(\1)
	ldh [rSVBK], a

	if \2_CACHE_SIZE
		; if we have a cache, check it first, as it is the fastest way
		if \2_CACHE_SIZE > 1
			ld a, l
			xor h
			and \2_CACHE_SIZE - 1
			add a, LOW(\1EntryCache)
			ld l, a
			ld h, HIGH(\1EntryCache)
			ld a, [hl]
		else
			ld a, [\1EntryCache]
		endc
		and a
		jr z, .cache_miss
		cp \2_ENTRIES + 1
		jr nc, .cache_miss
		ld c, a
		add a, a
		ld l, a
		if \2_ENTRIES >= $80
			; if there are at least $80 entries, we have to deal with carry
			adc HIGH(\1Entries)
			sub l
			ld h, a
		else
			ld h, HIGH(\1Entries)
		endc
		ld a, [hli]
		cp e
		jr nz, .cache_miss
		ld a, [hl]
		cp d
		jp z, .done
	.cache_miss
	endc

	; it's not in the cache (perhaps because we don't even have one), so look for the index in the table
	ld hl, \1Entries
	ld b, h ;not $FF = don't add to the recent indexes list
	DEF ___unroll = 8
	if \2_ENTRIES % ___unroll
		; Duff's device, gbz80 edition
		; note that the block inside the rept is 8 bytes long
		jr @ + 2 + 8 * (___unroll - \2_ENTRIES % ___unroll)
	endc
.search_loop
	rept ___unroll
		ld a, [hli]
		cp e
		ld a, [hli]
		jr nz, :+
		cp d
		jr z, .found
	:
	endr
	ld a, l
	cp LOW(\1EntriesEnd)
	jr nz, .search_loop
	if \2_ENTRIES >= $80
		bit 0, h
		; if HIGH(\1EntriesEnd) is odd, we jump on z; otherwise, we jump on nz
		; so we have to encode a "jr z/nz, .search_loop" instruction according to that value - jr z = $28, jr nz = $20
		db 8 * (HIGH(\1EntriesEnd) & 1) + $20
		db .search_loop - (@ + 1)
	endc

	; not found - we have to allocate the 16-bit ID on the table and return the new 8-bit ID for it
	call .allocate ;returns hl = position + 2
	push hl
	dec hl
	ld a, d
	ld [hld], a
	ld [hl], e
	if \2_ENTRIES >= $80
		ld hl, \1UsedSlots
	else
		ld l, LOW(\1UsedSlots)
	endc
	inc [hl]
	pop hl
	ld b, -1 ;$FF = add to the recent indexes list

.found
	; hl points past the entry
	ld a, l
	if \2_ENTRIES >= $7F
		; if there enough entries, the offset to \1 is 9 bits wide, capping at $1FE for the maximum $FE entries
		; so we set the carry to the value of the top bit of the offset, and then rra this bit into a
		srl h
		; if HIGH(\1) is even, srl h is correct; otherwise, we have to invert it. Since we can't conditionally include a
		; ccf instruction (as it would create a circular dependency between assembler and linker), we have no choice but
		; to execute a ccf on odd HIGH(\1) and a nop on even HIGH(\1) by inserting the correct instruction dynamically
		; using a db. Note that ccf = $3F and nop = $00.
		db (HIGH(\1) & 1) * $3F
		rra
	else
		; with less than $7F entries, the offset is 8 bits wide and always even, so handling it is simpler
		rrca
	endc
	dec a
	ld c, a
	; if there is a cache, store the found ID in it
	if \2_CACHE_SIZE > 1
		ld a, e
		xor d
		and \2_CACHE_SIZE - 1
		add a, LOW(\1EntryCache)
		ld l, a
		ld h, HIGH(\1EntryCache)
		ld [hl], c
	elif \2_CACHE_SIZE == 1
		ld [\1EntryCache], a
	endc

	; if the found ID was just allocated, record it as a recent allocation
	inc b
	jr nz, .done
	ld hl, \1LastAllocatedIndex
	ld a, [hl]
	inc a
	if \2_SAVED_RECENT_INDEXES & (\2_SAVED_RECENT_INDEXES - 1)
		; if the number of recent indexes is not a power of 2, constrain the index to range via a simple comparison...
		cp \2_SAVED_RECENT_INDEXES
		jr c, .no_recent_overflow
		xor a
	.no_recent_overflow
	else
		; ...but if it is a power of 2, it's simpler to just use an and
		and \2_SAVED_RECENT_INDEXES - 1
	endc
	ld [hl], a
	add a, LOW(\1LastAllocated)
	ld l, a
	ld h, HIGH(\1LastAllocated)
	ld [hl], c

.done
	pop af
	ldh [rSVBK], a
	ld a, c
	pop bc
	pop de
	ret

.allocate
	; check if the table isn't already full
	ld hl, \1
	ld a, [hli]
	cp \2_ENTRIES
	jr nc, .no_room
	; try starting at the last allocated position + 1
	ld c, l ;fallback position in case we don't get a valid one; l = LOW(\1LastAllocatedIndex) = 1 here
	ld a, [hl]
	add a, LOW(\1LastAllocated)
	ld l, a
	ld h, HIGH(\1LastAllocated)
	ld a, [hl]
	and a
	jr z, .start_allocation_loop
	cp \2_ENTRIES + 1
	jr nc, .start_allocation_loop
	ld c, a

.start_allocation_loop
	; go from position c until the end of the table, trying to find an empty position
	ld a, \2_ENTRIES + 1
	sub c
	ld b, a
	ld l, c
	sla l
	ld h, HIGH(\1Entries)
	if \2_ENTRIES >= $80
		jr nc, .allocation_loop
		inc h
	endc
.allocation_loop
	ld a, [hli]
	or [hl]
	inc hl ;even if there is no chance of carry, we need to preserve flags
	ret z
	dec b
	jr nz, .allocation_loop

	; no room was found; if we didn't start at c = 1, try with the rest of the table
	ld b, c
	ld c, 1
	if \2_ENTRIES >= $7F
		ld hl, \1Entries
	else
		ld l, LOW(\1Entries)
	endc
	dec b
	jr nz, .allocation_loop

.no_room
	; the table is really full; free up slots and try again (WARNING: the loop won't exit until some slots are freed)
	call .collect_garbage
	ld c, 1
	jr .start_allocation_loop

.collect_garbage
	; as stated at the top, this macro must be followed by garbage-collection code, which must preserve de and rSVBK
	; all other registers are free/clobbers; this code will be called as a function when needed
ENDM

MACRO ___conversion_bitmap_initialize
	; macro arguments: WRAM prefix, constant prefix, bit setting function (must preserve de; may be a local label)
	; falls through; clobbers all registers (make sure to push de before invoking!)
	xor a
	ld hl, wConversionTableBitmap
	DEF ___unroll = 4
	ld c, (\2_ENTRIES + 8 * ___unroll - 1) / (8 * ___unroll)
.initialization_clear_loop
	rept ___unroll
		ld [hli], a
	endr
	dec c
	jr nz, .initialization_clear_loop
	if \2_LOCKED_ENTRIES
		ld de, \1LockedEntries
	else
		ld de, \1LastAllocated
	endc
.initialization_locked_loop
	ld a, [de]
	call \3
	inc e
	jr nz, .initialization_locked_loop
ENDM

MACRO ___conversion_bitmap_check_structs
	; macro arguments: struct pointer, struct length, struct count, bit setting function
	; may clobber anything; falls through
	DEF ___unroll = 8
	if (\3) <= ___unroll
		FOR ___iteration, \3
			ld a, [(\1) + ___iteration * (\2)]
			call \4
		endr
	else
		ld de, \1
		ld hl, wTempLoopCounter
		ld [hl], ((\3) + ___unroll - 1) / ___unroll
		if (\3) % ___unroll
			; again, Duff's device - the body of the rept is 10 bytes long
			jr @ + 2 + 10 * (___unroll - (\3) % ___unroll)
		endc
	.check_loop\@
		rept ___unroll
			ld a, [de]
			ld hl, \2
			add hl, de
			ld d, h
			ld e, l
			call \4
		endr
		ld hl, wTempLoopCounter
		dec [hl]
		jr nz, .check_loop\@
	endc
ENDM

MACRO ___conversion_bitmap_check_values
	; macro arguments: bit setting function, address, address, address...
	for ___unroll, 2, _NARG + 1
		ld a, [\<___unroll>]
		call \1
	endr
ENDM

MACRO ___conversion_bitmap_free_unused
	; macro arguments: WRAM prefix, constant prefix
	ld bc, \2_ENTRIES >> 3
	ld de, wConversionTableBitmap
	ld a, [de]
	inc e
	ld hl, \1Entries
.value_removal_loop
	push de
	ld e, a
	; no ___unroll here since we rely on there being 8 bits per byte
	FOR ___iteration, 8
		srl e
		ld a, [hli]
		jr nc, :+
		or [hl]
		jr nz, :++
	:
		xor a
		ld [hld], a
		ld [hl], a
		dec b
	:
		set 0, l ;so hl points to the second byte of the entry regardless of whether it was cleared
		if (\2_ENTRIES >= $80) && (___iteration == 6)
			inc hl ;the only iteration with any chance of carry is this one
		else
			inc l
		endc
	endr
	pop de
	ld a, [de]
	inc e
	dec c
	jr nz, .value_removal_loop
	if \2_ENTRIES & 7
		; handle the few remaining entries that couldn't be handled by the loop
		ld e, a
		FOR ___iteration, \2_ENTRIES & 7
			; same loop as above
			srl e
			ld a, [hli]
			jr nc, :+
			or [hl]
			jr nz, :++
		:
			xor a
			ld [hld], a
			ld [hl], a
			dec b
		:
			if (___iteration + 1) < (\2_ENTRIES & 7)
				; no point incrementing the pointer if it is the last iteration
				set 0, l
				inc l ;no overflow is possible here
			endc
		endr
	endc
	; b contains minus the number of cleared entries now
	ld a, \2_ENTRIES
	add a, b
	ld [\1UsedSlots], a
ENDM

MACRO ___conversion_bitmap_set
	; macro argument: constant prefix
	; in: a: index - sets the corresponding bit in wConversionTableBitmap if the index is in range
	dec a
	cp \1_ENTRIES
	ret nc
	; what follows duplicates FlagAction in part, but calling the function is slow
	swap a
	rlca
	ld b, a
	and $1f
	add a, LOW(wConversionTableBitmap)
	ld l, a
	ld a, b
	ld h, HIGH(wConversionTableBitmap)
	ld c, [hl]
	inc c
	ret z
	rlca
	add a, a
	ld b, a
	sbc a
	and 3
	inc a
	sla b
	jr nc, .bitmap_set_skip_shift
	add a, a
.bitmap_set_skip_shift
	bit 2, b
	jr z, .bitmap_set_skip_swap
	swap a
.bitmap_set_skip_swap
	or [hl]
	ld [hl], a
	ret
ENDM

MACRO ___conversion_table_lock_ID
	; macro arguments: WRAM prefix, constant prefix
	; in: h = 8-bit index or zero (to clear), l = position
	; out: a = original h, hl = clobbered, carry = set if error
	ld a, l
	cp \2_LOCKED_ENTRIES
	ccf
	ld a, h
	ret c
	cp \2_ENTRIES + 1
	ccf
	ret c
	ldh a, [rSVBK]
	push af
	ld a, BANK(\1)
	ldh [rSVBK], a
	ld a, LOW(\1LockedEntries)
	add a, l
	ld l, a
	ld a, h
	ld h, HIGH(\1LockedEntries)
	ld [hl], a
	ld h, a
	pop af ;carry was clear when pushed, so it remains clear
	ldh [rSVBK], a
	ld a, h
	ret
ENDM
