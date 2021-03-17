; Pokémon R/S/E - Battle Factory
; Demixed by Mmmmmm
; https://pastebin.com/0hihGkJp
; https://soundcloud.com/mmmmmmmmmmmmmmmmm-1/battle-factory-gbc-8-bit

Music_BattleFactoryRSE:
	musicheader 4, 1, Music_BattleFactoryRSE_Ch1
	musicheader 1, 2, Music_BattleFactoryRSE_Ch2
	musicheader 1, 3, Music_BattleFactoryRSE_Ch3
	musicheader 1, 4, Music_BattleFactoryRSE_Ch4

Music_BattleFactoryRSE_Ch1:
	tempo 132
	volume $77
	stereopanning $ff
	notetype $c, $47
	note __, 12
	note __, 16
Music_BattleFactoryRSE_Ch1_loop:
	dutycycle $2
	vibrato $12, $24
	note __, 16
	notetype $6, $47
	octave 4
	note G_, 12
	octave 5
	note D_, 8
	octave 4
	note F_, 8
	note D_, 16
	note __, 12
	intensity $42
	dutycycle $0
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
	dutycycle $2
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
	dutycycle $0
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
	dutycycle 3
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
	dutycycle $0
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
	dutycycle $3
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
	dutycycle $0
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
	dutycycle $3
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
	dutycycle $0
	notetype $c, $1F
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
	notetype $8, $A7
	dutycycle $2
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
	notetype $6, $42
	note __, 16
	note __, 8

	dutycycle $0
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
	dutycycle $1
	notetype $8, $A7
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
	notetype $6, $94
	note __, 12
	octave 4
	dutycycle $2
	note G#, 16
	note __, 12
	note __, 8
	dutycycle $0
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
	loopchannel 0, Music_BattleFactoryRSE_Ch1_loop

Music_BattleFactoryRSE_Ch2:
	stereopanning $ff
	notetype $c, $90
	note __, 12
Music_BattleFactoryRSE_Ch2_loop:
	note __, 16
	note __, 16
	dutycycle $2
	notetype $6, $97
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
	dutycycle $0
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
	dutycycle $2
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
	dutycycle $0
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
	dutycycle $2
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
	dutycycle $0
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
	dutycycle 3
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
	dutycycle $0
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

	dutycycle $2
	note __, 10
	octave 4
	note E_, 2
	note G_, 2
	octave 3
	note E_, 2
	dutycycle $3
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
	dutycycle $0
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
	dutycycle $2
	intensity $92
	note __, 10
	octave 4
	note E_, 2
	note G_, 2
	octave 3
	note E_, 2
	dutycycle $3
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
	dutycycle $0
	notetype $c, $6F
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
	notetype $6, $92
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
	notetype $3, $92
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
	notetype $8, $92
	dutycycle $2
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

	notetype $6, $92
	dutycycle $0
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
	dutycycle $3
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
	loopchannel 0, Music_BattleFactoryRSE_Ch2_loop

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
	notetype $6, $25
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

	callchannel	Music_BattleFactoryRSE_Ch3_branch_1
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
	loopchannel 0, Music_BattleFactoryRSE_Ch3_loop

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
	notetype $6
Music_BattleFactoryRSE_Ch4_loop:
	note D#, 8
	loopchannel 0, Music_BattleFactoryRSE_Ch4_loop

Music_BattleFactoryRSE_Ch4_branch_1:
	note E_, 4
	note F#, 4
	note D#, 4
	note F#, 4
	loopchannel 6, Music_BattleFactoryRSE_Ch4_branch_1
	endchannel
