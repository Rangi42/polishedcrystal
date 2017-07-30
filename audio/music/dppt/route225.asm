; Pokémon D/P/Pt - Route 225
; Ported by FroggestSpirit
; https://github.com/froggestspirit/pokecrystal/blob/master/audio/music/077_Route225.asm

Music_Route225DPPt:
	musicheader 4, 1, Music_Route225DPPt_Ch1
	musicheader 1, 2, Music_Route225DPPt_Ch2
	musicheader 1, 3, Music_Route225DPPt_Ch3
	musicheader 1, 4, Music_Route225DPPt_Ch4

Music_Route225DPPt_Ch1:
	volume $77
	stereopanning $77
	tempo $88
Music_Route225DPPt_Ch1_loop:
	tone $0002
	notetype $E, $A7
	note __, 12
	dutycycle 1
	octave 2
	notetype $6, $A7
	note E_, 1
	note __, 1
	note E_, 1
	note __, 1
	note E_, 16
	note E_, 3
	note __, 1
	note E_, 1
	note __, 3
	note E_, 8
	note G_, 4
	octave 3
	note C_, 4
	note D_, 4
	dutycycle 2
	intensity $95
	octave 5
	note C_, 8
	note C_, 8
	note C_, 8
	dutycycle 1
	intensity $A7
	octave 1
	note G#, 2
	note __, 2
	note G#, 1
	note __, 3
	note G#, 1
	note __, 3
	note G_, 4
	note G#, 2
	note __, 2
	note G#, 4
	note A#, 7
	note __, 1
	note A#, 2
	note __, 2
	note A#, 1
	note __, 3
	note A#, 1
	note __, 3
	note A#, 4
	note B_, 2
	note __, 2
	note B_, 1
	note __, 3
	note B_, 1
	note __, 1
	octave 2
	note C_, 1
	note __, 1
	note E_, 16
	note E_, 2
	note __, 2
	note E_, 1
	note __, 3
	note E_, 8
	octave 3
	note E_, 4
	note F_, 4
	note F#, 4
	note G_, 8
	dutycycle 2
	intensity $95
	octave 5
	note C_, 8
	note C_, 8
	note C_, 12
	dutycycle 1
	intensity $A7
	octave 1
	note G_, 4
	note G#, 2
	note __, 2
	note G#, 4
	note A#, 7
	note __, 1
	note A#, 2
	note __, 2
	note A#, 1
	note __, 3
	note A#, 1
	note __, 3
	octave 2
	note C#, 4
	note D_, 2
	note __, 2
	note D_, 1
	note __, 3
	octave 1
	note G_, 1
	note __, 1
	note G_, 1
	note __, 1
	dutycycle 0
	intensity $A1
	octave 3
	note E_, 4
	intensity $71
	note E_, 4
	note E_, 4
	intensity $A1
	note E_, 4
	note E_, 4
	note E_, 4
	note E_, 4
	note E_, 4
	note E_, 4
	intensity $71
	note E_, 4
	note E_, 4
	intensity $A1
	note E_, 4
	note E_, 4
	note E_, 4
	note E_, 4
	note E_, 4
	note E_, 4
	intensity $71
	note E_, 4
	note E_, 4
	intensity $A1
	note E_, 4
	note E_, 4
	note E_, 4
	note E_, 4
	note E_, 4
	note E_, 4
	intensity $71
	note E_, 4
	note E_, 4
	intensity $A1
	note E_, 4
	note E_, 4
	note E_, 4
	note E_, 4
	note E_, 4
	note F_, 4
	intensity $71
	note F_, 4
	note F_, 4
	intensity $A1
	note F_, 4
	note F_, 4
	note F_, 4
	note F_, 4
	note F_, 4
	note F_, 4
	intensity $71
	note F_, 4
	note F_, 4
	intensity $A1
	note F_, 4
	note F_, 4
	note F_, 4
	note F_, 4
	note F_, 4
	note E_, 4
	intensity $71
	note E_, 4
	note E_, 4
	intensity $A1
	note E_, 4
	note E_, 4
	note E_, 4
	note E_, 4
	note E_, 4
	note D_, 4
	intensity $71
	note D_, 4
	note D_, 4
	dutycycle 1
	intensity $A7
	vibrato $02, $12
	octave 4
	note B_, 12
	octave 2
	note G#, 8
	octave 4
	note D#, 2
	note E_, 1
	note __, 1
	note E_, 2
	note __, 6
	note D#, 1
	note E_, 7
	note D_, 3
	note __, 5
	note D_, 8
	note C_, 2
	note __, 2
	note C_, 4
	notetype $F, $A7
	note __, 8
	notetype $C, $A7
	note D#, 1
	notetype $6, $A7
	note E_, 1
	note __, 1
	note E_, 2
	note __, 6
	note D#, 1
	note E_, 7
	note F_, 3
	note __, 5
	note D_, 8
	note E_, 2
	note D_, 2
	note C_, 4
	notetype $F, $A7
	note __, 8
	notetype $C, $A7
	note G#, 1
	notetype $6, $A7
	note A_, 1
	note __, 1
	note A_, 2
	note __, 6
	note G#, 1
	note A_, 7
	note G_, 3
	note __, 5
	note F#, 1
	note G_, 7
	note F_, 2
	note __, 2
	note F_, 4
	notetype $F, $A7
	note __, 8
	notetype $C, $A7
	note G#, 1
	notetype $6, $A7
	note A_, 1
	note __, 1
	note A_, 2
	note __, 6
	note G#, 1
	note A_, 7
	note B_, 3
	note __, 5
	note G_, 8
	note A_, 2
	note G_, 2
	note F_, 4
	intensity $97
	notetype $E, $97
	note __, 12
	vibrato $00, $00
	octave 3
	notetype $C, $97
	note C_, 1
	note __, 3
	octave 2
	note B_, 1
	note __, 5
	octave 3
	note D_, 4
	note D_, 1
	note __, 1
	octave 2
	note A#, 1
	note __, 3
	note A_, 4
	note A_, 1
	note __, 1
	note G#, 6
	note __, 2
	note G#, 1
	note __, 3
	note E_, 2
	note G_, 2
	octave 3
	note C_, 2
	note D#, 4
	note C_, 1
	note __, 1
	octave 2
	note G#, 4
	note G#, 6
	intensity $3F
	octave 3
	note C_, 10
	intensity $97
	note C_, 4
	note E_, 1
	note __, 1
	note E_, 4
	note __, 2
	note E_, 4
	note F#, 4
	octave 2
	note A_, 6
	note __, 2
	note A_, 1
	note __, 3
	note A_, 4
	octave 3
	note C_, 2
	note C_, 1
	note __, 1
	note C_, 1
	note __, 3
	note C_, 1
	note __, 3
	note D_, 4
	note D#, 1
	note __, 5
	note E_, 1
	note __, 3
	note F_, 1
	note __, 5
	notetype $6, $97
	note G#, 1
	note A_, 5
	note __, 2
	note A_, 2
	note __, 2
	note G_, 2
	note __, 6
	note F_, 8
	note G_, 2
	note __, 2
	note E_, 1
	note F_, 11
	note __, 4
	note C_, 2
	note __, 2
	note C_, 8
	note G_, 4
	octave 4
	note C_, 4
	note D#, 8
	note C_, 2
	note __, 2
	octave 3
	note G#, 4
	note __, 4
	note G_, 12
	note G#, 2
	intensity $3F
	note A_, 14
	intensity $97
	note B_, 4
	octave 4
	note C_, 3
	note __, 5
	note D_, 2
	note __, 2
	note D#, 1
	note E_, 7
	note D_, 2
	note __, 2
	note E_, 2
	note __, 6
	note G#, 1
	note A_, 7
	octave 3
	note F_, 12
	note __, 4
	note F_, 2
	note __, 6
	note F_, 8
	octave 4
	note C_, 4
	octave 3
	note B_, 1
	octave 4
	note C_, 2
	note __, 1
	octave 3
	note C_, 2
	note __, 2
	note A_, 2
	note __, 2
	octave 2
	note A_, 2
	note __, 2
	note G_, 2
	note __, 2
	octave 3
	note F#, 1
	note G_, 3
	note F_, 2
	note __, 2
	note F_, 12
	note __, 4
	note F_, 8
	note F#, 1
	note G_, 3
	note __, 4
	note F_, 12
	note __, 4
	note F_, 8
	note G#, 2
	note __, 2
	note F_, 2
	note __, 2
	note G#, 2
	note __, 2
	note F#, 1
	note G_, 3
	notetype $E, $97
	note E_, 12
	loopchannel 0, Music_Route225DPPt_Ch1_loop

Music_Route225DPPt_Ch2:
Music_Route225DPPt_Ch2_loop:
	tone $0001
	notetype $C, $C7
	note __, 16
	note __, 2
	dutycycle 1
	octave 3
	notetype $6, $C7
	note G_, 1
	octave 4
	note C_, 1
	note D_, 1
	note D#, 1
	note E_, 3
	note __, 9
	note D_, 3
	note __, 5
	note F_, 7
	note __, 1
	note F_, 2
	note __, 2
	note E_, 8
	note D_, 8
	note E_, 4
	notetype $F, $C7
	note C_, 8
	octave 3
	notetype $C, $C7
	note G#, 1
	note __, 1
	octave 4
	note C_, 1
	note __, 1
	note G#, 2
	notetype $E, $C7
	note G_, 3
	notetype $6, $C7
	note __, 1
	note G_, 2
	note __, 2
	note F_, 4
	note __, 2
	octave 3
	notetype $2, $C7
	note F_, 1
	note G_, 1
	notetype $3, $C7
	note A_, 1
	octave 4
	notetype $2, $C7
	note C_, 1
	notetype $3, $C7
	note D_, 1
	note E_, 6
	note __, 10
	note F_, 16
	note __, 8
	octave 3
	note G_, 2
	octave 4
	note C_, 2
	note D_, 2
	note D#, 2
	note E_, 6
	note __, 10
	note D_, 6
	notetype $9, $C7
	note __, 6
	notetype $E, $C7
	note F_, 3
	notetype $6, $C7
	note __, 1
	note F_, 2
	note __, 2
	note E_, 8
	note D_, 8
	note E_, 4
	notetype $F, $C7
	note C_, 8
	octave 3
	notetype $C, $C7
	note G#, 2
	octave 4
	note F_, 1
	note __, 1
	note G#, 2
	note A#, 4
	note D_, 1
	note __, 1
	note G#, 2
	note D_, 1
	note __, 1
	note G_, 2
	note __, 2
	note F_, 4
	dutycycle 2
	vibrato $02, $12
	octave 3
	note B_, 1
	octave 4
	notetype $6, $C7
	note C_, 1
	note __, 1
	note C_, 2
	note __, 6
	octave 3
	note B_, 1
	octave 4
	note C_, 7
	octave 3
	note B_, 3
	note __, 5
	note B_, 8
	note A_, 2
	note __, 2
	note A_, 4
	notetype $F, $C7
	note __, 8
	notetype $C, $C7
	note B_, 1
	octave 4
	notetype $6, $C7
	note C_, 1
	note __, 1
	note C_, 2
	note __, 6
	octave 3
	note B_, 1
	octave 4
	note C_, 7
	note D_, 3
	note __, 5
	octave 3
	note B_, 8
	octave 4
	note C_, 2
	octave 3
	note B_, 2
	note A_, 4
	notetype $F, $C7
	note __, 8
	octave 4
	notetype $C, $C7
	note E_, 1
	notetype $6, $C7
	note F_, 1
	note __, 1
	note F_, 2
	note __, 6
	note E_, 1
	note F_, 7
	note E_, 3
	note __, 5
	note E_, 8
	note D_, 2
	note __, 2
	note D_, 4
	notetype $F, $C7
	note __, 8
	notetype $C, $C7
	note E_, 1
	notetype $6, $C7
	note F_, 1
	note __, 1
	note F_, 2
	note __, 6
	note E_, 1
	note F_, 7
	note G_, 2
	note __, 6
	note E_, 8
	note F_, 2
	note E_, 2
	note D_, 4
	octave 3
	note G#, 12
	octave 1
	note G#, 8
	octave 3
	note B_, 2
	octave 4
	note C_, 1
	note __, 1
	note C_, 2
	note __, 6
	octave 3
	note B_, 1
	octave 4
	note C_, 7
	octave 3
	note B_, 3
	note __, 5
	note B_, 8
	note A_, 2
	note __, 2
	note A_, 4
	notetype $F, $C7
	note __, 8
	notetype $C, $C7
	note B_, 1
	octave 4
	notetype $6, $C7
	note C_, 1
	note __, 1
	note C_, 2
	note __, 6
	octave 3
	note B_, 1
	octave 4
	note C_, 7
	note D_, 3
	note __, 5
	octave 3
	note B_, 8
	octave 4
	note C_, 2
	octave 3
	note B_, 2
	note A_, 4
	notetype $F, $C7
	note __, 8
	octave 4
	notetype $C, $C7
	note E_, 1
	notetype $6, $C7
	note F_, 1
	note __, 1
	note F_, 2
	note __, 6
	note E_, 1
	note F_, 7
	note E_, 3
	note __, 5
	note D#, 1
	note E_, 7
	note D_, 2
	note __, 2
	note D_, 4
	notetype $F, $C7
	note __, 8
	notetype $C, $C7
	note E_, 1
	notetype $6, $C7
	note F_, 1
	note __, 1
	note F_, 2
	note __, 6
	note E_, 1
	note F_, 7
	note G_, 3
	note __, 5
	note E_, 8
	note F_, 2
	note E_, 2
	note D_, 4
	dutycycle 0
	intensity $77
	note G_, 4
	note B_, 4
	octave 5
	note D#, 4
	note G_, 8
	note __, 8
	dutycycle 1
	intensity $A7
	vibrato $00, $00
	octave 4
	note E_, 2
	note __, 6
	note D_, 2
	note __, 10
	note E_, 1
	note F_, 5
	note __, 2
	note F_, 2
	note __, 2
	note E_, 2
	note __, 6
	note C_, 8
	note D_, 2
	note __, 2
	octave 3
	note B_, 1
	octave 4
	note C_, 11
	note __, 4
	octave 3
	note G_, 2
	note __, 2
	note F#, 1
	note G_, 6
	note __, 1
	octave 4
	note C_, 4
	note D#, 4
	note F#, 2
	note G_, 6
	note F_, 2
	note __, 2
	note C_, 2
	note __, 6
	note D_, 12
	note D#, 2
	notetype $C, $4F
	note E_, 9
	intensity $A7
	note E_, 2
	note __, 2
	note A_, 1
	note __, 1
	notetype $6, $A7
	note A#, 1
	note B_, 7
	note A_, 2
	note __, 2
	note B_, 2
	note __, 6
	note A_, 1
	octave 5
	note C_, 7
	octave 4
	note C_, 12
	note __, 4
	note C_, 2
	note __, 6
	note C_, 8
	note F_, 4
	note G_, 4
	note __, 4
	note C_, 4
	octave 3
	note F_, 2
	note __, 2
	note C_, 4
	octave 4
	note D_, 4
	note __, 4
	note F_, 2
	note __, 8
	note C_, 1
	note D_, 1
	note E_, 2
	note __, 6
	note D_, 2
	note __, 10
	note E_, 1
	note F_, 5
	note __, 2
	note F_, 2
	note __, 2
	note E_, 2
	note __, 6
	note C_, 8
	note D_, 2
	note __, 2
	octave 3
	note B_, 1
	octave 4
	note C_, 11
	note __, 4
	octave 3
	note G_, 2
	note __, 2
	note G_, 8
	octave 4
	note C_, 4
	note D#, 4
	note F#, 2
	note G_, 6
	note F_, 2
	note __, 2
	note C_, 4
	note __, 4
	note D_, 12
	note D#, 2
	notetype $C, $4F
	note E_, 9
	intensity $A7
	note E_, 2
	note __, 2
	note A_, 1
	note __, 1
	notetype $6, $A7
	note A#, 1
	note B_, 7
	note A_, 2
	note __, 2
	note B_, 2
	note __, 6
	note B_, 1
	octave 5
	note C_, 7
	octave 4
	note C_, 12
	note __, 4
	note C_, 2
	note __, 6
	note C_, 8
	note F_, 4
	note F#, 1
	note G_, 3
	octave 3
	note G_, 2
	note __, 2
	octave 4
	note F_, 2
	note __, 2
	octave 3
	note F_, 2
	note __, 2
	note G_, 2
	note __, 2
	octave 4
	note C_, 1
	note E_, 3
	note D_, 2
	note __, 2
	note C_, 12
	note __, 4
	note C_, 8
	note C#, 1
	note D_, 3
	note __, 4
	note C_, 13
	note __, 3
	note C_, 8
	note D_, 2
	note __, 2
	note C_, 2
	note __, 2
	note D_, 2
	note __, 2
	note C#, 1
	note D_, 3
	notetype $E, $A7
	note C_, 12
	loopchannel 0, Music_Route225DPPt_Ch2_loop

Music_Route225DPPt_Ch3:
Music_Route225DPPt_Ch3_loop:
	notetype $C, $13
	note __, 16
	octave 2
	note C_, 4
	octave 3
	note C_, 1
	note __, 3
	octave 2
	note C_, 1
	note __, 1
	note C_, 2
	octave 3
	note C_, 1
	note __, 1
	octave 2
	note C_, 1
	note __, 3
	note C_, 2
	octave 3
	note C_, 1
	note __, 1
	octave 2
	note C_, 1
	note __, 3
	note C_, 2
	octave 1
	note A#, 2
	note G#, 2
	note G#, 4
	octave 2
	note G#, 1
	note __, 3
	octave 1
	notetype $9, $13
	note G_, 2
	notetype $6, $13
	note __, 1
	note G#, 2
	note __, 2
	octave 2
	note G#, 2
	note __, 2
	octave 1
	note A#, 7
	note __, 1
	note A#, 2
	note __, 2
	octave 2
	note A#, 2
	note __, 2
	octave 1
	note A#, 2
	note __, 2
	note G_, 4
	note G_, 2
	note __, 6
	note G_, 2
	note __, 2
	octave 2
	note F#, 2
	note G_, 2
	note D#, 2
	note E_, 2
	note C_, 8
	note C_, 2
	note __, 2
	note C_, 2
	note __, 2
	octave 3
	note C_, 2
	note __, 2
	octave 2
	note C_, 2
	note __, 6
	note C_, 4
	octave 3
	note C_, 2
	note __, 2
	octave 2
	note C_, 2
	note __, 6
	note C_, 4
	octave 1
	note A#, 4
	note G#, 4
	note G#, 8
	octave 2
	note G#, 2
	note __, 6
	octave 1
	note G_, 3
	note __, 1
	note G#, 2
	note __, 2
	octave 2
	note G#, 2
	note __, 2
	octave 1
	note A#, 7
	note __, 1
	note A#, 2
	note __, 2
	octave 2
	note A#, 2
	note __, 2
	octave 1
	note A#, 2
	note __, 2
	note G_, 4
	note G_, 2
	note __, 6
	note G_, 1
	note __, 1
	note G_, 1
	note __, 1
	intensity $14
	octave 2
	note A_, 16
	note __, 16
	note __, 16
	note __, 4
	note A_, 4
	note G_, 4
	note F#, 16
	notetype $F, $14
	note __, 16
	notetype $C, $14
	note F#, 2
	note E_, 2
	note D_, 8
	notetype $F, $14
	note __, 16
	notetype $C, $14
	note D_, 2
	note E_, 2
	note F_, 10
	note __, 2
	note F_, 2
	note F#, 2
	note G_, 6
	note __, 2
	note G#, 8
	note __, 2
	note A_, 2
	notetype $6, $14
	note A_, 1
	note __, 11
	note A_, 4
	note A_, 1
	note __, 3
	note A_, 1
	note __, 3
	note A_, 7
	note __, 1
	note A_, 1
	note __, 3
	note A_, 4
	note A_, 1
	note __, 3
	note A_, 3
	note __, 1
	note A_, 4
	note G_, 4
	note F#, 4
	note F#, 4
	note F#, 1
	note __, 11
	note F#, 4
	note F#, 1
	note __, 3
	note F#, 1
	note __, 3
	note F#, 7
	note __, 1
	note F#, 1
	note __, 3
	note F#, 4
	note F#, 1
	note __, 3
	note F#, 3
	note __, 1
	note F#, 1
	note __, 3
	note E_, 4
	note D_, 4
	note D_, 4
	note D_, 1
	note __, 11
	note D_, 4
	note D_, 1
	note __, 4
	note E_, 1
	note __, 3
	note E_, 7
	note D_, 1
	note __, 3
	note D_, 4
	note D_, 1
	note __, 3
	note D_, 3
	note __, 1
	note D_, 4
	note E_, 4
	note F_, 8
	note F_, 1
	note __, 11
	note F_, 4
	note F_, 1
	note __, 3
	note F#, 8
	note G_, 4
	note G_, 1
	note __, 3
	note G_, 4
	note G_, 1
	note __, 3
	note G_, 3
	note __, 1
	note G_, 1
	note __, 3
	note G_, 4
	note G_, 4
	intensity $13
	note C_, 4
	note __, 4
	octave 3
	note C_, 2
	note __, 6
	octave 1
	note B_, 2
	note __, 2
	note B_, 2
	note __, 2
	octave 2
	note B_, 2
	note __, 2
	octave 1
	note A#, 2
	note __, 2
	note A#, 4
	note A#, 1
	note __, 3
	octave 2
	note A#, 2
	note __, 2
	octave 1
	note A_, 2
	note __, 2
	note A_, 4
	note A_, 2
	note __, 2
	octave 2
	note A_, 2
	note __, 2
	octave 1
	note G#, 2
	note __, 2
	note G#, 4
	note G#, 1
	note __, 3
	octave 2
	note G#, 2
	note __, 2
	octave 1
	note G_, 2
	note __, 2
	note G_, 4
	note G_, 1
	note __, 3
	octave 2
	note G_, 2
	note __, 2
	octave 1
	note G#, 2
	note __, 2
	note G#, 4
	note G#, 1
	note __, 3
	octave 2
	note G#, 2
	note __, 2
	octave 1
	note G#, 2
	note __, 2
	octave 2
	note G#, 2
	note __, 2
	octave 1
	note A#, 2
	note __, 2
	octave 2
	note G_, 2
	note __, 2
	octave 1
	note G_, 2
	note __, 2
	note A_, 4
	note A_, 1
	note __, 3
	octave 2
	note A_, 2
	note __, 2
	octave 1
	note A_, 2
	note __, 2
	note G#, 4
	note G#, 1
	note __, 3
	octave 2
	note G#, 2
	note __, 2
	octave 1
	note G#, 4
	note G_, 4
	note G_, 1
	note __, 3
	octave 2
	note G_, 2
	note __, 2
	octave 1
	note F#, 2
	note __, 2
	note F#, 4
	note F#, 1
	note __, 3
	octave 2
	note F#, 4
	note F_, 3
	note __, 1
	note F_, 2
	note __, 6
	octave 3
	note F_, 2
	note __, 2
	octave 2
	note D_, 2
	note __, 2
	note D_, 4
	note D_, 1
	note __, 3
	octave 3
	note D_, 2
	note __, 2
	octave 2
	note D_, 2
	note __, 2
	note G_, 4
	note G_, 1
	note __, 7
	note G_, 2
	note __, 2
	note D_, 2
	note __, 2
	note G_, 8
	note __, 4
	note C_, 4
	note __, 4
	octave 3
	note C_, 2
	note __, 6
	octave 1
	note B_, 2
	note __, 2
	note B_, 2
	note __, 2
	octave 2
	note B_, 2
	note __, 2
	octave 1
	note A#, 2
	note __, 2
	note A#, 4
	note A#, 1
	note __, 3
	octave 2
	note A#, 2
	note __, 2
	octave 1
	note A_, 2
	note __, 2
	note A_, 4
	note A_, 2
	note __, 2
	octave 2
	note A_, 2
	note __, 2
	octave 1
	note G#, 2
	note __, 2
	note G#, 4
	note G#, 1
	note __, 3
	octave 2
	note G#, 2
	note __, 2
	octave 1
	note G_, 2
	note __, 2
	note G_, 4
	note G_, 1
	note __, 3
	octave 2
	note G_, 2
	note __, 2
	octave 1
	note G#, 2
	note __, 2
	note G#, 4
	note G#, 1
	note __, 3
	octave 2
	note G#, 2
	note __, 2
	octave 1
	note G#, 2
	note __, 2
	octave 2
	note G#, 4
	octave 1
	note A#, 2
	note __, 2
	octave 2
	note G_, 4
	octave 1
	note G_, 2
	note __, 2
	note A_, 4
	note A_, 1
	note __, 3
	octave 2
	note A_, 2
	note __, 2
	octave 1
	note A_, 2
	note __, 2
	note G#, 4
	note G#, 1
	note __, 3
	octave 2
	note G#, 2
	note __, 2
	octave 1
	note G#, 4
	note G_, 4
	note G_, 1
	note __, 3
	octave 2
	note G_, 2
	note __, 2
	octave 1
	note F#, 2
	note __, 2
	note F#, 4
	note F#, 1
	note __, 3
	octave 2
	note F#, 4
	note F_, 3
	note __, 1
	note F_, 8
	octave 3
	note F_, 2
	note __, 2
	octave 2
	note D_, 2
	note __, 2
	note D_, 4
	note D_, 1
	note __, 3
	octave 3
	note D_, 2
	note __, 2
	octave 2
	note D_, 2
	note __, 2
	note G_, 4
	note G_, 1
	note __, 7
	note G_, 2
	note __, 2
	note D_, 2
	note __, 2
	note G_, 8
	note D_, 4
	note D_, 2
	note __, 6
	octave 3
	note D_, 3
	note __, 5
	octave 2
	note D_, 4
	note D_, 1
	note __, 3
	octave 3
	note D_, 3
	note __, 1
	octave 2
	note D_, 4
	note D_, 2
	note __, 6
	octave 3
	note D_, 3
	note __, 5
	octave 2
	note D_, 4
	note D_, 1
	note __, 3
	octave 3
	note D_, 3
	note __, 1
	octave 2
	note C_, 4
	note C_, 4
	note __, 8
	octave 3
	note C_, 2
	note __, 2
	octave 2
	note C_, 2
	note __, 2
	octave 3
	note C_, 2
	note __, 6
	note C_, 4
	loopchannel 0, Music_Route225DPPt_Ch3_loop

Music_Route225DPPt_Ch4:
	togglenoise 3
Music_Route225DPPt_Ch4_loop:
	notetype $C
	note C_, 1
	note C_, 1
	note D#, 2
	note C_, 1
	note C_, 1
	note D#, 2
	note C_, 1
	note C_, 1
	note D#, 2
	note C_, 1
	note C_, 1
	note D#, 1
	note D#, 1
	note B_, 4
	note C_, 4
	note D#, 2
	note D#, 2
	note C_, 2
	note D#, 4
	note D#, 2
	note C_, 2
	note D#, 4
	note D#, 2
	note C_, 2
	note D#, 2
	note D#, 4
	note C_, 4
	note D#, 2
	note D#, 2
	note C_, 2
	note D#, 4
	note D#, 2
	note C_, 2
	note D#, 4
	note D#, 2
	notetype $6
	note C_, 1
	note C_, 3
	note C_, 4
	notetype $A
	note C_, 4
	notetype $8
	note D#, 1
	note C_, 3
	note D#, 3
	note C_, 3
	note D#, 3
	note C_, 3
	note D#, 6
	note D#, 3
	note C_, 3
	note D#, 6
	note D#, 3
	note C_, 3
	note D#, 3
	note D#, 6
	note C_, 6
	note D#, 3
	note D#, 3
	note C_, 3
	notetype $F
	note D#, 4
	notetype $C
	note D#, 4
	note D#, 1
	note C_, 1
	note C_, 2
	note D#, 1
	note C_, 1
	note C_, 3
	note B_, 8
	note F#, 4
	note D_, 4
	note F#, 4
	note D_, 4
	note F#, 4
	note D_, 4
	note F#, 4
	note D_, 4
	note F#, 4
	note D_, 4
	note F#, 4
	note D_, 4
	note F#, 4
	note D_, 4
	note F#, 4
	note D_, 4
	note F#, 4
	note D_, 4
	note F#, 4
	note D_, 4
	note F#, 4
	note D_, 4
	note F#, 4
	note D_, 4
	note F#, 4
	note D_, 4
	note B_, 3
	note D#, 3
	note C_, 1
	note C_, 1
	note D#, 1
	note D#, 1
	note C_, 1
	note D#, 1
	note C_, 1
	note C_, 3
	note D#, 4
	note C_, 4
	note D#, 2
	note D#, 2
	note C_, 2
	note D#, 4
	note D#, 2
	note C_, 2
	note D#, 4
	note D#, 2
	note C_, 4
	note D#, 4
	note C_, 4
	note D#, 2
	note D#, 2
	note C_, 2
	note D#, 4
	note D#, 2
	note C_, 2
	note D#, 4
	note D#, 2
	note C_, 4
	note D#, 4
	note C_, 4
	note D#, 2
	note D#, 2
	note C_, 2
	note D#, 4
	note D#, 2
	note C_, 2
	note D#, 4
	note D#, 2
	note C_, 4
	note D#, 4
	note C_, 4
	note D#, 2
	note D#, 2
	note C_, 2
	note D#, 2
	notetype $6
	note C_, 1
	note C_, 3
	note D#, 4
	note D#, 4
	note C_, 1
	note C_, 3
	note D#, 4
	note D#, 4
	note C_, 8
	note D#, 8
	note C_, 8
	note D#, 4
	note C_, 4
	note C_, 4
	note D#, 8
	note D#, 4
	note C_, 4
	note D#, 8
	note D#, 4
	note C_, 8
	note D#, 8
	note C_, 8
	note D#, 4
	note D#, 4
	note C_, 4
	note D#, 8
	note D#, 4
	note C_, 4
	note D#, 4
	note D#, 4
	note C_, 4
	note C_, 1
	note C_, 7
	note D#, 8
	note C_, 8
	note D#, 4
	note D#, 4
	note C_, 4
	note D#, 8
	note D#, 4
	note C_, 4
	note D#, 8
	note D#, 4
	note C_, 8
	note D#, 8
	note C_, 8
	note D#, 4
	note D#, 4
	note C_, 4
	note D#, 4
	note C_, 1
	note C_, 3
	note D#, 8
	note D#, 8
	note D#, 4
	note C_, 2
	note C_, 6
	note D#, 8
	note C_, 8
	note D#, 4
	note C_, 4
	note C_, 4
	note D#, 8
	note D#, 4
	note C_, 4
	note D#, 8
	note D#, 4
	note C_, 8
	note D#, 8
	note C_, 8
	note D#, 4
	note D#, 4
	note C_, 4
	note D#, 8
	note D#, 4
	note C_, 4
	note D#, 8
	note D#, 4
	note C_, 8
	note D#, 8
	note C_, 8
	note D#, 4
	note D#, 4
	note C_, 4
	note D#, 8
	note D#, 4
	note C_, 4
	note D#, 8
	note D#, 4
	note C_, 8
	note D#, 8
	note C_, 8
	note D#, 4
	note D#, 4
	note C_, 4
	note D#, 8
	note D#, 4
	note C_, 4
	note D#, 8
	note D#, 4
	note C_, 8
	note D#, 8
	note C_, 8
	note D#, 4
	note D#, 4
	note C_, 4
	note D#, 8
	note D#, 4
	note C_, 4
	note D#, 8
	note D#, 4
	note C_, 8
	note __, 16
	note __, 16
	loopchannel 0, Music_Route225DPPt_Ch4_loop
