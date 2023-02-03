Music_GoldenrodCity:
	channel_count 4
	channel 1, Music_GoldenrodCity_Ch1
	channel 2, Music_GoldenrodCity_Ch2
	channel 3, Music_GoldenrodCity_Ch3
	channel 4, Music_GoldenrodCity_Ch4

Music_GoldenrodCity_Ch1:
	stereopanning $f
	tempo 176
	volume 7, 7
	note_type 12, 9, 7
	note __, 16
	note __, 16
	note __, 16
	note __, 16
Music_GoldenrodCity_branch_eb46d:
	duty_cycle 0
	callchannel Music_GoldenrodCity_branch_eb4a9
	octave 3
	note G#, 1
	octave 4
	note C_, 1
	note D#, 1
	note F#, 1
	note D#, 1
	note F#, 1
	note G#, 1
	octave 5
	note C_, 1
	volume_envelope 7, 1
	duty_cycle 0
	callchannel Music_GoldenrodCity_branch_eb4d1
	volume_envelope 7, 7
	note D#, 2
	note F_, 2
	note F#, 2
	note G#, 4
	volume_envelope 7, 1
	callchannel Music_GoldenrodCity_branch_eb4d1
	note D#, 1
	note F#, 1
	volume_envelope 7, 7
	octave 5
	note C_, 2
	octave 4
	note G#, 2
	note F#, 2
	note D#, 2
	duty_cycle 2
	volume_envelope 9, 7
	callchannel Music_GoldenrodCity_branch_eb4a9
	note C_, 4
	octave 3
	note G#, 2
	octave 4
	note C_, 2
	jumpchannel Music_GoldenrodCity_branch_eb46d

Music_GoldenrodCity_branch_eb4a9:
	octave 4
	note C#, 2
	octave 3
	note G#, 1
	note __, 3
	note G#, 1
	note __, 1
	octave 4
	note C_, 2
	octave 3
	note G#, 1
	note __, 3
	note G#, 1
	note __, 1
	note A#, 2
	note F_, 1
	note __, 1
	note C#, 2
	note F_, 1
	note __, 1
	note D#, 2
	note C_, 2
	note C#, 2
	note D#, 2
	note F#, 2
	note C#, 1
	note __, 3
	note C#, 1
	note __, 1
	note F#, 2
	note C#, 1
	note __, 1
	note F#, 2
	note A#, 2
	note C#, 2
	note D#, 2
	note G#, 2
	octave 4
	note C#, 2
	endchannel

Music_GoldenrodCity_branch_eb4d1:
	octave 4
	note F_, 1
	note C#, 1
	octave 3
	note G#, 1
	octave 4
	note C#, 1
	note F_, 1
	note G#, 1
	note F_, 1
	note G#, 1
	note C#, 1
	octave 3
	note G#, 1
	note F_, 1
	note G#, 1
	octave 4
	note C#, 1
	note F_, 1
	note C#, 1
	note F_, 1
	note D#, 1
	note C_, 1
	octave 3
	note G#, 1
	octave 4
	note C_, 1
	note D#, 1
	note F#, 1
	note D#, 1
	note F#, 1
	note C_, 1
	octave 3
	note G#, 1
	note F#, 1
	note G#, 1
	octave 4
	note C_, 1
	note D#, 1
	note C_, 1
	note D#, 1
	note C#, 1
	octave 3
	note A#, 1
	note F#, 1
	note A#, 1
	octave 4
	note C#, 1
	note F_, 1
	note C#, 1
	note F_, 1
	octave 3
	note A#, 1
	note F#, 1
	note C#, 1
	note F#, 1
	note A#, 1
	octave 4
	note C#, 1
	octave 3
	note A#, 1
	octave 4
	note C#, 1
	note D#, 1
	note C_, 1
	octave 3
	note G#, 1
	octave 4
	note C_, 1
	note D#, 1
	note F#, 1
	endchannel

Music_GoldenrodCity_Ch2:
	stereopanning $f0
	vibrato $12, $23
	duty_cycle 2
	note_type 12, 9, 7
Music_GoldenrodCity_branch_eb523:
	volume_envelope 9, 7
	callchannel Music_GoldenrodCity_branch_eb555
	octave 4
	note F_, 2
	note F#, 2
	note G#, 2
	note F_, 2
	note D#, 8
	callchannel Music_GoldenrodCity_branch_eb555
	note G#, 2
	note A#, 2
	octave 5
	note C_, 2
	note C#, 2
	note D#, 8
	duty_cycle 2
	volume_envelope 7, 7
	callchannel Music_GoldenrodCity_branch_eb572
	octave 4
	note G#, 2
	note A#, 2
	note B_, 2
	octave 5
	note C_, 4
	duty_cycle 3
	volume_envelope 7, 7
	callchannel Music_GoldenrodCity_branch_eb572
	note F_, 2
	note D#, 2
	note C#, 2
	note C_, 2
	octave 4
	note G#, 2
	jumpchannel Music_GoldenrodCity_branch_eb523

Music_GoldenrodCity_branch_eb555:
	octave 4
	note F_, 4
	note C#, 4
	note D#, 4
	note C_, 4
	note C#, 2
	note C_, 2
	octave 3
	note A#, 2
	octave 4
	note C_, 2
	octave 3
	note G#, 6
	octave 3
	note G#, 1
	octave 3
	note A_, 1
	note A#, 4
	octave 4
	note C#, 4
	octave 3
	note A#, 2
	octave 4
	note A#, 2
	note G#, 2
	note F#, 2
	duty_cycle 1
	endchannel

Music_GoldenrodCity_branch_eb572:
	note C#, 6
	note F_, 6
	note C#, 4
	note C_, 6
	note D#, 6
	note C_, 2
	octave 4
	note G#, 1
	note A_, 1
	note A#, 6
	octave 5
	note C#, 6
	octave 4
	note A#, 4
	octave 5
	note C_, 4
	note D#, 2
	endchannel

Music_GoldenrodCity_Ch3:
	stereopanning $ff
	vibrato $8, $23
	note_type 12, 2, 5
Music_GoldenrodCity_branch_eb58c:
	callchannel Music_GoldenrodCity_branch_eb5aa
	callchannel Music_GoldenrodCity_branch_eb5aa
	callchannel Music_GoldenrodCity_branch_eb5d2
	note __, 3
	octave 3
	note C_, 1
	note D#, 1
	note G_, 1
	note G#, 1
	note D#, 2
	callchannel Music_GoldenrodCity_branch_eb5d2
	note __, 1
	octave 3
	note G#, 2
	note F#, 2
	note D#, 2
	octave 2
	note G#, 2
	jumpchannel Music_GoldenrodCity_branch_eb58c

Music_GoldenrodCity_branch_eb5aa:
	octave 3
	note C#, 4
	note __, 2
	note C#, 1
	note __, 1
	note C_, 4
	note __, 2
	note C_, 1
	note __, 1
	octave 2
	note A#, 4
	note __, 2
	note A#, 1
	note __, 1
	note G#, 4
	note __, 2
	note G#, 1
	note __, 1
	note F#, 4
	note __, 2
	note F#, 1
	note __, 1
	octave 3
	note D#, 4
	note __, 2
	note D#, 1
	note __, 1
	note G#, 4
	note __, 2
	note G#, 1
	note __, 1
	octave 2
	note G#, 1
	note __, 1
	note G#, 3
	note __, 1
	octave 3
	note G#, 1
	note __, 1
	endchannel

Music_GoldenrodCity_branch_eb5d2:
	note C#, 1
	note __, 1
	octave 4
	note C#, 1
	octave 3
	note C#, 1
	note __, 2
	note C#, 1
	note __, 5
	octave 4
	note C_, 1
	note C#, 1
	octave 3
	note G#, 2
	note C_, 1
	note __, 1
	octave 4
	note C_, 1
	octave 3
	note C_, 1
	note __, 2
	note C_, 1
	note __, 5
	note B_, 1
	octave 4
	note C_, 1
	octave 3
	note G#, 2
	octave 2
	note A#, 1
	note __, 1
	octave 3
	note A#, 1
	octave 2
	note A#, 1
	note __, 2
	note A#, 1
	note __, 5
	octave 3
	note A_, 1
	note A#, 1
	note F#, 2
	octave 2
	note G#, 1
	note __, 1
	octave 3
	note G#, 1
	octave 2
	note G#, 1
	note __, 2
	note G#, 1
	endchannel

Music_GoldenrodCity_Ch4:
	togglenoise $3
	note_type 12
	note __, 16
	note __, 16
	note __, 16
	note __, 8
	note D_, 2
	note F#, 2
	note D_, 1
	note D_, 1
	note F#, 2
Music_GoldenrodCity_branch_eb613:
	note D#, 2
	note F#, 2
	note D_, 2
	note F#, 2
	note D#, 2
	note F#, 2
	note D_, 2
	note F#, 2
	loopchannel 3, Music_GoldenrodCity_branch_eb613
	callchannel Music_GoldenrodCity_branch_eb663
	callchannel Music_GoldenrodCity_branch_eb66d
	note G_, 1
	note G_, 1
	note F#, 2
	callchannel Music_GoldenrodCity_branch_eb66d
	note D_, 2
	note F#, 2
	callchannel Music_GoldenrodCity_branch_eb66d
	note D_, 1
	note D_, 1
	note F#, 2
	callchannel Music_GoldenrodCity_branch_eb66d
	note D_, 2
	note D_, 1
	note D_, 1
	callchannel Music_GoldenrodCity_branch_eb66d
	note G_, 1
	note G_, 1
	note F#, 2
	callchannel Music_GoldenrodCity_branch_eb66d
	note D_, 2
	note F#, 2
	callchannel Music_GoldenrodCity_branch_eb66d
	note D_, 1
	note D_, 1
	note F#, 2
	callchannel Music_GoldenrodCity_branch_eb66d
	note D_, 2
	note D_, 1
	note D_, 1
Music_GoldenrodCity_branch_eb650:
	note D#, 2
	note F#, 2
	note D_, 2
	note F#, 2
	note D#, 2
	note F#, 2
	note D_, 2
	note F#, 2
	loopchannel 3, Music_GoldenrodCity_branch_eb650
	callchannel Music_GoldenrodCity_branch_eb663
	jumpchannel Music_GoldenrodCity_branch_eb613

Music_GoldenrodCity_branch_eb663:
	note D#, 2
	note F#, 2
	note D_, 2
	note F#, 2
	note D#, 2
	note F#, 2
	note D_, 1
	note D_, 1
	note F#, 2
	endchannel

Music_GoldenrodCity_branch_eb66d:
	note D#, 2
	note D_, 1
	note D#, 3
	note D#, 2
	note G_, 1
	note G_, 1
	note G_, 1
	note G_, 1
	endchannel
