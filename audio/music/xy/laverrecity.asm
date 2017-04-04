; Pokémon X/Y - Laverre City
; Demixed by Mmmmmm
; https://pastebin.com/pVtgJivC
; https://hax.iimarckus.org/topic/6777/

Music_LaverreCityXY: ; ef2d0
	musicheader 4, 1, Music_LaverreCityXY_Ch1
	musicheader 1, 2, Music_LaverreCityXY_Ch2
	musicheader 1, 3, Music_LaverreCityXY_Ch3
	musicheader 1, 4, Music_LaverreCityXY_Ch4
; ef2d9

Music_LaverreCityXY_Ch1: ; ef2d9
	tempo 120
	volume $77
	stereopanning $f
	vibrato $12, $25
Music_LaverreCityXY_branch_ef2e5: ; ef2e5
	dutycycle $0
	notetype $c, $A4
	note __, 4
	octave 3
	notetype $6, $A7
	note B_, 8
	octave 4
	note E_, 8
	note D_, 16
	note E_, 8
	note E_, 1
	note F#, 15
	note D_, 8
	note D_, 1
	note E_, 15
	octave 3
	note B_, 8
	octave 4
	note C#, 1
	intensity $A0
	note D_, 7
	intensity $A7
	note D_, 16
	note C#, 8
	octave 3
	note B_, 8
	note A_, 8
	note A_, 1
	intensity $A0
	note B_, 7
	intensity $A7
	note B_, 16
	notetype $c, $A7
	note __, 12
	dutycycle $3
	notetype $c, $C4
	note __, 4
	octave 3
	notetype $6, $C7
	note B_, 8
	octave 4
	note E_, 8
	note D_, 16
	note E_, 8
	note F#, 16
	note D_, 8
	note E_, 16
	octave 3
	note B_, 8
	octave 4
	intensity $C0
	note D_, 8
	intensity $C7
	note D_, 16
	note C#, 8
	octave 3
	note B_, 8
	note A_, 8
	intensity $C0
	note B_, 8
	intensity $C7
	note B_, 16
	notetype $c, $67
	note B_, 12
Music_LaverreCityXY_Ch1_branch_1:
	intensity $80
	note F#, 12
	intensity $87
	note F#, 12
	intensity $80
	note G_, 12
	intensity $87
	note G_, 12
	intensity $80
	note F#, 12
	intensity $87
	note F#, 12
	intensity $80
	note A#, 12
	note G#, 12
	note F#, 12
	intensity $87
	note F#, 12
	intensity $80
	note G_, 12
	intensity $87
	note G_, 12
	intensity $80
	note F#, 12
	intensity $87
	note F#, 12
	intensity $80
	note F#, 12
	notetype $8, $87
	dutycycle 1
	note B_, 2
	note A#, 2
	note G#, 2
	intensity $A7
	note C#, 2
	note D#, 2
	note F_, 2
	intensity $C7
	note G_, 2
	note G#, 2
	note A#, 2
	notetype $c, $C7
	note B_, 4
	note A#, 4
	note B_, 4
	octave 4
	note C#, 8
	octave 3
	note B_, 4
	note A#, 8
	octave 4
	note C#, 4
	octave 3
	note F#, 12
	note G#, 4
	note A#, 4
	note B_, 4
	note E_, 8
	note G#, 4
	note G_, 4
	note F_, 4
	note G_, 4
	note G#, 12
	note B_, 4
	note A#, 4
	note B_, 4
	octave 4
	note C#, 8
	octave 3
	note B_, 4
	note A#, 4
	note B_, 4
	octave 4
	note C#, 4
	note D#, 12
	note E_, 4
	note D#, 4
	octave 3
	note B_, 4
	note B_, 8
	octave 4
	note D#, 4
	note C#, 4
	intensity $AF
	note C#, 8
	intensity $F0
	note C#, 1
	note __, 3
	intensity $A7
	octave 3
	note B_, 4
	note A#, 2
	note B_, 1
	note A#, 1
	intensity $A0
	note G#, 8
	intensity $A7
	note G#, 16
	note __, 16
	dutycycle 3
	intensity $C7
	note B_, 4
	note A#, 4
	note G#, 12
	note D#, 8
	note G#, 4
	note A#, 4
	note G#, 4
	note F#, 4
	note G#, 12
	loopchannel 0, Music_LaverreCityXY_branch_ef2e5

Music_LaverreCityXY_Ch2: ; ef3eb
	vibrato $12, $25
	dutycycle $2
	stereopanning $f0
	tone $0002
Music_LaverreCityXY_branch_ef3f2: ; ef3f2
	notetype $c, $A7
	octave 2
	note E_, 12
	octave 1
	note B_, 12
	octave 2
	note E_, 12
	octave 1
	note B_, 12
	octave 2
	note E_, 12
	octave 1
	note B_, 12
	octave 2
	note E_, 12
	octave 1
	note B_, 12
	note A_, 12
	octave 2
	note E_, 12
	octave 1
	note A_, 12
	octave 2
	note E_, 12
	note E_, 12
	octave 1
	note B_, 12
	octave 2
	note E_, 12
	octave 1
	note B_, 12
Music_LaverreCityXY_Ch2_branch_1:
	intensity $50
	note D#, 12
	intensity $57
	note D#, 12
	intensity $50
	note E_, 12
	intensity $57
	note E_, 12
	intensity $50
	note F#, 12
	intensity $57
	note F#, 12
	intensity $50
	note F#, 12
	note E_, 12
	note D#, 12
	intensity $57
	note D#, 12
	intensity $50
	note E_, 12
	intensity $57
	note E_, 12
	intensity $50
	note F#, 12
	intensity $57
	note F#, 12
	intensity $50
	note F#, 12
	note D#, 12
Music_LaverreCityXY_Ch2_branch_2:
	intensity $A7
	note G#, 8
	note G#, 2
	note __, 2
	note E_, 8
	note E_, 2
	note __, 2
	note F#, 8
	note F#, 2
	note __, 2
	note D#, 8
	note D#, 2
	note __, 2
	note E_, 8
	note E_, 2
	note __, 2
	note C#, 8
	note C#, 2
	note __, 2
	note D#, 8
	note D#, 2
	note __, 2
	note E_, 8
	note E_, 2
	note __, 2
	note G#, 8
	note G#, 2
	note __, 2
	note E_, 8
	note E_, 2
	note __, 2
	note F#, 8
	note F#, 2
	note __, 2
	note D#, 8
	note D#, 2
	note __, 2
	note E_, 8
	note E_, 2
	note __, 2
	note C#, 8
	note C#, 2
	note __, 2
	note F#, 4
	intensity $8F
	note F#, 7
	note __, 1
	intensity $D0
	note F#, 1
	note __, 11
	intensity $A7
	note G#, 8
	note G#, 2
	note __, 2
	note E_, 8
	note E_, 2
	note __, 2
	note F#, 8
	note F#, 2
	note __, 2
	note B_, 8
	note A#, 2
	note __, 2
	note G#, 8
	note G#, 2
	note __, 2
	note E_, 8
	note E_, 2
	note __, 2
	note F#, 8
	note F#, 2
	note __, 2
	note G#, 8
	note G#, 2
	note __, 2
	loopchannel 0, Music_LaverreCityXY_branch_ef3f2

Music_LaverreCityXY_Ch3: ; ef4e1
	stereopanning $ff
	vibrato $12, $25
Music_LaverreCityXY_branch_ef4e3: ; ef4e3
	notetype $c, $25
	octave 3
	note __, 4
	note E_, 2
	note F#, 2
	note G#, 2
	note __, 6
	note F#, 2
	note __, 2
	note A_, 2
	note __, 6
	note E_, 2
	note __, 2
	note G#, 2
	note __, 6
	note D_, 2
	note __, 2
	note F#, 2
	note __, 6
	note E_, 2
	note F#, 2
	note G#, 2
	note __, 6
	note E_, 2
	note __, 2
	note D_, 2
	note __, 6
	note E_, 2
	note __, 2
	note G#, 2
	note __, 2
	notetype $c, $13
	octave 5
	note A_, 1
	note __, 1
	note G#, 1
	note __, 1
	note A_, 1
	note __, 1
	note B_, 1
	note __, 1
	octave 6
	note C#, 1
	note __, 1
	note D_, 1
	note __, 1
	octave 5
	note B_, 10
	note __, 6
	notetype $c, $25
	octave 3
	note F#, 2
	note __, 2
	note A_, 2
	note __, 6
	note E_, 2
	note __, 2
	note G#, 2
	note __, 6
	note D_, 2
	note __, 2
	note F#, 2
	note __, 6
	note E_, 2
	note F#, 2
	note G#, 2
	note __, 6
	note E_, 2
	note __, 2
	note D_, 2
	note __, 6
	note E_, 2
	note __, 2
	note G#, 2
	note __, 6
	note E_, 2
	note __, 2
	note G#, 2
	note __, 2
Music_LaverreCityXY_Ch3_branch_1:
	notetype $c, $13
	octave 5
	note F#, 12
	note B_, 8
	note F#, 4
	note A_, 12
	note G_, 12
	note F#, 12
	note F#, 12
	notetype $c, $23
	note F#, 12
	note F#, 12
	notetype $c, $13
	note F#, 12
	note B_, 8
	note F#, 4
	note A_, 12
	note G_, 4
	note A_, 4
	note G_, 4
	note F#, 12
	note F#, 12
	note __, 12
	note __, 12
	notetype $c, $25
	note __, 4
	octave 3
	note G#, 2
	note F#, 2
	note G#, 2
	note __, 6
	note G#, 2
	note __, 2
	note F#, 2
	note __, 6
	note F#, 2
	note __, 2
	note D#, 2
	note __, 2
	notetype $c, $13
	octave 5
	note A#, 2
	note __, 2
	note G#, 2
	note __, 2
	note F#, 2
	note __, 2
;;;;;;;;;;;;mark
	note G#, 12
	note E_, 8
	note G#, 4
	note G_, 4
	note F_, 4
	note G_, 4
	note G#, 4
	octave 6
	note D#, 2
	note __, 2
	note C#, 2
	note __, 2
	octave 5
	note B_, 12
	notetype $c, $25
;;;;;;;;;;;;mark
	octave 3
	note __, 4
	note G#, 2
	note __, 2
	note F#, 2
	note __, 6
	note F#, 2
	note __, 2
	note A#, 2
	note __, 2
	notetype $c, $13
	octave 5
	note A#, 4
	note G#, 4
	note F#, 4
;;;;;;;;;;;;mark
	note B_, 4
	note A#, 4
	note G#, 4
	octave 6
	note D#, 4
	note C#, 4
	octave 5
	note B_, 4
	note A#, 4
	octave 4
	note F#, 1
	note G#, 1
	note A#, 1
	octave 5
	note C#, 1
	note D#, 1
	note F#, 1
	note G#, 1
	note A#, 1
	octave 6
	note C#, 2
	note __, 10
	note __, 4
	octave 5
	note G#, 1
	note __, 1
	note A#, 1
	note __, 1
	note B_, 1
	note __, 3
	octave 6
	note D#, 4
	note C#, 4
	octave 5
	note B_, 4
	note A#, 4
	note B_, 4
	octave 6
	note C#, 4
	octave 5
	note F#, 12
	note __, 4
	note G#, 1
	note __, 1
	note A#, 1
	note __, 1
	note B_, 1
	note __, 3
	octave 6
	note D#, 4
	note C#, 4
	octave 5
	note B_, 4
	note A#, 4
	note G#, 4
	note F#, 4
	note G#, 12
	loopchannel 0, Music_LaverreCityXY_branch_ef4e3

Music_LaverreCityXY_Ch4: ; f517a
	togglenoise $3
	stereopanning $f
	notetype $c
Music_LaverreCityXY_Ch4_loop:
	callchannel Music_LaverreCityXY_Ch4_branch_1
	callchannel Music_LaverreCityXY_Ch4_branch_1
	callchannel Music_LaverreCityXY_Ch4_branch_1
	callchannel Music_LaverreCityXY_Ch4_branch_1
	callchannel Music_LaverreCityXY_Ch4_branch_1
	callchannel Music_LaverreCityXY_Ch4_branch_1
	callchannel Music_LaverreCityXY_Ch4_branch_1
	callchannel Music_LaverreCityXY_Ch4_branch_1
	callchannel Music_LaverreCityXY_Ch4_branch_2
	callchannel Music_LaverreCityXY_Ch4_branch_2
	callchannel Music_LaverreCityXY_Ch4_branch_2
	callchannel Music_LaverreCityXY_Ch4_branch_2
	callchannel Music_LaverreCityXY_Ch4_branch_2
	callchannel Music_LaverreCityXY_Ch4_branch_2
	callchannel Music_LaverreCityXY_Ch4_branch_2
	callchannel Music_LaverreCityXY_Ch4_branch_2
	callchannel Music_LaverreCityXY_Ch4_branch_1
	callchannel Music_LaverreCityXY_Ch4_branch_1
	callchannel Music_LaverreCityXY_Ch4_branch_1
	callchannel Music_LaverreCityXY_Ch4_branch_1
	callchannel Music_LaverreCityXY_Ch4_branch_1
	callchannel Music_LaverreCityXY_Ch4_branch_1
	callchannel Music_LaverreCityXY_Ch4_branch_1
	notetype $8
	note C#, 1
	note C#, 1
	note C#, 1
	note __, 3
	note C#, 1
	note C#, 1
	note C#, 1
	note __, 3
	note C#, 1
	note C#, 1
	note C#, 1
	note __, 3
	notetype $c
	note C#, 12
	callchannel Music_LaverreCityXY_Ch4_branch_1
	callchannel Music_LaverreCityXY_Ch4_branch_1
	callchannel Music_LaverreCityXY_Ch4_branch_1
	callchannel Music_LaverreCityXY_Ch4_branch_1
	loopchannel 0, Music_LaverreCityXY_Ch4_loop

Music_LaverreCityXY_Ch4_branch_1:
	notetype $8
	note C#, 1
	note C#, 1
	note C#, 1
	note __, 3
	notetype $c
	note C#, 4
	note C#, 4
	note __, 4
	note C#, 4
	note C#, 4
	endchannel

Music_LaverreCityXY_Ch4_branch_2
	notetype $c
	note __, 12
	note __, 12
	endchannel
