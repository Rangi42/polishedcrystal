Music_DragonsDen:
music_header
	channel_count 4
	channel 1, Music_DragonsDen_Ch1
	channel 2, Music_DragonsDen_Ch2
	channel 3, Music_DragonsDen_Ch3
	channel 4, Music_DragonsDen_Ch4

Music_DragonsDen_Ch1:
music_label
	tempo 144
	volume 7, 7
	duty_cycle 0
	pitch_offset 4
	stereo_panning TRUE, FALSE
	note_type 12, 8, 0
Music_DragonsDen_branch_eed03:
music_label
	sound_call Music_DragonsDen_branch_eed1e
	rest 16
	sound_call Music_DragonsDen_branch_eed2d
	rest 2
	sound_call Music_DragonsDen_branch_eed2d
	rest 2
	sound_call Music_DragonsDen_branch_eed2d
	rest 2
	sound_call Music_DragonsDen_branch_eed2d
	rest 10
	note_type 12, 11, 7
	sound_jump Music_DragonsDen_branch_eed03

Music_DragonsDen_branch_eed1e:
music_label
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
	sound_ret

Music_DragonsDen_branch_eed2d:
music_label
	volume_envelope 11, 1
	rest 2
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
	sound_ret

Music_DragonsDen_Ch2:
music_label
	duty_cycle 0
	pitch_offset 4
	stereo_panning FALSE, TRUE
	note_type 12, 9, 0
Music_DragonsDen_branch_eed46:
music_label
	sound_call Music_DragonsDen_branch_eed5e
	rest 16
	sound_call Music_DragonsDen_branch_eed6b
	sound_call Music_DragonsDen_branch_eed6b
	sound_call Music_DragonsDen_branch_eed6b
	sound_call Music_DragonsDen_branch_eed6b
	rest 16
	note_type 12, 12, 7
	sound_jump Music_DragonsDen_branch_eed46

Music_DragonsDen_branch_eed5e:
music_label
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
	sound_ret

Music_DragonsDen_branch_eed6b:
music_label
	volume_envelope 12, 1
Music_DragonsDen_branch_eed6d:
music_label
	octave 5
	note C#, 4
	octave 4
	note G#, 4
	note G#, 4
	note G#, 4
	sound_loop 2, Music_DragonsDen_branch_eed6d
	sound_ret

Music_DragonsDen_Ch3:
music_label
Music_DragonsDen_branch_eed78:
music_label
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
	sound_loop 15, Music_DragonsDen_branch_eed78
	rest 16
	note_type 6, 2, 7
Music_DragonsDen_branch_eed99:
music_label
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
	sound_loop 16, Music_DragonsDen_branch_eed99
	sound_jump Music_DragonsDen_branch_eed78

Music_DragonsDen_Ch4:
music_label
	toggle_noise 0
	drum_speed 12
	rest 16
	rest 16
Music_DragonsDen_branch_eedbd:
music_label
	stereo_panning TRUE, FALSE
	drum_note 6, 4
	stereo_panning FALSE, TRUE
	drum_note 7, 4
	drum_note 7, 4
	stereo_panning TRUE, FALSE
	drum_note 7, 4
	sound_jump Music_DragonsDen_branch_eedbd
