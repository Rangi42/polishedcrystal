Music_AfterTheRivalFight:
	channel_count 4
	channel 1, Music_AfterTheRivalFight_Ch1
	channel 2, Music_AfterTheRivalFight_Ch2
	channel 3, Music_AfterTheRivalFight_Ch3
	channel 4, Music_AfterTheRivalFight_Ch4

Music_AfterTheRivalFight_Ch1:
	tempo 112
	volume 7, 7
	duty_cycle 0
	tone $0001
	vibrato $8, $14
	stereopanning $f0
	note_type 12, 11, 2
	octave 2
	note G#, 4
	note G#, 4
	volume_envelope 8, 2
	octave 3
	note G#, 2
	note G#, 2
	note G#, 2
	note G#, 2
	jumpchannel Music_AfterTheRivalFight_branch_f4fb1

Music_AfterTheRivalFight_Ch2:
	duty_cycle 1
	vibrato $6, $35
	stereopanning $f
	note_type 12, 12, 2
	octave 4
	note G#, 4
	note G#, 4
	volume_envelope 10, 2
	note G#, 2
	note G#, 2
	note G#, 2
	note G#, 2
	jumpchannel Music_AfterTheRivalFight_branch_f502e

Music_AfterTheRivalFight_Ch3:
	note_type 12, 2, 8
	octave 3
	note D#, 2
	note __, 2
	note D#, 2
	note __, 2
	note G#, 2
	note F#, 2
	note F_, 2
	note D#, 2
	jumpchannel Music_AfterTheRivalFight_branch_f509d

Music_AfterTheRivalFight_Ch4:
	toggle_noise 3
	stereopanning $f
	note_type 12
	note D_, 4
	note D_, 4
	note D#, 2
	note D_, 2
	note D_, 2
	note D_, 2
	jumpchannel Music_AfterTheRivalFight_branch_f5118
