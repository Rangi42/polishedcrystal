; Pokémon R/S/E - Cable Car
; Demixed by Mmmmmm
; https://pastebin.com/pdd9nJqq
; https://soundcloud.com/mmmmmmmmmmmmmmmmm-1/mt-chimney-gbc-8-bit

Music_CableCarRSE:
	channel_count 4
	channel 1, Music_CableCarRSE_Ch1
	channel 2, Music_CableCarRSE_Ch2
	channel 3, Music_CableCarRSE_Ch3
	channel 4, Music_CableCarRSE_Ch4

Music_CableCarRSE_Ch1:
	tempo 172
	volume 7, 7
	duty_cycle 0
	pitch_offset $0002
	vibrato 8, 1, 5
	note_type 6, 6, 2
	octave 3
	note A_, 8
	note A_, 1
	note A_, 1
	note A_, 2
	note A_, 2
	note A_, 2
	octave 4
	note C_, 4
	octave 3
	volume_envelope 6, 5
	note A#, 8
	volume_envelope 6, 2
	octave 4
	note C_, 4
	octave 3
	note A_, 4
	note A_, 4
	note A_, 1
	note A_, 1
	note A_, 2
	note A_, 2
	note A_, 2
	octave 4
	note C_, 4
	octave 3
	volume_envelope 6, 5
	note A#, 8
	volume_envelope 6, 2
	octave 4
	note C_, 4
	note C#, 8
	note C#, 1
	note C#, 1
	note C#, 2
	note C#, 2
	note C#, 2
	note E_, 4
	volume_envelope 6, 5
	note D_, 8
	volume_envelope 6, 2
	note E_, 4
	note C#, 4
	note C#, 4
	note C#, 1
	note C#, 1
	note C#, 2
	note C#, 2
	note C#, 2
	note E_, 4
	volume_envelope 6, 5
	note D_, 8
	volume_envelope 6, 2
	note E_, 4
	octave 3
	volume_envelope 6, 0
	note A#, 16
	volume_envelope 6, 7
	note A#, 16
	sound_ret

Music_CableCarRSE_Ch2:
	duty_cycle 3
	vibrato 18, 2, 5
	pitch_offset $0001
	note_type 8, 9, 3
	octave 3
	note D_, 4
	note F#, 2
	volume_envelope 9, 7
	note A_, 6
	volume_envelope 9, 3
	note E_, 4
	note G_, 2
	volume_envelope 9, 7
	octave 4
	note C_, 4
	octave 3
	note B_, 1
	note A#, 1
	note A_, 16
	rest 4
	volume_envelope 9, 3
	note G_, 2
	note A_, 2
	note F#, 4
	note A#, 2
	volume_envelope 9, 7
	octave 4
	note C#, 6
	octave 3
	volume_envelope 9, 3
	note G#, 4
	note B_, 2
	volume_envelope 9, 7
	octave 4
	note E_, 4
	note D#, 1
	note D_, 1
	note C#, 12
	volume_envelope 9, 2
	note E_, 2
	note D_, 2
	note E_, 2
	volume_envelope 9, 7
	note F_, 6
	volume_envelope 9, 0
	note F#, 12
	volume_envelope 9, 7
	note F#, 12
	sound_ret

Music_CableCarRSE_Ch3:
	note_type 6, 2, 5
	vibrato 18, 1, 5
	octave 2
	note D_, 2
	rest 6
	octave 1
	note A_, 2
	rest 6
	octave 2
	note E_, 2
	rest 6
	octave 1
	note A_, 2
	rest 6
	octave 2
	note D_, 2
	rest 6
	octave 1
	note A_, 2
	rest 6
	octave 2
	note E_, 2
	rest 6
	octave 1
	note A_, 2
	rest 6
	octave 2
	note F#, 2
	rest 6
	note C#, 2
	rest 6
	note G#, 2
	rest 6
	note C#, 2
	rest 6
	note F#, 2
	rest 6
	note C#, 2
	rest 6
	note G#, 2
	rest 6
	note C#, 2
	rest 2
	octave 1
	note B_, 2
	note A#, 1
	note G#, 1
	note F#, 16
	volume_envelope 3, 5
	note F#, 16
	sound_ret
	
Music_CableCarRSE_Ch4:
	toggle_noise $4
	drum_speed 6
Music_CableCarRSE_Ch4_loop:
	drum_note 7, 8
	drum_note 7, 2
	drum_note 7, 2
	drum_note 7, 2
	drum_note 7, 2
	drum_note 7, 4
	drum_note 7, 8
	drum_note 7, 1
	drum_note 7, 1
	drum_note 7, 1
	drum_note 7, 1
	sound_loop 4, Music_CableCarRSE_Ch4_loop
	drum_note 12, 16
	sound_ret
