Music_LookOfficer:
	channel_count 3
	channel 1, Music_LookOfficer_Ch1
	channel 2, Music_LookOfficer_Ch2
	channel 3, Music_LookOfficer_Ch3

Music_LookOfficer_Ch1:
	tempo 116
	volume 7, 7
	tone $0001
	vibrato $12, $34
	stereopanning $f
	dutycycle $3
	note_type 12, 10, 7
	octave 4
	note C#, 1
	note D_, 1
	note D#, 1
	note E_, 1
	note F_, 12
	intensity $2f
	octave 3
	note B_, 16
Music_LookOfficer_branch_ed852:
	intensity $82
	note __, 4
	note B_, 6
	note G#, 4
	note B_, 6
	note B_, 6
	note G#, 4
	note B_, 2
	intensity $2f
	note A#, 16
	note A_, 16
	jumpchannel Music_LookOfficer_branch_ed852

Music_LookOfficer_Ch2:
	vibrato $12, $34
	dutycycle $3
	note_type 12, 11, 7
	octave 5
	note D#, 1
	note D_, 1
	note C#, 1
	note C_, 1
	octave 4
	note B_, 12
	dutycycle $3
	intensity $a2
	octave 1
	note B_, 4
	octave 2
	note A_, 2
	octave 1
	note B_, 4
	octave 2
	note F_, 2
	octave 1
	note B_, 2
	octave 2
	note D#, 2
Music_LookOfficer_branch_ed882:
	note E_, 2
	note G#, 2
	octave 3
	note E_, 2
	octave 2
	note E_, 2
	note G#, 2
	note B_, 2
	note E_, 2
	note G#, 2
	loopchannel 2, Music_LookOfficer_branch_ed882
	pitchoffset 0, C#
	callchannel Music_LookOfficer_branch_ed89e
	pitchoffset 0, C_
	callchannel Music_LookOfficer_branch_ed89e
	jumpchannel Music_LookOfficer_branch_ed882

Music_LookOfficer_branch_ed89e:
	octave 1
	note A_, 2
	octave 2
	note C#, 2
	note A_, 2
	octave 1
	note A_, 2
	octave 2
	note C#, 2
	note E_, 2
	octave 1
	note A_, 2
	octave 2
	note C#, 2
	endchannel

Music_LookOfficer_Ch3:
	vibrato $14, $14
	stereopanning $f0
	note_type 12, 1, 4
	note __, 10
	octave 3
	note B_, 2
	note __, 2
	note B_, 2
	intensity $12
	octave 5
	note D#, 2
	note __, 1
	note F_, 2
	note __, 1
	note A_, 2
	note B_, 2
	note __, 1
	octave 6
	note C#, 2
	note __, 1
	note D#, 2
Music_LookOfficer_branch_ed8c8:
	note E_, 6
	note D#, 6
	note C#, 4
	octave 5
	note B_, 2
	note A_, 2
	note G#, 2
	note F#, 2
	note G#, 2
	note A_, 2
	note B_, 2
	octave 6
	note C#, 2
	note F_, 8
	note D_, 8
	note E_, 8
	note C#, 8
	jumpchannel Music_LookOfficer_branch_ed8c8
