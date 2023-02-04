Music_SproutTower:
	channel_count 4
	channel 1, Music_SproutTower_Ch1
	channel 2, Music_SproutTower_Ch2
	channel 3, Music_SproutTower_Ch3
	channel 4, Music_SproutTower_Ch4

Music_SproutTower_Ch1:
	tempo 176
	volume 7, 7
	duty_cycle 3
	tone $0002
	vibrato $8, $45
	stereopanning $f
	note_type 12, 10, 3
	note __, 16
	note __, 16
Music_SproutTower_branch_f6994:
	note __, 6
	octave 3
	note F_, 2
	note F#, 4
	note F#, 4
	note F_, 4
	note C_, 4
	note C#, 4
	note D#, 4
	note D#, 4
	note D#, 4
	note F#, 4
	note F#, 4
	note F_, 2
	note F#, 2
	note G#, 2
	note F#, 2
	note F_, 4
	note F#, 2
	note D#, 10
	note F#, 2
	note F_, 2
	note D#, 2
	note C#, 2
	volume_envelope 10, 5
	note C_, 8
	volume_envelope 10, 3
	note C#, 2
	note C_, 2
	octave 2
	note A#, 2
	octave 3
	note C#, 2
	volume_envelope 10, 7
	note C_, 16
	volume_envelope 10, 3
	note F_, 4
	note F_, 4
	note F#, 4
	note F#, 4
	note F_, 4
	note F_, 4
	note D#, 4
	note D#, 4
	jumpchannel Music_SproutTower_branch_f6994

Music_SproutTower_Ch2:
	duty_cycle 3
	tone $0001
	vibrato $8, $48
	note_type 12, 11, 2
	octave 3
	note F_, 4
	note F_, 4
	note F#, 4
	note F#, 4
	note F_, 4
	note F_, 4
	note D#, 4
	note D#, 4
Music_SproutTower_branch_f69dc:
	volume_envelope 11, 5
	octave 4
	note C_, 4
	octave 3
	note A#, 4
	octave 4
	note C#, 4
	note C_, 2
	octave 3
	note A#, 2
	octave 4
	note C_, 2
	octave 3
	note A#, 2
	note F#, 4
	volume_envelope 11, 7
	note F_, 8
	volume_envelope 11, 5
	note F#, 4
	note A#, 4
	octave 4
	note C_, 2
	note C#, 2
	note C_, 2
	octave 3
	note A#, 2
	octave 4
	note C_, 2
	note C#, 2
	note D#, 2
	note C#, 2
	note C_, 8
	volume_envelope 11, 5
	note C#, 2
	note C_, 2
	octave 3
	note A#, 2
	note F#, 2
	volume_envelope 11, 7
	note A#, 8
	volume_envelope 11, 5
	octave 4
	note C_, 2
	octave 3
	note A#, 2
	note F#, 2
	note D#, 2
	volume_envelope 11, 7
	note F_, 8
	volume_envelope 11, 3
	note F_, 4
	note F_, 4
	note F#, 4
	note A#, 2
	note F_, 1
	note A#, 1
	volume_envelope 11, 7
	octave 4
	note C_, 16
	note __, 16
	jumpchannel Music_SproutTower_branch_f69dc

Music_SproutTower_Ch3:
	vibrato $14, $e8
	note_type 12, 1, 4
	octave 3
	note F_, 2
	note __, 2
	note C_, 2
	note F_, 2
	note F#, 2
	note D#, 2
	note __, 2
	note F#, 2
	note F_, 2
	note __, 2
	note C_, 2
	note F_, 2
	note F#, 2
	note D#, 2
	note __, 2
	note F#, 2
	stereopanning $f0
Music_SproutTower_branch_f6a3e:
	note __, 4
	note C_, 2
	note F_, 2
	note F#, 2
	note D#, 2
	note __, 2
	note F#, 2
	note F_, 2
	note __, 2
	note C_, 2
	note F_, 2
	note F#, 2
	note D#, 2
	note __, 2
	note F_, 2
	note D#, 2
	note __, 2
	octave 2
	note A#, 2
	octave 3
	note D#, 2
	note F#, 2
	note D#, 2
	note __, 2
	note F#, 2
	note F_, 2
	note __, 2
	note C_, 2
	note F_, 2
	note F#, 2
	note D#, 2
	note __, 2
	note F#, 2
	note F_, 8
	note F#, 4
	note A#, 4
	note D#, 8
	note F_, 4
	note F#, 4
	note F_, 16
	note F_, 2
	note __, 2
	note C_, 2
	note F_, 2
	note F#, 2
	note D#, 2
	note __, 2
	note F_, 2
	note F_, 2
	note __, 2
	note C_, 2
	note F_, 2
	note F#, 2
	note D#, 2
	note __, 2
	note F_, 2
	jumpchannel Music_SproutTower_branch_f6a3e

Music_SproutTower_Ch4:
	toggle_noise 0
	note_type 12
	note __, 4
Music_SproutTower_branch_f6a7f:
	note F#, 4
	stereopanning $f0
	note D#, 4
	note F#, 2
	stereopanning $f
	note D#, 2
	stereopanning $ff
	note F#, 4
	note F#, 4
	stereopanning $f
	note D#, 4
	note F#, 2
	stereopanning $f0
	note D#, 2
	stereopanning $ff
	note F#, 4
	jumpchannel Music_SproutTower_branch_f6a7f
