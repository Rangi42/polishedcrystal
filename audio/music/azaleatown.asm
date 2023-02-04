Music_AzaleaTown:
	channel_count 4
	channel 1, Music_AzaleaTown_Ch1
	channel 2, Music_AzaleaTown_Ch2
	channel 3, Music_AzaleaTown_Ch3
	channel 4, Music_AzaleaTown_Ch4

Music_AzaleaTown_Ch1:
	tempo 160
	volume 7, 7
	duty_cycle 2
	stereo_panning FALSE, TRUE
	note_type 12, 10, 1
	note __, 2
Music_AzaleaTown_branch_f5801:
	volume_envelope 10, 1
	octave 3
	note F_, 2
	volume_envelope 6, 1
	note F_, 2
	note F_, 2
	volume_envelope 10, 1
	note F_, 2
	volume_envelope 6, 1
	note F_, 2
	note F_, 2
	note F_, 2
	note F_, 2
	loopchannel 2, Music_AzaleaTown_branch_f5801
Music_AzaleaTown_branch_f5816:
	callchannel Music_AzaleaTown_branch_f588c
	stereo_panning TRUE, FALSE
	volume_envelope 10, 4
	note G#, 2
	note A#, 1
	note __, 3
	octave 4
	note C_, 4
	note_type 6, 10, 4
	note G_, 1
	note G#, 3
	note F#, 4
	note D#, 2
	note __, 2
	stereo_panning FALSE, TRUE
	callchannel Music_AzaleaTown_branch_f588c
	stereo_panning TRUE, FALSE
	note_type 6, 10, 4
	note D#, 4
	note C_, 4
	note __, 3
	note B_, 1
	octave 4
	note C_, 12
	octave 3
	note A#, 4
	note F#, 4
	stereo_panning FALSE, TRUE
	callchannel Music_AzaleaTown_branch_f5912
	volume_envelope 10, 3
	note A#, 4
	octave 4
	note C#, 2
	note __, 2
	note C_, 2
	note __, 2
	volume_envelope 10, 1
	octave 3
	note C#, 4
	note A_, 2
	note __, 14
	callchannel Music_AzaleaTown_branch_f5912
	volume_envelope 10, 3
	octave 4
	note C_, 1
	note C#, 3
	note F_, 2
	note __, 2
	note C#, 2
	note __, 2
	volume_envelope 10, 1
	octave 3
	note G_, 4
	note A#, 4
	note G_, 8
	volume_envelope 10, 2
	note A#, 4
	octave 4
	note C#, 4
	octave 3
	note A#, 4
	note F#, 4
	note C#, 8
	note F#, 4
	note __, 4
	note A#, 4
	octave 4
	note C#, 4
	octave 3
	note A#, 4
	note G_, 4
	note C#, 4
	note __, 4
	note G_, 4
	note __, 4
	octave 4
	note C#, 4
	note D#, 4
	note C#, 4
	octave 3
	note G#, 4
	note D#, 4
	note C#, 4
	octave 2
	note G#, 4
	note __, 8
	note_type 12, 2, -7
	octave 3
	note G#, 14
	note __, 2
	jumpchannel Music_AzaleaTown_branch_f5816

Music_AzaleaTown_branch_f588c:
	note_type 12, 10, 1
	octave 4
	note F_, 2
	volume_envelope 6, 1
	note F_, 2
	note F_, 2
	volume_envelope 10, 1
	note D#, 2
	volume_envelope 6, 1
	note D#, 2
	note D#, 2
	volume_envelope 10, 1
	note F_, 2
	volume_envelope 6, 1
	note F_, 2
	volume_envelope 10, 1
	note A#, 2
	volume_envelope 6, 1
	note A#, 2
	note A#, 2
	volume_envelope 10, 1
	note G#, 2
	volume_envelope 6, 1
	note G#, 2
	note G#, 2
	volume_envelope 10, 1
	note A_, 2
	volume_envelope 6, 1
	note A_, 2
	volume_envelope 10, 1
	note C_, 2
	volume_envelope 6, 1
	note C_, 2
	note C_, 2
	volume_envelope 10, 1
	note C#, 2
	volume_envelope 6, 1
	note C#, 2
	note C#, 2
	note C#, 2
	note C#, 2
	volume_envelope 10, 1
	note D#, 2
	volume_envelope 6, 1
	note D#, 2
	note D#, 2
	volume_envelope 10, 1
	note C#, 2
	volume_envelope 6, 1
	note C#, 2
	note C#, 2
	note C#, 2
	note __, 2
	volume_envelope 10, 1
	octave 3
	note F_, 2
	volume_envelope 6, 1
	note F_, 2
	note F_, 2
	volume_envelope 10, 1
	note F#, 2
	volume_envelope 6, 1
	note F#, 2
	note F#, 2
	note F#, 2
	note F#, 2
	volume_envelope 10, 1
	note F_, 2
	volume_envelope 6, 1
	note F_, 2
	note F_, 2
	volume_envelope 10, 1
	note D#, 2
	volume_envelope 6, 1
	note D#, 2
	note D#, 2
	volume_envelope 10, 1
	note C#, 2
	volume_envelope 6, 1
	note C#, 2
	volume_envelope 10, 1
	note C_, 2
	volume_envelope 6, 1
	note C_, 2
	note C_, 2
	volume_envelope 10, 1
	octave 2
	note A#, 2
	volume_envelope 6, 1
	note A#, 2
	note A#, 2
	volume_envelope 10, 1
	octave 3
	note C#, 2
	volume_envelope 6, 1
	note C#, 2
	endchannel

Music_AzaleaTown_branch_f5912:
	volume_envelope 6, 1
	note G#, 8
	note G#, 8
	volume_envelope 8, 1
	note A_, 8
	volume_envelope 10, 1
	note A_, 8
	endchannel

Music_AzaleaTown_Ch2:
	vibrato $12, $23
	duty_cycle 2
	stereo_panning TRUE, FALSE
	note_type 12, 6, 2
	note __, 1
	octave 4
	note D_, 1
	volume_envelope 11, 1
	note D#, 2
	volume_envelope 7, 1
	note D#, 2
	note D#, 2
	volume_envelope 11, 1
	note C#, 2
	volume_envelope 7, 1
	note C#, 2
	note C#, 2
	volume_envelope 5, 1
	note C#, 2
	note C#, 2
	volume_envelope 11, 1
	note C_, 2
	volume_envelope 7, 1
	note C_, 2
	note C_, 2
	volume_envelope 11, 1
	note C#, 2
	volume_envelope 7, 1
	note C#, 2
	note C#, 2
	note_type 6, 11, 4
	note F_, 7
	duty_cycle 1
	octave 5
	note C_, 1
Music_AzaleaTown_branch_f5952:
	callchannel Music_AzaleaTown_branch_f59c7
	note C#, 4
	note C_, 2
	note C#, 1
	note __, 3
	note_type 6, 11, 4
	note D#, 11
	note __, 8
	duty_cycle 1
	octave 5
	note C_, 1
	callchannel Music_AzaleaTown_branch_f59c7
	note __, 2
	note C#, 2
	note C_, 2
	octave 3
	note G#, 2
	note_type 6, 11, 4
	note __, 3
	octave 4
	note G_, 1
	note G#, 12
	note F#, 4
	note F_, 4
	duty_cycle 0
	note D_, 1
	note D#, 3
	note C#, 4
	note C_, 2
	note __, 2
	note G#, 4
	note __, 4
	note F#, 4
	note __, 4
	note F_, 4
	note D#, 4
	note F_, 2
	note __, 2
	note D#, 2
	note __, 2
	note C#, 8
	note __, 12
	note D_, 1
	note D#, 3
	note C#, 4
	note C_, 2
	note __, 2
	note G#, 4
	note __, 4
	note A_, 4
	note __, 4
	octave 5
	note C_, 4
	octave 4
	note B_, 1
	octave 5
	note C_, 3
	note C#, 2
	note __, 2
	note C_, 2
	note __, 2
	octave 4
	note F_, 4
	note __, 4
	note D#, 4
	note __, 4
	note C#, 4
	duty_cycle 2
	note F_, 4
	note D#, 4
	note C#, 4
	note F_, 4
	note __, 4
	note D#, 4
	note __, 4
	note C#, 4
	note F_, 4
	note D#, 4
	note C#, 4
	note F_, 4
	note __, 4
	note A#, 4
	note __, 4
	octave 5
	note C_, 4
	note_type 12, 11, 7
	octave 4
	note G#, 12
	note D#, 4
	volume_envelope 1, -7
	note C_, 14
	note_type 6, 11, 4
	duty_cycle 1
	note G#, 2
	octave 5
	note C_, 2
	jumpchannel Music_AzaleaTown_branch_f5952

Music_AzaleaTown_branch_f59c7:
	note C#, 4
	octave 4
	note G#, 2
	note __, 2
	octave 5
	note C_, 2
	note __, 2
	note C#, 8
	note D#, 8
	note F_, 2
	note __, 1
	note G_, 1
	note G#, 12
	note F_, 2
	note __, 6
	note D#, 8
	note F_, 2
	note __, 1
	note C_, 1
	note_type 12, 10, 8
	vibrato $0, $0
	note C#, 8
	volume_envelope 10, 7
	vibrato $12, $23
	note C#, 16
	note __, 4
	volume_envelope 11, 4
	duty_cycle 2
	octave 3
	note A#, 2
	octave 4
	note C#, 1
	note __, 1
	note F#, 8
	note __, 2
	note F#, 2
	note F_, 2
	note D#, 1
	note __, 1
	note C#, 6
	note C_, 2
	note __, 2
	note C_, 4
	note C#, 1
	note_type 6, 11, 4
	note __, 1
	note D_, 1
	note_type 12, 11, 7
	note D#, 12
	volume_envelope 11, 4
	endchannel

Music_AzaleaTown_Ch3:
	stereo_panning TRUE, TRUE
	vibrato $6, $26
	note_type 12, 2, 5
	octave 2
	note G#, 1
	octave 3
	note C_, 1
	note C#, 1
	note __, 5
	note C#, 1
	note __, 3
	note C#, 1
	note __, 1
	octave 2
	note G#, 4
	octave 3
	note C#, 1
	note __, 5
	note C#, 1
	note __, 3
	note C#, 1
	note __, 1
	note G#, 4
Music_AzaleaTown_branch_f5a24:
	callchannel Music_AzaleaTown_branch_f5a86
	note G#, 4
	note D#, 2
	callchannel Music_AzaleaTown_branch_f5a86
	note G#, 2
	note __, 2
	note F#, 2
	callchannel Music_AzaleaTown_branch_f5acf
	note A#, 1
	note __, 1
	octave 4
	note C#, 1
	note __, 1
	note F_, 2
	octave 3
	note A_, 4
	octave 4
	note C#, 1
	note __, 3
	note F_, 1
	note __, 1
	callchannel Music_AzaleaTown_branch_f5acf
	octave 2
	note A#, 2
	octave 3
	note F_, 1
	note __, 1
	note A#, 1
	note __, 1
	note D#, 2
	octave 2
	note A#, 2
	octave 3
	note D#, 1
	note __, 3
	note G_, 2
	octave 2
	note F#, 1
	note __, 5
	note F#, 1
	note F#, 1
	note F#, 1
	note __, 1
	octave 3
	note C#, 2
	note __, 2
	octave 2
	note F_, 1
	note F#, 1
	note G_, 1
	note __, 5
	note G_, 1
	note G_, 1
	note G_, 1
	note __, 1
	octave 3
	note C#, 2
	note __, 2
	octave 2
	note F#, 1
	note G_, 1
	note G#, 1
	note __, 5
	note G#, 1
	note G#, 1
	note G#, 1
	note __, 1
	octave 3
	note D#, 2
	note __, 2
	octave 2
	note F#, 1
	note G_, 1
	note G#, 1
	note __, 5
	note G#, 1
	note G#, 1
	note G#, 1
	note __, 1
	octave 3
	note D#, 2
	note __, 2
	octave 2
	note B_, 1
	octave 3
	note C_, 1
	jumpchannel Music_AzaleaTown_branch_f5a24

Music_AzaleaTown_branch_f5a86:
	note C#, 1
	note __, 5
	note C#, 1
	note __, 3
	note C#, 1
	note __, 1
	octave 2
	note G#, 4
	octave 3
	note F_, 1
	note __, 5
	note F_, 1
	note __, 1
	note C_, 1
	note __, 1
	note F_, 4
	note A_, 2
	volume_envelope 1, 5
	note A#, 1
	note __, 1
	volume_envelope 2, 5
	octave 4
	note C#, 1
	note __, 1
	note F_, 1
	note __, 1
	octave 3
	note A_, 4
	octave 4
	note C#, 1
	note __, 1
	note F_, 1
	note __, 1
	octave 3
	note G#, 4
	note A#, 1
	note __, 1
	note G#, 1
	note __, 1
	note G_, 6
	note __, 4
	note F#, 1
	note __, 5
	note F#, 1
	note __, 3
	note F#, 1
	note __, 1
	note C#, 4
	note G_, 1
	note __, 5
	note G_, 1
	note __, 3
	note C#, 4
	note G_, 1
	note __, 1
	note G#, 1
	note __, 5
	note G#, 1
	note __, 1
	note D#, 1
	note __, 1
	note C#, 4
	note G#, 1
	note __, 1
	note G#, 1
	note __, 5
	note G#, 1
	note __, 1
	note C_, 1
	note __, 1
	endchannel

Music_AzaleaTown_branch_f5acf:
	volume_envelope 3, 5
	octave 3
	note F_, 1
	note __, 1
	note F_, 1
	note __, 1
	note F_, 1
	note __, 1
	note F_, 1
	note __, 1
	volume_envelope 2, 5
	note F_, 1
	note __, 1
	note F_, 1
	note __, 1
	note F_, 1
	note __, 1
	note F_, 1
	note __, 1
	endchannel

Music_AzaleaTown_Ch4:
	toggle_noise 3
	note_type 12
	note F_, 2
Music_AzaleaTown_branch_f5aea:
	note D#, 2
	note F#, 2
	note D_, 2
	note D#, 1
	note G_, 1
	note G_, 1
	note G_, 1
	note D#, 2
	note D_, 2
	note G_, 1
	note G_, 1
	note D#, 2
	note F#, 2
	note D_, 2
	note D#, 1
	note G_, 1
	note G_, 1
	note G_, 1
	note D#, 2
	note D_, 2
	note F#, 2
	jumpchannel Music_AzaleaTown_branch_f5aea
