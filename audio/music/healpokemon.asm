Music_HealPokemon:
	channel_count 3
	channel 1, Music_HealPokemon_Ch1
	channel 2, Music_HealPokemon_Ch2
	channel 3, Music_HealPokemon_Ch3

Music_HealPokemon_Ch1:
	tempo 144
	volume 7, 7
	dutycycle $2
	tone $0001
	note_type 12, 8, 1
	note __, 2
	slidepitchto 1, 4, __
	note B_, 2
	slidepitchto 1, 5, E_
	note B_, 2
	slidepitchto 1, 4, E_
	note E_, 2
	note __, 4
	slidepitchto 1, 3, __
	note E_, 4
	slidepitchto 1, 4, __
	note B_, 4
	endchannel

Music_HealPokemon_Ch2:
	dutycycle $2
	note_type 12, 12, 3
	octave 4
	note B_, 4
	note B_, 4
	note B_, 2
	note G#, 2
	note_type 12, 12, 4
	octave 5
	note E_, 8
	endchannel

Music_HealPokemon_Ch3:
	note_type 12, 1, 0
	octave 4
	note E_, 2
	note __, 2
	note E_, 2
	note __, 2
	note E_, 2
	note G#, 2
	note E_, 6
	note __, 2
	endchannel
