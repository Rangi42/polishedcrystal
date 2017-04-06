; Pokémon R/S/E - Battle! Gym Leader
; Demixed by Mmmmmm
; https://pastebin.com/3iAgGV4u
; https://hax.iimarck.us/topic/6777/

Music_GymLeaderBattleRSE:
	dbw $c0, Music_GymLeaderBattleRSE_Ch1
	dbw $01, Music_GymLeaderBattleRSE_Ch2
	dbw $02, Music_GymLeaderBattleRSE_Ch3
	dbw $03, Music_GymLeaderBattleRSE_Ch4

Music_GymLeaderBattleRSE_Ch1:
	tempo 100
	dutycycle 1
	tone $0001
	notetype $C, $C4
	vibrato $12, $15
	octave 5
	note C_, 1
	octave 4
	note B_, 1
	note A#, 1
	note A_, 1
	note G#, 1
	note G_, 1
	note F#, 1
	note F_, 1
	note G#, 1
	note G_, 1
	note F#, 1
	note F_, 1
	note E_, 1
	note D#, 1
	note D_, 1
	note C#, 1
	note E_, 1
	note D#, 1
	note D_, 1
	note C#, 1
	note C_, 1
	octave 3
	note B_, 1
	note A#, 1
	note A_, 1
	octave 4
	note C_, 1
	octave 3
	note B_, 1
	note A#, 1
	note A_, 1
	note A#, 1
	note A_, 1
	note A#, 1
	note B_, 1
	octave 4
	note C_, 2
	note __, 4
	note C#, 2
	note __, 4
	octave 3
	note C_, 2
	note __, 2
	note G_, 2
	note __, 4
	note G#, 2
	note __, 4
	note C#, 4
	octave 4
	note C_, 2
	note __, 4
	note C#, 2
	note __, 4
	octave 3
	note C_, 2
	note __, 2
	note G_, 2
	note __, 4
	note G#, 2
	note __, 4
	octave 4
	note C#, 4
	octave 5
	note C_, 2
	note __, 4
	note C#, 2
	note __, 4
	octave 4
	note C_, 2
	note __, 2
	note G_, 2
	note __, 4
	note G#, 2
	note __, 4
	note C#, 4
	octave 5
	note C_, 2
	note __, 4
	note C#, 2
	note __, 4
	octave 4
	note G_, 2
	note __, 2
	octave 5
	note C_, 2
	note __, 4
	note C#, 2
	note __, 4
	note D#, 4
Music_GymLeaderBattleRSE_Ch1_loop:
	dutycycle 1
	intensity $C7
	octave 4
	note C_, 8
	octave 3
	note A#, 8
	octave 4
	note D_, 6
	octave 3
	note G_, 2
	note __, 2
	note G_, 2
	note A#, 2
	octave 4
	note D_, 2
	intensity $C0
	note E_, 6
	intensity $c7
	note E_, 6
	note D_, 2
	note E_, 2
	note F_, 2
	note E_, 2
	note __, 2
	note C_, 10
	note A#, 8
	note A_, 8
	note G_, 4
	note A_, 4
	note G_, 4
	note F_, 4
	intensity $C0
	note E_, 6
	intensity $c7
	note E_, 6
	note C_, 4
	intensity $C0
	note G_, 8
	intensity $c7
	note G_, 8
	note A#, 8
	note A_, 8
	note A#, 4
	note A_, 4
	octave 5
	note D_, 4
	note F_, 4
	intensity $C0
	note E_, 6
	intensity $c7
	note E_, 6
	note D_, 4
	intensity $C0
	note C_, 8
	intensity $c7
	note C_, 8
	vibrato $11, $26
	octave 4
	note C_, 8
	octave 3
	note A#, 8
	octave 4
	note D_, 6
	octave 3
	note G_, 2
	note __, 2
	note G_, 2
	note A#, 2
	octave 4
	note D_, 2
	intensity $C0
	note E_, 6
	intensity $c7
	note E_, 6
	note D_, 2
	note E_, 2
	note F_, 2
	note E_, 2
	note __, 2
	note C_, 10
	note A#, 8
	note A_, 8
	note G_, 4
	note A_, 4
	note G_, 4
	note F_, 4
	intensity $C0
	note E_, 6
	intensity $c7
	note E_, 6
	note C_, 4
	intensity $C0
	note G_, 4
	intensity $c7
	note G_, 6
	note G_, 2
	octave 5
	note C_, 2
	note __, 2
	octave 4
	note A#, 8
	note A_, 8
	note A#, 4
	note A_, 4
	octave 5
	note D_, 4
	note F_, 4
	intensity $C0
	note E_, 6
	intensity $C7
	note E_, 6
	note C_, 4
	intensity $C0
	note G_, 6
	intensity $C7
	note G_, 10
	dutycycle 3
	octave 3
	intensity $C4
	note C_, 6
	octave 2
	note A#, 6
	octave 3
	note C_, 4
	note D_, 6
	octave 2
	note A#, 6
	octave 3
	note D_, 4
	intensity $C0
	note C_, 4
	intensity $C4
	note C_, 12
	note __, 16
	note __, 16
	note __, 16
	intensity $90
	octave 3
	note C_, 16
	note C_, 11
	notetype $3, $90
	note C_, 3
	note __, 1
	notetype $C, $90
	note C_, 2
	octave 2
	note A#, 2
	octave 3
	note C#, 16
	note D#, 16
	note C_, 16
	octave 4
	intensity $A0
	note C_, 11
	notetype $3, $A0
	note C_, 3
	note __, 1
	notetype $C, $A0
	note C_, 2
	octave 3
	note A#, 2
	octave 4
	note C#, 16
	note D#, 16
	note F_, 16
	note F_, 16
	note F_, 16
	note F_, 16
	note F_, 16
	note F_, 16
	intensity $A0
	octave 3
	note C_, 8
	intensity $A7
	note C_, 8
	octave 2
	note A#, 7
	octave 3
	note C_, 1
	note D_, 8
	intensity $A0
	octave 2
	note G_, 8
	intensity $A7
	note G_, 8
	intensity $A0
	octave 3
	note C_, 8
	intensity $A7
	note C_, 8
	intensity $A0
	note C#, 8
	intensity $A7
	note C#, 8
	octave 2
	note A#, 8
	octave 3
	note C#, 6
	note E_, 2
	intensity $A0
	note C_, 8
	intensity $A7
	note C_, 8
	intensity $A0
	note E_, 8
	intensity $A7
	note E_, 8
	loopchannel 0, Music_GymLeaderBattleRSE_Ch1_loop

Music_GymLeaderBattleRSE_Ch2:
	tone $0001
	dutycycle 2
	notetype $C, $94
	vibrato $12, $15
	octave 5
	note G_, 1
	note G#, 1
	note G_, 2
	loopchannel 8, Music_GymLeaderBattleRSE_Ch2
	intensity $70
	octave 3
	note C_, 8
	octave 2
	note C_, 8
	note G_, 8
	note C#, 8
	octave 3
	note C_, 8
	note G_, 8
	octave 4
	note C_, 8
	octave 3
	note C#, 8
	dutycycle 1
	intensity $90
	note C_, 8
	octave 2
	note C_, 8
	note G_, 8
	note C#, 8
	octave 3
	note C_, 8
	octave 2
	note C_, 8
	octave 3
	note C#, 8
	octave 2
	note D#, 8
Music_GymLeaderBattleRSE_Ch2_loop_main:
	dutycycle 3
	intensity $C7
	octave 3
	note G_, 8
	note F_, 7
	note G#, 1
	note G_, 6
	note C_, 2
	note __, 2
	note C_, 2
	note D_, 2
	note F_, 2
	note G_, 6
	octave 4
	note C_, 6
	octave 3
	note A#, 2
	note A_, 2
	note A#, 2
	octave 4
	note C_, 2
	note __, 2
	octave 3
	intensity $97
	octave 3
	note E_, 2
	note E_, 2
	note E_, 2
	note E_, 2
	note E_, 2
	intensity $C7
	octave 4
	note D_, 8
	note C_, 8
	octave 3
	note A#, 4
	octave 4
	note C_, 4
	octave 3
	note A#, 4
	note A_, 4
	intensity $C0
	note G_, 6
	intensity $c7
	note G_, 6
	note E_, 4
	octave 4
	intensity $C0
	note C_, 4
	intensity $c7
	note C_, 6
	intensity $A7
	dutycycle 0
	octave 4
	note E_, 2
	note C_, 2
	octave 3
	note G_, 2
	note F_, 2
	note A#, 2
	octave 4
	note D_, 2
	note F_, 2
	note A_, 2
	note F_, 2
	note D_, 2
	octave 3
	note A#, 2
	note F_, 2
	note A#, 2
	octave 4
	note D_, 2
	note F_, 2
	note A_, 2
	note F_, 2
	note D_, 2
	octave 3
	note A#, 2
	note G_, 2
	octave 4
	note C_, 2
	note E_, 2
	note G_, 2
	octave 5
	note C_, 2
	octave 4
	note G_, 2
	note E_, 2
	note C_, 2
	octave 3
	note G_, 2
	octave 4
	note C_, 2
	note E_, 2
	note G_, 2
	octave 5
	note C_, 2
	octave 4
	note G_, 2
	note E_, 2
	note C_, 2
	octave 5
	note C_, 2
	octave 4
	note G_, 2
	octave 5
	note C_, 2
	note F_, 4
	note E_, 2
	note D_, 2
	note C_, 2
	octave 4
	note A#, 2
	note F_, 2
	note A#, 2
	octave 5
	note D_, 4
	note C_, 2
	octave 4
	note A#, 2
	octave 5
	note D_, 2
	note E_, 6
	note C_, 6
	note D_, 2
	note E_, 2
	note F_, 2
	octave 5
	note E_, 2
	note __, 2
	note C_, 10
	intensity $C7
	dutycycle 3
	octave 4
	note D_, 8
	note C_, 8
	octave 3
	note A#, 4
	octave 4
	note C_, 4
	octave 3
	note A#, 4
	note A_, 4
	intensity $C0
	note G_, 6
	intensity $c7
	note G_, 6
	note E_, 4
	octave 4
	intensity $C0
	note C_, 4
	intensity $c7
	note C_, 6
	intensity $A7
	dutycycle 0
	octave 4
	note E_, 2
	note C_, 2
	octave 3
	note G_, 2
	note F_, 2
	note A#, 2
	octave 4
	note D_, 2
	note F_, 2
	note A_, 2
	note F_, 2
	note D_, 2
	octave 3
	note A#, 2
	note F_, 2
	note A#, 2
	octave 4
	note D_, 2
	note F_, 2
	note A_, 2
	note F_, 2
	note D_, 2
	octave 3
	note A#, 2
	note G_, 2
	octave 4
	note C_, 2
	note E_, 2
	note G_, 2
	octave 5
	note C_, 2
	octave 4
	note G_, 2
	note E_, 2
	note C_, 2
	octave 3
	note G_, 2
	octave 4
	note C_, 2
	note E_, 2
	note G_, 2
	octave 5
	note C_, 2
	octave 4
	note G_, 2
	note E_, 2
	note C_, 2
	dutycycle 3
	intensity $A4
	octave 3
	note G_, 6
	note F_, 6
	note G_, 4
	note A_, 6
	note F_, 6
	note A_, 4
	intensity $A0
	note G_, 4
	intensity $A4
	note G_, 12
	intensity $90
	octave 2
	note C_, 11
	notetype $3, $90
	note C_, 3
	note __, 1
	notetype $C, $90
	note C_, 2
	octave 1
	note A#, 2
	octave 2
	note C#, 16
	note D#, 16
	note C_, 16
	note C_, 11
	notetype $3, $90
	note C_, 3
	note __, 1
	notetype $C, $90
	note C_, 2
	octave 1
	note A#, 2
	octave 2
	note C#, 16
	note D#, 16
	note C_, 16
	note C_, 11
	notetype $3, $90
	note C_, 3
	note __, 1
	notetype $C, $90
	note C_, 2
	octave 1
	note A#, 2
	octave 2
	note C#, 16
	note D#, 16
	octave 1
	note A#, 16
	note A#, 16
	dutycycle 0
	octave 3
	intensity $A7
	note A#, 2
	note A#, 2
	note A#, 6
	note A#, 2
	note A#, 2
	note A#, 2
	note F_, 2
	note F_, 2
	note F_, 6
	note F_, 2
	note F_, 2
	note F_, 2
	note D#, 2
	note D#, 2
	note D#, 6
	note D#, 2
	note D#, 2
	note D#, 2
	note D_, 2
	note D_, 2
	note D_, 6
	note D_, 2
	note D_, 2
	note D_, 2
	intensity $84
	callchannel Music_GymLeaderBattleRSE_Ch2_branch_1
	callchannel Music_GymLeaderBattleRSE_Ch2_branch_1
	callchannel Music_GymLeaderBattleRSE_Ch2_branch_2
	callchannel Music_GymLeaderBattleRSE_Ch2_branch_2
	callchannel Music_GymLeaderBattleRSE_Ch2_branch_3
	callchannel Music_GymLeaderBattleRSE_Ch2_branch_3
	callchannel Music_GymLeaderBattleRSE_Ch2_branch_2
	callchannel Music_GymLeaderBattleRSE_Ch2_branch_2
	loopchannel 0, Music_GymLeaderBattleRSE_Ch2_loop_main

Music_GymLeaderBattleRSE_Ch2_branch_1:
	dutycycle 0
	octave 3
	note G_, 2
	note C_, 2
	note G_, 2
	octave 4
	note C_, 2
	note G_, 2
	note C_, 2
	octave 3
	note G_, 2
	octave 4
	note C_, 2
	endchannel

Music_GymLeaderBattleRSE_Ch2_branch_2:
	dutycycle 1
	octave 3
	note G_, 2
	note C_, 2
	note G_, 2
	octave 4
	note C_, 2
	note E_, 2
	note C_, 2
	octave 3
	note G_, 2
	octave 4
	note C_, 2
	endchannel

Music_GymLeaderBattleRSE_Ch2_branch_3:
	dutycycle 0
	octave 3
	note G#, 2
	note C#, 2
	note G#, 2
	octave 4
	note C#, 2
	note G#, 2
	note C#, 2
	octave 3
	note G#, 2
	octave 4
	note C#, 2
	endchannel

Music_GymLeaderBattleRSE_Ch3:
	stereopanning $ff
	notetype $C, $19
	octave 3
	note C_, 4
	octave 2
	note C_, 4
	note A#, 4
	note C#, 4
	note G#, 4
	note A#, 2
	note G#, 2
	note G_, 2
	note F_, 2
	note D#, 2
	note C#, 2
Music_GymLeaderBattleRSE_Ch3_loop_1:
	callchannel Music_GymLeaderBattleRSE_Ch3_branch_1
	note F_, 2
	callchannel Music_GymLeaderBattleRSE_Ch3_branch_1
	note C#, 2
	loopchannel 4, Music_GymLeaderBattleRSE_Ch3_loop_1
Music_GymLeaderBattleRSE_Ch3_loop_main:
	callchannel Music_GymLeaderBattleRSE_Ch3_branch_2
	callchannel Music_GymLeaderBattleRSE_Ch3_branch_2
	callchannel Music_GymLeaderBattleRSE_Ch3_branch_2
	note C_, 2
	note G_, 2
	note C_, 2
	note D_, 2
	callchannel Music_GymLeaderBattleRSE_Ch3_branch_2
	callchannel Music_GymLeaderBattleRSE_Ch3_branch_2
	callchannel Music_GymLeaderBattleRSE_Ch3_branch_2
	note G_, 2
	note C_, 2
	note D_, 2
	note C_, 2
	callchannel Music_GymLeaderBattleRSE_Ch3_branch_3
	callchannel Music_GymLeaderBattleRSE_Ch3_branch_3
	callchannel Music_GymLeaderBattleRSE_Ch3_branch_3
	octave 1
	note A#, 2
	octave 2
	note F_, 2
	octave 1
	note A#, 2
	note B_, 2
	octave 2
	callchannel Music_GymLeaderBattleRSE_Ch3_branch_2
	callchannel Music_GymLeaderBattleRSE_Ch3_branch_2
	callchannel Music_GymLeaderBattleRSE_Ch3_branch_2
	note C_, 2
	note G_, 2
	note E_, 2
	note G_, 2
	callchannel Music_GymLeaderBattleRSE_Ch3_branch_3
	callchannel Music_GymLeaderBattleRSE_Ch3_branch_3
	callchannel Music_GymLeaderBattleRSE_Ch3_branch_3
	callchannel Music_GymLeaderBattleRSE_Ch3_branch_3
	callchannel Music_GymLeaderBattleRSE_Ch3_branch_2
	callchannel Music_GymLeaderBattleRSE_Ch3_branch_2
	callchannel Music_GymLeaderBattleRSE_Ch3_branch_2
	note C_, 2
	note G_, 2
	octave 3
	note C_, 2
	octave 2
	note G_, 2
	callchannel Music_GymLeaderBattleRSE_Ch3_branch_2
	callchannel Music_GymLeaderBattleRSE_Ch3_branch_2
	callchannel Music_GymLeaderBattleRSE_Ch3_branch_2
	callchannel Music_GymLeaderBattleRSE_Ch3_branch_2
	callchannel Music_GymLeaderBattleRSE_Ch3_branch_2
	callchannel Music_GymLeaderBattleRSE_Ch3_branch_2
	note C_, 2
	note G_, 2
	note __, 2
	note G_, 2
	octave 3
	note C_, 2
	octave 2
	note C_, 2
	note D_, 2
	note C_, 2
	callchannel Music_GymLeaderBattleRSE_Ch3_branch_3
	callchannel Music_GymLeaderBattleRSE_Ch3_branch_3
	callchannel Music_GymLeaderBattleRSE_Ch3_branch_3
	octave 1
	note A#, 2
	octave 2
	note F_, 2
	octave 1
	note A#, 2
	note B_, 2
	octave 2
	callchannel Music_GymLeaderBattleRSE_Ch3_branch_2
	callchannel Music_GymLeaderBattleRSE_Ch3_branch_2
	callchannel Music_GymLeaderBattleRSE_Ch3_branch_2
	note C_, 2
	note G_, 2
	note E_, 2
	note C_, 2
	callchannel Music_GymLeaderBattleRSE_Ch3_branch_3
	callchannel Music_GymLeaderBattleRSE_Ch3_branch_3
	callchannel Music_GymLeaderBattleRSE_Ch3_branch_3
	callchannel Music_GymLeaderBattleRSE_Ch3_branch_3
	callchannel Music_GymLeaderBattleRSE_Ch3_branch_2
	callchannel Music_GymLeaderBattleRSE_Ch3_branch_2
	callchannel Music_GymLeaderBattleRSE_Ch3_branch_2
	note C_, 2
	note G_, 2
	note E_, 2
	note G_, 2
	callchannel Music_GymLeaderBattleRSE_Ch3_branch_2
	callchannel Music_GymLeaderBattleRSE_Ch3_branch_2
	callchannel Music_GymLeaderBattleRSE_Ch3_branch_2
	callchannel Music_GymLeaderBattleRSE_Ch3_branch_2
Music_GymLeaderBattleRSE_Ch3_loop_2:
	callchannel Music_GymLeaderBattleRSE_Ch3_branch_2
	callchannel Music_GymLeaderBattleRSE_Ch3_branch_2
	callchannel Music_GymLeaderBattleRSE_Ch3_branch_2
	callchannel Music_GymLeaderBattleRSE_Ch3_branch_2
	callchannel Music_GymLeaderBattleRSE_Ch3_branch_4
	callchannel Music_GymLeaderBattleRSE_Ch3_branch_4
	callchannel Music_GymLeaderBattleRSE_Ch3_branch_5
	callchannel Music_GymLeaderBattleRSE_Ch3_branch_5
	loopchannel 3, Music_GymLeaderBattleRSE_Ch3_loop_2
Music_GymLeaderBattleRSE_Ch3_loop_3:
	callchannel Music_GymLeaderBattleRSE_Ch3_branch_3
	loopchannel 12, Music_GymLeaderBattleRSE_Ch3_loop_3
Music_GymLeaderBattleRSE_Ch3_loop_4:
	callchannel Music_GymLeaderBattleRSE_Ch3_branch_2
	loopchannel 8, Music_GymLeaderBattleRSE_Ch3_loop_4
	callchannel Music_GymLeaderBattleRSE_Ch3_branch_3
	callchannel Music_GymLeaderBattleRSE_Ch3_branch_3
	callchannel Music_GymLeaderBattleRSE_Ch3_branch_3
	callchannel Music_GymLeaderBattleRSE_Ch3_branch_3
	callchannel Music_GymLeaderBattleRSE_Ch3_branch_2
	callchannel Music_GymLeaderBattleRSE_Ch3_branch_2
	callchannel Music_GymLeaderBattleRSE_Ch3_branch_2
	callchannel Music_GymLeaderBattleRSE_Ch3_branch_2
	loopchannel 0, Music_GymLeaderBattleRSE_Ch3_loop_main

Music_GymLeaderBattleRSE_Ch3_branch_1:
	note C_, 2
	note F#, 2
	note F_, 2
	note D#, 2
	note F#, 2
	note D#, 1
	note __, 1
	note D#, 2
	endchannel

Music_GymLeaderBattleRSE_Ch3_branch_2:
	note C_, 2
	note G_, 2
	note C_, 2
	note G_, 2
	endchannel

Music_GymLeaderBattleRSE_Ch3_branch_3:
	octave 1
	note A#, 2
	octave 2
	note F_, 2
	octave 1
	note A#, 2
	octave 2
	note F_, 2
	endchannel

Music_GymLeaderBattleRSE_Ch3_branch_4:
	note C#, 2
	note G#, 2
	note C#, 2
	note G#, 2
	endchannel

Music_GymLeaderBattleRSE_Ch3_branch_5:
	note D#, 2
	note A#, 2
	note D#, 2
	note A#, 2
	endchannel

Music_GymLeaderBattleRSE_Ch4:
	togglenoise $3
	notetype $c
	note C_, 6
	note C_, 8
	note D#, 4
	note C_, 6
	note C_, 4
	note D#, 4
Music_GymLeaderBattleRSE_Ch4_loop_1:
	callchannel Music_GymLeaderBattleRSE_Ch4_branch_1
	loopchannel 8, Music_GymLeaderBattleRSE_Ch4_loop_1
Music_GymLeaderBattleRSE_Ch4_loop_main:
	callchannel Music_GymLeaderBattleRSE_Ch4_branch_2
	loopchannel 11, Music_GymLeaderBattleRSE_Ch4_loop_main
	callchannel Music_GymLeaderBattleRSE_Ch4_branch_1
Music_GymLeaderBattleRSE_Ch4_loop_2:
	callchannel Music_GymLeaderBattleRSE_Ch4_branch_2
	loopchannel 11, Music_GymLeaderBattleRSE_Ch4_loop_2
	callchannel Music_GymLeaderBattleRSE_Ch4_branch_1
	callchannel Music_GymLeaderBattleRSE_Ch4_branch_1
	callchannel Music_GymLeaderBattleRSE_Ch4_branch_2
	callchannel Music_GymLeaderBattleRSE_Ch4_branch_1
	callchannel Music_GymLeaderBattleRSE_Ch4_branch_2
	callchannel Music_GymLeaderBattleRSE_Ch4_branch_2
Music_GymLeaderBattleRSE_Ch4_loop_3:
	callchannel Music_GymLeaderBattleRSE_Ch4_branch_2
	loopchannel 15, Music_GymLeaderBattleRSE_Ch4_loop_3
Music_GymLeaderBattleRSE_Ch4_loop_4:
	callchannel Music_GymLeaderBattleRSE_Ch4_branch_3
	loopchannel 6, Music_GymLeaderBattleRSE_Ch4_loop_4
	note __, 4
	note C_, 4
	note C_, 2
	note C_, 4
	note C_, 2
	note C_, 8
	note C_, 2
	note C_, 6
	loopchannel 0, Music_GymLeaderBattleRSE_Ch4_loop_main

Music_GymLeaderBattleRSE_Ch4_branch_1:
	note C_, 6
	note C_, 10
	endchannel

Music_GymLeaderBattleRSE_Ch4_branch_2:
	note C_, 6
	note C_, 8
	note D#, 2
	endchannel

Music_GymLeaderBattleRSE_Ch4_branch_3:
	note C_, 8
	note C_, 2
	note C_, 4
	note C_, 2
	endchannel
