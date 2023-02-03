; Pokémon HG/SS - Cianwood City
; Demixed by Mmmmmm
; https://pastebin.com/GguFiV8e

Music_CianwoodCityHGSS:
	channel_count 3
	channel 1, Music_CianwoodCityHGSS_Ch1
	channel 2, Music_CianwoodCityHGSS_Ch2
	channel 3, Music_CianwoodCityHGSS_Ch3

Music_CianwoodCityHGSS_Ch1:
	tempo 197
	volume 7, 7
	stereopanning $f
	vibrato $12, $25
	duty_cycle 2
Music_CianwoodCityHGSS_branch_ef2e5:
	note_type 12, 5, 7
	note __, 10
	octave 3
	note F#, 6
	note __, 10
	note F#, 6
	note __, 16
	note F_, 4
	note F#, 4
	note G#, 4
	intensity $60
	note __, 4
	note __, 16
	note __, 10
	octave 4
	note C#, 2
	note D#, 2
	note E_, 2
	note __, 8
	note D_, 2
	note C#, 2
	octave 3
	note B_, 2
	octave 4
	note F#, 6
	note_type 6, 6, 7
	note G_, 4
	note G#, 10
	note __, 2
	stereopanning $ff
	note F_, 8
	stereopanning $f
	octave 3
	note E_, 1
	note F_, 11
	note F#, 4
	note A#, 4
	octave 4
	note C#, 12
	note E_, 12
	note C#, 4
	note __, 4
	note E_, 4
	note G_, 4
	note A#, 2
	note __, 2
	octave 3
	note D#, 8
	note F#, 8
	note B_, 4
	note __, 12
	note A#, 1
	note B_, 11
	octave 4
	note C#, 2
	note __, 2
	note D#, 4
	note C#, 4
	note __, 8
	intensity $52
	callchannel Music_CianwoodCityHGSS_branch_ef37f
	note G#, 2
	note F_, 2
	note D#, 2
	note F_, 2
	note D#, 2
	note F_, 2
	note G#, 2
	note F_, 2
	note G#, 2
	note F_, 2
	note D#, 2
	note F_, 2
	note D#, 2
	note F_, 2
	note D#, 2
	note F_, 2
	callchannel Music_CianwoodCityHGSS_branch_ef391
	octave 5
	intensity $52
	note E_, 2
	note C#, 2
	octave 4
	note A#, 2
	note G_, 2
	octave 5
	note C#, 2
	octave 4
	note A#, 2
	note G_, 2
	note E_, 2
	note A#, 2
	note G_, 2
	note E_, 2
	note C#, 2
	note E_, 2
	note C#, 2
	octave 3
	note A#, 2
	note G_, 2
	octave 4
	callchannel Music_CianwoodCityHGSS_branch_ef37f
	note G#, 2
	note F#, 2
	note D_, 2
	note F#, 2
	note D_, 2
	note F#, 2
	note G#, 2
	note F#, 2
	note G#, 2
	note F#, 2
	note D_, 2
	note F#, 2
	note D_, 2
	note F#, 2
	note D_, 2
	note F#, 2
	callchannel Music_CianwoodCityHGSS_branch_ef391
	jumpchannel Music_CianwoodCityHGSS_branch_ef2e5

Music_CianwoodCityHGSS_branch_ef37f:
	note A#, 2
	note F#, 2
	note D#, 2
	note F#, 2
	note D#, 2
	note F#, 2
	note A#, 2
	note F#, 2
	loopchannel 2, Music_CianwoodCityHGSS_branch_ef37f
	endchannel

Music_CianwoodCityHGSS_branch_ef391:
	note G#, 2
	note F_, 2
	note C#, 2
	note F_, 2
	note C#, 2
	note F_, 2
	note G#, 2
	note F_, 2
	note G#, 2
	note F_, 2
	note C#, 2
	note F_, 2
	note C#, 2
	note F_, 2
	note G#, 2
	note B_, 2
	octave 5
	note D#, 2
	octave 4
	note A#, 2
	note F#, 2
	note D#, 2
	note A#, 2
	note F#, 2
	note D#, 2
	note A#, 2
	note F#, 2
	note D#, 2
	octave 3
	note A#, 2
	note F#, 2
	note D#, 2
	note A#, 2
	note F#, 2
	note D#, 2
Music_CianwoodCityHGSS_branch_ef3be:
	octave 3
	note B_, 2
	octave 4
	note D#, 2
	note F#, 2
	note D#, 2
	note F#, 2
	note D#, 2
	note F#, 2
	note B_, 2
	loopchannel 2, Music_CianwoodCityHGSS_branch_ef3be
Music_CianwoodCityHGSS_branch_ef3d0:
	octave 4
	note C#, 2
	note F_, 2
	note G#, 2
	note F_, 2
	note G#, 2
	note F_, 2
	note G#, 2
	octave 5
	note C#, 2
	loopchannel 2, Music_CianwoodCityHGSS_branch_ef3d0
	intensity $50
	duty_cycle 0
	octave 4
	note A#, 16
	octave 5
	note C#, 16
	duty_cycle 2
	endchannel

Music_CianwoodCityHGSS_Ch2:
	vibrato $12, $25
	duty_cycle 3
	stereopanning $f0
Music_CianwoodCityHGSS_branch_ef3f2:
	note_type 6, 6, 7
	note __, 16
	note __, 5
	octave 4
	note C#, 1
	note G#, 1
	note A#, 9
	note __, 16
	note __, 5
	note D#, 1
	note A#, 1
	note B_, 9
	note_type 12, 7, 7
	note __, 10
	note G#, 2
	note F#, 2
	note D_, 2
	note C#, 4
	note D#, 4
	note F_, 4
	note_type 6, 9, 3
	intensity $97
	duty_cycle 2
	octave 3
	note C#, 7
	note G_, 1
	note G#, 11
	note __, 1
	note F#, 2
	note __, 2
	note F#, 16
	note B_, 8
	note __, 4
	note A#, 4
	note __, 4
	note A#, 4
	note B_, 4
	octave 4
	note C#, 4
	octave 3
	note A#, 4
	note F#, 2
	note __, 2
	note F#, 4
	note D#, 2
	octave 2
	note B_, 1
	octave 3
	note D#, 1
	note F#, 16
	note A#, 4
	octave 4
	note C#, 2
	note __, 2
	octave 3
	note A#, 4
	note G#, 10
	note __, 1
	stereopanning $ff
	note A_, 9
	stereopanning $f0
	duty_cycle 0
	octave 4
	note G_, 1
	note G#, 11
	note F#, 2
	note __, 2
	note F#, 16
	note B_, 12
	note A#, 4
	note __, 4
	note A#, 4
	note B_, 4
	octave 5
	note C#, 2
	octave 4
	note D#, 1
	note F#, 1
	note A#, 1
	octave 5
	note D#, 3
	octave 4
	note A#, 2
	note __, 2
	note A#, 4
	note F#, 2
	note __, 2
	note F#, 4
	note D#, 2
	note __, 2
	note F_, 4
	note F#, 2
	note C#, 1
	note F_, 1
	note A_, 1
	note A#, 11
	note G#, 2
	note __, 2
	note G#, 8
	duty_cycle 1
	octave 3
	note A#, 4
	octave 4
	note C#, 3
	note D_, 1
	note D#, 16
	octave 3
	note D#, 4
	note F#, 2
	note __, 2
	note A#, 4
	note G#, 12
	note F#, 4
	note __, 4
	note F_, 4
	note __, 4
	note B_, 8
	octave 4
	note C#, 12
	octave 3
	note B_, 8
	note __, 4
	note A#, 8
	note G#, 4
	note F#, 2
	note __, 2
	note F_, 4
	note F#, 2
	note __, 6
	note F_, 4
	note __, 4
	note F#, 4
	note D#, 16
	note __, 4
	note B_, 4
	note A#, 4
	note G#, 4
	note F#, 12
	note F_, 4
	note __, 4
	note F#, 4
	note G#, 4
	note A_, 4
	note_type 12, 8, 3
	note A#, 16
	intensity $80
	note G#, 4
	note G_, 4
	note B_, 4
	note_type 6, 8, 0
	octave 4
	note C#, 7
	note D_, 1
	intensity $87
	note D#, 12
	octave 3
	note A#, 2
	note __, 2
	note A#, 2
	note __, 2
	note A#, 3
	octave 4
	note D_, 1
	note D#, 4
	octave 3
	note A#, 2
	note __, 2
	note A#, 4
	note G#, 2
	note __, 2
	note G_, 4
	note G#, 12
	note F_, 4
	note B_, 4
	octave 4
	note C#, 12
	octave 3
	note G#, 2
	note __, 2
	note G#, 2
	note __, 2
	note G#, 4
	octave 4
	note C#, 4
	octave 3
	note G#, 2
	note __, 1
	octave 4
	note E_, 1
	note F_, 12
	note F#, 4
	note D#, 8
	octave 3
	note D#, 4
	note F#, 4
	note_type 12, 8, 7
	note B_, 10
	octave 4
	note C#, 2
	octave 3
	note B_, 2
	note A#, 2
	note G#, 8
	note __, 2
	note F_, 2
	note F#, 2
	note G#, 2
	note A#, 16
	jumpchannel Music_CianwoodCityHGSS_branch_ef3f2

Music_CianwoodCityHGSS_Ch3:
	stereopanning $ff
Music_CianwoodCityHGSS_branch_ef4e3:
	vibrato $12, $25
	note_type 12, 2, 5
	octave 2
	note F#, 2
	octave 3
	note C#, 2
	note G#, 2
	note A#, 10
	octave 2
	note F#, 2
	octave 3
	note D#, 2
	note A#, 2
	note B_, 10
	octave 2
	note F#, 2
	octave 3
	note C#, 2
	note G#, 2
	note A#, 10
	octave 4
	note C#, 4
	note C_, 4
	octave 3
	note B_, 4
	note F_, 2
	note C#, 2
	octave 2
	note F#, 2
	octave 3
	note C#, 2
	note G#, 2
	note A#, 10
	octave 2
	note G_, 2
	octave 3
	note C#, 2
	note E_, 2
	note G#, 2
	note __, 2
	note G_, 2
	note G#, 2
	note A#, 2
	octave 2
	note G#, 2
	octave 3
	note D#, 1
	note __, 1
	note A#, 2
	note B_, 1
	note __, 1
	octave 4
	note D_, 8
	note C#, 2
	octave 3
	note G#, 2
	note B_, 2
	octave 4
	note D_, 2
	note F_, 2
	note C#, 1
	note D_, 5
	octave 2
	note F#, 2
	octave 3
	note C#, 2
	note G#, 2
	note A#, 2
	octave 4
	note C#, 2
	note F#, 2
	note G#, 2
	note A#, 2
	octave 2
	note G_, 2
	octave 3
	note E_, 2
	note G#, 2
	note G_, 2
	note A#, 2
	note G#, 2
	note B_, 2
	octave 3
	note C#, 1
	note __, 1
	octave 2
	note B_, 8
	octave 4
	note D#, 2
	note F#, 1
	note __, 1
	note G#, 2
	note A#, 1
	note __, 1
	octave 2
	note C#, 2
	note G#, 2
	octave 3
	note C#, 2
	note C_, 2
	note D#, 2
	note C#, 2
	note F_, 2
	note G#, 2
	callchannel Music_CianwoodCityHGSS_branch_ef569
	note F#, 8
	note A#, 8
	octave 4
	note C#, 8
	note F_, 8
	note E_, 8
	note C#, 8
	octave 3
	note A#, 8
	note G_, 8
	note_type 12, 2, 5
	callchannel Music_CianwoodCityHGSS_branch_ef569
	note F#, 8
	note C#, 8
	octave 2
	note A#, 8
	note G#, 8
	jumpchannel Music_CianwoodCityHGSS_branch_ef4e3

Music_CianwoodCityHGSS_branch_ef569:
	octave 2
	note B_, 4
	note __, 2
	note B_, 1
	note __, 1
	note B_, 4
	note __, 2
	note F#, 1
	note __, 1
	note B_, 4
	note __, 2
	note B_, 1
	note __, 1
	note B_, 1
	note __, 1
	note B_, 2
	note __, 2
	note B_, 1
	note __, 1
	note A#, 4
	note __, 2
	octave 3
	note F_, 1
	note __, 1
	octave 2
	note A#, 1
	note __, 1
	note A#, 2
	note __, 2
	octave 3
	note F_, 1
	note __, 1
	note D#, 4
	note __, 2
	note D#, 1
	note __, 1
	note D_, 1
	note __, 1
	note D_, 1
	note __, 1
	note C#, 1
	note __, 1
	note C_, 1
	note __, 1
	octave 2
	note G#, 4
	note __, 2
	octave 3
	note D#, 1
	note __, 1
	octave 2
	note G#, 1
	note __, 1
	note G#, 1
	note __, 1
	note A#, 1
	note __, 1
	note B_, 1
	note __, 1
	octave 3
	note C#, 4
	note __, 2
	note G#, 1
	note __, 1
	note C#, 1
	note __, 1
	note C#, 1
	note __, 1
	note D#, 1
	note __, 1
	note E_, 1
	note_type 6, 2, 5
	note __, 1
	note F_, 1
	endchannel
