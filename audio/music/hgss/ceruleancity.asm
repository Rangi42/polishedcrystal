; Pokémon HG/SS - Cerulean City
; Demixed by FroggestSpirit
; https://github.com/froggestspirit/CrystalComplete/blob/master/audio/music/custom/ceruleanGSC.asm

Music_CeruleanCityHGSS:
	channel_count 4
	channel 1, Music_CeruleanCityHGSS_Ch1
	channel 2, Music_CeruleanCityHGSS_Ch2
	channel 3, Music_CeruleanCityHGSS_Ch3
	channel 4, Music_CeruleanCityHGSS_Ch4

Music_CeruleanCityHGSS_Ch1:
	tempo $94
	volume 7, 7
	note_type 12, 11, 2
	pitch_offset 1
	duty_cycle 2
	octave 4
	note E_, 2
	note D#, 2
	note C#, 2
	octave 3
	note B_, 2
	note A_, 2
	note B_, 2
	octave 4
	note C#, 2
	note D#, 2
Music_CeruleanCityHGSS_Loop1:
	volume_envelope 11, 1
	octave 3
	note G#, 2
	octave 4
	note G#, 2
	octave 3
	note B_, 2
	octave 4
	note G#, 2
	octave 3
	note B_, 2
	octave 4
	note G#, 2
	octave 3
	note B_, 2
	octave 4
	note G#, 2
	octave 3
	note A_, 2
	octave 4
	note E_, 2
	octave 3
	note A_, 2
	octave 4
	note E_, 2
	octave 3
	note B_, 2
	octave 4
	note D#, 2
	octave 3
	note B_, 2
	octave 4
	note D#, 2
	octave 3
	note B_, 2
	octave 4
	note G#, 2
	octave 3
	note B_, 2
	octave 4
	note G#, 2
	octave 3
	note B_, 2
	octave 4
	note G#, 2
	octave 3
	note B_, 2
	octave 4
	note G#, 2
	octave 3
	note A_, 2
	octave 4
	note E_, 2
	octave 3
	note A_, 2
	octave 4
	note E_, 2
	note D#, 2
	note B_, 2
	note D#, 2
	note B_, 2
	octave 3
	note B_, 4
	note B_, 2
	note G#, 1
	note G#, 1
	note E_, 2
	note F#, 2
	volume_envelope 11, 4
	note G#, 1
	note A_, 1
	note B_, 1
	octave 4
	note C#, 1
	octave 3
	note B_, 6
	octave 4
	note C#, 1
	octave 3
	note B_, 1
	note A_, 8
	volume_envelope 11, 2
	note G#, 1
	note G#, 1
	note G#, 1
	note G#, 1
	note G#, 2
	note G#, 1
	note G#, 1
	note E_, 2
	note F#, 2
	volume_envelope 11, 4
	note G#, 1
	note A_, 1
	note B_, 1
	octave 4
	note C#, 1
	octave 3
	note B_, 6
	note G#, 1
	note B_, 1
	octave 4
	note D#, 8
	octave 3
	note E_, 2
	note E_, 1
	note F#, 1
	note G#, 1
	rest 3
	note B_, 4
	note G#, 4
	note B_, 2
	note B_, 1
	octave 4
	note C#, 1
	note D#, 1
	rest 3
	note D#, 4
	octave 3
	note B_, 4
	note A_, 1
	note G#, 1
	note A_, 1
	note B_, 1
	octave 4
	note C#, 1
	rest 1
	note C#, 1
	octave 3
	note B_, 1
	octave 4
	note C#, 1
	note D#, 1
	note E_, 1
	rest 1
	note E_, 1
	note F#, 1
	note E_, 1
	note F#, 1
	octave 5
	note B_, 1
	note F#, 1
	note D#, 1
	note C#, 1
	octave 4
	note B_, 1
	octave 5
	note C#, 1
	note D#, 1
	note F#, 1
	note B_, 8
	volume_envelope 11, 6
	octave 3
	note G#, 8
	note G#, 4
	note B_, 4
	octave 4
	note E_, 4
	note F#, 4
	note G#, 8
;Channel1_Bar16:
	note D#, 8
	octave 3
	note B_, 4
	octave 4
	note B_, 4
;Channel1_Bar17:
	note A_, 4
	note B_, 4
	volume_envelope 11, 2
	note E_, 2
	note D#, 2
	note C#, 2
	note C_, 2
;Channel1_Bar18:
	sound_jump Music_CeruleanCityHGSS_Loop1

Music_CeruleanCityHGSS_Ch2:
;Channel2_Bar1:
	vibrato 12, 3, 4
	duty_cycle 2
	note_type 2, 12, 2
	pitch_offset 2
	rest 2
	note_type 12, 12, 2
	octave 5
	note E_, 2
	note D#, 2
	note C#, 2
	octave 4
	note B_, 2
	note A_, 2
	note B_, 2
	octave 5
	note C#, 2
	note_type 2, 12, 2
	note D#, 10
;Channel2_Bar2:
Music_CeruleanCityHGSS_Loop2:
	note_type 12, 12, 2
	note E_, 6
	octave 3
	note E_, 1
	octave 2
	note B_, 1
	octave 3
	note C#, 2
	note D#, 2
	note E_, 1
	note F#, 1
	note G#, 1
	note A_, 1
;Channel2_Bar3:
	volume_envelope 12, 4
	note G#, 6
	note A_, 1
	note G#, 1
	note F#, 14
;Channel2_Bar4:
	volume_envelope 12, 2
	note E_, 1
	octave 2
	note B_, 1
	octave 3
	note C#, 2
	note D#, 2
	note E_, 1
	note F#, 1
	note G#, 1
	note A_, 1
;Channel2_Bar5:
	volume_envelope 12, 4
	note G#, 6
	note E_, 1
	note G#, 1
	note B_, 14
;Channel2_Bar6:
	volume_envelope 12, 2
	duty_cycle 1
	octave 4
	note E_, 1
	octave 3
	note B_, 1
	octave 4
	note C#, 2
	note D#, 2
	note E_, 1
	note F#, 1
	note G#, 1
	note A_, 1
;Channel2_Bar7:
	volume_envelope 12, 4
	note G#, 6
	note A_, 1
	note G#, 1
	note F#, 8
;Channel2_Bar8:
	volume_envelope 12, 2
	note B_, 1
	note B_, 1
	note B_, 1
	note B_, 1
	note B_, 2
	note E_, 1
	octave 3
	note B_, 1
	octave 4
	note C#, 2
	note D#, 2
	note E_, 1
	note F#, 1
	note G#, 1
	note A_, 1
;Channel2_Bar9:
	volume_envelope 12, 4
	note G#, 6
	note E_, 1
	note G#, 1
	note B_, 8
;Channel2_Bar10:
	octave 3
	note C#, 1
	octave 2
	note B_, 1
	octave 3
	note C#, 1
	note D#, 1
	note E_, 1
	rest 3
	duty_cycle_pattern 0, 0, 2, 2
	duty_cycle 0
	octave 4
	note G#, 4
	note E_, 4
;Channel2_Bar11:
	duty_cycle_pattern 1, 1, 1, 1
	duty_cycle 1
	octave 3
	note D#, 1
	note C#, 1
	note D#, 1
	note E_, 1
	note F#, 1
	rest 3
	duty_cycle_pattern 0, 0, 2, 2
	duty_cycle 0
	octave 4
	note B_, 4
	note F#, 4
;Channel2_Bar12:
	duty_cycle_pattern 1, 1, 1, 1
	duty_cycle 1
	octave 3
	note C#, 1
	octave 2
	note B_, 1
	octave 3
	note C#, 1
	note D#, 1
	note E_, 1
	rest 1
	note E_, 1
	note D#, 1
	note E_, 1
	note F#, 1
	note G#, 1
	rest 1
	note G#, 1
	note A_, 1
	note G#, 1
	note A_, 1
;Channel2_Bar13:
	note B_, 1
	note F#, 1
	note D#, 1
	note C#, 1
	octave 2
	note B_, 1
	octave 3
	note C#, 1
	note D#, 1
	note F#, 1
	note B_, 8
;Channel2_Bar14:
	duty_cycle_pattern 0, 0, 2, 2
	volume_envelope 12, 6
	duty_cycle 2
	octave 4
	note E_, 8
	octave 3
	note B_, 4
	octave 4
	note F#, 4
;Channel2_Bar15:
	note G#, 4
	note A_, 4
	note B_, 8
;Channel2_Bar16:
	note B_, 8
	note G#, 4
	octave 5
	note D#, 4
;Channel2_Bar17:
	note C#, 4
	note D#, 4
	duty_cycle_pattern 2, 2, 2, 2
	note_type 2, 12, 2
	rest 2
	note_type 12, 12, 2
	note E_, 2
	note D#, 2
	note C#, 2
	note_type 2, 12, 2
	note D#, 10
;Channel2_Bar18:
	sound_jump Music_CeruleanCityHGSS_Loop2

Music_CeruleanCityHGSS_Ch3:
	note_type 6, 1, 5
	vibrato 12, 2, 4
;Channel3_Bar1:
	rest 16
	octave 4
	note E_, 3
	rest 1
	note D#, 3
	rest 1
	note C#, 3
	rest 1
	note C_, 3
	rest 1
;Channel3_Bar2:
Music_CeruleanCityHGSS_Loop3:
	octave 1
	note E_, 2
	rest 6
	note E_, 2
	rest 4
	note E_, 1
	rest 1
	note E_, 2
	rest 2
	octave 2
	note E_, 2
	rest 2
	octave 1
	note E_, 2
	rest 2
	octave 2
	note E_, 2
	rest 2
	octave 1
	note F#, 2
	rest 6
	note F#, 2
	rest 4
	octave 2
	note C#, 2
	octave 1
	note B_, 2
	rest 2
	octave 2
	note B_, 2
	rest 2
	octave 1
	note B_, 2
	rest 2
	octave 2
	note B_, 2
	rest 2
	octave 1
	note E_, 2
	rest 6
	note E_, 2
	rest 4
	note E_, 1
	rest 1
	note E_, 2
	rest 2
	octave 2
	note E_, 2
	rest 2
	octave 1
	note E_, 2
	rest 2
	octave 2
	note E_, 2
	rest 2
	octave 1
	note F#, 2
	rest 6
	note F#, 2
	rest 4
	octave 2
	note C#, 2
	octave 1
	note B_, 2
	rest 2
	octave 2
	note B_, 2
	rest 2
	octave 1
	note B_, 2
	octave 2
	note B_, 2
	octave 4
	note B_, 2
	octave 3
	note B_, 2
	octave 1
	note E_, 2
	rest 2
	octave 5
	note G#, 1
	rest 3
	octave 1
	note E_, 2
	rest 2
	octave 5
	note G#, 1
	rest 1
	octave 1
	note E_, 1
	rest 1
	note E_, 2
	rest 2
	octave 5
	note G#, 1
	rest 1
	octave 2
	note E_, 2
	octave 1
	note E_, 2
	octave 2
	note E_, 2
	octave 5
	note G#, 1
	rest 1
	octave 1
	note E_, 2
	note F#, 2
	rest 2
	octave 6
	note C#, 1
	rest 3
	octave 1
	note F#, 2
	rest 2
	octave 6
	note C#, 1
	rest 1
	octave 2
	note C#, 2
	octave 1
	note B_, 2
	rest 2
	octave 6
	note D#, 1
	rest 1
	octave 2
	note B_, 2
	octave 1
	note B_, 2
	octave 2
	note B_, 2
	octave 6
	note D#, 1
	rest 1
	octave 1
	note B_, 2
	octave 2
	note E_, 2
	octave 3
	note E_, 2
	octave 4
	note E_, 2
	octave 5
	note E_, 2
	octave 1
	note E_, 2
	rest 2
	octave 5
	note G#, 1
	rest 1
	octave 1
	note E_, 1
	rest 1
	note E_, 2
	rest 2
	octave 5
	note G#, 1
	rest 1
	octave 2
	note E_, 2
	octave 1
	note E_, 2
	octave 2
	note E_, 2
	octave 5
	note G#, 1
	rest 1
	octave 1
	note E_, 2
	note F#, 2
	rest 2
	octave 5
	note E_, 1
	rest 3
	octave 1
	note F#, 2
	rest 2
	octave 5
	note E_, 1
	rest 1
	octave 2
	note C#, 2
	octave 1
	note B_, 2
	rest 2
	octave 5
	note F#, 1
	rest 1
	octave 1
	note B_, 2
	note G#, 2
	octave 4
	note D#, 2
	octave 5
	note G#, 1
	rest 1
	octave 3
	note G#, 2
	octave 2
	note C#, 2
	rest 6
	note C#, 2
	rest 4
	note C#, 1
	rest 1
	note C#, 2
	rest 2
	octave 3
	note C#, 2
	rest 2
	octave 2
	note C#, 2
	rest 2
	octave 3
	note C#, 2
	rest 2
	octave 1
	note G#, 2
	rest 6
	note G#, 2
	rest 4
	note G#, 1
	rest 1
	note G#, 2
	rest 2
	octave 2
	note G#, 2
	rest 2
	octave 1
	note G#, 2
	rest 2
	octave 2
	note G#, 2
	rest 2
	octave 1
	note A_, 4
	octave 2
	note A_, 2
	rest 2
	octave 1
	note A_, 2
	rest 2
	note G#, 4
	octave 2
	note G#, 2
	rest 2
	octave 1
	note G#, 2
	rest 2
	note F#, 4
	octave 2
	note F#, 2
	rest 2
	octave 1
	note F#, 2
	rest 2
	note B_, 2
	rest 2
	note B_, 8
	rest 16
	rest 4
	octave 2
	note E_, 2
	rest 2
	octave 1
	note E_, 2
	rest 2
	octave 2
	note E_, 2
	rest 6
	note E_, 2
	rest 2
	octave 1
	note E_, 2
	rest 2
	octave 2
	note E_, 2
	rest 6
	note F#, 2
	rest 2
	octave 1
	note F#, 2
	rest 2
	octave 2
	note F#, 2
	rest 6
	note F#, 2
	rest 2
	octave 1
	note F#, 2
	rest 2
	octave 2
	note F#, 2
	rest 6
	note G#, 2
	rest 2
	octave 1
	note G#, 2
	rest 2
	octave 2
	note G#, 2
	rest 6
	note G#, 2
	rest 2
	octave 1
	note G#, 2
	rest 2
	octave 2
	note G#, 2
	rest 6
	note A_, 2
	rest 2
	octave 1
	note A_, 2
	rest 2
	octave 2
	note A_, 2
	rest 6
	note A_, 2
	rest 2
	octave 1
	note A_, 2
	rest 2
	octave 2
	note A_, 2
	rest 2
	sound_jump Music_CeruleanCityHGSS_Loop3

Music_CeruleanCityHGSS_Ch4:
	drum_speed 12
	toggle_noise 0
;Channel4_Bar1:
	rest 16
;Channel4_Bar2:
Music_CeruleanCityHGSS_Loop4:
	drum_note 11, 2
	drum_note 8, 1
	drum_note 8, 1
	drum_note 3, 2
	drum_note 8, 1
	drum_note 8, 1
	drum_note 10, 2
	drum_note 8, 1
	drum_note 8, 1
	drum_note 3, 2
	drum_note 8, 1
	drum_note 8, 1
;Channel4_Bar3:
	drum_note 10, 2
	drum_note 8, 1
	drum_note 8, 1
	drum_note 3, 2
	drum_note 8, 1
	drum_note 8, 1
	drum_note 10, 2
	drum_note 8, 1
	drum_note 8, 1
	drum_note 3, 2
	drum_note 8, 1
	drum_note 8, 1
;Channel4_Bar4:
	drum_note 10, 2
	drum_note 8, 1
	drum_note 8, 1
	drum_note 3, 2
	drum_note 8, 1
	drum_note 8, 1
	drum_note 10, 2
	drum_note 8, 1
	drum_note 8, 1
	drum_note 3, 2
	drum_note 8, 1
	drum_note 8, 1
;Channel4_Bar5:
	drum_note 10, 2
	drum_note 8, 1
	drum_note 8, 1
	drum_note 3, 2
	drum_note 8, 1
	drum_note 8, 1
	drum_note 10, 2
	drum_note 8, 1
	drum_note 8, 1
	drum_note 3, 2
	drum_note 8, 1
	drum_note 6, 1
;Channel4_Bar6:
	drum_note 10, 2
	drum_note 8, 1
	drum_note 8, 1
	drum_note 3, 2
	drum_note 8, 1
	drum_note 8, 1
	drum_note 10, 2
	drum_note 8, 1
	drum_note 8, 1
	drum_note 3, 2
	drum_note 8, 1
	drum_note 8, 1
;Channel4_Bar7:
	drum_note 10, 2
	drum_note 8, 1
	drum_note 8, 1
	drum_note 3, 2
	drum_note 8, 1
	drum_note 8, 1
	drum_note 10, 2
	drum_note 8, 1
	drum_note 8, 1
	drum_note 3, 2
	drum_note 11, 2
;Channel4_Bar8:
	drum_note 6, 1
	drum_note 6, 1
	drum_note 8, 1
	drum_note 6, 1
	drum_note 3, 2
	drum_note 8, 1
	drum_note 8, 1
	drum_note 10, 2
	drum_note 8, 1
	drum_note 8, 1
	drum_note 3, 2
	drum_note 8, 1
	drum_note 8, 1
;Channel4_Bar9:
	drum_note 10, 2
	drum_note 8, 1
	drum_note 8, 1
	drum_note 3, 2
	drum_note 8, 1
	drum_note 8, 1
	drum_note 10, 2
	drum_note 11, 2
	drum_note 3, 2
	drum_note 3, 1
	drum_note 6, 1
;Channel4_Bar10:
	drum_note 11, 2
	drum_note 8, 1
	drum_note 8, 1
	drum_note 3, 2
	drum_note 8, 1
	drum_note 8, 1
	drum_note 10, 2
	drum_note 8, 1
	drum_note 8, 1
	drum_note 3, 2
	drum_note 8, 1
	drum_note 8, 1
;Channel4_Bar11:
	drum_note 10, 2
	drum_note 8, 1
	drum_note 8, 1
	drum_note 3, 2
	drum_note 8, 1
	drum_note 8, 1
	drum_note 10, 2
	drum_note 8, 1
	drum_note 8, 1
	drum_note 3, 2
	drum_note 11, 2
;Channel4_Bar12:
	drum_note 11, 2
	drum_note 8, 1
	drum_note 8, 1
	drum_note 3, 2
	drum_note 10, 2
	drum_note 8, 1
	drum_note 8, 1
	drum_note 3, 2
	drum_note 10, 2
	drum_note 8, 1
	drum_note 8, 1
;Channel4_Bar13:
	drum_note 3, 2
	drum_note 3, 2
	drum_note 3, 12
;Channel4_Bar14:
	drum_note 8, 1
	drum_note 8, 1
	drum_note 3, 2
	drum_note 8, 1
	drum_note 8, 1
	drum_note 3, 2
	drum_note 8, 1
	drum_note 8, 1
	drum_note 3, 2
	drum_note 8, 1
	drum_note 8, 1
	drum_note 3, 2
;Channel4_Bar15:
	drum_note 8, 1
	drum_note 8, 1
	drum_note 3, 2
	drum_note 8, 1
	drum_note 8, 1
	drum_note 3, 2
	drum_note 8, 1
	drum_note 8, 1
	drum_note 3, 2
	drum_note 8, 1
	drum_note 8, 1
	drum_note 3, 2
;Channel4_Bar16:
	drum_note 8, 1
	drum_note 8, 1
	drum_note 3, 2
	drum_note 8, 1
	drum_note 8, 1
	drum_note 3, 2
	drum_note 8, 1
	drum_note 8, 1
	drum_note 3, 2
	drum_note 8, 1
	drum_note 8, 1
	drum_note 3, 2
;Channel4_Bar17:
	drum_note 8, 1
	drum_note 8, 1
	drum_note 3, 2
	drum_note 8, 1
	drum_note 8, 1
	drum_note 3, 2
	drum_note 8, 1
	drum_note 8, 1
	drum_note 11, 2
	drum_note 3, 2
	drum_note 6, 1
	drum_note 6, 1
;Channel4_Bar18:
	sound_jump Music_CeruleanCityHGSS_Loop4
