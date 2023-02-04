Music_Route37:
	channel_count 4
	channel 1, Music_Route37_Ch1
	channel 2, Music_Route37_Ch2
	channel 3, Music_Route37_Ch3
	channel 4, Music_Route37_Ch4

Music_Route37_Ch1:
	tempo 144
	volume 7, 7
	duty_cycle 3
	tone $0002
	vibrato $10, $22
	note_type 12, 11, 3
	note __, 16
	note __, 16
Music_Route37_branch_ee969:
	volume_envelope 11, 3
	note __, 2
	octave 2
	note F#, 2
	note B_, 2
	octave 3
	note E_, 2
	volume_envelope 11, 7
	note D#, 10
	volume_envelope 11, 3
	note E_, 4
	note D#, 4
	note C#, 4
	octave 2
	note B_, 2
	octave 3
	note D#, 3
	octave 2
	note B_, 1
	volume_envelope 11, 7
	note F#, 8
	note B_, 8
	octave 3
	note B_, 12
	volume_envelope 11, 3
	note __, 2
	octave 2
	note F#, 2
	note B_, 2
	octave 3
	note E_, 2
	volume_envelope 11, 7
	note D#, 10
	octave 2
	note A_, 4
	octave 3
	note C#, 4
	note E_, 4
	note A_, 2
	note F#, 3
	note A_, 1
	note B_, 6
	octave 2
	note B_, 2
	octave 3
	note D#, 2
	note F#, 2
	note B_, 2
	note A_, 4
	note F#, 4
	note E_, 2
	note D#, 4
	stereopanning $f
Music_Route37_branch_ee9a5:
	callchannel Music_Route37_branch_ee9da
	octave 3
	note C#, 4
	loopchannel 2, Music_Route37_branch_ee9a5
	callchannel Music_Route37_branch_ee9e9
	octave 3
	note F#, 4
	callchannel Music_Route37_branch_ee9e9
	octave 3
	note F#, 4
	callchannel Music_Route37_branch_ee9da
	octave 3
	note E_, 4
	callchannel Music_Route37_branch_ee9da
	octave 3
	note G#, 4
	callchannel Music_Route37_branch_ee9e9
	octave 4
	note D#, 4
	callchannel Music_Route37_branch_ee9e9
	octave 3
	note F_, 4
	stereopanning $ff
	callchannel Music_Route37_branch_ee9e9
	note __, 4
	callchannel Music_Route37_branch_ee9e9
	note __, 4
	jumpchannel Music_Route37_branch_ee969

Music_Route37_branch_ee9da:
	volume_envelope 12, 2
	octave 2
	note A_, 2
	note A_, 1
	note A_, 1
	note A_, 2
	note A_, 1
	note A_, 1
	note A_, 1
	note A_, 1
	note A_, 2
	volume_envelope 11, 7
	endchannel

Music_Route37_branch_ee9e9:
	volume_envelope 12, 2
	octave 2
	note B_, 2
	note B_, 1
	note B_, 1
	note B_, 2
	note B_, 1
	note B_, 1
	note B_, 1
	note B_, 1
	note B_, 2
	volume_envelope 11, 7
	endchannel

Music_Route37_Ch2:
	duty_cycle 3
	vibrato $1c, $12
	note_type 12, 12, 2
	octave 2
	note B_, 2
	note_type 12, 12, 1
	note B_, 1
	note B_, 1
	volume_envelope 12, 2
	note B_, 2
	volume_envelope 12, 1
	note B_, 1
	note B_, 1
	note B_, 1
	note B_, 1
	volume_envelope 12, 2
	note B_, 6
	note B_, 2
	volume_envelope 12, 1
	note B_, 1
	note B_, 1
	volume_envelope 12, 2
	note B_, 2
	volume_envelope 12, 1
	note B_, 1
	note B_, 1
	note B_, 1
	note B_, 1
	volume_envelope 12, 2
	note B_, 2
Music_Route37_branch_eea24:
	callchannel Music_Route37_branch_eeab7
	volume_envelope 12, 6
	octave 4
	note C#, 4
	octave 3
	note B_, 4
	note A_, 4
	note E_, 4
	volume_envelope 11, 0
	note F#, 8
	volume_envelope 11, 7
	note F#, 8
	volume_envelope 12, 7
	note D#, 12
	callchannel Music_Route37_branch_eeab7
	volume_envelope 12, 7
	octave 4
	note C#, 4
	octave 3
	note B_, 4
	octave 4
	note C#, 4
	note E_, 4
	volume_envelope 11, 0
	note D#, 16
	volume_envelope 11, 0
	note D#, 8
	volume_envelope 11, 7
	note D#, 8
	volume_envelope 12, 4
	note __, 4
	octave 3
	note A_, 3
	octave 4
	note E_, 1
	note A_, 4
	note G#, 4
	volume_envelope 10, 0
	note C#, 6
	note D#, 6
	note E_, 4
	volume_envelope 12, 3
	note F#, 3
	note E_, 1
	volume_envelope 11, 0
	note D#, 6
	volume_envelope 11, 7
	note D#, 6
	volume_envelope 12, 3
	octave 3
	note B_, 3
	note F#, 1
	volume_envelope 11, 0
	octave 4
	note D#, 6
	volume_envelope 11, 7
	octave 4
	note D#, 6
	volume_envelope 12, 4
	note __, 4
	octave 3
	note A_, 3
	octave 4
	note E_, 1
	note A_, 4
	note G#, 4
	volume_envelope 11, 0
	note C#, 6
	note D#, 6
	note E_, 4
	volume_envelope 12, 3
	note F#, 3
	note D#, 1
	volume_envelope 11, 0
	note B_, 6
	volume_envelope 11, 7
	note B_, 6
	volume_envelope 12, 3
	note B_, 3
	note F#, 1
	volume_envelope 11, 0
	octave 5
	note D#, 6
	volume_envelope 11, 7
	octave 5
	note D#, 6
	volume_envelope 12, 2
	octave 3
	note F#, 2
	note F#, 1
	note F#, 1
	note F#, 2
	volume_envelope 12, 1
	note F#, 1
	note F#, 1
	note F#, 1
	note F#, 1
	volume_envelope 12, 2
	note F#, 6
	note F#, 2
	note F#, 1
	note F#, 1
	note F#, 2
	volume_envelope 12, 1
	note F#, 1
	note F#, 1
	note F#, 1
	note F#, 1
	volume_envelope 12, 2
	note F#, 2
	jumpchannel Music_Route37_branch_eea24

Music_Route37_branch_eeab7:
	volume_envelope 12, 7
	octave 3
	note F#, 4
	volume_envelope 11, 0
	note B_, 5
	volume_envelope 11, 7
	note B_, 5
	volume_envelope 12, 3
	note F#, 2
	note F#, 2
	note B_, 2
	endchannel

Music_Route37_Ch3:
	stereopanning $f0
	note_type 12, 1, 4
Music_Route37_branch_eeacc:
	octave 2
	note F#, 2
	note __, 6
	loopchannel 4, Music_Route37_branch_eeacc
Music_Route37_branch_eead3:
	callchannel Music_Route37_branch_eeb32
	note A_, 2
	octave 3
	note C#, 2
	octave 2
	note G#, 2
	note B_, 2
	note F#, 2
	note A_, 2
	note F#, 2
	note E_, 2
Music_Route37_branch_eeae0:
	note D#, 2
	note F#, 2
	loopchannel 4, Music_Route37_branch_eeae0
	callchannel Music_Route37_branch_eeb32
	callchannel Music_Route37_branch_eeb32
	note A_, 2
	octave 3
	note C#, 2
	octave 2
	note G#, 2
	note B_, 2
	note F#, 2
	note A_, 2
	octave 3
	note C#, 2
	octave 2
	note A_, 2
	callchannel Music_Route37_branch_eeb32
Music_Route37_branch_eeafb:
	octave 2
	note B_, 2
	octave 3
	note D#, 2
	loopchannel 4, Music_Route37_branch_eeafb
Music_Route37_branch_eeb03:
	octave 2
	note A_, 2
	octave 3
	note C#, 2
	loopchannel 7, Music_Route37_branch_eeb03
	note E_, 2
	note C#, 2
	callchannel Music_Route37_branch_eeb3c
Music_Route37_branch_eeb10:
	octave 2
	note B_, 2
	octave 3
	note F#, 2
	loopchannel 4, Music_Route37_branch_eeb10
Music_Route37_branch_eeb18:
	octave 2
	note A_, 2
	octave 3
	note C#, 2
	loopchannel 7, Music_Route37_branch_eeb18
	note E_, 2
	note C#, 2
	callchannel Music_Route37_branch_eeb3c
	callchannel Music_Route37_branch_eeb32
Music_Route37_branch_eeb28:
	note F#, 2
	note __, 6
	loopchannel 4, Music_Route37_branch_eeb28
	jumpchannel Music_Route37_branch_eead3

Music_Route37_branch_eeb32:
	octave 2
	note F#, 2
	note B_, 2
	note F#, 2
	note B_, 2
	note F#, 2
	note B_, 2
	note F#, 2
	note B_, 2
	endchannel

Music_Route37_branch_eeb3c:
	octave 2
	note B_, 2
	octave 3
	note D#, 2
	octave 2
	note B_, 2
	octave 3
	note D#, 2
	octave 2
	note B_, 2
	octave 3
	note D#, 2
	octave 2
	note B_, 2
	octave 3
	note D#, 2
	endchannel

Music_Route37_Ch4:
	stereopanning $f
	toggle_noise 0
Music_Route37_branch_eeb51:
	note_type 12
	callchannel Music_Route37_branch_eeb6b
	note D_, 1
	note D#, 1
	note D#, 1
	note D_, 1
	callchannel Music_Route37_branch_eeb6b
	note_type 6
	note D#, 1
	note D#, 1
	note D#, 1
	note D#, 1
	note D#, 1
	note D_, 1
	note D_, 1
	note D_, 1
	jumpchannel Music_Route37_branch_eeb51

Music_Route37_branch_eeb6b:
	note D_, 2
	note D#, 1
	note D#, 1
	note D_, 2
	note D#, 1
	note D#, 1
	note D_, 2
	note D#, 1
	note D#, 1
	endchannel
