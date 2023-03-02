; Pokémon R/S/E - Battle! Champion
; Demixed by Mmmmmm
; https://pastebin.com/qyNUWZfz
; https://hax.iimarckus.org/topic/6777/4/

Music_ChampionBattleRSE:
	channel_count 4
	channel 1, Music_ChampionBattleRSE_Ch1
	channel 2, Music_ChampionBattleRSE_Ch2
	channel 3, Music_ChampionBattleRSE_Ch3
	channel 4, Music_ChampionBattleRSE_Ch4

Music_ChampionBattleRSE_Ch1:
	tempo 192
	volume 7, 7
	duty_cycle 2
	pitch_offset 2
	vibrato 8, 1, 5
	note_type 3, 9, 4
Music_ChampionBattleRSE_Ch1_loop_1:
	volume_envelope 5, 0
	octave 5
	note G_, 2
	note G#, 2
	note A#, 4
	sound_loop 8, Music_ChampionBattleRSE_Ch1_loop_1
	duty_cycle 1
	note_type 12, 11, 3
	octave 4
	note C_, 3
	note C#, 3
	volume_envelope 11, 5
	note D#, 2
	octave 3
	volume_envelope 11, 3
	note G_, 3
	note G#, 3
	volume_envelope 11, 5
	note A#, 2
	octave 4
	volume_envelope 11, 3
	note C_, 3
	note C#, 3
	volume_envelope 11, 5
	note D#, 2
	volume_envelope 11, 3
	note D#, 3
	note F_, 3
	volume_envelope 11, 5
	note F#, 2
	octave 5
	volume_envelope 11, 3
	note C_, 3
	note C#, 3
	volume_envelope 11, 5
	note D#, 2
	octave 4
	volume_envelope 11, 3
	note G_, 3
	note G#, 3
	volume_envelope 11, 5
	note A#, 2
	octave 5
	volume_envelope 11, 3
	note C_, 3
	note C#, 3
	volume_envelope 11, 5
	note D#, 2
	volume_envelope 11, 3
	note D#, 3
	note F_, 3
	volume_envelope 11, 5
	note G_, 2
Music_ChampionBattleRSE_Ch1_loop_main:
	duty_cycle 1
Music_ChampionBattleRSE_Ch1_loop_2:
	volume_envelope 11, 0
	octave 4
	note C_, 2
	volume_envelope 11, 5
	note C_, 5
	octave 3
	note G_, 1
	octave 4
	note C_, 1
	octave 3
	note G_, 1
	note C_, 1
	note G_, 2
	note C_, 1
	octave 4
	note C_, 1
	note F_, 1
	volume_envelope 11, 0
	note F#, 2
	volume_envelope 11, 5
	note F#, 5
	note F_, 1
	note F#, 1
	note F_, 1
	volume_envelope 11, 0
	note F#, 1
	volume_envelope 11, 5
	note F#, 5
	sound_loop 2, Music_ChampionBattleRSE_Ch1_loop_2
	duty_cycle 2
	volume_envelope 10, 6
	octave 3
	note G_, 3
	note G#, 3
	octave 4
	note C#, 2
	note C_, 1
	note C#, 1
	note C_, 1
	octave 3
	note A#, 2
	note G#, 1
	note G_, 1
	note F_, 1
	volume_envelope 10, 0
	note G#, 8
	volume_envelope 10, 7
	note G#, 8
	duty_cycle 3
	volume_envelope 10, 6
	note A#, 3
	note G#, 1
	note G_, 1
	note F_, 1
	note D#, 1
	note F_, 1
	note G_, 3
	note F_, 1
	note D#, 1
	note C#, 1
	note C_, 1
	octave 2
	note A#, 1
	octave 3
	volume_envelope 10, 0
	note F_, 8
	volume_envelope 10, 7
	note F_, 8
	duty_cycle 2
	octave 2
	volume_envelope 3, 3
	note C_, 1
	note C_, 1
	note C_, 1
	note C_, 1
	volume_envelope 5, 3
	note C_, 1
	note C_, 1
	volume_envelope 7, 3
	note C_, 1
	note C_, 1
	volume_envelope 8, 3
	note C_, 1
	note C_, 1
	volume_envelope 9, 3
	note C_, 1
	note C_, 1
	note C_, 1
	note C_, 1
	note C_, 1
	note C_, 1
	duty_cycle 3
	volume_envelope 11, 4
	sound_call Music_ChampionBattleRSE_Ch1_branch_1
	duty_cycle 0
	octave 5
	note C_, 1
	note C_, 1
	note C_, 1
	octave 4
	note G#, 3
	note G_, 2
	note C_, 1
	note E_, 1
	note G_, 1
	note G#, 3
	octave 5
	note C#, 2
	note C_, 1
	note C_, 1
	note C_, 1
	octave 4
	note G#, 3
	note G_, 2
	note C_, 1
	note D#, 1
	note G_, 1
	note G#, 2
	octave 5
	note C_, 1
	note D#, 1
	note F#, 1
	duty_cycle 1
	octave 4
	note C#, 2
	note G#, 2
	note A_, 2
	note G#, 1
	note F#, 1
	note G#, 1
	note E_, 1
	note D_, 2
	note E_, 2
	note D_, 2
	note C#, 1
	note C#, 1
	note G#, 2
	note A_, 2
	note G#, 1
	note F#, 1
	note A_, 1
	note F#, 1
	octave 5
	note C#, 2
	note D_, 2
	octave 4
	note B_, 2
	note E_, 2
	note B_, 2
	octave 5
	note C_, 2
	octave 4
	note B_, 1
	note A_, 1
	note B_, 1
	note G_, 1
	note F_, 2
	note G_, 2
	note F_, 2
	note E_, 1
	note E_, 1
	note B_, 2
	octave 5
	note C_, 2
	octave 4
	note B_, 1
	note A_, 1
	octave 5
	note C_, 1
	octave 4
	note A_, 1
	octave 5
	note E_, 2
	note F_, 2
	note A#, 2
	volume_envelope 11, 7
	note A_, 2
	octave 4
	note A_, 2
	octave 3
	note A_, 2
	octave 5
	note G_, 2
	octave 4
	note G_, 2
	octave 3
	note G_, 2
	octave 5
	note C_, 2
	octave 4
	note C_, 2
	octave 3
	note C_, 2
	octave 5
	note F_, 2
	octave 4
	note F_, 2
	octave 3
	note F_, 2
	octave 5
	note D_, 2
	octave 4
	note D_, 2
	octave 3
	note D_, 2
	octave 5
	note E_, 2
	octave 4
	note E_, 2
	octave 3
	note E_, 2
	octave 5
	note F_, 2
	octave 4
	note F_, 2
	octave 3
	note F_, 2
	octave 5
	note G_, 2
	octave 4
	note G_, 2
	octave 3
	note G_, 2
	octave 5
	volume_envelope 11, 0
	note G#, 6
	volume_envelope 11, 5
	note G#, 10
	octave 3
	volume_envelope 11, 0
	note A#, 6
	volume_envelope 11, 5
	note A#, 10
	volume_envelope 11, 0
	note G_, 6
	volume_envelope 11, 5
	note G_, 10
	volume_envelope 11, 0
	note A#, 6
	volume_envelope 11, 5
	note A#, 10
	sound_jump Music_ChampionBattleRSE_Ch1_loop_main

Music_ChampionBattleRSE_Ch1_branch_1:
	octave 4
	note C_, 1
	note C_, 1
	note C_, 1
	note C#, 3
	note D#, 2
	octave 3
	note G_, 1
	note G_, 1
	note G_, 1
	note G#, 3
	octave 4
	note C#, 2
	note C_, 1
	note C_, 1
	note C_, 1
	note C#, 3
	note D#, 2
	note D#, 1
	note D#, 1
	note D#, 1
	note F_, 3
	note F#, 2
	sound_ret

Music_ChampionBattleRSE_Ch2:
	duty_cycle 3
	vibrato 18, 2, 5
	pitch_offset 1
	note_type 3, 13, 4
	volume_envelope 6, 0
	octave 4
	note D#, 2
	note D_, 2
	note C#, 2
	note C_, 2
	note A#, 2
	note A_, 2
	note G#, 2
	note G_, 2
	note C_, 2
	octave 3
	note B_, 2
	note A#, 2
	note A_, 2
	octave 4
	note F#, 2
	note F_, 2
	note E_, 2
	note D#, 2
	octave 3
	note A_, 2
	note G#, 2
	note G_, 2
	note F#, 2
	octave 4
	note D_, 2
	note C#, 2
	note C_, 2
	octave 3
	note B_, 2
	note F#, 2
	note F_, 2
	note E_, 2
	note D#, 2
	note A#, 2
	note A_, 2
	note A#, 2
	note B_, 2
	note_type 12, 11, 3
	note G_, 3
	note G#, 3
	volume_envelope 11, 5
	note A#, 2
	volume_envelope 11, 3
	note E_, 3
	note F_, 3
	volume_envelope 11, 5
	note G_, 2
	volume_envelope 11, 3
	note G_, 3
	note G#, 3
	volume_envelope 11, 5
	note A#, 2
	volume_envelope 11, 3
	note A#, 3
	octave 4
	note C_, 3
	volume_envelope 11, 5
	note C#, 2
	volume_envelope 11, 3
	note C_, 3
	note C#, 3
	volume_envelope 11, 5
	note D#, 2
	octave 3
	volume_envelope 11, 3
	note G_, 3
	note G#, 3
	volume_envelope 11, 5
	note A#, 2
	octave 4
	volume_envelope 11, 3
	note C_, 3
	note C#, 3
	volume_envelope 11, 5
	note D#, 2
	volume_envelope 11, 3
	note D#, 3
	note F_, 3
	volume_envelope 11, 5
	note G_, 2
Music_ChampionBattleRSE_Ch2_loop_main:
	duty_cycle 0
Music_ChampionBattleRSE_Ch2_loop_1:
	volume_envelope 11, 0
	octave 3
	note E_, 2
	volume_envelope 11, 5
	note E_, 5
	note C_, 1
	octave 2
	note E_, 2
	note G_, 1
	octave 3
	note C_, 2
	note E_, 2
	note G#, 1
	volume_envelope 11, 0
	note A#, 2
	volume_envelope 11, 5
	note A#, 5
	note A_, 1
	note A#, 1
	note A_, 1
	note A#, 2
	volume_envelope 11, 2
	note A#, 1
	note A#, 1
	volume_envelope 11, 4
	note G#, 2
	sound_loop 2, Music_ChampionBattleRSE_Ch2_loop_1
	volume_envelope 10, 6
	octave 3
	note E_, 3
	note F_, 3
	note A#, 2
	note G#, 1
	note A#, 1
	note G#, 1
	note G_, 2
	note F_, 1
	note D#, 1
	note C#, 1
	note F_, 4
	note D#, 4
	note C#, 4
	note C_, 4
	octave 4
	note G_, 4
	note F_, 4
	note D#, 4
	note C#, 4
	volume_envelope 10, 0
	note C_, 4
	volume_envelope 10, 6
	note C_, 8
	octave 3
	note G_, 2
	octave 4
	note F_, 2
	volume_envelope 10, 0
	note E_, 8
	volume_envelope 10, 6
	note E_, 8
	volume_envelope 11, 4
	sound_call Music_ChampionBattleRSE_Ch2_branch_1
	duty_cycle 3
	sound_call Music_ChampionBattleRSE_Ch1_branch_1
	duty_cycle 0
	octave 3
	note G#, 2
	octave 4
	note D#, 2
	note E_, 2
	note D#, 1
	note C#, 1
	note D#, 1
	octave 3
	note B_, 1
	note A_, 2
	note B_, 2
	note A_, 2
	note G#, 1
	note G#, 1
	octave 4
	note D#, 2
	note E_, 2
	note D#, 1
	note C#, 1
	note E_, 1
	note C#, 1
	note G#, 2
	note A_, 2
	note F#, 2
	octave 3
	note B_, 2
	octave 4
	note F#, 2
	note G_, 2
	note F#, 1
	note E_, 1
	note F#, 1
	note D_, 1
	note C_, 2
	note D_, 2
	note C_, 2
	octave 3
	note B_, 1
	note B_, 1
	octave 4
	note F#, 2
	note G_, 2
	note F#, 1
	note E_, 1
	note G_, 1
	note E_, 1
	note B_, 2
	octave 5
	note C_, 2
	note F_, 2
	volume_envelope 11, 7
	note E_, 2
	octave 4
	note E_, 2
	octave 3
	note E_, 2
	octave 5
	note D_, 2
	octave 4
	note D_, 2
	octave 3
	note D_, 2
	octave 4
	note G_, 2
	octave 3
	note G_, 2
	octave 2
	note G_, 2
	octave 5
	note C_, 2
	octave 4
	note C_, 2
	octave 3
	note C_, 2
	octave 4
	note A_, 2
	octave 3
	note A_, 2
	octave 2
	note A_, 2
	octave 4
	note B_, 2
	octave 3
	note B_, 2
	octave 2
	note B_, 2
	octave 5
	note C_, 2
	octave 4
	note C_, 2
	octave 3
	note C_, 2
	octave 5
	note D_, 2
	octave 4
	note D_, 2
	octave 3
	note D_, 2
	octave 5
	volume_envelope 11, 0
	note D#, 6
	volume_envelope 11, 5
	note D#, 10
	octave 3
	volume_envelope 11, 0
	note F_, 6
	volume_envelope 11, 5
	note F_, 10
	volume_envelope 11, 0
	note D_, 6
	volume_envelope 11, 5
	note D_, 10
	volume_envelope 11, 0
	note F_, 6
	volume_envelope 11, 5
	note F_, 10
	sound_jump Music_ChampionBattleRSE_Ch2_loop_main

Music_ChampionBattleRSE_Ch2_branch_1:
	octave 3
	note G_, 1
	note G_, 1
	note G_, 1
	note G#, 3
	note A#, 2
	note E_, 1
	note E_, 1
	note E_, 1
	note F_, 3
	note G#, 2
	note G_, 1
	note G_, 1
	note G_, 1
	note G#, 3
	note A#, 2
	octave 4
	note C_, 1
	note C_, 1
	note C_, 1
	note C#, 3
	note D#, 2
	sound_ret

Music_ChampionBattleRSE_Ch3:
	note_type 12, 1, 9
	vibrato 18, 1, 5
	octave 3
	note C_, 1
	octave 2
	note G_, 1
	note B_, 1
	note F#, 1
	note A#, 1
	note F_, 1
	note G#, 1
	note E_, 1
	note G_, 1
	note D#, 1
	note F#, 1
	note D_, 1
	note F_, 1
	note C#, 1
	note D#, 1
	note C#, 1
Music_ChampionBattleRSE_Ch3_loop_1:
	sound_call Music_ChampionBattleRSE_Ch3_branch_1
	note D#, 1
	note F_, 1
	note D#, 1
	note F_, 1
	octave 1
	note B_, 1
	sound_loop 3, Music_ChampionBattleRSE_Ch3_loop_1
	sound_call Music_ChampionBattleRSE_Ch3_branch_1
	note A#, 1
	note C_, 1
	note F#, 1
	note F_, 1
	note D#, 1
Music_ChampionBattleRSE_Ch3_loop_main:
Music_ChampionBattleRSE_Ch3_loop_2:
	note C_, 1
	note G_, 1
	sound_loop 6, Music_ChampionBattleRSE_Ch3_loop_2
	note C_, 1
	octave 3
	note C_, 1
	octave 2
	note G_, 1
	note E_, 1
Music_ChampionBattleRSE_Ch3_loop_3:
	note C#, 1
	note G#, 1
	sound_loop 6, Music_ChampionBattleRSE_Ch3_loop_3
	note C#, 1
	note C#, 1
	note G#, 1
	note F_, 1
Music_ChampionBattleRSE_Ch3_loop_4:
	note C_, 1
	note G_, 1
	sound_loop 5, Music_ChampionBattleRSE_Ch3_loop_4
	octave 3
	note C_, 1
	octave 2
	note G_, 1
	note E_, 1
	note G_, 1
	note E_, 1
	note G_, 1
	sound_call Music_ChampionBattleRSE_Ch3_branch_7
	sound_call Music_ChampionBattleRSE_Ch3_branch_6
	sound_call Music_ChampionBattleRSE_Ch3_branch_7
Music_ChampionBattleRSE_Ch3_loop_5:
	note D#, 1
	note A#, 1
	sound_loop 8, Music_ChampionBattleRSE_Ch3_loop_5
	sound_call Music_ChampionBattleRSE_Ch3_branch_2
	octave 3
	note C_, 1
	note F_, 1
	note G_, 1
	note F_, 1
	note G_, 1
	note F_, 1
	note C_, 1
	octave 2
	note G_, 1
	sound_call Music_ChampionBattleRSE_Ch3_branch_2
	octave 3
	note C_, 1
	note G_, 1
	octave 2
	note B_, 1
	octave 3
	note F#, 1
	octave 2
	note A#, 1
	octave 3
	note F_, 1
	octave 2
	note A_, 1
	octave 3
	note E_, 1
	sound_call Music_ChampionBattleRSE_Ch3_branch_3
	note G#, 3
	octave 2
	note C#, 2
	sound_call Music_ChampionBattleRSE_Ch3_branch_3
	octave 2
	note C#, 2
	note G#, 1
	note D_, 2
	sound_call Music_ChampionBattleRSE_Ch3_branch_4
	sound_call Music_ChampionBattleRSE_Ch3_branch_4
	sound_call Music_ChampionBattleRSE_Ch3_branch_5
	sound_call Music_ChampionBattleRSE_Ch3_branch_5
	octave 2
	note A_, 2
	note E_, 2
	octave 1
	note A_, 2
	octave 2
	note G_, 2
	note D_, 2
	octave 1
	note G_, 2
	octave 2
	note C_, 2
	note E_, 2
	note G_, 2
	note F_, 2
	note C_, 2
	octave 1
	note F_, 2
	note G_, 1
	octave 2
	note D_, 1
	octave 1
	note G_, 1
	octave 2
	note D_, 1
	octave 1
	note G_, 1
	octave 2
	note D_, 1
	octave 1
	note A_, 1
	octave 2
	note E_, 1
	octave 1
	note A_, 1
	octave 2
	note E_, 1
	octave 1
	note A_, 1
	octave 2
	note E_, 1
	octave 1
	note A#, 1
	octave 2
	note F_, 1
	octave 1
	note A#, 1
	octave 2
	note F_, 1
	octave 1
	note A#, 1
	octave 2
	note F_, 1
	note C_, 1
	note G_, 1
	note C_, 1
	note G_, 1
	note C_, 1
	note G_, 1
	sound_call Music_ChampionBattleRSE_Ch3_branch_6
	sound_call Music_ChampionBattleRSE_Ch3_branch_7
	sound_call Music_ChampionBattleRSE_Ch3_branch_6
	sound_call Music_ChampionBattleRSE_Ch3_branch_7
	sound_jump Music_ChampionBattleRSE_Ch3_loop_main
	sound_ret

Music_ChampionBattleRSE_Ch3_branch_1:
	octave 2
	note C_, 1
	note F#, 1
	note A#, 1
	note F#, 1
	note F_, 1
	note D#, 1
	octave 1
	note B_, 1
	octave 2
	note F#, 1
	note F_, 1
	note D#, 1
	note C_, 1
	sound_ret

Music_ChampionBattleRSE_Ch3_branch_2:
	note C_, 1
	note G_, 1
	octave 3
	note C_, 1
	octave 2
	note C_, 1
	note G_, 1
	octave 3
	note C_, 1
	octave 2
	note C_, 1
	note G_, 1
	sound_ret

Music_ChampionBattleRSE_Ch3_branch_3:
	octave 2
	note C_, 1
	note C_, 1
	note C_, 1
	note C#, 3
	note D#, 2
	octave 1
	note G_, 1
	note G_, 1
	note G_, 1
	note G#, 3
	octave 2
	note C#, 2
	note C_, 1
	note C_, 1
	note C_, 1
	note C#, 3
	note D#, 2
	octave 1
	note G_, 1
	note G_, 1
	note G_, 1
	sound_ret

Music_ChampionBattleRSE_Ch3_branch_4:
	octave 2
	note C#, 1
	note G#, 1
	note C#, 1
	note A_, 1
	note C#, 1
	octave 3
	note C#, 1
	octave 2
	note C#, 1
	note A_, 1
	note C#, 1
	note G#, 1
	note C#, 1
	note A_, 1
	note C#, 1
	octave 3
	note C#, 1
	octave 2
	note C#, 1
	octave 3
	note D_, 1
	sound_ret

Music_ChampionBattleRSE_Ch3_branch_5:
	octave 2
	note E_, 1
	note B_, 1
	note E_, 1
	octave 3
	note C_, 1
	octave 2
	note E_, 1
	octave 3
	note E_, 1
	octave 2
	note E_, 1
	octave 3
	note C_, 1
	octave 2
	note E_, 1
	note B_, 1
	note E_, 1
	octave 3
	note C_, 1
	octave 2
	note E_, 1
	octave 3
	note E_, 1
	octave 2
	note E_, 1
	octave 3
	note F_, 1
	sound_ret

Music_ChampionBattleRSE_Ch3_branch_6:
	note C_, 1
	note G_, 1
	note C_, 1
	note G_, 1
	note C_, 1
	note G_, 1
	note C_, 1
	note G_, 1
	note C_, 1
	note G_, 1
	note C_, 1
	note G_, 1
	note C_, 1
	note G_, 1
	note C_, 1
	note G_, 1
	sound_ret

Music_ChampionBattleRSE_Ch3_branch_7:
	note C#, 1
	note G#, 1
	note C#, 1
	note G#, 1
	note C#, 1
	note G#, 1
	note C#, 1
	note G#, 1
	note C#, 1
	note G#, 1
	note C#, 1
	note G#, 1
	note C#, 1
	note G#, 1
	note C#, 1
	note G#, 1
	sound_ret

Music_ChampionBattleRSE_Ch4:
	toggle_noise 3
	drum_speed 6
	drum_note 1, 6
	drum_note 1, 8
	drum_note 4, 4
	drum_note 1, 6
	drum_note 1, 4
	drum_note 4, 4
	sound_call Music_ChampionBattleRSE_Ch4_branch_1
	sound_call Music_ChampionBattleRSE_Ch4_branch_2
	sound_call Music_ChampionBattleRSE_Ch4_branch_1
	sound_call Music_ChampionBattleRSE_Ch4_branch_2
Music_ChampionBattleRSE_Ch4_loop_main:
Music_ChampionBattleRSE_Ch4_loop_1:
	sound_call Music_ChampionBattleRSE_Ch4_branch_3
	sound_loop 4, Music_ChampionBattleRSE_Ch4_loop_1
	drum_note 4, 2
	drum_note 4, 2
	drum_note 1, 2
	drum_note 4, 4
	drum_note 4, 2
	drum_note 1, 4
	drum_note 4, 2
	drum_note 4, 2
	drum_note 1, 2
	drum_note 4, 4
	drum_note 4, 2
	drum_note 1, 4
	drum_note 4, 2
	drum_note 4, 2
	drum_note 1, 2
	drum_note 4, 4
	drum_note 4, 2
	drum_note 1, 2
	drum_note 4, 2
	drum_note 4, 4
	drum_note 1, 4
	drum_note 4, 2
	drum_note 4, 2
	drum_note 1, 4
	sound_call Music_ChampionBattleRSE_Ch4_branch_3
	rest 16
	rest 16
	rest 16
	rest 16
	drum_note 4, 2
	drum_note 4, 2
	drum_note 1, 4
	drum_note 4, 2
	drum_note 1, 2
	drum_note 4, 2
	drum_note 1, 2
	drum_note 4, 2
	drum_note 4, 2
	drum_note 1, 2
	drum_note 4, 4
	drum_note 4, 2
	drum_note 1, 2
	drum_note 4, 1
	drum_note 4, 1
	drum_note 4, 2
	drum_note 4, 2
	drum_note 1, 2
	drum_note 4, 4
	drum_note 4, 2
	drum_note 1, 2
	drum_note 4, 1
	drum_note 4, 1
	drum_note 4, 2
	drum_note 4, 2
	drum_note 1, 2
	drum_note 4, 4
	drum_note 1, 2
	drum_note 4, 2
	drum_note 1, 2
	drum_note 4, 2
	drum_note 4, 2
	drum_note 1, 2
	drum_note 4, 4
	drum_note 1, 2
	drum_note 4, 2
	drum_note 1, 2
	drum_note 4, 4
	drum_note 1, 2
	drum_note 4, 4
	drum_note 4, 2
	drum_note 1, 2
	drum_note 4, 2
	drum_note 4, 2
	drum_note 4, 2
	drum_note 1, 2
	drum_note 4, 2
	drum_note 4, 2
	drum_note 1, 2
	drum_note 4, 2
	drum_note 1, 2
	drum_note 4, 2
	drum_note 4, 2
	drum_note 1, 2
	drum_note 4, 2
	drum_note 4, 2
	drum_note 1, 2
	drum_note 1, 2
	drum_note 1, 2
Music_ChampionBattleRSE_Ch4_loop_2:
	drum_note 4, 4
	drum_note 1, 4
	drum_note 4, 2
	drum_note 4, 2
	drum_note 1, 4
	drum_note 4, 4
	drum_note 1, 4
	drum_note 4, 2
	drum_note 4, 2
	drum_note 1, 2
	drum_note 1, 2
	sound_loop 4, Music_ChampionBattleRSE_Ch4_loop_2
	drum_note 4, 4
	drum_note 1, 4
	drum_note 1, 4
	drum_note 4, 4
	drum_note 1, 4
	drum_note 1, 4
	drum_note 4, 4
	drum_note 1, 4
	drum_note 1, 4
	drum_note 4, 4
	drum_note 1, 4
	drum_note 1, 2
	drum_note 1, 2
	drum_note 4, 4
	drum_note 1, 4
	drum_note 4, 4
	drum_note 1, 4
	drum_note 4, 4
	drum_note 1, 4
	drum_note 4, 4
	drum_note 1, 4
	drum_note 4, 4
	drum_note 1, 4
	drum_note 4, 4
	drum_note 1, 2
	drum_note 1, 2
Music_ChampionBattleRSE_Ch4_loop_3:
	sound_call Music_ChampionBattleRSE_Ch4_branch_3
	sound_loop 4, Music_ChampionBattleRSE_Ch4_loop_3
	sound_jump Music_ChampionBattleRSE_Ch4_loop_main

Music_ChampionBattleRSE_Ch4_branch_1:
	drum_note 4, 2
	drum_note 4, 2
	drum_note 1, 2
	drum_note 4, 2
	drum_note 4, 4
	drum_note 1, 2
	drum_note 4, 2
	drum_note 4, 4
	drum_note 1, 2
	drum_note 4, 2
	drum_note 4, 2
	drum_note 4, 2
	drum_note 1, 2
	drum_note 4, 2
	sound_ret

Music_ChampionBattleRSE_Ch4_branch_2:
	drum_note 4, 2
	drum_note 4, 2
	drum_note 1, 2
	drum_note 4, 4
	drum_note 4, 2
	drum_note 1, 2
	drum_note 4, 2
	drum_note 4, 4
	drum_note 1, 2
	drum_note 4, 2
	drum_note 4, 2
	drum_note 4, 2
	drum_note 1, 2
	drum_note 4, 2
	sound_ret

Music_ChampionBattleRSE_Ch4_branch_3:
	drum_note 4, 4
	drum_note 1, 4
	drum_note 4, 2
	drum_note 4, 2
	drum_note 1, 4
	drum_note 4, 4
	drum_note 1, 2
	drum_note 4, 4
	drum_note 4, 2
	drum_note 1, 4
	sound_ret
