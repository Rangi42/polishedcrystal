Music_DragonsDen:
	channel_count 4
	channel 1, Music_DragonsDen_Ch1
	channel 2, Music_DragonsDen_Ch2
	channel 3, Music_DragonsDen_Ch3
	channel 4, Music_DragonsDen_Ch4

Music_DragonsDen_Ch1:
	tempo 144
	volume 7, 7
	dutycycle $0
	tone $0004
	stereopanning $f0
	note_type 12, 8, 0
Music_DragonsDen_branch_eed03:
	callchannel Music_DragonsDen_branch_eed1e
	note __, 16
	callchannel Music_DragonsDen_branch_eed2d
	note __, 2
	callchannel Music_DragonsDen_branch_eed2d
	note __, 2
	callchannel Music_DragonsDen_branch_eed2d
	note __, 2
	callchannel Music_DragonsDen_branch_eed2d
	note __, 10
	note_type 12, 11, 7
	jumpchannel Music_DragonsDen_branch_eed03

Music_DragonsDen_branch_eed1e:
	octave 3
	note A#, 12
	note A_, 4
	note A#, 12
	note A_, 4
	note A#, 6
	octave 4
	note C_, 4
	note C#, 6
	note E_, 16
	note D#, 12
	note D_, 4
	octave 3
	note G#, 16
	endchannel

Music_DragonsDen_branch_eed2d:
	intensity $b1
	note __, 2
	octave 4
	note C#, 3
	note C#, 3
	note C#, 3
	note C#, 3
	note C#, 4
	note C#, 3
	note C#, 3
	note C#, 4
	note C#, 2
	note C#, 2
	endchannel

Music_DragonsDen_Ch2:
	dutycycle $0
	tone $0004
	stereopanning $f
	note_type 12, 9, 0
Music_DragonsDen_branch_eed46:
	callchannel Music_DragonsDen_branch_eed5e
	note __, 16
	callchannel Music_DragonsDen_branch_eed6b
	callchannel Music_DragonsDen_branch_eed6b
	callchannel Music_DragonsDen_branch_eed6b
	callchannel Music_DragonsDen_branch_eed6b
	note __, 16
	note_type 12, 12, 7
	jumpchannel Music_DragonsDen_branch_eed46

Music_DragonsDen_branch_eed5e:
	octave 4
	note D#, 12
	note D_, 4
	note D#, 12
	note D_, 4
	note D#, 6
	note F_, 4
	note F#, 6
	note A_, 16
	note G#, 12
	note G_, 4
	note C#, 16
	endchannel

Music_DragonsDen_branch_eed6b:
	intensity $c1
Music_DragonsDen_branch_eed6d:
	octave 5
	note C#, 4
	octave 4
	note G#, 4
	note G#, 4
	note G#, 4
	loopchannel 2, Music_DragonsDen_branch_eed6d
	endchannel

Music_DragonsDen_Ch3:
Music_DragonsDen_branch_eed78:
	note_type 12, 1, 4
	octave 4
	note C#, 2
	octave 3
	note G#, 1
	octave 4
	note C#, 1
	octave 3
	note G#, 2
	octave 4
	note C#, 2
	octave 3
	note G#, 1
	octave 4
	note C#, 1
	octave 3
	note G#, 2
	octave 4
	note C#, 2
	octave 3
	note G#, 1
	octave 4
	note C#, 1
	loopchannel 15, Music_DragonsDen_branch_eed78
	note __, 16
	note_type 6, 2, 7
Music_DragonsDen_branch_eed99:
	octave 3
	note C#, 4
	octave 2
	note G#, 2
	octave 3
	note C#, 2
	octave 2
	note G#, 4
	octave 3
	note C#, 4
	octave 2
	note G#, 2
	octave 3
	note C#, 2
	octave 2
	note G#, 4
	octave 3
	note C#, 4
	octave 2
	note G#, 2
	octave 3
	note C#, 2
	loopchannel 16, Music_DragonsDen_branch_eed99
	jumpchannel Music_DragonsDen_branch_eed78

Music_DragonsDen_Ch4:
	togglenoise $0
	note_type 12
	note __, 16
	note __, 16
Music_DragonsDen_branch_eedbd:
	stereopanning $f0
	note F_, 4
	stereopanning $f
	note F#, 4
	note F#, 4
	stereopanning $f0
	note F#, 4
	jumpchannel Music_DragonsDen_branch_eedbd
