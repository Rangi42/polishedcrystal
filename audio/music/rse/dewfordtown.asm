; Pokémon R/S/E - Dewford Town
; Demixed by ShantyTown
; https://github.com/huderlem/pokestyle-music-devamps/blob/master/music/hoenn_dewford_town.asm

Music_DewfordTownRSE:
	channel_count 4
	channel 1, Music_DewfordTownRSE_Ch1
	channel 2, Music_DewfordTownRSE_Ch2
	channel 3, Music_DewfordTownRSE_Ch3
	channel 4, Music_DewfordTownRSE_Ch4

Music_DewfordTownRSE_Ch1:
	tempo 138
	volume 7, 7
	stereopanning $f
Music_DewfordTownRSE_Ch1_b0:
	vibrato $10, $33
	dutycycle $2
	note_type 12, 3, -7
	octave 3
	note D_, 6
	note_type 12, 7, 0
	octave 2
	note A#, 6
	note G#, 6
	note F_, 6
	note D_, 6
	note D#, 6
	note F_, 6
	note __, 6
	note_type 12, 9, 7
	dutycycle $1
	octave 2
	note C_, 10
	octave 1
	note A#, 2
	note A#, 6
	note_type 12, 6, 7
	octave 2
	note G#, 6
	note G_, 12
	note G#, 6
	note A#, 4
	note G_, 2
	note_type 12, 9, 7
	octave 1
	note G#, 10
	note G_, 2
	note G_, 10
	note __, 2
	note_type 12, 6, 7
	note G_, 7
	note __, 1
	note F_, 1
	note __, 1
	note G_, 1
	note __, 1
	note D#, 6
	note F_, 6
	octave 2
	note_type 12, 9, 7
	note D#, 10
	note_type 12, 6, 7
	note F_, 1
	note D#, 1
	note C_, 6
	octave 1
	note A#, 6
	octave 2
	note C_, 7
	note __, 1
	octave 1
	note G_, 1
	note __, 1
	octave 2
	note C_, 1
	note __, 1
	octave 1
	note_type 12, 9, 7
	note D#, 10
	note G#, 2
	note_type 12, 6, 7
	note A#, 16
	note __, 8
	octave 2
	note F_, 2
	note __, 16
	note __, 6
	note_type 12, 6, 1
	octave 5
	dutycycle $0
Music_DewfordTownRSE_Ch1_b1:
	note D#, 2
	note D#, 1
	note D_, 1
	note D#, 1
	note __, 1
	note D#, 1
	note __, 2
	note D#, 1
	note D_, 1
	note D#, 1
	loopchannel 12, Music_DewfordTownRSE_Ch1_b1
	note F_, 2
	note F_, 1
	note E_, 1
	note F_, 1
	note __, 1
	note F_, 1
	note __, 2
	note F_, 1
	note E_, 1
	note F_, 1
	note D#, 2
	note D#, 1
	note D_, 1
	note D#, 1
	note __, 1
	note D#, 1
	note __, 2
	note D#, 1
	note D_, 1
	note D#, 1
	note F_, 1
	note __, 11
	note_type 12, 9, 8
	octave 3
	note D_, 1
	note C_, 1
	octave 2
	note A#, 1
	octave 3
	note C_, 1
	note D_, 1
	note D#, 1
	note F_, 1
	note D#, 1
	note D_, 1
	note D#, 1
	note G_, 1
	note G#, 1
	note A#, 12
	note B_, 12
	octave 4
	note C_, 12
	note C#, 12
	octave 3
	note G#, 2
	note G_, 2
	note F_, 2
	note C_, 6
	octave 2
	note B_, 12
	note A#, 2
	octave 3
	note D#, 2
	note F_, 2
	note A#, 16
	note A_, 2
	note A#, 12
	note B_, 12
	octave 4
	note C_, 12
	note C#, 12
	octave 3
	note D#, 12
	note G#, 12
	note G_, 4
	note G#, 1
	note __, 1
	note G_, 4
	note F_, 1
	note __, 1
	note G_, 6
	note __, 6
	jumpchannel Music_DewfordTownRSE_Ch1_b0

Music_DewfordTownRSE_Ch2:
	stereopanning $f0
Music_DewfordTownRSE_Ch2_b0:
	note_type 12, 5, -7
	vibrato $10, $00
	dutycycle $2
	octave 4
	note A#, 6
	note_type 12, 9, 0
	note G#, 6
	note F_, 6
	note D_, 6
	octave 3
	note A#, 6
	octave 4
	note C_, 6
	note D_, 6
	vibrato $10, $33
	note_type 12, 9, 7
	dutycycle $2
	octave 2
	note A#, 2
	octave 3
	note D_, 2
	note F_, 2
	note_type 12, 9, 0
	note G#, 10
	note_type 12, 9, 7
	note G_, 1
	note __, 1
	note G_, 10
	note __, 10
	note_type 12, 9, 3
	note F_, 2
	note G_, 2
	note_type 6, 9, 7
	note A#, 4
	note G#, 1
	note A#, 1
	note G#, 2
	note_type 12, 9, 7
	note G_, 2
	note F_, 2
	note G_, 2
	note D_, 2
	note_type 12, 9, 0
	note F_, 10
	note_type 12, 9, 7
	note D#, 2
	note D#, 10
	note __, 10
	note_type 12, 9, 3
	note C_, 2
	note_type 6, 9, 7
	note D_, 3
	note G#, 1
	note_type 12, 9, 7
	note G_, 2
	note F_, 2
	note D#, 2
	note C_, 2
	note D_, 2
	note D#, 2
	note_type 12, 9, 0
	note A#, 9
	note_type 12, 9, 7
	octave 4
	note C_, 1
	octave 3
	note A#, 2
	note G#, 10
	note __, 10
	note_type 12, 9, 3
	note C_, 2
	note D#, 2
	octave 4
	note_type 6, 9, 7
	note C_, 4
	octave 3
	note A#, 1
	octave 4
	note C_, 1
	octave 3
	note A#, 2
	note_type 12, 9, 7
	note G#, 2
	note G_, 2
	note G#, 2
	note D#, 2
	vibrato $3f, $14
	note_type 12, 1, -7
	note F_, 12
	note_type 12, 11, 0
	note F_, 12
	note_type 12, 12, 2
	note A#, 2
	note __, 16
	note_type 12, 12, 7
	dutycycle $0
	octave 3
	note_type 12, 12, 3
	note G#, 2
	note A#, 2
	note F_, 2
	note_type 12, 12, 7
	note G#, 10
	note A#, 1
	note __, 1
	note G_, 12
	note __, 8
	note_type 12, 12, 3
	note F_, 2
	note G_, 2
	note A#, 2
	note_type 6, 12, 7
	note G#, 1
	note A#, 1
	note G#, 2
	note_type 12, 12, 7
	note G_, 2
	note F_, 2
	note G_, 2
	note D_, 2
	note F_, 10
	note D#, 1
	note D_, 1
	note D#, 10
	note __, 10
	note_type 12, 12, 3
	note C_, 2
	note D_, 2
	note G_, 2
	note_type 6, 12, 7
	note F_, 1
	note G_, 1
	note F_, 2
	note_type 12, 12, 7
	note D#, 2
	note C_, 2
	note D_, 2
	note D#, 2
	note A#, 10
	octave 4
	note C_, 2
	octave 3
	note G#, 10
	note __, 10
	note C_, 2
	note D#, 2
	octave 4
	note C_, 2
	note_type 6, 12, 7
	octave 3
	note A#, 1
	octave 4
	note C_, 1
	octave 3
	note A#, 2
	note_type 12, 12, 7
	note G#, 2
	note G_, 2
	note G#, 2
	note D#, 2
	note F_, 16
	note __, 6
	note G_, 2
	note G#, 2
	note __, 10
	note_type 12, 6, 7
	dutycycle $2
	octave 4
	note D_, 1
	note C_, 1
	octave 3
	note A#, 1
	octave 4
	note C_, 1
	note D_, 1
	note D#, 1
	note F_, 1
	note D#, 1
	note D_, 1
	note D#, 1
	note G_, 1
	note G#, 1
	note_type 12, 12, 7
	dutycycle $0
	octave 2
	note D#, 2
	note __, 2
	note D#, 2
	note __, 4
	octave 1
	note A#, 2
	octave 2
	note D#, 2
	note __, 2
	note D#, 2
	note __, 4
	octave 1
	note A#, 2
	octave 2
	note D#, 2
	note __, 2
	note D#, 2
	note __, 4
	octave 1
	note A#, 2
	octave 2
	note D#, 2
	note __, 2
	note D#, 2
	note __, 4
	octave 1
	note A#, 2
	octave 2
	note G#, 2
	note __, 2
	note G#, 2
	note __, 4
	note D#, 2
	note G#, 2
	note __, 2
	note G#, 2
	note __, 4
	note D#, 2
	note A#, 2
	note __, 2
	note A#, 2
	note __, 4
	note F_, 2
	note A#, 2
	note __, 2
	note A#, 2
	note __, 4
	note F_, 2
	note D#, 2
	note __, 2
	note D#, 2
	note __, 4
	octave 1
	note A#, 2
	octave 2
	note D#, 2
	note __, 2
	note D#, 2
	note __, 4
	octave 1
	note A#, 2
	octave 2
	note D#, 2
	note __, 2
	note D#, 2
	note __, 4
	octave 1
	note A#, 2
	octave 2
	note D#, 2
	note __, 2
	note D#, 2
	note __, 4
	octave 1
	note A#, 2
	octave 2
	note G#, 2
	note __, 2
	note G#, 2
	note __, 4
	note D#, 2
	note A#, 2
	note __, 2
	note A#, 2
	note __, 4
	note F_, 2
	octave 3
	note D#, 2
	note __, 2
	note D#, 2
	note __, 4
	octave 2
	note A#, 2
	note D#, 2
	note __, 2
	note D#, 2
	note __, 6
	jumpchannel Music_DewfordTownRSE_Ch2_b0

Music_DewfordTownRSE_Ch3:
	stereopanning $ff
Music_DewfordTownRSE_Ch3_b0:
	note_type 12, 1, 1
	octave 5
	note A#, 1
	note G#, 1
	note F_, 1
	note D_, 1
	octave 4
	note A#, 1
	note F_, 1
	octave 5
	note G#, 1
	note F_, 1
	note D_, 1
	octave 4
	note A#, 1
	note F_, 1
	note D_, 1
	octave 5
	note G_, 1
	note F_, 1
	note D_, 1
	octave 4
	note A#, 1
	note F_, 1
	note D_, 1
	octave 5
	note F_, 1
	note D_, 1
	octave 4
	note A#, 1
	note F_, 1
	note D_, 1
	octave 3
	note A#, 1
	octave 5
	note D_, 1
	octave 4
	note A#, 1
	note F_, 1
	note D_, 1
	note F_, 1
	note A#, 1
	octave 5
	note D_, 1
	octave 4
	note F_, 1
	note A#, 1
	octave 5
	note D_, 1
	note F_, 1
	note G#, 1
	note A#, 1
	note G#, 1
	note F_, 1
	note G#, 1
	note F_, 1
	note D_, 1
	note F_, 1
	note D_, 1
	octave 4
	note A#, 1
	octave 5
	note D_, 1
	octave 4
	note A#, 1
	note F_, 1
	note_type 12, 1, 2
	octave 3
	note D#, 2
	note __, 2
	note D#, 2
	note __, 2
	note D#, 2
	octave 2
	note A#, 2
	octave 3
	note D#, 2
	note __, 2
	note D#, 2
	note __, 4
	octave 2
	note A#, 2
	octave 3
	note D#, 2
	note __, 2
	note D#, 2
	note __, 2
	note D#, 2
	octave 2
	note A#, 2
	octave 3
	note D#, 2
	note __, 2
	note D#, 2
	note D_, 2
	note __, 2
	note D_, 2
	note C_, 2
	note __, 2
	note C_, 2
	note __, 2
	note C_, 2
	octave 2
	note G_, 2
	octave 3
	note C_, 2
	note __, 2
	note C_, 2
	note __, 4
	octave 2
	note G_, 2
	octave 3
	note C_, 2
	note __, 2
	note C_, 2
	note __, 2
	note C_, 2
	octave 2
	note G_, 2
	octave 3
	note C_, 2
	note __, 2
	note C_, 2
	octave 2
	note A#, 2
	note __, 2
	note A#, 2
	note G#, 2
	note __, 2
	note G#, 2
	note __, 2
	note G#, 2
	note D#, 2
	note G#, 2
	note __, 2
	note G#, 2
	note __, 4
	note D#, 2
	note G#, 2
	note __, 2
	note G#, 2
	note __, 2
	note G#, 2
	note D#, 2
	note G#, 2
	note __, 2
	note G#, 2
	note __, 4
	note D#, 2
	note A#, 2
	note __, 2
	note A#, 2
	note __, 2
	note A#, 2
	note F_, 2
	note A#, 2
	note __, 2
	note A#, 2
	note __, 4
	note F_, 2
	note A#, 2

	note __, 16
	note __, 6
	octave 3
	note D#, 2
	note __, 2
	note D#, 2
	note __, 2
	note D#, 2
	octave 2
	note A#, 2
	octave 3
	note D#, 2
	note __, 2
	note D#, 2
	note __, 4
	octave 2
	note A#, 2
	octave 3
	note D#, 2
	note __, 2
	note D#, 2
	note __, 2
	note D#, 2
	octave 2
	note A#, 2
	octave 3
	note D#, 2
	note D#, 2
	note __, 2
	note D_, 2
	note __, 2
	note D_, 2
	note C_, 2
	note __, 2
	note C_, 2
	note __, 2
	note C_, 2
	octave 2
	note G_, 2
	octave 3
	note C_, 2
	note __, 2
	note C_, 2
	note __, 4
	octave 2
	note G_, 2
	octave 3
	note C_, 2
	note __, 2
	note C_, 2
	note __, 2
	note C_, 2
	octave 2
	note G_, 2
	octave 3
	note C_, 2
	note C_, 2
	note __, 2
	octave 2
	note A#, 2
	note __, 2
	note A#, 2
	note G#, 2
	note __, 2
	note G#, 2
	note __, 2
	note G#, 2
	note D#, 2
	note G#, 2
	note __, 2
	note G#, 2
	note __, 4
	note D#, 2
	note G#, 2
	note __, 2
	note G#, 2
	note __, 2
	note G#, 2
	note D#, 2
	note G#, 2
	note __, 2
	note G#, 2
	note __, 4
	note D#, 2
	note A#, 2
	note __, 2
	note A#, 2
	note __, 2
	note A#, 2
	note F_, 2
	note A#, 2
	note __, 2
	note A#, 2
	note __, 4
	note F_, 2
	note A#, 1

	note __, 16
	note __, 6
	vibrato $14, $14
	note_type 6, 1, 0
	note __, 1
	octave 5
	note A#, 1
	note_type 12, 1, 0
	octave 6
	note F_, 4
	note D#, 2
	note __, 5
	note_type 6, 1, 0
	octave 5
	note A#, 1
	octave 6
	note D_, 1
	note_type 12, 1, 0
	note F_, 4
	note D#, 2
	note __, 4
	octave 5
	note A#, 1
	octave 6
	note D_, 1
	note F_, 4
	note D#, 1
	note __, 1
	note D_, 1
	note __, 1
	note D#, 1
	note __, 1
	octave 5
	note A#, 1
	note_type 6, 1, 0
	note __, 1
	note G#, 1
	note_type 12, 1, 0
	octave 6
	note G_, 6
	note F_, 4
	note D#, 2
	note G#, 2
	note G_, 2
	note F_, 2
	note D#, 10
	note_type 6, 1, 0
	note C#, 1
	note C_, 3
	note_type 12, 1, 0
	note G_, 1
	note __, 1
	note F_, 1
	note __, 1
	note D#, 1
	note __, 1
	note F_, 16
	note __, 2
	note A#, 1
	note G#, 1
	note G_, 1
	note F_, 1
	note D#, 1
	note E_, 1
	note F_, 4
	note D#, 2
	note __, 2
	note D#, 1
	note __, 1
	octave 5
	note A#, 1
	octave 6
	note D_, 1
	note F_, 4
	note D#, 2
	note __, 2
	note D#, 1
	note __, 1
	octave 5
	note A#, 1
	octave 6
	note D_, 1
	note F_, 4
	note D#, 1
	note __, 1
	note D_, 1
	note __, 1
	note D#, 1
	note __, 1
	octave 5
	note A#, 1
	note __, 1
	octave 6
	note G_, 2
	note G#, 1
	note __, 1
	note A#, 1
	note __, 1
	octave 7
	note C_, 1
	note __, 1
	octave 6
	note A#, 1
	note __, 1
	note G_, 1
	note __, 1
	note D#, 6
	note G#, 1
	note G_, 1
	note F_, 1
	note D#, 1
	note C_, 1
	note D#, 1
	note C_, 6
	note D_, 4
	note D#, 1
	note __, 1
	note D#, 16
	note __, 8
	jumpchannel Music_DewfordTownRSE_Ch3_b0

Music_DewfordTownRSE_Ch4:
	togglenoise $2
Music_DewfordTownRSE_Ch4_b0:
Music_DewfordTownRSE_Ch4_b1:
	note_type 12
	note 3, 4
	note 8, 2
	note 8, 4
	note 8, 2
	loopchannel 19, Music_DewfordTownRSE_Ch4_b1
	note 1, 1
	note 1, 1
	note 8, 1
	note 1, 1
	note 8, 2
	note 8, 2
	note 1, 1
	note __, 3
Music_DewfordTownRSE_Ch4_b2:
	note __, 6
	note 1, 6
	loopchannel 7, Music_DewfordTownRSE_Ch4_b2
	note __, 2
	note 1, 2
	note __, 2
	note 1, 2
	note __, 2
	note 1, 2
Music_DewfordTownRSE_Ch4_b3:
	note __, 6
	note 1, 6
	loopchannel 6, Music_DewfordTownRSE_Ch4_b3
	note __, 2
	note 1, 4
	note 1, 2
	note 8, 2
	note 8, 2

	note 8, 2
	note __, 2
	note 1, 2
	note 1, 2
	note 1, 1
	note 1, 1
	note 9, 2
Music_DewfordTownRSE_Ch4_b4:
	note __, 6
	note 1, 6
	loopchannel 7, Music_DewfordTownRSE_Ch4_b4
	note 1, 1
	note 1, 1
	note __, 1
	note 1, 3
	note 1, 4
	note 1, 2
Music_DewfordTownRSE_Ch4_b5:
	note __, 6
	note 1, 6
	loopchannel 7, Music_DewfordTownRSE_Ch4_b5
	note 1, 1
	note 1, 1
	note __, 1
	note 1, 3
	note 1, 4
	note 1, 2
	jumpchannel Music_DewfordTownRSE_Ch4_b0
