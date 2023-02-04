; Pokémon X/Y - Battle! Rival
; Demixed by Mmmmmm
; https://pastebin.com/KvYS4SPR
; https://hax.iimarckus.org/topic/6777/3/

Music_RivalBattleXY:
	channel_count 4
	channel 1, Music_RivalBattleXY_Ch1
	channel 2, Music_RivalBattleXY_Ch2
	channel 3, Music_RivalBattleXY_Ch3
	channel 4, Music_RivalBattleXY_Ch4

Music_RivalBattleXY_Ch1:
	tempo 116
	volume 7, 7
	duty_cycle 3
	pitch_offset 2
	vibrato $8, $15
	note_type 12, 12, 2
	octave 4
	note C_, 1
	octave 3
	note B_, 1
	note A#, 1
	note A_, 1
	note A#, 1
	note A_, 1
	note G#, 1
	note G_, 1
	note G#, 1
	note G_, 1
	note F#, 1
	note F_, 1
	note E_, 1
	note F#, 1
	note G#, 1
	note A#, 1
	volume_envelope 10, 3
	callchannel Music_RivalBattleXY_Ch1_branch_1
	callchannel Music_RivalBattleXY_Ch1_branch_1
Music_RivalBattleXY_Ch1_loop_main:
	octave 3
	duty_cycle 3
	volume_envelope 10, 3
	callchannel Music_RivalBattleXY_Ch1_branch_1
	volume_envelope 10, 0
	note D#, 16
	volume_envelope 10, 7
	note D#, 16
	volume_envelope 10, 3
	callchannel Music_RivalBattleXY_Ch1_branch_1
	volume_envelope 10, 0
	note D#, 16
	volume_envelope 10, 7
	note D#, 16
	duty_cycle 2
Music_RivalBattleXY_Ch1_loop_1:
	octave 4
	volume_envelope 8, 2
	note F_, 2
	callchannel Music_RivalBattleXY_Ch1_branch_2
	note F_, 2
	callchannel Music_RivalBattleXY_Ch1_branch_2
	note G#, 2
	callchannel Music_RivalBattleXY_Ch1_branch_2
	note F_, 2
	callchannel Music_RivalBattleXY_Ch1_branch_2
	note G_, 2
	callchannel Music_RivalBattleXY_Ch1_branch_3
	note G_, 2
	callchannel Music_RivalBattleXY_Ch1_branch_3
	note A#, 2
	callchannel Music_RivalBattleXY_Ch1_branch_3
	note G_, 2
	callchannel Music_RivalBattleXY_Ch1_branch_3
	loopchannel 2, Music_RivalBattleXY_Ch1_loop_1
	volume_envelope 10, 3
	duty_cycle 1
	octave 3
	note F_, 6
	note C#, 6
	note F_, 6
	note C#, 6
	note F_, 4
	volume_envelope 10, 5
	note G#, 4
	volume_envelope 10, 3
	note G_, 6
	note D#, 6
	note G_, 6
	note D#, 6
	note A#, 4
	volume_envelope 10, 5
	note G_, 4
	volume_envelope 10, 3
	note G#, 6
	note F_, 6
	note G#, 6
	note F_, 6
	note G#, 4
	volume_envelope 10, 5
	octave 4
	note C#, 4
	volume_envelope 10, 3
	octave 3
	note A#, 6
	note G_, 6
	note A#, 6
	note G_, 6
	note A#, 4
	note G_, 1
	note G#, 1
	note A#, 1
	note B_, 1
	note __, 16
	note __, 16
	note __, 16
	note __, 12
	volume_envelope 9, 3
	octave 4
	note G_, 1
	note G#, 1
	note A#, 1
	note B_, 1
	octave 5
	note C_, 2
	note C_, 4
	note C_, 4
	note C_, 4
	note C_, 2
	octave 4
	volume_envelope 9, 7
	note A#, 4
	note B_, 4
	octave 5
	volume_envelope 9, 3
	note C_, 4
	octave 4
	note G_, 4
	note A#, 6
	note A_, 4
	note F_, 4
	note F_, 2
	note A#, 4
	octave 5
	volume_envelope 9, 7
	note D_, 4
	volume_envelope 9, 3
	note C_, 8
	octave 4
	volume_envelope 10, 3
	duty_cycle 2
	note E_, 8
	note C_, 8
	note E_, 6
	note A_, 10
	note G_, 8
	note E_, 2
	note G_, 4
	note C_, 10
	note __, 8
	jumpchannel Music_RivalBattleXY_Ch1_loop_main

Music_RivalBattleXY_Ch1_branch_1:
	note G_, 6
	note C_, 4
	note G_, 6
	note F_, 4
	note E_, 4
	note F_, 4
	note G_, 4
	endchannel

Music_RivalBattleXY_Ch1_branch_2:
	note C#, 2
	note D#, 2
	note C#, 2
	endchannel

Music_RivalBattleXY_Ch1_branch_3:
	note D#, 2
	note F_, 2
	note D#, 2
	endchannel

Music_RivalBattleXY_Ch2:
	duty_cycle 3
	vibrato $8, $36
	pitch_offset 1
	note_type 12, 11, 2
	octave 4
	note G_, 2
	note A#, 4
	volume_envelope 11, 7
	note A#, 6
	note B_, 4
	volume_envelope 11, 4
	octave 5
	note C_, 4
	note __, 12
	note __, 16
	note __, 16
	note __, 16
Music_RivalBattleXY_Ch2_loop:
	duty_cycle 0
	callchannel Music_RivalBattleXY_Ch2_branch_1
	note F_, 4
	note D#, 4
	note D_, 4
	octave 3
	note A#, 4
	callchannel Music_RivalBattleXY_Ch2_branch_1
	note F_, 4
	note D#, 4
	note F_, 4
	note G_, 4
	octave 3
	volume_envelope 13, 0
	note F_, 16
	note C#, 8
	note F_, 8
	note D#, 16
	note G_, 8
	note D#, 8
	note F_, 15
	note_type 3, 13, 0
	note F#, 1
	note G_, 1
	note G#, 1
	note A_, 1
	note_type 12, 13, 0
	note A#, 7
	note A_, 1
	note G#, 8
	note G_, 16
	note A#, 16
	note G#, 16
	note F_, 8
	note G#, 8
	note G_, 15
	note_type 3, 13, 0
	note G#, 3
	note A_, 1
	note A#, 16
	note A#, 14
	note A_, 1
	note G#, 1
	note_type 12, 13, 0
	note G_, 8
	note G#, 15
	note_type 3, 13, 0
	note A_, 1
	note A#, 1
	note B_, 1
	octave 4
	note C_, 1
	note_type 12, 13, 0
	note C#, 8
	note C_, 8
	octave 3
	note A#, 15
	note_type 3, 13, 0
	note B_, 1
	octave 4
	note C_, 1
	note C#, 1
	note D_, 1
	note_type 12, 13, 0
	note D#, 12
	octave 3
	note G_, 1
	note G#, 1
	note A#, 1
	note B_, 1
	callchannel Music_RivalBattleXY_Ch2_branch_2
	note D#, 4
	volume_envelope 11, 7
	note G_, 4
	volume_envelope 11, 3
	note F_, 4
	note G_, 1
	note G#, 1
	note A#, 1
	note B_, 1
	callchannel Music_RivalBattleXY_Ch2_branch_2
	note A#, 4
	volume_envelope 11, 7
	octave 4
	note D_, 4
	volume_envelope 11, 3
	note C_, 4
	note __, 10
	note __, 16
	octave 2
	volume_envelope 11, 7
	note A#, 4
	note A_, 2
	note A#, 2
	note B_, 2
	octave 3
	volume_envelope 11, 3
	note C_, 2
	volume_envelope 11, 7
	note C_, 4
	note __, 12
	note C_, 2
	note __, 2
	octave 2
	note C_, 2
	octave 3
	note C_, 2
	note __, 2
	note C_, 4
	jumpchannel Music_RivalBattleXY_Ch2_loop

Music_RivalBattleXY_Ch2_branch_1:
	volume_envelope 11, 3
	octave 3
	note G_, 6
	note C_, 4
	note G_, 6
	note_type 6, 11, 7
	note F_, 8
	note E_, 8
	note F_, 8
	note G_, 7
	note A_, 1
	note_type 12, 11, 4
	note A#, 2
	note A_, 2
	note A#, 1
	note __, 1
	volume_envelope 11, 7
	octave 4
	note C_, 4
	volume_envelope 11, 4
	octave 3
	note A#, 2
	octave 4
	note C_, 2
	note D_, 1
	note __, 1
	volume_envelope 11, 7
	endchannel

Music_RivalBattleXY_Ch2_branch_2:
	volume_envelope 11, 3
	octave 4
	note C_, 2
	note C_, 4
	note C_, 4
	note C_, 4
	note C_, 2
	octave 3
	volume_envelope 11, 7
	note A#, 4
	note B_, 4
	octave 4
	volume_envelope 11, 3
	note C_, 4
	octave 3
	note G_, 4
	note A#, 6
	note A_, 4
	note F_, 4
	note F_, 2
	endchannel

Music_RivalBattleXY_Ch3:
	note_type 12, 1, -1
	octave 2
	note A_, 1
	note __, 1
	note A_, 2
	note __, 2
	note A_, 6
	note E_, 1
	note F#, 1
	note G#, 1
	note A#, 1
Music_RivalBattleXY_Ch3_loop_main:
Music_RivalBattleXY_Ch3_loop_1:
	note C_, 1
	note __, 1
	note C_, 1
	note __, 1
	loopchannel 13, Music_RivalBattleXY_Ch3_loop_1
	note G_, 1
	note __, 1
	note F_, 1
	note __, 1
	note G_, 1
	note __, 1
	note F_, 1
	note __, 1
	note E_, 1
	note __, 1
	octave 1
	note B_, 1
	note __, 1
	callchannel Music_RivalBattleXY_Ch3_branch_1
	callchannel Music_RivalBattleXY_Ch3_branch_2
	callchannel Music_RivalBattleXY_Ch3_branch_1
	callchannel Music_RivalBattleXY_Ch3_branch_4
	callchannel Music_RivalBattleXY_Ch3_branch_3
	callchannel Music_RivalBattleXY_Ch3_branch_4
	callchannel Music_RivalBattleXY_Ch3_branch_3
	callchannel Music_RivalBattleXY_Ch3_branch_4
	callchannel Music_RivalBattleXY_Ch3_branch_3
	callchannel Music_RivalBattleXY_Ch3_branch_4
	callchannel Music_RivalBattleXY_Ch3_branch_3
	callchannel Music_RivalBattleXY_Ch3_branch_2
	callchannel Music_RivalBattleXY_Ch3_branch_5
	note D#, 2
	note __, 2
	note G_, 4
	note F_, 2
	note __, 6
	callchannel Music_RivalBattleXY_Ch3_branch_5
	note A#, 2
	note __, 2
	octave 3
	note D_, 4
	note C_, 2
	octave 2
	note G#, 1
	note __, 1
	note A#, 1
	note __, 1
	note B_, 1
	note __, 1
	jumpchannel Music_RivalBattleXY_Ch3_loop_main

Music_RivalBattleXY_Ch3_branch_1:
	octave 2
	note C_, 1
	note __, 1
	octave 3
	note C_, 1
	note __, 1
	loopchannel 8, Music_RivalBattleXY_Ch3_branch_1
	endchannel

Music_RivalBattleXY_Ch3_branch_2:
	octave 2
	note D#, 1
	note __, 1
	octave 3
	note D#, 1
	note __, 1
	loopchannel 8, Music_RivalBattleXY_Ch3_branch_2
	endchannel

Music_RivalBattleXY_Ch3_branch_3:
	octave 2
	note C#, 1
	note __, 1
	octave 3
	note C#, 1
	note __, 1
	loopchannel 7, Music_RivalBattleXY_Ch3_branch_3
	octave 2
	note C#, 2
	note D_, 2
	endchannel

Music_RivalBattleXY_Ch3_branch_4:
	octave 2
	note D#, 1
	note __, 1
	octave 3
	note D#, 1
	note __, 1
	loopchannel 4, Music_RivalBattleXY_Ch3_branch_4
	octave 2
	note D#, 1
	note __, 1
	note D#, 2
	note A#, 2
	note G_, 2
	note A#, 2
	note G_, 2
	note F_, 2
	note D#, 2
	endchannel

Music_RivalBattleXY_Ch3_branch_5:
	octave 3
	note C_, 1
	note __, 1
	note C_, 2
	note __, 2
	note C_, 2
	note __, 2
	note C_, 2
	note __, 2
	note C_, 1
	note __, 1
	octave 2
	note A#, 4
	note B_, 4
	octave 3
	note C_, 2
	note __, 2
	octave 2
	note G_, 2
	note __, 2
	note A#, 4
	note __, 2
	note A_, 2
	note __, 2
	note F_, 2
	note __, 2
	note F_, 1
	note __, 1
	endchannel

Music_RivalBattleXY_Ch4:
	toggle_noise 3
	note_type 12
	note B_, 2
	note B_, 4
	note B_, 6
	note C_, 1
	note C_, 1
	note C_, 1
	note C_, 1
Music_RivalBattleXY_Ch4_loop:
	note D#, 2
	note D#, 2
	note C_, 2
	note D#, 2
	jumpchannel Music_RivalBattleXY_Ch4_loop
