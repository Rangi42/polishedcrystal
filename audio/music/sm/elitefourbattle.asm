; Pokémon S/M - Battle! Elite Four
; Demixed by Mmmmmm
; https://pastebin.com/Q2MsZc9W
; https://hax.iimarckus.org/topic/6777/8/

Music_EliteFourBattleSM:
	channel_count 4
	channel 1, Music_EliteFourBattleSM_Ch1
	channel 2, Music_EliteFourBattleSM_Ch2
	channel 3, Music_EliteFourBattleSM_Ch3
	channel 4, Music_EliteFourBattleSM_Ch4

Music_EliteFourBattleSM_Ch1:
	tempo 184
	volume 7, 7
	duty_cycle 0
	tone $0002
	vibrato $12, $15
	note_type 6, 1, 2
	note __, 16
	note __, 16
	note __, 16
	callchannel Music_EliteFourBattleSM_Ch1_branch_1
	volume_envelope 2, 2
	callchannel Music_EliteFourBattleSM_Ch1_branch_1
	volume_envelope 3, 1
	callchannel Music_EliteFourBattleSM_Ch1_branch_1
	volume_envelope 4, 1
	callchannel Music_EliteFourBattleSM_Ch1_branch_1
	volume_envelope 5, 1
	callchannel Music_EliteFourBattleSM_Ch1_branch_1
	volume_envelope 6, 1
	callchannel Music_EliteFourBattleSM_Ch1_branch_1
	volume_envelope 7, 1
	callchannel Music_EliteFourBattleSM_Ch1_branch_1
	volume_envelope 8, 1
	callchannel Music_EliteFourBattleSM_Ch1_branch_1
	volume_envelope 9, 1
	callchannel Music_EliteFourBattleSM_Ch1_branch_1
Music_EliteFourBattleSM_Ch1_loop_main:
Music_EliteFourBattleSM_Ch1_loop_1:
	octave 2
	volume_envelope 11, 1
	note B_, 2
	note B_, 2
	note B_, 2
	note B_, 4
	volume_envelope 11, 4
	note B_, 4
	volume_envelope 11, 1
	note B_, 2
	octave 3
	note C_, 2
	note C_, 2
	note C_, 2
	note C_, 4
	volume_envelope 11, 4
	note C_, 4
	volume_envelope 11, 1
	note C_, 2
	note D_, 2
	note D_, 2
	note D_, 2
	note D_, 4
	volume_envelope 11, 4
	note D_, 4
	volume_envelope 11, 2
	note D_, 2
	note C_, 4
	octave 2
	volume_envelope 9, 1
	note F_, 2
	volume_envelope 9, 2
	note F_, 4
	note F_, 4
	volume_envelope 9, 1
	note F_, 1
	note F_, 1
	loopchannel 2, Music_EliteFourBattleSM_Ch1_loop_1
	note __, 16
	duty_cycle 2
	volume_envelope 8, 7
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
	volume_envelope 8, 0
	note E_, 8
	volume_envelope 8, 4
	note E_, 8
	note __, 16
	note __, 16
	note __, 16
	duty_cycle 0
Music_EliteFourBattleSM_Ch1_loop_2:
	volume_envelope 9, 2
	note B_, 4
	volume_envelope 9, 1
	note B_, 2
	volume_envelope 9, 2
	note B_, 4
	note B_, 4
	volume_envelope 9, 1
	note B_, 1
	note B_, 1
	loopchannel 4, Music_EliteFourBattleSM_Ch1_loop_2
	duty_cycle 1
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
	volume_envelope 10, 1
	note E_, 2
	octave 2
	note B_, 2
	octave 3
	note E_, 2
	note B_, 4
	note G_, 4
	note D#, 2
	volume_envelope 11, 1
	octave 4
	note E_, 2
	octave 3
	note B_, 2
	octave 4
	note E_, 2
	note A_, 2
	volume_envelope 12, 1
	note B_, 2
	note G_, 2
	octave 3
	note B_, 2
	octave 4
	note D#, 2
	volume_envelope 13, 1
	note E_, 2
	octave 3
	note B_, 2
	octave 4
	note E_, 2
	note A_, 2
	volume_envelope 14, 1
	note B_, 2
	note G_, 2
	octave 3
	note B_, 2
	octave 4
	note D#, 2
	duty_cycle 0
	volume_envelope 13, 2
	octave 3
	note __, 8
	note E_, 2
	note D#, 4
	note A#, 2
	volume_envelope 13, 7
	note A_, 12
	volume_envelope 6, -7
	note A_, 12
	volume_envelope 13, 2
	note E_, 2
	note D#, 4
	note A#, 2
	volume_envelope 13, 7
	note A_, 12
	volume_envelope 6, -7
	note A_, 12
	volume_envelope 13, 2
	note A#, 2
	note A_, 4
	octave 4
	note E_, 2
	volume_envelope 13, 6
	note D#, 12
	volume_envelope 6, -7
	note D#, 12
	volume_envelope 13, 2
	octave 3
	note A#, 2
	note A_, 4
	octave 4
	note E_, 2
	volume_envelope 13, 7
	note D#, 8
	volume_envelope 8, -6
	note D#, 8
	jumpchannel Music_EliteFourBattleSM_Ch1_loop_main

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
	duty_cycle 1
	vibrato $8, $36
	tone $0001
	note_type 6, 10, 2
	octave 3
	note F_, 4
	volume_envelope 10, 1
	note F_, 2
	volume_envelope 10, 2
	note F_, 4
	note F_, 4
	volume_envelope 10, 1
	note F_, 1
	note F_, 1
	loopchannel 3, Music_EliteFourBattleSM_Ch2
	note __, 16
Music_EliteFourBattleSM_Ch2_loop_1:
	volume_envelope 10, 2
	note G_, 4
	volume_envelope 10, 1
	note G_, 2
	volume_envelope 10, 2
	note G_, 4
	note G_, 4
	volume_envelope 10, 1
	note G_, 1
	note G_, 1
	loopchannel 3, Music_EliteFourBattleSM_Ch2_loop_1
	note __, 16
Music_EliteFourBattleSM_Ch2_loop_2:
	volume_envelope 10, 2
	note A_, 4
	volume_envelope 10, 1
	note A_, 2
	volume_envelope 10, 2
	note A_, 4
	note A_, 4
	volume_envelope 10, 1
	note A_, 1
	note A_, 1
	loopchannel 3, Music_EliteFourBattleSM_Ch2_loop_2
	note __, 16
Music_EliteFourBattleSM_Ch2_loop_main:
Music_EliteFourBattleSM_Ch2_loop_3:
	octave 4
	volume_envelope 12, 1
	note E_, 2
	note E_, 2
	note E_, 2
	note E_, 4
	volume_envelope 12, 4
	note E_, 4
	volume_envelope 12, 1
	note E_, 2
	note F_, 2
	note F_, 2
	note F_, 2
	note F_, 4
	volume_envelope 12, 4
	note F_, 4
	volume_envelope 12, 1
	note F_, 2
	note G_, 2
	note G_, 2
	note G_, 2
	note G_, 4
	volume_envelope 12, 4
	note G_, 4
	volume_envelope 12, 2
	note G_, 2
	volume_envelope 12, 1
	note F_, 16
	loopchannel 2, Music_EliteFourBattleSM_Ch2_loop_3
	volume_envelope 11, 7
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
	volume_envelope 11, 0
	note E_, 8
	volume_envelope 11, 4
	note E_, 8
	duty_cycle 0
	octave 2
Music_EliteFourBattleSM_Ch2_loop_4:
	duty_cycle 0
	volume_envelope 9, 2
	note B_, 4
	volume_envelope 9, 1
	note B_, 2
	volume_envelope 9, 2
	note B_, 4
	note B_, 4
	volume_envelope 9, 1
	note B_, 1
	note B_, 1
	loopchannel 3, Music_EliteFourBattleSM_Ch2_loop_4
	duty_cycle 2
	volume_envelope 8, 0
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
	volume_envelope 9, 0
	note A_, 16
	volume_envelope 10, 0
	note B_, 16
	note B_, 16
	note B_, 16
	volume_envelope 14, 2
	duty_cycle 1
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
	jumpchannel Music_EliteFourBattleSM_Ch2_loop_main

Music_EliteFourBattleSM_Ch3:
	octave 2
	callchannel Music_EliteFourBattleSM_Ch3_branch_1
	callchannel Music_EliteFourBattleSM_Ch3_branch_1
	callchannel Music_EliteFourBattleSM_Ch3_branch_1
Music_EliteFourBattleSM_Ch3_loop_main:
Music_EliteFourBattleSM_Ch3_loop_1:
	note_type 6, 1, -1
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
	jumpchannel Music_EliteFourBattleSM_Ch3_loop_main

Music_EliteFourBattleSM_Ch3_branch_1:
	note_type 3, 1, -1
	note E_, 3
	note __, 1
	volume_envelope 2, -1
	note E_, 3
	note __, 1
	note E_, 3
	note __, 1
	loopchannel 8, Music_EliteFourBattleSM_Ch3_branch_1
	volume_envelope 1, -1
	note F_, 4
	note __, 12
	note __, 16
	endchannel

Music_EliteFourBattleSM_Ch4:
	toggle_noise 3
	note_type 12
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
	note_type 6
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
	jumpchannel Music_EliteFourBattleSM_Ch4_loop_main
