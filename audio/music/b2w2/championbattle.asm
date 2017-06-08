; Pokémon B2/W2 - Battle! Champion Iris
; Demixed by Mmmmmm
; https://pastebin.com/1TeQ2sMe
; https://hax.iimarck.us/topic/6777/2/

Music_ChampionBattleB2W2:
	dbw $c0, Music_ChampionBattleB2W2_Ch1
	dbw $01, Music_ChampionBattleB2W2_Ch2
	dbw $02, Music_ChampionBattleB2W2_Ch3
	dbw $03, Music_ChampionBattleB2W2_Ch4

Music_ChampionBattleB2W2_Ch1:
	tempo 100
	tone $0001
	vibrato $12, $15
	notetype $C, $82
	dutycycle 0
	octave 2
	note D_, 1
	note D_, 1
	callchannel Music_ChampionBattleB2W2_Ch1_branch_1
	dutycycle 0
	intensity $80
	octave 3
	note G_, 16
	note G_, 8
	note A_, 8
	note B_, 16
	note B_, 16
	octave 4
	note C_, 16
	octave 3
	note G_, 8
	note A_, 8
Music_ChampionBattleB2W2_Ch1_loop_main:
	intensity $80
	dutycycle 0
	octave 2
	callchannel Music_ChampionBattleB2W2_Ch1_branch_3
	callchannel Music_ChampionBattleB2W2_Ch1_branch_4
	callchannel Music_ChampionBattleB2W2_Ch1_branch_4
	callchannel Music_ChampionBattleB2W2_Ch1_branch_3
	callchannel Music_ChampionBattleB2W2_Ch1_branch_4
	dutycycle 1
	octave 5
	intensity $62
	note B_, 2
	octave 6
	note D_, 2
	octave 5
	note A_, 2
	octave 6
	note D_, 2
	octave 5
	note G_, 2
	note A_, 2
	note E_, 2
	note G_, 2
	note D_, 2
	octave 2
	dutycycle 0
	intensity $80
	callchannel Music_ChampionBattleB2W2_Ch1_branch_4
	callchannel Music_ChampionBattleB2W2_Ch1_branch_4
	intensity $80
	note D_, 2
	octave 1
	note G_, 2
	intensity $20
	note G_, 2
	note __, 2
	octave 2
	callchannel Music_ChampionBattleB2W2_Ch1_branch_4
	callchannel Music_ChampionBattleB2W2_Ch1_branch_3
	callchannel Music_ChampionBattleB2W2_Ch1_branch_5
	octave 2
	dutycycle 0
	intensity $80
	callchannel Music_ChampionBattleB2W2_Ch1_branch_2
	note G_, 2
	dutycycle 1
	octave 5
	intensity $62
	note D_, 2
	note G_, 2
	note E_, 2
	note A_, 2
	octave 2
	dutycycle 0
	intensity $80
	note D_, 2
	callchannel Music_ChampionBattleB2W2_Ch1_branch_2
	callchannel Music_ChampionBattleB2W2_Ch1_branch_5
	octave 2
	dutycycle 0
	intensity $80
	note G_, 2
	intensity $50
	note G_, 2
	dutycycle 1
	octave 4
	intensity $62
	note A_, 2
	octave 5
	note E_, 2
	note D_, 2
	note G_, 2
	octave 2
	dutycycle 0
	intensity $80
	octave 3
	note D_, 2
	intensity $50
	note D_, 2
	dutycycle 1
	octave 5
	intensity $62
	note B_, 2
	octave 6
	note D_, 2
	octave 5
	note A_, 2
	octave 6
	note D_, 2
	octave 5
	note G_, 1
	note A_, 1
	note E_, 1
	note G_, 1
	note D_, 1
	note E_, 1
	octave 4
	note B_, 1
	note D_, 1
	note __, 16
	note __, 8
	dutycycle 0
	intensity $84
	note B_, 4
	notetype $8, $82
	note G#, 2
	note B_, 2
	note G#, 2
	notetype $C, $84
	note G_, 14
	note __, 10
	intensity $82
	octave 5
	note C_, 1
	octave 4
	note G_, 1
	note F_, 1
	note D_, 1
	note C_, 1
	octave 3
	note A_, 1
	note G_, 1
	note F_, 1
	note D_, 11
	note __, 9
	note B_, 4
	notetype $8, $82
	octave 4
	note D#, 2
	note F_, 2
	note D#, 2
	notetype $C, $84
	note D_, 2
	note C_, 2
	octave 3
	note B_, 5
	note __, 16
	note G_, 1
	note G#, 1
	octave 4
	note C_, 1
	note D_, 1
	note F_, 1
	note G_, 1
	note G#, 1
	octave 5
	note C_, 1
	note D_, 1
	note F_, 1
	note G_, 1
	intensity $90
	octave 2
	callchannel Music_ChampionBattleB2W2_Ch3_branch_7
	callchannel Music_ChampionBattleB2W2_Ch1_branch_6
	octave 2
	note A#, 2
	callchannel Music_ChampionBattleB2W2_Ch3_branch_7
	note G_, 1
	intensity $30
	note G_, 1
	intensity $90
	note C#, 1
	intensity $30
	note C#, 1
	intensity $90
	note G_, 1
	intensity $30
	note G_, 1
	intensity $90
	note F_, 4
	note C#, 2
	note C_, 2
	octave 2
	note A#, 2
	callchannel Music_ChampionBattleB2W2_Ch3_branch_9
	callchannel Music_ChampionBattleB2W2_Ch1_branch_6
	octave 1
	note A#, 2
	callchannel Music_ChampionBattleB2W2_Ch3_branch_9
	octave 2
	note C_, 8
	note F_, 8
	callchannel Music_ChampionBattleB2W2_Ch1_branch_7
	callchannel Music_ChampionBattleB2W2_Ch1_branch_8
	intensity $90
	note __, 2
	note B_, 1
	intensity $30
	note B_, 1
	intensity $90
	note B_, 2
	intensity $30
	note B_, 2
	intensity $90
	note B_, 4
	intensity $30
	note A#, 2
	note __, 6
	callchannel Music_ChampionBattleB2W2_Ch1_branch_8
	note __, 2
	intensity $90
	callchannel Music_ChampionBattleB2W2_Ch1_branch_7
	callchannel Music_ChampionBattleB2W2_Ch1_branch_8
	intensity $90
	note A#, 2
	note A_, 2
	intensity $30
	note A_, 2
	note __, 2
	intensity $90
	note A_, 2
	intensity $30
	note A_, 2
	note __, 2
	intensity $90
	note D_, 2
	intensity $60
	note D_, 2
	intensity $30
	note D_, 2
	intensity $90
	note G_, 4
	note G#, 2
	note A_, 4
	octave 2
	note C_, 4
	dutycycle 1
	intensity $80
	octave 2
	note A_, 4
	intensity $87
	note A_, 4
	note G#, 4
	note G_, 4
	intensity $80
	note F#, 4
	intensity $87
	note F#, 4
	intensity $80
	note D#, 4
	intensity $87
	note D#, 4
	intensity $80
	note D_, 8
	intensity $87
	note D_, 8
	intensity $80
	note C_, 4
	intensity $87
	note C_, 4
	intensity $80
	note D#, 4
	intensity $87
	note D#, 4
	intensity $80
	note D_, 8
	intensity $86
	octave 4
	note F_, 16
	note D#, 6
	note F_, 1
	note D#, 1
	note D_, 16
	note __, 16
Music_ChampionBattleB2W2_Ch1_loop_1:
	octave 4
	intensity $62
	note D_, 2
	octave 5
	note D_, 2
	octave 4
	note D_, 2
	octave 5
	note E_, 2
	octave 4
	note D_, 2
	octave 5
	note C_, 2
	octave 3
	note B_, 2
	octave 5
	note C_, 2
	octave 4
	note D_, 1
	note G_, 1
	note A_, 1
	octave 5
	note D_, 1
	note G_, 1
	note D_, 1
	octave 4
	note A_, 1
	note D_, 1
	loopchannel 3, Music_ChampionBattleB2W2_Ch1_loop_1
	note A#, 2
	note D#, 2
	note A#, 2
	octave 5
	note G_, 2
	octave 4
	note A#, 2
	note D#, 2
	note A#, 2
	octave 5
	note D#, 2
	octave 4
	note A#, 2
	note D#, 2
	note A#, 2
	octave 5
	note G_, 2
	note F#, 2
	octave 4
	note A_, 2
	note D_, 2
	note A_, 2
	octave 5
	note D_, 2
	octave 4
	note D_, 2
	octave 5
	note F#, 2
	octave 4
	note A_, 2
	note D_, 2
	note A_, 2
	note G_, 2
	note D_, 2
	note A_, 2
	octave 5
	note D_, 2
	note F#, 2
	octave 4
	note D_, 2
	dutycycle 0
	intensity $90
	octave 3
	note __, 2
	note D_, 4
	note __, 2
	note D_, 4
	note __, 4
	note F_, 2
	note E_, 2
	note F_, 2
	note F#, 2
	note __, 2
	note F_, 2
	note F#, 2
	note __, 2
	callchannel Music_ChampionBattleB2W2_Ch1_branch_1
	intensity $85
	octave 3
	note D_, 4
	note E_, 2
	note D_, 4
	octave 4
	note C_, 2
	octave 3
	note B_, 2
	octave 4
	note C_, 2
	note D_, 4
	note E_, 2
	note D_, 2
	note __, 2
	octave 3
	note G_, 8
	note A_, 2
	octave 4
	note D_, 2
	note D#, 4
	note A_, 2
	note B_, 2
	note D_, 4
	octave 3
	note A_, 2
	note B_, 2
	octave 4
	note D_, 2
	note C_, 2
	octave 3
	note B_, 2
	note A_, 2
	note G_, 2
	note __, 2
	note D_, 2
	note C_, 2
	note D#, 4
	note G#, 2
	octave 4
	note D#, 2
	note D_, 4
	note D_, 4
	note __, 2
	note D_, 2
	note __, 2
	note A_, 4
	note __, 4
	intensity $97
	callchannel Music_ChampionBattleB2W2_Ch1_branch_9
	callchannel Music_ChampionBattleB2W2_Ch1_branch_9
	note __, 8
	callchannel Music_ChampionBattleB2W2_Ch1_branch_9
	octave 3
	note E_, 2
	note D_, 2
	octave 2
	note A_, 2
	octave 3
	note D_, 2
	octave 2
	note G_, 2
	note A_, 2
	note G_, 2
	octave 3
	note D_, 4
	octave 2
	note B_, 2
	octave 3
	note D_, 2
	note E_, 4
	note A_, 2
	note B_, 2
	note D_, 4
	octave 2
	note A_, 2
	note B_, 2
	octave 3
	note D_, 2
	intensity $42
	octave 5
	note D_, 1
	note G_, 1
	note D_, 1
	octave 6
	note D_, 1
	octave 5
	note G_, 1
	octave 6
	note G_, 1
	note D_, 1
	octave 7
	note D_, 1
	intensity $90
	dutycycle 0
	octave 2
	note A#, 5
	note __, 1
	note A#, 2
	note __, 2
	note A#, 6
	octave 3
	note C_, 5
	note __, 1
	note C_, 2
	note __, 2
	note C_, 6
	octave 3
	note D_, 8
	octave 2
	note D_, 16
	note C_, 8
	note D#, 16
	note D_, 14
	octave 1
	notetype $6, $90
	note D_, 1
	note __, 1
	note D_, 1
	note __, 1
	notetype $c, $90
	octave 2
	note C_, 8
	note D_, 8
	octave 1
	note G_, 8
	octave 2
	note D#, 8
	note D_, 2
	intensity $60
	note D_, 2
	intensity $30
	note D_, 2
	intensity $90
	note D_, 2
	intensity $60
	note D_, 2
	intensity $30
	note D_, 2
	intensity $90
	note D_, 2
	intensity $60
	note D_, 2
	intensity $30
	note D_, 2
	intensity $90
	note G_, 2
	intensity $60
	note G_, 2
	intensity $30
	note G_, 2
	intensity $90
	note G_, 1
	note __, 1
	note G_, 2
	intensity $60
	note G_, 2
	intensity $30
	note G_, 2
	loopchannel 0, Music_ChampionBattleB2W2_Ch1_loop_main

Music_ChampionBattleB2W2_Ch1_branch_1:
	intensity $42
	dutycycle 1
	octave 6
	note B_, 1
	octave 7
	note D_, 1
	note C_, 1
	note D#, 1
	octave 6
	note B_, 1
	octave 7
	note D_, 1
	octave 6
	note A_, 1
	octave 7
	note C_, 1
	octave 6
	note G_, 1
	note B_, 1
	note F#, 1
	note A_, 1
	note E_, 1
	note G_, 1
	note D_, 1
	note F#, 1
	note C_, 1
	note D#, 1
	octave 5
	note B_, 1
	octave 6
	note D_, 1
	octave 5
	note A_, 1
	octave 6
	note C_, 1
	note G_, 1
	note B_, 1
	note F#, 1
	note A_, 1
	note E_, 1
	note G_, 1
	note D_, 1
	note F#, 1
	note C_, 1
	note E_, 1
	endchannel


Music_ChampionBattleB2W2_Ch1_branch_2:
	note G_, 2
	intensity $50
	note G_, 2
	intensity $80
	note D_, 2
	endchannel

Music_ChampionBattleB2W2_Ch1_branch_3:
	intensity $80
	note D_, 1
	intensity $20
	note D_, 1
	endchannel

Music_ChampionBattleB2W2_Ch1_branch_4:
	intensity $80
	note D_, 2
	intensity $20
	note D_, 2
	endchannel

Music_ChampionBattleB2W2_Ch1_branch_5:
	dutycycle 1
	octave 5
	intensity $62
	note G_, 1
	note E_, 1
	note D_, 1
	octave 4
	note A_, 1
	note B_, 1
	note A_, 1
	note G_, 1
	note E_, 1
	endchannel

Music_ChampionBattleB2W2_Ch1_branch_6:
	note G_, 1
	intensity $30
	note G_, 1
	intensity $90
	note G_, 1
	intensity $30
	note G_, 1
	intensity $90
	note G_, 1
	intensity $30
	note G_, 1
	intensity $90
	note F_, 4
	note C#, 2
	note C_, 2
	endchannel

Music_ChampionBattleB2W2_Ch1_branch_7:
	octave 2
	note D_, 1
	intensity $30
	note D_, 1
	intensity $90
	note D_, 2
	intensity $30
	note D_, 2
	intensity $90
	note F_, 4
	note E_, 2
	note D#, 2
	note D_, 2
	intensity $30
	note D_, 2
	endchannel

Music_ChampionBattleB2W2_Ch1_branch_8:
	octave 1
	intensity $90
	note E_, 2
	note D#, 2
	intensity $30
	note D#, 2
	intensity $90
	note F#, 2
	note F_, 2
	intensity $30
	note F_, 2
	endchannel

Music_ChampionBattleB2W2_Ch1_branch_9:
	octave 3
	note G_, 2
	note E_, 2
	note D_, 2
	note E_, 2
	octave 2
	note B_, 2
	note __, 2
	endchannel

Music_ChampionBattleB2W2_Ch2:
	tone $0001
	dutycycle 2
	vibrato $12, $15
	notetype $C, $B0
	note __, 2
	callchannel Music_ChampionBattleB2W2_Ch2_branch_1
	note G_, 8
	note B_, 8
	note __, 4
	note G_, 4
	note A_, 2
	note G_, 4
	note D_, 2
	intensity $B0
	callchannel Music_ChampionBattleB2W2_Ch2_branch_1
	note G_, 6
	note B_, 10
	note __, 2
	note D_, 2
	note E_, 2
	note D_, 2
	notetype $8, $B0
	note A_, 4
	note G_, 4
	note F_, 4
Music_ChampionBattleB2W2_Ch2_loop_main:
	octave 4
	notetype $C, $B0
	note G_, 4
	intensity $80
	note G_, 4
	octave 5
	intensity $B0
	note D_, 4
	intensity $80
	note D_, 4
	octave 4
	intensity $B0
	note A_, 4
	intensity $80
	note A_, 4
	octave 5
	intensity $B0
	note E_, 4
	intensity $80
	note E_, 4
	intensity $B0
	note D_, 4
	intensity $80
	note D_, 4
	octave 4
	intensity $B0
	note A_, 4
	intensity $80
	note A_, 4
	intensity $B0
	note B_, 4
	intensity $80
	note B_, 4
	intensity $B0
	note E_, 4
	intensity $80
	note E_, 4
	intensity $B0
	octave 3
	note G_, 4
	intensity $80
	note G_, 4
	octave 4
	intensity $B0
	note D_, 4
	intensity $80
	note D_, 4
	octave 3
	intensity $B0
	note A_, 4
	intensity $80
	note A_, 4
	octave 4
	intensity $B0
	note E_, 4
	intensity $80
	note E_, 4
	intensity $B0
	note D_, 4
	intensity $80
	note D_, 4
	octave 3
	intensity $B0
	note A_, 4
	intensity $80
	note A_, 4
	intensity $B0
	note B_, 4
	intensity $80
	note B_, 4
	intensity $B0
	note D_, 4
	intensity $80
	note D_, 4
	intensity $A5
	callchannel Music_ChampionBattleB2W2_Ch2_branch_2
	callchannel Music_ChampionBattleB2W2_Ch2_branch_2
	note __, 2
	note G_, 4
	note __, 2
	note F_, 4
	note __, 2
	note A_, 4
	note __, 2
	note G_, 2
	note F_, 4
	note G#, 4
	note __, 4
	note G_, 4
	note F_, 4
	note __, 4
	note A_, 4
	note __, 2
	note G_, 4
	octave 4
	intensity $B5
	note F_, 2
	note G#, 4
	intensity $B0
	note G_, 16
	intensity $B7
	note G_, 16
	note __, 8
	dutycycle 1
	octave 5
	intensity $82
	note G_, 1
	note F_, 1
	note D_, 1
	note C_, 1
	octave 4
	note G#, 1
	note G_, 1
	note F_, 1
	note D_, 1
	note C#, 1
	note C_, 1
	note A#, 1
	note G_, 3
	note __, 6
	octave 4
	dutycycle 2
	intensity $B5
	note F_, 2
	note G#, 2
	intensity $B0
	note G_, 16
	intensity $B7
	note G_, 16
	note __, 2
	intensity $B0
	octave 3
	note G_, 2
	octave 4
	note G_, 2
	octave 3
	note F_, 2
	octave 4
	note F_, 2
	octave 3
	note G_, 2
	octave 4
	note G_, 2
	octave 3
	note A#, 2
	octave 4
	note A#, 2
	intensity $90
	note G#, 1
	octave 5
	intensity $50
	note G#, 1
	intensity $90
	note C_, 1
	octave 6
	intensity $50
	note C_, 1
	octave 5
	intensity $90
	note D#, 1
	octave 6
	intensity $50
	note D#, 1
	octave 5
	intensity $90
	note G#, 1
	octave 6
	intensity $50
	note G#, 1
	octave 5
	intensity $90
	note C_, 1
	octave 6
	intensity $50
	note C_, 1
	octave 5
	intensity $90
	note F_, 1
	octave 6
	intensity $50
	note F_, 1
	octave 5
	intensity $90
	note A_, 1
	octave 6
	intensity $50
	note A_, 1
	intensity $90
	note C_, 1
	octave 7
	intensity $50
	note C_, 1
	dutycycle 0
	octave 3
	callchannel Music_ChampionBattleB2W2_Ch2_branch_3
	note __, 2
	dutycycle 2
	octave 5
	note G_, 2
	note C#, 2
	note C_, 2
	octave 4
	note A#, 2
	note F_, 2
	note D#, 2
	octave 3
	note A#, 2
	octave 4
	callchannel Music_ChampionBattleB2W2_Ch2_branch_3
	note __, 16
	dutycycle 0
	octave 3
	callchannel Music_ChampionBattleB2W2_Ch2_branch_3
	dutycycle 2
	intensity $90
	octave 4
	note D_, 2
	note C#, 2
	note C_, 2
	note A#, 4
	note A_, 2
	note G_, 2
	note F#, 2
	octave 3
	intensity $80
	note A#, 14
	octave 4
	note C#, 1
	octave 3
	note A#, 1
	note A_, 8
	intensity $87
	note A_, 8
	intensity $80
	note D_, 4
	intensity $87
	note D_, 4
	note C#, 4
	note C_, 4
	intensity $80
	octave 2
	note B_, 4
	intensity $87
	note B_, 4
	intensity $80
	note G#, 4
	intensity $87
	note G#, 4
	intensity $80
	note G_, 8
	intensity $87
	note G_, 8
	intensity $80
	note F_, 4
	intensity $87
	note F_, 4
	intensity $80
	note G#, 4
	intensity $87
	note G#, 4
	intensity $80
	note G_, 8
	intensity $87
	note G_, 16
	octave 1
	intensity $80
	note D_, 8
	note G_, 8
	octave 2
	note D_, 8
	note G_, 4
	octave 3
	intensity $90
	note D_, 4
	note G_, 4
	octave 4
	intensity $A0
	note D_, 4
	callchannel Music_ChampionBattleB2W2_Ch2_branch_4
	callchannel Music_ChampionBattleB2W2_Ch2_branch_4
	intensity $B4
	octave 4
	note D_, 2
	note D_, 2
	note D_, 2
	note E_, 4
	note E_, 2
	note D_, 4
	intensity $B7
	note G_, 4
	note A_, 4
	intensity $B0
	note F_, 12
	intensity $B7
	note F_, 12
	intensity $B0
	note F#, 16
	intensity $B7
	note F#, 16
	note __, 16
	note __, 12
	callchannel Music_ChampionBattleB2W2_Ch2_branch_5
	octave 4
	note D_, 2
	note E_, 2
	note A_, 2
	callchannel Music_ChampionBattleB2W2_Ch2_branch_6
	note G#, 2
	note __, 2
	octave 5
	note C_, 2
	note G_, 2
	note F#, 6
	intensity $B7
	note F#, 6
	note __, 2
	callchannel Music_ChampionBattleB2W2_Ch2_branch_5
	note C_, 2
	octave 4
	note B_, 2
	note A_, 2
	callchannel Music_ChampionBattleB2W2_Ch2_branch_6
	note G_, 2
	note __, 2
	note A#, 2
	octave 5
	note F_, 2
	note D#, 4
	note C_, 2
	octave 4
	note A#, 2
	note A_, 2
	note __, 2
	octave 5
	note C_, 2
	note A_, 2
	note G_, 16
	intensity $A0
	note G_, 16
	intensity $90
	note G_, 8
	intensity $80
	note G_, 8
	intensity $87
	note G_, 16
	note __, 16
	note __, 16
	note __, 2
	intensity $40
	note G_, 8
	intensity $4F
	note G_, 8
	intensity $40
	note B_, 8
	intensity $4F
	note B_, 8
	loopchannel 0, Music_ChampionBattleB2W2_Ch2_loop_main

Music_ChampionBattleB2W2_Ch2_branch_1:
	octave 5
	note D_, 16
	intensity $B7
	note D_, 9
	note __, 1
	intensity $B0
	note C_, 2
	octave 4
	note B_, 2
	note A_, 2
	intensity $b7
	endchannel

Music_ChampionBattleB2W2_Ch2_branch_2:
	note G_, 4
	note __, 2
	note F_, 4
	note __, 2
	note A_, 4
	note __, 2
	note G_, 4
	note __, 2
	note F_, 4
	note G#, 4
	endchannel

Music_ChampionBattleB2W2_Ch2_branch_3:
	intensity $B3
	note G_, 2
	intensity $B0
	note G_, 4
	note A#, 4
	note A_, 2
	note G#, 2
	note G_, 2
	endchannel

Music_ChampionBattleB2W2_Ch2_branch_4:
	octave 4
	intensity $B4
	note G_, 2
	note G_, 2
	note G_, 2
	note B_, 4
	note B_, 2
	note A_, 4
	intensity $B7
	octave 5
	note D_, 8
	endchannel

Music_ChampionBattleB2W2_Ch2_branch_5:
	octave 4
	intensity $B0
	note D_, 4
	octave 5
	note D_, 12
	intensity $B7
	note D_, 14
	intensity $B0
	endchannel

Music_ChampionBattleB2W2_Ch2_branch_6:
	note G_, 4
	note A_, 2
	note G_, 10
	intensity $B7
	note G_, 10
	intensity $B0
	octave 5
	note D_, 6
	note __, 2
	octave 4
	note E_, 2
	note G_, 2
	note A_, 4
	octave 5
	note D_, 2
	note E_, 2
	octave 4
	note G_, 4
	note D_, 2
	note E_, 2
	note G_, 10
	note __, 2
	note F_, 2
	note D#, 2
	endchannel

Music_ChampionBattleB2W2_Ch3:
	stereopanning $ff
	notetype $6, $19
	octave 1
	note D_, 1
	note __, 1
	note D_, 1
	note __, 1
	notetype $C, $19
	octave 2
	callchannel Music_ChampionBattleB2W2_Ch3_branch_1
	callchannel Music_ChampionBattleB2W2_Ch3_branch_1
Music_ChampionBattleB2W2_Ch3_loop_main:
	octave 1
	intensity $19
	callchannel Music_ChampionBattleB2W2_Ch3_branch_4
	callchannel Music_ChampionBattleB2W2_Ch3_branch_5
	callchannel Music_ChampionBattleB2W2_Ch3_branch_5
	callchannel Music_ChampionBattleB2W2_Ch3_branch_4
	callchannel Music_ChampionBattleB2W2_Ch3_branch_5
	note __, 2
	callchannel Music_ChampionBattleB2W2_Ch3_branch_5
	callchannel Music_ChampionBattleB2W2_Ch3_branch_4
	callchannel Music_ChampionBattleB2W2_Ch3_branch_4
	callchannel Music_ChampionBattleB2W2_Ch3_branch_5
	intensity $19
	note F_, 2
	callchannel Music_ChampionBattleB2W2_Ch3_branch_4
	callchannel Music_ChampionBattleB2W2_Ch3_branch_5
	callchannel Music_ChampionBattleB2W2_Ch3_branch_5
	intensity $19
	note G_, 2
	note D_, 2
	intensity $39
	note D_, 2
	note __, 2
	callchannel Music_ChampionBattleB2W2_Ch3_branch_5
	callchannel Music_ChampionBattleB2W2_Ch3_branch_4
	callchannel Music_ChampionBattleB2W2_Ch3_branch_4
	callchannel Music_ChampionBattleB2W2_Ch3_branch_5
	intensity $19
	note F_, 2
	callchannel Music_ChampionBattleB2W2_Ch3_branch_2
	callchannel Music_ChampionBattleB2W2_Ch3_branch_2
	callchannel Music_ChampionBattleB2W2_Ch3_branch_3
	callchannel Music_ChampionBattleB2W2_Ch3_branch_2
	callchannel Music_ChampionBattleB2W2_Ch3_branch_6
	callchannel Music_ChampionBattleB2W2_Ch3_branch_2
	callchannel Music_ChampionBattleB2W2_Ch3_branch_2
	callchannel Music_ChampionBattleB2W2_Ch3_branch_3
	callchannel Music_ChampionBattleB2W2_Ch3_branch_2
	callchannel Music_ChampionBattleB2W2_Ch3_branch_6
Music_ChampionBattleB2W2_Ch3_loop_1:
	octave 1
	note G_, 2
	octave 2
	note D_, 2
	octave 1
	note G_, 2
	octave 2
	note G_, 2
	octave 1
	note G_, 2
	octave 2
	note F_, 2
	octave 1
	note G_, 2
	octave 2
	note D_, 2
	loopchannel 8, Music_ChampionBattleB2W2_Ch3_loop_1
	callchannel Music_ChampionBattleB2W2_Ch3_branch_7
	callchannel Music_ChampionBattleB2W2_Ch3_branch_8
	octave 2
	note A#, 2
	callchannel Music_ChampionBattleB2W2_Ch3_branch_7
	note G_, 1
	intensity $39
	note G_, 1
	intensity $19
	note C#, 1
	intensity $39
	note C#, 1
	intensity $19
	note G_, 1
	intensity $39
	note G_, 1
	intensity $19
	note F_, 4
	note C#, 2
	note C_, 2
	octave 2
	note A#, 2
	callchannel Music_ChampionBattleB2W2_Ch3_branch_9
	callchannel Music_ChampionBattleB2W2_Ch3_branch_8
	octave 1
	note A#, 2
	callchannel Music_ChampionBattleB2W2_Ch3_branch_9
	note G#, 8
	octave 3
	note C_, 8
	callchannel Music_ChampionBattleB2W2_Ch3_branch_10
	callchannel Music_ChampionBattleB2W2_Ch3_branch_11
	octave 1
	intensity $19
	note C_, 2
	octave 2
	note G_, 1
	intensity $39
	note G_, 1
	intensity $19
	note G_, 2
	intensity $39
	note G_, 2
	intensity $19
	note F_, 4
	intensity $39
	note F_, 2
	note __, 6
	callchannel Music_ChampionBattleB2W2_Ch3_branch_11
	octave 1
	intensity $19
	note C_, 2
	callchannel Music_ChampionBattleB2W2_Ch3_branch_10
	callchannel Music_ChampionBattleB2W2_Ch3_branch_11
	octave 2
	intensity $19
	note D#, 2
	note D_, 2
	intensity $39
	note D_, 2
	note __, 2
	intensity $19
	note D_, 2
	intensity $39
	note D_, 2
	note __, 2
	intensity $19
	octave 1
	note F#, 2
	intensity $29
	note F#, 2
	intensity $39
	note F#, 2
	intensity $19
	octave 3
	note C_, 4
	note C#, 2
	note D_, 4
	note F_, 4
Music_ChampionBattleB2W2_Ch3_loop_2:
	octave 1
	note D_, 2
	octave 2
	note D_, 2
	loopchannel 12, Music_ChampionBattleB2W2_Ch3_loop_2
Music_ChampionBattleB2W2_Ch3_loop_3:
	octave 1
	note C_, 2
	octave 2
	note C_, 2
	loopchannel 4, Music_ChampionBattleB2W2_Ch3_loop_3
Music_ChampionBattleB2W2_Ch3_loop_4:
	octave 1
	note D_, 2
	octave 2
	note D_, 2
	loopchannel 10, Music_ChampionBattleB2W2_Ch3_loop_4
	octave 1
	note F_, 2
	octave 2
	note F_, 2
	octave 1
	note F_, 2
	octave 2
	note F_, 2
	octave 1
	note G_, 2
	octave 2
	note G_, 2
	octave 1
	note G_, 2
	octave 2
	note G_, 2
	octave 1
	note B_, 2
	octave 2
	note B_, 2
	octave 1
	note B_, 2
	octave 2
	note B_, 2
	callchannel Music_ChampionBattleB2W2_Ch3_branch_12
	note D_, 2
	note F#, 2
	octave 1
	note G_, 2
	octave 2
	callchannel Music_ChampionBattleB2W2_Ch3_branch_12
	octave 2
	note D_, 2
	note F_, 2
	octave 1
	note G_, 2
	callchannel Music_ChampionBattleB2W2_Ch3_branch_12
	note G_, 2
	octave 2
	note D_, 2
	note G_, 2
	note D#, 2
	note A#, 2
	note D#, 2
	note A#, 2
	note D#, 2
	note A#, 2
	note D#, 2
	octave 3
	note D#, 2
	octave 2
	note D#, 2
	note A#, 2
	note D#, 2
	octave 3
	note D#, 2
Music_ChampionBattleB2W2_Ch3_loop_5:
	octave 2
	note D_, 2
	octave 3
	note D_, 2
	loopchannel 8, Music_ChampionBattleB2W2_Ch3_loop_5
	octave 1
	note D_, 2
	octave 2
	note D_, 2
	note __, 4
	octave 3
	note D_, 2
	octave 2
	note D_, 2
	note __, 4
	note C#, 2
	note C_, 2
	note C#, 2
	note D_, 2
	note __, 2
	note C#, 2
	note D_, 2
	note __, 2
	octave 3
	note D_, 1
	intensity $39
	note D_, 1
	intensity $19
	note D_, 2
	intensity $39
	note D_, 2
	intensity $19
	note D_, 2
	intensity $39
	note D_, 2
	intensity $19
	note D_, 2
	intensity $39
	note D_, 2
	intensity $19
	note G_, 4
	note D_, 2
	intensity $39
	note D_, 2
	intensity $19
	note D_, 2
	intensity $39
	note D_, 2
	intensity $19
	note C_, 4
	octave 2
	note A#, 2
	note B_, 4
	octave 3
	note C_, 2
	octave 2
	note B_, 4
	octave 1
	note B_, 2
	octave 2
	note C_, 2
	intensity $19
	note D_, 2
	intensity $39
	note D_, 2
	intensity $19
	note B_, 2
	intensity $39
	note B_, 2
	intensity $19
	note B_, 4
	octave 3
	note D_, 6
	note E_, 1
	intensity $39
	note E_, 1
	intensity $19
	note E_, 2
	intensity $39
	note E_, 2
	intensity $19
	note D#, 4
	intensity $39
	note D#, 2
	note __, 2
	intensity $19
	note E_, 4
	note D_, 2
	note E_, 2
	note G_, 4
	octave 2
	note A_, 2
	note A#, 2
	note B_, 2
	octave 3
	note F_, 4
	note D#, 2
	note D_, 4
	octave 2
	note G_, 2
	note A#, 2
	octave 3
	intensity $19
	note D_, 2
	intensity $39
	note D_, 2
	intensity $19
	note D_, 2
	intensity $39
	note D_, 2
	note __, 2
	intensity $19
	note D_, 2
	intensity $39
	note D_, 2
	octave 1
	intensity $19
	note A_, 4
	octave 2
	note D_, 8
	note G_, 8
	note B_, 8
	note A_, 8
	note G_, 4
	note A_, 2
	note G_, 10
	note D_, 16
	note E_, 8
	note F#, 8
	note G_, 6
	note D_, 6
	note E_, 4
	note D#, 6
	note D_, 2
	note __, 2
	note D#, 6
	note F_, 6
	note D#, 2
	note __, 2
	note F_, 6
	octave 3
	note G_, 8
	octave 2
	note G_, 16
	note F_, 8
	note G#, 16
	note G_, 14
	octave 1
	notetype $6, $19
	note G_, 1
	note __, 1
	note G_, 1
	note __, 1
	notetype $c, $19
	octave 2
	note F_, 8
	note G_, 8
	note C_, 8
	note G#, 8
	note G_, 2
	intensity $29
	note G_, 2
	intensity $39
	note G_, 2
	intensity $19
	note G_, 2
	intensity $29
	note G_, 2
	intensity $39
	note G_, 2
	intensity $19
	note G_, 2
	intensity $29
	note G_, 2
	intensity $39
	note G_, 2
	intensity $19
	note B_, 2
	intensity $29
	note B_, 2
	intensity $39
	note B_, 2
	intensity $19
	note B_, 1
	note __, 1
	note B_, 2
	intensity $29
	note B_, 2
	intensity $39
	note B_, 2
	loopchannel 0, Music_ChampionBattleB2W2_Ch3_loop_main

Music_ChampionBattleB2W2_Ch3_branch_1:
	note G_, 16
	note F_, 16
	note E_, 16
	note D#, 8
	note F_, 8
	endchannel

Music_ChampionBattleB2W2_Ch3_branch_2:
	octave 2
	note D_, 2
	intensity $29
	note D_, 2
	intensity $19
	octave 1
	note G_, 2
	endchannel

Music_ChampionBattleB2W2_Ch3_branch_3:
	octave 2
	note G_, 2
	intensity $29
	note G_, 2
	intensity $19
	octave 1
	note G_, 2
	endchannel

Music_ChampionBattleB2W2_Ch3_branch_4:
	intensity $19
	note G_, 1
	intensity $39
	note G_, 1
	endchannel

Music_ChampionBattleB2W2_Ch3_branch_5:
	intensity $19
	note G_, 2
	intensity $39
	note G_, 2
	endchannel

Music_ChampionBattleB2W2_Ch3_branch_6:
	octave 2
	note G_, 2
	octave 1
	note G_, 2
	octave 2
	note A_, 2
	note G_, 2
	endchannel

Music_ChampionBattleB2W2_Ch3_branch_7:
	note G_, 2
	octave 3
	note G_, 2
	octave 2
	note F_, 2
	octave 3
	note F_, 2
	octave 2
	note G_, 2
	octave 3
	note G_, 2
	octave 2
	note A#, 2
	octave 3
	note A#, 2
	endchannel

Music_ChampionBattleB2W2_Ch3_branch_8:
	note G_, 1
	intensity $39
	note G_, 1
	intensity $19
	note G_, 1
	intensity $39
	note G_, 1
	intensity $19
	note G_, 1
	intensity $39
	note G_, 1
	intensity $19
	note F_, 4
	note C#, 2
	note C_, 2
	endchannel

Music_ChampionBattleB2W2_Ch3_branch_9:
	octave 1
	note G_, 2
	octave 2
	note G_, 2
	octave 1
	note F_, 2
	octave 2
	note F_, 2
	octave 1
	note G_, 2
	octave 2
	note G_, 2
	octave 1
	note A#, 2
	octave 2
	note A#, 2
	endchannel

Music_ChampionBattleB2W2_Ch3_branch_10:
	octave 2
	note B_, 1
	intensity $39
	note B_, 1
	intensity $19
	note B_, 2
	intensity $39
	note B_, 2
	intensity $19
	octave 3
	note D_, 4
	note C#, 2
	note C_, 2
	octave 2
	note B_, 2
	intensity $39
	note B_, 2
	endchannel

Music_ChampionBattleB2W2_Ch3_branch_11:
	octave 1
	intensity $19
	note B_, 2
	note A#, 2
	intensity $39
	note A#, 2
	intensity $19
	octave 2
	note C#, 2
	note C_, 2
	intensity $39
	note C_, 2
	endchannel

Music_ChampionBattleB2W2_Ch3_branch_12:
	octave 2
	intensity $19
	note C_, 1
	intensity $39
	note C_, 1
	loopchannel 3, Music_ChampionBattleB2W2_Ch3_branch_12
	intensity $19
	note D_, 2
	intensity $39
	note D_, 2
	intensity $19
	note D_, 2
	note C_, 4
	octave 1
	note B_, 2
	endchannel

Music_ChampionBattleB2W2_Ch4:
	togglenoise $3
	notetype $c
	note C_, 1
	note C_, 1
	callchannel Music_ChampionBattleB2W2_Ch4_branch_1
	note C_, 2
	note C_, 4
	note D#, 2
	callchannel Music_ChampionBattleB2W2_Ch4_branch_1
	notetype $8
	note C_, 4
	note C_, 4
	note D#, 4
Music_ChampionBattleB2W2_Ch4_loop_main:
	notetype $c
	callchannel Music_ChampionBattleB2W2_Ch4_branch_2
	callchannel Music_ChampionBattleB2W2_Ch4_branch_2
	callchannel Music_ChampionBattleB2W2_Ch4_branch_2
	note D#, 4
	note C_, 2
	note D#, 4
	note D#, 2
	note C_, 2
	note D#, 1
	note D#, 1
Music_ChampionBattleB2W2_Ch4_loop_1:
	note C_, 2
	note D#, 2
	loopchannel 14, Music_ChampionBattleB2W2_Ch4_loop_1
	note C_, 1
	note C_, 1
	note C_, 2
	note C_, 1
	note C_, 1
	note C_, 2
Music_ChampionBattleB2W2_Ch4_loop_2:
	callchannel Music_ChampionBattleB2W2_Ch4_branch_3
	loopchannel 16, Music_ChampionBattleB2W2_Ch4_loop_2
Music_ChampionBattleB2W2_Ch4_loop_3:
	callchannel Music_ChampionBattleB2W2_Ch4_branch_3
	loopchannel 15, Music_ChampionBattleB2W2_Ch4_loop_3
	note C_, 1
	note C_, 1
	note C_, 1
	note C_, 1
	note C_, 1
	note C_, 1
	note C_, 1
	note C_, 1
Music_ChampionBattleB2W2_Ch4_loop_4:
	callchannel Music_ChampionBattleB2W2_Ch4_branch_3
	loopchannel 12, Music_ChampionBattleB2W2_Ch4_loop_4
	note C_, 6
	note C_, 6
	note C_, 4
	note G#, 4
	note G#, 4
	note G#, 4
	note G#, 4
Music_ChampionBattleB2W2_Ch4_loop_5:
	callchannel Music_ChampionBattleB2W2_Ch4_branch_3
	loopchannel 16, Music_ChampionBattleB2W2_Ch4_loop_5
Music_ChampionBattleB2W2_Ch4_loop_6:
	note B_, 2
	note D#, 2
	note C_, 2
	note D#, 2
	note G#, 2
	note C_, 2
	note D#, 2
	note G#, 2
	note C_, 2
	note G#, 2
	callchannel Music_ChampionBattleB2W2_Ch4_branch_4
	loopchannel 3, Music_ChampionBattleB2W2_Ch4_loop_6
	note C_, 2
	note D#, 2
	note C_, 2
	note D#, 2
	note C_, 1
	note C_, 1
	note C_, 2
	note C_, 1
	note C_, 1
	note C_, 2
	note C_, 2
	note D#, 2
	note C_, 2
	note C_, 1
	note C_, 1
	note C_, 2
	note D#, 2
	note C_, 1
	note C_, 1
	note C_, 2
	note C_, 2
	note D#, 2
	note C_, 1
	note C_, 1
	note C_, 2
	note C_, 2
	note D#, 4
	note C_, 2
	note D#, 4
	note C_, 2
	note D#, 2
	note G#, 16
	note __, 12
	callchannel Music_ChampionBattleB2W2_Ch4_branch_4
Music_ChampionBattleB2W2_Ch4_loop_7:
	callchannel Music_ChampionBattleB2W2_Ch4_branch_3
	loopchannel 16, Music_ChampionBattleB2W2_Ch4_loop_7
Music_ChampionBattleB2W2_Ch4_loop_8:
	callchannel Music_ChampionBattleB2W2_Ch4_branch_3
	loopchannel 16, Music_ChampionBattleB2W2_Ch4_loop_8
	note C_, 16
	note __, 16
	note __, 16
	note __, 14
	note C_, 1
	note C_, 1
	note C_, 16
	note __, 14
	note C_, 1
	note C_, 1
Music_ChampionBattleB2W2_Ch4_loop_9:
	note C_, 2
	note D#, 2
	loopchannel 7, Music_ChampionBattleB2W2_Ch4_loop_9
	callchannel Music_ChampionBattleB2W2_Ch4_branch_4
	loopchannel 0, Music_ChampionBattleB2W2_Ch4_loop_main

Music_ChampionBattleB2W2_Ch4_branch_1:
	note D#, 4
	note D#, 4
	note C_, 6
	note D#, 4
	note C_, 2
	note D#, 4
	note C_, 4
	note D#, 2
	note D#, 2
	note D#, 4
	note D#, 4
	note C_, 6
	note D#, 4
	note C_, 2
	note D#, 4
	endchannel

Music_ChampionBattleB2W2_Ch4_branch_2:
	note D#, 4
	note C_, 2
	note D#, 4
	note D#, 2
	note C_, 2
	note D#, 2
	endchannel

Music_ChampionBattleB2W2_Ch4_branch_3:
	note D#, 2
	note G#, 2
	note C_, 2
	note G#, 2
	endchannel

Music_ChampionBattleB2W2_Ch4_branch_4:
	notetype $6
	note C_, 1
	note C_, 1
	note C_, 1
	note C_, 1
	note C_, 1
	note C_, 1
	note C_, 1
	note C_, 1
	notetype $c
	endchannel
