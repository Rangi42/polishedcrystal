; Pokémon R/S/E - Mount Chimney
; Demixed by Mmmmmm
; https://pastebin.com/Yivqb9Tq
; https://hax.iimarckus.org/topic/6777/4/

Music_MountChimneyRSE:
	musicheader 4, 1, Music_MountChimneyRSE_Ch1
	musicheader 1, 2, Music_MountChimneyRSE_Ch2
	musicheader 1, 3, Music_MountChimneyRSE_Ch3
	musicheader 1, 4, Music_MountChimneyRSE_Ch4

Music_MountChimneyRSE_Ch1:
	tempo 160
	volume $77
	dutycycle 0
	tone $0002
	vibrato $8, $15
	notetype $c, $80
	octave 1
	note G_, 4
	octave 2
	note D#, 4
	octave 1
	note A#, 4
	octave 2
	note G_, 4
	note A#, 8
	intensity $87
	note A#, 9
Music_MountChimneyRSE_Ch1_loop_main:
	callchannel Music_MountChimneyRSE_Ch1_branch_1
	octave 4
	intensity $a2
	note F#, 2
	note F_, 1
	note E_, 1
	note D#, 1
	note C#, 1
	octave 3
	note B_, 1
	note __, 1
	notetype $8, $52
	dutycycle 1
Music_MountChimneyRSE_Ch1_loop_1:
	octave 2
	note B_, 1
	octave 3
	note D#, 1
	note F#, 1
	note A#, 1
	note F#, 1
	note D#, 1
	loopchannel 3, Music_MountChimneyRSE_Ch1_loop_1
Music_MountChimneyRSE_Ch1_loop_2:
	octave 2
	note A#, 1
	octave 3
	note C#, 1
	note F_, 1
	note G#, 1
	note F_, 1
	note C#, 1
	loopchannel 2, Music_MountChimneyRSE_Ch1_loop_2
	dutycycle 0
	notetype $6, $a2
	note G#, 2
	octave 4
	note C#, 4
	octave 3
	note F_, 2
	octave 4
	note D#, 2
	note C#, 1
	note C_, 1
	octave 3
	note A#, 1
	note G#, 3
	octave 4
	note C#, 2
	note C#, 2
	note C#, 2
	note C#, 4
	note C#, 4
	note C#, 2
	notetype $8, $52
	dutycycle 1
Music_MountChimneyRSE_Ch1_loop_3:
	octave 2
	note A_, 1
	octave 3
	note C#, 1
	note E_, 1
	note G#, 1
	note E_, 1
	note C#, 1
	loopchannel 2, Music_MountChimneyRSE_Ch1_loop_3
Music_MountChimneyRSE_Ch1_loop_4:
	octave 2
	note G#, 1
	octave 3
	note C_, 1
	note D#, 1
	note G_, 1
	note D#, 1
	note C_, 1
	loopchannel 2, Music_MountChimneyRSE_Ch1_loop_4
	dutycycle 0
	notetype $6, $a2
	note G#, 2
	octave 4
	note C_, 4
	octave 3
	note G#, 2
	octave 4
	note D#, 2
	note C#, 1
	note C_, 1
	octave 3
	note A#, 1
	note G#, 3
	dutycycle 1
	intensity $a7
	octave 2
	note A#, 12
	note G#, 2
	note A#, 2
	octave 3
	note C_, 8
	octave 2
	note G#, 2
	note D#, 2
	octave 3
	note C_, 2
	note C#, 2
	note D#, 12
	note D#, 2
	note E_, 2
	dutycycle 0
	intensity $a2
	note F_, 2
	note F_, 2
	note F_, 2
	note F_, 2
	note __, 10
	note F_, 4
	note D_, 2
	note F_, 2
	note D_, 2
	note F_, 2
	note G#, 4
	callchannel Music_MountChimneyRSE_Ch1_branch_1
	octave 3
	intensity $a2
	note D#, 2
	note D#, 2
	note A#, 2
	note A_, 2
	intensity $a4
	note G#, 4
	intensity $a2
	note G_, 4
	note G_, 2
	note G#, 4
	note G#, 2
	intensity $a7
	note G_, 8
	intensity $a2
	note D#, 2
	note D#, 2
	note A#, 2
	note A_, 2
	intensity $a4
	note G#, 4
	intensity $a2
	note G_, 4
	note G_, 2
	note G#, 4
	note G#, 2
	intensity $a7
	note B_, 8
	intensity $a2
	note D#, 2
	note D#, 2
	note A#, 2
	note A_, 2
	intensity $a4
	note G#, 4
	intensity $a2
	note G_, 4
	note D#, 2
	note D#, 2
	note A#, 2
	note A_, 2
	intensity $a4
	note G#, 4
	intensity $a2
	note G_, 4
	note D#, 2
	note D#, 2
	note A#, 2
	note A_, 2
	note D#, 2
	note D#, 2
	note A#, 2
	note A_, 2
	note D#, 2
	note D#, 2
	note A#, 2
	note A_, 2
	note D#, 2
	note D#, 2
	note D#, 2
	note D#, 1
	note D#, 1
	callchannel Music_MountChimneyRSE_blank
	note __, 2
	loopchannel 0, Music_MountChimneyRSE_Ch1_loop_main

Music_MountChimneyRSE_Ch1_branch_1:
	notetype $6, $a2
	octave 3
	note F_, 1
	note E_, 1
	note D#, 4
	note G#, 4
	note G_, 4
	note A_, 2
	note A#, 4
	note A#, 2
	intensity $a5
	note G#, 4
	note F_, 4
	intensity $a2
	note B_, 2
	note B_, 2
	note A#, 2
	note B_, 6
	octave 4
	note D#, 2
	note D#, 2
	note D#, 4
	note D#, 4
	intensity $a4
	note D_, 4
	octave 3
	note B_, 2
	octave 4
	intensity $a2
	note D_, 5
	octave 3
	note E_, 1
	note D#, 4
	note G#, 4
	note G_, 4
	intensity $a5
	note A#, 8
	note G#, 4
	note F_, 4
	intensity $a2
	note F#, 2
	note G#, 4
	note G#, 6
	octave 4
	note D#, 2
	note D#, 2
	note D_, 2
	note D#, 2
	note G#, 2
	note G#, 2
	note G_, 2
	note G#, 2
	note B_, 2
	note B_, 2
	octave 5
	note D#, 1
	note D_, 1
	note C_, 1
	octave 4
	note B_, 1
	note A_, 1
	note G_, 16
	note __, 3
	intensity $a3
	note D_, 2
	note D#, 8
	octave 3
	intensity $a2
	note G_, 4
	note D#, 2
	note G_, 2
	note F_, 2
	note G_, 2
	note A#, 10
	octave 2
	note G_, 2
	note F_, 2
	note G_, 2
	note A#, 2
	octave 3
	intensity $a0
	note D#, 16
	intensity $a7
	note D#, 16
	note __, 16
	note __, 16
	note __, 4
	intensity $a2
	note A#, 2
	note A_, 2
	note G#, 4
	note G_, 4
	note A_, 2
	note A#, 4
	note A#, 2
	intensity $a5
	note G#, 4
	note F_, 4
	intensity $a2
	note B_, 2
	note B_, 2
	note A#, 2
	note B_, 6
	octave 4
	note D#, 2
	note D#, 2
	note D#, 4
	note D#, 4
	intensity $a4
	note D_, 4
	octave 3
	intensity $a2
	note B_, 2
	octave 4
	note D_, 2
	octave 3
	note D#, 2
	note D#, 2
	note A#, 2
	note A_, 2
	note G#, 4
	note G_, 4
	intensity $a5
	note A#, 8
	note G#, 4
	note F_, 4
	intensity $a2
	note F#, 2
	note G#, 4
	note G#, 6
	octave 4
	note D#, 2
	note D#, 2
	note D_, 2
	note D#, 2
	note G#, 2
	note G#, 2
	note G_, 2
	note G#, 2
	note B_, 2
	note B_, 2
	octave 5
	note D#, 1
	note D_, 1
	note C_, 1
	octave 4
	note B_, 1
	note A_, 1
	note G_, 16
	note __, 3
	note D_, 2
	note D#, 8
	octave 3
	note G_, 4
	note D#, 2
	note G_, 2
	note F_, 2
	note G_, 2
	note A#, 10
	octave 2
	note G_, 2
	note F_, 2
	note G_, 2
	note A#, 2
	octave 3
	intensity $a0
	note D#, 16
	intensity $a7
	note D#, 16
	note __, 16
	note __, 16
	endchannel

Music_MountChimneyRSE_blank:
	note __, 16
	loopchannel 8, Music_MountChimneyRSE_blank
	endchannel

Music_MountChimneyRSE_Ch2:
	dutycycle 3
	vibrato $12, $25
	tone $0001
	notetype $c, $80
	octave 2
	note D#, 4
	note A#, 4
	note G_, 4
	octave 3
	note C#, 4
	note D#, 8
	intensity $87
	note D#, 9
Music_MountChimneyRSE_Ch2_loop:
	callchannel Music_MountChimneyRSE_Ch2_branch_1
	octave 4
	intensity $c0
	note D#, 8
	intensity $c6
	note D#, 12
	intensity $c2
	note C#, 8
	octave 3
	note G#, 4
	intensity $c0
	note A#, 16
	intensity $c7
	note A#, 16
	octave 4
	intensity $c0
	note C#, 16
	intensity $c4
	note C#, 8
	intensity $c2
	octave 3
	note B_, 4
	octave 4
	note C#, 2
	octave 3
	note B_, 2
	intensity $c5
	note A#, 2
	octave 4
	note C_, 1
	octave 3
	note A#, 1
	intensity $c0
	note G#, 16
	intensity $c5
	note G#, 12
	intensity $c0
	note F#, 4
	intensity $c5
	note F#, 8
	note F_, 2
	note F#, 2
	note G#, 8
	note D#, 8
	intensity $c7
	note G#, 12
	note G_, 2
	note G#, 2
	intensity $c0
	note A#, 8
	intensity $a0
	note G#, 1
	note G_, 1
	intensity $90
	note F_, 1
	intensity $70
	note D#, 1
	intensity $50
	note C#, 1
	intensity $40
	note C_, 1
	octave 2
	intensity $30
	note A#, 1
	note __, 3
	intensity $c2
	octave 3
	note A#, 4
	note F_, 2
	octave 4
	note D_, 2
	octave 3
	note A#, 2
	octave 4
	note D_, 2
	note F_, 4
	intensity $a2
	callchannel Music_MountChimneyRSE_Ch2_branch_1
	octave 3
	intensity $a2
	note G#, 2
	note G#, 2
	octave 4
	note F#, 2
	note F_, 2
	intensity $a4
	note D#, 4
	intensity $a2
	note D_, 4
	note D_, 2
	note D#, 4
	note D#, 2
	intensity $a7
	note D_, 8
	dutycycle 0
	octave 3
	intensity $a2
	note G#, 2
	note G#, 2
	octave 4
	note F#, 2
	note F_, 2
	intensity $a4
	note D#, 4
	intensity $a2
	note D_, 4
	note D_, 2
	note D#, 4
	note D#, 2
	intensity $a7
	note F#, 8
	dutycycle 1
	octave 3
	intensity $a2
	note G#, 2
	note G#, 2
	octave 4
	note F#, 2
	note F_, 2
	intensity $a4
	note D#, 4
	intensity $a2
	note D_, 4
	dutycycle 0
	octave 3
	note G#, 2
	note G#, 2
	octave 4
	note F#, 2
	note F_, 2
	intensity $a4
	note D#, 4
	intensity $a2
	note D_, 4
	dutycycle 1
	octave 3
	note G#, 2
	note G#, 2
	octave 4
	note F#, 2
	note F_, 2
	octave 3
	note G#, 2
	note G#, 2
	octave 4
	note F#, 2
	note F_, 2
	dutycycle 0
	octave 3
	note G#, 2
	note G#, 2
	octave 4
	note F#, 2
	note F_, 2
	octave 3
	note G#, 2
	note G#, 2
	note G#, 2
	note G#, 1
	note G#, 1
	callchannel Music_MountChimneyRSE_blank
	dutycycle 3
	note __, 2
	loopchannel 0, Music_MountChimneyRSE_Ch2_loop

Music_MountChimneyRSE_Ch2_branch_1:
	notetype $6, $a2
	octave 3
	note A#, 1
	note A_, 1
	note G#, 4
	octave 4
	note D#, 4
	note D_, 4
	note F_, 2
	note F#, 4
	note F#, 2
	intensity $a5
	note F_, 4
	note C#, 4
	intensity $a2
	note D#, 2
	note D#, 2
	note D_, 2
	note D#, 6
	dutycycle 0
	octave 3
	note B_, 2
	note B_, 2
	note B_, 4
	note B_, 4
	intensity $a4
	note A#, 4
	note G_, 2
	intensity $a2
	note A#, 5
	dutycycle 3
	note A_, 1
	note G#, 4
	octave 4
	note D#, 4
	note D_, 3
	note G_, 1
	intensity $a5
	note F#, 8
	note F_, 4
	note C#, 4
	intensity $a2
	note D_, 2
	note D#, 4
	note D#, 5
	note G_, 1
	intensity $a0
	note G#, 8
	intensity $a6
	note G#, 12
	intensity $a2
	note D#, 2
	octave 3
	note A#, 2
	note G_, 2
	intensity $a1
	note D#, 4
	note C#, 4
	octave 2
	note A#, 4
	note G_, 4
	note D#, 2
	octave 3
	intensity $a3
	note D_, 2
	note D#, 8
	dutycycle 0
	octave 2
	intensity $a2
	note G_, 4
	note D#, 2
	note G_, 2
	note F_, 2
	note G_, 2
	note A#, 10
	dutycycle 3
	octave 3
	note D#, 2
	note D_, 2
	note D#, 2
	note G_, 2
	notetype $c, $a0
	note A#, 8
	intensity $a7
	note A#, 9
	notetype $6, $a2
	dutycycle 0
	octave 4
	note D#, 4
	note C#, 2
	note D#, 1
	note E_, 1
	note C#, 2
	octave 3
	note A#, 2
	note G_, 2
	note A#, 2
	note A#, 2
	note A#, 2
	note A#, 2
	octave 4
	note D#, 1
	note D_, 1
	note C_, 1
	octave 3
	note A#, 1
	note A_, 1
	note G_, 7
	dutycycle 3
	octave 4
	note F#, 2
	note F_, 2
	note D#, 4
	note D_, 4
	note F_, 2
	note F#, 4
	note F#, 2
	intensity $a5
	note F_, 4
	note C#, 4
	intensity $a2
	note D#, 2
	note D#, 2
	note D_, 2
	note D#, 6
	dutycycle 0
	octave 3
	note B_, 2
	note B_, 2
	note B_, 4
	note B_, 4
	intensity $a4
	note A#, 4
	intensity $a2
	note G_, 2
	note A#, 2
	dutycycle 3
	note G#, 2
	note G#, 2
	octave 4
	note F#, 2
	note F_, 2
	note D#, 4
	note D_, 3
	note G_, 1
	intensity $a5
	note F#, 8
	note F_, 4
	note C#, 4
	intensity $a2
	note D_, 2
	note D#, 4
	note D#, 5
	note G_, 1
	intensity $a0
	note G#, 8
	intensity $a7
	note G#, 12
	intensity $a2
	note D#, 2
	octave 3
	note A#, 2
	note G_, 2
	intensity $a1
	note D#, 4
	note C#, 4
	octave 2
	note A#, 4
	note G_, 4
	note D#, 2
	octave 3
	intensity $a3
	note D_, 2
	note D#, 8
	octave 2
	dutycycle 0
	intensity $a2
	note G_, 4
	note D#, 2
	note G_, 2
	note F_, 2
	note G_, 2
	note A#, 10
	dutycycle 3
	octave 3
	note D#, 2
	note D_, 2
	note D#, 2
	note G_, 2
	intensity $a0
	note A#, 16
	intensity $a7
	note A#, 16
	intensity $60
	octave 2
	note D#, 8
	intensity $70
	note A#, 8
	octave 3
	intensity $80
	note G_, 8
	octave 4
	intensity $90
	note C#, 8
	endchannel

Music_MountChimneyRSE_Ch3:
	notetype $6, $25
	vibrato $12, $15
	octave 2
	note D#, 4
	note __, 12
	octave 1
	note A#, 4
	note __, 8
	note A#, 1
	note __, 1
	note A#, 1
	note __, 1
	octave 2
	note D#, 4
	note __, 4
	octave 1
	note A#, 4
	note __, 4
	note D#, 4
	note __, 4
	octave 4
	note C#, 1
	octave 3
	note A#, 1
	note G_, 1
	note D#, 1
	note C#, 1
	octave 2
	note A#, 1
	note G_, 1
	note D#, 1
Music_MountChimneyRSE_Ch3_loop:
	callchannel Music_MountChimneyRSE_Ch3_branch_1
	callchannel Music_MountChimneyRSE_Ch3_branch_1
	octave 1
	note B_, 3
	note F#, 3
	octave 2
	note F#, 2
	note __, 4
	note A#, 2
	note __, 4
	note A#, 2
	note D#, 4
	note F#, 2
	note __, 2
	note C#, 2
	note __, 2
	octave 1
	note A#, 3
	note F_, 3
	octave 2
	note F_, 2
	note __, 4
	note G#, 2
	note __, 4
	note G#, 2
	note C#, 4
	note F#, 1
	note __, 1
	note G#, 1
	note __, 1
	octave 1
	note A#, 4
	octave 1
	note A_, 3
	note E_, 3
	octave 2
	note E_, 2
	note __, 4
	note G#, 2
	note __, 4
	note G#, 2
	note C#, 4
	note E_, 2
	note __, 2
	octave 1
	note A_, 2
	note __, 2
	octave 1
	note G#, 3
	note D#, 3
	octave 2
	note D#, 2
	note __, 4
	note G_, 2
	note __, 4
	note G_, 2
	note C_, 4
	note D#, 1
	note __, 1
	note G_, 1
	note __, 1
	octave 1
	note G#, 4
	note F#, 6
	note A#, 2
	note __, 4
	octave 2
	note C#, 2
	note __, 2
	octave 1
	note F_, 2
	note G#, 2
	octave 2
	note C_, 2
	note D#, 2
	note __, 2
	note F_, 2
	note __, 2
	note G_, 2
	octave 1
	note E_, 6
	note B_, 2
	note __, 4
	octave 2
	note D#, 2
	note __, 2
	octave 1
	note D_, 2
	note F_, 2
	note G#, 2
	note A#, 2
	octave 2
	note D_, 2
	note F_, 2
	note G#, 2
	note A#, 2
	note __, 2
	note D_, 2
	note __, 2
	note D_, 1
	note __, 1
	note D_, 1
	note __, 1
	note A#, 1
	note __, 1
	note D_, 1
	note __, 1
	octave 1
	note A_, 1
	note __, 1
	callchannel Music_MountChimneyRSE_Ch3_branch_1
	callchannel Music_MountChimneyRSE_Ch3_branch_1
	callchannel Music_MountChimneyRSE_Ch3_branch_2
	callchannel Music_MountChimneyRSE_Ch3_branch_2
	octave 2
	note G#, 4
	octave 1
	note G#, 4
	note __, 4
	note G#, 1
	note __, 1
	note G#, 1
	note __, 1
	octave 2
	note G#, 4
	octave 1
	note G#, 4
	note __, 4
	note G#, 1
	note __, 1
	note G#, 1
	note __, 1
	octave 2
	note G#, 4
	octave 1
	note G#, 1
	note __, 1
	note G#, 1
	note __, 1
	octave 2
	note G#, 4
	octave 1
	note G#, 1
	note __, 1
	note G#, 1
	note __, 1
	octave 2
	note G#, 4
	octave 1
	note G#, 1
	note __, 1
	note G#, 1
	note __, 1
	octave 2
	note G#, 4
	octave 1
	note G#, 1
	note __, 1
	note G#, 1
	note __, 1
	callchannel Music_MountChimneyRSE_blank
	loopchannel 0, Music_MountChimneyRSE_Ch3_loop

Music_MountChimneyRSE_Ch3_branch_1:
	octave 1
	note G#, 6
	octave 2
	note D#, 2
	note __, 4
	note B_, 2
	note __, 4
	note B_, 1
	note __, 1
	octave 1
	note B_, 4
	octave 2
	note D#, 2
	note __, 2
	note C#, 2
	note __, 2
	octave 1
	note G#, 6
	octave 2
	note D#, 2
	note __, 4
	note B_, 2
	note __, 4
	note B_, 1
	note __, 1
	octave 1
	note B_, 4
	octave 2
	note D#, 1
	note __, 1
	note G#, 1
	note __, 1
	octave 1
	note B_, 4
	octave 1
	note G#, 6
	octave 2
	note D#, 2
	note __, 4
	note B_, 2
	note __, 4
	note B_, 1
	note __, 1
	octave 1
	note B_, 4
	octave 2
	note D#, 2
	note __, 2
	note C#, 2
	note __, 2
	octave 1
	note G#, 6
	octave 2
	note D#, 2
	note __, 4
	note B_, 2
	note __, 4
	note B_, 1
	note __, 1
	octave 1
	note B_, 4
	octave 2
	note D#, 1
	note __, 1
	note C#, 1
	note __, 1
	octave 1
	note A#, 1
	note __, 1
	note G_, 1
	note __, 1
	octave 1
	note D#, 6
	note A#, 2
	note __, 4
	octave 2
	note D#, 2
	note __, 4
	note D#, 1
	note __, 1
	octave 1
	note D#, 4
	octave 2
	note A#, 2
	note __, 2
	note G_, 2
	note __, 2
	octave 1
	note D#, 6
	note A#, 2
	note __, 4
	octave 2
	note D#, 2
	note __, 4
	note D#, 1
	note __, 1
	octave 1
	note D#, 4
	note A#, 1
	note __, 1
	octave 2
	note D#, 1
	note __, 1
	octave 1
	note G_, 4
	note D#, 6
	note A#, 2
	note __, 4
	octave 2
	note D#, 2
	note __, 4
	note D#, 1
	note __, 1
	octave 1
	note D#, 4
	octave 2
	note A#, 2
	note __, 2
	note G_, 2
	note __, 2
	octave 1
	note D#, 6
	note A#, 2
	note __, 4
	octave 2
	note D#, 2
	note __, 4
	note D#, 1
	note __, 1
	octave 1
	note D#, 4
	note G_, 1
	note __, 1
	octave 2
	note C#, 1
	note __, 1
	note D#, 1
	note G_, 1
	note A#, 1
	octave 3
	note C#, 1
	endchannel

Music_MountChimneyRSE_Ch3_branch_2:
	octave 2
	note G#, 4
	octave 1
	note G#, 4
	note __, 4
	note G#, 1
	note __, 1
	note G#, 1
	note __, 1
	note G#, 1
	note __, 1
	note G#, 1
	note __, 1
	note G#, 1
	note __, 1
	note G#, 1
	note __, 1
	note G#, 1
	note B_, 1
	octave 2
	note C#, 1
	note D_, 1
	note D#, 1
	note E_, 1
	note F_, 1
	note F_, 1
	endchannel

Music_MountChimneyRSE_Ch4:
	togglenoise $4
	notetype $6
	note B_, 4
	note E_, 2
	note C#, 1
	note G_, 1
	note E_, 2
	note E_, 4
	note E_, 2
	note E_, 2
	note D_, 2
	note E_, 2
	note D_, 2
	note C#, 1
	note C#, 1
	note C#, 1
	note C#, 1
	note E_, 2
	note E_, 2
	note E_, 2
	note E_, 2
	note C#, 1
	note C#, 1
	note C#, 1
	note C#, 1
	note E_, 2
	note D_, 2
	note E_, 2
	note D_, 2
	note E_, 2
	note E_, 2
	note C#, 1
	note C#, 1
	note C#, 1
	note C#, 1
	note E_, 2
	note E_, 2
	note C#, 1
	note C#, 1
	note C#, 1
	note C#, 1
Music_MountChimneyRSE_Ch4_loop:
	callchannel Music_MountChimneyRSE_Ch4_branch_1
	callchannel Music_MountChimneyRSE_Ch4_branch_1
	note A_, 16
	note D_, 2
	note C#, 2
	note D_, 2
	note C#, 1
	note C#, 1
	note E_, 4
	note D_, 4
	note E_, 2
	note C#, 2
	note C#, 2
	note D_, 1
	note C#, 1
	note E_, 4
	note D_, 2
	note D_, 2
	note E_, 2
	note D_, 2
	note E_, 2
	note C#, 1
	note C#, 1
	note E_, 4
	note D_, 2
	note D_, 2
	note E_, 4
	note C#, 1
	note C#, 1
	note C#, 1
	note C#, 1
	note E_, 4
	note E_, 2
	note D_, 2
	note E_, 2
	note D_, 2
	note E_, 2
	note C#, 1
	note C#, 1
	note E_, 4
	note D_, 2
	note D_, 2
	note E_, 2
	note C#, 2
	note C#, 2
	note D_, 1
	note C#, 1
	note E_, 4
	note D_, 2
	note D_, 2
	note E_, 2
	note D_, 2
	note E_, 2
	note C#, 1
	note C#, 1
	note E_, 4
	note B_, 4
	note E_, 6
	note C#, 1
	note C#, 1
	note E_, 4
	note E_, 2
	note D_, 2
	note D#, 2
	note D#, 2
	note D#, 2
	note C#, 1
	note C#, 1
	note E_, 4
	note E_, 4
	note D_, 2
	note E_, 2
	note D_, 4
	note E_, 2
	note D_, 2
	note E_, 4
	note E_, 4
	note E_, 2
	note C#, 1
	note C#, 1
	note D_, 2
	note D_, 2
	note D_, 2
	note D_, 4
	note C#, 4
	note C#, 2
	note C#, 2
	note C#, 2
	note B_, 4
	callchannel Music_MountChimneyRSE_Ch4_branch_1
	callchannel Music_MountChimneyRSE_Ch4_branch_1
	note E_, 4
	note A#, 8
	note E_, 2
	note E_, 2
	note E_, 4
	note A#, 4
	note B_, 8
	note E_, 4
	note A#, 8
	note E_, 2
	note E_, 2
	note E_, 4
	note A#, 4
	note B_, 8
	note E_, 4
	note A#, 4
	note B_, 8
	note E_, 4
	note A#, 4
	note B_, 8
	note E_, 4
	note A#, 4
	note E_, 4
	note A#, 4
	note E_, 4
	note A#, 4
	note E_, 4
	note E_, 2
	note E_, 1
	note E_, 1
	note E_, 2
	note D_, 2
	note E_, 2
	note A_, 2
	note E_, 2
	note E_, 2
	note A_, 2
	note E_, 2
	note E_, 2
	note D_, 2
	note D_, 2
	note E_, 2
	note D_, 1
	note C#, 1
	note C#, 1
	note C#, 1
	note D_, 2
	note D_, 2
	note D_, 2
	note D_, 2
	note D_, 1
	note C#, 1
	note C#, 1
	note C#, 1
	note D_, 1
	note D_, 1
	note D_, 1
	note D_, 1
	note E_, 2
	note E_, 2
	note E_, 2
	note D_, 2
	note C#, 1
	note C#, 1
	note C#, 1
	note C#, 1
	note E_, 2
	note D_, 2
	note C#, 1
	note C#, 1
	note C#, 1
	note C#, 1
	note E_, 2
	note D_, 2
	note C#, 1
	note C#, 1
	note C#, 1
	note C#, 1
	note E_, 2
	note D_, 2
	note __, 2
	note E_, 2
	note E_, 2
	note D_, 2
	note E_, 2
	note A_, 2
	note D_, 1
	note C#, 1
	note C#, 1
	note C#, 1
	note E_, 2
	note D_, 2
	note E_, 2
	note D_, 2
	note C#, 1
	note C#, 1
	note C#, 1
	note C#, 1
	note E_, 2
	note D_, 2
	note E_, 2
	note D_, 2
	note E_, 2
	note E_, 2
	note C#, 1
	note C#, 1
	note C#, 1
	note C#, 1
	note E_, 2
	note E_, 2
	note C#, 1
	note C#, 1
	note C#, 1
	note C#, 1
	loopchannel 0, Music_MountChimneyRSE_Ch4_loop

Music_MountChimneyRSE_Ch4_branch_1:
	note B_, 6
	note C#, 4
	note G_, 2
	note C#, 4
	note F_, 2
	note F_, 2
	note C#, 2
	note F_, 2
	note E_, 4
	note F_, 4
	note E_, 2
	note E_, 2
	note A#, 4
	note C#, 4
	note E_, 2
	note E_, 2
	note E_, 4
	note A#, 4
	note C#, 4
	note E_, 2
	note E_, 2
	note E_, 4
	note A#, 2
	note C#, 4
	note G_, 2
	note C#, 8
	note D_, 2
	note D_, 2
	note E_, 4
	note E_, 2
	note E_, 2
	note D_, 2
	note D_, 2
	note A#, 4
	note D_, 4
	note E_, 2
	note E_, 2
	note D_, 2
	note D_, 2
	note A#, 3
	note C#, 1
	note D_, 4
	note A#, 4
	note B_, 6
	note C#, 4
	note G_, 2
	note C#, 4
	note F_, 2
	note F_, 2
	note C#, 4
	note E_, 4
	note D_, 2
	note D_, 2
	note E_, 4
	note D#, 2
	note C#, 4
	note G_, 2
	note D_, 2
	note D_, 2
	note E_, 4
	note D#, 2
	note C#, 2
	note E_, 4
	note E_, 4
	note D_, 4
	note A_, 2
	note D_, 4
	note A_, 2
	note D_, 4
	note A_, 2
	note D#, 2
	note D#, 4
	note E_, 4
	note D#, 4
	note B_, 16
	note F_, 2
	note F_, 2
	note F_, 2
	note F_, 2
	note G#, 2
	note A_, 2
	note D_, 2
	note E_, 2
	endchannel
