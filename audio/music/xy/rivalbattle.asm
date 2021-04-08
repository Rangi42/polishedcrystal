; Pokémon X/Y - Battle! Rival
; Demixed by Mmmmmm
; https://pastebin.com/KvYS4SPR
; https://hax.iimarckus.org/topic/6777/3/

Music_RivalBattleXY:
	musicheader 4, 1, Music_RivalBattleXY_Ch1
	musicheader 1, 2, Music_RivalBattleXY_Ch2
	musicheader 1, 3, Music_RivalBattleXY_Ch3
	musicheader 1, 4, Music_RivalBattleXY_Ch4

Music_RivalBattleXY_Ch1:
	tempo 116
	volume $77
	dutycycle $3
	tone $0002
	vibrato $8, $15
	notetype $c, $c2
	octave 4
	note C_, 1
	octave 3
	note B_, 1
	note A#, 1
	note A_, 1
	note A#, 1
	note A_, 1
	note G#, 1
	note G_, 1
	note G#, 1
	note G_, 1
	note F#, 1
	note F_, 1
	note E_, 1
	note F#, 1
	note G#, 1
	note A#, 1
	intensity $a3
	callchannel Music_RivalBattleXY_Ch1_branch_1
	callchannel Music_RivalBattleXY_Ch1_branch_1
Music_RivalBattleXY_Ch1_loop_main:
	octave 3
	dutycycle $3
	intensity $a3
	callchannel Music_RivalBattleXY_Ch1_branch_1
	intensity $a0
	note D#, 16
	intensity $a7
	note D#, 16
	intensity $a3
	callchannel Music_RivalBattleXY_Ch1_branch_1
	intensity $a0
	note D#, 16
	intensity $a7
	note D#, 16
	dutycycle 2
Music_RivalBattleXY_Ch1_loop_1:
	octave 4
	intensity $82
	note F_, 2
	callchannel Music_RivalBattleXY_Ch1_branch_2
	note F_, 2
	callchannel Music_RivalBattleXY_Ch1_branch_2
	note G#, 2
	callchannel Music_RivalBattleXY_Ch1_branch_2
	note F_, 2
	callchannel Music_RivalBattleXY_Ch1_branch_2
	note G_, 2
	callchannel Music_RivalBattleXY_Ch1_branch_3
	note G_, 2
	callchannel Music_RivalBattleXY_Ch1_branch_3
	note A#, 2
	callchannel Music_RivalBattleXY_Ch1_branch_3
	note G_, 2
	callchannel Music_RivalBattleXY_Ch1_branch_3
	loopchannel 2, Music_RivalBattleXY_Ch1_loop_1
	intensity $a3
	dutycycle 1
	octave 3
	note F_, 6
	note C#, 6
	note F_, 6
	note C#, 6
	note F_, 4
	intensity $a5
	note G#, 4
	intensity $a3
	note G_, 6
	note D#, 6
	note G_, 6
	note D#, 6
	note A#, 4
	intensity $a5
	note G_, 4
	intensity $a3
	note G#, 6
	note F_, 6
	note G#, 6
	note F_, 6
	note G#, 4
	intensity $a5
	octave 4
	note C#, 4
	intensity $a3
	octave 3
	note A#, 6
	note G_, 6
	note A#, 6
	note G_, 6
	note A#, 4
	note G_, 1
	note G#, 1
	note A#, 1
	note B_, 1
	note __, 16
	note __, 16
	note __, 16
	note __, 12
	intensity $93
	octave 4
	note G_, 1
	note G#, 1
	note A#, 1
	note B_, 1
	octave 5
	note C_, 2
	note C_, 4
	note C_, 4
	note C_, 4
	note C_, 2
	octave 4
	intensity $97
	note A#, 4
	note B_, 4
	octave 5
	intensity $93
	note C_, 4
	octave 4
	note G_, 4
	note A#, 6
	note A_, 4
	note F_, 4
	note F_, 2
	note A#, 4
	octave 5
	intensity $97
	note D_, 4
	intensity $93
	note C_, 8
	octave 4
	intensity $a3
	dutycycle 2
	note E_, 8
	note C_, 8
	note E_, 6
	note A_, 10
	note G_, 8
	note E_, 2
	note G_, 4
	note C_, 10
	note __, 8
	loopchannel 0, Music_RivalBattleXY_Ch1_loop_main

Music_RivalBattleXY_Ch1_branch_1:
	note G_, 6
	note C_, 4
	note G_, 6
	note F_, 4
	note E_, 4
	note F_, 4
	note G_, 4
	endchannel

Music_RivalBattleXY_Ch1_branch_2:
	note C#, 2
	note D#, 2
	note C#, 2
	endchannel

Music_RivalBattleXY_Ch1_branch_3:
	note D#, 2
	note F_, 2
	note D#, 2
	endchannel

Music_RivalBattleXY_Ch2:
	dutycycle $3
	vibrato $8, $36
	tone $0001
	notetype $c, $b2
	octave 4
	note G_, 2
	note A#, 4
	intensity $b7
	note A#, 6
	note B_, 4
	intensity $b4
	octave 5
	note C_, 4
	note __, 12
	note __, 16
	note __, 16
	note __, 16
Music_RivalBattleXY_Ch2_loop:
	dutycycle $0
	callchannel Music_RivalBattleXY_Ch2_branch_1
	note F_, 4
	note D#, 4
	note D_, 4
	octave 3
	note A#, 4
	callchannel Music_RivalBattleXY_Ch2_branch_1
	note F_, 4
	note D#, 4
	note F_, 4
	note G_, 4
	octave 3
	intensity $d0
	note F_, 16
	note C#, 8
	note F_, 8
	note D#, 16
	note G_, 8
	note D#, 8
	note F_, 15
	notetype $3, $d0
	note F#, 1
	note G_, 1
	note G#, 1
	note A_, 1
	notetype $c, $d0
	note A#, 7
	note A_, 1
	note G#, 8
	note G_, 16
	note A#, 16
	note G#, 16
	note F_, 8
	note G#, 8
	note G_, 15
	notetype $3, $d0
	note G#, 3
	note A_, 1
	note A#, 16
	note A#, 14
	note A_, 1
	note G#, 1
	notetype $c, $d0
	note G_, 8
	note G#, 15
	notetype $3, $d0
	note A_, 1
	note A#, 1
	note B_, 1
	octave 4
	note C_, 1
	notetype $c, $d0
	note C#, 8
	note C_, 8
	octave 3
	note A#, 15
	notetype $3, $d0
	note B_, 1
	octave 4
	note C_, 1
	note C#, 1
	note D_, 1
	notetype $c, $d0
	note D#, 12
	octave 3
	note G_, 1
	note G#, 1
	note A#, 1
	note B_, 1
	callchannel Music_RivalBattleXY_Ch2_branch_2
	note D#, 4
	intensity $b7
	note G_, 4
	intensity $b3
	note F_, 4
	note G_, 1
	note G#, 1
	note A#, 1
	note B_, 1
	callchannel Music_RivalBattleXY_Ch2_branch_2
	note A#, 4
	intensity $b7
	octave 4
	note D_, 4
	intensity $b3
	note C_, 4
	note __, 10
	note __, 16
	octave 2
	intensity $b7
	note A#, 4
	note A_, 2
	note A#, 2
	note B_, 2
	octave 3
	intensity $b3
	note C_, 2
	intensity $b7
	note C_, 4
	note __, 12
	note C_, 2
	note __, 2
	octave 2
	note C_, 2
	octave 3
	note C_, 2
	note __, 2
	note C_, 4
	loopchannel 0, Music_RivalBattleXY_Ch2_loop

Music_RivalBattleXY_Ch2_branch_1:
	intensity $b3
	octave 3
	note G_, 6
	note C_, 4
	note G_, 6
	notetype $6, $b7
	note F_, 8
	note E_, 8
	note F_, 8
	note G_, 7
	note A_, 1
	notetype $c, $b4
	note A#, 2
	note A_, 2
	note A#, 1
	note __, 1
	intensity $b7
	octave 4
	note C_, 4
	intensity $b4
	octave 3
	note A#, 2
	octave 4
	note C_, 2
	note D_, 1
	note __, 1
	intensity $b7
	endchannel

Music_RivalBattleXY_Ch2_branch_2:
	intensity $b3
	octave 4
	note C_, 2
	note C_, 4
	note C_, 4
	note C_, 4
	note C_, 2
	octave 3
	intensity $b7
	note A#, 4
	note B_, 4
	octave 4
	intensity $b3
	note C_, 4
	octave 3
	note G_, 4
	note A#, 6
	note A_, 4
	note F_, 4
	note F_, 2
	endchannel

Music_RivalBattleXY_Ch3:
	notetype $c, $19
	octave 2
	note A_, 1
	note __, 1
	note A_, 2
	note __, 2
	note A_, 6
	note E_, 1
	note F#, 1
	note G#, 1
	note A#, 1
Music_RivalBattleXY_Ch3_loop_main:
Music_RivalBattleXY_Ch3_loop_1:
	note C_, 1
	note __, 1
	note C_, 1
	note __, 1
	loopchannel 13, Music_RivalBattleXY_Ch3_loop_1
	note G_, 1
	note __, 1
	note F_, 1
	note __, 1
	note G_, 1
	note __, 1
	note F_, 1
	note __, 1
	note E_, 1
	note __, 1
	octave 1
	note B_, 1
	note __, 1
	callchannel Music_RivalBattleXY_Ch3_branch_1
	callchannel Music_RivalBattleXY_Ch3_branch_2
	callchannel Music_RivalBattleXY_Ch3_branch_1
	callchannel Music_RivalBattleXY_Ch3_branch_4
	callchannel Music_RivalBattleXY_Ch3_branch_3
	callchannel Music_RivalBattleXY_Ch3_branch_4
	callchannel Music_RivalBattleXY_Ch3_branch_3
	callchannel Music_RivalBattleXY_Ch3_branch_4
	callchannel Music_RivalBattleXY_Ch3_branch_3
	callchannel Music_RivalBattleXY_Ch3_branch_4
	callchannel Music_RivalBattleXY_Ch3_branch_3
	callchannel Music_RivalBattleXY_Ch3_branch_2
	callchannel Music_RivalBattleXY_Ch3_branch_5
	note D#, 2
	note __, 2
	note G_, 4
	note F_, 2
	note __, 6
	callchannel Music_RivalBattleXY_Ch3_branch_5
	note A#, 2
	note __, 2
	octave 3
	note D_, 4
	note C_, 2
	octave 2
	note G#, 1
	note __, 1
	note A#, 1
	note __, 1
	note B_, 1
	note __, 1
	loopchannel 0, Music_RivalBattleXY_Ch3_loop_main

Music_RivalBattleXY_Ch3_branch_1:
	octave 2
	note C_, 1
	note __, 1
	octave 3
	note C_, 1
	note __, 1
	loopchannel 8, Music_RivalBattleXY_Ch3_branch_1
	endchannel

Music_RivalBattleXY_Ch3_branch_2:
	octave 2
	note D#, 1
	note __, 1
	octave 3
	note D#, 1
	note __, 1
	loopchannel 8, Music_RivalBattleXY_Ch3_branch_2
	endchannel

Music_RivalBattleXY_Ch3_branch_3:
	octave 2
	note C#, 1
	note __, 1
	octave 3
	note C#, 1
	note __, 1
	loopchannel 7, Music_RivalBattleXY_Ch3_branch_3
	octave 2
	note C#, 2
	note D_, 2
	endchannel

Music_RivalBattleXY_Ch3_branch_4:
	octave 2
	note D#, 1
	note __, 1
	octave 3
	note D#, 1
	note __, 1
	loopchannel 4, Music_RivalBattleXY_Ch3_branch_4
	octave 2
	note D#, 1
	note __, 1
	note D#, 2
	note A#, 2
	note G_, 2
	note A#, 2
	note G_, 2
	note F_, 2
	note D#, 2
	endchannel

Music_RivalBattleXY_Ch3_branch_5:
	octave 3
	note C_, 1
	note __, 1
	note C_, 2
	note __, 2
	note C_, 2
	note __, 2
	note C_, 2
	note __, 2
	note C_, 1
	note __, 1
	octave 2
	note A#, 4
	note B_, 4
	octave 3
	note C_, 2
	note __, 2
	octave 2
	note G_, 2
	note __, 2
	note A#, 4
	note __, 2
	note A_, 2
	note __, 2
	note F_, 2
	note __, 2
	note F_, 1
	note __, 1
	endchannel

Music_RivalBattleXY_Ch4:
	togglenoise $3
	notetype $c
	note B_, 2
	note B_, 4
	note B_, 6
	note C_, 1
	note C_, 1
	note C_, 1
	note C_, 1
Music_RivalBattleXY_Ch4_loop:
	note D#, 2
	note D#, 2
	note C_, 2
	note D#, 2
	loopchannel 0, Music_RivalBattleXY_Ch4_loop
