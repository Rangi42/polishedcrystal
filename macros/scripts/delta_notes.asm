; Encode a square or noise note. Use zero as the previous frequency
; for the first note in each channel.
; Arguments: frequency width, duration, volume, envelope, frequency.
MACRO _encode_delta_note
	DEF _delta_note_frequency_delta = (\5) - _delta_note_previous_frequency
	DEF _delta_note_previous_frequency = \5
	DEF _delta_note_env = \4
	if _delta_note_env < 0
		DEF _delta_note_env = 8 | -_delta_note_env
	endc
	if (\2) == 0
		DEF _delta_note_index = 0
	elif (\2) == 2
		DEF _delta_note_index = 1
	elif (\2) == 1
		DEF _delta_note_index = 2
	elif (\2) == 5
		DEF _delta_note_index = 3
	else
		DEF _delta_note_index = -1
	endc

	if _delta_note_index >= 0 && _delta_note_env == 8 && -128 <= _delta_note_frequency_delta && _delta_note_frequency_delta <= 127
		db $50 + 16 * _delta_note_index + (\3), LOW(_delta_note_frequency_delta)
	elif _delta_note_index >= 0 && -8 <= _delta_note_frequency_delta && _delta_note_frequency_delta <= 7
		db $90 + 16 * _delta_note_index + (_delta_note_frequency_delta & $f)
		dn \3, _delta_note_env
	elif _delta_note_index >= 0 && (\1) == 2 && (\5) < $800 && (_delta_note_env == 8 || _delta_note_env == 1)
		db $20 + 2 * _delta_note_index + (_delta_note_env == 1), LOW(\5)
		dn \3, HIGH(\5)
	else
		if (\2) >= $20
			db $28
		endc
		db \2
		dn \3, _delta_note_env
		if (\1) == 1
			db \5
		else
			dw \5
		endc
	endc
ENDM
