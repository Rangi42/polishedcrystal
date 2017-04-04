; Pokémon R/S/E - Battle! Champion
; Demixed by Mmmmmm
; https://pastebin.com/qyNUWZfz
; https://hax.iimarck.us/topic/6777/4/

Music_ChampionBattleRSE:
	musicheader 4, 1, Music_ChampionBattleRSE_Ch1
	musicheader 1, 2, Music_ChampionBattleRSE_Ch2
	musicheader 1, 3, Music_ChampionBattleRSE_Ch3
	musicheader 1, 4, Music_ChampionBattleRSE_Ch4

Music_ChampionBattleRSE_Ch1:
	tempo 192
	volume $77
	dutycycle 2
	tone $0002
	vibrato $8, $15
	notetype $3, $94
Music_ChampionBattleRSE_Ch1_loop_1:
	octave 5
	note G_, 2
	note G#, 2
	note A#, 4
	loopchannel 8, Music_ChampionBattleRSE_Ch1_loop_1
	dutycycle 1
	notetype $c, $b3
	octave 4
	note C_, 3
	note C#, 3
	intensity $b5
	note D#, 2
	octave 3
	intensity $b3
	note G_, 3
	note G#, 3
	intensity $b5
	note A#, 2
	octave 4
	intensity $b3
	note C_, 3
	note C#, 3
	intensity $b5
	note D#, 2
	intensity $b3
	note D#, 3
	note F_, 3
	intensity $b5
	note F#, 2
	octave 5
	intensity $b3
	note C_, 3
	note C#, 3
	intensity $b5
	note D#, 2
	octave 4
	intensity $b3
	note G_, 3
	note G#, 3
	intensity $b5
	note A#, 2
	octave 5
	intensity $b3
	note C_, 3
	note C#, 3
	intensity $b5
	note D#, 2
	intensity $b3
	note D#, 3
	note F_, 3
	intensity $b5
	note G_, 2
Music_ChampionBattleRSE_Ch1_loop_main:
	dutycycle 1
Music_ChampionBattleRSE_Ch1_loop_2:
	intensity $b0
	octave 4
	note C_, 2
	intensity $b5
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
	intensity $b0
	note F#, 2
	intensity $b5
	note F#, 5
	note F_, 1
	note F#, 1
	note F_, 1
	intensity $b0
	note F#, 1
	intensity $b5
	note F#, 5
	loopchannel 2, Music_ChampionBattleRSE_Ch1_loop_2
	dutycycle 2
	intensity $a6
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
	intensity $a0
	note G#, 8
	intensity $a7
	note G#, 8
	dutycycle 3
	intensity $a6
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
	intensity $a0
	note F_, 8
	intensity $a7
	note F_, 8
	dutycycle 2
	octave 2
	intensity $33
	note C_, 1
	note C_, 1
	note C_, 1
	note C_, 1
	intensity $53
	note C_, 1
	note C_, 1
	intensity $73
	note C_, 1
	note C_, 1
	intensity $83
	note C_, 1
	note C_, 1
	intensity $93
	note C_, 1
	note C_, 1
	note C_, 1
	note C_, 1
	note C_, 1
	note C_, 1
	dutycycle 3
	intensity $b4
	callchannel Music_ChampionBattleRSE_Ch1_branch_1
	dutycycle 0
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
	dutycycle 1
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
	intensity $b7
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
	intensity $b0
	note G#, 6
	intensity $b5
	note G#, 10
	octave 3
	intensity $b0
	note A#, 6
	intensity $b5
	note A#, 10
	intensity $b0
	note G_, 6
	intensity $b5
	note G_, 10
	intensity $b0
	note A#, 6
	intensity $b5
	note A#, 10
	loopchannel 0, Music_ChampionBattleRSE_Ch1_loop_main

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
	endchannel

Music_ChampionBattleRSE_Ch2:
	dutycycle 3
	vibrato $12, $25
	tone $0001
	notetype $3, $d4
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
	notetype $c, $b3
	note G_, 3
	note G#, 3
	intensity $b5
	note A#, 2
	intensity $b3
	note E_, 3
	note F_, 3
	intensity $b5
	note G_, 2
	intensity $b3
	note G_, 3
	note G#, 3
	intensity $b5
	note A#, 2
	intensity $b3
	note A#, 3
	octave 4
	note C_, 3
	intensity $b5
	note C#, 2
	intensity $b3
	note C_, 3
	note C#, 3
	intensity $b5
	note D#, 2
	octave 3
	intensity $b3
	note G_, 3
	note G#, 3
	intensity $b5
	note A#, 2
	octave 4
	intensity $b3
	note C_, 3
	note C#, 3
	intensity $b5
	note D#, 2
	intensity $b3
	note D#, 3
	note F_, 3
	intensity $b5
	note G_, 2
Music_ChampionBattleRSE_Ch2_loop_main:
	dutycycle 0
Music_ChampionBattleRSE_Ch2_loop_1:
	intensity $b0
	octave 3
	note E_, 2
	intensity $b5
	note E_, 5
	note C_, 1
	octave 2
	note E_, 2
	note G_, 1
	octave 3
	note C_, 2
	note E_, 2
	note G#, 1
	intensity $b0
	note A#, 2
	intensity $b5
	note A#, 5
	note A_, 1
	note A#, 1
	note A_, 1
	note A#, 2
	intensity $b2
	note A#, 1
	note A#, 1
	intensity $b4
	note G#, 2
	loopchannel 2, Music_ChampionBattleRSE_Ch2_loop_1
	intensity $a6
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
	intensity $a0
	note C_, 4
	intensity $a6
	note C_, 8
	octave 3
	note G_, 2
	octave 4
	note F_, 2
	intensity $a0
	note E_, 8
	intensity $a6
	note E_, 8
	intensity $b4
	callchannel Music_ChampionBattleRSE_Ch2_branch_1
	dutycycle 3
	callchannel Music_ChampionBattleRSE_Ch1_branch_1
	dutycycle 0
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
	intensity $b7
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
	intensity $b0
	note D#, 6
	intensity $b5
	note D#, 10
	octave 3
	intensity $b0
	note F_, 6
	intensity $b5
	note F_, 10
	intensity $b0
	note D_, 6
	intensity $b5
	note D_, 10
	intensity $b0
	note F_, 6
	intensity $b5
	note F_, 10
	loopchannel 0, Music_ChampionBattleRSE_Ch2_loop_main

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
	endchannel

Music_ChampionBattleRSE_Ch3:
	notetype $c, $19
	vibrato $12, $15
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
	callchannel Music_ChampionBattleRSE_Ch3_branch_1
	note D#, 1
	note F_, 1
	note D#, 1
	note F_, 1
	octave 1
	note B_, 1
	loopchannel 3, Music_ChampionBattleRSE_Ch3_loop_1
	callchannel Music_ChampionBattleRSE_Ch3_branch_1
	note A#, 1
	note C_, 1
	note F#, 1
	note F_, 1
	note D#, 1
Music_ChampionBattleRSE_Ch3_loop_main:
Music_ChampionBattleRSE_Ch3_loop_2:
	note C_, 1
	note G_, 1
	loopchannel 6, Music_ChampionBattleRSE_Ch3_loop_2
	note C_, 1
	octave 3
	note C_, 1
	octave 2
	note G_, 1
	note E_, 1
Music_ChampionBattleRSE_Ch3_loop_3:
	note C#, 1
	note G#, 1
	loopchannel 6, Music_ChampionBattleRSE_Ch3_loop_3
	note C#, 1
	note C#, 1
	note G#, 1
	note F_, 1
Music_ChampionBattleRSE_Ch3_loop_4:
	note C_, 1
	note G_, 1
	loopchannel 5, Music_ChampionBattleRSE_Ch3_loop_4
	octave 3
	note C_, 1
	octave 2
	note G_, 1
	note E_, 1
	note G_, 1
	note E_, 1
	note G_, 1
	callchannel Music_ChampionBattleRSE_Ch3_branch_7
	callchannel Music_ChampionBattleRSE_Ch3_branch_6
	callchannel Music_ChampionBattleRSE_Ch3_branch_7
Music_ChampionBattleRSE_Ch3_loop_5:
	note D#, 1
	note A#, 1
	loopchannel 8, Music_ChampionBattleRSE_Ch3_loop_5
	callchannel Music_ChampionBattleRSE_Ch3_branch_2
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
	callchannel Music_ChampionBattleRSE_Ch3_branch_2
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
	callchannel Music_ChampionBattleRSE_Ch3_branch_3
	note G#, 3
	octave 2
	note C#, 2
	callchannel Music_ChampionBattleRSE_Ch3_branch_3
	octave 2
	note C#, 2
	note G#, 1
	note D_, 2
	callchannel Music_ChampionBattleRSE_Ch3_branch_4
	callchannel Music_ChampionBattleRSE_Ch3_branch_4
	callchannel Music_ChampionBattleRSE_Ch3_branch_5
	callchannel Music_ChampionBattleRSE_Ch3_branch_5
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
	callchannel Music_ChampionBattleRSE_Ch3_branch_6
	callchannel Music_ChampionBattleRSE_Ch3_branch_7
	callchannel Music_ChampionBattleRSE_Ch3_branch_6
	callchannel Music_ChampionBattleRSE_Ch3_branch_7
	loopchannel 0, Music_ChampionBattleRSE_Ch3_loop_main
	endchannel

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
	endchannel

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
	endchannel

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
	endchannel

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
	endchannel

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
	endchannel

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
	endchannel

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
	endchannel

Music_ChampionBattleRSE_Ch4:
	togglenoise $3
	notetype $6
	note C_, 6
	note C_, 8
	note D#, 4
	note C_, 6
	note C_, 4
	note D#, 4
	callchannel Music_ChampionBattleRSE_Ch4_branch_1
	callchannel Music_ChampionBattleRSE_Ch4_branch_2
	callchannel Music_ChampionBattleRSE_Ch4_branch_1
	callchannel Music_ChampionBattleRSE_Ch4_branch_2
Music_ChampionBattleRSE_Ch4_loop_main:
Music_ChampionBattleRSE_Ch4_loop_1:
	callchannel Music_ChampionBattleRSE_Ch4_branch_3
	loopchannel 4, Music_ChampionBattleRSE_Ch4_loop_1
	note D#, 2
	note D#, 2
	note C_, 2
	note D#, 4
	note D#, 2
	note C_, 4
	note D#, 2
	note D#, 2
	note C_, 2
	note D#, 4
	note D#, 2
	note C_, 4
	note D#, 2
	note D#, 2
	note C_, 2
	note D#, 4
	note D#, 2
	note C_, 2
	note D#, 2
	note D#, 4
	note C_, 4
	note D#, 2
	note D#, 2
	note C_, 4
	callchannel Music_ChampionBattleRSE_Ch4_branch_3
	note __, 16
	note __, 16
	note __, 16
	note __, 16
	note D#, 2
	note D#, 2
	note C_, 4
	note D#, 2
	note C_, 2
	note D#, 2
	note C_, 2
	note D#, 2
	note D#, 2
	note C_, 2
	note D#, 4
	note D#, 2
	note C_, 2
	note D#, 1
	note D#, 1
	note D#, 2
	note D#, 2
	note C_, 2
	note D#, 4
	note D#, 2
	note C_, 2
	note D#, 1
	note D#, 1
	note D#, 2
	note D#, 2
	note C_, 2
	note D#, 4
	note C_, 2
	note D#, 2
	note C_, 2
	note D#, 2
	note D#, 2
	note C_, 2
	note D#, 4
	note C_, 2
	note D#, 2
	note C_, 2
	note D#, 4
	note C_, 2
	note D#, 4
	note D#, 2
	note C_, 2
	note D#, 2
	note D#, 2
	note D#, 2
	note C_, 2
	note D#, 2
	note D#, 2
	note C_, 2
	note D#, 2
	note C_, 2
	note D#, 2
	note D#, 2
	note C_, 2
	note D#, 2
	note D#, 2
	note C_, 2
	note C_, 2
	note C_, 2
Music_ChampionBattleRSE_Ch4_loop_2:
	note D#, 4
	note C_, 4
	note D#, 2
	note D#, 2
	note C_, 4
	note D#, 4
	note C_, 4
	note D#, 2
	note D#, 2
	note C_, 2
	note C_, 2
	loopchannel 4, Music_ChampionBattleRSE_Ch4_loop_2
	note D#, 4
	note C_, 4
	note C_, 4
	note D#, 4
	note C_, 4
	note C_, 4
	note D#, 4
	note C_, 4
	note C_, 4
	note D#, 4
	note C_, 4
	note C_, 2
	note C_, 2
	note D#, 4
	note C_, 4
	note D#, 4
	note C_, 4
	note D#, 4
	note C_, 4
	note D#, 4
	note C_, 4
	note D#, 4
	note C_, 4
	note D#, 4
	note C_, 2
	note C_, 2
Music_ChampionBattleRSE_Ch4_loop_3:
	callchannel Music_ChampionBattleRSE_Ch4_branch_3
	loopchannel 4, Music_ChampionBattleRSE_Ch4_loop_3
	loopchannel 0, Music_ChampionBattleRSE_Ch4_loop_main

Music_ChampionBattleRSE_Ch4_branch_1:
	note D#, 2
	note D#, 2
	note C_, 2
	note D#, 2
	note D#, 4
	note C_, 2
	note D#, 2
	note D#, 4
	note C_, 2
	note D#, 2
	note D#, 2
	note D#, 2
	note C_, 2
	note D#, 2
	endchannel

Music_ChampionBattleRSE_Ch4_branch_2:
	note D#, 2
	note D#, 2
	note C_, 2
	note D#, 4
	note D#, 2
	note C_, 2
	note D#, 2
	note D#, 4
	note C_, 2
	note D#, 2
	note D#, 2
	note D#, 2
	note C_, 2
	note D#, 2
	endchannel

Music_ChampionBattleRSE_Ch4_branch_3:
	note D#, 4
	note C_, 4
	note D#, 2
	note D#, 2
	note C_, 4
	note D#, 4
	note C_, 2
	note D#, 4
	note D#, 2
	note C_, 4
	endchannel
