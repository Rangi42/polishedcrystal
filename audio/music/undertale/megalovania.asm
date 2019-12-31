; Undertale - Megalovania
; Demixed by Shockslayer

Music_Megalovania:
	musicheader 4, 1, Music_Megalovania_Ch1
	musicheader 1, 2, Music_Megalovania_Ch2
	musicheader 1, 3, Music_Megalovania_Ch3
	musicheader 1, 4, Music_Megalovania_Ch4

Music_Megalovania_Ch1:
	tempo $A0
	volume $77
	stereopanning $77
Music_Megalovania_Ch1_loop:
	notetype $C, $00
	note __, 16
	note __, 16
	note __, 16
	note __, 16
	sound_duty $55
	intensity $F3
Music_Megalovania_Ch1_loop_1:
	octave 4
	note D_, 1
	note D_, 1
	callchannel Music_Megalovania_Ch1_ditty_1
	note C_, 1
	note C_, 1
	callchannel Music_Megalovania_Ch1_ditty_1
	octave 3
	note B_, 1
	note B_, 1
	callchannel Music_Megalovania_Ch1_ditty_1
	octave 3
	note A#, 1
	note A#, 1
	callchannel Music_Megalovania_Ch1_ditty_2
	loopchannel 2, Music_Megalovania_Ch1_loop_1
	sound_duty $00
	intensity $91
	callchannel Music_Megalovania_Ch1Ch3_ditty_2
	octave 3
	note C_, 1
	note C_, 1
	intensity $8D
	vibrato $08, $13
	octave 4
	note A_, 2
	note A_, 1
	note A_, 1
	note __, 1
	note A_, 1
	note __, 1
	note A_, 2
	note G_, 1
	note __, 1
	note G_, 4
	note __, 1
	note A_, 2
	note A_, 1
	note A_, 1
	note __, 1
	note A_, 1
	note __, 1
	note G_, 1
	note __, 1
	note A_, 1
	note __, 1
	octave 5
	note D_, 1
	note __, 1
	octave 4
	note A_, 1
	note G_, 2
	octave 5
	note D_, 2
	octave 4
	note A_, 2
	note G_, 2
	note F_, 2
	octave 5
	note C_, 2
	octave 4
	note G_, 2
	note F_, 2
	note E_, 2
	octave 3
	note A#, 2
	octave 4
	note C_, 1
	note D_, 1
	note __, 1
	note F_, 1
	note __, 1
	intensity $6D
	vibrato $0F, $13
	octave 5
	note C_, 8
	note __, 1
	sound_duty $5A
	intensity $F3
	callchannel Music_Megalovania_Ch1_ditty_3
	callchannel Music_Megalovania_Ch1_ditty_4
	callchannel Music_Megalovania_Ch1_ditty_3
	callchannel Music_Megalovania_Ch1_ditty_4
	octave 2
	note A#, 1
	octave 3
	note D_, 1
	note F_, 1
	note D_, 1
	octave 2
	note A#, 1
	octave 3
	note D_, 1
	note F_, 1
	note D_, 1
	callchannel Music_Megalovania_Ch1Ch2_ditty_1
	sound_duty $55
	intensity $A3
	octave 2
	note A_, 4
	octave 3
	note F_, 4
	note E_, 4
	intensity $A1
	octave 2
	note G_, 2
	intensity $A6
	note A_, 16
	note __, 2
	intensity $A1
	note A_, 2
	note __, 2
	intensity $A3
	octave 3
	note G_, 4
	note F_, 4
	intensity $A1
	note E_, 2
	intensity $A3
	note F_, 6
	note E_, 4
	note D_, 4
	note C_, 4
	note D_, 4
	note C_, 4
	octave 2
	note A_, 4
	intensity $A1
	octave 3
	note C_, 2
	intensity $A3
	note D_, 6
	note C_, 4
	octave 2
	note A_, 4
	intensity $A1
	octave 3
	note C_, 2
	intensity $A3
	octave 2
	note A_, 6
	intensity $A1
	note G_, 2
	note __, 2
	note A_, 2
	note __, 2
	octave 3
	note C_, 2
	intensity $A4
	octave 2
	note A_, 10
	intensity $A3
	note G_, 6
	note __, 2
	note A_, 4
	octave 3
	note F_, 4
	note E_, 4
	intensity $A1
	octave 2
	note G_, 2
	intensity $A5
	note A_, 14
	note __, 4
	intensity $A1
	note A_, 2
	note __, 2
	intensity $A3
	octave 3
	note G_, 4
	note F_, 4
	intensity $A1
	note E_, 2
	intensity $A3
	note F_, 6
	note E_, 4
	note D_, 4
	note C_, 4
	note D_, 4
	note C_, 4
	octave 2
	note A_, 4
	octave 3
	note C_, 4
	note D_, 4
	note C_, 4
	octave 2
	note A_, 4
	intensity $A1
	octave 3
	note C_, 2
	note __, 1
	note C_, 1
	notetype $9, $A5
	note D_, 9
	notetype $3, $A1
	note A_, 1
	note A#, 1
	note B_, 1
	octave 4
	note C_, 1
	note C#, 1
	notetype $C, $A6
	note D_, 8
	sound_duty $00
	vibrato $00, $13
	callchannel Music_Megalovania_Ch1_ditty_5
	intensity $3F
	note F_, 4
	intensity $88
	note F_, 12
	intensity $87
	note F_, 12
	note __, 4
	callchannel Music_Megalovania_Ch1_ditty_5
	sound_duty $55
	intensity $A1
	vibrato $0F, $13
	octave 3
	note D_, 1
	note D_, 1
	note __, 14
	note C_, 1
	note C_, 1
	note __, 14
	octave 2
	note B_, 1
	note B_, 1
	note __, 14
	note A#, 1
	note A#, 1
	note __, 14
	intensity $F2
	octave 3
	note D_, 1
	note D_, 1
	callchannel Music_Megalovania_Ch1Ch3_ditty_1
	note C_, 1
	note C_, 1
	callchannel Music_Megalovania_Ch1Ch3_ditty_1
	note __, 2
	octave 4
	note F_, 1
	note __, 1
	note E_, 1
	note __, 2
	note C_, 1
	note __, 1
	note E_, 1
	note __, 1
	note D_, 2
	octave 3
	note G_, 1
	note A_, 1
	octave 4
	note C_, 1
	note __, 1
	note D_, 1
	note A_, 1
	note D_, 1
	note G_, 1
	note A_, 1
	note F_, 1
	note C_, 1
	note __, 1
	note G_, 1
	note __, 1
	note A_, 2
	octave 3
	note A_, 1
	octave 4
	note C_, 1
	note C#, 1
Music_Megalovania_Ch1_loop_2:
	note D_, 1
	note C_, 1
	octave 3
	note A_, 1
	octave 4
	loopchannel 5, Music_Megalovania_Ch1_loop_2
	note C_, 1
Music_Megalovania_Ch1_loop_3:
	note E_, 1
	note C_, 1
	octave 3
	note A_, 1
	octave 4
	loopchannel 5, Music_Megalovania_Ch1_loop_3
	note G_, 1
	note A_, 1
	note F_, 1
	note G_, 1
	note C_, 1
	note E_, 1
	note G_, 1
	octave 3
	note A_, 1
	octave 4
	note E_, 1
	note F_, 1
	octave 3
	note A_, 1
	octave 4
	note E_, 1
	octave 3
	note A_, 1
	octave 4
	note D_, 1
	note C_, 1
	octave 3
	note A_, 1
	octave 4
	note C_, 1
	notetype $A, $F1
	note D_, 1
	notetype $6, $F1
	note __, 1
	notetype $A, $F1
	note D_, 1
	notetype $6, $F1
	note __, 1
	notetype $A, $F1
	note D_, 1
	notetype $6, $F1
	note __, 1
	intensity $F2
	note A_, 2
	note __, 2
	note G_, 2
	note A_, 2
	note __, 2
	note G_, 2
	note __, 2
	octave 5
	note C_, 4
	octave 4
	note F_, 2
	note E_, 2
	note C_, 2
	octave 3
	note A_, 2
	callchannel Music_Megalovania_Ch1_ditty_6
	note F_, 4
	octave 4
	note D_, 2
	callchannel Music_Megalovania_Ch1_ditty_7
	note G_, 2
	callchannel Music_Megalovania_Ch1_ditty_6
	note A_, 2
	octave 4
	note D_, 2
	octave 3
	note A_, 2
	octave 4
	callchannel Music_Megalovania_Ch1_ditty_7
	note __, 4
	note D_, 2
	note __, 2
	note F_, 2
	note __, 2
	note A_, 2
	note __, 2
	intensity $F1
	octave 4
Music_Megalovania_Ch1_loop3:
	note D_, 1
	note D#, 1
	loopchannel 4, Music_Megalovania_Ch1_loop3
	intensity $F2
	octave 3
	note A_, 6
	note __, 2
	note F_, 4
	note G_, 4
	note A_, 6
	note __, 2
	note E_, 4
	note D_, 4
	note C_, 4
	note E_, 4
	loopchannel 0, Music_Megalovania_Ch1_loop

Music_Megalovania_Ch1_ditty_1:
	octave 5
	note D_, 1
	note __, 1
	octave 4
	note A_, 1
	note __, 2
	note G#, 1
	note __, 1
	note G_, 1
	note __, 1
	note F_, 2
	note D_, 1
	note F_, 1
	note G_, 1
	endchannel

Music_Megalovania_Ch1_ditty_2:
	octave 5
	note D_, 1
	note __, 1
	octave 4
	note A_, 1
	note __, 1
	note G#, 1
	note __, 1
	note F_, 1
	note __, 1
	note C_, 1
	note G_, 2
	note D_, 1
	note F_, 1
	note G_, 1
	endchannel

Music_Megalovania_Ch1_ditty_3:
	octave 2
	note A#, 1
	octave 3
	note D_, 1
	note F_, 1
	note D_, 1
	octave 2
	note A#, 1
	octave 3
	note D_, 1
	note F_, 1
	note D_, 1
	octave 2
	note A#, 1
	octave 3
	note D_, 1
	note F_, 1
	note D_, 1
	octave 2
	note A#, 1
	octave 3
	note D_, 1
	note F_, 1
	note D_, 1
	octave 2
	note A_, 1
	octave 3
	note C#, 1
	note E_, 1
	note C#, 1
	octave 2
	note A_, 1
	octave 3
	note C#, 1
	note E_, 1
	note C#, 1
	octave 2
	note A_, 1
	octave 3
	note C#, 1
	note E_, 1
	note C#, 1
	octave 2
	note A_, 1
	octave 3
	note C#, 1
	note E_, 1
	note C#, 1
	endchannel

Music_Megalovania_Ch1_ditty_4:
	note D_, 1
	note F_, 1
	note A_, 1
	note F_, 1
	note D_, 1
	note F_, 1
	note A_, 1
	note F_, 1
	note __, 1
	note F_, 1
	note D_, 1
	octave 2
	note A_, 1
	octave 3
	note D_, 1
	octave 2
	note A_, 1
	note G_, 1
	note A_, 1
	octave 3
	note F_, 1
	note D_, 1
	note __, 1
	octave 2
	note B_, 1
	octave 3
	note F_, 1
	note D_, 1
	octave 2
	note B_, 1
	octave 3
	note D_, 1
	note __, 1
	note F_, 1
	note E_, 1
	note D_, 1
	octave 2
	note B_, 1
	octave 3
	note D_, 1
	note D_, 1
	note D_, 1
	endchannel

Music_Megalovania_Ch1_ditty_5:
	intensity $3F
	octave 1
	note A#, 4
	intensity $88
	note A#, 8
	intensity $3F
	octave 2
	note F_, 4
	note E_, 4
	intensity $88
	note E_, 4
	intensity $3F
	note D_, 4
	intensity $88
	note D_, 4
	endchannel

Music_Megalovania_Ch1_ditty_6:
	octave 4
	note F_, 2
	note E_, 2
	note F_, 2
	note D_, 2
	octave 3
	note A_, 2
	note __, 2
	endchannel

Music_Megalovania_Ch1_ditty_7:
	note F_, 2
	octave 5
	note C_, 2
	octave 4
	note A_, 2
	note F_, 2
	note D_, 2
	octave 3
	note A_, 2
	endchannel

Music_Megalovania_Ch1Ch2_ditty_1:
	sound_duty $00
	intensity $F1
	octave 4
	note F_, 1
	note D_, 1
	note F_, 1
	note G_, 1
	note G#, 1
	note G_, 1
	note F_, 1
	note D_, 1
	notetype $6, $F1
	note G#, 1
	note G_, 1
	note E_, 1
	note C#, 1
	intensity $F3
	note F_, 4
	intensity $F4
	note G_, 16
	note __, 2
	intensity $F3
	note G#, 4
	intensity $F1
	note A_, 2
	octave 5
	note C_, 2
	note __, 2
	octave 4
	note A_, 2
	note G#, 2
	note G_, 2
	note F_, 2
	note D_, 2
	note E_, 2
	intensity $F3
	note F_, 4
	note G_, 4
	note A_, 4
	octave 5
	note C_, 4
	note C#, 4
	intensity $F1
	octave 4
	note G#, 2
	note __, 2
	note G#, 2
	note G_, 2
	note F_, 2
	intensity $F4
	note G_, 16
	note __, 2
	intensity $F3
	octave 3
	note A#, 2
	note __, 2
	octave 4
Music_Megalovania_Ch1Ch2_ditty_1a:
	note C_, 2
	note __, 2
	note D_, 2
	note __, 2
	note F_, 2
	note __, 2
	note E_, 8
	note D_, 8
	note E_, 8
	note F_, 8
	note G_, 8
	note E_, 8
	intensity $F4
	note A_, 16
	intensity $F1
	note A_, 2
	note G#, 2
	note G_, 2
	note F#, 2
	note F_, 2
	note E_, 2
	note D#, 2
	note D_, 2
	intensity $F4
	note C#, 16
	note D_, 16
	endchannel

Music_Megalovania_Ch1Ch3_ditty_1:
	octave 4
	note D_, 1
	note __, 1
	octave 3
	note A_, 1
	note __, 2
	note G#, 1
	note __, 1
	note G_, 1
	note __, 1
	note F_, 2
	note D_, 1
	note F_, 1
	note G_, 1
	endchannel

Music_Megalovania_Ch1Ch3_ditty_2:
	octave 2
	note D_, 1
	note D_, 1
	note D_, 2
	note D_, 1
	note D_, 2
	note D_, 2
	note D_, 2
	note D_, 1
	note D_, 1
	note D_, 1
	octave 3
	note D_, 1
	note D_, 1
	octave 2
	note C_, 1
	note C_, 1
	note C_, 2
	note C_, 1
	note C_, 2
	note C_, 2
	note C_, 2
	note C_, 1
	note C_, 1
	note C_, 1
	octave 3
	note C_, 1
	note C_, 1
	octave 1
	note B_, 1
	note B_, 1
	note B_, 2
	note B_, 1
	note B_, 2
	note B_, 2
	note B_, 2
	note B_, 1
	note B_, 1
	note B_, 1
	octave 2
	note B_, 1
	note B_, 1
	octave 1
	note A#, 1
	note A#, 1
	note A#, 2
	note A#, 1
	note A#, 2
	octave 2
	note C_, 2
	note C_, 2
	note C_, 1
	note C_, 1
	note C_, 1
	endchannel

Music_Megalovania_Ch2:
	vibrato $00, $22
	notetype $C, $69
Music_Megalovania_Ch2_loop:
	octave 2
	note D_, 1
	note D_, 1
	callchannel Music_Megalovania_Ch2_ditty1
	note C_, 1
	note C_, 1
	callchannel Music_Megalovania_Ch2_ditty1
	octave 1
	note B_, 1
	note B_, 1
	callchannel Music_Megalovania_Ch2_ditty1
	octave 1
	note A#, 1
	note A#, 1
	callchannel Music_Megalovania_Ch2_ditty1
	loopchannel 2, Music_Megalovania_Ch2_loop
	note D_, 1
	note D_, 1
	callchannel Music_Megalovania_Ch2_ditty1
	note C_, 1
	note C_, 1
	callchannel Music_Megalovania_Ch2_ditty1
	octave 1
	note B_, 1
	note B_, 1
	callchannel Music_Megalovania_Ch2_ditty1
	octave 1
	note A#, 1
	note A#, 1
	octave 3
	note D_, 1
	note __, 1
	octave 2
	note A_, 1
	note __, 2
	note G#, 1
	note __, 1
	note G_, 1
	note __, 1
	note F_, 2
	note D_, 1
	note F_, 1
	sound_duty $AA
	vibrato $05, $13
	octave 4
	notetype $6, $D3
	note D_, 1
	note E_, 1
	note F_, 4
	note F_, 2
	note F_, 2
	note __, 2
	note F_, 2
	note __, 2
	note F_, 4
	note D_, 2
	note __, 2
	note D_, 8
	note __, 2
	note F_, 4
	note F_, 2
	note F_, 2
	note __, 2
	note G_, 2
	note __, 2
	note G#, 4
	note G_, 1
	note G#, 1
	note G_, 1
	note __, 1
	note D_, 2
	note F_, 2
	note G_, 2
	note __, 4
	note F_, 2
	note __, 2
	note F_, 2
	note F_, 2
	note __, 2
	note G_, 2
	note __, 2
	note G#, 2
	note __, 2
	note A_, 2
	note __, 2
	callchannel Music_Megalovania_Ch2_ditty2
	octave 4
	notetype $C, $D3
	note A_, 2
	note A_, 1
	note A_, 1
	note __, 1
	note A_, 1
	note __, 1
	note A_, 2
	note G_, 1
	note __, 1
	note G_, 4
	note __, 1
	note A_, 2
	note A_, 1
	note A_, 1
	note __, 1
	note G_, 1
	note __, 1
	note G#, 2
	notetype $6, $D3
	note G_, 1
	note G#, 1
	note G_, 1
	note __, 1
	note E_, 2
	note F_, 2
	note G_, 2
	note C_, 4
	note F_, 4
	note F_, 2
	note F_, 2
	note __, 2
	note D_, 2
	note C_, 2
	note D_, 2
	octave 5
	note C_, 2
	octave 4
	note A_, 2
	note G_, 2
	callchannel Music_Megalovania_Ch2_ditty2
	notetype $C, $D3
	note __, 8
	callchannel Music_Megalovania_Ch1Ch2_ditty_1
	note __, 16
	intensity $F1
	octave 3
	note F_, 2
	note D_, 2
	note F_, 2
	note G_, 2
	note G#, 2
	note G_, 2
	note F_, 2
	note D_, 2
	note G#, 1
	note G_, 1
	note E_, 1
	note C#, 1
	intensity $F3
	note F_, 4
	intensity $F4
	note G_, 16
	note __, 2
	intensity $F3
	note G#, 4
	intensity $F1
	note A_, 2
	octave 4
	note C_, 2
	note __, 2
	octave 3
	note A_, 2
	note G#, 2
	note G_, 2
	note F_, 2
	note D_, 2
	note E_, 2
	intensity $F3
	note F_, 4
	note G_, 4
	note A_, 4
	octave 4
	note C_, 4
	note C#, 4
	intensity $F1
	octave 3
	note G#, 2
	note __, 2
	note G#, 2
	note G_, 2
	note F_, 2
	intensity $F4
	note G_, 16
	note __, 2
	intensity $F3
	octave 2
	note A#, 2
	note __, 2
	octave 3
	callchannel Music_Megalovania_Ch1Ch2_ditty_1a
	callchannel Music_Megalovania_Ch2_ditty3
	sound_duty $5A
	vibrato $0F, $34
	octave 3
	notetype $6, $A1
	note D_, 1
	notetype $3, $A1
	note F_, 1
	note A_, 1
	sound_duty $55
	vibrato $0F, $1F
	octave 4
	notetype $9, $A7
	note D_, 16
	notetype $3, $A1
	note __, 12
	sound_duty $5A
	vibrato $0F, $34
	octave 3
	notetype $9, $A1
	note C_, 1
	notetype $3, $A1
	note F_, 1
	note A_, 1
	sound_duty $55
	vibrato $0F, $1F
	octave 4
	notetype $9, $A7
	note C_, 9
	octave 3
	notetype $C, $A7
	note B_, 8
	callchannel Music_Megalovania_Ch2_ditty3
	octave 5
	note D_, 12
	notetype $C, $A7
	note __, 1
	note C_, 15
	note __, 1
	octave 4
	note B_, 15
	note __, 16
	note __, 1
	notetype $C, $69
	sound_duty $00
	vibrato $00, $22
	octave 2
	note D_, 1
	note D_, 1
	callchannel Music_Megalovania_Ch2_ditty1
	note C_, 1
	note C_, 1
	callchannel Music_Megalovania_Ch2_ditty1
	octave 1
	note B_, 1
	note B_, 1
	callchannel Music_Megalovania_Ch2_ditty1
	octave 1
	note A#, 1
	note A#, 1
	callchannel Music_Megalovania_Ch2_ditty1
	note D_, 1
	note D_, 1
	callchannel Music_Megalovania_Ch2_ditty1
	note C_, 1
	note C_, 1
	callchannel Music_Megalovania_Ch2_ditty1
	octave 1
	note B_, 1
	note B_, 1
	callchannel Music_Megalovania_Ch2_ditty1
	octave 1
	note A#, 1
	note A#, 1
	callchannel Music_Megalovania_Ch2_ditty1
	note D_, 1
	note D_, 1
	callchannel Music_Megalovania_Ch2_ditty1
	note C_, 1
	note C_, 1
	callchannel Music_Megalovania_Ch2_ditty1
	octave 1
	note B_, 1
	note B_, 1
	callchannel Music_Megalovania_Ch2_ditty1
	octave 1
	note A#, 1
	note A#, 1
	callchannel Music_Megalovania_Ch2_ditty1
	loopchannel 0, Music_Megalovania_Ch2_loop

Music_Megalovania_Ch2_ditty1:
	octave 3
	note D_, 1
	note __, 1
	octave 2
	note A_, 1
	note __, 2
	note G#, 1
	note __, 1
	note G_, 1
	note __, 1
	note F_, 2
	note D_, 1
	note F_, 1
	note G_, 1
	endchannel

Music_Megalovania_Ch2_ditty2:
	octave 5
	note C_, 2
	note __, 2
	octave 4
	note A_, 6
	octave 5
	note D_, 2
	note __, 2
	note D_, 2
	note __, 2
	note D_, 2
	octave 4
	note A_, 2
	octave 5
	note D_, 2
	notetype $C, $D7
	note C_, 9
	endchannel

Music_Megalovania_Ch2_ditty3:
	sound_duty $5A
	vibrato $0F, $34
	octave 2
	notetype $9, $A1
	note A#, 1
	octave 3
	notetype $3, $A1
	note D_, 1
	note F_, 1
	sound_duty $55
	notetype $9, $A7
	vibrato $0F, $1F
	note A#, 16
	notetype $3, $A7
	note __, 11
	sound_duty $5A
	intensity $A1
	vibrato $0F, $34
	note C_, 2
	note E_, 1
	note G_, 1
	sound_duty $55
	vibrato $0F, $1F
	octave 4
	notetype $F, $A7
	note C_, 12
	sound_duty $5A
	vibrato $0F, $34
	octave 3
	notetype $9, $A1
	note D_, 1
	notetype $3, $A1
	note F_, 1
	note A_, 2
	sound_duty $55
	notetype $9, $A7
	vibrato $0F, $1F
	octave 4
	note D_, 16
	notetype $3, $A7
	note __, 10
	sound_duty $5A
	intensity $A1
	vibrato $0F, $34
	octave 3
	note D_, 4
	note F_, 1
	note A_, 1
	sound_duty $55
	vibrato $0F, $1F
	octave 4
	notetype $D, $A7
	note E_, 6
	notetype $C, $A7
	note D_, 8
	sound_duty $5A
	vibrato $0F, $34
	octave 2
	notetype $9, $A1
	note A#, 1
	octave 3
	notetype $3, $A1
	note D_, 1
	note F_, 1
	sound_duty $55
	notetype $9, $A7
	vibrato $0F, $1F
	note A#, 16
	notetype $3, $A7
	note __, 11
	sound_duty $5A
	intensity $A1
	vibrato $0F, $34
	note C_, 2
	note E_, 1
	note G_, 1
	sound_duty $55
	vibrato $0F, $1F
	octave 4
	notetype $F, $A7
	note C_, 12
	endchannel

Music_Megalovania_Ch3:
Music_Megalovania_Ch3_loop:
	dutycycle 9
	octave 3
	notetype $C, $19
	note D_, 1
	note D_, 1
	callchannel Music_Megalovania_Ch1Ch3_ditty_1
	note C_, 1
	note C_, 1
	callchannel Music_Megalovania_Ch1Ch3_ditty_1
	octave 2
	note B_, 1
	note B_, 1
	callchannel Music_Megalovania_Ch1Ch3_ditty_1
	octave 2
	note A#, 1
	note A#, 1
	callchannel Music_Megalovania_Ch1Ch3_ditty_1
	dutycycle 7
	intensity $17
	callchannel Music_Megalovania_Ch1Ch3_ditty_2
	callchannel Music_Megalovania_Ch3_ditty_1
	dutycycle 5
	intensity $35
	vibrato $07, $33
	octave 5
	note F_, 2
	note F_, 1
	note F_, 1
	note __, 1
	note F_, 1
	note __, 1
	note F_, 2
	note D_, 1
	note __, 1
	note D_, 4
	note __, 1
	note F_, 2
	note F_, 1
	note F_, 1
	note __, 1
	note G_, 1
	note __, 1
	note G#, 2
	notetype $6, $35
	note G_, 1
	note G#, 1
	note G_, 1
	note __, 1
	note D_, 2
	note F_, 2
	note G_, 2
	note __, 4
	note F_, 2
	note __, 2
	note F_, 2
	note F_, 2
	note __, 2
	note G_, 2
	note __, 2
	note G#, 2
	note __, 2
	note A_, 2
	note __, 2
	octave 6
	note C_, 2
	note __, 2
	octave 5
	note A_, 6
	octave 6
	note D_, 2
	note __, 2
	note D_, 2
	note __, 2
	note D_, 2
	octave 5
	note A_, 2
	octave 6
	note D_, 2
	note C_, 3
	note D_, 1
	notetype $3, $35
	note D#, 1
	note E_, 2
	notetype $3, $25
	note F_, 2
	note F#, 2
	notetype $9, $25
	note G_, 7
	dutycycle 7
	vibrato $00, $00
	octave 2
	notetype $C, $17
	callchannel Music_Megalovania_Ch3_ditty_2
	callchannel Music_Megalovania_Ch3_ditty_3
	callchannel Music_Megalovania_Ch3_ditty_3
	callchannel Music_Megalovania_Ch3_ditty_3
	callchannel Music_Megalovania_Ch3_ditty_3
	dutycycle 3
	intensity $23
	vibrato $07, $33
	octave 4
	note A#, 12
	octave 5
	note F_, 4
	note E_, 8
	note D_, 8
	note F_, 16
	note F_, 16
	octave 4
	note A#, 12
	octave 5
	note F_, 4
	note E_, 8
	note D_, 8
	note D_, 16
	note __, 16
	dutycycle 2
	intensity $32
	vibrato $03, $13
	note D_, 1
	note D_, 1
	callchannel Music_Megalovania_Ch3_ditty_4
	note C_, 1
	note C_, 1
	callchannel Music_Megalovania_Ch3_ditty_4
	intensity $22
	octave 4
	note B_, 1
	note B_, 1
	callchannel Music_Megalovania_Ch3_ditty_4
	octave 4
	note A#, 1
	note A#, 1
	callchannel Music_Megalovania_Ch3_ditty_4
	intensity $12
	note D_, 1
	note D_, 1
	callchannel Music_Megalovania_Ch3_ditty_4
	note C_, 1
	note C_, 1
	callchannel Music_Megalovania_Ch3_ditty_4
	note __, 2
	dutycycle 6
	intensity $36
	octave 6
	callchannel Music_Megalovania_Ch3_ditty_5
	intensity $26
	callchannel Music_Megalovania_Ch3_ditty_5
	intensity $16
	note A_, 1
	note __, 1
	note G_, 1
	note __, 2
	note E_, 1
	note __, 1
	note G_, 1
	note __, 1
	note F_, 1
	note __, 1
	note D_, 1
	note E_, 1
	note F_, 1
	note __, 16
	dutycycle 7
	intensity $17
	callchannel Music_Megalovania_Ch1Ch3_ditty_2
	callchannel Music_Megalovania_Ch3_ditty_1
	callchannel Music_Megalovania_Ch1Ch3_ditty_2
	note C_, 1
	note C_, 1
	loopchannel 0, Music_Megalovania_Ch3_loop

Music_Megalovania_Ch3_ditty_1:
	note C_, 1
	note C_, 1
Music_Megalovania_Ch3_ditty_2:
	note D_, 1
	note D_, 1
	note D_, 2
	note D_, 1
	note D_, 2
	note D_, 2
	note D_, 2
	note D_, 1
	note D_, 1
	note D_, 1
	octave 3
	note D_, 1
	note D_, 1
	octave 2
	note C_, 1
	note C_, 1
	note C_, 2
	note C_, 1
	note C_, 2
	note C_, 2
	note C_, 2
	note C_, 1
	note C_, 1
	note C_, 1
	octave 3
	note C_, 1
	note C_, 1
	octave 1
	note B_, 1
	note B_, 1
	note B_, 2
	note B_, 1
	note B_, 2
	note B_, 2
	note B_, 2
	note B_, 1
	note B_, 1
	note B_, 1
	octave 2
	note B_, 1
	note B_, 1
	octave 1
	note A#, 1
	note A#, 1
	note A#, 2
	note A#, 1
	note A#, 2
	octave 2
	note C_, 2
	note C_, 2
	note C_, 1
	note C_, 1
	note C_, 1
	octave 3
	note C_, 1
	note C_, 1
	endchannel

Music_Megalovania_Ch3_ditty_3:
	octave 1
	note A#, 1
	note A#, 1
	note A#, 2
	note A#, 1
	note A#, 2
	note A#, 2
	note A#, 2
	note A#, 1
	note A#, 1
	note A#, 1
	octave 2
	note A#, 1
	note A#, 1
	octave 1
	note A_, 1
	note A_, 1
	note A_, 2
	note A_, 1
	note A_, 2
	note A_, 2
	note A_, 2
	note A_, 1
	note A_, 1
	note A_, 1
	octave 2
	note A_, 1
	note A_, 1
	note D_, 1
	note D_, 1
	note D_, 2
	note D_, 1
	note D_, 2
	note D_, 2
	note D_, 2
	note D_, 1
	note D_, 1
	note D_, 1
	octave 3
	note D_, 1
	note D_, 1
	octave 1
	note B_, 1
	note B_, 1
	note B_, 2
	note B_, 1
	note B_, 2
	note B_, 2
	note B_, 2
	note B_, 1
	note B_, 1
	note B_, 1
	octave 2
	note B_, 1
	note B_, 1
	endchannel

Music_Megalovania_Ch3_ditty_4:
	octave 6
	note D_, 1
	note __, 1
	octave 5
	note A_, 1
	note __, 2
	note G#, 1
	note __, 1
	note G_, 1
	note __, 1
	note F_, 2
	note D_, 1
	note F_, 1
	note G_, 1
	endchannel

Music_Megalovania_Ch3_ditty_5:
	note F_, 1
	note __, 1
	note E_, 1
	note __, 2
	note C_, 1
	note __, 1
	note E_, 1
	note __, 1
	note D_, 1
	note __, 1
	octave 5
	note G_, 1
	note A_, 1
	octave 6
	note C_, 1
	note __, 2
	endchannel

Music_Megalovania_Ch4:
	notetype $C
	togglenoise 5
Music_Megalovania_Ch4_loop:
	note __, 16
	note __, 16
	note __, 16
	note __, 9
	noisesampleset 5
	note D#, 1
	note __, 1
	note D#, 1
	note __, 1
	note D#, 1
	note D#, 1
	note __, 1
	note F#, 1
Music_Megalovania_Ch4_loop1:
	callchannel Music_Megalovania_Ch4_ditty3
	loopchannel 3, Music_Megalovania_Ch4_loop1
	note E_, 1
	noisesampleset 0
	note A#, 1
	note __, 1
	noisesampleset 5
	note B_, 1
	note E_, 1
	noisesampleset 0
	note A#, 1
	noisesampleset 5
	note B_, 1
	note F#, 1
	note E_, 1
	noisesampleset 0
	note A#, 1
	noisesampleset 5
	note F#, 1
	note E_, 1
	noisesampleset 0
	note A#, 1
	noisesampleset 5
	note F#, 1
	noisesampleset 0
	note A#, 1
	noisesampleset 5
	note F#, 1
	note E_, 1
	noisesampleset 0
	note A#, 1
	note __, 1
	noisesampleset 5
	note B_, 1
	note E_, 1
	noisesampleset 0
	note A#, 1
Music_Megalovania_Ch4_loop2:
	callchannel Music_Megalovania_Ch4_ditty4
	note A#, 1
	note __, 1
	noisesampleset 5
	note B_, 1
	note E_, 1
	noisesampleset 0
	note A#, 1
	loopchannel 3, Music_Megalovania_Ch4_loop2
	noisesampleset 5
	note B_, 1
	note F#, 1
	note __, 1
	noisesampleset 0
	note A#, 1
	noisesampleset 5
	note F#, 1
	note __, 1
	noisesampleset 0
	note A#, 1
	noisesampleset 5
	note F#, 1
	noisesampleset 0
	note A#, 1
	noisesampleset 5
Music_Megalovania_Ch4_loop3:
	note B_, 1
	note E_, 1
	noisesampleset 0
	note A#, 1
	noisesampleset 5
	note F_, 1
	note B_, 1
	note E_, 1
	noisesampleset 0
	note A#, 1
	noisesampleset 5
	note F_, 1
	note B_, 1
	note E_, 1
	noisesampleset 0
	note A#, 1
	noisesampleset 5
	note B_, 1
	note E_, 1
	note B_, 1
	noisesampleset 0
	note A#, 1
	noisesampleset 5
	note F_, 1
	loopchannel 3, Music_Megalovania_Ch4_loop3
	note B_, 1
	note F_, 1
	noisesampleset 0
	note A#, 1
	note __, 1
	noisesampleset 5
	note B_, 1
	note F_, 1
	noisesampleset 0
	note A#, 1
	note __, 1
	noisesampleset 5
	note F#, 1
	note __, 1
	noisesampleset 0
	note A#, 1
	noisesampleset 5
	note F#, 1
	note __, 1
	note B_, 1
	note F#, 1
	note __, 1
	note F#, 1
	note E_, 1
	noisesampleset 0
Music_Megalovania_Ch4_loop4:
	note A#, 1
	note __, 1
	noisesampleset 5
	note B_, 1
	note E_, 1
	noisesampleset 0
	note A#, 1
	callchannel Music_Megalovania_Ch4_ditty4
	loopchannel 3, Music_Megalovania_Ch4_loop4
	note A#, 1
	note __, 1
	noisesampleset 5
	note B_, 1
	note E_, 1
	noisesampleset 0
	note A#, 1
	noisesampleset 5
	note B_, 1
	note F#, 1
	note E_, 1
	noisesampleset 0
	note A#, 1
	noisesampleset 5
	note F#, 1
	note E_, 1
	noisesampleset 0
	note A#, 1
	noisesampleset 5
	note F#, 1
	noisesampleset 0
	note A#, 1
	noisesampleset 5
	note F#, 1
Music_Megalovania_Ch4_loop5:
	note E_, 1
	noisesampleset 0
	note A#, 1
	note __, 1
	callchannel Music_Megalovania_Ch4_ditty2
	noisesampleset 5
	note B_, 1
	loopchannel 3, Music_Megalovania_Ch4_loop5
	note E_, 1
	noisesampleset 0
	note A#, 1
	note __, 1
	noisesampleset 5
	note B_, 1
	noisesampleset 0
	note F_, 1
	note A#, 1
	noisesampleset 5
	note B_, 1
	note F#, 1
	note __, 1
	noisesampleset 0
	note A#, 1
	noisesampleset 5
	note F#, 1
	note __, 1
	noisesampleset 0
	note A#, 1
	noisesampleset 5
	note F#, 1
	noisesampleset 0
	note A#, 1
	noisesampleset 5
	note F#, 1
Music_Megalovania_Ch4_loop6:
	note E_, 1
	noisesampleset 0
	note A#, 1
	note __, 1
	callchannel Music_Megalovania_Ch4_ditty2
	noisesampleset 5
	note B_, 1
	loopchannel 3, Music_Megalovania_Ch4_loop6
	note E_, 1
	noisesampleset 0
	note A#, 1
	note __, 1
	noisesampleset 5
	note B_, 1
	note E_, 1
	noisesampleset 0
	note A#, 1
	noisesampleset 5
	note B_, 1
	note F#, 1
	note __, 1
	noisesampleset 0
	note A#, 1
	noisesampleset 5
	note F#, 1
	note __, 1
	noisesampleset 0
	note A#, 1
	noisesampleset 5
	note F#, 1
	noisesampleset 0
	note A#, 1
	noisesampleset 5
	note F#, 1
	note E_, 1
Music_Megalovania_Ch4_loop7:
	noisesampleset 0
	note A#, 1
	note __, 1
	callchannel Music_Megalovania_Ch4_ditty2
	noisesampleset 5
	note B_, 1
	note E_, 1
	loopchannel 3, Music_Megalovania_Ch4_loop7
	noisesampleset 0
	note A#, 1
	note __, 1
	noisesampleset 5
	note B_, 1
	noisesampleset 0
	note F_, 1
	note A#, 1
	noisesampleset 5
	note B_, 1
	note F#, 1
	note __, 1
	noisesampleset 0
	note A#, 1
	noisesampleset 5
	note F#, 1
	note __, 1
	noisesampleset 0
	note A#, 1
	noisesampleset 5
	note F#, 1
	noisesampleset 0
	note A#, 1
	noisesampleset 5
	note F#, 1
	note E_, 1
Music_Megalovania_Ch4_loop8:
	noisesampleset 0
	note A#, 1
	note __, 1
	callchannel Music_Megalovania_Ch4_ditty2
	noisesampleset 5
	note B_, 1
	note E_, 1
	loopchannel 3, Music_Megalovania_Ch4_loop8
	noisesampleset 0
	note A#, 1
	note __, 1
	noisesampleset 5
	note B_, 1
	note E_, 1
	noisesampleset 0
	note A#, 1
	noisesampleset 5
	note B_, 1
	note F#, 1
	note __, 1
	noisesampleset 0
	note A#, 1
	noisesampleset 5
	note F#, 1
	note __, 1
	noisesampleset 0
	note A#, 1
	noisesampleset 5
	note F#, 1
	noisesampleset 0
	note A#, 1
	noisesampleset 2
	note D#, 1
	note __, 1
Music_Megalovania_Ch4_loop9:
	note D#, 1
	loopchannel 63, Music_Megalovania_Ch4_loop9
	noisesampleset 5
	note F#, 1
	noisesampleset 2
Music_Megalovania_Ch4_loop10:
	callchannel Music_Megalovania_Ch4_ditty1
	note G#, 1
	note __, 1
	note G#, 1
	note D#, 1
	note G#, 1
	note __, 1
	note G#, 1
	note G#, 1
	note D#, 1
	note G#, 1
	note G#, 1
	note G#, 1
	note G#, 1
	note D#, 1
	note G#, 1
	note D#, 1
	note G#, 1
	note __, 1
	note G#, 1
	note D#, 1
	note G#, 1
	note __, 1
	note G#, 1
	note G#, 1
	note D#, 1
	note G#, 1
	note G#, 1
	note G#, 1
	note G#, 1
	note D#, 1
	note G#, 1
	note D#, 1
	note A#, 1
	note __, 1
	loopchannel 2, Music_Megalovania_Ch4_loop10
	callchannel Music_Megalovania_Ch4_ditty1
	note __, 16
	note __, 16
	note __, 14
	noisesampleset 5
	note B_, 1
	note B_, 1
	note B_, 1
	note B_, 1
	noisesampleset 0
	note A#, 1
	note __, 1
	note A#, 1
	note A#, 1
	noisesampleset 5
	note B_, 1
	note F#, 1
	noisesampleset 7
	note B_, 1
	noisesampleset 5
	note F#, 1
	noisesampleset 7
	note B_, 1
	noisesampleset 5
	note F#, 1
	noisesampleset 2
	note D#, 1
	note G#, 1
	note A_, 1
	note A#, 1
	noisesampleset 5
	note F#, 1
Music_Megalovania_Ch4_loop11:
	callchannel Music_Megalovania_Ch4_ditty3
	loopchannel 3, Music_Megalovania_Ch4_loop11
	note E_, 1
	noisesampleset 0
	note A#, 1
	note __, 1
	noisesampleset 5
	note B_, 1
	note E_, 1
	noisesampleset 0
	note A#, 1
	noisesampleset 5
	note B_, 1
	note F#, 1
	note E_, 1
	noisesampleset 0
	note A#, 1
	noisesampleset 5
	note F#, 1
	note E_, 1
	noisesampleset 0
	note A#, 1
	noisesampleset 5
	note F#, 1
	noisesampleset 0
	note A#, 1
	noisesampleset 5
	note F#, 1
Music_Megalovania_Ch4_loop12:
	callchannel Music_Megalovania_Ch4_ditty3
	loopchannel 3, Music_Megalovania_Ch4_loop12
	note E_, 1
	noisesampleset 0
	note A#, 1
	note __, 1
	noisesampleset 5
	note B_, 1
	note E_, 1
	noisesampleset 0
	note A#, 1
	noisesampleset 5
	note B_, 1
	note F#, 1
	note __, 1
	noisesampleset 0
	note A#, 1
	noisesampleset 5
	note F#, 1
	note __, 1
	noisesampleset 0
	note A#, 1
	noisesampleset 5
	note F#, 1
	noisesampleset 0
	note A#, 1
	noisesampleset 5
	note F#, 1
	note E_, 1
	noisesampleset 0
	note A#, 1
	note __, 1
Music_Megalovania_Ch4_loop13:
	callchannel Music_Megalovania_Ch4_ditty2
	noisesampleset 5
	note B_, 1
	note E_, 1
	noisesampleset 0
	note A#, 1
	note __, 1
	loopchannel 3, Music_Megalovania_Ch4_loop13
	callchannel Music_Megalovania_Ch4_ditty2
	loopchannel 0, Music_Megalovania_Ch4_loop

Music_Megalovania_Ch4_ditty1:
	note A#, 1
	note D#, 1
	note A#, 1
	note __, 1
	note A#, 1
	note A#, 1
	note D#, 1
	note A#, 1
	note A#, 1
	note A#, 1
	note A#, 1
	note D#, 1
	note A#, 1
	note D#, 1
	note A_, 1
	note __, 1
	note A_, 1
	note D#, 1
	note A_, 1
	note __, 1
	note A_, 1
	note A_, 1
	note D#, 1
	note A_, 1
	note A_, 1
	note A_, 1
	note A_, 1
	note D#, 1
	note A_, 1
	note D#, 1
	endchannel

Music_Megalovania_Ch4_ditty2:
	noisesampleset 5
	note B_, 1
	note E_, 1
	noisesampleset 0
	note A#, 1
	note __, 1
	noisesampleset 5
	note B_, 1
	note E_, 1
	noisesampleset 0
	note A#, 1
	noisesampleset 5
	note B_, 1
	note E_, 1
	note B_, 1
	noisesampleset 0
	note A#, 1
	note __, 1
	endchannel

Music_Megalovania_Ch4_ditty3:
	note E_, 1
	noisesampleset 0
	note A#, 1
	note __, 1
	noisesampleset 5
	note B_, 1
	note E_, 1
	noisesampleset 0
	note A#, 1
	note F_, 1
	noisesampleset 5
	note B_, 1
	note E_, 1
	noisesampleset 0
	note A#, 1
	noisesampleset 5
	note B_, 1
	note E_, 1
	note B_, 1
	noisesampleset 0
	note A#, 1
	note __, 1
	noisesampleset 5
	note B_, 1
	endchannel

Music_Megalovania_Ch4_ditty4:
	note F_, 1
	noisesampleset 5
	note B_, 1
	note E_, 1
	noisesampleset 0
	note A#, 1
	noisesampleset 5
	note B_, 1
	note E_, 1
	note B_, 1
	noisesampleset 0
	note A#, 1
	note __, 1
	noisesampleset 5
	note B_, 1
	note E_, 1
	noisesampleset 0
	endchannel
