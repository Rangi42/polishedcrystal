; Pokémon R/S/E - Route 101
; Demixed by Mmmmmm
; https://pastebin.com/VstjfaGf
; https://hax.iimarckus.org/topic/6777/

Music_Route101RSE:
	channel_count 4
	channel 1, Music_Route101RSE_Ch1
	channel 2, Music_Route101RSE_Ch2
	channel 3, Music_Route101RSE_Ch3
	channel 4, Music_Route101RSE_Ch4

Music_Route101RSE_Ch1:
	tempo 166
	volume 7, 7
	pitch_offset 1
	vibrato 16, 1, 5
	stereo_panning FALSE, TRUE
	note_type 12, 8, 3
	rest 2
Music_Route101RSE_Ch1_loop:
	volume_envelope 8, 4
	duty_cycle 3
	sound_call Music_Route101RSE_Ch1_branch_1
	sound_call Music_Route101RSE_Ch1_branch_1
	volume_envelope 8, 2
	duty_cycle 0
	sound_call Music_Route101RSE_Ch1_branch_2
	sound_call Music_Route101RSE_Ch1_branch_3
	sound_call Music_Route101RSE_Ch1_branch_3
	octave 5
	note E_, 1
	octave 4
	note B_, 1
	note E_, 1
	octave 3
	note B_, 1
	octave 4
	note G_, 1
	octave 3
	note B_, 1
	note G_, 1
	note E_, 1
	note A_, 1
	octave 4
	note D_, 1
	note E_, 1
	note A_, 1
	note E_, 1
	octave 5
	note D_, 1
	note E_, 1
	note A_, 1
	note E_, 1
	note D#, 1
	rest 1
	note D_, 1
	note C#, 2
	octave 4
	note A_, 2
	sound_call Music_Route101RSE_Ch1_branch_2
	volume_envelope 8, 3
	duty_cycle 3
	octave 3
	note A#, 1
	note D_, 1
	note F_, 1
	note A#, 1
	octave 4
	note D_, 4
	octave 5
	volume_envelope 8, 4
	duty_cycle 2
	note F_, 2
	volume_envelope 6, 4
	note F_, 2
	volume_envelope 8, 4
	note A#, 2
	volume_envelope 6, 4
	note A#, 2
	volume_envelope 8, 3
	duty_cycle 3
	octave 3
	note A_, 1
	note C#, 1
	note E_, 1
	note G_, 1
	note A_, 4
	octave 5
	duty_cycle 2
	volume_envelope 8, 4
	note E_, 2
	volume_envelope 6, 4
	note E_, 2
	volume_envelope 8, 4
	note A_, 2
	volume_envelope 6, 4
	note A_, 2
	sound_jump Music_Route101RSE_Ch1_loop

Music_Route101RSE_Ch1_branch_1:
	octave 3
	note D_, 2
	octave 2
	note A_, 2
	rest 2
	note F#, 1
	note D_, 1
	note F#, 2
	rest 2
	octave 3
	note D_, 4
	note E_, 2
	octave 2
	note B_, 2
	rest 2
	note G_, 1
	note E_, 1
	note G_, 2
	rest 2
	octave 3
	note E_, 4
	note C#, 1
	octave 2
	note B_, 1
	octave 3
	note C#, 1
	note D_, 1
	note E_, 1
	note F#, 1
	note G_, 1
	note E_, 1
	note A_, 8
	octave 4
	note C#, 1
	octave 3
	note B_, 1
	octave 4
	note C#, 1
	octave 3
	note B_, 1
	octave 4
	note C#, 1
	octave 3
	rest 2
	note A_, 1
	octave 4
	note C#, 2
	rest 2
	octave 3
	note E_, 2
	octave 2
	note A_, 2
	sound_ret

Music_Route101RSE_Ch1_branch_2:
	octave 4
	note G_, 1
	octave 3
	note G_, 1
	octave 4
	note D_, 1
	octave 3
	note B_, 1
	octave 4
	note G_, 1
	octave 3
	note G_, 1
	octave 4
	note D_, 1
	octave 3
	note B_, 1
	note G_, 1
	note B_, 1
	octave 4
	note D_, 1
	note G_, 1
	octave 3
	note B_, 1
	octave 4
	note G_, 1
	octave 5
	note D_, 1
	note G_, 1
	octave 4
	note F#, 1
	octave 3
	note F#, 1
	octave 4
	note D_, 1
	octave 3
	note A_, 1
	octave 4
	note F#, 1
	octave 3
	note F#, 1
	octave 4
	note D_, 1
	octave 3
	note A_, 1
	note F#, 1
	octave 4
	note D_, 1
	note F#, 1
	note A_, 1
	note D_, 1
	note A_, 1
	octave 5
	note D_, 1
	note F#, 1
	sound_ret

Music_Route101RSE_Ch1_branch_3:
	octave 4
	note G_, 1
	octave 3
	note G_, 1
	note B_, 1
	octave 4
	note E_, 1
	sound_ret

Music_Route101RSE_Ch2:
	duty_cycle 2
	vibrato 18, 3, 6
	note_type 12, 7, 7
	rest 2
Music_Route101RSE_Ch2_loop:
	volume_envelope 7, 7
	sound_call Music_Route101RSE_Ch2_branch_1
	sound_call Music_Route101RSE_Ch2_branch_1
	sound_call Music_Route101RSE_Ch2_branch_2
	volume_envelope 9, 7
	octave 4
	note D_, 1
	rest 1
	note D_, 1
	rest 1
	note D_, 1
	rest 1
	note E_, 1
	note F#, 1
	volume_envelope 9, 0
	note G_, 2
	volume_envelope 9, 7
	note G_, 6
	note E_, 4
	note D_, 4
	note E_, 1
	rest 1
	note E_, 1
	rest 1
	note E_, 1
	rest 1
	note E_, 1
	note F#, 1
	note E_, 6
	volume_envelope 7, 7
	octave 1
	note A_, 2
	sound_call Music_Route101RSE_Ch2_branch_2
	note F#, 1
	rest 1
	note A_, 1
	rest 1
	octave 2
	note D_, 2
	octave 1
	note F#, 2
	volume_envelope 9, 7
	octave 4
	note A#, 6
	note A_, 2
	note G_, 4
	note F_, 2
	note A#, 2
	volume_envelope 9, 0
	note A_, 8
	volume_envelope 9, 7
	note A_, 8
	sound_jump Music_Route101RSE_Ch2_loop

Music_Route101RSE_Ch2_branch_1:
	octave 1
	note D_, 2
	rest 5
	note A_, 1
	note D_, 2
	rest 4
	note A_, 2
	note E_, 2
	rest 1
	note E_, 1
	octave 2
	note D#, 2
	octave 1
	note B_, 1
	note B_, 1
	note E_, 2
	rest 4
	note E_, 2
	note A_, 2
	rest 5
	note E_, 1
	note A_, 2
	rest 4
	octave 2
	note E_, 1
	note E_, 1
	octave 1
	note A_, 2
	rest 2
	note A_, 1
	rest 2
	note E_, 1
	note A_, 2
	rest 2
	octave 2
	note E_, 1
	rest 1
	octave 1
	note A_, 2
	sound_ret

Music_Route101RSE_Ch2_branch_2:
	note G_, 2
	rest 2
	note G_, 1
	rest 1
	octave 2
	note D_, 2
	octave 1
	note G_, 2
	rest 4
	volume_envelope 9, 2
	note G_, 1
	note G_, 1
	volume_envelope 9, 7
	note F#, 2
	rest 1
	note A_, 1
	octave 2
	note C#, 2
	octave 1
	note D_, 1
	note E_, 1
	sound_ret

Music_Route101RSE_Ch3:
	stereo_panning TRUE, FALSE
	note_type 12, 1, 3
	vibrato 21, 2, 4
Music_Route101RSE_Ch3_loop:
	sound_call Music_Route101RSE_Ch3_branch_1
	sound_call Music_Route101RSE_Ch3_branch_1
	octave 6
	note C#, 1
	note D_, 1
	octave 5
	note B_, 1
	rest 1
	note B_, 1
	rest 1
	note B_, 1
	rest 1
	note B_, 1
	octave 6
	note C#, 1
	note D_, 4
	octave 5
	note D_, 4
	sound_call Music_Route101RSE_Ch3_branch_2
	note G_, 1
	rest 1
	octave 4
	note B_, 1
	rest 1
	octave 5
	note C#, 1
	rest 1
	note E_, 1
	note F#, 1
	note G_, 4
	note B_, 4
	sound_call Music_Route101RSE_Ch3_branch_2
	note B_, 1
	rest 1
	note B_, 1
	rest 1
	note B_, 1
	rest 1
	note B_, 1
	octave 6
	note C#, 1
	note D_, 4
	octave 5
	note G_, 4
	octave 6
	note F#, 1
	rest 1
	note G_, 1
	rest 1
	note F#, 1
	rest 1
	note F#, 1
	note E_, 1
	note D_, 6
	rest 2
	note D_, 6
	note C_, 2
	octave 5
	note A#, 4
	note F_, 2
	octave 6
	note D_, 2
	note C#, 8
	volume_envelope 2, 3
	note C#, 6
	volume_envelope 1, 3
	sound_jump Music_Route101RSE_Ch3_loop

Music_Route101RSE_Ch3_branch_1:
	octave 5
	note A_, 1
	note B_, 1
	note A_, 1
	rest 1
	note A_, 1
	rest 1
	note G_, 1
	rest 1
	note F#, 2
	rest 2
	note F#, 1
	rest 1
	note G_, 1
	rest 1
	note A_, 1
	rest 1
	note G_, 2
	rest 2
	note F#, 2
	rest 2
	note E_, 2
	rest 2
	note B_, 2
	rest 2
	note A_, 12
	rest 2
	note F#, 1
	note G_, 1
	note A_, 1
	note G_, 1
	note A_, 1
	note G_, 1
	note A_, 1
	rest 1
	note G_, 1
	note F#, 1
	note E_, 1
	rest 5
	sound_ret

Music_Route101RSE_Ch3_branch_2:
	note A_, 1
	rest 1
	note A_, 1
	rest 1
	note A_, 1
	rest 1
	note A_, 1
	note B_, 1
	note A_, 6
	rest 2
	sound_ret

Music_Route101RSE_Ch4:
	stereo_panning FALSE, TRUE
	toggle_noise 0
	drum_speed 12
	rest 2
Music_Route101RSE_Ch4_loop:
	sound_call Music_Route101RSE_Ch4_branch_1
	drum_note 4, 1
	drum_note 4, 1
	sound_loop 4, Music_Route101RSE_Ch4_loop
Music_Route101RSE_Ch4_loop_2:
	sound_call Music_Route101RSE_Ch4_branch_2
	drum_note 3, 1
	drum_note 12, 1
	drum_note 12, 1
	drum_note 12, 1
	drum_note 4, 1
	drum_note 12, 1
	drum_note 3, 1
	drum_note 3, 1
	sound_call Music_Route101RSE_Ch4_branch_2
	drum_note 3, 1
	drum_note 12, 1
	drum_note 12, 1
	drum_note 3, 1
	drum_note 4, 1
	drum_note 12, 1
	drum_note 3, 1
	drum_note 12, 1
	sound_loop 3, Music_Route101RSE_Ch4_loop_2
	drum_note 3, 1
	drum_note 12, 1
	drum_note 12, 1
	drum_note 3, 1
	drum_note 4, 2
	drum_note 6, 1
	drum_note 6, 1
	drum_note 6, 2
	drum_note 4, 1
	drum_note 4, 1
	drum_note 3, 2
	drum_note 7, 2
	drum_note 3, 1
	drum_note 12, 1
	drum_note 12, 1
	drum_note 3, 1
	drum_note 4, 2
	drum_note 6, 1
	drum_note 6, 1
	drum_note 6, 2
	drum_note 4, 1
	drum_note 4, 1
	drum_note 3, 4
	sound_jump Music_Route101RSE_Ch4_loop

Music_Route101RSE_Ch4_branch_1:
	drum_note 4, 4
	drum_note 6, 3
	drum_note 4, 1
	drum_note 4, 4
	drum_note 6, 2
	drum_note 4, 1
	drum_note 4, 1
	drum_note 4, 4
	drum_note 6, 4
	drum_note 4, 2
	drum_note 6, 1
	drum_note 6, 1
	drum_note 6, 2
	sound_ret

Music_Route101RSE_Ch4_branch_2:
	drum_note 3, 1
	drum_note 12, 1
	drum_note 12, 1
	drum_note 12, 1
	drum_note 4, 1
	drum_note 12, 1
	drum_note 3, 1
	drum_note 12, 1
	sound_ret
