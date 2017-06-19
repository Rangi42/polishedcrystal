; Pokémon B/W - Black City
; Demixed by Mmmmmm
; https://pastebin.com/bqcvjdFi
; https://hax.iimarck.us/topic/6777/9/

Music_BlackCityBW:
	musicheader 4, 1, Music_BlackCityBW_Ch1
	musicheader 1, 2, Music_BlackCityBW_Ch2
	musicheader 1, 3, Music_BlackCityBW_Ch3
	musicheader 1, 4, Music_BlackCityBW_Ch4

Music_BlackCityBW_Ch1:
	vibrato $12, $15
	tone $0001
	notetype $6, $91
	tempo 156
	note __, 4
Music_BlackCityBW_Ch1_loop:
	callchannel Music_BlackCityBW_Ch1_branch_1
	octave 4
	dutycycle 1
	intensity $54
	note F#, 1
	intensity $74
	note G_, 1
	intensity $94
	note A#, 2
	note F#, 2
	note G_, 2
	note D#, 2
	note E_, 2
	note C_, 2
	note C#, 2
	octave 3
	note A#, 2
	dutycycle 0
	intensity $b1
	callchannel Music_BlackCityBW_Ch1_branch_1
	note __, 2
	dutycycle 1
	intensity $94
	note E_, 2
	note F#, 2
	note G_, 2
	note B_, 2
	octave 4
	note E_, 2
	note F#, 2
	note G_, 2
	note B_, 2 ;;;;; halfway point
	dutycycle 0
	intensity $91
	note D_, 4
	octave 3
	note F_, 4
	octave 4
	note D_, 4
	octave 3
	note F_, 4
	octave 4
	note D_, 4
	octave 3
	note F_, 4
	octave 4
	note D_, 4
	octave 3
	note F_, 4
	octave 4
	note C_, 4
	octave 3
	note F_, 4
	octave 4
	note C_, 4
	octave 3
	note F_, 4
	octave 4
	note C_, 4
	octave 3
	note F_, 4
	octave 4
	note C_, 4
	octave 3
	note F_, 4
	octave 4
	note C_, 4
	octave 3
	note C_, 4
	octave 4
	note C_, 4
	octave 3
	note C_, 4
	octave 4
	note C_, 4
	octave 3
	note C_, 4
	octave 4
	note C_, 4
	octave 3
	note C_, 4
	note A#, 4
	note C_, 4
	note A#, 4
	note C_, 4
	octave 4
	note C#, 4
	octave 3
	note C_, 4
	octave 4
	note C#, 4
	octave 3
	note C_, 4
	note B_, 4
	note D_, 4
	note B_, 4
	note D_, 4
	note B_, 4
	note D_, 4
	note B_, 4
	note D_, 4
	note A#, 4
	note C_, 4
	note A#, 4
	note C_, 4
	octave 4
	note C_, 4
	octave 3
	note C_, 4
	octave 4
	note C_, 4
	octave 3
	note C_, 4
	note G_, 4
	note C_, 4
	note G_, 4
	note C_, 4
	note G_, 4
	note C_, 4
	note G_, 4
	note C_, 4
	note G#, 4
	note C_, 4
	note G#, 4
	note C_, 4
	note G_, 4
	octave 2
	note B_, 4
	octave 3
	note G_, 4
	octave 2
	note B_, 4
	loopchannel 0, Music_BlackCityBW_Ch1_loop

Music_BlackCityBW_Ch1_branch_1:
	octave 4
	note E_, 2
	octave 3
	intensity $71
	note G_, 2
	intensity $b1
	note G_, 4
	octave 4
	note E_, 2
	octave 3
	intensity $71
	note G_, 2
	intensity $b1
	note G_, 4
	octave 4
	note E_, 2
	octave 3
	intensity $71
	note G_, 2
	intensity $b1
	note G_, 4
	octave 4
	note E_, 2
	octave 3
	intensity $71
	note G_, 2
	intensity $b1
	note G_, 4
	octave 4
	note D#, 2
	octave 3
	intensity $71
	note G_, 2
	intensity $b1
	note G_, 4
	octave 4
	note D#, 2
	octave 3
	intensity $71
	note G_, 2
	intensity $b1
	note G_, 4
	octave 4
	note D#, 2
	octave 3
	intensity $71
	note G_, 2
	intensity $b1
	note G_, 4
	octave 4
	note D#, 2
	octave 3
	intensity $71
	note G_, 2
	intensity $b1
	note G_, 4
	octave 4
	note D_, 2
	octave 3
	intensity $71
	note G_, 2
	intensity $b1
	note G_, 4
	octave 4
	note D_, 2
	octave 3
	intensity $71
	note G_, 2
	intensity $b1
	note G_, 4
	octave 4
	note D_, 2
	octave 3
	intensity $71
	note G_, 2
	intensity $b1
	note G_, 4
	octave 4
	note D_, 2
	octave 3
	intensity $71
	note G_, 2
	intensity $b1
	note G_, 4
	octave 4
	note C#, 2
	octave 3
	intensity $71
	note G_, 2
	intensity $b1
	note G_, 4
	octave 4
	note C#, 2
	octave 3
	intensity $71
	note G_, 2
	intensity $b1
	note G_, 2
	endchannel

Music_BlackCityBW_Ch2:
	dutycycle 2
	vibrato $12, $24
	tone $0001
	notetype $6, $a7
	octave 3
	note __, 1
	note G#, 1
	note A_, 1
	note A#, 1
	note B_, 12
	octave 4
	note E_, 12
	note C_, 8
	note D#, 12
	note C_, 12
	note D_, 4
	note C#, 2
	note C_, 2
	octave 3
	note B_, 16
	note __, 8
	note A_, 4
	note B_, 2
	octave 4
	note C_, 2
	octave 3
	note B_, 14
	octave 4
	dutycycle 0
	intensity $54
	note C_, 1
	intensity $74
	note C#, 1
	intensity $94
	note D#, 2
	note C_, 2
	note C#, 2
	octave 3
	note A_, 2
	note A#, 2
	note F#, 3
	intensity $a7
	dutycycle 2
	octave 3
	note G#, 1
	note A_, 1
	note A#, 1
	note B_, 12
	octave 4
	note E_, 12
	note C_, 8
	note D#, 12
	note C_, 12
	note D_, 4
	note C#, 2
	note C_, 2
	octave 3
	note B_, 16
	note __, 8
	note A_, 4
	note B_, 2
	octave 4
	note C_, 2
	octave 3
	note B_, 16
	dutycycle 0
	intensity $94
	octave 2
	note B_, 2
	octave 3
	note D_, 2
	note E_, 2
	note F#, 2
	note B_, 2
	octave 4
	note D_, 2
	note E_, 2
	note F#, 2
	dutycycle 1
	intensity $b7
	vibrato $10, $44
	note A_, 12
	note G_, 12
	octave 5
	note C_, 8
	octave 4
	note G_, 12
	intensity $b0
	note F_, 4
	intensity $b7
	note F_, 16
	note F_, 12
	note D#, 12
	octave 5
	note C_, 8
	octave 4
	note F_, 12
	intensity $b0
	note D#, 4
	intensity $b7
	note D#, 16
	note D#, 12
	note D_, 12
	note A#, 8
	intensity $b0
	note D_, 4
	intensity $b7
	note D_, 12
	intensity $b0
	note D#, 4
	intensity $b7
	note D#, 12
	intensity $b0
	note C_, 16
	intensity $b7
	note C_, 16
	intensity $b0
	note F_, 2
	intensity $b7
	note F_, 10
	note D#, 2
	note F_, 2
	intensity $b0
	note G_, 2
	intensity $b7
	note G_, 10
	loopchannel 0, Music_BlackCityBW_Ch2

Music_BlackCityBW_Ch3:
	notetype $c, $24
	note __, 2
Music_BlackCityBW_Ch3_loop:
	octave 4
	note E_, 16
	note D#, 16
	note D_, 16
	note C#, 16
	note E_, 16
	note D#, 16
	note D_, 16
	note C#, 16
	note D_, 16
	note C_, 8
	note F_, 8
	note C_, 16
	octave 3
	note A#, 8
	octave 4
	note C#, 8
	octave 3
	note B_, 16
	note A#, 8
	octave 4
	note C_, 8
	octave 3
	note G#, 16
	octave 4
	note C_, 8
	octave 3
	note B_, 8
	loopchannel 0, Music_BlackCityBW_Ch3_loop

Music_BlackCityBW_Ch4:
	togglenoise $3
	notetype $6
	note __, 4
Music_BlackCityBW_Ch4_loop_main:
Music_BlackCityBW_Ch4_loop_1:
	note B_, 6
	note C_, 6
	note D#, 4
	note D_, 4
	note D#, 4
	note C_, 4
	note D_, 4
	note D#, 2
	note D#, 2
	note D_, 4
	note C_, 4
	note D_, 4
	note C#, 2
	note C_, 6
	note C_, 4
	note D_, 4
	note D#, 2
	note D#, 2
	note D_, 2
	note C_, 6
	note D#, 4
	note D_, 4
	note D#, 4
	note C_, 4
	note D#, 4
	note D_, 2
	note D_, 2
	note D#, 2
	note C_, 6
	note D#, 4
	note D#, 2
	note C_, 4
	note D#, 2
	note C_, 2
	note C_, 2
	note D#, 4
	loopchannel 2, Music_BlackCityBW_Ch4_loop_1
	callchannel Music_BlackCityBW_Ch4_branch_1
	note D#, 4
	note D_, 4
	note D#, 4
	note D_, 4
	note D#, 2
	note C_, 6
	note C_, 4
	note C_, 2
	note C_, 2
	callchannel Music_BlackCityBW_Ch4_branch_1
	note D#, 2
	note D#, 2
	note D_, 4
	note C_, 4
	note D_, 4
	note D#, 2
	note C_, 6
	note C_, 2
	note C_, 2
	note D#, 1
	note D#, 1
	note D#, 1
	note D#, 1
	loopchannel 0, Music_BlackCityBW_Ch4_loop_main

Music_BlackCityBW_Ch4_branch_1:
	note B_, 8
	note D#, 4
	note D_, 4
	note D#, 2
	note C_, 6
	note C_, 4
	note D#, 4
	note D_, 4
	note D#, 4
	note D_, 4
	note D#, 4
	note D#, 2
	note C_, 6
	note C_, 4
	note D#, 4
	note D_, 4
	note D#, 4
	note D_, 4
	note D#, 4
	note D#, 2
	note C_, 6
	note C_, 4
	note D#, 2
	note D#, 2
	endchannel
