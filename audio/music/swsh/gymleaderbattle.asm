; Pokémon Sw/Sh - Battle! Gym Leader
; Demixed by ShinkoNetCavy
; https://soundcloud.com/user-927422935-571023782/swsh-gym-leader-theme-8-bit-by-shinkonetcavy

Music_GymLeaderBattleSwSh:
	channel_count 4
	channel 1, Music_GymLeaderBattleSwSh_Ch1
	channel 2, Music_GymLeaderBattleSwSh_Ch2
	channel 3, Music_GymLeaderBattleSwSh_Ch3
	channel 4, Music_GymLeaderBattleSwSh_Ch4

Music_GymLeaderBattleSwSh_Ch1:
	tempo 137
	volume 7, 7
	duty_cycle 2
	note_type 12, 11, 2
	stereo_panning TRUE, TRUE
	sound_jump_if COND_FINAL_MON, Music_GymLeaderBattleSwSh_Ch1_EnterLastPokemonPhase
	octave 3
	sound_call Music_GymLeaderBattleSwSh_Ch1_ditty1
	sound_call Music_GymLeaderBattleSwSh_Ch1_ditty1
	rest 16
	sound_call Music_GymLeaderBattleSwSh_Ch1_ditty2
	rest 1
	duty_cycle 2
	volume_envelope 11, 2
	sound_call Music_GymLeaderBattleSwSh_Ch1_ditty2
	rest 1

Music_GymLeaderBattleSwSh_Ch1_NeutralPhase_Loop:
	sound_jump_if COND_ADVANTAGE, Music_GymLeaderBattleSwSh_Ch1_AdvantagePhase_Loop_1
	sound_jump_if COND_DISADVANTAGE, Music_GymLeaderBattleSwSh_Ch1_DisadvantagePhase_Loop_1
Music_GymLeaderBattleSwSh_Ch1_NeutralPhase_Loop_1:
	stereo_panning TRUE, TRUE
	octave 3
	duty_cycle 2
	volume_envelope 11, 2
	rest 2
	sound_call Music_GymLeaderBattleSwSh_Ch1_ditty3
	sound_jump_if COND_ADVANTAGE, Music_GymLeaderBattleSwSh_Ch1_AdvantagePhase_Loop_2
	sound_jump_if COND_DISADVANTAGE, Music_GymLeaderBattleSwSh_Ch1_DisadvantagePhase_Loop_2
Music_GymLeaderBattleSwSh_Ch1_NeutralPhase_Loop_2:
	stereo_panning TRUE, TRUE
	octave 3
	duty_cycle 2
	volume_envelope 11, 2
	rest 2
	sound_call Music_GymLeaderBattleSwSh_Ch1_ditty3
	sound_jump_if COND_ADVANTAGE, Music_GymLeaderBattleSwSh_Ch1_AdvantagePhase_Loop_3
	sound_jump_if COND_DISADVANTAGE, Music_GymLeaderBattleSwSh_Ch1_DisadvantagePhase_Loop_3
Music_GymLeaderBattleSwSh_Ch1_NeutralPhase_Loop_3:
	stereo_panning TRUE, TRUE
	octave 3
	duty_cycle 2
	volume_envelope 11, 2
	rest 2
	sound_call Music_GymLeaderBattleSwSh_Ch2_ditty4
	sound_jump_if COND_ADVANTAGE, Music_GymLeaderBattleSwSh_Ch1_AdvantagePhase_Loop_4
	sound_jump_if COND_DISADVANTAGE, Music_GymLeaderBattleSwSh_Ch1_DisadvantagePhase_Loop_4
Music_GymLeaderBattleSwSh_Ch1_NeutralPhase_Loop_4:
	stereo_panning TRUE, TRUE
	octave 3
	duty_cycle 2
	volume_envelope 11, 2
	rest 2
	sound_call Music_GymLeaderBattleSwSh_Ch2_ditty3
	sound_jump Music_GymLeaderBattleSwSh_Ch1_NeutralPhase_Loop

Music_GymLeaderBattleSwSh_Ch1_AdvantagePhase_Loop:
	sound_jump_if COND_DEFAULT, Music_GymLeaderBattleSwSh_Ch1_NeutralPhase_Loop_1
	sound_jump_if COND_DISADVANTAGE, Music_GymLeaderBattleSwSh_Ch1_DisadvantagePhase_Loop_1
Music_GymLeaderBattleSwSh_Ch1_AdvantagePhase_Loop_1:
	duty_cycle 1
	volume_envelope 12, 7
	octave 3
	rest 2
	sound_call Music_GymLeaderBattleSwSh_Ch1_ditty6
	rest 1
	sound_jump_if COND_DEFAULT, Music_GymLeaderBattleSwSh_Ch1_NeutralPhase_Loop_2
	sound_jump_if COND_DISADVANTAGE, Music_GymLeaderBattleSwSh_Ch1_DisadvantagePhase_Loop_2
Music_GymLeaderBattleSwSh_Ch1_AdvantagePhase_Loop_2:
	duty_cycle 1
	volume_envelope 12, 7
	octave 3
	rest 2
	sound_call Music_GymLeaderBattleSwSh_Ch1_ditty6
	rest 1
	sound_jump_if COND_DEFAULT, Music_GymLeaderBattleSwSh_Ch1_NeutralPhase_Loop_3
	sound_jump_if COND_DISADVANTAGE, Music_GymLeaderBattleSwSh_Ch1_DisadvantagePhase_Loop_3
Music_GymLeaderBattleSwSh_Ch1_AdvantagePhase_Loop_3:
	duty_cycle 1
	volume_envelope 12, 7
	sound_call Music_GymLeaderBattleSwSh_Ch1_ditty7
	sound_jump_if COND_DEFAULT, Music_GymLeaderBattleSwSh_Ch1_NeutralPhase_Loop_4
	sound_jump_if COND_DISADVANTAGE, Music_GymLeaderBattleSwSh_Ch1_DisadvantagePhase_Loop_4
Music_GymLeaderBattleSwSh_Ch1_AdvantagePhase_Loop_4:
	duty_cycle 1
	volume_envelope 12, 7
	sound_call Music_GymLeaderBattleSwSh_Ch1_ditty7
	sound_jump Music_GymLeaderBattleSwSh_Ch1_AdvantagePhase_Loop

Music_GymLeaderBattleSwSh_Ch1_DisadvantagePhase_Loop:
	sound_jump_if COND_DEFAULT, Music_GymLeaderBattleSwSh_Ch1_NeutralPhase_Loop_1
	sound_jump_if COND_ADVANTAGE, Music_GymLeaderBattleSwSh_Ch1_AdvantagePhase_Loop_1
Music_GymLeaderBattleSwSh_Ch1_DisadvantagePhase_Loop_1:
	stereo_panning TRUE, TRUE
	duty_cycle 2
	volume_envelope 7, 2
	octave 3
	rest 2
	sound_call Music_GymLeaderBattleSwSh_Ch1_ditty11
	rest 3
	sound_call Music_GymLeaderBattleSwSh_Ch1_ditty11
	rest 1
	sound_jump_if COND_DEFAULT, Music_GymLeaderBattleSwSh_Ch1_NeutralPhase_Loop_2
	sound_jump_if COND_ADVANTAGE, Music_GymLeaderBattleSwSh_Ch1_AdvantagePhase_Loop_2
Music_GymLeaderBattleSwSh_Ch1_DisadvantagePhase_Loop_2:
	stereo_panning TRUE, TRUE
	duty_cycle 2
	volume_envelope 7, 2
	octave 3
	rest 2
	sound_call Music_GymLeaderBattleSwSh_Ch1_ditty11
	sound_call Music_GymLeaderBattleSwSh_Ch1_ditty12
	sound_jump_if COND_DEFAULT, Music_GymLeaderBattleSwSh_Ch1_NeutralPhase_Loop_3
	sound_jump_if COND_ADVANTAGE, Music_GymLeaderBattleSwSh_Ch1_AdvantagePhase_Loop_3
Music_GymLeaderBattleSwSh_Ch1_DisadvantagePhase_Loop_3:
	stereo_panning TRUE, TRUE
	duty_cycle 2
	volume_envelope 7, 2
	octave 3
	rest 2
	sound_call Music_GymLeaderBattleSwSh_Ch1_ditty11
	rest 3
	sound_call Music_GymLeaderBattleSwSh_Ch1_ditty11
	rest 1
	sound_jump_if COND_DEFAULT, Music_GymLeaderBattleSwSh_Ch1_NeutralPhase_Loop_4
	sound_jump_if COND_ADVANTAGE, Music_GymLeaderBattleSwSh_Ch1_AdvantagePhase_Loop_4
Music_GymLeaderBattleSwSh_Ch1_DisadvantagePhase_Loop_4:
	stereo_panning TRUE, TRUE
	duty_cycle 2
	volume_envelope 7, 2
	octave 3
	rest 2
	sound_call Music_GymLeaderBattleSwSh_Ch1_ditty11
	sound_call Music_GymLeaderBattleSwSh_Ch1_ditty12
	sound_jump Music_GymLeaderBattleSwSh_Ch1_DisadvantagePhase_Loop

Music_GymLeaderBattleSwSh_Ch2:
	duty_cycle 2
	note_type 12, 11, 2
	stereo_panning TRUE, TRUE
	sound_jump_if COND_FINAL_MON, Music_GymLeaderBattleSwSh_Ch2_EnterLastPokemonPhase
	sound_call Music_GymLeaderBattleSwSh_Ch2_ditty1
	sound_call Music_GymLeaderBattleSwSh_Ch2_ditty1
	rest 16
	duty_cycle 1
	volume_envelope 12, 7
	octave 3
	sound_call Music_GymLeaderBattleSwSh_Ch2_ditty2
	sound_call Music_GymLeaderBattleSwSh_Ch2_ditty2

Music_GymLeaderBattleSwSh_Ch2_NeutralPhase_Loop:
	sound_jump_if COND_ADVANTAGE, Music_GymLeaderBattleSwSh_Ch2_AdvantagePhase_Loop_1
	sound_jump_if COND_DISADVANTAGE, Music_GymLeaderBattleSwSh_Ch2_DisadvantagePhase_Loop_1
Music_GymLeaderBattleSwSh_Ch2_NeutralPhase_Loop_1:
	stereo_panning TRUE, TRUE
	duty_cycle 2
	volume_envelope 11, 2
	octave 3
	rest 2
	sound_call Music_GymLeaderBattleSwSh_Ch2_ditty4
	sound_jump_if COND_ADVANTAGE, Music_GymLeaderBattleSwSh_Ch2_AdvantagePhase_Loop_2
	sound_jump_if COND_DISADVANTAGE, Music_GymLeaderBattleSwSh_Ch2_DisadvantagePhase_Loop_2
Music_GymLeaderBattleSwSh_Ch2_NeutralPhase_Loop_2:
	stereo_panning TRUE, TRUE
	duty_cycle 2
	volume_envelope 11, 2
	octave 3
	rest 2
	sound_call Music_GymLeaderBattleSwSh_Ch2_ditty3
	sound_jump_if COND_ADVANTAGE, Music_GymLeaderBattleSwSh_Ch2_AdvantagePhase_Loop_3
	sound_jump_if COND_DISADVANTAGE, Music_GymLeaderBattleSwSh_Ch2_DisadvantagePhase_Loop_3
Music_GymLeaderBattleSwSh_Ch2_NeutralPhase_Loop_3:
	stereo_panning TRUE, FALSE
	duty_cycle 0
	volume_envelope 12, 7
	vibrato 9, 1, 2
	octave 4
	sound_call Music_GymLeaderBattleSwSh_Ch2_ditty5
	rest 9
	sound_jump_if COND_ADVANTAGE, Music_GymLeaderBattleSwSh_Ch2_AdvantagePhase_Loop_4
	sound_jump_if COND_DISADVANTAGE, Music_GymLeaderBattleSwSh_Ch2_DisadvantagePhase_Loop_4
Music_GymLeaderBattleSwSh_Ch2_NeutralPhase_Loop_4:
	stereo_panning TRUE, FALSE
	duty_cycle 0
	volume_envelope 12, 7
	vibrato 9, 1, 2
	octave 4
	sound_call Music_GymLeaderBattleSwSh_Ch2_ditty5
	rest 9
	sound_jump Music_GymLeaderBattleSwSh_Ch2_NeutralPhase_Loop

Music_GymLeaderBattleSwSh_Ch2_AdvantagePhase_Loop:
	sound_jump_if COND_DEFAULT, Music_GymLeaderBattleSwSh_Ch2_NeutralPhase_Loop_1
	sound_jump_if COND_DISADVANTAGE, Music_GymLeaderBattleSwSh_Ch2_DisadvantagePhase_Loop_1
Music_GymLeaderBattleSwSh_Ch2_AdvantagePhase_Loop_1:
	rest 2
	duty_cycle 1
	volume_envelope 12, 7
	octave 3
	sound_call Music_GymLeaderBattleSwSh_Ch2_ditty7
	rest 1
	sound_jump_if COND_DEFAULT, Music_GymLeaderBattleSwSh_Ch2_NeutralPhase_Loop_2
	sound_jump_if COND_DISADVANTAGE, Music_GymLeaderBattleSwSh_Ch2_DisadvantagePhase_Loop_2
Music_GymLeaderBattleSwSh_Ch2_AdvantagePhase_Loop_2:
	rest 2
	duty_cycle 1
	volume_envelope 12, 7
	octave 3
	sound_call Music_GymLeaderBattleSwSh_Ch2_ditty7
	rest 1
	sound_jump_if COND_DEFAULT, Music_GymLeaderBattleSwSh_Ch2_NeutralPhase_Loop_3
	sound_jump_if COND_DISADVANTAGE, Music_GymLeaderBattleSwSh_Ch2_DisadvantagePhase_Loop_3
Music_GymLeaderBattleSwSh_Ch2_AdvantagePhase_Loop_3:
	duty_cycle 2
	volume_envelope 11, 2
	sound_call Music_GymLeaderBattleSwSh_Ch2_ditty8
	sound_jump_if COND_DEFAULT, Music_GymLeaderBattleSwSh_Ch2_NeutralPhase_Loop_4
	sound_jump_if COND_DISADVANTAGE, Music_GymLeaderBattleSwSh_Ch2_DisadvantagePhase_Loop_4
Music_GymLeaderBattleSwSh_Ch2_AdvantagePhase_Loop_4:
	duty_cycle 2
	volume_envelope 11, 2
	sound_call Music_GymLeaderBattleSwSh_Ch2_ditty8
	sound_jump Music_GymLeaderBattleSwSh_Ch2_AdvantagePhase_Loop

Music_GymLeaderBattleSwSh_Ch2_DisadvantagePhase_Loop:
	sound_jump_if COND_DEFAULT, Music_GymLeaderBattleSwSh_Ch2_NeutralPhase_Loop_1
	sound_jump_if COND_ADVANTAGE, Music_GymLeaderBattleSwSh_Ch2_AdvantagePhase_Loop_1
Music_GymLeaderBattleSwSh_Ch2_DisadvantagePhase_Loop_1:
	stereo_panning TRUE, FALSE
	duty_cycle 2
	volume_envelope 7, 2
	octave 3
	rest 2
	sound_call Music_GymLeaderBattleSwSh_Ch2_ditty11
	rest 3
	sound_call Music_GymLeaderBattleSwSh_Ch2_ditty11
	rest 1
	sound_jump_if COND_DEFAULT, Music_GymLeaderBattleSwSh_Ch2_NeutralPhase_Loop_2
	sound_jump_if COND_ADVANTAGE, Music_GymLeaderBattleSwSh_Ch2_AdvantagePhase_Loop_2
Music_GymLeaderBattleSwSh_Ch2_DisadvantagePhase_Loop_2:
	stereo_panning TRUE, FALSE
	duty_cycle 2
	volume_envelope 7, 2
	octave 3
	rest 2
	sound_call Music_GymLeaderBattleSwSh_Ch2_ditty11
	sound_call Music_GymLeaderBattleSwSh_Ch2_ditty12
	sound_jump_if COND_DEFAULT, Music_GymLeaderBattleSwSh_Ch2_NeutralPhase_Loop_3
	sound_jump_if COND_ADVANTAGE, Music_GymLeaderBattleSwSh_Ch2_AdvantagePhase_Loop_3
Music_GymLeaderBattleSwSh_Ch2_DisadvantagePhase_Loop_3:
	stereo_panning TRUE, FALSE
	duty_cycle 2
	volume_envelope 7, 2
	octave 3
	rest 2
	sound_call Music_GymLeaderBattleSwSh_Ch2_ditty11
	rest 3
	sound_call Music_GymLeaderBattleSwSh_Ch2_ditty11
	rest 1
	sound_jump_if COND_DEFAULT, Music_GymLeaderBattleSwSh_Ch2_NeutralPhase_Loop_4
	sound_jump_if COND_ADVANTAGE, Music_GymLeaderBattleSwSh_Ch2_AdvantagePhase_Loop_4
Music_GymLeaderBattleSwSh_Ch2_DisadvantagePhase_Loop_4:
	stereo_panning TRUE, FALSE
	duty_cycle 2
	volume_envelope 7, 2
	octave 3
	rest 2
	sound_call Music_GymLeaderBattleSwSh_Ch2_ditty11
	sound_call Music_GymLeaderBattleSwSh_Ch2_ditty12
	sound_jump Music_GymLeaderBattleSwSh_Ch2_DisadvantagePhase_Loop

Music_GymLeaderBattleSwSh_Ch3:
	note_type 12, 1, 1
	stereo_panning TRUE, TRUE
	sound_jump_if COND_FINAL_MON, Music_GymLeaderBattleSwSh_Ch3_EnterLastPokemonPhase
	sound_call Music_GymLeaderBattleSwSh_Ch3_ditty1
	sound_call Music_GymLeaderBattleSwSh_Ch3_ditty1
	octave 1
	note G_, 8
	rest 4
	octave 3
	pitch_slide 1, 3, C_
	note G_, 4
	octave 2
	sound_call Music_GymLeaderBattleSwSh_Ch3_ditty2
	sound_call Music_GymLeaderBattleSwSh_Ch3_ditty2

Music_GymLeaderBattleSwSh_Ch3_NeutralPhase_Loop:
	sound_jump_if COND_ADVANTAGE, Music_GymLeaderBattleSwSh_Ch3_AdvantagePhase_Loop_1
	sound_jump_if COND_DISADVANTAGE, Music_GymLeaderBattleSwSh_Ch3_DisadvantagePhase_Loop_1
Music_GymLeaderBattleSwSh_Ch3_NeutralPhase_Loop_1:
	sound_call Music_GymLeaderBattleSwSh_Ch3_ditty3
	sound_call Music_GymLeaderBattleSwSh_Ch3_ditty3
	sound_jump_if COND_ADVANTAGE, Music_GymLeaderBattleSwSh_Ch3_AdvantagePhase_Loop_2
	sound_jump_if COND_DISADVANTAGE, Music_GymLeaderBattleSwSh_Ch3_DisadvantagePhase_Loop_2
Music_GymLeaderBattleSwSh_Ch3_NeutralPhase_Loop_2:
	sound_call Music_GymLeaderBattleSwSh_Ch3_ditty3
	sound_call Music_GymLeaderBattleSwSh_Ch3_ditty3
	sound_jump_if COND_ADVANTAGE, Music_GymLeaderBattleSwSh_Ch3_AdvantagePhase_Loop_3
	sound_jump_if COND_DISADVANTAGE, Music_GymLeaderBattleSwSh_Ch3_DisadvantagePhase_Loop_3
Music_GymLeaderBattleSwSh_Ch3_NeutralPhase_Loop_3:
	sound_call Music_GymLeaderBattleSwSh_Ch3_ditty3
	sound_call Music_GymLeaderBattleSwSh_Ch3_ditty3
	sound_jump_if COND_ADVANTAGE, Music_GymLeaderBattleSwSh_Ch3_AdvantagePhase_Loop_4
	sound_jump_if COND_DISADVANTAGE, Music_GymLeaderBattleSwSh_Ch3_DisadvantagePhase_Loop_4
Music_GymLeaderBattleSwSh_Ch3_NeutralPhase_Loop_4:
	sound_call Music_GymLeaderBattleSwSh_Ch3_ditty3
	sound_call Music_GymLeaderBattleSwSh_Ch3_ditty3
	sound_jump Music_GymLeaderBattleSwSh_Ch3_NeutralPhase_Loop

Music_GymLeaderBattleSwSh_Ch3_AdvantagePhase_Loop:
	sound_jump_if COND_DEFAULT, Music_GymLeaderBattleSwSh_Ch3_NeutralPhase_Loop_1
	sound_jump_if COND_DISADVANTAGE, Music_GymLeaderBattleSwSh_Ch3_DisadvantagePhase_Loop_1
Music_GymLeaderBattleSwSh_Ch3_AdvantagePhase_Loop_1:
	sound_call Music_GymLeaderBattleSwSh_Ch3_ditty5
	sound_jump_if COND_DEFAULT, Music_GymLeaderBattleSwSh_Ch3_NeutralPhase_Loop_2
	sound_jump_if COND_DISADVANTAGE, Music_GymLeaderBattleSwSh_Ch3_DisadvantagePhase_Loop_2
Music_GymLeaderBattleSwSh_Ch3_AdvantagePhase_Loop_2:
	sound_call Music_GymLeaderBattleSwSh_Ch3_ditty5
	sound_jump_if COND_DEFAULT, Music_GymLeaderBattleSwSh_Ch3_NeutralPhase_Loop_3
	sound_jump_if COND_DISADVANTAGE, Music_GymLeaderBattleSwSh_Ch3_DisadvantagePhase_Loop_3
Music_GymLeaderBattleSwSh_Ch3_AdvantagePhase_Loop_3:
	sound_call Music_GymLeaderBattleSwSh_Ch3_ditty5
	sound_jump_if COND_DEFAULT, Music_GymLeaderBattleSwSh_Ch3_NeutralPhase_Loop_4
	sound_jump_if COND_DISADVANTAGE, Music_GymLeaderBattleSwSh_Ch3_DisadvantagePhase_Loop_4
Music_GymLeaderBattleSwSh_Ch3_AdvantagePhase_Loop_4:
	sound_call Music_GymLeaderBattleSwSh_Ch3_ditty5
	sound_jump Music_GymLeaderBattleSwSh_Ch3_AdvantagePhase_Loop

Music_GymLeaderBattleSwSh_Ch3_DisadvantagePhase_Loop:
	sound_jump_if COND_DEFAULT, Music_GymLeaderBattleSwSh_Ch3_NeutralPhase_Loop_1
	sound_jump_if COND_ADVANTAGE, Music_GymLeaderBattleSwSh_Ch3_AdvantagePhase_Loop_1
Music_GymLeaderBattleSwSh_Ch3_DisadvantagePhase_Loop_1:
	volume_envelope 2, 3
	sound_call Music_GymLeaderBattleSwSh_Ch3_ditty8
	sound_call Music_GymLeaderBattleSwSh_Ch3_ditty9
	sound_call Music_GymLeaderBattleSwSh_Ch3_ditty8
	sound_call Music_GymLeaderBattleSwSh_Ch3_ditty10
	sound_call Music_GymLeaderBattleSwSh_Ch3_ditty8
	sound_call Music_GymLeaderBattleSwSh_Ch3_ditty9
	sound_call Music_GymLeaderBattleSwSh_Ch3_ditty8
	sound_call Music_GymLeaderBattleSwSh_Ch3_ditty10
	sound_jump_if COND_DEFAULT, Music_GymLeaderBattleSwSh_Ch3_NeutralPhase_Loop_2
	sound_jump_if COND_ADVANTAGE, Music_GymLeaderBattleSwSh_Ch3_AdvantagePhase_Loop_2
Music_GymLeaderBattleSwSh_Ch3_DisadvantagePhase_Loop_2:
	volume_envelope 2, 3
	sound_call Music_GymLeaderBattleSwSh_Ch3_ditty8
	sound_call Music_GymLeaderBattleSwSh_Ch3_ditty9
	sound_call Music_GymLeaderBattleSwSh_Ch3_ditty8
	sound_call Music_GymLeaderBattleSwSh_Ch3_ditty10
	sound_call Music_GymLeaderBattleSwSh_Ch3_ditty8
	sound_call Music_GymLeaderBattleSwSh_Ch3_ditty9
	sound_call Music_GymLeaderBattleSwSh_Ch3_ditty8
	sound_call Music_GymLeaderBattleSwSh_Ch3_ditty10
	sound_jump_if COND_DEFAULT, Music_GymLeaderBattleSwSh_Ch3_NeutralPhase_Loop_3
	sound_jump_if COND_ADVANTAGE, Music_GymLeaderBattleSwSh_Ch3_AdvantagePhase_Loop_3
Music_GymLeaderBattleSwSh_Ch3_DisadvantagePhase_Loop_3:
	volume_envelope 2, 3
	sound_call Music_GymLeaderBattleSwSh_Ch3_ditty8
	sound_call Music_GymLeaderBattleSwSh_Ch3_ditty9
	sound_call Music_GymLeaderBattleSwSh_Ch3_ditty8
	sound_call Music_GymLeaderBattleSwSh_Ch3_ditty10
	sound_call Music_GymLeaderBattleSwSh_Ch3_ditty8
	sound_call Music_GymLeaderBattleSwSh_Ch3_ditty9
	sound_call Music_GymLeaderBattleSwSh_Ch3_ditty8
	sound_call Music_GymLeaderBattleSwSh_Ch3_ditty10
	sound_jump_if COND_DEFAULT, Music_GymLeaderBattleSwSh_Ch3_NeutralPhase_Loop_4
	sound_jump_if COND_ADVANTAGE, Music_GymLeaderBattleSwSh_Ch3_AdvantagePhase_Loop_4
Music_GymLeaderBattleSwSh_Ch3_DisadvantagePhase_Loop_4:
	volume_envelope 2, 3
	sound_call Music_GymLeaderBattleSwSh_Ch3_ditty8
	sound_call Music_GymLeaderBattleSwSh_Ch3_ditty9
	sound_call Music_GymLeaderBattleSwSh_Ch3_ditty8
	sound_call Music_GymLeaderBattleSwSh_Ch3_ditty10
	sound_call Music_GymLeaderBattleSwSh_Ch3_ditty8
	sound_call Music_GymLeaderBattleSwSh_Ch3_ditty9
	sound_call Music_GymLeaderBattleSwSh_Ch3_ditty8
	sound_call Music_GymLeaderBattleSwSh_Ch3_ditty10
	sound_jump Music_GymLeaderBattleSwSh_Ch3_DisadvantagePhase_Loop

Music_GymLeaderBattleSwSh_Ch4:
	drum_speed 12
	toggle_noise 4
	stereo_panning TRUE, TRUE
	sound_jump_if COND_FINAL_MON, Music_GymLeaderBattleSwSh_Ch4_EnterLastPokemonPhase
	sound_call Music_GymLeaderBattleSwSh_Ch4_ditty1
	sound_call Music_GymLeaderBattleSwSh_Ch4_ditty1
	drum_note 2, 1
	drum_note 2, 1
	drum_note 2, 1
	drum_note 2, 1
	drum_note 2, 1
	drum_note 2, 11
	sound_call Music_GymLeaderBattleSwSh_Ch4_ditty2
	sound_call Music_GymLeaderBattleSwSh_Ch4_ditty2

Music_GymLeaderBattleSwSh_Ch4_NeutralPhase_Loop:
	sound_jump_if COND_ADVANTAGE, Music_GymLeaderBattleSwSh_Ch4_AdvantagePhase_Loop_1
	sound_jump_if COND_DISADVANTAGE, Music_GymLeaderBattleSwSh_Ch4_DisadvantagePhase_Loop_1
Music_GymLeaderBattleSwSh_Ch4_NeutralPhase_Loop_1:
	sound_call Music_GymLeaderBattleSwSh_Ch4_ditty3
	sound_jump_if COND_ADVANTAGE, Music_GymLeaderBattleSwSh_Ch4_AdvantagePhase_Loop_2
	sound_jump_if COND_DISADVANTAGE, Music_GymLeaderBattleSwSh_Ch4_DisadvantagePhase_Loop_2
Music_GymLeaderBattleSwSh_Ch4_NeutralPhase_Loop_2:
	sound_call Music_GymLeaderBattleSwSh_Ch4_ditty3
	sound_jump_if COND_ADVANTAGE, Music_GymLeaderBattleSwSh_Ch4_AdvantagePhase_Loop_3
	sound_jump_if COND_DISADVANTAGE, Music_GymLeaderBattleSwSh_Ch4_DisadvantagePhase_Loop_3
Music_GymLeaderBattleSwSh_Ch4_NeutralPhase_Loop_3:
	sound_call Music_GymLeaderBattleSwSh_Ch4_ditty4
	sound_jump_if COND_ADVANTAGE, Music_GymLeaderBattleSwSh_Ch4_AdvantagePhase_Loop_4
	sound_jump_if COND_DISADVANTAGE, Music_GymLeaderBattleSwSh_Ch4_DisadvantagePhase_Loop_4
Music_GymLeaderBattleSwSh_Ch4_NeutralPhase_Loop_4:
	sound_call Music_GymLeaderBattleSwSh_Ch4_ditty4
	sound_jump Music_GymLeaderBattleSwSh_Ch4_NeutralPhase_Loop

Music_GymLeaderBattleSwSh_Ch4_AdvantagePhase_Loop:
	sound_jump_if COND_DEFAULT, Music_GymLeaderBattleSwSh_Ch4_NeutralPhase_Loop_1
	sound_jump_if COND_DISADVANTAGE, Music_GymLeaderBattleSwSh_Ch4_DisadvantagePhase_Loop_1
Music_GymLeaderBattleSwSh_Ch4_AdvantagePhase_Loop_1:
	sound_call Music_GymLeaderBattleSwSh_Ch4_ditty3
	sound_jump_if COND_DEFAULT, Music_GymLeaderBattleSwSh_Ch4_NeutralPhase_Loop_2
	sound_jump_if COND_DISADVANTAGE, Music_GymLeaderBattleSwSh_Ch4_DisadvantagePhase_Loop_2
Music_GymLeaderBattleSwSh_Ch4_AdvantagePhase_Loop_2:
	sound_call Music_GymLeaderBattleSwSh_Ch4_ditty3
	sound_jump_if COND_DEFAULT, Music_GymLeaderBattleSwSh_Ch4_NeutralPhase_Loop_3
	sound_jump_if COND_DISADVANTAGE, Music_GymLeaderBattleSwSh_Ch4_DisadvantagePhase_Loop_3
Music_GymLeaderBattleSwSh_Ch4_AdvantagePhase_Loop_3:
	sound_call Music_GymLeaderBattleSwSh_Ch4_ditty6
	sound_jump_if COND_DEFAULT, Music_GymLeaderBattleSwSh_Ch4_NeutralPhase_Loop_4
	sound_jump_if COND_DISADVANTAGE, Music_GymLeaderBattleSwSh_Ch4_DisadvantagePhase_Loop_4
Music_GymLeaderBattleSwSh_Ch4_AdvantagePhase_Loop_4:
	sound_call Music_GymLeaderBattleSwSh_Ch4_ditty6
	sound_jump Music_GymLeaderBattleSwSh_Ch4_AdvantagePhase_Loop

Music_GymLeaderBattleSwSh_Ch4_DisadvantagePhase_Loop:
	sound_jump_if COND_DEFAULT, Music_GymLeaderBattleSwSh_Ch4_NeutralPhase_Loop_1
	sound_jump_if COND_ADVANTAGE, Music_GymLeaderBattleSwSh_Ch4_AdvantagePhase_Loop_1
Music_GymLeaderBattleSwSh_Ch4_DisadvantagePhase_Loop_1:
	sound_call Music_GymLeaderBattleSwSh_Ch4_ditty8
	sound_call Music_GymLeaderBattleSwSh_Ch4_ditty8
	sound_call Music_GymLeaderBattleSwSh_Ch4_ditty8
	sound_call Music_GymLeaderBattleSwSh_Ch4_ditty8
	sound_jump_if COND_DEFAULT, Music_GymLeaderBattleSwSh_Ch4_NeutralPhase_Loop_2
	sound_jump_if COND_ADVANTAGE, Music_GymLeaderBattleSwSh_Ch4_AdvantagePhase_Loop_2
Music_GymLeaderBattleSwSh_Ch4_DisadvantagePhase_Loop_2:
	sound_call Music_GymLeaderBattleSwSh_Ch4_ditty8
	sound_call Music_GymLeaderBattleSwSh_Ch4_ditty8
	sound_call Music_GymLeaderBattleSwSh_Ch4_ditty8
	sound_call Music_GymLeaderBattleSwSh_Ch4_ditty8
	sound_jump_if COND_DEFAULT, Music_GymLeaderBattleSwSh_Ch4_NeutralPhase_Loop_3
	sound_jump_if COND_ADVANTAGE, Music_GymLeaderBattleSwSh_Ch4_AdvantagePhase_Loop_3
Music_GymLeaderBattleSwSh_Ch4_DisadvantagePhase_Loop_3:
	sound_call Music_GymLeaderBattleSwSh_Ch4_ditty8
	sound_call Music_GymLeaderBattleSwSh_Ch4_ditty8
	sound_call Music_GymLeaderBattleSwSh_Ch4_ditty8
	sound_call Music_GymLeaderBattleSwSh_Ch4_ditty8
	sound_jump_if COND_DEFAULT, Music_GymLeaderBattleSwSh_Ch4_NeutralPhase_Loop_4
	sound_jump_if COND_ADVANTAGE, Music_GymLeaderBattleSwSh_Ch4_AdvantagePhase_Loop_4
Music_GymLeaderBattleSwSh_Ch4_DisadvantagePhase_Loop_4:
	sound_call Music_GymLeaderBattleSwSh_Ch4_ditty8
	sound_call Music_GymLeaderBattleSwSh_Ch4_ditty8
	sound_call Music_GymLeaderBattleSwSh_Ch4_ditty8
	sound_call Music_GymLeaderBattleSwSh_Ch4_ditty8
	sound_jump Music_GymLeaderBattleSwSh_Ch4_DisadvantagePhase_Loop

Music_GymLeaderBattleSwSh_Ch2_EnterLastPokemonPhase:
	duty_cycle 1
	volume_envelope 10, 8
	vibrato 0, 0, 0
	octave 3
	stereo_panning TRUE, FALSE
	rest 16
	rest 16
	octave 4
	rest 16
	rest 8
	volume_envelope 1, -4
	vibrato 1, 2, 1
	octave 4
	drum_note 8, 8
	duty_cycle 3
	volume_envelope 12, 1
	vibrato 0, 0, 0
	sound_call Music_GymLeaderBattleSwSh_Ch2_ditty6
	drum_note 12, 2
	octave 4
	sound_call Music_GymLeaderBattleSwSh_Ch2_ditty6
	drum_note 12, 2
Music_GymLeaderBattleSwSh_Ch2_LastPokemonPhase_Loop:
	duty_cycle 1
	volume_envelope 12, 4
	stereo_panning TRUE, TRUE
	sound_call Music_GymLeaderBattleSwSh_Ch2_ditty9
	sound_call Music_GymLeaderBattleSwSh_Ch2_ditty9
	sound_call Music_GymLeaderBattleSwSh_Ch2_ditty9
	octave 5
	drum_note 3, 8
	octave 4
	drum_note 12, 4
	drum_note 8, 2
	octave 5
	drum_note 3, 6
	rest 6
	drum_note 3, 4
	octave 4
	drum_note 8, 2
	octave 5
	drum_note 5, 2
	drum_note 3, 8
	octave 4
	drum_note 12, 2
	drum_note 10, 2
	drum_note 8, 6
	rest 12
	duty_cycle 2
	volume_envelope 11, 2
	octave 3
	sound_call Music_GymLeaderBattleSwSh_Ch2_ditty10
	sound_call Music_GymLeaderBattleSwSh_Ch2_ditty10
	sound_call Music_GymLeaderBattleSwSh_Ch2_ditty10
	sound_call Music_GymLeaderBattleSwSh_Ch2_ditty10
	sound_call Music_GymLeaderBattleSwSh_Ch2_ditty10
	sound_call Music_GymLeaderBattleSwSh_Ch2_ditty10
	sound_jump Music_GymLeaderBattleSwSh_Ch2_LastPokemonPhase_Loop

Music_GymLeaderBattleSwSh_Ch1_EnterLastPokemonPhase:
	duty_cycle 1
	volume_envelope 10, 8
	vibrato 0, 0, 0
	octave 2
	stereo_panning FALSE, TRUE
	rest 16
	rest 16
	octave 3
	rest 16
	rest 8
	volume_envelope 1, -4
	vibrato 1, 2, 1
	octave 3
	drum_note 8, 8
	duty_cycle 3
	volume_envelope 12, 1
	vibrato 0, 0, 0
	sound_call Music_GymLeaderBattleSwSh_Ch1_ditty4
	sound_call Music_GymLeaderBattleSwSh_Ch1_ditty5
Music_GymLeaderBattleSwSh_Ch1_LastPokemonPhase_Loop:
	rest 2
	duty_cycle 1
	volume_envelope 12, 7
	stereo_panning TRUE, TRUE
	sound_call Music_GymLeaderBattleSwSh_Ch2_ditty7
	rest 3
	sound_call Music_GymLeaderBattleSwSh_Ch2_ditty7
	rest 1
	duty_cycle 2
	volume_envelope 11, 2
	sound_call Music_GymLeaderBattleSwSh_Ch2_ditty8
	sound_call Music_GymLeaderBattleSwSh_Ch2_ditty8
	duty_cycle 1
	volume_envelope 12, 4
	octave 4
	sound_call Music_GymLeaderBattleSwSh_Ch1_ditty8
	sound_call Music_GymLeaderBattleSwSh_Ch1_ditty8
	sound_call Music_GymLeaderBattleSwSh_Ch1_ditty9
	sound_call Music_GymLeaderBattleSwSh_Ch1_ditty9
	sound_call Music_GymLeaderBattleSwSh_Ch1_ditty10
	octave 4
	sound_call Music_GymLeaderBattleSwSh_Ch1_ditty10
	sound_jump Music_GymLeaderBattleSwSh_Ch1_LastPokemonPhase_Loop


Music_GymLeaderBattleSwSh_Ch3_EnterLastPokemonPhase:
	rest 16
	rest 16
	rest 16
	rest 16
	octave 2
	sound_call Music_GymLeaderBattleSwSh_Ch3_ditty4
	sound_call Music_GymLeaderBattleSwSh_Ch3_ditty4
Music_GymLeaderBattleSwSh_Ch3_LastPokemonPhase_Loop:
	sound_call Music_GymLeaderBattleSwSh_Ch3_ditty5
	sound_call Music_GymLeaderBattleSwSh_Ch3_ditty5
	sound_call Music_GymLeaderBattleSwSh_Ch3_ditty5
	sound_call Music_GymLeaderBattleSwSh_Ch3_ditty5
	sound_call Music_GymLeaderBattleSwSh_Ch3_ditty6
	sound_call Music_GymLeaderBattleSwSh_Ch3_ditty6
	sound_call Music_GymLeaderBattleSwSh_Ch3_ditty6
	sound_call Music_GymLeaderBattleSwSh_Ch3_ditty6
	sound_call Music_GymLeaderBattleSwSh_Ch3_ditty7
	sound_call Music_GymLeaderBattleSwSh_Ch3_ditty7
	sound_jump Music_GymLeaderBattleSwSh_Ch3_LastPokemonPhase_Loop


Music_GymLeaderBattleSwSh_Ch4_EnterLastPokemonPhase:
	sound_call Music_GymLeaderBattleSwSh_Ch4_ditty5
	sound_call Music_GymLeaderBattleSwSh_Ch4_ditty2
	sound_call Music_GymLeaderBattleSwSh_Ch4_ditty2
Music_GymLeaderBattleSwSh_Ch4_LastPokemonPhase_Loop:
	sound_call Music_GymLeaderBattleSwSh_Ch4_ditty3
	sound_call Music_GymLeaderBattleSwSh_Ch4_ditty3
	sound_call Music_GymLeaderBattleSwSh_Ch4_ditty6
	sound_call Music_GymLeaderBattleSwSh_Ch4_ditty6
	sound_call Music_GymLeaderBattleSwSh_Ch4_ditty7
	sound_call Music_GymLeaderBattleSwSh_Ch4_ditty7
	sound_call Music_GymLeaderBattleSwSh_Ch4_ditty7
	sound_call Music_GymLeaderBattleSwSh_Ch4_ditty7
	sound_call Music_GymLeaderBattleSwSh_Ch4_ditty7
	sound_call Music_GymLeaderBattleSwSh_Ch4_ditty7
	sound_jump Music_GymLeaderBattleSwSh_Ch4_LastPokemonPhase_Loop

Music_GymLeaderBattleSwSh_Ch2_ditty1:
	octave 3
	drum_note 8, 1
	rest 1
	drum_note 8, 2
	rest 1
	drum_note 8, 2
	drum_note 9, 1
	drum_note 8, 1
	rest 1
	drum_note 8, 2
	rest 1
	drum_note 8, 2
	drum_note 9, 1
	drum_note 8, 1
	rest 1
	drum_note 8, 2
	rest 1
	drum_note 8, 2
	drum_note 9, 1
	drum_note 8, 1
	rest 1
	drum_note 8, 2
	rest 1
	drum_note 8, 2
	drum_note 9, 1
	octave 4
	drum_note 3, 1
	rest 1
	drum_note 3, 2
	rest 1
	drum_note 3, 2
	drum_note 4, 1
	drum_note 3, 1
	rest 1
	drum_note 3, 2
	rest 1
	drum_note 3, 2
	drum_note 4, 1
	drum_note 3, 1
	rest 1
	drum_note 3, 2
	rest 1
	drum_note 3, 2
	drum_note 4, 1
	drum_note 3, 1
	rest 1
	drum_note 3, 2
	rest 1
	drum_note 3, 2
	drum_note 4, 1
	sound_ret

Music_GymLeaderBattleSwSh_Ch2_ditty2:
	drum_note 8, 3
	rest 1
	drum_note 8, 3
	rest 1
	drum_note 11, 2
	rest 1
	drum_note 10, 2
	rest 1
	drum_note 11, 1
	rest 3
	duty_cycle 2
	volume_envelope 11, 2
	drum_note 8, 1
	drum_note 8, 1
	drum_note 8, 1
	drum_note 8, 1
	drum_note 8, 1
	drum_note 8, 1
	duty_cycle 1
	volume_envelope 12, 7
	drum_note 11, 2
	rest 1
	drum_note 10, 2
	rest 1
	drum_note 11, 1
	rest 1
	octave 4
	drum_note 3, 3
	rest 1
	drum_note 3, 1
	rest 1
	drum_note 3, 1
	rest 1
	drum_note 4, 2
	rest 1
	drum_note 1, 2
	rest 1
	drum_note 3, 4
	duty_cycle 2
	volume_envelope 11, 2
	octave 3
	drum_note 11, 1
	drum_note 11, 1
	drum_note 11, 1
	drum_note 11, 1
	drum_note 11, 1
	drum_note 11, 1
	duty_cycle 1
	volume_envelope 12, 7
	octave 4
	drum_note 1, 2
	rest 1
	octave 3
	drum_note 10, 2
	rest 1
	drum_note 11, 1
	rest 1
	sound_ret

Music_GymLeaderBattleSwSh_Ch2_ditty3:
	drum_note 8, 1
	rest 3
	drum_note 8, 1
	rest 3
	drum_note 9, 1
	rest 3
	drum_note 8, 1
	rest 3
	drum_note 8, 1
	rest 3
	drum_note 8, 1
	rest 3
	drum_note 11, 1
	rest 3
	drum_note 11, 1
	rest 3
	drum_note 8, 1
	rest 3
	drum_note 8, 1
	rest 3
	drum_note 9, 1
	rest 3
	drum_note 8, 1
	rest 3
	drum_note 8, 1
	rest 3
	drum_note 8, 1
	rest 3
	drum_note 11, 1
	rest 3
	drum_note 11, 1
	rest 1
	sound_ret

Music_GymLeaderBattleSwSh_Ch2_ditty4:
	drum_note 8, 1
	rest 3
	drum_note 8, 1
	rest 3
	drum_note 9, 1
	rest 3
	drum_note 8, 1
	rest 3
	drum_note 8, 1
	rest 3
	drum_note 8, 1
	rest 3
	drum_note 11, 1
	rest 3
	drum_note 11, 1
	rest 3
	drum_note 8, 1
	rest 3
	drum_note 8, 1
	rest 3
	drum_note 9, 1
	rest 3
	drum_note 8, 1
	rest 3
	drum_note 8, 1
	rest 3
	drum_note 8, 1
	rest 3
	drum_note 11, 1
	rest 3
	drum_note 11, 1
	rest 1
	sound_ret

Music_GymLeaderBattleSwSh_Ch2_ditty5:
	drum_note 11, 1
	rest 1
	drum_note 11, 1
	drum_note 8, 1
	rest 1
	stereo_panning FALSE, TRUE
	drum_note 8, 1
	drum_note 8, 1
	rest 9
	drum_note 11, 1
	rest 1
	drum_note 11, 1
	drum_note 8, 1
	rest 1
	stereo_panning TRUE, FALSE
	drum_note 8, 1
	drum_note 8, 1
	rest 9
	drum_note 11, 1
	rest 1
	drum_note 11, 1
	drum_note 8, 1
	rest 1
	stereo_panning FALSE, TRUE
	drum_note 8, 1
	drum_note 8, 1
	rest 1
	octave 5
	drum_note 1, 1
	rest 1
	drum_note 1, 1
	octave 4
	drum_note 11, 1
	rest 1
	drum_note 11, 1
	stereo_panning TRUE, FALSE
	drum_note 10, 1
	rest 1
	drum_note 11, 1
	rest 1
	drum_note 11, 1
	drum_note 8, 1
	rest 1
	stereo_panning FALSE, TRUE
	drum_note 8, 1
	drum_note 8, 1
	sound_ret

Music_GymLeaderBattleSwSh_Ch2_ditty6:
	drum_note 3, 3
	rest 1
	drum_note 3, 3
	rest 1
	octave 3
	drum_note 12, 2
	rest 1
	drum_note 10, 2
	rest 1
	drum_note 12, 1
	rest 3
	drum_note 12, 1
	drum_note 12, 1
	drum_note 12, 1
	drum_note 12, 1
	drum_note 12, 1
	drum_note 12, 1
	drum_note 12, 1
	rest 2
	drum_note 10, 2
	rest 1
	drum_note 12, 1
	rest 1
	octave 4
	drum_note 3, 2
	rest 2
	drum_note 3, 1
	rest 1
	drum_note 3, 2
	drum_note 5, 2
	rest 1
	drum_note 1, 2
	rest 1
	drum_note 3, 4
	octave 3
	drum_note 12, 1
	drum_note 12, 1
	drum_note 12, 1
	drum_note 12, 1
	drum_note 12, 1
	drum_note 12, 1
	octave 4
	drum_note 1, 2
	rest 1
	octave 3
	drum_note 10, 2
	rest 1
	sound_ret

Music_GymLeaderBattleSwSh_Ch2_ditty7:
	drum_note 8, 1
	rest 3
	drum_note 8, 1
	rest 3
	drum_note 10, 1
	rest 3
	drum_note 6, 1
	rest 3
	drum_note 8, 1
	rest 3
	drum_note 8, 1
	rest 3
	drum_note 12, 1
	rest 3
	drum_note 12, 1
	rest 3
	drum_note 8, 1
	rest 3
	drum_note 8, 1
	rest 3
	drum_note 10, 1
	rest 3
	drum_note 6, 1
	rest 3
	drum_note 8, 1
	rest 3
	drum_note 8, 1
	rest 3
	drum_note 12, 1
	rest 3
	drum_note 12, 1
	sound_ret

Music_GymLeaderBattleSwSh_Ch2_ditty8:
	octave 4
	drum_note 12, 1
	rest 2
	drum_note 8, 1
	rest 2
	drum_note 8, 1
	rest 3
	octave 3
	drum_note 10, 1
	rest 3
	drum_note 6, 1
	rest 1
	octave 4
	drum_note 12, 1
	rest 2
	drum_note 8, 1
	rest 2
	drum_note 8, 1
	rest 3
	octave 3
	drum_note 12, 1
	rest 3
	drum_note 12, 1
	rest 1
	octave 4
	drum_note 12, 1
	rest 2
	drum_note 8, 1
	rest 2
	drum_note 8, 1
	rest 1
	drum_note 10, 1
	rest 2
	drum_note 8, 1
	rest 2
	drum_note 8, 1
	rest 1
	drum_note 12, 1
	rest 2
	drum_note 10, 1
	rest 2
	drum_note 10, 1
	rest 3
	octave 3
	drum_note 12, 1
	rest 3
	drum_note 12, 1
	rest 1
	sound_ret

Music_GymLeaderBattleSwSh_Ch2_ditty9:
	octave 5
	drum_note 3, 8
	octave 4
	drum_note 12, 4
	drum_note 8, 2
	octave 5
	drum_note 3, 6
	rest 6
	drum_note 3, 4
	octave 4
	drum_note 8, 2
	octave 5
	drum_note 5, 2
	drum_note 3, 8
	octave 4
	drum_note 12, 2
	drum_note 8, 2
	drum_note 10, 6
	rest 6
	drum_note 8, 2
	drum_note 10, 2
	drum_note 8, 2
	sound_ret

Music_GymLeaderBattleSwSh_Ch2_ditty10:
	drum_note 8, 2
	rest 6
	drum_note 8, 2
	rest 6
	drum_note 8, 2
	rest 2
	drum_note 8, 2
	rest 2
	drum_note 8, 2
	rest 2
	drum_note 8, 2
	rest 2
	drum_note 8, 2
	rest 6
	drum_note 8, 2
	rest 6
	drum_note 8, 2
	rest 2
	drum_note 8, 2
	rest 2
	drum_note 8, 2
	rest 2
	drum_note 8, 2
	rest 2
	sound_ret

Music_GymLeaderBattleSwSh_Ch2_ditty11:
	drum_note 3, 1
	rest 3
	drum_note 3, 1
	rest 3
	drum_note 4, 1
	rest 3
	drum_note 3, 1
	rest 3
	drum_note 3, 1
	rest 3
	drum_note 3, 1
	rest 3
	drum_note 6, 1
	rest 3
	drum_note 6, 1
	sound_ret

Music_GymLeaderBattleSwSh_Ch2_ditty12:
	rest 3
	drum_note 3, 1
	rest 3
	drum_note 3, 1
	rest 3
	drum_note 4, 1
	rest 3
	drum_note 3, 1
	rest 3
	drum_note 3, 1
	rest 3
	drum_note 3, 1
	rest 3
	volume_envelope 0, -7
	drum_note 6, 6
	sound_ret

Music_GymLeaderBattleSwSh_Ch1_ditty1:
	drum_note 3, 1
	rest 1
	octave 2
	drum_note 8, 1
	octave 3
	drum_note 3, 1
	rest 1
	octave 2
	drum_note 8, 1
	octave 3
	drum_note 3, 1
	drum_note 4, 1
	drum_note 3, 1
	rest 1
	octave 2
	drum_note 8, 1
	octave 3
	drum_note 3, 1
	rest 1
	octave 2
	drum_note 8, 1
	octave 3
	drum_note 3, 1
	drum_note 4, 1
	drum_note 3, 1
	rest 1
	octave 2
	drum_note 8, 1
	octave 3
	drum_note 3, 1
	rest 1
	octave 2
	drum_note 8, 1
	octave 3
	drum_note 3, 1
	drum_note 4, 1
	drum_note 3, 1
	rest 1
	octave 2
	drum_note 8, 1
	octave 3
	drum_note 3, 1
	rest 1
	octave 2
	drum_note 8, 1
	octave 3
	drum_note 3, 1
	drum_note 4, 1
	drum_note 8, 1
	rest 1
	drum_note 3, 1
	drum_note 8, 1
	rest 1
	drum_note 3, 1
	drum_note 8, 1
	drum_note 9, 1
	drum_note 8, 1
	rest 1
	drum_note 3, 1
	drum_note 8, 1
	rest 1
	drum_note 3, 1
	drum_note 8, 1
	drum_note 9, 1
	drum_note 8, 1
	rest 1
	drum_note 3, 1
	drum_note 8, 1
	rest 1
	drum_note 3, 1
	drum_note 8, 1
	drum_note 9, 1
	drum_note 8, 1
	rest 1
	drum_note 3, 1
	drum_note 8, 1
	rest 1
	drum_note 3, 1
	drum_note 8, 1
	drum_note 9, 1
	sound_ret

Music_GymLeaderBattleSwSh_Ch1_ditty2:
	stereo_panning FALSE, TRUE
	octave 4
	drum_note 8, 3
	rest 1
	drum_note 8, 3
	rest 1
	drum_note 11, 2
	rest 1
	drum_note 10, 2
	rest 1
	drum_note 11, 1
	rest 3
	drum_note 8, 1
	drum_note 8, 1
	drum_note 8, 1
	drum_note 8, 1
	drum_note 8, 1
	drum_note 8, 1
	drum_note 11, 2
	rest 1
	drum_note 10, 2
	rest 1
	drum_note 11, 1
	rest 1
	duty_cycle 1
	volume_envelope 12, 7
	octave 3
	drum_note 8, 3
	rest 1
	drum_note 8, 1
	rest 1
	drum_note 8, 1
	rest 1
	drum_note 6, 2
	rest 1
	drum_note 6, 2
	rest 1
	drum_note 8, 4
	duty_cycle 2
	volume_envelope 11, 2
	drum_note 8, 1
	drum_note 8, 1
	drum_note 8, 1
	drum_note 8, 1
	drum_note 8, 1
	drum_note 8, 1
	duty_cycle 1
	volume_envelope 12, 7
	drum_note 6, 2
	rest 1
	drum_note 6, 2
	rest 1
	drum_note 6, 1
	sound_ret

Music_GymLeaderBattleSwSh_Ch1_ditty3:
	drum_note 3, 1
	rest 3
	drum_note 3, 1
	rest 3
	drum_note 4, 1
	rest 3
	drum_note 3, 1
	rest 3
	drum_note 3, 1
	rest 3
	drum_note 3, 1
	rest 3
	drum_note 6, 1
	rest 3
	drum_note 6, 1
	rest 3
	drum_note 3, 1
	rest 3
	drum_note 3, 1
	rest 3
	drum_note 4, 1
	rest 3
	drum_note 3, 1
	rest 3
	drum_note 3, 1
	rest 3
	drum_note 3, 1
	rest 3
	drum_note 6, 1
	rest 3
	drum_note 6, 1
	rest 1
	sound_ret

Music_GymLeaderBattleSwSh_Ch1_ditty4:
	drum_note 8, 3
	rest 1
	drum_note 8, 3
	rest 1
	drum_note 8, 2
	rest 1
	drum_note 3, 2
	rest 1
	drum_note 8, 1
	rest 3
	drum_note 8, 1
	drum_note 8, 1
	drum_note 8, 1
	drum_note 8, 1
	drum_note 8, 1
	drum_note 8, 1
	drum_note 8, 1
	rest 2
	drum_note 3, 2
	rest 1
	drum_note 8, 1
	rest 1
	drum_note 8, 2
	rest 2
	drum_note 8, 1
	rest 1
	drum_note 8, 2
	drum_note 8, 2
	rest 1
	drum_note 8, 2
	rest 1
	drum_note 8, 1
	rest 3
	drum_note 8, 1
	drum_note 8, 1
	drum_note 8, 1
	drum_note 8, 1
	drum_note 8, 1
	drum_note 8, 1
	drum_note 8, 1
	rest 2
	drum_note 3, 2
	rest 1
	drum_note 8, 2
	sound_ret

Music_GymLeaderBattleSwSh_Ch1_ditty5:
	drum_note 8, 3
	rest 1
	drum_note 8, 3
	rest 1
	drum_note 8, 2
	rest 1
	drum_note 3, 2
	rest 1
	drum_note 8, 1
	rest 3
	drum_note 8, 1
	drum_note 8, 1
	drum_note 8, 1
	drum_note 8, 1
	drum_note 8, 1
	drum_note 8, 1
	drum_note 8, 1
	rest 2
	drum_note 3, 2
	rest 1
	drum_note 8, 1
	rest 1
	drum_note 8, 2
	rest 2
	drum_note 8, 1
	rest 1
	drum_note 8, 2
	drum_note 8, 2
	rest 1
	drum_note 8, 2
	rest 1
	drum_note 8, 1
	rest 3
	drum_note 8, 1
	drum_note 8, 1
	drum_note 8, 1
	drum_note 8, 1
	drum_note 8, 1
	drum_note 8, 1
	drum_note 8, 1
	rest 2
	drum_note 3, 2
	rest 1
	drum_note 8, 2
	sound_ret

Music_GymLeaderBattleSwSh_Ch1_ditty6:
	drum_note 3, 1
	rest 3
	drum_note 3, 1
	rest 3
	drum_note 6, 1
	rest 3
	drum_note 3, 1
	rest 3
	drum_note 3, 1
	rest 3
	drum_note 3, 1
	rest 3
	drum_note 8, 1
	rest 3
	drum_note 8, 1
	rest 3
	drum_note 3, 1
	rest 3
	drum_note 3, 1
	rest 3
	drum_note 6, 1
	rest 3
	drum_note 3, 1
	rest 3
	drum_note 3, 1
	rest 3
	drum_note 3, 1
	rest 3
	drum_note 8, 1
	rest 3
	drum_note 8, 1
	sound_ret

Music_GymLeaderBattleSwSh_Ch1_ditty7:
	octave 4
	drum_note 8, 1
	rest 2
	drum_note 3, 1
	rest 2
	drum_note 3, 1
	rest 3
	octave 3
	drum_note 6, 1
	rest 3
	drum_note 3, 1
	rest 1
	octave 4
	drum_note 8, 1
	rest 2
	drum_note 3, 1
	rest 2
	drum_note 3, 1
	rest 3
	octave 3
	drum_note 8, 1
	rest 3
	drum_note 8, 1
	rest 1
	octave 4
	drum_note 8, 1
	rest 2
	drum_note 3, 1
	rest 2
	drum_note 3, 1
	rest 1
	drum_note 3, 1
	rest 2
	drum_note 3, 1
	rest 2
	drum_note 3, 1
	rest 1
	drum_note 8, 1
	rest 2
	drum_note 3, 1
	rest 2
	drum_note 3, 1
	rest 3
	octave 3
	drum_note 8, 1
	rest 3
	drum_note 8, 1
	rest 1
	sound_ret

Music_GymLeaderBattleSwSh_Ch1_ditty8:
	drum_note 8, 3
	rest 1
	drum_note 8, 1
	rest 1
	drum_note 8, 1
	drum_note 10, 1
	rest 1
	drum_note 10, 1
	drum_note 6, 4
	rest 6
	drum_note 8, 2
	drum_note 8, 1
	rest 5
	drum_note 8, 2
	drum_note 8, 1
	rest 1
	drum_note 8, 3
	rest 1
	drum_note 8, 1
	rest 1
	drum_note 8, 1
	drum_note 10, 1
	rest 1
	drum_note 10, 1
	drum_note 6, 4
	rest 2
	drum_note 8, 3
	rest 1
	drum_note 8, 1
	drum_note 8, 1
	rest 1
	drum_note 8, 1
	drum_note 3, 4
	rest 4
	sound_ret

Music_GymLeaderBattleSwSh_Ch1_ditty9:
	drum_note 8, 2
	octave 3
	drum_note 8, 1
	octave 4
	drum_note 8, 1
	rest 1
	octave 3
	drum_note 8, 1
	octave 4
	drum_note 8, 1
	rest 1
	drum_note 10, 2
	drum_note 8, 2
	drum_note 6, 2
	drum_note 10, 2
	octave 3
	drum_note 8, 2
	octave 4
	drum_note 8, 1
	rest 1
	octave 3
	drum_note 8, 1
	octave 4
	drum_note 8, 1
	rest 1
	drum_note 3, 3
	rest 6
	octave 3
	drum_note 12, 2
	rest 1
	drum_note 12, 1
	rest 1
	drum_note 8, 1
	drum_note 12, 1
	rest 1
	drum_note 12, 1
	rest 1
	drum_note 12, 2
	octave 4
	drum_note 1, 2
	drum_note 5, 1
	rest 1
	drum_note 8, 3
	rest 1
	drum_note 8, 1
	drum_note 8, 1
	rest 1
	drum_note 8, 1
	drum_note 3, 4
	rest 4
	sound_ret

Music_GymLeaderBattleSwSh_Ch1_ditty10:
	drum_note 8, 2
	octave 3
	drum_note 8, 1
	octave 4
	drum_note 8, 1
	rest 1
	octave 3
	drum_note 8, 1
	octave 4
	drum_note 8, 1
	rest 1
	drum_note 10, 2
	drum_note 8, 2
	drum_note 6, 2
	drum_note 10, 2
	octave 3
	drum_note 8, 2
	octave 4
	drum_note 8, 1
	rest 1
	octave 3
	drum_note 8, 1
	octave 4
	drum_note 8, 1
	rest 1
	drum_note 3, 3
	rest 6
	octave 3
	drum_note 12, 2
	rest 1
	drum_note 12, 1
	rest 1
	drum_note 8, 1
	drum_note 12, 1
	rest 1
	drum_note 12, 1
	rest 1
	drum_note 12, 2
	octave 4
	drum_note 1, 2
	drum_note 5, 1
	rest 1
	drum_note 3, 2
	octave 3
	drum_note 8, 1
	octave 4
	drum_note 3, 1
	rest 1
	octave 3
	drum_note 8, 1
	octave 4
	drum_note 3, 1
	rest 1
	octave 3
	drum_note 8, 1
	rest 1
	drum_note 8, 1
	rest 1
	drum_note 10, 2
	drum_note 12, 2
	sound_ret

Music_GymLeaderBattleSwSh_Ch1_ditty11:
	drum_note 8, 1
	rest 3
	drum_note 8, 1
	rest 3
	drum_note 9, 1
	rest 3
	drum_note 8, 1
	rest 3
	drum_note 8, 1
	rest 3
	drum_note 8, 1
	rest 3
	drum_note 11, 1
	rest 3
	drum_note 11, 1
	sound_ret

Music_GymLeaderBattleSwSh_Ch1_ditty12:
	rest 3
	drum_note 8, 1
	rest 3
	drum_note 8, 1
	rest 3
	drum_note 9, 1
	rest 3
	drum_note 8, 1
	rest 3
	drum_note 8, 1
	rest 3
	drum_note 8, 1
	rest 3
	octave 2
	volume_envelope 0, -7
	drum_note 6, 6
	sound_ret

Music_GymLeaderBattleSwSh_Ch3_ditty1:
	octave 1
	drum_note 8, 2
	octave 2
	drum_note 8, 1
	rest 1
	octave 1
	drum_note 8, 2
	octave 2
	drum_note 8, 1
	rest 1
	octave 1
	drum_note 8, 2
	octave 2
	drum_note 8, 1
	rest 1
	octave 1
	drum_note 8, 2
	octave 2
	drum_note 8, 1
	rest 1
	octave 1
	drum_note 8, 2
	octave 2
	drum_note 8, 1
	rest 1
	octave 1
	drum_note 8, 2
	octave 2
	drum_note 8, 1
	rest 1
	octave 1
	drum_note 8, 2
	octave 2
	drum_note 8, 1
	rest 1
	octave 1
	drum_note 8, 2
	octave 2
	drum_note 8, 1
	rest 1
	octave 1
	drum_note 8, 2
	octave 2
	drum_note 8, 1
	rest 1
	octave 1
	drum_note 8, 2
	octave 2
	drum_note 8, 1
	rest 1
	octave 1
	drum_note 8, 2
	octave 2
	drum_note 8, 1
	rest 1
	octave 1
	drum_note 8, 2
	octave 2
	drum_note 8, 1
	rest 1
	octave 1
	drum_note 8, 2
	octave 2
	drum_note 8, 1
	rest 1
	octave 1
	drum_note 8, 2
	octave 2
	drum_note 8, 1
	rest 1
	octave 1
	drum_note 8, 2
	octave 2
	drum_note 8, 1
	rest 1
	octave 1
	drum_note 8, 2
	octave 2
	drum_note 8, 1
	rest 1
	sound_ret

Music_GymLeaderBattleSwSh_Ch3_ditty2:
	drum_note 8, 3
	rest 1
	drum_note 8, 3
	rest 1
	drum_note 6, 2
	rest 1
	drum_note 6, 2
	rest 1
	drum_note 6, 1
	rest 3
	drum_note 8, 6
	drum_note 6, 2
	rest 1
	drum_note 6, 2
	rest 1
	drum_note 6, 1
	rest 1
	drum_note 8, 5
	rest 1
	drum_note 8, 1
	rest 1
	drum_note 6, 2
	rest 1
	drum_note 6, 2
	rest 1
	drum_note 6, 1
	rest 1
	drum_note 8, 8
	drum_note 6, 2
	rest 1
	drum_note 6, 2
	rest 1
	drum_note 6, 1
	rest 1
	sound_ret

Music_GymLeaderBattleSwSh_Ch3_ditty3:
	volume_envelope 1, 0
	octave 4
	drum_note 8, 1
	rest 1
	volume_envelope 1, 1
	octave 2
	drum_note 8, 1
	octave 3
	drum_note 8, 1
	rest 1
	octave 2
	drum_note 8, 1
	volume_envelope 1, 0
	octave 3
	drum_note 8, 1
	rest 1
	volume_envelope 1, 1
	drum_note 4, 1
	rest 1
	drum_note 4, 1
	rest 1
	volume_envelope 1, 0
	drum_note 4, 1
	drum_note 3, 1
	volume_envelope 1, 1
	drum_note 3, 1
	rest 1
	drum_note 8, 1
	octave 4
	drum_note 8, 1
	rest 1
	volume_envelope 1, 0
	octave 2
	drum_note 8, 1
	volume_envelope 1, 1
	octave 3
	drum_note 8, 1
	rest 1
	drum_note 11, 1
	rest 1
	volume_envelope 1, 0
	drum_note 2, 1
	rest 1
	volume_envelope 1, 1
	drum_note 2, 2
	rest 1
	drum_note 2, 1
	volume_envelope 1, 0
	drum_note 11, 1
	rest 1
	volume_envelope 1, 1
	sound_ret

Music_GymLeaderBattleSwSh_Ch3_ditty4:
	drum_note 8, 3
	rest 1
	drum_note 8, 3
	rest 1
	drum_note 3, 2
	rest 1
	drum_note 3, 2
	rest 1
	drum_note 3, 1
	rest 3
	drum_note 8, 5
	rest 1
	drum_note 3, 2
	rest 1
	drum_note 3, 2
	rest 1
	drum_note 3, 1
	rest 1
	drum_note 8, 8
	drum_note 1, 2
	rest 1
	drum_note 1, 2
	rest 1
	drum_note 1, 2
	drum_note 8, 7
	rest 1
	drum_note 3, 2
	rest 1
	drum_note 3, 2
	rest 1
	drum_note 3, 2
	sound_ret

Music_GymLeaderBattleSwSh_Ch3_ditty5:
	volume_envelope 1, 1
	octave 2
	drum_note 8, 2
	rest 1
	drum_note 8, 1
	octave 3
	drum_note 8, 2
	rest 1
	drum_note 8, 1
	drum_note 3, 3
	rest 1
	volume_envelope 1, 0
	drum_note 1, 3
	rest 1
	volume_envelope 1, 1
	octave 2
	drum_note 12, 2
	rest 1
	drum_note 8, 1
	volume_envelope 1, 0
	drum_note 12, 1
	volume_envelope 1, 1
	rest 1
	drum_note 12, 2
	rest 1
	drum_note 12, 1
	volume_envelope 1, 0
	octave 3
	drum_note 1, 1
	rest 1
	drum_note 3, 2
	rest 1
	drum_note 3, 1
	octave 2
	volume_envelope 1, 1
	drum_note 12, 2
	rest 1
	volume_envelope 1, 0
	drum_note 12, 1
	rest 1
	drum_note 8, 1
	volume_envelope 1, 1
	octave 3
	drum_note 1, 2
	octave 2
	drum_note 12, 1
	rest 1
	volume_envelope 1, 0
	drum_note 10, 1
	rest 1
	volume_envelope 1, 1
	drum_note 8, 2
	rest 1
	drum_note 6, 1
	volume_envelope 1, 0
	drum_note 8, 2
	rest 1
	drum_note 8, 1
	rest 2
	volume_envelope 1, 1
	octave 1
	drum_note 8, 1
	rest 1
	drum_note 12, 1
	rest 1
	volume_envelope 1, 0
	drum_note 12, 1
	rest 1
	octave 2
	drum_note 3, 2
	rest 1
	drum_note 3, 1
	volume_envelope 1, 1
	sound_ret

Music_GymLeaderBattleSwSh_Ch3_ditty6:
	drum_note 8, 7
	rest 1
	drum_note 8, 7
	rest 1
	drum_note 8, 3
	rest 1
	drum_note 8, 3
	rest 1
	drum_note 8, 3
	rest 1
	drum_note 8, 3
	rest 1
	drum_note 8, 5
	rest 3
	drum_note 8, 7
	rest 1
	drum_note 8, 3
	rest 1
	drum_note 8, 2
	rest 2
	drum_note 8, 8
	sound_ret

Music_GymLeaderBattleSwSh_Ch3_ditty7:
	drum_note 8, 7
	rest 1
	drum_note 8, 7
	rest 1
	drum_note 8, 3
	rest 1
	drum_note 8, 3
	rest 1
	drum_note 8, 3
	rest 1
	drum_note 8, 3
	rest 1
	drum_note 8, 5
	rest 3
	drum_note 8, 7
	rest 1
	drum_note 8, 3
	rest 1
	drum_note 8, 3
	rest 1
	drum_note 8, 8
	sound_ret

Music_GymLeaderBattleSwSh_Ch3_ditty8:
	octave 1
	drum_note 8, 2
	octave 2
	drum_note 8, 2
	octave 1
	drum_note 8, 2
	octave 2
	drum_note 8, 2
	sound_ret

Music_GymLeaderBattleSwSh_Ch3_ditty9:
	octave 2
	drum_note 4, 2
	octave 3
	drum_note 4, 2
	octave 2
	drum_note 3, 2
	octave 3
	drum_note 3, 2
	sound_ret

Music_GymLeaderBattleSwSh_Ch3_ditty10:
	octave 1
	drum_note 11, 2
	octave 2
	drum_note 11, 2
	octave 1
	drum_note 11, 2
	octave 2
	drum_note 11, 2
	sound_ret

Music_GymLeaderBattleSwSh_Ch4_ditty1:
	drum_note 4, 1
	rest 1
	drum_note 10, 2
	drum_note 4, 1
	rest 1
	drum_note 10, 2
	drum_note 2, 1
	rest 1
	drum_note 10, 2
	drum_note 4, 1
	rest 1
	drum_note 10, 2
	drum_note 2, 1
	rest 1
	drum_note 10, 2
	drum_note 4, 1
	rest 1
	drum_note 10, 2
	drum_note 2, 1
	rest 1
	drum_note 10, 2
	drum_note 4, 1
	rest 1
	drum_note 10, 2
	drum_note 2, 1
	rest 1
	drum_note 10, 2
	drum_note 4, 1
	rest 1
	drum_note 10, 2
	drum_note 2, 1
	rest 1
	drum_note 10, 2
	drum_note 4, 1
	rest 1
	drum_note 10, 2
	drum_note 2, 1
	rest 1
	drum_note 10, 2
	drum_note 4, 1
	rest 1
	drum_note 10, 2
	drum_note 2, 1
	drum_note 4, 3
	drum_note 2, 1
	drum_note 4, 3
	sound_ret

Music_GymLeaderBattleSwSh_Ch4_ditty2:
	drum_note 5, 4
	drum_note 4, 4
	drum_note 4, 3
	drum_note 4, 3
	drum_note 4, 1
	rest 3
	drum_note 4, 1
	rest 5
	drum_note 4, 1
	rest 2
	drum_note 4, 1
	rest 2
	drum_note 4, 1
	rest 1
	drum_note 4, 1
	rest 3
	drum_note 4, 1
	rest 1
	drum_note 4, 1
	rest 1
	drum_note 4, 1
	rest 2
	drum_note 4, 1
	rest 2
	drum_note 4, 1
	rest 3
	drum_note 4, 1
	rest 5
	drum_note 4, 1
	rest 2
	drum_note 4, 1
	rest 2
	drum_note 4, 1
	rest 1
	sound_ret

Music_GymLeaderBattleSwSh_Ch4_ditty3:
	drum_note 4, 2
	drum_note 10, 2
	drum_note 2, 2
	drum_note 10, 1
	drum_note 10, 1
	drum_note 4, 2
	drum_note 10, 2
	drum_note 2, 2
	drum_note 10, 1
	drum_note 10, 1
	drum_note 4, 2
	drum_note 10, 2
	drum_note 2, 2
	drum_note 10, 1
	drum_note 10, 1
	drum_note 4, 2
	drum_note 10, 2
	drum_note 2, 2
	drum_note 10, 1
	drum_note 10, 1
	drum_note 4, 2
	drum_note 10, 2
	drum_note 2, 2
	drum_note 10, 1
	drum_note 10, 1
	drum_note 4, 2
	drum_note 10, 2
	drum_note 2, 2
	drum_note 10, 1
	drum_note 10, 1
	drum_note 4, 2
	drum_note 10, 2
	drum_note 2, 2
	drum_note 10, 1
	drum_note 10, 1
	drum_note 4, 2
	drum_note 10, 2
	drum_note 2, 2
	drum_note 10, 1
	drum_note 10, 1
	sound_ret

Music_GymLeaderBattleSwSh_Ch4_ditty4:
	drum_note 2, 1
	drum_note 2, 1
	drum_note 2, 1
	drum_note 2, 1
	drum_note 2, 1
	drum_note 2, 11
	drum_note 4, 16
	drum_note 4, 16
	drum_note 4, 16
	sound_ret

Music_GymLeaderBattleSwSh_Ch4_ditty5:
	noisesampleset 5
	drum_note 2, 4
	drum_note 2, 4
	drum_note 2, 4
	drum_note 2, 4
	drum_note 2, 2
	drum_note 2, 2
	drum_note 2, 2
	drum_note 2, 2
	drum_note 2, 2
	drum_note 2, 2
	drum_note 2, 2
	drum_note 2, 2
	drum_note 2, 1
	drum_note 2, 1
	drum_note 2, 1
	drum_note 2, 1
	drum_note 2, 1
	drum_note 2, 1
	drum_note 2, 1
	drum_note 2, 1
	drum_note 2, 1
	drum_note 2, 1
	drum_note 2, 1
	drum_note 2, 1
	drum_note 2, 1
	drum_note 2, 1
	drum_note 2, 1
	drum_note 2, 1
	drum_note 9, 16
	noisesampleset 4
	sound_ret

Music_GymLeaderBattleSwSh_Ch4_ditty6:
	drum_note 5, 12
	drum_note 4, 2
	drum_note 4, 1
	rest 1
	drum_note 5, 12
	drum_note 4, 2
	drum_note 4, 1
	rest 1
	drum_note 5, 12
	drum_note 4, 2
	drum_note 4, 1
	rest 1
	drum_note 5, 8
	drum_note 4, 1
	rest 2
	drum_note 4, 1
	rest 2
	drum_note 4, 1
	rest 1
	sound_ret

Music_GymLeaderBattleSwSh_Ch4_ditty7:
	drum_note 4, 2
	drum_note 10, 2
	drum_note 2, 2
	drum_note 10, 1
	drum_note 2, 1
	drum_note 4, 2
	drum_note 10, 2
	drum_note 2, 2
	drum_note 10, 1
	drum_note 2, 1
	drum_note 4, 2
	drum_note 10, 2
	drum_note 2, 2
	drum_note 10, 1
	drum_note 4, 3
	drum_note 10, 2
	drum_note 2, 2
	drum_note 10, 2
	drum_note 4, 2
	drum_note 10, 2
	drum_note 2, 2
	drum_note 10, 1
	drum_note 2, 1
	drum_note 4, 2
	drum_note 10, 2
	drum_note 2, 2
	drum_note 10, 1
	drum_note 2, 1
	drum_note 4, 2
	drum_note 10, 2
	drum_note 2, 2
	drum_note 10, 1
	drum_note 4, 3
	drum_note 10, 2
	drum_note 2, 2
	drum_note 10, 2
	sound_ret

Music_GymLeaderBattleSwSh_Ch4_ditty8:
	drum_note 11, 2
	drum_note 8, 2
	drum_note 8, 2
	drum_note 8, 2
	drum_note 8, 2
	drum_note 8, 2
	drum_note 8, 2
	drum_note 11, 2
	sound_ret
