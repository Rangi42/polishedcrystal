; Pokémon HG/SS - Battle! Lugia
; Demixed by Pigu
; https://github.com/TwitchPlaysPokemon/tppcrystal251pub/blob/public/audio/music/custom/lugiabattle.asm
; https://pigu-a.bandcamp.com/album/pok-mon-anniversary-crystal-pigus-arranges

Music_LugiaBattleHGSS:
	dbw $80, Music_LugiaBattleHGSS_Ch1
	dbw $01, Music_LugiaBattleHGSS_Ch2
	dbw $02, Music_LugiaBattleHGSS_Ch3

Music_LugiaBattleHGSS_Ch1:
	tempo $66
	dutycycle $3
	notetype $c, $c7
	note __, 4
	octave 3
	note G#, 6
	note G_, 6
	note A#, 6
	note A_, 6
	octave 4
	note C_, 6
	octave 3
	note B_, 6
	octave 4
	note C#, 6
	intensity $4f
	note D_, 14
	intensity $c7
	note E_, 2
	note __, 6
	note E_, 2
	note __, 6
	note F#, 12
	octave 4
	note E_, 1
	note C#, 1
	octave 3
	note F#, 1
	note D#, 1
Music_LugiaBattleHGSS_Ch1_L:
	dutycycle $0
	intensity $c7
	octave 2
	note B_, 2
	note B_, 4
	intensity $c8
	note F#, 10
	intensity $c7
	note F#, 10
	note B_, 2
	note A#, 2
	octave 3
	note F#, 2
	intensity $c8
	note G_, 10
	intensity $c7
	note G_, 10
	note A_, 4
	note G_, 2
	note F_, 6
	intensity $c8
	note F#, 16
	intensity $c7
	note F#, 16
	note __, 16
	octave 2
	note B_, 4
	octave 3
	note G_, 2
	note G_, 2
	note G_, 2
	note A_, 6
	note __, 10
	octave 2
	note F#, 2
	note B_, 2
	note E_, 2
	note F#, 4
	note B_, 12
	dutycycle $2
	intensity $a6
	octave 3
	note E_, 6
	note G_, 6
	note C_, 6
	note E_, 6
	dutycycle $0
	intensity $c7
	note G_, 2
	note A#, 6
	octave 2
	note F#, 2
	octave 1
	note B_, 2
	octave 2
	note F#, 2
	note G_, 6
	note E_, 4
	note F#, 2
	octave 1
	note B_, 2
	octave 2
	note F#, 2
	note G_, 6
	note A_, 4
	note F#, 2
	octave 1
	note B_, 2
	octave 2
	note F#, 2
	note G_, 6
	note E_, 2
	note G_, 2
	note F#, 2
	octave 1
	note B_, 2
	octave 2
	note F#, 2
	note G_, 6
	octave 3
	note F_, 1
	note F#, 1
	note G_, 1
	note G#, 1
	intensity $c8
	note A_, 12
	intensity $c7
	note A_, 10
	note G_, 4
	note E_, 2
	note F_, 4
	intensity $c8
	note F#, 12
	intensity $c7
	note F#, 8
	note G_, 4
	octave 2
	note B_, 4
	octave 3
	note C_, 4
	intensity $c8
	note C#, 12
	intensity $c7
	note C#, 8
	note D_, 6
	note F#, 4
	note E_, 2
	intensity $c8
	octave 2
	note B_, 8
	note A_, 8
	intensity $c7
	note A_, 4
	octave 3
	note C_, 4
	octave 2
	note B_, 4
	note E_, 2
	note F_, 2
	intensity $c8
	note A_, 12
	intensity $c7
	note A_, 8
	note A#, 4
	octave 3
	note D_, 4
	note C_, 4
	intensity $c8
	note C#, 12
	intensity $c7
	note C#, 8
	note E_, 4
	octave 2
	note B_, 4
	octave 3
	note F#, 4
	intensity $c8
	note G_, 12
	intensity $c7
	note G_, 8
	note F_, 4
	octave 4
	note C_, 4
	note D#, 4
	notetype $8, $c7
	note A#, 6
	note A_, 2
	note G#, 2
	note G_, 2
	note F#, 6
	note F_, 2
	note E_, 2
	note D#, 2
	note D_, 6
	note C#, 2
	note C_, 2
	octave 3
	note B_, 2
	note A#, 6
	note A_, 2
	note G#, 2
	note G_, 2
	note __, 6
	intensity $c2
	note F#, 2
	note F#, 2
	note F#, 2
	note F_, 2
	note F_, 2
	note F_, 2
	note G#, 2
	note G#, 2
	note G#, 2
	note G_, 2
	note G_, 2
	note G_, 2
	note A#, 2
	note A#, 2
	note A#, 2
	note A_, 2
	note A_, 2
	note A_, 2
	octave 4
	note C_, 2
	note C_, 2
	note C_, 2
	note D_, 6
	octave 3
	note D#, 2
	note D#, 2
	note D#, 2
	note D_, 2
	note D_, 2
	note D_, 2
	note F_, 2
	note F_, 2
	note F_, 2
	note E_, 2
	note E_, 2
	note E_, 2
	note G_, 2
	note G_, 2
	note G_, 2
	note F#, 2
	note F#, 2
	note F#, 2
	note A_, 2
	note A_, 2
	note A_, 2
	notetype $c, $c7
	note A#, 2
	note __, 6
	note A#, 2
	note __, 10
	note A#, 4
	note __, 4
	notetype $8, $c2
	note A#, 2
	note A#, 2
	note A#, 2
	notetype $c, $c7
	octave 4
	note C_, 2
	note __, 6
	note C_, 2
	note __, 6
	dutycycle $3
	note F#, 12
	octave 4
	note E_, 1
	note C#, 1
	octave 3
	note F#, 1
	note D#, 1
	loopchannel 0, Music_LugiaBattleHGSS_Ch1_L

Music_LugiaBattleHGSS_Ch2:
	dutycycle $3
	notetype $c, $c7
	note __, 4
	octave 3
	note D#, 6
	note D_, 6
	note F_, 6
	note E_, 6
	note G_, 6
	note F#, 6
	note G#, 6
	intensity $4f
	note A_, 14
	intensity $c7
	note A#, 2
	note __, 6
	note A#, 2
	note __, 6
	octave 4
	note C#, 16
Music_LugiaBattleHGSS_Ch2_L:
	note __, 10
	dutycycle $0
	octave 3
	note G_, 2
	note F#, 2
	note A_, 2
	note B_, 4
	octave 4
	note D_, 12
	dutycycle $2
	intensity $a6
	octave 3
	note G_, 6
	note E_, 6
	note C_, 6
	note E_, 6
	note G_, 2
	octave 2
	note A#, 8
	dutycycle $3
	intensity $c7
	octave 4
	note F#, 1
	note A_, 1
	note B_, 2
	note A_, 1
	note G#, 1
	note A_, 2
	note F#, 1
	note F_, 1
	note E_, 2
	note D#, 1
	octave 3
	note B_, 1
	octave 4
	note D#, 4
	note D#, 1
	note E_, 1
	note D#, 1
	note E_, 1
	note F#, 2
	note F#, 6
	dutycycle $2
	intensity $a6
	octave 3
	note C_, 2
	octave 2
	note G_, 2
	octave 3
	note C_, 2
	note E_, 2
	note F#, 2
	note G_, 2
	note E_, 2
	note C_, 2
	octave 2
	note G_, 2
	octave 3
	note C_, 2
	note E_, 2
	octave 4
	note C_, 2
	octave 3
	note G_, 2
	note A#, 6
	dutycycle $3
	intensity $c7
	vibrato $5, $25
	octave 4
	note D#, 1
	note __, 1
	note D#, 2
	intensity $c8
	vibrato $0, $0
	octave 3
	note B_, 8
	intensity $c7
	vibrato $5, $25
	note B_, 12
	note __, 2
	note F#, 2
	note B_, 2
	octave 4
	note D#, 2
	intensity $c8
	vibrato $0, $0
	note E_, 8
	intensity $c7
	vibrato $5, $25
	note E_, 8
	note G_, 6
	note F#, 6
	note F_, 4
	intensity $c8
	vibrato $0, $0
	note F#, 12
	intensity $c7
	vibrato $5, $25
	note F#, 12
	note E_, 8
	note D#, 16
	note E_, 16
Music_LugiaBattleHGSS_Ch2_L1:
	octave 3
	note E_, 2
	note __, 2
	note E_, 2
	note __, 2
	note E_, 1
	note __, 1
	note E_, 2
	note __, 2
	note E_, 3
	note __, 1
	note E_, 2
	note __, 2
	note E_, 1
	note __, 1
	note E_, 2
	note __, 2
	note E_, 2
	note __, 2
	loopchannel 2, Music_LugiaBattleHGSS_Ch2_L1
Music_LugiaBattleHGSS_Ch2_L2:
	octave 2
	note B_, 2
	note __, 2
	note B_, 2
	note __, 2
	note B_, 1
	note __, 1
	note B_, 2
	note __, 2
	note B_, 3
	note __, 1
	note B_, 2
	note __, 2
	note B_, 1
	note __, 1
	note B_, 2
	note __, 2
	note B_, 2
	note __, 2
	loopchannel 2, Music_LugiaBattleHGSS_Ch2_L2
	octave 3
	note E_, 2
	note __, 2
	note E_, 2
	note __, 2
	note E_, 1
	note __, 1
	note E_, 2
	note __, 2
	note E_, 3
	note __, 1
	note E_, 2
	note __, 2
	note E_, 1
	note __, 1
	note E_, 2
	note __, 2
	note E_, 2
	note __, 2
	note G#, 2
	note __, 2
	note G#, 2
	note __, 2
	note G#, 1
	note __, 1
	note G#, 2
	note __, 2
	note G#, 3
	note __, 1
	note G#, 2
	note __, 2
	note G#, 1
	note __, 1
	note G#, 2
	note __, 2
	note G#, 2
	note __, 2
	note D_, 2
	note __, 2
	note D_, 2
	note __, 2
	note D_, 1
	note __, 1
	note D_, 2
	note __, 2
	note D_, 3
	note __, 1
	note D_, 2
	note __, 2
	note D_, 1
	note __, 1
	note A#, 2
	note __, 2
	note A#, 2
	note __, 2
	dutycycle $0
	notetype $8, $c7
	vibrato $0, $0
	octave 4
	note D_, 6
	note C#, 2
	note C_, 2
	octave 3
	note B_, 2
	note A#, 6
	note A_, 2
	note G#, 2
	note G_, 2
	note F#, 6
	note F_, 2
	note E_, 2
	note D#, 2
	note D_, 6
	note C#, 2
	note C_, 2
	octave 2
	note B_, 2
	notetype $c, $c7
	note __, 16
	note __, 16
	note __, 16
	note __, 12
	dutycycle $3
	octave 3
	note G_, 1
	note G#, 1
	note A#, 1
	octave 4
	note C_, 1
	note D_, 2
	note __, 6
	note D_, 2
	note __, 10
	note D_, 4
	note __, 4
	notetype $8, $c7
	note D_, 2
	note D_, 2
	note D_, 2
	notetype $c, $c7
	note E_, 2
	note __, 6
	note E_, 2
	note __, 6
	note C#, 16
	loopchannel 0, Music_LugiaBattleHGSS_Ch2_L

Music_LugiaBattleHGSS_Ch3:
	notetype $c, $23
	octave 6
	note G_, 1
	note G#, 1
	note A_, 1
	note A#, 1
	note G_, 1
	note G#, 1
	note A_, 1
	note A#, 1
	note G_, 1
	note G#, 1
	note A_, 1
	note A#, 1
	note G_, 1
	note G#, 1
	note A_, 1
	note A#, 1
	note G_, 1
	note G#, 1
	note A_, 1
	note A#, 1
	note G_, 1
	note G#, 1
	note A_, 1
	note A#, 1
	note G_, 1
	note G#, 1
	note A_, 1
	note A#, 1
	note G_, 1
	note G#, 1
	note A_, 1
	note A#, 1
	note G_, 1
	note G#, 1
	note A_, 1
	note A#, 1
	note G_, 1
	note G#, 1
	note A_, 1
	note A#, 1
	note G_, 1
	note G#, 1
	note A_, 1
	note A#, 1
	note G_, 1
	note G#, 1
	note A_, 1
	note A#, 2
	note __, 3
	note G_, 1
	note D_, 1
	octave 5
	note G_, 1
	note D_, 1
	octave 4
	note G_, 1
	note D_, 1
	octave 3
	note G_, 1
	note D_, 1
	intensity $16
	note E_, 2
	note __, 6
	note E_, 2
	note __, 6
	note C#, 14
	octave 2
	note F#, 2
Music_LugiaBattleHGSS_Ch3_L:
	octave 1
	note B_, 2
	octave 2
	note F#, 2
	octave 1
	note B_, 2
	octave 2
	note F#, 2
	octave 1
	note B_, 2
	octave 2
	note F#, 2
	octave 1
	note B_, 2
	octave 2
	note F#, 2
	octave 1
	note B_, 2
	octave 2
	note F#, 2
	octave 1
	note B_, 2
	octave 2
	note F#, 2
	octave 1
	note B_, 2
	octave 2
	note F#, 2
	octave 1
	note B_, 2
	octave 2
	note F#, 2
	note C_, 2
	note G_, 2
	note C_, 2
	note G_, 2
	note C_, 2
	note G_, 2
	note C_, 2
	note G_, 2
	note C_, 2
	note G_, 2
	note C_, 2
	note G_, 2
	note C_, 2
	note G_, 2
	note C_, 2
	note G_, 2
	loopchannel 3, Music_LugiaBattleHGSS_Ch3_L
Music_LugiaBattleHGSS_Ch3_L1:
	octave 1
	note B_, 2
	octave 2
	note F#, 2
	loopchannel 14, Music_LugiaBattleHGSS_Ch3_L1
	octave 1
	note A#, 2
	octave 2
	note F#, 2
	octave 1
	note A#, 2
	octave 2
	note F#, 2
Music_LugiaBattleHGSS_Ch3_L2:
	octave 1
	note A#, 2
	octave 2
	note E_, 2
	loopchannel 8, Music_LugiaBattleHGSS_Ch3_L2
Music_LugiaBattleHGSS_Ch3_L3:
	note C_, 2
	note F#, 2
	loopchannel 8, Music_LugiaBattleHGSS_Ch3_L3
Music_LugiaBattleHGSS_Ch3_L4:
	octave 1
	note G#, 2
	octave 2
	note C#, 2
	loopchannel 8, Music_LugiaBattleHGSS_Ch3_L4
Music_LugiaBattleHGSS_Ch3_L5:
	octave 1
	note A_, 2
	octave 2
	note D_, 2
	loopchannel 8, Music_LugiaBattleHGSS_Ch3_L5
Music_LugiaBattleHGSS_Ch3_L6:
	octave 1
	note A#, 2
	octave 2
	note E_, 2
	loopchannel 8, Music_LugiaBattleHGSS_Ch3_L6
Music_LugiaBattleHGSS_Ch3_L7:
	note C#, 2
	note G#, 2
	loopchannel 8, Music_LugiaBattleHGSS_Ch3_L7
Music_LugiaBattleHGSS_Ch3_L8:
	octave 1
	note A#, 2
	octave 2
	note G_, 2
	loopchannel 8, Music_LugiaBattleHGSS_Ch3_L8
	note A#, 4
	note __, 4
	note A#, 4
	note __, 4
	note A#, 3
	note __, 1
	note A#, 3
	note __, 1
	note A#, 3
	note __, 1
	note A#, 3
	note __, 1
	note A#, 16
	note F_, 4
	note A#, 8
	note F_, 4
	note G#, 16
	note D_, 4
	note G#, 8
	note D_, 4
	note G_, 2
	note __, 6
	note G_, 2
	note __, 6
	note D_, 4
	note G_, 2
	note __, 6
	notetype $8, $16
	note G_, 2
	note G_, 2
	note G_, 2
	notetype $c, $16
	note C_, 2
	note __, 6
	note C_, 2
	note __, 6
	octave 3
	note C#, 14
	octave 2
	note F#, 2
	loopchannel 0, Music_LugiaBattleHGSS_Ch3_L
