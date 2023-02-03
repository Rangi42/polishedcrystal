; Pokémon R/S/E - Battle! Gym Leader
; Demixed by Mmmmmm
; https://pastebin.com/3iAgGV4u
; https://hax.iimarckus.org/topic/6777/

Music_GymLeaderBattleRSE:
	dbw $c0, Music_GymLeaderBattleRSE_Ch1
	dbw $01, Music_GymLeaderBattleRSE_Ch2
	dbw $02, Music_GymLeaderBattleRSE_Ch3
	dbw $03, Music_GymLeaderBattleRSE_Ch4

Music_GymLeaderBattleRSE_Ch1:
	tempo 100
	duty_cycle 1
	tone $0001
	note_type 12, 12, 4
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
	duty_cycle 1
	volume_envelope 12, 7
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
	volume_envelope 12, 0
	note E_, 6
	volume_envelope 12, 7
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
	volume_envelope 12, 0
	note E_, 6
	volume_envelope 12, 7
	note E_, 6
	note C_, 4
	volume_envelope 12, 0
	note G_, 8
	volume_envelope 12, 7
	note G_, 8
	note A#, 8
	note A_, 8
	note A#, 4
	note A_, 4
	octave 5
	note D_, 4
	note F_, 4
	volume_envelope 12, 0
	note E_, 6
	volume_envelope 12, 7
	note E_, 6
	note D_, 4
	volume_envelope 12, 0
	note C_, 8
	volume_envelope 12, 7
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
	volume_envelope 12, 0
	note E_, 6
	volume_envelope 12, 7
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
	volume_envelope 12, 0
	note E_, 6
	volume_envelope 12, 7
	note E_, 6
	note C_, 4
	volume_envelope 12, 0
	note G_, 4
	volume_envelope 12, 7
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
	volume_envelope 12, 0
	note E_, 6
	volume_envelope 12, 7
	note E_, 6
	note C_, 4
	volume_envelope 12, 0
	note G_, 6
	volume_envelope 12, 7
	note G_, 10
	duty_cycle 3
	octave 3
	volume_envelope 12, 4
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
	volume_envelope 12, 0
	note C_, 4
	volume_envelope 12, 4
	note C_, 12
	note __, 16
	note __, 16
	note __, 16
	volume_envelope 9, 0
	octave 3
	note C_, 16
	note C_, 11
	note_type 3, 9, 0
	note C_, 3
	note __, 1
	note_type 12, 9, 0
	note C_, 2
	octave 2
	note A#, 2
	octave 3
	note C#, 16
	note D#, 16
	note C_, 16
	octave 4
	volume_envelope 10, 0
	note C_, 11
	note_type 3, 10, 0
	note C_, 3
	note __, 1
	note_type 12, 10, 0
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
	volume_envelope 10, 0
	octave 3
	note C_, 8
	volume_envelope 10, 7
	note C_, 8
	octave 2
	note A#, 7
	octave 3
	note C_, 1
	note D_, 8
	volume_envelope 10, 0
	octave 2
	note G_, 8
	volume_envelope 10, 7
	note G_, 8
	volume_envelope 10, 0
	octave 3
	note C_, 8
	volume_envelope 10, 7
	note C_, 8
	volume_envelope 10, 0
	note C#, 8
	volume_envelope 10, 7
	note C#, 8
	octave 2
	note A#, 8
	octave 3
	note C#, 6
	note E_, 2
	volume_envelope 10, 0
	note C_, 8
	volume_envelope 10, 7
	note C_, 8
	volume_envelope 10, 0
	note E_, 8
	volume_envelope 10, 7
	note E_, 8
	jumpchannel Music_GymLeaderBattleRSE_Ch1_loop

Music_GymLeaderBattleRSE_Ch2:
	tone $0001
	duty_cycle 2
	note_type 12, 9, 4
	vibrato $12, $15
	octave 5
	note G_, 1
	note G#, 1
	note G_, 2
	loopchannel 8, Music_GymLeaderBattleRSE_Ch2
	volume_envelope 7, 0
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
	duty_cycle 1
	volume_envelope 9, 0
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
	duty_cycle 3
	volume_envelope 12, 7
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
	volume_envelope 9, 7
	octave 3
	note E_, 2
	note E_, 2
	note E_, 2
	note E_, 2
	note E_, 2
	volume_envelope 12, 7
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
	volume_envelope 12, 0
	note G_, 6
	volume_envelope 12, 7
	note G_, 6
	note E_, 4
	octave 4
	volume_envelope 12, 0
	note C_, 4
	volume_envelope 12, 7
	note C_, 6
	volume_envelope 10, 7
	duty_cycle 0
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
	volume_envelope 12, 7
	duty_cycle 3
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
	volume_envelope 12, 0
	note G_, 6
	volume_envelope 12, 7
	note G_, 6
	note E_, 4
	octave 4
	volume_envelope 12, 0
	note C_, 4
	volume_envelope 12, 7
	note C_, 6
	volume_envelope 10, 7
	duty_cycle 0
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
	duty_cycle 3
	volume_envelope 10, 4
	octave 3
	note G_, 6
	note F_, 6
	note G_, 4
	note A_, 6
	note F_, 6
	note A_, 4
	volume_envelope 10, 0
	note G_, 4
	volume_envelope 10, 4
	note G_, 12
	volume_envelope 9, 0
	octave 2
	note C_, 11
	note_type 3, 9, 0
	note C_, 3
	note __, 1
	note_type 12, 9, 0
	note C_, 2
	octave 1
	note A#, 2
	octave 2
	note C#, 16
	note D#, 16
	note C_, 16
	note C_, 11
	note_type 3, 9, 0
	note C_, 3
	note __, 1
	note_type 12, 9, 0
	note C_, 2
	octave 1
	note A#, 2
	octave 2
	note C#, 16
	note D#, 16
	note C_, 16
	note C_, 11
	note_type 3, 9, 0
	note C_, 3
	note __, 1
	note_type 12, 9, 0
	note C_, 2
	octave 1
	note A#, 2
	octave 2
	note C#, 16
	note D#, 16
	octave 1
	note A#, 16
	note A#, 16
	duty_cycle 0
	octave 3
	volume_envelope 10, 7
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
	volume_envelope 8, 4
	callchannel Music_GymLeaderBattleRSE_Ch2_branch_1
	callchannel Music_GymLeaderBattleRSE_Ch2_branch_1
	callchannel Music_GymLeaderBattleRSE_Ch2_branch_2
	callchannel Music_GymLeaderBattleRSE_Ch2_branch_2
	callchannel Music_GymLeaderBattleRSE_Ch2_branch_3
	callchannel Music_GymLeaderBattleRSE_Ch2_branch_3
	callchannel Music_GymLeaderBattleRSE_Ch2_branch_2
	callchannel Music_GymLeaderBattleRSE_Ch2_branch_2
	jumpchannel Music_GymLeaderBattleRSE_Ch2_loop_main

Music_GymLeaderBattleRSE_Ch2_branch_1:
	duty_cycle 0
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
	duty_cycle 1
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
	duty_cycle 0
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
	note_type 12, 1, -1
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
	jumpchannel Music_GymLeaderBattleRSE_Ch3_loop_main

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
	note_type 12
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
	jumpchannel Music_GymLeaderBattleRSE_Ch4_loop_main

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
