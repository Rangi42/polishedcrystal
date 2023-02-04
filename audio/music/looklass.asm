Music_LookLass:
	channel_count 4
	channel 1, Music_LookLass_Ch1
	channel 2, Music_LookLass_Ch2
	channel 3, Music_LookLass_Ch3
	channel 4, Music_LookLass_Ch4

Music_LookLass_Ch1:
	tempo 132
	volume 7, 7
	tone $0001
	duty_cycle 2
	note_type 12, 12, 7
	octave 3
	note B_, 1
	note __, 1
	octave 4
	note B_, 14
	stereo_panning FALSE, TRUE
	duty_cycle 0
Music_LookLass_branch_ed7bd:
	volume_envelope 10, 2
	octave 3
	note E_, 4
	volume_envelope 10, 1
	note E_, 4
	note E_, 4
	note E_, 2
	volume_envelope 10, 3
	note B_, 2
	jumpchannel Music_LookLass_branch_ed7bd

Music_LookLass_Ch2:
	stereo_panning TRUE, FALSE
	duty_cycle 0
	note_type 12, 8, 3
	note __, 16
Music_LookLass_branch_ed7d5:
	volume_envelope 9, 2
	octave 2
	note B_, 4
	volume_envelope 9, 1
	note B_, 4
	note B_, 4
	note B_, 2
	volume_envelope 9, 3
	octave 3
	note G#, 2
	jumpchannel Music_LookLass_branch_ed7d5

Music_LookLass_Ch3:
	note_type 12, 1, 0
	note __, 8
	octave 6
	note E_, 2
	note D#, 2
	note C#, 2
	note C_, 2
Music_LookLass_branch_ed7ef:
	octave 5
	note B_, 2
	note __, 2
	octave 6
	note D#, 2
	note __, 2
	note E_, 2
	note __, 2
	note D#, 2
	note __, 2
	note C#, 2
	note C_, 2
	octave 5
	note B_, 2
	note A_, 2
	note G#, 2
	note A_, 2
	note A#, 2
	octave 6
	note C#, 2
	octave 5
	note B_, 2
	note __, 2
	octave 6
	note C#, 2
	note __, 2
	octave 5
	note B_, 2
	note __, 2
	note A_, 2
	note __, 2
	note G#, 2
	note F#, 2
	note E_, 2
	note D#, 2
	note E_, 2
	note F#, 2
	note G#, 2
	note A_, 2
	jumpchannel Music_LookLass_branch_ed7ef

Music_LookLass_Ch4:
	toggle_noise 4
	note_type 12
	note C_, 16
Music_LookLass_branch_ed81f:
	note_type 6
	note D_, 8
	note C#, 8
	note C#, 8
	note C#, 4
	note D_, 1
	note C#, 1
	note C#, 1
	note C#, 1
	jumpchannel Music_LookLass_branch_ed81f
