; HL = source, BC = bit reader. Return one decoded byte in A, updated HL/BC.
; All model accesses stay in this bank. RefillHuffmanBits fetches only bytes
; consumed by the current code, and the caller restores the source bank.
ReadHuffmanToken::
	ld d, h
	ld e, l
	ldh a, [hCompressedTextBuffer]
	add LOW(HuffmanContexts)
	ld l, a
	adc HIGH(HuffmanContexts)
	sub l
	ld h, a
	ld a, [hl]
	add LOW(HuffmanTrees)
	ld l, a
	adc HIGH(HuffmanTrees)
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
	call z, RefillHuffmanBits
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
	cp HUFFMAN_ESCAPE
	jr nz, .got_token
	ld a, 1 ; sentinel shifts out after eight bits
.escape
	dec b
	call z, RefillHuffmanBits
	sla c
	rla
	jr nc, .escape
.got_token
	cp ' '
	jr nc, .literal
	add a
	add LOW(HuffmanPairs)
	ld l, a
	adc HIGH(HuffmanPairs)
	sub l
	ld h, a
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, h
	ldh [hTextPendingChar], a
	ld a, l
	jr .done
.literal
	cp HUFFMAN_FIRST_SHIFTED_TOKEN
	jr c, .done
	sub HUFFMAN_TOKEN_SHIFT
.done
	ld h, d
	ld l, e
	ret

INCLUDE "data/text/compressed_text.asm"
