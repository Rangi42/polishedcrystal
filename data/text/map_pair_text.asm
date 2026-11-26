SECTION "Map dialogue decoder", ROMX

; HL = source, BC = bit reader. Return one decoded byte in A, updated HL/BC.
; All model accesses stay in this bank. RefillMapPairBits fetches only bytes
; consumed by the current code, and the caller restores the source bank.
ReadMapPairToken::
	ld d, h
	ld e, l
	ldh a, [hCompressedTextBuffer]
	add LOW(MapPairContexts)
	ld l, a
	adc HIGH(MapPairContexts)
	sub l
	ld h, a
	ld a, [hl]
	add LOW(MapPairTrees)
	ld l, a
	adc HIGH(MapPairTrees)
	sub l
	ld h, a
	ld a, [hli]
	ld h, [hl]
	ld l, a

	; Each length has a count and a one-byte displacement to the end of its
	; symbols. Skip a whole group in constant time for each extra code bit.
	; A is the prefix with all shorter codes subtracted.
	xor a
.read_bit
	dec b
	call z, RefillMapPairBits
	sla c
	rla
	sub [hl]
	inc hl
	jr c, .found
	inc hl
	jr .read_bit
.found
	; A is now the negative distance from the end of this length's symbols.
	add [hl]
	add l
	ld l, a
	adc h
	sub l
	ld h, a
	ld a, [hl]
	cp $ff
	jr nz, .got_token
	ld a, 1 ; sentinel shifts out after eight bits
.escape
	dec b
	call z, RefillMapPairBits
	sla c
	rla
	jr nc, .escape
.got_token
	cp ' '
	jr nc, .literal
	add a
	add LOW(MapPairDictionary)
	ld l, a
	adc HIGH(MapPairDictionary)
	sub l
	ld h, a
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, h
	ldh [hTextPairState], a
	ld a, l
	jr .done
.literal
	cp FIRST_SHIFTED_LEAF_NODE_ID
	jr c, .done
	sub FIRST_SHIFTED_LEAF_NODE_ID - FIRST_SHIFTED_LEAF_CHAR_ID
.done
	ld h, d
	ld l, e
	ret

INCLUDE "data/text/map_pair_models.inc"

MACRO pair_rule
	assert (\1 == ' ' || (\1 >= 'A' && \1 <= 'Z') || (\1 >= 'a' && \1 <= 'z'))
	assert (\2 == ' ' || (\2 >= 'A' && \2 <= 'Z') || (\2 >= 'a' && \2 <= 'z'))
	db \1, \2
ENDM

MACRO pair_contexts
	rept _NARG
		db 2 * \1 ; byte offset in the pointer table
		shift
	endr
ENDM

MACRO pair_codes
	if _emit_symbols
		if _NARG
			db \#
		endc
	else
		DEF _rank += _NARG
		db _NARG
		db .Symbols{d:tree} + _rank - @
	endc
ENDM

MapPairDictionary:
	map_pair_rules
MapPairContexts:
	map_pair_contexts
MapPairTrees:
	for tree, NUM_MAP_PAIR_TREES
		dw .Tree{d:tree}
	endr
	for tree, NUM_MAP_PAIR_TREES
.Tree{d:tree}:
		DEF _rank = 0
		DEF _emit_symbols = 0
		map_pair_tree_{d:tree}
.Symbols{d:tree}:
		DEF _emit_symbols = 1
		map_pair_tree_{d:tree}
	endr
MapPairModelsEnd:
