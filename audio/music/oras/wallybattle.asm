; Pokémon OR/AS - Battle! Wally
; Demixed by Mmmmmm
; https://pastebin.com/7vneX9pj
; https://hax.iimarckus.org/topic/6777/4/

Music_WallyBattleORAS:
	channel_count 4
	channel 1, Music_WallyBattleORAS_Ch1
	channel 2, Music_WallyBattleORAS_Ch2
	channel 3, Music_WallyBattleORAS_Ch3
	channel 4, Music_WallyBattleORAS_Ch4

Music_WallyBattleORAS_Ch1:
	tempo 192
	volume 7, 7
	duty_cycle 3
	sound_call Music_WallyBattleORAS_Ch1_branch_1
	octave 2
	note A_, 5
	volume_envelope 8, 4
	note G_, 2
	note A_, 2
	volume_envelope 8, 0
	note B_, 4
	volume_envelope 8, 7
	note B_, 5
	octave 3
	volume_envelope 11, 1
	note A_, 1
	note B_, 1
	note B_, 1
	rest 1
	sound_call Music_WallyBattleORAS_Ch1_branch_1
	octave 2
	note A_, 5
	volume_envelope 8, 3
	octave 3
	note C_, 2
	note C_, 2
	volume_envelope 8, 0
	octave 2
	note B_, 4
	volume_envelope 8, 7
	note B_, 5
	octave 3
	volume_envelope 11, 1
	note A_, 1
	note B_, 1
	note B_, 1
	rest 1
	volume_envelope 8, 7
	note E_, 1
	note A_, 1
	note B_, 1
	volume_envelope 8, 0
	octave 4
	note C_, 2
	volume_envelope 8, 7
	note C_, 4
	note E_, 1
	note D_, 3
	volume_envelope 8, 5
	note D_, 2
	note E_, 2
	note F#, 2
	volume_envelope 8, 7
	note F#, 3
	note D_, 3
	octave 3
	note B_, 1
	volume_envelope 8, 0
	octave 4
	note G_, 2
	volume_envelope 8, 7
	note G_, 3
	note G_, 1
	note F#, 1
	note E_, 1
	note D_, 1
	volume_envelope 8, 0
	note C_, 10
	volume_envelope 8, 4
	note C_, 4
	note_type 8, 8, 3
	note C_, 1
	note D_, 1
	note C_, 1
	duty_cycle 0
	note_type 12, 12, 0
	octave 3
	note D#, 12
	volume_envelope 12, 5
	note D#, 2
	volume_envelope 9, 4
	pitch_sweep 6, -4
	note D#, 2
	pitch_sweep 0, 0
	rest 2
	duty_cycle 3
Music_WallyBattleORAS_Ch1_loop_1:
	volume_envelope 8, 7
	octave 4
	note C_, 1
	note C_, 1
	octave 3
	note B_, 1
	octave 4
	note C_, 1
	rest 1
	note C_, 3
	octave 3
	note B_, 2
	note A_, 2
	note A_, 2
	duty_cycle 0
	volume_envelope 12, 0
	note G_, 3
	note E_, 3
	volume_envelope 12, 3
	pitch_sweep 6, -4
	note E_, 2
	pitch_sweep 0, 0
	duty_cycle 3
	rest 10
	sound_loop 2, Music_WallyBattleORAS_Ch1_loop_1
	volume_envelope 8, 7
	note E_, 2
	octave 4
	note E_, 2
	note D_, 2
	note C_, 2
	octave 3
	note E_, 2
	note G_, 2
	note A_, 2
	octave 4
	note C_, 3
	octave 3
	note B_, 5
	octave 4
	note E_, 3
	note D_, 3
	note C_, 2
	volume_envelope 8, 0
	octave 3
	note B_, 10
	volume_envelope 8, 4
	note B_, 4
	note_type 8, 8, 3
	note G_, 1
	note A_, 1
	note G_, 1
	duty_cycle 0
	note_type 12, 13, 0
	note D#, 10
	volume_envelope 13, 5
	note D#, 1
	volume_envelope 10, 4
	pitch_sweep 6, -4
	note D#, 2
	pitch_sweep 0, 0
	duty_cycle 3
	sound_jump Music_WallyBattleORAS_Ch1

Music_WallyBattleORAS_Ch1_branch_1:
	note_type 12, 9, 7
	octave 2
	note D_, 1
	note G_, 1
	note A_, 1
	volume_envelope 9, 0
	note B_, 2
	volume_envelope 9, 7
	note B_, 4
	octave 3
	note C_, 1
	sound_ret

Music_WallyBattleORAS_Ch2:
	duty_cycle 0
	sound_call Music_WallyBattleORAS_Ch2_branch_1
	note F#, 5
	volume_envelope 12, 3
	note E_, 2
	note F#, 2
	volume_envelope 12, 0
	note G_, 4
	volume_envelope 12, 7
	note G_, 9
	sound_call Music_WallyBattleORAS_Ch2_branch_1
	note_type 6, 12, 7
	note F#, 9
	note A#, 1
	volume_envelope 12, 3
	note B_, 4
	note A_, 4
	note_type 12, 12, 0
	note G_, 4
	volume_envelope 12, 7
	note G_, 9
	octave 2
	note B_, 1
	octave 3
	note C_, 1
	note D_, 1
	volume_envelope 12, 0
	note E_, 2
	volume_envelope 12, 7
	note E_, 4
	note G_, 1
	note F#, 3
	volume_envelope 12, 5
	note F#, 2
	note G_, 2
	note A_, 2
	volume_envelope 12, 7
	note A_, 3
	note F#, 3
	note D_, 1
	volume_envelope 12, 0
	note B_, 2
	volume_envelope 12, 7
	note B_, 4
	note A_, 1
	note G_, 1
	note F#, 1
	volume_envelope 12, 0
	note E_, 10
	volume_envelope 12, 4
	note E_, 4
	note_type 8, 12, 3
	note E_, 1
	note F#, 1
	note E_, 1
	duty_cycle 3
	note_type 12, 8, 0
	octave 3
	note B_, 8
	volume_envelope 8, 7
	note B_, 8
	rest 2
	duty_cycle 0
Music_WallyBattleORAS_Ch2_loop_1:
	volume_envelope 12, 7
	note G_, 1
	note G_, 1
	note F#, 1
	note G_, 1
	rest 1
	note G_, 3
	note F#, 2
	note E_, 2
	note F#, 2
	duty_cycle 3
	volume_envelope 8, 7
	note B_, 3
	note G_, 5
	duty_cycle 0
	rest 10
	sound_loop 2, Music_WallyBattleORAS_Ch2_loop_1
	volume_envelope 13, 7
	octave 2
	note B_, 2
	octave 3
	note B_, 2
	note A_, 2
	note F#, 2
	octave 2
	note B_, 2
	octave 3
	note D#, 2
	note F#, 2
	note A_, 3
	note G_, 5
	note B_, 3
	note A_, 3
	note G_, 2
	volume_envelope 12, 0
	note F#, 10
	volume_envelope 12, 4
	note F#, 4
	note_type 8, 12, 3
	note E_, 1
	note F#, 1
	note E_, 1
	duty_cycle 3
	note_type 12, 8, 0
	note F#, 8
	volume_envelope 8, 7
	note F#, 5
	duty_cycle 0
	sound_jump Music_WallyBattleORAS_Ch2

Music_WallyBattleORAS_Ch2_branch_1:
	note_type 12, 11, 7
	octave 2
	note B_, 1
	octave 3
	note E_, 1
	note F#, 1
	volume_envelope 11, 0
	note G_, 2
	volume_envelope 11, 7
	note G_, 4
	note A_, 1
	sound_ret

Music_WallyBattleORAS_Ch3:
	note_type 6, 1, 9
	vibrato 18, 1, 5
	rest 6
Music_WallyBattleORAS_Ch3_loop_main:
	sound_call Music_WallyBattleORAS_Ch3_branch_1
	octave 1
	note E_, 1
	rest 1
	note E_, 2
	rest 2
	octave 2
	note E_, 1
	rest 1
	note E_, 4
	octave 1
	note E_, 1
	rest 1
	note E_, 2
	rest 2
	note E_, 1
	rest 1
	note E_, 4
	octave 2
	note G#, 1
	note A_, 3
	note G_, 4
	sound_call Music_WallyBattleORAS_Ch3_branch_1
	octave 1
	note E_, 1
	rest 1
	note E_, 2
	rest 2
	note E_, 1
	rest 1
	note E_, 2
	rest 2
	note E_, 1
	rest 1
	note E_, 2
	rest 4
	note A#, 1
	note B_, 3
	octave 2
	note E_, 4
	octave 1
	note E_, 4
	octave 2
	note C_, 7
	rest 1
	note C_, 6
	note D_, 10
	octave 1
	note D#, 4
	octave 2
	note D#, 4
	octave 1
	note B_, 1
	rest 1
	note B_, 6
	rest 4
	note B_, 2
	octave 2
	note E_, 8
	octave 1
	note B_, 2
	octave 2
	note D_, 2
	note E_, 2
	octave 1
	note E_, 4
	octave 2
	note C_, 1
	rest 1
	note C_, 2
	rest 2
	octave 1
	note E_, 6
	octave 2
	note C_, 6
	octave 1
	note E_, 2
	octave 2
	note C_, 2
	octave 1
	note E_, 6
	octave 2
	note C_, 4
	octave 2
	note B_, 1
	rest 1
	note B_, 2
	rest 2
	octave 1
	note B_, 1
	rest 1
	note B_, 2
	rest 2
	octave 2
	note B_, 1
	rest 1
	note B_, 2
	rest 2
	octave 1
	note B_, 1
	rest 1
	note B_, 2
	rest 2
	note D_, 1
	note D#, 3
	note B_, 4
Music_WallyBattleORAS_Ch3_loop_1:
	octave 2
	note C_, 1
	rest 1
	note C_, 1
	rest 1
	note C_, 1
	rest 1
	note C_, 1
	rest 1
	octave 1
	note B_, 1
	rest 1
	octave 2
	note C_, 2
	rest 2
	note D_, 5
	rest 1
	note D_, 3
	rest 1
	note D_, 3
	rest 1
	note D_, 3
	rest 1
	octave 1
	note E_, 1
	rest 1
	note E_, 2
	rest 2
	sound_call Music_WallyBattleORAS_Ch3_branch_2
	octave 1
	note E_, 2
	octave 2
	note E_, 2
	octave 1
	note E_, 2
	octave 2
	note E_, 2
	note D_, 6
	sound_loop 2, Music_WallyBattleORAS_Ch3_loop_1
	note C_, 4
	note G_, 2
	octave 3
	note C_, 2
	rest 2
	note C_, 4
	note D_, 2
	rest 2
	note D_, 1
	rest 1
	note D_, 4
	note D#, 2
	rest 2
	note D#, 2
	rest 2
	sound_call Music_WallyBattleORAS_Ch3_branch_2
	octave 1
	note E_, 1
	rest 1
	note E_, 2
	rest 4
	note E_, 4
	rest 2
	note E_, 2
	rest 2
	note E_, 2
	note B_, 3
	rest 1
	note B_, 3
	rest 1
	octave 2
	note B_, 4
	octave 1
	note B_, 1
	rest 1
	note B_, 2
	rest 2
	note B_, 1
	rest 1
	note B_, 4
	octave 2
	note B_, 4
	octave 1
	note B_, 4
	octave 1
	note B_, 1
	rest 1
	note B_, 2
	rest 2
	octave 2
	note B_, 1
	rest 1
	note B_, 4
	octave 1
	note B_, 1
	rest 1
	note B_, 2
	rest 2
	octave 2
	note B_, 1
	rest 1
	note B_, 2
	note F#, 2
	note B_, 2
	octave 1
	note B_, 6
	sound_jump Music_WallyBattleORAS_Ch3_loop_main

Music_WallyBattleORAS_Ch3_branch_1:
	octave 1
	note E_, 1
	rest 1
	note E_, 2
	rest 2
	octave 2
	note E_, 1
	rest 1
	note E_, 5
	rest 1
	octave 1
	note E_, 2
	rest 2
	note E_, 1
	rest 1
	note E_, 4
	octave 2
	note A#, 1
	note B_, 3
	octave 3
	note E_, 4
	sound_ret

Music_WallyBattleORAS_Ch3_branch_2:
	octave 1
	note E_, 1
	rest 1
	note E_, 2
	rest 2
	octave 2
	note E_, 1
	rest 1
	note E_, 2
	rest 2
	sound_ret

Music_WallyBattleORAS_Ch4:
	toggle_noise 4
	drum_speed 12
	rest 3
Music_WallyBattleORAS_Ch4_loop_main:
	sound_call Music_WallyBattleORAS_Ch4_branch_1
	sound_call Music_WallyBattleORAS_Ch4_branch_2
	sound_call Music_WallyBattleORAS_Ch4_branch_2
	sound_call Music_WallyBattleORAS_Ch4_branch_3
	sound_call Music_WallyBattleORAS_Ch4_branch_1
	sound_call Music_WallyBattleORAS_Ch4_branch_2
	sound_call Music_WallyBattleORAS_Ch4_branch_4
	drum_note 5, 1
	drum_note 2, 1
	drum_note 5, 1
	drum_note 2, 1
	sound_call Music_WallyBattleORAS_Ch4_branch_1
	sound_call Music_WallyBattleORAS_Ch4_branch_2
	sound_call Music_WallyBattleORAS_Ch4_branch_2
	drum_note 2, 1
	drum_note 4, 1
	drum_note 4, 1
	drum_note 2, 1
	drum_note 4, 1
	drum_note 4, 1
	drum_note 5, 1
	drum_note 2, 1
	sound_call Music_WallyBattleORAS_Ch4_branch_1
	sound_call Music_WallyBattleORAS_Ch4_branch_2
	sound_call Music_WallyBattleORAS_Ch4_branch_6
	drum_note 5, 1
	drum_note 2, 1
	drum_note 4, 1
	drum_note 2, 1
Music_WallyBattleORAS_Ch4_loop_1:
	sound_call Music_WallyBattleORAS_Ch4_branch_1
	sound_call Music_WallyBattleORAS_Ch4_branch_5
	sound_call Music_WallyBattleORAS_Ch4_branch_2
	drum_note 11, 1
	drum_note 3, 1
	drum_note 11, 1
	drum_note 11, 1
	drum_note 12, 1
	drum_note 12, 2
	drum_note 4, 1
	sound_loop 2, Music_WallyBattleORAS_Ch4_loop_1
	sound_call Music_WallyBattleORAS_Ch4_branch_1
	sound_call Music_WallyBattleORAS_Ch4_branch_5
	sound_call Music_WallyBattleORAS_Ch4_branch_2
	drum_note 5, 1
	drum_note 3, 1
	drum_note 4, 1
	drum_note 5, 1
	drum_note 3, 1
	drum_note 4, 1
	drum_note 5, 1
	drum_note 4, 1
	sound_call Music_WallyBattleORAS_Ch4_branch_1
	sound_call Music_WallyBattleORAS_Ch4_branch_5
	sound_call Music_WallyBattleORAS_Ch4_branch_6
	drum_note 5, 1
	drum_note 5, 1
	drum_note 4, 1
	drum_note 4, 1
	sound_jump Music_WallyBattleORAS_Ch4_loop_main
	sound_ret

Music_WallyBattleORAS_Ch4_branch_1:
	drum_note 12, 2
	drum_note 4, 1
	drum_note 4, 1
	drum_note 5, 1
	drum_note 2, 1
	drum_note 4, 1
	drum_note 4, 1
	sound_ret

Music_WallyBattleORAS_Ch4_branch_2:
	drum_note 3, 1
	drum_note 3, 1
	drum_note 4, 1
	drum_note 4, 1
	drum_note 5, 1
	drum_note 2, 1
	drum_note 4, 1
	drum_note 4, 1
	sound_ret

Music_WallyBattleORAS_Ch4_branch_3:
	drum_note 3, 1
	drum_note 3, 1
	drum_note 4, 1
	drum_note 4, 1
	drum_note 5, 1
	drum_note 4, 1
	drum_note 5, 1
	drum_note 2, 1
	sound_ret

Music_WallyBattleORAS_Ch4_branch_4:
	drum_note 5, 1
	drum_note 5, 1
	drum_note 2, 1
	drum_note 4, 1
	drum_note 4, 1
	drum_note 2, 1
	drum_note 5, 1
	drum_note 5, 1
	drum_note 2, 1
	drum_note 4, 1
	drum_note 4, 1
	drum_note 2, 1
	sound_ret

Music_WallyBattleORAS_Ch4_branch_5:
	drum_note 3, 1
	drum_note 11, 1
	drum_note 11, 1
	drum_note 3, 1
	drum_note 5, 1
	drum_note 2, 1
	drum_note 5, 1
	drum_note 4, 1
	sound_ret

Music_WallyBattleORAS_Ch4_branch_6:
	drum_note 12, 1
	drum_note 12, 1
	drum_note 2, 1
	drum_note 4, 1
	drum_note 4, 1
	drum_note 2, 1
	drum_note 12, 1
	drum_note 12, 1
	drum_note 2, 1
	drum_note 4, 1
	drum_note 4, 1
	drum_note 2, 1
	sound_ret
