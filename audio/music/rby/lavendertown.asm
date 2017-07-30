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
	volume 119
	dutycycle 1
	vibrato 0, 136
	notetype 12, 135
	note __, 16
	note __, 16
	note __, 16
	note __, 16
	notetype 12, 167

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
	note __, 16
	note __, 16
	note __, 16
	note __, 16
	loopchannel 0, Music_LavenderTownRBY_branch_bb6b

Music_LavenderTownRBY_Ch2:
	vibrato 0, 52
	dutycycle 3
	notetype 12, 145

Music_LavenderTownRBY_branch_bba5:
	octave 5
	note C_, 4
	note G_, 4
	note B_, 4
	note F#, 4
	loopchannel 0, Music_LavenderTownRBY_branch_bba5

Music_LavenderTownRBY_Ch3:
	vibrato 4, 17
	notetype 12, $3a ; waveform 10
	note __, 16
	note __, 16
	note __, 16
	note __, 16
	notetype 12, $2a ; waveform 10
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
	notetype 12, $3a ; waveform 10
	octave 6
	note B_, 4
	note G_, 4
	note F#, 4
	note B_, 4
	notetype 12, $2a ; waveform 10
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
	notetype 12, $2a ; waveform 10
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
	loopchannel 0, Music_LavenderTownRBY_branch_bbb9

Music_LavenderTownRBY_Ch4:
	notetype 12
	togglenoise 0
	note __, 16
	note __, 16
	note __, 16
	note __, 16

Music_LavenderTownRBY_branch_bc26:
	note F#, 8
	note F#, 8
	loopchannel 0, Music_LavenderTownRBY_branch_bc26
