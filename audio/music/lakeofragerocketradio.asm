Music_LakeOfRageRocketRadio:
	channel_count 3
	channel 1, Music_LakeOfRageRocketRadio_Ch1
	channel 2, Music_LakeOfRageRocketRadio_Ch2
	channel 3, Music_LakeOfRageRocketRadio_Ch3

Music_LakeOfRageRocketRadio_Ch1:
	tempo 160
	volume 7, 7
	duty_cycle 1
	tone $1118
	vibrato $0, $f0
	stereopanning $f0
Music_LakeOfRageRocketRadio_branch_ef5c9:
	note_type 12, 10, 7
	octave 7
	note G_, 4
	note F#, 4
	note G_, 4
	note F#, 4
	note __, 16
	jumpchannel Music_LakeOfRageRocketRadio_branch_ef5c9

Music_LakeOfRageRocketRadio_Ch2:
	duty_cycle 1
	vibrato $13, $e8
	note_type 12, 10, 7
	note __, 2
	stereopanning $f
	jumpchannel Music_LakeOfRageRocketRadio_branch_ef5c9

Music_LakeOfRageRocketRadio_Ch3:
	note_type 12, 2, 6
	vibrato $10, $44
	note __, 4
	jumpchannel Music_LakeOfRageRocketRadio_branch_ef5c9
