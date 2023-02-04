Music_BurnedTower:
	channel_count 4
	channel 1, Music_BurnedTower_Ch1
	channel 2, Music_BurnedTower_Ch2
	channel 3, Music_BurnedTower_Ch3
	channel 4, Music_BurnedTower_Ch4

Music_BurnedTower_Ch1:
	tempo 168
	volume 7, 7
	duty_cycle 1
	tone $0004
	vibrato $8, $45
	stereopanning $f0
	note_type 12, 9, 1
	note __, 2
	octave 2
	note A_, 4
	note A_, 4
	note A_, 2
	volume_envelope 8, 0
	octave 3
	note D#, 6
	volume_envelope 9, 1
	note D_, 4
	note D_, 4
	note D_, 2
	volume_envelope 8, 0
	note C#, 6
Music_BurnedTower_branch_f6ac8:
	volume_envelope 9, 1
	octave 2
	note A_, 4
	note A_, 4
	note A_, 2
	volume_envelope 8, 0
	note A#, 6
	loopchannel 2, Music_BurnedTower_branch_f6ac8
	tempo 150
Music_BurnedTower_branch_f6ad8:
	volume_envelope 11, 1
	octave 2
	note A_, 4
	note A_, 4
	note A_, 2
	volume_envelope 10, 0
	octave 3
	note D#, 6
	volume_envelope 11, 1
	note D_, 4
	note D_, 4
	note D_, 2
	volume_envelope 10, 0
	note C#, 6
	volume_envelope 11, 1
	octave 2
	note A_, 4
	note A_, 4
	note A_, 2
	volume_envelope 10, 0
	note A#, 6
	volume_envelope 11, 1
	note A_, 4
	note A_, 4
	note A_, 2
	volume_envelope 11, 3
	note A#, 16
	note A#, 16
	note A#, 16
	note G#, 6
	volume_envelope 11, 1
	note A_, 4
	note A_, 4
	note A_, 2
	volume_envelope 10, 0
	note A#, 6
	volume_envelope 11, 1
	note B_, 4
	note B_, 4
	note B_, 2
	volume_envelope 10, 0
	octave 3
	note F_, 6
	volume_envelope 11, 1
	note E_, 4
	note E_, 4
	note E_, 2
	volume_envelope 10, 0
	note D#, 6
Music_BurnedTower_branch_f6b17:
	volume_envelope 11, 1
	octave 2
	note B_, 4
	note B_, 4
	note B_, 2
	volume_envelope 10, 0
	octave 3
	note C_, 6
	loopchannel 2, Music_BurnedTower_branch_f6b17
	jumpchannel Music_BurnedTower_branch_f6ad8

Music_BurnedTower_Ch2:
	duty_cycle 2
	vibrato $20, $82
	tone $0002
	note_type 12, 7, 0
	callchannel Music_BurnedTower_branch_f6b8e
	volume_envelope 12, 5
Music_BurnedTower_branch_f6b39:
	callchannel Music_BurnedTower_branch_f6b8e
	volume_envelope 12, 1
	duty_cycle 3
	note __, 2
	octave 2
	note A_, 4
	note A_, 4
	note A_, 2
	volume_envelope 11, 0
	octave 3
	note D#, 6
	volume_envelope 12, 1
	note D_, 4
	note D_, 4
	note D_, 2
	volume_envelope 11, 0
	note C#, 6
	volume_envelope 12, 1
	octave 2
	note A_, 4
	note A_, 4
	note A_, 2
	volume_envelope 11, 0
	note A#, 4
	volume_envelope 12, 1
	volume_envelope 12, 2
	octave 3
	note A_, 1
	note G_, 1
	note A_, 1
	octave 4
	note C_, 1
	vibrato $0, $0
	volume_envelope 3, -5
	note E_, 8
	vibrato $20, $83
	volume_envelope 11, 0
	octave 2
	note G_, 4
	duty_cycle 2
	volume_envelope 11, 0
	octave 3
	note F#, 4
	note E_, 2
	note F#, 2
	note G_, 4
	note B_, 4
	octave 4
	note C#, 4
	note D_, 2
	note C#, 2
	octave 3
	note B_, 4
	note G_, 4
	note F#, 4
	note E_, 2
	note F#, 2
	note G_, 4
	note E_, 4
	volume_envelope 11, 7
	note F#, 16
	jumpchannel Music_BurnedTower_branch_f6b39

Music_BurnedTower_branch_f6b8e:
	octave 3
	note E_, 4
	note D_, 2
	note E_, 2
	note F_, 4
	note A_, 4
	note B_, 4
	octave 4
	note C_, 2
	octave 3
	note B_, 2
	note A_, 4
	note F_, 4
	note E_, 4
	note D_, 2
	note E_, 2
	note F_, 4
	note D_, 4
	note E_, 16
	endchannel

Music_BurnedTower_Ch3:
	stereopanning $f
	note_type 12, 1, 4
	note __, 16
	note __, 16
	note __, 16
	note __, 12
	octave 3
	note D#, 4
Music_BurnedTower_branch_f6bad:
	octave 2
	note A_, 2
	octave 3
	note E_, 2
	note __, 2
	note E_, 2
	note __, 2
	note E_, 2
	note F_, 4
	octave 2
	note A_, 2
	octave 3
	note E_, 2
	note __, 2
	note E_, 2
	note __, 2
	note E_, 2
	note D#, 4
	loopchannel 4, Music_BurnedTower_branch_f6bad
Music_BurnedTower_branch_f6bc3:
	octave 2
	note B_, 2
	octave 3
	note F#, 2
	note __, 2
	note F#, 2
	note __, 2
	note F#, 2
	note G_, 4
	octave 2
	note B_, 2
	octave 3
	note F#, 2
	note __, 2
	note F#, 2
	note __, 2
	note F#, 2
	note F_, 4
	loopchannel 2, Music_BurnedTower_branch_f6bc3
	jumpchannel Music_BurnedTower_branch_f6bad

Music_BurnedTower_Ch4:
	toggle_noise 0
	note_type 12
Music_BurnedTower_branch_f6be1:
	note __, 16
	loopchannel 4, Music_BurnedTower_branch_f6be1
	note __, 2
Music_BurnedTower_branch_f6be7:
	stereopanning $f0
	note G_, 2
	note G#, 2
	note G_, 4
	note G#, 2
	note G_, 4
	jumpchannel Music_BurnedTower_branch_f6be7
