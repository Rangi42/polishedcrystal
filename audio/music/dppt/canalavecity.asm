; Pokémon D/P/Pt - Canalave City
; Demixed by FroggestSpirit
; https://github.com/froggestspirit/pokecrystal/blob/master/Demixes.zip

Music_CanalaveCityDPPt:
	dbw $C0, Music_CanalaveCityDPPt_Ch1
	dbw $01, Music_CanalaveCityDPPt_Ch2
	dbw $02, Music_CanalaveCityDPPt_Ch3
	dbw $03, Music_CanalaveCityDPPt_Ch4

Music_CanalaveCityDPPt_Ch1:
	tempo $CE
	volume 7, 7
	note_type 12, 10, 7
	duty_cycle 1
	tone $0002
	octave 1
	note E_, 2
Music_CanalaveCityDPPt_Ch1_loop:
	octave 1
	note A_, 2
	octave 2
	note E_, 2
	note A_, 2
	note B_, 2
	octave 3
	note C#, 2
	octave 2
	note A_, 2
	note B_, 2
	note E_, 2
	octave 1
	note A_, 2
	octave 2
	note E_, 2
	note A_, 2
	note B_, 2
	octave 3
	note C#, 2
	octave 2
	note A_, 2
	note B_, 2
	note E_, 1
	note_type 6, 10, 7
	octave 3
	note E_, 1
	note A_, 1
	note_type 13, 10, 7
	note A_, 12
	note_type 6, 10, 7
	note G#, 1
	octave 4
	note C#, 1
	note C#, 16
	note __, 16
	note __, 2
	octave 3
	note G_, 1
	note B_, 1
	note_type 15, 10, 7
	note B_, 12
	note_type 6, 10, 7
	note F#, 1
	note A_, 1
	octave 4
	note C#, 8
	octave 3
	note A_, 8
	note F#, 8
	note A_, 6
	note F_, 1
	note A_, 1
	note A_, 12
	note B_, 12
	note A_, 6
	note C#, 1
	note E_, 1
	note A_, 9
	note A_, 1
	octave 4
	note C#, 1
	note E_, 16
	note __, 3
	octave 2
	note B_, 1
	octave 3
	note D#, 1
	note F#, 9
	note F#, 1
	note B_, 1
	octave 4
	note D#, 13
	octave 3
	note F#, 8
	note F#, 4
	note E_, 4
	note D#, 4
	note_type 12, 10, 7
	note E_, 9
	note_type 6, 10, 7
	note E_, 1
	note A_, 1
	note_type 13, 10, 7
	note A_, 12
	note_type 6, 10, 7
	note G#, 1
	octave 4
	note C#, 1
	note C#, 16
	note __, 16
	note __, 2
	octave 3
	note G_, 1
	note B_, 1
	note_type 15, 10, 7
	note B_, 12
	note_type 6, 10, 7
	note F#, 1
	note A_, 1
	note_type 15, 10, 7
	note A_, 12
	note_type 6, 10, 7
	note F_, 1
	note A_, 1
	note A_, 4
	note F_, 4
	note A_, 4
	note B_, 4
	note_type 8, 10, 7
	octave 4
	note D_, 4
	octave 3
	note B_, 4
	note_type 10, 10, 7
	note A_, 2
	note_type 6, 10, 7
	note E_, 1
	note A_, 1
	note A_, 8
	note E_, 4
	octave 4
	note D_, 8
	note E_, 10
	octave 3
	note D#, 1
	note F#, 1
	note F#, 12
	note D#, 4
	note_type 8, 10, 7
	note B_, 4
	octave 4
	note D#, 4
	octave 3
	note A_, 4
	note F#, 9
	note_type 12, 10, 7
	note E_, 1
	note D#, 1
	note E_, 8
	note F_, 10
	note G_, 2
	note E_, 1
	note D_, 2
	note E_, 14
	octave 2
	note E_, 2
	note A_, 1
	octave 3
	note C_, 10
	note E_, 1
	note F_, 1
	note E_, 1
	note D_, 2
	octave 2
	note B_, 1
	octave 3
	note C_, 1
	note D_, 2
	note D#, 1
	note E_, 2
	note E_, 7
	note E_, 2
	note F_, 1
	note F_, 10
	note B_, 1
	octave 4
	note C_, 1
	octave 3
	note B_, 1
	note A_, 1
	note G_, 1
	note B_, 1
	note A_, 3
	note G_, 3
	note G_, 1
	note F#, 3
	note D_, 2
	note D_, 1
	note F_, 3
	note A_, 3
	note A_, 3
	note G#, 1
	note A_, 1
	note A_, 3
	note F_, 5
	note G_, 3
	note G_, 3
	note F#, 1
	note E_, 1
	note E_, 2
	note E_, 2
	note F#, 1
	note G_, 3
	note A_, 1
	note A_, 2
	note F_, 3
	note G_, 1
	note A_, 1
	note B_, 6
	note G_, 1
	note D_, 1
	volume_envelope 10, 2
	note G_, 2
	volume_envelope 10, 8
	note E_, 14
	note E_, 8
	volume_envelope 10, 7
	note E_, 8
	jumpchannel Music_CanalaveCityDPPt_Ch1_loop

Music_CanalaveCityDPPt_Ch2:
	note_type 12, 11, 7
	duty_cycle 1
	tone $0001
	octave 3
	note __, 2
Music_CanalaveCityDPPt_Ch2_loop:
	note __, 16
	note __, 10
	note E_, 2
	note A_, 2
	note B_, 2
	octave 4
	note C#, 4
	octave 3
	note B_, 2
	octave 4
	note C#, 4
	note D_, 4
	note E_, 14
	note C#, 2
	note D_, 2
	note E_, 10
	note E_, 2
	note F#, 2
	note C#, 2
	note E_, 4
	note D_, 4
	note C#, 4
	note E_, 4
	note D_, 6
	note E_, 6
	note D_, 4
	note C#, 6
	note A_, 10
	octave 3
	note B_, 6
	octave 4
	note A_, 6
	octave 3
	note B_, 4
	note A_, 2
	note G#, 2
	note F#, 2
	note G#, 4
	note E_, 2
	octave 4
	note E_, 2
	note D_, 2
	note C#, 4
	octave 3
	note B_, 2
	octave 4
	note C#, 4
	note D_, 4
	note E_, 14
	note C#, 2
	note D_, 2
	note E_, 10
	note E_, 2
	note F#, 2
	note C#, 2
	note E_, 4
	note D_, 4
	note_type 8, 11, 7
	note C#, 4
	note E_, 4
	note D_, 4
	note D_, 3
	octave 3
	note A_, 3
	octave 4
	note D_, 3
	note E_, 3
	note F_, 4
	note E_, 4
	note D_, 4
	note C#, 6
	octave 3
	note A_, 3
	octave 4
	note G#, 6
	note A_, 9
	octave 3
	note B_, 9
	note F#, 3
	octave 4
	note G#, 4
	note A_, 4
	note F#, 4
	octave 3
	note A_, 9
	note_type 12, 11, 7
	note G#, 1
	note F#, 1
	note G#, 4
	note_type 6, 11, 7
	octave 2
	note A_, 1
	note B_, 1
	octave 3
	note C_, 1
	note D_, 1
	note E_, 1
	note F_, 1
	note F#, 1
	note G_, 1
	note_type 15, 11, 7
	note A_, 8
	note_type 12, 11, 7
	note B_, 2
	note G_, 1
	note F_, 2
	note G_, 14
	octave 2
	note G_, 2
	octave 3
	note C_, 1
	note F_, 10
	note G_, 1
	note A_, 1
	note G_, 1
	note F_, 2
	note D_, 1
	note E_, 1
	note F_, 2
	note F#, 1
	note G_, 2
	note A#, 7
	note G_, 2
	note G#, 1
	note A_, 10
	octave 4
	note D_, 1
	note E_, 1
	note D_, 1
	note C_, 1
	octave 3
	note B_, 1
	octave 4
	note D_, 1
	note C_, 12
	note C_, 1
	octave 3
	note B_, 1
	note A_, 1
	note B_, 1
	octave 4
	note C_, 12
	note C_, 1
	octave 3
	note B_, 1
	note A_, 1
	note B_, 1
	octave 4
	note C_, 7
	octave 3
	note G_, 1
	note G_, 6
	note G_, 1
	note B_, 1
	octave 4
	note C_, 6
	octave 3
	note B_, 1
	octave 4
	note C_, 1
	note D_, 6
	octave 3
	note B_, 1
	note G_, 1
	volume_envelope 11, 2
	note B_, 2
	volume_envelope 11, 8
	note A_, 14
	note A_, 8
	volume_envelope 11, 7
	note A_, 8
	jumpchannel Music_CanalaveCityDPPt_Ch2_loop

Music_CanalaveCityDPPt_Ch3:
	note_type 12, 2, 5
	octave 4
	note __, 2
Music_CanalaveCityDPPt_Ch3_loop:
	note_type 8, 2, 5
	octave 3
	note A_, 1
	octave 4
	note E_, 1
	note A_, 1
	octave 5
	note C#, 1
	note B_, 1
	note C#, 1
	octave 3
	note A_, 1
	octave 4
	note E_, 1
	note A_, 1
	octave 5
	note C#, 1
	note B_, 1
	note C#, 1
	octave 3
	note A_, 1
	octave 4
	note E_, 1
	note A_, 1
	octave 5
	note C#, 1
	note B_, 1
	note C#, 1
	octave 3
	note A_, 1
	octave 4
	note E_, 1
	note A_, 1
	octave 5
	note C#, 1
	note B_, 1
	note C#, 1
	octave 3
	note A_, 1
	octave 4
	note E_, 1
	note A_, 1
	octave 5
	note C#, 1
	note B_, 1
	note C#, 1
	octave 3
	note A_, 1
	octave 4
	note E_, 1
	note A_, 1
	octave 5
	note C#, 1
	note B_, 1
	note C#, 1
	octave 3
	note A_, 1
	octave 4
	note A_, 1
	octave 5
	note E_, 1
	note B_, 1
	octave 6
	note C#, 1
	octave 5
	note A_, 1
	note C#, 1
	note E_, 1
	octave 4
	note B_, 1
	note A_, 1
	octave 5
	note C#, 1
	octave 4
	note E_, 1
	note_type 12, 1, 0
	octave 2
	note A_, 16
	octave 3
	note C#, 16
	octave 2
	note G_, 16
	note F#, 16
	note F_, 16
	note E_, 16
	note D#, 16
	note E_, 14
	note E_, 1
	note C#, 1
	octave 1
	note A_, 6
	note A_, 1
	note __, 1
	note A_, 8
	octave 2
	note C#, 6
	note C#, 1
	note __, 1
	note C#, 8
	octave 1
	note G_, 6
	note G_, 2
	note __, 2
	note G_, 2
	octave 2
	note D_, 2
	octave 1
	note B_, 2
	note F#, 6
	note F#, 1
	note __, 1
	note_type 8, 1, 0
	octave 2
	note D_, 4
	octave 1
	note A_, 4
	octave 2
	note D_, 4
	octave 1
	note F_, 9
	note A_, 3
	octave 2
	note D_, 4
	note E_, 4
	note F_, 4
	note E_, 9
	octave 1
	note A_, 6
	note A_, 6
	note A#, 3
	note B_, 9
	note B_, 3
	octave 2
	note F#, 4
	note D#, 4
	note A_, 4
	note E_, 9
	note_type 12, 1, 0
	note E_, 1
	note __, 1
	note E_, 4
	note D_, 4
	note F_, 1
	note F_, 1
	note __, 4
	note F_, 1
	note F_, 1
	note __, 2
	note F_, 2
	note __, 1
	octave 3
	note F_, 1
	octave 2
	note F_, 2
	note F#, 1
	note G_, 1
	note __, 1
	note E_, 4
	note G_, 1
	note __, 1
	note G_, 1
	note C_, 1
	note __, 1
	note G_, 1
	note __, 1
	note C_, 2
	note D_, 1
	note D_, 1
	note __, 1
	octave 1
	note A_, 2
	note __, 1
	octave 2
	note C#, 1
	note D_, 1
	note __, 2
	note G_, 2
	note __, 1
	note G_, 1
	octave 1
	note G_, 2
	octave 2
	note C_, 1
	note C_, 1
	note __, 4
	note C_, 1
	note C_, 1
	note C#, 1
	note C#, 1
	note __, 1
	octave 1
	note G_, 3
	octave 2
	note E_, 2
	note F_, 1
	note F_, 1
	note __, 1
	note C_, 2
	note __, 1
	note F_, 1
	note F_, 1
	note F_, 1
	note __, 1
	note D_, 2
	note G#, 1
	note B_, 1
	note E_, 2
	note A_, 3
	octave 3
	note C_, 3
	octave 2
	note G_, 1
	note D_, 3
	note F#, 1
	note __, 1
	note F#, 1
	note __, 1
	note D_, 2
	note D_, 1
	note D_, 1
	note __, 1
	octave 1
	note A_, 3
	octave 2
	note C#, 1
	note D_, 1
	note __, 8
	note E_, 1
	note E_, 1
	note __, 1
	octave 1
	note B_, 3
	octave 2
	note D#, 1
	note E_, 1
	note __, 8
	note F_, 1
	note F_, 1
	note __, 1
	note C_, 3
	note F_, 1
	note G_, 1
	note D_, 6
	note __, 2
	note_type 8, 2, 5
	octave 3
	note A_, 1
	octave 4
	note E_, 1
	note A_, 1
	octave 5
	note C#, 1
	note B_, 1
	note C#, 1
	octave 3
	note A_, 1
	octave 4
	note E_, 1
	note A_, 1
	octave 5
	note C#, 1
	note B_, 1
	note C#, 1
	octave 3
	note A_, 1
	octave 4
	note E_, 1
	note A_, 1
	octave 5
	note C#, 1
	note B_, 1
	note C#, 1
	octave 3
	note A_, 1
	octave 4
	note E_, 1
	note A_, 1
	octave 5
	note C#, 1
	note B_, 1
	note C#, 1
	octave 3
	note A_, 1
	octave 4
	note E_, 1
	note A_, 1
	octave 5
	note C#, 1
	note B_, 1
	note C#, 1
	octave 3
	note A_, 1
	octave 4
	note E_, 1
	note A_, 1
	octave 5
	note C#, 1
	note B_, 1
	note C#, 1
	octave 3
	note A_, 1
	octave 4
	note A_, 1
	octave 5
	note E_, 1
	note B_, 1
	octave 6
	note C#, 1
	octave 5
	note A_, 1
	note C#, 1
	note E_, 1
	octave 4
	note B_, 1
	note A_, 1
	octave 5
	note C#, 1
	octave 4
	note E_, 1
	jumpchannel Music_CanalaveCityDPPt_Ch3_loop

Music_CanalaveCityDPPt_Ch4:
	togglenoise 3
	note_type 12
	note __, 2
Music_CanalaveCityDPPt_Ch4_loop:
	note __, 16
	note __, 16
	note __, 16
	note __, 16
	note __, 16
	note __, 16
	note __, 16
	note __, 16
	note __, 16
	note __, 16
	note A#, 6
	note A#, 2
	note A#, 4
	note C_, 4
	note A#, 6
	note A#, 2
	note A#, 4
	note C_, 4
	note A#, 6
	note A#, 4
	note A#, 2
	note C_, 4
	note A#, 6
	note A#, 2
	note_type 8
	note C_, 4
	note A#, 4
	note A#, 4
	note A#, 9
	note A#, 3
	note A#, 4
	note A#, 8
	note A#, 9
	note A#, 6
	note A#, 3
	note C_, 6
	note A#, 9
	note A#, 6
	note A#, 3
	note C_, 6
	note A#, 9
	note A#, 3
	note A#, 6
	note C_, 6
	note_type 12
	note A#, 1
	note A#, 3
	note C_, 2
	note A#, 1
	note A#, 3
	note A#, 2
	note A#, 1
	note C_, 2
	note C_, 1
	note A#, 1
	note A#, 3
	note C_, 2
	note A#, 1
	note C_, 1
	note C_, 1
	note A#, 1
	note A#, 2
	note C_, 1
	note C_, 1
	note A#, 2
	note A#, 1
	note A#, 2
	note A#, 1
	note C_, 2
	note A#, 1
	note A#, 3
	note A#, 2
	note C_, 4
	note A#, 1
	note A#, 2
	note A#, 1
	note C_, 2
	note A#, 1
	note A#, 2
	note A#, 2
	note A#, 1
	note C_, 2
	note A#, 2
	note A#, 1
	note A#, 2
	note C_, 3
	note A#, 1
	note A#, 1
	note A#, 2
	note A#, 2
	note A#, 1
	note C_, 1
	note A#, 2
	note A#, 1
	note A#, 2
	note C_, 3
	note A#, 1
	note A#, 3
	note A#, 2
	note C_, 1
	note A#, 1
	note A#, 2
	note A#, 1
	note A#, 2
	note C_, 3
	note A#, 1
	note A#, 3
	note A#, 2
	note C_, 4
	note A#, 1
	note A#, 2
	note C_, 3
	note A#, 1
	note A#, 1
	note A#, 2
	note A#, 2
	note C_, 1
	note C_, 1
	note A#, 2
	note A#, 1
	note A#, 2
	note C_, 3
	note A#, 1
	note A#, 3
	note A#, 2
	note C_, 4
	note A#, 1
	note A#, 2
	note C_, 3
	note A#, 1
	note A#, 3
	note A#, 2
	note C_, 4
	note A#, 1
	note A#, 2
	note C_, 3
	note A#, 1
	note A#, 3
	note A#, 2
	note C_, 1
	note A#, 2
	note C_, 1
	jumpchannel Music_CanalaveCityDPPt_Ch4_loop
