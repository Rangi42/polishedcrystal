; Pokémon S/M - Battle! Elite Four
; Demixed by Mmmmmm
; https://pastebin.com/Q2MsZc9W
; https://hax.iimarckus.org/topic/6777/8/

Music_EliteFourBattleSM:
	channel_count 4
	channel 1, Music_EliteFourBattleSM_Ch1
	channel 2, Music_EliteFourBattleSM_Ch2
	channel 3, Music_EliteFourBattleSM_Ch3
	channel 4, Music_EliteFourBattleSM_Ch4

Music_EliteFourBattleSM_Ch1:
	tempo 184
	volume 7, 7
	duty_cycle 0
	pitch_offset 2
	vibrato 18, 1, 5
	note_type 6, 1, 2
	rest 16
	rest 16
	rest 16
	sound_call Music_EliteFourBattleSM_Ch1_branch_1
	volume_envelope 2, 2
	sound_call Music_EliteFourBattleSM_Ch1_branch_1
	volume_envelope 3, 1
	sound_call Music_EliteFourBattleSM_Ch1_branch_1
	volume_envelope 4, 1
	sound_call Music_EliteFourBattleSM_Ch1_branch_1
	volume_envelope 5, 1
	sound_call Music_EliteFourBattleSM_Ch1_branch_1
	volume_envelope 6, 1
	sound_call Music_EliteFourBattleSM_Ch1_branch_1
	volume_envelope 7, 1
	sound_call Music_EliteFourBattleSM_Ch1_branch_1
	volume_envelope 8, 1
	sound_call Music_EliteFourBattleSM_Ch1_branch_1
	volume_envelope 9, 1
	sound_call Music_EliteFourBattleSM_Ch1_branch_1
Music_EliteFourBattleSM_Ch1_loop_main:
Music_EliteFourBattleSM_Ch1_loop_1:
	octave 2
	volume_envelope 11, 1
	note B_, 2
	note B_, 2
	note B_, 2
	note B_, 4
	volume_envelope 11, 4
	note B_, 4
	volume_envelope 11, 1
	note B_, 2
	octave 3
	note C_, 2
	note C_, 2
	note C_, 2
	note C_, 4
	volume_envelope 11, 4
	note C_, 4
	volume_envelope 11, 1
	note C_, 2
	note D_, 2
	note D_, 2
	note D_, 2
	note D_, 4
	volume_envelope 11, 4
	note D_, 4
	volume_envelope 11, 2
	note D_, 2
	note C_, 4
	octave 2
	volume_envelope 9, 1
	note F_, 2
	volume_envelope 9, 2
	note F_, 4
	note F_, 4
	volume_envelope 9, 1
	note F_, 1
	note F_, 1
	sound_loop 2, Music_EliteFourBattleSM_Ch1_loop_1
	rest 16
	duty_cycle 2
	volume_envelope 8, 7
	note E_, 6
	note F_, 6
	note E_, 4
	note G_, 6
	note G#, 6
	note G_, 4
	note A#, 4
	note G#, 4
	note G_, 4
	note F_, 4
	note C_, 6
	note C#, 6
	note C_, 4
	note E_, 6
	note F_, 6
	note E_, 4
	note G_, 6
	note G#, 6
	note G_, 4
	note A#, 4
	note G#, 4
	note G_, 4
	note F_, 4
	volume_envelope 8, 0
	note E_, 8
	volume_envelope 8, 4
	note E_, 8
	rest 16
	rest 16
	rest 16
	duty_cycle 0
Music_EliteFourBattleSM_Ch1_loop_2:
	volume_envelope 9, 2
	note B_, 4
	volume_envelope 9, 1
	note B_, 2
	volume_envelope 9, 2
	note B_, 4
	note B_, 4
	volume_envelope 9, 1
	note B_, 1
	note B_, 1
	sound_loop 4, Music_EliteFourBattleSM_Ch1_loop_2
	duty_cycle 1
Music_EliteFourBattleSM_Ch1_loop_3:
	octave 3
	note E_, 2
	octave 2
	note B_, 2
	octave 3
	note E_, 2
	note A#, 4
	note G_, 4
	note D#, 2
	sound_loop 4, Music_EliteFourBattleSM_Ch1_loop_3
	note E_, 2
	octave 2
	note B_, 2
	octave 3
	note E_, 2
	note B_, 4
	note G_, 4
	note D#, 2
	volume_envelope 10, 1
	note E_, 2
	octave 2
	note B_, 2
	octave 3
	note E_, 2
	note B_, 4
	note G_, 4
	note D#, 2
	volume_envelope 11, 1
	octave 4
	note E_, 2
	octave 3
	note B_, 2
	octave 4
	note E_, 2
	note A_, 2
	volume_envelope 12, 1
	note B_, 2
	note G_, 2
	octave 3
	note B_, 2
	octave 4
	note D#, 2
	volume_envelope 13, 1
	note E_, 2
	octave 3
	note B_, 2
	octave 4
	note E_, 2
	note A_, 2
	volume_envelope 14, 1
	note B_, 2
	note G_, 2
	octave 3
	note B_, 2
	octave 4
	note D#, 2
	duty_cycle 0
	volume_envelope 13, 2
	octave 3
	rest 8
	note E_, 2
	note D#, 4
	note A#, 2
	volume_envelope 13, 7
	note A_, 12
	volume_envelope 6, -7
	note A_, 12
	volume_envelope 13, 2
	note E_, 2
	note D#, 4
	note A#, 2
	volume_envelope 13, 7
	note A_, 12
	volume_envelope 6, -7
	note A_, 12
	volume_envelope 13, 2
	note A#, 2
	note A_, 4
	octave 4
	note E_, 2
	volume_envelope 13, 6
	note D#, 12
	volume_envelope 6, -7
	note D#, 12
	volume_envelope 13, 2
	octave 3
	note A#, 2
	note A_, 4
	octave 4
	note E_, 2
	volume_envelope 13, 7
	note D#, 8
	volume_envelope 8, -6
	note D#, 8
	sound_jump Music_EliteFourBattleSM_Ch1_loop_main

Music_EliteFourBattleSM_Ch1_branch_1:
	octave 3
	note E_, 2
	octave 2
	note B_, 2
	octave 3
	note E_, 2
	note A_, 2
	note B_, 2
	note G_, 2
	octave 2
	note B_, 2
	octave 3
	note D#, 2
	sound_ret

Music_EliteFourBattleSM_Ch2:
	duty_cycle 1
	vibrato 8, 3, 6
	pitch_offset 1
	note_type 6, 10, 2
	octave 3
	note F_, 4
	volume_envelope 10, 1
	note F_, 2
	volume_envelope 10, 2
	note F_, 4
	note F_, 4
	volume_envelope 10, 1
	note F_, 1
	note F_, 1
	sound_loop 3, Music_EliteFourBattleSM_Ch2
	rest 16
Music_EliteFourBattleSM_Ch2_loop_1:
	volume_envelope 10, 2
	note G_, 4
	volume_envelope 10, 1
	note G_, 2
	volume_envelope 10, 2
	note G_, 4
	note G_, 4
	volume_envelope 10, 1
	note G_, 1
	note G_, 1
	sound_loop 3, Music_EliteFourBattleSM_Ch2_loop_1
	rest 16
Music_EliteFourBattleSM_Ch2_loop_2:
	volume_envelope 10, 2
	note A_, 4
	volume_envelope 10, 1
	note A_, 2
	volume_envelope 10, 2
	note A_, 4
	note A_, 4
	volume_envelope 10, 1
	note A_, 1
	note A_, 1
	sound_loop 3, Music_EliteFourBattleSM_Ch2_loop_2
	rest 16
Music_EliteFourBattleSM_Ch2_loop_main:
Music_EliteFourBattleSM_Ch2_loop_3:
	octave 4
	volume_envelope 12, 1
	note E_, 2
	note E_, 2
	note E_, 2
	note E_, 4
	volume_envelope 12, 4
	note E_, 4
	volume_envelope 12, 1
	note E_, 2
	note F_, 2
	note F_, 2
	note F_, 2
	note F_, 4
	volume_envelope 12, 4
	note F_, 4
	volume_envelope 12, 1
	note F_, 2
	note G_, 2
	note G_, 2
	note G_, 2
	note G_, 4
	volume_envelope 12, 4
	note G_, 4
	volume_envelope 12, 2
	note G_, 2
	volume_envelope 12, 1
	note F_, 16
	sound_loop 2, Music_EliteFourBattleSM_Ch2_loop_3
	volume_envelope 11, 7
	octave 3
	note E_, 6
	note F_, 6
	note E_, 4
	note G_, 6
	note G#, 6
	note G_, 4
	note A#, 4
	note G#, 4
	note G_, 4
	note F_, 4
	note E_, 6
	note F_, 6
	note G_, 4
	note E_, 6
	note F_, 6
	note E_, 4
	note G_, 6
	note G#, 6
	note G_, 4
	note A#, 4
	note G#, 4
	note G_, 4
	note F_, 4
	note G_, 6
	note G#, 6
	octave 4
	note D#, 4
	volume_envelope 11, 0
	note E_, 8
	volume_envelope 11, 4
	note E_, 8
	duty_cycle 0
	octave 2
Music_EliteFourBattleSM_Ch2_loop_4:
	duty_cycle 0
	volume_envelope 9, 2
	note B_, 4
	volume_envelope 9, 1
	note B_, 2
	volume_envelope 9, 2
	note B_, 4
	note B_, 4
	volume_envelope 9, 1
	note B_, 1
	note B_, 1
	sound_loop 3, Music_EliteFourBattleSM_Ch2_loop_4
	duty_cycle 2
	volume_envelope 8, 0
	note E_, 8
	note F_, 8
	note E_, 2
	rest 14
	note E_, 8
	note F_, 8
	note G_, 2
	rest 14
	note E_, 8
	note F_, 8
	note E_, 2
	rest 14
	note E_, 8
	note F_, 8
	note G_, 16
	volume_envelope 9, 0
	note A_, 16
	volume_envelope 10, 0
	note B_, 16
	note B_, 16
	note B_, 16
	volume_envelope 14, 2
	duty_cycle 1
	octave 4
	note E_, 2
	note D#, 4
	note A#, 2
	note A_, 4
	note A_, 2
	note G#, 2
	note G_, 2
	note F#, 4
	note D_, 2
	note C#, 4
	note F_, 4
	note E_, 2
	note D#, 4
	note A#, 2
	note A_, 4
	note A_, 2
	note G#, 2
	note G_, 2
	note F#, 4
	note D_, 2
	note C#, 4
	note F_, 4
	octave 3
	note A#, 2
	note A_, 4
	octave 4
	note E_, 2
	note D#, 4
	note D#, 2
	note D_, 2
	note C#, 2
	note C_, 4
	octave 3
	note G#, 2
	note G_, 4
	note B_, 4
	note A#, 2
	note A_, 4
	octave 4
	note E_, 2
	note D#, 4
	note D#, 2
	note D_, 2
	note C#, 2
	note C_, 4
	octave 3
	note G#, 2
	note G_, 4
	note B_, 4
	sound_jump Music_EliteFourBattleSM_Ch2_loop_main

Music_EliteFourBattleSM_Ch3:
	octave 2
	sound_call Music_EliteFourBattleSM_Ch3_branch_1
	sound_call Music_EliteFourBattleSM_Ch3_branch_1
	sound_call Music_EliteFourBattleSM_Ch3_branch_1
Music_EliteFourBattleSM_Ch3_loop_main:
Music_EliteFourBattleSM_Ch3_loop_1:
	note_type 6, 1, 9
	note E_, 2
	note B_, 2
	note E_, 2
	note B_, 2
	note E_, 2
	note B_, 2
	note E_, 2
	note B_, 2
	note F_, 2
	octave 3
	note C_, 2
	octave 2
	note F_, 2
	octave 3
	note C_, 2
	octave 2
	note F_, 2
	octave 3
	note C_, 2
	octave 2
	note F_, 2
	octave 3
	note C_, 2
	octave 2
	note G_, 2
	octave 3
	note D_, 2
	octave 2
	note G_, 2
	octave 3
	note D_, 1
	rest 1
	note D_, 2
	octave 2
	note G_, 2
	octave 3
	note D_, 2
	octave 2
	note G_, 2
	note F_, 2
	note E_, 2
	note D_, 2
	note A_, 2
	note F_, 2
	note E_, 2
	note D_, 2
	note D#, 2
	sound_loop 2, Music_EliteFourBattleSM_Ch3_loop_1
Music_EliteFourBattleSM_Ch3_loop_2:
	note E_, 2
	note B_, 2
	sound_loop 15, Music_EliteFourBattleSM_Ch3_loop_2
	octave 3
	note C_, 2
	octave 2
	note B_, 2
Music_EliteFourBattleSM_Ch3_loop_3:
	note E_, 2
	note B_, 2
	sound_loop 15, Music_EliteFourBattleSM_Ch3_loop_3
	octave 3
	note C_, 2
	octave 2
	note B_, 2
Music_EliteFourBattleSM_Ch3_loop_4:
	note E_, 2
	note B_, 2
	sound_loop 13, Music_EliteFourBattleSM_Ch3_loop_4
	octave 3
	note C_, 2
	octave 2
	note B_, 2
	octave 3
	note D_, 2
	note C#, 2
	note C_, 2
	octave 2
	note B_, 2
Music_EliteFourBattleSM_Ch3_loop_5:
	note E_, 2
	note B_, 2
	sound_loop 5, Music_EliteFourBattleSM_Ch3_loop_5
	octave 3
	note C_, 2
	octave 2
	note B_, 2
	octave 3
	note D_, 2
	note C#, 2
	note C_, 2
	octave 2
	note B_, 2
Music_EliteFourBattleSM_Ch3_loop_6:
	note E_, 2
	note B_, 2
	sound_loop 5, Music_EliteFourBattleSM_Ch3_loop_6
	octave 3
	note C_, 2
	octave 2
	note B_, 2
	octave 3
	note D_, 2
	note C#, 2
	note C_, 2
	octave 2
	note B_, 2
Music_EliteFourBattleSM_Ch3_loop_7:
	note E_, 2
	note B_, 2
	note E_, 2
	note B_, 2
	sound_loop 14, Music_EliteFourBattleSM_Ch3_loop_7
	note E_, 2
	note B_, 2
	octave 1
	note B_, 2
	octave 2
	note D#, 2
	note E_, 2
	note D#, 2
	octave 1
	note B_, 2
	octave 2
	note D#, 2
Music_EliteFourBattleSM_Ch3_loop_8:
	note E_, 2
	note B_, 2
	sound_loop 15, Music_EliteFourBattleSM_Ch3_loop_8
	octave 3
	note C_, 2
	octave 2
	note B_, 2
Music_EliteFourBattleSM_Ch3_loop_9:
	note E_, 2
	note A_, 2
	sound_loop 16, Music_EliteFourBattleSM_Ch3_loop_9
	sound_jump Music_EliteFourBattleSM_Ch3_loop_main

Music_EliteFourBattleSM_Ch3_branch_1:
	note_type 3, 1, 9
	note E_, 3
	rest 1
	volume_envelope 2, 9
	note E_, 3
	rest 1
	note E_, 3
	rest 1
	sound_loop 8, Music_EliteFourBattleSM_Ch3_branch_1
	volume_envelope 1, 9
	note F_, 4
	rest 12
	rest 16
	sound_ret

Music_EliteFourBattleSM_Ch4:
	toggle_noise 3
	drum_speed 12
	rest 16
	rest 16
	rest 16
	rest 16
	rest 16
	rest 8
	drum_note 2, 1
	drum_note 2, 2
	drum_note 2, 1
	drum_note 2, 2
	drum_note 1, 1
	drum_note 1, 1
Music_EliteFourBattleSM_Ch4_loop_main:
Music_EliteFourBattleSM_Ch4_loop_1:
	drum_speed 6
	drum_note 4, 4
	drum_note 1, 2
	drum_note 9, 1
	drum_note 8, 1
	drum_note 4, 2
	drum_note 4, 2
	drum_note 1, 4
	sound_loop 16, Music_EliteFourBattleSM_Ch4_loop_1
	drum_note 12, 16
	rest 16
	rest 16
	rest 16
Music_EliteFourBattleSM_Ch4_loop_2:
	drum_note 2, 1
	drum_note 2, 1
	drum_note 2, 2
	drum_note 2, 2
	drum_note 2, 1
	drum_note 2, 1
	drum_note 2, 1
	drum_note 2, 2
	drum_note 2, 1
	drum_note 2, 1
	drum_note 2, 1
	drum_note 2, 1
	drum_note 2, 1
	sound_loop 11, Music_EliteFourBattleSM_Ch4_loop_2
	drum_note 12, 2
	drum_note 1, 1
	drum_note 1, 1
	drum_note 12, 2
	drum_note 1, 1
	drum_note 1, 1
	drum_note 12, 2
	drum_note 1, 1
	drum_note 1, 1
	drum_note 12, 2
	drum_note 1, 1
	drum_note 1, 1
Music_EliteFourBattleSM_Ch4_loop_3:
	drum_note 1, 1
	drum_note 1, 1
	drum_note 1, 1
	drum_note 1, 1
	drum_note 1, 2
	drum_note 1, 1
	drum_note 1, 1
	drum_note 1, 1
	drum_note 1, 1
	drum_note 1, 2
	drum_note 1, 1
	drum_note 1, 1
	drum_note 1, 1
	drum_note 1, 1
	sound_loop 8, Music_EliteFourBattleSM_Ch4_loop_3
	sound_jump Music_EliteFourBattleSM_Ch4_loop_main
