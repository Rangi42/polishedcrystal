; Pokémon R/B/Y - Indigo Plateau
; Ported by FroggestSpirit
; https://github.com/froggestspirit/CrystalComplete/blob/master/audio/music/RBY/indigoplateau.asm

Music_IndigoPlateauRBY:
	dbw $C0, Music_IndigoPlateauRBY_Ch1
	dbw $01, Music_IndigoPlateauRBY_Ch2
	dbw $02, Music_IndigoPlateauRBY_Ch3
	dbw $03, Music_IndigoPlateauRBY_Ch4

Music_IndigoPlateauRBY_Ch1:
	tempo 132
	volume 7, 7
	duty_cycle 3
	vibrato 6, 52

	note_type 12, 11, 2
	octave 2
	note A_, 8
	note A_, 8
	note A_, 8
	note A_, 4
	note_type 12, 10, 4
	note A#, 4

Music_IndigoPlateauRBY_branch_a605:
	sound_call Music_IndigoPlateauRBY_branch_a659
	note_type 12, 11, 4
	octave 3
	note D_, 4
	sound_call Music_IndigoPlateauRBY_branch_a659
	note_type 12, 11, 4
	octave 3
	note D#, 4
	sound_call Music_IndigoPlateauRBY_branch_a659
	note_type 12, 11, 4
	octave 3
	note D_, 4
	sound_call Music_IndigoPlateauRBY_branch_a659
	note_type 12, 10, 0
	octave 2
	note A#, 4
	sound_call Music_IndigoPlateauRBY_branch_a659
	note_type 12, 11, 4
	octave 3
	note D_, 4
	note_type 12, 13, 4
	octave 3
	note A_, 4
	note A_, 4
	note A_, 4
	note A_, 4
	note A_, 4
	note A_, 4
	note A_, 4
	note_type 12, 11, 4
	octave 3
	note D#, 4
	note_type 12, 13, 4
	octave 3
	note A#, 4
	note A#, 4
	note A#, 4
	note A#, 4
	note A#, 4
	note A#, 4
	note A#, 4
	note_type 12, 11, 4
	octave 3
	note F_, 2
	note_type 12, 11, 4
	octave 3
	note G_, 2
	note_type 12, 11, 0
	note A_, 8
	octave 2
	note A_, 8
	note_type 12, 11, 7
	octave 3
	note F_, 8
	note_type 12, 4, -6
	octave 2
	note A#, 8
	sound_jump Music_IndigoPlateauRBY_branch_a605

Music_IndigoPlateauRBY_branch_a659:
	note_type 12, 11, 2
	octave 2
	note A_, 4
	note A_, 4
	note A_, 4
	note A_, 4
	note A_, 4
	note A_, 4
	note A_, 4
	endchannel

Music_IndigoPlateauRBY_Ch2:
	duty_cycle 3
	vibrato 8, 37
	note_type 12, 12, 2
	octave 3
	note D_, 8
	note D_, 8
	note D_, 8
	note D_, 4
	note_type 12, 5, -2
	note D#, 4

Music_IndigoPlateauRBY_branch_a673:
	sound_call Music_IndigoPlateauRBY_branch_a6af
	note_type 12, 12, 5
	note A_, 4
	sound_call Music_IndigoPlateauRBY_branch_a6af
	note_type 12, 12, 5
	note A#, 4
	sound_call Music_IndigoPlateauRBY_branch_a6af
	note_type 12, 12, 5
	note A_, 4
	sound_call Music_IndigoPlateauRBY_branch_a6af
	note_type 12, 12, 7
	note C#, 4
	sound_call Music_IndigoPlateauRBY_branch_a6af
	note_type 12, 12, 5
	note A_, 4
	sound_call Music_IndigoPlateauRBY_branch_a6af
	note_type 12, 12, 5
	note A#, 4
	sound_call Music_IndigoPlateauRBY_branch_a6af
	note_type 12, 12, 5
	octave 4
	note C_, 2
	note_type 12, 12, 7
	octave 4
	note C#, 2
	note D_, 8
	octave 3
	note D_, 8
	octave 4
	note C_, 8
	note_type 12, 4, -5
	octave 4
	note D#, 8
	sound_jump Music_IndigoPlateauRBY_branch_a673

Music_IndigoPlateauRBY_branch_a6af:
	note_type 12, 12, 2
	octave 3
	note D_, 4
	note D_, 4
	note D_, 4
	note D_, 4
	note D_, 4
	note D_, 4
	note D_, 4
	endchannel

Music_IndigoPlateauRBY_Ch3:
	note_type 12, 1, 0
	octave 4
	note D_, 2
	note __, 6
	note D_, 2
	note __, 6
	note D_, 2
	note __, 6
	note D_, 2
	note __, 2
	note D#, 4

Music_IndigoPlateauRBY_branch_a6c6:
	sound_call Music_IndigoPlateauRBY_branch_a6fe
	sound_call Music_IndigoPlateauRBY_branch_a6fe
	sound_call Music_IndigoPlateauRBY_branch_a6fe
	note D_, 2
	note __, 2
	note D_, 2
	note __, 2
	note D_, 2
	note __, 2
	note D_, 2
	note __, 2
	note D_, 2
	note __, 2
	note D_, 2
	note __, 2
	note D_, 2
	note __, 2
	note F#, 4
	sound_call Music_IndigoPlateauRBY_branch_a6fe
	sound_call Music_IndigoPlateauRBY_branch_a6fe
	note D_, 2
	note __, 2
	note D_, 2
	note __, 2
	note D_, 2
	note __, 2
	note D_, 2
	note __, 2
	note D_, 2
	note __, 2
	note D_, 2
	note __, 2
	note D_, 2
	note __, 2
	note A#, 1
	note __, 1
	note A#, 1
	note __, 1
	note A_, 8
	note D_, 8
	note A#, 8
	note D#, 8
	sound_jump Music_IndigoPlateauRBY_branch_a6c6

Music_IndigoPlateauRBY_branch_a6fe:
	octave 4
	note D_, 2
	note __, 2
	note D_, 2
	note __, 2
	note D_, 2
	note __, 2
	note D_, 2
	note __, 2
	note D_, 2
	note __, 2
	note D_, 2
	note __, 2
	note D_, 2
	note __, 2
	note A_, 4
	endchannel

Music_IndigoPlateauRBY_Ch4:
	note_type 6
	toggle_noise 1
	note A_, 16
	note A_, 16
	note A_, 16
	note A_, 8
	note B_, 1
	note B_, 1
	note B_, 1
	note B_, 1
	note A#, 1
	note A#, 1
	note A#, 1
	note A#, 1

Music_IndigoPlateauRBY_branch_a728:
	sound_call Music_IndigoPlateauRBY_branch_a791
	sound_call Music_IndigoPlateauRBY_branch_a77e
	sound_call Music_IndigoPlateauRBY_branch_a791
	sound_call Music_IndigoPlateauRBY_branch_a7a8
	sound_call Music_IndigoPlateauRBY_branch_a791
	sound_call Music_IndigoPlateauRBY_branch_a77e
	sound_call Music_IndigoPlateauRBY_branch_a791
	sound_call Music_IndigoPlateauRBY_branch_a7a8
	sound_call Music_IndigoPlateauRBY_branch_a791
	sound_call Music_IndigoPlateauRBY_branch_a77e
	sound_call Music_IndigoPlateauRBY_branch_a791
	sound_call Music_IndigoPlateauRBY_branch_a7a8
	sound_call Music_IndigoPlateauRBY_branch_a77e
	sound_call Music_IndigoPlateauRBY_branch_a7a8
	note A_, 16
	note A_, 8
	note A#, 8
	note A_, 16
	note B_, 1
	note B_, 1
	note B_, 1
	note B_, 1
	note A#, 1
	note B_, 1
	note A#, 1
	note B_, 1
	note A#, 1
	note A#, 1
	note A#, 1
	note A#, 1
	note A_, 1
	note A_, 1
	note A_, 1
	note A_, 1
	sound_jump Music_IndigoPlateauRBY_branch_a728

Music_IndigoPlateauRBY_branch_a77e:
	note A_, 4
	note A#, 4
	note B_, 4
	note A#, 4
	note A_, 4
	note A#, 4
	note B_, 4
	note B_, 2
	note A#, 2
	endchannel

Music_IndigoPlateauRBY_branch_a791:
	note A_, 4
	note A#, 4
	note B_, 4
	note A#, 4
	note A_, 4
	note A#, 4
	note B_, 4
	note B_, 1
	note B_, 1
	note A#, 1
	note A#, 1
	endchannel

Music_IndigoPlateauRBY_branch_a7a8:
	note A_, 4
	note A#, 4
	note A_, 4
	note A#, 4
	note A_, 4
	note A_, 4
	note B_, 1
	note B_, 1
	note B_, 1
	note B_, 1
	note A#, 1
	note A#, 1
	note A#, 1
	note A#, 1
	endchannel
