; Pokémon X/Y - Bicycle
; Demixed by ShantyTown
; https://github.com/huderlem/pokestyle-music-devamps/blob/master/music/kalos_bicycle.asm

Music_BicycleXY:
	dbw $C0, BicycleXY_Ch1
	dbw $01, BicycleXY_Ch2
	dbw $02, BicycleXY_Ch3
	dbw $03, BicycleXY_Ch4

BicycleXY_Ch1::
	tempo 120
	volume $77
	stereopanning $ff
	dutycycle $1
	vibrato $10, $22
	notetype $c, $a7

BicycleXY_Ch1_sub_0:
	note __, 2
	octave 3
	note E_, 4
	octave 2
	note G#, 2
	note G#, 2
	note __, 2
	note G#, 4
	note E_, 2
	note F#, 4
	note A_, 2
	note A_, 2
	note __, 2
	note A_, 4
	note A_, 2
	note A_, 2
	note A_, 2
	note __, 16
	note G#, 5
	note __, 1
	note G#, 1
	note __, 3
	note G#, 6
	octave 3
	note A_, 6
	note B_, 6
	note A_, 4
	note G#, 6
	note E_, 6
	note G#, 4
	note __, 16
	octave 2
	note E_, 5
	note __, 1
	note E_, 1
	note __, 3
	octave 3
	note E_, 2
	note D#, 2
	note E_, 2
	octave 2
	note G#, 2
	note G#, 2
	note __, 2
	note G#, 4
	octave 3
	note E_, 2
	note D#, 2
	note E_, 2
	octave 2
	note A_, 4
	note B_, 4
	octave 3
	note C#, 4
	note E_, 4
	note F#, 4
	note E_, 4
	note F#, 4
	note G#, 4
	octave 2
	note G#, 5
	note __, 1
	note G#, 1
	note __, 3
	note G#, 6
	octave 3
	note A_, 6
	note B_, 6
	note A_, 4
	note G#, 6
	note E_, 8
	note __, 2
	note E_, 6
	note D#, 2
	note __, 2
	note E_, 2
	note __, 2
	note E_, 8
	note D#, 10
	note G#, 2
	note __, 2
	note G#, 2
	note __, 2
	note G#, 2
	note __, 2
	note G#, 2
	note __, 2
	note F#, 2
	note __, 2
	octave 2
	note B_, 2
	octave 3
	note F#, 2
	note __, 2
	note G#, 6
	note G#, 2
	note __, 2
	note G#, 2
	note __, 2
	note G#, 2
	note __, 2
	note G#, 2
	note __, 2
	note F#, 2
	note __, 2
	octave 2
	note B_, 2
	octave 3
	note F#, 2
	note __, 2
	note B_, 6
	note G#, 2
	note __, 2
	note G#, 2
	note __, 2
	note G#, 2
	note __, 2
	note G#, 2
	note __, 2
	note F#, 2
	note __, 2
	octave 2
	note B_, 2
	octave 3
	note F#, 2
	note __, 2
	note G#, 4
	note G#, 10
	note __, 6
	note G#, 8
	note B_, 4
	loopchannel 0, BicycleXY_Ch1_sub_0

BicycleXY_Ch2::
	dutycycle $1
	notetype $c, $c7
	vibrato $10, $00

BicycleXY_Ch2_sub_0:
	notetype $c, $c8
	dutycycle $2
	octave 4
	note E_, 2
	note D#, 2
	note E_, 2
	octave 3
	note G#, 8
	note __, 2
	octave 4
	note E_, 2
	note D#, 2
	note E_, 2
	octave 3
	note A_, 4
	note B_, 4
	octave 4
	note C#, 4
	notetype $6, $c7
	note E_, 7
	note F_, 1
	notetype $c, $c7
	note F#, 4
	note E_, 4
	note F#, 4
	note G#, 4
	vibrato $0, $23
	note E_, 5
	vibrato $10, $00
	note __, 1
	note E_, 1
	note __, 3
	note D_, 6
	note C#, 6
	note D#, 6
	note C#, 3
	note __, 1
	octave 3
	note B_, 6
	octave 4
	note E_, 4
	octave 3
	note G#, 2
	note A_, 2
	note B_, 2
	note A_, 4
	note G#, 4
	note F#, 4
	note E_, 4
	note F#, 5
	note __, 1
	note F#, 1
	dutycycle $3
	notetype $6, $c7
	vibrato $8, $23
	octave 5
	note __, 5
	note D#, 1
	notetype $c, $c7
	note E_, 2
	note D#, 2
	note E_, 2
	octave 4
	note G#, 8
	notetype $6, $c7
	note __, 3
	octave 5
	note D#, 1
	notetype $c, $c7
	note E_, 2
	note D#, 2
	note E_, 2
	octave 4
	note A_, 4
	note B_, 4
	octave 5
	note C#, 4
	note E_, 4
	note F#, 4
	note E_, 4
	note F#, 4
	note G#, 4
	note E_, 5
	note __, 1
	note E_, 1
	note __, 3
	note D_, 6
	note C#, 6
	note D#, 6
	note C#, 3
	note __, 1
	octave 4
	note B_, 6
	octave 5
	note E_, 8
	note __, 2
	note E_, 6
	note D#, 2
	note __, 2
	note E_, 2
	note __, 2
	note E_, 8
	note D#, 10
	vibrato $10, $23
	notetype $c, $c4
	dutycycle $1
	octave 4
	note G#, 8
	note E_, 4
	octave 5
	note C#, 4
	octave 4
	note B_, 2
	note A_, 2
	note G#, 2
	note E_, 2
	note __, 2
	note E_, 6
	note G#, 8
	note E_, 4
	octave 5
	note E_, 4
	note D#, 2
	note E_, 2
	note F#, 2
	note G#, 2
	note __, 2
	note G#, 6
	note C#, 8
	octave 4
	note G#, 4
	octave 5
	note E_, 4
	note D#, 2
	note C#, 2
	octave 4
	note B_, 2
	note G#, 2
	note __, 2
	note G#, 4
	octave 5
	note C_, 10
	octave 4
	note G#, 4
	octave 5
	note D#, 2
	note C#, 8
	note D#, 4
	loopchannel 0, BicycleXY_Ch2_sub_0

BicycleXY_Ch3::
	stereopanning $ff
	vibrato $0, $0
	notetype $c, $16

BicycleXY_Ch3_sub_0:
	note __, 6

	octave 2
	note E_, 2
	note E_, 3
	note __, 1
	note B_, 4
	note E_, 2
	note F#, 2
	note G#, 2
	note F#, 2
	note F#, 3
	note __, 1
	octave 3
	note C#, 4
	octave 2
	note F#, 2
	note A_, 2
	note A_, 2
	octave 3
	note C_, 2
	note C_, 2
	octave 2
	note G#, 2
	note G#, 2
	note F#, 2
	note E_, 2
	note F#, 2
	note C#, 2
	octave 3
	note C#, 5
	note __, 1
	note C#, 1
	note __, 3
	octave 2
	note B_, 6
	note A_, 2
	note A_, 2
	note __, 2
	octave 3
	note E_, 4
	octave 2
	note A_, 2
	note B_, 2
	note A_, 2
	note G#, 2
	note F#, 2
	note G#, 2
	octave 3
	note C#, 4
	note C#, 2
	note E_, 2
	note C#, 2
	note D_, 2
	note D_, 2
	octave 2
	note A_, 2
	note A_, 2
	octave 3
	note D_, 2
	note D_, 2
	octave 2
	note F#, 2
	note F#, 2
	note B_, 5
	note __, 1
	note B_, 1
	note __, 9
	note E_, 2
	note E_, 3
	note __, 1
	note B_, 4
	note E_, 2
	note F#, 2
	note G#, 2
	note F#, 2
	note F#, 3
	note __, 1
	octave 3
	note C#, 4
	octave 2
	note F#, 2
	note A_, 2
	note A_, 2
	octave 3
	note C_, 2
	note C_, 2
	octave 2
	note G#, 2
	note G#, 2
	note F#, 2
	note E_, 2
	note F#, 2
	note C#, 2
	octave 3
	note C#, 5
	note __, 1
	note C#, 1
	note __, 3
	octave 2
	note B_, 6
	note A_, 2
	note A_, 2
	note __, 2
	octave 3
	note D#, 4
	octave 2
	note A_, 2
	note B_, 2
	note A_, 2
	note G#, 2
	note F#, 2
	note G#, 2
	octave 3
	note C#, 4
	note C#, 2
	note E_, 2
	note C#, 2
	octave 2
	note F#, 6
	note B_, 2
	note __, 2
	note B_, 2
	note __, 2
	octave 3
	note E_, 8
	note F#, 10
	note E_, 2
	note __, 2
	note E_, 2
	note __, 2
	note E_, 2
	note __, 2
	note E_, 2
	note __, 2
	octave 2
	note B_, 2
	note A_, 2
	note G#, 2
	note E_, 2
	note __, 2
	note E_, 6
	octave 3
	note E_, 2
	note __, 2
	note E_, 2
	note __, 2
	note E_, 2
	note __, 2
	note E_, 2
	note __, 2
	octave 2
	note B_, 2
	note A_, 2
	note G#, 2
	note E_, 2
	note __, 2
	note E_, 6
	octave 3
	note E_, 2
	note __, 2
	note E_, 2
	note __, 2
	note E_, 2
	note __, 2
	note E_, 2
	note __, 2
	octave 2
	note B_, 2
	note A_, 2
	note G#, 2
	note E_, 2
	note __, 2
	note E_, 4
	octave 3
	note D#, 2
	note G#, 2
	note G#, 2
	note C_, 2
	note C_, 2
	note D#, 2
	note D#, 2
	note C_, 2
	note A_, 4
	note D#, 2
	note F#, 2
	note B_, 4
	loopchannel 0, BicycleXY_Ch3_sub_0

BicycleXY_Ch4::
	togglenoise $3
	notetype $c
	note __, 6

BicycleXY_Ch4_0:
	callchannel BicycleXY_Ch4_sub_0
	callchannel BicycleXY_Ch4_sub_0
	callchannel BicycleXY_Ch4_sub_0
	callchannel BicycleXY_Ch4_sub_0
	callchannel BicycleXY_Ch4_sub_0
	callchannel BicycleXY_Ch4_sub_0
	callchannel BicycleXY_Ch4_sub_0
	callchannel BicycleXY_Ch4_sub_0
	callchannel BicycleXY_Ch4_sub_1
	callchannel BicycleXY_Ch4_sub_1
	callchannel BicycleXY_Ch4_sub_1
	callchannel BicycleXY_Ch4_sub_1
	callchannel BicycleXY_Ch4_sub_1
	callchannel BicycleXY_Ch4_sub_1
	note __, 4
	note A#, 4
	note B_, 8
	note __, 4
	note A#, 4
	note B_, 8
	loopchannel 0, BicycleXY_Ch4_0

BicycleXY_Ch4_sub_0:
	note C#, 4
	note D_, 4
	note C#, 4
	note D_, 4
	note C#, 4
	note D_, 4
	note C#, 2
	note D_, 2
	note D_, 4
	endchannel

BicycleXY_Ch4_sub_1:
	note C#, 2
	note D_, 2
	note C#, 2
	note D_, 2
	note C#, 2
	note D_, 2
	note C#, 2
	note D_, 2
	endchannel
