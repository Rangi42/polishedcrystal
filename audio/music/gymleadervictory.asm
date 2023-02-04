Music_GymLeaderVictory:
	channel_count 4
	channel 1, Music_GymLeaderVictory_Ch1
	channel 2, Music_GymLeaderVictory_Ch2
	channel 3, Music_GymLeaderVictory_Ch3
	channel 4, Music_GymLeaderVictory_Ch4

Music_GymLeaderVictory_Ch1:
	tempo 116
	volume 7, 7
	vibrato $12, $34
	duty_cycle 3
	tone $0001
	note_type 12, 11, 7
	octave 4
	note D_, 6
	octave 3
	note A_, 1
	octave 4
	note D_, 1
	note F#, 6
	note D_, 1
	note F#, 1
	note A_, 6
	note F#, 1
	note A_, 1
	octave 5
	note D_, 8
	stereo_panning FALSE, TRUE
Music_GymLeaderVictory_branch_f4658:
	duty_cycle 1
	callchannel Music_GymLeaderVictory_branch_f4689
	octave 4
	note C#, 4
	note E_, 4
	callchannel Music_GymLeaderVictory_branch_f4689
	note F#, 8
	loopchannel 2, Music_GymLeaderVictory_branch_f4658
	duty_cycle 2
	callchannel Music_GymLeaderVictory_branch_f46a0
	note A_, 4
	note G_, 4
	note F#, 6
	note D_, 1
	note E_, 1
	note F#, 6
	note E_, 2
	note D_, 8
	note C#, 8
	duty_cycle 3
	callchannel Music_GymLeaderVictory_branch_f46a0
	note C#, 4
	note E_, 4
	note G_, 6
	note A_, 1
	note G_, 1
	note A_, 6
	note G_, 2
	volume_envelope 8, 7
	note F#, 16
	jumpchannel Music_GymLeaderVictory_branch_f4658

Music_GymLeaderVictory_branch_f4689:
	volume_envelope 9, 1
	octave 3
	note F#, 2
	note A_, 2
	octave 4
	note D_, 2
	octave 3
	note A_, 1
	note F#, 1
	note E_, 2
	note A_, 2
	octave 4
	note C#, 2
	octave 3
	note A_, 1
	note E_, 1
	note D_, 2
	note G_, 2
	note B_, 2
	note G_, 1
	note D_, 1
	endchannel

Music_GymLeaderVictory_branch_f46a0:
	volume_envelope 8, 7
	octave 3
	note F#, 14
	note D_, 1
	note F#, 1
	note A_, 8
	note F#, 4
	note A_, 1
	note G#, 1
	note F#, 1
	note A_, 1
	note G#, 14
	note E_, 1
	note G#, 1
	note B_, 8
	octave 4
	note D_, 4
	note E_, 1
	note D_, 1
	note E_, 1
	note D_, 1
	note C#, 14
	octave 3
	note A_, 1
	octave 4
	note C#, 1
	note E_, 8
	endchannel

Music_GymLeaderVictory_Ch2:
	vibrato $12, $34
	duty_cycle 3
	note_type 12, 13, 7
	octave 4
	note A_, 6
	note F#, 1
	note A_, 1
	octave 5
	note D_, 6
	octave 4
	note A_, 1
	octave 5
	note D_, 1
	note F#, 16
Music_GymLeaderVictory_branch_f46d0:
	duty_cycle 3
	volume_envelope 10, 1
	callchannel Music_GymLeaderVictory_branch_f4711
	note A_, 4
	note A_, 4
	callchannel Music_GymLeaderVictory_branch_f4711
	note D_, 6
	duty_cycle 2
	note B_, 1
	octave 5
	note C#, 1
	callchannel Music_GymLeaderVictory_branch_f4711
	note A_, 4
	note A_, 4
	callchannel Music_GymLeaderVictory_branch_f4711
	note D_, 8
	duty_cycle 3
	callchannel Music_GymLeaderVictory_branch_f4720
	note F#, 4
	note E_, 4
	note D_, 14
	octave 4
	note B_, 2
	volume_envelope 10, 7
	note A_, 16
	duty_cycle 2
	callchannel Music_GymLeaderVictory_branch_f4720
	octave 4
	note A_, 4
	octave 5
	note C#, 4
	note D_, 14
	note E_, 2
	volume_envelope 10, 6
	note D_, 12
	note __, 2
	duty_cycle 3
	octave 4
	note B_, 1
	octave 5
	note C#, 1
	jumpchannel Music_GymLeaderVictory_branch_f46d0

Music_GymLeaderVictory_branch_f4711:
	octave 5
	note D_, 2
	note C#, 2
	octave 4
	note B_, 4
	octave 5
	note C#, 2
	octave 4
	note B_, 2
	note A_, 4
	note B_, 2
	note A_, 2
	note G_, 2
	note F#, 2
	endchannel

Music_GymLeaderVictory_branch_f4720:
	volume_envelope 9, 8
	note A_, 6
	note F#, 1
	note A_, 1
	octave 5
	note D_, 8
	note D_, 16
	octave 4
	note B_, 6
	note G#, 1
	note B_, 1
	octave 5
	note E_, 8
	note E_, 16
	octave 4
	note G_, 6
	note E_, 1
	note G_, 1
	octave 5
	note C#, 8
	note C#, 8
	endchannel

Music_GymLeaderVictory_Ch3:
	note_type 12, 2, 5
	octave 3
	note F#, 16
	note D_, 10
	octave 2
	note A_, 2
	note B_, 2
	octave 3
	note C#, 2
	stereo_panning TRUE, FALSE
Music_GymLeaderVictory_branch_f4744:
	note D_, 2
	note __, 4
	octave 2
	note A_, 2
	octave 3
	note C#, 2
	note __, 4
	octave 2
	note A_, 2
	note B_, 2
	note __, 4
	note G_, 2
	note A_, 2
	note __, 2
	octave 3
	note C#, 4
	note D_, 2
	note __, 4
	octave 2
	note A_, 2
	octave 3
	note C#, 2
	note __, 4
	octave 2
	note A_, 2
	note B_, 2
	note __, 4
	note G_, 2
	octave 3
	note D_, 2
	note __, 6
	loopchannel 2, Music_GymLeaderVictory_branch_f4744
	callchannel Music_GymLeaderVictory_branch_f479e
	octave 3
	note D_, 2
	note __, 2
	note D_, 2
	octave 4
	note D_, 2
	note __, 2
	octave 3
	note D_, 2
	note F#, 2
	note D_, 2
	note A_, 2
	note __, 2
	octave 2
	note A_, 2
	octave 3
	note E_, 2
	note __, 2
	octave 2
	note A_, 2
	octave 3
	note C#, 2
	octave 2
	note A_, 2
	callchannel Music_GymLeaderVictory_branch_f479e
	octave 3
	note D_, 2
	note __, 2
	note G_, 2
	octave 4
	note D_, 2
	note __, 2
	octave 3
	note D_, 2
	note G_, 2
	note E_, 2
	note D_, 2
	note __, 2
	note D_, 2
	note A_, 2
	note __, 2
	octave 2
	note A_, 2
	note B_, 2
	octave 3
	note C#, 2
	jumpchannel Music_GymLeaderVictory_branch_f4744

Music_GymLeaderVictory_branch_f479e:
	octave 3
	note D_, 2
	note __, 2
	note D_, 2
	octave 4
	note D_, 2
	note __, 2
	octave 3
	note D_, 2
	note F#, 2
	note D_, 2
	note A_, 2
	note __, 2
	note D_, 2
	note F#, 2
	note __, 2
	octave 2
	note A_, 2
	octave 3
	note D_, 2
	octave 2
	note A_, 2
	octave 3
	note E_, 2
	note __, 2
	note E_, 2
	octave 4
	note E_, 2
	note __, 2
	octave 3
	note E_, 2
	note G#, 2
	note E_, 2
	note B_, 2
	note __, 2
	note E_, 2
	note G#, 2
	note __, 2
	octave 2
	note B_, 2
	octave 3
	note E_, 2
	octave 2
	note B_, 2
	note A_, 2
	note __, 2
	note A_, 2
	octave 3
	note A_, 2
	note __, 2
	octave 2
	note A_, 2
	octave 3
	note C#, 2
	octave 2
	note A_, 2
	octave 3
	note A_, 2
	note __, 2
	octave 2
	note A_, 2
	octave 3
	note E_, 2
	note __, 2
	octave 2
	note A_, 2
	octave 3
	note C#, 2
	octave 2
	note A_, 2
	endchannel

Music_GymLeaderVictory_Ch4:
	toggle_noise 4
	note_type 12
	note B_, 16
	note B_, 16
Music_GymLeaderVictory_branch_f47eb:
	callchannel Music_GymLeaderVictory_branch_f480b
	note D#, 6
	note D#, 2
	note D#, 8
	callchannel Music_GymLeaderVictory_branch_f480b
	note D#, 6
	note D#, 2
	note D#, 4
	note C#, 1
	note C#, 1
	note C#, 1
	note C#, 1
Music_GymLeaderVictory_branch_f47fb:
	note D#, 2
	note G_, 2
	note D_, 2
	note D#, 2
	note G_, 2
	note D#, 2
	note D_, 2
	note G_, 2
	loopchannel 16, Music_GymLeaderVictory_branch_f47fb
	jumpchannel Music_GymLeaderVictory_branch_f47eb

Music_GymLeaderVictory_branch_f480b:
	note D#, 6
	note D#, 2
	note D#, 4
	note D_, 2
	note D#, 2
	loopchannel 3, Music_GymLeaderVictory_branch_f480b
	endchannel
