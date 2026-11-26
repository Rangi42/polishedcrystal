; Flag channels whose delta-encoded notes take fewer bytes. If any channel
; contains unknown commands or extra data, keep all channels under that header
; literal, since control flow or the previous frequency could change.
INCLUDE "macros/scripts/delta_notes.asm"

SECTION "Measure Delta Notes", ROMX

PURGE channel_count, channel, square_note, noise_note, duty_cycle, duty_cycle_pattern, sound_ret

MACRO _finish_delta_note_streams
	if _delta_note_valid && !_delta_note_remaining && !_delta_note_raw_notes \
		&& @ - {_delta_note_base} == _delta_note_known_size && STRLEN(#_delta_note_flags)
		println "DEF _delta_note_header_{_delta_note_base} EQU 1"
		print #_delta_note_flags
	endc
ENDM

MACRO channel_count
	if DEF(_delta_note_base)
		_finish_delta_note_streams
	endc
	REDEF _delta_note_base EQUS #.
	REDEF _delta_note_flags EQUS ""
	DEF _delta_note_remaining = \1
	DEF _delta_note_valid = 1
	DEF _delta_note_known_size = 0
	DEF _delta_note_raw_notes = 0
	DEF _delta_note_previous_frequency = 0
ENDM

MACRO channel
	DEF _delta_note_id = \1
	if _delta_note_id < 5 || _delta_note_id > 8 || STRCMP("\2", "{.}_Ch{d:_delta_note_id}")
		DEF _delta_note_valid = 0
	else
		DEF _delta_note_width_\2 = 1 + (_delta_note_id != 8)
	endc
ENDM

MACRO _measure_delta_note
	if !DEF(_delta_note_width_{.}) || STRCMP(#__SCOPE__, ".")
		DEF _delta_note_valid = 0
	elif !ISCONST(\2) || !ISCONST(\3) || !ISCONST(\4) || !ISCONST(\5)
		DEF _delta_note_valid = 0
	elif _delta_note_width_{.} != (\1) || (\2) < 0 || (\2) >= FIRST_MUSIC_CMD \
		|| (\3) < 0 || (\3) > 15 || (\4) < -7 || (\4) > 15 \
		|| (\5) < 0 || (\5) >= 1 << (8 * (\1))
		DEF _delta_note_valid = 0
	endc
	if _delta_note_valid
		DEF _delta_note_before = @ - {_delta_note_base}
		_encode_delta_note \#
		DEF _delta_note_known_size += @ - {_delta_note_base} - _delta_note_before
		DEF _delta_note_raw_notes += 2 + (\1)
	endc
ENDM

MACRO square_note
	_measure_delta_note 2, \#
ENDM

MACRO noise_note
	_measure_delta_note 1, \#
ENDM

; Duty commands and the terminator have equal widths in both formats.
MACRO duty_cycle
ENDM
MACRO duty_cycle_pattern
ENDM

MACRO sound_ret
	if !DEF(_delta_note_width_{.}) || STRCMP(#__SCOPE__, ".")
		DEF _delta_note_valid = 0
	else
		PURGE _delta_note_width_{.}
		if @ - {.} < _delta_note_raw_notes
			REDEF _delta_note_flags EQUS STRCAT(#_delta_note_flags, "DEF _delta_note_channel_{.} EQU 1\n")
		endc
	endc
	DEF _delta_note_raw_notes = 0
	DEF _delta_note_previous_frequency = 0
	DEF _delta_note_remaining -= 1
ENDM

INCLUDE "audio/delta_note_streams.asm"
	_finish_delta_note_streams
