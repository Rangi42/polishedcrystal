Music_Route3:
	channel_count 4
	channel 1, Music_Route3_Ch1
	channel 2, Music_Route3_Ch2
	channel 3, Music_Route3_Ch3
	channel 4, Music_Route3_Ch4

Music_Route3_Ch1:
	stereopanning $f
	tempo 160
	volume 7, 7
	note_type 12, 9, 1
	note __, 10
	duty_cycle 0
	vibrato $14, $6
	octave 3
	note C#, 1
	note E_, 1
	note C#, 1
	note E_, 1
	note A_, 1
	note E_, 1
	note C#, 1
	note E_, 1
	note A_, 1
	note E_, 1
	note C#, 1
	note E_, 1
	note C#, 1
	note E_, 1
	note C#, 1
	note E_, 1
	note A_, 1
	note F_, 1
	note D_, 1
	note F_, 1
	note D_, 1
	note F_, 1
	note D_, 1
	note F_, 1
	note C#, 1
	note E_, 1
	note A_, 1
	note E_, 1
	note C#, 1
	note E_, 1
	note F#, 1
	note G#, 1
Music_Route3_branch_ec307:
	callchannel Music_Route3_branch_ec3a4
	note G_, 1
	note D_, 1
	octave 2
	note B_, 1
	octave 3
	note D_, 1
	note G_, 1
	note D_, 1
	octave 2
	note B_, 1
	octave 3
	note D_, 1
	note G_, 1
	note D_, 1
	octave 2
	note B_, 1
	octave 3
	note D_, 1
	octave 2
	note B_, 1
	octave 3
	note D_, 1
	octave 2
	note B_, 1
	octave 3
	note D_, 1
	note A_, 1
	note E_, 1
	note C#, 1
	note E_, 1
	note A_, 1
	note E_, 1
	note C#, 1
	note E_, 1
	note A_, 1
	note E_, 1
	note C#, 1
	note E_, 1
	note C#, 1
	note E_, 1
	note C#, 1
	note E_, 1
	note A_, 1
	note E_, 1
	note C#, 1
	note E_, 1
	note A_, 1
	note E_, 1
	note C#, 1
	note E_, 1
	note A_, 1
	note E_, 1
	note C#, 1
	note E_, 1
	note C#, 1
	note E_, 1
	note C#, 1
	note E_, 1
	note G_, 1
	note D_, 1
	octave 2
	note B_, 1
	octave 3
	note D_, 1
	note G_, 1
	note D_, 1
	octave 2
	note B_, 1
	octave 3
	note D_, 1
	note G_, 1
	note D_, 1
	octave 2
	note B_, 1
	octave 3
	note D_, 1
	octave 2
	note B_, 1
	octave 3
	note D_, 1
	octave 2
	note B_, 1
	octave 3
	note D_, 1
	volume_envelope 6, -7
	note G_, 1
	note D_, 1
	volume_envelope 7, 7
	octave 2
	note B_, 1
	octave 3
	note D_, 1
	note G_, 1
	note D_, 1
	note E_, 1
	note G#, 1
	note B_, 4
	volume_envelope 6, -7
	octave 3
	note G#, 2
	note E_, 2
	note A_, 2
	note G#, 2
	note A_, 2
	note E_, 8
	note D#, 1
	note E_, 1
	note G#, 2
	octave 2
	note B_, 4
	octave 3
	note D_, 2
	note E_, 2
	note G#, 2
	note B_, 2
	note A_, 1
	note G#, 1
	note F_, 3
	note E_, 3
	note D_, 2
	octave 2
	note A_, 2
	octave 3
	note D_, 2
	note E_, 2
	note F_, 2
	volume_envelope 9, 1
	note F#, 1
	note D_, 1
	octave 2
	note A_, 1
	octave 3
	note D_, 1
	note F#, 1
	note A_, 1
	note F#, 1
	note A_, 1
	note B_, 1
	note G#, 1
	note E_, 1
	note G#, 1
	note E_, 1
	note G#, 1
	note B_, 1
	octave 4
	note D_, 1
	jumpchannel Music_Route3_branch_ec307

Music_Route3_branch_ec3a4:
	octave 3
	note A_, 1
	note E_, 1
	note C#, 1
	note E_, 1
	loopchannel 3, Music_Route3_branch_ec3a4
	note C#, 1
	note E_, 1
	note C#, 1
	note E_, 1
Music_Route3_branch_ec3b1:
	note A_, 1
	note E_, 1
	note C#, 1
	note E_, 1
	loopchannel 3, Music_Route3_branch_ec3b1
	note C#, 1
	note E_, 1
	note C#, 1
	note E_, 1
Music_Route3_branch_ec3bd:
	note G_, 1
	note D_, 1
	octave 2
	note B_, 1
	octave 3
	note D_, 1
	loopchannel 3, Music_Route3_branch_ec3bd
	octave 2
	note B_, 1
	octave 3
	note D_, 1
	octave 2
	note B_, 1
	octave 3
	note D_, 1
	endchannel

Music_Route3_Ch2:
	stereopanning $f0
	note_type 12, 5, -6
	duty_cycle 2
	vibrato $6, $3
	octave 4
	note E_, 1
	note G_, 1
	note G#, 6
	volume_envelope 8, 7
	note F#, 1
	note G#, 1
	note A_, 1
	note __, 7
	note C#, 4
	note E_, 4
	note D_, 4
	octave 3
	note B_, 4
	octave 4
	note C#, 4
	volume_envelope 10, 7
	duty_cycle 2
	octave 3
	note A_, 1
	octave 4
	note C#, 1
	note E_, 1
	note G#, 1
Music_Route3_branch_ec3f5:
	volume_envelope 7, -5
	callchannel Music_Route3_branch_ec443
	note G_, 1
	note B_, 10
	volume_envelope 11, 7
	note B_, 6
	volume_envelope 7, -5
	note __, 4
	duty_cycle 3
	note G#, 4
	callchannel Music_Route3_branch_ec443
	note B_, 1
	volume_envelope 7, -5
	octave 5
	note D_, 5
	volume_envelope 11, 7
	octave 5
	note D_, 5
	duty_cycle 0
	octave 3
	note D_, 1
	note G_, 1
	note B_, 1
	note __, 1
	note G_, 1
	note B_, 1
	octave 4
	note D_, 4
	volume_envelope 8, -7
	duty_cycle 2
	octave 4
	note E_, 2
	note D_, 2
	note C#, 2
	octave 3
	note B_, 2
	octave 4
	note C#, 2
	octave 3
	note A_, 8
	note G#, 1
	note A_, 1
	note B_, 2
	note E_, 4
	octave 4
	note E_, 8
	note D_, 1
	note C#, 1
	note D_, 3
	note C#, 3
	octave 3
	note A_, 10
	duty_cycle 2
	octave 4
	note F#, 6
	note E_, 1
	note F#, 1
	note G#, 6
	note F#, 1
	note G#, 1
	jumpchannel Music_Route3_branch_ec3f5

Music_Route3_branch_ec443:
	note A_, 6
	note E_, 1
	note A_, 1
	octave 5
	note C#, 7
	volume_envelope 11, 7
	octave 5
	note C#, 3
	volume_envelope 7, -5
	octave 4
	note E_, 2
	note A_, 2
	octave 5
	note E_, 2
	note D_, 2
	note C#, 2
	octave 4
	note B_, 2
	note A_, 2
	note G_, 6
	note D_, 1
	endchannel

Music_Route3_Ch3:
	stereopanning $ff
	vibrato $6, $3
	note_type 12, 1, 3
	octave 3
	note B_, 1
	octave 4
	note D_, 1
	note E_, 6
	note D_, 1
	octave 3
	note B_, 1
	volume_envelope 1, 4
	octave 3
	note A_, 1
	note __, 1
	octave 2
	note A_, 2
	note __, 2
	note A_, 1
	note A_, 1
	note A_, 1
	note __, 1
	note A_, 1
	note __, 1
	note A_, 1
	note __, 1
	note G#, 2
	callchannel Music_Route3_branch_ec4bd
Music_Route3_branch_ec47f:
	volume_envelope 1, 4
	callchannel Music_Route3_branch_ec4bd
	callchannel Music_Route3_branch_ec4bd
	callchannel Music_Route3_branch_ec4ce
	callchannel Music_Route3_branch_ec4bd
	callchannel Music_Route3_branch_ec4bd
	callchannel Music_Route3_branch_ec4ce
	note A_, 2
	octave 3
	note C#, 2
	note E_, 2
	note A_, 6
	note G#, 2
	note F#, 2
	note E_, 2
	note D_, 2
	octave 2
	note B_, 2
	note G#, 2
	note E_, 1
	note __, 1
	note E_, 2
	note B_, 2
	octave 3
	note E_, 2
	note F_, 6
	note E_, 2
	note D_, 2
	octave 2
	note B_, 2
	octave 3
	note C_, 2
	note C#, 2
	note D_, 1
	note __, 1
	note D_, 2
	note __, 2
	note D_, 1
	note D_, 1
	note E_, 1
	note __, 1
	note E_, 2
	note __, 2
	note F#, 1
	note G#, 1
	jumpchannel Music_Route3_branch_ec47f

Music_Route3_branch_ec4bd:
	octave 3
	note A_, 1
	note __, 1
	octave 2
	note A_, 2
	note __, 2
	note A_, 1
	note A_, 1
	note A_, 1
	note __, 1
	note A_, 1
	note __, 1
	octave 3
	note A_, 2
	octave 2
	note G#, 2
	endchannel

Music_Route3_branch_ec4ce:
	octave 3
	note G_, 1
	note __, 1
	octave 2
	note A_, 2
	note __, 2
	note A_, 1
	note A_, 1
	note A_, 1
	note __, 1
	note A_, 1
	note __, 1
	octave 3
	note D_, 2
	note G_, 2
	note G_, 1
	note __, 1
	octave 2
	note G_, 2
	note __, 2
	note G_, 1
	note G_, 1
	note E_, 1
	note __, 1
	note E_, 1
	note __, 1
	note G#, 2
	note B_, 2
	endchannel

Music_Route3_Ch4:
	togglenoise $4
	note_type 12
	note __, 10
Music_Route3_branch_ec4f0:
	note_type 12
	note D_, 2
	note D_, 4
	note D_, 1
	note D_, 1
	note D_, 2
	note D_, 2
	note_type 6
	note C#, 1
	note C#, 1
	note C#, 1
	note C#, 1
	note C#, 1
	note C#, 1
	note C#, 1
	note C#, 1
	jumpchannel Music_Route3_branch_ec4f0
