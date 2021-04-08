; Pokémon OR/AS - Battle! Wally
; Demixed by Mmmmmm
; https://pastebin.com/7vneX9pj
; https://hax.iimarckus.org/topic/6777/4/

Music_WallyBattleORAS:
	musicheader 4, 1, Music_WallyBattleORAS_Ch1
	musicheader 1, 2, Music_WallyBattleORAS_Ch2
	musicheader 1, 3, Music_WallyBattleORAS_Ch3
	musicheader 1, 4, Music_WallyBattleORAS_Ch4

Music_WallyBattleORAS_Ch1:
	tempo 192
	volume $77
	dutycycle 3
	callchannel Music_WallyBattleORAS_Ch1_branch_1
	octave 2
	note A_, 5
	intensity $84
	note G_, 2
	note A_, 2
	intensity $80
	note B_, 4
	intensity $87
	note B_, 5
	octave 3
	intensity $b1
	note A_, 1
	note B_, 1
	note B_, 1
	note __, 1
	callchannel Music_WallyBattleORAS_Ch1_branch_1
	octave 2
	note A_, 5
	intensity $83
	octave 3
	note C_, 2
	note C_, 2
	intensity $80
	octave 2
	note B_, 4
	intensity $87
	note B_, 5
	octave 3
	intensity $b1
	note A_, 1
	note B_, 1
	note B_, 1
	note __, 1
	intensity $87
	note E_, 1
	note A_, 1
	note B_, 1
	intensity $80
	octave 4
	note C_, 2
	intensity $87
	note C_, 4
	note E_, 1
	note D_, 3
	intensity $85
	note D_, 2
	note E_, 2
	note F#, 2
	intensity $87
	note F#, 3
	note D_, 3
	octave 3
	note B_, 1
	intensity $80
	octave 4
	note G_, 2
	intensity $87
	note G_, 3
	note G_, 1
	note F#, 1
	note E_, 1
	note D_, 1
	intensity $80
	note C_, 10
	intensity $84
	note C_, 4
	notetype $8, $83
	note C_, 1
	note D_, 1
	note C_, 1
	dutycycle 0
	notetype $c, $c0
	octave 3
	note D#, 12
	intensity $c5
	note D#, 2
	intensity $94
	soundinput $6c
	note D#, 2
	soundinput $00
	note __, 2
	dutycycle 3
Music_WallyBattleORAS_Ch1_loop_1:
	intensity $87
	octave 4
	note C_, 1
	note C_, 1
	octave 3
	note B_, 1
	octave 4
	note C_, 1
	note __, 1
	note C_, 3
	octave 3
	note B_, 2
	note A_, 2
	note A_, 2
	dutycycle 0
	intensity $c0
	note G_, 3
	note E_, 3
	intensity $c3
	soundinput $6c
	note E_, 2
	soundinput $00
	dutycycle 3
	note __, 10
	loopchannel 2, Music_WallyBattleORAS_Ch1_loop_1
	intensity $87
	note E_, 2
	octave 4
	note E_, 2
	note D_, 2
	note C_, 2
	octave 3
	note E_, 2
	note G_, 2
	note A_, 2
	octave 4
	note C_, 3
	octave 3
	note B_, 5
	octave 4
	note E_, 3
	note D_, 3
	note C_, 2
	intensity $80
	octave 3
	note B_, 10
	intensity $84
	note B_, 4
	notetype $8, $83
	note G_, 1
	note A_, 1
	note G_, 1
	dutycycle 0
	notetype $c, $d0
	note D#, 10
	intensity $d5
	note D#, 1
	intensity $a4
	soundinput $6c
	note D#, 2
	soundinput $00
	dutycycle 3
	loopchannel 0, Music_WallyBattleORAS_Ch1

Music_WallyBattleORAS_Ch1_branch_1:
	notetype $c, $97
	octave 2
	note D_, 1
	note G_, 1
	note A_, 1
	intensity $90
	note B_, 2
	intensity $97
	note B_, 4
	octave 3
	note C_, 1
	endchannel

Music_WallyBattleORAS_Ch2:
	dutycycle 0
	callchannel Music_WallyBattleORAS_Ch2_branch_1
	note F#, 5
	intensity $c3
	note E_, 2
	note F#, 2
	intensity $c0
	note G_, 4
	intensity $c7
	note G_, 9
	callchannel Music_WallyBattleORAS_Ch2_branch_1
	notetype $6, $c7
	note F#, 9
	note A#, 1
	intensity $c3
	note B_, 4
	note A_, 4
	notetype $c, $c0
	note G_, 4
	intensity $c7
	note G_, 9
	octave 2
	note B_, 1
	octave 3
	note C_, 1
	note D_, 1
	intensity $c0
	note E_, 2
	intensity $c7
	note E_, 4
	note G_, 1
	note F#, 3
	intensity $c5
	note F#, 2
	note G_, 2
	note A_, 2
	intensity $c7
	note A_, 3
	note F#, 3
	note D_, 1
	intensity $c0
	note B_, 2
	intensity $c7
	note B_, 4
	note A_, 1
	note G_, 1
	note F#, 1
	intensity $c0
	note E_, 10
	intensity $c4
	note E_, 4
	notetype $8, $c3
	note E_, 1
	note F#, 1
	note E_, 1
	dutycycle 3
	notetype $c, $80
	octave 3
	note B_, 8
	intensity $87
	note B_, 8
	note __, 2
	dutycycle 0
Music_WallyBattleORAS_Ch2_loop_1:
	intensity $c7
	note G_, 1
	note G_, 1
	note F#, 1
	note G_, 1
	note __, 1
	note G_, 3
	note F#, 2
	note E_, 2
	note F#, 2
	dutycycle 3
	intensity $87
	note B_, 3
	note G_, 5
	dutycycle 0
	note __, 10
	loopchannel 2, Music_WallyBattleORAS_Ch2_loop_1
	intensity $d7
	octave 2
	note B_, 2
	octave 3
	note B_, 2
	note A_, 2
	note F#, 2
	octave 2
	note B_, 2
	octave 3
	note D#, 2
	note F#, 2
	note A_, 3
	note G_, 5
	note B_, 3
	note A_, 3
	note G_, 2
	intensity $c0
	note F#, 10
	intensity $c4
	note F#, 4
	notetype $8, $c3
	note E_, 1
	note F#, 1
	note E_, 1
	dutycycle 3
	notetype $c, $80
	note F#, 8
	intensity $87
	note F#, 5
	dutycycle 0
	loopchannel 0, Music_WallyBattleORAS_Ch2

Music_WallyBattleORAS_Ch2_branch_1:
	notetype $c, $b7
	octave 2
	note B_, 1
	octave 3
	note E_, 1
	note F#, 1
	intensity $b0
	note G_, 2
	intensity $b7
	note G_, 4
	note A_, 1
	endchannel

Music_WallyBattleORAS_Ch3:
	notetype $6, $19
	vibrato $12, $15
	note __, 6
Music_WallyBattleORAS_Ch3_loop_main:
	callchannel Music_WallyBattleORAS_Ch3_branch_1
	octave 1
	note E_, 1
	note __, 1
	note E_, 2
	note __, 2
	octave 2
	note E_, 1
	note __, 1
	note E_, 4
	octave 1
	note E_, 1
	note __, 1
	note E_, 2
	note __, 2
	note E_, 1
	note __, 1
	note E_, 4
	octave 2
	note G#, 1
	note A_, 3
	note G_, 4
	callchannel Music_WallyBattleORAS_Ch3_branch_1
	octave 1
	note E_, 1
	note __, 1
	note E_, 2
	note __, 2
	note E_, 1
	note __, 1
	note E_, 2
	note __, 2
	note E_, 1
	note __, 1
	note E_, 2
	note __, 4
	note A#, 1
	note B_, 3
	octave 2
	note E_, 4
	octave 1
	note E_, 4
	octave 2
	note C_, 7
	note __, 1
	note C_, 6
	note D_, 10
	octave 1
	note D#, 4
	octave 2
	note D#, 4
	octave 1
	note B_, 1
	note __, 1
	note B_, 6
	note __, 4
	note B_, 2
	octave 2
	note E_, 8
	octave 1
	note B_, 2
	octave 2
	note D_, 2
	note E_, 2
	octave 1
	note E_, 4
	octave 2
	note C_, 1
	note __, 1
	note C_, 2
	note __, 2
	octave 1
	note E_, 6
	octave 2
	note C_, 6
	octave 1
	note E_, 2
	octave 2
	note C_, 2
	octave 1
	note E_, 6
	octave 2
	note C_, 4
	octave 2
	note B_, 1
	note __, 1
	note B_, 2
	note __, 2
	octave 1
	note B_, 1
	note __, 1
	note B_, 2
	note __, 2
	octave 2
	note B_, 1
	note __, 1
	note B_, 2
	note __, 2
	octave 1
	note B_, 1
	note __, 1
	note B_, 2
	note __, 2
	note D_, 1
	note D#, 3
	note B_, 4
Music_WallyBattleORAS_Ch3_loop_1:
	octave 2
	note C_, 1
	note __, 1
	note C_, 1
	note __, 1
	note C_, 1
	note __, 1
	note C_, 1
	note __, 1
	octave 1
	note B_, 1
	note __, 1
	octave 2
	note C_, 2
	note __, 2
	note D_, 5
	note __, 1
	note D_, 3
	note __, 1
	note D_, 3
	note __, 1
	note D_, 3
	note __, 1
	octave 1
	note E_, 1
	note __, 1
	note E_, 2
	note __, 2
	callchannel Music_WallyBattleORAS_Ch3_branch_2
	octave 1
	note E_, 2
	octave 2
	note E_, 2
	octave 1
	note E_, 2
	octave 2
	note E_, 2
	note D_, 6
	loopchannel 2, Music_WallyBattleORAS_Ch3_loop_1
	note C_, 4
	note G_, 2
	octave 3
	note C_, 2
	note __, 2
	note C_, 4
	note D_, 2
	note __, 2
	note D_, 1
	note __, 1
	note D_, 4
	note D#, 2
	note __, 2
	note D#, 2
	note __, 2
	callchannel Music_WallyBattleORAS_Ch3_branch_2
	octave 1
	note E_, 1
	note __, 1
	note E_, 2
	note __, 4
	note E_, 4
	note __, 2
	note E_, 2
	note __, 2
	note E_, 2
	note B_, 3
	note __, 1
	note B_, 3
	note __, 1
	octave 2
	note B_, 4
	octave 1
	note B_, 1
	note __, 1
	note B_, 2
	note __, 2
	note B_, 1
	note __, 1
	note B_, 4
	octave 2
	note B_, 4
	octave 1
	note B_, 4
	octave 1
	note B_, 1
	note __, 1
	note B_, 2
	note __, 2
	octave 2
	note B_, 1
	note __, 1
	note B_, 4
	octave 1
	note B_, 1
	note __, 1
	note B_, 2
	note __, 2
	octave 2
	note B_, 1
	note __, 1
	note B_, 2
	note F#, 2
	note B_, 2
	octave 1
	note B_, 6
	loopchannel 0, Music_WallyBattleORAS_Ch3_loop_main

Music_WallyBattleORAS_Ch3_branch_1:
	octave 1
	note E_, 1
	note __, 1
	note E_, 2
	note __, 2
	octave 2
	note E_, 1
	note __, 1
	note E_, 5
	note __, 1
	octave 1
	note E_, 2
	note __, 2
	note E_, 1
	note __, 1
	note E_, 4
	octave 2
	note A#, 1
	note B_, 3
	octave 3
	note E_, 4
	endchannel

Music_WallyBattleORAS_Ch3_branch_2:
	octave 1
	note E_, 1
	note __, 1
	note E_, 2
	note __, 2
	octave 2
	note E_, 1
	note __, 1
	note E_, 2
	note __, 2
	endchannel

Music_WallyBattleORAS_Ch4:
	togglenoise $4
	notetype $c
	note __, 3
Music_WallyBattleORAS_Ch4_loop_main:
	callchannel Music_WallyBattleORAS_Ch4_branch_1
	callchannel Music_WallyBattleORAS_Ch4_branch_2
	callchannel Music_WallyBattleORAS_Ch4_branch_2
	callchannel Music_WallyBattleORAS_Ch4_branch_3
	callchannel Music_WallyBattleORAS_Ch4_branch_1
	callchannel Music_WallyBattleORAS_Ch4_branch_2
	callchannel Music_WallyBattleORAS_Ch4_branch_4
	note E_, 1
	note C#, 1
	note E_, 1
	note C#, 1
	callchannel Music_WallyBattleORAS_Ch4_branch_1
	callchannel Music_WallyBattleORAS_Ch4_branch_2
	callchannel Music_WallyBattleORAS_Ch4_branch_2
	note C#, 1
	note D#, 1
	note D#, 1
	note C#, 1
	note D#, 1
	note D#, 1
	note E_, 1
	note C#, 1
	callchannel Music_WallyBattleORAS_Ch4_branch_1
	callchannel Music_WallyBattleORAS_Ch4_branch_2
	callchannel Music_WallyBattleORAS_Ch4_branch_6
	note E_, 1
	note C#, 1
	note D#, 1
	note C#, 1
Music_WallyBattleORAS_Ch4_loop_1:
	callchannel Music_WallyBattleORAS_Ch4_branch_1
	callchannel Music_WallyBattleORAS_Ch4_branch_5
	callchannel Music_WallyBattleORAS_Ch4_branch_2
	note A#, 1
	note D_, 1
	note A#, 1
	note A#, 1
	note B_, 1
	note B_, 2
	note D#, 1
	loopchannel 2, Music_WallyBattleORAS_Ch4_loop_1
	callchannel Music_WallyBattleORAS_Ch4_branch_1
	callchannel Music_WallyBattleORAS_Ch4_branch_5
	callchannel Music_WallyBattleORAS_Ch4_branch_2
	note E_, 1
	note D_, 1
	note D#, 1
	note E_, 1
	note D_, 1
	note D#, 1
	note E_, 1
	note D#, 1
	callchannel Music_WallyBattleORAS_Ch4_branch_1
	callchannel Music_WallyBattleORAS_Ch4_branch_5
	callchannel Music_WallyBattleORAS_Ch4_branch_6
	note E_, 1
	note E_, 1
	note D#, 1
	note D#, 1
	loopchannel 0, Music_WallyBattleORAS_Ch4_loop_main
	endchannel

Music_WallyBattleORAS_Ch4_branch_1:
	note B_, 2
	note D#, 1
	note D#, 1
	note E_, 1
	note C#, 1
	note D#, 1
	note D#, 1
	endchannel

Music_WallyBattleORAS_Ch4_branch_2:
	note D_, 1
	note D_, 1
	note D#, 1
	note D#, 1
	note E_, 1
	note C#, 1
	note D#, 1
	note D#, 1
	endchannel

Music_WallyBattleORAS_Ch4_branch_3:
	note D_, 1
	note D_, 1
	note D#, 1
	note D#, 1
	note E_, 1
	note D#, 1
	note E_, 1
	note C#, 1
	endchannel

Music_WallyBattleORAS_Ch4_branch_4:
	note E_, 1
	note E_, 1
	note C#, 1
	note D#, 1
	note D#, 1
	note C#, 1
	note E_, 1
	note E_, 1
	note C#, 1
	note D#, 1
	note D#, 1
	note C#, 1
	endchannel

Music_WallyBattleORAS_Ch4_branch_5:
	note D_, 1
	note A#, 1
	note A#, 1
	note D_, 1
	note E_, 1
	note C#, 1
	note E_, 1
	note D#, 1
	endchannel

Music_WallyBattleORAS_Ch4_branch_6:
	note B_, 1
	note B_, 1
	note C#, 1
	note D#, 1
	note D#, 1
	note C#, 1
	note B_, 1
	note B_, 1
	note C#, 1
	note D#, 1
	note D#, 1
	note C#, 1
	endchannel
