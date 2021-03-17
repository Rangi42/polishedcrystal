; Pokémon G/S/C - Kanto Wild Battle (Night)
; Demixed by TriteHexagon
; https://pastebin.com/p19WcKbx
; https://hax.iimarckus.org/topic/7697/

Music_KantoWildBattleNight:
	musicheader 3, 1, Music_KantoWildBattleNight_Ch1
	musicheader 1, 2, Music_KantoWildBattleNight_Ch2
	musicheader 1, 3, Music_KantoWildBattleNight_Ch3

Music_KantoWildBattleNight_Ch1:
	tempo 117
	volume $77
	vibrato $12, $22
	dutycycle $2
	notetype $c, $b7
	note __, 16
	octave 4
	note A#, 6
	note A_, 1
	note G#, 1
	note A_, 1
	note G#, 1
	note G_, 1
	note F#, 1
	note G#, 1
	note G_, 1
	note F#, 1
	note F_, 1
	callchannel Music_KantoWildBattle_branch_ed091

Music_KantoWildBattleNight_Ch2:
	dutycycle $3
	vibrato $12, $22
	notetype $c, $b1
	octave 4
rept 5
	note G_, 1
	note F#, 1
	note F_, 1
	note E_, 1
endr
	note F#, 1
	note F_, 1
	note E_, 1
	note D#, 1
	note F_, 1
	note E_, 1
	note D#, 1
	note D_, 1
	note E_, 1
	note D#, 1
	note D_, 1
	note C#, 1
	dutycycle $2
	callchannel Music_KantoWildBattle_branch_ed1c8

Music_KantoWildBattleNight_Ch3:
	vibrato $12, $23
	notetype $c, $12
	callchannel Music_KantoWildBattle_Ch3Intro
Music_KantoWildBattleNight_Ch3loop:
	notetype $c, $12
	callchannel Music_KantoWildBattle_Type1
	callchannel Music_KantoWildBattle_Ch3_Part3
	callchannel Music_KantoWildBattle_Type1
	callchannel Music_KantoWildBattle_Ch3_Part4
	intensity $22
	callchannel Music_KantoWildBattle_Type2
	intensity $12
	octave 5
	note F#, 2
	intensity $22
	callchannel Music_KantoWildBattle_Type2
	intensity $12
	octave 5
	note E_, 2
	intensity $22
	note C_, 1
	octave 4
	note G_, 1
	intensity $12
	octave 5
	note G_, 2
	intensity $22
	callchannel Music_KantoWildBattle_Type2
	intensity $12
	octave 5
	note A_, 2
	intensity $22
	callchannel Music_KantoWildBattle_Type2
	intensity $12
	octave 5
	note G_, 2
	intensity $22
	note C_, 1
	octave 4
	note G#, 1
	intensity $12
	octave 5
	note G#, 12
	note G_, 2
	note F_, 2
	note G#, 2
	note G_, 2
	note C#, 1
	note F_, 1
	note G#, 1
	octave 6
	note C_, 1
	note C#, 8
	octave 5
	note C_, 2
	intensity $22
	callchannel Music_KantoWildBattle_Type3
	intensity $12
	note A#, 2
	intensity $22
	callchannel Music_KantoWildBattle_Type3
	intensity $12
	note G#, 2
	intensity $22
	note E_, 1
	note G_, 1
	intensity $12
	octave 5
	note C#, 2
	intensity $22
	callchannel Music_KantoWildBattle_Type3
	intensity $12
	octave 5
	note C_, 2
	intensity $22
	callchannel Music_KantoWildBattle_Type3
	intensity $12
	note A#, 2
	intensity $22
	note E_, 1
	note G_, 1
	intensity $12
	octave 5
	note F_, 2
	intensity $22
	callchannel Music_KantoWildBattle_Type4
	intensity $12
	note E_, 2
	intensity $22
	callchannel Music_KantoWildBattle_Type4
	intensity $12
	note D_, 2
	intensity $22
	octave 4
	note G_, 1
	octave 5
	note C_, 1
	intensity $12
	octave 4
	note A#, 4
	octave 5
	note C_, 4
	note D_, 4
	note F_, 4
	note G#, 16
	notetype $6, $12
	note G#, 1
	note __, 1
	intensity $22
	note G#, 1
	note __, 1
	intensity $32
	callchannel Music_KantoWildBattle_Type5
	intensity $22
	callchannel Music_KantoWildBattle_Type5
	intensity $12
	note G#, 1
	note __, 1
	note G#, 1
	note __, 1
	octave 6
rept 4
	note C#, 1
	note __, 1
endr
	octave 5
	note G_, 2
	note F_, 2
	note E_, 2
	note F_, 2
	notetype $c, $12
	note G_, 12
	note G_, 8
	notetype $6, $12
rept 4
	note G_, 1
	note __, 1
endr
	intensity $22
	note G_, 1
	note __, 1
	note G_, 1
	note __, 1
	intensity $12
	note G_, 1
	note __, 1
	note G_, 1
	note __, 1
	notetype $c, $12
	octave 2
	note A#, 16
	note A#, 1
	note __, 2
	note A#, 1
	note __, 2
	note A#, 1
	note __, 1
	octave 3
	note A#, 1
	note __, 2
	note A#, 1
	note __, 2
	note A#, 1
	note __, 1
	note C_, 1
	note __, 2
	notetype $6, $12
	callchannel Music_KantoWildBattle_Type6
	octave 4
	note C_, 2
	note __, 2
	octave 3
	note C_, 4
	note C_, 2
	note __, 4
	callchannel Music_KantoWildBattle_Type6
	octave 2
	note A#, 2
	note __, 2
	note A#, 2
	note __, 2
	notetype $c, $12
	callchannel Music_KantoWildBattle_Ch3_Part1
	intensity $11
	callchannel Music_KantoWildBattle_Ch3_Part2
	loopchannel 0, Music_KantoWildBattleNight_Ch3loop
