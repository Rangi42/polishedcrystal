Music_GameCorner:
	channel_count 4
	channel 1, Music_GameCorner_Ch1
	channel 2, Music_GameCorner_Ch2
	channel 3, Music_GameCorner_Ch3
	channel 4, Music_GameCorner_Ch4

Music_GameCorner_Ch1:
	tempo 147
	volume 7, 7
	stereo_panning FALSE, TRUE
	note_type 12, 9, 1
	note __, 8
Music_GameCorner_branch_edd84:
	volume_envelope 9, 1
	note __, 16
	note __, 16
	note __, 16
	note __, 16
	callchannel Music_GameCorner_branch_ede03
	callchannel Music_GameCorner_branch_ede03
	callchannel Music_GameCorner_branch_ede03
	callchannel Music_GameCorner_branch_ede13
	note __, 16
	note __, 16
	note __, 16
	note __, 16
	note __, 16
	callchannel Music_GameCorner_branch_ede03
	callchannel Music_GameCorner_branch_ede03
	callchannel Music_GameCorner_branch_ede03
	callchannel Music_GameCorner_branch_ede13
	octave 3
	note __, 2
	note G#, 3
	note G#, 3
	note A#, 2
	note A#, 2
	note G#, 2
	note G_, 2
	volume_envelope 7, 1
Music_GameCorner_branch_eddb1:
	octave 4
	note G#, 1
	octave 5
	note C_, 1
	note F_, 1
	note C_, 1
	loopchannel 4, Music_GameCorner_branch_eddb1
Music_GameCorner_branch_eddbb:
	octave 4
	note A#, 1
	octave 5
	note D_, 1
	note G_, 1
	note D_, 1
	loopchannel 4, Music_GameCorner_branch_eddbb
Music_GameCorner_branch_eddc5:
	octave 4
	note D#, 1
	note G_, 1
	octave 5
	note C_, 1
	octave 4
	note G_, 1
	loopchannel 4, Music_GameCorner_branch_eddc5
Music_GameCorner_branch_eddd0:
	octave 4
	note F_, 1
	note A_, 1
	octave 5
	note C_, 1
	octave 4
	note A_, 1
	loopchannel 4, Music_GameCorner_branch_eddd0
Music_GameCorner_branch_edddb:
	octave 4
	note G#, 1
	octave 5
	note C_, 1
	note F_, 1
	note C_, 1
	loopchannel 4, Music_GameCorner_branch_edddb
Music_GameCorner_branch_edde5:
	octave 4
	note A#, 1
	octave 5
	note D_, 1
	note G_, 1
	note D_, 1
	loopchannel 4, Music_GameCorner_branch_edde5
Music_GameCorner_branch_eddef:
	octave 4
	note B_, 1
	octave 5
	note D_, 1
	note G_, 1
	note D_, 1
	loopchannel 4, Music_GameCorner_branch_eddef
	octave 3
	note D_, 1
	note D_, 1
	note D_, 3
	note F_, 2
	note F_, 9
	jumpchannel Music_GameCorner_branch_edd84

Music_GameCorner_branch_ede03:
	note __, 2
	octave 4
	note A#, 3
	note G_, 3
	note D#, 3
	octave 3
	note F_, 3
	note F_, 2
	note __, 2
	note G#, 3
	note G#, 3
	note A#, 2
	note A#, 2
	note G#, 1
	note A#, 3
	endchannel

Music_GameCorner_branch_ede13:
	note __, 2
	octave 4
	note A#, 3
	note G_, 3
	note D#, 3
	octave 3
	note F_, 3
	note F_, 2
	endchannel

Music_GameCorner_Ch2:
	stereo_panning TRUE, TRUE
	vibrato $8, $24
	note_type 12, 10, 1
	note __, 8
Music_GameCorner_branch_ede25:
	volume_envelope 9, 2
	duty_cycle 1
	callchannel Music_GameCorner_branch_ede75
	octave 1
	note F_, 2
	octave 3
	note G#, 2
	octave 1
	note F_, 1
	octave 3
	note G#, 2
	volume_envelope 10, 4
	note G#, 3
	volume_envelope 9, 2
	note G_, 2
	note A#, 1
	octave 4
	note C_, 3
	callchannel Music_GameCorner_branch_ede75
	octave 4
	note F_, 2
	note D#, 2
	note F_, 1
	note D#, 2
	volume_envelope 10, 4
	note G_, 3
	note F_, 4
	duty_cycle 2
	volume_envelope 12, 7
	octave 3
	note D#, 1
	note F_, 1
	note G_, 6
	note F_, 6
	note C_, 4
	note D_, 6
	note D#, 6
	note F_, 4
	note D_, 6
	note C_, 6
	octave 2
	note A#, 4
	note A_, 4
	note __, 10
	octave 3
	note D#, 1
	note F_, 1
	note G_, 6
	note F_, 6
	note C_, 4
	note D_, 6
	note D#, 6
	note F_, 2
	note D#, 1
	note F_, 1
	note G_, 16
	volume_envelope 9, 2
	note G_, 1
	note G_, 1
	note G_, 3
	note A#, 2
	note A#, 9
	volume_envelope 10, 4
	jumpchannel Music_GameCorner_branch_ede25

Music_GameCorner_branch_ede75:
	octave 1
	note C_, 2
	octave 3
	note D#, 3
	note D#, 3
	note D#, 3
	note F_, 3
	note F_, 2
	octave 1
	note C_, 2
	octave 3
	note D#, 3
	note D#, 3
	note F_, 2
	note F_, 2
	note D#, 1
	note F_, 3
	octave 1
	note C_, 2
	octave 3
	note D#, 3
	note D#, 3
	note D#, 3
	note F_, 3
	note F_, 2
	octave 1
	note C_, 2
	octave 3
	note D#, 3
	note D#, 3
	note F_, 2
	note C_, 2
	note D#, 1
	note F_, 3
	octave 1
	note C_, 2
	octave 5
	note D_, 3
	octave 4
	note A#, 3
	note G_, 2
	note C_, 2
	note D_, 2
	note D#, 2
	note F_, 2
	note D#, 2
	note F_, 1
	note D#, 2
	volume_envelope 10, 4
	note F_, 3
	note G_, 4
	volume_envelope 9, 2
	note F#, 1
	note F_, 1
	octave 1
	note C_, 2
	octave 5
	note D_, 3
	octave 4
	note A#, 3
	note G_, 2
	note C_, 2
	note D_, 2
	note D#, 2
	octave 1
	note F_, 1
	octave 4
	note F_, 1
	note D#, 2
	note G_, 1
	note D#, 2
	volume_envelope 10, 4
	note A#, 3
	note A_, 2
	volume_envelope 9, 2
	note A#, 1
	octave 5
	note C_, 3
	octave 1
	note C_, 2
	octave 5
	note D_, 3
	octave 4
	note A#, 3
	note G_, 2
	note C_, 2
	note D_, 2
	note D#, 2
	note F_, 2
	note D#, 2
	note F_, 1
	note D#, 2
	volume_envelope 10, 4
	note F_, 3
	note G_, 4
	volume_envelope 9, 2
	note F#, 1
	note F_, 1
	octave 1
	note C_, 2
	octave 5
	note D_, 3
	octave 4
	note A#, 3
	note G_, 2
	note C_, 2
	note D_, 2
	note D#, 2
	endchannel

Music_GameCorner_Ch3:
	vibrato $8, $22
	note_type 12, 1, 4
	note __, 8
Music_GameCorner_branch_edeef:
	stereo_panning TRUE, TRUE
	note_type 12, 1, 4
	callchannel Music_GameCorner_branch_edfdd
	callchannel Music_GameCorner_branch_edff8
	octave 4
	note G_, 1
	note A_, 3
	callchannel Music_GameCorner_branch_edfdd
	callchannel Music_GameCorner_branch_edff8
	octave 4
	note A#, 1
	octave 5
	note C_, 3
	stereo_panning TRUE, FALSE
	callchannel Music_GameCorner_branch_edfdd
	callchannel Music_GameCorner_branch_ee00c
	callchannel Music_GameCorner_branch_edfdd
	callchannel Music_GameCorner_branch_ee024
	callchannel Music_GameCorner_branch_edfdd
	callchannel Music_GameCorner_branch_ee00c
	callchannel Music_GameCorner_branch_edfdd
	stereo_panning TRUE, TRUE
	octave 2
	note F_, 1
	octave 3
	note F_, 1
	octave 5
	note C_, 1
	octave 4
	note F_, 1
	octave 2
	note F_, 1
	octave 5
	note C_, 1
	octave 3
	note F_, 1
	octave 5
	note D#, 3
	note D_, 1
	note __, 1
	note D#, 1
	note F_, 1
	note __, 2
	callchannel Music_GameCorner_branch_edfdd
	callchannel Music_GameCorner_branch_edff8
	octave 4
	note G_, 1
	note A_, 3
	callchannel Music_GameCorner_branch_edfdd
	callchannel Music_GameCorner_branch_edff8
	octave 4
	note A#, 1
	octave 5
	note C_, 3
	stereo_panning TRUE, FALSE
	callchannel Music_GameCorner_branch_edfdd
	callchannel Music_GameCorner_branch_ee00c
	callchannel Music_GameCorner_branch_edfdd
	callchannel Music_GameCorner_branch_ee024
	callchannel Music_GameCorner_branch_edfdd
	callchannel Music_GameCorner_branch_ee00c
	callchannel Music_GameCorner_branch_edfdd
	octave 2
	note F_, 1
	octave 3
	note F_, 1
	octave 5
	note C_, 1
	octave 4
	note F_, 1
	octave 3
	note F_, 1
	octave 5
	note C_, 1
	octave 4
	note F_, 1
	octave 3
	note F_, 1
	octave 5
	note D#, 1
	note __, 1
	note D_, 1
	note __, 1
	note C_, 1
	note __, 1
	octave 4
	note A#, 1
	note __, 1
	volume_envelope 1, 5
	callchannel Music_GameCorner_branch_ee03f
	octave 2
	note C_, 2
	note __, 1
	note C_, 1
	octave 3
	note C_, 1
	octave 2
	note C_, 1
	note __, 1
	note C_, 1
	note C_, 1
	octave 3
	note C_, 1
	octave 2
	note C_, 2
	octave 3
	note C_, 1
	octave 2
	note C_, 1
	note __, 1
	octave 3
	note C_, 1
	octave 2
	note F_, 2
	note __, 1
	note F_, 1
	octave 3
	note F_, 1
	octave 2
	note F_, 1
	note __, 1
	note F_, 1
	note F_, 1
	octave 3
	note F_, 1
	octave 2
	note F_, 2
	octave 3
	note F_, 1
	octave 2
	note F_, 1
	note __, 1
	octave 3
	note F_, 1
	callchannel Music_GameCorner_branch_ee03f
	octave 2
	note G_, 2
	note __, 1
	note G_, 1
	octave 3
	note G_, 1
	octave 2
	note G_, 1
	note __, 1
	note G_, 1
	note G_, 1
	octave 3
	note G_, 1
	octave 2
	note G_, 2
	octave 3
	note G_, 1
	octave 2
	note G_, 1
	note __, 1
	octave 3
	note G_, 1
	octave 2
	note B_, 1
	note B_, 1
	note B_, 1
	note __, 2
	note B_, 1
	note __, 1
	note B_, 1
	note __, 4
	note_type 6, 1, 5
	octave 3
	note D_, 1
	note C_, 1
	octave 2
	note B_, 1
	note A_, 1
	note G_, 1
	note F_, 1
	note E_, 1
	note D_, 1
	jumpchannel Music_GameCorner_branch_edeef

Music_GameCorner_branch_edfdd:
	octave 2
	note C_, 1
	octave 3
	note C_, 1
	octave 4
	note G_, 1
	note C_, 1
	octave 3
	note C_, 1
	octave 4
	note G_, 1
	note C_, 1
	octave 3
	note C_, 1
	octave 4
	note G_, 1
	note C_, 1
	octave 3
	note C_, 1
	octave 4
	note A_, 1
	note C_, 1
	octave 3
	note C_, 1
	octave 4
	note A_, 2
	endchannel

Music_GameCorner_branch_edff8:
	octave 2
	note C_, 1
	octave 3
	note C_, 1
	octave 4
	note G_, 1
	note C_, 1
	octave 3
	note C_, 1
	octave 4
	note G_, 1
	note C_, 1
	octave 3
	note C_, 1
	octave 4
	note A#, 1
	note __, 1
	note A_, 1
	note __, 1
	endchannel

Music_GameCorner_branch_ee00c:
	octave 2
	note F_, 1
	octave 3
	note F_, 1
	octave 5
	note C_, 1
	octave 4
	note F_, 1
	octave 3
	note F_, 1
	octave 5
	note C_, 1
	octave 4
	note F_, 1
	octave 3
	note F_, 1
	octave 5
	note D#, 1
	note __, 1
	note D_, 1
	note __, 1
	note C_, 1
	note D_, 3
	endchannel

Music_GameCorner_branch_ee024:
	octave 2
	note F_, 1
	octave 3
	note F_, 1
	octave 5
	note C_, 1
	octave 4
	note F_, 1
	octave 3
	note F_, 1
	octave 5
	note C_, 1
	octave 4
	note F_, 1
	octave 3
	note F_, 1
	octave 5
	note D#, 1
	note __, 1
	note D_, 1
	note __, 1
	note C_, 1
	note D_, 1
	octave 3
	note F_, 1
	note __, 1
	endchannel

Music_GameCorner_branch_ee03f:
	octave 2
	note F_, 2
	note __, 1
	note F_, 1
	octave 3
	note F_, 1
	octave 2
	note F_, 1
	note __, 1
	note F_, 1
	note F_, 1
	octave 3
	note F_, 1
	octave 2
	note F_, 2
	octave 3
	note F_, 1
	octave 2
	note F_, 1
	note __, 1
	octave 3
	note F_, 1
	octave 2
	note G_, 2
	note __, 1
	note G_, 1
	octave 3
	note G_, 1
	octave 2
	note G_, 1
	note __, 1
	note G_, 1
	note G_, 1
	octave 3
	note G_, 1
	octave 2
	note F_, 1
	octave 3
	note F_, 1
	octave 2
	note D#, 1
	octave 3
	note D#, 1
	octave 2
	note D_, 1
	octave 3
	note D_, 1
	endchannel

Music_GameCorner_Ch4:
	toggle_noise 3
	note_type 12
	note_type 8
	note D_, 1
	note D_, 1
	note D_, 1
	note_type 12
	note D_, 1
	note D_, 1
	note D_, 2
	note D_, 1
	note D_, 1
Music_GameCorner_branch_ee07f:
	callchannel Music_GameCorner_branch_ee106
Music_GameCorner_branch_ee082:
	note A#, 2
	note F#, 2
	note D_, 2
	note F#, 2
	note A#, 2
	note F#, 2
	note D_, 2
	note F#, 2
	loopchannel 6, Music_GameCorner_branch_ee082
	callchannel Music_GameCorner_branch_ee10f
Music_GameCorner_branch_ee091:
	note A#, 2
	note F#, 2
	note D_, 2
	note F#, 2
	note A#, 2
	note F#, 2
	note D_, 2
	note F#, 2
	loopchannel 3, Music_GameCorner_branch_ee091
	note __, 12
	note D_, 1
	note D_, 1
	note F#, 2
	callchannel Music_GameCorner_branch_ee106
Music_GameCorner_branch_ee0a4:
	note A#, 2
	note F#, 2
	note D_, 2
	note F#, 2
	note A#, 2
	note F#, 2
	note D_, 2
	note F#, 2
	loopchannel 6, Music_GameCorner_branch_ee0a4
	callchannel Music_GameCorner_branch_ee10f
Music_GameCorner_branch_ee0b3:
	note A#, 2
	note F#, 2
	note D_, 2
	note F#, 2
	note A#, 2
	note F#, 2
	note D_, 2
	note F#, 2
	loopchannel 3, Music_GameCorner_branch_ee0b3
	note A#, 2
	note F#, 2
	note D_, 2
	note F#, 2
	note D#, 2
	note F#, 2
	note D_, 1
	note D_, 1
	note D_, 1
	note D_, 1
Music_GameCorner_branch_ee0c9:
	note A#, 2
	note F#, 1
	note D#, 1
	note D_, 1
	note D#, 1
	note F#, 1
	note D#, 1
	note D#, 1
	note D_, 1
	note F#, 1
	note D#, 1
	note D_, 2
	note F#, 2
	loopchannel 3, Music_GameCorner_branch_ee0c9
	note A#, 2
	note F#, 1
	note D#, 1
	note D_, 1
	note D#, 1
	note F#, 1
	note D#, 1
	note D#, 1
	note D_, 1
	note F#, 1
	note D#, 1
	note D_, 2
	note D_, 1
	note D_, 1
Music_GameCorner_branch_ee0e8:
	note A#, 2
	note F#, 1
	note D#, 1
	note D_, 1
	note D#, 1
	note F#, 1
	note D#, 1
	note D#, 1
	note D_, 1
	note F#, 1
	note D#, 1
	note D_, 2
	note F#, 2
	loopchannel 3, Music_GameCorner_branch_ee0e8
	note D_, 1
	note D_, 1
	note D_, 2
	note A#, 1
	note F#, 2
	note F#, 5
	note D_, 1
	note D_, 1
	note D#, 2
	jumpchannel Music_GameCorner_branch_ee07f

Music_GameCorner_branch_ee106:
	note C_, 2
	note F#, 2
	note D_, 2
	note F#, 2
	note A#, 2
	note F#, 2
	note D_, 2
	note F#, 2
	endchannel

Music_GameCorner_branch_ee10f:
	note A#, 2
	note F#, 2
	note D_, 2
	note F#, 2
	note A#, 2
	note F#, 2
	note D_, 1
	note D_, 1
	note F#, 2
	endchannel
