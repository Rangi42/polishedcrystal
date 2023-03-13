; Pokémon OR/AS - Battle! Zinnia
; Demixed by Mmmmmm
; https://pastebin.com/fsqpcGL3
; https://hax.iimarckus.org/topic/6777/4/

Music_ZinniaBattleORAS:
	channel_count 4
	channel 1, Music_ZinniaBattleORAS_Ch1
	channel 2, Music_ZinniaBattleORAS_Ch2
	channel 3, Music_ZinniaBattleORAS_Ch3
	channel 4, Music_ZinniaBattleORAS_Ch4

Music_ZinniaBattleORAS_Ch1:
	tempo 212
	volume 7, 7
	duty_cycle 1
	pitch_offset 2
	vibrato 8, 1, 5
	note_type 3, 11, 3
	octave 4
	note C#, 12
	rest 12
	octave 3
	note C#, 4
	note D_, 1
	note D#, 1
	note E_, 1
	note F_, 1
	note_type 6, 11, 0
	octave 4
	note C#, 12
	volume_envelope 11, 3
	note C#, 4
	duty_cycle 2
Music_ZinniaBattleORAS_Ch1_loop_1:
	sound_call Music_ZinniaBattleORAS_Ch1_branch_1
	sound_loop 4, Music_ZinniaBattleORAS_Ch1_loop_1
Music_ZinniaBattleORAS_Ch1_loop_main:
Music_ZinniaBattleORAS_Ch1_loop_2:
	sound_call Music_ZinniaBattleORAS_Ch1_branch_1
	sound_loop 4, Music_ZinniaBattleORAS_Ch1_loop_2
	duty_cycle 0
	note_type 6, 8, 0
	note D_, 8
	volume_envelope 8, 7
	note D_, 8
	volume_envelope 8, 0
	note C_, 3
	volume_envelope 8, 7
	note C_, 5
	volume_envelope 8, 0
	note F_, 6
	note E_, 1
	note D#, 1
	volume_envelope 8, 0
	note D_, 8
	volume_envelope 8, 7
	note D_, 6
	note G_, 1
	note A_, 1
	volume_envelope 8, 0
	note A#, 6
	note A_, 6
	note F_, 4
	volume_envelope 8, 0
	note G_, 8
	volume_envelope 8, 7
	note G_, 6
	note F#, 1
	note D_, 1
	volume_envelope 8, 0
	note C_, 3
	volume_envelope 8, 7
	note C_, 5
	volume_envelope 8, 0
	note F_, 3
	volume_envelope 8, 7
	note F_, 5
	volume_envelope 8, 0
	note D_, 16
	volume_envelope 8, 7
	note D_, 14
	volume_envelope 7, 0
	note G_, 1
	note A_, 1
	note_type 6, 7, -7
	octave 3
	note G_, 1
	volume_envelope 9, 0
	note G_, 7
	volume_envelope 9, 5
	note G_, 8
	volume_envelope 7, -7
	note F#, 1
	volume_envelope 9, 0
	note F#, 3
	volume_envelope 9, 5
	note F#, 4
	volume_envelope 7, -7
	note A_, 1
	volume_envelope 9, 0
	note A_, 3
	volume_envelope 9, 5
	note A_, 4
	volume_envelope 9, 0
	note G#, 3
	volume_envelope 9, 5
	note G#, 5
	volume_envelope 9, 0
	note G_, 3
	volume_envelope 9, 5
	note G_, 5
	volume_envelope 9, 0
	note F#, 3
	volume_envelope 9, 5
	note F#, 5
	volume_envelope 9, 0
	note G#, 3
	volume_envelope 9, 5
	note G#, 5
	volume_envelope 9, 0
	note A#, 8
	volume_envelope 9, 5
	note A#, 6
	note F_, 1
	note D#, 1
	volume_envelope 9, 0
	note D_, 3
	volume_envelope 9, 5
	note D_, 5
	volume_envelope 9, 0
	note A#, 3
	volume_envelope 9, 5
	note A#, 4
	note F_, 1
	volume_envelope 7, -7
	note G_, 1
	volume_envelope 9, 0
	note G_, 15
	volume_envelope 9, 7
	note G_, 16
	volume_envelope 9, 0
	note A#, 12
	volume_envelope 9, 5
	note A#, 4
	volume_envelope 9, 0
	note A_, 6
	volume_envelope 9, 5
	note A_, 2
	note A#, 4
	octave 4
	note C_, 4
	octave 3
	note A_, 1
	volume_envelope 9, 0
	note A#, 9
	volume_envelope 9, 5
	note A#, 4
	note A_, 1
	note G_, 1
	volume_envelope 9, 0
	note D#, 10
	volume_envelope 9, 5
	note D#, 5
	note D_, 1
	volume_envelope 9, 0
	note D#, 10
	volume_envelope 9, 5
	note D#, 6
	note_type 8, 9, 4
	note C_, 1
	octave 2
	note G_, 1
	octave 3
	note C_, 1
	note D_, 1
	octave 2
	note G_, 1
	octave 3
	note D_, 1
	note D#, 1
	octave 2
	note G_, 1
	octave 3
	note D#, 1
	note D#, 1
	note F_, 1
	note G_, 1
	note_type 6, 9, 0
	note A#, 8
	volume_envelope 9, 5
	note A#, 6
	octave 4
	note C_, 1
	octave 3
	note A#, 1
	volume_envelope 9, 0
	note A_, 8
	volume_envelope 9, 7
	note A_, 8
	duty_cycle 3
	volume_envelope 7, 0
	note F#, 8
	volume_envelope 7, 7
	note F#, 8
	volume_envelope 7, 0
	note G#, 8
	volume_envelope 7, 7
	note G#, 8
	volume_envelope 7, 0
	note A_, 8
	volume_envelope 7, 7
	note A_, 8
	volume_envelope 7, 0
	note B_, 8
	volume_envelope 7, 7
	note B_, 8
	octave 4
	volume_envelope 7, 0
	note D_, 8
	volume_envelope 7, 7
	note D_, 8
	volume_envelope 7, 0
	note C#, 8
	volume_envelope 7, 7
	note C#, 8
	octave 3
	volume_envelope 7, 0
	note B_, 8
	volume_envelope 7, 7
	note B_, 8
	volume_envelope 7, 0
	note G#, 8
	volume_envelope 7, 7
	note G#, 8
	volume_envelope 10, 0
	octave 4
	sound_call Music_ZinniaBattleORAS_Ch1_branch_2
	note A_, 2
	rest 4
	note A_, 2
	rest 4
	note A_, 2
	rest 4
	note G#, 2
	rest 4
	note G#, 2
	rest 2
	note G#, 2
	rest 2
	sound_call Music_ZinniaBattleORAS_Ch1_branch_2
	sound_call Music_ZinniaBattleORAS_Ch1_branch_3
	sound_call Music_ZinniaBattleORAS_Ch1_branch_3
	duty_cycle 2
Music_ZinniaBattleORAS_Ch1_loop_3:
	sound_call Music_ZinniaBattleORAS_Ch1_branch_1
	sound_loop 3, Music_ZinniaBattleORAS_Ch1_loop_3
	sound_jump Music_ZinniaBattleORAS_Ch1_loop_main

Music_ZinniaBattleORAS_Ch1_branch_1:
	volume_envelope 10, 1
	note C#, 2
	note E_, 2
	note B_, 2
	note A_, 2
	note G#, 2
	note A_, 2
	note F#, 2
	note C#, 2
	note F#, 2
	note C#, 2
	note F#, 2
	note B_, 2
	note A_, 1
	note G#, 1
	note F#, 2
	note G#, 2
	note E_, 2
	sound_ret

Music_ZinniaBattleORAS_Ch1_branch_2:
	note F#, 2
	rest 4
	note F#, 2
	rest 4
	note F#, 2
	rest 4
	note G#, 2
	rest 4
	note G#, 2
	rest 2
	note G#, 2
	rest 2
	note A_, 2
	rest 4
	note A_, 2
	rest 4
	note A_, 2
	rest 4
	note B_, 2
	rest 4
	note B_, 2
	rest 2
	note B_, 2
	rest 2
	sound_ret

Music_ZinniaBattleORAS_Ch1_branch_3:
	note B_, 2
	rest 4
	note B_, 2
	rest 4
	note B_, 2
	rest 4
	note B_, 2
	rest 4
	note B_, 2
	rest 2
	note B_, 2
	rest 2
	sound_ret

Music_ZinniaBattleORAS_Ch2:
	duty_cycle 3
	vibrato 18, 3, 3
	note_type 3, 14, 3
	octave 3
	note G#, 2
	octave 4
	note B_, 2
	note A_, 2
	note G#, 2
	note F#, 2
	note A_, 2
	note G#, 2
	note F#, 2
	note E_, 2
	note G#, 2
	note F#, 2
	note E_, 2
	note D_, 2
	note F#, 2
	note E_, 2
	note D_, 2
	note C#, 2
	note E_, 2
	note D_, 2
	note C#, 2
	octave 3
	note B_, 2
	octave 4
	note D_, 2
	note C#, 2
	octave 3
	note B_, 2
	note A_, 2
	octave 4
	note C#, 2
	octave 3
	note B_, 2
	note A_, 2
	note G#, 2
	note B_, 2
	note A_, 2
	note G#, 2
	note_type 6, 10, 0
	duty_cycle 0
	octave 3
	note F#, 16
	note G#, 14
	note F#, 1
	note G#, 1
	note A_, 14
	note G#, 1
	note A_, 1
	note B_, 16
	octave 4
	note C#, 12
	note_type 3, 10, 0
	note E_, 6
	note D#, 1
	note D_, 1
	note_type 6, 10, 0
	note C#, 12
	note G#, 4
	note A_, 14
	note G#, 1
	note A_, 1
	note B_, 8
	octave 5
	note C#, 4
Music_ZinniaBattleORAS_Ch2_loop:
	note_type 6, 10, 0
	duty_cycle 3
	octave 3
	note C#, 2
	note D_, 1
	note E_, 1
	note_type 12, 10, -7
	note F#, 2
	volume_envelope 12, 0
	note F#, 3
	volume_envelope 12, 5
	note F#, 4
	volume_envelope 12, 7
	note G#, 3
	note A_, 2
	octave 4
	note_type 6, 12, 0
	note E_, 2
	note D#, 1
	note D_, 1
	vibrato 18, 5, 4
	note_type 12, 12, 0
	note C#, 5
	volume_envelope 12, 5
	note C#, 4
	vibrato 18, 3, 3
	volume_envelope 12, 1
	octave 3
	note B_, 1
	octave 4
	note C#, 1
	octave 3
	note B_, 1
	volume_envelope 12, 6
	note A_, 1
	volume_envelope 12, 1
	note B_, 1
	note A_, 1
	note G#, 1
	volume_envelope 10, -7
	note F#, 1
	volume_envelope 12, 0
	note F#, 3
	volume_envelope 12, 7
	note F#, 5
	volume_envelope 13, 5
	note G#, 3
	volume_envelope 12, 7
	note F#, 2
	note E_, 2
	volume_envelope 12, 0
	note C#, 8
	volume_envelope 12, 7
	note C#, 6
	note_type 6, 10, 0
	note D_, 2
	note D#, 1
	note F_, 1
	note_type 12, 10, -7
	note G_, 2
	volume_envelope 12, 0
	note G_, 3
	volume_envelope 12, 5
	note G_, 4
	volume_envelope 12, 7
	note A_, 3
	note A#, 2
	octave 4
	note_type 6, 12, 0
	note F_, 2
	note E_, 1
	note D#, 1
	vibrato 18, 5, 4
	note_type 12, 12, 0
	note D_, 5
	volume_envelope 12, 5
	note D_, 4
	vibrato 18, 3, 3
	volume_envelope 12, 1
	note C_, 1
	note D_, 1
	note C_, 1
	volume_envelope 12, 6
	octave 3
	note A#, 1
	volume_envelope 12, 1
	octave 4
	note C_, 1
	octave 3
	note A#, 1
	note A_, 1
	volume_envelope 10, -7
	note G_, 1
	volume_envelope 12, 0
	note G_, 3
	volume_envelope 12, 7
	note G_, 5
	volume_envelope 13, 5
	note A_, 3
	volume_envelope 12, 7
	note G_, 2
	note F_, 2
	volume_envelope 12, 0
	note D_, 8
	volume_envelope 12, 7
	note D_, 8
	duty_cycle 0
	note_type 6, 7, -7
	octave 4
	note A#, 1
	volume_envelope 9, 0
	note A#, 7
	volume_envelope 9, 5
	note A#, 8
	volume_envelope 7, -7
	note A_, 1
	volume_envelope 9, 0
	note A_, 3
	volume_envelope 9, 5
	note A_, 4
	volume_envelope 7, -7
	octave 5
	note C_, 1
	volume_envelope 9, 0
	note C_, 3
	volume_envelope 9, 5
	note C_, 4
	volume_envelope 9, 0
	octave 4
	note B_, 3
	volume_envelope 9, 5
	note B_, 5
	volume_envelope 9, 0
	note E_, 3
	volume_envelope 9, 5
	note E_, 5
	volume_envelope 9, 0
	note D#, 3
	volume_envelope 9, 5
	note D#, 5
	volume_envelope 9, 0
	note G#, 3
	volume_envelope 9, 5
	note G#, 5
	volume_envelope 9, 0
	note G_, 8
	volume_envelope 9, 5
	note G_, 6
	note F_, 1
	note D#, 1
	volume_envelope 9, 0
	note D_, 3
	volume_envelope 9, 5
	note D_, 5
	volume_envelope 9, 0
	note F_, 3
	volume_envelope 9, 5
	note F_, 4
	note C_, 1
	volume_envelope 7, -7
	note D_, 1
	volume_envelope 9, 0
	note D_, 15
	volume_envelope 9, 7
	note D_, 16
	volume_envelope 9, 0
	note A#, 12
	volume_envelope 9, 5
	note A#, 4
	volume_envelope 9, 0
	note A_, 6
	volume_envelope 9, 5
	note A_, 2
	note A#, 4
	octave 5
	note C_, 4
	octave 4
	note A_, 1
	volume_envelope 9, 0
	note A#, 9
	volume_envelope 9, 5
	note A#, 4
	note A_, 1
	note G_, 1
	volume_envelope 9, 0
	note D#, 10
	volume_envelope 9, 5
	note D#, 5
	note D_, 1
	volume_envelope 9, 0
	note D#, 10
	volume_envelope 9, 5
	note D#, 6
	note_type 8, 9, 4
	note C_, 1
	octave 3
	note G_, 1
	octave 4
	note C_, 1
	note D_, 1
	octave 3
	note G_, 1
	octave 4
	note D_, 1
	note D#, 1
	octave 3
	note G_, 1
	octave 4
	note D#, 1
	note D#, 1
	note F_, 1
	note G_, 1
	note_type 6, 9, 0
	note A#, 8
	volume_envelope 9, 5
	note A#, 6
	octave 5
	note C_, 1
	octave 4
	note A#, 1
	volume_envelope 9, 0
	note A_, 8
	volume_envelope 9, 7
	note A_, 8
	volume_envelope 11, 0
	note F#, 8
	volume_envelope 11, 5
	note F#, 4
	note_type 8, 11, 4
	note F#, 1
	note C#, 1
	note F#, 1
	note G#, 1
	note C#, 1
	note G#, 1
	note A_, 1
	note C#, 1
	note A_, 1
	note B_, 1
	note C#, 1
	note B_, 1
	note_type 6, 11, 4
	octave 5
	note E_, 2
	octave 4
	note E_, 1
	note D#, 1
	volume_envelope 11, 0
	note E_, 8
	volume_envelope 11, 6
	note E_, 6
	note D_, 1
	note C#, 1
	volume_envelope 11, 0
	note D_, 5
	volume_envelope 11, 4
	note D_, 3
	volume_envelope 11, 0
	note E_, 5
	volume_envelope 11, 4
	note E_, 3
	volume_envelope 11, 0
	note F#, 8
	volume_envelope 11, 6
	note F#, 6
	note E_, 1
	note D#, 1
	volume_envelope 11, 0
	note E_, 5
	volume_envelope 11, 4
	note E_, 3
	volume_envelope 11, 0
	note C#, 5
	volume_envelope 11, 4
	note C#, 3
	volume_envelope 11, 0
	note D_, 5
	volume_envelope 11, 4
	note D_, 3
	note_type 8, 11, 4
	octave 3
	note B_, 1
	note D_, 1
	note F#, 1
	note B_, 1
	note D_, 1
	note F#, 1
	note_type 12, 11, 0
	octave 4
	note C#, 4
	volume_envelope 11, 4
	note C#, 3
	duty_cycle 3
	vibrato 18, 5, 3
	note_type 3, 12, 0
	note D_, 1
	note D#, 1
	volume_envelope 13, 0
	note E_, 1
	note F_, 1
	octave 4
	volume_envelope 14, 0
	note F#, 8
	note_type 6, 14, 7
	note F#, 8
	volume_envelope 14, 5
	note A_, 4
	volume_envelope 14, 7
	note G#, 6
	note E_, 6
	note F#, 2
	note E_, 1
	note D_, 1
	note C#, 12
	octave 3
	volume_envelope 12, 7
	note B_, 4
	octave 4
	note C#, 8
	octave 3
	note B_, 6
	octave 4
	note C#, 1
	octave 3
	note B_, 1
	note_type 12, 14, 7
	note F#, 6
	octave 4
	note C#, 2
	octave 3
	note B_, 3
	note A_, 3
	note G#, 2
	note F#, 6
	octave 4
	note C#, 2
	octave 3
	note B_, 2
	octave 4
	note C#, 2
	note D_, 2
	note E_, 2
	note F#, 6
	note A_, 2
	note G#, 2
	note E_, 2
	note C#, 2
	note G#, 2
	volume_envelope 14, 0
	note F#, 8
	volume_envelope 14, 7
	note F#, 9
	note_type 6, 12, 4
	octave 3
	note A_, 2
	note B_, 2
	note A_, 2
	note G#, 3
	note A_, 1
	note F#, 2
	note E_, 2
	note F#, 2
	note A_, 2
	note G#, 2
	note E_, 2
	note F#, 2
	note E_, 2
	note C#, 4
	rest 2
	note C#, 2
	note F#, 2
	note G_, 2
	note A_, 3
	note G_, 2
	rest 1
	note F#, 2
	note E_, 2
	note G_, 2
	note F#, 2
	note E_, 2
	note F#, 2
	note F#, 2
	note E_, 6

	note C#, 2
	note F#, 2
	note G_, 2
	note A_, 3
	note G_, 2
	rest 1
	note F#, 2
	note E_, 2
	note G_, 2
	note F#, 2
	note E_, 2
	note F#, 2
	note B_, 2
	note E_, 6
	note C#, 2
	note F#, 2
	note G_, 2
	note A_, 3
	note G_, 2
	rest 1
	note F#, 2
	note F#, 2
	note A_, 2
	note G#, 2
	note E_, 2
	note F#, 2
	note E_, 2
	sound_jump Music_ZinniaBattleORAS_Ch2_loop

Music_ZinniaBattleORAS_Ch3:
	note_type 3, 1, 9
	vibrato 18, 1, 5
	octave 2
	note G#, 8
	rest 16
	note F#, 4
	note G_, 1
	note G#, 1
	note A_, 1
	note A#, 1
	note D_, 16
	note E_, 16
	note_type 6, 1, 9
	octave 2
	note C#, 16
	note E_, 14
	note D_, 1
	note E_, 1
	note F#, 14
	note E_, 1
	note F#, 1
	note G#, 16
	note A_, 12
	note_type 3, 1, 9
	octave 3
	note C#, 6
	note C_, 1
	octave 2
	note B_, 1
	note_type 6, 1, 9
	note A_, 12
	octave 3
	note E_, 4
	note F#, 14
	note E_, 1
	note F#, 1
	note E_, 8
	note F#, 8
Music_ZinniaBattleORAS_Ch3_loop_main:
Music_ZinniaBattleORAS_Ch3_loop_1:
	volume_envelope 1, 9
	octave 2
	note F#, 2
	octave 1
	volume_envelope 2, 9
	note F#, 1
	rest 1
	note F#, 1
	rest 1
	volume_envelope 1, 9
	octave 2
	note F#, 2
	octave 1
	volume_envelope 2, 9
	note F#, 1
	rest 1
	note F#, 1
	rest 1
	volume_envelope 1, 9
	octave 2
	note F#, 2
	octave 1
	volume_envelope 2, 9
	note F#, 1
	rest 1
	note F#, 1
	rest 1
	volume_envelope 1, 9
	octave 2
	note A_, 2
	octave 1
	volume_envelope 2, 9
	note F#, 1
	rest 1
	note F#, 1
	rest 1
	volume_envelope 1, 9
	octave 2
	note G#, 2
	octave 1
	volume_envelope 2, 9
	note F#, 1
	rest 1
	volume_envelope 1, 9
	octave 2
	note G_, 2
	octave 1
	volume_envelope 2, 9
	note F#, 1
	rest 1
	sound_loop 4, Music_ZinniaBattleORAS_Ch3_loop_1
Music_ZinniaBattleORAS_Ch3_loop_2:
	volume_envelope 1, 9
	octave 2
	note G_, 2
	octave 1
	volume_envelope 2, 9
	note G_, 1
	rest 1
	note G_, 1
	rest 1
	volume_envelope 1, 9
	octave 2
	note G_, 2
	octave 1
	volume_envelope 2, 9
	note G_, 1
	rest 1
	note G_, 1
	rest 1
	volume_envelope 1, 9
	octave 2
	note G_, 2
	octave 1
	volume_envelope 2, 9
	note G_, 1
	rest 1
	note G_, 1
	rest 1
	volume_envelope 1, 9
	octave 2
	note A#, 2
	octave 1
	volume_envelope 2, 9
	note G_, 1
	rest 1
	note G_, 1
	rest 1
	volume_envelope 1, 9
	octave 2
	note A_, 2
	octave 1
	volume_envelope 2, 9
	note G_, 1
	rest 1
	volume_envelope 1, 9
	octave 2
	note G#, 2
	octave 1
	volume_envelope 2, 9
	note G_, 1
	rest 1
	sound_loop 12, Music_ZinniaBattleORAS_Ch3_loop_2
	octave 2
	volume_envelope 2, 9
	note D_, 12
	volume_envelope 3, 9
	note D_, 4
	volume_envelope 2, 9
	note E_, 12
	volume_envelope 3, 9
	note E_, 4
	volume_envelope 2, 9
	note F#, 12
	volume_envelope 3, 9
	note F#, 4
	volume_envelope 2, 9
	note G_, 11
	rest 1
	note G_, 4
	volume_envelope 1, 9
	note D_, 2
	rest 3
	note F_, 1
	note F#, 6
	octave 3
	note F#, 4
	octave 2
	note C#, 4
	rest 4
	octave 1
	note A_, 4
	octave 2
	note A_, 4
	octave 1
	note B_, 2
	rest 4
	note B_, 6
	octave 2
	note B_, 4
	note G#, 3
	rest 1
	note G#, 3
	rest 1
	note G#, 3
	rest 1
	note G#, 4
	sound_call Music_ZinniaBattleORAS_Ch3_branch_1
	note F#, 2
	rest 4
	note F#, 2
	rest 4
	note F#, 2
	rest 4
	note G_, 2
	rest 4
	note G_, 2
	rest 2
	note G_, 2
	rest 2
	note F#, 2
	rest 4
	note F#, 2
	rest 4
	note F#, 2
	rest 4
	note E_, 2
	rest 4
	note E_, 2
	rest 2
	note E_, 2
	rest 2
	sound_call Music_ZinniaBattleORAS_Ch3_branch_1
	note F#, 2
	rest 4
	note F#, 2
	rest 4
	note F#, 2
	rest 4
	note G#, 2
	rest 4
	note G#, 2
	rest 2
	note G#, 2
	rest 2
	sound_call Music_ZinniaBattleORAS_Ch3_branch_2
	sound_call Music_ZinniaBattleORAS_Ch3_branch_2
	note E_, 16
	volume_envelope 2, 9
	note E_, 12
	rest 4
	volume_envelope 1, 9
	note B_, 16
	volume_envelope 2, 9
	note B_, 12
	rest 4
	octave 3
	volume_envelope 1, 9
	note E_, 16
	note G#, 8
	note A_, 4
	note B_, 4
	sound_jump Music_ZinniaBattleORAS_Ch3_loop_main

Music_ZinniaBattleORAS_Ch3_branch_1:
	note D_, 2
	rest 4
	note D_, 2
	rest 4
	note D_, 2
	rest 4
	note E_, 2
	rest 4
	note E_, 2
	rest 2
	note E_, 2
	rest 2
	sound_ret

Music_ZinniaBattleORAS_Ch3_branch_2:
	note F#, 2
	rest 4
	note F#, 2
	rest 4
	note F#, 2
	rest 4
	note F#, 2
	rest 4
	note F#, 2
	rest 2
	note F#, 2
	rest 2
	sound_ret

Music_ZinniaBattleORAS_Ch4:
	toggle_noise 3
	drum_speed 3
	drum_note 1, 16
	rest 16
	drum_note 12, 8
	drum_note 1, 8
	sound_call Music_ZinniaBattleORAS_Ch4_branch_2
	drum_note 12, 2
	drum_note 2, 2
Music_ZinniaBattleORAS_Ch4_loop_1:
	drum_note 2, 2
	drum_note 2, 2
	sound_loop 6, Music_ZinniaBattleORAS_Ch4_loop_1
	drum_note 2, 2
	drum_speed 3
	drum_note 3, 1
	drum_note 3, 1
	drum_note 3, 1
	drum_note 3, 1
	drum_note 3, 1
	drum_note 3, 1
	drum_note 3, 1
	drum_note 3, 1
	drum_speed 12
	drum_note 12, 2
	sound_call Music_ZinniaBattleORAS_Ch4_branch_1
	drum_note 4, 1
	drum_note 3, 1
	sound_call Music_ZinniaBattleORAS_Ch4_branch_1
Music_ZinniaBattleORAS_Ch4_loop_main:
Music_ZinniaBattleORAS_Ch4_loop_2:
	drum_note 4, 1
	drum_note 3, 1
	sound_call Music_ZinniaBattleORAS_Ch4_branch_1
	sound_loop 8, Music_ZinniaBattleORAS_Ch4_loop_2
	drum_note 12, 2
	sound_call Music_ZinniaBattleORAS_Ch4_branch_1
Music_ZinniaBattleORAS_Ch4_loop_3:
	drum_note 4, 1
	drum_note 3, 1
	sound_call Music_ZinniaBattleORAS_Ch4_branch_1
	sound_loop 7, Music_ZinniaBattleORAS_Ch4_loop_3
	rest 16
	drum_note 4, 14
	drum_note 4, 2
Music_ZinniaBattleORAS_Ch4_loop_4:
	drum_note 2, 1
	drum_note 2, 1
	drum_note 1, 1
	drum_note 2, 1
	sound_loop 7, Music_ZinniaBattleORAS_Ch4_loop_4
	sound_call Music_ZinniaBattleORAS_Ch4_branch_2
	drum_note 12, 2
	sound_call Music_ZinniaBattleORAS_Ch4_branch_1
	drum_note 4, 1
	drum_note 3, 1
	sound_call Music_ZinniaBattleORAS_Ch4_branch_1
Music_ZinniaBattleORAS_Ch4_loop_5:
	drum_note 12, 2
	sound_call Music_ZinniaBattleORAS_Ch4_branch_1
	sound_loop 4, Music_ZinniaBattleORAS_Ch4_loop_5
	drum_note 4, 1
	drum_note 3, 1
	sound_call Music_ZinniaBattleORAS_Ch4_branch_1
	drum_note 12, 2
	sound_call Music_ZinniaBattleORAS_Ch4_branch_1
	drum_note 4, 1
	drum_note 3, 1
	sound_call Music_ZinniaBattleORAS_Ch4_branch_1
	drum_note 12, 2
	drum_note 1, 1
	drum_note 4, 1
	drum_note 3, 1
	drum_note 3, 1
	drum_note 1, 1
	drum_note 3, 1
	drum_note 3, 1
	drum_note 4, 1
	drum_note 1, 1
	drum_note 3, 1
	sound_call Music_ZinniaBattleORAS_Ch4_branch_2
	sound_jump Music_ZinniaBattleORAS_Ch4_loop_main

Music_ZinniaBattleORAS_Ch4_branch_1:
	drum_note 1, 1
	drum_note 4, 1
	drum_note 3, 1
	drum_note 3, 1
	drum_note 1, 1
	drum_note 3, 1
	drum_note 3, 1
	drum_note 4, 1
	drum_note 1, 1
	drum_note 3, 1
	drum_note 4, 1
	drum_note 3, 1
	drum_note 1, 1
	drum_note 3, 1
	sound_ret

Music_ZinniaBattleORAS_Ch4_branch_2:
	drum_speed 3
	drum_note 4, 2
	drum_note 4, 2
	drum_note 4, 2
	drum_note 4, 2
	drum_note 3, 1
	drum_note 3, 1
	drum_note 3, 1
	drum_note 3, 1
	drum_note 3, 1
	drum_note 3, 1
	drum_note 3, 1
	drum_note 3, 1
	drum_speed 12
	sound_ret
