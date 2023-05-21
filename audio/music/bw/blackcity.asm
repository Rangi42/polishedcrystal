; Pokémon B/W - Black City
; Demixed by Mmmmmm
; https://pastebin.com/bqcvjdFi
; https://hax.iimarckus.org/topic/6777/9/

Music_BlackCityBW:
	channel_count 4
	channel 1, Music_BlackCityBW_Ch1
	channel 2, Music_BlackCityBW_Ch2
	channel 3, Music_BlackCityBW_Ch3
	channel 4, Music_BlackCityBW_Ch4

Music_BlackCityBW_Ch1:
	vibrato 18, 1, 5
	pitch_offset 1
	note_type 6, 9, 1
	tempo 156
	rest 4
Music_BlackCityBW_Ch1_loop:
	sound_call Music_BlackCityBW_Ch1_branch_1
	octave 4
	duty_cycle 1
	volume_envelope 5, 4
	note F#, 1
	volume_envelope 7, 4
	note G_, 1
	volume_envelope 9, 4
	note A#, 2
	note F#, 2
	note G_, 2
	note D#, 2
	note E_, 2
	note C_, 2
	note C#, 2
	octave 3
	note A#, 2
	duty_cycle 0
	volume_envelope 11, 1
	sound_call Music_BlackCityBW_Ch1_branch_1
	rest 2
	duty_cycle 1
	volume_envelope 9, 4
	note E_, 2
	note F#, 2
	note G_, 2
	note B_, 2
	octave 4
	note E_, 2
	note F#, 2
	note G_, 2
	note B_, 2 ;;;;; halfway point
	duty_cycle 0
	volume_envelope 9, 1
	note D_, 4
	octave 3
	note F_, 4
	octave 4
	note D_, 4
	octave 3
	note F_, 4
	octave 4
	note D_, 4
	octave 3
	note F_, 4
	octave 4
	note D_, 4
	octave 3
	note F_, 4
	octave 4
	note C_, 4
	octave 3
	note F_, 4
	octave 4
	note C_, 4
	octave 3
	note F_, 4
	octave 4
	note C_, 4
	octave 3
	note F_, 4
	octave 4
	note C_, 4
	octave 3
	note F_, 4
	octave 4
	note C_, 4
	octave 3
	note C_, 4
	octave 4
	note C_, 4
	octave 3
	note C_, 4
	octave 4
	note C_, 4
	octave 3
	note C_, 4
	octave 4
	note C_, 4
	octave 3
	note C_, 4
	note A#, 4
	note C_, 4
	note A#, 4
	note C_, 4
	octave 4
	note C#, 4
	octave 3
	note C_, 4
	octave 4
	note C#, 4
	octave 3
	note C_, 4
	note B_, 4
	note D_, 4
	note B_, 4
	note D_, 4
	note B_, 4
	note D_, 4
	note B_, 4
	note D_, 4
	note A#, 4
	note C_, 4
	note A#, 4
	note C_, 4
	octave 4
	note C_, 4
	octave 3
	note C_, 4
	octave 4
	note C_, 4
	octave 3
	note C_, 4
	note G_, 4
	note C_, 4
	note G_, 4
	note C_, 4
	note G_, 4
	note C_, 4
	note G_, 4
	note C_, 4
	note G#, 4
	note C_, 4
	note G#, 4
	note C_, 4
	note G_, 4
	octave 2
	note B_, 4
	octave 3
	note G_, 4
	octave 2
	note B_, 4
	sound_jump Music_BlackCityBW_Ch1_loop

Music_BlackCityBW_Ch1_branch_1:
	octave 4
	note E_, 2
	octave 3
	volume_envelope 7, 1
	note G_, 2
	volume_envelope 11, 1
	note G_, 4
	octave 4
	note E_, 2
	octave 3
	volume_envelope 7, 1
	note G_, 2
	volume_envelope 11, 1
	note G_, 4
	octave 4
	note E_, 2
	octave 3
	volume_envelope 7, 1
	note G_, 2
	volume_envelope 11, 1
	note G_, 4
	octave 4
	note E_, 2
	octave 3
	volume_envelope 7, 1
	note G_, 2
	volume_envelope 11, 1
	note G_, 4
	octave 4
	note D#, 2
	octave 3
	volume_envelope 7, 1
	note G_, 2
	volume_envelope 11, 1
	note G_, 4
	octave 4
	note D#, 2
	octave 3
	volume_envelope 7, 1
	note G_, 2
	volume_envelope 11, 1
	note G_, 4
	octave 4
	note D#, 2
	octave 3
	volume_envelope 7, 1
	note G_, 2
	volume_envelope 11, 1
	note G_, 4
	octave 4
	note D#, 2
	octave 3
	volume_envelope 7, 1
	note G_, 2
	volume_envelope 11, 1
	note G_, 4
	octave 4
	note D_, 2
	octave 3
	volume_envelope 7, 1
	note G_, 2
	volume_envelope 11, 1
	note G_, 4
	octave 4
	note D_, 2
	octave 3
	volume_envelope 7, 1
	note G_, 2
	volume_envelope 11, 1
	note G_, 4
	octave 4
	note D_, 2
	octave 3
	volume_envelope 7, 1
	note G_, 2
	volume_envelope 11, 1
	note G_, 4
	octave 4
	note D_, 2
	octave 3
	volume_envelope 7, 1
	note G_, 2
	volume_envelope 11, 1
	note G_, 4
	octave 4
	note C#, 2
	octave 3
	volume_envelope 7, 1
	note G_, 2
	volume_envelope 11, 1
	note G_, 4
	octave 4
	note C#, 2
	octave 3
	volume_envelope 7, 1
	note G_, 2
	volume_envelope 11, 1
	note G_, 2
	sound_ret

Music_BlackCityBW_Ch2:
	duty_cycle 2
	vibrato 18, 2, 4
	pitch_offset 1
	note_type 6, 10, 7
	octave 3
	rest 1
	note G#, 1
	note A_, 1
	note A#, 1
	note B_, 12
	octave 4
	note E_, 12
	note C_, 8
	note D#, 12
	note C_, 12
	note D_, 4
	note C#, 2
	note C_, 2
	octave 3
	note B_, 16
	rest 8
	note A_, 4
	note B_, 2
	octave 4
	note C_, 2
	octave 3
	note B_, 14
	octave 4
	duty_cycle 0
	volume_envelope 5, 4
	note C_, 1
	volume_envelope 7, 4
	note C#, 1
	volume_envelope 9, 4
	note D#, 2
	note C_, 2
	note C#, 2
	octave 3
	note A_, 2
	note A#, 2
	note F#, 3
	volume_envelope 10, 7
	duty_cycle 2
	octave 3
	note G#, 1
	note A_, 1
	note A#, 1
	note B_, 12
	octave 4
	note E_, 12
	note C_, 8
	note D#, 12
	note C_, 12
	note D_, 4
	note C#, 2
	note C_, 2
	octave 3
	note B_, 16
	rest 8
	note A_, 4
	note B_, 2
	octave 4
	note C_, 2
	octave 3
	note B_, 16
	duty_cycle 0
	volume_envelope 9, 4
	octave 2
	note B_, 2
	octave 3
	note D_, 2
	note E_, 2
	note F#, 2
	note B_, 2
	octave 4
	note D_, 2
	note E_, 2
	note F#, 2
	duty_cycle 1
	volume_envelope 11, 7
	vibrato 16, 4, 4
	note A_, 12
	note G_, 12
	octave 5
	note C_, 8
	octave 4
	note G_, 12
	volume_envelope 11, 0
	note F_, 4
	volume_envelope 11, 7
	note F_, 16
	note F_, 12
	note D#, 12
	octave 5
	note C_, 8
	octave 4
	note F_, 12
	volume_envelope 11, 0
	note D#, 4
	volume_envelope 11, 7
	note D#, 16
	note D#, 12
	note D_, 12
	note A#, 8
	volume_envelope 11, 0
	note D_, 4
	volume_envelope 11, 7
	note D_, 12
	volume_envelope 11, 0
	note D#, 4
	volume_envelope 11, 7
	note D#, 12
	volume_envelope 11, 0
	note C_, 16
	volume_envelope 11, 7
	note C_, 16
	volume_envelope 11, 0
	note F_, 2
	volume_envelope 11, 7
	note F_, 10
	note D#, 2
	note F_, 2
	volume_envelope 11, 0
	note G_, 2
	volume_envelope 11, 7
	note G_, 10
	sound_jump Music_BlackCityBW_Ch2

Music_BlackCityBW_Ch3:
	note_type 12, 2, 4
	rest 2
Music_BlackCityBW_Ch3_loop:
	octave 4
	note E_, 16
	note D#, 16
	note D_, 16
	note C#, 16
	note E_, 16
	note D#, 16
	note D_, 16
	note C#, 16
	note D_, 16
	note C_, 8
	note F_, 8
	note C_, 16
	octave 3
	note A#, 8
	octave 4
	note C#, 8
	octave 3
	note B_, 16
	note A#, 8
	octave 4
	note C_, 8
	octave 3
	note G#, 16
	octave 4
	note C_, 8
	octave 3
	note B_, 8
	sound_jump Music_BlackCityBW_Ch3_loop

Music_BlackCityBW_Ch4:
	toggle_noise 3
	drum_speed 6
	rest 4
Music_BlackCityBW_Ch4_loop_main:
Music_BlackCityBW_Ch4_loop_1:
	drum_note 12, 6
	drum_note 1, 6
	drum_note 4, 4
	drum_note 3, 4
	drum_note 4, 4
	drum_note 1, 4
	drum_note 3, 4
	drum_note 4, 2
	drum_note 4, 2
	drum_note 3, 4
	drum_note 1, 4
	drum_note 3, 4
	drum_note 2, 2
	drum_note 1, 6
	drum_note 1, 4
	drum_note 3, 4
	drum_note 4, 2
	drum_note 4, 2
	drum_note 3, 2
	drum_note 1, 6
	drum_note 4, 4
	drum_note 3, 4
	drum_note 4, 4
	drum_note 1, 4
	drum_note 4, 4
	drum_note 3, 2
	drum_note 3, 2
	drum_note 4, 2
	drum_note 1, 6
	drum_note 4, 4
	drum_note 4, 2
	drum_note 1, 4
	drum_note 4, 2
	drum_note 1, 2
	drum_note 1, 2
	drum_note 4, 4
	sound_loop 2, Music_BlackCityBW_Ch4_loop_1
	sound_call Music_BlackCityBW_Ch4_branch_1
	drum_note 4, 4
	drum_note 3, 4
	drum_note 4, 4
	drum_note 3, 4
	drum_note 4, 2
	drum_note 1, 6
	drum_note 1, 4
	drum_note 1, 2
	drum_note 1, 2
	sound_call Music_BlackCityBW_Ch4_branch_1
	drum_note 4, 2
	drum_note 4, 2
	drum_note 3, 4
	drum_note 1, 4
	drum_note 3, 4
	drum_note 4, 2
	drum_note 1, 6
	drum_note 1, 2
	drum_note 1, 2
	drum_note 4, 1
	drum_note 4, 1
	drum_note 4, 1
	drum_note 4, 1
	sound_jump Music_BlackCityBW_Ch4_loop_main

Music_BlackCityBW_Ch4_branch_1:
	drum_note 12, 8
	drum_note 4, 4
	drum_note 3, 4
	drum_note 4, 2
	drum_note 1, 6
	drum_note 1, 4
	drum_note 4, 4
	drum_note 3, 4
	drum_note 4, 4
	drum_note 3, 4
	drum_note 4, 4
	drum_note 4, 2
	drum_note 1, 6
	drum_note 1, 4
	drum_note 4, 4
	drum_note 3, 4
	drum_note 4, 4
	drum_note 3, 4
	drum_note 4, 4
	drum_note 4, 2
	drum_note 1, 6
	drum_note 1, 4
	drum_note 4, 2
	drum_note 4, 2
	sound_ret
