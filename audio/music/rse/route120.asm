; Pokémon R/S/E - Route 120
; Demixed by Pum
; https://hax.iimarck.us/topic/6443/

Music_Route120RSE:
	dbw $c0, Music_Route120RSE_Ch1
	dbw $01, Music_Route120RSE_Ch2
	dbw $02, Music_Route120RSE_Ch3
	dbw $03, Music_Route120RSE_Ch4

Music_Route120RSE_Ch1:
	tempo $4A
	volume $55
	dutycycle 1
	notetype $C, $F7
Music_Route120RSE_Loop1:
	note __, 8
	octave 4
	note E_, 8
	note D_, 8
	note C#, 8
	octave 3
	note B_, 8
	octave 4
	note C#, 8
	octave 3
	note B_, 8
	note A_, 8
	note G_, 13
	note __, 3
	note B_, 4
	note __, 1
	octave 4
	note C#, 4
	note __, 2
	note D_, 4
	note __, 1
	octave 3
	note B_, 12
	note A_, 12
	note G_, 8
	notetype $C, $F8
	note A_, 12
	notetype $C, $F7
	note A_, 12
	note __, 8
	note F_, 4
	note __, 1
	note G_, 4
	note __, 2
	note A_, 4
	note __, 1
	octave 4
	note C_, 4
	note __, 1
	octave 3
	note B_, 4
	note __, 2
	note A_, 4
	note __, 1
	note B_, 13
	note __, 3
	note B_, 4
	note __, 1
	octave 4
	note C#, 4
	note __, 2
	octave 3
	note A_, 4
	note __, 1
	notetype $C, $F8
	note B_, 16
	notetype $C, $F7
	note B_, 16
	note __, 8
	octave 4
	note E_, 8
	note D_, 8
	note C#, 8
	octave 3
	note B_, 8
	octave 4
	note C#, 8
	note D_, 8
	note E_, 8
	octave 3
	note B_, 8
	octave 4
	note G_, 2
	note __, 1
	note G_, 2
	note __, 1
	note G_, 2
	octave 5
	note D_, 4
	note __, 1
	note C#, 4
	note __, 2
	octave 4
	note A_, 4
	note __, 1
	notetype $C, $F8
	note B_, 16
	notetype $C, $F7
	note B_, 16
	note __, 8
	note F_, 8
	note G_, 8
	note F_, 8
	note E_, 7
	note __, 1
	note D_, 7
	note __, 1
	note C_, 7
	note __, 1
	note F_, 7
	note __, 1
	note E_, 8
	note A_, 2
	note __, 1
	note A_, 2
	note __, 1
	note A_, 2
	note B_, 4
	note __, 1
	note A_, 4
	note __, 2
	note F#, 4
	note __, 1
	notetype $C, $F8
	note G#, 16
	notetype $C, $F7
	note G#, 16
	octave 3
	note A_, 8
	note __, 2
	octave 4
	note C#, 3
	note E_, 3
	note A_, 4
	note __, 1
	note G#, 4
	note __, 2
	note A_, 4
	note __, 1
	notetype $C, $F8
	note E_, 16
	notetype $C, $F7
	note E_, 15
	note __, 1
	note E_, 8
	note __, 3
	note E_, 2
	note F#, 3
	note G_, 4
	note __, 1
	note A_, 4
	note __, 2
	note C#, 5
	notetype $C, $F8
	note D_, 16
	notetype $C, $F7
	note D_, 16
	note F_, 8
	note __, 3
	note D_, 2
	note E_, 3
	note F_, 4
	note __, 1
	note G_, 4
	note __, 2
	note F_, 5
	note A_, 8
	note __, 3
	note G#, 2
	note A_, 3
	notetype $C, $F8
	note E_, 8
	notetype $C, $F7
	note E_, 8
	note F#, 8
	note __, 3
	note G#, 2
	note A_, 3
	octave 5
	note D_, 4
	note __, 1
	note C#, 4
	note __, 2
	octave 4
	note B_, 5
	octave 5
	note E_, 4
	note __, 1
	note D_, 4
	note __, 2
	note C#, 2
	octave 4
	note A_, 3
	notetype $C, $F8
	note B_, 8
	notetype $C, $F7
	note B_, 8
	octave 3
	note A_, 8
	note __, 2
	octave 4
	note C#, 3
	note E_, 3
	note A_, 4
	note __, 1
	note G#, 4
	note __, 2
	note A_, 5
	notetype $C, $F8
	note E_, 16
	notetype $C, $F7
	note E_, 15
	note __, 1
	note E_, 8
	note __, 3
	note E_, 2
	note F#, 3
	note G_, 4
	note __, 1
	note A_, 4
	note __, 2
	note G_, 5
	notetype $C, $F8
	note F#, 16
	notetype $C, $F7
	note F#, 16
	note F_, 8
	note __, 3
	note F_, 2
	note G_, 3
	note A_, 4
	note __, 1
	note B_, 4
	note __, 2
	note A_, 5
	octave 5
	note C#, 8
	note __, 3
	note D_, 2
	note C#, 3
	octave 4
	notetype $C, $F8
	note A_, 8
	notetype $C, $F7
	note A_, 8
	note B_, 8
	note __, 3
	note F#, 2
	note G#, 3
	note A_, 4
	note __, 1
	note B_, 4
	note __, 2
	note A_, 5
	note B_, 8
	note __, 3
	note B_, 2
	octave 5
	note C#, 3
	note D_, 16
	loopchannel 0, Music_Route120RSE_Loop1

Music_Route120RSE_Ch2:
Music_Route120RSE_Loop2:
	dutycycle 2
	notetype $C, $B7
	; ?
	db $ef
	db $f0
	note __, 16
	note __, 16
	note __, 16
	note __, 16
	octave 3
	note G_, 4
	note __, 1
	note A_, 4
	note __, 2
	note B_, 4
	note __, 1
	octave 4
	notetype $C, $B8
	note D_, 16
	notetype $C, $B7
	note D_, 16
	note __, 16
	note __, 16
	octave 3
	note A_, 4
	note __, 1
	note B_, 4
	note __, 2
	note A_, 4
	note __, 1
	octave 4
	notetype $C, $B8
	note C_, 16
	notetype $C, $B7
	note C_, 16
	note __, 16
	note G#, 4
	note __, 1
	note A_, 4
	note __, 2
	note F#, 4
	note __, 1
	notetype $C, $B8
	note G#, 16
	notetype $C, $B7
	note G#, 16
	note __, 16
	note __, 3
	octave 2
	note A_, 2
	note __, 6
	note A_, 2
	note __, 1
	note A_, 1
	note __, 1
	notetype $C, $B8
	note A_, 16
	notetype $C, $B7
	note A_, 16
	note G_, 8
	octave 3
	note D_, 8
	note C#, 8
	octave 2
	note B_, 8
	note G_, 8
	note A_, 8
	note B_, 8
	octave 3
	note D_, 8
	notetype $C, $B8
	note C_, 16
	notetype $C, $B7
	note C_, 16
	octave 2
	notetype $C, $B8
	note A_, 16
	notetype $C, $B7
	note A_, 16
	note E_, 8
	note A_, 8
	note B_, 8
	note A_, 8
	note G#, 4
	note __, 1
	note B_, 4
	note __, 1
	octave 3
	note F#, 4
	note __, 2
	notetype $C, $B8
	note G#, 8
	notetype $C, $B7
	note G#, 8
	note __, 16
	note __, 8
	note A_, 8
	notetype $C, $B8
	note G#, 8
	notetype $C, $B7
	note G#, 8
	note A_, 5
	note G#, 6
	note A_, 5
	notetype $C, $B8
	note G_, 12
	notetype $C, $B7
	note G_, 12
	note E_, 8
	note A_, 4
	note __, 1
	note B_, 4
	note __, 2
	octave 4
	note C#, 4
	note __, 1
	octave 3
	note A_, 15
	note __, 1
	note A_, 11
	note F_, 2
	note G_, 3
	note A_, 4
	note __, 1
	note B_, 4
	note __, 2
	note A_, 4
	note __, 1
	octave 4
	note C#, 11
	octave 3
	note B_, 2
	octave 4
	note C#, 3
	octave 3
	notetype $C, $B8
	note A_, 8
	notetype $C, $B7
	note A_, 8
	note D_, 15
	note __, 1
	note D_, 4
	note __, 1
	note E_, 4
	note __, 2
	note D_, 4
	note __, 1
	note E_, 11
	note D_, 2
	note C#, 3
	octave 2
	note B_, 3
	octave 3
	note C#, 2
	note D_, 3
	note E_, 3
	note F#, 2
	note G#, 3
	note A_, 10
	note __, 1
	note A_, 2
	note B_, 3
	octave 4
	note C#, 4
	note __, 1
	octave 3
	note B_, 4
	note __, 2
	octave 4
	note C#, 4
	note __, 1
	octave 3
	note G#, 4
	note __, 1
	note A_, 4
	note __, 2
	note B_, 4
	note __, 1
	notetype $C, $B8
	note G#, 8
	notetype $C, $B7
	note G#, 8
	note E_, 3
	note __, 13
	note B_, 4
	note __, 1
	octave 4
	note C#, 4
	note __, 2
	octave 3
	note B_, 4
	note __, 1
	octave 4
	note D_, 4
	note __, 1
	note C#, 4
	note __, 2
	octave 3
	note A_, 4
	note __, 1
	notetype $C, $B8
	note D_, 8
	notetype $C, $B7
	note D_, 8
	note __, 16
	note F_, 4
	note __, 1
	note G_, 4
	note __, 2
	note F_, 4
	note __, 1
	note A_, 10
	note __, 1
	note A_, 2
	note G#, 3
	notetype $C, $B8
	note E_, 8
	notetype $C, $B7
	note E_, 7
	note __, 1
	note E_, 11
	note D_, 2
	note E_, 3
	note F#, 4
	note __, 1
	note G#, 4
	note __, 2
	note F#, 4
	note __, 1
	note G#, 10
	note __, 1
	note G#, 2
	note A_, 3
	notetype $C, $B8
	note B_, 8
	notetype $C, $B7
	note B_, 8
	loopchannel 0, Music_Route120RSE_Loop2

Music_Route120RSE_Ch3:
Music_Route120RSE_Loop3:
	notetype $C, $15
	intensity $22
	octave 4
	note C#, 16
	note C#, 14
	note __, 2
	note C#, 16
	note C#, 8
	octave 3
	note A_, 8
	note B_, 4
	note __, 1
	note A_, 4
	note __, 2
	note G_, 4
	note __, 1
	note B_, 10
	note __, 1
	note B_, 2
	note __, 1
	note B_, 2
	note G_, 12
	note A_, 12
	note B_, 8
	note A_, 16
	note A_, 15
	note __, 1
	note A_, 16
	octave 4
	note C_, 5
	octave 3
	note B_, 6
	note A_, 4
	note __, 1
	note A_, 15
	note __, 1
	note A_, 4
	note __, 1
	note A_, 5
	note __, 1
	note A_, 5
	note G#, 16
	note G#, 16
	note A_, 3
	octave 4
	note C#, 2
	note E_, 3
	note A_, 3
	octave 5
	note C#, 2
	note E_, 3
	note A_, 3
	note E_, 2
	note C#, 3
	note E_, 3
	note C#, 2
	octave 4
	note A_, 3
	octave 5
	note C#, 3
	octave 4
	note A_, 2
	note E_, 3
	note A_, 3
	note E_, 2
	note C#, 3
	octave 3
	note A_, 3
	octave 4
	note C#, 2
	note E_, 3
	note A_, 3
	note E_, 2
	note C#, 3
	octave 3
	note G_, 3
	note B_, 2
	octave 4
	note D_, 3
	note G_, 3
	note B_, 2
	octave 5
	note D_, 3
	note G_, 3
	note D_, 2
	octave 4
	note B_, 3
	octave 5
	note D_, 3
	octave 4
	note B_, 2
	note G_, 3
	note B_, 3
	note G_, 2
	note D_, 3
	note G_, 3
	note D_, 2
	octave 3
	note B_, 3
	note G_, 3
	note B_, 2
	octave 4
	note D_, 3
	note G_, 3
	note D_, 2
	octave 3
	note B_, 3
	note F_, 3
	note A_, 2
	octave 4
	note C_, 3
	note F_, 3
	note A_, 2
	octave 5
	note C_, 3
	note F_, 3
	note C_, 2
	octave 4
	note A_, 3
	octave 5
	note C_, 3
	octave 4
	note A_, 2
	note F_, 3
	note A_, 3
	note F_, 2
	note C_, 3
	note F_, 3
	note C_, 2
	octave 3
	note A_, 3
	note F_, 3
	note A_, 2
	octave 4
	note C_, 3
	note F_, 3
	note C_, 2
	octave 3
	note A_, 3
	octave 4
	note E_, 3
	note A_, 2
	note B_, 3
	octave 5
	note C#, 3
	note D_, 2
	note E_, 3
	note B_, 3
	note A_, 2
	note E_, 3
	note D_, 3
	octave 4
	note B_, 2
	note A_, 3
	note G#, 3
	note E_, 2
	octave 3
	note B_, 3
	octave 4
	note E_, 3
	octave 3
	note B_, 2
	note G#, 3
	note E_, 5
	note G#, 5
	note B_, 6
	octave 4
	note C#, 12
	note __, 1
	note C#, 2
	note __, 1
	note C#, 8
	note E_, 3
	note D_, 2
	note E_, 3
	note C#, 12
	note __, 1
	note C#, 2
	note __, 1
	note C#, 5
	note __, 3
	octave 5
	note A_, 3
	octave 6
	note C#, 2
	note E_, 3
	octave 4
	note C#, 12
	note __, 1
	note C#, 2
	note __, 1
	note C#, 7
	note __, 1
	note C#, 3
	octave 3
	note B_, 2
	octave 4
	note C#, 3
	octave 3
	note A_, 4
	note __, 1
	note B_, 4
	note __, 2
	octave 4
	note C#, 2
	octave 3
	note F#, 3
	note A_, 8
	octave 5
	note F#, 3
	note A_, 2
	octave 6
	note D_, 3
	octave 3
	note A_, 12
	note __, 1
	note A_, 2
	note __, 1
	note A_, 5
	note __, 3
	octave 4
	note D_, 3
	note C#, 2
	note D_, 3
	octave 3
	note A_, 12
	note __, 1
	note A_, 2
	note __, 1
	note A_, 8
	octave 5
	note E_, 3
	note A_, 2
	octave 6
	note C#, 3
	octave 4
	note F#, 11
	note E_, 2
	note F#, 2
	note __, 1
	note F#, 4
	note __, 1
	note G#, 4
	note __, 2
	note F#, 4
	note __, 1
	note G#, 10
	note __, 1
	note G#, 2
	note __, 1
	note G#, 1
	note __, 1
	note G#, 4
	note __, 1
	note A_, 4
	note __, 2
	note B_, 4
	note __, 1
	note A_, 13
	note C#, 2
	note __, 1
	note C#, 8
	note E_, 3
	note D_, 2
	note E_, 3
	note C#, 12
	note __, 1
	note C#, 2
	note __, 1
	note C#, 4
	note __, 1
	note E_, 4
	note __, 2
	note G#, 4
	note __, 1
	note C#, 12
	note __, 1
	note C#, 2
	note __, 1
	note C#, 7
	note __, 1
	note C#, 3
	octave 3
	note B_, 2
	octave 4
	note C#, 3
	octave 3
	note A_, 4
	note __, 1
	note B_, 4
	note __, 2
	octave 4
	note C#, 2
	note F#, 3
	note A_, 4
	note __, 1
	note F#, 4
	note __, 2
	note D_, 4
	note __, 1
	octave 3
	note A_, 12
	note __, 1
	note A_, 2
	note __, 1
	note A_, 8
	octave 4
	note D_, 3
	note C#, 2
	note D_, 3
	octave 3
	note A_, 10
	note __, 1
	note A_, 2
	note B_, 3
	octave 4
	note C#, 4
	note __, 1
	octave 3
	note A_, 4
	note __, 2
	note E_, 4
	note __, 1
	note A_, 10
	note __, 1
	note A_, 2
	note __, 1
	note A_, 1
	note __, 1
	note A_, 16
	note G#, 16
	octave 4
	note D_, 4
	note __, 1
	note C#, 4
	note __, 2
	octave 3
	note B_, 4
	note __, 1
	loopchannel 0, Music_Route120RSE_Loop3

Music_Route120RSE_Ch4:
	; pkmsSetDSpeed $C
	db $d8
	db $C
	; pkmsSetDrums 5
	db $e3
	db 5
Music_Route120RSE_Loop4:
	note C_, 8
	note C#, 3
	note C_, 2
	note C_, 3
	note C_, 5
	note C#, 1
	note C#, 1
	note C#, 1
	note D_, 3
	note C_, 2
	note C_, 3
	note C_, 8
	note C#, 3
	note C_, 2
	note C_, 3
	note C_, 3
	note C#, 2
	note C_, 3
	note C#, 3
	note C_, 2
	note C_, 3
	note C_, 8
	note C#, 3
	note C_, 2
	note C_, 3
	note C_, 5
	note C#, 1
	note C#, 1
	note C#, 1
	note D_, 3
	note C_, 2
	note C_, 3
	note C_, 8
	note C#, 3
	note C_, 2
	note C_, 3
	note C_, 3
	note C#, 2
	note C_, 3
	note C#, 3
	note C_, 2
	note C_, 3
	note C_, 8
	note C#, 3
	note C_, 2
	note C_, 3
	note C_, 5
	note C#, 1
	note C#, 1
	note C#, 1
	note D_, 3
	note C_, 2
	note C_, 3
	note C_, 8
	note C#, 3
	note C_, 2
	note C_, 3
	note C_, 3
	note C#, 2
	note C_, 3
	note C#, 3
	note C_, 2
	note C_, 3
	note C_, 8
	note C#, 3
	note C_, 2
	note C_, 3
	note C_, 5
	note C#, 1
	note C#, 1
	note C#, 1
	note D_, 3
	note C_, 2
	note C_, 3
	note C_, 8
	note C#, 3
	note C_, 2
	note C_, 3
	note C_, 3
	note C#, 2
	note C_, 3
	note C#, 3
	note C_, 2
	note C_, 3
	note C#, 8
	note C#, 3
	note C_, 2
	note C_, 3
	note C_, 5
	note C#, 1
	note C#, 1
	note C#, 1
	note D_, 3
	note C_, 2
	note C_, 3
	note C_, 8
	note C#, 3
	note C_, 2
	note C_, 3
	note C_, 3
	note C#, 2
	note C_, 3
	note C#, 3
	note C_, 2
	note C_, 3
	note C_, 8
	note C#, 3
	note C_, 2
	note C_, 3
	note C_, 5
	note C#, 1
	note C#, 1
	note C#, 1
	note D_, 3
	note C_, 2
	note C_, 3
	note C_, 8
	note C#, 3
	note C_, 2
	note C_, 3
	note C_, 3
	note C#, 2
	note C_, 3
	note C#, 3
	note C_, 2
	note C_, 3
	note C_, 8
	note C#, 3
	note C_, 2
	note C_, 3
	note C_, 5
	note C#, 1
	note C#, 1
	note C#, 1
	note D_, 3
	note C_, 2
	note C_, 3
	note C_, 8
	note C#, 3
	note C_, 2
	note C_, 3
	note C_, 3
	note C#, 2
	note C_, 3
	note C#, 3
	note C_, 2
	note C_, 1
	note C_, 1
	note C_, 1
	note C_, 3
	note C_, 2
	note C_, 3
	note C#, 3
	note C_, 2
	note C_, 3
	note C_, 5
	note C_, 1
	note C_, 1
	note C_, 1
	note C#, 3
	note C_, 2
	note C_, 1
	note C_, 1
	note C_, 1
	note C_, 3
	note C_, 2
	note C_, 3
	note C#, 3
	note C_, 2
	note C_, 3
	note C_, 3
	note C#, 2
	note C_, 3
	note C#, 3
	note C_, 2
	note C_, 3
	note C#, 5
	note C_, 1
	note C_, 1
	note C_, 1
	note C#, 5
	note C_, 1
	note C_, 1
	note C_, 1
	note C#, 3
	note C_, 2
	note C_, 3
	note C#, 3
	note C_, 2
	note C_, 3
	note C#, 5
	note C_, 1
	note C_, 1
	note C_, 1
	note C#, 5
	note C_, 1
	note C_, 1
	note C_, 1
	note C#, 3
	note C_, 2
	note C_, 3
	note C#, 3
	note C_, 2
	note C_, 3
	note C#, 5
	note C_, 1
	note C_, 1
	note C_, 1
	note C#, 5
	note C_, 1
	note C_, 1
	note C_, 1
	note C#, 3
	note C_, 2
	note C_, 3
	note C#, 3
	note C_, 2
	note C_, 3
	note C#, 5
	note C_, 1
	note C_, 1
	note C_, 1
	note C#, 5
	note C_, 1
	note C_, 1
	note C_, 1
	note C#, 3
	note C_, 2
	note C_, 3
	note C#, 3
	note C_, 2
	note C_, 3
	note C#, 5
	note C_, 1
	note C_, 1
	note C_, 1
	note C#, 5
	note C_, 1
	note C_, 1
	note C_, 1
	note C#, 3
	note C_, 2
	note C_, 3
	note C#, 3
	note C_, 2
	note C_, 3
	note C#, 5
	note C_, 1
	note C_, 1
	note C_, 1
	note C#, 5
	note C_, 1
	note C_, 1
	note C_, 1
	note C#, 3
	note C_, 2
	note C_, 3
	note C#, 3
	note C_, 2
	note C_, 3
	note C#, 5
	note C_, 1
	note C_, 1
	note C_, 1
	note C#, 5
	note C_, 1
	note C_, 1
	note C_, 1
	note C#, 3
	note C_, 2
	note C_, 3
	note C#, 3
	note C_, 2
	note C_, 3
	note C#, 16
	note C_, 1
	note C_, 1
	note C_, 1
	note C_, 1
	note C_, 1
	note C_, 1
	note C_, 1
	note C_, 1
	note C#, 1
	note C#, 1
	note C#, 1
	note C#, 1
	note C#, 1
	note C#, 1
	note C#, 1
	note C#, 1
	note C#, 5
	note C_, 1
	note C_, 1
	note C_, 1
	note C#, 5
	note C_, 1
	note C_, 1
	note C_, 1
	note C#, 3
	note C_, 2
	note C_, 3
	note C#, 3
	note C_, 2
	note C_, 3
	note C#, 4
	note C_, 1
	note C_, 1
	note C_, 1
	note C_, 1
	note C#, 4
	note C_, 1
	note C_, 1
	note C_, 1
	note C_, 1
	note C#, 5
	note C#, 6
	note C#, 2
	note C_, 3
	note C#, 5
	note C_, 1
	note C_, 1
	note C_, 1
	note C#, 5
	note C_, 1
	note C_, 1
	note C_, 1
	note C#, 3
	note C_, 2
	note C_, 3
	note C#, 2
	note C_, 3
	note C_, 3
	note C#, 4
	note C_, 1
	note C_, 1
	note C_, 1
	note C_, 1
	note C#, 4
	note C_, 1
	note C_, 1
	note C_, 1
	note C_, 1
	note C#, 5
	note C#, 6
	note C#, 2
	note C_, 3
	note C#, 5
	note C_, 1
	note C_, 1
	note C_, 1
	note C#, 5
	note C_, 1
	note C_, 1
	note C_, 1
	note C#, 3
	note C_, 2
	note C_, 3
	note C#, 5
	note C_, 1
	note C_, 1
	note C_, 1
	note C#, 5
	note C_, 1
	note C_, 1
	note C_, 1
	note C#, 3
	note C_, 2
	note C_, 3
	note C#, 5
	note C_, 1
	note C_, 1
	note C_, 1
	note C#, 3
	note C_, 2
	note C_, 3
	note C#, 16
	note C_, 3
	note C#, 3
	note C_, 2
	note C#, 3
	note C_, 3
	note C#, 2
	note C_, 16
	note C_, 3
	note C_, 2
	note C_, 3
	note C#, 3
	note C#, 3
	note C#, 2
	loopchannel 0, Music_Route120RSE_Loop4
