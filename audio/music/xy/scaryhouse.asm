; Pokémon X/Y - Scary House
; Demixed by Mmmmmm
; https://pastebin.com/Ycw1DGh3
; https://hax.iimarckus.org/topic/6777/9/

Music_ScaryHouseXY:
	musicheader 3, 1, Music_ScaryHouseXY_Ch1
	musicheader 1, 2, Music_ScaryHouseXY_Ch2
	musicheader 1, 3, Music_ScaryHouseXY_Ch3

Music_ScaryHouseXY_Ch1:
	vibrato $12, $15
	tone $0003
	notetype $6, $37
	dutycycle 2
	tempo 188
	octave 4
	note __, 1
	note B_, 4
	note E_, 4
	note B_, 4
	note E_, 4
	octave 5
	note C_, 4
	octave 4
	note E_, 4
	note B_, 4
	note E_, 4
	note A#, 4
	intensity $47
	note E_, 4
	note A#, 4
	note E_, 4
	note B_, 4
	note E_, 4
	note B_, 4
	intensity $57
	note E_, 4
	octave 5
	note C_, 4
	octave 4
	note E_, 4
	note B_, 4
	note E_, 4
	note A#, 15
	dutycycle 1
	tone $0003
Music_ScaryHouseXY_Ch1_loop_main:
	intensity $75
	octave 3
	note E_, 8
	note F#, 8
	note G_, 8
	note A_, 8
	intensity $55
	note A_, 8
	intensity $45
	note A_, 8
	intensity $35
	note A_, 8
	intensity $75
	note E_, 4
	note F#, 4
	note G_, 8
	note A_, 8
	intensity $55
	note A_, 8
	intensity $45
	note A_, 8
	intensity $35
	note A_, 8
	intensity $75
	note E_, 8
	note B_, 8
	note A#, 8
	note G_, 16
	octave 4
	note D_, 8
	intensity $55
	note D_, 8
	intensity $45
	note D_, 8
	intensity $75
	note C#, 8
	intensity $55
	note C#, 8
	intensity $45
	note C#, 8
	intensity $75
	note C_, 8
	octave 3
	note F_, 4
	note G_, 4
	note G#, 8
	note B_, 8
	intensity $55
	note B_, 8
	intensity $45
	note B_, 8
	intensity $35
	note B_, 8
	intensity $75
	note F_, 4
	note G_, 4
	note G#, 8
	note B_, 8
	intensity $55
	note B_, 8
	intensity $45
	note B_, 8
	loopchannel 0, Music_ScaryHouseXY_Ch1_loop_main

Music_ScaryHouseXY_Ch2:
	dutycycle 2
	vibrato $12, $15
	tone $0002
	notetype $c, $93
	octave 4
	note B_, 2
	note E_, 2
	note B_, 2
	note E_, 2
	octave 5
	note C_, 2
	octave 4
	note E_, 2
	note B_, 2
	note E_, 2
	note A#, 2
	note E_, 2
	note A#, 2
	note E_, 2
	note B_, 2
	note E_, 2
	note B_, 2
	note E_, 2
	octave 5
	note C_, 2
	octave 4
	note E_, 2
	note B_, 2
	note E_, 2
	note A#, 8
Music_ScaryHouseXY_Ch2_loop_main:
	intensity $94
	note E_, 4
	note F#, 4
	note G_, 4
	intensity $96
	note A_, 12
	octave 3
	intensity $77
	note E_, 4
	octave 4
	intensity $94
	note E_, 2
	note F#, 2
	note G_, 4
	intensity $96
	note A_, 12
	octave 3
	intensity $77
	note E_, 4
	octave 4
	intensity $94
	note E_, 4
	note B_, 4
	note A#, 4
	note G_, 8
	intensity $95
	octave 5
	note D_, 4
	octave 4
	note G#, 8
	octave 5
	note C#, 4
	octave 4
	note G_, 8
	octave 5
	note C_, 4
	octave 4
	note F_, 2
	note G_, 2
	note G#, 4
	note B_, 16
	note F_, 2
	note G_, 2
	note G#, 4
	note B_, 12
	loopchannel 0, Music_ScaryHouseXY_Ch2_loop_main

Music_ScaryHouseXY_Ch3:
	notetype $c, $20
	tone $0002
	octave 3
	note E_, 4
	note A#, 4
	octave 4
	note F_, 4
	note E_, 8
	intensity $30
	note E_, 4
	loopchannel 2, Music_ScaryHouseXY_Ch3
Music_ScaryHouseXY_Ch3_loop_main:
Music_ScaryHouseXY_Ch3_loop_1:
	intensity $20
	octave 3
	note E_, 2
	note B_, 2
	octave 4
	note G_, 2
	octave 3
	note B_, 2
	octave 4
	note G_, 2
	octave 3
	note B_, 2
	octave 4
	note F#, 2
	octave 3
	note B_, 2
	octave 4
	note F#, 4
	intensity $30
	note F#, 4
	intensity $20
	loopchannel 2, Music_ScaryHouseXY_Ch3_loop_1
	octave 3
	note E_, 2
	note F#, 2
	note G_, 2
	note B_, 2
	octave 4
	note E_, 2
	note B_, 2
	note A#, 2
	note E_, 2
	note A#, 4
	intensity $30
	note A#, 4
	intensity $20
	octave 3
	note E_, 2
	note A#, 2
	octave 4
	note D_, 4
	intensity $30
	note D_, 4
	intensity $20
	octave 3
	note D#, 2
	note A_, 2
	octave 4
	note C#, 4
	intensity $30
	note C#, 4
	intensity $20
	octave 3
	note D_, 2
	note G#, 2
	octave 4
	note C_, 4
	intensity $30
	note C_, 4
	intensity $20
	octave 3
	note C#, 2
	note G_, 2
	note B_, 2
	octave 4
	note E_, 2
	note A#, 4
	note __, 16
	note __, 8
	loopchannel 0, Music_ScaryHouseXY_Ch3_loop_main
