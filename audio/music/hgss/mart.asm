; Pokémon HG/SS - Poké Mart
; Demixed by FroggestSpirit
; https://github.com/froggestspirit/CrystalComplete/blob/master/audio/music/custom/shop.asm

Music_MartHGSS:
	dbw $c0, Music_MartHGSS_Ch1
	dbw $01, Music_MartHGSS_Ch2
	dbw $02, Music_MartHGSS_Ch3
	dbw $03, Music_MartHGSS_Ch4

Music_MartHGSS_Ch1:
	tempo $90
	volume $77
	dutycycle 1
	notetype $C, $B2
	stereopanning $f
	octave 4
	note C#, 4
	note C#, 4
	note C_, 2
	note C_, 4
	octave 3
	note B_, 6
	note A#, 12
Music_MartHGSS_Loop1:
	note D#, 4
	octave 2
	note A#, 2
	octave 3
	note D#, 4
	octave 2
	note F#, 4
	octave 3
	note D#, 4
	octave 2
	note F#, 2
	note B_, 2
	note F#, 4
	octave 3
	note D#, 4
	octave 2
	note B_, 2
	note A_, 4
	note F#, 2
	octave 3
	note D#, 4
	octave 2
	note A_, 4
	octave 3
	note D#, 4
	octave 2
	note F#, 2
	note A_, 2
	note F#, 4
	octave 3
	note D#, 4
	octave 2
	note A_, 2
	note G#, 4
	note B_, 2
	note E_, 4
	note B_, 4
	note G#, 4
	note F_, 2
	octave 3
	note D_, 2
	octave 2
	note G#, 4
	octave 3
	note D_, 4
	note F_, 2
	note B_, 4
	note F#, 2
	note B_, 2
	note F#, 2
	intensity $B4
	note F_, 2
	note F#, 2
	note G#, 2
	note A#, 16
	dutycycle 2
	note A#, 4
	note B_, 2
	note D#, 4
	note F#, 4
	note D#, 1
	note F#, 1
	note B_, 2
	note F#, 2
	note B_, 2
	octave 4
	note C#, 4
	octave 3
	note B_, 2
	octave 4
	note C#, 2
	note D#, 2
	octave 3
	note A_, 4
	note B_, 2
	note D#, 4
	note F#, 4
	note D#, 1
	note F#, 1
	note A_, 2
	note D#, 2
	note F#, 2
	note B_, 4
	note A_, 4
	note F#, 1
	note A_, 1
	note B_, 4
	note B_, 2
	note E_, 4
	note B_, 4
	note E_, 4
	octave 2
	note F_, 2
	octave 3
	note D_, 2
	note F_, 4
	note D_, 4
	note G#, 2
	note B_, 4
	note F#, 2
	octave 4
	note C#, 1
	octave 3
	note B_, 1
	note F#, 2
	note F_, 2
	note F#, 2
	note G#, 2
	note A#, 8
	note E_, 2
	note C#, 2
	note F#, 2
	note E_, 2
	intensity $B1
	dutycycle 0
	note D#, 2
	octave 2
	note G_, 2
	note A#, 2
	note G_, 4
	note A#, 4
	octave 3
	note D#, 4
	octave 2
	note G_, 2
	note A#, 2
	note G_, 4
	octave 3
	note D#, 4
	octave 2
	note A#, 2
	octave 3
	note D#, 2
	octave 2
	note G#, 2
	note B_, 2
	note G#, 4
	octave 3
	note D#, 4
	octave 2
	note B_, 4
	note G#, 2
	note B_, 2
	note G#, 4
	octave 3
	note D#, 4
	octave 2
	note G#, 2
	intensity $B4
	dutycycle 1
	octave 3
	note G_, 2
	note D#, 2
	note G_, 2
	note D#, 2
	note A#, 2
	note A_, 2
	note A#, 2
	octave 4
	note D#, 2
	octave 3
	note D#, 2
	octave 2
	note A#, 2
	octave 4
	note D#, 1
	note D_, 1
	note D#, 2
	note F_, 1
	note E_, 1
	note F_, 2
	note G_, 1
	note F#, 1
	note G_, 2
	note C#, 2
	octave 3
	note G#, 2
	octave 4
	note D#, 2
	octave 3
	note B_, 4
	note D#, 4
	note C#, 4
	octave 4
	note C#, 2
	note D#, 2
	octave 3
	note B_, 4
	note D#, 4
	octave 2
	note G#, 2
	intensity $B2
	octave 3
	note D#, 2
	octave 2
	note B_, 2
	octave 3
	note D#, 2
	note G#, 4
	note B_, 4
	note D#, 2
	note D_, 2
	octave 2
	note B_, 2
	octave 3
	note D_, 2
	note G#, 4
	note F_, 4
	note D_, 2
	note C#, 2
	octave 2
	note F#, 2
	note A#, 2
	octave 3
	note C#, 2
	note F#, 2
	note B_, 2
	octave 4
	note C#, 2
	octave 3
	note B_, 2
	octave 4
	note C#, 2
	octave 3
	note B_, 4
	note A#, 10
	loopchannel 0, Music_MartHGSS_Loop1

Music_MartHGSS_Ch2:
	dutycycle 2
	notetype $C, $B1
	stereopanning $f
	octave 4
	note F#, 4
	note F#, 4
	note F#, 2
	note F#, 4
	note F#, 6
	intensity $C5
	note F#, 6
	dutycycle 1
	stereopanning $ff
	octave 3
	note F#, 2
	note G#, 2
	note A#, 2
Music_MartHGSS_Loop2:
	octave 4
	note C#, 3
	octave 3
	note F#, 1
	octave 4
	note D#, 2
	octave 3
	note B_, 8
	note B_, 1
	octave 4
	note C#, 1
	note D#, 2
	note D_, 2
	note D#, 2
	note E_, 6
	note D#, 1
	note E_, 1
	note F#, 2
	note C#, 3
	octave 3
	note F#, 1
	octave 4
	note D#, 2
	octave 3
	note B_, 8
	note B_, 1
	octave 4
	note C#, 1
	note D#, 2
	note D_, 2
	note D#, 2
	note G#, 6
	note E_, 1
	note D#, 1
	note C#, 2
	note D#, 3
	octave 3
	note G#, 1
	octave 4
	note E_, 2
	note C#, 12
	octave 3
	note G#, 6
	note A#, 4
	note B_, 4
	octave 4
	note D#, 6
	note E_, 1
	note D#, 1
	note C#, 2
	octave 3
	note B_, 2
	note A#, 2
	note B_, 2
	intensity $C2
	octave 4
	note C#, 8
	note B_, 2
	note F#, 2
	note E_, 2
	note D#, 2
	intensity $C5
	note C#, 3
	octave 3
	note F#, 1
	octave 4
	note D#, 2
	octave 3
	note B_, 8
	note B_, 1
	octave 4
	note C#, 1
	note D#, 6
	note E_, 4
	note D#, 2
	note E_, 2
	note F#, 2
	note C#, 3
	octave 3
	note F#, 1
	octave 4
	note D#, 2
	octave 3
	note B_, 8
	note B_, 1
	octave 4
	note C#, 1
	notetype 6, $C5
	note D#, 11
	note G_, 1
	note G#, 8
	note F#, 8
	octave 3
	note B_, 2
	octave 4
	note C#, 2
	note D#, 6
	octave 3
	note G#, 2
	octave 4
	note E_, 4
	note C#, 16
	note __, 8
	octave 3
	note G#, 4
	note G_, 4
	note G#, 4
	note A#, 4
	note G#, 4
	note A#, 4
	note B_, 3
	octave 4
	note D_, 1
	note D#, 12
	note E_, 2
	note D#, 2
	note C#, 4
	octave 3
	note B_, 4
	note A#, 4
	note B_, 4
	notetype $C, $C5
	octave 4
	note C#, 12
	dutycycle 2
	octave 3
	note B_, 2
	octave 4
	note C#, 2
	note D#, 4
	note D#, 4
	note D#, 2
	note D_, 2
	notetype 6, $C5
	note D#, 3
	note G#, 1
	note A#, 12
	note G_, 8
	note D#, 8
	note C#, 8
	note C#, 6
	note C#, 1
	note D_, 1
	note D#, 4
	octave 3
	note B_, 8
	note A#, 4
	note B_, 4
	octave 4
	note C#, 12
	note D#, 4
	note G#, 12
	octave 3
	note B_, 4
	octave 4
	note C#, 4
	note D#, 8
	note D#, 8
	note D#, 4
	note D_, 4
	note D#, 3
	note G#, 1
	note A#, 12
	note G_, 2
	note F#, 2
	note G_, 4
	note G#, 2
	note G_, 2
	note G#, 4
	note A#, 2
	note A_, 2
	note A#, 4
	note A#, 8
	note B_, 4
	note G#, 8
	note G_, 4
	note G#, 4
	note A#, 12
	note B_, 4
	note G#, 7
	dutycycle 0
	octave 5
	note C_, 1
	note C#, 4
	octave 4
	note B_, 4
	note A#, 4
	notetype $C, $C5
	note B_, 15
	notetype 6, $C5
	note G#, 1
	note A#, 1
	notetype $C, $C5
	note B_, 10
	note G#, 2
	note A#, 2
	note B_, 2
	note A#, 10
	note G#, 2
	note A#, 2
	note G#, 2
	note A#, 2
	note G#, 4
	note F#, 10
	dutycycle 1
	loopchannel 0, Music_MartHGSS_Loop2

Music_MartHGSS_Ch3:
	notetype $C, $14
	stereopanning $f0
	octave 4
	note D#, 1
	note __, 3
	note D#, 1
	note __, 3
	note D_, 1
	note __, 1
	note D_, 1
	note __, 3
	note C#, 1
	note __, 5
	octave 3
	note F#, 5
	note __, 7
Music_MartHGSS_Loop3:
	octave 2
	note B_, 4
	note __, 2
	note B_, 1
	note __, 1
	note F#, 4
	note __, 2
	note F#, 1
	note __, 1
	note B_, 4
	note __, 2
	note B_, 1
	note __, 1
	note F#, 4
	note __, 2
	note F#, 1
	note __, 1
	note B_, 4
	note __, 2
	note B_, 1
	note __, 1
	note F#, 4
	note __, 2
	note F#, 1
	note __, 1
	note B_, 4
	note __, 2
	note B_, 1
	note __, 1
	note F#, 4
	note __, 2
	note F#, 1
	note __, 1
	note E_, 4
	note __, 2
	note E_, 1
	note __, 1
	note B_, 4
	note __, 2
	note B_, 1
	note __, 1
	note F_, 4
	note __, 2
	note F_, 1
	note __, 1
	note B_, 4
	note __, 2
	note B_, 1
	note __, 1
	note F#, 4
	note __, 2
	note F#, 1
	note __, 1
	octave 3
	note F#, 4
	note __, 2
	note F#, 1
	note __, 1
	octave 2
	note F#, 2
	note __, 14
	callchannel Music_MartHGSS_Branch
	callchannel Music_MartHGSS_Branch
	callchannel Music_MartHGSS_Branch
	callchannel Music_MartHGSS_Branch
	note E_, 4
	intensity $24
	octave 6
	note G#, 1
	intensity $14
	octave 2
	note __, 1
	note E_, 1
	note __, 1
	note B_, 4
	intensity $24
	octave 5
	note G#, 1
	intensity $14
	octave 2
	note __, 1
	note B_, 1
	note __, 1
	note F_, 4
	intensity $24
	octave 6
	note G#, 1
	intensity $14
	octave 2
	note __, 1
	note F_, 1
	note __, 1
	note B_, 4
	intensity $24
	octave 5
	note G#, 1
	intensity $14
	octave 2
	note __, 1
	note B_, 1
	note __, 1
	note F#, 4
	intensity $24
	octave 6
	note F#, 1
	intensity $14
	octave 2
	note __, 1
	note F#, 1
	note __, 1
	octave 3
	note F#, 4
	intensity $24
	octave 5
	note F#, 1
	intensity $14
	octave 2
	note __, 1
	octave 3
	note F#, 1
	octave 2
	note __, 1
	note F#, 2
	note __, 6
	octave 3
	note C#, 4
	octave 2
	note F#, 4
	note D#, 4
	note __, 2
	note D#, 1
	note __, 1
	note G_, 4
	note __, 2
	note G_, 1
	note __, 1
	note A#, 4
	note __, 2
	note A#, 1
	note __, 1
	note D#, 4
	note G_, 4
	note G#, 4
	note __, 2
	note G#, 1
	note __, 1
	note G_, 4
	note __, 2
	note G_, 1
	note __, 1
	note F#, 4
	note __, 2
	note F#, 1
	note __, 1
	note F_, 4
	note E_, 4
	note D#, 4
	octave 4
	note A#, 1
	octave 2
	note __, 1
	note D#, 1
	note __, 1
	note G_, 4
	octave 4
	note G_, 1
	octave 2
	note __, 1
	note G_, 1
	note __, 1
	note A#, 4
	octave 4
	note A#, 1
	octave 2
	note __, 1
	note A#, 1
	note __, 1
	note D#, 4
	note G_, 4
	note G#, 4
	intensity $24
	octave 6
	note D#, 1
	intensity $14
	octave 2
	note __, 1
	note G#, 1
	note __, 1
	note G_, 4
	intensity $24
	octave 6
	note D#, 1
	intensity $14
	octave 2
	note __, 1
	note G_, 1
	note __, 1
	note F#, 4
	intensity $24
	octave 6
	note D#, 1
	intensity $14
	octave 2
	note __, 1
	note F#, 1
	note __, 1
	note F_, 4
	intensity $24
	octave 6
	note D#, 1
	intensity $14
	octave 2
	note __, 1
	note F_, 1
	note __, 1
	note E_, 4
	intensity $24
	octave 6
	note G#, 1
	intensity $14
	octave 2
	note __, 1
	note E_, 1
	note __, 1
	octave 1
	note B_, 4
	intensity $24
	octave 5
	note G#, 1
	intensity $14
	octave 1
	note __, 1
	note B_, 1
	note __, 1
	octave 2
	note F_, 4
	intensity $24
	octave 6
	note G#, 1
	intensity $14
	octave 2
	note __, 1
	note F_, 1
	note __, 1
	octave 1
	note B_, 4
	intensity $24
	octave 6
	note D_, 1
	intensity $14
	octave 1
	note __, 1
	note B_, 1
	note __, 1
	octave 2
	note F#, 4
	intensity $24
	octave 6
	note F#, 1
	intensity $14
	octave 2
	note __, 1
	note F#, 1
	note __, 1
	octave 3
	note C#, 4
	intensity $24
	octave 5
	note F#, 1
	intensity $14
	octave 3
	note __, 1
	note C#, 1
	note __, 1
	octave 2
	note F#, 1
	note __, 1
	note F#, 1
	note __, 3
	note F#, 3
	note __, 1
	note F#, 1
	note __, 1
	note G#, 1
	note __, 1
	note A#, 1
	note __, 1
	loopchannel 0, Music_MartHGSS_Loop3
Music_MartHGSS_Branch:
	note B_, 4
	intensity $24
	octave 6
	note F#, 1
	intensity $14
	octave 2
	note __, 1
	note B_, 1
	note __, 1
	note F#, 4
	intensity $24
	octave 5
	note F#, 1
	intensity $14
	octave 2
	note __, 1
	note F#, 1
	note __, 1
	endchannel

Music_MartHGSS_Ch4:
	notetype $C
	togglenoise 0
	stereopanning $f0
	note G_, 4
	note G_, 4
	note G_, 2
	note G_, 4
	note G_, 6
	note A#, 12
Music_MartHGSS_Loop4:
	note A#, 4
	note G_, 2
	note D_, 2
	note D_, 2
	note G_, 2
	note D_, 2
	note D_, 2
	note G_, 2
	note D_, 2
	note D_, 2
	note G_, 2
	note D_, 2
	note D_, 2
	note G_, 2
	note D_, 2
	note G_, 2
	note D_, 2
	note G_, 2
	note D_, 2
	note D_, 2
	note G_, 2
	note D_, 2
	note D_, 2
	note G_, 2
	note D_, 2
	note D_, 2
	note G_, 2
	note D_, 2
	note D_, 2
	note G_, 2
	note D_, 2
	note G_, 2
	note D_, 2
	note G_, 2
	note D_, 2
	note D_, 2
	note G_, 2
	note D_, 2
	note D_, 2
	note G_, 2
	note D_, 2
	note D_, 2
	note G_, 2
	note D_, 2
	note D_, 2
	note G_, 2
	note D_, 2
	note G_, 2
	note D_, 2
	note G_, 2
	note D_, 2
	note D_, 2
	note G_, 2
	note D_, 2
	note D_, 2
	note G_, 16
	note G_, 2
	note D_, 2
	note G_, 2
	note D_, 2
	note D_, 2
	note G_, 2
	note D_, 2
	note D_, 2
	note G_, 2
	note D_, 2
	note D_, 2
	note G_, 2
	note D_, 2
	note D_, 2
	note G_, 2
	note D_, 2
	note G_, 2
	note D_, 2
	note G_, 2
	note D_, 2
	note D_, 2
	note G_, 2
	note D_, 2
	note D_, 2
	note G_, 2
	note D_, 2
	note D_, 2
	note G_, 2
	note D_, 2
	note D_, 2
	note G_, 2
	note D_, 2
	note G_, 2
	note D_, 2
	note G_, 2
	note D_, 2
	note D_, 2
	note G_, 2
	note D_, 2
	note D_, 2
	note G_, 2
	note D_, 2
	note D_, 2
	note G_, 2
	note D_, 2
	note D_, 2
	note G_, 2
	note D_, 2
	note G_, 2
	note D_, 2
	note G_, 2
	note D_, 2
	note D_, 2
	note G_, 2
	note D_, 2
	note D_, 2
	note G_, 16
	note A#, 4
	note G_, 2
	note D_, 2
	note A#, 4
	note G_, 2
	note D_, 2
	note A#, 4
	note G_, 2
	note D_, 2
	note A#, 4
	note G_, 2
	note D_, 2
	note A#, 4
	note G_, 2
	note D_, 2
	note A#, 4
	note G_, 2
	note D_, 2
	note A#, 4
	note G_, 2
	note D_, 2
	note A#, 4
	note G_, 2
	note D_, 2
	note A#, 4
	note G_, 2
	note D_, 2
	note A#, 4
	note G_, 2
	note D_, 2
	note A#, 4
	note G_, 2
	note D_, 2
	note A#, 4
	note G_, 2
	note D_, 2
	note A#, 4
	note G_, 2
	note D_, 2
	note A#, 4
	note G_, 2
	note D_, 2
	note A#, 4
	note G_, 2
	note D_, 2
	note A#, 4
	note G_, 2
	note D_, 2
	note A#, 4
	note G_, 2
	note D_, 2
	note A#, 4
	note G_, 2
	note D_, 2
	note A#, 4
	note G_, 2
	note D_, 2
	note A#, 4
	note G_, 2
	note D_, 2
	note A#, 4
	note G_, 2
	note D_, 2
	note A#, 4
	note G_, 2
	note D_, 2
	note G_, 2
	note A#, 4
	note A#, 4
	note D_, 2
	note G_, 2
	note G_, 2
	loopchannel 0, Music_MartHGSS_Loop4
