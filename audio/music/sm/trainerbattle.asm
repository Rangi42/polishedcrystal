; Pokémon S/M - Battle! Trainer
; Demixed by Mmmmmm
; https://pastebin.com/jFntMups
; https://hax.iimarckus.org/topic/6777/7/

Music_TrainerBattleSM:
	musicheader 4, 1, Music_TrainerBattleSM_Ch1
	musicheader 1, 2, Music_TrainerBattleSM_Ch2
	musicheader 1, 3, Music_TrainerBattleSM_Ch3
	musicheader 1, 4, Music_TrainerBattleSM_Ch4

Music_TrainerBattleSM_Ch1:
	tempo 204
	volume $77
	dutycycle 2
	tone $0002
	vibrato $12, $15
	notetype $6, $60
	octave 2
	note A#, 8
	note E_, 8
	octave 3
	note G_, 8
	intensity $6f
	note G_, 8
Music_TrainerBattleSM_Ch1_loop_main:
	dutycycle 0
	intensity $60
	octave 3
	note G_, 6
	note F_, 10
	note E_, 6
	note C_, 6
	note A#, 2
	octave 4
	note C_, 2
	note D_, 6
	octave 3
	note A#, 6
	octave 4
	note D_, 4
	note C_, 16
Music_TrainerBattleSM_Ch1_loop_1:
	octave 2
	intensity $97
	note A#, 6
	intensity $92
	note A#, 4
	note A#, 2
	octave 3
	note C_, 2
	note D_, 2
	intensity $93
	note F_, 6
	note E_, 6
	note D_, 4
	intensity $97
	note C_, 6
	intensity $92
	note C_, 4
	note C_, 2
	note D_, 2
	note E_, 2
	intensity $93
	note G_, 6
	note F_, 6
	note E_, 4
	loopchannel 2, Music_TrainerBattleSM_Ch1_loop_1
	octave 4
	intensity $60
	note C_, 6
	note F_, 8
	note E_, 2
	note D#, 2
	intensity $64
	note E_, 4
	intensity $60
	note G_, 6
	intensity $67
	note G_, 4
	octave 5
	note C_, 6
	note C_, 6
	intensity $65
	note C_, 4
	note __, 6
	intensity $60
	note C_, 6
	intensity $64
	note C_, 4
	intensity $97
	octave 3
	note F_, 8
	note E_, 8
	intensity $92
	note D_, 2
	note C_, 4
	note C_, 4
	note D_, 4
	note E_, 2
	note F_, 2
	note E_, 2
	note D_, 2
	note C_, 2
	octave 2
	note A#, 2
	note A_, 2
	note G_, 2
	note F_, 2
	octave 3
	note A#, 2
	note A_, 2
	note G_, 2
	note F_, 2
	note D#, 2
	note D_, 2
	note C_, 2
	octave 2
	note A#, 2
	intensity $a0
	octave 3
	note C_, 2
	note __, 4
	note C_, 2
	note __, 8
	note C_, 2
	note __, 4
	note C_, 2
	note __, 8
	note C_, 2
	note __, 4
	note C_, 2
	note __, 10
	note C_, 2
	note __, 4
	note C_, 2
	note __, 2
	note C_, 2
	note __, 2
	intensity $a2
	note C_, 4
	intensity $a7
	note F_, 4
	octave 2
	intensity $a2
	note A#, 4
	octave 3
	intensity $a7
	note E_, 4
	octave 2
	intensity $a2
	note A_, 2
	octave 3
	note C_, 4
	octave 2
	intensity $a3
	note A#, 6
	note __, 4
	intensity $a7
	note A#, 2
	note __, 4
	note A#, 2
	note __, 8
	note A#, 2
	note __, 4
	note A#, 2
	note __, 8
	octave 3
	note C_, 2
	note __, 4
	note C_, 2
	note __, 16
	octave 2
	note A#, 8
	note B_, 1
	octave 3
	note C_, 5
	note C_, 2
	note __, 8
	vibrato $1, $21
	intensity $90
	octave 2
	note B_, 2
	octave 3
	note C_, 10
	vibrato $0, $0
	soundinput $6b
	note C_, 4
	soundinput $00
	vibrato $12, $15
	dutycycle 1
	notetype $c, $a3
Music_TrainerBattleSM_Ch1_loop_2:
	note C_, 11
	note C_, 5
	note C_, 16
	loopchannel 5, Music_TrainerBattleSM_Ch1_loop_2
	notetype $6, $a1
Music_TrainerBattleSM_Ch1_loop_3:
	octave 4
	note A#, 1
	note F_, 1
	note D_, 1
	octave 3
	note A#, 1
	octave 4
	note F_, 1
	note D_, 1
	octave 3
	note A#, 1
	note F_, 1
	octave 4
	note D_, 1
	octave 3
	note A#, 1
	note F_, 1
	note D_, 1
	note D_, 1
	note F_, 1
	note A#, 1
	octave 4
	note D_, 1
	note F_, 1
	note D_, 1
	note A#, 1
	note F_, 1
	note A#, 1
	note F_, 1
	octave 5
	note D_, 1
	octave 4
	note A#, 1
	octave 5
	note F_, 1
	note D_, 1
	octave 4
	note A#, 1
	note F_, 1
	octave 5
	note D_, 1
	octave 4
	note A#, 1
	note F_, 1
	note D_, 1
	octave 5
	note C_, 1
	octave 4
	note G_, 1
	note E_, 1
	note C_, 1
	note G_, 1
	note E_, 1
	note C_, 1
	octave 3
	note G_, 1
	octave 4
	note E_, 1
	note C_, 1
	octave 3
	note G_, 1
	note E_, 1
	note E_, 1
	note G_, 1
	octave 4
	note C_, 1
	note E_, 1
	octave 5
	note C_, 1
	octave 4
	note G_, 1
	octave 5
	note E_, 1
	note C_, 1
	note G_, 1
	note E_, 1
	octave 6
	note C_, 1
	octave 5
	note G_, 1
	note G_, 1
	note E_, 1
	note C_, 1
	octave 4
	note G_, 1
	note E_, 1
	note G_, 1
	note E_, 1
	note C_, 1
	loopchannel 2, Music_TrainerBattleSM_Ch1_loop_3
	loopchannel 0, Music_TrainerBattleSM_Ch1_loop_main

Music_TrainerBattleSM_Ch2:
	dutycycle 3
	vibrato $8, $36
	tone $0001
	notetype $6, $c2
	octave 4
	note A#, 1
	note G_, 1
	note E_, 1
	note C_, 1
	octave 3
	note G_, 1
	note E_, 1
	note G_, 1
	octave 4
	note C_, 1
	note E_, 1
	note G_, 1
	note A#, 1
	octave 5
	note D_, 1
	note F_, 1
	note D_, 1
	octave 4
	note A#, 1
	note F_, 1
	note E_, 1
	note C_, 1
	octave 3
	note G_, 1
	octave 4
	note C_, 1
	note E_, 1
	note G_, 1
	note A#, 1
	octave 5
	note D_, 1
	note F_, 1
	note A#, 1
	note F_, 1
	intensity $b2
	note D_, 1
	octave 4
	note A#, 1
	octave 5
	intensity $92
	note A#, 1
	intensity $82
	note F_, 1
	intensity $72
	note D_, 1
Music_TrainerBattleSM_Ch2_loop_main:
	dutycycle 3
	octave 4
	intensity $a0
	note C_, 6
	note F_, 6
	intensity $a7
	note F_, 2
	note E_, 2
	intensity $a0
	note G_, 6
	intensity $a7
	note G_, 6
	note G_, 2
	note A_, 2
	intensity $a0
	note A#, 6
	note A_, 6
	note F_, 4
	note G_, 8
	intensity $a5
	note G_, 8
	dutycycle 2
	callchannel Music_TrainerBattleSM_Ch2_branch_2
	intensity $a7
	note G_, 10
	dutycycle 3
	octave 4
	intensity $a0
	note C_, 6
	note F_, 6
	intensity $a7
	note F_, 2
	note E_, 2
	intensity $a0
	note G_, 6
	intensity $a7
	note G_, 6
	note G_, 2
	note A_, 2
	intensity $a0
	note A#, 4
	intensity $a4
	note A#, 2
	intensity $a0
	note A_, 4
	intensity $a4
	note A_, 2
	note F_, 4
	note D#, 2
	intensity $a2
	note E_, 4
	intensity $a0
	note G_, 2
	intensity $a6
	note G_, 8
	dutycycle 2
	note F_, 8
	note E_, 8
	intensity $a3
	note D_, 2
	note C_, 4
	note C_, 4
	note D_, 4
	note E_, 2
	note F_, 2
	note E_, 2
	note D_, 2
	note C_, 2
	octave 3
	note A#, 2
	note A_, 2
	note G_, 2
	note F_, 2
	octave 4
	note F_, 2
	note E_, 2
	note D_, 2
	note C_, 2
	octave 3
	note A#, 2
	note A_, 2
	note G_, 2
	note F_, 2
	intensity $a0
	note C_, 12
	intensity $a7
	note C_, 16
	note __, 4
	intensity $a0
	note E_, 4
	intensity $a7
	note E_, 12
	intensity $a0
	note G_, 4
	intensity $a7
	note G_, 12
	dutycycle 3
	octave 4
	intensity $a2
	note F_, 4
	intensity $a7
	note A#, 4
	intensity $a2
	note E_, 4
	intensity $a7
	note A_, 4
	intensity $a2
	note D_, 2
	intensity $a7
	note G_, 4
	intensity $a3
	note F_, 6
	intensity $81
	octave 4
	note C_, 1
	octave 5
	note C_, 1
	octave 4
	note E_, 1
	octave 5
	note E_, 1
	octave 4
	note F_, 1
	octave 5
	note F_, 1
	callchannel Music_TrainerBattleSM_Ch2_branch_1
	note F_, 1
	octave 5
	note F_, 3
	callchannel Music_TrainerBattleSM_Ch2_branch_1
	octave 3
	note F_, 1
	octave 4
	note F_, 1
	octave 3
	dutycycle 2
	intensity $90
	note C_, 8
	intensity $97
	note C_, 16
	note F_, 8
	intensity $90
	note G_, 8
	intensity $97
	note G_, 8
	intensity $90
	note F_, 2
	note G_, 6
	intensity $97
	note G_, 8
	dutycycle 0
	vibrato $12, $54
	intensity $c0
	note F_, 8
	intensity $c7
	note F_, 16
	note C_, 8
	intensity $c0
	note D#, 16
	intensity $c7
	note D#, 16
	intensity $c0
	note F_, 8
	intensity $c7
	note F_, 8
	intensity $c0
	note G#, 8
	intensity $c7
	note G#, 8
	intensity $c0
	note G_, 8
	intensity $c7
	note G_, 8
	intensity $c0
	octave 4
	note C#, 8
	intensity $c7
	note C#, 16
	octave 3
	note __, 8
	note F_, 8
	note C_, 8
	intensity $c0
	note D#, 16
	intensity $c7
	note D#, 16
	note __, 16
	note F_, 6
	note G#, 6
	note G_, 4
	intensity $c0
	note D#, 16
	intensity $c7
	note D#, 16
	dutycycle 2
	octave 2
	intensity $97
	vibrato $12, $15
	note F_, 2
	note F#, 2
	note G_, 2
	note G#, 2
	note A_, 2
	note A#, 2
	note B_, 2
	octave 3
	note C_, 2
	intensity $a7
	note C#, 2
	note D_, 2
	note D#, 2
	note E_, 2
	note F_, 2
	note F#, 2
	note G_, 2
	note G#, 2
	intensity $b7
	note F_, 2
	note F#, 2
	note G_, 2
	note G#, 2
	note A_, 2
	note A#, 2
	note B_, 2
	octave 4
	note C_, 2
	intensity $c7
	note C#, 2
	note D_, 2
	note D#, 2
	note E_, 2
	intensity $d7
	note F_, 2
	note F#, 2
	note G_, 2
	note G#, 2
	intensity $a5
	callchannel Music_TrainerBattleSM_Ch2_branch_2
	intensity $a7
	note G_, 10
	loopchannel 0, Music_TrainerBattleSM_Ch2_loop_main

Music_TrainerBattleSM_Ch2_branch_1:
	octave 4
	note E_, 1
	octave 5
	note E_, 1
	octave 4
	note D_, 1
	octave 5
	note D_, 1
	octave 4
	note C_, 1
	octave 5
	note C_, 1
	octave 3
	note A#, 1
	octave 4
	note A#, 1
	octave 3
	note A_, 1
	octave 4
	note A_, 1
	octave 3
	note G_, 1
	octave 4
	note G_, 1
	endchannel

Music_TrainerBattleSM_Ch2_branch_2:
	octave 3
	note A#, 8
	octave 4
	note C_, 8
	note D_, 8
	note F_, 8
	note C_, 8
	note D_, 8
	note E_, 8
	note G_, 8
	octave 3
	note A#, 8
	octave 4
	note C_, 8
	note D_, 8
	note F_, 8
	note C_, 8
	note D_, 8
	note E_, 6
	endchannel

Music_TrainerBattleSM_Ch3:
	notetype $6, $19
	octave 2
	note C_, 7
	note __, 1
	note C_, 7
	note __, 1
	note C_, 2
	note G_, 2
	note C_, 2
	note G_, 2
	note C_, 2
	note G_, 2
	note C_, 2
	note G_, 2
Music_TrainerBattleSM_Ch3_loop_main:
Music_TrainerBattleSM_Ch3_loop_1:
	note C_, 2
	note G_, 2
	note C_, 2
	note G_, 2
	note C_, 2
	note G_, 2
	note C_, 2
	note G_, 2
	loopchannel 16, Music_TrainerBattleSM_Ch3_loop_1
Music_TrainerBattleSM_Ch3_loop_2:
	octave 1
	note A#, 2
	octave 2
	note F_, 2
	loopchannel 16, Music_TrainerBattleSM_Ch3_loop_2
Music_TrainerBattleSM_Ch3_loop_3:
	note C_, 2
	note G_, 2
	loopchannel 16, Music_TrainerBattleSM_Ch3_loop_3
Music_TrainerBattleSM_Ch3_loop_4:
	octave 1
	note A#, 2
	octave 2
	note F_, 2
	loopchannel 16, Music_TrainerBattleSM_Ch3_loop_4
Music_TrainerBattleSM_Ch3_loop_5:
	note C_, 2
	note G_, 2
	loopchannel 16, Music_TrainerBattleSM_Ch3_loop_5
	intensity $19
Music_TrainerBattleSM_Ch3_loop_6:
	note F_, 2
	note __, 2
	note F_, 2
	note __, 2
	note F_, 1
	note __, 1
	note F_, 4
	note __, 2
	note F_, 1
	note __, 1
	note F_, 2
	note __, 2
	note F_, 2
	note __, 2
	note F_, 1
	note __, 1
	note F_, 2
	note __, 2
	note D#, 2
	note __, 2
	note D#, 2
	note __, 2
	note D#, 1
	note __, 1
	note D#, 4
	note __, 2
	note D#, 1
	note __, 1
	note D#, 2
	note __, 2
	note D#, 2
	note __, 2
	note D#, 1
	note __, 1
	note D#, 2
	note __, 2
	note C#, 2
	note __, 2
	note C#, 2
	note __, 2
	note C#, 1
	note __, 1
	note C#, 4
	note __, 2
	note C#, 1
	note __, 1
	note C#, 2
	note __, 2
	note C#, 2
	note __, 2
	note C#, 1
	note __, 1
	note C#, 2
	note __, 2
	note D#, 2
	note __, 2
	note D#, 2
	note __, 2
	note D#, 1
	note __, 1
	note D#, 4
	note __, 2
	note D#, 1
	note __, 1
	note D#, 2
	note __, 2
	note D#, 2
	note __, 2
	note D#, 1
	note __, 1
	note D#, 2
	note __, 2
	loopchannel 2, Music_TrainerBattleSM_Ch3_loop_6
	octave 1
	note F_, 2
	note F#, 2
	note G_, 2
	note G#, 2
	note A_, 2
	note A#, 2
	note B_, 2
	octave 2
	note C_, 2
	note C#, 2
	note D_, 2
	note D#, 2
	note E_, 2
	note F_, 2
	note F#, 2
	note G_, 2
	note G#, 2
	note A_, 2
	note A#, 2
	note B_, 2
	octave 3
	note C_, 2
	note C#, 2
	note D_, 2
	note D#, 2
	note E_, 2
	note F_, 2
	note F#, 2
	note G_, 2
	note G#, 2
	note A_, 2
	note A#, 2
	note B_, 2
	octave 4
	note C_, 2
	octave 2
	note F_, 16
	note F_, 16
	note G_, 16
	note G_, 16
;	intensity $29
Music_TrainerBattleSM_Ch3_loop_7:
	note C_, 2
	note G_, 2
	loopchannel 16, Music_TrainerBattleSM_Ch3_loop_7
	loopchannel 0, Music_TrainerBattleSM_Ch3_loop_main

Music_TrainerBattleSM_Ch4:
	togglenoise $3
	notetype $6
	note __, 16
	note __, 12
	note C_, 4
Music_TrainerBattleSM_Ch4_loop_main:
Music_TrainerBattleSM_Ch4_loop_1:
	note D#, 3
	note F#, 1
	note C_, 4
	note D#, 2
	note D#, 2
	note C_, 4
	loopchannel 4, Music_TrainerBattleSM_Ch4_loop_1
Music_TrainerBattleSM_Ch4_loop_2:
	note D#, 2
	note C#, 2
	note C_, 2
	note C#, 2
	note D#, 2
	note D#, 2
	note D_, 2
	note C#, 2
	loopchannel 4, Music_TrainerBattleSM_Ch4_loop_2
Music_TrainerBattleSM_Ch4_loop_3:
	note D#, 4
	note C_, 4
	note D#, 2
	note D#, 2
	note D_, 4
	loopchannel 4, Music_TrainerBattleSM_Ch4_loop_3
	note B_, 3
	note F#, 1
	note C_, 4
	note D#, 2
	note D#, 2
	note C_, 4
	note D#, 3
	note D_, 1
	note C_, 4
	note D#, 2
	note D#, 2
	note C_, 4
	note D#, 3
	note D_, 1
	note C_, 4
	note D#, 2
	note D#, 2
	note C_, 4
	note D#, 3
	note D_, 1
	note C_, 4
	note D#, 2
	note C_, 2
	note C_, 2
	note C_, 2
Music_TrainerBattleSM_Ch4_loop_4:
	note D#, 4
	note C_, 4
	note D#, 2
	note D#, 2
	note D_, 4
	loopchannel 7, Music_TrainerBattleSM_Ch4_loop_4
	note D#, 4
	note C_, 4
	note D#, 2
	note C_, 2
	note C_, 2
	note C_, 1
	note C_, 1
	note D#, 2
	note D#, 2
	note B_, 4
	note D#, 2
	note D#, 2
	note B_, 4
	note D#, 2
	note C_, 4
	note C_, 4
	note D#, 2
	note D_, 2
	note D#, 2
	note D#, 4
	note C_, 4
	note D#, 2
	note D_, 2
	note D_, 2
	note D#, 2
	note D#, 4
	note C_, 4
	note D#, 2
	note D_, 2
	note D_, 2
	note D_, 1
	note D_, 1
Music_TrainerBattleSM_Ch4_loop_5:
	note D#, 4
	note C_, 4
	note D#, 2
	note D#, 2
	note D_, 4
	loopchannel 3, Music_TrainerBattleSM_Ch4_loop_5
	note D#, 4
	note C_, 4
	note D#, 2
	note C_, 2
	note C_, 2
	note C_, 1
	note C_, 1
Music_TrainerBattleSM_Ch4_loop_6:
	note D#, 2
	note D#, 2
	note C_, 1
	note D_, 1
	note D#, 2
	loopchannel 16, Music_TrainerBattleSM_Ch4_loop_6
	note B_, 4
	note C_, 1
	note D_, 1
	note D#, 2
Music_TrainerBattleSM_Ch4_loop_7:
	note D#, 2
	note D#, 2
	note C_, 1
	note D_, 1
	note D#, 2
	loopchannel 15, Music_TrainerBattleSM_Ch4_loop_7
	note B_, 4
	note C_, 1
	note D_, 1
	note D#, 2
Music_TrainerBattleSM_Ch4_loop_8:
	note D#, 2
	note D#, 2
	note C_, 1
	note D_, 1
	note D#, 2
	loopchannel 3, Music_TrainerBattleSM_Ch4_loop_8
	note B_, 4
	note D#, 2
	note D_, 2
	note D#, 4
	note D_, 2
	note D#, 4
	note D_, 2
	note D#, 2
	note D#, 2
	note C_, 2
	note D#, 2
	note C_, 2
	note D_, 1
	note D_, 1
	note B_, 16
	note __, 16
	note B_, 16
	note __, 10
	note C_, 2
	note C_, 2
	note D_, 1
	note D_, 1
Music_TrainerBattleSM_Ch4_loop_9:
	note D#, 2
	note C#, 2
	note C_, 2
	note C#, 2
	note D#, 2
	note D#, 2
	note D_, 2
	note C#, 2
	loopchannel 3, Music_TrainerBattleSM_Ch4_loop_9
	note D#, 2
	note C#, 2
	note C_, 2
	note C#, 2
	note D#, 2
	note C_, 2
	note C_, 2
	note D_, 1
	note D_, 1
	loopchannel 0, Music_TrainerBattleSM_Ch4_loop_main
