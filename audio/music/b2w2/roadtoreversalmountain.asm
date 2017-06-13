; Pokémon B2/W2 - Road to Reversal Mountain
; Demixed by Mmmmmm
; https://pastebin.com/27rkdjmk
; https://hax.iimarck.us/topic/6777/

Music_RoadToReversalMountainB2W2:
	musicheader 4, 1, Music_RoadToReversalMountainB2W2_Ch1
	musicheader 1, 2, Music_RoadToReversalMountainB2W2_Ch2
	musicheader 1, 3, Music_RoadToReversalMountainB2W2_Ch3
	musicheader 1, 4, Music_RoadToReversalMountainB2W2_Ch4

Music_RoadToReversalMountainB2W2_Ch1:
	tempo 140
	volume $77
	dutycycle 3
	tone $0002
	vibrato $10, $22
	notetype $c, $60
	callchannel Music_RoadToReversalMountainB2W2_Ch1_branch_1
	callchannel Music_RoadToReversalMountainB2W2_Ch1_branch_1
	octave 3
	note A_, 15
	intensity $67
	note A_, 3
	intensity $60
	note A_, 12
	note A#, 6
	callchannel Music_RoadToReversalMountainB2W2_Ch1_branch_1
	callchannel Music_RoadToReversalMountainB2W2_Ch1_branch_1
	note D_, 15
	intensity $67
	note D_, 3
	note __, 16
	note __, 16
	note __, 16
	note __, 6
	loopchannel 0, Music_RoadToReversalMountainB2W2_Ch1

Music_RoadToReversalMountainB2W2_Ch1_branch_1:
	octave 2
	note A_, 12
	note A#, 6
	note A_, 12
	note G_, 6
	endchannel

Music_RoadToReversalMountainB2W2_Ch2:
	dutycycle $0
	tone $0001
	vibrato $1c, $12
	notetype $6, $a4
	note __, 4
	octave 3
	note D_, 2
	note C#, 2
	note D_, 4
	note C#, 1
	note D_, 1
	note C#, 2
	octave 2
	note A_, 8
	note G#, 4
	note A_, 4
	note A#, 8
	octave 3
	note C#, 2
	note C_, 2
	note C#, 4
	note C#, 1
	note C_, 1
	note C#, 2
	octave 2
	note A_, 8
	note A#, 4
	octave 3
	note C_, 4
	note C#, 8
	note D#, 2
	note D_, 2
	note D#, 4
	note D_, 4
	note D#, 1
	note D_, 1
	note C#, 10
	octave 2
	note A#, 4
	note A_, 8
	octave 3
	note D#, 2
	note D_, 2
	note D#, 4
	note D_, 4
	note C_, 12
	note C#, 4
	note D#, 4
	note D_, 1
	note D#, 1
	notetype $C, $a0
	note D_, 6
	intensity $a7
	note D_, 11
	dutycycle 3
	intensity $70
	note C_, 12
	intensity $77
	note C_, 6
	dutycycle 0
	octave 2
	notetype $6, $a4
	note G#, 4
	note A#, 4
	octave 3
	note C_, 4
	note C_, 1
	note C#, 7
	note C_, 1
	note C#, 1
	note C_, 2
	octave 2
	note A#, 4
	note A_, 4
	note A#, 4
	octave 3
	note C_, 4
	note C#, 4
	note C#, 1
	note D_, 3
	note D#, 8
	note D_, 4
	note C#, 4
	note C_, 4
	note C#, 4
	note D_, 4
	note D#, 4
	note D_, 4
	notetype $8, $a4
	note C#, 1
	note D_, 1
	note C#, 1
	notetype $c, $a6
	octave 2
	note A_, 10
	intensity $a4
	octave 3
	note C_, 2
	note C#, 2
	note C_, 2
	notetype $8, $a4
	octave 2
	note B_, 1
	octave 3
	note C_, 1
	octave 2
	note B_, 1
	notetype $c, $a7
	note G#, 10
	note A_, 16
	note __, 16
	note __, 4
	octave 3
	notetype $3, $a4
	note A_, 8
	note A_, 4
	note G_, 4
	note A_, 8
	octave 4
	note C_, 8
	note C#, 1
	note D_, 1
	note C#, 1
	note D_, 1
	note C#, 12
	notetype $6, $a4
	note D#, 12
	note D_, 4
	octave 3
	note A_, 2
	note G_, 2
	note A_, 4
	octave 4
	note C_, 4
	note C#, 8
	note C_, 1
	note C#, 1
	note C_, 10
	loopchannel 0, Music_RoadToReversalMountainB2W2_Ch2

Music_RoadToReversalMountainB2W2_Ch3:
	notetype $c, $25
	octave 2
	callchannel Music_RoadToReversalMountainB2W2_Ch3_branch_1
	note D_, 2
	note G_, 1
	note __, 1
	note G_, 1
	note __, 1
	callchannel Music_RoadToReversalMountainB2W2_Ch3_branch_1
	note C_, 2
	note G_, 1
	note __, 1
	note G_, 1
	note __, 1
	loopchannel 0, Music_RoadToReversalMountainB2W2_Ch3

Music_RoadToReversalMountainB2W2_Ch3_branch_1:
	note D_, 2
	note __, 2
	note A_, 2
	note __, 2
	note A_, 2
	note __, 2
	endchannel

Music_RoadToReversalMountainB2W2_Ch4:
	stereopanning $f
	togglenoise $3
	notetype $c
Music_RoadToReversalMountainB2W2_Ch4_loop:
	note C_, 4
	note D#, 2
	note D#, 2
	note C_, 2
	note D#, 1
	note D#, 1
	note C_, 2
	note C_, 2
	note D#, 2
	loopchannel 0, Music_RoadToReversalMountainB2W2_Ch4_loop
