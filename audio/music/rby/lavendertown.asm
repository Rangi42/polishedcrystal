; Pokémon R/B/Y - Lavender Town
; Ported by FroggestSpirit
; https://github.com/froggestspirit/CrystalComplete/blob/master/audio/music/RBY/lavender.asm

Music_LavenderTownRBY:
	dbw $C0, Music_LavenderTownRBY_Ch1
	dbw $01, Music_LavenderTownRBY_Ch2
	dbw $02, Music_LavenderTownRBY_Ch3
	dbw $03, Music_LavenderTownRBY_Ch4

Music_LavenderTownRBY_Ch1:
	tempo 152
	volume 7, 7
	duty_cycle 1
	vibrato 0, 8, 8
	note_type 12, 8, 7
	rest 16
	rest 16
	rest 16
	rest 16
	note_type 12, 10, 7

Music_LavenderTownRBY_branch_bb6b:
	octave 3
	note G_, 8
	note G_, 8
	note E_, 8
	note E_, 8
	note G_, 4
	note F#, 4
	note E_, 4
	note B_, 4
	note C#, 8
	note C#, 8
	note G_, 8
	note G_, 8
	note F#, 8
	note F#, 8
	note B_, 4
	note G_, 4
	note F#, 4
	note B_, 4
	octave 4
	note C_, 8
	note C_, 8
	octave 3
	note G_, 8
	note G_, 8
	note E_, 8
	note E_, 8
	note G_, 4
	note F#, 4
	note E_, 4
	note B_, 4
	note C#, 8
	note C#, 8
	note G_, 8
	note G_, 8
	note F#, 8
	note F#, 8
	note B_, 4
	note G_, 4
	note F#, 4
	note B_, 4
	note C_, 8
	note C_, 8
	rest 16
	rest 16
	rest 16
	rest 16
	sound_jump Music_LavenderTownRBY_branch_bb6b

Music_LavenderTownRBY_Ch2:
	vibrato 0, 3, 4
	duty_cycle 3
	note_type 12, 9, 1

Music_LavenderTownRBY_branch_bba5:
	octave 5
	note C_, 4
	note G_, 4
	note B_, 4
	note F#, 4
	sound_jump Music_LavenderTownRBY_branch_bba5

Music_LavenderTownRBY_Ch3:
	vibrato 4, 1, 1
	note_type 12, 3, -2 ; waveform 10
	rest 16
	rest 16
	rest 16
	rest 16
	note_type 12, 2, -2 ; waveform 10
Music_LavenderTownRBY_branch_bbb9:
	octave 4
	note E_, 16
	note D_, 16
	note C_, 16
	note E_, 4
	note C_, 4
	octave 3
	note B_, 4
	octave 4
	note E_, 4
	note E_, 16
	note D_, 16
	note C_, 16
	note E_, 4
	note C_, 4
	octave 3
	note B_, 4
	octave 4
	note E_, 4
	note E_, 16
	note D_, 16
	note C_, 16
	note E_, 4
	note C_, 4
	octave 3
	note B_, 4
	octave 4
	note E_, 4
	note_type 12, 3, -2 ; waveform 10
	octave 6
	note B_, 4
	note G_, 4
	note F#, 4
	note B_, 4
	note_type 12, 2, -2 ; waveform 10
	note B_, 4
	note G_, 4
	note F#, 4
	note B_, 4
	octave 7
	note B_, 4
	note G_, 4
	note F#, 4
	note B_, 4
	octave 4
	note E_, 4
	note G_, 4
	note F#, 4
	note B_, 4
	note E_, 16
	note D_, 16
	note C_, 16
	note E_, 4
	note C_, 4
	octave 3
	note B_, 4
	octave 4
	note E_, 4
	note E_, 16
	note D_, 16
	note C_, 16
	note E_, 4
	note C_, 4
	octave 3
	note B_, 4
	octave 4
	note E_, 4
	note E_, 16
	note D_, 16
	note C_, 16
	note E_, 4
	note C_, 4
	octave 3
	note B_, 4
	octave 4
	note E_, 4
	note_type 12, 2, -2 ; waveform 10
	octave 6
	note B_, 4
	note G_, 4
	note F#, 4
	note B_, 4
	octave 7
	note B_, 4
	note G_, 4
	note F#, 4
	note B_, 4
	octave 8
	note B_, 4
	note G_, 4
	note F#, 4
	note B_, 4
	octave 4
	note E_, 4
	note G_, 4
	note F#, 4
	note B_, 4
	sound_jump Music_LavenderTownRBY_branch_bbb9

Music_LavenderTownRBY_Ch4:
	note_type 12
	toggle_noise 0
	rest 16
	rest 16
	rest 16
	rest 16

Music_LavenderTownRBY_branch_bc26:
	note F#, 8
	note F#, 8
	sound_jump Music_LavenderTownRBY_branch_bc26
