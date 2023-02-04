Music_LookRival:
	channel_count 4
	channel 1, Music_LookRival_Ch1
	channel 2, Music_LookRival_Ch2
	channel 3, Music_LookRival_Ch3
	channel 4, Music_LookRival_Ch4

Music_LookRival_Ch1:
	tempo 112
	volume 7, 7
	duty_cycle 1
	tone $0001
	vibrato $12, $15
	stereo_panning FALSE, TRUE
	note_type 12, 11, 2
	octave 4
	note C_, 1
	octave 3
	note A#, 1
	note G#, 2
	note A#, 1
	note G#, 1
	note F#, 2
	note F_, 6
	volume_envelope 11, 7
	note G#, 6
	volume_envelope 11, 2
	note A#, 4
	note F_, 2
	note G#, 4
	volume_envelope 10, 0
	note G#, 10
	volume_envelope 10, 5
	note G#, 8
	volume_envelope 10, 6
	note F#, 8
Music_AfterTheRivalFight_branch_f4fb1:
Music_LookRival_branch_f4fb1:
	volume_envelope 11, 5
	note F_, 4
	note D#, 2
	note F_, 6
	note F_, 2
	note G_, 2
	note G#, 4
	note A#, 4
	note G#, 2
	note G_, 4
	volume_envelope 10, 0
	note F_, 2
	volume_envelope 10, 7
	note F_, 16
	volume_envelope 6, 6
	note __, 2
	note F_, 2
	note G_, 4
	volume_envelope 11, 6
	note G#, 4
	octave 4
	note C_, 4
	octave 3
	note A#, 4
	note G#, 2
	note A#, 6
	volume_envelope 11, 4
	note A#, 2
	octave 4
	note C_, 2
	note C#, 2
	note C#, 2
	note D#, 2
	note D#, 2
	note C#, 2
	note C_, 6
	volume_envelope 11, 7
	octave 3
	note A#, 12
	note G#, 2
	note G_, 2
	note G#, 2
	note A#, 10
	note B_, 4
	octave 4
	note C_, 6
	octave 3
	note A#, 6
	octave 4
	note D_, 2
	note C_, 2
	octave 3
	note A#, 6
	note G_, 10
	note A#, 6
	note G#, 6
	octave 4
	note C_, 2
	octave 3
	note A#, 2
	note G#, 8
	note F_, 6
	note C_, 2
Music_LookRival_branch_f4ff7:
	volume_envelope 11, 2
	note F_, 6
	volume_envelope 11, 7
	note G#, 4
	note F#, 2
	note F_, 2
	note D#, 2
	loopchannel 3, Music_LookRival_branch_f4ff7
	volume_envelope 11, 2
	note F_, 2
	note G#, 4
	volume_envelope 11, 7
	note G#, 6
	note F#, 4
	jumpchannel Music_LookRival_branch_f4fb1

Music_LookRival_Ch2:
	duty_cycle 3
	vibrato $8, $36
	stereo_panning TRUE, FALSE
	note_type 12, 12, 2
	octave 4
	note F#, 2
	note F_, 2
	note D#, 2
	note C#, 2
	note C_, 6
	volume_envelope 12, 7
	note D#, 6
	volume_envelope 12, 2
	note F_, 4
	note C_, 2
	note D#, 4
	volume_envelope 11, 0
	note D#, 10
	volume_envelope 11, 7
	note D#, 16
Music_AfterTheRivalFight_branch_f502e:
Music_LookRival_branch_f502e:
	volume_envelope 12, 7
	note C_, 12
	volume_envelope 12, 4
	note C_, 2
	note D_, 2
	note D#, 4
	note D_, 4
	note C_, 2
	note D_, 4
	volume_envelope 11, 0
	note C_, 6
	volume_envelope 11, 7
	note C_, 8
	volume_envelope 11, 4
	octave 3
	note A_, 2
	note G_, 2
	note A_, 2
	volume_envelope 12, 6
	octave 4
	note C_, 6
	volume_envelope 12, 7
	note D#, 8
	note F_, 12
	volume_envelope 12, 4
	note F_, 2
	note G_, 2
	note G#, 2
	note G#, 2
	note G_, 2
	note G_, 2
	note F_, 2
	volume_envelope 12, 4
	note G_, 6
	volume_envelope 11, 0
	note F_, 16
	volume_envelope 11, 7
	note F_, 16
	volume_envelope 11, 0
	note G_, 12
	note F_, 4
	note E_, 16
	note F_, 12
	note D#, 4
	volume_envelope 12, 7
	note D_, 8
	volume_envelope 12, 4
	note C_, 2
	note D_, 2
	note D#, 1
	note D_, 1
	note D#, 2
Music_LookRival_branch_f5070:
	volume_envelope 12, 2
	note C_, 6
	volume_envelope 12, 7
	note D#, 6
	volume_envelope 12, 2
	note F_, 4
	loopchannel 3, Music_LookRival_branch_f5070
	note C_, 2
	note D#, 4
	volume_envelope 12, 7
	note D#, 10
	jumpchannel Music_LookRival_branch_f502e

Music_LookRival_Ch3:
	note_type 12, 2, 8
	note __, 2
	octave 4
	note C_, 2
	octave 3
	note G#, 2
	note F#, 2
	note F_, 4
	note G#, 2
	note D#, 4
	note C_, 2
	note D_, 2
	note D#, 2
	note G#, 2
	note F#, 2
	note F_, 2
	note D#, 10
	note D#, 10
	note C_, 2
	note D#, 2
	note F#, 2
Music_AfterTheRivalFight_branch_f509d:
Music_LookRival_branch_f509d:
	callchannel Music_LookRival_branch_f50ef
	loopchannel 3, Music_LookRival_branch_f509d
	note F_, 4
	note C_, 2
	note D#, 4
	note G#, 2
	note G_, 2
	note F#, 2
	callchannel Music_LookRival_branch_f50f7
	note A#, 2
	note F_, 2
	note G_, 2
	note G#, 4
	note F_, 2
	note G_, 2
	note G#, 1
	note A_, 1
	callchannel Music_LookRival_branch_f50ff
	note A#, 2
	note F_, 2
	note G_, 2
	note G#, 4
	note F_, 2
	note A#, 2
	note B_, 2
	octave 4
	note C_, 4
	octave 3
	note G_, 2
	note A#, 4
	note G_, 2
	note A_, 2
	note A#, 2
	octave 4
	note C_, 4
	octave 3
	note G_, 2
	note A#, 4
	note G_, 2
	note A_, 2
	note A#, 1
	note A_, 1
	callchannel Music_LookRival_branch_f50f7
	callchannel Music_LookRival_branch_f50ff
	callchannel Music_LookRival_branch_f50ef
	callchannel Music_LookRival_branch_f50ef
	note F_, 2
	note C_, 2
	note D_, 2
	note D#, 4
	note C_, 2
	note D_, 2
	note D#, 1
	note E_, 1
	note F_, 2
	note C_, 2
	note D_, 2
	note D#, 4
	note C_, 2
	note F#, 2
	note E_, 2
	jumpchannel Music_LookRival_branch_f509d

Music_LookRival_branch_f50ef:
	note F_, 2
	note C_, 2
	note D_, 2
	note D#, 4
	note C_, 2
	note D_, 2
	note D#, 2
	endchannel

Music_LookRival_branch_f50f7:
	note A#, 2
	note F_, 2
	note G_, 2
	note G#, 4
	note F_, 2
	note G_, 2
	note G#, 2
	endchannel

Music_LookRival_branch_f50ff:
	note A#, 4
	note F_, 2
	note G#, 4
	note F_, 2
	note G_, 2
	note G#, 2
	endchannel

Music_LookRival_Ch4:
	stereo_panning TRUE, FALSE
	toggle_noise 3
	note_type 12
	note __, 8
	note __, 16
	note D#, 2
	note D_, 4
	note D_, 6
	note D_, 4
	note D#, 4
	note D#, 4
	note D_, 2
	note D_, 2
	note D_, 2
	note D_, 2
Music_AfterTheRivalFight_branch_f5118:
Music_LookRival_branch_f5118:
	note D#, 4
	note D_, 2
	note D#, 4
	note D#, 2
	note D_, 4
	note D#, 4
	note D_, 2
	note D#, 4
	note D#, 2
	note D_, 2
	note D_, 2
	jumpchannel Music_LookRival_branch_f5118
