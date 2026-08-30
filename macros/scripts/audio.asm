DEF MUSIC_HUFFMAN_FIRST_LEAF EQU $80
DEF MUSIC_HUFFMAN_ESCAPE_LEAF EQU $ff
DEF NUM_MUSIC_HUFFMAN_DIRECT_LEAVES EQU 127

MACRO musichuffmap
	DEF x = \1
	DEF y = \2
	DEF ___music_huffman_data_{02X:x} EQU %\3
	DEF ___music_huffman_length_{02X:x} EQU STRLEN("\3")
	DEF ___music_huffman_leaf_\3 EQU MUSIC_HUFFMAN_FIRST_LEAF + \2
	DEF MUSIC_HUFFMAN_LEAF_{d:y} EQU \1
ENDM

MACRO musichuffesc
	DEF x = \1
	DEF ___music_huffman_data_{02X:x} EQU %\2
	DEF ___music_huffman_length_{02X:x} EQU STRLEN("\2")
ENDM

MACRO musichuffleaf
	DEF ___music_huffman_escape_\1 = 1
ENDM

INCLUDE "constants/music_huffman.asm"

DEF _compressing_music = 0
DEF _music_header_active = 0
DEF _music_channel_pending = 0
DEF _music_bits = 0
DEF _music_bit_count = 0
DEF _music_stream_has_data = 0
DEF _music_root EQUS "none"

MACRO _music_align
	if _compressing_music && _music_bit_count
		db _music_bits << (8 - _music_bit_count)
		DEF _music_bits = 0
		DEF _music_bit_count = 0
	endc
	if _compressing_music
		DEF _music_stream_has_data = 0
	endc
ENDM

MACRO _music_byte
	if !_compressing_music
		db \1
	else
		DEF _music_stream_has_data = 1
		DEF _music_value = (\1) & $ff
		if DEF(MUSIC_HUFFMAN)
			println "${02x:_music_value}"
		endc
		DEF _music_bits = (_music_bits << ___music_huffman_length_{02X:_music_value}) \
			| ___music_huffman_data_{02X:_music_value}
		DEF _music_bit_count += ___music_huffman_length_{02X:_music_value}
		rept 4
			if _music_bit_count >= 8
				db _music_bits >> (_music_bit_count - 8)
				DEF _music_bit_count -= 8
				DEF _music_bits &= (1 << _music_bit_count) - 1
			endc
		endr
	endc
ENDM

MACRO _music_word
	if _compressing_music
		_music_byte LOW(\1)
		_music_byte HIGH(\1)
	else
		dw \1
	endc
ENDM

MACRO _music_nibbles
	_music_byte ((\1) << 4) | ((\2) & $f)
ENDM

MACRO _music_pointer
	if _compressing_music
		_music_align
		dw \1_music_restart
	else
		dw \1
	endc
.___music_restart_\@:
	if _compressing_music && DEF(MUSIC_HUFFMAN)
		println "!~{_music_root}:\@"
	endc
ENDM

MACRO music_header
	_redef_current_label CURRENT_MUSIC_LABEL, ".music_header_\@", \#
	_music_align
	DEF _compressing_music = 0
	DEF _music_header_active = 1
	DEF _music_channel_pending = 0
	REDEF _music_root EQUS "{CURRENT_MUSIC_LABEL}"
ENDM

MACRO music_label
	_redef_current_label CURRENT_MUSIC_LABEL, ".music_label_\@", \#
	if _compressing_music && _music_stream_has_data
		_music_byte music_align_cmd
	endc
	_music_align
{CURRENT_MUSIC_LABEL}_music_restart:
	if _music_channel_pending
		DEF _compressing_music = 1
		DEF _music_header_active = 0
		DEF _music_channel_pending = 0
	endc
	if _compressing_music && DEF(MUSIC_HUFFMAN)
		println "!{CURRENT_MUSIC_LABEL}_music_restart"
	endc
ENDM

MACRO music_end
	_music_align
	DEF _compressing_music = 0
	DEF _music_header_active = 0
	DEF _music_channel_pending = 0
	DEF _music_stream_has_data = 0
ENDM

MACRO compressed_music_pointer
	db TRUE
	dba \1
ENDM

MACRO channel_count
	assert 0 < (\1) && (\1) <= NUM_MUSIC_CHANS, \
		"channel_count must be 1-{d:NUM_MUSIC_CHANS}"
	DEF _num_channels = \1 - 1
ENDM

MACRO channel
	assert 0 < (\1) && (\1) <= NUM_CHANNELS, \
		"channel id must be 1-{d:NUM_CHANNELS}"
	dn (_num_channels << 2), \1 - 1 ; channel id
	if _music_header_active
		dw \2_music_restart ; compressed music address
		DEF _music_channel_pending = 1
	else
		dw \2 ; uncompressed SFX or cry address
	endc
	DEF _num_channels = 0
ENDM

MACRO note
	_music_nibbles \1, (\2) - 1 ; pitch, length
ENDM

MACRO drum_note
	note \1, \2 ; drum instrument, length
ENDM

MACRO rest
	note 0, \1 ; length
ENDM

MACRO square_note
	db \1 ; length
	if \3 < 0
		dn \2, %1000 | (\3 * -1) ; volume envelope
	else
		dn \2, \3 ; volume envelope
	endc
	dw \4 ; frequency
ENDM

MACRO noise_note
	db \1 ; length
	if \3 < 0
		dn \2, %1000 | (\3 * -1) ; volume envelope
	else
		dn \2, \3 ; volume envelope
	endc
	db \4 ; frequency
ENDM

; MusicCommands indexes (see audio/engine.asm)
	const_def $d0
DEF FIRST_MUSIC_CMD EQU const_value

	const octave_cmd ; $d0
	assert octave_cmd & %111 == 0, "octave_cmd must be 3-bit aligned"
MACRO octave
	assert 1 <= (\1) && (\1) <= 8, "octave must be 1-8"
	_music_byte octave_cmd + 8 - (\1) ; octave
ENDM

	const_skip 7 ; all octave values

	const duty_cycle_cmd ; $d8
	assert duty_cycle_cmd & %11 == 0, "duty_cycle_cmd must be 2-bit aligned"
MACRO duty_cycle
	assert 0 <= (\1) && (\1) <= 6, "duty cycle must be 0-6"
	_music_byte duty_cycle_cmd | (\1 & 3) ; values 4-6 fold into 0-2
ENDM

	const_skip 3 ; all duty cycle values

	const note_type_cmd ; $dc
MACRO note_type
	_music_byte note_type_cmd
	_music_byte \1 ; note length
	if _NARG >= 2
		if \3 < 0
			_music_nibbles \2, %1000 | (\3 * -1) ; volume envelope
		else
			_music_nibbles \2, \3 ; volume envelope
		endc
	endc
ENDM

; only valid on the noise channel
MACRO drum_speed
	note_type \1 ; note length
ENDM

	const transpose_cmd ; $dd
MACRO transpose
	_music_byte transpose_cmd
	_music_nibbles \1, \2 ; num octaves, num pitches
ENDM

	const tempo_cmd ; $de
MACRO tempo
	_music_byte tempo_cmd
	_music_word \1 ; tempo
ENDM

	const volume_envelope_cmd ; $df
MACRO volume_envelope
	_music_byte volume_envelope_cmd
	if \2 < 0
		_music_nibbles \1, %1000 | (\2 * -1) ; volume envelope
	else
		_music_nibbles \1, \2 ; volume envelope
	endc
ENDM

	const pitch_sweep_cmd ; $e0
MACRO pitch_sweep
	_music_byte pitch_sweep_cmd
	if \2 < 0
		_music_nibbles \1, %1000 | (\2 * -1) ; pitch sweep
	else
		_music_nibbles \1, \2 ; pitch sweep
	endc
ENDM

	const duty_cycle_pattern_cmd ; $e1
MACRO duty_cycle_pattern
	_music_byte duty_cycle_pattern_cmd
	_music_byte (\1 << 6) | (\2 << 4) | (\3 << 2) | (\4 << 0) ; duty cycle pattern
ENDM

	const toggle_sfx_cmd ; $e2
MACRO toggle_sfx
	_music_byte toggle_sfx_cmd
ENDM

	const pitch_slide_cmd ; $e3
MACRO pitch_slide
	_music_byte pitch_slide_cmd
	_music_byte \1 - 1 ; duration
	_music_nibbles 8 - \2, \3 % 12 ; octave, pitch
ENDM

	const vibrato_cmd ; $e4
MACRO vibrato
	_music_byte vibrato_cmd
	_music_byte \1 ; delay
	if _NARG > 2
		_music_nibbles \2, \3 ; extent, rate
	else
		_music_byte \2 ; LEGACY: Support for 1-arg extent
	endc
ENDM

	const toggle_noise_cmd ; $e5
DEF _toggle_noisesampleset = 0
MACRO toggle_noise
	; `toggle_noise` followed by `toggle_noise N` acts like `noisesampleset N`
	; This maintains compatibility with Crystal Tracker
	if _NARG == 0
		DEF _toggle_noisesampleset = 1
	elif _toggle_noisesampleset
		DEF _toggle_noisesampleset = 0
		_music_byte noisesampleset_cmd
		_music_byte \1 ; noise
	else
		_music_byte toggle_noise_cmd
		_music_byte \1 ; drum kit
	endc
ENDM

MACRO sfx_toggle_noise
	toggle_noise \#
ENDM

	const volume_cmd ; $e6
MACRO volume
	_music_byte volume_cmd
	if _NARG > 1
		_music_nibbles \1, \2 ; left volume, right volume
	else
		_music_byte \1 ; LEGACY: Support for 1-arg volume
	endc
ENDM

	const pitch_offset_cmd ; $e7
MACRO pitch_offset
	_music_byte pitch_offset_cmd
	_music_word \1 ; pitch offset
ENDM

	const tempo_relative_cmd ; $e8
MACRO tempo_relative
	_music_byte tempo_relative_cmd
	_music_byte \1 ; tempo adjustment
ENDM

	const restart_channel_cmd ; $e9
MACRO restart_channel
	_music_byte restart_channel_cmd
	_music_pointer \1 ; address
ENDM

	const new_song_cmd ; $ea
MACRO new_song
	_music_byte new_song_cmd
	_music_word \1 ; id
ENDM

	const sfx_priority_on_cmd ; $eb
MACRO sfx_priority_on
	_music_byte sfx_priority_on_cmd
ENDM

	const sfx_priority_off_cmd ; $ec
MACRO sfx_priority_off
	_music_byte sfx_priority_off_cmd
ENDM

	const stereo_left_cmd ; $ed
	const stereo_right_cmd ; $ee
	const stereo_center_cmd ; $ef
MACRO stereo_panning
	if (\1) && !(\2)
		_music_byte stereo_left_cmd
	elif !(\1) && (\2)
		_music_byte stereo_right_cmd
	elif (\1) && (\2)
		_music_byte stereo_center_cmd
	else
		fail "Cannot mute with stereo_panning"
	endc
ENDM

	const_skip 8
	const music_align_cmd ; $f8

	const noisesampleset_cmd ; $f9
	; this gets output by toggle_noise

	const set_condition_cmd ; $fa
MACRO set_condition
	_music_byte set_condition_cmd
	_music_byte \1 ; condition
ENDM

	const sound_jump_if_cmd ; $fb
MACRO sound_jump_if
	_music_byte sound_jump_if_cmd
	_music_byte \1 ; condition
	_music_pointer \2 ; address
ENDM

	const sound_jump_cmd ; $fc
MACRO sound_jump
	_music_byte sound_jump_cmd
	_music_pointer \1 ; address
ENDM

	const sound_loop_cmd ; $fd
MACRO sound_loop
	_music_byte sound_loop_cmd
	assert (\1) != 0, "'sound_loop 0' can be 'sound_jump'"
	assert (\1) != 1, "'sound_loop 1' is pointless"
	_music_byte \1 ; count
	_music_pointer \2 ; address
ENDM

	const sound_call_cmd ; $fe
MACRO sound_call
	_music_byte sound_call_cmd
	_music_pointer \1 ; address
ENDM

	const sound_ret_cmd ; $ff
	assert sound_ret_cmd == $ff, "sound_ret_cmd must be $ff"
MACRO sound_ret
	_music_byte sound_ret_cmd
ENDM
