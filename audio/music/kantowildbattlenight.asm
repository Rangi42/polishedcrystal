; Pokémon G/S/C - Kanto Wild Battle (Night)
; Demixed by TriteHexagon
; https://pastebin.com/p19WcKbx
; https://hax.iimarckus.org/topic/7697/

Music_KantoWildBattleNight:
	channel_count 3
	channel 1, Music_KantoWildBattleNight_Ch1
	channel 2, Music_KantoWildBattleNight_Ch2
	channel 3, Music_KantoWildBattleNight_Ch3

Music_KantoWildBattleNight_Ch1:
	tempo 117
	volume 7, 7
	vibrato 18, 2, 2
	duty_cycle 2
	note_type 12, 11, 7
	rest 16
	octave 4
	note A#, 6
	note A_, 1
	note G#, 1
	note A_, 1
	note G#, 1
	note G_, 1
	note F#, 1
	note G#, 1
	note G_, 1
	note F#, 1
	note F_, 1
	sound_call Music_KantoWildBattle_branch_ed091

Music_KantoWildBattleNight_Ch2:
	duty_cycle 3
	vibrato 18, 2, 2
	note_type 12, 11, 1
	octave 4
	note G_, 1
	note F#, 1
	note F_, 1
	note E_, 1
	note G_, 1
	note F#, 1
	note F_, 1
	note E_, 1
	note G_, 1
	note F#, 1
	note F_, 1
	note E_, 1
	note G_, 1
	note F#, 1
	note F_, 1
	note E_, 1
	note G_, 1
	note F#, 1
	note F_, 1
	note E_, 1
	note F#, 1
	note F_, 1
	note E_, 1
	note D#, 1
	note F_, 1
	note E_, 1
	note D#, 1
	note D_, 1
	note E_, 1
	note D#, 1
	note D_, 1
	note C#, 1
	duty_cycle 2
	sound_call Music_KantoWildBattle_branch_ed1c8

Music_KantoWildBattleNight_Ch3:
	vibrato 18, 2, 3
	note_type 12, 1, 2
	sound_call Music_KantoWildBattle_Ch3Intro
Music_KantoWildBattleNight_Ch3loop:
	note_type 12, 1, 2
	sound_call Music_KantoWildBattle_Type1
	sound_call Music_KantoWildBattle_Ch3_Part3
	sound_call Music_KantoWildBattle_Type1
	sound_call Music_KantoWildBattle_Ch3_Part4
	volume_envelope 2, 2
	sound_call Music_KantoWildBattle_Type2
	volume_envelope 1, 2
	octave 5
	note F#, 2
	volume_envelope 2, 2
	sound_call Music_KantoWildBattle_Type2
	volume_envelope 1, 2
	octave 5
	note E_, 2
	volume_envelope 2, 2
	note C_, 1
	octave 4
	note G_, 1
	volume_envelope 1, 2
	octave 5
	note G_, 2
	volume_envelope 2, 2
	sound_call Music_KantoWildBattle_Type2
	volume_envelope 1, 2
	octave 5
	note A_, 2
	volume_envelope 2, 2
	sound_call Music_KantoWildBattle_Type2
	volume_envelope 1, 2
	octave 5
	note G_, 2
	volume_envelope 2, 2
	note C_, 1
	octave 4
	note G#, 1
	volume_envelope 1, 2
	octave 5
	note G#, 12
	note G_, 2
	note F_, 2
	note G#, 2
	note G_, 2
	note C#, 1
	note F_, 1
	note G#, 1
	octave 6
	note C_, 1
	note C#, 8
	octave 5
	note C_, 2
	volume_envelope 2, 2
	sound_call Music_KantoWildBattle_Type3
	volume_envelope 1, 2
	note A#, 2
	volume_envelope 2, 2
	sound_call Music_KantoWildBattle_Type3
	volume_envelope 1, 2
	note G#, 2
	volume_envelope 2, 2
	note E_, 1
	note G_, 1
	volume_envelope 1, 2
	octave 5
	note C#, 2
	volume_envelope 2, 2
	sound_call Music_KantoWildBattle_Type3
	volume_envelope 1, 2
	octave 5
	note C_, 2
	volume_envelope 2, 2
	sound_call Music_KantoWildBattle_Type3
	volume_envelope 1, 2
	note A#, 2
	volume_envelope 2, 2
	note E_, 1
	note G_, 1
	volume_envelope 1, 2
	octave 5
	note F_, 2
	volume_envelope 2, 2
	sound_call Music_KantoWildBattle_Type4
	volume_envelope 1, 2
	note E_, 2
	volume_envelope 2, 2
	sound_call Music_KantoWildBattle_Type4
	volume_envelope 1, 2
	note D_, 2
	volume_envelope 2, 2
	octave 4
	note G_, 1
	octave 5
	note C_, 1
	volume_envelope 1, 2
	octave 4
	note A#, 4
	octave 5
	note C_, 4
	note D_, 4
	note F_, 4
	note G#, 16
	note_type 6, 1, 2
	note G#, 1
	rest 1
	volume_envelope 2, 2
	note G#, 1
	rest 1
	volume_envelope 3, 2
	sound_call Music_KantoWildBattle_Type5
	volume_envelope 2, 2
	sound_call Music_KantoWildBattle_Type5
	volume_envelope 1, 2
	note G#, 1
	rest 1
	note G#, 1
	rest 1
	octave 6
	note C#, 1
	rest 1
	note C#, 1
	rest 1
	note C#, 1
	rest 1
	note C#, 1
	rest 1
	octave 5
	note G_, 2
	note F_, 2
	note E_, 2
	note F_, 2
	note_type 12, 1, 2
	note G_, 12
	note G_, 8
	note_type 6, 1, 2
	note G_, 1
	rest 1
	note G_, 1
	rest 1
	note G_, 1
	rest 1
	note G_, 1
	rest 1
	volume_envelope 2, 2
	note G_, 1
	rest 1
	note G_, 1
	rest 1
	volume_envelope 1, 2
	note G_, 1
	rest 1
	note G_, 1
	rest 1
	note_type 12, 1, 2
	octave 2
	note A#, 16
	note A#, 1
	rest 2
	note A#, 1
	rest 2
	note A#, 1
	rest 1
	octave 3
	note A#, 1
	rest 2
	note A#, 1
	rest 2
	note A#, 1
	rest 1
	note C_, 1
	rest 2
	note_type 6, 1, 2
	sound_call Music_KantoWildBattle_Type6
	octave 4
	note C_, 2
	rest 2
	octave 3
	note C_, 4
	note C_, 2
	rest 4
	sound_call Music_KantoWildBattle_Type6
	octave 2
	note A#, 2
	rest 2
	note A#, 2
	rest 2
	note_type 12, 1, 2
	sound_call Music_KantoWildBattle_Ch3_Part1
	volume_envelope 1, 1
	sound_call Music_KantoWildBattle_Ch3_Part2
	sound_jump Music_KantoWildBattleNight_Ch3loop
