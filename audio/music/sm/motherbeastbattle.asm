; Pokémon S/M - Battle! Mother Beast
; Demixed by Mmmmmm
; https://pastebin.com/zWajMT3c
; https://hax.iimarck.us/topic/6777/5/

Music_MotherBeastBattleSM:
	musicheader 4, 1, Music_MotherBeastBattleSM_Ch1
	musicheader 1, 2, Music_MotherBeastBattleSM_Ch2
	musicheader 1, 3, Music_MotherBeastBattleSM_Ch3
	musicheader 1, 4, Music_MotherBeastBattleSM_Ch4

Music_MotherBeastBattleSM_Ch1:
	dutycycle 3
	tempo 220
	vibrato $12, $15
	tone $0001
	notetype $c, $1f
	octave 3
	note D_, 4
	dutycycle 2
	intensity $60
	note A#, 16
	note A#, 8
	intensity $67
	note A#, 6
	intensity $60
	note B_, 14
	intensity $67
	note B_, 6
	intensity $30
	note D#, 12
	note D#, 9
	intensity $37
	note D#, 3
Music_MotherBeastBattleSM_Ch1_loop_main:
	intensity $30
	dutycycle 3
	octave 3
	callchannel Music_MotherBeastBattleSM_Ch2_branch_1
	octave 2
	note A_, 1
	octave 3
	callchannel Music_MotherBeastBattleSM_Ch2_branch_2
	callchannel Music_MotherBeastBattleSM_Ch2_branch_1
	octave 2
	note A_, 1
	octave 3
	callchannel Music_MotherBeastBattleSM_Ch2_branch_2
	octave 3
	dutycycle 0
	intensity $50
	note D_, 12
	note D#, 12
	note A#, 12
	octave 4
	intensity $50
	note A#, 8
	intensity $5f
	note A#, 4
	intensity $72
	dutycycle 2
	octave 5
	callchannel Music_MotherBeastBattleSM_Ch2_branch_1
	octave 4
	note A_, 1
	octave 5
	callchannel Music_MotherBeastBattleSM_Ch2_branch_2
	callchannel Music_MotherBeastBattleSM_Ch2_branch_1
	octave 4
	note A_, 1
	octave 5
	callchannel Music_MotherBeastBattleSM_Ch2_branch_2
	intensity $60
	dutycycle 2
	octave 2
	note A_, 1
	octave 3
	note D#, 2
	octave 2
	note A_, 1
	octave 3
	note A_, 1
	note D#, 1
	octave 2
	note A_, 1
	octave 3
	note D#, 1
	note G#, 1
	note D#, 1
	octave 2
	note A_, 1
	octave 3
	note D#, 1
	octave 2
	note G#, 1
	octave 3
	note D_, 2
	octave 2
	note G#, 1
	octave 3
	note D_, 1
	octave 2
	note G#, 1
	octave 3
	note D_, 1
	note G#, 1
	note D_, 1
	octave 2
	note G#, 1
	octave 3
	note D_, 2
	octave 2
	note B_, 1
	octave 3
	note F_, 3
	note D#, 4
	note C_, 4
	octave 2
	note B_, 1
	octave 3
	note D_, 1
	note F_, 4
	octave 2
	note F_, 1
	note B_, 1
	octave 3
	note F_, 4
	note __, 16
	note __, 16
	note __, 16
	intensity $30
	octave 2
	note G_, 16
	note G_, 16
	note G_, 14
	intensity $37
	note G_, 2
	note __, 4
	octave 3
	dutycycle 1
	intensity $1f
	note C_, 4
	intensity $60
	note C_, 12
	intensity $67
	note C_, 4
	octave 4
	intensity $1f
	note G_, 4
	intensity $60
	note G_, 4
	note F#, 4
	octave 5
	intensity $60
	note D_, 4
	intensity $67
	note D_, 2
	intensity $60
	note C#, 10
	intensity $67
	note C#, 2
	intensity $60
	note C_, 4
	intensity $67
	note C_, 2
	octave 4
	intensity $60
	note B_, 4
	intensity $67
	note B_, 2
	intensity $60
	note A#, 4
	intensity $67
	note A#, 2
	note G_, 2
	note G#, 2
	note F#, 2
	note G_, 2
	note D_, 2
	note F_, 2
	note D#, 2
	note G_, 2
	octave 3
	note G#, 2
	intensity $60
	note G_, 2
	intensity $67
	note G_, 4
	intensity $1f
	note C#, 3
	intensity $50
	note C#, 15
	note C#, 15
	intensity $57
	note C#, 3
	intensity $30
	dutycycle 1
	callchannel Music_MotherBeastBattleSM_Ch2_branch_3
	loopchannel 0, Music_MotherBeastBattleSM_Ch1_loop_main

Music_MotherBeastBattleSM_Ch2:
	dutycycle 3
	vibrato $12, $15
	notetype $6, $91
	note __, 8
	octave 3
	note D_, 1
	note F_, 1
	note G#, 1
	note G#, 1
	octave 4
	note D_, 1
	note G#, 1
	note D_, 1
	octave 3
	note A_, 1
	note G#, 1
	note D_, 1
	note G#, 1
	octave 4
	note D_, 1
	octave 3
	note G#, 1
	note D_, 1
	octave 4
	note G#, 1
	octave 3
	note G#, 1
	octave 4
	note D_, 1
	note G#, 1
	note D_, 1
	octave 3
	note A_, 1
	note G#, 1
	note D_, 1
	octave 4
	note D_, 1
	note G#, 1
	octave 3
	note D_, 1
	note G#, 1
	octave 4
	note D_, 1
	octave 3
	note G#, 1
	note D_, 1
	octave 4
	note G#, 1
	note D_, 1
	octave 3
	note A_, 1
	note G#, 1
	note D_, 1
	note G#, 1
	note D_, 1
	note G#, 1
	note D_, 1
	note G#, 1
	octave 4
	note G#, 1
	note D_, 1
	note G#, 1
	note D_, 1
	octave 3
	note A_, 1
	note G#, 1
	note A_, 1
	octave 4
	note D_, 1
	note G#, 1
	note D_, 1
	octave 3
	note G#, 1
	note A_, 1
	note G#, 1
	octave 4
	note D_, 1
	note G#, 1
	note D_, 1
	octave 3
	note A_, 1
	note G#, 1
	note A_, 1
	note G#, 1
	note A_, 1
	note G#, 1
	note D_, 1
	octave 4
	note D_, 1
	octave 3
	note G#, 1
	octave 4
	note G#, 1
	octave 3
	note G#, 1
	octave 4
	note G#, 1
	note D#, 1
	note D_, 1
	note D#, 1
	note G#, 2
	octave 3
	note G#, 1
	note D_, 1
	octave 4
	note D#, 1
	octave 3
	note G#, 1
	octave 4
	note G#, 1
	octave 5
	note D_, 1
	octave 4
	note G#, 1
	note D#, 1
	note D_, 1
	octave 3
	note G#, 1
	octave 4
	note D_, 1
	note D#, 1
	note D_, 1
	octave 3
	note G#, 1
	octave 4
	note D_, 1
	note D#, 1
	note G#, 1
	octave 5
	note D_, 1
	octave 4
	note G#, 1
	note D#, 1
	note D_, 1
	intensity $71
	note G#, 1
	intensity $61
	note D_, 1
	intensity $51
	note G#, 1
	intensity $41
	note D_, 1
	intensity $31
	note G#, 1
	intensity $21
	note D_, 1
	intensity $11
	note G#, 1
	notetype $3, $65
	octave 4
	note D_, 4
	note A_, 4
	note G_, 4
	octave 5
	note D#, 13
	octave 4
	note A#, 4
	note A_, 4
	note G_, 4
	octave 5
	note D#, 13
	octave 4
	note D_, 4
	note A_, 4
	note G_, 4
	octave 5
	note D#, 13
	octave 4
	note A#, 4
	note A_, 4
	note G_, 4
	octave 5
	note D#, 9
	notetype $c, $90
Music_MotherBeastBattleSM_Ch2_loop_main:
	dutycycle 2
Music_MotherBeastBattleSM_Ch2_loop_1:
	octave 3
	callchannel Music_MotherBeastBattleSM_Ch2_branch_1
	octave 2
	note A_, 1
	octave 3
	callchannel Music_MotherBeastBattleSM_Ch2_branch_2
	loopchannel 6, Music_MotherBeastBattleSM_Ch2_loop_1
	notetype $3, $42
	dutycycle 2
	note __, 8  ;
	octave 2
	note E_, 1
	note A_, 7 ;
	octave 3
	intensity $92
	note E_, 1
	note A_, 7 ;
	octave 4
	note E_, 1
	note A_, 11 ;
	octave 3
	note G_, 1
	octave 4
	note C_, 7 ;
	note G_, 1
	octave 5
	note C_, 13 ;
	octave 3
	note A#, 2
	octave 4
	note E_, 2 ;
	note A#, 2
	notetype $4, $92
	octave 5
	note E_, 1
	note A#, 1
	note E_, 1
	note A#, 1
	note E_, 1
	note A#, 1
	note E_, 1
	note A#, 1
	note E_, 1
	note A#, 1
	note E_, 1
	note A#, 1
	note E_, 1
	note A#, 1
	note E_, 1
	note A#, 1
	note E_, 1
	note A#, 4
	notetype $3, $92
	note __, 12
	note F_, 1
	octave 6
	note C#, 7
	octave 5
	note C#, 1
	note A_, 7
	note B_, 1
	octave 6
	note D#, 7
	octave 5
	note D#, 1
	note G_, 7
	note __, 16
	note A#, 2
	note B_, 2
	note A#, 4
	octave 4
	note A_, 2
	note A#, 2
	note A_, 4
	octave 5
	note A_, 2
	note A#, 2
	note A_, 4
	note __, 8
	note E_, 1
	octave 4
	note A#, 1
	note E_, 1
	octave 3
	intensity $72
	note A#, 1
	intensity $52
	note E_, 1
	intensity $32
	octave 2
	note A#, 3
	dutycycle 0
	notetype $c, $74
	octave 3
	note __, 2
	note E_, 1
	note D_, 1
	note A_, 3
	note E_, 1
	note D_, 1
	octave 2
	note A_, 1
	octave 3
	note A_, 2
	note C#, 1
	octave 2
	note A_, 1
	octave 3
	note E_, 1
	note C#, 1
	note A_, 3
	note E_, 1
	note D_, 1
	octave 2
	note A_, 1
	octave 3
	note A_, 2
	octave 2
	note A#, 1
	note A_, 1
	octave 3
	note E_, 1
	note D_, 1
	note A_, 3
	note E_, 1
	note D_, 1
	octave 2
	note A_, 1
	octave 3
	note A_, 2
	octave 2
	note A_, 2
	octave 3
	note D_, 2
	note E_, 2
	note F_, 2
	note G_, 2
	note A_, 4
	octave 4
	note D_, 1
	note C_, 1
	note G_, 3
	note D_, 1
	note C_, 1
	octave 3
	note G_, 1
	octave 4
	note G_, 2
	octave 3
	note C_, 1
	note G_, 1
	octave 4
	note D_, 1
	note C_, 1
	note G_, 3
	note D_, 1
	note C_, 1
	octave 3
	note G_, 1
	octave 4
	note G_, 4
	note D_, 1
	note C_, 1
	note G_, 3
	note D_, 1
	note C_, 1
	octave 3
	note G_, 1
	octave 4
	note G_, 4
	notetype $6, $72
	octave 5
	note C_, 1
	octave 4
	note G_, 1
	note C_, 1
	octave 3
	note F#, 1
	note C_, 1
	octave 2
	note F#, 1
	note D_, 1
	octave 1
	note G_, 1
	note C_, 4
	notetype $c, $74
	octave 4
	note G_, 4
	note __, 2
	intensity $94
	octave 3
	note D_, 1
	note D_, 1
	note D_, 1
	note __, 1
	note G_, 1
	note __, 1
	note F#, 1
	note __, 1
	note C#, 1
	note __, 3
	note B_, 1
	note __, 2
	note B_, 1
	note A#, 1
	octave 2
	note A#, 1
	note __, 1
	note A#, 1
	note __, 2
	octave 3
	intensity $90
	note G_, 5
	intensity $94
	note G_, 3
	note D_, 1
	note F#, 1
	note D#, 1
	note __, 1
	note D_, 1
	note __, 7
	note F#, 1
	note __, 1
	note G_, 1
	note __, 3
	octave 4
	dutycycle 3
	note C_, 1
	note D_, 1
	note D#, 1
	octave 5
	note C_, 1
	octave 4
	note A#, 1
	note __, 1
	dutycycle 0
	octave 3
	note D_, 1
	note __, 1
	dutycycle 3
	octave 5
	note C_, 2
	note __, 2
	dutycycle 0
	octave 3
	note C#, 1
	note __, 1
	note B_, 1
	note C#, 1
	octave 2
	note A#, 1
	note A#, 1
	note __, 1
	note A#, 1
	note __, 2
	octave 3
	dutycycle 3
	note D_, 2
	note D#, 2
	note A_, 2
	octave 4
	note D#, 2
	dutycycle 0
	octave 3
	note D_, 1
	note D_, 1
	note D#, 1
	note __, 9
	note F#, 1
	note __, 1
	note G_, 1
	note __, 3
	dutycycle 2
	octave 3
	intensity $70
	note D_, 1
	note G_, 1
	note D_, 1
	note G_, 1
	note D_, 1
	note G_, 1
	note D_, 1
	note G_, 1
	octave 4
	note D_, 1
	note G#, 1
	note D_, 1
	note G#, 1
	note C#, 1
	note F#, 1
	note C#, 1
	note F#, 1
	note G_, 1
	note D_, 1
	note G_, 1
	note D_, 1
	note G#, 1
	note C#, 1
	note G_, 1
	note D_, 1
	note G_, 1
	note C#, 1
	note G#, 1
	note C#, 1
	note G#, 1
	note C#, 1
	note G_, 1
	note D_, 1
	intensity $50
	note G_, 1
	intensity $30
	note D_, 1
	intensity $90
	dutycycle 0
	callchannel Music_MotherBeastBattleSM_Ch2_branch_3
	loopchannel 0, Music_MotherBeastBattleSM_Ch2_loop_main

Music_MotherBeastBattleSM_Ch2_branch_1:
	note D_, 1
	note E_, 1
	note F_, 1
	note D_, 1
	note G_, 1
	note E_, 1
	note F_, 1
	note D_, 1
	note E_, 1
	note C_, 1
	note D_, 1
	endchannel

Music_MotherBeastBattleSM_Ch2_branch_2:
	note D_, 1
	note E_, 1
	note F_, 1
	note D_, 1
	note G_, 1
	note E_, 1
	note D_, 1
	note E_, 1
	note F_, 1
	note G_, 1
	note E_, 1
	note F_, 1
	endchannel

Music_MotherBeastBattleSM_Ch2_branch_3:
	octave 4
	note G_, 1
	note G#, 1
	note D_, 1
	note G_, 1
	octave 3
	note G_, 1
	octave 4
	note C#, 1
	octave 3
	note B_, 1
	note F#, 1
	octave 2
	note B_, 1
	octave 3
	note B_, 1
	note D#, 1
	note A_, 1
	endchannel

Music_MotherBeastBattleSM_Ch3:
	notetype $c, $19
	octave 2
	note __, 4
	note D_, 16
	note D_, 8
	intensity $29
	note D_, 4
	intensity $39
	note D_, 2
	intensity $19
	note G#, 11
	intensity $29
	note G#, 2
	intensity $39
	note G#, 2
	note __, 5
	octave 1
	intensity $29
	note A#, 12
	note A#, 9
	intensity $39
	note A#, 3
Music_MotherBeastBattleSM_Ch3_loop_main:
	note __, 12
	note __, 12
	note __, 12
	intensity $19
	octave 2
	note A_, 1
	note __, 1
	note A#, 1
	note __, 1
	note G_, 1
	note __, 2
	note A_, 1
	note D_, 1
	note __, 1
	note E_, 1
	note __, 1
	intensity $29
	octave 2
	note D_, 12
	note D#, 12
	note D_, 12
	note D_, 12
	notetype $6, $19
	note A_, 1
	note __, 1
	note A_, 2
	note __, 2
	note A_, 2
	note __, 12
	note A_, 4
	note A#, 1
	note __, 1
	note A#, 1
	note __, 1
	note A#, 2
	note __, 2
	note A#, 2
	note __, 10
	note A#, 4
	note B_, 1
	note __, 1
	note B_, 2
	note __, 2
	note B_, 2
	note __, 12
	note B_, 4
	note A_, 2
	note __, 2
	note A#, 2
	note __, 2
	note G_, 2
	note __, 4
	note A_, 2
	note D_, 2
	note __, 2
	note E_, 2
	note __, 2
	notetype $c, $19
	octave 2
	note A_, 12
	note G#, 12
	note B_, 12
	octave 1
	note B_, 12
	octave 2
	intensity $29
	note D_, 12
	note C#, 12
	note C_, 12
	octave 1
	note B_, 8
	note A#, 4
	note G_, 12
	note B_, 8
	note A#, 3
	note __, 1
	note A#, 8
	note G#, 4
	note G_, 7
	note __, 1
	note G_, 4
	intensity $19
	octave 2
Music_MotherBeastBattleSM_Ch3_loop_1:
	note C_, 4
	note __, 2
	loopchannel 16, Music_MotherBeastBattleSM_Ch3_loop_1
	octave 1
	intensity $29
Music_MotherBeastBattleSM_Ch3_loop_2:
	note C_, 4
	note __, 2
	loopchannel 6, Music_MotherBeastBattleSM_Ch3_loop_2
	note C_, 1
	note __, 11
	loopchannel 0, Music_MotherBeastBattleSM_Ch3_loop_main

Music_MotherBeastBattleSM_Ch4:
	togglenoise $3
	callchannel Music_MotherBeastBattleSM_Ch4_buildup
	note C_, 2 ;
	note C#, 1
	note C#, 3
	note C_, 2
	note C#, 1 ;
	note F#, 2
	note F#, 1
	note C#, 1
	note F#, 1
	note E_, 4 ;
	note C#, 1
	note F#, 1
	note F#, 1
	note F#, 2
	note F#, 1
	note C_, 2 ;
	note F#, 1
	note F#, 1
	note E_, 2
	note E_, 2
	note C_, 1 ;
	note C#, 1
	note C#, 1
	note C_, 1
	note C#, 1
	note C#, 1
	note C_, 2
	note E_, 3 ;
	note F#, 1
	note C#, 2
	note C#, 2
	note F#, 1 ;
	note C#, 1
	note A#, 2
	note C#, 1
	note C#, 3
	note A#, 4 ;
	note C_, 16
	note __, 2
	note F#, 2
	note E_, 6
	note C_, 1
	note C_, 1
	note C_, 1
	note C_, 1
	note B_, 12
	note __, 12
	note __, 12
	note __, 14
Music_MotherBeastBattleSM_Ch4_loop_main:
	callchannel Music_MotherBeastBattleSM_Ch4_buildup
	callchannel Music_MotherBeastBattleSM_Ch4_branch_1
	callchannel Music_MotherBeastBattleSM_Ch4_branch_2
	callchannel Music_MotherBeastBattleSM_Ch4_branch_1
	callchannel Music_MotherBeastBattleSM_Ch4_branch_3
	callchannel Music_MotherBeastBattleSM_Ch4_branch_1
	callchannel Music_MotherBeastBattleSM_Ch4_branch_2
	callchannel Music_MotherBeastBattleSM_Ch4_branch_1
	callchannel Music_MotherBeastBattleSM_Ch4_branch_3
	notetype $c
	note C_, 12
	note D#, 12
	note D#, 12
	note D#, 6
	note D#, 2
	note C_, 4
	note C_, 12
	note D#, 12
	note D#, 12
	note D#, 6
	note D#, 2
	note C_, 4
Music_MotherBeastBattleSM_Ch4_loop_1:
	note C_, 3
	note C_, 3
	note C_, 3
	note C_, 1
	note D#, 2
	loopchannel 11, Music_MotherBeastBattleSM_Ch4_loop_1
	note C_, 8
	loopchannel 0, Music_MotherBeastBattleSM_Ch4_loop_main

Music_MotherBeastBattleSM_Ch4_branch_1:
	note C_, 6
	note C_, 2
	note D#, 2
	note D#, 1
	note D#, 1
	note C_, 2
	note D#, 2
	note E_, 2
	note C_, 2
	note E_, 1
	note E_, 1
	note D#, 2
	note C_, 2
	note D#, 2
	note C_, 2
	note G#, 1
	note G#, 1
	note C_, 2
	note F#, 2
	note F#, 2
	note C_, 2
	note D#, 2
	note E_, 1
	note E_, 1
	note C_, 2
	note D#, 2
	endchannel

Music_MotherBeastBattleSM_Ch4_branch_2:
	note C_, 2
	note D#, 2
	note E_, 1
	note E_, 1
	note C_, 2
	note F#, 2
	note D#, 1
	note E_, 1
	note C_, 2
	note F#, 1
	note F#, 1
	note C#, 2
	note C_, 2
	note F#, 1
	note F#, 1
	note C#, 2
	note C_, 4
	note C_, 4
	note C_, 2
	note D#, 2
	note D#, 2
	note C_, 2
	note C_, 2
	note D#, 2
	note C_, 2
	note D#, 2
	endchannel

Music_MotherBeastBattleSM_Ch4_branch_3:
	note C_, 6
	note C_, 2
	note D#, 2
	note D#, 1
	note D#, 1
	note C_, 2
	note D#, 2
	note E_, 2
	note C_, 2
	note E_, 1
	note E_, 1
	note D#, 2
	note C_, 2
	note D#, 2
	note C_, 2
	note G#, 1
	note G#, 1
	note C_, 2
	note F#, 2
	note F#, 2
	note C_, 2
	note D#, 2
	note C_, 2
	note C_, 1
	note E_, 3
	endchannel

Music_MotherBeastBattleSM_Ch4_buildup:
	notetype $3
	note G_, 1
	note G_, 1
	note G_, 1
	note G_, 1
	note G_, 1
	note G_, 1
	note G_, 1
	note G_, 1
	note F#, 1
	note F#, 1
	note F#, 1
	note F#, 1
	note F#, 1
	note F#, 1
	note F#, 1
	note F#, 1
	notetype $6
	endchannel
