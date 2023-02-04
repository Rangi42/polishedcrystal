; Pokémon R/B/Y - Cerulean Cave
; Ported by FroggestSpirit
; https://github.com/froggestspirit/CrystalComplete/blob/master/audio/music/RBY/dungeon1.asm

Music_CeruleanCaveRBY:
	dbw $C0, Music_CeruleanCaveRBY_Ch1
	dbw $01, Music_CeruleanCaveRBY_Ch2
	dbw $02, Music_CeruleanCaveRBY_Ch3
	dbw $03, Music_CeruleanCaveRBY_Ch4

Music_CeruleanCaveRBY_Ch1:
	tempo 144
	volume 7, 7
	duty_cycle 3
	vibrato 10, 20
	note_type 12, 4, -5
	note __, 8
	octave 4
	note F#, 8

Music_CeruleanCaveRBY_branch_7dee5:
	note_type 12, 11, 2
	octave 3

Music_CeruleanCaveRBY_branch_7dee8:
	sound_call Music_CeruleanCaveRBY_branch_7dfaa
	sound_loop 3, Music_CeruleanCaveRBY_branch_7dee8
	note E_, 1
	note D#, 1
	note B_, 1
	note A#, 1
	note G_, 1
	note G#, 1
	note __, 1
	note A#, 1
	note E_, 1
	note D#, 1
	note B_, 1
	note A#, 1
	note G_, 1
	note G#, 1
	note A_, 1
	note A#, 1

Music_CeruleanCaveRBY_branch_7deff:
	sound_call Music_CeruleanCaveRBY_branch_7dfaa
	sound_loop 4, Music_CeruleanCaveRBY_branch_7deff
	sound_call Music_CeruleanCaveRBY_branch_7dfd5
	octave 3
	note G_, 1
	note F#, 1
	note E_, 1
	note G_, 1
	sound_call Music_CeruleanCaveRBY_branch_7dfd5
	octave 3
	note A_, 1
	note G_, 1
	note E_, 1
	note A_, 1
	sound_call Music_CeruleanCaveRBY_branch_7dfd5
	octave 3
	note B_, 1
	note A_, 1
	note G_, 1
	note F#, 1
	note_type 12, 12, 3
	note G_, 4
	note F#, 4
	note E_, 4
	note D#, 4
	note_type 12, 12, 2
	sound_call Music_CeruleanCaveRBY_branch_7dfc5
	octave 3
	note B_, 3
	sound_call Music_CeruleanCaveRBY_branch_7dfc5
	note C_, 3
	sound_call Music_CeruleanCaveRBY_branch_7dfc5
	note C#, 3
	note_type 12, 12, 3
	octave 3
	note G_, 4
	note F#, 4
	note E_, 4
	note D#, 4
	note E_, 4
	note D#, 4
	note C_, 4
	octave 2
	note B_, 4
	note_type 12, 12, 2
	note B_, 1
	note A#, 1
	note G_, 1
	note A#, 1
	note B_, 1
	note A#, 1
	note G_, 1
	note A#, 1
	octave 3
	note C_, 1
	octave 2
	note B_, 1
	note G#, 1
	note B_, 1
	octave 3
	note C_, 1
	octave 2
	note B_, 1
	note G#, 1
	note B_, 1
	octave 3
	note C#, 1
	note C_, 1
	octave 2
	note A_, 1
	octave 3
	note C_, 1
	note C#, 1
	note C_, 1
	octave 2
	note A_, 1
	octave 3
	note C_, 1
	note D_, 1
	note C#, 1
	octave 2
	note A#, 1
	octave 3
	note C#, 1
	note D_, 1
	note C#, 1
	octave 2
	note A#, 1
	octave 3
	note C#, 1

Music_CeruleanCaveRBY_branch_7df6e:
	note __, 16
	sound_loop 8, Music_CeruleanCaveRBY_branch_7df6e
	note_type 12, 12, 3
	sound_call Music_CeruleanCaveRBY_branch_7dfbb
	note B_, 2
	note G_, 2
	octave 3
	note C#, 4
	octave 2
	note G_, 2
	note A_, 4
	note F#, 2
	sound_call Music_CeruleanCaveRBY_branch_7dfbb
	note A#, 2
	note G_, 2
	note B_, 4
	note G_, 2
	note F#, 2
	note G_, 2
	note D#, 2
	note_type 12, 12, 2
	sound_call Music_CeruleanCaveRBY_branch_7dfc5
	octave 3
	note B_, 3
	sound_call Music_CeruleanCaveRBY_branch_7dfc5
	note C_, 3
	sound_call Music_CeruleanCaveRBY_branch_7dfc5
	note C#, 3
	note_type 12, 12, 7
	octave 3
	note F#, 8
	note D#, 8
	note_type 12, 12, 2
	sound_call Music_CeruleanCaveRBY_branch_7dfaa
	sound_call Music_CeruleanCaveRBY_branch_7dfaa
	sound_jump Music_CeruleanCaveRBY_branch_7dee5

Music_CeruleanCaveRBY_branch_7dfaa:
	note E_, 1
	note D#, 1
	note B_, 1
	note A#, 1
	note G_, 1
	note G#, 1
	note __, 1
	note A#, 1
	note E_, 1
	note D#, 1
	note B_, 1
	note A#, 1
	note G_, 1
	note G#, 1
	note __, 1
	note A#, 1
	endchannel

Music_CeruleanCaveRBY_branch_7dfbb:
	octave 2
	note G_, 2
	note A#, 4
	note G_, 2
	octave 3
	note C#, 4
	octave 2
	note G_, 2
	note A#, 2
	endchannel

Music_CeruleanCaveRBY_branch_7dfc5:
	octave 3
	note E_, 1
	note E_, 1
	note F_, 1
	note E_, 1
	note G_, 1
	note E_, 1
	note A_, 1
	note E_, 1
	note A#, 1
	note E_, 1
	note B_, 1
	note E_, 1
	octave 4
	note C_, 1
	endchannel

Music_CeruleanCaveRBY_branch_7dfd5:
	note E_, 1
	note E_, 1
	note __, 4
	octave 1
	note E_, 1
	note __, 3
	note E_, 1
	note __, 1
	endchannel

Music_CeruleanCaveRBY_Ch2:
	vibrato 11, 21
	duty_cycle 3
	note_type 12, 0, -7
	octave 4
	note G#, 8
	note_type 12, 4, -5
	octave 5
	note D_, 8

Music_CeruleanCaveRBY_branch_7dfeb:
	note_type 12, 12, 2

Music_CeruleanCaveRBY_branch_7dfed:
	sound_call Music_CeruleanCaveRBY_branch_7e097
	sound_loop 3, Music_CeruleanCaveRBY_branch_7dfed
	octave 2
	note E_, 1
	note E_, 1
	note B_, 1
	octave 3
	note C_, 1
	note __, 2
	note C_, 1
	octave 2
	note B_, 1
	note E_, 1
	note E_, 1
	note A_, 1
	note G_, 1
	note F_, 1
	note F#, 1
	note G_, 1
	note D#, 1

Music_CeruleanCaveRBY_branch_7e006:
	sound_call Music_CeruleanCaveRBY_branch_7e097
	sound_loop 4, Music_CeruleanCaveRBY_branch_7e006
	note __, 2
	sound_call Music_CeruleanCaveRBY_branch_7e0ab
	octave 3
	note C_, 4
	sound_call Music_CeruleanCaveRBY_branch_7e0ab
	octave 3
	note C#, 4
	sound_call Music_CeruleanCaveRBY_branch_7e0ab
	octave 3
	note D#, 4
	note_type 12, 13, 3
	octave 4
	note E_, 4
	note D#, 4
	note C_, 4
	octave 3
	note B_, 4
	note_type 12, 13, 2
	sound_call Music_CeruleanCaveRBY_branch_7e0b5
	octave 3
	note F#, 4
	sound_call Music_CeruleanCaveRBY_branch_7e0b5
	octave 3
	note G_, 4
	sound_call Music_CeruleanCaveRBY_branch_7e0b5
	octave 3
	note A#, 4
	note_type 12, 13, 3
	octave 4
	note E_, 4
	note D#, 4
	note C_, 4
	octave 3
	note B_, 4
	octave 4
	note C_, 4
	octave 3
	note B_, 4
	note G_, 4
	note F#, 2
	note_type 12, 13, 6
	note E_, 8
	note F_, 8
	note F#, 8
	note G_, 8
	note_type 12, 13, 2
	sound_call Music_CeruleanCaveRBY_branch_7e0ba
	note __, 10
	note E_, 1
	note __, 1
	sound_call Music_CeruleanCaveRBY_branch_7e0ba
	note __, 12
	sound_call Music_CeruleanCaveRBY_branch_7e0ba
	note __, 12
	sound_call Music_CeruleanCaveRBY_branch_7e0ba
	note __, 14
	note_type 12, 13, 3
	sound_call Music_CeruleanCaveRBY_branch_7e0cd
	note D#, 4
	sound_call Music_CeruleanCaveRBY_branch_7e0cd
	note D#, 2
	note __, 2
	note_type 12, 13, 2
	sound_call Music_CeruleanCaveRBY_branch_7e0c0
	note __, 2
	octave 3
	note F#, 4
	octave 2
	note E_, 1
	note E_, 1
	octave 3
	note B_, 1
	note __, 1
	octave 4
	note C_, 1
	note __, 1
	note C#, 1
	note __, 1
	note D_, 1
	note C#, 1
	note __, 2
	octave 3
	note G_, 4
	sound_call Music_CeruleanCaveRBY_branch_7e0c0
	octave 3
	note A#, 4
	note_type 12, 13, 6
	note B_, 8
	octave 4
	note D#, 8
	note_type 12, 13, 2
	sound_call Music_CeruleanCaveRBY_branch_7e097
	sound_call Music_CeruleanCaveRBY_branch_7e097
	sound_jump Music_CeruleanCaveRBY_branch_7dfeb

Music_CeruleanCaveRBY_branch_7e097:
	octave 2
	note E_, 1
	note E_, 1
	note B_, 1
	octave 3
	note C_, 1
	note __, 2
	note C_, 1
	octave 2
	note B_, 1
	note E_, 1
	note E_, 1
	note B_, 1
	octave 3
	note C_, 1
	note __, 2
	note C_, 1
	octave 2
	note B_, 1
	endchannel

Music_CeruleanCaveRBY_branch_7e0ab:
	octave 2
	note E_, 1
	note E_, 1
	note __, 2
	octave 1
	note E_, 1
	note __, 3
	note E_, 1
	note __, 3
	endchannel

Music_CeruleanCaveRBY_branch_7e0b5:
	octave 2
	note E_, 1
	note E_, 1
	note __, 10
	endchannel

Music_CeruleanCaveRBY_branch_7e0ba:
	octave 1
	note E_, 1
	note G_, 1
	note E_, 1
	note D#, 1
	endchannel

Music_CeruleanCaveRBY_branch_7e0c0:
	octave 2
	note E_, 1
	note E_, 1
	octave 4
	note E_, 1
	note __, 1
	note D#, 1
	note __, 1
	note D_, 1
	note __, 1
	note C#, 1
	note C_, 1
	endchannel

Music_CeruleanCaveRBY_branch_7e0cd:
	octave 3
	note E_, 6
	note G_, 6
	note E_, 4
	note A_, 6
	octave 4
	note C_, 6
	octave 3
	note B_, 4
	note G_, 6
	note A#, 6
	note F#, 4
	note E_, 6
	note F#, 6
	endchannel

Music_CeruleanCaveRBY_Ch3:
	note_type 12, 1, 1
	vibrato 8, 38
	note __, 14
	octave 4
	note D_, 1
	note D#, 1

Music_CeruleanCaveRBY_branch_7e0e5:
	sound_call Music_CeruleanCaveRBY_branch_7e140
	sound_call Music_CeruleanCaveRBY_branch_7e140
	octave 5
	note E_, 2
	note __, 4
	octave 3
	note E_, 1
	note __, 3
	note E_, 1
	note __, 1
	octave 4
	note F#, 4
	sound_call Music_CeruleanCaveRBY_branch_7e154
	octave 4
	note G_, 4
	sound_call Music_CeruleanCaveRBY_branch_7e154
	octave 4
	note A_, 4
	note B_, 4
	note A#, 4
	note G_, 4
	note F#, 4
	note __, 6
	sound_call Music_CeruleanCaveRBY_branch_7e177
	note B_, 4
	note A#, 4
	note G_, 4
	note F#, 4
	note G_, 4
	note F#, 4
	note E_, 4
	note D#, 4
	sound_call Music_CeruleanCaveRBY_branch_7e15e
	note __, 12
	sound_call Music_CeruleanCaveRBY_branch_7e15e
	note __, 12
	sound_call Music_CeruleanCaveRBY_branch_7e15e
	note __, 10
	note E_, 1
	note __, 1
	sound_call Music_CeruleanCaveRBY_branch_7e15e
	note __, 12
	sound_call Music_CeruleanCaveRBY_branch_7e15e
	note __, 12
	sound_call Music_CeruleanCaveRBY_branch_7e15e
	note __, 10
	note D_, 1
	note D#, 1
	sound_call Music_CeruleanCaveRBY_branch_7e164
	sound_call Music_CeruleanCaveRBY_branch_7e164
	note E_, 2
	note __, 4
	sound_call Music_CeruleanCaveRBY_branch_7e177
	note B_, 8
	note F#, 6
	note D_, 1
	note D#, 1
	note __, 16
	note __, 16
	sound_jump Music_CeruleanCaveRBY_branch_7e0e5

Music_CeruleanCaveRBY_branch_7e140:
	octave 5
	note E_, 4
	note B_, 4
	note A#, 4
	octave 6
	note D_, 4
	note C#, 4
	octave 5
	note G#, 4
	note G_, 4
	note B_, 4
	note A#, 4
	note E_, 4
	note D#, 4
	note A_, 4
	note G#, 4
	note E_, 4
	note F#, 4
	note D#, 4
	endchannel

Music_CeruleanCaveRBY_branch_7e154:
	octave 6
	note E_, 1
	note E_, 1
	note __, 4
	octave 3
	note E_, 1
	note __, 3
	note E_, 1
	note __, 1
	endchannel

Music_CeruleanCaveRBY_branch_7e15e:
	octave 3
	note E_, 1
	note G_, 1
	note E_, 1
	note D#, 1
	endchannel

Music_CeruleanCaveRBY_branch_7e164:
	note E_, 4
	note B_, 4
	note A#, 4
	octave 4
	note D_, 4
	note C#, 4
	octave 3
	note G#, 4
	note G_, 4
	note B_, 4
	note A#, 4
	note E_, 4
	note D#, 4
	note A_, 4
	note G#, 4
	note E_, 4
	note F#, 4
	note D#, 4
	endchannel

Music_CeruleanCaveRBY_branch_7e177:
	octave 4
	note E_, 1
	note __, 3
	note E_, 1
	note __, 1
	note F#, 4
	note __, 6
	note E_, 1
	note __, 3
	note E_, 1
	note __, 1
	note G_, 4
	note __, 6
	note E_, 1
	note __, 3
	note E_, 1
	note E_, 1
	note A#, 4
	endchannel

Music_CeruleanCaveRBY_Ch4:
	note_type 12
	toggle_noise 1
	note __, 14
	note E_, 1
	note E_, 1

Music_CeruleanCaveRBY_branch_7e190:
	sound_call Music_CeruleanCaveRBY_branch_7e1f1
	sound_loop 3, Music_CeruleanCaveRBY_branch_7e190
	note F_, 4
	note E_, 4
	note F_, 4
	note E_, 2
	note E_, 2

Music_CeruleanCaveRBY_branch_7e1a1:
	sound_call Music_CeruleanCaveRBY_branch_7e1f1
	sound_loop 3, Music_CeruleanCaveRBY_branch_7e1a1
	note F_, 4
	note E_, 4
	note F_, 4
	note F_, 4

Music_CeruleanCaveRBY_branch_7e1b0:
	sound_call Music_CeruleanCaveRBY_branch_7e1fa
	sound_loop 3, Music_CeruleanCaveRBY_branch_7e1b0
	sound_call Music_CeruleanCaveRBY_branch_7e202

Music_CeruleanCaveRBY_branch_7e1ba:
	sound_call Music_CeruleanCaveRBY_branch_7e1fa
	sound_loop 3, Music_CeruleanCaveRBY_branch_7e1ba
	sound_call Music_CeruleanCaveRBY_branch_7e202
	note C#, 4
	note D_, 4
	note D_, 4
	note __, 2
	note C#, 2
	note F_, 4

Music_CeruleanCaveRBY_branch_7e1cf:
	note __, 16
	sound_loop 13, Music_CeruleanCaveRBY_branch_7e1cf
	note __, 12

Music_CeruleanCaveRBY_branch_7e1d5:
	sound_call Music_CeruleanCaveRBY_branch_7e1fa
	sound_loop 3, Music_CeruleanCaveRBY_branch_7e1d5
	note E_, 4
	note E_, 4
	note E_, 4
	note __, 2
	note E_, 1
	note E_, 1
	sound_call Music_CeruleanCaveRBY_branch_7e1f1
	sound_call Music_CeruleanCaveRBY_branch_7e1f1
	sound_jump Music_CeruleanCaveRBY_branch_7e190

Music_CeruleanCaveRBY_branch_7e1f1:
	note F_, 4
	note E_, 4
	note F_, 4
	note E_, 4
	endchannel

Music_CeruleanCaveRBY_branch_7e1fa:
	note E_, 1
	note E_, 1
	note __, 10
	note F#, 4
	endchannel

Music_CeruleanCaveRBY_branch_7e202:
	note C#, 4
	note D_, 4
	note D_, 4
	note D#, 4
	endchannel
