; Pokémon R/S/E - Mount Pyre / Shoal Cave
; Demixed by Mmmmmm
; https://pastebin.com/3iAgGV4u
; https://hax.iimarckus.org/topic/6777/

Music_MountPyreRSE:
	channel_count 4
	channel 1, Music_MountPyreRSE_Ch1
	channel 2, Music_MountPyreRSE_Ch2
	channel 3, Music_MountPyreRSE_Ch3
	channel 4, Music_MountPyreRSE_Ch4

Music_MountPyreRSE_Ch1:
	tempo 212
	volume 7, 7
	duty_cycle 1
	pitch_offset 2
	vibrato 16, 2, 2
	note_type 6, 6, 3
	rest 5
Music_MountPyreRSE_Ch1_loop_main:
Music_MountPyreRSE_Ch1_loop_1:
	octave 3
	volume_envelope 4, 2
	note C_, 1
	volume_envelope 7, 2
	note D_, 4
	note G#, 4
	note D_, 7
	sound_loop 16, Music_MountPyreRSE_Ch1_loop_1
Music_MountPyreRSE_Ch1_loop_2:
	volume_envelope 4, 2
	note D#, 1
	volume_envelope 7, 2
	note F_, 4
	note B_, 4
	note F_, 7
	sound_loop 16, Music_MountPyreRSE_Ch1_loop_2
	volume_envelope 10, 3
	rest 7
Music_MountPyreRSE_Ch1_loop_3:
	octave 3
	note F#, 1
	rest 1
	sound_loop 7, Music_MountPyreRSE_Ch1_loop_3
	note F#, 1
	note G#, 1
	note F#, 1
	rest 1
	note F_, 1
	rest 1
	note D#, 1
	rest 1
	note D_, 2
	note D#, 2
	volume_envelope 10, 0
	note F_, 16
	volume_envelope 10, 7
	note F_, 12
	volume_envelope 10, 3
	octave 4
	note C_, 2
	octave 3
	note A_, 2
	rest 2
	note F#, 1
	rest 1
	note D#, 1
	rest 1
	note F#, 1
	rest 1
	octave 2
	note A_, 1
	rest 1
	octave 3
	note C_, 1
	rest 1
	octave 2
	note F#, 1
	rest 1
	note A_, 1
	rest 1
	note D#, 1
	rest 1
	note F#, 1
	rest 1
	note_type 8, 10, 3
	note A_, 1
	octave 3
	note C_, 1
	note D#, 1
	note A_, 1
	octave 4
	note C_, 1
	note F#, 4
	note_type 6, 10, 3
	rest 16
	rest 15
	sound_jump Music_MountPyreRSE_Ch1_loop_main

Music_MountPyreRSE_Ch2:
	duty_cycle 2
	vibrato 28, 1, 2
	note_type 12, 10, 3
	rest 1
Music_MountPyreRSE_Ch2_loop_main:
	duty_cycle 2
	sound_call Music_MountPyreRSE_Ch2_branch_1
	sound_call Music_MountPyreRSE_Ch2_branch_1
	sound_call Music_MountPyreRSE_Ch2_branch_2
	sound_call Music_MountPyreRSE_Ch2_branch_2
	note_type 6, 10, 3
	rest 10
Music_MountPyreRSE_Ch2_loop_1:
	duty_cycle 0
	octave 3
	note A#, 1
	rest 1
	sound_loop 7, Music_MountPyreRSE_Ch2_loop_1
	note A#, 1
	note B_, 1
	note A#, 1
	rest 1
	note G#, 1
	rest 1
	note F#, 1
	rest 1
	note F_, 2
	note F#, 2
	volume_envelope 10, 0
	note G#, 16
	volume_envelope 10, 7
	note G#, 12
	volume_envelope 10, 3
	octave 4
	note D#, 2
	note C_, 2
	rest 2
	octave 3
	note A_, 1
	rest 1
	note F#, 1
	rest 1
	note A_, 1
	rest 1
	note C_, 1
	rest 1
	note D#, 1
	rest 1
	octave 2
	note A_, 1
	rest 1
	octave 3
	note C_, 1
	rest 1
	octave 2
	note F#, 1
	rest 1
	note A_, 1
	rest 1
	note_type 8, 10, 3
	octave 3
	note C_, 1
	note D#, 1
	note F#, 1
	octave 4
	note C_, 1
	note D#, 1
	note A#, 4
	note_type 12, 10, 3
	rest 14
	sound_jump Music_MountPyreRSE_Ch2_loop_main

Music_MountPyreRSE_Ch2_branch_1:
	octave 3
	volume_envelope 10, 3
	note G_, 2
	volume_envelope 6, 3
	note G_, 2
	volume_envelope 10, 3
	note D#, 2
	volume_envelope 6, 3
	note D#, 2
	volume_envelope 10, 3
	note G_, 2
	volume_envelope 6, 3
	note G_, 2
	volume_envelope 10, 3
	note G#, 2
	volume_envelope 6, 3
	note G#, 2
	volume_envelope 10, 3
	note G_, 2
	volume_envelope 6, 3
	note G_, 2
	volume_envelope 10, 3
	note D#, 2
	volume_envelope 6, 3
	note D#, 2
	volume_envelope 10, 3
	note D_, 2
	volume_envelope 6, 3
	note D_, 2
	volume_envelope 10, 3
	note C_, 2
	volume_envelope 6, 3
	note C_, 2
	volume_envelope 10, 3
	octave 2
	note B_, 2
	volume_envelope 6, 3
	note B_, 2
	volume_envelope 10, 3
	note G_, 2
	volume_envelope 6, 3
	note G_, 2
	volume_envelope 10, 3
	note B_, 2
	volume_envelope 6, 3
	note B_, 2
	octave 3
	volume_envelope 10, 3
	note C_, 2
	volume_envelope 6, 3
	note C_, 2
	volume_envelope 10, 3
	note D_, 2
	volume_envelope 6, 3
	note D_, 2
	volume_envelope 10, 3
	note D#, 2
	volume_envelope 6, 3
	note D#, 2
	volume_envelope 10, 3
	note D_, 2
	volume_envelope 6, 3
	note D_, 2
	volume_envelope 10, 3
	note G#, 2
	volume_envelope 6, 3
	note G#, 2
	sound_ret

Music_MountPyreRSE_Ch2_branch_2:
	octave 3
	volume_envelope 10, 3
	note A#, 2
	volume_envelope 6, 3
	note A#, 2
	volume_envelope 10, 3
	note F#, 2
	volume_envelope 6, 3
	note F#, 2
	volume_envelope 10, 3
	note A#, 2
	volume_envelope 6, 3
	note A#, 2
	volume_envelope 10, 3
	note B_, 2
	volume_envelope 6, 3
	note B_, 2
	volume_envelope 10, 3
	note A#, 2
	volume_envelope 6, 3
	note A#, 2
	volume_envelope 10, 3
	note F#, 2
	volume_envelope 6, 3
	note F#, 2
	volume_envelope 10, 3
	note F_, 2
	volume_envelope 6, 3
	note F_, 2
	volume_envelope 10, 3
	note D#, 2
	volume_envelope 6, 3
	note D#, 2
	volume_envelope 10, 3
	note D_, 2
	volume_envelope 6, 3
	note D_, 2
	octave 2
	volume_envelope 10, 3
	note A#, 2
	volume_envelope 6, 3
	note A#, 2
	volume_envelope 10, 3
	octave 3
	note D_, 2
	volume_envelope 6, 3
	note D_, 2
	volume_envelope 10, 3
	note D#, 2
	volume_envelope 6, 3
	note D#, 2
	volume_envelope 10, 3
	note F_, 2
	volume_envelope 6, 3
	note F_, 2
	volume_envelope 10, 3
	note F#, 2
	volume_envelope 6, 3
	note F#, 2
	volume_envelope 10, 3
	note F_, 2
	volume_envelope 6, 3
	note F_, 2
	volume_envelope 10, 3
	note B_, 2
	volume_envelope 6, 3
	note B_, 2
	sound_ret

Music_MountPyreRSE_Ch3:
	note_type 6, 2, 4
Music_MountPyreRSE_Ch3_loop_main:
Music_MountPyreRSE_Ch3_loop_1:
	octave 2
	note E_, 1
	note F#, 1
	note G_, 14
	sound_loop 16, Music_MountPyreRSE_Ch3_loop_1
Music_MountPyreRSE_Ch3_loop_2:
	octave 2
	note G_, 1
	note A_, 1
	note A#, 14
	sound_loop 16, Music_MountPyreRSE_Ch3_loop_2
	note G_, 1
	note A_, 1
	note_type 12, 1, 4
	octave 3
	note A#, 2
	octave 2
	note A#, 10
	note A#, 8
	octave 3
	note D_, 1
	octave 2
	note A#, 1
	note A_, 1
	note A#, 1
	octave 3
	note F_, 1
	note D_, 1
	note C#, 1
	note D_, 1
	note A#, 1
	note F_, 1
	note E_, 1
	note F_, 1
	octave 2
	note A_, 12
	note_type 8, 1, 4
	note A_, 1
	octave 3
	note C_, 1
	note D#, 1
	note F#, 1
	note A_, 1
	note A#, 4
	note_type 6, 2, 4
	rest 13
	rest 13
	sound_jump Music_MountPyreRSE_Ch3_loop_main

Music_MountPyreRSE_Ch4:
	toggle_noise 3
	drum_speed 12
	rest 1
Music_MountPyreRSE_Ch4_loop_main:
Music_MountPyreRSE_Ch4_loop_1:
	sound_call Music_MountPyreRSE_Ch4_branch_1
	sound_loop 4, Music_MountPyreRSE_Ch4_loop_1
Music_MountPyreRSE_Ch4_loop_2:
	sound_call Music_MountPyreRSE_Ch4_branch_2
	sound_loop 8, Music_MountPyreRSE_Ch4_loop_2
Music_MountPyreRSE_Ch4_loop_3:
	sound_call Music_MountPyreRSE_Ch4_branch_1
	sound_loop 4, Music_MountPyreRSE_Ch4_loop_3
Music_MountPyreRSE_Ch4_loop_4:
	sound_call Music_MountPyreRSE_Ch4_branch_2
	sound_loop 8, Music_MountPyreRSE_Ch4_loop_4
	rest 16
	rest 16
	rest 16
	rest 8
	drum_note 12, 8
	sound_jump Music_MountPyreRSE_Ch4_loop_main

Music_MountPyreRSE_Ch4_branch_1:
	stereo_panning TRUE, FALSE
	drum_note 9, 2
	drum_note 7, 2
	drum_note 9, 2
	drum_note 7, 2
	stereo_panning FALSE, TRUE
	drum_note 9, 2
	drum_note 7, 2
	drum_note 9, 2
	drum_note 7, 2
	sound_ret

Music_MountPyreRSE_Ch4_branch_2:
	stereo_panning TRUE, FALSE
	drum_note 9, 1
	drum_note 7, 1
	drum_note 9, 1
	drum_note 8, 1
	stereo_panning FALSE, TRUE
	drum_note 9, 1
	drum_note 7, 1
	drum_note 9, 1
	drum_note 8, 1
	sound_ret
