; Pokémon B/W - Lacunosa Town
; Demixed by Mmmmmm
; https://pastebin.com/Bfg68CV7
; https://soundcloud.com/mmmmmmmmmmmmmmmmm-1/lacunosa-town-gbc-8-bit

Music_LacunosaTown:
	dbw $c0, Music_LacunosaTown_Ch1
	dbw $01, Music_LacunosaTown_Ch2
	dbw $02, Music_LacunosaTown_Ch3
	dbw $03, Music_LacunosaTown_Ch4

Music_LacunosaTown_Ch1:
	tempo 130
	dutycycle 2
	tone $0001
	notetype $C, $94
	octave 5
	note __, 6
	note D#, 2
	note C#, 4
	octave 4
	note F_, 2
	note G#, 4
	note C#, 4
	octave 5
	note C_, 2
	octave 4
	note A#, 4
	note D#, 2
	note F_, 4
	octave 3
	note G#, 4
	octave 5
	note D#, 2
	note C#, 4
	octave 4
	note F_, 2
	note A#, 4
	note G#, 4
	octave 3
	note G#, 2
	octave 4
	note C#, 2
	note C_, 2
	note C#, 2
	note D#, 2
	note __, 8
	note F_, 2
	note G#, 2
	octave 5
	note C#, 2
	note C_, 4
	octave 4
	note D#, 6
	note G#, 2
	note F#, 2
	note F_, 2
	note D#, 4
	note F_, 2
	note C#, 4
	note C_, 2
	note C#, 2
	note D#, 2
	note F_, 4
	note G#, 2
	octave 5
	note C#, 10
	note __, 2
	intensity $B4
	octave 4
	note C_, 4
	note C#, 2
	octave 3
	note F_, 4
	note A#, 2
	note G#, 6
	note F#, 2
	note F_, 2
	note D#, 2
	note F_, 4
	note A#, 2
	note G#, 6
	note C#, 4
	note F#, 2
	note F_, 2
	note F#, 2
	note G#, 4
	note A#, 2
	note G#, 4
	intensity $83
	octave 4
	note F#, 2
	note F_, 2
	note D#, 2
	note F_, 2
	intensity $B4
	note C_, 4
	note C#, 2
	octave 3
	note F_, 4
	note A#, 2
	note G#, 6
	note C#, 2
	note D#, 2
	note F#, 2
	note F_, 4
	note G#, 2
	note C#, 6
	note F_, 4
	note F#, 2
	note F_, 2
	note C#, 2
	note D#, 3
	note __, 1
	note D#, 2
	note C#, 8
	note __, 4
	intensity $73
	callchannel Music_LacunosaTown_Ch1_branch_1
	callchannel Music_LacunosaTown_Ch1_branch_1
	callchannel Music_LacunosaTown_Ch1_branch_1
	note A#, 2
	note A#, 2
	octave 3
	note C#, 2
	octave 2
	note A#, 2
	note __, 2
	note A#, 2
	octave 3
	note C#, 2
	octave 2
	note A#, 2
	note __, 2
	octave 3
	note G#, 2
	octave 4
	note C#, 2
	note D#, 4
	intensity $94
	note G#, 2
	note A#, 2
	octave 5
	note C_, 2
	note C#, 8
	octave 4
	intensity $B4
	note F_, 2
	note F#, 2
	note G#, 2
	octave 5
	note C#, 6
	note C_, 4
	octave 4
	note A#, 2
	octave 5
	note C_, 4
	note C#, 8
	octave 4
	note C#, 2
	intensity $84
	octave 3
	note G#, 2
	octave 4
	note C#, 2
	note F_, 2
	note F#, 6
	note F_, 4
	note F#, 2
	note G#, 6
	intensity $B4
	octave 5
	note C_, 4
	note C#, 2
	octave 4
	note F_, 4
	note A#, 2
	note G#, 6
	note F#, 2
	note F_, 2
	note D#, 2
	note F_, 4
	note A#, 2
	note G#, 6
	note C#, 2
	note F#, 4
	note F_, 2
	note D#, 2
	note C#, 12
	note __, 6
	loopchannel 0, Music_LacunosaTown_Ch1

Music_LacunosaTown_Ch1_branch_1:
	octave 2
	note A#, 2
	note A#, 2
	octave 3
	note C#, 2
	octave 2
	note A#, 2
	note __, 2
	note A#, 2
	octave 3
	note C#, 2
	octave 2
	note A#, 2
	note __, 2
	note A#, 2
	octave 3
	note C#, 2
	note C#, 2
	octave 2
	note A#, 2
	note A#, 2
	octave 3
	note C#, 2
	note C#, 2
	endchannel

Music_LacunosaTown_Ch2:
	dutycycle 0
	notetype $C, $97
	octave 1
	note A#, 2
	octave 2
	note G#, 2
	octave 3
	note F_, 2
	octave 4
	note C#, 10
	octave 1
	note F_, 2
	octave 2
	note G#, 2
	octave 3
	note D#, 2
	octave 4
	note C_, 10
	octave 1
	note D#, 2
	octave 2
	note F_, 2
	octave 3
	note C#, 2
	note A#, 10
	octave 1
	note F_, 2
	octave 2
	note G#, 2
	octave 3
	note D#, 2
	octave 4
	note C_, 10
	note __, 2
	octave 3
	note A#, 4
	note __, 2
	note A#, 2
	note A#, 4
	note __, 4
	note G#, 4
	note __, 2
	note G#, 2
	note G#, 4
	note __, 4
	note A#, 4
	note __, 2
	note A#, 2
	note A#, 4
	note G#, 4
	note __, 2
	note G#, 4
	note __, 2
	note G#, 4
	note __, 4
	note A#, 4
	note __, 4
	note G#, 4
	note __, 4
	note G#, 4
	note __, 2
	note G#, 2
	octave 4
	note C#, 4
	octave 3
	note A#, 2
	note __, 2
	note A#, 4
	note __, 4
	note G#, 4
	note __, 4
	note G#, 4
	note __, 2
	note G#, 2
	note A#, 4
	note __, 4
	note A#, 4
	note __, 4
	note G#, 4
	note __, 4
	note G#, 4
	note __, 2
	note G#, 2
	octave 4
	note C#, 2
	note __, 2
	octave 3
	note A#, 2
	note __, 2
	note A#, 4
	note __, 4
	note G#, 4
	note __, 2
	note G#, 2
	note __, 2
	note G#, 4
	note __, 2
	octave 4
	intensity $B7
	note C_, 2
	note C#, 2
	note F_, 2
	note D#, 4
	note F_, 2
	octave 3
	note G#, 4
	octave 4
	note C#, 2
	note C_, 14
	note C_, 2
	note C#, 2
	note F_, 2
	note D#, 4
	note F_, 2
	octave 3
	note G#, 4
	octave 4
	note C#, 2
	note C_, 14
	note C_, 2
	note C#, 2
	note A#, 2
	note G#, 4
	note A#, 2
	note D#, 4
	note F_, 2
	note C_, 12
	note C#, 2
	note C_, 2
	note C#, 2
	note G#, 10
	notetype $6, $B7
	note __, 3
	note B_, 1
	notetype $C, $C7
	octave 5
	note C_, 4
	octave 4
	note G#, 12
	note __, 10
	intensity $97
	octave 3
	note F_, 4
	note __, 2
	note F_, 4
	note __, 6
	note F#, 4
	note __, 2
	note F#, 4
	note __, 6
	note F#, 4
	note __, 2
	note F#, 4
	note __, 6
	note F#, 4
	note __, 2
	note F#, 4
	note __, 6
	note F#, 4
	note __, 2
	note G#, 6
	note __, 2
	note D#, 6
	note __, 2
	note G#, 6
	note __, 2
	note F#, 6
	note G#, 2
	note G#, 2
	note __, 2
	note F_, 4
	note D#, 2
	note __, 2
	note D#, 2
	note __, 2
	note F_, 6
	loopchannel 0, Music_LacunosaTown_Ch2


Music_LacunosaTown_Ch3:
	stereopanning $ff
	notetype $C, $14
	vibrato $16, $25
	note __, 16
	note __, 16
	note __, 16
	note __, 16
	octave 2
	note A#, 2
	note __, 4
	note F_, 2
	note A#, 1
	note __, 1
	note A#, 2
	note __, 2
	note A#, 2
	note F_, 2
	note __, 4
	note C_, 2
	note F_, 1
	note __, 1
	note F_, 2
	note __, 2
	octave 3
	note C_, 2
	octave 2
	note D#, 2
	note __, 4
	note A#, 2
	note D#, 1
	note __, 1
	note D#, 2
	note __, 2
	note F_, 1
	note __, 1
	note F_, 2
	note __, 4
	note F_, 2
	octave 3
	note C_, 2
	note __, 4
	octave 2
	note F_, 2
	note F#, 2
	note __, 4
	note F#, 2
	note F_, 2
	note __, 4
	note F_, 2
	note A#, 2
	note __, 4
	note A#, 2
	note __, 2
	note A#, 2
	note __, 2
	note A#, 2
	note F#, 2
	note __, 4
	note F#, 2
	note F_, 2
	note __, 4
	note F_, 2
	note A#, 2
	note __, 2
	note A#, 2
	note __, 2
	note A#, 1
	note __, 1
	note A#, 2
	note __, 2
	note G#, 2
	note F#, 2
	note __, 4
	note F#, 2
	note F_, 2
	note __, 4
	note F_, 2
	note A#, 2
	note __, 4
	note A#, 2
	note __, 2
	note A#, 2
	note __, 2
	note A#, 2
	note F#, 2
	note __, 4
	note F#, 2
	note F_, 2
	note __, 4
	note F_, 2
	note A#, 2
	note __, 2
	note A#, 4
	note __, 2
	octave 1
	note A#, 2
	octave 2
	note A#, 4
	note F#, 6
	note F#, 3
	note __, 1
	note F#, 4
	note A#, 6
	note F_, 2
	note A#, 2
	note __, 2
	note A#, 2
	note G#, 4
	note F#, 6
	note F#, 3
	note __, 1
	note F#, 4
	octave 1
	note A#, 6
	octave 2
	note F_, 2
	note A#, 2
	note __, 2
	note F_, 2
	note G#, 4
	note F#, 6
	note F_, 8
	note A#, 6
	octave 1
	note A#, 2
	octave 2
	note F_, 3
	note __, 1
	note F_, 2
	note C#, 2
	note A#, 2
	note D#, 5
	note __, 1
	note D#, 4
	note A#, 4
	note D#, 2
	note G#, 5
	note __, 1
	note G#, 2
	note __, 2
	octave 1
	note G#, 2
	note __, 2
	note G#, 2
	octave 2
	note C#, 2
	note __, 4
	note C#, 1
	note __, 1
	note C#, 2
	note __, 4
	note C#, 2
	note G#, 2
	note __, 4
	note G#, 1
	note __, 1
	note G#, 2
	note __, 4
	note G#, 2
	note F#, 2
	note __, 4
	note F#, 2
	note C#, 2
	note __, 4
	note C#, 2
	note F#, 2
	note __, 4
	note F#, 2
	note G#, 2
	note __, 4
	note G#, 2
	note F#, 2
	note __, 4
	note F#, 2
	note G#, 2
	note __, 4
	note G#, 2
	note F_, 2
	note __, 4
	note F_, 2
	note A#, 2
	note __, 4
	note A#, 2
	note D#, 2
	note __, 4
	note D#, 2
	note G#, 1
	note __, 1
	note G#, 2
	note __, 4
	note C#, 2
	note __, 4
	note C#, 2
	note __, 2
	note C#, 2
	note __, 4
	loopchannel 0, Music_LacunosaTown_Ch3

Music_LacunosaTown_Ch4:
	togglenoise $3
	notetype $c
Music_LacunosaTown_Ch4_loop:
	note __, 16
	note __, 16
	note __, 16
	note __, 10
	note F#, 2
	note D_, 2
	note F#, 2
	callchannel Music_LacunosaTown_Ch4_branch_1
	callchannel Music_LacunosaTown_Ch4_branch_1
	callchannel Music_LacunosaTown_Ch4_branch_1
	callchannel Music_LacunosaTown_Ch4_branch_1
	callchannel Music_LacunosaTown_Ch4_branch_1
	callchannel Music_LacunosaTown_Ch4_branch_1
	callchannel Music_LacunosaTown_Ch4_branch_2
	callchannel Music_LacunosaTown_Ch4_branch_2
	callchannel Music_LacunosaTown_Ch4_branch_2
	callchannel Music_LacunosaTown_Ch4_branch_2
	callchannel Music_LacunosaTown_Ch4_branch_1
	callchannel Music_LacunosaTown_Ch4_branch_1
	callchannel Music_LacunosaTown_Ch4_branch_1
	note F#, 2
	note F#, 2
	note D_, 2
	note F#, 2
	note D_, 2
	note D_, 2
	note __, 4
	note F#, 2
	note F#, 2
	note D_, 2
	note F#, 2
	note __, 2
	note F#, 2
	note D_, 2
	note F#, 2
	loopchannel 0, Music_LacunosaTown_Ch4_loop

Music_LacunosaTown_Ch4_branch_1:
	note F#, 2
	note F#, 2
	note D_, 2
	note F#, 2
	loopchannel 4, Music_LacunosaTown_Ch4_branch_1
	endchannel

Music_LacunosaTown_Ch4_branch_2:
	note F#, 2
	note F#, 2
	note D_, 2
	note F#, 2
	note F#, 2
	note F#, 2
	note D_, 2
	note F#, 2
	note F#, 2
	note D_, 2
	note F#, 2
	note F#, 2
	note D_, 2
	note F#, 2
	note F#, 2
	note D_, 2
	endchannel
