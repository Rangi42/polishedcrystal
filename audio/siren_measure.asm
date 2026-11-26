; RGBASM sizing pass. Output the names of channels whose packed notes take
; fewer bytes. Unknown commands or extra data keep the entire cry literal,
; since they could change control flow or the frequency predictor.
INCLUDE "macros/scripts/siren.asm"

SECTION "Measure Siren cries", ROMX

PURGE channel_count, channel, square_note, noise_note, duty_cycle, duty_cycle_pattern, sound_ret

MACRO _siren_finish_cry
	if _siren_valid && !_siren_remaining && !_siren_raw_notes \
		&& @ - {_siren_base} == _siren_known_size && STRLEN(#_siren_flags)
		println "DEF _siren_header_{_siren_base} EQU 1"
		print #_siren_flags
	endc
ENDM

MACRO channel_count
	if DEF(_siren_base)
		_siren_finish_cry
	endc
	REDEF _siren_base EQUS #.
	REDEF _siren_flags EQUS ""
	DEF _siren_remaining = \1
	DEF _siren_valid = 1
	DEF _siren_known_size = 0
	DEF _siren_raw_notes = 0
	DEF _siren_previous = 0
ENDM

MACRO channel
	DEF _siren_id = \1
	if _siren_id < 5 || _siren_id > 8 || STRCMP("\2", "{.}_Ch{d:_siren_id}")
		DEF _siren_valid = 0
	else
		DEF _siren_width_\2 = 1 + (_siren_id != 8)
	endc
ENDM

MACRO _siren_measure_note
	if !DEF(_siren_width_{.}) || STRCMP(#__SCOPE__, ".")
		DEF _siren_valid = 0
	elif !ISCONST(\2) || !ISCONST(\3) || !ISCONST(\4) || !ISCONST(\5)
		DEF _siren_valid = 0
	elif _siren_width_{.} != (\1) || (\2) < 0 || (\2) >= FIRST_MUSIC_CMD \
		|| (\3) < 0 || (\3) > 15 || (\4) < -7 || (\4) > 15 \
		|| (\5) < 0 || (\5) >= 1 << (8 * (\1))
		DEF _siren_valid = 0
	endc
	if _siren_valid
		DEF _siren_before = @ - {_siren_base}
		_siren_note \#
		DEF _siren_known_size += @ - {_siren_base} - _siren_before
		DEF _siren_raw_notes += 2 + (\1)
	endc
ENDM

MACRO square_note
	_siren_measure_note 2, \#
ENDM

MACRO noise_note
	_siren_measure_note 1, \#
ENDM

; Duty commands and the terminator have equal widths in both formats.
MACRO duty_cycle
ENDM
MACRO duty_cycle_pattern
ENDM

MACRO sound_ret
	if !DEF(_siren_width_{.}) || STRCMP(#__SCOPE__, ".")
		DEF _siren_valid = 0
	else
		PURGE _siren_width_{.}
		if @ - {.} < _siren_raw_notes
			REDEF _siren_flags EQUS STRCAT(#_siren_flags, "DEF _siren_pack_{.} EQU 1\n")
		endc
	endc
	DEF _siren_raw_notes = 0
	DEF _siren_previous = 0
	DEF _siren_remaining -= 1
ENDM

INCLUDE "audio/siren_cries.asm"
	_siren_finish_cry
