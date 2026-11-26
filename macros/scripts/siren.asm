; Pack a Siren note. The channel's previous frequency is zero at its start.
; Arguments: frequency width, duration, volume, envelope, frequency.
MACRO _siren_note
	DEF _siren_delta = (\5) - _siren_previous
	DEF _siren_previous = \5
	DEF _siren_env = \4
	if _siren_env < 0
		DEF _siren_env = 8 | -_siren_env
	endc
	if (\2) == 0
		DEF _siren_index = 0
	elif (\2) == 2
		DEF _siren_index = 1
	elif (\2) == 1
		DEF _siren_index = 2
	elif (\2) == 5
		DEF _siren_index = 3
	else
		DEF _siren_index = -1
	endc

	if _siren_index >= 0 && _siren_env == 8 && -128 <= _siren_delta && _siren_delta <= 127
		db $50 + 16 * _siren_index + (\3), LOW(_siren_delta)
	elif _siren_index >= 0 && -8 <= _siren_delta && _siren_delta <= 7
		db $90 + 16 * _siren_index + (_siren_delta & $f)
		dn \3, _siren_env
	elif _siren_index >= 0 && (\1) == 2 && (\5) < $800 && (_siren_env == 8 || _siren_env == 1)
		db $20 + 2 * _siren_index + (_siren_env == 1), LOW(\5)
		dn \3, HIGH(\5)
	else
		if (\2) >= $20
			db $28
		endc
		db \2
		dn \3, _siren_env
		if (\1) == 1
			db \5
		else
			dw \5
		endc
	endc
ENDM
