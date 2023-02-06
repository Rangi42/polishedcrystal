; Pokémon: The Movie 2000 - Lugia's Song
; Demixed by Mmmmmm
; https://pastebin.com/UikDn8qP

Music_LugiasSong2000:
	channel_count 4
	channel 1, Music_LugiasSong2000_Ch1
	channel 2, Music_LugiasSong2000_Ch2
	channel 3, Music_LugiasSong2000_Ch3
	channel 4, Music_LugiasSong2000_Ch4

Music_LugiasSong2000_NoIntro:
	channel_count 3
	channel 1, Music_LugiasSong2000_Ch1_loop_main
	channel 2, Music_LugiasSong2000_Ch2_loop_main
	channel 3, Music_LugiasSong2000_Ch3_loop

Music_LugiasSong2000_Ch1:
	duty_cycle 3
	vibrato 18, 1, 5
	pitch_offset 1
	tempo 136
	note_type 12, 6, 0
Music_LugiasSong2000_Ch1_loop_1:
	rest 8
	sound_loop 16, Music_LugiasSong2000_Ch1_loop_1
	rest 8
	octave 2
	note E_, 16
	note D_, 16
	octave 1
	note A_, 12
	note B_, 4
	octave 2
	note C_, 4
	note D_, 2
	note C_, 2
	octave 1
	note B_, 4
	note A_, 4
	note E_, 16
	note D_, 16
	note C_, 16
	note C_, 12
	volume_envelope 6, 7
	note C_, 4
Music_LugiasSong2000_Ch1_loop_main:
	tempo 156
	sound_ret

Music_LugiasSong2000_Ch2:
	duty_cycle 0
	vibrato 18, 1, 5
	pitch_offset 1
	note_type 12, 1, 0
Music_LugiasSong2000_Ch2_loop_1:
	rest 16
	sound_loop 4, Music_LugiasSong2000_Ch2_loop_1
	octave 2
	note B_, 16
	note B_, 16
	volume_envelope 2, 0
	note B_, 16
	note B_, 4
	volume_envelope 4, 0
	note B_, 2
	octave 3
	volume_envelope 5, 0
	note G_, 2
	volume_envelope 4, 0
	note F#, 8
	volume_envelope 4, -6
	note F#, 8
	volume_envelope 10, 7
	octave 4
	note E_, 8
	note D_, 8
	octave 3
	note B_, 8
	note G_, 6
	volume_envelope 10, 2
	note A_, 1
	note B_, 1
	volume_envelope 10, 7
	note A_, 8
	volume_envelope 10, 0
	note E_, 8
	volume_envelope 10, 7
	note E_, 16
	volume_envelope 10, 7
	note E_, 8
	note B_, 8
	note A_, 8
	note D_, 8
	volume_envelope 6, 0
	note E_, 16
	volume_envelope 6, 7
	note E_, 16
Music_LugiasSong2000_Ch2_loop_main:
	duty_cycle 0
	note_type 12, 7, 4
	octave 2
	note E_, 2
	volume_envelope 5, 7
	note G_, 2
	note B_, 2
	octave 3
	note E_, 4
	octave 2
	note B_, 2
	octave 3
	note E_, 4
	octave 2
	volume_envelope 7, 4
	note D_, 2
	volume_envelope 5, 7
	note F#, 2
	note A_, 2
	octave 3
	note E_, 4
	octave 2
	note A_, 2
	octave 3
	note D_, 4
	volume_envelope 7, 4
	octave 2
	note E_, 2
	volume_envelope 5, 7
	note G_, 2
	note B_, 2
	octave 3
	note E_, 4
	octave 2
	note B_, 2
	octave 3
	note E_, 4
	volume_envelope 7, 4
	octave 2
	note D_, 2
	volume_envelope 5, 7
	note F#, 2
	note A_, 2
	octave 3
	note E_, 4
	note D_, 6
	volume_envelope 7, 4
	octave 2
	note E_, 2
	volume_envelope 5, 7
	note G_, 2
	note B_, 2
	octave 3
	note E_, 4
	octave 2
	note B_, 2
	octave 3
	note E_, 4
	volume_envelope 7, 4
	octave 2
	note D_, 2
	volume_envelope 5, 7
	note F#, 2
	note A_, 2
	octave 3
	note E_, 4
	octave 2
	note A_, 2
	octave 3
	note D_, 4
	volume_envelope 7, 4
	octave 2
	note E_, 2
	volume_envelope 5, 7
	note G_, 2
	note B_, 2
	octave 3
	note E_, 4
	octave 2
	note B_, 2
	octave 3
	note E_, 4
	volume_envelope 7, 4
	note F#, 2
	octave 2
	volume_envelope 5, 7
	note F#, 2
	note A_, 2
	octave 3
	note E_, 2
	volume_envelope 7, 4
	octave 2
	note D_, 2
	volume_envelope 5, 7
	note A_, 2
	octave 3
	note D_, 4
	volume_envelope 7, 4
	octave 2
	note C_, 2
	volume_envelope 5, 7
	note E_, 2
	note G_, 2
	octave 3
	note E_, 4
	octave 2
	note G_, 2
	octave 3
	note E_, 4
	volume_envelope 7, 4
	octave 2
	note G_, 2
	volume_envelope 5, 7
	note B_, 2
	octave 3
	note D_, 2
	note G_, 4
	octave 2
	note G_, 2
	octave 3
	note D_, 4
	volume_envelope 7, 4
	octave 1
	note A_, 2
	volume_envelope 5, 7
	octave 2
	note E_, 2
	note A_, 2
	octave 3
	note C_, 4
	octave 2
	note E_, 2
	octave 3
	note D_, 4
	volume_envelope 7, 4
	octave 2
	note C_, 2
	volume_envelope 5, 7
	note E_, 2
	note G_, 2
	octave 3
	note G_, 4
	octave 2
	note E_, 2
	octave 3
	note C_, 4
	volume_envelope 7, 4
	octave 2
	note E_, 2
	volume_envelope 5, 7
	note G_, 2
	note B_, 2
	octave 3
	note E_, 4
	octave 2
	note B_, 2
	octave 3
	note E_, 4
	volume_envelope 7, 4
	octave 2
	note D_, 2
	volume_envelope 5, 7
	note F#, 2
	note A_, 2
	octave 3
	note E_, 2
	octave 2
	note D_, 2
	note A_, 2
	octave 3
	note D_, 4
	octave 2
	volume_envelope 7, 4
	note E_, 4
	volume_envelope 5, 7
	note B_, 2
	octave 3
	note G_, 2
	note F#, 2
	octave 2
	note B_, 2
	octave 3
	volume_envelope 8, 7
	note C_, 4
	note F#, 4
	note E_, 4
	note F#, 4
	note E_, 4
	sound_jump Music_LugiasSong2000_Ch2_loop_main

Music_LugiasSong2000_Ch3:
	note_type 12, 2, 3
	vibrato 8, 1, 6
	sound_call Music_LugiasSong2000_Ch3_branch_1
	note B_, 8
	sound_call Music_LugiasSong2000_Ch3_branch_2
Music_LugiasSong2000_Ch3_loop:
	vibrato 8, 1, 6
	note_type 12, 1, 3
	sound_call Music_LugiasSong2000_Ch3_branch_1
	sound_call Music_LugiasSong2000_Ch3_branch_2
	note E_, 8
	note G_, 8
	note F#, 12
	note D_, 4
	note E_, 8
	octave 4
	note B_, 12
	note B_, 12
	octave 5
	note E_, 8
	note G_, 8
	note F#, 8
	octave 6
	note D_, 10
	note_type 6, 1, 3
	note D_, 2
	octave 5
	note B_, 1
	octave 6
	note C_, 1
	octave 5
	note B_, 4
	note A_, 4
	note_type 12, 1, 3
	note B_, 12
	note B_, 12
	sound_call Music_LugiasSong2000_Ch3_branch_2
	sound_jump Music_LugiasSong2000_Ch3_loop

Music_LugiasSong2000_Ch3_branch_1:
	octave 5
	note E_, 8
	note G_, 8
	note F#, 12
	note D_, 4
	note E_, 8
	octave 4
	note B_, 12
	note B_, 12
	octave 5
	note E_, 8
	note G_, 8
	note F#, 12
	octave 4
	note B_, 4
	octave 5
	note E_, 4
	note G_, 4
	note B_, 12
	note B_, 12
	sound_ret

Music_LugiasSong2000_Ch3_branch_2:
	note_type 6, 1, 3
	octave 6
	note E_, 16
	note D_, 14
	note E_, 1
	note D_, 1
	octave 5
	note B_, 16
	note G_, 12
	note A_, 2
	note B_, 2
	note_type 12, 1, 3
	note A_, 8
	note E_, 12
	note E_, 12
	note_type 6, 1, 3
	note E_, 14
	note B_, 1
	octave 6
	note C_, 1
	octave 5
	note B_, 16
	note A_, 16
	note D_, 16
	note F#, 6
	note G_, 1
	note F#, 1
	note E_, 4
	note D_, 4
	note_type 12, 1, 3
	note E_, 12
	note E_, 6
	volume_envelope 2, 3
	note E_, 6
	volume_envelope 1, 3
	sound_ret

Music_LugiasSong2000_Ch4:
	toggle_noise 3
	drum_speed 12
Music_LugiasSong2000_Ch4_loop_1:
	rest 16
	sound_loop 8, Music_LugiasSong2000_Ch4_loop_1
	drum_speed 6
	drum_note 2, 2
	drum_note 2, 2
	drum_note 2, 2
	drum_note 2, 2
	drum_note 3, 1
	drum_note 3, 1
	drum_note 3, 1
	drum_note 3, 1
	drum_note 3, 1
	drum_note 3, 1
	drum_note 3, 1
	drum_note 3, 1
	drum_speed 12
	drum_note 12, 16
	drum_note 1, 8
	drum_note 1, 8
	drum_note 12, 16
	drum_note 1, 8
	drum_note 1, 8
	drum_note 12, 16
	sound_ret
