MACRO channel_count
	assert 0 < (\1) && (\1) <= NUM_MUSIC_CHANS, \
		"channel_count must be 1-{d:NUM_MUSIC_CHANS}"
	DEF _num_channels = \1 - 1
ENDM

MACRO channel
	assert 0 < (\1) && (\1) <= NUM_CHANNELS, \
		"channel id must be 1-{d:NUM_CHANNELS}"
	dn (_num_channels << 2), \1 - 1 ; channel id
	dw \2 ; address
	DEF _num_channels = 0
ENDM

MACRO note
	dn (\1), (\2) - 1 ; pitch, length
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
	db octave_cmd + 8 - (\1) ; octave
ENDM

	const_skip 7 ; all octave values

	const duty_cycle_cmd ; $d8
	assert duty_cycle_cmd & %11 == 0, "duty_cycle_cmd must be 2-bit aligned"
MACRO duty_cycle
	assert 0 <= (\1) && (\1) <= 6, "duty cycle must be 0-6"
	db duty_cycle_cmd | (\1 & 3) ; values 4-6 fold into 0-2
ENDM

	const_skip 3 ; all duty cycle values

	const note_type_cmd ; $dc
MACRO note_type
	db note_type_cmd
	db \1 ; note length
	if _NARG >= 2
		if \3 < 0
			dn \2, %1000 | (\3 * -1) ; volume envelope
		else
			dn \2, \3 ; volume envelope
		endc
	endc
ENDM

; only valid on the noise channel
MACRO drum_speed
	note_type \1 ; note length
ENDM

	const transpose_cmd ; $dd
MACRO transpose
	db transpose_cmd
	dn \1, \2 ; num octaves, num pitches
ENDM

	const tempo_cmd ; $de
MACRO tempo
	db tempo_cmd
	dw \1 ; tempo
ENDM

	const volume_envelope_cmd ; $df
MACRO volume_envelope
	db volume_envelope_cmd
	if \2 < 0
		dn \1, %1000 | (\2 * -1) ; volume envelope
	else
		dn \1, \2 ; volume envelope
	endc
ENDM

	const pitch_sweep_cmd ; $e0
MACRO pitch_sweep
	db pitch_sweep_cmd
	if \2 < 0
		dn \1, %1000 | (\2 * -1) ; pitch sweep
	else
		dn \1, \2 ; pitch sweep
	endc
ENDM

	const duty_cycle_pattern_cmd ; $e1
MACRO duty_cycle_pattern
	db duty_cycle_pattern_cmd
	db (\1 << 6) | (\2 << 4) | (\3 << 2) | (\4 << 0) ; duty cycle pattern
ENDM

	const toggle_sfx_cmd ; $e2
MACRO toggle_sfx
	db toggle_sfx_cmd
ENDM

	const pitch_slide_cmd ; $e3
MACRO pitch_slide
	db pitch_slide_cmd
	db \1 - 1 ; duration
	dn 8 - \2, \3 % 12 ; octave, pitch
ENDM

	const vibrato_cmd ; $e4
MACRO vibrato
	db vibrato_cmd
	db \1 ; delay
	if _NARG > 2
		dn \2, \3 ; extent, rate
	else
		db \2 ; LEGACY: Support for 1-arg extent
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
		db noisesampleset_cmd
		db \1 ; noise
	else
		db toggle_noise_cmd
		db \1 ; drum kit
	endc
ENDM

MACRO sfx_toggle_noise
	toggle_noise \#
ENDM

	const volume_cmd ; $e6
MACRO volume
	db volume_cmd
	if _NARG > 1
		dn \1, \2 ; left volume, right volume
	else
		db \1 ; LEGACY: Support for 1-arg volume
	endc
ENDM

	const pitch_offset_cmd ; $e7
MACRO pitch_offset
	db pitch_offset_cmd
	dw \1 ; pitch offset
ENDM

	const tempo_relative_cmd ; $e8
MACRO tempo_relative
	db tempo_relative_cmd
	db \1 ; tempo adjustment
ENDM

	const restart_channel_cmd ; $e9
MACRO restart_channel
	db restart_channel_cmd
	dw \1 ; address
ENDM

	const new_song_cmd ; $ea
MACRO new_song
	db new_song_cmd
	dw \1 ; id
ENDM

	const sfx_priority_on_cmd ; $eb
MACRO sfx_priority_on
	db sfx_priority_on_cmd
ENDM

	const sfx_priority_off_cmd ; $ec
MACRO sfx_priority_off
	db sfx_priority_off_cmd
ENDM

	const stereo_left_cmd ; $ed
	const stereo_right_cmd ; $ee
	const stereo_center_cmd ; $ef
MACRO stereo_panning
	if (\1) && !(\2)
		db stereo_left_cmd
	elif !(\1) && (\2)
		db stereo_right_cmd
	elif (\1) && (\2)
		db stereo_center_cmd
	else
		fail "Cannot mute with stereo_panning"
	endc
ENDM

	const_skip 9

	const noisesampleset_cmd ; $f9
	; this gets output by toggle_noise

	const set_condition_cmd ; $fa
MACRO set_condition
	db set_condition_cmd
	db \1 ; condition
ENDM

	const sound_jump_if_cmd ; $fb
MACRO sound_jump_if
	db sound_jump_if_cmd
	db \1 ; condition
	dw \2 ; address
ENDM

	const sound_jump_cmd ; $fc
MACRO sound_jump
	db sound_jump_cmd
	dw \1 ; address
ENDM

	const sound_loop_cmd ; $fd
MACRO sound_loop
	db sound_loop_cmd
	assert (\1) != 0, "'sound_loop 0' can be 'sound_jump'"
	assert (\1) != 1, "'sound_loop 1' is pointless"
	db \1 ; count
	dw \2 ; address
ENDM

	const sound_call_cmd ; $fe
MACRO sound_call
	db sound_call_cmd
	dw \1 ; address
ENDM

	const sound_ret_cmd ; $ff
	assert sound_ret_cmd == $ff, "sound_ret_cmd must be $ff"
MACRO sound_ret
	db sound_ret_cmd
ENDM
