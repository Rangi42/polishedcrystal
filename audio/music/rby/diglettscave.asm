; Pokémon R/B/Y - Diglett's Cave
; Ported by FroggestSpirit
; https://github.com/froggestspirit/CrystalComplete/blob/master/audio/music/RBY/dungeon2.asm

Music_DiglettsCaveRBY:
	channel_count 4
	channel 1, Music_DiglettsCaveRBY_Ch1
	channel 2, Music_DiglettsCaveRBY_Ch2
	channel 3, Music_DiglettsCaveRBY_Ch3
	channel 4, Music_DiglettsCaveRBY_Ch4

Music_DiglettsCaveRBY_Ch1:
	tempo 144
	volume 7, 7
	duty_cycle 3
	vibrato 10, 1, 4

Music_DiglettsCaveRBY_branch_7e892:
	note_type 12, 11, 2
	octave 4
	note E_, 4
	note E_, 4
	note E_, 4
	note E_, 4
	note A#, 4
	note A#, 4
	note A#, 4
	note A#, 4
	note E_, 4
	note E_, 4
	note E_, 4
	note E_, 4
	octave 5
	note C#, 4
	note C#, 4
	note C#, 4
	note C#, 4
	octave 3
	note E_, 4
	note E_, 4
	note E_, 4
	note E_, 4
	note A#, 4
	note A#, 4
	note A#, 4
	note A#, 4
	octave 2
	note G_, 2
	note A#, 4
	note G_, 2
	octave 3
	note C#, 4
	octave 2
	note G_, 2
	note A#, 2
	note B_, 2
	note G_, 2
	octave 3
	note C#, 4
	octave 2
	note G_, 2
	note A_, 4
	note F#, 2
	sound_loop 2, Music_DiglettsCaveRBY_branch_7e892
	note_type 12, 1, -7
	octave 3
	note E_, 16
	note C_, 16
	note D_, 16
	octave 2
	note A#, 16
	rest 16
	rest 16
	rest 16
	rest 16
	rest 16
	rest 16
	rest 16
	rest 16
	sound_jump Music_DiglettsCaveRBY_branch_7e892

Music_DiglettsCaveRBY_Ch2:
	vibrato 11, 1, 5

Music_DiglettsCaveRBY_branch_7e8db:
	duty_cycle 3
	note_type 12, 12, 2
	octave 3
	note E_, 4
	note E_, 4
	note E_, 4
	note E_, 4
	note C_, 4
	note C_, 4
	note C_, 4
	note C_, 4
	note E_, 4
	note E_, 4
	note E_, 4
	note E_, 4
	note C_, 4
	note C_, 4
	note C_, 4
	note C_, 4
	note B_, 4
	note B_, 4
	note B_, 4
	note B_, 4
	octave 4
	note F#, 4
	note F#, 4
	note F#, 4
	note F#, 4
	note D_, 4
	note D_, 4
	note D_, 4
	note D_, 4
	note G_, 4
	note G_, 4
	note G_, 4
	note F#, 4
	sound_loop 2, Music_DiglettsCaveRBY_branch_7e8db
	octave 3
	note E_, 2
	note G_, 2
	note E_, 2
	note D#, 2
	note E_, 2
	note E_, 2
	octave 5
	note E_, 2
	rest 2
	note D#, 2
	rest 2
	note D_, 2
	rest 2
	note C#, 2
	note C_, 2
	octave 4
	note E_, 2
	note G_, 2
	octave 3
	note A#, 2
	note C#, 2
	note A#, 2
	note A_, 2
	note A#, 2
	note G_, 2
	octave 5
	note G_, 2
	rest 2
	note F#, 2
	rest 2
	note F_, 2
	rest 2
	note E_, 2
	note D#, 2
	note D_, 2
	note C#, 2
	rest 16
	rest 16
	rest 16
	rest 16
	note_type 12, 12, 7
	duty_cycle 1
	octave 4
	note E_, 16
	note D_, 16
	note C_, 16
	note D_, 16
	sound_jump Music_DiglettsCaveRBY_branch_7e8db

Music_DiglettsCaveRBY_Ch3:
	note_type 12, 1, 3
	vibrato 8, 2, 6

Music_DiglettsCaveRBY_branch_7e940:
	sound_call Music_DiglettsCaveRBY_branch_7e9d1
	sound_loop 16, Music_DiglettsCaveRBY_branch_7e940
	note E_, 4
	rest 4
	rest 4
	note E_, 4
	note C_, 4
	rest 4
	rest 4
	note C_, 4
	note D_, 4
	rest 4
	rest 4
	note D_, 4
	octave 3
	note A#, 4
	rest 4
	rest 4
	note A#, 4

Music_DiglettsCaveRBY_branch_7e958:
	octave 5
	note E_, 2
	rest 2
	note B_, 2
	rest 2
	note A#, 2
	rest 2
	octave 6
	note D_, 2
	rest 2
	note C#, 2
	rest 2
	octave 5
	note G#, 2
	rest 2
	note G_, 2
	rest 2
	note B_, 2
	rest 2
	note A#, 2
	rest 2
	note E_, 2
	rest 2
	note D#, 2
	rest 2
	note A_, 2
	rest 2
	note G#, 2
	rest 2
	note E_, 2
	rest 2
	note F#, 2
	rest 2
	note D#, 2
	rest 2
	sound_loop 3, Music_DiglettsCaveRBY_branch_7e958
	octave 4
	note E_, 4
	note B_, 4
	note A#, 4
	octave 5
	note D_, 4
	note C#, 4
	octave 4
	note G#, 4
	note G_, 4
	note B_, 4
	note A#, 4
	note E_, 4
	note D#, 4
	note A_, 4
	note G#, 4
	note E_, 4
	note F#, 4
	note D#, 4
	octave 3
	note E_, 16
	note C_, 16
	note D_, 16
	octave 2
	note A#, 16
	octave 3
	note E_, 16
	note F_, 16
	note G_, 16
	octave 3
	note B_, 16
	rest 16
	rest 16
	rest 16
	rest 16
	sound_call Music_DiglettsCaveRBY_branch_7e9d1
	sound_call Music_DiglettsCaveRBY_branch_7e9d1
	sound_call Music_DiglettsCaveRBY_branch_7e9d1
	sound_call Music_DiglettsCaveRBY_branch_7e9d1
	sound_call Music_DiglettsCaveRBY_branch_7e9d1
	sound_call Music_DiglettsCaveRBY_branch_7e9d1
	sound_call Music_DiglettsCaveRBY_branch_7e9d1
	sound_call Music_DiglettsCaveRBY_branch_7e9d1
	sound_jump Music_DiglettsCaveRBY_branch_7e940
	octave 2
	note G_, 2
	note A#, 4
	note G_, 2
	octave 3
	note C#, 4
	octave 2
	note G_, 2
	note A_, 2
	note A#, 2
	note G_, 2
	octave 3
	note C#, 4
	octave 2
	note G_, 2
	note A#, 2
	note G_, 2
	rest 2
	sound_ret

Music_DiglettsCaveRBY_branch_7e9d1:
	octave 4
	note E_, 2
	rest 4
	octave 3
	note E_, 1
	rest 3
	note E_, 1
	rest 1
	octave 4
	note F#, 4
	sound_ret

Music_DiglettsCaveRBY_Ch4:
	drum_speed 12
	toggle_noise 1

Music_DiglettsCaveRBY_branch_7e9dd:
	drum_note 5, 4
	drum_note 6, 4
	drum_note 5, 4
	drum_note 3, 4
	drum_note 5, 4
	drum_note 6, 4
	drum_note 4, 4
	drum_note 2, 4
	sound_jump Music_DiglettsCaveRBY_branch_7e9dd
