; Pokémon B/W - Route 4
; Demixed by Mmmmmm
; https://pastebin.com/QXeYDHeD
; https://hax.iimarckus.org/topic/6777/

Music_Route4BW:
	channel_count 4
	channel 1, Music_Route4BW_Ch1
	channel 2, Music_Route4BW_Ch2
	channel 3, Music_Route4BW_Ch3
	channel 4, Music_Route4BW_Ch4

Music_Route4BW_Ch1:
	tempo 144
	volume 7, 7
	dutycycle $3
	tone $0002
	vibrato $10, $22
	callchannel Music_Route4BW_Ch1_branch_1
Music_Route4BW_Ch1_loop:
	callchannel Music_Route4BW_Ch1_branch_1
	callchannel Music_Route4BW_Ch1_branch_1
	dutycycle $0
	intensity $80
	callchannel Music_Route4BW_Ch1_branch_2
	callchannel Music_Route4BW_Ch1_branch_3
	callchannel Music_Route4BW_Ch1_branch_2
	callchannel Music_Route4BW_Ch1_branch_4
	callchannel Music_Route4BW_Ch1_branch_2
	note_type 8, 11, 0
	octave 2
	note A_, 4
	note B_, 4
	octave 3
	note E_, 4
	note_type 12, 11, 0
	note D#, 4
	note C#, 4
	intensity $c7
	note __, 4
	note F#, 6
	note B_, 6
	octave 4
	note G#, 6
	note F#, 6
	note E_, 4
	intensity $c0
	note D#, 8
	intensity $c7
	note D#, 8
	note C#, 1
	note __, 2
	note D#, 1
	intensity $c0
	note E_, 4
	intensity $c7
	note E_, 8
	dutycycle $3
	jumpchannel Music_Route4BW_Ch1_loop

Music_Route4BW_Ch1_branch_1:
	note_type 12, 11, 2
	octave 2
	note B_, 2
	note B_, 4
	intensity $b1
	note B_, 1
	note B_, 1
	intensity $b2
	note B_, 2
	note B_, 4
	note B_, 2
	octave 3
	note C#, 2
	note C#, 4
	intensity $b1
	note C#, 1
	note C#, 1
	intensity $b2
	note C#, 2
	note C#, 4
	note C#, 2
	note D#, 2
	note D#, 4
	intensity $b1
	note D#, 1
	note D#, 1
	intensity $b2
	note D#, 2
	note D#, 4
	note D#, 2
	note C#, 2
	note C#, 4
	intensity $b1
	note C#, 1
	note C#, 1
	intensity $b2
	note C#, 2
	note C#, 4
	note C#, 2
	endchannel

Music_Route4BW_Ch1_branch_2:
	octave 3
	note D#, 2
	octave 2
	note B_, 2
	octave 3
	note D#, 2
	octave 2
	note B_, 4
	octave 3
	note D#, 2
	octave 2
	note B_, 2
	octave 3
	note D#, 2
	endchannel

Music_Route4BW_Ch1_branch_3:
	note E_, 2
	note C#, 2
	note E_, 2
	note C#, 4
	note E_, 2
	note C#, 2
	note E_, 2
	endchannel

Music_Route4BW_Ch1_branch_4:
	octave 3
	note C#, 2
	octave 2
	note A_, 2
	octave 3
	note C#, 2
	octave 2
	note A_, 4
	octave 3
	note C#, 2
	octave 2
	note A_, 2
	octave 3
	note C#, 2
	endchannel

Music_Route4BW_Ch2:
	dutycycle $3
	vibrato $1c, $12
	note_type 12, 12, 2
	octave 3
	note D#, 2
	note D#, 4
	intensity $c1
	note D#, 1
	note D#, 1
	intensity $c2
	note D#, 2
	note D#, 4
	intensity $c1
	note C#, 1
	note D#, 1
	intensity $c2
	note E_, 2
	note E_, 4
	intensity $c1
	note E_, 1
	note E_, 1
	intensity $c2
	note E_, 2
	note E_, 4
	intensity $c1
	note D#, 1
	note E_, 1
	intensity $c2
	note F#, 2
	note F#, 4
	intensity $c1
	note F#, 1
	note F#, 1
	intensity $c2
	note F#, 2
	note D#, 2
	note F#, 2
	note B_, 2
	intensity $c7
	note A_, 4
	note G#, 4
	note A_, 4
	octave 4
	note C#, 4
	intensity $c0
	octave 3
	note B_, 8
	intensity $c7
	note B_, 8
	note __, 2
	note F#, 2
	octave 4
	note F#, 2
	note E_, 2
	note D#, 2
	note C#, 2
	octave 3
	note B_, 2
	note F#, 2
	intensity $c0
	note A_, 8
	intensity $c7
	note A_, 8
	note __, 2
	note F#, 2
	note A_, 2
	note B_, 2
	octave 4
	note C#, 2
	note D#, 2
	note E_, 2
	note C#, 2
	intensity $c0
	note D#, 8
	intensity $c7
	note D#, 8
	note __, 2
	octave 3
	note F#, 2
	octave 4
	note F#, 2
	note E_, 2
	note D#, 2
	note C#, 2
	octave 3
	note B_, 2
	note F#, 2
	intensity $c0
	note A_, 8
	intensity $c7
	note A_, 8
	note __, 4
	note A_, 2
	note B_, 2
	octave 4
	note C#, 2
	note D#, 2
	note E_, 2
	note C#, 2
	note __, 4
	octave 2
	intensity $b7
	note F#, 4
	note B_, 4
	octave 3
	note F#, 4
	note E_, 4
	note D#, 4
	note C#, 4
	note E_, 4
	note D#, 2
	note __, 1
	note E_, 1
	note F#, 6
	note D#, 6
	note E_, 4
	note C#, 2
	note E_, 2
	octave 4
	note C#, 2
	octave 3
	note A_, 6
	note D#, 2
	note __, 1
	note E_, 1
	note F#, 4
	note B_, 2
	note __, 1
	octave 4
	note C#, 1
	note D#, 3
	note_type 6, 11, 7
	octave 3
	note A_, 1
	note B_, 1
	note_type 8, 12, 7
	octave 4
	note C#, 4
	octave 3
	note B_, 4
	note A_, 4
	note_type 12, 12, 7
	note F#, 4
	note E_, 4
	jumpchannel Music_Route4BW_Ch2

Music_Route4BW_Ch3:
	stereopanning $f0
	note_type 6, 1, 4
	octave 2
	note B_, 3
	note __, 1
	note B_, 4
	note __, 4
	note B_, 1
	note __, 1
	note B_, 1
	note __, 1
	note B_, 3
	note __, 1
	note B_, 4
	note __, 4
	note B_, 4
	octave 3
	note C#, 3
	note __, 1
	note C#, 4
	note __, 4
	note C#, 1
	note __, 1
	note C#, 1
	note __, 1
	note C#, 3
	note __, 1
	note C#, 4
	note __, 4
	note C#, 4
	note D#, 3
	note __, 1
	note D#, 4
	note __, 4
	note D#, 1
	note __, 1
	note D#, 1
	note __, 1
	note D#, 3
	note __, 1
	octave 2
	note B_, 3
	note __, 1
	octave 3
	note D#, 3
	note __, 1
	note F#, 3
	note __, 1
	note E_, 8
	note C#, 8
	note E_, 8
	octave 2
	note A_, 8
	note_type 12, 1, 4
	note B_, 4
	note F#, 1
	note __, 1
	note B_, 4
	note F#, 1
	note __, 1
	note B_, 2
	note F#, 2
	octave 3
	note C#, 4
	octave 2
	note A_, 1
	note __, 1
	octave 3
	note C#, 4
	octave 2
	note A_, 1
	note __, 1
	octave 3
	note C#, 2
	note D_, 2
	note D#, 2
	intensity $10
	octave 5
	note F#, 2
	octave 6
	note F#, 2
	note E_, 2
	note D#, 2
	note C#, 2
	octave 5
	note B_, 2
	note F#, 2
	note_type 6, 1, 0
	note A_, 1
	note B_, 1
	note A_, 1
	note B_, 1
	note A_, 1
	note B_, 1
	note A_, 1
	note B_, 1
	intensity $20
	note A_, 1
	note B_, 1
	note A_, 1
	note B_, 1
	note A_, 1
	note B_, 1
	note A_, 1
	note B_, 1
	note_type 12, 2, 0
	note A_, 1
	note B_, 1
	intensity $14
	octave 3
	note C#, 2
	octave 2
	note A_, 2
	note A#, 2
	note B_, 2
	intensity $10
	octave 5
	note F#, 2
	note A_, 2
	note B_, 2
	octave 6
	note C#, 2
	note D#, 2
	note E_, 2
	note C#, 2
	note_type 6, 1, 0
	note D#, 1
	note E_, 1
	note D#, 1
	note E_, 1
	note D#, 1
	note E_, 1
	note D#, 1
	note E_, 1
	intensity $20
	note D#, 1
	note E_, 1
	note D#, 1
	note E_, 1
	note D#, 1
	note E_, 1
	note D#, 1
	note E_, 1
	note_type 12, 2, 0
	note D#, 1
	note E_, 1
	intensity $14
	octave 2
	note E_, 2
	note A_, 2
	note A#, 2
	note B_, 2
	intensity $10
	octave 5
	note F#, 2
	octave 6
	note F#, 2
	note E_, 2
	note D#, 2
	note C#, 2
	octave 5
	note B_, 2
	note F#, 2
	note_type 6, 1, 0
	note A_, 1
	note B_, 1
	note A_, 1
	note B_, 1
	note A_, 1
	note B_, 1
	note A_, 1
	note B_, 1
	intensity $20
	note A_, 1
	note B_, 1
	note A_, 1
	note B_, 1
	note A_, 1
	note B_, 1
	note A_, 1
	note B_, 1
	note_type 12, 2, 0
	note A_, 1
	note B_, 1
	octave 6
	note C#, 1
	note D#, 1
	intensity $10
	note E_, 1
	note F#, 1
	note G#, 1
	note A_, 1
	intensity $14
	octave 5
	callchannel Music_Route4BW_Ch3_branch_1
	note A_, 8
	octave 4
	note B_, 1
	octave 5
	note C#, 1
	callchannel Music_Route4BW_Ch3_branch_1
	note A_, 10
	note F#, 5
	note_type 6, 1, 4
	note G#, 1
	note A#, 1
	note_type 12, 1, 4
	note B_, 8
	note F#, 1
	note G#, 1
	note_type 8, 1, 4
	note A_, 4
	note G#, 4
	note E_, 4
	note_type 12, 1, 4
	note D#, 4
	note C#, 4
	jumpchannel Music_Route4BW_Ch3

Music_Route4BW_Ch3_branch_1:
	note D#, 5
	note_type 6, 2, 4
	note C#, 1
	note D#, 1
	note_type 12, 1, 4
	note F#, 8
	note E_, 1
	note D#, 1
	note E_, 2
	note D#, 2
	note E_, 1
	note_type 6, 2, 4
	note F#, 1
	note G#, 1
	note_type 12, 1, 4
	endchannel

Music_Route4BW_Ch4:
	stereopanning $f
	togglenoise $0
Music_Route4BW_Ch4_branch_1:
	note_type 12
	callchannel Music_Route4BW_Ch4_branch_2
	note D_, 1
	note D#, 1
	note D#, 1
	note D_, 1
	callchannel Music_Route4BW_Ch4_branch_2
	note_type 6
	note D#, 1
	note D#, 1
	note D#, 1
	note D#, 1
	note D#, 1
	note D_, 1
	note D_, 1
	note D_, 1
	loopchannel 6, Music_Route4BW_Ch4_branch_1
	callchannel Music_Route4BW_Ch4_branch_3
	callchannel Music_Route4BW_Ch4_branch_3
	note_type 12
	note D_, 10
	note D#, 1
	note D_, 3
	note D#, 1
	note D#, 1
	note_type 8
	note D_, 4
	note D_, 4
	note D_, 4
	note_type 6
	note B_, 12
	note D#, 1
	note D#, 1
	note D#, 1
	note D_, 1
	jumpchannel Music_Route4BW_Ch4_branch_1

Music_Route4BW_Ch4_branch_2:
	note D_, 2
	note D#, 1
	note D#, 1
	note D_, 2
	note D#, 1
	note D#, 1
	note D_, 2
	note D#, 1
	note D#, 1
	endchannel

Music_Route4BW_Ch4_branch_3:
	note_type 12
	note D_, 16
	note __, 12
	note_type 6
	note D#, 1
	note D#, 1
	note D#, 1
	note D#, 1
	note D#, 1
	note D_, 1
	note D_, 1
	note D_, 1
	endchannel
