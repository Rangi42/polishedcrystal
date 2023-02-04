Music_DarkCave:
	channel_count 4
	channel 1, Music_DarkCave_Ch1
	channel 2, Music_DarkCave_Ch2
	channel 3, Music_DarkCave_Ch3
	channel 4, Music_DarkCave_Ch4

Music_DarkCave_Ch1:
	tempo 128
	volume 7, 7
	duty_cycle 3
	pitch_offset 1
	vibrato $11, $15
	stereo_panning TRUE, FALSE
	note_type 12, 10, 7
Music_DarkCave_branch_ea2dc:
	note __, 16
	loopchannel 4, Music_DarkCave_branch_ea2dc
	octave 3
	note D#, 16
	note D_, 16
	note C#, 16
	note C_, 16
	volume_envelope 10, 3
Music_DarkCave_branch_ea2e8:
	callchannel Music_DarkCave_branch_ea333
	loopchannel 3, Music_DarkCave_branch_ea2e8
	volume_envelope 11, 7
	note G#, 8
	note D#, 8
	note G_, 8
	note D_, 8
	note F_, 8
	note C#, 8
	note D#, 8
	note G_, 8
	note G#, 8
	note D#, 8
	note G_, 8
	note D_, 8
	note F_, 8
	note C#, 8
	note D#, 8
	note C_, 8
	volume_envelope 10, 3
Music_DarkCave_branch_ea303:
	callchannel Music_DarkCave_branch_ea333
	loopchannel 2, Music_DarkCave_branch_ea303
	note __, 16
	note __, 8
	volume_envelope 11, 7
	octave 2
	note F_, 2
	note G_, 2
	note G#, 4
	octave 3
	note D#, 16
	note __, 8
	octave 2
	note G#, 2
	note G_, 2
	note G#, 4
	octave 3
	note D#, 16
	note G_, 2
	note __, 6
	note F_, 2
	note G_, 2
	note G#, 4
	note G_, 16
	note F_, 2
	note __, 6
	note G#, 2
	note G_, 2
	note G#, 4
	volume_envelope 10, 3
Music_DarkCave_branch_ea328:
	callchannel Music_DarkCave_branch_ea333
	loopchannel 2, Music_DarkCave_branch_ea328
	sound_jump Music_DarkCave_branch_ea2e8

Music_DarkCave_branch_ea333:
	octave 4
	note D#, 2
	octave 3
	note G#, 2
	octave 4
	note C_, 2
	note D#, 2
	octave 3
	note G#, 2
	octave 4
	note C_, 2
	note D#, 2
	note C_, 2
	note D_, 2
	octave 3
	note G_, 2
	note A#, 2
	octave 4
	note D_, 2
	octave 3
	note G_, 2
	note A#, 2
	octave 4
	note D_, 2
	octave 3
	note A#, 2
	octave 4
	note C#, 2
	octave 3
	note F_, 2
	note A#, 2
	octave 4
	note C#, 2
	octave 3
	note F_, 2
	note A#, 2
	octave 4
	note C#, 2
	octave 3
	note A#, 2
	octave 4
	note C_, 2
	octave 3
	note G_, 2
	note A#, 2
	octave 4
	note C_, 2
	octave 3
	note G_, 2
	note A#, 2
	octave 4
	note C_, 2
	octave 3
	note A#, 2
	endchannel

Music_DarkCave_Ch2:
	duty_cycle 1
	vibrato $12, $36
	stereo_panning FALSE, TRUE
	note_type 12, 10, 7
Music_DarkCave_branch_ea374:
	note __, 16
	loopchannel 4, Music_DarkCave_branch_ea374
	octave 3
	note G_, 16
	note A#, 16
	note F_, 16
	note G_, 16
Music_DarkCave_branch_ea37e:
	note __, 16
	loopchannel 4, Music_DarkCave_branch_ea37e
	note __, 8
	stereo_panning TRUE, TRUE
	volume_envelope 12, 7
	octave 5
	note C_, 8
	volume_envelope 12, 4
	note D_, 2
	note C_, 2
	octave 4
	note A#, 2
	note G_, 4
	note A#, 2
	octave 5
	note D_, 4
	volume_envelope 11, 0
	note C#, 4
	volume_envelope 11, 7
	note C#, 12
	volume_envelope 5, -1
	note C_, 8
	volume_envelope 12, 7
	note C_, 8
	note __, 8
	volume_envelope 12, 7
	note C_, 8
	volume_envelope 12, 4
	note D_, 2
	note C_, 2
	octave 4
	note A#, 2
	note G_, 2
	note G_, 2
	note A#, 2
	octave 5
	note D_, 4
	volume_envelope 12, 7
	note C#, 12
	volume_envelope 12, 3
	note C_, 2
	note C#, 2
	volume_envelope 11, 0
	note D#, 10
	volume_envelope 11, 7
	note D#, 6
	stereo_panning FALSE, TRUE
	volume_envelope 12, 4
	octave 4
	note F_, 4
	note D#, 2
	note D_, 2
	note D#, 4
	note D_, 2
	note C_, 2
	note D_, 2
	note C_, 2
	octave 3
	note A#, 2
	octave 4
	note C_, 2
	note D_, 4
	note C_, 2
	octave 3
	note A#, 2
	octave 4
	note C#, 8
	octave 3
	note A#, 8
	volume_envelope 11, 0
	octave 4
	note D#, 2
	note D_, 2
	note C_, 2
	octave 3
	note A#, 2
	octave 4
	note C_, 8
	note F_, 4
	note D#, 2
	note D_, 2
	note D#, 4
	note D_, 2
	note C_, 2
	note D_, 2
	note C_, 2
	octave 3
	note A#, 2
	octave 4
	note C_, 2
	note D_, 4
	note C_, 2
	octave 3
	note A#, 2
	octave 4
	note C#, 4
	note C_, 2
	note C#, 2
	note C_, 2
	note C#, 2
	octave 3
	note A#, 2
	octave 4
	note C#, 2
	volume_envelope 11, 0
	note C_, 8
	volume_envelope 11, 7
	note C_, 8
	volume_envelope 12, 7
	stereo_panning TRUE, TRUE
	note __, 8
	octave 5
	note C_, 8
	volume_envelope 12, 4
	note D_, 2
	note C_, 2
	octave 4
	note A#, 2
	note G_, 4
	note A#, 2
	octave 5
	note D_, 4
	volume_envelope 4, -1
	note C#, 8
	volume_envelope 12, 7
	note C#, 8
	volume_envelope 11, 0
	note C_, 8
	volume_envelope 11, 7
	note C_, 8
	note __, 8
	volume_envelope 12, 7
	note C_, 8
	volume_envelope 12, 4
	note D_, 2
	note C_, 2
	octave 4
	note A#, 2
	note G_, 2
	note G_, 2
	note A#, 2
	octave 5
	note D_, 4
	volume_envelope 11, 0
	note C#, 8
	volume_envelope 11, 7
	note C#, 8
	volume_envelope 11, 0
	note C_, 8
	volume_envelope 11, 7
	note C_, 8
	volume_envelope 12, 7
	note __, 16
	stereo_panning FALSE, TRUE
	note __, 8
	octave 3
	note A#, 2
	octave 4
	note C_, 2
	note C#, 4
	note C_, 16
	note __, 8
	note C#, 2
	note C_, 2
	note C#, 4
	note C_, 16
	volume_envelope 12, 2
	note D#, 8
	volume_envelope 12, 7
	octave 3
	note A#, 2
	octave 4
	note C_, 2
	note C#, 4
	note C_, 16
	volume_envelope 12, 2
	octave 3
	note A#, 8
	volume_envelope 12, 7
	octave 4
	note C#, 2
	note C_, 2
	volume_envelope 12, 4
	note C#, 16
	note __, 4
	note __, 16
	note __, 16
	note __, 16
	volume_envelope 11, 7
	octave 5
	note D#, 16
	note D_, 16
	note F_, 16
	note D#, 16
	sound_jump Music_DarkCave_branch_ea37e

Music_DarkCave_Ch3:
	note_type 12, 2, 7
Music_DarkCave_branch_ea471:
	callchannel Music_DarkCave_branch_ea4ce
	loopchannel 2, Music_DarkCave_branch_ea471
Music_DarkCave_branch_ea478:
	callchannel Music_DarkCave_branch_ea4ce
	loopchannel 7, Music_DarkCave_branch_ea478
	callchannel Music_DarkCave_branch_ea4c3
	octave 3
	note C_, 4
	note G_, 2
	note D#, 4
	note G_, 2
	note D#, 4
	note F_, 2
	note __, 2
	octave 2
	note A#, 12
	callchannel Music_DarkCave_branch_ea4c3
	octave 3
	note C_, 4
	note G_, 2
	note D#, 4
	note G_, 2
	note D#, 4
	note F_, 2
	note __, 2
	octave 2
	note A#, 4
	octave 3
	note C#, 2
	note C_, 2
	note C#, 4
	callchannel Music_DarkCave_branch_ea4a7
	callchannel Music_DarkCave_branch_ea4a7
	sound_jump Music_DarkCave_branch_ea478

Music_DarkCave_branch_ea4a7:
	octave 3
	note C_, 4
	note G_, 2
	note D#, 4
	note G_, 2
	note F_, 4
	note D#, 2
	note __, 2
	octave 2
	note A#, 4
	note A#, 2
	octave 3
	note C_, 2
	note C#, 4
	note C_, 4
	note G_, 2
	note D#, 4
	note G_, 2
	note D#, 4
	note F_, 2
	note __, 2
	octave 2
	note A#, 4
	octave 3
	note C#, 2
	note C_, 2
	note C#, 4
	endchannel

Music_DarkCave_branch_ea4c3:
	octave 3
	note C_, 4
	note G_, 2
	note D#, 4
	note G_, 2
	note F_, 4
	note D#, 2
	note __, 2
	octave 2
	note A#, 12
	endchannel

Music_DarkCave_branch_ea4ce:
	octave 2
	note C_, 4
	note G_, 2
	note D#, 4
	note G_, 2
	note F_, 4
	note D#, 2
	note __, 2
	octave 1
	note A#, 4
	note A#, 2
	octave 2
	note C_, 2
	note C#, 4
	note C_, 4
	note G_, 2
	note D#, 4
	note G_, 2
	note D#, 4
	note F_, 2
	note __, 2
	octave 1
	note A#, 4
	octave 2
	note C#, 2
	note C_, 2
	note C#, 4
	endchannel

Music_DarkCave_Ch4:
	toggle_noise 3
	note_type 12
Music_DarkCave_branch_ea4ee:
	stereo_panning TRUE, TRUE
	note D#, 8
	note D#, 8
	note D#, 4
	stereo_panning TRUE, FALSE
	note C#, 4
	stereo_panning FALSE, TRUE
	note C#, 2
	note C#, 2
	stereo_panning TRUE, FALSE
	note C#, 4
	stereo_panning TRUE, TRUE
	note D#, 8
	note D#, 8
	note D#, 4
	stereo_panning FALSE, TRUE
	note C#, 8
	stereo_panning TRUE, FALSE
	note C#, 2
	note C#, 2
	sound_jump Music_DarkCave_branch_ea4ee
