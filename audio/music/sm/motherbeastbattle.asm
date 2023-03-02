; Pokémon S/M - Battle! Mother Beast
; Demixed by Mmmmmm
; https://pastebin.com/zWajMT3c
; https://hax.iimarckus.org/topic/6777/5/

Music_MotherBeastBattleSM:
	channel_count 4
	channel 1, Music_MotherBeastBattleSM_Ch1
	channel 2, Music_MotherBeastBattleSM_Ch2
	channel 3, Music_MotherBeastBattleSM_Ch3
	channel 4, Music_MotherBeastBattleSM_Ch4

Music_MotherBeastBattleSM_Ch1:
	duty_cycle 3
	tempo 220
	vibrato 18, 1, 5
	pitch_offset 1
	note_type 12, 1, -7
	octave 3
	note D_, 4
	duty_cycle 2
	volume_envelope 6, 0
	note A#, 16
	note A#, 8
	volume_envelope 6, 7
	note A#, 6
	volume_envelope 6, 0
	note B_, 14
	volume_envelope 6, 7
	note B_, 6
	volume_envelope 3, 0
	note D#, 12
	note D#, 9
	volume_envelope 3, 7
	note D#, 3
Music_MotherBeastBattleSM_Ch1_loop_main:
	volume_envelope 3, 0
	duty_cycle 3
	octave 3
	sound_call Music_MotherBeastBattleSM_Ch2_branch_1
	octave 2
	note A_, 1
	octave 3
	sound_call Music_MotherBeastBattleSM_Ch2_branch_2
	sound_call Music_MotherBeastBattleSM_Ch2_branch_1
	octave 2
	note A_, 1
	octave 3
	sound_call Music_MotherBeastBattleSM_Ch2_branch_2
	octave 3
	duty_cycle 0
	volume_envelope 5, 0
	note D_, 12
	note D#, 12
	note A#, 12
	octave 4
	volume_envelope 5, 0
	note A#, 8
	volume_envelope 5, -7
	note A#, 4
	volume_envelope 7, 2
	duty_cycle 2
	octave 5
	sound_call Music_MotherBeastBattleSM_Ch2_branch_1
	octave 4
	note A_, 1
	octave 5
	sound_call Music_MotherBeastBattleSM_Ch2_branch_2
	sound_call Music_MotherBeastBattleSM_Ch2_branch_1
	octave 4
	note A_, 1
	octave 5
	sound_call Music_MotherBeastBattleSM_Ch2_branch_2
	volume_envelope 6, 0
	duty_cycle 2
	octave 2
	note A_, 1
	octave 3
	note D#, 2
	octave 2
	note A_, 1
	octave 3
	note A_, 1
	note D#, 1
	octave 2
	note A_, 1
	octave 3
	note D#, 1
	note G#, 1
	note D#, 1
	octave 2
	note A_, 1
	octave 3
	note D#, 1
	octave 2
	note G#, 1
	octave 3
	note D_, 2
	octave 2
	note G#, 1
	octave 3
	note D_, 1
	octave 2
	note G#, 1
	octave 3
	note D_, 1
	note G#, 1
	note D_, 1
	octave 2
	note G#, 1
	octave 3
	note D_, 2
	octave 2
	note B_, 1
	octave 3
	note F_, 3
	note D#, 4
	note C_, 4
	octave 2
	note B_, 1
	octave 3
	note D_, 1
	note F_, 4
	octave 2
	note F_, 1
	note B_, 1
	octave 3
	note F_, 4
	rest 16
	rest 16
	rest 16
	volume_envelope 3, 0
	octave 2
	note G_, 16
	note G_, 16
	note G_, 14
	volume_envelope 3, 7
	note G_, 2
	rest 4
	octave 3
	duty_cycle 1
	volume_envelope 1, -7
	note C_, 4
	volume_envelope 6, 0
	note C_, 12
	volume_envelope 6, 7
	note C_, 4
	octave 4
	volume_envelope 1, -7
	note G_, 4
	volume_envelope 6, 0
	note G_, 4
	note F#, 4
	octave 5
	volume_envelope 6, 0
	note D_, 4
	volume_envelope 6, 7
	note D_, 2
	volume_envelope 6, 0
	note C#, 10
	volume_envelope 6, 7
	note C#, 2
	volume_envelope 6, 0
	note C_, 4
	volume_envelope 6, 7
	note C_, 2
	octave 4
	volume_envelope 6, 0
	note B_, 4
	volume_envelope 6, 7
	note B_, 2
	volume_envelope 6, 0
	note A#, 4
	volume_envelope 6, 7
	note A#, 2
	note G_, 2
	note G#, 2
	note F#, 2
	note G_, 2
	note D_, 2
	note F_, 2
	note D#, 2
	note G_, 2
	octave 3
	note G#, 2
	volume_envelope 6, 0
	note G_, 2
	volume_envelope 6, 7
	note G_, 4
	volume_envelope 1, -7
	note C#, 3
	volume_envelope 5, 0
	note C#, 15
	note C#, 15
	volume_envelope 5, 7
	note C#, 3
	volume_envelope 3, 0
	duty_cycle 1
	sound_call Music_MotherBeastBattleSM_Ch2_branch_3
	sound_jump Music_MotherBeastBattleSM_Ch1_loop_main

Music_MotherBeastBattleSM_Ch2:
	duty_cycle 3
	vibrato 18, 1, 5
	note_type 6, 9, 1
	rest 8
	octave 3
	note D_, 1
	note F_, 1
	note G#, 1
	note G#, 1
	octave 4
	note D_, 1
	note G#, 1
	note D_, 1
	octave 3
	note A_, 1
	note G#, 1
	note D_, 1
	note G#, 1
	octave 4
	note D_, 1
	octave 3
	note G#, 1
	note D_, 1
	octave 4
	note G#, 1
	octave 3
	note G#, 1
	octave 4
	note D_, 1
	note G#, 1
	note D_, 1
	octave 3
	note A_, 1
	note G#, 1
	note D_, 1
	octave 4
	note D_, 1
	note G#, 1
	octave 3
	note D_, 1
	note G#, 1
	octave 4
	note D_, 1
	octave 3
	note G#, 1
	note D_, 1
	octave 4
	note G#, 1
	note D_, 1
	octave 3
	note A_, 1
	note G#, 1
	note D_, 1
	note G#, 1
	note D_, 1
	note G#, 1
	note D_, 1
	note G#, 1
	octave 4
	note G#, 1
	note D_, 1
	note G#, 1
	note D_, 1
	octave 3
	note A_, 1
	note G#, 1
	note A_, 1
	octave 4
	note D_, 1
	note G#, 1
	note D_, 1
	octave 3
	note G#, 1
	note A_, 1
	note G#, 1
	octave 4
	note D_, 1
	note G#, 1
	note D_, 1
	octave 3
	note A_, 1
	note G#, 1
	note A_, 1
	note G#, 1
	note A_, 1
	note G#, 1
	note D_, 1
	octave 4
	note D_, 1
	octave 3
	note G#, 1
	octave 4
	note G#, 1
	octave 3
	note G#, 1
	octave 4
	note G#, 1
	note D#, 1
	note D_, 1
	note D#, 1
	note G#, 2
	octave 3
	note G#, 1
	note D_, 1
	octave 4
	note D#, 1
	octave 3
	note G#, 1
	octave 4
	note G#, 1
	octave 5
	note D_, 1
	octave 4
	note G#, 1
	note D#, 1
	note D_, 1
	octave 3
	note G#, 1
	octave 4
	note D_, 1
	note D#, 1
	note D_, 1
	octave 3
	note G#, 1
	octave 4
	note D_, 1
	note D#, 1
	note G#, 1
	octave 5
	note D_, 1
	octave 4
	note G#, 1
	note D#, 1
	note D_, 1
	volume_envelope 7, 1
	note G#, 1
	volume_envelope 6, 1
	note D_, 1
	volume_envelope 5, 1
	note G#, 1
	volume_envelope 4, 1
	note D_, 1
	volume_envelope 3, 1
	note G#, 1
	volume_envelope 2, 1
	note D_, 1
	volume_envelope 1, 1
	note G#, 1
	note_type 3, 6, 5
	octave 4
	note D_, 4
	note A_, 4
	note G_, 4
	octave 5
	note D#, 13
	octave 4
	note A#, 4
	note A_, 4
	note G_, 4
	octave 5
	note D#, 13
	octave 4
	note D_, 4
	note A_, 4
	note G_, 4
	octave 5
	note D#, 13
	octave 4
	note A#, 4
	note A_, 4
	note G_, 4
	octave 5
	note D#, 9
	note_type 12, 9, 0
Music_MotherBeastBattleSM_Ch2_loop_main:
	duty_cycle 2
Music_MotherBeastBattleSM_Ch2_loop_1:
	octave 3
	sound_call Music_MotherBeastBattleSM_Ch2_branch_1
	octave 2
	note A_, 1
	octave 3
	sound_call Music_MotherBeastBattleSM_Ch2_branch_2
	sound_loop 6, Music_MotherBeastBattleSM_Ch2_loop_1
	note_type 3, 4, 2
	duty_cycle 2
	rest 8  ;
	octave 2
	note E_, 1
	note A_, 7 ;
	octave 3
	volume_envelope 9, 2
	note E_, 1
	note A_, 7 ;
	octave 4
	note E_, 1
	note A_, 11 ;
	octave 3
	note G_, 1
	octave 4
	note C_, 7 ;
	note G_, 1
	octave 5
	note C_, 13 ;
	octave 3
	note A#, 2
	octave 4
	note E_, 2 ;
	note A#, 2
	note_type 4, 9, 2
	octave 5
	note E_, 1
	note A#, 1
	note E_, 1
	note A#, 1
	note E_, 1
	note A#, 1
	note E_, 1
	note A#, 1
	note E_, 1
	note A#, 1
	note E_, 1
	note A#, 1
	note E_, 1
	note A#, 1
	note E_, 1
	note A#, 1
	note E_, 1
	note A#, 4
	note_type 3, 9, 2
	rest 12
	note F_, 1
	octave 6
	note C#, 7
	octave 5
	note C#, 1
	note A_, 7
	note B_, 1
	octave 6
	note D#, 7
	octave 5
	note D#, 1
	note G_, 7
	rest 16
	note A#, 2
	note B_, 2
	note A#, 4
	octave 4
	note A_, 2
	note A#, 2
	note A_, 4
	octave 5
	note A_, 2
	note A#, 2
	note A_, 4
	rest 8
	note E_, 1
	octave 4
	note A#, 1
	note E_, 1
	octave 3
	volume_envelope 7, 2
	note A#, 1
	volume_envelope 5, 2
	note E_, 1
	volume_envelope 3, 2
	octave 2
	note A#, 3
	duty_cycle 0
	note_type 12, 7, 4
	octave 3
	rest 2
	note E_, 1
	note D_, 1
	note A_, 3
	note E_, 1
	note D_, 1
	octave 2
	note A_, 1
	octave 3
	note A_, 2
	note C#, 1
	octave 2
	note A_, 1
	octave 3
	note E_, 1
	note C#, 1
	note A_, 3
	note E_, 1
	note D_, 1
	octave 2
	note A_, 1
	octave 3
	note A_, 2
	octave 2
	note A#, 1
	note A_, 1
	octave 3
	note E_, 1
	note D_, 1
	note A_, 3
	note E_, 1
	note D_, 1
	octave 2
	note A_, 1
	octave 3
	note A_, 2
	octave 2
	note A_, 2
	octave 3
	note D_, 2
	note E_, 2
	note F_, 2
	note G_, 2
	note A_, 4
	octave 4
	note D_, 1
	note C_, 1
	note G_, 3
	note D_, 1
	note C_, 1
	octave 3
	note G_, 1
	octave 4
	note G_, 2
	octave 3
	note C_, 1
	note G_, 1
	octave 4
	note D_, 1
	note C_, 1
	note G_, 3
	note D_, 1
	note C_, 1
	octave 3
	note G_, 1
	octave 4
	note G_, 4
	note D_, 1
	note C_, 1
	note G_, 3
	note D_, 1
	note C_, 1
	octave 3
	note G_, 1
	octave 4
	note G_, 4
	note_type 6, 7, 2
	octave 5
	note C_, 1
	octave 4
	note G_, 1
	note C_, 1
	octave 3
	note F#, 1
	note C_, 1
	octave 2
	note F#, 1
	note D_, 1
	octave 1
	note G_, 1
	note C_, 4
	note_type 12, 7, 4
	octave 4
	note G_, 4
	rest 2
	volume_envelope 9, 4
	octave 3
	note D_, 1
	note D_, 1
	note D_, 1
	rest 1
	note G_, 1
	rest 1
	note F#, 1
	rest 1
	note C#, 1
	rest 3
	note B_, 1
	rest 2
	note B_, 1
	note A#, 1
	octave 2
	note A#, 1
	rest 1
	note A#, 1
	rest 2
	octave 3
	volume_envelope 9, 0
	note G_, 5
	volume_envelope 9, 4
	note G_, 3
	note D_, 1
	note F#, 1
	note D#, 1
	rest 1
	note D_, 1
	rest 7
	note F#, 1
	rest 1
	note G_, 1
	rest 3
	octave 4
	duty_cycle 3
	note C_, 1
	note D_, 1
	note D#, 1
	octave 5
	note C_, 1
	octave 4
	note A#, 1
	rest 1
	duty_cycle 0
	octave 3
	note D_, 1
	rest 1
	duty_cycle 3
	octave 5
	note C_, 2
	rest 2
	duty_cycle 0
	octave 3
	note C#, 1
	rest 1
	note B_, 1
	note C#, 1
	octave 2
	note A#, 1
	note A#, 1
	rest 1
	note A#, 1
	rest 2
	octave 3
	duty_cycle 3
	note D_, 2
	note D#, 2
	note A_, 2
	octave 4
	note D#, 2
	duty_cycle 0
	octave 3
	note D_, 1
	note D_, 1
	note D#, 1
	rest 9
	note F#, 1
	rest 1
	note G_, 1
	rest 3
	duty_cycle 2
	octave 3
	volume_envelope 7, 0
	note D_, 1
	note G_, 1
	note D_, 1
	note G_, 1
	note D_, 1
	note G_, 1
	note D_, 1
	note G_, 1
	octave 4
	note D_, 1
	note G#, 1
	note D_, 1
	note G#, 1
	note C#, 1
	note F#, 1
	note C#, 1
	note F#, 1
	note G_, 1
	note D_, 1
	note G_, 1
	note D_, 1
	note G#, 1
	note C#, 1
	note G_, 1
	note D_, 1
	note G_, 1
	note C#, 1
	note G#, 1
	note C#, 1
	note G#, 1
	note C#, 1
	note G_, 1
	note D_, 1
	volume_envelope 5, 0
	note G_, 1
	volume_envelope 3, 0
	note D_, 1
	volume_envelope 9, 0
	duty_cycle 0
	sound_call Music_MotherBeastBattleSM_Ch2_branch_3
	sound_jump Music_MotherBeastBattleSM_Ch2_loop_main

Music_MotherBeastBattleSM_Ch2_branch_1:
	note D_, 1
	note E_, 1
	note F_, 1
	note D_, 1
	note G_, 1
	note E_, 1
	note F_, 1
	note D_, 1
	note E_, 1
	note C_, 1
	note D_, 1
	sound_ret

Music_MotherBeastBattleSM_Ch2_branch_2:
	note D_, 1
	note E_, 1
	note F_, 1
	note D_, 1
	note G_, 1
	note E_, 1
	note D_, 1
	note E_, 1
	note F_, 1
	note G_, 1
	note E_, 1
	note F_, 1
	sound_ret

Music_MotherBeastBattleSM_Ch2_branch_3:
	octave 4
	note G_, 1
	note G#, 1
	note D_, 1
	note G_, 1
	octave 3
	note G_, 1
	octave 4
	note C#, 1
	octave 3
	note B_, 1
	note F#, 1
	octave 2
	note B_, 1
	octave 3
	note B_, 1
	note D#, 1
	note A_, 1
	sound_ret

Music_MotherBeastBattleSM_Ch3:
	note_type 12, 1, 9
	octave 2
	rest 4
	note D_, 16
	note D_, 8
	volume_envelope 2, 9
	note D_, 4
	volume_envelope 3, 9
	note D_, 2
	volume_envelope 1, 9
	note G#, 11
	volume_envelope 2, 9
	note G#, 2
	volume_envelope 3, 9
	note G#, 2
	rest 5
	octave 1
	volume_envelope 2, 9
	note A#, 12
	note A#, 9
	volume_envelope 3, 9
	note A#, 3
Music_MotherBeastBattleSM_Ch3_loop_main:
	rest 12
	rest 12
	rest 12
	volume_envelope 1, 9
	octave 2
	note A_, 1
	rest 1
	note A#, 1
	rest 1
	note G_, 1
	rest 2
	note A_, 1
	note D_, 1
	rest 1
	note E_, 1
	rest 1
	volume_envelope 2, 9
	octave 2
	note D_, 12
	note D#, 12
	note D_, 12
	note D_, 12
	note_type 6, 1, 9
	note A_, 1
	rest 1
	note A_, 2
	rest 2
	note A_, 2
	rest 12
	note A_, 4
	note A#, 1
	rest 1
	note A#, 1
	rest 1
	note A#, 2
	rest 2
	note A#, 2
	rest 10
	note A#, 4
	note B_, 1
	rest 1
	note B_, 2
	rest 2
	note B_, 2
	rest 12
	note B_, 4
	note A_, 2
	rest 2
	note A#, 2
	rest 2
	note G_, 2
	rest 4
	note A_, 2
	note D_, 2
	rest 2
	note E_, 2
	rest 2
	note_type 12, 1, 9
	octave 2
	note A_, 12
	note G#, 12
	note B_, 12
	octave 1
	note B_, 12
	octave 2
	volume_envelope 2, 9
	note D_, 12
	note C#, 12
	note C_, 12
	octave 1
	note B_, 8
	note A#, 4
	note G_, 12
	note B_, 8
	note A#, 3
	rest 1
	note A#, 8
	note G#, 4
	note G_, 7
	rest 1
	note G_, 4
	volume_envelope 1, 9
	octave 2
Music_MotherBeastBattleSM_Ch3_loop_1:
	note C_, 4
	rest 2
	sound_loop 16, Music_MotherBeastBattleSM_Ch3_loop_1
	octave 1
	volume_envelope 2, 9
Music_MotherBeastBattleSM_Ch3_loop_2:
	note C_, 4
	rest 2
	sound_loop 6, Music_MotherBeastBattleSM_Ch3_loop_2
	note C_, 1
	rest 11
	sound_jump Music_MotherBeastBattleSM_Ch3_loop_main

Music_MotherBeastBattleSM_Ch4:
	toggle_noise 3
	sound_call Music_MotherBeastBattleSM_Ch4_buildup
	drum_note 1, 2 ;
	drum_note 2, 1
	drum_note 2, 3
	drum_note 1, 2
	drum_note 2, 1 ;
	drum_note 7, 2
	drum_note 7, 1
	drum_note 2, 1
	drum_note 7, 1
	drum_note 5, 4 ;
	drum_note 2, 1
	drum_note 7, 1
	drum_note 7, 1
	drum_note 7, 2
	drum_note 7, 1
	drum_note 1, 2 ;
	drum_note 7, 1
	drum_note 7, 1
	drum_note 5, 2
	drum_note 5, 2
	drum_note 1, 1 ;
	drum_note 2, 1
	drum_note 2, 1
	drum_note 1, 1
	drum_note 2, 1
	drum_note 2, 1
	drum_note 1, 2
	drum_note 5, 3 ;
	drum_note 7, 1
	drum_note 2, 2
	drum_note 2, 2
	drum_note 7, 1 ;
	drum_note 2, 1
	drum_note 11, 2
	drum_note 2, 1
	drum_note 2, 3
	drum_note 11, 4 ;
	drum_note 1, 16
	rest 2
	drum_note 7, 2
	drum_note 5, 6
	drum_note 1, 1
	drum_note 1, 1
	drum_note 1, 1
	drum_note 1, 1
	drum_note 12, 12
	rest 12
	rest 12
	rest 14
Music_MotherBeastBattleSM_Ch4_loop_main:
	sound_call Music_MotherBeastBattleSM_Ch4_buildup
	sound_call Music_MotherBeastBattleSM_Ch4_branch_1
	sound_call Music_MotherBeastBattleSM_Ch4_branch_2
	sound_call Music_MotherBeastBattleSM_Ch4_branch_1
	sound_call Music_MotherBeastBattleSM_Ch4_branch_3
	sound_call Music_MotherBeastBattleSM_Ch4_branch_1
	sound_call Music_MotherBeastBattleSM_Ch4_branch_2
	sound_call Music_MotherBeastBattleSM_Ch4_branch_1
	sound_call Music_MotherBeastBattleSM_Ch4_branch_3
	drum_speed 12
	drum_note 1, 12
	drum_note 4, 12
	drum_note 4, 12
	drum_note 4, 6
	drum_note 4, 2
	drum_note 1, 4
	drum_note 1, 12
	drum_note 4, 12
	drum_note 4, 12
	drum_note 4, 6
	drum_note 4, 2
	drum_note 1, 4
Music_MotherBeastBattleSM_Ch4_loop_1:
	drum_note 1, 3
	drum_note 1, 3
	drum_note 1, 3
	drum_note 1, 1
	drum_note 4, 2
	sound_loop 11, Music_MotherBeastBattleSM_Ch4_loop_1
	drum_note 1, 8
	sound_jump Music_MotherBeastBattleSM_Ch4_loop_main

Music_MotherBeastBattleSM_Ch4_branch_1:
	drum_note 1, 6
	drum_note 1, 2
	drum_note 4, 2
	drum_note 4, 1
	drum_note 4, 1
	drum_note 1, 2
	drum_note 4, 2
	drum_note 5, 2
	drum_note 1, 2
	drum_note 5, 1
	drum_note 5, 1
	drum_note 4, 2
	drum_note 1, 2
	drum_note 4, 2
	drum_note 1, 2
	drum_note 9, 1
	drum_note 9, 1
	drum_note 1, 2
	drum_note 7, 2
	drum_note 7, 2
	drum_note 1, 2
	drum_note 4, 2
	drum_note 5, 1
	drum_note 5, 1
	drum_note 1, 2
	drum_note 4, 2
	sound_ret

Music_MotherBeastBattleSM_Ch4_branch_2:
	drum_note 1, 2
	drum_note 4, 2
	drum_note 5, 1
	drum_note 5, 1
	drum_note 1, 2
	drum_note 7, 2
	drum_note 4, 1
	drum_note 5, 1
	drum_note 1, 2
	drum_note 7, 1
	drum_note 7, 1
	drum_note 2, 2
	drum_note 1, 2
	drum_note 7, 1
	drum_note 7, 1
	drum_note 2, 2
	drum_note 1, 4
	drum_note 1, 4
	drum_note 1, 2
	drum_note 4, 2
	drum_note 4, 2
	drum_note 1, 2
	drum_note 1, 2
	drum_note 4, 2
	drum_note 1, 2
	drum_note 4, 2
	sound_ret

Music_MotherBeastBattleSM_Ch4_branch_3:
	drum_note 1, 6
	drum_note 1, 2
	drum_note 4, 2
	drum_note 4, 1
	drum_note 4, 1
	drum_note 1, 2
	drum_note 4, 2
	drum_note 5, 2
	drum_note 1, 2
	drum_note 5, 1
	drum_note 5, 1
	drum_note 4, 2
	drum_note 1, 2
	drum_note 4, 2
	drum_note 1, 2
	drum_note 9, 1
	drum_note 9, 1
	drum_note 1, 2
	drum_note 7, 2
	drum_note 7, 2
	drum_note 1, 2
	drum_note 4, 2
	drum_note 1, 2
	drum_note 1, 1
	drum_note 5, 3
	sound_ret

Music_MotherBeastBattleSM_Ch4_buildup:
	drum_speed 3
	drum_note 8, 1
	drum_note 8, 1
	drum_note 8, 1
	drum_note 8, 1
	drum_note 8, 1
	drum_note 8, 1
	drum_note 8, 1
	drum_note 8, 1
	drum_note 7, 1
	drum_note 7, 1
	drum_note 7, 1
	drum_note 7, 1
	drum_note 7, 1
	drum_note 7, 1
	drum_note 7, 1
	drum_note 7, 1
	drum_speed 6
	sound_ret
