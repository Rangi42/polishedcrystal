Music_RuinsOfAlphRadio:
	channel_count 3
	channel 1, Music_RuinsOfAlphRadio_Ch1
	channel 2, Music_RuinsOfAlphRadio_Ch2
	channel 3, Music_RuinsOfAlphRadio_Ch3

Music_RuinsOfAlphRadio_Ch1:
	tempo 160
	volume 7, 7
	dutycycle $0
	tone $0118
	vibrato $0, $f0
	stereopanning $f0
Music_RuinsOfAlphRadio_branch_eede3:
	notetype $6, $71
	callchannel Music_RuinsOfAlphRadio_branch_eee01
	notetype $c, $a1
	note __, 16
	note __, 16
	callchannel Music_RuinsOfAlphRadio_branch_eee08
	notetype $c, $a1
	note __, 16
	note __, 16
	callchannel Music_RuinsOfAlphRadio_branch_eee01
	notetype $c, $a1
	note __, 16
	jumpchannel Music_RuinsOfAlphRadio_branch_eede3

Music_RuinsOfAlphRadio_branch_eee01:
	octave 4
	note G_, 1
	note F#, 1
	note G_, 1
	note F#, 1
	note C_, 8
	endchannel

Music_RuinsOfAlphRadio_branch_eee08:
	octave 4
	note G_, 1
	note F#, 1
	note G_, 1
	note F#, 1
	note C_, 4
	note G_, 1
	octave 5
	note C_, 8
	endchannel

Music_RuinsOfAlphRadio_Ch2:
	dutycycle $1
	vibrato $1, $e0
Music_RuinsOfAlphRadio_branch_eee17:
	stereopanning $f
	notetype $6, $81
	callchannel Music_RuinsOfAlphRadio_branch_eee01
	notetype $c, $a1
	note __, 16
	note __, 16
	notetype $6, $81
	callchannel Music_RuinsOfAlphRadio_branch_eee08
	notetype $c, $a1
	note __, 16
	jumpchannel Music_RuinsOfAlphRadio_branch_eee17

Music_RuinsOfAlphRadio_Ch3:
	notetype $6, $26
Music_RuinsOfAlphRadio_branch_eee35:
	octave 2
	note C_, 1
	note C#, 1
	note C_, 1
	note __, 16
	jumpchannel Music_RuinsOfAlphRadio_branch_eee35
