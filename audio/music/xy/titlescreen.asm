; Pokémon X/Y - Title Screen
; Demixed by ShantyTown
; https://github.com/huderlem/pokestyle-music-devamps/blob/master/music/kalos_titlescreen.asm

Music_TitleScreenXY:
	channel_count 4
	channel 1, Music_TitleScreenXY_Ch1
	channel 2, Music_TitleScreenXY_Ch2
	channel 3, Music_TitleScreenXY_Ch3
	channel 4, Music_TitleScreenXY_Ch4

Music_TitleScreenXY_Ch1:
	tempo 125
	volume 7, 7
	stereo_panning FALSE, TRUE
	vibrato 16, 3, 3
	pitch_sweep 0, 0
Music_TitleScreenXY_Ch1_b0:
	duty_cycle 0
	note_type 8, 8, 7
Music_TitleScreenXY_Ch1_b1:
	octave 3
	note G#, 2
	octave 4
	note C#, 2
	note D#, 2
	note G#, 2
	note D#, 2
	note C#, 2
	sound_loop 8, Music_TitleScreenXY_Ch1_b1
	note_type 8, 9, 7
Music_TitleScreenXY_Ch1_b2:
	octave 3
	note B_, 2
	octave 4
	note E_, 2
	note F#, 2
	note B_, 2
	note F#, 2
	note E_, 2
	sound_loop 4, Music_TitleScreenXY_Ch1_b2
	note_type 8, 11, 7
Music_TitleScreenXY_Ch1_b3:
	octave 4
	note D_, 2
	note G_, 2
	note A_, 2
	octave 5
	note D_, 2
	octave 4
	note A_, 2
	note G_, 2
	sound_loop 2, Music_TitleScreenXY_Ch1_b3
	note_type 8, 11, 2
	octave 3
	note G#, 6
	note G#, 6
	note G#, 2
	note G#, 2
	note G#, 2
	note G#, 6
	note G#, 6
	note G#, 6
	octave 2
	note F#, 2
	note A#, 2
	octave 3
	note C#, 2
	octave 2
	note G#, 2
	octave 3
	note C_, 2
	note D#, 2
	note_type 8, 11, 7
	sound_call Music_TitleScreenXY_Ch1_b5
	octave 4
	note F#, 8 ; measure 11.3
	note F_, 2
	note E_, 2
	note_type 12, 11, 7
	note D#, 16
	note_type 8, 11, 7
	octave 2
	note D#, 2
	rest 2
	note D#, 2
	octave 1
	note B_, 4
	rest 2
	octave 2
	note C#, 4
	rest 2
	note D_, 4
	rest 2
	octave 3
	note G#, 9
	octave 4
	note C_, 3
	note D#, 9
	volume_envelope 6, -4
	octave 2
	note G#, 1
	octave 3
	note C_, 1
	note D#, 1
	note G#, 1
	octave 4
	note C_, 1
	note D#, 1
	note G#, 1
	octave 5
	note C_, 1
	note D#, 1
	note G#, 1
	note D#, 1
	note C_, 1
	octave 4
	note G#, 1
	note D#, 1
	note C_, 1
	note_type 8, 11, 7
	note F#, 8
	note F_, 2
	note E_, 2
	note_type 12, 11, 7
	note D#, 16
	note_type 8, 11, 7
	octave 2
	note D#, 2
	rest 2
	note D#, 2
	octave 1
	note B_, 4
	rest 2
	octave 2
	note C#, 4
	rest 2
	note D_, 4
	rest 2
	sound_call Music_TitleScreenXY_Ch1_b5
	note F#, 8
	note F_, 2
	note E_, 2
	note_type 12, 11, 7
	note D#, 16
	note_type 8, 11, 7
	octave 1
	note B_, 2
	rest 2
	note B_, 2
	octave 2
	note C#, 4
	rest 2
	octave 1
	note B_, 4
	rest 2
	octave 2
	note D_, 4
	rest 2
	sound_call Music_TitleScreenXY_Ch1_b5
	octave 4
	note_type 8, 11, 7
	note F#, 8
	note F_, 2
	note F#, 2
	note G#, 9
	note B_, 3
	note_type 12, 11, 7
	note G#, 16
	rest 8
	rest 16
	duty_cycle 2
	octave 3
	note D#, 8
	octave 2
	note B_, 4
	octave 3
	note C_, 4
	note F_, 16
	note F_, 8
	duty_cycle 0
	octave 2
	note G#, 4
	note A_, 4
	note D#, 2
	rest 2
	note_type 8, 11, 7
	note D#, 1
	rest 1
	note G_, 1
	rest 1
	note A#, 1
	rest 1
	note_type 12, 11, 7
	octave 3
	note D#, 16
	note G#, 4
	note_type 8, 11, 7
	note F_, 1
	rest 1
	note F_, 1
	rest 1
	note E_, 1
	rest 1
	note_type 12, 11, 7
	note D#, 16
	note_type 8, 11, 7
	octave 2
	note A#, 1
	rest 1
	note F_, 1
	rest 1
	note G_, 1
	rest 1
	note F_, 1
	rest 1
	note G_, 1
	rest 1
	octave 1
	note A#, 1
	rest 1
	octave 2
	note C#, 6
	note C_, 6
	note_type 8, 11, 1
	octave 3
	note D#, 6
	note D#, 6
	note D#, 2
	note D#, 2
	note D#, 2
	note D#, 6
	note D#, 6
	note D#, 6
	note C#, 2
	note C#, 2
	note C#, 2
	note C#, 2
	note C#, 2
	note D_, 2
	note D#, 6
	note D#, 2
	note D#, 2
	note D#, 2
	note D#, 12
	rest 16
	rest 16
	sound_jump Music_TitleScreenXY_Ch1_b0

Music_TitleScreenXY_Ch1_b5:
	octave 3
	note G#, 9
	octave 4
	note C_, 3
	note D#, 6
	volume_envelope 7, 0
	octave 5
	note D#, 1
	note C_, 1
	octave 4
	note G#, 1
	note D#, 1
	note C_, 1
	octave 3
	note G#, 1
	note F#, 1
	note C#, 1
	octave 2
	note A#, 1
	note F#, 1
	note A#, 1
	octave 3
	note C#, 1
	note F#, 1
	note A#, 1
	octave 4
	note C#, 1
	note F#, 1
	note A#, 1
	octave 5
	note C#, 1
	sound_ret

Music_TitleScreenXY_Ch2:
	vibrato 16, 3, 3
	stereo_panning TRUE, FALSE
	duty_cycle 1
Music_TitleScreenXY_Ch2_b0:
	note_type 8, 9, 7
Music_TitleScreenXY_Ch2_b1:
	octave 2
	note G#, 2
	octave 3
	note C#, 2
	note D#, 2
	note G#, 2
	note D#, 2
	note C#, 2
	sound_loop 8, Music_TitleScreenXY_Ch2_b1
	note_type 8, 10, 7
Music_TitleScreenXY_Ch2_b2:
	octave 2
	note B_, 2
	octave 3
	note E_, 2
	note F#, 2
	note B_, 2
	note F#, 2
	note E_, 2
	sound_loop 4, Music_TitleScreenXY_Ch2_b2
	note_type 8, 12, 7
Music_TitleScreenXY_Ch2_b3:
	octave 3
	note D_, 2
	note G_, 2
	note A_, 2
	octave 4
	note D_, 2
	octave 3
	note A_, 2
	note G_, 2
	sound_loop 2, Music_TitleScreenXY_Ch2_b3
	octave 2
	note G#, 2
	rest 4
	note G#, 2
	rest 4
	note G#, 1
	rest 1
	note G#, 1
	rest 1
	note G#, 1
	rest 1
	note G#, 2
	rest 4
	note G#, 2
	rest 4
	note G#, 2
	rest 4
	octave 3
	note F#, 1
	rest 1
	note F#, 1
	rest 1
	note F#, 1
	rest 1
	note F#, 1
	rest 1
	note F#, 1
	rest 1
	note G_, 1
	rest 1
	note_type 12, 12, 7 ; measure 10
	octave 2
	note G#, 6
	octave 3
	note C_, 2
	note D#, 16
	note_type 8, 12, 7 ; measure 11.3
	note F#, 8
	note F_, 2
	note E_, 2
	note_type 12, 12, 7 ; measure 12
	note D#, 16
	note_type 8, 12, 7 ; measure 13
	octave 2
	note G#, 2
	rest 2
	note G#, 2
	note E_, 4
	rest 2
	note F#, 4
	rest 2
	note G_, 4
	rest 2
	note_type 12, 12, 7 ; measure 14
	note G#, 6
	octave 3
	note C_, 2
	note D#, 16
	note_type 8, 12, 7 ; measure 15
	note C#, 8
	octave 2
	note A#, 2
	octave 3
	note C#, 2
	note_type 12, 12, 7 ; measure 16
	note D#, 16
	note_type 8, 12, 7 ; measure 17
	octave 2
	note G#, 2
	rest 2
	note G#, 2
	note E_, 4
	rest 2
	note F#, 4
	rest 2
	note G_, 4
	rest 2
	note_type 12, 12, 7 ; measure 18
	octave 2
	note G#, 6
	octave 3
	note C_, 2
	note D#, 16
	note_type 8, 12, 7 ; measure 19.3
	note F#, 8
	note F_, 2
	note E_, 2
	note_type 12, 12, 7 ; measure 20
	note D#, 16
	note_type 8, 12, 7 ; measure 21
	octave 2
	note E_, 2
	rest 2
	note E_, 2
	note F#, 4
	rest 2
	note E_, 4
	rest 2
	note G_, 4
	rest 2
	note_type 12, 12, 7 ; measure 22
	octave 2
	note G#, 6
	octave 3
	note C_, 2
	note D#, 16
	note_type 8, 12, 7 ; measure 23.3
	note F#, 8
	note F_, 2
	note F#, 2
	note G#, 9
	note B_, 3
	note_type 12, 12, 7 ; measure 24.3
	note G#, 16
	duty_cycle 2
	note_type 12, 3, -4
	note A#, 8
	note_type 12, 12, 7
	note B_, 6
	note F#, 1
	rest 1
	note F#, 16
	note B_, 4
	octave 4
	note C_, 4
	note C#, 6
	octave 3
	note G#, 1
	rest 1
	note G#, 16
	octave 4
	note C#, 4
	note D_, 4
	duty_cycle 1
	note D#, 2
	rest 2
	note_type 8, 12, 7 ; measure 30.2
	octave 4
	note D#, 1
	rest 1
	note D#, 1
	rest 1
	note G_, 1
	rest 1
	note_type 12, 12, 7 ; measure 31
	note A#, 16
	note_type 8, 12, 7 ; measure 31.3
	octave 5
	note C#,  7
	rest 1
	note C_, 1
	rest 1
	octave 4
	note B_, 1
	rest 1
	note_type 12, 12, 7 ; measure 32
	note A#, 16
	note_type 8, 12, 7 ; measure 33
	octave 4
	note A#, 1
	rest 1
	note F_, 1
	rest 1
	note G_, 1
	rest 1
	note F_, 1
	rest 1
	note G_, 1
	rest 1
	octave 3
	note A#, 1
	rest 1
	octave 4
	note C#, 6
	note C_, 6
	note G#, 2
	rest 4
	note G#, 2
	rest 4
	note G#, 1
	rest 1
	note G#, 1
	rest 1
	note G#, 1
	rest 1
	note G#, 2
	rest 4
	note G#, 2
	rest 4
	note G#, 2
	rest 4
Music_TitleScreenXY_Ch2_b4:
	note F#, 1
	rest 1
	sound_loop 5, Music_TitleScreenXY_Ch2_b4
	note G_, 1
	rest 1
	note G#, 2
	rest 4
	note G#, 1
	rest 1
	note G#, 1
	rest 1
	note G#, 1
	rest 1
	note G#, 2
	rest 10
	rest 16
	rest 16
	sound_jump Music_TitleScreenXY_Ch2_b0

Music_TitleScreenXY_Ch3:
	stereo_panning TRUE, TRUE
Music_TitleScreenXY_Ch3_b0:
	note_type 8, 1, 2
	rest 12
	octave 3
	note G#, 1
	rest 3
	octave 4
	note C#, 2
	note_type 12, 1, 2
	note D#, 12
	note_type 8, 1, 2
	note F#, 8
	note F_, 2
	note E_, 2
	note_type 12, 1, 2
	note D#, 16
	rest 16
	rest 4
	note_type 8, 1, 2
	octave 3
	note A_, 1
	rest 3
	octave 4
	note C#, 2
	note_type 12, 1, 2
	note E_, 16
	rest 8
	note D_, 16
	note_type 8, 1, 2 ; measure 8
	octave 3
	note G#, 2
	rest 4
	octave 2
	note G#, 2
	rest 4
	note G#, 1
	rest 1
	octave 3
	note C#, 1
	rest 1
	note D#, 1
	rest 1
	octave 2
	note G#, 1
	rest 1
	octave 3
	note D#, 1
	rest 1
	note C#, 1
	rest 1
	octave 2
	note G#, 1
	rest 5
	octave 3
	note G#, 2
	rest 4
	octave 2
	note F#, 1
	rest 1
	note A#, 1
	rest 1
	octave 3
	note C#, 1
	rest 1
	octave 2
	note G#, 1
	rest 1
	octave 3
	note C_, 1
	rest 1
	note G_, 1
	rest 1
Music_TitleScreenXY_Ch3_b1:
	sound_call Music_TitleScreenXY_Ch3_b2
	sound_call Music_TitleScreenXY_Ch3_b3
	sound_call Music_TitleScreenXY_Ch3_b2
	octave 2
	note G#, 2
	rest 4
	note D#, 4
	rest 2
	note F#, 4
	rest 2
	note A#, 4
	rest 2
	sound_loop 2, Music_TitleScreenXY_Ch3_b1
	sound_call Music_TitleScreenXY_Ch3_b2
	sound_call Music_TitleScreenXY_Ch3_b3
	octave 2
	note E_, 2
	note G#, 2
	note B_, 2
	octave 3
	note E_, 2
	note G#, 2
	note B_, 2
	octave 4
	note E_, 2
	octave 3
	note B_, 2
	note G#, 2
	note E_, 2
	octave 2
	note B_, 2
	note G#, 2
	note E_, 2
	rest 4
	note F#, 4
	rest 2
	note E_, 4
	rest 2
	note A_, 4
	rest 2
	sound_call Music_TitleScreenXY_Ch3_b2
	sound_call Music_TitleScreenXY_Ch3_b3
	sound_call Music_TitleScreenXY_Ch3_b2
	octave 2
	note A#, 2
	octave 3
	note C_, 2
	note D#, 2
	note G#, 2
	note D#, 2
	note C_, 2
	octave 2
	note F#, 2
	note A#, 2
	octave 3
	note C#, 2
	note F#, 2
	note C#, 2
	octave 2
	note A#, 2
	note_type 12, 1, 2 ; measure 26
	octave 2
	note B_, 2
	octave 3
	note D#, 2
	note F#, 2
	note B_, 2
	octave 4
	note D#, 2
	octave 3
	note B_, 2
	note F#, 2
	note D#, 2
	octave 2
	note B_, 2
	octave 3
	note D#, 2
	note F#, 2
	note B_, 2
	octave 2
	note B_, 2
	octave 3
	note D#, 2
	note G#, 2
	octave 4
	note C_, 2
	octave 3
	note C#, 2
	note F_, 2
	note G#, 2
	octave 4
	note C#, 2
	note F_, 2
	note C#, 2
	octave 3
	note G#, 2
	note F_, 2
	note C#, 2
	note F_, 2
	note G#, 2
	octave 4
	note C#, 2
	octave 3
	note C#, 2
	note F_, 2
	note A#, 2
	octave 4
	note D_, 2
	octave 3
	note_type 12, 1, 4
	note D#, 2
	rest 2
	octave 2
	note A#, 2
	rest 2
	octave 3
	note D#, 2
	rest 2
	octave 2
	note A#, 2
	rest 2
	octave 3
	note C#, 2
	rest 2
	octave 2
	note G#, 2
	rest 2
	octave 3
	note C#, 2
	rest 2
	octave 2
	note G#, 2
	rest 2
	octave 3
	note D#, 2
	rest 2
	octave 2
	note A#, 2
	rest 2
	octave 3
	note D#, 2
	rest 2
	octave 2
	note A#, 2
	rest 2
	octave 3
	note D#, 2
	rest 2
	octave 2
	note A#, 2
	rest 2
	octave 3
	note D#, 2
	rest 2
	octave 2
	note A#, 2
	rest 2
	note_type 8, 1, 2 ; measure 34
	octave 3
	note G#, 2
	rest 4
	octave 2
	note G#, 2
	rest 4
	note G#, 1
	rest 1
	octave 3
	note C#, 1
	rest 1
	note D#, 1
	rest 1
	note G#, 1
	rest 1
	octave 4
	note C#, 1
	rest 1
	note D#, 1
	rest 1
	octave 2
	note G#, 2
	rest 1
	octave 3
	note D#, 2
	rest 1
	note G#, 3
	rest 3
	note F#, 1
	rest 1
	note F#, 1
	rest 1
	note F#, 1
	rest 1
	note F#, 1
	rest 1
	note F#, 1
	rest 1
	note G_, 1
	rest 1
	note G#, 2
	rest 4
	note G#, 1
	rest 1
	note D#, 1
	rest 1
	note C_, 1
	rest 1
	octave 2
	note G#, 2
	rest 10
	rest 16
	rest 16
	sound_jump Music_TitleScreenXY_Ch3_b0

Music_TitleScreenXY_Ch3_b2:
	octave 2
	note G#, 2
	octave 3
	note C_, 2
	note D#, 2
	note G#, 2
	octave 4
	note C_, 2
	note D#, 2
	note G#, 2
	note D#, 2
	note C_, 2
	octave 3
	note G#, 2
	note D#, 2
	note C_, 2
	sound_ret

Music_TitleScreenXY_Ch3_b3:
	octave 2
	note F#, 2
	note A#, 2
	octave 3
	note C#, 2
	note F#, 2
	note A#, 2
	octave 4
	note C#, 2
	note F#, 2
	note C#, 2
	octave 3
	note A#, 2
	note F#, 2
	note C#, 2
	octave 2
	note A#, 2
	sound_ret

Music_TitleScreenXY_Ch4:
	toggle_noise 3
Music_TitleScreenXY_Ch4_b0:
	drum_speed 12
	rest 16
	rest 12
	drum_speed 4
	drum_note 3, 2
	drum_note 3, 2
	drum_note 3, 4
	drum_note 3, 4
	drum_speed 12
	drum_note 12, 16
	rest 16
	rest 16
	rest 16
	rest 12
	drum_speed 4
	drum_note 3, 2
	drum_note 3, 2
	drum_note 3, 2
	drum_note 3, 2
	drum_note 3, 2
	drum_note 3, 2
	drum_note 3, 12
	drum_note 3, 12
	drum_note 3, 2
	drum_note 3, 2
	drum_note 3, 4
	drum_note 3, 4
	drum_note 3, 12
	drum_note 3, 12
	drum_note 3, 12
	drum_note 3, 2
	drum_note 3, 2
	drum_note 3, 4
	drum_note 3, 4
	drum_note 3, 4
	drum_note 3, 4
	drum_note 3, 4
Music_TitleScreenXY_Ch4_b1:
	sound_call Music_TitleScreenXY_Ch4_b2
	sound_call Music_TitleScreenXY_Ch4_b2
	sound_call Music_TitleScreenXY_Ch4_b2
	drum_note 3, 8
	drum_note 3, 12
	drum_note 3, 4
	drum_note 3, 4
	drum_note 3, 4
	drum_note 3, 4
	drum_note 3, 8
	drum_note 3, 4
	sound_loop 4, Music_TitleScreenXY_Ch4_b1
	drum_speed 12
	rest 8
	drum_note 12, 16
	drum_note 12, 16
	drum_note 12, 16
	drum_note 12, 8
	drum_speed 4
	sound_call Music_TitleScreenXY_Ch4_b2
	sound_call Music_TitleScreenXY_Ch4_b2
	sound_call Music_TitleScreenXY_Ch4_b2
	drum_note 3, 8
	drum_note 3, 12
	drum_note 3, 4
	drum_note 3, 4
	drum_note 3, 4
	drum_note 3, 4
	drum_note 3, 8
	drum_note 3, 4
	drum_note 3, 12
	drum_note 3, 12
	drum_note 3, 2
	drum_note 3, 2
	drum_note 3, 4
	drum_note 3, 4
	drum_note 3, 12
	drum_note 3, 12
	drum_note 3, 12
	drum_note 3, 2
	drum_note 3, 2
	drum_note 3, 4
	drum_note 3, 4
	drum_note 3, 2
	drum_note 3, 2
	drum_note 3, 4
	drum_note 3, 4
	drum_note 3, 12
	drum_note 3, 4
	drum_note 3, 4
	drum_note 3, 4
	drum_note 3, 12
	rest 12
	rest 16
	rest 16
	rest 16
	rest 16
	sound_jump Music_TitleScreenXY_Ch4_b0

Music_TitleScreenXY_Ch4_b2:
	drum_note 3, 8
	drum_note 3, 12
	drum_note 3, 4
	drum_note 3, 2
	drum_note 3, 2
	drum_note 3, 4
	drum_note 3, 4
	drum_note 3, 8
	drum_note 3, 4
	sound_ret
