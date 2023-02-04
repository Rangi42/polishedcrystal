; Pokémon D/P/Pt - Game Corner
; Demixed by FroggestSpirit
; https://github.com/froggestspirit/CrystalComplete/blob/master/audio/music/DPPt/gamecorner.asm

Music_GameCornerDPPt:
	dbw $C0, Music_GameCornerDPPt_Ch1
	dbw $01, Music_GameCornerDPPt_Ch2
	dbw $02, Music_GameCornerDPPt_Ch3
	dbw $03, Music_GameCornerDPPt_Ch4

Music_GameCornerDPPt_Ch1:
	tempo $7C
	volume 7, 7
	note_type 12, 10, 2
	duty_cycle 2
	pitch_offset 1
	stereo_panning FALSE, TRUE
	octave 4
	note __, 16
	note __, 16
	note __, 16
	note __, 16
	note C_, 1
	note C_, 1
	note C_, 2
	note C_, 1
	note C_, 1
	note C_, 2
	octave 3
	note A_, 1
	note A_, 1
	note A_, 2
	note A_, 1
	note A_, 1
	note A_, 2
	note B_, 1
	note B_, 1
	note B_, 2
	note B_, 1
	note B_, 1
	note B_, 2
	note G_, 1
	note G_, 1
	note G_, 2
	note G_, 1
	note G_, 1
	note G_, 2
	note A_, 1
	note A_, 1
	note A_, 2
	note A_, 1
	note A_, 1
	note A_, 2
	note A_, 1
	note A_, 1
	note A_, 2
	note A_, 1
	note A_, 1
	note A_, 2
	note B_, 1
	note B_, 1
	note B_, 2
	note B_, 1
	note B_, 1
	note B_, 2
	note B_, 1
	note B_, 1
	note B_, 2
	note B_, 1
	note B_, 1
	note B_, 1
	note B_, 1
	octave 4
	note C_, 1
	note C_, 1
	note C_, 2
	note C_, 1
	note C_, 1
	note C_, 2
	octave 3
	note A_, 1
	note A_, 1
	note A_, 2
	note A_, 1
	note A_, 1
	note A_, 2
Music_GameCornerDPPt_Ch1_loop:
	note B_, 1
	note B_, 1
	note B_, 2
	note B_, 1
	note B_, 1
	note B_, 2
	note G_, 1
	note G_, 1
	note G_, 2
	note G_, 1
	note G_, 1
	note G_, 2
	note A_, 1
	note A_, 1
	note A_, 2
	note A_, 1
	note A_, 1
	note A_, 2
	note A_, 1
	note A_, 1
	note A_, 2
	note A_, 1
	note A_, 1
	note A_, 2
	note B_, 1
	note B_, 1
	note B_, 2
	note B_, 1
	note B_, 1
	note B_, 2
	note B_, 1
	note B_, 1
	note B_, 2
	note B_, 1
	note B_, 1
	note B_, 2
	volume_envelope 5, -1
	note A_, 1
	volume_envelope 10, 2
	note A_, 1
	note A_, 2
	volume_envelope 5, -1
	note A_, 1
	volume_envelope 10, 2
	note A_, 1
	note A_, 2
	volume_envelope 5, -1
	note A_, 1
	volume_envelope 10, 2
	note A_, 1
	note A_, 2
	volume_envelope 5, -1
	note A_, 1
	volume_envelope 10, 2
	note A_, 1
	note G#, 2
	volume_envelope 3, -1
	note F#, 1
	volume_envelope 10, 2
	note F#, 1
	note F#, 2
	volume_envelope 3, -1
	note F#, 1
	volume_envelope 10, 2
	note F#, 1
	note F#, 2
	volume_envelope 3, -1
	note F#, 1
	volume_envelope 10, 2
	note F#, 1
	note F#, 2
	volume_envelope 3, -1
	note F#, 1
	volume_envelope 10, 2
	note F#, 1
	note E_, 2
	volume_envelope 3, -1
	note D_, 1
	volume_envelope 10, 2
	note D_, 1
	note D_, 2
	volume_envelope 3, -1
	note D_, 1
	volume_envelope 10, 2
	note D_, 1
	note D_, 2
	volume_envelope 3, -1
	note D_, 1
	volume_envelope 10, 2
	note D_, 1
	note D_, 2
	volume_envelope 3, -1
	note D_, 1
	volume_envelope 10, 2
	note D_, 1
	note E_, 2
	volume_envelope 3, -1
	note F#, 1
	volume_envelope 10, 2
	note F#, 1
	note F#, 2
	volume_envelope 3, -1
	note F#, 1
	volume_envelope 10, 2
	note F#, 1
	note F#, 2
	volume_envelope 3, -1
	note F#, 1
	volume_envelope 10, 2
	note F#, 1
	note F#, 2
	volume_envelope 3, -1
	note F#, 1
	volume_envelope 10, 2
	note F#, 1
	note G#, 2
	volume_envelope 3, -1
	note A_, 1
	volume_envelope 10, 2
	note A_, 1
	note A_, 2
	volume_envelope 3, -1
	note A_, 1
	volume_envelope 10, 2
	note A_, 1
	note A_, 2
	volume_envelope 3, -1
	note A_, 1
	volume_envelope 10, 2
	note A_, 1
	note A_, 2
	volume_envelope 3, -1
	note A_, 1
	volume_envelope 10, 2
	note A_, 1
	note G#, 2
	volume_envelope 3, -1
	note F#, 1
	volume_envelope 10, 2
	note F#, 1
	note F#, 2
	volume_envelope 3, -1
	note F#, 1
	volume_envelope 10, 2
	note F#, 1
	note F#, 2
	volume_envelope 3, -1
	note F#, 1
	volume_envelope 10, 2
	note F#, 1
	note F#, 2
	volume_envelope 3, -1
	note F#, 1
	volume_envelope 10, 2
	note F#, 1
	note E_, 2
	volume_envelope 3, -1
	note D_, 1
	volume_envelope 10, 2
	note D_, 1
	note D_, 2
	volume_envelope 3, -1
	note D_, 1
	volume_envelope 10, 2
	note D_, 1
	note D_, 2
	volume_envelope 3, -1
	note D_, 1
	volume_envelope 10, 2
	note D_, 1
	note D_, 2
	volume_envelope 3, -1
	note D_, 1
	volume_envelope 10, 2
	note D_, 1
	note E_, 2
	volume_envelope 3, -1
	note F#, 1
	volume_envelope 10, 2
	note F#, 1
	note F#, 2
	volume_envelope 3, -1
	note F#, 1
	volume_envelope 10, 2
	note F#, 1
	note F#, 2
	volume_envelope 3, -1
	note E_, 1
	volume_envelope 10, 2
	note E_, 1
	note E_, 2
	volume_envelope 3, -1
	note F#, 1
	volume_envelope 10, 2
	note F#, 1
	note G#, 2
	note B_, 2
	note B_, 2
	note B_, 2
	note B_, 2
	note G#, 1
	note G#, 2
	note G#, 1
	note G#, 1
	note G#, 1
	note G#, 1
	note G#, 1
	note A#, 2
	note A#, 2
	note A#, 2
	note A#, 2
	note F#, 1
	note F#, 2
	note F#, 1
	note F#, 1
	note F#, 1
	note F#, 2
	note G#, 1
	note G#, 1
	note G#, 2
	note G#, 1
	note G#, 1
	note G#, 2
	note G#, 1
	note G#, 1
	note G#, 2
	note G#, 1
	note G#, 1
	note G#, 2
	note A#, 1
	note A#, 1
	note A#, 2
	note A#, 1
	note A#, 1
	note A#, 2
	note A#, 1
	note A#, 1
	note A#, 2
	note A#, 1
	note A#, 1
	note A#, 1
	note A#, 1
	note B_, 2
	note B_, 2
	note B_, 2
	note B_, 2
	note G#, 1
	note G#, 2
	note G#, 1
	note G#, 1
	note G#, 1
	note G#, 1
	note G#, 1
	note A#, 2
	note A#, 2
	note A#, 2
	note A#, 2
	note F#, 1
	note F#, 2
	note F#, 1
	note F#, 1
	note F#, 1
	note F#, 2
	note G#, 1
	note G#, 1
	note G#, 2
	note G#, 1
	note G#, 1
	note G#, 2
	note G#, 1
	note G#, 1
	note G#, 2
	note G#, 1
	note G#, 1
	note G#, 2
	note A#, 1
	note A#, 1
	note A#, 2
	note A#, 1
	note A#, 1
	note A#, 2
	note A#, 1
	note A#, 1
	note A#, 2
	note A#, 1
	note A#, 1
	note A#, 1
	note A#, 1
	note A#, 1
	note A#, 1
	note A#, 2
	note A#, 1
	note A#, 1
	note A#, 1
	note A#, 1
	note A#, 1
	note A#, 1
	note A#, 2
	note A#, 1
	note A#, 1
	note A#, 1
	note A#, 1
	octave 4
	note D#, 1
	note D#, 1
	note D#, 2
	note D#, 1
	note D#, 1
	note D#, 2
	note G_, 1
	note G_, 1
	note G_, 2
	note A#, 1
	note A#, 1
	note A#, 2
	note C_, 1
	note C_, 1
	note C_, 2
	note C_, 1
	note C_, 1
	note C_, 2
	octave 3
	note A#, 1
	note A#, 1
	note A#, 2
	note A#, 1
	note A#, 1
	note A#, 2
	note A#, 2
	note A#, 2
	note A#, 2
	note A#, 2
	note A#, 1
	note G#, 2
	note A_, 1
	note A#, 2
	octave 4
	note C_, 2
	octave 3
	note G#, 1
	note G#, 1
	note G#, 3
	note G#, 2
	note G#, 1
	note G#, 2
	note G_, 2
	note G#, 1
	note A#, 2
	note G#, 1
	note F_, 1
	note F_, 1
	note F_, 3
	note F_, 2
	note F_, 1
	note G_, 2
	note F#, 2
	note G_, 1
	note G_, 2
	note G_, 1
	octave 4
	note C_, 1
	note C_, 1
	note C_, 2
	note C_, 1
	note C_, 1
	note C_, 2
	note F_, 1
	note F_, 1
	note F_, 2
	note F_, 1
	note F_, 1
	note F_, 2
	octave 3
	note A#, 1
	note A#, 1
	note A#, 2
	note A#, 1
	note A#, 1
	note A#, 2
	octave 4
	note D#, 1
	note D#, 2
	note D_, 1
	note D#, 2
	note F_, 2
	octave 3
	note G#, 1
	note G#, 1
	note G#, 3
	note G#, 2
	note G#, 1
	note G#, 2
	note G_, 2
	note G#, 1
	note A#, 2
	note G#, 1

	duty_cycle 0
	volume_envelope 12, 4
	octave 1
	note D#, 2
	note A#, 2
	octave 2
	note D#, 2
	octave 1
	note A#, 2
	note F_, 2
	octave 2
	note D_, 2
	note F_, 2
	note D_, 2

	octave 1
	note D#, 2
	note A#, 2
	octave 2
	note D#, 2
	octave 1
	note A#, 2
	note F_, 2
	octave 2
	note D_, 2
	note F_, 2
	note D_, 2

	note __, 16
	note __, 16
	note __, 16
	note __, 16
	duty_cycle 2
	volume_envelope 3, -1
	octave 4
	note C_, 1
	volume_envelope 10, 2
	note C_, 1
	note C_, 2
	volume_envelope 3, -1
	note C_, 1
	volume_envelope 10, 2
	note C_, 1
	note C_, 2
	volume_envelope 3, -1
	octave 3
	note A_, 1
	volume_envelope 10, 2
	note A_, 1
	note A_, 2
	volume_envelope 3, -1
	note A_, 1
	volume_envelope 10, 2
	note A_, 1
	note A_, 2
	volume_envelope 3, -1
	note B_, 1
	volume_envelope 10, 2
	note B_, 1
	note B_, 2
	volume_envelope 3, -1
	note B_, 1
	volume_envelope 10, 2
	note B_, 1
	note B_, 2
	volume_envelope 3, -1
	note G_, 1
	volume_envelope 10, 2
	note G_, 1
	note G_, 2
	volume_envelope 3, -1
	note G_, 1
	volume_envelope 10, 2
	note G_, 1
	note G_, 2
	volume_envelope 3, -1
	note A_, 1
	volume_envelope 10, 2
	note A_, 1
	note A_, 2
	volume_envelope 3, -1
	note A_, 1
	volume_envelope 10, 2
	note A_, 1
	note A_, 2
	volume_envelope 3, -1
	note A_, 1
	volume_envelope 10, 2
	note A_, 1
	note A_, 2
	volume_envelope 3, -1
	note A_, 1
	volume_envelope 10, 2
	note A_, 1
	note A_, 2
	volume_envelope 3, -1
	note B_, 1
	volume_envelope 10, 2
	note B_, 1
	note B_, 2
	volume_envelope 3, -1
	note B_, 1
	volume_envelope 10, 2
	note B_, 1
	note B_, 2
	volume_envelope 3, -1
	note B_, 1
	volume_envelope 10, 2
	note B_, 1
	note B_, 2
	volume_envelope 3, -1
	note B_, 1
	volume_envelope 10, 2
	note B_, 1
	note B_, 1
	note B_, 1
	octave 4
	note C_, 1
	note C_, 1
	note C_, 2
	note C_, 1
	note C_, 1
	note C_, 2
	octave 3
	note A_, 1
	note A_, 1
	note A_, 2
	note A_, 1
	note A_, 1
	note A_, 2
	jumpchannel Music_GameCornerDPPt_Ch1_loop

Music_GameCornerDPPt_Ch2:
	note_type 12, 12, 7
	duty_cycle 0
	pitch_offset 2
	stereo_panning TRUE, TRUE
	octave 1
	note A_, 2
	octave 2
	note E_, 2
	note A_, 2
	note E_, 2
	octave 1
	note F_, 2
	octave 2
	note C_, 2
	note F_, 2
	note C_, 2
	octave 1
	note G_, 2
	octave 2
	note D_, 2
	note G_, 2
	note D_, 2
	octave 1
	note E_, 2
	note B_, 2
	octave 2
	note E_, 2
	octave 1
	note B_, 2
	note F_, 2
	octave 2
	note C_, 2
	note F_, 2
	note C_, 2
	octave 1
	note D_, 2
	note A_, 2
	octave 2
	note D_, 2
	octave 1
	note A_, 2
	note G_, 2
	octave 2
	note D_, 2
	note G_, 2
	note D_, 2
	octave 1
	note G#, 2
	octave 2
	note E_, 2
	note G#, 2
	note E_, 2
	octave 1
	note A_, 2
	octave 2
	note E_, 2
	note A_, 2
	note E_, 2
	octave 1
	note F_, 2
	octave 2
	note C_, 2
	note F_, 2
	note C_, 2
	octave 1
	note G_, 2
	octave 2
	note D_, 2
	note G_, 2
	note D_, 2
	octave 1
	note E_, 2
	note B_, 2
	octave 2
	note E_, 2
	octave 1
	note B_, 2
	note F_, 2
	octave 2
	note C_, 2
	note F_, 2
	note_type 15, 12, 7
	note C_, 2
	note_type 9, 12, 7
	octave 1
	note D_, 2
	note_type 12, 12, 7
	note A_, 2
	octave 2
	note D_, 2
	octave 1
	note A_, 2
	note G_, 2
	octave 2
	note D_, 2
	note G_, 2
	note D_, 2
	octave 1
	note G#, 2
	octave 2
	note E_, 2
	note G#, 2
	note E_, 2
	volume_envelope 0, 0
	octave 4
	note A_, 8
Music_GameCornerDPPt_Ch2_loop:
	note_type 8, 12, 8
	duty_cycle 2
	octave 1
	note E_, 1
	note F_, 1
	note F#, 1
	note G_, 1
	note G#, 1
	note A_, 1
	note A#, 1
	note B_, 1
	octave 2
	note C_, 1
	note C#, 1
	note D_, 1
	note D#, 1
	note_type 12, 12, 8
	octave 2
	note E_, 8
	note_type 8, 12, 8
	octave 3
	note E_, 1
	note F_, 1
	note F#, 1
	note G_, 1
	note G#, 1
	note A_, 1
	note A#, 1
	note B_, 1
	octave 4
	note C_, 1
	note C#, 1
	note D_, 1
	note D#, 1
	note_type 12, 12, 8
	note E_, 8
	note_type 8, 12, 8
	octave 5
	note E_, 1
	note F_, 1
	note F#, 1
	note G_, 1
	note G#, 1
	note A_, 1
	note A#, 1
	note B_, 1
	octave 6
	note C_, 1
	note C#, 1
	note D_, 1
	note D#, 1
	note_type 12, 12, 8
	octave 6
	note E_, 12
	duty_cycle 0
	octave 2
	note E_, 2
	octave 1
	note G#, 2

	volume_envelope 5, -1
	octave 2
	note F#, 2
	volume_envelope 12, 4
	note F#, 2
	volume_envelope 5, -1
	octave 3
	note C#, 2
	volume_envelope 12, 4
	octave 2
	note F#, 2
	volume_envelope 5, -1
	note F#, 2
	volume_envelope 12, 4
	octave 3
	note C#, 2
	volume_envelope 5, -1
	note D_, 2
	volume_envelope 12, 4
	note E_, 2

	volume_envelope 5, -1
	note E_, 2
	volume_envelope 12, 4
	note D_, 2
	volume_envelope 5, -1
	note D_, 2
	volume_envelope 12, 4
	note C#, 2
	volume_envelope 5, -1
	note C#, 2
	volume_envelope 12, 4
	octave 2
	note B_, 2
	volume_envelope 5, -1
	note B_, 2
	volume_envelope 12, 4
	note A_, 2

	volume_envelope 5, -1
	note D_, 2
	volume_envelope 12, 4
	note D_, 2
	volume_envelope 5, -1
	note B_, 2
	volume_envelope 12, 4
	note D_, 2
	volume_envelope 5, -1
	note B_, 1
	volume_envelope 12, 4
	note E_, 1
	note A#, 1
	note B_, 1
	volume_envelope 5, -1
	note A_, 1
	volume_envelope 12, 4
	note F#, 1
	note B_, 2

	volume_envelope 5, -1
	note B_, 2
	volume_envelope 12, 4
	note A_, 2
	volume_envelope 5, -1
	note A_, 2
	volume_envelope 12, 4
	note B_, 2
	volume_envelope 5, -1
	note B_, 2
	volume_envelope 12, 4
	octave 3
	note D_, 2
	volume_envelope 5, -1
	note D_, 2

	note C#, 4
	volume_envelope 12, 4
	octave 2
	note F#, 2
	volume_envelope 5, -1
	octave 3
	note C#, 2
	volume_envelope 12, 4
	octave 2
	note F#, 2
	volume_envelope 5, -1
	octave 3
	note C#, 1
	volume_envelope 12, 4
	octave 2
	note F#, 2
	note F#, 1
	volume_envelope 5, -1
	note B_, 1
	volume_envelope 12, 4
	octave 3
	note C_, 1
	note D_, 2

	volume_envelope 5, -1
	note E_, 3
	volume_envelope 12, 4
	note D_, 1
	volume_envelope 5, -1
	note D_, 2
	volume_envelope 12, 4
	note C#, 2
	volume_envelope 5, -1
	octave 2
	note B_, 3
	volume_envelope 12, 4
	note A_, 1
	volume_envelope 5, -1
	note A_, 2
	volume_envelope 12, 4
	octave 3
	note C#, 2
	volume_envelope 5, -1
	note C#, 2
	volume_envelope 12, 4
	octave 2
	note F#, 2

	volume_envelope 5, -1
	note B_, 2
	volume_envelope 12, 4
	note F#, 2
	volume_envelope 5, -1
	note B_, 1
	volume_envelope 12, 4
	note E_, 1
	note A#, 1
	note B_, 1
	volume_envelope 5, -1
	note A_, 1
	volume_envelope 12, 4
	note F#, 1
	octave 3
	note C#, 2
	volume_envelope 5, -1
	note D_, 3
	volume_envelope 12, 4
	octave 2
	note A_, 1

	volume_envelope 5, -1
	note A_, 2
	octave 3
	note D_, 4
	volume_envelope 12, 4
	note E_, 2
	volume_envelope 5, -1
	note F#, 2
	volume_envelope 12, 4
	note F#, 4
	note D#, 2

	note E_, 2
	note D#, 2
	note C#, 2
	octave 2
	note B_, 2
	octave 3
	note D#, 2
	octave 2
	note A#, 2

	stereo_panning TRUE, FALSE
	octave 1
	note D#, 2
	note D#, 2
	note_type 6, 12, 4
	octave 2
	note D_, 1
	note D#, 3
	octave 1
	note B_, 1
	note A#, 7
	note D#, 4
	stereo_panning FALSE, TRUE
	octave 5
	note D#, 12
	stereo_panning TRUE, TRUE
	octave 2
	note E_, 4
	note F#, 4
	note G#, 8
	note G#, 4
	note A#, 4
	note B_, 4
	octave 3
	note D#, 4
	note C#, 8
	note_type 12, 12, 4
	octave 2
	note A#, 12
	octave 3
	note D#, 2
	note E_, 2
	note D#, 2
	note C#, 2
	octave 2
	note B_, 2
	octave 3
	note E_, 2
	note F#, 2

	note_type 6, 9, 4
	duty_cycle 2
	stereo_panning TRUE, FALSE
	octave 5
	note C#, 1
	octave 6
	note C#, 1
	octave 4
	note A#, 1
	octave 5
	note A#, 1
	stereo_panning FALSE, TRUE
	note A#, 1
	octave 6
	note A#, 1
	octave 5
	note F#, 1
	octave 6
	note F#, 1
	stereo_panning TRUE, FALSE
	octave 4
	note A#, 1
	octave 5
	note A#, 1
	note A#, 1
	octave 6
	note A#, 1
	stereo_panning FALSE, TRUE
	octave 5
	note F#, 1
	octave 6
	note F#, 1
	octave 5
	note C#, 1
	octave 6
	note C#, 1
	stereo_panning TRUE, FALSE
	octave 4
	note A#, 1
	octave 5
	note A#, 1
	octave 4
	note F#, 1
	octave 5
	note F#, 1
	stereo_panning FALSE, TRUE
	octave 4
	note C#, 1
	octave 5
	note C#, 1
	octave 3
	note A#, 1
	octave 4
	note A#, 1
	stereo_panning TRUE, FALSE
	octave 3
	note G#, 1
	note F#, 1
	note E_, 1
	note D#, 1
	note C#, 1
	octave 2
	note B_, 1
	note A#, 1
	note G#, 1
	duty_cycle 0
	note_type 6, 12, 4
	stereo_panning TRUE, TRUE
	note __, 4
	note G#, 4
	note A#, 4
	note B_, 8
	note B_, 4
	octave 3
	note C#, 4
	note D#, 4
	note F#, 8
	note E_, 8
	note D#, 8
	note E_, 8
	octave 4
	note A#, 12
	note G#, 4
	note G_, 4
	note F_, 4
	note D#, 4
	note D_, 4
	note D#, 4
	note A#, 2
	note A_, 2
	note A#, 2
	note A_, 2
	note A#, 2
	note A_, 2
	note A#, 8
	octave 3
	note C_, 2
	note D_, 2
	note D#, 2
	note D_, 2
	note D_, 1
	duty_cycle 1
	note D#, 7
	octave 2
	note A#, 8
	octave 3
	note F#, 1
	note G_, 7
	note D#, 8
	octave 4
	note C_, 4
	note_type 14, 12, 4
	octave 3
	note A#, 12
	note_type 12, 12, 4
	octave 4
	note D#, 6
	note D_, 2
	note C_, 2
	octave 3
	note A#, 2
	note G#, 2
	note G_, 2
	note A#, 12
	note C_, 2
	note D_, 2
	note D#, 4
	octave 2
	note A#, 4
	octave 3
	note G_, 4
	note F_, 4
	octave 4
	note C_, 2
	note_type 6, 12, 4
	note C#, 1
	note D_, 7
	note_type 15, 12, 4
	octave 3
	note A#, 8
	note_type 12, 12, 4
	note G#, 2
	note A#, 2
	note G_, 2
	note D#, 2
	note E_, 2
	note F_, 2
	note_type 6, 12, 4
	note A_, 1
	note A#, 7
	note D#, 16
	note __, 16
	note __, 16
	note __, 16
	duty_cycle 0
	octave 1
	note A_, 4
	octave 2
	note E_, 4
	note A_, 4
	note E_, 4
	octave 1
	note F_, 4
	octave 2
	note C_, 4
	note F_, 4
	note C_, 4
	octave 1
	note G_, 4
	octave 2
	note D_, 4
	note G_, 4
	note D_, 4
	octave 1
	note E_, 4
	note B_, 4
	octave 2
	note E_, 4
	octave 1
	note B_, 4
	note F_, 4
	octave 2
	note C_, 4
	note F_, 4
	note C_, 4
	octave 1
	note D_, 4
	note A_, 4
	octave 2
	note D_, 4
	octave 1
	note A_, 4
	note G_, 4
	octave 2
	note D_, 4
	note G_, 4
	note D_, 4
	octave 1
	note G#, 4
	octave 2
	note E_, 4
	note G#, 4
	octave 4
	note C_, 2
	note D_, 2
	volume_envelope 5, -1
	note E_, 2
	volume_envelope 12, 4
	note E_, 2
	note D_, 2
	octave 3
	note A_, 2
	volume_envelope 5, -1
	octave 4
	note C_, 2
	volume_envelope 12, 4
	octave 3
	note A_, 2
	octave 4
	note E_, 2
	note G_, 2
	volume_envelope 5, -1
	note E_, 2
	volume_envelope 12, 4
	note E_, 2
	note D_, 2
	octave 3
	note A_, 2
	volume_envelope 5, -1
	octave 4
	note C_, 2
	volume_envelope 12, 4
	note E_, 2
	note A_, 2
	note D_, 2
	volume_envelope 5, -1
	note D#, 1
	volume_envelope 12, 4
	note E_, 7
	volume_envelope 5, -1
	note E_, 8
	note D_, 8
	note D_, 8
	note C_, 2
	note C_, 2
	volume_envelope 12, 4
	octave 3
	note B_, 2
	octave 4
	note G_, 2
	volume_envelope 5, -1
	note C_, 2
	volume_envelope 12, 4
	octave 3
	note B_, 2
	note A_, 2
	octave 4
	note G_, 2
	volume_envelope 5, -1
	note E_, 2
	volume_envelope 12, 4
	note C_, 2
	note D_, 2
	octave 3
	note A_, 2
	volume_envelope 5, -1
	octave 4
	note C_, 2
	volume_envelope 12, 4
	octave 3
	note B_, 2
	octave 4
	note C_, 2
	note D_, 2
	volume_envelope 5, -1
	note E_, 6
	volume_envelope 12, 4
	note G_, 2
	volume_envelope 5, -1
	note G_, 4
	volume_envelope 12, 4
	note E_, 4
	volume_envelope 5, -1
	note D_, 2
	volume_envelope 12, 4
	note E_, 2
	note G_, 2
	note D_, 2
	volume_envelope 5, -1
	note E_, 4
	volume_envelope 12, 7
	note D_, 16
	note __, 4
	jumpchannel Music_GameCornerDPPt_Ch2_loop

Music_GameCornerDPPt_Ch3:
	stereo_panning TRUE, FALSE
	note_type 12, 1, 5
	octave 4
	note __, 16
	note __, 16
	note __, 16
	note __, 16
	note_type 6, 1, 5
	note E_, 1
	note __, 1
	note E_, 1
	note __, 1
	note E_, 4
	note E_, 1
	note __, 1
	note E_, 1
	note __, 1
	note E_, 4
	note C_, 1
	note __, 1
	note C_, 1
	note __, 1
	note C_, 4
	note C_, 1
	note __, 1
	note C_, 1
	note __, 1
	note C_, 4
	note D_, 1
	note __, 1
	note D_, 1
	note __, 1
	note D_, 4
	note D_, 1
	note __, 1
	note D_, 1
	note __, 1
	note D_, 4
	octave 3
	note B_, 1
	note __, 1
	note B_, 1
	note __, 1
	note B_, 4
	note B_, 1
	note __, 1
	note B_, 1
	note __, 1
	note B_, 4
	octave 4
	note C_, 1
	note __, 1
	note C_, 1
	note __, 1
	note C_, 4
	note C_, 1
	note __, 1
	note C_, 1
	note __, 1
	note C_, 4
	note C_, 1
	note __, 1
	note C_, 1
	note __, 1
	note C_, 4
	note C_, 1
	note __, 1
	note C_, 1
	note __, 1
	note C_, 4
	note D_, 1
	note __, 1
	note D_, 1
	note __, 1
	note D_, 4
	note D_, 1
	note __, 1
	note D_, 1
	note __, 1
	note D_, 4
	note D_, 1
	note __, 1
	note D_, 1
	note __, 1
	note D_, 4
	note D_, 1
	note __, 1
	note D_, 1
	note __, 1
	note D_, 2
	note D_, 2
	note E_, 1
	note __, 1
	note E_, 1
	note __, 1
	note E_, 4
	note E_, 1
	note __, 1
	note E_, 1
	note __, 1
	note E_, 4
	note C_, 1
	note __, 1
	note C_, 1
	note __, 1
	note C_, 4
	note C_, 1
	note __, 1
	note C_, 1
	note __, 1
	note C_, 4
Music_GameCornerDPPt_Ch3_loop:
	note D_, 1
	note __, 1
	note D_, 1
	note __, 1
	note D_, 4
	note D_, 1
	note __, 1
	note D_, 1
	note __, 1
	note D_, 4
	octave 3
	note B_, 1
	note __, 1
	note B_, 1
	note __, 1
	note B_, 4
	note B_, 1
	note __, 1
	note B_, 1
	note __, 1
	note B_, 4
	octave 4
	note C_, 1
	note __, 1
	note C_, 1
	note __, 1
	note C_, 4
	note C_, 1
	note __, 1
	note C_, 1
	note __, 1
	note C_, 4
	note C_, 1
	note __, 1
	note C_, 1
	note __, 1
	note C_, 4
	note C_, 1
	note __, 1
	note C_, 1
	note __, 1
	note C_, 4
	note D_, 1
	note __, 1
	note D_, 1
	note __, 1
	note D_, 4
	note D_, 1
	note __, 1
	note D_, 1
	note __, 1
	note D_, 4
	note D_, 1
	note __, 1
	note D_, 1
	note __, 1
	note D_, 4
	note D_, 1
	note __, 1
	note D_, 1
	note __, 1
	note D_, 4
	octave 3
	note F#, 2
	note __, 2
	octave 4
	note F#, 1
	note __, 3
	octave 3
	note F#, 2
	note __, 2
	octave 4
	note F#, 1
	note __, 3
	octave 3
	note F#, 2
	note __, 2
	octave 4
	note F#, 1
	note __, 3
	octave 3
	note F#, 2
	note __, 2
	octave 4
	note E_, 1
	note __, 3
	octave 3
	note D_, 2
	note __, 2
	octave 4
	note D_, 1
	note __, 3
	octave 3
	note D_, 2
	note __, 2
	octave 4
	note D_, 1
	note __, 3
	octave 3
	note D_, 2
	note __, 2
	octave 4
	note D_, 1
	note __, 3
	octave 3
	note D_, 2
	note __, 2
	octave 4
	note C#, 1
	note __, 3
	octave 2
	note B_, 2
	note __, 2
	octave 3
	note B_, 1
	note __, 3
	octave 2
	note B_, 2
	note __, 2
	octave 3
	note B_, 1
	note __, 3
	octave 2
	note B_, 2
	note __, 2
	octave 3
	note B_, 1
	note __, 3
	octave 2
	note B_, 2
	note __, 2
	octave 4
	note C#, 1
	note __, 3
	octave 3
	note D_, 2
	note __, 2
	octave 4
	note D_, 1
	note __, 3
	octave 3
	note D_, 2
	note __, 2
	octave 4
	note D_, 1
	note __, 3
	octave 3
	note D_, 2
	note __, 2
	octave 4
	note D_, 1
	note __, 3
	octave 3
	note D_, 2
	note __, 2
	octave 4
	note E_, 1
	note __, 3
	octave 3
	note F#, 2
	note __, 2
	octave 4
	note F#, 1
	note __, 3
	octave 3
	note F#, 2
	note __, 2
	octave 4
	note F#, 1
	note __, 3
	octave 3
	note F#, 2
	note __, 2
	octave 4
	note F#, 1
	note __, 3
	octave 3
	note F#, 2
	note __, 2
	octave 4
	note E_, 1
	note __, 3
	octave 3
	note D_, 2
	note __, 2
	octave 4
	note D_, 1
	note __, 3
	octave 3
	note D_, 2
	note __, 2
	octave 4
	note D_, 1
	note __, 3
	octave 3
	note D_, 2
	note __, 2
	octave 4
	note D_, 1
	note __, 3
	octave 3
	note D_, 2
	note __, 2
	octave 4
	note C#, 1
	note __, 3
	octave 2
	note B_, 2
	note __, 2
	octave 3
	note B_, 1
	note __, 3
	octave 2
	note B_, 2
	note __, 2
	octave 3
	note B_, 1
	note __, 3
	octave 2
	note B_, 2
	note __, 2
	octave 3
	note B_, 1
	note __, 3
	octave 2
	note B_, 2
	note __, 2
	octave 4
	note C#, 1
	note __, 3
	octave 3
	note D_, 2
	note __, 2
	octave 4
	note D_, 1
	note __, 3
	octave 3
	note D_, 2
	note __, 2
	octave 4
	note D_, 1
	note __, 3
	octave 3
	note D_, 2
	note __, 2
	octave 4
	note D_, 1
	note __, 3
	octave 3
	note D_, 2
	note __, 2
	octave 4
	note E_, 1
	note __, 3
	note D#, 1
	note __, 3
	note D#, 1
	note __, 3
	note D#, 1
	note __, 3
	note D#, 1
	note __, 3
	octave 3
	note B_, 1
	note __, 1
	note B_, 1
	note __, 3
	note B_, 1
	note __, 1
	note B_, 1
	note __, 1
	note B_, 1
	note __, 1
	note B_, 1
	note __, 1
	note B_, 1
	note __, 1
	octave 4
	note C#, 1
	note __, 3
	note C#, 1
	note __, 3
	note C#, 1
	note __, 3
	note C#, 1
	note __, 3
	octave 3
	note A#, 1
	note __, 1
	note A#, 1
	note __, 3
	note A#, 1
	note __, 1
	note A#, 1
	note __, 1
	note A#, 1
	note __, 1
	note A#, 4
	note B_, 1
	note __, 1
	note B_, 1
	note __, 1
	note B_, 4
	note B_, 1
	note __, 1
	note B_, 1
	note __, 1
	note B_, 4
	note B_, 1
	note __, 1
	note B_, 1
	note __, 1
	note B_, 4
	note B_, 1
	note __, 1
	note B_, 1
	note __, 1
	note B_, 4
	octave 4
	note C#, 1
	note __, 1
	note C#, 1
	note __, 1
	note C#, 4
	note C#, 1
	note __, 1
	note C#, 1
	note __, 1
	note C#, 4
	note C#, 1
	note __, 1
	note C#, 1
	note __, 1
	note C#, 4
	note C#, 1
	note __, 1
	note C#, 1
	note __, 1
	note C#, 2
	note C#, 2
	note D#, 1
	note __, 3
	note D#, 1
	note __, 3
	note D#, 1
	note __, 3
	note D#, 1
	note __, 3
	octave 3
	note B_, 1
	note __, 1
	note B_, 1
	note __, 3
	note B_, 1
	note __, 1
	note B_, 1
	note __, 1
	note B_, 1
	note __, 1
	note B_, 1
	note __, 1
	note B_, 1
	note __, 1
	octave 4
	note C#, 1
	note __, 3
	note C#, 1
	note __, 3
	note C#, 1
	note __, 3
	note C#, 1
	note __, 3
	octave 3
	note A#, 1
	note __, 1
	note A#, 1
	note __, 3
	note A#, 1
	note __, 1
	note A#, 1
	note __, 1
	note A#, 1
	note __, 1
	note A#, 4
	note B_, 1
	note __, 1
	note B_, 1
	note __, 1
	note B_, 4
	note B_, 1
	note __, 1
	note B_, 1
	note __, 1
	note B_, 4
	note B_, 1
	note __, 1
	note B_, 1
	note __, 1
	note B_, 4
	note B_, 1
	note __, 1
	note B_, 1
	note __, 1
	note B_, 4
	octave 4
	note C#, 1
	note __, 1
	note C#, 1
	note __, 1
	note C#, 4
	note C#, 1
	note __, 1
	note C#, 1
	note __, 1
	note C#, 4
	note C#, 1
	note __, 1
	note C#, 1
	note __, 1
	note C#, 4
	note C#, 1
	note __, 1
	note C#, 1
	note __, 1
	note D#, 4
	octave 3
	note D#, 2
	note __, 2
	octave 4
	note D#, 1
	note __, 3
	octave 3
	note D#, 2
	note __, 2
	octave 4
	note D#, 1
	note __, 3
	octave 3
	note D#, 2
	note __, 2
	octave 4
	note D#, 1
	note __, 3
	octave 3
	note D#, 2
	note __, 2
	octave 4
	note D#, 1
	note __, 3
	octave 3
	note D#, 2
	note __, 2
	octave 4
	note D#, 1
	note __, 3
	octave 3
	note D#, 2
	note __, 2
	octave 4
	note D#, 1
	note __, 3
	octave 3
	note D#, 2
	note __, 2
	octave 4
	note D#, 1
	note __, 3
	octave 3
	note D#, 2
	note __, 2
	octave 4
	note D#, 1
	note __, 3
	octave 2
	note G#, 2
	note __, 2
	octave 3
	note G#, 1
	note __, 3
	octave 2
	note G#, 2
	note __, 2
	octave 3
	note G#, 1
	note __, 3
	octave 2
	note G#, 2
	note __, 2
	octave 3
	note G#, 1
	note __, 3
	octave 2
	note G#, 2
	note __, 2
	octave 3
	note G#, 1
	note __, 3
	octave 2
	note G_, 2
	note __, 2
	octave 3
	note G_, 1
	note __, 3
	octave 2
	note G_, 2
	note __, 2
	octave 3
	note G_, 1
	note __, 3
	note C_, 2
	note __, 2
	note A#, 1
	note __, 3
	note C_, 2
	note __, 2
	note A#, 1
	note __, 3
	octave 2
	note F_, 2
	note __, 2
	octave 3
	note D#, 1
	note __, 3
	octave 2
	note F_, 2
	note __, 2
	octave 3
	note D#, 1
	note __, 3
	octave 2
	note F_, 2
	note __, 2
	octave 3
	note G_, 1
	note __, 3
	octave 2
	note F_, 2
	note __, 2
	octave 3
	note F_, 1
	note __, 3
	octave 2
	note D#, 2
	note __, 2
	octave 3
	note D#, 1
	note __, 3
	octave 2
	note D#, 2
	note __, 2
	octave 3
	note D#, 1
	note __, 3
	octave 2
	note E_, 2
	note __, 2
	octave 3
	note E_, 1
	note __, 3
	octave 2
	note E_, 2
	note __, 2
	octave 3
	note E_, 1
	note __, 3
	octave 2
	note G#, 2
	note __, 2
	octave 3
	note G#, 1
	note __, 3
	octave 2
	note G#, 2
	note __, 2
	octave 3
	note G#, 1
	note __, 3
	octave 2
	note D_, 2
	note __, 2
	octave 3
	note D_, 1
	note __, 3
	octave 2
	note D_, 2
	note __, 2
	octave 3
	note D_, 1
	note __, 3
	octave 2
	note G_, 2
	note __, 2
	octave 3
	note G_, 1
	note __, 3
	octave 2
	note G_, 2
	note __, 2
	octave 3
	note G_, 1
	note __, 3
	octave 2
	note C_, 2
	note __, 2
	note A#, 1
	note __, 3
	note C_, 2
	note __, 2
	note A#, 1
	note __, 3
	note A#, 2
	note __, 2
	octave 3
	note A#, 1
	note __, 3
	octave 2
	note A#, 2
	note __, 2
	octave 3
	note G#, 1
	note __, 3
	octave 2
	note A#, 2
	note __, 2
	octave 3
	note G_, 1
	note __, 3
	octave 2
	note F_, 2
	note __, 2
	octave 3
	note F_, 1
	note __, 3
	octave 2
	note D#, 2
	note __, 2
	octave 3
	note D#, 1
	note __, 3
	octave 2
	note D#, 2
	note __, 2
	octave 3
	note D#, 1
	note __, 3
	octave 2
	note G#, 2
	note __, 2
	octave 3
	note G#, 1
	note __, 3
	octave 2
	note G#, 2
	note __, 2
	octave 3
	note G#, 1
	note __, 3
	octave 2
	note D#, 2
	note __, 2
	octave 3
	note D#, 1
	note __, 3
	octave 2
	note D#, 2
	note __, 2
	octave 3
	note D#, 1
	note __, 3
	octave 2
	note G_, 2
	note __, 2
	octave 3
	note G_, 1
	note __, 3
	octave 2
	note G_, 2
	note __, 2
	octave 3
	note G_, 1
	note __, 16
	note __, 16
	note __, 16
	note __, 16
	note __, 16
	note __, 16
	note __, 16
	note __, 16
	note __, 3
	octave 4
	note E_, 1
	note __, 1
	note E_, 1
	note __, 1
	note E_, 4
	note E_, 1
	note __, 1
	note E_, 1
	note __, 1
	note E_, 4
	note C_, 1
	note __, 1
	note C_, 1
	note __, 1
	note C_, 4
	note C_, 1
	note __, 1
	note C_, 1
	note __, 1
	note C_, 4
	note D_, 1
	note __, 1
	note D_, 1
	note __, 1
	note D_, 4
	note D_, 1
	note __, 1
	note D_, 1
	note __, 1
	note D_, 4
	octave 3
	note B_, 1
	note __, 1
	note B_, 1
	note __, 1
	note B_, 4
	note B_, 1
	note __, 1
	note B_, 1
	note __, 1
	note B_, 4
	octave 4
	note C_, 1
	note __, 1
	note C_, 1
	note __, 1
	note C_, 4
	note C_, 1
	note __, 1
	note C_, 1
	note __, 1
	note C_, 4
	note C_, 1
	note __, 1
	note C_, 1
	note __, 1
	note C_, 4
	note C_, 1
	note __, 1
	note C_, 1
	note __, 1
	note C_, 4
	note D_, 1
	note __, 1
	note D_, 1
	note __, 1
	note D_, 4
	note D_, 1
	note __, 1
	note D_, 1
	note __, 1
	note D_, 4
	note D_, 1
	note __, 1
	note D_, 1
	note __, 1
	note D_, 4
	note D_, 1
	note __, 1
	note D_, 1
	note __, 1
	note D_, 2
	note D_, 2
	note E_, 1
	note __, 1
	note E_, 1
	note __, 1
	note E_, 4
	note E_, 1
	note __, 1
	note E_, 1
	note __, 1
	note E_, 4
	note C_, 1
	note __, 1
	note C_, 1
	note __, 1
	note C_, 4
	note C_, 1
	note __, 1
	note C_, 1
	note __, 1
	note C_, 4
	jumpchannel Music_GameCornerDPPt_Ch3_loop

Music_GameCornerDPPt_Ch4:
	toggle_noise 3
	note_type 12
	stereo_panning TRUE, FALSE
	note __, 16
	note __, 16
	note C_, 8
	stereo_panning FALSE, TRUE
	note C_, 8
	stereo_panning TRUE, FALSE
	note C_, 4
	stereo_panning FALSE, TRUE
	note C_, 4
	stereo_panning TRUE, TRUE
	note C_, 1
	note C_, 2
	note C_, 1
	note C_, 2
	note C_, 2
	stereo_panning TRUE, TRUE
	note C#, 4
	note C#, 4
	note C#, 4
	note C#, 4
	note C#, 4
	note C#, 4
	note C#, 4
	note C#, 2
	note C#, 2
	note C#, 4
	note C#, 4
	note C#, 4
	note C#, 4
	note C#, 4
	note C#, 4
	note C#, 4
	stereo_panning FALSE, TRUE
	note B_, 2
	stereo_panning TRUE, FALSE
	note B_, 16
	note __, 2
Music_GameCornerDPPt_Ch4_loop:
	note_type 12
	stereo_panning FALSE, TRUE
	note B_, 14
	stereo_panning TRUE, FALSE
	note B_, 2
	note B_, 8
	stereo_panning FALSE, TRUE
	note B_, 8
	stereo_panning TRUE, TRUE
	note C#, 1
	note C#, 1
	note C#, 1
	note C#, 1
	note C#, 1
	note C#, 1
	note C#, 1
	note C#, 1
	note C#, 1
	note C#, 1
	note C#, 1
	note C#, 1
	note_type 6
	note C#, 1
	note C#, 1
	note C#, 1
	note C#, 1
	note C#, 1
	note C#, 1
	note C#, 1
	note C#, 1
	note A#, 4
	note F#, 4
	note A#, 4
	note F#, 4
	note A#, 4
	note F#, 4
	note A#, 4
	note F#, 4
	note A#, 4
	note F#, 4
	note A#, 4
	note F#, 4
	note A#, 4
	note F#, 4
	note A#, 4
	note F#, 4
	note A#, 4
	note F#, 4
	note A#, 4
	note F#, 4
	note A#, 4
	note F#, 4
	note A#, 4
	note F#, 4
	note A#, 4
	note F#, 4
	note A#, 4
	note F#, 4
	note A#, 4
	note F#, 4
	note A#, 4
	note F#, 4
	note A#, 4
	note F#, 4
	note A#, 4
	note F#, 4
	note A#, 4
	note F#, 4
	note A#, 4
	note F#, 4
	note A#, 4
	note F#, 4
	note A#, 4
	note F#, 4
	note A#, 4
	note F#, 4
	note A#, 4
	note F#, 4
	note A#, 4
	note F#, 4
	note A#, 4
	note F#, 4
	note A#, 4
	note F#, 4
	note A#, 4
	note F#, 4
	note A#, 4
	note F#, 4
	note A#, 4
	note F#, 4
	note A#, 4
	note F#, 4
	note A#, 4
	note F#, 4
	note B_, 16
	note __, 16
	note __, 16
	note A#, 2
	note A#, 4
	note A#, 2
	note A#, 4
	note F#, 4
	note B_, 16
	note __, 16
	note __, 16
	note C#, 2
	note C#, 2
	note C#, 2
	note C#, 2
	note C#, 2
	note C#, 2
	note C#, 1
	note C#, 1
	note C#, 1
	note C#, 1
	note B_, 16
	note __, 16
	note __, 16
	note A#, 2
	note A#, 4
	note A#, 2
	note A#, 4
	note F#, 4
	note B_, 16
	note __, 16
	note __, 16
	note __, 12
	note A#, 2
	note A#, 2
	note B_, 12
	note A#, 2
	note A#, 2
	note B_, 16
	note A#, 8
	note A#, 8
	note C#, 2
	note C#, 4
	note C#, 2
	note C#, 2
	note C#, 2
	note C#, 1
	note C#, 1
	note C#, 1
	note C#, 1
	note A#, 8
	note A#, 8
	note A#, 8
	note A#, 8
	note A#, 8
	note A#, 8
	note A#, 2
	note A#, 4
	note A#, 2
	note A#, 4
	note A#, 4
	note A#, 8
	note A#, 8
	note A#, 8
	note A#, 8
	note A#, 8
	note A#, 8
	note A#, 8
	note A#, 4
	note A#, 4
	note A#, 8
	note A#, 8
	note A#, 8
	note A#, 8
	note A#, 8
	note A#, 8
	note A#, 2
	note A#, 4
	note A#, 2
	note A#, 4
	note A#, 4
	note A#, 8
	note A#, 8
	note A#, 8
	note A#, 8
	note A#, 8
	note A#, 8
	note A#, 8
	note A#, 4
	note A#, 4
	note A#, 8
	note A#, 8
	note A#, 8
	note A#, 4
	note A#, 4
	stereo_panning TRUE, FALSE
	note B_, 16
	note __, 16
	note __, 16
	note __, 16
	note A#, 16
	stereo_panning FALSE, TRUE
	note A#, 16
	stereo_panning TRUE, FALSE
	note A#, 8
	stereo_panning FALSE, TRUE
	note A#, 8
	stereo_panning TRUE, TRUE
	note A#, 2
	note A#, 4
	note A#, 2
	note A#, 4
	note A#, 4
	note A#, 8
	note A#, 8
	note A#, 8
	note A#, 8
	note A#, 8
	note A#, 8
	note A#, 8
	note A#, 4
	note A#, 4
	note A#, 8
	note A#, 8
	note A#, 8
	note A#, 8
	note A#, 8
	note A#, 8
	note A#, 8
	note A#, 4
	note A#, 16
	note __, 16
	note __, 4
	jumpchannel Music_GameCornerDPPt_Ch4_loop
