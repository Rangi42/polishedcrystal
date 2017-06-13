; Pokémon White 2 - Reversal Mountain
; Demixed by Mmmmmm
; https://pastebin.com/mUzX8S44
; https://hax.iimarck.us/topic/6777/2/

Music_ReversalMountainWhite2:
	musicheader 4, 1, Music_ReversalMountainWhite2_Ch1
	musicheader 1, 2, Music_ReversalMountainWhite2_Ch2
	musicheader 1, 3, Music_ReversalMountainWhite2_Ch3
	musicheader 1, 4, Music_ReversalMountainWhite2_Ch4

Music_ReversalMountainWhite2_Ch1:
	tempo 176
	volume $77
	dutycycle $2
	tone $0002
	vibrato $10, $22
	notetype $c, $62
	note __, 1
	callchannel Music_ReversalMountainWhite2_Ch1_branch_1
Music_ReversalMountainWhite2_Ch1_loop:
	octave 4
	note C_, 2
	callchannel Music_ReversalMountainWhite2_Ch1_branch_1
	dutycycle $0
	notetype $6, $94
	octave 3
	note G_, 4
	note __, 2
	note G_, 4
	note __, 10
	intensity $90
	note G_, 6
	intensity $97
	note G_, 6
	intensity $94
	note F#, 6
	intensity $96
	note F#, 4
	note __, 10
	intensity $90
	note F#, 6
	intensity $97
	note F#, 6
	intensity $94
	note G_, 4
	note __, 2
	note G_, 4
	note __, 10
	intensity $90
	note G_, 2
	intensity $94
	note G_, 4
	intensity $90
	note G_, 2
	intensity $94
	note G_, 4
	intensity $94
	note A_, 4
	note __, 2
	note A_, 4
	note __, 10
	intensity $90
	note F#, 2
	intensity $94
	note F#, 4
	intensity $90
	note F#, 2
	intensity $94
	note F#, 4
	intensity $90
	note F_, 2
	intensity $94
	note F_, 4
	;;;;;;;;;;;;;;;
	note F_, 4
	note __, 10
	intensity $90
	note F_, 2
	intensity $94
	note F_, 4
	intensity $90
	note A_, 2
	intensity $94
	note A_, 4
	;;;;;;;;;;;
	note G_, 4
	note __, 2
	note G_, 4
	note __, 10
	note G_, 4
	note __, 2
	note G_, 4
	note __, 2
	note A_, 4
	note __, 2
	note A_, 4
	note __, 10
	intensity $90
	note G_, 6
	intensity $97
	note G_, 6
	intensity $94
	note F#, 4
	note __, 2
	note F#, 4
	note __, 10
	intensity $90
	note D_, 2
	intensity $94
	note D_, 4
	intensity $90
	note C#, 2
	intensity $94
	note C#, 4
;;;;;;;;;;;;;;;;mark
	intensity $90
	note C_, 16
	intensity $97
	note C_, 16
	octave 2
	intensity $90
	note A_, 8
	intensity $97
	note A_, 8
	octave 3
	intensity $90
	note D_, 8
	intensity $97
	note D_, 8
	intensity $90
	note C_, 8
	intensity $97
	note C_, 8
	intensity $90
	note E_, 8
	intensity $97
	note E_, 8
	intensity $90
	note D_, 16
	intensity $97
	note D_, 8
	intensity $a4
	note D_, 2
	note E_, 4
	note E_, 2
;;;;;;;;;;;;;;;mark
	note F_, 4
	note __, 2
	note F_, 4
	note __, 10
	note F_, 4
	note __, 2
	intensity $a0
	note F_, 2
	intensity $a4
	note F_, 4
	note E_, 4
	note __, 2
	note E_, 4
	note __, 10
	note E_, 4
	note __, 2
	intensity $a0
	note E_, 2
	intensity $a4
	note E_, 4
	note A_, 4
	note __, 2
	note A_, 4
	note __, 10
	note A_, 4
	note __, 2
	intensity $a0
	note A_, 2
	intensity $a4
	note A_, 4
	intensity $a0
	note B_, 10
	intensity $a7
	note B_, 6
	intensity $a0
	note A#, 10
	intensity $a7
	note A#, 6
	intensity $a4
	note A_, 4
	note __, 2
	note A_, 4
	note __, 10
	intensity $a0
	note F_, 6
	intensity $a7
	note F_, 6
	intensity $a4
	note B_, 4
	note __, 2
	note B_, 4
	note __, 10
	intensity $a0
	note G_, 6
	notetype $3, $c0
	dutycycle 2
	octave 4
	note E_, 3
	note G#, 1
	note A_, 4
	note G_, 8
	intensity $90
	note G_, 4
	intensity $30
	note G_, 4
	intensity $c0
	note G#, 4
	note A_, 4
	note C_, 4
	intensity $90
	note C_, 4
	intensity $c0
	note D_, 4
	note E_, 16
	note F_, 14
	note __, 2
	note G_, 3
	note __, 1
	note G_, 4
	intensity $30
	note G_, 4
	note __, 12
	intensity $c0
	note G_, 3
	note __, 1
	note G_, 4
	intensity $30
	note G_, 4
	note __, 4
	notetype $6, $a4
	dutycycle 0
	octave 3
	note B_, 2
	note B_, 2
	note __, 8
	intensity $a7
	note A_, 16
	dutycycle 2
	notetype $c, $62
	note __, 2
	octave 4
	note A_, 2
	octave 5
	note C_, 2
	octave 4
	note G_, 2
	note E_, 2
	note D_, 2
	note G_, 2
	note E_, 2
	note C_, 2
	note D_, 2
	note C_, 2
	octave 3
	note A_, 2
	loopchannel 0, Music_ReversalMountainWhite2_Ch1_loop

Music_ReversalMountainWhite2_Ch1_branch_1:
	octave 4
	note D_, 2
	note G_, 2
	note E_, 2
	note G_, 2
	note A_, 2
	octave 5
	note C_, 2
	octave 4
	note G_, 2
	note E_, 2
	note D_, 2
	note G_, 2
	note E_, 2
	note C_, 2
	note D_, 2
	note C_, 2
	octave 3
	note A_, 2
	endchannel

Music_ReversalMountainWhite2_Ch2:
	dutycycle $3
	vibrato $1c, $12
	notetype $c, $62
	callchannel Music_ReversalMountainWhite2_Ch1_branch_1
Music_ReversalMountainWhite2_Ch2_loop:
	octave 4
	note C_, 2
	callchannel Music_ReversalMountainWhite2_Ch1_branch_1
	octave 4
	note C_, 1
	dutycycle $0
	notetype $6, $94
	octave 3
	note C_, 4
	note __, 2
	note C_, 4
	note __, 10
	intensity $90
	note C_, 6
	intensity $97
	note C_, 6
	intensity $94
	note D_, 6
	intensity $96
	note D_, 4
	note __, 10
	intensity $90
	note D_, 6
	intensity $97
	note D_, 6
	intensity $94
	note C_, 4
	note __, 2
	note C_, 4
	note __, 10
	intensity $90
	note C_, 2
	intensity $94
	note C_, 4
	intensity $90
	note C_, 2
	intensity $94
	note C_, 4
	intensity $94
	note F#, 4
	note __, 2
	note F#, 4
	note __, 10
	intensity $90
	note D_, 2
	intensity $94
	note D_, 4
	intensity $90
	note D_, 2
	intensity $94
	note D_, 4
	intensity $90
	note D_, 2
	intensity $94
	note D_, 4
	;;;;;;;;;;;;;;;
	note D_, 4
	note __, 10
	intensity $90
	note C_, 2
	intensity $94
	note C_, 4
	intensity $90
	note F_, 2
	intensity $94
	note F_, 4
	;;;;;;;;;;;;
	note E_, 4
	note __, 2
	note E_, 4
	note __, 10
	note D_, 4
	note __, 2
	note D_, 4
	note __, 2
	note G_, 4
	note __, 2
	note G_, 4
	note __, 10
	intensity $90
	note C_, 6
	intensity $97
	note C_, 6
	intensity $94
	note D_, 4
	note __, 2
	note D_, 4
	note __, 10
	octave 2
	intensity $90
	note A_, 2
	intensity $94
	note A_, 4
	intensity $90
	note G#, 2
	intensity $94
	note G#, 4
;;;;;;;;;;;;;;;;mark
	intensity $90
	note G_, 16
	intensity $97
	note G_, 16
	intensity $90
	note F#, 8
	intensity $97
	note F#, 8
	intensity $90
	note A_, 8
	intensity $97
	note A_, 8
	intensity $90
	note G_, 8
	intensity $97
	note G_, 8
	octave 3
	intensity $90
	note C_, 8
	intensity $97
	note C_, 8
	intensity $90
	octave 2
	note A_, 16
	intensity $97
	note A_, 8
	intensity $a4
	note A_, 2
	note B_, 4
	note B_, 2
;;;;;;;;;;;;;;;mark
	octave 3
	note D_, 4
	note __, 2
	note D_, 4
	note __, 10
	note D_, 4
	note __, 2
	intensity $a0
	note D_, 2
	intensity $a4
	note D_, 4
	note C_, 4
	note __, 2
	note C_, 4
	note __, 10
	note C_, 4
	note __, 2
	intensity $a0
	note C_, 2
	intensity $a4
	note C_, 4
	note F_, 4
	note __, 2
	note F_, 4
	note __, 10
	note F_, 4
	note __, 2
	intensity $a0
	note F_, 2
	intensity $a4
	note F_, 4
	intensity $b4
	octave 2
	note E_, 2
	note __, 2
	octave 3
	note E_, 2
	octave 2
	note E_, 2
	note __, 2
	intensity $b5
	note E_, 6
	intensity $b4
	note D#, 2
	note __, 2
	octave 3
	note D#, 2
	octave 2
	note D#, 2
	note __, 2
	intensity $b5
	note D#, 6
	octave 3
	intensity $a4
	note F_, 4
	note __, 2
	note F_, 4
	note __, 10
	intensity $a0
	note C_, 6
	intensity $a7
	note C_, 6
	intensity $a4
	note G_, 4
	note __, 2
	note G_, 4
	note __, 10
	intensity $a0
	note D_, 6
	intensity $a7
	note D_, 6
	octave 4
	intensity $a4
	note C_, 4
	note __, 2
	note C_, 4
	note __, 10
	octave 3
	intensity $a7
	note A_, 6
	octave 4
	note C_, 6
	intensity $a4
	note C_, 2
	note C_, 2
	note __, 8
	note C_, 2
	note C_, 2
	note __, 4
	note D_, 2
	note D_, 2
	note __, 8
	intensity $a7
	note C_, 16
	notetype $c, $62
	note __, 1
	dutycycle 3
	note A_, 2
	octave 5
	note C_, 2
	octave 4
	note G_, 2
	note E_, 2
	note D_, 2
	note G_, 2
	note E_, 2
	note C_, 2
	note D_, 2
	note C_, 2
	octave 3
	note A_, 2
	loopchannel 0, Music_ReversalMountainWhite2_Ch2_loop

Music_ReversalMountainWhite2_Ch3:
	stereopanning $f0
	notetype $c, $14
	note __, 16
	note __, 16
	note __, 16
	note __, 16
	note __, 4
Music_ReversalMountainWhite2_Ch3_loop:
	note __, 8
	octave 4
	notetype $3, $14
	note G_, 4
	note A_, 4
	note G_, 4
	octave 5
	note D_, 12
	note E_, 8
	note __, 3
	note G_, 1
	note A_, 4
	note G_, 8
	note F_, 4
	note E_, 4
	note F_, 4
	note G_, 8
	note D_, 4
	note E_, 4
	note __, 3
	octave 4
	note G#, 1
	note A_, 4
	notetype $c, $14
	octave 5
	note C_, 4
	intensity $24
	note C_, 3
	notetype $3, $34
	note C_, 3
	intensity $15
	note C#, 1
	note D_, 4
	note C_, 4
	intensity $25
	note C_, 4
	intensity $15
	octave 4
	note E_, 4
	note G_, 12
	note D_, 4
	note E_, 4
	note A_, 4
	note F#, 1
	note G_, 3
	note F#, 4
	note E_, 4
	note D_, 4
	intensity $25
	note D_, 4
	intensity $15
	octave 3
	note A_, 4
	octave 4
	note D_, 4
	note E_, 4
	note F#, 4
	note G_, 4
	note A_, 4
	notetype $c, $15
	octave 5
	note D_, 4
	intensity $25
	note D_, 3
	notetype $3, $35
	note D_, 3
	intensity $14
	note D#, 1
	note E_, 4
	note D_, 8
	note C_, 4
	octave 4
	note B_, 4
	note A_, 4
	intensity $24
	note A_, 4
	intensity $14
	note G_, 4
	note A_, 4
	note G_, 4
	octave 5
	note C#, 1
	note D_, 11
	note E_, 4
	intensity $24
	note E_, 4
	intensity $34
	note E_, 4
	intensity $14
	note A_, 4
	note G_, 7
	note E_, 1
	note F_, 4
	note E_, 4
	note F_, 3
	note F#, 1
	note G_, 8
	note D_, 4
	note E_, 4
	note __, 4
	octave 4
	note G_, 4
	notetype $c, $14
	octave 5
	note C_, 3
	intensity $24
	note C_, 2
	notetype $3, $34
	note C_, 3
	intensity $15
	octave 4
	note D#, 1
	note E_, 4
	note B_, 4
	note A_, 4
	intensity $25
	note A_, 4
	intensity $15
	note C_, 4
	note E_, 8
	intensity $25
	note E_, 4
	intensity $35
	note E_, 3
	octave 3
	intensity $15
	note D#, 1
	note E_, 4
	octave 4
	note D#, 4
	note D_, 4
	note C#, 4
	note C_, 4
	note D_, 4
	note E_, 4
	octave 3
	note A_, 8
	octave 4
	note C_, 4
	note D_, 4
	note D#, 4
	note E_, 4
	note A_, 4
	notetype $c, $15
	note A_, 4
	intensity $25
	note A_, 5
	intensity $35
	note A_, 2
	notetype $3, $15
	note __, 7
	octave 3
	note B_, 1
	octave 4
	note C_, 4
	note E_, 4
	note A_, 4
	note B_, 4
	octave 5
	note C_, 4
	note D_, 4
	note D#, 8
	intensity $35
	note D#, 3
	intensity $15
	note C#, 1
	note D_, 4
	note C_, 4
	note D_, 4
	octave 4
	note E_, 4
	note G_, 4
	note A_, 8
	note G#, 4
	note G_, 4
	note F#, 4
	note F_, 4
	note E_, 4
	intensity $25
	note E_, 4
	octave 3
	intensity $15
	note G#, 3
	octave 4
	note C#, 1
	note D_, 4
	note C_, 16
	intensity $25
	note C_, 8
	intensity $35
	note C_, 8
	intensity $15
	octave 2
	note G#, 4
	note A_, 3
	octave 3
	note D#, 1
	note E_, 8
	note G_, 4
	note G#, 4
	intensity $15
	note A_, 16
	intensity $25
	note A_, 7
	intensity $15
	octave 4
	note C#, 1
	note D_, 4
	note C_, 16
	intensity $25
	note C_, 16
	intensity $35
	note C_, 8
	note __, 11
	intensity $27
	octave 3
	note G#, 1
	note A_, 4
	octave 4
	note D_, 4
	note C_, 4
	octave 3
	note A_, 4
	octave 4
	note D_, 4
	note E_, 4
	note G_, 4
	note G#, 4
	note A_, 4
	intensity $37
	note A_, 3
	intensity $27
	note G#, 1
	note A_, 4
	intensity $37
	note A_, 4
	intensity $27
	note G#, 3
	note __, 1
	note G#, 4
	intensity $37
	note G#, 4
	intensity $27
	note G_, 3
	note __, 1
	note G_, 4
	intensity $37
	note G_, 3
	intensity $27
	note F#, 1
	note G_, 4
	note G#, 4
	note A_, 4
	note C_, 4
	note C#, 4
	note D_, 4
	octave 3
	note A_, 4
	intensity $37
	note A_, 4
	intensity $27
	octave 4
	note C_, 3
	note D#, 1
	note E_, 4
	note D#, 4
	note D_, 4
	note C_, 4
	note C#, 4
	note D_, 4
	note E_, 4
	note G_, 4
	note A_, 4
	octave 5
	note C_, 4
	intensity $37
	note C_, 4
	intensity $27
	note E_, 3
	note G#, 1
	note A_, 4
	note G_, 8
	note A_, 4
	octave 6
	note C_, 4
	octave 5
	note G_, 4
	note A_, 4
	note C_, 3
	note D#, 1
	note E_, 4
	note D#, 8
	intensity $37
	note D#, 4
	intensity $27
	note D_, 4
	note G_, 4
	note A_, 4
	note D#, 4
	note D_, 4
	note C#, 4
	note C_, 8
	intensity $37
	note C_, 4
	intensity $15
	octave 4
	note G_, 3
	note G#, 1
	note A_, 4
	note G_, 4
	octave 5
	note C_, 4
	note E_, 8
	note D#, 4
	note D_, 4
	note C#, 4
	note C_, 3
	octave 4
	note D#, 1
	note E_, 4
	note A_, 4
	note G_, 8
	intensity $25
	note G_, 4
	intensity $35
	note G_, 4
	intensity $15
	note G_, 4
	note A_, 4
	note G_, 4
	octave 5
	note C_, 4
	note E_, 8
	note D#, 4
	note D_, 4
	note C#, 4
	note C_, 4
	intensity $14
	note C_, 4
	note F_, 4
	note E_, 8
	intensity $24
	note E_, 4
	intensity $34
	note E_, 4
	intensity $14
	note E_, 4
	note F_, 4
	octave 4
	note G_, 4
	intensity $24
	note G_, 4
	intensity $14
	note A_, 4
	octave 5
	note C_, 16
	note D_, 14
	note __, 2
	note D_, 3
	note __, 1
	note D_, 4
	intensity $34
	note D_, 4
	note __, 12
	intensity $14
	note D_, 3
	note __, 1
	note D_, 4
	intensity $34
	note D_, 4
	intensity $14
	octave 4
	note G_, 4
	note G#, 4
	note A_, 4
	octave 5
	note C_, 4
	note E_, 4
	note G_, 4
	octave 6
	note C_, 4
	octave 5
	note G_, 2
	note A_, 2
	note B_, 12
	intensity $24
	note B_, 8
	intensity $14
	note G_, 16
	intensity $24
	note G_, 16
	intensity $34
	note G_, 16
	notetype $c, $25
	note __, 11
	octave 2
	note E_, 1
	note __, 1
	note E_, 1
	note A_, 1
	intensity $35
	note A_, 1
	note __, 1
	intensity $25
	note A_, 1
	intensity $35
	note A_, 1
	intensity $25
	note __, 16
	note __, 8
	note E_, 1
	note __, 1
	note E_, 1
	note A_, 1
	intensity $35
	note A_, 1
	note __, 1
	intensity $25
	note A_, 1
	intensity $35
	note A_, 1
	loopchannel 0, Music_ReversalMountainWhite2_Ch3_loop

Music_ReversalMountainWhite2_Ch4:
	stereopanning $f
	togglenoise $3
	notetype $c
	note __, 16
	note __, 16
	note __, 16
	note __, 15
Music_ReversalMountainWhite2_Ch4_loop:
	callchannel Music_ReversalMountainWhite2_Ch4_branch_1
	callchannel Music_ReversalMountainWhite2_Ch4_branch_1
	callchannel Music_ReversalMountainWhite2_Ch4_branch_1
	callchannel Music_ReversalMountainWhite2_Ch4_branch_2
	callchannel Music_ReversalMountainWhite2_Ch4_branch_1
	callchannel Music_ReversalMountainWhite2_Ch4_branch_1
	callchannel Music_ReversalMountainWhite2_Ch4_branch_1
	callchannel Music_ReversalMountainWhite2_Ch4_branch_2
	callchannel Music_ReversalMountainWhite2_Ch4_branch_2
	callchannel Music_ReversalMountainWhite2_Ch4_branch_1
	callchannel Music_ReversalMountainWhite2_Ch4_branch_2
	callchannel Music_ReversalMountainWhite2_Ch4_branch_1
	callchannel Music_ReversalMountainWhite2_Ch4_branch_1
	callchannel Music_ReversalMountainWhite2_Ch4_branch_1
	callchannel Music_ReversalMountainWhite2_Ch4_branch_1
	callchannel Music_ReversalMountainWhite2_Ch4_branch_2
	note __, 16
	note __, 16
	note __, 16
	note __, 16
	callchannel Music_ReversalMountainWhite2_Ch4_branch_2
	callchannel Music_ReversalMountainWhite2_Ch4_branch_1
	callchannel Music_ReversalMountainWhite2_Ch4_branch_2
	callchannel Music_ReversalMountainWhite2_Ch4_branch_1
	callchannel Music_ReversalMountainWhite2_Ch4_branch_2
	callchannel Music_ReversalMountainWhite2_Ch4_branch_1
	callchannel Music_ReversalMountainWhite2_Ch4_branch_1
	callchannel Music_ReversalMountainWhite2_Ch4_branch_1
	callchannel Music_ReversalMountainWhite2_Ch4_branch_2
	callchannel Music_ReversalMountainWhite2_Ch4_branch_1
	callchannel Music_ReversalMountainWhite2_Ch4_branch_2
	callchannel Music_ReversalMountainWhite2_Ch4_branch_1
	callchannel Music_ReversalMountainWhite2_Ch4_branch_2
	callchannel Music_ReversalMountainWhite2_Ch4_branch_1
	callchannel Music_ReversalMountainWhite2_Ch4_branch_1
	callchannel Music_ReversalMountainWhite2_Ch4_branch_1
	note D#, 3
	note D#, 2
	note __, 11
	note __, 16
	note __, 16
	note __, 16
	loopchannel 0, Music_ReversalMountainWhite2_Ch4_loop

Music_ReversalMountainWhite2_Ch4_branch_1:
	note D#, 2
	note D#, 1
	note D#, 2
	note C_, 3
	endchannel

Music_ReversalMountainWhite2_Ch4_branch_2:
	note D#, 3
	note D#, 2
	note C_, 3
	endchannel

Music_ReversalMountainWhite2_Ch4_branch_3:
	note D#, 4
	note C_, 4
	endchannel
