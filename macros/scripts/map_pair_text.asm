; Build RGBDS lookups from the same canonical groups used by the ROM reader.
MACRO x_pair_rule
	DEF _left = \1
	DEF _right = \2
	DEF _map_pair_{02X:_left}{02X:_right} EQU _pair_index
	DEF _pair_index += 1
ENDM

MACRO x_pair_contexts
	rept _NARG
		DEF _map_context_{02X:_context_byte} EQU \1
		DEF _context_byte += 1
		shift
	endr
ENDM

MACRO x_pair_codes
	DEF _code <<= 1
	DEF _length += 1
	rept _NARG
		DEF _symbol = \1
		DEF _map_code_{d:_tree}_{02X:_symbol} EQU _code
		DEF _map_length_{d:_tree}_{02X:_symbol} EQU _length
		DEF _code += 1
		shift
	endr
ENDM

INCLUDE "data/text/map_pair_models.inc"

DEF _pair_index = 0
map_pair_rules
assert _pair_index <= ' '
DEF _context_byte = 0
map_pair_contexts
assert _context_byte == 256
for _tree, NUM_MAP_PAIR_TREES
	DEF _code = 0
	DEF _length = 0
	map_pair_tree_{d:_tree}
	; An escape can also beat a long direct code.
	DEF _escape_length = _map_length_{d:_tree}_FF + 8
	for _symbol, LAST_SHIFTED_LEAF_NODE_ID + 1
		if !DEF(_map_length_{d:_tree}_{02X:_symbol}) || _map_length_{d:_tree}_{02X:_symbol} > _escape_length
			REDEF _map_length_{d:_tree}_{02X:_symbol} EQU _escape_length
			REDEF _map_code_{d:_tree}_{02X:_symbol} EQU (_map_code_{d:_tree}_FF << 8) | _symbol
		endc
	endr
endr

; The context at a position only depends on the preceding source byte. Work
; backwards, comparing one literal plus the best remaining suffix against a
; pair plus the suffix two bytes ahead. On equal bit costs prefer the pair.
MACRO _try_map_pairs
	DEF _cost_one_ahead = 0
	DEF _cost_two_ahead = 0
	DEF _following = 0 ; outside the pair alphabet
	for _pos, _raw_bytes - 1, -1, -1
		DEF _previous = ' '
		if _pos
			DEF _prev_pos = _pos - 1
			DEF _previous = _raw_byte_{d:_prev_pos}
		endc
		DEF _context = _map_context_{02X:_previous}
		DEF _byte = _raw_byte_{d:_pos}
		DEF _token = _byte
		if _byte < ' '
			DEF _token += FIRST_SHIFTED_LEAF_NODE_ID - FIRST_SHIFTED_LEAF_CHAR_ID
		endc
		DEF _cost = _map_length_{d:_context}_{02X:_token} + _cost_one_ahead
		if DEF(_map_pair_{02X:_byte}{02X:_following})
			DEF _pair = _map_pair_{02X:_byte}{02X:_following}
			DEF _pair_cost = _map_length_{d:_context}_{02X:_pair} + _cost_two_ahead
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

	; _dchr already chose legacy over raw. Replace it only for a byte saving.
	if 1 + (_cost_one_ahead + 7) / 8 < _compressed_bytes
		_write_map_pairs
	endc
ENDM

MACRO _write_map_pairs
	DEF _compressed_bytes = 1
	DEF _compressed_byte_0 = '<MAP_PAIR_TEXT_MARKER>'
	DEF _pair_bits = 0
	DEF _pending_bits = 0
	DEF _previous = ' '
	DEF _pos = 0
	rept _raw_bytes
		if _pos == _raw_bytes
			break
		endc
		DEF _context = _map_context_{02X:_previous}
		DEF _token = _choice_{d:_pos}
		DEF _length = _map_length_{d:_context}_{02X:_token}
		DEF _code = _map_code_{d:_context}_{02X:_token}
		DEF _pair_bits = (_pair_bits << _length) | _code
		DEF _pending_bits += _length
		rept _pending_bits / 8
			DEF _pending_bits -= 8
			DEF _compressed_byte_{d:_compressed_bytes} = (_pair_bits >> _pending_bits) & $ff
			DEF _compressed_bytes += 1
		endr
		DEF _pair_bits &= (1 << _pending_bits) - 1
		DEF _pos += 1 + (_token < ' ')
		DEF _prev_pos = _pos - 1
		DEF _previous = _raw_byte_{d:_prev_pos}
	endr
	if _pending_bits
		DEF _compressed_byte_{d:_compressed_bytes} = _pair_bits << (8 - _pending_bits)
		DEF _compressed_bytes += 1
	endc
ENDM

; Emit the exact eligible bytes after RGBDS charmap expansion. The two local
; symbols bracket the chosen representation, including a synthesized terminator
; only when required by that representation before an inline command.
DEF _pair_record_id = 0
MACRO _pair_text_record
.pair_text_start{d:_pair_record_id}:
	print "PAIR {d:_pair_record_id} {d:_compression_terminator} "
	for _i, _raw_bytes
		print "{02X:_raw_byte_{d:_i}}"
	endr
	println ""
ENDM
