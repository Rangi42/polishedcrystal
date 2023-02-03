; Pokémon R/S/E - Battle Factory
; Demixed by Mmmmmm
; https://pastebin.com/0hihGkJp
; https://soundcloud.com/mmmmmmmmmmmmmmmmm-1/battle-factory-gbc-8-bit

Music_BattleFactoryRSE:
	channel_count 4
	channel 1, Music_BattleFactoryRSE_Ch1
	channel 2, Music_BattleFactoryRSE_Ch2
	channel 3, Music_BattleFactoryRSE_Ch3
	channel 4, Music_BattleFactoryRSE_Ch4

Music_BattleFactoryRSE_Ch1:
	tempo 132
	volume 7, 7
	stereopanning $ff
	note_type 12, 4, 7
	note __, 12
	note __, 16
Music_BattleFactoryRSE_Ch1_loop:
	duty_cycle 2
	vibrato $12, $24
	note __, 16
	note_type 6, 4, 7
	octave 4
	note G_, 12
	octave 5
	note D_, 8
	octave 4
	note F_, 8
	note D_, 16
	note __, 12
	intensity $42
	duty_cycle 0
	note D_, 2
	note D_, 2
	note D_, 2
	note D_, 2
	note D_, 2
	note D_, 2
	note D_, 2
	note D_, 2
	note E_, 2
	octave 2
	note E_, 2
	octave 3
	note E_, 2
	octave 4
	note E_, 2
	octave 3
	note E_, 2
	octave 4
	note E_, 2
	note D_, 2
	note E_, 2
	note G_, 2
	note A_, 2
	octave 2
	note E_, 2
	octave 4
	note D_, 2
	note E_, 2
	octave 3
	note E_, 2
	note A_, 2
	note B_, 2
	octave 2
	note B_, 2
	octave 3
	note A#, 2
	note B_, 2
	octave 4
	note D_, 2
	octave 3
	note A#, 2
	note B_, 2
	octave 4
	note D_, 2
	note F_, 2
	octave 3
	note B_, 2
	octave 4
	note D_, 2
	note F_, 2
	note G_, 2
	duty_cycle 2
	intensity $47
	octave 4
	note B_, 12
	note G_, 12
	note D_, 8
	note F#, 12
	octave 5
	note D_, 12
	octave 4
	note B_, 8
	octave 5
	note F_, 16

	intensity $42
	duty_cycle 0
	octave 4
	note __, 8
	note F_, 2
	note F_, 2
	note F_, 2
	note F_, 2
	note F_, 4
	note F_, 2
	note F_, 2
	note F_, 2
	note F_, 2
	note F_, 4
	note F_, 2
	note F_, 2
	note F_, 4
	note __, 16
	octave 1
	note E_, 1
	note __, 1
	octave 2
	note E_, 2
	note __, 2
	octave 1
	note E_, 2
	octave 2
	note E_, 2
	note __, 2
	octave 1
	note E_, 2
	octave 2
	note E_, 2
	note __, 2
	octave 1
	note E_, 2
	octave 2
	note E_, 2
	octave 1
	note E_, 1
	note __, 1
	note E_, 1
	note __, 1
	octave 2
	note E_, 2
	note G_, 2
	octave 1
	note E_, 1
	note __, 1
	duty_cycle 3
	octave 4
	note E_, 2
	octave 2
	note E_, 2
	octave 3
	note E_, 2
	octave 4
	note E_, 2
	octave 3
	note A#, 2
	note B_, 2
	note G_, 2
	octave 1
	note E_, 2
	octave 3
	note F#, 2
	note G_, 2
	note D_, 2
	octave 2
	note E_, 2
	octave 3
	note D#, 2
	note E_, 2
	note F#, 2
	note G_, 2
	duty_cycle 0
	intensity $47
	vibrato $12, $F2
	octave 2
	note B_, 12
	octave 3
	note E_, 12
	note B_, 8
	octave 4
	note D#, 12
	octave 3
	note B_, 12
	note G#, 8
	octave 4
	note F_, 16
	vibrato $12, $24
	intensity $44
	octave 4
	note D_, 2
	note D_, 2
	note D_, 2
	note D_, 2
	octave 5
	note D_, 4
	octave 4
	note D_, 2
	note D_, 2
	note D_, 2
	note D_, 2
	octave 5
	note D_, 2
	octave 4
	note D_, 2
	note D_, 2
	octave 5
	note D_, 2
	octave 4
	note D_, 2
	note D_, 2

	note __, 16
	duty_cycle 3
	octave 3
	note A#, 2
	note B_, 2
	octave 2
	note E_, 2
	octave 3
	note B_, 2
	note B_, 2
	note B_, 2
	note A#, 2
	note B_, 2
	octave 4
	note D_, 2
	note D_, 2
	note C#, 2
	octave 3
	note B_, 2
	note G_, 2
	note G_, 2
	note E_, 2
	octave 2
	note B_, 2
	octave 3
	note E_, 2
	note G_, 2
	octave 2
	note E_, 2
	octave 3
	note E_, 2
	note G_, 2
	octave 2
	note E_, 2
	octave 3
	note E_, 2
	note G_, 2
	octave 2
	note E_, 2
	octave 3
	note E_, 2
	note G_, 2
	octave 2
	note E_, 2
	octave 3
	note E_, 2
	note G_, 2
	note A_, 2
	note B_, 2
	duty_cycle 0
	intensity $47
	vibrato $12, $F2
	octave 2
	note B_, 12
	note G_, 12
	note D_, 8
	note F#, 12
	octave 3
	note C#, 12
	octave 2
	note F#, 8
	note D#, 16
	vibrato $12, $24
	note __, 16
	duty_cycle 3
	intensity $42
	callchannel Music_BattleFactoryRSE_Ch2_branch_1
	note G_, 2
	octave 2
	note B_, 2
	octave 3
	note A_, 2
	octave 2
	note G_, 2
	octave 3
	note B_, 2
	octave 2
	note B_, 2
	octave 3
	note G_, 2
	note D_, 2
	octave 2
	note B_, 2
	octave 3
	note F#, 2
	note B_, 2
	octave 4
	note F#, 2
	octave 5
	note D_, 2
	octave 4
	note B_, 2
	note F#, 2
	note D_, 2
	duty_cycle 0
	note_type 12, 1, -7
	note F#, 6
	intensity $47
	vibrato $12, $73
	note F#, 10
	intensity $1F
	vibrato $12, $24
	note B_, 6
	intensity $47
	vibrato $12, $73
	note B_, 10
	intensity $1F
	vibrato $12, $24
	note D#, 6
	intensity $47
	vibrato $12, $73
	note D#, 10
	intensity $1F
	vibrato $12, $24
	note A_, 6
	intensity $47
	vibrato $12, $73
	vibrato $12, $24
	note A_, 10
	note __, 16
	note __, 16
	note __, 12
	note_type 8, 10, 7
	duty_cycle 2
	octave 6
	note D#, 1
	note D_, 5
	note C_, 2
	note __, 2
	octave 5
	note A#, 2
	note A_, 6
	note G_, 2
	note __, 2
	note A#, 2
	note G_, 6
	note D#, 1
	note D_, 5
	note_type 6, 4, 2
	note __, 16
	note __, 8

	duty_cycle 0
	octave 1
	note B_, 2
	octave 2
	note B_, 2
	note __, 2
	octave 1
	note B_, 2
	octave 2
	note B_, 2
	note __, 2
	octave 1
	note B_, 2
	octave 2
	note B_, 2
	note __, 2
	octave 1
	note B_, 2
	octave 2
	note B_, 2
	octave 1
	note B_, 1
	note __, 1
	note B_, 1
	note __, 1
	octave 2
	note F#, 2
	note B_, 2
	octave 3
	note F_, 2
	vibrato $12, $73
	intensity $47
	note F#, 16
	vibrato $12, $24
	note __, 8
	duty_cycle 1
	note_type 8, 10, 7
	note G#, 2
	note __, 2
	note E_, 2
	note B_, 6
	note A_, 6
	note G#, 6
	note D#, 2
	note __, 2
	note E_, 2
	note F#, 12
	note_type 6, 9, 4
	note __, 12
	octave 4
	duty_cycle 2
	note G#, 16
	note __, 12
	note __, 8
	duty_cycle 0
	intensity $62
	octave 2
	note E_, 1
	note __, 1
	octave 3
	note E_, 2
	note __, 2
	octave 2
	note E_, 2
	octave 3
	note E_, 2
	note __, 2
	octave 2
	note E_, 2
	octave 3
	note E_, 2
	note __, 2
	octave 2
	note E_, 2
	octave 3
	note E_, 2
	octave 2
	note E_, 1
	note __, 1
	note E_, 1
	note __, 1
	octave 3
	note E_, 2
	note G_, 2
	octave 2
	note E_, 1
	note __, 1
	intensity $22
	note E_, 1
	note __, 1
	octave 3
	note E_, 2
	note G_, 2
	octave 2
	note E_, 2
	jumpchannel Music_BattleFactoryRSE_Ch1_loop

Music_BattleFactoryRSE_Ch2:
	stereopanning $ff
	note_type 12, 9, 0
	note __, 12
Music_BattleFactoryRSE_Ch2_loop:
	note __, 16
	note __, 16
	duty_cycle 2
	note_type 6, 9, 7
	octave 4
	note G_, 11
	note B_, 1
	octave 5
	note D_, 7
	octave 4
	note G#, 1
	note F_, 8
	note D_, 16
	note __, 4
	intensity $92
	duty_cycle 0
	note D_, 2
	note D_, 2
	note D_, 2
	note D_, 2
	note D_, 2
	note D_, 2
	note D_, 2
	note D_, 2
	note E_, 2
	octave 2
	note E_, 2
	octave 3
	note E_, 2
	octave 4
	note E_, 2
	octave 3
	note E_, 2
	octave 4
	note E_, 2
	note D_, 2
	note E_, 2
	note G_, 2
	note A_, 2
	octave 2
	note E_, 2
	octave 4
	note D_, 2
	note E_, 2
	octave 3
	note E_, 2
	note A_, 2
	note B_, 2
	octave 2
	note B_, 2
	octave 3
	note A#, 2
	note B_, 2
	octave 4
	note D_, 2
	octave 3
	note A#, 2
	note B_, 2
	octave 4
	note D_, 2
	note F_, 2
	octave 3
	note B_, 2
	octave 4
	note D_, 2
	note F_, 2
	note G_, 2
	octave 5
	note D_, 2
	octave 4
	note A#, 2
	note E_, 2
	octave 3
	note B_, 2
	duty_cycle 2
	intensity $97
	octave 4
	note B_, 11
	note A_, 1
	note G_, 11
	note F_, 1
	note D_, 8
	note F#, 10
	note A_, 1
	note B_, 1
	octave 5
	note D_, 12
	octave 4
	note B_, 7
	octave 5
	note D_, 1
	note F_, 16

	intensity $92
	duty_cycle 0
	octave 4
	note F_, 2
	note F_, 2
	note F_, 2
	note F_, 2
	note F_, 4
	note F_, 2
	note F_, 2
	note F_, 2
	note F_, 2
	note F_, 4
	note F_, 2
	note F_, 2
	note F_, 4
	note __, 2
	duty_cycle 2
	octave 3
	note E_, 2
	octave 4
	note E_, 2
	octave 3
	note E_, 2
	note __, 2
	octave 4
	note E_, 2
	note G_, 2
	octave 3
	note E_, 2
	duty_cycle 0
	octave 1
	note E_, 1
	note __, 1
	octave 2
	note E_, 2
	note __, 2
	octave 1
	note E_, 2
	octave 2
	note E_, 2
	note __, 2
	octave 1
	note E_, 2
	octave 2
	note E_, 2
	note __, 2
	octave 1
	note E_, 2
	octave 2
	note E_, 2
	octave 1
	note E_, 1
	note __, 1
	note E_, 1
	note __, 1
	octave 2
	note E_, 2
	note G_, 2
	octave 1
	note E_, 1
	note __, 1
	duty_cycle 3
	octave 4
	note E_, 2
	octave 2
	note E_, 2
	octave 3
	note E_, 2
	octave 4
	note E_, 2
	octave 3
	note A#, 2
	note B_, 2
	note G_, 2
	octave 1
	note E_, 2
	octave 3
	note F#, 2
	note G_, 2
	note D_, 2
	octave 2
	note E_, 2
	octave 3
	note D#, 2
	note E_, 2
	note F#, 2
	note G_, 2
	duty_cycle 0
	intensity $97
	vibrato $12, $F2
	octave 2
	note B_, 12
	octave 3
	note E_, 12
	note B_, 8
	octave 4
	note D#, 12
	octave 3
	note B_, 12
	note G#, 8
	octave 4
	note F_, 16
	vibrato $12, $24
	intensity $84
	octave 4
	note D_, 2
	note D_, 2
	note D_, 2
	note D_, 2
	octave 5
	note D_, 4
	octave 4
	note D_, 2
	note D_, 2
	note D_, 2
	note D_, 2
	octave 5
	note D_, 2
	octave 4
	note D_, 2
	note D_, 2
	octave 5
	note D_, 2
	octave 4
	note D_, 2
	note D_, 2

	duty_cycle 2
	note __, 10
	octave 4
	note E_, 2
	note G_, 2
	octave 3
	note E_, 2
	duty_cycle 3
	octave 3
	note A#, 2
	note B_, 2
	octave 2
	note E_, 2
	octave 3
	note B_, 2
	note B_, 2
	note B_, 2
	note A#, 2
	note B_, 2
	octave 4
	note D_, 2
	note D_, 2
	note C#, 2
	octave 3
	note B_, 2
	note G_, 2
	note G_, 2
	note E_, 2
	octave 2
	note B_, 2
	octave 3
	note E_, 2
	note G_, 2
	octave 2
	note E_, 2
	octave 3
	note E_, 2
	note G_, 2
	octave 2
	note E_, 2
	octave 3
	note E_, 2
	note G_, 2
	octave 2
	note E_, 2
	octave 3
	note E_, 2
	note G_, 2
	octave 2
	note E_, 2
	octave 3
	note E_, 2
	note G_, 2
	note A_, 2
	note B_, 2
	duty_cycle 0
	intensity $97
	vibrato $12, $F2
	octave 2
	note B_, 12
	note G_, 12
	note D_, 8
	note F#, 12
	octave 3
	note C#, 12
	octave 2
	note F#, 8
	note D#, 16
	duty_cycle 2
	intensity $92
	note __, 10
	octave 4
	note E_, 2
	note G_, 2
	octave 3
	note E_, 2
	duty_cycle 3
	octave 3
	callchannel Music_BattleFactoryRSE_Ch2_branch_1
	note G_, 2
	octave 2
	note B_, 2
	octave 3
	note A_, 2
	octave 2
	note G_, 2
	octave 3
	note B_, 2
	octave 2
	note B_, 2
	octave 3
	note G_, 2
	note D_, 2
	octave 2
	note B_, 2
	octave 3
	note F#, 2
	note B_, 2
	octave 4
	note F#, 2
	octave 5
	note D_, 2
	octave 4
	note B_, 2
	note F#, 2
	note D_, 2
	duty_cycle 0
	note_type 12, 6, -7
	note F#, 6
	intensity $97
	vibrato $12, $73
	note F#, 10
	intensity $6F
	vibrato $12, $24
	note B_, 6
	intensity $97
	vibrato $12, $73
	note B_, 10
	intensity $6F
	vibrato $12, $24
	note D#, 6
	intensity $97
	vibrato $12, $73
	note D#, 10
	intensity $6F
	vibrato $12, $24
	note A_, 6
	intensity $97
	vibrato $12, $73
	note A_, 10
	note_type 6, 9, 2
	vibrato $12, $24
	octave 2
	note C_, 2
	note E_, 2
	note G_, 2
	octave 3
	note C_, 4
	octave 2
	note E_, 2
	note F_, 2
	note C_, 2
	note D_, 2
	note F_, 2
	note G_, 2
	note B_, 2
	note_type 3, 9, 2
	note D#, 1
	note D_, 1
	note C#, 1
	note C_, 1
	octave 1
	note B_, 1
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
	note_type 8, 9, 2
	duty_cycle 2
	octave 3
	note D_, 4
	note A_, 2
	octave 2
	note A_, 4
	octave 3
	note A_, 2
	octave 2
	note B_, 4
	octave 3
	note A_, 2
	note C#, 4
	note A_, 2
	note E_, 4
	note B_, 2
	octave 2
	note B_, 4
	octave 3
	note B_, 2
	note C#, 4
	note B_, 2
	note D#, 4
	note B_, 2
	note F_, 4
	octave 4
	note C_, 2
	octave 3
	note C_, 4
	octave 4
	note C_, 2
	octave 3
	note D_, 4
	octave 4
	note C_, 2
	octave 3
	note E_, 4
	octave 4
	note C_, 2
	octave 3
	note G_, 4
	octave 4
	note D_, 2
	octave 3
	note D_, 4
	octave 4
	note D_, 2
	octave 3
	note E_, 4
	octave 4
	note D_, 2
	octave 3
	note F#, 4
	octave 4
	note D_, 2

	note_type 6, 9, 2
	duty_cycle 0
	octave 1
	note B_, 2
	octave 2
	note B_, 2
	note __, 2
	octave 1
	note B_, 2
	octave 2
	note B_, 2
	note __, 2
	octave 1
	note B_, 2
	octave 2
	note B_, 2
	note __, 2
	octave 1
	note B_, 2
	octave 2
	note B_, 2
	octave 1
	note B_, 1
	note __, 1
	note B_, 1
	note __, 1
	octave 2
	note F#, 2
	note B_, 2
	octave 3
	note F_, 2
	vibrato $12, $73
	intensity $97
	note F#, 16
	vibrato $12, $24
	note __, 16
	duty_cycle 3
	octave 3
	intensity $42
	callchannel Music_BattleFactoryRSE_Ch2_branch_1
	callchannel Music_BattleFactoryRSE_Ch2_branch_1
	octave 4
	note D_, 2
	note D_, 2
	note C#, 2
	octave 3
	note B_, 2
	octave 4
	note D_, 2
	note D_, 2
	note C#, 2
	octave 3
	note B_, 2
	octave 4
	note D_, 2
	note D_, 2
	note C#, 2
	octave 3
	note B_, 2
	note __, 8
	intensity $B7
	octave 2
	note E_, 1
	note __, 1
	octave 3
	note E_, 2
	note __, 2
	octave 2
	note E_, 2
	octave 3
	note E_, 2
	note __, 2
	octave 2
	note E_, 2
	octave 3
	note E_, 2
	note __, 2
	octave 2
	note E_, 2
	octave 3
	note E_, 2
	octave 2
	note E_, 1
	note __, 1
	note E_, 1
	note __, 1
	octave 3
	note E_, 2
	note G_, 2
	octave 2
	note E_, 1
	note __, 1
	jumpchannel Music_BattleFactoryRSE_Ch2_loop

Music_BattleFactoryRSE_Ch2_branch_1:
	octave 3
	note A#, 2
	note B_, 2
	note B_, 2
	note B_, 2
	note B_, 2
	note __, 2
	note A#, 2
	note B_, 2
	note B_, 2
	note B_, 2
	note B_, 2
	note __, 2
	octave 4
	note D_, 2
	note D_, 2
	note C#, 2
	octave 3
	note B_, 2
	endchannel

Music_BattleFactoryRSE_Ch3:
	vibrato $14, $23
	stereopanning $ff
	note_type 6, 2, 5
	octave 2
	note E_, 2
	note __, 2
	octave 1
	note E_, 2
	octave 2
	note E_, 2
	note __, 2
	octave 1
	note E_, 2
	octave 2
	note E_, 2
	note __, 2
	octave 1
	note E_, 2
	octave 2
	note E_, 2
	note __, 2
	octave 1
	note E_, 1
	note __, 1
	note E_, 1
	note __, 1
	octave 2
	note E_, 2
	note __, 2
	octave 1
	note E_, 2
	octave 2
	note E_, 2
	note __, 2
	octave 1
	note E_, 2
	octave 2
	note E_, 2
	note __, 2
	octave 1
	note E_, 2
	octave 2
	note E_, 2
	octave 1
	note E_, 1
	note __, 1
	note E_, 1
	note __, 1
	octave 2
	note E_, 2
	note G_, 2
	octave 3
	note E_, 2
Music_BattleFactoryRSE_Ch3_loop:
	octave 2
	note G_, 2
	note E_, 2
	note __, 2
	octave 1
	note E_, 2
	octave 2
	note E_, 2
	note __, 2
	octave 1
	note E_, 2
	octave 2
	note E_, 2
	note __, 2
	octave 3
	note E_, 2
	octave 2
	note E_, 2
	note G_, 2
	note E_, 1
	note __, 1
	note G_, 1
	note __, 1
	note B_, 1
	note __, 1
	octave 3
	note E_, 1
	note __, 1
	callchannel Music_BattleFactoryRSE_Ch3_branch_1

	callchannel Music_BattleFactoryRSE_Ch3_branch_1
	callchannel Music_BattleFactoryRSE_Ch3_branch_1
	callchannel Music_BattleFactoryRSE_Ch3_branch_1
	callchannel Music_BattleFactoryRSE_Ch3_branch_1

	callchannel Music_BattleFactoryRSE_Ch3_branch_1
	callchannel Music_BattleFactoryRSE_Ch3_branch_1
	callchannel Music_BattleFactoryRSE_Ch3_branch_1
	callchannel Music_BattleFactoryRSE_Ch3_branch_1

	callchannel Music_BattleFactoryRSE_Ch3_branch_1
	callchannel Music_BattleFactoryRSE_Ch3_branch_1
	callchannel Music_BattleFactoryRSE_Ch3_branch_1
	callchannel Music_BattleFactoryRSE_Ch3_branch_1

	callchannel Music_BattleFactoryRSE_Ch3_branch_1
	callchannel Music_BattleFactoryRSE_Ch3_branch_1
	callchannel Music_BattleFactoryRSE_Ch3_branch_1
	callchannel Music_BattleFactoryRSE_Ch3_branch_1

	callchannel Music_BattleFactoryRSE_Ch3_branch_1
	callchannel Music_BattleFactoryRSE_Ch3_branch_1
	callchannel Music_BattleFactoryRSE_Ch3_branch_1
	callchannel Music_BattleFactoryRSE_Ch3_branch_1

	callchannel Music_BattleFactoryRSE_Ch3_branch_1
	callchannel Music_BattleFactoryRSE_Ch3_branch_1
	callchannel Music_BattleFactoryRSE_Ch3_branch_1
	callchannel Music_BattleFactoryRSE_Ch3_branch_1

	callchannel Music_BattleFactoryRSE_Ch3_branch_2
	callchannel Music_BattleFactoryRSE_Ch3_branch_1
	callchannel Music_BattleFactoryRSE_Ch3_branch_1
	callchannel Music_BattleFactoryRSE_Ch3_branch_1

	intensity $18
	octave 4
	note G_, 2
	octave 5
	note G_, 2
	octave 4
	note G_, 4
	intensity $25
	note F#, 2
	note G_, 2
	note C#, 2
	note D_, 2
	octave 2
	note A#, 2
	note B_, 2
	note F#, 2
	note G_, 2
	octave 1
	note B_, 2
	octave 2
	note D_, 2
	note F#, 2
	note G_, 2
	callchannel Music_BattleFactoryRSE_Ch3_branch_1
	callchannel Music_BattleFactoryRSE_Ch3_branch_1
	callchannel Music_BattleFactoryRSE_Ch3_branch_1

	callchannel Music_BattleFactoryRSE_Ch3_branch_1
	callchannel Music_BattleFactoryRSE_Ch3_branch_3
	callchannel Music_BattleFactoryRSE_Ch3_branch_1
	jumpchannel Music_BattleFactoryRSE_Ch3_loop

Music_BattleFactoryRSE_Ch3_branch_1:
	octave 1
	note E_, 1
	note __, 1
	octave 2
	note E_, 2
	note __, 2
	octave 1
	note E_, 2
	octave 2
	note E_, 2
	note __, 2
	octave 1
	note E_, 2
	octave 2
	note E_, 2
	note __, 2
	octave 1
	note E_, 2
	octave 2
	note E_, 2
	octave 1
	note E_, 1
	note __, 1
	note E_, 1
	note __, 1
	octave 2
	note E_, 2
	note G_, 2
	octave 1
	note E_, 1
	note __, 1
	endchannel

Music_BattleFactoryRSE_Ch3_branch_2:
	octave 1
	note E_, 1
	note __, 1
	octave 2
	note E_, 2
	note __, 2
	octave 1
	note E_, 2
	octave 2
	note E_, 2
	note __, 2
	octave 1
	note E_, 2
	octave 2
	note E_, 2
	note __, 2
	octave 1
	note E_, 2
	octave 2
	note E_, 2
	octave 1
	note E_, 1
	note __, 1
	note E_, 1
	note __, 1
	octave 2
	note E_, 2
	note G_, 2
	octave 3
	note D_, 2
	endchannel

Music_BattleFactoryRSE_Ch3_branch_3:
	note E_, 1
	note __, 1
	octave 2
	note E_, 1
	note __, 1
	note G_, 1
	note __, 1
	octave 1
	note E_, 1
	note __, 1
	loopchannel 4, Music_BattleFactoryRSE_Ch3_branch_3
	endchannel

Music_BattleFactoryRSE_Ch4:
	togglenoise $4
	note_type 6
Music_BattleFactoryRSE_Ch4_loop:
	note D#, 8
	jumpchannel Music_BattleFactoryRSE_Ch4_loop

Music_BattleFactoryRSE_Ch4_branch_1:
	note E_, 4
	note F#, 4
	note D#, 4
	note F#, 4
	loopchannel 6, Music_BattleFactoryRSE_Ch4_branch_1
	endchannel
