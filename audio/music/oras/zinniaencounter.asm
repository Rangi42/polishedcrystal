; Pokémon OR/AS - Encounter! Zinnia
; Demixed by Mmmmmm
; https://pastebin.com/eXmCVCCX
; https://hax.iimarckus.org/topic/6777/4/

Music_ZinniaEncounterORAS:
	channel_count 4
	channel 1, Music_ZinniaEncounterORAS_Ch1
	channel 2, Music_ZinniaEncounterORAS_Ch2
	channel 3, Music_ZinniaEncounterORAS_Ch3
	channel 4, Music_ZinniaEncounterORAS_Ch4

Music_ZinniaEncounterORAS_Ch1:
	tempo 176
	volume 7, 7
	duty_cycle 0
	pitch_offset 2
	vibrato 8, 1, 5
	note_type 12, 10, 3
	octave 2
	note B_, 8
Music_ZinniaEncounterORAS_Ch1_loop:
	rest 4
	octave 3
	note F#, 1
	note G#, 2
	volume_envelope 10, 6
	note A_, 3
	volume_envelope 10, 3
	note G#, 2
	note F#, 1
	note G#, 1
	rest 2
	volume_envelope 10, 7
	note C#, 8
	volume_envelope 10, 4
	note F#, 3
	note G#, 3
	note A_, 2
	volume_envelope 10, 7
	note E_, 6
	note C#, 2
	volume_envelope 10, 4
	note A_, 3
	note B_, 3
	note A_, 2
	volume_envelope 10, 7
	note G#, 6
	note F#, 2
	volume_envelope 10, 4
	note E_, 4
	note G#, 4
	volume_envelope 10, 3
	rest 2
	note F#, 1
	note G#, 2
	note A_, 2
	volume_envelope 10, 5
	note B_, 3
	volume_envelope 10, 3
	note A_, 2
	note G#, 1
	note A_, 1
	rest 2
	volume_envelope 10, 7
	note E_, 8
	volume_envelope 10, 4
	note F#, 3
	note G#, 3
	note A_, 2
	note_type 6, 10, 0
	octave 4
	note C_, 1
	note C#, 7
	note_type 12, 10, 6
	note C#, 4
	volume_envelope 10, 4
	note C#, 3
	note D_, 3
	note C#, 2
	octave 3
	volume_envelope 10, 7
	note B_, 6
	volume_envelope 10, 4
	note G#, 2
	note G#, 4
	note B_, 4
	octave 4
	volume_envelope 6, 0
	note D_, 4
	volume_envelope 6, -7
	note D_, 4
	volume_envelope 6, 0
	note E_, 4
	volume_envelope 6, -7
	note E_, 4
	octave 3
	volume_envelope 6, 0
	note A_, 4
	volume_envelope 6, -7
	note A_, 4
	volume_envelope 6, 0
	note B_, 4
	volume_envelope 6, -7
	note B_, 4
	volume_envelope 6, 0
	note D_, 4
	volume_envelope 6, -7
	note D_, 4
	volume_envelope 6, 0
	note C#, 4
	volume_envelope 6, -7
	note C#, 4
	volume_envelope 6, 0
	note D_, 4
	volume_envelope 6, -7
	note D_, 4
	volume_envelope 6, 0
	note F_, 4
	volume_envelope 6, -7
	note F_, 4
	octave 4
	volume_envelope 2, 0
	note D_, 2
	volume_envelope 2, -6
	note D_, 4
	volume_envelope 10, 6
	note F#, 2
	note E_, 3
	octave 3
	note B_, 3
	octave 4
	note C#, 2
	octave 3
	note A_, 8
	note G_, 8
	note D_, 6
	note A_, 2
	note G#, 3
	note F#, 3
	note E_, 2
	note D_, 6
	note A_, 2
	note G#, 4
	note A_, 2
	note B_, 2
	note A_, 6
	octave 4
	note C#, 2
	octave 3
	note B_, 8
	volume_envelope 10, 0
	note A_, 1
	rest 2
	note A_, 3
	note G#, 2
	note A_, 1
	rest 3
	volume_envelope 10, 6
	note A_, 4
	volume_envelope 10, 3
	sound_jump Music_ZinniaEncounterORAS_Ch1_loop

Music_ZinniaEncounterORAS_Ch2:
	duty_cycle 1
	vibrato 18, 2, 5
	pitch_offset 1
	note_type 12, 11, 3
	octave 2
	note C#, 1
	octave 3
	note C#, 1
	note F#, 1
	note G#, 1
	note A_, 1
	note B_, 1
	note A_, 1
	note G#, 1
Music_ZinniaEncounterORAS_Ch2_loop_main:
	vibrato 18, 2, 5
	volume_envelope 11, 0
	octave 3
	note C#, 2
	sound_call Music_ZinniaEncounterORAS_Ch2_branch_1
	note_type 6, 11, 0
	note C_, 1
	note C#, 7
	note_type 12, 11, 6
	note C#, 4
	note C#, 3
	note D_, 3
	note C#, 2
	octave 3
	volume_envelope 11, 7
	note B_, 6
	volume_envelope 11, 6
	note A_, 2
	note G#, 4
	note B_, 4
	note A_, 1
	note G#, 1
	volume_envelope 11, 0
	sound_call Music_ZinniaEncounterORAS_Ch2_branch_1
	note_type 6, 11, 0
	note D#, 1
	note E_, 7
	note_type 12, 11, 6
	note E_, 4
	note E_, 3
	note F#, 3
	note E_, 2
	volume_envelope 11, 7
	note E_, 6
	volume_envelope 11, 3
	octave 3
	note B_, 2
	volume_envelope 11, 6
	note B_, 4
	octave 4
	note E_, 4
Music_ZinniaEncounterORAS_Ch2_loop_1:
	vibrato 34, 4, 3
	volume_envelope 4, 0
	note F#, 2
	volume_envelope 4, -6
	note F#, 4
	volume_envelope 12, 6
	note A_, 2
	note G#, 3
	note E_, 3
	note F#, 2
	note C#, 6
	octave 3
	note B_, 2
	octave 4
	note C#, 4
	octave 3
	note B_, 4
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
	sound_loop 2, Music_ZinniaEncounterORAS_Ch2_loop_1
	note F#, 6
	note A_, 2
	note G#, 2
	note F#, 2
	note E_, 2
	note G#, 2
	volume_envelope 13, 7
	note F#, 1
	note G#, 1
	rest 1
	note A_, 2
	note B_, 1
	note A_, 1
	note G#, 1
	note F#, 1
	rest 3
	note F#, 4
	sound_jump Music_ZinniaEncounterORAS_Ch2_loop_main

Music_ZinniaEncounterORAS_Ch2_branch_1:
	note C#, 6
	volume_envelope 11, 6
	note C#, 6
	octave 2
	note A_, 1
	note B_, 1
	octave 3
	volume_envelope 11, 0
	note C#, 4
	volume_envelope 11, 6
	note C#, 4
	note A_, 3
	note B_, 3
	octave 4
	note C#, 2
	sound_ret

Music_ZinniaEncounterORAS_Ch3:
	note_type 12, 1, 4
	vibrato 18, 1, 5
	octave 2
	note G#, 2
	rest 6
Music_ZinniaEncounterORAS_Ch3_loop:
	sound_call Music_ZinniaEncounterORAS_Ch3_branch_1
	octave 1
	note B_, 2
	rest 2
	octave 2
	sound_call Music_ZinniaEncounterORAS_Ch3_branch_1
	octave 1
	note B_, 2
	octave 2
	note E_, 2
	sound_call Music_ZinniaEncounterORAS_Ch3_branch_2
	octave 1
	note B_, 2
	rest 2
	note F#, 2
	note B_, 2
	octave 2
	note C#, 2
	rest 2
	note G#, 2
	note C#, 2
	sound_call Music_ZinniaEncounterORAS_Ch3_branch_2
	octave 1
	note B_, 2
	rest 2
	octave 2
	note F#, 2
	octave 1
	note B_, 2
	octave 2
	note C#, 2
	rest 2
	note G#, 2
	note C#, 2
	note D_, 2
	rest 2
	octave 1
	note A_, 2
	octave 2
	note D_, 2
	note E_, 2
	rest 2
	octave 1
	note B_, 2
	octave 2
	note E_, 2
	note F#, 1
	rest 2
	note F#, 3
	note E_, 2
	note F#, 1
	rest 3
	note F#, 2
	rest 2
	sound_jump Music_ZinniaEncounterORAS_Ch3_loop

Music_ZinniaEncounterORAS_Ch3_branch_1:
	note F#, 2
	rest 2
	note C#, 2
	rest 2
	note F#, 2
	rest 2
	note C#, 2
	rest 2
	note D_, 2
	rest 2
	octave 1
	note A_, 2
	rest 2
	octave 2
	note D_, 2
	rest 2
	octave 1
	note A_, 2
	rest 2
	octave 2
	note A_, 2
	rest 2
	note E_, 2
	rest 2
	note A_, 2
	rest 2
	note E_, 2
	note A_, 2
	note E_, 2
	rest 2
	octave 1
	note B_, 2
	rest 2
	octave 2
	note E_, 2
	rest 2
	sound_ret

Music_ZinniaEncounterORAS_Ch3_branch_2:
	note D_, 2
	rest 2
	octave 1
	note A_, 2
	octave 2
	note D_, 2
	note E_, 2
	rest 2
	octave 1
	note B_, 2
	octave 2
	note E_, 2
	note F#, 2
	rest 2
	note C#, 2
	rest 2
	note G_, 2
	rest 2
	note D_, 2
	note G_, 2
	note D_, 2
	rest 2
	octave 1
	note A_, 2
	octave 2
	note D_, 2
	note C#, 2
	rest 2
	octave 1
	note G#, 2
	octave 2
	note C#, 2
	sound_ret

Music_ZinniaEncounterORAS_Ch4:
	toggle_noise 3
	drum_speed 12
	drum_note 12, 8
Music_ZinniaEncounterORAS_Ch4_loop_main:
Music_ZinniaEncounterORAS_Ch4_loop_1:
	drum_note 1, 2
	drum_note 2, 1
	drum_note 2, 1
	drum_note 1, 2
	drum_note 4, 2
	sound_loop 8, Music_ZinniaEncounterORAS_Ch4_loop_1
	drum_note 12, 2
	drum_note 2, 1
	drum_note 2, 1
	drum_note 1, 2
	drum_note 4, 2
Music_ZinniaEncounterORAS_Ch4_loop_2:
	drum_note 1, 2
	drum_note 2, 1
	drum_note 2, 1
	drum_note 1, 2
	drum_note 4, 2
	sound_loop 7, Music_ZinniaEncounterORAS_Ch4_loop_2
	drum_note 12, 2
	drum_note 2, 1
	drum_note 2, 1
	drum_note 1, 2
	drum_note 4, 2
Music_ZinniaEncounterORAS_Ch4_loop_3:
	drum_note 1, 2
	drum_note 2, 1
	drum_note 2, 1
	drum_note 1, 2
	drum_note 4, 2
	sound_loop 7, Music_ZinniaEncounterORAS_Ch4_loop_3
	drum_note 12, 2
	drum_note 2, 1
	drum_note 2, 1
	drum_note 1, 2
	drum_note 4, 2
Music_ZinniaEncounterORAS_Ch4_loop_4:
	drum_note 1, 2
	drum_note 2, 1
	drum_note 2, 1
	drum_note 1, 2
	drum_note 4, 2
	sound_loop 7, Music_ZinniaEncounterORAS_Ch4_loop_4
	drum_note 12, 2
	drum_note 2, 1
	drum_note 2, 1
	drum_note 1, 2
	drum_note 4, 2
	drum_note 1, 2
	drum_note 2, 1
	drum_note 2, 1
	drum_note 1, 2
	drum_note 4, 2
	drum_note 1, 2
	drum_note 2, 1
	drum_note 1, 2
	drum_note 2, 1
	drum_note 1, 2
	drum_note 12, 2
	drum_note 2, 1
	drum_note 2, 1
	drum_note 1, 4
	sound_jump Music_ZinniaEncounterORAS_Ch4_loop_main
