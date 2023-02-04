Music_Clair:
	channel_count 4
	channel 1, Music_Clair_Ch1
	channel 2, Music_Clair_Ch2
	channel 3, Music_Clair_Ch3
	channel 4, Music_Clair_Ch4

Music_Clair_Ch1:
	tempo 136
	volume 7, 7
	tone $0001
	vibrato $12, $34
	stereopanning $f
	note_type 12, 9, 3
	duty_cycle 3
Music_Clair_branch_1faab:
	octave 4
	note F_, 1
	note F#, 1
	note F_, 1
	note __, 1
	note C#, 1
	note __, 1
	loopchannel 2, Music_Clair_branch_1faab
	octave 3
	note B_, 1
	note __, 1
	note G#, 1
	duty_cycle 2
	volume_envelope 9, 2
	octave 5
	note F_, 1
	note G_, 4
	volume_envelope 10, 7
	duty_cycle 3
	octave 3
	note D#, 4
	note F_, 4
	note G_, 4
Music_Clair_branch_1fac9:
	volume_envelope 9, 3
	callchannel Music_Clair_branch_1fb12
	octave 2
	note B_, 1
	octave 3
	note C#, 1
	note D#, 2
	octave 2
	note G_, 1
	note A#, 1
	octave 3
	note C#, 2
	octave 2
	note A#, 1
	note G_, 1
	callchannel Music_Clair_branch_1fb12
	note D#, 1
	note C#, 1
	note D#, 2
	octave 4
	note A#, 1
	note G#, 1
	note G_, 1
	note G#, 1
	note A#, 1
	octave 5
	note D#, 1
	callchannel Music_Clair_branch_1fb2e
	duty_cycle 3
	note G#, 3
	note F_, 2
	note __, 1
	note A#, 4
	duty_cycle 2
	note D#, 1
	note C#, 1
	note D#, 1
	note G_, 1
	note A#, 1
	octave 5
	note D#, 1
	callchannel Music_Clair_branch_1fb2e
	duty_cycle 3
	note D#, 3
	note C#, 2
	note __, 1
	octave 3
	note B_, 4
	duty_cycle 2
	note G#, 1
	note C#, 1
	note D#, 1
	note G#, 1
	note B_, 1
	octave 4
	note D#, 1
	jumpchannel Music_Clair_branch_1fac9

Music_Clair_branch_1fb12:
	duty_cycle 3
	stereopanning $ff
	octave 3
	note B_, 1
	note __, 2
	note G#, 5
	duty_cycle 2
	stereopanning $f
	octave 2
	note B_, 2
	note G#, 1
	note B_, 1
	octave 3
	note D#, 1
	note __, 1
	note D#, 1
	note F#, 1
	note F_, 1
	note C#, 1
	note __, 1
	note F_, 1
	note C#, 1
	note __, 1
	endchannel

Music_Clair_branch_1fb2e:
	octave 4
	note F#, 1
	note D#, 1
	note __, 1
	note F#, 1
	note D#, 1
	note __, 1
	octave 3
	note D#, 1
	note G#, 1
	note B_, 2
	note G#, 1
	note B_, 1
	octave 4
	note D#, 1
	note __, 1
	note D#, 1
	note F#, 1
	endchannel

Music_Clair_Ch2:
	duty_cycle 3
	vibrato $12, $34
	note_type 6, 11, 7
Music_Clair_branch_1fb49:
	octave 3
	note A#, 2
	note B_, 2
	note A#, 2
	note __, 2
	note G#, 2
	note __, 2
	loopchannel 2, Music_Clair_branch_1fb49
	note F_, 2
	note __, 2
	note C#, 2
	note __, 2
	volume_envelope 8, 2
	note D#, 2
	note A#, 2
	octave 4
	note C#, 2
	octave 3
	note A#, 2
	volume_envelope 9, 2
	note G_, 2
	octave 4
	note C#, 2
	note D#, 2
	octave 3
	note A#, 2
	volume_envelope 11, 2
	octave 4
	note C#, 2
	note D#, 2
	note G_, 2
	note D#, 2
	volume_envelope 12, 2
	note C#, 2
	note D#, 2
	note G_, 2
	note A#, 2
	volume_envelope 11, 7
Music_Clair_branch_1fb77:
	callchannel Music_Clair_branch_1fba6
	note F#, 2
	note __, 4
	note D#, 12
	note __, 2
	note D#, 4
	note C#, 4
	octave 3
	note B_, 3
	note A#, 1
	note B_, 6
	octave 4
	note C#, 4
	note __, 2
	octave 3
	note A#, 16
	note __, 4
	transpose 0, 12
	callchannel Music_Clair_branch_1fba6
	transpose 0, 0
	octave 5
	note F#, 2
	note __, 4
	note D#, 12
	note __, 2
	octave 4
	note G#, 4
	note A#, 4
	note B_, 3
	octave 5
	note C_, 1
	note C#, 6
	octave 4
	note A#, 4
	note __, 2
	note G#, 16
	note __, 4
	jumpchannel Music_Clair_branch_1fb77

Music_Clair_branch_1fba6:
	octave 4
	note F#, 2
	note __, 4
	note D#, 12
	note __, 2
	octave 3
	note G#, 4
	note A#, 4
	note B_, 3
	octave 4
	note C_, 1
	note C#, 6
	octave 3
	note B_, 4
	note __, 2
	octave 4
	note D#, 16
	note __, 4
	endchannel

Music_Clair_Ch3:
	note_type 12, 1, 4
	transpose 0, 12
	octave 3
	note C#, 2
	note __, 4
	octave 2
	note G#, 1
	note B_, 1
	octave 3
	note C#, 2
	note __, 4
	octave 2
	note G#, 1
	note B_, 1
	octave 3
	note D#, 2
	note __, 2
	octave 2
	note A#, 4
	note G#, 4
	note G_, 4
Music_Clair_branch_1fbd1:
	callchannel Music_Clair_branch_1fc3c
	octave 2
	note C#, 2
	note __, 1
	note G#, 2
	note __, 1
	note C#, 2
	note __, 2
	note D#, 2
	note A#, 2
	note D#, 2
	callchannel Music_Clair_branch_1fc3c
	octave 2
	note G#, 2
	note __, 1
	note C#, 2
	note __, 1
	note D#, 2
	note __, 2
	note D#, 1
	note C#, 1
	note D#, 1
	note F_, 1
	note G_, 1
	note A#, 1
	octave 1
	note G#, 2
	note __, 1
	octave 2
	note D#, 2
	note __, 1
	octave 1
	note G#, 2
	octave 3
	note F#, 1
	note __, 1
	octave 1
	note G#, 1
	octave 3
	note D#, 1
	octave 2
	note D#, 2
	octave 1
	note G#, 2
	octave 2
	note C#, 2
	note __, 1
	note G#, 2
	note __, 1
	note C#, 2
	octave 3
	note D#, 1
	note __, 1
	octave 2
	note D#, 1
	octave 3
	note A#, 1
	octave 2
	note A#, 2
	octave 3
	note G_, 1
	octave 2
	note D#, 1
	octave 1
	note G#, 2
	note __, 1
	octave 2
	note D#, 2
	note __, 1
	octave 1
	note G#, 2
	octave 3
	note F#, 1
	note __, 1
	octave 1
	note G#, 1
	octave 3
	note D#, 1
	octave 2
	note D#, 2
	octave 1
	note G#, 2
	octave 2
	note D#, 2
	note __, 1
	note G_, 2
	note __, 1
	note G#, 2
	octave 2
	note B_, 1
	note __, 1
	octave 1
	note G#, 1
	octave 2
	note A#, 1
	note D#, 2
	note G#, 1
	octave 1
	note G#, 1
	jumpchannel Music_Clair_branch_1fbd1

Music_Clair_branch_1fc3c:
	octave 1
	note G#, 2
	note __, 1
	octave 2
	note D#, 2
	note __, 1
	octave 1
	note G#, 2
	note __, 2
	note G#, 2
	octave 2
	note D#, 2
	octave 1
	note G#, 2
	endchannel

Music_Clair_Ch4:
	toggle_noise 3
	note_type 12
	stereopanning $f0
	note B_, 8
	note B_, 8
	note B_, 6
	stereopanning $ff
	note D#, 1
	note D#, 1
	note D_, 2
	note D#, 1
	note D#, 1
	note D_, 2
	note D_, 1
	note D_, 1
Music_Clair_branch_1fc5e:
	stereopanning $ff
	callchannel Music_Clair_branch_1fc6e
	note G_, 1
	stereopanning $ff
	callchannel Music_Clair_branch_1fc6e
	note F#, 1
	jumpchannel Music_Clair_branch_1fc5e

Music_Clair_branch_1fc6e:
	note D#, 2
	stereopanning $f0
	note G_, 2
	stereopanning $ff
	note D_, 2
	stereopanning $f0
	note G_, 1
	note G_, 1
	note G_, 2
	stereopanning $ff
	note D#, 1
	stereopanning $f0
	note G_, 1
	stereopanning $ff
	note D_, 2
	stereopanning $f0
	note G_, 1
	endchannel
