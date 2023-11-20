; Pokémon Go - Battle! Wild Pokémon
; Demixed by ShockSlayer
; https://soundcloud.com/user-927422935-571023782/pokemon-go-wild-battle-8-bit-1/s-4NapJ

Music_WildBattleGo:
	channel_count 4
	channel 1, Music_WildBattleGo_Ch1
	channel 2, Music_WildBattleGo_Ch2
	channel 3, Music_WildBattleGo_Ch3
	channel 4, Music_WildBattleGo_Ch4

Music_WildBattleGo_Ch1:
	tempo 112
	volume 7, 7
	stereo_panning TRUE, TRUE
	duty_cycle_pattern 1, 1, 2, 2
	octave 3
	note_type 12, 10, 3
	note D_, 1
	note F#, 1
	note A_, 1
	octave 4
	note C#, 1
	note D_, 2
	rest 4
	octave 3
	note D_, 1
	rest 5
	note D_, 1
	rest 3
	note D_, 1
	rest 5
	note D_, 1
	rest 5
Music_WildBattleGo_Ch1_loop:
	note_type 12, 10, 3
	note D#, 3
	rest 1
	note A_, 1
	rest 5
	note A_, 1
	rest 5
	note A_, 1
	rest 3
	note A_, 1
	rest 5
	note A_, 1
	rest 3
	note C#, 4
	rest 2
	duty_cycle 2
	sound_call Music_WildBattleGo_Ch1_ditty1
	sound_call Music_WildBattleGo_Ch1_ditty2
	sound_call Music_WildBattleGo_Ch1_ditty1
	sound_call Music_WildBattleGo_Ch1_ditty2
	octave 2
	note A#, 4
	note A#, 1
	rest 1
	note A#, 6
	note A#, 4
	note F_, 4
	note F_, 2
	note F_, 2
	note F_, 2
	note F_, 2
	note F_, 2
	note F_, 2
	octave 3
	sound_call Music_WildBattleGo_Ch1_ditty2
	sound_call Music_WildBattleGo_Ch1_ditty1
	sound_call Music_WildBattleGo_Ch1_ditty1
	rest 4
	duty_cycle 1
	volume_envelope 15, 3
	vibrato 5, 1, 3
	octave 2
	note A#, 4
	octave 3
	note D_, 4
	note F_, 4
	volume_envelope 13, 8
	note A#, 16
	volume_envelope 15, 3
	note E_, 2
	note C_, 2
	octave 2
	note G_, 2
	octave 3
	note C_, 2
	note E_, 4
	note G_, 4
	volume_envelope 13, 8
	octave 4
	note C_, 16
Music_WildBattleGo_Ch1_loop_2:
	volume_envelope 15, 3
	octave 3
	note F#, 2
	note D_, 2
	octave 2
	note A_, 2
	octave 3
	note D_, 2
	note F#, 4
	note A_, 4
	volume_envelope 13, 8
	octave 4
	note D_, 16
	sound_loop 2, Music_WildBattleGo_Ch1_loop_2
	duty_cycle_pattern 1, 1, 2, 2
	octave 3
	sound_call Music_WildBattleGo_Ch2_ditty2
	sound_jump Music_WildBattleGo_Ch1_loop

Music_WildBattleGo_Ch1_ditty1:
	note D_, 4
	note D_, 1
	rest 1
	note D_, 6
	note D_, 4
	note D_, 4
	note D_, 2
	note D_, 2
	note D_, 2
	note D_, 2
	note D_, 2
	note D_, 2
	sound_ret

Music_WildBattleGo_Ch1_ditty2:
	note C_, 4
	note C_, 1
	rest 1
	note C_, 6
	note C_, 4
	note C_, 4
	note C_, 2
	note C_, 2
	note C_, 2
	note C_, 2
	note C_, 2
	note C_, 2
	sound_ret

Music_WildBattleGo_Ch2:
	note_type 12, 0, 0
	rest 4
	duty_cycle_pattern 1, 1, 2, 2
	volume_envelope 10, 3
	octave 5
	sound_call Music_WildBattleGo_Ch2_ditty2
Music_WildBattleGo_Ch2_loop:
	note D#, 3
	rest 1
	note A_, 1
	rest 5
	note A_, 1
	rest 5
	note A_, 1
	rest 3
	note A_, 1
	rest 5
	note A_, 1
	rest 3
	note C#, 4
	rest 2
	duty_cycle 1
	volume_envelope 10, 8
	vibrato 8, 1, 3
	octave 4
	sound_call Music_WildBattleGo_Ch2_ditty1
	note G_, 4
	note F#, 4
	volume_envelope 11, 7
	note E_, 6
	note E_, 10
	volume_envelope 10, 8
	octave 5
	note C_, 8
	octave 4
	note G_, 8
	sound_call Music_WildBattleGo_Ch2_ditty1
	note A_, 4
	note B_, 4
	octave 5
	note C_, 4
	octave 3
	note G_, 2
	octave 4
	note E_, 10
	note G_, 4
	octave 5
	note C_, 4
	note E_, 4
	note C_, 4
	octave 3
	note A#, 2
	note F_, 2
	note A#, 2
	octave 4
	note F_, 10
	octave 2
	note A#, 2
	octave 3
	note D_, 2
	note F_, 2
	pitch_slide 1, 3, A#
	note A_, 1
	note A#, 3
	note F_, 2
	note D_, 2
	note F_, 2
	octave 4
	note C_, 2
	octave 3
	note G_, 2
	octave 4
	note C_, 2
	note G_, 2
	note A_, 2
	octave 5
	note C_, 2
	octave 4
	note A_, 2
	note A_, 1
	note G#, 1
	note G_, 16
	note D_, 2
	octave 3
	note A_, 2
	octave 4
	note D_, 2
	volume_envelope 11, 7
	note A_, 6
	note A_, 4
	volume_envelope 10, 8
	note B_, 4
	note_type 15, 10, 8
	note A_, 3
	note G_, 3
	note_type 6, 10, 8
	note G_, 1
	note F#, 8
	note D_, 4
	octave 3
	note A_, 4
	octave 4
	note D_, 4
	volume_envelope 11, 7
	note A_, 12
	note A_, 8
	volume_envelope 10, 8
	note B_, 8
	note A_, 8
	note G_, 8
	note F#, 8
Music_WildBattleGo_Ch2_loop_1:
	rest 16
	sound_loop 8, Music_WildBattleGo_Ch2_loop_1
	duty_cycle_pattern 1, 1, 2, 2
	octave 5
	note D_, 2
	rest 10
	note D_, 2
	rest 10
	note D_, 2
	rest 6
	note D_, 2
	rest 10
	note D_, 2
	note_type 12, 10, 8
	rest 9
	note D_, 1
	rest 5
	note D_, 1
	rest 5
	note D_, 1
	rest 3
	note D_, 1
	rest 5
	note D_, 1
	rest 9
	sound_call Music_WildBattleGo_Ch2_ditty2
	sound_jump Music_WildBattleGo_Ch2_loop

Music_WildBattleGo_Ch2_ditty1:
	note D_, 6
	octave 3
	note A_, 2
	octave 4
	note F#, 4
	note E_, 2
	note F#, 2
	note G_, 4
	note F#, 4
	sound_ret

Music_WildBattleGo_Ch2_ditty2:
	note D_, 1
	rest 5
	note D_, 1
	rest 5
	note D_, 1
	rest 3
	note D_, 1
	rest 5
	note D_, 1
	rest 5
	sound_ret

Music_WildBattleGo_Ch3:
	octave 3
	note_type 12, 1, 6
	note D_, 2
	rest 2
	octave 2
Music_WildBattleGo_Ch3_loop_1:
	note D_, 2
	note A_, 2
	sound_loop 7, Music_WildBattleGo_Ch3_loop_1
Music_WildBattleGo_Ch3_loop:
	note A#, 2
	note A_, 2
Music_WildBattleGo_Ch3_loop_2:
	note D_, 2
	note A_, 2
	sound_loop 6, Music_WildBattleGo_Ch3_loop_2
	octave 3
	note D_, 2
	note C#, 2
	note E_, 2
	note E_, 2
	octave 2
Music_WildBattleGo_Ch3_loop_3:
	note D_, 2
	note A_, 2
	sound_loop 8, Music_WildBattleGo_Ch3_loop_3
Music_WildBattleGo_Ch3_loop_10:
	note C_, 2
	note G_, 2
	sound_loop 7, Music_WildBattleGo_Ch3_loop_10
	note A_, 2
	note G_, 2
Music_WildBattleGo_Ch3_loop_4:
	note D_, 2
	note A_, 2
	sound_loop 8, Music_WildBattleGo_Ch3_loop_4
Music_WildBattleGo_Ch3_loop_11:
	note C_, 2
	note G_, 2
	sound_loop 5, Music_WildBattleGo_Ch3_loop_11
	note F_, 2
	note E_, 2
	note F_, 2
	note E_, 2
	note D_, 2
	note E_, 2
Music_WildBattleGo_Ch3_loop_14:
	octave 1
	note A#, 2
	octave 2
	note F_, 2
	sound_loop 8, Music_WildBattleGo_Ch3_loop_14
Music_WildBattleGo_Ch3_loop_12:
	note C_, 2
	note G_, 2
	sound_loop 8, Music_WildBattleGo_Ch3_loop_12
Music_WildBattleGo_Ch3_loop_9:
	note D_, 2
	note A_, 2
	sound_loop 10, Music_WildBattleGo_Ch3_loop_9
	octave 3
	note D_, 2
	octave 2
	note A_, 2
	note D_, 2
	note A_, 2
	note D_, 2
	note A_, 2
	octave 3
	note D_, 2
	octave 2
	note A_, 2
	octave 3
	note D_, 2
	octave 2
	note A_, 2
	note D_, 2
	note A_, 2
Music_WildBattleGo_Ch3_loop_15:
	octave 1
	note A#, 2
	octave 2
	note F_, 2
	sound_loop 8, Music_WildBattleGo_Ch3_loop_15
Music_WildBattleGo_Ch3_loop_13:
	note C_, 2
	note G_, 2
	sound_loop 8, Music_WildBattleGo_Ch3_loop_13
Music_WildBattleGo_Ch3_loop_5:
	note D_, 2
	note A_, 2
	sound_loop 3, Music_WildBattleGo_Ch3_loop_5
	octave 3
	note D_, 2
	octave 2
	note A_, 2
Music_WildBattleGo_Ch3_loop_6:
	note D_, 2
	note A_, 2
	sound_loop 3, Music_WildBattleGo_Ch3_loop_6
	note A#, 2
	note A_, 2
Music_WildBattleGo_Ch3_loop_7:
	note D_, 2
	note A_, 2
	sound_loop 6, Music_WildBattleGo_Ch3_loop_7
	octave 3
	note D_, 2
	octave 2
	note A_, 2
	octave 3
	note D_, 2
	octave 2
	note A_, 2
Music_WildBattleGo_Ch3_loop_8:
	note D_, 2
	note A_, 2
	sound_loop 7, Music_WildBattleGo_Ch3_loop_8
	sound_jump Music_WildBattleGo_Ch3_loop

Music_WildBattleGo_Ch4:
	drum_speed 12
	rest 4
	toggle_noise 3
	sound_call Music_WildBattleGo_Ch4_ditty1
	sound_call Music_WildBattleGo_Ch4_ditty2
	sound_call Music_WildBattleGo_Ch4_ditty1
	drum_note 3, 1
	rest 1
	drum_note 2, 1
	rest 1
Music_WildBattleGo_Ch4_loop:
	drum_note 7, 1
	rest 1
	drum_note 2, 1
	drum_note 8, 1
Music_WildBattleGo_Ch4_loop_1:
	sound_call Music_WildBattleGo_Ch4_ditty1
	sound_call Music_WildBattleGo_Ch4_ditty2
	sound_call Music_WildBattleGo_Ch4_ditty1
	sound_call Music_WildBattleGo_Ch4_ditty3
	sound_call Music_WildBattleGo_Ch4_ditty1
	sound_call Music_WildBattleGo_Ch4_ditty2
	sound_call Music_WildBattleGo_Ch4_ditty1
	sound_call Music_WildBattleGo_Ch4_ditty2
	sound_call Music_WildBattleGo_Ch4_ditty1
	sound_call Music_WildBattleGo_Ch4_ditty2
	sound_call Music_WildBattleGo_Ch4_ditty1
	sound_call Music_WildBattleGo_Ch4_ditty2
	sound_call Music_WildBattleGo_Ch4_ditty1
	sound_call Music_WildBattleGo_Ch4_ditty2
	sound_call Music_WildBattleGo_Ch4_ditty1
	sound_call Music_WildBattleGo_Ch4_ditty2
	sound_loop 2, Music_WildBattleGo_Ch4_loop_1
	sound_call Music_WildBattleGo_Ch4_ditty1
	sound_call Music_WildBattleGo_Ch4_ditty2
	sound_call Music_WildBattleGo_Ch4_ditty1
	drum_note 3, 1
	rest 1
	drum_note 2, 1
	rest 1
	drum_note 7, 1
	drum_note 7, 1
	drum_note 2, 1
	drum_note 7, 1
Music_WildBattleGo_Ch4_loop_2:
	sound_call Music_WildBattleGo_Ch4_ditty1
	sound_call Music_WildBattleGo_Ch4_ditty2
	sound_loop 9, Music_WildBattleGo_Ch4_loop_2
	sound_call Music_WildBattleGo_Ch4_ditty1
	drum_note 3, 1
	rest 1
	drum_note 2, 1
	rest 1
	sound_jump Music_WildBattleGo_Ch4_loop

Music_WildBattleGo_Ch4_ditty1:
	drum_note 3, 1
	rest 1
	drum_note 2, 1
	rest 1
	drum_note 7, 1
	rest 1
	drum_note 2, 1
	drum_note 2, 1
	sound_ret

Music_WildBattleGo_Ch4_ditty2:
	drum_note 3, 1
	rest 1
	drum_note 2, 1
	rest 1
	drum_note 7, 1
	rest 1
	drum_note 2, 1
	rest 1
	sound_ret

Music_WildBattleGo_Ch4_ditty3:
	drum_note 3, 1
	rest 1
	drum_note 2, 1
	rest 1
	drum_note 7, 1
	rest 1
	drum_note 2, 1
	drum_note 8, 1
	sound_ret
