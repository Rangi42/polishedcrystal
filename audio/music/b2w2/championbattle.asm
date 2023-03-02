; Pokémon B2/W2 - Battle! Champion Iris
; Demixed by Mmmmmm
; https://pastebin.com/1TeQ2sMe
; https://hax.iimarckus.org/topic/6777/2/

Music_ChampionBattleB2W2:
	channel_count 4
	channel 1, Music_ChampionBattleB2W2_Ch1
	channel 2, Music_ChampionBattleB2W2_Ch2
	channel 3, Music_ChampionBattleB2W2_Ch3
	channel 4, Music_ChampionBattleB2W2_Ch4

Music_ChampionBattleB2W2_Ch1:
	tempo 100
	pitch_offset 1
	vibrato 18, 1, 5
	note_type 12, 8, 2
	duty_cycle 0
	octave 2
	note D_, 1
	note D_, 1
	sound_call Music_ChampionBattleB2W2_Ch1_branch_1
	duty_cycle 0
	volume_envelope 8, 0
	octave 3
	note G_, 16
	note G_, 8
	note A_, 8
	note B_, 16
	note B_, 16
	octave 4
	note C_, 16
	octave 3
	note G_, 8
	note A_, 8
Music_ChampionBattleB2W2_Ch1_loop_main:
	volume_envelope 8, 0
	duty_cycle 0
	octave 2
	sound_call Music_ChampionBattleB2W2_Ch1_branch_3
	sound_call Music_ChampionBattleB2W2_Ch1_branch_4
	sound_call Music_ChampionBattleB2W2_Ch1_branch_4
	sound_call Music_ChampionBattleB2W2_Ch1_branch_3
	sound_call Music_ChampionBattleB2W2_Ch1_branch_4
	duty_cycle 1
	octave 5
	volume_envelope 6, 2
	note B_, 2
	octave 6
	note D_, 2
	octave 5
	note A_, 2
	octave 6
	note D_, 2
	octave 5
	note G_, 2
	note A_, 2
	note E_, 2
	note G_, 2
	note D_, 2
	octave 2
	duty_cycle 0
	volume_envelope 8, 0
	sound_call Music_ChampionBattleB2W2_Ch1_branch_4
	sound_call Music_ChampionBattleB2W2_Ch1_branch_4
	volume_envelope 8, 0
	note D_, 2
	octave 1
	note G_, 2
	volume_envelope 2, 0
	note G_, 2
	rest 2
	octave 2
	sound_call Music_ChampionBattleB2W2_Ch1_branch_4
	sound_call Music_ChampionBattleB2W2_Ch1_branch_3
	sound_call Music_ChampionBattleB2W2_Ch1_branch_5
	octave 2
	duty_cycle 0
	volume_envelope 8, 0
	sound_call Music_ChampionBattleB2W2_Ch1_branch_2
	note G_, 2
	duty_cycle 1
	octave 5
	volume_envelope 6, 2
	note D_, 2
	note G_, 2
	note E_, 2
	note A_, 2
	octave 2
	duty_cycle 0
	volume_envelope 8, 0
	note D_, 2
	sound_call Music_ChampionBattleB2W2_Ch1_branch_2
	sound_call Music_ChampionBattleB2W2_Ch1_branch_5
	octave 2
	duty_cycle 0
	volume_envelope 8, 0
	note G_, 2
	volume_envelope 5, 0
	note G_, 2
	duty_cycle 1
	octave 4
	volume_envelope 6, 2
	note A_, 2
	octave 5
	note E_, 2
	note D_, 2
	note G_, 2
	octave 2
	duty_cycle 0
	volume_envelope 8, 0
	octave 3
	note D_, 2
	volume_envelope 5, 0
	note D_, 2
	duty_cycle 1
	octave 5
	volume_envelope 6, 2
	note B_, 2
	octave 6
	note D_, 2
	octave 5
	note A_, 2
	octave 6
	note D_, 2
	octave 5
	note G_, 1
	note A_, 1
	note E_, 1
	note G_, 1
	note D_, 1
	note E_, 1
	octave 4
	note B_, 1
	note D_, 1
	rest 16
	rest 8
	duty_cycle 0
	volume_envelope 8, 4
	note B_, 4
	note_type 8, 8, 2
	note G#, 2
	note B_, 2
	note G#, 2
	note_type 12, 8, 4
	note G_, 14
	rest 10
	volume_envelope 8, 2
	octave 5
	note C_, 1
	octave 4
	note G_, 1
	note F_, 1
	note D_, 1
	note C_, 1
	octave 3
	note A_, 1
	note G_, 1
	note F_, 1
	note D_, 11
	rest 9
	note B_, 4
	note_type 8, 8, 2
	octave 4
	note D#, 2
	note F_, 2
	note D#, 2
	note_type 12, 8, 4
	note D_, 2
	note C_, 2
	octave 3
	note B_, 5
	rest 16
	note G_, 1
	note G#, 1
	octave 4
	note C_, 1
	note D_, 1
	note F_, 1
	note G_, 1
	note G#, 1
	octave 5
	note C_, 1
	note D_, 1
	note F_, 1
	note G_, 1
	volume_envelope 9, 0
	octave 2
	sound_call Music_ChampionBattleB2W2_Ch3_branch_7
	sound_call Music_ChampionBattleB2W2_Ch1_branch_6
	octave 2
	note A#, 2
	sound_call Music_ChampionBattleB2W2_Ch3_branch_7
	note G_, 1
	volume_envelope 3, 0
	note G_, 1
	volume_envelope 9, 0
	note C#, 1
	volume_envelope 3, 0
	note C#, 1
	volume_envelope 9, 0
	note G_, 1
	volume_envelope 3, 0
	note G_, 1
	volume_envelope 9, 0
	note F_, 4
	note C#, 2
	note C_, 2
	octave 2
	note A#, 2
	sound_call Music_ChampionBattleB2W2_Ch3_branch_9
	sound_call Music_ChampionBattleB2W2_Ch1_branch_6
	octave 1
	note A#, 2
	sound_call Music_ChampionBattleB2W2_Ch3_branch_9
	octave 2
	note C_, 8
	note F_, 8
	sound_call Music_ChampionBattleB2W2_Ch1_branch_7
	sound_call Music_ChampionBattleB2W2_Ch1_branch_8
	volume_envelope 9, 0
	rest 2
	note B_, 1
	volume_envelope 3, 0
	note B_, 1
	volume_envelope 9, 0
	note B_, 2
	volume_envelope 3, 0
	note B_, 2
	volume_envelope 9, 0
	note B_, 4
	volume_envelope 3, 0
	note A#, 2
	rest 6
	sound_call Music_ChampionBattleB2W2_Ch1_branch_8
	rest 2
	volume_envelope 9, 0
	sound_call Music_ChampionBattleB2W2_Ch1_branch_7
	sound_call Music_ChampionBattleB2W2_Ch1_branch_8
	volume_envelope 9, 0
	note A#, 2
	note A_, 2
	volume_envelope 3, 0
	note A_, 2
	rest 2
	volume_envelope 9, 0
	note A_, 2
	volume_envelope 3, 0
	note A_, 2
	rest 2
	volume_envelope 9, 0
	note D_, 2
	volume_envelope 6, 0
	note D_, 2
	volume_envelope 3, 0
	note D_, 2
	volume_envelope 9, 0
	note G_, 4
	note G#, 2
	note A_, 4
	octave 2
	note C_, 4
	duty_cycle 1
	volume_envelope 8, 0
	octave 2
	note A_, 4
	volume_envelope 8, 7
	note A_, 4
	note G#, 4
	note G_, 4
	volume_envelope 8, 0
	note F#, 4
	volume_envelope 8, 7
	note F#, 4
	volume_envelope 8, 0
	note D#, 4
	volume_envelope 8, 7
	note D#, 4
	volume_envelope 8, 0
	note D_, 8
	volume_envelope 8, 7
	note D_, 8
	volume_envelope 8, 0
	note C_, 4
	volume_envelope 8, 7
	note C_, 4
	volume_envelope 8, 0
	note D#, 4
	volume_envelope 8, 7
	note D#, 4
	volume_envelope 8, 0
	note D_, 8
	volume_envelope 8, 6
	octave 4
	note F_, 16
	note D#, 6
	note F_, 1
	note D#, 1
	note D_, 16
	rest 16
Music_ChampionBattleB2W2_Ch1_loop_1:
	octave 4
	volume_envelope 6, 2
	note D_, 2
	octave 5
	note D_, 2
	octave 4
	note D_, 2
	octave 5
	note E_, 2
	octave 4
	note D_, 2
	octave 5
	note C_, 2
	octave 3
	note B_, 2
	octave 5
	note C_, 2
	octave 4
	note D_, 1
	note G_, 1
	note A_, 1
	octave 5
	note D_, 1
	note G_, 1
	note D_, 1
	octave 4
	note A_, 1
	note D_, 1
	sound_loop 3, Music_ChampionBattleB2W2_Ch1_loop_1
	note A#, 2
	note D#, 2
	note A#, 2
	octave 5
	note G_, 2
	octave 4
	note A#, 2
	note D#, 2
	note A#, 2
	octave 5
	note D#, 2
	octave 4
	note A#, 2
	note D#, 2
	note A#, 2
	octave 5
	note G_, 2
	note F#, 2
	octave 4
	note A_, 2
	note D_, 2
	note A_, 2
	octave 5
	note D_, 2
	octave 4
	note D_, 2
	octave 5
	note F#, 2
	octave 4
	note A_, 2
	note D_, 2
	note A_, 2
	note G_, 2
	note D_, 2
	note A_, 2
	octave 5
	note D_, 2
	note F#, 2
	octave 4
	note D_, 2
	duty_cycle 0
	volume_envelope 9, 0
	octave 3
	rest 2
	note D_, 4
	rest 2
	note D_, 4
	rest 4
	note F_, 2
	note E_, 2
	note F_, 2
	note F#, 2
	rest 2
	note F_, 2
	note F#, 2
	rest 2
	sound_call Music_ChampionBattleB2W2_Ch1_branch_1
	volume_envelope 8, 5
	octave 3
	note D_, 4
	note E_, 2
	note D_, 4
	octave 4
	note C_, 2
	octave 3
	note B_, 2
	octave 4
	note C_, 2
	note D_, 4
	note E_, 2
	note D_, 2
	rest 2
	octave 3
	note G_, 8
	note A_, 2
	octave 4
	note D_, 2
	note D#, 4
	note A_, 2
	note B_, 2
	note D_, 4
	octave 3
	note A_, 2
	note B_, 2
	octave 4
	note D_, 2
	note C_, 2
	octave 3
	note B_, 2
	note A_, 2
	note G_, 2
	rest 2
	note D_, 2
	note C_, 2
	note D#, 4
	note G#, 2
	octave 4
	note D#, 2
	note D_, 4
	note D_, 4
	rest 2
	note D_, 2
	rest 2
	note A_, 4
	rest 4
	volume_envelope 9, 7
	sound_call Music_ChampionBattleB2W2_Ch1_branch_9
	sound_call Music_ChampionBattleB2W2_Ch1_branch_9
	rest 8
	sound_call Music_ChampionBattleB2W2_Ch1_branch_9
	octave 3
	note E_, 2
	note D_, 2
	octave 2
	note A_, 2
	octave 3
	note D_, 2
	octave 2
	note G_, 2
	note A_, 2
	note G_, 2
	octave 3
	note D_, 4
	octave 2
	note B_, 2
	octave 3
	note D_, 2
	note E_, 4
	note A_, 2
	note B_, 2
	note D_, 4
	octave 2
	note A_, 2
	note B_, 2
	octave 3
	note D_, 2
	volume_envelope 4, 2
	octave 5
	note D_, 1
	note G_, 1
	note D_, 1
	octave 6
	note D_, 1
	octave 5
	note G_, 1
	octave 6
	note G_, 1
	note D_, 1
	octave 7
	note D_, 1
	volume_envelope 9, 0
	duty_cycle 0
	octave 2
	note A#, 5
	rest 1
	note A#, 2
	rest 2
	note A#, 6
	octave 3
	note C_, 5
	rest 1
	note C_, 2
	rest 2
	note C_, 6
	octave 3
	note D_, 8
	octave 2
	note D_, 16
	note C_, 8
	note D#, 16
	note D_, 14
	octave 1
	note_type 6, 9, 0
	note D_, 1
	rest 1
	note D_, 1
	rest 1
	note_type 12, 9, 0
	octave 2
	note C_, 8
	note D_, 8
	octave 1
	note G_, 8
	octave 2
	note D#, 8
	note D_, 2
	volume_envelope 6, 0
	note D_, 2
	volume_envelope 3, 0
	note D_, 2
	volume_envelope 9, 0
	note D_, 2
	volume_envelope 6, 0
	note D_, 2
	volume_envelope 3, 0
	note D_, 2
	volume_envelope 9, 0
	note D_, 2
	volume_envelope 6, 0
	note D_, 2
	volume_envelope 3, 0
	note D_, 2
	volume_envelope 9, 0
	note G_, 2
	volume_envelope 6, 0
	note G_, 2
	volume_envelope 3, 0
	note G_, 2
	volume_envelope 9, 0
	note G_, 1
	rest 1
	note G_, 2
	volume_envelope 6, 0
	note G_, 2
	volume_envelope 3, 0
	note G_, 2
	sound_jump Music_ChampionBattleB2W2_Ch1_loop_main

Music_ChampionBattleB2W2_Ch1_branch_1:
	volume_envelope 4, 2
	duty_cycle 1
	octave 6
	note B_, 1
	octave 7
	note D_, 1
	note C_, 1
	note D#, 1
	octave 6
	note B_, 1
	octave 7
	note D_, 1
	octave 6
	note A_, 1
	octave 7
	note C_, 1
	octave 6
	note G_, 1
	note B_, 1
	note F#, 1
	note A_, 1
	note E_, 1
	note G_, 1
	note D_, 1
	note F#, 1
	note C_, 1
	note D#, 1
	octave 5
	note B_, 1
	octave 6
	note D_, 1
	octave 5
	note A_, 1
	octave 6
	note C_, 1
	note G_, 1
	note B_, 1
	note F#, 1
	note A_, 1
	note E_, 1
	note G_, 1
	note D_, 1
	note F#, 1
	note C_, 1
	note E_, 1
	sound_ret

Music_ChampionBattleB2W2_Ch1_branch_2:
	note G_, 2
	volume_envelope 5, 0
	note G_, 2
	volume_envelope 8, 0
	note D_, 2
	sound_ret

Music_ChampionBattleB2W2_Ch1_branch_3:
	volume_envelope 8, 0
	note D_, 1
	volume_envelope 2, 0
	note D_, 1
	sound_ret

Music_ChampionBattleB2W2_Ch1_branch_4:
	volume_envelope 8, 0
	note D_, 2
	volume_envelope 2, 0
	note D_, 2
	sound_ret

Music_ChampionBattleB2W2_Ch1_branch_5:
	duty_cycle 1
	octave 5
	volume_envelope 6, 2
	note G_, 1
	note E_, 1
	note D_, 1
	octave 4
	note A_, 1
	note B_, 1
	note A_, 1
	note G_, 1
	note E_, 1
	sound_ret

Music_ChampionBattleB2W2_Ch1_branch_6:
	note G_, 1
	volume_envelope 3, 0
	note G_, 1
	volume_envelope 9, 0
	note G_, 1
	volume_envelope 3, 0
	note G_, 1
	volume_envelope 9, 0
	note G_, 1
	volume_envelope 3, 0
	note G_, 1
	volume_envelope 9, 0
	note F_, 4
	note C#, 2
	note C_, 2
	sound_ret

Music_ChampionBattleB2W2_Ch1_branch_7:
	octave 2
	note D_, 1
	volume_envelope 3, 0
	note D_, 1
	volume_envelope 9, 0
	note D_, 2
	volume_envelope 3, 0
	note D_, 2
	volume_envelope 9, 0
	note F_, 4
	note E_, 2
	note D#, 2
	note D_, 2
	volume_envelope 3, 0
	note D_, 2
	sound_ret

Music_ChampionBattleB2W2_Ch1_branch_8:
	octave 1
	volume_envelope 9, 0
	note E_, 2
	note D#, 2
	volume_envelope 3, 0
	note D#, 2
	volume_envelope 9, 0
	note F#, 2
	note F_, 2
	volume_envelope 3, 0
	note F_, 2
	sound_ret

Music_ChampionBattleB2W2_Ch1_branch_9:
	octave 3
	note G_, 2
	note E_, 2
	note D_, 2
	note E_, 2
	octave 2
	note B_, 2
	rest 2
	sound_ret

Music_ChampionBattleB2W2_Ch2:
	pitch_offset 1
	duty_cycle 2
	vibrato 18, 1, 5
	note_type 12, 11, 0
	rest 2
	sound_call Music_ChampionBattleB2W2_Ch2_branch_1
	note G_, 8
	note B_, 8
	rest 4
	note G_, 4
	note A_, 2
	note G_, 4
	note D_, 2
	volume_envelope 11, 0
	sound_call Music_ChampionBattleB2W2_Ch2_branch_1
	note G_, 6
	note B_, 10
	rest 2
	note D_, 2
	note E_, 2
	note D_, 2
	note_type 8, 11, 0
	note A_, 4
	note G_, 4
	note F_, 4
Music_ChampionBattleB2W2_Ch2_loop_main:
	octave 4
	note_type 12, 11, 0
	note G_, 4
	volume_envelope 8, 0
	note G_, 4
	octave 5
	volume_envelope 11, 0
	note D_, 4
	volume_envelope 8, 0
	note D_, 4
	octave 4
	volume_envelope 11, 0
	note A_, 4
	volume_envelope 8, 0
	note A_, 4
	octave 5
	volume_envelope 11, 0
	note E_, 4
	volume_envelope 8, 0
	note E_, 4
	volume_envelope 11, 0
	note D_, 4
	volume_envelope 8, 0
	note D_, 4
	octave 4
	volume_envelope 11, 0
	note A_, 4
	volume_envelope 8, 0
	note A_, 4
	volume_envelope 11, 0
	note B_, 4
	volume_envelope 8, 0
	note B_, 4
	volume_envelope 11, 0
	note E_, 4
	volume_envelope 8, 0
	note E_, 4
	volume_envelope 11, 0
	octave 3
	note G_, 4
	volume_envelope 8, 0
	note G_, 4
	octave 4
	volume_envelope 11, 0
	note D_, 4
	volume_envelope 8, 0
	note D_, 4
	octave 3
	volume_envelope 11, 0
	note A_, 4
	volume_envelope 8, 0
	note A_, 4
	octave 4
	volume_envelope 11, 0
	note E_, 4
	volume_envelope 8, 0
	note E_, 4
	volume_envelope 11, 0
	note D_, 4
	volume_envelope 8, 0
	note D_, 4
	octave 3
	volume_envelope 11, 0
	note A_, 4
	volume_envelope 8, 0
	note A_, 4
	volume_envelope 11, 0
	note B_, 4
	volume_envelope 8, 0
	note B_, 4
	volume_envelope 11, 0
	note D_, 4
	volume_envelope 8, 0
	note D_, 4
	volume_envelope 10, 5
	sound_call Music_ChampionBattleB2W2_Ch2_branch_2
	sound_call Music_ChampionBattleB2W2_Ch2_branch_2
	rest 2
	note G_, 4
	rest 2
	note F_, 4
	rest 2
	note A_, 4
	rest 2
	note G_, 2
	note F_, 4
	note G#, 4
	rest 4
	note G_, 4
	note F_, 4
	rest 4
	note A_, 4
	rest 2
	note G_, 4
	octave 4
	volume_envelope 11, 5
	note F_, 2
	note G#, 4
	volume_envelope 11, 0
	note G_, 16
	volume_envelope 11, 7
	note G_, 16
	rest 8
	duty_cycle 1
	octave 5
	volume_envelope 8, 2
	note G_, 1
	note F_, 1
	note D_, 1
	note C_, 1
	octave 4
	note G#, 1
	note G_, 1
	note F_, 1
	note D_, 1
	note C#, 1
	note C_, 1
	note A#, 1
	note G_, 3
	rest 6
	octave 4
	duty_cycle 2
	volume_envelope 11, 5
	note F_, 2
	note G#, 2
	volume_envelope 11, 0
	note G_, 16
	volume_envelope 11, 7
	note G_, 16
	rest 2
	volume_envelope 11, 0
	octave 3
	note G_, 2
	octave 4
	note G_, 2
	octave 3
	note F_, 2
	octave 4
	note F_, 2
	octave 3
	note G_, 2
	octave 4
	note G_, 2
	octave 3
	note A#, 2
	octave 4
	note A#, 2
	volume_envelope 9, 0
	note G#, 1
	octave 5
	volume_envelope 5, 0
	note G#, 1
	volume_envelope 9, 0
	note C_, 1
	octave 6
	volume_envelope 5, 0
	note C_, 1
	octave 5
	volume_envelope 9, 0
	note D#, 1
	octave 6
	volume_envelope 5, 0
	note D#, 1
	octave 5
	volume_envelope 9, 0
	note G#, 1
	octave 6
	volume_envelope 5, 0
	note G#, 1
	octave 5
	volume_envelope 9, 0
	note C_, 1
	octave 6
	volume_envelope 5, 0
	note C_, 1
	octave 5
	volume_envelope 9, 0
	note F_, 1
	octave 6
	volume_envelope 5, 0
	note F_, 1
	octave 5
	volume_envelope 9, 0
	note A_, 1
	octave 6
	volume_envelope 5, 0
	note A_, 1
	volume_envelope 9, 0
	note C_, 1
	octave 7
	volume_envelope 5, 0
	note C_, 1
	duty_cycle 0
	octave 3
	sound_call Music_ChampionBattleB2W2_Ch2_branch_3
	rest 2
	duty_cycle 2
	octave 5
	note G_, 2
	note C#, 2
	note C_, 2
	octave 4
	note A#, 2
	note F_, 2
	note D#, 2
	octave 3
	note A#, 2
	octave 4
	sound_call Music_ChampionBattleB2W2_Ch2_branch_3
	rest 16
	duty_cycle 0
	octave 3
	sound_call Music_ChampionBattleB2W2_Ch2_branch_3
	duty_cycle 2
	volume_envelope 9, 0
	octave 4
	note D_, 2
	note C#, 2
	note C_, 2
	note A#, 4
	note A_, 2
	note G_, 2
	note F#, 2
	octave 3
	volume_envelope 8, 0
	note A#, 14
	octave 4
	note C#, 1
	octave 3
	note A#, 1
	note A_, 8
	volume_envelope 8, 7
	note A_, 8
	volume_envelope 8, 0
	note D_, 4
	volume_envelope 8, 7
	note D_, 4
	note C#, 4
	note C_, 4
	volume_envelope 8, 0
	octave 2
	note B_, 4
	volume_envelope 8, 7
	note B_, 4
	volume_envelope 8, 0
	note G#, 4
	volume_envelope 8, 7
	note G#, 4
	volume_envelope 8, 0
	note G_, 8
	volume_envelope 8, 7
	note G_, 8
	volume_envelope 8, 0
	note F_, 4
	volume_envelope 8, 7
	note F_, 4
	volume_envelope 8, 0
	note G#, 4
	volume_envelope 8, 7
	note G#, 4
	volume_envelope 8, 0
	note G_, 8
	volume_envelope 8, 7
	note G_, 16
	octave 1
	volume_envelope 8, 0
	note D_, 8
	note G_, 8
	octave 2
	note D_, 8
	note G_, 4
	octave 3
	volume_envelope 9, 0
	note D_, 4
	note G_, 4
	octave 4
	volume_envelope 10, 0
	note D_, 4
	sound_call Music_ChampionBattleB2W2_Ch2_branch_4
	sound_call Music_ChampionBattleB2W2_Ch2_branch_4
	volume_envelope 11, 4
	octave 4
	note D_, 2
	note D_, 2
	note D_, 2
	note E_, 4
	note E_, 2
	note D_, 4
	volume_envelope 11, 7
	note G_, 4
	note A_, 4
	volume_envelope 11, 0
	note F_, 12
	volume_envelope 11, 7
	note F_, 12
	volume_envelope 11, 0
	note F#, 16
	volume_envelope 11, 7
	note F#, 16
	rest 16
	rest 12
	sound_call Music_ChampionBattleB2W2_Ch2_branch_5
	octave 4
	note D_, 2
	note E_, 2
	note A_, 2
	sound_call Music_ChampionBattleB2W2_Ch2_branch_6
	note G#, 2
	rest 2
	octave 5
	note C_, 2
	note G_, 2
	note F#, 6
	volume_envelope 11, 7
	note F#, 6
	rest 2
	sound_call Music_ChampionBattleB2W2_Ch2_branch_5
	note C_, 2
	octave 4
	note B_, 2
	note A_, 2
	sound_call Music_ChampionBattleB2W2_Ch2_branch_6
	note G_, 2
	rest 2
	note A#, 2
	octave 5
	note F_, 2
	note D#, 4
	note C_, 2
	octave 4
	note A#, 2
	note A_, 2
	rest 2
	octave 5
	note C_, 2
	note A_, 2
	note G_, 16
	volume_envelope 10, 0
	note G_, 16
	volume_envelope 9, 0
	note G_, 8
	volume_envelope 8, 0
	note G_, 8
	volume_envelope 8, 7
	note G_, 16
	rest 16
	rest 16
	rest 2
	volume_envelope 4, 0
	note G_, 8
	volume_envelope 4, -7
	note G_, 8
	volume_envelope 4, 0
	note B_, 8
	volume_envelope 4, -7
	note B_, 8
	sound_jump Music_ChampionBattleB2W2_Ch2_loop_main

Music_ChampionBattleB2W2_Ch2_branch_1:
	octave 5
	note D_, 16
	volume_envelope 11, 7
	note D_, 9
	rest 1
	volume_envelope 11, 0
	note C_, 2
	octave 4
	note B_, 2
	note A_, 2
	volume_envelope 11, 7
	sound_ret

Music_ChampionBattleB2W2_Ch2_branch_2:
	note G_, 4
	rest 2
	note F_, 4
	rest 2
	note A_, 4
	rest 2
	note G_, 4
	rest 2
	note F_, 4
	note G#, 4
	sound_ret

Music_ChampionBattleB2W2_Ch2_branch_3:
	volume_envelope 11, 3
	note G_, 2
	volume_envelope 11, 0
	note G_, 4
	note A#, 4
	note A_, 2
	note G#, 2
	note G_, 2
	sound_ret

Music_ChampionBattleB2W2_Ch2_branch_4:
	octave 4
	volume_envelope 11, 4
	note G_, 2
	note G_, 2
	note G_, 2
	note B_, 4
	note B_, 2
	note A_, 4
	volume_envelope 11, 7
	octave 5
	note D_, 8
	sound_ret

Music_ChampionBattleB2W2_Ch2_branch_5:
	octave 4
	volume_envelope 11, 0
	note D_, 4
	octave 5
	note D_, 12
	volume_envelope 11, 7
	note D_, 14
	volume_envelope 11, 0
	sound_ret

Music_ChampionBattleB2W2_Ch2_branch_6:
	note G_, 4
	note A_, 2
	note G_, 10
	volume_envelope 11, 7
	note G_, 10
	volume_envelope 11, 0
	octave 5
	note D_, 6
	rest 2
	octave 4
	note E_, 2
	note G_, 2
	note A_, 4
	octave 5
	note D_, 2
	note E_, 2
	octave 4
	note G_, 4
	note D_, 2
	note E_, 2
	note G_, 10
	rest 2
	note F_, 2
	note D#, 2
	sound_ret

Music_ChampionBattleB2W2_Ch3:
	stereo_panning TRUE, TRUE
	note_type 6, 1, 9
	octave 1
	note D_, 1
	rest 1
	note D_, 1
	rest 1
	note_type 12, 1, 9
	octave 2
	sound_call Music_ChampionBattleB2W2_Ch3_branch_1
	sound_call Music_ChampionBattleB2W2_Ch3_branch_1
Music_ChampionBattleB2W2_Ch3_loop_main:
	octave 1
	volume_envelope 1, 9
	sound_call Music_ChampionBattleB2W2_Ch3_branch_4
	sound_call Music_ChampionBattleB2W2_Ch3_branch_5
	sound_call Music_ChampionBattleB2W2_Ch3_branch_5
	sound_call Music_ChampionBattleB2W2_Ch3_branch_4
	sound_call Music_ChampionBattleB2W2_Ch3_branch_5
	rest 2
	sound_call Music_ChampionBattleB2W2_Ch3_branch_5
	sound_call Music_ChampionBattleB2W2_Ch3_branch_4
	sound_call Music_ChampionBattleB2W2_Ch3_branch_4
	sound_call Music_ChampionBattleB2W2_Ch3_branch_5
	volume_envelope 1, 9
	note F_, 2
	sound_call Music_ChampionBattleB2W2_Ch3_branch_4
	sound_call Music_ChampionBattleB2W2_Ch3_branch_5
	sound_call Music_ChampionBattleB2W2_Ch3_branch_5
	volume_envelope 1, 9
	note G_, 2
	note D_, 2
	volume_envelope 3, 9
	note D_, 2
	rest 2
	sound_call Music_ChampionBattleB2W2_Ch3_branch_5
	sound_call Music_ChampionBattleB2W2_Ch3_branch_4
	sound_call Music_ChampionBattleB2W2_Ch3_branch_4
	sound_call Music_ChampionBattleB2W2_Ch3_branch_5
	volume_envelope 1, 9
	note F_, 2
	sound_call Music_ChampionBattleB2W2_Ch3_branch_2
	sound_call Music_ChampionBattleB2W2_Ch3_branch_2
	sound_call Music_ChampionBattleB2W2_Ch3_branch_3
	sound_call Music_ChampionBattleB2W2_Ch3_branch_2
	sound_call Music_ChampionBattleB2W2_Ch3_branch_6
	sound_call Music_ChampionBattleB2W2_Ch3_branch_2
	sound_call Music_ChampionBattleB2W2_Ch3_branch_2
	sound_call Music_ChampionBattleB2W2_Ch3_branch_3
	sound_call Music_ChampionBattleB2W2_Ch3_branch_2
	sound_call Music_ChampionBattleB2W2_Ch3_branch_6
Music_ChampionBattleB2W2_Ch3_loop_1:
	octave 1
	note G_, 2
	octave 2
	note D_, 2
	octave 1
	note G_, 2
	octave 2
	note G_, 2
	octave 1
	note G_, 2
	octave 2
	note F_, 2
	octave 1
	note G_, 2
	octave 2
	note D_, 2
	sound_loop 8, Music_ChampionBattleB2W2_Ch3_loop_1
	sound_call Music_ChampionBattleB2W2_Ch3_branch_7
	sound_call Music_ChampionBattleB2W2_Ch3_branch_8
	octave 2
	note A#, 2
	sound_call Music_ChampionBattleB2W2_Ch3_branch_7
	note G_, 1
	volume_envelope 3, 9
	note G_, 1
	volume_envelope 1, 9
	note C#, 1
	volume_envelope 3, 9
	note C#, 1
	volume_envelope 1, 9
	note G_, 1
	volume_envelope 3, 9
	note G_, 1
	volume_envelope 1, 9
	note F_, 4
	note C#, 2
	note C_, 2
	octave 2
	note A#, 2
	sound_call Music_ChampionBattleB2W2_Ch3_branch_9
	sound_call Music_ChampionBattleB2W2_Ch3_branch_8
	octave 1
	note A#, 2
	sound_call Music_ChampionBattleB2W2_Ch3_branch_9
	note G#, 8
	octave 3
	note C_, 8
	sound_call Music_ChampionBattleB2W2_Ch3_branch_10
	sound_call Music_ChampionBattleB2W2_Ch3_branch_11
	octave 1
	volume_envelope 1, 9
	note C_, 2
	octave 2
	note G_, 1
	volume_envelope 3, 9
	note G_, 1
	volume_envelope 1, 9
	note G_, 2
	volume_envelope 3, 9
	note G_, 2
	volume_envelope 1, 9
	note F_, 4
	volume_envelope 3, 9
	note F_, 2
	rest 6
	sound_call Music_ChampionBattleB2W2_Ch3_branch_11
	octave 1
	volume_envelope 1, 9
	note C_, 2
	sound_call Music_ChampionBattleB2W2_Ch3_branch_10
	sound_call Music_ChampionBattleB2W2_Ch3_branch_11
	octave 2
	volume_envelope 1, 9
	note D#, 2
	note D_, 2
	volume_envelope 3, 9
	note D_, 2
	rest 2
	volume_envelope 1, 9
	note D_, 2
	volume_envelope 3, 9
	note D_, 2
	rest 2
	volume_envelope 1, 9
	octave 1
	note F#, 2
	volume_envelope 2, 9
	note F#, 2
	volume_envelope 3, 9
	note F#, 2
	volume_envelope 1, 9
	octave 3
	note C_, 4
	note C#, 2
	note D_, 4
	note F_, 4
Music_ChampionBattleB2W2_Ch3_loop_2:
	octave 1
	note D_, 2
	octave 2
	note D_, 2
	sound_loop 12, Music_ChampionBattleB2W2_Ch3_loop_2
Music_ChampionBattleB2W2_Ch3_loop_3:
	octave 1
	note C_, 2
	octave 2
	note C_, 2
	sound_loop 4, Music_ChampionBattleB2W2_Ch3_loop_3
Music_ChampionBattleB2W2_Ch3_loop_4:
	octave 1
	note D_, 2
	octave 2
	note D_, 2
	sound_loop 10, Music_ChampionBattleB2W2_Ch3_loop_4
	octave 1
	note F_, 2
	octave 2
	note F_, 2
	octave 1
	note F_, 2
	octave 2
	note F_, 2
	octave 1
	note G_, 2
	octave 2
	note G_, 2
	octave 1
	note G_, 2
	octave 2
	note G_, 2
	octave 1
	note B_, 2
	octave 2
	note B_, 2
	octave 1
	note B_, 2
	octave 2
	note B_, 2
	sound_call Music_ChampionBattleB2W2_Ch3_branch_12
	note D_, 2
	note F#, 2
	octave 1
	note G_, 2
	octave 2
	sound_call Music_ChampionBattleB2W2_Ch3_branch_12
	octave 2
	note D_, 2
	note F_, 2
	octave 1
	note G_, 2
	sound_call Music_ChampionBattleB2W2_Ch3_branch_12
	note G_, 2
	octave 2
	note D_, 2
	note G_, 2
	note D#, 2
	note A#, 2
	note D#, 2
	note A#, 2
	note D#, 2
	note A#, 2
	note D#, 2
	octave 3
	note D#, 2
	octave 2
	note D#, 2
	note A#, 2
	note D#, 2
	octave 3
	note D#, 2
Music_ChampionBattleB2W2_Ch3_loop_5:
	octave 2
	note D_, 2
	octave 3
	note D_, 2
	sound_loop 8, Music_ChampionBattleB2W2_Ch3_loop_5
	octave 1
	note D_, 2
	octave 2
	note D_, 2
	rest 4
	octave 3
	note D_, 2
	octave 2
	note D_, 2
	rest 4
	note C#, 2
	note C_, 2
	note C#, 2
	note D_, 2
	rest 2
	note C#, 2
	note D_, 2
	rest 2
	octave 3
	note D_, 1
	volume_envelope 3, 9
	note D_, 1
	volume_envelope 1, 9
	note D_, 2
	volume_envelope 3, 9
	note D_, 2
	volume_envelope 1, 9
	note D_, 2
	volume_envelope 3, 9
	note D_, 2
	volume_envelope 1, 9
	note D_, 2
	volume_envelope 3, 9
	note D_, 2
	volume_envelope 1, 9
	note G_, 4
	note D_, 2
	volume_envelope 3, 9
	note D_, 2
	volume_envelope 1, 9
	note D_, 2
	volume_envelope 3, 9
	note D_, 2
	volume_envelope 1, 9
	note C_, 4
	octave 2
	note A#, 2
	note B_, 4
	octave 3
	note C_, 2
	octave 2
	note B_, 4
	octave 1
	note B_, 2
	octave 2
	note C_, 2
	volume_envelope 1, 9
	note D_, 2
	volume_envelope 3, 9
	note D_, 2
	volume_envelope 1, 9
	note B_, 2
	volume_envelope 3, 9
	note B_, 2
	volume_envelope 1, 9
	note B_, 4
	octave 3
	note D_, 6
	note E_, 1
	volume_envelope 3, 9
	note E_, 1
	volume_envelope 1, 9
	note E_, 2
	volume_envelope 3, 9
	note E_, 2
	volume_envelope 1, 9
	note D#, 4
	volume_envelope 3, 9
	note D#, 2
	rest 2
	volume_envelope 1, 9
	note E_, 4
	note D_, 2
	note E_, 2
	note G_, 4
	octave 2
	note A_, 2
	note A#, 2
	note B_, 2
	octave 3
	note F_, 4
	note D#, 2
	note D_, 4
	octave 2
	note G_, 2
	note A#, 2
	octave 3
	volume_envelope 1, 9
	note D_, 2
	volume_envelope 3, 9
	note D_, 2
	volume_envelope 1, 9
	note D_, 2
	volume_envelope 3, 9
	note D_, 2
	rest 2
	volume_envelope 1, 9
	note D_, 2
	volume_envelope 3, 9
	note D_, 2
	octave 1
	volume_envelope 1, 9
	note A_, 4
	octave 2
	note D_, 8
	note G_, 8
	note B_, 8
	note A_, 8
	note G_, 4
	note A_, 2
	note G_, 10
	note D_, 16
	note E_, 8
	note F#, 8
	note G_, 6
	note D_, 6
	note E_, 4
	note D#, 6
	note D_, 2
	rest 2
	note D#, 6
	note F_, 6
	note D#, 2
	rest 2
	note F_, 6
	octave 3
	note G_, 8
	octave 2
	note G_, 16
	note F_, 8
	note G#, 16
	note G_, 14
	octave 1
	note_type 6, 1, 9
	note G_, 1
	rest 1
	note G_, 1
	rest 1
	note_type 12, 1, 9
	octave 2
	note F_, 8
	note G_, 8
	note C_, 8
	note G#, 8
	note G_, 2
	volume_envelope 2, 9
	note G_, 2
	volume_envelope 3, 9
	note G_, 2
	volume_envelope 1, 9
	note G_, 2
	volume_envelope 2, 9
	note G_, 2
	volume_envelope 3, 9
	note G_, 2
	volume_envelope 1, 9
	note G_, 2
	volume_envelope 2, 9
	note G_, 2
	volume_envelope 3, 9
	note G_, 2
	volume_envelope 1, 9
	note B_, 2
	volume_envelope 2, 9
	note B_, 2
	volume_envelope 3, 9
	note B_, 2
	volume_envelope 1, 9
	note B_, 1
	rest 1
	note B_, 2
	volume_envelope 2, 9
	note B_, 2
	volume_envelope 3, 9
	note B_, 2
	sound_jump Music_ChampionBattleB2W2_Ch3_loop_main

Music_ChampionBattleB2W2_Ch3_branch_1:
	note G_, 16
	note F_, 16
	note E_, 16
	note D#, 8
	note F_, 8
	sound_ret

Music_ChampionBattleB2W2_Ch3_branch_2:
	octave 2
	note D_, 2
	volume_envelope 2, 9
	note D_, 2
	volume_envelope 1, 9
	octave 1
	note G_, 2
	sound_ret

Music_ChampionBattleB2W2_Ch3_branch_3:
	octave 2
	note G_, 2
	volume_envelope 2, 9
	note G_, 2
	volume_envelope 1, 9
	octave 1
	note G_, 2
	sound_ret

Music_ChampionBattleB2W2_Ch3_branch_4:
	volume_envelope 1, 9
	note G_, 1
	volume_envelope 3, 9
	note G_, 1
	sound_ret

Music_ChampionBattleB2W2_Ch3_branch_5:
	volume_envelope 1, 9
	note G_, 2
	volume_envelope 3, 9
	note G_, 2
	sound_ret

Music_ChampionBattleB2W2_Ch3_branch_6:
	octave 2
	note G_, 2
	octave 1
	note G_, 2
	octave 2
	note A_, 2
	note G_, 2
	sound_ret

Music_ChampionBattleB2W2_Ch3_branch_7:
	note G_, 2
	octave 3
	note G_, 2
	octave 2
	note F_, 2
	octave 3
	note F_, 2
	octave 2
	note G_, 2
	octave 3
	note G_, 2
	octave 2
	note A#, 2
	octave 3
	note A#, 2
	sound_ret

Music_ChampionBattleB2W2_Ch3_branch_8:
	note G_, 1
	volume_envelope 3, 9
	note G_, 1
	volume_envelope 1, 9
	note G_, 1
	volume_envelope 3, 9
	note G_, 1
	volume_envelope 1, 9
	note G_, 1
	volume_envelope 3, 9
	note G_, 1
	volume_envelope 1, 9
	note F_, 4
	note C#, 2
	note C_, 2
	sound_ret

Music_ChampionBattleB2W2_Ch3_branch_9:
	octave 1
	note G_, 2
	octave 2
	note G_, 2
	octave 1
	note F_, 2
	octave 2
	note F_, 2
	octave 1
	note G_, 2
	octave 2
	note G_, 2
	octave 1
	note A#, 2
	octave 2
	note A#, 2
	sound_ret

Music_ChampionBattleB2W2_Ch3_branch_10:
	octave 2
	note B_, 1
	volume_envelope 3, 9
	note B_, 1
	volume_envelope 1, 9
	note B_, 2
	volume_envelope 3, 9
	note B_, 2
	volume_envelope 1, 9
	octave 3
	note D_, 4
	note C#, 2
	note C_, 2
	octave 2
	note B_, 2
	volume_envelope 3, 9
	note B_, 2
	sound_ret

Music_ChampionBattleB2W2_Ch3_branch_11:
	octave 1
	volume_envelope 1, 9
	note B_, 2
	note A#, 2
	volume_envelope 3, 9
	note A#, 2
	volume_envelope 1, 9
	octave 2
	note C#, 2
	note C_, 2
	volume_envelope 3, 9
	note C_, 2
	sound_ret

Music_ChampionBattleB2W2_Ch3_branch_12:
	octave 2
	volume_envelope 1, 9
	note C_, 1
	volume_envelope 3, 9
	note C_, 1
	sound_loop 3, Music_ChampionBattleB2W2_Ch3_branch_12
	volume_envelope 1, 9
	note D_, 2
	volume_envelope 3, 9
	note D_, 2
	volume_envelope 1, 9
	note D_, 2
	note C_, 4
	octave 1
	note B_, 2
	sound_ret

Music_ChampionBattleB2W2_Ch4:
	toggle_noise 3
	drum_speed 12
	drum_note 1, 1
	drum_note 1, 1
	sound_call Music_ChampionBattleB2W2_Ch4_branch_1
	drum_note 1, 2
	drum_note 1, 4
	drum_note 4, 2
	sound_call Music_ChampionBattleB2W2_Ch4_branch_1
	drum_speed 8
	drum_note 1, 4
	drum_note 1, 4
	drum_note 4, 4
Music_ChampionBattleB2W2_Ch4_loop_main:
	drum_speed 12
	sound_call Music_ChampionBattleB2W2_Ch4_branch_2
	sound_call Music_ChampionBattleB2W2_Ch4_branch_2
	sound_call Music_ChampionBattleB2W2_Ch4_branch_2
	drum_note 4, 4
	drum_note 1, 2
	drum_note 4, 4
	drum_note 4, 2
	drum_note 1, 2
	drum_note 4, 1
	drum_note 4, 1
Music_ChampionBattleB2W2_Ch4_loop_1:
	drum_note 1, 2
	drum_note 4, 2
	sound_loop 14, Music_ChampionBattleB2W2_Ch4_loop_1
	drum_note 1, 1
	drum_note 1, 1
	drum_note 1, 2
	drum_note 1, 1
	drum_note 1, 1
	drum_note 1, 2
Music_ChampionBattleB2W2_Ch4_loop_2:
	sound_call Music_ChampionBattleB2W2_Ch4_branch_3
	sound_loop 16, Music_ChampionBattleB2W2_Ch4_loop_2
Music_ChampionBattleB2W2_Ch4_loop_3:
	sound_call Music_ChampionBattleB2W2_Ch4_branch_3
	sound_loop 15, Music_ChampionBattleB2W2_Ch4_loop_3
	drum_note 1, 1
	drum_note 1, 1
	drum_note 1, 1
	drum_note 1, 1
	drum_note 1, 1
	drum_note 1, 1
	drum_note 1, 1
	drum_note 1, 1
Music_ChampionBattleB2W2_Ch4_loop_4:
	sound_call Music_ChampionBattleB2W2_Ch4_branch_3
	sound_loop 12, Music_ChampionBattleB2W2_Ch4_loop_4
	drum_note 1, 6
	drum_note 1, 6
	drum_note 1, 4
	drum_note 9, 4
	drum_note 9, 4
	drum_note 9, 4
	drum_note 9, 4
Music_ChampionBattleB2W2_Ch4_loop_5:
	sound_call Music_ChampionBattleB2W2_Ch4_branch_3
	sound_loop 16, Music_ChampionBattleB2W2_Ch4_loop_5
Music_ChampionBattleB2W2_Ch4_loop_6:
	drum_note 12, 2
	drum_note 4, 2
	drum_note 1, 2
	drum_note 4, 2
	drum_note 9, 2
	drum_note 1, 2
	drum_note 4, 2
	drum_note 9, 2
	drum_note 1, 2
	drum_note 9, 2
	sound_call Music_ChampionBattleB2W2_Ch4_branch_4
	sound_loop 3, Music_ChampionBattleB2W2_Ch4_loop_6
	drum_note 1, 2
	drum_note 4, 2
	drum_note 1, 2
	drum_note 4, 2
	drum_note 1, 1
	drum_note 1, 1
	drum_note 1, 2
	drum_note 1, 1
	drum_note 1, 1
	drum_note 1, 2
	drum_note 1, 2
	drum_note 4, 2
	drum_note 1, 2
	drum_note 1, 1
	drum_note 1, 1
	drum_note 1, 2
	drum_note 4, 2
	drum_note 1, 1
	drum_note 1, 1
	drum_note 1, 2
	drum_note 1, 2
	drum_note 4, 2
	drum_note 1, 1
	drum_note 1, 1
	drum_note 1, 2
	drum_note 1, 2
	drum_note 4, 4
	drum_note 1, 2
	drum_note 4, 4
	drum_note 1, 2
	drum_note 4, 2
	drum_note 9, 16
	rest 12
	sound_call Music_ChampionBattleB2W2_Ch4_branch_4
Music_ChampionBattleB2W2_Ch4_loop_7:
	sound_call Music_ChampionBattleB2W2_Ch4_branch_3
	sound_loop 16, Music_ChampionBattleB2W2_Ch4_loop_7
Music_ChampionBattleB2W2_Ch4_loop_8:
	sound_call Music_ChampionBattleB2W2_Ch4_branch_3
	sound_loop 16, Music_ChampionBattleB2W2_Ch4_loop_8
	drum_note 1, 16
	rest 16
	rest 16
	rest 14
	drum_note 1, 1
	drum_note 1, 1
	drum_note 1, 16
	rest 14
	drum_note 1, 1
	drum_note 1, 1
Music_ChampionBattleB2W2_Ch4_loop_9:
	drum_note 1, 2
	drum_note 4, 2
	sound_loop 7, Music_ChampionBattleB2W2_Ch4_loop_9
	sound_call Music_ChampionBattleB2W2_Ch4_branch_4
	sound_jump Music_ChampionBattleB2W2_Ch4_loop_main

Music_ChampionBattleB2W2_Ch4_branch_1:
	drum_note 4, 4
	drum_note 4, 4
	drum_note 1, 6
	drum_note 4, 4
	drum_note 1, 2
	drum_note 4, 4
	drum_note 1, 4
	drum_note 4, 2
	drum_note 4, 2
	drum_note 4, 4
	drum_note 4, 4
	drum_note 1, 6
	drum_note 4, 4
	drum_note 1, 2
	drum_note 4, 4
	sound_ret

Music_ChampionBattleB2W2_Ch4_branch_2:
	drum_note 4, 4
	drum_note 1, 2
	drum_note 4, 4
	drum_note 4, 2
	drum_note 1, 2
	drum_note 4, 2
	sound_ret

Music_ChampionBattleB2W2_Ch4_branch_3:
	drum_note 4, 2
	drum_note 9, 2
	drum_note 1, 2
	drum_note 9, 2
	sound_ret

Music_ChampionBattleB2W2_Ch4_branch_4:
	drum_speed 6
	drum_note 1, 1
	drum_note 1, 1
	drum_note 1, 1
	drum_note 1, 1
	drum_note 1, 1
	drum_note 1, 1
	drum_note 1, 1
	drum_note 1, 1
	drum_speed 12
	sound_ret
