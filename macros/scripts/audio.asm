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
	dn (\1), (\2) - 1
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

	const_def $d0
DEF FIRST_MUSIC_CMD EQU const_value

	const octave_cmd
MACRO octave
	assert 1 <= (\1) && (\1) <= 8, "octave must be 1-8"
	db octave_cmd + 8 - (\1)
ENDM

	const_skip 7 ; all octave values

	const note_type_cmd ; $d8
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

	const transpose_cmd ; $d9
MACRO transpose
	db transpose_cmd
	dn \1, \2 ; num octaves, num pitches
ENDM

	const tempo_cmd
MACRO tempo
	db tempo_cmd
	bigdw \1 ; tempo
ENDM

	const duty_cycle_cmd ; $db
MACRO duty_cycle
	db duty_cycle_cmd
	db \1 ; duty cycle
ENDM

	const volume_envelope_cmd ; $dc
MACRO volume_envelope
	db volume_envelope_cmd
	if \2 < 0
		dn \1, %1000 | (\2 * -1) ; volume envelope
	else
		dn \1, \2 ; volume envelope
	endc
ENDM

	const pitch_sweep_cmd ; $dd
MACRO pitch_sweep
	db pitch_sweep_cmd
	if \2 < 0
		dn \1, %1000 | (\2 * -1) ; pitch sweep
	else
		dn \1, \2 ; pitch sweep
	endc
ENDM

	const duty_cycle_pattern_cmd ; $de
MACRO duty_cycle_pattern
	db duty_cycle_pattern_cmd
	db (\1 << 6) | (\2 << 4) | (\3 << 2) | (\4 << 0) ; duty cycle pattern
ENDM

	const toggle_sfx_cmd ; $df
MACRO toggle_sfx
	db toggle_sfx_cmd
ENDM

	const pitch_slide_cmd ; $e0
MACRO pitch_slide
	db pitch_slide_cmd
	db \1 - 1 ; duration
	dn 8 - \2, \3 % 12 ; octave, pitch
ENDM

	const vibrato_cmd
MACRO vibrato
	db vibrato_cmd
	db \1 ; delay
	db \2 ; extent
ENDM

	const unknownmusic0xe2_cmd
MACRO unknownmusic0xe2
	db unknownmusic0xe2_cmd
	db \1 ; unknown
ENDM

	const toggle_noise_cmd ; $e3
MACRO toggle_noise
	db toggle_noise_cmd
	if _NARG > 0
		db \1 ; drum kit
	endc
ENDM

	const force_stereo_panning_cmd ; $e4
MACRO force_stereo_panning
	db force_stereo_panning_cmd
	dn %1111 * (1 && \1), %1111 * (1 && \2) ; left enable, right enable
ENDM

	const volume_cmd
MACRO volume
	db volume_cmd
	if _NARG > 1
		dn \1, \2 ; left volume, right volume
	else
		db \1 ; LEGACY: Support for 1-arg volume
	endc
ENDM

	const pitch_offset_cmd ; $e6
MACRO pitch_offset
	db pitch_offset_cmd
	bigdw \1 ; pitch offset
ENDM

	const unknownmusic0xe7_cmd
MACRO unknownmusic0xe7
	db unknownmusic0xe7_cmd
	db \1 ; unknown
ENDM

	const unknownmusic0xe8_cmd
MACRO unknownmusic0xe8
	db unknownmusic0xe8_cmd
	db \1 ; unknown
ENDM

	const tempo_relative_cmd
MACRO tempo_relative
	db tempo_relative_cmd
	bigdw \1 ; value
ENDM

	const restartchannel_cmd
MACRO restartchannel
	db restartchannel_cmd
	dw \1 ; address
ENDM

	const newsong_cmd
MACRO newsong
	db newsong_cmd
	bigdw \1 ; id
ENDM

	const sfxpriorityon_cmd
MACRO sfxpriorityon
	db sfxpriorityon_cmd
ENDM

	const sfxpriorityoff_cmd
MACRO sfxpriorityoff
	db sfxpriorityoff_cmd
ENDM

	const unknownmusic0xee_cmd
MACRO unknownmusic0xee
	db unknownmusic0xee_cmd
	dw \1 ; address
ENDM

	const stereo_panning_cmd ; $ef
MACRO stereo_panning
	db stereo_panning_cmd
	dn %1111 * (1 && \1), %1111 * (1 && \2) ; left enable, right enable
ENDM

	const sfxtogglenoise_cmd
MACRO sfxtogglenoise
	db sfxtogglenoise_cmd
	db \1 ; id
ENDM

	const music0xf1_cmd
MACRO music0xf1
	db music0xf1_cmd
ENDM

	const music0xf2_cmd
MACRO music0xf2
	db music0xf2_cmd
ENDM

	const music0xf3_cmd
MACRO music0xf3
	db music0xf3_cmd
ENDM

	const music0xf4_cmd
MACRO music0xf4
	db music0xf4_cmd
ENDM

	const music0xf5_cmd
MACRO music0xf5
	db music0xf5_cmd
ENDM

	const music0xf6_cmd
MACRO music0xf6
	db music0xf6_cmd
ENDM

	const music0xf7_cmd
MACRO music0xf7
	db music0xf7_cmd
ENDM

	const music0xf8_cmd
MACRO music0xf8
	db music0xf8_cmd
ENDM

	const noisesampleset_cmd
MACRO noisesampleset
	db noisesampleset_cmd
	db \1 ; noise
ENDM

	const setcondition_cmd
MACRO setcondition
	db setcondition_cmd
	db \1 ; condition
ENDM

	const jumpif_cmd
MACRO jumpif
	db jumpif_cmd
	db \1 ; condition
	dw \2 ; address
ENDM

	const jumpchannel_cmd
MACRO jumpchannel
	db jumpchannel_cmd
	dw \1 ; address
ENDM

	const loopchannel_cmd
MACRO loopchannel
	db loopchannel_cmd
	assert (\1) != 0, "'loopchannel 0' can be 'jumpchannel'"
	assert (\1) != 1, "'loopchannel 1' is pointless"
	db \1 ; count
	dw \2 ; address
ENDM

	const callchannel_cmd
MACRO callchannel
	db callchannel_cmd
	dw \1 ; address
ENDM

	const endchannel_cmd
MACRO endchannel
	db endchannel_cmd
ENDM
