; Pokémon R/S/E - Route 101
; Demixed by Mmmmmm
; https://pastebin.com/VstjfaGf
; https://hax.iimarckus.org/topic/6777/

Music_Route101RSE:
	musicheader 4, 1, Music_Route101RSE_Ch1
	musicheader 1, 2, Music_Route101RSE_Ch2
	musicheader 1, 3, Music_Route101RSE_Ch3
	musicheader 1, 4, Music_Route101RSE_Ch4

Music_Route101RSE_Ch1:
	tempo 166
	volume $77
	tone $0001
	vibrato $10, $15
	stereopanning $f
	notetype $c, $83
	note __, 2
Music_Route101RSE_Ch1_loop:
	intensity $84
	dutycycle $3
	callchannel Music_Route101RSE_Ch1_branch_1
	callchannel Music_Route101RSE_Ch1_branch_1
	intensity $82
	dutycycle $0
	callchannel Music_Route101RSE_Ch1_branch_2
	callchannel Music_Route101RSE_Ch1_branch_3
	callchannel Music_Route101RSE_Ch1_branch_3
	octave 5
	note E_, 1
	octave 4
	note B_, 1
	note E_, 1
	octave 3
	note B_, 1
	octave 4
	note G_, 1
	octave 3
	note B_, 1
	note G_, 1
	note E_, 1
	note A_, 1
	octave 4
	note D_, 1
	note E_, 1
	note A_, 1
	note E_, 1
	octave 5
	note D_, 1
	note E_, 1
	note A_, 1
	note E_, 1
	note D#, 1
	note __, 1
	note D_, 1
	note C#, 2
	octave 4
	note A_, 2
	callchannel Music_Route101RSE_Ch1_branch_2
	intensity $83
	dutycycle $3
	octave 3
	note A#, 1
	note D_, 1
	note F_, 1
	note A#, 1
	octave 4
	note D_, 4
	octave 5
	intensity $84
	dutycycle $2
	note F_, 2
	intensity $64
	note F_, 2
	intensity $84
	note A#, 2
	intensity $64
	note A#, 2
	intensity $83
	dutycycle $3
	octave 3
	note A_, 1
	note C#, 1
	note E_, 1
	note G_, 1
	note A_, 4
	octave 5
	dutycycle $2
	intensity $84
	note E_, 2
	intensity $64
	note E_, 2
	intensity $84
	note A_, 2
	intensity $64
	note A_, 2
	loopchannel 0, Music_Route101RSE_Ch1_loop

Music_Route101RSE_Ch1_branch_1:
	octave 3
	note D_, 2
	octave 2
	note A_, 2
	note __, 2
	note F#, 1
	note D_, 1
	note F#, 2
	note __, 2
	octave 3
	note D_, 4
	note E_, 2
	octave 2
	note B_, 2
	note __, 2
	note G_, 1
	note E_, 1
	note G_, 2
	note __, 2
	octave 3
	note E_, 4
	note C#, 1
	octave 2
	note B_, 1
	octave 3
	note C#, 1
	note D_, 1
	note E_, 1
	note F#, 1
	note G_, 1
	note E_, 1
	note A_, 8
	octave 4
	note C#, 1
	octave 3
	note B_, 1
	octave 4
	note C#, 1
	octave 3
	note B_, 1
	octave 4
	note C#, 1
	octave 3
	note __, 2
	note A_, 1
	octave 4
	note C#, 2
	note __, 2
	octave 3
	note E_, 2
	octave 2
	note A_, 2
	endchannel

Music_Route101RSE_Ch1_branch_2:
	octave 4
	note G_, 1
	octave 3
	note G_, 1
	octave 4
	note D_, 1
	octave 3
	note B_, 1
	octave 4
	note G_, 1
	octave 3
	note G_, 1
	octave 4
	note D_, 1
	octave 3
	note B_, 1
	note G_, 1
	note B_, 1
	octave 4
	note D_, 1
	note G_, 1
	octave 3
	note B_, 1
	octave 4
	note G_, 1
	octave 5
	note D_, 1
	note G_, 1
	octave 4
	note F#, 1
	octave 3
	note F#, 1
	octave 4
	note D_, 1
	octave 3
	note A_, 1
	octave 4
	note F#, 1
	octave 3
	note F#, 1
	octave 4
	note D_, 1
	octave 3
	note A_, 1
	note F#, 1
	octave 4
	note D_, 1
	note F#, 1
	note A_, 1
	note D_, 1
	note A_, 1
	octave 5
	note D_, 1
	note F#, 1
	endchannel

Music_Route101RSE_Ch1_branch_3:
	octave 4
	note G_, 1
	octave 3
	note G_, 1
	note B_, 1
	octave 4
	note E_, 1
	endchannel

Music_Route101RSE_Ch2:
	dutycycle $2
	vibrato $12, $36
	notetype $c, $77
	note __, 2
Music_Route101RSE_Ch2_loop:
	intensity $77
	callchannel Music_Route101RSE_Ch2_branch_1
	callchannel Music_Route101RSE_Ch2_branch_1
	callchannel Music_Route101RSE_Ch2_branch_2
	intensity $97
	octave 4
	note D_, 1
	note __, 1
	note D_, 1
	note __, 1
	note D_, 1
	note __, 1
	note E_, 1
	note F#, 1
	intensity $90
	note G_, 2
	intensity $97
	note G_, 6
	note E_, 4
	note D_, 4
	note E_, 1
	note __, 1
	note E_, 1
	note __, 1
	note E_, 1
	note __, 1
	note E_, 1
	note F#, 1
	note E_, 6
	intensity $77
	octave 1
	note A_, 2
	callchannel Music_Route101RSE_Ch2_branch_2
	note F#, 1
	note __, 1
	note A_, 1
	note __, 1
	octave 2
	note D_, 2
	octave 1
	note F#, 2
	intensity $97
	octave 4
	note A#, 6
	note A_, 2
	note G_, 4
	note F_, 2
	note A#, 2
	intensity $90
	note A_, 8
	intensity $97
	note A_, 8
	loopchannel 0, Music_Route101RSE_Ch2_loop

Music_Route101RSE_Ch2_branch_1:
	octave 1
	note D_, 2
	note __, 5
	note A_, 1
	note D_, 2
	note __, 4
	note A_, 2
	note E_, 2
	note __, 1
	note E_, 1
	octave 2
	note D#, 2
	octave 1
	note B_, 1
	note B_, 1
	note E_, 2
	note __, 4
	note E_, 2
	note A_, 2
	note __, 5
	note E_, 1
	note A_, 2
	note __, 4
	octave 2
	note E_, 1
	note E_, 1
	octave 1
	note A_, 2
	note __, 2
	note A_, 1
	note __, 2
	note E_, 1
	note A_, 2
	note __, 2
	octave 2
	note E_, 1
	note __, 1
	octave 1
	note A_, 2
	endchannel

Music_Route101RSE_Ch2_branch_2:
	note G_, 2
	note __, 2
	note G_, 1
	note __, 1
	octave 2
	note D_, 2
	octave 1
	note G_, 2
	note __, 4
	intensity $92
	note G_, 1
	note G_, 1
	intensity $97
	note F#, 2
	note __, 1
	note A_, 1
	octave 2
	note C#, 2
	octave 1
	note D_, 1
	note E_, 1
	endchannel

Music_Route101RSE_Ch3:
	stereopanning $f0
	notetype $c, $13
	vibrato $15, $24
Music_Route101RSE_Ch3_loop:
	callchannel Music_Route101RSE_Ch3_branch_1
	callchannel Music_Route101RSE_Ch3_branch_1
	octave 6
	note C#, 1
	note D_, 1
	octave 5
	note B_, 1
	note __, 1
	note B_, 1
	note __, 1
	note B_, 1
	note __, 1
	note B_, 1
	octave 6
	note C#, 1
	note D_, 4
	octave 5
	note D_, 4
	callchannel Music_Route101RSE_Ch3_branch_2
	note G_, 1
	note __, 1
	octave 4
	note B_, 1
	note __, 1
	octave 5
	note C#, 1
	note __, 1
	note E_, 1
	note F#, 1
	note G_, 4
	note B_, 4
	callchannel Music_Route101RSE_Ch3_branch_2
	note B_, 1
	note __, 1
	note B_, 1
	note __, 1
	note B_, 1
	note __, 1
	note B_, 1
	octave 6
	note C#, 1
	note D_, 4
	octave 5
	note G_, 4
	octave 6
	note F#, 1
	note __, 1
	note G_, 1
	note __, 1
	note F#, 1
	note __, 1
	note F#, 1
	note E_, 1
	note D_, 6
	note __, 2
	note D_, 6
	note C_, 2
	octave 5
	note A#, 4
	note F_, 2
	octave 6
	note D_, 2
	note C#, 8
	intensity $23
	note C#, 6
	intensity $13
	loopchannel 0, Music_Route101RSE_Ch3_loop

Music_Route101RSE_Ch3_branch_1:
	octave 5
	note A_, 1
	note B_, 1
	note A_, 1
	note __, 1
	note A_, 1
	note __, 1
	note G_, 1
	note __, 1
	note F#, 2
	note __, 2
	note F#, 1
	note __, 1
	note G_, 1
	note __, 1
	note A_, 1
	note __, 1
	note G_, 2
	note __, 2
	note F#, 2
	note __, 2
	note E_, 2
	note __, 2
	note B_, 2
	note __, 2
	note A_, 12
	note __, 2
	note F#, 1
	note G_, 1
	note A_, 1
	note G_, 1
	note A_, 1
	note G_, 1
	note A_, 1
	note __, 1
	note G_, 1
	note F#, 1
	note E_, 1
	note __, 5
	endchannel

Music_Route101RSE_Ch3_branch_2:
	note A_, 1
	note __, 1
	note A_, 1
	note __, 1
	note A_, 1
	note __, 1
	note A_, 1
	note B_, 1
	note A_, 6
	note __, 2
	endchannel

Music_Route101RSE_Ch4:
	stereopanning $f
	togglenoise $0
	notetype $c
	note __, 2
Music_Route101RSE_Ch4_loop:
	callchannel Music_Route101RSE_Ch4_branch_1
	note D#, 1
	note D#, 1
	loopchannel 4, Music_Route101RSE_Ch4_loop
Music_Route101RSE_Ch4_loop_2:
	callchannel Music_Route101RSE_Ch4_branch_2
	note D_, 1
	note B_, 1
	note B_, 1
	note B_, 1
	note D#, 1
	note B_, 1
	note D_, 1
	note D_, 1
	callchannel Music_Route101RSE_Ch4_branch_2
	note D_, 1
	note B_, 1
	note B_, 1
	note D_, 1
	note D#, 1
	note B_, 1
	note D_, 1
	note B_, 1
	loopchannel 3, Music_Route101RSE_Ch4_loop_2
	note D_, 1
	note B_, 1
	note B_, 1
	note D_, 1
	note D#, 2
	note F_, 1
	note F_, 1
	note F_, 2
	note D#, 1
	note D#, 1
	note D_, 2
	note F#, 2
	note D_, 1
	note B_, 1
	note B_, 1
	note D_, 1
	note D#, 2
	note F_, 1
	note F_, 1
	note F_, 2
	note D#, 1
	note D#, 1
	note D_, 4
	loopchannel 0, Music_Route101RSE_Ch4_loop

Music_Route101RSE_Ch4_branch_1:
	note D#, 4
	note F_, 3
	note D#, 1
	note D#, 4
	note F_, 2
	note D#, 1
	note D#, 1
	note D#, 4
	note F_, 4
	note D#, 2
	note F_, 1
	note F_, 1
	note F_, 2
	endchannel

Music_Route101RSE_Ch4_branch_2:
	note D_, 1
	note B_, 1
	note B_, 1
	note B_, 1
	note D#, 1
	note B_, 1
	note D_, 1
	note B_, 1
	endchannel
