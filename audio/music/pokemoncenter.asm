Music_PokemonCenter:
	channel_count 4
	channel 1, Music_PokemonCenter_Ch1
	channel 2, Music_PokemonCenter_Ch2
	channel 3, Music_PokemonCenter_Ch3
	channel 4, Music_PokemonCenter_Ch4

Music_PokemonCenter_Ch1:
	tempo 152
	volume 7, 7
	duty_cycle 2
	vibrato $a, $14
	tone $0001
Music_PokemonCenter_branch_ed5df:
	stereopanning $f
	note_type 12, 8, 3
	octave 3
	note F#, 2
	note F_, 2
	note F#, 2
	octave 4
	note D_, 4
	note C#, 2
	octave 3
	note B_, 2
	note A_, 2
	note B_, 2
	note A_, 2
	note G_, 2
	note F#, 2
	note E_, 2
	note F#, 2
	note G_, 2
	note A_, 2
	note A_, 2
	note E_, 2
	note A_, 2
	octave 4
	note C#, 4
	octave 3
	note B_, 2
	note A_, 2
	note G_, 2
	note F#, 2
	note A_, 2
	note B_, 2
	octave 4
	note C#, 2
	note D_, 2
	note C#, 2
	octave 3
	note B_, 2
	note A_, 2
	note F#, 2
	note F_, 2
	note F#, 2
	octave 4
	note D_, 4
	note C#, 2
	octave 3
	note B_, 2
	note A_, 2
	note B_, 2
	note A_, 2
	note G_, 2
	note F#, 2
	note E_, 2
	note F#, 2
	note G_, 2
	note A_, 2
	note A_, 2
	note E_, 2
	note A_, 2
	octave 4
	note C#, 4
	octave 3
	note B_, 2
	note A_, 2
	note G_, 2
	note_type 12, 11, 4
	note F#, 2
	note E_, 2
	note D_, 2
	note E_, 2
	note F#, 2
	note G_, 2
	note A_, 2
	note B_, 2
	stereopanning $f0
	note F#, 2
	note E_, 2
	note D_, 4
	note E_, 2
	note F#, 2
	note G_, 2
	note A_, 2
	note B_, 2
	note A_, 2
	note G_, 4
	note E_, 2
	note F#, 2
	note G_, 2
	note A_, 2
	note G_, 2
	note F#, 2
	note E_, 4
	note C#, 2
	note D_, 2
	note E_, 2
	note G_, 2
	note F#, 2
	note G_, 2
	note A_, 2
	note B_, 2
	note A_, 8
	octave 4
	note D_, 2
	note C#, 2
	octave 3
	note B_, 4
	note A_, 2
	note B_, 2
	octave 4
	note C#, 2
	note D_, 2
	note E_, 2
	note D_, 2
	note C#, 4
	octave 3
	note B_, 2
	octave 4
	note C#, 2
	note D_, 2
	note E_, 2
	note C#, 2
	octave 3
	note B_, 2
	note A_, 4
	note G_, 2
	note A_, 2
	note B_, 2
	note G_, 2
	note A_, 2
	note G_, 2
	note F#, 2
	note E_, 2
	note D_, 2
	note E_, 2
	note F#, 2
	note G_, 2
	jumpchannel Music_PokemonCenter_branch_ed5df

Music_PokemonCenter_Ch2:
	vibrato $10, $25
Music_PokemonCenter_branch_ed674:
	stereopanning $ff
	callchannel Music_PokemonCenter_branch_ed6d1
	stereopanning $f
	note_type 12, 10, 5
	octave 3
	note A_, 4
	note E_, 4
	stereopanning $ff
	callchannel Music_PokemonCenter_branch_ed6e4
	note D_, 2
	note F#, 6
	stereopanning $f
	note_type 12, 10, 5
	octave 3
	note A_, 4
	note E_, 4
	stereopanning $ff
	callchannel Music_PokemonCenter_branch_ed6d1
	stereopanning $f
	note_type 12, 10, 5
	octave 3
	note A_, 4
	note E_, 4
	stereopanning $ff
	callchannel Music_PokemonCenter_branch_ed6e4
	note D_, 8
	stereopanning $f
	note_type 12, 10, 5
	octave 3
	note D_, 4
	note E_, 4
	note_type 12, 12, 6
	octave 4
	note F#, 8
	note A_, 8
	note G_, 2
	note A_, 2
	note G_, 2
	note F#, 2
	note E_, 8
	note C#, 8
	note E_, 8
	note F#, 2
	note G_, 2
	note F#, 2
	note E_, 2
	note D_, 8
	note F#, 8
	note A_, 8
	note G_, 2
	note F#, 2
	note G_, 2
	note A_, 2
	note B_, 8
	note A_, 4
	note G_, 2
	note F#, 2
	note G_, 8
	note F#, 2
	note G_, 2
	note F#, 2
	note E_, 2
	note D_, 8
	jumpchannel Music_PokemonCenter_branch_ed674

Music_PokemonCenter_branch_ed6d1:
	duty_cycle 2
	note_type 12, 12, 2
	octave 4
	note D_, 2
	octave 3
	note A_, 2
	octave 4
	note D_, 2
	volume_envelope 12, 3
	note A_, 4
	note G_, 4
	note F#, 2
	note E_, 2
	note C#, 6
	endchannel

Music_PokemonCenter_branch_ed6e4:
	note_type 12, 12, 2
	octave 4
	note C#, 2
	octave 3
	note A_, 2
	octave 4
	note C#, 2
	volume_envelope 12, 3
	note F#, 4
	note E_, 4
	note C#, 2
	endchannel

Music_PokemonCenter_Ch3:
	note_type 12, 2, 8
Music_PokemonCenter_branch_ed6f6:
	stereopanning $f0
	octave 3
	note D_, 1
	note __, 5
	note F#, 1
	note __, 3
	note F#, 1
	note __, 1
	note G_, 1
	note __, 1
	note F#, 1
	note __, 1
	callchannel Music_PokemonCenter_branch_ed76f
	callchannel Music_PokemonCenter_branch_ed778
	note F#, 1
	note __, 5
	note A_, 1
	note __, 3
	note A_, 1
	note __, 1
	note G_, 1
	note __, 1
	note A_, 1
	note __, 1
	note D_, 1
	note __, 5
	note F#, 1
	note __, 3
	note F#, 1
	note __, 1
	note G_, 1
	note __, 1
	note F#, 1
	note __, 1
	callchannel Music_PokemonCenter_branch_ed76f
	callchannel Music_PokemonCenter_branch_ed778
	note D_, 1
	note __, 5
	note F#, 1
	note __, 3
	note F#, 1
	note __, 1
	note D_, 1
	note __, 1
	note G_, 1
	note __, 1
	stereopanning $ff
	callchannel Music_PokemonCenter_branch_ed783
	note G_, 1
	note __, 5
	note B_, 1
	note __, 3
	note B_, 1
	note __, 1
	note G_, 1
	note __, 1
	note B_, 1
	note __, 1
	note E_, 1
	note __, 5
	note G_, 1
	note __, 3
	note G_, 1
	note __, 3
	note G_, 1
	note __, 1
	note F#, 1
	note __, 5
	note A_, 1
	note __, 3
	note A_, 1
	note __, 1
	note G#, 1
	note __, 1
	note A_, 1
	note __, 1
	callchannel Music_PokemonCenter_branch_ed783
	note G_, 1
	note __, 5
	note B_, 1
	note __, 3
	note B_, 1
	note __, 3
	note B_, 1
	note __, 1
	note E_, 1
	note __, 5
	note G_, 1
	note __, 3
	note G_, 1
	note __, 3
	note G_, 1
	note __, 1
	note F#, 1
	note __, 5
	note A_, 1
	note __, 3
	note A_, 1
	note __, 1
	note G_, 1
	note __, 1
	note E_, 1
	note __, 1
	jumpchannel Music_PokemonCenter_branch_ed6f6

Music_PokemonCenter_branch_ed76f:
	note E_, 1
	note __, 5
	note A_, 1
	note __, 3
	note A_, 1
	note __, 3
	note A_, 1
	note __, 1
	endchannel

Music_PokemonCenter_branch_ed778:
	note E_, 1
	note __, 5
	note A_, 1
	note __, 3
	note A_, 1
	note __, 1
	note G_, 1
	note __, 1
	note A_, 1
	note __, 1
	endchannel

Music_PokemonCenter_branch_ed783:
	note F#, 1
	note __, 5
	note A_, 1
	note __, 3
	note A_, 1
	note __, 3
	note A_, 1
	note __, 1
	endchannel

Music_PokemonCenter_Ch4:
	toggle_noise 3
	note_type 12
	stereopanning $ff
Music_PokemonCenter_branch_ed792:
	note G_, 6
	note G_, 4
	note G_, 2
	note G_, 2
	note G_, 2
	jumpchannel Music_PokemonCenter_branch_ed792
