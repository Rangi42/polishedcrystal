; Pokémon Sw/Sh - Battle! Gym Leader
; Demixed by ShinkoNetCavy
; https://soundcloud.com/user-927422935-571023782/swsh-gym-leader-theme-8-bit-by-shinkonetcavy

Music_GymLeaderBattleSwSh:
	musicheader 4, 1, Music_GymLeaderBattleSwSh_Ch1
	musicheader 1, 2, Music_GymLeaderBattleSwSh_Ch2
	musicheader 1, 3, Music_GymLeaderBattleSwSh_Ch3
	musicheader 1, 4, Music_GymLeaderBattleSwSh_Ch4

Music_GymLeaderBattleSwSh_Ch1:
	tempo $89
	volume $77
	dutycycle $2
	notetype $c, $b2
	stereopanning $ff
	jumpif COND_FINAL_MON, Music_GymLeaderBattleSwSh_Ch1_EnterLastPokemonPhase
; Neutral Intro
	octave 3
	callchannel Music_GymLeaderBattleSwSh_Ch1_ditty1
	callchannel Music_GymLeaderBattleSwSh_Ch1_ditty1
	note __, 16
	callchannel Music_GymLeaderBattleSwSh_Ch1_ditty2
	note __, 1
	dutycycle $2
	intensity $b2
	callchannel Music_GymLeaderBattleSwSh_Ch1_ditty2
	note __, 1

;Neutral Loop
Music_GymLeaderBattleSwSh_Ch1_NeutralPhase_Loop:
	jumpif COND_ADVANTAGE, Music_GymLeaderBattleSwSh_Ch1_AdvantagePhase_Loop_1
	jumpif COND_DISADVANTAGE, Music_GymLeaderBattleSwSh_Ch1_DisadvantagePhase_Loop_1
Music_GymLeaderBattleSwSh_Ch1_NeutralPhase_Loop_1:
	stereopanning $ff
	octave 3
	dutycycle $2
	intensity $b2
	note __, 2
	callchannel Music_GymLeaderBattleSwSh_Ch1_ditty3
	jumpif COND_ADVANTAGE, Music_GymLeaderBattleSwSh_Ch1_AdvantagePhase_Loop_2
	jumpif COND_DISADVANTAGE, Music_GymLeaderBattleSwSh_Ch1_DisadvantagePhase_Loop_2
Music_GymLeaderBattleSwSh_Ch1_NeutralPhase_Loop_2:
	stereopanning $ff
	octave 3
	dutycycle $2
	intensity $b2
	note __, 2
	callchannel Music_GymLeaderBattleSwSh_Ch1_ditty3
	jumpif COND_ADVANTAGE, Music_GymLeaderBattleSwSh_Ch1_AdvantagePhase_Loop_3
	jumpif COND_DISADVANTAGE, Music_GymLeaderBattleSwSh_Ch1_DisadvantagePhase_Loop_3
Music_GymLeaderBattleSwSh_Ch1_NeutralPhase_Loop_3:
	stereopanning $ff
	octave 3
	dutycycle $2
	intensity $b2
	note __, 2
	callchannel Music_GymLeaderBattleSwSh_Ch2_ditty4
	jumpif COND_ADVANTAGE, Music_GymLeaderBattleSwSh_Ch1_AdvantagePhase_Loop_4
	jumpif COND_DISADVANTAGE, Music_GymLeaderBattleSwSh_Ch1_DisadvantagePhase_Loop_4
Music_GymLeaderBattleSwSh_Ch1_NeutralPhase_Loop_4:
	stereopanning $ff
	octave 3
	dutycycle $2
	intensity $b2
	note __, 2
	callchannel Music_GymLeaderBattleSwSh_Ch2_ditty3
	jumpchannel Music_GymLeaderBattleSwSh_Ch1_NeutralPhase_Loop

;Advantage Loop
Music_GymLeaderBattleSwSh_Ch1_AdvantagePhase_Loop:
	jumpif COND_DEFAULT, Music_GymLeaderBattleSwSh_Ch1_NeutralPhase_Loop_1
	jumpif COND_DISADVANTAGE, Music_GymLeaderBattleSwSh_Ch1_DisadvantagePhase_Loop_1
Music_GymLeaderBattleSwSh_Ch1_AdvantagePhase_Loop_1:
	dutycycle $1
	intensity $c7
	octave 3
	note __, 2
	callchannel Music_GymLeaderBattleSwSh_Ch1_ditty6
	note __, 1
	jumpif COND_DEFAULT, Music_GymLeaderBattleSwSh_Ch1_NeutralPhase_Loop_2
	jumpif COND_DISADVANTAGE, Music_GymLeaderBattleSwSh_Ch1_DisadvantagePhase_Loop_2
Music_GymLeaderBattleSwSh_Ch1_AdvantagePhase_Loop_2:
	dutycycle $1
	intensity $c7
	octave 3
	note __, 2
	callchannel Music_GymLeaderBattleSwSh_Ch1_ditty6
	note __, 1
	jumpif COND_DEFAULT, Music_GymLeaderBattleSwSh_Ch1_NeutralPhase_Loop_3
	jumpif COND_DISADVANTAGE, Music_GymLeaderBattleSwSh_Ch1_DisadvantagePhase_Loop_3
Music_GymLeaderBattleSwSh_Ch1_AdvantagePhase_Loop_3:
	dutycycle $1
	intensity $c7
	callchannel Music_GymLeaderBattleSwSh_Ch1_ditty7
	jumpif COND_DEFAULT, Music_GymLeaderBattleSwSh_Ch1_NeutralPhase_Loop_4
	jumpif COND_DISADVANTAGE, Music_GymLeaderBattleSwSh_Ch1_DisadvantagePhase_Loop_4
Music_GymLeaderBattleSwSh_Ch1_AdvantagePhase_Loop_4:
	dutycycle $1
	intensity $c7
	callchannel Music_GymLeaderBattleSwSh_Ch1_ditty7
	jumpchannel Music_GymLeaderBattleSwSh_Ch1_AdvantagePhase_Loop

;Disadvantage Loop
Music_GymLeaderBattleSwSh_Ch1_DisadvantagePhase_Loop:
	jumpif COND_DEFAULT, Music_GymLeaderBattleSwSh_Ch1_NeutralPhase_Loop_1
	jumpif COND_ADVANTAGE, Music_GymLeaderBattleSwSh_Ch1_AdvantagePhase_Loop_1
Music_GymLeaderBattleSwSh_Ch1_DisadvantagePhase_Loop_1:
	stereopanning $ff
	dutycycle $2
	intensity $72
	octave 3
	note __, 2
	callchannel Music_GymLeaderBattleSwSh_Ch1_ditty11
	note __, 3
	callchannel Music_GymLeaderBattleSwSh_Ch1_ditty11
	note __, 1
	jumpif COND_DEFAULT, Music_GymLeaderBattleSwSh_Ch1_NeutralPhase_Loop_2
	jumpif COND_ADVANTAGE, Music_GymLeaderBattleSwSh_Ch1_AdvantagePhase_Loop_2
Music_GymLeaderBattleSwSh_Ch1_DisadvantagePhase_Loop_2:
	stereopanning $ff
	dutycycle $2
	intensity $72
	octave 3
	note __, 2
	callchannel Music_GymLeaderBattleSwSh_Ch1_ditty11
	callchannel Music_GymLeaderBattleSwSh_Ch1_ditty12
	jumpif COND_DEFAULT, Music_GymLeaderBattleSwSh_Ch1_NeutralPhase_Loop_3
	jumpif COND_ADVANTAGE, Music_GymLeaderBattleSwSh_Ch1_AdvantagePhase_Loop_3
Music_GymLeaderBattleSwSh_Ch1_DisadvantagePhase_Loop_3:
	stereopanning $ff
	dutycycle $2
	intensity $72
	octave 3
	note __, 2
	callchannel Music_GymLeaderBattleSwSh_Ch1_ditty11
	note __, 3
	callchannel Music_GymLeaderBattleSwSh_Ch1_ditty11
	note __, 1
	jumpif COND_DEFAULT, Music_GymLeaderBattleSwSh_Ch1_NeutralPhase_Loop_4
	jumpif COND_ADVANTAGE, Music_GymLeaderBattleSwSh_Ch1_AdvantagePhase_Loop_4
Music_GymLeaderBattleSwSh_Ch1_DisadvantagePhase_Loop_4:
	stereopanning $ff
	dutycycle $2
	intensity $72
	octave 3
	note __, 2
	callchannel Music_GymLeaderBattleSwSh_Ch1_ditty11
	callchannel Music_GymLeaderBattleSwSh_Ch1_ditty12
	jumpchannel Music_GymLeaderBattleSwSh_Ch1_DisadvantagePhase_Loop

Music_GymLeaderBattleSwSh_Ch2:
	dutycycle $2
	notetype $c, $b2
	stereopanning $ff
	jumpif COND_FINAL_MON, Music_GymLeaderBattleSwSh_Ch2_EnterLastPokemonPhase
; Neutral Intro
	callchannel Music_GymLeaderBattleSwSh_Ch2_ditty1
	callchannel Music_GymLeaderBattleSwSh_Ch2_ditty1
	note __, 16
	dutycycle $1
	intensity $c7
	octave 3
	callchannel Music_GymLeaderBattleSwSh_Ch2_ditty2
	callchannel Music_GymLeaderBattleSwSh_Ch2_ditty2

;Neutral Loop
Music_GymLeaderBattleSwSh_Ch2_NeutralPhase_Loop:
	jumpif COND_ADVANTAGE, Music_GymLeaderBattleSwSh_Ch2_AdvantagePhase_Loop_1
	jumpif COND_DISADVANTAGE, Music_GymLeaderBattleSwSh_Ch2_DisadvantagePhase_Loop_1
Music_GymLeaderBattleSwSh_Ch2_NeutralPhase_Loop_1:
	stereopanning $ff
	dutycycle $2
	intensity $b2
	octave 3
	note __, 2
	callchannel Music_GymLeaderBattleSwSh_Ch2_ditty4
	jumpif COND_ADVANTAGE, Music_GymLeaderBattleSwSh_Ch2_AdvantagePhase_Loop_2
	jumpif COND_DISADVANTAGE, Music_GymLeaderBattleSwSh_Ch2_DisadvantagePhase_Loop_2
Music_GymLeaderBattleSwSh_Ch2_NeutralPhase_Loop_2:
	stereopanning $ff
	dutycycle $2
	intensity $b2
	octave 3
	note __, 2
	callchannel Music_GymLeaderBattleSwSh_Ch2_ditty3
	jumpif COND_ADVANTAGE, Music_GymLeaderBattleSwSh_Ch2_AdvantagePhase_Loop_3
	jumpif COND_DISADVANTAGE, Music_GymLeaderBattleSwSh_Ch2_DisadvantagePhase_Loop_3
Music_GymLeaderBattleSwSh_Ch2_NeutralPhase_Loop_3:
	stereopanning $f0
	dutycycle $0
	intensity $c7
	vibrato $9, $12
	octave 4
	callchannel Music_GymLeaderBattleSwSh_Ch2_ditty5
	note __, 9
	jumpif COND_ADVANTAGE, Music_GymLeaderBattleSwSh_Ch2_AdvantagePhase_Loop_4
	jumpif COND_DISADVANTAGE, Music_GymLeaderBattleSwSh_Ch2_DisadvantagePhase_Loop_4
Music_GymLeaderBattleSwSh_Ch2_NeutralPhase_Loop_4:
	stereopanning $f0
	dutycycle $0
	intensity $c7
	vibrato $9, $12
	octave 4
	callchannel Music_GymLeaderBattleSwSh_Ch2_ditty5
	note __, 9
	jumpchannel Music_GymLeaderBattleSwSh_Ch2_NeutralPhase_Loop

;Advantage Loop
Music_GymLeaderBattleSwSh_Ch2_AdvantagePhase_Loop:
	jumpif COND_DEFAULT, Music_GymLeaderBattleSwSh_Ch2_NeutralPhase_Loop_1
	jumpif COND_DISADVANTAGE, Music_GymLeaderBattleSwSh_Ch2_DisadvantagePhase_Loop_1
Music_GymLeaderBattleSwSh_Ch2_AdvantagePhase_Loop_1:
	note __, 2
	dutycycle $1
	intensity $c7
	octave 3
	callchannel Music_GymLeaderBattleSwSh_Ch2_ditty7
	note __, 1
	jumpif COND_DEFAULT, Music_GymLeaderBattleSwSh_Ch2_NeutralPhase_Loop_2
	jumpif COND_DISADVANTAGE, Music_GymLeaderBattleSwSh_Ch2_DisadvantagePhase_Loop_2
Music_GymLeaderBattleSwSh_Ch2_AdvantagePhase_Loop_2:
	note __, 2
	dutycycle $1
	intensity $c7
	octave 3
	callchannel Music_GymLeaderBattleSwSh_Ch2_ditty7
	note __, 1
	jumpif COND_DEFAULT, Music_GymLeaderBattleSwSh_Ch2_NeutralPhase_Loop_3
	jumpif COND_DISADVANTAGE, Music_GymLeaderBattleSwSh_Ch2_DisadvantagePhase_Loop_3
Music_GymLeaderBattleSwSh_Ch2_AdvantagePhase_Loop_3:
	dutycycle $2
	intensity $b2
	callchannel Music_GymLeaderBattleSwSh_Ch2_ditty8
	jumpif COND_DEFAULT, Music_GymLeaderBattleSwSh_Ch2_NeutralPhase_Loop_4
	jumpif COND_DISADVANTAGE, Music_GymLeaderBattleSwSh_Ch2_DisadvantagePhase_Loop_4
Music_GymLeaderBattleSwSh_Ch2_AdvantagePhase_Loop_4:
	dutycycle $2
	intensity $b2
	callchannel Music_GymLeaderBattleSwSh_Ch2_ditty8
	jumpchannel Music_GymLeaderBattleSwSh_Ch2_AdvantagePhase_Loop

;Disadvantage Loop
Music_GymLeaderBattleSwSh_Ch2_DisadvantagePhase_Loop:
	jumpif COND_DEFAULT, Music_GymLeaderBattleSwSh_Ch2_NeutralPhase_Loop_1
	jumpif COND_ADVANTAGE, Music_GymLeaderBattleSwSh_Ch2_AdvantagePhase_Loop_1
Music_GymLeaderBattleSwSh_Ch2_DisadvantagePhase_Loop_1:
	stereopanning $f0
	dutycycle $2
	intensity $72
	octave 3
	note __, 2
	callchannel Music_GymLeaderBattleSwSh_Ch2_ditty11
	note __, 3
	callchannel Music_GymLeaderBattleSwSh_Ch2_ditty11
	note __, 1
	jumpif COND_DEFAULT, Music_GymLeaderBattleSwSh_Ch2_NeutralPhase_Loop_2
	jumpif COND_ADVANTAGE, Music_GymLeaderBattleSwSh_Ch2_AdvantagePhase_Loop_2
Music_GymLeaderBattleSwSh_Ch2_DisadvantagePhase_Loop_2:
	stereopanning $f0
	dutycycle $2
	intensity $72
	octave 3
	note __, 2
	callchannel Music_GymLeaderBattleSwSh_Ch2_ditty11
	callchannel Music_GymLeaderBattleSwSh_Ch2_ditty12
	jumpif COND_DEFAULT, Music_GymLeaderBattleSwSh_Ch2_NeutralPhase_Loop_3
	jumpif COND_ADVANTAGE, Music_GymLeaderBattleSwSh_Ch2_AdvantagePhase_Loop_3
Music_GymLeaderBattleSwSh_Ch2_DisadvantagePhase_Loop_3:
	stereopanning $f0
	dutycycle $2
	intensity $72
	octave 3
	note __, 2
	callchannel Music_GymLeaderBattleSwSh_Ch2_ditty11
	note __, 3
	callchannel Music_GymLeaderBattleSwSh_Ch2_ditty11
	note __, 1
	jumpif COND_DEFAULT, Music_GymLeaderBattleSwSh_Ch2_NeutralPhase_Loop_4
	jumpif COND_ADVANTAGE, Music_GymLeaderBattleSwSh_Ch2_AdvantagePhase_Loop_4
Music_GymLeaderBattleSwSh_Ch2_DisadvantagePhase_Loop_4:
	stereopanning $f0
	dutycycle $2
	intensity $72
	octave 3
	note __, 2
	callchannel Music_GymLeaderBattleSwSh_Ch2_ditty11
	callchannel Music_GymLeaderBattleSwSh_Ch2_ditty12
	jumpchannel Music_GymLeaderBattleSwSh_Ch2_DisadvantagePhase_Loop

Music_GymLeaderBattleSwSh_Ch3:
	notetype $c, $11
	stereopanning $ff
	jumpif COND_FINAL_MON, Music_GymLeaderBattleSwSh_Ch3_EnterLastPokemonPhase
; Neutral Intro
	callchannel Music_GymLeaderBattleSwSh_Ch3_ditty1
	callchannel Music_GymLeaderBattleSwSh_Ch3_ditty1
	octave 1
	note G_, 8
	note __, 4
	octave 3
	slidepitchto 1, 5, C_
	note G_, 4
	octave 2
	callchannel Music_GymLeaderBattleSwSh_Ch3_ditty2
	callchannel Music_GymLeaderBattleSwSh_Ch3_ditty2

;Neutral Loop
Music_GymLeaderBattleSwSh_Ch3_NeutralPhase_Loop:
	jumpif COND_ADVANTAGE, Music_GymLeaderBattleSwSh_Ch3_AdvantagePhase_Loop_1
	jumpif COND_DISADVANTAGE, Music_GymLeaderBattleSwSh_Ch3_DisadvantagePhase_Loop_1
Music_GymLeaderBattleSwSh_Ch3_NeutralPhase_Loop_1:
	callchannel Music_GymLeaderBattleSwSh_Ch3_ditty3
	callchannel Music_GymLeaderBattleSwSh_Ch3_ditty3
	jumpif COND_ADVANTAGE, Music_GymLeaderBattleSwSh_Ch3_AdvantagePhase_Loop_2
	jumpif COND_DISADVANTAGE, Music_GymLeaderBattleSwSh_Ch3_DisadvantagePhase_Loop_2
Music_GymLeaderBattleSwSh_Ch3_NeutralPhase_Loop_2:
	callchannel Music_GymLeaderBattleSwSh_Ch3_ditty3
	callchannel Music_GymLeaderBattleSwSh_Ch3_ditty3
	jumpif COND_ADVANTAGE, Music_GymLeaderBattleSwSh_Ch3_AdvantagePhase_Loop_3
	jumpif COND_DISADVANTAGE, Music_GymLeaderBattleSwSh_Ch3_DisadvantagePhase_Loop_3
Music_GymLeaderBattleSwSh_Ch3_NeutralPhase_Loop_3:
	callchannel Music_GymLeaderBattleSwSh_Ch3_ditty3
	callchannel Music_GymLeaderBattleSwSh_Ch3_ditty3
	jumpif COND_ADVANTAGE, Music_GymLeaderBattleSwSh_Ch3_AdvantagePhase_Loop_4
	jumpif COND_DISADVANTAGE, Music_GymLeaderBattleSwSh_Ch3_DisadvantagePhase_Loop_4
Music_GymLeaderBattleSwSh_Ch3_NeutralPhase_Loop_4:
	callchannel Music_GymLeaderBattleSwSh_Ch3_ditty3
	callchannel Music_GymLeaderBattleSwSh_Ch3_ditty3
	jumpchannel Music_GymLeaderBattleSwSh_Ch3_NeutralPhase_Loop

;Advantage Loop
Music_GymLeaderBattleSwSh_Ch3_AdvantagePhase_Loop:
	jumpif COND_DEFAULT, Music_GymLeaderBattleSwSh_Ch3_NeutralPhase_Loop_1
	jumpif COND_DISADVANTAGE, Music_GymLeaderBattleSwSh_Ch3_DisadvantagePhase_Loop_1
Music_GymLeaderBattleSwSh_Ch3_AdvantagePhase_Loop_1:
	callchannel Music_GymLeaderBattleSwSh_Ch3_ditty5
	jumpif COND_DEFAULT, Music_GymLeaderBattleSwSh_Ch3_NeutralPhase_Loop_2
	jumpif COND_DISADVANTAGE, Music_GymLeaderBattleSwSh_Ch3_DisadvantagePhase_Loop_2
Music_GymLeaderBattleSwSh_Ch3_AdvantagePhase_Loop_2:
	callchannel Music_GymLeaderBattleSwSh_Ch3_ditty5
	jumpif COND_DEFAULT, Music_GymLeaderBattleSwSh_Ch3_NeutralPhase_Loop_3
	jumpif COND_DISADVANTAGE, Music_GymLeaderBattleSwSh_Ch3_DisadvantagePhase_Loop_3
Music_GymLeaderBattleSwSh_Ch3_AdvantagePhase_Loop_3:
	callchannel Music_GymLeaderBattleSwSh_Ch3_ditty5
	jumpif COND_DEFAULT, Music_GymLeaderBattleSwSh_Ch3_NeutralPhase_Loop_4
	jumpif COND_DISADVANTAGE, Music_GymLeaderBattleSwSh_Ch3_DisadvantagePhase_Loop_4
Music_GymLeaderBattleSwSh_Ch3_AdvantagePhase_Loop_4:
	callchannel Music_GymLeaderBattleSwSh_Ch3_ditty5
	jumpchannel Music_GymLeaderBattleSwSh_Ch3_AdvantagePhase_Loop

;Disadvantage Loop
Music_GymLeaderBattleSwSh_Ch3_DisadvantagePhase_Loop:
	jumpif COND_DEFAULT, Music_GymLeaderBattleSwSh_Ch3_NeutralPhase_Loop_1
	jumpif COND_ADVANTAGE, Music_GymLeaderBattleSwSh_Ch3_AdvantagePhase_Loop_1
Music_GymLeaderBattleSwSh_Ch3_DisadvantagePhase_Loop_1:
	intensity $23
	callchannel Music_GymLeaderBattleSwSh_Ch3_ditty8
	callchannel Music_GymLeaderBattleSwSh_Ch3_ditty9
	callchannel Music_GymLeaderBattleSwSh_Ch3_ditty8
	callchannel Music_GymLeaderBattleSwSh_Ch3_ditty10
	callchannel Music_GymLeaderBattleSwSh_Ch3_ditty8
	callchannel Music_GymLeaderBattleSwSh_Ch3_ditty9
	callchannel Music_GymLeaderBattleSwSh_Ch3_ditty8
	callchannel Music_GymLeaderBattleSwSh_Ch3_ditty10
	jumpif COND_DEFAULT, Music_GymLeaderBattleSwSh_Ch3_NeutralPhase_Loop_2
	jumpif COND_ADVANTAGE, Music_GymLeaderBattleSwSh_Ch3_AdvantagePhase_Loop_2
Music_GymLeaderBattleSwSh_Ch3_DisadvantagePhase_Loop_2:
	intensity $23
	callchannel Music_GymLeaderBattleSwSh_Ch3_ditty8
	callchannel Music_GymLeaderBattleSwSh_Ch3_ditty9
	callchannel Music_GymLeaderBattleSwSh_Ch3_ditty8
	callchannel Music_GymLeaderBattleSwSh_Ch3_ditty10
	callchannel Music_GymLeaderBattleSwSh_Ch3_ditty8
	callchannel Music_GymLeaderBattleSwSh_Ch3_ditty9
	callchannel Music_GymLeaderBattleSwSh_Ch3_ditty8
	callchannel Music_GymLeaderBattleSwSh_Ch3_ditty10
	jumpif COND_DEFAULT, Music_GymLeaderBattleSwSh_Ch3_NeutralPhase_Loop_3
	jumpif COND_ADVANTAGE, Music_GymLeaderBattleSwSh_Ch3_AdvantagePhase_Loop_3
Music_GymLeaderBattleSwSh_Ch3_DisadvantagePhase_Loop_3:
	intensity $23
	callchannel Music_GymLeaderBattleSwSh_Ch3_ditty8
	callchannel Music_GymLeaderBattleSwSh_Ch3_ditty9
	callchannel Music_GymLeaderBattleSwSh_Ch3_ditty8
	callchannel Music_GymLeaderBattleSwSh_Ch3_ditty10
	callchannel Music_GymLeaderBattleSwSh_Ch3_ditty8
	callchannel Music_GymLeaderBattleSwSh_Ch3_ditty9
	callchannel Music_GymLeaderBattleSwSh_Ch3_ditty8
	callchannel Music_GymLeaderBattleSwSh_Ch3_ditty10
	jumpif COND_DEFAULT, Music_GymLeaderBattleSwSh_Ch3_NeutralPhase_Loop_4
	jumpif COND_ADVANTAGE, Music_GymLeaderBattleSwSh_Ch3_AdvantagePhase_Loop_4
Music_GymLeaderBattleSwSh_Ch3_DisadvantagePhase_Loop_4:
	intensity $23
	callchannel Music_GymLeaderBattleSwSh_Ch3_ditty8
	callchannel Music_GymLeaderBattleSwSh_Ch3_ditty9
	callchannel Music_GymLeaderBattleSwSh_Ch3_ditty8
	callchannel Music_GymLeaderBattleSwSh_Ch3_ditty10
	callchannel Music_GymLeaderBattleSwSh_Ch3_ditty8
	callchannel Music_GymLeaderBattleSwSh_Ch3_ditty9
	callchannel Music_GymLeaderBattleSwSh_Ch3_ditty8
	callchannel Music_GymLeaderBattleSwSh_Ch3_ditty10
	jumpchannel Music_GymLeaderBattleSwSh_Ch3_DisadvantagePhase_Loop

Music_GymLeaderBattleSwSh_Ch4:
	notetype $c
	togglenoise $4
	stereopanning $ff
	jumpif COND_FINAL_MON, Music_GymLeaderBattleSwSh_Ch4_EnterLastPokemonPhase
; Neutral Intro
	callchannel Music_GymLeaderBattleSwSh_Ch4_ditty1
	callchannel Music_GymLeaderBattleSwSh_Ch4_ditty1
	note C#, 1
	note C#, 1
	note C#, 1
	note C#, 1
	note C#, 1
	note C#, 11
	callchannel Music_GymLeaderBattleSwSh_Ch4_ditty2
	callchannel Music_GymLeaderBattleSwSh_Ch4_ditty2

;Neutral Loop
Music_GymLeaderBattleSwSh_Ch4_NeutralPhase_Loop:
	jumpif COND_ADVANTAGE, Music_GymLeaderBattleSwSh_Ch4_AdvantagePhase_Loop_1
	jumpif COND_DISADVANTAGE, Music_GymLeaderBattleSwSh_Ch4_DisadvantagePhase_Loop_1
Music_GymLeaderBattleSwSh_Ch4_NeutralPhase_Loop_1:
	callchannel Music_GymLeaderBattleSwSh_Ch4_ditty3
	jumpif COND_ADVANTAGE, Music_GymLeaderBattleSwSh_Ch4_AdvantagePhase_Loop_2
	jumpif COND_DISADVANTAGE, Music_GymLeaderBattleSwSh_Ch4_DisadvantagePhase_Loop_2
Music_GymLeaderBattleSwSh_Ch4_NeutralPhase_Loop_2:
	callchannel Music_GymLeaderBattleSwSh_Ch4_ditty3
	jumpif COND_ADVANTAGE, Music_GymLeaderBattleSwSh_Ch4_AdvantagePhase_Loop_3
	jumpif COND_DISADVANTAGE, Music_GymLeaderBattleSwSh_Ch4_DisadvantagePhase_Loop_3
Music_GymLeaderBattleSwSh_Ch4_NeutralPhase_Loop_3:
	callchannel Music_GymLeaderBattleSwSh_Ch4_ditty4
	jumpif COND_ADVANTAGE, Music_GymLeaderBattleSwSh_Ch4_AdvantagePhase_Loop_4
	jumpif COND_DISADVANTAGE, Music_GymLeaderBattleSwSh_Ch4_DisadvantagePhase_Loop_4
Music_GymLeaderBattleSwSh_Ch4_NeutralPhase_Loop_4:
	callchannel Music_GymLeaderBattleSwSh_Ch4_ditty4
	jumpchannel Music_GymLeaderBattleSwSh_Ch4_NeutralPhase_Loop

;Advantage Loop
Music_GymLeaderBattleSwSh_Ch4_AdvantagePhase_Loop:
	jumpif COND_DEFAULT, Music_GymLeaderBattleSwSh_Ch4_NeutralPhase_Loop_1
	jumpif COND_DISADVANTAGE, Music_GymLeaderBattleSwSh_Ch4_DisadvantagePhase_Loop_1
Music_GymLeaderBattleSwSh_Ch4_AdvantagePhase_Loop_1:
	callchannel Music_GymLeaderBattleSwSh_Ch4_ditty3
	jumpif COND_DEFAULT, Music_GymLeaderBattleSwSh_Ch4_NeutralPhase_Loop_2
	jumpif COND_DISADVANTAGE, Music_GymLeaderBattleSwSh_Ch4_DisadvantagePhase_Loop_2
Music_GymLeaderBattleSwSh_Ch4_AdvantagePhase_Loop_2:
	callchannel Music_GymLeaderBattleSwSh_Ch4_ditty3
	jumpif COND_DEFAULT, Music_GymLeaderBattleSwSh_Ch4_NeutralPhase_Loop_3
	jumpif COND_DISADVANTAGE, Music_GymLeaderBattleSwSh_Ch4_DisadvantagePhase_Loop_3
Music_GymLeaderBattleSwSh_Ch4_AdvantagePhase_Loop_3:
	callchannel Music_GymLeaderBattleSwSh_Ch4_ditty6
	jumpif COND_DEFAULT, Music_GymLeaderBattleSwSh_Ch4_NeutralPhase_Loop_4
	jumpif COND_DISADVANTAGE, Music_GymLeaderBattleSwSh_Ch4_DisadvantagePhase_Loop_4
Music_GymLeaderBattleSwSh_Ch4_AdvantagePhase_Loop_4:
	callchannel Music_GymLeaderBattleSwSh_Ch4_ditty6
	jumpchannel Music_GymLeaderBattleSwSh_Ch4_AdvantagePhase_Loop

;Disadvantage Loop
Music_GymLeaderBattleSwSh_Ch4_DisadvantagePhase_Loop:
	jumpif COND_DEFAULT, Music_GymLeaderBattleSwSh_Ch4_NeutralPhase_Loop_1
	jumpif COND_ADVANTAGE, Music_GymLeaderBattleSwSh_Ch4_AdvantagePhase_Loop_1
Music_GymLeaderBattleSwSh_Ch4_DisadvantagePhase_Loop_1:
	callchannel Music_GymLeaderBattleSwSh_Ch4_ditty8
	callchannel Music_GymLeaderBattleSwSh_Ch4_ditty8
	callchannel Music_GymLeaderBattleSwSh_Ch4_ditty8
	callchannel Music_GymLeaderBattleSwSh_Ch4_ditty8
	jumpif COND_DEFAULT, Music_GymLeaderBattleSwSh_Ch4_NeutralPhase_Loop_2
	jumpif COND_ADVANTAGE, Music_GymLeaderBattleSwSh_Ch4_AdvantagePhase_Loop_2
Music_GymLeaderBattleSwSh_Ch4_DisadvantagePhase_Loop_2:
	callchannel Music_GymLeaderBattleSwSh_Ch4_ditty8
	callchannel Music_GymLeaderBattleSwSh_Ch4_ditty8
	callchannel Music_GymLeaderBattleSwSh_Ch4_ditty8
	callchannel Music_GymLeaderBattleSwSh_Ch4_ditty8
	jumpif COND_DEFAULT, Music_GymLeaderBattleSwSh_Ch4_NeutralPhase_Loop_3
	jumpif COND_ADVANTAGE, Music_GymLeaderBattleSwSh_Ch4_AdvantagePhase_Loop_3
Music_GymLeaderBattleSwSh_Ch4_DisadvantagePhase_Loop_3:
	callchannel Music_GymLeaderBattleSwSh_Ch4_ditty8
	callchannel Music_GymLeaderBattleSwSh_Ch4_ditty8
	callchannel Music_GymLeaderBattleSwSh_Ch4_ditty8
	callchannel Music_GymLeaderBattleSwSh_Ch4_ditty8
	jumpif COND_DEFAULT, Music_GymLeaderBattleSwSh_Ch4_NeutralPhase_Loop_4
	jumpif COND_ADVANTAGE, Music_GymLeaderBattleSwSh_Ch4_AdvantagePhase_Loop_4
Music_GymLeaderBattleSwSh_Ch4_DisadvantagePhase_Loop_4:
	callchannel Music_GymLeaderBattleSwSh_Ch4_ditty8
	callchannel Music_GymLeaderBattleSwSh_Ch4_ditty8
	callchannel Music_GymLeaderBattleSwSh_Ch4_ditty8
	callchannel Music_GymLeaderBattleSwSh_Ch4_ditty8
	jumpchannel Music_GymLeaderBattleSwSh_Ch4_DisadvantagePhase_Loop

; Advantage/Last Pokemon Intros - This could be its own song.

; Advantage/Last Pokemon Intro
Music_GymLeaderBattleSwSh_Ch2_EnterLastPokemonPhase:
	dutycycle $1
	intensity $a8
	vibrato $0, $0
	octave 3
	stereopanning $f0
	;slidepitchto 1, 5, G_
	note __, 16
	;slidepitchto 1, 4, C_
	note __, 16
	;slidepitchto 1, 4, F#
	octave 4
	note __, 16
	note __, 8
	intensity $1C
	vibrato $1, $21
	octave 4
	note G_, 8
	dutycycle $3
	intensity $c1
	vibrato $0, $0
	callchannel Music_GymLeaderBattleSwSh_Ch2_ditty6
	note B_, 2
	octave 4
	callchannel Music_GymLeaderBattleSwSh_Ch2_ditty6
	note B_, 2
;Last Pokemon Loop
Music_GymLeaderBattleSwSh_Ch2_LastPokemonPhase_Loop:
	dutycycle $1
	intensity $c4
	stereopanning $ff
	callchannel Music_GymLeaderBattleSwSh_Ch2_ditty9
	callchannel Music_GymLeaderBattleSwSh_Ch2_ditty9
	callchannel Music_GymLeaderBattleSwSh_Ch2_ditty9
	octave 5
	note D_, 8
	octave 4
	note B_, 4
	note G_, 2
	octave 5
	note D_, 6
	note __, 6
	note D_, 4
	octave 4
	note G_, 2
	octave 5
	note E_, 2
	note D_, 8
	octave 4
	note B_, 2
	note A_, 2
	note G_, 6
	note __, 12
	dutycycle $2
	intensity $b2
	octave 3
	callchannel Music_GymLeaderBattleSwSh_Ch2_ditty10
	callchannel Music_GymLeaderBattleSwSh_Ch2_ditty10
	callchannel Music_GymLeaderBattleSwSh_Ch2_ditty10
	callchannel Music_GymLeaderBattleSwSh_Ch2_ditty10
	callchannel Music_GymLeaderBattleSwSh_Ch2_ditty10
	callchannel Music_GymLeaderBattleSwSh_Ch2_ditty10
	jumpchannel Music_GymLeaderBattleSwSh_Ch2_LastPokemonPhase_Loop

; Advantage/Last Pokemon Intro
Music_GymLeaderBattleSwSh_Ch1_EnterLastPokemonPhase:
	dutycycle $1
	intensity $a8
	vibrato $0, $0
	octave 2
	stereopanning $0f
	;slidepitchto 1, 5, G_
	note __, 16
	;slidepitchto 1, 4, C_
	note __, 16
	;slidepitchto 1, 4, F#
	octave 3
	note __, 16
	note __, 8
	intensity $1C
	vibrato $1, $21
	octave 3
	note G_, 8
	dutycycle $3
	intensity $c1
	vibrato $0, $0
	callchannel Music_GymLeaderBattleSwSh_Ch1_ditty4
	callchannel Music_GymLeaderBattleSwSh_Ch1_ditty5
;Last Pokemon Loop
Music_GymLeaderBattleSwSh_Ch1_LastPokemonPhase_Loop:
	note __, 2
	dutycycle $1
	intensity $c7
	stereopanning $ff
	callchannel Music_GymLeaderBattleSwSh_Ch2_ditty7
	note __, 3
	callchannel Music_GymLeaderBattleSwSh_Ch2_ditty7
	note __, 1
	dutycycle $2
	intensity $b2
	callchannel Music_GymLeaderBattleSwSh_Ch2_ditty8
	callchannel Music_GymLeaderBattleSwSh_Ch2_ditty8
	dutycycle $1
	intensity $c4
	octave 4
	callchannel Music_GymLeaderBattleSwSh_Ch1_ditty8
	callchannel Music_GymLeaderBattleSwSh_Ch1_ditty8
	callchannel Music_GymLeaderBattleSwSh_Ch1_ditty9
	callchannel Music_GymLeaderBattleSwSh_Ch1_ditty9
	callchannel Music_GymLeaderBattleSwSh_Ch1_ditty10
	octave 4
	callchannel Music_GymLeaderBattleSwSh_Ch1_ditty10
	jumpchannel Music_GymLeaderBattleSwSh_Ch1_LastPokemonPhase_Loop


; Advantage/Last Pokemon Intro
Music_GymLeaderBattleSwSh_Ch3_EnterLastPokemonPhase:
	note __, 16
	note __, 16
	note __, 16
	note __, 16
	octave 2
	callchannel Music_GymLeaderBattleSwSh_Ch3_ditty4
	callchannel Music_GymLeaderBattleSwSh_Ch3_ditty4
;Last Pokemon Loop
Music_GymLeaderBattleSwSh_Ch3_LastPokemonPhase_Loop:
	callchannel Music_GymLeaderBattleSwSh_Ch3_ditty5
	callchannel Music_GymLeaderBattleSwSh_Ch3_ditty5
	callchannel Music_GymLeaderBattleSwSh_Ch3_ditty5
	callchannel Music_GymLeaderBattleSwSh_Ch3_ditty5
	callchannel Music_GymLeaderBattleSwSh_Ch3_ditty6
	callchannel Music_GymLeaderBattleSwSh_Ch3_ditty6
	callchannel Music_GymLeaderBattleSwSh_Ch3_ditty6
	callchannel Music_GymLeaderBattleSwSh_Ch3_ditty6
	callchannel Music_GymLeaderBattleSwSh_Ch3_ditty7
	callchannel Music_GymLeaderBattleSwSh_Ch3_ditty7
	jumpchannel Music_GymLeaderBattleSwSh_Ch3_LastPokemonPhase_Loop


; Advantage/Last Pokemon Intro
Music_GymLeaderBattleSwSh_Ch4_EnterLastPokemonPhase:
	callchannel Music_GymLeaderBattleSwSh_Ch4_ditty5
	callchannel Music_GymLeaderBattleSwSh_Ch4_ditty2
	callchannel Music_GymLeaderBattleSwSh_Ch4_ditty2
;Last Pokemon Loop
Music_GymLeaderBattleSwSh_Ch4_LastPokemonPhase_Loop:
	callchannel Music_GymLeaderBattleSwSh_Ch4_ditty3
	callchannel Music_GymLeaderBattleSwSh_Ch4_ditty3
	callchannel Music_GymLeaderBattleSwSh_Ch4_ditty6
	callchannel Music_GymLeaderBattleSwSh_Ch4_ditty6
	callchannel Music_GymLeaderBattleSwSh_Ch4_ditty7
	callchannel Music_GymLeaderBattleSwSh_Ch4_ditty7
	callchannel Music_GymLeaderBattleSwSh_Ch4_ditty7
	callchannel Music_GymLeaderBattleSwSh_Ch4_ditty7
	callchannel Music_GymLeaderBattleSwSh_Ch4_ditty7
	callchannel Music_GymLeaderBattleSwSh_Ch4_ditty7
	jumpchannel Music_GymLeaderBattleSwSh_Ch4_LastPokemonPhase_Loop

Music_GymLeaderBattleSwSh_Ch2_ditty1:
	octave 3
	note G_, 1
	note __, 1
	note G_, 2
	note __, 1
	note G_, 2
	note G#, 1
	note G_, 1
	note __, 1
	note G_, 2
	note __, 1
	note G_, 2
	note G#, 1
	note G_, 1
	note __, 1
	note G_, 2
	note __, 1
	note G_, 2
	note G#, 1
	note G_, 1
	note __, 1
	note G_, 2
	note __, 1
	note G_, 2
	note G#, 1
	octave 4
	note D_, 1
	note __, 1
	note D_, 2
	note __, 1
	note D_, 2
	note D#, 1
	note D_, 1
	note __, 1
	note D_, 2
	note __, 1
	note D_, 2
	note D#, 1
	note D_, 1
	note __, 1
	note D_, 2
	note __, 1
	note D_, 2
	note D#, 1
	note D_, 1
	note __, 1
	note D_, 2
	note __, 1
	note D_, 2
	note D#, 1
	endchannel

Music_GymLeaderBattleSwSh_Ch2_ditty2:
	note G_, 3
	note __, 1
	note G_, 3
	note __, 1
	note A#, 2
	note __, 1
	note A_, 2
	note __, 1
	note A#, 1
	note __, 3
	dutycycle $2
	intensity $b2
	note G_, 1
	note G_, 1
	note G_, 1
	note G_, 1
	note G_, 1
	note G_, 1
	dutycycle $1
	intensity $c7
	note A#, 2
	note __, 1
	note A_, 2
	note __, 1
	note A#, 1
	note __, 1
	octave 4
	note D_, 3
	note __, 1
	note D_, 1
	note __, 1
	note D_, 1
	note __, 1
	note D#, 2
	note __, 1
	note C_, 2
	note __, 1
	note D_, 4
	dutycycle $2
	intensity $b2
	octave 3
	note A#, 1
	note A#, 1
	note A#, 1
	note A#, 1
	note A#, 1
	note A#, 1
	dutycycle $1
	intensity $c7
	octave 4
	note C_, 2
	note __, 1
	octave 3
	note A_, 2
	note __, 1
	note A#, 1
	note __, 1
	endchannel

Music_GymLeaderBattleSwSh_Ch2_ditty3:
	note G_, 1
	note __, 3
	note G_, 1
	note __, 3
	note G#, 1
	note __, 3
	note G_, 1
	note __, 3
	note G_, 1
	note __, 3
	note G_, 1
	note __, 3
	note A#, 1
	note __, 3
	note A#, 1
	note __, 3
	note G_, 1
	note __, 3
	note G_, 1
	note __, 3
	note G#, 1
	note __, 3
	note G_, 1
	note __, 3
	note G_, 1
	note __, 3
	note G_, 1
	note __, 3
	note A#, 1
	note __, 3
	note A#, 1
	note __, 1
	endchannel

Music_GymLeaderBattleSwSh_Ch2_ditty4:
	note G_, 1
	note __, 3
	note G_, 1
	note __, 3
	note G#, 1
	note __, 3
	note G_, 1
	note __, 3
	note G_, 1
	note __, 3
	note G_, 1
	note __, 3
	note A#, 1
	note __, 3
	note A#, 1
	note __, 3
	note G_, 1
	note __, 3
	note G_, 1
	note __, 3
	note G#, 1
	note __, 3
	note G_, 1
	note __, 3
	note G_, 1
	note __, 3
	note G_, 1
	note __, 3
	note A#, 1
	note __, 3
	note A#, 1
	note __, 1
	endchannel

Music_GymLeaderBattleSwSh_Ch2_ditty5:
	note A#, 1
	note __, 1
	note A#, 1
	note G_, 1
	note __, 1
	stereopanning $0f
	note G_, 1
	note G_, 1
	note __, 9
	note A#, 1
	note __, 1
	note A#, 1
	note G_, 1
	note __, 1
	stereopanning $f0
	note G_, 1
	note G_, 1
	note __, 9
	note A#, 1
	note __, 1
	note A#, 1
	note G_, 1
	note __, 1
	stereopanning $0f
	note G_, 1
	note G_, 1
	note __, 1
	octave 5
	note C_, 1
	note __, 1
	note C_, 1
	octave 4
	note A#, 1
	note __, 1
	note A#, 1
	stereopanning $f0
	note A_, 1
	note __, 1
	note A#, 1
	note __, 1
	note A#, 1
	note G_, 1
	note __, 1
	stereopanning $0f
	note G_, 1
	note G_, 1
	endchannel

Music_GymLeaderBattleSwSh_Ch2_ditty6:
	note D_, 3
	note __, 1
	note D_, 3
	note __, 1
	octave 3
	note B_, 2
	note __, 1
	note A_, 2
	note __, 1
	note B_, 1
	note __, 3
	note B_, 1
	note B_, 1
	note B_, 1
	note B_, 1
	note B_, 1
	note B_, 1
	note B_, 1
	note __, 2
	note A_, 2
	note __, 1
	note B_, 1
	note __, 1
	octave 4
	note D_, 2
	note __, 2
	note D_, 1
	note __, 1
	note D_, 2
	note E_, 2
	note __, 1
	note C_, 2
	note __, 1
	note D_, 4
	octave 3
	note B_, 1
	note B_, 1
	note B_, 1
	note B_, 1
	note B_, 1
	note B_, 1
	octave 4
	note C_, 2
	note __, 1
	octave 3
	note A_, 2
	note __, 1
	endchannel

Music_GymLeaderBattleSwSh_Ch2_ditty7:
	note G_, 1
	note __, 3
	note G_, 1
	note __, 3
	note A_, 1
	note __, 3
	note F_, 1
	note __, 3
	note G_, 1
	note __, 3
	note G_, 1
	note __, 3
	note B_, 1
	note __, 3
	note B_, 1
	note __, 3
	note G_, 1
	note __, 3
	note G_, 1
	note __, 3
	note A_, 1
	note __, 3
	note F_, 1
	note __, 3
	note G_, 1
	note __, 3
	note G_, 1
	note __, 3
	note B_, 1
	note __, 3
	note B_, 1
	endchannel

Music_GymLeaderBattleSwSh_Ch2_ditty8:
	octave 4
	note B_, 1
	note __, 2
	note G_, 1
	note __, 2
	note G_, 1
	note __, 3
	octave 3
	note A_, 1
	note __, 3
	note F_, 1
	note __, 1
	octave 4
	note B_, 1
	note __, 2
	note G_, 1
	note __, 2
	note G_, 1
	note __, 3
	octave 3
	note B_, 1
	note __, 3
	note B_, 1
	note __, 1
	octave 4
	note B_, 1
	note __, 2
	note G_, 1
	note __, 2
	note G_, 1
	note __, 1
	note A_, 1
	note __, 2
	note G_, 1
	note __, 2
	note G_, 1
	note __, 1
	note B_, 1
	note __, 2
	note A_, 1
	note __, 2
	note A_, 1
	note __, 3
	octave 3
	note B_, 1
	note __, 3
	note B_, 1
	note __, 1
	endchannel

Music_GymLeaderBattleSwSh_Ch2_ditty9:
	octave 5
	note D_, 8
	octave 4
	note B_, 4
	note G_, 2
	octave 5
	note D_, 6
	note __, 6
	note D_, 4
	octave 4
	note G_, 2
	octave 5
	note E_, 2
	note D_, 8
	octave 4
	note B_, 2
	note G_, 2
	note A_, 6
	note __, 6
	note G_, 2
	note A_, 2
	note G_, 2
	endchannel

Music_GymLeaderBattleSwSh_Ch2_ditty10:
	note G_, 2
	note __, 6
	note G_, 2
	note __, 6
	note G_, 2
	note __, 2
	note G_, 2
	note __, 2
	note G_, 2
	note __, 2
	note G_, 2
	note __, 2
	note G_, 2
	note __, 6
	note G_, 2
	note __, 6
	note G_, 2
	note __, 2
	note G_, 2
	note __, 2
	note G_, 2
	note __, 2
	note G_, 2
	note __, 2
	endchannel

Music_GymLeaderBattleSwSh_Ch2_ditty11:
	note D_, 1
	note __, 3
	note D_, 1
	note __, 3
	note D#, 1
	note __, 3
	note D_, 1
	note __, 3
	note D_, 1
	note __, 3
	note D_, 1
	note __, 3
	note F_, 1
	note __, 3
	note F_, 1
	endchannel

Music_GymLeaderBattleSwSh_Ch2_ditty12:
	note __, 3
	note D_, 1
	note __, 3
	note D_, 1
	note __, 3
	note D#, 1
	note __, 3
	note D_, 1
	note __, 3
	note D_, 1
	note __, 3
	note D_, 1
	note __, 3
	intensity $0F
	note F_, 6
	endchannel

Music_GymLeaderBattleSwSh_Ch1_ditty1:
	note D_, 1
	note __, 1
	octave 2
	note G_, 1
	octave 3
	note D_, 1
	note __, 1
	octave 2
	note G_, 1
	octave 3
	note D_, 1
	note D#, 1
	note D_, 1
	note __, 1
	octave 2
	note G_, 1
	octave 3
	note D_, 1
	note __, 1
	octave 2
	note G_, 1
	octave 3
	note D_, 1
	note D#, 1
	note D_, 1
	note __, 1
	octave 2
	note G_, 1
	octave 3
	note D_, 1
	note __, 1
	octave 2
	note G_, 1
	octave 3
	note D_, 1
	note D#, 1
	note D_, 1
	note __, 1
	octave 2
	note G_, 1
	octave 3
	note D_, 1
	note __, 1
	octave 2
	note G_, 1
	octave 3
	note D_, 1
	note D#, 1
	note G_, 1
	note __, 1
	note D_, 1
	note G_, 1
	note __, 1
	note D_, 1
	note G_, 1
	note G#, 1
	note G_, 1
	note __, 1
	note D_, 1
	note G_, 1
	note __, 1
	note D_, 1
	note G_, 1
	note G#, 1
	note G_, 1
	note __, 1
	note D_, 1
	note G_, 1
	note __, 1
	note D_, 1
	note G_, 1
	note G#, 1
	note G_, 1
	note __, 1
	note D_, 1
	note G_, 1
	note __, 1
	note D_, 1
	note G_, 1
	note G#, 1
	endchannel

Music_GymLeaderBattleSwSh_Ch1_ditty2:
	stereopanning $0f
	octave 4
	note G_, 3
	note __, 1
	note G_, 3
	note __, 1
	note A#, 2
	note __, 1
	note A_, 2
	note __, 1
	note A#, 1
	note __, 3
	note G_, 1
	note G_, 1
	note G_, 1
	note G_, 1
	note G_, 1
	note G_, 1
	note A#, 2
	note __, 1
	note A_, 2
	note __, 1
	note A#, 1
	note __, 1
	dutycycle $1
	intensity $c7
	octave 3
	note G_, 3
	note __, 1
	note G_, 1
	note __, 1
	note G_, 1
	note __, 1
	note F_, 2
	note __, 1
	note F_, 2
	note __, 1
	note G_, 4
	dutycycle $2
	intensity $b2
	note G_, 1
	note G_, 1
	note G_, 1
	note G_, 1
	note G_, 1
	note G_, 1
	dutycycle $1
	intensity $c7
	note F_, 2
	note __, 1
	note F_, 2
	note __, 1
	note F_, 1
	endchannel

Music_GymLeaderBattleSwSh_Ch1_ditty3:
	note D_, 1
	note __, 3
	note D_, 1
	note __, 3
	note D#, 1
	note __, 3
	note D_, 1
	note __, 3
	note D_, 1
	note __, 3
	note D_, 1
	note __, 3
	note F_, 1
	note __, 3
	note F_, 1
	note __, 3
	note D_, 1
	note __, 3
	note D_, 1
	note __, 3
	note D#, 1
	note __, 3
	note D_, 1
	note __, 3
	note D_, 1
	note __, 3
	note D_, 1
	note __, 3
	note F_, 1
	note __, 3
	note F_, 1
	note __, 1
	endchannel

Music_GymLeaderBattleSwSh_Ch1_ditty4:
	note G_, 3
	note __, 1
	note G_, 3
	note __, 1
	note G_, 2
	note __, 1
	note D_, 2
	note __, 1
	note G_, 1
	note __, 3
	note G_, 1
	note G_, 1
	note G_, 1
	note G_, 1
	note G_, 1
	note G_, 1
	note G_, 1
	note __, 2
	note D_, 2
	note __, 1
	note G_, 1
	note __, 1
	note G_, 2
	note __, 2
	note G_, 1
	note __, 1
	note G_, 2
	note G_, 2
	note __, 1
	note G_, 2
	note __, 1
	note G_, 1
	note __, 3
	note G_, 1
	note G_, 1
	note G_, 1
	note G_, 1
	note G_, 1
	note G_, 1
	note G_, 1
	note __, 2
	note D_, 2
	note __, 1
	note G_, 2
	endchannel

Music_GymLeaderBattleSwSh_Ch1_ditty5:
	note G_, 3
	note __, 1
	note G_, 3
	note __, 1
	note G_, 2
	note __, 1
	note D_, 2
	note __, 1
	note G_, 1
	note __, 3
	note G_, 1
	note G_, 1
	note G_, 1
	note G_, 1
	note G_, 1
	note G_, 1
	note G_, 1
	note __, 2
	note D_, 2
	note __, 1
	note G_, 1
	note __, 1
	note G_, 2
	note __, 2
	note G_, 1
	note __, 1
	note G_, 2
	note G_, 2
	note __, 1
	note G_, 2
	note __, 1
	note G_, 1
	note __, 3
	note G_, 1
	note G_, 1
	note G_, 1
	note G_, 1
	note G_, 1
	note G_, 1
	note G_, 1
	note __, 2
	note D_, 2
	note __, 1
	note G_, 2
	endchannel

Music_GymLeaderBattleSwSh_Ch1_ditty6:
	note D_, 1
	note __, 3
	note D_, 1
	note __, 3
	note F_, 1
	note __, 3
	note D_, 1
	note __, 3
	note D_, 1
	note __, 3
	note D_, 1
	note __, 3
	note G_, 1
	note __, 3
	note G_, 1
	note __, 3
	note D_, 1
	note __, 3
	note D_, 1
	note __, 3
	note F_, 1
	note __, 3
	note D_, 1
	note __, 3
	note D_, 1
	note __, 3
	note D_, 1
	note __, 3
	note G_, 1
	note __, 3
	note G_, 1
	endchannel

Music_GymLeaderBattleSwSh_Ch1_ditty7:
	octave 4
	note G_, 1
	note __, 2
	note D_, 1
	note __, 2
	note D_, 1
	note __, 3
	octave 3
	note F_, 1
	note __, 3
	note D_, 1
	note __, 1
	octave 4
	note G_, 1
	note __, 2
	note D_, 1
	note __, 2
	note D_, 1
	note __, 3
	octave 3
	note G_, 1
	note __, 3
	note G_, 1
	note __, 1
	octave 4
	note G_, 1
	note __, 2
	note D_, 1
	note __, 2
	note D_, 1
	note __, 1
	note D_, 1
	note __, 2
	note D_, 1
	note __, 2
	note D_, 1
	note __, 1
	note G_, 1
	note __, 2
	note D_, 1
	note __, 2
	note D_, 1
	note __, 3
	octave 3
	note G_, 1
	note __, 3
	note G_, 1
	note __, 1
	endchannel

Music_GymLeaderBattleSwSh_Ch1_ditty8:
	note G_, 3
	note __, 1
	note G_, 1
	note __, 1
	note G_, 1
	note A_, 1
	note __, 1
	note A_, 1
	note F_, 4
	note __, 6
	note G_, 2
	note G_, 1
	note __, 5
	note G_, 2
	note G_, 1
	note __, 1
	note G_, 3
	note __, 1
	note G_, 1
	note __, 1
	note G_, 1
	note A_, 1
	note __, 1
	note A_, 1
	note F_, 4
	note __, 2
	note G_, 3
	note __, 1
	note G_, 1
	note G_, 1
	note __, 1
	note G_, 1
	note D_, 4
	note __, 4
	endchannel

Music_GymLeaderBattleSwSh_Ch1_ditty9:
	note G_, 2
	octave 3
	note G_, 1
	octave 4
	note G_, 1
	note __, 1
	octave 3
	note G_, 1
	octave 4
	note G_, 1
	note __, 1
	note A_, 2
	note G_, 2
	note F_, 2
	note A_, 2
	octave 3
	note G_, 2
	octave 4
	note G_, 1
	note __, 1
	octave 3
	note G_, 1
	octave 4
	note G_, 1
	note __, 1
	note D_, 3
	note __, 6
	octave 3
	note B_, 2
	note __, 1
	note B_, 1
	note __, 1
	note G_, 1
	note B_, 1
	note __, 1
	note B_, 1
	note __, 1
	note B_, 2
	octave 4
	note C_, 2
	note E_, 1
	note __, 1
	note G_, 3
	note __, 1
	note G_, 1
	note G_, 1
	note __, 1
	note G_, 1
	note D_, 4
	note __, 4
	endchannel

Music_GymLeaderBattleSwSh_Ch1_ditty10:
	note G_, 2
	octave 3
	note G_, 1
	octave 4
	note G_, 1
	note __, 1
	octave 3
	note G_, 1
	octave 4
	note G_, 1
	note __, 1
	note A_, 2
	note G_, 2
	note F_, 2
	note A_, 2
	octave 3
	note G_, 2
	octave 4
	note G_, 1
	note __, 1
	octave 3
	note G_, 1
	octave 4
	note G_, 1
	note __, 1
	note D_, 3
	note __, 6
	octave 3
	note B_, 2
	note __, 1
	note B_, 1
	note __, 1
	note G_, 1
	note B_, 1
	note __, 1
	note B_, 1
	note __, 1
	note B_, 2
	octave 4
	note C_, 2
	note E_, 1
	note __, 1
	note D_, 2
	octave 3
	note G_, 1
	octave 4
	note D_, 1
	note __, 1
	octave 3
	note G_, 1
	octave 4
	note D_, 1
	note __, 1
	octave 3
	note G_, 1
	note __, 1
	note G_, 1
	note __, 1
	note A_, 2
	note B_, 2
	endchannel

Music_GymLeaderBattleSwSh_Ch1_ditty11:
	note G_, 1
	note __, 3
	note G_, 1
	note __, 3
	note G#, 1
	note __, 3
	note G_, 1
	note __, 3
	note G_, 1
	note __, 3
	note G_, 1
	note __, 3
	note A#, 1
	note __, 3
	note A#, 1
	endchannel

Music_GymLeaderBattleSwSh_Ch1_ditty12:
	note __, 3
	note G_, 1
	note __, 3
	note G_, 1
	note __, 3
	note G#, 1
	note __, 3
	note G_, 1
	note __, 3
	note G_, 1
	note __, 3
	note G_, 1
	note __, 3
	octave 2
	intensity $0F
	note F_, 6
	endchannel

Music_GymLeaderBattleSwSh_Ch3_ditty1:
	octave 1
	note G_, 2
	octave 2
	note G_, 1
	note __, 1
	octave 1
	note G_, 2
	octave 2
	note G_, 1
	note __, 1
	octave 1
	note G_, 2
	octave 2
	note G_, 1
	note __, 1
	octave 1
	note G_, 2
	octave 2
	note G_, 1
	note __, 1
	octave 1
	note G_, 2
	octave 2
	note G_, 1
	note __, 1
	octave 1
	note G_, 2
	octave 2
	note G_, 1
	note __, 1
	octave 1
	note G_, 2
	octave 2
	note G_, 1
	note __, 1
	octave 1
	note G_, 2
	octave 2
	note G_, 1
	note __, 1
	octave 1
	note G_, 2
	octave 2
	note G_, 1
	note __, 1
	octave 1
	note G_, 2
	octave 2
	note G_, 1
	note __, 1
	octave 1
	note G_, 2
	octave 2
	note G_, 1
	note __, 1
	octave 1
	note G_, 2
	octave 2
	note G_, 1
	note __, 1
	octave 1
	note G_, 2
	octave 2
	note G_, 1
	note __, 1
	octave 1
	note G_, 2
	octave 2
	note G_, 1
	note __, 1
	octave 1
	note G_, 2
	octave 2
	note G_, 1
	note __, 1
	octave 1
	note G_, 2
	octave 2
	note G_, 1
	note __, 1
	endchannel

Music_GymLeaderBattleSwSh_Ch3_ditty2:
	note G_, 3
	note __, 1
	note G_, 3
	note __, 1
	note F_, 2
	note __, 1
	note F_, 2
	note __, 1
	note F_, 1
	note __, 3
	note G_, 6
	note F_, 2
	note __, 1
	note F_, 2
	note __, 1
	note F_, 1
	note __, 1
	note G_, 5
	note __, 1
	note G_, 1
	note __, 1
	note F_, 2
	note __, 1
	note F_, 2
	note __, 1
	note F_, 1
	note __, 1
	note G_, 8
	note F_, 2
	note __, 1
	note F_, 2
	note __, 1
	note F_, 1
	note __, 1
	endchannel

Music_GymLeaderBattleSwSh_Ch3_ditty3:
	intensity $10
	octave 4
	note G_, 1
	note __, 1
	intensity $11
	octave 2
	note G_, 1
	octave 3
	note G_, 1
	note __, 1
	octave 2
	note G_, 1
	intensity $10
	octave 3
	note G_, 1
	note __, 1
	intensity $11
	note D#, 1
	note __, 1
	note D#, 1
	note __, 1
	intensity $10
	note D#, 1
	note D_, 1
	intensity $11
	note D_, 1
	note __, 1
	note G_, 1
	octave 4
	note G_, 1
	note __, 1
	intensity $10
	octave 2
	note G_, 1
	intensity $11
	octave 3
	note G_, 1
	note __, 1
	note A#, 1
	note __, 1
	intensity $10
	note C#, 1
	note __, 1
	intensity $11
	note C#, 2
	note __, 1
	note C#, 1
	intensity $10
	note A#, 1
	note __, 1
	intensity $11
	endchannel

Music_GymLeaderBattleSwSh_Ch3_ditty4:
	note G_, 3
	note __, 1
	note G_, 3
	note __, 1
	note D_, 2
	note __, 1
	note D_, 2
	note __, 1
	note D_, 1
	note __, 3
	note G_, 5
	note __, 1
	note D_, 2
	note __, 1
	note D_, 2
	note __, 1
	note D_, 1
	note __, 1
	note G_, 8
	note C_, 2
	note __, 1
	note C_, 2
	note __, 1
	note C_, 2
	note G_, 7
	note __, 1
	note D_, 2
	note __, 1
	note D_, 2
	note __, 1
	note D_, 2
	endchannel

Music_GymLeaderBattleSwSh_Ch3_ditty5:
	intensity $11
	octave 2
	note G_, 2
	note __, 1
	note G_, 1
	octave 3
	note G_, 2
	note __, 1
	note G_, 1
	note D_, 3
	note __, 1
	intensity $10
	note C_, 3
	note __, 1
	intensity $11
	octave 2
	note B_, 2
	note __, 1
	note G_, 1
	intensity $10
	note B_, 1
	intensity $11
	note __, 1
	note B_, 2
	note __, 1
	note B_, 1
	intensity $10
	octave 3
	note C_, 1
	note __, 1
	note D_, 2
	note __, 1
	note D_, 1
	octave 2
	intensity $11
	note B_, 2
	note __, 1
	intensity $10
	note B_, 1
	note __, 1
	note G_, 1
	intensity $11
	octave 3
	note C_, 2
	octave 2
	note B_, 1
	note __, 1
	intensity $10
	note A_, 1
	note __, 1
	intensity $11
	note G_, 2
	note __, 1
	note F_, 1
	intensity $10
	note G_, 2
	note __, 1
	note G_, 1
	note __, 2
	intensity $11
	octave 1
	note G_, 1
	note __, 1
	note B_, 1
	note __, 1
	intensity $10
	note B_, 1
	note __, 1
	octave 2
	note D_, 2
	note __, 1
	note D_, 1
	intensity $11
	endchannel

Music_GymLeaderBattleSwSh_Ch3_ditty6:
	note G_, 7
	note __, 1
	note G_, 7
	note __, 1
	note G_, 3
	note __, 1
	note G_, 3
	note __, 1
	note G_, 3
	note __, 1
	note G_, 3
	note __, 1
	note G_, 5
	note __, 3
	note G_, 7
	note __, 1
	note G_, 3
	note __, 1
	note G_, 2
	note __, 2
	note G_, 8
	endchannel

Music_GymLeaderBattleSwSh_Ch3_ditty7:
	note G_, 7
	note __, 1
	note G_, 7
	note __, 1
	note G_, 3
	note __, 1
	note G_, 3
	note __, 1
	note G_, 3
	note __, 1
	note G_, 3
	note __, 1
	note G_, 5
	note __, 3
	note G_, 7
	note __, 1
	note G_, 3
	note __, 1
	note G_, 3
	note __, 1
	note G_, 8
	endchannel

Music_GymLeaderBattleSwSh_Ch3_ditty8:
	octave 1
	note G_, 2
	octave 2
	note G_, 2
	octave 1
	note G_, 2
	octave 2
	note G_, 2
	endchannel

Music_GymLeaderBattleSwSh_Ch3_ditty9:
	octave 2
	note D#, 2
	octave 3
	note D#, 2
	octave 2
	note D_, 2
	octave 3
	note D_, 2
	endchannel

Music_GymLeaderBattleSwSh_Ch3_ditty10:
	octave 1
	note A#, 2
	octave 2
	note A#, 2
	octave 1
	note A#, 2
	octave 2
	note A#, 2
	endchannel

Music_GymLeaderBattleSwSh_Ch4_ditty1:
	note D#, 1
	note __, 1
	note A_, 2
	note D#, 1
	note __, 1
	note A_, 2
	note C#, 1
	note __, 1
	note A_, 2
	note D#, 1
	note __, 1
	note A_, 2
	note C#, 1
	note __, 1
	note A_, 2
	note D#, 1
	note __, 1
	note A_, 2
	note C#, 1
	note __, 1
	note A_, 2
	note D#, 1
	note __, 1
	note A_, 2
	note C#, 1
	note __, 1
	note A_, 2
	note D#, 1
	note __, 1
	note A_, 2
	note C#, 1
	note __, 1
	note A_, 2
	note D#, 1
	note __, 1
	note A_, 2
	note C#, 1
	note __, 1
	note A_, 2
	note D#, 1
	note __, 1
	note A_, 2
	note C#, 1
	note D#, 3
	note C#, 1
	note D#, 3
	endchannel

Music_GymLeaderBattleSwSh_Ch4_ditty2:
	note E_, 4
	note D#, 4
	note D#, 3
	note D#, 3
	note D#, 1
	note __, 3
	note D#, 1
	note __, 5
	note D#, 1
	note __, 2
	note D#, 1
	note __, 2
	note D#, 1
	note __, 1
	note D#, 1
	note __, 3
	note D#, 1
	note __, 1
	note D#, 1
	note __, 1
	note D#, 1
	note __, 2
	note D#, 1
	note __, 2
	note D#, 1
	note __, 3
	note D#, 1
	note __, 5
	note D#, 1
	note __, 2
	note D#, 1
	note __, 2
	note D#, 1
	note __, 1
	endchannel

Music_GymLeaderBattleSwSh_Ch4_ditty3:
	note D#, 2
	note A_, 2
	note C#, 2
	note A_, 1
	note A_, 1
	note D#, 2
	note A_, 2
	note C#, 2
	note A_, 1
	note A_, 1
	note D#, 2
	note A_, 2
	note C#, 2
	note A_, 1
	note A_, 1
	note D#, 2
	note A_, 2
	note C#, 2
	note A_, 1
	note A_, 1
	note D#, 2
	note A_, 2
	note C#, 2
	note A_, 1
	note A_, 1
	note D#, 2
	note A_, 2
	note C#, 2
	note A_, 1
	note A_, 1
	note D#, 2
	note A_, 2
	note C#, 2
	note A_, 1
	note A_, 1
	note D#, 2
	note A_, 2
	note C#, 2
	note A_, 1
	note A_, 1
	endchannel

Music_GymLeaderBattleSwSh_Ch4_ditty4:
	note C#, 1
	note C#, 1
	note C#, 1
	note C#, 1
	note C#, 1
	note C#, 11
	note D#, 16
	note D#, 16
	note D#, 16
	endchannel

Music_GymLeaderBattleSwSh_Ch4_ditty5:
	noisesampleset 5
	note C#, 4
	note C#, 4
	note C#, 4
	note C#, 4
	note C#, 2
	note C#, 2
	note C#, 2
	note C#, 2
	note C#, 2
	note C#, 2
	note C#, 2
	note C#, 2
	note C#, 1
	note C#, 1
	note C#, 1
	note C#, 1
	note C#, 1
	note C#, 1
	note C#, 1
	note C#, 1
	note C#, 1
	note C#, 1
	note C#, 1
	note C#, 1
	note C#, 1
	note C#, 1
	note C#, 1
	note C#, 1
	note G#, 16
	noisesampleset 4
	endchannel

Music_GymLeaderBattleSwSh_Ch4_ditty6:
	note E_, 12
	note D#, 2
	note D#, 1
	note __, 1
	note E_, 12
	note D#, 2
	note D#, 1
	note __, 1
	note E_, 12
	note D#, 2
	note D#, 1
	note __, 1
	note E_, 8
	note D#, 1
	note __, 2
	note D#, 1
	note __, 2
	note D#, 1
	note __, 1
	endchannel

Music_GymLeaderBattleSwSh_Ch4_ditty7:
	note D#, 2
	note A_, 2
	note C#, 2
	note A_, 1
	note C#, 1
	note D#, 2
	note A_, 2
	note C#, 2
	note A_, 1
	note C#, 1
	note D#, 2
	note A_, 2
	note C#, 2
	note A_, 1
	note D#, 3
	note A_, 2
	note C#, 2
	note A_, 2
	note D#, 2
	note A_, 2
	note C#, 2
	note A_, 1
	note C#, 1
	note D#, 2
	note A_, 2
	note C#, 2
	note A_, 1
	note C#, 1
	note D#, 2
	note A_, 2
	note C#, 2
	note A_, 1
	note D#, 3
	note A_, 2
	note C#, 2
	note A_, 2
	endchannel

Music_GymLeaderBattleSwSh_Ch4_ditty8:
	note A#, 2
	note G_, 2
	note G_, 2
	note G_, 2
	note G_, 2
	note G_, 2
	note G_, 2
	note A#, 2
	endchannel
