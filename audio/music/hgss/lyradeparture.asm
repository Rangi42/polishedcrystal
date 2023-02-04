; Pokémon HG/SS - Encounter! Lyra (Departure)
; Demixed by Mmmmmm
; https://pastebin.com/0PPUz32D
; https://hax.iimarckus.org/topic/6777/3/

Music_LyraDepartureHGSS:
	channel_count 4
	channel 1, Music_LyraDepartureHGSS_Ch1
	channel 2, Music_LyraDepartureHGSS_Ch2
	channel 3, Music_LyraDepartureHGSS_Ch3
	channel 4, Music_LyraDepartureHGSS_Ch4

Music_LyraDepartureHGSS_Ch1:
	tempo 184
	duty_cycle 1
	note_type 12, 8, 5
	rest 4
	sound_jump Music_LyraEncounterHGSS_Ch1_loop

Music_LyraDepartureHGSS_Ch2:
	duty_cycle 2
	note_type 12, 11, 4
	rest 4
	sound_jump Music_LyraEncounterHGSS_Ch2_loop

Music_LyraDepartureHGSS_Ch3:
	note_type 12, 1, 5
	volume_envelope 1, 0
	rest 4
	sound_jump Music_LyraEncounterHGSS_Ch3_loop

Music_LyraDepartureHGSS_Ch4:
	toggle_noise 3
	drum_speed 6
	drum_note 1, 2
	drum_note 1, 2
	drum_note 4, 4
	sound_jump Music_LyraEncounterHGSS_Ch4_loop
