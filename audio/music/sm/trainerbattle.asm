; Pokémon S/M - Battle! Trainer
; Demixed by Mmmmmm
; https://pastebin.com/jFntMups
; https://hax.iimarckus.org/topic/6777/7/

Music_TrainerBattleSM:
	channel_count 4
	channel 1, Music_TrainerBattleSM_Ch1
	channel 2, Music_TrainerBattleSM_Ch2
	channel 3, Music_TrainerBattleSM_Ch3
	channel 4, Music_TrainerBattleSM_Ch4

Music_TrainerBattleSM_Ch1:
	tempo 204
	volume 7, 7
	duty_cycle 2
	tone $0002
	vibrato $12, $15
	note_type 6, 6, 0
	octave 2
	note A#, 8
	note E_, 8
	octave 3
	note G_, 8
	volume_envelope 6, -7
	note G_, 8
Music_TrainerBattleSM_Ch1_loop_main:
	duty_cycle 0
	volume_envelope 6, 0
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
	volume_envelope 9, 7
	note A#, 6
	volume_envelope 9, 2
	note A#, 4
	note A#, 2
	octave 3
	note C_, 2
	note D_, 2
	volume_envelope 9, 3
	note F_, 6
	note E_, 6
	note D_, 4
	volume_envelope 9, 7
	note C_, 6
	volume_envelope 9, 2
	note C_, 4
	note C_, 2
	note D_, 2
	note E_, 2
	volume_envelope 9, 3
	note G_, 6
	note F_, 6
	note E_, 4
	loopchannel 2, Music_TrainerBattleSM_Ch1_loop_1
	octave 4
	volume_envelope 6, 0
	note C_, 6
	note F_, 8
	note E_, 2
	note D#, 2
	volume_envelope 6, 4
	note E_, 4
	volume_envelope 6, 0
	note G_, 6
	volume_envelope 6, 7
	note G_, 4
	octave 5
	note C_, 6
	note C_, 6
	volume_envelope 6, 5
	note C_, 4
	note __, 6
	volume_envelope 6, 0
	note C_, 6
	volume_envelope 6, 4
	note C_, 4
	volume_envelope 9, 7
	octave 3
	note F_, 8
	note E_, 8
	volume_envelope 9, 2
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
	volume_envelope 10, 0
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
	volume_envelope 10, 2
	note C_, 4
	volume_envelope 10, 7
	note F_, 4
	octave 2
	volume_envelope 10, 2
	note A#, 4
	octave 3
	volume_envelope 10, 7
	note E_, 4
	octave 2
	volume_envelope 10, 2
	note A_, 2
	octave 3
	note C_, 4
	octave 2
	volume_envelope 10, 3
	note A#, 6
	note __, 4
	volume_envelope 10, 7
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
	volume_envelope 9, 0
	octave 2
	note B_, 2
	octave 3
	note C_, 10
	vibrato $0, $0
	pitch_sweep 6, -3
	note C_, 4
	pitch_sweep 0, 0
	vibrato $12, $15
	duty_cycle 1
	note_type 12, 10, 3
Music_TrainerBattleSM_Ch1_loop_2:
	note C_, 11
	note C_, 5
	note C_, 16
	loopchannel 5, Music_TrainerBattleSM_Ch1_loop_2
	note_type 6, 10, 1
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
	jumpchannel Music_TrainerBattleSM_Ch1_loop_main

Music_TrainerBattleSM_Ch2:
	duty_cycle 3
	vibrato $8, $36
	tone $0001
	note_type 6, 12, 2
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
	volume_envelope 11, 2
	note D_, 1
	octave 4
	note A#, 1
	octave 5
	volume_envelope 9, 2
	note A#, 1
	volume_envelope 8, 2
	note F_, 1
	volume_envelope 7, 2
	note D_, 1
Music_TrainerBattleSM_Ch2_loop_main:
	duty_cycle 3
	octave 4
	volume_envelope 10, 0
	note C_, 6
	note F_, 6
	volume_envelope 10, 7
	note F_, 2
	note E_, 2
	volume_envelope 10, 0
	note G_, 6
	volume_envelope 10, 7
	note G_, 6
	note G_, 2
	note A_, 2
	volume_envelope 10, 0
	note A#, 6
	note A_, 6
	note F_, 4
	note G_, 8
	volume_envelope 10, 5
	note G_, 8
	duty_cycle 2
	callchannel Music_TrainerBattleSM_Ch2_branch_2
	volume_envelope 10, 7
	note G_, 10
	duty_cycle 3
	octave 4
	volume_envelope 10, 0
	note C_, 6
	note F_, 6
	volume_envelope 10, 7
	note F_, 2
	note E_, 2
	volume_envelope 10, 0
	note G_, 6
	volume_envelope 10, 7
	note G_, 6
	note G_, 2
	note A_, 2
	volume_envelope 10, 0
	note A#, 4
	volume_envelope 10, 4
	note A#, 2
	volume_envelope 10, 0
	note A_, 4
	volume_envelope 10, 4
	note A_, 2
	note F_, 4
	note D#, 2
	volume_envelope 10, 2
	note E_, 4
	volume_envelope 10, 0
	note G_, 2
	volume_envelope 10, 6
	note G_, 8
	duty_cycle 2
	note F_, 8
	note E_, 8
	volume_envelope 10, 3
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
	volume_envelope 10, 0
	note C_, 12
	volume_envelope 10, 7
	note C_, 16
	note __, 4
	volume_envelope 10, 0
	note E_, 4
	volume_envelope 10, 7
	note E_, 12
	volume_envelope 10, 0
	note G_, 4
	volume_envelope 10, 7
	note G_, 12
	duty_cycle 3
	octave 4
	volume_envelope 10, 2
	note F_, 4
	volume_envelope 10, 7
	note A#, 4
	volume_envelope 10, 2
	note E_, 4
	volume_envelope 10, 7
	note A_, 4
	volume_envelope 10, 2
	note D_, 2
	volume_envelope 10, 7
	note G_, 4
	volume_envelope 10, 3
	note F_, 6
	volume_envelope 8, 1
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
	duty_cycle 2
	volume_envelope 9, 0
	note C_, 8
	volume_envelope 9, 7
	note C_, 16
	note F_, 8
	volume_envelope 9, 0
	note G_, 8
	volume_envelope 9, 7
	note G_, 8
	volume_envelope 9, 0
	note F_, 2
	note G_, 6
	volume_envelope 9, 7
	note G_, 8
	duty_cycle 0
	vibrato $12, $54
	volume_envelope 12, 0
	note F_, 8
	volume_envelope 12, 7
	note F_, 16
	note C_, 8
	volume_envelope 12, 0
	note D#, 16
	volume_envelope 12, 7
	note D#, 16
	volume_envelope 12, 0
	note F_, 8
	volume_envelope 12, 7
	note F_, 8
	volume_envelope 12, 0
	note G#, 8
	volume_envelope 12, 7
	note G#, 8
	volume_envelope 12, 0
	note G_, 8
	volume_envelope 12, 7
	note G_, 8
	volume_envelope 12, 0
	octave 4
	note C#, 8
	volume_envelope 12, 7
	note C#, 16
	octave 3
	note __, 8
	note F_, 8
	note C_, 8
	volume_envelope 12, 0
	note D#, 16
	volume_envelope 12, 7
	note D#, 16
	note __, 16
	note F_, 6
	note G#, 6
	note G_, 4
	volume_envelope 12, 0
	note D#, 16
	volume_envelope 12, 7
	note D#, 16
	duty_cycle 2
	octave 2
	volume_envelope 9, 7
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
	volume_envelope 10, 7
	note C#, 2
	note D_, 2
	note D#, 2
	note E_, 2
	note F_, 2
	note F#, 2
	note G_, 2
	note G#, 2
	volume_envelope 11, 7
	note F_, 2
	note F#, 2
	note G_, 2
	note G#, 2
	note A_, 2
	note A#, 2
	note B_, 2
	octave 4
	note C_, 2
	volume_envelope 12, 7
	note C#, 2
	note D_, 2
	note D#, 2
	note E_, 2
	volume_envelope 13, 7
	note F_, 2
	note F#, 2
	note G_, 2
	note G#, 2
	volume_envelope 10, 5
	callchannel Music_TrainerBattleSM_Ch2_branch_2
	volume_envelope 10, 7
	note G_, 10
	jumpchannel Music_TrainerBattleSM_Ch2_loop_main

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
	note_type 6, 1, -1
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
	volume_envelope 1, -1
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
	jumpchannel Music_TrainerBattleSM_Ch3_loop_main

Music_TrainerBattleSM_Ch4:
	toggle_noise 3
	note_type 6
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
	jumpchannel Music_TrainerBattleSM_Ch4_loop_main
