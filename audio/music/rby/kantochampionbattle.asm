; Pokémon R/B/Y - Champion Battle Theme
; Ported by FroggestSpirit
; https://github.com/froggestspirit/CrystalComplete/blob/master/audio/music/RBY/finalbattle.asm

Music_KantoChampionBattle::
	dbw $80, Music_KantoChampionBattle_Ch1
	dbw $01, Music_KantoChampionBattle_Ch2
	dbw $02, Music_KantoChampionBattle_Ch3

Music_KantoChampionBattle_Ch1: 
	tempo 112
	volume 7, 7	; 119
	duty_cycle 3
	vibrato 6, 3, 4
	note_type 12, 11, 2
	octave 3
	note F#, 1
	note F_, 1
	note F#, 1
	note G_, 1
	note F#, 1
	note G_, 1
	note G#, 1
	note G_, 1
	volume_envelope 10, 2
	note G#, 1
	note A_, 1
	note G#, 1
	note A_, 1
	note A#, 1
	note A_, 1
	note A#, 1
	note B_, 1
	volume_envelope 9, 2
	note A#, 1
	note B_, 1
	octave 4
	note C_, 1
	octave 3
	note B_, 1
	octave 4
	note C_, 1
	note C#, 1
	note C_, 1
	note C#, 1
	volume_envelope 8, 2
	note D_, 1
	note C#, 1
	note D_, 1
	note D#, 1
	note D_, 1
	note D#, 1
	note E_, 1
	note D#, 1
	volume_envelope 12, 1
	octave 3
	note E_, 1
	note E_, 7
	note F_, 1
	note F_, 7
	note G_, 1
	note G_, 7
	note F_, 1
	note F_, 7
	note E_, 1
	note E_, 7
	note F_, 1
	note F_, 7
	note G_, 1
	note G_, 7
	note G#, 1
	note G#, 3
	note D#, 4
	volume_envelope 12, 1
	note E_, 1
	note E_, 3
	volume_envelope 11, 3
	note E_, 4
	volume_envelope 12, 1
	note F_, 1
	note F_, 3
	volume_envelope 11, 3
	note F_, 4
	volume_envelope 12, 1
	note G_, 1
	note G_, 3
	volume_envelope 11, 3
	note G_, 4
	volume_envelope 12, 1
	note F_, 1
	note F_, 3
	volume_envelope 11, 3
	note F_, 4
	volume_envelope 12, 1
	note E_, 1
	note E_, 3
	volume_envelope 11, 3
	note E_, 4
	volume_envelope 12, 1
	note F_, 1
	note F_, 3
	volume_envelope 11, 3
	note F_, 4
	volume_envelope 12, 1
	note G_, 1
	note G_, 3
	volume_envelope 11, 3
	note G_, 4
	volume_envelope 12, 1
	note G#, 1
	note G#, 3
	volume_envelope 11, 7
	note D#, 4
Music_KantoChampionBattle_branch_23429:
	volume_envelope 11, 7
	octave 3
	note E_, 4
	note B_, 4
	note D#, 4
	note A#, 4
	note D_, 4
	note A_, 4
	octave 2
	note B_, 4
	octave 3
	note F#, 4
	note F_, 4
	note F#, 4
	volume_envelope 11, 1
	note F#, 2
	note F_, 1
	note F#, 1
	note A_, 1
	note F#, 2
	note F#, 1
	volume_envelope 11, 7
	octave 2
	note B_, 6
	volume_envelope 10, 0
	octave 3
	note D_, 6
	volume_envelope 11, 7
	note F#, 4
	note E_, 4
	note B_, 4
	note D#, 4
	note A#, 4
	note D_, 4
	note A_, 4
	octave 2
	note B_, 4
	octave 3
	note F#, 4
	note F_, 4
	note F#, 12
	note A#, 4
	volume_envelope 5, 14
	note B_, 12
	volume_envelope 11, 2
	note E_, 3
	note E_, 3
	note E_, 2
	note E_, 1
	note F#, 1
	note E_, 1
	note B_, 1
	note F#, 1
	note E_, 1
	note F#, 1
	note B_, 1
	note F#, 1
	note E_, 1
	note F#, 1
	note B_, 1
	note F#, 1
	note E_, 1
	note F#, 1
	note B_, 1
	note F#, 1
	volume_envelope 12, 2
	note E_, 1
	note F#, 1
	note B_, 1
	note F#, 1
	volume_envelope 13, 2
	note E_, 1
	note F#, 1
	note B_, 1
	volume_envelope 12, 1
	note E_, 1
	note E_, 7
	note E_, 1
	note E_, 7
	note E_, 1
	note E_, 7
	note E_, 1
	note E_, 7
	note E_, 1
	note E_, 3
	volume_envelope 11, 5
	note D_, 4
	volume_envelope 12, 1
	note E_, 1
	note E_, 3
	volume_envelope 11, 5
	note F_, 4
	volume_envelope 12, 1
	note E_, 1
	note E_, 3
	volume_envelope 11, 5
	note D_, 4
	volume_envelope 12, 1
	note E_, 1
	volume_envelope 11, 7
	note E_, 7
	volume_envelope 12, 1
	note E_, 2
	note B_, 1
	note A_, 1
	note E_, 2
	note B_, 1
	note A_, 1
	note E_, 2
	note B_, 1
	note A_, 1
	note E_, 2
	note B_, 1
	note A_, 3
	note E_, 1
	note D_, 3
	note E_, 1
	note D_, 3
	note E_, 1
	note D_, 3
	note E_, 1
	note D_, 1
	note F_, 2
	octave 4
	note C_, 1
	octave 3
	note B_, 1
	note F_, 2
	octave 4
	note C_, 1
	octave 3
	note B_, 1
	note F_, 2
	octave 4
	note C_, 1
	octave 3
	note B_, 1
	note F_, 2
	octave 4
	note C_, 1
	octave 3
	note B_, 3
	note F_, 1
	note E_, 3
	note F_, 1
	note E_, 3
	note F_, 1
	note E_, 3
	note F_, 1
	note E_, 1
	note F#, 2
	octave 4
	note C#, 1
	note C_, 1
	octave 3
	note F#, 2
	octave 4
	note C#, 1
	note C_, 1
	octave 3
	note F#, 2
	octave 4
	note C#, 1
	note C_, 1
	octave 3
	note F#, 2
	octave 4
	note C#, 1
	note C_, 3
	octave 3
	note F#, 1
	note F_, 3
	note F#, 1
	note F_, 3
	note F#, 1
	note F_, 3
	note F#, 1
	note F_, 3
	note F#, 1
	note F_, 3
	note F#, 1
	note F_, 3
	note F#, 1
	note F_, 3
	volume_envelope 11, 7
	octave 4
	note C_, 2
	volume_envelope 11, 0
	note C#, 8
	volume_envelope 11, 7
	note C#, 8
	volume_envelope 10, 0
	octave 3
	note F#, 8
	note F#, 8
	volume_envelope 11, 0
	octave 3
	note A_, 8
	volume_envelope 11, 7
	note A_, 8
	note G_, 4
	note B_, 12
	volume_envelope 11, 0
	note A_, 8
	volume_envelope 11, 7
	note A_, 8
	volume_envelope 11, 0
	note E_, 8
	volume_envelope 11, 7
	note E_, 8
	volume_envelope 11, 0
	note A#, 8
	volume_envelope 11, 7
	note A#, 8
	octave 4
	note F_, 8
	octave 3
	note A#, 8
	octave 4
	note C#, 4
	note E_, 12
	octave 3
	note A_, 4
	octave 4
	note C#, 12
	volume_envelope 4, 0
	sound_call Music_KantoChampionBattle_branch_23710
	sound_call Music_KantoChampionBattle_branch_23710
	volume_envelope 11, 7
	octave 3
	note E_, 4
	note B_, 4
	note D#, 4
	note A#, 4
	note D_, 4
	note A_, 4
	octave 2
	note B_, 4
	octave 3
	note F#, 4
	note F_, 4
	note F#, 12
	volume_envelope 11, 0
	note A_, 8
	note G_, 8
	volume_envelope 11, 7
	note E_, 4
	note B_, 4
	note D#, 4
	note A#, 4
	note D_, 4
	note A_, 4
	octave 2
	note B_, 4
	octave 3
	note F#, 4
	note F_, 4
	note F#, 12
	volume_envelope 11, 0
	note A_, 8
	volume_envelope 11, 7
	octave 4
	note C_, 8
	volume_envelope 11, 0
	octave 3
	note B_, 8
	volume_envelope 11, 7
	note B_, 8
	volume_envelope 11, 0
	octave 4
	note E_, 8
	volume_envelope 11, 7
	note E_, 8
	sound_jump Music_KantoChampionBattle_branch_23429
Music_KantoChampionBattle_Ch2: 
	duty_cycle 3
	vibrato 8, 2, 5
	note_type 12, 12, 2
	octave 5
	note C_, 1
	octave 4
	note G#, 1
	note B_, 1
	note F#, 1
	note A_, 1
	note E_, 1
	note G_, 1
	octave 5
	note C_, 1
	octave 4
	note F_, 1
	note C#, 1
	note E_, 1
	note C_, 1
	note D#, 1
	octave 3
	note B_, 1
	octave 4
	note D_, 1
	octave 5
	note C_, 1
	octave 4
	note C_, 1
	octave 3
	note G#, 1
	note B_, 1
	note F#, 1
	note A#, 1
	note F_, 1
	note A_, 1
	octave 5
	note C_, 1
	octave 3
	note G#, 1
	note D#, 1
	note G_, 1
	note D_, 1
	note F_, 1
	note C#, 1
	note E_, 1
	octave 5
	note C_, 1
	volume_envelope 12, 1
	octave 4
	note E_, 1
	note E_, 7
	note E_, 1
	note E_, 7
	note E_, 1
	note E_, 7
	note E_, 1
	note E_, 7
	note E_, 1
	note E_, 3
	volume_envelope 12, 2
	octave 5
	note E_, 4
	volume_envelope 12, 1
	octave 4
	note E_, 1
	note E_, 3
	volume_envelope 12, 2
	octave 5
	note E_, 4
	volume_envelope 12, 1
	octave 4
	note E_, 1
	note E_, 3
	volume_envelope 12, 2
	octave 5
	note E_, 4
	volume_envelope 12, 1
	octave 4
	note E_, 1
	note E_, 3
	volume_envelope 12, 2
	note D#, 4
	sound_call Music_KantoChampionBattle_branch_23704
	sound_call Music_KantoChampionBattle_branch_23704
	sound_call Music_KantoChampionBattle_branch_23704
	sound_call Music_KantoChampionBattle_branch_23704
	sound_call Music_KantoChampionBattle_branch_23704
	sound_call Music_KantoChampionBattle_branch_23704
	sound_call Music_KantoChampionBattle_branch_23704
	volume_envelope 12, 1
	octave 4
	note E_, 1
	note E_, 3
	volume_envelope 4, 10
	octave 3
	note G#, 4
Music_KantoChampionBattle_branch_235e6:
	volume_envelope 13, 7
	octave 4
	note E_, 8
	note D#, 8
	note D_, 8
	octave 3
	note B_, 8
	volume_envelope 13, 7
	note A#, 4
	note B_, 12
	volume_envelope 11, 1
	note F_, 2
	note F#, 3
	note A_, 1
	note B_, 1
	note A_, 1
	octave 4
	note C_, 1
	octave 3
	note B_, 2
	note A_, 1
	note B_, 1
	note B_, 1
	note A_, 1
	note A#, 1
	volume_envelope 13, 7
	octave 4
	note E_, 8
	note D#, 8
	note D_, 8
	octave 3
	note B_, 8
	volume_envelope 13, 7
	note A#, 4
	note B_, 12
	octave 4
	note D#, 4
	note E_, 12
	volume_envelope 10, 0
	octave 3
	note B_, 8
	octave 4
	note D_, 8
	note F_, 8
	note D_, 8
	volume_envelope 13, 1
	note E_, 1
	note E_, 3
	volume_envelope 12, 4
	octave 3
	note D_, 4
	volume_envelope 13, 1
	octave 4
	note E_, 1
	note E_, 3
	volume_envelope 12, 4
	octave 3
	note F_, 4
	volume_envelope 13, 1
	octave 4
	note E_, 1
	note E_, 3
	volume_envelope 12, 4
	octave 3
	note D_, 4
	volume_envelope 13, 1
	octave 4
	note E_, 1
	note E_, 1
	volume_envelope 12, 4
	octave 2
	note B_, 4
	octave 3
	note D_, 2
	volume_envelope 12, 2
	octave 4
	note E_, 1
	note E_, 1
	note D_, 1
	note E_, 1
	note F_, 1
	note E_, 1
	note D_, 1
	note F_, 1
	note E_, 1
	note E_, 1
	note F#, 1
	note F_, 1
	note E_, 1
	note D#, 1
	note E_, 1
	note F#, 1
	note E_, 1
	note E_, 1
	note F_, 1
	note E_, 1
	note D_, 1
	note C#, 1
	note D_, 1
	note D#, 1
	note E_, 1
	note E_, 1
	volume_envelope 12, 4
	octave 2
	note B_, 4
	octave 3
	note D_, 2
	volume_envelope 13, 7
	octave 4
	note E_, 4
	note F_, 2
	note F#, 12
	volume_envelope 12, 2
	octave 3
	note B_, 2
	note B_, 4
	note B_, 2
	note B_, 4
	note B_, 2
	volume_envelope 13, 7
	octave 4
	note F_, 4
	note F#, 2
	note G_, 12
	volume_envelope 12, 2
	note C_, 2
	note C_, 4
	note C_, 2
	note C_, 4
	note C_, 2
	volume_envelope 13, 7
	note F#, 4
	note G_, 2
	note G#, 12
	volume_envelope 8, 2
	note C#, 2
	note C#, 4
	volume_envelope 10, 2
	note C#, 2
	note C#, 4
	note C#, 4
	volume_envelope 13, 2
	note C#, 2
	note C#, 4
	volume_envelope 15, 2
	note C#, 2
	note C#, 4
	volume_envelope 12, 4
	note E_, 1
	note F_, 1
	volume_envelope 12, 0
	note F#, 12
	volume_envelope 12, 7
	note F#, 4
	volume_envelope 1, 15
	octave 3
	note F#, 8
	volume_envelope 9, 0
	note F#, 8
	volume_envelope 12, 7
	octave 4
	note C#, 4
	volume_envelope 12, 0
	note D_, 12
	note D_, 8
	volume_envelope 12, 7
	note D_, 8
	volume_envelope 12, 0
	note E_, 8
	volume_envelope 12, 7
	note E_, 8
	volume_envelope 12, 0
	octave 3
	note A_, 8
	volume_envelope 12, 7
	note A_, 8
	volume_envelope 12, 0
	octave 4
	note F_, 8
	volume_envelope 12, 7
	note F_, 8
	octave 5
	note C_, 8
	octave 4
	note A#, 8
	volume_envelope 12, 0
	note A_, 16
	note A_, 8
	volume_envelope 12, 7
	note A_, 8
	volume_envelope 12, 5
	sound_call Music_KantoChampionBattle_branch_23710
	volume_envelope 11, 1
	sound_call Music_KantoChampionBattle_branch_23710
	volume_envelope 13, 7
	octave 4
	note E_, 8
	note D#, 8
	note D_, 8
	octave 3
	note B_, 8
	note A#, 4
	note B_, 12
	volume_envelope 12, 7
	octave 4
	note D_, 8
	volume_envelope 4, 12
	note C_, 8
	volume_envelope 13, 7
	note E_, 8
	note D#, 8
	note D_, 8
	octave 3
	note B_, 8
	note A#, 4
	note B_, 12
	volume_envelope 5, 13
	octave 4
	note D_, 8
	volume_envelope 12, 0
	note F_, 8
	volume_envelope 12, 0
	note E_, 8
	volume_envelope 12, 7
	note E_, 8
	note A#, 4
	note B_, 12
	sound_jump Music_KantoChampionBattle_branch_235e6
Music_KantoChampionBattle_branch_23704:
	octave 4
	note E_, 1
	note E_, 1
	note G_, 1
	octave 5
	note C_, 1
	note E_, 1
	note C_, 1
	octave 4
	note G_, 1
	note F_, 1
	sound_ret
Music_KantoChampionBattle_branch_23710:
	octave 4
	note D_, 2
	note C#, 2
	octave 3
	note B_, 2
	octave 4
	note C#, 2
	note D_, 2
	note C#, 2
	note F#, 2
	note D_, 2
	sound_ret
Music_KantoChampionBattle_Ch3: 
	note_type 12, 1, 1
	octave 4
	note E_, 4
	octave 5
	note E_, 4
	octave 4
	note F_, 4
	octave 5
	note D#, 4
	octave 4
	note G_, 4
	octave 5
	note D_, 4
	octave 4
	note G#, 4
	note B_, 4
	note E_, 1
	note E_, 1
	rest 6
	note E_, 1
	note E_, 1
	rest 6
	note E_, 1
	note E_, 1
	rest 6
	note E_, 1
	note E_, 1
	rest 2
	note D#, 4
	note E_, 1
	note E_, 1
	rest 2
	note B_, 4
	note E_, 1
	note E_, 1
	rest 2
	octave 5
	note C_, 4
	octave 4
	note E_, 1
	note E_, 1
	rest 2
	octave 5
	note D_, 4
	octave 4
	note E_, 1
	note E_, 1
	octave 5
	note C_, 4
	octave 4
	note A#, 2
	note E_, 1
	note E_, 1
	rest 2
	note B_, 4
	note E_, 1
	note E_, 1
	rest 2
	octave 5
	note C_, 4
	octave 4
	note E_, 1
	note E_, 1
	rest 2
	octave 5
	note D_, 4
	octave 4
	note E_, 1
	note E_, 1
	octave 5
	note C_, 4
	note D_, 2
	octave 4
	note E_, 1
	note E_, 1
	rest 2
	note B_, 4
	note E_, 1
	note E_, 1
	rest 2
	octave 5
	note C_, 4
	octave 4
	note E_, 1
	note E_, 1
	rest 2
	octave 5
	note D_, 4
	octave 4
	note E_, 1
	note E_, 1
	rest 2
	note E_, 1
	note D#, 1
	note E_, 1
	note G_, 1
Music_KantoChampionBattle_branch_2377d:
	octave 4
	note E_, 1
	octave 3
	note E_, 1
	rest 2
	octave 4
	note F#, 4
	note D#, 1
	octave 3
	note D#, 1
	rest 2
	octave 4
	note F_, 4
	note D_, 1
	octave 3
	note D_, 1
	rest 2
	octave 4
	note E_, 4
	note F#, 1
	octave 3
	note F#, 1
	rest 2
	octave 4
	note F#, 4
	note F_, 4
	octave 3
	note B_, 2
	octave 4
	note F#, 2
	octave 3
	note B_, 2
	octave 4
	note F#, 2
	octave 3
	note B_, 2
	octave 4
	note F#, 2
	octave 3
	note B_, 2
	octave 4
	note F#, 2
	octave 3
	note B_, 2
	octave 4
	note F#, 2
	octave 3
	note B_, 2
	octave 4
	note F#, 2
	octave 3
	note B_, 2
	octave 4
	note F#, 2
	note E_, 1
	octave 3
	note E_, 1
	rest 2
	octave 4
	note F#, 4
	note D#, 1
	octave 3
	note D#, 1
	rest 2
	octave 4
	note F_, 4
	note D_, 1
	octave 3
	note D_, 1
	rest 2
	octave 4
	note E_, 4
	note F#, 1
	octave 3
	note F#, 1
	rest 2
	octave 4
	note F#, 4
	note F_, 4
	octave 3
	note B_, 2
	octave 4
	note F#, 2
	octave 3
	note B_, 2
	octave 4
	note F#, 2
	octave 3
	note B_, 2
	octave 4
	note F#, 2
	note E_, 1
	note D#, 1
	note E_, 1
	note F#, 1
	note E_, 2
	note B_, 2
	note E_, 2
	note B_, 2
	note E_, 2
	note B_, 2
	note E_, 2
	note B_, 2
	note E_, 2
	note B_, 2
	note E_, 2
	note B_, 2
	note E_, 2
	note B_, 2
	note E_, 2
	note B_, 2
	note E_, 2
	note B_, 2
	note E_, 2
	note B_, 2
	note E_, 2
	note B_, 2
	note E_, 1
	note E_, 1
	rest 2
	note D_, 4
	note E_, 1
	note E_, 1
	rest 2
	note F_, 4
	note E_, 1
	note E_, 1
	rest 2
	note D_, 4
	note E_, 1
	note E_, 1
	octave 3
	note B_, 6
	octave 4
	note E_, 1
	note E_, 1
	rest 2
	note D_, 4
	note E_, 1
	note E_, 1
	rest 2
	note F_, 4
	note E_, 1
	note E_, 1
	rest 2
	note D_, 4
	note E_, 1
	note E_, 1
	octave 3
	note B_, 6
	octave 4
	note E_, 2
	octave 5
	note D_, 2
	octave 4
	note E_, 2
	octave 5
	note D_, 2
	octave 4
	note E_, 2
	octave 5
	note D_, 2
	octave 4
	note E_, 2
	octave 5
	note D_, 2
	octave 4
	note E_, 2
	note B_, 2
	note B_, 2
	note E_, 2
	note B_, 2
	note B_, 2
	octave 5
	note C#, 2
	octave 4
	note B_, 2
	note F_, 2
	octave 5
	note D#, 2
	octave 4
	note F_, 2
	octave 5
	note D#, 2
	octave 4
	note F_, 2
	octave 5
	note D#, 2
	octave 4
	note F_, 2
	octave 5
	note D#, 2
	octave 4
	note F_, 2
	octave 5
	note C_, 2
	note C_, 2
	octave 4
	note F_, 2
	octave 5
	note C_, 2
	note C_, 2
	note D_, 2
	note C_, 2
	octave 4
	note F#, 2
	octave 5
	note E_, 2
	octave 4
	note F#, 2
	octave 5
	note E_, 2
	octave 4
	note F#, 2
	octave 5
	note E_, 2
	octave 4
	note F#, 2
	octave 5
	note E_, 2
	octave 4
	note F#, 2
	octave 5
	note C#, 2
	note C#, 2
	octave 4
	note F#, 2
	octave 5
	note C#, 2
	note C#, 2
	note E_, 2
	note C#, 2
	octave 4
	note F#, 2
	octave 5
	note C#, 2
	note C#, 2
	octave 4
	note F#, 2
	octave 5
	note C#, 2
	note C#, 2
	note E_, 2
	note C#, 2
	sound_call Music_KantoChampionBattle_branch_2395b
	sound_call Music_KantoChampionBattle_branch_2395b
	octave 4
	note G_, 2
	octave 5
	note D_, 2
	octave 4
	note G_, 2
	octave 5
	note D_, 2
	octave 4
	note G_, 2
	octave 5
	note D_, 2
	octave 4
	note G_, 2
	octave 5
	note D_, 2
	octave 4
	note G_, 2
	octave 5
	note D_, 2
	octave 4
	note G_, 2
	octave 5
	note D_, 2
	octave 4
	note G_, 2
	octave 5
	note D_, 2
	octave 4
	note G_, 1
	note F#, 1
	note G_, 1
	note G#, 1
	sound_call Music_KantoChampionBattle_branch_2396c
	sound_call Music_KantoChampionBattle_branch_2396c
	octave 4
	note A#, 2
	octave 5
	note F_, 2
	octave 4
	note A#, 2
	octave 5
	note F_, 2
	octave 4
	note A#, 2
	octave 5
	note F_, 2
	octave 4
	note A#, 2
	octave 5
	note F_, 2
	octave 4
	note A#, 2
	octave 5
	note F_, 2
	note G_, 2
	note F_, 2
	note E_, 2
	note D_, 2
	note C#, 2
	octave 4
	note A#, 2
	note A_, 2
	octave 5
	note C#, 2
	octave 4
	note A_, 2
	octave 5
	note C#, 2
	octave 4
	note A_, 2
	octave 5
	note C#, 2
	octave 4
	note A_, 2
	octave 5
	note C#, 2
	octave 4
	note A_, 2
	octave 5
	note C#, 2
	octave 4
	note A_, 2
	octave 5
	note C#, 2
	octave 4
	note A_, 2
	octave 5
	note C#, 2
	octave 4
	note A_, 2
	note G#, 2
	note G_, 2
	octave 5
	note D_, 2
	octave 4
	note G_, 2
	octave 5
	note D_, 2
	octave 4
	note G_, 2
	octave 5
	note D_, 2
	octave 4
	note G_, 2
	octave 5
	note D_, 2
	octave 4
	note G_, 2
	octave 5
	note D_, 2
	octave 4
	note G_, 2
	octave 5
	note D_, 2
	octave 4
	note G_, 2
	octave 5
	note D_, 2
	octave 4
	note G_, 1
	note F#, 1
	note G_, 1
	note G#, 1
	note E_, 2
	note A_, 2
	note E_, 2
	note A_, 2
	note E_, 2
	note A_, 2
	note E_, 2
	note A_, 2
	note E_, 2
	note A_, 2
	note E_, 2
	note A_, 2
	note E_, 2
	note F_, 2
	note F#, 2
	note G_, 2
	note F#, 2
	note B_, 2
	note F#, 2
	note B_, 2
	note F#, 2
	note B_, 2
	note F#, 2
	note B_, 2
	note F#, 2
	note B_, 2
	note F#, 2
	note B_, 2
	note F#, 2
	note B_, 2
	note F#, 2
	note D#, 2
	note E_, 2
	note B_, 2
	note E_, 2
	note B_, 2
	note E_, 2
	note B_, 2
	note E_, 2
	note B_, 2
	note E_, 2
	note B_, 2
	note E_, 2
	note B_, 2
	note E_, 2
	note F_, 2
	note F#, 2
	note G_, 2
	note F#, 2
	octave 5
	note D_, 2
	octave 4
	note F#, 2
	octave 5
	note D_, 2
	octave 4
	note F#, 2
	octave 5
	note D_, 2
	octave 4
	note F#, 2
	octave 5
	note D_, 2
	octave 4
	note F#, 2
	octave 5
	note D_, 2
	octave 4
	note F#, 2
	octave 5
	note D_, 2
	octave 4
	note F#, 2
	octave 5
	note D_, 2
	octave 4
	note F#, 2
	note F_, 2
	note E_, 2
	note B_, 2
	octave 5
	note E_, 4
	octave 4
	note E_, 2
	note B_, 2
	octave 5
	note D#, 4
	octave 4
	note E_, 2
	note B_, 2
	octave 5
	note D_, 4
	octave 4
	note E_, 2
	note A_, 2
	note B_, 4
	sound_jump Music_KantoChampionBattle_branch_2377d
Music_KantoChampionBattle_branch_2395b:
	octave 4
	note F#, 2
	octave 5
	note C#, 2
	octave 4
	note F#, 2
	octave 5
	note C#, 2
	octave 4
	note F#, 2
	octave 5
	note C#, 2
	octave 4
	note F#, 2
	octave 5
	note C#, 2
	sound_ret
Music_KantoChampionBattle_branch_2396c:
	octave 4
	note A_, 2
	octave 5
	note E_, 2
	octave 4
	note A_, 2
	octave 5
	note E_, 2
	octave 4
	note A_, 2
	octave 5
	note E_, 2
	octave 4
	note A_, 2
	octave 5
	note E_, 2
	sound_ret

