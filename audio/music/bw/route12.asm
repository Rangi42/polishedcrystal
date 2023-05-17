; Pokémon B/W - Route 12
; Demixed by Mmmmmm
; https://pastebin.com/JK83UjgF
; https://hax.iimarckus.org/topic/6777/2/

Music_Route12BW:
	channel_count 4
	channel 1, Music_Route12BW_Ch1
	channel 2, Music_Route12BW_Ch2
	channel 3, Music_Route12BW_Ch3
	channel 4, Music_Route12BW_Ch4

Music_Route12BW_Ch1:
	tempo 236
	volume 7, 7
	duty_cycle 0
	pitch_offset 2
	vibrato 16, 2, 2
Music_Route12BW_Ch1_loop_1:
	sound_call Music_Route12BW_Ch1_branch_1
	sound_call Music_Route12BW_Ch1_branch_1
	sound_loop 16, Music_Route12BW_Ch1_loop_1
	sound_call Music_Route12BW_Ch1_branch_2
	note E_, 6
	duty_cycle 0
	sound_call Music_Route12BW_Ch1_branch_2
	note G_, 6
	note G#, 12
	note F#, 6
	note B_, 4
	octave 5
	note C#, 2
	octave 4
	note F#, 12
	duty_cycle 0
	octave 2
	volume_envelope 7, 0
	note F#, 8
	octave 3
	volume_envelope 9, 7
	note F#, 2
	note G#, 2
	volume_envelope 9, 0
	note B_, 4
	volume_envelope 9, 7
	note B_, 4
	sound_call Music_Route12BW_Ch1_branch_3
	duty_cycle 0
	octave 3
	volume_envelope 9, 0
	note F#, 4
	volume_envelope 9, 7
	note F#, 4
	sound_call Music_Route12BW_Ch1_branch_3
	duty_cycle 0
	octave 3
	volume_envelope 9, 0
	note E_, 2
	volume_envelope 9, 7
	note E_, 4
	volume_envelope 11, 4
	duty_cycle 2
	octave 4
	note E_, 6
	note G_, 6
	note B_, 6
	octave 5
	note D#, 12
	rest 12
	sound_jump Music_Route12BW_Ch1

Music_Route12BW_Ch1_branch_1:
	note_type 6, 10, 3
	octave 4
	note F#, 1
	volume_envelope 9, 3
	note E_, 1
	volume_envelope 7, 3
	note D#, 1
	volume_envelope 6, 3
	octave 3
	note B_, 1
	volume_envelope 5, 3
	note F#, 1
	volume_envelope 4, 3
	note C#, 1
	octave 2
	volume_envelope 3, 3
	note B_, 1
	volume_envelope 2, 3
	note F#, 1
	sound_ret

Music_Route12BW_Ch1_branch_2:
	octave 3
	note_type 8, 9, 0
	note D#, 4
	volume_envelope 9, 5
	note D#, 4
	note C#, 2
	note D#, 2
	volume_envelope 9, 0
	note B_, 2
	volume_envelope 9, 7
	note B_, 4
	volume_envelope 11, 4
	duty_cycle 2
	octave 4
	note B_, 2
	note A#, 2
	note B_, 2
	note F#, 6
	note G#, 6
	note F#, 6
	sound_ret

Music_Route12BW_Ch1_branch_3:
	volume_envelope 11, 4
	octave 4
	duty_cycle 2
	note D#, 2
	note E_, 2
	note F#, 6
	note B_, 6
	sound_ret

Music_Route12BW_Ch2:
	note_type 8, 11, 0
	duty_cycle 1
	vibrato 28, 1, 2
Music_Route12BW_Ch2_loop:
	octave 4
	volume_envelope 11, 0
	note D#, 6
	volume_envelope 11, 7
	note D#, 6
	volume_envelope 11, 0
	note E_, 2
	volume_envelope 11, 7
	note E_, 4
	volume_envelope 11, 0
	note F#, 2
	volume_envelope 11, 7
	note F#, 4
	octave 3
	volume_envelope 11, 0
	note B_, 12
	volume_envelope 11, 7
	note B_, 6
	volume_envelope 11, 0
	note A#, 2
	volume_envelope 11, 7
	note A#, 4
	volume_envelope 11, 0
	note G#, 2
	volume_envelope 11, 7
	note G#, 4
	volume_envelope 11, 0
	note B_, 6
	volume_envelope 11, 7
	note B_, 6
	volume_envelope 11, 5
	note A#, 2
	note B_, 2
	octave 4
	note C#, 2
	octave 3
	volume_envelope 11, 0
	note F#, 12
	volume_envelope 11, 7
	note F#, 12
	volume_envelope 11, 0
	note F#, 2
	volume_envelope 11, 7
	note F#, 4
	volume_envelope 11, 0
	note B_, 4
	volume_envelope 11, 7
	note B_, 6
	volume_envelope 11, 5
	note F#, 2
	note G#, 2
	note A#, 2
	note B_, 2
	octave 4
	volume_envelope 11, 0
	note F#, 4
	volume_envelope 11, 3
	note F#, 4
	octave 3
	volume_envelope 11, 5
	note A#, 2
	note B_, 2
	octave 4
	volume_envelope 11, 0
	note E_, 4
	volume_envelope 11, 7
	note E_, 2
	volume_envelope 11, 0
	note D#, 4
	volume_envelope 11, 7
	note D#, 2
	volume_envelope 11, 0
	note C#, 6
	volume_envelope 11, 7
	note C#, 6
	octave 3
	volume_envelope 11, 0
	note B_, 2
	volume_envelope 11, 7
	note B_, 4
	octave 4
	volume_envelope 11, 0
	note D#, 2
	volume_envelope 11, 7
	note D#, 4
	volume_envelope 11, 0
	note D#, 1
	volume_envelope 11, 7
	note D#, 5
	volume_envelope 11, 0
	note C#, 1
	volume_envelope 11, 7
	note C#, 5
	octave 3
	volume_envelope 11, 0
	note B_, 1
	volume_envelope 11, 7
	note B_, 5
	volume_envelope 11, 0
	note A#, 1
	volume_envelope 11, 7
	note A#, 5
	sound_call Music_Route12BW_Ch2_branch_1
	sound_call Music_Route12BW_Ch2_branch_1
	volume_envelope 11, 0
	note B_, 6
	volume_envelope 11, 7
	note B_, 6
	volume_envelope 11, 0
	note A#, 2
	volume_envelope 11, 7
	note A#, 4
	note B_, 2
	note A#, 2
	note G#, 2
	volume_envelope 11, 0
	note F#, 9
	volume_envelope 11, 7
	note F#, 9
	rest 2
	octave 4
	note D#, 2
	note E_, 2
	volume_envelope 11, 0
	note F#, 9
	volume_envelope 11, 7
	note F#, 9
	rest 2
	octave 3
	note B_, 2
	octave 4
	note C#, 2
	volume_envelope 11, 0
	note D#, 9
	volume_envelope 11, 7
	note D#, 9
	rest 2
	octave 3
	note G#, 2
	note A#, 2
	volume_envelope 11, 0
	note B_, 12
	volume_envelope 11, 7
	note B_, 12
	volume_envelope 8, 0
	note D#, 12
	volume_envelope 8, 7
	note D#, 12
	sound_jump Music_Route12BW_Ch2_loop

Music_Route12BW_Ch2_branch_1:
	volume_envelope 11, 0
	note B_, 4
	volume_envelope 11, 5
	note B_, 4
	note A#, 2
	note B_, 2
	octave 4
	volume_envelope 11, 0
	note F#, 6
	volume_envelope 11, 7
	note F#, 6
	octave 3
	volume_envelope 11, 0
	note B_, 4
	volume_envelope 11, 5
	note B_, 4
	note F#, 2
	note B_, 2
	octave 4
	volume_envelope 11, 0
	note D#, 2
	volume_envelope 11, 7
	note D#, 4
	volume_envelope 11, 0
	note C#, 2
	volume_envelope 11, 7
	note C#, 4
	octave 3
	sound_ret

Music_Route12BW_Ch3:
	note_type 8, 1, 4
	octave 1
	note B_, 12
	note B_, 6
	octave 2
	note C#, 6
	note D#, 12
	note F#, 6
	note D#, 6
	note E_, 12
	note F#, 6
	note E_, 6
	note D#, 12
	note A#, 6
	note B_, 6
	note E_, 12
	note F#, 6
	note E_, 6
	note D#, 12
	note G#, 6
	note C_, 6
	note C#, 12
	note F_, 12
	note F#, 12
	note F#, 6
	note E_, 6
	sound_call Music_Route12BW_Ch3_branch_1
	note E_, 6
	sound_call Music_Route12BW_Ch3_branch_1
	note G_, 6
	note G#, 12
	note F#, 6
	note E_, 6
	note D#, 12
	note G#, 6
	note F#, 6
	note E_, 12
	note E_, 12
	note F#, 12
	note F#, 12
	rest 6
	note E_, 6
	note G_, 6
	note B_, 6
	octave 1
	note B_, 12
	octave 2
	note F#, 12
	sound_jump Music_Route12BW_Ch3

Music_Route12BW_Ch3_branch_1:
	note D#, 12
	note A#, 6
	octave 3
	note C#, 6
	octave 2
	note E_, 12
	note F#, 6
	sound_ret

Music_Route12BW_Ch4:
	stereo_panning FALSE, TRUE
	toggle_noise 0
Music_Route12BW_Ch4_loop:
	drum_speed 4
	sound_call Music_Route12BW_Ch4_branch_1
	sound_call Music_Route12BW_Ch4_branch_2
	sound_call Music_Route12BW_Ch4_branch_3
	sound_call Music_Route12BW_Ch4_branch_4
	sound_call Music_Route12BW_Ch4_branch_5
	sound_call Music_Route12BW_Ch4_branch_6
	sound_call Music_Route12BW_Ch4_branch_1
	sound_call Music_Route12BW_Ch4_branch_7
	sound_jump Music_Route12BW_Ch4_loop

Music_Route12BW_Ch4_branch_1:
	drum_note 3, 4
	drum_note 3, 1
	drum_note 4, 1
	drum_note 4, 1
	drum_note 4, 1
	drum_note 3, 4
	sound_ret

Music_Route12BW_Ch4_branch_2:
	drum_note 3, 4
	drum_note 3, 4
	drum_note 3, 4
	sound_ret

Music_Route12BW_Ch4_branch_3:
	drum_note 3, 1
	drum_note 4, 1
	drum_note 4, 1
	drum_note 4, 1
	drum_note 3, 2
	drum_note 4, 2
	drum_note 3, 4
	sound_ret

Music_Route12BW_Ch4_branch_4:
	drum_note 3, 2
	drum_note 4, 2
	drum_note 3, 2
	drum_note 4, 2
	drum_note 3, 1
	drum_note 4, 1
	drum_note 4, 1
	drum_note 4, 1
	sound_ret

Music_Route12BW_Ch4_branch_5:
	drum_note 3, 4
	drum_note 3, 2
	drum_note 4, 2
	drum_note 3, 4
	sound_ret

Music_Route12BW_Ch4_branch_6:
	drum_note 3, 4
	drum_note 3, 2
	drum_note 4, 2
	drum_note 3, 2
	drum_note 4, 2
	sound_ret

Music_Route12BW_Ch4_branch_7:
	drum_note 3, 1
	drum_note 4, 1
	drum_note 4, 1
	drum_note 4, 1
	drum_note 3, 4
	drum_note 3, 4
	sound_ret
