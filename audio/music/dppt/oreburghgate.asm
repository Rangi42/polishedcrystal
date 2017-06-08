; Pokémon D/P/Pt - Oreburgh Gate
; Demixed by Mmmmmm
; https://pastebin.com/xEactCTm
; https://hax.iimarck.us/topic/6777/

Music_OreburghGateDPPt:
	dbw $80, Music_OreburghGateDPPt_Ch1
	dbw $01, Music_OreburghGateDPPt_Ch2
	dbw $02, Music_OreburghGateDPPt_Ch3

Music_OreburghGateDPPt_Ch1:
	tempo 130
	volume $77
	dutycycle 0
	tone $0001
	notetype $C, $20
	vibrato $8, $12
	octave 3
	note G_, 8
	intensity $2E
	note G_, 8
Music_OreburghGateDPPt_Ch1_branch_1:
	octave 4
	intensity $40
	note F#, 12
	intensity $4F
	note F#, 8
	intensity $7F
	note G_, 2
	note A_, 2
	intensity $A0
	note F#, 12
	intensity $A7
	note E_, 12
	intensity $40
	note F#, 12
	intensity $4F
	note F#, 8
	intensity $7F
	note G_, 2
	note A_, 2
	intensity $A0
	note F#, 12
	intensity $A7
	note F#, 12
	intensity $40
	note D#, 12
	intensity $4F
	note D#, 8
	intensity $7F
	note E_, 2
	note F#, 2
	intensity $A0
	note D#, 12
	intensity $A7
	note C#, 12
	intensity $40
	note D#, 12
	intensity $4F
	note C#, 8
	intensity $7F
	note D#, 2
	note E_, 2
	intensity $A0
	note D#, 12
	intensity $A7
	note D_, 8
	intensity $40
	note E_, 4
	loopchannel 3, Music_OreburghGateDPPt_Ch1_branch_1
Music_OreburghGateDPPt_Ch1_branch_2:
	intensity $D7
	octave 2
	note C#, 2
	octave 4
	note C#, 1
	note C_, 1
	octave 3
	note B_, 2
	note A_, 2
	note G#, 2
	note F_, 2
	note F#, 2
	note C_, 2
	note D_, 2
	note F#, 2
	note C#, 2
	note E_, 2
	intensity $40
	note G_, 12
	intensity $4F
	note G_, 12
	intensity $40
	note G#, 12
	intensity $4F
	note G#, 12
	intensity $40
	note A_, 12
	intensity $4F
	note A_, 12
	intensity $40
	note A_, 6
	intensity $4F
	note A_, 6
	intensity $97
	note A_, 6
	intensity $47
	note A_, 6
	note __, 8
	intensity $20
	note G_, 8
	intensity $2E
	note G_, 8
	loopchannel 0, Music_OreburghGateDPPt_Ch1_branch_1


Music_OreburghGateDPPt_Ch2:
	tone $0001
	dutycycle 1
	notetype $C, $55
	note __, 16
Music_OreburghGateDPPt_Ch2_branch_1:
	octave 3
	intensity $55
	note G_, 2
	note A#, 2
	octave 4
	note C#, 2
	note F#, 2
	note C#, 2
	octave 3
	note A#, 2
	note G_, 2
	note A#, 2
	octave 4
	note C#, 2
	note F#, 2
	note C#, 2
	octave 3
	note A#, 2
	note G_, 2
	note A#, 2
	octave 4
	note C#, 2
	note F#, 2
	note C#, 2
	octave 3
	note A#, 2
	note G_, 2
	note A#, 2
	octave 4
	note C#, 2
	note F#, 2
	note C#, 2
	octave 3
	note A#, 2
	; measure 2
	note F#, 2
	note A#, 2
	octave 4
	note D#, 2
	note E_, 2
	note D#, 2
	octave 3
	note A#, 2
	note F#, 2
	note A#, 2
	octave 4
	note D#, 2
	note E_, 2
	note D#, 2
	octave 3
	note A#, 2
	note F#, 2
	note A_, 2
	octave 4
	note C_, 2
	note E_, 2
	note C_, 2
	octave 3
	note A_, 2
	note F#, 2
	note A_, 2
	octave 4
	note C_, 2
	note E_, 2
	note C_, 2
	octave 3
	note A_, 2
	; measure 3
	note E_, 2
	note G_, 2
	note B_, 2
	octave 4
	note D#, 2
	octave 3
	note B_, 2
	note G_, 2
	note E_, 2
	note G_, 2
	note B_, 2
	octave 4
	note D#, 2
	octave 3
	note B_, 2
	note G_, 2
	note E_, 2
	note G_, 2
	note A#, 2
	octave 4
	note E_, 2
	octave 3
	note A#, 2
	note G_, 2
	note E_, 2
	note G_, 2
	note B_, 2
	octave 4
	note D#, 2
	octave 3
	note B_, 2
	note G_, 2
	; measure 4
	note D#, 2
	note G_, 2
	note A#, 2
	octave 4
	note E_, 2
	octave 3
	note A#, 2
	note G_, 2
	note D#, 2
	note G_, 2
	note A#, 2
	octave 4
	note E_, 2
	octave 3
	note A#, 2
	note G_, 2
	note D#, 2
	note G_, 2
	note A#, 2
	octave 4
	note D#, 2
	octave 3
	note A#, 2
	note G_, 2
	note E_, 2
	note G_, 2
	note A#, 2
	octave 4
	note E_, 2
	octave 3
	note A#, 2
	note G_, 2
	loopchannel 2, Music_OreburghGateDPPt_Ch2_branch_1
Music_OreburghGateDPPt_Ch2_branch_2:
	octave 4
	intensity $30
	note __, 8
	note C#, 4
	intensity $3F
	note C#, 8
	intensity $6F
	note C_, 2
	octave 3
	note B_, 2
	intensity $90
	note A#, 8
	intensity $97
	note A#, 4
	intensity $77
	note A_, 2
	note G#, 2
	intensity $57
	note G_, 8
	intensity $30
	note C#, 12
	intensity $3F
	note C#, 12
	intensity $90
	note C_, 12
	intensity $97
	note C_, 8
	intensity $47
	note E_, 4
	octave 2
	intensity $30
	note B_, 12
	intensity $3F
	note B_, 8
	intensity $6F
	octave 3
	note D#, 2
	note C#, 2
	intensity $90
	octave 2
	note A#, 12
	intensity $97
	note A#, 4
	intensity $57
	note A_, 2
	note G#, 2
	note G_, 4
	octave 3
	intensity $30
	note D#, 12
	intensity $3F
	note D#, 8
	intensity $6F
	note C#, 2
	octave 2
	note B_, 2
	intensity $90
	note A#, 8
	intensity $97
	note A#, 12
	intensity $30
	octave 3
	note E_, 4
Music_OreburghGateDPPt_Ch2_branch_3:
	octave 5
	intensity $53
	note __, 1
	note F#, 1
	note C#, 1
	note D_, 1
	octave 4
	note A#, 1
	octave 5
	note C#, 1
	octave 4
	note G_, 1
	note A#, 1
	note F#, 1
	note G_, 1
	note C#, 1
	note D_, 1
	octave 3
	note A#, 1
	octave 4
	note C#, 1
	octave 3
	note G_, 1
	note A#, 1
	note F#, 1
	note G_, 1
	note C#, 1
	note D_, 1
	octave 2
	note A#, 1
	octave 3
	note C#, 1
	octave 2
	note G_, 1
	note A#, 1
	intensity $A7
	octave 3
	note C#, 2
	note C#, 4
	intensity $87
	note C#, 2
	note C#, 2
	note C#, 4
	intensity $57
	note C#, 2
	note C#, 2
	note C#, 4
	intensity $37
	note C#, 2
	intensity $A7
	octave 3
	note D_, 2
	note D_, 4
	intensity $87
	note D_, 2
	note D_, 2
	note D_, 4
	intensity $57
	note D_, 2
	note D_, 2
	note D_, 4
	intensity $37
	note D_, 2
	intensity $A7
	octave 3
	note D#, 2
	note D#, 4
	intensity $87
	note D#, 2
	note D#, 2
	note D#, 4
	intensity $57
	note D#, 2
	note D#, 2
	note D#, 4
	intensity $37
	note D#, 2
	intensity $87
	octave 3
	note D#, 2
	note D#, 4
	intensity $47
	note D#, 2
	note D#, 2
	note D#, 4
	intensity $27
	note D#, 2
	note D#, 2
	note D#, 4
	note D#, 2
	note __, 12
	note __, 12
	loopchannel 0, Music_OreburghGateDPPt_Ch2_branch_1

Music_OreburghGateDPPt_Ch3:
	notetype $C, $12
	vibrato $8, $12
	note __, 16
Music_OreburghGateDPPt_Ch3_branch_1:
	octave 3
	intensity $12
	note G_, 1
	note __, 1
	octave 4
	note C#, 1
	note __, 1
	note F#, 1
	note __, 1
	note G_, 1
	note __, 1
	note A#, 1
	note __, 1
	octave 5
	note C#, 1
	note __, 1
	note F#, 1
	note __, 1
	note G_, 1
	note __, 1
	note A#, 1
	note __, 1
	note G_, 1
	note __, 1
	note F#, 1
	note __, 1
	note C#, 1
	note __, 1
	octave 4
	note A#, 1
	note __, 1
	note G_, 1
	note __, 1
	note F#, 1
	note __, 1
	note G_, 1
	note __, 1
	note A#, 1
	note __, 1
	octave 5
	note C#, 1
	note __, 1
	octave 3
	note G_, 1
	note __, 1
	octave 4
	note C#, 1
	note __, 1
	note F#, 1
	note __, 1
	note G_, 1
	note __, 1
	note A#, 1
	note __, 1
	note F#, 1
	note __, 1
	; measure 2
	octave 3
	note F#, 1
	note __, 1
	note A#, 1
	note __, 1
	octave 4
	note E_, 1
	note __, 1
	note F#, 1
	note __, 1
	note A#, 1
	note __, 1
	octave 5
	note C#, 1
	note __, 1
	note E_, 1
	note __, 1
	note F#, 1
	note __, 1
	note A#, 1
	note __, 1
	note F#, 1
	note __, 1
	note E_, 1
	note __, 1
	note C#, 1
	note __, 1
	octave 4
	note F#, 1
	note __, 1
	note E_, 1
	note __, 1
	note C_, 1
	note __, 1
	note F#, 1
	note __, 1
	note A#, 1
	note __, 1
	octave 5
	note C_, 1
	note __, 1
	octave 3
	note F#, 1
	note __, 1
	octave 4
	note C_, 1
	note __, 1
	note E_, 1
	note __, 1
	note F#, 1
	note __, 1
	note A_, 1
	note __, 1
	note F#, 1
	note __, 1
	; measure 3
	octave 3
	note E_, 1
	note __, 1
	note B_, 1
	note __, 1
	octave 4
	note D#, 1
	note __, 1
	note E_, 1
	note __, 1
	note G_, 1
	note __, 1
	note B_, 1
	note __, 1
	octave 5
	note D#, 1
	note __, 1
	note E_, 1
	note __, 1
	note G_, 1
	note __, 1
	note E_, 1
	note __, 1
	note D#, 1
	note __, 1
	octave 4
	note B_, 1
	note __, 1
	note G_, 1
	note __, 1
	note E_, 1
	note __, 1
	note D#, 1
	note __, 1
	note E_, 1
	note __, 1
	note G_, 1
	note __, 1
	note A#, 1
	note __, 1
	octave 3
	note E_, 1
	note __, 1
	note A#, 1
	note __, 1
	octave 4
	note D#, 1
	note __, 1
	note E_, 1
	note __, 1
	note G_, 1
	note __, 1
	note E_, 1
	note __, 1
	; measure 4
	octave 3
	note D#, 1
	note __, 1
	note A#, 1
	note __, 1
	octave 4
	note C#, 1
	note __, 1
	note E_, 1
	note __, 1
	note G_, 1
	note __, 1
	note A#, 1
	note __, 1
	octave 5
	note C#, 1
	note __, 1
	note E_, 1
	note __, 1
	note G_, 1
	note __, 1
	note E_, 1
	note __, 1
	note C#, 1
	note __, 1
	octave 4
	note A#, 1
	note __, 1
	note G_, 1
	note __, 1
	note D#, 1
	note __, 1
	note C#, 1
	note __, 1
	note D#, 1
	note __, 1
	note G_, 1
	note __, 1
	octave 5
	note C#, 1
	note __, 1
	octave 3
	note E_, 1
	note __, 1
	note A#, 1
	note __, 1
	octave 4
	note E_, 1
	note __, 1
	note G_, 1
	note __, 1
	note A#, 1
	note __, 1
	octave 5
	note E_, 1
	note __, 1
Music_OreburghGateDPPt_Ch3_branch_2:
	octave 3
	intensity $12
	note G_, 1
	intensity $22
	octave 4
	note G_, 1
	intensity $12
	note C#, 1
	intensity $22
	note A#, 1
	intensity $12
	note F#, 1
	intensity $22
	octave 5
	note C#, 1
	intensity $12
	octave 4
	note G_, 1
	intensity $22
	octave 5
	note F#, 1
	intensity $12
	octave 4
	note A#, 1
	intensity $22
	octave 5
	note C#, 1
	intensity $12
	note C#, 1
	intensity $22
	octave 4
	note A#, 1
	intensity $12
	octave 5
	note F#, 1
	intensity $22
	octave 4
	note G_, 1
	intensity $12
	octave 5
	note G_, 1
	intensity $22
	octave 4
	note A#, 1
	intensity $12
	octave 5
	note A#, 1
	intensity $22
	note C#, 1
	intensity $12
	note G_, 1
	intensity $22
	note F#, 1
	intensity $12
	note F#, 1
	intensity $22
	note C#, 1
	intensity $12
	note C#, 1
	intensity $22
	octave 4
	note A#, 1
	intensity $12
	note A#, 1
	intensity $22
	note G_, 1
	intensity $12
	note G_, 1
	intensity $22
	note A#, 1
	intensity $12
	note F#, 1
	intensity $22
	octave 5
	note C#, 1
	intensity $12
	octave 4
	note G_, 1
	intensity $22
	octave 5
	note F#, 1
	intensity $12
	octave 4
	note A#, 1
	intensity $22
	octave 5
	note C#, 1
	intensity $12
	note C#, 1
	intensity $22
	octave 4
	note A#, 1
	octave 3
	intensity $12
	note G_, 1
	intensity $22
	octave 4
	note G_, 1
	intensity $12
	note C#, 1
	intensity $22
	note A#, 1
	intensity $12
	note F#, 1
	intensity $22
	octave 5
	note C#, 1
	intensity $12
	octave 4
	note G_, 1
	intensity $22
	octave 5
	note F#, 1
	intensity $12
	octave 4
	note A#, 1
	intensity $22
	octave 5
	note C#, 1
	intensity $12
	octave 4
	note F#, 1
	intensity $22
	note A#, 1
	; measure 2
	octave 3
	intensity $12
	note F#, 1
	intensity $22
	octave 4
	note F#, 1
	intensity $12
	octave 3
	note A#, 1
	intensity $22
	octave 4
	note A#, 1
	intensity $12
	note E_, 1
	intensity $22
	octave 5
	note D#, 1
	intensity $12
	octave 4
	note F#, 1
	intensity $22
	octave 5
	note E_, 1
	intensity $12
	octave 4
	note A#, 1
	intensity $22
	octave 5
	note D#, 1
	intensity $12
	note C#, 1
	intensity $22
	octave 4
	note A#, 1
	intensity $12
	octave 5
	note E_, 1
	intensity $22
	octave 4
	note F#, 1
	intensity $12
	octave 5
	note F#, 1
	intensity $22
	octave 4
	note A#, 1
	intensity $12
	octave 5
	note A#, 1
	intensity $22
	note D#, 1
	intensity $12
	note F#, 1
	intensity $22
	note E_, 1
	intensity $12
	note E_, 1
	intensity $22
	note D#, 1
	intensity $12
	note C#, 1
	intensity $22
	octave 4
	note A#, 1
	intensity $12
	note F#, 1
	intensity $22
	note F#, 1
	intensity $12
	note E_, 1
	intensity $22
	note A_, 1
	intensity $12
	note C_, 1
	intensity $22
	octave 5
	note C_, 1
	intensity $12
	octave 4
	note F#, 1
	intensity $22
	octave 5
	note E_, 1
	intensity $12
	octave 4
	note A#, 1
	intensity $22
	octave 5
	note C_, 1
	intensity $12
	note C_, 1
	intensity $22
	octave 4
	note A_, 1
	intensity $12
	octave 3
	note F#, 1
	intensity $22
	octave 4
	note F#, 1
	intensity $12
	note C_, 1
	intensity $22
	note A_, 1
	intensity $12
	note E_, 1
	intensity $22
	octave 5
	note C_, 1
	intensity $12
	octave 4
	note F#, 1
	intensity $22
	octave 5
	note E_, 1
	intensity $12
	octave 4
	note A_, 1
	intensity $22
	octave 5
	note C_, 1
	intensity $12
	octave 4
	note F#, 1
	intensity $22
	note A_, 1
	; measure 3
	octave 3
	intensity $12
	note E_, 1
	octave 4
	intensity $22
	note E_, 1
	intensity $12
	octave 3
	note B_, 1
	intensity $22
	octave 4
	note G_, 1
	octave 4
	intensity $12
	note D#, 1
	intensity $22
	note B_, 1
	intensity $12
	note E_, 1
	intensity $22
	octave 5
	note D#, 1
	intensity $12
	octave 4
	note G_, 1
	intensity $22
	note B_, 1
	intensity $12
	note B_, 1
	intensity $22
	note G_, 1
	octave 5
	intensity $12
	note D#, 1
	intensity $22
	octave 4
	note E_, 1
	intensity $12
	octave 5
	note E_, 1
	intensity $22
	octave 4
	note G_, 1
	intensity $12
	octave 5
	note G_, 1
	intensity $22
	octave 5
	note B_, 1
	intensity $12
	octave 5
	note E_, 1
	intensity $22
	note D#, 1
	intensity $12
	note D#, 1
	intensity $22
	octave 4
	note B_, 1
	intensity $12
	note B_, 1
	intensity $22
	note G_, 1
	intensity $12
	note G_, 1
	intensity $22
	note E_, 1
	intensity $12
	note E_, 1
	intensity $22
	note G_, 1
	intensity $12
	note D#, 1
	intensity $22
	note A#, 1
	intensity $12
	note E_, 1
	intensity $22
	octave 5
	note E_, 1
	intensity $12
	octave 4
	note G_, 1
	intensity $22
	note A#, 1
	intensity $12
	note A#, 1
	intensity $22
	note G_, 1
	octave 3
	intensity $12
	note E_, 1
	intensity $22
	octave 4
	note E_, 1
	intensity $12
	octave 3
	note A#, 1
	intensity $22
	octave 4
	note G_, 1
	intensity $12
	note D#, 1
	intensity $22
	note B_, 1
	intensity $12
	octave 4
	note E_, 1
	intensity $22
	octave 5
	note D#, 1
	intensity $12
	octave 4
	note G_, 1
	intensity $22
	note B_, 1
	intensity $12
	note E_, 1
	intensity $22
	note G_, 1
	; measure 4
	octave 3
	intensity $12
	note D#, 1
	intensity $22
	octave 4
	note D#, 1
	intensity $12
	octave 3
	note A#, 1
	intensity $22
	octave 4
	note G_, 1
	intensity $12
	note C#, 1
	intensity $22
	note A#, 1
	intensity $12
	note E_, 1
	intensity $22
	octave 5
	note E_, 1
	intensity $12
	octave 4
	note G_, 1
	intensity $22
	note A#, 1
	intensity $12
	note A#, 1
	intensity $22
	note G_, 1
	octave 5
	intensity $12
	note C#, 1
	intensity $22
	octave 4
	note D#, 1
	intensity $12
	octave 5
	note E_, 1
	intensity $22
	octave 4
	note G_, 1
	intensity $12
	octave 5
	note G_, 1
	intensity $22
	octave 4
	note A#, 1
	intensity $12
	octave 5
	note E_, 1
	intensity $22
	note E_, 1
	intensity $12
	note C#, 1
	intensity $22
	octave 4
	note A#, 1
	intensity $12
	note A#, 1
	intensity $22
	note G_, 1
	intensity $12
	note G_, 1
	intensity $22
	note D#, 1
	intensity $12
	note D#, 1
	intensity $22
	note G_, 1
	intensity $12
	note C#, 1
	intensity $22
	note A#, 1
	intensity $12
	note D#, 1
	intensity $22
	octave 5
	note D#, 1
	intensity $12
	octave 4
	note G_, 1
	intensity $22
	note A#, 1
	octave 5
	intensity $12
	note C#, 1
	intensity $22
	octave 4
	note G_, 1
	octave 3
	intensity $12
	note E_, 1
	intensity $22
	octave 4
	note E_, 1
	intensity $12
	octave 3
	note A#, 1
	intensity $22
	octave 4
	note G_, 1
	intensity $12
	note E_, 1
	intensity $22
	note A#, 1
	intensity $12
	note G_, 1
	intensity $22
	octave 5
	note E_, 1
	intensity $12
	octave 4
	note A#, 1
	intensity $22
	note A#, 1
	octave 5
	intensity $12
	note E_, 1
	octave 4
	intensity $22
	note G_, 1
	loopchannel 2, Music_OreburghGateDPPt_Ch3_branch_2
	octave 5
	intensity $22
	note F#, 1
	note C#, 1
	note D_, 1
	octave 4
	note A#, 1
	octave 5
	note C#, 1
	octave 4
	note G_, 1
	note A#, 1
	note F#, 1
	note G_, 1
	note C#, 1
	note D_, 1
	octave 3
	note A#, 1
	octave 4
	note C#, 1
	octave 3
	note G_, 1
	note A#, 1
	note F#, 1
	note G_, 1
	note C#, 1
	note D_, 1
	octave 2
	note A#, 1
	octave 3
	note C#, 1
	octave 2
	note G_, 1
	note A#, 1
	note F#, 1
	octave 3
	intensity $15
	note G_, 1
	note __, 1
	note G_, 3
	note __, 1
	note G_, 1
	note __, 1
	note G_, 1
	note __, 1
	note G_, 3
	note __, 1
	intensity $25
	note G_, 1
	note __, 1
	note G_, 1
	note __, 1
	note G_, 3
	note __, 1
	note G_, 1
	note __, 1
	intensity $15
	note G#, 1
	note __, 1
	note G#, 3
	note __, 1
	note G#, 1
	note __, 1
	note G#, 1
	note __, 1
	note G#, 3
	note __, 1
	intensity $25
	note G#, 1
	note __, 1
	note G#, 1
	note __, 1
	note G#, 3
	note __, 1
	note G#, 1
	note __, 1
	intensity $15
	note A_, 1
	note __, 1
	note A_, 3
	note __, 1
	note A_, 1
	note __, 1
	note A_, 1
	note __, 1
	note A_, 3
	note __, 1
	intensity $25
	note A_, 1
	note __, 1
	note A_, 1
	note __, 1
	note A_, 3
	note __, 1
	note A_, 1
	note __, 1
	note A_, 1
	note __, 1
	note A_, 3
	note __, 1
	note A_, 1
	note __, 1
	note A_, 1
	note __, 1
	note A_, 3
	note __, 1
	intensity $35
	note A_, 1
	note __, 1
	note A_, 1
	note __, 1
	note A_, 3
	note __, 1
	note A_, 1
	note __, 1
	intensity $12
	note __, 12
	note __, 12
	loopchannel 0, Music_OreburghGateDPPt_Ch3_branch_1
