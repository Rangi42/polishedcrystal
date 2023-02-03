; Pokémon HG/SS - Battle! Ho-Oh
; Demixed by Pigu
; https://github.com/TwitchPlaysPokemon/tppcrystal251pub/blob/public/audio/music/custom/hoohbattle.asm
; https://pigu-a.bandcamp.com/album/pok-mon-anniversary-crystal-pigus-arranges

Music_HoOhBattleHGSS:
	dbw $80, Music_HoOhBattleHGSS_Ch1
	dbw $01, Music_HoOhBattleHGSS_Ch2
	dbw $02, Music_HoOhBattleHGSS_Ch3

Music_HoOhBattleHGSS_Ch1:
	tempo $6a
	duty_cycle 3
	note_type 12, 12, 2
	octave 3
	note B_, 1
	note A#, 1
	note A_, 1
	note G#, 1
	note A_, 1
	note G#, 1
	note G_, 1
	note F#, 1
	note G_, 1
	note F#, 1
	note F_, 1
	note E_, 1
	note F_, 1
	note E_, 1
	note D#, 1
	note D_, 1
	note D#, 1
	note D_, 1
	note C#, 1
	note C_, 1
	note C#, 1
	note C_, 1
	octave 2
	note B_, 1
	note A#, 1
	note B_, 1
	note A#, 1
	note A_, 1
	note G#, 1
	note A_, 1
	note A#, 1
	note B_, 1
	octave 3
	note C_, 1
Music_HoOhBattleHGSS_Ch1_L:
	volume_envelope 12, 2
	octave 2
	note B_, 2
	note B_, 4
	note B_, 4
	note B_, 4
	volume_envelope 12, 7
	note B_, 6
	note A_, 6
	octave 3
	note C_, 6
	loopchannel 3, Music_HoOhBattleHGSS_Ch1_L
	volume_envelope 12, 2
	octave 2
	note B_, 2
	note B_, 4
	note B_, 4
	note B_, 4
	volume_envelope 12, 7
	note B_, 6
	note A_, 4
	volume_envelope 12, 2
	octave 3
	note E_, 1
	note D_, 1
	octave 2
	note B_, 1
	note E_, 1
	octave 3
	note C_, 1
	octave 2
	note A_, 1
	octave 3
	note D#, 1
	octave 2
	note B_, 1
	volume_envelope 12, 8
	octave 3
	pitch_sweep 3, 7
	note D_, 1
	volume_envelope 12, 7
	pitch_sweep 0, 0
	note E_, 11
	note D_, 2
	note E_, 2
	volume_envelope 12, 8
	pitch_sweep 3, 7
	note D_, 1
	volume_envelope 12, 7
	pitch_sweep 0, 0
	note E_, 11
	note D_, 2
	note E_, 2
	volume_envelope 12, 8
	pitch_sweep 4, 7
	note G_, 1
	volume_envelope 12, 7
	pitch_sweep 0, 0
	note A_, 11
	volume_envelope 12, 8
	pitch_sweep 5, 7
	note A_, 1
	volume_envelope 12, 7
	pitch_sweep 0, 0
	note B_, 3
	note E_, 12
	note D_, 2
	note F_, 2
	volume_envelope 12, 8
	pitch_sweep 3, 7
	note D_, 1
	volume_envelope 12, 7
	pitch_sweep 0, 0
	note E_, 11
	note F_, 2
	note D_, 2
	volume_envelope 12, 8
	pitch_sweep 3, 7
	note D_, 1
	volume_envelope 12, 7
	pitch_sweep 0, 0
	note E_, 11
	note D_, 2
	note E_, 2
	volume_envelope 12, 8
	pitch_sweep 3, 7
	note D_, 1
	volume_envelope 12, 7
	pitch_sweep 0, 0
	note E_, 15
	volume_envelope 12, 2
	octave 2
	note B_, 1
	note E_, 1
	note A_, 1
	note E_, 1
	note B_, 1
	note E_, 1
	octave 3
	note F_, 1
	octave 2
	note E_, 1
	octave 3
	note E_, 1
	octave 2
	note E_, 1
	octave 3
	note A#, 1
	octave 4
	note C#, 1
	octave 3
	note A_, 1
	note A#, 1
	note E_, 1
	octave 2
	note B_, 1
	volume_envelope 12, 8
	octave 3
	pitch_sweep 3, 7
	note D_, 1
	volume_envelope 12, 7
	pitch_sweep 0, 0
	note E_, 11
	note D_, 2
	note E_, 2
	volume_envelope 12, 8
	pitch_sweep 3, 7
	note D_, 1
	volume_envelope 12, 7
	pitch_sweep 0, 0
	note E_, 11
	note D_, 2
	note E_, 2
	volume_envelope 12, 8
	pitch_sweep 4, 7
	note G_, 1
	volume_envelope 12, 7
	pitch_sweep 0, 0
	note A_, 11
	volume_envelope 12, 8
	pitch_sweep 5, 7
	note A_, 1
	volume_envelope 12, 7
	pitch_sweep 0, 0
	note B_, 3
	octave 4
	note D_, 10
	octave 3
	note B_, 2
	note F_, 2
	note A_, 2
	volume_envelope 12, 8
	pitch_sweep 4, 7
	note F#, 1
	volume_envelope 12, 7
	pitch_sweep 0, 0
	note G#, 9
	note B_, 2
	note E_, 2
	note A_, 2
	volume_envelope 12, 8
	pitch_sweep 3, 7
	note D#, 1
	volume_envelope 12, 7
	pitch_sweep 0, 0
	note F_, 9
	note A_, 2
	note D_, 2
	note F_, 2
	volume_envelope 12, 8
	pitch_sweep 3, 7
	note D_, 1
	volume_envelope 12, 7
	pitch_sweep 0, 0
	note E_, 9
	note E_, 2
	note F_, 2
	note D_, 2
	volume_envelope 12, 8
	pitch_sweep 3, 7
	note D_, 1
	volume_envelope 12, 7
	pitch_sweep 0, 0
	note E_, 7
	note_type 8, 11, 7
	vibrato $7, $26
	octave 4
	note D_, 2
	note F_, 2
	note A_, 2
	note B_, 2
	octave 5
	note D_, 2
	note D#, 2
	note_type 12, 11, 7
	note E_, 1
	note F_, 1
	note E_, 12
	note F_, 2
	note D_, 2
	note E_, 2
	octave 4
	note B_, 2
	octave 5
	note D_, 2
	octave 4
	note A_, 2
	note B_, 2
	note D_, 2
	note E_, 2
	note F#, 2
	note A_, 2
	volume_envelope 12, 8
	vibrato $0, $0
	octave 5
	note D_, 8
	volume_envelope 11, 7
	vibrato $7, $26
	note D_, 12
	octave 4
	note B_, 1
	note A_, 1
	note F_, 1
	note D_, 1
	octave 3
	note B_, 1
	note A_, 1
	note F_, 1
	note D_, 1
	octave 5
	note E_, 1
	note F_, 1
	note E_, 8
	note F_, 2
	note D_, 2
	note E_, 2
	octave 4
	note B_, 8
	octave 5
	note D_, 2
	note E_, 2
	octave 4
	note B_, 2
	octave 5
	note D_, 2
	octave 4
	note A_, 2
	note B_, 2
	octave 5
	note D_, 4
	volume_envelope 12, 8
	vibrato $0, $0
	note E_, 8
	volume_envelope 11, 7
	vibrato $7, $26
	note E_, 16
	volume_envelope 12, 7
	vibrato $0, $0
	octave 4
	note E_, 1
	note F_, 1
	note E_, 12
	note F_, 2
	note D_, 2
	note E_, 2
	octave 3
	note B_, 2
	octave 4
	note D_, 2
	octave 3
	note A_, 2
	note B_, 2
	note D_, 2
	note E_, 2
	note F#, 2
	note A_, 2
	volume_envelope 12, 8
	octave 4
	note D_, 8
	volume_envelope 12, 7
	note D_, 12
	octave 3
	note B_, 1
	note A_, 1
	note F_, 1
	note D_, 1
	octave 2
	note B_, 1
	note A_, 1
	note F_, 1
	note D_, 1
	octave 4
	note E_, 1
	note F_, 1
	note E_, 8
	note F_, 2
	note D_, 2
	note E_, 2
	octave 3
	note B_, 12
	note A_, 2
	note B_, 2
	note A_, 2
	note B_, 2
	octave 4
	note D_, 4
	volume_envelope 12, 8
	note E_, 8
	volume_envelope 12, 7
	note E_, 16
	octave 2
	note E_, 4
	volume_envelope 12, 8
	note A_, 2
	volume_envelope 12, 7
	pitch_sweep 6, -7
	note A_, 2
	pitch_sweep 0, 0
	note G_, 2
	note A_, 2
	volume_envelope 12, 8
	octave 3
	note C_, 2
	volume_envelope 12, 7
	pitch_sweep 6, -7
	note C_, 2
	octave 2
	pitch_sweep 0, 0
	note A_, 2
	octave 3
	note C_, 2
	volume_envelope 12, 8
	note D_, 2
	volume_envelope 12, 7
	pitch_sweep 6, -7
	note D_, 2
	pitch_sweep 0, 0
	note C_, 2
	note D_, 2
	volume_envelope 12, 8
	note G_, 2
	volume_envelope 12, 7
	pitch_sweep 6, -7
	note G_, 2
	pitch_sweep 0, 0
	note E_, 2
	note __, 16
	note __, 14
	octave 2
	note E_, 4
	volume_envelope 12, 8
	note A_, 2
	volume_envelope 12, 7
	pitch_sweep 6, -7
	note A_, 2
	pitch_sweep 0, 0
	note G_, 2
	note A_, 2
	octave 3
	volume_envelope 12, 8
	note C_, 2
	volume_envelope 12, 7
	pitch_sweep 6, -7
	note C_, 2
	octave 2
	pitch_sweep 0, 0
	note A_, 2
	octave 3
	note C_, 2
	note D_, 1
	note C_, 1
	octave 2
	note A_, 2
	octave 3
	note C_, 2
	note D_, 2
	volume_envelope 12, 8
	note G_, 2
	volume_envelope 12, 7
	pitch_sweep 6, -7
	note G_, 2
	pitch_sweep 0, 0
	note E_, 2
	note __, 16
	note __, 14
	duty_cycle 0
	volume_envelope 12, 4
	vibrato $1, $25
	octave 2
	note E_, 2
	note E_, 6
	volume_envelope 9, 3
	note E_, 1
	note E_, 1
	note E_, 2
	note E_, 1
	note E_, 1
	note E_, 2
	volume_envelope 12, 4
	note E_, 1
	volume_envelope 9, 3
	note E_, 1
	volume_envelope 12, 4
	note E_, 2
	note E_, 1
	volume_envelope 9, 3
	note E_, 1
	volume_envelope 12, 4
	note E_, 2
	note E_, 1
	note E_, 1
	note E_, 2
	note E_, 1
	note E_, 1
	note E_, 2
	duty_cycle 3
	volume_envelope 12, 8
	vibrato $0, $0
	octave 3
	pitch_sweep 4, 7
	note D_, 1
	volume_envelope 12, 7
	pitch_sweep 0, 0
	note E_, 3
	note D_, 2
	note E_, 2
	note __, 2
	note G_, 2
	note A_, 2
	octave 2
	note B_, 2
	volume_envelope 12, 8
	octave 3
	pitch_sweep 4, 7
	note D_, 1
	volume_envelope 12, 7
	pitch_sweep 0, 0
	note E_, 3
	note D_, 2
	note E_, 2
	note __, 2
	note G_, 2
	note A_, 4
	volume_envelope 12, 8
	note A#, 16
	volume_envelope 12, 7
	note A#, 16
	jumpchannel Music_HoOhBattleHGSS_Ch1_L

Music_HoOhBattleHGSS_Ch2:
	duty_cycle 3
	note_type 12, 12, 2
	octave 4
	note E_, 1
	note D#, 1
	note D_, 1
	octave 5
	note E_, 1
	octave 4
	note E_, 1
	note D#, 1
	note D_, 1
	octave 5
	note E_, 1
	octave 4
	note E_, 1
	note D#, 1
	note D_, 1
	octave 5
	note E_, 1
	octave 4
	note E_, 1
	note D#, 1
	note D_, 1
	octave 5
	note E_, 1
	octave 4
	note E_, 1
	note D#, 1
	note D_, 1
	octave 5
	note E_, 1
	octave 4
	note E_, 1
	note D#, 1
	note D_, 1
	octave 5
	note E_, 1
	octave 4
	note E_, 1
	note D#, 1
	note D_, 1
	octave 5
	note E_, 1
	octave 4
	note E_, 1
	note D#, 1
	note D_, 1
	octave 5
	note E_, 1
Music_HoOhBattleHGSS_Ch2_L:
	volume_envelope 12, 2
	octave 3
	note E_, 2
	note E_, 4
	note E_, 4
	note E_, 4
	volume_envelope 12, 7
	note E_, 6
	note D_, 6
	note F_, 6
	loopchannel 3, Music_HoOhBattleHGSS_Ch2_L
	volume_envelope 12, 2
	note E_, 2
	note E_, 4
	note E_, 4
	note E_, 4
	volume_envelope 12, 7
	note E_, 6
	note D_, 6
	note F_, 4
	duty_cycle 0
	volume_envelope 12, 4
	vibrato $1, $25
	octave 2
	note E_, 2
	note E_, 14
	note E_, 2
	note E_, 4
	note D_, 2
	note E_, 6
	note E_, 2
	note E_, 2
	note E_, 4
	note D_, 2
	note E_, 12
	note E_, 8
	note E_, 2
	note E_, 2
	note E_, 2
	note E_, 14
	note E_, 2
	note E_, 4
	note D_, 2
	note E_, 6
	note E_, 2
	note E_, 2
	note E_, 2
	note E_, 2
	note D_, 2
	note E_, 4
	note D_, 2
	note E_, 4
	note D_, 2
	note E_, 4
	note D_, 2
	note E_, 4
	note E_, 2
	octave 1
	note B_, 2
	octave 2
	note E_, 14
	note E_, 2
	note E_, 4
	note D_, 2
	note E_, 6
	note E_, 2
	note E_, 2
	note E_, 4
	note D_, 2
	note E_, 12
	note E_, 8
	note E_, 2
	note E_, 2
	note E_, 2
	note E_, 14
	note E_, 2
	note E_, 4
	note D_, 2
	note E_, 6
	note E_, 2
	note E_, 2
	note E_, 4
	note D_, 2
	note E_, 12
	note E_, 8
	note E_, 2
	note E_, 2
	note E_, 2
	duty_cycle 2
	volume_envelope 9, 3
	vibrato $0, $0
	octave 4
	note E_, 2
	octave 5
	note E_, 2
	note D_, 2
	octave 4
	note A_, 2
	note B_, 2
	note A_, 2
	note E_, 2
	note F_, 2
	note E_, 2
	note F_, 2
	note D_, 2
	octave 3
	note A_, 2
	note F#, 2
	octave 4
	note D_, 2
	octave 3
	note D_, 2
	note A_, 2
	note F#, 2
	octave 4
	note E_, 2
	note D_, 2
	octave 3
	note A_, 2
	note B_, 2
	note A_, 2
	note F#, 2
	note D_, 2
	octave 5
	note D_, 2
	octave 4
	note A_, 2
	note B_, 2
	note F#, 2
	note F#, 1
	note E_, 1
	note C_, 1
	octave 3
	note A_, 1
	note F#, 1
	note E_, 1
	octave 4
	note B_, 2
	note E_, 2
	octave 5
	note E_, 2
	note D_, 2
	octave 4
	note A_, 2
	note B_, 2
	note A_, 2
	note F_, 2
	note D_, 2
	octave 3
	note B_, 2
	octave 4
	note F_, 2
	note E_, 2
	note D_, 2
	octave 3
	note B_, 2
	octave 5
	note E_, 2
	note D_, 2
	octave 4
	note B_, 2
	octave 3
	note D_, 2
	octave 4
	note E_, 2
	note D_, 2
	octave 3
	note A_, 2
	note B_, 2
	note A_, 2
	note F#, 2
	note D_, 6
	duty_cycle 3
	volume_envelope 11, 7
	vibrato $7, $26
	octave 5
	note F_, 2
	note D_, 2
	note E_, 8
	duty_cycle 0
	volume_envelope 9, 3
	vibrato $1, $25
	octave 3
	note E_, 2
	octave 4
	note E_, 2
	note D_, 2
	octave 3
	note A_, 2
	note B_, 2
	note A_, 2
	note E_, 2
	note F_, 2
	note E_, 2
	note F_, 2
	note D_, 2
	octave 2
	note A_, 2
	note F#, 2
	octave 3
	note D_, 2
	octave 2
	note D_, 2
	note A_, 2
	note F#, 2
	octave 3
	note E_, 2
	note D_, 2
	octave 2
	note A_, 2
	note B_, 2
	note A_, 2
	note F#, 2
	note D_, 2
	octave 4
	note D_, 2
	octave 3
	note A_, 2
	note B_, 2
	note F#, 2
	note F#, 1
	note E_, 1
	note C_, 1
	octave 2
	note A_, 1
	note F#, 1
	note E_, 1
	octave 3
	note B_, 2
	note E_, 2
	octave 4
	note E_, 2
	note D_, 2
	octave 3
	note A_, 2
	note B_, 2
	note A_, 2
	note F_, 2
	note D_, 2
	octave 2
	note B_, 2
	octave 3
	note F_, 2
	note E_, 2
	note D_, 2
	octave 2
	note B_, 2
	octave 4
	note E_, 2
	note D_, 2
	octave 3
	note B_, 2
	octave 2
	note D_, 2
	octave 3
	note E_, 2
	note D_, 2
	octave 2
	note A_, 2
	note B_, 2
	note A_, 2
	note F#, 2
	note D_, 2
	octave 3
	note E_, 2
	octave 4
	note E_, 2
	note D_, 2
	octave 3
	note B_, 2
	note A_, 2
	note B_, 2
	note A_, 2
	note G_, 2
	note __, 16
	note __, 16
	note __, 1
	volume_envelope 12, 4
	note D_, 1
	note E_, 4
	octave 2
	note A_, 2
	octave 3
	note D_, 2
	note E_, 2
	note C_, 2
	octave 2
	note A_, 2
	note E_, 2
	octave 3
	note D_, 2
	note E_, 1
	note D_, 1
	octave 2
	note A_, 2
	note G_, 2
	note A_, 2
	note D_, 1
	note E_, 1
	note G_, 2
	note __, 16
	note __, 16
	octave 3
	note A_, 1
	note G_, 1
	note A_, 2
	note A_, 2
	octave 2
	note A_, 2
	octave 3
	note E_, 2
	note G_, 2
	note C_, 2
	octave 2
	note A_, 2
	octave 3
	note C_, 2
	note G_, 2
	note E_, 1
	note D_, 1
	octave 2
	note A_, 2
	note G_, 2
	note A_, 2
	note D_, 1
	note E_, 1
	note G_, 2
	note B_, 2
	note B_, 6
	volume_envelope 9, 3
	note B_, 1
	note B_, 1
	note B_, 2
	note B_, 1
	note B_, 1
	note B_, 2
	volume_envelope 12, 4
	note B_, 1
	volume_envelope 9, 3
	note B_, 1
	volume_envelope 12, 4
	note B_, 2
	note B_, 1
	volume_envelope 9, 3
	note B_, 1
	volume_envelope 12, 4
	note B_, 2
	note B_, 1
	note B_, 1
	note B_, 2
	note B_, 1
	note B_, 1
	note B_, 2
	note __, 16
	note __, 16
	duty_cycle 3
	volume_envelope 12, 8
	vibrato $0, $0
	octave 3
	note F_, 16
	volume_envelope 12, 7
	note F_, 16
	jumpchannel Music_HoOhBattleHGSS_Ch2_L

Music_HoOhBattleHGSS_Ch3:
	note_type 12, 1, 6
	octave 2
	note E_, 16
	note D_, 8
	note F_, 8
Music_HoOhBattleHGSS_Ch3_L:
	octave 1
	note B_, 2
	octave 2
	note E_, 2
	loopchannel 93, Music_HoOhBattleHGSS_Ch3_L
	note F_, 2
	note D_, 2
	note E_, 2
	note F_, 2
	note E_, 2
	note D_, 2
	note F_, 14
	octave 3
	note E_, 2
	octave 2
	note F_, 2
	note __, 2
	note E_, 2
	note __, 2
	note B_, 6
	note A_, 2
	note F#, 2
	note D_, 12
	note F#, 1
	note __, 1
	note F#, 2
	note __, 2
	note D_, 8
	note __, 4
	note D_, 1
	note __, 1
	note D_, 6
	note __, 4
	note D_, 2
	note __, 2
	note D_, 2
	note __, 2
	octave 3
	note D_, 4
	octave 2
	note B_, 4
	note A_, 4
	note __, 2
	note E_, 6
	note __, 4
	note E_, 1
	note __, 1
	note E_, 2
	octave 3
	note D_, 2
	octave 2
	note E_, 1
	note __, 1
	note E_, 2
	note B_, 2
	note E_, 2
	note B_, 2
	note G_, 2
	note E_, 2
	note F_, 2
	note B_, 2
	note F_, 2
	note B_, 2
	note F_, 2
	note B_, 2
	note F_, 2
	note B_, 2
	note F_, 2
	note B_, 2
	note F_, 2
	note B_, 2
	note F_, 2
	note B_, 2
	note A_, 2
	note F#, 2
	note D_, 2
	note A_, 2
	note D_, 2
	note A_, 2
	note D_, 2
	note A_, 2
	note D_, 2
	note A_, 2
	note D_, 2
	note A_, 2
	note D_, 2
	note A_, 2
	note D_, 2
	note A_, 2
	note F#, 2
	note E_, 2
	note F_, 2
	note B_, 2
	note F_, 2
	note B_, 2
	note F_, 2
	note B_, 2
	note F_, 2
	note B_, 2
	note F_, 2
	note B_, 2
	note F_, 2
	note B_, 2
	note F_, 2
	note B_, 2
	note A_, 2
	note F#, 2
	note E_, 2
	note B_, 2
	note E_, 2
	note B_, 2
	note E_, 2
	note B_, 2
	note E_, 2
	note B_, 2
	note E_, 2
	note B_, 2
	note E_, 2
	note B_, 2
	note E_, 2
	note B_, 2
	note F#, 2
	note D_, 2
Music_HoOhBattleHGSS_Ch3_L1:
	octave 1
	note A_, 2
	octave 2
	note E_, 2
	octave 1
	note A_, 2
	octave 2
	note E_, 2
	octave 1
	note A_, 2
	octave 2
	note E_, 2
	octave 1
	note A_, 2
	octave 2
	note E_, 2
	octave 1
	note A_, 2
	octave 2
	note E_, 2
	octave 1
	note A_, 2
	octave 2
	note E_, 2
	octave 1
	note A_, 2
	octave 2
	note E_, 2
	octave 1
	note A_, 2
	octave 2
	note E_, 2
	octave 1
	note A_, 2
	octave 2
	note E_, 2
	octave 1
	note A_, 2
	octave 2
	note E_, 2
	octave 1
	note A_, 2
	octave 2
	note E_, 2
	octave 1
	note A_, 2
	octave 2
	note E_, 2
	octave 1
	note A_, 2
	octave 2
	note E_, 2
	octave 1
	note A_, 2
	octave 2
	note E_, 2
	octave 1
	note G_, 2
	octave 2
	note D_, 2
	octave 1
	note G_, 2
	octave 2
	note D_, 2
	loopchannel 2, Music_HoOhBattleHGSS_Ch3_L1
	note F_, 4
	note B_, 4
	note F_, 4
	note B_, 4
	note F_, 4
	note B_, 4
	octave 3
	note E_, 4
	octave 2
	note B_, 4
	note E_, 4
	note D_, 2
	note E_, 2
	note __, 2
	note G_, 2
	note A_, 2
	octave 1
	note B_, 2
	octave 2
	note E_, 4
	note D_, 2
	note E_, 2
	note __, 2
	note G_, 2
	note A_, 4
	note A#, 16
	note A#, 10
	note G_, 2
	note A_, 2
	note E_, 2
	jumpchannel Music_HoOhBattleHGSS_Ch3_L
