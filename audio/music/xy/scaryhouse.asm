; Pokémon X/Y - Scary House
; Demixed by Mmmmmm
; https://pastebin.com/Ycw1DGh3
; https://hax.iimarckus.org/topic/6777/9/

Music_ScaryHouseXY:
	channel_count 3
	channel 1, Music_ScaryHouseXY_Ch1
	channel 2, Music_ScaryHouseXY_Ch2
	channel 3, Music_ScaryHouseXY_Ch3

Music_ScaryHouseXY_Ch1:
	vibrato 18, 1, 5
	pitch_offset 3
	note_type 6, 3, 7
	duty_cycle 2
	tempo 188
	octave 4
	rest 1
	note B_, 4
	note E_, 4
	note B_, 4
	note E_, 4
	octave 5
	note C_, 4
	octave 4
	note E_, 4
	note B_, 4
	note E_, 4
	note A#, 4
	volume_envelope 4, 7
	note E_, 4
	note A#, 4
	note E_, 4
	note B_, 4
	note E_, 4
	note B_, 4
	volume_envelope 5, 7
	note E_, 4
	octave 5
	note C_, 4
	octave 4
	note E_, 4
	note B_, 4
	note E_, 4
	note A#, 15
	duty_cycle 1
	pitch_offset 3
Music_ScaryHouseXY_Ch1_loop_main:
	volume_envelope 7, 5
	octave 3
	note E_, 8
	note F#, 8
	note G_, 8
	note A_, 8
	volume_envelope 5, 5
	note A_, 8
	volume_envelope 4, 5
	note A_, 8
	volume_envelope 3, 5
	note A_, 8
	volume_envelope 7, 5
	note E_, 4
	note F#, 4
	note G_, 8
	note A_, 8
	volume_envelope 5, 5
	note A_, 8
	volume_envelope 4, 5
	note A_, 8
	volume_envelope 3, 5
	note A_, 8
	volume_envelope 7, 5
	note E_, 8
	note B_, 8
	note A#, 8
	note G_, 16
	octave 4
	note D_, 8
	volume_envelope 5, 5
	note D_, 8
	volume_envelope 4, 5
	note D_, 8
	volume_envelope 7, 5
	note C#, 8
	volume_envelope 5, 5
	note C#, 8
	volume_envelope 4, 5
	note C#, 8
	volume_envelope 7, 5
	note C_, 8
	octave 3
	note F_, 4
	note G_, 4
	note G#, 8
	note B_, 8
	volume_envelope 5, 5
	note B_, 8
	volume_envelope 4, 5
	note B_, 8
	volume_envelope 3, 5
	note B_, 8
	volume_envelope 7, 5
	note F_, 4
	note G_, 4
	note G#, 8
	note B_, 8
	volume_envelope 5, 5
	note B_, 8
	volume_envelope 4, 5
	note B_, 8
	sound_jump Music_ScaryHouseXY_Ch1_loop_main

Music_ScaryHouseXY_Ch2:
	duty_cycle 2
	vibrato 18, 1, 5
	pitch_offset 2
	note_type 12, 9, 3
	octave 4
	note B_, 2
	note E_, 2
	note B_, 2
	note E_, 2
	octave 5
	note C_, 2
	octave 4
	note E_, 2
	note B_, 2
	note E_, 2
	note A#, 2
	note E_, 2
	note A#, 2
	note E_, 2
	note B_, 2
	note E_, 2
	note B_, 2
	note E_, 2
	octave 5
	note C_, 2
	octave 4
	note E_, 2
	note B_, 2
	note E_, 2
	note A#, 8
Music_ScaryHouseXY_Ch2_loop_main:
	volume_envelope 9, 4
	note E_, 4
	note F#, 4
	note G_, 4
	volume_envelope 9, 6
	note A_, 12
	octave 3
	volume_envelope 7, 7
	note E_, 4
	octave 4
	volume_envelope 9, 4
	note E_, 2
	note F#, 2
	note G_, 4
	volume_envelope 9, 6
	note A_, 12
	octave 3
	volume_envelope 7, 7
	note E_, 4
	octave 4
	volume_envelope 9, 4
	note E_, 4
	note B_, 4
	note A#, 4
	note G_, 8
	volume_envelope 9, 5
	octave 5
	note D_, 4
	octave 4
	note G#, 8
	octave 5
	note C#, 4
	octave 4
	note G_, 8
	octave 5
	note C_, 4
	octave 4
	note F_, 2
	note G_, 2
	note G#, 4
	note B_, 16
	note F_, 2
	note G_, 2
	note G#, 4
	note B_, 12
	sound_jump Music_ScaryHouseXY_Ch2_loop_main

Music_ScaryHouseXY_Ch3:
	note_type 12, 2, 0
	pitch_offset 2
	octave 3
	note E_, 4
	note A#, 4
	octave 4
	note F_, 4
	note E_, 8
	volume_envelope 3, 0
	note E_, 4
	sound_loop 2, Music_ScaryHouseXY_Ch3
Music_ScaryHouseXY_Ch3_loop_main:
Music_ScaryHouseXY_Ch3_loop_1:
	volume_envelope 2, 0
	octave 3
	note E_, 2
	note B_, 2
	octave 4
	note G_, 2
	octave 3
	note B_, 2
	octave 4
	note G_, 2
	octave 3
	note B_, 2
	octave 4
	note F#, 2
	octave 3
	note B_, 2
	octave 4
	note F#, 4
	volume_envelope 3, 0
	note F#, 4
	volume_envelope 2, 0
	sound_loop 2, Music_ScaryHouseXY_Ch3_loop_1
	octave 3
	note E_, 2
	note F#, 2
	note G_, 2
	note B_, 2
	octave 4
	note E_, 2
	note B_, 2
	note A#, 2
	note E_, 2
	note A#, 4
	volume_envelope 3, 0
	note A#, 4
	volume_envelope 2, 0
	octave 3
	note E_, 2
	note A#, 2
	octave 4
	note D_, 4
	volume_envelope 3, 0
	note D_, 4
	volume_envelope 2, 0
	octave 3
	note D#, 2
	note A_, 2
	octave 4
	note C#, 4
	volume_envelope 3, 0
	note C#, 4
	volume_envelope 2, 0
	octave 3
	note D_, 2
	note G#, 2
	octave 4
	note C_, 4
	volume_envelope 3, 0
	note C_, 4
	volume_envelope 2, 0
	octave 3
	note C#, 2
	note G_, 2
	note B_, 2
	octave 4
	note E_, 2
	note A#, 4
	rest 16
	rest 8
	sound_jump Music_ScaryHouseXY_Ch3_loop_main
