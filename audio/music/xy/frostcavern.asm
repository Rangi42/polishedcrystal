; Pokémon X/Y - Frost Cavern
; Demixed by Mmmmmm
; https://pastebin.com/raw/eMuPLjSZ
; https://hax.iimarckus.org/topic/6777/8/

Music_FrostCavernXY:
	channel_count 3
	channel 1, Music_FrostCavernXY_Ch1
	channel 2, Music_FrostCavernXY_Ch2
	channel 3, Music_FrostCavernXY_Ch3

Music_FrostCavernXY_Ch1:
	tempo 152
	volume 7, 7
	vibrato $6, $23
	note_type 12, 9, 2
	duty_cycle 0
	octave 3
	note __, 2
	note F_, 2
	note G_, 4
	note A#, 4
	note F_, 2
	note G_, 4
	note F_, 2
	note G_, 4
	note A#, 4
	note F_, 2
	note G_, 4
	note F_, 2
	note G_, 4
	note A#, 4
	note F_, 2
	note G_, 4
	octave 4
	note C_, 2
	note C_, 12
	duty_cycle 3
	volume_envelope 7, 7
	octave 5
	note C_, 6
	octave 4
	note G_, 6
	note A#, 6
	note F_, 6
	note G_, 4
	note A#, 4
	octave 5
	note C_, 6
	octave 4
	note G_, 6
	note A#, 6
	note F_, 14
Music_FrostCavernXY_Ch1_loop_1:
	duty_cycle 0
	volume_envelope 11, 2
	octave 5
	note C_, 4
	octave 4
	note G_, 4
	note A#, 4
	note F_, 2
	note G_, 4
	octave 5
	note C_, 2
	octave 4
	note G_, 4
	note A#, 4
	note F_, 2
	note G_, 4
	octave 5
	note C_, 2
	octave 4
	note G_, 4
	note A#, 4
	note F_, 2
	note G_, 4
	note G#, 2
	note G#, 12
	loopchannel 2, Music_FrostCavernXY_Ch1_loop_1
	jumpchannel Music_FrostCavernXY_Ch1

Music_FrostCavernXY_Ch2:
	vibrato $8, $24
	note_type 12, 11, 2
	duty_cycle 2
	octave 3
	note C_, 2
	note A#, 2
	octave 4
	note C_, 2
	octave 3
	note C_, 2
	octave 4
	note D#, 2
	octave 3
	note C_, 2
	note A#, 2
	octave 4
	note C_, 2
	octave 3
	note C_, 2
	note A#, 2
	octave 4
	note C_, 2
	octave 3
	note C_, 2
	octave 4
	note D#, 2
	octave 3
	note C_, 2
	note A#, 2
	octave 4
	note C_, 2
	octave 3
	note C_, 2
	note A#, 2
	octave 4
	note C_, 2
	octave 3
	note C_, 2
	octave 4
	note D#, 2
	octave 3
	note C_, 2
	note A#, 2
	octave 4
	note C_, 2
	octave 3
	note C_, 2
	octave 4
	note F_, 2
	note F_, 2
	octave 3
	note C_, 4
	note C_, 4
	note C_, 2
	jumpchannel Music_FrostCavernXY_Ch2

Music_FrostCavernXY_Ch3:
	vibrato $16, $15
	note_type 12, 2, 0
	note __, 16
Music_FrostCavernXY_Ch3_loop_main:
	note __, 16
	note __, 16
	note __, 16
	note __, 2
Music_FrostCavernXY_Ch3_loop_1:
	octave 4
	note C_, 2
	note D#, 2
	note G_, 4
	note C_, 2
	note D#, 2
	note F_, 4
	note C_, 2
	note D#, 2
	note F_, 4
	octave 3
	note A#, 2
	octave 4
	note C_, 2
	note D#, 4
	loopchannel 6, Music_FrostCavernXY_Ch3_loop_1
	note D#, 6
	volume_envelope 3, 0
	note D#, 4
	volume_envelope 2, 0
	note __, 4
	jumpchannel Music_FrostCavernXY_Ch3_loop_main
