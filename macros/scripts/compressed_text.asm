; Build RGBDS lookups from the same canonical groups used by the ROM reader.
MACRO x_pair_rule
	DEF _left = \1
	DEF _right = \2
	DEF _text_pair_{02X:_left}{02X:_right} EQU _pair_index
	DEF _pair_index += 1
ENDM

MACRO x_pair_contexts
	rept _NARG
		DEF _text_context_{02X:_context_byte} EQU \1
		DEF _context_byte += 1
		shift
	endr
ENDM

MACRO x_pair_codes
	DEF _code <<= 1
	DEF _length += 1
	rept _NARG
		DEF _symbol = \1
		DEF _text_code_{d:_tree}_{02X:_symbol} EQU _code
		DEF _text_length_{d:_tree}_{02X:_symbol} EQU _length
		DEF _code += 1
		shift
	endr
ENDM

INCLUDE "data/text/huffman_model.inc"

DEF _pair_index = 0
huffman_pairs
assert _pair_index <= ' '
DEF _context_byte = 0
huffman_contexts
assert _context_byte == 256
for _tree, NUM_HUFFMAN_TREES
	DEF _code = 0
	DEF _length = 0
	huffman_tree_{d:_tree}
	; An escape can also beat a long direct code.
	DEF _escape_length = _text_length_{d:_tree}_FF + 8
	for _symbol, HUFFMAN_LAST_SHIFTED_TOKEN + 1
		if !DEF(_text_length_{d:_tree}_{02X:_symbol}) || _text_length_{d:_tree}_{02X:_symbol} > _escape_length
			REDEF _text_length_{d:_tree}_{02X:_symbol} EQU _escape_length
			REDEF _text_code_{d:_tree}_{02X:_symbol} EQU (_text_code_{d:_tree}_FF << 8) | _symbol
		endc
	endr
endr

PURGE x_pair_rule, x_pair_contexts, x_pair_codes

; The context at a position only depends on the preceding source byte. Work
; backwards, comparing one literal plus the best remaining suffix against a
; pair plus the suffix two bytes ahead. On equal bit costs prefer the pair.
MACRO _emit_text_segment
	DEF _cost_one_ahead = 0
	DEF _cost_two_ahead = 0
	DEF _following = 0 ; outside the pair alphabet
	for _pos, _raw_bytes - 1, -1, -1
		DEF _previous = ' '
		if _pos
			DEF _prev_pos = _pos - 1
			DEF _previous = _raw_byte_{d:_prev_pos}
		endc
		DEF _context = _text_context_{02X:_previous}
		DEF _byte = _raw_byte_{d:_pos}
		DEF _token = _byte
		if _byte < ' '
			DEF _token += HUFFMAN_TOKEN_SHIFT
		endc
		DEF _cost = _text_length_{d:_context}_{02X:_token} + _cost_one_ahead
		if DEF(_text_pair_{02X:_byte}{02X:_following})
			DEF _pair = _text_pair_{02X:_byte}{02X:_following}
			DEF _pair_cost = _text_length_{d:_context}_{02X:_pair} + _cost_two_ahead
			if _pair_cost <= _cost
				DEF _token = _pair
				DEF _cost = _pair_cost
			endc
		endc
		DEF _choice_{d:_pos} = _token
		DEF _cost_two_ahead = _cost_one_ahead
		DEF _cost_one_ahead = _cost
		DEF _following = _byte
	endr

	; Include the marker and final padding in the size comparison.
	DEF _raw_size = _raw_bytes - _compression_terminator
	if 1 + (_cost_one_ahead + 7) / 8 < _raw_size
		_write_compressed_text
	else
		for _pos, _raw_size
			db _raw_byte_{d:_pos}
		endr
	endc
ENDM

MACRO _write_compressed_text
	db '<CTXT>'
	DEF _pair_bits = 0
	DEF _pending_bits = 0
	DEF _previous = ' '
	DEF _pos = 0
	rept _raw_bytes
		if _pos == _raw_bytes
			break
		endc
		DEF _context = _text_context_{02X:_previous}
		DEF _token = _choice_{d:_pos}
		DEF _length = _text_length_{d:_context}_{02X:_token}
		DEF _code = _text_code_{d:_context}_{02X:_token}
		DEF _pair_bits = (_pair_bits << _length) | _code
		DEF _pending_bits += _length
		rept _pending_bits / 8
			DEF _pending_bits -= 8
			db (_pair_bits >> _pending_bits) & $ff
		endr
		DEF _pair_bits &= (1 << _pending_bits) - 1
		DEF _pos += 1 + (_token < ' ')
		DEF _prev_pos = _pos - 1
		DEF _previous = _raw_byte_{d:_prev_pos}
	endr
	if _pending_bits
		db _pair_bits << (8 - _pending_bits)
	endc
ENDM

; Emit the exact eligible bytes after RGBDS charmap expansion. The two local
; symbols bracket the chosen representation, including a synthesized terminator
; only when required by that representation before an inline command.
DEF _pair_record_id = 0
MACRO _pair_text_record
.pair_text_{d:_pair_record_id}_start:
	print "PAIR {.}.pair_text_{d:_pair_record_id} {d:_compression_terminator} "
	for _i, _raw_bytes
		print "{02X:_raw_byte_{d:_i}}"
	endr
	println ""
ENDM
