Music_IndigoPlateau:
	channel_count 4
	channel 1, Music_IndigoPlateau_Ch1
	channel 2, Music_IndigoPlateau_Ch2
	channel 3, Music_IndigoPlateau_Ch3
	channel 4, Music_IndigoPlateau_Ch4

Music_IndigoPlateau_Ch1:
	tempo 128
	volume 7, 7
	dutycycle $3
	tone $0002
	stereopanning $f
Music_IndigoPlateau_branch_ee86a:
	callchannel Music_IndigoPlateau_branch_ee881
	octave 3
	note D_, 4
	callchannel Music_IndigoPlateau_branch_ee881
	octave 3
	note D#, 4
	callchannel Music_IndigoPlateau_branch_ee881
	octave 3
	note D#, 4
	callchannel Music_IndigoPlateau_branch_ee881
	note A#, 4
	jumpchannel Music_IndigoPlateau_branch_ee86a

Music_IndigoPlateau_branch_ee881:
	note_type 12, 11, 6
	octave 2
	note A_, 4
	intensity $b2
	note A_, 2
	note A_, 2
	note A_, 2
	note A_, 2
	note A_, 4
	note A_, 2
	note A_, 2
	intensity $a0
	endchannel

Music_IndigoPlateau_Ch2:
	dutycycle $3
	vibrato $10, $22
	stereopanning $f0
Music_IndigoPlateau_branch_ee899:
	callchannel Music_IndigoPlateau_branch_ee8e9
	note A_, 4
	callchannel Music_IndigoPlateau_branch_ee8e9
	note A#, 4
	callchannel Music_IndigoPlateau_branch_ee8e9
	note A_, 4
	callchannel Music_IndigoPlateau_branch_ee8e9
	note C#, 4
	intensity $c7
	note A_, 6
	note D_, 2
	note G_, 2
	note A#, 2
	note A_, 8
	intensity $b0
	note A_, 4
	callchannel Music_IndigoPlateau_branch_ee8e9
	note A#, 4
	intensity $c7
	octave 4
	note D_, 6
	note D#, 2
	note C_, 4
	note D_, 8
	intensity $b0
	octave 3
	note A_, 4
	callchannel Music_IndigoPlateau_branch_ee8e9
	note C#, 4
	intensity $c7
	octave 4
	note C_, 6
	octave 3
	note A#, 2
	note A_, 2
	note G_, 2
	note F#, 8
	intensity $b0
	note A_, 4
	callchannel Music_IndigoPlateau_branch_ee8e9
	note A#, 4
	intensity $c7
	octave 4
	note D_, 6
	note D#, 2
	note F_, 4
	note F#, 8
	intensity $b0
	octave 3
	note A_, 4
	callchannel Music_IndigoPlateau_branch_ee8e9
	note C#, 4
	jumpchannel Music_IndigoPlateau_branch_ee899

Music_IndigoPlateau_branch_ee8e9:
	note_type 12, 12, 6
	octave 3
	note D_, 4
	intensity $c2
	note D_, 2
	note D_, 2
	note D_, 2
	note D_, 2
	note D_, 4
	note D_, 2
	note D_, 2
	intensity $b0
	endchannel

Music_IndigoPlateau_Ch3:
	note_type 12, 1, -1
Music_IndigoPlateau_branch_ee8fd:
	callchannel Music_IndigoPlateau_branch_ee915
	octave 3
	note A_, 4
	callchannel Music_IndigoPlateau_branch_ee915
	octave 3
	note A_, 4
	callchannel Music_IndigoPlateau_branch_ee915
	octave 3
	note A_, 4
	callchannel Music_IndigoPlateau_branch_ee915
	octave 3
	note F#, 4
	jumpchannel Music_IndigoPlateau_branch_ee8fd

Music_IndigoPlateau_branch_ee915:
	octave 3
	note D_, 1
	note __, 3
	octave 2
	note A_, 1
	note __, 3
	octave 3
	note C_, 1
	note __, 3
	note D_, 1
	note __, 3
	octave 2
	note A_, 1
	note __, 3
	endchannel

Music_IndigoPlateau_Ch4:
	stereopanning $f0
	togglenoise $0
	note_type 12
Music_IndigoPlateau_branch_ee92a:
	note D#, 4
	note D_, 2
	note D#, 2
	note D#, 2
	note D#, 2
	note D_, 4
	note D_, 2
	note D_, 2
	note_type 6
	note D_, 1
	note D_, 1
	note D#, 1
	note D#, 1
	note D#, 1
	note D#, 1
	note D_, 1
	note D_, 1
	note_type 12
	note D#, 4
	note D_, 2
	note D#, 2
	note D#, 2
	note D_, 2
	note C#, 4
	note D_, 2
	note D_, 2
	note C#, 4
	jumpchannel Music_IndigoPlateau_branch_ee92a
