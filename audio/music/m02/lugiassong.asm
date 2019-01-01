; Pokémon: The Movie 2000 - Lugia's Song
; Demixed by Mmmmmm
; https://pastebin.com/UikDn8qP

Music_LugiasSong2000:
	musicheader 4, 1, Music_LugiasSong2000_Ch1
	musicheader 1, 2, Music_LugiasSong2000_Ch2
	musicheader 1, 3, Music_LugiasSong2000_Ch3
	musicheader 1, 4, Music_LugiasSong2000_Ch4

Music_LugiasSong2000_NoIntro:
	musicheader 3, 1, Music_LugiasSong2000_Ch1_loop_main
	musicheader 1, 2, Music_LugiasSong2000_Ch2_loop_main
	musicheader 1, 3, Music_LugiasSong2000_Ch3_loop

Music_LugiasSong2000_Ch1:
	dutycycle $3
	vibrato $12, $15
	tone $0001
	tempo 136
	notetype $c, $60
Music_LugiasSong2000_Ch1_loop_1:
	note __, 8
	loopchannel 16, Music_LugiasSong2000_Ch1_loop_1
	note __, 8
	octave 2
	note E_, 16
	note D_, 16
	octave 1
	note A_, 12
	note B_, 4
	octave 2
	note C_, 4
	note D_, 2
	note C_, 2
	octave 1
	note B_, 4
	note A_, 4
	note E_, 16
	note D_, 16
	note C_, 16
	note C_, 12
	intensity $67
	note C_, 4
Music_LugiasSong2000_Ch1_loop_main:
	tempo 156
	endchannel

Music_LugiasSong2000_Ch2:
	dutycycle 0
	vibrato $12, $15
	tone $0001
	notetype $c, $10
Music_LugiasSong2000_Ch2_loop_1:
	note __, 16
	loopchannel 4, Music_LugiasSong2000_Ch2_loop_1
	octave 2
	note B_, 16
	note B_, 16
	intensity $20
	note B_, 16
	note B_, 4
	intensity $40
	note B_, 2
	octave 3
	intensity $50
	note G_, 2
	intensity $40
	note F#, 8
	intensity $4e
	note F#, 8
	intensity $a7
	octave 4
	note E_, 8
	note D_, 8
	octave 3
	note B_, 8
	note G_, 6
	intensity $a2
	note A_, 1
	note B_, 1
	intensity $a7
	note A_, 8
	intensity $a0
	note E_, 8
	intensity $a7
	note E_, 16
	intensity $a7
	note E_, 8
	note B_, 8
	note A_, 8
	note D_, 8
	intensity $60
	note E_, 16
	intensity $67
	note E_, 16
Music_LugiasSong2000_Ch2_loop_main:
	dutycycle 0
	notetype $c, $74
	octave 2
	note E_, 2
	intensity $57
	note G_, 2
	note B_, 2
	octave 3
	note E_, 4
	octave 2
	note B_, 2
	octave 3
	note E_, 4
	octave 2
	intensity $74
	note D_, 2
	intensity $57
	note F#, 2
	note A_, 2
	octave 3
	note E_, 4
	octave 2
	note A_, 2
	octave 3
	note D_, 4
	intensity $74
	octave 2
	note E_, 2
	intensity $57
	note G_, 2
	note B_, 2
	octave 3
	note E_, 4
	octave 2
	note B_, 2
	octave 3
	note E_, 4
	intensity $74
	octave 2
	note D_, 2
	intensity $57
	note F#, 2
	note A_, 2
	octave 3
	note E_, 4
	note D_, 6
	intensity $74
	octave 2
	note E_, 2
	intensity $57
	note G_, 2
	note B_, 2
	octave 3
	note E_, 4
	octave 2
	note B_, 2
	octave 3
	note E_, 4
	intensity $74
	octave 2
	note D_, 2
	intensity $57
	note F#, 2
	note A_, 2
	octave 3
	note E_, 4
	octave 2
	note A_, 2
	octave 3
	note D_, 4
	intensity $74
	octave 2
	note E_, 2
	intensity $57
	note G_, 2
	note B_, 2
	octave 3
	note E_, 4
	octave 2
	note B_, 2
	octave 3
	note E_, 4
	intensity $74
	note F#, 2
	octave 2
	intensity $57
	note F#, 2
	note A_, 2
	octave 3
	note E_, 2
	intensity $74
	octave 2
	note D_, 2
	intensity $57
	note A_, 2
	octave 3
	note D_, 4
	intensity $74
	octave 2
	note C_, 2
	intensity $57
	note E_, 2
	note G_, 2
	octave 3
	note E_, 4
	octave 2
	note G_, 2
	octave 3
	note E_, 4
	intensity $74
	octave 2
	note G_, 2
	intensity $57
	note B_, 2
	octave 3
	note D_, 2
	note G_, 4
	octave 2
	note G_, 2
	octave 3
	note D_, 4
	intensity $74
	octave 1
	note A_, 2
	intensity $57
	octave 2
	note E_, 2
	note A_, 2
	octave 3
	note C_, 4
	octave 2
	note E_, 2
	octave 3
	note D_, 4
	intensity $74
	octave 2
	note C_, 2
	intensity $57
	note E_, 2
	note G_, 2
	octave 3
	note G_, 4
	octave 2
	note E_, 2
	octave 3
	note C_, 4
	intensity $74
	octave 2
	note E_, 2
	intensity $57
	note G_, 2
	note B_, 2
	octave 3
	note E_, 4
	octave 2
	note B_, 2
	octave 3
	note E_, 4
	intensity $74
	octave 2
	note D_, 2
	intensity $57
	note F#, 2
	note A_, 2
	octave 3
	note E_, 2
	octave 2
	note D_, 2
	note A_, 2
	octave 3
	note D_, 4
	octave 2
	intensity $74
	note E_, 4
	intensity $57
	note B_, 2
	octave 3
	note G_, 2
	note F#, 2
	octave 2
	note B_, 2
	octave 3
	intensity $87
	note C_, 4
	note F#, 4
	note E_, 4
	note F#, 4
	note E_, 4
	loopchannel 0, Music_LugiasSong2000_Ch2_loop_main

Music_LugiasSong2000_Ch3:
	notetype $c, $23
	vibrato $8, $16
	callchannel Music_LugiasSong2000_Ch3_branch_1
	note B_, 8
	callchannel Music_LugiasSong2000_Ch3_branch_2
Music_LugiasSong2000_Ch3_loop:
	vibrato $8, $16
	notetype $c, $13
	callchannel Music_LugiasSong2000_Ch3_branch_1
	callchannel Music_LugiasSong2000_Ch3_branch_2
	note E_, 8
	note G_, 8
	note F#, 12
	note D_, 4
	note E_, 8
	octave 4
	note B_, 12
	note B_, 12
	octave 5
	note E_, 8
	note G_, 8
	note F#, 8
	octave 6
	note D_, 10
	notetype $6, $13
	note D_, 2
	octave 5
	note B_, 1
	octave 6
	note C_, 1
	octave 5
	note B_, 4
	note A_, 4
	notetype $c, $13
	note B_, 12
	note B_, 12
	callchannel Music_LugiasSong2000_Ch3_branch_2
	loopchannel 0, Music_LugiasSong2000_Ch3_loop

Music_LugiasSong2000_Ch3_branch_1:
	octave 5
	note E_, 8
	note G_, 8
	note F#, 12
	note D_, 4
	note E_, 8
	octave 4
	note B_, 12
	note B_, 12
	octave 5
	note E_, 8
	note G_, 8
	note F#, 12
	octave 4
	note B_, 4
	octave 5
	note E_, 4
	note G_, 4
	note B_, 12
	note B_, 12
	endchannel

Music_LugiasSong2000_Ch3_branch_2:
	notetype $6, $13
	octave 6
	note E_, 16
	note D_, 14
	note E_, 1
	note D_, 1
	octave 5
	note B_, 16
	note G_, 12
	note A_, 2
	note B_, 2
	notetype $c, $13
	note A_, 8
	note E_, 12
	note E_, 12
	notetype $6, $13
	note E_, 14
	note B_, 1
	octave 6
	note C_, 1
	octave 5
	note B_, 16
	note A_, 16
	note D_, 16
	note F#, 6
	note G_, 1
	note F#, 1
	note E_, 4
	note D_, 4
	notetype $c, $13
	note E_, 12
	note E_, 6
	intensity $23
	note E_, 6
	intensity $13
	endchannel

Music_LugiasSong2000_Ch4:
	togglenoise $3
	notetype $c
Music_LugiasSong2000_Ch4_loop_1:
	note __, 16
	loopchannel 8, Music_LugiasSong2000_Ch4_loop_1
	notetype $6
	note C#, 2
	note C#, 2
	note C#, 2
	note C#, 2
	note D_, 1
	note D_, 1
	note D_, 1
	note D_, 1
	note D_, 1
	note D_, 1
	note D_, 1
	note D_, 1
	notetype $c
	note B_, 16
	note C_, 8
	note C_, 8
	note B_, 16
	note C_, 8
	note C_, 8
	note B_, 16
	endchannel
