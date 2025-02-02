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
	vibrato 18, 1, 5
	tempo 188
	note_type 12, 9, 2
	octave 4
	note F#, 2
	note E_, 2
	note D_, 2
	note C_, 16
	rest 2
	note C_, 2
	note F#, 16
	rest 10
	note F#, 2
	note E_, 2
	note D_, 2
	note C_, 16
	rest 3
	octave 3
	note G_, 16
	rest 4
	octave 4
	note C_, 16
	rest 4
	sound_jump Music_HiddenGrottoB2W2_Ch1

Music_HiddenGrottoB2W2_Ch2:
	duty_cycle 2
	vibrato 18, 1, 5
	note_type 6, 5, 2
	octave 4
	rest 1
Music_HiddenGrottoB2W2_Ch2_loop:
	note_type 12, 5, 2
	note F#, 2
	note E_, 2
	note D_, 2
	note C_, 2
	rest 16
	volume_envelope 5, 2
	note C_, 2
	note F#, 10
	rest 16
	note F#, 2
	note E_, 2
	note D_, 2
	note C_, 6
	rest 13
	octave 3
	note G_, 4
	rest 16
	octave 4
	note C_, 4
	rest 16
	sound_jump Music_HiddenGrottoB2W2_Ch2_loop

Music_HiddenGrottoB2W2_Ch3:
	vibrato 18, 1, 5
	note_type 12, 3, 5
	octave 3
	note D_, 2
	note C_, 2
	octave 2
	note A_, 2
	note G_, 2
	rest 16
	note G_, 2
	octave 3
	note D_, 2
	rest 16
	rest 8
	note D_, 2
	note C_, 2
	octave 2
	note A_, 2
	note G_, 2
	rest 16
	rest 1
	note E_, 2
	rest 16
	rest 2
	note G_, 2
	rest 16
	rest 2
	sound_jump Music_HiddenGrottoB2W2_Ch3

Music_HiddenGrottoB2W2_Ch4:
	drum_speed 6
	toggle_noise 5
Music_HiddenGrottoB2W2_Ch4_loop:
	rest 16
	rest 6
	drum_note 4, 5
	drum_note 5, 1
	drum_note 5, 1
	drum_note 5, 1
	drum_note 5, 1
	drum_note 5, 1
	drum_note 5, 1
	drum_note 5, 2
	drum_note 1, 13
	rest 8
	rest 16
	drum_note 4, 1
	drum_note 4, 1
	drum_note 4, 1
	drum_note 4, 1
	drum_note 4, 2
	drum_note 5, 10
	rest 16
	rest 16
	rest 8
	drum_note 3, 1
	drum_note 3, 1
	drum_note 3, 1
	drum_note 3, 1
	drum_note 3, 2
	drum_note 3, 3
	drum_note 3, 3
	drum_note 4, 8
	rest 14
	drum_note 5, 1
	drum_note 5, 1
	drum_note 5, 1
	drum_note 5, 1
	drum_note 5, 1
	drum_note 12, 2
	drum_note 1, 13
	rest 16
	rest 8
	drum_note 4, 1
	drum_note 4, 1
	drum_note 4, 1
	drum_note 4, 16
	rest 9
	sound_jump Music_HiddenGrottoB2W2_Ch4_loop
