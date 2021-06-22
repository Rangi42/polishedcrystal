; Pokémon OR/AS - Battle! Zinnia
; Demixed by Mmmmmm
; https://pastebin.com/fsqpcGL3
; https://hax.iimarckus.org/topic/6777/4/

Music_ZinniaBattleORAS:
	musicheader 4, 1, Music_ZinniaBattleORAS_Ch1
	musicheader 1, 2, Music_ZinniaBattleORAS_Ch2
	musicheader 1, 3, Music_ZinniaBattleORAS_Ch3
	musicheader 1, 4, Music_ZinniaBattleORAS_Ch4

Music_ZinniaBattleORAS_Ch1:
	tempo 212
	volume $77
	dutycycle 1
	tone $0002
	vibrato $8, $15
	notetype $3, $b3
	octave 4
	note C#, 12
	note __, 12
	octave 3
	note C#, 4
	note D_, 1
	note D#, 1
	note E_, 1
	note F_, 1
	notetype $6, $b0
	octave 4
	note C#, 12
	intensity $b3
	note C#, 4
	dutycycle 2
Music_ZinniaBattleORAS_Ch1_loop_1:
	callchannel Music_ZinniaBattleORAS_Ch1_branch_1
	loopchannel 4, Music_ZinniaBattleORAS_Ch1_loop_1
Music_ZinniaBattleORAS_Ch1_loop_main:
Music_ZinniaBattleORAS_Ch1_loop_2:
	callchannel Music_ZinniaBattleORAS_Ch1_branch_1
	loopchannel 4, Music_ZinniaBattleORAS_Ch1_loop_2
	dutycycle 0
	notetype $6, $80
	note D_, 8
	intensity $87
	note D_, 8
	intensity $80
	note C_, 3
	intensity $87
	note C_, 5
	intensity $80
	note F_, 6
	note E_, 1
	note D#, 1
	intensity $80
	note D_, 8
	intensity $87
	note D_, 6
	note G_, 1
	note A_, 1
	intensity $80
	note A#, 6
	note A_, 6
	note F_, 4
	intensity $80
	note G_, 8
	intensity $87
	note G_, 6
	note F#, 1
	note D_, 1
	intensity $80
	note C_, 3
	intensity $87
	note C_, 5
	intensity $80
	note F_, 3
	intensity $87
	note F_, 5
	intensity $80
	note D_, 16
	intensity $87
	note D_, 14
	intensity $70
	note G_, 1
	note A_, 1
	notetype $6, $7f
	octave 3
	note G_, 1
	intensity $90
	note G_, 7
	intensity $95
	note G_, 8
	intensity $7f
	note F#, 1
	intensity $90
	note F#, 3
	intensity $95
	note F#, 4
	intensity $7f
	note A_, 1
	intensity $90
	note A_, 3
	intensity $95
	note A_, 4
	intensity $90
	note G#, 3
	intensity $95
	note G#, 5
	intensity $90
	note G_, 3
	intensity $95
	note G_, 5
	intensity $90
	note F#, 3
	intensity $95
	note F#, 5
	intensity $90
	note G#, 3
	intensity $95
	note G#, 5
	intensity $90
	note A#, 8
	intensity $95
	note A#, 6
	note F_, 1
	note D#, 1
	intensity $90
	note D_, 3
	intensity $95
	note D_, 5
	intensity $90
	note A#, 3
	intensity $95
	note A#, 4
	note F_, 1
	intensity $7f
	note G_, 1
	intensity $90
	note G_, 15
	intensity $97
	note G_, 16
	intensity $90
	note A#, 12
	intensity $95
	note A#, 4
	intensity $90
	note A_, 6
	intensity $95
	note A_, 2
	note A#, 4
	octave 4
	note C_, 4
	octave 3
	note A_, 1
	intensity $90
	note A#, 9
	intensity $95
	note A#, 4
	note A_, 1
	note G_, 1
	intensity $90
	note D#, 10
	intensity $95
	note D#, 5
	note D_, 1
	intensity $90
	note D#, 10
	intensity $95
	note D#, 6
	notetype $8, $94
	note C_, 1
	octave 2
	note G_, 1
	octave 3
	note C_, 1
	note D_, 1
	octave 2
	note G_, 1
	octave 3
	note D_, 1
	note D#, 1
	octave 2
	note G_, 1
	octave 3
	note D#, 1
	note D#, 1
	note F_, 1
	note G_, 1
	notetype $6, $90
	note A#, 8
	intensity $95
	note A#, 6
	octave 4
	note C_, 1
	octave 3
	note A#, 1
	intensity $90
	note A_, 8
	intensity $97
	note A_, 8
	dutycycle 3
	intensity $70
	note F#, 8
	intensity $77
	note F#, 8
	intensity $70
	note G#, 8
	intensity $77
	note G#, 8
	intensity $70
	note A_, 8
	intensity $77
	note A_, 8
	intensity $70
	note B_, 8
	intensity $77
	note B_, 8
	octave 4
	intensity $70
	note D_, 8
	intensity $77
	note D_, 8
	intensity $70
	note C#, 8
	intensity $77
	note C#, 8
	octave 3
	intensity $70
	note B_, 8
	intensity $77
	note B_, 8
	intensity $70
	note G#, 8
	intensity $77
	note G#, 8
	intensity $a0
	octave 4
	callchannel Music_ZinniaBattleORAS_Ch1_branch_2
	note A_, 2
	note __, 4
	note A_, 2
	note __, 4
	note A_, 2
	note __, 4
	note G#, 2
	note __, 4
	note G#, 2
	note __, 2
	note G#, 2
	note __, 2
	callchannel Music_ZinniaBattleORAS_Ch1_branch_2
	callchannel Music_ZinniaBattleORAS_Ch1_branch_3
	callchannel Music_ZinniaBattleORAS_Ch1_branch_3
	dutycycle 2
Music_ZinniaBattleORAS_Ch1_loop_3:
	callchannel Music_ZinniaBattleORAS_Ch1_branch_1
	loopchannel 3, Music_ZinniaBattleORAS_Ch1_loop_3
	loopchannel 0, Music_ZinniaBattleORAS_Ch1_loop_main

Music_ZinniaBattleORAS_Ch1_branch_1:
	intensity $a1
	note C#, 2
	note E_, 2
	note B_, 2
	note A_, 2
	note G#, 2
	note A_, 2
	note F#, 2
	note C#, 2
	note F#, 2
	note C#, 2
	note F#, 2
	note B_, 2
	note A_, 1
	note G#, 1
	note F#, 2
	note G#, 2
	note E_, 2
	endchannel

Music_ZinniaBattleORAS_Ch1_branch_2:
	note F#, 2
	note __, 4
	note F#, 2
	note __, 4
	note F#, 2
	note __, 4
	note G#, 2
	note __, 4
	note G#, 2
	note __, 2
	note G#, 2
	note __, 2
	note A_, 2
	note __, 4
	note A_, 2
	note __, 4
	note A_, 2
	note __, 4
	note B_, 2
	note __, 4
	note B_, 2
	note __, 2
	note B_, 2
	note __, 2
	endchannel

Music_ZinniaBattleORAS_Ch1_branch_3:
	note B_, 2
	note __, 4
	note B_, 2
	note __, 4
	note B_, 2
	note __, 4
	note B_, 2
	note __, 4
	note B_, 2
	note __, 2
	note B_, 2
	note __, 2
	endchannel

Music_ZinniaBattleORAS_Ch2:
	dutycycle 3
	vibrato $12, $33
	notetype $3, $e3
	octave 3
	note G#, 2
	octave 4
	note B_, 2
	note A_, 2
	note G#, 2
	note F#, 2
	note A_, 2
	note G#, 2
	note F#, 2
	note E_, 2
	note G#, 2
	note F#, 2
	note E_, 2
	note D_, 2
	note F#, 2
	note E_, 2
	note D_, 2
	note C#, 2
	note E_, 2
	note D_, 2
	note C#, 2
	octave 3
	note B_, 2
	octave 4
	note D_, 2
	note C#, 2
	octave 3
	note B_, 2
	note A_, 2
	octave 4
	note C#, 2
	octave 3
	note B_, 2
	note A_, 2
	note G#, 2
	note B_, 2
	note A_, 2
	note G#, 2
	notetype $6, $a0
	dutycycle 0
	octave 3
	note F#, 16
	note G#, 14
	note F#, 1
	note G#, 1
	note A_, 14
	note G#, 1
	note A_, 1
	note B_, 16
	octave 4
	note C#, 12
	notetype $3, $a0
	note E_, 6
	note D#, 1
	note D_, 1
	notetype $6, $a0
	note C#, 12
	note G#, 4
	note A_, 14
	note G#, 1
	note A_, 1
	note B_, 8
	octave 5
	note C#, 4
Music_ZinniaBattleORAS_Ch2_loop:
	notetype $6, $a0
	dutycycle 3
	octave 3
	note C#, 2
	note D_, 1
	note E_, 1
	notetype $c, $af
	note F#, 2
	intensity $c0
	note F#, 3
	intensity $c5
	note F#, 4
	intensity $c7
	note G#, 3
	note A_, 2
	octave 4
	notetype $6, $c0
	note E_, 2
	note D#, 1
	note D_, 1
	vibrato $12, $54
	notetype $c, $c0
	note C#, 5
	intensity $c5
	note C#, 4
	vibrato $12, $33
	intensity $c1
	octave 3
	note B_, 1
	octave 4
	note C#, 1
	octave 3
	note B_, 1
	intensity $c6
	note A_, 1
	intensity $c1
	note B_, 1
	note A_, 1
	note G#, 1
	intensity $af
	note F#, 1
	intensity $c0
	note F#, 3
	intensity $c7
	note F#, 5
	intensity $d5
	note G#, 3
	intensity $c7
	note F#, 2
	note E_, 2
	intensity $c0
	note C#, 8
	intensity $c7
	note C#, 6
	notetype $6, $a0
	note D_, 2
	note D#, 1
	note F_, 1
	notetype $c, $af
	note G_, 2
	intensity $c0
	note G_, 3
	intensity $c5
	note G_, 4
	intensity $c7
	note A_, 3
	note A#, 2
	octave 4
	notetype $6, $c0
	note F_, 2
	note E_, 1
	note D#, 1
	vibrato $12, $54
	notetype $c, $c0
	note D_, 5
	intensity $c5
	note D_, 4
	vibrato $12, $33
	intensity $c1
	note C_, 1
	note D_, 1
	note C_, 1
	intensity $c6
	octave 3
	note A#, 1
	intensity $c1
	octave 4
	note C_, 1
	octave 3
	note A#, 1
	note A_, 1
	intensity $af
	note G_, 1
	intensity $c0
	note G_, 3
	intensity $c7
	note G_, 5
	intensity $d5
	note A_, 3
	intensity $c7
	note G_, 2
	note F_, 2
	intensity $c0
	note D_, 8
	intensity $c7
	note D_, 8
	dutycycle 0
	notetype $6, $7f
	octave 4
	note A#, 1
	intensity $90
	note A#, 7
	intensity $95
	note A#, 8
	intensity $7f
	note A_, 1
	intensity $90
	note A_, 3
	intensity $95
	note A_, 4
	intensity $7f
	octave 5
	note C_, 1
	intensity $90
	note C_, 3
	intensity $95
	note C_, 4
	intensity $90
	octave 4
	note B_, 3
	intensity $95
	note B_, 5
	intensity $90
	note E_, 3
	intensity $95
	note E_, 5
	intensity $90
	note D#, 3
	intensity $95
	note D#, 5
	intensity $90
	note G#, 3
	intensity $95
	note G#, 5
	intensity $90
	note G_, 8
	intensity $95
	note G_, 6
	note F_, 1
	note D#, 1
	intensity $90
	note D_, 3
	intensity $95
	note D_, 5
	intensity $90
	note F_, 3
	intensity $95
	note F_, 4
	note C_, 1
	intensity $7f
	note D_, 1
	intensity $90
	note D_, 15
	intensity $97
	note D_, 16
	intensity $90
	note A#, 12
	intensity $95
	note A#, 4
	intensity $90
	note A_, 6
	intensity $95
	note A_, 2
	note A#, 4
	octave 5
	note C_, 4
	octave 4
	note A_, 1
	intensity $90
	note A#, 9
	intensity $95
	note A#, 4
	note A_, 1
	note G_, 1
	intensity $90
	note D#, 10
	intensity $95
	note D#, 5
	note D_, 1
	intensity $90
	note D#, 10
	intensity $95
	note D#, 6
	notetype $8, $94
	note C_, 1
	octave 3
	note G_, 1
	octave 4
	note C_, 1
	note D_, 1
	octave 3
	note G_, 1
	octave 4
	note D_, 1
	note D#, 1
	octave 3
	note G_, 1
	octave 4
	note D#, 1
	note D#, 1
	note F_, 1
	note G_, 1
	notetype $6, $90
	note A#, 8
	intensity $95
	note A#, 6
	octave 5
	note C_, 1
	octave 4
	note A#, 1
	intensity $90
	note A_, 8
	intensity $97
	note A_, 8
	intensity $b0
	note F#, 8
	intensity $b5
	note F#, 4
	notetype $8, $b4
	note F#, 1
	note C#, 1
	note F#, 1
	note G#, 1
	note C#, 1
	note G#, 1
	note A_, 1
	note C#, 1
	note A_, 1
	note B_, 1
	note C#, 1
	note B_, 1
	notetype $6, $b4
	octave 5
	note E_, 2
	octave 4
	note E_, 1
	note D#, 1
	intensity $b0
	note E_, 8
	intensity $b6
	note E_, 6
	note D_, 1
	note C#, 1
	intensity $b0
	note D_, 5
	intensity $b4
	note D_, 3
	intensity $b0
	note E_, 5
	intensity $b4
	note E_, 3
	intensity $b0
	note F#, 8
	intensity $b6
	note F#, 6
	note E_, 1
	note D#, 1
	intensity $b0
	note E_, 5
	intensity $b4
	note E_, 3
	intensity $b0
	note C#, 5
	intensity $b4
	note C#, 3
	intensity $b0
	note D_, 5
	intensity $b4
	note D_, 3
	notetype $8, $b4
	octave 3
	note B_, 1
	note D_, 1
	note F#, 1
	note B_, 1
	note D_, 1
	note F#, 1
	notetype $c, $b0
	octave 4
	note C#, 4
	intensity $b4
	note C#, 3
	dutycycle 3
	vibrato $12, $53
	notetype $3, $c0
	note D_, 1
	note D#, 1
	intensity $d0
	note E_, 1
	note F_, 1
	octave 4
	intensity $e0
	note F#, 8
	notetype $6, $e7
	note F#, 8
	intensity $e5
	note A_, 4
	intensity $e7
	note G#, 6
	note E_, 6
	note F#, 2
	note E_, 1
	note D_, 1
	note C#, 12
	octave 3
	intensity $c7
	note B_, 4
	octave 4
	note C#, 8
	octave 3
	note B_, 6
	octave 4
	note C#, 1
	octave 3
	note B_, 1
	notetype $c, $e7
	note F#, 6
	octave 4
	note C#, 2
	octave 3
	note B_, 3
	note A_, 3
	note G#, 2
	note F#, 6
	octave 4
	note C#, 2
	octave 3
	note B_, 2
	octave 4
	note C#, 2
	note D_, 2
	note E_, 2
	note F#, 6
	note A_, 2
	note G#, 2
	note E_, 2
	note C#, 2
	note G#, 2
	intensity $e0
	note F#, 8
	intensity $e7
	note F#, 9
	notetype $6, $c4
	octave 3
	note A_, 2
	note B_, 2
	note A_, 2
	note G#, 3
	note A_, 1
	note F#, 2
	note E_, 2
	note F#, 2
	note A_, 2
	note G#, 2
	note E_, 2
	note F#, 2
	note E_, 2
	note C#, 4
	note __, 2
	note C#, 2
	note F#, 2
	note G_, 2
	note A_, 3
	note G_, 2
	note __, 1
	note F#, 2
	note E_, 2
	note G_, 2
	note F#, 2
	note E_, 2
	note F#, 2
	note F#, 2
	note E_, 6

	note C#, 2
	note F#, 2
	note G_, 2
	note A_, 3
	note G_, 2
	note __, 1
	note F#, 2
	note E_, 2
	note G_, 2
	note F#, 2
	note E_, 2
	note F#, 2
	note B_, 2
	note E_, 6
	note C#, 2
	note F#, 2
	note G_, 2
	note A_, 3
	note G_, 2
	note __, 1
	note F#, 2
	note F#, 2
	note A_, 2
	note G#, 2
	note E_, 2
	note F#, 2
	note E_, 2
	loopchannel 0, Music_ZinniaBattleORAS_Ch2_loop

Music_ZinniaBattleORAS_Ch3:
	notetype $3, $19
	vibrato $12, $15
	octave 2
	note G#, 8
	note __, 16
	note F#, 4
	note G_, 1
	note G#, 1
	note A_, 1
	note A#, 1
	note D_, 16
	note E_, 16
	notetype $6, $19
	octave 2
	note C#, 16
	note E_, 14
	note D_, 1
	note E_, 1
	note F#, 14
	note E_, 1
	note F#, 1
	note G#, 16
	note A_, 12
	notetype $3, $19
	octave 3
	note C#, 6
	note C_, 1
	octave 2
	note B_, 1
	notetype $6, $19
	note A_, 12
	octave 3
	note E_, 4
	note F#, 14
	note E_, 1
	note F#, 1
	note E_, 8
	note F#, 8
Music_ZinniaBattleORAS_Ch3_loop_main:
Music_ZinniaBattleORAS_Ch3_loop_1:
	intensity $19
	octave 2
	note F#, 2
	octave 1
	intensity $29
	note F#, 1
	note __, 1
	note F#, 1
	note __, 1
	intensity $19
	octave 2
	note F#, 2
	octave 1
	intensity $29
	note F#, 1
	note __, 1
	note F#, 1
	note __, 1
	intensity $19
	octave 2
	note F#, 2
	octave 1
	intensity $29
	note F#, 1
	note __, 1
	note F#, 1
	note __, 1
	intensity $19
	octave 2
	note A_, 2
	octave 1
	intensity $29
	note F#, 1
	note __, 1
	note F#, 1
	note __, 1
	intensity $19
	octave 2
	note G#, 2
	octave 1
	intensity $29
	note F#, 1
	note __, 1
	intensity $19
	octave 2
	note G_, 2
	octave 1
	intensity $29
	note F#, 1
	note __, 1
	loopchannel 4, Music_ZinniaBattleORAS_Ch3_loop_1
Music_ZinniaBattleORAS_Ch3_loop_2:
	intensity $19
	octave 2
	note G_, 2
	octave 1
	intensity $29
	note G_, 1
	note __, 1
	note G_, 1
	note __, 1
	intensity $19
	octave 2
	note G_, 2
	octave 1
	intensity $29
	note G_, 1
	note __, 1
	note G_, 1
	note __, 1
	intensity $19
	octave 2
	note G_, 2
	octave 1
	intensity $29
	note G_, 1
	note __, 1
	note G_, 1
	note __, 1
	intensity $19
	octave 2
	note A#, 2
	octave 1
	intensity $29
	note G_, 1
	note __, 1
	note G_, 1
	note __, 1
	intensity $19
	octave 2
	note A_, 2
	octave 1
	intensity $29
	note G_, 1
	note __, 1
	intensity $19
	octave 2
	note G#, 2
	octave 1
	intensity $29
	note G_, 1
	note __, 1
	loopchannel 12, Music_ZinniaBattleORAS_Ch3_loop_2
	octave 2
	intensity $29
	note D_, 12
	intensity $39
	note D_, 4
	intensity $29
	note E_, 12
	intensity $39
	note E_, 4
	intensity $29
	note F#, 12
	intensity $39
	note F#, 4
	intensity $29
	note G_, 11
	note __, 1
	note G_, 4
	intensity $19
	note D_, 2
	note __, 3
	note F_, 1
	note F#, 6
	octave 3
	note F#, 4
	octave 2
	note C#, 4
	note __, 4
	octave 1
	note A_, 4
	octave 2
	note A_, 4
	octave 1
	note B_, 2
	note __, 4
	note B_, 6
	octave 2
	note B_, 4
	note G#, 3
	note __, 1
	note G#, 3
	note __, 1
	note G#, 3
	note __, 1
	note G#, 4
	callchannel Music_ZinniaBattleORAS_Ch3_branch_1
	note F#, 2
	note __, 4
	note F#, 2
	note __, 4
	note F#, 2
	note __, 4
	note G_, 2
	note __, 4
	note G_, 2
	note __, 2
	note G_, 2
	note __, 2
	note F#, 2
	note __, 4
	note F#, 2
	note __, 4
	note F#, 2
	note __, 4
	note E_, 2
	note __, 4
	note E_, 2
	note __, 2
	note E_, 2
	note __, 2
	callchannel Music_ZinniaBattleORAS_Ch3_branch_1
	note F#, 2
	note __, 4
	note F#, 2
	note __, 4
	note F#, 2
	note __, 4
	note G#, 2
	note __, 4
	note G#, 2
	note __, 2
	note G#, 2
	note __, 2
	callchannel Music_ZinniaBattleORAS_Ch3_branch_2
	callchannel Music_ZinniaBattleORAS_Ch3_branch_2
	note E_, 16
	intensity $29
	note E_, 12
	note __, 4
	intensity $19
	note B_, 16
	intensity $29
	note B_, 12
	note __, 4
	octave 3
	intensity $19
	note E_, 16
	note G#, 8
	note A_, 4
	note B_, 4
	loopchannel 0, Music_ZinniaBattleORAS_Ch3_loop_main

Music_ZinniaBattleORAS_Ch3_branch_1:
	note D_, 2
	note __, 4
	note D_, 2
	note __, 4
	note D_, 2
	note __, 4
	note E_, 2
	note __, 4
	note E_, 2
	note __, 2
	note E_, 2
	note __, 2
	endchannel

Music_ZinniaBattleORAS_Ch3_branch_2:
	note F#, 2
	note __, 4
	note F#, 2
	note __, 4
	note F#, 2
	note __, 4
	note F#, 2
	note __, 4
	note F#, 2
	note __, 2
	note F#, 2
	note __, 2
	endchannel

Music_ZinniaBattleORAS_Ch4:
	togglenoise $3
	notetype $3
	note C_, 16
	note __, 16
	note B_, 8
	note C_, 8
	callchannel Music_ZinniaBattleORAS_Ch4_branch_2
	note B_, 2
	note C#, 2
Music_ZinniaBattleORAS_Ch4_loop_1:
	note C#, 2
	note C#, 2
	loopchannel 6, Music_ZinniaBattleORAS_Ch4_loop_1
	note C#, 2
	notetype $3
	note D_, 1
	note D_, 1
	note D_, 1
	note D_, 1
	note D_, 1
	note D_, 1
	note D_, 1
	note D_, 1
	notetype $c
	note B_, 2
	callchannel Music_ZinniaBattleORAS_Ch4_branch_1
	note D#, 1
	note D_, 1
	callchannel Music_ZinniaBattleORAS_Ch4_branch_1
Music_ZinniaBattleORAS_Ch4_loop_main:
Music_ZinniaBattleORAS_Ch4_loop_2:
	note D#, 1
	note D_, 1
	callchannel Music_ZinniaBattleORAS_Ch4_branch_1
	loopchannel 8, Music_ZinniaBattleORAS_Ch4_loop_2
	note B_, 2
	callchannel Music_ZinniaBattleORAS_Ch4_branch_1
Music_ZinniaBattleORAS_Ch4_loop_3:
	note D#, 1
	note D_, 1
	callchannel Music_ZinniaBattleORAS_Ch4_branch_1
	loopchannel 7, Music_ZinniaBattleORAS_Ch4_loop_3
	note __, 16
	note D#, 14
	note D#, 2
Music_ZinniaBattleORAS_Ch4_loop_4:
	note C#, 1
	note C#, 1
	note C_, 1
	note C#, 1
	loopchannel 7, Music_ZinniaBattleORAS_Ch4_loop_4
	callchannel Music_ZinniaBattleORAS_Ch4_branch_2
	note B_, 2
	callchannel Music_ZinniaBattleORAS_Ch4_branch_1
	note D#, 1
	note D_, 1
	callchannel Music_ZinniaBattleORAS_Ch4_branch_1
Music_ZinniaBattleORAS_Ch4_loop_5:
	note B_, 2
	callchannel Music_ZinniaBattleORAS_Ch4_branch_1
	loopchannel 4, Music_ZinniaBattleORAS_Ch4_loop_5
	note D#, 1
	note D_, 1
	callchannel Music_ZinniaBattleORAS_Ch4_branch_1
	note B_, 2
	callchannel Music_ZinniaBattleORAS_Ch4_branch_1
	note D#, 1
	note D_, 1
	callchannel Music_ZinniaBattleORAS_Ch4_branch_1
	note B_, 2
	note C_, 1
	note D#, 1
	note D_, 1
	note D_, 1
	note C_, 1
	note D_, 1
	note D_, 1
	note D#, 1
	note C_, 1
	note D_, 1
	callchannel Music_ZinniaBattleORAS_Ch4_branch_2
	loopchannel 0, Music_ZinniaBattleORAS_Ch4_loop_main

Music_ZinniaBattleORAS_Ch4_branch_1:
	note C_, 1
	note D#, 1
	note D_, 1
	note D_, 1
	note C_, 1
	note D_, 1
	note D_, 1
	note D#, 1
	note C_, 1
	note D_, 1
	note D#, 1
	note D_, 1
	note C_, 1
	note D_, 1
	endchannel

Music_ZinniaBattleORAS_Ch4_branch_2:
	notetype $3
	note D#, 2
	note D#, 2
	note D#, 2
	note D#, 2
	note D_, 1
	note D_, 1
	note D_, 1
	note D_, 1
	note D_, 1
	note D_, 1
	note D_, 1
	note D_, 1
	notetype $c
	endchannel
