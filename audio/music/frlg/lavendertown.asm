; Pokémon FR/LG - Lavender Town
; Demixed by TriteHexagon
; https://github.com/TriteHexagon/Trite_ASM_Repository/blob/main/normal/LavenderTownFRLG.asm

Music_LavenderTownFRLG:
	channel_count 3
	channel 1, Music_LavenderTownFRLG_Ch1
	channel 2, Music_LavenderTownFRLG_Ch2
	channel 3, Music_LavenderTownFRLG_Ch3

Music_LavenderTownFRLG_Ch1:
	volume 7, 7
	duty_cycle $1
	note_type 6, 8, 3
	tempo 153
	stereo_panning TRUE, TRUE
;Bar 1
	octave 5
	note C_, 4
	volume_envelope 4, 3
	note C_, 4
	volume_envelope 8, 3
	note G_, 4
	volume_envelope 4, 3
	note G_, 4
	volume_envelope 8, 3
	note B_, 4
	volume_envelope 4, 3
	note B_, 4
	volume_envelope 8, 3
	note F#, 4
	volume_envelope 4, 3
	note F#, 4
	sound_jump Music_LavenderTownFRLG_Ch1

Music_LavenderTownFRLG_Ch2:
	duty_cycle $2
	note_type 12, 9, 7
	vibrato 0, 4, 2
Music_LavenderTownFRLG_Ch2_loop:
;Bar 1
	volume_envelope 10, 7
	rest 16
	rest 16
	rest 16
	rest 16
	octave 4
	note G_, 8
	note G_, 8
;Bar 6
	note E_, 8
	note E_, 8
;Bar 7
	note G_, 4
	note F#, 4
	note E_, 4
	note B_, 2
	note_type 6, 10, 7
	note A_, 1
	note G_, 1
	note F#, 1
	note E_, 1
;Bar 8
	note_type 12, 10, 7
	note C#, 8
	note C#, 8
;Bar 9
	note G_, 8
	note G_, 8
;Bar 10
	note F#, 8
	note F#, 8
;Bar 11
	note B_, 4
	note G_, 4
	note F#, 2
	note_type 6, 8, 7
	note G_, 1
	note G#, 1
	note A_, 1
	note A#, 1
	note_type 12, 10, 7
	note B_, 4
;Bar 12
	octave 5
	note C_, 8
	note C_, 8
;Bar 13
	note G_, 8
	note G_, 8
;Bar 14
	note E_, 8
	note E_, 8
;Bar 15
	note G_, 4
	note F#, 4
	note E_, 4
	note B_, 2
	note_type 6, 8, 7
	note A_, 1
	note G_, 1
	note F#, 1
	note E_, 1
;Bar 16
	note_type 12, 10, 7
	note C#, 8
	note C#, 8
;Bar 17
	note G_, 8
	note G_, 8
;Bar 18
	note F#, 8
	note F#, 8
;Bar 19
	note B_, 4
	note G_, 4
	note F#, 2
	note_type 6, 8, 7
	note G_, 1
	note G#, 1
	note A_, 1
	note A#, 1
	note_type 12, 10, 7
	note B_, 4
;Bar 20
	note C_, 8
	note C_, 8
;Bar 21
	octave 3
	note_type 6, 6, 8
	note E_, 16
	note E_, 15
	note D#, 1
;Bar 22
	note D_, 16
	note D_, 15
	note C#, 1
;Bar 23
	note C_, 16
	note C_, 13
	note C#, 1
	note D_, 1
	note D#, 1
;Bar 24
	note E_, 5
	note D#, 1
	note D_, 1
	note C#, 1
	note C_, 8
	octave 2
	note B_, 4
	octave 3
	note C_, 1
	note C#, 1
	note D_, 1
	note D#, 1
	note E_, 8
;Bar 25
	note_type 12, 4, -6
	sound_call Music_LavenderTownFRLG_Ch2_Main
;Bar 32
	octave 5
	note C_, 8
	note C_, 8
;Bar 33
	sound_call Music_LavenderTownFRLG_Ch2_Main
;Bar 40
	note C_, 8
	note C_, 8
	sound_jump Music_LavenderTownFRLG_Ch2_loop

Music_LavenderTownFRLG_Ch2_Main:
	octave 4
	note G_, 8
	note G_, 8
;Bar 26
	note E_, 8
	note E_, 8
;Bar 27
	note G_, 4
	note F#, 4
	note E_, 4
	note B_, 4
;Bar 28
	note C#, 8
	note C#, 8
;Bar 29
	note G_, 8
	note G_, 8
;Bar 30
	note F#, 8
	note F#, 8
;Bar 31
	note B_, 4
	note G_, 4
	note F#, 4
	note B_, 4
	sound_ret

Music_LavenderTownFRLG_Ch3:
	note_type 12, 2, 7
;Bar 1
	rest 16
	rest 16
	rest 16
	rest 12
;Bar 4
	octave 2
	note G_, 2
	note F#, 1
	note F_, 1
Music_LavenderTownFRLG_Ch3_loop:
;Bar 5
	sound_call Music_LavenderTownFRLG_Ch3_Main
;Bar 9
	sound_call Music_LavenderTownFRLG_Ch3_Main
;Bar 13
	sound_call Music_LavenderTownFRLG_Ch3_Main
;Bar 17
	octave 4
	sound_call Music_LavenderTownFRLG_Ch3_Bar17
;Bar 18
	sound_call Music_LavenderTownFRLG_Ch3_Bar17
;Bar 19
	volume_envelope 3, 7
	octave 5
	sound_call Music_LavenderTownFRLG_Ch3_Bar17
	volume_envelope 2, 7
;Bar 20
	sound_call Music_LavenderTownFRLG_Ch3_Bar20
;Bar 21
	sound_call Music_LavenderTownFRLG_Ch3_Main
;Bar 25
	sound_call Music_LavenderTownFRLG_Ch3_Main
;Bar 29
	sound_call Music_LavenderTownFRLG_Ch3_Main
;Bar 33
	octave 4
	sound_call Music_LavenderTownFRLG_Ch3_Bar17
;Bar 34
	sound_call Music_LavenderTownFRLG_Ch3_Bar17
;Bar 35
	volume_envelope 3, 7
	octave 5
	sound_call Music_LavenderTownFRLG_Ch3_Bar17
	volume_envelope 2, 7
;Bar 36
	sound_call Music_LavenderTownFRLG_Ch3_Bar20
;Bar 37
	sound_call Music_LavenderTownFRLG_Ch3_Main
;Bar 41
	sound_call Music_LavenderTownFRLG_Ch3_Main
	sound_jump Music_LavenderTownFRLG_Ch3_loop

Music_LavenderTownFRLG_Ch3_Main:
;Bar 5
	note E_, 16
;Bar 6
	note D_, 16
;Bar 7
	note C_, 16
;Bar 8
	note E_, 4
	note C_, 4
	octave 1
	note B_, 4
	octave 2
	note E_, 4
	sound_ret

Music_LavenderTownFRLG_Ch3_Bar17:
	note B_, 4
	note G_, 4
	note F#, 4
	note B_, 4
	sound_ret

Music_LavenderTownFRLG_Ch3_Bar20:
	octave 2
	note E_, 4
	note G_, 4
	note F#, 4
	note B_, 4
	sound_ret
