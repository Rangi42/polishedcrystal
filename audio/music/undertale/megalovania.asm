; Undertale - Megalovania
; Demixed by Shockslayer

Music_Megalovania:
	channel_count 4
	channel 1, Music_Megalovania_Ch1
	channel 2, Music_Megalovania_Ch2
	channel 3, Music_Megalovania_Ch3
	channel 4, Music_Megalovania_Ch4

Music_Megalovania_Ch1:
	tempo $A0
	volume 7, 7
	stereopanning $77
Music_Megalovania_Ch1_loop:
	note_type 12, 0, 0
	note __, 16
	note __, 16
	note __, 16
	note __, 16
	duty_cycle_pattern 1, 1, 1, 1
	volume_envelope 15, 3
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
	duty_cycle_pattern 0, 0, 0, 0
	volume_envelope 9, 1
	callchannel Music_Megalovania_Ch1Ch3_ditty_2
	octave 3
	note C_, 1
	note C_, 1
	volume_envelope 8, -5
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
	volume_envelope 6, -5
	vibrato $0F, $13
	octave 5
	note C_, 8
	note __, 1
	duty_cycle_pattern 1, 1, 2, 2
	volume_envelope 15, 3
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
	duty_cycle_pattern 1, 1, 1, 1
	volume_envelope 10, 3
	octave 2
	note A_, 4
	octave 3
	note F_, 4
	note E_, 4
	volume_envelope 10, 1
	octave 2
	note G_, 2
	volume_envelope 10, 6
	note A_, 16
	note __, 2
	volume_envelope 10, 1
	note A_, 2
	note __, 2
	volume_envelope 10, 3
	octave 3
	note G_, 4
	note F_, 4
	volume_envelope 10, 1
	note E_, 2
	volume_envelope 10, 3
	note F_, 6
	note E_, 4
	note D_, 4
	note C_, 4
	note D_, 4
	note C_, 4
	octave 2
	note A_, 4
	volume_envelope 10, 1
	octave 3
	note C_, 2
	volume_envelope 10, 3
	note D_, 6
	note C_, 4
	octave 2
	note A_, 4
	volume_envelope 10, 1
	octave 3
	note C_, 2
	volume_envelope 10, 3
	octave 2
	note A_, 6
	volume_envelope 10, 1
	note G_, 2
	note __, 2
	note A_, 2
	note __, 2
	octave 3
	note C_, 2
	volume_envelope 10, 4
	octave 2
	note A_, 10
	volume_envelope 10, 3
	note G_, 6
	note __, 2
	note A_, 4
	octave 3
	note F_, 4
	note E_, 4
	volume_envelope 10, 1
	octave 2
	note G_, 2
	volume_envelope 10, 5
	note A_, 14
	note __, 4
	volume_envelope 10, 1
	note A_, 2
	note __, 2
	volume_envelope 10, 3
	octave 3
	note G_, 4
	note F_, 4
	volume_envelope 10, 1
	note E_, 2
	volume_envelope 10, 3
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
	volume_envelope 10, 1
	octave 3
	note C_, 2
	note __, 1
	note C_, 1
	note_type 9, 10, 5
	note D_, 9
	note_type 3, 10, 1
	note A_, 1
	note A#, 1
	note B_, 1
	octave 4
	note C_, 1
	note C#, 1
	note_type 12, 10, 6
	note D_, 8
	duty_cycle_pattern 0, 0, 0, 0
	vibrato $00, $13
	callchannel Music_Megalovania_Ch1_ditty_5
	volume_envelope 3, -7
	note F_, 4
	volume_envelope 8, 8
	note F_, 12
	volume_envelope 8, 7
	note F_, 12
	note __, 4
	callchannel Music_Megalovania_Ch1_ditty_5
	duty_cycle_pattern 1, 1, 1, 1
	volume_envelope 10, 1
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
	volume_envelope 15, 2
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
	note_type 10, 15, 1
	note D_, 1
	note_type 6, 15, 1
	note __, 1
	note_type 10, 15, 1
	note D_, 1
	note_type 6, 15, 1
	note __, 1
	note_type 10, 15, 1
	note D_, 1
	note_type 6, 15, 1
	note __, 1
	volume_envelope 15, 2
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
	volume_envelope 15, 1
	octave 4
Music_Megalovania_Ch1_loop3:
	note D_, 1
	note D#, 1
	loopchannel 4, Music_Megalovania_Ch1_loop3
	volume_envelope 15, 2
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
	jumpchannel Music_Megalovania_Ch1_loop

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
	volume_envelope 3, -7
	octave 1
	note A#, 4
	volume_envelope 8, 8
	note A#, 8
	volume_envelope 3, -7
	octave 2
	note F_, 4
	note E_, 4
	volume_envelope 8, 8
	note E_, 4
	volume_envelope 3, -7
	note D_, 4
	volume_envelope 8, 8
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
	duty_cycle_pattern 0, 0, 0, 0
	volume_envelope 15, 1
	octave 4
	note F_, 1
	note D_, 1
	note F_, 1
	note G_, 1
	note G#, 1
	note G_, 1
	note F_, 1
	note D_, 1
	note_type 6, 15, 1
	note G#, 1
	note G_, 1
	note E_, 1
	note C#, 1
	volume_envelope 15, 3
	note F_, 4
	volume_envelope 15, 4
	note G_, 16
	note __, 2
	volume_envelope 15, 3
	note G#, 4
	volume_envelope 15, 1
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
	volume_envelope 15, 3
	note F_, 4
	note G_, 4
	note A_, 4
	octave 5
	note C_, 4
	note C#, 4
	volume_envelope 15, 1
	octave 4
	note G#, 2
	note __, 2
	note G#, 2
	note G_, 2
	note F_, 2
	volume_envelope 15, 4
	note G_, 16
	note __, 2
	volume_envelope 15, 3
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
	volume_envelope 15, 4
	note A_, 16
	volume_envelope 15, 1
	note A_, 2
	note G#, 2
	note G_, 2
	note F#, 2
	note F_, 2
	note E_, 2
	note D#, 2
	note D_, 2
	volume_envelope 15, 4
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
	note_type 12, 6, -1
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
	duty_cycle_pattern 2, 2, 2, 2
	vibrato $05, $13
	octave 4
	note_type 6, 13, 3
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
	note_type 12, 13, 3
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
	note_type 6, 13, 3
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
	note_type 12, 13, 3
	note __, 8
	callchannel Music_Megalovania_Ch1Ch2_ditty_1
	note __, 16
	volume_envelope 15, 1
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
	volume_envelope 15, 3
	note F_, 4
	volume_envelope 15, 4
	note G_, 16
	note __, 2
	volume_envelope 15, 3
	note G#, 4
	volume_envelope 15, 1
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
	volume_envelope 15, 3
	note F_, 4
	note G_, 4
	note A_, 4
	octave 4
	note C_, 4
	note C#, 4
	volume_envelope 15, 1
	octave 3
	note G#, 2
	note __, 2
	note G#, 2
	note G_, 2
	note F_, 2
	volume_envelope 15, 4
	note G_, 16
	note __, 2
	volume_envelope 15, 3
	octave 2
	note A#, 2
	note __, 2
	octave 3
	callchannel Music_Megalovania_Ch1Ch2_ditty_1a
	callchannel Music_Megalovania_Ch2_ditty3
	duty_cycle_pattern 1, 1, 2, 2
	vibrato $0F, $34
	octave 3
	note_type 6, 10, 1
	note D_, 1
	note_type 3, 10, 1
	note F_, 1
	note A_, 1
	duty_cycle_pattern 1, 1, 1, 1
	vibrato $0F, $1F
	octave 4
	note_type 9, 10, 7
	note D_, 16
	note_type 3, 10, 1
	note __, 12
	duty_cycle_pattern 1, 1, 2, 2
	vibrato $0F, $34
	octave 3
	note_type 9, 10, 1
	note C_, 1
	note_type 3, 10, 1
	note F_, 1
	note A_, 1
	duty_cycle_pattern 1, 1, 1, 1
	vibrato $0F, $1F
	octave 4
	note_type 9, 10, 7
	note C_, 9
	octave 3
	note_type 12, 10, 7
	note B_, 8
	callchannel Music_Megalovania_Ch2_ditty3
	octave 5
	note D_, 12
	note_type 12, 10, 7
	note __, 1
	note C_, 15
	note __, 1
	octave 4
	note B_, 15
	note __, 16
	note __, 1
	note_type 12, 6, -1
	duty_cycle_pattern 0, 0, 0, 0
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
	jumpchannel Music_Megalovania_Ch2_loop

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
	note_type 12, 13, 7
	note C_, 9
	endchannel

Music_Megalovania_Ch2_ditty3:
	duty_cycle_pattern 1, 1, 2, 2
	vibrato $0F, $34
	octave 2
	note_type 9, 10, 1
	note A#, 1
	octave 3
	note_type 3, 10, 1
	note D_, 1
	note F_, 1
	duty_cycle_pattern 1, 1, 1, 1
	note_type 9, 10, 7
	vibrato $0F, $1F
	note A#, 16
	note_type 3, 10, 7
	note __, 11
	duty_cycle_pattern 1, 1, 2, 2
	volume_envelope 10, 1
	vibrato $0F, $34
	note C_, 2
	note E_, 1
	note G_, 1
	duty_cycle_pattern 1, 1, 1, 1
	vibrato $0F, $1F
	octave 4
	note_type 15, 10, 7
	note C_, 12
	duty_cycle_pattern 1, 1, 2, 2
	vibrato $0F, $34
	octave 3
	note_type 9, 10, 1
	note D_, 1
	note_type 3, 10, 1
	note F_, 1
	note A_, 2
	duty_cycle_pattern 1, 1, 1, 1
	note_type 9, 10, 7
	vibrato $0F, $1F
	octave 4
	note D_, 16
	note_type 3, 10, 7
	note __, 10
	duty_cycle_pattern 1, 1, 2, 2
	volume_envelope 10, 1
	vibrato $0F, $34
	octave 3
	note D_, 4
	note F_, 1
	note A_, 1
	duty_cycle_pattern 1, 1, 1, 1
	vibrato $0F, $1F
	octave 4
	note_type 13, 10, 7
	note E_, 6
	note_type 12, 10, 7
	note D_, 8
	duty_cycle_pattern 1, 1, 2, 2
	vibrato $0F, $34
	octave 2
	note_type 9, 10, 1
	note A#, 1
	octave 3
	note_type 3, 10, 1
	note D_, 1
	note F_, 1
	duty_cycle_pattern 1, 1, 1, 1
	note_type 9, 10, 7
	vibrato $0F, $1F
	note A#, 16
	note_type 3, 10, 7
	note __, 11
	duty_cycle_pattern 1, 1, 2, 2
	volume_envelope 10, 1
	vibrato $0F, $34
	note C_, 2
	note E_, 1
	note G_, 1
	duty_cycle_pattern 1, 1, 1, 1
	vibrato $0F, $1F
	octave 4
	note_type 15, 10, 7
	note C_, 12
	endchannel

Music_Megalovania_Ch3:
Music_Megalovania_Ch3_loop:
	duty_cycle 9
	octave 3
	note_type 12, 1, -1
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
	duty_cycle 7
	volume_envelope 1, 7
	callchannel Music_Megalovania_Ch1Ch3_ditty_2
	callchannel Music_Megalovania_Ch3_ditty_1
	duty_cycle 5
	volume_envelope 3, 5
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
	note_type 6, 3, 5
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
	note_type 3, 3, 5
	note D#, 1
	note E_, 2
	note_type 3, 2, 5
	note F_, 2
	note F#, 2
	note_type 9, 2, 5
	note G_, 7
	duty_cycle 7
	vibrato $00, $00
	octave 2
	note_type 12, 1, 7
	callchannel Music_Megalovania_Ch3_ditty_2
	callchannel Music_Megalovania_Ch3_ditty_3
	callchannel Music_Megalovania_Ch3_ditty_3
	callchannel Music_Megalovania_Ch3_ditty_3
	callchannel Music_Megalovania_Ch3_ditty_3
	duty_cycle 3
	volume_envelope 2, 3
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
	duty_cycle 2
	volume_envelope 3, 2
	vibrato $03, $13
	note D_, 1
	note D_, 1
	callchannel Music_Megalovania_Ch3_ditty_4
	note C_, 1
	note C_, 1
	callchannel Music_Megalovania_Ch3_ditty_4
	volume_envelope 2, 2
	octave 4
	note B_, 1
	note B_, 1
	callchannel Music_Megalovania_Ch3_ditty_4
	octave 4
	note A#, 1
	note A#, 1
	callchannel Music_Megalovania_Ch3_ditty_4
	volume_envelope 1, 2
	note D_, 1
	note D_, 1
	callchannel Music_Megalovania_Ch3_ditty_4
	note C_, 1
	note C_, 1
	callchannel Music_Megalovania_Ch3_ditty_4
	note __, 2
	duty_cycle 6
	volume_envelope 3, 6
	octave 6
	callchannel Music_Megalovania_Ch3_ditty_5
	volume_envelope 2, 6
	callchannel Music_Megalovania_Ch3_ditty_5
	volume_envelope 1, 6
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
	duty_cycle 7
	volume_envelope 1, 7
	callchannel Music_Megalovania_Ch1Ch3_ditty_2
	callchannel Music_Megalovania_Ch3_ditty_1
	callchannel Music_Megalovania_Ch1Ch3_ditty_2
	note C_, 1
	note C_, 1
	jumpchannel Music_Megalovania_Ch3_loop

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
	note_type 12
	toggle_noise 5
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
	jumpchannel Music_Megalovania_Ch4_loop

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
