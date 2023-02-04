; Pokémon X/Y - Power Plant
; Demixed by ShantyTown
; https://github.com/huderlem/pokestyle-music-devamps/blob/master/music/kalos_powerplant.asm

Music_PowerPlantXY:
	channel_count 4
	channel 1, Music_PowerPlantXY_Ch1
	channel 2, Music_PowerPlantXY_Ch2
	channel 3, Music_PowerPlantXY_Ch3
	channel 4, Music_PowerPlantXY_Ch4

Music_PowerPlantXY_Ch1:
	tempo 175
	volume 7, 7
	stereo_panning FALSE, TRUE
	vibrato 18, 2, 3
	note_type 12, 8, 7
	duty_cycle 0

Music_PowerPlantXY_Ch1_branch_0:
	sound_call Music_PowerPlantXY_Ch1_branch_4
	sound_call Music_PowerPlantXY_Ch1_branch_1
	sound_call Music_PowerPlantXY_Ch1_branch_1
	sound_call Music_PowerPlantXY_Ch1_branch_2
	sound_call Music_PowerPlantXY_Ch1_branch_1
	sound_call Music_PowerPlantXY_Ch1_branch_1
	sound_call Music_PowerPlantXY_Ch1_branch_3
	sound_jump Music_PowerPlantXY_Ch1_branch_0

Music_PowerPlantXY_Ch1_branch_1:
	vibrato 18, 2, 3
	note_type 12, 12, 3
	octave 2
	note G#, 3
	note_type 12, 12, 2
	note G#, 1
	rest 6
	note G#, 2
	rest 1
	note G#, 2
	rest 1
	note_type 12, 12, 3
	note G#, 3
	note_type 12, 12, 2
	note G#, 1
	rest 6
	note G#, 2
	rest 1
	note G#, 2
	rest 1
	note_type 12, 12, 3
	note G_, 3
	note_type 12, 12, 2
	note G_, 1
	rest 6
	note G_, 2
	rest 1
	note G_, 2
	rest 1
	note_type 12, 12, 3
	note G_, 3
	note_type 12, 12, 2
	note G_, 1
	rest 6
	note G_, 2
	rest 1
	note G_, 2
	rest 1
	sound_ret

Music_PowerPlantXY_Ch1_branch_2:
	note_type 12, 12, 2
	octave 3
	note C#, 1
	rest 2
	note D_, 1
	rest 2
	note_type 12, 11, -1
	note C#, 6
	rest 4
	octave 2
	note A#, 1
	rest 2
	note D#, 1
	rest 2
	note_type 12, 11, -1
	note D_, 10
	note_type 12, 10, -2
	note F#, 2
	note F#, 2
	note F#, 2
	octave 3
	note C_, 2
	note C#, 2
	note C_, 2
	note C#, 2
	note D#, 2
	note_type 12, 6, -6
	note C_, 8
	rest 2
	octave 2
	note_type 12, 13, 3
	note G#, 1
	rest 2
	note_type 12, 12, 8
	note F#, 3
	sound_ret

Music_PowerPlantXY_Ch1_branch_3:
	note_type 12, 6, -2
	octave 4
	note E_, 16
	note C_, 8
	note E_, 8
	octave 3
	note B_, 16
	note G#, 6
	note G#, 6
	note G#, 4
	note B_, 16
	note B_, 8
	octave 4
	note D#, 8
	octave 3
	note B_, 16
	note B_, 8
	octave 4
	note D#, 8
	sound_ret

Music_PowerPlantXY_Ch1_branch_4:
	vibrato 18, 3, 5
	duty_cycle 2
	note_type 12, 5, 1
	rest 3
	octave 4
	note E_, 2
	note E_, 2
	rest 1
	note E_, 2
	rest 1
	note E_, 2
	note F#, 2
	note D#, 2
	octave 3
	rest 2
	octave 4
	note E_, 2
	note E_, 2
	rest 1
	note E_, 2
	rest 1
	note E_, 2
	note D#, 2
	rest 1
	sound_ret

Music_PowerPlantXY_Ch2:
	stereo_panning TRUE, TRUE
	vibrato 18, 2, 3
	note_type 12, 12, 4

Music_PowerPlantXY_Ch2_branch_0:
	sound_call Music_PowerPlantXY_Ch2_branch_4
	sound_call Music_PowerPlantXY_Ch2_branch_1
	sound_call Music_PowerPlantXY_Ch2_branch_1
	sound_call Music_PowerPlantXY_Ch2_branch_2
	sound_call Music_PowerPlantXY_Ch2_branch_1
	sound_call Music_PowerPlantXY_Ch2_branch_1
	sound_call Music_PowerPlantXY_Ch2_branch_3
	sound_jump Music_PowerPlantXY_Ch2_branch_0

Music_PowerPlantXY_Ch2_branch_1:
	note_type 12, 12, 2
	duty_cycle 1
	octave 3
	note G#, 2
	octave 4
	note E_, 2
	note D#, 2
	octave 3
	note B_, 2
	octave 4
	note C#, 2
	rest 2
	octave 3
	note G#, 2
	note B_, 2
	rest 2
	note A_, 2
	rest 2
	note G#, 2
	rest 2
	note F#, 2
	note G#, 2
	rest 3
	octave 4
	note E_, 1
	duty_cycle 2
	octave 5
	note E_, 1
	duty_cycle 1
	octave 4
	note E_, 1
	duty_cycle 2
	octave 5
	note E_, 2
	duty_cycle 1
	octave 4
	note E_, 1
	duty_cycle 2
	octave 5
	note E_, 2
	duty_cycle 1
	octave 4
	note E_, 1
	octave 5
	note D_, 2
	octave 4
	note B_, 2
	note A_, 2
	note B_, 2
	note A_, 1
	note E_, 2
	note E_, 1
	note A_, 1
	note B_, 3
	note A_, 2
	note E_, 2
	note A_, 2
	sound_ret

Music_PowerPlantXY_Ch2_branch_2:
	vibrato 18, 2, 3
	duty_cycle 1
	note_type 12, 12, 2
	octave 4
	note C#, 1
	rest 2
	octave 3
	note G#, 1
	rest 2
	note_type 12, 11, -1
	note A_, 6
	octave 4
	note C#, 1
	note D#, 1
	note E_, 1
	note F_, 1
	note_type 12, 13, 2
	note F#, 1
	rest 2
	octave 3
	note F#, 1
	rest 2
	note_type 12, 11, -1
	note B_, 10
	note_type 12, 10, -2
	note A_, 2
	note B_, 2
	note A_, 2
	octave 4
	note D#, 2
	note E_, 2
	note D#, 2
	note E_, 2
	note F#, 2
	note_type 12, 4, -7
	note D#, 8
	rest 2
	note_type 12, 13, 3
	note E_, 1
	rest 2
	note_type 12, 12, 8
	note D#, 3
	sound_ret

Music_PowerPlantXY_Ch2_branch_3:
	note_type 12, 6, -2
	octave 4
	note G#, 16
	note F#, 8
	note B_, 8
	note E_, 16
	note D_, 6
	note E_, 6
	note F#, 4
	note G#, 16
	note F#, 8
	note B_, 8
	note G#, 16
	note F#, 8
	note B_, 8
	sound_ret

Music_PowerPlantXY_Ch2_branch_4:
	vibrato 18, 3, 5
	duty_cycle 2
	note_type 12, 12, 2
	octave 3
	note C#, 1
	note G#, 1
	octave 4
	note E_, 2
	note E_, 2
	rest 1
	note E_, 2
	rest 1
	note E_, 2
	note F#, 2
	note D#, 2
	octave 3
	note C#, 1
	note G#, 1
	octave 4
	note E_, 2
	note E_, 2
	rest 1
	note E_, 2
	rest 1
	note E_, 2
	note D#, 2
	rest 2
	sound_ret

Music_PowerPlantXY_Ch3:
	stereo_panning TRUE, TRUE
	note_type 12, 1, 1

Music_PowerPlantXY_Ch3_branch_0:
	sound_call Music_PowerPlantXY_Ch3_branch_4
	sound_call Music_PowerPlantXY_Ch3_branch_1
	sound_call Music_PowerPlantXY_Ch3_branch_1
	sound_call Music_PowerPlantXY_Ch3_branch_2
	sound_call Music_PowerPlantXY_Ch3_branch_1
	sound_call Music_PowerPlantXY_Ch3_branch_1
	sound_call Music_PowerPlantXY_Ch3_branch_3
	sound_jump Music_PowerPlantXY_Ch3_branch_0

Music_PowerPlantXY_Ch3_branch_1:
	vibrato 0, 6, 6
	note_type 12, 1, 4
	octave 3
	note C#, 3
	note C#, 1
	rest 2
	octave 2
	note_type 12, 1, 2
	note C#, 4
	note_type 12, 1, 4
	octave 3
	note C#, 2
	rest 1
	note C#, 2
	rest 1
	note C#, 3
	note C#, 1
	rest 2
	note_type 12, 1, 2
	octave 2
	note C#, 4
	note_type 12, 1, 4
	octave 3
	note C#, 2
	rest 1
	note C#, 2
	rest 1
	note E_, 3
	note E_, 1
	rest 2
	note_type 12, 1, 2
	octave 2
	note E_, 4
	note_type 12, 1, 4
	octave 3
	note E_, 2
	rest 1
	note E_, 2
	rest 1
	note E_, 3
	note E_, 1
	rest 2
	note_type 12, 1, 2
	octave 2
	note E_, 4
	note_type 12, 1, 4
	octave 3
	note E_, 2
	rest 1
	note E_, 2
	rest 1
	sound_ret

Music_PowerPlantXY_Ch3_branch_2:
	note_type 12, 1, 4
	octave 2
	note A_, 1
	rest 2
	note G#, 1
	rest 2
	note A_, 7
	note G#, 1
	note A_, 1
	note G#, 1
	note F#, 1
	rest 2
	note D#, 1
	rest 2
	note G_, 8
	note A_, 1
	note G_, 1
	note F#, 8
	note D#, 8
	note G#, 8
	rest 2
	note G#, 1
	rest 2
	note G#, 3
	sound_ret

Music_PowerPlantXY_Ch3_branch_3:
	octave 2
	note B_, 2
	rest 1
	note B_, 1
	rest 6
	octave 3
	note E_, 3
	octave 2
	note A_, 3
	note G#, 2
	rest 1
	note G#, 1
	rest 1
	note G#, 1
	rest 4
	note G#, 2
	rest 1
	note G#, 3
	octave 3
	note C#, 2
	rest 1
	note C#, 1
	rest 2
	note C#, 1
	rest 3
	note C#, 1
	rest 2
	note C#, 3
	octave 2
	note E_, 2
	rest 1
	note E_, 1
	rest 2
	note E_, 1
	rest 3
	note E_, 1
	rest 2
	note E_, 3
	note F#, 4
	note B_, 1
	octave 3
	note C_, 1
	note C#, 6
	octave 2
	note F#, 4
	note G#, 4
	octave 3
	note C#, 1
	note D_, 1
	note D#, 6
	octave 2
	note B_, 4
	note G#, 4
	octave 3
	note C#, 1
	note D#, 1
	note E_, 6
	octave 2
	note B_, 2
	octave 3
	note C#, 2
	octave 2
	note B_, 4
	octave 3
	note D#, 1
	note F_, 1
	note F#, 4
	note D#, 2
	octave 2
	note B_, 2
	octave 3
	note D#, 2
	sound_ret

Music_PowerPlantXY_Ch3_branch_4:
	note_type 12, 1, 1
	octave 3
	note C#, 16
	note C#, 13
	rest 3
	sound_ret

Music_PowerPlantXY_Ch4:
	drum_speed 12
	toggle_noise 3
Music_PowerPlantXY_Ch4_branch_0:
	drum_note 11, 3
	drum_note 2, 1
	drum_note 3, 2
	drum_note 11, 4
	drum_note 11, 2
	drum_note 3, 4
	drum_note 11, 3
	drum_note 2, 1
	drum_note 3, 2
	drum_note 11, 4
	drum_note 11, 2
	drum_note 1, 4
Music_PowerPlantXY_Ch4_branch_1:
	drum_note 3, 4
	drum_note 3, 2
	drum_note 3, 2
	drum_note 3, 2
	drum_note 3, 2
	drum_note 3, 1
	drum_note 9, 1
	drum_note 12, 2
	drum_note 3, 2
	drum_note 3, 1
	drum_note 9, 1
	drum_note 3, 2
	drum_note 3, 2
	drum_note 3, 2
	drum_note 3, 2
	drum_note 3, 1
	drum_note 9, 1
	drum_note 12, 2
	sound_loop 5, Music_PowerPlantXY_Ch4_branch_1
	drum_note 3, 4
	drum_note 3, 2
	drum_note 3, 2
	drum_note 3, 2
	drum_note 3, 2
	drum_note 3, 1
	drum_note 9, 1
	drum_note 12, 2
	drum_note 3, 2
	drum_note 3, 1
	drum_note 9, 1
	drum_note 3, 2
	drum_note 3, 2
	drum_note 3, 2
	drum_note 12, 2
	rest 1
	drum_note 12, 2
	rest 1
Music_PowerPlantXY_Ch4_branch_3:
	drum_note 3, 4
	drum_note 3, 2
	drum_note 3, 2
	drum_note 3, 2
	drum_note 3, 2
	drum_note 3, 1
	drum_note 9, 1
	drum_note 12, 2
	drum_note 3, 2
	drum_note 3, 1
	drum_note 9, 1
	drum_note 3, 2
	drum_note 3, 2
	drum_note 3, 2
	drum_note 3, 2
	drum_note 3, 1
	drum_note 9, 1
	drum_note 12, 2
	sound_loop 8, Music_PowerPlantXY_Ch4_branch_3
	sound_jump Music_PowerPlantXY_Ch4_branch_0
