; Pokémon B/W - Battle! Elite Four
; Demixed by Mmmmmm
; https://pastebin.com/SQ00sPwE
; https://hax.iimarckus.org/topic/6777/9/

Music_EliteFourBattleBW:
	musicheader 4, 1, Music_EliteFourBattleBW_Ch1
	musicheader 1, 2, Music_EliteFourBattleBW_Ch2
	musicheader 1, 3, Music_EliteFourBattleBW_Ch3
	musicheader 1, 4, Music_EliteFourBattleBW_Ch4

Music_EliteFourBattleBW_Ch1:
	dutycycle $2
	vibrato $12, $15
	tone $0001
	tempo 200
	notetype $c, $b2
	octave 4
	note __, 16
	note __, 14
	note F#, 2
	octave 5
	note C#, 2
	octave 3
	intensity $63
	soundinput $6c
Music_EliteFourBattleBW_Ch1_loop_1:
	note C#, 2
	loopchannel 31, Music_EliteFourBattleBW_Ch1_loop_1
Music_EliteFourBattleBW_Ch1_loop_main:
	notetype $6, $a0
	soundinput $67
	octave 3
	note D#, 2
	soundinput $00
	note F#, 4
	octave 4
	note C#, 6
	octave 3
	note A#, 4
	octave 4
	note C_, 6
	soundinput $67
	note D#, 2
	soundinput $00
	note F#, 4
	intensity $a4
	note F#, 4
	intensity $a0
	octave 3
	note F#, 6
	soundinput $67
	note A#, 2
	octave 4
	soundinput $00
	note C#, 4
	octave 3
	note A#, 4
	note A_, 6
	soundinput $6f
	note A_, 2
	soundinput $00
	note F#, 4
	intensity $a4
	note F#, 4

	intensity $a0
	soundinput $67
	octave 4
	note E_, 1
	soundinput $00
	note F#, 5
	octave 5
	note C#, 6
	octave 4
	note A#, 4
	octave 5
	note C_, 6
	soundinput $67
	note D#, 1
	soundinput $00
	note F#, 5
	intensity $a4
	note F#, 4
	intensity $a0
	octave 4
	note F#, 6
	soundinput $67
	note B_, 1
	octave 5
	soundinput $00
	note C#, 5
	octave 4
	note A#, 4
	note A_, 6
	soundinput $6f
	note A_, 2
	soundinput $00
	note F#, 4
	intensity $a4
	note F#, 4
	dutycycle 0
	intensity $b2
	note F#, 2
	note F#, 4
	intensity $b5
	note G_, 4
	note A_, 2
	note G#, 2
	note G_, 2
	intensity $b2
	note F#, 2
	note F#, 4
	intensity $b5
	note G_, 4
	note B_, 2
	note A_, 2
	note G_, 2
	intensity $b2
	note F#, 2
	note F#, 4
	intensity $b5
	note G_, 4
	note A_, 2
	note G#, 2
	note G_, 2
	intensity $b2
	note F#, 2
	note F#, 4
	intensity $b5
	note G_, 4
	note B_, 2
	note A_, 2
	note G_, 2
	dutycycle 2
	intensity $a0
	soundinput $67
	octave 2
	note D#, 2
	soundinput $00
	note F#, 4
	octave 3
	note C#, 6
	octave 2
	note A#, 4
	octave 3
	note C_, 6
	soundinput $67
	note D#, 2
	soundinput $00
	note F#, 4
	intensity $a4
	note F#, 4
	intensity $a0
	octave 2
	note F#, 6
	soundinput $67
	note A#, 2
	octave 3
	soundinput $00
	note C#, 4
	octave 2
	note A#, 4
	note A_, 6
	soundinput $6f
	note A_, 2
	soundinput $00
	note F#, 4
	intensity $a4
	note F#, 4
	intensity $a0
	soundinput $67
	octave 3
	note D#, 2
	soundinput $00
	note F#, 4
	octave 4
	note C#, 6
	octave 3
	note A#, 4
	octave 4
	note C_, 6
	soundinput $67
	note D#, 2
	soundinput $00
	note F#, 4
	intensity $a4
	note F#, 4
	intensity $a0
	octave 3
	note F#, 6
	soundinput $67
	note A#, 2
	octave 4
	soundinput $00
	note C#, 4
	octave 3
	note A#, 4
	intensity $a7
	note A_, 6
	intensity $a0
	note A_, 6
	intensity $a4
	note A_, 4
	dutycycle 3
	octave 4
	notetype $c, $c1
	note F#, 1
	note F#, 2
	intensity $c0
	note E_, 5
	intensity $c7
	note E_, 8
	intensity $c1
	note F#, 1
	note F#, 2
	intensity $c0
	note G_, 5
	intensity $c7
	note G_, 8
	octave 3
	dutycycle 0
	intensity $b2
	note F#, 2
	intensity $b5
	note G_, 2
	note A_, 2
	note G_, 2
	intensity $b2
	note F#, 2
	intensity $b5
	note G_, 2
	note A_, 2
	note G_, 2
	intensity $b2
	note B_, 2
	intensity $b5
	octave 4
	note C_, 2
	note D_, 2
	note C_, 2
	octave 3
	intensity $b2
	note B_, 2
	intensity $b5
	octave 4
	note C_, 2
	note D_, 2
	note C_, 2
	octave 3
	intensity $b2
	note B_, 2
	intensity $b5
	octave 4
	note C_, 2
	note D_, 2
	note C_, 2
	octave 3
	intensity $b2
	note B_, 2
	intensity $b5
	octave 4
	note C_, 2
	note D_, 2
	note E_, 2
	note __, 16
	note __, 16
	octave 2
	intensity $a0
	note F#, 3
	octave 3
	note C#, 3
	note F#, 2
	note G_, 2
	intensity $a7
	note G_, 4
	intensity $a2
	note F#, 2
	octave 2
	intensity $a7
	note E_, 2
	intensity $a2
	note G_, 2
	intensity $a7
	note B_, 2
	octave 3
	intensity $a2
	note D_, 2
	intensity $a0
	note C#, 2
	intensity $a7
	note C#, 5
	octave 4
	note C#, 1
	octave 3
	intensity $a0
	note B_, 8
	intensity $a7
	note B_, 7
	octave 4
	note C_, 1
	intensity $a0
	note C#, 8
	intensity $a7
	note C#, 8
	intensity $a0
	octave 3
	note F#, 3
	octave 4
	note C#, 3
	octave 3
	note F#, 2
	note D_, 2
	intensity $a7
	note D_, 4
	intensity $a2
	note F#, 2
	intensity $a7
	note E_, 2
	intensity $a2
	note G_, 2
	intensity $a7
	note B_, 2
	octave 4
	intensity $a2
	note D_, 2
	intensity $a0
	note C#, 2
	intensity $a7
	note C#, 5
	note F#, 1
	intensity $a0
	note E_, 8
	intensity $a7
	note E_, 7
	note C#, 1
	intensity $a0
	note F#, 8
	intensity $a7
	note F#, 8
	dutycycle 2
	notetype $6, $a1
	octave 4
	note F_, 1
	note D#, 1
	note C#, 1
	octave 3
	note B_, 1
	note A#, 1
	note G#, 1
	note F#, 1
	note F_, 1
	note D#, 1
	note C#, 1
	octave 2
	note B_, 1
	octave 3
	note C#, 1
	note D#, 1
	note F_, 1
	note F#, 1
	note G#, 1
	octave 4
	note C#, 1
	octave 3
	note B_, 1
	note A#, 1
	note G#, 1
	note F#, 1
	note F_, 1
	note D#, 1
	note C#, 1
	octave 2
	note B_, 1
	note A#, 1
	note B_, 1
	octave 3
	note C#, 1
	note D#, 1
	note F#, 1
	note A#, 1
	note G#, 1
	octave 2
	note A#, 2
	octave 3
	note C#, 2
	note D#, 2
	note F_, 2
	note A#, 2
	note G#, 2
	note F#, 2
	note G#, 2
	note F#, 2
	note C#, 2
	note F#, 1
	note G#, 1
	note A#, 2
	octave 4
	note C#, 2
	octave 3
	intensity $a4
	note A#, 6
	intensity $a1
	octave 4
	note F_, 1
	note D#, 1
	note C#, 2
	note C#, 1
	octave 3
	note B_, 1
	note G#, 2
	note A#, 2
	note C_, 1
	note C#, 1
	note D#, 1
	note F_, 1
	note F#, 1
	note G#, 1
	octave 4
	note C#, 1
	octave 3
	note B_, 1
	note G#, 2
	note A#, 1
	note G#, 1
	note F#, 1
	note F_, 2
	octave 2
	note A#, 1
	note B_, 1
	octave 3
	note C#, 1
	note D#, 1
	note F_, 1
	note F#, 1
	note G#, 1
	octave 2
	note A#, 2
	octave 3
	note C#, 2
	note D#, 2
	note F_, 2
	note A#, 2
	note G#, 4
	note F_, 2
	intensity $a4
	note F#, 2
	note F_, 2
	note F#, 2
	intensity $a6
	note F_, 10
	loopchannel 0, Music_EliteFourBattleBW_Ch1_loop_main

Music_EliteFourBattleBW_Ch2:
	dutycycle $3
	vibrato $12, $15
	tone $0001
	notetype $c, $b2
	note __, 16
	note __, 14
	octave 2
	note F#, 2
	octave 3
	note C#, 16
	note __, 16
	note __, 16
	note __, 16
Music_EliteFourBattleBW_Ch2_loop_main:
	intensity $80
	octave 3
	note C#, 3
	note F#, 3
	note D#, 2
	note F_, 3
	octave 4
	note C_, 3
	intensity $84
	note C_, 2
	intensity $80
	octave 3
	note C#, 3
	note F#, 3
	note D#, 2
	note D_, 3
	note C_, 3
	intensity $84
	note C_, 2
	intensity $80
	octave 4
	note C#, 3
	note F#, 3
	note D#, 2
	note F_, 3
	octave 5
	note C_, 3
	intensity $84
	note C_, 2
	intensity $80
	octave 4
	note C#, 3
	note F#, 3
	note D#, 2
	note D_, 3
	note C_, 3
	intensity $84
	note C_, 2
	intensity $b2
	octave 2
	note C#, 1
	octave 3
	note C_, 2
	intensity $b5
	note D_, 2
	note E_, 1
	note D#, 1
	note D_, 1
	intensity $b2
	note C#, 1
	note C_, 2
	intensity $b5
	note D_, 2
	note F#, 1
	note E_, 1
	note D_, 1
	intensity $b2
	note C#, 1
	note C#, 2
	intensity $b5
	note D_, 2
	note E_, 1
	note D#, 1
	note D_, 1
	intensity $b2
	note C#, 1
	note C#, 2
	intensity $b5
	note D_, 2
	note F#, 1
	note E_, 1
	note D_, 1
	intensity $80
	octave 3
	note C#, 3
	note F#, 3
	note D#, 2
	note F_, 3
	octave 4
	note C_, 3
	intensity $84
	note C_, 2
	intensity $80
	octave 3
	note C#, 3
	note F#, 3
	note D#, 2
	note D_, 3
	note C_, 3
	intensity $84
	note C_, 2
	intensity $80
	octave 3
	note C#, 3
	note F#, 3
	note D#, 2
	note F_, 3
	octave 4
	note C_, 3
	intensity $84
	note C_, 2
	intensity $80
	octave 3
	note C#, 3
	note F#, 3
	note D#, 2
	intensity $87
	note D_, 3
	note D_, 5
	notetype $6, $c1
	octave 4
	note C#, 2
	note C#, 4
	intensity $c0
	octave 3
	note B_, 10
	callchannel Music_EliteFourBattleBW_Ch2_branch_1
	intensity $c1
	octave 4
	note C#, 2
	note C#, 4
	intensity $c0
	note D_, 10
	callchannel Music_EliteFourBattleBW_Ch2_branch_1
	octave 3
	notetype $6, $a2
	note C#, 4
	intensity $a5
	note D_, 4
	note E_, 4
	note D_, 4
	note F#, 2
	note E_, 2
	note D_, 2
	note E_, 2
	note F#, 2
	note G_, 2
	note F#, 2
	note E_, 2
	intensity $a2
	note F#, 4
	intensity $a5
	note G_, 4
	note A_, 4
	note G_, 4
	note B_, 2
	note A_, 2
	note G_, 2
	note A_, 2
	note B_, 2
	octave 4
	note C_, 2
	octave 3
	note B_, 2
	note A_, 2
	intensity $a2
	note F#, 4
	intensity $a5
	note G_, 4
	note A_, 4
	note G_, 4
	note B_, 2
	note A_, 2
	note G_, 2
	note A_, 2
	note B_, 2
	octave 4
	note C_, 2
	note D_, 2
	note E_, 2
	intensity $71
	dutycycle 2
Music_EliteFourBattleBW_Ch2_loop_1:
	octave 4
	note C#, 1
	octave 3
	note F#, 1
	octave 4
	note C#, 1
	note F#, 1
	octave 5
	note E_, 1
	note C#, 1
	octave 4
	note B_, 1
	octave 5
	note C#, 1
	note F#, 1
	note G_, 1
	note F#, 1
	note C_, 1
	note C#, 1
	note D_, 1
	note C#, 1
	octave 4
	note G_, 1
	loopchannel 3, Music_EliteFourBattleBW_Ch2_loop_1
	octave 5
	note G_, 1
	note A_, 1
	note G_, 1
	note D_, 1
	octave 4
	note B_, 1
	octave 5
	note D_, 1
	octave 4
	note B_, 1
	note G_, 1
	note C#, 1
	note G_, 1
	note F#, 1
	octave 5
	note D_, 1
	octave 4
	note B_, 1
	octave 5
	note G_, 1
	note B_, 1
	octave 6
	note G_, 1
	dutycycle 3
	octave 3
	notetype $c, $a0
	note F#, 3
	octave 4
	note C#, 3
	note F#, 2
	note G_, 2
	intensity $a7
	note G_, 4
	intensity $a2
	note F#, 2
	intensity $a7
	note E_, 2
	intensity $a2
	note D_, 2
	intensity $a7
	note C#, 2
	octave 3
	intensity $a2
	note B_, 2
	intensity $a0
	note A#, 2
	intensity $a7
	note A#, 5
	octave 4
	note F#, 1
	intensity $a0
	note E_, 8
	intensity $a7
	note E_, 7
	note F_, 1
	intensity $a0
	note F#, 8
	intensity $a7
	note F#, 8
	intensity $a0
	note F#, 3
	octave 5
	note C#, 3
	note F#, 2
	note G_, 2
	intensity $a7
	note G_, 4
	intensity $a2
	note F#, 2
	intensity $a7
	note E_, 2
	intensity $a2
	note D_, 2
	intensity $a7
	note C#, 2
	octave 4
	intensity $a2
	note B_, 2
	intensity $a0
	note A#, 2
	intensity $a7
	note A#, 5
	octave 5
	note F#, 1
	intensity $a0
	note G#, 8
	intensity $a7
	note G#, 7
	note G#, 1
	intensity $a0
	note A#, 8
	intensity $a7
	note A#, 8
	octave 4
	intensity $c2
	note B_, 3
	intensity $c7
	note A#, 3
	note G#, 2
	intensity $c2
	note A#, 3
	intensity $c7
	note G#, 3
	note F#, 2
	intensity $c2
	note G#, 3
	intensity $c7
	note F#, 3
	note F_, 2
	intensity $c2
	note F#, 1
	note C#, 2
	note G#, 2
	intensity $c7
	note A#, 3
	note B_, 3
	octave 5
	note C#, 3
	octave 4
	note B_, 2
	note A#, 3
	note B_, 3
	note A#, 2
	note G#, 3
	note F#, 3
	note F_, 2
	note F#, 3
	note F_, 5
	loopchannel 0, Music_EliteFourBattleBW_Ch2_loop_main

Music_EliteFourBattleBW_Ch2_branch_1:
	intensity $91
	octave 3
	note G_, 1
	note B_, 1
	octave 4
	note D_, 1
	octave 3
	note B_, 1
	octave 4
	note D_, 1
	note G_, 1
	note D_, 1
	note G_, 1
	note B_, 1
	note G_, 1
	note B_, 1
	octave 5
	note D_, 1
	octave 4
	note B_, 1
	octave 5
	note D_, 1
	note G_, 1
	note B_, 1
	endchannel

Music_EliteFourBattleBW_Ch3:
	notetype $6, $19
Music_EliteFourBattleBW_Ch3_loop_1:
	callchannel Music_EliteFourBattleBW_Ch3_branch_1
	loopchannel 12, Music_EliteFourBattleBW_Ch3_loop_1
Music_EliteFourBattleBW_Ch3_loop_main:
Music_EliteFourBattleBW_Ch3_loop_2:
	callchannel Music_EliteFourBattleBW_Ch3_branch_1
	loopchannel 8, Music_EliteFourBattleBW_Ch3_loop_2
	octave 2
	note F#, 2
	note C_, 2
	note __, 2
	note G_, 4
	note A_, 2
	note G#, 2
	note G_, 2
	note F#, 2
	note C_, 2
	note __, 2
	note G_, 4
	note B_, 2
	note A_, 2
	note G_, 2
	note F#, 1
	note __, 1
	note F#, 2
	note __, 2
	note G_, 4
	note A_, 2
	note G#, 2
	note G_, 2
	note F#, 1
	note __, 1
	note F#, 2
	note __, 2
	note G_, 4
	note B_, 2
	note A_, 2
	note G_, 2
Music_EliteFourBattleBW_Ch3_loop_3:
	callchannel Music_EliteFourBattleBW_Ch3_branch_1
	loopchannel 8, Music_EliteFourBattleBW_Ch3_loop_3
	octave 2
	note F#, 1
	note __, 1
	note F#, 2
	note __, 2
	note G_, 4
	note A_, 2
	note G#, 2
	note G_, 2
	note F#, 1
	note __, 1
	note F#, 2
	note __, 2
	note G_, 4
	note B_, 2
	note A_, 2
	note G_, 2
	note F#, 1
	note __, 1
	note F#, 2
	note __, 2
	note G_, 4
	note A_, 2
	note G#, 2
	note G_, 2
	note F#, 1
	note __, 1
	note F#, 2
	note __, 2
	note G_, 4
	note B_, 2
	note A_, 2
	note G_, 2
Music_EliteFourBattleBW_Ch3_loop_4:
	callchannel Music_EliteFourBattleBW_Ch3_branch_1
	loopchannel 2, Music_EliteFourBattleBW_Ch3_loop_4
Music_EliteFourBattleBW_Ch3_loop_5:
	octave 1
	note B_, 2
	octave 2
	note F#, 2
	octave 1
	note B_, 2
	octave 2
	note G_, 2
	octave 1
	note B_, 2
	octave 2
	note G#, 2
	octave 1
	note B_, 2
	octave 2
	note A_, 2
	loopchannel 3, Music_EliteFourBattleBW_Ch3_loop_5
	octave 1
	note B_, 2
	octave 2
	note F#, 2
	octave 1
	note B_, 2
	octave 2
	note G_, 2
	octave 1
	note B_, 2
	octave 3
	note F#, 2
	note C#, 2
	octave 2
	note G_, 2
Music_EliteFourBattleBW_Ch3_loop_6:
	callchannel Music_EliteFourBattleBW_Ch3_branch_1
	loopchannel 4, Music_EliteFourBattleBW_Ch3_loop_6
	callchannel Music_EliteFourBattleBW_Ch3_branch_2
	octave 1
	note F#, 2
	octave 2
	note C#, 2
	octave 1
	note F#, 2
	octave 2
	note D_, 2
	octave 1
	note F#, 2
	octave 2
	note D_, 2
	note C#, 2
	octave 1
	note B_, 2
	callchannel Music_EliteFourBattleBW_Ch3_branch_2
	octave 1
	note F#, 2
	octave 2
	note C#, 2
	octave 1
	note F#, 2
	octave 2
	note D_, 2
	octave 1
	note F#, 2
	octave 2
	note D#, 2
	octave 1
	note F#, 2
	octave 2
	note E_, 2
	callchannel Music_EliteFourBattleBW_Ch3_branch_3
	note F#, 2
	octave 2
	note C#, 2
	octave 1
	note F#, 2
	octave 2
	note C#, 2
	note F#, 2
	octave 3
	note C#, 2
	note __, 2
	octave 2
	note C#, 2
	callchannel Music_EliteFourBattleBW_Ch3_branch_3
	note F#, 2
	octave 2
	note C#, 2
	note __, 2
	octave 1
	note A#, 6
	note G_, 4
	loopchannel 0, Music_EliteFourBattleBW_Ch3_loop_main

Music_EliteFourBattleBW_Ch3_branch_1:
	octave 1
	note F#, 2
	octave 2
	note C#, 2
	octave 1
	note F#, 2
	octave 2
	note D_, 2
	octave 1
	note F#, 2
	octave 2
	note D#, 2
	octave 1
	note F#, 2
	octave 2
	note E_, 2
	endchannel

Music_EliteFourBattleBW_Ch3_branch_2:
	octave 1
	note F#, 2
	octave 2
	note C#, 2
	octave 1
	note F#, 2
	octave 2
	note C#, 2
	octave 1
	note F#, 2
	octave 2
	note C#, 2
	octave 1
	note F#, 2
	octave 2
	note C#, 2
	octave 1
	note F#, 2
	octave 2
	note D_, 2
	octave 1
	note F#, 2
	octave 2
	note D_, 2
	octave 1
	note F#, 2
	octave 2
	note D_, 2
	octave 1
	note F#, 2
	octave 2
	note D_, 2
	octave 1
	note E_, 2
	note B_, 2
	note E_, 2
	note B_, 2
	note E_, 2
	note B_, 2
	note E_, 2
	note B_, 2
	note F#, 2
	octave 2
	note C#, 2
	octave 1
	note F#, 2
	octave 2
	note C#, 2
	octave 1
	note F#, 2
	octave 2
	note C#, 2
	octave 1
	note F#, 2
	note F_, 2
	note E_, 2
	note B_, 2
	note E_, 2
	octave 2
	note C_, 2
	octave 1
	note E_, 2
	octave 2
	note C#, 2
	octave 1
	note E_, 2
	octave 2
	note D_, 2
	note E_, 2
	note B_, 2
	note E_, 2
	octave 2
	note C_, 2
	octave 1
	note E_, 2
	octave 2
	note C#, 2
	octave 1
	note E_, 2
	octave 2
	note D_, 2
	octave 1
	note F#, 2
	octave 2
	note C#, 2
	octave 1
	note F#, 2
	octave 2
	note D_, 2
	octave 1
	note F#, 2
	octave 2
	note D#, 2
	octave 1
	note F#, 2
	octave 2
	note E_, 2
	endchannel

Music_EliteFourBattleBW_Ch3_branch_3:
	octave 1
	note E_, 2
	note B_, 2
	note E_, 2
	note B_, 2
	octave 2
	note E_, 2
	octave 1
	note B_, 2
	octave 2
	note G#, 2
	octave 1
	note B_, 2
	note F#, 2
	octave 2
	note C#, 2
	octave 1
	note F#, 2
	octave 2
	note C#, 2
	note F#, 2
	note C#, 2
	octave 3
	note C#, 2
	octave 2
	note C#, 2
	octave 1
	note C#, 2
	note G#, 2
	note C#, 2
	note G#, 2
	octave 2
	note C#, 2
	octave 1
	note G#, 2
	octave 2
	note G#, 2
	octave 1
	note G#, 2
	endchannel

Music_EliteFourBattleBW_Ch4:
	togglenoise $3
	notetype $6
	note __, 16
	note __, 16
	note __, 16
	note __, 16
Music_EliteFourBattleBW_Ch4_loop_1:
	note D#, 2
	note D_, 2
	loopchannel 8, Music_EliteFourBattleBW_Ch4_loop_1
Music_EliteFourBattleBW_Ch4_loop_2:
	note C#, 1
	note C#, 1
	note C#, 2
	loopchannel 8, Music_EliteFourBattleBW_Ch4_loop_2
Music_EliteFourBattleBW_Ch4_loop_3:
	callchannel Music_EliteFourBattleBW_Ch4_branch_1
	loopchannel 2, Music_EliteFourBattleBW_Ch4_loop_3
Music_EliteFourBattleBW_Ch4_loop_main:
Music_EliteFourBattleBW_Ch4_loop_4:
	callchannel Music_EliteFourBattleBW_Ch4_branch_1
	loopchannel 4, Music_EliteFourBattleBW_Ch4_loop_4
	note C_, 2
	note C_, 2
	note G#, 1
	note G#, 1
	note D#, 2
	note C_, 2
	note D#, 2
	note C_, 2
	note D#, 2
	note C_, 2
	note C_, 2
	note G#, 1
	note G#, 1
	note D#, 2
	note C_, 2
	note D#, 2
	note C_, 2
	note D#, 2
	note C_, 2
	note C_, 2
	note G#, 1
	note G#, 1
	note D#, 2
	note C_, 2
	note D#, 2
	note C_, 2
	note D#, 2
	note C_, 2
	note C_, 2
	note G#, 1
	note G#, 1
	note D#, 2
	note C_, 2
	note D#, 2
	note C_, 1
	note C_, 1
	note C_, 1
	note C_, 1
Music_EliteFourBattleBW_Ch4_loop_5:
	callchannel Music_EliteFourBattleBW_Ch4_branch_1
	loopchannel 12, Music_EliteFourBattleBW_Ch4_loop_5
	note A#, 2
	note A#, 1
	note A#, 1
	note A#, 2
	note A#, 1
	note A#, 1
	note A#, 1
	note A#, 2
	note A#, 1
	note A#, 1
	note A#, 2
	note A#, 1
	note A#, 1
	note A#, 1
	note B_, 6
	note C_, 2
	note D_, 1
	note D_, 1
	note C_, 2
	note C_, 2
Music_EliteFourBattleBW_Ch4_loop_6:
	callchannel Music_EliteFourBattleBW_Ch4_branch_1
	loopchannel 6, Music_EliteFourBattleBW_Ch4_loop_6
Music_EliteFourBattleBW_Ch4_loop_7:
	note D#, 4
	loopchannel 16, Music_EliteFourBattleBW_Ch4_loop_7
Music_EliteFourBattleBW_Ch4_loop_8:
	note D#, 2
	note D_, 2
	loopchannel 15, Music_EliteFourBattleBW_Ch4_loop_8
	note C_, 1
	note C_, 1
	note C_, 1
	note C_, 1
	loopchannel 0, Music_EliteFourBattleBW_Ch4_loop_main

Music_EliteFourBattleBW_Ch4_branch_1:
	note C_, 2
	note D_, 1
	note D_, 1
	note C_, 2
	note D_, 1
	note D_, 1
	note C_, 1
	note D_, 2
	note D_, 1
	note C_, 1
	note D_, 2
	note D_, 1
	note C_, 1
	note D_, 1
	note D_, 2
	note C_, 1
	note D_, 2
	note D_, 1
	note C_, 2
	note D_, 1
	note D_, 1
	note C_, 2
	note C_, 2
	endchannel
