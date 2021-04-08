; Pokémon B/W - Route 12
; Demixed by Mmmmmm
; https://pastebin.com/JK83UjgF
; https://hax.iimarckus.org/topic/6777/2/

Music_Route12BW:
	musicheader 4, 1, Music_Route12BW_Ch1
	musicheader 1, 2, Music_Route12BW_Ch2
	musicheader 1, 3, Music_Route12BW_Ch3
	musicheader 1, 4, Music_Route12BW_Ch4

Music_Route12BW_Ch1:
	tempo 236
	volume $77
	dutycycle $0
	tone $0002
	vibrato $10, $22
Music_Route12BW_Ch1_loop_1:
	callchannel Music_Route12BW_Ch1_branch_1
	callchannel Music_Route12BW_Ch1_branch_1
	loopchannel 16, Music_Route12BW_Ch1_loop_1
	callchannel Music_Route12BW_Ch1_branch_2
	note E_, 6
	dutycycle 0
	callchannel Music_Route12BW_Ch1_branch_2
	note G_, 6
	note G#, 12
	note F#, 6
	note B_, 4
	octave 5
	note C#, 2
	octave 4
	note F#, 12
	dutycycle 0
	octave 2
	intensity $70
	note F#, 8
	octave 3
	intensity $97
	note F#, 2
	note G#, 2
	intensity $90
	note B_, 4
	intensity $97
	note B_, 4
	callchannel Music_Route12BW_Ch1_branch_3
	dutycycle 0
	octave 3
	intensity $90
	note F#, 4
	intensity $97
	note F#, 4
	callchannel Music_Route12BW_Ch1_branch_3
	dutycycle 0
	octave 3
	intensity $90
	note E_, 2
	intensity $97
	note E_, 4
	intensity $b4
	dutycycle 2
	octave 4
	note E_, 6
	note G_, 6
	note B_, 6
	octave 5
	note D#, 12
	note __, 12
	loopchannel 0, Music_Route12BW_Ch1

Music_Route12BW_Ch1_branch_1:
	notetype $6, $a3
	octave 4
	note F#, 1
	intensity $93
	note E_, 1
	intensity $73
	note D#, 1
	intensity $63
	octave 3
	note B_, 1
	intensity $53
	note F#, 1
	intensity $43
	note C#, 1
	octave 2
	intensity $33
	note B_, 1
	intensity $23
	note F#, 1
	endchannel

Music_Route12BW_Ch1_branch_2:
	octave 3
	notetype $8, $90
	note D#, 4
	intensity $95
	note D#, 4
	note C#, 2
	note D#, 2
	intensity $90
	note B_, 2
	intensity $97
	note B_, 4
	intensity $b4
	dutycycle 2
	octave 4
	note B_, 2
	note A#, 2
	note B_, 2
	note F#, 6
	note G#, 6
	note F#, 6
	endchannel

Music_Route12BW_Ch1_branch_3:
	intensity $b4
	octave 4
	dutycycle 2
	note D#, 2
	note E_, 2
	note F#, 6
	note B_, 6
	endchannel

Music_Route12BW_Ch2:
	notetype $8, $b0
	dutycycle $1
	vibrato $1c, $12
Music_Route12BW_Ch2_loop:
	octave 4
	intensity $b0
	note D#, 6
	intensity $b7
	note D#, 6
	intensity $b0
	note E_, 2
	intensity $b7
	note E_, 4
	intensity $b0
	note F#, 2
	intensity $b7
	note F#, 4
	octave 3
	intensity $b0
	note B_, 12
	intensity $b7
	note B_, 6
	intensity $b0
	note A#, 2
	intensity $b7
	note A#, 4
	intensity $b0
	note G#, 2
	intensity $b7
	note G#, 4
	intensity $b0
	note B_, 6
	intensity $b7
	note B_, 6
	intensity $b5
	note A#, 2
	note B_, 2
	octave 4
	note C#, 2
	octave 3
	intensity $b0
	note F#, 12
	intensity $b7
	note F#, 12
	intensity $b0
	note F#, 2
	intensity $b7
	note F#, 4
	intensity $b0
	note B_, 4
	intensity $b7
	note B_, 6
	intensity $b5
	note F#, 2
	note G#, 2
	note A#, 2
	note B_, 2
	octave 4
	intensity $b0
	note F#, 4
	intensity $b3
	note F#, 4
	octave 3
	intensity $b5
	note A#, 2
	note B_, 2
	octave 4
	intensity $b0
	note E_, 4
	intensity $b7
	note E_, 2
	intensity $b0
	note D#, 4
	intensity $b7
	note D#, 2
	intensity $b0
	note C#, 6
	intensity $b7
	note C#, 6
	octave 3
	intensity $b0
	note B_, 2
	intensity $b7
	note B_, 4
	octave 4
	intensity $b0
	note D#, 2
	intensity $b7
	note D#, 4
	intensity $b0
	note D#, 1
	intensity $b7
	note D#, 5
	intensity $b0
	note C#, 1
	intensity $b7
	note C#, 5
	octave 3
	intensity $b0
	note B_, 1
	intensity $b7
	note B_, 5
	intensity $b0
	note A#, 1
	intensity $b7
	note A#, 5
	callchannel Music_Route12BW_Ch2_branch_1
	callchannel Music_Route12BW_Ch2_branch_1
	intensity $b0
	note B_, 6
	intensity $b7
	note B_, 6
	intensity $b0
	note A#, 2
	intensity $b7
	note A#, 4
	note B_, 2
	note A#, 2
	note G#, 2
	intensity $b0
	note F#, 9
	intensity $b7
	note F#, 9
	note __, 2
	octave 4
	note D#, 2
	note E_, 2
	intensity $b0
	note F#, 9
	intensity $b7
	note F#, 9
	note __, 2
	octave 3
	note B_, 2
	octave 4
	note C#, 2
	intensity $b0
	note D#, 9
	intensity $b7
	note D#, 9
	note __, 2
	octave 3
	note G#, 2
	note A#, 2
	intensity $b0
	note B_, 12
	intensity $b7
	note B_, 12
	intensity $80
	note D#, 12
	intensity $87
	note D#, 12
	loopchannel 0, Music_Route12BW_Ch2_loop

Music_Route12BW_Ch2_branch_1:
	intensity $b0
	note B_, 4
	intensity $b5
	note B_, 4
	note A#, 2
	note B_, 2
	octave 4
	intensity $b0
	note F#, 6
	intensity $b7
	note F#, 6
	octave 3
	intensity $b0
	note B_, 4
	intensity $b5
	note B_, 4
	note F#, 2
	note B_, 2
	octave 4
	intensity $b0
	note D#, 2
	intensity $b7
	note D#, 4
	intensity $b0
	note C#, 2
	intensity $b7
	note C#, 4
	octave 3
	endchannel

Music_Route12BW_Ch3:
	notetype $8, $14
	octave 1
	note B_, 12
	note B_, 6
	octave 2
	note C#, 6
	note D#, 12
	note F#, 6
	note D#, 6
	note E_, 12
	note F#, 6
	note E_, 6
	note D#, 12
	note A#, 6
	note B_, 6
	note E_, 12
	note F#, 6
	note E_, 6
	note D#, 12
	note G#, 6
	note C_, 6
	note C#, 12
	note F_, 12
	note F#, 12
	note F#, 6
	note E_, 6
	callchannel Music_Route12BW_Ch3_branch_1
	note E_, 6
	callchannel Music_Route12BW_Ch3_branch_1
	note G_, 6
	note G#, 12
	note F#, 6
	note E_, 6
	note D#, 12
	note G#, 6
	note F#, 6
	note E_, 12
	note E_, 12
	note F#, 12
	note F#, 12
	note __, 6
	note E_, 6
	note G_, 6
	note B_, 6
	octave 1
	note B_, 12
	octave 2
	note F#, 12
	loopchannel 0, Music_Route12BW_Ch3

Music_Route12BW_Ch3_branch_1:
	note D#, 12
	note A#, 6
	octave 3
	note C#, 6
	octave 2
	note E_, 12
	note F#, 6
	endchannel

Music_Route12BW_Ch4:
	stereopanning $f
	togglenoise $0
Music_Route12BW_Ch4_loop:
	notetype $4
	callchannel Music_Route12BW_Ch4_branch_1
	callchannel Music_Route12BW_Ch4_branch_2
	callchannel Music_Route12BW_Ch4_branch_3
	callchannel Music_Route12BW_Ch4_branch_4
	callchannel Music_Route12BW_Ch4_branch_5
	callchannel Music_Route12BW_Ch4_branch_6
	callchannel Music_Route12BW_Ch4_branch_1
	callchannel Music_Route12BW_Ch4_branch_7
	loopchannel 0, Music_Route12BW_Ch4_loop

Music_Route12BW_Ch4_branch_1:
	note D_, 4
	note D_, 1
	note D#, 1
	note D#, 1
	note D#, 1
	note D_, 4
	endchannel

Music_Route12BW_Ch4_branch_2:
	note D_, 4
	note D_, 4
	note D_, 4
	endchannel

Music_Route12BW_Ch4_branch_3:
	note D_, 1
	note D#, 1
	note D#, 1
	note D#, 1
	note D_, 2
	note D#, 2
	note D_, 4
	endchannel

Music_Route12BW_Ch4_branch_4:
	note D_, 2
	note D#, 2
	note D_, 2
	note D#, 2
	note D_, 1
	note D#, 1
	note D#, 1
	note D#, 1
	endchannel

Music_Route12BW_Ch4_branch_5:
	note D_, 4
	note D_, 2
	note D#, 2
	note D_, 4
	endchannel

Music_Route12BW_Ch4_branch_6:
	note D_, 4
	note D_, 2
	note D#, 2
	note D_, 2
	note D#, 2
	endchannel

Music_Route12BW_Ch4_branch_7:
	note D_, 1
	note D#, 1
	note D#, 1
	note D#, 1
	note D_, 4
	note D_, 4
	endchannel
