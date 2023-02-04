Music_HallOfFame:
	channel_count 4
	channel 1, Music_HallOfFame_Ch1
	channel 2, Music_HallOfFame_Ch2
	channel 3, Music_HallOfFame_Ch3
	channel 4, Music_HallOfFame_Ch4

Music_HallOfFame_Ch1:
	tempo 112
	volume 7, 7
	duty_cycle 2
	vibrato $c, $22
	pitch_offset 1
	stereo_panning TRUE, FALSE
	note_type 12, 9, 3
	note __, 16
	note __, 16
	note __, 16
	note __, 12
	octave 3
	note D_, 1
	note E_, 1
	note F_, 1
	note F#, 1
Music_HallOfFame_branch_f05e6:
	volume_envelope 9, 7
	octave 4
	note C_, 8
	volume_envelope 7, 7
	note C_, 8
	volume_envelope 9, 7
	note E_, 8
	volume_envelope 7, 7
	note E_, 8
	volume_envelope 9, 7
	note F#, 8
	volume_envelope 7, 7
	note F#, 8
	volume_envelope 7, 7
	note F_, 8
	volume_envelope 5, 7
	note F_, 8
	loopchannel 3, Music_HallOfFame_branch_f05e6
	note __, 16
	note __, 16
	note __, 16
	note __, 16
	sound_jump Music_HallOfFame_branch_f05e6

Music_HallOfFame_Ch2:
	vibrato $8, $25
	duty_cycle 3
Music_HallOfFame_branch_f0610:
	note_type 12, 12, 4
	octave 3
	note G_, 2
	note D_, 2
	note G_, 2
	note A_, 10
	note G_, 2
	note D_, 2
	note G_, 2
	octave 4
	note C_, 4
	octave 3
	note B_, 4
	note A_, 2
	note G_, 2
	note D_, 2
	note G_, 2
	note A_, 10
	note F_, 2
	note C_, 2
	note F_, 2
	note A#, 4
	note A_, 4
	note F_, 2
	sound_jump Music_HallOfFame_branch_f0610

Music_HallOfFame_Ch3:
Music_HallOfFame_branch_f062e:
	note_type 12, 2, 8
Music_HallOfFame_branch_f0631:
	octave 3
	note D_, 2
	note G_, 2
	note D_, 2
	note G_, 2
	note D_, 2
	note G_, 2
	note D_, 2
	note G_, 2
	octave 3
	note D_, 2
	note G_, 2
	note D_, 2
	note G_, 2
	note D_, 2
	note G_, 2
	note D_, 2
	note G_, 2
	octave 3
	note D_, 2
	note G_, 2
	note D_, 2
	note G_, 2
	note D_, 2
	note G_, 2
	note D_, 2
	note G_, 2
	octave 3
	note C_, 2
	note F_, 2
	note C_, 2
	note F_, 2
	note C_, 2
	note F_, 2
	note C_, 2
	note F_, 2
	loopchannel 3, Music_HallOfFame_branch_f0631
	note D_, 4
	note G_, 4
	note D_, 4
	note G_, 4
	note E_, 4
	note G_, 4
	note E_, 4
	note G_, 4
	note F#, 4
	note A_, 4
	note F#, 4
	note A_, 4
	note E_, 4
	note G_, 4
	note E_, 4
	note G_, 4
	sound_jump Music_HallOfFame_branch_f062e

Music_HallOfFame_Ch4:
	toggle_noise 5
	note_type 12
	note __, 16
	note __, 16
	note __, 16
	note __, 16
	note_type 6
Music_HallOfFame_branch_f0677:
	stereo_panning FALSE, TRUE
	note A#, 4
	note A#, 8
	note A#, 4
	note A#, 4
	note A#, 4
	stereo_panning TRUE, FALSE
	note A_, 2
	note A_, 2
	note A#, 2
	note A#, 2
	note A#, 4
	note A#, 4
	note A#, 8
	note A#, 4
	note A#, 4
	stereo_panning FALSE, TRUE
	note A#, 1
	note A#, 1
	note A_, 1
	note A_, 1
	note A#, 1
	note A#, 1
	note A#, 1
	note A#, 1
	sound_jump Music_HallOfFame_branch_f0677
