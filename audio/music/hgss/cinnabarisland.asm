; Pokémon HG/SS - Cinnabar Island
; Demixed by FroggestSpirit
; https://github.com/froggestspirit/CrystalComplete/blob/master/audio/music/custom/cinnabarGSC.asm

Music_CinnabarIslandHGSS: ; f5127
	dbw $40, Music_CinnabarIslandHGSS_Ch1
	dbw $01, Music_CinnabarIslandHGSS_Ch2

Music_CinnabarIslandHGSS_Ch1:
	tempo	 $118
	volume $77
	dutycycle 1
	notetype $C, $B6
Music_CinnabarIslandHGSS_Loop1:
	note __, 4
	octave 3
	note D_, 4
	note E_, 6
	note C#, 2
	note D_, 4
	note B_, 4
	octave 4
	note C_, 6
	octave 3
	note A_, 2
	note B_, 4
	note G_, 4
	note F#, 4
	note E_, 2
	note F#, 2
	note G_, 8
	note F#, 4
	note E_, 4
	note D_, 4
	note E_, 4
	note F#, 6
	note A_, 2
	note G_, 4
	note B_, 4
	octave 4
	note C_, 6
	octave 3
	note A_, 2
	note B_, 4
	note G_, 4
	note F#, 3
	note E_, 1
	note F#, 2
	note A_, 2
	note G_, 4
	octave 4
	note D_, 1
	note E_, 1
	note D_, 4
	note D_, 1
	note E_, 1
	note D_, 4
	octave 3
	note B_, 6
	note G_, 2
	note E_, 8
	octave 4
	note C_, 6
	octave 3
	note A_, 2
	note F#, 8
	octave 4
	note F#, 6
	note D_, 2
	octave 3
	note B_, 2
	note A_, 2
	note G_, 2
	note F#, 2
	note G_, 8
	note F#, 4
	note E_, 4
	loopchannel 0, Music_CinnabarIslandHGSS_Loop1

Music_CinnabarIslandHGSS_Ch2:
	dutycycle 1
	notetype $C, $C6
Music_CinnabarIslandHGSS_Loop2:
	octave 3
	note G_, 6
	note A_, 1
	note B_, 1
	octave 4
	note C_, 6
	note D_, 1
	note E_, 1
	note D_, 4
	note G_, 4
	note A_, 6
	note G_, 1
	note F#, 1
	note E_, 4
	note D_, 4
	note C_, 3
	octave 3
	note B_, 1
	octave 4
	note C_, 2
	note E_, 2
	note D_, 4
	octave 3
	note B_, 8
	note A_, 4
	note G_, 6
	note A_, 1
	note B_, 1
	octave 4
	note C_, 6
	note D_, 1
	note E_, 1
	note D_, 4
	note G_, 4
	note A_, 6
	note G_, 1
	note F#, 1
	note E_, 4
	note D_, 4
	note C_, 3
	octave 3
	note B_, 1
	octave 4
	note C_, 2
	note D_, 1
	note E_, 1
	note D_, 4
	octave 3
	note A_, 4
	note G_, 4
	note F#, 4
	octave 4
	note D_, 6
	octave 3
	note B_, 2
	note G_, 8
	octave 4
	note E_, 6
	note C_, 2
	octave 3
	note A_, 8
	octave 4
	note A_, 6
	note F#, 2
	note D_, 2
	note C_, 2
	octave 3
	note B_, 2
	note A_, 2
	note B_, 4
	octave 4
	note D_, 4
	octave 3
	note B_, 2
	note A_, 6
	loopchannel 0, Music_CinnabarIslandHGSS_Loop2
