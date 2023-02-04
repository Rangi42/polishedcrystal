Music_PokemonMarch:
	channel_count 4
	channel 1, Music_PokemonMarch_Ch1
	channel 2, Music_PokemonMarch_Ch2
	channel 3, Music_PokemonMarch_Ch3
	channel 4, Music_PokemonMarch_Ch4

Music_PokemonMarch_Ch1:
	tempo 144
	volume 7, 7
	stereo_panning TRUE, FALSE
	duty_cycle 3
	pitch_offset 1
	note_type 12, 4, 2
	octave 3
	note D_, 4
	volume_envelope 6, 2
	note D_, 4
	volume_envelope 8, 2
	note D_, 4
	volume_envelope 10, 2
	note D_, 4
	note_type 8, 10, 2
Music_PokemonMarch_branch_f6e4c:
	sound_call Music_PokemonMarch_branch_f6eae
	note D#, 2
	note C_, 2
	note D#, 2
	note C_, 2
	sound_call Music_PokemonMarch_branch_f6eae
	note D#, 2
	note C_, 2
	note D#, 2
	note G_, 2
	sound_call Music_PokemonMarch_branch_f6eae
	note C_, 2
	note C_, 2
	note D#, 2
	note C_, 2
	sound_call Music_PokemonMarch_branch_f6eae
	note D#, 2
	note C_, 2
	note C#, 2
	note D#, 2
	sound_call Music_PokemonMarch_branch_f6eb8
	note F_, 2
	note D_, 2
	note F_, 2
	note D_, 2
	sound_call Music_PokemonMarch_branch_f6eb8
	note F_, 2
	note D_, 2
	note F_, 2
	note A_, 2
	sound_call Music_PokemonMarch_branch_f6eb8
	note D_, 2
	note D_, 2
	note F_, 2
	note D_, 2
	sound_call Music_PokemonMarch_branch_f6eb8
	note F_, 2
	note D_, 2
	note F_, 2
	note G_, 2
	sound_call Music_PokemonMarch_branch_f6eb8
	note F_, 2
	note D_, 2
	note F_, 2
	note D_, 2
	sound_call Music_PokemonMarch_branch_f6eae
	note D#, 2
	note C_, 2
	note D#, 2
	note C_, 2
	octave 2
	note A#, 2
	note A#, 2
	octave 3
	note C_, 2
	note D_, 2
	note C#, 2
	note C_, 2
	octave 2
	note A#, 2
	note __, 4
	note D#, 2
	note __, 4
	octave 3
	note D#, 2
	note D#, 2
	note F_, 2
	note G_, 2
	note F#, 2
	note F_, 2
	note D#, 4
	note F_, 2
	note G_, 4
	note A#, 2
	sound_jump Music_PokemonMarch_branch_f6e4c

Music_PokemonMarch_branch_f6eae:
	note __, 4
	octave 3
	note D#, 1
	note D_, 1
	note D#, 2
	note __, 2
	note D#, 2
	note D#, 2
	note __, 2
	sound_ret

Music_PokemonMarch_branch_f6eb8:
	note __, 4
	note F_, 1
	note E_, 1
	note F_, 2
	note __, 2
	note F_, 2
	note F_, 2
	note __, 2
	sound_ret

Music_PokemonMarch_Ch2:
	duty_cycle 2
	vibrato 16, 2, 2
	note_type 12, 11, 2
	octave 3
	note G_, 4
	note G_, 4
	note G_, 4
	note G_, 4
Music_PokemonMarch_branch_f6ece:
	note_type 12, 11, 7
	octave 3
	note G#, 12
	note_type 8, 11, 3
	note D#, 2
	note G#, 2
	note A#, 2
	octave 4
	note C_, 2
	note __, 16
	note __, 6
	note_type 8, 11, 7
	octave 3
	note G#, 16
	note_type 8, 11, 3
	note D#, 2
	note G#, 4
	note A#, 2
	octave 4
	note C_, 4
	note C#, 2
	note C_, 4
	note C#, 2
	note C_, 4
	note C#, 2
	note C_, 2
	octave 3
	note A#, 2
	note G#, 2
	note_type 8, 11, 7
	note A#, 16
	note_type 8, 11, 3
	note A#, 2
	note F_, 2
	note A#, 2
	octave 4
	note C_, 2
	note D_, 2
	note __, 16
	note __, 6
	note_type 8, 11, 7
	octave 3
	note A#, 16
	note_type 8, 11, 3
	note F_, 2
	note A#, 4
	octave 4
	note C_, 2
	note D_, 4
	note D#, 2
	note D_, 4
	note D#, 2
	note D_, 4
	note D#, 2
	note D_, 2
	note C_, 2
	octave 3
	note B_, 2
	note_type 8, 11, 7
	note A#, 16
	note_type 8, 11, 3
	note A_, 2
	note A#, 4
	octave 4
	note C_, 2
	note_type 8, 11, 7
	octave 3
	note G#, 16
	note_type 8, 11, 3
	note A#, 2
	note G#, 4
	note F_, 2
	note D#, 2
	note D#, 2
	note F_, 2
	note G_, 2
	note F#, 2
	note F_, 2
	note D#, 2
	note __, 2
	octave 4
	note D#, 1
	note D_, 1
	note D#, 1
	note __, 5
	octave 3
	note G_, 2
	note G_, 2
	note G#, 2
	note A#, 2
	note A_, 2
	note G#, 2
	note G_, 2
	note __, 2
	octave 4
	note G_, 1
	note F#, 1
	note G_, 1
	note __, 5
	sound_jump Music_PokemonMarch_branch_f6ece

Music_PokemonMarch_Ch3:
	stereo_panning FALSE, TRUE
	note_type 12, 1, 6
	note __, 16
	note_type 8, 1, 6
Music_PokemonMarch_branch_f6f56:
	sound_call Music_PokemonMarch_branch_f6fe8
	note __, 2
	octave 4
	note D#, 2
	sound_call Music_PokemonMarch_branch_f6fe8
	octave 4
	note G#, 2
	note D#, 2
	sound_call Music_PokemonMarch_branch_f6fe8
	note __, 2
	octave 4
	note D#, 2
	octave 3
	note G#, 2
	note __, 2
	octave 4
	note D#, 2
	octave 3
	note D#, 2
	note __, 2
	octave 4
	note D#, 2
	octave 3
	note G#, 2
	note __, 2
	octave 4
	note D#, 2
	octave 3
	note D#, 2
	note G_, 2
	note G#, 2
Music_PokemonMarch_branch_f6f7b:
	octave 3
	note A#, 2
	note __, 2
	octave 4
	note F_, 2
	octave 3
	note F_, 2
	note __, 2
	octave 4
	note F_, 2
	octave 3
	note G_, 2
	note __, 2
	octave 4
	note F_, 2
	octave 3
	note A_, 2
	note __, 1
	octave 4
	note F_, 2
	note __, 1
	sound_loop 3, Music_PokemonMarch_branch_f6f7b
	octave 3
	note A#, 2
	note __, 2
	octave 4
	note F_, 2
	octave 3
	note F_, 2
	note __, 2
	octave 4
	note F_, 2
	octave 3
	note A#, 2
	note __, 2
	octave 4
	note F_, 2
	note D_, 2
	note C_, 2
	octave 3
	note B_, 2
	note A#, 2
	note __, 2
	octave 4
	note F_, 2
	octave 3
	note F_, 2
	note __, 2
	octave 4
	note F_, 2
	octave 3
	note G_, 2
	note __, 2
	octave 4
	note F_, 2
	octave 3
	note F_, 2
	note G_, 2
	note A#, 2
	note G#, 2
	note __, 2
	octave 4
	note D#, 2
	octave 3
	note D#, 2
	note __, 2
	octave 4
	note D#, 2
	octave 3
	note F_, 2
	note __, 2
	octave 4
	note D#, 2
	octave 3
	note G#, 2
	note __, 2
	octave 4
	note C_, 2
	note D#, 2
	note D#, 2
	note F_, 2
	note G_, 2
	note F#, 2
	note F_, 2
	note D#, 2
	note __, 4
	octave 3
	note D#, 2
	note __, 4
	octave 4
	note G_, 2
	note G_, 2
	note G#, 2
	note A#, 2
	note A_, 2
	note G#, 2
	note G_, 2
	note __, 2
	note D#, 2
	note F_, 2
	note __, 2
	note G#, 2
	sound_jump Music_PokemonMarch_branch_f6f56

Music_PokemonMarch_branch_f6fe8:
	octave 3
	note G#, 2
	note __, 2
	octave 4
	note D#, 2
	octave 3
	note D#, 2
	note __, 2
	octave 4
	note D#, 2
	octave 3
	note F_, 2
	note __, 2
	octave 4
	note D#, 2
	octave 3
	note G_, 2
	sound_ret

Music_PokemonMarch_Ch4:
	stereo_panning TRUE, FALSE
	toggle_noise 5
	note_type 8
	sound_call Music_PokemonMarch_branch_f704c
Music_PokemonMarch_branch_f7003:
	sound_call Music_PokemonMarch_branch_f7042
	note C_, 4
	note C_, 2
	note C_, 4
	note C_, 2
	note C_, 4
	note C_, 5
	note_type 6
	note D_, 1
	note D_, 1
	note C#, 1
	note C#, 1
	note_type 8
	sound_call Music_PokemonMarch_branch_f7042
	sound_call Music_PokemonMarch_branch_f704c
	sound_call Music_PokemonMarch_branch_f7042
	sound_call Music_PokemonMarch_branch_f704c
	sound_call Music_PokemonMarch_branch_f7042
	sound_call Music_PokemonMarch_branch_f704c
	sound_call Music_PokemonMarch_branch_f7042
	sound_call Music_PokemonMarch_branch_f704c
	note C#, 4
	note C#, 2
	note C#, 4
	note C#, 2
	note C#, 6
	note C_, 2
	note_type 4
	note __, 5
	note_type 6
	note D_, 1
	note D_, 1
	note_type 8
	sound_call Music_PokemonMarch_branch_f704c
	sound_jump Music_PokemonMarch_branch_f7003

Music_PokemonMarch_branch_f7042:
	note C_, 4
	note C_, 2
	note C_, 4
	note C_, 2
	note C_, 4
	note D_, 2
	note D_, 2
	note C#, 2
	note C#, 2
	sound_ret

Music_PokemonMarch_branch_f704c:
	note C_, 4
	note C_, 2
	note C_, 4
	note C_, 4
	note C_, 4
	note C#, 2
	note D_, 2
	note C#, 2
	sound_ret
