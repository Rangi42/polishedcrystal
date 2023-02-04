; Pokémon B2/W2 - Hidden Grotto
; Demixed by Mmmmmm
; https://pastebin.com/gde9CFXP
; http://picosong.com/wkT7C/

Music_HiddenGrottoB2W2:
	channel_count 4
	channel 1, Music_HiddenGrottoB2W2_Ch1
	channel 2, Music_HiddenGrottoB2W2_Ch2
	channel 3, Music_HiddenGrottoB2W2_Ch3
	channel 4, Music_HiddenGrottoB2W2_Ch4

Music_HiddenGrottoB2W2_Ch1:
	duty_cycle 2
	vibrato $12, $15
	tempo 188
	note_type 12, 9, 2
	octave 4
	note F#, 2
	note E_, 2
	note D_, 2
	note C_, 16
	note __, 2
	note C_, 2
	note F#, 16
	note __, 10
	note F#, 2
	note E_, 2
	note D_, 2
	note C_, 16
	note __, 3
	octave 3
	note G_, 16
	note __, 4
	octave 4
	note C_, 16
	note __, 4
	jumpchannel Music_HiddenGrottoB2W2_Ch1

Music_HiddenGrottoB2W2_Ch1_branch_1:
	octave 4
	note F#, 2
	note E_, 2
	note D_, 2
	note C_, 16
	note __, 2
	note C_, 2
	note F#, 16
	note __, 10
	note F#, 2
	note E_, 2
	note D_, 2
	note C_, 16
	note __, 3
	octave 3
	note G_, 16
	note __, 4
	octave 4
	note C_, 16
	note __, 4
	endchannel

Music_HiddenGrottoB2W2_Ch2:
	duty_cycle 2
	vibrato $12, $15
	note_type 6, 5, 2
	octave 4
	note __, 1
Music_HiddenGrottoB2W2_Ch2_loop:
	note_type 12, 5, 2
	note F#, 2
	note E_, 2
	note D_, 2
	note C_, 2
	note __, 16
	volume_envelope 5, 2
	note C_, 2
	note F#, 10
	note __, 16
	note F#, 2
	note E_, 2
	note D_, 2
	note C_, 6
	note __, 13
	octave 3
	note G_, 4
	note __, 16
	octave 4
	note C_, 4
	note __, 16
	jumpchannel Music_HiddenGrottoB2W2_Ch2_loop

Music_HiddenGrottoB2W2_Ch3:
	vibrato $12, $15
	note_type 12, 3, 5
	octave 3
	note D_, 2
	note C_, 2
	octave 2
	note A_, 2
	note G_, 2
	note __, 16
	note G_, 2
	octave 3
	note D_, 2
	note __, 16
	note __, 8
	note D_, 2
	note C_, 2
	octave 2
	note A_, 2
	note G_, 2
	note __, 16
	note __, 1
	note E_, 2
	note __, 16
	note __, 2
	note G_, 2
	note __, 16
	note __, 2
	jumpchannel Music_HiddenGrottoB2W2_Ch3

Music_HiddenGrottoB2W2_Ch4:
	note_type 6
	toggle_noise 5
Music_HiddenGrottoB2W2_Ch4_loop:
	note __, 16
	note __, 6
	note D#, 5
	note E_, 1
	note E_, 1
	note E_, 1
	note E_, 1
	note E_, 1
	note E_, 1
	note E_, 2
	note C_, 13
	note __, 8
	note __, 16
	note D#, 1
	note D#, 1
	note D#, 1
	note D#, 1
	note D#, 2
	note E_, 10
	note __, 16
	note __, 16
	note __, 8
	note D_, 1
	note D_, 1
	note D_, 1
	note D_, 1
	note D_, 2
	note D_, 3
	note D_, 3
	note D#, 8
	note __, 14
	note E_, 1
	note E_, 1
	note E_, 1
	note E_, 1
	note E_, 1
	note B_, 2
	note C_, 13
	note __, 16
	note __, 8
	note D#, 1
	note D#, 1
	note D#, 1
	note D#, 16
	note __, 9
	jumpchannel Music_HiddenGrottoB2W2_Ch4_loop
