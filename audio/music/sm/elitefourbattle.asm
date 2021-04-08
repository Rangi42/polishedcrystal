; Pokémon S/M - Battle! Elite Four
; Demixed by Mmmmmm
; https://pastebin.com/Q2MsZc9W
; https://hax.iimarckus.org/topic/6777/8/

Music_EliteFourBattleSM:
	musicheader 4, 1, Music_EliteFourBattleSM_Ch1
	musicheader 1, 2, Music_EliteFourBattleSM_Ch2
	musicheader 1, 3, Music_EliteFourBattleSM_Ch3
	musicheader 1, 4, Music_EliteFourBattleSM_Ch4

Music_EliteFourBattleSM_Ch1:
	tempo 184
	volume $77
	dutycycle 0
	tone $0002
	vibrato $12, $15
	notetype $6, $12
	note __, 16
	note __, 16
	note __, 16
	callchannel Music_EliteFourBattleSM_Ch1_branch_1
	intensity $22
	callchannel Music_EliteFourBattleSM_Ch1_branch_1
	intensity $31
	callchannel Music_EliteFourBattleSM_Ch1_branch_1
	intensity $41
	callchannel Music_EliteFourBattleSM_Ch1_branch_1
	intensity $51
	callchannel Music_EliteFourBattleSM_Ch1_branch_1
	intensity $61
	callchannel Music_EliteFourBattleSM_Ch1_branch_1
	intensity $71
	callchannel Music_EliteFourBattleSM_Ch1_branch_1
	intensity $81
	callchannel Music_EliteFourBattleSM_Ch1_branch_1
	intensity $91
	callchannel Music_EliteFourBattleSM_Ch1_branch_1
Music_EliteFourBattleSM_Ch1_loop_main:
Music_EliteFourBattleSM_Ch1_loop_1:
	octave 2
	intensity $b1
	note B_, 2
	note B_, 2
	note B_, 2
	note B_, 4
	intensity $b4
	note B_, 4
	intensity $b1
	note B_, 2
	octave 3
	note C_, 2
	note C_, 2
	note C_, 2
	note C_, 4
	intensity $b4
	note C_, 4
	intensity $b1
	note C_, 2
	note D_, 2
	note D_, 2
	note D_, 2
	note D_, 4
	intensity $b4
	note D_, 4
	intensity $b2
	note D_, 2
	note C_, 4
	octave 2
	intensity $91
	note F_, 2
	intensity $92
	note F_, 4
	note F_, 4
	intensity $91
	note F_, 1
	note F_, 1
	loopchannel 2, Music_EliteFourBattleSM_Ch1_loop_1
	note __, 16
	dutycycle 2
	intensity $87
	note E_, 6
	note F_, 6
	note E_, 4
	note G_, 6
	note G#, 6
	note G_, 4
	note A#, 4
	note G#, 4
	note G_, 4
	note F_, 4
	note C_, 6
	note C#, 6
	note C_, 4
	note E_, 6
	note F_, 6
	note E_, 4
	note G_, 6
	note G#, 6
	note G_, 4
	note A#, 4
	note G#, 4
	note G_, 4
	note F_, 4
	intensity $80
	note E_, 8
	intensity $84
	note E_, 8
	note __, 16
	note __, 16
	note __, 16
	dutycycle 0
Music_EliteFourBattleSM_Ch1_loop_2:
	intensity $92
	note B_, 4
	intensity $91
	note B_, 2
	intensity $92
	note B_, 4
	note B_, 4
	intensity $91
	note B_, 1
	note B_, 1
	loopchannel 4, Music_EliteFourBattleSM_Ch1_loop_2
	dutycycle 1
Music_EliteFourBattleSM_Ch1_loop_3:
	octave 3
	note E_, 2
	octave 2
	note B_, 2
	octave 3
	note E_, 2
	note A#, 4
	note G_, 4
	note D#, 2
	loopchannel 4, Music_EliteFourBattleSM_Ch1_loop_3
	note E_, 2
	octave 2
	note B_, 2
	octave 3
	note E_, 2
	note B_, 4
	note G_, 4
	note D#, 2
	intensity $a1
	note E_, 2
	octave 2
	note B_, 2
	octave 3
	note E_, 2
	note B_, 4
	note G_, 4
	note D#, 2
	intensity $b1
	octave 4
	note E_, 2
	octave 3
	note B_, 2
	octave 4
	note E_, 2
	note A_, 2
	intensity $c1
	note B_, 2
	note G_, 2
	octave 3
	note B_, 2
	octave 4
	note D#, 2
	intensity $d1
	note E_, 2
	octave 3
	note B_, 2
	octave 4
	note E_, 2
	note A_, 2
	intensity $e1
	note B_, 2
	note G_, 2
	octave 3
	note B_, 2
	octave 4
	note D#, 2
	dutycycle 0
	intensity $d2
	octave 3
	note __, 8
	note E_, 2
	note D#, 4
	note A#, 2
	intensity $d7
	note A_, 12
	intensity $6f
	note A_, 12
	intensity $d2
	note E_, 2
	note D#, 4
	note A#, 2
	intensity $d7
	note A_, 12
	intensity $6f
	note A_, 12
	intensity $d2
	note A#, 2
	note A_, 4
	octave 4
	note E_, 2
	intensity $d6
	note D#, 12
	intensity $6f
	note D#, 12
	intensity $d2
	octave 3
	note A#, 2
	note A_, 4
	octave 4
	note E_, 2
	intensity $d7
	note D#, 8
	intensity $8e
	note D#, 8
	loopchannel 0, Music_EliteFourBattleSM_Ch1_loop_main

Music_EliteFourBattleSM_Ch1_branch_1:
	octave 3
	note E_, 2
	octave 2
	note B_, 2
	octave 3
	note E_, 2
	note A_, 2
	note B_, 2
	note G_, 2
	octave 2
	note B_, 2
	octave 3
	note D#, 2
	endchannel

Music_EliteFourBattleSM_Ch2:
	dutycycle 1
	vibrato $8, $36
	tone $0001
	notetype $6, $a2
	octave 3
	note F_, 4
	intensity $a1
	note F_, 2
	intensity $a2
	note F_, 4
	note F_, 4
	intensity $a1
	note F_, 1
	note F_, 1
	loopchannel 3, Music_EliteFourBattleSM_Ch2
	note __, 16
Music_EliteFourBattleSM_Ch2_loop_1:
	intensity $a2
	note G_, 4
	intensity $a1
	note G_, 2
	intensity $a2
	note G_, 4
	note G_, 4
	intensity $a1
	note G_, 1
	note G_, 1
	loopchannel 3, Music_EliteFourBattleSM_Ch2_loop_1
	note __, 16
Music_EliteFourBattleSM_Ch2_loop_2:
	intensity $a2
	note A_, 4
	intensity $a1
	note A_, 2
	intensity $a2
	note A_, 4
	note A_, 4
	intensity $a1
	note A_, 1
	note A_, 1
	loopchannel 3, Music_EliteFourBattleSM_Ch2_loop_2
	note __, 16
Music_EliteFourBattleSM_Ch2_loop_main:
Music_EliteFourBattleSM_Ch2_loop_3:
	octave 4
	intensity $c1
	note E_, 2
	note E_, 2
	note E_, 2
	note E_, 4
	intensity $c4
	note E_, 4
	intensity $c1
	note E_, 2
	note F_, 2
	note F_, 2
	note F_, 2
	note F_, 4
	intensity $c4
	note F_, 4
	intensity $c1
	note F_, 2
	note G_, 2
	note G_, 2
	note G_, 2
	note G_, 4
	intensity $c4
	note G_, 4
	intensity $c2
	note G_, 2
	intensity $c1
	note F_, 16
	loopchannel 2, Music_EliteFourBattleSM_Ch2_loop_3
	intensity $b7
	octave 3
	note E_, 6
	note F_, 6
	note E_, 4
	note G_, 6
	note G#, 6
	note G_, 4
	note A#, 4
	note G#, 4
	note G_, 4
	note F_, 4
	note E_, 6
	note F_, 6
	note G_, 4
	note E_, 6
	note F_, 6
	note E_, 4
	note G_, 6
	note G#, 6
	note G_, 4
	note A#, 4
	note G#, 4
	note G_, 4
	note F_, 4
	note G_, 6
	note G#, 6
	octave 4
	note D#, 4
	intensity $b0
	note E_, 8
	intensity $b4
	note E_, 8
	dutycycle 0
	octave 2
Music_EliteFourBattleSM_Ch2_loop_4:
	dutycycle 0
	intensity $92
	note B_, 4
	intensity $91
	note B_, 2
	intensity $92
	note B_, 4
	note B_, 4
	intensity $91
	note B_, 1
	note B_, 1
	loopchannel 3, Music_EliteFourBattleSM_Ch2_loop_4
	dutycycle 2
	intensity $80
	note E_, 8
	note F_, 8
	note E_, 2
	note __, 14
	note E_, 8
	note F_, 8
	note G_, 2
	note __, 14
	note E_, 8
	note F_, 8
	note E_, 2
	note __, 14
	note E_, 8
	note F_, 8
	note G_, 16
	intensity $90
	note A_, 16
	intensity $a0
	note B_, 16
	note B_, 16
	note B_, 16
	intensity $e2
	dutycycle 1
	octave 4
	note E_, 2
	note D#, 4
	note A#, 2
	note A_, 4
	note A_, 2
	note G#, 2
	note G_, 2
	note F#, 4
	note D_, 2
	note C#, 4
	note F_, 4
	note E_, 2
	note D#, 4
	note A#, 2
	note A_, 4
	note A_, 2
	note G#, 2
	note G_, 2
	note F#, 4
	note D_, 2
	note C#, 4
	note F_, 4
	octave 3
	note A#, 2
	note A_, 4
	octave 4
	note E_, 2
	note D#, 4
	note D#, 2
	note D_, 2
	note C#, 2
	note C_, 4
	octave 3
	note G#, 2
	note G_, 4
	note B_, 4
	note A#, 2
	note A_, 4
	octave 4
	note E_, 2
	note D#, 4
	note D#, 2
	note D_, 2
	note C#, 2
	note C_, 4
	octave 3
	note G#, 2
	note G_, 4
	note B_, 4
	loopchannel 0, Music_EliteFourBattleSM_Ch2_loop_main

Music_EliteFourBattleSM_Ch3:
	octave 2
	callchannel Music_EliteFourBattleSM_Ch3_branch_1
	callchannel Music_EliteFourBattleSM_Ch3_branch_1
	callchannel Music_EliteFourBattleSM_Ch3_branch_1
Music_EliteFourBattleSM_Ch3_loop_main:
Music_EliteFourBattleSM_Ch3_loop_1:
	notetype $6, $19
	note E_, 2
	note B_, 2
	note E_, 2
	note B_, 2
	note E_, 2
	note B_, 2
	note E_, 2
	note B_, 2
	note F_, 2
	octave 3
	note C_, 2
	octave 2
	note F_, 2
	octave 3
	note C_, 2
	octave 2
	note F_, 2
	octave 3
	note C_, 2
	octave 2
	note F_, 2
	octave 3
	note C_, 2
	octave 2
	note G_, 2
	octave 3
	note D_, 2
	octave 2
	note G_, 2
	octave 3
	note D_, 1
	note __, 1
	note D_, 2
	octave 2
	note G_, 2
	octave 3
	note D_, 2
	octave 2
	note G_, 2
	note F_, 2
	note E_, 2
	note D_, 2
	note A_, 2
	note F_, 2
	note E_, 2
	note D_, 2
	note D#, 2
	loopchannel 2, Music_EliteFourBattleSM_Ch3_loop_1
Music_EliteFourBattleSM_Ch3_loop_2:
	note E_, 2
	note B_, 2
	loopchannel 15, Music_EliteFourBattleSM_Ch3_loop_2
	octave 3
	note C_, 2
	octave 2
	note B_, 2
Music_EliteFourBattleSM_Ch3_loop_3:
	note E_, 2
	note B_, 2
	loopchannel 15, Music_EliteFourBattleSM_Ch3_loop_3
	octave 3
	note C_, 2
	octave 2
	note B_, 2
Music_EliteFourBattleSM_Ch3_loop_4:
	note E_, 2
	note B_, 2
	loopchannel 13, Music_EliteFourBattleSM_Ch3_loop_4
	octave 3
	note C_, 2
	octave 2
	note B_, 2
	octave 3
	note D_, 2
	note C#, 2
	note C_, 2
	octave 2
	note B_, 2
Music_EliteFourBattleSM_Ch3_loop_5:
	note E_, 2
	note B_, 2
	loopchannel 5, Music_EliteFourBattleSM_Ch3_loop_5
	octave 3
	note C_, 2
	octave 2
	note B_, 2
	octave 3
	note D_, 2
	note C#, 2
	note C_, 2
	octave 2
	note B_, 2
Music_EliteFourBattleSM_Ch3_loop_6:
	note E_, 2
	note B_, 2
	loopchannel 5, Music_EliteFourBattleSM_Ch3_loop_6
	octave 3
	note C_, 2
	octave 2
	note B_, 2
	octave 3
	note D_, 2
	note C#, 2
	note C_, 2
	octave 2
	note B_, 2
Music_EliteFourBattleSM_Ch3_loop_7:
	note E_, 2
	note B_, 2
	note E_, 2
	note B_, 2
	loopchannel 14, Music_EliteFourBattleSM_Ch3_loop_7
	note E_, 2
	note B_, 2
	octave 1
	note B_, 2
	octave 2
	note D#, 2
	note E_, 2
	note D#, 2
	octave 1
	note B_, 2
	octave 2
	note D#, 2
Music_EliteFourBattleSM_Ch3_loop_8:
	note E_, 2
	note B_, 2
	loopchannel 15, Music_EliteFourBattleSM_Ch3_loop_8
	octave 3
	note C_, 2
	octave 2
	note B_, 2
Music_EliteFourBattleSM_Ch3_loop_9:
	note E_, 2
	note A_, 2
	loopchannel 16, Music_EliteFourBattleSM_Ch3_loop_9
	loopchannel 0, Music_EliteFourBattleSM_Ch3_loop_main

Music_EliteFourBattleSM_Ch3_branch_1:
	notetype $3, $19
	note E_, 3
	note __, 1
	intensity $29
	note E_, 3
	note __, 1
	note E_, 3
	note __, 1
	loopchannel 8, Music_EliteFourBattleSM_Ch3_branch_1
	intensity $19
	note F_, 4
	note __, 12
	note __, 16
	endchannel

Music_EliteFourBattleSM_Ch4:
	togglenoise $3
	notetype $c
	note __, 16
	note __, 16
	note __, 16
	note __, 16
	note __, 16
	note __, 8
	note C#, 1
	note C#, 2
	note C#, 1
	note C#, 2
	note C_, 1
	note C_, 1
Music_EliteFourBattleSM_Ch4_loop_main:
Music_EliteFourBattleSM_Ch4_loop_1:
	notetype $6
	note D#, 4
	note C_, 2
	note G#, 1
	note G_, 1
	note D#, 2
	note D#, 2
	note C_, 4
	loopchannel 16, Music_EliteFourBattleSM_Ch4_loop_1
	note B_, 16
	note __, 16
	note __, 16
	note __, 16
Music_EliteFourBattleSM_Ch4_loop_2:
	note C#, 1
	note C#, 1
	note C#, 2
	note C#, 2
	note C#, 1
	note C#, 1
	note C#, 1
	note C#, 2
	note C#, 1
	note C#, 1
	note C#, 1
	note C#, 1
	note C#, 1
	loopchannel 11, Music_EliteFourBattleSM_Ch4_loop_2
	note B_, 2
	note C_, 1
	note C_, 1
	note B_, 2
	note C_, 1
	note C_, 1
	note B_, 2
	note C_, 1
	note C_, 1
	note B_, 2
	note C_, 1
	note C_, 1
Music_EliteFourBattleSM_Ch4_loop_3:
	note C_, 1
	note C_, 1
	note C_, 1
	note C_, 1
	note C_, 2
	note C_, 1
	note C_, 1
	note C_, 1
	note C_, 1
	note C_, 2
	note C_, 1
	note C_, 1
	note C_, 1
	note C_, 1
	loopchannel 8, Music_EliteFourBattleSM_Ch4_loop_3
	loopchannel 0, Music_EliteFourBattleSM_Ch4_loop_main
