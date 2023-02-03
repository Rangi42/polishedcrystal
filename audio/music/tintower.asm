Music_TinTower:
	channel_count 4
	channel 1, Music_TinTower_Ch1
	channel 2, Music_TinTower_Ch2
	channel 3, Music_TinTower_Ch3
	channel 4, Music_TinTower_Ch4

Music_TinTower_Ch1:
	tempo 208
	volume 7, 7
	duty_cycle 3
	tone $0004
	vibrato $8, $45
Music_TinTower_branch_f682a:
	stereopanning $f0
	note_type 12, 10, 5
	octave 3
	note G_, 4
	note C_, 4
	note G#, 8
	note G_, 4
	note C_, 4
	octave 2
	note A#, 2
	octave 3
	note C_, 2
	note C#, 2
	octave 2
	note A#, 2
	octave 3
	note G_, 4
	note C_, 4
	note G#, 4
	note F_, 4
	note G_, 4
	octave 2
	note G_, 4
	octave 3
	note G_, 6
	note A#, 2
	note G_, 2
	note F_, 2
	note C#, 2
	note G_, 2
	note G#, 8
	note G_, 4
	octave 4
	note C_, 4
	octave 3
	note G#, 2
	note G_, 2
	note F_, 2
	note G#, 2
	note G_, 2
	note C#, 2
	octave 2
	note A#, 2
	octave 3
	note G_, 2
	note G#, 4
	note F_, 4
	note G_, 4
	octave 2
	note G_, 4
	octave 3
	note G_, 8
	volume_envelope 10, 2
	octave 2
	note G_, 4
	note G_, 12
	note G_, 4
	note G_, 8
	volume_envelope 10, 7
	note G_, 4
	volume_envelope 10, 2
	note G#, 4
	note G#, 8
	volume_envelope 10, 7
	note G_, 4
	volume_envelope 10, 2
	note G#, 4
	note G#, 8
	volume_envelope 10, 7
	note A#, 4
	volume_envelope 10, 2
	note G_, 4
	note G_, 12
	note G_, 4
	note G_, 12
	note G_, 4
	note G_, 12
	note G_, 4
	note G_, 8
	volume_envelope 10, 5
	octave 3
	note A#, 4
	jumpchannel Music_TinTower_branch_f682a

Music_TinTower_Ch2:
	duty_cycle 3
	tone $0002
	vibrato $18, $44
Music_TinTower_branch_f6893:
	stereopanning $ff
Music_TinTower_branch_f6895:
	note_type 12, 11, 5
	octave 4
	note C_, 4
	note C_, 4
	note C#, 2
	note C_, 2
	octave 3
	note A#, 2
	octave 4
	note C#, 2
	note C_, 4
	note F_, 4
	note C#, 4
	octave 3
	note A#, 4
	octave 4
	note C_, 4
	note C_, 4
	note C#, 2
	note C_, 2
	octave 3
	note A#, 2
	octave 4
	note C#, 2
	note C_, 4
	octave 3
	note C_, 4
	octave 4
	note C_, 8
	stereopanning $f
	loopchannel 2, Music_TinTower_branch_f6895
	volume_envelope 11, 2
	octave 3
	note C_, 4
	note C_, 12
	note C_, 4
	note C_, 8
	volume_envelope 11, 7
	note C_, 4
	volume_envelope 11, 2
	note C#, 4
	note C#, 8
	volume_envelope 11, 7
	note C_, 4
	volume_envelope 11, 2
	note C#, 4
	note C#, 8
	volume_envelope 11, 7
	note D#, 4
	volume_envelope 9, 0
	stereopanning $ff
	note G_, 4
	octave 4
	note C_, 4
	octave 3
	note A#, 2
	note G#, 2
	note G_, 2
	note G#, 2
	note G_, 4
	note C_, 4
	note G_, 8
	note G_, 4
	octave 4
	note C_, 4
	octave 3
	note A#, 2
	octave 4
	note C_, 2
	note C#, 2
	octave 3
	note A#, 2
	octave 4
	note C_, 4
	octave 3
	note C_, 4
	octave 4
	note C_, 6
	volume_envelope 9, 5
	note C#, 2
	jumpchannel Music_TinTower_branch_f6893

Music_TinTower_Ch3:
	note_type 12, 1, 4
Music_TinTower_branch_f68fb:
	note __, 16
	note __, 16
	note __, 16
	note __, 10
	octave 2
	note G_, 2
	note G#, 2
	note A#, 2
	octave 3
	note C_, 8
	note C#, 8
	note E_, 8
	octave 2
	note A#, 2
	octave 3
	note C_, 2
	note C#, 2
	note D#, 2
	note C_, 8
	note C#, 8
	note E_, 8
	octave 4
	note C_, 8
	octave 3
	note C_, 1
	note __, 3
	note C_, 1
	note __, 11
	note C_, 1
	note __, 3
	note C_, 1
	note __, 7
	note C_, 4
	note C#, 1
	note __, 3
	note C#, 1
	note __, 7
	note C_, 4
	note C#, 1
	note __, 3
	note C#, 1
	note __, 7
	note D#, 4
	stereopanning $f
	note C_, 1
	note __, 3
	note C_, 1
	note __, 11
	note C_, 1
	note __, 3
	note C_, 1
	note __, 3
	stereopanning $ff
	octave 2
	note A#, 2
	octave 3
	note C_, 2
	note C#, 2
	note D#, 2
	stereopanning $f
	note C_, 1
	note __, 3
	note C_, 1
	note __, 11
	note C_, 1
	note __, 3
	note C_, 1
	note __, 11
	stereopanning $ff
	jumpchannel Music_TinTower_branch_f68fb

Music_TinTower_Ch4:
	togglenoise $0
	note_type 12
Music_TinTower_branch_f694c:
	stereopanning $f
	note G_, 2
	stereopanning $f0
	note G_, 1
	note G_, 1
	stereopanning $f
	note G_, 2
	stereopanning $f0
	note F_, 4
	stereopanning $f
	note G_, 2
	note G_, 2
	note F_, 2
	stereopanning $f0
	note G_, 2
	stereopanning $f
	note G_, 1
	note G_, 1
	stereopanning $f0
	note G_, 2
	stereopanning $f
	note F_, 4
	stereopanning $f0
	note G_, 2
	note G_, 2
	note F_, 2
	jumpchannel Music_TinTower_branch_f694c
