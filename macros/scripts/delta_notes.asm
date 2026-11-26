; Only adjacent notes under the same named label share a packet. A call, loop or
; jump can enter a label with any frequency, and a pitch slide can change the
; first note's frequency between frames. Two consecutive notes establish a
; predictor independent of the entry path. Use a raw note at an anonymous
; label or a computed entry point, which has no scope of its own.
DEF _note_scope EQUS ""
DEF _note_width = 0
DEF _note_can_predict = 0
DEF _note_in_packet = 0

MACRO _delta_note ; frequency width, duration, volume, envelope, frequency
	DEF _adjacent = 0
	if STRLEN(#__SCOPE__)
		if !STRCMP(#_note_scope, #{__SCOPE__}) && _note_width == (\1)
			DEF _adjacent = @ - {{__SCOPE__}} == _note_end
		endc
	endc

	DEF _note_tag = -1
	if ISCONST(\2) && ISCONST(\3) && ISCONST(\4) && ISCONST(\5)
		if 0 <= (\2) && (\2) <= DELTA_NOTE_DURATION_MASK && 0 <= (\3) && (\3) < 16 \
			&& -7 <= (\4) && (\4) < 16 && 0 <= (\5) && (\5) < 1 << (8 * (\1))
			_choose_delta_note \#
		endc
	endc
	if _note_tag >= delta_absolute_cmd
		; Bit 3 of the high frequency byte is free in an 11-bit tone.
		REDEF _note_more EQUS "_more_notes\@"
		db _note_tag, LOW(\5), ((\3) << 4) | HIGH(\5) | (DELTA_NOTE_ABS_MORE * {_note_more})
		DEF {_note_more} = 0
	elif _note_tag >= 0
		DEF _note_start = !_adjacent || !_note_in_packet
		if !_note_start
			REDEF {_note_more} = 1
		endc
		; RGBLINK fills the continuation bit once the next note has had
		; a chance to join. Labels and branch targets keep their positions.
		REDEF _note_more EQUS "_more_notes\@"
		if _note_start && (\1) == 1
			; A lone noise note uses three bytes in either format. Keep its
			; raw encoding unless the following note shares the marker.
			_note_choice \2, delta_notes_cmd, {_note_more}
			_note_choice _note_intensity, _note_tag + DELTA_NOTE_MORE, {_note_more}
			_note_choice LOW(\5), _note_operand, {_note_more}
		else
			if _note_start
				db delta_notes_cmd
			endc
			db _note_tag + DELTA_NOTE_MORE * {_note_more}, _note_operand
		endc
		DEF {_note_more} = 0
	elif (\1) == 1
		raw_noise_note \2, \3, \4, \5
	else
		raw_square_note \2, \3, \4, \5
	endc
	DEF _note_in_packet = _note_tag >= 0
	DEF _note_width = \1
	DEF _note_can_predict = _adjacent && ISCONST(\5)
	if ISCONST(\5)
		DEF _note_frequency = \5
	endc
	if STRLEN(#__SCOPE__)
		REDEF _note_scope EQUS #{__SCOPE__}
		DEF _note_end = @ - {{__SCOPE__}}
	else
		REDEF _note_scope EQUS ""
	endc
ENDM

MACRO _note_choice ; raw byte, packed byte, forward-referenced 0 or 1
	db (\1) + ((\2) - (\1)) * (\3)
ENDM

MACRO _choose_delta_note
	DEF _note_env = \4
	if _note_env < 0
		DEF _note_env = AUD1ENV_UP | -_note_env
	endc
	DEF _note_intensity = ((\3) << 4) | _note_env
	if _adjacent && _note_can_predict
		DEF _frequency_delta = (\5) - _note_frequency
		if _note_env == DELTA_NOTE_ENVELOPE && -128 <= _frequency_delta && _frequency_delta <= 127
			DEF _note_tag = DELTA_NOTE_BYTE + 16 * (\2) + (\3)
			DEF _note_operand = LOW(_frequency_delta)
		elif (\2) < 2 && -DELTA_NOTE_SIGN <= _frequency_delta && _frequency_delta < DELTA_NOTE_SIGN
			DEF _note_tag = DELTA_NOTE_NIBBLE + 16 * (\2) + (_frequency_delta & DELTA_NOTE_NIBBLE_MASK)
			DEF _note_operand = _note_intensity
		endc
	endc
	if _note_tag < 0 && (\1) == 2 && (\5) < 1 << DELTA_NOTE_PITCH_BITS && (_note_env == DELTA_NOTE_ENVELOPE || _note_env == DELTA_NOTE_ALT_ENV)
		DEF _note_tag = delta_absolute_cmd + 2 * (\2) + (_note_env == DELTA_NOTE_ALT_ENV)
	endc
ENDM
