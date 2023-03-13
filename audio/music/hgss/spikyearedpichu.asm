; Pokémon HG/SS - Spiky-Eared Pichu
; Demixed by Mmmmmm
; https://pastebin.com/stpKurZA
; https://hax.iimarckus.org/topic/6777/3/

Music_SpikyEaredPichuHGSS:
	channel_count 4
	channel 1, Music_SpikyEaredPichuHGSS_Ch1
	channel 2, Music_SpikyEaredPichuHGSS_Ch2
	channel 3, Music_SpikyEaredPichuHGSS_Ch3
	channel 4, Music_SpikyEaredPichuHGSS_Ch4

Music_SpikyEaredPichuHGSS_Ch1:
	tempo 160
	volume 7, 7
	sound_call Music_SpikyEaredPichuHGSS_Ch1_branch_1
	sound_call Music_SpikyEaredPichuHGSS_Ch1_branch_1
	duty_cycle 1
	volume_envelope 11, 3
	note F_, 2
	note F_, 2
	note F_, 1
	note E_, 1
	note D_, 1
	note E_, 1
	note F_, 4
	note A_, 4
	note G_, 2
	note G_, 2
	note G_, 1
	note A_, 1
	note A#, 1
	note G_, 1
	note A_, 4
	octave 4
	note C_, 4
	octave 3
	note B_, 2
	note B_, 2
	note B_, 1
	octave 4
	note C_, 1
	note D_, 1
	octave 3
	note B_, 1
	octave 4
	note C_, 4
	note E_, 4
	note D_, 2
	octave 3
	note A_, 2
	note B_, 2
	octave 4
	note C_, 2
	octave 3
	note B_, 4
	octave 4
	note C_, 4
	sound_jump Music_SpikyEaredPichuHGSS_Ch1

Music_SpikyEaredPichuHGSS_Ch1_branch_1:
	note_type 4, 9, 2
	duty_cycle 0
	octave 3
	rest 6
	note A_, 1
	octave 4
	note C_, 1
	octave 3
	note A_, 1
	octave 4
	note C_, 1
	octave 3
	note A_, 1
	octave 4
	note C_, 1
	note_type 12, 9, 2
	octave 3
	note B_, 2
	octave 4
	note C_, 2
	note D_, 2
	note C_, 2
	octave 3
	note A#, 2
	note A_, 2
	note A#, 2
	note_type 8, 9, 2
	note A_, 1
	note A#, 1
	note A_, 1
	note_type 12, 9, 2
	note G_, 2
	note F_, 2
	note E_, 2
	note F_, 2
	note G_, 2
	note A_, 2
	note A#, 2
	note G_, 2
	note_type 6, 9, 2
	note A#, 1
	octave 4
	note D#, 1
	octave 3
	note A#, 1
	octave 4
	note D#, 1
	octave 3
	note A#, 1
	octave 4
	note D#, 3
	note_type 12, 9, 2
	octave 4
	note D_, 2
	octave 3
	note A#, 2
	note G_, 2
	octave 4
	note D_, 2
	note E_, 2
	note D_, 2
	note C_, 2
	octave 3
	note A#, 2
	note A_, 2
	octave 4
	note C_, 2
	octave 3
	note E_, 4
	sound_ret

Music_SpikyEaredPichuHGSS_Ch2:
	volume 7, 7
	duty_cycle 2
	note_type 12, 11, 3
	octave 3
	note C_, 2
	note C_, 2
	note C_, 1
	octave 2
	note A#, 1
	note A_, 1
	note A#, 1
	octave 3
	note C_, 2
	note F_, 2
	note F_, 2
	note C_, 2
	note D_, 2
	note_type 8, 11, 3
	note C_, 1
	note D_, 1
	note C_, 1
	note_type 12, 11, 3
	octave 2
	note A#, 2
	note A_, 2
	note A#, 2
	note A_, 2
	note A#, 2
	note F_, 2
	note G_, 2
	note D#, 2
	note A#, 2
	note G_, 2
	octave 3
	note D_, 2
	octave 2
	note A#, 2
	note G_, 2
	octave 3
	note D_, 2
	note E_, 2
	note D_, 2
	note C_, 2
	octave 2
	note A#, 2
	note A_, 2
	octave 3
	note C_, 2
	octave 2
	note E_, 4
	volume_envelope 9, 3
Music_SpikyEaredPichuHGSS_Ch2_loop_1:
	octave 1
	note F_, 2
	octave 2
	note C_, 2
	rest 2
	note C_, 2
	sound_loop 4, Music_SpikyEaredPichuHGSS_Ch2_loop_1
	octave 1
	note D#, 2
	note A#, 4
	note A#, 2
	note A#, 2
	note G_, 2
	note D_, 2
	note B_, 2
	octave 2
	note C_, 2
	octave 1
	note A#, 2
	note A_, 2
	note G_, 2
	note F_, 2
	note A_, 2
	note C_, 4
	note D_, 2
	note A_, 2
	octave 2
	note D_, 2
	octave 1
	note A_, 2
	note D_, 2
	note A#, 2
	octave 2
	note D_, 2
	octave 1
	note A_, 2
	note C_, 2
	note G_, 2
	octave 2
	note E_, 2
	octave 1
	note G_, 2
	note C_, 2
	note F_, 2
	octave 2
	note C_, 2
	octave 1
	note F_, 2
	note D_, 2
	note B_, 2
	octave 2
	note D_, 2
	octave 1
	note F_, 2
	note C_, 2
	note G_, 2
	octave 2
	note C_, 2
	octave 1
	note E_, 2
	note D_, 4
	note D_, 4
	note B_, 4
	rest 4
	sound_jump Music_SpikyEaredPichuHGSS_Ch2

Music_SpikyEaredPichuHGSS_Ch3:
	note_type 6, 1, 5
	volume_envelope 1, 0
	rest 16
	octave 6
	note C_, 2
	note D_, 2
	note C_, 2
	note F_, 2
	note C_, 12
	volume_envelope 2, 0
	note C_, 8
	volume_envelope 3, 0
	note C_, 4
	octave 5
	volume_envelope 1, 0
	note A_, 2
	note F_, 1
	volume_envelope 2, 0
	note F_, 1
	volume_envelope 1, 0
	note F_, 2
	note A_, 2
	octave 6
	note F_, 2
	note C_, 2
	octave 5
	note A_, 2
	note F_, 12
	volume_envelope 2, 0
	note F_, 8
	volume_envelope 3, 0
	note F_, 4
	rest 8
	note_type 3, 1, 0
	note F_, 1
	note B_, 1
	octave 6
	note C_, 1
	note D_, 1
	note_type 12, 1, 0
	note E_, 1
	volume_envelope 3, 0
	note E_, 1
	volume_envelope 1, 0
	note D_, 1
	volume_envelope 3, 0
	note D_, 1
	volume_envelope 1, 0
	note C_, 1
	volume_envelope 3, 0
	note C_, 1
	volume_envelope 1, 0
	octave 5
	note A#, 1
	volume_envelope 3, 0
	note A#, 1
	volume_envelope 1, 0
	note A_, 1
	volume_envelope 3, 0
	note A_, 1
	volume_envelope 1, 0
	octave 6
	note C_, 1
	volume_envelope 3, 0
	note C_, 1
	volume_envelope 1, 0
	octave 5
	note E_, 4
	octave 6
	note C_, 1
	volume_envelope 3, 0
	note C_, 1
	volume_envelope 1, 0
	note C_, 1
	volume_envelope 3, 0
	note C_, 1
	volume_envelope 1, 0
	note C_, 1
	octave 5
	note A#, 1
	note A_, 1
	note A#, 1
	octave 6
	note C_, 2
	note F_, 1
	volume_envelope 3, 0
	note F_, 1
	volume_envelope 1, 0
	note F_, 1
	volume_envelope 3, 0
	note F_, 1
	volume_envelope 1, 0
	note C_, 1
	volume_envelope 3, 0
	note C_, 1
	volume_envelope 1, 0
	note D_, 2
	note_type 8, 1, 0
	note C_, 1
	note D_, 1
	note C_, 1
	octave 5
	note_type 12, 1, 0
	note A#, 1
	volume_envelope 3, 0
	note A#, 1
	volume_envelope 1, 0
	note A_, 1
	volume_envelope 3, 0
	note A_, 1
	volume_envelope 1, 0
	note A#, 1
	volume_envelope 3, 0
	note A#, 1
	volume_envelope 1, 0
	note A_, 1
	volume_envelope 3, 0
	note A_, 1
	volume_envelope 1, 0
	note A#, 1
	volume_envelope 3, 0
	note A#, 1
	volume_envelope 1, 0
	note F_, 1
	volume_envelope 3, 0
	note F_, 1
	volume_envelope 1, 0
	note G_, 2
	note D#, 2
	note_type 6, 1, 0
	octave 6
	note D#, 1
	note F_, 1
	note D#, 1
	note F_, 1
	volume_envelope 2, 0
	note D#, 1
	note F_, 1
	note D#, 1
	note F_, 1
	note_type 12, 1, 0
	note D_, 1
	volume_envelope 3, 0
	note D_, 1
	volume_envelope 1, 0
	octave 5
	note A#, 1
	volume_envelope 3, 0
	note A#, 1
	volume_envelope 1, 0
	note G_, 1
	volume_envelope 3, 0
	note G_, 1
	volume_envelope 1, 0
	octave 6
	note D_, 1
	volume_envelope 3, 0
	note D_, 1
	volume_envelope 1, 0
	note E_, 1
	volume_envelope 3, 0
	note E_, 1
	volume_envelope 1, 0
	note D_, 1
	volume_envelope 3, 0
	note D_, 1
	volume_envelope 1, 0
	note C_, 1
	volume_envelope 3, 0
	note C_, 1
	volume_envelope 1, 0
	octave 5
	note A#, 1
	volume_envelope 3, 0
	note A#, 1
	volume_envelope 1, 0
	note A_, 1
	volume_envelope 3, 0
	note A_, 1
	volume_envelope 1, 0
	octave 6
	note C_, 1
	volume_envelope 3, 0
	note C_, 1
	volume_envelope 1, 0
	octave 5
	note E_, 4
	rest 8
	note A_, 1
	note A#, 1
	note A_, 1
	note A#, 1
	volume_envelope 2, 5
	octave 4
	note D_, 1
	note C_, 1
	octave 3
	note A#, 1
	octave 4
	note D_, 1
	note C_, 6
	volume_envelope 3, 5
	note C_, 2
	volume_envelope 1, 0
	octave 6
	note C_, 1
	note D_, 1
	note C_, 1
	note D_, 1
	volume_envelope 2, 5
	octave 4
	note F_, 1
	note E_, 1
	note C_, 1
	note A_, 1
	note G_, 6
	volume_envelope 3, 5
	note G_, 1
	note_type 3, 1, 0
	octave 5
	note C_, 1
	note G_, 1
	note A_, 1
	note B_, 1
	note_type 12, 1, 0
	octave 6
	note C_, 1
	volume_envelope 3, 0
	note C_, 1
	volume_envelope 1, 0
	octave 5
	note G_, 1
	volume_envelope 3, 0
	note G_, 1
	volume_envelope 1, 0
	octave 6
	note C_, 1
	volume_envelope 3, 0
	note C_, 1
	volume_envelope 1, 0
	note E_, 1
	volume_envelope 3, 0
	note E_, 1
	volume_envelope 1, 0
	note D_, 1
	volume_envelope 3, 0
	note D_, 1
	volume_envelope 1, 0
	octave 5
	note A_, 1
	volume_envelope 3, 0
	note A_, 1
	volume_envelope 1, 0
	note B_, 1
	volume_envelope 3, 0
	note B_, 1
	volume_envelope 1, 0
	octave 6
	note C_, 2
	note_type 3, 1, 0
	octave 5
	note B_, 4
	volume_envelope 3, 0
	note B_, 9
	octave 6
	volume_envelope 1, 0
	note D_, 1
	note E_, 1
	note F#, 1
	note G_, 8
	rest 8
	sound_jump Music_SpikyEaredPichuHGSS_Ch3

Music_SpikyEaredPichuHGSS_Ch4:
	toggle_noise 3
	drum_speed 12
Music_SpikyEaredPichuHGSS_Ch4_loop_main:
Music_SpikyEaredPichuHGSS_Ch4_loop_1:
	drum_note 9, 8
	drum_note 9, 8
	drum_note 9, 8
	drum_note 9, 8
	drum_note 9, 8
	drum_note 9, 7
	drum_speed 3
	drum_note 1, 1
	drum_note 1, 1
	drum_note 1, 1
	drum_note 1, 1
	drum_speed 12
	drum_note 12, 6
	drum_note 4, 2
	drum_note 1, 4
	drum_note 1, 4
	sound_loop 2, Music_SpikyEaredPichuHGSS_Ch4_loop_1
	drum_note 9, 8
	drum_note 9, 8
	drum_note 9, 8
	drum_note 9, 8
	drum_note 9, 8
	drum_note 9, 8
	drum_note 12, 2
	drum_note 1, 2
	drum_note 12, 2
	drum_note 1, 2
	drum_note 12, 4
	drum_note 4, 4
	sound_jump Music_SpikyEaredPichuHGSS_Ch4_loop_main
