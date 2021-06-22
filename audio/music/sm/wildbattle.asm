; Pokémon S/M - Battle! Wild Pokémon
; Demixed by Mmmmmm
; https://pastebin.com/WSdP1J0x
; https://hax.iimarckus.org/topic/6777/6/

Music_WildBattleSM:
	musicheader 4, 1, Music_WildBattleSM_Ch1
	musicheader 1, 2, Music_WildBattleSM_Ch2
	musicheader 1, 3, Music_WildBattleSM_Ch3
	musicheader 1, 4, Music_WildBattleSM_Ch4

Music_WildBattleSM_Ch1:
	tempo 204
	volume $77
	dutycycle $3
	tone $0002
	vibrato $12, $15
	notetype $6, $92
	note __, 4
	octave 4
	note G#, 1
	note G_, 1
	note F#, 1
	note F_, 1
	note E_, 1
	note D#, 1
	note D_, 1
	note C#, 1
	note C_, 1
	octave 3
	note B_, 1
	note A#, 1
	note A_, 1
	note G#, 1
	note G_, 1
	note F#, 1
	note F_, 1
	note A#, 1
	note A_, 1
	note G#, 1
	note G_, 1
	note F#, 1
	note F_, 1
	note E_, 1
	note D#, 1
	note D_, 1
	note C#, 1
	note C_, 1
	octave 2
	note B_, 1
	note A#, 1
	note A_, 1
	note G#, 1
	note G_, 1
	intensity $a2
	octave 3
	note C_, 6
	octave 2
	note B_, 6
	octave 3
	note C_, 4
	note C_, 8
	intensity $a7
	octave 2
	note F_, 8
	intensity $a2
	octave 3
	note C#, 6
	note C_, 6
	note C#, 4
	note C#, 8
	intensity $a7
	note F#, 8
Music_WildBattleSM_Ch1_loop_main:
	note __, 8
	dutycycle 0
	intensity $a2
	octave 4
	note F_, 2
	note G_, 2
	octave 5
	note C_, 2
	octave 4
	note F_, 4
	octave 5
	note C_, 4
	octave 2
	intensity $a4
	note D_, 2
	note F_, 4
	note G_, 3
	octave 4
	note F#, 1
	note A#, 4
	note A_, 2
	note A#, 4
	note A_, 2
	intensity $a7
	note G_, 4
	octave 5
	note D#, 2
	note D_, 2
	note C_, 2
	octave 4
	note A#, 12
	octave 4
	intensity $92
	note F_, 4
	note F_, 2
	octave 3
	note B_, 2
	octave 4
	note C_, 10
	note F_, 6
	note F_, 4
	note F_, 2
	intensity $a0
	note A#, 6
	intensity $a7
	note A#, 12
	intensity $4f
	note A#, 8
	intensity $c2
	note A_, 4
	note A#, 2
	octave 5
	note C_, 10
	octave 4
	note F_, 4
	note F_, 4
	note A_, 4
	note A_, 4
	note D#, 6
	note D#, 6
	note __, 12
	octave 3
	note A#, 4
	note A#, 4
	note A#, 2
	intensity $c5
	note A_, 4
	intensity $c0
	note A#, 8
	intensity $c7
	note A#, 8
	octave 4
	note C_, 8
	note D_, 8
	intensity $c2
	note __, 4
	note G_, 8
	note F_, 8
	note D#, 6
	note D_, 4
	note D_, 2
Music_WildBattleSM_Ch1_loop_1:
	note D_, 6
	note E_, 4
	note F#, 4
	note F#, 1
	note G_, 1
	note A_, 2
	note F#, 4
	note D_, 4
	note D_, 4
	note C#, 2
	loopchannel 2, Music_WildBattleSM_Ch1_loop_1
	dutycycle 0
	intensity $c7
	octave 4
	note D#, 8
	note D_, 8
	note C_, 8
	octave 3
	note A#, 8
	octave 4
	note C_, 8
	octave 3
	note A#, 8
	note A_, 8
	note B_, 2
	intensity $c2
	octave 4
	note C_, 4
	intensity $c0
	octave 3
	note B_, 16
	intensity $c7
	note B_, 16
	intensity $60
	octave 4
	note D#, 2
	note E_, 16
	note E_, 16

	octave 3
	intensity $c2
	note C_, 2
	octave 2
	note B_, 4
	octave 3
	note C_, 4
	note C_, 4
	octave 2
	note B_, 2
	octave 3
	note C_, 2
	octave 2
	note A_, 4
	intensity $c7
	octave 3
	note F_, 10
	intensity $c2
	note D_, 4
	note C#, 2
	note D_, 4
	note D_, 4
	note C#, 2
	note D_, 2
	octave 2
	note A_, 4
	octave 3
	intensity $c7
	note G_, 10
	intensity $c0
	note E_, 16
	intensity $c7
	note E_, 16
	octave 2
	intensity $80
	note E_, 16
	intensity $87
	note E_, 16
	note __, 16
	note __, 16
	note __, 16
	note __, 16
	loopchannel 0, Music_WildBattleSM_Ch1_loop_main

Music_WildBattleSM_Ch2:
	dutycycle $3
	vibrato $8, $36
	tone $0001
	notetype $6, $c2
	note __, 4
Music_WildBattleSM_Ch2_loop_1:
	octave 5
	note E_, 1
	note F_, 1
	note F#, 1
	note G_, 1
	loopchannel 8, Music_WildBattleSM_Ch2_loop_1
	octave 4
	note C_, 6
	octave 3
	note B_, 6
	octave 4
	note C_, 4
	note C_, 8
	intensity $c7
	octave 3
	note F_, 8
	intensity $c2
	octave 4
	note C#, 6
	note C_, 6
	note C#, 4
	note C#, 8
	intensity $c7
	note C#, 4
	octave 3
	intensity $c2
	note G#, 1
	note A_, 1
Music_WildBattleSM_Ch2_loop_main:
	octave 3
	intensity $c2
	note A#, 1
	note B_, 1
	octave 4
	note C_, 6
	note F_, 6
	intensity $c4
	note A#, 4
	intensity $c2
	note A_, 6
	note G_, 6
	intensity $c4
	note F_, 4
	dutycycle 0
	intensity $a4
	note G_, 4
	note F_, 2
	note G_, 4
	note F_, 2
	intensity $a7
	note D#, 4
	note A#, 2
	note A_, 2
	note G_, 2
	note F_, 6
	dutycycle 3
	intensity $c2
	note E_, 4
	note A_, 2
	note F_, 4
	note F_, 6
	note F_, 2
	note G_, 2
	note A_, 6
	octave 5
	note C_, 6
	octave 4
	note A_, 4
	intensity $c7
	note A#, 8
	octave 5
	intensity $a1
	note D#, 1
	octave 6
	note D#, 1
	octave 5
	note D_, 1
	octave 6
	note D_, 1
	octave 5
	note C_, 1
	octave 6
	note C_, 1
	octave 4
	note A#, 1
	octave 5
	note A#, 1
	note G_, 1
	octave 6
	note G_, 1
	octave 5
	note F_, 1
	octave 6
	note F_, 1
	octave 5
	note D#, 1
	octave 6
	note D#, 1
	octave 4
	note A#, 1
	octave 5
	note A#, 1
	octave 4
	intensity $71
	note A#, 1
	octave 5
	note A#, 1
	intensity $c2
	octave 4
	note F_, 4
	note G_, 2
	intensity $c5
	note A_, 6
	intensity $c2
	note F_, 4
	note F_, 4
	note A_, 2
	intensity $c7
	note A#, 6
	note A_, 6
	note G_, 2
	octave 5
	intensity $c2
	note C_, 1
	note D_, 1
	note D#, 6
	octave 4
	note A#, 4
	note A#, 4
	octave 5
	note D_, 2
	note D#, 2
	note D_, 2
	note C_, 2
	note D_, 4
	note D_, 2
	note C_, 4
	intensity $c0
	note D_, 8
	intensity $c4
	note D_, 8
	note D#, 8
	note F_, 8
	note D#, 8
	note D_, 8
	note C_, 8
	octave 4
	note A#, 8
	note A_, 1
	note A#, 1
	note G_, 1
	intensity $c0
	note A_, 6
	intensity $c4
	note A_, 10
	note __, 13
	note F#, 1
	note G_, 1
	note E_, 1
	intensity $c0
	note F#, 6
	intensity $c4
	note F#, 10
	note __, 11
	notetype $3, $c1
	octave 3
	note A#, 1
	note B_, 1
	octave 4
	note C_, 1
	note D_, 1
	notetype $6, $c7
	note D#, 8
	note F_, 8
	note G_, 8
	note A#, 8
	note F_, 8
	note G_, 8
	note A_, 8
	note B_, 2
	intensity $c2
	octave 5
	note C_, 4
	intensity $c0
	octave 4
	note B_, 16
	intensity $c7
	note B_, 16
	intensity $60
	octave 5
	note D#, 2
	note E_, 16
	note E_, 16
	octave 4
	intensity $c2
	note A_, 2
	note G#, 4
	note A_, 4
	note A_, 4
	note G#, 2
	note A_, 2
	note F_, 4
	octave 5
	intensity $c7
	note C_, 10
	octave 4
	intensity $c2
	note B_, 4
	note A#, 2
	note B_, 4
	note B_, 4
	note A#, 2
	note B_, 2
	note G_, 4
	octave 5
	intensity $c7
	note D_, 10
	intensity $c0
	note C#, 16
	intensity $c7
	note C#, 16
	intensity $80
	octave 4
	note A_, 16
	intensity $87
	note A_, 16
	note __, 16
	note __, 16
	note __, 16
	note __, 14
	loopchannel 0, Music_WildBattleSM_Ch2_loop_main

Music_WildBattleSM_Ch3:
	notetype $3, $19
	octave 3
	note C_, 8
	octave 2
	note C_, 4
	note G#, 4
	note __, 4
	note G_, 4
	note __, 4
	note F#, 4
	note __, 4
	note F_, 4
	note __, 4
	note E_, 4
	note __, 4
	note D#, 4
	note __, 4
	note D_, 4
	note __, 4
	note C#, 4
	octave 3
	note C_, 4
	note F_, 4
	note F#, 4
	note F_, 4
	note C_, 4
	note F_, 4
	note F_, 4
	note F#, 4
	note C_, 4
	note F_, 4
	note G_, 4
	note F_, 4
	note C_, 4
	note G_, 3
	note __, 1
	note G_, 4
	note F_, 4
	note C#, 4
	note F#, 4
	note G_, 4
	note F#, 4
	note C#, 4
	note F#, 4
	note F#, 4
	note G_, 4
	note C#, 4
	note F#, 4
	note G#, 4
	note F#, 4
	note C#, 4
	note F#, 3
	note __, 1
	note F#, 4
	note F_, 4
Music_WildBattleSM_Ch3_loop_main:
	octave 2
	note C_, 4
	note __, 4
	note F_, 4
	note __, 4
	note C_, 3
	note __, 1
	note C_, 4
	note F_, 4
	note C_, 4
	note __, 4
	note F_, 4
	note __, 4
	note C_, 4
	note F_, 8
	note G_, 8
	note D#, 3
	note __, 1
	note D#, 4
	octave 3
	note D#, 4
	octave 2
	note D#, 3
	note __, 1
	note D#, 3
	note __, 1
	note D#, 4
	note F_, 4
	note __, 4
	note D#, 3
	note __, 1
	note D#, 4
	note __, 4
	note D#, 1
	note __, 1
	note D#, 1
	note __, 1
	note D#, 3
	note __, 1
	note D#, 4
	note E_, 3
	note __, 1
	note E_, 4
	note A_, 4
	note F_, 4
	note __, 4
	note F_, 3
	note __, 1
	note F_, 4
	octave 3
	note F_, 4
	octave 2
	note F_, 3
	note __, 1
	note F_, 3
	note __, 1
	note F_, 4
	note __, 4
	octave 3
	note F_, 4
	octave 2
	note F_, 4
	note __, 4
	octave 3
	note F_, 4
	octave 2
	note F_, 4
	octave 3
	note F_, 4
	octave 2
	note D#, 4
	note __, 4
	octave 1
	note D#, 4
	note __, 4
	note A#, 3
	note __, 1
	note A#, 4
	note __, 8
	octave 2
	note D#, 4
	octave 1
	note A#, 4
	note __, 4
	note A#, 4
	note __, 4
	octave 2
	note C_, 4
	octave 1
	note B_, 4
	note __, 4
	octave 2
	note C_, 4
	note F_, 4
	note C_, 4
	note F_, 4
	note C_, 4
	note A_, 4
	note G_, 4
	note F_, 4
	note C_, 4
	note A_, 4
	note C_, 4
	note F_, 4
	note C_, 4
	note F_, 4
	note D#, 4
	note C_, 4
	octave 1
	note A#, 4
	octave 2
	note D#, 4
	octave 1
	note A#, 4
	octave 2
	note D#, 4
	octave 1
	note A#, 4
	octave 2
	note F_, 4
	note D#, 4
	note C_, 4
	octave 1
	note A#, 4
	octave 2
	note A#, 4
	octave 1
	note A_, 4
	octave 2
	note A_, 4
	octave 1
	note G_, 4
	octave 2
	note G_, 4
	octave 1
	note F#, 4
	octave 2
	note F#, 4
	note C_, 3
	note __, 1
	note C_, 4
	note F_, 8
	note D#, 8
	note C_, 8
	octave 1
	note A_, 8
	note F_, 8
	octave 2
	note F_, 8
	octave 1
	note F_, 8
	octave 2
	note D#, 3
	note __, 1
	note D#, 4
	octave 3
	note D#, 8
	octave 2
	note D#, 3
	note __, 1
	note D#, 4
	octave 3
	note D#, 8
	octave 2
	note D#, 4
	note F_, 4
	note G_, 4
	note D#, 3
	note __, 1
	note D#, 4
	note A#, 4
	note A_, 4
	note G_, 4
Music_WildBattleSM_Ch3_loop_1:
	octave 1
	note D_, 4
	octave 2
	note D_, 4
	loopchannel 12, Music_WildBattleSM_Ch3_loop_1
	octave 1
	note D_, 4
	octave 2
	note A_, 4
	note G_, 4
	note F#, 4
	note G_, 4
	note F#, 4
	note D_, 8
	octave 1
	note A#, 6
	octave 2
	note F_, 2
	note G_, 4
	octave 1
	note A#, 3
	note __, 1
	note A#, 4
	octave 2
	note G_, 4
	note __, 4
	octave 1
	note A#, 3
	note __, 1
	note A#, 4
	octave 2
	note D#, 4
	note G_, 3
	note __, 1
	note G_, 4
	octave 1
	note A#, 4
	octave 2
	note A#, 4
	note A_, 4
	note G_, 4
	note C_, 6
	note G_, 2
	note A_, 4
	note C_, 4
	note C_, 4
	note A_, 8
	note C_, 4
	note C_, 4
	note F_, 4
	note A_, 4
	note A_, 4
	note C_, 4
	octave 3
	note C_, 4
	octave 2
	note B_, 4
	note A_, 4
Music_WildBattleSM_Ch3_loop_2:
	octave 1
	note B_, 4
	octave 2
	note E_, 4
	loopchannel 16, Music_WildBattleSM_Ch3_loop_2
	note C_, 4
	note F_, 4
	note C_, 4
	note F_, 4
	note C_, 4
	note F_, 4
	note C_, 4
	note F_, 4
	note C_, 4
	octave 3
	note C_, 4
	octave 2
	note A#, 4
	note A_, 4
	note A#, 4
	note A_, 4
	note G_, 4
	note F_, 4
	note D_, 4
	note G_, 4
	note D_, 4
	note G_, 4
	note D_, 4
	note G_, 4
	note D_, 4
	note G_, 4
	note D_, 4
	note G_, 4
	octave 3
	note D_, 4
	octave 2
	note B_, 4
	octave 3
	note D_, 4
	octave 2
	note B_, 4
	note G_, 4
	note D_, 4
	note E_, 8
	note __, 4
	note E_, 4
	note A_, 8
	note __, 4
	note A_, 4
	note E_, 8
	note __, 4
	note E_, 4
	note A_, 8
	note __, 4
	note A_, 4
	note E_, 4
	note A_, 4
	note E_, 4
	note A_, 4
	note E_, 4
	note A_, 4
	note E_, 4
	note A_, 4
	note E_, 4
	note A_, 4
	note E_, 4
	note A_, 4
	note E_, 4
	note A_, 8
	note E_, 4
Music_WildBattleSM_Ch3_loop_3:
	note C_, 4
	note F_, 4
	loopchannel 12, Music_WildBattleSM_Ch3_loop_3
	note C_, 4
	octave 3
	note C_, 4
	octave 2
	note A#, 4
	note A_, 4
	note F_, 4
	note G_, 4
	note C_, 8
	loopchannel 0, Music_WildBattleSM_Ch3_loop_main

Music_WildBattleSM_Ch4:
	togglenoise $3
	notetype $6
	note B_, 4
	note D#, 4
	note D#, 4
	note D#, 4
	note D#, 4
	note D#, 4
	note D#, 4
	note D#, 4
	note D#, 4
	note D#, 4
	note D_, 2
	note D_, 2
	note D#, 4
	note D_, 2
	note D_, 2
	note D#, 4
	note D_, 2
	note D_, 2
	note D#, 2
	note D_, 4
	note D_, 2
	note D#, 4
	note D_, 2
	note D_, 2
	note D#, 4
	note D_, 2
	note D_, 2
	note D#, 4
	note D_, 2
	note D_, 2
	note D#, 2
	note C_, 2
	note D_, 2
	note C_, 2
Music_WildBattleSM_Ch4_loop_main:
	note A#, 4
	note C_, 4
	note A#, 2
	note A#, 2
	note C_, 4
	note A#, 2
	note A#, 4
	note C_, 2
	note A#, 4
	note C_, 2
	note C_, 2
	note A#, 4
	note C_, 4
	note A#, 2
	note A#, 2
	note C_, 4
	note A#, 2
	note A#, 2
	note C_, 2
	note D#, 1
	note D#, 1
	note A#, 2
	note A#, 2
	note C_, 2
	note D#, 1
	note C_, 1
	note C_, 2
	note D#, 2
	note C_, 3
	note C_, 1
	note C_, 2
	note C_, 2
	note D#, 2
	note D#, 2
	note D#, 2
	note D#, 2
	note D#, 2
	note C_, 4
	note D#, 2
	note C_, 2
	note D#, 1
	note D#, 1
	note A#, 4
	note C_, 4
	note A#, 2
	note A#, 2
	note C_, 4
	note A#, 2
	note A#, 2
	note C_, 2
	note A#, 4
	note A#, 2
	note C_, 2
	note C_, 1
	note C_, 1
	note D#, 4
	note C_, 4
	note D#, 2
	note D#, 2
	note D#, 2
	note C_, 2
	note D#, 2
	note C_, 2
	note D#, 2
	note C_, 2
	note D#, 2
	note C_, 2
	note D#, 2
	note C_, 2
	note D#, 4
	note C_, 4
	note D#, 2
	note C_, 2
	note D#, 2
	note C_, 2
	note D#, 2
	note C_, 2
	note D#, 2
	note C_, 2
	note D#, 2
	note C_, 2
	note C_, 4
	note D#, 2
	note A#, 6
	note C_, 2
	note D#, 4
	note D#, 2
	note D#, 2
	note C_, 4
	note D#, 1
	note D#, 1
	note B_, 4
	note D#, 2
	note D#, 2
	note D#, 2
	note D#, 2
	note C_, 2
	note D#, 2
	note D#, 2
	note D#, 2
	note C_, 2
	note D#, 2
	note D#, 2
	note D#, 2
	note C_, 2
	note D#, 1
	note D#, 1
	note D#, 2
	note B_, 4
	note D#, 2
	callchannel Music_WildBattleSM_Ch4_branch_1
	note D#, 2
	callchannel Music_WildBattleSM_Ch4_branch_1
	note C_, 1
	note C_, 1
	note D#, 3
	note D#, 1
	note C_, 4
	note D#, 2
	note D#, 4
	note C_, 2
	note D#, 3
	note D#, 1
	note C_, 4
	note D#, 2
	note D#, 2
	note C_, 3
	note C_, 1
	note D#, 3
	note D#, 1
	note C_, 4
	note D#, 2
	note D#, 4
	note C_, 2
	note D#, 3
	note D#, 1
	note C_, 4
	note D#, 2
	note C_, 2
	note C_, 2
	note C_, 2
	note D#, 4
	note C_, 4
	note D#, 2
	note D#, 2
	note C_, 4
	note D#, 4
	note C_, 4
	note D#, 2
	note D#, 2
	note C_, 4
	note D#, 4
	note C_, 4
	note D#, 2
	note D#, 2
	note C_, 4
	note D#, 2
	note C_, 4
	note D#, 2
	note C_, 4
	note C_, 2
	note C_, 2
	note D#, 8
	note D#, 2
	note D#, 6
	note D#, 6
	note D#, 4
	note D#, 2
	note C_, 2
	note C_, 1
	note C_, 1
	note D#, 4
	note D#, 2
	note C_, 4
	note C_, 4
	note C_, 2
	note D#, 4
	note C_, 1
	note C_, 1
	note D_, 4
	note D#, 2
	note C_, 2
	note C_, 1
	note C_, 1
	note D#, 4
	note C_, 4
	note D#, 2
	note D#, 2
	note C_, 4
	note D#, 4
	note C_, 4
	note D#, 2
	note D#, 2
	note C_, 4
	note D#, 4
	note C_, 4
	note D#, 2
	note D#, 2
	note C_, 4
	note D#, 4
	note C_, 4
	note D#, 2
	note C_, 2
	note C_, 2
	note C_, 2
	note D#, 4
	note C_, 4
	note D#, 2
	note D#, 2
	note C_, 4
	note D#, 4
	note C_, 4
	note D#, 2
	note C_, 4
	note C_, 2
	note D#, 4
	note C_, 2
	note C_, 2
	note D#, 4
	note C_, 4
	note D#, 4
	note C_, 4
	note D#, 2
	note C_, 4
	note C_, 2
	loopchannel 0, Music_WildBattleSM_Ch4_loop_main

Music_WildBattleSM_Ch4_branch_1:
	note D#, 4
	note C_, 4
	note D#, 2
	note D#, 2
	note C_, 4
	note D#, 2
	note D#, 2
	note C_, 2
	note D#, 4
	note D#, 2
	note C_, 2
	endchannel
