Music_PokemonLullaby:
	channel_count 3
	channel 1, Music_PokemonLullaby_Ch1
	channel 2, Music_PokemonLullaby_Ch2
	channel 3, Music_PokemonLullaby_Ch3

Music_PokemonLullaby_Ch1:
	tempo 224
	volume 7, 7
	dutycycle $3
	tone $0001
Music_PokemonLullaby_branch_f6d8c:
	note_type 12, 10, 7
	octave 3
	note G_, 16
	octave 4
	note C_, 16
	stereopanning $f0
	octave 3
	note G_, 16
	stereopanning $f
	octave 4
	note C_, 8
	stereopanning $f0
	octave 3
	note B_, 8
	stereopanning $f
	note G_, 16
	stereopanning $f0
	octave 4
	note C_, 8
	stereopanning $f
	octave 3
	note B_, 8
	stereopanning $f0
	note G_, 8
	stereopanning $ff
	note __, 2
	note G_, 2
	note G_, 2
	note B_, 2
	octave 4
	note C_, 4
	octave 3
	note B_, 4
	octave 4
	note C_, 4
	octave 3
	note B_, 4
	note G_, 16
	octave 4
	note C_, 8
	octave 3
	note B_, 8
	jumpchannel Music_PokemonLullaby_branch_f6d8c

Music_PokemonLullaby_Ch2:
	vibrato $10, $14
	dutycycle $0
	note_type 12, 11, 4
Music_PokemonLullaby_branch_f6dcc:
	note __, 16
	note __, 10
	octave 4
	note G_, 2
	note F#, 2
	note G_, 2
	intensity $b7
	note E_, 12
	note D_, 2
	note E_, 2
	note F_, 4
	note G_, 4
	note F_, 2
	note E_, 2
	note D_, 2
	note F_, 2
	note E_, 10
	intensity $b5
	note D_, 2
	note D_, 2
	intensity $c7
	note E_, 2
	note F_, 4
	note E_, 4
	note F_, 4
	intensity $b5
	note G_, 2
	note G_, 2
	note D#, 2
	intensity $b7
	note E_, 14
	intensity $87
	octave 3
	note F_, 8
	note G_, 4
	intensity $b5
	octave 4
	note G_, 2
	note G_, 2
	intensity $b7
	note D#, 2
	note E_, 16
	note __, 14
	jumpchannel Music_PokemonLullaby_branch_f6dcc

Music_PokemonLullaby_Ch3:
	note_type 12, 1, 1
Music_PokemonLullaby_branch_f6e06:
	stereopanning $f0
	octave 4
	note C_, 2
	note E_, 2
	note G_, 2
	note B_, 2
	octave 5
	note C_, 2
	octave 4
	note B_, 2
	note A_, 2
	note G_, 2
	stereopanning $f
	note D_, 2
	note F_, 2
	note A_, 2
	octave 5
	note C_, 2
	note D_, 2
	note C_, 2
	octave 4
	note B_, 2
	note A_, 2
	jumpchannel Music_PokemonLullaby_branch_f6e06
