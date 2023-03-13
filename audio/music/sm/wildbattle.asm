; Pokémon S/M - Battle! Wild Pokémon
; Demixed by Mmmmmm
; https://pastebin.com/WSdP1J0x
; https://hax.iimarckus.org/topic/6777/6/

Music_WildBattleSM:
	channel_count 4
	channel 1, Music_WildBattleSM_Ch1
	channel 2, Music_WildBattleSM_Ch2
	channel 3, Music_WildBattleSM_Ch3
	channel 4, Music_WildBattleSM_Ch4

Music_WildBattleSM_Ch1:
	tempo 204
	volume 7, 7
	duty_cycle 3
	pitch_offset 2
	vibrato 18, 1, 5
	note_type 6, 9, 2
	rest 4
	octave 4
	note G#, 1
	note G_, 1
	note F#, 1
	note F_, 1
	note E_, 1
	note D#, 1
	note D_, 1
	note C#, 1
	note C_, 1
	octave 3
	note B_, 1
	note A#, 1
	note A_, 1
	note G#, 1
	note G_, 1
	note F#, 1
	note F_, 1
	note A#, 1
	note A_, 1
	note G#, 1
	note G_, 1
	note F#, 1
	note F_, 1
	note E_, 1
	note D#, 1
	note D_, 1
	note C#, 1
	note C_, 1
	octave 2
	note B_, 1
	note A#, 1
	note A_, 1
	note G#, 1
	note G_, 1
	volume_envelope 10, 2
	octave 3
	note C_, 6
	octave 2
	note B_, 6
	octave 3
	note C_, 4
	note C_, 8
	volume_envelope 10, 7
	octave 2
	note F_, 8
	volume_envelope 10, 2
	octave 3
	note C#, 6
	note C_, 6
	note C#, 4
	note C#, 8
	volume_envelope 10, 7
	note F#, 8
Music_WildBattleSM_Ch1_loop_main:
	rest 8
	duty_cycle 0
	volume_envelope 10, 2
	octave 4
	note F_, 2
	note G_, 2
	octave 5
	note C_, 2
	octave 4
	note F_, 4
	octave 5
	note C_, 4
	octave 2
	volume_envelope 10, 4
	note D_, 2
	note F_, 4
	note G_, 3
	octave 4
	note F#, 1
	note A#, 4
	note A_, 2
	note A#, 4
	note A_, 2
	volume_envelope 10, 7
	note G_, 4
	octave 5
	note D#, 2
	note D_, 2
	note C_, 2
	octave 4
	note A#, 12
	octave 4
	volume_envelope 9, 2
	note F_, 4
	note F_, 2
	octave 3
	note B_, 2
	octave 4
	note C_, 10
	note F_, 6
	note F_, 4
	note F_, 2
	volume_envelope 10, 0
	note A#, 6
	volume_envelope 10, 7
	note A#, 12
	volume_envelope 4, -7
	note A#, 8
	volume_envelope 12, 2
	note A_, 4
	note A#, 2
	octave 5
	note C_, 10
	octave 4
	note F_, 4
	note F_, 4
	note A_, 4
	note A_, 4
	note D#, 6
	note D#, 6
	rest 12
	octave 3
	note A#, 4
	note A#, 4
	note A#, 2
	volume_envelope 12, 5
	note A_, 4
	volume_envelope 12, 0
	note A#, 8
	volume_envelope 12, 7
	note A#, 8
	octave 4
	note C_, 8
	note D_, 8
	volume_envelope 12, 2
	rest 4
	note G_, 8
	note F_, 8
	note D#, 6
	note D_, 4
	note D_, 2
Music_WildBattleSM_Ch1_loop_1:
	note D_, 6
	note E_, 4
	note F#, 4
	note F#, 1
	note G_, 1
	note A_, 2
	note F#, 4
	note D_, 4
	note D_, 4
	note C#, 2
	sound_loop 2, Music_WildBattleSM_Ch1_loop_1
	duty_cycle 0
	volume_envelope 12, 7
	octave 4
	note D#, 8
	note D_, 8
	note C_, 8
	octave 3
	note A#, 8
	octave 4
	note C_, 8
	octave 3
	note A#, 8
	note A_, 8
	note B_, 2
	volume_envelope 12, 2
	octave 4
	note C_, 4
	volume_envelope 12, 0
	octave 3
	note B_, 16
	volume_envelope 12, 7
	note B_, 16
	volume_envelope 6, 0
	octave 4
	note D#, 2
	note E_, 16
	note E_, 16

	octave 3
	volume_envelope 12, 2
	note C_, 2
	octave 2
	note B_, 4
	octave 3
	note C_, 4
	note C_, 4
	octave 2
	note B_, 2
	octave 3
	note C_, 2
	octave 2
	note A_, 4
	volume_envelope 12, 7
	octave 3
	note F_, 10
	volume_envelope 12, 2
	note D_, 4
	note C#, 2
	note D_, 4
	note D_, 4
	note C#, 2
	note D_, 2
	octave 2
	note A_, 4
	octave 3
	volume_envelope 12, 7
	note G_, 10
	volume_envelope 12, 0
	note E_, 16
	volume_envelope 12, 7
	note E_, 16
	octave 2
	volume_envelope 8, 0
	note E_, 16
	volume_envelope 8, 7
	note E_, 16
	rest 16
	rest 16
	rest 16
	rest 16
	sound_jump Music_WildBattleSM_Ch1_loop_main

Music_WildBattleSM_Ch2:
	duty_cycle 3
	vibrato 8, 3, 6
	pitch_offset 1
	note_type 6, 12, 2
	rest 4
Music_WildBattleSM_Ch2_loop_1:
	octave 5
	note E_, 1
	note F_, 1
	note F#, 1
	note G_, 1
	sound_loop 8, Music_WildBattleSM_Ch2_loop_1
	octave 4
	note C_, 6
	octave 3
	note B_, 6
	octave 4
	note C_, 4
	note C_, 8
	volume_envelope 12, 7
	octave 3
	note F_, 8
	volume_envelope 12, 2
	octave 4
	note C#, 6
	note C_, 6
	note C#, 4
	note C#, 8
	volume_envelope 12, 7
	note C#, 4
	octave 3
	volume_envelope 12, 2
	note G#, 1
	note A_, 1
Music_WildBattleSM_Ch2_loop_main:
	octave 3
	volume_envelope 12, 2
	note A#, 1
	note B_, 1
	octave 4
	note C_, 6
	note F_, 6
	volume_envelope 12, 4
	note A#, 4
	volume_envelope 12, 2
	note A_, 6
	note G_, 6
	volume_envelope 12, 4
	note F_, 4
	duty_cycle 0
	volume_envelope 10, 4
	note G_, 4
	note F_, 2
	note G_, 4
	note F_, 2
	volume_envelope 10, 7
	note D#, 4
	note A#, 2
	note A_, 2
	note G_, 2
	note F_, 6
	duty_cycle 3
	volume_envelope 12, 2
	note E_, 4
	note A_, 2
	note F_, 4
	note F_, 6
	note F_, 2
	note G_, 2
	note A_, 6
	octave 5
	note C_, 6
	octave 4
	note A_, 4
	volume_envelope 12, 7
	note A#, 8
	octave 5
	volume_envelope 10, 1
	note D#, 1
	octave 6
	note D#, 1
	octave 5
	note D_, 1
	octave 6
	note D_, 1
	octave 5
	note C_, 1
	octave 6
	note C_, 1
	octave 4
	note A#, 1
	octave 5
	note A#, 1
	note G_, 1
	octave 6
	note G_, 1
	octave 5
	note F_, 1
	octave 6
	note F_, 1
	octave 5
	note D#, 1
	octave 6
	note D#, 1
	octave 4
	note A#, 1
	octave 5
	note A#, 1
	octave 4
	volume_envelope 7, 1
	note A#, 1
	octave 5
	note A#, 1
	volume_envelope 12, 2
	octave 4
	note F_, 4
	note G_, 2
	volume_envelope 12, 5
	note A_, 6
	volume_envelope 12, 2
	note F_, 4
	note F_, 4
	note A_, 2
	volume_envelope 12, 7
	note A#, 6
	note A_, 6
	note G_, 2
	octave 5
	volume_envelope 12, 2
	note C_, 1
	note D_, 1
	note D#, 6
	octave 4
	note A#, 4
	note A#, 4
	octave 5
	note D_, 2
	note D#, 2
	note D_, 2
	note C_, 2
	note D_, 4
	note D_, 2
	note C_, 4
	volume_envelope 12, 0
	note D_, 8
	volume_envelope 12, 4
	note D_, 8
	note D#, 8
	note F_, 8
	note D#, 8
	note D_, 8
	note C_, 8
	octave 4
	note A#, 8
	note A_, 1
	note A#, 1
	note G_, 1
	volume_envelope 12, 0
	note A_, 6
	volume_envelope 12, 4
	note A_, 10
	rest 13
	note F#, 1
	note G_, 1
	note E_, 1
	volume_envelope 12, 0
	note F#, 6
	volume_envelope 12, 4
	note F#, 10
	rest 11
	note_type 3, 12, 1
	octave 3
	note A#, 1
	note B_, 1
	octave 4
	note C_, 1
	note D_, 1
	note_type 6, 12, 7
	note D#, 8
	note F_, 8
	note G_, 8
	note A#, 8
	note F_, 8
	note G_, 8
	note A_, 8
	note B_, 2
	volume_envelope 12, 2
	octave 5
	note C_, 4
	volume_envelope 12, 0
	octave 4
	note B_, 16
	volume_envelope 12, 7
	note B_, 16
	volume_envelope 6, 0
	octave 5
	note D#, 2
	note E_, 16
	note E_, 16
	octave 4
	volume_envelope 12, 2
	note A_, 2
	note G#, 4
	note A_, 4
	note A_, 4
	note G#, 2
	note A_, 2
	note F_, 4
	octave 5
	volume_envelope 12, 7
	note C_, 10
	octave 4
	volume_envelope 12, 2
	note B_, 4
	note A#, 2
	note B_, 4
	note B_, 4
	note A#, 2
	note B_, 2
	note G_, 4
	octave 5
	volume_envelope 12, 7
	note D_, 10
	volume_envelope 12, 0
	note C#, 16
	volume_envelope 12, 7
	note C#, 16
	volume_envelope 8, 0
	octave 4
	note A_, 16
	volume_envelope 8, 7
	note A_, 16
	rest 16
	rest 16
	rest 16
	rest 14
	sound_jump Music_WildBattleSM_Ch2_loop_main

Music_WildBattleSM_Ch3:
	note_type 3, 1, 9
	octave 3
	note C_, 8
	octave 2
	note C_, 4
	note G#, 4
	rest 4
	note G_, 4
	rest 4
	note F#, 4
	rest 4
	note F_, 4
	rest 4
	note E_, 4
	rest 4
	note D#, 4
	rest 4
	note D_, 4
	rest 4
	note C#, 4
	octave 3
	note C_, 4
	note F_, 4
	note F#, 4
	note F_, 4
	note C_, 4
	note F_, 4
	note F_, 4
	note F#, 4
	note C_, 4
	note F_, 4
	note G_, 4
	note F_, 4
	note C_, 4
	note G_, 3
	rest 1
	note G_, 4
	note F_, 4
	note C#, 4
	note F#, 4
	note G_, 4
	note F#, 4
	note C#, 4
	note F#, 4
	note F#, 4
	note G_, 4
	note C#, 4
	note F#, 4
	note G#, 4
	note F#, 4
	note C#, 4
	note F#, 3
	rest 1
	note F#, 4
	note F_, 4
Music_WildBattleSM_Ch3_loop_main:
	octave 2
	note C_, 4
	rest 4
	note F_, 4
	rest 4
	note C_, 3
	rest 1
	note C_, 4
	note F_, 4
	note C_, 4
	rest 4
	note F_, 4
	rest 4
	note C_, 4
	note F_, 8
	note G_, 8
	note D#, 3
	rest 1
	note D#, 4
	octave 3
	note D#, 4
	octave 2
	note D#, 3
	rest 1
	note D#, 3
	rest 1
	note D#, 4
	note F_, 4
	rest 4
	note D#, 3
	rest 1
	note D#, 4
	rest 4
	note D#, 1
	rest 1
	note D#, 1
	rest 1
	note D#, 3
	rest 1
	note D#, 4
	note E_, 3
	rest 1
	note E_, 4
	note A_, 4
	note F_, 4
	rest 4
	note F_, 3
	rest 1
	note F_, 4
	octave 3
	note F_, 4
	octave 2
	note F_, 3
	rest 1
	note F_, 3
	rest 1
	note F_, 4
	rest 4
	octave 3
	note F_, 4
	octave 2
	note F_, 4
	rest 4
	octave 3
	note F_, 4
	octave 2
	note F_, 4
	octave 3
	note F_, 4
	octave 2
	note D#, 4
	rest 4
	octave 1
	note D#, 4
	rest 4
	note A#, 3
	rest 1
	note A#, 4
	rest 8
	octave 2
	note D#, 4
	octave 1
	note A#, 4
	rest 4
	note A#, 4
	rest 4
	octave 2
	note C_, 4
	octave 1
	note B_, 4
	rest 4
	octave 2
	note C_, 4
	note F_, 4
	note C_, 4
	note F_, 4
	note C_, 4
	note A_, 4
	note G_, 4
	note F_, 4
	note C_, 4
	note A_, 4
	note C_, 4
	note F_, 4
	note C_, 4
	note F_, 4
	note D#, 4
	note C_, 4
	octave 1
	note A#, 4
	octave 2
	note D#, 4
	octave 1
	note A#, 4
	octave 2
	note D#, 4
	octave 1
	note A#, 4
	octave 2
	note F_, 4
	note D#, 4
	note C_, 4
	octave 1
	note A#, 4
	octave 2
	note A#, 4
	octave 1
	note A_, 4
	octave 2
	note A_, 4
	octave 1
	note G_, 4
	octave 2
	note G_, 4
	octave 1
	note F#, 4
	octave 2
	note F#, 4
	note C_, 3
	rest 1
	note C_, 4
	note F_, 8
	note D#, 8
	note C_, 8
	octave 1
	note A_, 8
	note F_, 8
	octave 2
	note F_, 8
	octave 1
	note F_, 8
	octave 2
	note D#, 3
	rest 1
	note D#, 4
	octave 3
	note D#, 8
	octave 2
	note D#, 3
	rest 1
	note D#, 4
	octave 3
	note D#, 8
	octave 2
	note D#, 4
	note F_, 4
	note G_, 4
	note D#, 3
	rest 1
	note D#, 4
	note A#, 4
	note A_, 4
	note G_, 4
Music_WildBattleSM_Ch3_loop_1:
	octave 1
	note D_, 4
	octave 2
	note D_, 4
	sound_loop 12, Music_WildBattleSM_Ch3_loop_1
	octave 1
	note D_, 4
	octave 2
	note A_, 4
	note G_, 4
	note F#, 4
	note G_, 4
	note F#, 4
	note D_, 8
	octave 1
	note A#, 6
	octave 2
	note F_, 2
	note G_, 4
	octave 1
	note A#, 3
	rest 1
	note A#, 4
	octave 2
	note G_, 4
	rest 4
	octave 1
	note A#, 3
	rest 1
	note A#, 4
	octave 2
	note D#, 4
	note G_, 3
	rest 1
	note G_, 4
	octave 1
	note A#, 4
	octave 2
	note A#, 4
	note A_, 4
	note G_, 4
	note C_, 6
	note G_, 2
	note A_, 4
	note C_, 4
	note C_, 4
	note A_, 8
	note C_, 4
	note C_, 4
	note F_, 4
	note A_, 4
	note A_, 4
	note C_, 4
	octave 3
	note C_, 4
	octave 2
	note B_, 4
	note A_, 4
Music_WildBattleSM_Ch3_loop_2:
	octave 1
	note B_, 4
	octave 2
	note E_, 4
	sound_loop 16, Music_WildBattleSM_Ch3_loop_2
	note C_, 4
	note F_, 4
	note C_, 4
	note F_, 4
	note C_, 4
	note F_, 4
	note C_, 4
	note F_, 4
	note C_, 4
	octave 3
	note C_, 4
	octave 2
	note A#, 4
	note A_, 4
	note A#, 4
	note A_, 4
	note G_, 4
	note F_, 4
	note D_, 4
	note G_, 4
	note D_, 4
	note G_, 4
	note D_, 4
	note G_, 4
	note D_, 4
	note G_, 4
	note D_, 4
	note G_, 4
	octave 3
	note D_, 4
	octave 2
	note B_, 4
	octave 3
	note D_, 4
	octave 2
	note B_, 4
	note G_, 4
	note D_, 4
	note E_, 8
	rest 4
	note E_, 4
	note A_, 8
	rest 4
	note A_, 4
	note E_, 8
	rest 4
	note E_, 4
	note A_, 8
	rest 4
	note A_, 4
	note E_, 4
	note A_, 4
	note E_, 4
	note A_, 4
	note E_, 4
	note A_, 4
	note E_, 4
	note A_, 4
	note E_, 4
	note A_, 4
	note E_, 4
	note A_, 4
	note E_, 4
	note A_, 8
	note E_, 4
Music_WildBattleSM_Ch3_loop_3:
	note C_, 4
	note F_, 4
	sound_loop 12, Music_WildBattleSM_Ch3_loop_3
	note C_, 4
	octave 3
	note C_, 4
	octave 2
	note A#, 4
	note A_, 4
	note F_, 4
	note G_, 4
	note C_, 8
	sound_jump Music_WildBattleSM_Ch3_loop_main

Music_WildBattleSM_Ch4:
	toggle_noise 3
	drum_speed 6
	drum_note 12, 4
	drum_note 4, 4
	drum_note 4, 4
	drum_note 4, 4
	drum_note 4, 4
	drum_note 4, 4
	drum_note 4, 4
	drum_note 4, 4
	drum_note 4, 4
	drum_note 4, 4
	drum_note 3, 2
	drum_note 3, 2
	drum_note 4, 4
	drum_note 3, 2
	drum_note 3, 2
	drum_note 4, 4
	drum_note 3, 2
	drum_note 3, 2
	drum_note 4, 2
	drum_note 3, 4
	drum_note 3, 2
	drum_note 4, 4
	drum_note 3, 2
	drum_note 3, 2
	drum_note 4, 4
	drum_note 3, 2
	drum_note 3, 2
	drum_note 4, 4
	drum_note 3, 2
	drum_note 3, 2
	drum_note 4, 2
	drum_note 1, 2
	drum_note 3, 2
	drum_note 1, 2
Music_WildBattleSM_Ch4_loop_main:
	drum_note 11, 4
	drum_note 1, 4
	drum_note 11, 2
	drum_note 11, 2
	drum_note 1, 4
	drum_note 11, 2
	drum_note 11, 4
	drum_note 1, 2
	drum_note 11, 4
	drum_note 1, 2
	drum_note 1, 2
	drum_note 11, 4
	drum_note 1, 4
	drum_note 11, 2
	drum_note 11, 2
	drum_note 1, 4
	drum_note 11, 2
	drum_note 11, 2
	drum_note 1, 2
	drum_note 4, 1
	drum_note 4, 1
	drum_note 11, 2
	drum_note 11, 2
	drum_note 1, 2
	drum_note 4, 1
	drum_note 1, 1
	drum_note 1, 2
	drum_note 4, 2
	drum_note 1, 3
	drum_note 1, 1
	drum_note 1, 2
	drum_note 1, 2
	drum_note 4, 2
	drum_note 4, 2
	drum_note 4, 2
	drum_note 4, 2
	drum_note 4, 2
	drum_note 1, 4
	drum_note 4, 2
	drum_note 1, 2
	drum_note 4, 1
	drum_note 4, 1
	drum_note 11, 4
	drum_note 1, 4
	drum_note 11, 2
	drum_note 11, 2
	drum_note 1, 4
	drum_note 11, 2
	drum_note 11, 2
	drum_note 1, 2
	drum_note 11, 4
	drum_note 11, 2
	drum_note 1, 2
	drum_note 1, 1
	drum_note 1, 1
	drum_note 4, 4
	drum_note 1, 4
	drum_note 4, 2
	drum_note 4, 2
	drum_note 4, 2
	drum_note 1, 2
	drum_note 4, 2
	drum_note 1, 2
	drum_note 4, 2
	drum_note 1, 2
	drum_note 4, 2
	drum_note 1, 2
	drum_note 4, 2
	drum_note 1, 2
	drum_note 4, 4
	drum_note 1, 4
	drum_note 4, 2
	drum_note 1, 2
	drum_note 4, 2
	drum_note 1, 2
	drum_note 4, 2
	drum_note 1, 2
	drum_note 4, 2
	drum_note 1, 2
	drum_note 4, 2
	drum_note 1, 2
	drum_note 1, 4
	drum_note 4, 2
	drum_note 11, 6
	drum_note 1, 2
	drum_note 4, 4
	drum_note 4, 2
	drum_note 4, 2
	drum_note 1, 4
	drum_note 4, 1
	drum_note 4, 1
	drum_note 12, 4
	drum_note 4, 2
	drum_note 4, 2
	drum_note 4, 2
	drum_note 4, 2
	drum_note 1, 2
	drum_note 4, 2
	drum_note 4, 2
	drum_note 4, 2
	drum_note 1, 2
	drum_note 4, 2
	drum_note 4, 2
	drum_note 4, 2
	drum_note 1, 2
	drum_note 4, 1
	drum_note 4, 1
	drum_note 4, 2
	drum_note 12, 4
	drum_note 4, 2
	sound_call Music_WildBattleSM_Ch4_branch_1
	drum_note 4, 2
	sound_call Music_WildBattleSM_Ch4_branch_1
	drum_note 1, 1
	drum_note 1, 1
	drum_note 4, 3
	drum_note 4, 1
	drum_note 1, 4
	drum_note 4, 2
	drum_note 4, 4
	drum_note 1, 2
	drum_note 4, 3
	drum_note 4, 1
	drum_note 1, 4
	drum_note 4, 2
	drum_note 4, 2
	drum_note 1, 3
	drum_note 1, 1
	drum_note 4, 3
	drum_note 4, 1
	drum_note 1, 4
	drum_note 4, 2
	drum_note 4, 4
	drum_note 1, 2
	drum_note 4, 3
	drum_note 4, 1
	drum_note 1, 4
	drum_note 4, 2
	drum_note 1, 2
	drum_note 1, 2
	drum_note 1, 2
	drum_note 4, 4
	drum_note 1, 4
	drum_note 4, 2
	drum_note 4, 2
	drum_note 1, 4
	drum_note 4, 4
	drum_note 1, 4
	drum_note 4, 2
	drum_note 4, 2
	drum_note 1, 4
	drum_note 4, 4
	drum_note 1, 4
	drum_note 4, 2
	drum_note 4, 2
	drum_note 1, 4
	drum_note 4, 2
	drum_note 1, 4
	drum_note 4, 2
	drum_note 1, 4
	drum_note 1, 2
	drum_note 1, 2
	drum_note 4, 8
	drum_note 4, 2
	drum_note 4, 6
	drum_note 4, 6
	drum_note 4, 4
	drum_note 4, 2
	drum_note 1, 2
	drum_note 1, 1
	drum_note 1, 1
	drum_note 4, 4
	drum_note 4, 2
	drum_note 1, 4
	drum_note 1, 4
	drum_note 1, 2
	drum_note 4, 4
	drum_note 1, 1
	drum_note 1, 1
	drum_note 3, 4
	drum_note 4, 2
	drum_note 1, 2
	drum_note 1, 1
	drum_note 1, 1
	drum_note 4, 4
	drum_note 1, 4
	drum_note 4, 2
	drum_note 4, 2
	drum_note 1, 4
	drum_note 4, 4
	drum_note 1, 4
	drum_note 4, 2
	drum_note 4, 2
	drum_note 1, 4
	drum_note 4, 4
	drum_note 1, 4
	drum_note 4, 2
	drum_note 4, 2
	drum_note 1, 4
	drum_note 4, 4
	drum_note 1, 4
	drum_note 4, 2
	drum_note 1, 2
	drum_note 1, 2
	drum_note 1, 2
	drum_note 4, 4
	drum_note 1, 4
	drum_note 4, 2
	drum_note 4, 2
	drum_note 1, 4
	drum_note 4, 4
	drum_note 1, 4
	drum_note 4, 2
	drum_note 1, 4
	drum_note 1, 2
	drum_note 4, 4
	drum_note 1, 2
	drum_note 1, 2
	drum_note 4, 4
	drum_note 1, 4
	drum_note 4, 4
	drum_note 1, 4
	drum_note 4, 2
	drum_note 1, 4
	drum_note 1, 2
	sound_jump Music_WildBattleSM_Ch4_loop_main

Music_WildBattleSM_Ch4_branch_1:
	drum_note 4, 4
	drum_note 1, 4
	drum_note 4, 2
	drum_note 4, 2
	drum_note 1, 4
	drum_note 4, 2
	drum_note 4, 2
	drum_note 1, 2
	drum_note 4, 4
	drum_note 4, 2
	drum_note 1, 2
	sound_ret
