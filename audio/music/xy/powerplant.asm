; Pokémon X/Y - Power Plant
; Demixed by ShantyTown
; https://github.com/huderlem/pokestyle-music-devamps/blob/master/music/kalos_powerplant.asm

Music_PowerPlantXY:
	musicheader 4, 1, Music_PowerPlantXY_Ch1
	musicheader 1, 2, Music_PowerPlantXY_Ch2
	musicheader 1, 3, Music_PowerPlantXY_Ch3
	musicheader 1, 4, Music_PowerPlantXY_Ch4

Music_PowerPlantXY_Ch1:
	tempo 175
	volume $77
	stereopanning $f
	vibrato $12, $23
	notetype $c, $87
	dutycycle $0

Music_PowerPlantXY_Ch1_branch_0:
	callchannel Music_PowerPlantXY_Ch1_branch_4
	callchannel Music_PowerPlantXY_Ch1_branch_1
	callchannel Music_PowerPlantXY_Ch1_branch_1
	callchannel Music_PowerPlantXY_Ch1_branch_2
	callchannel Music_PowerPlantXY_Ch1_branch_1
	callchannel Music_PowerPlantXY_Ch1_branch_1
	callchannel Music_PowerPlantXY_Ch1_branch_3
	loopchannel 0, Music_PowerPlantXY_Ch1_branch_0

Music_PowerPlantXY_Ch1_branch_1:
	vibrato $12, $23
	notetype $c, $c3
	octave 2
	note G#, 3
	notetype $c, $c2
	note G#, 1
	note __, 6
	note G#, 2
	note __, 1
	note G#, 2
	note __, 1
	notetype $c, $c3
	note G#, 3
	notetype $c, $c2
	note G#, 1
	note __, 6
	note G#, 2
	note __, 1
	note G#, 2
	note __, 1
	notetype $c, $c3
	note G_, 3
	notetype $c, $c2
	note G_, 1
	note __, 6
	note G_, 2
	note __, 1
	note G_, 2
	note __, 1
	notetype $c, $c3
	note G_, 3
	notetype $c, $c2
	note G_, 1
	note __, 6
	note G_, 2
	note __, 1
	note G_, 2
	note __, 1
	endchannel

Music_PowerPlantXY_Ch1_branch_2:
	notetype $c, $c2
	octave 3
	note C#, 1
	note __, 2
	note D_, 1
	note __, 2
	notetype $c, $b9
	note C#, 6
	note __, 4
	octave 2
	note A#, 1
	note __, 2
	note D#, 1
	note __, 2
	notetype $c, $b9
	note D_, 10
	notetype $c, $aa
	note F#, 2
	note F#, 2
	note F#, 2
	octave 3
	note C_, 2
	note C#, 2
	note C_, 2
	note C#, 2
	note D#, 2
	notetype $c, $6e
	note C_, 8
	note __, 2
	octave 2
	notetype $c, $d3
	note G#, 1
	note __, 2
	notetype $c, $c8
	note F#, 3
	endchannel

Music_PowerPlantXY_Ch1_branch_3:
	notetype $c, $6a
	octave 4
	note E_, 16
	note C_, 8
	note E_, 8
	octave 3
	note B_, 16
	note G#, 6
	note G#, 6
	note G#, 4
	note B_, 16
	note B_, 8
	octave 4
	note D#, 8
	octave 3
	note B_, 16
	note B_, 8
	octave 4
	note D#, 8
	endchannel

Music_PowerPlantXY_Ch1_branch_4:
	vibrato $12, $35
	dutycycle $2
	notetype $c, $51
	note __, 3
	octave 4
	note E_, 2
	note E_, 2
	note __, 1
	note E_, 2
	note __, 1
	note E_, 2
	note F#, 2
	note D#, 2
	octave 3
	note __, 2
	octave 4
	note E_, 2
	note E_, 2
	note __, 1
	note E_, 2
	note __, 1
	note E_, 2
	note D#, 2
	note __, 1
	endchannel

Music_PowerPlantXY_Ch2:
	stereopanning $ff
	vibrato $12, $23
	notetype $c, $c4

Music_PowerPlantXY_Ch2_branch_0:
	callchannel Music_PowerPlantXY_Ch2_branch_4
	callchannel Music_PowerPlantXY_Ch2_branch_1
	callchannel Music_PowerPlantXY_Ch2_branch_1
	callchannel Music_PowerPlantXY_Ch2_branch_2
	callchannel Music_PowerPlantXY_Ch2_branch_1
	callchannel Music_PowerPlantXY_Ch2_branch_1
	callchannel Music_PowerPlantXY_Ch2_branch_3
	loopchannel 0, Music_PowerPlantXY_Ch2_branch_0

Music_PowerPlantXY_Ch2_branch_1:
	notetype $c, $c2
	dutycycle $1
	octave 3
	note G#, 2
	octave 4
	note E_, 2
	note D#, 2
	octave 3
	note B_, 2
	octave 4
	note C#, 2
	note __, 2
	octave 3
	note G#, 2
	note B_, 2
	note __, 2
	note A_, 2
	note __, 2
	note G#, 2
	note __, 2
	note F#, 2
	note G#, 2
	note __, 3
	octave 4
	note E_, 1
	dutycycle $2
	octave 5
	note E_, 1
	dutycycle $1
	octave 4
	note E_, 1
	dutycycle $2
	octave 5
	note E_, 2
	dutycycle $1
	octave 4
	note E_, 1
	dutycycle $2
	octave 5
	note E_, 2
	dutycycle $1
	octave 4
	note E_, 1
	octave 5
	note D_, 2
	octave 4
	note B_, 2
	note A_, 2
	note B_, 2
	note A_, 1
	note E_, 2
	note E_, 1
	note A_, 1
	note B_, 3
	note A_, 2
	note E_, 2
	note A_, 2
	endchannel

Music_PowerPlantXY_Ch2_branch_2:
	vibrato $12, $23
	dutycycle $1
	notetype $c, $c2
	octave 4
	note C#, 1
	note __, 2
	octave 3
	note G#, 1
	note __, 2
	notetype $c, $b9
	note A_, 6
	octave 4
	note C#, 1
	note D#, 1
	note E_, 1
	note F_, 1
	notetype $c, $d2
	note F#, 1
	note __, 2
	octave 3
	note F#, 1
	note __, 2
	notetype $c, $b9
	note B_, 10
	notetype $c, $aa
	note A_, 2
	note B_, 2
	note A_, 2
	octave 4
	note D#, 2
	note E_, 2
	note D#, 2
	note E_, 2
	note F#, 2
	notetype $c, $4f
	note D#, 8
	note __, 2
	notetype $c, $d3
	note E_, 1
	note __, 2
	notetype $c, $c8
	note D#, 3
	endchannel

Music_PowerPlantXY_Ch2_branch_3:
	notetype $c, $6a
	octave 4
	note G#, 16
	note F#, 8
	note B_, 8
	note E_, 16
	note D_, 6
	note E_, 6
	note F#, 4
	note G#, 16
	note F#, 8
	note B_, 8
	note G#, 16
	note F#, 8
	note B_, 8
	endchannel

Music_PowerPlantXY_Ch2_branch_4:
	vibrato $12, $35
	dutycycle $2
	notetype $c, $c2
	octave 3
	note C#, 1
	note G#, 1
	octave 4
	note E_, 2
	note E_, 2
	note __, 1
	note E_, 2
	note __, 1
	note E_, 2
	note F#, 2
	note D#, 2
	octave 3
	note C#, 1
	note G#, 1
	octave 4
	note E_, 2
	note E_, 2
	note __, 1
	note E_, 2
	note __, 1
	note E_, 2
	note D#, 2
	note __, 2
	endchannel

Music_PowerPlantXY_Ch3:
	stereopanning $ff
	notetype $c, $11

Music_PowerPlantXY_Ch3_branch_0:
	callchannel Music_PowerPlantXY_Ch3_branch_4
	callchannel Music_PowerPlantXY_Ch3_branch_1
	callchannel Music_PowerPlantXY_Ch3_branch_1
	callchannel Music_PowerPlantXY_Ch3_branch_2
	callchannel Music_PowerPlantXY_Ch3_branch_1
	callchannel Music_PowerPlantXY_Ch3_branch_1
	callchannel Music_PowerPlantXY_Ch3_branch_3
	loopchannel 0, Music_PowerPlantXY_Ch3_branch_0

Music_PowerPlantXY_Ch3_branch_1:
	vibrato $0, $66
	notetype $c, $14
	octave 3
	note C#, 3
	note C#, 1
	note __, 2
	octave 2
	notetype $c, $12
	note C#, 4
	notetype $c, $14
	octave 3
	note C#, 2
	note __, 1
	note C#, 2
	note __, 1
	note C#, 3
	note C#, 1
	note __, 2
	notetype $c, $12
	octave 2
	note C#, 4
	notetype $c, $14
	octave 3
	note C#, 2
	note __, 1
	note C#, 2
	note __, 1
	note E_, 3
	note E_, 1
	note __, 2
	notetype $c, $12
	octave 2
	note E_, 4
	notetype $c, $14
	octave 3
	note E_, 2
	note __, 1
	note E_, 2
	note __, 1
	note E_, 3
	note E_, 1
	note __, 2
	notetype $c, $12
	octave 2
	note E_, 4
	notetype $c, $14
	octave 3
	note E_, 2
	note __, 1
	note E_, 2
	note __, 1
	endchannel

Music_PowerPlantXY_Ch3_branch_2:
	notetype $c, $14
	octave 2
	note A_, 1
	note __, 2
	note G#, 1
	note __, 2
	note A_, 7
	note G#, 1
	note A_, 1
	note G#, 1
	note F#, 1
	note __, 2
	note D#, 1
	note __, 2
	note G_, 8
	note A_, 1
	note G_, 1
	note F#, 8
	note D#, 8
	note G#, 8
	note __, 2
	note G#, 1
	note __, 2
	note G#, 3
	endchannel

Music_PowerPlantXY_Ch3_branch_3:
	octave 2
	note B_, 2
	note __, 1
	note B_, 1
	note __, 6
	octave 3
	note E_, 3
	octave 2
	note A_, 3
	note G#, 2
	note __, 1
	note G#, 1
	note __, 1
	note G#, 1
	note __, 4
	note G#, 2
	note __, 1
	note G#, 3
	octave 3
	note C#, 2
	note __, 1
	note C#, 1
	note __, 2
	note C#, 1
	note __, 3
	note C#, 1
	note __, 2
	note C#, 3
	octave 2
	note E_, 2
	note __, 1
	note E_, 1
	note __, 2
	note E_, 1
	note __, 3
	note E_, 1
	note __, 2
	note E_, 3
	note F#, 4
	note B_, 1
	octave 3
	note C_, 1
	note C#, 6
	octave 2
	note F#, 4
	note G#, 4
	octave 3
	note C#, 1
	note D_, 1
	note D#, 6
	octave 2
	note B_, 4
	note G#, 4
	octave 3
	note C#, 1
	note D#, 1
	note E_, 6
	octave 2
	note B_, 2
	octave 3
	note C#, 2
	octave 2
	note B_, 4
	octave 3
	note D#, 1
	note F_, 1
	note F#, 4
	note D#, 2
	octave 2
	note B_, 2
	octave 3
	note D#, 2
	endchannel

Music_PowerPlantXY_Ch3_branch_4:
	notetype $c, $11
	octave 3
	note C#, 16
	note C#, 13
	note __, 3
	endchannel

Music_PowerPlantXY_Ch4:
	notetype $c
	togglenoise $3
Music_PowerPlantXY_Ch4_branch_0:
	note A#, 3
	note C#, 1
	note D_, 2
	note A#, 4
	note A#, 2
	note D_, 4
	note A#, 3
	note C#, 1
	note D_, 2
	note A#, 4
	note A#, 2
	note C_, 4
Music_PowerPlantXY_Ch4_branch_1:
	note D_, 4
	note D_, 2
	note D_, 2
	note D_, 2
	note D_, 2
	note D_, 1
	note G#, 1
	note B_, 2
	note D_, 2
	note D_, 1
	note G#, 1
	note D_, 2
	note D_, 2
	note D_, 2
	note D_, 2
	note D_, 1
	note G#, 1
	note B_, 2
	loopchannel 5, Music_PowerPlantXY_Ch4_branch_1
	note D_, 4
	note D_, 2
	note D_, 2
	note D_, 2
	note D_, 2
	note D_, 1
	note G#, 1
	note B_, 2
	note D_, 2
	note D_, 1
	note G#, 1
	note D_, 2
	note D_, 2
	note D_, 2
	note B_, 2
	note __, 1
	note B_, 2
	note __, 1
Music_PowerPlantXY_Ch4_branch_3:
	note D_, 4
	note D_, 2
	note D_, 2
	note D_, 2
	note D_, 2
	note D_, 1
	note G#, 1
	note B_, 2
	note D_, 2
	note D_, 1
	note G#, 1
	note D_, 2
	note D_, 2
	note D_, 2
	note D_, 2
	note D_, 1
	note G#, 1
	note B_, 2
	loopchannel 8, Music_PowerPlantXY_Ch4_branch_3
	loopchannel 0, Music_PowerPlantXY_Ch4_branch_0
