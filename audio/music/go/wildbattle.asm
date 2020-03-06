; Pokémon Go - Battle! Wild Pokémon
; Demixed by ShockSlayer
; https://soundcloud.com/user-927422935-571023782/pokemon-go-wild-battle-8-bit-1/s-4NapJ

Music_WildBattleGo:
	musicheader 4, 1, Music_WildBattleGo_Ch1
	musicheader 1, 2, Music_WildBattleGo_Ch2
	musicheader 1, 3, Music_WildBattleGo_Ch3
	musicheader 1, 4, Music_WildBattleGo_Ch4

Music_WildBattleGo_Ch1:
	tempo $70
	volume $77
	stereopanning $77
	sound_duty $5A
	octave 3
	notetype $C, $A3
	note D_, 1
	note F#, 1
	note A_, 1
	octave 4
	note C#, 1
	note D_, 2
	note __, 4
	octave 3
	note D_, 1
	note __, 5
	note D_, 1
	note __, 3
	note D_, 1
	note __, 5
	note D_, 1
	note __, 5
Music_WildBattleGo_Ch1_loop:
	notetype $C, $A3
	note D#, 3
	note __, 1
	note A_, 1
	note __, 5
	note A_, 1
	note __, 5
	note A_, 1
	note __, 3
	note A_, 1
	note __, 5
	note A_, 1
	note __, 3
	note C#, 4
	note __, 2
	sound_duty $AA
	callchannel Music_WildBattleGo_Ch1_ditty1
	callchannel Music_WildBattleGo_Ch1_ditty2
	callchannel Music_WildBattleGo_Ch1_ditty1
	callchannel Music_WildBattleGo_Ch1_ditty2
	octave 2
	note A#, 4
	note A#, 1
	note __, 1
	note A#, 6
	note A#, 4
	note F_, 4
	note F_, 2
	note F_, 2
	note F_, 2
	note F_, 2
	note F_, 2
	note F_, 2
	octave 3
	callchannel Music_WildBattleGo_Ch1_ditty2
	callchannel Music_WildBattleGo_Ch1_ditty1
	callchannel Music_WildBattleGo_Ch1_ditty1
	note __, 4
	sound_duty $55
	intensity $F3
	vibrato $05, $13
	octave 2
	note A#, 4
	octave 3
	note D_, 4
	note F_, 4
	intensity $D8
	note A#, 16
	intensity $F3
	note E_, 2
	note C_, 2
	octave 2
	note G_, 2
	octave 3
	note C_, 2
	note E_, 4
	note G_, 4
	intensity $D8
	octave 4
	note C_, 16
Music_WildBattleGo_Ch1_loop_2:
	intensity $F3
	octave 3
	note F#, 2
	note D_, 2
	octave 2
	note A_, 2
	octave 3
	note D_, 2
	note F#, 4
	note A_, 4
	intensity $D8
	octave 4
	note D_, 16
	loopchannel 2, Music_WildBattleGo_Ch1_loop_2
	sound_duty $5A
	octave 3
	callchannel Music_WildBattleGo_Ch2_ditty2
	loopchannel 0, Music_WildBattleGo_Ch1_loop

Music_WildBattleGo_Ch1_ditty1:
	note D_, 4
	note D_, 1
	note __, 1
	note D_, 6
	note D_, 4
	note D_, 4
	note D_, 2
	note D_, 2
	note D_, 2
	note D_, 2
	note D_, 2
	note D_, 2
	endchannel

Music_WildBattleGo_Ch1_ditty2:
	note C_, 4
	note C_, 1
	note __, 1
	note C_, 6
	note C_, 4
	note C_, 4
	note C_, 2
	note C_, 2
	note C_, 2
	note C_, 2
	note C_, 2
	note C_, 2
	endchannel

Music_WildBattleGo_Ch2:
	notetype $C, $00
	note __, 4
	sound_duty $5A
	intensity $A3
	octave 5
	callchannel Music_WildBattleGo_Ch2_ditty2
Music_WildBattleGo_Ch2_loop:
	note D#, 3
	note __, 1
	note A_, 1
	note __, 5
	note A_, 1
	note __, 5
	note A_, 1
	note __, 3
	note A_, 1
	note __, 5
	note A_, 1
	note __, 3
	note C#, 4
	note __, 2
	sound_duty $55
	intensity $A8
	vibrato $08, $13
	octave 4
	callchannel Music_WildBattleGo_Ch2_ditty1
	note G_, 4
	note F#, 4
	intensity $B7
	note E_, 6
	note E_, 10
	intensity $A8
	octave 5
	note C_, 8
	octave 4
	note G_, 8
	callchannel Music_WildBattleGo_Ch2_ditty1
	note A_, 4
	note B_, 4
	octave 5
	note C_, 4
	octave 3
	note G_, 2
	octave 4
	note E_, 10
	note G_, 4
	octave 5
	note C_, 4
	note E_, 4
	note C_, 4
	octave 3
	note A#, 2
	note F_, 2
	note A#, 2
	octave 4
	note F_, 10
	octave 2
	note A#, 2
	octave 3
	note D_, 2
	note F_, 2
	slidepitchto 1, 5, A#
	note A_, 1
	note A#, 3
	note F_, 2
	note D_, 2
	note F_, 2
	octave 4
	note C_, 2
	octave 3
	note G_, 2
	octave 4
	note C_, 2
	note G_, 2
	note A_, 2
	octave 5
	note C_, 2
	octave 4
	note A_, 2
	note A_, 1
	note G#, 1
	note G_, 16
	note D_, 2
	octave 3
	note A_, 2
	octave 4
	note D_, 2
	intensity $B7
	note A_, 6
	note A_, 4
	intensity $A8
	note B_, 4
	notetype $F, $A8
	note A_, 3
	note G_, 3
	notetype $6, $A8
	note G_, 1
	note F#, 8
	note D_, 4
	octave 3
	note A_, 4
	octave 4
	note D_, 4
	intensity $B7
	note A_, 12
	note A_, 8
	intensity $A8
	note B_, 8
	note A_, 8
	note G_, 8
	note F#, 8
Music_WildBattleGo_Ch2_loop_1:
	note __, 16
	loopchannel 8, Music_WildBattleGo_Ch2_loop_1
	sound_duty $5A
	octave 5
	note D_, 2
	note __, 10
	note D_, 2
	note __, 10
	note D_, 2
	note __, 6
	note D_, 2
	note __, 10
	note D_, 2
	notetype $C, $A8
	note __, 9
	note D_, 1
	note __, 5
	note D_, 1
	note __, 5
	note D_, 1
	note __, 3
	note D_, 1
	note __, 5
	note D_, 1
	note __, 9
	callchannel Music_WildBattleGo_Ch2_ditty2
	loopchannel 0, Music_WildBattleGo_Ch2_loop

Music_WildBattleGo_Ch2_ditty1:
	note D_, 6
	octave 3
	note A_, 2
	octave 4
	note F#, 4
	note E_, 2
	note F#, 2
	note G_, 4
	note F#, 4
	endchannel

Music_WildBattleGo_Ch2_ditty2:
	note D_, 1
	note __, 5
	note D_, 1
	note __, 5
	note D_, 1
	note __, 3
	note D_, 1
	note __, 5
	note D_, 1
	note __, 5
	endchannel

Music_WildBattleGo_Ch3:
	dutycycle 6
	octave 3
	notetype $C, $16
	note D_, 2
	note __, 2
	octave 2
Music_WildBattleGo_Ch3_loop_1:
	note D_, 2
	note A_, 2
	loopchannel 7, Music_WildBattleGo_Ch3_loop_1
Music_WildBattleGo_Ch3_loop:
	note A#, 2
	note A_, 2
Music_WildBattleGo_Ch3_loop_2:
	note D_, 2
	note A_, 2
	loopchannel 6, Music_WildBattleGo_Ch3_loop_2
	octave 3
	note D_, 2
	note C#, 2
	note E_, 2
	note E_, 2
	octave 2
Music_WildBattleGo_Ch3_loop_3:
	note D_, 2
	note A_, 2
	loopchannel 8, Music_WildBattleGo_Ch3_loop_3
Music_WildBattleGo_Ch3_loop_10:
	note C_, 2
	note G_, 2
	loopchannel 7, Music_WildBattleGo_Ch3_loop_10
	note A_, 2
	note G_, 2
Music_WildBattleGo_Ch3_loop_4:
	note D_, 2
	note A_, 2
	loopchannel 8, Music_WildBattleGo_Ch3_loop_4
Music_WildBattleGo_Ch3_loop_11:
	note C_, 2
	note G_, 2
	loopchannel 5, Music_WildBattleGo_Ch3_loop_11
	note F_, 2
	note E_, 2
	note F_, 2
	note E_, 2
	note D_, 2
	note E_, 2
Music_WildBattleGo_Ch3_loop_14:
	octave 1
	note A#, 2
	octave 2
	note F_, 2
	loopchannel 8, Music_WildBattleGo_Ch3_loop_14
Music_WildBattleGo_Ch3_loop_12:
	note C_, 2
	note G_, 2
	loopchannel 8, Music_WildBattleGo_Ch3_loop_12
Music_WildBattleGo_Ch3_loop_9:
	note D_, 2
	note A_, 2
	loopchannel 10, Music_WildBattleGo_Ch3_loop_9
	octave 3
	note D_, 2
	octave 2
	note A_, 2
	note D_, 2
	note A_, 2
	note D_, 2
	note A_, 2
	octave 3
	note D_, 2
	octave 2
	note A_, 2
	octave 3
	note D_, 2
	octave 2
	note A_, 2
	note D_, 2
	note A_, 2
Music_WildBattleGo_Ch3_loop_15:
	octave 1
	note A#, 2
	octave 2
	note F_, 2
	loopchannel 8, Music_WildBattleGo_Ch3_loop_15
Music_WildBattleGo_Ch3_loop_13:
	note C_, 2
	note G_, 2
	loopchannel 8, Music_WildBattleGo_Ch3_loop_13
Music_WildBattleGo_Ch3_loop_5:
	note D_, 2
	note A_, 2
	loopchannel 3, Music_WildBattleGo_Ch3_loop_5
	octave 3
	note D_, 2
	octave 2
	note A_, 2
Music_WildBattleGo_Ch3_loop_6:
	note D_, 2
	note A_, 2
	loopchannel 3, Music_WildBattleGo_Ch3_loop_6
	note A#, 2
	note A_, 2
Music_WildBattleGo_Ch3_loop_7:
	note D_, 2
	note A_, 2
	loopchannel 6, Music_WildBattleGo_Ch3_loop_7
	octave 3
	note D_, 2
	octave 2
	note A_, 2
	octave 3
	note D_, 2
	octave 2
	note A_, 2
Music_WildBattleGo_Ch3_loop_8:
	note D_, 2
	note A_, 2
	loopchannel 7, Music_WildBattleGo_Ch3_loop_8
	loopchannel 0, Music_WildBattleGo_Ch3_loop

Music_WildBattleGo_Ch4:
	notetype $C
	note __, 4
	togglenoise 3
	callchannel Music_WildBattleGo_Ch4_ditty1
	callchannel Music_WildBattleGo_Ch4_ditty2
	callchannel Music_WildBattleGo_Ch4_ditty1
	note D_, 1
	note __, 1
	note C#, 1
	note __, 1
Music_WildBattleGo_Ch4_loop:
	note F#, 1
	note __, 1
	note C#, 1
	note G_, 1
Music_WildBattleGo_Ch4_loop_1:
	callchannel Music_WildBattleGo_Ch4_ditty1
	callchannel Music_WildBattleGo_Ch4_ditty2
	callchannel Music_WildBattleGo_Ch4_ditty1
	callchannel Music_WildBattleGo_Ch4_ditty3
	callchannel Music_WildBattleGo_Ch4_ditty1
	callchannel Music_WildBattleGo_Ch4_ditty2
	callchannel Music_WildBattleGo_Ch4_ditty1
	callchannel Music_WildBattleGo_Ch4_ditty2
	callchannel Music_WildBattleGo_Ch4_ditty1
	callchannel Music_WildBattleGo_Ch4_ditty2
	callchannel Music_WildBattleGo_Ch4_ditty1
	callchannel Music_WildBattleGo_Ch4_ditty2
	callchannel Music_WildBattleGo_Ch4_ditty1
	callchannel Music_WildBattleGo_Ch4_ditty2
	callchannel Music_WildBattleGo_Ch4_ditty1
	callchannel Music_WildBattleGo_Ch4_ditty2
	loopchannel 2, Music_WildBattleGo_Ch4_loop_1
	callchannel Music_WildBattleGo_Ch4_ditty1
	callchannel Music_WildBattleGo_Ch4_ditty2
	callchannel Music_WildBattleGo_Ch4_ditty1
	note D_, 1
	note __, 1
	note C#, 1
	note __, 1
	note F#, 1
	note F#, 1
	note C#, 1
	note F#, 1
Music_WildBattleGo_Ch4_loop_2:
	callchannel Music_WildBattleGo_Ch4_ditty1
	callchannel Music_WildBattleGo_Ch4_ditty2
	loopchannel 9, Music_WildBattleGo_Ch4_loop_2
	callchannel Music_WildBattleGo_Ch4_ditty1
	note D_, 1
	note __, 1
	note C#, 1
	note __, 1
	loopchannel 0, Music_WildBattleGo_Ch4_loop

Music_WildBattleGo_Ch4_ditty1:
	note D_, 1
	note __, 1
	note C#, 1
	note __, 1
	note F#, 1
	note __, 1
	note C#, 1
	note C#, 1
	endchannel

Music_WildBattleGo_Ch4_ditty2:
	note D_, 1
	note __, 1
	note C#, 1
	note __, 1
	note F#, 1
	note __, 1
	note C#, 1
	note __, 1
	endchannel

Music_WildBattleGo_Ch4_ditty3:
	note D_, 1
	note __, 1
	note C#, 1
	note __, 1
	note F#, 1
	note __, 1
	note C#, 1
	note G_, 1
	endchannel
