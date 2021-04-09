; Pokémon R/S/E - Abandoned Ship
; Demixed by Mmmmmm
; https://pastebin.com/8yZgqyZ8
; https://hax.iimarckus.org/topic/6777/

Music_AbandonedShipRSE:
	musicheader 4, 1, Music_AbandonedShipRSE_Ch1
	musicheader 1, 2, Music_AbandonedShipRSE_Ch2
	musicheader 1, 3, Music_AbandonedShipRSE_Ch3
	musicheader 1, 4, Music_AbandonedShipRSE_Ch4

Music_AbandonedShipRSE_Ch1:
	tempo 188
	volume $77
	dutycycle $0
	tone $0002
	vibrato $10, $22
	notetype $c, $82
	note __, 6
Music_AbandonedShipRSE_Ch1_loop:
	octave 3
	note A#, 2
	octave 4
	note F#, 4
	note F_, 4
	octave 3
	note C#, 1
	octave 4
	note F_, 1
	octave 3
	note C#, 1
	octave 4
	note F_, 1
	octave 3
	note C#, 1
	octave 4
	note F_, 1
	octave 3
	note A#, 2
	octave 4
	note F#, 4
	note F_, 4
	note C#, 4
	octave 3
	note A#, 2
	note A_, 2
	octave 4
	note D#, 4
	note C_, 4
	octave 3
	note C_, 1
	octave 4
	note C_, 1
	octave 3
	note C_, 1
	octave 4
	note D#, 1
	octave 3
	note C_, 1
	octave 4
	note C_, 1
	octave 3
	note A_, 2
	octave 4
	note D#, 4
	note C_, 4
	note D#, 4
	note C_, 2
	note C_, 2
	note F_, 4
	note D#, 4
	octave 3
	note C_, 1
	octave 4
	note D#, 1
	octave 3
	note C_, 1
	octave 4
	note F_, 1
	octave 3
	note C_, 1
	octave 4
	note D#, 1
	note C_, 2
	note F_, 4
	note D#, 4
	note C_, 4
	note D#, 2
	note C#, 2
	note F_, 4
	note C#, 4
	octave 3
	note C#, 1
	octave 4
	note C#, 1
	octave 3
	note C#, 1
	octave 4
	note F_, 1
	octave 3
	note C#, 1
	octave 4
	note C#, 1
	note F_, 2
	note D#, 4
	note C#, 4
	intensity $84
	octave 3
	note F_, 6
	intensity $82
	dutycycle $2
	octave 3
	note F#, 1
	note A_, 1
	octave 4
	note C#, 1
	note D#, 1
	note F#, 1
	note A_, 1
	octave 5
	note C#, 1
	note D#, 1
	note A_, 1
	note F#, 1
	note D#, 1
	note C#, 1
	octave 4
	note A_, 1
	note F#, 1
	note C#, 1
	octave 3
	note F#, 1
	note F_, 1
	note G#, 1
	octave 4
	note C_, 1
	note D#, 1
	note F_, 1
	note G#, 1
	octave 5
	note C_, 1
	note D#, 1
	note G#, 1
	note F_, 1
	note D#, 1
	note C_, 1
	octave 4
	note G#, 1
	note F_, 1
	note C_, 1
	octave 3
	note F_, 1
	note C#, 1
	note F_, 1
	note A#, 1
	octave 4
	note C#, 1
	note F_, 1
	note G#, 1
	note A#, 1
	octave 5
	note C#, 1
	note F_, 1
	note C#, 1
	octave 4
	note A#, 1
	note G#, 1
	note F_, 1
	note C#, 1
	octave 3
	note A#, 1
	note G#, 1
	note D#, 1
	note G_, 1
	note G#, 1
	octave 4
	note C_, 1
	note D#, 1
	note G_, 1
	note G#, 1
	octave 5
	note C_, 1
	note G#, 1
	note G_, 1
	note D#, 1
	note C_, 1
	octave 4
	note G#, 1
	note G_, 1
	note D#, 1
	note C_, 1
	dutycycle $0
	octave 4
	note F#, 2
	note D#, 4
	note G#, 1
	note G#, 1
	note D#, 3
	note G#, 3
	note F#, 2
	note F_, 2
	note D_, 4
	octave 3
	note G#, 1
	note G#, 1
	note F_, 4
	note D_, 1
	note G#, 1
	octave 4
	note D_, 1
	note F_, 1
	note C#, 1
	octave 3
	note B_, 1
	note __, 1
	octave 4
	note C#, 1
	octave 3
	note B_, 1
	note __, 1
	note C#, 1
	octave 3
	note B_, 1
	notetype $6, $82
	octave 4
	note C#, 1
	octave 3
	note G#, 1
	note F#, 1
	note C#, 1
	note F#, 1
	note G#, 1
	note B_, 1
	octave 4
	note F#, 1
	octave 3
	note C#, 1
	note F#, 1
	note G#, 1
	octave 4
	note C#, 1
	note F#, 1
	note G#, 1
	note B_, 1
	octave 5
	note C#, 1
	octave 4
	notetype $c, $82
	note G#, 3
	note F#, 3
	note F_, 2
	octave 3
	note B_, 3
	note A#, 3
	note G#, 2
	loopchannel 0, Music_AbandonedShipRSE_Ch1_loop

Music_AbandonedShipRSE_Ch2:
	dutycycle $3
	vibrato $1c, $12
	notetype $c, $a0
	note __, 6
Music_AbandonedShipRSE_Ch2_loop:
	callchannel Music_AbandonedShipRSE_Ch2_branch_1
	vibrato $1c, $F2
	callchannel Music_AbandonedShipRSE_Ch2_branch_1
	note D#, 2
	note C#, 2
	note D#, 2
	intensity $a0
	note C_, 4
	intensity $a7
	vibrato $15, $F2
	note C_, 6
	dutycycle $2
	intensity $85
	note __, 2
	vibrato $1c, $12
	octave 5
	note C_, 4
	octave 4
	note A_, 4
	note __, 6
	dutycycle $3
	intensity $a0
	note D#, 4
	intensity $a7
	vibrato $15, $72
	note D#, 6
	vibrato $1c, $12
	note D#, 2
	note F_, 2
	note D#, 2
	octave 3
	intensity $a0
	note G#, 4
	intensity $a7
	vibrato $15, $72
	note G#, 6
	octave 4
	vibrato $1c, $12
	note D#, 2
	note F_, 2
	note C_, 2
	octave 3
	note G#, 2
	note A#, 2
	octave 4
	note C_, 2
	intensity $a0
	note C#, 4
	vibrato $15, $62
	intensity $a7
	note C#, 6
	dutycycle $2
	intensity $85
	vibrato $1c, $12
	note __, 2
	octave 5
	note C#, 4
	octave 4
	note A#, 4
	note __, 6
	intensity $84
	note C#, 2
	intensity $64
	note C#, 2
	intensity $54
	note C#, 2
	intensity $44
	note C#, 2
	octave 3
	intensity $84
	note A_, 2
	note B_, 2
	octave 4
	note C#, 2
	octave 3
	note F#, 2
	note G#, 2
	intensity $64
	note G#, 2
	intensity $54
	note G#, 2
	intensity $44
	note G#, 2
	intensity $84
	octave 4
	note C_, 2
	intensity $64
	note C_, 2
	intensity $54
	note C_, 2
	intensity $44
	note C_, 2
	intensity $84
	note C#, 2
	intensity $64
	note C#, 2
	intensity $54
	note C#, 2
	intensity $84
	note F_, 2
	intensity $64
	note F_, 2
	intensity $84
	note G#, 2
	intensity $64
	note G#, 2
	intensity $84
	octave 5
	note C#, 2
	note C_, 2
	intensity $64
	note C_, 2
	intensity $54
	note C_, 2
	intensity $44
	note C_, 2
	intensity $34
	note C_, 2
	intensity $24
	note C_, 2
	note __, 2
	dutycycle $3
	notetype $6, $a7
	octave 3
	note G_, 1
	note G#, 1
	note A_, 1
	note A#, 1
	notetype $c, $a7
	note B_, 6
	note A#, 1
	note B_, 1
	octave 4
	note C#, 2
	octave 3
	note B_, 2
	note A#, 2
	note G#, 2
	note B_, 2
	note __, 1
	note F_, 2
	note __, 1
	note F#, 1
	note G#, 7
	note __, 2
	note G#, 1
	note F#, 1
	note __, 1
	note G#, 1
	note F#, 1
	note __, 1
	note G#, 1
	note F#, 1
	note G#, 2
	note __, 1
	note A#, 2
	note __, 1
	note B_, 2
	octave 4
	note C#, 2
	note __, 1
	octave 3
	note B_, 2
	note __, 1
	note G#, 2
	note F_, 2
	note __, 1
	note D#, 2
	note __, 1
	note C#, 2
	loopchannel 0, Music_AbandonedShipRSE_Ch2_loop

Music_AbandonedShipRSE_Ch2_branch_1:
	notetype $c, $a0
	octave 3
	note A#, 4
	intensity $a7
	note A#, 6
	octave 4
	vibrato $1c, $12
	note F_, 2
	note F#, 2
	note F_, 2
	endchannel

Music_AbandonedShipRSE_Ch3:
	stereopanning $f0
	notetype $c, $14
	note __, 6
Music_AbandonedShipRSE_Ch3_loop:
	octave 2
	note F#, 1
	note __, 1
	note F#, 1
	note __, 3
	octave 4
	intensity $24
	note F_, 4
	note __, 4
	octave 2
	intensity $14
	note F#, 1
	note __, 1
	note F#, 1
	note __, 1
	note F#, 1
	note __, 3
	octave 4
	intensity $24
	note F_, 4
	intensity $14
	octave 2
	note F#, 5
	note __, 1
	note F#, 1
	note __, 1
	note F#, 1
	note __, 3
	octave 4
	intensity $24
	note D#, 4
	note __, 4
	octave 2
	intensity $14
	note F#, 1
	note __, 1
	note F#, 1
	note __, 1
	note F#, 1
	note __, 3
	octave 4
	intensity $24
	note D#, 4
	octave 2
	intensity $14
	note F#, 5
	note __, 1
	note F_, 1
	note __, 1
	note F_, 1
	note __, 3
	octave 4
	intensity $24
	note C_, 4
	note __, 4
	octave 2
	intensity $14
	note F_, 1
	note __, 1
	note F_, 1
	note __, 1
	note F_, 1
	note __, 3
	octave 4
	intensity $24
	note C_, 4
	octave 2
	intensity $14
	note F_, 5
	note __, 1
	note C#, 1
	note __, 1
	note C#, 1
	note __, 3
	octave 3
	intensity $24
	note A#, 4
	note __, 4
	octave 2
	intensity $14
	note C#, 1
	note __, 1
	note C#, 1
	note __, 1
	note C#, 1
	note __, 3
	octave 3
	intensity $24
	note A#, 4
	octave 2
	intensity $14
	note C#, 6
	note __, 8
	note C#, 8
	note C_, 8
	note G#, 8
	note A#, 6
	octave 3
	note C#, 3
	note __, 1
	note C#, 4
	note F_, 2
	note D#, 8
	intensity $24
	note D#, 8
	intensity $14
	octave 2
	note G#, 1
	note __, 1
	note G#, 1
	note __, 3
	note B_, 2
	note G#, 6
	octave 3
	note D#, 2
	note D_, 6
	note __, 4
	octave 2
	note B_, 5
	note __, 1
	note B_, 2
	note __, 1
	note B_, 2
	note __, 1
	note F#, 1
	note A#, 1
	note B_, 2
	note __, 1
	octave 3
	note C#, 2
	note __, 1
	note D#, 2
	note F#, 2
	note __, 1
	note D#, 2
	note __, 1
	note C#, 2
	octave 2
	note B_, 2
	note __, 1
	note A#, 2
	note __, 1
	note G#, 2
	loopchannel 0, Music_AbandonedShipRSE_Ch3_loop

Music_AbandonedShipRSE_Ch4:
	stereopanning $f
	togglenoise $3
	notetype $6
	note C#, 1
	note C#, 1
	note C#, 1
	note C#, 1
	note C#, 1
	note C#, 1
	note C#, 1
	note C#, 1
	note D_, 1
	note D_, 1
	note D_, 1
	note D_, 1
Music_AbandonedShipRSE_branch_1:
	notetype $c
	callchannel Music_AbandonedShipRSE_branch_eeb6b
	note D_, 1
	note C#, 1
	note C#, 1
	note D_, 1
	callchannel Music_AbandonedShipRSE_branch_eeb6b
	notetype $6
	note C#, 1
	note C#, 1
	note C#, 1
	note C#, 1
	note C#, 1
	note D_, 1
	note D_, 1
	note D_, 1
	loopchannel 4, Music_AbandonedShipRSE_branch_1
Music_AbandonedShipRSE_branch_2:
	notetype $c
	note __, 16
	loopchannel 4, Music_AbandonedShipRSE_branch_2
	callchannel Music_AbandonedShipRSE_branch_eeb6b
	note D_, 1
	note C#, 1
	note C#, 1
	note D_, 1
	callchannel Music_AbandonedShipRSE_branch_eeb6b
	notetype $6
	note C#, 1
	note C#, 1
	note C#, 1
	note C#, 1
	note C#, 1
	note D_, 1
	note D_, 1
	note D_, 1
	notetype $c
	callchannel Music_AbandonedShipRSE_branch_eeb6b
	note D_, 1
	note C#, 1
	note C#, 1
	note D_, 1
	note D_, 2
	note C#, 1
	note C#, 1
	note D_, 2
	note C#, 1
	note C#, 1
	note D_, 2
	notetype $6
	note C#, 1
	note C#, 1
	note C#, 1
	note C#, 1
	note C#, 1
	note C#, 1
	note C#, 1
	note C#, 1
	note D_, 1
	note D_, 1
	note D_, 1
	note D_, 1
	loopchannel 0, Music_AbandonedShipRSE_branch_1

Music_AbandonedShipRSE_branch_eeb6b:
	note D_, 2
	note C#, 1
	note C#, 1
	note D_, 2
	note C#, 1
	note C#, 1
	note D_, 2
	note C#, 1
	note C#, 1
	endchannel
