; Pokémon B/W - Battle! World Championship Finals
; Demixed by Pigu and PikalaxALT
; https://github.com/TwitchPlaysPokemon/tppcrystal251pub/blob/public/audio/music/custom/vsWCS.asm

Music_WCSBattleBW:
	dbw $80, Music_WCSBattleBW_Ch2
	dbw $01, Music_WCSBattleBW_Ch1
	dbw $02, Music_WCSBattleBW_Ch3

Music_WCSBattleBW_Ch1:
	dutycycle $2
	notetype $c, $8c
	octave 2
	note A#, 12
	intensity $c1
	note A#, 1
	note A#, 1
	note A#, 1
	note A#, 1
	intensity $c8
	note A#, 12
	intensity $c1
	note A#, 1
	note A#, 1
	note A#, 1
	note A#, 1
	octave 3
	intensity $c8
	note C_, 12
	intensity $c1
	note C_, 1
	note C_, 1
	note C_, 1
	note C_, 1
	intensity $c8
	note C_, 12
	intensity $c1
	note C_, 1
	note C_, 1
	note C_, 1
	note C_, 1
	dutycycle $3
	intensity $e7
	note C_, 8
	note C#, 8
	note D#, 8
	note F_, 8
	note C_, 8
	note C#, 8
	note D#, 8
	note F_, 4
	note C_, 1
	note C#, 1
	note D#, 1
	note F_, 1
	note G_, 8
	note G#, 8
	note A#, 8
	octave 4
	note C_, 8
	octave 3
	note G_, 8
	note G#, 8
	note A#, 8
	octave 4
	note C_, 8
	intensity $c8
	vibrato $5, $22
	note C#, 16
	note C#, 16
	note C_, 16
	note C_, 16
	octave 3
	note A#, 16
	note A#, 16
	note G#, 16
	note F_, 8
	note G#, 8
	note G_, 16
	octave 4
	note C_, 16
Music_WCSBattleBW_Ch1_L:
	intensity $e7
	vibrato $0, $0
	note C_, 8
	octave 3
	note B_, 8
	note A#, 8
	note G_, 8
	note F#, 4
	note G_, 12
	dutycycle $2
	intensity $c8
	octave 2
	note A#, 1
	note A_, 1
	note G_, 1
	note A#, 1
	octave 3
	note C_, 1
	octave 2
	note A#, 1
	note A_, 1
	octave 3
	note C_, 1
	note D_, 1
	note C_, 1
	octave 2
	note A#, 1
	octave 3
	note D_, 1
	note D#, 1
	octave 2
	note A#, 1
	octave 3
	note D_, 1
	note G_, 1
	dutycycle $3
	intensity $e7
	octave 4
	note C_, 8
	octave 3
	note B_, 8
	note A#, 8
	note G_, 8
	note F#, 4
	note G_, 12
	note B_, 4
	octave 4
	note C_, 16
	note __, 4
	note A#, 8
	octave 5
	note C#, 8
	octave 4
	note A#, 1
	note F_, 1
	note F_, 1
	octave 3
	note A#, 1
	notetype $6, $7e
	octave 4
	note C_, 1
	note D_, 1
	note E_, 2
	note F_, 1
	note G_, 1
	note A_, 1
	note B_, 1
	notetype $c, $1e
	octave 5
	note C_, 1
	note C_, 3
	intensity $e7
	octave 3
	note A#, 4
	octave 5
	intensity $e1
	note C_, 1
	note C_, 3
	intensity $e7
	octave 4
	note C#, 4
	octave 5
	intensity $e1
	note C_, 1
	note C_, 3
	intensity $e7
	octave 3
	note A#, 4
	octave 5
	intensity $e1
	note C_, 1
	note C_, 1
	intensity $e7
	octave 3
	note G_, 4
	note A#, 2
	octave 5
	intensity $e1
	note C_, 1
	note C_, 3
	intensity $e7
	octave 4
	note A#, 4
	octave 5
	intensity $e1
	note C_, 1
	note C_, 3
	intensity $e7
	note C#, 4
	intensity $e1
	note C_, 1
	note C_, 3
	intensity $e7
	octave 4
	note A#, 4
	octave 5
	intensity $e1
	note C_, 1
	note C_, 1
	intensity $e7
	octave 4
	note G_, 4
	note A#, 2
	note C_, 4
	note C#, 2
	note D_, 10
	octave 3
	note D#, 6
	note D_, 1
	note C#, 1
	note C_, 8
	octave 4
	note C#, 4
	note D_, 2
	note D#, 10
	octave 3
	note E_, 6
	note D#, 1
	note D_, 1
	note C#, 8
	octave 4
	note D_, 4
	note D#, 2
	note E_, 10
	octave 3
	note F_, 6
	note E_, 1
	note D#, 1
	note D_, 8
	octave 4
	note D_, 14
	note C_, 1
	note C#, 1
	note D_, 16
	octave 3
	note D_, 16
	note A_, 4
	note A#, 12
	note D#, 4
	note G_, 12
	octave 4
	note C_, 16
	octave 3
	note F_, 16
	octave 4
	note C#, 8
	note F#, 8
	note G#, 8
	note F#, 8
	note F_, 16
	note __, 16
	octave 3
	note A#, 2
	note A_, 2
	note G_, 2
	note A_, 2
	note A#, 2
	note A_, 2
	octave 4
	note D_, 2
	octave 3
	note A#, 2
	note A#, 1
	note __, 1
	note A_, 1
	note __, 1
	note G_, 1
	note __, 1
	note A_, 1
	note __, 1
	note A#, 1
	note __, 1
	note A_, 1
	note __, 1
	octave 4
	note D_, 1
	note __, 1
	octave 3
	note A#, 1
	note __, 1
	octave 4
	note C_, 8
	octave 3
	note B_, 8
	note A#, 8
	note G_, 8
	note F#, 4
	note G_, 12
	note A#, 8
	note G#, 8
	octave 4
	note C_, 8
	octave 3
	note B_, 8
	note A#, 8
	note G_, 8
	note F#, 4
	note G_, 12
	note A#, 8
	octave 4
	note C#, 8
	note C_, 16
	note F#, 4
	note G_, 12
	loopchannel 0, Music_WCSBattleBW_Ch1_L

Music_WCSBattleBW_Ch2:
	tempo $69
	volume $77
	dutycycle $2
	notetype $c, $8c
	octave 2
	note F_, 12
	intensity $c1
	note F_, 1
	note F_, 1
	note F_, 1
	note F_, 1
	intensity $c8
	note F_, 12
	intensity $c1
	note F_, 1
	note F_, 1
	note F_, 1
	note F_, 1
	intensity $c8
	note G_, 12
	intensity $c1
	note G_, 1
	note G_, 1
	note G_, 1
	note G_, 1
	intensity $c8
	note G_, 12
	intensity $c1
	note G_, 1
	note G_, 1
	note G_, 1
	note G_, 1
	dutycycle $3
	intensity $e7
	note G_, 8
	note G#, 8
	note A#, 8
	octave 3
	note C_, 8
	octave 2
	note G_, 8
	note G#, 8
	note A#, 8
	octave 3
	note C_, 8
	note D_, 8
	note D#, 8
	note F_, 8
	note G_, 8
	note D_, 8
	note D#, 8
	note F_, 8
	note G_, 8
	intensity $c8
	vibrato $5, $22
	note F#, 16
	note G#, 8
	note F#, 8
	note F_, 16
	note C_, 8
	note F_, 8
	note D#, 16
	note F_, 8
	note D#, 8
	note D#, 16
	note C_, 8
	note D#, 8
	note D_, 16
	note E_, 16
Music_WCSBattleBW_Ch2_L:
	intensity $e7
	vibrato $0, $0
	octave 3
	note G_, 8
	note F#, 8
	note F_, 8
	note D_, 8
	note C#, 4
	note D_, 12
	dutycycle $2
	intensity $c8
	octave 2
	note G_, 1
	note F#, 1
	note E_, 1
	note G_, 1
	note A_, 1
	note G_, 1
	note F#, 1
	note A_, 1
	note A#, 1
	note A_, 1
	note G_, 1
	note A#, 1
	octave 3
	note C_, 1
	octave 2
	note G_, 1
	note A#, 1
	octave 3
	note D#, 1
	dutycycle $3
	intensity $e7
	note G_, 8
	note F#, 8
	note F_, 8
	note D_, 8
	note C#, 4
	note D_, 12
	note F#, 4
	note G_, 16
	note __, 4
	note F_, 8
	note G#, 8
	note F_, 8
	intensity $e1
	note G_, 1
	note G_, 7
	note G_, 1
	note G_, 7
	note G_, 1
	note G_, 7
	note G_, 8
	note G_, 1
	note G_, 7
	note G_, 1
	note G_, 7
	note G_, 1
	note G_, 7
	note G_, 8
	intensity $e7
	note C_, 1
	octave 2
	note B_, 1
	octave 3
	note C_, 1
	note C#, 1
	note D_, 1
	note C#, 1
	note D_, 1
	note D#, 1
	note E_, 1
	note D#, 1
	note E_, 1
	note F#, 1
	note G_, 1
	note F#, 1
	note F_, 1
	note D#, 1
	note G_, 1
	octave 2
	note B_, 1
	octave 3
	note C_, 1
	note D_, 1
	note D#, 1
	note D_, 1
	note D#, 1
	note F_, 1
	note G_, 1
	note F#, 1
	note G_, 1
	note G#, 1
	octave 4
	note C_, 1
	octave 3
	note G_, 1
	note F_, 1
	note D#, 1
	note C_, 1
	octave 2
	note B_, 1
	octave 3
	note C_, 1
	note C#, 1
	note D_, 1
	note C#, 1
	note D_, 1
	note D#, 1
	note E_, 1
	note D#, 1
	note E_, 1
	note F#, 1
	note G_, 1
	note F#, 1
	note F_, 1
	note D#, 1
	note G_, 1
	octave 2
	note B_, 1
	octave 3
	note C_, 1
	note D_, 1
	note D#, 1
	note D_, 1
	note D#, 1
	note F_, 1
	note G_, 1
	note F#, 1
	note G_, 1
	note G#, 1
	octave 4
	note C_, 1
	octave 3
	note G_, 1
	note F_, 1
	note D#, 1
	note D_, 1
	note C#, 1
	note D_, 1
	note D#, 1
	note E_, 1
	note D#, 1
	note E_, 1
	note F_, 1
	note F#, 1
	note F_, 1
	note F#, 1
	note G#, 1
	note A_, 1
	note G#, 1
	note G_, 1
	note F_, 1
	note A_, 1
	note C#, 1
	note D_, 1
	note E_, 1
	note F_, 1
	note E_, 1
	note F_, 1
	note G_, 1
	note A_, 1
	note G#, 1
	note A_, 1
	note A#, 1
	octave 4
	note D_, 1
	octave 3
	note A_, 1
	note G_, 1
	note F_, 1
	note A_, 14
	note G_, 1
	note G#, 1
	note A_, 16
	octave 2
	note A_, 8
	octave 3
	note D_, 1
	octave 2
	note A_, 1
	octave 3
	note D_, 1
	note F_, 1
	note D_, 1
	note F_, 1
	note A_, 1
	octave 4
	note D_, 1
	octave 3
	note D#, 1
	note __, 1
	octave 2
	note A#, 1
	note __, 1
	octave 3
	note D#, 1
	note __, 1
	note G_, 1
	note __, 1
	note D#, 1
	note __, 1
	note G_, 1
	note __, 1
	note A#, 1
	note __, 1
	note D#, 1
	note __, 1
	note A#, 6
	note A_, 1
	note G#, 1
	note G_, 8
	note F_, 14
	note F_, 1
	note G_, 1
	note A_, 1
	note __, 1
	note F_, 1
	note __, 1
	note A_, 1
	note __, 1
	octave 4
	note C_, 1
	note __, 1
	octave 3
	note F_, 1
	note __, 1
	note C_, 1
	note __, 1
	note F_, 1
	note __, 1
	octave 4
	note C_, 1
	note __, 1
	octave 3
	note A#, 16
	octave 4
	note D#, 8
	note C#, 8
	note C_, 14
	octave 3
	note F_, 1
	note G_, 1
	note A_, 1
	note __, 1
	note F_, 1
	note __, 1
	note A_, 1
	note __, 1
	octave 4
	note C_, 1
	note __, 1
	octave 3
	note A_, 1
	note __, 1
	note F_, 1
	note __, 1
	note C_, 1
	note __, 1
	note A_, 1
	note __, 1
	note A#, 14
	note A_, 1
	note G#, 1
	note G_, 8
	note D#, 8
	note G_, 8
	note F#, 8
	note F_, 8
	note D_, 8
	note C#, 4
	note D_, 12
	note F_, 8
	note D#, 8
	note G_, 8
	note F#, 8
	note F_, 8
	note D_, 8
	note C#, 4
	note D_, 12
	note F_, 8
	note G#, 8
	note G_, 16
	octave 4
	note C_, 16
	loopchannel 0, Music_WCSBattleBW_Ch2_L

Music_WCSBattleBW_Ch3:
	notetype $c, $16
	octave 4
	note __, 16
	note __, 16
	note A#, 1
	octave 5
	note C_, 1
	note C#, 1
	note C_, 1
	note D#, 1
	note C_, 1
	note E_, 1
	note C#, 1
	octave 4
	note A#, 1
	octave 5
	note C#, 1
	note C_, 7
	note __, 1
	note C_, 1
	note __, 1
	note C_, 1
	note __, 1
	note C_, 1
	note __, 1
	note C_, 1
	note __, 1
	note C_, 1
	note __, 1
	note C_, 1
	note __, 1
	note C_, 1
	note __, 1
	intensity $15
	octave 3
	note C_, 3
	note __, 1
	note C_, 1
	octave 2
	note C_, 1
	note __, 2
	octave 3
	note C#, 3
	note __, 1
	note C#, 1
	octave 2
	note C#, 1
	note __, 2
	octave 3
	note D#, 3
	note __, 1
	note D#, 1
	octave 2
	note D#, 1
	note __, 2
	octave 3
	note F_, 3
	note __, 1
	note F_, 1
	octave 2
	note F_, 1
	note __, 2
	octave 3
	note C_, 3
	note __, 1
	note C_, 1
	octave 2
	note C_, 1
	note __, 2
	octave 3
	note C#, 3
	note __, 1
	note C#, 1
	octave 2
	note C#, 1
	note __, 2
	octave 3
	note D#, 3
	note __, 1
	note D#, 1
	octave 2
	note D#, 1
	note __, 2
	octave 3
	note F_, 3
	note __, 1
	note F_, 1
	octave 2
	note F_, 1
	note __, 2
	octave 3
	note G_, 3
	note __, 1
	note G_, 1
	octave 2
	note G_, 1
	note __, 2
	octave 3
	note G#, 3
	note __, 1
	note G#, 1
	octave 2
	note G#, 1
	note __, 2
	octave 3
	note A#, 3
	note __, 1
	note A#, 1
	octave 2
	note A#, 1
	note __, 2
	octave 4
	note C_, 3
	note __, 1
	note C_, 1
	octave 3
	note C_, 1
	note __, 2
	note G_, 3
	note __, 1
	note G_, 1
	octave 2
	note G_, 1
	note __, 2
	octave 3
	note G#, 3
	note __, 1
	note G#, 1
	octave 2
	note G#, 1
	note __, 2
	octave 3
	note A#, 3
	note __, 1
	note A#, 1
	octave 2
	note A#, 1
	note __, 2
	octave 4
	note C_, 3
	note __, 1
	note C_, 1
	octave 3
	note C_, 1
	note __, 2
	intensity $16
	octave 4
	note C#, 1
	note __, 1
	note F#, 1
	note __, 1
	note A#, 1
	note __, 1
	octave 5
	note C_, 1
	note __, 1
	note C#, 1
	note __, 1
	note C_, 1
	note __, 1
	octave 4
	note A#, 1
	note __, 1
	note G#, 1
	note __, 1
	note F#, 1
	note __, 1
	note C#, 1
	note __, 1
	note F#, 1
	note __, 1
	note A#, 1
	note __, 1
	octave 5
	note C#, 1
	note __, 1
	note C_, 1
	note __, 1
	octave 4
	note A#, 1
	note __, 1
	note G#, 1
	note __, 1
	note C_, 1
	note __, 1
	note F_, 1
	note __, 1
	note A_, 1
	note __, 1
	note A#, 1
	note __, 1
	octave 5
	note C_, 1
	note __, 1
	octave 4
	note A#, 1
	note __, 1
	note A_, 1
	note __, 1
	note G_, 1
	note __, 1
	note F_, 1
	note __, 1
	note C_, 1
	note __, 1
	note F_, 1
	note __, 1
	note A_, 1
	note __, 1
	octave 5
	note C_, 1
	note __, 1
	octave 4
	note A#, 1
	note __, 1
	note A_, 1
	note __, 1
	note G_, 1
	note __, 1
	octave 3
	note A#, 1
	note __, 1
	octave 4
	note D#, 1
	note __, 1
	note G_, 1
	note __, 1
	note G#, 1
	note __, 1
	note A#, 1
	note __, 1
	note G#, 1
	note __, 1
	note G_, 1
	note __, 1
	note F_, 1
	note __, 1
	note D#, 1
	note __, 1
	octave 3
	note A#, 1
	note __, 1
	octave 4
	note D#, 1
	note __, 1
	note G_, 1
	note __, 1
	note A#, 1
	note __, 1
	note G#, 1
	note __, 1
	note G_, 1
	note __, 1
	note F_, 1
	note __, 1
	octave 3
	note G#, 1
	note __, 1
	octave 4
	note C#, 1
	note __, 1
	note F_, 1
	note __, 1
	note F#, 1
	note __, 1
	note G#, 1
	note __, 1
	note F#, 1
	note __, 1
	note F_, 1
	note __, 1
	note D#, 1
	note __, 1
	note C#, 1
	note __, 1
	octave 3
	note A#, 1
	note __, 1
	octave 4
	note C#, 1
	note __, 1
	note F_, 1
	note __, 1
	note G#, 1
	note __, 1
	note F#, 1
	note __, 1
	note F_, 1
	note __, 1
	note D#, 1
	note __, 1
	octave 3
	note G_, 1
	note __, 1
	octave 4
	note C_, 1
	note __, 1
	note E_, 1
	note __, 1
	note F_, 1
	note __, 1
	note G_, 1
	note __, 1
	note F_, 1
	note __, 1
	note E_, 1
	note __, 1
	note D_, 1
	note __, 1
	note C_, 1
	note __, 1
	octave 3
	note G_, 1
	note __, 1
	octave 4
	note C_, 1
	note __, 1
	note E_, 1
	note __, 1
	note G_, 1
	note __, 1
	note F_, 1
	note __, 1
	note E_, 1
	note __, 1
	note D_, 1
	note __, 1
Music_WCSBattleBW_Ch3_L:
	intensity $15
	octave 3
	note C_, 1
	octave 2
	note C_, 1
	note __, 6
	note B_, 1
	octave 1
	note B_, 1
	note __, 6
	octave 2
	note A#, 1
	octave 1
	note A#, 1
	note __, 6
	octave 3
	note D_, 1
	octave 2
	note D_, 1
	note __, 6
	intensity $18
Music_WCSBattleBW_Ch3_L1:
	octave 2
	note G_, 2
	octave 3
	note D_, 2
	loopchannel 8, Music_WCSBattleBW_Ch3_L1
Music_WCSBattleBW_Ch3_L2:
	octave 2
	note G_, 2
	octave 3
	note C_, 2
	loopchannel 8, Music_WCSBattleBW_Ch3_L2
Music_WCSBattleBW_Ch3_L3:
	octave 2
	note G_, 2
	octave 3
	note D_, 2
	loopchannel 4, Music_WCSBattleBW_Ch3_L3
	note C#, 1
	octave 2
	note B_, 1
	note A#, 1
	octave 3
	note D_, 1
	note C_, 2
	octave 2
	note G_, 2
	octave 3
	note C_, 2
	octave 2
	note G_, 2
	octave 3
	note C_, 2
	octave 2
	note G_, 2
	octave 3
	note C_, 2
	octave 2
	note G_, 2
	octave 3
	note C_, 2
	octave 2
	note G_, 2
	note A#, 2
	octave 3
	note F_, 2
	octave 2
	note A#, 2
	octave 3
	note C#, 2
	octave 2
	note A#, 2
	octave 3
	note F_, 2
	note C#, 2
	note C_, 2
	octave 2
	note A#, 2
	note F_, 2
	note A#, 2
	octave 3
	note C#, 2
	callchannel Music_WCSBattleBW_Ch3_P1
	note __, 4
	callchannel Music_WCSBattleBW_Ch3_P1
	note __, 4
	callchannel Music_WCSBattleBW_Ch3_P1
	note __, 4
	octave 3
	note C_, 1
	note __, 1
	octave 2
	note G_, 4
	note A#, 2
	callchannel Music_WCSBattleBW_Ch3_P1
	note F#, 4
	callchannel Music_WCSBattleBW_Ch3_P1
	note G_, 4
	callchannel Music_WCSBattleBW_Ch3_P1
	note F#, 4
	octave 3
	note C_, 1
	note __, 1
	octave 2
	note G_, 4
	note A#, 2
	octave 3
Music_WCSBattleBW_Ch3_L4:
	note C_, 2
	note G_, 2
	loopchannel 7, Music_WCSBattleBW_Ch3_L4
	note G#, 2
	note G_, 2
Music_WCSBattleBW_Ch3_L5:
	note C#, 2
	note G#, 2
	loopchannel 7, Music_WCSBattleBW_Ch3_L5
	note A#, 2
	note G#, 2
Music_WCSBattleBW_Ch3_L6:
	note D_, 2
	note A_, 2
	loopchannel 7, Music_WCSBattleBW_Ch3_L6
	note A#, 2
	note A_, 2
Music_WCSBattleBW_Ch3_L7:
	note D_, 2
	note A_, 2
	loopchannel 12, Music_WCSBattleBW_Ch3_L7
Music_WCSBattleBW_Ch3_L8:
	note D#, 2
	note A#, 2
	loopchannel 4, Music_WCSBattleBW_Ch3_L8
Music_WCSBattleBW_Ch3_L9:
	note D#, 2
	note G_, 2
	loopchannel 4, Music_WCSBattleBW_Ch3_L9
Music_WCSBattleBW_Ch3_L10:
	octave 3
	note F_, 2
	octave 4
	note C_, 2
	loopchannel 8, Music_WCSBattleBW_Ch3_L10
Music_WCSBattleBW_Ch3_L11:
	octave 3
	note F#, 2
	octave 4
	note C#, 2
	loopchannel 5, Music_WCSBattleBW_Ch3_L11
	note D#, 2
	note C#, 2
	octave 3
	note B_, 2
	note A#, 2
	note A_, 2
	note F#, 2
Music_WCSBattleBW_Ch3_L12:
	octave 3
	note F_, 2
	octave 4
	note C_, 2
	loopchannel 7, Music_WCSBattleBW_Ch3_L12
	octave 3
	note F_, 2
	note E_, 2
Music_WCSBattleBW_Ch3_L13:
	note D#, 2
	note A#, 2
	loopchannel 5, Music_WCSBattleBW_Ch3_L13
	octave 4
	note C_, 2
	octave 3
	note A#, 2
	note G#, 2
	note G_, 2
	note F#, 2
	note D#, 2
	note C_, 2
	note F_, 2
	note G_, 2
	note C_, 2
Music_WCSBattleBW_Ch3_L14:
	note C_, 2
	note G_, 2
	loopchannel 6, Music_WCSBattleBW_Ch3_L14
Music_WCSBattleBW_Ch3_L15:
	note D#, 2
	note A#, 2
	loopchannel 8, Music_WCSBattleBW_Ch3_L15
Music_WCSBattleBW_Ch3_L16:
	note C_, 2
	note G_, 2
	loopchannel 6, Music_WCSBattleBW_Ch3_L16
	note C_, 2
	note C#, 2
	note D#, 2
	note D_, 2
Music_WCSBattleBW_Ch3_L17:
	note D#, 2
	note A#, 2
	loopchannel 7, Music_WCSBattleBW_Ch3_L17
	note D_, 2
	note C#, 2
	intensity $15
Music_WCSBattleBW_Ch3_L18:
	octave 3
	note C_, 1
	octave 2
	note C_, 1
	note __, 6
	loopchannel 4, Music_WCSBattleBW_Ch3_L18
	loopchannel 0, Music_WCSBattleBW_Ch3_L

Music_WCSBattleBW_Ch3_P1:
	octave 3
	note C_, 1
	note C_, 1
	note __, 2
	octave 2
	endchannel
